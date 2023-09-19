Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61D87A5CCA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 10:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbjISImU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 04:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjISImS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 04:42:18 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDEA0E6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 01:41:50 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c571029a36so1995415ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 01:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1695112910; x=1695717710; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ggAs6Jvrg7jU8HHW9+5HqI0MNBzi15nZzeXnKWoG/oI=;
        b=Ht39K05h/iJKBbR9NojOtjPLgLEoKNVLEEGSTSl/5jHD2o7xCmVqKi2S6XNts3/SDx
         cA/gllPQ5ZTkbJTOVjh3zJQpOCo6QL1MvPF4xEmTxieeXTZV5qIRajf0KCwMxzynh9OG
         pUGFEtlfy3BmEXLveECrBX+LmRgVd/Ki7+Z4AR/uyhLiH6jpY0YwO1F8GnnEFfhjBYj4
         0JG4d5fxr1ypkpvIw97hjhsHNmgSET8lqEKl7rCyCFtvNcQ1+r/gf00zL4EHjfcr3D3B
         KxNsak9G/ZnHxV1dlNqGieZYX4fDoVc3W2hyAO6t9iUllOQD5kStdq1aOddgG/x0QupX
         iXtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695112910; x=1695717710;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ggAs6Jvrg7jU8HHW9+5HqI0MNBzi15nZzeXnKWoG/oI=;
        b=e/16fl2iL76e385Ca2gyUTF133hndBK0fjGGqEG5KTkMIlQIVpRmKcOLEmDAnTBltB
         l8mm6Zxd4+RMMoEkM7Az33JBFQjUiuO8TDI8Jqen/ZnPy+1jp8syit9aS6yeVQSAPcne
         GYBqc+e6inYL2bGq6/8sl+sBLk6S2TdbNlvnnIM0lsQwc4lbu+7m2nHcPAOzOtJzreo/
         uT+VCOelekWefeg0HkUyBKIDoDd4NzhE81YrSBeSpz4Z9PHB6wK+Bo9JAM8JVL1qhp4T
         lAvSjEy5JExNHLYchOr97Xz7elHLNZEGt56OSsrhqKuqHyNXdt7uYMBxadY05Rjjg8DB
         hGDw==
X-Gm-Message-State: AOJu0YzBFVMmTwkGhEG8MPMnxnw7+KtjW6o/vDQwnaS5UebgJctzcQns
        oco563CC7psYG2BG4wa1+w41kg==
X-Google-Smtp-Source: AGHT+IFeKBHpGu+FNgHJxwAzj0C8DCtc24wynefQJapGswFQmiRq7dfwK8DJKrHzW2eWDYH9DCRz4Q==
X-Received: by 2002:a17:90a:1787:b0:26d:412d:9ce8 with SMTP id q7-20020a17090a178700b0026d412d9ce8mr10457879pja.0.1695112910342;
        Tue, 19 Sep 2023 01:41:50 -0700 (PDT)
Received: from [10.84.155.178] ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id 12-20020a17090a1a0c00b0026b0b4ed7b1sm10909229pjk.15.2023.09.19.01.41.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 01:41:49 -0700 (PDT)
Message-ID: <91d5e4e4-89e5-818e-8239-b7558f6349c4@bytedance.com>
Date:   Tue, 19 Sep 2023 16:41:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] mm: shrinker: some cleanup
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     akpm@linux-foundation.org, muchun.song@linux.dev,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, Muchun Song <songmuchun@bytedance.com>
References: <20230911094444.68966-2-zhengqi.arch@bytedance.com>
 <20230919024607.65463-1-zhengqi.arch@bytedance.com>
 <2023091937-claw-denote-8945@gregkh>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <2023091937-claw-denote-8945@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 2023/9/19 16:04, Greg KH wrote:
> On Tue, Sep 19, 2023 at 10:46:07AM +0800, Qi Zheng wrote:
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
>> ---
>> Hi Andrew, this is a cleanup patch for [PATCH v6 01/45], there will be a
>> small conflict with [PATCH v6 41/45].
> 
> I know I can't take patches without any changelog text, but maybe other
> maintainers are more lax.

This patch will be folded into one patch with [PATCH v6 01/45] and will
not enter the mainline as a separate patch, so I was too lazy to write
the commit message.

Anyway, I'll keep your words in mind next time.

Thanks,
Qi

> 
> thanks,
> 
> greg k-h

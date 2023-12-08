Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD008098FC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 03:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1572984AbjLHCFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 21:05:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1572949AbjLHCFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 21:05:34 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B4F121;
        Thu,  7 Dec 2023 18:05:40 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6cea2a38b48so1229260b3a.3;
        Thu, 07 Dec 2023 18:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702001140; x=1702605940; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5p96aV1jD/kmwOXUo+oTVCU+80IQN61LG9xj68A9h98=;
        b=RSVFGHiWw2GWaqTVcc5XneW0/RGugvagjAkUDAiY3rELN3MxWsAl1xtmGVINbgPfcT
         q5nWqixM0kKJc4kbKvjfzVEd1NlHSrbmflxvzFQGho3GSMSM7/bkSg4QOaNQqXbTZOOt
         j2Oun9z+HQFtoUKHwJSENh6IuzRfvcstP10VBwYJLVmAQvHvTraOihxbfeGRGkYrlKS3
         ysxmc0zWXCmNKFFU2b7B/tq5nHRSYmLVQzGERd1t74PVthwimgN+mPJCaE7waEdHjV8B
         ln7HH4OyAwntU/bUyqXToyigFp0drxhgAJTbvjBCVwQylh8wy0TuBsr3fk3Qryr1QKqQ
         eX1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702001140; x=1702605940;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5p96aV1jD/kmwOXUo+oTVCU+80IQN61LG9xj68A9h98=;
        b=ftdzebXFyIZkxIj2Yt9FoO6mGH3J2ElxX+XDbbLzruwomWjFJ1OP9/G9nqVL236Bqx
         DUMdRtvhIn9P6Y53OiTmpkknt3P3e31WhwEXM9YoEHTLe2YkocH7/2xpsyI4WX84reia
         ueh53ZvyCfhdvYauhofY1pDIu1NMlII4H5+neVxz7nTJYt/4pa7xGteTeMejsVr139YQ
         ueEh1NyzVDQNK/7fzfS9V2HJymfOD3e95k+W2OISwCwdkXr0un+uZGgYjRW3KEUt/WSM
         6f2gkcwHyktei7AkkwGPCl2k7IHqps7k/Jy1LiLa+dEL+rtsjc8yOB6/4QLFJc64ooUj
         eSlA==
X-Gm-Message-State: AOJu0Yy1A0wZry9mdzA9UplZos3V6ggYsrcHs4M/i3tTpRYcs5zH/kuc
        BsD4yqMaj790DO0OX+GfjKs=
X-Google-Smtp-Source: AGHT+IFMmgiD674YTc4A3jEartJ8gR3NDksSfuREBAIVu8xW2/AiH4VD9wzfTunJJW0wRT/TRMKLJQ==
X-Received: by 2002:a05:6a20:cea7:b0:187:5a4d:7061 with SMTP id if39-20020a056a20cea700b001875a4d7061mr3543631pzb.44.1702001140334;
        Thu, 07 Dec 2023 18:05:40 -0800 (PST)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id bv190-20020a632ec7000000b005c2967852c5sm448219pgb.30.2023.12.07.18.05.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 18:05:39 -0800 (PST)
Message-ID: <f6fc246f-4f57-4340-a967-396047e2924d@gmail.com>
Date:   Fri, 8 Dec 2023 09:05:33 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: md raid6 oops in 6.6.4 stable
Content-Language: en-US
To:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Genes Lists <lists@sapience.com>, snitzer@kernel.org,
        song@kernel.org, yukuai3@huawei.com, axboe@kernel.dk,
        mpatocka@redhat.com, heinzm@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux RAID <linux-raid@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>
Cc:     Bhanu Victor DiCara <00bvd0+linux@gmail.com>,
        Xiao Ni <xni@redhat.com>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <6e6816dd-2ec5-4bca-9558-60cfde46ef8c@sapience.com>
 <ZXHJEkwIJ5zKTMjV@archie.me>
 <e2d47b6c-3420-4785-8e04-e5f217d09a46@leemhuis.info>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <e2d47b6c-3420-4785-8e04-e5f217d09a46@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/23 20:58, Thorsten Leemhuis wrote:
> On 07.12.23 14:30, Bagas Sanjaya wrote:
>> On Thu, Dec 07, 2023 at 08:10:04AM -0500, Genes Lists wrote:
>>> I have not had chance to git bisect this but since it happened in stable I
>>> thought it was important to share sooner than later.
>>>
>>> One possibly relevant commit between 6.6.3 and 6.6.4 could be:
>>>
>>>   commit 2c975b0b8b11f1ffb1ed538609e2c89d8abf800e
>>>   Author: Song Liu <song@kernel.org>
>>>   Date:   Fri Nov 17 15:56:30 2023 -0800
>>>
>>>     md: fix bi_status reporting in md_end_clone_io
>>>
>>> log attached shows page_fault_oops.
>>> Machine was up for 3 days before crash happened.
>>
>> Can you confirm that culprit by bisection?
> 
> Bagas, I know you are trying to help, but sorry, I'd say this is not
> helpful at all -- any maybe even harmful.
> 
> From the quoted texts it's pretty clear that the reporter knows that a
> bisection would be helpful, but currently is unable to perform one --
> and even states reasons for reporting it without having it bisected. So
> your message afaics doesn't bring anything new to the table; and I might
> be wrong with that, but I fear some people in a situation like this
> might even be offended by a reply like that, as it states something
> already obvious.
> 

Oops, I didn't fully understand the context. Thanks anyway.

-- 
An old man doll... just what I always wanted! - Clara


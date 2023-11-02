Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75BB57DF3D4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 14:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376540AbjKBNbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 09:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234984AbjKBNbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 09:31:22 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71F819D
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 06:31:19 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-5b92b852390so710266a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 06:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698931879; x=1699536679; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TOkLeZ1O4q/pINlkEKARqNQtmFQ8WPpDSAmLPInWj7A=;
        b=YK0ZQAhyux2rezDHcNwHTSZMAJoz+2mN/36FZBjdKEuvKLqmP7uQc3Kju+F6YxOnyy
         r4al0vCFbZ4W2fLPC0gZclxtoEQ1f+XVD/hsPXoZRIc6qZPXn5aOH6m4PpGRa75oASh1
         BlhdYKzCrc2HYQ/wquyZbbzo+8sw5Zyn1t9EGfRxv5oj2SSejK/8289GtzlHVlxJr1oO
         RCVfECSCTWn1xbcxkfVSBl4/nJJykHnrj+Z0H3VgHMMD+tWFcpLeMveT16HPS1kPl9RV
         me6jFfH+Uurks2/Vc1wyIoSmhKH5kvxpGEtlFCkhwyYB7GjwajAxO4/65ZzkBJFjmD1i
         lxBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698931879; x=1699536679;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TOkLeZ1O4q/pINlkEKARqNQtmFQ8WPpDSAmLPInWj7A=;
        b=AC4XsO19TSqS2bwLTm5VI7j9/638rpEbDHXC0XWFBmEzUfYizrXYj5tcVkKK59om8t
         qiHWyvg/PGESik3FdHoA0Fxj2V9NBZnmBI5rI5iOxQe8V/uAGTUhPADZAhykxAM2QLI5
         gIgFWbBlc5QOrM/1uEjHJUSJrBj2kx0bKf5uGsJERgFrtnkD0JuubxjEYFrUN56gk+oQ
         np/NddBLqW4ksRYNB4ZQijg9DG+JDj7bgPzMD9EQLfVBOItuEntsa/KsTepBbHBfTZYQ
         /0XNTP1xn8gGuMH9UanizowqZZN+j1ZCORjssDzDpmD87dWqxvHzJaDoD1Ig8NdnDqrZ
         GRxg==
X-Gm-Message-State: AOJu0YxpuIYi+UUU4nFTFKtfPYDu7/IGimvqK8zMBOfTn0kcBfdkvcmF
        yl+o+J/uWnQ66vxsY8ObQjk=
X-Google-Smtp-Source: AGHT+IE/3y8BtLSvIHYcZOBPbsY8x2agc3Q0xHxeyZxDcyo2mX10wII/2TrlRDQVH2w7N2bQxK4CTw==
X-Received: by 2002:a17:90b:1e07:b0:280:5b33:d30 with SMTP id pg7-20020a17090b1e0700b002805b330d30mr11151542pjb.44.1698931879024;
        Thu, 02 Nov 2023 06:31:19 -0700 (PDT)
Received: from [192.168.1.105] (111-255-201-13.dynamic-ip.hinet.net. [111.255.201.13])
        by smtp.gmail.com with ESMTPSA id gk11-20020a17090b118b00b0027d0de51454sm2484308pjb.19.2023.11.02.06.31.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 06:31:18 -0700 (PDT)
Message-ID: <7537e534-9616-4f45-9974-399453aee276@gmail.com>
Date:   Thu, 2 Nov 2023 21:31:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/fair: Track current se's EEVDF parameters
Content-Language: en-US
To:     Abel Wu <wuyun.abel@bytedance.com>, mingo@redhat.com,
        peterz@infradead.org
Cc:     vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        linux-kernel@vger.kernel.org
References: <20231101174446.90413-1-s921975628@gmail.com>
 <e9638a3f-baa0-4abb-bb61-481c539c2181@bytedance.com>
From:   Yiwei Lin <s921975628@gmail.com>
In-Reply-To: <e9638a3f-baa0-4abb-bb61-481c539c2181@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/2/23 14:27, Abel Wu wrote:
> On 11/2/23 1:44 AM, s921975628@gmail.com Wrote:
>> From: Yiwei Lin <s921975628@gmail.com>
>>
>> After dequeuing the current-picked scheduling entity with
>> `__dequeue_entity`, its contribution to the EEVDF parameters
>> cfs_rq->avg_vruntime and cfs_rq->avg_load are also removed.
>> Because these should in fact be considered for the EEVDF algorithm,
>> we took curr as the special case and inserted back the contributions
>> when requests for cfs_rq->avg_vruntime and cfs_rq->avg_load.
>
> Being 'curr' means its vruntime is increasing, so does its
> contribution to avg_vruntime. And you failed to explain the
> most important part that how to commit its contribution to
> avg_vruntime (specifically in update_curr()).
>
> Regards,
>     Abel

Thanks for pointing out the missing part.  I should remember to commit back
the latest contribution at `update_curr()`. In other words, adding
delta * scale_load_down(curr->load.weight) to avg_vruntime.

Thanks,
     Yiwei Lin



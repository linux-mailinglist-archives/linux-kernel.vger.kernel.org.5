Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5D97D6A45
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 13:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233747AbjJYLjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 07:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjJYLjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 07:39:32 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996C3129;
        Wed, 25 Oct 2023 04:39:29 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1cac925732fso38316625ad.1;
        Wed, 25 Oct 2023 04:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698233969; x=1698838769; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k+ZentH0C6mAVhoNQir5R0FCDI0dOcUIaUM4TCO9vGs=;
        b=QRSokw9oYGJ2tSkAVyGwq5WzCNU8z1GtPOQBaIl9QazJjOZhAY23PNW+LUFAD/t2mw
         pF/Ty+xLiMHx/nLDhVVNkbWcn379EZoIVfV/AIYiStuaeUgLnUKxw0nbbQW8LMD2A2Eb
         Qc3yQXv8l4v7nzry7imlVjFdQ2iZKNAe9ZN3oBxR0lW/oFeCiQCni/mcnELKzxHhODq+
         OnGpUJWEZAmW0Rf1gVHtF5zXtGEuelUoNZgTM0NhLdGnQL4VMK6UA1Siwz+RQjlc085T
         zbQN8l+/n4QRz7qMHEJf1dsvnSNUXS37rgWJ/hFnB41myIYrN1wnD5OotuosmQzlmgIZ
         UptQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698233969; x=1698838769;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k+ZentH0C6mAVhoNQir5R0FCDI0dOcUIaUM4TCO9vGs=;
        b=Yk1KU0BVEJckuLcmPfdKV7uBaBHoJjGC/B6QJ8iyn6kBPGMkizc0DJVnjI0horTCOG
         B1iR1UHNB1DOn1sxKGplCxcSO9a4nO7ZJmG//VbnUA1zF3mlsGnQmoDP8SOIc1Kn7I/s
         ku/fGzc/8zxigHObbdpAlw/jJY6D22C9EwgGXrJW7Tdi5t1tC4Td13c0UQOfj4ujMcjx
         29ciHcX52xc/mZJNCFLbjILfYk04TsLZG11VzwSqwo19vbyG421nm4KBgent9KccSPHX
         4m2aAGpQ6ZNIvQf6jw3fVaQ+IZPkB5zRNqdQ+Ml9H4mB8PNE1+iWwKFHkI8neeor31lZ
         fiYg==
X-Gm-Message-State: AOJu0YyoLtlnCM+sHcTergF9CKb7SBKCkxYJQQAInyzLkicDGm976T1o
        gcC8xeFWmNWg8tleh6VmBQM=
X-Google-Smtp-Source: AGHT+IFM7VOOaQAl6JvOmOHuzeAGIx59ME/ecvaS3A4v2/DuO+uxu3Aqydv/XClTWs00Utqvq+9+aQ==
X-Received: by 2002:a17:902:d482:b0:1ca:eccb:d58b with SMTP id c2-20020a170902d48200b001caeccbd58bmr9455006plg.23.1698233968887;
        Wed, 25 Oct 2023 04:39:28 -0700 (PDT)
Received: from [192.168.1.13] ([117.243.111.63])
        by smtp.gmail.com with ESMTPSA id u5-20020a17090282c500b001c7283d3089sm8981594plz.273.2023.10.25.04.39.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 04:39:28 -0700 (PDT)
Message-ID: <ad7350d9-873b-4e79-8941-1fe684bb13a2@gmail.com>
Date:   Wed, 25 Oct 2023 17:09:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amd/pds_core: core: No need for Null pointer check before
 kfree
Content-Language: en-US
To:     Wojciech Drewek <wojciech.drewek@intel.com>,
        shannon.nelson@amd.com, brett.creeley@amd.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231024182051.48513-1-bragathemanick0908@gmail.com>
 <74296600-6d91-4353-a9f6-fdb1ed724a59@intel.com>
From:   Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
In-Reply-To: <74296600-6d91-4353-a9f6-fdb1ed724a59@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Shannon!

On 25/10/23 14:52, Wojciech Drewek wrote:
>
> On 24.10.2023 20:20, Bragatheswaran Manickavel wrote:
>> kfree()/vfree() internally perform NULL check on the
>> pointer handed to it and take no action if it indeed is
>> NULL. Hence there is no need for a pre-check of the memory
>> pointer before handing it to kfree()/vfree().
>>
>> Issue reported by ifnullfree.cocci Coccinelle semantic
>> patch script.
>>
>> Signed-off-by: Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
>> ---
> Thanks for the patch!
> One nit, you're missing a target tag. It should be [PATCH net-next] since this not a fix IMO.
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Hi Wojciech,
Will take care of this next time. Thanks!
>>   drivers/net/ethernet/amd/pds_core/core.c | 7 ++-----
>>   1 file changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/amd/pds_core/core.c b/drivers/net/ethernet/amd/pds_core/core.c
>> index 2a8643e167e1..0d2091e9eb28 100644
>> --- a/drivers/net/ethernet/amd/pds_core/core.c
>> +++ b/drivers/net/ethernet/amd/pds_core/core.c
>> @@ -152,11 +152,8 @@ void pdsc_qcq_free(struct pdsc *pdsc, struct pdsc_qcq *qcq)
>>   		dma_free_coherent(dev, qcq->cq_size,
>>   				  qcq->cq_base, qcq->cq_base_pa);
>>   
>> -	if (qcq->cq.info)
>> -		vfree(qcq->cq.info);
>> -
>> -	if (qcq->q.info)
>> -		vfree(qcq->q.info);
>> +	vfree(qcq->cq.info);
>> +	vfree(qcq->q.info);
>>   
>>   	memset(qcq, 0, sizeof(*qcq));
>>   }

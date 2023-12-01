Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDADD800D06
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 15:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379145AbjLAOTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 09:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379137AbjLAOTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 09:19:00 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CF310DB
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 06:19:05 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1d03f90b0cbso2869705ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 06:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1701440345; x=1702045145; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wEpn1rN0H9J4J1lp44h9DQD1Iq6/aR8RtLbVaUkH44I=;
        b=VOJIvOVeW57Y/YzXd2zMRTpU8jkRLXWB289x2SwezAkb0SFJMPZvSOKaZhgz0sh/Jq
         IQKeeR7V+mwxhq5kP+ZXZzISZbAbRCSFRMQlIXdD0CXTDG17c/Lwxv+y1qbj2Bfk8HRi
         HycRzBUJRnUGEHrsBSAEi9RIrg8tXDiNOD0qU1Yv8zpIGln50Njp8i+1e4G5FVa66lJh
         FZluKVqx+Z42g1dqzivsMvYT+2UW/+//uj0ICYR3nrIATqY+I34c6kLAJRjnaRpyavOf
         yMilEwxodwCE95j3ysf7H2EFl+a1GjSUjr2K1scanBdd0dKQCrxRYmXUoFtobqGoD5x8
         SmPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701440345; x=1702045145;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wEpn1rN0H9J4J1lp44h9DQD1Iq6/aR8RtLbVaUkH44I=;
        b=KNHfh2XHnXkoXw4tjj4pfB5yS2DRkB253CnOFADA6Kn3YASbuM/sSqHmO+eajDM0bG
         Itlm+7lcKbyMHXJ0v5OG02nww2MA3hfOD1i3Wq+q/egdK8Bb24YdaWdX0sPe7kxUdoDB
         ZHk8zpoK273TOAWhr6lo96tmBW4yEvAHriYgOqlWESSTXxAsJ8FC8ozoKL4AT/Y6oIuo
         dz7PmSXx1GZ14m2cKmujMZAxA1+/fpV2CGv9cBSfFy9dvKjmaB8obafjM+bGMZ1dcCDB
         nY8wsiFftv0pVGjiKXPF4mw3umrrIZMExKytFrc4JceUhX/oKV5w8Nc3O/qoZauU/agX
         hvYQ==
X-Gm-Message-State: AOJu0Yx6Sk56yaJoPEO0VzTfeHQ1PgaD60lEq2ZGhuph48rDTvmEZRnK
        wSEBrLYBphO+OLPYpbMo4+kGn5VNOaw3y0XbLNryaQ==
X-Google-Smtp-Source: AGHT+IGdByjrBLXaV56IMdNxYt294euk7OXlpD8VbgLECuhP3e6lElFoZkWSI/xZTijGcN+vhmnmgw==
X-Received: by 2002:a17:902:d501:b0:1cf:7962:656d with SMTP id b1-20020a170902d50100b001cf7962656dmr5467856plg.3.1701440345138;
        Fri, 01 Dec 2023 06:19:05 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id u23-20020a170902a61700b001cf6d5a034dsm3370360plq.209.2023.12.01.06.19.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Dec 2023 06:19:04 -0800 (PST)
Message-ID: <b26ab8d0-c719-4bf6-b909-26f4c014574b@kernel.dk>
Date:   Fri, 1 Dec 2023 07:19:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] zram: Using GFP_ATOMIC instead of GFP_KERNEL to allocate
 bitmap memory in backing_dev_store
Content-Language: en-US
To:     Dongyun Liu <dongyun.liu3@gmail.com>, minchan@kernel.org,
        senozhatsky@chromium.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        lincheng.yang@transsion.com, jiajun.ling@transsion.com,
        ldys2014@foxmail.com, Dongyun Liu <dongyun.liu@transsion.com>
References: <20231130152047.200169-1-dongyun.liu@transsion.com>
 <feb0a163-c1d3-4087-96dc-f64d0dde235b@kernel.dk>
 <3af0752f-0534-43c4-913f-4d4df8c8501b@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <3af0752f-0534-43c4-913f-4d4df8c8501b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/23 11:51 PM, Dongyun Liu wrote:
> 
> 
> On 2023/11/30 23:37, Jens Axboe wrote:
>> On 11/30/23 8:20 AM, Dongyun Liu wrote:
>>> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
>>> index d77d3664ca08..ee6c22c50e09 100644
>>> --- a/drivers/block/zram/zram_drv.c
>>> +++ b/drivers/block/zram/zram_drv.c
>>> @@ -514,7 +514,7 @@ static ssize_t backing_dev_store(struct device *dev,
>>>         nr_pages = i_size_read(inode) >> PAGE_SHIFT;
>>>       bitmap_sz = BITS_TO_LONGS(nr_pages) * sizeof(long);
>>> -    bitmap = kvzalloc(bitmap_sz, GFP_KERNEL);
>>> +    bitmap = kmalloc(bitmap_sz, GFP_ATOMIC);
>>>       if (!bitmap) {
>>>           err = -ENOMEM;
>>>           goto out;
>>
>> Outside of this moving from a zeroed alloc to one that does not, the
>> change looks woefully incomplete. Why does this allocation need to be
>> GFP_ATOMIC, and:
> 
> By using GFP_ATOMIC, it indicates that the caller cannot reclaim or
> sleep, although we can prevent the risk of  deadlock when acquiring
> the zram->lock again in zram_bvec_write.

Yes, I am very much aware of how gfp allocation flags work and how why
it's broken. It was a rhetorical question as to why you think you could
get away with just fixing one of them.

>> 1) file_name = kmalloc(PATH_MAX, GFP_KERNEL); does not
> 
> There is no zram->init_lock held here, so there is no need to use
> GFP_ATOMIC.

True

>> 2) filp_open() -> getname_kernel() -> __getname() does not
>> 3) filp_open() -> getname_kernel() does not
>> 4) bdev_open_by_dev() does not
> 
> Missing the use of GFP_ATOMIC.

Indeed!

>> IOW, you have a slew of GFP_KERNEL allocations in there, and you
>> probably just patched the largest one. But the core issue remains.
>>
>> The whole handling of backing_dev_store() looks pretty broken.
>>
> 
> Indeed, this patch only solves the biggest problem and does not
> fundamentally solve it, because there are many processes for holding
> zram->init_lock before allocation memory in backing_dev_store that
> need to be fully modified, and I did not consider it thoroughly.
> Obviously, a larger and better patch is needed to eliminate this risk,
> but it is currently not necessary.

You agree that it doesn't fix the issue, it just happens to fix the one
that you hit. And then you jump to the conclusion that this is all
that's needed to fix it. Ehm, confused?

-- 
Jens Axboe


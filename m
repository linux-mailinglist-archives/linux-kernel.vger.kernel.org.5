Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F7B7FF3B4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 16:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346309AbjK3Phk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 10:37:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbjK3Phh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 10:37:37 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B7E10E4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 07:37:43 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-7b37a2e6314so12837639f.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 07:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1701358663; x=1701963463; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eRo1oknj4mG3obwA0KmAvZPEjccwf277vmOJQMSbu+o=;
        b=V5HSyfWxih5vlN9sEwNh4WyJLxo2rNJRaDQed8gzXIOrjHWi07juEfASs39Vl364vr
         oieI9VpmVVFeMwXkwp6ggdI53xyuUSNHfsu+R4XLpL7E182oLXp1m7K6B3UhRN4TaZ8E
         nQjdDZgGWR7pe4NmRoBW3HIEoj2RK0vdskfSIz2A9CMWTJTJWDg0EpJRbw0RoKtXL05L
         mU9NhSuhajtyoObvym8TLDlsPOxUMOBxDAnncYmSOdQvIeUpxlzmNMammDN63SRSMg23
         vTnF6GpOZpiR7ROey4cnLd3zxwYnrCtDUpJf4fC9ldzgumNEVV0wOJ/xdLtIxLRWbO3u
         xStg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701358663; x=1701963463;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eRo1oknj4mG3obwA0KmAvZPEjccwf277vmOJQMSbu+o=;
        b=DCkqaoMqTGws+UAmNPJl7gNYp5CJxN6WeJWTFcSyAJdgWCvdn4v2jxfg8EmyC6QdN7
         hTKnm5fdaTdC00MkNCJVWcT2J8HHMes77GsnCPSj/kd9Q+aX3O0vcwVsr3SFiWhzyTqh
         xlb0UwzOP9frScjRp4R8CAJgb4tDC9947bdKm7i6C7hDv8npBlK607vrDnk1nMY6q67L
         pD74OMkGvXsLZK4EBtLgJ+FA/Aw2ilvAsIl8q0oVdwknsa+pBFpr66CAFmwIcKx/aW+8
         Nl60SOvty5Hm97ZcFqCaKICuKYYoji5v/VHfE+/wuuLXu4vUdBAhJ5ULZG9pBImVqbIg
         DU9A==
X-Gm-Message-State: AOJu0Yx9ZU18Qb/9auWK6T2iK9cx8LXkG3HXCn6ezdPnTf+ybNr2tVv+
        31MUVw4j5EmRu0i9N/h86iW6SA==
X-Google-Smtp-Source: AGHT+IGSYO+9xXxMk+Bn7bqLWNX6OK2f41ov3rtjgV/FWA2seq3P2qUsGUYmTrmQqmmsuPk1XL1ywQ==
X-Received: by 2002:a05:6602:155:b0:7b3:6d5c:b8e with SMTP id v21-20020a056602015500b007b36d5c0b8emr2615464iot.0.1701358662939;
        Thu, 30 Nov 2023 07:37:42 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id el4-20020a0566384d8400b00468590162f4sm345409jab.178.2023.11.30.07.37.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 07:37:42 -0800 (PST)
Message-ID: <feb0a163-c1d3-4087-96dc-f64d0dde235b@kernel.dk>
Date:   Thu, 30 Nov 2023 08:37:40 -0700
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
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231130152047.200169-1-dongyun.liu@transsion.com>
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

On 11/30/23 8:20 AM, Dongyun Liu wrote:
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index d77d3664ca08..ee6c22c50e09 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -514,7 +514,7 @@ static ssize_t backing_dev_store(struct device *dev,
>  
>  	nr_pages = i_size_read(inode) >> PAGE_SHIFT;
>  	bitmap_sz = BITS_TO_LONGS(nr_pages) * sizeof(long);
> -	bitmap = kvzalloc(bitmap_sz, GFP_KERNEL);
> +	bitmap = kmalloc(bitmap_sz, GFP_ATOMIC);
>  	if (!bitmap) {
>  		err = -ENOMEM;
>  		goto out;

Outside of this moving from a zeroed alloc to one that does not, the
change looks woefully incomplete. Why does this allocation need to be
GFP_ATOMIC, and:

1) file_name = kmalloc(PATH_MAX, GFP_KERNEL); does not
2) filp_open() -> getname_kernel() -> __getname() does not
3) filp_open() -> getname_kernel() does not
4) bdev_open_by_dev() does not

IOW, you have a slew of GFP_KERNEL allocations in there, and you
probably just patched the largest one. But the core issue remains.

The whole handling of backing_dev_store() looks pretty broken.

-- 
Jens Axboe


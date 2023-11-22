Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34ECE7F48CB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 15:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343967AbjKVOWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 09:22:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235176AbjKVOWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 09:22:04 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08EFC112;
        Wed, 22 Nov 2023 06:22:00 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6be0277c05bso6114973b3a.0;
        Wed, 22 Nov 2023 06:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700662919; x=1701267719; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T42V6TPt3HJK5qPeCR0290v9Ba+EJxYb7HZYLNMMVVo=;
        b=ItX6HUKMUyJO0KAy7//+rqRRNu3mW23Jckc9jO0iHL28Guvd/vw8oW+CcRmZyxe/Fp
         YpdsqKeP5UZ99iJmi9cnyWwAvCCqtd246Zz3E82v65Pkd/HhrvkCRTRctlkwh+UHX9Aq
         u+dbnFG0CYp6Isfyvsco9SfWkfattN8IdRWhryuXXR7o53NMFsVe0feCGsGjtAaddF/g
         tw33L3IqzTCZSLiZ7nlQ7SJw1crzqUykpJgS5vd0xaf/siFk6ZAg9YT+AJlZe+9++5j3
         ywZdG+ayiJEy/QDSg1SI8b5IfDVLEFnjDZoD2JogZyzp73RZ01mCyleYYws6aViXmbrI
         P4kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700662919; x=1701267719;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T42V6TPt3HJK5qPeCR0290v9Ba+EJxYb7HZYLNMMVVo=;
        b=h50cjlm8buzjiWnTbn9ioaphxfH7XvkTkOUZ9QVhhG6VFjd0zDx4S16SOAAK0htP/g
         tBvHVI5VKnwMkdsafus2OVkWkcEWRJ1gRyqBnuOJ/gk5j2mOlgO+k3ugcvITzuUKkDkC
         qHwgsCQ50L+VPQiOxR+imt60giloIg+BpUvti9/Zjwr/+GkfMhxBk8+QKh5z4tC2oggY
         ok5jRvqtazz88Wag98hIk5qGdRK0m8J4D1wjIwfzraxNeekUUgKyTtTOW5K0xcEN2DUv
         3jKOQtb1wiwMpsDStr4jfvNeEyDWBFmutdmidoxP8Gj0H0h/VzCzAztbszzn3Ut+h9dO
         D5Bw==
X-Gm-Message-State: AOJu0Yw9fXfqqStg9BcjdAOf/zqT3/AtBbBPTs+/qrDs47HT9y575L6/
        pdAhFvO/zih4GHFL2kWDzzs=
X-Google-Smtp-Source: AGHT+IGhy7rUh4lvpP3hDQ6ITe1G5hUYfdvFh1qdeVgpH7HmQ0lPxilhk01NWpzFV+FY9G4JyNbItQ==
X-Received: by 2002:a17:90b:4f84:b0:27c:f016:49a2 with SMTP id qe4-20020a17090b4f8400b0027cf01649a2mr2861039pjb.7.1700662919039;
        Wed, 22 Nov 2023 06:21:59 -0800 (PST)
Received: from [172.24.5.154] ([119.8.44.69])
        by smtp.gmail.com with ESMTPSA id 29-20020a17090a035d00b00280c285f878sm1536495pjf.55.2023.11.22.06.21.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 06:21:58 -0800 (PST)
From:   Asuna Yang <spriteovo@gmail.com>
X-Google-Original-From: Asuna Yang <SpriteOvO@gmail.com>
Message-ID: <4aadd8ba-d566-411a-830e-242fb101b220@gmail.com>
Date:   Wed, 22 Nov 2023 22:21:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] USB: serial: option: add Luat Air72*U series products
To:     johan@kernel.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangyu Chen <cyy@cyyself.name>
References: <20231122141803.82844-1-SpriteOvO@gmail.com>
Content-Language: en-US
In-Reply-To: <20231122141803.82844-1-SpriteOvO@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Compared to v1, the v2 patch only changed the git name.

Thanks,

On 11/22/23 22:18, Asuna Yang wrote:
> Update the USB serial option driver support for Luat Air72*U series
> products.
>
> ID 1782:4e00 Spreadtrum Communications Inc. UNISOC-8910
>
> T: Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#= 13 Spd=480 MxCh= 0
> D: Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs= 1
> P: Vendor=1782 ProdID=4e00 Rev=00.00
> S: Manufacturer=UNISOC
> S: Product=UNISOC-8910
> C: #Ifs= 5 Cfg#= 1 Atr=e0 MxPwr=400mA
> I: If#= 0 Alt= 0 #EPs= 1 Cls=e0(wlcon) Sub=01 Prot=03 Driver=rndis_host
> E: Ad=82(I) Atr=03(Int.) MxPS= 8 Ivl=4096ms
> I: If#= 1 Alt= 0 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=rndis_host
> E: Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E: Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I: If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E: Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E: Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I: If#= 3 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E: Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E: Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I: If#= 4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E: Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E: Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>
> Co-developed-by: Yangyu Chen <cyy@cyyself.name>
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
> Signed-off-by: Asuna Yang <SpriteOvO@gmail.com>
> ---
>   drivers/usb/serial/option.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
> index 45dcfaadaf98..b76cb9a096f7 100644
> --- a/drivers/usb/serial/option.c
> +++ b/drivers/usb/serial/option.c
> @@ -609,6 +609,8 @@ static void option_instat_callback(struct urb *urb);
>   #define UNISOC_VENDOR_ID			0x1782
>   /* TOZED LT70-C based on UNISOC SL8563 uses UNISOC's vendor ID */
>   #define TOZED_PRODUCT_LT70C			0x4055
> +/* Luat Air72*U series based on UNISOC UIS8910 uses UNISOC's vendor ID */
> +#define LUAT_PRODUCT_AIR720U			0x4e00
>   
>   /* Device flags */
>   
> @@ -2271,6 +2273,7 @@ static const struct usb_device_id option_ids[] = {
>   	{ USB_DEVICE_AND_INTERFACE_INFO(SIERRA_VENDOR_ID, SIERRA_PRODUCT_EM9191, 0xff, 0xff, 0x40) },
>   	{ USB_DEVICE_AND_INTERFACE_INFO(SIERRA_VENDOR_ID, SIERRA_PRODUCT_EM9191, 0xff, 0, 0) },
>   	{ USB_DEVICE_AND_INTERFACE_INFO(UNISOC_VENDOR_ID, TOZED_PRODUCT_LT70C, 0xff, 0, 0) },
> +	{ USB_DEVICE_AND_INTERFACE_INFO(UNISOC_VENDOR_ID, LUAT_PRODUCT_AIR720U, 0xff, 0, 0) },
>   	{ } /* Terminating entry */
>   };
>   MODULE_DEVICE_TABLE(usb, option_ids);

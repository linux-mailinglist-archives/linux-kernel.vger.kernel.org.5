Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0EA7D8357
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 15:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344987AbjJZNNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 09:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbjJZNNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 09:13:24 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B46512A;
        Thu, 26 Oct 2023 06:13:21 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c9bf22fe05so6543335ad.2;
        Thu, 26 Oct 2023 06:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698326001; x=1698930801; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sEnPf88Jt5XnwTHhFWjZ1zcOWPv+iZfytB9ZjHA1/p0=;
        b=Wyisu8o9M8CgQpvfQzmiCNT2mTo3H8smX6mPWoQqZU3F0OvVTXt6LelOfhUBSppFGD
         ZEtE8AAW16ERYmM2VfEWfwCPF2rPYSLMTC5xRRukKExlXrX855Asqj91MAGL6zNunVPp
         OJh6+96rGNNohudVtzy++MSkKX8JZ38O56siNp5Lb9d7k5A+FyYIvHeHvAIXQ+UL/u5n
         O3F13bZl/CmZ6cp4WSkdXuxH4GDXxOEyXnUQT797n6TnkSgB+VHsSUDgoVlL+fcYawJ5
         nlPQbh7GgKHk5wjhUFnUTAkEQVVKnG2gUk2kB6woaS39csHnclzPu8BERlZodi8v0Z0A
         6Sxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698326001; x=1698930801;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sEnPf88Jt5XnwTHhFWjZ1zcOWPv+iZfytB9ZjHA1/p0=;
        b=l+qI92R+L5cKpvhjHHKkotLKsYhqTxY+6LaihSUYa+KSZiyQCebJgHE0YbaO4XNYps
         vHesriO19QhUKHZlCGJsbZPfHP1c3gYB6T4U/P0wDtwdBqGdPlfq/XHiSqa44fiDLvtR
         mljMW2uQNzNS+lhlADAVwimuHHAolSgGh7OsZq6aOoESHuDMH+4lV+oMvuqVxlEgb63B
         O8Wo1885V3qcVTzsSjjDp6DlBBJtRL1bqUA5E1tSWsFUC2rmJ/ab31gIoR6UV3QPfHMv
         I7HXK4PirYWBFJwF/DEDM2QXKw3KOkehaCc5CAO8B0DSLxhXUuRcFClAsVZ+tVyq19vL
         tLeA==
X-Gm-Message-State: AOJu0YxgdIa1hB8LZanCWt0JNo7bpoaVlj85ztN3cTbh9dogI9bdtP9L
        1FXe1q3eh1efwx1WHYlN/qo=
X-Google-Smtp-Source: AGHT+IFn2DJJBKgA7L7hBELD5R0h9RsAD2LwKmcN1ybfGVOdhFgeqcvvYnxkBp0a4mtSF7XWHYDLtw==
X-Received: by 2002:a17:902:c74b:b0:1c9:dac0:fbb3 with SMTP id q11-20020a170902c74b00b001c9dac0fbb3mr12810316plq.31.1698326000729;
        Thu, 26 Oct 2023 06:13:20 -0700 (PDT)
Received: from [192.168.1.7] ([159.192.164.247])
        by smtp.googlemail.com with ESMTPSA id h1-20020a170902704100b001c61921d4d2sm10953151plt.302.2023.10.26.06.13.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Oct 2023 06:13:20 -0700 (PDT)
Message-ID: <84a78bb8-fd85-4ee5-9c92-859e8450a587@gmail.com>
Date:   Thu, 26 Oct 2023 20:13:14 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] USB: serial: option: add Fibocom L7xx modules
Content-Language: en-US
To:     Victor Fragoso <victorffs@hotmail.com>,
        "johan@kernel.org" <johan@kernel.org>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <9315051ae981aaad1d46724641defc6e5f79d12b.camel@hotmail.com>
From:   Lars Melin <larsm17@gmail.com>
In-Reply-To: <9315051ae981aaad1d46724641defc6e5f79d12b.camel@hotmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/2023 8:24, Victor Fragoso wrote:
> Add support for Fibocom L7xx module series and variants.
> 
> L716-EU-60 (ECM):
> T:  Bus=03 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#= 17 Spd=480  MxCh= 0
> D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
> P:  Vendor=19d2 ProdID=0579 Rev= 1.00
> S:  Manufacturer=Fibocom,Incorporated
> S:  Product=Fibocom Mobile Boardband
> S:  SerialNumber=1234567890ABCDEF
> C:* #Ifs= 7 Cfg#= 1 Atr=e0 MxPwr=500mA
> A:  FirstIf#= 0 IfCount= 2 Cls=02(comm.) Sub=06 Prot=00
> I:* If#= 0 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=06 Prot=00 Driver=cdc_ether
> E:  Ad=87(I) Atr=03(Int.) MxPS=  16 Ivl=32ms
> I:  If#= 1 Alt= 0 #EPs= 0 Cls=0a(data ) Sub=00 Prot=00 Driver=cdc_ether
> I:* If#= 1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=cdc_ether
> E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
> E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 3 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
> E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
> E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 5 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
> E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 6 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=usbfs
> E:  Ad=86(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=06(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> 
> L716-EU-60 (RNDIS):
> T:  Bus=03 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#= 21 Spd=480  MxCh= 0
> D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
> P:  Vendor=2cb7 ProdID=0001 Rev= 1.00
> S:  Manufacturer=Fibocom,Incorporated
> S:  Product=Fibocom Mobile Boardband
> S:  SerialNumber=1234567890ABCDEF
> C:* #Ifs= 7 Cfg#= 1 Atr=e0 MxPwr=500mA
> A:  FirstIf#= 0 IfCount= 2 Cls=02(comm.) Sub=06 Prot=00
> I:* If#= 0 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=06 Prot=00 Driver=cdc_ether
> E:  Ad=87(I) Atr=03(Int.) MxPS=  16 Ivl=32ms
> I:  If#= 1 Alt= 0 #EPs= 0 Cls=0a(data ) Sub=00 Prot=00 Driver=cdc_ether
> I:* If#= 1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=cdc_ether
> E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
> E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 3 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
> E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
> E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 5 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
> E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 6 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=usbfs
> E:  Ad=86(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=06(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> 
> L716-EU-10 (ECM):
> T:  Bus=03 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#= 21 Spd=480  MxCh= 0
> D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
> P:  Vendor=2cb7 ProdID=0001 Rev= 1.00
> S:  Manufacturer=Fibocom,Incorporated
> S:  Product=Fibocom Mobile Boardband
> S:  SerialNumber=1234567890ABCDEF
> C:* #Ifs= 7 Cfg#= 1 Atr=e0 MxPwr=500mA
> A:  FirstIf#= 0 IfCount= 2 Cls=02(comm.) Sub=06 Prot=00
> I:* If#= 0 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=06 Prot=00 Driver=cdc_ether
> E:  Ad=87(I) Atr=03(Int.) MxPS=  16 Ivl=32ms
> I:  If#= 1 Alt= 0 #EPs= 0 Cls=0a(data ) Sub=00 Prot=00 Driver=cdc_ether
> I:* If#= 1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=cdc_ether
> E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
> E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 3 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
> E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
> E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 5 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
> E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 6 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=usbfs
> E:  Ad=86(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=06(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> 
> Signed-off-by: Victor Fragoso <victorffs@hotmail.com>
> ---
>   drivers/usb/serial/option.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
> index 45dcfaadaf98..4ba3dc352d65 100644
> --- a/drivers/usb/serial/option.c
> +++ b/drivers/usb/serial/option.c
> @@ -2262,6 +2262,11 @@ static const struct usb_device_id option_ids[] =
> {
>   	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x01a2, 0xff)
> },			/* Fibocom FM101-GL (laptop MBIM) */
>   	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x01a4,
> 0xff),			/* Fibocom FM101-GL (laptop MBIM) */
>   	  .driver_info = RSVD(4) },
> +	{ USB_DEVICE_AND_INTERFACE_INFO(0x2cb7, 0x0001, 0xff, 0xff,
> 0xff) },	/* Fibocom L71x */
> +	{ USB_DEVICE_AND_INTERFACE_INFO(0x2cb7, 0x0001, 0x0a, 0x00,
> 0xff) },	/* Fibocom L71x */
> +	{ USB_DEVICE_AND_INTERFACE_INFO(0x2cb7, 0x0100, 0xff, 0xff,
> 0xff) },	/* Fibocom L71x */
> +	{ USB_DEVICE_AND_INTERFACE_INFO(0x19d2, 0x0256, 0xff, 0xff,
> 0xff) },	/* Fibocom L71x */
> +	{ USB_DEVICE_AND_INTERFACE_INFO(0x19d2, 0x0579, 0xff, 0xff,
> 0xff) },	/* Fibocom L71x */
>   	{ USB_DEVICE_INTERFACE_CLASS(0x2df3, 0x9d03, 0xff)
> },			/* LongSung M5710 */
>   	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1404, 0xff)
> },			/* GosunCn GM500 RNDIS */
>   	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1405, 0xff)
> },			/* GosunCn GM500 MBIM */


Hi Victor, thanks for the patch, there is unfortunately the following 
errors in it:
The device list is sorted in ascending order based on vid:pid, you have 
inserted all of your added Id's in the wrong place.

19d2:0579 is a ZTE device Id and should be placed among the other 19d2 
devices.

You have not included usb-devices output for 19d2:0256 and 2cb7:0100, 
and I have strong reasons to believe that they should not be included in 
the option driver.
If you are of another opinion then please show the usb-devices output 
for them, otherwise remove them from the patch.

You have added support for an interface with the attributes 0a/00/ff , 
there is no such interface in your provided usb-devices listing, 
interface Class 0a does not even belong to the option driver.

Thanks
Lars

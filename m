Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED89D7DA188
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 21:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232867AbjJ0T7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 15:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbjJ0T7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 15:59:51 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96A21AA;
        Fri, 27 Oct 2023 12:59:48 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6be1bc5aa1cso2438980b3a.3;
        Fri, 27 Oct 2023 12:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698436788; x=1699041588; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=weKHPjc4wxBWhrJPXw89N+hZ6eKctWfsrLxKNLkb6ls=;
        b=VYSPSBNuOJHJKjmv3GatUEGUveVDUbkM4V2YgZQu5XlCuGhPt7wD2ZI5Mluwi2Pqhh
         tWa+5YST4KJKYF4T2Q7Y5h1VRi/AGNr1fkzs5EFhdTrz5SEl7IpHo30H52BSx4F5C5gV
         cwFOTmUJp3fOahwWVO4f/OJR4LP5k3H9oFqqXGagSX4BPxkZGQsdPJvJvBGmuQZWLOOC
         2YNqNYFtEpABPlq8YPtKj80WtQW6VGlhDJiE9bMeyvic29WQBBryD0vleGAN32q5MLHG
         5mkIKE//hXyUbs0LHXTQCkwkmWCbQNCmpU7GoCqJm3x2/4ZaqAkuHT2HZ6zswAIAAMh7
         dGLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698436788; x=1699041588;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=weKHPjc4wxBWhrJPXw89N+hZ6eKctWfsrLxKNLkb6ls=;
        b=F5tl63Vkq5aOS4gTmzN9or0XM+QGy5s3ThuDoJbXzcDEVzh+kI9Ix9QIFKvcUIqm1F
         JkY3A6Vwlo7y6Dpuy6Z4VlmVd/TSScFByO/0UKytQXn/78Jt1SG5BD9RoyK5O+8jBD/4
         zDIhADF8nCIofCxFDGgA2tNSgO3twTfLaU4UCpPMkwTH+6pVzf4RUjT08BABP4l4Oda4
         a6WNcD27sDLSQce5SXSnH3vtNQRNzdP0awVuz2vzBQt6cC5DJU72yzlAbryppR50fxxG
         SdT7z6ba8LIGxy/kSd05TisvN8LoJYOfJhpQwxVxCb7HPy1TFWBUliCflUP0D48MVwdh
         eENw==
X-Gm-Message-State: AOJu0YwUcw+o/NUiVy+dRAlM91PJtUp0G1tD4BJ1iXt7bxdPmNLPGefV
        25zvph/cKNF7Xx1zhukXkCE=
X-Google-Smtp-Source: AGHT+IFk+gtYxQ8LAHDWpcgS3J28W2XTK3gk8wUOAryTEz+QmMB12fhIgtRqvCcN8KMIyoepBHQlrg==
X-Received: by 2002:a05:6a21:3388:b0:15c:c381:f65e with SMTP id yy8-20020a056a21338800b0015cc381f65emr4783548pzb.34.1698436787831;
        Fri, 27 Oct 2023 12:59:47 -0700 (PDT)
Received: from [192.168.1.7] ([159.192.237.220])
        by smtp.googlemail.com with ESMTPSA id fj40-20020a056a003a2800b0068fe7c4148fsm1745550pfb.57.2023.10.27.12.59.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Oct 2023 12:59:47 -0700 (PDT)
Message-ID: <103aa944-073a-4dd0-8d58-8c9123dc2352@gmail.com>
Date:   Sat, 28 Oct 2023 02:59:42 +0700
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
 <84a78bb8-fd85-4ee5-9c92-859e8450a587@gmail.com>
 <94477736e69cc76eaaef8584d7e1aa5078a0611e.camel@hotmail.com>
From:   Lars Melin <larsm17@gmail.com>
In-Reply-To: <94477736e69cc76eaaef8584d7e1aa5078a0611e.camel@hotmail.com>
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

On 10/28/2023 0:55, Victor Fragoso wrote:
> On Thu, 2023-10-26 at 20:13 +0700, Lars Melin wrote:
>> On 10/26/2023 8:24, Victor Fragoso wrote:
>>> Add support for Fibocom L7xx module series and variants.
>>>
>>> L716-EU-60 (ECM):
>>> T:  Bus=03 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#= 17 Spd=480  MxCh= 0
>>> D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
>>> P:  Vendor=19d2 ProdID=0579 Rev= 1.00
>>> S:  Manufacturer=Fibocom,Incorporated
>>> S:  Product=Fibocom Mobile Boardband
>>> S:  SerialNumber=1234567890ABCDEF
>>> C:* #Ifs= 7 Cfg#= 1 Atr=e0 MxPwr=500mA
>>> A:  FirstIf#= 0 IfCount= 2 Cls=02(comm.) Sub=06 Prot=00
>>> I:* If#= 0 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=06 Prot=00 Driver=cdc_ether
>>> E:  Ad=87(I) Atr=03(Int.) MxPS=  16 Ivl=32ms
>>> I:  If#= 1 Alt= 0 #EPs= 0 Cls=0a(data ) Sub=00 Prot=00 Driver=cdc_ether
>>> I:* If#= 1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=cdc_ether
>>> E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>>> E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>>> I:* If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
>>> E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>>> E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>>> I:* If#= 3 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
>>> E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>>> E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>>> I:* If#= 4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
>>> E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>>> E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>>> I:* If#= 5 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
>>> E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>>> E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>>> I:* If#= 6 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=usbfs
>>> E:  Ad=86(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>>> E:  Ad=06(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>>>
>>> L716-EU-60 (RNDIS):
>>> T:  Bus=03 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#= 21 Spd=480  MxCh= 0
>>> D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
>>> P:  Vendor=2cb7 ProdID=0001 Rev= 1.00
>>> S:  Manufacturer=Fibocom,Incorporated
>>> S:  Product=Fibocom Mobile Boardband
>>> S:  SerialNumber=1234567890ABCDEF
>>> C:* #Ifs= 7 Cfg#= 1 Atr=e0 MxPwr=500mA
>>> A:  FirstIf#= 0 IfCount= 2 Cls=02(comm.) Sub=06 Prot=00
>>> I:* If#= 0 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=06 Prot=00 Driver=cdc_ether
>>> E:  Ad=87(I) Atr=03(Int.) MxPS=  16 Ivl=32ms
>>> I:  If#= 1 Alt= 0 #EPs= 0 Cls=0a(data ) Sub=00 Prot=00 Driver=cdc_ether
>>> I:* If#= 1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=cdc_ether
>>> E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>>> E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>>> I:* If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
>>> E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>>> E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>>> I:* If#= 3 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
>>> E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>>> E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>>> I:* If#= 4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
>>> E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>>> E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>>> I:* If#= 5 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
>>> E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>>> E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>>> I:* If#= 6 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=usbfs
>>> E:  Ad=86(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>>> E:  Ad=06(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>>>
>>> L716-EU-10 (ECM):
>>> T:  Bus=03 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#= 21 Spd=480  MxCh= 0
>>> D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
>>> P:  Vendor=2cb7 ProdID=0001 Rev= 1.00
>>> S:  Manufacturer=Fibocom,Incorporated
>>> S:  Product=Fibocom Mobile Boardband
>>> S:  SerialNumber=1234567890ABCDEF
>>> C:* #Ifs= 7 Cfg#= 1 Atr=e0 MxPwr=500mA
>>> A:  FirstIf#= 0 IfCount= 2 Cls=02(comm.) Sub=06 Prot=00
>>> I:* If#= 0 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=06 Prot=00 Driver=cdc_ether
>>> E:  Ad=87(I) Atr=03(Int.) MxPS=  16 Ivl=32ms
>>> I:  If#= 1 Alt= 0 #EPs= 0 Cls=0a(data ) Sub=00 Prot=00 Driver=cdc_ether
>>> I:* If#= 1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=cdc_ether
>>> E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>>> E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>>> I:* If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
>>> E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>>> E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>>> I:* If#= 3 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
>>> E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>>> E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>>> I:* If#= 4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
>>> E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>>> E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>>> I:* If#= 5 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
>>> E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>>> E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>>> I:* If#= 6 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=usbfs
>>> E:  Ad=86(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>>> E:  Ad=06(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>>>
>>> Signed-off-by: Victor Fragoso <victorffs@hotmail.com>
>>> ---
>>>    drivers/usb/serial/option.c | 5 +++++
>>>    1 file changed, 5 insertions(+)
>>>
>>> diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
>>> index 45dcfaadaf98..4ba3dc352d65 100644
>>> --- a/drivers/usb/serial/option.c
>>> +++ b/drivers/usb/serial/option.c
>>> @@ -2262,6 +2262,11 @@ static const struct usb_device_id option_ids[] =
>>> {
>>>    	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x01a2, 0xff)
>>> },			/* Fibocom FM101-GL (laptop MBIM) */
>>>    	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x01a4,
>>> 0xff),			/* Fibocom FM101-GL (laptop MBIM) */
>>>    	  .driver_info = RSVD(4) },
>>> +	{ USB_DEVICE_AND_INTERFACE_INFO(0x2cb7, 0x0001, 0xff, 0xff,
>>> 0xff) },	/* Fibocom L71x */
>>> +	{ USB_DEVICE_AND_INTERFACE_INFO(0x2cb7, 0x0001, 0x0a, 0x00,
>>> 0xff) },	/* Fibocom L71x */
>>> +	{ USB_DEVICE_AND_INTERFACE_INFO(0x2cb7, 0x0100, 0xff, 0xff,
>>> 0xff) },	/* Fibocom L71x */
>>> +	{ USB_DEVICE_AND_INTERFACE_INFO(0x19d2, 0x0256, 0xff, 0xff,
>>> 0xff) },	/* Fibocom L71x */
>>> +	{ USB_DEVICE_AND_INTERFACE_INFO(0x19d2, 0x0579, 0xff, 0xff,
>>> 0xff) },	/* Fibocom L71x */
>>>    	{ USB_DEVICE_INTERFACE_CLASS(0x2df3, 0x9d03, 0xff)
>>> },			/* LongSung M5710 */
>>>    	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1404, 0xff)
>>> },			/* GosunCn GM500 RNDIS */
>>>    	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1405, 0xff)
>>> },			/* GosunCn GM500 MBIM */
>>
>>
>> Hi Victor, thanks for the patch, there is unfortunately the following
>> errors in it:
>> The device list is sorted in ascending order based on vid:pid, you have
>> inserted all of your added Id's in the wrong place.
>>
>> 19d2:0579 is a ZTE device Id and should be placed among the other 19d2
>> devices.
>>
>> You have not included usb-devices output for 19d2:0256 and 2cb7:0100,
>> and I have strong reasons to believe that they should not be included in
>> the option driver.
>> If you are of another opinion then please show the usb-devices output
>> for them, otherwise remove them from the patch.
>>
>> You have added support for an interface with the attributes 0a/00/ff ,
>> there is no such interface in your provided usb-devices listing,
>> interface Class 0a does not even belong to the option driver.
>>
>> Thanks
>> Lars
> 
> Hi Lars, sorry about the wrong order, I will correct it.
> 
> But about the ZTE device ID, I belive that we should insert among
> Fibocom drivers because we are talking about a Fibocom module that is
> using an ZTE Chipset.
> So, this is exactly the same situation from Fibocom L610 IDs (0x1782,
> 0x4d10 / 0x1782, 0x4d11) that is using the Unisoc Chipset but were
> inserted among Fibocom drivers.
> 
> And about the usb-devices output, let me explain better:
> I am a Field Application Enginner at Fibocom Brazil and I am using the
> IDs from our internal and official documentation.
> On this documents its suggested to add all this IDs because it will
> guarantee that can be used on all the variants devices from L71x series
> (that can change according to different part number, region support or
> network protocol).
> Unfortunately, I don't have all the modules variations available with
> me right now to test and share all the outputs.
> 
> Can we continue with all the IDs that I have inserted?
> Or do you prefer to keep just the devices that I tested by myself until
> now?
> 
> Victor Fragoso

Johan may have a different opinion from mine and he is the one to 
decide, my take is that there is no value in having a minor part of the 
list grouped by mfgr and the major part of the list sorted by USB Id.
We have also seen in the past that when a mfgr1 buys a chipset from 
mfgr2 and then sells his product with mfgr2 Id instead of using one of 
his own Id's then there is also not uncommon that mfgr3 is also buying 
the same chipset without changing Id. Hence "Manufacturer name" is not 
unique but the vid is..

The list should not be seen or used as a cross reference between 
mfgr:product name and vid:pid, anyone who needs to search the driver 
source to see if a device is supported ought to know its vid:pid so can 
search on those and that works much better if the list is sorted by 
vid:pid in ascending order. Personally I'd rather see a source without 
all the unnecessary defines, only vid:pid based and with the 
mfgr/product as an optional comment.

When adding Id's to the driver it is you who should know the devices you 
are adding, don't add Id's if you have not personally confirmed their 
interface composition and usage.
Those who told you add these Id's apparently also told you that there 
are two versions of 2cb7:0001, one with ECM interfaces and one with 
RNDIS interfaces but your usb-devices output show both to be identical.. 
There is no RNDIS interface in your listings, both of them will load
the cdc_ether driver.

br
Lars


Return-Path: <linux-kernel+bounces-51834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB82848FD2
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 18:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CED31F21C36
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 17:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA7D249F5;
	Sun,  4 Feb 2024 17:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e052uGI6"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0B3249ED;
	Sun,  4 Feb 2024 17:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707069227; cv=none; b=Ldt9jlDZK87tch0AeGFYi5JAAG45idJPaZFCka7mUnD/tQu0GBCn1n+ETcgYR/szdmSaDxFVcYL1sF9LYfD9FHlHhSVC/hQBJIcr1MhL0yXBzlzsCsUq6W0h8z9aaT5hODrxSMQmPwUFLv5QVSXRsdjSLBp5olGTVhieB1LWT7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707069227; c=relaxed/simple;
	bh=EcNJ3rKMcbo5fK8XHTaSZEIXc7cpvN5ob1azr59K0D8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PSzj50F9an5cFmi22JpZsA9769FYMcu96RPcmhr8ID5tOI6/ZYqXVeT5prxfJk62ezYkzNnOUGQnRiAncO6CIQ7xH/ppg+mc3cjPc4GU4uq6WNbY2pp5Uyy0DKAt+q7XfXoVJR3yFaVfbkY4WgbqJ8gS3Tpd0Znzw4sAKuNuZ9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e052uGI6; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33b29b5ea86so964288f8f.1;
        Sun, 04 Feb 2024 09:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707069224; x=1707674024; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qphVhv7DsI6M2H6WOfBkI0vgxxCWMpx7hi0O5yQ9Yuw=;
        b=e052uGI6GN65m4vlp3R5BsORaQXfZZ3cQMNOYhpJzwEpEnY0vybM79uoinwl1Uof9f
         WHdeOP5dUQSbVVaiaUqx95RNsnlD2al52psluZVnhNHgSOgcL85qo2YU4PP5lWAceSYC
         UGTLQEXbQLhZzpWUmFDWASWvkzVdQwzV3GDpEXTqNQkRUJE8i4SX4esPE/fYDeb802CN
         FXwmOI3lQqVnscnOb1g+2L26s0yAva/9OjUvpROQNzyZWieR2WjnrVq1/CWynyzS/Doh
         d6lKLX96GEFPr1TiB0TYUxAaZBh4e14HX6ba4gTyYQUuiQNzQpVmtYOdf4GbVhsCWIcl
         VUWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707069224; x=1707674024;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qphVhv7DsI6M2H6WOfBkI0vgxxCWMpx7hi0O5yQ9Yuw=;
        b=bEeh3R8tQxLET/GoFZEIF4MWRFome2v55w9uC82iScX7Xaa0F0w1hZIyXpvQ6oGdcw
         JKUbtzR20yrWSg/3PJcElJShXDBwRqcVEI4MILT/kjT4b/A3OY/7jvBgQVKAziZnTx4i
         7WMG6ivgCYhAmdobXtxDslpCZ/BCFfjZ6+xYCqBS5+varG+2cT+AuJf6S6GT/e3V6FsK
         fhZiwKFzM76dhsXGntx5+mxGGuYNRk5+9EI4vSHxgWqyO5/9iNdufR3+ZCTFoEgR2v/m
         kJzwrbnTg+jxv4/j1YDccsEmNoMbNgqDqTWNlfo6um9nZqZzPDZ//EAwLiQP5y/W4Kz7
         lQEQ==
X-Gm-Message-State: AOJu0YxW/C25/3wymyi1fEUOFJIAdrrLPx2Kpj01Khfr4S3FCUneF1NW
	NV9EFpoBsR0PedThkClhfF4IWdeIkYFiu6luQHwEPx5crfYxceQm
X-Google-Smtp-Source: AGHT+IHV/IvLSAN2izrOHg66txgeN0PvWT68scjuselKXxDQznIpQYokZ0XkHOn8krFeITl2sA9sRA==
X-Received: by 2002:a5d:64a8:0:b0:33b:26de:4289 with SMTP id m8-20020a5d64a8000000b0033b26de4289mr4501493wrp.42.1707069223497;
        Sun, 04 Feb 2024 09:53:43 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCURr1MAjAWShprE84DyqOpJcq1IZl3JyECTbXelgawITqOuXZQoiiuaIWO4ECSpl7dt9ZdQMGk3MEwQIUof8jnhoisqZb9WO0V+OiaNh6Lzo4AQZUakvDPYQOUKa2tyddQ1x3fXNOoS0ZGl0/r1QOKif823uiKwR+9p/BC7s+u6+bNlV5+DtKfD9hs=
Received: from [192.168.101.144] (i577B6AA2.versanet.de. [87.123.106.162])
        by smtp.gmail.com with ESMTPSA id fs18-20020a05600c3f9200b0040ef9ffd3c1sm6266105wmb.19.2024.02.04.09.53.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Feb 2024 09:53:43 -0800 (PST)
Message-ID: <a449f603-8079-468c-9a28-be32ae96f83a@gmail.com>
Date: Sun, 4 Feb 2024 18:53:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] Add 10EC5280 to bmi160_i2c ACPI IDs to allow binding
 on some devices
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20240202173040.26806-2-jesusmgh@gmail.com>
 <20240204140010.7edaa782@jic23-huawei>
Content-Language: es-ES, de-DE, en-US
From: Jesus Miguel Gonzalez Herrero <jesusmgh@gmail.com>
In-Reply-To: <20240204140010.7edaa782@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Mr. Cameron

First of all thank you for reviewing the patch.

And I most definitely agree with you and Mr. Shevchenko: this absolutely
is a firmware bug that manufacturers should fix. For this reason some
people started talks with affected manufacturers to change it. In my
case it was with GPD, together with some others, including some which
historically had a more direct line with them. This was finally dismissed
as WONTFIX, since their main focus is Windows and their driver supports
the ID, so the end result of those conversations is a lack of a fixed
firmware, and a surplus of frustration.

As far as I know people have been in talks with Aya too, and I do not
know the status of conversations with Lenovo or other manufacturers. I
do not know of any conversation with Realtek, besides what was mentioned
in those emails you linked to from 2021.

I will amend the patch to include a big disclaimer and the reason as
a comment in the code, and send it again in reply to this message. I
don't think I'd go as far as tainting the kernel, but I'm not opposed,
happy anyway if the IMU finally becomes usable, and VERY far from any
expertise whatsoever concerning kernel development!

Here is the relevant extract from the DSDT of my GPD Win Max 2 (AMD
6800U model) with the latest firmware 1.05 installed.

     Scope (_SB.I2CC) {
         Device (BMA2) {
             Name (_ADR, Zero)  // _ADR: Address Name (_HID, "10EC5280")
             // _HID: Hardware ID Name (_CID, "10EC5280")  // _CID:
             Compatible ID Name (_DDN, "Accelerometer")  // _DDN: DOS
             Device Name Name (_UID, One)  // _UID: Unique ID Method
             (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings {
                 Name (RBUF, ResourceTemplate () {
                     I2cSerialBusV2 (0x0069, ControllerInitiated,
                     0x00061A80,
                         AddressingMode7Bit, "\\_SB.I2CC", 0x00,
                         ResourceConsumer, , Exclusive, )
                 }) Return (RBUF) /* \_SB_.I2CC.BMA2._CRS.RBUF */
             }

             OperationRegion (CMS2, SystemIO, 0x72, 0x02) Field (CMS2,
             ByteAcc, NoLock, Preserve) {
                 IND2,   8, DAT2,   8
             }

             IndexField (IND2, DAT2, ByteAcc, NoLock, Preserve) {
                 Offset (0x74), BACS,   32
             }

             Method (ROMS, 0, NotSerialized) {
                 Name (RBUF, Package (0x03) {
                     "0 -1 0", "-1 0 0", "0 0 1"
                 }) Return (RBUF) /* \_SB_.I2CC.BMA2.ROMS.RBUF */
             }

             Method (CALS, 1, NotSerialized) {
                 Local0 = Arg0 If (((Local0 == Zero) || (Local0 ==
                 Ones))) {
                     Return (Local0)
                 } Else {
                     BACS = Local0
                 }
             }

             Method (_STA, 0, NotSerialized)  // _STA: Status {
                 Return (0x0F)
             }
         }
     }

Thank you for taking this into consideration!

Jesus Gonzalez



On 04/02/2024 15:00, Jonathan Cameron wrote:
> On Fri,  2 Feb 2024 18:30:41 +0100
> Jesus Gonzalez <jesusmgh@gmail.com> wrote:
>
>> "10EC5280" is used by several manufacturers like Lenovo, GPD, or AYA (and
>> probably others) in their ACPI table as the ID for the bmi160 IMU. This
>> means the bmi160_i2c driver won't bind to it, and the IMU is unavailable
>> to the user. Manufacturers have been approached on several occasions to
>> try getting a BIOS with a fixed ID, mostly without actual positive
>> results, and since affected devices are already a few years old, this is
>> not expected to change. This patch enables using the bmi160_i2c driver for
>> the bmi160 IMU on these devices.
> Hi Jesus,
>
> https://lore.kernel.org/lkml/CAHp75Vct-AXnU7QQmdE7nyYZT-=n=p67COPLiiZTet7z7snL-g@mail.gmail.com/
> Lays out what Andy (and for that matter I) consider necessary for such
> a patch.
>
> In short, we want to see devices called out here - with a DSDT section.
> + a clear comment in the code.
>
> The big problem here is this tramples on Realtech's ID space. It's not just
> a made up code (incidentally the BMI0160 isn't valid either),
> it's a valid code but for an entirely different (PCI) device.
>
> So we need as much info as possible in the patch description and the driver
> itself to justify carrying this.   Tempting to add a firmware bug taint on
> it as well but that might scare people :)
>
> Jonathan
>
>
>> Signed-off-by: Jesus Gonzalez <jesusmgh@gmail.com>
>> ---
>> A device-specific transformation matrix can then be provided in a second
>> step through udev hwdb.
>>
>> This has been discussed before in 2021, see here:
>> https://lore.kernel.org/lkml/CACAwPwYQHRcrabw9=0tvenPzAcwwW1pTaR6a+AEWBF9Hqf_wXQ@mail.gmail.com/
>>
>> Lenovo, as an example of a big manufacturer, is also using this ID:
>> https://www.reddit.com/r/linux/comments/r6f9de/comment/hr8bdfs/?context=3
>>
>> At least some discussions with GPD took place on the GPD server Discord,
>> for which I can provide proof on demand via screenshot (if not accessible
>> directly).
>>
>> I have read the patch submission instructions and followed them to the
>> best of my knowledge. Still, this is my first kernel patch submission,
>> so I'd be glad if you could please point out any mistakes. Thank you!
>>
>>
>>   drivers/iio/imu/bmi160/bmi160_spi.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/iio/imu/bmi160/bmi160_spi.c b/drivers/iio/imu/bmi160/bmi160_spi.c
>> index 8b573ea99af2..0874c37c6670 100644
>> --- a/drivers/iio/imu/bmi160/bmi160_spi.c
>> +++ b/drivers/iio/imu/bmi160/bmi160_spi.c
>> @@ -41,6 +41,7 @@ MODULE_DEVICE_TABLE(spi, bmi160_spi_id);
>>   
>>   static const struct acpi_device_id bmi160_acpi_match[] = {
>>   	{"BMI0160", 0},
>> +	{"10EC5280", 0},
>>   	{ },
>>   };
>>   MODULE_DEVICE_TABLE(acpi, bmi160_acpi_match);


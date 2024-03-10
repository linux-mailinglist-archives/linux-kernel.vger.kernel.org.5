Return-Path: <linux-kernel+bounces-98288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FE98777ED
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 19:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F5A11C208EE
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 18:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66FD739AEA;
	Sun, 10 Mar 2024 18:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iktKiwLc"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44563984A;
	Sun, 10 Mar 2024 18:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710094510; cv=none; b=MLkVxHbilMRNXhk2JXVOjR23rreCUkOnsCBvjnE1GQd0dGbUS/TVqB7wD1OK6mXSpalgd8Ve6EKxDRRm1WlZdxbuoKAVw27hZSnt+xOae7CWTMorwU+JjjofXC8eQxUZNXGfs/FED0t9v878qcfYTyu9QtVJPZq24EdeeWnW+cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710094510; c=relaxed/simple;
	bh=Me3N+aSp63v2aYhLt7RwblPyj0XJZ9M2diakZOyTOpg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CLrFM85mVGfHQm2+by2bAeL/8MdTDIqgXxZyMhPD4nqHG9sISUeIvpT3/HP2457bnO5gJN29baNpEueYwmFESZ9fLwA9vyLlHBVNlQR3KMgYJFmScpjJxhtRDzVpS4vKHKR5U88aPkLYOwbYDcDFmXBLBFK2oNZdW8UNq315qwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iktKiwLc; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-566e869f631so4196793a12.0;
        Sun, 10 Mar 2024 11:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710094507; x=1710699307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=32GqZb86xdl8pl2R+sWsYTtlYRodKHkoyREXR2fj+vQ=;
        b=iktKiwLcxruXDZY8htSPjOuT2hL/bFezTottJbJB7X0sLnptrE36DPLhUiYZD/6kOX
         UBkNSW8sQfe1PpBWhKILj63EakOfU49BmCfpzNmZUYLjEz5CxTJpTAwW3iTnLcOj8eRY
         gdkvk4jxGWBDI+TCxfiKBUpsDn5944wY/mTF3Kk/PM7CM0J67XB4OkciZS28uS9oJUic
         mjMvPpkJh9tdies8DiFFuvaflIvmnpOHXeuwMF9IKrf1DJablY6nLXF7n/P41ey+lIxV
         cb/XwJ0K3pWAozs+2BzaIpBzNXwa7Y4EAxYd/c5iX51Mp3mKAJb3fcfNnAjRjr2dUnsf
         2oPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710094507; x=1710699307;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=32GqZb86xdl8pl2R+sWsYTtlYRodKHkoyREXR2fj+vQ=;
        b=g6W4o4CSlO1bBTc0cP7p4ygSQCdKKMtFfBqnRgaEX/8HTleuLZsTE8+Za3ILj1WMO2
         baeNWcplTmq5id24YG6z9MK3bE01q+O2i/Fdrylwt1jsOnxyMXVCiYy1SLp4Pbqbrm7r
         WTzzezraZyEHDj9hDJ4BJDQk1SU3g+sMfyTRiWbzE5sovcJMzOjIDL71Kc0m7CWX/rtn
         7df1O200W/7v55WoU+72X6DGl7yhnfdS8BBP7ycU6zZOGnlyhrS2X/y3ScqrPrjEwgqV
         fFWscUIQuRrnf8MVQBun7Wf51BBGBDmYFklA5lSvmfcy78O9TsbxRJuqD8OxvVn08ySZ
         JYCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXp/hCeRTGMRoFNEKokwzjy8xjo8LIOpdAI2B56XjyQHQAQVygjb75fdrT37tntP0e8LEHy5Tv3H1K6sLionzed+5WLGsN/BS33ctpdwKmbfMarSl3KVEVumcIpWco+rQPS61gQSNbxqtIbIjeR9Ld/bKPGJZHNxVzakd7Be8zFFyppFc5GZBAk+7CM0DMVwHsUReQWyEHEu6xAW77SeVbpYGmxv5m9CgH5Fw==
X-Gm-Message-State: AOJu0Yw0KIXoIjmY3d7H2x+NaxaEWvwI1diGF6YBsBxeIeCnm8L7XQWo
	GUPxqKsU65zi6ENTGMjlHqD3hhaQ+tqqHKfypEX8LT/YXvbUYD/0
X-Google-Smtp-Source: AGHT+IFx68n6jNr1zIKBJD/BxfVjafadWsECNhDnTljRKjxnWDsHpA1I845YqQzdNSKFCj15Rpztgw==
X-Received: by 2002:a50:cd18:0:b0:566:ef8:93f6 with SMTP id z24-20020a50cd18000000b005660ef893f6mr3556714edi.0.1710094506863;
        Sun, 10 Mar 2024 11:15:06 -0700 (PDT)
Received: from localhost.localdomain ([94.120.90.19])
        by smtp.gmail.com with ESMTPSA id q17-20020a056402033100b00566d6e30f1fsm2074601edw.31.2024.03.10.11.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 11:15:06 -0700 (PDT)
From: mustafa <mustafa.eskieksi@gmail.com>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	mustafa.eskieksi@gmail.com,
	jdelvare@suse.com,
	linux@roeck-us.net,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	pavel@ucw.cz,
	lee@kernel.org,
	linux-leds@vger.kernel.org
Cc: rishitbansal0@gmail.com
Subject: [PATCH v3 0/1] platform/x86: Add wmi driver for Casper Excalibur laptops
Date: Sun, 10 Mar 2024 21:14:28 +0300
Message-ID: <20240310181429.59451-1-mustafa.eskieksi@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Mustafa Ekşi <mustafa.eskieksi@gmail.com>

Hi,
I apologize for the delay. I submitted v2 in a hurry and it was
catastrophic (especially the subject), so I didn't want the same thing to
happen in v3.

On 23.02.2024 13:14, Ilpo Järvinen wrote:
> However, I still suspect this is wrong way to do RGB leds and the multi_*
> sysfs interface is the way you should use.
I was skeptical about using multicolor because it said it wasn't a good
fit for rgb drivers in drivers/leds/TODO but after I read the thread about
hp omen backlight driver support, I changed my mind. Hp omen's keyboard
backlight is very similar to Casper's keyboard backlight. And probably
TODO file meant "per key rgb"s and not zoned rgbs.
I think Rishit's' driver didn't get into mainline but I still liked the
API he used so I decided to use the same API.
Driver creates 4 different led_classdev_mc devices:
> casper::kbd_zoned_backlight-right/
> casper::kbd_zoned_backlight-middle/
> casper::kbd_zoned_backlight-left/
> casper::kbd_zoned_backlight-corners/
right, middle, and left leds share the same brightness but the corners
led doesn't.
I found a way to get the brightness level from the hardware, so it shows
the correct brightness when it is changed via keyboard shortcut. But
still, there's most likely no way to get color data from firmware,
Windows driver uses a Windows registry (as a cache) for same reason.

I seek your advice on how to support "led modes". It is very different
from led_pattern. It is not possible to change the interval, or anything.
This version has an enum called casper_led_mode:
> enum casper_led_mode {
>        LED_NORMAL = 0x10,
>        LED_BLINK = 0x20,
>        LED_FADE = 0x30,
>        LED_HEARTBEAT = 0x40,
>        LED_REPEAT = 0x50,
>        LED_RANDOM = 0x60
> };
For example, random mode assigns random colors to leds every second. Fade
mode slowly fades out brightness and then fades in. I thought of creating
an attribute but working with multiple leds seemed uneasy.

And also this multicolor approach doesn't include a way to set all
keyboard leds all at once (like Rishit's driver). This can create long
delays when a userspace program (like OpenRGB) sets all keyboard leds
to user configuration.

On 23.02.2024 03:13, Guenter Roeck wrote:
>> +        return -ENODEV;
>> +    hwmon_dev = devm_hwmon_device_register_with_info(&wdev->dev,
>> +                        "casper_wmi", wdev,
>> +                        &casper_wmi_hwmon_chip_info,
>> +                        NULL);
>> +    return PTR_ERR_OR_ZERO(hwmon_dev);
>
> Why use devm_hwmon_device_register_with_info() but not
> devm_led_classdev_register() ?
I use devm for everything now, and I think it unregisters them if probe
returns -ENODEV, I tested it with hwmon and it didn't crash and
unregistered successfully.

On 23.02.2024 05:54, Kuppuswamy Sathyanarayanan wrote:
>> +static umode_t casper_wmi_hwmon_is_visible(const void *drvdata,
>> +					   enum hwmon_sensor_types type,
>> +					   u32 attr, int channel)
>> +{
>> +	switch (type) {
>> +	case hwmon_fan:
>> +		return 0444;
>
> How about S_IRUSR | S_IRGRP | S_IROTH ?
checkpatch.pl suggests me to not use those macros:
> SYMBOLIC_PERMS: Symbolic permissions 'S_IRUSR | S_IRGRP | S_IROTH'
> are not preferred. Consider using octal permissions '0444'.
So I think it is better to use octal permissions.

On 23.02.2024 13:14, Ilpo Järvinen wrote:
> v1 -> v2 changelog is missing from here!
I added both v2 and v3 changelog in this patch.

On 23.02.2024 13:14, Ilpo Järvinen wrote:
>> +	acpi_status ret = wmidev_block_set(wdev, 0, &input);
> Put the declaration separately into the declarations block:
>
> 	acpi_status ret;
>
> 	ret = wmidev_block_set(wdev, 0, &input);
I followed this except with to_wmi_device and container_of because
you also put to_wmi_device in the declaration block.

Link to Rishit Bansal's thread:
https://lore.kernel.org/lkml/20230131235027.36304-1-rishitbansal0@gmail.com/

Thanks for your reviews and patience,
Mustafa Ekşi

Mustafa Ekşi (1):
  platform/x86: Add wmi driver for Casper Excalibur laptops

 MAINTAINERS                       |   6 +
 drivers/platform/x86/Kconfig      |  14 +
 drivers/platform/x86/Makefile     |   1 +
 drivers/platform/x86/casper-wmi.c | 639 ++++++++++++++++++++++++++++++
 4 files changed, 660 insertions(+)
 create mode 100644 drivers/platform/x86/casper-wmi.c

-- 
2.44.0



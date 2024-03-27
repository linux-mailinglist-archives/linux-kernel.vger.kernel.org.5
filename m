Return-Path: <linux-kernel+bounces-121875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB2B88EED4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3427C280FBF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8562814D42C;
	Wed, 27 Mar 2024 19:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iu58nxUi"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715E6150983;
	Wed, 27 Mar 2024 19:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711566187; cv=none; b=gs8ZbbMvGNSL8eusSvQQVAMv8g5RL/3sALY3OFcjUNxGCB0DNnpST16uoQZBSXtqdyNV1yVaZY9AcG8QuTLiHZB2iDS+83JI/4J7TP2g1NkeK4sTzcEtrr/GsFSFo1TsG8dk+fR0CCOOqbBbGp9ckWPslm7HPJgrbC/WRcSnHLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711566187; c=relaxed/simple;
	bh=7tGP5Yx28ma+MeXsuiagnEfceXRF58+ITcV8jHkkQcw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=XvxACrGm5NKSzEeYtQelyQ8gElxp8Bhn/I33MwByiGY3WS7nHw+0/O+Lkh2INBL/UujNcHVPKHU4sHS1CWK/8N7+2h7bhVNmN5i1sJiGBH/VoBZmitglSO8rrxHqzpLC/eK4OpGx3iaVsNPBfLcQwKoRIO708eQ2Casjezy33ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iu58nxUi; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4149746f80aso1024015e9.1;
        Wed, 27 Mar 2024 12:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711566184; x=1712170984; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dCQNhIetTJ8dJ+pvLEKVctT07st05bOCf57ar6v1H74=;
        b=iu58nxUipyFK9uUwxozaQAg2AhJ4y4sPpinRiQi2qjXg762URM+lCUxSXm6TioAIJY
         UWw/I4kKUmhYpXt6NpY5bpRkPj8m0RmFqf/2KSoLnHk0VVFD4KSqKhgIk8rfLWMThTlP
         SgwGOix4P60cqiaJXa+J5LBLTxdUGHUtLBflNmoZgcTGycrZbGViw48EttcwAGTcOXGp
         jcLrIU70aBoNdWxfNxVZrMOhNLzrEJG8yvrgvdWxCCQzkGtaatV1E0QRAagC3p3y/nTt
         soagFPExj9tEBQfDq5zZqihohUEyNn6C1arEUiNwEOVViMyGaQX14/a2lGSjuaJpCa5b
         d8XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711566184; x=1712170984;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dCQNhIetTJ8dJ+pvLEKVctT07st05bOCf57ar6v1H74=;
        b=igCHxEXG3JjV1dozKoU7Dc6Y+bn5hWkYgB7YKTokl2uCRHRG/BuixGl/9ba2NXCx3U
         E3vVQd1TuLHAUvL+bQkNk3Ic2as5sRW60jOHZlY4EX+DoGsorSXp9IuDo4I5+MtDtwQ/
         csKFvMeByoariQh3Tk1aG7bDqsToi/N+u/9CxOjJDz7L/V7ZhZePRhcige2Q0K6eeISF
         mnqHQj+EVx5sT1EBaqeaLOfXsOY7s1i9rSui2phbcLNcNg/zKASerySUl+tdPCLD/SBY
         RUfVBAaAk6Gl87AU2e/luJIB+9mNkW04IYisJGVloYIvEmJ/IY5qngIUZHJ98VsYTrO4
         VOHA==
X-Forwarded-Encrypted: i=1; AJvYcCVfccZejuqRzvZG+a1B03FTrNy6ASRTKwI+KmKRSiewuebuKcCGyvN+ZnvgNizCC6j/Liq4Mxh2DXwek/6NJkb81xpKlTxnmXx9n62gOwon97ECYK1lAViV/gx2/Uxt3zqDZx7Bn0jPTqBLFTYg3JmK2Q==
X-Gm-Message-State: AOJu0YzPblbhkR4UwMOZrLr4o7WOyu0t24eYMg6h36QmOJRvjPay+0b4
	jLtvGYs4kgS5GRgmQQc5YLcuzHMPoMorYXaH87+qcrRG261I5nfroovfkA/y6uHT0Q==
X-Google-Smtp-Source: AGHT+IHF6SdKCaaAFsMOJ9ztw4rgjkCSIcK223yBchR0f0uzh8AFVcFaTMAY8GEi1kGSH1JGFynVXA==
X-Received: by 2002:a05:600c:2109:b0:414:7e1b:8aac with SMTP id u9-20020a05600c210900b004147e1b8aacmr703353wml.38.1711566183395;
        Wed, 27 Mar 2024 12:03:03 -0700 (PDT)
Received: from ?IPV6:2001:8a0:ed72:2800:4fbb:3beb:7045:e257? ([2001:8a0:ed72:2800:4fbb:3beb:7045:e257])
        by smtp.gmail.com with ESMTPSA id h17-20020a05600c351100b0041468961233sm2940538wmq.35.2024.03.27.12.03.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 12:03:02 -0700 (PDT)
Message-ID: <5181e9fa-2acc-4bc3-9f22-77ec519941ac@gmail.com>
Date: Wed, 27 Mar 2024 19:03:01 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] HP: wmi: added support for 4 zone keyboard rgb
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <20240324180549.148812-1-carlosmiguelferreira.2003@gmail.com>
 <980459bc-a781-1d2b-374c-da023d601c58@linux.intel.com>
 <998ee474-5e0c-4877-8a95-b22b0edd7837@gmail.com>
 <69e28674-58b8-4e77-b4b1-033ccb7e4dce@linux.intel.com>
Content-Language: en-US
Cc: hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Carlos Ferreira <carlosmiguelferreira.2003@gmail.com>
In-Reply-To: <69e28674-58b8-4e77-b4b1-033ccb7e4dce@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/27/24 1:05 PM, Ilpo Järvinen wrote:

> On Tue, 26 Mar 2024, Carlos Ferreira wrote:
> 
>> Hi, i have changed some of the code. How does it look now?
>>
>> Signed-off-by: Carlos Ferreira <carlosmiguelferreira.2003@gmail.com>
>> ---
> 
> First of all, you need to make a proper submission with versioning, that 
> is:
> 
> - Put version into the subject: PATCH v2
> - Don't put extra stuff into changelog like the above question, if you 
> need to ask something, put your question underneath the first --- line.
> - List the changes you made underneath the first --- line (see ML 
> archives for examples about formatting)

Should i submit the v2 patch with the current state or with the changes suggested such as the use of the leds API?

>>  drivers/platform/x86/hp/hp-wmi.c | 251 +++++++++++++++++++++++++++++--
>>  1 file changed, 241 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
>> index e53660422..8108ca7e9 100644
>> --- a/drivers/platform/x86/hp/hp-wmi.c
>> +++ b/drivers/platform/x86/hp/hp-wmi.c
>> @@ -27,6 +27,7 @@
>>  #include <linux/rfkill.h>
>>  #include <linux/string.h>
>>  #include <linux/dmi.h>
>> +#include <linux/bitfield.h>
> 
> Try to put it earlier, these should eventually be in alphabetic order 
> (again, ordered by a separate patch, not this one).

You mean organizing all the imports like this?
#include <linux/acpi.h>
#include <linux/bitfield.h>
#include <linux/dmi.h>
#include <linux/hwmon.h>
#include <linux/init.h>
#include <linux/input.h>
#include <linux/input/sparse-keymap.h>
#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/platform_device.h>
#include <linux/platform_profile.h>
#include <linux/rfkill.h>
#include <linux/slab.h>
#include <linux/string.h>
#include <linux/types.h>

>>  MODULE_AUTHOR("Matthew Garrett <mjg59@srcf.ucam.org>");
>>  MODULE_DESCRIPTION("HP laptop WMI hotkeys driver");
>> @@ -40,6 +41,10 @@ MODULE_ALIAS("wmi:5FB7F034-2C63-45e9-BE91-3D44E2C707E4");
>>  #define HP_OMEN_EC_THERMAL_PROFILE_OFFSET 0x95
>>  #define zero_if_sup(tmp) (zero_insize_support?0:sizeof(tmp)) // use when zero insize is required
>>  
>> +#define FOURZONE_LIGHTING_SUPPORTED_BIT 0x01
>> +#define FOURZONE_LIGHTING_ON  228
>> +#define FOURZONE_LIGHTING_OFF 100
>> +
>>  /* DMI board names of devices that should use the omen specific path for
>>   * thermal profiles.
>>   * This was obtained by taking a look in the windows omen command center
>> @@ -131,18 +136,36 @@ enum hp_wmi_commandtype {
>>  };
>>  
>>  enum hp_wmi_gm_commandtype {
>> -	HPWMI_FAN_SPEED_GET_QUERY = 0x11,
>> -	HPWMI_SET_PERFORMANCE_MODE = 0x1A,
>> -	HPWMI_FAN_SPEED_MAX_GET_QUERY = 0x26,
>> -	HPWMI_FAN_SPEED_MAX_SET_QUERY = 0x27,
>> -	HPWMI_GET_SYSTEM_DESIGN_DATA = 0x28,
>> +	HPWMI_FAN_SPEED_GET_QUERY	= 0x11,
>> +	HPWMI_SET_PERFORMANCE_MODE	= 0x1A,
>> +	HPWMI_FAN_SPEED_MAX_GET_QUERY	= 0x26,
>> +	HPWMI_FAN_SPEED_MAX_SET_QUERY	= 0x27,
>> +	HPWMI_GET_SYSTEM_DESIGN_DATA	= 0x28,
>> +	HPWMI_GET_KEYBOARD_TYPE		= 0x2B,
>> +};
>> +
>> +enum hp_wmi_fourzone_commandtype {
>> +	HPWMI_SUPPORTS_LIGHTNING = 0x01,
>> +	HPWMI_FOURZONE_COLOR_GET = 0x02,
>> +	HPWMI_FOURZONE_COLOR_SET = 0x03,
>> +	HPWMI_FOURZONE_MODE_GET  = 0x04,
>> +	HPWMI_FOURZONE_MODE_SET  = 0x05,
>> +};
>> +
>> +enum hp_wmi_keyboardtype {
>> +	HPWMI_KEYBOARD_INVALID        = 0x00,
>> +	HPWMI_KEYBOARD_NORMAL         = 0x01,
>> +	HPWMI_KEYBOARD_WITH_NUMPAD    = 0x02,
>> +	HPWMI_KEYBOARD_WITHOUT_NUMPAD = 0x03,
>> +	HPWMI_KEYBOARD_RGB	      = 0x04,
>>  };
>>  
>>  enum hp_wmi_command {
>> -	HPWMI_READ	= 0x01,
>> -	HPWMI_WRITE	= 0x02,
>> -	HPWMI_ODM	= 0x03,
>> -	HPWMI_GM	= 0x20008,
>> +	HPWMI_READ     = 0x01,
>> +	HPWMI_WRITE    = 0x02,
>> +	HPWMI_ODM      = 0x03,
>> +	HPWMI_GM       = 0x20008,
>> +	HPWMI_FOURZONE = 0x20009,
>>  };
>>  
>>  enum hp_wmi_hardware_mask {
>> @@ -652,6 +675,74 @@ static int hp_wmi_rfkill2_refresh(void)
>>  	return 0;
>>  }
>>  
>> +static int fourzone_get_colors(u32 *colors)
>> +{
>> +	int ret;
>> +	u8 buff[128];
>> +
>> +	ret = hp_wmi_perform_query(HPWMI_FOURZONE_COLOR_GET, HPWMI_FOURZONE,
>> +				   &buff, sizeof(buff), sizeof(buff));
>> +	if (ret != 0)
>> +		return -EINVAL;
>> +
>> +	for (int i = 0; i < 4; i++) {
>> +		colors[3 - i] = FIELD_PREP(GENMASK(23, 16), buff[25 + i * 3])	   // r
>> +			      |	FIELD_PREP(GENMASK(15, 8),  buff[25 + i * 3 + 1])  // g
>> +			      | FIELD_PREP(GENMASK(7, 0),   buff[25 + i * 3 + 2]); // b
> 
> Those GENMASK() calls should be done in #define and only used here:
> 
> #define FOURZONE_COLOR_R		GENMASK(23, 16)
> #define FOURZONE_COLOR_G		GENMASK(15, 8)
> #define FOURZONE_COLOR_B		GENMASK(7, 0)
> 
> You can then drop the comments because the code is self-explanatory.
> 
> Add #include <linux/bits.h>.
> 
> ...But please see my comments about multicolor below.
> 
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int fourzone_set_colors(u32 *colors)
>> +{
>> +	int ret;
>> +	u8 buff[128];
>> +
>> +	ret = hp_wmi_perform_query(HPWMI_FOURZONE_COLOR_GET, HPWMI_FOURZONE,
>> +				   &buff, sizeof(buff), sizeof(buff));
>> +	if (ret != 0)
>> +		return -EINVAL;
>> +
>> +	for (int i = 0; i < 4; i++) {
>> +		buff[25 + i * 3]     = FIELD_GET(GENMASK(23, 16), colors[3 - i]); // r
>> +		buff[25 + i * 3 + 1] = FIELD_GET(GENMASK(15, 8),  colors[3 - i]); // g
>> +		buff[25 + i * 3 + 2] = FIELD_GET(GENMASK(7, 0),	  colors[3 - i]); // b
>> +	}
>> +	return hp_wmi_perform_query(HPWMI_FOURZONE_COLOR_SET, HPWMI_FOURZONE,
>> +				    &buff, sizeof(buff), sizeof(buff));
>> +}
>> +
>> +/*
>> + * Returns a negative number on error or 0/1 for the mode.
>> + */
>> +static int fourzone_get_mode(void)
>> +{
>> +	int ret;
>> +	u8 buff[4];
> 
> Try to use reverse xmas tree order where possible (go through the other 
> functions too).
> 
>> +
>> +	ret = hp_wmi_perform_query(HPWMI_FOURZONE_MODE_GET, HPWMI_FOURZONE,
>> +				   &buff, sizeof(buff), sizeof(buff));
>> +	if (ret != 0)
>> +		return ret;
>> +
>> +	return buff[0] == FOURZONE_LIGHTING_ON ? 1 : 0;
>> +}
>> +
>> +/*
>> + * This device supports only two different modes:
>> + * 1 -> lights on
>> + * 0 -> lights off
>> + */
>> +static int fourzone_set_mode(u32 mode)
>> +{
>> +	u8 buff[4] = {mode ? FOURZONE_LIGHTING_ON : FOURZONE_LIGHTING_OFF, 0, 0, 0};
>> +
>> +	return hp_wmi_perform_query(HPWMI_FOURZONE_MODE_SET, HPWMI_FOURZONE,
>> +				    &buff, sizeof(buff), 0);
>> +}
>> +
>>  static ssize_t display_show(struct device *dev, struct device_attribute *attr,
>>  			    char *buf)
>>  {
>> @@ -754,6 +845,58 @@ static ssize_t postcode_store(struct device *dev, struct device_attribute *attr,
>>  	return count;
>>  }
>>  
>> +static ssize_t colors_show(struct device *dev, struct device_attribute *attr,
>> +			    char *buf)
>> +{
>> +	int ret;
>> +	u32 colors[4];
>> +
>> +	ret = fourzone_get_colors(colors);
>> +	if (ret != 0)
>> +		return -EINVAL;
>> +
>> +	return sysfs_emit(buf, "%06x %06x %06x %06x\n", colors[0], colors[1], colors[2], colors[3]);
>> +}
>> +
>> +static ssize_t colors_store(struct device *dev, struct device_attribute *attr,
>> +				const char *buf, size_t count)
>> +{
>> +	int ret;
>> +	u32 colors[4];
>> +
>> +	ret = sscanf(buf, "%6x %6x %6x %6x", &colors[0], &colors[1], &colors[2], &colors[3]);
>> +	if (ret != 4)
>> +		return -EINVAL;
> 
> I now realize this should use leds multicolor API instead.
> 
>> +	ret = fourzone_set_colors(colors);
>> +	return ret == 0 ? count : ret;
>> +}
>> +
>> +static ssize_t mode_show(struct device *dev, struct device_attribute *attr,
>> +			    char *buf)
>> +{
>> +	u32 ret = fourzone_get_mode();
>> +
>> +	if (ret < 0)
> 
> Please don't save one line like this, put the declaration on own 
> line/declaration block so you can keep function call and it's error 
> handling next to each other.
> 
> Also, compiler should have warned you here because u32 is not the correct 
> type and you're checking for < 0!
> 
>> +		return ret;
>> +
>> +	return sysfs_emit(buf, "%d\n", ret);
>> +}
>> +
>> +static ssize_t mode_store(struct device *dev, struct device_attribute *attr,
>> +				const char *buf, size_t count)
>> +{
>> +	int ret;
>> +	u32 mode;
>> +
>> +	ret = kstrtou32(buf, 10, &mode);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = fourzone_set_mode(mode);
>> +	return ret == 0 ? count : ret;
>> +}
>> +
>>  static int camera_shutter_input_setup(void)
>>  {
>>  	int err;
>> @@ -781,6 +924,34 @@ static int camera_shutter_input_setup(void)
>>  	return err;
>>  }
>>  
>> +static enum hp_wmi_keyboardtype fourzone_get_keyboard_type(void)
>> +{
>> +	int ret;
>> +	u8 buff[128];
>> +
>> +	ret = hp_wmi_perform_query(HPWMI_GET_KEYBOARD_TYPE, HPWMI_GM,
>> +				   &buff, sizeof(buff), sizeof(buff));
>> +	if (ret != 0)
>> +		return HPWMI_KEYBOARD_INVALID;
>> +
>> +	/* the first byte in the response represents the keyboard type */
>> +	return (enum hp_wmi_keyboardtype)(buff[0] + 1);
>> +}
>> +
>> +static ssize_t type_show(struct device *dev, struct device_attribute *attr,
>> +			    char *buf)
>> +{
>> +	enum hp_wmi_keyboardtype type = fourzone_get_keyboard_type();
>> +
>> +	if (type == HPWMI_KEYBOARD_INVALID)
>> +		return -EINVAL;
>> +
>> +	return sysfs_emit(buf, "%d\n", type - 1);
> 
> These are always positive, right? So %u is better.
> 
>> +}
>> +
>> +/*
>> + * Generic device attributes.
>> + */
>>  static DEVICE_ATTR_RO(display);
>>  static DEVICE_ATTR_RO(hddtemp);
>>  static DEVICE_ATTR_RW(als);
>> @@ -797,7 +968,35 @@ static struct attribute *hp_wmi_attrs[] = {
>>  	&dev_attr_postcode.attr,
>>  	NULL,
>>  };
>> -ATTRIBUTE_GROUPS(hp_wmi);
>> +
>> +static struct attribute_group hp_wmi_group = {
>> +	.attrs = hp_wmi_attrs,
>> +};
>> +
>> +/*
>> + * Omen fourzone specific device attributes.
>> + */
>> +static DEVICE_ATTR_RW(colors);
>> +static DEVICE_ATTR_RW(mode);
>> +static DEVICE_ATTR_RO(type);
>> +
>> +static struct attribute *hp_wmi_fourzone_attrs[] = {
>> +	&dev_attr_colors.attr,
>> +	&dev_attr_mode.attr,
>> +	&dev_attr_type.attr,
>> +	NULL,
>> +};
>> +
>> +static struct attribute_group hp_wmi_fourzone_group = {
>> +	.attrs = hp_wmi_fourzone_attrs,
>> +	.name = "kbd-backlight",
>> +};
>> +
>> +static const struct attribute_group *hp_wmi_groups[] = {
>> +	&hp_wmi_group,
>> +	NULL,
>> +	NULL,
>> +};
>>  
>>  static void hp_wmi_notify(u32 value, void *context)
>>  {
>> @@ -1446,6 +1645,35 @@ static int thermal_profile_setup(void)
>>  	return 0;
>>  }
>>  
>> +static bool fourzone_supports_lighting(void)
>> +{
>> +	int ret;
>> +	u8 buff[128];
>> +
>> +	ret = hp_wmi_perform_query(HPWMI_SUPPORTS_LIGHTNING, HPWMI_FOURZONE,
>> +				   &buff, sizeof(buff), sizeof(buff));
>> +	if (ret != 0)
> 
> < 0 ?
> 


Return-Path: <linux-kernel+bounces-49637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D562846D37
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9400A1C27A7C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8EB578B6B;
	Fri,  2 Feb 2024 10:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="VyfW0C3f"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1C533990;
	Fri,  2 Feb 2024 10:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706868099; cv=none; b=drEzF7mW9DW+l+pDczm1ivOSUBsj3dUfAg46KJbPTV6dc5KtGkQzM0316tWha8pam2emzQmpsXeFaJJmfP8HAwXm7htEZnG/Ku1zrb+o9xUN6dcOGcHKwKhSLIem4rT6hJSkjVHEYHwmqEFocNIHkBSU7N1MXeJvNwRYhsnPMA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706868099; c=relaxed/simple;
	bh=iAeX2V1R4iOUtvH22ZujrykVDWSHb4t4vjjKCuU9whE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VQnZWNXK8isXTi5sgUvOAiTiAy8LF3DpQTLmMkCZ56Wu8mwI+b0JgS/KltiOWRA0hVIqdGs45Ez3J1c/BjjN75zaT+xOOAPaH+okeMuZ+m8l4NIy/GbeIBkXMs0VbjmKx8PjCUTvb9GX80qq5c0TJ/ZLJPqxcZuODy3pMXWDJAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=VyfW0C3f; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706868095;
	bh=iAeX2V1R4iOUtvH22ZujrykVDWSHb4t4vjjKCuU9whE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VyfW0C3f9keG8ojus4cmEQwMN2EnvI0tIVvsA3Ii/GpmHw52bLje/tXn4xbuY+eoS
	 4M375eeVut0YoxOaeYzVXArtC5/U294a4MzKp2BRqiawtSK/O7PN1qB1SMv6SkV7tf
	 aQIW9GsEJsx6T+zqmu9gDz4wpywo0ZNjyZ0DD0cz+Xvx/cFGAirIpynFCE8s7kSFuh
	 uB4FzeE66vah56gdra09tuqVP3cIRAPUl2ItzW3+kH/DjdI3bj3mrrUOalNqj/Cby+
	 77J4DT9DLWw6weO8aZDyH80I2FDdSr4pvi7jrhhidNiCaWiK7/QhkdzgIsDZQKzm/O
	 b3sdnfbEzAvSg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 62213378047F;
	Fri,  2 Feb 2024 10:01:33 +0000 (UTC)
Message-ID: <6f8021d5-50af-40c5-983e-cd203b1b3683@collabora.com>
Date: Fri, 2 Feb 2024 11:01:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/18] thermal: core: Change governor name to const
 char pointer
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: daniel.lezcano@linaro.org, miquel.raynal@bootlin.com,
 rui.zhang@intel.com, lukasz.luba@arm.com, support.opensource@diasemi.com,
 shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
 festevam@gmail.com, linux-imx@nxp.com, andersson@kernel.org,
 konrad.dybcio@linaro.org, amitk@kernel.org, thara.gopinath@gmail.com,
 niklas.soderlund@ragnatech.se, srinivas.pandruvada@linux.intel.com,
 baolin.wang@linux.alibaba.com, u.kleine-koenig@pengutronix.de,
 hayashi.kunihiko@socionext.com, d-gole@ti.com, linus.walleij@linaro.org,
 DLG-Adam.Ward.opensource@dm.renesas.com, error27@gmail.com, heiko@sntech.de,
 hdegoede@redhat.com, jernej.skrabec@gmail.com, f.fainelli@gmail.com,
 bchihi@baylibre.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, kernel@collabora.com
References: <20240130111250.185718-1-angelogioacchino.delregno@collabora.com>
 <20240130111250.185718-2-angelogioacchino.delregno@collabora.com>
 <CAJZ5v0hOcS0Fm2-mKWtc1-0ym33XuH=B39GGL9b6MfGSqeERkQ@mail.gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAJZ5v0hOcS0Fm2-mKWtc1-0ym33XuH=B39GGL9b6MfGSqeERkQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 01/02/24 19:37, Rafael J. Wysocki ha scritto:
> On Tue, Jan 30, 2024 at 12:13 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> All users are already assigning a const char * to the `governor_name`
>> member of struct thermal_zone_params and to the `name` member of
>> struct thermal_governor.
>> Even if users are technically wrong, it just makes more sense to change
>> this member to be a const char pointer instead of doing the other way
>> around.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> Acked-by: Rafael J. Wysocki <rafael@kernel.org>
> 
> or I can pick it up right away if you want me to do that.
> 

I appreciate having less patches to carry over with new series versions.

Whatever you can take, please feel free to pick directly :-)

Thanks,
Angelo

>> ---
>>   include/linux/thermal.h | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
>> index b7a3deb372fd..65d8f92a9a0d 100644
>> --- a/include/linux/thermal.h
>> +++ b/include/linux/thermal.h
>> @@ -214,7 +214,7 @@ struct thermal_zone_device {
>>    * @governor_list:     node in thermal_governor_list (in thermal_core.c)
>>    */
>>   struct thermal_governor {
>> -       char name[THERMAL_NAME_LENGTH];
>> +       const char *name;
>>          int (*bind_to_tz)(struct thermal_zone_device *tz);
>>          void (*unbind_from_tz)(struct thermal_zone_device *tz);
>>          int (*throttle)(struct thermal_zone_device *tz,
>> @@ -226,7 +226,7 @@ struct thermal_governor {
>>
>>   /* Structure to define Thermal Zone parameters */
>>   struct thermal_zone_params {
>> -       char governor_name[THERMAL_NAME_LENGTH];
>> +       const char *governor_name;
>>
>>          /*
>>           * a boolean to indicate if the thermal to hwmon sysfs interface
>> --



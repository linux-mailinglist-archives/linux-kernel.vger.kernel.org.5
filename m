Return-Path: <linux-kernel+bounces-49630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A915D846D22
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C20F21C2648F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A07F78B78;
	Fri,  2 Feb 2024 09:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="y4448Zhj"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F4F77F2F;
	Fri,  2 Feb 2024 09:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706867908; cv=none; b=DmsKYblcby2220tLGxLT//xbM+8N7mYuALdeUHJmNnhCOeOajPF+y9GtpVKMugWZG6SuQfaPul3/it8F+G3Jb3/hJPlUEoOEW0g1MBtDfex9fpH3VdkIhxGMphWfq74t2BZxYUJ6a5tu36vMYx2SUqRMNMOb3sYIsKeKCdG0XhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706867908; c=relaxed/simple;
	bh=3yoKAEkp7fZQnp9uYTICy3qIfHawRJiuCLjeE8sbj0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YZcx4EOPmUGfBoh+bTkZEQTI1gcmr0oJQgwxl2S9R3aNBt2snuThaZjkQ+CT84OLrW5PKYwRZ/I79Uwovh63Xw/Cp3NYCAKQ1bY5HENA5MwRRWqAjVV/NtHaacWLjwnCCUbtoElhXlbqhVPz3tq6fKeiAOISkxhBCh1CMeT9z74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=y4448Zhj; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706867898;
	bh=3yoKAEkp7fZQnp9uYTICy3qIfHawRJiuCLjeE8sbj0c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=y4448ZhjZZloNj+kMKSQSwoQtCJJUIK9QZLHw0xdMR7nL5vjxTJeatrWdCvunuMap
	 f2CNLpwG1HV/NJf+mEvNtqf9ikfuYvjEuwOOcavGk1XZSWZDPxQBgoD2YKe414xSMZ
	 hzSMLKUo89SZVsbxubMAsXQdgULWBzpHRU0vw83mONBd+n2YAkxWwns6Azq9ORN9Gp
	 u4Oy0NpNOGWihvBslBgNVd440TzQUWfHpxT5+NShhm+kHhGXLbhEsrXa00qFVJ9NeX
	 6Vg9Y/Zilhu49Zc1SyDjWMHAW0TvvfZneaMAThVws24jH0VXKtLpVWt3pL9OSIesbk
	 t4TEg7l1hqrXA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5582A3782053;
	Fri,  2 Feb 2024 09:58:16 +0000 (UTC)
Message-ID: <923499c2-1a60-42dc-b0e2-3f7d78de9d8a@collabora.com>
Date: Fri, 2 Feb 2024 10:58:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/18] Thermal: Part 1 - Introduce new structs and
 registration
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
 <CAJZ5v0haFEGOjaMC4a8CZbQe+cxFfaB1hD60NkN297NY2TZB5A@mail.gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAJZ5v0haFEGOjaMC4a8CZbQe+cxFfaB1hD60NkN297NY2TZB5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 01/02/24 19:35, Rafael J. Wysocki ha scritto:
> On Tue, Jan 30, 2024 at 12:13 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> This series is a preparation for a bigger cleanup that will be split in
>> three parts in order to avoid immutable branches on multiple subsystems,
>> as in other parts of this series there will be changes in:
>> - drivers/acpi
>> - drivers/platform/x86
>> - drivers/power/supply
>> - drivers/net/wireless
>> - drivers/net/ethernet
>>
>> This is the first part which adds new structures and starts reorganizing
>> struct members around, plus, this migrates all of the thermal drivers
>> found in drivers/thermal/ to the new thermal_zone_device_register()
>> function, and advertises that the old registration functions are
>> deprecated and will be removed.
>>
>> The reorganization is supposed to be complete (or mostly) but...
>>   - struct thermal_zone_platform_params has a temporary name:
>>     this is done in order to avoid compile time failures for
>>     the drivers outside of drivers/thermal before migrating
>>     them to thermal_zone_device_params/thermal_zone_device_register();
>>   - struct thermal_zone_params temporarily has two duplicated members,
>>     governor_name and no_hwmon;
>>
>> Part 2 of this topic will migrate all drivers that are external to
>> drivers/thermal to thermal_zone_device_register(); I will send that
>> part only after part 1 is confirmed to be acceptable, as otherwise
>> I'd be spamming people for no reason :-)
>>
>> After all drivers will be migrated to thermal_zone_device_register(),
>> we won't have to care about changing anything outside of drivers/thermal
>> to finish this set of cleanups/changes (and no immutable branches needed)
>> and this means that...
>> Part 3 of this topic will contain the following changes:
>>   - thermal_zone_device_register_with_trips() will be removed
>>   - thermal_tripless_zone_device_register() will be removed
>>   - thermal_zone_params will be renamed to thermal_governor_ipa_params
>>     - governor_name, no_hwmon members will be removed
>>   - thermal_zone_platform_params will be renamed to thermal_zone_params
>>   - Removal of the THERMAL_NAME_LENGTH limitation for `type`
>>
>> More scheduled changes, which should end up in part 3 (at least that's
>> my intention), or eventually entirely after this cleanup topic, include:
>>   - Introduction of Thermal Zone names
>>   - Disambiguation of TZ name and type
>>   - Addition of `thermal-zones`, `thermal-zone-names` parsing for
>>     devicetrees
> 
> You really should start with this, because that's your goal.
> 
> It is quite arguable that it can be achieved without making all of the
> changes mentioned above.
> 

Actually, my initial idea was exactly that... but then there were some
discussions around it, please check [1] for the thermal-zone-names, and
[2] for the rest of the discussion.

[1]: https://lore.kernel.org/all/8d42e0f5-b2d2-471b-ada9-79f76c637abe@collabora.com/

[2]: https://lore.kernel.org/all/4dd4ac79-e8bc-4d88-92d6-6061dae42092@collabora.com/

>>
>> ... Summarizing ...
>>
>> Part 1:
>>   - Reorganize structures (some temporary names/leftovers)
>>   - New registration function, deprecation of old ones
>>   - Migration of drivers/thermal drivers to new registration
> 
> I kind of see where this is going, but I don't agree with some of the
> changes made.
> 
> Let me comment on individual patches (which is not necessarily going
> to happen today or even tomorrow, so let me go through the entire
> series before deciding what to do next).
> 

Sure, thanks for your feedback!

Cheers,
Angelo



Return-Path: <linux-kernel+bounces-61338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A937485113F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DACF71C222D1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F68822F0C;
	Mon, 12 Feb 2024 10:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="C80BftAR"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5417738DDD;
	Mon, 12 Feb 2024 10:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707734509; cv=none; b=HZ/2i82i451g2BcYgHUmYOFPpgVATX6j1EfQY3MbJ42fdAH5RU1K7TNjAYX00kaI6MIyZCl4fHWyUAp85Y7lmTigHgdahpDVUkK4tQQeT06/UhOQhLKSpGwgBJgl0AiEDS3vsBFpnV5FBq150F9Paz3oK878+uaSm2f4tW2sm5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707734509; c=relaxed/simple;
	bh=PhktcjZp3ec2RQQV6BGAadFKl5P5K7d8y3PPtC/Q+Yw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PldeFDMyJLTA1cYozd94VHSHAiSCc9jvBOwuvIQ6o0BZvJqgm3ITott4u8pu1RvwUg8nci7+S1u3gTsypIgHVyoMPGgDBRLafvJTl1abp3Ydov//b/0mzRzIMPwgSKoeQdlXcW+CBGNEW9Kq+j9uYLhzTfH9mvqo67Pl2KYADlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=C80BftAR; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707734506;
	bh=PhktcjZp3ec2RQQV6BGAadFKl5P5K7d8y3PPtC/Q+Yw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=C80BftARSh7yokw3SnJ1ognBUyIUBF0FEO6zTbQN0HdSPhCWNSbedpVi92pMsgCKz
	 t7pne7aYFxhiK/NsbHhGMoLTLSihT3POe2kYd8uqt9WyhrhjMVqo1/jEuc427CQM6j
	 ext5xA3PjENqqlGrKJ5bdLivpMWdKbjrsH4cN4V3bKJODfk3K03e3kJnwZYVIZPuzN
	 ejXHGnO9McblEZYaN/ZlELrVIkubkb8AFB5oXDVUbX9IS1PjPUJnixvL2O+vrvxRpn
	 k8DVFmkHI2wRAhcWV2y6IZ+rAVL9nO8RTdnJgDyTIMdR7wEjoyujGdNMqpmPE6cTEs
	 sL0Y6TU3OVWxw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 359BD3782058;
	Mon, 12 Feb 2024 10:41:44 +0000 (UTC)
Message-ID: <45422a32-de34-4de1-bcd3-5580386f27f8@collabora.com>
Date: Mon, 12 Feb 2024 11:41:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 02/18] thermal: Add new structures and
 thermal_zone_device_register()
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, daniel.lezcano@linaro.org
Cc: miquel.raynal@bootlin.com, rui.zhang@intel.com, lukasz.luba@arm.com,
 support.opensource@diasemi.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
 kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
 andersson@kernel.org, konrad.dybcio@linaro.org, amitk@kernel.org,
 thara.gopinath@gmail.com, niklas.soderlund@ragnatech.se,
 srinivas.pandruvada@linux.intel.com, baolin.wang@linux.alibaba.com,
 u.kleine-koenig@pengutronix.de, hayashi.kunihiko@socionext.com,
 d-gole@ti.com, linus.walleij@linaro.org,
 DLG-Adam.Ward.opensource@dm.renesas.com, error27@gmail.com, heiko@sntech.de,
 hdegoede@redhat.com, jernej.skrabec@gmail.com, f.fainelli@gmail.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, kernel@collabora.com
References: <20240130111250.185718-1-angelogioacchino.delregno@collabora.com>
 <20240130111250.185718-3-angelogioacchino.delregno@collabora.com>
 <CAJZ5v0jzaGpK8LnsFDtjuPoURrwrUgM1Z2QfZhK_FUzDeK3wcw@mail.gmail.com>
 <e4359d2c-e686-4a97-9d21-d10908e9df61@moroto.mountain>
 <CAJZ5v0iYNPB2v7ZCynEOvWy+gz4DQUhuoJ8e7F1MXz13m_d7rw@mail.gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAJZ5v0iYNPB2v7ZCynEOvWy+gz4DQUhuoJ8e7F1MXz13m_d7rw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 02/02/24 18:13, Rafael J. Wysocki ha scritto:
> On Fri, Feb 2, 2024 at 9:47 AM Dan Carpenter <dan.carpenter@linaro.org> wrote:
>>
>> On Thu, Feb 01, 2024 at 08:24:15PM +0100, Rafael J. Wysocki wrote:
>>> On Tue, Jan 30, 2024 at 12:13 PM AngeloGioacchino Del Regno
>>>> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
>>>> index 65d8f92a9a0d..7a540b746703 100644
>>>> --- a/include/linux/thermal.h
>>>> +++ b/include/linux/thermal.h
>>>> @@ -149,7 +149,8 @@ struct thermal_cooling_device {
>>>>                          passive trip point.
>>>>    * @need_update:       if equals 1, thermal_zone_device_update needs to be invoked.
>>>>    * @ops:       operations this &thermal_zone_device supports
>>>> - * @tzp:       thermal zone parameters
>>>> + * @tzp:               Thermal zone parameters
>>>> + * @tgp:               Thermal zone governor parameters
>>>>    * @governor:  pointer to the governor for this thermal zone
>>>>    * @governor_data:     private pointer for governor data
>>>>    * @thermal_instances: list of &struct thermal_instance of this thermal zone
>>>> @@ -184,7 +185,8 @@ struct thermal_zone_device {
>>>>          int prev_high_trip;
>>>>          atomic_t need_update;
>>>>          struct thermal_zone_device_ops *ops;
>>>> -       struct thermal_zone_params *tzp;
>>>> +       struct thermal_zone_platform_params *tzp;
>>>> +       struct thermal_governor_params *tgp;
>>>
>>> I agree with doing a split here, but I'm not sure about moving items
>>> from the arg list to struct thermal_zone_platform_params (as mentioned
>>> above).
>>>
>>> Also the naming is quite inconsistent.  IMO it would be better to call
>>> the first pointer "tzpp", rename struct thermal_governor_params to
>>> struct thermal_zone_governor_params and call the second pointer
>>> "tzgp".
>>>
>>
>> The names "tzgp" and "tzpp" look almost identical at first glance.
>> Could we increase the hamming distance somehow?
> 
> Good point.
> 
> They may as well be gov_params and platform_params AFAIAC.

I'm more for gov_params and zone_params, as the thermal_zone_platform_params is
supposed to get renamed to struct thermal_zone_params in part 2.

Anything against that?

Cheers,
Angelo


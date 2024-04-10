Return-Path: <linux-kernel+bounces-138281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7597B89EF31
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 208A42829A7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4DB156F23;
	Wed, 10 Apr 2024 09:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="eih+DVQB"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05CB156976;
	Wed, 10 Apr 2024 09:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712742607; cv=none; b=f8Bh+VYuJ1I0e/DQHH03cL4zmkuA4JZIkEtrr5uXU7FsnPtpXyaraQjF/65WHJmNAlywbN4/O+XKWGVv/SvYsb2ZpKT0HKUfd5yfkHWAsoUmDNqR7Yqb7Bub5KqHjMQ6JjEoxOhZrl8YGDIYVhhS0PKL4koI/zY6FMcZreCvl7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712742607; c=relaxed/simple;
	bh=Ii71cBKKIW141cZWCc8RUZXkNgzA4tr4OR6L3mud6Dw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rIlINOXpvydmYmFR6jyRdlSTjdYWR6QM/VKNHqSkAkQUflkrXtohbUYG8hLvkYUDqAptyVpjotenMVlVz/2rLIR2k/JfKE7Pj8JbMYmst8gx6lXo5Os3YiNdMQBd2WNtObCUkOsdPaYn/AOaSdrvGmhiHKs0ZZsswEiIDpD8BiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=eih+DVQB; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712742603;
	bh=Ii71cBKKIW141cZWCc8RUZXkNgzA4tr4OR6L3mud6Dw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eih+DVQBahmd/5DRwuBsmzb797GZaSLdemKLXmgKi0pgdwvdsZ2TMBKjXicySQZvi
	 KR3pbCwPybIVbvaL7gHcvncfa+PfXh7r08he4U08V1AnoAhzImpx7ks9fWSbg/HOU/
	 AhjZnWHDaIHajFyd4SH6zr8k/V0D5ZxuWawhPw5IG9J/QdEl3xrm5mfo2FwwoMGXtd
	 SfU1Yo+w+D6aGSnJ6CrJVHeLQI6OGdK6jL439lJTZ00zZLete9CwdsIPYfmvok5LUo
	 h6pqI46uWULKb50a/j+lWcXb9jrv/PSWn9vpB35e7AY/GfPksBNuteJroTsLKSsZoF
	 Br1kKBLAtlOTg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4C95B378000E;
	Wed, 10 Apr 2024 09:50:01 +0000 (UTC)
Message-ID: <d1dafc46-9b14-4752-822c-86cbabdcfb8b@collabora.com>
Date: Wed, 10 Apr 2024 11:49:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: mediatek: mt8192: Add missing trip point
 in thermal zone
To: Hsin-Te Yuan <yuanhsinte@chromium.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?=
 <nfraprado@collabora.com>, =?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?=
 <bero@baylibre.com>, Balsam CHIHI <bchihi@baylibre.com>,
 Alexandre Mergnat <amergnat@baylibre.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240410-upstream-torvalds-master-v2-1-679777847b63@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240410-upstream-torvalds-master-v2-1-679777847b63@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 10/04/24 10:40, Hsin-Te Yuan ha scritto:
> According to Documentation/driver-api/thermal/power_allocator.rst, there
> should be two passive trip points. Adding the missing trip point to
> ensure that the governor works optimally.
> 
> Fixes: c7a728051f4e ("arm64: dts: mediatek: mt8192: Add thermal nodes and thermal zones")
> Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>

That's better - but while I can agree about setting a general temperature
for that, I still have a few questions and requests:

1. Why is this 68°C? Was that value provided by MediaTek, or was it calculated?
  1b. If this was calculated, please, can you explain how?

2. The power allocator documentation also says that the governor works good
    when a "sustainable dissipatable power" parameter is fed to it through the
    `sustainable-power` devicetree property (with that being strictly board
    specific and never SoC-global, as that depends on the form factor and on
    the cooling method of the machine), can you please also add the right
    sustainable power indication to the Chromebook devicetrees?
    In the MT8192 specific case, that's mt8192-asurada.dtsi.

3. I just noticed that MT8192 is not the only one that would be affected by
    the issue that you're describing in this commit; can you please perform a
    similar change on the others, if parameters are known?

Thanks,
Angelo

> ---
> Changes in v2:
> - Clearify the reason of adding another passive trip point
> - Link to v1: https://lore.kernel.org/r/20240410-upstream-torvalds-master-v1-1-852e903f0cec@chromium.org
> ---
>   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 40 ++++++++++++++++++++++++++++++++
>   1 file changed, 40 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index 05e401670bced..08d8bccc84669 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -1959,6 +1959,11 @@ cpu0-thermal {
>   			thermal-sensors = <&lvts_mcu MT8192_MCU_LITTLE_CPU0>;
>   
>   			trips {
> +				cpu0_thres: trip-point {
> +					temperature = <68000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
>   				cpu0_alert: trip-alert {
>   					temperature = <85000>;
>   					hysteresis = <2000>;
> @@ -1989,6 +1994,11 @@ cpu1-thermal {
>   			thermal-sensors = <&lvts_mcu MT8192_MCU_LITTLE_CPU1>;
>   
>   			trips {
> +				cpu1_thres: trip-point {
> +					temperature = <68000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
>   				cpu1_alert: trip-alert {
>   					temperature = <85000>;
>   					hysteresis = <2000>;
> @@ -2019,6 +2029,11 @@ cpu2-thermal {
>   			thermal-sensors = <&lvts_mcu MT8192_MCU_LITTLE_CPU2>;
>   
>   			trips {
> +				cpu2_thres: trip-point {
> +					temperature = <68000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
>   				cpu2_alert: trip-alert {
>   					temperature = <85000>;
>   					hysteresis = <2000>;
> @@ -2049,6 +2064,11 @@ cpu3-thermal {
>   			thermal-sensors = <&lvts_mcu MT8192_MCU_LITTLE_CPU3>;
>   
>   			trips {
> +				cpu3_thres: trip-point {
> +					temperature = <68000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
>   				cpu3_alert: trip-alert {
>   					temperature = <85000>;
>   					hysteresis = <2000>;
> @@ -2079,6 +2099,11 @@ cpu4-thermal {
>   			thermal-sensors = <&lvts_mcu MT8192_MCU_BIG_CPU0>;
>   
>   			trips {
> +				cpu4_thres: trip-point {
> +					temperature = <68000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
>   				cpu4_alert: trip-alert {
>   					temperature = <85000>;
>   					hysteresis = <2000>;
> @@ -2109,6 +2134,11 @@ cpu5-thermal {
>   			thermal-sensors = <&lvts_mcu MT8192_MCU_BIG_CPU1>;
>   
>   			trips {
> +				cpu5_thres: trip-point {
> +					temperature = <68000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
>   				cpu5_alert: trip-alert {
>   					temperature = <85000>;
>   					hysteresis = <2000>;
> @@ -2139,6 +2169,11 @@ cpu6-thermal {
>   			thermal-sensors = <&lvts_mcu MT8192_MCU_BIG_CPU2>;
>   
>   			trips {
> +				cpu6_thres: trip-point {
> +					temperature = <68000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
>   				cpu6_alert: trip-alert {
>   					temperature = <85000>;
>   					hysteresis = <2000>;
> @@ -2169,6 +2204,11 @@ cpu7-thermal {
>   			thermal-sensors = <&lvts_mcu MT8192_MCU_BIG_CPU3>;
>   
>   			trips {
> +				cpu7_thres: trip-point {
> +					temperature = <68000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
>   				cpu7_alert: trip-alert {
>   					temperature = <85000>;
>   					hysteresis = <2000>;
> 
> ---
> base-commit: 20cb38a7af88dc40095da7c2c9094da3873fea23
> change-id: 20240410-upstream-torvalds-master-40aeff5416c7
> 
> Best regards,




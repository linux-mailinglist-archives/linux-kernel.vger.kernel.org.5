Return-Path: <linux-kernel+bounces-36635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A55BF83A423
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7DFB1C21586
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CC217578;
	Wed, 24 Jan 2024 08:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="GUdmYU31"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA8A17562;
	Wed, 24 Jan 2024 08:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706084860; cv=none; b=uWmi0erUCQIPV81+qFKd0K6OsGMiOMX27CDd1BS69se5wA10y859Ov7TD0OXMVgzWFcNkvn1oq2MMoezmpXRiaLNrQI2VoZtnluFGa9XZrdjBhazlaqg7VZmHJVN65eWZJy0SQ3tLohOSuhR2Yo4BpTJQMDWZOWcAv2AYxDTQgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706084860; c=relaxed/simple;
	bh=D/3W7RJsCcBLtUtTh+4k2/CoFhq/vowhmOY8IGXc+KY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IJxW81I8PLxWkNj3R9MgWBFT8zOZB3uVBBhTz92ZNI4ONp2BPhcv9KZNGy57O+ngl6/AeE2z2sNxpV9uoEHL1CYN+hwcG15A4v3U7P23XoS5glcKoKWgRI3FwS19HlH1+evhG1jfzroAHkCaqUiGQsrESGiJyPb6Kakz97RwEo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=GUdmYU31; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706084856;
	bh=D/3W7RJsCcBLtUtTh+4k2/CoFhq/vowhmOY8IGXc+KY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GUdmYU31XCa+Z1vt3C9m2f0rfVL1OZ9JKUXOaN4LdVZVjs17LHcviQj0irZzOeTY6
	 O/f3aAMZClPhrwsB66gVFkT+FCi2ZxYtDuuPKzo9gKd1cbnxhmjZoC0hpV+CmeEaEH
	 /bxiC0t59kRvGt5L5ayeha5x4O0IglqFxWchpx46q54mLXov9m3/o/nhg8gI7yFNct
	 kOrc2H3CruKpZgDHHf7CF1ifpQHRJMADYx2grxbIy+Kdpi71DUQ28NKrew5wUZs8pY
	 lR9OvIH4igtikPQsyIw5I+TIsJhCVMqcDI25Y7YHpXpmLy0PinRVqQsUdpKBcpjH71
	 e+33HKPdsW3yw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1D5AE3782074;
	Wed, 24 Jan 2024 08:27:36 +0000 (UTC)
Message-ID: <786c85c7-7b38-4a2a-85ec-282196de7b5e@collabora.com>
Date: Wed, 24 Jan 2024 09:27:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] arm64: dts: mt8195-cherry-tomato: change watchdog
 reset boot flow
To: Hsin-Te Yuan <yuanhsinte@chromium.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Hsin-Te Yuan <yuanhsinte@google.com>
References: <20240124-send-upstream-v3-1-5097c9862a73@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240124-send-upstream-v3-1-5097c9862a73@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 24/01/24 08:51, Hsin-Te Yuan ha scritto:
> From: Hsin-Te Yuan <yuanhsinte@google.com>
> 
> The external output reset signal was originally disabled and sent from
> firmware. However, an unfixed bug in the firmware on tomato prevents
> the signal from being sent, causing the device to fail to boot. To fix
> this, enable external output reset signal to allow the device to reboot
> normally.
> 
> Fixes: 5eb2e303ec6b ("arm64: dts: mediatek: Introduce MT8195 Cherry platform's Tomato")
> Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>

Can't trigger the bug, but also this commit gives no side effects, so:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


> ---
> Changes in v3:
> - Add Fixes tag
> 
> Changes in v2:
> - Limit the effect only on tomato.
> ---
>   arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts | 4 ++++
>   arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts | 4 ++++
>   arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts | 4 ++++
>   3 files changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts
> index 2d5e8f371b6de..a82d716f10d44 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts
> @@ -23,3 +23,7 @@ &sound {
>   &ts_10 {
>   	status = "okay";
>   };
> +
> +&watchdog {
> +	/delete-property/ mediatek,disable-extrst;
> +};
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts
> index 2586c32ce6e6f..2fe20e0dad836 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts
> @@ -43,3 +43,7 @@ &sound {
>   &ts_10 {
>   	status = "okay";
>   };
> +
> +&watchdog {
> +	/delete-property/ mediatek,disable-extrst;
> +};
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts
> index f54f9477b99da..dd294ca98194c 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts
> @@ -44,3 +44,7 @@ &sound {
>   &ts_10 {
>   	status = "okay";
>   };
> +
> +&watchdog {
> +	/delete-property/ mediatek,disable-extrst;
> +};
> 
> ---
> base-commit: 64b50fcb03649ca7f0d762a50e7a3484cfc1d586
> change-id: 20230818-send-upstream-e91e615a893c
> 
> Best regards,



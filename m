Return-Path: <linux-kernel+bounces-138086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B74B89EC89
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FD901F2181C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D236213D28A;
	Wed, 10 Apr 2024 07:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bvIwJ3sB"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9739479;
	Wed, 10 Apr 2024 07:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712735020; cv=none; b=qTOBdADVsuZaCm2++5aRMNjmxjPITKjfX/CeCQPrHwhrNq6dih4hmIejKMjjJIsVT6gt/uFzZ0nbXakNSEL/X25ZF4T0aIeaBBjC2yIP+f22yD5T0tdwIs+QzdzcNl4GIubj1tbER9WF2theKvkvVbgvrALztih+P6bhfOheg2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712735020; c=relaxed/simple;
	bh=DeSfzPYFn0N6NR18R8H3GpZboC/iGhCg4ALFCzEZRKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=immI8L4qcTQFtHD/5b2fUXtKUppCgbQGMt2EdFQuq3ksHLaId21bBU0wVZaC83GAxwAPZltJLwtxaibXSPzSnRMnPktOyFcbgbDDPwOjPEu3mhJZq9cL83kT3asDbELUlPmEXT4nbWbhIGdvHlaNeRWqAXCCi/saqs31o1BMe4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bvIwJ3sB; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712735016;
	bh=DeSfzPYFn0N6NR18R8H3GpZboC/iGhCg4ALFCzEZRKI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bvIwJ3sB7OrZj3KC8gn3eqW08Bc/4c5JWCeL7YUzBTi01GKdRDY4XUkN/+bOZxlLK
	 wAIgyFw5srJUU8UK1IcEYrTE3SwnZ+3MG9i+NHeIR1BhqjQXgrCJoCQMRG33h3fRDl
	 KBgKF7ZC4ROOI/+FkGQNR+F5rN76GWGqTa22lTfOE6RkK2JrsYJ+fG2tDDSFTn1a9p
	 /XyF2JXQ9x4cCWbTHDKPylDtmQG2lvC0C+pGI7ZlPocIp8GrrdwMqtX+ixTn+cX6G4
	 OCpftAVgB11ICqHOXZKQ7qL0WbA2076iATeGWAsMA/rbx9nUsj9bgMo6Oso55buHqU
	 hDW+4eetblGbQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 48F1A3780C13;
	Wed, 10 Apr 2024 07:43:35 +0000 (UTC)
Message-ID: <c3d05b3e-f784-4606-9634-52dc6feee318@collabora.com>
Date: Wed, 10 Apr 2024 09:43:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: mediatek: mt8192: Add missing trip point in
 thermal zone
To: Hsin-Te Yuan <yuanhsinte@chromium.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?=
 <nfraprado@collabora.com>, =?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?=
 <bero@baylibre.com>, Balsam CHIHI <bchihi@baylibre.com>,
 Alexandre Mergnat <amergnat@baylibre.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240410-upstream-torvalds-master-v1-1-852e903f0cec@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240410-upstream-torvalds-master-v1-1-852e903f0cec@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 10/04/24 08:20, Hsin-Te Yuan ha scritto:
> Add the missing passive trip point which is expected by kernel.
> 
> Fixes: c7a728051f4e ("arm64: dts: mediatek: mt8192: Add thermal nodes and thermal zones")
> Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>

Sorry, I don't understand what you're trying to solve here.

All of the thermal zones in mt8192.dtsi already do have a passive trip point
which is also used in cooling-maps.

Can you please describe the issue?

Thanks,
Angelo

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



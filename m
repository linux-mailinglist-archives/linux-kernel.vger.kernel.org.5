Return-Path: <linux-kernel+bounces-89551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E7E86F1E0
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 19:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F4F1282F9C
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 18:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C6936AEB;
	Sat,  2 Mar 2024 18:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="aVO2U4iy"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5755374DB;
	Sat,  2 Mar 2024 18:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709404707; cv=none; b=ke6wENniZRfZvboOzvhNZzymIPULypRi8xeYVDQWekXnhjbQnRf+eaDbZdfMKcSAH4x9Nl+CAGDx20e6+9QvQn13m3xpnepCTAge1wrawu0QVBDBaqRYkF03TDx7skSqPBohiarmHqM2kFsGNIXz74oKUndwEIXv0j+i3igqrBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709404707; c=relaxed/simple;
	bh=DxMieUdGbPoFEJAzv8g2IGm2lj3iuTaFDdXF9YJKqnY=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=fxPBrjNd3wVXtKPtD9dRoZpI3UmT+DTQunrhBVWZfWyxU1oBaB1rOU+NsKzB88WNaPSPFLcM8rYJrALMJQ5FbsFElecs4xTyRToPSqKstxLgxP2bb0FHEFxISItHCyxDd+a+l0DMLQ+uNiHdu37EUbsIAuok86fDSwoSl1CGRLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=aVO2U4iy; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1709404695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g8ZlwO6znWmhb0i3vL98mOnE4UFnlmkSb9Ze7dDbIvw=;
	b=aVO2U4iyixRmN8pxd49qgP99L5UhCddPgPtNq8RIiNWeg6l8r1BUftxz9RgrDpQT778eCk
	ks4k3prN2Bb8e7SZNg+w5ypo/sTvkfwBIzdbdMMRnd75FLxasKhkWTxBDjmyxv0D6v/nP8
	fsqRR5WQaDPso4IYQv/BYzq6/3z8qvYsCko3wfdpzbZ8+wAIOvogabY5hvTnoUxOJ2jdxG
	N/HoC4I9ozA1MwXONMEfC0tevvu8BExiFIHDYIDlkPVEPek1FogRQkva+xLIB5PYVOsmlD
	SecLkbeFJ0N+1Mskhvn5/yD+PEqYk7zO8sN5Cr40zOTtnr3DdInkrptklCPQQw==
Date: Sat, 02 Mar 2024 19:38:14 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Alexey Charkov <alchark@gmail.com>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Chen-Yu
 Tsai <wens@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] arm64: dts: rockchip: enable built-in thermal
 monitoring on RK3588
In-Reply-To: <6279836.31r3eYUQgx@phil>
References: <20240229-rk-dts-additions-v3-0-6afe8473a631@gmail.com>
 <20240229-rk-dts-additions-v3-1-6afe8473a631@gmail.com>
 <6279836.31r3eYUQgx@phil>
Message-ID: <3f73d847fbe9d7f6dd05802eb7e47d49@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Heiko,

On 2024-03-02 12:25, Heiko Stuebner wrote:
> Am Donnerstag, 29. Februar 2024, 20:26:32 CET schrieb Alexey Charkov:
>> Include thermal zones information in device tree for RK3588 variants.
>> 
>> This also enables the TSADC controller unconditionally on all boards
>> to ensure that thermal protections are in place via throttling and
>> emergency reset, once OPPs are added to enable CPU DVFS.
>> 
>> The default settings (using CRU as the emergency reset mechanism)
>> should work on all boards regardless of their wiring, as CRU resets
>> do not depend on any external components. Boards that have the TSHUT
>> signal wired to the reset line of the PMIC may opt to switch to GPIO
>> tshut mode instead (rockchip,hw-tshut-mode = <1>;)
>> 
>> It seems though that downstream kernels don't use that, even for
>> those boards where the wiring allows for GPIO based tshut, such as
>> Radxa Rock 5B [1], [2], [3]
>> 
>> [1] 
>> https://github.com/radxa/kernel/blob/stable-5.10-rock5/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts#L540
>> [2] 
>> https://github.com/radxa/kernel/blob/stable-5.10-rock5/arch/arm64/boot/dts/rockchip/rk3588s.dtsi#L5433
>> [3] https://dl.radxa.com/rock5/5b/docs/hw/radxa_rock_5b_v1423_sch.pdf 
>> page 11 (TSADC_SHUT_H)
>> 
>> Signed-off-by: Alexey Charkov <alchark@gmail.com>
>> ---
>>  arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 176 
>> +++++++++++++++++++++++++++++-
>>  1 file changed, 175 insertions(+), 1 deletion(-)
>> 
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi 
>> b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
>> index 36b1b7acfe6a..9bf197358642 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
>> @@ -10,6 +10,7 @@
>>  #include <dt-bindings/reset/rockchip,rk3588-cru.h>
>>  #include <dt-bindings/phy/phy.h>
>>  #include <dt-bindings/ata/ahci.h>
>> +#include <dt-bindings/thermal/thermal.h>
>> 
>>  / {
>>  	compatible = "rockchip,rk3588";
>> @@ -2225,7 +2226,180 @@ tsadc: tsadc@fec00000 {
>>  		pinctrl-1 = <&tsadc_shut>;
>>  		pinctrl-names = "gpio", "otpout";
>>  		#thermal-sensor-cells = <1>;
>> -		status = "disabled";
>> +		status = "okay";
>> +	};
> 
> so I've skimmed over the general discussion, though don't have a hard
> opinion in either direction yet. Still there are some low-hanging 
> fruit:
> 
> - having the thermal-zones addition in a separate patch would allow to
>   merge the obvious stuff, while this discussion is still ongoing

Very good suggestion.

> - status=okay in a soc dtsi is wrong, because okay is the default 
> status
>   so if anything the status property should be removed
> 
> In general I'm not that much of a fan of things just working 
> implicitly.
> So somehow, when someone submits a board devicetree, I expect them to
> having ensured stuff is enabled somewhat ok. So even seeing a simple
> 
> 	&tsadc {
> 		status = "okay"
> 	};
> 
> suggests that they have at least noticed the existence of thermal 
> stuff.

I agree that having such additional "signed-off markers", so to speak, 
in
a board dts is quite assuring.  I mean, someone implementing a new dts 
file
for a new board should simply know what needs to be done there, and 
there
should be no excuses for not checking the thermal throttling stuff.


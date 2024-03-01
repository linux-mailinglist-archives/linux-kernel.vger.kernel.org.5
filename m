Return-Path: <linux-kernel+bounces-87963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 188C586DB8A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 07:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66C26B21A78
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 06:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673A567E78;
	Fri,  1 Mar 2024 06:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="Vo8SonFQ"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46B167C74;
	Fri,  1 Mar 2024 06:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709274982; cv=none; b=NWt8lBhLiYu3FT/xm3RBOVzojZdZt53URFu7nHD1mBZVH5jVLF6CjWe3PGhy23IoC+ws4qljdrTK/8QRSBx4YQRhaYEtB0GVb518Ijzwq7cpmSW4LMYIkr5Mtl5/1kYSGERlxy/XzW1MtD6pbpDsHdgkVRFQeZ6Jo1UqPFdO2UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709274982; c=relaxed/simple;
	bh=JNG/ygakUvEPV8RswkC/Zwajwfwyk8WyG2+D4co9aPI=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=V4QfHysax0x2vBHLMpnobIR2apSfUoJlhMhH/KnkQjUR9DPyOwHh47IhdIfP8AawHCtAIqp/PwSk4ryiQjuNPDv54pKiMB8suPjsZ2apR35nGsWWHFp3YsfH188oOkZHmFRlFYbsS4KkWi2mXJZghwVyeikbTaSvoUsVoKgP7Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=Vo8SonFQ; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1709274978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J6gzN4EuRpgmrmWnxz0mdsD/+1mrLoS4280/mKFSM0Y=;
	b=Vo8SonFQqGUwQAwgGoSShVQajvLDVoAP3kz46mC4H61QgvNUwypN0Q/uuM5dK5ybyRI35D
	jXC5EAwOUgt+YD6S5cfU9OrM3xFIVr1eGJ+UWHHZn+3e7gx/NAtCI9LWxikEvKAqqpgM1m
	bzOO6+xNS/35cy82r7o5s/MMZgyC8NLzhTuFyicpjurZ6t8oNJrkYpKWkiQJHPQdMk1WgM
	gktWzmAm3MaDre0DIKd9tiGQQMjEh3hi3/d02ZoiXxcnpo0OZyUZdA1Sm0ci+PEyXMsLZa
	R30DuLTGgmHoFodYTuSMp7S2oUJqqqA9klNuVelqaGneI2HvZHET3PlJqgetSQ==
Date: Fri, 01 Mar 2024 07:36:18 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Alexey Charkov <alchark@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Chen-Yu
 Tsai <wens@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/5] arm64: dts: rockchip: Add further granularity in
 RK3588 CPU OPPs
In-Reply-To: <20240229-rk-dts-additions-v3-5-6afe8473a631@gmail.com>
References: <20240229-rk-dts-additions-v3-0-6afe8473a631@gmail.com>
 <20240229-rk-dts-additions-v3-5-6afe8473a631@gmail.com>
Message-ID: <5e088e85cd006dc0d9cdefc2b39b4ff0@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-02-29 20:26, Alexey Charkov wrote:
> This introduces additional OPPs that share the same voltage as
> another OPP already present in the .dtsi but with lower frequency.
> 
> The idea is to try and limit system throughput more gradually upon
> reaching the throttling condition for workloads that are close to
> sustainable power already, thus avoiding needless performance loss.
> 
> My limited synthetic benchmarking [1] showed around 3.8% performance
> benefit when these are in place, other things equal (not meant to
> be comprehensive). Though dmesg complains about these OPPs being
> 'inefficient':

As I already promised, I'll perform additional testing, in a 
reproducible
way, and come back with a detailed report.

> [    9.009561] cpu cpu0: EM: OPP:816000 is inefficient
> [    9.009580] cpu cpu0: EM: OPP:600000 is inefficient
> [    9.009591] cpu cpu0: EM: OPP:408000 is inefficient
> [    9.011370] cpu cpu4: EM: OPP:2352000 is inefficient
> [    9.011379] cpu cpu4: EM: OPP:2304000 is inefficient
> [    9.011384] cpu cpu4: EM: OPP:2256000 is inefficient
> [    9.011389] cpu cpu4: EM: OPP:600000 is inefficient
> [    9.011393] cpu cpu4: EM: OPP:408000 is inefficient
> [    9.012978] cpu cpu6: EM: OPP:2352000 is inefficient
> [    9.012987] cpu cpu6: EM: OPP:2304000 is inefficient
> [    9.012992] cpu cpu6: EM: OPP:2256000 is inefficient
> [    9.012996] cpu cpu6: EM: OPP:600000 is inefficient
> [    9.013000] cpu cpu6: EM: OPP:408000 is inefficient
> 
> [1] 
> https://lore.kernel.org/linux-rockchip/CABjd4YxqarUCbZ-a2XLe3TWJ-qjphGkyq=wDnctnEhdoSdPPpw@mail.gmail.com/T/#me92aa0ee25e6eeb1d1501ce85f5af4e58b3b13c5
> 
> Signed-off-by: Alexey Charkov <alchark@gmail.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 87 
> +++++++++++++++++++++++++++++++
>  1 file changed, 87 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> index bd39c5c47bfb..6b4ecc7ab37d 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> @@ -360,6 +360,21 @@ cluster0_opp_table: opp-table-cluster0 {
>  		compatible = "operating-points-v2";
>  		opp-shared;
> 
> +		opp-408000000 {
> +			opp-hz = /bits/ 64 <408000000>;
> +			opp-microvolt = <675000 675000 950000>;
> +			clock-latency-ns = <40000>;
> +		};
> +		opp-600000000 {
> +			opp-hz = /bits/ 64 <600000000>;
> +			opp-microvolt = <675000 675000 950000>;
> +			clock-latency-ns = <40000>;
> +		};
> +		opp-816000000 {
> +			opp-hz = /bits/ 64 <816000000>;
> +			opp-microvolt = <675000 675000 950000>;
> +			clock-latency-ns = <40000>;
> +		};
>  		opp-1008000000 {
>  			opp-hz = /bits/ 64 <1008000000>;
>  			opp-microvolt = <675000 675000 950000>;
> @@ -392,6 +407,27 @@ cluster1_opp_table: opp-table-cluster1 {
>  		compatible = "operating-points-v2";
>  		opp-shared;
> 
> +		opp-408000000 {
> +			opp-hz = /bits/ 64 <408000000>;
> +			opp-microvolt = <675000 675000 1000000>;
> +			clock-latency-ns = <40000>;
> +			opp-suspend;
> +		};
> +		opp-600000000 {
> +			opp-hz = /bits/ 64 <600000000>;
> +			opp-microvolt = <675000 675000 1000000>;
> +			clock-latency-ns = <40000>;
> +		};
> +		opp-816000000 {
> +			opp-hz = /bits/ 64 <816000000>;
> +			opp-microvolt = <675000 675000 1000000>;
> +			clock-latency-ns = <40000>;
> +		};
> +		opp-1008000000 {
> +			opp-hz = /bits/ 64 <1008000000>;
> +			opp-microvolt = <675000 675000 1000000>;
> +			clock-latency-ns = <40000>;
> +		};
>  		opp-1200000000 {
>  			opp-hz = /bits/ 64 <1200000000>;
>  			opp-microvolt = <675000 675000 1000000>;
> @@ -422,6 +458,21 @@ opp-2208000000 {
>  			opp-microvolt = <987500 987500 1000000>;
>  			clock-latency-ns = <40000>;
>  		};
> +		opp-2256000000 {
> +			opp-hz = /bits/ 64 <2256000000>;
> +			opp-microvolt = <1000000 1000000 1000000>;
> +			clock-latency-ns = <40000>;
> +		};
> +		opp-2304000000 {
> +			opp-hz = /bits/ 64 <2304000000>;
> +			opp-microvolt = <1000000 1000000 1000000>;
> +			clock-latency-ns = <40000>;
> +		};
> +		opp-2352000000 {
> +			opp-hz = /bits/ 64 <2352000000>;
> +			opp-microvolt = <1000000 1000000 1000000>;
> +			clock-latency-ns = <40000>;
> +		};
>  		opp-2400000000 {
>  			opp-hz = /bits/ 64 <2400000000>;
>  			opp-microvolt = <1000000 1000000 1000000>;
> @@ -433,6 +484,27 @@ cluster2_opp_table: opp-table-cluster2 {
>  		compatible = "operating-points-v2";
>  		opp-shared;
> 
> +		opp-408000000 {
> +			opp-hz = /bits/ 64 <408000000>;
> +			opp-microvolt = <675000 675000 1000000>;
> +			clock-latency-ns = <40000>;
> +			opp-suspend;
> +		};
> +		opp-600000000 {
> +			opp-hz = /bits/ 64 <600000000>;
> +			opp-microvolt = <675000 675000 1000000>;
> +			clock-latency-ns = <40000>;
> +		};
> +		opp-816000000 {
> +			opp-hz = /bits/ 64 <816000000>;
> +			opp-microvolt = <675000 675000 1000000>;
> +			clock-latency-ns = <40000>;
> +		};
> +		opp-1008000000 {
> +			opp-hz = /bits/ 64 <1008000000>;
> +			opp-microvolt = <675000 675000 1000000>;
> +			clock-latency-ns = <40000>;
> +		};
>  		opp-1200000000 {
>  			opp-hz = /bits/ 64 <1200000000>;
>  			opp-microvolt = <675000 675000 1000000>;
> @@ -463,6 +535,21 @@ opp-2208000000 {
>  			opp-microvolt = <987500 987500 1000000>;
>  			clock-latency-ns = <40000>;
>  		};
> +		opp-2256000000 {
> +			opp-hz = /bits/ 64 <2256000000>;
> +			opp-microvolt = <1000000 1000000 1000000>;
> +			clock-latency-ns = <40000>;
> +		};
> +		opp-2304000000 {
> +			opp-hz = /bits/ 64 <2304000000>;
> +			opp-microvolt = <1000000 1000000 1000000>;
> +			clock-latency-ns = <40000>;
> +		};
> +		opp-2352000000 {
> +			opp-hz = /bits/ 64 <2352000000>;
> +			opp-microvolt = <1000000 1000000 1000000>;
> +			clock-latency-ns = <40000>;
> +		};
>  		opp-2400000000 {
>  			opp-hz = /bits/ 64 <2400000000>;
>  			opp-microvolt = <1000000 1000000 1000000>;


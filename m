Return-Path: <linux-kernel+bounces-82202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E405586808D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70A781F20983
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45CF130AC0;
	Mon, 26 Feb 2024 19:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="I9egwK4T"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731A612FB2A;
	Mon, 26 Feb 2024 19:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708974574; cv=none; b=nDEt9cl2oq3KKL25EKgvcXwJOEFQVb3c/PCmJwSpbAiN1vvLbrRRdoQUQ9UUVJfFLiYqpnG1darh1k79cGhCzfZmgm/l+JPZ7wO4McKGIQdniUJkWCJrZB23e0kkxmq63IAXdKBdmdcFToOMB2wAW8Z1mTrU8txJyewA/tOi8yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708974574; c=relaxed/simple;
	bh=T1nwYcrb80KiMkROIVNK/60go897IbC9GVwqBNMMXlk=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=uRXHMFZM1NdN5OoRpauPig8pL39Ll63sF+WCgMrs2AoKsqpPHeDpEf+3jh7RNN6zS42SgllR36+3MxFUN7xiKUHuhXiyS40AgDBt3RAbtS0uz1+AbijFfFsFYYAb7c6hHKRowIv5cli7Q1yIXdjNZwcCiahfaI3QZJCVlPEZ/7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=I9egwK4T; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1708974566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MhPScaDHRZdhouzkoYyad3R9PfIyEE1nMSKg/JolwpQ=;
	b=I9egwK4T0p5eJfARevw+aGPmERrw3GF5gjjW79/nE95wu9QItS2TbWjRXlRTj4HfZzW31w
	Yaw8zlGTOSWMOlovsfFbnOIzVh5XFZDPSdA78Fvn4vMx7+yb+HwnxRPPk+OkpNDlYd8HoB
	1zbPKHe8+raiZJt9WfpUUFzyw9uB4rtdlrw9HhCAjsWXaZU63W0XaZ9ZXEjLp50F9eGen0
	gu8Lm/+hFZg3K1gC9PLBjqKAOshVEGLYMBUibpYrdkuj+gP0XmbSWMSdUmHid2ozYNc+dT
	OrxUt278Ydtbg2X1HwGgh8a/EEoBrX0Qv8oEHkcbkCpIPhQkUwTyZvDsZAw0Jw==
Date: Mon, 26 Feb 2024 20:09:26 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] arm64: dts: rockchip: Add cache information to the
 Rockchip RK3566 and RK3568 SoC
In-Reply-To: <20240226182310.4032-1-linux.amoon@gmail.com>
References: <20240226182310.4032-1-linux.amoon@gmail.com>
Message-ID: <8ceea100f2ef7cce296943ce1397161a@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Anand,

On 2024-02-26 19:23, Anand Moon wrote:
> As per RK3568 Datasheet and TRM add missing cache information to
> the Rockchip RK3566 and RK3568 SoC.
> 
> - Each Cortex-A55 core has 32KB of L1 instruction cache available and
> 	32KB of L1 data cache available with ECC.
> - Along with 512KB Unified L3 cache with ECC.
> 
> With adding instruction cache and data cache and a write buffer to
> reduce the effect of main memory bandwidth and latency on data
> access performance.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>

I was about to send my own patch that adds the same missing cache
information, so please allow me to describe the proposed way to move
forward.

The way I see it, your commit summary and description need a rather
complete rewrite, to be more readable, more accurate, and to avoid
including an irrelevant (and slightly misleading) description of the
general role of caches.

Also, the changes to the dtsi file would benefit from small touch-ups
here and there, for improved consistency, etc.

With all that in mind, I propose that you withdraw your patch and let
me send my patch that will addresses all these issues, of course with
a proper tag that lists you as a co-developer.  I think that would
save us a fair amount of time going back and forth.

I hope you agree.


> ---
> [0] 
> http://www.rock-chips.com/uploads/pdf/2022.8.26/191/RK3568%20Brief%20Datasheet.pdf
> [1] 
> https://dl.radxa.com/rock3/docs/hw/datasheet/Rockchip%20RK3568%20TRM%20Part1%20V1.1-20210301.pdf
> ---
>  arch/arm64/boot/dts/rockchip/rk356x.dtsi | 37 ++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> index c19c0f1b3778..49235efefb6b 100644
> --- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> @@ -56,6 +56,13 @@ cpu0: cpu@0 {
>  			clocks = <&scmi_clk 0>;
>  			#cooling-cells = <2>;
>  			enable-method = "psci";
> +			d-cache-line-size = <32>;
> +			d-cache-size = <0x8000>;
> +			d-cache-sets = <32>;
> +			i-cache-line-size = <32>;
> +			i-cache-size = <0x8000>;
> +			i-cache-sets = <32>;
> +			next-level-cache = <&l2>;
>  			operating-points-v2 = <&cpu0_opp_table>;
>  		};
> 
> @@ -65,6 +72,13 @@ cpu1: cpu@100 {
>  			reg = <0x0 0x100>;
>  			#cooling-cells = <2>;
>  			enable-method = "psci";
> +			d-cache-line-size = <32>;
> +			d-cache-size = <0x8000>;
> +			d-cache-sets = <32>;
> +			i-cache-line-size = <32>;
> +			i-cache-size = <0x8000>;
> +			i-cache-sets = <32>;
> +			next-level-cache = <&l2>;
>  			operating-points-v2 = <&cpu0_opp_table>;
>  		};
> 
> @@ -74,6 +88,13 @@ cpu2: cpu@200 {
>  			reg = <0x0 0x200>;
>  			#cooling-cells = <2>;
>  			enable-method = "psci";
> +			d-cache-line-size = <32>;
> +			d-cache-size = <0x8000>;
> +			d-cache-sets = <32>;
> +			i-cache-line-size = <32>;
> +			i-cache-size = <0x8000>;
> +			i-cache-sets = <32>;
> +			next-level-cache = <&l2>;
>  			operating-points-v2 = <&cpu0_opp_table>;
>  		};
> 
> @@ -83,8 +104,24 @@ cpu3: cpu@300 {
>  			reg = <0x0 0x300>;
>  			#cooling-cells = <2>;
>  			enable-method = "psci";
> +			d-cache-line-size = <32>;
> +			d-cache-size = <0x8000>;
> +			d-cache-sets = <32>;
> +			i-cache-line-size = <32>;
> +			i-cache-size = <0x8000>;
> +			i-cache-sets = <32>;
> +			next-level-cache = <&l2>;
>  			operating-points-v2 = <&cpu0_opp_table>;
>  		};
> +
> +		l2: l2-cache0 {
> +			compatible = "cache";
> +			cache-level = <3>;
> +			cache-unified;
> +			cache-size = <0x7d000>; /* L3. 512 KB */
> +			cache-line-size = <64>;
> +			cache-sets = <512>;
> +		};
>  	};
> 
>  	cpu0_opp_table: opp-table-0 {


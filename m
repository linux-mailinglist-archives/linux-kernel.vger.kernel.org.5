Return-Path: <linux-kernel+bounces-54435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFECD84AF31
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A0C61F23968
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 07:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB821292E6;
	Tue,  6 Feb 2024 07:48:34 +0000 (UTC)
Received: from mx.msync.work (mx.msync.work [62.182.159.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E9D55E40;
	Tue,  6 Feb 2024 07:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.182.159.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707205713; cv=none; b=Cl42FRgg/6P3a3Encw2MnlSAnPuljCLuMc1l50WNd7Rvyl+Bj2LzmhET0fuNnegtipH74cBiAPae3QJZ07fdDnkgnTltHgvaKEey8+MyLyvRN77Nr5IqgI1xj0JLkkwYpPplkfdiMWoMfZ3WIHVcJDTv/Eb637hLf1GtvHVcYRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707205713; c=relaxed/simple;
	bh=4jEdupVxgTG+iiH9uyvUhWF4J92USuZZDRzBIix0h8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e/fwYUQiWZrjAoHc8gC0gsqBoJ6vXEIaYxcwpmwLKdfYkYU6cVxSJT/TBAEPr0eGGrHx4cbFK35dP87PJ3JjLBRARh+Ah2P2SY6CFUSMxYmSh0SI8XZn9SerFBXGT0KBM9xTzXAb+PAYUTegnGSjJgxA46cyFyrprHxr80XXLKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lexina.in; spf=pass smtp.mailfrom=lexina.in; dkim=pass (2048-bit key) header.d=lexina.in header.i=@lexina.in header.b=ue+Bezo6; arc=none smtp.client-ip=62.182.159.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lexina.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lexina.in
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 02E11ECB94;
	Tue,  6 Feb 2024 07:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1707205693; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references:autocrypt;
	bh=S3M9EroVDAgqRoipWcralP7huHBJRMins8OTjwghy7w=;
	b=ue+Bezo6XcL7NRELmUH12w4hO2kpZQTYTpcwBoAv5hZVpxa3+AcqLLVyEJ34NiFYSV2o0W
	fopWIlP5WzGC/fXqZ/ruEON68QY494u1mfZNlSYO5fyuMt+4+uYlutTzSKlNmfpVOqkYTl
	nEx3jcaRH3HB0znG2K5vwmQ6xnzbj/wX5hZeBKo0nxdTw6ZlT4i5p6ma4djUxuUQoXlyGs
	ZgSsvPDvTMwfnvnhauEbJFN8+R/vgH6JuojRrS/43ZOSvwR9spYFL2PYu9LnA/70EN2qeW
	zF0eDGgQwQW+irH7V39wrYydudH3Slw/NeZuKxGkwV5XrTWIhsqfTP9hxoe20A==
Message-ID: <4248e19e-5f2f-4e4f-a869-a0fec81b16bd@lexina.in>
Date: Tue, 6 Feb 2024 10:48:09 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv1 3/5] arm64: dts: amlogic: Add cache information to the
 Amlogic G12A SoCS
Content-Language: en-US, ru-RU
To: Anand Moon <linux.amoon@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240205171930.968-1-linux.amoon@gmail.com>
 <20240205171930.968-4-linux.amoon@gmail.com>
From: Viacheslav <adeep@lexina.in>
Autocrypt: addr=adeep@lexina.in; keydata=
 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
In-Reply-To: <20240205171930.968-4-linux.amoon@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi!

You missed the AXG family with the Cortex-A53 CPU. The datasheet does 
not provide information on cache sizes. Given that the A113X/A113D are 
equipped with the Arm Cortex-A53 processor, it is assumed they use the 
same cache size as the S905/S905X/S905X2 models.

05/02/2024 20.19, Anand Moon wrote:
> As per the S905X2 datasheet add missing cache information to the Amlogic
> G12A SoC.
> 
> - Each Cortex-A53 core has 32KB of L1 instruction cache available and
> 	32KB of L1 data cache available.
> - Along with 512KB Unified L2 cache.
> 
> To improve system performance.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> No public dataheet available, since S905X2 support Arm Cortex-A53 cpu
> nence used the same cache size as S905 and S905X.
> ---
>   arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 27 +++++++++++++++++++++
>   1 file changed, 27 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
> index 543e70669df5..6e1e3a3f5f18 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
> @@ -17,6 +17,12 @@ cpu0: cpu@0 {
>   			compatible = "arm,cortex-a53";
>   			reg = <0x0 0x0>;
>   			enable-method = "psci";
> +			d-cache-line-size = <32>;
> +			d-cache-size = <0x8000>;
> +			d-cache-sets = <32>;
> +			i-cache-line-size = <32>;
> +			i-cache-size = <0x8000>;
> +			i-cache-sets = <32>;
>   			next-level-cache = <&l2>;
>   			#cooling-cells = <2>;
>   		};
> @@ -26,6 +32,12 @@ cpu1: cpu@1 {
>   			compatible = "arm,cortex-a53";
>   			reg = <0x0 0x1>;
>   			enable-method = "psci";
> +			d-cache-line-size = <32>;
> +			d-cache-size = <0x8000>;
> +			d-cache-sets = <32>;
> +			i-cache-line-size = <32>;
> +			i-cache-size = <0x8000>;
> +			i-cache-sets = <32>;
>   			next-level-cache = <&l2>;
>   			#cooling-cells = <2>;
>   		};
> @@ -35,6 +47,12 @@ cpu2: cpu@2 {
>   			compatible = "arm,cortex-a53";
>   			reg = <0x0 0x2>;
>   			enable-method = "psci";
> +			d-cache-line-size = <32>;
> +			d-cache-size = <0x8000>;
> +			d-cache-sets = <32>;
> +			i-cache-line-size = <32>;
> +			i-cache-size = <0x8000>;
> +			i-cache-sets = <32>;
>   			next-level-cache = <&l2>;
>   			#cooling-cells = <2>;
>   		};
> @@ -44,6 +62,12 @@ cpu3: cpu@3 {
>   			compatible = "arm,cortex-a53";
>   			reg = <0x0 0x3>;
>   			enable-method = "psci";
> +			d-cache-line-size = <32>;
> +			d-cache-size = <0x8000>;
> +			d-cache-sets = <32>;
> +			i-cache-line-size = <32>;
> +			i-cache-size = <0x8000>;
> +			i-cache-sets = <32>;
>   			next-level-cache = <&l2>;
>   			#cooling-cells = <2>;
>   		};
> @@ -52,6 +76,9 @@ l2: l2-cache0 {
>   			compatible = "cache";
>   			cache-level = <2>;
>   			cache-unified;
> +			cache-size = <0x7d000>; /* L2. 512 KB */
> +			cache-line-size = <64>;
> +			cache-sets = <512>;
>   		};
>   	};
>   


Best regards,
--
Viacheslav Bocharov <adeep@lexina.in>


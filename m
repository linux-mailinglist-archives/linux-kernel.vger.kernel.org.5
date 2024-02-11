Return-Path: <linux-kernel+bounces-60779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB106850951
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 13:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DF4428313E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 12:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD015A11B;
	Sun, 11 Feb 2024 12:54:00 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADFB8466;
	Sun, 11 Feb 2024 12:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707656039; cv=none; b=rkgEtexFrZeie447ImwZBZ64oNzP7PVgVNpRhgUgQEkiwjeVWVbqMM3kXxluYph5oU8QYuyPXWGCRXE0B3cnmKfX5lebpaclrVSsM5CMA7whertVvJBoOppMwdIqKgfZVz678s2EdPYOGV5W+BO39yCMeY1MG5+B1Lg+ecO+P94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707656039; c=relaxed/simple;
	bh=CQfthw3rkV9cCFLDE6lml5kSWrygmwenJhANwHY2V1U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P1+V6Eco9EpGH1LeCHAArvO/LL2E+/3L96Iey+GPYhiu7SuUJ8Zx7W5i1n/EKHRWY9QfgvsZ9TDqu5PQfxUe/zh5zX/1ayVfeMO/paIwKT3sy8GMnbbnHHSSQr/WDN+8qEHqaVJfnCjKW+e3/LicvqDTswVua628AKtEeKLB2wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 028FCDA7;
	Sun, 11 Feb 2024 04:54:32 -0800 (PST)
Received: from minigeek.lan (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1CE4C3F5A1;
	Sun, 11 Feb 2024 04:53:47 -0800 (PST)
Date: Sun, 11 Feb 2024 12:52:26 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, Arnaud Ferraris
 <arnaud.ferraris@collabora.com>, Alexey Klimov <alexey.klimov@linaro.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] arm64: dts: allwinner: a64: Add thermal trip points for
 GPU
Message-ID: <20240211125209.15d58462@minigeek.lan>
In-Reply-To: <20240211105326.506049-1-andrej.skvortzov@gmail.com>
References: <20240211105326.506049-1-andrej.skvortzov@gmail.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 11 Feb 2024 13:53:26 +0300
Andrey Skvortsov <andrej.skvortzov@gmail.com> wrote:

Hi Andrey,

> From: Alexey Klimov <alexey.klimov@linaro.org>
> 
> Without trip points for GPU, the following errors are printed in the
> dmesg log and the sun8i-thermal driver fails to load:

So how does that post differ from Alexey one's a few weeks back:
https://lore.kernel.org/linux-arm-kernel/20240101000008.65747-1-alexey.klimov@linaro.org/
It seems like the same patch?

And Jernej and I had some comments (no mentioning of "Linux" in commit
message, add cooling maps, source of trip temperature values), can you
please try to address them?


> thermal_sys: Failed to find 'trips' node
> thermal_sys: Failed to find trip points for thermal-sensor id=1
> sun8i-thermal: probe of 1c25000.thermal-sensor failed with error -22

I think it's pretty obvious that the trip points are missing when they
shouldn't, so this does not need too much explanation or rationale in
the commit message, so you can cut this short.

> When thermal zones are defined, trip points definitions are mandatory.
> Trip values for the GPU are assumed to be the same values as the CPU
> ones. The available specs do not provide any hints about thermal regimes
> for the GPU and it seems GPU is implemented on the same die as the CPU.
> 
> 'make dtbs_check' complains about problem in dts for 18 A64-based boards
> supported by the kernel:
> 
> sun50i-a64-pine64.dtb: thermal-zones: gpu0-thermal: 'trips' is a required property
> 	from schema $id: http://devicetree.org/schemas/thermal/thermal-zones.yaml#
> sun50i-a64-pine64.dtb: thermal-zones: gpu1-thermal: 'trips' is a required property
> 	from schema $id: http://devicetree.org/schemas/thermal/thermal-zones.yaml#
> 
> Tested on Pine a64+ and PinePhone 1.2.
> 
> Cc: Samuel Holland <samuel@sholland.org>
> Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
> Tested-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>

You would need your Signed-off-by: here, since you send this, even when
on Alexey's behalf.

Cheers,
Andre

> 
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 46 +++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> index 57ac18738c99..c25da7229e42 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -244,6 +244,29 @@ gpu0_thermal: gpu0-thermal {
>  			polling-delay-passive = <0>;
>  			polling-delay = <0>;
>  			thermal-sensors = <&ths 1>;
> +
> +			trips {
> +				gpu0_alert0: gpu0_alert0 {
> +					/* milliCelsius */
> +					temperature = <75000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				gpu0_alert1: gpu0_alert1 {
> +					/* milliCelsius */
> +					temperature = <90000>;
> +					hysteresis = <2000>;
> +					type = "hot";
> +				};
> +
> +				gpu0_crit: gpu0_crit {
> +					/* milliCelsius */
> +					temperature = <110000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
>  		};
>  
>  		gpu1_thermal: gpu1-thermal {
> @@ -251,6 +274,29 @@ gpu1_thermal: gpu1-thermal {
>  			polling-delay-passive = <0>;
>  			polling-delay = <0>;
>  			thermal-sensors = <&ths 2>;
> +
> +			trips {
> +				gpu1_alert0: gpu1_alert0 {
> +					/* milliCelsius */
> +					temperature = <75000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				gpu1_alert1: gpu1_alert1 {
> +					/* milliCelsius */
> +					temperature = <90000>;
> +					hysteresis = <2000>;
> +					type = "hot";
> +				};
> +
> +				gpu1_crit: gpu1_crit {
> +					/* milliCelsius */
> +					temperature = <110000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
>  		};
>  	};
>  



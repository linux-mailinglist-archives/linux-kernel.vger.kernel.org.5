Return-Path: <linux-kernel+bounces-31354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDDE832D08
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 17:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36CC4283255
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 16:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3E854FAC;
	Fri, 19 Jan 2024 16:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LvHZY+GM"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A947154F92
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 16:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705681276; cv=none; b=MjVl2iPo/VQvsVJ2v4/sRsxXAIVWLbTpoXBsigMKKBXo8vbqI3Xx4S9v9ndeZJNvV07sII9Wl4GKnrVD92mnZ050zFnLOam9deneWMfO3KUZFbE+I4k7xz94Ax8ZiXydmcd+r65DJ0rYvA6tXB26dx2kBUDzolpkGc2BKfdqYcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705681276; c=relaxed/simple;
	bh=8JaW94Lk8QgsccDDyDOsh9+ZEKHf9Oh/lDc8IdvEurU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mOAVNdjFnuOyNO8keut8gbuA7SXAsu6a817HO+8rs2kCRG16rSbNHNeHM/wasvXK7SObLi6jLpDP9aA0r3CcmVXiMhwkHJtAnZqFxlYLOYv87vefOsEnRWPtzhzbaNqKLE3bKw+hXQNqUKx123OZIV1qXUSROV0u9u28HI3iewc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LvHZY+GM; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-337cf4eabc9so666874f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 08:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705681273; x=1706286073; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4Et99TJn/9LrcxnPBg5MmEqO0M8peYvrbI0bmYPvx2M=;
        b=LvHZY+GMbx+gHJ8KGZ1zg6jqMBbAjctZa/YT4LHpak8bNSaaC0uX3tiV5Ahq8qosuK
         kI5XQmRsUtpv4QoksXuE3nt3wyVKBJgJ/Gcxw9hKasmfKmdSfccH/PHugprWUMKKr3MR
         b70wsWadefLO7/06g5km1OHlNmWivRMLR5VE+omt/3+4Z6oDf+cWRpOPtrFaPFQOAWoF
         UFVjDk2OxjvxMILWpkjcry0Ww7zGKn2Gg1AzxQ4q1ugji2aXeJl4GQ8fbBAQ3+wLL9sS
         YLILOEU7VrEVJ57g+ak7UeggvYOMaHeRNv5/4YwqJNYaPqnxN5yZbGz8S7zTboJJv2o6
         L/sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705681273; x=1706286073;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Et99TJn/9LrcxnPBg5MmEqO0M8peYvrbI0bmYPvx2M=;
        b=mv08vyQMQ97nXOFCOhLQkRb5OvzTyaCFqTxE/ClQ6xmuYSbhEkBzgQsmJsQQxboMVu
         XVU44iNbz9Mmd2N7tXvPTKn4uDBhg+bmwyPx7knS075O71coN9N0AOJPBngAM0Wq0B/L
         SG3WHz5mActoFd5NDdTAhpmz24yLpu/BpUWfMK0XW9PiYQifbE1iFP8HCXdP3qvklj9H
         znltfPcWJ6JPhrd7eL2H+kardljTuqrPgC0k482Ai/YTHrCnh16tudYsGhXCVHiY7+2L
         C/g2IIOIKMCnh3NO5blgBq0CpJ6hmMKiWrn3K8Vt72ZUCGS5L6I9i64+GRqpVPPM105d
         pWYQ==
X-Gm-Message-State: AOJu0Yw80gGJAReEHPX4KTdz4xC3YuFlHJmtO87o8r+WSbrPHbaewakT
	N9fB3kxDOxrZQoN7OLf3skDrMR6kKCsaPs8yanKvtr9KoDXxL3NgrUu6D4jht9g=
X-Google-Smtp-Source: AGHT+IEksNHi+z3W/UPJGCEhYWxuI2PhBzwQkLHsDvVjtq+JN3bnKj1kybphCbVmjTWLW27uO5WXLg==
X-Received: by 2002:a5d:4904:0:b0:338:d6c5:e9e9 with SMTP id x4-20020a5d4904000000b00338d6c5e9e9mr641365wrq.138.1705681272827;
        Fri, 19 Jan 2024 08:21:12 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:80ec:9cf:f853:831a? ([2a05:6e02:1041:c10:80ec:9cf:f853:831a])
        by smtp.googlemail.com with ESMTPSA id n13-20020a5d51cd000000b0033673ddd81csm6808214wrv.112.2024.01.19.08.21.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jan 2024 08:21:12 -0800 (PST)
Message-ID: <c517f26c-34bc-4b99-b744-8e2549cd28b5@linaro.org>
Date: Fri, 19 Jan 2024 17:21:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: rockchip: enable built-in thermal
 monitoring on rk3588
Content-Language: en-US
To: Alexey Charkov <alchark@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Christopher Obbard <chris.obbard@collabora.com>,
 =?UTF-8?B?VGFtw6FzIFN6xbFjcw==?= <szucst@iit.uni-miskolc.hu>,
 Shreeya Patel <shreeya.patel@collabora.com>,
 Kever Yang <kever.yang@rock-chips.com>, Jagan Teki <jagan@edgeble.ai>,
 Chris Morgan <macromorgan@hotmail.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240106222357.23835-1-alchark@gmail.com>
 <20240109192608.5981-1-alchark@gmail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240109192608.5981-1-alchark@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09/01/2024 20:19, Alexey Charkov wrote:
> Include thermal zones information in device tree for rk3588 variants
> and enable the built-in thermal sensing ADC on RADXA Rock 5B
> 
> Signed-off-by: Alexey Charkov <alchark@gmail.com>
> ---
> Changes in v2:
>   - Dropped redundant comments
>   - Included all CPU cores in cooling maps
>   - Split cooling maps into more granular ones utilizing TSADC
>     channels 1-3 which measure temperature by separate CPU clusters
>     instead of channel 0 which measures the center of the SoC die
> ---
>   .../boot/dts/rockchip/rk3588-rock-5b.dts      |   4 +
>   arch/arm64/boot/dts/rockchip/rk3588s.dtsi     | 151 ++++++++++++++++++
>   2 files changed, 155 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> index a5a104131403..f9d540000de3 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> @@ -772,3 +772,7 @@ &usb_host1_ehci {
>   &usb_host1_ohci {
>   	status = "okay";
>   };
> +
> +&tsadc {
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> index 8aa0499f9b03..8d54998d0ecc 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> @@ -10,6 +10,7 @@
>   #include <dt-bindings/reset/rockchip,rk3588-cru.h>
>   #include <dt-bindings/phy/phy.h>
>   #include <dt-bindings/ata/ahci.h>
> +#include <dt-bindings/thermal/thermal.h>
>   
>   / {
>   	compatible = "rockchip,rk3588";
> @@ -2112,6 +2113,156 @@ tsadc: tsadc@fec00000 {
>   		status = "disabled";
>   	};
>   
> +	thermal_zones: thermal-zones {
> +		/* sensor near the center of the whole chip */
> +		soc_thermal: soc-thermal {
> +			polling-delay-passive = <20>;

There is no mitigation set for this thermal zone. It is pointless to 
specify a passive polling.

> +			polling-delay = <1000>;

The driver is interrupt driven. No need to poll.

> +			sustainable-power = <2100>;

There is no mitigation with this thermal zone. Specifying a sustainable 
power does not make sense.

> +			thermal-sensors = <&tsadc 0>;
> +
> +			trips {
> +				soc_crit: soc-crit {
> +					temperature = <115000>;
> +					hysteresis = <2000>;

This trip point leads to a system shutdown / reboot. It is not necessary 
to specify a hysteresis.

> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		/* sensor between A76 cores 0 and 1 */
> +		bigcore0_thermal: bigcore0-thermal {
> +			polling-delay-passive = <20>;
> +			polling-delay = <1000>;

The driver is interrupt driven. No need to poll.

> +			thermal-sensors = <&tsadc 1>;
> +
> +			trips {
> +				bigcore0_alert: bigcore0-alert {
> +					temperature = <85000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +				bigcore0_crit: bigcore0-crit {
> +					temperature = <115000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +			cooling-maps {
> +				map0 {
> +					trip = <&bigcore0_alert>;
> +					cooling-device =
> +						<&cpu_b0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&cpu_b1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +					contribution = <1024>;

If you specify the contribution, that means it is expected to use the 
IPA governor. However, this one needs an extra trip point before 'alert' 
to begin collecting temperatures in order to initialize the PID loop of 
the IPA.

> +				};
> +			};
> +		};
> +
> +		/* sensor between A76 cores 2 and 3 */
> +		bigcore2_thermal: bigcore2-thermal {
> +			polling-delay-passive = <20>;
> +			polling-delay = <1000>;

The driver is interrupt driven. No need to poll.

> +			thermal-sensors = <&tsadc 2>;
> +
> +			trips {
> +				bigcore2_alert: bigcore2-alert {
> +					temperature = <85000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +				bigcore2_crit: bigcore2-crit {
> +					temperature = <115000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +			cooling-maps {
> +				map1 {
> +					trip = <&bigcore2_alert>;
> +					cooling-device =
> +						<&cpu_b2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&cpu_b3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +					contribution = <1024>;
> +				};
> +			};
> +		};
> +
> +		/* sensor between the four A55 cores */
> +		little_core_thermal: littlecore-thermal {
> +			polling-delay-passive = <20>;
> +			polling-delay = <1000>;

The driver is interrupt driven. No need to poll.

> +			thermal-sensors = <&tsadc 3>;
> +
> +			trips {
> +				littlecore_alert: littlecore-alert {
> +					temperature = <85000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +				littlecore_crit: littlecore-crit {
> +					temperature = <115000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +			cooling-maps {
> +				map2 {
> +					trip = <&littlecore_alert>;
> +					cooling-device =
> +						<&cpu_l0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&cpu_l1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&cpu_l2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&cpu_l3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +					contribution = <1024>;
> +				};
> +			};
> +		};
> +
> +		/* sensor near the PD_CENTER power domain */
> +		center_thermal: center-thermal {
> +			polling-delay-passive = <20>;
> +			polling-delay = <1000>;

Same comment as above for "soc-thermal"

> +			thermal-sensors = <&tsadc 4>;
> +
> +			trips {
> +				center_crit: center-crit {
> +					temperature = <115000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		gpu_thermal: gpu-thermal {
> +			polling-delay-passive = <20>;
> +			polling-delay = <1000>;

Same comment as above for "soc-thermal"



> +			thermal-sensors = <&tsadc 5>;
> +
> +			trips {
> +				gpu_crit: gpu-crit {
> +					temperature = <115000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		npu_thermal: npu-thermal {
> +			polling-delay-passive = <20>;
> +			polling-delay = <1000>;

Same comment as above for "soc-thermal"


> +			thermal-sensors = <&tsadc 6>;
> +
> +			trips {
> +				npu_crit: npu-crit {
> +					temperature = <115000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +	};
> +
>   	saradc: adc@fec10000 {
>   		compatible = "rockchip,rk3588-saradc";
>   		reg = <0x0 0xfec10000 0x0 0x10000>;

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog



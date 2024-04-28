Return-Path: <linux-kernel+bounces-161248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 173D08B4986
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 05:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7176282121
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 03:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCD04436;
	Sun, 28 Apr 2024 03:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TxJm0xxG"
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F86B1876;
	Sun, 28 Apr 2024 03:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714276457; cv=none; b=CJbWO+12Llszlw8Qk2sBySkk16jUznx4MVJgzShh9q/STaNHqX/2mKyoiOb6MHtlaiIA8/GV7J/+T3U8xvCbAThWPHGZ/FSqgpqwN4NxFBnO6m6C6ygJGZAItMAbqit1udlqMtfw8ujwXyXiVnclZIw3o3p5Fjz8S3kvacVighY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714276457; c=relaxed/simple;
	bh=aNjB07W8U36J0nUWbKqxP/4UyrwGwcvrCUmVtPtMEdM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ebRkkGr6LDlp5Dv6br4kmYZ5HZEnq3e1lJTacqmScKKBrFcjpbOkVAUDDzEFzyona3b9yRox1ZSPpfZJqN8M8hvTCSDum8PMa34O5JVX1UR0e9O3t8690A+BXUbaw+pvimtXd6nDhFh9jyhts4yRIeJ19Aw7ZA06BtXBFnMfxcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TxJm0xxG; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-23319017c4cso2199686fac.2;
        Sat, 27 Apr 2024 20:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714276454; x=1714881254; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CLpY/XhI5HbcFTKFtWlC5rSdt0Q9kJF4aY4r/ezxW9w=;
        b=TxJm0xxGFzwYdxIThSqm0tYBGLao7SajxxxXLJB0XBrFQ8oADrZ7rhZ4iOzswJEOJA
         ipuiXTbevALWbruTbW8wqcMAMRhCaagP4E8hW7yxqeI8bEy/QkF8THlU26X0z+7j1bil
         7Pe+Q1ATKgA3SoQZgG5K7xpy2XcDALwVD1zo5qJeSLIJo0ylAZTOGBYXHrLTUQ0atLx/
         abWlyYSIzKP7xS6lo8LyGQXQmfJvaQLI6BWg59jWzjSe2k+ZlQLz7hN52fmoFdzsZHym
         wdugt96xGh1IU7vqG6ZOUBSM1Md+wjOAxJp0O/aYzN/K6E333TLaVzH4BC7jf0osLTV/
         Rw/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714276454; x=1714881254;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CLpY/XhI5HbcFTKFtWlC5rSdt0Q9kJF4aY4r/ezxW9w=;
        b=R1wIGwi9DdQfUkGCR/gIn6Tf13Bt8QZTheX6y7QAg4ddKyrNZwYKBOw5LLX8gxvRvJ
         u5pWR97jCVU8+TezQFvlbFz+BhUt7ZgkxoLo7ZUqAJeWWb/O89HP6yzq2xKvRQhNgV1j
         HfE/JVPca0lb/rjoqi7erm94YSXRvXxsHOHd6F3l5tgKJfLkQ8M4c0e0oWDOljEB+FuC
         iqGVPNd5FsRlp0FLX6BGPNydnOumKFFH2Urpk/4rDN68YotKOV3jKb301Q8p/oCgSbAc
         05a1ZH3AQqDfr11TZDExmI5UCz80sNKPBsibeohfzxy+WfrxR5SyRnwPWeRb1KfajDAY
         OA6A==
X-Forwarded-Encrypted: i=1; AJvYcCVPOxxvI6XWBGaejOUti9ojih4kCb4c6C6EBQWu4w+4PCuOOc6iWXndEJ2HtTO3IVtRcjZlq8+6E3Eak6fzrCMWEi2QTHzyPSJPmqIocQD18yLQyn5F6k2eeiWCIYsWCpiw/i5IOBe00k1G75wz5MD2hhm9LLCY4hcEsK/tLi0aEMp7p7DX9ZQ=
X-Gm-Message-State: AOJu0Yw0rZvq343bRQi+n6OSod/4+zhnPrhuVyIJ06WeP1HZKpVPPyXG
	5QlR9E4CwZgNQBIu56O5ICIG4x/GSsRSsrfORJ7MGHe8PL6H+2VO
X-Google-Smtp-Source: AGHT+IECFoxzkYPE9JmOaGsxWZcrK5Todisg8/d+PBvt5Xw6UOu42wHTOHTWW5/gCiRYyLITGDlz4w==
X-Received: by 2002:a05:6870:f22a:b0:22e:c787:5fa2 with SMTP id t42-20020a056870f22a00b0022ec7875fa2mr7294645oao.58.1714276454353;
        Sat, 27 Apr 2024 20:54:14 -0700 (PDT)
Received: from [0.0.0.0] (42-3-109-144.ptr.netvigator.com. [42.3.109.144])
        by smtp.gmail.com with ESMTPSA id fb12-20020a056a002d8c00b006f3ec69bc09sm1968853pfb.75.2024.04.27.20.54.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Apr 2024 20:54:13 -0700 (PDT)
Message-ID: <f80384eb-d7eb-4a68-952d-529230ec51a6@gmail.com>
Date: Sun, 28 Apr 2024 11:54:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] arm64: dts: qcom: Add AYN Odin 2
To: Krzysztof Kozlowski <krzk@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Junhao Xie <bigfoot@classfun.cn>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Tengfei Fan <quic_tengfan@quicinc.com>,
 Molly Sophia <mollysophia379@gmail.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org
References: <20240424-ayn-odin2-initial-v1-0-e0aa05c991fd@gmail.com>
 <20240424-ayn-odin2-initial-v1-10-e0aa05c991fd@gmail.com>
 <0d1c6ed9-0c20-4b0e-876d-4b0adf5aa75d@kernel.org>
Content-Language: en-US
From: Xilin Wu <wuxilin123@gmail.com>
In-Reply-To: <0d1c6ed9-0c20-4b0e-876d-4b0adf5aa75d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/4/25 14:28, Krzysztof Kozlowski wrote:
> On 24/04/2024 17:29, Xilin Wu via B4 Relay wrote:
>> From: Xilin Wu <wuxilin123@gmail.com>
>>
>> AYN Odin 2 is a gaming handheld based on QCS8550, which is derived
>> from SM8550 but without modem RF system.
>>
> 
> 
> 
>> +
>> +/ {
>> +	model = "AYN Odin 2";
>> +	compatible = "ayn,odin2", "qcom,qcs8550", "qcom,sm8550";
>> +	chassis-type = "handset";
>> +
>> +	qcom,msm-id = <QCOM_ID_QCS8550 0x20000>;
>> +	qcom,board-id = <0x1001f 0>;
> 
> No, these are not allowed. You did not test your dts.
> 
> It does not look like you tested the DTS against bindings. Please run
> `make dtbs_check W=1` (see
> Documentation/devicetree/bindings/writing-schema.rst or
> https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
> for instructions).
> 
>> +
>> +	aliases {
>> +		serial0 = &uart7;
>> +		serial1 = &uart14;
>> +		serial2 = &uart15;
>> +	};
>> +
>> +	backlight: backlight {
>> +		compatible = "pwm-backlight";
>> +		pwms = <&pmk8550_pwm 0 860000>;
>> +		brightness-levels = <1023 0>;
>> +		num-interpolated-steps = <1023>;
>> +		default-brightness-level = <600>;
>> +		power-supply = <&vph_pwr>;
>> +		enable-gpios = <&pmk8550_gpios 5 GPIO_ACTIVE_HIGH>;
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&pwm_backlight_default>;
>> +		status = "okay";
> 
> Drop, why do you need it? Do you see it anywhere else in the backlight
> nodes in DTS?
> 
> 
>> +	};
>> +
>> +	fan_pwr: fan-pwr-regulator {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "fan_pwr";
>> +
>> +		regulator-min-microvolt = <5000000>;
>> +		regulator-max-microvolt = <5000000>;
>> +
>> +		gpio = <&tlmm 109 GPIO_ACTIVE_HIGH>;
>> +		enable-active-high;
>> +
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&fan_pwr_en>;
>> +
>> +		regulator-state-mem {
>> +			regulator-off-in-suspend;
>> +		};
>> +	};
>> +
>> +	gpio-keys {
>> +		compatible = "gpio-keys";
>> +
>> +		pinctrl-0 = <&volume_up_n>, <&m1_m2_keys_default>;
>> +		pinctrl-names = "default";
>> +
>> +		key-volume-up {
>> +			label = "Volume Up";
>> +			linux,code = <KEY_VOLUMEUP>;
>> +			gpios = <&pm8550_gpios 6 GPIO_ACTIVE_LOW>;
>> +			debounce-interval = <15>;
>> +			linux,can-disable;
>> +			wakeup-source;
>> +		};
>> +
>> +		m1-button {
>> +			label = "M1";
>> +			linux,code = <BTN_TRIGGER_HAPPY1>;
>> +			gpios = <&tlmm 57 GPIO_ACTIVE_LOW>;
>> +		};
>> +
>> +		m2-button {
>> +			label = "M2";
>> +			linux,code = <BTN_TRIGGER_HAPPY2>;
>> +			gpios = <&tlmm 58 GPIO_ACTIVE_LOW>;
>> +		};
>> +	};
>> +
>> +	hdmi-out {
>> +		compatible = "hdmi-connector";
>> +		type = "d";
>> +		hpd-gpios = <&tlmm 9 GPIO_ACTIVE_HIGH>;
>> +
>> +		port {
>> +			hdmi_con: endpoint {
>> +				remote-endpoint = <&lt8912_out>;
>> +			};
>> +		};
>> +	};
>> +
>> +	hdmi_pwr: hdmi-pwr-regulator {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "hdmi_pwr";
>> +
>> +		regulator-min-microvolt = <1800000>;
>> +		regulator-max-microvolt = <1800000>;
>> +
>> +		gpio = <&tlmm 10 GPIO_ACTIVE_HIGH>;
>> +		enable-active-high;
>> +	};
>> +
>> +	vdd_lcm_2p8: vdd-lcm-2p8-regulator {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "vdd_lcm_2p8";
>> +
>> +		regulator-min-microvolt = <2800000>;
>> +		regulator-max-microvolt = <2800000>;
>> +
>> +		gpio = <&tlmm 142 GPIO_ACTIVE_HIGH>;
>> +		enable-active-high;
>> +	};
>> +
>> +	led_left_side: led-controller-1 {
>> +		compatible = "pwm-leds-multicolor";
>> +
>> +		multi-led {
>> +			label = "left-side";
>> +			color = <LED_COLOR_ID_RGB>;
>> +			max-brightness = <255>;
>> +
>> +			led-red {
>> +				color = <LED_COLOR_ID_RED>;
>> +				pwms = <&pwm_rgb_left 0>;
>> +			};
>> +
>> +			led-green {
>> +				color = <LED_COLOR_ID_GREEN>;
>> +				pwms = <&pwm_rgb_left 1>;
>> +			};
>> +
>> +			led-blue {
>> +				color = <LED_COLOR_ID_BLUE>;
>> +				pwms = <&pwm_rgb_left 2>;
>> +			};
>> +		};
>> +	};
>> +
>> +	led_left_joystick: led-controller-2 {
>> +		compatible = "pwm-leds-multicolor";
>> +
>> +		multi-led {
>> +			label = "left-joystick";
>> +			color = <LED_COLOR_ID_RGB>;
>> +			max-brightness = <255>;
>> +
>> +			led-red {
>> +				color = <LED_COLOR_ID_RED>;
>> +				pwms = <&pwm_rgb_left 6>;
>> +			};
>> +
>> +			led-green {
>> +				color = <LED_COLOR_ID_GREEN>;
>> +				pwms = <&pwm_rgb_left 7>;
>> +			};
>> +
>> +			led-blue {
>> +				color = <LED_COLOR_ID_BLUE>;
>> +				pwms = <&pwm_rgb_left 8>;
>> +			};
>> +		};
>> +	};
>> +
>> +	led_right_side: led-controller-3 {
>> +		compatible = "pwm-leds-multicolor";
>> +
>> +		multi-led {
>> +			label = "right-side";
>> +			color = <LED_COLOR_ID_RGB>;
>> +			max-brightness = <255>;
>> +
>> +			led-red {
>> +				color = <LED_COLOR_ID_RED>;
>> +				pwms = <&pwm_rgb_right 0>;
>> +			};
>> +
>> +			led-green {
>> +				color = <LED_COLOR_ID_GREEN>;
>> +				pwms = <&pwm_rgb_right 1>;
>> +			};
>> +
>> +			led-blue {
>> +				color = <LED_COLOR_ID_BLUE>;
>> +				pwms = <&pwm_rgb_right 2>;
>> +			};
>> +		};
>> +	};
>> +
>> +	led_right_joystick: led-controller-4 {
>> +		compatible = "pwm-leds-multicolor";
>> +
>> +		multi-led {
>> +			label = "right-joystick";
>> +			color = <LED_COLOR_ID_RGB>;
>> +			max-brightness = <255>;
>> +
>> +			led-red {
>> +				color = <LED_COLOR_ID_RED>;
>> +				pwms = <&pwm_rgb_right 6>;
>> +			};
>> +
>> +			led-green {
>> +				color = <LED_COLOR_ID_GREEN>;
>> +				pwms = <&pwm_rgb_right 7>;
>> +			};
>> +
>> +			led-blue {
>> +				color = <LED_COLOR_ID_BLUE>;
>> +				pwms = <&pwm_rgb_right 8>;
>> +			};
>> +		};
>> +	};
>> +
>> +	mcu_3v3: mcu-3v3-regulator {
> 
> Name all regulators regulator-n, where n is decimal number. Then order
> the nodes by name.
> 
> 
> ...
> 
>> +
>> +&i2c4 {
>> +	clock-frequency = <400000>;
>> +	status = "okay";
>> +
>> +	touchscreen@20 {
>> +		compatible = "syna,rmi4-i2c";
>> +		reg = <0x20>;
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +		interrupts-extended = <&tlmm 25 0x2008>;
>> +
>> +		pinctrl-names = "default", "sleep";
>> +		pinctrl-0 = <&ts_int_default>;
>> +		pinctrl-1 = <&ts_int_sleep>;
>> +
>> +		vio-supply = <&vreg_l12b_1p8>;
>> +
>> +		syna,startup-delay-ms = <200>;
>> +		syna,reset-delay-ms = <200>;
>> +
>> +		rmi4-f01@1 {
>> +			syna,nosleep-mode = <0x1>;
>> +			reg = <0x1>;
>> +		};
>> +
>> +		rmi4-f12@12 {
>> +			reg = <0x12>;
>> +			syna,rezero-wait-ms = <20>;
>> +			syna,clip-x-low = <0>;
>> +			syna,clip-y-low = <0>;
>> +			syna,clip-x-high = <1080>;
>> +			syna,clip-y-high = <1920>;
>> +			syna,sensor-type = <1>;
>> +			touchscreen-inverted-x;
>> +		};
>> +	};
> 
> Please confirm the status of dtbs_check for your board. I am pretty sure
> it fails.
> 
> Best regards,
> Krzysztof
> 

I will correct all the mistakes in v2. Thanks for catching them!

-- 
Thanks,
Xilin Wu



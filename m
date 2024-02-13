Return-Path: <linux-kernel+bounces-63132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57225852B56
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD50C1F23F0F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0769E1B592;
	Tue, 13 Feb 2024 08:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ulUePcVn"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E607E182D2
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 08:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707813599; cv=none; b=B2kE9G3TUleaf8cs8YsEAQ655y53I4gMz+5GYASX8NGE+lQlyKK0W4JRefo6PO8M9cQ2ew1aU2ialJNsEZJHiCSEcRpFyMLE8RySl2uF3XUsYOu1UJXLzNCse0MMc1Bn9rFFKFq0EHqy4UUkpXR831dv063Y8YctrUAmEiNt8DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707813599; c=relaxed/simple;
	bh=CXODdfHRF8EcwyoTQZNwzppKR+EmBpLtqQj9CeT169k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dA4/a1hK179rY7X9PouPOjLEi0c+R9P6pt8r0Wsi26f9vlYs9lc55xpO8+IiMPbV5Atb7MiBaF4FOLOg7PHz1LMvLorbPF2zhsz9Fd9fzOx3LYL8S5JgUyRttPWpuqM0/dpZ+uZ6GL6D21Rr18MRYnfDTzqo4lo8nsJOFw4wAMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ulUePcVn; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-511898b6c9eso2321001e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 00:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707813594; x=1708418394; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P3RxmLsVbnbUP7U67nLjdpooWU8Ch7hTMjG3mEOZDbU=;
        b=ulUePcVnNTD/Pl7uYqzGh7F7oKSKovOoaZ4gNWLdUQtmJ5gn2q0ciGNdb4St0XVMaB
         LIJeHHeXxaqobYBXOjBYP93xVhAl3mN04Xaf+jW9v6ARsCffjzoD/RMbT3lNULlQPIVL
         tcGaRryxjuMbFWyo2xSt14NqEr1ePLQqSfUtI5/fHbO9dJkMc7OZGHkqrDmU5ajz/2fi
         49aTneSU8znX6pHCppkI2GPXK2X/7FmhoYVHx0gKU4tqpEEMg8ZgXqvJM06r+LiCX09y
         w1YBKWNTXmV55Z3mvhla+rYNzSm8yBER5u8CGZQANlOA727WRfTLItnHSY7QMpSNDNyB
         Sb+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707813594; x=1708418394;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P3RxmLsVbnbUP7U67nLjdpooWU8Ch7hTMjG3mEOZDbU=;
        b=WR/8Cq4wbI/cFsen2ilAnnio6YY9ij6+wrQr3KokgpLNtdSx15by3LMwJqt0rsjO8K
         YRpOqR9JJZ/SkXKGIvxiW/FmV+Rq7wIb2O2AyKS8KoNlzQNF3kjEIk6VURrk/zebXYzH
         k+jnV7hCioD3p9FOLxb/DaMpXcvLA+Z94bvq+XparxjoK5MFEFNegJoAmlgaMO+d6SkE
         flgmQUdr5/bOqSOpTQOftCzqQY59KiuDbdkKciST2n5x0VKccQlyFx7nlzzP9TjLBI8B
         3ZCvMl5sZDOfvNTIpjwGrETfLjGMzraLX4qBJZtOliRqJdLf6DqVAPabjNCG9bWr8QYx
         zfIA==
X-Forwarded-Encrypted: i=1; AJvYcCXJEmDaylk+EeP+FWQRukqZ6xqstY2feTQJ4bQ3XjySKHCi1AINVQBRdHs/XhK/VMAezmIzVunanTpSgxberAqvmYF7waLYwWT90Dpo
X-Gm-Message-State: AOJu0YxoAfyZlk5oFx1NGlZrQROHq0I0aYUKVUa6iW5fd5Xh8A9j71wJ
	6lInmRDCALCg8qeVdPY3PePkrdW0SIj+5irBNOMoM0q2fYpWi67rO5tC2AZsgpU=
X-Google-Smtp-Source: AGHT+IEH3Y9V61oP0zkkNyBFwQQBwSuQrMQ1YQBzaqzcnW/20KC7jvRaJxDo3NmvpY6fgru/1HHtrA==
X-Received: by 2002:a05:6512:328a:b0:511:4e91:4a3b with SMTP id p10-20020a056512328a00b005114e914a3bmr5133344lfe.50.1707813593931;
        Tue, 13 Feb 2024 00:39:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXfAKyUSJ4CbSRGWbArh7A4ov21ceEh49P1pwWaUQGPnG0VBwNQf2xF19vLdlUIwKs/LTiz13R2p0qoByANO/yd+xc0OQsRAf1Ob0dJ47LM38oxbQmIkh83xVzjdm5ECjKD1BJLEdGJ3Vvs4c73gETWs1gZcwXt/Fo4CVv7Mzz6jPiz4a8M2RpO8lUyK3LCHM62F79dwXUNZGU+2pwYE5jMzmMYy7l9Kmu7fCCmoes8LINwbhByJJGhON0poMw7HiBFEUYXsSbIpep/5d12SSUOPkLBuli2U1cycYJ1EjLEf2KsCko6lXa9LVuIPjp2vXe5XZFJG7aYnfDo6Za560T/h7ImfM7bhMh9BbPV0bnEx0PTauodvGRt4g==
Received: from [192.168.1.20] ([178.197.223.6])
        by smtp.gmail.com with ESMTPSA id jg8-20020a05600ca00800b00410820995dcsm10446311wmb.23.2024.02.13.00.39.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 00:39:53 -0800 (PST)
Message-ID: <efbd57e8-6cbb-480e-b2d5-1d064a27b3a4@linaro.org>
Date: Tue, 13 Feb 2024 09:39:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: sa8295p: Enable tertiary
 controller and its 4 USB ports
Content-Language: en-US
To: Krishna Kurapati <quic_kriskura@quicinc.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, quic_ppratap@quicinc.com,
 quic_jackp@quicinc.com
References: <20240213082724.1789096-1-quic_kriskura@quicinc.com>
 <20240213082724.1789096-3-quic_kriskura@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240213082724.1789096-3-quic_kriskura@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/02/2024 09:27, Krishna Kurapati wrote:
> Multiport USB controller (host-only) of SA8295 ADP has 4 Type-A ports
> exposed for connecting peripherals. The VBUS to these peripherals is
> provided by TPS2559QWDRCTQ1 regulators connected to these ports. Each
> regulator has an enable pin controlled by PMM8540. Since these regulators
> are GPIO controlled regulators, model them as fixed regulators and keep
> them Always-On at boot since we are wakeup capable and we don't need to
> turn them off on suspend. Also since we don't enter device mode, these
> regulators can be kept on.
> 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sa8295p-adp.dts | 83 ++++++++++++++++++++++++
>  1 file changed, 83 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> index fd253942e5e5..49418843c214 100644
> --- a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> +++ b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> @@ -9,6 +9,7 @@
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>  #include <dt-bindings/spmi/spmi.h>
> +#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
>  
>  #include "sa8540p.dtsi"
>  #include "sa8540p-pmics.dtsi"
> @@ -108,6 +109,46 @@ edp3_connector_in: endpoint {
>  			};
>  		};
>  	};
> +
> +	regulator-usb2-vbus {
> +		compatible = "regulator-fixed";
> +		regulator-name = "USB2_VBUS";
> +		gpio = <&pmm8540c_gpios 9 GPIO_ACTIVE_HIGH>;
> +		pinctrl-0 = <&usb2_en>;
> +		pinctrl-names = "default";
> +		enable-active-high;
> +		regulator-always-on;
> +	};
> +
> +	regulator-usb3-vbus {
> +		compatible = "regulator-fixed";
> +		regulator-name = "USB3_VBUS";
> +		gpio = <&pmm8540e_gpios 5 GPIO_ACTIVE_HIGH>;
> +		pinctrl-0 = <&usb3_en>;
> +		pinctrl-names = "default";
> +		enable-active-high;
> +		regulator-always-on;
> +	};
> +
> +	regulator-usb4-vbus {
> +		compatible = "regulator-fixed";
> +		regulator-name = "USB4_VBUS";
> +		gpio = <&pmm8540g_gpios 5 GPIO_ACTIVE_HIGH>;
> +		pinctrl-0 = <&usb4_en>;
> +		pinctrl-names = "default";
> +		enable-active-high;
> +		regulator-always-on;
> +	};
> +
> +	regulator-usb5-vbus {
> +		compatible = "regulator-fixed";
> +		regulator-name = "USB5_VBUS";
> +		gpio = <&pmm8540g_gpios 9 GPIO_ACTIVE_HIGH>;
> +		pinctrl-0 = <&usb5_en>;
> +		pinctrl-names = "default";
> +		enable-active-high;
> +		regulator-always-on;

Why all these regulators are always on? If USB controller does not probe
for any reason, why keeping them enabled? These must not be always-on,
but instead used by connector as VBUS supply (or by whatever you have
there for USB).

Best regards,
Krzysztof



Return-Path: <linux-kernel+bounces-66406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C61855C4C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 360BF1F2396B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 08:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B227C14002;
	Thu, 15 Feb 2024 08:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rDeHxBKZ"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3B613FE4
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 08:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707985184; cv=none; b=OpsDIQ0kq6LhC1eI7ePP0o0x3HNCH8BO7Pk7I9Jl6Gz3SjeW+4Tsd1LMNgJaMC3fEGxi6npLmHviV0pB9gWXkIF9dJj+FqPfosKR4vdt2D7uBBkbGc8QHd7O9dtcKo3891XAI9ZlE1cEmT5I6pD9rjHJMq2YJ4VRxFusUb5JPlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707985184; c=relaxed/simple;
	bh=EfTZYVaSsX1s35Y58/dkJBvUW4r4Q5Z0373ngEMDH4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ItESQjQtNeYm//495Ht+jWg3qDPBdvUxpdenF9MtB2BPZENeA2f0/C9ALACVCDdoXLBy4J2LWpGYuWrMubd5cn6iO5daOiIShUkgeL87+C8oAMFph9oP+Wb7swppxoD7BhuBgM8Ne7vluqLTUAzE8KGhjAm3DwEsVzUZ6MBWNLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rDeHxBKZ; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a3daa39b9e2so4375266b.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 00:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707985181; x=1708589981; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fsMsBaPXEY2l9yW0J2IWwe7XAIQs9QLuwKD0eEvS9fs=;
        b=rDeHxBKZtFWszhz3Tswi7EuNNNepVU9nv4typG2icAr7muQcLwiCfQ/2CoJYVR5GeM
         cSrbPfzNN/lxQi5GC/Z0jmFNAwQGIsmo3nf0EYGw3PA8hMk+sx8n6NqQJB27bIvgUUdk
         aBsyxA9OxZXjUAW8SNKu6KTGq8H3yNM9Vae7mlv4tSl2hXtE1TqXuOWuOemha5LCBgEE
         om0erhjRBwDxpQMY8OKbp/JXpIokOeg+y8NmFe8oPtqrtgElNcLHl+Drt78Ll01EfzHx
         +sN+Ql/FemVLXS1FKUDTYWROMATEOuDhKFsPqtaXEe2pFd66J8TFlI7n/8I0VdV4gQle
         M1ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707985181; x=1708589981;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fsMsBaPXEY2l9yW0J2IWwe7XAIQs9QLuwKD0eEvS9fs=;
        b=CgU+4pYZhgK1lwfxH3E8+f+OMbPGquY68QePuFLi/k64TnBt8J6SfYOtubRx4ZmJKl
         qeouizfBBStZ7Sw5FjVR9VQK0w0gvkI7TtvwJax5tfPnviyMncHGltTPzXxlNTvwzO4z
         cgdgGFvQcG/Prpe+P8Fvhw2AMz0McQrRnHBvWiY1XqAe/Li2rL+WenTI5R4Se383aTWU
         XIq7Yfvkk1fbaRjLygSTdPF2KtNgKb5xG2wcCP/W5xXPWkJdRGkOAtmpDnNsbv3L+WMu
         d9IFYRfr4eXs04ubHdfPQi1TGU2ISP/iP6LmEstkbgdiFdiTaADnBYbWXAM6tgjb/7XV
         VHew==
X-Forwarded-Encrypted: i=1; AJvYcCXwJHB2lhuIC1xmeQw3OWBn4jFiNwf6aQH4sZUrYD9VY45xnyMKdAM5yYm6k0dxAh8BVKdRFZASREX047HXMX9PXphGR/1tnehhqnRO
X-Gm-Message-State: AOJu0YzcnhanhGmh1d7oSGi10FV3Ii9GqYRel28MMIghNhwzk5/hTJ2G
	ioOKxFxkNFOfHMEn5CHYLUbA6Ru66EAbkfu8zBAqFYvQcTCMW5P83QSAn/W/89Y=
X-Google-Smtp-Source: AGHT+IFGNIH/33A0icX9mLlSZ18BjKZS+FIoDET8RTiSLKjiGIiOqwaRV9V/uOY6xlSxFj+1ryWuFg==
X-Received: by 2002:a17:906:1811:b0:a3d:9b4b:c6d with SMTP id v17-20020a170906181100b00a3d9b4b0c6dmr476963eje.27.1707985181041;
        Thu, 15 Feb 2024 00:19:41 -0800 (PST)
Received: from [192.168.0.22] ([78.10.207.130])
        by smtp.gmail.com with ESMTPSA id v12-20020aa7d64c000000b00562156c563esm316898edr.33.2024.02.15.00.19.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 00:19:40 -0800 (PST)
Message-ID: <1a033944-9361-4576-8807-35a68c1e8548@linaro.org>
Date: Thu, 15 Feb 2024 09:19:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: sa8295p: Enable tertiary
 controller and its 4 USB ports
To: Bjorn Andersson <andersson@kernel.org>
Cc: Krishna Kurapati <quic_kriskura@quicinc.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 quic_ppratap@quicinc.com, quic_jackp@quicinc.com
References: <20240213082724.1789096-1-quic_kriskura@quicinc.com>
 <20240213082724.1789096-3-quic_kriskura@quicinc.com>
 <efbd57e8-6cbb-480e-b2d5-1d064a27b3a4@linaro.org>
 <mko2tdjrc4fbpbuig7o4jbznzxr7y6fsw42synu6yur4qzjgtt@nd7eyojiruvd>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <mko2tdjrc4fbpbuig7o4jbznzxr7y6fsw42synu6yur4qzjgtt@nd7eyojiruvd>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/02/2024 03:41, Bjorn Andersson wrote:
> On Tue, Feb 13, 2024 at 09:39:51AM +0100, Krzysztof Kozlowski wrote:
>> On 13/02/2024 09:27, Krishna Kurapati wrote:
>>> Multiport USB controller (host-only) of SA8295 ADP has 4 Type-A ports
>>> exposed for connecting peripherals. The VBUS to these peripherals is
>>> provided by TPS2559QWDRCTQ1 regulators connected to these ports. Each
>>> regulator has an enable pin controlled by PMM8540. Since these regulators
>>> are GPIO controlled regulators, model them as fixed regulators and keep
>>> them Always-On at boot since we are wakeup capable and we don't need to
>>> turn them off on suspend. Also since we don't enter device mode, these
>>> regulators can be kept on.
>>>
>>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>>> ---
>>>  arch/arm64/boot/dts/qcom/sa8295p-adp.dts | 83 ++++++++++++++++++++++++
>>>  1 file changed, 83 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
>>> index fd253942e5e5..49418843c214 100644
>>> --- a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
>>> +++ b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
>>> @@ -9,6 +9,7 @@
>>>  #include <dt-bindings/gpio/gpio.h>
>>>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>>>  #include <dt-bindings/spmi/spmi.h>
>>> +#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
>>>  
>>>  #include "sa8540p.dtsi"
>>>  #include "sa8540p-pmics.dtsi"
>>> @@ -108,6 +109,46 @@ edp3_connector_in: endpoint {
>>>  			};
>>>  		};
>>>  	};
>>> +
>>> +	regulator-usb2-vbus {
>>> +		compatible = "regulator-fixed";
>>> +		regulator-name = "USB2_VBUS";
>>> +		gpio = <&pmm8540c_gpios 9 GPIO_ACTIVE_HIGH>;
>>> +		pinctrl-0 = <&usb2_en>;
>>> +		pinctrl-names = "default";
>>> +		enable-active-high;
>>> +		regulator-always-on;
>>> +	};
>>> +
>>> +	regulator-usb3-vbus {
>>> +		compatible = "regulator-fixed";
>>> +		regulator-name = "USB3_VBUS";
>>> +		gpio = <&pmm8540e_gpios 5 GPIO_ACTIVE_HIGH>;
>>> +		pinctrl-0 = <&usb3_en>;
>>> +		pinctrl-names = "default";
>>> +		enable-active-high;
>>> +		regulator-always-on;
>>> +	};
>>> +
>>> +	regulator-usb4-vbus {
>>> +		compatible = "regulator-fixed";
>>> +		regulator-name = "USB4_VBUS";
>>> +		gpio = <&pmm8540g_gpios 5 GPIO_ACTIVE_HIGH>;
>>> +		pinctrl-0 = <&usb4_en>;
>>> +		pinctrl-names = "default";
>>> +		enable-active-high;
>>> +		regulator-always-on;
>>> +	};
>>> +
>>> +	regulator-usb5-vbus {
>>> +		compatible = "regulator-fixed";
>>> +		regulator-name = "USB5_VBUS";
>>> +		gpio = <&pmm8540g_gpios 9 GPIO_ACTIVE_HIGH>;
>>> +		pinctrl-0 = <&usb5_en>;
>>> +		pinctrl-names = "default";
>>> +		enable-active-high;
>>> +		regulator-always-on;
>>
>> Why all these regulators are always on? If USB controller does not probe
>> for any reason, why keeping them enabled? These must not be always-on,
>> but instead used by connector as VBUS supply (or by whatever you have
>> there for USB).
>>
> 
> I'm not too concerned about keeping the lights on in this scenario, but
> if we can describe this properly let's do so (and let's do so on other
> boards with connectors as well).
> 
> We'd have a set of usb-a-connector nodes, that we can tie to the nodes
> in the USB/phy, and the supply. But so far we've associated a connector
> with a port manager, here we don't have one of those, so where would the
> node reside and who should acquire and drive the vbus-supply?

usb-connector binding has vbus-supply and its node could be top-level.
However don't some USB phys also take that regulator?

Best regards,
Krzysztof



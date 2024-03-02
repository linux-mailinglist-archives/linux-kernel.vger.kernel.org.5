Return-Path: <linux-kernel+bounces-89619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC2286F31E
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 00:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71DFC1F21D12
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 23:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C890453E39;
	Sat,  2 Mar 2024 23:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fKHMAs/u"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDCD4AEE1
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 23:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709421987; cv=none; b=Yum0zdRvbKhtEeRvt0EAHY/uZ8A2Wy0YL+Nq5Ga+w+KxMhT4vJ85H9wmC/RwcIgCq7b34J3jCvhkaLpAk/3NaoiQMfub/9srpqJ8tzbn352r3rOqn6IJZHC0zK+S/BFKVDZ9yIOXaP48zliRk1UzDggPJFsV0d88UJ2gYZF5Pg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709421987; c=relaxed/simple;
	bh=WWoPXoEikJ+qkTL7RUU2//A1oFwcmolq2w8LR5Xiczs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Zrx4+CaTH/UFrD7Bj1zApChs6qEfE7szj2tJ66yZZPPm5zC6e16X7OmJlMsfSvJtwJorsA9jg192onCgpzSI4Yd7yXCeZcADZUcHaORsRESv1/hMnU7mAQRvatqUjfsykyr8D8DtheoskYeFFcN5iquvECuXGCz5bmeNRX/HoI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fKHMAs/u; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5132bd70e7dso718137e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2024 15:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709421983; x=1710026783; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=91l1ZuFqeuBqMaEr1yfV8RMJG1YWc8ygTqpkAMdBgko=;
        b=fKHMAs/utfMMhneONRmXOG+r6SaDqyqkQGeprcXNP2SPh9WHM1J3d46rUHJJuPWWpI
         a+tanMOQwRytinlqj22wOAen9TAQCFshEe8OXlqte8KlJJOMIKoZCW2ypyDdSXwQL0nc
         RcP3T6YqxsaFw0NOBQJucPWsVwFz2615POpEIY7ftEDJdW7qGrqimeC43ab0VSV+66Uv
         mvH6+GnnAG44q2GWRfOVXbwnHD3VhxzsW/uszNdjeB2Hzv0T/twlCD8inzgkhhGXkpsV
         4mmKcBJWE7uoM3y5KIlxCr0sk9nxdwkCL/Fu+/zYh6COLlKDbskrMltYvP32pUZ2hjIT
         ivZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709421983; x=1710026783;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=91l1ZuFqeuBqMaEr1yfV8RMJG1YWc8ygTqpkAMdBgko=;
        b=sRpwURGz6nMNYieTQ06r4k3qObjwIK0seqfI8QVlKl9mW5d0+MO0hOArB0GS6gvf7R
         IxFL5bNQl8rf5cEpKEKin+zE4+0dc/2lh1XWHv/lwjDSD/dwGFIlSTWDnsH0CPE2R1Pb
         17yZNO5nYHBkk+9PQWO1Mz7jdTc02bnlsmANyYklhRIf5eloEa4vQK0o/WSZ1im4+m3u
         Zmkg3cYTCwG+km/Kv/NdlwaLSgcSlhmfBUDpjoyfarqB93lTp+YKUY8v4hArLo/h0hJe
         rV3+z9BZrziWKLw8e7D5xjlHQnx1xqk8cFyOgoPUmCRo0P044NMNIWn3dqimu0vOo/ba
         ygCA==
X-Forwarded-Encrypted: i=1; AJvYcCXb4uwpwivkejf7kPDrDtNMg195QiAQZglQ+QDLA4Wi09wzPtjprI4XyzS3qhlzzkJDeGlLFbK9MWyzIlC8xAUAeoWeGQamYpkcjxG1
X-Gm-Message-State: AOJu0Yyoaw7qcIsU092YXFD9TzNBt0t600Nw6D4BWB+yBRR/EI06+suG
	xBEoQDG7KGeaTck9iwT5JQYobZ06IvSNzl7qPaEq4MzKCoqGlMb3Ey459TfpSMgRKL3wM2JujW9
	w
X-Google-Smtp-Source: AGHT+IHHAtDUwd18LuJhpkgrUuyhU878/OBTmnIxde0MbgC2ZcjssOvGV8rZBA7OW28m9OEHFpPF9Q==
X-Received: by 2002:a05:6512:3e1b:b0:512:a026:1f13 with SMTP id i27-20020a0565123e1b00b00512a0261f13mr3705669lfv.3.1709421983115;
        Sat, 02 Mar 2024 15:26:23 -0800 (PST)
Received: from [192.168.1.102] (88-112-131-206.elisa-laajakaista.fi. [88.112.131.206])
        by smtp.gmail.com with ESMTPSA id y26-20020ac2447a000000b005133ca2a28asm352617lfl.110.2024.03.02.15.26.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Mar 2024 15:26:22 -0800 (PST)
Message-ID: <8a1b08df-dc44-6f9f-c819-33491308699e@linaro.org>
Date: Sun, 3 Mar 2024 01:26:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Subject: Re: [PATCH 2/3] arm64: dts: qcom: sm8650: add support for the
 SM8650-HDK board
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240223-topic-sm8650-upstream-hdk-v1-0-ccca645cd901@linaro.org>
 <20240223-topic-sm8650-upstream-hdk-v1-2-ccca645cd901@linaro.org>
Content-Language: en-US
In-Reply-To: <20240223-topic-sm8650-upstream-hdk-v1-2-ccca645cd901@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Neil,

On 2/23/24 10:52, Neil Armstrong wrote:
> The SM8650-HDK is an embedded development platforms for the
> Snapdragon 8 Gen 3 SoC aka SM8650, with the following features:
> - Qualcomm SM8650 SoC
> - 16GiB On-board LPDDR5
> - On-board WiFi 7 + Bluetooth 5.3/BLE
> - On-board UFS4.0
> - M.2 Key B+M Gen3x2 PCIe Slot
> - HDMI Output
> - USB-C Connector with DP Almode & Audio Accessory mode
> - Micro-SDCard Slot
> - Audio Jack with Playback and Microphone
> - 2 On-board Analog microphones
> - 2 On-board Speakers
> - 96Boards Compatible Low-Speed and High-Speed connectors [1]
>    - For Camera, Sensors and external Display cards
>      - Compatible with the Linaro Debug board [2]

what are these [1] and [2] references? Probably there might be some links.

>      - SIM Slot for Modem
>      - Debug connectors
>      - 6x On-Board LEDs
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/Makefile       |    1 +
>   arch/arm64/boot/dts/qcom/sm8650-hdk.dts | 1259 +++++++++++++++++++++++++++++++
>   2 files changed, 1260 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 7d40ec5e7d21..4f48c98451de 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -241,6 +241,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sm8450-sony-xperia-nagara-pdx224.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= sm8550-hdk.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= sm8550-mtp.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= sm8550-qrd.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sm8650-hdk.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= sm8650-mtp.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= sm8650-qrd.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= x1e80100-crd.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sm8650-hdk.dts b/arch/arm64/boot/dts/qcom/sm8650-hdk.dts
> new file mode 100644
> index 000000000000..cb1e0f569483

<snip>

> +
> +&i2c6 {
> +	clock-frequency = <400000>;
> +	status = "okay";
> +

<snip>

> +};
> +
> +&i2c3 {
> +       status = "okay";
> +

<snip>

> +};

Please change the order of i2c3 and i2c6.

<snip>

> +&pcie_1_phy_aux_clk {
> +	clock-frequency = <1000>;
> +};
> +

May be put the clock above after &pcie1_phy like in the list of gcc
source clocks?

> +&pcie0 {
> +	wake-gpios = <&tlmm 96 GPIO_ACTIVE_HIGH>;
> +	perst-gpios = <&tlmm 94 GPIO_ACTIVE_LOW>;
> +
> +	pinctrl-0 = <&pcie0_default_state>;
> +	pinctrl-names = "default";
> +
> +	status = "okay";
> +};
> +
> +&pcie0_phy {
> +	vdda-phy-supply = <&vreg_l1i_0p88>;
> +	vdda-pll-supply = <&vreg_l3i_1p2>;
> +
> +	status = "okay";
> +};
> +
> +&pcie1 {
> +	wake-gpios = <&tlmm 99 GPIO_ACTIVE_HIGH>;
> +	perst-gpios = <&tlmm 97 GPIO_ACTIVE_LOW>;
> +
> +	pinctrl-0 = <&pcie1_default_state>;
> +	pinctrl-names = "default";
> +
> +	status = "okay";
> +};
> +
> +&pcie1_phy {
> +	vdda-phy-supply = <&vreg_l3e_0p9>;
> +	vdda-pll-supply = <&vreg_l3i_1p2>;
> +	vdda-qref-supply = <&vreg_l1i_0p88>;
> +
> +	status = "okay";
> +};
> +

So I've found just these minor things, and I've successfully tested
the dtb on the SM8650-HDK board.

Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Tested-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

--
Best wishes,
Vladimir


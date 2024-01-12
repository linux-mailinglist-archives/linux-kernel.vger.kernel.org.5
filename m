Return-Path: <linux-kernel+bounces-24915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C74E282C49E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 18:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D8261F248E9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 17:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0382261F;
	Fri, 12 Jan 2024 17:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p/lGBzlu"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDD22260D
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 17:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40e5f746ac4so24292075e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 09:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705080128; x=1705684928; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hWQs+SrV/KFbufk6ifwh/c7DnE5+G03IvI/aQVbn9p8=;
        b=p/lGBzluEFowcAMzDkWnJSHiZcfLXRPelFpgpVnPWQRFU9Td86lK6aTRyzq9CBZ4l0
         aJU45RGd1Iyiui4wZN5q89l/G1LYg9pvLdHOqmEqk34URaxiHZn6ro8jQx4IPkR1KW7W
         Oo8B2Uep5TchCE8ddoxJuWpuBX9BBKBkJFpKiGtOxcvGwhfUNKdExdYSWwh9XFZBWiPy
         9a07VOUxIuUrz+EkmmMrHIOLYiigQkrUSXPXtq41WXMI4dpKdxjhsJaHU1RpyTeznTjt
         i+ARqD91O30qr+RlZ3XUul5reV7HnRzkgbd46FbMykXTblJjrderbWEVgJtbZc3QHjcS
         0DUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705080128; x=1705684928;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hWQs+SrV/KFbufk6ifwh/c7DnE5+G03IvI/aQVbn9p8=;
        b=OmK0b5oIKCXjEcHONf+TppPy/LXR02sV8YowNZmX8hprcfWdSeJxRtvcA+QIaQAyEQ
         Od87SLNLoRqEEkjM5yMpqzZ4oZMfBViIDMUA+eyQQ9RVJT5/T7PZt9sBP06yzuK7h++7
         MUsNrF6hzBKU6sxNer6RKoPkLifdsGNrAh3adXsZO5BQgPr44Mz1Lu7HvuKs2Z3Rji+8
         q1+tZuo2cep9XFfUOFeF+JDkopgjEzaaZDENgczxArSN6pg+bTQORRFCPFrmhpBhLFre
         m1dx8AMBcyAosw1+lGn4S84i29Q82gD50DZu3tiZLMoEvruhcBgRH3Q6haKxqRdUrTUO
         xNjA==
X-Gm-Message-State: AOJu0Yw2IPl0EtSqw9IQzKoDGH09pZeBhR3XtCtsISsW5h3hhToFVUdU
	uGQguY4v5qOlcT9z+/McyqrCQFE7kIv4rg==
X-Google-Smtp-Source: AGHT+IHOCXczXmxh+9wGSnbj5JnHj07o/ME+ktmKRl/TAznRyG6I5SbmL7TLaY1MC0Xp8dHAG/cKOg==
X-Received: by 2002:a05:600c:6543:b0:40e:68c1:4637 with SMTP id dn3-20020a05600c654300b0040e68c14637mr429175wmb.18.1705080128384;
        Fri, 12 Jan 2024 09:22:08 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.112])
        by smtp.gmail.com with ESMTPSA id q8-20020a7bce88000000b0040c11fbe581sm6318800wmj.27.2024.01.12.09.22.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jan 2024 09:22:07 -0800 (PST)
Message-ID: <60d78882-0ec5-4cd1-b68d-f75b73cb6cdb@linaro.org>
Date: Fri, 12 Jan 2024 18:22:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] arm64: dts: add description for solidrun am642 som
 and evaluation board
Content-Language: en-US
To: Josua Mayer <josua@solid-run.com>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
References: <20240112-add-am64-som-v2-0-1385246c428c@solid-run.com>
 <20240112-add-am64-som-v2-4-1385246c428c@solid-run.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240112-add-am64-som-v2-4-1385246c428c@solid-run.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/01/2024 18:12, Josua Mayer wrote:
> Add description for the SolidRun AM642 SoM, and HummingBoard-T
> evaluation board.
> 
..

> +&main_gpio0 {
> +	m2-reset-hog {
> +		gpio-hog;
> +		gpios = <12 GPIO_ACTIVE_LOW>;
> +		output-low; /* deasserted */
> +		line-name = "m2-reset";
> +	};
> +
> +	m1-m2-w-disable1-hog {
> +		gpio-hog;
> +		gpios = <32 GPIO_ACTIVE_LOW>;
> +		output-low; /* deasserted */
> +		line-name = "m1-m2-pcie-w-disable1";
> +	};
> +
> +	m1-m2-w_disable2-hog {

No, underscores are not allowed.

..

> +
> +#include <dt-bindings/net/ti-dp83869.h>
> +
> +/ {
> +	model = "SolidRun AM642 SoM";
> +	compatible = "solidrun,am642-sr-som", "ti,am642";
> +
> +	aliases {
> +		ethernet0 = &cpsw_port1;
> +		ethernet1 = &icssg1_emac0;
> +		ethernet2 = &icssg1_emac1;
> +		mmc0 = &sdhci0;
> +		mmc1 = &sdhci1;
> +		serial2 = &main_uart0;
> +	};
> +
> +	chosen {
> +		/* SoC default UART console */
> +		stdout-path = "serial2:115200n8";
> +	};
> +
> +	/* PRU Ethernet Controller */
> +	icssg1_eth: icssg1-eth {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +		compatible = "ti,am642-icssg-prueth";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pru_rgmii1_pins_default>, <&pru_rgmii2_pins_default>;
> +
> +		sram = <&oc_sram>;
> +		ti,prus = <&pru1_0>, <&rtu1_0>, <&tx_pru1_0>, <&pru1_1>, <&rtu1_1>, <&tx_pru1_1>;
> +		firmware-name = "ti-pruss/am65x-sr2-pru0-prueth-fw.elf",
> +				"ti-pruss/am65x-sr2-rtu0-prueth-fw.elf",
> +				"ti-pruss/am65x-sr2-txpru0-prueth-fw.elf",
> +				"ti-pruss/am65x-sr2-pru1-prueth-fw.elf",
> +				"ti-pruss/am65x-sr2-rtu1-prueth-fw.elf",
> +				"ti-pruss/am65x-sr2-txpru1-prueth-fw.elf";
> +
> +		ti,pruss-gp-mux-sel = <2>,	/* MII mode */
> +				      <2>,
> +				      <2>,
> +				      <2>,	/* MII mode */
> +				      <2>,
> +				      <2>;
> +
> +		ti,mii-g-rt = <&icssg1_mii_g_rt>;
> +		ti,mii-rt = <&icssg1_mii_rt>;
> +		ti,iep = <&icssg1_iep0>, <&icssg1_iep1>;
> +
> +		interrupt-parent = <&icssg1_intc>;
> +		interrupts = <24 0 2>, <25 1 3>;

None of these are typical interrupt constants/flags?

> +		interrupt-names = "tx_ts0", "tx_ts1";
> +
> +		dmas = <&main_pktdma 0xc200 15>, /* egress slice 0 */
> +		       <&main_pktdma 0xc201 15>, /* egress slice 0 */
> +		       <&main_pktdma 0xc202 15>, /* egress slice 0 */
> +		       <&main_pktdma 0xc203 15>, /* egress slice 0 */
> +		       <&main_pktdma 0xc204 15>, /* egress slice 1 */
> +		       <&main_pktdma 0xc205 15>, /* egress slice 1 */
> +		       <&main_pktdma 0xc206 15>, /* egress slice 1 */
> +		       <&main_pktdma 0xc207 15>, /* egress slice 1 */
> +		       <&main_pktdma 0x4200 15>, /* ingress slice 0 */
> +		       <&main_pktdma 0x4201 15>, /* ingress slice 1 */
> +		       <&main_pktdma 0x4202 0>, /* mgmnt rsp slice 0 */
> +		       <&main_pktdma 0x4203 0>; /* mgmnt rsp slice 1 */
> +		dma-names = "tx0-0", "tx0-1", "tx0-2", "tx0-3",
> +			    "tx1-0", "tx1-1", "tx1-2", "tx1-3",
> +			    "rx0", "rx1";
> +
> +		status = "okay";

Drop. Didn't you get such comments before?

> +
> +		ethernet-ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			icssg1_emac0: port@0 {
> +				reg = <0>;
> +				ti,syscon-rgmii-delay = <&main_conf 0x4110>;
> +				/* Filled in by bootloader */
> +				local-mac-address = [00 00 00 00 00 00];
> +				phy-handle = <&ethernet_phy2>;
> +				phy-mode = "rgmii-id";
> +				status = "okay";

?

> +			};
> +
> +			icssg1_emac1: port@1 {
> +				reg = <1>;
> +				ti,syscon-rgmii-delay = <&main_conf 0x4114>;
> +				/* Filled in by bootloader */
> +				local-mac-address = [00 00 00 00 00 00];
> +				phy-handle = <&ethernet_phy1>;
> +				phy-mode = "rgmii-id";
> +				status = "okay";

?


...

> +	ethernet_phy0: ethernet-phy@0 {
> +		compatible = "ethernet-phy-id2000.a0f1";
> +		reg = <0>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&ethernet_phy0_pins_default>;
> +		ti,clk-output-sel = <DP83869_CLK_O_SEL_REF_CLK>;
> +		ti,op-mode = <DP83869_RGMII_COPPER_ETHERNET>;
> +		/*
> +		 * Disable interrupts because ISR never clears 0x0040
> +		 *
> +		 * interrupt-parent = <&main_gpio1>;
> +		 * interrupts = <70 IRQ_TYPE_LEVEL_LOW>;
> +		 */
> +		/*
> +		 * Disable HW Reset because clock signal is daisy-chained
> +		 *
> +		 * reset-gpios = <&main_gpio0 84 GPIO_ACTIVE_LOW>;
> +		 * reset-assert-us = <1>;
> +		 * reset-deassert-us = <30>;
> +		 */
> +		 status = "okay";

Drop, this applies everywhere where not needed. You have this in
multiple places...

Best regards,
Krzysztof



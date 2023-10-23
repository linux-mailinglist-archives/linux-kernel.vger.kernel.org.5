Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2024F7D306B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 12:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjJWK4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 06:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjJWK4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 06:56:07 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D99D7E
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 03:56:00 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-522bd411679so4664130a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 03:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1698058559; x=1698663359; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D3uCaDkYIP2k+SJkMK/GFg6xfE/rRo7Hk4A+SRqM1sI=;
        b=zdo+OfjRq1dQSJxXvsVlGovRZtsjpYFS4XqCuyVT2BBW+ISJc3DsChNs96r6W0I/PW
         K9d4pyhlpRYhiXlT0ovrcXJRYIrrez2iV58QVM6ddmLUdG4tJ1+5Us/vhGMi9U7CGYiW
         /x2kXifWoxC/B4p7bqWGGl+xv5Pz3InlUIYvo8XAO2BojWFXKVQBJ1l75gWZWkacRQPm
         z44pUF1fosvL91NGj/F0nupFjbu/YEWPFe6kteNPM62eguAJ/3x03RW4FdLjCJBi30W7
         sKRgusAyllOS41/Aq+XtilavTBvNyi8GBPmuctN1Q/v2U8XhHGhAxf2s5gcvczdfeVH5
         ymiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698058559; x=1698663359;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D3uCaDkYIP2k+SJkMK/GFg6xfE/rRo7Hk4A+SRqM1sI=;
        b=Aw0dN0/86VEmMEV3rYhr02HWTuwlcFq+lGcBycuPK0fBR9MHKxanAy5zo51xfd0K00
         +ZFJn+dI1G+tTA6fN/HkY9eEuhJEvGECzyDb+On0OHsc+qgWF3jNAc3h2vQRRLq+Y41/
         m0nbTkmzPmxlh9bL00Dur1/bI48TviQkZoU48DHEbS29/1HVxhVMMPFCZZDtKewQGNtl
         dZNOsU+bUqOmw3hiikqodTn12u7S6bCGts1w9bSYWIalc26vL4u9NZgt8dkC62uMXUQB
         Pn+gIMIg7K48zEAILMgMOUoKAPV/z0zJk+AZY76FRCPaJwWqhm/SjHDIPG5EovwTG3GP
         1nGw==
X-Gm-Message-State: AOJu0YxB+NlL4GfgN8I1sBlUbJX3+hGhOw+DrjbbHjTFrMLs8Eq2YOi1
        4o7WWUTTGpRFx26GmTmuvWM9Ig==
X-Google-Smtp-Source: AGHT+IHgud+ri83ecGImW587nXW8BLXh+rzA3PwsJVWpotOaar4YBUzaqFakBmvO76oc4SqntSfuYA==
X-Received: by 2002:a17:907:7b9f:b0:9bf:8073:a922 with SMTP id ne31-20020a1709077b9f00b009bf8073a922mr8004440ejc.19.1698058558770;
        Mon, 23 Oct 2023 03:55:58 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id c11-20020a170906340b00b009be23a040cfsm6371567ejb.40.2023.10.23.03.55.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 03:55:58 -0700 (PDT)
Message-ID: <a1846955-e6d9-4217-8c9f-1f20be166f4b@baylibre.com>
Date:   Mon, 23 Oct 2023 12:55:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/4] arm64: dts: Add MediaTek MT8188 dts and evaluation
 board and Makefile
Content-Language: en-US
To:     Jason-ch Chen <jason-ch.chen@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     =?UTF-8?Q?N=C3=ADcolas_F_=2E_R_=2E_A_=2E_Prado?= 
        <nfraprado@collabora.com>, Chen-Yu Tsai <wenst@chromium.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20231023083839.24453-1-jason-ch.chen@mediatek.com>
 <20231023083839.24453-5-jason-ch.chen@mediatek.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20231023083839.24453-5-jason-ch.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/10/2023 10:38, Jason-ch Chen wrote:
> From: jason-ch chen <Jason-ch.Chen@mediatek.com>
> 
> MT8188 is a SoC based on 64bit ARMv8 architecture. It contains 6 CA55
> and 2 CA78 cores. MT8188 share many HW IP with MT65xx series.
> 
> We add basic chip support for MediaTek MT8188 on evaluation board.
> 
> Signed-off-by: jason-ch chen <Jason-ch.Chen@mediatek.com>
> ---
>   arch/arm64/boot/dts/mediatek/Makefile       |   1 +
>   arch/arm64/boot/dts/mediatek/mt8188-evb.dts | 387 ++++++++
>   arch/arm64/boot/dts/mediatek/mt8188.dtsi    | 956 ++++++++++++++++++++
>   3 files changed, 1344 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-evb.dts
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8188.dtsi
> 
> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
> index e6e7592a3645..8900b939ed52 100644
> --- a/arch/arm64/boot/dts/mediatek/Makefile
> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> @@ -44,6 +44,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku0.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku176.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-pumpkin.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-evb.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8188-evb.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-asurada-hayato-r1.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-asurada-hayato-r5-sku2.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-asurada-spherion-r0.dtb
> diff --git a/arch/arm64/boot/dts/mediatek/mt8188-evb.dts b/arch/arm64/boot/dts/mediatek/mt8188-evb.dts
> new file mode 100644
> index 000000000000..68a82b49f7a3
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8188-evb.dts
> @@ -0,0 +1,387 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (C) 2023 MediaTek Inc.
> + */
> +/dts-v1/;
> +#include "mt8188.dtsi"
> +#include "mt6359.dtsi"
> +
> +/ {
> +	model = "MediaTek MT8188 evaluation board";
> +	compatible = "mediatek,mt8188-evb", "mediatek,mt8188";
> +
> +	aliases {
> +		serial0 = &uart0;
> +		i2c0 = &i2c0;
> +		i2c1 = &i2c1;
> +		i2c2 = &i2c2;
> +		i2c3 = &i2c3;
> +		i2c4 = &i2c4;
> +		i2c5 = &i2c5;
> +		i2c6 = &i2c6;
> +		mmc0 = &mmc0;
> +	};
> +
> +	chosen: chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	memory@40000000 {
> +		device_type = "memory";
> +		reg = <0 0x40000000 0 0x80000000>;
> +	};
> +
> +	reserved_memory: reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		scp_mem_reserved: memory@50000000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0 0x50000000 0 0x2900000>;
> +			no-map;
> +		};
> +	};
> +};
> +
> +&auxadc {
> +	status = "okay";
> +};
> +
> +&i2c0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c0_pins>;
> +	clock-frequency = <400000>;
> +	status = "okay";

IMO, the order should be

clock-frequency = <400000>;
pinctrl-0 = <&i2c0_pins>;
pinctrl-names = "default";
status = "okay";

Please apply this to other nodes

> +};
> +
> +&i2c1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c1_pins>;
> +	clock-frequency = <400000>;
> +	status = "okay";
> +};
> +
> +&i2c2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c2_pins>;
> +	clock-frequency = <400000>;
> +	status = "okay";
> +};
> +
> +&i2c3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c3_pins>;
> +	clock-frequency = <400000>;
> +	status = "okay";
> +};
> +
> +&i2c4 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c4_pins>;
> +	clock-frequency = <400000>;
> +	status = "okay";
> +};
> +
> +&i2c5 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c5_pins>;
> +	clock-frequency = <400000>;
> +	status = "okay";
> +};
> +
> +&i2c6 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c6_pins>;
> +	clock-frequency = <400000>;
> +	status = "okay";
> +};
> +
> +&mmc0 {
> +	bus-width = <8>;
> +	hs400-ds-delay = <0x1481b>;
> +	max-frequency = <200000000>;
> +
> +	cap-mmc-highspeed;
> +	mmc-hs200-1_8v;
> +	mmc-hs400-1_8v;
> +	supports-cqe;
> +	cap-mmc-hw-reset;
> +	no-sdio;
> +	no-sd;
> +	non-removable;
> +
> +	vmmc-supply = <&mt6359_vemc_1_ldo_reg>;
> +	vqmmc-supply = <&mt6359_vufs_ldo_reg>;
> +
> +	pinctrl-names = "default", "state_uhs";
> +	pinctrl-0 = <&mmc0_default_pins>;
> +	pinctrl-1 = <&mmc0_uhs_pins>;
> +
> +	status = "okay";
> +};
> +
> +&mt6359_vcore_buck_reg {
> +	regulator-always-on;
> +};
> +
> +&mt6359_vgpu11_buck_reg {
> +	regulator-always-on;
> +};
> +
> +&mt6359_vpu_buck_reg {
> +	regulator-always-on;
> +};
> +
> +&mt6359_vrf12_ldo_reg {
> +	regulator-always-on;
> +};
> +
> +&nor_flash {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&nor_pins_default>;
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	status = "okay";

Order:


#address-cells = <1>;
#size-cells = <0>;

pinctrl-0 = <&nor_pins_default>;
pinctrl-names = "default";

status = "okay";

> +
> +	flash@0 {
> +		compatible = "jedec,spi-nor";
> +		reg = <0>;
> +		spi-max-frequency = <52000000>;
> +	};
> +};
> +

..snip..

> +
> +&pmic {
> +	interrupts-extended = <&pio 222 IRQ_TYPE_LEVEL_HIGH>;
> +};
> +
> +&scp {
> +	memory-region = <&scp_mem_reserved>;
> +	status = "okay";
> +};
> +
> +&spi0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&spi0_pins>;

Order:

pinctrl-0 = <&spi0_pins>;
pinctrl-names = "default";

Please apply this to other nodes

> +	status = "okay";
> +};
> +
> +&spi1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&spi1_pins>;
> +	status = "okay";
> +};
> +
> +&spi2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&spi2_pins>;
> +	status = "okay";
> +};
> +
> +&u3phy0 {
> +	status = "okay";
> +};
> +
> +&u3phy1 {
> +	status = "okay";
> +};
> +
> +&u3phy2 {
> +	status = "okay";
> +};
> +
> +&uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart0_pins>;
> +	status = "okay";
> +};
> +

..snip..

> +		};
> +	};
> +};

After that:
Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

-- 
Regards,
Alexandre

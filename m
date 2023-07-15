Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B44C75488C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 14:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjGOMg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 08:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjGOMgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 08:36:24 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59CEC3A82
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 05:36:23 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b741cf99f8so43038451fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 05:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689424581; x=1692016581;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OQh1RqnYtSQG/u4OzhJ8MZUxL/+/aRY/L+fqZJTYF4g=;
        b=nT4Bg8WYmt+w7liTUcMwOy0n7JPxVjemZTuHxAfPlX6sDs4qi9R91DYWZr0mE4q0Vt
         XKolK/2BgsetcbJ2A3jICOptLBHtcJhc1aG5l35usGaC/pXzVaP+/09mPB9us7kGWddm
         7mNqDG9wfwAblk5JuGqvqS+5H18tub6PCIWr+mqrPPixy46quXe5miq8Reowf52xKspA
         jPiZPL9KMxvEQ9EtbEBSPOb8DMVZ4CUTwLG0ODV3xYlqSpNkI92Izfw0N7LgxOu8JzVW
         CEcMwhk9gWv+Hy7GYoxMnSX8V4avbWdaAL2VwMMFEKdxRgtZfy+N9r8tneTpcShU5swS
         Q0Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689424581; x=1692016581;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OQh1RqnYtSQG/u4OzhJ8MZUxL/+/aRY/L+fqZJTYF4g=;
        b=M67z4lxqTk2bCqYU3H9XWpZVmb3oHV4bIejWQJAl7mKa43Qc6psUvb897YjMQPOHpc
         oC8wbRSjUAdPjzcIBNj+JpA1bjVdZpAqBErw0quKhrScc2ckyDWZj1GX+9ww4jntypPl
         qeumb6VXb5Dkt2fM9/ll0lG7LyOqPMba7/JCuqBRPUnnPxyeS8LOtbGjLWsFvqBDIqQ3
         QhlLpS8x6cVPyLsAHJ2FjHIdaOeqPbxHjq11aAZQxj0oeKaeLywzHtR4QlX/4ruzIPxX
         CBdYGAVLinyQsI/zn/o/wKTFjhUTMwn3V5TW/8EqNlM12thbMOXqmZMLL0owtTTABxoC
         7U7g==
X-Gm-Message-State: ABy/qLbBNuRkEDDocr02nmy3CJZBYpvVwWcy1eLIJx0j9Vc/kvgD7Dy4
        0KwmBq/tY590p9Dj3GDFousDbXsNYkAfGXOtChib6w==
X-Google-Smtp-Source: APBJJlGk2A5i2kVSs9kXxMPfC00oOdJikOH/eqNKi7gO/8COjEdmJWtOg99/mke4kY2DyOA1vU4+Dw==
X-Received: by 2002:a2e:9159:0:b0:2b6:ece0:a3c1 with SMTP id q25-20020a2e9159000000b002b6ece0a3c1mr6016039ljg.35.1689424581496;
        Sat, 15 Jul 2023 05:36:21 -0700 (PDT)
Received: from [192.168.1.101] (abxi167.neoplus.adsl.tpnet.pl. [83.9.2.167])
        by smtp.gmail.com with ESMTPSA id n17-20020a2e8791000000b002b6ca937d60sm2487484lji.8.2023.07.15.05.36.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Jul 2023 05:36:20 -0700 (PDT)
Message-ID: <cfafdde2-4ded-517f-7c69-a751e53984e3@linaro.org>
Date:   Sat, 15 Jul 2023 14:36:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 4/6] arm64: dts: qcom: ipq5332: Add USB related nodes
Content-Language: en-US
To:     Varadarajan Narayanan <quic_varada@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, vkoul@kernel.org, kishon@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, gregkh@linuxfoundation.org,
        catalin.marinas@arm.com, will@kernel.org, p.zabel@pengutronix.de,
        arnd@arndb.de, geert+renesas@glider.be, neil.armstrong@linaro.org,
        nfraprado@collabora.com, rafal@milecki.pl,
        quic_srichara@quicinc.com, quic_varada@quicinc.org,
        quic_wcheng@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <cover.1689160067.git.quic_varada@quicinc.com>
 <1f99805b6437aa8d6eaa4663e8d27b98ee595f00.1689160067.git.quic_varada@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <1f99805b6437aa8d6eaa4663e8d27b98ee595f00.1689160067.git.quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.07.2023 13:38, Varadarajan Narayanan wrote:
> Add USB phy and controller nodes.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v4:
> 	Change node name
> 	Remove blank line
> 	'make CHECK_DTBS=y DT_SCHEMA_FILES=qcom qcom/ipq5332-rdp441.dtb' passed
DT_SCHEMA_FILES accepts yaml files

Konrad
> v1:
> 	Rename phy node
> 	Change compatible from m31,ipq5332-usb-hsphy -> qcom,ipq5332-usb-hsphy
> 	Remove 'qscratch' from phy node
> 	Fix alignment and upper-case hex no.s
> 	Add clock definition for the phy
> 	Remove snps,ref-clock-period-ns as it is not used. dwc3_ref_clk_period()
> 	in dwc3/core.c takes the frequency from ref clock and calculates fladj
> 	as appropriate.
> ---
>  arch/arm64/boot/dts/qcom/ipq5332.dtsi | 53 +++++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> index 8bfc2db..8118356 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> @@ -405,6 +405,59 @@
>  				status = "disabled";
>  			};
>  		};
> +
> +		usbphy0: usb-phy@7b000 {
> +			compatible = "qcom,ipq5332-usb-hsphy";
> +			reg = <0x0007b000 0x12c>;
> +
> +			clocks = <&gcc GCC_USB0_PHY_CFG_AHB_CLK>;
> +			clock-names = "cfg_ahb";
> +
> +			resets = <&gcc GCC_QUSB2_0_PHY_BCR>;
> +
> +			status = "disabled";
> +		};
> +
> +		usb2: usb2@8a00000 {
> +			compatible = "qcom,ipq5332-dwc3", "qcom,dwc3";
> +			reg = <0x08af8800 0x400>;
> +
> +			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "hs_phy_irq";
> +
> +			clocks = <&gcc GCC_USB0_MASTER_CLK>,
> +				 <&gcc GCC_SNOC_USB_CLK>,
> +				 <&gcc GCC_USB0_SLEEP_CLK>,
> +				 <&gcc GCC_USB0_MOCK_UTMI_CLK>;
> +			clock-names = "core",
> +				      "iface",
> +				      "sleep",
> +				      "mock_utmi";
> +
> +			resets = <&gcc GCC_USB_BCR>;
> +
> +			qcom,select-utmi-as-pipe-clk;
> +
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +
> +			status = "disabled";
> +
> +			usb2_0_dwc: usb@8a00000 {
> +				compatible = "snps,dwc3";
> +				reg = <0x08a00000 0xe000>;
> +				clocks = <&gcc GCC_USB0_MOCK_UTMI_CLK>;
> +				clock-names = "ref";
> +				interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
> +				usb-phy = <&usbphy0>;
> +				tx-fifo-resize;
> +				snps,is-utmi-l1-suspend;
> +				snps,hird-threshold = /bits/ 8 <0x0>;
> +				snps,dis_u2_susphy_quirk;
> +				snps,dis_u3_susphy_quirk;
> +			};
> +		};
>  	};
>  
>  	timer {

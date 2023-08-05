Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0DD277120B
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 22:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjHEURb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 16:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjHEUR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 16:17:29 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86D41735
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 13:17:27 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fe4cdb72b9so10141805e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 05 Aug 2023 13:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691266646; x=1691871446;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FWa1AmIUGQBjLAqU0BZ+XNgYlFPjyI+9N5RjbJHnaYE=;
        b=PvE39rwqdXYdchIxFFtJRWfvmhg/bkGMKXoBtvnb33wwtca5SjHtuvod+dHqcuMCqO
         2oeNXo6Vh/ahd83U/iA5Vxahg9/wEP0gEONMof1QaT/VzX2Q4BfpDnfcQQUUXwhn7sdi
         y3hUMrq4LHbj+lIfcplrblhcDLUM8iaulajDTHTDz4zoUlXqTfzds4spQxS8Mlm37ltA
         nRSa2vLQUdsGI4Z0Qohh1qnLnYNnuOUUMJ/hStFdhzkY9hCcz34i65Wdpyir5EsXX+Vc
         I0Kqg4hkMs8+8QPlQjHNo6bRj2e7esB7L0OqDepF1iPemU7nQPecVTlKCsJEpTNC1QFh
         5RsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691266646; x=1691871446;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FWa1AmIUGQBjLAqU0BZ+XNgYlFPjyI+9N5RjbJHnaYE=;
        b=U4ce4kja/CPa5kAIiDoHMIiY0ZwIuPQwLrJ+Qfxs1PeYM/+UCcTIg1HuRFiy/0a7oD
         NFxbFOUtqDN7FD9ZeyRGOCocagsFNzlZkBbX1LYuPqmAZ6fasHbuDHx8mca8AapyRiTv
         3SdR9sE3m6v3QrBbWCJ15fONQbt30QiK2SA948FAymPe+37C1s5n5HdRFSRU1PId5pkB
         1XvmC5MyyrL5TbMYZaqlEuW87F3ICH5uOw2JSutceugGN8JuEYwHUTa2cRb26l1leKEH
         Php663ZlulCEaWF8/od5DlcgYiVV6yUhD3obGpT+rDvYr6RTZ3yRFoZ1JdpB2Yq4/xJc
         A5Cw==
X-Gm-Message-State: AOJu0Yy5AK1bwsCIXQ2gp4Vmi50ueXC+fDIzf6G3HgfLC4Ndq/WHy3iA
        52etobGXsB2UZScD4Qfyc+FBMg==
X-Google-Smtp-Source: AGHT+IHq8r5p1pNsI4R8XXhR2NKV/ym7X668soaNAjcQN4oEwd9a2WQ06kYC2CjjSKhc9yikXslxqA==
X-Received: by 2002:a7b:ca57:0:b0:3fe:22a9:907 with SMTP id m23-20020a7bca57000000b003fe22a90907mr3875587wml.20.1691266646268;
        Sat, 05 Aug 2023 13:17:26 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.245])
        by smtp.gmail.com with ESMTPSA id r15-20020adfdc8f000000b00317909f9985sm5870830wrj.113.2023.08.05.13.17.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Aug 2023 13:17:25 -0700 (PDT)
Message-ID: <c32f0d5a-32c9-fd0b-822c-a8ed9238458c@linaro.org>
Date:   Sat, 5 Aug 2023 22:17:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 3/3] arm64: dts: qcom: Add device tree for Xiaomi Mi 11
 Ultra
Content-Language: en-US
To:     wuxilin123@gmail.com, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20230806-xiaomi-star-v1-0-0c384e8b5737@gmail.com>
 <20230806-xiaomi-star-v1-3-0c384e8b5737@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230806-xiaomi-star-v1-3-0c384e8b5737@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/08/2023 19:03, Xilin Wu via B4 Relay wrote:
> From: Xilin Wu <wuxilin123@gmail.com>
> 
> Add support for Xiaomi Mi 11 Ultra. This commit brings support for:
> * Front and rear display panels (initialized by bootloader)
> * USB
> * UFS
> * PCIe0
> * Thermistor sensors
> * ADSP/CDSP/Modem/SLPI
> * IR Transmitter
> * RTC provided by PMK8350
> * Buttons
> 

...


> +/*
> + * Delete following upstream (sm8350.dtsi) reserved
> + * memory mappings which are different on this device.


> + */
> +/delete-node/ &pil_adsp_mem;
> +/delete-node/ &pil_slpi_mem;
> +/delete-node/ &pil_cdsp_mem;
> +/delete-node/ &pil_ipa_fw_mem;
> +/delete-node/ &pil_ipa_gsi_mem;
> +/delete-node/ &pil_gpu_mem;
> +/delete-node/ &pil_spss_mem;
> +/delete-node/ &pil_modem_mem;
> +/delete-node/ &rmtfs_mem;
> +/delete-node/ &pil_trustedvm_mem;
> +/delete-node/ &removed_mem;
> +
> +/ {
> +	model = "Xiaomi Mi 11 Ultra";
> +	compatible = "xiaomi,star", "qcom,sm8350";
> +	chassis-type = "handset";
> +
> +	chosen {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		framebuffer0: framebuffer-front@ea600000 {

framebuffer@

> +			compatible = "simple-framebuffer";
> +			reg = <0 0xea600000 0 (1440 * 3200 * 4)>;
> +
> +			width = <1440>;
> +			height = <3200>;
> +			stride = <(1440 * 4)>;
> +			format = "a8r8g8b8";
> +		};
> +
> +		framebuffer1: framebuffer-rear@eb79c000 {

framebuffer@

> +			compatible = "simple-framebuffer";
> +			reg = <0 0xeb79c000 0 (126 * 294 * 4)>;
> +
> +			width = <126>;
> +			height = <294>;
> +			stride = <(126 * 4)>;
> +			format = "a8r8g8b8";
> +		};
> +	};
> +




> +			reg = <0 0x86100000 0 0x3900000>;
> +			no-map;
> +		};
> +
> +		pil_slpi_mem: memory@89a00000 {
> +			reg = <0 0x89a00000 0 0x2f00000>;
> +			no-map;
> +		};
> +
> +		pil_cdsp_mem: memory@8c900000 {
> +			reg = <0 0x8c900000 0 0x1e00000>;
> +			no-map;
> +		};
> +
> +		pil_ipa_fw_mem: memory@8e700000 {
> +			reg = <0 0x8e700000 0 0x10000>;
> +			no-map;
> +		};
> +
> +		pil_ipa_gsi_mem: memory@8e710000 {
> +			reg = <0 0x8e710000 0 0xa000>;
> +			no-map;
> +		};
> +

...

> +&pm8350c_gpios {
> +	gpio-line-names = "VDD_BOOST_5V_EN",
> +			  "NC",
> +			  "OTG_OVP_EN",
> +			  "WL_TXON",
> +			  "NC",
> +			  "NC",
> +			  "NC",
> +			  "NC",
> +			  "NC";
> +};
> +
> +&pmk8350_adc_tm {
> +	status = "okay";
> +
> +	pm8350-skin-therm@0 {

Hm, didn't we change the node names to generic "channel" and started
using labels? At least in next or ongoing patches? Or was it only for VADC?


> +		reg = <0>;
> +		io-channels = <&pmk8350_vadc PM8350_ADC7_AMUX_THM1_100K_PU(1)>;
> +		qcom,ratiometric;
> +		qcom,hw-settle-time-us = <200>;
> +	};

...

> +
> +&ufs_mem_hc {
> +	status = "okay";
> +
> +	reset-gpios = <&tlmm 203 GPIO_ACTIVE_LOW>;
> +
> +	vcc-supply = <&vreg_l7b_2p96>;
> +	vcc-max-microamp = <800000>;
> +	vccq-supply = <&vreg_l9b_1p2>;
> +	vccq-max-microamp = <900000>;
> +};
> +
> +&ufs_mem_phy {
> +	status = "okay";
> +
> +	vdda-phy-supply = <&vreg_l5b_0p88>;
> +	vdda-pll-supply = <&vreg_l6b_1p2>;
> +};
> +
> +&usb_1 {
> +	/* USB 2.0 only */
> +	qcom,select-utmi-as-pipe-clk;
> +	status = "okay";
> +};
> +
> +&usb_1_dwc3 {
> +	dr_mode = "otg";
> +	usb-role-switch;
> +	maximum-speed = "high-speed";
> +	/* Remove USB3 phy */
> +	phys = <&usb_1_hsphy>;
> +	phy-names = "usb2-phy";
> +};
> +
> +&usb_1_dwc3_hs {
> +	remote-endpoint = <&pmic_glink_hs_in>;
> +};
> +
> +&usb_1_hsphy {
> +	status = "okay";
> +
> +	vdda-pll-supply = <&vreg_l5b_0p88>;
> +	vdda18-supply = <&vreg_l1c_1p8>;
> +	vdda33-supply = <&vreg_l2b_3p07>;
> +};
> +

Looks like you have trailing blank line.

Best regards,
Krzysztof


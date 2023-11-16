Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879FC7EE775
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 20:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345513AbjKPT0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 14:26:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjKPT0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 14:26:50 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD9D18D;
        Thu, 16 Nov 2023 11:26:45 -0800 (PST)
Received: from [194.95.143.137] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1r3i0g-000580-O2; Thu, 16 Nov 2023 20:26:42 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michal Simek <michal.simek@amd.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Nishanth Menon <nm@ti.com>, Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] docs: dt-bindings: add DTS Coding Style document
Date:   Thu, 16 Nov 2023 20:26:41 +0100
Message-ID: <5727404.DvuYhMxLoT@phil>
In-Reply-To: <20231116181218.18886-1-krzysztof.kozlowski@linaro.org>
References: <20231116181218.18886-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,
Am Donnerstag, 16. November 2023, 19:12:18 CET schrieb Krzysztof Kozlowski:
> Document preferred coding style for Devicetree sources (DTS and DTSI),
> to bring consistency among all (sub)architectures and ease in reviews.
> 
> Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Bjorn Andersson <andersson@kernel.org>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Olof Johansson <olof@lixom.net>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 

> +Order of Properties in Device Node
> +----------------------------------
> +
> +Following order of properties in device nodes is preferred:
> +
> +1. compatible
> +2. reg
> +3. ranges
> +4. All properties with values
> +5. Boolean properties

I guess the only thing I do have questions about is the part

> +4. All properties with values
> +5. Boolean properties

Is there a rationale for it? Because with it things like regulator-*
properties then end up in two different blocks.


For all the rest I fully agree :-)


Thanks
Heiko


> +6. status (if applicable)
> +7. Child nodes
> +
> +The "status" property is by default "okay", thus it can be omitted.
> +
> +Example::
> +
> +	// SoC DTSI
> +
> +	usb_1_hsphy: phy@88e3000 {
> +		compatible = "qcom,sm8550-snps-eusb2-phy";
> +		reg = <0x0 0x088e3000 0x0 0x154>;
> +		#phy-cells = <0>;
> +		resets = <&gcc GCC_QUSB2PHY_PRIM_BCR>;
> +		status = "disabled";
> +	};
> +
> +	// Board DTS
> +
> +	&usb_1_hsphy {
> +		clocks = <&tcsr TCSR_USB2_CLKREF_EN>;
> +		clock-names = "ref";
> +		status = "okay";
> +	};
> +




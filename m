Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFCCD7BA50D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241064AbjJEQNg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 5 Oct 2023 12:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240855AbjJEQMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:12:17 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACAFCAD37;
        Thu,  5 Oct 2023 08:30:42 -0700 (PDT)
Received: from i53875a3c.versanet.de ([83.135.90.60] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qoLAi-0004BA-Lx; Thu, 05 Oct 2023 12:01:32 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Vincent Shih <vincent.sunplus@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Lala Lin <lala.lin@mediatek.com>,
        Komal Bajaj <quic_kbajaj@quicinc.com>,
        Kumar Thella <sthella@codeaurora.org>,
        Keiji Hayashibara <hayashibara.keiji@socionext.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, asahi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-rtc@vger.kernel.org, linux-mediatek@lists.infradead.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH V2] dt-bindings: nvmem: move deprecated cells binding to its own
 file
Date:   Thu, 05 Oct 2023 12:01:30 +0200
Message-ID: <2829805.88bMQJbFj6@diego>
In-Reply-To: <20231003064018.7502-1-zajec5@gmail.com>
References: <20231003064018.7502-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 3. Oktober 2023, 08:40:18 CEST schrieb Rafał Miłecki:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Support for old NVMEM fixed cells was deprecated in favour of
> "fixed-layout". It's still part of the nvmem.yaml though and may be
> unknowingly used by new bindings added without much of analyze.
> 
> To make it more difficult to accidentally support old syntax move its
> binding to separated file with "deprecated" in its name.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
> V2: Fix path to nvmem-deprecated-cells.yaml in amlogic,meson6-rtc.yaml
> 

>  .../bindings/nvmem/rockchip,otp.yaml          |  1 +
>  .../bindings/nvmem/rockchip-efuse.yaml        |  1 +

> diff --git a/Documentation/devicetree/bindings/nvmem/rockchip,otp.yaml b/Documentation/devicetree/bindings/nvmem/rockchip,otp.yaml
> index 9c6eff788928..a44d44b32809 100644
> --- a/Documentation/devicetree/bindings/nvmem/rockchip,otp.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/rockchip,otp.yaml
> @@ -49,6 +49,7 @@ required:
>  
>  allOf:
>    - $ref: nvmem.yaml#
> +  - $ref: nvmem-deprecated-cells.yaml#
>  
>    - if:
>        properties:
> diff --git a/Documentation/devicetree/bindings/nvmem/rockchip-efuse.yaml b/Documentation/devicetree/bindings/nvmem/rockchip-efuse.yaml
> index c5403e149080..b80fd8d1ae5b 100644
> --- a/Documentation/devicetree/bindings/nvmem/rockchip-efuse.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/rockchip-efuse.yaml
> @@ -11,6 +11,7 @@ maintainers:
>  
>  allOf:
>    - $ref: nvmem.yaml#
> +  - $ref: nvmem-deprecated-cells.yaml#
>  
>  properties:
>    compatible:

For Rockchip OTP and Efuse bindngs:
Acked-by: Heiko Stuebner <heiko@sntech.de>



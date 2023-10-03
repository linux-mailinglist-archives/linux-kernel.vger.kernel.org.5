Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D17027B60D4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 08:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbjJCGeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 02:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjJCGeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 02:34:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99EF593;
        Mon,  2 Oct 2023 23:34:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C39E1C433C7;
        Tue,  3 Oct 2023 06:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696314855;
        bh=Ryqz7zCojcMrEL8UuOL0v/jyNiV/Tvh9g3eXU1LCU2I=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=AAlRSjy+ZPVXdvA0otoocH+MR4mkmlZiwM0Qq6ROZJEyMmGSGE+A6KbaKGSezpi7l
         ZTCzUND2LpxuvzOLyksaUm3ZDB1hgsSeDh4FinK07Ps+wIPBZYy6/s52s3OAShctPi
         oSJivSz33iUYk+CvBwUzAN2lo/UMZ6SwbE3KgL3zWAjTv+OI6flkEJpNWxSZsWcqOF
         Wva207ke7oNtBOrUUwVzyft4pGJ7y8gF3mfcv1xM/yoh27FwGVvUGCSW8xLT0ui+MJ
         whJmGLWJ9L6giK/J1zon59LVlMfeQlHhGpfbnQlvBThtC8UATKTjTXR52pTYAYcEc7
         yekHR3gUSzE5w==
Received: (nullmailer pid 3548862 invoked by uid 1000);
        Tue, 03 Oct 2023 06:34:09 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Hector Martin <marcan@marcan.st>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Komal Bajaj <quic_kbajaj@quicinc.com>,
        linux-rtc@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-mtd@lists.infradead.org,
        Jerome Brunet <jbrunet@baylibre.com>,
        Vincent Shih <vincent.sunplus@gmail.com>,
        asahi@lists.linux.dev, Rob Herring <robh+dt@kernel.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Andy Gross <agross@kernel.org>,
        linux-rockchip@lists.infradead.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Richard Weinberger <richard@nod.at>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Fabio Estevam <festevam@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Sven Peter <sven@svenpeter.dev>,
        linux-arm-kernel@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Kumar Thella <sthella@codeaurora.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        devicetree@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Keiji Hayashibara <hayashibara.keiji@socionext.com>,
        Kevin Hilman <khilman@baylibre.com>,
        =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>,
        linux-mediatek@lists.infradead.org,
        Lala Lin <lala.lin@mediatek.com>
In-Reply-To: <20231003050355.1631-1-zajec5@gmail.com>
References: <20231003050355.1631-1-zajec5@gmail.com>
Message-Id: <169631484962.3548819.1223779643388796546.robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: nvmem: move deprecated cells binding to
 its own file
Date:   Tue, 03 Oct 2023 01:34:09 -0500
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 03 Oct 2023 07:03:55 +0200, Rafał Miłecki wrote:
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
>  .../devicetree/bindings/mtd/mtd.yaml          |  7 ++++-
>  .../bindings/mtd/partitions/nvmem-cells.yaml  |  1 +
>  .../nvmem/amlogic,meson-gxbb-efuse.yaml       |  1 +
>  .../bindings/nvmem/amlogic,meson6-efuse.yaml  |  1 +
>  .../bindings/nvmem/apple,efuses.yaml          |  1 +
>  .../devicetree/bindings/nvmem/imx-ocotp.yaml  |  1 +
>  .../bindings/nvmem/mediatek,efuse.yaml        |  1 +
>  .../nvmem/microchip,sama7g5-otpc.yaml         |  1 +
>  .../devicetree/bindings/nvmem/mxs-ocotp.yaml  |  1 +
>  .../nvmem/nvmem-deprecated-cells.yaml         | 28 +++++++++++++++++++
>  .../devicetree/bindings/nvmem/nvmem.yaml      |  9 ------
>  .../bindings/nvmem/qcom,qfprom.yaml           |  1 +
>  .../bindings/nvmem/qcom,sec-qfprom.yaml       |  1 +
>  .../bindings/nvmem/qcom,spmi-sdam.yaml        |  1 +
>  .../bindings/nvmem/rockchip,otp.yaml          |  1 +
>  .../bindings/nvmem/rockchip-efuse.yaml        |  1 +
>  .../nvmem/socionext,uniphier-efuse.yaml       |  1 +
>  .../bindings/nvmem/sunplus,sp7021-ocotp.yaml  |  1 +
>  .../bindings/rtc/amlogic,meson6-rtc.yaml      |  1 +
>  19 files changed, 50 insertions(+), 10 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/nvmem-deprecated-cells.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/rtc/amlogic,meson6-rtc.yaml:
Error in referenced schema matching $id: http://devicetree.org/schemas/rtc/nvmem-deprecated-cells.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/rtc/amlogic,meson6-rtc.example.dtb: rtc@740: False schema does not allow {'compatible': ['amlogic,meson6-rtc'], 'reg': [[1856, 20]], 'interrupts': [[0, 72, 1]], 'clocks': [[4294967295]], 'vdd-supply': [[4294967295]], 'resets': [[4294967295]], '#address-cells': [[1]], '#size-cells': [[1]], 'mac@0': {'reg': [[0, 6]]}, '$nodename': ['rtc@740']}
	from schema $id: http://devicetree.org/schemas/rtc/amlogic,meson6-rtc.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/rtc/amlogic,meson6-rtc.example.dtb: rtc@740: Unevaluated properties are not allowed ('mac@0' was unexpected)
	from schema $id: http://devicetree.org/schemas/rtc/amlogic,meson6-rtc.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231003050355.1631-1-zajec5@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


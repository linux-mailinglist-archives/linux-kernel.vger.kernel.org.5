Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3239876939D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 12:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbjGaKxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 06:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232529AbjGaKxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 06:53:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B2D171A;
        Mon, 31 Jul 2023 03:52:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC8156100F;
        Mon, 31 Jul 2023 10:51:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 139D4C433C8;
        Mon, 31 Jul 2023 10:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690800719;
        bh=VRB/1XE21uItYhBv3v9HcbSnr1pNI+FT1F8W0UoZ4EQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Rx3XU9T/DfTBZmTe1X/pitgrSt+EjtnzJoqNRAZuy+u5vwBhkfxh+hUZZrw8G6eyB
         lFooQITIfBmh8/jxn75ajaVWWyL+K/4SU45HngfcLfFTzUUGPBR5u+9IjcHh4p2VuV
         Gn/BP1tBlmjRqXbGir615a2nw2/EGblZCbb/EdH53HfxfeXjlH0iUF72exIeOeH8ce
         iI0zsUs/KwhnnNIx6Lxy7o7ockkHS9S04Qeay5vnvJcuIp6si4rRnNUb+xaSuY4dlr
         /lvwh+EQxuP3f465WPY0yRWJu6eDmjBQECj4Tp33HLlFzlfhS5JD89tNI3MxRd9Faa
         LZXL9lzdwZVlg==
Received: (nullmailer pid 2405199 invoked by uid 1000);
        Mon, 31 Jul 2023 10:51:46 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Jaroslav Kysela <perex@perex.cz>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-mediatek@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Jonathan Bakker <xc-racer2@live.ca>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        devicetree@vger.kernel.org, Trevor Wu <trevor.wu@mediatek.com>,
        linux-kernel@vger.kernel.org,
        Rohit kumar <quic_rohkumar@quicinc.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rao Mandadapu <srivasam@codeaurora.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
        Judy Hsiao <judyhsiao@chromium.org>,
        Conor Dooley <conor+dt@kernel.org>
In-Reply-To: <20230731094303.185067-7-krzysztof.kozlowski@linaro.org>
References: <20230731094303.185067-1-krzysztof.kozlowski@linaro.org>
 <20230731094303.185067-7-krzysztof.kozlowski@linaro.org>
Message-Id: <169080070445.2405101.15748974095026995722.robh@kernel.org>
Subject: Re: [PATCH 06/12] ASoC: dt-bindings: samsung,odroid: use common
 sound card
Date:   Mon, 31 Jul 2023 04:51:46 -0600
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 31 Jul 2023 11:42:57 +0200, Krzysztof Kozlowski wrote:
> Reference the common sound card properties and deprecate the
> custom "samsung,audio-routing" in favor of generic one.  This allows to
> remove "model" property and make the binding closer to other sounds
> cards.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/sound/samsung,odroid.yaml  | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/samsung,odroid.yaml:
Error in referenced schema matching $id: http://devicetree.org/schemas/sound/sound-card-common.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/samsung,odroid.example.dtb: sound: False schema does not allow {'compatible': ['hardkernel,odroid-xu3-audio'], 'model': ['Odroid-XU3'], 'audio-routing': ['Headphone Jack', 'HPL', 'Headphone Jack', 'HPR', 'IN1', 'Mic Jack', 'Mic Jack', 'MICBIAS'], 'cpu': {'sound-dai': [[4294967295, 0]]}, 'codec': {'sound-dai': [[4294967295], [4294967295]]}, '$nodename': ['sound']}
	from schema $id: http://devicetree.org/schemas/sound/samsung,odroid.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/samsung,odroid.example.dtb: sound: Unevaluated properties are not allowed ('audio-routing', 'model' were unexpected)
	from schema $id: http://devicetree.org/schemas/sound/samsung,odroid.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230731094303.185067-7-krzysztof.kozlowski@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


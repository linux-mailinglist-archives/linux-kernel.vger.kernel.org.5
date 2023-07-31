Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB4817699B2
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 16:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbjGaOjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 10:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbjGaOjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 10:39:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD0AB18E;
        Mon, 31 Jul 2023 07:39:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3642561184;
        Mon, 31 Jul 2023 14:39:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79B60C433C7;
        Mon, 31 Jul 2023 14:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690814342;
        bh=I+HTilLE0eCgqcOxm8A9AzbA88OpHR1hterp6c6XU+w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pg+zp2UxyorlYipjOt2QuL2ulmdPZOv6nqgX8rI7HeFvug9s4uUjTa7fk79yJpEJZ
         kHJIg6Z09MuBmxvZJMz0zBvsfY9SuES52uCVOp98BgNUkZPsAx2MMUEjZugT4Oggog
         NBGUpxONXSFmhKzNBPavt7eavVNB8kxNt3n0vvryKgwCsd4BwOQsHWUxNWajJc3oH8
         sZ+ZaPbj4JyaWZAwz6LO1jDGvPA7EMmXVj40RP77w9SdUECS+f+Gc2hB2WZDcmX/8l
         GrsKzmxO061FUgIS6HjTQ7bAT5+QxQEU5qmOPbePzUCVf5uv7ldYatz7zF8mfbHnLK
         /z0h20ZI/tWjg==
Received: (nullmailer pid 2931468 invoked by uid 1000);
        Mon, 31 Jul 2023 14:38:59 -0000
Date:   Mon, 31 Jul 2023 08:38:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Judy Hsiao <judyhsiao@chromium.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        linux-mediatek@lists.infradead.org,
        Fabio Estevam <festevam@gmail.com>,
        alsa-devel@alsa-project.org, NXP Linux Team <linux-imx@nxp.com>,
        Rao Mandadapu <srivasam@codeaurora.org>,
        Trevor Wu <trevor.wu@mediatek.com>,
        Jonathan Bakker <xc-racer2@live.ca>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        devicetree@vger.kernel.org,
        Rohit kumar <quic_rohkumar@quicinc.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/12] ASoC: dt-bindings: mediatek,mt8188-mt6359: use
 common sound card
Message-ID: <20230731143859.GA2928327-robh@kernel.org>
References: <20230731094303.185067-1-krzysztof.kozlowski@linaro.org>
 <20230731094303.185067-4-krzysztof.kozlowski@linaro.org>
 <169080070077.2404962.11506468692056687115.robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169080070077.2404962.11506468692056687115.robh@kernel.org>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 04:51:46AM -0600, Rob Herring wrote:
> 
> On Mon, 31 Jul 2023 11:42:54 +0200, Krzysztof Kozlowski wrote:
> > The mediatek,mt8188-mt6359 Linux sound machine driver requires the
> > "model" property, so binding was incomplete.  Reference the common sound
> > card properties to fix that which also allows to remove duplicated
> > property definitions.  Leave the relevant parts of "audio-routing"
> > description.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> >  .../bindings/sound/mediatek,mt8188-mt6359.yaml  | 17 +++++++----------
> >  1 file changed, 7 insertions(+), 10 deletions(-)
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml:
> Error in referenced schema matching $id: http://devicetree.org/schemas/sound/sound-card-common.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.example.dtb: sound: False schema does not allow {'compatible': ['mediatek,mt8188-mt6359-evb'], 'model': ['MT6359-EVB'], 'mediatek,platform': [[4294967295]], 'pinctrl-names': ['default'], 'pinctrl-0': [[4294967295]], 'audio-routing': ['Headphone', 'Headphone L', 'Headphone', 'Headphone R', 'AIN1', 'Headset Mic'], 'dai-link-0': {'link-name': ['ETDM3_OUT_BE'], 'dai-format': ['i2s'], 'mediatek,clk-provider': ['cpu'], 'codec': {'sound-dai': [[4294967295]]}}, '$nodename': ['sound']}
> 	from schema $id: http://devicetree.org/schemas/sound/mediatek,mt8188-mt6359.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.example.dtb: sound: Unevaluated properties are not allowed ('model' was unexpected)
> 	from schema $id: http://devicetree.org/schemas/sound/mediatek,mt8188-mt6359.yaml#

Looks like patch 2 could not be applied causing this.

Rob

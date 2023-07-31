Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CECB87699DC
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 16:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbjGaOn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 10:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbjGaOn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 10:43:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E459F18E;
        Mon, 31 Jul 2023 07:43:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 835BC61187;
        Mon, 31 Jul 2023 14:43:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D868C433CB;
        Mon, 31 Jul 2023 14:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690814605;
        bh=ZZP/+vM0qz6EaB+8dhpI2Dpi6RMKi1QnNhcTct6HcJc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gcf81MxHKfKQ6cb1/4LQVxpQJQBDyR9UMg13U+PabS/04OLLUefmHt1dU84ssOZZ9
         c0d2AZj+FB2qTva5iWdNN2E2AnFwsvtEv2Ks3VIQVYigWOnFqi8McciDtMf9PLGZ6M
         E7L790xhMnUuSiTkRqelk95M70e9aKxn9e36LUlS8rJrhYMm0ZfWUxDKfAz65ycs4a
         Yh9WU014M9UDp6ZN2WSStBAcAdiA4qFE270JVmBfnzxtgCdX8k3+ni8PhdGty4vieM
         iYEXJaLGPnQkoKYur2AJgZnuT44dfJ5BZ1fdXMvd/eCtycaMLqAzSXuqnMchXyUc2W
         prELTN76RjOsw==
Received: (nullmailer pid 2936636 invoked by uid 1000);
        Mon, 31 Jul 2023 14:43:21 -0000
Date:   Mon, 31 Jul 2023 08:43:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Takashi Iwai <tiwai@suse.com>,
        Rohit kumar <quic_rohkumar@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Judy Hsiao <judyhsiao@chromium.org>,
        Jonathan Bakker <xc-racer2@live.ca>,
        Fabio Estevam <festevam@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-mediatek@lists.infradead.org,
        Trevor Wu <trevor.wu@mediatek.com>,
        Jaroslav Kysela <perex@perex.cz>,
        NXP Linux Team <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Rao Mandadapu <srivasam@codeaurora.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH 07/12] ASoC: dt-bindings: samsung,tm2: use common sound
 card
Message-ID: <169081460128.2936591.465135796589060685.robh@kernel.org>
References: <20230731094303.185067-1-krzysztof.kozlowski@linaro.org>
 <20230731094303.185067-8-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731094303.185067-8-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 31 Jul 2023 11:42:58 +0200, Krzysztof Kozlowski wrote:
> Reference the common sound card properties and deprecate the
> custom "samsung,audio-routing" in favor of generic one.  This allows to
> remove "model" property and make the binding closer to other sounds
> cards.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/sound/samsung,tm2.yaml   | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


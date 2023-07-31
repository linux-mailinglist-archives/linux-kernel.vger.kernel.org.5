Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69C457699CF
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 16:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbjGaOlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 10:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbjGaOl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 10:41:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E068011C;
        Mon, 31 Jul 2023 07:41:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F14161184;
        Mon, 31 Jul 2023 14:41:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56F82C433C8;
        Mon, 31 Jul 2023 14:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690814485;
        bh=x6gwteO8wm+nEx6S7vKzpRLQHolXy2la/OsV7eQgzEQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TFg73a75Trc6lH/hs+o1+Ry1vWzVceNDfCSrck4T4k2Zycc5DcrUb1SObuv4R+WTk
         wKrBBZ8qX61ki6uw+u0gUwd3z81ZBzP8pt6Zethmoy0GeqUq20lQpVK2jVxFA5Mgz7
         iXkgDrwFGGc2UpALMZHoffcG11GqhvgvG+JRLtf6VWGgQhT2cdGeRj3SeXjJEt1bBQ
         83Z+PZ8zG1LREBDbyu5VytllfsRgoAOWRiq4ghsIY6EslP1JaKoU2S5WqCG4Dg9D8s
         vmVAV+uzkNllnwIMFLnTQ5HgSQ1V57actO28GEiPXqoN2HXYshs6lODA+fbKFn4zcD
         LkP4LDDA1/g6Q==
Received: (nullmailer pid 2934074 invoked by uid 1000);
        Mon, 31 Jul 2023 14:41:22 -0000
Date:   Mon, 31 Jul 2023 08:41:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Fabio Estevam <festevam@gmail.com>,
        Jonathan Bakker <xc-racer2@live.ca>,
        Jaroslav Kysela <perex@perex.cz>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Rohit kumar <quic_rohkumar@quicinc.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rao Mandadapu <srivasam@codeaurora.org>,
        Trevor Wu <trevor.wu@mediatek.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-mediatek@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Judy Hsiao <judyhsiao@chromium.org>,
        Shengj iu Wang <shengjiu.wang@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 04/12] ASoC: dt-bindings: samsung,aries-wm8994: use
 common sound card
Message-ID: <169081448188.2934017.10192674386465397658.robh@kernel.org>
References: <20230731094303.185067-1-krzysztof.kozlowski@linaro.org>
 <20230731094303.185067-5-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731094303.185067-5-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 31 Jul 2023 11:42:55 +0200, Krzysztof Kozlowski wrote:
> Reference the common sound card properties and deprecate the
> custom "samsung,audio-routing" in favor of generic one.  This allows to
> remove "model" property and make the binding closer to other sounds
> cards.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/sound/samsung,aries-wm8994.yaml     | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


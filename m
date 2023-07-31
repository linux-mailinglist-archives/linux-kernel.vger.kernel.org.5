Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5487699D1
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 16:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbjGaOmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 10:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbjGaOlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 10:41:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CAA9199F;
        Mon, 31 Jul 2023 07:41:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E93161187;
        Mon, 31 Jul 2023 14:41:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5064C433C7;
        Mon, 31 Jul 2023 14:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690814501;
        bh=6zs0p262FWZnT2q/CfUaDwyUeYXnBXhuseu1gVc38XQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C/t+Ag8xPMkM4w/sN7awWdOpwxKL34AbhifM3ApfHy4wOszK/s4+Ee3pM1mlmxUHh
         v3ZzKncG+rC5CxEti9EIBWxgYFXoBwcLkKlSMrY6e3Lhtmjqic8diE+lH2SNhaJ14k
         PtrRzG2dTZ7uqXx/ovkZiPH/4TDr8HZgv06SC5w0LnHDMrw5vZb6+D3i/3YQHsZk2O
         zKJCFoYvZIJgkEyenckCSLpBgCRynXYx39uIE/6LvGshuAOhb2uAUy5VM77KQYMPWi
         ZU2HUveBRZOXlFXxUrQZsjwhUzAKIgFokee643ITPbAkWj227rcbvABFWI/mPu1Z+d
         UTgXJLPm/UV7Q==
Received: (nullmailer pid 2934485 invoked by uid 1000);
        Mon, 31 Jul 2023 14:41:38 -0000
Date:   Mon, 31 Jul 2023 08:41:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-mediatek@lists.infradead.org,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, Shengjiu Wang <shengjiu.wang@nxp.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        linux-kernel@vger.kernel.org, Jonathan Bakker <xc-racer2@live.ca>,
        Rao Mandadapu <srivasam@codeaurora.org>,
        Rohit kumar <quic_rohkumar@quicinc.com>,
        Judy Hsiao <judyhsiao@chromium.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Fabio Estevam <festevam@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Trevor Wu <trevor.wu@mediatek.com>,
        alsa-devel@alsa-project.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Gu o <shawnguo@kernel.org>,
        Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 05/12] ASoC: dt-bindings: samsung,midas-audio: use common
 sound card
Message-ID: <169081449785.2934415.14179927279002446763.robh@kernel.org>
References: <20230731094303.185067-1-krzysztof.kozlowski@linaro.org>
 <20230731094303.185067-6-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731094303.185067-6-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 31 Jul 2023 11:42:56 +0200, Krzysztof Kozlowski wrote:
> Reference the common sound card properties and deprecate the
> custom "samsung,audio-routing" in favor of generic one.  This allows to
> remove "model" property and make the binding closer to other sounds
> cards.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/sound/samsung,midas-audio.yaml      | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


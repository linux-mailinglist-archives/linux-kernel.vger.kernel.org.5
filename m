Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C57806ADF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 10:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377249AbjLFJi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 04:38:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377117AbjLFJi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 04:38:28 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4D3B9;
        Wed,  6 Dec 2023 01:38:33 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2AE831C000C;
        Wed,  6 Dec 2023 09:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701855512;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4y+flM2aoike/FPH6qr4fSM5H3yUCAUYtHfykcYhVEk=;
        b=k3xwGbvc8l51DdwhCNNogPX2i1UK8RjJkiIGiGaX0/DJVE/mlb7iIDCQUJX7b0YZt7Pyrz
        ol/ktsBWk+HKKJ9KtMnbWNEZbsDwzAZarfZ8Tvw7RKPgjQfRyvZTdgdh2dzaknhZgnsGPc
        CYNBqpr0zllwndP39wsFuYC0BUL1s/YeutbzFu7W1iQ/r2FAd2DGfueucoeZnU4UGzcbUd
        DKRseSOSfCmYsxVvS2QS2Ef4WcQCfq6MI2Adx2ZJCp2z/Rr7ilVlDANz8ZYN4LzE2Yf7ZG
        sRDfl+Qr214EPqeEauGxYkj4Y7YZqozG5zfnFxtxI9jLhBh5pkCvFanPbMffsQ==
Date:   Wed, 6 Dec 2023 10:38:26 +0100
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Alexander Couzens <lynxis@fe80.eu>,
        Qingfang Deng <dqfext@gmail.com>,
        SkyLake Huang <SkyLake.Huang@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org
Subject: Re: [RFC PATCH v2 3/8] net: pcs: pcs-mtk-lynxi: add platform driver
 for MT7988
Message-ID: <20231206103826.4e396513@device.home>
In-Reply-To: <68bb81ac6bf99393c8de256f42e5715626590af8.1701826319.git.daniel@makrotopia.org>
References: <cover.1701826319.git.daniel@makrotopia.org>
        <68bb81ac6bf99393c8de256f42e5715626590af8.1701826319.git.daniel@makrotopia.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Daniel,

My two cents below :

On Wed, 6 Dec 2023 01:44:17 +0000
Daniel Golle <daniel@makrotopia.org> wrote:

> Introduce a proper platform MFD driver for the LynxI (H)SGMII PCS which
> is going to initially be used for the MT7988 SoC.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

 [ ... ]

> +static int mtk_pcs_lynxi_enable(struct phylink_pcs *pcs)
> +{
> +	struct mtk_pcs_lynxi *mpcs = pcs_to_mtk_pcs_lynxi(pcs);
> +
> +	if (mpcs->sgmii_tx && mpcs->sgmii_rx) {
> +		clk_prepare_enable(mpcs->sgmii_rx);
> +		clk_prepare_enable(mpcs->sgmii_tx);

You can use the clk_bulk_prepare_enable() here

> +	}
> +
> +	return 0;
> +}
> +
>  static void mtk_pcs_lynxi_disable(struct phylink_pcs *pcs)
>  {
>  	struct mtk_pcs_lynxi *mpcs = pcs_to_mtk_pcs_lynxi(pcs);
>  
> +	regmap_set_bits(mpcs->regmap, SGMSYS_QPHY_PWR_STATE_CTRL, SGMII_PHYA_PWD);
> +
> +	if (mpcs->sgmii_tx && mpcs->sgmii_rx) {
> +		clk_disable_unprepare(mpcs->sgmii_tx);
> +		clk_disable_unprepare(mpcs->sgmii_rx);

and clk_bulk_disable_unprepare() here

 [...]

> +static int mtk_pcs_lynxi_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	struct mtk_pcs_lynxi *mpcs;
> +	struct phylink_pcs *pcs;
> +	struct regmap *regmap;
> +	u32 flags = 0;
> +
> +	mpcs = devm_kzalloc(dev, sizeof(*mpcs), GFP_KERNEL);
> +	if (!mpcs)
> +		return -ENOMEM;
> +
> +	regmap = syscon_node_to_regmap(np->parent);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	if (of_property_read_bool(np->parent, "mediatek,pnswap"))
> +		flags |= MTK_SGMII_FLAG_PN_SWAP;
> +
> +	mpcs->rstc = of_reset_control_get_shared(np->parent, NULL);
> +	if (IS_ERR(mpcs->rstc))
> +		return PTR_ERR(mpcs->rstc);
> +
> +	reset_control_deassert(mpcs->rstc);
> +	mpcs->sgmii_sel = devm_clk_get_enabled(dev, "sgmii_sel");
> +	if (IS_ERR(mpcs->sgmii_sel))
> +		return PTR_ERR(mpcs->sgmii_sel);
> +
> +	mpcs->sgmii_rx = devm_clk_get(dev, "sgmii_rx");
> +	if (IS_ERR(mpcs->sgmii_rx))
> +		return PTR_ERR(mpcs->sgmii_rx);
> +
> +	mpcs->sgmii_tx = devm_clk_get(dev, "sgmii_tx");
> +	if (IS_ERR(mpcs->sgmii_tx))
> +		return PTR_ERR(mpcs->sgmii_tx);

and clk bulk operations here as well ?

Maxime

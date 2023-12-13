Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA55181189D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbjLMQEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:04:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjLMQEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:04:36 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58A910B;
        Wed, 13 Dec 2023 08:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QRqwo6sswifF3LFPo684dgIWFUyFasVRNKlEWyiikhI=; b=R+1MKf1rzy9ANE955VAmc7MRqm
        hCWSk4JX137rBfen/P8Nm47Di+4ndSbW7wyKqKAZQfSeKvNqjZOQ7h+ozG1y82K68yoGn+GJmlxTJ
        HSa3d2+TEnPRtqH2l6FBZBT0QG523tdWrM2gvgIjLfWc+lQ+OwZn8xeMBQZ+p27avi7V6KZ1EIwmE
        tUOWNpuAZOwuNx7857l8Nppar0NfBSL4jj2fssUdXc1mBs8uG1+Lm5CRVI9LBqGlXLhqKzg21wp1M
        Pg2rWKekk7nkzy3zfT65bes3ssLwvxH5KjSQJCl0VUaxSTKZcMGrv8l/GBDNAPCaM0ej6RDZvdprY
        Q6b4hJhQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55118)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1rDRiY-0000D5-0G;
        Wed, 13 Dec 2023 16:04:14 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1rDRiW-0001cw-Q5; Wed, 13 Dec 2023 16:04:12 +0000
Date:   Wed, 13 Dec 2023 16:04:12 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
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
        Alexander Couzens <lynxis@fe80.eu>,
        Qingfang Deng <dqfext@gmail.com>,
        SkyLake Huang <SkyLake.Huang@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org
Subject: Re: [RFC PATCH net-next v3 3/8] net: pcs: pcs-mtk-lynxi: add
 platform driver for MT7988
Message-ID: <ZXnV/Pk1PYxAm/jS@shell.armlinux.org.uk>
References: <cover.1702352117.git.daniel@makrotopia.org>
 <8aa905080bdb6760875d62cb3b2b41258837f80e.1702352117.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8aa905080bdb6760875d62cb3b2b41258837f80e.1702352117.git.daniel@makrotopia.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 03:47:18AM +0000, Daniel Golle wrote:
> Introduce a proper platform MFD driver for the LynxI (H)SGMII PCS which
> is going to initially be used for the MT7988 SoC.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

I made some specific suggestions about what I wanted to see for
"getting" PCS in the previous review, and I'm disappointed that this
patch set is still inventing its own solution.

> +struct phylink_pcs *mtk_pcs_lynxi_get(struct device *dev, struct device_node *np)
> +{
> +	struct platform_device *pdev;
> +	struct mtk_pcs_lynxi *mpcs;
> +
> +	if (!np)
> +		return NULL;
> +
> +	if (!of_device_is_available(np))
> +		return ERR_PTR(-ENODEV);
> +
> +	if (!of_match_node(mtk_pcs_lynxi_of_match, np))
> +		return ERR_PTR(-EINVAL);
> +
> +	pdev = of_find_device_by_node(np);
> +	if (!pdev || !platform_get_drvdata(pdev)) {

This is racy - as I thought I described before, userspace can unbind
the device in one thread, while another thread is calling this
function. With just the right timing, this check succeeds, but...

> +		if (pdev)
> +			put_device(&pdev->dev);
> +		return ERR_PTR(-EPROBE_DEFER);
> +	}
> +
> +	mpcs = platform_get_drvdata(pdev);

mpcs ends up being read as NULL here. Even if you did manage to get a
valid pointer, "mpcs" being devm-alloced could be freed from under
you at this point...

> +	device_link_add(dev, mpcs->dev, DL_FLAG_AUTOREMOVE_CONSUMER);

resulting in this accessing memory which has been freed.

The solution would be either to suppress the bind/unbind attributes
(provided the underlying struct device can't go away, which probably
also means ensuring the same of the MDIO bus. Aternatively, adding
a lock around the remove path and around the checking of
platform_get_drvdata() down to adding the device link would probably
solve it.

However, I come back to my general point - this kind of stuff is
hairy. Do we want N different implementations of it in various drivers
with subtle bugs, or do we want _one_ implemenatation.

If we go with the one implemenation approach, then we need to think
about whether we should be using device links or not. The problem
could be for network interfaces where one struct device is
associated with multiple network interfaces. Using device links has
the unfortunate side effect that if the PCS for one of those network
interfaces is removed, _all_ network interfaces disappear.

My original suggestion was to hook into phylink to cause that to
take the link down when an in-use PCS gets removed.

> +
> +	return &mpcs->pcs;
> +}
> +EXPORT_SYMBOL(mtk_pcs_lynxi_get);
> +
> +void mtk_pcs_lynxi_put(struct phylink_pcs *pcs)
> +{
> +	struct mtk_pcs_lynxi *cur, *mpcs = NULL;
> +
> +	if (!pcs)
> +		return;
> +
> +	mutex_lock(&instance_mutex);
> +	list_for_each_entry(cur, &mtk_pcs_lynxi_instances, node)
> +		if (pcs == &cur->pcs) {
> +			mpcs = cur;
> +			break;
> +		}
> +	mutex_unlock(&instance_mutex);

I don't see what this loop gains us, other than checking that the "pcs"
is still on the list and hasn't already been removed. If that is all
that this is about, then I would suggest:

	bool found = false;

	if (!pcs)
		return;

	mpcs = pcs_to_mtk_pcs_lynxi(pcs);
	mutex_lock(&instance_mutex);
	list_for_each_entry(cur, &mtk_pcs_lynxi_instances, node)
		if (cur == mpcs) {
			found = true;
			break;
		}
	mutex_unlock(&instance_mutex);

	if (WARN_ON(!found))
		return;

which makes it more obvious why this exists.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

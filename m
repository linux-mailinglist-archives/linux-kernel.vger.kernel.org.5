Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 512278076FE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 18:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442736AbjLFRwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 12:52:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379751AbjLFRwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 12:52:02 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023F9D5A;
        Wed,  6 Dec 2023 09:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=xtEyYJ2fL6Bd/0ZQMBJdBd4JHYGCVwVdwTisB+sS+6c=; b=zH/nzGG9C8Rq19EuObrG0yz4pf
        R93eD9OUVT4C3HY1QMdnol7HJPeIhWZROomiVjeEA5vOZl+0VpkragNpePVgochBymEUcb4tqXCE3
        +cjT7SYIHITZerFDewzgXH17u0OEX74lJJgr1l0RhzVh/6LqsKCJhwiwCF7e2roBz4pIBnMbfKqer
        rsm1nvLceBhbmqXohGYuaIJpwIMyIwAia2po95HwUoKD2VVBzltSdO2VPi64RXLRe2cWd+jlWTZg7
        LkNLQNz1yJGIvo73+eEPhriyAPciIpXk+54b0oGxPr5VdsfZ3ol0O1LZA6f3oOXKHIkbRLhsIHA6d
        4E4Aed3w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45446)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1rAw3e-0000CW-1J;
        Wed, 06 Dec 2023 17:51:38 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1rAw3a-0002uY-MH; Wed, 06 Dec 2023 17:51:34 +0000
Date:   Wed, 6 Dec 2023 17:51:34 +0000
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
Subject: Re: [RFC PATCH v2 3/8] net: pcs: pcs-mtk-lynxi: add platform driver
 for MT7988
Message-ID: <ZXC0pq2C6iRmeF4B@shell.armlinux.org.uk>
References: <cover.1701826319.git.daniel@makrotopia.org>
 <68bb81ac6bf99393c8de256f42e5715626590af8.1701826319.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68bb81ac6bf99393c8de256f42e5715626590af8.1701826319.git.daniel@makrotopia.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 01:44:17AM +0000, Daniel Golle wrote:
> +struct phylink_pcs *mtk_pcs_lynxi_select_pcs(struct device_node *np, phy_interface_t mode)
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
> +		if (pdev)
> +			put_device(&pdev->dev);
> +		return ERR_PTR(-EPROBE_DEFER);
> +	}
> +
> +	mpcs = platform_get_drvdata(pdev);
> +	put_device(&pdev->dev);
> +
> +	return &mpcs->pcs;
> +}
> +EXPORT_SYMBOL(mtk_pcs_lynxi_select_pcs);

If you're going to play games like this, then you must mark the driver
with .suppress_bind_attrs = true to remove the bind/unbind attributes
in userspace that could wreak havoc with the above - because there is
_nothing_ that guarantees that the memory you're returning from this
function will remain intact. Basically, it's racy.

Also, I'm not sure I approve of using the "select_pcs" suffix (I
haven't spotted _where_ you use this, but returning EPROBE_DEFER to
phylink's mac_select_pcs() method doesn't do anything to defer any
probe, so that's an entirely misleading error code.

If we are going to have device drivers for PCS, then we need to
seriously think about how we look up PCS and return the phylink_pcs
pointer - and also how we handle the PCS device going away. None of
that should be coded into _any_ PCS driver.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

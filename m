Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEE4C7E8459
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 21:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346627AbjKJUmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 15:42:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346273AbjKJUlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 15:41:45 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B610EA27D;
        Fri, 10 Nov 2023 00:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=u8052caqSNt3af6DzeiZMofvFARC4Kcew0q/mv0AkUE=; b=eRSvftjkjscZdlIzAGYnHH+mCb
        eJv7Q7N1M5DJC/5JXhgsDiDSEEoNotwJxxH4umHm97Q06EIxLrwmqmo1mUb4IR8pj1P1jwh4VwAxj
        OHzBFF0spuZUlXJ17MfpYjVtSK2edEQko3bPcc4wQsclDjXJBEfH5e3JD7fb9ae/lhoEMecXAaXqk
        1j8iyuFbsoLZY9OQpGAYmhJzhkuP+1x6ngan+I2d/m7Xhh9OLXrM3As0nN880dSCwXcBduX0xAXgC
        xKwiMdqWAJ+ywY2gpw2ZU1qwpKoiGgllcZ6gf1A5oKOkeDPUusJvn9s2XNpxyI5dg/+wd0tyBUGwp
        QOwiwivA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49306)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1r1NHG-0003Lv-28;
        Fri, 10 Nov 2023 08:54:10 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1r1NHC-0001Q8-OY; Fri, 10 Nov 2023 08:54:06 +0000
Date:   Fri, 10 Nov 2023 08:54:06 +0000
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
        Philipp Zabel <p.zabel@pengutronix.de>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org
Subject: Re: [RFC PATCH 3/8] net: pcs: pcs-mtk-lynxi: use 2500Base-X without
 AN
Message-ID: <ZU3vrhJe7WmyeVHA@shell.armlinux.org.uk>
References: <cover.1699565880.git.daniel@makrotopia.org>
 <091e466912f1333bb76d23e95dc6019c9b71645f.1699565880.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <091e466912f1333bb76d23e95dc6019c9b71645f.1699565880.git.daniel@makrotopia.org>
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

On Thu, Nov 09, 2023 at 09:51:22PM +0000, Daniel Golle wrote:
> Using 2500Base-T SFP modules e.g. on the BananaPi R3 requires manually
> disabling auto-negotiation, e.g. using ethtool. While a proper fix
> using SFP quirks is being discussed upstream, bring a work-around to
> restore user experience to what it was before the switch to the
> dedicated SGMII PCS driver.

No.

> @@ -129,7 +138,8 @@ static int mtk_pcs_lynxi_config(struct phylink_pcs *pcs, unsigned int neg_mode,
>  	if (neg_mode & PHYLINK_PCS_NEG_INBAND)
>  		sgm_mode |= SGMII_REMOTE_FAULT_DIS;
>  
> -	if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED) {
> +	if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED &&
> +	    interface != PHY_INTERFACE_MODE_2500BASEX) {
>  		if (interface == PHY_INTERFACE_MODE_SGMII)
>  			sgm_mode |= SGMII_SPEED_DUPLEX_AN;
>  		bmcr = BMCR_ANENABLE;

Phylink is asking you to have inband enabled. If inband needs to be
disabled, then we need to arrange for phylink to pass
PHYLINK_PCS_NEG_INBAND_DISABLED.

Please don't hack special handling and behaviour into drivers.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

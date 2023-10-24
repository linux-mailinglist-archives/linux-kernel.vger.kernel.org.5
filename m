Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D9D7D5B0C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 21:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344196AbjJXTEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 15:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343856AbjJXTEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 15:04:13 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D7310C3;
        Tue, 24 Oct 2023 12:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=nSXgyrd5Any4zAA1VKJ/tcBAkJl4Oo+kDodKxkp5fqI=; b=iSh7QDXawUj1WtmbBAcT6DKVkS
        riPILgcBVvE2T7tyuY3RM5X4ZpwG0b1ElkFC+uwnmiOdWdkzmY/m++sS81HeEbUe2iBChvQHSt8S8
        vjEBndJu0yzNaFyOPsUm2j6sx2wYjpImnv4WgUNOAbt/zw7KDHbE71f4qVPpS6NqRo6kvqDjeUfXt
        Mo/IVVyS+GLCYJVaE9B7ElT0o1xUxEUynSs0r0eH6txz6ENS5k6V5ZaRuMZrlpjccxLofmNzlvz+D
        z1SeS3GXJ6BwxFMSFBllGqT0YiSJZUqP2q7xuE83QSTy6dcq/MqLNOiGb2MfoPmfgbCO8WvlIsLNd
        1UBLwi/Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33170)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qvMgw-0004oC-14;
        Tue, 24 Oct 2023 20:03:50 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qvMgt-00069P-BC; Tue, 24 Oct 2023 20:03:47 +0100
Date:   Tue, 24 Oct 2023 20:03:47 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Enrico Mioso <mrkiko.rs@gmail.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v7 5/7] ARM64: dts: marvell: Fix some common
 switch mistakes
Message-ID: <ZTgVE8TzMEPvVeOr@shell.armlinux.org.uk>
References: <20231024-marvell-88e6152-wan-led-v7-0-2869347697d1@linaro.org>
 <20231024-marvell-88e6152-wan-led-v7-5-2869347697d1@linaro.org>
 <20231024182842.flxrg3hjm3scnhjo@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024182842.flxrg3hjm3scnhjo@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 09:28:42PM +0300, Vladimir Oltean wrote:
> U-Boot code does this, so you can't rename "ports":
> 
> 	/*
> 	 * now if there are more switches or a SFP module coming after,
> 	 * enable corresponding ports
> 	 */
> 	if (id < peridot + topaz - 1) {
> 		res = fdt_status_okay_by_pathf(blob,
> 					       "%s/switch%i@%x/ports/port@a",
> 					       mdio_path, id, addr);
> 	} else if (id == peridot - 1 && !topaz && sfp) {
> 		res = fdt_status_okay_by_pathf(blob,
> 					       "%s/switch%i@%x/ports/port-sfp@a",
> 					       mdio_path, id, addr);
> 	} else {
> 		res = 0;
> 	}

So that's now two platforms that do this. I think at this stage, we
have to regard these node paths as an ABI that we just can't change
without causing some breakage.

If we can't fix up all platforms, doesn't that make the YAML
conversion harder?

You've asked me to test the Clearfog GT-8k change - which is something
that won't happen for a while as I don't have the hardware to hand at
my current location, nor remotely.

What I can do is poke about in the u-boot sources I have for that
board and see# whether it's doing anything with those node paths. Off
the top of my# head, given what the board is, I think it's highly
unlikely though,# but I will check - possibly tomorrow.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

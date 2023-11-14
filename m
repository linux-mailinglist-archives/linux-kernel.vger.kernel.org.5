Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57247EB8EF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 22:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233986AbjKNVub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 16:50:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbjKNVu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 16:50:29 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40966C9;
        Tue, 14 Nov 2023 13:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=dyj12d9JUwarSFi32r69krZSdxAS2fBoSBW7chw1xuM=; b=xzCJqJbkFe2z7NeM7a7ymMtDBm
        jT5Jk9dGhIDAY0qEyglxvv8YPYKhTNIY1xb4/CN0gEi+XZM/RpXyvZ8Dp0ul9wvkP7+zeZgTGaawr
        A90Q70hTt8coE4KGeWwCEVPjifkO0uixEnmh3psVQSfFS2Lrf6myGfbVsrS3GO5XgAac=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1r31IY-000CBm-KV; Tue, 14 Nov 2023 22:50:18 +0100
Date:   Tue, 14 Nov 2023 22:50:18 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH net-next v8 0/9] Create a binding for the Marvell
 MV88E6xxx DSA switches
Message-ID: <0bd7809b-7b99-4f88-9b06-266d566b5c36@lunn.ch>
References: <20231114-marvell-88e6152-wan-led-v8-0-50688741691b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114-marvell-88e6152-wan-led-v8-0-50688741691b@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2023 at 12:35:55AM +0100, Linus Walleij wrote:
> The Marvell switches are lacking DT bindings.
> 
> I need proper schema checking to add LED support to the
> Marvell switch. Just how it is, it can't go on like this.
> 
> Some Device Tree fixes are included in the series, these
> remove the major and most annoying warnings fallout noise:
> some warnings remain, and these are of more serious nature,
> such as missing phy-mode. They can be applied individually,
> or to the networking tree with the rest of the patches.
> 
> Thanks to Andrew Lunn, Vladimir Oltean and Russell King
> for excellent review and feedback!
> 
> This latest version employs special compatibles in the
> odd ABI device trees.

So i have one open question. How do we merge this?

Can we just take it all through the DT tree?

    Andrew

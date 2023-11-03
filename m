Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED4D7E0309
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 13:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376623AbjKCMgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 08:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377053AbjKCMgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 08:36:03 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830A4D58;
        Fri,  3 Nov 2023 05:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=dZ2IV2/74//AS93j1vBOgGMskGuc4i5nUoK+wjJWXL0=; b=ZnJOhG+o4n+Wd6QDeV1pGkZQ6M
        GweFsOfUKHJJxIwng/iUsBpnvEuFwrNuT1eKWfhsZl0NB6zDFIPki57FYSU6xiOKr6pgamteZiHaO
        2GyQa2h379WAI0PgGJ+C0pT/b3TdTQ3QGWwnGZt8sendbOFBhclEkmX/4L0L1ULfjv+c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qytOs-000oTD-Az; Fri, 03 Nov 2023 13:35:46 +0100
Date:   Fri, 3 Nov 2023 13:35:46 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?iso-8859-1?Q?S=F8ren?= Andersen <san@skov.dk>,
        Sam Ravnborg <sam@ravnborg.org>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v2 2/2] arm64: dts: freescale: Add SKOV IMX8MP CPU revB
 board
Message-ID: <1ee285d7-6bc9-43ad-9ec9-a8aaed4452b5@lunn.ch>
References: <20231103105305.2459143-1-o.rempel@pengutronix.de>
 <20231103105305.2459143-2-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103105305.2459143-2-o.rempel@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +			port@2 {
> +				reg = <2>;
> +				label = "cpu";
> +				ethernet = <&eqos>;
> +				/* 2ns rgmii-rxid is implemented on PCB.
> +				 * Switch should add only rgmii-txid.
> +				 */

Its unusual to actually see that. Its even more unusual its only one
clock line. Can you actually see it on the PCB?

> +				phy-mode = "rgmii-txid";
> +				tx-internal-delay-ps = <2000>;

Is this actually needed? rgmii-txid should add 2ns delay. Since this
apparently works, i'm assuming setting tx-internal-delay-ps to 2ns
does nothing, otherwise you would have a 4ns delay.

     Andrew

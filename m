Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63CC0768390
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 05:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjG3DEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 23:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjG3DEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 23:04:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CB71BCE;
        Sat, 29 Jul 2023 20:04:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7501160766;
        Sun, 30 Jul 2023 03:04:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FF3DC433C7;
        Sun, 30 Jul 2023 03:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690686283;
        bh=XCxytUv15QG7HcusHOJ5Fk2+EpLtcAQKZgoCyEga+HM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aZyjTugRZgJmIUBOqtcLYNhG8MM3e2k840ITznMTguA0Yvv4UQf9DiVQ947HIsXdg
         F7DSkRN2LI3p91vRxkDFW9hap/llVm/VrnnJ2bb3YSPlSO73dLwtDBgyWzN7RF55fB
         AKOpbbmJ+ICB5GlOhFdmog4a8KicXo9AX8NridKRwhZ/1tqwq+aPOcXpZ2wkzb460M
         QwxAKDDhQXx5q/rz1CBDbk2uwCEF7c4g9/PjEC125eMGQr+LUqjwWYJqeTBgxlwprY
         v0Vf1brnXQa6uIQ6Yvcq+vjGCVOk4BoDqUDnLFVCdq8MM9mAvL2ixl2AnVgw6Iga4T
         O3qAJu+W1O0ZQ==
Date:   Sun, 30 Jul 2023 11:04:30 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Bough Chen <haibo.chen@nxp.com>
Cc:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sherry Sun <sherry.sun@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 09/10] arm64: dts: imx8ulp-evk: add 100MHz/200MHz pinctrl
 setting for eMMC
Message-ID: <20230730030430.GT151430@dragon>
References: <20230625124238.4071717-1-peng.fan@oss.nxp.com>
 <20230625124238.4071717-10-peng.fan@oss.nxp.com>
 <20230718033227.GE9559@dragon>
 <DB7PR04MB4010E151615277AB6BD3E4CD9002A@DB7PR04MB4010.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DB7PR04MB4010E151615277AB6BD3E4CD9002A@DB7PR04MB4010.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 06:51:17AM +0000, Bough Chen wrote:
> > -----Original Message-----
> > From: Shawn Guo <shawnguo@kernel.org>
> > Sent: 2023年7月18日 11:32
> > To: Peng Fan (OSS) <peng.fan@oss.nxp.com>
> > Cc: robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> > s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com;
> > dl-linux-imx <linux-imx@nxp.com>; devicetree@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Bough
> > Chen <haibo.chen@nxp.com>; Sherry Sun <sherry.sun@nxp.com>; Peng Fan
> > <peng.fan@nxp.com>
> > Subject: Re: [PATCH 09/10] arm64: dts: imx8ulp-evk: add 100MHz/200MHz
> > pinctrl setting for eMMC
> > 
> > On Sun, Jun 25, 2023 at 08:42:37PM +0800, Peng Fan (OSS) wrote:
> > > From: Haibo Chen <haibo.chen@nxp.com>
> > >
> > > Add 100MHz and 200MHz pinctrl setting for eMMC, and enable 8 bit bus
> > > mode to config the eMMC work at HS400ES mode.
> > >
> > > Also update to use Standard Drive Strength for USDHC pad to get a
> > > better signal quality per Hardware team suggests.
> > >
> > > Reviewed-by: Sherry Sun <sherry.sun@nxp.com>
> > > Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > ---
> > >  arch/arm64/boot/dts/freescale/imx8ulp-evk.dts | 26
> > > ++++++++++---------
> > >  1 file changed, 14 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
> > > b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
> > > index e459dc35e469..ab7af705bbca 100644
> > > --- a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
> > > +++ b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
> > > @@ -121,9 +121,11 @@ &lpuart5 {
> > >  };
> > >
> > >  &usdhc0 {
> > > -	pinctrl-names = "default", "sleep";
> > > +	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
> > >  	pinctrl-0 = <&pinctrl_usdhc0>;
> > >  	pinctrl-1 = <&pinctrl_usdhc0>;
> > > +	pinctrl-2 = <&pinctrl_usdhc0>;
> > > +	pinctrl-3 = <&pinctrl_usdhc0>;
> > 
> > All three speed modes use the same pinctrl?
> 
> Yes, the IOMUX on imx8ulp do not support config different drive strength. So here use the same pinctrl.

Mention that in the commit log or with a comment would be helpful.

Shawn

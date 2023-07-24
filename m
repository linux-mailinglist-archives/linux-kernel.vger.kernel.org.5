Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF89275EBEE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 08:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbjGXGtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 02:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbjGXGs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 02:48:58 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5528812E;
        Sun, 23 Jul 2023 23:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690181337; x=1721717337;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X+QLejVo4nrDeuAo8lREDbvE+k/FVg2ZSNpiNXXSbPo=;
  b=TQOpGDBLB/dONOvOPalai1RXsfhf1ko9vhhprsYoWddbckdkgnqn21nl
   GwdoFuHLUBjoGv7xQJboot9sdbYEd5hT0l+nIc60XQ8LcLT5q3URUaMGm
   +s4y2TPAEsSJJ5uukgZXjC2Q+pkfWc18ctGcEcYANruTC7UbWtmSMvWhP
   c9tyGGlNOTwzWwBhFkhpD7/QV+PtbhLiBNgkHisA6vYZL7UfqTLumjmYO
   B4hEL1qwknoHeh1iZF+2gVso/lTZeSCLCjkQt6kyKEzAA7ytU7BYgIrC/
   hX/CRA3epk1R2bUzLWBqperys9nAFO5/+rKxKejWql19gR2rMg7dMgH/n
   g==;
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="asc'?scan'208";a="221809493"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Jul 2023 23:48:53 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sun, 23 Jul 2023 23:48:36 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Sun, 23 Jul 2023 23:48:32 -0700
Date:   Mon, 24 Jul 2023 07:47:58 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Pankaj Gupta <pankaj.gupta@nxp.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "clin@suse.com" <clin@suse.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "pierre.gondois@arm.com" <pierre.gondois@arm.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        Wei Fang <wei.fang@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Bough Chen <haibo.chen@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        "alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>,
        Sahil Malhotra <sahil.malhotra@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>
Subject: Re: [EXT] Re: [PATCH v4 1/7] dt-bindings: arm: fsl: add se-fw
 binding doc
Message-ID: <20230724-grunge-flyover-b0720cf28082@wendy>
References: <20230712121219.2654234-1-pankaj.gupta@nxp.com>
 <20230712121219.2654234-2-pankaj.gupta@nxp.com>
 <20230712-step-dimple-31746cd3a640@spud>
 <6e13acf6-3e23-f9bf-5c3f-368e79802a8d@linaro.org>
 <DU2PR04MB86307308661039043F9FF1C79502A@DU2PR04MB8630.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tMC/5Vu1hIlJnkxW"
Content-Disposition: inline
In-Reply-To: <DU2PR04MB86307308661039043F9FF1C79502A@DU2PR04MB8630.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--tMC/5Vu1hIlJnkxW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 24, 2023 at 06:37:22AM +0000, Pankaj Gupta wrote:
> > From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > On 12/07/2023 20:26, Conor Dooley wrote:
> > > On Wed, Jul 12, 2023 at 05:42:13PM +0530, Pankaj Gupta wrote:

> > >> +  value, i.e., supported SoC(s) are imx8ulp, imx93.

> > >> +
> > >> +properties:
> > >> +  compatible:
> > >> +    enum:
> > >> +      - fsl,imx-ele
> > >
> > > This looks like a generic compatible, not a specific one, but you use
> > > it on the imx8ulp. I would have expected that you would have something
> > > like "fsl,imx8ulp-ele" for that.
> >=20
> > Yeah, this one looks generic, so not what we expect.
>=20
> This change left un-changed in V4. It is "fsl,se-fw", instead of "fsl,imx=
8ulp-ele".
> I will change in V5.

That's a generic compatible too, so no different to "fsl,imx-ele".
What is the reason for avoiding the SoC-specific "fsl,imx8ulp-ele"?

> > >> +      - fsl,imx93-ele


--tMC/5Vu1hIlJnkxW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZL4engAKCRB4tDGHoIJi
0iuFAQCgh7+l7qRuYFg5wl2S63xcJWGeNK3ZsYkey9HUQKNgkQD9FdZOFuLyLn9U
z5ihyzBLBlv4cR/jxuoMgNq+pyqYwQI=
=y6i4
-----END PGP SIGNATURE-----

--tMC/5Vu1hIlJnkxW--

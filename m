Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBCE759418
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 13:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjGSLXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 07:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjGSLXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 07:23:30 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2042.outbound.protection.outlook.com [40.107.8.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D045E52;
        Wed, 19 Jul 2023 04:23:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ov3FTNRdOCIFaBn5y5sIz+BfE3X/UYOIEyfvTsLOiMb9oU/rj73legJPN2HnOReRB+TR9aRrt+OvUKJWQN/OPLsP05F0nWM3mhhvJ2aMX+sKagwCjLSKQnqkJovdSzfPw0HQ8u8fnC5jwpyonpzqStsLjxoirxTvgCfloxCsyHlz/wD74UuEnLH48N5HBNdrUTnTnvOILja0wjCNoRWJHIr9DINi5Pnh+5YHjEzHFYCueb+9ZxE4aXD0G0ApL3qaDFJscKBC0nvvXgRfnrITZ7xYkvJO24pBWAnXJJcfiqw2Y7htDEG4XL/BifjTySVWu7QUmjpUZmJpN4cWzWPwsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IEkVtEVwrtrT2lcgjb1fce1rxKGqjbHCy9U6zCKxdEc=;
 b=cQDO0VovTFrEvGZusLQQQQx1cJtExVxLQGP7z9fVRs8TWGcM/tZsQtaEncCC4/cBKNOsGNNKsWADbWGT+OzkhN29+24pYFoGDls5UVJdVL6EI/FU8NNGU5R8KKyLsPki4CAUv3Ftq26BZuuQclnDpl3kzMtY8qImam6y34Y7A3KsID40v2zoE1uw0l8ldDKZT3L5b+nB+fV+76bMs9/SeqzNIwH2wrB3RoP0pA1loI0LW2j4s6qlqejSnpgBXcZCMaKwFB5wMFmypZCWbdQG/NAcrd7hQU6/Y3Ss3QySpZFS8wpmr5ciTn1cF5S+jMmnyuzXgJQZe5T96puU8Tku+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IEkVtEVwrtrT2lcgjb1fce1rxKGqjbHCy9U6zCKxdEc=;
 b=GwCeTa4oHJgHDAvPuLEP/zGlS3bAu8SOjh6GtGQmjPMf62pJV7noAus9tS9EbxPgjGr9Q8vkTc/1oZYimuM1EBghpZos4XIhKTJ9yqjY2/whVwZZAflvBKTMuXDJ+Q/O77FhfuNxRuy5+mFlLWMxgiJmPCy1emVXt0zzwwQhVmU=
Received: from DB7PR04MB4505.eurprd04.prod.outlook.com (2603:10a6:5:39::26) by
 AM8PR04MB8035.eurprd04.prod.outlook.com (2603:10a6:20b:248::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Wed, 19 Jul
 2023 11:23:26 +0000
Received: from DB7PR04MB4505.eurprd04.prod.outlook.com
 ([fe80::473a:28:1d98:10ab]) by DB7PR04MB4505.eurprd04.prod.outlook.com
 ([fe80::473a:28:1d98:10ab%5]) with mapi id 15.20.6609.022; Wed, 19 Jul 2023
 11:23:26 +0000
From:   Xu Yang <xu.yang_2@nxp.com>
To:     Luca Ceresoli <luca.ceresoli@bootlin.com>
CC:     Francesco Dolcini <francesco@dolcini.it>, Jun Li <jun.li@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: RE: [EXT] Re: [PATCH v2 2/3] usb: chipidea: imx: support disabling
 runtime-pm
Thread-Topic: [EXT] Re: [PATCH v2 2/3] usb: chipidea: imx: support disabling
 runtime-pm
Thread-Index: AQHZkukSER6EMlEOvUGUKvCWQIHv2K+swg6AgBG0WYCAAQQm4IAARWMAgAF+cOA=
Date:   Wed, 19 Jul 2023 11:23:26 +0000
Message-ID: <DB7PR04MB4505560E7DCBC2523FD7A0FE8C39A@DB7PR04MB4505.eurprd04.prod.outlook.com>
References: <20230504162312.1506763-1-luca.ceresoli@bootlin.com>
        <ZFPiRvoF5l8uGzzZ@francesco-nb.int.toradex.com>
        <PA4PR04MB96403377F5E37C12AD8C25B389729@PA4PR04MB9640.eurprd04.prod.outlook.com>
        <20230505120618.2f4cf22c@booty>
        <ZFThyn/D/dDK9nk3@francesco-nb.int.toradex.com>
        <PA4PR04MB96405EE2468555EA900B340189739@PA4PR04MB9640.eurprd04.prod.outlook.com>
        <ZFjaNzY32x8o2XG7@francesco-nb.int.toradex.com>
        <20230508151756.785ec07e@booty> <20230529121825.71e9b6d6@booty>
        <PA4PR04MB96405138465D215C34285F02894B9@PA4PR04MB9640.eurprd04.prod.outlook.com>
        <ZKaWL3+ClI7iNr/4@francesco-nb.int.toradex.com>
        <20230717184537.6d6ed607@booty>
        <DB7PR04MB450573F8EA936E049F053A258C38A@DB7PR04MB4505.eurprd04.prod.outlook.com>
 <20230718142504.075d0186@booty>
In-Reply-To: <20230718142504.075d0186@booty>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR04MB4505:EE_|AM8PR04MB8035:EE_
x-ms-office365-filtering-correlation-id: 9e906301-4191-4273-cf92-08db884a9229
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8DlQTzMxkv5Pw5yzfUFTAmUKVJaHN02VcEZfbX2e+bAHUUANipIfDbBBiABurOEymccl51eJQRLbSHyC3EbEkyAt4/z715BcS28qrQKhkZ8czWqtd8ErbbPmxtBvDoJhV59wRQ5n/VtXX0SPU8jMpnFvhIM4+339n9pcIWMA7vfYrddF+jB4gPhaq2x2GzJhEXG8gWT9afX5bBKQvp9Iu7TpDce0RylyRtqDfZ86h4aUgPhQrVQG6bySSiUkXqXVCQebw4QKwBGX+jNvRWyMlZ9AzmnTbTF+azpVNdafJWhklV8oM/MJPoRDhpE1wA7QNw7Ln/3DdLTy7KxwCfSu6pkjHeFvicdeAGzZUj4lHrE2/xkMXPjTY7T78WY/3oWzLNdUtEltfu1hCExUCGm/5V6njTy6I9LMLU89LDASJ3z9dLwA0hP8JKUE1uoelW1jloAzKmkbHHVlLFfKJuxAQ/6Yf/1jSodgFDuDWfrkfEAzIHmpA2L/VKmc5WmNbh2Fl36Ji8iRzmJe0t+4rm/04gjw3b8MrtYRJI2GCf5LJ/XZ3ofyHqCVKrsKLw4k9bxOFDC3ygxa2uFwlrnisi45rPA+15ReaKJKeXSdlI7YRogR61jqQCWx5j5FyiPlPGgf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4505.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(451199021)(2906002)(38070700005)(86362001)(71200400001)(26005)(6506007)(186003)(83380400001)(38100700002)(122000001)(55016003)(478600001)(7696005)(33656002)(9686003)(54906003)(316002)(41300700001)(66556008)(66476007)(66446008)(64756008)(4326008)(6916009)(7416002)(52536014)(8936002)(8676002)(5660300002)(66946007)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2BSVlLvAjF6LTiTwG87TocOtCB8DOj44LfFcY1E8lKt6Gl/DGk3IHUv4a0qr?=
 =?us-ascii?Q?nQ4uvADNkpMAqyjO1xeMCuIIXfxCdPzj8R5jIqxpo0wamXkLkMjLyf5AWCMp?=
 =?us-ascii?Q?+GHQSvSvNnckN9t+ezm7gkuMSdrDH+DYJ3l7igb2neAPzN/B6wGYqussiWKc?=
 =?us-ascii?Q?Xr0ndPssWDN3+sDE1qd3Z8ZmImsErhBPqIGSY4sPmwJhUCslOOxdE6d2qL/K?=
 =?us-ascii?Q?JP/UYH48TL0O9bq9vODQGMVFtEcn/lM998GgAj1xMj5aXCPoVfzJKqpaPw27?=
 =?us-ascii?Q?mpUECZ2q/g2wsTYB1SrM6FyeWJlfOxC9hMt6bf12HYufXjU5K8WQ3fPK1Hiu?=
 =?us-ascii?Q?H+rwx7ptP0IJR5F/bhywkZCeTrLiz1n0ciaV7/9X+CbHZA7rAKLFDk9gH8mY?=
 =?us-ascii?Q?2AiFKtYJB8GOqBDqdHGEW+AgF8mWCF4LbS8KjhYSs1ppWDEd9jiyDyFr83zw?=
 =?us-ascii?Q?Eul/fO/lT1fB2Ff4ZWcNSKNgjx/VGc+tEthucoPmAlULaUTRIPRAcIb/eMIP?=
 =?us-ascii?Q?1W/hAkG4OD/fjL/NhaI7Cd4pH05+gzXkNg3KauQ0bu5TwMxCdsmSBNX3q+O0?=
 =?us-ascii?Q?8XyygtOIKPyVKs9V6hXtcwBWyjcg8CLyRSr8OnVKBY0WlHpBE39v1Be3uQEc?=
 =?us-ascii?Q?lx0HEOLbNv4WCCavWokL4Xso5rjkY6uP7RFHeXS5r1QFTZvwNOM5zS0a39gR?=
 =?us-ascii?Q?/sCh94m5CAo+wOryGaymrUv5cybbycNED6yAeTsmwxa9hcH4lJN5Xcg4YuXW?=
 =?us-ascii?Q?p8DmCbUrRssytjnIxJbNRz17L/m4Kqsz9fyJlfnSkVhAETBrzWFKJB0bRM1A?=
 =?us-ascii?Q?0r3wnwp2D2+UgOBWaJYgApdTuHrUPJn3q24vGAo343mu3IWyUdydWmexMGPY?=
 =?us-ascii?Q?FWY2Gq4gV1tJYHGqcErsQhQ6VlXypiZRwDrehI5AfqslMh54Ax0OnqQAgLJW?=
 =?us-ascii?Q?zPBbl6us2Yz1XxABLCgWiuiaW6eBPiUyjnIu1VcbFCjO4Wkhyf63RXIOLTfa?=
 =?us-ascii?Q?ZzmlsVLFUh79mJcKvmT6loF0PoJoHI5B57Zv5zKEvMTX/XVjyGX4ab4DefrF?=
 =?us-ascii?Q?DnMOTVLsw2QqlUbguX5MDW8jNl3cr9Bh+g+vXcOBlXUUP9CixsVA78Hz8bXb?=
 =?us-ascii?Q?EeKHNjO6OjMpwd+Mubnp1F8J9JTOIDkhOCC565SODb0P0j/QTyBM6NLaV6RM?=
 =?us-ascii?Q?K42qxzm0olL7UxiFv92mnCQk/bjdG8cMs0ZiYOkz2y6Mfo4BHHAOf1lpyDC0?=
 =?us-ascii?Q?BCZV7z5WOWzpC1gbL89AuzdylQqKeu9L02HN/MYshGx8Uf1UPY98j2hXu1yw?=
 =?us-ascii?Q?EsL8jJF+tCrA03th6aGeDHe9U+pJiVbbngETQKNgmizBQkv/mmuJkctoitcF?=
 =?us-ascii?Q?xE2hO2Sj/UJaj0thRuQ5jNhCyJ2RiDHnv7gbvSkdrvZh9SZKMJK/VLG2qM5b?=
 =?us-ascii?Q?WQ0Tv23bEXBFFKkyYmB/tZl1Sw0SyHIVQzAWTUtGVP2rDMkaPktHoxYdGZh6?=
 =?us-ascii?Q?bmgj5oVygXv3omtx7yta/zLf53ihXr0ZNQb02/vwycYCmD4NDtsjycsQ5FAb?=
 =?us-ascii?Q?2LU/L+H2ZfuMJCSgEqg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4505.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e906301-4191-4273-cf92-08db884a9229
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2023 11:23:26.3776
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gOgFVWFsdauVJjiWaJwtgy4BXURn+zUH0umLpUhIBvvwwfUhgA6+HlFO2j0P5pm42w2kjupti8jwX8ZJZlNgBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8035
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luca,

> -----Original Message-----
>=20
> Hello Xu,
>=20
> On Tue, 18 Jul 2023 08:31:48 +0000
> Xu Yang <xu.yang_2@nxp.com> wrote:
>=20
> > > -----Original Message-----
> > >
> > > Ciao Francesco,
> > >
> > > On Thu, 6 Jul 2023 12:23:43 +0200
> > > Francesco Dolcini <francesco@dolcini.it> wrote:
> > >
> > > > Hello Luca,
> > > >
> > > > On Tue, May 30, 2023 at 11:22:51AM +0000, Jun Li wrote:
> > > > > Yes, your understanding is correct, talked with Xu(in CC), he wil=
l take this
> > > > > soon.
> > > >
> > > > A series was posted
> > > >
> > > > I had no time to try or look at it yet.
> > >
> > > Thanks for keeping me up to date on this topic, which is still totall=
y
> > > relevant to me.
> > >
> > > I looked at the series, but it does not seem to be addressing the
> > > problem with USB host not detecting new devices when VBUS is not
> > > directly connected, e.g. in the Colibri imx6ull SoM.
> > >
> > > Xu, do you confirm the series at the link is _not_ solving the proble=
m
> > > being discussed here?
> >
> > Have you tried this patchset? The upstream driver couldn't get correct
> > USB role from HW_USBPHY_CTRL register when the ID pin is float. This is
> > what this patchset is trying to fix. With this patch, condition
> > "(!vbus_is_on && !mxs_phy_is_otg_host(mxs_phy)" will always be false wh=
en
> > controller acts as host role, then __mxs_phy_disconnect_line(phy, true)
> > will never be called. So I think it doesn't matter whether VBUS is conn=
ected
> > or not when act as host mode. If you still have issue after apply this =
patchset,
> > please let me know.
>=20
> I tested this patchset on top of v6.5-rc2 and I confirm USB detection
> is still broken on the Colibri iMX6ULL. With or without the patches
> the behavior is the same: USB devices are detected only during boot,
> and anything connected after boot are never detected.

Thanks for your feedback. As you said this issue will disappear with below =
change, right?

	diff --git a/drivers/usb/phy/phy-mxs-usb.c b/drivers/usb/phy/phy-mxs-usb.c
	index e1a2b2ea098b..ec5ee790455e 100644
	--- a/drivers/usb/phy/phy-mxs-usb.c
	+++ b/drivers/usb/phy/phy-mxs-usb.c
	@@ -178,7 +178,6 @@ static const struct mxs_phy_data imx6sx_phy_data =3D {
	 };

	 static const struct mxs_phy_data imx6ul_phy_data =3D {
	-       .flags =3D MXS_PHY_DISCONNECT_LINE_WITHOUT_VBUS,
	 };

	 static const struct mxs_phy_data imx7ulp_phy_data =3D {

So I guess something in __mxs_phy_disconnect_line(mxs_phy, true) is causing=
 this behavior.
Could you please help to find which line to comment to make this issue disa=
ppear?

Thanks,
Xu Yang

>=20
> For the archives, I'm replying also to the patch series.
>=20
> Luca
>=20


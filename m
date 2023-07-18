Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B258B75768D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 10:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjGRIbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 04:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjGRIbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 04:31:52 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2049.outbound.protection.outlook.com [40.107.6.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661BB10E;
        Tue, 18 Jul 2023 01:31:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QmIIfQcbGxEXtTBRfNxn41gzGq+LViDgGp7DUEdUuoytvgRjQ8H5g4fZ7DI6NphflTUYUGAp8HroMb02bHPaF0KOgz7UL2nSUnsfFbbH0/T1A9ReyXdt925hb744UIuYFq02Z/2P8Se2sEWLOgr3vBtAzpX2VL/3LxLUjH9R07Q4+6c20mq/UpamPrGVEhjlnRCYGeGAjLK0rAH4OP9mmsB/EznIrGBIsGng3GPZmXhPWqB07iq8Ha9NmYU0eGdaEi5EkH1quFt40tXSFGQPGW4p+BiHtgZDzIotIC5vb/51R6+vYNIioFwR0NcWdTK1DnuM2BTPmmqRDxyOx4eM0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N9xicRDhmCvREVWH9gecWM/3BREslHlgeLqYudrD6t0=;
 b=ixOR/7HM3HmfjgSoDLKLMUxgbHap36/Q+XpnfBEqJXbMBra+gDRttYjDZV0ZA9dI5jrCs2HYdW2B2oQ7oQrb/xuT5gigxYe02Vyq08efA6B3ZWhF2LXaVLwUGR2uue1z/u6/SYv/1HzC7dMNj3H0GqGA56Op6K7ssfBt+rNONeCsDlpy4bV6eR5L8edDXC3xXyCj1sa+chLAePV0dKGGRxn/XMKGM+MqU8ULYO/8mqtmUKNSowrD8IToaMIucJI1pf8ruOCSVgkiW2USe+1x1ay/yABbHKme1BAQuawHJ4yQbNX4oNBRAFSOYN4e4RDImI06BNwrF6lPV0faSHKeug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N9xicRDhmCvREVWH9gecWM/3BREslHlgeLqYudrD6t0=;
 b=EWRCoiyhZkvQSMTTxb8mmQ7M2kNzlmxh0cZtsmTEKrJj1DNzjzQ4Rf81169zzI59M0Gdb71NsllyMBdFELOTRkhpVkEKnePFif9tvFPWExjna/forjk8450c0fAWPWb+h0AnG3PPtELLrKUyNW6poIBqFcUjvbT2RYQuh0svpJI=
Received: from DB7PR04MB4505.eurprd04.prod.outlook.com (2603:10a6:5:39::26) by
 AS8PR04MB8881.eurprd04.prod.outlook.com (2603:10a6:20b:42c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 18 Jul
 2023 08:31:48 +0000
Received: from DB7PR04MB4505.eurprd04.prod.outlook.com
 ([fe80::473a:28:1d98:10ab]) by DB7PR04MB4505.eurprd04.prod.outlook.com
 ([fe80::473a:28:1d98:10ab%5]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 08:31:48 +0000
From:   Xu Yang <xu.yang_2@nxp.com>
To:     Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Francesco Dolcini <francesco@dolcini.it>
CC:     Jun Li <jun.li@nxp.com>,
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
Thread-Index: AQHZkukSER6EMlEOvUGUKvCWQIHv2K+swg6AgBG0WYCAAQQm4A==
Date:   Tue, 18 Jul 2023 08:31:48 +0000
Message-ID: <DB7PR04MB450573F8EA936E049F053A258C38A@DB7PR04MB4505.eurprd04.prod.outlook.com>
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
In-Reply-To: <20230717184537.6d6ed607@booty>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR04MB4505:EE_|AS8PR04MB8881:EE_
x-ms-office365-filtering-correlation-id: 305beb94-a709-422c-3ce3-08db87696da7
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h+NdoijtE+d+KxSRTtK9TZ88bVfb3f8Ybrv2MjAS7PPTm6NCFpjCKlb2w9jJodSOw780llF9iV1iFUcQKcWf6GabMEI19Li+RT/xuTlpmIlE2tVSneGVgVaPgwWtiC3fZ9IzqarrU3mTTLBNigIwmXLYzmy3gnwY6r8fUV4X4E7WWeNqdGXKkrjyEyG9Iq6L0UHCA0ruwVi6F7TwbT2ZrsszJ49RoWvnP5XgtVF3G6+q5eydW7Sq2IO8JT2KBtMFMan9Gz8dKH0JRz4crAVfPbi5Ub/ZdMm5jENfhRXPn4OT73zsp6xTAiPFDYJL2oWwQRZBkdmt2wZSB1e45jPbsMqWKfQ6pu8+ve/e+U+VyjJmGMUYlwUmkSY47af1Sp0XCF09Xl8AAyQJ8sJuphtJpb/x6vo4dH8QgO5jGOS2pUwpRqZUCk74oEZ3EM7pYsd4HnLnO7WYdI31tZZe4K6NG7yM16+re+b53ClHiyuslJ3agYD+uXys7gzjoibW11mRruG4zBYrBsdgPPYcgBKRvhbH4r6LbUy0TERSA3hwgl+KG6fap2t+R7PQAyrFnlpYIOTa02nx8NfRA2R5ttmsqNPQBt2/gsq4VoZGu1ZYvRT7BJpw7YP2m50edKj1xMBI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4505.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(451199021)(8676002)(7696005)(41300700001)(7416002)(66476007)(66946007)(2906002)(66446008)(66556008)(8936002)(54906003)(122000001)(76116006)(86362001)(4326008)(316002)(52536014)(5660300002)(9686003)(64756008)(38100700002)(83380400001)(186003)(26005)(6506007)(71200400001)(33656002)(38070700005)(55016003)(110136005)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?o2HOsGGGy8DKIlR2q9Y4vPZpUQyOeC/vLUfQgYPdSkzopmH9vaXmBlYi42Cl?=
 =?us-ascii?Q?zGVrTMRXJJnCy26+Bz0WBUUOU5nnm03UN1D/wkJm9Fp94FDDx6sTYLWDQrrh?=
 =?us-ascii?Q?vUMpc19N0b01SUNd9ZfeTqoJWoi5m4yh2RGFIQic3019UCZf6hga6If8Yh1Q?=
 =?us-ascii?Q?o3Z5000pC0ONifQK5SgJbwbBUAjDSGyldpOLVxQsj44rxN6bHQG/s15HffYO?=
 =?us-ascii?Q?9VOn8cOAsUizhQEbZ4DdId5WU1OEeGvDXAcRI16UyOtLcmx3MlTe0tji6doJ?=
 =?us-ascii?Q?DHtJWWUtPiksEyKDEUNeJ3HvKskj9W3olHblV6dtehoNpGlyIaP4iaiwL6L8?=
 =?us-ascii?Q?o3UewyHpIXzRxUKWMApoDfn5cRLl8sIKmbRTr1oaYoX/y6FmCHkdN8hExrcK?=
 =?us-ascii?Q?kZeGwSeI7LSpfWPTXDyzqcOSNlb3kUkLeeeNXc/QaOKBly4OLi4PdH45959v?=
 =?us-ascii?Q?CjLMWv6xHAB5wMoXT/EmMcdjjb8hJv4GlsM6q4jQcGH/5wx580n+86rFSEvl?=
 =?us-ascii?Q?EgPc0Awm660sYm4ZSZP8+b9+SQN8CVVm9C8NbIrojx6ylah1uYJVM8Mpero+?=
 =?us-ascii?Q?2xg1sGnN6EZC5Uuw3Xflf5rFpb8t8evlSP1xXDHoe47h8XxFQ7JZgWTky8L7?=
 =?us-ascii?Q?WRMZ0tKRZ6nKTYsO/IdzOEneAW+36zl+8er+FjawNNNzaFawoPotQofq/tNG?=
 =?us-ascii?Q?WzFLKGWQuKCbBe/JtRMTChgpxFZp3p2v3meS9w9017yo6G0joeIrU3agHqFF?=
 =?us-ascii?Q?ZlwwHnNmG1XxLho33N0k2k7vMlCQmAiieGIQQrZVKKQz9Ldd8LAV+sHMuZYQ?=
 =?us-ascii?Q?IdKIJtV2egEnZu+yHyXQGPKMPNBbNmq+nvAkAvki6RXXDEdSNMUrAVr0qmeu?=
 =?us-ascii?Q?2N/4hNOOd+79i3uJQLImeEycFi7CPWaNihJFdlNQ9+xSH5nMrVMBAufnGs6D?=
 =?us-ascii?Q?6yL/hRb47EeQckM9bcI7oMawmVxUxctAb0SheIItmHsq/6bClKeHTpKqopKe?=
 =?us-ascii?Q?o4yUtVxAxTUp7IC9CiOV0CsuuBGbMuX/bBmeJpN1F9z4dpspBJiIpQZyGyJW?=
 =?us-ascii?Q?Yh+zDro2pxvWPqh/ZluadlXagNhQR7F1SPabDGTmPKUnriFr4X6r50bM8T7B?=
 =?us-ascii?Q?/crLsLPj3esrIMlZJqwq7yirnpAOveFZB7Y8M1bQQqRLaXiVcap07OR3/ZoQ?=
 =?us-ascii?Q?GnpnuqmT5dESiHp6bFAYiAMjpYhcbdQXpqZ089sB4rZbwefv6Re0Djkf0ru1?=
 =?us-ascii?Q?kM2wbHIctDhOmIVZEuOJRLdNW+XeDlueExnHInhYuohRzkvUmCROp0/G7F95?=
 =?us-ascii?Q?uLUb2ZZSETrMwy/w/QseLL4lQuWHaILLFzbeharf6vp+QnPiJ2OE7NySv928?=
 =?us-ascii?Q?wxh8RPHcf8NaThgDclRSjpgqV2QeFzvz387g4TnJsfglCUwAoDi+8ULoZiZL?=
 =?us-ascii?Q?8VsQfrOjBfwHqu9kV+lY7lmxQq6l7FqPsjLdATkeoPIIY/F0rNcdvLum4GAP?=
 =?us-ascii?Q?pa52NMUY2RHsmjCvowAEivl+FDEWzKrZIo8PP1tS7kWPrtF1CI9Gly6OGy7R?=
 =?us-ascii?Q?F4AtdRWDtA11MfLQxok=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4505.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 305beb94-a709-422c-3ce3-08db87696da7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2023 08:31:48.3876
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KPgj9e6bSpBM2SRp4ZgrzWlUNzCClmNlVAMynffXQjw3YwUFGTWVCiD2EvzBGY7ioJD4DQka9yIPH5qYgypu7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8881
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
>=20
> Ciao Francesco,
>=20
> On Thu, 6 Jul 2023 12:23:43 +0200
> Francesco Dolcini <francesco@dolcini.it> wrote:
>=20
> > Hello Luca,
> >
> > On Tue, May 30, 2023 at 11:22:51AM +0000, Jun Li wrote:
> > > Yes, your understanding is correct, talked with Xu(in CC), he will ta=
ke this
> > > soon.
> >
> > A series was posted
> >
> > I had no time to try or look at it yet.
>=20
> Thanks for keeping me up to date on this topic, which is still totally
> relevant to me.
>=20
> I looked at the series, but it does not seem to be addressing the
> problem with USB host not detecting new devices when VBUS is not
> directly connected, e.g. in the Colibri imx6ull SoM.
>=20
> Xu, do you confirm the series at the link is _not_ solving the problem
> being discussed here?

Have you tried this patchset? The upstream driver couldn't get correct
USB role from HW_USBPHY_CTRL register when the ID pin is float. This is
what this patchset is trying to fix. With this patch, condition=20
"(!vbus_is_on && !mxs_phy_is_otg_host(mxs_phy)" will always be false when
controller acts as host role, then __mxs_phy_disconnect_line(phy, true)
will never be called. So I think it doesn't matter whether VBUS is connecte=
d
or not when act as host mode. If you still have issue after apply this patc=
hset,
please let me know.

Thanks,
Xu Yang

>=20
> Best regards,
>=20
> Luca
>=20

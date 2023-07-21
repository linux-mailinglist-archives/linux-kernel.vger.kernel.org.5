Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB3E575BC19
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 04:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjGUCGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 22:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjGUCG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 22:06:28 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2075.outbound.protection.outlook.com [40.107.105.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839C7271E;
        Thu, 20 Jul 2023 19:06:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PuxDtJATe3WJ8tr0GNKTMoShjMdBFQWY1NwnwtiUvDxdnHobbMGNNAx6C4iidWWPRBjmn7nK68iZgU9UC6EjKC7FqggVEvvi3+xhuqAPRW6d6Xq/E6XPW1pM15X16sy2+bIJYVfcVYcNHZz4muTTYDRX7+3oCiVRMWZyDwlJHjKwfz6tEOjFAhdUVYYZLxHfw8Dg0O/4WbO620CcTcPxKDm5H3Sx2LDM4aPEEBj910ir+5uAA8Bh0zh0e1bgxXp/z4rocikVdUjRNXTAul88Uo+4nteBPHim/72XB93RWYQxYJT03hfJRIboJGt0fEHxsbOkinzxtiXAvCs/fc6eBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gcUe1wDjSSjRWUxX1BzRYajmZynUriaMM2aEvMJXaaE=;
 b=hBASk2wE+qklKjAOV9r2aKVTJ9JIQ0SY8bGp/cpXgEJUqg7zevTHfvXenOR1ToJ6litGMMTPt3FCk31hh3objPt95yB5ddSm1rdjCkL0xIL+BxyilzfuCiUVwoV88f2//MNtfBFXvx1IwpgR+47gytYzNaRLvxrVUqqEpVXV7/lW6vhE729E8K97LcQFBLiJJ7zhpHLyb6N9xSsEgXr7TgwPxHfeXmB800dbBoERQWdTuyVQ8I2wG9ISgIWKoi5byrJZD0D/lOWbUPIOxmQjOJOtp9IWYmDJ3kCZX145r16YFdnvAkzBti17rQvTPCEzbqc2SZWsskjA7UDe0ERaKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gcUe1wDjSSjRWUxX1BzRYajmZynUriaMM2aEvMJXaaE=;
 b=JwgEJzphepAfWtSP1eVK67KLRMfPxLtYlhuT/fkkCysPlNPUZXIRWgkLKFxOIwDv/OvednEWk1YQx7TqsRve6BJ7UH0ZgJ67BKh5+YzP08qRuwQDS8EgFr8tvtkHIz1eK31yYLuir8/1PsFYraCb4MZSQ4pJyyYHGqE+0IQ0Kdk=
Received: from DB7PR04MB4505.eurprd04.prod.outlook.com (2603:10a6:5:39::26) by
 PAXPR04MB9006.eurprd04.prod.outlook.com (2603:10a6:102:20e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Fri, 21 Jul
 2023 02:06:18 +0000
Received: from DB7PR04MB4505.eurprd04.prod.outlook.com
 ([fe80::473a:28:1d98:10ab]) by DB7PR04MB4505.eurprd04.prod.outlook.com
 ([fe80::473a:28:1d98:10ab%5]) with mapi id 15.20.6609.022; Fri, 21 Jul 2023
 02:06:18 +0000
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
Thread-Index: AQHZkukSER6EMlEOvUGUKvCWQIHv2K+swg6AgBG0WYCAAQQm4IAARWMAgAF+cOCAAF2AgIAA4BAQgABvbACAANwWkA==
Date:   Fri, 21 Jul 2023 02:06:18 +0000
Message-ID: <DB7PR04MB4505F28957A32F09BB84B27A8C3FA@DB7PR04MB4505.eurprd04.prod.outlook.com>
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
        <DB7PR04MB4505560E7DCBC2523FD7A0FE8C39A@DB7PR04MB4505.eurprd04.prod.outlook.com>
        <20230719184831.75ae8658@booty>
        <DB7PR04MB45050B15EDA7A2A3940840308C3EA@DB7PR04MB4505.eurprd04.prod.outlook.com>
 <20230720144916.01d49adb@booty>
In-Reply-To: <20230720144916.01d49adb@booty>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR04MB4505:EE_|PAXPR04MB9006:EE_
x-ms-office365-filtering-correlation-id: 316d4269-962f-46ca-8a96-08db898f1255
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oHPsOVPpFaJsXOYQKEPxVmqRFzwLCAnEAAZkGxUsCYnmLEWjbgYU3qDlDw75/eW/IhQanfIH3Yx5S6HBqzu3IkAOWydnye3iWnafH4HCK95hUbdbGUOigm/g1H02MA5Ru8m5NzgBSwfSTTcdMI4sESAcpHBKeeh38GrA8XOQoAieoCZH/69ErKivOv7vf4KEMqFF4pWM+c8umZLM1GkEL7moJDE6mHgNEGT+VAhbka5UkAWPYuTxkT3bjpYz48F2o9OdEHTAZ4zTEttcY7O91pjmuUtZ5esmaWmKOR+CuaLxrVbOxb8Js6Fzc3GYyjkt2M1RfHaPPDL7tzEYGhuXvx1ue13DjEiLwCB9W1dcdnLzGTMHHsQRpYfByWj0xdetoEhjpOnOb8vYDkhxFFLkioCSrV1p9Gsgo5C8ijdH8IGS1C++3JMbDXVoj6pDZpj/C8MMqzHC/sLU8Zu4rLecHfUoOvIxNEdXBje3CUnX8QbABnoyarM9+didP56rRe8pee1WGQxRXzxtcM3bvETxPtTLjOImjvQ16XhoafqzpBvLCUqEZcSYSCSOne3Fma7W7zTZ6j4ej8JTg8aYdpdJKcxyoxodiEkbQUMEIXeSync=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4505.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(39860400002)(396003)(366004)(451199021)(83380400001)(71200400001)(9686003)(7696005)(966005)(122000001)(55016003)(6506007)(186003)(26005)(316002)(54906003)(478600001)(6916009)(38070700005)(76116006)(86362001)(2906002)(38100700002)(66946007)(66446008)(66476007)(66556008)(64756008)(4326008)(8936002)(7416002)(8676002)(5660300002)(52536014)(41300700001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kwXOEgPLhIASgR8+W948yYEHi8NSSr6/1eZ/lfhexxqaUOUt5jKT/Zc6mbF3?=
 =?us-ascii?Q?EB23Tda/HTTZ1Vvweyo19zc6KVOqGyYMsrnY4raN+jlc3IGrF6/GDEZLBHDq?=
 =?us-ascii?Q?/+XdpxJq6wgmIxMBGKOvdDqKJn5gXm6s7OIyUCEcvxdSW0HSl9EhYUzzFSlF?=
 =?us-ascii?Q?OdIWgnsGfsA3i/QR/gzcEIkaAqYP+w7YSReMBqrPDnG3pdSixjTO+xHH3XRP?=
 =?us-ascii?Q?qzRLJ/omNuam4LoCQ34cZyByvaM2VEedna1V7ArKWr5iY4SPgjA6/zF/BiQ0?=
 =?us-ascii?Q?j+u0nj9a/KL4uUzyBF3305LhEhi8fwHqYfR7Tvhi8n3DJCiuGcmSdMtWPWhP?=
 =?us-ascii?Q?sgzx6XtyssKE3VKteHPmO0OafEgBWawkdcAMAU0uX4+yhDpVby4a1fPZHq0W?=
 =?us-ascii?Q?rKvfKj9uIAXi0ql00hEc1WCbob+qInB1kovhzGnNnNJx9vebp/tW/3F+tpAS?=
 =?us-ascii?Q?1xmhX/QSWyWKR19gaPVbCY088730urYKbhpVnB1A2e8LenB0D0UbRz0/kA/9?=
 =?us-ascii?Q?/EP+/V9g1AgUn5bq4JvErp1rr0b16ntXIPMY3Qjm++a31nsZ971TuavfpYbo?=
 =?us-ascii?Q?IZHiq88MZYH6fdBU8R+P+AS/cGL+XWfBBuzQIl+XY9OChZT7aFlj3GOjuUnE?=
 =?us-ascii?Q?lQ2FlQ1FasrZGTB13r8xw3leFySXdE+7e/SvDEjOu63Yk2d4DbYZYuYNpRaV?=
 =?us-ascii?Q?rgcQzfm18M0nGHvb4s2I6WrRqAHKOFCUjoeqmEAXKU2VbfNmUgw5K0a07vZi?=
 =?us-ascii?Q?2bSdIaVgJRUGOKcf1ZRaBbxVDXFUUb+tmsgR7uKrvTggnNkD3LDnx7/YIR0N?=
 =?us-ascii?Q?FwSVI7LuuWUxBEhz1fxiPI1/l10dAA+6r392eZJjXfv74qETaqG/RFWM0RX7?=
 =?us-ascii?Q?A0kV7MxKWqby/bvNmYe7DeCrk9ashi5ZZ0b1SuoYxqTmb7kXd/F1grZR9ujy?=
 =?us-ascii?Q?lSAVBkIh5kPSzooGbGRmJ+WiiyMAhS+poOjX00YYriAztQCjb09n4RzvFMyf?=
 =?us-ascii?Q?m2gM7ofIo4TPC66VJ5a3RWyueFvkioZ4iqBQfCt6TkrziWEF2q7Dl7JUqFh0?=
 =?us-ascii?Q?UKPXs1kY+6JBrMOv+ldngNBbHiCWLp1go0N1xnuKNRtzASN67IwIIllDHhW0?=
 =?us-ascii?Q?bS84HWer6KSFK8zuNTX5YYKVsB/oCRc/gNI590yrv34fOCVkEF35nkjeiC7V?=
 =?us-ascii?Q?lPZgGxBMjjMGCcqGn3CcW2b+npdUG//Xtd/oJu8CHxiZnH8tiktE/T/0fOYm?=
 =?us-ascii?Q?qIzoS4uN6kBOLA3WcIG+RRzasoqeT5FXqFpcyGzJT7Ge0T1D8iSl6p7YxLau?=
 =?us-ascii?Q?YGEJwif1fXwHw258RLjlXSonoHEErBBcsuu2vX9RTEbXoyK4GEyAZJGZgWse?=
 =?us-ascii?Q?HvgDS9bmhv0yNlYR5j3yWvG5X64uzUhkxVqnzBDbVMDR8xIWBGxuBaqWQwWP?=
 =?us-ascii?Q?PxTn8Y9bgi28bIThoiw5YvDutZPKhKl9OiaZeqQmjmepsrpOtTOuKkyg8WGD?=
 =?us-ascii?Q?f8m+YxlOb/yCnFvy9hqCuh56fFGMwyFpisx3hs/mPnHmkFWx/LJelpqz4l6V?=
 =?us-ascii?Q?j/w0HS4/p92zLjXw2VA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4505.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 316d4269-962f-46ca-8a96-08db898f1255
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2023 02:06:18.3856
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v8MCNGPBoMotAJOfYEFnvvqhEzWB/s219zpqz3CNKC52BOeLVdloPfzK2Xz9f/3WBz7VZpomgC2TTto6DJJ1ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9006
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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
> Hi Xu,
>=20
> On Thu, 20 Jul 2023 10:13:57 +0000
> Xu Yang <xu.yang_2@nxp.com> wrote:
>=20
> > Hi Luca,
> >
> > > > > -----Original Message-----
> > > > >
> > > > > Hello Xu,
> > > > >
> > > > > On Tue, 18 Jul 2023 08:31:48 +0000
> > > > > Xu Yang <xu.yang_2@nxp.com> wrote:
> > > > >
> > > > > > > -----Original Message-----
> > > > > > >
> > > > > > > Ciao Francesco,
> > > > > > >
> > > > > > > On Thu, 6 Jul 2023 12:23:43 +0200
> > > > > > > Francesco Dolcini <francesco@dolcini.it> wrote:
> > > > > > >
> > > > > > > > Hello Luca,
> > > > > > > >
> > > > > > > > On Tue, May 30, 2023 at 11:22:51AM +0000, Jun Li wrote:
> > > > > > > > > Yes, your understanding is correct, talked with Xu(in CC)=
, he will take this
> > > > > > > > > soon.
> > > > > > > >
> > > > > > > > A series was posted
> > > > > > > >
> > > > > > > > I had no time to try or look at it yet.
> > > > > > >
> > > > > > > Thanks for keeping me up to date on this topic, which is stil=
l totally
> > > > > > > relevant to me.
> > > > > > >
> > > > > > > I looked at the series, but it does not seem to be addressing=
 the
> > > > > > > problem with USB host not detecting new devices when VBUS is =
not
> > > > > > > directly connected, e.g. in the Colibri imx6ull SoM.
> > > > > > >
> > > > > > > Xu, do you confirm the series at the link is _not_ solving th=
e problem
> > > > > > > being discussed here?
> > > > > >
> > > > > > Have you tried this patchset? The upstream driver couldn't get =
correct
> > > > > > USB role from HW_USBPHY_CTRL register when the ID pin is float.=
 This is
> > > > > > what this patchset is trying to fix. With this patch, condition
> > > > > > "(!vbus_is_on && !mxs_phy_is_otg_host(mxs_phy)" will always be =
false when
> > > > > > controller acts as host role, then __mxs_phy_disconnect_line(ph=
y, true)
> > > > > > will never be called. So I think it doesn't matter whether VBUS=
 is connected
> > > > > > or not when act as host mode. If you still have issue after app=
ly this patchset,
> > > > > > please let me know.
> > > > >
> > > > > I tested this patchset on top of v6.5-rc2 and I confirm USB detec=
tion
> > > > > is still broken on the Colibri iMX6ULL. With or without the patch=
es
> > > > > the behavior is the same: USB devices are detected only during bo=
ot,
> > > > > and anything connected after boot are never detected.
> > > >
> > > > Thanks for your feedback. As you said this issue will disappear wit=
h below change, right?
> > > >
> > > >       diff --git a/drivers/usb/phy/phy-mxs-usb.c b/drivers/usb/phy/=
phy-mxs-usb.c
> > > >       index e1a2b2ea098b..ec5ee790455e 100644
> > > >       --- a/drivers/usb/phy/phy-mxs-usb.c
> > > >       +++ b/drivers/usb/phy/phy-mxs-usb.c
> > > >       @@ -178,7 +178,6 @@ static const struct mxs_phy_data imx6sx_p=
hy_data =3D {
> > > >        };
> > > >
> > > >        static const struct mxs_phy_data imx6ul_phy_data =3D {
> > > >       -       .flags =3D MXS_PHY_DISCONNECT_LINE_WITHOUT_VBUS,
> > > >        };
> > > >
> > > >        static const struct mxs_phy_data imx7ulp_phy_data =3D {
> > >
> > > Exactly.
> > >
> > > > So I guess something in __mxs_phy_disconnect_line(mxs_phy, true) is=
 causing this behavior.
> > > > Could you please help to find which line to comment to make this is=
sue disappear?
> >
> > To correct what I said:  __mxs_phy_disconnect_line(mxs_phy, false) shou=
ld
> > be called.
> >
> > I think the enable wakeup sequence should be follow for host-only port:
> > mxs_phy_set_wakeup(mxs_phy, true)
> >     mxs_phy_disconnect_line(mxs_phy, true);
> >         __mxs_phy_disconnect_line(mxs_phy, false);
> >
> > And disable wakeup sequence:
> > mxs_phy_set_wakeup(mxs_phy, false)
> >     mxs_phy_disconnect_line(mxs_phy, false);
> >         __mxs_phy_disconnect_line(mxs_phy, false);
> >
> > So "bool variable disconnect is false" all the time.
> >
> > >
> > > I did some tests and detection works by doing _any_ of the following
> > > two changes (or both of them).
> > >
> > > Change 1:
> > >
> > > --- a/drivers/usb/phy/phy-mxs-usb.c
> > > +++ b/drivers/usb/phy/phy-mxs-usb.c
> > > @@ -359,10 +359,6 @@ static void __mxs_phy_disconnect_line(struct mxs=
_phy *mxs_phy, bool disconnect)
> > >         void __iomem *base =3D mxs_phy->phy.io_priv;
> > >         u32 reg;
> > >
> > > -       if (disconnect)
> > > -               writel_relaxed(BM_USBPHY_DEBUG_CLKGATE,
> > > -                       base + HW_USBPHY_DEBUG_CLR);
> > > -
> >
> > Since disconnect =3D false, this code didn't get executed all the time.
> > Remove this will have no impact. But your test results didn't align
> > to this. Could you please help check the sequence? Is disconnect
> > true or false when __mxs_phy_disconnect_line is called?
>=20
> What I observe is that __mxs_phy_disconnect_line(..., true) is called.
> This happens during boot and after unplugging a device in case one was
> detected during boot.
>=20
> This is because in mxs_phy_disconnect_line() [0]:
>  - on =3D 1
>  - !vbus_is_on =3D 1
>  - !mxs_phy_is_otg_host(mxs_phy) =3D 1
>=20
> Which one(s) of those three would you expect to be 0?
>=20
> Some additional info about the !mxs_phy_is_otg_host(mxs_phy) value:
> with or without CONFIG_USB_OTG, it always has the same value because
> phyctrl always has the BM_USBPHY_CTRL_OTG_ID_VALUE bit set.
>=20

I guess you didn't apply my whole patchset.

[1/3] usb: chipidea: add USB PHY event
[2/3] usb: phy: mxs: fix getting wrong state with mxs_phy_is_otg_host()
[3/3] usb: phy: mxs: disconnect line when USB charger is attached

The 2nd patch is going to fix the issue of mxs_phy_is_otg_host():
https://lore.kernel.org/all/20230627110353.1879477-2-xu.yang_2@nxp.com/

Our design is not to disconnect line when the controller is acting as host =
mode.

Thanks,
Xu Yang


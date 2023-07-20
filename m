Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9380E75ABB8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 12:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjGTKOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 06:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjGTKOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 06:14:02 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2088.outbound.protection.outlook.com [40.107.21.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6E7B7;
        Thu, 20 Jul 2023 03:14:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a2gEkY01Flxx37RxkVbbdwNv8Jkh/i61MNsXNvV1oAUajxxO+1uLXulLkA0DxjhFWwcrPqOOHXOlB8ua96qRtwApPAdqDEgavuNZFoSw/5nAkC9lYpWvKT9kqtir0k5sukpxWZMjKek6Gnol19DHdm6arSVCoOPe6iZakqfyJpTkbPQtLhgZ6ipdqgldqJRH+JOM2nrgefVwCFmRDo5UpZKXw8RMOO/UCiOf9PdsZ+MWIFPrUGoyC5KG9e9XmS6DJ1J/TLnzLaWvdPv1vmeew5ES708oubf1fHTWZDACubdxTX2Gi1pxqRXqx+/EdLuA0PAmscYtIiVDrHjf9lSWWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SyMsAmRDsfeqQ34IPasKhA59cN0Q9JHQYmEjhWGa0tg=;
 b=MQ4MTfwYG0n3rWkvvdmQ4zV1yghfkmEqkYeeFGwVYjjrkvWqIjHsorDcIOMQJRYi6xMAZNaAN7QYoHYcVsD11li+K1B6jWDaZclIZ2845Y4PC9UeDSwOSI/ju1/n6n0fEmFpa4N8hOnpJGuxsaKkkkR8fudTr298MxPPZuwF9x1zWiSH6YOljaZlHed/BgGWL3FvpBTsrWgmOF3s7QHKSe82x6Qq+rWSP7YI1sGgJOpPjqLz2Xjw7g5TM2h6VvmXFNyZDMdCXDCGKjEz3SukSm6GQFoHcktdRc6AVS9SxZRVNWrpIlkhfCHJ583tZNDnUsvhvNFSd+HDytg+DRRc6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SyMsAmRDsfeqQ34IPasKhA59cN0Q9JHQYmEjhWGa0tg=;
 b=EgZ7DtuOVGahFMMQT7wqYazZgUJiHAzxKIoVwMd2VZzDJ9SpH3jWQNRDMvRMo44hCj9jqk6WX6F0G+Hkn6mTi6Ekwpyf4mltlM23rm9UVorJ840GgBlixJr2xyjFvmkoDAzXjnGHfgBbGLnsi7C8fJYCtyxeQXJwByigy1RxFwY=
Received: from DB7PR04MB4505.eurprd04.prod.outlook.com (2603:10a6:5:39::26) by
 AS8PR04MB7559.eurprd04.prod.outlook.com (2603:10a6:20b:295::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Thu, 20 Jul
 2023 10:13:58 +0000
Received: from DB7PR04MB4505.eurprd04.prod.outlook.com
 ([fe80::473a:28:1d98:10ab]) by DB7PR04MB4505.eurprd04.prod.outlook.com
 ([fe80::473a:28:1d98:10ab%5]) with mapi id 15.20.6609.022; Thu, 20 Jul 2023
 10:13:57 +0000
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
Thread-Index: AQHZkukSER6EMlEOvUGUKvCWQIHv2K+swg6AgBG0WYCAAQQm4IAARWMAgAF+cOCAAF2AgIAA4BAQ
Date:   Thu, 20 Jul 2023 10:13:57 +0000
Message-ID: <DB7PR04MB45050B15EDA7A2A3940840308C3EA@DB7PR04MB4505.eurprd04.prod.outlook.com>
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
In-Reply-To: <20230719184831.75ae8658@booty>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR04MB4505:EE_|AS8PR04MB7559:EE_
x-ms-office365-filtering-correlation-id: 9ccdca33-0a8f-46a4-b2e2-08db890a07eb
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y3vUWw8wOlgf00xghFLEaKTljZ3DOWoZbH5OUNoi9qp7KD7ikI3gH+anfbsV8nM6WoT/n8td/AUJEgquuEFgl3Duqt0diiex2mJzhuTE2l0aY9WWDRUN0dsajAwFApsnKwgN0G3pIc58qqcehFAmBTBzw+HABMUoJvazPHXS5c14uMnEK8bdKHFzbGgh8Q4nJUFVKs9Iadci5YnvJuDLRQaf9bJhXcYH5n24t51xCjb5Ke8J5/cbX3cHLr8cY297SXb1UlONjg1ObBk65BHzuAf3VMaDAUuMhw1N/uaqZRu76q+il38Q1X52McXmJKptjMQp2NVVMHzHcvTkUoqQARnBhNVr8EkM8XD4yQZ4p7qSMTZ/c8yW0OlhfQr0TttOZyfWifpuQbkfzYzS5OOj81gPs/g9UyeJO/DQAimiiVIvWvx7900hGm3yr+TJazzZPzW4AJrn4GsV3akxj8LxBLk/KYCUO7GXqXegkVbfni7u3rutLSwnyFaKCXMACUi58lwiPtlLr7YoKl35So/KrgRHl3UtAVSY8RymxfLpXwGipl7AjNECL4c7joXo6reb+juNDW5VnslYqFeZ8gFs6kPRQRA7Fu2nj0kQCLxKVaCaFVuIWTSabeaBKCoswTQD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4505.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(39860400002)(136003)(396003)(376002)(451199021)(55016003)(41300700001)(54906003)(7696005)(122000001)(71200400001)(8676002)(478600001)(9686003)(66476007)(5660300002)(8936002)(66556008)(52536014)(6916009)(66946007)(316002)(64756008)(66446008)(4326008)(76116006)(38100700002)(6506007)(83380400001)(186003)(26005)(86362001)(38070700005)(33656002)(7416002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7TzQx3UkCJ57HefhGkex7Zi+ht/+SGzUogpr9JWhefljy1GNu+RfZBciEJ5x?=
 =?us-ascii?Q?kP+X/pATeKLdhxWKco2IK0uXhSHuwDmmC8lE3LrvvNQgIPQWSjChUN7YQFtf?=
 =?us-ascii?Q?If6/7UokD1bRgrALN3varNgjJ4VExUoLWiaOrtdRRmtgvc/rCi2CwL7Z82Xe?=
 =?us-ascii?Q?yxFPsvTRSHfYJQmeJ1unPqa587gb4E6xz/oBJNj+2kmYO9/1X0HAtNmW72gk?=
 =?us-ascii?Q?Xr8gOqtn44J81q0V8POpQ2bl51Dm2WqRW4IigT+4C17rieE0jyH9QTxTcn/y?=
 =?us-ascii?Q?bus2oMTH89HpRdGEckEce1NlsBb6T7rrgGP7DCuy7cStbFOtqmqz3P8JyQl5?=
 =?us-ascii?Q?QgrFjC+Hdg+0zDH/C6AYOdk71E5N9scYawhJ73Ge5HkjkT28FzaO8g/xdiXE?=
 =?us-ascii?Q?0EMKmRgW07kXQ7zQZ0UxHSdq5qkWFlHlVLtSlX/NiXyXHgzomnCC/WuPA3wF?=
 =?us-ascii?Q?DFasrNSCMbh+/jr2LIRDUPvYWFezSsMUmVEjlBG7cGrLtLj4JSIOADPdhZ9J?=
 =?us-ascii?Q?Olc+Lo5NpMP8XwKGTucICEtzFMAbuekRz/W4rPa30z6Zz+S4nHzw34l54KDi?=
 =?us-ascii?Q?ughYovHpBG0Tu29Pt+rWoM5T3iqFov/08uubLzJcEU7IIbXlK2wvU7pYxkkw?=
 =?us-ascii?Q?OlcwryqTVEBwTPOE9/uGFI0U+3mgQXRo+HvivMPhCA8bLNc0WrH27/sWYzh1?=
 =?us-ascii?Q?xwJdSmyT6EPoGeEEufUJ5NHUqdXKeJCD15JBQ5GXXQjlBdhzPzPxx5gz7Cr3?=
 =?us-ascii?Q?e/NeleekLpgaXWsyn1fnlC46ff9mqUvBtbbkSG2HnqjRTxgolrGm93l8w1Jw?=
 =?us-ascii?Q?t+tkv5OKAx/jjmll8pJlDMIi2LlD/BriQ1kIEP7MJmlJs3wOXIQptcg6vQCw?=
 =?us-ascii?Q?xbOb2ISVF+bjHhZcGSM67XcTOfN/KbBy9AUHf/qmhXqNLhanINhtfpJ0ZOdP?=
 =?us-ascii?Q?kQ8De7XCy1RjKdVuzD9WU66rz3hIM1CNnDn3+7p5gV1MSZ2FfqWAI565QVwL?=
 =?us-ascii?Q?0Bmz9cvNUT3wfL2Vie1+6+nIYMM3DTbf6o+9NS9UCjKS035S2Y30NcWwaiTI?=
 =?us-ascii?Q?S6CwQEKMksImwjHOcBbzkVcyNNYmfpo/R+SqC9CVp/nhR4zX4zEonYCNwabV?=
 =?us-ascii?Q?qt6/B5SeKVlO+M4svjuUwiNoaJ8mACpgCrpGSo3eQstjV0L42fZi8hEN1ITQ?=
 =?us-ascii?Q?MwGxuXQVgZ65jz+AscsBsnnqTo4GkSqL+CGOANv5kVv2n4TPxy4wtqkVRAcU?=
 =?us-ascii?Q?gZaJ1DD1IY5wkZCfss0bp720Cv/T6aGU6dppe0VKqL5xP1HI5wRbwuH5sdxe?=
 =?us-ascii?Q?mNDdveYtpfzGIxvcFtsRZHnS8JZ1KIxNdZLVybwwx0ZCCdWuRJUR3ONDwI6M?=
 =?us-ascii?Q?D2WI5vK6Rzk30IFC5GnEwq5Wq2IQcpruMj7DI+qXLwY4mWOoeFlV51TFETif?=
 =?us-ascii?Q?c9zpORBEAjoDmvlINXmVE0OsizWImlm7VDodZQDn/7hsxgz03k/CkOfdReLM?=
 =?us-ascii?Q?cLncszxGEikYjphzceu9XZ50BNa0cMr+bK51eKL8ZTVw0swMaWi1BRaMNNjW?=
 =?us-ascii?Q?OIu7c9m9URID/NoX2hY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4505.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ccdca33-0a8f-46a4-b2e2-08db890a07eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2023 10:13:57.8447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7smY8D1JzJbsZZuUMMg+WgSEPSWqtfVVzbkadRK3S+bwIAz8kYgGXjD+m0gWMg+JzvvsAImEgvYbEWaGq9lZUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7559
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luca,

> > > -----Original Message-----
> > >
> > > Hello Xu,
> > >
> > > On Tue, 18 Jul 2023 08:31:48 +0000
> > > Xu Yang <xu.yang_2@nxp.com> wrote:
> > >
> > > > > -----Original Message-----
> > > > >
> > > > > Ciao Francesco,
> > > > >
> > > > > On Thu, 6 Jul 2023 12:23:43 +0200
> > > > > Francesco Dolcini <francesco@dolcini.it> wrote:
> > > > >
> > > > > > Hello Luca,
> > > > > >
> > > > > > On Tue, May 30, 2023 at 11:22:51AM +0000, Jun Li wrote:
> > > > > > > Yes, your understanding is correct, talked with Xu(in CC), he=
 will take this
> > > > > > > soon.
> > > > > >
> > > > > > A series was posted
> > > > > >
> > > > > > I had no time to try or look at it yet.
> > > > >
> > > > > Thanks for keeping me up to date on this topic, which is still to=
tally
> > > > > relevant to me.
> > > > >
> > > > > I looked at the series, but it does not seem to be addressing the
> > > > > problem with USB host not detecting new devices when VBUS is not
> > > > > directly connected, e.g. in the Colibri imx6ull SoM.
> > > > >
> > > > > Xu, do you confirm the series at the link is _not_ solving the pr=
oblem
> > > > > being discussed here?
> > > >
> > > > Have you tried this patchset? The upstream driver couldn't get corr=
ect
> > > > USB role from HW_USBPHY_CTRL register when the ID pin is float. Thi=
s is
> > > > what this patchset is trying to fix. With this patch, condition
> > > > "(!vbus_is_on && !mxs_phy_is_otg_host(mxs_phy)" will always be fals=
e when
> > > > controller acts as host role, then __mxs_phy_disconnect_line(phy, t=
rue)
> > > > will never be called. So I think it doesn't matter whether VBUS is =
connected
> > > > or not when act as host mode. If you still have issue after apply t=
his patchset,
> > > > please let me know.
> > >
> > > I tested this patchset on top of v6.5-rc2 and I confirm USB detection
> > > is still broken on the Colibri iMX6ULL. With or without the patches
> > > the behavior is the same: USB devices are detected only during boot,
> > > and anything connected after boot are never detected.
> >
> > Thanks for your feedback. As you said this issue will disappear with be=
low change, right?
> >
> >       diff --git a/drivers/usb/phy/phy-mxs-usb.c b/drivers/usb/phy/phy-=
mxs-usb.c
> >       index e1a2b2ea098b..ec5ee790455e 100644
> >       --- a/drivers/usb/phy/phy-mxs-usb.c
> >       +++ b/drivers/usb/phy/phy-mxs-usb.c
> >       @@ -178,7 +178,6 @@ static const struct mxs_phy_data imx6sx_phy_d=
ata =3D {
> >        };
> >
> >        static const struct mxs_phy_data imx6ul_phy_data =3D {
> >       -       .flags =3D MXS_PHY_DISCONNECT_LINE_WITHOUT_VBUS,
> >        };
> >
> >        static const struct mxs_phy_data imx7ulp_phy_data =3D {
>=20
> Exactly.
>=20
> > So I guess something in __mxs_phy_disconnect_line(mxs_phy, true) is cau=
sing this behavior.
> > Could you please help to find which line to comment to make this issue =
disappear?

To correct what I said:  __mxs_phy_disconnect_line(mxs_phy, false) should
be called.

I think the enable wakeup sequence should be follow for host-only port:
mxs_phy_set_wakeup(mxs_phy, true)
    mxs_phy_disconnect_line(mxs_phy, true);
        __mxs_phy_disconnect_line(mxs_phy, false);

And disable wakeup sequence:
mxs_phy_set_wakeup(mxs_phy, false)
    mxs_phy_disconnect_line(mxs_phy, false);
        __mxs_phy_disconnect_line(mxs_phy, false);

So "bool variable disconnect is false" all the time.

>=20
> I did some tests and detection works by doing _any_ of the following
> two changes (or both of them).
>=20
> Change 1:
>=20
> --- a/drivers/usb/phy/phy-mxs-usb.c
> +++ b/drivers/usb/phy/phy-mxs-usb.c
> @@ -359,10 +359,6 @@ static void __mxs_phy_disconnect_line(struct mxs_phy=
 *mxs_phy, bool disconnect)
>         void __iomem *base =3D mxs_phy->phy.io_priv;
>         u32 reg;
>=20
> -       if (disconnect)
> -               writel_relaxed(BM_USBPHY_DEBUG_CLKGATE,
> -                       base + HW_USBPHY_DEBUG_CLR);
> -

Since disconnect =3D false, this code didn't get executed all the time.
Remove this will have no impact. But your test results didn't align
to this. Could you please help check the sequence? Is disconnect
true or false when __mxs_phy_disconnect_line is called?

Thanks,
Xu Yang

>         if (mxs_phy->port_id =3D=3D 0) {
>                 reg =3D disconnect ? ANADIG_USB1_LOOPBACK_SET
>                         : ANADIG_USB1_LOOPBACK_CLR;
>=20
> Change 2:
>=20
> --- a/drivers/usb/phy/phy-mxs-usb.c
> +++ b/drivers/usb/phy/phy-mxs-usb.c
> @@ -372,9 +372,6 @@ static void __mxs_phy_disconnect_line(struct mxs_phy =
*mxs_phy, bool disconnect)
>         } else if (mxs_phy->port_id =3D=3D 1) {
>                 reg =3D disconnect ? ANADIG_USB2_LOOPBACK_SET
>                         : ANADIG_USB2_LOOPBACK_CLR;
> -               regmap_write(mxs_phy->regmap_anatop, reg,
> -                       BM_ANADIG_USB2_LOOPBACK_UTMI_DIG_TST1 |
> -                       BM_ANADIG_USB2_LOOPBACK_TSTI_TX_EN);
>         }
>=20
>         if (!disconnect)
>=20
> I hope this clarifies something to you.
>=20
> Luca
>=20

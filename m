Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5238C7718A8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 04:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjHGC6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 22:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjHGC6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 22:58:39 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2062e.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe16::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4874D1BD4
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 19:58:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LPgspxCYUnPMxnOVLNlzWU7aawQ7TkgHn4Hj0nd7VEdKPMlICNgFYnoP31HqnkULxc6AHCfqC7BBsxldJ/f30MTFmNXR+usPspMklyjdoLKJIc6l7TY4Jqi6Jgy4wNSJblCTVCluP3+I9cNIaqT/cTxB1YQB7+Ci0PR2CsZ5O14smH5dDiNxC242dJ8Fs69qObBfOW93I4aPkcEee3ZYmhJwDnokKjKthgOSUHcwUV2Q9rahECb5NJhgt3XzGJiVLqdDXvN6psTIYoLSTamNBEqTFdqNz9lbaPT7dn46ZY8nkDwMmogryiqTehCcYzBu+S7QpNrx9yHHhWy7Zlgexw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pSnhIXHZqLzaZemwCYnQ6kgfCieZkYl3WQVdgcsW0kc=;
 b=ALMUzm5bzz4lc93o3Qswc9tUXGycV27cRRwCM7MVxaMx6Op/oA4SUU1VK+dfB9A/oRy8QcEto8Kg0ZSg1mHLvJt8SqQVRQh/o2ZkworK4LsTToL6ImOuVCOG0y68AKI9vRae1XfZ61hOGFgGE3KzuNshqss0NgO9mg6YGOm8kK4vOi4GGkoE1esr7RQYcDHFhtkkyBaNR3xo0JRjjtpIuKMVUZ16/NgMHTQV3zG1W+s3gMux+7nH8jfBHn+AyxWCHZGmB6vEWHe6XdZX93rTalUxU20/K6+ORlubaoBydIsH5BOp7H6zUlpPaUk904OywsMzhpQpbFvuGfmy0UKJrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pSnhIXHZqLzaZemwCYnQ6kgfCieZkYl3WQVdgcsW0kc=;
 b=l4r/Q3l5VaaARD/6HZ7ILqRYWhhKh8tXFxg1DD5LhE/5x4TOeGaDmTiAaz5d9qFNKyZhKLQ2Oe5fpAqQehOuBr+M1u9GPAbpNmOwNFxM0LU7mTNQw3IjaltbMUFJgwGV1fmcVpILEKsJB23vv3bkyUqEheKL0KeWRAWP3xvvJhk=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS4PR04MB9508.eurprd04.prod.outlook.com (2603:10a6:20b:4cb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.25; Mon, 7 Aug
 2023 02:57:18 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97%6]) with mapi id 15.20.6652.025; Mon, 7 Aug 2023
 02:57:17 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V5 5/9] firmware: imx: scu: use EOPNOTSUPP
Thread-Topic: [PATCH V5 5/9] firmware: imx: scu: use EOPNOTSUPP
Thread-Index: AQHZw41v9JxAHPEEOku28K+vqFT2QK/eLcgAgAAAl5A=
Date:   Mon, 7 Aug 2023 02:57:17 +0000
Message-ID: <DU0PR04MB9417C47BDAC2BDF8D00B7DFE880CA@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230731090449.2845997-1-peng.fan@oss.nxp.com>
 <20230731090449.2845997-6-peng.fan@oss.nxp.com>
 <20230807025412.GN151430@dragon>
In-Reply-To: <20230807025412.GN151430@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AS4PR04MB9508:EE_
x-ms-office365-filtering-correlation-id: 4d8fdac7-cc3a-4ae2-e0b3-08db96f202d0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oNIrruT1XnZIQFSAWQ2WpfhJhRq5KeAxkUYTHMQSC4YQVCSKHaP1lCaeY2p3x8hh2xJTy6PxEhCwJyMd8SuRMAvRNgBQDLQhlfUHzWCPYgMr4PDo5j6uqX2wJ/JVaeCUheXw7zbrnXSTWm/qewuHrg0XSBWqc2XDBZwuIzIdBehR3J+S9BG6Uok8Lkw6Sm/rifkV3V5Vb1elYlLDRSozUp0cWcOrvfbMVf8NmxZVi8BHFu2n8HTLVqVggsEbLvw4pW2Dwtw6I2qT5w1IWtc04/5l2zuOJ1EI6uiaM7QVN2SUKdjaMuIRc5MoCB5cdMP//YLmlPuPGAiJkSj0xoEvV4/87+/OwyBBGZ+AKQfCpkL9P11fhP/ntnBrPqK1OUQpFDaq6wCpOhqkBzcncbkoXF4q7Sbs2dAuLUnRTzxLtkOSVhX3M4yPLeJNlWggGHkckHrHK9BaU3GgWatag7VJ70kUQEDL5BZbSYs2WUA92IsC7feMVohSnTsgCw7sZsTg15bht9vu6gGiaehZJGMPMDjx0YgahFBGRtOwY8voT1nrOEuerMozTEEVEnncc2s/jaSsLO8FMxHcCqtRgGQYv7C4aHF+3s7V957SVbO5IxTN0stvxgeq5hYleBbws3sL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(396003)(136003)(39860400002)(1800799003)(186006)(451199021)(52536014)(38070700005)(41300700001)(26005)(2906002)(5660300002)(44832011)(83380400001)(8676002)(8936002)(55016003)(122000001)(478600001)(86362001)(316002)(33656002)(6506007)(7696005)(76116006)(54906003)(110136005)(38100700002)(66476007)(66556008)(64756008)(66446008)(71200400001)(66946007)(9686003)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?56vTm901tDRdALp8zcln4ZO3gF6W6BdolF5aPBnzyZ/nV+ptLFoWfb61h9fJ?=
 =?us-ascii?Q?er8RZzWaAC7dBpkQQCvx5+T466RfX/9TvSgsJfSjisVTUAXFWCClSlmhg0Tm?=
 =?us-ascii?Q?QXtfjBZs7ZpowE/S8AyVQAydO0w8CyjF/JicN3fK1ke1bHVQ3btwXZDAYxCy?=
 =?us-ascii?Q?iBmyDykrfTL2A7/Xnry28/6RSz0c65HGS06ilZEI0WtZ8HJspzLRiAjew2OV?=
 =?us-ascii?Q?5CuM4y1l1hrOE+teh4QJNywkl0f5sA7Y9//OA5rImWH309YdGbZFjFGfe0kX?=
 =?us-ascii?Q?5YcLuVpqvTeQos136ifLQF2d72Uylo4MD11NPHl6wbnbwzL0AdV75d6Xp9Te?=
 =?us-ascii?Q?ez8dC87bXPy6EYLWmEaRGZkVakphZuZ2xz6KP+8QeVRB1/Mesjl28fyMw46x?=
 =?us-ascii?Q?HLlUuST1DLq3zmFjgEPJbUagdf7A+DDV7njcljfXLTYV2JbJ8glPMUAiWFRu?=
 =?us-ascii?Q?LoZFybeQpsONAXeyZBA+jGFDiDL/jIJNaBaDCoAge7uUlbmUWVVe7QPYGdI+?=
 =?us-ascii?Q?cdzeHV4YKSfkLrSTUvi2n483kkKWmqxa+TsfZn+NRsuYfJ3BLQ2pboubGgA+?=
 =?us-ascii?Q?jv/s3ENJw7vDrQytCRQcUEbXxnVtiOsmUAb89spXEa5xBWIXEzrTWySFhKlq?=
 =?us-ascii?Q?3G8qPQLisMGN8KPsZp+09vYt6SnlLWv7h9q12wyCxGqkteVbtpyJUBowku03?=
 =?us-ascii?Q?VGU+Z6SwX5EPPE409GwTS0GgC8njCd4JqYM9zpufHM0JWAbhAD2fIDpCRByR?=
 =?us-ascii?Q?kqvw+ReVRkUNDT8V2P7xQIbDmJaaqdKsrP994ko2oPaV+YzPHEEn/3MiZpmE?=
 =?us-ascii?Q?J9pvob5KPfOW2zhjL4v7vSaiAf7dyyjj6LBmm+lTnboQqDy3KqXKXtwj/y0o?=
 =?us-ascii?Q?fpz459txfXUNnx2J+Doeb2b1zroSsCvHpsf029Founx41kBQ0SCyuOT6nwSA?=
 =?us-ascii?Q?PJO0hLoc5sa8IdbIqWZcv/cmCtnGxcGQ1NbgwKKCH6IzYL4VgnCxHnAwTjf2?=
 =?us-ascii?Q?0ivpp9r/Z8+KnR/nn7tDCBtRTgqiBeC8RiC1WeLRccivgkAmwTOEoqJ1iMWB?=
 =?us-ascii?Q?Bj+y8yCDuIUwNRw5Qrc5IormiJM7t/emaO1Um8+LNO6kqLqITQDDM4MzcWHC?=
 =?us-ascii?Q?woHAH2uqldZ+mQyodG9DrQ27Ukj3s+HUhAcXMU3cUyjDIfAPZvWEfu7/uWjz?=
 =?us-ascii?Q?DDMdhGMPVxmzT6OPkjQaTjp6k0lOX9v/4BQqpGmOI0CVqWc/KTIUSvEHtq6P?=
 =?us-ascii?Q?UJ3SzQ0iq4SZgeTcaxoWJ7tCD2RxE6oGuUxA1FDbvILXjcq/GaHfDYyOKWC0?=
 =?us-ascii?Q?rinTvM0/3wI87+fKeZX7ZJPbDs6rY/2lSuOP3v36M40NC2GAQvEScOdC9i+/?=
 =?us-ascii?Q?5IcfS2BFJih9i2uCZka10KDKg2/qkz3L820x+41qNzpfCvCUnQzWsqVYFKec?=
 =?us-ascii?Q?VS2kpGbSDsLr/U0izfhObriVwKLrLIVNHkhbvpr0twUzjE/ZL2PpDXFhtD/5?=
 =?us-ascii?Q?5fT38ACxfMfEA8LKEpJk4bJJvpsQCRP3+Rp9uAvtEBLcWM46gg105SZpEK+s?=
 =?us-ascii?Q?gSOTgP+2ywnfBtiMnoY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d8fdac7-cc3a-4ae2-e0b3-08db96f202d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2023 02:57:17.6195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pFn7I5BY6LscgLXIshOwTRLnP2jSTYBOYASzcFztJy5/cl5FjzutTJ/TRrUusek9S2tGJlszTbfgvEh7bRnyFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9508
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,T_SPF_PERMERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,

> Subject: Re: [PATCH V5 5/9] firmware: imx: scu: use EOPNOTSUPP
>=20
> On Mon, Jul 31, 2023 at 05:04:45PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > EOPNOTSUPP is preferred than ENOTSUPP.
>=20
> Could you elaborate why?

From checkpatch.pl:
"ENOTSUPP is not a SUSV4 error code, prefer EOPNOTSUPP"
I could add this in commit message if you prefer.

Thanks,
Peng.

>=20
> Shawn
>=20
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  include/linux/firmware/imx/sci.h | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/linux/firmware/imx/sci.h
> > b/include/linux/firmware/imx/sci.h
> > index 5cc63fe7e84d..7fa0f3b329b5 100644
> > --- a/include/linux/firmware/imx/sci.h
> > +++ b/include/linux/firmware/imx/sci.h
> > @@ -25,27 +25,27 @@ int imx_scu_soc_init(struct device *dev);  #else
> > static inline int imx_scu_soc_init(struct device *dev)  {
> > -	return -ENOTSUPP;
> > +	return -EOPNOTSUPP;
> >  }
> >
> >  static inline int imx_scu_enable_general_irq_channel(struct device
> > *dev)  {
> > -	return -ENOTSUPP;
> > +	return -EOPNOTSUPP;
> >  }
> >
> >  static inline int imx_scu_irq_register_notifier(struct notifier_block
> > *nb)  {
> > -	return -ENOTSUPP;
> > +	return -EOPNOTSUPP;
> >  }
> >
> >  static inline int imx_scu_irq_unregister_notifier(struct
> > notifier_block *nb)  {
> > -	return -ENOTSUPP;
> > +	return -EOPNOTSUPP;
> >  }
> >
> >  static inline int imx_scu_irq_group_enable(u8 group, u32 mask, u8
> > enable)  {
> > -	return -ENOTSUPP;
> > +	return -EOPNOTSUPP;
> >  }
> >  #endif
> >  #endif /* _SC_SCI_H */
> > --
> > 2.37.1
> >

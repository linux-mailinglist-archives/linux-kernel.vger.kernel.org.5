Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE997BF90A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 12:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjJJKwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 06:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjJJKwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 06:52:49 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2056.outbound.protection.outlook.com [40.107.6.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61EAEA9;
        Tue, 10 Oct 2023 03:52:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S4SOBsVUVQ2cBuuSU3i2OcCHYsiVXkzOduqUQiHd+KywSlYYB1zA9/LFeerHGWgp2yK7g4TDZgc/wuJQiuPFF5Zil4ZrJ7QAi3rYQHf+AACnjcGdLrSTIQ7D3KLtKBiMrMUm09b9MOe85BMaGjnzqGRXvRuxQlQ8IoyDNQRlmKHRwqw6pOiQaCVCignkJ4G6jCMgXwKlfQiBCsllrbE82FeCDV8tpWzTHwwzrRe7rAhxWnQJeZk0W+8TCpvt2HtZ9SmrA7ExSMvF3/f0uSuLDby6ILWcgoRPJ039NTxzkOZ5qU6/jpFmYPDTEno2YO/dOOU+9TnqAiVPD0m+n1t3Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G5bO9xYcXomt8IMtUN1EVC3PtvNNSs4+GO9dh0EeDnU=;
 b=lhZR0bEhowr9X7I2u7SD78cVHYLTi0S/XiKRQjlixmts43iKWvKgdGOlZKq7kHPhygqNXF7m/ZDOj6CcBBEKR6YqZzotQSRYQOUyXf3EMRzBKgjlqzpOI3efqIa+m4Bo6F5xu/JCOtCynM3wYPAarXA7f+jNJI5U0lYD+CG2oS849c40V/pjs7P65OgzZXibH43TSzmV73OB34VbP5c0QlwH+xtgaqrFIKHprUVuQi9UGgiyNCxC2xeFpZhqW2tEfw3fOQLMKXI3OEck84nujqEPo/AbQK5462GTUKklEJNpBgcdrAoU4tajHucGYzGb+oniPtU+pmI7LsEAtqFb7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5bO9xYcXomt8IMtUN1EVC3PtvNNSs4+GO9dh0EeDnU=;
 b=LK7+XR71dWkSwfqwAc+RYF5AALdcasI9GtaMwmS0aixBcIqSxZp/PzmQamkn6XcXPLjU5gE1znlFX3KIuohzOQkT73Q4lqB+U34uExcLvb1sFMYH60mQyv2CpUfjZtJY97M364TkeQ1P0oGn93rkRjDnNP6YK/Cejbvgpcfl26s=
Received: from DB7PR04MB5146.eurprd04.prod.outlook.com (2603:10a6:10:23::16)
 by AM7PR04MB7013.eurprd04.prod.outlook.com (2603:10a6:20b:116::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Tue, 10 Oct
 2023 10:52:44 +0000
Received: from DB7PR04MB5146.eurprd04.prod.outlook.com
 ([fe80::f4f8:a4d6:fe5a:3e1]) by DB7PR04MB5146.eurprd04.prod.outlook.com
 ([fe80::f4f8:a4d6:fe5a:3e1%3]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 10:52:44 +0000
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
Thread-Index: AQHZkukSER6EMlEOvUGUKvCWQIHv2K+swg6AgBG0WYCAAQQm4IAARWMAgAF+cOCAAF2AgIAA4BAQgABvbACAANwWkIABRyIAgAWwp3CAZ883AIARGsdw
Date:   Tue, 10 Oct 2023 10:52:43 +0000
Message-ID: <DB7PR04MB51460E22D3F57F1D613861A38CCDA@DB7PR04MB5146.eurprd04.prod.outlook.com>
References: <20230504162312.1506763-1-luca.ceresoli@bootlin.com>
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
        <DB7PR04MB4505F28957A32F09BB84B27A8C3FA@DB7PR04MB4505.eurprd04.prod.outlook.com>
        <20230721232750.0aea6e0f@booty>
        <DB7PR04MB450517AD9F25F47320835A5B8C03A@DB7PR04MB4505.eurprd04.prod.outlook.com>
 <20230929153748.63620770@booty>
In-Reply-To: <20230929153748.63620770@booty>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR04MB5146:EE_|AM7PR04MB7013:EE_
x-ms-office365-filtering-correlation-id: 547f04e3-3aad-4adf-aa02-08dbc97f07c0
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8AOijuB9YM3rFnTERkL6c7IlYeOyNs1vp7li6I1PaSMdDJdmZJRG7CPgBNbyIoSNl2yXSOs9EKIfKBs9Nay9tXUJ02MNfpJE6+fG8ceVjGfEELGBDHMVgLABu19/jpXq/HPAkEUxHpiV5Jv09MsA3W4CB9lKDObS+skrEVs36BJLD5W3jtBRasib8ZtAtvnE9nZikJWF8NsKCI2SIjA9jXzvf1gxlbRQ6l4G/4HddCX8BzF7v22DSrpaLHO1zZSCQemWgXGl+92U2nM0GYpX6c3MLdzeMPSyiaj9/wpLiT88qeSt/RCFAG3HQ5QaoKHBcHVoQTfNkOkLAcQLH0aQbAJn5XgXgmXuff71Zp67lr79n8HG9p43iiMh7IaziUjwo5bt62ACsFWUfHEalamFHzkLg44RSjhLPQO/nzugXBHgdjylJZFOSLjB9sk4qfbuVe8dPxQzXOP9O43QIFw11Vc1nXzahGk6ogeo9eP9491kyl1YaGH3jNVmM5zIsuYNJwsZUpC/JlYguaUDT+tA6PUv8/HhA8/sxtQgjhpWeAFdlxDgLdAJ6QhcWe1nNhYR7fgW3N2pbNJvLvluBtDdI18iUVKT9i8HC1YWQdegWhJfBEfTqDvv3r+F9r/8ObfK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB5146.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(396003)(376002)(39860400002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(9686003)(7696005)(6506007)(55016003)(122000001)(38070700005)(86362001)(71200400001)(33656002)(38100700002)(83380400001)(2906002)(4744005)(7416002)(316002)(41300700001)(478600001)(66476007)(8676002)(66946007)(8936002)(26005)(4326008)(5660300002)(66446008)(76116006)(6916009)(54906003)(66556008)(64756008)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yVyqni6BhabYLokQk9EBnCfJkou0T9f6waiWX5VzWLy2mq7RdeD2JMy/nMhq?=
 =?us-ascii?Q?ZHvZlSYHIIqpaqg3vOcVLe/cl5iCk2UnVx8ALtswTQEyVklENQRDGqvEbGSz?=
 =?us-ascii?Q?abl2W3P+8Iouo8ZIP/eoNTa38lh9ySBdA0UtXYeBE0UlsO9FXAoqstriAJk6?=
 =?us-ascii?Q?DcPVnsNUUd6oLmi3qRPsJYOSwySWw4BXm4X0mrx6FaO2lkX9i+cfLeiu2XD7?=
 =?us-ascii?Q?yGl3a/6FOzFswqmB0lEiIMBx8lBgo2PfkAKQnZnBSVympUKpmT2OdpssTEKl?=
 =?us-ascii?Q?aIyoARoDcaSf1biLHSlBunlB0OzFB2EKXZsHrazJGzIkeb17JSYjEtzfScqH?=
 =?us-ascii?Q?azso3otmoqdfxWrADdxcGYpgShXKcz7t9gDP8FCLaecuuk/zooHFXB/u6xnc?=
 =?us-ascii?Q?sYB/htNlU2S/+mh36qiTCkfM1jiGoOmdLobE8+9WEEYbvT0MlWxSGamB9DfH?=
 =?us-ascii?Q?mpLUrnB0pEXD76QchSauXHCv7rvnAITRXgiRRU2rodTkD0LNexZINOpvx8mw?=
 =?us-ascii?Q?bDArXza5wfoboRQMhvV16tma3hAOtnc8esNkHGJSXnBaXj/5foIb3lhErArN?=
 =?us-ascii?Q?ZWU9Zpzg5K9EKebz7ipSQNwXRA8moigeV+2JwdXykGHCB6qayMy+4Nxdk59U?=
 =?us-ascii?Q?xE777QOrLcOOBeBbxLQSnWw261H1cHNTR1nBUKMCVELiDFKGE/KFq7W4gosu?=
 =?us-ascii?Q?W4rSYRFYHegq9oIebuH1VHVgnhZ6H4VebsEeh9vWKlF3sw4PUOYx7G6kbByw?=
 =?us-ascii?Q?VZkEEIHM22/W5BLsD7fjE/Mfsw46dRMlP7WO4Hahb2NcFIaiJ6SzwIIno0Uz?=
 =?us-ascii?Q?k8ePaRt8fPKPgLP3JsFDFadDYf87wbolPJ1EcGNJhquzBX5LmhgGUZ0eubpA?=
 =?us-ascii?Q?LnHA3dN66BxcwNsorovsMnQiDfQIExgqNQO7nBvCOaBTnlKGk3P6lpwALAVd?=
 =?us-ascii?Q?Ba5cllVp37Z7Ju1Iu6F6SWl2MrNqR76bqpBVYDd73zlRHKuiV5In8bC5rEFx?=
 =?us-ascii?Q?V5XMJlVXA0kydFzgaHeO18XDtSgZm3DaCoY9OcmpQEHtwTpv6SNwk187S/e7?=
 =?us-ascii?Q?nflldwruTxXU3MWuerC6H1sk0sRMP56uhSkR3s0l1vT43bX3RGm9pcxIVqA0?=
 =?us-ascii?Q?EcdOg2uGgV8jn4AC7xbkLUHYPyt0D8VwhqShUQnSD6GRCIcwBQ/XBWrGB6I9?=
 =?us-ascii?Q?G9hnofHOmLVrwh8uTPTTEkCxnxof1xVGnUTYRbTlPAJHnwPUS9VaQCwOF6Vh?=
 =?us-ascii?Q?v9Yrzt0m4OKb66wpb4OUU4vxVDQ9gOD8EUS+5jDuHza8YvMibBNNF3WZ+zWm?=
 =?us-ascii?Q?wlFwWo0MQAu/G+a9rmXr56fuoF8SoeN/3QyEehs+Nvw5zFaPlAGfquG8aA4g?=
 =?us-ascii?Q?yhxMicODJ8SLXSMubPkt8ZCXi+x4w8Ayc3C5qOCiqKmvBrcx9tfLdY83Qmzw?=
 =?us-ascii?Q?TjzczmcT4R4a2/yBmY5hXsoYjP8uxd848GBsJvsWL6DH+2TsOSKFvnQ+/cU3?=
 =?us-ascii?Q?+3EmNVca+sPVr8C8vDrmV42/bd+NOGmM2OuhSlmOmZ0ODJZjq0Rgx4v7wBJQ?=
 =?us-ascii?Q?Q4sQoQXcxuuzOmdIpd0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB5146.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 547f04e3-3aad-4adf-aa02-08dbc97f07c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2023 10:52:43.0586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ji9l8d1090l+473ZSyOMf9kuc0b/Drnqip58wzyt0/9cjRaBfEe0ms5k4QOaBIJ4UIJArswpjhQmKrf+r5UbRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7013
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luca,

> Hello Xu,
>=20
> On Tue, 25 Jul 2023 12:23:43 +0000
> Xu Yang <xu.yang_2@nxp.com> wrote:
> ...
> > > I tested again now with the 3 patches applied and found that with
> > > CONFIG_USB_OTG=3Dy it works, and detects a device when plugged. Good!
> > >
> > > However with CONFIG_USB_OTG disabled it is still not working. In this
> > > case obviously mxs_phy_is_otg_host() returns always false, even thoug=
h
> > > las_event is 2 (USB_EVENT_ID). This is what I get during boot with no
> > > device connected:
> >
> > Yes, I may need to remove CONFIG_USB_OTG condifion. Will handle this la=
ter.
>=20
> Did you manage to make progress with this work? It looked like very
> close to be fixed in the proper way with your latest patch iteration.

I'm a little busy these days. I may handle this when I'm free or you can al=
so
fix it.

Thanks,
Xu Yang

>=20
> I'd definitely happy to test new patches as soon as you have any.
>=20
> Best regards,
> Luca
>=20

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD7407572F0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 06:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjGREuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 00:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGREux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 00:50:53 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2059.outbound.protection.outlook.com [40.107.20.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4464BB;
        Mon, 17 Jul 2023 21:50:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jvr7vur5Bgaxl1Xy4LliDGIubcMdI9q6TuwPTRxZtvQ1/aKCRP9OhvHMhu4H2mNWb1+6TIi7wc4Jc2OfgqYFgw3pYR4zte/axc42/YA8YmLCQcIagLZtpQCrq8qxcMPLLaIWQENJqC6a/wN5IzHukKNQtxJIcvvmnVcUWPoCSfpVUYgazR/Ao32fXKfB3HEb+nnD0Z/UVRXEH2B5K7UrXRI7sG96AUy8/HIxH7pUQfITpht+gl2O0nqfRKoZJN4Q3/mMZskR10nuOfkwrF/+GH0jLAYNnY8uo1WoA1sWdKAhKwgeiKx+/zFTEPxdNs3u/Y3fHgnYe3fEi4XxrUSxiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+l7jc+/06LVOpNYwEaB4aryrFQmV1csiTpk2BwdeSbs=;
 b=coGd3y2wZMTeCKcJByWjYEQmoMLoK0yJZPuPTtP50F3yRik6tlf0HWZ4jjDtSVeKE8YKlp6iLKcbsseFquQEW5XLL96rmCdTIGT8X3gEXubQqqP7Bcq6DiyscEWtXa91ij6vhKQMkYUcozSJN7dP0NmIayG1Gu8LZmYBgqdDQfn41iPLkUTr0k9f8b9fz9HItxaubAwW7v4WXoO28slxbugS1u4D3mQ6b9CygM7jQmPN36JBEsZ2UhBOKXD9lmwwvshknVf4FYtEUN3yVXmwmaK3B8u1m5n0ghZbAmLM5N0R0qiTHy0asvGCWJ+PszCRpsMTf7AhkJDMHAvvKAXbEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+l7jc+/06LVOpNYwEaB4aryrFQmV1csiTpk2BwdeSbs=;
 b=lhztz3eZaxenUZBe0BsjT5SY3lWcTcVC+lrHn5DwJafJwceRyKnexIH6cPC8Urs6ReJz2+crke4e+26JD1weZXLGfjQYK74IaWBcXZ7hWt+3E+ZhTXoIJDETXfKvWvCeGoIlU/St0Jpz3JF5Lx73/WjdHlm6xhw+aosV7L/RUhU=
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by VI1PR04MB6957.eurprd04.prod.outlook.com (2603:10a6:803:135::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 18 Jul
 2023 04:50:48 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::413f:a9d5:4c09:9dad]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::413f:a9d5:4c09:9dad%3]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 04:50:48 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Varun Sethi <V.Sethi@nxp.com>
Subject: RE: [EXT] Re: [PATCH v2] arm64: dts: imx8ulp-evk: add caam jr
Thread-Topic: [EXT] Re: [PATCH v2] arm64: dts: imx8ulp-evk: add caam jr
Thread-Index: AQHZp+k2v8Jbz02GhkGV+zbcgHYc46++6W0AgAAtcYA=
Date:   Tue, 18 Jul 2023 04:50:48 +0000
Message-ID: <DU2PR04MB8630136DB99EEF4532E30CB59538A@DU2PR04MB8630.eurprd04.prod.outlook.com>
References: <20230616174050.644880-1-pankaj.gupta@nxp.com>
 <DU2PR04MB86300C782DC7637C469599EC9526A@DU2PR04MB8630.eurprd04.prod.outlook.com>
 <20230718020738.GX9559@dragon>
In-Reply-To: <20230718020738.GX9559@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8630:EE_|VI1PR04MB6957:EE_
x-ms-office365-filtering-correlation-id: 3f9f6edf-62f6-499b-6585-08db874a8e38
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YjTB0NFDt8uyyYu1Iyd8NJDEqgFzQjRp/9cR8Ytlv/wYtNCSUR9DBtw5LJcNmu8dUKAkyX+aYMJzEossndymZRje/8pCfjIfsVew5rBwPPpOroA1KMWQ9xGdNIzsuq+BU3qzeARG6qXX9obL4TAYmIwVrVKcve4ZTHKKfZPjNlz/63Dq3fR+cbbfj37eYNv35/ezAHGYQElVQGnyL2Tel3rKEaCMZnwMc9cMmN9A6aTpreUhLaZBpU+lXsQwmPQeITkMoLwueeTncN7LEJbArKY+MaAr0y2H6AjBUYdydV60ACQAXi0AmFqVE3fwQReKwWJv0QQkKccq63uaeTvW/R0O29bRC9pcmLh1xYY+9ge7H1bCpPdQck+2l8qTgOJx3X7G2Ma/rH4Y4dhVBdY62s7HO21WGU62dCg2czkTVJASkRMVHqOmPTUG4KNN2bmDStxCr5ORCNLYBBMWO+GhIgeCaLFr3i8C0KZMD/T88oe156YnIK7Q836gc1btG8Zp1HbvVwDZzWpMqPsCo+Ie5PVwG7dsfM2pNfFeryzh+C9dZHfhcbhMVFQ0wzpCE1iQbH5nnD1uCtLYau1GWu+VojGXwJih+1pQeuf05zaMpPfxGYT0+NauWx3BI3LtQJ+Suta5KHr7dGcPCmNhumqi3A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(396003)(136003)(39860400002)(346002)(451199021)(86362001)(8936002)(316002)(66556008)(5660300002)(7416002)(52536014)(4326008)(8676002)(76116006)(44832011)(66946007)(41300700001)(2906002)(478600001)(71200400001)(7696005)(26005)(54906003)(6506007)(53546011)(9686003)(66446008)(186003)(6916009)(83380400001)(66476007)(64756008)(55016003)(122000001)(38100700002)(38070700005)(33656002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rT++Z0gBFXyUivqbolkDqEhwmHsgd9Ht7QhZFWiMMMgErKdm8a+/gDLoH3yO?=
 =?us-ascii?Q?J7U/DPyAAVT4+XY9h0WE4485ByVJ829W+j/O18+IVsKYbTpWLs41KHe2bkat?=
 =?us-ascii?Q?GzHbVPgbLIwhm6dGMa9WogoPogXp/sMLOeo0EWUmCHEwXQY99tE7l0kirs+G?=
 =?us-ascii?Q?nNzMNYBJatOKFxOrgim52AJujoaQW9xqI/R98lYSM9IYwGhqhjpIbOQKongW?=
 =?us-ascii?Q?yl8YJ8z+uB2F4GEFbKxd7c7QGNvfxdPwb8rarSrpNVJOuN8FS7hlAgTzKwQa?=
 =?us-ascii?Q?Iz3vNEfz+iFGvld3cdPYdrtwwY6bZo5NouSSQZZybCp6YWr1rH+PCZfZWCma?=
 =?us-ascii?Q?PnTlIN3M3C5dZ014Dlr013qixCbA+x7kfHRzUhbzvyrkqX6Z/z2rYFdzBltH?=
 =?us-ascii?Q?DgHKJBV7ZCR7nKPheOD+jxwAuNyRv6hn0TkKAp5vqPKSbO6qbbfhf0YO/qo2?=
 =?us-ascii?Q?n2/BotZ4KhxahabV1DSeLFV6+nTxeSUFRcCtFj3vzcoT2rmXidrN1N+VKOit?=
 =?us-ascii?Q?nBkUok074/mWiLc3fVgREJ5QrVgCMKYoahzvf42me5dETFcSxJwLL5AKoyAP?=
 =?us-ascii?Q?N0FkVeDV99unQKNcGVyHBFjlpGKgvbLgrySDLn2uDCVs0a8IP3eIK6iXvvVs?=
 =?us-ascii?Q?PFTs5rGYsLtHOkU2U0V1JCqzTliWvHBQGZeVQ2LIq6qGRskxSKjJK5pqazT3?=
 =?us-ascii?Q?8TldQzWZP/wiC0Q5l8re5RoZG1bGxN8xwXAQS3xuXvbLYX7e8jNtIwAMCari?=
 =?us-ascii?Q?QEtLtQN/Ls/qiOjdXBSkA66tJCJF8lZAbCtHcseum0f/s077iiawBVLptzV4?=
 =?us-ascii?Q?U3RnzK4ADKQRmUGR40DYcWVWrWCKbQda5hb1nCQ5V3Q6vsaBbPQVSXWwQrNj?=
 =?us-ascii?Q?TkdmAH6Whq1Xf8ixMzNCjpxyIfLSJITi/LaehYXWTZkHwJW2XWo4cAdQWX5i?=
 =?us-ascii?Q?einlhVjYTbvxPjHzuo8+nxLflyIAUnmLpDtGxwGKRAybefBiOVrCC2ZlKVRP?=
 =?us-ascii?Q?nuARI841DdsphhjRfBxPCHdTorEi8oJNAIQEPYFVbTz9nhY3bJ6Nvq07q6QE?=
 =?us-ascii?Q?GwZhZpdhjgjjWEwJXsfRuDQf4p9k2NEXpago/iUoZf/xQVEkXpq9vfnlf5pp?=
 =?us-ascii?Q?yNVlzzzjVQd1yEmXf+JX2LafuweR8e/YPcDafcBuwrF2jpfEK2afc/zAoUgV?=
 =?us-ascii?Q?C89SE6lRFyVdQVDYONVMyAviOqPa3jZoVhUCBra0MpXoqdpdaqKVcZowiwS6?=
 =?us-ascii?Q?U3MzKEmiV4smgeS+eB1SeUcNFpi9B+LHyt6VoOvTEBLt6ZtzkO3D7CKirn03?=
 =?us-ascii?Q?76ASlAFAKhIk6NMSk95n+zbrEb/VdCzboPf+fzgBDUlS15R1CpgQNY/BgV8Z?=
 =?us-ascii?Q?1y2jLR2WTUQ3Vc9RnD6PyCdCv12FBdHuA9R9oy/IoOzGootprrUKoRod6qiT?=
 =?us-ascii?Q?juNgRLsxlhq40wrRxwhVDklpn4SKwMKwp2cfp1y1jVKlqFuRlXC1v/6vH37U?=
 =?us-ascii?Q?bUL3JTcpsjY4MBTxQdobrfMRXdo7FqCnT+A001+pPk5vZEit90zojD3XWCJ8?=
 =?us-ascii?Q?KNbEcNIOul/1y6VnQMXEn/N1rwh6GhbjEdlzEfzN?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f9f6edf-62f6-499b-6585-08db874a8e38
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2023 04:50:48.6133
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p1OCih1CwoUDQTeRAVfiZ8E/ciRRqj7HqsK+zhVUOptQ8JSA7AK5hzkH/nenuCvtZ4vc+2uO49mSVDhlLHEYgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6957
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
> From: Shawn Guo <shawnguo@kernel.org>
> Sent: Tuesday, July 18, 2023 7:38 AM
> To: Pankaj Gupta <pankaj.gupta@nxp.com>
> Cc: robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> conor+dt@kernel.org; s.hauer@pengutronix.de; kernel@pengutronix.de;
> festevam@gmail.com; dl-linux-imx <linux-imx@nxp.com>;
> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; Varun Sethi <V.Sethi@nxp.com>
> Subject: [EXT] Re: [PATCH v2] arm64: dts: imx8ulp-evk: add caam jr
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> On Mon, Jun 26, 2023 at 04:46:46AM +0000, Pankaj Gupta wrote:
> > V2: Changed the email subject line.
> > ------------------------------------------------
> >
> >
> > Add crypto node in device tree for:
> > - CAAM job-ring
> >
> > Signed-off-by: Varun Sethi <v.sethi@nxp.com>
> > Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 32
> > ++++++++++++++++++++++
> >  1 file changed, 32 insertions(+)
>=20
> The patch only changes imx8ulp SoC instead of imx8ulp-evk board, so the
> patch subject should be:
>=20
>   arm64: dts: imx8ulp: ...
> [Accepted]. Correct this in next version.

> Shawn

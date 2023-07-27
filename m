Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E04765604
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 16:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233712AbjG0Ocm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 10:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbjG0Ocl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 10:32:41 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2062c.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e1a::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E8B2D40;
        Thu, 27 Jul 2023 07:32:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XuUA1hbFVqpM3izdd7HT3T6Fu8jEONDs8uvihRIcIiFN6rg9iGaJn+lgs7NQUGmaLX1tFmXTAhsExxGAs493ERfiaB5xQ220z0QzKkwZbgwb6uW+A4h9QtSbavqHDoMa/sz0eWFT8fzORgSKg9rJSW44zay5SplGVkDczibixrvC1D8cMYKran35ZuHCyK3raf++O+2n3c9guIc3O1MRh4CopAxvN0MAJPl6XmgT/3PWFOx3a3tUt9YGM12fGTHVECAEZIRtREiyPdrjkfHTaL7ZxB2GE+cALECL55Xq/7AFTCjQa7guZZCf7kUJHdnd3zGPZ/r7LQipUU7UfTZ4Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F0nJ3Y/BS0SMKQgyZIvetQimZM8MNr+itQnX8lcCFPM=;
 b=oUXU8zRW+UAdkpNXr1OkSV6jB3rlpPSyA9wyKPTTh51EdZrF9gQdurFL393dm6g1BZv9zxPMSL1sfedfRljos0EIcW6RSHNdv4SA9h3ml0BCYKvKGt2wAtAU4xIh66ZaKe391B95ai1vKIbOzvE0uO0fwhneoJ/vDSc/H5Ysk7++77bBvLvIrXUhgPHvBA60LV4PILsYy8J/yxKMsA9d67cCPAshZvHr/5jDyz67S6HU1swPBYN8bJOpoaqJput1SFCWFhZWTIF9sX+YnJJb1mDkBYRn93IU+KrHzHqgJVbYSQkPnI5ZFzXl+z2OPXhYw6ZFz1r2qIEISgP6utCCng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F0nJ3Y/BS0SMKQgyZIvetQimZM8MNr+itQnX8lcCFPM=;
 b=J0SfD+a/sGTdiuml9imQmVyHVB/p/FJaPfBkTbaVstv5BEJRdBYEEdXhOm2iv4yxLaWCv6HsLuDn8rjbhVNP2VJfQF3OaLxNt8xERppjAOYZ6kMj72mTCrgo5lc/m8J7qVj7QuUfhqbZqfzqIk8Ogk1zdUeaywiaq6IGEHAFG3k=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8854.eurprd04.prod.outlook.com (2603:10a6:10:2e1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 14:32:35 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97%6]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 14:32:35 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2] genpd: Makefile: build imx
Thread-Topic: [PATCH V2] genpd: Makefile: build imx
Thread-Index: AQHZuuiOaUbY4emHfUG2Aqz8aNM4ua/NuIYQ
Date:   Thu, 27 Jul 2023 14:32:35 +0000
Message-ID: <DU0PR04MB9417AAACDDC890FDC3D199158801A@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230720090443.503525-1-peng.fan@oss.nxp.com>
In-Reply-To: <20230720090443.503525-1-peng.fan@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DU2PR04MB8854:EE_
x-ms-office365-filtering-correlation-id: 21194666-ab00-4a9c-4eac-08db8eae5208
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1nGHNoOyhOZy3kT1H2Xjbrg76/4UzuLFHOR0V+ILyUIvObQZ5g04DtiZlngEsiJQRaDqa4vI2jjO+s5Rw1G68tPChtNh7aqCiY/SxLxpIgaGWKgdjlHOcU9CeQuSNxlOFKN3QmAYPFjtXa9GF22v7iE3uHb4IYJo1e8wkQQWkl87G6CZaHmF07vTxVhbKJnCppRv3g6uY8ZHrpBBioEJV95gnD18DOjL30of7vVwElyijSo0G2dW04BSSbdKx63GF4L5gpy21UvwHKKDkuo1sKje5JRmpHgyXhx0rvMOQeVrZmhqtdB6Ij514wk/PQqpEJJw3lbyzfYsSg3sulU2q6OLHW2DBL0SHcP3Y57bXRQtL+/jBf0HI0mcrJzUz7GB3Zw84fxptpkLOsQj6ZVJ1fcCXqbPJJvpUOkDSn2g7ICmTvMSXAOAGlf2kBhNsDt/aR9HJqo/sLjwTzTAmSW7izlDCKOH5o5G0DceVccNc/kVW+bom60IPMStWXHJqca84bGrZZrB96RoRsw4p5G/LK//YmP56EFw5tMPgeZVy5qDSEzwJCyA5AuxdEV0XyFMgRNq8AHguuRlf72lOOumyZg9y3IDab2ze6SdjL8iEH3zGshsJLOnnDXMgXu0OquG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(366004)(136003)(396003)(451199021)(86362001)(9686003)(7696005)(71200400001)(38100700002)(33656002)(186003)(38070700005)(122000001)(6506007)(26005)(55016003)(64756008)(66556008)(66446008)(4326008)(66476007)(66946007)(76116006)(4744005)(2906002)(316002)(5660300002)(52536014)(44832011)(41300700001)(8676002)(8936002)(478600001)(110136005)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KNhV2z8f+N52LYd8Wexv4UNnAZEIX/jfG8jhnU7QZb7iOSdm2hJZyzKJxAG8?=
 =?us-ascii?Q?d/Xnr/nRKwHMT2rSBr5z2TeVs+ILO7n2zgoGgp2O+J0hHmry7fljr8HEbZRB?=
 =?us-ascii?Q?zo9pQ7J64qnm+18YW2xR5BICqbRD6GJj0kH07xn0enKp5vu+FhPrwG5NIixT?=
 =?us-ascii?Q?QD7lehZ34x07FL4M7hO0qCh2VAHi3t8qBIPppq+4Qve7tqxRc7PMV0Gs9AXj?=
 =?us-ascii?Q?HrOGRtQbGJJu6ziz6mgj3e1CyEnVa+bwDdoUOkIgVUa2atWCD9wSaVnhnGS4?=
 =?us-ascii?Q?TAZDK8huhuHtO5fuYIuWRJD9ZlWp7mRd5Bi+VlMjAkgTELPyJoDLofCRcATz?=
 =?us-ascii?Q?g2TpjEyVRI7ZUroak5L13B/nynFYBIhvB+7QRRmncdHsYWpVysHaYDMU0zor?=
 =?us-ascii?Q?85XLgYNJPBPV866JvhWmKqVwPwd9v/DjQ8U/L/FNIepaYxruIvyG7Le9fWtl?=
 =?us-ascii?Q?T5c5m+yWzd/C4hrP1cQI9UyKk5aOzYSQJOhb/22AIzdPyb/vVrPyCocILaqI?=
 =?us-ascii?Q?8e2dXzTeji5mysPVzxB6NcN2T00DIEBYL+CHwaVE3kG7MtinobpvEMTN63Tx?=
 =?us-ascii?Q?D/UMxjC1wMFBaOCOghrUDVIxgbuevvxJDmadnjHIy4VB6Kl1N8Avs3fmW+Cm?=
 =?us-ascii?Q?j69pTWavJUfy7MfkfYVp732jFQ8OzFYgArw2u1FjA47etpWStwNmEZPJywGt?=
 =?us-ascii?Q?GqUhhxuqPo5Q0qWYZ/GPUtyHTu2mFPQVhPi1MHJkDAR6qgKi/KASaLO5jBKm?=
 =?us-ascii?Q?yO4LUMOMVOsrOuCyF40t1QxQppN4cnItUXrp/DNhJubB4yT12Dnt+e6WHwOf?=
 =?us-ascii?Q?d0KAJLSuC9qN4kRfC3o5aI/ZdwNUALrqjwL6IjnBwQC7u3j/Qnn7ikopIYt5?=
 =?us-ascii?Q?4TgFXeDu9xBjmqrGCxYWxQhbTODwcVaQLRWjToHTlJ+g7R4uhfC8NYpF7dSp?=
 =?us-ascii?Q?ftXDfE8PdLid0Ipk0AKKaqjzCzdfw4ZHy5OeldOxXj9P5n/UXYg0KyK+o4Dn?=
 =?us-ascii?Q?6itFmkWFmBNRxmoeIthHLuZUmRXAS51Fz7LaoR0Y11RTmg/vdu3z1jSYElVa?=
 =?us-ascii?Q?HGaBXxMaNzdkpQcXNJm413DbXRviuVO67/xiJdC1QUfsSmDyNcYRRmLjHkc/?=
 =?us-ascii?Q?BCyqCjVKq3RhovBdc/4NAl7wf+2Gc+AUpAq7Hv3s8Vp+t8vj+ML+Ps9LnkWK?=
 =?us-ascii?Q?DXvRvuU+pgmXT5Xizs4hu5G18m0IPnMHLLZE4Q51GdKsfIDbhaFxr75U3g6X?=
 =?us-ascii?Q?D79P4IcQgJO7ZzUDqq/K0YfiPMplnPcJr813q0JRUl8URHOr+ONgfBT1N5wI?=
 =?us-ascii?Q?W4EMOQQOt1GgUj2hKZpcMIDy3JTlerv8/DrjmxuDcpxvl6S1G8mRYdiEVHmL?=
 =?us-ascii?Q?xV3yVP3sBJRdNivGRC+4QNCAqr1WEjEENulMRUy7ne3D26Q2wHqCn7K3+rLn?=
 =?us-ascii?Q?/Wi+lwnwe3VY1UPqVMl8G9Nb4oNRKKDTmJb1F4VdkJhusmPwnToHvICvteZb?=
 =?us-ascii?Q?+CuvYwoB51CmrutP8OIWInWC18HYyg+5fWz+zH4H7Xba66YdDhTWd8pcQ5A6?=
 =?us-ascii?Q?YeUDYOSYTsOzZkJp1wM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21194666-ab00-4a9c-4eac-08db8eae5208
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2023 14:32:35.4338
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tdk/1FjwnLAAi38L5/yF2WvJzCp0zujdCuoHi1mMxs2E//rtzdHs16Pub0aHESjjZOdkVO92N8eCMMquo4R4hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8854
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ulf,

> Subject: [PATCH V2] genpd: Makefile: build imx

I see drivers/genpd are in linux-next. But i.MX was not built.
Would you pick this patch?

Thanks,
Peng.

>=20
> From: Peng Fan <peng.fan@nxp.com>
>=20
> The imx genpd was missed to be built out, add it in Makefile
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>=20
> V2:
>  Drop scu-pd change
>=20
>  drivers/genpd/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/genpd/Makefile b/drivers/genpd/Makefile index
> c429485c13f6..666753676e5c 100644
> --- a/drivers/genpd/Makefile
> +++ b/drivers/genpd/Makefile
> @@ -3,6 +3,7 @@ obj-y					+=3D actions/
>  obj-y					+=3D amlogic/
>  obj-y					+=3D apple/
>  obj-y					+=3D bcm/
> +obj-y					+=3D imx/
>  obj-y					+=3D mediatek/
>  obj-y					+=3D qcom/
>  obj-y					+=3D renesas/
> --
> 2.37.1


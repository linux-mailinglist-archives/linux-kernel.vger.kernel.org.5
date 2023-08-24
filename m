Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 090D378757E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 18:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242594AbjHXQfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 12:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242281AbjHXQfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 12:35:21 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2049.outbound.protection.outlook.com [40.107.8.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D328E6A;
        Thu, 24 Aug 2023 09:35:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OdALxPiR+PJIqarDn+oNo8/S6v84rUzTFgmD78gnCCQIFwZjaeRuhPGaump6r0xZNTYf6Ca0I6C1wHoZdTywCOO5LiNdMeCmlXkRiHF2QIrtrvBulSz0UTCtCWSSvceRUw799zqnhTn0opcM7UsfdgSc6c6DmAihS7XxHnKUpGibNCszli7rN3NcKu4RmQPduHvyROHON4d15WVQgx3Ac8pIojdi9+NNdgz+dFoA7rs2BQUoBsFJ+0R9SOC76wo6ig2BYQFXD8nbqnSY98z15NKv+//m04kvu8JFpYjn9i5hdn1MtMC9KM+yXnpWZdUfljsuOWQydBjtBifbWekq8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9IPaX6+t0xSguYhTtq3ZYQtf3s7JovGLwJ1fOtqKBa8=;
 b=UKWgmI7ACdNSejAmZNI/h9O/2TVHqozmYjMUko5rXgNYhPSjyeDVaPZG6LBh2j+urUbOBO4bQ4yNWKIgBgU2D6rleTn3139bfkRYV5FImiyJ/ejeT4vxV/EUJSY7/zL7t3fi4qnjHjSX44NNOOyXRIkTfOZ2AtiACzKZr8UVSXtzOPpjEkpBS1O403TONelaLLT3xfWkRYzCQPwaAU4eoLFzGuZYt3VUKiLsk9CHvvM+pnE+mGArwkEuqzoLd4ytMCiAPsPYO0HX/qTE5UByd9eXUJMwmZmMVrNldznJsowTM9cKVcenk/hnveFKiyR+LoP3eb1zoAW2l/Wn6z8s6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9IPaX6+t0xSguYhTtq3ZYQtf3s7JovGLwJ1fOtqKBa8=;
 b=cMJ7xuHFKjyVXOyBdhmX/HzOvLgn0UgjIJraTzetyjz8RWTOg16JbYzVgCeNaCTigolYwqiPGlZhxscgdwDBgA7ZnC6RH4YCbiEL/9D7Z4307XKm7xKD38hD6ggvm2OfIydtvyfofQErmAou9/+Trt52yfv56Qs7eZrBA6iFYTM=
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by PAWPR04MB9988.eurprd04.prod.outlook.com (2603:10a6:102:38b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 16:35:16 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671%3]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 16:35:16 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 1/2] dt-bindings: power: Add regulator-pd yaml file
Thread-Topic: [PATCH 1/2] dt-bindings: power: Add regulator-pd yaml file
Thread-Index: AQHZ1qj2VVRTmWnHdEanv3R7kt4LnA==
Date:   Thu, 24 Aug 2023 16:35:16 +0000
Message-ID: <PAXPR04MB91858254554272C90822FED1891DA@PAXPR04MB9185.eurprd04.prod.outlook.com>
References: <20230818153446.1076027-1-shenwei.wang@nxp.com>
 <CAPDyKFqsn6kVjPFUdVyRxNDiOaHO9hq=9c+6eAK4N-v-LVWUPw@mail.gmail.com>
In-Reply-To: <CAPDyKFqsn6kVjPFUdVyRxNDiOaHO9hq=9c+6eAK4N-v-LVWUPw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9185:EE_|PAWPR04MB9988:EE_
x-ms-office365-filtering-correlation-id: 695ff9d9-cbae-4803-ca59-08dba4c0190f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oTgXQL/sylWH2GgLXOo3UD2Xi0gysyVWK7nuh4r5qoa2VUy3lFWSEBHR3odOkpE3HH/nzdgTRGCVpCEnv7IlaxRib3qVKeJ7bdw7eOS9H3L9ZrVv0+E3TUsC86ayPu4h+Wvk53FyJW34PL5cwA8YwTxhnX5Z7tZ2WkcaCcak6btdgU0F/pSqC7uHR2vq6MlYjAioDdPUvu6LVpZyFeYWSixPwaWPoF7CRLrC/oAoXsR8tpU6Lpy+eh34qWDaaRNTQNsV7o5RoNJ0A/NiJyiKImKzfOehQ2gEmEZBrBvT8x0Xh4H7kHMRLo5DtvwB3sxdmPQVckrAOx0P/DXPqR8vDgu7zIkGzha0Q33kWa/7wR+xl2F7/+lGcqe1MTNbwkuzLzkhBuVsuUnO7wm2vqJ5WEYAyvz4tuXyko1xzZJrclrXMsByvdviEjdBEvphX5QNaRgXDEx9/jJUZL8CiC1av8VeUzuj2j3gpbx19Sr2hBTgjf4aluUp+NxWOgOpkofteIrJTOCLEKRLwv24kZJgNX+fggRP+6bj3PETWoxRcggQwDyoCVy9/340MlpKgDQZtLZkRCt60HZugBBkgJMi5nRS60+8RxXfTqO3/IagPcQBqn1YaEJyQ5Eic/gj7UBA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(396003)(136003)(346002)(451199024)(1800799009)(186009)(122000001)(38070700005)(38100700002)(8676002)(4326008)(8936002)(64756008)(54906003)(41300700001)(6506007)(53546011)(55236004)(7696005)(316002)(33656002)(66446008)(6916009)(66476007)(66556008)(76116006)(66946007)(86362001)(71200400001)(9686003)(55016003)(26005)(478600001)(44832011)(83380400001)(2906002)(52536014)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lwdhnNnnzuVoKHGexU/mfkqYXN9FLTL/nrfdwUQlII249JueU++NNz5xMkbB?=
 =?us-ascii?Q?YjQE4JhY9aCLU/R5OOGY5uYpYIdmQQGZMmwCEwNlXrhEJTE4rEshok2Iu/J+?=
 =?us-ascii?Q?JsXBCJxRVerW4UnJFqH//ZfrHZ6hVZ8uY+42jCHl7zijGG/enDeVbWNK8dY/?=
 =?us-ascii?Q?9Ezq92y5O+vPI2kf3TvOGnGjeVWZq5pEDW5tPv/VlmvjWOh0aXFqZzYCL1Lt?=
 =?us-ascii?Q?IwQ6tBd1ITP6CQAyJNMjkZxCss+wESc5Bt4Ts3/A/nhkejdfBpLKPaf2Q3I7?=
 =?us-ascii?Q?u3wmB+orwVchQ/FDNmfWHVmgdZrEp5OlEsfZzaKZvU/1zGWnvj2rY7RU9oeu?=
 =?us-ascii?Q?90h87z3T9nUDwzgpvjthOVhLaxyFjwtljqBlEz00r9JHIcG81h8HH1ZajpqE?=
 =?us-ascii?Q?X/M4S4YEK0CpkePugenLhLu3+B55D0t9d1/P7z/94/YqgR1a5Txb2DSzwYVC?=
 =?us-ascii?Q?7wCapgo7kBem5Qolt9jwkfjj2oqyQftBdZhsmZiytVhRFL/scWQeQIVegMnd?=
 =?us-ascii?Q?6Cpg+I9B031O7VIxk9Bvu/NQP4+TeE3oLYJuiQddMknFhOVOg/Z8lVAP74A/?=
 =?us-ascii?Q?28nFe723jyPXGnxvwmJazqx1FzNadnkHhTjITJ6o8LErvkqXXCTFXAyk02Wj?=
 =?us-ascii?Q?tvTHoow+KnlEnX90/YlzhhjDhcQQ5TMwlLTWrz9bnfeIDyKEtRDNTrKaiHkw?=
 =?us-ascii?Q?8IyoRv8Yq3Mq0JllcVyaIaYgZdTV6oT88A4OrI0tPnA3IfasQDVmrrQBfP8T?=
 =?us-ascii?Q?/41Gh8v/KrORALJgMCNPWNR2P7ym9vcQdsMZxay+mmMNxnPjIY2HJY9jSmv3?=
 =?us-ascii?Q?WLXbuY47gwKrf8ddnO/TXmTp1Bdpys93OkqgpVn3LkusQ9TT67PckawlC1lI?=
 =?us-ascii?Q?dFcUBpiWJHzHVWD/kfzseePG6kCakpCxF3T8FSPJljpIiLGLdCP2PW1HFhAl?=
 =?us-ascii?Q?Cp+tGq2vYfJ0H31ZhDQbMlyqVz8eXT5d6NWokIRaAQWV83BgS7VJZxOIaPFN?=
 =?us-ascii?Q?pu67XvG71V6PS8XG3b9vme22oDrKTw/mYzmdbC52LN8udcT0mgrvfho93xPg?=
 =?us-ascii?Q?GQdYnxWu5UJo2mnozM0quwliRaBirxBY0dr7qyvjUFz863ew3mht8fWFcKLO?=
 =?us-ascii?Q?fdRiyvK+89f684JpSCKPRCWmn5Tapf5IofGgsHVYerK+flb5FFgt5wpDES/V?=
 =?us-ascii?Q?c9m5IMG5xK7ffmouYyeP197NsvS3SKSqfVBAaOWe42lK/uBEPs8+ls9c3x7g?=
 =?us-ascii?Q?d4fpCoVzkBZvATfuIS25kLGbEu9wGLpXpiol0hZ1qwj9PQev3F9Zb2NzLpxY?=
 =?us-ascii?Q?EZpIzDEO3V1TV/OpCG+e9xsQkRE0BpWLDzyI39RrbHZxgcyGk2HuhBEjjdXM?=
 =?us-ascii?Q?Q0V7TJve9SCJKI86Rhx9FF+Z92/jZ2mdSHPPIdxbMAi2YUlZmlRnLbTCRb6/?=
 =?us-ascii?Q?zW3n9EU4DGdQ7aUCX1Nh7P98CuNnOoNdLXEGkQW6+1CgMcZ7mK6ASaKSAYQh?=
 =?us-ascii?Q?Yf8pjw1AH/0sXRQqCGie5Gn2p2p/9k/WsOCtc8OfYVOfaSQkEP8SdH+qxnp/?=
 =?us-ascii?Q?Q70YqI2rCumSf1Vg2I7MMPYpFAbIpziQ7yGO4ukN?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 695ff9d9-cbae-4803-ca59-08dba4c0190f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2023 16:35:16.4193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UpSCM5zn/dwVBPJO4Rinuh59Gb7VNbafCnJrvt96X8rNfzeJXGsDqqgVLlyI98nbn2IbKm9vM8gSngfUJgh0Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9988
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Ulf Hansson <ulf.hansson@linaro.org>
> Sent: Thursday, August 24, 2023 4:27 AM
> To: Shenwei Wang <shenwei.wang@nxp.com>
> Cc: Rob Herring <robh+dt@kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley <conor+dt@kernel.org>;
> Liam Girdwood <lgirdwood@gmail.com>; Mark Brown <broonie@kernel.org>;
> imx@lists.linux.dev; devicetree@vger.kernel.org; linux-kernel@vger.kernel=
.org;
> dl-linux-imx <linux-imx@nxp.com>
> Subject: [EXT] Re: [PATCH 1/2] dt-bindings: power: Add regulator-pd yaml =
file
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report =
this
> email' button
>=20
>=20
> On Fri, 18 Aug 2023 at 17:35, Shenwei Wang <shenwei.wang@nxp.com> wrote:
> >
> > Documenting the regulator power domain properties and usage examples.
>=20
> As Rob and Krzysztof already pointed out, I agree that this binding looks=
 a bit
> questionable.
>=20
> Rather than adding a new DT binding, why can't we just use the existing w=
ay of
> describing a platform specific power-domain provider?

Can you please provide more details on how you thought we should implement =
this
feature using the existing way? Very appreciate if you could provide a simp=
le example.

> This still looks platform specific to me.

What does platform specific exactly mean here?  I want to make sure I under=
stand=20
what you were referring to.

Thanks,
Shenwei

>=20
> Kind regards
> Uffe
>=20
> >
> > Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
> > ---
> >  .../bindings/power/regulator-pd.yaml          | 71 +++++++++++++++++++
> >  1 file changed, 71 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/power/regulator-pd.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/power/regulator-pd.yaml
> > b/Documentation/devicetree/bindings/power/regulator-pd.yaml
> > new file mode 100644
> > index 000000000000..181d2fa83f8a

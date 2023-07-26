Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBD85762EC0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 09:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233022AbjGZHwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 03:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232942AbjGZHvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 03:51:31 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2077.outbound.protection.outlook.com [40.107.247.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BC930F2;
        Wed, 26 Jul 2023 00:45:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HXJrlfFAhymyr7qgEwYSC9Ppm6mLrdkCn3JrirauBkAkl4B7UIgYdlA+W3b/yt62S36fCVqm7xxhCK5H5Bn/63s045Y1O2QAbeLNXXA7/p1itB+lfGcYST8JeEbwYLalseDb01yMYyfazu9md4PwD4ADIEEKiW+kEsYHYTU+1CGIVbbkFnb5vwl/u5dKBnYo+XOqY011eYVveWTV5mtEW3mDNZgaVj1mZbyqUAzIzzqlwoiroHyLBMhw78pgGf3hVPlxf2BaJnqY0bd/uihIzlwvGCB4vGgOHvbWaEbvH9R21p+SQIh75Lkgh1tmBFwBU9zrUHFyDQmg9ESPcfjXqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kOBYTYDbkgQ7l0H6gt4cndI0CJBH5IK9vKmU+BZq2cQ=;
 b=jmEYrColEFcQx9ItlFGzZnlUdWwrF2JNfXiJkcuEAFmFavxy+KZZEVcclZk2+hFMB5H9Sb7y7RH2c/FaxSO06psNtG36KLmS1rFVz87JphIlLBZU638PyYnRqfXvGr3DAGan/Yzto7EpWBerBzfEv8/yj6Bg+CgM6RlCVmP0iLeShJhZUYsV1PEZjr1n9H/RyT02/2zVaIM7+V4u0kNhhQUQuGG98TTd56z95iAs4/MmIT65b4th43pUosaPdupnk7RRV9bUfOFvkrt7O+8SBqDDYSZgbh0C47J6nYvU5Iy5o28WUmxTXmCCnALuQ8Qjd/ND0rG6uhxHsjdvoEb1+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kOBYTYDbkgQ7l0H6gt4cndI0CJBH5IK9vKmU+BZq2cQ=;
 b=YNo0ZN67QBDerFhJi04V2zSbY6FIZa5gJj1hY2LV1Q43GGvbbYPMUsXbf5LMr9xznWAyrklgystFfv2lT3r22qHropLeMcwUqLKiixxRCDQ1CAW1Ne865YkJwWcysLXJqj/wbBtf0tojjwuKnqFJ35dv3FqU0LobymwpW5GEOSE=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB8283.eurprd04.prod.outlook.com (2603:10a6:10:249::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 07:45:34 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97%6]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 07:45:34 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Conor Dooley <conor.dooley@microchip.com>
CC:     Conor Dooley <conor@kernel.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [PATCH] dt-bindings: power: fsl,scu-pd: separate out fsl,scu-pd
Thread-Topic: [PATCH] dt-bindings: power: fsl,scu-pd: separate out fsl,scu-pd
Thread-Index: AQHZvuIo+RWSoLABrUiHrp6dtY69Sa/K0C+AgABgB2CAAHt4gIAAAGFQ
Date:   Wed, 26 Jul 2023 07:45:33 +0000
Message-ID: <DU0PR04MB94172387DF83E1F9A27CC0F68800A@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230725102900.225262-1-peng.fan@oss.nxp.com>
 <20230725-excretory-speed-003064040657@spud>
 <DU0PR04MB94171BDFA6FF61A644138F688800A@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20230726-trolling-chair-41f8258ef8ef@wendy>
In-Reply-To: <20230726-trolling-chair-41f8258ef8ef@wendy>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DB9PR04MB8283:EE_
x-ms-office365-filtering-correlation-id: 80d449f6-de80-49b9-6d34-08db8dac4b43
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pWVHyfXJ6PpHu8NhFG6IbGVSaZcjpO39KO4bLIAqkn+1S0JIRYLricXF2hvyIz4dQzKGSDKDq/xxBn3geqsz1M6KIfWL69f6yVFs5HkYJhSQb3j6y5qCEwCugAH9XXJWwFJIAsusQwuI16XSIwXiFxXlwW9xBdRvjsoEgUzOp6w8hhDQsku+w0LX75ujsV2C6qYrn7/sRbR7vX2OjhE2T1kJ5phihQk5HCSOc2CjFXjUtOY0H1H9tayqdW5oSoktOV/fSunnqIKIr7XNe7wg3hIs4iJHfKrwlQgPGm3fG39CXDRQfpEx4UceTqqBL+lBp/VZ5QXa5uup9MePtrUzXXLp5oOEU++KJbpPY77XY5XyUCA/SlUYkc/K3PpygMDcOMkIesye8WVc9lPsIkZEKCOG2/KSCN46D+BpOaF5NW7eJGBTqPQY+VA8ZgiwnrD+/xvbG8E9NPjzvMeQRdhEKghEAeUN6Z/wgmlq4d3gc3If1gq29zEuUsvJwDuTz3RdEAchYlXxqeWYI8bmff4yct4RcNmbpCtxA95Lvrz0bM24Mu41FmnyBMuJcUlxPZ8qjijg0o2pzayH+9XEdXb+86WbLf2cBZmwu2j3YGoSrZaeazVelZNZK4Q9d0gDy5Gt
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(366004)(396003)(346002)(39860400002)(451199021)(6916009)(7696005)(64756008)(38070700005)(66556008)(71200400001)(66476007)(66446008)(66946007)(9686003)(76116006)(44832011)(4326008)(54906003)(4744005)(55016003)(38100700002)(122000001)(478600001)(2906002)(41300700001)(7416002)(5660300002)(8936002)(8676002)(52536014)(33656002)(26005)(6506007)(186003)(316002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DTc8EX6jqEfQYdxQsFsma/nUIMNyQRYStoOXgv/c+ww4l+ox2zd0QN36fgux?=
 =?us-ascii?Q?qOyYYoDHAhauFFufao9ZlEz+hvWDhB9yCxiNZbgL0bBazsHopE6cfGqIVWk5?=
 =?us-ascii?Q?pvG4ZS8iN3dx3jw9JtgwavrSutV/WwvnqFKR7rVBXSFe7F8Gpii3HKxQWH4N?=
 =?us-ascii?Q?2+Ax8AEzJofkGhrZsc2TvgkLytEmiZgKMNhBKnrjDb3mYVqN9asSCOI+zkHh?=
 =?us-ascii?Q?7fj9kdr/gZRyJXz71+gLgMxJlqvRbwHMV5sibboTDAknMfNX4OpdNiVkYU6L?=
 =?us-ascii?Q?MaG1hZo7kYWa43aq52zHcfdusubcl3/8kXG6655wOQZXLvF4teKlxwfzFBDA?=
 =?us-ascii?Q?JpVEOsseFxctqHIzkhoSEgVwSykERIvMinisH0OlhlYAovEb6issfyYyCQRM?=
 =?us-ascii?Q?Q4fNXj+196KMvCbvJfbvq3fU2ey65+m4fL6/rQfRJwohCBZhUfDAOH9AKYTQ?=
 =?us-ascii?Q?BBF1prCVV91pQAcevwLyKYbfCJx9GdgbcgmftTNAmVGFPgY1fg/kLHs1c2Vo?=
 =?us-ascii?Q?K0IAtf5zYJjW9u7o1JfmNE7vlODuxY4tf76hUozmDRIrCHKP/h1RFBl95ewF?=
 =?us-ascii?Q?1POVrBBXL9Q69GvsiZ+veC3oVD3j9wchj4wB0pfEOUeXIYk8PxQyFamCmTia?=
 =?us-ascii?Q?jxdR7PyGNu2lR3/OuJgmarBgU9yHq9TII740HoQKA8F7nX9ErTaKSkJ8+Qhv?=
 =?us-ascii?Q?WgXIlLX3fUKjjIvgZ/kfG0xYdcYtJn+dYjsNLzM7PYnYLBF/cBRWPmHMmfiy?=
 =?us-ascii?Q?Vhx0oJ/ImcHNeOKKqQbgFOWoLi1sYDFM2QMpGNSFD8a6rCOQm6wMEyu7SQqo?=
 =?us-ascii?Q?A2SvqIYLb3XUtsPjgNt8g8Uftcw2G8GeNnszdSLgiWTU09x2arFnOBOVnz2v?=
 =?us-ascii?Q?+R8pNzPWQHRwWdPydKDebQ+y5H4zkMrz21KNGoncdB+k67INE9eI1QSKiYjS?=
 =?us-ascii?Q?HJ+5s9ZpD5UJHQbZ5K+D4BrKDWoR7fYJK1huEP8ytylUKrItg30eG9lglmk6?=
 =?us-ascii?Q?Cz3LdQiJCqzop41o/Muz2xFuowPZ2ecomqZrqF9qFSkfTrqyTrcQbpM3Yv8c?=
 =?us-ascii?Q?u+bFoFhD7ZmHZAMlYRqSERreUc1MdbWJ1DPiW8Pn/fwfmW7mEMS13scMWV15?=
 =?us-ascii?Q?3YCaLj624Z6vTA9EmrxIDz8OmwR/kqPbWQkM1MlJwb2fgA77/bmO50yXKhcO?=
 =?us-ascii?Q?v++4DNUbYUvcahq0vZSeBRj/iHLUwxS1bMQiwH56eY3TDYD7p9zGOkDAppu3?=
 =?us-ascii?Q?rDhAcPRifRRYmwWfE59FXxQq1pzlDWR/fMNx2xJqcFrJLDSGO5/cXxsUeN6A?=
 =?us-ascii?Q?saq994ZZf5BzaliNMZP0H5U+OAJEm2aALbveyw3XdbJjAE70qlWBb4JEmRW1?=
 =?us-ascii?Q?af3KRilWKQK/8cFHkV04psHebcVbJ8Y4FtvWowoetn+nR4nKIrvfGQOeMCRc?=
 =?us-ascii?Q?aPAtMXsHLEbVaGQ9t+kH30MNFedUUtc5w1GhQ5+cxQ3tOqdmgrl7/PfXG1ww?=
 =?us-ascii?Q?P2m1eZaYGR7T2psPdZ4zxmryUGzY4AwFHesPVfeUuSNDtHPh/y6+er9xlYYX?=
 =?us-ascii?Q?xQIF1y34SaWBeHr6cp4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80d449f6-de80-49b9-6d34-08db8dac4b43
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2023 07:45:33.9636
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rD/wmZy3yoZb5DA98bIXQCxuVsytG2+86T2DzEjEmSFY5qImQYLaiC2pttd0AD+KKphH9e2+ME0z8zI0WYdXTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8283
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Subject: Re: [PATCH] dt-bindings: power: fsl,scu-pd: separate out fsl=
,scu-
> pd
> > >
> > > On Tue, Jul 25, 2023 at 06:29:00PM +0800, Peng Fan (OSS) wrote:
> > > > From: Peng Fan <peng.fan@nxp.com>
> > > >
> > > > Add an entry dedicated for fsl,scu-pd which could serve i.MX8DXL
> > >
> > > Why not just add a soc-specific compatible for the i.MX8DXL?
> > > The current form of this does not look right to me.
> >
> > I could add one dedicated for i.MX8DXL.
>=20
> Also, where is the user for this? I'd expect to see a dts patch too?

arch/arm64/boot/dts/freescale/imx8dxl.dtsi scu node
not use fsl,imx8dxl-scxx. It's already in tree.I am just trying to address
the dtbs_check issue.

Regards,
Peng.

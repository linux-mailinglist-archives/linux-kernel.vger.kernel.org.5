Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 397997B7705
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 06:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbjJDELJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 00:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjJDELI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 00:11:08 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2068.outbound.protection.outlook.com [40.107.20.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631F7AC;
        Tue,  3 Oct 2023 21:11:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mOA1iML0k4sDRFNlgBC7KR8OZ+KxtgoLt2PHc5+Vean4o/lFpMJOn4HbxHYTXJ/Di7uBR92Lj+grTUMMC7CsAMbwLd2RHKRc7tw3K4dJnkOMMkhJLoMIwB7/L7FmHx2gsbOkazreAyf2c1bSJB+FriqUkbNlAWiC6d0dsnIRLrHWr6bO4KxsFzc5rBLRYNe7SfEfyD/u6ibomH7Kz6phAfh4YmqhZ6SrgbQektjHpF1Tvr4/OBWZ5A1lUNAHqJuRSU578zHoeGbhvIAPv5YHeR4gFI/6ZYteuxF0RfR6xxOLBxf48zlLF6EWQ4BDBO3mVV1hRGk8zEz3uk+MSCivpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WS6qMWBAXWqEXvvCOWzZS0T8G87xOX2Gmz1Hj0QfUx4=;
 b=NNpl12rTOkRuR6htGPGcCK2JBtrm+LE6JnwB5xgmLRYxEN7l0KWhXnAGYtBv6fGgagI9kLq/nNp8EHA65dWyDCj7vk76JPWa8PPD1IKa77XZ/yYSKWJ1TJzAW0YxkHAsrwJRG1FBAvPjj1/iBvbBZ+hkMdS5nW70cLJtLpqqY37d4ITNELnek0+tvaIW/rSwqCqSpxotzmYNtnD9w8F03MNyfj37pra01W9ZXSfA79KT/LNhlCYH/9+jFsX4G4NImWILpydnAvA8xXd/NIyGzCAl4E257XFaAErVgnyI0ENgXE2RrAuabHLMv/68ssoryGjueImoOUUh+Ad9o0eIBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WS6qMWBAXWqEXvvCOWzZS0T8G87xOX2Gmz1Hj0QfUx4=;
 b=A9G6QyRNfTJfeYPFuDnm9XxVfrlM4TiaRvRTJMhx1PwddQE2Me+TxRPq8AElievOiLGhatysNckAE6e6U51wQRx1g9uX0z9zGZEfB2pL0Qgx1198KgkKtWZS1o9uxvZL7iPAX2S8TGExQQuThMnx2aooKHo2VGZ86VUQ9THWaT4=
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by VI1PR04MB7024.eurprd04.prod.outlook.com (2603:10a6:800:124::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 4 Oct
 2023 04:10:57 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::dbc:99b7:7808:f82e]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::dbc:99b7:7808:f82e%7]) with mapi id 15.20.6838.033; Wed, 4 Oct 2023
 04:10:56 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "clin@suse.com" <clin@suse.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "pierre.gondois@arm.com" <pierre.gondois@arm.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        "alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>,
        Varun Sethi <V.Sethi@nxp.com>
Subject: RE: [EXT] Re: [PATCH v6 02/11] dt-bindings: arm: fsl: add imx-se-fw
 binding doc
Thread-Topic: [EXT] Re: [PATCH v6 02/11] dt-bindings: arm: fsl: add imx-se-fw
 binding doc
Thread-Index: AQHZ8T3cp/FWHmHt10GsVHBXrCASpLAwlzyAgAdf5cA=
Date:   Wed, 4 Oct 2023 04:10:55 +0000
Message-ID: <DU2PR04MB8630FF5994D65A5404E8B9B095CBA@DU2PR04MB8630.eurprd04.prod.outlook.com>
References: <20230927175401.1962733-1-pankaj.gupta@nxp.com>
 <20230927175401.1962733-3-pankaj.gupta@nxp.com>
 <20230928185159.GA1035361-robh@kernel.org>
In-Reply-To: <20230928185159.GA1035361-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8630:EE_|VI1PR04MB7024:EE_
x-ms-office365-filtering-correlation-id: 91506adb-95ec-4eb5-2c5c-08dbc48fe86d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oCaoS7KUJWmxlbCDqxYhmblNlg6FQ7VqeXVPUR4E7mCOmqDXjLRgEMTtE1DdqWApKwdixSF5FxHfhH1RqNm5OC4ukgIFtbxOsm/C8kRNY0Wh4KsRbWjIpiTHp7SxOSh1yTPlLWELF6qOA6x4CcAnm6txGAtyRnZSsz4t0pzv5/MgvGTq3etWFcFQseRpfDiBOVK6J1CS3OZWk20YO8NcZU47S1cGP+8Yj0VGYq4A93lDxavC3jIxt8SGlpTJ4EAMYStj3hxO2XZYqleMN7hd5upilyMZZzKaXeqFKjZhhbvC2EvU0EpjRuNMCrvbXIJhNJdFc2ZKA/860didO6xvb6gLs2836nayZAqNq/RS7n6hZD6GlX+R1ZVU7d1LufWFWyVPAclFnmrjXtuqgd37LNYG/NVvKyBZCkCOqBIivdyTLAeEZ2q/DX14wZ8Fw1OW260huPNsqVvHEPNMrBEzRg6ugobTdUvHe7+BF1fck+/XpqgNOqcxfuB6C587NFzqjtZlZwjwYe4j/0HyOiDK0sShHBb0SAP+RyUM8hkz5EONBYCa1UeeAkdtypdYVbMJwW88K3n2d7z7JydKvLrcmF5z0Z6UGEiu8YCDicK9q2Ixhc6CGtrZx2Qavv7vMeBL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(136003)(396003)(376002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(33656002)(86362001)(55016003)(54906003)(7696005)(66556008)(71200400001)(52536014)(45080400002)(64756008)(66446008)(4326008)(53546011)(44832011)(66946007)(6506007)(76116006)(9686003)(66476007)(55236004)(8676002)(41300700001)(316002)(6916009)(8936002)(26005)(5660300002)(2906002)(7416002)(478600001)(38100700002)(83380400001)(122000001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8OA7kaSLDivzDyNmUjOFlLkZTGYMElIMrafUxW1RldIi3Z7gYC6MkUrXqPJb?=
 =?us-ascii?Q?pt5uLespZYeliTOWjKs+hBVkNUOj/yc6EXbEG7UNj92Jir2hsrQERhyg2Gl4?=
 =?us-ascii?Q?ol//F/TxQY73//3UZthpZ7/AMprj6u1ol9B079cxi2Z/u/zITexUaxs/Oii5?=
 =?us-ascii?Q?FZT18vWv2Iqu/Iwsz7KdjE703Wj9dYAzD/xpcgwQmYAA7tRvtZvVbusc8Mg9?=
 =?us-ascii?Q?oIlgtXCEvsqo9WJB2/dU/xQuhgqKPhiMKkTsjpm4Qwb9VkO+ujS9O/RRpeeG?=
 =?us-ascii?Q?aoLklJkAOpeeo9HSPVzN0N2nLJbgwDbqC+3oOrChfAimVgS7O/Ix0K/H5d6I?=
 =?us-ascii?Q?LEFCVF5EjSBql9NBa9ra1iOpFI0PaYIm5GC6HDErCrZnwdViCTARIWHJ8I0j?=
 =?us-ascii?Q?pe91kmcv2xPIPUJOfmMgr9yd7/EBpsKbI+Ixj0A1/izBpaNGWIFtF5POw2wb?=
 =?us-ascii?Q?ZiCFX2VzNLznun6ovS1QBsc3e/EY4yctgeuFL5sWechlMRYbGT7JRFiG/keh?=
 =?us-ascii?Q?iAednByFobEQykLBZvaGt1JF7JUyhHm+uOqcR6cOeQcJ5/gfofyZFeinx7IK?=
 =?us-ascii?Q?sNLW04o2BX54LiBViSTQxF+XoPcOWYFFTOECeCEHHwI8GBh0JajtlYTFB9aR?=
 =?us-ascii?Q?/xVJlfcRekoFIjqpwcH2KLoWU0SU+//7JLO4Z1ubf9sjzyrAs1uuTysBTvuR?=
 =?us-ascii?Q?4Cs0eQpMUteGsxCMDdB9Nuv9XUAa2pgiJQ3ykkS2if8AhbmOhQ5TzGEx80sx?=
 =?us-ascii?Q?VxS2gnJs8vkCS7jmzr1I4RgLyvUduUt2PB/7PJ1wcWMN7j36MBiZjXDvjgvV?=
 =?us-ascii?Q?uNp50waEzD2DiecRkme3n5BD1IMqd3pjGoCKK2XO3af7oWHmmT5RnH8bh2Sb?=
 =?us-ascii?Q?EkpmLuGydPesC4KJXuTUfQ0Hie8Fx7BCFriyXy+lOGE5qmi5cl/sBW594fsG?=
 =?us-ascii?Q?6T5UNJB61yzRSckBt0g8+Xezg9z9mB1bBeJx25GGSVu6Lvw9JdBGrmv0bI2d?=
 =?us-ascii?Q?lA4CFYRPwvppmwkxEl+vNYorPKi0MAcppF2IF6IOjgW8fqHwuBV/1ICpp1T0?=
 =?us-ascii?Q?6KalEJhrkBwCgMMjkZBxU6cG1au6FHuLb+h6SfHndRa4rte5p4+AVa1XfSFe?=
 =?us-ascii?Q?zrqAZEFzBXtAWrU8DKIpaR/GPQFWyWPWKfOA9Dpp4mXkrmDeUJF3MsjK7Iiy?=
 =?us-ascii?Q?YDp0Xfy/ahiDPVW6k0mdHCephcKL5jOzgbW3g4fsz+5c5LiYvGhpQYRMDdaU?=
 =?us-ascii?Q?YEJQ02qILMgQGeU3kf0qD3VBZ2T+UwY2E5rwOA73YEM1BW5E/prbGjtwUP8Q?=
 =?us-ascii?Q?A5wEmYtHb/rEZzKq2kN1fk6eacDy7DADGzDM0yVhF1S9TRXH05UEY8/0KSH8?=
 =?us-ascii?Q?dS2M6rIGbMpd1zMMqZdrFNQT2fcMNIdyes1GaFlhoMoBH6sHjUVtbhy8oa/T?=
 =?us-ascii?Q?JKJYOAyW+EOR6UsIYujN9wmJ4kdn0AcvR3Gh2Vljm7qvaVuj7V20UAhOWaHt?=
 =?us-ascii?Q?OTJhS33+pIINe4pMiHh5QdUdmi8Z5MPjqqWWIpr4XRy9EVPRV0ERKRLWeVgF?=
 =?us-ascii?Q?hzj7NlLL/NlTSBCp2swM8mdsEjbYVK2XLJTDl93i?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91506adb-95ec-4eb5-2c5c-08dbc48fe86d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2023 04:10:56.1633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: owIKo2/5y9PLOwZSct81Mo6i5vBZKlOHjS5lTcQXpLtdTq0yWF0mqF1mcfEM/vKI/8+3sica60FP8X+h4Vr10g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7024
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Friday, September 29, 2023 12:22 AM
> To: Pankaj Gupta <pankaj.gupta@nxp.com>
> Cc: shawnguo@kernel.org; s.hauer@pengutronix.de;
> kernel@pengutronix.de; clin@suse.com; conor+dt@kernel.org;
> pierre.gondois@arm.com; festevam@gmail.com; dl-linux-imx <linux-
> imx@nxp.com>; davem@davemloft.net; krzysztof.kozlowski+dt@linaro.org;
> linux-arm-kernel@lists.infradead.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; Gaurav Jain <gaurav.jain@nxp.com>;
> alexander.stein@ew.tq-group.com; Varun Sethi <V.Sethi@nxp.com>
> Subject: [EXT] Re: [PATCH v6 02/11] dt-bindings: arm: fsl: add imx-se-fw
> binding doc
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> On Wed, Sep 27, 2023 at 11:23:52PM +0530, Pankaj Gupta wrote:
> > The NXP's i.MX EdgeLock Enclave, a HW IP creating an embedded secure
> > enclave within the SoC boundary to enable features like
> > - HSM
> > - SHE
> > - V2X
> >
> > Communicates via message unit with linux kernel. This driver is
> > enables communication ensuring well defined message sequence protocol
> > between Application Core and enclave's firmware.
> >
> > Driver configures multiple misc-device on the MU, for multiple
> > user-space applications can communicate on single MU.
> >
> > It exists on some i.MX processors. e.g. i.MX8ULP, i.MX93 etc.
> >
> > Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> > ---
> >  .../bindings/firmware/fsl,imx-se-fw.yaml      | 73 +++++++++++++++++++
> >  1 file changed, 73 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/firmware/fsl,imx-se-fw.yaml
> >
> > diff --git
> > a/Documentation/devicetree/bindings/firmware/fsl,imx-se-fw.yaml
> > b/Documentation/devicetree/bindings/firmware/fsl,imx-se-fw.yaml
> > new file mode 100644
> > index 000000000000..d250794432b3
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/firmware/fsl,imx-se-fw.yaml
> > @@ -0,0 +1,73 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id:
> >
> +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdevi
> > +cetree.org%2Fschemas%2Ffirmware%2Ffsl%2Cimx-se-
> fw.yaml%23&data=3D05%7C0
> >
> +1%7Cpankaj.gupta%40nxp.com%7C5ec9b97100834814d30608dbc054010a%7
> C686ea
> >
> +1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638315239256248220%7CUnk
> nown%7C
> >
> +TWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwi
> LCJXV
> >
> +CI6Mn0%3D%7C3000%7C%7C%7C&sdata=3D5%2BuUxUzFCRHsi17vX83tGcJijp
> HsNAxd5Fu
> > +Ws4qT9Lw%3D&reserved=3D0
> > +$schema:
> >
> +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdevi
> > +cetree.org%2Fmeta-
> schemas%2Fcore.yaml%23&data=3D05%7C01%7Cpankaj.gupta%
> >
> +40nxp.com%7C5ec9b97100834814d30608dbc054010a%7C686ea1d3bc2b4c6f
> a92cd9
> >
> +9c5c301635%7C0%7C0%7C638315239256248220%7CUnknown%7CTWFpbGZ
> sb3d8eyJWI
> >
> +joiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7
> C3000%
> >
> +7C%7C%7C&sdata=3Do1LjAT7gJVTb66L21HyhfY9dGh8uKIFNHWKg%2FLNBMO
> 8%3D&reser
> > +ved=3D0
> > +
> > +title: NXP i.MX EdgeLock Enclave Firmware (ELEFW)
> > +
> > +maintainers:
> > +  - Pankaj Gupta <pankaj.gupta@nxp.com>
> > +
> > +description:
>=20
> Need '|' to preserve formatting.

Accepted.
>=20
> > +  The NXP's i.MX EdgeLock Enclave, a HW IP creating an embedded
> > + secure enclave within the SoC boundary to enable features like
> > +  - HSM
> > +  - SHE
> > +  - V2X
> > +
> > +  It uses message unit to communicate and coordinate to pass messages
> > + (e.g., data,  status and control) through its interfaces.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - fsl,imx8ulp-se-fw
> > +      - fsl,imx93-se-fw
>=20
> The firmware is not compatible across chips?
=09
The secure-enclave hardware varies from one SoC to another.
Hence, FW varies too, from one SoC, to other.

>=20
> > +
> > +  mboxes:
> > +    description:
> > +      All MU channels must be within the same MU instance. Cross insta=
nces
> are
> > +      not allowed. Users need to ensure that used MU instance does not
> conflict
> > +      with other execution environments.
> > +    items:
> > +      - description: TX0 MU channel
> > +      - description: RX0 MU channel
> > +
> > +  mbox-names:
> > +    items:
> > +      - const: tx
> > +      - const: rx
> > +
> > +  fsl,mu-id:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description:
> > +      Identifier to the message-unit among the multiple message-unit t=
hat
> exists on SoC.
> > +      Per message-unit, multiple misc-devices are created, that are
> > + used by userspace
>=20
> Extra space in there.

Accepted.
>=20
> Wrap lines at 80 unless there's a benefit to going to 100.
>=20
Accepted.

> > +      application as logical-waiter and logical-receiver.
> > +
> > +  memory-region:
> > +    items:
> > +      - description: Reserved memory region that can be accessed by
> firmware. Used for
> > +          exchanging the buffers between driver and firmware.
> > +
> > +  fsl,sram:
>=20
> Just the common 'sram' property.
Ok

>=20
> > +    description: Phandle to the device SRAM
>=20
> Used for what?
Accepted and will add the details on the usage.

>=20
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +
> > +required:
> > +  - compatible
> > +  - mboxes
> > +  - mbox-names
> > +  - fsl,mu-id
>=20
> How is memory-region optional?
Depending on the type of enclave IP and the FW, memory-region is configured=
 optionally.
For i.MX8ULP and i.MX93, it is required. For i.MX8DXL, it is not required.
>=20
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    ele_fw: se-fw {
>=20
> Drop unused labels.
I am sorry, if I am not able to understand your point here.
But, all the below labels are getting used.
I can remove the fsl,mu-id. Will do it in V7.

>=20
> > +      compatible =3D "fsl,imx8ulp-se-fw";
> > +      mbox-names =3D "tx", "rx";
> > +      mboxes =3D <&s4muap 0 0>, <&s4muap 1 0>;
> > +      fsl,mu-id =3D <2>;
> > +    };
> > --
> > 2.34.1
> >

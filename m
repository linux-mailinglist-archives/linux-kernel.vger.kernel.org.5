Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B83A7A6298
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 14:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbjISMTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 08:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231998AbjISMTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 08:19:07 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2042.outbound.protection.outlook.com [40.107.21.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE582D51;
        Tue, 19 Sep 2023 05:17:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJwNTvZredXx5USNIE5uu94shpa0k8Ha1mV8vOhweCx0EVlrNOOj54c7eobNY2O/p3RbWC2DRDHn3h/B4ETEaQJxnI0VypuV5AjnxLFiT88c8BUS+51qjwziZMmoPl8JGAg1apvhuGKaDg7PuV9dvEBOyDjGS9S27nbJYcWCshcZqE6fQ2NAFxznSV+Udbnxt0v84rdEKBaFBjL+3lAiU4n0VHfxLDmFMPgzJONJ/DpgSNMZqYhcbnRVDAk6AwR0DiOBcWH5WjSHRKEoL5lBB+1QvMQH/qKPbikeyw/p/C7o4bnbBSAaCTBhLByjtxEE9U3q2xRkv0Bop4YcD+ofAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=deI050UroHNbtpGA1P++CnNHuR7s61hJHsBJ9cBOpXI=;
 b=PaCjCkvr0lAwiW4iun7POC6349KUdcPJA5gXc0Yt6lJ3bn3EJO0Tra0T+IHaGBc3ZQAJyfH12bIVTQPCTETUgfATP4MmwdZhX+/WalfYyROQQFbXMIUdkWejIz65Xfa5b5mM9qQ+MueXNtllcQm/4hrdhILauHTlbZD/ahj4CtJ/LsVKLV7e3p6eq0E1Y7golOo14xZyn2P5JLlud3pt6OClf4fj62Vub6xEDIRi9SWx9yb4DUIrPA0zLNnckD6jWzMIqSgnYwuG/zsEMjCN6sMN48u67l8GYNGp9s9Z3FpXZ4HlOTA34NXBFFUae7rz62QD2GcjalvIfl8ym6jOEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=deI050UroHNbtpGA1P++CnNHuR7s61hJHsBJ9cBOpXI=;
 b=jxPx3M/LNxJG2n3sddGD/cYjKJ3FIAyt6NCwDj38UXQ+ErsaZf3pcNkQvK3Jb+FNSiMgRSBS5nShNNuFY6xvn27AnqN6RiuIPtu6BWXhqOOCceobH7MoHcIHRSoj+of5uY8vA4oPGoEn/zQEFtR0h/ZU0NsfHf20mPXJ7bDtFYQ=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB6924.eurprd04.prod.outlook.com (2603:10a6:10:11e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 12:17:43 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 12:17:43 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Conor Dooley <conor@kernel.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v3 2/6] dt-bindings: gpio: vf610: correct i.MX8ULP and
 i.MX93
Thread-Topic: [PATCH v3 2/6] dt-bindings: gpio: vf610: correct i.MX8ULP and
 i.MX93
Thread-Index: AQHZ6gfIwXnML+yFXUyFCKp5zvWymbAh2wIAgAA3BKA=
Date:   Tue, 19 Sep 2023 12:17:43 +0000
Message-ID: <DU0PR04MB941745B5D2316951F31B3B1888FAA@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230918-vf610-gpio-v3-0-ada82a17adc5@nxp.com>
 <20230918-vf610-gpio-v3-2-ada82a17adc5@nxp.com>
 <20230919-b3c77666394588fc74a06d9e@fedora>
In-Reply-To: <20230919-b3c77666394588fc74a06d9e@fedora>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DB8PR04MB6924:EE_
x-ms-office365-filtering-correlation-id: accf3559-8024-4c1f-0a08-08dbb90a6d50
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 36JderrXgGhCHoOZOvS7esRCLODgACBtT+den7IPYXijJNzGM9m5pgMgqHhhHl5ZMVF94NE5FiAx0bB91ejpLyXKmPfETqvkJHu0AOaE8KDajCE6gYInglXJzR+F68osSwn/dQ7pYU4hI0mFcm0S2U7z/wFm25kGVQzPLXdwI82xRmnQJylXaoMjVLHtcY1x6h5f7GSV6Lo4UJ8LxcCMchSqJVsccJMI57OILoE1F0+IF68ByldBdMHTooR9J1NtO8z3EQB08W67IGs/88yiFS/uVBRzH2AI18sQY70CYIvLoX90OD1SwihW//yn8S6am1oUNo+L4GwQ3BTY1hJiJ06LezfRqyIUIR7VltDJc59pa0f3MnN/EAMGxz61NZUX7aZxWfJBC1aOFsGq0HOV6sUXSER832lEjj969D0DakfGQ+596h+kZMpqickkbFe8U5Y3ZWmt/Iko7ZWfqRj2JEmAnjijtg2h2FncTZBLL4XMuUv1I1463V4wTvkAOE9aQuvdRGwWYeyr+evjDAvRfNlW4I3/r1FNWNY83V6MJpiIvg9SxV5bQZ2OSkaNMZ77jdl4VoFW9mSzoF8VD3rBKqXfUeVluDA2aRrb5Z/btr6zYc07sVpErSwKvruUu+UJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(136003)(39860400002)(396003)(451199024)(1800799009)(186009)(52536014)(55016003)(7416002)(76116006)(64756008)(54906003)(316002)(66446008)(66556008)(66476007)(110136005)(122000001)(66946007)(478600001)(38070700005)(38100700002)(2906002)(86362001)(8936002)(41300700001)(8676002)(4326008)(5660300002)(44832011)(7696005)(83380400001)(9686003)(71200400001)(6506007)(26005)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KHN5nB7UynLIE6ILktaDukUzriNITg4rtXlT0lutn3ew7a4AHnS7c1mRzolj?=
 =?us-ascii?Q?w2gc3APtOxgTdom7N02CQEuRrBNcuPaDcRWemY+BnXB/kUAfrxePDz1yhmfe?=
 =?us-ascii?Q?PXX511h3+lAxmExbxSs+y/GYBrzCH2b3gE+kpnvI55SHop+QMG7yDYsQAo5z?=
 =?us-ascii?Q?+lfiMPKsH4XE9xvH4MsjMrNw9wabS12KWYHonpc25F9WAGLv0Pfn6tsEE4yD?=
 =?us-ascii?Q?J9I/ZGEwPBGP7b5N8+WkMD5RLZGcGBf2CNn1A3237/rKfrIi1vIbBNqQZWid?=
 =?us-ascii?Q?fHUzDfvRys+w3pxi7iB3vu7KKlCrPuzq27dciTNylmBuYSNdW3kUaDQSYdNo?=
 =?us-ascii?Q?s83rZ6mhl42AxR2o8WyMVXbAL2YuSN+X+bgHzuygRlVCOZIbCr1TqwYkjUYx?=
 =?us-ascii?Q?fMV+aH308FTW2cii3urXZbBDsxm6brNNq6MzbpQhJybhMYR5pBw0MGkNLfup?=
 =?us-ascii?Q?PNgMB/xfFORvqPCHHrthMznqUQQ8uSccvvctYzK3068m3Dbwe8q/Nur5wRnw?=
 =?us-ascii?Q?q7uDebwlvYyCeW+kPpdOBsSlpdsGVm/nglWs+EZJgFgCzidVoKw3jEAjYmDs?=
 =?us-ascii?Q?HB0M4UIX6mwvpwIa1nByWZFy3Pw05zcB55AJvE/bw8DKXRDWembE9v1Eq9zo?=
 =?us-ascii?Q?W4u+ZapyasYcwmUZXFs9CJMI/pdXlkE9L+cSxGIkiIBZ7U6cn3AyXXAx3786?=
 =?us-ascii?Q?INbMXbhmVJzlKWZ+KAqV64CDVjGndPC3A4fFnqJzp20PDxHa9zVYTcLZFJ3Y?=
 =?us-ascii?Q?toQxqRs2QI37RwcxVtAWcIukXHXaMylAmsaFgnDIa+AEBb1AjPKU6UrmmXwq?=
 =?us-ascii?Q?RD8ae1mlltDTxd1mDPtwLVR4Jy6tnEAd/SSF8ZqnE3S+ph1i0OHOAjM0qqxG?=
 =?us-ascii?Q?CnQX4yib3qxyM4EOqBgfRfAkzq4uu7+r2qXDr6G/DMcMyfRy/y7ELo0TQJhO?=
 =?us-ascii?Q?68TP2zGnOcIK9QRRx1xKUGyGzy4mVjnGSpalgAtnm1jadNNT+WHvHS8OtwHq?=
 =?us-ascii?Q?ks0KirGEy/VTi8zJiT0SJc5stz1QndYuGWp8dVtChMBWVMJ98T5Ag3MwwHfw?=
 =?us-ascii?Q?efMo0vcH2Lyi/cvTaB3vwNuiHB0wEIZDEgnpiotPJS7o7u5/hN3PHley6BMi?=
 =?us-ascii?Q?moQO0JJkFKZK01rn3icBVTbaTsbpacM57DKPAs7/GoZZraHCghs8LutzvRRz?=
 =?us-ascii?Q?pvTQyfMvPa/SZEjFzhDAwRGEQFCRlgAF46hknWyYWp7zID+bkQV1LRMWOexv?=
 =?us-ascii?Q?sdNykMtzG+AxWLu+29RCXkfJvYR42jA6WjWCPUcm9ywKaPDFUjoj34puDRGs?=
 =?us-ascii?Q?NB3gyqrmD5QZ49TsGYdRFvK8QCbJyu+rHfawZC38K/A+WsgXlNJKZcBYvGV0?=
 =?us-ascii?Q?yPToU7p2hD5jG9HDho/bsGdjeLqSlQ1M5XdeSLl/RignSdLteFCPdp67/7mM?=
 =?us-ascii?Q?mpYLXCv2NqvK6BkP2QAjzjdKCobpVilxm/P/HKK4PWStPFf++Sc0F3zpgOBS?=
 =?us-ascii?Q?6ul9WJdhr1d3ZQOOdCKG1GqPxFisNXR1f6H9mBbDCBddO/Nxe+AXx+lWOXUQ?=
 =?us-ascii?Q?/Hdy80vIMfXhZqxjFMc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: accf3559-8024-4c1f-0a08-08dbb90a6d50
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2023 12:17:43.7751
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FYVkoSMpB3udP+B1156lZPnOOMXF7Blfcux2SKNQVNXFW138GBg+FBiM3VGqUbIieP5C022WfPgxbg1yYrG9cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6924
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH v3 2/6] dt-bindings: gpio: vf610: correct i.MX8ULP an=
d
> i.MX93
>=20
> On Mon, Sep 18, 2023 at 04:16:06PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > i.MX8ULP and i.MX93 actually has two interrupts for each gpio
> > controller, one for Trustzone non-secure world, one for secure world.
> >
> > And they has one register based, not two as i.MX7ULP or VF610.
> >
> > Although the Linux Kernel driver gpio-vf610.c could work with
> > fsl,imx7ulp-gpio compatible, it is based on some tricks did in device
> > tree with some offset added to base address.
> >
> > So actually i.MX8ULP/i.MX93 is not compatible with i.MX7ULP.
> >
> > Last, i.MX93 is directly derived from i.MX8ULP, so make i.MX93 GPIO
> > compatible with i.MX8ULP
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  .../devicetree/bindings/gpio/gpio-vf610.yaml       | 36
> +++++++++++++++++++---
> >  1 file changed, 31 insertions(+), 5 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml
> > b/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml
> > index 59427d97adf5..5243b4cf1235 100644
> > --- a/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml
> > +++ b/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml
> > @@ -20,6 +20,7 @@ description: |
> >  properties:
> >    compatible:
> >      oneOf:
> > +      - const: fsl,imx8ulp-gpio
> >        - const: fsl,vf610-gpio
> >        - items:
> >            - const: fsl,imx7ulp-gpio
> > @@ -27,16 +28,17 @@ properties:
> >        - items:
> >            - enum:
> >                - fsl,imx93-gpio
> > -              - fsl,imx8ulp-gpio
> > -          - const: fsl,imx7ulp-gpio
> > +          - const: fsl,imx8ulp-gpio
> >
> >    reg:
> > -    description: The first reg tuple represents the PORT module, the s=
econd
> tuple
> > -      represents the GPIO module.
> > +    minItems: 1
> >      maxItems: 2
> >
> >    interrupts:
> > -    maxItems: 1
> > +    items:
> > +      - description: GPIO Trustzone non-secure interrupt number
> > +      - description: GPIO Trustzone secure interrupt number
> > +    minItems: 1
> >
> >    interrupt-controller: true
> >
> > @@ -78,6 +80,30 @@ required:
> >    - "#gpio-cells"
> >    - gpio-controller
> >
> > +allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - fsl,vf610-gpio
> > +              - fsl,imx7ulp-gpio
> > +    then:
> > +      properties:
> > +        interrupts:
> > +          maxItems: 1
> > +        reg:
> > +          items:
> > +            - description: PORT register base address
> > +            - description: GPIO register base address
> > +    else:
> > +      properties:
> > +        interrupts:
> > +          maxItems: 2
>=20
> Doesn't this default to 2 because there are 2 items in your list of inter=
rupts as
> things stand?

Oh, I should set this as minItems: 2. There are two interrupts.

Thanks,
Peng.

> Otherwise, this seems fine to me, provided the existing platforms are goi=
ng to
> be broken as you implement the software side of this change.
>=20
> Thanks,
> Conor.
>=20
> > +        reg:
> > +          items:
> > +            - description: GPIO register base address
> > +
> >  additionalProperties: false
> >
> >  examples:
> >
> > --
> > 2.37.1
> >

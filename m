Return-Path: <linux-kernel+bounces-2076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47293815790
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 05:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C57A81F25C9B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 04:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DDF10A33;
	Sat, 16 Dec 2023 04:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sYVCXFAn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2080.outbound.protection.outlook.com [40.107.21.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE7313ACA;
	Sat, 16 Dec 2023 04:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R/3Ljg5t5RJi5FA8LvZeEYkXaeUDPc/AXiPyHOUphVnHeb3wtIOiSb7jR3oMU5qDn3qrbVMIQcjHeW9GTfM5PVBMHisQpFSrLbGWCDca0ON28yBMlNpOujsCY7baS1GlFEJJp36MG9H7nQbTMKBTWiHzWAD79KdS4iP00WjSQn+/zOkkFsM61SnVjJvcgCfO7EqfP7ghPlcgcRR97PwVHO6mqYcxsL4aGwcz3nDVurD78tR7oZfqUfQjLcVygS3uZ+Jc0uVsWn4IWTA/3ioXHa157L873nlEBgv4907ro5mTKQpp0gVsx1n2XNx4HRNfx79OGpHtcuIOoAKHTMzN3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o/B5UvwpggWNbSG/AvsjVgcAblMd4aRyRP3sJu8QWG0=;
 b=c5RhZzli5hHYb3T8UBOcbY4/qqnfzuiFwyLRdhMjjBlUm21uNRflXlMjC1xzSGar3YjTQHsJ+bGrgRKt6SPOughviW6slKztaDM03AVCJDHn1CnfKZHn03zYkoCf+xU7Y+wjsWa4SKiUQwE94JFTp+BL4PZOybCFyeikD5djd/S8Yr3/xv0VakyrFxrBo0+HfX34p8nwuhTqYMpIPPzPjBlX+M8S0B447c4/lJM7o5HXUlaIS7l9z9zyXIjEMqLCb6NODTRks/TXPA9bDH0zysgurgPTaQk+uVzeNsua5bLuK6iU866B+nqNyPyFX2K1i+ghquYOJUa088MEQq0Kpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/B5UvwpggWNbSG/AvsjVgcAblMd4aRyRP3sJu8QWG0=;
 b=sYVCXFAnz6UCWi2CtSypxCpvedNC/YzgixsOmQjZLQLAQVNdt716skpQaAZT9q78oMQgKXldzjmB0KwhFqs8FvCDaiKkjRId6x/JuaXweohphIlblAihJgxYvCsPzC0+QqI/HxauNXvLkMkAwAI5WzN6uElKMcQ+1LAIr6dk6Bw=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB6883.eurprd04.prod.outlook.com (2603:10a6:208:17f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.33; Sat, 16 Dec
 2023 04:44:39 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ff06:bbb2:c068:5fb3]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ff06:bbb2:c068:5fb3%7]) with mapi id 15.20.7046.015; Sat, 16 Dec 2023
 04:44:38 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Rob Herring <robh@kernel.org>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: Sudeep Holla <sudeep.holla@arm.com>, Cristian Marussi
	<cristian.marussi@arm.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Oleksii Moisieiev <oleksii_moisieiev@epam.com>, Linus Walleij
	<linus.walleij@linaro.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, dl-linux-imx <linux-imx@nxp.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-gpio@vger.kernel.org"
	<linux-gpio@vger.kernel.org>
Subject: RE: [PATCH 4/7] dt-bindings: firmware: arm,scmi: support pinctrl
 protocol
Thread-Topic: [PATCH 4/7] dt-bindings: firmware: arm,scmi: support pinctrl
 protocol
Thread-Index: AQHaL00vUsuXdEJTYUWYoB3T3FLKXbCqx0MAgACOi2A=
Date: Sat, 16 Dec 2023 04:44:38 +0000
Message-ID:
 <DU0PR04MB94177607820C463B904173DF8892A@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20231215-pinctrl-scmi-v1-0-0fe35e4611f7@nxp.com>
 <20231215-pinctrl-scmi-v1-4-0fe35e4611f7@nxp.com>
 <20231215201148.GA304363-robh@kernel.org>
In-Reply-To: <20231215201148.GA304363-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AM0PR04MB6883:EE_
x-ms-office365-filtering-correlation-id: 72447c2b-2f0f-4162-8724-08dbfdf1b5d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 squhPc9o8ADgbLJiSRSAmLGa8MCIWCn0D4uNFIi/zcH/VTcR+MzCMpKY4C7pdSn8tNUqTqmSiDhzLTvWjSO6s4y6RRdOdU9cDA/7vIq3d6Z8v9cIX32ikYvh2z40BEJUFb+/GYwzwxV/i/vaqVYkH2gq7IzWbn9s5wEGS76ufo65MQVAZnzRwVua2ZYic9qp/pZ/LfNV+o0JrEHheThGsy85gBA0cIn+SFO7XR22voqn2MXSFoDMRdSypUqoWX0ScI0dMtDGLMjOHmKG/Ol+5blj69TCFirmpi7oyGyR+z800HHYvFUrkrqXJeyXCJ9O/ys8P1C8FIZO372olJarQzRW59eLAM7DXgZaWdnjZ96SpxGcxQrmbWYRbgdqGEOymAVPiD4oebBusXUZoK/ixR1Np4To15I9NGaAwQUb+R35ZsKkAd+4WGlSCcMzKkfo97d7hh7aiCLzOHK6Gweew3AuETt4kvJch4BiyeqvnNu5j3iFp6MAqqyIfmjE3g8lHblE0nSJouluWx2OiasTL4tmb2PF+Zpa0iGG4FwFafygLpk3xcNak2gbaPxPTCWyc5CoYYl4Hc5LO8AIhxsbmUnravuKz1TWfoKQNjPXBbyNv52t2LDIjvRUKwYX8TaH
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(136003)(366004)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(71200400001)(26005)(122000001)(38100700002)(4326008)(8676002)(5660300002)(8936002)(44832011)(52536014)(41300700001)(7416002)(2906002)(478600001)(66946007)(316002)(6506007)(7696005)(9686003)(54906003)(64756008)(66446008)(66476007)(66556008)(76116006)(110136005)(33656002)(86362001)(38070700009)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?w4jNGk9Vd6+SlxcXN3wmGzpnBTMA0tCSn29QzggvSG5sEtiGZY9ZKX4alHBO?=
 =?us-ascii?Q?Q7OFugTTtFnKsS7LLwE8SBCkp/MCjxKdNDa/zCTbBzen6GVhbuuy+TB/YsVC?=
 =?us-ascii?Q?R6Sa/zyaj7K9XpuOAOGJwszenOLDETe5dBK5KIGr3GtKhTpR1rqKM/PIMffG?=
 =?us-ascii?Q?YjH6xHWcXzUMk7ine3dmMtLyYkQ4UTPTFtgzFBLpVhpRhdTseUdWB/UGVHJD?=
 =?us-ascii?Q?kM3NZ1fUMSeExgoQOaq/R0iy5fOXZ9hzVil7FUWuTmVoOBwkFn8VhO4GXKGl?=
 =?us-ascii?Q?vDJfP3G0W2mwC7dlxkciLjBiFD5h/XFgLRvkOybIXKpXdHtZsnPH2YQj88rk?=
 =?us-ascii?Q?9gRCQr0d9/LhNeRw1qgMuGNNSCG2FT3RLnLW4p/cdHPrBXS4rW3octvxzgcz?=
 =?us-ascii?Q?DbBXNbptZdOrcLKoXrIVDJ5SrH+i+DBR/dWk1Tm7qsHCPCvekSWtoTn2qNqJ?=
 =?us-ascii?Q?zO4Ie/vonaG+NC7/Pp9J+X0wsWlcrfGOVhmlf/Z95oZUTA0z8xpCDbvWey6q?=
 =?us-ascii?Q?QfZlKRTpv2j94dvhh08me8v7uxl+/icOZZfwpSL4REJec0pptP4NzIHjWarI?=
 =?us-ascii?Q?TXOlDmpvnoF+85FaQdU0PG1JG+hGaiZuESd4cb/yXk/Lisb9nr6ke0KEm0Qs?=
 =?us-ascii?Q?CpIRoK7C/jdGUlhF3U9SppgcibvPVuh1DqH1LMESvROf4kKW/MohVUiJhzci?=
 =?us-ascii?Q?6kr/khPA/uUB6EJ5oEjMMvB/mk0SV8QwaI4Rj11SZDgAp5VOO+8W+RZtbs84?=
 =?us-ascii?Q?pSLDHfpcvApCNP4vXW0DPBaoNbiAwRfcxGrXd2kOdjAswISw1YB8VnHpaaM/?=
 =?us-ascii?Q?n8nyvR0V8ksm7miPOzqtAUupo8KdXrVQkiMCTanaGmzR+GxSEegQwiPcnlou?=
 =?us-ascii?Q?DwZprwAchzW3JMLNKDE2g2pTwwMP1zZGF5O/rvrLfrdaGCnUSFJCFTsMUjlv?=
 =?us-ascii?Q?qPXZUXMpxnkvQvFiR8f04c1p/kTGLREG91ofzpVB74RlJLjU2rP/vGPjq9UN?=
 =?us-ascii?Q?iKPEDPjVHcJhUtiXMuw4KmYnZUbAK7w+n+Tj974aTSnzvM88qb/hLuo+P/2y?=
 =?us-ascii?Q?s9OwfLBwBkln41hb3G7ZApE6ZGe8MZ8zOtIUaLDVJSi/HAQZaFP+uDq3ay69?=
 =?us-ascii?Q?qMFNtliYJkxoKkNV+cpbZ+44Ht61BMjLGHQMInd6rGF4hOAfer7bCDKImtU+?=
 =?us-ascii?Q?1NGaxl/UAkBg2fAUESBrodDEA3+bSA8/Mcq6HfFemqF1Rd4704bJpKzyDjIy?=
 =?us-ascii?Q?Cw7dkG40aWjsbH/TEn6TLQYXGL2F+clBU06bOfnA4/IxfIDmCVLBEMNWZO1S?=
 =?us-ascii?Q?qVxsKzzmv1CvnShW0dgA+CUOvDu5C7hm6tUx4n8PDpMilhwVY6ws//iytrZ6?=
 =?us-ascii?Q?4HOkyCVGZUDsJifA9bK+KB3eslzOE4FpNptLI5IfrPMtvL/ViUiLPunv+v7U?=
 =?us-ascii?Q?etjHpxeRu7z9XCkIQv4AeRJEd4GH48K+CVrJOmgOv3oOLIGcUVwgBhTkR/rD?=
 =?us-ascii?Q?/ckqVCN2LcvdthN3KAaeyGmqIC0sxayqEOyiyriBtW27dnAgRTW7EmAuV0q2?=
 =?us-ascii?Q?fYUeooE+NiiEh44TrQc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72447c2b-2f0f-4162-8724-08dbfdf1b5d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2023 04:44:38.2308
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X6/LwSeTR3PtpFAlAG5rZUYEpWmifgFNE9z5vn7S+ybFEnBd5dq2lWugvbGyf8o7og7Qdx8XzcclP3f9ylIFiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6883

Hi Rob,

> Subject: Re: [PATCH 4/7] dt-bindings: firmware: arm,scmi: support pinctrl
> protocol
>=20
> On Fri, Dec 15, 2023 at 07:56:32PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Add SCMI v3.2 pinctrl protocol bindings and example.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  .../devicetree/bindings/firmware/arm,scmi.yaml     | 99
> ++++++++++++++++++++++
> >  1 file changed, 99 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > index 4591523b51a0..bfd2b6a89979 100644
> > --- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > +++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > @@ -247,6 +247,85 @@ properties:
> >        reg:
> >          const: 0x18
> >
> > +  protocol@19:
> > +    type: object
> > +    allOf:
> > +      - $ref: '#/$defs/protocol-node'
> > +      - $ref: /schemas/pinctrl/pinctrl.yaml
> > +      - if:
> > +          properties:
> > +            compatible:
> > +              const: fsl,imx95-scmi-pinctrl
> > +        then:
> > +          patternProperties:
> > +            "grp$": false
> > +            "-pins$": true
> > +        else:
> > +          patternProperties:
> > +            "grp$": false
> > +            "-pins$": true
> > +    unevaluatedProperties: false
>=20
> This will not scale if each vendor adds to arm,scmi.yaml. You need to mov=
e
> this to its own file. That can have a ref to
> /schemas/firmware/arm,scmi.yaml#/$defs/protocol-node.
>=20
> Here you can just say compatible is "fsl,imx95-scmi-pinctrl" and
> 'additionalProperties: true'.

Do you have an example for this? I am not able write a correct
one to pass the dt check.
      - if:                                                                =
                        =20
          properties:                                                      =
                        =20
            compatible:                                                    =
                        =20
              const: fsl,imx95-scmi-pinctrl                                =
                        =20
        then:                                                              =
                        =20
          properties:                                                      =
                        =20
            additionalProperties: true

.......
      compatible: true

And in fsl,imx95-scmi-pinctrl.yaml

allOf:                                                                     =
                        =20
  - $ref: '/schemas/firmware/arm,scmi.yaml#/$defs/protocol-node'           =
                        =20
                                                                           =
                        =20
properties:                                                                =
                        =20
  reg:                                                                     =
                        =20
    const: 0x19                                                            =
                        =20
                                                                           =
                        =20
  compatible:                                                              =
                        =20
    const: fsl,imx95-scmi-pinctrl                                          =
                        =20
                                                                           =
                        =20
patternProperties:                                                         =
                        =20
  'grp$':                                                                  =
                        =20
    type: object                                                           =
                        =20
    description:                                                           =
                        =20
      Pinctrl node's client devices use subnodes for desired pin configurat=
ion.                    =20
      Client device subnodes use below standard properties.                =
                        =20
                                                                           =
                        =20
    properties:                                                            =
                        =20
      fsl,pins:                                                            =
                        =20
        description:     =20

.....
>=20
> > +
> > +    properties:
> > +      reg:
> > +        const: 0x19
> > +
> > +      '#pinctrl-cells':
> > +        const: 0
>=20
> Generally not used if 0.

Will drop this property.

>=20
> > +
> > +      compatible:
> > +        const: fsl,imx95-scmi-pinctrl
> > +
> > +    patternProperties:
> > +      '-pins$':
> > +        type: object
> > +        allOf:
> > +          - $ref: /schemas/pinctrl/pincfg-node.yaml#
> > +          - $ref: /schemas/pinctrl/pinmux-node.yaml#
> > +        unevaluatedProperties: false
> > +
> > +        description:
> > +          A pin multiplexing sub-node describe how to configure a
> > +          set of pins is some desired function.
> > +          A single sub-node may define several pin configurations.
> > +          This sub-node is using default pinctrl bindings to configure
> > +          pin multiplexing and using SCMI protocol to apply specified
> > +          configuration using SCMI protocol.
> > +
> > +      'grp$':
> > +        type: object
> > +        description:
> > +          Pinctrl node's client devices use subnodes for desired pin
> configuration.
> > +          Client device subnodes use below standard properties.
> > +
> > +        properties:
> > +          fsl,pins:
> > +            description:
> > +              each entry consists of 6 integers and represents the mux=
 and
> config
> > +              setting for one pin. The first 5 integers <mux_reg conf_=
reg
> input_reg
> > +              mux_val input_val> are specified using a PIN_FUNC_ID mac=
ro,
> which can
> > +              be found in <arch/arm64/boot/dts/freescale/imx95-pinfunc=
.h>.
> The last
> > +              integer CONFIG is the pad setting value like pull-up on =
this pin.
> Please
> > +              refer to i.MX95 Plus Reference Manual for detailed CONFI=
G
> settings.
> > +            $ref: /schemas/types.yaml#/definitions/uint32-matrix
> > +            items:
> > +              items:
> > +                - description: |
> > +                    "mux_reg" indicates the offset of mux register.
> > +                - description: |
> > +                    "conf_reg" indicates the offset of pad configurati=
on register.
> > +                - description: |
> > +                    "input_reg" indicates the offset of select input r=
egister.
> > +                - description: |
> > +                    "mux_val" indicates the mux value to be applied.
> > +                - description: |
> > +                    "input_val" indicates the select input value to be=
 applied.
> > +                - description: |
> > +                    "pad_setting" indicates the pad configuration valu=
e to be
> applied.
> > +
> > +    required:
> > +      - reg
> > +
> >  additionalProperties: false
> >
> >  $defs:
> > @@ -401,6 +480,26 @@ examples:
> >              scmi_powercap: protocol@18 {
> >                  reg =3D <0x18>;
> >              };
> > +
> > +            scmi_pinctrl: protocol@19 {
> > +                reg =3D <0x19>;
> > +                #pinctrl-cells =3D <0>;
>=20
> Missing compatible. Schema should catch that...

Only i.MX need compatible here.

Thanks,
Peng.

>=20
> > +
> > +                i2c2-pins {
> > +                    groups =3D "i2c2_a", "i2c2_b";
> > +                    function =3D "i2c2";
> > +                };
> > +
> > +                mdio-pins {
> > +                    groups =3D "avb_mdio";
> > +                    drive-strength =3D <24>;
> > +                };
> > +
> > +                keys_pins: keys-pins {
> > +                    pins =3D "GP_5_17", "GP_5_20", "GP_5_22", "GP_2_1"=
;
> > +                    bias-pull-up;
> > +                };
> > +            };
> >          };
> >      };
> >
> >
> > --
> > 2.37.1
> >


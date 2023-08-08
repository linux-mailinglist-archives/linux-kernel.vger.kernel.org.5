Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF297749E8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233689AbjHHUGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233530AbjHHUFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:05:47 -0400
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com [148.163.137.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319621194C;
        Tue,  8 Aug 2023 11:25:56 -0700 (PDT)
Received: from pps.filterd (m0174681.ppops.net [127.0.0.1])
        by mx0b-0039f301.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 378E6hV0002285;
        Tue, 8 Aug 2023 18:25:39 GMT
Received: from eur02-db5-obe.outbound.protection.outlook.com (mail-db5eur02lp2104.outbound.protection.outlook.com [104.47.11.104])
        by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3sbknk2902-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Aug 2023 18:25:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LHGpC6+zThipRjLw4v9JdByWgixYNAKjrmUR1498xT1wo5Ni46/mscIbmWFCB1cegzaSorwfi/WHEJ+x1WXm5WwYGV5/1e5wP9stg80WGeiYUiGk6JvDP3drsTHRRG0P01ORrKAluAWGxLRi7jtfHpipkbSVeS0c8EBZC/Nx7bkQnSMfbi2xvReUjvp4tRAhAeeiAGLVX0cFKGNeOYIhFtC86cilx73O/bcC4xsask5uvW61ZvP4B9hDPeyRZErtMZOEgGLhCL9RyvIYbaT9DBkk8uFQDHw/B9ToxuLhneHIbJUIlBE6xKfVcMikXWBfumMdgbQ1beidKHNxh1zEXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sqS/pUjPpEVLV51qYi6Phg2ZHA1nXvh5Cg65k9pOJy8=;
 b=iDXhPSMMtUM/xvkAwCda1bUxdm6p2bC0mxoIXsLy2d2e4c0M0EiLcnGom0DTD0NxwtfHxsvXcRq3GuRlGGlblgQPEjBwUZibBYr4gA0003ypl4kWNe7AxgJz54a6bfRjhGO9weOy9GdQypthFMmBFNWHOFvL/mMRxe53QQ9kGPCAY6/n7Wbdccx2hdvNwFM3xS+nPHf2IzhKIFsPxT4frCZ6293eXysnVJ7TPeEB4QRXBYx4EfeCPHO7vouaXvRBSI47h+pJoqg3AMJbSSmJjKTvcOY2zcewB2goSqN/unFk90oHGRss31gzbVsyysbWpz5P52AJnOntzrdI3D7XtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sqS/pUjPpEVLV51qYi6Phg2ZHA1nXvh5Cg65k9pOJy8=;
 b=EnzxwfoFbsVHscA4AAY4u5gLhAbwuQsg/ihamJ3B031QFoihAzhgUeBkgjHbF0ze3DlWfHkM0xb7qeQkPdC/aMcm/Ql2Cg8CWnNmL48R+S093Mq2y4pstUPm1ekoaPpOGIucr2gUk1L0WVA0atItR4wRdQiaiJMVmIALszuyf/6A1gQdKNwUp9OqOu9EXBFOHea17LTbRLqnlgFrSFQTB3ndEFqxS4+bSQEJBBnhhQ2/36J8uZybPF2hlfV1n8lzuOwcWJ7YaBB4WYeHWJrDJg+49Ao7XTq9J6tOVyID3m8jG45qKE9va6MFUaG5LXXDwhY4FcwgpjCCFLZvVqspfQ==
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com (2603:10a6:102:ea::23)
 by AS1PR03MB8151.eurprd03.prod.outlook.com (2603:10a6:20b:4c5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 18:25:36 +0000
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::ccb5:5aee:f10d:ab26]) by PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::ccb5:5aee:f10d:ab26%4]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 18:25:36 +0000
From:   Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To:     "sudeep.holla@arm.com" <sudeep.holla@arm.com>
CC:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: [PATCH v4 4/4] dt-bindings: firmware: arm,scmi: Add support for
 pinctrl protocol
Thread-Topic: [PATCH v4 4/4] dt-bindings: firmware: arm,scmi: Add support for
 pinctrl protocol
Thread-Index: AQHZyiW58zfrIydQN0ew8q6pi6gRRQ==
Date:   Tue, 8 Aug 2023 18:25:36 +0000
Message-ID: <1dcf25b5c6b16b7138534e3c13827287f7c644cf.1691518314.git.oleksii_moisieiev@epam.com>
References: <cover.1691518313.git.oleksii_moisieiev@epam.com>
In-Reply-To: <cover.1691518313.git.oleksii_moisieiev@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR03MB7136:EE_|AS1PR03MB8151:EE_
x-ms-office365-filtering-correlation-id: 0e90bda9-000d-4c78-0461-08db983cdc32
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qh6egbmjtu6LJc4zrZ6ZLXWnjJgykdyMNmu/OOEQMPskC9mQpsWOXsOfpiRZHnmxDLsOAuRk18y7/TZMF0W0HXEvCcClvZwj5Jd+Cf3KqLg/MGLi6807Yp//2Ow9pCLalj3yzAw//SkUSmCKMimb4r2/shfyMJ1cSsvBdyrQxg5b2EdPOdDQQu5rtC2u0IH5oYw9Mela5ijRpw5o9QKPpYOI+BW+9dkr4fP5sDtSvkvI66d3hb2B2L0iprzGqBAFkzOPw4T+Vc7j7tjmgAdEKI58t+OGUhe7RihB9LpgTJx4I5EIxQHiySg5bCWErTR1srVEWdPfanb46HrSO01DIkry4yI5SXOp0Zjsf/cknSSHF5m6aKAjSlGS0dxHN2tOACBpLk0nXMrXbay56U6bKMV/BhSG78HxJsbgORwtdNzyfKPa6Sw874o6WvxIDZshzUnqhkI4thlaEzBh6tOgN2YnMFllpmbaGj5Y1kmzvas9j3zmiGXZN0GO11tIdx5XczafDJOEJyJnfWind5DlDTDqqSXVFufpey/LSyEU8jiC9+5edz32IdyUquLiQy1wh5iv41BvbAH0QzsSVsJYjr8NUm983acY1FcHTEzOrObidu0FzUyX/IA36XzBQ3mO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7136.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(1800799003)(186006)(451199021)(2616005)(6506007)(26005)(6512007)(71200400001)(6486002)(36756003)(122000001)(478600001)(54906003)(38100700002)(66476007)(66946007)(66556008)(66446008)(91956017)(76116006)(64756008)(4326008)(6916009)(316002)(41300700001)(8676002)(8936002)(5660300002)(38070700005)(7416002)(2906002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?wSfnDCz2poAL1d4ErvHy953PfjBXEh2qh33Vr8hs3hjHQmTOOLMpqeJBp2?=
 =?iso-8859-1?Q?FQipmAowFaE0Okojm6+OzmJnpj/pqUlW+ewgKIiOgog9Ucesrcvmp7n0hh?=
 =?iso-8859-1?Q?nNGw+GL40cQFIMZTLQsBjrtf9DaeK+hTVlYi9/q4IWinCOYImSjHrkFUqp?=
 =?iso-8859-1?Q?6qXpUwYvnBgOmAl4Scc15ZmbuczzOXoRtDk581KxXEiKVPLb3a0tiElBPN?=
 =?iso-8859-1?Q?aP/qxb6iHFeNBXDHutmK0S9XboOAVYmb6ApO48i/M0jbZw90S5OQ2h/G1h?=
 =?iso-8859-1?Q?f1/yhdfURytpQVp+hm8mev34RySKSzoYfvkmbdYcCqUKiwUp9a5ICWx2nv?=
 =?iso-8859-1?Q?ad+U0FZfwMLEKCoOuZuq8QF9OyJmTUPCRY938V3F/6n5KNqnCsujQfG6r7?=
 =?iso-8859-1?Q?v+eYm+cGwBPVRcv84R1cZ6PEqtwT5hlgt60OR/+nLpAB4200onQqxPScqx?=
 =?iso-8859-1?Q?6t7musVBe2/bQrRkSns+m1MEbHu5BgBSjlPjyx2u4/tkP5nwJNuVZjYZCh?=
 =?iso-8859-1?Q?qLchyjIUuvV8PtMaPbPW/E3vsgMqSaSNm7Rm+y80ibNMWnu+Nr6FRBJamX?=
 =?iso-8859-1?Q?lXJX08Urwq9kPW+oqoNjArCkMVm9nl2/P7n4NsHN8D4S3UjzgQbkkAMMsT?=
 =?iso-8859-1?Q?D8sZTk67o4UPVAQ8rV4bjXwHes2YLSI0CfBXCvk8fqDVZAL4vI3h5T6ZVq?=
 =?iso-8859-1?Q?AnHlDQ+egD5IgSyf2djPXpepUGH2wLNQdt7SzpGMbOhbneyUBZmk1kw8UT?=
 =?iso-8859-1?Q?XESDeGDMA6lFvIePFjJr69WhZsI/faEx+rEb4g9u3qU62HMIuIyp78+UHc?=
 =?iso-8859-1?Q?uSEbUZ5GkePzIPCwk05klcpnnhI7XwOb48F3LOm64EVq1O4/C+Po02BDTV?=
 =?iso-8859-1?Q?fUZWxrgBLyQ11byCgDtmNNqs7f82tNcT93dDgMxu/LzPWu6kmM3plS4qqQ?=
 =?iso-8859-1?Q?lX0/m0o3fQKaIHNORIW+OpPNYmCs33IUmAXEqbjyZBXXkmNxLu3BejxmmY?=
 =?iso-8859-1?Q?BMujP51SDwB/3ybrxc2kWebEjCat+u0Jf4QkAMkG1XuHcdJXVIDpqvfOIY?=
 =?iso-8859-1?Q?YMZncUd9G/+pHa2DEgR0M8Nc9T41+3VyH7SbfS5G/JF8qGje3ddL/jCIwh?=
 =?iso-8859-1?Q?w8cwp6pi+2GrX746PnCiMK5TyHEQ0wyRyZbCDHFNyzG+m+azCrRlR1UciD?=
 =?iso-8859-1?Q?SYoDGMBNUy8aRvMi4/FniAx5U3ztPgw5VsaZrp2iN7dmpyQFuAV+TpTwyE?=
 =?iso-8859-1?Q?+J2Mm6sj4oeUqW2D/h0bUV291dKzq6G/lJwhVlJqz+w5HlLnKxGEaZwel7?=
 =?iso-8859-1?Q?d4b4y5EZcxmy0Yhjjhi51ly6SQkkbiZUV9ILCx+9pwMiVGtMvTrXMszCfc?=
 =?iso-8859-1?Q?iu8s7tHqp4Rh1fR4r6tV4wO5SOZZaDZ7GqrJJ4Csv4R5+UF4/sjZxXoTuH?=
 =?iso-8859-1?Q?gnlfCenZ//bZm3MBE8hF943NWfPM7GAZXNbQI+VwrfVf0HmuxRmX6pv+eR?=
 =?iso-8859-1?Q?Lu/V7XNsTdOW1fXJwxafoqHOZBvleChwmpJZnNVIFFrie+MOSxOkxM08xq?=
 =?iso-8859-1?Q?lMS1AclttapzNq76kGMpiOvhNO/4Hzsd4S03eK+SaK1wRyY+hVGzx06XgA?=
 =?iso-8859-1?Q?O3fBO1IrF/q5Yu5nZL3WygpFUyZa5X9ecT1o38aA5M002pVnA3jJ2G+Q?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7136.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e90bda9-000d-4c78-0461-08db983cdc32
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2023 18:25:36.2462
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QtjjaAMWTFWP7ShPdGFf+SZv44HZ8QfErgj7wTqXsPyVGzZ3JB2Y2NQwsbsu1UthOiD6X5FeQWNp+pZH46Oo1ukVVcoY9U+4BVTbuF9wAmo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR03MB8151
X-Proofpoint-GUID: A4k1w-RHrJqVYQQHTo7eoat-HVZ23Xcd
X-Proofpoint-ORIG-GUID: A4k1w-RHrJqVYQQHTo7eoat-HVZ23Xcd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-08_15,2023-08-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1011
 priorityscore=1501 mlxscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308080163
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new SCMI v3.2 pinctrl protocol bindings definitions and example.

Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>

---
Changes v3 -> v4
  - reworked protocol@19 format
---
 .../bindings/firmware/arm,scmi.yaml           | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Doc=
umentation/devicetree/bindings/firmware/arm,scmi.yaml
index 5824c43e9893..5318fe72354e 100644
--- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
+++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
@@ -233,6 +233,39 @@ properties:
       reg:
         const: 0x18
=20
+  protocol@19:
+    type: object
+    allOf:
+      - $ref: "#/$defs/protocol-node"
+      - $ref: "../pinctrl/pinctrl.yaml"
+    unevaluatedProperties: false
+
+    properties:
+      reg:
+        const: 0x19
+
+      '#pinctrl-cells':
+        const: 0
+
+    patternProperties:
+      '-pins$':
+        type: object
+        allOf:
+          - $ref: "../pinctrl/pincfg-node.yaml#"
+          - $ref: "../pinctrl/pinmux-node.yaml#"
+        unevaluatedProperties: false
+
+        description:
+          A pin multiplexing sub-node describe how to configure a
+          set of pins is some desired function.
+          A single sub-node may define several pin configurations.
+          This sub-node is using default pinctrl bindings to configure
+          pin multiplexing and using SCMI protocol to apply specified
+          configuration using SCMI protocol.
+
+    required:
+      - reg
+
 additionalProperties: false
=20
 $defs:
@@ -384,6 +417,26 @@ examples:
             scmi_powercap: protocol@18 {
                 reg =3D <0x18>;
             };
+
+            scmi_pinctrl: protocol@19 {
+                reg =3D <0x19>;
+                #pinctrl-cells =3D <0>;
+
+                i2c2-pins {
+                    groups =3D "i2c2_a", "i2c2_b";
+                    function =3D "i2c2";
+                };
+
+                mdio-pins {
+                    groups =3D "avb_mdio";
+                    drive-strength =3D <24>;
+                };
+
+                keys_pins: keys-pins {
+                    pins =3D "GP_5_17", "GP_5_20", "GP_5_22", "GP_2_1";
+                    bias-pull-up;
+                };
+            };
         };
     };
=20
--=20
2.25.1

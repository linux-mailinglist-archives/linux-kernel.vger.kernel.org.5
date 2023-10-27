Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7971B7D8EB1
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 08:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345248AbjJ0G2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 02:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234917AbjJ0G2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 02:28:37 -0400
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com [148.163.137.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC1E1B3;
        Thu, 26 Oct 2023 23:28:34 -0700 (PDT)
Received: from pps.filterd (m0174681.ppops.net [127.0.0.1])
        by mx0b-0039f301.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39QL6OQR007652;
        Fri, 27 Oct 2023 06:28:17 GMT
Received: from eur04-he1-obe.outbound.protection.outlook.com (mail-he1eur04lp2050.outbound.protection.outlook.com [104.47.13.50])
        by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3tywqm92ds-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Oct 2023 06:28:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CTZtOfn/K3Upb3PyYNhM+r/1fErsyufRwBZWpXiu1Uw12rDkVJ1VjwJzse0213UpPuvnUrS79QTUt8Bg4/vsZHwCJ/B6ztLvcQhq6v4LtFJNCM4OrPPAelWMaR64H36wkpefusO66Eito5K5D8XEu2lIh2cWCwBlxasYOJQkiObbFxNalLf41sfyMyiO/tUfUGfrlEATyghIO3pAyLROesw1tsTvXX8PT5fcPSgB6YNrFGECgeZO/JjkE8HVvbbls0OPOwckeKcktANvHnVk5EH4XaLMTPaadN3Fr2bZ0T/sCcLfkQBZt4/1RWKt0TOGUcttJjBA3T9iHFLWrehbsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sqS/pUjPpEVLV51qYi6Phg2ZHA1nXvh5Cg65k9pOJy8=;
 b=UT3IV1iA9ylzq+V7AHEV8X9qfDrNvDi3sgUJ0kxUKQoK4vPqUMe9AwwuXneWl2CXJ2a/4WZUqAo5/hbzLGXp77U71+eW9NFvjFUzd3MOyiUxSoIxLcHWU1GUpiuUF3ZMBW/KtxIWcMcxbxaKl7w+GOgadPXB8dd5NNRMdg+UEUPVPKZ0gbmmnm2D94NXzU+azgFxvDN8TNGjf77j4HCkfqWBxUWeCcd1QTvF41IskJjwGapajokspRFyIhSO8oJBq/5TkMw12WWZdAQ2EZ8IbvfZ0WyzQma5flLOGRtmEW1GOzzsbrxMzcm61K4HeK2X1WMNVjwtSoh5D2Zq56uBmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sqS/pUjPpEVLV51qYi6Phg2ZHA1nXvh5Cg65k9pOJy8=;
 b=W3KhZCyquzzTHy/VRPnP+9MFM7HDHpBz+Z7nFQjh6jcHwWh65mzYSq2rC93A30K48Gz8wofwCjVVcg72wkJZ5dfbo00LLiPwz/s6f2HD3yJkU23iGxzjcPup8V3oWKuMOwJLZ7DPcEVHAN6Sf3juwzIoubyysEWzIIM1bxJ/HYiSxI9U1der9Dz1Q+x7qXq6/5KKy/+Qzx4aHq0P6nVEX0LvIIM9eVyV6wFpKVWXzEhZts2+rVp3BgcqqoWlHWjCvUqe+27gCyPwDL42v+hR2fLiL6H0nAxshcEv9oqbpf/FKjmfcOPDxAEVnNuycjjNmgT5oxx9qjtugbZLKir6wg==
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com (2603:10a6:102:ea::23)
 by GV2PR03MB8876.eurprd03.prod.outlook.com (2603:10a6:150:c0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.23; Fri, 27 Oct
 2023 06:28:11 +0000
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::2211:9053:228e:4e40]) by PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::2211:9053:228e:4e40%3]) with mapi id 15.20.6933.022; Fri, 27 Oct 2023
 06:28:11 +0000
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
Subject: [RFC v5 5/5] dt-bindings: firmware: arm,scmi: Add support for pinctrl
 protocol
Thread-Topic: [RFC v5 5/5] dt-bindings: firmware: arm,scmi: Add support for
 pinctrl protocol
Thread-Index: AQHaCJ7CNWHZc0R0IUas1KWQRTDeQw==
Date:   Fri, 27 Oct 2023 06:28:11 +0000
Message-ID: <e9285b4377242e4d888391be987cbb99caf8c573.1698353854.git.oleksii_moisieiev@epam.com>
References: <cover.1698353854.git.oleksii_moisieiev@epam.com>
In-Reply-To: <cover.1698353854.git.oleksii_moisieiev@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR03MB7136:EE_|GV2PR03MB8876:EE_
x-ms-office365-filtering-correlation-id: 577086e1-406b-4be6-5fcd-08dbd6b5e490
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fzszHZeY9DfXxv03C4j84o1yiU5+1kLXRdEq8dJfnWL4p9Obfs9fB69PdJmBgck1wMEt64Wl0IETodU+ZRjG1NWo0K8wRM4Nfw0b2n3iYWVVRBl96I+oKpJVuiwQ8RxR+N7vC11A3zs2cq+OYvyQ4MYBF7sO86QI6ql9LMPVy8R67vzGgKMpP2CmeEF8kHECRSNeMTfd6nG3t9ovZKSElrHCk0kR0p+ovJUA0H+q68M8WTX/cthgxxSbNIcVN/ey2YnX2iXvY3B3ZopfaG1TcQX8jq6nlBV0fjTiaBV9kuDD79U829G1XM6NqhQtJ/lQpqAEfPduER2l2msI9kFniRPmMEI5qACRZkZO8SOIpROdOW1RMEehnrW7smutDjBvWVT5gpeRWRsFlkqy9zb8mySUtP/ECZHFNLDf7rR92gRRVAZt0PmaPar1ZbnYWuDj1JquBeZUVDvd84tXOA2to91+ZrKnUbg8fnq6Cce8SKtitB9nUsiR4qUDZCl1jKRte42ig2pXrhKYxiF2IhllubvROhNNq5X1R39dvpj20F5w0NZ64QkUSU+AQknQ5QB8BEKrnfWsnriPx+GFX5liDcmGdNw9PYmcvExvLudzngch8ezCrVLZHdxGbyvdc2FA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7136.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(396003)(346002)(366004)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(2906002)(478600001)(6486002)(36756003)(86362001)(8936002)(7416002)(4326008)(8676002)(26005)(5660300002)(38070700009)(41300700001)(2616005)(66476007)(66556008)(66446008)(64756008)(66946007)(54906003)(91956017)(6916009)(316002)(76116006)(38100700002)(6512007)(122000001)(71200400001)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?OsK5GtJvzI9Tst3cplm2SQELgmbgkjgVuDONXkOYutPvFHC8/MllV5JIFD?=
 =?iso-8859-1?Q?4vPH8mYI9iFhEdUhrKAFFgKdX9Uk4p5Q/B32yeqfREjzosixyvv6jfEFg3?=
 =?iso-8859-1?Q?gqmo2MJ1BD6nG/SvIG3HMOheCsB6HK5dXr3Nhkw8nG/i/HBtz4Xooas95d?=
 =?iso-8859-1?Q?ouDMn3jfNXvn29QKN64BUjWzquI5ni/E7T2zEg3aHkzf0Nh9Qtsbknx/RV?=
 =?iso-8859-1?Q?LTYxTHYLp6zJqJYzSO6IZhRhlgGOsLBYBpPwzCWLhHgvSNQTl/X2dLaLn1?=
 =?iso-8859-1?Q?DbtxcAk5Oqiw2pulOFj/cUsMAt2OCanLtB0cldaFColN4TmWvGcLsr0X+q?=
 =?iso-8859-1?Q?uvgEwBYO4Ks4BQwgYR1VmnXeT7VjGV/SaqZIhOICmqXjGYN0sFqDl6+pXp?=
 =?iso-8859-1?Q?9OJs3YXncHbuavew1snxY4FJDmO4e4S5PC49AJPD3MNM+l+m+JA8O7ivJK?=
 =?iso-8859-1?Q?7LF09c5Pbrn8bQ7KVEFwjxx2KEC0cpNoiZQRvMuvz341Vpp8yHcNBzd55O?=
 =?iso-8859-1?Q?O+K0U8Tzh1GQO7npKvSj7VdwTXBF82JthaQ5x7Ar6QcTMtcAr4AfgUS8in?=
 =?iso-8859-1?Q?EiUQe11QNH+MbcOKkKenvnl4ZsN2lmARt/zdKs/Fsmphv7HannLOHJCiZD?=
 =?iso-8859-1?Q?0tT2bbdD3Vg7CXZhDu9zPPJmpDlOGrgyrs731acTbP+p6RkNC63pfMjiu9?=
 =?iso-8859-1?Q?H5JUKEXK+G1xqsQGFuPO5gcS0MLEAvj9gxIhT/GEBH6Z2srIcDtQW8Zj59?=
 =?iso-8859-1?Q?Tf4D5VWd6A0euSZrc5ynX6U6B55lIeGSvmLPPFKRNfkBxz03h1pHZXQ26u?=
 =?iso-8859-1?Q?6TEtbPnQdlOJ1xdEZxYOiaPDxItpo1cJKrk5sul++SNKhFc9SLYOKa6ijM?=
 =?iso-8859-1?Q?FiIRqYezKbpFnhjg9SFdwRe+bVFCfjT/BR0RDU0dAt4kNtn1q1J6TXpHLj?=
 =?iso-8859-1?Q?GFub/YwCbk2Auvxaz+JarlcVqVtlCTG/bxHdnASnqIsxII0OarCrf3hBkH?=
 =?iso-8859-1?Q?A/xyASAXtr8v9ZJQabU9F5h9QUij6lK79TfncHTxAUiwNzk1dxyTjeoUer?=
 =?iso-8859-1?Q?wzV8uKI1wGIDwhPVpHu05CGlYneKB961mDl1zeQM3JuEWDHQXpcPYdiist?=
 =?iso-8859-1?Q?RRBaJ+ls9+8QPuc15yyZS7JjsmsXkjpHUzUH0QbGHJJkoJhg8W7K0Isc+G?=
 =?iso-8859-1?Q?zuMlt09teoFxVenzifemma7hG8m8GLU+Dyj6PGDR4UjgTFXe/UHXW3/ChH?=
 =?iso-8859-1?Q?SuiTFBuf1oWx9GVSln+UYhEtsSf2ptSn/Iqno61DFJC4+p50YeIEqtZ9Pi?=
 =?iso-8859-1?Q?v+sqwEaD0sXt/o3QTOc05lmlKDLYYYtBmOgVjcieNU4pxASqxilcq23PHf?=
 =?iso-8859-1?Q?K86eOadJlx+ZETsDnyNbKewcakcsJn+7qP7UdjqKXySuYY0a/MiVEpnc5w?=
 =?iso-8859-1?Q?od5hcabTpiLDiEY84hLGwArQvxskjPY4pk7zmIJiDIbMBXFPnN2qyekDyw?=
 =?iso-8859-1?Q?h+XPwI8iWxWlsT1zP3xtChw0l1Bqp5kPdEg5nynNv5uo8vLvAMjc6ed6UD?=
 =?iso-8859-1?Q?s5gvClziizoVU3EMtmKj5PMslzK/iNFTbjtY/HM1lwfLLOVZJUUi1lBkqA?=
 =?iso-8859-1?Q?lRDkTn7dPGZ74lfRK6STvCkbQ6IiexUEgga5ktyyXnatJJ7G4xq/b7Ag?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7136.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 577086e1-406b-4be6-5fcd-08dbd6b5e490
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2023 06:28:11.4209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vAS49Q2enD6bhHMgDQqMMucAV9f1DhwFhgKls24Oa4dUUU9/lqtLPD+2otb8Tljd9lOS4uRes5CJFm6w6lBZXoPc9jtWbM3Np12zDH0kORc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR03MB8876
X-Proofpoint-ORIG-GUID: SfDDq3WxAfKPn_Qc-AP54mvIQ2SEanoS
X-Proofpoint-GUID: SfDDq3WxAfKPn_Qc-AP54mvIQ2SEanoS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_03,2023-10-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 bulkscore=0 adultscore=0
 impostorscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2310240000 definitions=main-2310270057
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

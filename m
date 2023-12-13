Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52B8B810D08
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 10:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbjLMJJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 04:09:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjLMJJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 04:09:20 -0500
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2089.outbound.protection.outlook.com [40.107.241.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86555AB;
        Wed, 13 Dec 2023 01:09:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bQD61dsS6nOX5iEM6ae+/DKLJmGy+mzr+xpAC2knqTkt3qppyv5U4JlH0ukBSp45ZkkpA09ISToPNnPvAgcEW6o+AGX+tO0Uzoqq/7q4AzSQ/PcQmFNPgJpeOYKdl74qrvA2rCXLtqI7v90RBBMFTmBFKv1uSB+q7RlPviPXnu2ffBd2s3gzrc3ozjThcxtj3Xk/oBnQ1p/E0Xm8g3YbNymtBFh8G4w9Cci80nsnfsdywyt5Y621ddBJmDRyM3gWtsZBUucYRbtTm1UAlZ0ygYhxJuPtESKUARzwEoJFZ7amdj+Ou9GjEXxKmDN/wqKUzjP4bhRZ5jTA0R8xFF4Xjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6jD1xLbyvzSLMnGfShXOLgXCEzPxy6WvqRxdwpUCT5o=;
 b=fzTvHvTL7rh8McnM/MHmmEGdZ8ILKSPlQlbQfY5tCycvyr7se/TFa3bhFMlW7AMj3euyNnd7a8qETeUf4S+XKpIpnNIyl664Azh73sk3EtuTxIguksQsIkYN0wz3YKS7GlRqHYpzL8Klh0y6kIzAYbcuIOvyuuqUCWIrMyrdsW9XNzr/b/ljrgx/2tkSuxEFMEcVtbIymQNJeCGkqe/cs6CdgTwin3gCZd8Cvnym9MQWhj5Tu7l+rpVnAzoGKQMeeIotrWNmgYzeqSJipIi5iC53xM4xxO2qp7CcVXJL8ZRBku495NG6uTxx1FRbRELIwsivtuXT78ZMsb/rrWqfsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.93.42.39) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=topic.nl;
 dmarc=bestguesspass action=none header.from=topic.nl; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6jD1xLbyvzSLMnGfShXOLgXCEzPxy6WvqRxdwpUCT5o=;
 b=Xg3ZSKaiJ1jD0O46wPLUcpwPqMwvtb595XoPSs8k7bkOINwUP1TgdbBLBW8sX5IbtXYK4b7NyISNplzLAWt4tCNzkl3/zZSkEa4A5/CqVWL68BqyNG13n4Q7LWL6YZKoig7pJiyFkb7eAqGwVcb60WaG7JlFqR1AMjyHHWlDIdpsb4Q31rOJ4o8CNZX/sNjpfdPlMGMFcjpb5D4PCyRiJmQlc1Hn9Z+POoHirn1VncTWONtsQnMh/Cm8M8DIDSoGscUYjDas/McdXK9EXlZdSoaRw+XL0LsIC/W8LGEU6iAi9Cjdz2Z+sjl9qALQ41vhQ/ZJCQq6lfYyVRI6/XwW1Q==
Received: from AS4P190CA0036.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5d1::7)
 by AS8PR04MB8817.eurprd04.prod.outlook.com (2603:10a6:20b:42c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 09:09:22 +0000
Received: from VE1EUR01FT034.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:5d1:cafe::f9) by AS4P190CA0036.outlook.office365.com
 (2603:10a6:20b:5d1::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Wed, 13 Dec 2023 09:09:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 VE1EUR01FT034.mail.protection.outlook.com (10.152.2.235) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.26 via Frontend Transport; Wed, 13 Dec 2023 09:09:21 +0000
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (104.47.30.104) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Wed, 13 Dec 2023 09:09:21 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from VE1PR04MB7471.eurprd04.prod.outlook.com (2603:10a6:800:1a7::11)
 by AM9PR04MB8194.eurprd04.prod.outlook.com (2603:10a6:20b:3e6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 09:09:17 +0000
Received: from VE1PR04MB7471.eurprd04.prod.outlook.com
 ([fe80::ec21:cf04:ed05:c7b1]) by VE1PR04MB7471.eurprd04.prod.outlook.com
 ([fe80::ec21:cf04:ed05:c7b1%4]) with mapi id 15.20.7068.033; Wed, 13 Dec 2023
 09:09:17 +0000
From:   Mike Looijmans <mike.looijmans@topic.nl>
To:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org
CC:     Mike Looijmans <mike.looijmans@topic.nl>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: iio: spi-dac: Add driver for SPI shift register DACs
Date:   Wed, 13 Dec 2023 10:09:09 +0100
Message-ID: <20231213090910.25410-1-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM0P190CA0021.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::31) To VE1PR04MB7471.eurprd04.prod.outlook.com
 (2603:10a6:800:1a7::11)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VE1PR04MB7471:EE_|AM9PR04MB8194:EE_|VE1EUR01FT034:EE_|AS8PR04MB8817:EE_
X-MS-Office365-Filtering-Correlation-Id: 89d04d7d-dda8-4a6c-1a6a-08dbfbbb3225
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: YIVvvUye5dLfGvIBU4d1IgsNgXw+UUQAnnJFR9lE+bWRSMvm3VVPBVHcdfzjYD7si9IO5VyTb6pHXGrROV0R5hZx6HeBFShpJCKgRggZUMlHPHIN0D9HswcIo222oNaDBdCgcHu1ymH7zmtjunZbldU8PpaaB8kfqOKfJ0cdx3PmpqzJeGSbJmmzc9JXhBdPDxcfA5cCjNbSditv5Th4NOpt7lzRJgwERLw9CrTSmXBd0lM10k1PFCmPWc5bjn8tY/B89zHnh5ysB1yoBJIIDnRxU865k9IQLR/yBOR+MxjYaLGoBZ7S8blRhOdz+v2ZRkjCut5SuT3p/QBn1aYFR5gn0CHe4JdbipRmNivXptiOiDrmLd/ok1kC5f0PL5ZHVV8DVXgoQmRk1f9VX2LHgqH3+cCL7GPZ5HL1mVWS7ez3Fyu3CE5SHqibsuVEn3kJtXDCTClutgVTYpJ0hL8n1GyUbdlb4lvSmhB69adqTu9jkqAFAJ8zyOHGqOtjENCsAf912Lli3LuYFAJyzQ1rB3sSTM3pjzBpFHm4pRJA5i4yhVzAhasIpkuQzrRpf2VrENIDJsq5Vjj4wJplhN0vqHDfjxEWwX154/MOKYso1FM=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7471.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(366004)(39840400004)(136003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(2616005)(83380400001)(26005)(38100700002)(44832011)(8936002)(316002)(54906003)(8676002)(2906002)(5660300002)(4326008)(66476007)(478600001)(52116002)(41300700001)(6512007)(6666004)(6506007)(66556008)(966005)(6486002)(66946007)(1076003)(38350700005)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8194
X-CodeTwo-MessageID: ac50f718-c869-4fcf-8c62-bb4e2049b265.20231213090920@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.3aa8b2c3-ac7e-4139-afe5-048730c85889@emailsignatures365.codetwo.com>
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR01FT034.eop-EUR01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 1e065eaf-ec9f-435c-2fcc-08dbfbbb2f17
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zPCTdF9FD5QZZAyGgB8hKDrRPq6pwVO+Y3yXkNtKrxbcvNvGvk7aNc1gjqCpH+SFbA8ZvdLvWrEt/QP2Awf3iP9eT9wSACXEESY+t/R0GH1P2SyqcGd1y5DqNUgeUh4t6anhWmF1+SDH1jlBrqh3ol4/1x8xDIAO7+DnfdumktC/MspkrJufT5We3B+HvC6hi8jqCyzIouejU6TRZnh0BKPH69aP1by6yT5SN7lZ/KXqHr2QjpDSUWoUMR6YVqJ3aMz4LH/GsblL606kZik9MXDBu1e+CbMH3SbVRcXzh5G8B9sxpaz7JZvLULDlCHCi0ReKrFXYLAlCZPulW+D6sstVWh1tfC366HnWvwqBl2N4AW4EBKbd03+BM1R2I+uleY18+UzHPRkn+NLEUmqtg1vOvA6uLpIa4QvDv+bUuoJWIrT5M+l2R4uwHjTI7hu05DfVGUy5UNH8CYpRmDbYB6eEeWvh2RxDrCxwK5KgkrdQr73Un9S8dryGxfTrQ/4fkfRguffXLE9Veox7s8U2WM5Pji/ZE8T8+ZIiYhhJtXHn2tCC11d6sv3g1sUUS7v/AmNyXr4qtwyOYAFms+56NH4a2FhoNgyZx9q6XRDG9GJRLe0mXZGpFrEd/08MIthQVMiWSkkUPWfgumVgUfK+ILIcIQA/svSe1VcCL/En+4c0hRj5HMKbkxNselMP/VIb
X-Forefront-Antispam-Report: CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(396003)(346002)(39840400004)(230922051799003)(451199024)(1800799012)(82310400011)(186009)(64100799003)(46966006)(36840700001)(26005)(83380400001)(336012)(6506007)(2616005)(6512007)(1076003)(47076005)(36860700001)(44832011)(5660300002)(4326008)(8936002)(8676002)(41300700001)(2906002)(966005)(6486002)(6666004)(478600001)(316002)(54906003)(70206006)(70586007)(86362001)(36756003)(15974865002)(7636003)(7596003)(356005)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 09:09:21.9305
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89d04d7d-dda8-4a6c-1a6a-08dbfbbb3225
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR01FT034.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8817
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a driver for generic serial shift register DACs like TI DAC714.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>

---

 .../devicetree/bindings/iio/dac/spidac.yaml   | 69 +++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/spidac.yaml

diff --git a/Documentation/devicetree/bindings/iio/dac/spidac.yaml b/Docume=
ntation/devicetree/bindings/iio/dac/spidac.yaml
new file mode 100644
index 000000000000..be98da728594
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/spidac.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/dac/spidac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Generic "shift register" SPI DAC
+
+description:
+  Supports simple SPI "shift register" DACs, like TI's DAC714. These DACs =
have
+  no control registers or commands, they just use a clock and serial data =
to
+  shift in a raw DAC value. Multiple DACs can be daisy-chained together.
+
+maintainers:
+  - Mike Looijmans <mike.looijmans@topic.nl>
+
+properties:
+  compatible:
+    enum:
+      - spi-dac
+      - ti,dac714
+
+  reg:
+    maxItems: 1
+
+  ldac-gpios:
+    description:
+      LDAC pin to be used as a hardware trigger to update the DAC outputs.=
 Not
+      needed when the DACs use the chip select to update their output.
+    maxItems: 1
+
+  reset-gpios:
+    description:
+      Optional reset pin that resets all DACs.
+    maxItems: 1
+
+  num-channels:
+    description:
+      Number of channels (usually the number of DAC chips in series)
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  bits-per-channel:
+    description:
+       Number of bits for each DAC output.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    spi {
+        #address-cells =3D <1>;
+        #size-cells =3D <0>;
+
+        dac@1 {
+            compatible =3D "spidac";
+            reg =3D <0x1>;
+            ldac-gpios =3D <&gpio 42 GPIO_ACTIVE_LOW>;
+        };
+    };
+...
--=20
2.34.1


Met vriendelijke groet / kind regards,=0A=
=0A=
Mike Looijmans=0A=
System Expert=0A=
=0A=
=0A=
TOPIC Embedded Products B.V.=0A=
Materiaalweg 4, 5681 RJ Best=0A=
The Netherlands=0A=
=0A=
T: +31 (0) 499 33 69 69=0A=
E: mike.looijmans@topic.nl=0A=
W: www.topic.nl=0A=
=0A=
Please consider the environment before printing this e-mail=0A=

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFFC810E17
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 11:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbjLMJrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 04:47:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233142AbjLMJrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 04:47:35 -0500
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2055.outbound.protection.outlook.com [40.107.241.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3338CA4;
        Wed, 13 Dec 2023 01:47:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PHS3kMj7n3vJLqeGYKdby/IYwedRjA+wxDE+ln1in2HISXLezT1lwrhVlT/yRztxFeEcP3c48Ye1KDG8TJUymL9IwD3kZaBMBhSx+pKgKRROVQG/Dvi8QqPBYVi7lV1ROsopXHoLtOxCWrq3riAzF6bS/IJLQPYbAn2Op3Mc68HCN0KAFqSo9379rp7XGHQk0c0gaSQTehzy0/x83QRl31u/17JQRhaoPX+x2OHU5A+5kMu9LQ8VrstGg/fT/x1ww5LR3EY6mQlvVB5lRW2Fji+ICXFpg/7inw+pw7Cxq7AZFJAEz2070PE5Knt4BhvcL/sgkEHFgGu7BceqmKTy4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A/wMzej5/YXpG5BjXoZfddm6eLKjN9vSMlvAYHUyE40=;
 b=bkcjQvrUjMnEySjDo0ahrsfblCxsJY3JAzGkFIjeuhqWUGIEV/bE26gly/+8AvEXrZhzWqwoffsZxn8yvLveXXwiY/lnXurQNEUJ3Pbx4S5zquD/54wVhjrF+Cmbq/rzz+RbxmK7IEYWwXrS3Q63dLNBONv3a6X7vUP5bLwjepNtifHQ/xBfLrTR/JLRUblqJj2wbmU/3hsOCzoL6W8FN+KEYTbkgVH/i9MUmMoNYf/w8J0i/rrYI6hl5yN7o7GGQJItyIZX7jig00z2dUNDOsyvPZSFFSEM6oRmfXHKPTDt/lknFgMaOx/X/IEskcKE9YlyV550xjmctXAipmDYsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.93.42.39) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=topic.nl;
 dmarc=bestguesspass action=none header.from=topic.nl; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A/wMzej5/YXpG5BjXoZfddm6eLKjN9vSMlvAYHUyE40=;
 b=qkHEpvaabHplLEPAfjumocWANdpdDVrQJhy3PTOzwDsi3INp49FQy9gvatGbwVpmDaLOsMaTKdb5G5zUVOnClR+A1F40jxroGFxKKzTh/eh2UGurFcqoFrrwg/dG/heGAARQwFqGk4tNB/CP63XdZKRPCu1T/nUENxA9W+prPSx3qm6HICDBdf4yrIFvZ9hCzT+RTm2JW6YXH9lc7K20JU4QEkjvgo7ZzPc74r+R2dD3GZwbcSNDUWalo4fKEoDYV3UnOp37ptjNZSsafhlrUbpUm5U39mUvKpQTyqkwmKgNMYbw+MCHpjNGrFeGtnojA8AKGtp3WbR0yU5lw2ipBQ==
Received: from FR4P281CA0313.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:f6::7) by
 GV1PR04MB9120.eurprd04.prod.outlook.com (2603:10a6:150:27::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.26; Wed, 13 Dec 2023 09:47:34 +0000
Received: from VE1EUR01FT043.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:d10:f6:cafe::25) by FR4P281CA0313.outlook.office365.com
 (2603:10a6:d10:f6::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Wed, 13 Dec 2023 09:47:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 VE1EUR01FT043.mail.protection.outlook.com (10.152.3.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.26 via Frontend Transport; Wed, 13 Dec 2023 09:47:33 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (104.47.17.168) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Wed, 13 Dec 2023 09:47:32 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from VE1PR04MB7471.eurprd04.prod.outlook.com (2603:10a6:800:1a7::11)
 by PAXPR04MB8767.eurprd04.prod.outlook.com (2603:10a6:102:20e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Wed, 13 Dec
 2023 09:47:29 +0000
Received: from VE1PR04MB7471.eurprd04.prod.outlook.com
 ([fe80::ec21:cf04:ed05:c7b1]) by VE1PR04MB7471.eurprd04.prod.outlook.com
 ([fe80::ec21:cf04:ed05:c7b1%4]) with mapi id 15.20.7068.033; Wed, 13 Dec 2023
 09:47:29 +0000
From:   Mike Looijmans <mike.looijmans@topic.nl>
To:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org
CC:     Mike Looijmans <mike.looijmans@topic.nl>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: iio: adc: ti-ads1298: Add driver
Date:   Wed, 13 Dec 2023 10:47:21 +0100
Message-ID: <20231213094722.31547-1-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM9P192CA0015.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::20) To VE1PR04MB7471.eurprd04.prod.outlook.com
 (2603:10a6:800:1a7::11)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VE1PR04MB7471:EE_|PAXPR04MB8767:EE_|VE1EUR01FT043:EE_|GV1PR04MB9120:EE_
X-MS-Office365-Filtering-Correlation-Id: a5546ec6-41e5-4d88-a1df-08dbfbc08803
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: g9xk/fge5Ml+kcmryxXdID0TjnrFFFW1EJwd30aAYup+2/B8iAwTTA0BzQNljPfrmm/IwCoZBJcljk07sdvwbC0sz/4jRN4ipYjZ9/5CusO+DEpDLWnpnUQCyf1VQLA+nXncolMFmI/Hk/mV/rTXyM5IC0WEhXYoX1TcVOAnEFUmLbsDm/dZJM/+Rk+p1Pxo0CfVZcfYoCc5EKlPjxrQbj3gJ+YRgkuViEyyprCMdScUuI5XCYWJziDk10R4JdNS6iv/onZNjJZMO4LdfU7VjfCZPP7AuPNBP52GiKruC5D3AjmdLMt8MkorWZWQEn7vV4u8k7UB5CXtxh6KzoEaBoGiQsAOrrbrmWfSYJKtND9N7LLZr342mTBPhbwfBDpNH2cFxPBJ3te5b0PzYWdkzn+aHg9jfDPBmoDWc826rOW2kUjRJZHbVLjrVRAUNRRj2n7LdLGHJdiSKxHUV7Lgt8EumX9OncFJERhQmgD3oULWsZ1l9HM942kXydmTxQ3+zqG5kkdW3VUr+heAhmxmCa5zUvjxk/WfVwjEPcrsddNx2D/U2Z2V+bIABFtBSF0Zb7DnsMsC65aVf6DwS5tqwI+ncMaov/bcBsO9IuDMO8hxig6rcuFbHYCjPK/xpq8IbDQfHGdDlnjlFmRSbqOP8Q==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7471.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(396003)(346002)(39840400004)(230173577357003)(230273577357003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(66556008)(2616005)(8936002)(4326008)(966005)(478600001)(8676002)(66946007)(316002)(66476007)(6486002)(54906003)(44832011)(6666004)(6512007)(5660300002)(86362001)(41300700001)(38350700005)(26005)(83380400001)(36756003)(6506007)(52116002)(38100700002)(2906002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8767
X-CodeTwo-MessageID: 3069d77d-92f4-47ab-8c14-7ab3caa852eb.20231213094732@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.618139b3-8cb2-4e4c-9283-9e3787c70105@emailsignatures365.codetwo.com>
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR01FT043.eop-EUR01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 95c44e53-e880-4600-7b08-08dbfbc0851c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7s7tD05z2sGcB/vJFmpYSY2TRRU5ZqAooFo4KhXkXPon7ovbxJA6vHpcZwt3Zqod12b6LkGJV+kyNOUQVG2Q/ikrakDc+gULdYEsI+lRbGW/YxoRXcX77TfHJmEvueAIm0iyJQAMXErp9ybBdW5EMOzgiTC7ey9hoPfdFyRtsgaO80oCBPEEIKRilwQvKL5tNitu+OjeM9PFi1jlEz5MGKxmBo6qSQZfs6Af6TVKQoOcivu9LGj0zdZcF1IgIGhvw6OyOBZq3xV3ammkzPVbNBENbzeJ7QZwVppmhb5egNRzjdl3f14BJtg1LKb/vZDQtxrfEaknyD1Yu2RZVwnDUHsF5hy+IOroxZVxgvsWzDdcge35qHXOXuOGJ/Q/lVlQ93/w4q5rd5FhkGKYkKLLoRxCCSLxS9IyLk510EQN3EZLa//kj8gyRzJvrP7WWRMiXC1aHXXADOxFBrs2VYDt4eVFE1jv0482lGhnkTOe39d22seShaiAs3n8idEZXic168ectLFvpIZshtdUFo8GYYDEsVgs0XmPFhisSMjDIwv3iePSv6m99GGr+Ts4/qgBCmaUWkRaIAc7g9S9YEK2nS4GFXQCCiIXCGMdjRBvCBbwi0+OO2SaxnbMujLl7lKR6HWFM3KMsCytUOUZ0Pq9fZW8ak1VJoKJQ5Blt2KDL12xSFwkDXrjaqjlMYzcPa1ZtF5o1OmMJfjEaNL+q0ZSKwBRuFvb3cMm8tFsFY7r9XE=
X-Forefront-Antispam-Report: CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(346002)(396003)(39840400004)(230273577357003)(230922051799003)(230173577357003)(64100799003)(82310400011)(186009)(1800799012)(451199024)(36840700001)(46966006)(40480700001)(36756003)(54906003)(26005)(2616005)(1076003)(6666004)(966005)(15974865002)(2906002)(478600001)(6486002)(6506007)(70206006)(70586007)(4326008)(8676002)(8936002)(316002)(6512007)(36860700001)(336012)(47076005)(5660300002)(44832011)(356005)(7596003)(7636003)(83380400001)(41300700001)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 09:47:33.5101
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5546ec6-41e5-4d88-a1df-08dbfbc08803
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR01FT043.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9120
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Skeleton driver for the TI ADS1298 medical ADC. This device is
typically used for ECG and similar measurements. Supports data
acquisition at configurable scale and sampling frequency.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>

---

 .../bindings/iio/adc/ti,ads1298.yaml          | 80 +++++++++++++++++++
 1 file changed, 80 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads1298.ya=
ml

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1298.yaml b/Do=
cumentation/devicetree/bindings/iio/adc/ti,ads1298.yaml
new file mode 100644
index 000000000000..7a160ba721eb
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1298.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/ti,ads1298.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments' ads1298 medical ADC chips
+
+maintainers:
+  - Mike Looijmans <mike.looijmans@topic.nl>
+
+properties:
+  compatible:
+    enum:
+      - ti,ads1298
+
+  reg:
+    maxItems: 1
+
+  spi-cpha: true
+
+  reset-gpios:
+    maxItems: 1
+
+  avdd-supply:
+    description:
+      Analog power supply, voltage between AVDD and AVSS. When providing a
+      symmetric +/- 2.5V, the regulator should report 5V.
+
+  vref-supply:
+    description:
+      Optional reference voltage. If omitted, internal reference is used,
+      depending on analog supply this is 2.4 or 4V.
+
+  clocks:
+    description: Optional 2.048 MHz external source clock on CLK pin
+    maxItems: 1
+
+  clock-names:
+    const: clk
+
+  interrupts:
+    description: Interrupt on DRDY pin, triggers on falling edge
+    maxItems: 1
+
+  label: true
+
+required:
+  - compatible
+  - reg
+  - avdd-supply
+  - interrupts
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spi {
+        #address-cells =3D <1>;
+        #size-cells =3D <0>;
+
+        adc@1 {
+          reg =3D <1>;
+          compatible =3D "ti,ads1298";
+          label =3D "ads1298-1-ecg";
+          avdd-supply =3D <&reg_iso_5v_a>;
+          clock-names =3D "clk";
+          clocks =3D <&clk_ads1298>;
+          interrupt-parent =3D <&gpio0>;
+          interrupts =3D <78 IRQ_TYPE_EDGE_FALLING>;
+          spi-max-frequency =3D <20000000>;
+          spi-cpha;
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

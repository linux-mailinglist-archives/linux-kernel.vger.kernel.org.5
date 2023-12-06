Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB76806C1B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 11:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377479AbjLFKgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 05:36:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377464AbjLFKgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 05:36:42 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2044.outbound.protection.outlook.com [40.92.107.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8592D12F;
        Wed,  6 Dec 2023 02:36:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C0NjphLwSWxNmTwpVBFE2zrByMCwaqe8x6Z1hL6A409FNwxzfQC/+3ul1XSUif+P+2jdRc8ZhE1YucjwOuzdrsLmmDLGZ0y69Hnxmysui5bxqxbtmkVvHPUJpfLDZm9h7mFBrBLh86EYIF9a5lXdhmMMuqo0oSGY4zXiuyh7u+GsWHWTf0v0pb9soft/ewgX25h/KNAVeJrJLzfdEWOIFphkQpfq2OHXzz4vVssGGs8J3nz3sdvpcqCQ+GRCtjXmUY2Mt66NXbv2/uTUBIuTdjG6h+snzwlhvudpPk8h2FRWU8Au8d8ZnDaNCP0A/X/bGpV6s98CUMmDh5VSeFoKiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=riIxlArENCoaMNr3b1AfCgrNHkczW4liCzMBXP1+Qe0=;
 b=NIkumn85I7+lds2A8Yxe/LtHwuD9SiX+kSfFlP7pAaSVjGo8YcEhwslzeA6tixDSozon5u5xNt83Qfs9UY2npGS5MIHrU/rNrxWe4OHtcdTi/nZDce4WOAL3g4P+BjNskeNfhsn58ap0cQwPzYpv0KtqAxZnPzX/F4fz8wRTVEYe/+SB72IhXqbWymylV2gMdqxH4KztnzLtXf0LBlOztqFn9ODGgwje/g24VJ4MwfGbcHGafLNZEnXD47oPVT3iZipSuEm/5I3QM3ldCz3l4Vm3Lpl11z0/bKx2m+nSu8QWFich3G7DNh/oJ6B9i5ZCD2nXl4iOcOoSZmrJfnEiEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=riIxlArENCoaMNr3b1AfCgrNHkczW4liCzMBXP1+Qe0=;
 b=WZsLrSQdpYG25DWSgQ3Yy67hLR3Xs9aIOSGPbM6m0AYGJo6prujcyrMcmtACYI9xdlxUUhDx9PO88OCJzf/rRQ+pCtfSDjCk0wJf5wFtPTtD928rnwgAOj+q3fTIYhcqZovQxRDq8astxzUuqxjSxC32vtX2h3KnmeVl6ikJmrTeBr1Lgdci0gOuVKUlW3sxzt+rCUnKuxMg2CtkAlJxzJXJik6E8KvWzATkHrFXBHvmb28Uc/gDdh6dipe/PdZmYvyASVftqWlbR28XjftbJmi/TDvE3MFySi4sWDdSiEPn2o6LpmVqo/RkbjzCyNLfV5+itoteGuUBInTdhfns2A==
Received: from TY0PR06MB5611.apcprd06.prod.outlook.com (2603:1096:400:31e::8)
 by KL1PR06MB6866.apcprd06.prod.outlook.com (2603:1096:820:115::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 10:36:43 +0000
Received: from TY0PR06MB5611.apcprd06.prod.outlook.com
 ([fe80::f2fd:d852:e4b9:6166]) by TY0PR06MB5611.apcprd06.prod.outlook.com
 ([fe80::f2fd:d852:e4b9:6166%5]) with mapi id 15.20.7068.025; Wed, 6 Dec 2023
 10:36:43 +0000
From:   Allen_Lin <allencl_lin@hotmail.com>
To:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Allen_Lin <allencl_lin@hotmail.com>
Subject: [PATCH v2 1/2] dt-bindings: input: Add Himax HX83102J touchscreen
Date:   Wed,  6 Dec 2023 18:35:45 +0800
Message-ID: <TY0PR06MB5611A2BEF3FAC1648CFFEE149E84A@TY0PR06MB5611.apcprd06.prod.outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231206103546.808680-1-allencl_lin@hotmail.com>
References: <20231206103546.808680-1-allencl_lin@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [+jJbTldv9+uQj0mN8S0kpSLSpdmt8hys]
X-ClientProxiedBy: PS1PR03CA0015.apcprd03.prod.outlook.com
 (2603:1096:803:3d::27) To TY0PR06MB5611.apcprd06.prod.outlook.com
 (2603:1096:400:31e::8)
X-Microsoft-Original-Message-ID: <20231206103546.808680-2-allencl_lin@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR06MB5611:EE_|KL1PR06MB6866:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ea4d8cf-4f1a-4761-2cd7-08dbf6473d2d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X18NkMf5Gdzv7Px+eR2GsNLKtpzf8gKh5OVJPPLRiSosYaSlZzJvyXnrhniZed6EJg5kjVbmIQFyRTFSdiQIseVvobt34GAgFoBtgjNEmdkJiCrq/ysUyeP+1GdQ78txwBU8sA1OVfwv833iq7B1UMvsYWdi0KBR3fmFO6UgX+bG3+1sn4sLIqJ/DOWdrfgZKESqCzYSxKQR2NqM9kNZ5lsdRVjJ+Bob3+cPmU73ejxsTdU4FgrRd5SqtKhz9+GKq7Jr/WVmue5gOEcCmpHTiDo4jIfYMDAydTrNO7KvWPPcXmf3JjvY+pK0KiPOFEYdKZfwn02+m4GecN8y6JWBAKpq2cB+01Qb/GPZpq11xorL9NTYBdv9nSdWHafxFT1A/DOzjVJNzM/SXqGqS5EiBCN0Iieh/fUvroOb9lySOtSc8hdfoP93pDLGaQvoa4pJsV7+tyzHT3+Z4mjhBq851POpxbtraORfhxzFoMocCKhGkypu5FqB6+gL5Hne86De7vY8f+N1mDZ9RAU2RXuVpzqfjoe6wmCSGa+jLPLKEEa3HMg0dA7sB2poJQBkgfLcablVsXy/D+RpzGorg5aGhV4cIVtpdhR17pP+njjKNhfOKhjwYH3jGoIqZIUDYWGa
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZAbq5SySogt/PueIDtHeUkGYN4QnoRFRcO9LWYTM9//sibhfNzZfSpc0/EsF?=
 =?us-ascii?Q?yWNiya53I54bWJty4U0qaoSLprllJzIAL9WJk3lzzlxnYn4ILFN8grbCeFkV?=
 =?us-ascii?Q?EhfyiujfcyUrGPRc+n0tQ6H/uFKDo+iDzOK7BTAchT/6f/FWjj4dz8d4bvl7?=
 =?us-ascii?Q?xCoL3P1Gss8uF3IGShcSIh3W4hljLR7LvSNrKwT0BjZNyo/kJio7ugfc5pcP?=
 =?us-ascii?Q?asmiSFtRohqoCPZCB2fplRH9H1z3dpPX+59zPzuP/7zMrknxNzimxgwppyuM?=
 =?us-ascii?Q?MLe7vkULkaFtZSJxHSJL3Zy0hpk7jkySai9isO20RXGNtA4wtlWI3uzRcRHT?=
 =?us-ascii?Q?Yu2h9Tr3ee4+orbU50lb43ZeBcMXH4gKJbL6YZnjLIaqoIdBa/1MIwmvHxO2?=
 =?us-ascii?Q?LN5I8upDSElrACdZ7T1hQFVOyLMIeOlpzwQ8IERnVls8SRls6yTcFim1VFjE?=
 =?us-ascii?Q?ENIiv7C8XS9OlvfxPPa9uBKTvovvkq1jn9kuC0S4e4z6wcBnSbk9PNaX89mZ?=
 =?us-ascii?Q?59TmRgx1/DrCRV3nskAJMxiTIjVkbdAPn3T0dkO6ao5OPJMxhq6/Uq0lAPDw?=
 =?us-ascii?Q?Dkqx+Jbr0sD7I7ht9D9eA71kKXoUDosIvSxkuCzui6+4mfI8njgHurdmi5Q/?=
 =?us-ascii?Q?30Vw8l8K8UqXCYCMaE05he8Uph7U6xpwMSo617x9GvJ3cMOECxg9kj26iB//?=
 =?us-ascii?Q?le0iNhtvN5qpPAS6sOhyxfbZECVC1aZwCC6yy+z2q58es/AMlwJ3SV6ihJrW?=
 =?us-ascii?Q?AmzPoS0I6IbysELNkECge4L536tAcrwEIvquGzSPZDndQn7GCkyXvlg92KuL?=
 =?us-ascii?Q?7gh45QmEGtshep1isJwAcMnrQe8Q6qVrGEpZob7A23zPHRW4q9jKwsEYemk4?=
 =?us-ascii?Q?xTvT2iSihh1HfRpaRX+VE0okDS9D8Xh9b69fepVgW15bgd/PBQJaYvZVibj/?=
 =?us-ascii?Q?mqH9seSviETXxXa7pX6k+SJ8DLUa0Yd72zS21u03MMfLEMG1ui/Bjj4KSUFc?=
 =?us-ascii?Q?A/hcvj5GOzvVwta7g9C+peVj4ecQyfu4CVLXiHe3zMFVnSYxXLPIK9/4/9c1?=
 =?us-ascii?Q?C5H+Mi1cLadZTLfHCczqdeCkTAJAjepItmB4XEm4w33mn/fHaLp7TxgnlPsR?=
 =?us-ascii?Q?cizIWKyT4DM1mWg00n6k5hHOIWR059ZDZvYyLQwy9LbnVPN1dfyz1XHqpJ9x?=
 =?us-ascii?Q?l0oxNOY1diZGTCAyRp7SgO6MLYbA0KtGz2XOng=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-f764d.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ea4d8cf-4f1a-4761-2cd7-08dbf6473d2d
X-MS-Exchange-CrossTenant-AuthSource: TY0PR06MB5611.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 10:36:43.4918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6866
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the HX83102j touchscreen device tree bindings documents.

Signed-off-by: Allen_Lin <allencl_lin@hotmail.com>
---
 .../bindings/input/himax,hx8310xx.yaml        | 70 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 2 files changed, 76 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/himax,hx8310xx.yaml

diff --git a/Documentation/devicetree/bindings/input/himax,hx8310xx.yaml b/Documentation/devicetree/bindings/input/himax,hx8310xx.yaml
new file mode 100644
index 000000000000..1cc65e9bd267
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/himax,hx8310xx.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/himax,hx8310xx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: himax hx8310xx touchscreen
+
+maintainers:
+  - Allen Lin <allencl_lin@hotmail.com>
+
+description:
+  Supports the himax hx8310xx touchscreen.
+  This touchscreen uses the spi-hid protocol but has some non-standard
+  power sequencing required.
+
+allOf:
+  - $ref: /schemas/input/touchscreen/touchscreen.yaml#
+
+properties:
+  compatible:
+    enum:
+      - himax,hx83102j
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+
+  spi-cpha: true
+
+  spi-cpol: true
+
+  spi-max-frequency: true
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - reset-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      hid_himax_spi@0 {
+        pinctrl-names = "default";
+        pinctrl-0 = <&touch_int0 &touch_reset>;
+        reg = <0>;
+        spi-max-frequency = <12500000>;
+        status = "okay";
+        compatible = "himax,hx83102j";
+        reset-gpios = <&gpio1 8 GPIO_ACTIVE_LOW>;
+        spi-cpha;
+        spi-cpol;
+        interrupt-parent = <&gpio1>;
+        interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
+      };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 012df8ccf34e..cadcbf7294a6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9502,6 +9502,12 @@ L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	drivers/misc/hisi_hikey_usb.c
 
+HIMAX HID HX83102J TOUCHSCREEN
+M:	Allen Lin <allencl_lin@hotmail.com>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/input/himax,hx8310xx.yaml
+
 HIMAX HX83112B TOUCHSCREEN SUPPORT
 M:	Job Noorman <job@noorman.info>
 L:	linux-input@vger.kernel.org
-- 
2.34.1


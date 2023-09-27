Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85CAD7B03FD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 14:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbjI0M0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 08:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbjI0M0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 08:26:47 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2079.outbound.protection.outlook.com [40.107.241.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231B0199;
        Wed, 27 Sep 2023 05:26:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OtjOMAdggvR8MivNBUw0+xH/MJo8lzVjxpA9XRN1vnDJykqmUwfD/kNvHmaBngq4yJSanV/HlD3sNK4H1ZANN+am+jo7WlbE0dtvWcvKiVWSsfL55H6BEggK8SpwRrEPNAn+m4f9gj2C0Ohs9xi/qR85v1WzAR8Mf5z2mNNCavVWxcIyeztxf2PmNPCNT7fNhNQsqWNp9Ne5KZl2D2zQxuQjmmJUvLMTVgqEBK/GHd6cN/nEQ11PcrCab7Q5NYHrA5VEDreP3jkHqJWAVwaq5eUcureB12thRqF60j7tbkxl0afsrJDXIehU7lG8pKP98yesS9RB/yNJBmgjhohKFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y8+ymlawP3djoeglT5X6ixc1UnvqX9Wv925OgQ2Z9mk=;
 b=bMcXV06pwumfYrb38VIPrmizVehndFeYF0vlAPQOaSDiE2FPt65eEo8lNbvu0Wh5RkTpARt5Tyb1Y/kPzwxMTC0tE4LSuwHt0DB9VCWQNZB1qlEHEeumBadCwgPg8xFuPj/NAIMZ1vIKwKIQxnT4dkGWVNfefW6xB3sTpu2Wt3uhj0eyh6HoB+DYt5p1+qVjtgfCaefi2mrdM/yBdnE9K176VXdBR+0gAV3dIdXsZIStMWjPlIyEsCga0ngrw8lynxZ6Eh6jM5OOIS8qzdiskplfO7YZWHPoJt8L/gjQsMSprB77jbMhaxYCLWBKIhxApRKsxp58IWRfTC8EoSLP+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y8+ymlawP3djoeglT5X6ixc1UnvqX9Wv925OgQ2Z9mk=;
 b=R0R6rgY2dyw8WWftaxFwEaBLDeguQRLyyoqM1rW9H/s9iMjsf7swHcYPyFTmsO5qPBMub73h4i4sBTzp53UL0N2oLys1TIcZStmn7BpgN+HTq76KcouwURwj/O+0lpy4FqhxTt/hPUid92h6LVDyeapdHNSjYJVNSRYT1kyMd7Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by AS8PR04MB7704.eurprd04.prod.outlook.com (2603:10a6:20b:296::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.27; Wed, 27 Sep
 2023 12:26:37 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::dbc:99b7:7808:f82e]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::dbc:99b7:7808:f82e%7]) with mapi id 15.20.6838.016; Wed, 27 Sep 2023
 12:26:37 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        clin@suse.com, conor+dt@kernel.org, pierre.gondois@arm.com,
        festevam@gmail.com, linux-imx@nxp.com, davem@davemloft.net,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gaurav.jain@nxp.com,
        alexander.stein@ew.tq-group.com, V.Sethi@nxp.com
Cc:     Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: [PATCH v6 02/11] dt-bindings: arm: fsl: add imx-se-fw binding doc
Date:   Wed, 27 Sep 2023 23:23:52 +0530
Message-Id: <20230927175401.1962733-3-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230927175401.1962733-1-pankaj.gupta@nxp.com>
References: <20230927175401.1962733-1-pankaj.gupta@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0128.apcprd02.prod.outlook.com
 (2603:1096:4:188::20) To DU2PR04MB8630.eurprd04.prod.outlook.com
 (2603:10a6:10:2dd::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8630:EE_|AS8PR04MB7704:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ba0d855-4cfa-4e31-da33-08dbbf54fe97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pmVQ6z7nSz3l6xOyUZS4t870kMSiVW8doEhNnLM8WNnvJxN1iXbSh9VRpybFCoU/pbTLKT0St9WWYAs1lootkFt9tjGBepe6PY2IMrW+Z9oZmaNLZFzRof8FIe7U1v9m4CHEnI/JRHGWhbcRjqE4zmeAMnB8xFdZYiSWcZfvi7A7N88z9n0bxT6NmWW1KyvcPh5gwwmIxwe6IROJP4SEbE6BKsH3DKnDD+56D0PiE+qLm1BxAeIwvaCCpqO3wI6DKYLQ4iiX4Xa4Vgo6IAzBrgZM/PM22zHBeogqoX0fLmsrJbEyH/tNWaQagl9sruIP2eeO2aX+8JzafO6wSVEi3Ir/kMNA2hYemifkmgYFJ65FD7++azGJw77H36m5Evl6p3rMAYd6qqiqC4H6Rjxn6KbR8JTRysrXBEnCVDsbJ8vpC9vsjEbqVanTgzyOOfZ2Ny3cd66209Gd1jgROuZ+eolstnrCH7NXuc5c+2NH1c4bjsxJur//JGaYjZ1k/x6fMTR1Shq3oTgPaGBIms3PLNFe4LHefFNJPzowJ2NoCTYwxKj6C/aBfEbAw8aGhRydkELco52d1X/zS40B/z6JzCrI6KUE/f662klhBFc36O9W3BPB5J1w9A703N+qCRkw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(39860400002)(396003)(376002)(230922051799003)(1800799009)(186009)(451199024)(1076003)(2616005)(6506007)(52116002)(6512007)(44832011)(26005)(8936002)(478600001)(921005)(5660300002)(6666004)(36756003)(4326008)(2906002)(316002)(6636002)(86362001)(66556008)(66946007)(8676002)(966005)(41300700001)(38100700002)(38350700002)(66476007)(6486002)(7416002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P3Mgjvc7XlQhLSaN+PauMX/qFd07t/YS1xA6GHNgag7WXtyM5lR4H9qaV0Vo?=
 =?us-ascii?Q?8WvI1h2WvNOscAvToz8vUs1NyQzSa5qWTUQhQ/vS+micn9oUaE8mfIFfPIfL?=
 =?us-ascii?Q?u/LRR/WqaFSdPV4GzyCkf7tPAcAMt3/+YGQxwDOnRWJ7F8wWkVNIzRq4SUzn?=
 =?us-ascii?Q?TsZ5slxArcKC99fwk2kYiLnR3fJWW2QjilFig2rqjM3Cn03egw0qO4uSVn0d?=
 =?us-ascii?Q?5SW6DgmOdxgz27TQZeaUgLcEVZpdI/rEjjcmPi9eGmhix5iOiaOR5Vtwh761?=
 =?us-ascii?Q?BrvSWfGPnEu7F0RzKKcxwt/XfMBZVZeUdOu2l50uUl+LMXbnp25QWtxxVE9q?=
 =?us-ascii?Q?mYqbFh83Tdo7tqUUhQVpDaf0arjv/fYT10TnUZA2QbY9WB5EDx6GbV2ENl/3?=
 =?us-ascii?Q?VisbDrfkfO3jPMEf8hsRUeMv9awTJIzpjQbEJmEhTa88zNhZzBJy588S3v66?=
 =?us-ascii?Q?Zj+bhYblD2D+EbIU6kaFCmSV0mb68HxA5tK4Ay1wbBSOji3D4EGOlMTp9pho?=
 =?us-ascii?Q?Dtkv1lturg7Q10Ro+TnFFtwN+EGoMyQUEx8jXwXTEH28g9X9XFzPy5B9a9ZD?=
 =?us-ascii?Q?2niBiyxtRkoWbmSQjrUtMsfCbqnFjhDWdXoRh/PbWsk7044d4YhvxYxq8Fac?=
 =?us-ascii?Q?owrdpmyvn/oZunYHCnE1PXYsy99YkuJYQEDQe5WvGNXHM5c+HdF431YSKPMK?=
 =?us-ascii?Q?iJktvdljJI8ey5BTT/mwWLeEaKm0mI/AbOSzF8UylOfZQ4IhiLOsVdR3CnmG?=
 =?us-ascii?Q?ypAx0qEUd9CAciZxGROuPVoEioZ3SDhib7juxeVFQ6isaTmk8ITyE23YUPz8?=
 =?us-ascii?Q?L+GJnJzC4YVM2xRa487tLucnAhJ9Mn80Lcoi4rD+Kp9DUTHl/tCNgPHFeQJg?=
 =?us-ascii?Q?+/b9B51jhtAjq6Vy5fcGroc27dy/L3Pe9/RzvzuE7Ixzk1dsxBq87WLtUXwb?=
 =?us-ascii?Q?OyoKu3qlPV3JpvvImB7pK5IoDwU99QL4dWqcX+2e8F5Q9YpMBmRFA6xtk1p0?=
 =?us-ascii?Q?o4LrOWiPw2Xm1+90JE7xBJN1BibaTl72CWRKu2V4YHXjz3kG/X1eDlrgAz/3?=
 =?us-ascii?Q?gsZZXmVLc12E4SVxvlPY4LJWELxxjSC0Ldx1IzGZznBveFb5CFc4zbtsSBmr?=
 =?us-ascii?Q?xxfPZQQNtJ/YOBkI7pw8Uwc6J9mTpJ6UYobgYmgo+hzOymxBReSyf3q0Q8JN?=
 =?us-ascii?Q?6H3mYj1OuW7MZ+5yvDMH/BnToPHCowvkSOWgoRfrb0onFwGvvSMt8jocrjqn?=
 =?us-ascii?Q?zxl49i8QqdUipCzoxvcH+djLFXkrBPKdONshobNr4zRa3+6kK3Mm6uxNkOOU?=
 =?us-ascii?Q?JKCNjcdzw9lDBpULRVU1lDq9mNbzDQGDane5ICl6ZojrVLuK4qJ74OGLL/No?=
 =?us-ascii?Q?rwl+cPHo1dt7H4oaau2tFFbeZ3z6bvefmikW2qtFCIzqYq418HN4SF8VJ7y8?=
 =?us-ascii?Q?e9dEoHqa8pW7dBBuC9nkbl7JO+36pNBFswlcSkjGSkXic8xKik9aFPQWkNxx?=
 =?us-ascii?Q?DfWKbby5xadpV/X1cniyeC/xobJvRzZyakiPw4vSMrq5Px77XDRqmSRH4yLO?=
 =?us-ascii?Q?48CPU9NjHQ6C1/xcQuwQqW23TUgJmLnFK1kjubpt?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ba0d855-4cfa-4e31-da33-08dbbf54fe97
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 12:26:37.5420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3UG50l9EN275sqtbZJUqMAAOJHGrFMC/xqReDZsBLqUjFgDoeVUp1SSSoRfdyVhrI3WrAUYMYfL8Afl76y1Sqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7704
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The NXP's i.MX EdgeLock Enclave, a HW IP creating an embedded
secure enclave within the SoC boundary to enable features like
- HSM
- SHE
- V2X

Communicates via message unit with linux kernel. This driver
is enables communication ensuring well defined message sequence
protocol between Application Core and enclave's firmware.

Driver configures multiple misc-device on the MU, for multiple
user-space applications can communicate on single MU.

It exists on some i.MX processors. e.g. i.MX8ULP, i.MX93 etc.

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 .../bindings/firmware/fsl,imx-se-fw.yaml      | 73 +++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/fsl,imx-se-fw.yaml

diff --git a/Documentation/devicetree/bindings/firmware/fsl,imx-se-fw.yaml b/Documentation/devicetree/bindings/firmware/fsl,imx-se-fw.yaml
new file mode 100644
index 000000000000..d250794432b3
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/fsl,imx-se-fw.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/firmware/fsl,imx-se-fw.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX EdgeLock Enclave Firmware (ELEFW)
+
+maintainers:
+  - Pankaj Gupta <pankaj.gupta@nxp.com>
+
+description:
+  The NXP's i.MX EdgeLock Enclave, a HW IP creating an embedded
+  secure enclave within the SoC boundary to enable features like
+  - HSM
+  - SHE
+  - V2X
+
+  It uses message unit to communicate and coordinate to pass messages
+  (e.g., data,  status and control) through its interfaces.
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx8ulp-se-fw
+      - fsl,imx93-se-fw
+
+  mboxes:
+    description:
+      All MU channels must be within the same MU instance. Cross instances are
+      not allowed. Users need to ensure that used MU instance does not conflict
+      with other execution environments.
+    items:
+      - description: TX0 MU channel
+      - description: RX0 MU channel
+
+  mbox-names:
+    items:
+      - const: tx
+      - const: rx
+
+  fsl,mu-id:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Identifier to the message-unit among the multiple message-unit that exists on SoC.
+      Per message-unit, multiple misc-devices are created, that are  used by userspace
+      application as logical-waiter and logical-receiver.
+
+  memory-region:
+    items:
+      - description: Reserved memory region that can be accessed by firmware. Used for
+          exchanging the buffers between driver and firmware.
+
+  fsl,sram:
+    description: Phandle to the device SRAM
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+
+required:
+  - compatible
+  - mboxes
+  - mbox-names
+  - fsl,mu-id
+
+additionalProperties: false
+
+examples:
+  - |
+    ele_fw: se-fw {
+      compatible = "fsl,imx8ulp-se-fw";
+      mbox-names = "tx", "rx";
+      mboxes = <&s4muap 0 0>, <&s4muap 1 0>;
+      fsl,mu-id = <2>;
+    };
-- 
2.34.1


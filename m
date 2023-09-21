Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC59E7A96F1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjIURKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjIURE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:04:59 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on20620.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e1b::620])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22681BC9;
        Thu, 21 Sep 2023 10:02:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dIlcu6YP7TuqWQKdmqg8j1+RYeUCSjh1tN6NbY8Z4AolYBLsJfc9ETitiDGxJuGHWCsmMQYY9C32RRXPn7F7j6/FwGTGbAjf1OoXH5mRgbSx4djwoVAz+8f/r7FywRDeJOTrsJbdhYFSj7aC7UwvKn6/cgPYnru2nWPMSapGgnONPjImylNSMLedMS9cumBYuow/RLKDHt02e3heW5ARCio0spzyQ947wZz7BAk06g8Ktn+vleN0gsD9maez9QKU50o2b3OzuEkonjJBYytWyEZy6Snv59JgShENql55mB5/Sw3H8p9KNQBk5SvhT5qpEdHqq3vlsIvzhekJ7cCsSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ar48PPT+QBOh5OZCMdyv/m2L8UjG49SAuoYB1SeSTtM=;
 b=leAfu+wmz4uEA6zkbqQTb7lPezfTQOUpwG+uXUMCBmj25BABt0JEtMtDy2vrU42jv1UavSRr5YIJgI7zRJdBRRV2jJ1SvsmPTwvITwk+0I9JJU0Ic2vj/qTdXtDZA486XWhMexYm7AJIRDZnt5r/Fv1+MuQTqXQLjiHfEKXCRPAytcXzgVdwWd/RSLWG/Ni1Z9WxUyHWimPJFABBgd6rhy/6y+LDNCLWtn4TRJZ/ZPTwoEMs8wEgY8gqxrlcMfl4o56AHo+xfM/UNF+OaauZ2vsIzPdwy1jbf+x/7MtBFOOmHGhEcc9h3PEFb7v/m90DdydGz51NcJQol4BJ85XMxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ar48PPT+QBOh5OZCMdyv/m2L8UjG49SAuoYB1SeSTtM=;
 b=iRCfQrzxbmahvmmO8MnsrxiTGaE8hSgoFffNGZ2gTnNLhu3ulFX/eR3wHUb9g5xmB2PM3BPrs6QRlc6bQqF7MBZK2SyLrnh0rO69PBa4miwfsP8C6cnxz2vyqQCrCAzeVfdRKADSUqWDUm2/if2zRoVTBSFX8sagp2PGpqs3yFE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM9PR04MB8414.eurprd04.prod.outlook.com (2603:10a6:20b:3ef::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Thu, 21 Sep
 2023 06:36:52 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::71e6:21de:ecb2:560f]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::71e6:21de:ecb2:560f%4]) with mapi id 15.20.6813.017; Thu, 21 Sep 2023
 06:36:52 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mirela.rabulea@oss.nxp.com, robh+dt@kernel.org, shawnguo@kernel.org
Cc:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        xiahong.bao@nxp.com, eagle.zhou@nxp.com, tao.jiang_2@nxp.com,
        linux-imx@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/2] dt-bindings: media: imx-jpeg: Assign slot for imx jpeg encoder/decoder
Date:   Thu, 21 Sep 2023 14:36:20 +0800
Message-Id: <20230921063620.22962-2-ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230921063620.22962-1-ming.qian@nxp.com>
References: <20230921063620.22962-1-ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0027.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::7) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|AM9PR04MB8414:EE_
X-MS-Office365-Filtering-Correlation-Id: bb3c394e-15a6-4b94-e0d8-08dbba6d23c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FAc4A/tKpBKrOIbTEPgsLC6MU0GLuMvNjCwqMWtfOQhz4rh2bILbdYdJS6vioATpR9tULyXPPz9yddAQuKISlvMb4IoPxyGuZImYfZFxhVCQnD7ac2j05xxHMdcYNsswnudD7nSp149gpBQVMM05oz+tIHWtjWdwOq072RwQwoMDPJ4D+t1pG8JzS1POpQizhn0KbdZKpMhYCelvL7S8rL7EGdwd1PHR2F7kIhZnb+66pGK6c3BHlYq97XsEF3fCiSRO4CV4AvC0QlBfdnSxh4yl9IfyNayNYN4Fdz3wt4DtWq9ebTSOGfl5TR/SPfQkDa12F71+k3t2nA+Cq2QOtCJeELBgmUKTd0XdQjvnj3gj0ioNSmQZcjZTznj94D9JxuJs1Zu3ugpzHNxneylXo2UClW3uBSCrALG/SQNy3MS8iS46Q2r1CblWBp95oufoWLeWLgXL0ft+6dYyFfel3LSc5HVaIJIDNyiYCK1cy3I3HDFoERIPacXnZICNUVNZOt0TcyUdb6TLb9Jw5UAMxrE7bryEB1VLomWMroFn9efZRfQ66Jl9NtjO5seUUffAtzPBeIr4MaYbpcKf6fnosBI3Nwmr5dq3kaP2B9EUS9Rc6FUfTvuttq8pbgdSTuME
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(396003)(136003)(346002)(1800799009)(451199024)(186009)(26005)(316002)(8936002)(8676002)(1076003)(41300700001)(2616005)(52116002)(6486002)(36756003)(6666004)(6512007)(86362001)(83380400001)(38350700002)(38100700002)(4326008)(66476007)(66946007)(66556008)(6506007)(478600001)(2906002)(7416002)(44832011)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R4MDnDadelXGKmWNNLFiKTySay5l8y0taWL2FBo96o1cZgMZo3Unxr8MaR+Y?=
 =?us-ascii?Q?5XME7jIogkCVxOCyHNISbF0HgJ2AHyVaDZTArzZpt3rpuE6l7uaD3ut/Hofn?=
 =?us-ascii?Q?81XVLKCP4jShLOfpD0b0wdFjxp10TR6tQkhtScw8h14bCHfHSow5yu5rD/wl?=
 =?us-ascii?Q?05d6WV150RoOwWyyXrc8+X2S32z6dvCgVcT9KLxtKrLS2T7qsemeph5et/Ts?=
 =?us-ascii?Q?QwRRjFk1tp5cyinaUAJLr6HOetrcryCRZRkiCVPbAyKMJ9DwgL90Y6fkZU0H?=
 =?us-ascii?Q?m6fwEaHtjo0GTitZIroRY7kYv3zDWz0gH+Vi559hypR1nfnAEMnOoERbgV69?=
 =?us-ascii?Q?liBq1L+X8V+9OK+JB5TTQlKmBcaJpC4c5zxDwnyqeDNZZzEsyLlQY6hLj3J0?=
 =?us-ascii?Q?Bh708EFPmYkBKJHxsT5kMy6lRa2I5+e9xmqn96h/lqf5PqC8HHfiAKYElsYE?=
 =?us-ascii?Q?FZ6/PFcU6aE0gxNACpfTKwO3cvlkdxkKzGmIFN2JHF7aPnC5yl9Xowq9eUZl?=
 =?us-ascii?Q?Le0ierEqciLcoUPM7J91Vi0Q2SI5oWGRAo1SU/5X0+6gu8OMx5pIOrjWw5hF?=
 =?us-ascii?Q?7CsT/EIVNU40EoJrqXsJ8b6aL6J9Pb4jGpDxEQ2hChNydKvX2SHk1uMJb4XY?=
 =?us-ascii?Q?SCX0AjiUTKd+LFDOTrLqubmKkWWUSAra1+UWOfmM7fuw6Heg+DMeUgWnafRU?=
 =?us-ascii?Q?zni/gA+PvN1oMaedXUtczB3Ur32TsE2AGOZEnXZVBy9y70+WnYgdM/m8HptG?=
 =?us-ascii?Q?ClpMo6nb354S/VHtaMwdliAfjiPGjDepmpWWuwft23sKw9s2mVCxxxSdqphs?=
 =?us-ascii?Q?narDTK6fuG2KXsrxL2eeGgDIKUo+v5lSgGAqpYf+eYnXZN9gyzIagO0gu3/3?=
 =?us-ascii?Q?KgeMyN2R3yYf1roy72sPBohlhi5N5Kdo5cVcGdzz4apDxXcWCUTjOspszeNg?=
 =?us-ascii?Q?t8muo3zzs1aT5xg1hDiJt9CxXnW7sOxJsucrXHAIw7NCGd8Kwr7vUOLoq3wc?=
 =?us-ascii?Q?hdSNolumPVCi/5Yu0XZbfgN5kEY3iGwi9KG0oZvMCqb5J+KfQbgXx//9CZK5?=
 =?us-ascii?Q?TABZO8uoJLBpdfQzDIrcjsd+L3IuzDl/HTaJq0bfUVJsxVerT5dUQNJ8F1lV?=
 =?us-ascii?Q?oEYfxXtWtNApkJ6hNndfl7yBEc4BuUAIAGtcYcHVuQHj0AZhH/Z7Qv3ZZQfK?=
 =?us-ascii?Q?hPgQUg0vyS3Nf+CWU5aQ0a69QP/hD3MPuVZwsh84GxKAlMcTE4orUoDRwPzb?=
 =?us-ascii?Q?lMyIZUuV8L8grjpVMutSnqLWWJ+rblQaABM6kMACd28iNC7mR/8lNYK51C9P?=
 =?us-ascii?Q?DWfQWa/eJ5rkT6euyBz3DsGYWHEPuUG3G8xw97bvATh5JHik8hBqCAw6PmrA?=
 =?us-ascii?Q?9jCqKvtkuWJqg2q05JagPZI7tDETmvAqUR8lVDcmfuSGn3U7akspyGkbAgwX?=
 =?us-ascii?Q?1vK8Q0EWG3PzwArpviYvsazRUIVy81ly19VD4qoJ1NrWkm8iz6ffKmq0tbZ4?=
 =?us-ascii?Q?3g8CEaw/NTW9R+SKh8ZXOafFN0TdUtZ3uWZ+O7IH93CrL6IkOqOYp5D2NMqt?=
 =?us-ascii?Q?vk3V0EgLazLq6zXQ0SaBoswNlfqt9KCIg4CCidvB?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb3c394e-15a6-4b94-e0d8-08dbba6d23c4
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 06:36:51.9506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ewjRI7fFyETt3sOaxucIcDEmkir40Z8fpV3z2laUUhCX9RqkMnqOKKx6drMaQd/jzR9yXek0RCOgC20ezhAg/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8414
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are total 4 slots available in the IP,
and we only need to use one slot in one os,
assign a single slot,
configure interrupt and power domain only for 1 slot,
not for the all 4 slots.

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 .../bindings/media/nxp,imx8-jpeg.yaml         | 40 ++++++++-----------
 1 file changed, 16 insertions(+), 24 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml b/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
index 3d9d1db37040..5f0e2fc1ea9c 100644
--- a/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
+++ b/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
@@ -32,25 +32,27 @@ properties:
     maxItems: 1
 
   interrupts:
-    description: |
-      There are 4 slots available in the IP, which the driver may use
-      If a certain slot is used, it should have an associated interrupt
-      The interrupt with index i is assumed to be for slot i
-    minItems: 1               # At least one slot is needed by the driver
-    maxItems: 4               # The IP has 4 slots available for use
+    description:
+      Interrupt number for slot
+    maxItems: 1
 
   power-domains:
     description:
       List of phandle and PM domain specifier as documented in
       Documentation/devicetree/bindings/power/power_domain.txt
-    minItems: 2               # Wrapper and 1 slot
-    maxItems: 5               # Wrapper and 4 slots
+    minItems: 1               # VPUMIX
+    maxItems: 2               # Wrapper and 1 slot
+
+  slot:
+    description:
+      Integer number of slot index used. the value range is from 0 to 3
 
 required:
   - compatible
   - reg
   - interrupts
   - power-domains
+  - slot
 
 additionalProperties: false
 
@@ -62,28 +64,18 @@ examples:
     jpegdec: jpegdec@58400000 {
         compatible = "nxp,imx8qxp-jpgdec";
         reg = <0x58400000 0x00050000 >;
-        interrupts = <GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH>,
-                     <GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH>,
-                     <GIC_SPI 311 IRQ_TYPE_LEVEL_HIGH>,
-                     <GIC_SPI 312 IRQ_TYPE_LEVEL_HIGH>;
+        interrupts = <GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH>;
         power-domains = <&pd IMX_SC_R_MJPEG_DEC_MP>,
-                        <&pd IMX_SC_R_MJPEG_DEC_S0>,
-                        <&pd IMX_SC_R_MJPEG_DEC_S1>,
-                        <&pd IMX_SC_R_MJPEG_DEC_S2>,
-                        <&pd IMX_SC_R_MJPEG_DEC_S3>;
+                        <&pd IMX_SC_R_MJPEG_DEC_S0>;
+        slot = <0>;
     };
 
     jpegenc: jpegenc@58450000 {
         compatible = "nxp,imx8qm-jpgenc", "nxp,imx8qxp-jpgenc";
         reg = <0x58450000 0x00050000 >;
-        interrupts = <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>,
-                     <GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>,
-                     <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>,
-                     <GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH>;
+        interrupts = <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>;
         power-domains = <&pd IMX_SC_R_MJPEG_ENC_MP>,
-                        <&pd IMX_SC_R_MJPEG_ENC_S0>,
-                        <&pd IMX_SC_R_MJPEG_ENC_S1>,
-                        <&pd IMX_SC_R_MJPEG_ENC_S2>,
-                        <&pd IMX_SC_R_MJPEG_ENC_S3>;
+                        <&pd IMX_SC_R_MJPEG_ENC_S0>;
+        slot = <0>;
     };
 ...
-- 
2.38.1


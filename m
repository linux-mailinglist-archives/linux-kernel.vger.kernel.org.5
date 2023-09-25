Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4419A7AD1F1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 09:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbjIYHmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 03:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232320AbjIYHmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 03:42:09 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2075.outbound.protection.outlook.com [40.107.13.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F656E3;
        Mon, 25 Sep 2023 00:42:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H6GQ6gKB7RzCMmUSHEGlZZctOGLP7RQoIdUSvblR35g/5DchBbfBOnNzmWvG27BBL7y839mjYxlAcTe0e6/aA8ZAbJ4ehCqKBY9K4+l6MEIQWYkYuKTT4E1g4l16JBJufYN78MJonwZZdtwRi7bBDBdqVvVRxWANRD/bQ/LJl1z5ScX/gFxLn73IZa/O8bJfo1qREXeJjs14NniKrOurknfoi9ozmuSAnluLe+QaDbpDlEkZI6Qk/Lri2IxnaBbsDKnvXHcfDpmYEoQq+f0MoKUWz8668d4FnHg8afzQxq4VO5plYm8LKyd8p8nQySlmXdzGitVXl1BkWN0tAkNJkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mvNzXaz4qs0RO3jVy9j44DkVR/y4UCbTBiwWZFrbgOM=;
 b=nCYH+cm0BZhG6PkO0OaiD6qxsbEhzQd8XJ1h+Efl4yG38K7QfTip7pxNoVaUgym8mGaGAIzMnbnJzCJ9A+VfymnDqbBlQ/XqFsZ614LatMG35zBYUBUN1XGaswsPX1dmiBg4EiR5+MKIDX1HxJJ8sVC9H8ORG7swEiLGxLeB2HC9fQnSQqYYFFCLN5DGw63FigpehGAdtzzXwkR2srYLoKN0hrEW2QD0oIdmfMsqNOONwxzaJ/gTkjjWPL5WSbqpu15kyWqb27WS0PUJwritQcWOqpSx4YAkO0ub14N4ABygHdrPQ/gXRAwy37t8EMavPyi1GsIb25k3pU0hNbgOKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mvNzXaz4qs0RO3jVy9j44DkVR/y4UCbTBiwWZFrbgOM=;
 b=bG1lKdobJOdub0OCxy/kqyBsMbiEpMXTZOAY9ZUUo77c2g+QS+Cy39E7wBodV71cG7XHBWCmCmQtvWmfhf8zgN3wVrVXiYI/vPn+iRSlczB1tKFzu5zR/hG6BsAUvx3CR42Cd9gvplwsPYcehgQ7sOpER0Nrl95V6szKhwCpr3k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DB9PR04MB8218.eurprd04.prod.outlook.com (2603:10a6:10:24a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 07:41:59 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::71e6:21de:ecb2:560f]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::71e6:21de:ecb2:560f%4]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 07:41:59 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mirela.rabulea@oss.nxp.com, robh+dt@kernel.org, shawnguo@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        xiahong.bao@nxp.com, eagle.zhou@nxp.com, tao.jiang_2@nxp.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 2/2] dt-bindings: media: imx-jpeg: Assign slot for imx jpeg encoder/decoder
Date:   Mon, 25 Sep 2023 15:41:31 +0800
Message-Id: <20230925074131.10133-2-ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230925074131.10133-1-ming.qian@nxp.com>
References: <20230925074131.10133-1-ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:4:195::8) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|DB9PR04MB8218:EE_
X-MS-Office365-Filtering-Correlation-Id: 178ef689-ca87-4958-e2ff-08dbbd9ae693
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QAWANUUPo5H7iDh8RNna8HInS3pyiA2Z58y9VghZgVukfgixKlEWop9baQLXcB145OohxbSrmZEMRd9tRyFpZ4XNcJoiDDf+IHyyGIJELSlS7Md4isqP+1POFPTqI6/B8oVWcksXugPbt/OZjJFil99dA0khvhm8VsCTSakXTOCjKakCu2vct2zg4jESF6vQ2S6IJbSfgQ84cBDR4joObe3IgrYONp1NkBJWUESq+OgIoh/u75wIUIM4pKIqCsUVwwSud5H1S06V9UafY+z6TJtq21U+KN4cA295/01mmUe0taz4IFGxloPyZ7YbCoIBrpTsSHkEZX14L13hWD3xSt2Dx0pReK2CMa8fK+UW7FRwQDQyUIVcII6a+5ea4mHO/8llm0RtjMndbpUzfVAdX+MHW5n1/TfgJLUAmNSpqeEvk7iTYW5GqHsKk+2EH/0dxiYTsodKovWEQqco3d9BSfDambM6OjmB4+0s1vFaUE/Q+QDzoAFBZBkbTLlIu9dHgpQCLEUOS61XLI9bS+a3cXFN2BNITJEdkNskcmDemES0WIxY9UEnvumJxvoDJ5bP27McRyP0T4gDE9JIwvmmk0benPI98fC8AWt0wGW9q2uMa578ng7nzSlAiCZzeoYY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(396003)(376002)(136003)(230922051799003)(451199024)(1800799009)(186009)(316002)(7416002)(41300700001)(26005)(2906002)(5660300002)(8676002)(478600001)(66556008)(44832011)(66476007)(66946007)(4326008)(8936002)(6486002)(6666004)(6506007)(52116002)(6512007)(36756003)(1076003)(2616005)(83380400001)(38100700002)(38350700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?17N43uHzzobW1QlUVdgRfoAOrUrQL60Wr3EuzVP10lAEpj07fDP9B+mxfLLI?=
 =?us-ascii?Q?GRWQQshuFIPI+e+lnSPisyhk5+bfseZ91Djr6X05VkfxvoWwgNoHCQ+OQpLV?=
 =?us-ascii?Q?JvKJEFrphGX5KvCotTuRQTQQzMuJT2PR3DWyvn4Yr4BVWl0USMjc39wvmwof?=
 =?us-ascii?Q?6J0iuXMLPokC1+XmMmT+VFtfaPuywIpqWqpItpXCws70iyFLQ5TtmEI9cDE7?=
 =?us-ascii?Q?uXLeNeJjtUs8YCnOR7likxzjUMlkeIDDhwMHrAwf3fsDcmDNPM5dle6/gwzP?=
 =?us-ascii?Q?G6TqD8Fq4wxNzo54JOwf+U3XHdMf4t64dCPzilF5a2AfTeJvMRCebRoKJz2e?=
 =?us-ascii?Q?qsJ5Tc1lWqCI8F3C+p9n1+TaHZJpoCV8ASGAjCPCwAk7hw5PJVKP0cl9C2Xj?=
 =?us-ascii?Q?PVZLg97h0usMj0etM5y7rvjuQs9zZIey2B6FZwAbWKCn0hrUl9qDAcUVUUpZ?=
 =?us-ascii?Q?FlNr/C7rNit3k8ekIcCr0RPJ/r7EwuCCwwjqNfWv8EAKQg9YwLuoK0tkAe5P?=
 =?us-ascii?Q?sWct75PUrEFbFHJjDOa2DOxB/8tQU0s4M5Ew+VnihCWyrTBjEE4DF9PA/vhU?=
 =?us-ascii?Q?sOc/gl2Kw/txRZ4KXr5GZ3pYmnxMv23qk0GxmUwwICD6s8vNCYnml4Y4AVL3?=
 =?us-ascii?Q?SnDiMIOAuZo8Q5XJUsp+hykRpO04/VqSEVVFEG7ESaqaUP+e3TK+vSjiBowi?=
 =?us-ascii?Q?mZxXWNbMccVA6F+pkvpqtZ7qGVE/VLZuiD+0d0mt6C2MeQBrIeSzQTG67Nmd?=
 =?us-ascii?Q?NSmVZ1yIc86yF3K+XK//xqXQPdqZrXpeVSBb5gugOH8+msmo7D94L/oPIpi1?=
 =?us-ascii?Q?IoziNVowt3yFbt6o1bVuzIW4FOF12ajL29CDrGlD4pf/N1Jm6jlpygAAv9Za?=
 =?us-ascii?Q?KnrZ90TlzZ1T66Z9gUz8vnThyit1bfVntvRUYd53P0oUyHHVSx4ecH1j2Sg9?=
 =?us-ascii?Q?GM8a7pbQuszp1fI6lK/4U/rTMQZypMJgiqtH4feTKZ0qKSvJO4kVNHSUtHy6?=
 =?us-ascii?Q?D+D/eZyICIi4Padx2gk6CKroPgldLKjW/nZA0TJcIf8ybqkC2ol+YxDOHe4h?=
 =?us-ascii?Q?ozOM5RiRpn/4xuYtsTZqiQtp86rpPK/d7zQU8j73DSR1XW0GyuQg273LMWYu?=
 =?us-ascii?Q?y2D/O/wR2l3+Azk/c7TbW7SlW71dx3dSkJ+DfW26ve2BrqJYhAmLzgbSaVKi?=
 =?us-ascii?Q?ZWJ2HqtEd3FjGEfhO5yFiEiMlmqceCoeNsClyY84hJUN+p6l8i8jhKy+5v6o?=
 =?us-ascii?Q?eRLYsjFF4pyWKlr6CZZc311phsodazHhcDVazBOT7kjVaCxPEQmfzUKcGLjV?=
 =?us-ascii?Q?GL2Ja5cOVS78Og4kzl3BqqWOi6IHAiJzDp1rM+BgyBznJSzrgF3yVx9tbzrU?=
 =?us-ascii?Q?nzuSV7BBDzMBClyyca6ZVXFaHnGYm/wMBouDQ4LyVSFzj6CQMRAW3c3x40q4?=
 =?us-ascii?Q?Y4/B8QOEkOLcLzAql+BUzDjahLmLI779tlL8l6ChZhdUB57nLXwCIRPYHjfE?=
 =?us-ascii?Q?6Fk95jlOHVMi3MNMcqNRBMKyKGmcl1IYVGGIQ7EXmoJbiDwX57G2+zRB4OIj?=
 =?us-ascii?Q?S3gE4xItzE6oXszzOhzi6GQPibrmdQGz0rifF88n?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 178ef689-ca87-4958-e2ff-08dbbd9ae693
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 07:41:59.6103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hdmyi7m9w529BSsaGNnEhwHAzJnDIs5w3zb/BgK1aRj6U1UpqDW9p3DsX++d+uzStisiFjpLi3g4rAxAEsZveQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8218
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
 .../bindings/media/nxp,imx8-jpeg.yaml         | 42 ++++++++-----------
 1 file changed, 18 insertions(+), 24 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml b/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
index 3d9d1db37040..df381b21336d 100644
--- a/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
+++ b/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
@@ -32,25 +32,29 @@ properties:
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
+  nxp,slot:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Integer number of slot index used.
+    minimum: 0
+    maximum: 3
 
 required:
   - compatible
   - reg
   - interrupts
   - power-domains
+  - nxp,slot
 
 additionalProperties: false
 
@@ -62,28 +66,18 @@ examples:
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
+        nxp,slot = <0>;
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
+        nxp,slot = <0>;
     };
 ...
-- 
2.38.1


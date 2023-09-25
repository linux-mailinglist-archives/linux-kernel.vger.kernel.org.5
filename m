Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 806CB7ADB03
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 17:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbjIYPKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 11:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232605AbjIYPKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 11:10:39 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2080.outbound.protection.outlook.com [40.107.20.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE9211C;
        Mon, 25 Sep 2023 08:10:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KyBGpJYJ8GPuMm8duV1ANqiGIrS/lT7qbl3teX7u/t1Ljoo9kYYddFAC1A9+fU0RxU58Rb4GgbxJ8vnb0omQyfTRJhZEySg/FFZL2eslzJyMvK0znG6tAlNf7rgUDjcqbz3REcYYvLeZvOEgfoXYE2j1cqT9WjQQnxJrlkvYGSi9cYDnJXZQ23/6qLiVssulHHngCmVzHkuKAZpsKlepKLZSqlzNsW2inuoj+UJSaAdtFms1Qs9wrhbvfmTM8TCpREvt/BvojydJIfYZegn2TKmrzsDyY/tXvw5cB3qdDU+NZY9jG8utSVWflXh4jegcDpMFfY2kcyOxBFhEu8OqCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iOj8MA+QlyeDwSu9jcml6IisrotUj9aqWmLXcD8eqRI=;
 b=eOQ/qLF2N8XfWz6we2KgQ7hS22xzMGoJiup0nW4N4GGf4Pcv6BWS3Embmq3G2lqmfx2gRHbKZFLFthmyTKBm3IavTl1CGntZ6tUAWweeX1FsGqu/S624xurA2jtT0zp8S9YyFIShmMbebICDJffML2j6Ob+9DWX2/c1XAFjtBORx+tpqym25cSxC7ioa3trXtQ9dJZf+0mFvbB/9Yrf4IZvGICXzJDUKcBvjOluPkAa01x5oItAAYf4gPjW+gqg+Ih6SI8xMO/yNLXyzSuskqmyMrVObtYD08rR2+QNcf5omPcPfNcDkf+nz737R+XpvbNacezV4uZKynds28E2vSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iOj8MA+QlyeDwSu9jcml6IisrotUj9aqWmLXcD8eqRI=;
 b=lBm2wZ6eRjARfhaariHnD/HfXLiWxhDxoZy5WZSeLuaWtUGUi3egjzRUxk1omGctylcAstVPnLDP2iwXRTn1c0VMJoW0Pf96CZZNsqT79Vt/Oc49wgrlYaewvfpj2o3uWBZraAg8jl4cGqDDE34cJHPB5WY5LkIojME3+TgoX3g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9380.eurprd04.prod.outlook.com (2603:10a6:10:368::16)
 by PAXPR04MB9204.eurprd04.prod.outlook.com (2603:10a6:102:227::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 15:10:25 +0000
Received: from DB9PR04MB9380.eurprd04.prod.outlook.com
 ([fe80::425a:a4a9:17b3:cfe4]) by DB9PR04MB9380.eurprd04.prod.outlook.com
 ([fe80::425a:a4a9:17b3:cfe4%4]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 15:10:25 +0000
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
To:     shawnguo@kernel.org, leoyang.li@nxp.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH v3] arm64: dts: ls208xa: use a pseudo-bus to constrain usb dma size
Date:   Mon, 25 Sep 2023 18:10:15 +0300
Message-Id: <20230925151015.4449-1-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AM4PR07CA0033.eurprd07.prod.outlook.com
 (2603:10a6:205:1::46) To DB9PR04MB9380.eurprd04.prod.outlook.com
 (2603:10a6:10:368::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9380:EE_|PAXPR04MB9204:EE_
X-MS-Office365-Filtering-Correlation-Id: 1516f1e1-1554-4063-c05b-08dbbdd98bc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TajW+9ICardIbiqjW7t4VtJiyZ4x6/szKI50EcXSRAtkojzehsH5aRPfvefuuMOZv5kYwK2wTZou2Pwz620K3IYswI4ZtbPu3qBGECm4JcHgTK1D9ohY4eelt3LMKwflE33tEZN2jujxj6evNC4lAxZx0W6s6e+qSkPh1Iq+MGBWG8yjJzuIBpr/CRK4gHpYpBdEdAkoFQyswgw4lCzHLe0vn897G8Mi7YGKoL5Zdj/y/G3u24bFGZ/xWM+SW+Uv1kl+QDFOYA9JHnQacqNIX2i8X5qxs/bholsqrAV/DY49SE/MkGxE7snM/KUTFHHiJsCBh2G8VOD/6by5gkZrTAOZIpG9FwIsL+Ovpi8+X0DQh+TaMe3rukwWJ0KYjhEBQofSoO4MRWqvesEIBUiIcm0OyOn7jujeaaYzKVSAdD32sdJyNl878CkJ90OABErFzjBpWLC9VQyJTtew5qK4LepeRtzqPNGXtDUWkCikINhiWru9g+2O26W9uxIJquT/pm4g7XakQOWQbhBuhQzlAs0WRRKSYElZkNiT8+IduoQZStiq9BayRqcFKfEwhx84r9Vna2rGj2X9d0FET3BuV5fZ8nDDcS77ufbQlh7i5X54AG+UPTI1z/L8aqatRBtL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9380.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(346002)(136003)(376002)(230922051799003)(1800799009)(186009)(451199024)(6512007)(6486002)(6506007)(6666004)(52116002)(83380400001)(86362001)(38350700002)(38100700002)(36756003)(1076003)(2616005)(26005)(44832011)(2906002)(8936002)(8676002)(4326008)(41300700001)(316002)(66556008)(66946007)(66476007)(5660300002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hC8dVc/beVIZFcK/65HvwB2kLQjrH5Verd+yqMWJ79eDb2xRR84co6NEpMJG?=
 =?us-ascii?Q?3f4qoX9n5PfZDquA6t+UpsOo2GEZEBndImnaE01aQEBGVIaky0VJ4V8ZXN+U?=
 =?us-ascii?Q?UGxjBKm0WQHL0CZYiQOO/+o4q24WxeVNeI4PbjPSpsejqT5PtO19WfRNUnKr?=
 =?us-ascii?Q?s3VMYQLiVjmQQNFZNRyTQ8bxceSBG53JUs1EeKt/Yi9fIwqBGoqcinn87+ps?=
 =?us-ascii?Q?TSgSY6akqmAwPx8odpT2ojixeqzL+aOKV+Rlg4Na8xCyKZJr96V9oN92oNFs?=
 =?us-ascii?Q?nD8XHyEMAdIfZonUYG1Y1USYEDQwniLZ9dsTtewZ3jlsbJbsP/7VQ6231Tu+?=
 =?us-ascii?Q?8RczBLkqkZxZs0bNb1qaC1QJiQixjNAkC3m580moofc8OCt1w1FjJPqAfW4W?=
 =?us-ascii?Q?deP0vWUs8weMESWyJJCdbqMz0bqXAytYUH+PE9uKFXK9bFqpRvutPvV6FSF3?=
 =?us-ascii?Q?JPkDn8s83qOB8WOYdJ1WS8oFSCytz7jnMQOhtTav1S02HtSOQwAzUQC9pkhD?=
 =?us-ascii?Q?qYYVL+DcJX9gA+j5wc2nruxoAKA0Qe2mUuYcnxmg68gbzyLGVRpKVFB83msx?=
 =?us-ascii?Q?yVplDTmcOz9mz2T0ic3BYuYpfIl6F4JoCKlgp46t211HJwxESZ7ZNjlVgvi+?=
 =?us-ascii?Q?1TZVRJZtIMXhg0drIjbvIrGpr2lVil0ePS0ujRxExvYtqfvQsA/A68i3kE0n?=
 =?us-ascii?Q?6fTOaOgzRDkEe/hAztLoG3u38U/cuanGPX73w8DDZJZkcxXyhjw4vtcYXPKB?=
 =?us-ascii?Q?j53cu+B7bJae8Fr4ABPt8zZYRUo3YNIJOvHNBJ/EqSQlF4bBuF/KQqL69FVo?=
 =?us-ascii?Q?jy57Kh5JrM8xZdj4+Ug6nLGw/ZZwR1RcYBoiTfRx80Ujpf3mK/p0yuN5jN5Y?=
 =?us-ascii?Q?fpw21we8+NnUv4qJv0SC+WwasMDlM+X9r251IYTd5c5Os0oTHdvryZDxKwXZ?=
 =?us-ascii?Q?Np44bVx6xL7vsO0sQhj/TmRFzcV1NHHpUs0xSBkuK/TtDXLSMfhuC4kS+ca9?=
 =?us-ascii?Q?7+8J7PT6hRczadk0he38cBwf/xo7SobB7hqvpYHB2UU/9urTIb6GzgSOhe7P?=
 =?us-ascii?Q?HSxujj5uOwtki0Que1MgEVA3Ps4Qexh2GVVNAd/U6ft7Z56pwMK8rODDLWku?=
 =?us-ascii?Q?MsP45CPN0tH9hCDV7QnQGyBt/d2VbqmzK/7VA5fl2xGmKeSmn5lw/7l7R3dd?=
 =?us-ascii?Q?SOnz65WfhgLbitdqphEoVUBAtQB1PgtU+tW3AuR2qBJtA7P94bi5L7m+S6mS?=
 =?us-ascii?Q?1Y5XLEkNvhYSbXLZNg5IoLtsV4oWQZvLZotSNfd8sA7y3tcjM8DbYpi2xrVB?=
 =?us-ascii?Q?UsBQqccQ6/yx1OyNKZU5orzXdSPxHyvBUaQbFfjQxyBRaRoW5elHgc4qodsE?=
 =?us-ascii?Q?4aTyRHlUXe8Ymiiyrr1PUq8uuOq9GOLlCABL1ap2YKXOxmyKjSGJ6PydfATB?=
 =?us-ascii?Q?GGaWehw40m9G7o3/hPUD+sJ8ue19GGfR+afYQ/SAmlwlJ6zmRibJznHgZtuu?=
 =?us-ascii?Q?9w6f8V5TJktlewAVWH4SnD4DB/8BetoSlYc33CtgAH6Mus7ZZij969Inrf1s?=
 =?us-ascii?Q?Pkh6ArKvs/EA+CQ9se0ao0iliTQQNO7EG3RmqEyP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1516f1e1-1554-4063-c05b-08dbbdd98bc9
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9380.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 15:10:25.5378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qn+TlZNLIrKVd/J28+fNXzwuUEM3OLCTc41yYJwTeMs6Wpn/SLMkRijoNweNVxYlveTOWQ9si9TkL13AjMJaBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9204
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wrap the usb controllers in an intermediate simple-bus and use it to
constrain the dma address size of these usb controllers to the 40b
that they generate toward the interconnect. This is required because
the SoC uses 48b address sizes and this mismatch would lead to smmu
context faults [1] because the usb generates 40b addresses while the
smmu page tables are populated with 48b wide addresses.

[1]
xhci-hcd xhci-hcd.0.auto: xHCI Host Controller
xhci-hcd xhci-hcd.0.auto: new USB bus registered, assigned bus number 1
xhci-hcd xhci-hcd.0.auto: hcc params 0x0220f66d hci version 0x100 quirks 0x0000000002000010
xhci-hcd xhci-hcd.0.auto: irq 108, io mem 0x03100000
xhci-hcd xhci-hcd.0.auto: xHCI Host Controller
xhci-hcd xhci-hcd.0.auto: new USB bus registered, assigned bus number 2
xhci-hcd xhci-hcd.0.auto: Host supports USB 3.0 SuperSpeed
arm-smmu 5000000.iommu: Unhandled context fault: fsr=0x402, iova=0xffffffb000, fsynr=0x0, cbfrsynra=0xc01, cb=3

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
Changes in v3:
 - move 'status' prop to the end

Changes in v2:
 - renamed pseudo-bus from 'aux_bus' to just 'bus'

 .../arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 46 +++++++++++--------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index d2f5345d0560..717288bbdb8b 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -1186,26 +1186,34 @@
 			dma-coherent;
 		};
 
-		usb0: usb@3100000 {
-			status = "disabled";
-			compatible = "snps,dwc3";
-			reg = <0x0 0x3100000 0x0 0x10000>;
-			interrupts = <0 80 0x4>; /* Level high type */
-			dr_mode = "host";
-			snps,quirk-frame-length-adjustment = <0x20>;
-			snps,dis_rxdet_inp3_quirk;
-			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
-		};
+		bus: bus {
+			#address-cells = <2>;
+			#size-cells = <2>;
+			compatible = "simple-bus";
+			ranges;
+			dma-ranges = <0x0 0x0 0x0 0x0 0x100 0x00000000>;
+
+			usb0: usb@3100000 {
+				compatible = "snps,dwc3";
+				reg = <0x0 0x3100000 0x0 0x10000>;
+				interrupts = <0 80 0x4>; /* Level high type */
+				dr_mode = "host";
+				snps,quirk-frame-length-adjustment = <0x20>;
+				snps,dis_rxdet_inp3_quirk;
+				snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
+				status = "disabled";
+			};
 
-		usb1: usb@3110000 {
-			status = "disabled";
-			compatible = "snps,dwc3";
-			reg = <0x0 0x3110000 0x0 0x10000>;
-			interrupts = <0 81 0x4>; /* Level high type */
-			dr_mode = "host";
-			snps,quirk-frame-length-adjustment = <0x20>;
-			snps,dis_rxdet_inp3_quirk;
-			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
+			usb1: usb@3110000 {
+				compatible = "snps,dwc3";
+				reg = <0x0 0x3110000 0x0 0x10000>;
+				interrupts = <0 81 0x4>; /* Level high type */
+				dr_mode = "host";
+				snps,quirk-frame-length-adjustment = <0x20>;
+				snps,dis_rxdet_inp3_quirk;
+				snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
+				status = "disabled";
+			};
 		};
 
 		ccn@4000000 {
-- 
2.17.1


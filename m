Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBE480792F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 21:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379499AbjLFUNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 15:13:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379461AbjLFUNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 15:13:13 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2086.outbound.protection.outlook.com [40.107.105.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9639A;
        Wed,  6 Dec 2023 12:13:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UgCbSjmxluW0uPVu//0Q/S1Ynvq/cd6ShY4WFC3nVN674r1IN5ZiOZ4CT1JsdY6LpstG3UFkYWuJZxkZ+WGwAAqiTaMO7Xo6SsN0v5MGyp+RoPI1J51YN4wQM3wQbVnkJxS5U2IbfdNE8DkFT54Gh0idIOeSCALigb7ER0PmwAJAbSLA4SlBWy8rnNRqz09tAQ98JBtaGBvoZzafEKZotbFyEcGVgL+YIrQSz9JrGwKhHRYi1VaoEnZl3psqobgZvW0fLbVb4mmeDDM/toAAN4DiQjUOPmm/rJ0Vkd80G/J1HT5lQ/QJS8wIqPntoa+YaJpyX465OucU82x5elfXRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nVRgza5vkrMlpm4NVL1c+VPmiT8Fv9VRp0VzVsNY1Qw=;
 b=i2D7BWxbK4+xxadHyVT6P6lb2e3fOZbhu4KnszKNIMDW0l5znFmadYQPFvuE+ZdY0gs7Tc8Vi7xYlQShxIpqVXBAzDRgGG3k3dtVgtt5MAN4y/aO1pGlgUtsmb0BimF2cirVQ3mrXCT0BRJgiyUdJrR3qGfxezwivGRPyirmwsDdE+Yfv3w+PWfZcPitYjeDwiMqFwWYaqc2oEodJ/PthxvkARUkRDaMBevPE/ILyHOZxoo9niA5zIp9SUoVbgKhNEjOEjofqMnF5bCz4QeGd6Z4gd33gmar6GrILGJyGZxbkLkJMi0PcZgfd0Jcg/Rcm7weextKcQgji4Q9w8cKAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nVRgza5vkrMlpm4NVL1c+VPmiT8Fv9VRp0VzVsNY1Qw=;
 b=ISQAS75FCOGHgNeYU+WfuLDTUR7FzZHgYmwyCnTZBd2POmSCkFrUv38LRX+IlEUMQ8YrpzIoj2oaG12x7Si+NehsDRAPSZWbk24vq2jXS8sRqAVxtSGjlnnY0v9/loUA4yQvOnb/9O03Y07y0DHregGhDjwZ5lbExBdkr3dbR4E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM9PR04MB8842.eurprd04.prod.outlook.com (2603:10a6:20b:409::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Wed, 6 Dec
 2023 20:13:16 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%6]) with mapi id 15.20.7068.026; Wed, 6 Dec 2023
 20:13:16 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     imx@lists.linux.dev, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX
        / MXC ARM ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/1] arm64: dts: imx8qm: Fix edma3 power-domains and interrupt number
Date:   Wed,  6 Dec 2023 15:12:55 -0500
Message-Id: <20231206201256.1113800-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0027.namprd08.prod.outlook.com
 (2603:10b6:a03:100::40) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM9PR04MB8842:EE_
X-MS-Office365-Filtering-Correlation-Id: d7820a84-31ea-4479-9c59-08dbf697c7e9
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OhSXwB+x/6h0J5/EsrlCAkMReL6J29FrmVg7wFOWc7j43anPHmIpaJTSVdM/2YBJLjgbliwGbmfwCQcP7Knv2ocuUZvA7wm26uqHzBuxAZ4SisLkET0oOTNoobaNFXZ8aX5AGJK1bm48SeKhpyf2faNaNmOi/9VPbvcVE3yhY6g/Cd7wcwJFjM9L9yqSgjyCOtvXDOoqwsA2lm4byoWM8JxIygeCnw64Y+4pFtU3ahgKqMaCLSipcJlAsZgaD7Y5SMhC+rsWImfF9bwEfypJxzS20ASgzn85YJ6ODd1jVqkKe2+aXbY+gYMX6rotF5zO2mul+3hOk+sexRJFpTczfoQ/6Uam2wiam63wmpSApGl/yDineib9jRxhZ54MmNCmWsQLPuV8Mwj6JzA1OAUL0sezzRGjbkhs1302BpV6TKwDbnKEmk7QdFt6NCXW0VWBkrxEGFH+x1fbayKiBrxyDFCTfpobSA9rrf9SztW2oIUi0LnpBc1KSqWCxh/6icZGlkfgMUrpJErlD+PLJxF9Yg/auioxSfl9ewcTDhG+C7sLqQK5Gc1Y/mVcRRZav4wJNdskA+6AiQdlPtTg4CRWgXM1/3uwW1ERwxHUHlpBQbygUvbPkEHWOITVnU/4Efc16XASdjI6AZoHFwL7qxEZZohVyI9P4RnSBODEzXf5NfM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(396003)(366004)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(41300700001)(83380400001)(6512007)(26005)(1076003)(2616005)(38100700002)(38350700005)(86362001)(921008)(36756003)(6486002)(2906002)(478600001)(66476007)(66556008)(66946007)(5660300002)(110136005)(7416002)(316002)(52116002)(6506007)(8676002)(6666004)(8936002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3R6yBVuL9Pl8pGaJqXzbRc9n2HFVwT0QKztl6+FsdoiO01hrvBrQUf284K4i?=
 =?us-ascii?Q?1VfH/8nrArax/S+obHKRE9X0GZYRmmaBA1xPQrd41dC99cCuOBOBQwwk2poP?=
 =?us-ascii?Q?HMtw0Igx3EIMc2CY7QaMADmpj9n6At8negOIhPLfHan61RSvH6opi5kO8iMG?=
 =?us-ascii?Q?8oKc7kENsyqBOZdEPz7o7RVdjaVZxyVmI1/rFQUBQUXsQ3SA5tmOPeFB3JjM?=
 =?us-ascii?Q?ajHd9B3MrJWayTNKbOXT/Z4D/Hx3oPMQf6HgkP9hXnNIXM0qMl8e+T8zV/M9?=
 =?us-ascii?Q?kCWmDJgYQXqgE4nwt0RG61Bp3OGkss8nWYAbaCUP/fGZ6hiI5+8lWLFdRl4m?=
 =?us-ascii?Q?APacdBMBsKnLJJzHhbgmioi4wypC38Z7Fi7wKT3srsrT4JeZe5KdLMtMlYej?=
 =?us-ascii?Q?qD04NpOIW7ljD6GPQUUkrQapGtAHkQNldIDzHA9W0N04vtCWndSL1aaKeW2b?=
 =?us-ascii?Q?Qi7Eo/7F1/vXmUI0d4Ajwj4aZJcsu/7ZFQkfGruRk3zb3F9xYuAuLSfc7VV2?=
 =?us-ascii?Q?O9JdBJlJqsGvtWPNctxmihn7BjIT9pu/Uu2BSfbSC7WAYmTRPZo1UAk+Xiug?=
 =?us-ascii?Q?YM7RTRVAZYtZ7JIH7TkC+hujqx7OMeR8r7rHshb0MiUL5UwgQdLSnAKdI0Uh?=
 =?us-ascii?Q?m44jWjKJLa49ssTXmccFnFrhAAWPu1HOVtyOSDuemxoxQtxe90nfI8QiGxm8?=
 =?us-ascii?Q?XUfGLIbdCziMmGtsPQxk0f4C71AGmaZibKGyq1iBFesSRIVcF2C6roPZM7rB?=
 =?us-ascii?Q?i5mE36haJ7S5KnYIpFrtJSFMveUW2OuniygVN/A3ddqKFl1jXV6Vnzc2DQ3n?=
 =?us-ascii?Q?Amap43sjK+9bklZknkf4hQSfmGeFxApFnLlNKdvemXA8S3Do//xy5tUiq6qe?=
 =?us-ascii?Q?4EF02/MmRsSysXkdL9zEhwjkQo/+cp5apCNSLE3XAq1VLmzIGVg3R9SCFGAq?=
 =?us-ascii?Q?2Vl1NigjQIktcs6+gEXERjk2hgX3ngbzMAs7lRfOgO0Klp8gB7UWpaLtlJWa?=
 =?us-ascii?Q?ubnTu//qDJ53xpkc8hCFKFe1AJu6WaIQEEPtfFntCf1ZQHw0k3rpcEswQ4hU?=
 =?us-ascii?Q?KwYjkbjRr4Qx8JJ8twsxJPguHFaT7e2xgqltG9csw/QCA+EXcx87e5snBpU6?=
 =?us-ascii?Q?7LxI73FLz4PjCb1hodWJ4r5lR9MxfK1m0CqlNOl0Fdz7cTM/mTX1Xtb5hfNw?=
 =?us-ascii?Q?T3foi7fE44Ar6qOmweygBJjzQsAeHrVsEZ7T6rNNATikkt5X/JhWLOcpa1RQ?=
 =?us-ascii?Q?wZ3rhXiDirQNQbkFDBTCJf1JFMylwPHCG4Lotb1SgDfSdYp1IaASNF2l5MwA?=
 =?us-ascii?Q?ehntFjxnDWot+rPXjPdGNpMevb7L78Kme2UIEtAFM/Ev7fq2HfFZbgIwulwI?=
 =?us-ascii?Q?tlEgbomkOt2HHNJdjVvrgMJS+6XQIRYUnoNlVaFtuP+eWDlf4/xzKWfS8ccR?=
 =?us-ascii?Q?yNUywBlkvQPVyry7B+/8jQH37AM8F91WCIg1GPMlRrsij+O9e4GmQPBvwD+O?=
 =?us-ascii?Q?m8xomnZwX3HasF2fNZeS4t/hzLzjzvt+3pUVC/uTLoYUBYEMI4yZo13aiTRQ?=
 =?us-ascii?Q?aSOdgYpz0vHMTl8Ukqehwlyz/bO+I093ejl9P5UA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7820a84-31ea-4479-9c59-08dbf697c7e9
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 20:13:16.0498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FaOgRoS6hYEmVuKCCfiXodQqOrgETDwqP28W4ZTB1l7GlfSk8LsXeAffMk7XUITsDkH1xSUVz3s8jHyNlf8XHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8842
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed a kernel dump when access edma3 registers.

[    1.517547] SError Interrupt on CPU1, code 0x00000000bf000002 -- SError
[    1.517556] CPU: 1 PID: 59 Comm: kworker/u8:2 Not tainted 6.7.0-rc3-next-20231129-dirty #3
[    1.517564] Hardware name: Freescale i.MX8QM MEK (DT)
[    1.517570] Workqueue: events_unbound deferred_probe_work_func
[    1.517593] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    1.517601] pc : vsnprintf+0x60/0x770
[    1.517612] lr : snprintf+0x58/0x80
[    1.517619] sp : ffff800082f0b9e0
[    1.517622] x29: ffff800082f0b9e0 x28: ffff8000819a8af8 x27: ffff000801f90080
[    1.517632] x26: ffff000801f90510 x25: 0000000000000001 x24: 0000000000000020
[    1.517640] x23: 00000000ffffffd8 x22: ffff000800114800 x21: ffff800082f0baf0
[    1.517650] x20: ffff000801f90698 x19: ffff000801f906b8 x18: ffffffffffffffff
[    1.517659] x17: 6e6f632d616d642e x16: 3030303066396135 x15: ffff800102f0b687
[    1.517668] x14: 0000000000000000 x13: 30206e6168632065 x12: 74697277203a7265
[    1.517677] x11: 6c6c6f72746e6f63 x10: 2d616d642e303030 x9 : 72656c6c6f72746e
[    1.517686] x8 : ffff000800396740 x7 : 205d333337383035 x6 : ffff800082f0baf0
[    1.517694] x5 : 00000000ffffffd8 x4 : ffff000800396740 x3 : ffff800082f0ba70
[    1.517703] x2 : ffff8000819a8af8 x1 : ffff800082f0baf0 x0 : 0000000000000025
[    1.517713] Kernel panic - not syncing: Asynchronous SError Interrupt
[    1.517718] CPU: 1 PID: 59 Comm: kworker/u8:2 Not tainted 6.7.0-rc3-next-20231129-dirty #3
[    1.517724] Hardware name: Freescale i.MX8QM MEK (DT)
[    1.517727] Workqueue: events_unbound deferred_probe_work_func
[    1.517736] Call trace:
[    1.517739]  dump_backtrace+0x90/0xe8
[    1.517752]  show_stack+0x18/0x24
[    1.517761]  dump_stack_lvl+0x48/0x60
[    1.517771]  dump_stack+0x18/0x24
[    1.517780]  panic+0x36c/0x3ac
[    1.517789]  nmi_panic+0x48/0x94
[    1.517796]  arm64_serror_panic+0x6c/0x78
[    1.517801]  do_serror+0x3c/0x78
[    1.517806]  el1h_64_error_handler+0x30/0x48
[    1.517813]  el1h_64_error+0x64/0x68
[    1.517819]  vsnprintf+0x60/0x770
[    1.517827]  snprintf+0x58/0x80
[    1.517834]  fsl_edma_probe+0x2ac/0x830

It is eDMA1 at QM, which have the same register with eDMA3 at qxp.

Fixes: e4d7a330fb7a ("arm64: dts: imx8: add edma[0..3]")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../boot/dts/freescale/imx8qm-ss-dma.dtsi     | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi b/arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi
index 01539df335f8c..5d76b4dee4cef 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi
@@ -44,6 +44,33 @@ can2_lpcg: clock-controller@5acf0000 {
 	};
 };
 
+/* It is eDMA1 in 8QM RM, but 8QXP it is eDMA3 */
+&edma3 {
+	reg = <0x5a9f0000 0x210000>;
+	dma-channels = <10>;
+	interrupts = <GIC_SPI 424 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 426 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 427 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 428 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 429 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 430 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 431 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 432 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 433 IRQ_TYPE_LEVEL_HIGH>;
+	power-domains = <&pd IMX_SC_R_DMA_1_CH0>,
+			<&pd IMX_SC_R_DMA_1_CH1>,
+			<&pd IMX_SC_R_DMA_1_CH2>,
+			<&pd IMX_SC_R_DMA_1_CH3>,
+			<&pd IMX_SC_R_DMA_1_CH4>,
+			<&pd IMX_SC_R_DMA_1_CH5>,
+			<&pd IMX_SC_R_DMA_1_CH6>,
+			<&pd IMX_SC_R_DMA_1_CH7>,
+			<&pd IMX_SC_R_DMA_1_CH8>,
+			<&pd IMX_SC_R_DMA_1_CH9>;
+};
+
+/* It is edma0 in 8QM RM, but it is eDMA2 at 8QXP */
 &edma2 {
 	reg = <0x5a1f0000 0x170000>;
 	#dma-cells = <3>;
-- 
2.34.1


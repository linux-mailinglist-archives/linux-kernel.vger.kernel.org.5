Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89E7C7AE06F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 22:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233296AbjIYUuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 16:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233327AbjIYUuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 16:50:18 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2042.outbound.protection.outlook.com [40.107.105.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64389194;
        Mon, 25 Sep 2023 13:50:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kAcQ78wnwZ9+V53QXqpOMshOXINspuRAKg+SNMjF/c1Wzz6hF4Nfn4NoQ3dKsRXlPaTIcIvdd26ysFPn94sMf4XiMYDqK35QtsC31IisBhPk0BiNF6R1j8ggi7eJIBTuo86Vpu/TX/Upj8LDDY5W14aNkbL1HfAacTmqK/A7RZe1cQxu7zNFSzH7Nk2brbdVVDJpqeT8XDC3OoswpUVsAiIWkxrKxWpCw5T77/5p9ytGoKlAkU+/QIHAd7QRcJ+TCuaid7H+Ri+Ojx2M+yw5DA5PgPxlXZ24DaUkaKZlwoUbVizKYMtVjMsWY6YM0qCBu8S5A2whjd6A7IF40jfPcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dtwMeSg2JYYaDd7iMOytnRPZ328tFq7DdCTw5j3hZ+Y=;
 b=g9Svs1aboZQQleJ0v9HuTia687Nz8OnfqjH1uJ5lrYYzyJPvtzp/nwKWYu3ZrMj0qO4UX2a7evMF19C4qPAZ4RyBNauTAm+Ii32TyUTJOQeH1eRQU1mG9K/f8LtBBYWNAfTYKuh2Xo4Tr0e/e+evg3dWXL4zRpKbglU9wkPBXlbSfNFOu7TXwOT7S6TrQc3xambWCJwSZk8j8tkVHGbNA32rTA5GOXAgk8atEZdJ92x5TXIW29cs2Opfp5OI5yIBQiCAngXksc7UiWlYa80PEc1NqG7hEckCjjRWY71kD7Jv/yjgAsJJmqddyH0011P08J8PHAcgvOrs8wdHOhNPUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dtwMeSg2JYYaDd7iMOytnRPZ328tFq7DdCTw5j3hZ+Y=;
 b=YqggJbSxihypY8FjH6LhgysJIQ8QxqPdHlIg3Sl8pbQGNbukYF+A3vd05RkNtvDXiVaBBlGbpG6hAKwgWeubi7cEF0iI/DPlH+6f0woQzThPKTpTxFyWtDnYVMsEzmhkJ2BU3Ju/zZoy1Rcx6OUZA43xi2BdZMNunC7v6YXLV/k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM8PR04MB7809.eurprd04.prod.outlook.com (2603:10a6:20b:242::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 20:50:02 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 20:50:02 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com, shawnguo@kernel.org
Cc:     clin@suse.com, conor+dt@kernel.org, devicetree@vger.kernel.org,
        eagle.zhou@nxp.com, festevam@gmail.com, imx@lists.linux.dev,
        joy.zou@nxp.com, kernel@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, pierre.gondois@arm.com,
        robh+dt@kernel.org, s.hauer@pengutronix.de, shenwei.wang@nxp.com,
        sherry.sun@nxp.com
Subject: [PATCH v2 6/7] arm64: dts: imx8qxp-mek: enable 8qxp lpuart2 and lpuart3
Date:   Mon, 25 Sep 2023 16:49:12 -0400
Message-Id: <20230925204913.3776656-7-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230925204913.3776656-1-Frank.Li@nxp.com>
References: <20230925204913.3776656-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR07CA0045.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::14) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM8PR04MB7809:EE_
X-MS-Office365-Filtering-Correlation-Id: 99bb9f5d-8527-4bdf-a3a4-08dbbe08fd21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zXYvc3j+dsX6u4Pmx0ScurUwclWKy41VJ4543ZOW22QuKAYkZbDoNH5JKUgocczDNsY8q/XdBRckLzM3D4KBUA6KpXRjiuR4meELx6c9jhLnmZg1bXq5NlSgjmEEDfBTgp1WOGYMZIeNIjRb5RfjltS1jWCi8l5P0tbaT/PbyRnF+oo/6U5yA4o1es4m/6MmjobmZoHr+vYPHCA1WRlOjZpBP7RQEoCcgvOPCgkhdWGFbfWICK6e32Q/HMxSr4R7C8dovU7fUPmsln/iinUfhow9e+nChY943KTr64xZsYxqrFW8q1Gee86D0aJrAU9Ld5k6vm2SUXA3vZlrUDbNpFA4tmjp9EpOzx0mMheN78PPPWVghWgkH19rbVdCst5jKRTXE6delY6l0TeFdH1d0DCfU+B/vnmnVOElmxkGdGWslNrgMx7D25z57mWQwhb2e7paZlnMoh+LZbVVF/S18r8iBfb/uHYscUq1YFSTCZ/iNn7RTQIplEUQzxNeJYoA6AbRmQ0JjfQ3MJgeSVcJeRBnqBWnGrzVYvyoEUsh/tU6ujrhB5hSDx6cMxHP3FYrunR5czwY1nMRVMFEhP0rQXaTa7uhRUHPOuq9uzvwcgoBCtFY3SMm82H5tolN3+oQumsplACX/dqgn8/ELLkX+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(346002)(39860400002)(396003)(230922051799003)(451199024)(1800799009)(186009)(5660300002)(2906002)(316002)(41300700001)(8676002)(7416002)(8936002)(36756003)(4326008)(2616005)(86362001)(66476007)(66556008)(66946007)(1076003)(6486002)(52116002)(6512007)(6666004)(6506007)(26005)(38100700002)(38350700002)(478600001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MoLGEcG5MqsG39XkJ69KbhGsyPjRT8/lUGpZdQw90YALM6bxeQoE0/4AVR39?=
 =?us-ascii?Q?tB1LJSzxEIARSxqwqfSt7aAc73zBuKkS+thNO7esZK430TtfFRh+G3lDxy+C?=
 =?us-ascii?Q?VxiRctfxxwhwcpgvhD/VSbuBuGWBo7qoF+Obc3+T/gu8/EwdTmTVl7EjhRSm?=
 =?us-ascii?Q?v4JlvUPwKMXTSKdFFr2jfQBqz06nB8RudSqCUeQLMD5PVZDmzxcq2frL3BI2?=
 =?us-ascii?Q?aKm3BRwtC181yuZ7/5+5/ofFNjbVoP5OVCXEgt8gzTNhrADp8ewnpHYD1T2T?=
 =?us-ascii?Q?g2KVp71ns//1Lt6QWV2NqOTX5XkPReTK4A+sE5J+bYqL8xoewNVWJsV+AGsq?=
 =?us-ascii?Q?KanaeQBJkNCD4lM3tN8n2OiCyep1eWRUC3ELU4JXZz4C9GqzOlxxqykUOku2?=
 =?us-ascii?Q?ALDVW4lODh11Bm00GM6j9S5JRb+OiYLYTe56j3EqCwVZQKWxxATUFGbcY4cG?=
 =?us-ascii?Q?t1c3geW1joCUb1RFHAdkYq15KZX6H4Dl1NdfOZpBi8YI9awko6nUS/Z56Ztr?=
 =?us-ascii?Q?nD5NN8hvoQNhkOOEeuSNiE9oITsGe4jygJyCxtNqaBUlkjKeQl4HZswdf4Ta?=
 =?us-ascii?Q?Px5PJoFyOS2HY+r3w4DKXjL50D9U5PetBVdsxmkKV3ZdS6pQhdnJzuGcNSRb?=
 =?us-ascii?Q?hN6ggXBGZFF+trSxSoPTxx2Z0XrOulB0GcOdrDI+GD6RMhwWpJTE1dKzl1Xk?=
 =?us-ascii?Q?wRSqYJ57HrvqzAIRvL7ywahvRxXlLiJ2YRPUCWcXKaQg1LCUHA7sqnxA7ZOw?=
 =?us-ascii?Q?1N4XGJq0qIu9fyFNLjF31N4fM7rvGO1Lb5M9nF5+kGHjchUzWol5Nu72eFN5?=
 =?us-ascii?Q?b3NapSutno48t8/tEyVmeD7I3k9zBP4sT+S5+5jkLk281ym7bynGvHGzFGJc?=
 =?us-ascii?Q?dzpEGspTkpH+I2+UOvsq4EPsycLffiMGSuQKpx7g/gdvPmmGiU65th1KssmD?=
 =?us-ascii?Q?2VxmYGcg8/FpTlauf8l+Wm+VC3sa1TMxgceyA+0Mu4/LDCptgYiCh6Z0YZwm?=
 =?us-ascii?Q?R1u4Sdg1DB5lGU9w4zAoZlLBv+xCRESPqjheJC6CuyRjvwkrP9z6rT96EglV?=
 =?us-ascii?Q?QLe9l0PngVR2c3PfNeglEeUtqP7sffjo4EIEQO30Jk+x5t5YLPuaXZSJO4zw?=
 =?us-ascii?Q?fFxJChy3e1XTTRQFHdgAzZM13Wj+x9WnncvCqz2NZyQ0nD2yHPnmtRcVEbST?=
 =?us-ascii?Q?vxvJEpw2yFW0IwGBTK0WAmOpiBWHn6JWWs1qmHqoSEj1KyNjzL0hWLE9Peax?=
 =?us-ascii?Q?MKLlEAACxymAcpKxK5RHc/jpaGoK6a0QVFvw97VqwSv0F9y34Wc1InAvA1Sp?=
 =?us-ascii?Q?W6mgGe0Yo+w5wRgFqrX/v6QWUa95rRr1MMTyAxps+Xt/2gAWsDe7Agwf5pZL?=
 =?us-ascii?Q?0yk4HJw0XHMUQKkW/tzurcMKPzOWquGip+qLZT7GCheM7MSKyPsDAf1kXv7b?=
 =?us-ascii?Q?4P9w7j3unyOfYrf+VLcANrVv2rbkVIlJwOMuOTOd/ujoZ/TzvilGP+fkjl+r?=
 =?us-ascii?Q?FRGGaWlrXZ6b5IiswzeD/7Wj9x4892d5i0l/P+V/FnANxKk6nn7/G6FBL+8r?=
 =?us-ascii?Q?3/dNH5rmi8p74lUC8ik=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99bb9f5d-8527-4bdf-a3a4-08dbbe08fd21
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 20:50:02.1871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jti6+IJA9epq0PcmbU4muBh5r9RtSf9xDeYkC8UUpdo86+w1xkXVO3xvxJP40xUoDSEa4URuzM5r/RkHikteow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7809
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable uart2 and uart3 for imx8qxp-mek board.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
index 7924b0969ad8..99611729943c 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
@@ -187,6 +187,18 @@ &lpuart0 {
 	status = "okay";
 };
 
+&lpuart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpuart2>;
+	status = "okay";
+};
+
+&lpuart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpuart3>;
+	status = "okay";
+};
+
 &mu_m0 {
 	status = "okay";
 };
@@ -340,6 +352,20 @@ IMX8QXP_UART0_TX_ADMA_UART0_TX				0x06000020
 		>;
 	};
 
+	pinctrl_lpuart2: lpuart2grp {
+		fsl,pins = <
+			IMX8QXP_UART2_TX_ADMA_UART2_TX          0x06000020
+			IMX8QXP_UART2_RX_ADMA_UART2_RX          0x06000020
+		>;
+	};
+
+	pinctrl_lpuart3: lpuart3grp {
+		fsl,pins = <
+			IMX8QXP_FLEXCAN2_TX_ADMA_UART3_TX       0x06000020
+			IMX8QXP_FLEXCAN2_RX_ADMA_UART3_RX       0x06000020
+		>;
+	};
+
 	pinctrl_typec: typecgrp {
 		fsl,pins = <
 			IMX8QXP_SPI2_SCK_LSIO_GPIO1_IO03                        0x06000021
-- 
2.34.1


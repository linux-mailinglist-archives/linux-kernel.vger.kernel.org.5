Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA16B76A6EB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 04:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbjHACYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 22:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjHACYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 22:24:48 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2079.outbound.protection.outlook.com [40.107.21.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A803A1BF8;
        Mon, 31 Jul 2023 19:24:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XbiQDgYRQlc3U2j856vTDAC1hWrO5SZ4w7dJSDpAbMmeZOAW54z1iw7cr0XeRXIGkFI7C9ysku61LjDgF9jSHfnvKqmhnPadv6mp93cnojcUe3wIKBCnYocrPuyPgfYZaBUy0de/eOVICPdswV/rZITWy/vg7xfNbAJbyod6y0SxN34p6DWV26YT6Q30UC11faMAe9bQFxVcqJDN2RRgG+fraCFhqvDUIa66+0umK9CV5oBBdC84dek19njZDoSCSL+A9uirCkz4EnGOlxcoJ8NQ9zkr7idkO9EIyFDjwW6eNYxyiF6dFM9d+9Gt6BOZtn8FQduQJ9Byry26Mc7nFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zig7axDUxF1Zm9ohPVaA4T/rg27HQc2URnVNCVKBDNE=;
 b=B3pYs20of8spgm/+MgngNIpx44u6++o81xgKoFAx8knOiVcbiiMCvzsjiu9+6GObl4cFZdCsDr1FW4GoRVZlgQkwnXrHs002m4XQS1HEJmV8iKbWsMPyFiNK/s9580UizplbGo8Pdq0N6pY65J4YfHz9tdgpgOctiMENjaTM6s4AjxTz8N2C0GJfZVHA1ZKQPn7Rv8Gjoc+5JdBYIWXvMosjz4EMvIS650FMiyrUhssTMxbXR+hzUvDcQGS2IQYe0WBNjsSrWv6KFk53JVVaFxvBoKcpekBLS1G2EXKbfrzMiEKiA48t7lm3vefED8ZrctnEph38XS1zeYyE/WROaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zig7axDUxF1Zm9ohPVaA4T/rg27HQc2URnVNCVKBDNE=;
 b=lFkocitrGoifcWQ5wYI0S5DB5nfbRyfMJ3RFuuKYo5n53udSKxpWWmKjjsQYZRfb4AMb7VMRATXZdWuAb4xeyFIodEOkNCrdA0uIActYqbKRYkxglxlpoD+6FFnY7FWG7iFgwssSCxtuq8tB7Gy6zExX4coaYktTFFUC6vjtORU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by DU2PR04MB8856.eurprd04.prod.outlook.com (2603:10a6:10:2e3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Tue, 1 Aug
 2023 02:24:44 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::c5e2:98f8:b03:2189]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::c5e2:98f8:b03:2189%3]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 02:24:42 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        atsushi.nemoto@sord.co.jp, tomonori.sakita@sord.co.jp
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH V2] tty: serial: fsl_lpuart: Clear the error flags by writing 1 for lpuart32 platforms
Date:   Tue,  1 Aug 2023 10:23:04 +0800
Message-Id: <20230801022304.24251-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0075.apcprd02.prod.outlook.com
 (2603:1096:4:90::15) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8404:EE_|DU2PR04MB8856:EE_
X-MS-Office365-Filtering-Correlation-Id: 0467ceb1-d5e3-4bea-cca8-08db923676d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /bbCn+Mw4UZ5HO0gEmU7kBBAhSYQKJ7Onym3DmBKKkxA6s+3lj0S1RsgxF24dgWRjHDAMb2PYApVVAUwX8OKQVlIA0l2sbGiY0MrdYqpc+NtbJStVJupJgCvYzTjKoBcGkVpgOmNiYD/hl/gSKR9cKwvhlnFFCeFjFSPsbVdhJtFGpwfQQxUJreP/tcKwA7D8hJjolCOXHg9o0BFAq0/gbY+KBFPxRhwbcmrMDeotX7WjdoHs+2mtRQmulnQpWot/pNJujZdo8QQ5Ah8aXx/BP8YeBsBpZu5/Xp5ra8E6ly4Mwa06wRx9zoBBOsZ/1SgxT+pQ0XN6LiEa9P9HDRgXXyWfzaaLqCR9Y96A+0jaYeY9cRBcz/FYnR6NEU6v5oTCMvDCFri2LIi1vnuKsUy/13o/z4sHPka/g+k6D/Z8vY2YZQ6v9jsvk/qk/zsRI7DhyHQ/zfEABqU2CnnsolFf/mECzT+5NgNGZBvsWZv38LjE1dkcQECIlnb82er4u2SkzVwLpbLJXOb9UoK+hCv2XVSyJs6fuMuKsTCvB5y3KYP7l0nlrYKCOitCsuQ5bb0VAG+lERXHgIlJ4U0jAiyHr4qiPxI4m2JwbKfxXgdEizNXtbLnJBaHEyxaOUyiFIU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(39860400002)(376002)(136003)(396003)(451199021)(44832011)(6512007)(6486002)(52116002)(36756003)(2616005)(6506007)(26005)(1076003)(83380400001)(186003)(66946007)(66556008)(41300700001)(38350700002)(38100700002)(86362001)(66476007)(316002)(5660300002)(4326008)(8676002)(8936002)(2906002)(6666004)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c9n5qS4gV7rWc5QC21lesxHPQsdMlay1kXDwmzakD4RmoXpk4UtOYovDVpD+?=
 =?us-ascii?Q?IeNjyOJjIZGdmECPk+zFwqSUv9nk8LaTH8pdWuJKx/od73ODnyV1t/SAhrOJ?=
 =?us-ascii?Q?UTygE0bwidh7plHdAX7w/1teFpzoHh/gHljrD3jkFzuPflX8+qO4PUqf4uiv?=
 =?us-ascii?Q?CcEASzcTkjplnmCPi75MJ9DgshGSL9EXsKZn/c5OSCbHcndCMqrMzwTg/m9+?=
 =?us-ascii?Q?zloMm+Tkc1Op+QA1WXErxNNE8/0M6q4KxgOw+eVhY3Kzglpmn4QBOIKvUIOA?=
 =?us-ascii?Q?DWgtBx4ZzQ1ZUWN5Rin7EB9b8DqY5JNJA4CHDSFlYGIMtgmuM+fzJK0mKXwE?=
 =?us-ascii?Q?OPjwl/PzPt12s46nFbyYh1I7zqDUlUZ66ZkUCSOPxauR2Z5SAMxBb7NuhM7u?=
 =?us-ascii?Q?5CjqVJOCMuHNmklv3WdzfVwLEhtKbQlaRqMbR1HMTKjiMMctw2JJLWysiC7E?=
 =?us-ascii?Q?UbcKqqQPOYZSgzmer4sZshvYCDCDBzAEboN9ypYXMZA9aMRQtDF9mKcXEDct?=
 =?us-ascii?Q?48KpW6EmtOQbsTunFU/NgEZKUOPgdv6rPjaSgFfpF8f+ZgQN6dKuW7RLziaw?=
 =?us-ascii?Q?lx6rJBysLiEslOMFZsxZ3XtCgvmtRZu9r8zBXTIYUNNX1xPq/u1/fUMq/b/r?=
 =?us-ascii?Q?H1XFWnwLmqu7nn9zKS+GFJyKQlCg2vD0T+4jKl5I1cN4S6NRBy3rD7qmX1V4?=
 =?us-ascii?Q?jaVoBI4MP8ec7BDUFYwQGBUFk+zYIOyAnudePVB1E8sNYKmYLDMbLe7qodvl?=
 =?us-ascii?Q?YS0wM9DVHmUGPdwXT7cRGdcLVP5Yas4BYz/ZsRDESiIHy2ve3LlDU8sYPLKw?=
 =?us-ascii?Q?tgST3FtTOsr28qotgmOz7X1ULwDjzUf4aeCFJW2zLOfcNupDoJGOXsrDDR9M?=
 =?us-ascii?Q?jXCbNLk4vgixIjItueC3jR5Z8jzeifRpWdqal53L9Sbw4Ki5W3Rtmm/QDJ95?=
 =?us-ascii?Q?djwCYWpXpRX3Ur4spH5iw21HfQorp8MgCpyUjDePCY9dvQ+6TgEoY5VEsfPE?=
 =?us-ascii?Q?6lIbmoPdW1uZpiVWp2DtaBG6xg1jZIfBf/nTqQsosEm6pInQk7NYvJg/8Z5W?=
 =?us-ascii?Q?/1bQmF0sS+eTiyfhWxQRcm9LiBavkxADAO3LvI9hvcwERqQ1V86SorzN00MZ?=
 =?us-ascii?Q?hRsZ7aQdHCUd/uJZVx2X8nF836z2TEie/ixcnk9hlEmlWy0Y0wV0HbLFVldN?=
 =?us-ascii?Q?wGQVSmr7wE8TQ4c5/XpgnAg+b1z/JSySe92txUnjPW2sb8joVWDHSpYx2FHN?=
 =?us-ascii?Q?+cM4byrKoch1+ZQQVpjxXeBFiaCp7dIYWdzfi1sPAKQthRAxmSH1fX6EYVfT?=
 =?us-ascii?Q?9hkLkRS2KrUSIze2lY4iAzpfgfmER2SdysT8eg9GxdbfztcWWX4KMFTzRCDM?=
 =?us-ascii?Q?GhhG8HTBvgCcFxJ7KkOpGLk1q7OIBsc2YiY/hwsYZa/SvybP8CjMCNnAKqIK?=
 =?us-ascii?Q?pmsBugrKp+XJmeqDo5fhvpx5PJHclxlkjIpGK0gZvDrTe2j4IMWNaInbQU+W?=
 =?us-ascii?Q?GrFJjkweBDPSkPn2atQhYDDK8PYAp0sLFnDOCsgHf1Q/Vwrqe4iH1NPN7yZI?=
 =?us-ascii?Q?bUh4AtcXPD0j5zGtusYUDIw3tIkL0IWGxqCcafiT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0467ceb1-d5e3-4bea-cca8-08db923676d7
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 02:24:42.5922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MsyAlycon3DAhZO9PzJYxZBQiCLFNMR+jZfn8JkLo+15+BZ7uHkRP5JG4MMIaBZFzB4ycI9wmhnwqJ5Yu9QJig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8856
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not read the data register to clear the error flags for lpuart32
platforms, the additional read may cause the receive FIFO underflow
since the DMA has already read the data register.
Actually all lpuart32 platforms support write 1 to clear those error
bits, let's use this method to better clear the error flags.

Fixes: 42b68768e51b ("serial: fsl_lpuart: DMA support for 32-bit variant")
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
Changes in V2:
1. Improve commit message to avoid confusion as commented by Jiri.
---
 drivers/tty/serial/fsl_lpuart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index f6644c5989d3..f72e1340b47d 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1120,8 +1120,8 @@ static void lpuart_copy_rx_to_tty(struct lpuart_port *sport)
 		unsigned long sr = lpuart32_read(&sport->port, UARTSTAT);
 
 		if (sr & (UARTSTAT_PE | UARTSTAT_FE)) {
-			/* Read DR to clear the error flags */
-			lpuart32_read(&sport->port, UARTDATA);
+			/* Clear the error flags */
+			lpuart32_write(&sport->port, sr, UARTSTAT);
 
 			if (sr & UARTSTAT_PE)
 				sport->port.icount.parity++;
-- 
2.17.1


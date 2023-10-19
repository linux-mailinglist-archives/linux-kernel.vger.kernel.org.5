Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82F27CF2BA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 10:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbjJSIgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 04:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232850AbjJSIgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 04:36:51 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2075.outbound.protection.outlook.com [40.107.241.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D03129;
        Thu, 19 Oct 2023 01:36:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fxIhGYgaFq6jnq6fibAuc3+/FLkZw53zHxCRYIstM4feh20xrJSviLQ/ZeTR3aewXFCjssZBSI5v7zi058lNmSLOSsX2WBUBvWMWUPOnJVgGnajSU1yJEIdoziddj1mpk9M7fZeV6EJeipWL3wlkCbVLsYCA0OeYN+RcIXvWeA+unYwuteJF0Mop4hrRGBuOdviZgRLOxy/TCJWDTwYXMxHrEa+XOQnnh3YQDy+AKXG6zWimUms14zh1OxmKVmk7e3jH0LzXW3zs33ZR8c/S6IGFxZuLHWK9Qy4eQtXi0MgVS8eUvI6GQifmc4mHWnvfFxL5dlhB9yNjkaczbn9TNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WiBsrDiMvQG6nGHZcDZsI/8W1cXfZT8iJfdlQPp1hro=;
 b=hiHzG7KzqumrcVcKsEdxXsxEw6MIjxEQ6cuIcvfxYyO0cmHCYzyrsMHt3zlzVI/Z/e6ziB315coJoTZCD4qv7fYGofSd3oIBvtYpW6WdM+2atWujzNYSY/iYRvumQU5qKuJsCuLr9lQGAQS62mUFb/eLjjFTbNa0gCR6COfE0aXjH6BtkznyMNuBjoDUtSu8jDWHjh/38EYH/tghfqOsu8DMEV6yNE3/1JVax0eBTwWaG4zm/avoZP+UcA5wFaaSQ/T6f+0INaAbvQNDgSz/Ls/lDFUb8AvDH+NsYktbL/rhXRW9MJgO8Pt/ahq2rzOzotIYf2Wig5ADqdOnHcxZqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WiBsrDiMvQG6nGHZcDZsI/8W1cXfZT8iJfdlQPp1hro=;
 b=PkwEGb62OjnGwi2Qlsj44nw2PtfQXkCztPO+OMH8arWbIdeeJJeBVRMUVM2HRqYAeeWn4mbXUEqlLHfi1Zj/NhQzRNe91rNT/mc7tug98+KIOQHPsEYJvDH+xUge8jl45ZnqEqOqHvhhmJxKqV3OVjITn5NUFgeH9sxUOWow5go=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AS8PR04MB8724.eurprd04.prod.outlook.com (2603:10a6:20b:42b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.7; Thu, 19 Oct
 2023 08:36:46 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::6e53:39fc:f010:30d5]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::6e53:39fc:f010:30d5%4]) with mapi id 15.20.6907.021; Thu, 19 Oct 2023
 08:36:46 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, eagle.zhou@nxp.com,
        tao.jiang_2@nxp.com, ming.qian@oss.nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] media: imx-jpeg: Drop initial source change event if capture has been setup
Date:   Thu, 19 Oct 2023 16:36:36 +0800
Message-Id: <20231019083636.10762-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0131.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::35) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|AS8PR04MB8724:EE_
X-MS-Office365-Filtering-Correlation-Id: a08754e4-a84a-4bbc-c47a-08dbd07e87cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N5j5eiQYpJTAX8Sl7IlXMQ/V4eDG/scE3QLi9IwY6GCPK3OUxQadawzyl0op7sZ6jAIo1pfnexU880yA3ulL8XKGbDmQQwSsioRdTsxE5zkdGgdDD+vTlK91O7kX0Pnuof3aXKDI/Z5bpn5HzIlbPbliCPmCzhabp+NM4cYN9RxWIOCVvOF/LuC/SW3sW5ZSpervSe6bgUMweJJKkeWdThjl4ffdOuYdUCfHnHhQWru00GVQx9aje7hCJpMVI3WbcOA4JpTuiYivHBcxUPPQv/capO5Ejdzqht+nBicollFHps+/TUjcPyHStKxWcZbQBI90yJPVFMhKJhqcTqz7BuH/rqaYRGhZan0Ixh4fYygAlu1Q5dXjIZu5Ui16wjjsyOkveoCjm5zHkxP11F+BON6/b+akX8YqF7IMebT0tSNz1j1LjZOseYepL4aNZDTOmCJuRiahyLde/fUCuos7nzmrrm98igCpyRialF+X4qqkFIoQCmr94oHX+hCgbzN9mYwvMjQyoiRTn1GAcSgOL3EClDMSQpJwMJD4XptOzb/KmdvjjroLefGWeiJY3tDPIo7b69vtW1VdNHqouWTMVY1v7xY5h/hehmKJaYfX0/rdtozivksf/QlSSNy0xA+B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(39860400002)(396003)(136003)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(38350700005)(6506007)(86362001)(41300700001)(4326008)(36756003)(2906002)(38100700002)(1076003)(6512007)(26005)(2616005)(52116002)(44832011)(5660300002)(8676002)(6666004)(478600001)(6486002)(8936002)(66556008)(66476007)(316002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qlAO2V6SkQvSXZUbvvDTqNPUiPa6SNmgGTSU/pQ4gX6gjytGkQKrejD+xjWN?=
 =?us-ascii?Q?7fAscAVqm3DAWhzlrmQrwUQvZl4y2Y4SW+QqerMTzzENk0B9RgCYuQJevCsi?=
 =?us-ascii?Q?HkYb1k3lK8Tcm64n1XFKQBz+AezxVl3YswI5OAhJNSPZ3dDyyyS+/0pQ/iDR?=
 =?us-ascii?Q?CpxxF/fATBsSdzf8ZJpcFkTdWQRl0cPFqW3ylhFOsilfYBsJYF7D5BFaA06c?=
 =?us-ascii?Q?vbwuzeoyP4mUu6G9BqANU3OFcWm7L5NVaMnCgDaW9NV9RdwlWst8lmPMUzxD?=
 =?us-ascii?Q?ZXiP+OQwnpV3O06CBlR6kDHZvz9WrZS5RxdowTe/MIbsEjEr2Bnbd46l2lfr?=
 =?us-ascii?Q?W3j7Ls3EmUcnSq1s2lWmlFRJuLsRDCulUxd1YaQ4YA9xxJ6wEsM/FjYWPRzi?=
 =?us-ascii?Q?k510652hj26RTWkixhu7vXydB3LwCyS62rkcb3r70g6CrWpXWPiTmkuEZ6ra?=
 =?us-ascii?Q?4LrayloZDyTYV4LttyNd78HYhZGnHii/AVLFhPXcJhE/7Cvrb+g5zNzJVHaJ?=
 =?us-ascii?Q?NYP9WmDHSRjgNUAatAujMs4s+wggAuc2uiOeFi174PH5wbBX36sEXJSzaqvL?=
 =?us-ascii?Q?f/YCwE1X0pIUgaL1kF46j0WGk4WrpwtE4bB5DX2KtVHv/2El7EvWjw89i4q4?=
 =?us-ascii?Q?GuvtOe8AG5lfCHqwbJuYwHFhwp7EX0YpTHzzd4LYtIGuJ24A+fJXqdIO0x3Q?=
 =?us-ascii?Q?/76JPEvG5zVB3QrXJNECiqCJB1diGg3ul7l6WWx6vwxaDToeh5glbcZ3pr+K?=
 =?us-ascii?Q?21vonTilT+Y/ns6UNpq7HRwtpMic/6CY04fETDtKzDC2ZmMr7xBSZbE5p+jw?=
 =?us-ascii?Q?J6i81Wh4D89IMtMO2C661W9/YpM+IOlsWHI7czfNcR4I/St3GobXrxsGkC4c?=
 =?us-ascii?Q?IQp503BauZY5LxeczIw/igPR7Sfg+F5bpZlyzKEs4MWDoJbfE+0q0XuKSc/O?=
 =?us-ascii?Q?v37y7NuJ/PGRaxGTvl/9ZeFXePEqQ4fi2S+5ggp74CE5P/A32FQgs5DBQ2X/?=
 =?us-ascii?Q?QKDhUrdPHJqjCM4q7R5cNowbXwAq0Q4rCr9FW/qisbt83GhPi1rq+kBZU624?=
 =?us-ascii?Q?UgGYUx7UvfBJO4e8uXcRDqJOW85jT8l/iamkdLZBtCY2baO2SIC1W3Py3kee?=
 =?us-ascii?Q?8N93o87pBsYPZzcP1lQaUHUYIFhd6cZn4dwnGt8koa0qSgqk8G/hsigVbxNu?=
 =?us-ascii?Q?tx5CQ/zpwT99m/f8U1vmloL8sZMXo46OzLiyxsL4IqOXVhe9ADK+/mzafEuu?=
 =?us-ascii?Q?2MaaNszkW9HZ/RLz3OlyyN1pZcGfO70wqARu37mFXZfDifmLUTLJI1FQjkDX?=
 =?us-ascii?Q?8/Wtw62eB1icEmm8yYhtvY4xokK4uzbOY8/vzwfVVg+S5bKn+Oc4XQX3IpPK?=
 =?us-ascii?Q?SVJo05XxgZDYq/R8bhkm3Y87gsgBYfV4ABCwgdbk9PH1ZFzn069pf/SH/x6S?=
 =?us-ascii?Q?4jNbTM3rxCK1cwz8wygScV0QJ6fxFfrUM2uJXsd4LFjj7RIC/pjyLnwwBNhr?=
 =?us-ascii?Q?d31mK7f69xEmG0cIoBF5uIzM8pO7EpCmro1oNCHHDWHLqqGkru+hp5MBdf2I?=
 =?us-ascii?Q?5TndHjanRmsr12lvM9xJ8xy6Y5L0NwQoBYuTAaeA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a08754e4-a84a-4bbc-c47a-08dbd07e87cc
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 08:36:46.7152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lmGQZde6rzchfSql1nAhz2WNIdlgnAlsvoMyAk1Pesz4AkziGZTv5rCrnN8YJ5GOUF9I7bPuHJtrsgTS8MI/Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8724
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In section 4.5.1.5. Initialization, the step 4 may be skipped and
continue with the Capture Setup sequence, so if the capture has been
setup, there is no need to trigger the initial source change event, just
start decoding, and follow the dynamic resolution change flow if the
configured values do not match those parsed by the decoder.

And it won't fail the gstreamer pipeline.

Fixes: abf5d3c5bcbe ("media: imx-jpeg: notify source chagne event when the first picture parsed")
Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
index c538440abe8d..c87603cb4a6f 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
@@ -1632,6 +1632,9 @@ static int mxc_jpeg_start_streaming(struct vb2_queue *q, unsigned int count)
 	dev_dbg(ctx->mxc_jpeg->dev, "Start streaming ctx=%p", ctx);
 	q_data->sequence = 0;
 
+	if (V4L2_TYPE_IS_CAPTURE(q->type))
+		ctx->need_initial_source_change_evt = false;
+
 	ret = pm_runtime_resume_and_get(ctx->mxc_jpeg->dev);
 	if (ret < 0) {
 		dev_err(ctx->mxc_jpeg->dev, "Failed to power up jpeg\n");
-- 
2.38.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F287B1231
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 07:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjI1Fhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 01:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjI1Fhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 01:37:52 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2042.outbound.protection.outlook.com [40.107.14.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2B618F;
        Wed, 27 Sep 2023 22:37:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PGtol/2uIBtUmRLXQdASvgbRWdRAP8ChbMsoZO/euaFL8vKgZSpE0ff5xXW31Ia1dpxh/FNr9JzWYohlLUyPJAQ2dsOg1uFQvwjWWMvgDtH3qliYVtkLvB+XH3qXIyyHj7Z5HTL0ynKNpXaOXcxMT68ehTvb52r7dufTV3ekLYnw6ammPFejA92kGlZc6StteTSa77tPtaCc5SHlFDQB0SsX3lrQmRv25BjJX+YBhwQpS94A8MUtnR3Q7I7VSVZHY0GcpVUOewbVIyKsQKzu1p9WP6JwKQc3JdVVDKSlNDq309Gr3WPzkBV4Z2/2tsK39BWYusvADvWkgUMCcpGXmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ud4oAkb+sU/I9dzDqmSC+IW7tNJ6ougwqwea1mzmD78=;
 b=MRv3HuQO6dXh+hZ0LpjPCnP8ww2T+QfgCGdhIIuFIYgkTqPUt1l7TcBGQ/wvO/BEPk+6svlR3gYzehXCoyGwCVUI9N+aJkMS/rdeiHlzIGfSW2lyvx7c1+LqH2SF3HE3kVaSoZbAezHwayZO85GlK7+jWimUA73DmElAtQHB0+plW/YJLeTzvmx6ZDzcxeTQnVmpYDwYH2+RUMqSK0fAw3SiHskv5P4ryhOBRYU+8mNh+3jb4NXGMHTC4ofW3UqUMM2j0FV+koXDe3yOd83X5IDku/S2F0Dlw+Ea+eXynuH8mOWmFqd82j4mAe26/06Kr502IY1ClkYabVONeU+T/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ud4oAkb+sU/I9dzDqmSC+IW7tNJ6ougwqwea1mzmD78=;
 b=mC8GPnOBZ2wHH5Q5ZIChr/AIAjzF1Lm+QGmA5Js7F7eoYcjpdKC4SK1h3FnXFK3XFLLXxs+KNDdKDyealGUMq1hdRfZvOqQhDamJeS4ae2QU+SqSjbzuivoRL3OMVo65fqss64tqcZKVn4yrMvhSfPxPtdDU8dXWkBO2SgYQ6XM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by VI1PR04MB6912.eurprd04.prod.outlook.com (2603:10a6:803:134::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Thu, 28 Sep
 2023 05:37:46 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::71e6:21de:ecb2:560f]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::71e6:21de:ecb2:560f%4]) with mapi id 15.20.6813.027; Thu, 28 Sep 2023
 05:37:45 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, eagle.zhou@nxp.com,
        tao.jiang_2@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] media: imx-jpeg: notify source chagne event when the first picture parsed
Date:   Thu, 28 Sep 2023 13:37:23 +0800
Message-Id: <20230928053723.20765-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0015.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::21) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|VI1PR04MB6912:EE_
X-MS-Office365-Filtering-Correlation-Id: 752bc49d-c827-4b34-3327-08dbbfe50a95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V2NeUcnq46zCjbq8STQhchX/b8Xaz6PBn3L08Bk7ln/xacXsBVxbGDOj8MU9iiEusFEA00PLSLhMpHbQ3vty2dhsOfWEsOFNKAIAYPSkVHOcmK1pe9LXUnRLcVZB0cYc/RmEwxVTjHCpYqNvcY/3GWubcSx63v0ZvaF1+NseeOz284PTIBA05yK6o6QsNZQei3ahyUWhbFJ4+wO4otr+sOm7WBr7SL8FhKk8OkQiy5Z8WLl10meHrD7rLenb8tz/0uZzZ4k93UQoViyYxoVGQCh5c3fTfzt7WRb7whdYO5UN8xsf6y4uR6c4WZAsiHfj92eP7SFoTU3dGXmVceiZ8F1+LD0MOfViXOXFIpAVQsjzdVDOhJskx2U8wrH+Gsd3KksFnPZQUKS7ewvVgP9tXT8EqMzIO/fby5l7RQeFZd4bVUOg0JGEXaAtMSz05jKC2OVfdE3ZSFKHUeOL+W4aJfWXNEhTSV9j3fWS/7U3vsSr0SzWt9B7DamSN6U9sp9e3cvXfIssomMq9CO1a2/5VLsvGPUe1tDEdBfWFTWR/TevbSoHXPwbJbv/qimGj3E2hYoZgWE2MEe/Z0GxhSWyYWWX//2T+JYmTQids93WKhg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(136003)(39860400002)(396003)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(6512007)(316002)(2906002)(36756003)(41300700001)(4326008)(5660300002)(8676002)(8936002)(66946007)(6486002)(66476007)(6666004)(2616005)(478600001)(66556008)(26005)(6506007)(966005)(1076003)(44832011)(83380400001)(52116002)(86362001)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ilMM/09iGlsi2O9VUdnwmpKUARt2BMP6OMYcabgBKF+3yFwiEhCu3tX7vmCq?=
 =?us-ascii?Q?ie3eIode4iLhgY6VptnvBsYlT7UB8Z10M4fgB/qe+BYm/wFCFf2vhzUdvSRx?=
 =?us-ascii?Q?I+HRoe/ifcvxrZD1KMezJM8y5kTjwYXbZZ5DGLNhajdGKI9Z0qZx0LlnK+kk?=
 =?us-ascii?Q?5jTHMzNWEcLcUy0ZmQXU+HnWd6wBRT3nUVqhPxQTK1PovzVjWPoF7ny2yZpO?=
 =?us-ascii?Q?hn9NhiLd5YViq0TgYcb4Y5pFWeRLVwxyGPWBHqsbG6/TVVfpGr9TxuHqbirb?=
 =?us-ascii?Q?tJ9VT0NW0Nb4NmiH/zazTMuIe2ABXQe+f6vlcTXZTA1RjafVNPjvsVZ45wII?=
 =?us-ascii?Q?jWZk52KR4y3EgH3LwsKbLLY2yETJIXMgVH8tI/pBo/ZRBFrscxH8f7bBJogN?=
 =?us-ascii?Q?fe3Cyx1Y3Ry7pmWaxvAdvNLEl0oYssY+0/YcG1+Kd3kWX6r9qOVjBBCIR4yk?=
 =?us-ascii?Q?9gjTGZJRmMrjz6LS3tykJJDSYnyGSzvhjaa7soMC+zVPdT4RniTM1M2qbjMN?=
 =?us-ascii?Q?b3TvOJPo1qF4yyBF/TApVM1xLQaBW9XMvoyWvzwyPEMkFHkVZD8VrQN/pkpv?=
 =?us-ascii?Q?O1k7th4mnNoXoH+SP7VgKUtqm+7HnyhRMuTh29BcUuio9J3kJj3TNFtiOG3b?=
 =?us-ascii?Q?sLCJs/f9XoIc52nhpmpXXmhqatw/pi6T+6Ji/zjbdVylZoyd3wUzB34QEGfT?=
 =?us-ascii?Q?7K+FZ0GCt2bhsoDyC55OyCNpNmh7At032qRRcpytnXqxHzLAb+hsA7DqbULX?=
 =?us-ascii?Q?PUonB+z9twpHObHFyEF2rdSEC5qzNpDRR+A6kp61BRY77w9Zir58niCK0vZQ?=
 =?us-ascii?Q?8QuKPOUuAYbvvbI9C2tQdHNydwwk/mKGR+KJQ54VJpAeRfjIXVc2rqW57RjB?=
 =?us-ascii?Q?+jNtDe5xK7fj/erpLaZKaA4wrHlaAgy3VivTp5BXWMPTVRDEYW4bq+XGwBPi?=
 =?us-ascii?Q?uUXB9OiVBPbJ4BoSjmLpCLhFxfMy2tfpqPgq5qCFKHtB4lqXGMxpyua3QK9o?=
 =?us-ascii?Q?jnmN5h0NgKFuT+eRIVzKILW2xLC4LmlFLfZhUE1B6qPS40UwdlBwXbeAB2Az?=
 =?us-ascii?Q?+liexgge6sa7dBpBkGPYk6l8COedmslsaa9K7+3zlVqWa0xDLe7euxB6+Qfg?=
 =?us-ascii?Q?e3S4YdvCf3MS1y00vpHMY7HOz+wklDluapvX1cy4sPaDjKhGtwequ9kOSMon?=
 =?us-ascii?Q?DR4d8c0v4WJ3vfpzPOqIJYUH+QJpqCv9qTpP4TbTYwvX/lPMGNn3lO9IWgAf?=
 =?us-ascii?Q?bT/KgL90TdC1ScbBrqVCA3s3JLY7UNCo1k23DcVzla7tyBnmapgclW3tQvaM?=
 =?us-ascii?Q?/k+rIKBb4tSLmfm0eNog8yRMqqxRgGT5vHoy0WJJZXKRJ47PXwg7PSIMwa1F?=
 =?us-ascii?Q?Nv2azJAteJxX7bCuN1y8ZBVbR4diwZGK5KKZ7e+nt6dhreS/SpTEXQDY1yBA?=
 =?us-ascii?Q?zIE1lco2HEyEvLpPfKRCgyF+I3Yhm/7+/yEOHFLXxGIQVpiQk8hwM+8ZpAZB?=
 =?us-ascii?Q?rAExyB3i5ukTFlDEHfIcoKbBAylRdg8C2zigfbWkSW4dT7m6W3UhwbrDMEDn?=
 =?us-ascii?Q?LnWKDpKiCYLSA8YncyTdVHUNVW7l5/d2+pEy/bZ5?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 752bc49d-c827-4b34-3327-08dbbfe50a95
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 05:37:45.1548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dqZ8yuerEOvrGKsiccV4HIlLivL9EoKFICSXBoMOG5KpOhby7G79Dbx2WHpSswlbOhudozgeuCWaK79ozg6zsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6912
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After gstreamer rework the dynamic resolution change handling, gstreamer
stop doing capture buffer allocation based on guesses and wait for the
source change event when available. It requires driver always notify
source change event in the initialization, even if the size parsed is
equal to the size set on capture queue. otherwise, the pipeline will be
stalled.

Currently driver may not notify source change event if the parsed format
and size are equal to those previously established, but it may stall the
gstreamer pipeline.

The link of gstreamer patch is
https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4437

Fixes: b4e1fb8643da ("media: imx-jpeg: Support dynamic resolution change")
Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c | 7 ++++++-
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
index 3af0af8ac07b..372f3007ff43 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
@@ -1348,7 +1348,8 @@ static bool mxc_jpeg_source_change(struct mxc_jpeg_ctx *ctx,
 	q_data_cap = mxc_jpeg_get_q_data(ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE);
 	if (mxc_jpeg_compare_format(q_data_cap->fmt, jpeg_src_buf->fmt))
 		jpeg_src_buf->fmt = q_data_cap->fmt;
-	if (q_data_cap->fmt != jpeg_src_buf->fmt ||
+	if (!ctx->source_change_cnt ||
+	    q_data_cap->fmt != jpeg_src_buf->fmt ||
 	    q_data_cap->w != jpeg_src_buf->w ||
 	    q_data_cap->h != jpeg_src_buf->h) {
 		dev_dbg(dev, "Detected jpeg res=(%dx%d)->(%dx%d), pixfmt=%c%c%c%c\n",
@@ -1392,6 +1393,7 @@ static bool mxc_jpeg_source_change(struct mxc_jpeg_ctx *ctx,
 		mxc_jpeg_sizeimage(q_data_cap);
 		notify_src_chg(ctx);
 		ctx->source_change = 1;
+		ctx->source_change_cnt++;
 		if (vb2_is_streaming(v4l2_m2m_get_dst_vq(ctx->fh.m2m_ctx)))
 			mxc_jpeg_set_last_buffer(ctx);
 	}
@@ -1611,6 +1613,9 @@ static int mxc_jpeg_queue_setup(struct vb2_queue *q,
 	for (i = 0; i < *nplanes; i++)
 		sizes[i] = mxc_jpeg_get_plane_size(q_data, i);
 
+	if (V4L2_TYPE_IS_OUTPUT(q->type))
+		ctx->source_change_cnt = 0;
+
 	return 0;
 }
 
diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h
index d80e94cc9d99..b7e94fa50e02 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h
@@ -99,6 +99,7 @@ struct mxc_jpeg_ctx {
 	enum mxc_jpeg_enc_state		enc_state;
 	int				slot;
 	unsigned int			source_change;
+	unsigned int			source_change_cnt;
 	bool				header_parsed;
 	struct v4l2_ctrl_handler	ctrl_handler;
 	u8				jpeg_quality;
-- 
2.38.1


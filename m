Return-Path: <linux-kernel+bounces-23269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2170382AA05
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 140F2B26E54
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAEB2168B4;
	Thu, 11 Jan 2024 08:57:09 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2046.outbound.protection.partner.outlook.cn [139.219.17.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC1315E9B;
	Thu, 11 Jan 2024 08:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KlSr0XsOdMyMn73tvm+01Y8Er4XgqNeCDAC78kabCHrAKBcWhSXWADrj4ZbGrwjwGFSxmZITRYPF3q+07rOP5wiOzlou9bzcUnpv6JNdDtMuPEc1GlctwABU77h9RYb90BLKd3f/9bA9MpHtM9ilmQbqhLmQDdASoqhNWurKCwoNDvIiEYbwbkO0R+4pxKFxMrNos6HyLbCJd/lvREe9hblkRk5tYCTckFqMbLynCSCu0/Ep7w2AfAW9KQ5c/o0wJPtqgUKlKOKh7Ja9K7PIjyUJOO8H0U8ohtq9iLQ+1B3wi37FNm3qhYsqeQtUA0CO1Zqh7GarC/PsNy1EeCe66g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xSmZQzN78d+etqBy2o5BJkiJz5ehsWeddbIOJIxCv1k=;
 b=XcNCljYvSydqTN0R3Xz4lGqKIk5RNOEOSEViPAABsOIBYGHey8maBostj5DXcRYEgQjGwj+ll9x0Szhhpqoto9pS3nba8+Ai6zjry6uTxaseEAAFx8ZQcjxJ9dZyK53CZ0/+n2vo0A2SC2SpkAwjDr/jRSANuUtqgKAcb1U2WuSP0Dt+WNRvC3sCRy7dd69mrqSbP7Cj7R8ywHEn9S58deqdEnutk3E5nwrK9hw3tUK2UQc7otngi2b67sOuQ+aAubPi2wDKrK4BzE34A5Do+dz1sZDMvnNEgVbxpQqN+RScJSUx+QgimpzHxXL5MfqvIeEqYeIIX+WaFGRSerZ5wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:20::21) by SH0PR01MB0747.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:21::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.33; Thu, 11 Jan
 2024 08:41:32 +0000
Received: from SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn
 ([fe80::e255:98f3:ba27:8c7d]) by
 SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn ([fe80::e255:98f3:ba27:8c7d%3])
 with mapi id 15.20.7135.033; Thu, 11 Jan 2024 08:41:31 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Ming Qian <ming.qian@nxp.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
	Mingjia Zhang <mingjia.zhang@mediatek.com>
Cc: Jack Zhu <jack.zhu@starfivetech.com>,
	Changhuang Liang <changhuang.liang@starfivetech.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: [PATCH v2 05/13] staging: media: starfive: Separate buffer from ISP hardware operation
Date: Thu, 11 Jan 2024 00:41:12 -0800
Message-Id: <20240111084120.16685-6-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240111084120.16685-1-changhuang.liang@starfivetech.com>
References: <20240111084120.16685-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0009.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510::19) To SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:20::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SH0PR01MB0667:EE_|SH0PR01MB0747:EE_
X-MS-Office365-Filtering-Correlation-Id: ceedce40-7c4b-487e-8f7d-08dc12811c80
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QLBLq+HNkabaOEBG/2GMNYsucyxUd869gymZW22lwyFI7U6i+FW9mO5Obv/FSp3vn660zGxEKTXIv9gzpmLaroVe3jyd1UqS3bq6HOMyoZoMM0HtzPSmjJ8iZ2SdMAVNLwugDnQQuM5ycyFASrJ+8rLpfuCuptT85hoyy7ViJ0aOLaDj0b0RDKIlUlHttOhUTbFV5+yz3J1QmntUqrStFMBug3vqV2uaTDcqdcWpTjH7lIm12DX/ti/XRy7ES8OqITeJLIgHEVJWK4rRnrflreeBS53g4Qn7mV0tkbvsLVkqGFCd0BqTcI14pvPtnreW/FPVlTd558RJLtwgb4MClk7sV3OoA8RNNRGl5YpczkmID6pI6BzG8dqmFT0q7KBF5oTG05zvW5Wm7fs73BDwM/Ys/l93xH/nLfYwYYIHnc2uNSCNHGL4ncHtRtsiYFqxqFc2ndSK67i12qqwwOp4sMXv5JcHokd06pvhodwPguen19uT+Xhh81c1/Dx8Vwf+udY9OZIiBoywD/hCSmuYJUCCNdM4tY78B0K/TavZuQ5g8Dg4Ioe4cnwPqOp1Fdwp/2oq3AvaUpSuSvR71QhTwA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(136003)(39830400003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(6666004)(52116002)(41300700001)(2616005)(508600001)(38100700002)(40160700002)(1076003)(26005)(86362001)(36756003)(921011)(38350700005)(83380400001)(110136005)(54906003)(66556008)(66946007)(66476007)(8676002)(8936002)(41320700001)(4326008)(44832011)(2906002)(40180700001)(5660300002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ocgDd2OhZzdCDGoFesvBDBYFGBMdkiF+HUrhID98EXDjrQxRskzL2I/JyI/F?=
 =?us-ascii?Q?U+rifewxyjdNlhgC8141L61dbtz+N8Fsgav19qVZ+GQlifsDYQf1A5PFHvEy?=
 =?us-ascii?Q?7WRGIO1ESKz9IiPBMlniX83jsVcEeMJmXTn+e/tvf0ni4Y1Y2IVWREndAhoZ?=
 =?us-ascii?Q?b8be347lIO6iLUrUAhoOrz90kKgzC11tjEstFbTmrhsJevOog2xitUqVCHnI?=
 =?us-ascii?Q?AlvIMA3S3JmoXUaLbeXHln4WHo7mT6hj2v62+tk2yA0uF5qeY7SLXDmW0L4w?=
 =?us-ascii?Q?aNGWkBgZT2GPchLgVCUlR8XT4JaN5P6gILySl4uSQX+DKlZbuRkdLBXUO8UA?=
 =?us-ascii?Q?x2R+fKsDXRqEcx0H1HnL90Sz24CSybfbJZ1EnyGvGne36YfyQmteeXs/L3Q1?=
 =?us-ascii?Q?s92O8529hrpUBR2E8ZwQH7xliwXLqUTaWsIAmwmo2u+byATkl+W0MTYrAaGR?=
 =?us-ascii?Q?R0/jxqnVU5DPLI1B0r5G1cfdGLW4NalO2kND9HQLtU3yhopklmg0bw12oDYZ?=
 =?us-ascii?Q?VKgxUX2B1FK5eu6x94xbSV87SCum3pWFwzgMmkem7laB9pkPSCLB0Z77nmY7?=
 =?us-ascii?Q?kC6mrsg4sTLBd/NJ3GyxG7sVJ9P7uXG7DM6wKg4ZM1qEFjbxJHUPz8aetdzQ?=
 =?us-ascii?Q?kMgFtzOw3JUrrTSUtxcevhkuQBVlCdBfvl+qu72omI2Or1R0mVs5TGevda+Z?=
 =?us-ascii?Q?hFs6n3ucXnGkJn3PywSyGqhRoDo5nprpHKI/VKl+1LOgbqE8+fz6cN2v/JNd?=
 =?us-ascii?Q?iMhLt9ZnoKsiBJAKkcAifOMw0W6IaKUALQOEnbpeiSHpnzZyD2sSRcSqAmOy?=
 =?us-ascii?Q?fOatgnPX5Kp+PIw1vfTT3O9Rd5+lgri9Vg/6lY5tmx8qZDLZoRnmroBps9Mf?=
 =?us-ascii?Q?lFBemqZjnP/SbLNq9uwSgN7DQEIdnCoUymiCqOQOMw+HIb2DCRCF5L/qcQPO?=
 =?us-ascii?Q?P0kjVAFTfPW7vYRIIBgtTGtfvu7wT0wjxRFj4TxPsf8CcnrP6wHdxU9Wv2HX?=
 =?us-ascii?Q?sLEyomoJA3kj9ha2vfhLBcW+Fz0NDKwY4+pyspX8DVBXNpm9pDVg2veIdPVd?=
 =?us-ascii?Q?wS866InbrRhc2tOVGHYAMm6RhgJM0apsyDzpSe6P92SxMRdGUHsR23ijeXF5?=
 =?us-ascii?Q?gYg9MwS5OSL5pp4o8IYu2S4yN8Azjt/+o89IzznBSL5xAQ9h3l5t2EVh3k21?=
 =?us-ascii?Q?unoI3Wqwj6OZ/Ng2m1cl+YBDiLcLl9XIobzj2Uqko1pEREy9/FDnuJ6eSPr+?=
 =?us-ascii?Q?eSdZzayo1lYdU0TBgKClvLxOuxbWJxzBhLRn2EzJWovQpfUff1K+9fplHAai?=
 =?us-ascii?Q?dUgatuHl6R1Jz9RMBIgfXEvCfIIy5jM+z6qZ7U4vA0jA3iRxEPNbBbAeI1vG?=
 =?us-ascii?Q?mTACP5EYSN4nq6HO/Ej7u84J8AyYxzX5Wy602tUCctLDzwXAYNniCtU3GMH3?=
 =?us-ascii?Q?GP+C+sBykoyI4cAWQP0/jU4ouY3bXufHq0iT2G/N+gZukhMBSMzVAVfrZ2Gi?=
 =?us-ascii?Q?mWTKm2T/BC8NKzkIBfBYxFhRaA3gQ+tpyjTkzKOip/vgbnxxGzP5r9fg8auM?=
 =?us-ascii?Q?nz++BrqDiSE5ZvM047ugEZEsPIv7VQqx1BPzGsZcTj3I7kIUNisG4hQLmL/e?=
 =?us-ascii?Q?vPFbIpP/RADccyEKaOUnY8k=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ceedce40-7c4b-487e-8f7d-08dc12811c80
X-MS-Exchange-CrossTenant-AuthSource: SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 08:41:31.9245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Va/s3YfTBqzf7JcxQ4hlSLjdZ7Npr550isS88ip4b7CVHanbXu657E/d/h9xZZmYh+SbsReBHoB5gkIP7ytz7vGTOneRIHrzt++9DlSH/W1hsdyEDBO12XDioWoaoN/5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SH0PR01MB0747

Separate buffer from ISP hardware operation. Convenient to extract the
buffer be a common file.
Replace "while" with "if" in stf_buf_done helper function because one
interrupt signal only handle one video buffer.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 .../media/starfive/camss/stf-capture.c        | 63 +++++++++++--------
 1 file changed, 36 insertions(+), 27 deletions(-)

diff --git a/drivers/staging/media/starfive/camss/stf-capture.c b/drivers/staging/media/starfive/camss/stf-capture.c
index 70c24b050a1b..367bdc924fb7 100644
--- a/drivers/staging/media/starfive/camss/stf-capture.c
+++ b/drivers/staging/media/starfive/camss/stf-capture.c
@@ -368,7 +368,7 @@ static void stf_buf_flush(struct stf_v_buf *output, enum vb2_buffer_state state)
 	}
 }
 
-static void stf_buf_done(struct stf_v_buf *output)
+static struct stfcamss_buffer *stf_buf_done(struct stf_v_buf *output)
 {
 	struct stfcamss_buffer *ready_buf;
 	u64 ts = ktime_get_ns();
@@ -376,27 +376,27 @@ static void stf_buf_done(struct stf_v_buf *output)
 
 	if (output->state == STF_OUTPUT_OFF ||
 	    output->state == STF_OUTPUT_RESERVED)
-		return;
+		return NULL;
 
 	spin_lock_irqsave(&output->lock, flags);
 
-	while ((ready_buf = stf_buf_get_ready(output))) {
+	ready_buf = stf_buf_get_ready(output);
+	if (ready_buf) {
 		ready_buf->vb.vb2_buf.timestamp = ts;
 		ready_buf->vb.sequence = output->sequence++;
-
-		vb2_buffer_done(&ready_buf->vb.vb2_buf, VB2_BUF_STATE_DONE);
 	}
 
 	spin_unlock_irqrestore(&output->lock, flags);
+
+	return ready_buf;
 }
 
-static void stf_change_buffer(struct stf_v_buf *output)
+static struct stfcamss_buffer *stf_change_buffer(struct stf_v_buf *output)
 {
 	struct stf_capture *cap = container_of(output, struct stf_capture,
 					       buffers);
 	struct stfcamss *stfcamss = cap->video.stfcamss;
 	struct stfcamss_buffer *ready_buf;
-	dma_addr_t *new_addr;
 	unsigned long flags;
 	u32 active_index;
 
@@ -404,7 +404,7 @@ static void stf_change_buffer(struct stf_v_buf *output)
 	    output->state == STF_OUTPUT_STOPPING ||
 	    output->state == STF_OUTPUT_RESERVED ||
 	    output->state == STF_OUTPUT_IDLE)
-		return;
+		return NULL;
 
 	spin_lock_irqsave(&output->lock, flags);
 
@@ -426,37 +426,37 @@ static void stf_change_buffer(struct stf_v_buf *output)
 
 	/* Get next buffer */
 	output->buf[active_index] = stf_buf_get_pending(output);
-	if (!output->buf[active_index]) {
-		new_addr = ready_buf->addr;
+	if (!output->buf[active_index])
 		stf_buf_update_on_last(output);
-	} else {
-		new_addr = output->buf[active_index]->addr;
+	else
 		stf_buf_update_on_next(output);
-	}
 
-	if (output->state == STF_OUTPUT_STOPPING) {
+	if (output->state == STF_OUTPUT_STOPPING)
 		output->last_buffer = ready_buf;
-	} else {
-		if (cap->type == STF_CAPTURE_RAW)
-			stf_set_raw_addr(stfcamss, new_addr[0]);
-		else if (cap->type == STF_CAPTURE_YUV)
-			stf_set_yuv_addr(stfcamss, new_addr[0], new_addr[1]);
-
+	else
 		stf_buf_add_ready(output, ready_buf);
-	}
 
 out_unlock:
 	spin_unlock_irqrestore(&output->lock, flags);
+
+	return output->buf[active_index];
 }
 
 irqreturn_t stf_wr_irq_handler(int irq, void *priv)
 {
 	struct stfcamss *stfcamss = priv;
 	struct stf_capture *cap = &stfcamss->captures[STF_CAPTURE_RAW];
+	struct stfcamss_buffer *change_buf;
+	struct stfcamss_buffer *ready_buf;
 
 	if (atomic_dec_if_positive(&cap->buffers.frame_skip) < 0) {
-		stf_change_buffer(&cap->buffers);
-		stf_buf_done(&cap->buffers);
+		change_buf = stf_change_buffer(&cap->buffers);
+		if (change_buf)
+			stf_set_raw_addr(stfcamss, change_buf->addr[0]);
+
+		ready_buf = stf_buf_done(&cap->buffers);
+		if (ready_buf)
+			vb2_buffer_done(&ready_buf->vb.vb2_buf, VB2_BUF_STATE_DONE);
 	}
 
 	stf_syscon_reg_set_bit(stfcamss, VIN_INRT_PIX_CFG, U0_VIN_INTR_CLEAN);
@@ -469,12 +469,16 @@ irqreturn_t stf_isp_irq_handler(int irq, void *priv)
 {
 	struct stfcamss *stfcamss = priv;
 	struct stf_capture *cap = &stfcamss->captures[STF_CAPTURE_YUV];
+	struct stfcamss_buffer *ready_buf;
 	u32 status;
 
 	status = stf_isp_reg_read(stfcamss, ISP_REG_ISP_CTRL_0);
 	if (status & ISPC_ISP) {
-		if (status & ISPC_ENUO)
-			stf_buf_done(&cap->buffers);
+		if (status & ISPC_ENUO) {
+			ready_buf = stf_buf_done(&cap->buffers);
+			if (ready_buf)
+				vb2_buffer_done(&ready_buf->vb.vb2_buf, VB2_BUF_STATE_DONE);
+		}
 
 		stf_isp_reg_write(stfcamss, ISP_REG_ISP_CTRL_0,
 				  (status & ~ISPC_INT_ALL_MASK) |
@@ -488,13 +492,18 @@ irqreturn_t stf_line_irq_handler(int irq, void *priv)
 {
 	struct stfcamss *stfcamss = priv;
 	struct stf_capture *cap = &stfcamss->captures[STF_CAPTURE_YUV];
+	struct stfcamss_buffer *change_buf;
 	u32 status;
 
 	status = stf_isp_reg_read(stfcamss, ISP_REG_ISP_CTRL_0);
 	if (status & ISPC_LINE) {
 		if (atomic_dec_if_positive(&cap->buffers.frame_skip) < 0) {
-			if ((status & ISPC_ENUO))
-				stf_change_buffer(&cap->buffers);
+			if ((status & ISPC_ENUO)) {
+				change_buf = stf_change_buffer(&cap->buffers);
+				if (change_buf)
+					stf_set_yuv_addr(stfcamss, change_buf->addr[0],
+							 change_buf->addr[1]);
+			}
 		}
 
 		stf_isp_reg_set_bit(stfcamss, ISP_REG_CSIINTS,
-- 
2.25.1



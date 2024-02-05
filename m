Return-Path: <linux-kernel+bounces-52247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8550B8495DE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A77E281250
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B3C134D1;
	Mon,  5 Feb 2024 09:04:58 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2116.outbound.protection.partner.outlook.cn [139.219.17.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD5812E4E;
	Mon,  5 Feb 2024 09:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707123897; cv=fail; b=O0xiZoE9Awe6kQqIKpVmv3r3daOoaJMzdft4bVs4cnh0BWThh4BMFA6StSnKJhwq9ESLSvuKjiP9JFTJSRauWNwUuzcYWCz4dOqj5/tnqab2z17mYhz+swXy3nws6Twtb+Pw3dPB/gQ9NFv0OvuZ7p/teeY5w4kMhsrzIA8Oj18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707123897; c=relaxed/simple;
	bh=4XSzZb1QgbFtv5Ni/ki7IzK8zqNLItn00o0AqleFxU8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gRNzMJeIlMSZajVnDtTf+BLryg+8EaJPk90ESpLC4m9T8eqzUoIygdrbvQmidZD5TZGIM/Rz61teUUZ84Q/U6nMcXujsxXaLsBAZvruqVCo6GDP3M4F7pr61P9V+NBYXUHbGgQ11lewTFGhz7Mk9i9iwIFDiEnQRYG8GbuY8Nsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kgnjud4ubeGKmLVeAYJa3qVxwJ4fcIMDpT9Caz8KKhY2wQXVLMwj+lcunHxW2i6b7cjjZhlmexNNfW4TOhpTuSrOpMDELDuPqcN7TOFHip8IeKUQCY0K8tSKkCb9yrz2wM/DfBvttUfx8ovrlJfNiGPvTx3ik2WcSEHwekKQGZFF06nTIKGBRfq1Z3w6pWU4L8fi915hEVOfssJTUxPlnqybVnfAA7JQTY6p/a3nTQhdx5T3ohit/xWuCE3KJePOIiNYWnJW7VkaeUSlmzQoedTzCzd4eUWr8RvXkU5o+k4h/zTwpNfC/0clNu+zj44rk4Vk9bC7tsX5fbow7wa8oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xSmZQzN78d+etqBy2o5BJkiJz5ehsWeddbIOJIxCv1k=;
 b=kPolL3HLli9gzSjS1vvx4FqFbM8mhtYzfurRr/TzgEh+EL7zJ8hwN4wNvu0TFWCj/0dOAuGnI2XmTuMAhe2PXtkhYMwIJVIi1d3FKk6Sdtoxeq1BQmzGrzt3A+EMaoPsSivs+5zv1/OPiwUjva4hIRfv7lopB+LpTOHjtEVwONk4MNbQcETC6UP54KxYYrNlnA6/AzYNHcPU30w5gBwVPlQG8xJrnP2Q8E8eo2Jea7MJQk7FzbuDkSe+rzhMQZUang7SNlQqEw0IkhjPntK1gjnE7tP4Ygg9zcbLHv405fgUwia+3CEfgV1zS50iyTFY2uRAPl8+jXqgbzN7j8pKDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0815.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 09:04:41 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::b0af:4c9d:2058:a344]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::b0af:4c9d:2058:a344%6])
 with mapi id 15.20.7249.025; Mon, 5 Feb 2024 09:04:41 +0000
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
Subject: [PATCH v3 05/13] staging: media: starfive: Separate buffer from ISP hardware operation
Date: Mon,  5 Feb 2024 01:04:16 -0800
Message-Id: <20240205090424.40302-6-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240205090424.40302-1-changhuang.liang@starfivetech.com>
References: <20240205090424.40302-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0022.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:2::23) To SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0671:EE_|SHXPR01MB0815:EE_
X-MS-Office365-Filtering-Correlation-Id: a6a63b37-7f3d-4dc1-bd2e-08dc26297d4f
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4guHUnYE59UPvGxs1t0vdJDVaDBfHk5WyO7l991zrr7PX2tnbMc392zecLJYmljBgE/1jpw8Lb7Gvur9SALGre5W8uDFL4qQBTC8VfkL9LHzJjfw5WgYm/CSInYj3+jLuRT+Lv2PfBDsPDlTISLlCday8UTqWsfZ6srgwNLt1eNm7bgXbbeUeuYUdk9Z6gl9MbE9n/OqAM90Be6NUntM2t/cMp+0f/YRPuzHz3qt/NUM00lvfGS/+rxpnSLER1N6q63wBw4PEw51pDy9c/ekoWwlLOLvwJbfzsl0AB4wiqC7skCiV0DQAf3jFwYdAnzdKsX9K4Iv9ehnVp6DtpMvyf2uspoeovplCiGdRXPrF3eeHfMMrLAynZtZ57xyCdZ5Gw38HwFvjj4z9ZyHQjmgNUSeEQV/BP9uMIIPdXnvnKcoZonrR6cSRuhNYUytWpbkNlPwgAstiDAxPUpVjeUHIgWD0b6p4Mo3n4o65apml7MtZUbNd94KM8rL5iseBdqy8i1NInr805q8wwwk8jqMhSPo+ikS7ba/QjoSd/CdG2Bay3FbxBgJ/cDqv4d+lH/2tuRLkYt5uQKHOEtQB6+Zqg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(366004)(396003)(346002)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(41320700001)(6666004)(52116002)(36756003)(40180700001)(508600001)(38350700005)(40160700002)(38100700002)(2616005)(1076003)(26005)(83380400001)(86362001)(5660300002)(2906002)(7416002)(8936002)(8676002)(4326008)(110136005)(44832011)(54906003)(66946007)(66556008)(66476007)(41300700001)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jf/Y7xvGPkRUMlSOnKzIklxlthophB3qvOZuHbzzmzUwwdltq8yKMQm2KFF+?=
 =?us-ascii?Q?PYm0/Y3JUfY11VKY1y8ncSi0Ta1bIAeu6FzkIJBY0xLICRQC/IqG/sDt2c1L?=
 =?us-ascii?Q?6aLfIA2cuvk88jpG8SQFqm/DzfLq61NwQNCLjSUsiXgCoYpiuTWNieieUBv1?=
 =?us-ascii?Q?jSi4Keo6DYLxmrQOhqtPBooMewfMtTEd44aMjdHI1aGJe7iiaXzG9O4zSaVx?=
 =?us-ascii?Q?LCjph5i297s5prhpGofBGdmHLKi+9AlDYfl27hn48NNGx0SNud+e4JUq8Jqj?=
 =?us-ascii?Q?zTE7oAzOEJdlvDrBQ21m2N0x/Jc5/R89IoCXkR4a5wy6/N2WtwAhl4SwFE7O?=
 =?us-ascii?Q?N5ZMT0CAY2q+wMSEFe3WyLAr0sivX5I6cCBlAm7+gTyTS/5/GlKbl5whaDtf?=
 =?us-ascii?Q?7qYkvMrVYmuz9oHem94OZ3JB9j3qfgbo2G8qQUhQO99KwneAblDl8nEzjGTc?=
 =?us-ascii?Q?T36RSFzKt5rwk1vlOjKCCQAGUWNJiV8Hl6TbaMA0aw2eMl9DZhIQuBpji41/?=
 =?us-ascii?Q?YWoEUZXtSb5jNWgZ0NHsC+7ceysTe1XmoYT8Acn6lRe1mR795kE1LxT/DGo1?=
 =?us-ascii?Q?Iv0qlyWbYZvVOZkhLVfwmDtUX49qPI7zvVEF83jddHfcUp+KRgrseQrrK/wt?=
 =?us-ascii?Q?M5Jv2q+FYF2y1JG5+rPqTD4SrLIMvybBN/pD+PE+e9b/1Tv8xfY4s2Urvwbu?=
 =?us-ascii?Q?G6wGrC/dFcVQEWFbE9AEDyVsZaepA11vzp8Onk/7Nfa5iJvT0XtlktJnDoBs?=
 =?us-ascii?Q?IGYxAi2qqRke3Vd6PcoubMfmvc0TgXA2yvq4DAiH/TX4Ka3AOM4GXEhI3W50?=
 =?us-ascii?Q?5ssLkkOd2D2lSIRRcpwnAbAlS0s1lwu0aahdmj6wzC5KEZcIt2w0epr7sdUj?=
 =?us-ascii?Q?JJZNGOycT3cqyszKe2e8qVc5Ej1MGcevGC6BHylMdHXzzRoGq6sl8GQ5y1DO?=
 =?us-ascii?Q?blxmNQqdQhBBzeWGox+aRldrSl1s96tPh8qmC607n3oCvbQj+l1SkBrVUxMg?=
 =?us-ascii?Q?EJUixDQIIfTVfO4VlPU6J1WKVYsEUauEWKmeJI1X2W3KNjB5SJNrdyis29wD?=
 =?us-ascii?Q?f18xMIk7z8vx0DOW00SR/RRZ7UbdLlwe9wtToo+qsQpCa154RV761rxR2IPj?=
 =?us-ascii?Q?jNv5CChSSVjt1RAYxnyE3EQNZafgQP5Y7xw4aXlbR5CUhgu51xiHPrUtrVat?=
 =?us-ascii?Q?74OAcENkdeQjSra/FjqB1sPJcJUSsniQ/G2nsmv1Z/GZAYCVKW6hwzDEr6lo?=
 =?us-ascii?Q?IhRC1Rlw2V4XlBdWB3geeAJE4ivFyDxnnzM6MFd7wdLt5Ikwhwm5gCXTb0kD?=
 =?us-ascii?Q?n88SXI1QrexiPn6x3q9dbNc/6Ne09WiV1PUw7vMbPQPX+5VLJYEmJ3wQdMiL?=
 =?us-ascii?Q?mDixxq+wKSo9V95yLudwlwJ14SMBft4diqUlCAY/VEIsM67DsHGhDaMljo52?=
 =?us-ascii?Q?xaMeRardaIJRioLCU9EbEYqRAgtAYFYDf6J2449p9buZ9LdFbvphw1u71u9m?=
 =?us-ascii?Q?hCqTm/BEcxo5aSWlNbqSIPEWGcAikZIxWppSQIYhQwFBP9J4+U+1rei6tLhe?=
 =?us-ascii?Q?GyResSSeBAHygJnackbHJ6fT8v0bxkHjyICL6xRyuXGspTSMHRXhEWRUz0b+?=
 =?us-ascii?Q?DX1D70ZA9BK+5PgFGENVCZg=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6a63b37-7f3d-4dc1-bd2e-08dc26297d4f
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 09:04:41.8786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4JbXG8U1/FdPFXClCp7FYwpZi42qmb31EeUoomf2rNbsnQk1lhFHXl84xE0Ibm99vK12QqQEGpNbGsoJclMNt7rvtnLR2VhhAIS/o1/kMycBnN4QHmVravhzC2uUeQK0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0815

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



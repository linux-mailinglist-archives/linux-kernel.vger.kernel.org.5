Return-Path: <linux-kernel+bounces-127684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 393A7894F6C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6C371F215B1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D7A5FBA9;
	Tue,  2 Apr 2024 10:00:45 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2134.outbound.protection.partner.outlook.cn [139.219.146.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909785B5D3;
	Tue,  2 Apr 2024 10:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712052044; cv=fail; b=dsbnjJte67nn0bVfY/wCxKTi8yhP9jc9k2PSsGXrjomIQfUQd/2G4vd0jFM5uyOm4SSWZrslciXNFcRH/PCXtDfMbenaij3HQzWR3ng4+wvciJGEfsYvN6ZKbn2i4h+FfNkV9jxRZYJbfajF+E0JfF+74B2RQMxuL9V0kWwaezM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712052044; c=relaxed/simple;
	bh=+SiXIlS9xRgB9Uk+id65QRQQdN+77i/KJd0PUD00/po=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CGVRb7EBV+LwfGEw8lnyX0eW3b4ReOJIfTvIMhY3KbIn9FH+kCcywmpJgXCg1vyEodHhF/KYMpJVT9XsChchWhCg4flD1bTjt3swC5SZqF6Vr+gOnw2AIEuel5W5bKMwf3Xx+fuTuO63Wpcojhysa5Bcydw5pU5kDlR7tHIfSXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nbgP1xoEFh2PcgrPzG4+itL2LnCtHltF55Fq0p/PVoi+y6RSVXP8ehFXjDV6rmX04XMUkUXFcVpRpYB940TIdcjWr/OEksRI412F0nwRiF1klCOpxcpXdv8NdEOFwmx4cxTiRYGEdjexNP7JT6w3t8AgiXN1xbgDEatfOtellcjHhb/BM7ki9HJH4I5LjG4zQ6thCLobHldiB80Vuvg2EHJIGYB4R2s5CFFdWXgatwy6KYJtJY9wOhdfv/rD0CFc9/PdP5+QNX3Dz1e+SH6qJswH3Qo0jx3Ek7+jozTEFz8nFzOn0Kx8SDz134JTzzQfbYES4u00n5MwtsxM99cKnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IpNDGY9Z69KwGD7XfHtTW7NF/LKZHWPGrDb6RfSKDWM=;
 b=ejlZirW5PYAxJt/T2otnw7iVT3X5RKqiKmjMp5Tol4p34Uv5xnrpY1g1IGpCzdgNybM33PTlw7DyzYD3blST/NRHGuhwaIztBIMyoxmVMbfQRrEFQmXq4O2uh39sNzyGp9k6eRTvnpZCte5YXaBL8/i6Fqkos68qdNotJIqOfxpV3gTbmnH07de4dnkaMnKmx9di+hdHEynMe6Tip2hLOk6HC2IRyQdQrdS3lGnGMAzBk1FljnFib19GKZxht/XpcEyzMBmc2NQOoEyposR/uw9p8EZd1YmZg86jdBnNwwR/Yt78eiigun/QDoiHnR++3thhYmTAGUzab1UtGvNXKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0862.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:27::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 10:00:32 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::b0af:4c9d:2058:a344]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::b0af:4c9d:2058:a344%7])
 with mapi id 15.20.7409.038; Tue, 2 Apr 2024 10:00:32 +0000
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
	Mingjia Zhang <mingjia.zhang@mediatek.com>,
	Marvin Lin <milkfafa@gmail.com>
Cc: Jack Zhu <jack.zhu@starfivetech.com>,
	Changhuang Liang <changhuang.liang@starfivetech.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: [PATCH v4 07/13] staging: media: starfive: Separate ISP hardware from capture device
Date: Tue,  2 Apr 2024 03:00:05 -0700
Message-Id: <20240402100011.13480-8-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240402100011.13480-1-changhuang.liang@starfivetech.com>
References: <20240402100011.13480-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0005.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:5::11) To SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0671:EE_|SHXPR01MB0862:EE_
X-MS-Office365-Filtering-Correlation-Id: 941a7dd1-2438-4d9f-ebc1-08dc52fbbc1c
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZvtzNRAga71ntLfhHgQIAzh8zcdlPeN6X27/rPSoiIIk13JTr3+dHpNZeYNvHooqr5yt34GSWru5zKx7QK2KUGOe03LWKhwASEevu8wXwKg+TdZkpjFKL67t7SUcXWKMgBI5kah5L7kkIGFVVHaD8TCYmVepLlKNu4WXa0FFW3T8GpfkdGyJqndPDWzDtgeH+P7CSn9u2B3h2d2AZh2ACkyuqyTjhV3+hBCGQlTt1UJ9HbN0K/Q6EwENEKwDa808JYMl12YPauAukS9+XOqx26o+QcYWX/sSeZSRDffoAlcBSUNv4GFX9mUnicd2qLQX9wArykvWPdNsS1Uf7qBww0AGt2qG+wRVQJQWIeZs1BWrj7gZH2r3m7jycndIWwY9o+4OPSO5a4mpQ+DPWncGeduMdqP5p4TOANUD1uDx3L1atdDPvheEaIKAezixlqEfJlWuAi+pCujcFmqAZL8ih/3ayPQWJLoD4O0ntLdXhAsMzAe2rCLQAhCoE9U+Z3vJ5QA7ae/bHTGfLAxkP5Y4a3gHOhRNVz1uL2djgCpJkC0R+o2l2TRUzckdcno5eNQ0Zto5hGryMrOW0188YYbgcAaGNnqHvvIA78JyQG8jZmFvWnb1S4z4qsZNYp/MmmGRC83KrPCee8qjEjGUqG1Y7w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(366007)(1800799015)(7416005)(52116005)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LLLPJA4V3wPrkSqFj+UZz+YDRBvWAAvuLw4A3lmbbeptw8dtoNZGbDZkOcfi?=
 =?us-ascii?Q?lBAver7oNEoXJJvoVZ/uAUqZPVOAGJ0t6nzxcWmQp14Fc1leEG3ZzSCoIiZs?=
 =?us-ascii?Q?WkFvdo3D8qaVpT9vUEfPQuho8tICUEmTtPU+dB9dSnaeUBFuBj7QSSlYgfA5?=
 =?us-ascii?Q?ax8zcBbMLK1yee1TuL6amAvX+npTvRlPbkhQv+OvTrGos3VIT4tvWudboy5N?=
 =?us-ascii?Q?gsaKf+Q2KCAfK++EsB+u3dHODZysaYKr2eBNUFE9yk55N82JgUz/6VL9eMhS?=
 =?us-ascii?Q?wprEdtBpP210/FsfOAV1suArsgdjZzm39+qZEB9qYruGYlUpQ1ii/YRH1owU?=
 =?us-ascii?Q?cRQJEHZuGuWXrLWn6pi6r0MiOVQJakYVpH4OzVZL/VeZtQOWx6OhICQ+/ZBX?=
 =?us-ascii?Q?9VlPB2r3bF8XXWq8/96/Ci6qgIkbomFxXlYA5fEyIoJxZq1NR8jcNXgLqicS?=
 =?us-ascii?Q?QKEHUng3LEleNqlqqMCJ50IQZS1+IzO8HIUaKtupDUMH/gxEC5MpjAhxxBM3?=
 =?us-ascii?Q?xNHwI+tF7z04cnCArTJvBqo1NojUCuaLWMazCtL6/fxgtblrDixe/+OFNmF1?=
 =?us-ascii?Q?jkocV91YRx3XxtGI1nWOLWNMIyuTfY/szxpK/m+IaSzgYXVR9cWtLf8bF/jj?=
 =?us-ascii?Q?wIZBhgKSCAX3NBneV3cQuYR0PtQOiU/4aHJcWDpBHa21s5GRE7tcfe7CzO2Q?=
 =?us-ascii?Q?uhAhrIh1DVY0r2VIVya0O2ei5QdK6/zePBFRkRPfVvOd+S4g0JqDi+eJz2g8?=
 =?us-ascii?Q?FAPnaXnpmxH/kJd7ne2OzSSqssv50Ow264x9ZPIEsOXZGs5Pc60PxGLJLJis?=
 =?us-ascii?Q?gRkPojYoExAbRJs6UkqSw/rZaSCp0wTI2MUvpEZ+igJ1T7wyNGb9zDPOcDdB?=
 =?us-ascii?Q?rUONnC0iqnx5VZbp+AaH8QpWZ4HZ31390C17TgeIU2i/RNNJbfycZMttIp1Q?=
 =?us-ascii?Q?vLUDs40qCgq5j6Df972QwmqtQvHP4arhRSRziJsiks6Kr2AdWZJ/z+J/c2Pn?=
 =?us-ascii?Q?678l8gLrS4iLHadnf306P0xEsTAxnrIz+5HFg7FJJ2cuRSN2pH4W14oL8AtX?=
 =?us-ascii?Q?zU9Rp7nMHZdZkdhcHN7VxSWf+T7CcwXqm1JnwM1RkTtBGnIF8KmGnf3yqsXy?=
 =?us-ascii?Q?gFMyEmAM2Oz3qqxgoWMPmXlCIWMvwDv+KyNceEjSedePpl07ttmqkYuVLhx8?=
 =?us-ascii?Q?VU6xHzaBvj5OyjIRCKi3Pmmy1Q81EjGdLa9IhfnjRr+HQLykTC9o8Rrh2Ybr?=
 =?us-ascii?Q?SNtcF3zAEpefuvdUc1pn+Av18WPoqO5tIgx4Y9KT2szU1CL+ljapUcPosTjM?=
 =?us-ascii?Q?mZ6Zj3oxx/9wXYe3w/2NXDDUZ8SMv7lEDgMyAFDQC57vXUWitmbhYTPndpmZ?=
 =?us-ascii?Q?QPt1sgeJj3/6W2VtwGot7LS+zDoa7DN7dNw7rCyzNoU8VUFJHDXtS+Ea6T3c?=
 =?us-ascii?Q?I/Luhm0j6ClVUi36W2IEBsL/gXiC7sd/1MAsVjA69xeBFRn5mEMPsmgFr81W?=
 =?us-ascii?Q?9hH1oLMdho0BZe+8yBFWLupfq1BRokUXDiSbWfzY3+Ym9Ghh96nxTPWQ0n3G?=
 =?us-ascii?Q?zZDInYGwN4a/vX9mje3F4obzrGcrJeafzsSXKP/wbQJ4UNiDM7IM9iRBINLX?=
 =?us-ascii?Q?/lObKzwJYkSl/8dyFQtvNRQ=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 941a7dd1-2438-4d9f-ebc1-08dc52fbbc1c
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 10:00:32.7187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RDcJh/B2YBxHyYr8oZMHTZdXXXETrhYam0oCU2vlPjmZ7y5casuDcVr5SctaAUEWQYJdc7lPN/ZXjKtvD5M7ZJO08emj8PvH8gxs92W2cbj4hFLX/UwZufqHoR7FcEfa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0862

Some ISP hardware operations also used for output device, so separate
them from capture device, move them to ISP common file.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 .../media/starfive/camss/stf-capture.c        | 60 -------------------
 .../media/starfive/camss/stf-isp-hw-ops.c     | 60 +++++++++++++++++++
 .../staging/media/starfive/camss/stf-isp.h    |  3 +
 3 files changed, 63 insertions(+), 60 deletions(-)

diff --git a/drivers/staging/media/starfive/camss/stf-capture.c b/drivers/staging/media/starfive/camss/stf-capture.c
index 696d79920713..75f6ef405e61 100644
--- a/drivers/staging/media/starfive/camss/stf-capture.c
+++ b/drivers/staging/media/starfive/camss/stf-capture.c
@@ -66,13 +66,6 @@ static void stf_set_raw_addr(struct stfcamss *stfcamss, dma_addr_t addr)
 	stf_syscon_reg_write(stfcamss, VIN_START_ADDR_N, (long)addr);
 }
 
-static void stf_set_yuv_addr(struct stfcamss *stfcamss,
-			     dma_addr_t y_addr, dma_addr_t uv_addr)
-{
-	stf_isp_reg_write(stfcamss, ISP_REG_Y_PLANE_START_ADDR, y_addr);
-	stf_isp_reg_write(stfcamss, ISP_REG_UV_PLANE_START_ADDR, uv_addr);
-}
-
 static void stf_init_addrs(struct stfcamss_video *video)
 {
 	struct stf_capture *cap = to_stf_capture(video);
@@ -307,59 +300,6 @@ irqreturn_t stf_wr_irq_handler(int irq, void *priv)
 	return IRQ_HANDLED;
 }
 
-irqreturn_t stf_isp_irq_handler(int irq, void *priv)
-{
-	struct stfcamss *stfcamss = priv;
-	struct stf_capture *cap = &stfcamss->captures[STF_CAPTURE_YUV];
-	struct stfcamss_buffer *ready_buf;
-	u32 status;
-
-	status = stf_isp_reg_read(stfcamss, ISP_REG_ISP_CTRL_0);
-	if (status & ISPC_ISP) {
-		if (status & ISPC_ENUO) {
-			ready_buf = stf_buf_done(&cap->buffers);
-			if (ready_buf)
-				vb2_buffer_done(&ready_buf->vb.vb2_buf, VB2_BUF_STATE_DONE);
-		}
-
-		stf_isp_reg_write(stfcamss, ISP_REG_ISP_CTRL_0,
-				  (status & ~ISPC_INT_ALL_MASK) |
-				  ISPC_ISP | ISPC_CSI | ISPC_SC);
-	}
-
-	return IRQ_HANDLED;
-}
-
-irqreturn_t stf_line_irq_handler(int irq, void *priv)
-{
-	struct stfcamss *stfcamss = priv;
-	struct stf_capture *cap = &stfcamss->captures[STF_CAPTURE_YUV];
-	struct stfcamss_buffer *change_buf;
-	u32 status;
-
-	status = stf_isp_reg_read(stfcamss, ISP_REG_ISP_CTRL_0);
-	if (status & ISPC_LINE) {
-		if (atomic_dec_if_positive(&cap->buffers.frame_skip) < 0) {
-			if ((status & ISPC_ENUO)) {
-				change_buf = stf_change_buffer(&cap->buffers);
-				if (change_buf)
-					stf_set_yuv_addr(stfcamss, change_buf->addr[0],
-							 change_buf->addr[1]);
-			}
-		}
-
-		stf_isp_reg_set_bit(stfcamss, ISP_REG_CSIINTS,
-				    CSI_INTS_MASK, CSI_INTS(0x3));
-		stf_isp_reg_set_bit(stfcamss, ISP_REG_IESHD,
-				    SHAD_UP_M | SHAD_UP_EN, 0x3);
-
-		stf_isp_reg_write(stfcamss, ISP_REG_ISP_CTRL_0,
-				  (status & ~ISPC_INT_ALL_MASK) | ISPC_LINE);
-	}
-
-	return IRQ_HANDLED;
-}
-
 static int stf_queue_buffer(struct stfcamss_video *video,
 			    struct stfcamss_buffer *buf)
 {
diff --git a/drivers/staging/media/starfive/camss/stf-isp-hw-ops.c b/drivers/staging/media/starfive/camss/stf-isp-hw-ops.c
index c34631ff9422..6b3966ca18bf 100644
--- a/drivers/staging/media/starfive/camss/stf-isp-hw-ops.c
+++ b/drivers/staging/media/starfive/camss/stf-isp-hw-ops.c
@@ -443,3 +443,63 @@ void stf_isp_stream_set(struct stf_isp_dev *isp_dev)
 	stf_isp_reg_write_delay(stfcamss, ISP_REG_CSI_INPUT_EN_AND_STATUS,
 				CSI_EN_S, 10);
 }
+
+void stf_set_yuv_addr(struct stfcamss *stfcamss,
+		      dma_addr_t y_addr, dma_addr_t uv_addr)
+{
+	stf_isp_reg_write(stfcamss, ISP_REG_Y_PLANE_START_ADDR, y_addr);
+	stf_isp_reg_write(stfcamss, ISP_REG_UV_PLANE_START_ADDR, uv_addr);
+}
+
+irqreturn_t stf_line_irq_handler(int irq, void *priv)
+{
+	struct stfcamss *stfcamss = priv;
+	struct stf_capture *cap = &stfcamss->captures[STF_CAPTURE_YUV];
+	struct stfcamss_buffer *change_buf;
+	u32 status;
+
+	status = stf_isp_reg_read(stfcamss, ISP_REG_ISP_CTRL_0);
+	if (status & ISPC_LINE) {
+		if (atomic_dec_if_positive(&cap->buffers.frame_skip) < 0) {
+			if ((status & ISPC_ENUO)) {
+				change_buf = stf_change_buffer(&cap->buffers);
+				if (change_buf)
+					stf_set_yuv_addr(stfcamss, change_buf->addr[0],
+							 change_buf->addr[1]);
+			}
+		}
+
+		stf_isp_reg_set_bit(stfcamss, ISP_REG_CSIINTS,
+				    CSI_INTS_MASK, CSI_INTS(0x3));
+		stf_isp_reg_set_bit(stfcamss, ISP_REG_IESHD,
+				    SHAD_UP_M | SHAD_UP_EN, 0x3);
+
+		stf_isp_reg_write(stfcamss, ISP_REG_ISP_CTRL_0,
+				  (status & ~ISPC_INT_ALL_MASK) | ISPC_LINE);
+	}
+
+	return IRQ_HANDLED;
+}
+
+irqreturn_t stf_isp_irq_handler(int irq, void *priv)
+{
+	struct stfcamss *stfcamss = priv;
+	struct stf_capture *cap = &stfcamss->captures[STF_CAPTURE_YUV];
+	struct stfcamss_buffer *ready_buf;
+	u32 status;
+
+	status = stf_isp_reg_read(stfcamss, ISP_REG_ISP_CTRL_0);
+	if (status & ISPC_ISP) {
+		if (status & ISPC_ENUO) {
+			ready_buf = stf_buf_done(&cap->buffers);
+			if (ready_buf)
+				vb2_buffer_done(&ready_buf->vb.vb2_buf, VB2_BUF_STATE_DONE);
+		}
+
+		stf_isp_reg_write(stfcamss, ISP_REG_ISP_CTRL_0,
+				  (status & ~ISPC_INT_ALL_MASK) |
+				  ISPC_ISP | ISPC_CSI | ISPC_SC);
+	}
+
+	return IRQ_HANDLED;
+}
diff --git a/drivers/staging/media/starfive/camss/stf-isp.h b/drivers/staging/media/starfive/camss/stf-isp.h
index bc7e7b0736fa..fcda0502e3b0 100644
--- a/drivers/staging/media/starfive/camss/stf-isp.h
+++ b/drivers/staging/media/starfive/camss/stf-isp.h
@@ -427,4 +427,7 @@ int stf_isp_init(struct stfcamss *stfcamss);
 int stf_isp_register(struct stf_isp_dev *isp_dev, struct v4l2_device *v4l2_dev);
 int stf_isp_unregister(struct stf_isp_dev *isp_dev);
 
+void stf_set_yuv_addr(struct stfcamss *stfcamss,
+		      dma_addr_t y_addr, dma_addr_t uv_addr);
+
 #endif /* STF_ISP_H */
-- 
2.25.1



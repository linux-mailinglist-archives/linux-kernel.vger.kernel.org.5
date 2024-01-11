Return-Path: <linux-kernel+bounces-23234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B6A82A942
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 188D0285EAD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 08:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A41101D5;
	Thu, 11 Jan 2024 08:42:57 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2051.outbound.protection.partner.outlook.cn [139.219.17.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63036F9D6;
	Thu, 11 Jan 2024 08:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EQ3WQukP+RNqoxiDbwDmyGD4+4e+NUB2pCMOESy/OBQDKIItuwmaPCX8killHBscCTeDMM49FAHbP9zVdY8hImqWnw6fFxvWNcJTzjx4iL+6E2CjTuaak47/KLbSVpJlHQlrwX6jvPw9/7S3iQdtoKmhSmXevhLW7xzzcrDXuz+rVM+qqKYLaA30EaGCn162fr9Tn7vQTm2MEMssBi57zQfIZcTiUtQHTWTuCqWMZAxxi1HWiulSvMtASWt6XAZnoJTxHakoTKhAzUWd6Xsm0uRKmCuwumIf0SuBm2YLrHBPtLyzuT/79Chb/4LixCiU2EDUagoZmhKeVFmUMqojsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QBKebo5g8nQNZpo/7QeoJbRcWRwazmkDu4kDf3PuBJQ=;
 b=LUmYsH3ueAmi6tMU8dK/9AA/UGVxeY+r4FeYi/wKcwZSoJGaY4FeqeaZfSMaeDQhB4sCqmQznWfhiGNzBJOlcgij+41qEAGysA5rzCkbfOLuhtKDs9nAmtW0g+DgtuHE+f/Eodkm+W/OyfE4uJ4Nz+zbDWw8ufgCFmHkKCPCaD6g7ChQPON8zr+LHzGHB5o+wIGsgGTcFabO+7A94jwBzMEWAYK/kzeqXqhi+ykx+DZw2KDeO1IV0RQ5UWvoIPcuQ4sdWnlRgn9ZzfXvInMbSb1aM+5wSN2G0uaYgit6xekvmwfHYGxOaXNs+RfkO3+yxax0sYSHwWdxzRwbz456QA==
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
 with mapi id 15.20.7135.033; Thu, 11 Jan 2024 08:41:32 +0000
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
Subject: [PATCH v2 06/13] staging: media: starfive: Separate buffer be a common file
Date: Thu, 11 Jan 2024 00:41:13 -0800
Message-Id: <20240111084120.16685-7-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: e74f0fa9-64b1-4b36-4c0a-08dc12811d01
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IuupgDbIc0nHZbB9zxDqBIAnlcptmdYA7aU9lXWnsss6NAWhR2TmJETi71+lQodlDEnBqeJW1vBuf4BER22qMwp0q6E8Mh2w193/EWHHxlBJyahrOs0rl1E4j+92JnoK3xBRkx/vC2PQ61mj3DiG50zebo78Xz1aqiaC7n+hGjYARzSiJZvkBJEf7LZigjQ3Me992YzZezGzOTvzwQtEV6yF1JgTlB7WH8H1cT4wPq1SDlKAfr05781p/tmBBQhiyHrsq4FtQ03WRmXUA+xsxaOShqjxF2htuh2RxhiMxro/11Chl3o2zMjHGWnApz5Xg94gMEbeonz36CzuYmPrRzPuzOdvMW3rhBXmBj+WxQ9LFaB7Lujx4JBn0qsyJhqjfc1HZConY5YvSsdpQVpg9M91KnJoH7l6og9NNc1HQiLbByoO38qlrYVtTwN8R0fnxErdwC94ARY0bbvnrTzjMRRMniJ6HOiQ5Z/nywuRs7TQKye7fWTcDsYLYa4uzj1jN5nRKpZKbC7eIM3n7oBZl4U6Sk4t8YRkRImcURJNaJRmZvaFFdvYOcRbfNVf+IUbzf4msqW0uGH1fZ9ifPWzpA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(136003)(39830400003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(6666004)(52116002)(41300700001)(2616005)(508600001)(38100700002)(40160700002)(1076003)(26005)(86362001)(36756003)(921011)(38350700005)(83380400001)(110136005)(54906003)(66556008)(66946007)(66476007)(8676002)(8936002)(41320700001)(4326008)(44832011)(2906002)(40180700001)(5660300002)(30864003)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uUY9J6HbpDkAR9Jm9AP6dB1Eqv7aNJTjfViAlQdR5sKVzyRWSKjFCrccwruf?=
 =?us-ascii?Q?Z5Rd3gugS089sf6ppN5psKnCRtpi8GBMJME+LbAOAIHm7C3I5FLE7WD9gLfJ?=
 =?us-ascii?Q?U3P6xc/I2SFDiOlryVk4fsPvchD+i6v6YGIq1ZUiuraAsNl3UD4OmjIi3ZSw?=
 =?us-ascii?Q?NJh5QFWUqLWB9oguO019ey7NWHyqLg4AGhmkRjzIyNpMN4606GE2Sf8IuWrz?=
 =?us-ascii?Q?l57egvIPL3YeDrlfJHOOWiwTfq7asGZwv0jNIkJxKGF6rnAIOg7iFJWNxAuN?=
 =?us-ascii?Q?XfUWMJskor5B0cXDKsBhMyo3aIfCtf/IDFloWWGdKDprLTksAJzcQpmy8YmM?=
 =?us-ascii?Q?FGxZjfM908Qv6txiEZ0oo6reVDwoqqJn5mGaF5mvbZfxBKiGKejriv9nIIm4?=
 =?us-ascii?Q?UiyjzJTgImLCFscO0K2upR5HJF2jOW77Lv9Dp/RoWXJ6EHqPsQWJ02wHtadK?=
 =?us-ascii?Q?dpzZRnQNSSLF+VcZhFJ58sFNhHzG9116+TvUpu0Ldet0eDjGVxf4zO0SccvQ?=
 =?us-ascii?Q?vC76b8VYnVBznfI3TZ9sR7/ZWWGr6m9+vYAxQ28HIIjLta5Q1v8PqEoxBk6F?=
 =?us-ascii?Q?stTgDhfFA5f7BF69QI+bfqpsgpSnITDX1zBxjr8LJauP7V1jKejrDywqXfx+?=
 =?us-ascii?Q?1aC+ZN86bJ7zoKLdrBknV/Om7FpzTZuzJtkUXkfDgqzPDFpFA77DumWzV/E1?=
 =?us-ascii?Q?QOy0GPEpYH4bdOmXi5uSKoeq+kd6YdOzidXNJinDVXFZKGVo26BzQf3Vnabt?=
 =?us-ascii?Q?CxlXgioawwQ3GXwIrR2RM1gFswlPjxaGdC22wun1/YVIz9M/+hemDf0Mt9Pw?=
 =?us-ascii?Q?nZp35EBHRd+GJ68yX3Nkc3q6xOjjSQfomX513gonPMNWIyvG6pY3wEKOL5n1?=
 =?us-ascii?Q?E0sLkSvj28IoYe0Yf63CPjYDz86LHT6lhVKZI5zr2gPsTicOXOdwc9alp/cV?=
 =?us-ascii?Q?OJpzlqyYMAI6xFsP8uEYr5G0cFPvzUbxfnr6Wpj1/Vrq5X18cVeZ3F2k4wmy?=
 =?us-ascii?Q?5r722uFyoXXXYHgY31sflDI6deogfHP7JiRRQUMLm3c1sHgZrbFCQlbF8prJ?=
 =?us-ascii?Q?l8sAIaOQIintXvoy3J2uktWW2fU3SRoRAt9U1xIuWITZMPpzl3gs3SdGwIWo?=
 =?us-ascii?Q?hAA/CLEd+WKfc43QHg0qeLBEtMn5uGAdj7O1GVqiTyCUzBa1MsJpGOl/umxa?=
 =?us-ascii?Q?vkGefzU+LibQOXpp1K9w3YOuSD78obOWtYFMXbG/tOVSYuQvusM5lBviMA0U?=
 =?us-ascii?Q?KyfLKnqLX7OByOvcBj5l9VCGhoAnI4pig2PdnMkahW9jKT22MO5UbJH2dyL2?=
 =?us-ascii?Q?JIHxRjI4tTjyZ/gk9whcGNy8KfPsyxjjUENR9Ti3o1PU8IcmYJbXiCJbwYjr?=
 =?us-ascii?Q?zSK2YdJcCZ2ZtyPIUkxNo/DE3EKufNdE1/594WhM/o34LAezFkAAgiJOLenc?=
 =?us-ascii?Q?Ptr1heQ8JxIr8zhCDobV6SknEHq8N9bdQteNZoELLDrSYNg0WQ+1WfV+6Xm0?=
 =?us-ascii?Q?CXbtKMvMvXXsOtI6FkV5j/eZUhp0CXmVUPtlUegH3Eug9JeBbF0dxdxU5U+3?=
 =?us-ascii?Q?cuYk/JkjorwVaAMBqDO29L9Ax3bLFWcOUOjnn+4srP76cml+82Y6ZP5n/1Dv?=
 =?us-ascii?Q?we/F7wNnH/QQ5Km8ojxls40=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e74f0fa9-64b1-4b36-4c0a-08dc12811d01
X-MS-Exchange-CrossTenant-AuthSource: SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 08:41:32.7556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KPsXlnthgWlJX/AOyBxWAMHagdWGZZE2kmtuE4ZpnhYQCerRJC0fwyw4VEc6i8AfyX/QzCFO16DOcQ4LIHFCTmYx60Zp6nhmGh/32nejpqvK70IdTvAX/Y0BBYyC68pi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SH0PR01MB0747

Buffer operations is not only applicable to capture device, also
can use for output device. So separating it be a common file.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/staging/media/starfive/camss/Makefile |   1 +
 .../staging/media/starfive/camss/stf-buffer.c | 166 ++++++++++++++++++
 .../staging/media/starfive/camss/stf-buffer.h |  52 ++++++
 .../staging/media/starfive/camss/stf-camss.h  |   1 +
 .../media/starfive/camss/stf-capture.c        | 158 -----------------
 .../media/starfive/camss/stf-capture.h        |  22 ---
 .../staging/media/starfive/camss/stf-video.h  |  10 +-
 7 files changed, 222 insertions(+), 188 deletions(-)
 create mode 100644 drivers/staging/media/starfive/camss/stf-buffer.c
 create mode 100644 drivers/staging/media/starfive/camss/stf-buffer.h

diff --git a/drivers/staging/media/starfive/camss/Makefile b/drivers/staging/media/starfive/camss/Makefile
index 005790202e7b..411b45f3fb52 100644
--- a/drivers/staging/media/starfive/camss/Makefile
+++ b/drivers/staging/media/starfive/camss/Makefile
@@ -4,6 +4,7 @@
 #
 
 starfive-camss-objs += \
+		stf-buffer.o \
 		stf-camss.o \
 		stf-capture.o \
 		stf-isp.o \
diff --git a/drivers/staging/media/starfive/camss/stf-buffer.c b/drivers/staging/media/starfive/camss/stf-buffer.c
new file mode 100644
index 000000000000..7272b5ab9eb5
--- /dev/null
+++ b/drivers/staging/media/starfive/camss/stf-buffer.c
@@ -0,0 +1,166 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * StarFive Camera Subsystem - buffer common
+ *
+ * Copyright (C) 2023 StarFive Technology Co., Ltd.
+ */
+
+#include "stf-camss.h"
+
+void stf_buf_add_pending(struct stf_v_buf *output,
+			 struct stfcamss_buffer *buffer)
+{
+	INIT_LIST_HEAD(&buffer->queue);
+	list_add_tail(&buffer->queue, &output->pending_bufs);
+}
+
+struct stfcamss_buffer *stf_buf_get_pending(struct stf_v_buf *output)
+{
+	struct stfcamss_buffer *buffer = NULL;
+
+	if (!list_empty(&output->pending_bufs)) {
+		buffer = list_first_entry(&output->pending_bufs,
+					  struct stfcamss_buffer,
+					  queue);
+		list_del(&buffer->queue);
+	}
+
+	return buffer;
+}
+
+void stf_buf_add_ready(struct stf_v_buf *output,
+		       struct stfcamss_buffer *buffer)
+{
+	INIT_LIST_HEAD(&buffer->queue);
+	list_add_tail(&buffer->queue, &output->ready_bufs);
+}
+
+struct stfcamss_buffer *stf_buf_get_ready(struct stf_v_buf *output)
+{
+	struct stfcamss_buffer *buffer = NULL;
+
+	if (!list_empty(&output->ready_bufs)) {
+		buffer = list_first_entry(&output->ready_bufs,
+					  struct stfcamss_buffer,
+					  queue);
+		list_del(&buffer->queue);
+	}
+
+	return buffer;
+}
+
+static void stf_buf_update_on_last(struct stf_v_buf *output)
+{
+	switch (output->state) {
+	case STF_OUTPUT_CONTINUOUS:
+		output->state = STF_OUTPUT_SINGLE;
+		output->active_buf = !output->active_buf;
+		break;
+	case STF_OUTPUT_SINGLE:
+		output->state = STF_OUTPUT_STOPPING;
+		break;
+	default:
+		break;
+	}
+}
+
+static void stf_buf_update_on_next(struct stf_v_buf *output)
+{
+	switch (output->state) {
+	case STF_OUTPUT_CONTINUOUS:
+		output->active_buf = !output->active_buf;
+		break;
+	case STF_OUTPUT_SINGLE:
+	default:
+		break;
+	}
+}
+
+void stf_buf_flush(struct stf_v_buf *output, enum vb2_buffer_state state)
+{
+	struct stfcamss_buffer *buf;
+	struct stfcamss_buffer *t;
+
+	list_for_each_entry_safe(buf, t, &output->pending_bufs, queue) {
+		vb2_buffer_done(&buf->vb.vb2_buf, state);
+		list_del(&buf->queue);
+	}
+	list_for_each_entry_safe(buf, t, &output->ready_bufs, queue) {
+		vb2_buffer_done(&buf->vb.vb2_buf, state);
+		list_del(&buf->queue);
+	}
+}
+
+struct stfcamss_buffer *stf_change_buffer(struct stf_v_buf *output)
+{
+	struct stf_capture *cap = container_of(output, struct stf_capture,
+					       buffers);
+	struct stfcamss *stfcamss = cap->video.stfcamss;
+	struct stfcamss_buffer *ready_buf;
+	unsigned long flags;
+	u32 active_index;
+
+	if (output->state == STF_OUTPUT_OFF ||
+	    output->state == STF_OUTPUT_STOPPING ||
+	    output->state == STF_OUTPUT_RESERVED ||
+	    output->state == STF_OUTPUT_IDLE)
+		return NULL;
+
+	spin_lock_irqsave(&output->lock, flags);
+
+	active_index = output->active_buf;
+
+	ready_buf = output->buf[active_index];
+	if (!ready_buf) {
+		dev_dbg(stfcamss->dev, "missing ready buf %d %d.\n",
+			active_index, output->state);
+		active_index = !active_index;
+		ready_buf = output->buf[active_index];
+		if (!ready_buf) {
+			dev_dbg(stfcamss->dev,
+				"missing ready buf2 %d %d.\n",
+				active_index, output->state);
+			goto out_unlock;
+		}
+	}
+
+	/* Get next buffer */
+	output->buf[active_index] = stf_buf_get_pending(output);
+	if (!output->buf[active_index])
+		stf_buf_update_on_last(output);
+	else
+		stf_buf_update_on_next(output);
+
+	if (output->state == STF_OUTPUT_STOPPING)
+		output->last_buffer = ready_buf;
+	else
+		stf_buf_add_ready(output, ready_buf);
+
+out_unlock:
+	spin_unlock_irqrestore(&output->lock, flags);
+
+	return output->buf[active_index];
+}
+
+struct stfcamss_buffer *stf_buf_done(struct stf_v_buf *output)
+{
+	struct stfcamss_buffer *ready_buf;
+	u64 ts = ktime_get_ns();
+	unsigned long flags;
+
+	if (output->state == STF_OUTPUT_OFF ||
+	    output->state == STF_OUTPUT_RESERVED)
+		return NULL;
+
+	spin_lock_irqsave(&output->lock, flags);
+
+	ready_buf = stf_buf_get_ready(output);
+	if (ready_buf) {
+		ready_buf->vb.vb2_buf.timestamp = ts;
+		ready_buf->vb.sequence = output->sequence++;
+	}
+
+	spin_unlock_irqrestore(&output->lock, flags);
+
+	return ready_buf;
+}
diff --git a/drivers/staging/media/starfive/camss/stf-buffer.h b/drivers/staging/media/starfive/camss/stf-buffer.h
new file mode 100644
index 000000000000..9d1670fb05ed
--- /dev/null
+++ b/drivers/staging/media/starfive/camss/stf-buffer.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * StarFive Camera Subsystem - buffer common
+ *
+ * Copyright (C) 2023 StarFive Technology Co., Ltd.
+ */
+
+#ifndef STF_BUFFER_H
+#define STF_BUFFER_H
+
+#include <linux/list.h>
+#include <media/videobuf2-v4l2.h>
+
+enum stf_v_state {
+	STF_OUTPUT_OFF,
+	STF_OUTPUT_RESERVED,
+	STF_OUTPUT_SINGLE,
+	STF_OUTPUT_CONTINUOUS,
+	STF_OUTPUT_IDLE,
+	STF_OUTPUT_STOPPING
+};
+
+struct stfcamss_buffer {
+	struct vb2_v4l2_buffer vb;
+	dma_addr_t addr[2];
+	struct list_head queue;
+};
+
+struct stf_v_buf {
+	int active_buf;
+	struct stfcamss_buffer *buf[2];
+	struct stfcamss_buffer *last_buffer;
+	struct list_head pending_bufs;
+	struct list_head ready_bufs;
+	enum stf_v_state state;
+	unsigned int sequence;
+	/* protects the above member variables */
+	spinlock_t lock;
+	atomic_t frame_skip;
+};
+
+void stf_buf_add_pending(struct stf_v_buf *output,
+			 struct stfcamss_buffer *buffer);
+struct stfcamss_buffer *stf_buf_get_pending(struct stf_v_buf *output);
+void stf_buf_add_ready(struct stf_v_buf *output,
+		       struct stfcamss_buffer *buffer);
+struct stfcamss_buffer *stf_buf_get_ready(struct stf_v_buf *output);
+void stf_buf_flush(struct stf_v_buf *output, enum vb2_buffer_state state);
+struct stfcamss_buffer *stf_change_buffer(struct stf_v_buf *output);
+struct stfcamss_buffer *stf_buf_done(struct stf_v_buf *output);
+
+#endif /* STF_BUFFER_H */
diff --git a/drivers/staging/media/starfive/camss/stf-camss.h b/drivers/staging/media/starfive/camss/stf-camss.h
index e2b0cfb437bd..ae49c7031ab7 100644
--- a/drivers/staging/media/starfive/camss/stf-camss.h
+++ b/drivers/staging/media/starfive/camss/stf-camss.h
@@ -18,6 +18,7 @@
 #include <media/v4l2-async.h>
 #include <media/v4l2-device.h>
 
+#include "stf-buffer.h"
 #include "stf-isp.h"
 #include "stf-capture.h"
 
diff --git a/drivers/staging/media/starfive/camss/stf-capture.c b/drivers/staging/media/starfive/camss/stf-capture.c
index 367bdc924fb7..5cbafac46ee6 100644
--- a/drivers/staging/media/starfive/camss/stf-capture.c
+++ b/drivers/staging/media/starfive/camss/stf-capture.c
@@ -93,20 +93,6 @@ static void stf_init_addrs(struct stfcamss_video *video)
 		stf_set_yuv_addr(video->stfcamss, addr0, addr1);
 }
 
-static struct stfcamss_buffer *stf_buf_get_pending(struct stf_v_buf *output)
-{
-	struct stfcamss_buffer *buffer = NULL;
-
-	if (!list_empty(&output->pending_bufs)) {
-		buffer = list_first_entry(&output->pending_bufs,
-					  struct stfcamss_buffer,
-					  queue);
-		list_del(&buffer->queue);
-	}
-
-	return buffer;
-}
-
 static void stf_cap_s_cfg(struct stfcamss_video *video)
 {
 	struct stf_capture *cap = to_stf_capture(video);
@@ -263,61 +249,6 @@ static void stf_capture_init(struct stfcamss *stfcamss, struct stf_capture *cap)
 	}
 }
 
-static void stf_buf_add_ready(struct stf_v_buf *output,
-			      struct stfcamss_buffer *buffer)
-{
-	INIT_LIST_HEAD(&buffer->queue);
-	list_add_tail(&buffer->queue, &output->ready_bufs);
-}
-
-static struct stfcamss_buffer *stf_buf_get_ready(struct stf_v_buf *output)
-{
-	struct stfcamss_buffer *buffer = NULL;
-
-	if (!list_empty(&output->ready_bufs)) {
-		buffer = list_first_entry(&output->ready_bufs,
-					  struct stfcamss_buffer,
-					  queue);
-		list_del(&buffer->queue);
-	}
-
-	return buffer;
-}
-
-static void stf_buf_add_pending(struct stf_v_buf *output,
-				struct stfcamss_buffer *buffer)
-{
-	INIT_LIST_HEAD(&buffer->queue);
-	list_add_tail(&buffer->queue, &output->pending_bufs);
-}
-
-static void stf_buf_update_on_last(struct stf_v_buf *output)
-{
-	switch (output->state) {
-	case STF_OUTPUT_CONTINUOUS:
-		output->state = STF_OUTPUT_SINGLE;
-		output->active_buf = !output->active_buf;
-		break;
-	case STF_OUTPUT_SINGLE:
-		output->state = STF_OUTPUT_STOPPING;
-		break;
-	default:
-		break;
-	}
-}
-
-static void stf_buf_update_on_next(struct stf_v_buf *output)
-{
-	switch (output->state) {
-	case STF_OUTPUT_CONTINUOUS:
-		output->active_buf = !output->active_buf;
-		break;
-	case STF_OUTPUT_SINGLE:
-	default:
-		break;
-	}
-}
-
 static void stf_buf_update_on_new(struct stfcamss_video *video,
 				  struct stfcamss_buffer *new_buf)
 {
@@ -353,95 +284,6 @@ static void stf_buf_update_on_new(struct stfcamss_video *video,
 	}
 }
 
-static void stf_buf_flush(struct stf_v_buf *output, enum vb2_buffer_state state)
-{
-	struct stfcamss_buffer *buf;
-	struct stfcamss_buffer *t;
-
-	list_for_each_entry_safe(buf, t, &output->pending_bufs, queue) {
-		vb2_buffer_done(&buf->vb.vb2_buf, state);
-		list_del(&buf->queue);
-	}
-	list_for_each_entry_safe(buf, t, &output->ready_bufs, queue) {
-		vb2_buffer_done(&buf->vb.vb2_buf, state);
-		list_del(&buf->queue);
-	}
-}
-
-static struct stfcamss_buffer *stf_buf_done(struct stf_v_buf *output)
-{
-	struct stfcamss_buffer *ready_buf;
-	u64 ts = ktime_get_ns();
-	unsigned long flags;
-
-	if (output->state == STF_OUTPUT_OFF ||
-	    output->state == STF_OUTPUT_RESERVED)
-		return NULL;
-
-	spin_lock_irqsave(&output->lock, flags);
-
-	ready_buf = stf_buf_get_ready(output);
-	if (ready_buf) {
-		ready_buf->vb.vb2_buf.timestamp = ts;
-		ready_buf->vb.sequence = output->sequence++;
-	}
-
-	spin_unlock_irqrestore(&output->lock, flags);
-
-	return ready_buf;
-}
-
-static struct stfcamss_buffer *stf_change_buffer(struct stf_v_buf *output)
-{
-	struct stf_capture *cap = container_of(output, struct stf_capture,
-					       buffers);
-	struct stfcamss *stfcamss = cap->video.stfcamss;
-	struct stfcamss_buffer *ready_buf;
-	unsigned long flags;
-	u32 active_index;
-
-	if (output->state == STF_OUTPUT_OFF ||
-	    output->state == STF_OUTPUT_STOPPING ||
-	    output->state == STF_OUTPUT_RESERVED ||
-	    output->state == STF_OUTPUT_IDLE)
-		return NULL;
-
-	spin_lock_irqsave(&output->lock, flags);
-
-	active_index = output->active_buf;
-
-	ready_buf = output->buf[active_index];
-	if (!ready_buf) {
-		dev_dbg(stfcamss->dev, "missing ready buf %d %d.\n",
-			active_index, output->state);
-		active_index = !active_index;
-		ready_buf = output->buf[active_index];
-		if (!ready_buf) {
-			dev_dbg(stfcamss->dev,
-				"missing ready buf2 %d %d.\n",
-				active_index, output->state);
-			goto out_unlock;
-		}
-	}
-
-	/* Get next buffer */
-	output->buf[active_index] = stf_buf_get_pending(output);
-	if (!output->buf[active_index])
-		stf_buf_update_on_last(output);
-	else
-		stf_buf_update_on_next(output);
-
-	if (output->state == STF_OUTPUT_STOPPING)
-		output->last_buffer = ready_buf;
-	else
-		stf_buf_add_ready(output, ready_buf);
-
-out_unlock:
-	spin_unlock_irqrestore(&output->lock, flags);
-
-	return output->buf[active_index];
-}
-
 irqreturn_t stf_wr_irq_handler(int irq, void *priv)
 {
 	struct stfcamss *stfcamss = priv;
diff --git a/drivers/staging/media/starfive/camss/stf-capture.h b/drivers/staging/media/starfive/camss/stf-capture.h
index 2f9740b7e500..fe2489d55090 100644
--- a/drivers/staging/media/starfive/camss/stf-capture.h
+++ b/drivers/staging/media/starfive/camss/stf-capture.h
@@ -48,28 +48,6 @@
 #define U0_VIN_P_I_MIPI_HAEDER_EN0_MASK		BIT(12)
 #define U0_VIN_PIX_NUM_MASK			GENMASK(16, 13)
 
-enum stf_v_state {
-	STF_OUTPUT_OFF,
-	STF_OUTPUT_RESERVED,
-	STF_OUTPUT_SINGLE,
-	STF_OUTPUT_CONTINUOUS,
-	STF_OUTPUT_IDLE,
-	STF_OUTPUT_STOPPING
-};
-
-struct stf_v_buf {
-	int active_buf;
-	struct stfcamss_buffer *buf[2];
-	struct stfcamss_buffer *last_buffer;
-	struct list_head pending_bufs;
-	struct list_head ready_bufs;
-	enum stf_v_state state;
-	unsigned int sequence;
-	/* protects the above member variables */
-	spinlock_t lock;
-	atomic_t frame_skip;
-};
-
 struct stf_capture {
 	struct stfcamss_video video;
 	struct stf_v_buf buffers;
diff --git a/drivers/staging/media/starfive/camss/stf-video.h b/drivers/staging/media/starfive/camss/stf-video.h
index 8052b77e3ad8..59799b65cbe5 100644
--- a/drivers/staging/media/starfive/camss/stf-video.h
+++ b/drivers/staging/media/starfive/camss/stf-video.h
@@ -10,13 +10,13 @@
 #ifndef STF_VIDEO_H
 #define STF_VIDEO_H
 
-#include <linux/list.h>
 #include <linux/mutex.h>
 #include <linux/videodev2.h>
 #include <media/v4l2-dev.h>
 #include <media/v4l2-fh.h>
 #include <media/v4l2-ioctl.h>
-#include <media/videobuf2-v4l2.h>
+
+#include "stf-buffer.h"
 
 #define STFCAMSS_FRAME_MIN_WIDTH		64
 #define STFCAMSS_FRAME_MAX_WIDTH		1920
@@ -40,12 +40,6 @@ enum stf_capture_type {
 	STF_CAPTURE_NUM,
 };
 
-struct stfcamss_buffer {
-	struct vb2_v4l2_buffer vb;
-	dma_addr_t addr[2];
-	struct list_head queue;
-};
-
 struct fract {
 	u8 numerator;
 	u8 denominator;
-- 
2.25.1



Return-Path: <linux-kernel+bounces-127682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D93D894F69
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C373B21C27
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926085D471;
	Tue,  2 Apr 2024 10:00:43 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2134.outbound.protection.partner.outlook.cn [139.219.146.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE605A0E5;
	Tue,  2 Apr 2024 10:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712052042; cv=fail; b=CuZ/sqh8HH0F5ARTb27Rl7iMgNwyyicoJrs/ZcEQCWnc3WOx6KvTwEF8USXSTyYDr75dCUbah9Do30EZb6hI5m9dBHMusv8Fj7BOxUsAhzC2ben9CdvTW8JwO362xK6qEpVMv+h+u9NK1WQ0yF7HAWvHuV1vFpAWJtvoHw95iM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712052042; c=relaxed/simple;
	bh=sayo4V87xszCiBFe1VAH/qoEodDVGFjtvlKqNeihdsE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=czvLfSzvhk4Zx1XCiIHwLOzyUXWEQy1iq7Y7F7U5OBamVWUAFKbP872w6hcHi6rqr8NtVSgXn4sFbGlmShXdkUVyu7qOvyrCuyxOAy7LcEfe5GsYkDxqEKKRabkXzYnGUzq8u/UPARDyD+3uGx5eBhnRA4frjU/3koBeCtWqw7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ArJ8TetSvsuXPOzNThG5rtFSLidHuTvnoWgWpO3h1K6qMaKVDtymsLZ0yIrmnzj4EbOeWagU8hER3Q0qKVztEpAkQI32sQzypR+8OKaY+dfsdfmdEGy2UEi2epKnxNmnur5LCYOGXbkEcZBE0bL9DwmzHg2SYUb4CeRMP1WcMS1cqFT6tEb2U+H2jmJBOtagu4xAZnWujZRuIu71Bcy+TyESl6q1Sox+pq5ZZMAcheuFyfhgQk2HOxxcLWRLfs+/a4EGcM2IYHrV/M+tamKNWZjJ4yW7m95kDi2wbVyf+B8E/OzWM7nreq+xU7NvrAbtsw+TzXWfaMiRgk1gL6aYCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bGPoJG6WZTSrICAiJmktHByWoI1K0yWN+ivdhvmttgQ=;
 b=oaYFQx+TLqRESdB1QsTkkLH7jzb7tyGcJjzMN0ghDfTSYtZkLU+GLJZbXuiFoBXzBezYpwItuWD1b9LbyapyHXal8fTb7ZTqhjDdeR5DrKaN3Egm2iyreVGd8dkR0YJ1tKqnyMbpLDCdpfZk/NYWIRHmPFWvYz4MZ2KDzSSFMpf9Y497nOGTOWq2VJ9yzxTlRgBbcA4KV8HNMFGud7Bh6NMep31K+qqa7g6bMxuifKAMi8MC0dbaeC5vWp1AuksJF6p2dAJ2d5EA9b7F+eMIuV3UCHI1OS3ODyRO5V2fXBbjfWM+iROLl2m+kslrTp3yItasH2NAy0VMuAP6Rqksrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0862.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:27::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 10:00:31 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::b0af:4c9d:2058:a344]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::b0af:4c9d:2058:a344%7])
 with mapi id 15.20.7409.038; Tue, 2 Apr 2024 10:00:31 +0000
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
Subject: [PATCH v4 06/13] staging: media: starfive: Separate buffer be a common file
Date: Tue,  2 Apr 2024 03:00:04 -0700
Message-Id: <20240402100011.13480-7-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: ca6852c0-f69f-4353-f52e-08dc52fbbb13
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OVpWn3tQYTTomH0+0RkmhXZf+tTgW1cLMhJcublAaX152r1rJ6zyGNjrdABi07c9cYKQ4Rec2oTCg0JgjDhuQghPyWr753JQ+CWFsQmzpzuctusMSH9zk5rKRZ/OGg/p98nvjKWrOT1X37tJMYKQBrX1lFg1na75zXc4SfZrBAXVOYZ13lvEVUmjvPF5CvKr/Pw+YOj2+JF9ww/n+qlw6EYqwA6GPqwNbFaEYGanY5F8ee0jCol1M4ReAxIAWdaeDZNHFj09aMNum6K6e/MjPS9bdplmhLJv8cdO5Wcu6ZgeYXx9TJkcMcecd3hBhACyU2LaQfY/Oe0j31I63q7PKmPOWlq4hHso7Dr8JlkDePJgGk5H5MW1Hipuox+VsX4wGC3YUsvvMyFD4/a4IeDf9VVjqTu+P2HILV/ZwBHfAWFBWYhTXyDICeFBtwcXTrZhSSWXuQPpu57Pb5eHVJSec+Efi+DG38/Jk1iK00q272OvFXi8Su9Bc6gKgYH/+XuqrwlVUEcNMshytzkEgdnfRHWcjbCcZulJwImSMjJg1tHAAEPI86wZL31gzA0+y0xT8r9MoL5Gft4BJAnyWwfYdZIndOXkyOfpUn8+Jp+vza60NywFKwz0d6D7OlJIWDKv44b4C317wpKeNlC/qKLHEg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(366007)(1800799015)(7416005)(52116005)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cQ8faRxwXZmVwnKvHa8p4q2zOrcNb8YrzqJiW9tChxR4sTxORAVvd+8wEPyY?=
 =?us-ascii?Q?BKBqc32oWgYtyqzbg2CSz73/LsSgb/Im73lj9VlhwQb4WIbhc5UJIgwjEzqm?=
 =?us-ascii?Q?A0sxSZAIKL0iG+SZF6FbDGnaTRogDhKWFgPS+UNf05lFEZDFYO4d9dqly5Jc?=
 =?us-ascii?Q?O52b5XGv/23wbkErE0YSCmEqAj4DyhVTbhxuv1UQ2BOG9q8Y9C3oeUEVuaUT?=
 =?us-ascii?Q?UWWmvM6cHu3MBE5AzhYW2l6axUXOa9KJlRC/IVpHxJLJjwz9pr71IqFUznUq?=
 =?us-ascii?Q?66We3tHOdz75ggACjuc6ZXOjQo3yfeLcbQ9XwFncbdnjHHUz0s6/vJLIMJ/V?=
 =?us-ascii?Q?ziaEd88UJ2n08UCenECceDm0/8iAy0ZQs5UVB0nK+ZmaG6KpNobZ8uMoboIC?=
 =?us-ascii?Q?QWrY4mGyhOdbQIsjwJzTLZoX6GD7/6Ev7JxtlxKzU5OZSGK8ZXMIjBoYAtMJ?=
 =?us-ascii?Q?q43tTzcwjCIhw6DEMDsF5vN11xhHXBFBdz1SGPfC/tiRGLN+7fW6ErupnvI/?=
 =?us-ascii?Q?ovabhcArPNKXD8JaEhryUmiut/HJFUdB8hDCu2ODHO1YB77QFrrnuDH/G6/W?=
 =?us-ascii?Q?CeI96FteDqj8ftjQeCc/9dykvuN10GeigUo3/JaCkVEfIrci5jvpx1OyHVFV?=
 =?us-ascii?Q?novrMeoMlSwN4Q6KPpZRbQVNzhcTRmCz5y7yNj4kFeqIcl4e7sMvE4jiTUpi?=
 =?us-ascii?Q?0UWu0Qb5Bw53G2jF/3WOxQW1xihh7r4BfNzYONeS7n46HVGncqFsxORxR9hb?=
 =?us-ascii?Q?Q9d5RLlRlhfA5HKBTD9XQHz1U/Pumqif1U1bJIP4MEBDUS9m8q2PCmZvPU0m?=
 =?us-ascii?Q?RTja6kjn+JGL6GvG4TF9gBKrruv1zZ4YjGO5/7gdOrKK8tH6UNC9MIHKNq6S?=
 =?us-ascii?Q?lPtgK0kOZC7pcF7CKCqIDtwfahER44xyOX6ZRprY7jJAFOqHn4BGkkvLCggL?=
 =?us-ascii?Q?Ysj4JimSh6mCjKtFUOVJY0lWEHv+ozok6k74QQsJDl1zV+PVZjnB9fNXcfn2?=
 =?us-ascii?Q?JjwX2PZ2j6nioB7+I17fybwVY1kM/cwGXlt2sTnit9lgUl7oRJF6nprpumxb?=
 =?us-ascii?Q?rdnErAsf8P9v2DPuB73QoYzCtzVE8gZSPErhaTpqjby2I4FnOOSjAfimeKpK?=
 =?us-ascii?Q?4Kv4lAUc75dwkLBKnfuNAgC5BCOVu2qhKuGF7iZuO2JA+rBxWfR2AI9eIaUf?=
 =?us-ascii?Q?XmBGszDhEWNzCsuFUkX4A6YPfuEM59mn7RpXWUIcrdRdewsRJlvdYqdwcOiW?=
 =?us-ascii?Q?dkTKXSKa968UFq2kfBjuE43DJbN2F/LCH399TRM5PPlwA2/WsQFiysbb261b?=
 =?us-ascii?Q?fVdv4WUi+ev4hgB2hYD7pLPufmZ+46jd3QyRSRKTz99k6A0x/R+9iZQm/g+f?=
 =?us-ascii?Q?6VFmRKgz6MU42DL2fPtEi7tmL+2Xu41LritmAyFyOVTw9LeTsgaJp7LrMOh9?=
 =?us-ascii?Q?AO2rxv6kf8MNi9KEchuZawWHgFNGfMwsOBnTf4urBUyj4thfXcs+RJIHqTTx?=
 =?us-ascii?Q?Meag8XeiNP/ibj1wSNWdOqd2WivB+ObK8cYUBXubCVT+WFJrrKfkKdMUatd7?=
 =?us-ascii?Q?aJ7kuFVWyQWf6UhnSO8B/xxX2bOW6NCdq74GPQcHGwVJZVF3bJcL2L0Tzkql?=
 =?us-ascii?Q?hg5ZqIqsjO1YMvL1EBPAcqY=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca6852c0-f69f-4353-f52e-08dc52fbbb13
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 10:00:30.9835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RlwMvvQsgoD3+PZ8/MyscuKgUxKrh7azegWcTaWR6y1DFprPV3h1F+qkW8maIV9VcvkvER5mMHtD7LlszWbh+5vKOkPiTpzkIEJ7ZC7VuCAdMRqKDK/+CxkWvdDdEA1w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0862

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
index 494e56e731f0..696d79920713 100644
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



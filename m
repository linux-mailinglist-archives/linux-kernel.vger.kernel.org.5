Return-Path: <linux-kernel+bounces-52283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54686849643
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 795AE1C229B4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D919134AD;
	Mon,  5 Feb 2024 09:19:31 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2097.outbound.protection.partner.outlook.cn [139.219.17.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A05412B84;
	Mon,  5 Feb 2024 09:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707124769; cv=fail; b=eHaQNPTKviojof9UVpaABUhjuC3fJn/uECbI4ucCih/NK8NP7Hzu6v4lVvKWwIkU4LFhtaAAKg18dzxGJq5qI+08S3sQp5RnXuxZUCMBM/RqVK3P5a3Cscc4ceO/GYFYJ/orGx0mbX4CVE2LCvM8J/dwTRWJRr4OfcVyrwAGtUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707124769; c=relaxed/simple;
	bh=+1D7IvLRJBTd04sDwZpOplB3rB5YLSzF/fM/IdO+03U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z2ACH+RtXbMwpj0V7khWrsHQJSfdWSj6FHFC3uXr2MZX8KPxBkMwrkkUoQe+gFO/uwB5scbukUp5ZmKnYFVdzaH91g3SfI/ZtzDYsz6EwKTPPmBtYihpYRX4rSvrP7Ig9IGli1BBOnyHawyVhwL73piMe+pl2pvMgvgBnUK5qD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m3QxqBnQ12dXc/YXHxU71K2uF8wJ4uFivT3NqvPs/rB/S6a55nNPs0zdpKi6DCwB5za+xgedpOqdwCD07QK+AbUgIxjTWeUZvdVjYtzpfIuw/fvsQ243wFhA8fm5FlaDtVxBIx2TAYuvY4EPaIeFIhRzxmMjew4wsFfTwIN7xvdLW9Jy1e+Oe8OlmboBu5MfDfOHxilnUV76KPB28ABskNCxn6D0GHhmtuFOcNnkfp9hxN1l3i3gMaBgVOW5f0nhNCDF0Fou0JCCKucQjdG0by1Hq1SKPS+CwEj/FHEV71qR5z4/+3emucgRXTGuEPw/CSojRzljCVBkBUE4frFd9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QBKebo5g8nQNZpo/7QeoJbRcWRwazmkDu4kDf3PuBJQ=;
 b=CLP64KgnxRjMqpSlBsGY2xGAGPrMe8TQnG12l8xXYt2rFaxyFqghHTmXcifD4RwROf38z1yuvRWo4+WsYsAmWmyVqhHyPEeReDPSkEsZT4KEpd1mwt/utWhJ/6z9wUt7N4lN73U+eClJzWp8hPjlzTtKSBVHcXCufOPkobovF4IkT1gmhHCMvJnJqZZPuAB3TING+343HKNI90cauQGceyzSvmsg4MS2TfVGgRHL77TB6LWvSE1arq0oNjhzp4c+4yiNyNzBSkRvE6jfMM/FDO+Dju2EivQ1g2K6NGvPJITs7ekS6LaugTpNsOjyQX3aQFIXDhgjQ9ez25K1uvELog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0815.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 09:04:43 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::b0af:4c9d:2058:a344]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::b0af:4c9d:2058:a344%6])
 with mapi id 15.20.7249.025; Mon, 5 Feb 2024 09:04:43 +0000
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
Subject: [PATCH v3 06/13] staging: media: starfive: Separate buffer be a common file
Date: Mon,  5 Feb 2024 01:04:17 -0800
Message-Id: <20240205090424.40302-7-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7097c64d-ed3b-4b8a-4adc-08dc26297e45
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5A/NgJEFOrBl6hJUejIi/7trHEYgBof68a0VkR5gk2450ZstyBWzx7VQ9SfSBqJ1lwh6F0zApIJo2HFCVsYaqyUKaCBCcbdh9kEUhcgzzK4cmTTGEUMBlmLd2VAZON+gOuiGJUiG4ZpJ/26JFk7Bg4uE7KlOG/En+XVKTS+mkZSVpT0bRtz7DC0Ef+P28nnZ4u7n9zuYclLf3Bk/MjbpQoDxsXz5y+Cs2YG45U7zBu5Y/jhW7yZHBmGHIJLSh5nPb6ergSDmS4XPchfFKbWyBVHQ0Nts9tJy9lI7ssWCgOgWpHLoFTL9STsx79XoAIMTD9+eRKXKbzSbLI2kXl5qgiD7CrRky6mpH0kh2ZygYr8JALe0eMKZEwIf9s2PJnhD/B4m5420X8WpIpJPWOOzfqW29E3qrlFLVg97ZHZiNOwWPdBFF6xdkyGfhlWkHunMpzpTqX1hPEOtdZVYFZren5evlinhFD7r9i9otmEpEVlt4lGZkPXOKZg2TfQ9afZQIX3PlTc3GDWy6feBenphD8CYkBFCDWbfbHy60wesDCKOgZyI8U9auUZo8yLnwiNB1s8+kLHKEvP3DnlAhLb9LA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(366004)(396003)(346002)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(41320700001)(6666004)(52116002)(36756003)(40180700001)(508600001)(38350700005)(40160700002)(38100700002)(2616005)(1076003)(26005)(83380400001)(86362001)(5660300002)(2906002)(7416002)(30864003)(8936002)(8676002)(4326008)(110136005)(44832011)(54906003)(66946007)(66556008)(66476007)(41300700001)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h2xcPNG/aaWbor7zF0vwAJ9CDyJziQ5PVxFsbyF6gcog8ImkDfRcuT1LxgJK?=
 =?us-ascii?Q?44nbsqNjlsei2gAvojlNP98U6DQ3CMXMaslYi9Ho6M5FUef43T87hp5+rPIC?=
 =?us-ascii?Q?ecCcEPoHB9TCzhnb4DIKx8o8NhIuYtk7qd8QVWH7cXh79L2fTfVZyNaIQj9W?=
 =?us-ascii?Q?LzJIvKBRBqUDvZPpAvjUyHFWrZL2HMyM1yn/AOiGCc2+GpJ5eUWOLMU7DD5e?=
 =?us-ascii?Q?1+aQ2lWtnjzDIbMJoX5y7vV2Lz+CW/a4G9VCYE/mYrkvKCByCFFjFDa/eGBV?=
 =?us-ascii?Q?qVEmdZ1g21qP6ha+W4RFd7NsZqLNvD2fz6Z8zbFftjDKC1QyHJTEhk8UHDtT?=
 =?us-ascii?Q?rev9wjl8ElxqL+KrIiRT8Mfv+fQiy/u+hqN29K3Tf53XKtPWOkdY5rNo4LqP?=
 =?us-ascii?Q?OOKMxB4S5e2+C6lxq3uirUai2Jr3ksyKmECin76f3APzHYrHuUj9wZjHV9VO?=
 =?us-ascii?Q?j0R9XpNrwFOMjZyBeEHOWtRom163fCowVa0NpvkIYAjXMYOAxBGQgrEOAXuG?=
 =?us-ascii?Q?7B12/rx0oFBovWhPgujtiDAByFTCKlE9fgaHZTwg2DDY9WBcOu4si+N/N7rd?=
 =?us-ascii?Q?0WM67NpYyXNKu+x4CahZhWehwRnb67ioa7hBmbH1aWlzJ6fRt+poR1PjRCvv?=
 =?us-ascii?Q?s0Ja+fSP0tndwDcV/9vtGlP65kk17NK5O2c6r4H8GoGIEvOUjhY0ojzrz6en?=
 =?us-ascii?Q?9NuZT5euAwpYUSG8ko8mo0JLhmmU4SxHrIvWarIEoIkzoPX3+bJic7XfW4kg?=
 =?us-ascii?Q?N9yPqC7peq+QNsW7cbIPIysVlLwFMwpVsTLjJ0vJ7MvPo60oeJVq/iVtn0U1?=
 =?us-ascii?Q?5I+5CRPM6Hrgkdiy2BBZNO8Tin0mfDAj6lTgWIQB1AGReQXI4EAVtbEeFsQE?=
 =?us-ascii?Q?MNJAS63+A5aImaW9NBUoSwKGNtFMUCNTi6LLlsGt1DxCVTt/xViXbiACNovw?=
 =?us-ascii?Q?xQtqV2ItF2Npjudee5HxrQoAsP9kzZtjOT1po54FBkfA7WYGzjcrWCd4MEqt?=
 =?us-ascii?Q?+89Y7qJEw1CGkhHJNazLNmnpdskBZqA6YzPUzxcWJn5ahfx1pJV3MeHHAXB7?=
 =?us-ascii?Q?rSzI3/SEsViSNoVfdizvV3KISoOVOBjITCnK/48e4FNGVO9qXjCKFd/ki5pS?=
 =?us-ascii?Q?t6FPNb98vHsy8/XfJ5jn4vME7OCvDJjBNkFOr7/EQEL/cudKNlsBWUpXRsNF?=
 =?us-ascii?Q?HniRkwhkww6rKSZrpEkQw/aNYPGgN6DRwf4vla0WLUsEkFjYWYvX6fUSAKQB?=
 =?us-ascii?Q?XkSWeL6GOGtC5zPJeXd0AKuhJHdYSgiLm7VDXUbPWbYqZ9WSRnxWPTpb0yzg?=
 =?us-ascii?Q?amGCfKi80xM2voN3nlzxobuRy8Rov97lmZ18ULVIR6eB5WURhs3yN13Uh00o?=
 =?us-ascii?Q?eN0qhvAghk829FS2bTlmFZ2zpS0vZC5G9KFaLzz/e8CD1hzkZUwyh/YCPh+I?=
 =?us-ascii?Q?puResBEpRSIuXUzszaSlmwdzNWqiDhH3fjHAKwm8Cr0N0zY/zLYe27Yyoo74?=
 =?us-ascii?Q?MT6rLKGhv8+DMKA9gZKgmZBICF1hcIbKMweDQ7BV3ziFObt3IzcqqqznsWpr?=
 =?us-ascii?Q?rZCtd8HxspxOtU3BUm6MGO66RYocHQES27OTh2kF5Hnj/lVnc1YI0eFOob81?=
 =?us-ascii?Q?fcoZwR5R03FVZALx8GbeLX8=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7097c64d-ed3b-4b8a-4adc-08dc26297e45
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 09:04:43.4908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mx9pV1aUOUj4jeKMYXYwxbRoSWMCV6bhzV7z1IEQRDbBprZa82pAGawhxLrWLjjWIXhInmF3U4Px2El8MIH6NfEwPrQFsjK/1juQxFiCHdkjlCJd/5AecnwdtMxAS//t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0815

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



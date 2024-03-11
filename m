Return-Path: <linux-kernel+bounces-98728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6402F877E77
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 11:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB8C1B21A3E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363A63B79F;
	Mon, 11 Mar 2024 10:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b="F3G2wuWk"
Received: from SE2P216CU007.outbound.protection.outlook.com (mail-koreacentralazon11020002.outbound.protection.outlook.com [52.101.154.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB31838F82;
	Mon, 11 Mar 2024 10:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.154.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710154601; cv=fail; b=FVYeFDahgy9jo50BeZMm/Tc26gjRTg2VQPu0EjY//SGO0U5KKgSQ1jW8X9ASABn800D6MhUWeC/6qcTIQ0eno/aJplNygcugEj5MLsUHLv9zt6rm12Ev8QmlNfM9JBOCd7/gIchxXnIvdrPWz7YnYaJIkA7vDM07CC+NFBm0s3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710154601; c=relaxed/simple;
	bh=c699SjHFtTzC7I067eLP9WqVNL2aredc7aHxW6xMntE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D5y2rSRPa5iV9iYzgHW4+LccYOnTffkKXvdu3qDAU8vCOSq5jTTQoIgjwnsx8SdSOje40QZjO88Ibdv6fkkxOEmp05FC50eRyjB/luQZlwMN5KG9R/MDQ+CCWWF+oYP3460xp/KVYs1PLmvuxCgNQTgFym28be/9fjtQReEQOzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com; spf=pass smtp.mailfrom=chipsnmedia.com; dkim=pass (1024-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b=F3G2wuWk; arc=fail smtp.client-ip=52.101.154.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chipsnmedia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gb2bawGp5cP34Uk03W1SCXn37hVi3m80AUxWin/lP1xiWngdTjuZeBWUJ8rgmFhmEFbkaFBPXxzYSqFnJFoaH/tenDLwIw4+pvRMuArwrDprGlyrhrEwEeVea3djYhRftYsChyg/XwbxYBdesDXPzwa1yVxFF4E90PfWr66yx+fGZkX1yEutGysG0fw7FJXKRc7BpAt9/D4khoan67LRVPijkW/OGuoLTS/AGD7IYkeCuZwKAu5aBGYkY9pwml4IjfAjgL9B3yxBr0QJtTuSQGHBhwVrvcJd9Gy54TuDTtC3o3kKnTF5ku/X+i8YK9xzxgDe/ZaeXlAF6kMgdBiJhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pBu1pcMHOWrYRIuELwvfaJNrJcQdtFs5qXu5g0hd17c=;
 b=NUAP3motvxX6mn2naE64itbYZgGsbBOL+r+StEa16oWkkokveS6qpYcKx0lkNPy5NcVYZAmaYK9bNuh3rw3jloWjM20Wce15lbXmtPBrvCjw+yT6YnVp4nIZ56MWf7Wn4kztMqGIPid9ssJ8NByUhi9OTFAB3mx9yxEuaFM5DDqfMwqnLXz5IdFom6H1O52Xg4e1v5+anmMZyKvrWAmUKKET8zF5k0vKpPItxKXuSfjGI/6cV24hhMRn/I1kooxIOyxqDCy/C1wGH1GHR6bQRSmENd5suahLlUx/CG/zRvjKi6OIuZZhm/WisWXpex3vzC48sx8F+qSl0BZMNOds5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chipsnmedia.com; dmarc=pass action=none
 header.from=chipsnmedia.com; dkim=pass header.d=chipsnmedia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chipsnmedia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBu1pcMHOWrYRIuELwvfaJNrJcQdtFs5qXu5g0hd17c=;
 b=F3G2wuWkJ5eJ29EbRCX8VTyqgZp8RtgJkKMN12JwNJn2ujEWppH4Yr8WlqiDAZQHa3C/dwNawvdYgJ3TGkQgNfSo/hTgd0e/paxYaKWJ/rNZgOJjsGsFbmvZ3HIkLI99ya64P7eFe+0KIHTp4q02Phnd/GQXic8s88YTCulawjw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=chipsnmedia.com;
Received: from SE1P216MB1303.KORP216.PROD.OUTLOOK.COM (2603:1096:101:15::5) by
 SE1P216MB2024.KORP216.PROD.OUTLOOK.COM (2603:1096:101:15b::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.36; Mon, 11 Mar 2024 10:56:31 +0000
Received: from SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
 ([fe80::ebb8:2043:fd53:303a]) by SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
 ([fe80::ebb8:2043:fd53:303a%3]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 10:56:31 +0000
From: "jackson.lee" <jackson.lee@chipsnmedia.com>
To: mchehab@kernel.org,
	nicolas@ndufresne.ca,
	sebastian.fricke@collabora.com
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hverkuil@xs4all.nl,
	nas.chung@chipsnmedia.com,
	lafley.kim@chipsnmedia.com,
	b-brnich@ti.com,
	"Jackson.lee" <jackson.lee@chipsnmedia.com>
Subject: [RESEND PATCH v2 2/4] media: chips-media: wave5: Support runtime suspend/resume
Date: Mon, 11 Mar 2024 19:56:21 +0900
Message-Id: <20240311105623.20406-3-jackson.lee@chipsnmedia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240311105623.20406-1-jackson.lee@chipsnmedia.com>
References: <20240311105623.20406-1-jackson.lee@chipsnmedia.com>
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0127.KORP216.PROD.OUTLOOK.COM (2603:1096:101:1::6)
 To SE1P216MB1303.KORP216.PROD.OUTLOOK.COM (2603:1096:101:15::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE1P216MB1303:EE_|SE1P216MB2024:EE_
X-MS-Office365-Filtering-Correlation-Id: 25069910-1368-47a6-d792-08dc41b9e8be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kCNt3y5e5ZDeYTgEWydzXOfFb2EAY0DshyJtiW+Prl5lzT/w+gyoO/n/LO5IV/P4JAsefxi6tBU/mZPADlVDPcjgbr+4TioJvYvJwF2lWfFsKnXNo99pgKs09+I7tDdWLDtGelUffEkEfQPP9USs6yp+LLd0YIZT3Wo8h1GHafXAN2rHUboIfrdPUJXVUAjA0qWET6AlonEwvZXZ7YHCGSaCrpOCieNNojgX7GMm9bvAl6ZxmWhdFaIYR/V3p5p8OZaMgLxneotp32m+768XIQlv9ljI5/o8TqOOfKxvfDgVOYgebu/QRhD3HzKRkoAb9+pLoL/ODujzbuylEQZIlR5clhBjtH3AIE8oTTyvpaK6MdWuRr2ua5Nioh9xeBTlqXT5/tRjIMCsiW5BYn0J751YWJz0ZJ4z59jdL5hpaN11DsAcf2tDgqflgcoBeB9S6m0zfmEdVRUFMEfDsCXXW6gEl46grgUAFy0wtjeoMU3z4/mni/K560H/Ec57APM9P7HjDVptgSXAwfFa/X1DhPVrY71b2c9ZWCh2eez7GpzqWQuBNRv7BgrxG6GxPg4PDWQLZjA7ixdI6NOdqkYbml++4uIBfCHehdvcqRIE0SvR4SCI0sXJMX2iyYLTqEltfnxLXTEHxubYw6/tLHC+jKRBauUCSh1hWc3JJYpg+Rz4ddIrIbVR1WMGfPm4Eqb5CCKuKajE8wWqivfBciUbZA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE1P216MB1303.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jRR7m5irvb264qJDRSkz4TN0tcgRdGO4BIe/93FSlYM3uKJYQfxw7qI8iYAS?=
 =?us-ascii?Q?ogHFn6Y8FVzLY+O0NCpVmP13zTBd1RNrCiSByseRUVUthERQWiElADAkb84A?=
 =?us-ascii?Q?14BIYi13Jqf/6jq6sUjnp9Ejy3lBDg+4a1Uuw7EDyZh0lcktjMAPmRxUwTWg?=
 =?us-ascii?Q?uF7WaLT414UuERsoWUiOcuzTtguXjkVZY9DX+GTrx3HCtiYBoGMy2jc0acDs?=
 =?us-ascii?Q?hifUf1cjpBYQbtZmRCTmNn/NEigsEck1SZ/bmEsxq6PrSeD7Ovb3lNyT0gi0?=
 =?us-ascii?Q?R5B+lHi6QnAWNCJxvZZSzSKucoolb69O/gNLZ7QF66Qy19eCS4q6E5ieLD1r?=
 =?us-ascii?Q?hrs5cYDpMJiLgNApXAyDP5nTjnw+oenXklOBe0rz304LuY6lcwtQ+441VAiT?=
 =?us-ascii?Q?NW+0iJorDfytvy0YPUjIEaFayHTJmvn3T5tnGTRbbENJm8d+YgsmhBH/+1kx?=
 =?us-ascii?Q?hAXtys8iMis4c1L8P5mfHo7kU5xLTSj0lRhVXLGMsKAnVET/2hVjRrYemkoL?=
 =?us-ascii?Q?2rzvAgItgd4MSyEH8LK/ZqLrWvGDU6O/rM4wEYGGsUH9S2snY6zW+L+YACNp?=
 =?us-ascii?Q?0+NJ7IIeIBlAV69Ut+WlCkbzGIQcu/ukXPjzdN6Adn3m2yCcxb9jUyos3enE?=
 =?us-ascii?Q?Nmxh6DudHxjKkX1QuvRat6h7KA9ET1rAH0yXVDSFDsid0kuEnEeZjOLNsCrt?=
 =?us-ascii?Q?qxpoVC4voiBuN3JpYuswLZ0fqMU4taJ0qCcQgHjKjSiM25+HAACj/ZHONcN/?=
 =?us-ascii?Q?V0BEUxZGLovV9OxW5YiM9MZGygMr8x6eRInBX96TEo2GBwlh/1/5a/1mjlbX?=
 =?us-ascii?Q?hAf7iALDlNRpc1faKsZBUKnLM25hBI+sd1f75CTSgawun4iluk5lNBYusSFi?=
 =?us-ascii?Q?UAj86OvjyTJ+n96WUdwNBl407RAgMI+vJ8J0ZsDGt3Ak5DV8Y1Sc0lWDm15Y?=
 =?us-ascii?Q?dNzS2d88OwkyVF4Y4x+fzVw5QHlLAwsMwZ4Xs3TlIBGM1mFPpn13cOb1SMwx?=
 =?us-ascii?Q?eWqxiLI/rvmQi6/U/fT+4Kl9FikVIQz85sEDSusSRcmPkdh+phb61Aq1ANVV?=
 =?us-ascii?Q?XU41MB4x7FCb83UbNLBf5mhSYwtI0nrPsQxf54ILtLbYeameMqSTw1XRHPHK?=
 =?us-ascii?Q?KY/4JMldrsnj1qhRpC4vUArR06qTwxbs7aOWlc6uVgQUen9C4DB9kQIT+6An?=
 =?us-ascii?Q?QS943vwuEEyHpqo9eo+9PXbNZ8B0eswnO6GlLEk5I6Fb8CLul3/aVFMM0N8k?=
 =?us-ascii?Q?aSIB8pi/A5xPN1V9ZYPli7n7k6wB3pm4MuGngQ0kaVG/tKHYvxFucugUNOc5?=
 =?us-ascii?Q?Goz6BXj2PFw8hRWCBCQgokFHM/crrGGMQTTUYxFwdDV/2fr2N3/FZoQEyoQE?=
 =?us-ascii?Q?dbYm6F3VT5unkOQs5ZcIbKDVUQdMwn+F9j0uo2CGA/J9VoBMCKRqHDzLEL6h?=
 =?us-ascii?Q?+yG4naRulgyzNWJeJhl7M0nr4dRaiFhdpm6+rN7OAes64e5cruRl1opVxiKo?=
 =?us-ascii?Q?zIH2FwKv7mN25EzxZTgJi1pqbfKRJX27Ct9K/PvXijqmGOL2u2FOy7sV7+U/?=
 =?us-ascii?Q?2Cu+Hu6AEmjW6wyLCPVI2eAg87fEGZ00ADZS3hz652vCCcNUFSxxNlqJPcCL?=
 =?us-ascii?Q?OFwGfhoN2neuUR7VtHRcDeU=3D?=
X-OriginatorOrg: chipsnmedia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25069910-1368-47a6-d792-08dc41b9e8be
X-MS-Exchange-CrossTenant-AuthSource: SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 10:56:31.0502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4d70c8e9-142b-4389-b7f2-fa8a3c68c467
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ntfbn6T7Uh6+o7UMA/IR00I6QPt/hSWpav6anELbHB8kawt139kjQ+Nfsa4adcpfRQLjuD8gUcQduAj/cAFTqb7S+EAddJki2MR9uoiL7aA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE1P216MB2024

From: "Jackson.lee" <jackson.lee@chipsnmedia.com>

For saving a power resource, we support runtime suspend/resume for an encoder/decoder.
So our vpu module's power turns on only if an encoder/decoder is used.

Signed-off-by: Jackson.lee <jackson.lee@chipsnmedia.com>
Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>
---
 .../platform/chips-media/wave5/wave5-hw.c     |  4 +-
 .../chips-media/wave5/wave5-vpu-dec.c         | 16 ++++++-
 .../chips-media/wave5/wave5-vpu-enc.c         | 15 +++++++
 .../platform/chips-media/wave5/wave5-vpu.c    | 43 +++++++++++++++++++
 .../platform/chips-media/wave5/wave5-vpuapi.c | 14 ++++--
 .../media/platform/chips-media/wave5/wave5.h  |  3 ++
 6 files changed, 88 insertions(+), 7 deletions(-)

diff --git a/drivers/media/platform/chips-media/wave5/wave5-hw.c b/drivers/media/platform/chips-media/wave5/wave5-hw.c
index 4a262822bf17..826b92b7b582 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-hw.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-hw.c
@@ -1084,8 +1084,8 @@ int wave5_vpu_re_init(struct device *dev, u8 *fw, size_t size)
 	return setup_wave5_properties(dev);
 }
 
-static int wave5_vpu_sleep_wake(struct device *dev, bool i_sleep_wake, const uint16_t *code,
-				size_t size)
+int wave5_vpu_sleep_wake(struct device *dev, bool i_sleep_wake, const uint16_t *code,
+			 size_t size)
 {
 	u32 reg_val;
 	struct vpu_buf *common_vb;
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
index ef227af72348..a199877c643b 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2021-2023 CHIPS&MEDIA INC
  */
 
+#include <linux/pm_runtime.h>
 #include "wave5-helper.h"
 
 #define VPU_DEC_DEV_NAME "C&M Wave5 VPU decoder"
@@ -518,6 +519,8 @@ static void wave5_vpu_dec_finish_decode(struct vpu_instance *inst)
 	if (q_status.report_queue_count == 0 &&
 	    (q_status.instance_queue_count == 0 || dec_info.sequence_changed)) {
 		dev_dbg(inst->dev->dev, "%s: finishing job.\n", __func__);
+		pm_runtime_mark_last_busy(inst->dev->dev);
+		pm_runtime_put_autosuspend(inst->dev->dev);
 		v4l2_m2m_job_finish(inst->v4l2_m2m_dev, m2m_ctx);
 	}
 }
@@ -1382,6 +1385,7 @@ static int wave5_vpu_dec_start_streaming(struct vb2_queue *q, unsigned int count
 	int ret = 0;
 
 	dev_dbg(inst->dev->dev, "%s: type: %u\n", __func__, q->type);
+	pm_runtime_resume_and_get(inst->dev->dev);
 
 	v4l2_m2m_update_start_streaming_state(m2m_ctx, q);
 
@@ -1425,13 +1429,15 @@ static int wave5_vpu_dec_start_streaming(struct vb2_queue *q, unsigned int count
 			}
 		}
 	}
-
+	pm_runtime_mark_last_busy(inst->dev->dev);
+	pm_runtime_put_autosuspend(inst->dev->dev);
 	return ret;
 
 free_bitstream_vbuf:
 	wave5_vdi_free_dma_memory(inst->dev, &inst->bitstream_vbuf);
 return_buffers:
 	wave5_return_bufs(q, VB2_BUF_STATE_QUEUED);
+	pm_runtime_put_autosuspend(inst->dev->dev);
 	return ret;
 }
 
@@ -1517,6 +1523,7 @@ static void wave5_vpu_dec_stop_streaming(struct vb2_queue *q)
 	bool check_cmd = TRUE;
 
 	dev_dbg(inst->dev->dev, "%s: type: %u\n", __func__, q->type);
+	pm_runtime_resume_and_get(inst->dev->dev);
 
 	while (check_cmd) {
 		struct queue_status_info q_status;
@@ -1540,6 +1547,9 @@ static void wave5_vpu_dec_stop_streaming(struct vb2_queue *q)
 		streamoff_output(q);
 	else
 		streamoff_capture(q);
+
+	pm_runtime_mark_last_busy(inst->dev->dev);
+	pm_runtime_put_autosuspend(inst->dev->dev);
 }
 
 static const struct vb2_ops wave5_vpu_dec_vb2_ops = {
@@ -1626,7 +1636,7 @@ static void wave5_vpu_dec_device_run(void *priv)
 	int ret = 0;
 
 	dev_dbg(inst->dev->dev, "%s: Fill the ring buffer with new bitstream data", __func__);
-
+	pm_runtime_resume_and_get(inst->dev->dev);
 	ret = fill_ringbuffer(inst);
 	if (ret) {
 		dev_warn(inst->dev->dev, "Filling ring buffer failed\n");
@@ -1709,6 +1719,8 @@ static void wave5_vpu_dec_device_run(void *priv)
 
 finish_job_and_return:
 	dev_dbg(inst->dev->dev, "%s: leave and finish job", __func__);
+	pm_runtime_mark_last_busy(inst->dev->dev);
+	pm_runtime_put_autosuspend(inst->dev->dev);
 	v4l2_m2m_job_finish(inst->v4l2_m2m_dev, m2m_ctx);
 }
 
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
index f04baa93a9b7..013e2bb37fbb 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2021-2023 CHIPS&MEDIA INC
  */
 
+#include <linux/pm_runtime.h>
 #include "wave5-helper.h"
 
 #define VPU_ENC_DEV_NAME "C&M Wave5 VPU encoder"
@@ -1310,6 +1311,7 @@ static int wave5_vpu_enc_start_streaming(struct vb2_queue *q, unsigned int count
 	struct v4l2_m2m_ctx *m2m_ctx = inst->v4l2_fh.m2m_ctx;
 	int ret = 0;
 
+	pm_runtime_resume_and_get(inst->dev->dev);
 	v4l2_m2m_update_start_streaming_state(m2m_ctx, q);
 
 	if (inst->state == VPU_INST_STATE_NONE && q->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) {
@@ -1364,9 +1366,13 @@ static int wave5_vpu_enc_start_streaming(struct vb2_queue *q, unsigned int count
 	if (ret)
 		goto return_buffers;
 
+	pm_runtime_mark_last_busy(inst->dev->dev);
+	pm_runtime_put_autosuspend(inst->dev->dev);
 	return 0;
 return_buffers:
 	wave5_return_bufs(q, VB2_BUF_STATE_QUEUED);
+	pm_runtime_mark_last_busy(inst->dev->dev);
+	pm_runtime_put_autosuspend(inst->dev->dev);
 	return ret;
 }
 
@@ -1408,6 +1414,7 @@ static void wave5_vpu_enc_stop_streaming(struct vb2_queue *q)
 	 */
 
 	dev_dbg(inst->dev->dev, "%s: type: %u\n", __func__, q->type);
+	pm_runtime_resume_and_get(inst->dev->dev);
 
 	if (wave5_vpu_both_queues_are_streaming(inst))
 		switch_state(inst, VPU_INST_STATE_STOP);
@@ -1432,6 +1439,9 @@ static void wave5_vpu_enc_stop_streaming(struct vb2_queue *q)
 		streamoff_output(inst, q);
 	else
 		streamoff_capture(inst, q);
+
+	pm_runtime_mark_last_busy(inst->dev->dev);
+	pm_runtime_put_autosuspend(inst->dev->dev);
 }
 
 static const struct vb2_ops wave5_vpu_enc_vb2_ops = {
@@ -1478,6 +1488,7 @@ static void wave5_vpu_enc_device_run(void *priv)
 	u32 fail_res = 0;
 	int ret = 0;
 
+	pm_runtime_resume_and_get(inst->dev->dev);
 	switch (inst->state) {
 	case VPU_INST_STATE_PIC_RUN:
 		ret = start_encode(inst, &fail_res);
@@ -1491,6 +1502,8 @@ static void wave5_vpu_enc_device_run(void *priv)
 			break;
 		}
 		dev_dbg(inst->dev->dev, "%s: leave with active job", __func__);
+		pm_runtime_mark_last_busy(inst->dev->dev);
+		pm_runtime_put_autosuspend(inst->dev->dev);
 		return;
 	default:
 		WARN(1, "Execution of a job in state %s is invalid.\n",
@@ -1498,6 +1511,8 @@ static void wave5_vpu_enc_device_run(void *priv)
 		break;
 	}
 	dev_dbg(inst->dev->dev, "%s: leave and finish job", __func__);
+	pm_runtime_mark_last_busy(inst->dev->dev);
+	pm_runtime_put_autosuspend(inst->dev->dev);
 	v4l2_m2m_job_finish(inst->v4l2_m2m_dev, m2m_ctx);
 }
 
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu.c b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
index 0d90b5820bef..8e08461b3515 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
@@ -10,6 +10,7 @@
 #include <linux/clk.h>
 #include <linux/firmware.h>
 #include <linux/interrupt.h>
+#include <linux/pm_runtime.h>
 #include "wave5-vpu.h"
 #include "wave5-regdefine.h"
 #include "wave5-vpuconfig.h"
@@ -117,6 +118,38 @@ static int wave5_vpu_load_firmware(struct device *dev, const char *fw_name,
 	return 0;
 }
 
+static int wave5_pm_suspend(struct device *dev)
+{
+	struct vpu_device *vpu = dev_get_drvdata(dev);
+
+	if (pm_runtime_suspended(dev))
+		return 0;
+
+	wave5_vpu_sleep_wake(dev, true, NULL, 0);
+	clk_bulk_disable_unprepare(vpu->num_clks, vpu->clks);
+
+	return 0;
+}
+
+static int wave5_pm_resume(struct device *dev)
+{
+	struct vpu_device *vpu = dev_get_drvdata(dev);
+	int ret = 0;
+
+	wave5_vpu_sleep_wake(dev, false, NULL, 0);
+	ret = clk_bulk_prepare_enable(vpu->num_clks, vpu->clks);
+	if (ret) {
+		dev_err(dev, "Enabling clocks, fail: %d\n", ret);
+		return ret;
+	}
+
+	return ret;
+}
+
+static const struct dev_pm_ops wave5_pm_ops = {
+	SET_RUNTIME_PM_OPS(wave5_pm_suspend, wave5_pm_resume, NULL)
+};
+
 static int wave5_vpu_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -232,6 +265,12 @@ static int wave5_vpu_probe(struct platform_device *pdev)
 		 (match_data->flags & WAVE5_IS_DEC) ? "'DECODE'" : "");
 	dev_info(&pdev->dev, "Product Code:      0x%x\n", dev->product_code);
 	dev_info(&pdev->dev, "Firmware Revision: %u\n", fw_revision);
+
+	pm_runtime_set_autosuspend_delay(&pdev->dev, 5000);
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+	wave5_vpu_sleep_wake(&pdev->dev, true, NULL, 0);
+
 	return 0;
 
 err_enc_unreg:
@@ -254,6 +293,9 @@ static int wave5_vpu_remove(struct platform_device *pdev)
 {
 	struct vpu_device *dev = dev_get_drvdata(&pdev->dev);
 
+	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+
 	mutex_destroy(&dev->dev_lock);
 	mutex_destroy(&dev->hw_lock);
 	clk_bulk_disable_unprepare(dev->num_clks, dev->clks);
@@ -281,6 +323,7 @@ static struct platform_driver wave5_vpu_driver = {
 	.driver = {
 		.name = VPU_PLATFORM_DEVICE_NAME,
 		.of_match_table = of_match_ptr(wave5_dt_ids),
+		.pm = &wave5_pm_ops,
 		},
 	.probe = wave5_vpu_probe,
 	.remove = wave5_vpu_remove,
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c
index 1a3efb638dde..b0911fef232f 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c
@@ -6,6 +6,8 @@
  */
 
 #include <linux/bug.h>
+#include <linux/pm_runtime.h>
+#include <linux/delay.h>
 #include "wave5-vpuapi.h"
 #include "wave5-regdefine.h"
 #include "wave5.h"
@@ -200,9 +202,13 @@ int wave5_vpu_dec_close(struct vpu_instance *inst, u32 *fail_res)
 	if (!inst->codec_info)
 		return -EINVAL;
 
+	pm_runtime_resume_and_get(inst->dev->dev);
+
 	ret = mutex_lock_interruptible(&vpu_dev->hw_lock);
-	if (ret)
+	if (ret) {
+		pm_runtime_put_sync(inst->dev->dev);
 		return ret;
+	}
 
 	do {
 		ret = wave5_vpu_dec_finish_seq(inst, fail_res);
@@ -234,7 +240,7 @@ int wave5_vpu_dec_close(struct vpu_instance *inst, u32 *fail_res)
 
 unlock_and_return:
 	mutex_unlock(&vpu_dev->hw_lock);
-
+	pm_runtime_put_sync(inst->dev->dev);
 	return ret;
 }
 
@@ -702,6 +708,8 @@ int wave5_vpu_enc_close(struct vpu_instance *inst, u32 *fail_res)
 	if (!inst->codec_info)
 		return -EINVAL;
 
+	pm_runtime_resume_and_get(inst->dev->dev);
+
 	ret = mutex_lock_interruptible(&vpu_dev->hw_lock);
 	if (ret)
 		return ret;
@@ -733,9 +741,9 @@ int wave5_vpu_enc_close(struct vpu_instance *inst, u32 *fail_res)
 	}
 
 	wave5_vdi_free_dma_memory(vpu_dev, &p_enc_info->vb_task);
-
 	mutex_unlock(&vpu_dev->hw_lock);
 
+	pm_runtime_put_sync(inst->dev->dev);
 	return 0;
 }
 
diff --git a/drivers/media/platform/chips-media/wave5/wave5.h b/drivers/media/platform/chips-media/wave5/wave5.h
index 063028eccd3b..6125eff938a8 100644
--- a/drivers/media/platform/chips-media/wave5/wave5.h
+++ b/drivers/media/platform/chips-media/wave5/wave5.h
@@ -56,6 +56,9 @@ int wave5_vpu_get_version(struct vpu_device *vpu_dev, u32 *revision);
 
 int wave5_vpu_init(struct device *dev, u8 *fw, size_t size);
 
+int wave5_vpu_sleep_wake(struct device *dev, bool i_sleep_wake, const uint16_t *code,
+			 size_t size);
+
 int wave5_vpu_reset(struct device *dev, enum sw_reset_mode reset_mode);
 
 int wave5_vpu_build_up_dec_param(struct vpu_instance *inst, struct dec_open_param *param);
-- 
2.43.0



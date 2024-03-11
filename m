Return-Path: <linux-kernel+bounces-98727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C07877E75
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 11:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EF0E1F21961
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B37F39AFA;
	Mon, 11 Mar 2024 10:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b="N0StllYb"
Received: from SE2P216CU007.outbound.protection.outlook.com (mail-koreacentralazon11020002.outbound.protection.outlook.com [52.101.154.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB2C37169;
	Mon, 11 Mar 2024 10:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.154.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710154599; cv=fail; b=VfQvRfscrCn+WBslRD7wckPkme7z+TdTq3JPnI6BpHHtH7OfMXpJcmf5gEF9VjCPuZQwOxas15FSuygGGyslzVv42NUzL4jo4KyAVbXTiV/zvI3bV0epY8A7iNMFEp07pg6eUWIX2xxaS24Sk/syZ8ZRtoqTTGSn53SxssBwMgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710154599; c=relaxed/simple;
	bh=l2wUCmHDK8MzOelGsKM+UYRm9Vter11l6pl5SdW3fx0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I1AFrGVVWctW2G5s6oXLgY4KW/VsPG+N+YRy0q51nQxfH3Vn+xL+SIMrjhHghVDUmvvd4082DLQ/q2FP53Q5kTa98t7KjsTwO/To0znFx/eQNDjI99d+H0KQzHV2HAVujOcSAbtIGgTC45iGpW1KlR7ngcuDaGAtI7uvO7zpS0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com; spf=pass smtp.mailfrom=chipsnmedia.com; dkim=pass (1024-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b=N0StllYb; arc=fail smtp.client-ip=52.101.154.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chipsnmedia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rc9CfVBCmg6iA7pm2NdTZvs8rT4Q7YWOAyroUm192e1GDbYu0G7u1TDngGmEpeKXjObGaGal//RT4TQkZ2Xn+tnx5CH1nlLGmsx/TSikS0upIswNfEkB152N6QyUkB72vQ14qWHUBwVxZKT+0XSLZgYRHIZnQWmMpVDp2l29xTH8lVCp5dAITb8cQyvAUgu48lHHHf3jRIGR6Osvtgv6qnay5WOpAufO+2TZwBMciUeJSXNyEiBgi2gB6BqGGKvWogUegfeZ3nCccoYrrEU1WBY5Q/3DYaOw3m9NlnSjuxQncGN3KiLU9Q+8r86rcWHk/6UM/DtqdU7ZbMF6xeBAIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rLpqCFd9QlagKVmdqGgrlC5upXeqJ3Sr5cHld6DJd6E=;
 b=Do7ZWhN3BQwkB+L10VDceYMnVrD5sQeIYfFFy0ZQfMYOtKx4ZeLpnV421dIUAYkVcJTCH1htq+3q2kXqU6t3wRMNV+tiO98BVuYfEwV4E57TPIF2rN/ZmsL5No2KUITJPuRUWhLXnpXVaTzxxgF8N7g+QUR4+U6M6rhRxJaBXA9/qFo50bIQRzSpO4yJ01MDSkVD9CZoxSSU6bn8NBebuPc/R+f8NvEibc8mg19D8tARL6rHFbJPEls3nChgytSH0SfOV2iOQWRXdnfc6FIPObJZfIFcHtVrMyCgGs/pKu818ldUfZSi4BxXOiMKFHoY+30Hlis+I7BjwoIWJV74pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chipsnmedia.com; dmarc=pass action=none
 header.from=chipsnmedia.com; dkim=pass header.d=chipsnmedia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chipsnmedia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rLpqCFd9QlagKVmdqGgrlC5upXeqJ3Sr5cHld6DJd6E=;
 b=N0StllYbrYQSE41UPjOCVrkuXr7xZqk2CwjaYcPzruZIfgaAu+b7iMFjbx7kEx4kb9W968t506qw1bHjDdFxevY1k5o3RO3BtJpRENojAFre+uvAqnKHUgyUKJG2qbvX4XI2bFCKlLcoSOZMs9/rnLTaIeE9Mj/DcW2kWQkEaWI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=chipsnmedia.com;
Received: from SE1P216MB1303.KORP216.PROD.OUTLOOK.COM (2603:1096:101:15::5) by
 SE1P216MB2024.KORP216.PROD.OUTLOOK.COM (2603:1096:101:15b::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.36; Mon, 11 Mar 2024 10:56:31 +0000
Received: from SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
 ([fe80::ebb8:2043:fd53:303a]) by SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
 ([fe80::ebb8:2043:fd53:303a%3]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 10:56:30 +0000
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
Subject: [RESEND PATCH v2 1/4] media: chips-media: wave5: Support SPS/PPS generation for each IDR
Date: Mon, 11 Mar 2024 19:56:20 +0900
Message-Id: <20240311105623.20406-2-jackson.lee@chipsnmedia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4d2fb6ac-2fd6-4300-d1ed-08dc41b9e896
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rmq3OwIEJm8WTwuRSfrHgQFCxAncYeHYranuCx0Jr0PwpKx1RL5vwLpZRE9+mPHUYkivTXDrjlBxx+gA2zeNrLRFCwLZCpfJJzea905eIZr4CFyohwC9l0y5RVT10a8yAk8+phBV5MHp5sof+gKtoIQ2jBSGh8RmYMDLVlkEtUekGnz8KVFu8Ge54aDxWOlZ5WAeSbqaL/qNx3j9mwCROhcsWAqE1dKttbge5l5ebGV4CA6ia7/VncQdRg8a7inZ5ayUIzjt5jGI5iTiDDJ0ePwwo6yBLjU9YwtMdK7Nu6XRFhUiqNwmqgOE+iMyYS7cS4i3WopjZhlNGiqx6/h985PgRifyWXzBwjcWOlT9M02Vc8y+HHzGyoczxmbGXuRex38txKRC77z/Ee4EtLx1FwjRGvCMizwSUIwm3qssdHePdyTAnb4Ynkq4FNEvbbP6R8tY37jQdwkJRy6qAYqO3XuOEFC+o1/ajDCH0xcPdam1nk/Y/tfTSfsiJhnbG6U663ViDSW+eX5CAf3MKC0bN8uiOr9lvtpK90Np4WDPoG6Tuc88wbKEJzAy0HWYpqYnEaGClDKP0tFptyHF76Nnsvqdy6i3qbYshNRCoyyO8kGaUGePXnCIgD+3+9h14a4d96g6v9QkGIfBUES3eZGlMsM+yxhoMGoUpPYWc4cxSmjDYEE1EKKMJbBtupKcc6FKtx1ZeY/APzOPgHmg0OtQedimJOfBjPWVgPyNc8hoM78=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE1P216MB1303.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ek4IxOMPARtVagvrttkXy1CO7EtTChuP00gaLP/nBdJtmimEHXMOy7fdgXHK?=
 =?us-ascii?Q?eV0iXxrW5sK7C7J+f2P9aHevKTo4idKh2W7exgY4bGGPSLUTyb9xFMq2rQ8g?=
 =?us-ascii?Q?Kof4LuA5tMuTbcJCiCHW2ojtaq7od+Lz82+P5bIGUNZakY+tQVN/71ZvF6G4?=
 =?us-ascii?Q?vib2UzWU7sX3E6aSXM4Bh2dJ0vOrv8vnb0FUoq8Jpp69QIrnoEhtZCwuuQM1?=
 =?us-ascii?Q?WHkTRWJrQkdQiBgGKNAxNEXdiHnHuZ9iX0mCsK15eCeYCQohEK7bplR12zAX?=
 =?us-ascii?Q?zIXSf0lXJrJqHXfP3l50tZCFrss3rjq34bzP8ygRAc7QVHe98e+pZ4IdhUh8?=
 =?us-ascii?Q?lUsaYhUHjRU2u4sSe0j6/Hn2xcpZHjot4tkPB3qZgysxdq62bQx0IlTr1biA?=
 =?us-ascii?Q?keYYb1FvcNno5cgIHuHXD6kcFk4yD10y2Cqi/wrpXhjzlkoEDwhbkO7PVciY?=
 =?us-ascii?Q?fs/hQDDbsvuUEZ/vBTuap31DKxWFifFsIhpp0jLlSCDiT9ZUNT9DKw96HU8+?=
 =?us-ascii?Q?wxerkEiPtGicS/frFjQ3oZtrbefNxTQsqyKHDg2mFZ5ffTIsvl7fxfqytzYx?=
 =?us-ascii?Q?A4aVwyOVkNa0dY5zVhA/8seKqzNJPA3zbaNF9BfHlGtj2c9tPBKbHVcnekjM?=
 =?us-ascii?Q?axBTLeXY//owWfebiSnLygTuVKfhAqaXLGGBk7a0PUqVlHeUl7QmJnW1QYv/?=
 =?us-ascii?Q?ED032XrXj2bRhQeYy4XZuD7jmqprB0IKk+jik1ad6Djp3FjADqcBTmk6RwpU?=
 =?us-ascii?Q?41RuNElm3qMgGMffO6SV+aLauFleMZWcqbaoVxsGWVHlIGvOWKKmhSwov5xk?=
 =?us-ascii?Q?qD0yDm1baXEtPFpmgpgk735uGbisjavVUOUDPJUG1VWjq4Gnh4ZG+pzCIbC0?=
 =?us-ascii?Q?GjgMZN8Mkg+XQda09fGEJu4hbq8vkYBaenxz/nrw+BXB2NawAkfctjpD0i/N?=
 =?us-ascii?Q?46aHlm3XlXlo8psXtWv4IJSCvRHKo8MURikmz68s1V2NjxkSzGj9iVww+Y6g?=
 =?us-ascii?Q?5cdhYe3Bbw1niYKqsTdtB4Xfq+lZ+WHSdeVI96RZJdyAiIOKGSnOtfOfjQ+/?=
 =?us-ascii?Q?lr1CE72HH4tbX+4BQvOyhaBlrPg+Lw+DRZsbQ/SjWg5AgcaArJU7+BQr2pQ0?=
 =?us-ascii?Q?wqB1dAuh6HbJk+3DZZmm+G0Pyfa125Z3eXE0gD9SxE7J1ggPg5DLZNloIOYN?=
 =?us-ascii?Q?WJ37BiremuHz6vd7xivpz1HlrF3umpSAEJv9fPOf5vVW7pqwiABt+bl8vSZW?=
 =?us-ascii?Q?Aga/tIIj8u5mZNPZMsacRxoklt8tt6yUQgNL8gMpNFvV3Oydz5oAYiq/6OTt?=
 =?us-ascii?Q?QiNze5EGK2qPVI6ikNm8H8boimpIE96IWsSBjFjCKPorbeFUfG1CsyFrZdux?=
 =?us-ascii?Q?B1xt0UPJFYZFAlcthAIxS1N+QwkBDpmddgWlRjw8a3iuRtZotbnCdRQ2ZexS?=
 =?us-ascii?Q?8GHTIRE8+nfOGfgkNiA5K90D43ifvzYPzcE+i0WGbX4MsHDpuY/iBaVgCuLM?=
 =?us-ascii?Q?dlylKRYP0FUiTORb+yJO2u3Sk3RTaOsE4a3J/Xs0N88Kz0vKpz/7PE6sGw9T?=
 =?us-ascii?Q?KwLnhBnN5XEe8WcPp3V8m1SmpfsIQj+IqWCPDTA+B1YcdMSVnatryQXN7mE9?=
 =?us-ascii?Q?BGAUtVVe/o/ScPzofn+03m0=3D?=
X-OriginatorOrg: chipsnmedia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d2fb6ac-2fd6-4300-d1ed-08dc41b9e896
X-MS-Exchange-CrossTenant-AuthSource: SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 10:56:30.7800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4d70c8e9-142b-4389-b7f2-fa8a3c68c467
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tdklFd38tZ3s1CVgpOygb0QHHJDseD7F2AHqO2tregj/vesMdt9jTMEMyRLsnCFyYholKHniM5sRa2dAC1hQ+/efx45kly0tH+zYmshWBQE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE1P216MB2024

From: "Jackson.lee" <jackson.lee@chipsnmedia.com>

Provide a control to toggle (0 = off / 1 = on), whether the SPS and
PPS are generated for every IDR.

Signed-off-by: Jackson.lee <jackson.lee@chipsnmedia.com>
Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>
---
 .../platform/chips-media/wave5/wave5-hw.c     | 19 +++++++++++++++----
 .../chips-media/wave5/wave5-vpu-enc.c         |  7 +++++++
 .../platform/chips-media/wave5/wave5-vpuapi.h |  1 +
 3 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/chips-media/wave5/wave5-hw.c b/drivers/media/platform/chips-media/wave5/wave5-hw.c
index f1e022fb148e..4a262822bf17 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-hw.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-hw.c
@@ -23,6 +23,15 @@
 #define FEATURE_AVC_ENCODER		BIT(1)
 #define FEATURE_HEVC_ENCODER		BIT(0)
 
+#define ENC_AVC_INTRA_IDR_PARAM_MASK	0x7ff
+#define ENC_AVC_INTRA_PERIOD		6
+#define ENC_AVC_IDR_PERIOD		17
+#define ENC_AVC_FORCED_IDR_HEADER	28
+
+#define ENC_HEVC_INTRA_QP		3
+#define ENC_HEVC_FORCED_IDR_HEADER	9
+#define ENC_HEVC_INTRA_PERIOD		16
+
 /* Decoder support fields */
 #define FEATURE_AVC_DECODER		BIT(3)
 #define FEATURE_HEVC_DECODER		BIT(2)
@@ -1601,12 +1610,14 @@ int wave5_vpu_enc_init_seq(struct vpu_instance *inst)
 
 	if (inst->std == W_AVC_ENC)
 		vpu_write_reg(inst->dev, W5_CMD_ENC_SEQ_INTRA_PARAM, p_param->intra_qp |
-				((p_param->intra_period & 0x7ff) << 6) |
-				((p_param->avc_idr_period & 0x7ff) << 17));
+				((p_param->intra_period & ENC_AVC_INTRA_IDR_PARAM_MASK) << ENC_AVC_INTRA_PERIOD) |
+				((p_param->avc_idr_period & ENC_AVC_INTRA_IDR_PARAM_MASK) << ENC_AVC_IDR_PERIOD) |
+				(p_param->forced_idr_header_enable << ENC_AVC_FORCED_IDR_HEADER));
 	else if (inst->std == W_HEVC_ENC)
 		vpu_write_reg(inst->dev, W5_CMD_ENC_SEQ_INTRA_PARAM,
-			      p_param->decoding_refresh_type | (p_param->intra_qp << 3) |
-				(p_param->intra_period << 16));
+			      p_param->decoding_refresh_type | (p_param->intra_qp << ENC_HEVC_INTRA_QP) |
+			      (p_param->forced_idr_header_enable << ENC_HEVC_FORCED_IDR_HEADER) |
+			      (p_param->intra_period << ENC_HEVC_INTRA_PERIOD));
 
 	reg_val = (p_param->rdo_skip << 2) |
 		(p_param->lambda_scaling_enable << 3) |
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
index f29cfa3af94a..f04baa93a9b7 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
@@ -1061,6 +1061,9 @@ static int wave5_vpu_enc_s_ctrl(struct v4l2_ctrl *ctrl)
 	case V4L2_CID_MPEG_VIDEO_H264_ENTROPY_MODE:
 		inst->enc_param.entropy_coding_mode = ctrl->val;
 		break;
+	case V4L2_CID_MPEG_VIDEO_PREPEND_SPSPPS_TO_IDR:
+		inst->enc_param.forced_idr_header_enable = ctrl->val;
+		break;
 	case V4L2_CID_MIN_BUFFERS_FOR_OUTPUT:
 		break;
 	default:
@@ -1219,6 +1222,7 @@ static void wave5_set_enc_openparam(struct enc_open_param *open_param,
 		else
 			open_param->wave_param.intra_refresh_arg = num_ctu_row;
 	}
+	open_param->wave_param.forced_idr_header_enable = input.forced_idr_header_enable;
 }
 
 static int initialize_sequence(struct vpu_instance *inst)
@@ -1702,6 +1706,9 @@ static int wave5_vpu_open_enc(struct file *filp)
 			  0, 1, 1, 0);
 	v4l2_ctrl_new_std(v4l2_ctrl_hdl, &wave5_vpu_enc_ctrl_ops,
 			  V4L2_CID_MIN_BUFFERS_FOR_OUTPUT, 1, 32, 1, 1);
+	v4l2_ctrl_new_std(v4l2_ctrl_hdl, &wave5_vpu_enc_ctrl_ops,
+			  V4L2_CID_MPEG_VIDEO_PREPEND_SPSPPS_TO_IDR,
+			  0, 1, 1, 0);
 
 	if (v4l2_ctrl_hdl->error) {
 		ret = -ENODEV;
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
index 352f6e904e50..3ad6118550ac 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
@@ -566,6 +566,7 @@ struct enc_wave_param {
 	u32 lambda_scaling_enable: 1; /* enable lambda scaling using custom GOP */
 	u32 transform8x8_enable: 1; /* enable 8x8 intra prediction and 8x8 transform */
 	u32 mb_level_rc_enable: 1; /* enable MB-level rate control */
+	u32 forced_idr_header_enable: 1; /* enable header encoding before IDR frame */
 };
 
 struct enc_open_param {
-- 
2.43.0



Return-Path: <linux-kernel+bounces-45589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6988432C2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 02:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEB511F22628
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 01:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFCC5672;
	Wed, 31 Jan 2024 01:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chipsnmedia.onmicrosoft.com header.i=@chipsnmedia.onmicrosoft.com header.b="iFx8xWxI"
Received: from KOR01-SL2-obe.outbound.protection.outlook.com (mail-sl2kor01on2119.outbound.protection.outlook.com [40.107.129.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FC41879;
	Wed, 31 Jan 2024 01:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.129.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706664663; cv=fail; b=auXbSVWT7J0GKQmW4iZFTon4O3iBuOCcemd/4/amxhSy6T4U5bCSgG8Dbg7CEZdqTR/Pr+bK8aWBpDymshEumTSmmMgB3cFbFDbAfTxP2TGheQfaQOFC90iAgQRZCtRonp3tZcA3jEsDIYVhsdrGOnz5Qx+PNU7mRTc3lvoQmb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706664663; c=relaxed/simple;
	bh=X0yfwrshsp8er0k1tHV5dMdkLO32f9I0607hnZSGlLo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rR8E5WyKkWtzEDUNm+sU6x/BIEN15WJ14wgb4zwqyFK2agHSQuABVF7j9u1WjL5jSD87OeDxpOlNEH5BuouLehqXm1nl5Sccjn3ruy2nx1tpJY6YwcDTKlb1Kvqmlz+f4W5OgtQ/zeREPrmLQ3ZzvEJB4d3RP6kRR1ZPbN2AG6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com; spf=pass smtp.mailfrom=chipsnmedia.com; dkim=pass (1024-bit key) header.d=chipsnmedia.onmicrosoft.com header.i=@chipsnmedia.onmicrosoft.com header.b=iFx8xWxI; arc=fail smtp.client-ip=40.107.129.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chipsnmedia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fEWx3CMLP2bDQ/YrMcv6Jq9NZiHE0/t7yez2oH53870rluIPI9yoIrp1DKmV82QJICJ3eJiGWYojfb5xiiD00aaZaWRfbnGcLoztgQ9EkfHwkc7tyZcC+VA9sakSCDAz07SDUBtE15F6NAlDs/BYnB+SKoojWAn8GXl2gU4coMPNosEzRy9eevifavgydnGSXYNgl4tbR5eqBiKfmOPh6IYhbbeAlrwGrKAmtq+4ThQcLLvl6EseGhmdcC15/s2yepmoY1DXqK1YNjMqbqeuNSmfhgpK6RF/kQof9HQB8n+Kr0zrc6bSqazrnog0PailHEJgVTcT6JVZidt8cQUCXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8utOFXxbLDEr2TD58UTmf2jV6OeoYkStHv59ULoeMxs=;
 b=kmjPDjb8f9y4Fm3sXWjr8V235MHPFP8GrcVFe5BxIvYG8P4k2DGwlmY81ejQrUCl13omHOWQe+V7WdrNVGK85F82MGYlWAf+WXxI9f01jL0g3oGaiye+BPIH7AILQfywSnFw9/LA5cns5UwxrjvdxVM8iAAw4ldwuomF/hppCrjtkeZrITrKay0/k+8CbzH25owCM+A3J1vdS0IXDSiTXaey9HHOswctOxN0+6JB7z9fhKeOBvC7J6BikuH0URDsRNlmgjETjwib/vX4gDPNxPLnOasg97fY+jHjDo0ai1WkuiJRDj5PlYcumo7KtJL6NQOnTjMvdNGf8bVcGvTDlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chipsnmedia.com; dmarc=pass action=none
 header.from=chipsnmedia.com; dkim=pass header.d=chipsnmedia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chipsnmedia.onmicrosoft.com; s=selector2-chipsnmedia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8utOFXxbLDEr2TD58UTmf2jV6OeoYkStHv59ULoeMxs=;
 b=iFx8xWxIvz+JQD8IdFN2PqejjbvLPbbDhK8ItSsUbSaPag/9bvk1z+DH89fPELGhPvnM7cyTFS8euSpaf88litkGkc0+ggq6tTkiKBA93LqDsudbrGxNtAur5NNK2zZb9vdb3xl7JbAyPb5RLMeelG0mFsujSXKSvHzb7TtFvyg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=chipsnmedia.com;
Received: from SE1P216MB1303.KORP216.PROD.OUTLOOK.COM (2603:1096:101:15::5) by
 PU4P216MB2229.KORP216.PROD.OUTLOOK.COM (2603:1096:301:131::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.22; Wed, 31 Jan 2024 01:30:54 +0000
Received: from SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
 ([fe80::de27:9f30:e1f9:1b5c]) by SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
 ([fe80::de27:9f30:e1f9:1b5c%4]) with mapi id 15.20.7249.023; Wed, 31 Jan 2024
 01:30:54 +0000
From: "jackson.lee" <jackson.lee@chipsnmedia.com>
To: mchehab@kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nas.chung@chipsnmedia.com
Cc: jackson.lee@chipsnmedia.com,
	lafley.kim@chipsnmedia.com,
	b-brnich@ti.com
Subject: [RESEND PATCH v0 2/5] wave5: Support to prepend sps/pps to IDR frame.
Date: Wed, 31 Jan 2024 10:30:43 +0900
Message-Id: <20240131013046.15687-3-jackson.lee@chipsnmedia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240131013046.15687-1-jackson.lee@chipsnmedia.com>
References: <20240131013046.15687-1-jackson.lee@chipsnmedia.com>
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0224.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:18::12) To SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:15::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE1P216MB1303:EE_|PU4P216MB2229:EE_
X-MS-Office365-Filtering-Correlation-Id: 99554df8-d27b-4bd2-ff9c-08dc21fc44a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wyOe5ME378lDvSEFQJI2+98whXv8dk2n1i8BW7i8vGtB9Vuog9JQ263J1zY8io70SEl2nor2RXuYVnI2HFgBR9hLtiazWDkUjRvqqgUnK4PbKRHW63waxMOitVcpwW/ZBfM4Ee4o0JV2WeOVuPtVkybOr6L0mpASUPkTbBGhUZrDMzZLOMKr2nByiqw97meIsXNaYTZSwuJkRdsYf6RB5NyvA1/dqQH1SPd2CsDZIRFU3KMfIY4xADA847bA2IFyPeSPN1oyxuoWKdBnxOejmcJ2Fm6udAYImUp2dXin/9T6qBu5C2Jxjb855V9bGqJ/SqWT5cdTqeOyOeDphjaj8HjStl28fJqzA8CaE+9/Z7Mqx66vOO9Mm+98m+ipFk3T+OOCCXA06aa9UKLpdQmgQKKrtjDZfw4Rx2PT5k5sAhYXPl8EO6iYSYMjeMe92PseWKCX05Ch+3z3TGxgqDlrO42V9S1PjRGcYYOWrPNnaXpELj8OOBvvewppTSD4FkZBtkKy7ZdJpvWUcTklvKF+nzOfJz7aL3Zxt0AUl8MD4lVkYxJIt0vpdxACKRr9M9EpSyfn7kV3oyJ89rHV+zElLR8GipEtdoG9K3huF7Hvg1QBjdxB+JOS/Ud5I43yn5Q6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE1P216MB1303.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39850400004)(396003)(346002)(366004)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(83380400001)(6666004)(52116002)(2616005)(6506007)(316002)(6486002)(478600001)(86362001)(6636002)(66946007)(66556008)(66476007)(41300700001)(26005)(6512007)(1076003)(5660300002)(8936002)(4326008)(8676002)(38100700002)(2906002)(38350700005)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qAFQ2ss0dpqH4puRJ5cIL7lDJBabns8nIgxs9OueCPpkMwOqcehCwNj7hRak?=
 =?us-ascii?Q?SDYIvujxf2O8Ew0hM4IBNxXx8+YKT8V5WICQ5skNqUNDwTvRTWK8HdmlHGMw?=
 =?us-ascii?Q?hFtW1jV1ZaqrkFopvSKA2Bqkty3gUCtQWtiSY5kXdLbGsHuFIz1/0kQ65Txl?=
 =?us-ascii?Q?TlYCS6w5/+rPv8B0rz6m1s7WcehmYI+TJuqkLK5NpwkoAR3/mEs9uG7n5OMw?=
 =?us-ascii?Q?s/d+zgM1Ok2rzonjiae1ibghUjVXZy6DcO4hCT35oB9vbd4vt9/DvpAyxQyj?=
 =?us-ascii?Q?t3vznZSAkjU59HhCRwpK4ZliIIydM1wDJb4P/kOQiYhdntWtUD85KxS/qpzO?=
 =?us-ascii?Q?AFo6pZUrRD0y1GY848ktTMVR9SvDSCnLIqvgau/3SDAfUgXGYwauug4QeKV1?=
 =?us-ascii?Q?2iXihGXG3k2bsBcsddfG31r85xico9b8xJZzDWsm76PdYTbf9GRrv2cPQqgp?=
 =?us-ascii?Q?tVumfl6XbWOkvegn0/TBtG56nRwewQZ3iAQ8hX9wHts9V4yLUfZR6kx3LL4C?=
 =?us-ascii?Q?kunj0IS+bd1KF5zYWc6EQClTVmp1DMSXYkgG+osaFYKNfl5P3Q3FRfcypTlz?=
 =?us-ascii?Q?vV9LagUPS7b5nNqv3jp6IZYtxy277EqEXr5w6P4zffWyzm31kGzro/jZmRlk?=
 =?us-ascii?Q?F526UOOCenmUxJs0V/EGdiU0rrAai2HJnZmmLE99cC9t2WRqVSVdOEtGsAbL?=
 =?us-ascii?Q?fyi+x8DmOzArnKIXsvZNd7VcYzdUYn+qNLnmoet/tOy2DTTgzuuJb7QbWLFG?=
 =?us-ascii?Q?FLPkrDt/dX7lsqqRy9gk0Vov182Hi8F2RphV8IhxpY566zD2XGQ3B977XlRz?=
 =?us-ascii?Q?jCUZlSxi7LtOuMtVgmrgii7vMhQHHXe8p3qPrTNJVzXytLLxYF1d+HXfLVvb?=
 =?us-ascii?Q?fWaaI2pvwlh2cq710u+upqHbCAc2z5vpf2HB0qxQhYCySgO0pxRzjUBbFzFo?=
 =?us-ascii?Q?tleRPHr2KG+baH4+u3Be7okP00SU6mVx4+1qDGIbZtl+ioVFPnPOaMvank7B?=
 =?us-ascii?Q?k6uaVOu3c2CQPPCvSLVq11kUYuXB7FLDRIW4udiflwsRxFt2tA6UvOWo0Naz?=
 =?us-ascii?Q?ysjGO8BzI+PXeSb1QtWMJ7NVOp/AD/iLnnE6uEtqg4GcLUv/UZFjoL9ofg3a?=
 =?us-ascii?Q?D3Gx0FG7rkFPqdSXHQFRc5anHlK7wtoj4uOSOwwW2/grQplyxEprbUlVh03Z?=
 =?us-ascii?Q?TFedgbex+z3+EbCR+qE/48UiJL8zsyPWQZhE06bIlP6vLFEZE8kfnXDLb4N/?=
 =?us-ascii?Q?t4FCkYYj5usDMY6hnT4lJUfchiq4ZcEjGVIXPUh+MMwfhiiAVVlBZwuoAXHU?=
 =?us-ascii?Q?xlKxwad8UAw5q3EDKJqnpuGopc7a/uQgtWJCKiWGq5ExbOOlaSuHutkP6l0T?=
 =?us-ascii?Q?iC/QXyjgHFbfaNiT3nFgUxxYXn6iust8mV31XaLDXidXV/pWTY4cA1zNr5rH?=
 =?us-ascii?Q?hteZGxTf5kRgMJ5eHaFYU88oFlN63CoIFZk770VDjRPtNhyugu1t7+dCFjbf?=
 =?us-ascii?Q?GByUkAwI0v+16s7ybbvObju/yHXOfPrXiPwdanUnk7/N5W9Ly71bchax/ji7?=
 =?us-ascii?Q?GiLMFUh83o79N4aX0wCvQD4KyCMltALOvQpEH9/cCEz+I5WHLhNWnfgl0uys?=
 =?us-ascii?Q?QLYdySQQIBmwUYTjJEhaZVw=3D?=
X-OriginatorOrg: chipsnmedia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99554df8-d27b-4bd2-ff9c-08dc21fc44a1
X-MS-Exchange-CrossTenant-AuthSource: SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 01:30:54.7621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4d70c8e9-142b-4389-b7f2-fa8a3c68c467
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KUC7fQib/n6T5AQ8OR5NVoDQXXMmfg6D6VR28oFY1VWe35zzibQUCZ3jXrWi7rlpRL/ZINfg+G6xkcQRcmT0btpnyXf9i9Ve/yNOa7onKcw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU4P216MB2229

Indicates whether to generate SPS and PPS at every IDR. Setting it to 0 disables generating SPS and PPS at every IDR.
Setting it to one enables generating SPS and PPS at every IDR.

Signed-off-by: Jackson Lee <jackson.lee@chipsnmedia.com>
Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>
---
 drivers/media/platform/chips-media/wave5/wave5-hw.c      | 6 ++++--
 drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c | 7 +++++++
 drivers/media/platform/chips-media/wave5/wave5-vpuapi.h  | 1 +
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/chips-media/wave5/wave5-hw.c b/drivers/media/platform/chips-media/wave5/wave5-hw.c
index f1e022fb148e..8ad7f3a28ae1 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-hw.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-hw.c
@@ -1602,11 +1602,13 @@ int wave5_vpu_enc_init_seq(struct vpu_instance *inst)
 	if (inst->std == W_AVC_ENC)
 		vpu_write_reg(inst->dev, W5_CMD_ENC_SEQ_INTRA_PARAM, p_param->intra_qp |
 				((p_param->intra_period & 0x7ff) << 6) |
-				((p_param->avc_idr_period & 0x7ff) << 17));
+				((p_param->avc_idr_period & 0x7ff) << 17) |
+				(p_param->forced_idr_header_enable << 28));
 	else if (inst->std == W_HEVC_ENC)
 		vpu_write_reg(inst->dev, W5_CMD_ENC_SEQ_INTRA_PARAM,
 			      p_param->decoding_refresh_type | (p_param->intra_qp << 3) |
-				(p_param->intra_period << 16));
+			      (p_param->forced_idr_header_enable << 9) |
+			      (p_param->intra_period << 16));
 
 	reg_val = (p_param->rdo_skip << 2) |
 		(p_param->lambda_scaling_enable << 3) |
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
index 0cb5bfb67258..761775216cd4 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
@@ -1125,6 +1125,9 @@ static int wave5_vpu_enc_s_ctrl(struct v4l2_ctrl *ctrl)
 	case V4L2_CID_MPEG_VIDEO_H264_ENTROPY_MODE:
 		inst->enc_param.entropy_coding_mode = ctrl->val;
 		break;
+	case V4L2_CID_MPEG_VIDEO_PREPEND_SPSPPS_TO_IDR:
+		inst->enc_param.forced_idr_header_enable = ctrl->val;
+		break;
 	case V4L2_CID_MIN_BUFFERS_FOR_OUTPUT:
 		break;
 	default:
@@ -1292,6 +1295,7 @@ static void wave5_set_enc_openparam(struct enc_open_param *open_param,
 		else
 			open_param->wave_param.intra_refresh_arg = num_ctu_row;
 	}
+	open_param->wave_param.forced_idr_header_enable = input.forced_idr_header_enable;
 }
 
 static int initialize_sequence(struct vpu_instance *inst)
@@ -1775,6 +1779,9 @@ static int wave5_vpu_open_enc(struct file *filp)
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



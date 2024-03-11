Return-Path: <linux-kernel+bounces-98729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C68D0877E79
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 11:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48B421F2111B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C8A36B1B;
	Mon, 11 Mar 2024 10:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b="Bgs78w2T"
Received: from SE2P216CU007.outbound.protection.outlook.com (mail-koreacentralazon11020002.outbound.protection.outlook.com [52.101.154.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281F03A8C1;
	Mon, 11 Mar 2024 10:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.154.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710154603; cv=fail; b=IowkZcqgXhjiMTPA02u/owE7lGRPN2ff7QOFay21yhDqGwmcdLjtbB64CL7tZ8DDL6zuIgNedsWiW055Xda/fd3ZEVGkIeknNdmoMDZKlUuUUB3Xuw7nqJnBWsYu0UxpCHPqVUjfDiuZy1QOb7y/RQfM6fzoRAQ0SWdlP3gofYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710154603; c=relaxed/simple;
	bh=yxNFp988MN/rGSkeStJyaW4sORGym2mKJNvRu9JwxrI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m8EFmqlE8NY9w12GcP4Vl9HjCWW1EaMDMH3vxhfAASO6vxT+zX6MBgb3DjH/uPmqrasKQXfFUpIVvMBQkBmMgrSzRV+GOwRnag+x3+me62Eg9h2OMdlWxUoddqNyeb7/0e9AkGGowR+4HMso1lbZf1XRPLg7ygoSVbKNXBjjdN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com; spf=pass smtp.mailfrom=chipsnmedia.com; dkim=pass (1024-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b=Bgs78w2T; arc=fail smtp.client-ip=52.101.154.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chipsnmedia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/imnr/Xm2GlbLAdKDkTPEMZoPQqCTrZZtzYZb/A6Tc+7hoOYu8DSC0UEtCmRxmxseM72bj3XnbnPxzWerI2O/91A4e8u5rvf/+ePJPQ10HPWcxjCSEQtIigYLIUnFs869Z/iNoeaqdz/R0xH9dkQa8YFeW2FOaEj4B98j4qaRVLlgoB+Z3MfYO8zDz2slnNbBEESJLUOjmvQEy4vz1k7rf+SNZP6l/AX8kLx2+r8uayIqxBu330FtDxpSSWumd4XsoocZuGa1XPXzBgcQlFGTCcwHxNmGmK71sg4pVHMjrezACKa0z7/Twfdbu5TXYZtPjegcNakW7EK9LbQVLwVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5AOc2QOAt3qo30Tc77Pm7XC3tlB9nOy+F4lkE4s5kPw=;
 b=MHCUCkkRa4xrwqaWKqQiQFQLb5SOU/fugASXXk5r5EeInUaBkJbO1qlHoVfW1qbDpqk6WI3YsXKUMpK3dxvsPtq9LLVEf1CYI8LjyKvL6w/wxOiF67qDRvkTQu8nEFkvEx2bTWnyt5Psk6NfLlv2VbwCkje1huzxSo5zMiaRxezxMqOBDrDF4zXtfLuPcb4P4WQfcxFBmq+Svyh32RUmcHYXRLi9RX5VKAlKGvJYDie5EMsDoBJp+HiefKPhwMlF0vs+0nWdoYkZi4P5Aku70Bz5mN+mmMGYc+doysdVTpf4t6CEX02SMoaJ6hcCHoW92yzjEfDZGHh5UQ8/ep8ptQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chipsnmedia.com; dmarc=pass action=none
 header.from=chipsnmedia.com; dkim=pass header.d=chipsnmedia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chipsnmedia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5AOc2QOAt3qo30Tc77Pm7XC3tlB9nOy+F4lkE4s5kPw=;
 b=Bgs78w2T57uhjhAPug3MkqG4hmaZgNjjEJn2SWusmY3LNBCUEtkJ0JN0W2D94hopegDua8d+dqq8W4YSswZQP2Her+VCIVBDnlKl5db9KtXEisoQJe0Z94Kvduh6QIp6q3YjBJVMNJnTlgLT04GHYOLQt8XWfYThSlFoPfJf2cg=
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
Subject: [RESEND PATCH v2 4/4] media: chips-media: wave5: Support YUV422 raw pixel-formats on the encoder.
Date: Mon, 11 Mar 2024 19:56:23 +0900
Message-Id: <20240311105623.20406-5-jackson.lee@chipsnmedia.com>
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
X-MS-Office365-Filtering-Correlation-Id: da2880e9-1ddb-458b-e225-08dc41b9e90d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	G1L5LpWatu5C9xrfDaMTvWoaw3WxmYp/x7XkbLFJJErni/KXKuEBwnL9zBF0drzJqggD6IJexvGqW3BDLqNaAgOGCMIhweyoyqeplJqLh2Yf4PqfzHY7sv4o7GV7a+ZNBuGftEnGgzpUJT39+CY4Cub1BJ0wTxyuf8YTpDJV9uBm50XE+v4oyeLYdtRfDiacNLEXrB3qoDrd+wD1jISnGSft+w7dWKNib6T3TdWkvACHK00h85THSwrXVig949Epk0Zn+zFMQxdNV8J0ztfdxbSMIHpOwkEBS23YGt+nVJPdcV0Bf9Iezqql/7xLXLSywrTvlDHOnE/ElIvECi8ZbcYFXT4+gHzKpVHO4HZfloNQ1iZaRPP4IVF1hQ82u4BNi1HJY20KZfZrna627sxXynOuJdjvMNjTleSGtRPS9p/2ytMk7OHrcQhRo0iqd6Iyg04xs3PRulRX6yrhY9Kwo0kq8yE/47Rvsj6/dwZPvuKcWRmDtP097V/eErLE4jVbTgk9OAk6+BTCLT62dgMHugoJ6hch1I9xLVTYeqVmQ08tKbXJ1LUMUiwa39JTg8yL29Ggxwwa4q+ROSJ7ht72h5J38x+6/3Si+gwj5p5WBkZeM8NxS56CNC0Jd6HjwRsHpWsAFd7ljfF417AXtP5hUrQIsvfd3XMIEItpCf38QyZyOXAsqKzHYNyrSwlTcPK4khyD2z/JTiQ1vIXUckYWCe2ymR95L1NiG6IaINg/3Z8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE1P216MB1303.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NxP+NFzny3H6BRWGp7EQ97yhu1GDNXoy+LcAbgZDUxtMUhxD39v3TQypV/7N?=
 =?us-ascii?Q?KxrnEpNpVCtw8HOaqc0/dhY4NEVj3x9u85RBp99tLkS09amKhUhLNxxDMHIs?=
 =?us-ascii?Q?dPkw2U4AthEeCDiNQGjAEqNoE0sDKzCuQjXMhSVrBRaR54h8FAXYVI3fA13W?=
 =?us-ascii?Q?FL4ZnmnUQQH0wB0oe1pdt/4uar6hVMaGo2nDdtkRk09LcgdE7xEI45fkQ+1k?=
 =?us-ascii?Q?ZEcnCsA60S0RamCNsGTsL0RtVLsCgmjq03YM/zzpYoTQFfGVDSIv6MP2sbjs?=
 =?us-ascii?Q?NGucyjXoCWavZ92lGMFy7f0ka0U0kn8SqxxoKbHLzI+FCxqA+l4z1OxtC5fR?=
 =?us-ascii?Q?/U+ILRtJP2Osx+d59dVwgkdO8ni+V/v4L1Yn01upCBQqYNoeKzMgeGpTQzom?=
 =?us-ascii?Q?kw8pG1342jvnh2mEHDzVQm745DGfKkHcvOYNbC7uaIuRYkFaqgK95jJHWe5i?=
 =?us-ascii?Q?GNzaPDY8xyuVL9zBYwNJrlR1RMKQ3H/K7PpbVMH8C0pQWNpVPw3NY2rbGNnV?=
 =?us-ascii?Q?V4KHdeQeEwo7HnR6mYY8dWmKHFj2zpvmrtk+yC8G9TaMSesNZr7stu0fR7hN?=
 =?us-ascii?Q?2evG+Np1zZpligrCU+vvb4ruOK4RY3xTIcDdktkOB78jmQE66CTscRAG3J8y?=
 =?us-ascii?Q?CiFRWQYgB0XgF0/MOWmr0RxpTi08bEuiLfJLNqfQDzF6dbIVIj6gR78KlMJD?=
 =?us-ascii?Q?3DKGANwMZXDl0zWuSiXb10l7/qUX+EoI4NLWbWYvnQVzYi1gvmGPvsZmk9fZ?=
 =?us-ascii?Q?95Bh5JMIC5vlLULlEq+WjZdYtfjK4fGaA5HdLTurwbllVIOkp1htfLXwVUq+?=
 =?us-ascii?Q?sWGIox1HAyYifIGCn0gC65xB/U9nruPzj3cD/0iRweMqquiEnPOHnIq3d+lW?=
 =?us-ascii?Q?Qr3nVDhv3fYStZleNAPwxhpRX51l1buceKrSsaJQvz2msztQs6EKKv1tmyjQ?=
 =?us-ascii?Q?+WW7B9lU92X5X3thvkon0VPuYei/60toKFxBzfXJnhOE8YQlLca4JTNzNEeW?=
 =?us-ascii?Q?N71xmLaCj61x9KaMI+qPnUaNTi6E7jRViK1clFWlJsK+B9qRjR703DTW8uPW?=
 =?us-ascii?Q?b5810AwJOFbdlpFZ/PT0pa7nvWWcMki6YQpuNNTw1RqDNpxuygna6QMhZQTj?=
 =?us-ascii?Q?iMlpV7eo4u2dxkNv+5VgH31F/snaNOHSOPq3rSYmCl0cZPXjg5Pt4/V9rSwt?=
 =?us-ascii?Q?YMOC8tQUHeq6atDMegQ591LaqaFaouKgzXdLhzqcULCtK98///yHYOgyzAZv?=
 =?us-ascii?Q?lkWaWIHlq3HFoZh+m5/wZiz/y/WUeVKYFQUSoCbH7xU3gvajIyDwWlOpYeAZ?=
 =?us-ascii?Q?8bwXu72ZGUkwLcmRSzxGNu+bt06e4oepIkzbhGvtYHQ/R537plrOciYyoHJ7?=
 =?us-ascii?Q?6+80UzrNPjgMSkzdXWvQG8lMIIghmCZDAOS3bOMlFBRS8yx0G+c/qUvjaYAW?=
 =?us-ascii?Q?fiXUydxXDpKnHLTNDF39gyMXO5LUC4YIXAAUWqJOo/VPCRuywPQHQcWTZ4ry?=
 =?us-ascii?Q?XXy/NcrTPKXpRTRYzJ/wXcp6w5G4vV9KrHJn/ckfpMRueRzLPULtRF9ce403?=
 =?us-ascii?Q?TxOaHG4YmJVZkKTi5nCXh1zXhOsIDuKcwU7MBqg2Wa9YGfMxQIsqqOjAArzx?=
 =?us-ascii?Q?kg=3D=3D?=
X-OriginatorOrg: chipsnmedia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da2880e9-1ddb-458b-e225-08dc41b9e90d
X-MS-Exchange-CrossTenant-AuthSource: SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 10:56:31.5264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4d70c8e9-142b-4389-b7f2-fa8a3c68c467
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ajZCkbccnSIgBIblDWoYyMGRr5LvfVDLsLElNz6cCloO9LpOWPVlMd/Ses/6kgbsJGE/yCf7hY7Ls1H6EV921Lamcc5v/oG0f4nbPHR5t78=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE1P216MB2024

From: "Jackson.lee" <jackson.lee@chipsnmedia.com>

Add support for the YUV422P, NV16, NV61, YUV422M, NV16M, NV61M raw pixel-formats to the Wave5 encoder.
All these formats have a chroma subsampling ratio of 4:2:2 and therefore require a new image size calculation as the driver previously only handled a ratio of 4:2:0.

Signed-off-by: Jackson.lee <jackson.lee@chipsnmedia.com>
Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>
---
 .../chips-media/wave5/wave5-vpu-enc.c         | 59 +++++++++++++++++--
 1 file changed, 54 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
index 5a32bb138158..77657f63a169 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
@@ -39,6 +39,24 @@ static const struct vpu_format enc_fmt_list[FMT_TYPES][MAX_FMTS] = {
 		{
 			.v4l2_pix_fmt = V4L2_PIX_FMT_NV21M,
 		},
+		{
+			.v4l2_pix_fmt = V4L2_PIX_FMT_YUV422P,
+		},
+		{
+			.v4l2_pix_fmt = V4L2_PIX_FMT_NV16,
+		},
+		{
+			.v4l2_pix_fmt = V4L2_PIX_FMT_NV61,
+		},
+		{
+			.v4l2_pix_fmt = V4L2_PIX_FMT_YUV422M,
+		},
+		{
+			.v4l2_pix_fmt = V4L2_PIX_FMT_NV16M,
+		},
+		{
+			.v4l2_pix_fmt = V4L2_PIX_FMT_NV61M,
+		},
 	}
 };
 
@@ -101,13 +119,30 @@ static int start_encode(struct vpu_instance *inst, u32 *fail_res)
 	struct vb2_v4l2_buffer *dst_buf;
 	struct frame_buffer frame_buf;
 	struct enc_param pic_param;
-	u32 stride = ALIGN(inst->dst_fmt.width, 32);
-	u32 luma_size = (stride * inst->dst_fmt.height);
-	u32 chroma_size = ((stride / 2) * (inst->dst_fmt.height / 2));
+	u32 stride = inst->src_fmt.plane_fmt[0].bytesperline;
+	u32 luma_size = (stride * inst->src_fmt.height);
+	u32 chroma_size = 0;
 
 	memset(&pic_param, 0, sizeof(struct enc_param));
 	memset(&frame_buf, 0, sizeof(struct frame_buffer));
 
+	if (inst->src_fmt.pixelformat == V4L2_PIX_FMT_YUV420 ||
+	    inst->src_fmt.pixelformat == V4L2_PIX_FMT_YUV420M)
+		chroma_size = luma_size / 4;
+	else if (inst->src_fmt.pixelformat == V4L2_PIX_FMT_NV12 ||
+		 inst->src_fmt.pixelformat == V4L2_PIX_FMT_NV21 ||
+		 inst->src_fmt.pixelformat == V4L2_PIX_FMT_NV12M ||
+		 inst->src_fmt.pixelformat == V4L2_PIX_FMT_NV21M)
+		chroma_size = luma_size / 2;
+	else if (inst->src_fmt.pixelformat == V4L2_PIX_FMT_YUV422P ||
+		 inst->src_fmt.pixelformat == V4L2_PIX_FMT_YUV422M)
+		chroma_size = luma_size / 2;
+	else if (inst->src_fmt.pixelformat == V4L2_PIX_FMT_NV16 ||
+		 inst->src_fmt.pixelformat == V4L2_PIX_FMT_NV61 ||
+		 inst->src_fmt.pixelformat == V4L2_PIX_FMT_NV16M ||
+		 inst->src_fmt.pixelformat == V4L2_PIX_FMT_NV61M)
+		chroma_size = luma_size;
+
 	dst_buf = v4l2_m2m_next_dst_buf(m2m_ctx);
 	if (!dst_buf) {
 		dev_dbg(inst->dev->dev, "%s: No destination buffer found\n", __func__);
@@ -490,11 +525,15 @@ static int wave5_vpu_enc_s_fmt_out(struct file *file, void *fh, struct v4l2_form
 	}
 
 	if (inst->src_fmt.pixelformat == V4L2_PIX_FMT_NV12 ||
-	    inst->src_fmt.pixelformat == V4L2_PIX_FMT_NV12M) {
+	    inst->src_fmt.pixelformat == V4L2_PIX_FMT_NV12M ||
+	    inst->src_fmt.pixelformat == V4L2_PIX_FMT_NV16 ||
+	    inst->src_fmt.pixelformat == V4L2_PIX_FMT_NV16M) {
 		inst->cbcr_interleave = true;
 		inst->nv21 = false;
 	} else if (inst->src_fmt.pixelformat == V4L2_PIX_FMT_NV21 ||
-		   inst->src_fmt.pixelformat == V4L2_PIX_FMT_NV21M) {
+		   inst->src_fmt.pixelformat == V4L2_PIX_FMT_NV21M ||
+		   inst->src_fmt.pixelformat == V4L2_PIX_FMT_NV61 ||
+		   inst->src_fmt.pixelformat == V4L2_PIX_FMT_NV61M) {
 		inst->cbcr_interleave = true;
 		inst->nv21 = true;
 	} else {
@@ -1086,6 +1125,16 @@ static void wave5_set_enc_openparam(struct enc_open_param *open_param,
 	u32 num_ctu_row = ALIGN(inst->dst_fmt.height, 64) / 64;
 	u32 num_mb_row = ALIGN(inst->dst_fmt.height, 16) / 16;
 
+	if (inst->src_fmt.pixelformat == V4L2_PIX_FMT_YUV422P ||
+	    inst->src_fmt.pixelformat == V4L2_PIX_FMT_NV16 ||
+	    inst->src_fmt.pixelformat == V4L2_PIX_FMT_NV61 ||
+	    inst->src_fmt.pixelformat == V4L2_PIX_FMT_YUV422M ||
+	    inst->src_fmt.pixelformat == V4L2_PIX_FMT_NV16M ||
+	    inst->src_fmt.pixelformat == V4L2_PIX_FMT_NV61M)
+		open_param->src_format = FORMAT_422;
+	else
+		open_param->src_format = FORMAT_420;
+
 	open_param->wave_param.gop_preset_idx = PRESET_IDX_IPP_SINGLE;
 	open_param->wave_param.hvs_qp_scale = 2;
 	open_param->wave_param.hvs_max_delta_qp = 10;
-- 
2.43.0



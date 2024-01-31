Return-Path: <linux-kernel+bounces-45587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 516D38432BE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 02:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD3AE1F27483
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 01:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10EC31847;
	Wed, 31 Jan 2024 01:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chipsnmedia.onmicrosoft.com header.i=@chipsnmedia.onmicrosoft.com header.b="GkQCVtfK"
Received: from KOR01-SL2-obe.outbound.protection.outlook.com (mail-sl2kor01on2119.outbound.protection.outlook.com [40.107.129.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6537AEA4;
	Wed, 31 Jan 2024 01:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.129.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706664660; cv=fail; b=BtxIo94PzR2eR08ZkAgx0I4bNp34tpRM0P3hcDGKAK3GvZI28YM7jBfSHs5PtnhPuGZPSVz2iwxk6jwtK5NzDVDcnP/sTobQLJK5Z4hBEbVcpqGciZ7G9GHot1u2eRgDd9g0IQYWATtRNF/gkGSZPeEQI5/HVNHAGrWZhk1MSlU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706664660; c=relaxed/simple;
	bh=JIhvGfNywtwdrHhM1QNneERXxrfgWpuWXUxJ8ff+Y5k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p06xjCU9M1NDJtDhtBWR0M5TzHG/9dHL49HwebxzIGM6xwzPqBfFBmahPW3zunk8h8xG4vKlNGhYbysaIIpmqkVKVNGA6nR8RFLRkQaf3zBzHZXDK43MCineXi9DGnlGv6Lq4WdbwriMeATGz7Ctx3N/T4lwPyCyxyicTGTkvDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com; spf=pass smtp.mailfrom=chipsnmedia.com; dkim=pass (1024-bit key) header.d=chipsnmedia.onmicrosoft.com header.i=@chipsnmedia.onmicrosoft.com header.b=GkQCVtfK; arc=fail smtp.client-ip=40.107.129.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chipsnmedia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CuyQHa0mD9t7e+jABp2sZcWRAtrDiJVkxTr9SnfUsoGSDI2qzB4a6j91CjtbEzOTFl4/IYAa+KUQGdQlxSQbvjq2R2mhxtZNFyFiioEN/OXV2POvYGEytGo5wFO0/C0eFYAIBUYIdli+HswigckE8gbuF49hXb9Jc/GJfs8nY1P2Nzsl1ri779a/xnCtbR60vRjMblGXP17JZv7JBZv/SdR6Viw9NT9VvFLcbLa5grL82LB26AzxzOq7JHCQFTk34AHM5CV2YqyLYzPymY0BXYgwO0mKev1eqCq7yYdDoWMckOO/b+w9v7smRbeaACDppNW7TSN4fWIsfsONFhHzpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GJnQ/OS1RAiuGjD1AtU31iFg23nF99Sk/pxQkcLYO6Q=;
 b=gipHeMXCjQ9z2/JkImQhsnC/6UBqccPbvi+UUtt6o+qApr1X99Hlxv30FdUt42VB9V8G+9jWI70jwMlU0E65W/5Z3zW+YWXWmYmiSfXEQ3a3JFjG2JqndZ8mIoGUtI0pk3xl2/sE0zqXvP2Cg9As5USzIPZpIRdjRaf/qdnrSJvc0XBPTHAH0W4BiGweRMHb22cna2PoItYJdNxBfQ8DM2YVjx2EDi5ITDCw+Pdix1q/Xm6/W1YNpqwn7ko1y4YBUxBfZTmY6k1b/S7dh77IXhFRqQDvWlGjC0YnsNOcAodEzws3X5ZO3cNXEiLHwPgS2f0SJYWF1dzThKWz8/uWkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chipsnmedia.com; dmarc=pass action=none
 header.from=chipsnmedia.com; dkim=pass header.d=chipsnmedia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chipsnmedia.onmicrosoft.com; s=selector2-chipsnmedia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJnQ/OS1RAiuGjD1AtU31iFg23nF99Sk/pxQkcLYO6Q=;
 b=GkQCVtfKpaeh8rRt9isWENCZsC+Z0N92y86aFsVqRlnmGThMjywvazNkEk0O5GUjh1k5P2oZ9iI2IvAyi3in0tf7h0Sje+I+QqOWFeHt8jUoYaySvPnAPcC/hA8h6vdwcSJMqYowsxzHv2sp2OuvOZ4EDG5NWPRQxikBKjtH6DE=
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
Subject: [RESEND PATCH v0 1/5] wave5 : Support yuv422 input format for encoder.
Date: Wed, 31 Jan 2024 10:30:42 +0900
Message-Id: <20240131013046.15687-2-jackson.lee@chipsnmedia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 209c073e-a94c-4d74-a1d5-08dc21fc4470
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VShc+megklDNcQ6MCBPQ1Jq4YyiuX8A4aM8qnVTjyB8F4H09IjyOs/7vfB/UwSmfLv1/xdS/K/0lflsdYKgd6SrQwfzsx7M+FJluDaQ0GPJGAACd/GQzGbxHV79KTtAM7xFK9vxY4n2dzz1iVAvHpbq1YZ10ngUCvg5ySOVYpyxiboxWk9kXMOBrsimPwqRRqtVJSOUu7KQaUM89x3gurXfDj4Ltnmom5gYhwbUxqPuTNx5BnHTG4QsvFCfZdbZtFrWlKErix/npge1lvPBlZraAhJGtsVz+/CBRjB7JYPACcI5AjLpP/wqwxcfUuZwlB8YPyqv2eOhpg3rt0omKB4PIVf6KLdZpjIx0hOq7OFD/uar70fr94D32pg4qLYM998qcSyAQO0YxqDK3+uGJg8lsAMZa7W3QATs5fODAn7o0kdGN1+uVu06sCI9mn1ZxXtRqMXcnv7MRPyelTfu96eUFEzkUx6AWEyge6dzNQueUO4p0gL7UoHFJj/C82/T/N6f+vnSqTe2cD96YWgrxyA694/Xm/zVU7Bwtm7Ba4fAdhYqOw6pMRxXGRvHNzlkrOgA66oPRiM8g67ZZm4HhOkv/0+9h0YaL/HkdyKXVbh7ff+Sob4jddeP840RM7ksQ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE1P216MB1303.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39850400004)(396003)(346002)(366004)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(83380400001)(6666004)(52116002)(2616005)(6506007)(316002)(6486002)(478600001)(86362001)(6636002)(66946007)(66556008)(66476007)(41300700001)(26005)(6512007)(1076003)(5660300002)(8936002)(4326008)(8676002)(38100700002)(2906002)(38350700005)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z9dahGO0ZmKEMCdAndcoWPlDV/y+cc63VtbKf8Nk9EcgJ+82nKgRSH85CMEN?=
 =?us-ascii?Q?zJM+2anuMJrnS346e0CCCIG8BLocLLLSCBTH52n9XBvwYiSHTezXt4mYj5Aw?=
 =?us-ascii?Q?Ova91kda4oYOqXQIyDmya/F8oP/qG0JXNLuPFydBWrRt5+nfhvQiGflm2vF6?=
 =?us-ascii?Q?YAmvTZa+whjLUzjKr57MRBJGztG2tVcddw+6wYE7tf+OTZ2l08fjSunjsN/3?=
 =?us-ascii?Q?FWB9KbhwblhbQ/VffesJOmNRQv8bmOZOHW0Bj1bTCgCrPltzH9M15IZwKtwJ?=
 =?us-ascii?Q?Rm3q8mKOCoiGglnnqGsopBI5SvQ+PNYh2QVUm+ofxwNaG2wY25PoHVk9dzNN?=
 =?us-ascii?Q?jLAyeHgT9uB/FQu3yRi3iBx3e6UqAoVtl32Gj1I3hFRVDWuYRTvDBj1fivvU?=
 =?us-ascii?Q?IWV1nNXzFNCZEnYVCmav+Abd4mjMZb288pQdyogf3NNNBPLGW9ZPa9CN7dK5?=
 =?us-ascii?Q?X9gQw3mfMBpUnRZF4SoLLv4+Xf+ArLcrYVN+zVVAed/LZYT7M6NB6mivR76b?=
 =?us-ascii?Q?3I77n3qcXU06DDSwM1L57QHygAJ1S8ixMAlli9PqoWjn3Sv+dt98uLO/whhs?=
 =?us-ascii?Q?ySepfQguiabVSIXSc5g9ilh9yU1NuFErrWSdd+huwnYhFLKht4MTsR06Ra89?=
 =?us-ascii?Q?6kARmlTRX6O+mRFbCUYFeMzKYfynZv55RntlJUpwBjzHbtOWdKU1t/OPgi/x?=
 =?us-ascii?Q?JVXb72O9BXUwG14qu2Muv9eBsZJCb7R4MuU2jpi4LgcpXmC2k3IolVly3026?=
 =?us-ascii?Q?o6YHqFoHCsMOyDTFh8LX9yJJHQhsNTwLA5aRLcGM98rm4YmgcH9wfzj9IqfR?=
 =?us-ascii?Q?2JxrBaw9krseYW9HYAfM1wqLxew1dkoWQeE+LuRe+ZrGql6SGuKz5L26FD+l?=
 =?us-ascii?Q?ZwYKTskzM3a3/pYSsvK9Gc2/rJPcsyVfzBv4LUJzru/O+vFisPJRNBh5TnVd?=
 =?us-ascii?Q?m5YMwXp0L0TTtjCfDOxQcBKiRG0N0NkKp5GKpRWqEvAdfCZcm7mqVfQJ9CjF?=
 =?us-ascii?Q?3rq5f/gd4MxJ+eRjO2Rfi7Rq9xDPzaJM0qW5NR3HcimtqV7qyk24qyRLykke?=
 =?us-ascii?Q?VG/A97My5+Hjc+KESLFImdYuwWPm/TTuQeyxRKyjZZunKaJ6AYJ5hG2gSegx?=
 =?us-ascii?Q?S10IhF4CWHlX7pGm8hPw9jmG/sjhdYmuNAx8ZuYuY8VMUFhywfp4NNUQjnot?=
 =?us-ascii?Q?oSwLeH5t3pl8AhZjYlZDcksiRCzT8NrvZ8wiH7GvSeLoKImJ+CsK44r08d48?=
 =?us-ascii?Q?u7M/cg+qAqdY3mDAmKIfWvlun9hxUnAqeefz8Qao+PHYH++LoxAjl7OmwU3F?=
 =?us-ascii?Q?vx6KXJDUtWY3DZwSTsnXRP89t2Zan81zpOfg0kTeTaJx6MdI9KNCn6PI9oqy?=
 =?us-ascii?Q?WnxcxtTHhfrK2MaR6V1pXlLCJ2VfC9I3Zo/XNUmhC54h2VXmzRpuLlpyplSM?=
 =?us-ascii?Q?h1iiKYkllYfiNWST/A4EhfmbUkazJIlgiqVDN06BJ5sFFr0jygcgjXL/kx0S?=
 =?us-ascii?Q?kh033CvEmGrD9NfcNs4G8lMoALxPkasQsMwQfYAxBF8rqx3wyDTZb4dDucUT?=
 =?us-ascii?Q?Gd+zFhMPJ6ttHPxOQDBD3b/YWl5o/ztDL69sUurbj4UiZlEKCXBxMaK0V/Ya?=
 =?us-ascii?Q?g3VUn0XWZKKst8oJ4JjpC1Q=3D?=
X-OriginatorOrg: chipsnmedia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 209c073e-a94c-4d74-a1d5-08dc21fc4470
X-MS-Exchange-CrossTenant-AuthSource: SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 01:30:54.4349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4d70c8e9-142b-4389-b7f2-fa8a3c68c467
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sf/durbcPothbmshjhi99DfB1eKrmt09QkH7gnCtk7tJPfy5F5neWy0LCBetLSFbr6DawOFQXYzt+gSN9nUXf7rfJuKD+EHP1OFnuIsa7Q8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU4P216MB2229

Encoder supports the following formats.
YUV422P, NV16, NV61, NV16M, NV61M

Signed-off-by: Jackson Lee <jackson.lee@chipsnmedia.com>
Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>
---
 .../chips-media/wave5/wave5-vpu-enc.c         | 79 ++++++++++++++++++-
 1 file changed, 76 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
index f29cfa3af94a..0cb5bfb67258 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
@@ -70,6 +70,41 @@ static const struct vpu_format enc_fmt_list[FMT_TYPES][MAX_FMTS] = {
 			.max_height = W5_MAX_ENC_PIC_HEIGHT,
 			.min_height = W5_MIN_ENC_PIC_HEIGHT,
 		},
+		{
+			.v4l2_pix_fmt = V4L2_PIX_FMT_YUV422P,
+			.max_width = W5_MAX_ENC_PIC_WIDTH,
+			.min_width = W5_MIN_ENC_PIC_WIDTH,
+			.max_height = W5_MAX_ENC_PIC_HEIGHT,
+			.min_height = W5_MIN_ENC_PIC_HEIGHT,
+		},
+		{
+			.v4l2_pix_fmt = V4L2_PIX_FMT_NV16,
+			.max_width = W5_MAX_ENC_PIC_WIDTH,
+			.min_width = W5_MIN_ENC_PIC_WIDTH,
+			.max_height = W5_MAX_ENC_PIC_HEIGHT,
+			.min_height = W5_MIN_ENC_PIC_HEIGHT,
+		},
+		{
+			.v4l2_pix_fmt = V4L2_PIX_FMT_NV61,
+			.max_width = W5_MAX_ENC_PIC_WIDTH,
+			.min_width = W5_MIN_ENC_PIC_WIDTH,
+			.max_height = W5_MAX_ENC_PIC_HEIGHT,
+			.min_height = W5_MIN_ENC_PIC_HEIGHT,
+		},
+		{
+			.v4l2_pix_fmt = V4L2_PIX_FMT_NV16M,
+			.max_width = W5_MAX_ENC_PIC_WIDTH,
+			.min_width = W5_MIN_ENC_PIC_WIDTH,
+			.max_height = W5_MAX_ENC_PIC_HEIGHT,
+			.min_height = W5_MIN_ENC_PIC_HEIGHT,
+		},
+		{
+			.v4l2_pix_fmt = V4L2_PIX_FMT_NV61M,
+			.max_width = W5_MAX_ENC_PIC_WIDTH,
+			.min_width = W5_MIN_ENC_PIC_WIDTH,
+			.max_height = W5_MAX_ENC_PIC_HEIGHT,
+			.min_height = W5_MIN_ENC_PIC_HEIGHT,
+		},
 	}
 };
 
@@ -136,6 +171,23 @@ static void wave5_update_pix_fmt(struct v4l2_pix_format_mplane *pix_mp, unsigned
 		pix_mp->plane_fmt[1].bytesperline = round_up(width, 32);
 		pix_mp->plane_fmt[1].sizeimage = round_up(width, 32) * height / 2;
 		break;
+	case V4L2_PIX_FMT_YUV422P:
+	case V4L2_PIX_FMT_NV16:
+	case V4L2_PIX_FMT_NV61:
+		pix_mp->width = width;
+		pix_mp->height = height;
+		pix_mp->plane_fmt[0].bytesperline = round_up(width, 32);
+		pix_mp->plane_fmt[0].sizeimage = round_up(width, 32) * height * 2;
+		break;
+	case V4L2_PIX_FMT_NV16M:
+	case V4L2_PIX_FMT_NV61M:
+		pix_mp->width = width;
+		pix_mp->height = height;
+		pix_mp->plane_fmt[0].bytesperline = round_up(width, 32);
+		pix_mp->plane_fmt[0].sizeimage = round_up(width, 32) * height;
+		pix_mp->plane_fmt[1].bytesperline = round_up(width, 32);
+		pix_mp->plane_fmt[1].sizeimage = round_up(width, 32) * height;
+		break;
 	default:
 		pix_mp->width = width;
 		pix_mp->height = height;
@@ -155,11 +207,19 @@ static int start_encode(struct vpu_instance *inst, u32 *fail_res)
 	struct enc_param pic_param;
 	u32 stride = ALIGN(inst->dst_fmt.width, 32);
 	u32 luma_size = (stride * inst->dst_fmt.height);
-	u32 chroma_size = ((stride / 2) * (inst->dst_fmt.height / 2));
+	u32 chroma_size;
 
 	memset(&pic_param, 0, sizeof(struct enc_param));
 	memset(&frame_buf, 0, sizeof(struct frame_buffer));
 
+	if (inst->src_fmt.pixelformat == V4L2_PIX_FMT_YUV420 ||
+	    inst->src_fmt.pixelformat == V4L2_PIX_FMT_YUV420M)
+		chroma_size = ((stride / 2) * (inst->dst_fmt.height / 2));
+	else if (inst->src_fmt.pixelformat == V4L2_PIX_FMT_YUV422P)
+		chroma_size = ((stride) * (inst->dst_fmt.height / 2));
+	else
+		chroma_size = 0;
+
 	dst_buf = v4l2_m2m_next_dst_buf(m2m_ctx);
 	if (!dst_buf) {
 		dev_dbg(inst->dev->dev, "%s: No destination buffer found\n", __func__);
@@ -550,11 +610,15 @@ static int wave5_vpu_enc_s_fmt_out(struct file *file, void *fh, struct v4l2_form
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
@@ -1132,6 +1196,15 @@ static void wave5_set_enc_openparam(struct enc_open_param *open_param,
 	u32 num_ctu_row = ALIGN(inst->dst_fmt.height, 64) / 64;
 	u32 num_mb_row = ALIGN(inst->dst_fmt.height, 16) / 16;
 
+	if (inst->src_fmt.pixelformat == V4L2_PIX_FMT_NV16 ||
+	    inst->src_fmt.pixelformat == V4L2_PIX_FMT_NV61 ||
+	    inst->src_fmt.pixelformat == V4L2_PIX_FMT_YUV422P ||
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



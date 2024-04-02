Return-Path: <linux-kernel+bounces-127737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E14B895032
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D79C92855BB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5A863417;
	Tue,  2 Apr 2024 10:34:11 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2115.outbound.protection.partner.outlook.cn [139.219.146.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881025D749;
	Tue,  2 Apr 2024 10:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712054050; cv=fail; b=YrcjRLVW9mSzqpv5mcdJtwNQFIe/fHLh14rM/TTXYGqsNp0WImZg0r9eJqAiFfrL7wVknnGd3GYIQ8tspHSApE/7+h3exW1ZcWOmD55INfC88kWuQ6faAMs716YYg3tb4TsYm3HS9jWevRqK69/XVqVJezbrlqz/V3sa+C1mR0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712054050; c=relaxed/simple;
	bh=3wPJeuqg+XjtvRChC7cZeMIpVlM/VxDZB37ms6ho46Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P+bODGDzH28poopMW6f6yLatK/kTkdA64YXZKyeg92qiiEyUaMTfeJAlRWCd4I4jjLRQS+KSdhKmRN8wqhZ5Bpg25wa3/3eIEdfRjbx8jSfEuelEJqFqfaGZQHf2qhnBsiSBHvW+S2rmLvlcvoAkDnosq8Qppju4Ehq0o019lQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OKCgr4tQC+3JWSYW1RbbkN5tkttHk77DbMOl3ExKNR+DkPCTWHctMTQV12OfsaXiD0/UnnXQGdAH5qbi8wnRBLaRIITWg6UTy15xerI7b4vHPpWIZ+63ItZODzJYK5CUY51XPPrTHGUxs1MS96RvSQS5teMZ2xKmNuwgDb0uvLKF07MvU0j0kfzvvYxySHB9t4TL5zLT4XGRBL8hKZ+BEAh7eJbzdjjj9Fe4/ixWb3F03E+259Ed9+Q67n8/Z4E5vheBSV9Y74g08xCLiVH13C5Ix1KU5hz7hSKIP3rWd9En7V+pAVu7a+BHqAB8Pm/F16UVbX6RNaXEsZrey8M/ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Aac1iEzUkOA0iE0SzMFYIYlDMtGQLHNrnjiiQQSCUA=;
 b=JwbgBdY4PgDsTsDd1zrvpsMXZMdIfgCou11IrFK7gwUwNDPt16VZje+Ni+hviGFedCDFB25GpafpnUeBccHDoH0zulgN2H54x4YMT8Gmr9ENu7WGM86HisD1jMjmpCv7BaeyifPYMNnPyXP1pwW3LkRhNyVcMZ4Dzy9+Y7hzipxmfc2u8XtNO5pptD6/9PAVPZ0JIUwqWi4gP86j7GcEjO0CwsvU2GUHz9c8tWJ0177zmX2N3ii0ksXTtrJE6gf2Fxjvxj+L25pTqiLgQJlPlrAF2EAbiQ0Y0V918RT+pxC5g5El6yZYD9IJtOzK2X1M/rYADXC5tFuu/GVuJQpAOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0462.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 10:00:39 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::b0af:4c9d:2058:a344]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::b0af:4c9d:2058:a344%7])
 with mapi id 15.20.7409.038; Tue, 2 Apr 2024 10:00:39 +0000
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
Subject: [PATCH v4 11/13] staging: media: starfive: Add ISP params video device
Date: Tue,  2 Apr 2024 03:00:09 -0700
Message-Id: <20240402100011.13480-12-changhuang.liang@starfivetech.com>
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
X-MS-TrafficTypeDiagnostic: SHXPR01MB0671:EE_|SHXPR01MB0462:EE_
X-MS-Office365-Filtering-Correlation-Id: 61abdbe4-3d9a-45ad-b00a-08dc52fbc049
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wBmFJQiqYjALFV7o8z8xn4OBvmlk1D9/lBGr9pBxFequTj1r4+6dd/5aSv9g0tLgeHs687YIIxvc5nufswVujTjnV58mRNIPcuJi/voGeSZ0smT3vqV6Rx06wq9TfMnNwICPgUo9BiqGQaxTNUGUJG+JdQ6hjs53Lbe0ExGBbmUVUZjAcg/U9IyIZrVNQD9+xaYgK2t1ZccLhNvk8PDsFmZUHYUg4WXmIaonlodi+jzibmFJmsnsmRe0YCTOTgoBWfaR+NUMIE8WU4nUNI+3bSzYMBE3hQAmO5MK9Ur4kNCWZcPZKJwQX652j98TBXmYuMRvmYl30ZnVTQ82aZfDvV8CcpB3c6ZrZYcjrOVwX4E4ES+Nxq124vmYAnsp5bbS8FrJDrR7q0UAlSD2kwcbYCbZCgyLjY+yCMdslictHPwjMyIgb81TKwYjC4wDyktNVdK4BULKCp3i+vTOXY3IA9zQaY0qKR23omRxOuJ+Tkla+oWdW9G1CwevrI9pYisZR8zp52PQyO/PKSoX+HGwZzKU8IZPILKofhBkmtZdzToyAGJ8Ws1WoC0CkHayzLvPIM8mLdOM//YG6SmasE6fBrm1LXFkQ8XGanlaex5Geg5Smdq4V9AtszZVolcvti6GPjnSehe4+3igwc3/nnVNNA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(7416005)(41320700004)(366007)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uTBtORuk4tYyFG/HV+8N8sCEBH5xeq+SoBkLhg6cjDmBezUaD+gbSavIlpaC?=
 =?us-ascii?Q?sa/TJFWPacsBXi7DHU80sCR/oQ1074IOAZjN1lHRQZPpdHsZFc31yGE9P/Ao?=
 =?us-ascii?Q?S4rrhZRf8s2yCNKpTYnAf8NaERqcBm2WfPsKCLtOBIsdamH3fN/6pojETBYx?=
 =?us-ascii?Q?sTMX8PDJIcr5hgOgTLqhGKotuYgBh5s+Fwkm8fM3lgtym01pdSGL0nLn6ZGA?=
 =?us-ascii?Q?xa/j3Rkv5wM1hFdB3avl1xFBCyWiJXsiYFKZ3zeBeYIlaHoWg/SRoHjky/B1?=
 =?us-ascii?Q?gRD9JyWEyqKKCk2ePA088RpnfM/n90GvbI/3aLW2UQyDHBznJFA0vPTY85Ts?=
 =?us-ascii?Q?Fp02zo0+GEKwkQTJK2Q9IdRiPjyq6Rzh3GlZe8ogU5fwpewsJulW3zJxXgjy?=
 =?us-ascii?Q?ExmFqGUxZxvPRB2Adi+an5ARr+fguWDuf7RtSJjZLMDq9ckDvpxk3sDapS2/?=
 =?us-ascii?Q?KD9M6IKc/GMP/4Z1jnXSnLt0gQmIoUKczajpwpL6jkpgXrRAJ4/ECqExMPyN?=
 =?us-ascii?Q?elj+WVqrEUlRHAAzvB4GPmnYjWsmg4hkU2kM0c10i1pNItbP0miIyI7hUyak?=
 =?us-ascii?Q?vopdPGep9KdJCQmrNrGGjKM7uZDU3WMvEMy7b2ju8L+u20PvRWR43bu7eV39?=
 =?us-ascii?Q?Ef5kHuhtfqtDVCl+8jZHjzLhtJv1UPgFc8d3k4248T99wWmSpRcKdST73w3E?=
 =?us-ascii?Q?2SNuGGiEFjDAbM6t/P4Hgc4ua6zjaUuaF+rEZDFLBCzyGrbl/NSdKNVe+0zS?=
 =?us-ascii?Q?OdTXWUOxBOrHAmGNhqjc+0cTILNpOMZ2ysHyEBBXM45+4KChSTNZlNh4rTBG?=
 =?us-ascii?Q?RynoV4uSlX1JG0scSEQyB+cfb1QeESxA04Se65KNltpXiQA2INMUwCD6WBQU?=
 =?us-ascii?Q?ul3x17d49QePUYs94o550UmeInuiLgWUbtQ+taLvRy2tpsSaJjKtuJumZvM+?=
 =?us-ascii?Q?9AAZQYxgi3VzMafPiMd15xmgKSUHyNMnCSZ89ui7LGL0uXVz1U1f3E1OaqNI?=
 =?us-ascii?Q?ywKQERKaSc8R8GfBxkDkaIhXrFObZjg8aK9pbgoyDssJv6wuU2qRiH+VGUha?=
 =?us-ascii?Q?8MRYoe6w1gSHYU4IOwWKpi+VwyH6frz1JPuEqzyRg50VZF1tMEshYDdMa+sb?=
 =?us-ascii?Q?sKukBZLtwBr7JYGcNklxvBJnA7UouaoHJot5A+X0hRlOThkvrXr0PeXAB3Dp?=
 =?us-ascii?Q?MAtKS+rcfP7MEpsa35ylaew+VapyUG5qTlJTNff6A0TdcQgRQlXQ2PA82EQ7?=
 =?us-ascii?Q?tS8BWbzQydp8tDKnmFQKyVVSAH0D5awpLsYS8TowF3iZiJJCD5rummQanz1D?=
 =?us-ascii?Q?6T0BNpQodE+xLJnLEbQIVau/0b09c/0hoyPhx1wqBz/4V2mHYyH274OWK94v?=
 =?us-ascii?Q?VDJoMY/AfLoERDkhmQca1M+HZTMFynwMqNp6oQjkQclC3EY6YJDznDPSThdt?=
 =?us-ascii?Q?BItmbwilTcSMdFebIyxV3V6TwzeeotCtQdjBU+tQYqskYkXGiaJmQAbet/hM?=
 =?us-ascii?Q?QX2eNKzx05hEvQiQi44GfpMiYqgTHPZOeA4e9/uCql36IhlZ0JTox5Blm00I?=
 =?us-ascii?Q?08uG23JbgflLBSkDR9ac1H+duKsBQwlvAQasJq7rlwI9+Aflbiotk1y0rCUa?=
 =?us-ascii?Q?U1Nn/229kg1vv+aXEn2nrgg=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61abdbe4-3d9a-45ad-b00a-08dc52fbc049
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 10:00:39.7196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P6PebLRtqWHeYidfTBjkfZJY7vd9/hVunOSYqZ7SVIx5mdHBWpz0F6FKHTBlBMphKVZurObT6ghTwvaCF7GPHNIihLraqi08K4/5S5X+Az2ZmJNVo/ebL0pFR3Z1cw2/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0462

Add ISP params video device to write ISP parameters for 3A.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/staging/media/starfive/camss/Makefile |   2 +
 .../staging/media/starfive/camss/stf-camss.c  |  23 +-
 .../staging/media/starfive/camss/stf-camss.h  |   3 +
 .../media/starfive/camss/stf-isp-params.c     | 238 ++++++++++++++++++
 .../staging/media/starfive/camss/stf-isp.h    |   4 +
 .../staging/media/starfive/camss/stf-output.c |  83 ++++++
 .../staging/media/starfive/camss/stf-output.h |  22 ++
 7 files changed, 374 insertions(+), 1 deletion(-)
 create mode 100644 drivers/staging/media/starfive/camss/stf-isp-params.c
 create mode 100644 drivers/staging/media/starfive/camss/stf-output.c
 create mode 100644 drivers/staging/media/starfive/camss/stf-output.h

diff --git a/drivers/staging/media/starfive/camss/Makefile b/drivers/staging/media/starfive/camss/Makefile
index 411b45f3fb52..077165cbba7a 100644
--- a/drivers/staging/media/starfive/camss/Makefile
+++ b/drivers/staging/media/starfive/camss/Makefile
@@ -9,6 +9,8 @@ starfive-camss-objs += \
 		stf-capture.o \
 		stf-isp.o \
 		stf-isp-hw-ops.o \
+		stf-isp-params.o \
+		stf-output.o \
 		stf-video.o
 
 obj-$(CONFIG_VIDEO_STARFIVE_CAMSS) += starfive-camss.o
diff --git a/drivers/staging/media/starfive/camss/stf-camss.c b/drivers/staging/media/starfive/camss/stf-camss.c
index 3fe4e3332719..20eef0daccbe 100644
--- a/drivers/staging/media/starfive/camss/stf-camss.c
+++ b/drivers/staging/media/starfive/camss/stf-camss.c
@@ -127,6 +127,7 @@ static int stfcamss_register_devs(struct stfcamss *stfcamss)
 {
 	struct stf_capture *cap_yuv = &stfcamss->captures[STF_CAPTURE_YUV];
 	struct stf_capture *cap_scd = &stfcamss->captures[STF_CAPTURE_SCD];
+	struct stf_output *output = &stfcamss->output;
 	struct stf_isp_dev *isp_dev = &stfcamss->isp_dev;
 	int ret;
 
@@ -137,13 +138,20 @@ static int stfcamss_register_devs(struct stfcamss *stfcamss)
 		return ret;
 	}
 
-	ret = stf_capture_register(stfcamss, &stfcamss->v4l2_dev);
+	ret = stf_output_register(stfcamss, &stfcamss->v4l2_dev);
 	if (ret < 0) {
 		dev_err(stfcamss->dev,
 			"failed to register capture: %d\n", ret);
 		goto err_isp_unregister;
 	}
 
+	ret = stf_capture_register(stfcamss, &stfcamss->v4l2_dev);
+	if (ret < 0) {
+		dev_err(stfcamss->dev,
+			"failed to register capture: %d\n", ret);
+		goto err_out_unregister;
+	}
+
 	ret = media_create_pad_link(&isp_dev->subdev.entity, STF_ISP_PAD_SRC,
 				    &cap_yuv->video.vdev.entity, 0, 0);
 	if (ret)
@@ -158,13 +166,23 @@ static int stfcamss_register_devs(struct stfcamss *stfcamss)
 
 	cap_scd->video.source_subdev = &isp_dev->subdev;
 
+	ret = media_create_pad_link(&output->video.vdev.entity, 0,
+				    &isp_dev->subdev.entity, STF_ISP_PAD_SINK_PARAMS,
+				    0);
+	if (ret)
+		goto err_rm_links1;
+
 	return ret;
 
+err_rm_links1:
+	media_entity_remove_links(&cap_scd->video.vdev.entity);
 err_rm_links0:
 	media_entity_remove_links(&isp_dev->subdev.entity);
 	media_entity_remove_links(&cap_yuv->video.vdev.entity);
 err_cap_unregister:
 	stf_capture_unregister(stfcamss);
+err_out_unregister:
+	stf_output_unregister(stfcamss);
 err_isp_unregister:
 	stf_isp_unregister(&stfcamss->isp_dev);
 
@@ -175,14 +193,17 @@ static void stfcamss_unregister_devs(struct stfcamss *stfcamss)
 {
 	struct stf_capture *cap_yuv = &stfcamss->captures[STF_CAPTURE_YUV];
 	struct stf_capture *cap_scd = &stfcamss->captures[STF_CAPTURE_SCD];
+	struct stf_output *output = &stfcamss->output;
 	struct stf_isp_dev *isp_dev = &stfcamss->isp_dev;
 
+	media_entity_remove_links(&output->video.vdev.entity);
 	media_entity_remove_links(&isp_dev->subdev.entity);
 	media_entity_remove_links(&cap_yuv->video.vdev.entity);
 	media_entity_remove_links(&cap_scd->video.vdev.entity);
 
 	stf_isp_unregister(&stfcamss->isp_dev);
 	stf_capture_unregister(stfcamss);
+	stf_output_unregister(stfcamss);
 }
 
 static int stfcamss_subdev_notifier_bound(struct v4l2_async_notifier *async,
diff --git a/drivers/staging/media/starfive/camss/stf-camss.h b/drivers/staging/media/starfive/camss/stf-camss.h
index ae49c7031ab7..3f84f1a1e997 100644
--- a/drivers/staging/media/starfive/camss/stf-camss.h
+++ b/drivers/staging/media/starfive/camss/stf-camss.h
@@ -21,6 +21,7 @@
 #include "stf-buffer.h"
 #include "stf-isp.h"
 #include "stf-capture.h"
+#include "stf-output.h"
 
 enum stf_port_num {
 	STF_PORT_DVP = 0,
@@ -55,6 +56,7 @@ struct stfcamss {
 	struct device *dev;
 	struct stf_isp_dev isp_dev;
 	struct stf_capture captures[STF_CAPTURE_NUM];
+	struct stf_output output;
 	struct v4l2_async_notifier notifier;
 	void __iomem *syscon_base;
 	void __iomem *isp_base;
@@ -132,4 +134,5 @@ static inline void stf_syscon_reg_clear_bit(struct stfcamss *stfcamss,
 	value = ioread32(stfcamss->syscon_base + reg);
 	iowrite32(value & ~bit_mask, stfcamss->syscon_base + reg);
 }
+
 #endif /* STF_CAMSS_H */
diff --git a/drivers/staging/media/starfive/camss/stf-isp-params.c b/drivers/staging/media/starfive/camss/stf-isp-params.c
new file mode 100644
index 000000000000..dbf50f31709e
--- /dev/null
+++ b/drivers/staging/media/starfive/camss/stf-isp-params.c
@@ -0,0 +1,238 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * stf-isp-params.c
+ *
+ * StarFive Camera Subsystem - V4L2 device node
+ *
+ * Copyright (C) 2021-2023 StarFive Technology Co., Ltd.
+ */
+
+#include <media/videobuf2-dma-contig.h>
+
+#include "stf-camss.h"
+#include "stf-video.h"
+
+static inline struct stfcamss_buffer *
+to_stfcamss_buffer(struct vb2_v4l2_buffer *vbuf)
+{
+	return container_of(vbuf, struct stfcamss_buffer, vb);
+}
+
+static int stf_isp_params_queue_setup(struct vb2_queue *q,
+				      unsigned int *num_buffers,
+				      unsigned int *num_planes,
+				      unsigned int sizes[],
+				      struct device *alloc_devs[])
+{
+	*num_planes = 1;
+	sizes[0] = sizeof(struct jh7110_isp_params_buffer);
+
+	return 0;
+}
+
+static int stf_isp_params_buf_init(struct vb2_buffer *vb)
+{
+	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
+	struct stfcamss_buffer *buffer = to_stfcamss_buffer(vbuf);
+	dma_addr_t *paddr;
+
+	paddr = vb2_plane_cookie(vb, 0);
+	buffer->addr[0] = *paddr;
+	buffer->vaddr = vb2_plane_vaddr(vb, 0);
+
+	return 0;
+}
+
+static int stf_isp_params_buf_prepare(struct vb2_buffer *vb)
+{
+	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
+
+	if (sizeof(struct jh7110_isp_params_buffer) > vb2_plane_size(vb, 0))
+		return -EINVAL;
+
+	vb2_set_plane_payload(vb, 0, sizeof(struct jh7110_isp_params_buffer));
+
+	vbuf->field = V4L2_FIELD_NONE;
+
+	return 0;
+}
+
+static void stf_isp_params_buf_queue(struct vb2_buffer *vb)
+{
+	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
+	struct stfcamss_video *video = vb2_get_drv_priv(vb->vb2_queue);
+	struct stfcamss_buffer *buffer = to_stfcamss_buffer(vbuf);
+
+	video->ops->queue_buffer(video, buffer);
+}
+
+static void stf_isp_params_stop_streaming(struct vb2_queue *q)
+{
+	struct stfcamss_video *video = vb2_get_drv_priv(q);
+
+	video->ops->flush_buffers(video, VB2_BUF_STATE_ERROR);
+}
+
+static const struct vb2_ops stf_isp_params_vb2_q_ops = {
+	.queue_setup     = stf_isp_params_queue_setup,
+	.wait_prepare    = vb2_ops_wait_prepare,
+	.wait_finish     = vb2_ops_wait_finish,
+	.buf_init        = stf_isp_params_buf_init,
+	.buf_prepare     = stf_isp_params_buf_prepare,
+	.buf_queue       = stf_isp_params_buf_queue,
+	.stop_streaming  = stf_isp_params_stop_streaming,
+};
+
+static int stf_isp_params_init_format(struct stfcamss_video *video)
+{
+	video->active_fmt.fmt.meta.dataformat = V4L2_META_FMT_STF_ISP_PARAMS;
+	video->active_fmt.fmt.meta.buffersize = sizeof(struct jh7110_isp_params_buffer);
+
+	return 0;
+}
+
+static int stf_isp_params_querycap(struct file *file, void *fh,
+				   struct v4l2_capability *cap)
+{
+	strscpy(cap->driver, "starfive-camss", sizeof(cap->driver));
+	strscpy(cap->card, "Starfive Camera Subsystem", sizeof(cap->card));
+
+	return 0;
+}
+
+static int stf_isp_params_enum_fmt(struct file *file, void *priv,
+				   struct v4l2_fmtdesc *f)
+{
+	struct stfcamss_video *video = video_drvdata(file);
+
+	if (f->index > 0 || f->type != video->type)
+		return -EINVAL;
+
+	f->pixelformat = video->active_fmt.fmt.meta.dataformat;
+	return 0;
+}
+
+static int stf_isp_params_g_fmt(struct file *file, void *fh, struct v4l2_format *f)
+{
+	struct stfcamss_video *video = video_drvdata(file);
+	struct v4l2_meta_format *meta = &f->fmt.meta;
+
+	if (f->type != video->type)
+		return -EINVAL;
+
+	meta->dataformat = video->active_fmt.fmt.meta.dataformat;
+	meta->buffersize = video->active_fmt.fmt.meta.buffersize;
+
+	return 0;
+}
+
+static const struct v4l2_ioctl_ops stf_isp_params_ioctl_ops = {
+	.vidioc_querycap                = stf_isp_params_querycap,
+	.vidioc_enum_fmt_meta_out	= stf_isp_params_enum_fmt,
+	.vidioc_g_fmt_meta_out          = stf_isp_params_g_fmt,
+	.vidioc_s_fmt_meta_out          = stf_isp_params_g_fmt,
+	.vidioc_try_fmt_meta_out        = stf_isp_params_g_fmt,
+	.vidioc_reqbufs                 = vb2_ioctl_reqbufs,
+	.vidioc_querybuf                = vb2_ioctl_querybuf,
+	.vidioc_qbuf                    = vb2_ioctl_qbuf,
+	.vidioc_expbuf                  = vb2_ioctl_expbuf,
+	.vidioc_dqbuf                   = vb2_ioctl_dqbuf,
+	.vidioc_create_bufs             = vb2_ioctl_create_bufs,
+	.vidioc_prepare_buf             = vb2_ioctl_prepare_buf,
+	.vidioc_streamon                = vb2_ioctl_streamon,
+	.vidioc_streamoff               = vb2_ioctl_streamoff,
+};
+
+static const struct v4l2_file_operations stf_isp_params_fops = {
+	.owner          = THIS_MODULE,
+	.unlocked_ioctl = video_ioctl2,
+	.open           = v4l2_fh_open,
+	.release        = vb2_fop_release,
+	.poll           = vb2_fop_poll,
+	.mmap           = vb2_fop_mmap,
+	.read           = vb2_fop_read,
+};
+
+static void stf_isp_params_release(struct video_device *vdev)
+{
+	struct stfcamss_video *video = video_get_drvdata(vdev);
+
+	media_entity_cleanup(&vdev->entity);
+
+	mutex_destroy(&video->q_lock);
+	mutex_destroy(&video->lock);
+}
+
+int stf_isp_params_register(struct stfcamss_video *video,
+			    struct v4l2_device *v4l2_dev,
+			    const char *name)
+{
+	struct video_device *vdev = &video->vdev;
+	struct vb2_queue *q;
+	struct media_pad *pad = &video->pad;
+	int ret;
+
+	mutex_init(&video->q_lock);
+	mutex_init(&video->lock);
+
+	q = &video->vb2_q;
+	q->drv_priv = video;
+	q->mem_ops = &vb2_dma_contig_memops;
+	q->ops = &stf_isp_params_vb2_q_ops;
+	q->type = video->type;
+	q->io_modes = VB2_DMABUF | VB2_MMAP;
+	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
+	q->buf_struct_size = sizeof(struct stfcamss_buffer);
+	q->dev = video->stfcamss->dev;
+	q->lock = &video->q_lock;
+	q->min_queued_buffers = STFCAMSS_MIN_BUFFERS;
+	ret = vb2_queue_init(q);
+	if (ret < 0) {
+		dev_err(video->stfcamss->dev,
+			"Failed to init vb2 queue: %d\n", ret);
+		goto err_mutex_destroy;
+	}
+
+	pad->flags = MEDIA_PAD_FL_SOURCE;
+	ret = media_entity_pads_init(&vdev->entity, 1, pad);
+	if (ret < 0) {
+		dev_err(video->stfcamss->dev,
+			"Failed to init video entity: %d\n", ret);
+		goto err_mutex_destroy;
+	}
+
+	ret = stf_isp_params_init_format(video);
+	if (ret < 0) {
+		dev_err(video->stfcamss->dev,
+			"Failed to init format: %d\n", ret);
+		goto err_media_cleanup;
+	}
+	vdev->ioctl_ops = &stf_isp_params_ioctl_ops;
+	vdev->device_caps = V4L2_CAP_META_OUTPUT;
+	vdev->fops = &stf_isp_params_fops;
+	vdev->device_caps |= V4L2_CAP_STREAMING | V4L2_CAP_IO_MC;
+	vdev->vfl_dir = VFL_DIR_TX;
+	vdev->release = stf_isp_params_release;
+	vdev->v4l2_dev = v4l2_dev;
+	vdev->queue = &video->vb2_q;
+	vdev->lock = &video->lock;
+	strscpy(vdev->name, name, sizeof(vdev->name));
+
+	video_set_drvdata(vdev, video);
+
+	ret = video_register_device(vdev, VFL_TYPE_VIDEO, -1);
+	if (ret < 0) {
+		dev_err(video->stfcamss->dev,
+			"Failed to register video device: %d\n", ret);
+		goto err_media_cleanup;
+	}
+
+	return 0;
+
+err_media_cleanup:
+	media_entity_cleanup(&vdev->entity);
+err_mutex_destroy:
+	mutex_destroy(&video->lock);
+	mutex_destroy(&video->q_lock);
+	return ret;
+}
diff --git a/drivers/staging/media/starfive/camss/stf-isp.h b/drivers/staging/media/starfive/camss/stf-isp.h
index eca3ba1ade75..76ea943bfe98 100644
--- a/drivers/staging/media/starfive/camss/stf-isp.h
+++ b/drivers/staging/media/starfive/camss/stf-isp.h
@@ -474,4 +474,8 @@ void stf_set_scd_addr(struct stfcamss *stfcamss,
 		      dma_addr_t yhist_addr, dma_addr_t scd_addr,
 		      enum stf_isp_type_scd type_scd);
 
+int stf_isp_params_register(struct stfcamss_video *video,
+			    struct v4l2_device *v4l2_dev,
+			    const char *name);
+
 #endif /* STF_ISP_H */
diff --git a/drivers/staging/media/starfive/camss/stf-output.c b/drivers/staging/media/starfive/camss/stf-output.c
new file mode 100644
index 000000000000..8eaf4979cafa
--- /dev/null
+++ b/drivers/staging/media/starfive/camss/stf-output.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * StarFive Camera Subsystem - output device
+ *
+ * Copyright (C) 2023 StarFive Technology Co., Ltd.
+ */
+
+#include "stf-camss.h"
+
+static inline struct stf_output *to_stf_output(struct stfcamss_video *video)
+{
+	return container_of(video, struct stf_output, video);
+}
+
+static int stf_output_queue_buffer(struct stfcamss_video *video,
+				   struct stfcamss_buffer *buf)
+{
+	struct stf_output *output = to_stf_output(video);
+	struct stf_v_buf *v_bufs = &output->buffers;
+	unsigned long flags;
+
+	spin_lock_irqsave(&v_bufs->lock, flags);
+	stf_buf_add_ready(v_bufs, buf);
+	spin_unlock_irqrestore(&v_bufs->lock, flags);
+
+	return 0;
+}
+
+static int stf_output_flush_buffers(struct stfcamss_video *video,
+				    enum vb2_buffer_state state)
+{
+	struct stf_output *output = to_stf_output(video);
+	struct stf_v_buf *v_bufs = &output->buffers;
+	unsigned long flags;
+
+	spin_lock_irqsave(&v_bufs->lock, flags);
+	stf_buf_flush(v_bufs, state);
+	spin_unlock_irqrestore(&v_bufs->lock, flags);
+
+	return 0;
+}
+
+static const struct stfcamss_video_ops stf_output_ops = {
+	.queue_buffer = stf_output_queue_buffer,
+	.flush_buffers = stf_output_flush_buffers,
+};
+
+static void stf_output_init(struct stfcamss *stfcamss, struct stf_output *out)
+{
+	out->buffers.state = STF_OUTPUT_OFF;
+	out->buffers.buf[0] = NULL;
+	out->buffers.buf[1] = NULL;
+	out->buffers.active_buf = 0;
+	INIT_LIST_HEAD(&out->buffers.pending_bufs);
+	INIT_LIST_HEAD(&out->buffers.ready_bufs);
+	spin_lock_init(&out->buffers.lock);
+
+	out->video.stfcamss = stfcamss;
+	out->video.type = V4L2_BUF_TYPE_META_OUTPUT;
+}
+
+void stf_output_unregister(struct stfcamss *stfcamss)
+{
+	struct stf_output *output = &stfcamss->output;
+
+	if (!video_is_registered(&output->video.vdev))
+		return;
+
+	media_entity_cleanup(&output->video.vdev.entity);
+	vb2_video_unregister_device(&output->video.vdev);
+}
+
+int stf_output_register(struct stfcamss *stfcamss,
+			struct v4l2_device *v4l2_dev)
+{
+	struct stf_output *output = &stfcamss->output;
+
+	output->video.ops = &stf_output_ops;
+	stf_output_init(stfcamss, output);
+	stf_isp_params_register(&output->video, v4l2_dev, "output_params");
+
+	return 0;
+}
diff --git a/drivers/staging/media/starfive/camss/stf-output.h b/drivers/staging/media/starfive/camss/stf-output.h
new file mode 100644
index 000000000000..d3591a0b609b
--- /dev/null
+++ b/drivers/staging/media/starfive/camss/stf-output.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Starfive Camera Subsystem driver
+ *
+ * Copyright (C) 2023 StarFive Technology Co., Ltd.
+ */
+
+#ifndef STF_OUTPUT_H
+#define STF_OUTPUT_H
+
+#include "stf-video.h"
+
+struct stf_output {
+	struct stfcamss_video video;
+	struct stf_v_buf buffers;
+};
+
+int stf_output_register(struct stfcamss *stfcamss,
+			struct v4l2_device *v4l2_dev);
+void stf_output_unregister(struct stfcamss *stfcamss);
+
+#endif
-- 
2.25.1



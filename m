Return-Path: <linux-kernel+bounces-138217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C53589EE34
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFC021C21930
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E9B155759;
	Wed, 10 Apr 2024 09:10:50 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2130.outbound.protection.partner.outlook.cn [139.219.146.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8980D15531C;
	Wed, 10 Apr 2024 09:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712740249; cv=fail; b=XOwcf+u9D1DOrlJv8fyeXDb9wwfpHmBy7HkumDeC4Gx14yeonv8Ogv26I33NTLoJnOwDXELDGML+4V5r8Bg/ACrhY9OHXgBZ7+z4k/RDJ+eCoPFBe+q+zb8lxvnh3kmtQbtn+NYTHN6OsSCfzj73Hf/yQc7Ev6i0nq2Hx8LdBVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712740249; c=relaxed/simple;
	bh=OwdQ/LorckZcXWrjDDOl9kFQdK8dnOiSzf2Gi5uTgC0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ufiYOBfBrLEXEmNNBQe9O7gpuyz/62xekYrw+IJ1jw/9mGogQuzT3W38T/cDyAcTB3hW4vZ1tp+P9lia3m+jSE2lTh98hmFEQYrcE0cCF6Nl0iyvJ2HwjyJzZKrMOHZwKQrScBwezZSQiXNyJ6SNiO43jFVeMA5oerfxfjU6WDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UJFSLhF4/Dcru+8D/Qisxhdh8QvVtbauXE+IE77D+8Qko5/LijKkSGTwQGAGORm5Myd/1cIAv7NZ9Mfb47YtM3EQGDraW3Fl4Y45ULtn/EDFLyqhV5+3K9D78XAI18cmueP0MhOGQpLzpkDQ9HJD7+8/KAmXI/DtXufC0zRMKRvaAr3rr/FoW3bv86b7N/yqanEAZDxBP4+U5PZ2fxWjICNObSEj7A5IjebyXbM2EPr32C/K04kM5q2xmnvTrBT5FKZQCriLN12z4VujNEBC9jjEcgtwIGLRNOOaoBQUZtOsw4FqvPTuj6ly1V2Komr1ft2crXrLeXqbxKuGSI+JyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dyxB5oFw3XUgR3h6xDMF8CC/wX6qkIn8P0CFG0mBuYw=;
 b=MhhvVoRNlkUmc7nOoX+hSLcpDHjl4U1nOSBFbr9dNrIiKQOrgotsFCA8i0avV16OV1DFFGVQGe3gT1nWB679qEF22ZdDSSY+/QJVRC7IcMQi2YwwFmdbwXXIRz4HOzuTaNdynXbBdTd/1nlxpRGccIEDGhl2NK45xrVDF8pJhmYKbQ0kVupI5DybRS/0gkBHdpTogtSCSpWFjYkChwPPmpO2oVkmpGzpIDWipvjNxw4bdRaSrhWvDefKHGSgFdDInbsM0uTuK4FJPbbnSV8k8kg5DStN7vc3wTAPJaxOqgv2hk7+vSyaAcB/CvpkDQlzMOBk+v3eYmF/ZSqvwK193g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0461.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Wed, 10 Apr
 2024 09:10:38 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::b0af:4c9d:2058:a344]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::b0af:4c9d:2058:a344%7])
 with mapi id 15.20.7409.053; Wed, 10 Apr 2024 09:10:38 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Jack Zhu <jack.zhu@starfivetech.com>,
	Changhuang Liang <changhuang.liang@starfivetech.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: [PATCH v2 4/8] staging: media: starfive: Introduce isp_stream
Date: Wed, 10 Apr 2024 02:10:22 -0700
Message-Id: <20240410091026.50272-5-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240410091026.50272-1-changhuang.liang@starfivetech.com>
References: <20240410091026.50272-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJSPR01CA0005.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:c::17) To SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0671:EE_|SHXPR01MB0461:EE_
X-MS-Office365-Filtering-Correlation-Id: ce8b0b6c-0e33-4b97-5119-08dc593e16c3
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WX/XYEzqzz2TUIjN3akmi1UYpoAIySgqNVO9/X3PzAtMXRUQ94zgmz8ZaYWU8j88uEAbjaIqd6mxXXSJFrmAhlF0NruicH55il+5nondLGTTpMrNeKOYwV0rKJ4mT/2nEA4ECZPOgXlZHnLT+1jefo74m1ZIj3zJ6Fsi3F7eRvw+BIhHaP7dOStljBow3X7rvTR5vPend88zK/OCdRhgGzmiuz4qq84A3hYbFkfXbI8YPLLi3thGXiK6A3PA6elZ6OrXqf+OKTQOHdFxkcvsimxEJDZV6pHNA155NheDTcF7ojtZWMTuujXhBi3K3bB9eZxGpkCltPMgAr31zwc0wB9LF4/65oLuR1BhY1fxpu44+XsYfv5o9nM2qE3+ZaG5VjeyV4yrwRj/l6pBMMAgpol80jYR1pYg9s+p64MyZrq53TbmzBga6ImgJA/DZ0flJbKXRL7xOE7NZTbynaPdIwo2IQCPrK/Ld97HcMteP5UAddr9Vy3Da2VlO+TMZJ1kuTH8shur1mMlpU1t4FrstAWmuc6kHlMNeGc01MPPltr+Rk6jpE31Is2BWwTaRzisGbsVgL0CyPIHxTU7xkR1+b6H/L+cynZlVhT7bEq+qCqH2YwAyowBE2E96yoOEDlH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(52116005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SUU9J57OgfoR1qqQh1lNsB0K5FGgiPFcECsjQy5qx0JfGJYmo1Uuq/8IjiI6?=
 =?us-ascii?Q?9025iLn6jH9jFPxd/vghzYE/uP1PwX+7Vo0tXhsrspq3LOgjZHCJm7Ehuzch?=
 =?us-ascii?Q?TJZSbpq+ibkxnX6Y5yk4avC2xdzNLAwV/nNFOCFLrSCw5UMrlXnVSD5aGTfX?=
 =?us-ascii?Q?8Js1mfG3YH/NT3OfRg06K/sE/2lV0CqEnbQ5q/5gGfu+AG1E9AKQzNKw2pcG?=
 =?us-ascii?Q?R/sIzPuw6SRYcumhTWZU/jxjD6BYnA+PpVtxgZ3U5wqSwtx63FYpF/eIHxfM?=
 =?us-ascii?Q?dUbAUkEbQRgwvKskZTlCQigXHEi4giZmYv2W25mS0u8jNP+FDnrkDD3SIJiY?=
 =?us-ascii?Q?pH5VutyIoGny86jfbbXXQZWS/jpsOx9MiREdCpAigq1xRxZCoGn69lHjwa5j?=
 =?us-ascii?Q?FM14A2RQqEHtW7+ilUDO6lRKxdapU3MqYZoMwTomG1W3ICICevwF3nMyhjbe?=
 =?us-ascii?Q?oxC/vy4JqYpfxq2GcTBVV5lZeP29IvlTDzfngSiDZVXeSmR3AuCvwss3HkPE?=
 =?us-ascii?Q?aScEjm3LDgt2dA8atnXHvpZcxAO8NBW0ngGA7qYMjBIxS4epCDa7XxUvnP+h?=
 =?us-ascii?Q?fRUBB8coIHA17n6Ct0fExp3HU5LiFg/ewZdj1IcklD1iGgUNvutRxZKVeS51?=
 =?us-ascii?Q?la7EjuaiFZ46+RXx12ht70SioS6aMt05p8kThgOFsRDsuX8r3sbf6WhMyLFW?=
 =?us-ascii?Q?jqEa4kgXQ0fUJC6AMEn+T4ayjGr6c12Ck6ls8qEuSbfSBTtuBjspyYGmMpGk?=
 =?us-ascii?Q?Y/ESBFxdP+oJ4gFkSOrhGmznAJLzlJRmPvaJdFHoMVljkxT1zrIUGqOtdrlt?=
 =?us-ascii?Q?4DSj0tQAJWwk300OrgHVnaZjKpld3/eJpQ8BuZNXKVEYWPygHh/OddLuPK+1?=
 =?us-ascii?Q?E3vHkcgLRYpLuq54QWC/O2q3/ayyqwvStyRiJ0v+jypx0kxBDQI+SlYczR7j?=
 =?us-ascii?Q?FTg1pd0QvrbPyw1r5ZcRt+GvgOh/+61hgMpmDo0ZsvwRIJGVA6HRcTzoCOw/?=
 =?us-ascii?Q?FK5I/tBHiGlwbTnLCD/cEfDCaxFISPwnEexxRQL02ZToXKIHKg3d/35Kxqwi?=
 =?us-ascii?Q?ppqK6+ewgIrmoHK2XPC0lf6K3QRX6tDFRco2kfN5UmwytQaQjcbkyL+EabJ0?=
 =?us-ascii?Q?GsyuQ3UDrnOMupZMjd2hGdUxilVDt1ZhLefKTFOKVC77csyf4BOP5pUwz2xU?=
 =?us-ascii?Q?HyFq4v/cbVAMljO5/EO0YtgJVaBAmsd/fVBmjs2l7DqhImBXTuQLdTP4C1iN?=
 =?us-ascii?Q?UzOpcpRDl+AdvYosiFSYB/2BakFRD+DGyX+WF9p6Ayn1OwRdXXonBNT9szmh?=
 =?us-ascii?Q?/0+80cs1nFkO8x5Z/ThzP9mN8mK/IVJ/3JxjEb7Q/D0KQ7P67tY7b1p7/ehL?=
 =?us-ascii?Q?l96bgya8ndRzaDA6O+HYSdylGcx8+zvcH2q/RF+pk6TMylTaRH7ZpK7oBk0+?=
 =?us-ascii?Q?TOmycPPWP8DIw3afCoRrycaKHjuWuJQDGyddKsW7d6sRFRMnkbmS6EAFFzKz?=
 =?us-ascii?Q?Tn+OJIsEJwBh2s7RwH/BqwV0HzEhT3tVsjnotV8fJEIMYGgw287Jn32uZOcq?=
 =?us-ascii?Q?rOfuG2huZvZJTnPkRnnALoxMLU3pn68Gjt5+8SGU23r30p6hxRAIAN0vXU8P?=
 =?us-ascii?Q?SQ5vhYC2fKnt4bYV5icHUKM=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce8b0b6c-0e33-4b97-5119-08dc593e16c3
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 09:10:38.6084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4udbzkIUT4NxB3LjLDTbE6f/+g48+UgkNScMrtIC3dcOTyxNya7qffOmaZunU9Bd1B6AA52yt7lsr/flguIlg9J1eXKUYWDKZiSH2zPaNoT99B3sMd+Fdi/dPu2a/wk4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0461

The ISP can support multiple output streams. Introduce isp_stream to
store the number of streams.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 .../staging/media/starfive/camss/stf-camss.h  |  1 +
 .../staging/media/starfive/camss/stf-video.c  | 28 +++++++++++++++----
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/media/starfive/camss/stf-camss.h b/drivers/staging/media/starfive/camss/stf-camss.h
index 328318d61c6b..6b9215c92cfa 100644
--- a/drivers/staging/media/starfive/camss/stf-camss.h
+++ b/drivers/staging/media/starfive/camss/stf-camss.h
@@ -55,6 +55,7 @@ struct stfcamss {
 	struct media_pipeline pipe;
 	struct device *dev;
 	struct stf_isp_dev isp_dev;
+	unsigned int isp_stream;
 	struct stf_capture captures[STF_CAPTURE_NUM];
 	struct stf_output output;
 	struct v4l2_async_notifier notifier;
diff --git a/drivers/staging/media/starfive/camss/stf-video.c b/drivers/staging/media/starfive/camss/stf-video.c
index 4ca889a7b757..69e3e4f9e56b 100644
--- a/drivers/staging/media/starfive/camss/stf-video.c
+++ b/drivers/staging/media/starfive/camss/stf-video.c
@@ -295,10 +295,22 @@ static int video_start_streaming(struct vb2_queue *q, unsigned int count)
 
 	video->ops->start_streaming(video);
 
-	ret = v4l2_subdev_call(video->source_subdev, video, s_stream, true);
-	if (ret) {
-		dev_err(video->stfcamss->dev, "stream on failed\n");
-		goto err_pm_put;
+	if (video->source_subdev != &video->stfcamss->isp_dev.subdev) {
+		ret = v4l2_subdev_call(video->source_subdev, video, s_stream, true);
+		if (ret) {
+			dev_err(video->stfcamss->dev, "stream on failed\n");
+			goto err_pm_put;
+		}
+	} else {
+		if (!video->stfcamss->isp_stream) {
+			ret = v4l2_subdev_call(video->source_subdev, video, s_stream, true);
+			if (ret) {
+				dev_err(video->stfcamss->dev, "stream on failed\n");
+				goto err_pm_put;
+			}
+		}
+
+		video->stfcamss->isp_stream++;
 	}
 
 	return 0;
@@ -319,7 +331,13 @@ static void video_stop_streaming(struct vb2_queue *q)
 
 	video->ops->stop_streaming(video);
 
-	v4l2_subdev_call(video->source_subdev, video, s_stream, false);
+	if (video->source_subdev != &video->stfcamss->isp_dev.subdev) {
+		v4l2_subdev_call(video->source_subdev, video, s_stream, false);
+	} else {
+		video->stfcamss->isp_stream--;
+		if (!video->stfcamss->isp_stream)
+			v4l2_subdev_call(video->source_subdev, video, s_stream, false);
+	}
 
 	pm_runtime_put(video->stfcamss->dev);
 
-- 
2.25.1



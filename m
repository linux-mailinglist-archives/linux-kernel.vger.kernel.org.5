Return-Path: <linux-kernel+bounces-93710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A9D8733A7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4552E285439
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D6D6025D;
	Wed,  6 Mar 2024 10:08:49 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2097.outbound.protection.partner.outlook.cn [139.219.17.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E3F5F549;
	Wed,  6 Mar 2024 10:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709719728; cv=fail; b=cr/sG6KHAiltql96vSss2VvWMfsNcsh48Mx0I3MJGWDqg0pPhMaKlDqZHFCyljxJINyv94W/1GOz0yrnmKnBvD6QTqsTA6pOe9jL441JfNJ/UbSiFYvWOmtnxFdL9KF7G73qialW+a64D1UTxtOJo43ZvxhaewdugoJC0OIZXSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709719728; c=relaxed/simple;
	bh=Ag/9jm7fZlBWooHWCeXB5OWwqFPZwihKU9de3eVv2g4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IYbeTkkwDPOf3Z5VkGrhKp82VKfJWzDJCyotKq04vfVwTKT1oGRD9+8KGOkEIQo8Q2FTuF7rl59J1ocI9Ql6pwd88IV2pyGxFserIBu8bqKuDqPLt5Nef2A4nMVPFTV8IFggu5JffYAzZNfjueoYYL1Pf/5HRqKO/rk7KHpoO24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CXCgC3TtGQMYBg1xiSxmqCjQWia24Y/Yz0K98SLdig6ETZroOycmH1OZyhOl6dvYkDaN1VqaE3UfoQsC5cI2wLl5+58toKKE02RrfW+Gv0jIJ1fRCZ0kSdce8QbzEY7R1gvE657uAP4NQ7cVlwXkLIHhH/r8+j8nOCCG9IBb9TdH1Z1fp/1rnJlAmfC3bVNTTnCaRnwNAHoEo3EF+4NHMFWVwCfiaRsYW1uODQ1zU5doZ1SY13kp7xAB8/O88ZtYjzI1LnGCRltXLfehcSQhqp9dVI1s7shcigshFwZv7UGsDZLOkeBDGjI12FQF6TNNZRoCnnyAjPS9baD58oKr2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xAPstmroN5nFl6jMr8n3AzD2pk6wIBAH7OD/yrVrd9w=;
 b=RiS4pslRQpUs5zHnDC2p9iAPVC1LBy7n3YDWejYqTdIJHgUA3pzx+in9FDD9l4Dmu8sfVAX/nSMGvEul8Pf3Q6dCnWLavTdT4Nv9BLwCR33JrmeE1CyHVjWOs5ezvObp6CA0zI8tGIK7gHo0AtEUV/IXr0Tuy8Z2jrlgM7wA7jEaxuJDJTpZkGaS4ej/BXm6E5U3bAUyt+7C8JDIUUjRTMY+o8Y1UqZDIBlDqaT8eqkiDwChaZWFIEi42mjnotyzellCB7G35kPVD24iOJ+L+bbKo5pBIJ1J0B9Z8woW9MuDKB0vVNgHQvCBno8w+NQU/1LHUBTpyFac/CoVz6GVig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0765.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.51; Wed, 6 Mar
 2024 09:33:46 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::b0af:4c9d:2058:a344]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::b0af:4c9d:2058:a344%6])
 with mapi id 15.20.7249.041; Wed, 6 Mar 2024 09:33:46 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Jack Zhu <jack.zhu@starfivetech.com>,
	Changhuang Liang <changhuang.liang@starfivetech.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: [PATCH v1 4/7] staging: media: starfive: Add multi streams for ISP
Date: Wed,  6 Mar 2024 01:33:31 -0800
Message-Id: <20240306093334.9321-5-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240306093334.9321-1-changhuang.liang@starfivetech.com>
References: <20240306093334.9321-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0010.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:5::17) To SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0671:EE_|SHXPR01MB0765:EE_
X-MS-Office365-Filtering-Correlation-Id: c597e034-318f-4948-2b19-08dc3dc085cc
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	og76OOEnX5KI6Ac5SL8zUEwRepFmh+bSa0DI3k7r1gTtI4ORcZw4w003ln3bD9aZ4yxa9WmvGSThSxsCYNkWryQOekZ8+i+/t/bMYg/AO+9tuc3f6cQ1uOvbkYs38QDfBZpUKXNVLIoC06IuWjZlkEZkWf9A18flJ1cubcLJkOr1X0YmbKVk4s0O9WZzSL7TFE+1Ui3DkR20+8dj1EdZb59LRsuU8xiU2jxi8kcs5xBAWNc9fD5nGwGLY/zA0fiZnUnHO1CHeBpa+VjIFZjkk3EMybLRvlVdoPN8nlqKu/qwN18AGbjLbRDT0Vp1dpekwHbTze9seVd7r0D882zEBs7CYlOZQ/nA9g4w8f5I+CWpdahSe9ne2EodXQOUrxBppE8DA7vccXihAade3YPDClbmkTG+gISufyojoKLoS1XIrLQa0wjCyptiXpqW6wGIfBTCm8/mPrl8lqtW5Bm/FYm3PjQ6vrJOYtlkuT4nj9mJXLdRZt9TvbSi8gvMu45x04qsQ7X/si7dFWwwjTXEs0dm6QQUqfw0EV8b4Wa0R3ngkHb9XxL6T8MfkPYYSEqJ0wQMHsJMJA08ZRkWs6p+otAjE7FDMuoPN9yaTPFh6ENVHTWbnn1bEImpS2nDN+KH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tUXXXps2Rksso7CBdyufFPKBob+wxRkA/Mf5TVVYh246DOaBG8XyfV1cOLO5?=
 =?us-ascii?Q?C2mUpOmvSbODJAX7qSI+n3s1Ip3HAcs2zJtqj2RgytWV1gPZN5rKyabDu3t5?=
 =?us-ascii?Q?G2+jVLhcCAT4Fa1yxxb0zlM31NHuScNx4FDwr//Yd90CMuVNnaTEKiesEvX5?=
 =?us-ascii?Q?11KAaRmPd092ayqZp4tWK3qErV3eGbUQbAbccqLikn7QdDTBZQNKFgbkjgJL?=
 =?us-ascii?Q?4voSo0lWRbe9e6KTS8HfFQSRGwn8CfT80B1Quz3FEREyXdVpE4etYmB7zI+S?=
 =?us-ascii?Q?G5roA60PezLRNElslzHhGclgeF7Q9Dy2stG+37G1q8vmIi7rWHLpJun4CEff?=
 =?us-ascii?Q?X2YTgGMcEEJU04cHxYCQCseXvTxNsCr8RsEUs7BI/tEOqZh/xKJ+657x6gHR?=
 =?us-ascii?Q?Ohqjybstg256kTFE1gS0HJVFCJBWGId1bdssdEu6B605KQf/itUorP+R4Cpr?=
 =?us-ascii?Q?234W6wvPw5Yj296ZwmY6+cOJ1StJ/gHyhqDn0fuFdP2oQZfn/g3Sy1aRXtu7?=
 =?us-ascii?Q?CJd089koGBmM1Sx+d7v8h7h04SuuisltKZZTqZhd7LX21WJB1IKVDTwh9qK7?=
 =?us-ascii?Q?egjOXRPYKjiahpoYQ8FFe+UbV75WHSFkGBL9CX32yrBwf8kIgbTE+//XpX/t?=
 =?us-ascii?Q?IaV13ka12Cn/q+AGX5yLHuaXdJl3KPd3GauosMjSdnm/jZDKmayu9nerPl9v?=
 =?us-ascii?Q?h4rbBtG/FGRKcoMz2ILkc/Oe/7yLNTBNNv+KQ1aFO603qqIQ/k780D2w75WK?=
 =?us-ascii?Q?oUHlz90uEbavs2po9rtzRs1x/QRw2c2aWfbsIj7WDm9JGdIuBwvPx8OsUGfe?=
 =?us-ascii?Q?TwD+OTWSDBkAVCT8KQEnZFgmy+0+F/wvqtTaQt3E7fjBc5SdCmGClxPLGyvK?=
 =?us-ascii?Q?Y+n7+KzCQbVPhYyvtxFck4qnQrEvSVUF3yb7GVo07ohzX+ZlDg9S0aHVAL9H?=
 =?us-ascii?Q?WNjWy+0bX7zPA1+T3I5hidFIDBBriTuQxksP/amX3DP9pjcxTAUHI9CpteLo?=
 =?us-ascii?Q?wtgQZvH2kEt6pVyo0LqafK7wr9zyJvANVhNeH37kbAnVzNqkJDUsuxvWXxNu?=
 =?us-ascii?Q?l1xEKq5HTMLPc1XtM+h7xzn12BVbdE8gr42i6JwSn73sN5OhAU2dxVPE+cKZ?=
 =?us-ascii?Q?Vyms0OQkOwQEHJ/az4LBl3MLodJgaxeHkD2aE9Y7eOdrAe7HVl7jhK745VNT?=
 =?us-ascii?Q?JeBheG2jpyD8yqKw7W9VKosjm8oe0Fv26uioCcYC/cjBtOahCg4j4S7a6jgF?=
 =?us-ascii?Q?bNpwxikSE43hG6QHOIAMK7USEwipGYO69tXgMBxhNe7vfg9jHB4cJL7c/nzO?=
 =?us-ascii?Q?tI57WNO6GvnG655GTfk/aHDOtBzGFuj9/4dsBFtUuSByKHJzHol788yjLnKN?=
 =?us-ascii?Q?/gA+u0PN8l6P9Lo0DYHJRcr+xhAM4jH4eiEixz40OuZrue/HSBHk7+yPkSYZ?=
 =?us-ascii?Q?AMQfBEvP9un5aO4BMLouBt/T1gYAifoKBZ6xkjec3EczG5Ce+Utouthn0vPl?=
 =?us-ascii?Q?e1/FwXHg7GIAQ38tTbJnUN0RaC7Dr+SuVbR2NFN3hHnkCSsZRR9EAyFh1mWK?=
 =?us-ascii?Q?byE12wM5uohPU+OVviOxXzkYmImTBKKzTDh39BcCrbGkIU72SUpkqBDFWNCY?=
 =?us-ascii?Q?xMEmQU4zC3+e20/abugK+0A=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c597e034-318f-4948-2b19-08dc3dc085cc
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 09:33:46.8701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MAhmhPG27jV75DULtX8LM2y1BIfUtr/9J767AowYLGD818vrGppcB4PNyH9ZcKOAuXpJVItlTV6qj2h09iRCwJ9fj/buLqlOIPbHqrMm6cWATCaVDbA9vtMC2UdAWMKg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0765

ISP support multi streams output. Add stream_count to save the number
of stream on.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 .../staging/media/starfive/camss/stf-isp.c    | 28 +++++++++++++------
 .../staging/media/starfive/camss/stf-isp.h    |  1 +
 2 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/media/starfive/camss/stf-isp.c b/drivers/staging/media/starfive/camss/stf-isp.c
index 9b5745669fa6..1bfd336b14a1 100644
--- a/drivers/staging/media/starfive/camss/stf-isp.c
+++ b/drivers/staging/media/starfive/camss/stf-isp.c
@@ -92,15 +92,27 @@ static int isp_set_stream(struct v4l2_subdev *sd, int enable)
 	src = stf_isp_g_index_by_mcode(fmt_t_src, fmt_src->code);
 
 	if (enable) {
-		stf_isp_reset(isp_dev);
-		stf_isp_init_cfg(isp_dev);
-		stf_isp_settings(isp_dev, crop, fmt->code);
-		stf_isp_config_yuv_out_stride(isp_dev, crop->width,
-					      fmt_t_src->fmts[src].bpp);
-		stf_isp_stream_set(isp_dev);
-	}
+		if (!isp_dev->stream_count) {
+			stf_isp_reset(isp_dev);
+			stf_isp_init_cfg(isp_dev);
+			stf_isp_settings(isp_dev, crop, fmt->code);
+			stf_isp_config_yuv_out_stride(isp_dev, crop->width,
+						      fmt_t_src->fmts[src].bpp);
+			stf_isp_stream_set(isp_dev);
+
+			v4l2_subdev_call(isp_dev->source_subdev, video,
+					 s_stream, enable);
+		}
+
+		isp_dev->stream_count++;
+	} else {
+		isp_dev->stream_count--;
 
-	v4l2_subdev_call(isp_dev->source_subdev, video, s_stream, enable);
+		if (!isp_dev->stream_count) {
+			v4l2_subdev_call(isp_dev->source_subdev, video,
+					 s_stream, enable);
+		}
+	}
 
 	v4l2_subdev_unlock_state(sd_state);
 	return 0;
diff --git a/drivers/staging/media/starfive/camss/stf-isp.h b/drivers/staging/media/starfive/camss/stf-isp.h
index 4fc5cfac115c..30e4eb29f077 100644
--- a/drivers/staging/media/starfive/camss/stf-isp.h
+++ b/drivers/staging/media/starfive/camss/stf-isp.h
@@ -414,6 +414,7 @@ struct stf_isp_dev {
 	const struct stf_isp_format_table *formats;
 	unsigned int nformats;
 	struct v4l2_subdev *source_subdev;
+	unsigned int stream_count;
 };
 
 int stf_isp_reset(struct stf_isp_dev *isp_dev);
-- 
2.25.1



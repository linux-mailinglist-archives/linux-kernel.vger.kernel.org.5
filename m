Return-Path: <linux-kernel+bounces-99778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1A6878D26
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 03:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFA0E1F21D7C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 02:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715D3AD4B;
	Tue, 12 Mar 2024 02:45:43 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2112.outbound.protection.partner.outlook.cn [139.219.146.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A947482;
	Tue, 12 Mar 2024 02:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710211542; cv=fail; b=R3v+dUm97jCOC70/VfeXDjw/VN6sHhoQcz88jFWc5JQ9Xv5BeQEytPJRkTDpo4WZaoRc6DgskUMGdrw7KkJ/1UXo9GmXVWHXIhKW3tQQLOPRnCDUM0nsYVr8AdvvA6NVrDU6oBm7WZZkA6v8FunZFmzjeMDgjQnkAM/Blusqeuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710211542; c=relaxed/simple;
	bh=cvE1iY6j1g7PYcGYBktFyGnkuJ+N7v4wDIyPQJhKStk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=PhjhcPYICZQI18sT/1qhd87cFh4RyfyNmQrrN+gGYCPw3nVmn805QxoA+KLiJizNn3TO9aWAf2n4fqjcDtJUgTjxWiNIywALivebslwtKI8wTDTzTyMXfiOaolCu3LxtCfZISIfdlfwswwQUcwNTjG7iwqEHNDCW2KFfyge9cKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PKERtY7cEtHrlCDu3rT4GsrfaipkpbppcHFwL/cYcZEatFYG0BbUckOVcahhJc2c3qLlcTBNB/qmlXFF9UhblQWzIC4L/pDT829gjjWQX+TpkW3ba3mrBPRaLqwDen1lxRsww3a3g+CCrMyBpweCJU3fL9oApp5YCQ0SPM/P7CrUWQbQROx7562yVb+d/+Gmm9YBkWmu88Phs5Ez78iJgXjWdXzmhT8+gBP8iPMlgfXhuyuFYNPQai0Dg/dhAZORnNYhL0+kdoZQ7fnJxCJy2VnBicfs4oIKyDGDigiFXRo8QKopWLVStI/9J9Hgdv2ldCNpmJtBY9NfZnOpldqSXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iqcsnIrJ8sPmElkzWKcIofUPyC/sXNuZQb/yrEyc3wU=;
 b=g+fxLAFd20BGxjKHyecFuBISQxLhjTbGEU8hmGzUJVO1CkQrczEnqwt8WaRvG8CbGoril/yhf3u6EYmBTzfaOLntKPCIMTMxLLXp+3m5F4tP7saHuDtienBQ/RHcQeZi5ldfqH9QxaqrIcjDPtb3NOj9rfrocy+XXdQim6aLlGwHjS4IlR4qO7Y9sgz6nXaBSErKExshJDgi//xwUYKVlWTAWcmxZULbjze2nw1T83Hg9jWEO6beNYXx0+iOWCgYY80Ea4/kva45rI+EVH9pj+m1dQMNzBkixKU6o/BIHJ09/GpCpvZULr41vPYwQfx+ntXU6UpjuwJqP9Oq9/8cnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0575.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.45; Tue, 12 Mar
 2024 02:45:28 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::b0af:4c9d:2058:a344]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::b0af:4c9d:2058:a344%6])
 with mapi id 15.20.7249.041; Tue, 12 Mar 2024 02:45:28 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Jack Zhu <jack.zhu@starfivetech.com>,
	Changhuang Liang <changhuang.liang@starfivetech.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: [v1] staging: media: starfive: Clean pad selection in isp_try_format()
Date: Mon, 11 Mar 2024 19:45:20 -0700
Message-Id: <20240312024520.11022-1-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJSPR01CA0024.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:c::36) To SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0671:EE_|SHXPR01MB0575:EE_
X-MS-Office365-Filtering-Correlation-Id: ae8b754c-f47e-4c34-2d42-08dc423e79ce
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bOOaeHKFVUtIBDLw66TX1DqcaseZqYVxQAXuEq9o5xFCPjhnJgcmLrTUhU6tKWKavyXiC/mzq0G54AHcxEKmuwpcingwkKFVAogC3NApqIatQmeu8dVAw6x9rMHMSLKyOEIhIaucOHTIWjDPkXOWyKmWcRBtaiW+3VNq/9NHn6p4C2rc8n5NlQdzZoTorzm3dCIsksN8WOwKW+Ma7SF8rD3elTRYmvyV9T0kJ4ApZlJq55F0gV6vCPF75n5rG76H6fee2us8SjQu34cbtTAJ+1Vrug/rYwaFr7g/d8hIPJFy1UmNagR1bzYfKamG+J6M6BW2DkCxuXSOJJWMrF30fSTAlwLikZBLGJzmLuodOgtltkSdg8FbZV3Gwyf7t9NukR5+sMm1rK6xVL8crbPIxUly9m4w99SrEZgGpeZrNsXT4mz9jaFWtF8K9ya/Vs+YHoajCmc+UDKp+Um9USaCELv6r2HVgR8T4ZZghzyLDE7p3blYkBxq/epPlD7jibKDmNxkhNaGxac7p0wShRIg+FlNwGcQSJuz27WgTQKkQKiPZcEco0d8TUiFonEYQ4nK4qV1wAHR7pHQqdsVu+exudZTvTA36kKtp43c5WV3gwis5jLZWQNuUsHnLW/qklo/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(41320700004)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dTXd6btUGXHBFcJkKsHmQ1T9o3w96MXKJHkDrNtdyIVkdTDeBbIhZq1zEpeb?=
 =?us-ascii?Q?h4ZGf5nzOx9h2aOQqmN+E04I64nUiGaP+TBpywr3kgW+5xSF8/xj6HVpnVNY?=
 =?us-ascii?Q?YfuKkE5sVdqXB61iTe7HNk7maJ6qho95HmGEURWrzUxSyung43tIGmdcmk6p?=
 =?us-ascii?Q?bnoYTVuoxq6KOWrlxuBKjShgdjVqE1y2JMS579oJZqZayxqLakEgIdGyV5mn?=
 =?us-ascii?Q?q47uYM4CAHJ1Sih2kSRT1KbRPLLPXZu1EbmqKHEiA/KyD5tLRNMan+zH3piA?=
 =?us-ascii?Q?NtNL1TkcDS7iS674i7WSoIWh/QbX29uCGrGBjg0kYbs4JqsY+cq8FsN6ZdHW?=
 =?us-ascii?Q?neoG3TzHa8TxrpY9pHTN1Xpz3cfwnZfHfOH1devo5OqwlMPjL9rf+w29jW5y?=
 =?us-ascii?Q?4bGFlYZFukmpZYinfXcSiMwhsG2foMpTtBEiEpeQE0nr51X779Q8yaXtkG7G?=
 =?us-ascii?Q?mHKJ8Kh9puVJdFH2CLJfgdOBtc9BnAFBcpbmPZuiDN1upfvB5YagGD/scdr6?=
 =?us-ascii?Q?PBBxwqADveohtC2b5RlwH/jqZ0SYHoUaj8mtefU9oJYyYlJ5BpY0/A8df4UU?=
 =?us-ascii?Q?R97ANBqKp8cI4O6k/i5tS3IAksDaGwWxq9aDK1YPTMPk8NIZln+BgQFHWoub?=
 =?us-ascii?Q?rniUk0T3mt3lAfSzG9Oqttgln6lf7ZnIxL00Q1exGekzivfZ3doSJl50ED1j?=
 =?us-ascii?Q?YPVY6c2hgqTd525LhU55UBsHiSzgNIt1Jpb8doevbnISFKgftKuxzIdlqtWw?=
 =?us-ascii?Q?HOo8PoMp50MXCa9M+i03MteGu70YyIoCdOP8MWyUDN70I0khAeBLVuaMvDFy?=
 =?us-ascii?Q?gyaeMlZLjlvz9aYHGMePJd1e2nVqc7Zo6pRzDeUJwZR4hWjfrTqKe8XFQ0Jn?=
 =?us-ascii?Q?oQ5fO7AVXKmx4SxSELGpETDZwju5sZl6RIaF4h3CNbdyszjhHgQ73WB5+A2A?=
 =?us-ascii?Q?INPwjhGS6Bn/qL547a/LUarpfT/uwDTH8JVNsbar0syov4su6wHOZbs55bYF?=
 =?us-ascii?Q?JFsypWI4xVjHqA3BuSDTaqNH9Mq+bR5dcG7IrjZuakrzFd5ZHH9+6kUaja6V?=
 =?us-ascii?Q?iv20TvnGcSh1JpEuiWQh+XlP3knhhxE1zP65vw/ZCHq5QoPkeu1l3WptwBI8?=
 =?us-ascii?Q?SrvVFVsPhKViCXCXpf/Htk/07aFTnVM9clAh+2I/0p/jHUhROlhA9q01wJsd?=
 =?us-ascii?Q?a0iGx9BAsCZIR4yC2xoZLRwQLE1wGwJeyi90w3arWfGPmG3HuUY3lZLj3NeA?=
 =?us-ascii?Q?5Rfv0JhrNzz4c5jMEeHfTEwrKB/ffVCiaxUEHPq51ffzajCOx17NBLXje6oI?=
 =?us-ascii?Q?61OfVMFexAuY8WcqaGNJwtTK3CLKHo0Q94SbwfXbR0LTEqmnEucVLcDYJGV0?=
 =?us-ascii?Q?xji8gIMv/w5QLpmAyEkXkM9eUJZTOf+DcthI8FdHH5qC/EilfsivSYNsy35s?=
 =?us-ascii?Q?hkjkJ+BSaVglF/i34Ys7IBzRTF85SXgXFbo/zvKZd13r0jNum0+C1YBA+h93?=
 =?us-ascii?Q?sJjwFHB7MBtXlbUXMVH/OyCQ7N6xOBzohlWFXkO9t3+AQWsi2DIy5FrlSL66?=
 =?us-ascii?Q?DHtJM8iP30KoQbeDoe1+Trr0CUdD5ddwa5DQgkkauag2RkwYDpK3aYYaM5da?=
 =?us-ascii?Q?7qehTMviLmNDG7VHhF6di+w=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae8b754c-f47e-4c34-2d42-08dc423e79ce
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 02:45:28.0241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7sI19hZ/dqRU7okSDiJy3cQfb/ZrPjwpshoejwkwDqmelK7ZGCpco0BcIImbZ7ZvvPJBUzoiU6nYqgpM/pjozC7EWlg5d1anRuz5kWjYrNS9LYAiz4YyKre9vk16/5D0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0575

The code to select isp_dev->formats[] is overly complicated.  We can
just use the "pad" as the index.  This will making adding new pads
easier in future patches.  No functional change.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/staging/media/starfive/camss/stf-isp.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/media/starfive/camss/stf-isp.c b/drivers/staging/media/starfive/camss/stf-isp.c
index d50616ef351e..4e6e26736852 100644
--- a/drivers/staging/media/starfive/camss/stf-isp.c
+++ b/drivers/staging/media/starfive/camss/stf-isp.c
@@ -10,9 +10,6 @@
 
 #include "stf-camss.h"
 
-#define SINK_FORMATS_INDEX	0
-#define SOURCE_FORMATS_INDEX	1
-
 static int isp_set_selection(struct v4l2_subdev *sd,
 			     struct v4l2_subdev_state *state,
 			     struct v4l2_subdev_selection *sel);
@@ -94,10 +91,7 @@ static void isp_try_format(struct stf_isp_dev *isp_dev,
 		return;
 	}
 
-	if (pad == STF_ISP_PAD_SINK)
-		formats = &isp_dev->formats[SINK_FORMATS_INDEX];
-	else if (pad == STF_ISP_PAD_SRC)
-		formats = &isp_dev->formats[SOURCE_FORMATS_INDEX];
+	formats = &isp_dev->formats[pad];
 
 	fmt->width = clamp_t(u32, fmt->width, STFCAMSS_FRAME_MIN_WIDTH,
 			     STFCAMSS_FRAME_MAX_WIDTH);
@@ -123,7 +117,7 @@ static int isp_enum_mbus_code(struct v4l2_subdev *sd,
 		if (code->index >= ARRAY_SIZE(isp_formats_sink))
 			return -EINVAL;
 
-		formats = &isp_dev->formats[SINK_FORMATS_INDEX];
+		formats = &isp_dev->formats[code->pad];
 		code->code = formats->fmts[code->index].code;
 	} else {
 		struct v4l2_mbus_framefmt *sink_fmt;
-- 
2.25.1



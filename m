Return-Path: <linux-kernel+bounces-151334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9F58AAD1D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 12:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 610B7B21F53
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 10:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD3680619;
	Fri, 19 Apr 2024 10:54:48 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2090.outbound.protection.partner.outlook.cn [139.219.146.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B29AD51;
	Fri, 19 Apr 2024 10:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713524087; cv=fail; b=oAJetEn96REDBTHWcb2HDQXykxljon9vF2kaWDvpT9HVpYOBcQVOQFXGgcxy0FKiiUPE7U6QOOUB0ZE9u7i4KeIh9+X0VtFYby6PtBq78chyLFHzS8aG+0JgfAblhbUtWLRQkaojr5gz9eP+6kumif2AGGY9BsLNd0/e5/9K4Fw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713524087; c=relaxed/simple;
	bh=UP9/we4PHPB1X2//BiZ72LNYVHu9bnYF0MiM4U9v2BQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Uq3WPqmxUsMzoVNkxQks1nJLH/GAVJwg4GtyzVOmN+U5r78FldsHQib4kgpAbEotbOxxg1e2EqpG6TUsIGFS5v0hgVxttMA6is2Ag/WjY7qLgGM8RxYSqgtdG03fIHYHjrSmGby4MkNEsZCYG2f3zaBi5tJP1CsqhOEJSLTJutk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JanWvZwFusp5R775VdCVTXewOOhqq0gNK9H00j1pklQz5tps6Ef0qw2t/4Z+XMgNlFlkS7O5f6m/CBoF76VX3GdPZifn2SZnAZVgdYyP1FIYeQsSvW+MbYnidFTtoURwgeoUTbIdiUfawtnTAWJMnInM5bQ5Mp/iBjstUifTrVq/2oOC4PGudXIaZVzVmKSVC3BnGirSMuGFAXEi3fZtOhRsnSJm5pLiLE4He79Ud/AfTCkIsB38WwQ2cw0BGCvlQ0xsu36WEhgitUPqy+m/PnIZiltyKLkpznlztKQvr9Gvis9tQqtEdc8rG6angbF6+RAOfLE2JY6ylA3fUbAEyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=flowjzOKs0zXc10a8zGVxJW0lIwqY29xTAislxFBQlw=;
 b=XYq6zx1YXPtnb5zDDe9AFIQbbZq08K+Ze1vp/Ho2aOQ84J9L6iuAP9cCNRNqqgz73GyQefBNKFC4lKWvLIhazXrD8HkU7NsYehGQpGlCehOSHB34niQ9/JYxws0hdmBKpaLK+Vz9ucnQ7z4snMna8qstjm/TOF7JmVc1vUtQF0MJ1bxpUlRgnJ9IbNDcfnich8BSYB6x+xMoqUtzbFeM/JTxPmrs95cR97QY72tSsPBFP8IQtEnP6mbqJTgbKMV0ZOGHG4/yfpUlQ0uDxD/KmbCSkFMngOX5uhe1Aexpx+i9w0l3ZuI8laQJ81c+gyQndB1xiCdIoh3ExIDX2skobg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0847.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:24::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.43; Fri, 19 Apr
 2024 08:20:03 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::b0af:4c9d:2058:a344]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::b0af:4c9d:2058:a344%7])
 with mapi id 15.20.7409.055; Fri, 19 Apr 2024 08:20:03 +0000
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
Subject: [PATCH] staging: media: starfive: Add multiple resolution support
Date: Fri, 19 Apr 2024 01:19:55 -0700
Message-Id: <20240419081955.5140-1-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0033.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:2::8) To SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0671:EE_|SHXPR01MB0847:EE_
X-MS-Office365-Filtering-Correlation-Id: 80b4f6aa-f509-4111-f433-08dc60498316
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eGswJsF6Ecs62UaS7Yq6vj6fJN9RWxNpdXQv0LP9JUbwIXWPh+b5k96tVwi93S0z8rKUbpEf+OtTzUFFqwtitJTS8SkJv8jKiGR/P4bu3lMN6ICvUxLarS/8dbvyh0saYBxmhvG3cSG5WObp6KZC3GtLe3ZKem8cdBDLDbJLk5vyujGsdnpJ+ZXe7MuTi6wgRUyGSZwaQ753e7yvoM/4H+ywFeGYeHfchyUwmZn/ktefQOjgZtKflzAOhM0AFoFBE9Kiz17TZ5uiCiRBSoKrM+9yV5bsM3D7a1HYlH5wOlOpBE/aLMP4zi5VezocOv6QJhakUm0WtUFBHrKW5DcseQLIn9nQjwjBsNDC/MwNOiHpvsc4CLyPHAO7RRAjnMcACrIBUal/F9p3CPDboWdoyRYtl6FTI9IvIEn/UdPqv3XKaKP1iNafhNkCP6GrvyNH3h4nffysmsritlWKXwawFkTy0ROZKA/Vr2IbwOb7lLv3wMBb1nYxbaXwpeSGbfiH4meg0Eg5HCm9Wb3uUr1xKHsJLZaCCfA/N8Ln8rSlIc7r/cRIq8j8sKWnfWJEu8KYjuAZFDOcYeGH4FRkX4eWp39Yt3fy92uDmJ0WcI1PPSZLUUiOco5GGXMV56wtdL+R
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(41320700004)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mMIYneoNwmJZXa1uIQGLeV8OMGkIuAdvWkaC0+A+4gDvh6JUT5ODgt7bQdXx?=
 =?us-ascii?Q?UiH7rBkvTXX7iY4xZ5hwbXZbufBjQxnqFDs9cXO+7MTS9cUVbPY7GR6+BlPL?=
 =?us-ascii?Q?FiO5HTWYCyUxX6kzslFWJeqk262Q0LeFsMKsaDs2g9bAeXLwTCGSJKy+UagZ?=
 =?us-ascii?Q?uCSe39LrL5XZa/A3SIleLFxrgRkv+QoGsScOpHZMjxC5b75w26OahxD3T+so?=
 =?us-ascii?Q?ZuDsMLsqpHVEAtHHCKMEM1fRisdPZEsLQ0R2PG+bEa7d9sLGw4lArrPYn6XC?=
 =?us-ascii?Q?ejng1nNtk2U7YAdXuhetm0E5a3WfOyEWJkdChV2aW0Bhn4gDdRjaE/3L8BQl?=
 =?us-ascii?Q?9a2LTLLsNXsOvAMTNMz6yBiISKbwS2pYig9XwDDoUiKU/t0kYC0MAA+VoLXJ?=
 =?us-ascii?Q?RQ+JA41xet7ycFmnLUHDcvZg3cUwYrWp7IyscriziExbvdyNoD82Wxwj9lBp?=
 =?us-ascii?Q?6inPbviZUOrwKyBOSZQpPFfOzOCaNMYdwkfSGp7IvDbylu2boUOTeldxg5i8?=
 =?us-ascii?Q?1pFQjv0ZmKNpl1HwaXGB2ZRyp6r4nFpOHNt45qwH4j0yB635k0hh9oxKc4ut?=
 =?us-ascii?Q?Ym+BwV7qjJBOrOilWMKzFfuYXwKOJ/w5JFj2SwHVPO0qI5yGDdMfz0EC/0cx?=
 =?us-ascii?Q?6OsLKaUCKdTRyadlj5cqZOAymSTeohZiZrbOdbT6mSnitq9mA4DZaxJxtXBK?=
 =?us-ascii?Q?ql4Vj3n79mdJoAF7KcM7z2rNTVIwBYOe/kEwGtcCh8Qhg91lQGr0QScm3OJt?=
 =?us-ascii?Q?pCBTGz9m6XiB8ZaR/4H2hEcmy8zbW2fPxqKRxmAMTqqZtycqJY13oGYl1euI?=
 =?us-ascii?Q?GmPhI+LBIShp4WZICIV+xYqY9rVb9eSC5WgJh6+JDgntKh8TTLFDZ60MudPq?=
 =?us-ascii?Q?2k3BVXPjIMdaD7iun6zhn4DyFcGUtQcdN+WLv4Mea0j2TolB11XRUyLT7+83?=
 =?us-ascii?Q?qLarttGGd6CLaUzHkFOZ2SjkkyYzz4AdiYqSjfAF7LScQtmCuBwxZx41CtJ3?=
 =?us-ascii?Q?RVHodeBG6ZrREORUw9bUILcQzZfgPv2CHsoMWf/L18B5gYmmdaLkM0aO7xpo?=
 =?us-ascii?Q?TAfzPOWGDYOkbfM6GR7BXpXEViDhjtQHeXG9yGms5iMBEGyQ0hK2W07nHhjm?=
 =?us-ascii?Q?dtwDsnyn5L3Ij4Kd36fq9TKgcYL1iArMUQExo3EJWvG9t3rumH5tWmyuJCp9?=
 =?us-ascii?Q?t7TkFvikaj4n20oGTOtofpNPu8T1MjyCaS3Irz2ecrwCFfzc1rViKvkwTk9W?=
 =?us-ascii?Q?5cixphVctKhRt9lssaCmqYo9jdqhC2L+6WU25OhlnCJIuxrq53oMlCneh6ad?=
 =?us-ascii?Q?tMTXgvVg0G7R+YzBmTcYzm6bIMPJbJyiww8Nuwq5KynkJ7lSyu9WMgPLFpul?=
 =?us-ascii?Q?B6bzIoh8tVIDSWBBOCh9C2MLePlhZYMPd876Kh5+HAQ+WFtifSIaZm0D7b3p?=
 =?us-ascii?Q?D5jNy+95U3ryI44gzOq3XnQ8A/Qfuc+/cmlRE0qIa5v90+JVSTHlMBaJotf+?=
 =?us-ascii?Q?GiYLoMyfIeZdcObMJk8bMwD1dL+oyqG+edod7wLANS7dz++CEiCMKHOY1sZf?=
 =?us-ascii?Q?+WtU5ZAvbF4G4MaTy91ZcjydTosJciR4VsJ4n4uXiiy7v+9qUlfn1oTHvAPt?=
 =?us-ascii?Q?7PqdJjMnkh3UXfE2hsrvnF4=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80b4f6aa-f509-4111-f433-08dc60498316
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 08:20:02.9912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: REdevP97PIZS4ijQXw8u8S6QIAw2aoXosC4bJEEG6IhrnAt3R5L7Ct3EUubQUuvw9rjmnj5l6gN3r9WmER7pi3p/41DNISmE+BpP9gVbrWdAFDq6k3YGN2UqNUIhlyUL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0847

Add multiple resolution support for video "capture_raw" device. Otherwise
it will capture the wrong image data if the width is not 1920.

Fixes: e080f339c80a ("media: staging: media: starfive: camss: Add capture driver")

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/staging/media/starfive/camss/stf-capture.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/media/starfive/camss/stf-capture.c b/drivers/staging/media/starfive/camss/stf-capture.c
index ec5169e7b391..9e853ff2596a 100644
--- a/drivers/staging/media/starfive/camss/stf-capture.c
+++ b/drivers/staging/media/starfive/camss/stf-capture.c
@@ -177,9 +177,12 @@ static void stf_channel_set(struct stfcamss_video *video)
 {
 	struct stf_capture *cap = to_stf_capture(video);
 	struct stfcamss *stfcamss = cap->video.stfcamss;
+	struct v4l2_pix_format *pix;
 	u32 val;

 	if (cap->type == STF_CAPTURE_RAW) {
+		pix = &video->active_fmt.fmt.pix;
+
 		val = stf_syscon_reg_read(stfcamss, VIN_CHANNEL_SEL_EN);
 		val &= ~U0_VIN_CHANNEL_SEL_MASK;
 		val |= CHANNEL(0);
@@ -193,7 +196,7 @@ static void stf_channel_set(struct stfcamss_video *video)
 		val |= PIXEL_HEIGH_BIT_SEL(0);

 		val &= ~U0_VIN_PIX_CNT_END_MASK;
-		val |= PIX_CNT_END(IMAGE_MAX_WIDTH / 4 - 1);
+		val |= PIX_CNT_END(pix->width / 4 - 1);

 		stf_syscon_reg_write(stfcamss, VIN_INRT_PIX_CFG, val);
 	} else if (cap->type == STF_CAPTURE_YUV) {
--
2.25.1


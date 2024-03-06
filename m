Return-Path: <linux-kernel+bounces-93709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 162398733A2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 480DE1C20349
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBF95FBBF;
	Wed,  6 Mar 2024 10:08:27 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2115.outbound.protection.partner.outlook.cn [139.219.17.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496C45F875;
	Wed,  6 Mar 2024 10:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709719706; cv=fail; b=jw8tiVlaZiXy1u7HGank5sdMGLkY1SQXp3xxhxGMjreEsSlTVV0IDQjrnwSrH/Ezd6lsL21ghqXVrxc0TOl8I7k3eYIXBRUkfdQCA56rsNdeKLew7gULvxEm1+Z1zg8dVqEo9IDBNvhBAvmQkpeDsxlzxO5/RZYnBuEUp+kBiIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709719706; c=relaxed/simple;
	bh=oGjeh/iqC8qg6oK7qO5kLtJQbnNBQVPsBXYmyTvLXq0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jPt/L+KMb6uSMIetDc922qCdQ5vwOB90l5Wba1STpi9w206tzWTQVaW1n+DbIkXAL2Co9bT0S/nqfoRPINnc0sw2I16wmvmGXu0v+EhbMNgzmiI5jXHEJ66S/ULE+dMEhCDqtqayH4PMR1dVedYD4WNQTNzCbFsTPR43ZJflKGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X2noor8SsfXdxQCWxXXPJCyi+BPQGz1ZqDxf51KC1vcnip/wlKgrbpGqEhM7hnQ7GKc0iibkgoy272DAmm//v1/tkZy7KT7vU63P1SEyMhuJUI4B8N1QUQOpuEOVfaO+D4EJP1j0soOr3JRLhwbmOKYNjZlSFOws827RbhYRigaBPv9zJjfGD9UMj2JJCNk0urK1EVgjqiEIAi6DSO6m4RRsSbLg7z+arRBFJfMVPR8wGgxNaVowtYv9J5nSfUSUB3M1YoJ+/pjSmPXBPsOfzaBj2IReP20lT6PtG0HnL2zHbCZ1eAdrAb46M8mT2vUEtAOmizPNFoff5bDnMxak8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=97Q0ajJf1BXRnJXZ/rZBKBWF57BB22R4JvBABMYZvmE=;
 b=FnBnyt+puCkZpPDwMrhkvZzr+BLd1Hv6Pc2xMjdT9wWD0My5hS81pKA+dS1q+mOl7sppMcMTwBDUvSdDdySa1JgUN9IzqUu38boTsrlSZE/2Tkvzk733AHd3LdGbTSNbIUPNWIo29V3qUQTGTQzvOTykcbg8TOsqjKLPr7F4DDtXgMl/WXIUi+heEMYJ+KT3gyj5b+OtKBHSECL7jsRxdOitUjLbJylI4WFYR6o6YawrJKDEQHFivIvZUxLdalVbboojLUJXCWEAFGy3KCakGpm1QruWaca+8kFj0V7Sv12a3u955eyqf9n7tJGcSdENbcyBCHGdDmW3gx0/sjL1Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0765.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.51; Wed, 6 Mar
 2024 09:33:45 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::b0af:4c9d:2058:a344]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::b0af:4c9d:2058:a344%6])
 with mapi id 15.20.7249.041; Wed, 6 Mar 2024 09:33:45 +0000
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
Subject: [PATCH v1 3/7] staging: media: starfive: Sink rectangle set to ISP source pad
Date: Wed,  6 Mar 2024 01:33:30 -0800
Message-Id: <20240306093334.9321-4-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6b101b64-a2cc-4594-22b0-08dc3dc0851e
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5RxmvjOXBLysVi+dAQXwtl4d93vEmYUXnhWYhKMZ5dihEjyZrN+MMzFysALMQu3pzcZTn0ti96aFKj6qtNiAfr9+fWPXuTc6S8/1czzhCVbuv9gaNQ5uu+urInUOu1WnwMDoj83uOwnV7DCQqsE64XdLJr+DDN0gmAszAK1zdMjriPKTznKUu2L4PHmSeyJZ6O5VMhSsQ87y/dGsw7sLLJezOHQJfnUnP8gR6ZJ70OkDyMRtysmridXhz5tcazkxwS7UZA/Nzf6L5+6rDOf5pdZwo3aYM9d2IF5YkpWfgJWxnJ3TyiYq4xuVXayruvIEOKpFQEMJjsOU/iPGzszXgbJKzTUQBw4C8l5hfpLuemMcx4e6SgtJFdmhO3OxVw8LAkb7U1akKFNScPi4dDOkib8QpuI3L3rq1wS6M1PnsVnRydMrZBRWdfxVx21IvRjZVENQObgYAz2bLHVKYG6PYfaFVPHzPzLFxS5KEuQc3W9Gr+iT8i8umKYZFLoQtGNguONnwMyC4wumXXN0Bu3J90ZpqITcosCt0Fy3CZIYmkDq9XmhVUDkRatBqR0g7pyDwPgNaVlA20T4U6N0CwxvYWuccsOit0pciFOTIE/ydS9E2xp/1A11BOmdbK9Lu4O+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3Xqxa/lkHzp6I50MYnIz1osIkUDvdKXGQXwf7LrLbNGZzy6vg0Dw37ubd3NB?=
 =?us-ascii?Q?RS8BJJ2fxTg+vK1xG0/sQMVZ/kXM+LwSxYQS4alLmMF1rhzEW5KrdzP5Zzjm?=
 =?us-ascii?Q?K6RUFBGhbDGHvKllnPDpqU3h+CUB3FI5Fk8nvtmf7I1drK7BothwwH3IRRMN?=
 =?us-ascii?Q?9mxJMOvbIMPnc7nuxJyjfsE3pna7Ox1wguqVc+b777bbaqKjEQtQimi+IRna?=
 =?us-ascii?Q?2x5vQzGqai6hrrttBPUKpgdeMWTP6ore3tcUqaE6r1yD9CIxNSxzuWli6LJV?=
 =?us-ascii?Q?rymPK928CbovzFDxUtGItVuN7KdUlbspBexTkGIpaFMEN1k8SJT2dykGHJwf?=
 =?us-ascii?Q?iLWhs+9p1vnvWRChyWd835fTuSsp9RJidHRmc4uOmyC3vkPxPDrgf0h4EwRU?=
 =?us-ascii?Q?3ibHOuAJbAkt6v88mSvyz+6L3ZY4AjZ8j2jO7AkKunft/z1yPeewN6VauNaG?=
 =?us-ascii?Q?db5gi1XD6BOgSKSz9PQbE1I+Yp836w5y+e112p9L9RC1gBj/yv4PTY7blk0K?=
 =?us-ascii?Q?TEiAh87aV80U47UjQL3YFADZyBx/naHZ64XVdtrjy8OSRh4mi3lL1HYmFRGO?=
 =?us-ascii?Q?JFPGbTTtL4yBxXMHSw4JFpG9OBgKR/lVqoFTRB2pejY0+7UWJ0tvX79oDR7L?=
 =?us-ascii?Q?fPLb4kC4OyRyhIStuUJhvv99LT3VDGrKArgmvdRPRABAn1QssBVOZtT9mtzA?=
 =?us-ascii?Q?s0FFt6ZXMVBELbgSaET3eK5KfhWXlcXAcggugmJbxDYaxx7gV84MPxIcOYWp?=
 =?us-ascii?Q?cId64vSvNovyaHuFGpZ+sg3qJLgFvQ7JqrD8imN0+uSVHc5xZhRuE0PdCbrd?=
 =?us-ascii?Q?SVFUQWW9kpSpOJCaOshyD5wocsNebnNJoR4OIyfxXhsfiQAKsWXr6WU06PFK?=
 =?us-ascii?Q?9Jz7TpONY2hae0oR0bbUCMRef++/r90W1llrLuYl8H+RbK1hFU3GnFc3EkV+?=
 =?us-ascii?Q?O1CYbiijsdR1nqlNJCBe4ABf6MbAXY7ecwEOH3DEl0wy+1SgllUZzTjh2zz6?=
 =?us-ascii?Q?Y3jlQXN0sTokcQyePOSL+a4S6ri2W3MsbxMsJigYWVc+dKUDJqqdTzKMPwZB?=
 =?us-ascii?Q?/k07nZZfxcisyRN9+mRIWAScZl3UmIe+Y2PzxVSa/8QZUAbWQEzAv6SbAytS?=
 =?us-ascii?Q?PFiEPofnRj84vlfCIN+VmXvo+9eGlK9P66JNydv8ot/b1K9IhHvM0Zp/g8Po?=
 =?us-ascii?Q?XR8CgoFJPfbqYD81dNOaA4Vz7e5pgQPvBBRPCeTqi1Bj5Kng7JOsLLw5RZV5?=
 =?us-ascii?Q?XOPOk8pgSxQh8ZO8Jhf6CvDvJmtzSfgXezITbMuRY34VfH9zcdn4espDsWKj?=
 =?us-ascii?Q?D8CvYeErGRmrvJJ44pO+hV5XnJXa9E8TIidbms97vTCDEL3GSacQ1tiv0yiw?=
 =?us-ascii?Q?RZ6WD2IEKcvdwyX3hq4GdCuoRPN5GdfhUnsqWVenSvn6tMm832ip52sl2dt/?=
 =?us-ascii?Q?+7KkUk0hRnKrfa5yFgdRw0AbOxARXus3E/NNH8QKZ1wJutVYzEXsNUcOg79M?=
 =?us-ascii?Q?HjBemq68odfBii++g4YIgielCY4l/bFnKJgaKbxRethNcN5WCypsZgcLw7Z5?=
 =?us-ascii?Q?Gz/XHG8JxoJJajAFL9avaGxcp0vbOoxqV58KquNvj5AUKKiiU1CRNS4aNr61?=
 =?us-ascii?Q?4alzLeQMmjFnFAPcCxQiWvE=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b101b64-a2cc-4594-22b0-08dc3dc0851e
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 09:33:45.7810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bFS4z/PNE0lAq/rObLVIsIJIPUJ7HqTD/d37L6DkA6NvivHti02DZALG7TUvN6funDpK4YbGiJZdqYC8QndWGjpNaUjQsRJjdjuxtDUyk7jF237a/1gFJfLEKRqgVMZR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0765

Sink rectangle will be valid for all source pads.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/staging/media/starfive/camss/stf-isp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/starfive/camss/stf-isp.c b/drivers/staging/media/starfive/camss/stf-isp.c
index 6bab0ac23120..9b5745669fa6 100644
--- a/drivers/staging/media/starfive/camss/stf-isp.c
+++ b/drivers/staging/media/starfive/camss/stf-isp.c
@@ -88,7 +88,7 @@ static int isp_set_stream(struct v4l2_subdev *sd, int enable)
 	fmt_t_src = &isp_dev->formats[STF_ISP_PAD_SRC];
 	fmt = v4l2_subdev_state_get_format(sd_state, STF_ISP_PAD_SINK);
 	fmt_src = v4l2_subdev_state_get_format(sd_state, STF_ISP_PAD_SRC);
-	crop = v4l2_subdev_state_get_crop(sd_state, STF_ISP_PAD_SRC);
+	crop = v4l2_subdev_state_get_crop(sd_state, STF_ISP_PAD_SINK);
 	src = stf_isp_g_index_by_mcode(fmt_t_src, fmt_src->code);
 
 	if (enable) {
-- 
2.25.1



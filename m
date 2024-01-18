Return-Path: <linux-kernel+bounces-29734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E168312AD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 07:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39AF3B22195
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 06:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F5F8F7D;
	Thu, 18 Jan 2024 06:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="H6dvU8qi"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2095.outbound.protection.outlook.com [40.92.19.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D12DBA22;
	Thu, 18 Jan 2024 06:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.19.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705559103; cv=fail; b=QFUzeP8lL6TUSuj/QVO8zWiRUJX69DN9NGCZBt7/Rml9h9r8AuZ+MRL/IjY6cX84m2OjPr89UN3zoxrAidCYczwtolUoNCY5BpWCwrbkjHZBC8D+jUdaQkIqY84m5TyH0CQ4UaCvZ02k1AJPG0ZcI3HJqstD+oQ8evuvQsybX5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705559103; c=relaxed/simple;
	bh=XLXOWA0XJCa6qno88mdJTSXp5aEo5wNCdkRNtd+gIHs=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 Content-Transfer-Encoding:Content-Type:X-TMN:X-ClientProxiedBy:
	 X-Microsoft-Original-Message-ID:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=OUZZeST6Z63IR6agaqEMy3BB/k2KT/f7V6KuenFRQpkDiZ4SLD5SzKRcevGiH9Ub6IIx94x9d8Z/e/fwEel3AkFa90EGrrPg8Q7u1IfJuAQedCJ8KKgeVAe6FLlbdK+EeUIPzJxzx2x+Q9eGtied5OG41j+T2gxNkaMd471eokU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=H6dvU8qi; arc=fail smtp.client-ip=40.92.19.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OhPTnUZDf6gthA61WyVbBEsY1HClxfQBQtdRf3MgDJui03+YpGHgSC/zGqGZ8h0c+xCGikNnFMF4awQzHOmm7L4KjQJv5pDzZzG5yNflkmW8uR0wQTUqTel6/jaPXpKlZzfRqtZGyRPn7c8jmNiNGn1Ss5VXa4C/2Q8eSs7LLlViPy/zHk2y6cRuHo31XN2NWr+hA0rv0auL5y/yTEjLFaqOwPrQo99PYfD1zFY94LIfzcOsZ2pZpiScH7KDxFDH31M9B4ftajZiLhezzo7DLgVmCIDeMnlbduwDgQTnUVQ0pUJvZP4EWoEVDaHzGZni2Tnz/Ffir9EsMfuMyzGQ7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gx9kwoCqci77bV09jm8OB6UsZgP2ClNJMF3niEXcBA8=;
 b=gerJWo0e+ZAi13UmAhiBBytQy0oUaHGwjMOn0hTo1z7vwUlbAkxBzvMojKtWslCSNgA1Bl/kUiacarzlWv3ryuBKBHbROHQL74JUFj9Q9FTI0Tsber0HUk0PTJGdSFOpEWkv+cNWcxgKdfjVS3mDmnzMQpIAWjHCQ2LAc5N3RNFiUnU2x1lLWsfDLW6OP66yv8MJVTps2rX65dJzFXyEa9NLud5uz09npMsFMH9IYpo9C7kqbRIt9pGgxo8LahosxsefxCB7HOJw6LPD2G0HnpIGvWSeSV1nkoK5uP1rhbmw9UwIJRthV/jvQvPsjJQrYSnuyDvOUIjQt6e3YSt2QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gx9kwoCqci77bV09jm8OB6UsZgP2ClNJMF3niEXcBA8=;
 b=H6dvU8qijF1pfNU1r+kkk9DGASUidnXswo3qayjFEY/ZabjTrs6lPHrcPhhmfOxZMz1SFcyjo9mpREW1cGsXGQiB72inr/WmrGvxWQvWXiZB3SRhkmygVzznSYVQqLq1Y9ZRMvklaPaw/S4nhmAmuAVOXRiGI+YE50neJIkAaG6ZIZz+WbzkOg2t7MS/AtzRGhL8ih17y/cWPcB9wNIT7ZFzvdzahwKqZ+VSXQqPgBGdTc6Zgm1TA5qXw3rbYIqpbT986b4DicGSh6czije1R7sXET2VISQHw6Isie3DclJXxpnbOOGOBzCE90vU8CHavimDXDASW/V8s4yq3kRYJA==
Received: from PH7PR20MB5925.namprd20.prod.outlook.com (2603:10b6:510:27f::21)
 by CH3PR20MB7418.namprd20.prod.outlook.com (2603:10b6:610:1dd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Thu, 18 Jan
 2024 06:24:59 +0000
Received: from PH7PR20MB5925.namprd20.prod.outlook.com
 ([fe80::e1de:29a8:e090:5b7b]) by PH7PR20MB5925.namprd20.prod.outlook.com
 ([fe80::e1de:29a8:e090:5b7b%4]) with mapi id 15.20.7202.020; Thu, 18 Jan 2024
 06:24:59 +0000
From: Fullway Wang <fullwaywang@outlook.com>
To: deller@gmx.de,
	tzimmermann@suse.de,
	sam@ravnborg.org,
	javierm@redhat.com
Cc: linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	fullwaywang@tencent.com,
	Fullway Wang <fullwaywang@outlook.com>
Subject: [PATCH] video: fbdev: sis: Error out if pixclock equals zero
Date: Thu, 18 Jan 2024 14:24:43 +0800
Message-ID:
 <PH7PR20MB5925C492B7F8CDACB2386DB4BF712@PH7PR20MB5925.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [9M1jzjP0DiI6qoFzPnwvoKV9ytJ8cDa3]
X-ClientProxiedBy: SI1PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::6) To PH7PR20MB5925.namprd20.prod.outlook.com
 (2603:10b6:510:27f::21)
X-Microsoft-Original-Message-ID:
 <20240118062443.14970-1-fullwaywang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR20MB5925:EE_|CH3PR20MB7418:EE_
X-MS-Office365-Filtering-Correlation-Id: f8d05777-0087-456b-e6e5-08dc17ee323c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Jz63IS7enfUxD9X50rG6+jvGQXH3HbNZfFE9n2CE52JKyv+bGsbYbjpQh+sB2V4yqVGkngcI2BGmJ8wj56fDbh2onNfkPgkeU9yuElaloOkFGq0/yBJDV3gpC5Woyh/YG2NJM9NG1sY08c4/mzMc1y29cmB/uyi7ZFmffDhCj02iK/PV8VMAtq47vMwUihhsH31yk+ffmQGXW9aKrvn8fkK0bEzUeBEp7SKhP14kUv/V53BjiLZgzVKCqfEQddQZITbcA1HfmQXBxUvpqvD2JFpLoKFlzhx6LiLr+mXx0lecp+8nOc4Vo7GQ8npUMa/6fwLwQX4CgrkbSu9YKL0imcdM80WU5FTN/Yb3n8zPPyrN8IikoJhVLzlZcmK2l13zDtHss2VAYpMAJi5oqlydKQotGTjKZRWaymShqyNuiO21bMF8yw/amzNDUDr130bGi+oqiDWVTIJPqr0OEiGZJfEdQKizfMw5mjz5W9T6qH0fn1pywsEQO775L79Lz244gqrPvSq49l6U5UWJxNKNyQW+xKXPCQ+ck6BPiQyzrJexENVO/AfbTLnY6NN9Szjb/h4yEtjom/ZaDo//DVGeLdv7Q0mQE2KQkAozPBtJ+mFF3fyHS1FluXcXlu2I7fIB
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dXuSiSW6WriQrcd/Wy6IDP9ctYscaGNAABPiyE/knJSS2EpTXcmeyPvFa6mM?=
 =?us-ascii?Q?6gpxPBwNhnABEGqZhMYF0k50DUTCRDbEWC46gNwXcYtWeqiYRtWIxZJ9HL+I?=
 =?us-ascii?Q?tDaw7WahDvlkE4n8F+wrVtu6UWZPZYx9eBh+YTraARY1qw6b2wS3XocIXS81?=
 =?us-ascii?Q?vadwHJyVIxD2vuQY6xtI3Nyrj0J0ghYc/el6HrOjypj3bklSvzZCrv8rLe+r?=
 =?us-ascii?Q?zhXrELMd095wTWJntKMU4gZ/EDY05lfde5Mugl4sl5Ww+K9+V/1N+mutROIF?=
 =?us-ascii?Q?Orwi78mEIKP1BTdnK9X+IOcGMeEI6IVu+FmRZApH6dcUJME3aEJW45eQJ5bP?=
 =?us-ascii?Q?fLLbeMPrFuSwzykFFcgkeZnSj3YPk+EAq1SGL8FgQLKkEXZ8DqCSKe4P3rtB?=
 =?us-ascii?Q?EpyEe7coAnT9/WtNYcxpmbehYbsWL+uwn/2Dft96vb1ejfO/p30pJZLExq96?=
 =?us-ascii?Q?F+/d31ISolAiUckb5i6ePdUlgcRvuQbMWQZvzAzduW+mdzA2vOTOZsAzER+V?=
 =?us-ascii?Q?meT31SrSMev2OvQ+apQTDiH4I/uDwesGMByc8CAcEIip9jpOr5sNPrFV5xqR?=
 =?us-ascii?Q?+qb62ETwmT+brdCxbGcr1mktUyfyDzeDP7kkJ+JULSVnWbGstS5pNS6KGeMg?=
 =?us-ascii?Q?ugJkIv5KBP57Wz+IUaJGe/A36J2nIde8YxvAAEwPEki6aw5EbmnGRQ8+/DJ6?=
 =?us-ascii?Q?ziSrvx+ohu5KRGfSogrc7ABe7IpRkyDJjUXq5KyZDqXjZY6nO5NduYdWDqa2?=
 =?us-ascii?Q?08itFqcvLO8XfO3NH66mY4Y4kGXNUoNbXHREFrfoCbiL1oyXnm0t8KRVNnvI?=
 =?us-ascii?Q?Q6rBBDyVdnNLNHCc8j+fhjtdHFqgYqbMW+QTFPIuMSgON7BmQ8u47zb1xelc?=
 =?us-ascii?Q?mvXT3XEDmoyHJUUoimMPamIzTnpPVtzRbdN94pD93cb1FVQUgYsJ9/KlQpYz?=
 =?us-ascii?Q?ZGzhUuqyPzTZYoZB2JHYuHXglnQVYuELemFFAyrvuExGVMAECxMck3phBqOr?=
 =?us-ascii?Q?mSfQGzS4vp5OjjXQ9Snc+Ce02jDfb6lffKxxAngLGsmuA2Jux6jF74xn1PyM?=
 =?us-ascii?Q?L7zhmxEZI3E9hcO3UAg9qJDDyu4EHcKOsOM11hDoPl9nRFpRcPOnnSL3mDV9?=
 =?us-ascii?Q?3EKZjUxVZgJ2lPUCmC1tgMFeJjkw2itx5LtLiwUuB1bc9dVDdy1H1D7yHkVt?=
 =?us-ascii?Q?9koqCZYvrjp4kTFrAqSc5Z924zyPhIUls3iamznm771bh996D7sWj4i2gR4?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8d05777-0087-456b-e6e5-08dc17ee323c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR20MB5925.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 06:24:59.7373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR20MB7418

The userspace program could pass any values to the driver through
ioctl() interface. If the driver doesn't check the value of pixclock,
it may cause divide-by-zero error.

In sisfb_check_var(), var->pixclock is used as a divisor to caculate
drate before it is checked against zero. Fix this by checking it
at the beginning.

This is similar to CVE-2022-3061 in i740fb which was fixed by
commit 15cf0b8.

Signed-off-by: Fullway Wang <fullwaywang@outlook.com>
---
 drivers/video/fbdev/sis/sis_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/sis/sis_main.c b/drivers/video/fbdev/sis/sis_main.c
index 803ccb6aa479..009bf1d92644 100644
--- a/drivers/video/fbdev/sis/sis_main.c
+++ b/drivers/video/fbdev/sis/sis_main.c
@@ -1444,6 +1444,8 @@ sisfb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 
 	vtotal = var->upper_margin + var->lower_margin + var->vsync_len;
 
+	if (!var->pixclock)
+		return -EINVAL;
 	pixclock = var->pixclock;
 
 	if((var->vmode & FB_VMODE_MASK) == FB_VMODE_NONINTERLACED) {
-- 
2.39.3 (Apple Git-145)



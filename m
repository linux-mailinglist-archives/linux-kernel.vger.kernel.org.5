Return-Path: <linux-kernel+bounces-29687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 876BC8311B7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 04:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37A552834B2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 03:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CCA9442;
	Thu, 18 Jan 2024 03:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Zw/tFz2w"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04olkn2023.outbound.protection.outlook.com [40.92.45.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CF88F40;
	Thu, 18 Jan 2024 03:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.45.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705548026; cv=fail; b=oLL1GBerM8imdnYIRxvhnVh87j63Y9vsuyElxGz/Pwn76ydwHqUK2Duq5NjoWnUi7ZU/IF9jtGXm3LeNQeZrmJwBXfrLIZ4CpTrT7O4CAwtCxK3ydTyV28oR+qgyO31yhhabl6plt2wA/EYmRe6mrX+vBFOC1J0JfzcQJLWYrlg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705548026; c=relaxed/simple;
	bh=Ka6armkSN2Vftom6ci/ifYOQq0xOWlxvL3E2bGJKSiw=;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=eRsizJ24z5il7Jna1tLqxDVCuFQa65Kbf0HkpKFzXGOpidcS6xfaU5QcA+sqySyD/disUPcw/2JYFfw00N2a+20ewjE80QAJgOQ7V+EFLFjT5EUYlCGE5SPDqGCD0RRvo4onWGpWNlYoAt7YYq3md4PYLqTDTpPAjEwR0zDgxH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Zw/tFz2w; arc=fail smtp.client-ip=40.92.45.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UkM9b/xROQD/saMLP/7qaH3QGd5bfRD5FRRGoB5LFO8RDggLxibArsv4yVb7L8qOHnffsX15l6c+8Ct85um0IdfDLhsLSfqJtrtpp/guY/Klub9XNlMT9u8Z2w5PQkCKDxN0dovngRtJr+lAHXwfdMHWImO3PMXbNMyUr/Z7e6SNaK2WQRmHCmNyfvqlvVbe6tLzu87DtLOXQUDxhPVfwqkwfcKKqoTpQKoLCiJXVs5iu/KMWr+ErHpkoTDVYM6vnIYJeG/WvhtVj8O9+/Yw5ZKCxhsAYWB8EEqwGxljDI1rUh20qewjo9+NZyh/zUCAdnm8yqCLSfvZMZZWsFFUmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VPgx4Fxl3xnyDneE2sVD7T2pI258zNYPp7fBsUT3RcM=;
 b=HtAUiDee0kix2/BoSj8cnKcg0l5tnzoeWUnlukwrj8MR4HvM5Qh6kJXuoPJ09VOdVQ3JZBfBdi3tfCpkiikXdE6lTyb6yWvTuZjy5anmwPZZYVvGUd2+kwBJanL0Q/H7wenq0TF+WMzcf+CbYjYavMTMAEy/euHOaEmj2q9vNYnli6FVw/YEBv0oy+676St0cnX0TJK2Vg754wA4iAL3XQY/vRz1TbM7crWvhpnHBF+ZdVGx6Ut1N37rKXzkOQ1JZ71u6VzjkbkDFOLScmAzI5uXQ1RF5++yxavyJyXGPnSTHJaORRBo30Q/YefleSq3tcOW6O/TZXBqjzFD0gxqzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VPgx4Fxl3xnyDneE2sVD7T2pI258zNYPp7fBsUT3RcM=;
 b=Zw/tFz2wYU+3HctFLfCNq2rBqI7JHUzOwMGyYnzGqjHlIJe1xSJcGGJ1YBhjFgk0cMbXpOwUB1CMt5Rw1g/B+GHk+5YOxCo++mB94dAGmQvAkmCbGK9PXbgAC+Du1s6luYr6rgPe1jO2m1dHVQJMD5qIyQVBPJ8Uy15cFi9JI4uvX0+Od5YQNoslaq+xZ/8dnJLJrytQwTzvozMcC2pnMzO3vCaOM5c7h2Bo36R5qgprnUO5sc3PZ1MA2HBh3tmzF87rMKcPTxnXZcy9BMkyTGhQi00sZIniqSz3z7kLPszwqSzFHPtVhhTCCSxcS28HIPaRvJju6jnpVhFO3/8c3Q==
Received: from PH7PR20MB5925.namprd20.prod.outlook.com (2603:10b6:510:27f::21)
 by LV8PR20MB7289.namprd20.prod.outlook.com (2603:10b6:408:222::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 03:20:22 +0000
Received: from PH7PR20MB5925.namprd20.prod.outlook.com
 ([fe80::e1de:29a8:e090:5b7b]) by PH7PR20MB5925.namprd20.prod.outlook.com
 ([fe80::e1de:29a8:e090:5b7b%4]) with mapi id 15.20.7202.020; Thu, 18 Jan 2024
 03:20:22 +0000
From: Fullway Wang <fullwaywang@outlook.com>
To: bootc@bootc.net,
	martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	fullwaywang@tencent.com,
	Fullway Wang <fullwaywang@outlook.com>
Subject: [PATCH] target: sbp: integer overflow and potential memory corruption
Date: Thu, 18 Jan 2024 11:19:59 +0800
Message-ID:
 <PH7PR20MB59258C767EF853A54273B3A7BF712@PH7PR20MB5925.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [NAB0d/mhuhnROt/NMMxu0JpLVw2WwJos]
X-ClientProxiedBy: SI2P153CA0035.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::14) To PH7PR20MB5925.namprd20.prod.outlook.com
 (2603:10b6:510:27f::21)
X-Microsoft-Original-Message-ID:
 <20240118031959.10718-1-fullwaywang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR20MB5925:EE_|LV8PR20MB7289:EE_
X-MS-Office365-Filtering-Correlation-Id: ffaa856a-3910-43e8-b0f4-08dc17d4675f
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VSi8w5XzqJSI3lBVZEUriD5yxt4qJ97CJyEQOzjG6daxQcHd7bKRf5aEdqg6ty5N3El8mMH0P6p0tqRfhbRoz1nfjNRLWlC9jqLjVEhVzAja5Tw3s9TL4qFCwSmjG0X9qI2iIR7rqwfdjUG62P2UG2cggul1heJ2K4UKgIOtXkMrnY72GYH7x0W26rEP1aRIvi0aJriuOVuMKy6At2Mnzw3ihnUVrEBMAEbpZLQyjXcXqMkg7lrF+ZZhA8cpQ7cuEm0xEJe97+jVPDLEJZuPiZI/o+isx0WDZU1ZEj8g2H+4Y8Rf3V4nK82ZgiuxcRu/UOhI5FtGgykSoM0aG8fC3wVRR8TyaBPbFtdeGflnRg2Bx8TQK32x1QEXkB19ATUJrPxqwKj/JMFVAce93nu5DYUnuZLVIAMhAEQB/MfugpvK019fPfiPWx36RX5sEenSLWWqhgMzyYUcytFZw+RaQDFh8nGQfz7obIa9Io7uYsQj9g6NriEjkDBfSvHPsGub+ZpOArtw1lsmncTkwyV5Mv8PdiTe11//Wde53zg4W+slHhOMJ/Vqm4b6mLxZHpwl5EeZqiKxd0V8GUYFgut/vVqbKz9PjXkQYBrV5OHqizUlzImjC5iDs8EcDpoSjokm
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w+f9LaEoNzlSxqBaziwnjKQpwq9Hns69ZQXppwzrIF3qp4IAlHPMVELj9D93?=
 =?us-ascii?Q?ZkB6dQH/xH1WBH95KhHqGGvW55EN4iCHS5k1F2EVWRASYs8N577VjWfVBGBG?=
 =?us-ascii?Q?xecnV9u7Df8OHaIItjBZl2+DVrnQRs1gV1TPYvvxWlYjBXyONN7GCUCPOH7/?=
 =?us-ascii?Q?z9k4MH/nOzTAXErVVvrtpv+SJ61j8rFlMNfQkRyccf6XnjVE74ViOYDJkg5m?=
 =?us-ascii?Q?NUyFUcoliALyNuRLOwu950LBVvwdFQvZILkqJC4+CQ9aMSEj3i05/gxt9GXr?=
 =?us-ascii?Q?0SJGTymh3CvahQEgGdDSHHs5V2AS/aDfk1tgUPw0+Eky+LE9l0R+3i4enzqo?=
 =?us-ascii?Q?vsY3DjB7NUvt5MPQtQE+uHDSNfUoRc6lnyugdPhHfZqRqwpo7GlaFkMWosj3?=
 =?us-ascii?Q?q8cDwflHdmPc/GAhp+Je30818zkXOV1daAUEv1HjVErwHgtX1TQ2JIw9/p5C?=
 =?us-ascii?Q?PibtUxMc7nNVdELpQvion5wnXYz9oemeHOJJ2MfoffCpXw9GugnrrRINJHlU?=
 =?us-ascii?Q?VSckGRxMJtn04oMbZ/s+XzxP9tD2hxhIg0cWRUYKdbACOH3tzAk0Uuezj8N4?=
 =?us-ascii?Q?3VTiKCpls6ZyhuPmkqddRvBYy+pYX4T3Fv9Z+cMzuKyRAlku3cLT+2UhVetT?=
 =?us-ascii?Q?ZLa1ksyEBgya2R9Na3i528l+CUul3ax2ijhiDCSLRreNj9fqgSXww/Qzu6LU?=
 =?us-ascii?Q?OXwOlnEsJEBL9B2F2UWRhRfZvY5EVQFf1I/Ovwa/3QldABMJwLQ1zlatNv9Y?=
 =?us-ascii?Q?XadT++b2FVwmPLs0aR6REshMJpMY/U+bh6WH+Vh2Y6XFFow5RA5zZednXxb0?=
 =?us-ascii?Q?bzS1o3J4V1bRZn5JG7fqkQTvljVGtQxgIk8IgauZD5ho3SiM6WL/9jfpPwKy?=
 =?us-ascii?Q?t9QbxWPf7svlcvkQGBZiI6NDdh//bbXWrRU4tqqnQ7wk/k/uZBB+gz5kOuX3?=
 =?us-ascii?Q?xj9wvCSDCO9IF8Ic0IPYKSGgywGK4gZ89eLWfONVNZsZ9tFTgWVdev/d6pHG?=
 =?us-ascii?Q?T+SL3Sakqq9jnPlu9QTcWDQwe3wj9jfTwtfCtZ12+l42SCTRFaoPtsxZtsjU?=
 =?us-ascii?Q?HcD11DvZkgZ8SMChJJeqg9I9VD4eyjGW6CTBXELHI3/9Rx5r0XLvXqoqjPY8?=
 =?us-ascii?Q?a+wif4NPOQpXz+S7Bf0l42pK7YDOce+dlQ5vZtk9LCWPQsV5yA5W4eGD/O5l?=
 =?us-ascii?Q?LKiE0Q4db2AUXD2st3FXhoEnRMD45pX2f3RWBn0YRkFWPt4o+yVLCsIM30k?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffaa856a-3910-43e8-b0f4-08dc17d4675f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR20MB5925.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 03:20:21.8274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR20MB7289

The code in sbp_make_tpg() is confusing because tpgt was limited
to UINT_MAX but the datatype of tpg->tport_tpgt is actually u16.
Correctly fix the data type problem to avoid integer overflow.

This is similar to CVE-2015-4036 in the sense that sbp is a clone
of vhost/scsi, and the bug was inherited but never fixed.

Signed-off-by: Fullway Wang <fullwaywang@outlook.com>
---
 drivers/target/sbp/sbp_target.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/target/sbp/sbp_target.c b/drivers/target/sbp/sbp_target.c
index b604fcae21e1..1ba742ee48b0 100644
--- a/drivers/target/sbp/sbp_target.c
+++ b/drivers/target/sbp/sbp_target.c
@@ -43,6 +43,7 @@ static const u32 sbp_unit_directory_template[] = {
 };
 
 #define SESSION_MAINTENANCE_INTERVAL HZ
+#define SBP_MAX_TARGET	256
 
 static atomic_t login_id = ATOMIC_INIT(0);
 
@@ -1961,12 +1962,12 @@ static struct se_portal_group *sbp_make_tpg(struct se_wwn *wwn,
 		container_of(wwn, struct sbp_tport, tport_wwn);
 
 	struct sbp_tpg *tpg;
-	unsigned long tpgt;
+	u16 tpgt;
 	int ret;
 
 	if (strstr(name, "tpgt_") != name)
 		return ERR_PTR(-EINVAL);
-	if (kstrtoul(name + 5, 10, &tpgt) || tpgt > UINT_MAX)
+	if (kstrtou16(name + 5, 10, &tpgt) || tpgt >= SBP_MAX_TARGET)
 		return ERR_PTR(-EINVAL);
 
 	if (tport->tpg) {
-- 
2.39.3 (Apple Git-145)



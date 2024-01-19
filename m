Return-Path: <linux-kernel+bounces-30992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9C0832737
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 11:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73B1A2854E5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 10:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779593C46D;
	Fri, 19 Jan 2024 10:04:51 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2077.outbound.protection.partner.outlook.cn [139.219.146.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AE13CF48;
	Fri, 19 Jan 2024 10:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705658690; cv=fail; b=GUHWN01nz7Qla6G8D3JYc0HTFQKn1k6fACJQ4SykQ+9N4AXEMlnwZbS0JZGhXckDtZFcqLTVPbQHBce+0pRIDKzE6gRCsiH2JEO6GSXu2cnASllZhMYiR9+ZdtGz2801QPiw7la8CpkzAjhE++cC+CcwdxtQHxWQsNcb85+Kkq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705658690; c=relaxed/simple;
	bh=JvM2TnLMJqemG/ss0T5f+1QkF//6fjRt4DImr7AwVuI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=oLaee09sfOzN7riQYPIcSNbBcq8kb174yNiNeN3ZYuO3P64GIZlNGx8csYJcruPTzUodQsp7lNPVK2T+0nS7fLVIxAMngv9Nqs3fAuZhdizYmRM9uO3YSZuxerYMaGVM+M6ffRrPjcKqN2fVMw/dbTDKDjwMVUitPnSxqVwVK94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a6D+XG6QuoaDvQSFmW4R/203jTTQmpJGdniSdzJceqqIK5VBSY2rXwUwZ+juVE3U6WXUogzOlz9AGaCRCdK+uo7uQGqnHJjgxUkf7CuKV5631GObTvr6cQUukOhOz/4oVtBKtZCG1/nSsUIf99htGqBQNT1BguGElnO7dCeBUn+gZu4Ofdzaxszqwq4UZTqWMH4bEQM5KfhbqYRqjMY07o96xGMA5mErpWRdpb9M3APG93qsvwkNrUR0vS+Fsx3s9WSc6+kbalepbyn+ymGw2xWU+Zh6RRDffHi2XE6ZHFMn0WwnKkECRHLkCGudLuIUtNwxz3zJr9SG0auzNce+dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sb3kU7bz2UqiQTqnmPL8Qn2dRS3LwgbpCk8/GDJppW8=;
 b=N07/TwHEMLa68qCy5M8iyw6uW0csxnXQSz8c0b3nsZbVsRHLMgs91ntDAo5f+OmBwTqYap6oJhY9kO9b5naMHDE0vMpzw96kuOnkwtlURoawt1/ZpRiuRFgcLM2noOP+aXE0rPU4rcS0Y0xlwHNRGGRQAAVxifi55UyuEnM9d21+qlvfLDJjeRcMjXjuuDmkITZjFXF54cuhgFAF89ACgIpJyHNhp7iaWBVmyUUXllTe3vfZvvR/g653ah/94U/HsoYppfz5n+M2cvWjpgzq+BOaAAJWMUsIVl/4mzBL2QTrjSPRvhcFVopq4EgN6k9vgFpsNp8n/+jIfyORrKvwtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:19::6) by ZQ0PR01MB1045.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.30; Fri, 19 Jan
 2024 08:29:28 +0000
Received: from ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn
 ([fe80::1dbb:b090:7d89:4e22]) by
 ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn ([fe80::1dbb:b090:7d89:4e22%4])
 with mapi id 15.20.7181.032; Fri, 19 Jan 2024 08:29:28 +0000
From: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
To: Xingyu Wu <xingyu.wu@starfivetech.com>,
	Samin Guo <samin.guo@starfivetech.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] watchdog: starfive: Check pm_runtime_enabled() before decrementing usage counter
Date: Fri, 19 Jan 2024 16:27:21 +0800
Message-ID: <20240119082722.1133024-1-jisheng.teoh@starfivetech.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0060.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::27) To ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:19::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB1160:EE_|ZQ0PR01MB1045:EE_
X-MS-Office365-Filtering-Correlation-Id: 87153ce2-c8d4-4f31-4279-08dc18c8c06a
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Oo6P6RzX6IZ0spIeyu9oWfM0OSlRWV0+a2Vhn+yPn6CIyixjv5FjUdAyKr2XRbpcnrepMdCJU44gisqFGl9sgpiYWPhZT9tBd/IXL1HSoD2XGNwteMmTg9kJfzyuHUp49b3s9V4XSp4tWHXZscUBuA4yrIDg4YV4lEbo0SpzbLew4GqsQoqsJRV8l3UO8iFjIZrSzxM1osaa/BrqK65yAfzB9AdeIbIkC7jzyHJXa2qbPOL5Bt64hIxJCCLG3NBAChm/GdqyC2J0DwWlKEawkickkS+NjQkbnpCbFaRt3pEdpF4rWjlW1qbLO1ccfD++U/IEwyE+SAMGzJ7I1Z2fQGYhOa3dHOC4tLqDrZ1yzYR+Ehxu1THOCRrtTkYOTad6gMNxWGyGKJCEEOPpPceXgz99XKLoFKki2j2hRs2CDVzIFFgXHPi9s8XhTC/HHFyCymBkRCR9hK4NNSzqMAEF2TjW+A+dKF+3Ggli8xh26jstQZ90kj1AojOPs275yfu9SqBcTeQb9GP0nHUiPwDXJCxcDXST+35TJp1u9OpmLbSsm3LieU4VWMEtpxYyaD0f
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366004)(230922051799003)(451199024)(186009)(1800799012)(52116002)(1076003)(83380400001)(26005)(6666004)(2616005)(38100700002)(4326008)(8676002)(5660300002)(2906002)(8936002)(508600001)(66556008)(66946007)(66476007)(110136005)(40180700001)(86362001)(36756003)(40160700002)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YwIxyFZ5lt78OAmR/zhl0SDRHoDqYbN8McGDMR2pAe9xN1cJ2gdSpQR1nk5v?=
 =?us-ascii?Q?tNoC0oFsikRoDKjWybSTbAI/p6TpXjRNSrTmNPaaGFRKmqm/6rslEcSZHNiB?=
 =?us-ascii?Q?IfIUY07BoFmbn81dSb4/e1Z7jdLRvaNbHrJt4m8uM5hb/Edm2b81yz5087E9?=
 =?us-ascii?Q?F915fUD58fXei46wuddliubiCD5fnbbdupOUbwF4hxonAgyyu711WlMQh0IW?=
 =?us-ascii?Q?+Dlgmj1bdNtJAyzi9XjO22MrqvvCxtA8J6Vd6w60SHrKkg7QLtqRlGAYlMKF?=
 =?us-ascii?Q?H7H9pfg2Oi46yK7UJwi0QatrK79eh7N0S6M2zC8/vVfe1g/7Tbs3ytqCfUy6?=
 =?us-ascii?Q?4bQa6mSvqF0nRVCHnI4R2K7YSh7IS7o2pE2+eTi4H7/v8HaR2OUeo6DB3Pg5?=
 =?us-ascii?Q?ji7ZkzdV3J1d0DpDtZ+azArbcuWLOR354ua+OaK+bktmt1LRV7JvsA6zV8eu?=
 =?us-ascii?Q?hN2p+E7JKPXhfd7pe6PjAtDsMrBCOu189MaCzsj266I5wdEJgqHm1wvYF0xn?=
 =?us-ascii?Q?zTAU2uuU6wdXq6wV8ec1V7y7qlEqHOL+2qo/EHZHC2RO34ZIc4kkRJXKNNX+?=
 =?us-ascii?Q?RFiY6HZeM/VKDi3czPFdHww35Fvwr/2pS9zGaxmG8I0Y9E3qvcQtsKdXPprN?=
 =?us-ascii?Q?JWsCMqmqLhVh87uymGfTMHmgWJU9eW7bLPIXCY1FYU0ED4elHe3mJvV7LkTi?=
 =?us-ascii?Q?C2OpRvvhPG+ogRCuWhNYNzixRFOR0GeMS3F6r5PSGVcCiXh1cYptCYD+xfdF?=
 =?us-ascii?Q?tCUxOSMYE47/T/CplRW0/JOGgQw31UGxfRzYPH4Ki579IUCtA6sXme1wPDwA?=
 =?us-ascii?Q?kCpyLdwuBCmKafoVEi38lruFISAy5+mkxG5QORYYqisrfrLnfa2IXSqTBKuK?=
 =?us-ascii?Q?sBhWBtxNgqYnujMbh4aCuJKdXFuRAX8yelTUVqzPFoGW2eIJgF+BqakLVjhR?=
 =?us-ascii?Q?LUACys4Mn0Z7WBdFZmwQyZdLTjuNA3Q9WWgXjkceFH6LRaMrSbDsWdD9v5Vd?=
 =?us-ascii?Q?HJU8LVItNyoqXx+iusvI+D0jsRtcrhFkeEYLuVR7SOxsBZTDCWnc3kvgygKv?=
 =?us-ascii?Q?yzWISg2+D3WLw+OHP3HNd8dUXBE4mGUJXFv0QicneYOBXceXYS66ZAWiKvGH?=
 =?us-ascii?Q?OuCfwOnEV95/o8LaWrxur0sfPyrbtLbLFs4NVQZwhq033GCYAgkpduDRsLQC?=
 =?us-ascii?Q?sJpogZiF21nxW21xwxoKInRcLq2uFpoqcFnVlHSVTLEExO8CldbTrvLvu7H3?=
 =?us-ascii?Q?UGSXQAp1bWoTfiztXEDoxZklzQj56Q2Umtqe0d8XLy6XJgrTOfTyOb63Bz7E?=
 =?us-ascii?Q?LCwMyBvyX11sySOrVtUOUhdpHotnpg3xWvbJRIZX3gcdaFNaXqz0tyaOZOSM?=
 =?us-ascii?Q?Zg1dagimYJQt7B8t581mzWGusWwJblF6KQVFrvZdhkqMoNp2JGJFvXnGtmxu?=
 =?us-ascii?Q?2FnFMzAa8TR9gx4nMR39BDgNsqwQgjOLAmGp79NAYX0wquDNz+Gb0v0tSePR?=
 =?us-ascii?Q?baBoeslZFp9UhBqZjFP840YyQqjwc0Z9aqiOI4sAdCb96225YtDZO9N5h/k2?=
 =?us-ascii?Q?BxL4Zhv4bhKPz0FuhlJg+f//fU2J6cLA0lh29QXzV9+yMhGI17Ium1v3VZ6m?=
 =?us-ascii?Q?RA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87153ce2-c8d4-4f31-4279-08dc18c8c06a
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 08:29:28.2625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zg8m/sAzXPs9zvn82+cAbMAO1e3rWRZ1NGbF+I4bdbkRAiemRqq+51ugsehwzTZlt4Sqvs+oPeLHfAcpm8eKD+yz5RT1IW/fFzAJUB+KgNQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1045

In the probe function, pm_runtime_put_sync() will fail on platform with
runtime PM disabled.
Check if runtime PM is enabled before calling pm_runtime_put_sync() to
fix it.

Fixes: db728ea9c7be ("drivers: watchdog: Add StarFive Watchdog driver")
Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
Signed-off-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
Signed-off-by: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
---
 drivers/watchdog/starfive-wdt.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/starfive-wdt.c b/drivers/watchdog/starfive-wdt.c
index e28ead24c520..df68ae4acbd7 100644
--- a/drivers/watchdog/starfive-wdt.c
+++ b/drivers/watchdog/starfive-wdt.c
@@ -494,8 +494,13 @@ static int starfive_wdt_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_exit;
 
-	if (!early_enable)
-		pm_runtime_put_sync(&pdev->dev);
+	if (!early_enable) {
+		if (pm_runtime_enabled(&pdev->dev)) {
+			ret = pm_runtime_put_sync(&pdev->dev);
+			if (ret)
+				goto err_exit;
+		}
+	}
 
 	return 0;
 
-- 
2.43.0



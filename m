Return-Path: <linux-kernel+bounces-44044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0180841C8F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 885F02822D8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 07:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63864F1F3;
	Tue, 30 Jan 2024 07:27:13 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2073.outbound.protection.partner.outlook.cn [139.219.146.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8351654F8E;
	Tue, 30 Jan 2024 07:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706599633; cv=fail; b=TXiZkgOoaU9SJhDsfCFVikAyK2tTrwhKtiayAV0mkH1jhaauN799jQfrMlAAGxgNhqWs33hRUVX6rln5Pu/uvbnOBYf9dUWMpM/J7eyezPSgzH9lyBmI2Lh8LPm4NApPl/zlapg013RAWGBkt7R/7shQtuapmgpfJr0o5OnKB8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706599633; c=relaxed/simple;
	bh=Y3PD+8QcDf6qI2LEORL0jEvnkGwlhauiTgMBDrDA1QY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=MVaC5burYS+e6HB/KanBc2g7OT+7ZKdjT++xkLTkw0u7rA228z1a9Jrc7XHTDAh7gxLpDZYgOLHETAS6ZH3a2Z7vKw1v6/fSHlQ/gzLqq65G57S+UNpyujEHNzYS2/ID/UBIhWN+fW5lmnSTbRlC3dSnn8O77MgBDTTtxxwTLL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nYliVV75UxpqEA2mrgmvaNLnIRie6QTqf+AJ8Z/TmPE0rZttntVGrJGB74MYSmqd6Z0+h11vXsg7S07gLAQ2SmIZCfGYvK4Tfp8hKi7qSst17jpC9ssISqwF8Qc8PYNR7b2AKezaZmq49kx9sd5RKIgck/Cnz8zVH1P08rHb1y/xfNdNWghLSnWdNs8Tss1a01Ml1SosZQ9ZO0Xtvbf2tj2652jm3NNeR/cTjPss6sLW/udEa/a9MitaRxC3jFznO859ImuLla0BUbmt2wnQm93oZQVDJrfO2TVhJpTYqnvbaDC19PHE5t7s3mGxPSzEFwDu/k9LW5dfn4c7Y/CKUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5/ym4ARTvOcck4XoGLMmghS3yD7nmIPcdnZFLZ/b/3Y=;
 b=hulUf/sERJWt+FIZ8QT63ovd1PuGvNGKe23YLJtSkI3gwwJ/QxAn3ppIKJ4OuzG5VQD4LayVifAUXZrZpVBJiiBqvAbVP0OQ0H+C1eC+2rH51uuHF2MFcQ0ZSl2k5K8a65/yHvIALls8IIz4D8Zg/1iXUWq0+XmVETklz1icfkZEURopOKFgJkUv/+mIXSjVJ/aHshXuw55w4a4uS28kwelZMALJSb5Lov7cDSouKIjdfHtQHPa4FxzgnCkMi+uh0nH3sU/DVglrKfiAf0WK6v9qJpL44/hpVrjqXfELllfggvdiVCc1Rnsj0BwWPrBGKIAjV6+PWhik2AiE4vQyjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:19::6) by ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:19::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Tue, 30 Jan
 2024 05:54:01 +0000
Received: from ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn
 ([fe80::1dbb:b090:7d89:4e22]) by
 ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn ([fe80::1dbb:b090:7d89:4e22%4])
 with mapi id 15.20.7228.028; Tue, 30 Jan 2024 05:54:01 +0000
From: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
To: Xingyu Wu <xingyu.wu@starfivetech.com>,
	Samin Guo <samin.guo@starfivetech.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sia Jee Heng <jeeheng.sia@starfivetech.com>
Subject: [PATCH] watchdog: starfive: check watchdog status before enabling in system resume
Date: Tue, 30 Jan 2024 13:51:18 +0800
Message-ID: <20240130055118.1917086-1-jisheng.teoh@starfivetech.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SH0PR01CA0016.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:5::28) To ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:19::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB1160:EE_|ZQ0PR01MB1208:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e3c1082-7173-4489-dbae-08dc2157dbcf
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OSQhLHrMC/Tp/4kdNIgOmz93WB4oapAZDe1CTa/8E6BP+VU8WirvbLIkQkowHeG/Ha3Og7pkWAk3I+T9rZyLOJDLV3YOy4P41gW0IK8jg2FyoQ252TxIjIBRomAcsE18MROb1ZmAuQkEEw3FKb3aLDf/lxnh80ZtNhtnRAkx7aCIAB3HJ/OPehxYjtEAHcquJ57Ln0Q5m3/9ZXKNwdI5cmfVWDCNKz9/gZd+DKgj0R6BxHtOYGnsuJ5Ju+yqVGuSpbWJm5fYoJ38mm55d9a2aeIYQ+uGMgxrEZHGAHPQ9/rDJauYcv3ZCN5mvFsGjykwVgo5S495SogUEl4fjb4a9x/X9wvvwatbWFMk0Im6uu22yODnG7oiqT9VJLrMIHqI0pvx5yz3tFaDjVzGieVFzDGdrxr+YOE3ApDtHYAGkfI3Lp8iGKCjATcd+pjLYVsbTupisP+aHH/umDP/ib1Pn7QLdgeNxEPmR0TYHXU62qlfiuKqukrNySj/dW4WrbW17DZ9lec+UGqc4dokGlbxzoE8wYhM7i99FrSf83JnHOIiiFtwiBhzp47IL40vQ5JH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366004)(230922051799003)(1800799012)(186009)(451199024)(38100700002)(4326008)(40180700001)(5660300002)(8676002)(86362001)(54906003)(38350700005)(8936002)(66556008)(110136005)(66476007)(66946007)(4744005)(26005)(36756003)(508600001)(2906002)(52116002)(2616005)(83380400001)(1076003)(6666004)(40160700002)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GorqAkK5GxqYS1JRZRms8H20NHPsztzaWpFi4kaM45S0rFtxX/ZrwEbqiP/b?=
 =?us-ascii?Q?ub7yedZoc+tWXzlW2YTxGgfR4vnVvDl6ERPXZb27oNvuUggvmGRAVDd/3aWo?=
 =?us-ascii?Q?6Fit9so9+OcUkWe+0CO5/HUSDCdlZzlkAow62sjjQ8drvwQNQLpXWD/lZMKE?=
 =?us-ascii?Q?7vLhUNC3NnKaFJ9/uxou5/ykTH7Yj3oEhS4QSjUv9welR7UpRFWirjuNMtYQ?=
 =?us-ascii?Q?Wzi+6bm3c4qDDySA1L/FCfPAwQBu6EJ8J0/TsSpHrvQXuFF8VSVMJASnC6ix?=
 =?us-ascii?Q?0P8zyL0RsXnBUHWAgWKQmZ0Y+rqujr4CRHKSk8q68qgeKn1fheUk4fA2BuVq?=
 =?us-ascii?Q?70CMiemYIJSG0yDOG6hF4ZQSgvAPtPTixj08S6Zf/6mZtjwbZqwiOYIRm0yO?=
 =?us-ascii?Q?+4v6mHWfx9TEIJ3kA7bOy/94ldmYgFn/+UdPVqdekma1762XY42Wb1yENpJc?=
 =?us-ascii?Q?dNRlPgQEBUPvR/aCWDGj1tXlLiJMCYqy8g5ww97WLdSN78d+bd3WSwmeRlVY?=
 =?us-ascii?Q?f3BlFRBWU2kLir4w1sb0J2C8zCM3i8wl0L0jv0iOsGcRPGukzWmOPsKit9zD?=
 =?us-ascii?Q?+UHqBn5BaSSQDXE+Ee4q7bhSxIqSoC54ajJLsiPTreAOWAf8WCOWw94NVXby?=
 =?us-ascii?Q?KE82CZabrKRnDydrq7zqRcg1iBZzv4SvyB5eNME3fmAk2CyAaB9gbUNz+KhW?=
 =?us-ascii?Q?ssafAHaqkIXEmrOnH+h8w1aKTFem9g4CIJXfaiEzajqSU4fkt4Bo1FgLMtZ1?=
 =?us-ascii?Q?E4RyhrPiepfcQIheZxOTL1Q4dV2uAi9Mc3MMukSQ9VsENAUfg/Sll2KB9dTn?=
 =?us-ascii?Q?KL1Oe26NEV7viLwXm3ieQwoMcnTmpXkm04g3OH01+reCASPbH8GyG7awUVlM?=
 =?us-ascii?Q?utNyDDuVzWrQ+QSd/lCZb4qmItbZl+Yx/oi3KBlKJlhpENTirMebfdIRCeWG?=
 =?us-ascii?Q?oJ0rXxGRMAj9AGe851hKip2H7/XBBX51Kamrh7p9skQPWk7DwHiMFjCHGwVm?=
 =?us-ascii?Q?PC7uvRNiPZjS6Jnmh3wC19Yty5AgJJ1oAC9RqHg+37nuSggbKJx7HpzL/BZf?=
 =?us-ascii?Q?TE+ZU+rYDNFQenOQ4LkUgOVJfDyds3SzcxOSvPdIonhjGy6LJygS4JTxuWuC?=
 =?us-ascii?Q?FUS7rT84wk2JdylqZiEsh25CO1eH0h9VTLuuULvWTv2O3baw4p3KWmziCI8m?=
 =?us-ascii?Q?gV8hBvtinmpMz0pO/yDhXQIXFkpqKzLmTy64doMxtfBYMCEojKkxQu4/o70X?=
 =?us-ascii?Q?xfeosOVKEoUrJj/aqb0yWaiLxyTSXKcd2+qOwfwLFC6pFyMR3KhbqF0+eKIr?=
 =?us-ascii?Q?P1omLM6VkioRy225JIc/JS6bisJ3iy3PYf1XGn/CZGiQULdvNACzkcaf8iu8?=
 =?us-ascii?Q?BIQO2CMJjUIH2rYKr0+W3RahLC+vBVg540X+TVMrGrsoiuk0VKH9EnpXKn+9?=
 =?us-ascii?Q?DldL4wN22+DLjB8YGojIDPJepm+LwZP581/47gHTFWDLVmbbRA0kk8Kcn8Ua?=
 =?us-ascii?Q?xmtn/+kfoEUd3gba43olSxc9XAFp+Ls7h4Md2dos9LsiQDsJCrg1vA8fYoq8?=
 =?us-ascii?Q?f91Ag2nK7hUj8b0RlT2N3fRd6CnD7ibruPX4EPyphAXZK36EJW6QeohvRquG?=
 =?us-ascii?Q?Ww=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e3c1082-7173-4489-dbae-08dc2157dbcf
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 05:54:01.5641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U0O/3fARYv4+GoJk5/D2hldEoLuprgNP3w09PRduSVJjks4lfxwmeXyKMpbKTF6RwqfJ07/IG8kZiD1GpYs1CL1PXWceziuyVIklKvoqwbE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1208

System resume will start and enable watchdog regardless of whether the
watchdog is enabled/disabled during a system suspend.
Add a check to the watchdog status and only start and enable the
watchdog if the watchdog status is running/active.

Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Signed-off-by: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
---
 drivers/watchdog/starfive-wdt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/starfive-wdt.c b/drivers/watchdog/starfive-wdt.c
index e28ead24c520..f72fc38a41f8 100644
--- a/drivers/watchdog/starfive-wdt.c
+++ b/drivers/watchdog/starfive-wdt.c
@@ -554,7 +554,10 @@ static int starfive_wdt_resume(struct device *dev)
 	starfive_wdt_set_reload_count(wdt, wdt->reload);
 	starfive_wdt_lock(wdt);
 
-	return starfive_wdt_start(wdt);
+	if (watchdog_active(&wdt->wdd))
+		return starfive_wdt_start(wdt);
+
+	return 0;
 }
 
 static int starfive_wdt_runtime_suspend(struct device *dev)
-- 
2.43.0



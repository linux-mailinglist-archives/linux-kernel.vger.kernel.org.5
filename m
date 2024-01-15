Return-Path: <linux-kernel+bounces-25728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8CF482D509
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 09:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81666281A41
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 08:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C7D63AE;
	Mon, 15 Jan 2024 08:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="dMOEsOIl"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2136.outbound.protection.outlook.com [40.107.117.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5C75C97;
	Mon, 15 Jan 2024 08:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NLB8zFm0Hh5MWuWTur2nCDulCayFOAhUM6vfjaftgRP0QDPL0nlrG3l7sUTP5AT9f/vMr5IgI3mV12WH4bjPoRVzQvUFinhfL+r2oIYod3d2Dw6Z1zL4MK1jIpcrsigE4/au/qSRkye3/D0ap7KUdg7kI8tg3dolur5pEv6j7WJXEp2hi75U9L7eeIUNy2btJqmbtaRBwmMpTxQoCaDMZgF/kjJpu5hr5fL+Ssm+BwG3tBcd7AaFZEZ77Pdr69IU5zghpes1qxXxkOksMNPVvo5o1kbsXJ9WfaD4BmpgAoRTd46rp55ZB+VC5onN2HxLG9ohwUOxfBe3mLJDUO4VjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=454L7JXpg/DQMJGVcBwvV9veAZ8bvc1YHMeTA1TJabY=;
 b=Z92pkCMEuQpdx4Epdf57NHVUlXOh0RhiCihlLUrdSTR/kbMaJhfcoY7iTt2LD6qpdVTD1GXg47etiACK+5wIQlOgvrwj/VTVAULN7zNgLd4HWc64doEfE9uP4XF8mXeftMgDBDZys4XrNndPP+vad4dTASfkT3FUjLUeUbQw8p02kc7eZVsK6Lz4Zv5Nr4Q+RrTuAaW7ZuuCmRTVExdyhUc3WPBdFSA3SVKywI6Zgl7j56l3DNmw/tqLkvsQO9GoHifOizkvo3G5VdxpgIk6FoCjtamtrsRK81qcay9FHxNa27lFnd1lGn/M+1QEvrX5meyUSDuZd8lNgphlDzj9tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=454L7JXpg/DQMJGVcBwvV9veAZ8bvc1YHMeTA1TJabY=;
 b=dMOEsOIlwNf+s71ipAvjmrV1J9nez9Kkchl/RA7HUH8NO7uMtSQSgP4YYC59Pq8rB0KMdZHK+fG6Q47nwMx+3f7/eT3Deg8GWhOw+/kV5bA5b060oofSLBNBX2edab75+YF47alyD2AnlmV/uEd/SsXdFk+VOBpYJL+MTnSQN7H7Lb97tjXWxHRQE2XBLbs0xlAA/f/zDiojAhu5mHAn2TO5sIozkj8hBtPDwDCcJb97UM1C8/ih5sFzgqnDhR1HUFvbwkEmBhjQR2bq/k77oEy9AQR2yIKOF2MAdNC6HzvQCR1EsXR+lpnj1JsZdQ20tRkUibr0SXdB3WfIYVad9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9) by
 SEZPR06MB6158.apcprd06.prod.outlook.com (2603:1096:101:ea::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.18; Mon, 15 Jan 2024 08:25:43 +0000
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::6b60:8171:49a4:af39]) by SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::6b60:8171:49a4:af39%4]) with mapi id 15.20.7181.019; Mon, 15 Jan 2024
 08:25:43 +0000
From: Minjie Du <duminjie@vivo.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org (open list:THERMAL),
	linux-kernel@vger.kernel.org (open list)
Cc: opensource.kernel@vivo.com,
	Minjie Du <duminjie@vivo.com>
Subject: [PATCH v1] thermal/debugfs: Remove unnecessary debugfs_create_dir() error check in thermal_debug_init()
Date: Mon, 15 Jan 2024 16:25:02 +0800
Message-Id: <20240115082507.29651-1-duminjie@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0167.jpnprd01.prod.outlook.com
 (2603:1096:404:7e::35) To SG2PR06MB5288.apcprd06.prod.outlook.com
 (2603:1096:4:1dc::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB5288:EE_|SEZPR06MB6158:EE_
X-MS-Office365-Filtering-Correlation-Id: 20bab21b-7847-400d-2707-08dc15a390b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	q+hGzKEImQ40NVWj5kCRatVduOXKBAV6eRvNstuzzZK6SxR08XxnQxPVGLI5reJdFMyEDtGhruMHl8QlUSv8/cPq8o3SJhtpM1BfWC7VdfMkw/4zTp//k6J32R9Y7S60J+zZGlqL9YY+cuZ3gnDGZgsKzRJlJgvVn8WnkoljG1B9uAUnrA3FbP0Do3QebMPZjrp0AHCN0R3WaS4u2/oyR4evL9IHTYDIE/8lyMdrGUfE4zgaPaPIR63ZeQVKx6mWIttNGryrZo1nXhJvXjMiJlhad7xVpFlLA5behvwIW+2JZnn2c+oe5GSmK+T5f1pi8udXg2mBnOtIRkTDGkhPFhWTd38PAMMSLBWCfSpCgOnNFABRItop0wHjv+hUqq1U9/04udg3t8eFJCBXctWqgCnObiDkadVsB7Ix7O7LKNcNJ7exQAJfdhRgtMWkZQFP74lJoMqoTan2dVeTnHE5KPNTeiHj7ch9W4mp3XKgDgjESdkfYHJKgyBInjbr7Qu6yKVaUHCaFhV24AB7R2G8ZrupfmiJ1/Dakjp4a7SbeaostvhkceFoYjWfd4ZbNBSw4/z/NUCBcoYg0u5NL2nN2qjY0GSAXqu6w08EFrOiSv4Mu2/zzFBWNSBiWmhKD78k
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB5288.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(376002)(346002)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(83380400001)(26005)(1076003)(107886003)(2616005)(5660300002)(6506007)(478600001)(8676002)(6512007)(66946007)(8936002)(2906002)(4326008)(38100700002)(6666004)(52116002)(66556008)(4744005)(66476007)(6486002)(316002)(110136005)(41300700001)(38350700005)(36756003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t5skAOV2FCQLgYOFl079z3+qsIseGuwWSWG9thf97bPAhm++UVPeKeCSZjfh?=
 =?us-ascii?Q?D1UQZGQzIjhT4KuO3gX7z1S2J16b5/lYuIHlPlhv7oycjeEA4psDgeDn3+yR?=
 =?us-ascii?Q?We6pHL/7wMg9V+AN5gqWV5FDBa/yHKhtM0xTqYz5Tdm2PX19zcD1uAe9NmSZ?=
 =?us-ascii?Q?MZ+CxajS8YUSV/nTafLwK1pnASU79ZpYtau0O3jSP7XL7FY/YLJqEocRbzKI?=
 =?us-ascii?Q?nwWUQk7xyn0LJf1ESmJG1Na7NtQC7pVh05c5glWTJjdtw2D9fUGzKqogLngs?=
 =?us-ascii?Q?HBNTzkumxD4zT68SW/t0j8QnM4A+hRzCEiOCFSyRZLJqRKofFgGUu+xQ58pi?=
 =?us-ascii?Q?it5hxvTLrFwz5z2AM2TDVCxp+St+gIcKB7gTDnvtBgFSSqnTyBQGdvQQs2cv?=
 =?us-ascii?Q?JXeMcripSN5LbDuCbjGSy0eDv4NGpsIkjm7AtqWl7NoB6YckAkaEG1XOElRZ?=
 =?us-ascii?Q?T0XeACwnbQJl9LbADUBDtYjhGYfOuTSTB5WLOkjDykuDMEuO87fu1yl/7TEM?=
 =?us-ascii?Q?QthSKEi7+KhyeAzQpddabq4Yn5dIOKOWGdBmYviht+w7r38TShRvlsgldwa5?=
 =?us-ascii?Q?nqvYbR3MAL70tCF1Ubq+KRgUIW1M6EWX8XIlHPKeKVzjiFv7fC/2ljVkuazl?=
 =?us-ascii?Q?x0qQ5DDXX9BMo6LXNf3Mq8DgDegmpKujnLK29RcOCmFGKHxlumFvV95FcIuw?=
 =?us-ascii?Q?2cFOBZzMMJ8vxZPUuBn3Dca2oKSgLmqsl2b4/jR2Rce1QChOqhRsqn6G8cLw?=
 =?us-ascii?Q?ELF3bkO/qeiS2DFDTAfddKMWbvKEMGLUMsYmf6onbftsEUkdYT1UafLEnBq2?=
 =?us-ascii?Q?3KL+RRgxYTvMzh0cbto96bt+fNn4GxzMRi8OgJV0erOaB9QKAZwR2A0kDBcI?=
 =?us-ascii?Q?YKLXWmKepjRWUgBOnWWg7xnOpSEmQX9PGCq/u/EsNcOxpDgdhKOyNc2mmEha?=
 =?us-ascii?Q?Fp4MKG0c6WhHV15cVfq//tKOlopaVBfw+wpgag+nUQH9WZhErzvwx/UNchHm?=
 =?us-ascii?Q?NIftcBmlok7dLZyN/LjhRtpcQCrPbd3GFnaK9m7sJnZXbn1Wlt9uNyxn4F1k?=
 =?us-ascii?Q?5+p993gUgPMGDPiGJ3qZ+JIA0mH/OafbFKLrDx0t+PPGEEaCCtCsb0zvWZ5K?=
 =?us-ascii?Q?m5iygojk6KIDCKjF+UyuRSQpbuMTvZxGKDiCjRg2/dYqVJAyeiFMiK7hsNiX?=
 =?us-ascii?Q?8lRJ8AmucdOO9+A0myFCPLV4faY9ybE5jU6dNrrP0wONmxBZdK6WGWOoR1pS?=
 =?us-ascii?Q?b41JCqY3iEOXVfv6m0SEK/j/L7UEgOFnsKZMXblu1A8wGAs51Ko9BeeVEque?=
 =?us-ascii?Q?qcKmwDqXiyqO/svGk+FV8xKODFbZHl0Ik6z5NbSmc04VTk2S7U6YC22h3t6P?=
 =?us-ascii?Q?nw6vXVh2rkj+CRi18lyDtNT1bgDOqJ4bGh6AXc6OzJHfaD9Lb3018HbW6Khl?=
 =?us-ascii?Q?wo4exURR3uNkk+uR3BAc+69bdDN4teI0BuF9m95FsnvMxOOxFhXc2BiJOMpy?=
 =?us-ascii?Q?2h76Sgn48gnK9nadgBSRRqJ+2B9OQXT82p6wcCXEt6cEK0yPtd4z0BU5leRw?=
 =?us-ascii?Q?MyQ9xAkW3PyEltRM/bLBBMsFbZR7KiPCI3HR8vBf?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20bab21b-7847-400d-2707-08dc15a390b4
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB5288.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 08:25:43.6467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QSdYLtX8jFOt1eyjbLOaTOluzg0/aIbFLP6Wvu1K9lj8bw9nT8vKN6CH8S8HR3I/J1h4fI0LaVCLaAegJsMwhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6158

This patch removes the debugfs_create_dir() error checking in
thermal_debug_init(). Because the debugfs_create_dir() is developed
in a way that the caller can safely handle the errors that
occur during the creation of DebugFS nodes.

Signed-off-by: Minjie Du <duminjie@vivo.com>
---
 drivers/thermal/thermal_debugfs.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/thermal/thermal_debugfs.c b/drivers/thermal/thermal_debugfs.c
index a3fa09235da1..695253559a61 100644
--- a/drivers/thermal/thermal_debugfs.c
+++ b/drivers/thermal/thermal_debugfs.c
@@ -172,12 +172,8 @@ struct thermal_debugfs {
 void thermal_debug_init(void)
 {
 	d_root = debugfs_create_dir("thermal", NULL);
-	if (!d_root)
-		return;
 
 	d_cdev = debugfs_create_dir("cooling_devices", d_root);
-	if (!d_cdev)
-		return;
 
 	d_tz = debugfs_create_dir("thermal_zones", d_root);
 }
-- 
2.39.0



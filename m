Return-Path: <linux-kernel+bounces-28482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE0682FF1A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 04:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D7ED1C23C09
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 03:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFA7524F;
	Wed, 17 Jan 2024 03:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="d3Xoc7aE"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42331C05;
	Wed, 17 Jan 2024 03:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705460743; cv=fail; b=aGqyCoXE2lCMcLwLWSL9vyyhse0/NZC8mO4p2iQlsnHCGuw6NcgqRyB1/+BRlXLuol/ASYw3hW4Cnqc9qdZ+e5U83GawxmuWq0ViPpLTwXq1BnyrcIda6JZWoOHGelTK5AoqD1NUwQv/f+XHJJVHU/To1Yb9L7aHmKLVbJ+eAcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705460743; c=relaxed/simple;
	bh=AQec8uBuDJCFEySS5K4ndUlt0azAwRzOuv317x0UAow=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=U8jxD+nMtnPgZmUTruxCLzuGfFX6F6J3gs81aoNq28fdASEKerDmUEYX0nfIl7SGcWioZpoOLVv3q7rcUMKLKdFDyyKVntPEX4LKWxxkqpN+kVQK7s9d4gL6Qjq6DLqC2YQeMnk1kra+HCAdM9nz+XsamiH7o3t2u+X8giVZrk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=d3Xoc7aE; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=COWP/jkdsCUY5dnon9ShR3BQwDnrbD0m8VPSP9VnuWS2Yil2VclKFwwQuLBgXQaWUVo10fRX1wYwDtaWXPGOxpdpHnZeiDkiR/97JjiS2WQ096r5Jryz91FlUktsuXwz5tcyrGN1KZ7sG0qm6ZFQeFa1gMy4sjsqaP9V8/5g+A6JQJNGOoYvc12t7Z5JCR2mqdFSbXu/iIKu0ge2gN46Kx3OKJIC3F72USmHm9daFvbHz1xNGzavoaqiueS8yf+g+R2sWXWB0yFwE5P6/u2oSgxJDnbBL4qH68Jb6lgs1KyvxyAYGKJeJL/KmEtxE9dBc/pM0ZIrU15Qn3LyEvMeww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hs9qhr241rZrxdk2k+agYKrxwWyjM45O1IWRqDApG5k=;
 b=Lohv1DBI6u4PDBEH513u9RrACRMGHCxY2BlYACQNhHc5prjqd4JExM1QmrYlabM5Rrwz3mAadM0rtk324uU/aKma0YRHgkUnSVgabyBK/7Sx5uiI4x9D8DMjF858LxqE03WzLAjGpq0fP8t23NTjDKb9Bq2fawaC6rrOCDnN5HOTfsf0bxcD6ZgwyMGNQjKSkCjqkGBGKJJzkI0RVXF/8/kyNw8ayu75Y1ruBSeBD2p8dr+E6t1XGlRYeZIb9Z7SfqT+AdztQH5oG32UEhZSVJYUxvtLNp9v7HLsZiS/TKH9sK05WSiDaHQsp5cmB7BVA0zwmUF/WBRExYk1h0SmJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=sipsolutions.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hs9qhr241rZrxdk2k+agYKrxwWyjM45O1IWRqDApG5k=;
 b=d3Xoc7aEaNUS1H0Q2+/6halhTsd+5c0h7WwaIA8Du21YNGPMxqNd73ymQ3YpQ6I9nGhjad8EtqBWJa2In8Ax4tg+k/h97CyolBF5HO5mOp/bjfn4d2x5KAy55T+k/UqtE06PvwY5ONvWTgylTAo386Xg2oTW/7kSGkEKicres/s=
Received: from PR0P264CA0146.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1b::14)
 by IA0PR12MB9048.namprd12.prod.outlook.com (2603:10b6:208:408::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Wed, 17 Jan
 2024 03:05:38 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10a6:100:1b:cafe::7) by PR0P264CA0146.outlook.office365.com
 (2603:10a6:100:1b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23 via Frontend
 Transport; Wed, 17 Jan 2024 03:05:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Wed, 17 Jan 2024 03:05:36 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 16 Jan
 2024 21:05:34 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: Johannes Berg <johannes@sipsolutions.net>
CC: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "open list:MAC80211" <linux-wireless@vger.kernel.org>,
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>, Mario Limonciello
	<mario.limonciello@amd.com>, Jun Ma <Jun.Ma2@amd.com>, Kalle Valo
	<kvalo@kernel.org>
Subject: [PATCH] wifi: mac80211: Drop WBRF debugging statements
Date: Tue, 16 Jan 2024 21:05:25 -0600
Message-ID: <20240117030525.539-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|IA0PR12MB9048:EE_
X-MS-Office365-Filtering-Correlation-Id: f4d10189-7c3d-4e15-19ab-08dc17092d4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	comNzEd+hgFNSJg+CQfSCb2vxBPeOIm3b35r6GEJuMlwWMGPO+U30h9PvZMUHhOgIJTE0HYDKG/F0q79FY45G+eViVsR1FrTNofdL2g4aYwjBOEXVk4xFbp55BAK3gTGFFEhx2pvmqafBAB/KS1fD9eC3cMknI1N80VGdsv1sS2u4XRiMzCnop8FQ4JjmnyyyLxTb9VP+Js9O/3ghSU3PiCtnqmVbdR9ofXI7zoMoIzPhes0tUYBQA6kKCFxoOOVnZ6ToeNKN65zWXGnK0CUKMswTIJXCS6OASUbs5ML+A0LKngQioKFfnZBfCjWfZ2YvcbgFIOoUeY4YTzvm2O8fRJDeP34kVKD7G7aQSDguBu1G2ZnTqvQ5oPrihpx8Dpa+qeOriDZhK6r1yNOUqMqeRZR5rSxhFlNJipDKlIEgeSNqUJdq97cC39t0ltqG+U3CdrckGNTUmEufFt+DtN2YhzgzZCZUaW77mEMcgwu7Q/ZgGTL53/k1I+Ztq1nMjMMyeCnTPAAqeV/Lg91lg8MG2EGnweW659yhdvGVMgaHfxamKZyyAIS8WaTXM7TBJjcqqVT6QFwohHbKkfHEJHmAvh2OAcgufG1qkZDxJD2sEvZ1NmDh5qU4GTOmxeglkjDyAkQ/wm1e1RsCPFEXhH8SroVuIMF0WxnKBeiDRV6lBDfw/7lvli/4k8towdmNDdzEw6UUbmWLICpb1+wNIqUDNkGbOQSdT+IlKRT90sBmW1aVpfxPtGm4MQJhvgSu+eJ6J7j1z9WW1ZtEK2RdefhVA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(136003)(396003)(346002)(230922051799003)(1800799012)(82310400011)(64100799003)(186009)(451199024)(46966006)(36840700001)(40470700004)(40480700001)(40460700003)(36756003)(81166007)(6666004)(41300700001)(86362001)(356005)(54906003)(478600001)(83380400001)(70206006)(336012)(426003)(5660300002)(47076005)(16526019)(82740400003)(2616005)(36860700001)(4744005)(316002)(8936002)(1076003)(8676002)(26005)(70586007)(2906002)(44832011)(7696005)(6916009)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 03:05:36.1405
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4d10189-7c3d-4e15-19ab-08dc17092d4c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9048

Due to the way that debugging is used in the mac80211 subsystem
this message ends up being noisier than it needs to be.

As the statement is only useful at a first stage of triage for
BIOS bugs, just drop it.

Cc: Jun Ma <Jun.Ma2@amd.com>
Suggested-by: Kalle Valo <kvalo@kernel.org>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 net/mac80211/wbrf.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/mac80211/wbrf.c b/net/mac80211/wbrf.c
index a05c5b971789..3a8612309137 100644
--- a/net/mac80211/wbrf.c
+++ b/net/mac80211/wbrf.c
@@ -23,8 +23,6 @@ void ieee80211_check_wbrf_support(struct ieee80211_local *local)
 		return;
 
 	local->wbrf_supported = acpi_amd_wbrf_supported_producer(dev);
-	dev_dbg(dev, "WBRF is %s supported\n",
-		local->wbrf_supported ? "" : "not");
 }
 
 static void get_chan_freq_boundary(u32 center_freq, u32 bandwidth, u64 *start, u64 *end)
-- 
2.34.1



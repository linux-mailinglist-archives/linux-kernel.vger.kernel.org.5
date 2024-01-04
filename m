Return-Path: <linux-kernel+bounces-17000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F25CA824704
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 18:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 863A7287BB7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75312D02B;
	Thu,  4 Jan 2024 17:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TtyjPl4D"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2C12C6B0;
	Thu,  4 Jan 2024 17:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VFmVJeyC6cTbpLOu7+E8eAZTVTO/dx7j8K+dQmirFeHcxy2enrNfyFitI3xAQd9iAUuQANh5xJAiJSgEyavNvxLzv7BaubKLgpmRhvMb1oX4nLtxb78CeOo8jXikvHzzbnaMkBYSyRl50N0s08Rk+Zu5fMhaWuzp4ozAbdSR7c00GW0vB7y2xoEK3zcGV9uOnl+VQncuCFzAw9B3x1sfKDIyIBmTOJj1TDUCgEvge3e7a2lG2WLIUpJ/513B+16//xhVPgU4YLxE7TMjdtI69tCaYfYpIoNxxfldNGdIiuX/IWgStZZBpdJa1hE0jFzsOrDyPb1UYZsWPVAhR5UaLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z+OLxvq2DYP7wxZqyHKMOFqju/oZOkRXvow9JXosYx4=;
 b=NEKGU/VygSl5LKZEjO9gE+LwH8gPlhMISrhbeA2PJHGy6S4WZFtLk0eCQZIQMtCdCcsJlFL+fnwgCmunw0VnLOoTODwUQMvfM1pE5neQmZcnL6qGAYcW9CSvnDi82c1e10tODeLvJsqBqTmqaEt1E5xJZe1KNxxNFLilWbz7kM5nxXFxjSbjW2PinEeyTFdfEMoXq+AQYFQXzK/ulJpF+mWDIpC+9nafyMM2QDXRIHoHMOcSVfccSEzOGSzvzEOxLTLPUcpeEZ0ExUzmu73ibqkjbfSJBUSfvm5Ffj6zq+BiAZ0/fa8TfRKiS+9dkzGIZW5rTBi5Z5H8laLXcMBs5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z+OLxvq2DYP7wxZqyHKMOFqju/oZOkRXvow9JXosYx4=;
 b=TtyjPl4DPe/4cjPl+3PTO93PkJQO9nnAG1fxVodDrnSfhMjxl7MjimdZrNMbnR5qanBKOTA3qlgq3WLl6BvFxFs7gpUDL4Jp95FOrp8SCmnM7xirveIUYsbadFd56eeVcIEYzXHBhQp1slc4NE+d2OiMio1HyPCn4xENV1KaKIA=
Received: from DS7PR03CA0214.namprd03.prod.outlook.com (2603:10b6:5:3ba::9) by
 DS7PR12MB6143.namprd12.prod.outlook.com (2603:10b6:8:99::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.13; Thu, 4 Jan 2024 17:12:44 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:5:3ba:cafe::a6) by DS7PR03CA0214.outlook.office365.com
 (2603:10b6:5:3ba::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13 via Frontend
 Transport; Thu, 4 Jan 2024 17:12:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Thu, 4 Jan 2024 17:12:44 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 4 Jan
 2024 11:12:42 -0600
From: Brett Creeley <brett.creeley@amd.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <shannon.nelson@amd.com>, <brett.creeley@amd.com>
Subject: [PATCH net-next 8/8] pds_core: Fix up some RCT issues
Date: Thu, 4 Jan 2024 09:12:21 -0800
Message-ID: <20240104171221.31399-9-brett.creeley@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240104171221.31399-1-brett.creeley@amd.com>
References: <20240104171221.31399-1-brett.creeley@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|DS7PR12MB6143:EE_
X-MS-Office365-Filtering-Correlation-Id: 037ef2c4-4ad6-442a-822e-08dc0d485e2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wvIlY/UWxwnpR1F/qk2/aQIWoxE1y2dtGR4dm0JmB8P445luUx98+YSFzE3XdswMbD9zYhNak1t+su7d6CS3naM88iroD52pDIZ6jSs6qbltJ06wEA3fNUpuBdvqig4/2SaajTvtchFzcnwRei8cRDarhcYYqBSkWI/cv1kiikyW8BJpGMol9v7NPItBuJa7W096rIy6GnXMJDubqQd2oxTA4PWmKAgE4L0v5dPXkhSDc494ePptZG8EAHe/elmR/IVC7PX0LFoIigJ8PUGDBHI0MN6jEzDwRD4tDx2133JVzI/XTZ5fdQ3nUWnEK7QnNbC4OYjg1Ai2M0On6q29mvCHHMw4Ym/6XgrxzJWNcAb4/K9Dz0VbhfyAeRAzRys2BDYasH7jBdP2ZVKYuX7SerbaP6KzQewcnrd5cLKcDDtXOsTZ+nRR+4lN8BZv6qo8O3CouYUX+EDrZDJAuKrSm/wzaqvs+J6oZ4HACdtALzM+cdpwV2QUGWxKo2wrTbQyF3Y7JhC1iNhkQu2UB1WQuW0y7cJZLJjYg1q3tXQdjifEs0gT+6SUgGdZKB7jAOXIrCcBSjP9GepT8c5ztJpC0WhgCTB5IywjouTP+9kt4W9uy6NPxUL1bvNVOVrTqgpSNlV3FW8rtw7BdDNmz1+deJF6LlRtUvliUpjD9j5GIuk5fmUXzTIkCWCpnlRjUArXOVTVF2cHVL3wgN+WQ7ymUpSFycoMoA0kvS5Gdl7CfmRfg7cHSQtCnNm+pJS42QEjKbYWNUUwh515HiL4qDYWpw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(136003)(396003)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(82310400011)(36840700001)(46966006)(40470700004)(1076003)(2616005)(26005)(4326008)(83380400001)(47076005)(41300700001)(2906002)(81166007)(356005)(82740400003)(5660300002)(316002)(54906003)(8936002)(110136005)(36860700001)(8676002)(44832011)(6666004)(478600001)(70586007)(70206006)(336012)(426003)(16526019)(86362001)(36756003)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 17:12:44.6855
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 037ef2c4-4ad6-442a-822e-08dc0d485e2a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6143

Running xmastree.py against the driver found some
RCT issues, so fix them.

Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/amd/pds_core/debugfs.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/debugfs.c b/drivers/net/ethernet/amd/pds_core/debugfs.c
index dd6aaeecfe0a..d56fdbb4cdb9 100644
--- a/drivers/net/ethernet/amd/pds_core/debugfs.c
+++ b/drivers/net/ethernet/amd/pds_core/debugfs.c
@@ -32,8 +32,8 @@ void pdsc_debugfs_del_dev(struct pdsc *pdsc)
 
 static int identity_show(struct seq_file *seq, void *v)
 {
-	struct pdsc *pdsc = seq->private;
 	struct pds_core_dev_identity *ident;
+	struct pdsc *pdsc = seq->private;
 	int vt;
 
 	ident = &pdsc->dev_ident;
@@ -102,8 +102,7 @@ static const struct debugfs_reg32 intr_ctrl_regs[] = {
 
 void pdsc_debugfs_add_qcq(struct pdsc *pdsc, struct pdsc_qcq *qcq)
 {
-	struct dentry *qcq_dentry, *q_dentry, *cq_dentry;
-	struct dentry *intr_dentry;
+	struct dentry *qcq_dentry, *q_dentry, *cq_dentry, *intr_dentry;
 	struct debugfs_regset32 *intr_ctrl_regset;
 	struct pdsc_queue *q = &qcq->q;
 	struct pdsc_cq *cq = &qcq->cq;
-- 
2.17.1



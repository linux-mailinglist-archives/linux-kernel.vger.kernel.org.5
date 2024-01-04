Return-Path: <linux-kernel+bounces-16997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF4A8246FD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 18:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC352B2381A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749A22C6AE;
	Thu,  4 Jan 2024 17:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WzKylqBC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA612C693;
	Thu,  4 Jan 2024 17:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X45mPAtJNFdLmbzhWX9a0OINidweVVnk5TGXyO9SObQjXRQHNcBcMphg2AWdE3/N6wbH6pt+s5ieaUA54vUCgQXIQO3cFV7dWxAQEq3nRoJjAQcZi8ECmpWVWfVuAarEYFLplNtZAL3J84QFAr5jLtUe5iPdfcRdJTxCdMQdxJUOU+ig0TnzXP3i3R8ZFzP9Y0iRB425aNE90ddLecmEfo7+3txsnYzDPeKDUigMG/08q57OB2+m4SinzHwFwwgWaYZ5uJFBu+IkP7R4H0fApSxIrAKRROHgk4+b9AKgoNa632gVbpFNpFxw7pcdSzBWXa2F78u+eisJqF9wtFOZNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NVMyew+aAbLO2p6XK3nYqwrp0paEZ6on+b8/3CaJpi8=;
 b=jnSXGz3JIBqHpQm3oVviTTiz0ev8dZh8xaHKfvV8K3l2QVa5WWKThH2GDW/nun6enCULd/eEueC7zR7rj5kS6kA1iAPFDELNKoyWUjwWvfELUQKBrXdPh8CVAPT3HNQYlfTG4Nyx6r4r2NPa3+1XJeY3zzGOd0j1t98rV/fowvJ8OqNF4j9kkbAlHvUEMJV6Q5bPpIPYsh5POlniMnUmMvOcBfA/I7OVCbdFjIS0A7CfLUfX6xdro5pGFpg41+KXO0AlIGTcMd1iLMMEokaxSM6FwML+kWkasr49XQY427RTpX1jGE/vYRZA67xduyLBE1sZrTyIFNXbvMHl/OxpxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NVMyew+aAbLO2p6XK3nYqwrp0paEZ6on+b8/3CaJpi8=;
 b=WzKylqBCBsD49WeysrkveJ4Xi83/1qL50DLkgKLz+Bh3PTqBuuUG4qIIPP3f3ji27CbaaNzuxvsv5/n5o4XQbBUFUae1u1/xJ//MFIloz5CSRmzrjN0o3p7O2MmNbVLrjHyyBig8MdDrO8MeuCRjyqFgOipqO/atJ4U/tjxCFvg=
Received: from DS7PR03CA0219.namprd03.prod.outlook.com (2603:10b6:5:3ba::14)
 by PH7PR12MB5687.namprd12.prod.outlook.com (2603:10b6:510:13e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14; Thu, 4 Jan
 2024 17:12:43 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:5:3ba:cafe::25) by DS7PR03CA0219.outlook.office365.com
 (2603:10b6:5:3ba::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.15 via Frontend
 Transport; Thu, 4 Jan 2024 17:12:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Thu, 4 Jan 2024 17:12:43 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 4 Jan
 2024 11:12:40 -0600
From: Brett Creeley <brett.creeley@amd.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <shannon.nelson@amd.com>, <brett.creeley@amd.com>
Subject: [PATCH net-next 6/8] pds_core: Don't assign interrupt index/bound_intr to notifyq
Date: Thu, 4 Jan 2024 09:12:19 -0800
Message-ID: <20240104171221.31399-7-brett.creeley@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|PH7PR12MB5687:EE_
X-MS-Office365-Filtering-Correlation-Id: 43f96daa-fcad-45b6-d8a7-08dc0d485d7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qSmv5QA4V1VTIQEarP4YHaRCCUZnag9oy0LCcNWa9xUEFk1oMlbXhxi2RtUKKStbJ+B2YbTwf+sOQwTv5QZkSKW2hVB42FhlJVhxMBXRPMPJYUVXXLjQsJHFsnrbX90vaAY6WzdLIhB5NwYyBoJhtNRbpgK6V2NKMh1qJaOwTAERAbG66k1d7iNVp4EupqQRi9J8mE4DwunBbPOpYScRFvCm1duqaD2hLcq5nE51ldCKg9R3oRCr9nEuuHPHHw/2R7/VMaNEOuKATmMr0+inT9R83l3eh7adVyBDDpB891o5BTJrxb8qskiKrkRW9i+CjSGVmAhGhCWPBYF8cYx25AeS4BrlCiIaohyFrHoyI2Z8NaRu/pxI9NGe2FgsKBgNWRTevXBF9rSUKXrcLyPJgmhZlWcYoQlTHRkZZ8HXO8Sle2yf/CCG5HQK3OO+PgLMmOLVYztZoHCeBEfWttCJSPwA+NPzUW5g3tAXy+PAyxlV9Z2khlEN+Q9UlGhLIZtZS4CiigNQbEFdEalTn9BMiukdXBZSKN7qk4Zsp4263OqrD0565MnALULPaEX7eYflHlPksURW/y51uhq5tyDnC30UeeAzRV/SF2ju1laOGlBKCGvzcqpnAE4tG/BMdY/H+bi3SZrVvHhffmEZjHOOuwh5f3YfhtKAOm2/8kXQILhfmnzLUob+eHeNivPtnniMKYQ6NvBSwuvCiwO1/IA4/Q+JEdK8KwqtCQUwA62y5UOtIBZs/X0O0T3Xbx4aNomNMvHFAyiF//em/L9GYZbUpA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(376002)(136003)(346002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(82310400011)(40470700004)(36840700001)(46966006)(478600001)(8676002)(8936002)(6666004)(70206006)(54906003)(110136005)(316002)(47076005)(2616005)(70586007)(36860700001)(26005)(1076003)(426003)(336012)(4326008)(16526019)(5660300002)(44832011)(2906002)(41300700001)(83380400001)(36756003)(82740400003)(81166007)(356005)(86362001)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 17:12:43.5449
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43f96daa-fcad-45b6-d8a7-08dc0d485d7e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5687

The notifyq rides on the adminq's interrupt, so there's
no need to setup and/or access the notifyq's interrupt
index or bound_intr. The driver sets the bound_intr
using  qcq->intx = -1 for the notifyq, but luckily
nothing accesses that field for notifyq. Instead of
expecting that remains the case, just clean up
the notifyq's interrupt index and bound_intr fields.

Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/amd/pds_core/core.c    | 5 +----
 drivers/net/ethernet/amd/pds_core/debugfs.c | 3 ++-
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/core.c b/drivers/net/ethernet/amd/pds_core/core.c
index 023a59c8e425..5426ab5de66b 100644
--- a/drivers/net/ethernet/amd/pds_core/core.c
+++ b/drivers/net/ethernet/amd/pds_core/core.c
@@ -129,6 +129,7 @@ static int pdsc_qcq_intr_alloc(struct pdsc *pdsc, struct pdsc_qcq *qcq)
 	if (index < 0)
 		return index;
 	qcq->intx = index;
+	qcq->cq.bound_intr = &pdsc->intr_info[index];
 
 	return 0;
 }
@@ -222,7 +223,6 @@ int pdsc_qcq_alloc(struct pdsc *pdsc, unsigned int type, unsigned int index,
 		goto err_out_free_irq;
 	}
 
-	qcq->cq.bound_intr = &pdsc->intr_info[qcq->intx];
 	qcq->cq.num_descs = num_descs;
 	qcq->cq.desc_size = cq_desc_size;
 	qcq->cq.tail_idx = 0;
@@ -433,9 +433,6 @@ int pdsc_setup(struct pdsc *pdsc, bool init)
 	if (err)
 		goto err_out_teardown;
 
-	/* NotifyQ rides on the AdminQ interrupt */
-	pdsc->notifyqcq.intx = pdsc->adminqcq.intx;
-
 	/* Set up the Core with the AdminQ and NotifyQ info */
 	err = pdsc_core_init(pdsc);
 	if (err)
diff --git a/drivers/net/ethernet/amd/pds_core/debugfs.c b/drivers/net/ethernet/amd/pds_core/debugfs.c
index 8ec392299b7d..dd6aaeecfe0a 100644
--- a/drivers/net/ethernet/amd/pds_core/debugfs.c
+++ b/drivers/net/ethernet/amd/pds_core/debugfs.c
@@ -105,7 +105,6 @@ void pdsc_debugfs_add_qcq(struct pdsc *pdsc, struct pdsc_qcq *qcq)
 	struct dentry *qcq_dentry, *q_dentry, *cq_dentry;
 	struct dentry *intr_dentry;
 	struct debugfs_regset32 *intr_ctrl_regset;
-	struct pdsc_intr_info *intr = &pdsc->intr_info[qcq->intx];
 	struct pdsc_queue *q = &qcq->q;
 	struct pdsc_cq *cq = &qcq->cq;
 
@@ -143,6 +142,8 @@ void pdsc_debugfs_add_qcq(struct pdsc *pdsc, struct pdsc_qcq *qcq)
 	debugfs_create_u16("tail", 0400, cq_dentry, &cq->tail_idx);
 
 	if (qcq->flags & PDS_CORE_QCQ_F_INTR) {
+		struct pdsc_intr_info *intr = &pdsc->intr_info[qcq->intx];
+
 		intr_dentry = debugfs_create_dir("intr", qcq->dentry);
 		if (IS_ERR_OR_NULL(intr_dentry))
 			return;
-- 
2.17.1



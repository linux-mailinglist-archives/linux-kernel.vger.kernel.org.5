Return-Path: <linux-kernel+bounces-17001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C073D824709
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 18:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0B391C240F3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C2B2D614;
	Thu,  4 Jan 2024 17:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LG5xPR1P"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657282C851;
	Thu,  4 Jan 2024 17:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NFYCAi8Q5t1l/fZwEhy1MGipf9Ua7Wm7XOMWnnvE0v1KjW50h7GfasOO7f/ZhwiyD2SXaqvqYx/u11JUVPyGwf8cupBWxuAb8/DdtBVHbhRgB9eQGUzOnV7ig3pJUcp9g7PIXvi+Z+MtGx0Qo0aOeGFKhuMt/6G8FaM6FbqmVvJMjA5kszd4zi3m3Io9rzXU2cA6RRiGMiUbuW/inMB/kQXRhexX0LiIZPG+XgPbgDoSdw++Gifb03iIxhQuj0Y2b0PdHW5QXlG9ee8QikX8ii8yhXHetXJliiCJBL6EHO8VgsRxdAtFnzsvzIDxuq/qYQquV1nsQXcYP0DBW9dHSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vBhNvqaRMdtFzSqi5mm/2MbuFLYYK6P5oiVtXFHeKKI=;
 b=BZH2wq6wg4oSl6/LbNxZphtiz8ctBPfXJgbtpHgezkmJ/IXytkffsyUgr6kAf3X5DuUTTJoInCXx5H+1XjNLiXMmzRlVu3OjsXrALEA7rAEIQWhxKGMG4PCoaxBUXQKQyUZRk0HLVKEdeCJ4anEF+SIQvEOeyHDjFLcQNcL67QLC/enWNDtnVHmuxOmQ0sMZrxZXhmF1JDqiwKeLdM1Jfex21XJwR9Xl7E9l50dOR5laLZN8yjoXQsWi2n1tfnXe5gRS/M1p6ZEx5eKW5bSSYnUkl9jlOt7e28vOuwIFAwQ6V8bUYyfR61iFKtXpIgnAkyIEG9j1hGBmNcu2/nXcXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vBhNvqaRMdtFzSqi5mm/2MbuFLYYK6P5oiVtXFHeKKI=;
 b=LG5xPR1PwggKIVnHTezif/Jc9vXARR63jNiAbvn0WCOMzIsMXy3qncyBiwy5BHyGe/zfh5+ZtRoCYa4jbIJh4JqkOqeimtXqIFtGfquu8TC1rdWQ9OZrqhp5J8pXC5gIyV+7tQPrum8+2nJ1kqo64OTyqlvqKctt+/N0jCMNvCs=
Received: from DS7PR03CA0236.namprd03.prod.outlook.com (2603:10b6:5:3ba::31)
 by PH0PR12MB5629.namprd12.prod.outlook.com (2603:10b6:510:141::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.15; Thu, 4 Jan
 2024 17:12:42 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:5:3ba:cafe::e6) by DS7PR03CA0236.outlook.office365.com
 (2603:10b6:5:3ba::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16 via Frontend
 Transport; Thu, 4 Jan 2024 17:12:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Thu, 4 Jan 2024 17:12:41 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 4 Jan
 2024 11:12:37 -0600
From: Brett Creeley <brett.creeley@amd.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <shannon.nelson@amd.com>, <brett.creeley@amd.com>
Subject: [PATCH net-next 3/8] pds_core: Use struct pdsc for the pdsc_adminq_isr private data
Date: Thu, 4 Jan 2024 09:12:16 -0800
Message-ID: <20240104171221.31399-4-brett.creeley@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|PH0PR12MB5629:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ef2253b-a7c1-4d81-32e4-08dc0d485c76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0UmF/kWaqEwjrduKNfab4GwOxflMIzRsAamJgiIxh/2BaWTWx3RO5tN4ol/7mwZ3D/yMRDzRvQW4OVHYg+A2IEFx9LyQSjlzU54IF1T+tcGuIccpvK6jcaWZG6/ckGgujMPtqwXyLNmNr9PUCy1qWCJCq/fAU06Pe3aR70mfyjFj1Vi+svCfmOiNznyIlSPU40wiQnXClWGzuow4Nt6Hi5ZCkt+uz/3suY7rj4E3Zv6aPInEJRJFpY79fiEFJJyAT5nPK5BsrKcKpEMxIUE98U3F3oH2U4d7yQlA8A4vG5GC6IRfwB6Xr+co1TzZXjTq+YukIT1BO8D+BWs44oJCrvHu6ONoJJ0jeIyJZMx+r1ScuRm5Z1ExAFNPs5gz5dq44pjjNr7P15NkNBvVWKuZkKye/f5tXDH8wDmWGscB0B1NQSX/UMln67jcXmT05FpsnqPubZTbHcaRQYW6CDx+S+94a4bnc6g2IFGeE3R8BOoxRUREI8J0AqZvUXSxeZYlWUOCqYN7T58XM3Xg7icAcumPPVWaS3GuUDlchHtPOjIc7+pSdbABIAEL7Um8O70cRAzol6TxA/DDo+9sz/8Jyf1CuOEKEodk0AlQdOp+3+0K4paQqh+zTsK93s63jxX7wCHhOWF6Ept2kT6dbHSvsPlu/FokaPSr+G6OrMmWDscRB7Jyv+SLE4NRmHFs+geBrl5nWK5MjYVzyQBDBQ6+C0b39JZY7p8aX7/omB/Fmrt7qlNFMdo3tCqvJke726mVPp5wom2i988dtCHV/2J6Dg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(396003)(346002)(136003)(230922051799003)(82310400011)(186009)(1800799012)(64100799003)(451199024)(36840700001)(46966006)(40470700004)(40460700003)(40480700001)(2616005)(336012)(1076003)(426003)(6666004)(478600001)(26005)(86362001)(36860700001)(36756003)(82740400003)(356005)(81166007)(2906002)(16526019)(41300700001)(47076005)(83380400001)(70586007)(5660300002)(44832011)(8676002)(110136005)(316002)(54906003)(70206006)(4326008)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 17:12:41.8574
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ef2253b-a7c1-4d81-32e4-08dc0d485c76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5629

The initial design for the adminq interrupt was done based
on client drivers having their own adminq and adminq
interrupt. So, each client driver's adminq isr would use
their specific adminqcq for the private data struct. For the
time being the design has changed to only use a single
adminq for all clients. So, instead use the struct pdsc for
the private data to simplify things a bit.

This also has the benefit of not dereferencing the adminqcq
to access the pdsc struct when the PDSC_S_STOPPING_DRIVER bit
is set and the adminqcq has actually been cleared/freed.

Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/amd/pds_core/adminq.c | 5 +++--
 drivers/net/ethernet/amd/pds_core/core.c   | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/adminq.c b/drivers/net/ethernet/amd/pds_core/adminq.c
index 5beadabc2136..68be5ea251fc 100644
--- a/drivers/net/ethernet/amd/pds_core/adminq.c
+++ b/drivers/net/ethernet/amd/pds_core/adminq.c
@@ -135,8 +135,8 @@ void pdsc_work_thread(struct work_struct *work)
 
 irqreturn_t pdsc_adminq_isr(int irq, void *data)
 {
-	struct pdsc_qcq *qcq = data;
-	struct pdsc *pdsc = qcq->pdsc;
+	struct pdsc *pdsc = data;
+	struct pdsc_qcq *qcq;
 
 	/* Don't process AdminQ when shutting down */
 	if (pdsc->state & BIT_ULL(PDSC_S_STOPPING_DRIVER)) {
@@ -145,6 +145,7 @@ irqreturn_t pdsc_adminq_isr(int irq, void *data)
 		return IRQ_HANDLED;
 	}
 
+	qcq = &pdsc->adminqcq;
 	queue_work(pdsc->wq, &qcq->work);
 	pds_core_intr_mask(&pdsc->intr_ctrl[qcq->intx], PDS_CORE_INTR_MASK_CLEAR);
 
diff --git a/drivers/net/ethernet/amd/pds_core/core.c b/drivers/net/ethernet/amd/pds_core/core.c
index b582729331eb..0356e56a6e99 100644
--- a/drivers/net/ethernet/amd/pds_core/core.c
+++ b/drivers/net/ethernet/amd/pds_core/core.c
@@ -125,7 +125,7 @@ static int pdsc_qcq_intr_alloc(struct pdsc *pdsc, struct pdsc_qcq *qcq)
 
 	snprintf(name, sizeof(name), "%s-%d-%s",
 		 PDS_CORE_DRV_NAME, pdsc->pdev->bus->number, qcq->q.name);
-	index = pdsc_intr_alloc(pdsc, name, pdsc_adminq_isr, qcq);
+	index = pdsc_intr_alloc(pdsc, name, pdsc_adminq_isr, pdsc);
 	if (index < 0)
 		return index;
 	qcq->intx = index;
-- 
2.17.1



Return-Path: <linux-kernel+bounces-16999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF81824703
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 18:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13984B23573
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF012CCD1;
	Thu,  4 Jan 2024 17:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Z1WEPRj3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2064.outbound.protection.outlook.com [40.107.212.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55ADD2C6A7;
	Thu,  4 Jan 2024 17:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NZy9921I/cxsmM/mT4Nu6xs4pMk/lwFeuRuBCsfeR02Fk8/hcJfJEymeXQPRUeF5MV4aoT2wBMeg6kPblEI1/e9aHe9bBggIq6YZ6yOF/nTKyaLu4YwIBIimcuxe1Zp0tEnSH+hqRxql7Cyr9AGtjjo4ThNr51qb2dWhhclBuJ8JDHeBD6oQYQJnr4jVCcNvtLTdjaDvODffiCi1ogAB8MM6T7gqb+qn/Elw3PP6aL8KLpDMqHRhNnyFS703PFA0t7Kax5Zl3KZQO9ylpWOjnsYg0kfjzDOArVbXGPzUDqoqtNHnvXUY+YjL8FAKFt6rbEFN1JAP9DHrFYz53jasdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z22fZj2ZslWdm6XMDtUt/mFJgscRVo8cTrG8iqZ2EZ0=;
 b=dRkKKe7peQ6o3Was7qwl8tiCdI1hD5gfrsLdYXmeRa7+Le3dZejZyOJSjYxvkA8PfQzFrbCk1odBIZyrmd4nnC1jBN/J3OXMsOA71lAOpgq4zvHxeGDRMau55vR6G3+33H9z9D9GIn1UZgT3stRwsTvhL0G3lizuWuNeENXqMNbvwdj38tHlMvM91KyUP3z1C8Dmpws+Rfa3/G+S7tWCva/POt+QdblO/0wIn8TsIHAGOB1alF/11u10jjM0ulrQdkYClfa3FUz7Py4UdqbQDuuBiE6QcjmyWVhgHMhd7OZ0xsJuW7xYgNtDVZtojlIROxC4EKh4qjSu8AhY/wSPfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z22fZj2ZslWdm6XMDtUt/mFJgscRVo8cTrG8iqZ2EZ0=;
 b=Z1WEPRj3ymfCEHKMOvRxyh4KsV13E/6QHM2ExbNIuIYkgZnq/hkEAUrj/KhPVIpegTwOmc4Y6UCacBWuFpLU1Lr7k2jCscuYNa3ZVattrQZWJmXkds0cgtYbCS2bbZVbol2wT6Ae0Q/+FldkUXCfJP+bTxq/uVjaWMlfF3Gi2B0=
Received: from DS7PR03CA0227.namprd03.prod.outlook.com (2603:10b6:5:3ba::22)
 by BL0PR12MB4916.namprd12.prod.outlook.com (2603:10b6:208:1ce::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.15; Thu, 4 Jan
 2024 17:12:44 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:5:3ba:cafe::e6) by DS7PR03CA0227.outlook.office365.com
 (2603:10b6:5:3ba::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16 via Frontend
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
 2024 11:12:41 -0600
From: Brett Creeley <brett.creeley@amd.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <shannon.nelson@amd.com>, <brett.creeley@amd.com>
Subject: [PATCH net-next 7/8] pds_core: Unmask adminq interrupt in work thread
Date: Thu, 4 Jan 2024 09:12:20 -0800
Message-ID: <20240104171221.31399-8-brett.creeley@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|BL0PR12MB4916:EE_
X-MS-Office365-Filtering-Correlation-Id: dd5ec5b9-2a6a-457c-8611-08dc0d485dcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8UF4zK/v1626phqqoEAplBYhRsDH0UeLcou7dC10uAnRKk5ZdTRonpTYb5Z7PRL+6M9u9ehFzoVkhVFf3lXSEN1Q1fNpOpd4zoscDEG6pQJA+dvGwWRBNskBlvVgDl455IJsdlhtoAtzy/7l7H1pMt6QMdqOEmd+m/pjmmKSZXwP7/TFJ3gLD6KWaJDuZ013byFRS693uS8ScvxNdytjT432lEvFmuwX7cg8Wacge/HGpmxABG9dOHmdlzWA2HKVtMJJE5Mf8qjmOPNSwreNR3BSa32+PraslBH0fqLdYRdAya1/aQxByaBikK62dss/Vvk7cgJXuFeh/O1jYKqMb9b0R7XGTFZv1ffhqBkSwLCfIr9/D7PXzepjIS3hnE8HF1/4YNCw/RFc6uHHuX78Cm5Ps9p1kb5cPv+4NTwsZeyJfsbooRdrriVYQxoFnj6zo4IsREf//yQXLI9LU0kxfQJ/T4bc7q9ILxZg40WR7fr7MRITRR46T9Kqi7Qs3itIV5GZC+VT44tPg/OqzMXa9+aGJ2rs+HdPZAtZChmvJS+ZLO6JJNcvszrRg0iNJgOiaJlBz03u9DFb+OYjZ8WdGnPRgQ/vo1FCwd8lYeq+c+ifaWJP7QdlXm8O/bL1TVJwAfTY+KXirQ4EcaTnQ8/+onDirgA4F98Id3i9Xe8tZNPbz46YWiqG0PaCnea/UPMtPdbATTysUchsAWRQc6LjUFoREDFLOwZ5EPTPEivdJpsCttrjo4PkuFKf/UgrOaBrw9bXTb7NrFM/iJV+9sRsCA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(136003)(376002)(346002)(230922051799003)(82310400011)(186009)(64100799003)(1800799012)(451199024)(36840700001)(40470700004)(46966006)(36860700001)(47076005)(40480700001)(1076003)(16526019)(426003)(26005)(2616005)(336012)(40460700003)(83380400001)(478600001)(41300700001)(6666004)(4326008)(70586007)(110136005)(70206006)(316002)(8936002)(54906003)(36756003)(8676002)(44832011)(82740400003)(81166007)(356005)(86362001)(2906002)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 17:12:44.1387
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd5ec5b9-2a6a-457c-8611-08dc0d485dcd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4916

Unmasking the interrupt during the pdsc_adminq_isr
is a bit early and could cause unnecessary interrupts.
Instead always unmask after processing the adminq
and notifyq in pdsc_work_thread()->pdsc_process_adminq().
Also, since we are always unmasking, there's no need
for the local credits variable in pdsc_process_adminq().

Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/amd/pds_core/adminq.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/adminq.c b/drivers/net/ethernet/amd/pds_core/adminq.c
index ea773cfa0af6..c83a0a80d533 100644
--- a/drivers/net/ethernet/amd/pds_core/adminq.c
+++ b/drivers/net/ethernet/amd/pds_core/adminq.c
@@ -82,7 +82,6 @@ void pdsc_process_adminq(struct pdsc_qcq *qcq)
 	unsigned long irqflags;
 	int nq_work = 0;
 	int aq_work = 0;
-	int credits;
 
 	/* Don't process AdminQ when it's not up */
 	if (!pdsc_adminq_inc_if_up(pdsc)) {
@@ -128,11 +127,9 @@ void pdsc_process_adminq(struct pdsc_qcq *qcq)
 
 credits:
 	/* Return the interrupt credits, one for each completion */
-	credits = nq_work + aq_work;
-	if (credits)
-		pds_core_intr_credits(&pdsc->intr_ctrl[qcq->intx],
-				      credits,
-				      PDS_CORE_INTR_CRED_REARM);
+	pds_core_intr_credits(&pdsc->intr_ctrl[qcq->intx],
+			      nq_work + aq_work,
+			      PDS_CORE_INTR_CRED_REARM);
 	refcount_dec(&pdsc->adminq_refcnt);
 }
 
@@ -157,7 +154,6 @@ irqreturn_t pdsc_adminq_isr(int irq, void *data)
 
 	qcq = &pdsc->adminqcq;
 	queue_work(pdsc->wq, &qcq->work);
-	pds_core_intr_mask(&pdsc->intr_ctrl[qcq->intx], PDS_CORE_INTR_MASK_CLEAR);
 	refcount_dec(&pdsc->adminq_refcnt);
 
 	return IRQ_HANDLED;
-- 
2.17.1



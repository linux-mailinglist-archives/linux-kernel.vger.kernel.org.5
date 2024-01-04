Return-Path: <linux-kernel+bounces-16998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BD48246FF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 18:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B03EFB247FE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB062C857;
	Thu,  4 Jan 2024 17:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZVtuwFWT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442E828DB9;
	Thu,  4 Jan 2024 17:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NgHAUJZQQJGOZ9gATJByf3+7y0lwKBtotpqvC8fxuQxHCUs5YvRc9FMogSlvGBPR/LUXmO3INHxH6v5ENqE/TNIhJdDxq03hXWCeRQzzv/9KU9Ic4/dgI3H79VKgoBjtA6w2RMOC8aeCxPbV2v95I9U9XwbvILhOoh+N8GIa/i+rxuxjfu5ib2akC/XOI0oNNXCci0/ScPjHn+Ecd3sZm/H7lGPd9YjNY/pvBdb9Rfhxi6gsY6/ivjuDrDhGH9B/1RJBwGR9g2C4Tg4rRr3G0C8t9JMl1qKL3SHeWuCfKGNlMOzYu0DIaRqhADnc2S/x1qKUDrSEXpxuVPWtXjk+ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jhVBXH+IltD3kpoJwfm00H6Rnk41GD9XT2RASqKLOYg=;
 b=aEa/GTDVshEIE36kJPDPuVsgfcTphSjBCEqVAHYd+v11bZJuY4FNVftOiSGOaOgbpADnNO3uqKzlHbuiN6WiH0n5ANOdUgMTjY+IIx+kBECwLiuWXt5zIbAF2zs7hI+nUb/bGeO174+ykq269rPKhN6Gp7ABD46evs9HhkQFWbr7RSCaGu1jK9afKI/Acal2HS3UnzvvyJ8gDRm0i7mSeKsgB0g5Av3DlZEYVhxE1G2SLKE6FvpKXDIIvIWhIPCFaWHqpb8ab1fBJlofv1sUdkXZNmj41RJxADtYAYBnI7rL/i6bcw0aRF1T93T6idvOhprMEBV12PnRQh+FbKp4qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jhVBXH+IltD3kpoJwfm00H6Rnk41GD9XT2RASqKLOYg=;
 b=ZVtuwFWT/mDYLx9nEV3fEUqycDHT3+Dppr/WRZwkzEX1oDx69OSiga7CiG+kja3JNBi2ZdU7mwDDwmnSV75R8BD+2g1GfJ7gWZuIddETxjk6Fwl33zAX1pm2qlCvWFsvJy8bsneamaT2i44lvcmuqizWPYYc7xetD5FA50aokxw=
Received: from DS7PR03CA0220.namprd03.prod.outlook.com (2603:10b6:5:3ba::15)
 by SA1PR12MB8142.namprd12.prod.outlook.com (2603:10b6:806:334::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.15; Thu, 4 Jan
 2024 17:12:43 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:5:3ba:cafe::b9) by DS7PR03CA0220.outlook.office365.com
 (2603:10b6:5:3ba::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13 via Frontend
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
 15.20.7159.9 via Frontend Transport; Thu, 4 Jan 2024 17:12:42 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 4 Jan
 2024 11:12:39 -0600
From: Brett Creeley <brett.creeley@amd.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <shannon.nelson@amd.com>, <brett.creeley@amd.com>
Subject: [PATCH net-next 5/8] pds_core: Clear BARs on reset
Date: Thu, 4 Jan 2024 09:12:18 -0800
Message-ID: <20240104171221.31399-6-brett.creeley@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|SA1PR12MB8142:EE_
X-MS-Office365-Filtering-Correlation-Id: cf419c8f-dd04-4246-0398-08dc0d485d29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xJ3Syczm38eTP9R2kqZ222Q91A3Zz4BQIU6nz/o+Yei2fvfAlRer4YZjIcbwC6H0pVk3fM3F3eZFJao9AZ5w9qJprkoiaVQfW0uRwaSMlELcDniBXdwRisbKO/2E77zRmKTD61DIkM/1mr1tA1g5byJLXpaTmKF6IYhVvRv447fg7gIsXuEWAsAiG3A+gt3V4x/qw1c00t1zbOGOojADyF0sZosRXP0rXKtUDzlhEne1C18qIGib8Nwfrs7Czk3BbZQhau1uhcQ4W7+S0cxmawSRkspL/kGbE/Tt/ENFs0Gx14/ShiKN820zuwIjWaqLqcV2we/FXliAedpkZI1XEJNV0+3s7ljO2WEZl56wj9cH1wj+i7sQqQ2ch/97/1RBSxWhrT0h0jruobcYUeyiC8XdKAAplqkPBW86pRxN+FIw1fNcAUKMxnF0NLdgwLVaArwzKLiZTjVzi8dAWiim5fxFaDiD/F4/aJiRPIavctvjWAhpJ1AgykhoOJdpXuAEg+aVhyfC3t6fwJn1+vhoTTY3aQjFN+Y2Ynmpm/NzqGYFe+ir3gqIg8Ng+Nn2W+zLIyxoY0CSbtI3OvipEBpkwBKZXUr8+hr8+/ybzPn7TILEyE+5c7Bavi21UCp4bpKzl5AO7GfVLLA4YZ6R03EMvsrOrU2BGN65CyDT3GFPdLKcpJAHVpJRgbkwv47F1iiuOveGJFFVrTp+zK/bQx4/01hW64cYhNzg/VB2AFcjCMTjYUetNETuEY/pVbvEsF3qkqM9fqpItlIrcTHR8dNYbg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(39860400002)(376002)(136003)(230922051799003)(186009)(64100799003)(82310400011)(451199024)(1800799012)(40470700004)(46966006)(36840700001)(426003)(26005)(2616005)(1076003)(336012)(6666004)(478600001)(47076005)(16526019)(83380400001)(41300700001)(2906002)(4326008)(316002)(8936002)(54906003)(70206006)(110136005)(70586007)(44832011)(8676002)(36860700001)(5660300002)(82740400003)(86362001)(36756003)(81166007)(356005)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 17:12:42.9980
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf419c8f-dd04-4246-0398-08dc0d485d29
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8142

During reset the BARs might be accessed when they are
unmapped. This can cause unexpected issues, so fix it by
clearing the cached BAR values so they are not accessed
until they are re-mapped.

Also, make sure any places that can access the BARs
when they are NULL are prevented.

Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/amd/pds_core/adminq.c  | 28 +++++++++++++++------
 drivers/net/ethernet/amd/pds_core/core.c    |  8 +++++-
 drivers/net/ethernet/amd/pds_core/dev.c     |  9 ++++++-
 drivers/net/ethernet/amd/pds_core/devlink.c |  3 ++-
 drivers/net/ethernet/amd/pds_core/fw.c      |  3 +++
 drivers/net/ethernet/amd/pds_core/main.c    |  5 ++++
 6 files changed, 45 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/adminq.c b/drivers/net/ethernet/amd/pds_core/adminq.c
index 5edff33d56f3..ea773cfa0af6 100644
--- a/drivers/net/ethernet/amd/pds_core/adminq.c
+++ b/drivers/net/ethernet/amd/pds_core/adminq.c
@@ -191,10 +191,16 @@ static int __pdsc_adminq_post(struct pdsc *pdsc,
 
 	/* Check that the FW is running */
 	if (!pdsc_is_fw_running(pdsc)) {
-		u8 fw_status = ioread8(&pdsc->info_regs->fw_status);
-
-		dev_info(pdsc->dev, "%s: post failed - fw not running %#02x:\n",
-			 __func__, fw_status);
+		if (pdsc->info_regs) {
+			u8 fw_status =
+				ioread8(&pdsc->info_regs->fw_status);
+
+			dev_info(pdsc->dev, "%s: post failed - fw not running %#02x:\n",
+				 __func__, fw_status);
+		} else {
+			dev_info(pdsc->dev, "%s: post failed - BARs not setup\n",
+				 __func__);
+		}
 		ret = -ENXIO;
 
 		goto err_out_unlock;
@@ -266,10 +272,16 @@ int pdsc_adminq_post(struct pdsc *pdsc,
 			break;
 
 		if (!pdsc_is_fw_running(pdsc)) {
-			u8 fw_status = ioread8(&pdsc->info_regs->fw_status);
-
-			dev_dbg(pdsc->dev, "%s: post wait failed - fw not running %#02x:\n",
-				__func__, fw_status);
+			if (pdsc->info_regs) {
+				u8 fw_status =
+					ioread8(&pdsc->info_regs->fw_status);
+
+				dev_dbg(pdsc->dev, "%s: post wait failed - fw not running %#02x:\n",
+					__func__, fw_status);
+			} else {
+				dev_dbg(pdsc->dev, "%s: post wait failed - BARs not setup\n",
+					__func__);
+			}
 			err = -ENXIO;
 			break;
 		}
diff --git a/drivers/net/ethernet/amd/pds_core/core.c b/drivers/net/ethernet/amd/pds_core/core.c
index 3b3e1541dd1c..023a59c8e425 100644
--- a/drivers/net/ethernet/amd/pds_core/core.c
+++ b/drivers/net/ethernet/amd/pds_core/core.c
@@ -600,7 +600,13 @@ void pdsc_fw_up(struct pdsc *pdsc)
 
 static void pdsc_check_pci_health(struct pdsc *pdsc)
 {
-	u8 fw_status = ioread8(&pdsc->info_regs->fw_status);
+	u8 fw_status;
+
+	/* some sort of teardown already in progress */
+	if (!pdsc->info_regs)
+		return;
+
+	fw_status = ioread8(&pdsc->info_regs->fw_status);
 
 	/* is PCI broken? */
 	if (fw_status != PDS_RC_BAD_PCI)
diff --git a/drivers/net/ethernet/amd/pds_core/dev.c b/drivers/net/ethernet/amd/pds_core/dev.c
index 31940b857e0e..62a38e0a8454 100644
--- a/drivers/net/ethernet/amd/pds_core/dev.c
+++ b/drivers/net/ethernet/amd/pds_core/dev.c
@@ -57,6 +57,9 @@ int pdsc_err_to_errno(enum pds_core_status_code code)
 
 bool pdsc_is_fw_running(struct pdsc *pdsc)
 {
+	if (!pdsc->info_regs)
+		return false;
+
 	pdsc->fw_status = ioread8(&pdsc->info_regs->fw_status);
 	pdsc->last_fw_time = jiffies;
 	pdsc->last_hb = ioread32(&pdsc->info_regs->fw_heartbeat);
@@ -182,13 +185,17 @@ int pdsc_devcmd_locked(struct pdsc *pdsc, union pds_core_dev_cmd *cmd,
 {
 	int err;
 
+	if (!pdsc->cmd_regs)
+		return -ENXIO;
+
 	memcpy_toio(&pdsc->cmd_regs->cmd, cmd, sizeof(*cmd));
 	pdsc_devcmd_dbell(pdsc);
 	err = pdsc_devcmd_wait(pdsc, cmd->opcode, max_seconds);
-	memcpy_fromio(comp, &pdsc->cmd_regs->comp, sizeof(*comp));
 
 	if ((err == -ENXIO || err == -ETIMEDOUT) && pdsc->wq)
 		queue_work(pdsc->wq, &pdsc->health_work);
+	else
+		memcpy_fromio(comp, &pdsc->cmd_regs->comp, sizeof(*comp));
 
 	return err;
 }
diff --git a/drivers/net/ethernet/amd/pds_core/devlink.c b/drivers/net/ethernet/amd/pds_core/devlink.c
index e9948ea5bbcd..54864f27c87a 100644
--- a/drivers/net/ethernet/amd/pds_core/devlink.c
+++ b/drivers/net/ethernet/amd/pds_core/devlink.c
@@ -111,7 +111,8 @@ int pdsc_dl_info_get(struct devlink *dl, struct devlink_info_req *req,
 
 	mutex_lock(&pdsc->devcmd_lock);
 	err = pdsc_devcmd_locked(pdsc, &cmd, &comp, pdsc->devcmd_timeout * 2);
-	memcpy_fromio(&fw_list, pdsc->cmd_regs->data, sizeof(fw_list));
+	if (!err)
+		memcpy_fromio(&fw_list, pdsc->cmd_regs->data, sizeof(fw_list));
 	mutex_unlock(&pdsc->devcmd_lock);
 	if (err && err != -EIO)
 		return err;
diff --git a/drivers/net/ethernet/amd/pds_core/fw.c b/drivers/net/ethernet/amd/pds_core/fw.c
index 90a811f3878a..fa626719e68d 100644
--- a/drivers/net/ethernet/amd/pds_core/fw.c
+++ b/drivers/net/ethernet/amd/pds_core/fw.c
@@ -107,6 +107,9 @@ int pdsc_firmware_update(struct pdsc *pdsc, const struct firmware *fw,
 
 	dev_info(pdsc->dev, "Installing firmware\n");
 
+	if (!pdsc->cmd_regs)
+		return -ENXIO;
+
 	dl = priv_to_devlink(pdsc);
 	devlink_flash_update_status_notify(dl, "Preparing to flash",
 					   NULL, 0, 0);
diff --git a/drivers/net/ethernet/amd/pds_core/main.c b/drivers/net/ethernet/amd/pds_core/main.c
index 5172a5ad8ec6..05fdeb235e5f 100644
--- a/drivers/net/ethernet/amd/pds_core/main.c
+++ b/drivers/net/ethernet/amd/pds_core/main.c
@@ -37,6 +37,11 @@ static void pdsc_unmap_bars(struct pdsc *pdsc)
 	struct pdsc_dev_bar *bars = pdsc->bars;
 	unsigned int i;
 
+	pdsc->info_regs = NULL;
+	pdsc->cmd_regs = NULL;
+	pdsc->intr_status = NULL;
+	pdsc->intr_ctrl = NULL;
+
 	for (i = 0; i < PDS_CORE_BARS_MAX; i++) {
 		if (bars[i].vaddr)
 			pci_iounmap(pdsc->pdev, bars[i].vaddr);
-- 
2.17.1



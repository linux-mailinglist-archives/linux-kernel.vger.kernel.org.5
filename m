Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 294AF75AEDA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 14:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbjGTMz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 08:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbjGTMzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 08:55:17 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFFA2722;
        Thu, 20 Jul 2023 05:55:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ciFG9DhHDbGUwpBvTMX/FFuQUf7IpqyMgcI62KAmtBs4+yOuhx6PuihWC5zthRedeVQCYcXmfpSWEMnFwxYOUM57XeYoKsgque9UiaExlMH3ckJNlcaY9WQanGgb/C68Tzsh6tX0zK3sud5j4Hbsg3DSNUDHMvlXvEE7nvygwt6HO7mHhBslnX2VN4C4A//xJ+pvi6Y17vsBry+SfZIL0CGHljxDSeDKER0I71pdS8RRtv3SFkIP6HAWVF3sm3WjOwgm/gmtbFOxv7+XWRgf0acGgsTla3VQLRLaM75AmQya7GCO9/iMNlIXTz73pDq0djTYV62D+VWLm8wgP33SpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U9yRez6h0uRSAITgN3HzUnO3UVFKjwjVboVPu2W1haY=;
 b=f9mOPxtawmepysmyhWp6hgQpWiggwXkZKnTTWww7WE53klrvU1P3aZ7dnantg+OBZ5gOuuB6exmzSnZo5ETtxyP5+Jc9cX0HfuQB0KxXry56vRzZ65UMFzXTplQpBVQ539vFrAzA5W9REkNk2ToxFrwgg9NlV0TBXWXfOKq7MCTwd2ElcygjxLuY/hnwsrhbX5r6Y+htW9jIzjXuNJC6Lxu40Oa8YTMkjh3PouPTD1zU9B/6r4IkYF5oUnFrCr6zHQKWwaAj02nsZXK6fKts7g2XiQiu1Gra5SSz9BPWxF4pxcsvp5xpHwO0E7BjPa4j09BtRqpcklYmdXCUVhYOMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U9yRez6h0uRSAITgN3HzUnO3UVFKjwjVboVPu2W1haY=;
 b=vWbpOmro9VM3aXVTVVVRhZyi1WSef3ZxfMlB5sTdviIT3vew+TzW7Vj0boPSxsKvG5Imoz3kem4FegidlOhgTbDrjmYfq3YatjBWWDlPzfJuaz0S0dtp//jB34INstBtYElzqEBYxUAjVamGVBIPaLXb3BlA43s2A6NL95BRHqQ=
Received: from BN9PR03CA0256.namprd03.prod.outlook.com (2603:10b6:408:ff::21)
 by MN2PR12MB4125.namprd12.prod.outlook.com (2603:10b6:208:1d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Thu, 20 Jul
 2023 12:55:00 +0000
Received: from BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ff:cafe::5f) by BN9PR03CA0256.outlook.office365.com
 (2603:10b6:408:ff::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.25 via Frontend
 Transport; Thu, 20 Jul 2023 12:55:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT017.mail.protection.outlook.com (10.13.177.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.34 via Frontend Transport; Thu, 20 Jul 2023 12:55:00 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 20 Jul
 2023 07:54:57 -0500
From:   Muralidhara M K <muralimk@amd.com>
To:     <linux-edac@vger.kernel.org>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <mingo@redhat.com>,
        <mchehab@kernel.org>, <nchatrad@amd.com>, <yazen.ghannam@amd.com>,
        Muralidhara M K <muralidhara.mk@amd.com>,
        Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
Subject: [PATCH 6/7] EDAC/amd64: Add error instance get_err_info() to pvt->ops
Date:   Thu, 20 Jul 2023 12:54:24 +0000
Message-ID: <20230720125425.3735538-7-muralimk@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230720125425.3735538-1-muralimk@amd.com>
References: <20230720125425.3735538-1-muralimk@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT017:EE_|MN2PR12MB4125:EE_
X-MS-Office365-Filtering-Correlation-Id: 8638fa0d-c730-40c9-4870-08db89208738
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6rg+zHz7NoaAdVrld3L2RELt40X9NJd6C3Vi2CEoJc4JXH4ToIofIh7typbWHaOYa6JwY3Bq/IUeeoJ8IrDw/G184hXW3RzygjPXZ9P/8OEnv8VAhhiwJlIjUrNMCsZLHMRcT7oBbWRtfKXnixpDta6TyavzVqjnXY85czKLE1bIJXMXIZWLyfBe5x2XoWqTLPjagw5rtbXrCTRKcsvrnYs1gjB4nGqw/AWL3Wp1Q25jCQINaIN434wVaeS1thQKJ2u7cFzkv74S7TLdt/vOAyjdpJXj19OS+/Bpt9E+cKVphLl0fQb5S1Ib2LA0jNqpWTZPegkdZxYdh7j+y+dOVgTmWupbzyMS7806mBqBlO449xYHYZ6JKkWAWr58lSG0yrNabRA2Xq3kjYd+f3Eufn4PmLHWi6sJ9GlWpjZ9NjCrzKo8fqQ4w4iN8Jpqx6wjOQgM1lZkoqzJ2EylrYFM+d/tvQZl14tw4IaazitRMKumKz6+VyZXcqbcZgVGvLobkUxhPNvsX5gZDB3ByE2AStHvIBMC3qF453EkexkcQ7ZeCjNQ2AFFeXLZXyYjeHmFGN5EEunK3xWgWmz9lHTwDv3oplVQGnoPD6pqzTV83oy2M+RcVQjtwv3120StQePD19Gnl25Wnzhqm1pBOJnI02QKrzykzG1x1KUfrQxspAXrfzZPiThgkxGx1aWxhtw1W0GHNMC/F7rOs8hTnNNTPv5j/8dqyOQ14RCb25nifFMxhIiRZAqxxMKAduL7l1zG6ZNpVMCNAhpRK7qQaH3s6g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(39860400002)(451199021)(82310400008)(36840700001)(46966006)(40470700004)(478600001)(83380400001)(336012)(1076003)(40480700001)(186003)(41300700001)(26005)(110136005)(54906003)(8676002)(8936002)(316002)(356005)(2906002)(426003)(4326008)(7696005)(36860700001)(70206006)(6666004)(81166007)(40460700003)(2616005)(16526019)(70586007)(47076005)(36756003)(82740400003)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 12:55:00.3159
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8638fa0d-c730-40c9-4870-08db89208738
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4125
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Muralidhara M K <muralidhara.mk@amd.com>

On CPUs the data fabric ID of an instance on a CPU is equal to the
UMC number. since the UMC number and channel are equal in CPU nodes,
the channel can be used as the data fabric ID of the instance.

GPU node has 'X' number of PHYs and 'Y' number of channels.
This results in 'X*Y' number of instances in the data fabric.
Therefore the data fabric ID of an instance in GPU as below:
  df_inst_id = 'X' * number of channels per PHY + 'Y'

Co-developed-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
Signed-off-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
---
 drivers/edac/amd64_edac.c | 36 +++++++++++++++++++++++++++++++++++-
 drivers/edac/amd64_edac.h |  2 ++
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 45d8093c117a..74b2b47cc22a 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -3047,6 +3047,17 @@ static inline void decode_bus_error(int node_id, struct mce *m)
 	__log_ecc_error(mci, &err, ecc_type);
 }
 
+/*
+ * On CPUs, The data fabric ID of an instance is equal to the UMC number.
+ * and since the UMC number and channel are equal in CPU nodes, the channel can be
+ * used as the data fabric ID of the instance.
+ */
+static int umc_inst_id(struct mem_ctl_info *mci, struct amd64_pvt *pvt,
+		       struct err_info *err)
+{
+	return err->channel;
+}
+
 /*
  * To find the UMC channel represented by this bank we need to match on its
  * instance_id. The instance_id of a bank is held in the lower 32 bits of its
@@ -3071,6 +3082,7 @@ static void decode_umc_error(int node_id, struct mce *m)
 	struct mem_ctl_info *mci;
 	struct amd64_pvt *pvt;
 	struct err_info err;
+	u8 df_inst_id;
 	u64 sys_addr;
 
 	node_id = fixup_node_id(node_id, m);
@@ -3101,8 +3113,9 @@ static void decode_umc_error(int node_id, struct mce *m)
 	}
 
 	pvt->ops->get_err_info(m, &err);
+	df_inst_id = pvt->ops->get_inst_id(mci, pvt, &err);
 
-	if (umc_normaddr_to_sysaddr(m->addr, pvt->mc_node_id, err.channel, &sys_addr)) {
+	if (umc_normaddr_to_sysaddr(m->addr, pvt->mc_node_id, df_inst_id, &sys_addr)) {
 		err.err_code = ERR_NORM_ADDR;
 		goto log_error;
 	}
@@ -3758,6 +3771,25 @@ static int umc_hw_info_get(struct amd64_pvt *pvt)
 	return 0;
 }
 
+/*
+ * A GPU node has 'X' number of PHYs and 'Y' number of channels.
+ * This results in 'X*Y' number of instances in the data fabric.
+ * Therefore the data fabric ID of an instance can be found with the following formula:
+ * df_inst_id = 'X' * number of channels per PHY + 'Y'
+ *
+ */
+static int gpu_inst_id(struct mem_ctl_info *mci, struct amd64_pvt *pvt,
+		       struct err_info *err)
+{
+	int i, channels = 0;
+
+	/* The memory channels in case of GPUs are fully populated */
+	for_each_umc(i)
+		channels += pvt->csels[i].b_cnt;
+
+	return (err->csrow * channels / mci->nr_csrows) + err->channel;
+}
+
 /*
  * The CPUs have one channel per UMC, so UMC number is equivalent to a
  * channel number. The GPUs have 8 channels per UMC, so the UMC number no
@@ -4015,6 +4047,7 @@ static struct low_ops umc_ops = {
 	.setup_mci_misc_attrs		= umc_setup_mci_misc_attrs,
 	.dump_misc_regs			= umc_dump_misc_regs,
 	.get_err_info			= umc_get_err_info,
+	.get_inst_id			= umc_inst_id,
 };
 
 static struct low_ops gpu_ops = {
@@ -4023,6 +4056,7 @@ static struct low_ops gpu_ops = {
 	.setup_mci_misc_attrs		= gpu_setup_mci_misc_attrs,
 	.dump_misc_regs			= gpu_dump_misc_regs,
 	.get_err_info			= gpu_get_err_info,
+	.get_inst_id			= gpu_inst_id,
 };
 
 /* Use Family 16h versions for defaults and adjust as needed below. */
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 5a4e4a59682b..d9e9e62dd4b1 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -471,6 +471,8 @@ struct low_ops {
 	void (*setup_mci_misc_attrs)(struct mem_ctl_info *mci);
 	void (*dump_misc_regs)(struct amd64_pvt *pvt);
 	void (*get_err_info)(struct mce *m, struct err_info *err);
+	int  (*get_inst_id)(struct mem_ctl_info *mci, struct amd64_pvt *pvt,
+			    struct err_info *err);
 };
 
 int __amd64_read_pci_cfg_dword(struct pci_dev *pdev, int offset,
-- 
2.25.1


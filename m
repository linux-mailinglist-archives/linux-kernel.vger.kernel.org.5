Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B85637BA82E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 19:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbjJERhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 13:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbjJERhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 13:37:15 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061242708;
        Thu,  5 Oct 2023 10:35:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RcSCs5q+YbBEzzTCz/djwfveEukAXBL46a889xlC/9Vykp2nETsTPjVLS/qHd83l0rqo+C0D5pXZL26wqu4DaYCDbRByt7L2A4hhzDsHR3/bkXV9c8a2TdHPhJvVdG0F70mCcTXlQ67ufvxJLB5fxukUH3kpsRuUFWKQYRthU9ux40Tt867gzPdg/i34EFbR4FHdMZr6dg0lYnrcnoprHvZseJ3A1s4QIK2NQh8q42lOPmJKlgwnr+aYESJDXwC3n3zHVvmP0hy6lpAdgtoE5XcFl+1OfVHWYm4UjSLxYuPTigpRWZ7orTbJTsdYarHcqDxuUlbBb5mJQO+JBSMG2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eYiqXfwwB+BVnZntf6YZoGreLfIj2/vRGPAvH5DbHTc=;
 b=WFGGltyNNfGocRRDkP4xTRoeImWIWxSDqhXJ9QOAz5LSmNWfjZaSMIcA+5QwHyeJ+/jNNBDgfSV+ROFmfALv4dbk/wmF/0ICbxO4Zmk5uiogYE5CPIQIA2D1ApRYuCLNPq4qCaCXnMMyylyqelTxFfunrrbU6j0JoHx05vaMWvfcSa6UOrhqgYOnNE4PpCWyS7LBpBUi/aQr1u0cpMNqZyGTmcxwV0czjTiY4G3zSkIZdsakjqyYhZb6OaIvbrCF0kSlLs1CZutfawJHhJqAspbqjEawXuB7ORCqRb1ZdIoBW4Uo77wUGb5nojLYrnFFrmQUUccFSYgkKGUBrhJBRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eYiqXfwwB+BVnZntf6YZoGreLfIj2/vRGPAvH5DbHTc=;
 b=aFgVJuTQjOOEXhbg3MYIh3mjhscchEFz6QChldreF76iYdjurV7ubIq5A18rPjcFhlAUP2zUwD2TaE2cHLHg/hGo+U4tyEwzIqgfbwZ2ZKqpk4i/7OrN5pK2tfu+iCLT1Vha67rRLoekx/RQT0ePEHOmdG56+f3JYktS+wuwzmE=
Received: from CH2PR16CA0020.namprd16.prod.outlook.com (2603:10b6:610:50::30)
 by BY5PR12MB4902.namprd12.prod.outlook.com (2603:10b6:a03:1dd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Thu, 5 Oct
 2023 17:35:50 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:610:50:cafe::6f) by CH2PR16CA0020.outlook.office365.com
 (2603:10b6:610:50::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33 via Frontend
 Transport; Thu, 5 Oct 2023 17:35:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Thu, 5 Oct 2023 17:35:50 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 5 Oct
 2023 12:35:49 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <bp@alien8.de>, <linux-edac@vger.kernel.org>, <tony.luck@intel.com>
CC:     <linux-kernel@vger.kernel.org>, <avadhut.naik@amd.com>,
        <john.allen@amd.com>, <william.roche@oracle.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v2 2/2] EDAC/amd64: Use new AMD Address Translation Library
Date:   Thu, 5 Oct 2023 12:35:26 -0500
Message-ID: <20231005173526.42831-3-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231005173526.42831-1-yazen.ghannam@amd.com>
References: <20231005173526.42831-1-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|BY5PR12MB4902:EE_
X-MS-Office365-Filtering-Correlation-Id: fc0fe85a-3251-481d-00ea-08dbc5c9848f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KDneJGxjRLfEoR6bUieX7HyrVzgvsFrtR5yt6ig/GgnfdDgMJY8UIPyMmoo86Up4CI8zxABWh390bubaz7vbAbRhiNcAPA5ZPKJeLEnJOsiCZMRF8GrLdHTYbBS9mUsmYeuUbwapeOmmpEZ71Cr/YN+ZtX8vIYwP9Wg5mkrq+yLxBgkAVr6xc+zo25xdOtw6Drp7DBNa7+XpgsyPA/62AQt5u1SuCZ0voHcL844EtxxN9ggA/LA2gF5xqjHLvl2rWnQWrhE5o0qtmspnN3u4T4BpTqCL7nQCn8IlX6MtN268VBtQstk/xDi5lE/n2fCVPy9KYJ28Q1RmnL3F1o82rg6PoYgJaG8DI/TTTtfWAFaUam3VSJKO0UVeTViIilVRkA2W4EsEdFGkyOGU7dxxPwKQRSOxURVf54xpfEthCDPXHzkXyoUzB2cOF0oS0k+uRqHoxuEKnx/QUvgYOY2lY4JDv369C97xBcdVH1fRPURhCklqaaH0C0l1Ocgut234iO2pbLPxpgB37VQ+2zIXNrH7YlYI+fA+nS61wR+/PLdlB9OTKQiXiNvQ4gMO0vCVZk9/hMHy5iIidID2ZNuN0YT3Q43csR8aGSGk511QV9YrGA0SvIVGb6jNxkhL9abRTZRMYOT0QC+l2p1fOt85xqZG7Tu4wFPt5EvJF1YyBjPyS3yAdCSKVBPIKhkbYpmod87ydtc8t6dC3rTHYSBDXg9Z+YJkdIBwQXt94aNApJxyiF6z8PM3VvALHwudJo8K6QFYtrD1JN/01jl84Np2vA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(136003)(346002)(39860400002)(230922051799003)(1800799009)(82310400011)(451199024)(186009)(64100799003)(40470700004)(46966006)(36840700001)(40480700001)(40460700003)(478600001)(7696005)(966005)(6666004)(36860700001)(82740400003)(86362001)(81166007)(356005)(2906002)(47076005)(83380400001)(26005)(16526019)(426003)(336012)(2616005)(1076003)(36756003)(70586007)(70206006)(8936002)(8676002)(5660300002)(316002)(110136005)(54906003)(44832011)(4326008)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 17:35:50.5338
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc0fe85a-3251-481d-00ea-08dbc5c9848f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4902
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove old address translation code and use the new AMD Address
Translation Library.

Use "imply" in Kconfig so that the "AMD_ATL" config option takes the
value of "EDAC_AMD64" as its default.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lore.kernel.org/r/20230802185504.606855-3-yazen.ghannam@amd.com

v1->v2:
* Drop the "config reachable" check.

 drivers/edac/Kconfig      |   1 +
 drivers/edac/amd64_edac.c | 278 +-------------------------------------
 2 files changed, 3 insertions(+), 276 deletions(-)

diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 110e99b86a66..87feeb24b3ff 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -78,6 +78,7 @@ config EDAC_GHES
 config EDAC_AMD64
 	tristate "AMD64 (Opteron, Athlon64)"
 	depends on AMD_NB && EDAC_DECODE_MCE
+	imply AMD_ATL
 	help
 	  Support for error detection and correction of DRAM ECC errors on
 	  the AMD64 families (>= K8) of memory controllers.
diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 9b6642d00871..623f84c53d2d 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include "amd64_edac.h"
 #include <asm/amd_nb.h>
+#include <linux/amd-atl.h>
 
 static struct edac_pci_ctl_info *pci_ctl;
 
@@ -1043,281 +1044,6 @@ static int fixup_node_id(int node_id, struct mce *m)
 	return nid - gpu_node_map.base_node_id + 1;
 }
 
-/* Protect the PCI config register pairs used for DF indirect access. */
-static DEFINE_MUTEX(df_indirect_mutex);
-
-/*
- * Data Fabric Indirect Access uses FICAA/FICAD.
- *
- * Fabric Indirect Configuration Access Address (FICAA): Constructed based
- * on the device's Instance Id and the PCI function and register offset of
- * the desired register.
- *
- * Fabric Indirect Configuration Access Data (FICAD): There are FICAD LO
- * and FICAD HI registers but so far we only need the LO register.
- *
- * Use Instance Id 0xFF to indicate a broadcast read.
- */
-#define DF_BROADCAST	0xFF
-static int __df_indirect_read(u16 node, u8 func, u16 reg, u8 instance_id, u32 *lo)
-{
-	struct pci_dev *F4;
-	u32 ficaa;
-	int err = -ENODEV;
-
-	if (node >= amd_nb_num())
-		goto out;
-
-	F4 = node_to_amd_nb(node)->link;
-	if (!F4)
-		goto out;
-
-	ficaa  = (instance_id == DF_BROADCAST) ? 0 : 1;
-	ficaa |= reg & 0x3FC;
-	ficaa |= (func & 0x7) << 11;
-	ficaa |= instance_id << 16;
-
-	mutex_lock(&df_indirect_mutex);
-
-	err = pci_write_config_dword(F4, 0x5C, ficaa);
-	if (err) {
-		pr_warn("Error writing DF Indirect FICAA, FICAA=0x%x\n", ficaa);
-		goto out_unlock;
-	}
-
-	err = pci_read_config_dword(F4, 0x98, lo);
-	if (err)
-		pr_warn("Error reading DF Indirect FICAD LO, FICAA=0x%x.\n", ficaa);
-
-out_unlock:
-	mutex_unlock(&df_indirect_mutex);
-
-out:
-	return err;
-}
-
-static int df_indirect_read_instance(u16 node, u8 func, u16 reg, u8 instance_id, u32 *lo)
-{
-	return __df_indirect_read(node, func, reg, instance_id, lo);
-}
-
-static int df_indirect_read_broadcast(u16 node, u8 func, u16 reg, u32 *lo)
-{
-	return __df_indirect_read(node, func, reg, DF_BROADCAST, lo);
-}
-
-struct addr_ctx {
-	u64 ret_addr;
-	u32 tmp;
-	u16 nid;
-	u8 inst_id;
-};
-
-static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
-{
-	u64 dram_base_addr, dram_limit_addr, dram_hole_base;
-
-	u8 die_id_shift, die_id_mask, socket_id_shift, socket_id_mask;
-	u8 intlv_num_dies, intlv_num_chan, intlv_num_sockets;
-	u8 intlv_addr_sel, intlv_addr_bit;
-	u8 num_intlv_bits, hashed_bit;
-	u8 lgcy_mmio_hole_en, base = 0;
-	u8 cs_mask, cs_id = 0;
-	bool hash_enabled = false;
-
-	struct addr_ctx ctx;
-
-	memset(&ctx, 0, sizeof(ctx));
-
-	/* Start from the normalized address */
-	ctx.ret_addr = norm_addr;
-
-	ctx.nid = nid;
-	ctx.inst_id = umc;
-
-	/* Read D18F0x1B4 (DramOffset), check if base 1 is used. */
-	if (df_indirect_read_instance(nid, 0, 0x1B4, umc, &ctx.tmp))
-		goto out_err;
-
-	/* Remove HiAddrOffset from normalized address, if enabled: */
-	if (ctx.tmp & BIT(0)) {
-		u64 hi_addr_offset = (ctx.tmp & GENMASK_ULL(31, 20)) << 8;
-
-		if (norm_addr >= hi_addr_offset) {
-			ctx.ret_addr -= hi_addr_offset;
-			base = 1;
-		}
-	}
-
-	/* Read D18F0x110 (DramBaseAddress). */
-	if (df_indirect_read_instance(nid, 0, 0x110 + (8 * base), umc, &ctx.tmp))
-		goto out_err;
-
-	/* Check if address range is valid. */
-	if (!(ctx.tmp & BIT(0))) {
-		pr_err("%s: Invalid DramBaseAddress range: 0x%x.\n",
-			__func__, ctx.tmp);
-		goto out_err;
-	}
-
-	lgcy_mmio_hole_en = ctx.tmp & BIT(1);
-	intlv_num_chan	  = (ctx.tmp >> 4) & 0xF;
-	intlv_addr_sel	  = (ctx.tmp >> 8) & 0x7;
-	dram_base_addr	  = (ctx.tmp & GENMASK_ULL(31, 12)) << 16;
-
-	/* {0, 1, 2, 3} map to address bits {8, 9, 10, 11} respectively */
-	if (intlv_addr_sel > 3) {
-		pr_err("%s: Invalid interleave address select %d.\n",
-			__func__, intlv_addr_sel);
-		goto out_err;
-	}
-
-	/* Read D18F0x114 (DramLimitAddress). */
-	if (df_indirect_read_instance(nid, 0, 0x114 + (8 * base), umc, &ctx.tmp))
-		goto out_err;
-
-	intlv_num_sockets = (ctx.tmp >> 8) & 0x1;
-	intlv_num_dies	  = (ctx.tmp >> 10) & 0x3;
-	dram_limit_addr	  = ((ctx.tmp & GENMASK_ULL(31, 12)) << 16) | GENMASK_ULL(27, 0);
-
-	intlv_addr_bit = intlv_addr_sel + 8;
-
-	/* Re-use intlv_num_chan by setting it equal to log2(#channels) */
-	switch (intlv_num_chan) {
-	case 0:	intlv_num_chan = 0; break;
-	case 1: intlv_num_chan = 1; break;
-	case 3: intlv_num_chan = 2; break;
-	case 5:	intlv_num_chan = 3; break;
-	case 7:	intlv_num_chan = 4; break;
-
-	case 8: intlv_num_chan = 1;
-		hash_enabled = true;
-		break;
-	default:
-		pr_err("%s: Invalid number of interleaved channels %d.\n",
-			__func__, intlv_num_chan);
-		goto out_err;
-	}
-
-	num_intlv_bits = intlv_num_chan;
-
-	if (intlv_num_dies > 2) {
-		pr_err("%s: Invalid number of interleaved nodes/dies %d.\n",
-			__func__, intlv_num_dies);
-		goto out_err;
-	}
-
-	num_intlv_bits += intlv_num_dies;
-
-	/* Add a bit if sockets are interleaved. */
-	num_intlv_bits += intlv_num_sockets;
-
-	/* Assert num_intlv_bits <= 4 */
-	if (num_intlv_bits > 4) {
-		pr_err("%s: Invalid interleave bits %d.\n",
-			__func__, num_intlv_bits);
-		goto out_err;
-	}
-
-	if (num_intlv_bits > 0) {
-		u64 temp_addr_x, temp_addr_i, temp_addr_y;
-		u8 die_id_bit, sock_id_bit, cs_fabric_id;
-
-		/*
-		 * Read FabricBlockInstanceInformation3_CS[BlockFabricID].
-		 * This is the fabric id for this coherent slave. Use
-		 * umc/channel# as instance id of the coherent slave
-		 * for FICAA.
-		 */
-		if (df_indirect_read_instance(nid, 0, 0x50, umc, &ctx.tmp))
-			goto out_err;
-
-		cs_fabric_id = (ctx.tmp >> 8) & 0xFF;
-		die_id_bit   = 0;
-
-		/* If interleaved over more than 1 channel: */
-		if (intlv_num_chan) {
-			die_id_bit = intlv_num_chan;
-			cs_mask	   = (1 << die_id_bit) - 1;
-			cs_id	   = cs_fabric_id & cs_mask;
-		}
-
-		sock_id_bit = die_id_bit;
-
-		/* Read D18F1x208 (SystemFabricIdMask). */
-		if (intlv_num_dies || intlv_num_sockets)
-			if (df_indirect_read_broadcast(nid, 1, 0x208, &ctx.tmp))
-				goto out_err;
-
-		/* If interleaved over more than 1 die. */
-		if (intlv_num_dies) {
-			sock_id_bit  = die_id_bit + intlv_num_dies;
-			die_id_shift = (ctx.tmp >> 24) & 0xF;
-			die_id_mask  = (ctx.tmp >> 8) & 0xFF;
-
-			cs_id |= ((cs_fabric_id & die_id_mask) >> die_id_shift) << die_id_bit;
-		}
-
-		/* If interleaved over more than 1 socket. */
-		if (intlv_num_sockets) {
-			socket_id_shift	= (ctx.tmp >> 28) & 0xF;
-			socket_id_mask	= (ctx.tmp >> 16) & 0xFF;
-
-			cs_id |= ((cs_fabric_id & socket_id_mask) >> socket_id_shift) << sock_id_bit;
-		}
-
-		/*
-		 * The pre-interleaved address consists of XXXXXXIIIYYYYY
-		 * where III is the ID for this CS, and XXXXXXYYYYY are the
-		 * address bits from the post-interleaved address.
-		 * "num_intlv_bits" has been calculated to tell us how many "I"
-		 * bits there are. "intlv_addr_bit" tells us how many "Y" bits
-		 * there are (where "I" starts).
-		 */
-		temp_addr_y = ctx.ret_addr & GENMASK_ULL(intlv_addr_bit - 1, 0);
-		temp_addr_i = (cs_id << intlv_addr_bit);
-		temp_addr_x = (ctx.ret_addr & GENMASK_ULL(63, intlv_addr_bit)) << num_intlv_bits;
-		ctx.ret_addr    = temp_addr_x | temp_addr_i | temp_addr_y;
-	}
-
-	/* Add dram base address */
-	ctx.ret_addr += dram_base_addr;
-
-	/* If legacy MMIO hole enabled */
-	if (lgcy_mmio_hole_en) {
-		if (df_indirect_read_broadcast(nid, 0, 0x104, &ctx.tmp))
-			goto out_err;
-
-		dram_hole_base = ctx.tmp & GENMASK(31, 24);
-		if (ctx.ret_addr >= dram_hole_base)
-			ctx.ret_addr += (BIT_ULL(32) - dram_hole_base);
-	}
-
-	if (hash_enabled) {
-		/* Save some parentheses and grab ls-bit at the end. */
-		hashed_bit =	(ctx.ret_addr >> 12) ^
-				(ctx.ret_addr >> 18) ^
-				(ctx.ret_addr >> 21) ^
-				(ctx.ret_addr >> 30) ^
-				cs_id;
-
-		hashed_bit &= BIT(0);
-
-		if (hashed_bit != ((ctx.ret_addr >> intlv_addr_bit) & BIT(0)))
-			ctx.ret_addr ^= BIT(intlv_addr_bit);
-	}
-
-	/* Is calculated system address is above DRAM limit address? */
-	if (ctx.ret_addr > dram_limit_addr)
-		goto out_err;
-
-	*sys_addr = ctx.ret_addr;
-	return 0;
-
-out_err:
-	return -EINVAL;
-}
-
 static int get_channel_from_ecc_syndrome(struct mem_ctl_info *, u16);
 
 /*
@@ -3098,7 +2824,7 @@ static void decode_umc_error(int node_id, struct mce *m)
 
 	pvt->ops->get_err_info(m, &err);
 
-	if (umc_normaddr_to_sysaddr(m->addr, pvt->mc_node_id, err.channel, &sys_addr)) {
+	if (amd_umc_mca_addr_to_sys_addr(m, &sys_addr)) {
 		err.err_code = ERR_NORM_ADDR;
 		goto log_error;
 	}
-- 
2.34.1


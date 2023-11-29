Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22E357FCFFA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 08:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjK2Hf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 02:35:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjK2Hft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 02:35:49 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA3D1735;
        Tue, 28 Nov 2023 23:35:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BTiq1sdXQFvaT1YToxRZFOjiPaknsqpQtuTM8a8sZPW+osvVYGg9nbVYFRXNb6V6HgwY7expKJoKjZK0wdqQmbSuAdC8O+nUsmFIxSxUYXlELbrh4G5zAJOmD9gbYG1wnVpuI5Bb1ZjMbO7WLI5mICUPlPi/KhNhGguJ0wjGi7IqKSNeJmVr54z5nyVxqtM/ZCFO/0lbJc/v4Lg5L0jUhA8J/7s9Hswu1Xdf6KbLrePdFPX7MKpLVECL1SUxRdbp7k+tFJ6vTjtu1mqpro9Zt/QqzPudbqoK57SaK3iiXsoyBUtQc8/YuRQkPWERSE8Bfd0LSGCueMtch1bjMdAfcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJmwj0m4m4m8VUWsar/ZTlXGPlPxYWU5vB7Xf9/94I4=;
 b=auudVwJDgi3eVa3vPHHVzpYnxsw6WA5wuzWmHf+doRKiPIyGOzxzgPGo2TDhU6Bc1VwL8zz5ycZgJxy8J4hlrCoyZlupCeXK3ol/iarKNikUJ6s8/mxbqg3SZoStheZZr9BAEffsrRvPNmcusy4CbfUKZ9zQGOWPWK90uvt7lTCdka59DoCj+dhB8SbAC2xsGpJTWo41BPLanHEJ/KqNNq1yLLfs3hTJBobzKfZwM/WhNFyjfiFxqJyyTrrJsfTCTBYHE932YX+qlEKt1OmwcLUCx5C0i6atKjYPVDCleg3vjJlTKza+pT2EbmiI3+EbL5saBd+BDhMhI9Cz7ZjIOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJmwj0m4m4m8VUWsar/ZTlXGPlPxYWU5vB7Xf9/94I4=;
 b=OA3b2PjGrpPRJp6615+a6eGFoEO6vVl+H2p5TQJ4zB08ZWNZazng4saJfJ+lXs9meHoDVkV2HlWDPtc7L0r/jUfGZivN65AB7ODhTn1LgR03HW5eZZuY1Yjcxna+ugbx132Gqo4CfgXg/dklUxxugCZ8Fjm7tfQR2zJ6l2HsK14=
Received: from SJ0PR03CA0276.namprd03.prod.outlook.com (2603:10b6:a03:39e::11)
 by CH3PR12MB9342.namprd12.prod.outlook.com (2603:10b6:610:1cb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Wed, 29 Nov
 2023 07:35:52 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:a03:39e:cafe::25) by SJ0PR03CA0276.outlook.office365.com
 (2603:10b6:a03:39e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27 via Frontend
 Transport; Wed, 29 Nov 2023 07:35:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Wed, 29 Nov 2023 07:35:51 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 29 Nov
 2023 01:35:48 -0600
From:   Muralidhara M K <muralimk@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, Muralidhara M K <muralidhara.mk@amd.com>
Subject: [PATCH v2 3/6] RAS: Add MCA Error address conversion for UMC
Date:   Wed, 29 Nov 2023 07:35:18 +0000
Message-ID: <20231129073521.2127403-4-muralimk@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231129073521.2127403-1-muralimk@amd.com>
References: <20231129073521.2127403-1-muralimk@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|CH3PR12MB9342:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b5a0a97-c822-46bf-b1d3-08dbf0add03d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fNhzHRcy7Kxg436B4I1floGlBD7mzOzHXr+HPFTIu0wH9YlexEYGh1gF6qrXnKOa6/SDibnR8t/GqRmpjW4NgrQh1nOJMYWl7y9M6KNjyBbwvGLjO+LsZZ2kVVU4hKJx+01GwUhp3yg7NBzxPoL4CSLKKXvuUwzY9HgLSIHahbl4G2Uw4Td1ISL/0pzQeSWC2T9+YanJhEqBxEkzR+81aveJ7+1cbkWGc/FfkSWy6ssszXPMKpIhHjxoGUx3ooMdu/BqAi3WWOdtPXB6rPQ3EI2yyuz6YezHjHxtM1yfAAixwM6WJ/XsDYqmKFFJRj8GayHsw0op0GYtQrF+uzEHY5ci17DHB1w1TwVUQxArUstY/O5iNOfTapWwBSdt+kvjNsDcm618LqMjMxts29wIzntLhkPg2OJDxNfGHSrimiUrjIXRBzTK2p1UMNSgECLxEgJFZSHyQ8lEQsDUx/4RLFvj9JFhbJT1/a+i0IC2WwKa0XIHFKa7aDLTlaPoeMcf/sIQQCztOig2mgGqoaUTEi7S7SoCVv2EhoNj5N9k9qOheKzz0rR9xOIVaAbDCstz9ZpYSg7La52k9AMJ+xBwn9xQBcIa5GpJAuDNluaN3BBGKdEdGt/6IeRZJe8GIsXju7lV9giV56PcjhTD5/yhxarQvT3rtZJKZcd52wC7s1M/F774SJsdEDdI4Dk9Oh1wOVClFYBQ73XHlxEn9ENaPRVYHuLeymlqSiQpxr1j6vLMtdn2oszUV1Mq90dHSMY/3HufbAeDpXWkORUhZCQsVg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(346002)(396003)(136003)(230922051799003)(1800799012)(82310400011)(451199024)(64100799003)(186009)(46966006)(40470700004)(36840700001)(41300700001)(36756003)(1076003)(81166007)(47076005)(356005)(83380400001)(5660300002)(336012)(82740400003)(426003)(2906002)(16526019)(26005)(40480700001)(2616005)(36860700001)(7696005)(6666004)(8676002)(4326008)(8936002)(40460700003)(478600001)(316002)(70206006)(70586007)(54906003)(6916009)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 07:35:51.5363
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b5a0a97-c822-46bf-b1d3-08dbf0add03d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9342
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Muralidhara M K <muralidhara.mk@amd.com>

On AMD systems with HBM3 memory, The reported MCA address is
DRAM address which needs to be converted to normalized address
before the data fabric address translation.

MI300A models have on-chip HBM3 memory capable of On-Die ECC support.
On-Die ECC error address to MCA is a encoded address reported with
a DRAM address (PC/SID/Bank/ROW/COL) instead of normalized address
unlike MI200s UMC ECC, as the implementation difference between
HBM3 On-Die ECC and HBM2 host ECC.
Because On-Die ECC address reporting is done in the back-end of UMC
and it no longer has normalized address at that point.
So software needs to convert the reported MCA Error Address back to
normalized address.

Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
---
Changes:
v1 -> v2 : None

 drivers/ras/amd/atl/umc.c | 145 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 145 insertions(+)

diff --git a/drivers/ras/amd/atl/umc.c b/drivers/ras/amd/atl/umc.c
index f334be0dc034..94eb2c5eae3b 100644
--- a/drivers/ras/amd/atl/umc.c
+++ b/drivers/ras/amd/atl/umc.c
@@ -12,6 +12,147 @@
 
 #include "internal.h"
 
+static bool internal_bit_wise_xor(u32 inp)
+{
+	bool tmp = 0;
+	int i;
+
+	for (i = 0; i < 32; i++)
+		tmp = tmp ^ ((inp >> i) & 0x1);
+
+	return tmp;
+}
+
+/*
+ * Mapping of MCA decoded error address bit location to
+ * normalized address on MI300A systems.
+ */
+static const u8 umc_mca2na_mapping[] = {
+	0,  5,  6,  8,  9,  14, 12, 13,
+	10, 11, 15, 16, 17, 18, 19, 20,
+	21, 22, 23, 24, 25, 26, 27, 28,
+	7,  29, 30,
+};
+
+/* AddrHashBank and AddrHashPC/PC2 umc register bit fields */
+static struct {
+	u32 xor_enable	:1;
+	u32 col_xor	:13;
+	u32 row_xor	:18;
+} addr_hash_pc, addr_hash_bank[4];
+
+static struct {
+	u32 bank_xor	:6;
+} addr_hash_pc2;
+
+#define COLUMN_LOCATION		GENMASK(5, 1)
+#define ROW_LOCATION		GENMASK(23, 10)
+/*
+ * The location of bank, column and row are fixed.
+ * location of column bit must be NA[5].
+ * Row bits are always placed in a contiguous stretch of NA above the
+ * column and bank bits.
+ * Bits below the row bits can be either column or bank in any order,
+ * with the exception that NA[5] must be a column bit.
+ * Stack ID(SID) bits are placed in the MSB position of the NA.
+ */
+static int umc_ondie_addr_to_normaddr(u64 mca_addr, u16 nid)
+{
+	u32 bank[4], bank_hash[4], pc_hash;
+	u32 col, row, rawbank = 0, pc;
+	int i, temp = 0, err;
+	u64 mca2na;
+
+	/* Default umc base address on MI300A systems */
+	u32 gpu_umc_base = 0x90000;
+
+	/*
+	 * Error address logged on MI300A systems is ondie MCA address
+	 * in the format MCA_Addr[27:0] =
+	 *	{SID[1:0],PC[0],row[14:0],bank[3:0],col[4:0],1'b0}
+	 * The bit locations are calculated as per umc_mca2na_mapping[]
+	 * to find normalized address.
+	 * Refer F19 M90h BKDG Section 20.3.1.3 for clarifications
+	 *
+	 * XORs need to be applied based on the hash settings below.
+	 */
+
+	/* Calculate column and row */
+	col = FIELD_GET(COLUMN_LOCATION, mca_addr);
+	row = FIELD_GET(ROW_LOCATION, mca_addr);
+
+	/* Apply hashing on below banks for bank calculation */
+	for (i = 0; i < 4; i++)
+		bank_hash[i] = (mca_addr >> (6 + i)) & 0x1;
+
+	/* bank hash algorithm */
+	for (i = 0; i < 4; i++) {
+		/* Read AMD PPR UMC::AddrHashBank register */
+		err = amd_smn_read(nid, gpu_umc_base + 0xC8 + (i * 4), &temp);
+		if (err)
+			return err;
+
+		addr_hash_bank[i].xor_enable = temp & 1;
+		addr_hash_bank[i].col_xor = FIELD_GET(GENMASK(13, 1), temp);
+		addr_hash_bank[i].row_xor = FIELD_GET(GENMASK(31, 14), temp);
+		/* bank hash selection */
+		bank[i] = bank_hash[i] ^ (addr_hash_bank[i].xor_enable &
+			  (internal_bit_wise_xor(col & addr_hash_bank[i].col_xor) ^
+			  internal_bit_wise_xor(row & addr_hash_bank[i].row_xor)));
+	}
+
+	/* To apply hash on pc bit */
+	pc_hash = (mca_addr >> 25) & 0x1;
+
+	/* Read AMD PPR UMC::CH::AddrHashPC register */
+	err = amd_smn_read(nid, gpu_umc_base + 0xE0, &temp);
+	if (err)
+		return err;
+
+	addr_hash_pc.xor_enable = temp & 1;
+	addr_hash_pc.col_xor = FIELD_GET(GENMASK(13, 1), temp);
+	addr_hash_pc.row_xor = FIELD_GET(GENMASK(31, 14), temp);
+
+	/* Read AMD PPR UMC::CH::AddrHashPC2 register*/
+	err = amd_smn_read(nid, gpu_umc_base + 0xE4, &temp);
+	if (err)
+		return err;
+
+	addr_hash_pc2.bank_xor = FIELD_GET(GENMASK(5, 0), temp);
+
+	/* Calculate bank value from bank[0..3], bank[4] and bank[5] */
+	for (i = 0; i < 4; i++)
+		rawbank |= (bank[i] & 1) << i;
+
+	rawbank |= (mca_addr >> 22) & 0x30;
+
+	/* pseudochannel(pc) hash selection */
+	pc = pc_hash ^ (addr_hash_pc.xor_enable &
+		(internal_bit_wise_xor(col & addr_hash_pc.col_xor) ^
+		internal_bit_wise_xor(row & addr_hash_pc.row_xor) ^
+		internal_bit_wise_xor(rawbank & addr_hash_pc2.bank_xor)));
+
+	/* Mask b'25(pc_bit) and b'[9:6](bank) */
+	mca_addr &= ~0x20003c0ULL;
+
+	for (i = 0; i < 4; i++)
+		mca_addr |= (bank[i] << (6 + i));
+
+	 mca_addr |= (pc << 25);
+
+	/* NA[4..0] is fixed */
+	mca2na = 0x0;
+	/* convert mca error address to normalized address */
+	for (i = 1; i < ARRAY_SIZE(umc_mca2na_mapping); i++)
+		mca2na |= ((mca_addr >> i) & 0x1) << umc_mca2na_mapping[i];
+
+	mca_addr = mca2na;
+	pr_debug("Error Addr 0x%016llx\n", mca_addr);
+	pr_debug("Error hit on Bank %d Row %d Column %d\n", rawbank, row, col);
+
+	return mca_addr;
+}
+
 static u8 get_socket_id(struct mce *m)
 {
 	return m->socketid;
@@ -36,6 +177,10 @@ static u8 get_die_id(struct mce *m)
 
 static u64 get_norm_addr(struct mce *m)
 {
+	/* MI300: DRAM->Normalized translation */
+	if (df_cfg.rev == DF4p5 && df_cfg.flags.heterogeneous)
+		return umc_ondie_addr_to_normaddr(m->addr, get_socket_id(m));
+
 	return m->addr;
 }
 
-- 
2.25.1


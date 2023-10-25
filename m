Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D987D6388
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 09:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234255AbjJYHh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 03:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232865AbjJYHh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 03:37:27 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C153A9B;
        Wed, 25 Oct 2023 00:35:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RhdF/bJ5/tS2Bxk8WbBsind90rSGp9j/C8pDbXPfx1triwVBjNjXIEbSL8BSCNbUw0NMc+2w8vKFDMN7FXJO0qES4i97eSBuh80E8AAVKoky+jnNm3sJYcWEA8MqasHKS+algxCDgZDxNAHAV53odR3fwpk4JGB5wGmBGx4o0B9Fk/7/4j1mdad6KMbOp8wiVmXnkXit6htyQv0LgbACus/pOvNXNLwtHAh4fiDTK+92uo+wy3euO4JWH5NiX79zJRdhQaecCGLnMcA2Yct2MwFjYRZqj8Wk/1orNe5d4Mzlk6RTG0o6oOASMFiTGvnOulaHNXoOfXlcfHXoys4J/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YenW6jD8DwHsKBLoZ7mUSWL1oZeP5QZt1EbgNOwjlcU=;
 b=kyf60T8VGXFhaQHwZFx97F67vDEj9tezJk7QnYa599DC2648oBvmcmIu4IevvltZaABQQnpDSw9ONLDCjxWSgGvIROisYqTwFHz9mKjTbyMtUjqiRXkkiAOQuNFO1BBqM8HXrfV12xG/d3lxWCJ/dojLrylT0OlJwJmzl2lHkSRxGA+lIEDlPLusDN0pAWjkevqmCw0mV1qjn2kYD8Yv5x2CfTuRxAqhTO000z9FGVfV+mxdexOzr1j3mkZmW/DljBCAEWF1/gVdV1XyKXH8Y7Jy7GTq9vHG5RUCwuGC8a0R8ED1o2g7J5wHmvXc6B+DnX9lKUdkIFxGQFzSzdR7/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YenW6jD8DwHsKBLoZ7mUSWL1oZeP5QZt1EbgNOwjlcU=;
 b=yQ0AXTA2vPy6LFUUMeTi/4463Nde8IKDNGFpHvWWxdPNLyAlYTfclNWe9hCr0tl4boo4W3QXsKdYJueMbTVfZATuOGeBd4zM5GU4uGkOwJ9aXlAlYmMZxLXZf1TYe57SnvrLAxNJ7PXnDfSo6eklnnCSNZfJ/iI3egvLIA++hOk=
Received: from BYAPR21CA0023.namprd21.prod.outlook.com (2603:10b6:a03:114::33)
 by CH0PR12MB5236.namprd12.prod.outlook.com (2603:10b6:610:d3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 07:35:19 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:a03:114:cafe::8c) by BYAPR21CA0023.outlook.office365.com
 (2603:10b6:a03:114::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.14 via Frontend
 Transport; Wed, 25 Oct 2023 07:35:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Wed, 25 Oct 2023 07:35:18 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 25 Oct
 2023 02:35:15 -0500
From:   Muralidhara M K <muralimk@amd.com>
To:     <linux-edac@vger.kernel.org>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, Muralidhara M K <muralidhara.mk@amd.com>
Subject: [PATCH 3/7] RAS: Add MCA Error address conversion for UMC
Date:   Wed, 25 Oct 2023 07:33:35 +0000
Message-ID: <20231025073339.630093-4-muralimk@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231025073339.630093-1-muralimk@amd.com>
References: <20231025073339.630093-1-muralimk@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|CH0PR12MB5236:EE_
X-MS-Office365-Filtering-Correlation-Id: 7074fb77-3bf6-46e6-5b7c-08dbd52cf035
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: trspEdtej7BlUAzO0hT4NfNHMyHdHjBbADCByvh30ijtnBVABVqFot/vFigdA4paO5p4v+Bw1oI+eiyx98Fc/nGgbDyjELRwr6E+DWLRenPyQKr1RnFM8yI2FdnI4PofNlKkyEkC55ExSp8C0F783PXtGvQYLUwaOY3f6fg3nBIKe/G6HN5CadPxEqxvtcrhzYJZK/BOZFdLfB+qRYQGtNQ0tbj5vuFkvRL+8IH+lwJUTBGCXhZ74cqLGduLyOfqerewIrs+ri/qFuZn1pVocATE1ZufSjOrke/AWU3lccjZ4fEZxfphq0tcqAA4u5xH1DSmdIHVQeIYPKeON9egStGSHaePeqIiOfJab+IiJ+ZyzVUYl7i8wkzZDhdjFl/U0Mkr0WuVHXF7xRGSPQYf/jFqru0A7TSgOCKpfXDsT5bZnSiodYxWdqK5lDn7M78+BxE9f4AjE9infchTGai16ThlsYPwUSspJwZ2vIw1ysrnu1s6U/kEcUguRynX+dgSR8a5PgAOMr4MLout5cmZzWIgq6uXU8mDRFIwIgoUwAcFZPMeVDVHdfKlKB0Y1yEZScWD7pjllvQJ+dSPWeCelS+5q6NJftNipRF4yXLVv1SBN9NZLi7yYTGXPUFSzV89M3vmz+edN9r3UWGLPhyF/xZEgWtcB9v5BDn3P+/RLJahpYX2ffx4N1RDzamnBHMinyUB/6zId4JfWlHHFRoGYEO4oEf4gFOZ+fA3juXokM662+CQryKytDJC6mzY9y9Ep02CIav+eblyP2jdNKcYog==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(346002)(136003)(376002)(230922051799003)(186009)(1800799009)(451199024)(82310400011)(64100799003)(46966006)(36840700001)(40470700004)(36860700001)(2906002)(41300700001)(82740400003)(81166007)(54906003)(6666004)(316002)(7696005)(16526019)(478600001)(70206006)(70586007)(2616005)(1076003)(110136005)(426003)(336012)(40480700001)(47076005)(966005)(83380400001)(40460700003)(36756003)(5660300002)(356005)(4326008)(8676002)(8936002)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 07:35:18.6956
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7074fb77-3bf6-46e6-5b7c-08dbd52cf035
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5236
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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
Link: https://lore.kernel.org/linux-edac/20230720125425.3735538-1-muralimk@amd.com/T/#m225efdf5812820efd084158bd8cdf40cad1a5af6

 drivers/ras/amd/atl/umc.c | 145 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 145 insertions(+)

diff --git a/drivers/ras/amd/atl/umc.c b/drivers/ras/amd/atl/umc.c
index f334be0dc034..fa8c3072a54f 100644
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
+	pr_info("Error Addr: 0x%016llx\n", mca_addr);
+	pr_info("Error hit on: Bank %d Row %d Column %d\n", rawbank, row, col);
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


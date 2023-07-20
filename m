Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34C2B75AEDC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 14:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjGTMzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 08:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbjGTMz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 08:55:27 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8DE26B2;
        Thu, 20 Jul 2023 05:55:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oR6ADlBSzHaiFZuMT8iCWBSDC+ooccLocm4PjbZvrNlNVeT5HQXrf6w0CeXODhWaqxa2tD9YjRvY4DWXwMJSsiTdmXq+MsJOPY4Y6gXmor85OWCLufASzzxPxYwPDedSfOGCwnssirIHzI3rY0tlblbWsbAna/ULLEkl5W4n8GPD31J1/gEhAWfeDlBJQQSojTyGLGAj09bqqCw9lJNAvcEchIkqYfRmIvM0P5YYpUZHOBDi686FudD5LOiN1l0OEdQCON7JBDz9K6VI4MLyO5c3fFue9xiA+Bs2+cqWIS6AqDPxbRoqcuO73R09CQZSdwJVkis5KRKoaGkd2c7qNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gpF5CU3R3oxAqvV9qnvtGlkZ4ET7rpxtO10T0fLl03s=;
 b=luqUZfZMX10eNfIQaUCG6t9Re3RmEaDd5D/D4r7BlsOOR/vMOkqEORg4Sivd2x80xc9/OWYsRrwvJkVUd2d/1w5/8SXRnniaGJKuv1Fij29IjY520gSebZVjCVMzwAsyYQhN57Ch8jSxqEN+uOxyUfUK+jOpN/VKTlBeTdGuyZvxaaMpff/D/napn+fM3ge+t15Eq6fJKCm0MTGZbMYOgVtPmC9MBOjQDvxItS1a27EwOG+p0r6L1I229F9LZELk0Q8dNezTIMgQrcAtZJhwVSQoU/Ri0Sm//OH4I520Bnhlqk18wWuFzgiDJzBkhEcD8KjPmWT6JagKMaYnyl3zJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gpF5CU3R3oxAqvV9qnvtGlkZ4ET7rpxtO10T0fLl03s=;
 b=3uYMQg107kt6AaK8hw/E328E3DwqyH+oRJh0dmYlKSY/wNStnl3wvdFF5Lm4gpEDvX6MG8iRgENdFa/lIlS7A+NGAOKLj7ePzwLEtX/jrwrUfgnSO/bkFzxpWHAIEEuuI9rz01K9+gDtoy3CgQ4xhe8/sw3QuKLkUSqlWaX2OXo=
Received: from BN0PR03CA0035.namprd03.prod.outlook.com (2603:10b6:408:e7::10)
 by DM4PR12MB6399.namprd12.prod.outlook.com (2603:10b6:8:b7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Thu, 20 Jul
 2023 12:55:03 +0000
Received: from BN8NAM11FT105.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e7:cafe::84) by BN0PR03CA0035.outlook.office365.com
 (2603:10b6:408:e7::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28 via Frontend
 Transport; Thu, 20 Jul 2023 12:55:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT105.mail.protection.outlook.com (10.13.176.183) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6609.28 via Frontend Transport; Thu, 20 Jul 2023 12:55:03 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 20 Jul
 2023 07:55:00 -0500
From:   Muralidhara M K <muralimk@amd.com>
To:     <linux-edac@vger.kernel.org>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <mingo@redhat.com>,
        <mchehab@kernel.org>, <nchatrad@amd.com>, <yazen.ghannam@amd.com>,
        Muralidhara M K <muralidhara.mk@amd.com>
Subject: [PATCH 7/7] EDAC/amd64: Add Error address conversion for UMC
Date:   Thu, 20 Jul 2023 12:54:25 +0000
Message-ID: <20230720125425.3735538-8-muralimk@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230720125425.3735538-1-muralimk@amd.com>
References: <20230720125425.3735538-1-muralimk@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT105:EE_|DM4PR12MB6399:EE_
X-MS-Office365-Filtering-Correlation-Id: c0489295-1caf-4fb3-f7ab-08db892088ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DLsAR0bx0SiXg7wyOlZqqsbdn9aqetXOS78T4pnvPtm8BGgxA7vPoyr+3eOfWtnqX/qQezF9igQ7W1IEwX0F/3E16O513EoDGZ59TBeH7oO36lyHHWdxYt7lVERyAopPIiIrYrUjsOqUS+DQYDy37LTAkEe07hDP6+3n0HDyYnmtaKh/WH9B0ljBwooLzMEEpQykHAzDXGYAm1uhsUmtFTghEjHF/Iq7HryHqTa9cRnBAMm2iZaywYZAp3ALknczy2RZsAdqvLDHnn+I4qDN+3rP4Md55yXyy+oErxJLbdwNWoZEHqIZKpfNF6BwFikXHFP/Utf2y7WYYuNDnDxxpnuNnI8fk68gTOpfoe477D2HyN8vSakD3NNgbS0J1IjEWKlBt8ehSZyP3G+H+ioYFG6CX5z8tAJhLCNJ7V3oh8R6bP1F/UWdE4vvZw1VS28L9iAAlr4hTuXv6wr9+26VEAzfIwPyNSSD3MHLqNEpcLuCLSKtdi3DHTVCO9Ps5UwfxBxp8XOklUO9B9SGCIzWeaLcohuAl5cTYijE1YmypH+UVA31YJEmuUGh1QguU2n/MdPtpdsKvJnlDzVIbFWq1p7u3QeNM7cQCMH1/+yp4IxnAPtptd/Ro5gajjBNrS8ai0xBjCAQK4mi/0uZUt5QUhz4Tppo206JeiHTwlwMwvE8re2xfktzmbiGuR83GnMW1L+KW6A89LcyUKdYH817ZW6YVaMNV26o3fz/WCWK7XvszXmiJ8HgIpTXOF2rp+HGRZMjcxQajwP9qBOy86IEcg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(136003)(82310400008)(451199021)(40470700004)(46966006)(36840700001)(40480700001)(41300700001)(5660300002)(8676002)(8936002)(4326008)(40460700003)(110136005)(70206006)(54906003)(70586007)(316002)(82740400003)(356005)(81166007)(2906002)(6666004)(2616005)(36756003)(426003)(7696005)(1076003)(26005)(186003)(16526019)(336012)(47076005)(36860700001)(478600001)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 12:55:03.1909
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0489295-1caf-4fb3-f7ab-08db892088ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT105.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6399
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

Reported MCA address is DRAM address which needs to be converted
to normalized address before Data fabric address translation.

Some AMD systems have on-chip memory capable of OnDie ECC support.
OnDie-ECC error address to MCA is a DRAM decoded address reported with
a DRAM address (PC/SID/Bank/ROW/COL) instead of normalized address
unlike MI200’s UMC ECC, as the implementation difference between
HBM3 ODECC and HBM2 host ECC.
Because OnDie-ECC address reporting is done in the back-end of UMC and
it no longer has normalized address at that point.
So software needs to convert the reported MCA Error Address back to
normalized address.

Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
---
 drivers/edac/amd64_edac.c | 160 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 160 insertions(+)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 74b2b47cc22a..304d104c25d8 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -3076,6 +3076,159 @@ static void umc_get_err_info(struct mce *m, struct err_info *err)
 	err->csrow = m->synd & 0x7;
 }
 
+static bool internal_bit_wise_xor(u32 inp)
+{
+	bool tmp = 0;
+
+	for (int i = 0; i < 32; i++)
+		tmp = tmp ^ ((inp >> i) & 0x1);
+
+	return tmp;
+}
+
+/* mapping of MCA error address to normalized address */
+static const u8 umc_mca2na_mapping[] = {
+	0,  5,  6,  8,  9,  14, 12, 13,
+	10, 11, 15, 16, 17, 18, 19, 20,
+	21, 22, 23, 24, 25, 26, 27, 28,
+	7,  29, 30,
+};
+
+/*
+ * Read AMD PPR UMC::AddrHashBank and
+ * UMC::CH::AddrHashPC/PC2 register fields
+ */
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
+	int i, temp = 0;
+	u64 mca2na;
+
+	u32 gpu_umc_base = 0x90000;
+
+	/*
+	 * the below calculation, trying to maps ondie error address
+	 * to normalized address. logged ondie MCA address format is
+	 * BEQ_MCA_RdDatAddr[27:0] =
+	 *	{SID[1:0],PC[0],row[14:0],bank[3:0],col[4:0],1'b0}
+	 * The conversion mappings are:
+	 *
+	 * Normalized location	  ondie MCA error Address
+	 * ===================	  ======================
+	 * NA[4]		  = 1'b0
+	 * NA[5]	= col[0]  = BEQ_MCA_RdDatAddr[1]
+	 * NA[6]	= col[1]  = BEQ_MCA_RdDatAddr[2]
+	 * NA[8]	= col[2]  = BEQ_MCA_RdDatAddr[3]
+	 * NA[9]	= col[3]  = BEQ_MCA_RdDatAddr[4]
+	 * NA[14]	= col[4]  = BEQ_MCA_RdDatAddr[5]
+	 * NA[12]	= bank[0] = BEQ_MCA_RdDatAddr[5]
+	 * NA[13]	= bank[1] = BEQ_MCA_RdDatAddr[6]
+	 * NA[10]	= bank[2] = BEQ_MCA_RdDatAddr[7]
+	 * NA[11]	= bank[3] = BEQ_MCA_RdDatAddr[8]
+	 *
+	 * row low is 12 bit locations, low lsb bit starts from 10
+	 * NA[15..26] = row[0..11]  = BEQ_MCA_RdDatAddr[10..21]
+	 *
+	 * row high is 2 bit locations, high lsb bit starts from 22
+	 * NA[27..28] = row[12..13] = BEQ_MCA_RdDatAddr[22..23]
+	 *
+	 * NA[7]	= PC[0]   = BEQ_MCA_RdDatAddr[25]
+	 * NA[29]	= sid[0]  = bank[4] = BEQ_MCA_RdDatAddr[26]
+	 * NA[30]	= sid[1]  = bank[5] = BEQ_MCA_RdDatAddr[27]
+	 * Basically, it calculates a locations to fit as shown in
+	 * table umc_mca2na_mapping[].
+	 *
+	 * XORs need to be applied based on the hash settings below.
+	 */
+
+	/* Calculate column and row */
+	col = FIELD_GET(GENMASK(5, 1), mca_addr);
+	row = FIELD_GET(GENMASK(23, 10), mca_addr);
+
+	/* Apply hashing on below banks for bank calculation */
+	for (i = 0; i < 4; i++)
+		bank_hash[i] = (mca_addr >> (6 + i)) & 0x1;
+
+	/* bank hash algorithm */
+	for (i = 0; i < 4; i++) {
+		/* Read AMD PPR UMC::AddrHashBank register*/
+		if (!amd_smn_read(nid, gpu_umc_base + 0xC8 + (i * 4), &temp)) {
+			addr_hash_bank[i].xor_enable = temp & 1;
+			addr_hash_bank[i].col_xor = FIELD_GET(GENMASK(13, 1), temp);
+			addr_hash_bank[i].row_xor = FIELD_GET(GENMASK(31, 14), temp);
+			/* bank hash selection */
+			bank[i] = bank_hash[i] ^ (addr_hash_bank[i].xor_enable &
+				  (internal_bit_wise_xor(col & addr_hash_bank[i].col_xor) ^
+				  internal_bit_wise_xor(row & addr_hash_bank[i].row_xor)));
+		}
+	}
+
+	/* To apply hash on pc bit */
+	pc_hash = (mca_addr >> 25) & 0x1;
+
+	/* Read AMD PPR UMC::CH::AddrHashPC register */
+	if (!amd_smn_read(nid, gpu_umc_base + 0xE0, &temp)) {
+		addr_hash_pc.xor_enable = temp & 1;
+		addr_hash_pc.col_xor = FIELD_GET(GENMASK(13, 1), temp);
+		addr_hash_pc.row_xor = FIELD_GET(GENMASK(31, 14), temp);
+	}
+	/* Read AMD PPR UMC::CH::AddrHashPC2 register*/
+	if (!amd_smn_read(nid, gpu_umc_base + 0xE4, &temp))
+		addr_hash_pc2.bank_xor = FIELD_GET(GENMASK(5, 0), temp);
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
+	pr_emerg(HW_ERR "Error Addr: 0x%016llx\n", mca_addr);
+	pr_emerg(HW_ERR "Error hit on Bank: %d Row: %d Column: %d\n", rawbank, row, col);
+
+	return mca_addr;
+}
+
 static void decode_umc_error(int node_id, struct mce *m)
 {
 	u8 ecc_type = (m->status >> 45) & 0x3;
@@ -3115,6 +3268,13 @@ static void decode_umc_error(int node_id, struct mce *m)
 	pvt->ops->get_err_info(m, &err);
 	df_inst_id = pvt->ops->get_inst_id(mci, pvt, &err);
 
+	/*
+	 * The reported MCA address(Error Addr) is DRAM decoded address which needs to be
+	 * converted to normalized address before DF address translation.
+	 */
+	if (pvt->fam == 0x19 && (pvt->model >= 0x90 && pvt->model <= 0x9f))
+		m->addr = umc_ondie_addr_to_normaddr(m->addr, pvt->mc_node_id);
+
 	if (umc_normaddr_to_sysaddr(m->addr, pvt->mc_node_id, df_inst_id, &sys_addr)) {
 		err.err_code = ERR_NORM_ADDR;
 		goto log_error;
-- 
2.25.1


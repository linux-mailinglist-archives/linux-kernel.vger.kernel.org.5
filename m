Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F287077B0EF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 07:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233424AbjHNFyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 01:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233456AbjHNFyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 01:54:19 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDAE610D7
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 22:54:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nOM7/s5nSAGgNpzogs0f2NX7JmTpw3AiVhXAGgVYm+uXTdxHSausiiIRlDERDRdZD72QpxDUE2XonmYsLeGLdciTqbGgmRzJu0ZyG+MxeIssYBoiOJUAWYbrh0GgdPaKsglW3MJ9p8LqgXmSyy5EWHMm3GEFu/k2XojguRRqwgOynryxLVASM7K5BdxS5UkYAb1tDmu709BA1Fbr4KcRCct5L1a5Y4a3grBfcGxWnwo4atRg5AKnFKO7ubHxEuWZCf0QAEKxhuo3ovAc/+pMdmVZMMT3iibmagJ2SofU5J/vko6j47obzCi4Vm/REHfRoGN7AMbEzO1K4WMttrDP8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g8rFfVrUTFoITwQVDTO6F5FOD7whF12hpJmq/8o8lVc=;
 b=Dwu/cyZKllMtfFVbw1cLtauQ7QcI0D1ZN+r/DWg7Tj76kwqQS160UX9Xd1XFV4jYA4+MiyH8rUeywIZ0m1Kg3W1B3kNxDxcD/F+142QgZtH8DRFzQCiM8sdFpW0vE7VFoBlu4KvceGR4ZD6Gl9qa8I4aP8qJRvntAciyv1jqLAq1N2c6ZPL6zPYd5b3cQ8kqgDdRVGyBLY4ujMHUfIUjo/wId24euvPAq779asJcojO8dYJfxcDmLx8yiI7cf89GVy6j2LI3aI7c+IdCbWNi1Z3ZqAKS0kbjdihqQCPm6XmbBcP8Ckt/zg9o0RKh/Qv15VyAhDVNy0QMkmR9RrERlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8rFfVrUTFoITwQVDTO6F5FOD7whF12hpJmq/8o8lVc=;
 b=OT2JgvSOUCe5yWsFpnZEp6bws5+wsP1qXBxONfX0Rcx8yE+dYJbFFNoc0JtGdbEc1P85Bv9HFn+Ptwh13HWzkUIcFj3UkGOhJnONA2Yho0vgDZ3w02P2oLcU3KOue44xOXS5ybD2Psur2VT2fr2ujDRhqw0yhHttJvk02F7olaM=
Received: from MW4PR03CA0126.namprd03.prod.outlook.com (2603:10b6:303:8c::11)
 by MW3PR12MB4362.namprd12.prod.outlook.com (2603:10b6:303:5d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 05:54:05 +0000
Received: from CO1NAM11FT074.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::a4) by MW4PR03CA0126.outlook.office365.com
 (2603:10b6:303:8c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Mon, 14 Aug 2023 05:54:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT074.mail.protection.outlook.com (10.13.174.254) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.13 via Frontend Transport; Mon, 14 Aug 2023 05:54:05 +0000
Received: from gomati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 14 Aug
 2023 00:53:58 -0500
From:   Nikunj A Dadhania <nikunj@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC:     <bp@alien8.de>, <thomas.lendacky@amd.com>,
        <dionnaglaze@google.com>, <pgonda@google.com>, <seanjc@google.com>,
        <pbonzini@redhat.com>, <nikunj@amd.com>
Subject: [PATCH v4 09/14] x86/sev: Add Secure TSC support for SNP guests
Date:   Mon, 14 Aug 2023 11:22:17 +0530
Message-ID: <20230814055222.1056404-10-nikunj@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230814055222.1056404-1-nikunj@amd.com>
References: <20230814055222.1056404-1-nikunj@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT074:EE_|MW3PR12MB4362:EE_
X-MS-Office365-Filtering-Correlation-Id: cf4fae2e-b700-4e9a-cd2f-08db9c8ade70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wd1tnaQDrXNn5EO7a6nKCr/rVrvNPQMxntrHDVPHzUqfQFhwbJCpNxsmhqevDDKAsmOzfyYXp29Qq0klbIXKA98m++tY18hImPFY3gqiCFYQHu92Roe3le/uSRekh3ETk1hHNla0eDX8GOzyCiYX+AUsmBMYzFNzWVoypVup/1+HUBQT/6vkdZLJHlqiE6JzTfRFj8RYoAdkizbdc+e01S6GPmKSgcQvIW2I0Cm7yumgXgVqLMhliPhu1VpVpH04HRQZml86a7nBWsPT6V58gQOIBYDGMiPaYb6qaKAdIJOsP90KBid8HOxHkx8JkXE809px8m4M7UJBo7oUGfPlTfymZ6WO8q47jivHEj/3tyFVJzbLnySjD6gVu2x+cdCoPyEtqX+SrkE0aADY4f3dvfzD0ho+fLz04zaLfk5Zew27y4jPe/U7vVOGERajDrvrOsw0a/xkVHNRzasfnsdMshSuO7MPULIgXyocd7rnl3p5IuPH2zPVQ3MZ3nPa2oASFZWM7W7km7eiYmzEfvD382kcXmhrgw474nbkIuz/NLTDuZ+C84kaJOV8VJm14rUzhxSo4Z/Iw+V398LG/AR3s7wWwNP9jLrBRqdhbTtl2UsndsPL+eHbo14odSwBu6Nhaz+w6xWT73GoFeWG35CMKkdXklxQgCnoxPFVi3QoSCVPM2hudKhLwr/xCKGBEpCv1z0T4nCrrPuIawEB1ULJRSfch9yxKHdD1VOlfGnBuNXXRDmV7fxVlFifby3nh6Ppv/JykyhYlpAv0UgIESDRyA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(396003)(39860400002)(186006)(1800799006)(82310400008)(451199021)(40470700004)(46966006)(36840700001)(7696005)(6666004)(36756003)(81166007)(356005)(82740400003)(83380400001)(47076005)(36860700001)(26005)(1076003)(2906002)(336012)(110136005)(54906003)(478600001)(40480700001)(426003)(2616005)(16526019)(8676002)(8936002)(70586007)(5660300002)(40460700003)(41300700001)(316002)(4326008)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 05:54:05.2849
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf4fae2e-b700-4e9a-cd2f-08db9c8ade70
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT074.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4362
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Secure TSC in SNP enabled guests. Secure TSC allows
guest to securely use RDTSC/RDTSCP instructions as the parameters
being used cannot be changed by hypervisor once the guest is launched.

During the boot-up of the secondary cpus, SecureTSC enabled guests
need to query TSC info from AMD Security Processor. This communication
channel is encrypted between the AMD Security Processor and the guest,
the hypervisor is just the conduit to deliver the guest messages to
the AMD Security Processor. Each message is protected with an
AEAD (AES-256 GCM). Use minimal AES GCM library to encrypt/decrypt SNP
Guest messages to communicate with the PSP.

Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
---
 arch/x86/coco/core.c             |  3 ++
 arch/x86/include/asm/sev-guest.h | 18 +++++++
 arch/x86/include/asm/sev.h       |  2 +
 arch/x86/include/asm/svm.h       |  6 ++-
 arch/x86/kernel/sev.c            | 82 ++++++++++++++++++++++++++++++++
 arch/x86/mm/mem_encrypt_amd.c    |  6 +++
 include/linux/cc_platform.h      |  8 ++++
 7 files changed, 123 insertions(+), 2 deletions(-)

diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
index 73f83233d25d..1cfb86c6bd78 100644
--- a/arch/x86/coco/core.c
+++ b/arch/x86/coco/core.c
@@ -89,6 +89,9 @@ static bool amd_cc_platform_has(enum cc_attr attr)
 	case CC_ATTR_GUEST_SEV_SNP:
 		return sev_status & MSR_AMD64_SEV_SNP_ENABLED;
 
+	case CC_ATTR_GUEST_SECURE_TSC:
+		return sev_status & MSR_AMD64_SNP_SECURE_TSC;
+
 	default:
 		return false;
 	}
diff --git a/arch/x86/include/asm/sev-guest.h b/arch/x86/include/asm/sev-guest.h
index e6f94208173d..58739173eba9 100644
--- a/arch/x86/include/asm/sev-guest.h
+++ b/arch/x86/include/asm/sev-guest.h
@@ -39,6 +39,8 @@ enum msg_type {
 	SNP_MSG_ABSORB_RSP,
 	SNP_MSG_VMRK_REQ,
 	SNP_MSG_VMRK_RSP,
+	SNP_MSG_TSC_INFO_REQ = 17,
+	SNP_MSG_TSC_INFO_RSP,
 
 	SNP_MSG_TYPE_MAX
 };
@@ -111,6 +113,22 @@ struct snp_guest_req {
 	u8 msg_type;
 };
 
+struct snp_tsc_info_req {
+#define SNP_TSC_INFO_REQ_SZ 128
+	/* Must be zero filled */
+	u8 rsvd[SNP_TSC_INFO_REQ_SZ];
+} __packed;
+
+struct snp_tsc_info_resp {
+	/* Status of TSC_INFO message */
+	u32 status;
+	u32 rsvd1;
+	u64 tsc_scale;
+	u64 tsc_offset;
+	u32 tsc_factor;
+	u8 rsvd2[100];
+} __packed;
+
 int snp_setup_psp_messaging(struct snp_guest_dev *snp_dev);
 int snp_send_guest_request(struct snp_guest_dev *dev, struct snp_guest_req *req,
 			   struct snp_guest_request_ioctl *rio);
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 807f85f8014c..d5b35da1b583 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -189,6 +189,7 @@ void snp_set_memory_private(unsigned long vaddr, unsigned int npages);
 void snp_set_wakeup_secondary_cpu(void);
 bool snp_init(struct boot_params *bp);
 void __init __noreturn snp_abort(void);
+void __init snp_secure_tsc_prepare(void);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -208,6 +209,7 @@ static inline void snp_set_memory_private(unsigned long vaddr, unsigned int npag
 static inline void snp_set_wakeup_secondary_cpu(void) { }
 static inline bool snp_init(struct boot_params *bp) { return false; }
 static inline void snp_abort(void) { }
+static inline void __init snp_secure_tsc_prepare(void) { }
 #endif
 
 #endif
diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index e7c7379d6ac7..3956c5095109 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -412,7 +412,9 @@ struct sev_es_save_area {
 	u8 reserved_0x298[80];
 	u32 pkru;
 	u32 tsc_aux;
-	u8 reserved_0x2f0[24];
+	u64 tsc_scale;
+	u64 tsc_offset;
+	u8 reserved_0x300[8];
 	u64 rcx;
 	u64 rdx;
 	u64 rbx;
@@ -544,7 +546,7 @@ static inline void __unused_size_checks(void)
 	BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0x1c0);
 	BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0x248);
 	BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0x298);
-	BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0x2f0);
+	BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0x300);
 	BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0x320);
 	BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0x380);
 	BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0x3f0);
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 72e76c58aebd..d55562cd395d 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -76,6 +76,10 @@ static u64 sev_hv_features __ro_after_init;
 /* Secrets page physical address from the CC blob */
 static u64 secrets_pa __ro_after_init;
 
+/* Secure TSC values read using TSC_INFO SNP Guest request */
+static u64 guest_tsc_scale __ro_after_init;
+static u64 guest_tsc_offset __ro_after_init;
+
 /* #VC handler runtime per-CPU data */
 struct sev_es_runtime_data {
 	struct ghcb ghcb_page;
@@ -1411,6 +1415,78 @@ bool snp_assign_vmpck(struct snp_guest_dev *dev, unsigned int vmpck_id)
 }
 EXPORT_SYMBOL_GPL(snp_assign_vmpck);
 
+static struct snp_guest_dev tsc_snp_dev __initdata;
+
+static int __init snp_get_tsc_info(void)
+{
+	static u8 buf[SNP_TSC_INFO_REQ_SZ + AUTHTAG_LEN];
+	struct snp_guest_request_ioctl rio;
+	struct snp_tsc_info_resp tsc_resp;
+	struct snp_tsc_info_req tsc_req;
+	struct snp_guest_req req;
+	int rc, resp_len;
+
+	/*
+	 * The intermediate response buffer is used while decrypting the
+	 * response payload. Make sure that it has enough space to cover the
+	 * authtag.
+	 */
+	resp_len = sizeof(tsc_resp) + AUTHTAG_LEN;
+	if (sizeof(buf) < resp_len)
+		return -EINVAL;
+
+	memset(&tsc_req, 0, sizeof(tsc_req));
+	memset(&req, 0, sizeof(req));
+	memset(&rio, 0, sizeof(rio));
+	memset(buf, 0, sizeof(buf));
+
+	if (!snp_assign_vmpck(&tsc_snp_dev, 0))
+		return -EINVAL;
+
+	/* Initialize the PSP channel to send snp messages */
+	if (snp_setup_psp_messaging(&tsc_snp_dev))
+		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
+
+	req.msg_version = MSG_HDR_VER;
+	req.msg_type = SNP_MSG_TSC_INFO_REQ;
+	req.vmpck_id = tsc_snp_dev.vmpck_id;
+	req.req_buf = &tsc_req;
+	req.req_sz = sizeof(tsc_req);
+	req.resp_buf = buf;
+	req.resp_sz = resp_len;
+	req.exit_code = SVM_VMGEXIT_GUEST_REQUEST;
+	rc = snp_send_guest_request(&tsc_snp_dev, &req, &rio);
+	if (rc)
+		goto err_req;
+
+	memcpy(&tsc_resp, buf, sizeof(tsc_resp));
+	pr_debug("%s: Valid response status %x scale %llx offset %llx factor %x\n",
+		 __func__, tsc_resp.status, tsc_resp.tsc_scale, tsc_resp.tsc_offset,
+		 tsc_resp.tsc_factor);
+
+	guest_tsc_scale = tsc_resp.tsc_scale;
+	guest_tsc_offset = tsc_resp.tsc_offset;
+
+err_req:
+	/* The response buffer contains the sensitive data, explicitly clear it. */
+	memzero_explicit(buf, sizeof(buf));
+	memzero_explicit(&tsc_resp, sizeof(tsc_resp));
+	memzero_explicit(&req, sizeof(req));
+
+	return rc;
+}
+
+void __init snp_secure_tsc_prepare(void)
+{
+	if (!cc_platform_has(CC_ATTR_GUEST_SECURE_TSC))
+		return;
+
+	if (snp_get_tsc_info())
+		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
+
+	pr_debug("SecureTSC enabled\n");
+}
+
 static int wakeup_cpu_via_vmgexit(int apic_id, unsigned long start_ip)
 {
 	struct sev_es_save_area *cur_vmsa, *vmsa;
@@ -1511,6 +1587,12 @@ static int wakeup_cpu_via_vmgexit(int apic_id, unsigned long start_ip)
 	vmsa->vmpl		= 0;
 	vmsa->sev_features	= sev_status >> 2;
 
+	/* Setting Secure TSC parameters */
+	if (cc_platform_has(CC_ATTR_GUEST_SECURE_TSC)) {
+		vmsa->tsc_scale = guest_tsc_scale;
+		vmsa->tsc_offset = guest_tsc_offset;
+	}
+
 	/* Switch the page over to a VMSA page now that it is initialized */
 	ret = snp_set_vmsa(vmsa, true);
 	if (ret) {
diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
index e0b51c09109f..fc25749fb2e5 100644
--- a/arch/x86/mm/mem_encrypt_amd.c
+++ b/arch/x86/mm/mem_encrypt_amd.c
@@ -215,6 +215,11 @@ void __init sme_map_bootdata(char *real_mode_data)
 	__sme_early_map_unmap_mem(__va(cmdline_paddr), COMMAND_LINE_SIZE, true);
 }
 
+void __init amd_enc_init(void)
+{
+	snp_secure_tsc_prepare();
+}
+
 void __init sev_setup_arch(void)
 {
 	phys_addr_t total_mem = memblock_phys_mem_size();
@@ -501,6 +506,7 @@ void __init sme_early_init(void)
 	x86_platform.guest.enc_status_change_finish  = amd_enc_status_change_finish;
 	x86_platform.guest.enc_tlb_flush_required    = amd_enc_tlb_flush_required;
 	x86_platform.guest.enc_cache_flush_required  = amd_enc_cache_flush_required;
+	x86_platform.guest.enc_init		     = amd_enc_init;
 }
 
 void __init mem_encrypt_free_decrypted_mem(void)
diff --git a/include/linux/cc_platform.h b/include/linux/cc_platform.h
index cb0d6cd1c12f..e081ca4d5da2 100644
--- a/include/linux/cc_platform.h
+++ b/include/linux/cc_platform.h
@@ -90,6 +90,14 @@ enum cc_attr {
 	 * Examples include TDX Guest.
 	 */
 	CC_ATTR_HOTPLUG_DISABLED,
+
+	/**
+	 * @CC_ATTR_GUEST_SECURE_TSC: Secure TSC is active.
+	 *
+	 * The platform/OS is running as a guest/virtual machine and actively
+	 * using AMD SEV-SNP Secure TSC feature.
+	 */
+	CC_ATTR_GUEST_SECURE_TSC,
 };
 
 #ifdef CONFIG_ARCH_HAS_CC_PLATFORM
-- 
2.34.1


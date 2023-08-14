Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B43B77B0E3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 07:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233354AbjHNFxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 01:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbjHNFxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 01:53:17 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061f.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::61f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9843FE6D
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 22:53:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fvLDqgfx5+5v8MwhfHzcLMOrJbyq9vupJu0M7QkNG8iIg6a3vC6NW0dpitkCEV5u5SxFfeZizCqpUOCPZPNKtFKkOaFqCzwRgTNnx7GWLU5J6kDDB5FuSCFjuP7AazvXC2kszxaePWsAFl+NQvANh8GQ8MkuHIxqbV2Hk1Tld6uo7Ktuv4kyE2KAM86xJxxykr1NQdhJRkajk+l71SpUU2YIeBDeepz7IAws7RNRBIaXYPILBgzfMWxWPcqw2xTx4sbBkRO3uznUP3oiCWa/5yxF20bXnv60RtpshoPS2D0j9LczgBiaUwA/FskK97lzI323HROVl93FUNqnjL/fjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C8YBTpFGk7VVMW4QMmFgsK0wze61RTx0YleGqLW4BcE=;
 b=Qvbn5aUQXZ76b5R7chj5fWXzcOSLggRC/ZGprLcPy8324qhK84a25l/cmhl+9n1APLEiasRxEBctxrk8BsmCdLbpaJyfCnlRkeBat0+6j3YDBhZfsdgd/O7GWq6OqnXjQRYf0tmjWZZRxteGaMy18uv634nVBGwuihH8XpVjfd+xNSSlxNZEhB6D8iBhuu7W/3rlBPagmwSCCkeFAvF0Qw/o6MtdKzfNTsH7OMScg0P3vL52lL5IbOa6YMKKVFc1MmygzIBNr8KWUPp4ZzNgd2R6N6lTbnms6ODqbFHo+KxJ4W1BPMC40pnDWnCrWYNdQnSiyptSJwLNIa4e0NzF6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C8YBTpFGk7VVMW4QMmFgsK0wze61RTx0YleGqLW4BcE=;
 b=DWxIPlImGriLc2Oy5PPOnyeTGns/dZnDXEHBB65tmf6LQYHyjB60HdkLGRJln/OqMI/cR9rRuFaO3xVoOMjXCVzft3ajg2IgGdm56GRtNJn96qnPawbKp9v2M7GoKWNKjrhqS3Gb4y3VoZTXUIRhAibnCidhGpX0z70XwTIjTtg=
Received: from MW4PR03CA0191.namprd03.prod.outlook.com (2603:10b6:303:b8::16)
 by BN9PR12MB5067.namprd12.prod.outlook.com (2603:10b6:408:134::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 05:53:12 +0000
Received: from CO1NAM11FT079.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::5a) by MW4PR03CA0191.outlook.office365.com
 (2603:10b6:303:b8::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Mon, 14 Aug 2023 05:53:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT079.mail.protection.outlook.com (10.13.175.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.13 via Frontend Transport; Mon, 14 Aug 2023 05:53:11 +0000
Received: from gomati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 14 Aug
 2023 00:52:57 -0500
From:   Nikunj A Dadhania <nikunj@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC:     <bp@alien8.de>, <thomas.lendacky@amd.com>,
        <dionnaglaze@google.com>, <pgonda@google.com>, <seanjc@google.com>,
        <pbonzini@redhat.com>, <nikunj@amd.com>
Subject: [PATCH v4 04/14] virt: sev-guest: Add SNP guest request structure
Date:   Mon, 14 Aug 2023 11:22:12 +0530
Message-ID: <20230814055222.1056404-5-nikunj@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT079:EE_|BN9PR12MB5067:EE_
X-MS-Office365-Filtering-Correlation-Id: 44c86c8e-85ac-4d9f-41fd-08db9c8abe48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5I4tekAEStZc6kSmyV/EXf07k+Mn20H0iDf3UjD6QsD5LQPOUOHo9JJx4CrMZuIWNn+U8h+3ClOGU7AGRqNdAhvAYVXjX+8m/9GCTJ01z4KVrWZnx0tV8brOvqD0Np6PKeMlHz/3jPcuRlCzuCyQKQOrI0XhQzlGJJXv1NeTM8J1YFz13mPm81Qq7zh38OdUubh7mi5Kxwj2ZWawlzTIOuacLOa+kWQo5GWMmuz224M+2MJ4/fGT9LdKg+6ce77tdYwoBqIUZL8Xh5KTBvmMCvXpmi5KWTn5pFs1MuE6U7bgBSkiVCeJszGI3Afbn7bD1ze6e5OI3g3ZHjXxxtN5ZNykYnnaz13bNMafwWDwmV04ipVe+QxF3TDgs4BZ+v3MJMTTzjD5QvZZihPbw0raHZ4R+ujGKDklGObaLGH50990zl6+b3Lfazmd9Vafsk/z966JD/itG0dJ0sr2eUilXkii6xOl+RnTw1DlTFGxM5ODXjcsX//bdJ0vlf6HMD1dFxlQwM0IG+R4KJduPGYxKD/y6GAUPkKg03YgA7x+yoVQZ4qFN8gklD56aioeZUxp4uru2XVYAbbGHmhmbu4jpYdwWoyjMQGm0wcCqKneJMDyHNhVlX/w/FVsEwYwWRLl87kCgqah4KJ26D+W/nHTJ7h8irn/kwvJNF+cE8IiwoZOLqOY9jTdBBVIMqt7O+j42Ms+JghN14SKWV86ADJthQ7ccNPruakqKRUFa6UcZEnkag2kWnu/ojpieC4sMRKsZ/vhA6oDwZB5ZojzbbbwsA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(376002)(396003)(1800799006)(186006)(82310400008)(451199021)(40470700004)(36840700001)(46966006)(7696005)(6666004)(36756003)(356005)(81166007)(82740400003)(83380400001)(47076005)(36860700001)(26005)(1076003)(2906002)(30864003)(54906003)(110136005)(40480700001)(426003)(2616005)(16526019)(336012)(478600001)(8676002)(41300700001)(8936002)(70206006)(5660300002)(40460700003)(70586007)(316002)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 05:53:11.3321
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44c86c8e-85ac-4d9f-41fd-08db9c8abe48
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT079.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5067
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a snp_guest_req structure to simplify the function arguments. The
structure will be used to call the SNP Guest message request API
instead of passing a long list of parameters.

Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
---
 .../x86/include/asm}/sev-guest.h              |  11 ++
 arch/x86/include/asm/sev.h                    |   7 --
 arch/x86/kernel/sev.c                         |  15 ++-
 drivers/virt/coco/sev-guest/sev-guest.c       | 103 +++++++++++-------
 4 files changed, 84 insertions(+), 52 deletions(-)
 rename {drivers/virt/coco/sev-guest => arch/x86/include/asm}/sev-guest.h (80%)

diff --git a/drivers/virt/coco/sev-guest/sev-guest.h b/arch/x86/include/asm/sev-guest.h
similarity index 80%
rename from drivers/virt/coco/sev-guest/sev-guest.h
rename to arch/x86/include/asm/sev-guest.h
index ceb798a404d6..22ef97b55069 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.h
+++ b/arch/x86/include/asm/sev-guest.h
@@ -63,4 +63,15 @@ struct snp_guest_msg {
 	u8 payload[4000];
 } __packed;
 
+struct snp_guest_req {
+	void *req_buf, *resp_buf, *data;
+	size_t req_sz, resp_sz, *data_npages;
+	u64 exit_code;
+	unsigned int vmpck_id;
+	u8 msg_version;
+	u8 msg_type;
+};
+
+int snp_issue_guest_request(struct snp_guest_req *req, struct snp_req_data *input,
+			    struct snp_guest_request_ioctl *rio);
 #endif /* __VIRT_SEVGUEST_H__ */
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 13dc2a9d23c1..d8e972aeb22c 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -92,8 +92,6 @@ extern bool handle_vc_boot_ghcb(struct pt_regs *regs);
 struct snp_req_data {
 	unsigned long req_gpa;
 	unsigned long resp_gpa;
-	unsigned long data_gpa;
-	unsigned int data_npages;
 };
 
 struct sev_guest_platform_data {
@@ -201,7 +199,6 @@ void snp_set_memory_private(unsigned long vaddr, unsigned int npages);
 void snp_set_wakeup_secondary_cpu(void);
 bool snp_init(struct boot_params *bp);
 void __init __noreturn snp_abort(void);
-int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, struct snp_guest_request_ioctl *rio);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -221,10 +218,6 @@ static inline void snp_set_memory_private(unsigned long vaddr, unsigned int npag
 static inline void snp_set_wakeup_secondary_cpu(void) { }
 static inline bool snp_init(struct boot_params *bp) { return false; }
 static inline void snp_abort(void) { }
-static inline int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, struct snp_guest_request_ioctl *rio)
-{
-	return -ENOTTY;
-}
 #endif
 
 #endif
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index b031244d6d2d..a10cf9f21e22 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -28,6 +28,7 @@
 #include <asm/cpu_entry_area.h>
 #include <asm/stacktrace.h>
 #include <asm/sev.h>
+#include <asm/sev-guest.h>
 #include <asm/insn-eval.h>
 #include <asm/fpu/xcr.h>
 #include <asm/processor.h>
@@ -2177,15 +2178,21 @@ static int __init init_sev_config(char *str)
 }
 __setup("sev=", init_sev_config);
 
-int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, struct snp_guest_request_ioctl *rio)
+int snp_issue_guest_request(struct snp_guest_req *req, struct snp_req_data *input,
+			    struct snp_guest_request_ioctl *rio)
 {
 	struct ghcb_state state;
 	struct es_em_ctxt ctxt;
 	unsigned long flags;
 	struct ghcb *ghcb;
+	u64 exit_code;
 	int ret;
 
 	rio->exitinfo2 = SEV_RET_NO_FW_CALL;
+	if (!req)
+		return -EINVAL;
+
+	exit_code = req->exit_code;
 
 	/*
 	 * __sev_get_ghcb() needs to run with IRQs disabled because it is using
@@ -2202,8 +2209,8 @@ int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, struct sn
 	vc_ghcb_invalidate(ghcb);
 
 	if (exit_code == SVM_VMGEXIT_EXT_GUEST_REQUEST) {
-		ghcb_set_rax(ghcb, input->data_gpa);
-		ghcb_set_rbx(ghcb, input->data_npages);
+		ghcb_set_rax(ghcb, __pa(req->data));
+		ghcb_set_rbx(ghcb, *req->data_npages);
 	}
 
 	ret = sev_es_ghcb_hv_call(ghcb, &ctxt, exit_code, input->req_gpa, input->resp_gpa);
@@ -2222,7 +2229,7 @@ int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, struct sn
 	case SNP_GUEST_VMM_ERR(SNP_GUEST_VMM_ERR_INVALID_LEN):
 		/* Number of expected pages are returned in RBX */
 		if (exit_code == SVM_VMGEXIT_EXT_GUEST_REQUEST) {
-			input->data_npages = ghcb_get_rbx(ghcb);
+			*req->data_npages = ghcb_get_rbx(ghcb);
 			ret = -ENOSPC;
 			break;
 		}
diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 538c42e64baa..74b796409da9 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -23,8 +23,7 @@
 
 #include <asm/svm.h>
 #include <asm/sev.h>
-
-#include "sev-guest.h"
+#include <asm/sev-guest.h>
 
 #define DEVICE_NAME	"sev-guest"
 
@@ -198,7 +197,7 @@ static int dec_payload(struct aesgcm_ctx *ctx, struct snp_guest_msg *msg,
 		return -EBADMSG;
 }
 
-static int verify_and_dec_payload(struct snp_guest_dev *snp_dev, void *payload, u32 sz)
+static int verify_and_dec_payload(struct snp_guest_dev *snp_dev, struct snp_guest_req *guest_req)
 {
 	struct snp_guest_msg *resp = &snp_dev->secret_response;
 	struct snp_guest_msg *req = &snp_dev->secret_request;
@@ -226,29 +225,28 @@ static int verify_and_dec_payload(struct snp_guest_dev *snp_dev, void *payload,
 	 * If the message size is greater than our buffer length then return
 	 * an error.
 	 */
-	if (unlikely((resp_hdr->msg_sz + ctx->authsize) > sz))
+	if (unlikely((resp_hdr->msg_sz + ctx->authsize) > guest_req->resp_sz))
 		return -EBADMSG;
 
 	/* Decrypt the payload */
-	return dec_payload(ctx, resp, payload, resp_hdr->msg_sz);
+	return dec_payload(ctx, resp, guest_req->resp_buf, resp_hdr->msg_sz);
 }
 
-static int enc_payload(struct snp_guest_dev *snp_dev, u64 seqno, int version, u8 type,
-			void *payload, size_t sz)
+static int enc_payload(struct snp_guest_dev *snp_dev, u64 seqno, struct snp_guest_req *req)
 {
-	struct snp_guest_msg *req = &snp_dev->secret_request;
-	struct snp_guest_msg_hdr *hdr = &req->hdr;
+	struct snp_guest_msg *msg = &snp_dev->secret_request;
+	struct snp_guest_msg_hdr *hdr = &msg->hdr;
 
-	memset(req, 0, sizeof(*req));
+	memset(msg, 0, sizeof(*msg));
 
 	hdr->algo = SNP_AEAD_AES_256_GCM;
 	hdr->hdr_version = MSG_HDR_VER;
 	hdr->hdr_sz = sizeof(*hdr);
-	hdr->msg_type = type;
-	hdr->msg_version = version;
+	hdr->msg_type = req->msg_type;
+	hdr->msg_version = req->msg_version;
 	hdr->msg_seqno = seqno;
-	hdr->msg_vmpck = vmpck_id;
-	hdr->msg_sz = sz;
+	hdr->msg_vmpck = req->vmpck_id;
+	hdr->msg_sz = req->req_sz;
 
 	/* Verify the sequence number is non-zero */
 	if (!hdr->msg_seqno)
@@ -257,10 +255,10 @@ static int enc_payload(struct snp_guest_dev *snp_dev, u64 seqno, int version, u8
 	pr_debug("request [seqno %lld type %d version %d sz %d]\n",
 		 hdr->msg_seqno, hdr->msg_type, hdr->msg_version, hdr->msg_sz);
 
-	return __enc_payload(snp_dev->ctx, req, payload, sz);
+	return __enc_payload(snp_dev->ctx, msg, req->req_buf, req->req_sz);
 }
 
-static int __handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
+static int __handle_guest_request(struct snp_guest_dev *snp_dev, struct snp_guest_req *req,
 				  struct snp_guest_request_ioctl *rio)
 {
 	unsigned long req_start = jiffies;
@@ -275,7 +273,7 @@ static int __handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
 	 * sequence number must be incremented or the VMPCK must be deleted to
 	 * prevent reuse of the IV.
 	 */
-	rc = snp_issue_guest_request(exit_code, &snp_dev->input, rio);
+	rc = snp_issue_guest_request(req, &snp_dev->input, rio);
 	switch (rc) {
 	case -ENOSPC:
 		/*
@@ -285,8 +283,8 @@ static int __handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
 		 * order to increment the sequence number and thus avoid
 		 * IV reuse.
 		 */
-		override_npages = snp_dev->input.data_npages;
-		exit_code	= SVM_VMGEXIT_GUEST_REQUEST;
+		override_npages = *req->data_npages;
+		req->exit_code	= SVM_VMGEXIT_GUEST_REQUEST;
 
 		/*
 		 * Override the error to inform callers the given extended
@@ -341,15 +339,13 @@ static int __handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
 	}
 
 	if (override_npages)
-		snp_dev->input.data_npages = override_npages;
+		*req->data_npages = override_npages;
 
 	return rc;
 }
 
-static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
-				struct snp_guest_request_ioctl *rio, u8 type,
-				void *req_buf, size_t req_sz, void *resp_buf,
-				u32 resp_sz)
+static int snp_send_guest_request(struct snp_guest_dev *snp_dev, struct snp_guest_req *req,
+				  struct snp_guest_request_ioctl *rio)
 {
 	u64 seqno;
 	int rc;
@@ -363,7 +359,7 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
 	memset(snp_dev->response, 0, sizeof(struct snp_guest_msg));
 
 	/* Encrypt the userspace provided payload in snp_dev->secret_request. */
-	rc = enc_payload(snp_dev, seqno, rio->msg_version, type, req_buf, req_sz);
+	rc = enc_payload(snp_dev, seqno, req);
 	if (rc)
 		return rc;
 
@@ -374,7 +370,7 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
 	memcpy(snp_dev->request, &snp_dev->secret_request,
 	       sizeof(snp_dev->secret_request));
 
-	rc = __handle_guest_request(snp_dev, exit_code, rio);
+	rc = __handle_guest_request(snp_dev, req, rio);
 	if (rc) {
 		if (rc == -EIO &&
 		    rio->exitinfo2 == SNP_GUEST_VMM_ERR(SNP_GUEST_VMM_ERR_INVALID_LEN))
@@ -383,12 +379,11 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
 		dev_alert(snp_dev->dev,
 			  "Detected error from ASP request. rc: %d, exitinfo2: 0x%llx\n",
 			  rc, rio->exitinfo2);
-
 		snp_disable_vmpck(snp_dev);
 		return rc;
 	}
 
-	rc = verify_and_dec_payload(snp_dev, resp_buf, resp_sz);
+	rc = verify_and_dec_payload(snp_dev, req);
 	if (rc) {
 		dev_alert(snp_dev->dev, "Detected unexpected decode failure from ASP. rc: %d\n", rc);
 		snp_disable_vmpck(snp_dev);
@@ -400,6 +395,7 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
 
 static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg)
 {
+	struct snp_guest_req guest_req = {0};
 	struct snp_report_resp *resp;
 	struct snp_report_req req;
 	int rc, resp_len;
@@ -422,9 +418,16 @@ static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_io
 	if (!resp)
 		return -ENOMEM;
 
-	rc = handle_guest_request(snp_dev, SVM_VMGEXIT_GUEST_REQUEST, arg,
-				  SNP_MSG_REPORT_REQ, &req, sizeof(req), resp->data,
-				  resp_len);
+	guest_req.msg_version = arg->msg_version;
+	guest_req.msg_type = SNP_MSG_REPORT_REQ;
+	guest_req.vmpck_id = vmpck_id;
+	guest_req.req_buf = &req;
+	guest_req.req_sz = sizeof(req);
+	guest_req.resp_buf = resp->data;
+	guest_req.resp_sz = resp_len;
+	guest_req.exit_code = SVM_VMGEXIT_GUEST_REQUEST;
+
+	rc = snp_send_guest_request(snp_dev, &guest_req, arg);
 	if (rc)
 		goto e_free;
 
@@ -439,6 +442,7 @@ static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_io
 static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg)
 {
 	struct snp_derived_key_resp resp = {0};
+	struct snp_guest_req guest_req = {0};
 	struct snp_derived_key_req req;
 	int rc, resp_len;
 	/* Response data is 64 bytes and max authsize for GCM is 16 bytes. */
@@ -461,8 +465,16 @@ static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_reque
 	if (copy_from_user(&req, (void __user *)arg->req_data, sizeof(req)))
 		return -EFAULT;
 
-	rc = handle_guest_request(snp_dev, SVM_VMGEXIT_GUEST_REQUEST, arg,
-				  SNP_MSG_KEY_REQ, &req, sizeof(req), buf, resp_len);
+	guest_req.msg_version = arg->msg_version;
+	guest_req.msg_type = SNP_MSG_KEY_REQ;
+	guest_req.vmpck_id = vmpck_id;
+	guest_req.req_buf = &req;
+	guest_req.req_sz = sizeof(req);
+	guest_req.resp_buf = buf;
+	guest_req.resp_sz = resp_len;
+	guest_req.exit_code = SVM_VMGEXIT_GUEST_REQUEST;
+
+	rc = snp_send_guest_request(snp_dev, &guest_req, arg);
 	if (rc)
 		return rc;
 
@@ -478,9 +490,11 @@ static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_reque
 
 static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg)
 {
+	struct snp_guest_req guest_req = {0};
 	struct snp_ext_report_req req;
 	struct snp_report_resp *resp;
-	int ret, npages = 0, resp_len;
+	int ret, resp_len;
+	size_t npages = 0;
 
 	lockdep_assert_held(&snp_dev->cmd_mutex);
 
@@ -520,14 +534,22 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
 	if (!resp)
 		return -ENOMEM;
 
-	snp_dev->input.data_npages = npages;
-	ret = handle_guest_request(snp_dev, SVM_VMGEXIT_EXT_GUEST_REQUEST, arg,
-				   SNP_MSG_REPORT_REQ, &req.data,
-				   sizeof(req.data), resp->data, resp_len);
+	guest_req.msg_version = arg->msg_version;
+	guest_req.msg_type = SNP_MSG_REPORT_REQ;
+	guest_req.vmpck_id = vmpck_id;
+	guest_req.req_buf = &req.data;
+	guest_req.req_sz = sizeof(req.data);
+	guest_req.resp_buf = resp->data;
+	guest_req.resp_sz = resp_len;
+	guest_req.exit_code = SVM_VMGEXIT_EXT_GUEST_REQUEST;
+	guest_req.data = snp_dev->certs_data;
+	guest_req.data_npages = &npages;
+
+	ret = snp_send_guest_request(snp_dev, &guest_req, arg);
 
 	/* If certs length is invalid then copy the returned length */
 	if (arg->vmm_error == SNP_GUEST_VMM_ERR_INVALID_LEN) {
-		req.certs_len = snp_dev->input.data_npages << PAGE_SHIFT;
+		req.certs_len = npages << PAGE_SHIFT;
 
 		if (copy_to_user((void __user *)arg->req_data, &req, sizeof(req)))
 			ret = -EFAULT;
@@ -536,7 +558,7 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
 	if (ret)
 		goto e_free;
 
-	if (npages &&
+	if (npages && req.certs_len &&
 	    copy_to_user((void __user *)req.certs_address, snp_dev->certs_data,
 			 req.certs_len)) {
 		ret = -EFAULT;
@@ -740,7 +762,6 @@ static int __init sev_guest_probe(struct platform_device *pdev)
 	/* initial the input address for guest request */
 	snp_dev->input.req_gpa = __pa(snp_dev->request);
 	snp_dev->input.resp_gpa = __pa(snp_dev->response);
-	snp_dev->input.data_gpa = __pa(snp_dev->certs_data);
 
 	ret =  misc_register(misc);
 	if (ret)
-- 
2.34.1


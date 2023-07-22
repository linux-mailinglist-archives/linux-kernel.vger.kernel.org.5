Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD9B575DBD8
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 13:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjGVLU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 07:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjGVLUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 07:20:24 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6382691
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 04:20:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kk5iE1Re+7ajfK2Eyq6jJmhRpgXnRPdturyZldGAx2w/SRnZDu+tQGx3Q/+5WIBE72FO/8cI1iHvzgwlo7IjW/ZqZz3JjRNDgN83618Gv9PBsFo09AacN9mz9rRizAlnS89Rqwr4X1wgjY6oWFRPPIJ6/CPXYzZDP9OSXJ0WHFH5CTPV0Wo6ATvWZMHD2cOu30kXyVuTEhVKvdrYv17R2t6b2FVtyvMvVrTyE4QWVqUVOO7JJ3L5PqTlCNBFR2lZFDNSMjECDrxy8tnaP4AsL3DEdqPBR4sbpRCyV5nfFv9llbgSpV/g80FkouSe0QMpXEljN0ZZqyqxrYmrbQayUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VRFylGabQzzvJqhEhXUBSxSlnX16uDNWgUblpWO7iA0=;
 b=ZEI+4WPI2fcCP4fsIhWWbTWYdgIHoOXZeIjpnxasMNsY1ol9seLZgKFBiKuF+dmwWxlUO6xkQb0wM5gbiWmnmEU0Jv5qwA6PkOt4vOCYcI16E3yogVsFFb3WLs1+0KctFARz36NppXYne9pDtWOYir2/9+539bXvVZJxGUhaxwFVzAUebu7vZ68WPtfx7/3pIgdas1IvIMVKUWeFSCLiag2r6QDVc6fZNw/Gtxv17qN3+FTNbqnID5aBq03yiF2N0LKMZefmCJXpsaGsuNyyVs+HFMN5Gg5nB+lNsY+hyh1xEPn9I0xD5yu0G9PuECDKR5140UgM87usGOGq0DGedA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRFylGabQzzvJqhEhXUBSxSlnX16uDNWgUblpWO7iA0=;
 b=U37wRY9+1R9XCG7UNueJUc1JZGMlFLnBJJ43tesaK0Ic9z2nAwDhCZ/OeFMIR4BoJmy3K2YnDVKKTbi4CLAMcQaFu8PkzFOy/fEFRgEr1BF9Vo3wyJKzFQesHm1MZsB+y6+cTqE0iY8OsBEo+cxmxnwWAkvdk5S83aLpTsCKhqw=
Received: from DM5PR07CA0072.namprd07.prod.outlook.com (2603:10b6:4:ad::37) by
 PH7PR12MB7019.namprd12.prod.outlook.com (2603:10b6:510:1b9::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.29; Sat, 22 Jul 2023 11:20:18 +0000
Received: from DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::de) by DM5PR07CA0072.outlook.office365.com
 (2603:10b6:4:ad::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.30 via Frontend
 Transport; Sat, 22 Jul 2023 11:20:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT052.mail.protection.outlook.com (10.13.172.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.22 via Frontend Transport; Sat, 22 Jul 2023 11:20:18 +0000
Received: from gomati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 22 Jul
 2023 06:20:13 -0500
From:   Nikunj A Dadhania <nikunj@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC:     <bp@alien8.de>, <thomas.lendacky@amd.com>,
        <dionnaglaze@google.com>, <pgonda@google.com>, <seanjc@google.com>,
        <pbonzini@redhat.com>, <nikunj@amd.com>
Subject: [PATCH v3 01/14] virt: sev-guest: Use AES GCM crypto library
Date:   Sat, 22 Jul 2023 16:48:56 +0530
Message-ID: <20230722111909.15166-2-nikunj@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230722111909.15166-1-nikunj@amd.com>
References: <20230722111909.15166-1-nikunj@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT052:EE_|PH7PR12MB7019:EE_
X-MS-Office365-Filtering-Correlation-Id: 85fe9f5b-a2fc-42e8-dd6e-08db8aa5a16f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZczAdonh/phlz5K6JExTl18JiS4iRKVfg+QXPiJ6oeXSWNiLBuXwUWos1WuuMH/8ZmZI2noYi1OM7JjTzu3HvR35czV2alpHQp5S1ZS2q15DlGROLgsVd9QTXbR9n9uGfCm6gD207bsCcHmif12M5JUPEFfMxTowYxP2DkrgA8etgSf0WJDESTxvpte+lx+TiPBrTmTPw1urC0FDwPxoQ68w6Oo85pZ+x7V/Bn8A8aqco7LjVQKWCifzfAHq0zX+yW3nQ8N6mBphVTqLKZJbwAqSLSs5AZBF/7LnNfFlBrom9OSZGgNwkvUIlygWaV+x9KGtg5OB9nXqKBYDRdz8pq5J0lI5fQsGLgL9A1KhKXEIyJhIk+YFpwbMll/3+XIYRiZGX22ldAlQnXMvUCs7PYhbI/Z9zY/96Nqg13kuPFbgFytfy8hFumJpxhnwsGOgeFjm54S++n06J5JUcyDdOC3osxRSUgZmffotKOBSW1XNNTKY/H99nBL7OVewrnKhniZXiD/JFToH1YfokO39gSbbyQmd7PoLDnoMbWRbpwebo+7kDd0oR0kogScFS0ZJz//Xf/U+ZQHqm/PmH82JWfWGqw8JP80egJxYfIOQy83BklxhZ2vs6HAReFZIOIZ0QblglyYhovM8La8DsOt6GmuzN44lbGz0l2+013ws8I68hH6hM4IyNPRZ7zWIu3Y+w9iz4O+jKBZyY7L821RodokOZA6ijae+osd/S42B6GgBRJp+7aPICIgqNa4y4NLHz77/FADVmrI2cGPG85zGtw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(346002)(396003)(82310400008)(451199021)(36840700001)(46966006)(40470700004)(7696005)(966005)(54906003)(110136005)(478600001)(6666004)(36860700001)(83380400001)(47076005)(426003)(40460700003)(36756003)(40480700001)(30864003)(2906002)(16526019)(336012)(2616005)(186003)(1076003)(26005)(356005)(82740400003)(81166007)(70206006)(4326008)(316002)(70586007)(41300700001)(8676002)(8936002)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2023 11:20:18.4819
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85fe9f5b-a2fc-42e8-dd6e-08db8aa5a16f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7019
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sev-guest driver encryption code uses Crypto API for SNP guest
messaging to interact with AMD Security processor. For enabling SecureTSC,
SEV-SNP guests need to send a TSC_INFO request guest message before the
smpboot phase starts. Details from the TSC_INFO response will be used to
program the VMSA before the secondary CPUs are brought up. The Crypto API
is not available this early in the boot phase.

In preparation of moving the encryption code out of sev-guest driver to
support SecureTSC and make reviewing the diff easier, start using AES GCM
library implementation instead of Crypto API.

Link: https://lore.kernel.org/all/20221103192259.2229-1-ardb@kernel.org
CC: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
---
 drivers/virt/coco/sev-guest/Kconfig     |   3 +-
 drivers/virt/coco/sev-guest/sev-guest.c | 172 +++++++-----------------
 drivers/virt/coco/sev-guest/sev-guest.h |   3 +
 3 files changed, 53 insertions(+), 125 deletions(-)

diff --git a/drivers/virt/coco/sev-guest/Kconfig b/drivers/virt/coco/sev-guest/Kconfig
index f9db0799ae67..bcc760bfb468 100644
--- a/drivers/virt/coco/sev-guest/Kconfig
+++ b/drivers/virt/coco/sev-guest/Kconfig
@@ -2,8 +2,7 @@ config SEV_GUEST
 	tristate "AMD SEV Guest driver"
 	default m
 	depends on AMD_MEM_ENCRYPT
-	select CRYPTO_AEAD2
-	select CRYPTO_GCM
+	select CRYPTO_LIB_AESGCM
 	help
 	  SEV-SNP firmware provides the guest a mechanism to communicate with
 	  the PSP without risk from a malicious hypervisor who wishes to read,
diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 97dbe715e96a..520e2b6613a7 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -16,8 +16,7 @@
 #include <linux/miscdevice.h>
 #include <linux/set_memory.h>
 #include <linux/fs.h>
-#include <crypto/aead.h>
-#include <linux/scatterlist.h>
+#include <crypto/gcm.h>
 #include <linux/psp-sev.h>
 #include <uapi/linux/sev-guest.h>
 #include <uapi/linux/psp-sev.h>
@@ -28,24 +27,16 @@
 #include "sev-guest.h"
 
 #define DEVICE_NAME	"sev-guest"
-#define AAD_LEN		48
-#define MSG_HDR_VER	1
 
 #define SNP_REQ_MAX_RETRY_DURATION	(60*HZ)
 #define SNP_REQ_RETRY_DELAY		(2*HZ)
 
-struct snp_guest_crypto {
-	struct crypto_aead *tfm;
-	u8 *iv, *authtag;
-	int iv_len, a_len;
-};
-
 struct snp_guest_dev {
 	struct device *dev;
 	struct miscdevice misc;
 
 	void *certs_data;
-	struct snp_guest_crypto *crypto;
+	struct aesgcm_ctx *ctx;
 	/* request and response are in unencrypted memory */
 	struct snp_guest_msg *request, *response;
 
@@ -68,6 +59,15 @@ MODULE_PARM_DESC(vmpck_id, "The VMPCK ID to use when communicating with the PSP.
 /* Mutex to serialize the shared buffer access and command handling. */
 static DEFINE_MUTEX(snp_cmd_mutex);
 
+static inline unsigned int get_ctx_authsize(struct snp_guest_dev *snp_dev)
+{
+	if (snp_dev && snp_dev->ctx)
+		return snp_dev->ctx->authsize;
+
+	WARN_ONCE(1, "Unable to get crypto authsize\n");
+	return 0;
+}
+
 static bool is_vmpck_empty(struct snp_guest_dev *snp_dev)
 {
 	char zero_key[VMPCK_KEY_LEN] = {0};
@@ -152,132 +152,59 @@ static inline struct snp_guest_dev *to_snp_dev(struct file *file)
 	return container_of(dev, struct snp_guest_dev, misc);
 }
 
-static struct snp_guest_crypto *init_crypto(struct snp_guest_dev *snp_dev, u8 *key, size_t keylen)
+static struct aesgcm_ctx *snp_init_crypto(u8 *key, size_t keylen)
 {
-	struct snp_guest_crypto *crypto;
+	struct aesgcm_ctx *ctx;
 
-	crypto = kzalloc(sizeof(*crypto), GFP_KERNEL_ACCOUNT);
-	if (!crypto)
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL_ACCOUNT);
+	if (!ctx)
 		return NULL;
 
-	crypto->tfm = crypto_alloc_aead("gcm(aes)", 0, 0);
-	if (IS_ERR(crypto->tfm))
-		goto e_free;
-
-	if (crypto_aead_setkey(crypto->tfm, key, keylen))
-		goto e_free_crypto;
-
-	crypto->iv_len = crypto_aead_ivsize(crypto->tfm);
-	crypto->iv = kmalloc(crypto->iv_len, GFP_KERNEL_ACCOUNT);
-	if (!crypto->iv)
-		goto e_free_crypto;
-
-	if (crypto_aead_authsize(crypto->tfm) > MAX_AUTHTAG_LEN) {
-		if (crypto_aead_setauthsize(crypto->tfm, MAX_AUTHTAG_LEN)) {
-			dev_err(snp_dev->dev, "failed to set authsize to %d\n", MAX_AUTHTAG_LEN);
-			goto e_free_iv;
-		}
+	if (aesgcm_expandkey(ctx, key, keylen, AUTHTAG_LEN)) {
+		pr_err("SNP: crypto init failed\n");
+		kfree(ctx);
+		return NULL;
 	}
 
-	crypto->a_len = crypto_aead_authsize(crypto->tfm);
-	crypto->authtag = kmalloc(crypto->a_len, GFP_KERNEL_ACCOUNT);
-	if (!crypto->authtag)
-		goto e_free_iv;
-
-	return crypto;
-
-e_free_iv:
-	kfree(crypto->iv);
-e_free_crypto:
-	crypto_free_aead(crypto->tfm);
-e_free:
-	kfree(crypto);
-
-	return NULL;
+	return ctx;
 }
 
-static void deinit_crypto(struct snp_guest_crypto *crypto)
-{
-	crypto_free_aead(crypto->tfm);
-	kfree(crypto->iv);
-	kfree(crypto->authtag);
-	kfree(crypto);
-}
-
-static int enc_dec_message(struct snp_guest_crypto *crypto, struct snp_guest_msg *msg,
-			   u8 *src_buf, u8 *dst_buf, size_t len, bool enc)
-{
-	struct snp_guest_msg_hdr *hdr = &msg->hdr;
-	struct scatterlist src[3], dst[3];
-	DECLARE_CRYPTO_WAIT(wait);
-	struct aead_request *req;
-	int ret;
-
-	req = aead_request_alloc(crypto->tfm, GFP_KERNEL);
-	if (!req)
-		return -ENOMEM;
-
-	/*
-	 * AEAD memory operations:
-	 * +------ AAD -------+------- DATA -----+---- AUTHTAG----+
-	 * |  msg header      |  plaintext       |  hdr->authtag  |
-	 * | bytes 30h - 5Fh  |    or            |                |
-	 * |                  |   cipher         |                |
-	 * +------------------+------------------+----------------+
-	 */
-	sg_init_table(src, 3);
-	sg_set_buf(&src[0], &hdr->algo, AAD_LEN);
-	sg_set_buf(&src[1], src_buf, hdr->msg_sz);
-	sg_set_buf(&src[2], hdr->authtag, crypto->a_len);
-
-	sg_init_table(dst, 3);
-	sg_set_buf(&dst[0], &hdr->algo, AAD_LEN);
-	sg_set_buf(&dst[1], dst_buf, hdr->msg_sz);
-	sg_set_buf(&dst[2], hdr->authtag, crypto->a_len);
-
-	aead_request_set_ad(req, AAD_LEN);
-	aead_request_set_tfm(req, crypto->tfm);
-	aead_request_set_callback(req, 0, crypto_req_done, &wait);
-
-	aead_request_set_crypt(req, src, dst, len, crypto->iv);
-	ret = crypto_wait_req(enc ? crypto_aead_encrypt(req) : crypto_aead_decrypt(req), &wait);
-
-	aead_request_free(req);
-	return ret;
-}
-
-static int __enc_payload(struct snp_guest_dev *snp_dev, struct snp_guest_msg *msg,
+static int __enc_payload(struct aesgcm_ctx *ctx, struct snp_guest_msg *msg,
 			 void *plaintext, size_t len)
 {
-	struct snp_guest_crypto *crypto = snp_dev->crypto;
 	struct snp_guest_msg_hdr *hdr = &msg->hdr;
+	u8 iv[GCM_AES_IV_SIZE] = {};
 
-	memset(crypto->iv, 0, crypto->iv_len);
-	memcpy(crypto->iv, &hdr->msg_seqno, sizeof(hdr->msg_seqno));
+	if (WARN_ON((hdr->msg_sz + ctx->authsize) > sizeof(msg->payload)))
+		return -EBADMSG;
 
-	return enc_dec_message(crypto, msg, plaintext, msg->payload, len, true);
+	memcpy(iv, &hdr->msg_seqno, sizeof(hdr->msg_seqno));
+	aesgcm_encrypt(ctx, msg->payload, plaintext, len, &hdr->algo, AAD_LEN,
+		       iv, hdr->authtag);
+	return 0;
 }
 
-static int dec_payload(struct snp_guest_dev *snp_dev, struct snp_guest_msg *msg,
+static int dec_payload(struct aesgcm_ctx *ctx, struct snp_guest_msg *msg,
 		       void *plaintext, size_t len)
 {
-	struct snp_guest_crypto *crypto = snp_dev->crypto;
 	struct snp_guest_msg_hdr *hdr = &msg->hdr;
+	u8 iv[GCM_AES_IV_SIZE] = {};
 
-	/* Build IV with response buffer sequence number */
-	memset(crypto->iv, 0, crypto->iv_len);
-	memcpy(crypto->iv, &hdr->msg_seqno, sizeof(hdr->msg_seqno));
-
-	return enc_dec_message(crypto, msg, msg->payload, plaintext, len, false);
+	memcpy(iv, &hdr->msg_seqno, sizeof(hdr->msg_seqno));
+	if (aesgcm_decrypt(ctx, plaintext, msg->payload, len, &hdr->algo,
+			   AAD_LEN, iv, hdr->authtag))
+		return 0;
+	else
+		return -EBADMSG;
 }
 
 static int verify_and_dec_payload(struct snp_guest_dev *snp_dev, void *payload, u32 sz)
 {
-	struct snp_guest_crypto *crypto = snp_dev->crypto;
 	struct snp_guest_msg *resp = &snp_dev->secret_response;
 	struct snp_guest_msg *req = &snp_dev->secret_request;
 	struct snp_guest_msg_hdr *req_hdr = &req->hdr;
 	struct snp_guest_msg_hdr *resp_hdr = &resp->hdr;
+	struct aesgcm_ctx *ctx = snp_dev->ctx;
 
 	dev_dbg(snp_dev->dev, "response [seqno %lld type %d version %d sz %d]\n",
 		resp_hdr->msg_seqno, resp_hdr->msg_type, resp_hdr->msg_version, resp_hdr->msg_sz);
@@ -298,11 +225,11 @@ static int verify_and_dec_payload(struct snp_guest_dev *snp_dev, void *payload,
 	 * If the message size is greater than our buffer length then return
 	 * an error.
 	 */
-	if (unlikely((resp_hdr->msg_sz + crypto->a_len) > sz))
+	if (unlikely((resp_hdr->msg_sz + ctx->authsize) > sz))
 		return -EBADMSG;
 
 	/* Decrypt the payload */
-	return dec_payload(snp_dev, resp, payload, resp_hdr->msg_sz + crypto->a_len);
+	return dec_payload(ctx, resp, payload, resp_hdr->msg_sz);
 }
 
 static int enc_payload(struct snp_guest_dev *snp_dev, u64 seqno, int version, u8 type,
@@ -329,7 +256,7 @@ static int enc_payload(struct snp_guest_dev *snp_dev, u64 seqno, int version, u8
 	dev_dbg(snp_dev->dev, "request [seqno %lld type %d version %d sz %d]\n",
 		hdr->msg_seqno, hdr->msg_type, hdr->msg_version, hdr->msg_sz);
 
-	return __enc_payload(snp_dev, req, payload, sz);
+	return __enc_payload(snp_dev->ctx, req, payload, sz);
 }
 
 static int __handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
@@ -472,7 +399,6 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
 
 static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg)
 {
-	struct snp_guest_crypto *crypto = snp_dev->crypto;
 	struct snp_report_resp *resp;
 	struct snp_report_req req;
 	int rc, resp_len;
@@ -490,7 +416,7 @@ static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_io
 	 * response payload. Make sure that it has enough space to cover the
 	 * authtag.
 	 */
-	resp_len = sizeof(resp->data) + crypto->a_len;
+	resp_len = sizeof(resp->data) + get_ctx_authsize(snp_dev);
 	resp = kzalloc(resp_len, GFP_KERNEL_ACCOUNT);
 	if (!resp)
 		return -ENOMEM;
@@ -511,7 +437,6 @@ static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_io
 
 static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg)
 {
-	struct snp_guest_crypto *crypto = snp_dev->crypto;
 	struct snp_derived_key_resp resp = {0};
 	struct snp_derived_key_req req;
 	int rc, resp_len;
@@ -528,7 +453,7 @@ static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_reque
 	 * response payload. Make sure that it has enough space to cover the
 	 * authtag.
 	 */
-	resp_len = sizeof(resp.data) + crypto->a_len;
+	resp_len = sizeof(resp.data) + get_ctx_authsize(snp_dev);
 	if (sizeof(buf) < resp_len)
 		return -ENOMEM;
 
@@ -552,7 +477,6 @@ static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_reque
 
 static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg)
 {
-	struct snp_guest_crypto *crypto = snp_dev->crypto;
 	struct snp_ext_report_req req;
 	struct snp_report_resp *resp;
 	int ret, npages = 0, resp_len;
@@ -590,7 +514,7 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
 	 * response payload. Make sure that it has enough space to cover the
 	 * authtag.
 	 */
-	resp_len = sizeof(resp->data) + crypto->a_len;
+	resp_len = sizeof(resp->data) + get_ctx_authsize(snp_dev);
 	resp = kzalloc(resp_len, GFP_KERNEL_ACCOUNT);
 	if (!resp)
 		return -ENOMEM;
@@ -802,8 +726,8 @@ static int __init sev_guest_probe(struct platform_device *pdev)
 		goto e_free_response;
 
 	ret = -EIO;
-	snp_dev->crypto = init_crypto(snp_dev, snp_dev->vmpck, VMPCK_KEY_LEN);
-	if (!snp_dev->crypto)
+	snp_dev->ctx = snp_init_crypto(snp_dev->vmpck, VMPCK_KEY_LEN);
+	if (!snp_dev->ctx)
 		goto e_free_cert_data;
 
 	misc = &snp_dev->misc;
@@ -818,11 +742,13 @@ static int __init sev_guest_probe(struct platform_device *pdev)
 
 	ret =  misc_register(misc);
 	if (ret)
-		goto e_free_cert_data;
+		goto e_free_ctx;
 
 	dev_info(dev, "Initialized SEV guest driver (using vmpck_id %d)\n", vmpck_id);
 	return 0;
 
+e_free_ctx:
+	kfree(snp_dev->ctx);
 e_free_cert_data:
 	free_shared_pages(snp_dev->certs_data, SEV_FW_BLOB_MAX_SIZE);
 e_free_response:
@@ -841,7 +767,7 @@ static int __exit sev_guest_remove(struct platform_device *pdev)
 	free_shared_pages(snp_dev->certs_data, SEV_FW_BLOB_MAX_SIZE);
 	free_shared_pages(snp_dev->response, sizeof(struct snp_guest_msg));
 	free_shared_pages(snp_dev->request, sizeof(struct snp_guest_msg));
-	deinit_crypto(snp_dev->crypto);
+	kfree(snp_dev->ctx);
 	misc_deregister(&snp_dev->misc);
 
 	return 0;
diff --git a/drivers/virt/coco/sev-guest/sev-guest.h b/drivers/virt/coco/sev-guest/sev-guest.h
index 21bda26fdb95..ceb798a404d6 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.h
+++ b/drivers/virt/coco/sev-guest/sev-guest.h
@@ -13,6 +13,9 @@
 #include <linux/types.h>
 
 #define MAX_AUTHTAG_LEN		32
+#define AUTHTAG_LEN		16
+#define AAD_LEN			48
+#define MSG_HDR_VER		1
 
 /* See SNP spec SNP_GUEST_REQUEST section for the structure */
 enum msg_type {
-- 
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF9BB77B0E9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 07:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233382AbjHNFyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 01:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233398AbjHNFxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 01:53:55 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5982C10DD
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 22:53:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E+mqVpaPVBypM1+UKPlscOJF6HXZOMCI039Y2pguqe3xEmg0e/hyQurw/gmwlUmFUh+8K0x4Tv34ChUCgLn4C1QyBpZdtPGTcaGgcFanpHicJwQSZlsYqGGH3DZN4tCPgCaok+9wLWI/5tnFqmw0X/sOQL3lxZUtpWPQ3jhxVRhreSnOK36ksxWcyenWbHOISzeBIU/J8t2HLZ7gs1TZJPF8uH20PGyrRJuyOutC5gneUM6vCgXvPgz/PFaPdQ7ZL5nJmMRwPT6KT577G4shpLErQCZrCAtTs8QQ6XYVX1pjhVB0baT1CiSwSA6PceZUOWyqs/H6KggkABpSpq1r9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IJjXt35ecBxjpO1/s1it/GkMzSEARj7vRaLIb2xhSd0=;
 b=S5uAquJpNWancq6ovWKMa/vH/pO2rZcZLMft2MOVzUChhkMQuTLmGKzpGZv8d6q//aJP5qOJzxYjEvTZ4WQ3VLhygX2UjWGrdkadygoVSVlDF5U0NqO5ce9aQQ+KJzxrnsgD+8o5AAc0ZrIQnJaY7cb08Bt67Sb6Xip9wzMIu1ILZpE5bxCSWovKCUreZIdq5cqLNCaSRRj+RfGNvyYg7MRsAcEHZ8M/r80R0uaTIwYRTqwXZ2FNk7bIfUfihHibokXKarL4Xc4lHIcQnOM8LPffePF92AQKMubr3gtVPDTrxNgK92xMAtD5LUQYvO7ukkiWKQJVXsEyJpiFjUU5zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJjXt35ecBxjpO1/s1it/GkMzSEARj7vRaLIb2xhSd0=;
 b=RJf6Hs8ga+uiCs6IfyvLIu+7Nsn1S9yhyd0fFKXDnyGxz1kc0RPHVt0zFz4GQGQUWZtgSpnS0bCCLHxDzeur8oDDoCBYUHhLzjjnjSV4X4oRcPrZ+NhF/ZGkC9Ai41OPeqoDW9nHgqwkj4O3U2+GkvzGIzuCI6SzSZBK4kBxQEk=
Received: from MW4PR03CA0246.namprd03.prod.outlook.com (2603:10b6:303:b4::11)
 by BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Mon, 14 Aug
 2023 05:53:50 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::41) by MW4PR03CA0246.outlook.office365.com
 (2603:10b6:303:b4::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Mon, 14 Aug 2023 05:53:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.13 via Frontend Transport; Mon, 14 Aug 2023 05:53:49 +0000
Received: from gomati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 14 Aug
 2023 00:53:06 -0500
From:   Nikunj A Dadhania <nikunj@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC:     <bp@alien8.de>, <thomas.lendacky@amd.com>,
        <dionnaglaze@google.com>, <pgonda@google.com>, <seanjc@google.com>,
        <pbonzini@redhat.com>, <nikunj@amd.com>
Subject: [PATCH v4 05/14] virt: sev-guest: Add vmpck_id to snp_guest_dev struct
Date:   Mon, 14 Aug 2023 11:22:13 +0530
Message-ID: <20230814055222.1056404-6-nikunj@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT037:EE_|BL0PR12MB4948:EE_
X-MS-Office365-Filtering-Correlation-Id: ec9a3c0e-d41f-445f-1c4e-08db9c8ad4e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: twxXqGS5ZJ22k8iSyuJZAsbn3GZzU6qL+m8A59hcDKt/WMrsCsGJTnnQiBvbKcoBYfUd2gaqMl5bH2s8ljpWmz+zDEIQP3saTuPP9p/ALkQp2Enznga9P+ZND+j75FIMSD/1Ev1iuVs2ajw+zyukbZMqheeIjljXTEPuyQiCPfF728LhAzJv+0Uu0dLbZAmeXW//tlA9wiJGi3BCwxAJbAj1p4PHftvFgiKJlO9rjcf98bTJJwiVWPfEYMPOwLrCGRPmU1PukrSkTBW7WrimUQxqE85a/nAX2gF8RCSFylX5CpACFiyV53qi3ICXq1zcWRR5o8JSbNrVi4zRFaUQScNP4IXLkjl/Ku1YBnK8CCRyBoiUsue9wxRq4Y3Xkh9BSH5fAj4ZIgxpTHV5HhltJQtx0W1QN43EjPbpBNMBDdD1vKp0Sz7NVoKiVmXFgGGAOvDRy4Vew9DCT31sg0aT8pPkoI4Int9vNfhfCUxX7AJiN8SqBlilCCdk78qzyRVMZVjeAHMuMxz61vaMqGJQfcdkPz+B1HOjKy+D2vwlbSzb2Q8HVcx/cdIOIXaAqDOvmMmPN+ZKc9zi3TOxSNuA6DXFoE64CYEH0Fvx1WlC8mkzLYPucf56gO62JdBauOMB6yPW2uaIVXCZHldrMgxktX9xqkHmNGkjII8SsxBGEP/4PMVdsKdqV4E2+8rfev7h/Bkn1yjlxwVwKR4/LE0elu+pu2NJ7t5sClg2SmCoXIfW2ELoaWhq1JYtDYabUIBRmDsJYfl7AHjmElNbBURRuw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(39850400004)(396003)(346002)(376002)(82310400008)(451199021)(186006)(1800799006)(40470700004)(36840700001)(46966006)(40480700001)(110136005)(54906003)(7696005)(6666004)(40460700003)(478600001)(81166007)(356005)(82740400003)(5660300002)(2906002)(36756003)(4326008)(70206006)(70586007)(41300700001)(8936002)(8676002)(316002)(47076005)(426003)(83380400001)(336012)(16526019)(2616005)(26005)(1076003)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 05:53:49.2215
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec9a3c0e-d41f-445f-1c4e-08db9c8ad4e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4948
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop vmpck and os_area_msg_seqno pointers so that secret page layout
does not need to be exposed to the sev-guest driver after the rework.
Instead, add helper APIs to access vmpck and os_area_msg_seqno when
needed.

Also, change function is_vmpck_empty() to snp_is_vmpck_empty() in
preparation for moving to sev.c.

Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
---
 drivers/virt/coco/sev-guest/sev-guest.c | 85 ++++++++++++-------------
 1 file changed, 42 insertions(+), 43 deletions(-)

diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 74b796409da9..0f519b855169 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -50,8 +50,7 @@ struct snp_guest_dev {
 
 	struct snp_secrets_page_layout *layout;
 	struct snp_req_data input;
-	u32 *os_area_msg_seqno;
-	u8 *vmpck;
+	unsigned int vmpck_id;
 };
 
 static u32 vmpck_id;
@@ -67,14 +66,22 @@ static inline unsigned int get_ctx_authsize(struct snp_guest_dev *snp_dev)
 	return 0;
 }
 
-static bool is_vmpck_empty(struct snp_guest_dev *snp_dev)
+static inline u8 *snp_get_vmpck(struct snp_guest_dev *snp_dev)
 {
-	char zero_key[VMPCK_KEY_LEN] = {0};
+	return snp_dev->layout->vmpck0 + snp_dev->vmpck_id * VMPCK_KEY_LEN;
+}
 
-	if (snp_dev->vmpck)
-		return !memcmp(snp_dev->vmpck, zero_key, VMPCK_KEY_LEN);
+static inline u32 *snp_get_os_area_msg_seqno(struct snp_guest_dev *snp_dev)
+{
+	return &snp_dev->layout->os_area.msg_seqno_0 + snp_dev->vmpck_id;
+}
 
-	return true;
+static bool snp_is_vmpck_empty(struct snp_guest_dev *snp_dev)
+{
+	char zero_key[VMPCK_KEY_LEN] = {0};
+	u8 *key = snp_get_vmpck(snp_dev);
+
+	return !memcmp(key, zero_key, VMPCK_KEY_LEN);
 }
 
 /*
@@ -96,20 +103,22 @@ static bool is_vmpck_empty(struct snp_guest_dev *snp_dev)
  */
 static void snp_disable_vmpck(struct snp_guest_dev *snp_dev)
 {
+	u8 *key = snp_get_vmpck(snp_dev);
+
 	dev_alert(snp_dev->dev, "Disabling vmpck_id %d to prevent IV reuse.\n",
-		  vmpck_id);
-	memzero_explicit(snp_dev->vmpck, VMPCK_KEY_LEN);
-	snp_dev->vmpck = NULL;
+		  snp_dev->vmpck_id);
+	memzero_explicit(key, VMPCK_KEY_LEN);
 }
 
 static inline u64 __snp_get_msg_seqno(struct snp_guest_dev *snp_dev)
 {
+	u32 *os_area_msg_seqno = snp_get_os_area_msg_seqno(snp_dev);
 	u64 count;
 
 	lockdep_assert_held(&snp_dev->cmd_mutex);
 
 	/* Read the current message sequence counter from secrets pages */
-	count = *snp_dev->os_area_msg_seqno;
+	count = *os_area_msg_seqno;
 
 	return count + 1;
 }
@@ -137,11 +146,13 @@ static u64 snp_get_msg_seqno(struct snp_guest_dev *snp_dev)
 
 static void snp_inc_msg_seqno(struct snp_guest_dev *snp_dev)
 {
+	u32 *os_area_msg_seqno = snp_get_os_area_msg_seqno(snp_dev);
+
 	/*
 	 * The counter is also incremented by the PSP, so increment it by 2
 	 * and save in secrets page.
 	 */
-	*snp_dev->os_area_msg_seqno += 2;
+	*os_area_msg_seqno += 2;
 }
 
 static inline struct snp_guest_dev *to_snp_dev(struct file *file)
@@ -151,15 +162,22 @@ static inline struct snp_guest_dev *to_snp_dev(struct file *file)
 	return container_of(dev, struct snp_guest_dev, misc);
 }
 
-static struct aesgcm_ctx *snp_init_crypto(u8 *key, size_t keylen)
+static struct aesgcm_ctx *snp_init_crypto(struct snp_guest_dev *snp_dev)
 {
 	struct aesgcm_ctx *ctx;
+	u8 *key;
+
+	if (snp_is_vmpck_empty(snp_dev)) {
+		pr_err("SNP: vmpck id %d is null\n", snp_dev->vmpck_id);
+		return NULL;
+	}
 
 	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL_ACCOUNT);
 	if (!ctx)
 		return NULL;
 
-	if (aesgcm_expandkey(ctx, key, keylen, AUTHTAG_LEN)) {
+	key = snp_get_vmpck(snp_dev);
+	if (aesgcm_expandkey(ctx, key, VMPCK_KEY_LEN, AUTHTAG_LEN)) {
 		pr_err("SNP: crypto init failed\n");
 		kfree(ctx);
 		return NULL;
@@ -592,7 +610,7 @@ static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long
 	mutex_lock(&snp_dev->cmd_mutex);
 
 	/* Check if the VMPCK is not empty */
-	if (is_vmpck_empty(snp_dev)) {
+	if (snp_is_vmpck_empty(snp_dev)) {
 		dev_err_ratelimited(snp_dev->dev, "VMPCK is disabled\n");
 		mutex_unlock(&snp_dev->cmd_mutex);
 		return -ENOTTY;
@@ -662,32 +680,14 @@ static const struct file_operations snp_guest_fops = {
 	.unlocked_ioctl = snp_guest_ioctl,
 };
 
-static u8 *get_vmpck(int id, struct snp_secrets_page_layout *layout, u32 **seqno)
+bool snp_assign_vmpck(struct snp_guest_dev *dev, int vmpck_id)
 {
-	u8 *key = NULL;
+	if (WARN_ON(vmpck_id > 3))
+		return false;
 
-	switch (id) {
-	case 0:
-		*seqno = &layout->os_area.msg_seqno_0;
-		key = layout->vmpck0;
-		break;
-	case 1:
-		*seqno = &layout->os_area.msg_seqno_1;
-		key = layout->vmpck1;
-		break;
-	case 2:
-		*seqno = &layout->os_area.msg_seqno_2;
-		key = layout->vmpck2;
-		break;
-	case 3:
-		*seqno = &layout->os_area.msg_seqno_3;
-		key = layout->vmpck3;
-		break;
-	default:
-		break;
-	}
+	dev->vmpck_id = vmpck_id;
 
-	return key;
+	return true;
 }
 
 static int __init sev_guest_probe(struct platform_device *pdev)
@@ -719,14 +719,14 @@ static int __init sev_guest_probe(struct platform_device *pdev)
 		goto e_unmap;
 
 	ret = -EINVAL;
-	snp_dev->vmpck = get_vmpck(vmpck_id, layout, &snp_dev->os_area_msg_seqno);
-	if (!snp_dev->vmpck) {
+	snp_dev->layout = layout;
+	if (!snp_assign_vmpck(snp_dev, vmpck_id)) {
 		dev_err(dev, "invalid vmpck id %d\n", vmpck_id);
 		goto e_unmap;
 	}
 
 	/* Verify that VMPCK is not zero. */
-	if (is_vmpck_empty(snp_dev)) {
+	if (snp_is_vmpck_empty(snp_dev)) {
 		dev_err(dev, "vmpck id %d is null\n", vmpck_id);
 		goto e_unmap;
 	}
@@ -734,7 +734,6 @@ static int __init sev_guest_probe(struct platform_device *pdev)
 	mutex_init(&snp_dev->cmd_mutex);
 	platform_set_drvdata(pdev, snp_dev);
 	snp_dev->dev = dev;
-	snp_dev->layout = layout;
 
 	/* Allocate the shared page used for the request and response message. */
 	snp_dev->request = alloc_shared_pages(dev, sizeof(struct snp_guest_msg));
@@ -750,7 +749,7 @@ static int __init sev_guest_probe(struct platform_device *pdev)
 		goto e_free_response;
 
 	ret = -EIO;
-	snp_dev->ctx = snp_init_crypto(snp_dev->vmpck, VMPCK_KEY_LEN);
+	snp_dev->ctx = snp_init_crypto(snp_dev);
 	if (!snp_dev->ctx)
 		goto e_free_cert_data;
 
-- 
2.34.1


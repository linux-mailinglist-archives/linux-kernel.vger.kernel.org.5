Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2EFB75DBDB
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 13:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjGVLUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 07:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjGVLUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 07:20:41 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907253A80
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 04:20:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GhSHWZnkR54nZ5PAHLGT6EN8xZrx0c3gQXC+hqdwDFeLKCi3EONHa23/Ni8BRcbzdmr0E6fN4oWLfIqQXIrH9AKIWSAL/7130Wizk78kBD+AHVcS+L8ympZlbsvqAKcBN2QPSRVcNLj6bwmraCN+BIYrBhpz9g3bosu8GfGpTGgclMbvhzzjHsT4i7d04c+U3NsiOk7bFtvSgBS2ldbGN244dur4G/YqMSg4uZsR7D66deb92ZyrscZ8SzmKyBzHeZTAH+uUtEJzXFWVoRQijZwmAzk0CNGlLYWVFN4d080/+Aeagz+qul9HdqQNUGo8eZ5Y4ivu+i4wFzPt4MJe3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fELucEziKjmc65JVfEfBO+V5Qa0SARR8xrFj5Kr0h/U=;
 b=GpCRb7HVePpHCq869qbTTMmcSP4ctN4d4qSIeRfKd1PZxTBr+gsYXU/Kf/glo3/g6Xu/uCiVoyuCH6LBfOHcgmUM+jUDztDfORcsmCeu5DwV1S99CvwvZQdYpgEHFNfXZOI+mOonWlg5FimXJMFw64GG5OuHmNYJDhO5OVX74I3XcQONYlbov5ksvpNblKLYPvFmo+kH/2t3h5LIbxaDEaR5hElOm4+h5To002/9gWLL/UVWfaEG8ND0e+XHVFhOEFDTmv8wsxlPxWnpZOrdoUQ+y28C5m0c8cjNDLJfh7CAFJ18W+GfUxJyNTygMvgsU7cXgPsxGamQshBjjpaP3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fELucEziKjmc65JVfEfBO+V5Qa0SARR8xrFj5Kr0h/U=;
 b=1InIZ7OETO8jZV9dGtF5Y0ui/T1iQOs4A3h4URyFwk4roR5z81FEcxb54VV0P+c4dLPZE+/rlAlslXWv1Q8+g5g5cUdk0QUNo2NUtn0gUGxNR/5+RPsASUTB3m8tAcif4B1QJtnPab2Lh/ZQdkEjWYMlMihRif03qPbAy+2ofw8=
Received: from DM6PR07CA0092.namprd07.prod.outlook.com (2603:10b6:5:337::25)
 by DM6PR12MB4893.namprd12.prod.outlook.com (2603:10b6:5:1bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.29; Sat, 22 Jul
 2023 11:20:32 +0000
Received: from DM6NAM11FT083.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:337::4) by DM6PR07CA0092.outlook.office365.com
 (2603:10b6:5:337::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.30 via Frontend
 Transport; Sat, 22 Jul 2023 11:20:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT083.mail.protection.outlook.com (10.13.173.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6609.28 via Frontend Transport; Sat, 22 Jul 2023 11:20:31 +0000
Received: from gomati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 22 Jul
 2023 06:20:26 -0500
From:   Nikunj A Dadhania <nikunj@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC:     <bp@alien8.de>, <thomas.lendacky@amd.com>,
        <dionnaglaze@google.com>, <pgonda@google.com>, <seanjc@google.com>,
        <pbonzini@redhat.com>, <nikunj@amd.com>
Subject: [PATCH v3 05/14] virt: sev-guest: Add vmpck_id to snp_guest_dev struct
Date:   Sat, 22 Jul 2023 16:49:00 +0530
Message-ID: <20230722111909.15166-6-nikunj@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT083:EE_|DM6PR12MB4893:EE_
X-MS-Office365-Filtering-Correlation-Id: 18361cc6-99d2-4dda-117c-08db8aa5a973
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0qRfJUL/IthYdH+pCwKU812SjAjEMEMWiGWwZu8cKDA07goDWOflsh1k3BJKdJFavLdSEIOH9p8m3fITyXDSiNicPSCVdTH3mOAievVcs+bRr436NAmBm1fuzNKsrWaog3DUPLtpKOChxgGbCIN35Kcyp+J5YOcvaBNeXmn94FM0zMZtjCfnLctykt1hs3bAL4oRLQrUWr6e5G6cuOmFSImKyB6nlJT4uLXbY9WJvYQZPdG1E+Qq2Oo9v7uswHX7/REcAkuNzx0VexN1ZMx/PEs96ykWKi3BWyLsBcNWX68GPwkjGLFCrkghxFLKfU/sYlY2ipMxL1LPxuJoOjgv4vnqEUbV9boJfKz0D/2RrwvFS3FO3h46ZuhvIPKNl1nGdNiA5a4aHsSJp2AmsFtS/fRCE5/YeRNYA11ijfFTAJapMSipIAqCKB3ma6cxzQMKApPDqf11sNsu4Q3l9WBngwh0A2c9VAqZAk7i19ebKvWD4QAbG4mga4rotJqwIKKFTWGO+aUe5+sh89eaEQQBp0jYflFH9rcRwk/Pmg/xLdUaTlmHiUwzT3K7i1Ob175t02/mZuCOuT/U92uEtnEgDOnYYScGEAEFKcZAQePdxTWfpcQKsYMF/5NQdDpRNoUro14eAud86h6XiaUw3WQNZTbYXTtddMLkQt04MjFuS+XAZAgqLWnppR2SIqNEc+umpeKX2+UW7i8UpOFkMjQO58WWZaJbk39NUJVRSg6GWxnNcLs4pGlc50WeBXzG/1LRzNFhWNcxpmA40JSlo58/Ew==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(346002)(39860400002)(451199021)(82310400008)(40470700004)(46966006)(36840700001)(2906002)(40480700001)(81166007)(356005)(82740400003)(83380400001)(426003)(47076005)(16526019)(186003)(26005)(336012)(2616005)(36860700001)(1076003)(40460700003)(5660300002)(8936002)(478600001)(8676002)(36756003)(6666004)(7696005)(4326008)(70206006)(70586007)(41300700001)(316002)(110136005)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2023 11:20:31.9403
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18361cc6-99d2-4dda-117c-08db8aa5a973
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT083.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4893
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop vmpck and os_area_msg_seqno pointers so that secret page layout
does not need to be exposed to the sev-guest driver after the rework.
Instead, add helper APIs to access vmpck and os_area_msg_seqno when
needed.

Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
---
 drivers/virt/coco/sev-guest/sev-guest.c | 84 +++++++++++++------------
 1 file changed, 43 insertions(+), 41 deletions(-)

diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index d4241048b397..8ad43e007d3b 100644
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
@@ -67,12 +66,23 @@ static inline unsigned int get_ctx_authsize(struct snp_guest_dev *snp_dev)
 	return 0;
 }
 
-static bool is_vmpck_empty(struct snp_guest_dev *snp_dev)
+static inline u8 *snp_get_vmpck(struct snp_guest_dev *snp_dev)
+{
+	return snp_dev->layout->vmpck0 + snp_dev->vmpck_id * VMPCK_KEY_LEN;
+}
+
+static inline u32 *snp_get_os_area_msg_seqno(struct snp_guest_dev *snp_dev)
+{
+	return &snp_dev->layout->os_area.msg_seqno_0 + snp_dev->vmpck_id;
+}
+
+static bool snp_is_vmpck_empty(struct snp_guest_dev *snp_dev)
 {
 	char zero_key[VMPCK_KEY_LEN] = {0};
+	u8 *key = snp_get_vmpck(snp_dev);
 
-	if (snp_dev->vmpck)
-		return !memcmp(snp_dev->vmpck, zero_key, VMPCK_KEY_LEN);
+	if (key)
+		return !memcmp(key, zero_key, VMPCK_KEY_LEN);
 
 	return true;
 }
@@ -96,20 +106,22 @@ static bool is_vmpck_empty(struct snp_guest_dev *snp_dev)
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
@@ -137,11 +149,13 @@ static u64 snp_get_msg_seqno(struct snp_guest_dev *snp_dev)
 
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
@@ -151,15 +165,22 @@ static inline struct snp_guest_dev *to_snp_dev(struct file *file)
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
@@ -606,7 +627,7 @@ static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long
 	mutex_lock(&snp_dev->cmd_mutex);
 
 	/* Check if the VMPCK is not empty */
-	if (is_vmpck_empty(snp_dev)) {
+	if (snp_is_vmpck_empty(snp_dev)) {
 		dev_err_ratelimited(snp_dev->dev, "VMPCK is disabled\n");
 		mutex_unlock(&snp_dev->cmd_mutex);
 		return -ENOTTY;
@@ -676,32 +697,14 @@ static const struct file_operations snp_guest_fops = {
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
@@ -733,14 +736,14 @@ static int __init sev_guest_probe(struct platform_device *pdev)
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
@@ -748,7 +751,6 @@ static int __init sev_guest_probe(struct platform_device *pdev)
 	mutex_init(&snp_dev->cmd_mutex);
 	platform_set_drvdata(pdev, snp_dev);
 	snp_dev->dev = dev;
-	snp_dev->layout = layout;
 
 	/* Allocate the shared page used for the request and response message. */
 	snp_dev->request = alloc_shared_pages(dev, sizeof(struct snp_guest_msg));
@@ -764,7 +766,7 @@ static int __init sev_guest_probe(struct platform_device *pdev)
 		goto e_free_response;
 
 	ret = -EIO;
-	snp_dev->ctx = snp_init_crypto(snp_dev->vmpck, VMPCK_KEY_LEN);
+	snp_dev->ctx = snp_init_crypto(snp_dev);
 	if (!snp_dev->ctx)
 		goto e_free_cert_data;
 
-- 
2.34.1


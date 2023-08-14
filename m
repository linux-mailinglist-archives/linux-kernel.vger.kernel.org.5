Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 420B477B0E2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 07:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbjHNFxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 01:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbjHNFw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 01:52:58 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36CA5E6D
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 22:52:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ezIZ/2O1SdIaXwLS/hdRtCQrlnIpJbjai2A1+zGKyaarQmDNL30FzCUUGRKhum4T1htuc86VqRwZlfk1qtZyf1V1CljsFjwPoOczezjAuWnMpkm1GXvsztEM7L7j/1SNakgCSjGJG+OUj0VUyGyBOQKOam53+jHUMnUIT5qXSU6z1V5/kUDdxo1nNx4UwXVqUxSssvlJ3P8M1KVpscwYLmuvnbceaUg/Gh9osSGgiWOZH+CBUZSkqMPnmh4ENPm4yWUSVaouPRHxCLoqa961Z6nSOetAlR1AQUg/HppE3aEYQfXR5EGFXTqHbULG9OHL60aCYgtrkGtSV0WI32/3mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FuBmIhqf5s50MDqpiNEq7ipa9JYgkOBMMnMLOaInExY=;
 b=WvA+QqgVHRx1GkOsNqpglgONbpgMYfOBBHAZz36bVqbBAcLDW3/GcyTHxPy0JiDbbhGsOvYjTbY9pCQP94An+ivyICzULj3Qc1GrOqF/jL1m9+KXsZnQGT0csq4gNnUFdg+rGCF4A1rYmj4civVl+Rfe07Wulfp5RtKogXxfBFf4aooa1PW4VQrZtBlzabe1QuNZEM4An1XUXmWGMfy9RmOyAt8wcMqP1xTdyWUNztR8UGQ5i8QUMuB5I79PwQppVKwRJ5NXeZbn7OZs72symurEcjs1YJ+aK57HdJyE3pEzZIRmwpNK+qw1XEy4kK/mbWzvkcL98NgxrZHAKSO0XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FuBmIhqf5s50MDqpiNEq7ipa9JYgkOBMMnMLOaInExY=;
 b=qs7R6/8+bGm/Odu9jehF0nnfT4waZukTN1T+Rhz4lS6c2Yy8FrLAhQJ+NFfTBM3BufOobn/R5xkH2WJpGaaUagudfbvnjTT2pp5AuCwTU9Xh4muzUGh+2uI92JnTKg9Yv/N9yK/vJaH4bR6FTBwvErPxv4gBK9iG1HWEUfy8Vu4=
Received: from CY5P221CA0063.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:4::38) by
 DS7PR12MB5862.namprd12.prod.outlook.com (2603:10b6:8:79::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.24; Mon, 14 Aug 2023 05:52:54 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:930:4:cafe::ab) by CY5P221CA0063.outlook.office365.com
 (2603:10b6:930:4::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Mon, 14 Aug 2023 05:52:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.144) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.12 via Frontend Transport; Mon, 14 Aug 2023 05:52:54 +0000
Received: from gomati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 14 Aug
 2023 00:52:51 -0500
From:   Nikunj A Dadhania <nikunj@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC:     <bp@alien8.de>, <thomas.lendacky@amd.com>,
        <dionnaglaze@google.com>, <pgonda@google.com>, <seanjc@google.com>,
        <pbonzini@redhat.com>, <nikunj@amd.com>
Subject: [PATCH v4 02/14] virt: sev-guest: Move mutex to SNP guest device structure
Date:   Mon, 14 Aug 2023 11:22:10 +0530
Message-ID: <20230814055222.1056404-3-nikunj@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|DS7PR12MB5862:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c2c5eb4-fd09-4cdd-0e10-08db9c8ab45b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: elPq0jRWsH1rPX2//46keVE8Dxe9pQpW2q9A0Qe0XvulXVACH80rmyRYqpjbCaeraGix4719LaBTOQ4SiTFfp+z9vyQ7o2lIGiTGyCY4PEkqgTNmAuD8QKL4m6yerPHM56Yzluzgiqy5OkW8mzKIB0wX5VOtXMXc0XYNAJzplN7v/OEubjBR43q4aJkjjyEO4s/omhJDZHinz9rI6pvGvQpvaJora68djyg6VLcV4eFIVsFnAf/hRIfBIYkRarCcK99ZIaT/uQdIcVHdFAj+nHj9airVAcJnB5lt/NjIlY6jmcUIgNLcTOUpd3SrI1+r8jBP4LlwiKzDdqURiiWDnKNKD9PNs2hhY+4eP4DemORpqeoXPLHAXlBBaPfhkwP89XkH90t1T6o46znSCsoX/HER3l/leaT255LNA9asHiZ4HTptDZ7H4hW5vPeMq4iSbmZB1V9dlJ/Oon17R5mY4juxpunO6LRxGk3YMmFepnLvwy1TtfagTolBSJDJZKpvjV3Wuwmykp6Gf2r1BSHxFjdhWRdUB3u+h4yPfAAVNyLgxdy1zL58hOX5LPzT6CBSMMV8KGSdbT/QQIYMwO1tFJr2Xmv4wte3vbZvNZRTgp8Y2TPLCD8Duwym0zl0gDUv6ln/L8eYhcb5QuR6eIRBAjf11hWuS4F6k2asoZlzJBsbwsxtEpTUNsT6B9LQflKdQ9u451gidy8+8xIMmpsSWvEXM7+IgoRySKqaQwKoTIanHF6GXfMyc1O6wZ89HuPM7+sbLcnSgZfhq4xP9Cyfvw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(396003)(376002)(82310400008)(451199021)(1800799006)(186006)(46966006)(36840700001)(40470700004)(6666004)(7696005)(40460700003)(356005)(36756003)(82740400003)(81166007)(47076005)(40480700001)(36860700001)(336012)(426003)(83380400001)(2616005)(26005)(16526019)(2906002)(478600001)(5660300002)(1076003)(110136005)(70586007)(70206006)(8936002)(8676002)(4326008)(54906003)(41300700001)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 05:52:54.7093
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c2c5eb4-fd09-4cdd-0e10-08db9c8ab45b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5862
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for providing a new API to the sev-guest driver for sending
an SNP guest message, move the SNP command mutex to the snp_guest_dev
structure.

Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 drivers/virt/coco/sev-guest/sev-guest.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 520e2b6613a7..8ba624088d73 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -35,6 +35,9 @@ struct snp_guest_dev {
 	struct device *dev;
 	struct miscdevice misc;
 
+	/* Mutex to serialize the shared buffer access and command handling. */
+	struct mutex cmd_mutex;
+
 	void *certs_data;
 	struct aesgcm_ctx *ctx;
 	/* request and response are in unencrypted memory */
@@ -56,9 +59,6 @@ static u32 vmpck_id;
 module_param(vmpck_id, uint, 0444);
 MODULE_PARM_DESC(vmpck_id, "The VMPCK ID to use when communicating with the PSP.");
 
-/* Mutex to serialize the shared buffer access and command handling. */
-static DEFINE_MUTEX(snp_cmd_mutex);
-
 static inline unsigned int get_ctx_authsize(struct snp_guest_dev *snp_dev)
 {
 	if (snp_dev && snp_dev->ctx)
@@ -107,7 +107,7 @@ static inline u64 __snp_get_msg_seqno(struct snp_guest_dev *snp_dev)
 {
 	u64 count;
 
-	lockdep_assert_held(&snp_cmd_mutex);
+	lockdep_assert_held(&snp_dev->cmd_mutex);
 
 	/* Read the current message sequence counter from secrets pages */
 	count = *snp_dev->os_area_msg_seqno;
@@ -403,7 +403,7 @@ static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_io
 	struct snp_report_req req;
 	int rc, resp_len;
 
-	lockdep_assert_held(&snp_cmd_mutex);
+	lockdep_assert_held(&snp_dev->cmd_mutex);
 
 	if (!arg->req_data || !arg->resp_data)
 		return -EINVAL;
@@ -443,7 +443,7 @@ static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_reque
 	/* Response data is 64 bytes and max authsize for GCM is 16 bytes. */
 	u8 buf[64 + 16];
 
-	lockdep_assert_held(&snp_cmd_mutex);
+	lockdep_assert_held(&snp_dev->cmd_mutex);
 
 	if (!arg->req_data || !arg->resp_data)
 		return -EINVAL;
@@ -481,7 +481,7 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
 	struct snp_report_resp *resp;
 	int ret, npages = 0, resp_len;
 
-	lockdep_assert_held(&snp_cmd_mutex);
+	lockdep_assert_held(&snp_dev->cmd_mutex);
 
 	if (!arg->req_data || !arg->resp_data)
 		return -EINVAL;
@@ -566,12 +566,12 @@ static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long
 	if (!input.msg_version)
 		return -EINVAL;
 
-	mutex_lock(&snp_cmd_mutex);
+	mutex_lock(&snp_dev->cmd_mutex);
 
 	/* Check if the VMPCK is not empty */
 	if (is_vmpck_empty(snp_dev)) {
 		dev_err_ratelimited(snp_dev->dev, "VMPCK is disabled\n");
-		mutex_unlock(&snp_cmd_mutex);
+		mutex_unlock(&snp_dev->cmd_mutex);
 		return -ENOTTY;
 	}
 
@@ -589,7 +589,7 @@ static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long
 		break;
 	}
 
-	mutex_unlock(&snp_cmd_mutex);
+	mutex_unlock(&snp_dev->cmd_mutex);
 
 	if (input.exitinfo2 && copy_to_user(argp, &input, sizeof(input)))
 		return -EFAULT;
@@ -708,6 +708,7 @@ static int __init sev_guest_probe(struct platform_device *pdev)
 		goto e_unmap;
 	}
 
+	mutex_init(&snp_dev->cmd_mutex);
 	platform_set_drvdata(pdev, snp_dev);
 	snp_dev->dev = dev;
 	snp_dev->layout = layout;
-- 
2.34.1


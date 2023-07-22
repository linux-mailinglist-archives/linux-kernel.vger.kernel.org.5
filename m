Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4FC75DBE3
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 13:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbjGVLXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 07:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjGVLXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 07:23:50 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2060f.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e83::60f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047CC3C3E
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 04:23:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P6gR72N82FUDXActhsdTo5awGcTwhUpzbW8uf4BZQiYNz6IuM51hQwuHWuqifx3QdRl5o9lsQa3JPjhxeRy7nIQDQcXEict0eP1KcxmnFGxQfAzcHtClchpyrljXe5y159uJEcSF4EP+Ck4eUJ7zM+T4AlrurGrPZwz7ztsRL+BeJThmS3CiYaUhmFRdMt9flzJxb4sMqKKpaoiVbhK8NnBoV21wJ6kjZl1oc+TwPprVIuYQ62MR6RI6Upge2KCrEbMtjBDLJNdcXGq2FEunrKzMf/W0qFA6lyDm6FQ5nXe2lG4DynpLo0n32nqxDzPVdArT4HoVKWa4W0j2jwscOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5NiJq6xAI78ib3LcOR1IpI4AF1pAQl6aTlJruCyHLaI=;
 b=R3R/qH41lUYf0kJJDNPsLlnFRNvDGdFZKgbboT+B8NUM8U18ESTo4ClslUCwhbI5EhJQQhuB/CIVk2QDi+EIUnCtKdtUa1dvE+Rs0ghb1I4i9jRv+4dfFOCHeRkFJNmWwo+2PqmpPSksQcQSOkZVKJZBqT17G9Nx7sLTTX3d19xb5ETfpVlaiKO8JExyoDtWdHab05HYv7G/iYPj+gZFFpb882r2sWDlSCD8PrHiLH3Y6+auLwGrlYYJXNiG+zDBfEaXkuDLx/u/dp/UIMUwHrsIWghkI7KK+n+aducdEnLJBCqQ1KvYuL3AOxQyNol5pTkQUW0BW3+YbnKz+SNqIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5NiJq6xAI78ib3LcOR1IpI4AF1pAQl6aTlJruCyHLaI=;
 b=nJqDKg39F9iuPF1VpzkUUuDrm+RZNtVcG9xtnRezr48QIt58lX/Eg0sqOvelwl3L5TLPIHCtmdQWAIJj3eVULToY/A5Di69QRLlgKC9Eyy6LBDq1WZqc8q/3IeJgsFr0mZwKyY5dCaWahkciDDFhaceLb6JNrN45+qJc2BfgvTk=
Received: from DS7PR03CA0029.namprd03.prod.outlook.com (2603:10b6:5:3b8::34)
 by CH0PR12MB5283.namprd12.prod.outlook.com (2603:10b6:610:d6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.29; Sat, 22 Jul
 2023 11:21:00 +0000
Received: from DM6NAM11FT115.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b8:cafe::22) by DS7PR03CA0029.outlook.office365.com
 (2603:10b6:5:3b8::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28 via Frontend
 Transport; Sat, 22 Jul 2023 11:21:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT115.mail.protection.outlook.com (10.13.173.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.22 via Frontend Transport; Sat, 22 Jul 2023 11:21:00 +0000
Received: from gomati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 22 Jul
 2023 06:20:57 -0500
From:   Nikunj A Dadhania <nikunj@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC:     <bp@alien8.de>, <thomas.lendacky@amd.com>,
        <dionnaglaze@google.com>, <pgonda@google.com>, <seanjc@google.com>,
        <pbonzini@redhat.com>, <nikunj@amd.com>
Subject: [PATCH v3 14/14] x86/sev: Enable Secure TSC for SNP guests
Date:   Sat, 22 Jul 2023 16:49:09 +0530
Message-ID: <20230722111909.15166-15-nikunj@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT115:EE_|CH0PR12MB5283:EE_
X-MS-Office365-Filtering-Correlation-Id: 31318545-2a7c-47a8-0907-08db8aa5ba90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ANsmhHXYNyfl9rr49DxDA+1IvVZ9SV3m7tJ1R5U4oLJiBFQ2ROAgxrrXM2NXDKVsmcPu3uKspdQn6Os+gOtUe64oZayeCtuCJyN1la7xWhoCqnHQTvu6fws3kv5Pt5Mj3TTEwuw2pCTv1CfFg1lmYRfrLM66g0pa4N6q4Wcoyez6+SSraG5iykGBk6W/LmoahcWN1Nd+4dW8D3k8VzlffeULJxwdCV9o3Bl9Lb40n63MygxN73fLrcvdGsSt8z9HK1PHwfpTrkvAFNV0GhJihQl/IF5JAyqqDS1KwlU7MgdiBW0q/NT3LiPndoKfNMGUuoDEu5XvyhSefJ5RAlLEeDfWU3C44nIvmQbn0H23aMFQDPJq4uZgQ9LA+BM0UzgfAVXDclISxgq43nWQqOUd64gM54UdLx1j05qX0UnigVS8Ui7LHjQVOqUGotV/whcnVCEM5vU2iCPVnOGE4bE6kZ7ipPZQtGe8EhH59lgWfRcb+1aL8M5PJkJnGiWGMXEBZuG9ItWI9FY1cRh+XfN0HXtqmphzrBkS1JLKYpJW2VM2631mG1E+dZg+4UApuA6Yz2I/gKJTdihRPPvaauYqCWKR6S/m3gzDJDE9shzZTt0lCqCBsCIFp+YIy45KO6dpkd9v1l0wz6upoQGEhJFjRAS3vBNMrIdMp0MiqaoWJIfpvpKu/G8/KOdIAI3tigM3qHYOSCkArW2LKRA8TfPXOkmtg7zz2t/ng6lDAmctNWaaCuwd/VcAceV27xfNJ9SfnNIGEW2q2WC90geE+c1nyQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(136003)(451199021)(82310400008)(40470700004)(36840700001)(46966006)(40460700003)(356005)(40480700001)(81166007)(36860700001)(36756003)(2616005)(426003)(47076005)(83380400001)(16526019)(8676002)(8936002)(5660300002)(110136005)(54906003)(478600001)(4326008)(316002)(70206006)(70586007)(41300700001)(26005)(186003)(336012)(1076003)(7696005)(6666004)(2906002)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2023 11:21:00.6514
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31318545-2a7c-47a8-0907-08db8aa5ba90
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT115.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5283
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all the required plumbing is done for enabling SNP
Secure TSC feature, add Secure TSC to snp features present list.

The CC_ATTR_GUEST_SECURE_TSC can be used by the guest to query whether
the SNP guest has Secure TSC feature active.

Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
---
 arch/x86/boot/compressed/sev.c |  2 +-
 arch/x86/mm/mem_encrypt.c      | 10 ++++++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 014b89c89088..11f951caf2de 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -313,7 +313,7 @@ static void enforce_vmpl0(void)
  * by the guest kernel. As and when a new feature is implemented in the
  * guest kernel, a corresponding bit should be added to the mask.
  */
-#define SNP_FEATURES_PRESENT (0)
+#define SNP_FEATURES_PRESENT (MSR_AMD64_SNP_SECURE_TSC)
 
 void snp_check_features(void)
 {
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 01abecc9a774..26608b9f2ca7 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -69,8 +69,14 @@ static void print_mem_encrypt_feature_info(void)
 		pr_cont(" SEV-ES");
 
 	/* Secure Nested Paging */
-	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
-		pr_cont(" SEV-SNP");
+	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP)) {
+		pr_cont(" SEV-SNP\n");
+		pr_cont("SNP Features active: ");
+
+		/* SNP Secure TSC */
+		if (cc_platform_has(CC_ATTR_GUEST_SECURE_TSC))
+			pr_cont(" SECURE-TSC");
+	}
 
 	pr_cont("\n");
 }
-- 
2.34.1


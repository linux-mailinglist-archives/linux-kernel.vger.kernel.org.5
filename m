Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089F877B0F3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 07:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233454AbjHNFzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 01:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233385AbjHNFyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 01:54:38 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2050.outbound.protection.outlook.com [40.107.101.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFD11708
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 22:54:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DZgfL1W8eg7GX3gclL/alI8SYuYOD8Hu3fO1iKbyHWPCpIhZGetc5aMUlxvX1cjwzBxwhR1RwjzoCLNRQXTKlwncRjkwZAKuBmF8o6iNGdq67gO9GbJYOwac9or+ANYF0SPgTpXbnylDrkf9jMn0pORpOEkKh/nj1adH9u3v7y5nNbd6XjkF/qC3IgPBmcmPHmr8AmYsC48qF4PplYf2rQ24k+cAqGx6tw2KuT74jdpyTQbl8Zezr8iJY1HJXCqMY/xPooDug9f+mS+CsBh6GIiG5Dum64S6t7ZFEiHLwIIXs5AdQjOYl63AMvWk64+L3LUgQDeUQPmdj3q0zG9gOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5NiJq6xAI78ib3LcOR1IpI4AF1pAQl6aTlJruCyHLaI=;
 b=LXE7j7c1geuKwuW7kbuT1OEnzHO++LAfLwwN6sVt1ClcISjNWIxF6aEeA4GkzzWDp9suM1lBcCx2cDJe4lnCUIppxqUneqnYpOHTRcGn+X/oLWzxuH2WrRDA9KmgN9MzujNjhbk6t+GAQdfJpA3Yz4cd5yPI565jMDmhS6kJtdu7eOE8E6DG0SenfE8DGpF6z9CEh2C+FThWPwiBfEc2LmO0ddGtM6mcgYNv3/R0AFgtazrttO4gfXQy+vPW4FOyumDBJ/Lti1oPUQkYkPKBQpys3dQok64OvtedteFzo4pWHzIPCzBdW9BUzqCjdQddxQ+vaMZgbBq0g7gNHau5Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5NiJq6xAI78ib3LcOR1IpI4AF1pAQl6aTlJruCyHLaI=;
 b=Oshk3E8VcjWPajyrwH6kvrZRqIp646Y5ikt9XptHi9Yv52dwXKvSHiUK/FbyYUouY9mWU1jLulhLA3+mf03eCoVLrsmgNP72Rv1Sie8xWlDsTuu2C1quDas8Bjt8fDyDJ8yXgAoK8VM2pqXjKZY9Uiu/25x2+9mhuDCcNhPujec=
Received: from MW4P221CA0011.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::16)
 by MN2PR12MB4064.namprd12.prod.outlook.com (2603:10b6:208:1d3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 05:54:20 +0000
Received: from CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::42) by MW4P221CA0011.outlook.office365.com
 (2603:10b6:303:8b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Mon, 14 Aug 2023 05:54:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT020.mail.protection.outlook.com (10.13.174.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Mon, 14 Aug 2023 05:54:19 +0000
Received: from gomati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 14 Aug
 2023 00:54:14 -0500
From:   Nikunj A Dadhania <nikunj@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC:     <bp@alien8.de>, <thomas.lendacky@amd.com>,
        <dionnaglaze@google.com>, <pgonda@google.com>, <seanjc@google.com>,
        <pbonzini@redhat.com>, <nikunj@amd.com>
Subject: [PATCH v4 14/14] x86/sev: Enable Secure TSC for SNP guests
Date:   Mon, 14 Aug 2023 11:22:22 +0530
Message-ID: <20230814055222.1056404-15-nikunj@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT020:EE_|MN2PR12MB4064:EE_
X-MS-Office365-Filtering-Correlation-Id: 70f688da-e59d-46ec-1b95-08db9c8ae707
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XlbTlMu40GdJN464Pf0MJ8EXzQdKtisoDopaxdOGDdcctjCtdd7Ol/8F3FtAtKDFJTQer7NSm0vKMWScq+UScyjvyIYnb73HwY4GAD8+sZ4jEkiOwJwazhgGVDvTkx3buUWAmdFMMBIWho08mZO5E+TdHhf4JPS+i5E0JV5fTgnzjAnnektFu0E/XBgZardooHbuWyqwAONrZLam23fQA6myKZ+PIlLnV05+I0FnUwptQlcyTYKb801eBuEnIClVsZcsRdsn6fM9Z5u6VUl1+A4iSUxTh35KMrwr53qUj5qg80CWeUzT69Xje4LnM594AG9wIjWEJiqC9OJ2LB9pUh7yPOT0zFfQ2gSumrL21NEDVFs8rkH+b4Ovyh7cO3GX9DKWevLj+obINh20LnZgA/7d04dFZThNEiN8dr0EM6LS7hxLgJexd9JMmlOsptqBJodFVcjYAEqfPIgD46obzSrEru35rx459rCR6ReNJHKSV4p9VqBjda+8Yx8SAbA+/F42anYJApZwdKil++YKGkMERv0AT1QmyARG2XcrDEn2S19jY8pPt1dftB+rzKHbHO1T1XsqM2xjYZ4RuVduK8Pbzg0oW+YqYa3Vf1SSqZYlhgHhud6RcH9ePJIea1hMQKl3m95olelpGxoF8Wd4/GwGX3EHyKBEB4iBQvevEkI8Z1QXW0UEa/s2beAEW4CDpt1Ym6OIUTp++Nc7GBAshJ3BDI1H8EYeDfBnMkYoYP4YkuPy9R8xqqyxHVdCAJWCEcLhq3ALUFCCby167nTFUQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(346002)(396003)(451199021)(82310400008)(186006)(1800799006)(36840700001)(40470700004)(46966006)(40460700003)(6666004)(110136005)(70206006)(70586007)(7696005)(478600001)(47076005)(83380400001)(36860700001)(16526019)(36756003)(2906002)(40480700001)(426003)(1076003)(26005)(336012)(2616005)(82740400003)(81166007)(356005)(316002)(8676002)(54906003)(4326008)(5660300002)(8936002)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 05:54:19.7073
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70f688da-e59d-46ec-1b95-08db9c8ae707
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4064
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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


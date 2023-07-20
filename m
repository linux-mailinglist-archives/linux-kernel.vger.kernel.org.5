Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2920D75B8BF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 22:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjGTU2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 16:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjGTU2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 16:28:32 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F78272A;
        Thu, 20 Jul 2023 13:28:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SFeoc/GMaT4npENXHiKaPebbYtMwJcwdzc+zILgF8HXRe3AKou/+ECn6D/hCtuqhVkOAnWX7SRnlmFr7zZ8MnvizuF5CyKS/q6FCq3R4+gKCpG1mAnMdih2frP94Nj8P8BDmu3rC6YC5NUvtX95KcAqqzAli2h3xblQUx+KraK3veXY+ONlX7VgcKsK2IQoIUe6NsKsP0Yhcu7Tx4AmLeKWdBJSf5STTCqsYpzS5WA1yyJku4j6lsFb0QYyfFOVNdrwePdO82tjHd8/6oKEybsDQJrLSOVb/Yx9YuHkN+cKoJUI8p0RnO9yYP5UcVandq7RTBpvkKiFHv9vgw446Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OoM/PHiNwVCxv2JrvAPeXjDXTa6wF1QZnD03AwUPfRk=;
 b=HfS905KRbJTtOC4vSt1Eue1ltMUS6fHtywYAieQgQqW0S9HIj4kGf7Xn9K3DL+n5F6hyOSpWRJwoxLHgwe1R+X+quxLj/o5cRUGRa8/BbgcYCZG1ugXbHfuCZFPrFSRMn2BEVfNPCheh/zGlsTQSgy9PvJNsuVRDgQ8+dzspf1UDFzgqUo+J1C58/XgI7vzf+Q8NT7PLm/xd3Gq7ILLRxrcNNAp3TA/CXNL/oXatTvj5l1lqkNRcdiYsezFyUl/k/l/lXZVvGVolDlHsThp2vsmj5gvwqpOlz5awvtyc5ZATFsjh8Rwm73BvEb7EPrC+75HemQ4P3E0gh0pXRedCRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OoM/PHiNwVCxv2JrvAPeXjDXTa6wF1QZnD03AwUPfRk=;
 b=Q5LLVxGuPLe9eCMB5jDiRvYhEh1dvjm84gPyes/O0mGmM78o1FBLYN9lz2XX55H/bIKyHpw8nBX9ThdSoh4os92aSfvHxZBbq7Npp9sMcz5eBoHCK8QIkAgZnv579u/26oa1cG02AUgCtNHgtEW5sj3/jkSUraAIYp9rukWgCVs=
Received: from BN9PR03CA0356.namprd03.prod.outlook.com (2603:10b6:408:f6::31)
 by DM4PR12MB7718.namprd12.prod.outlook.com (2603:10b6:8:102::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Thu, 20 Jul
 2023 20:28:27 +0000
Received: from BN8NAM11FT093.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f6:cafe::ce) by BN9PR03CA0356.outlook.office365.com
 (2603:10b6:408:f6::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.25 via Frontend
 Transport; Thu, 20 Jul 2023 20:28:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT093.mail.protection.outlook.com (10.13.177.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6609.28 via Frontend Transport; Thu, 20 Jul 2023 20:28:26 +0000
Received: from jallen-jump-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 20 Jul
 2023 15:28:25 -0500
From:   John Allen <john.allen@amd.com>
To:     <bp@alien8.de>, <linux-kernel@vger.kernel.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <x86@kernel.org>, John Allen <john.allen@amd.com>,
        <stable@vger.kernel.org>
Subject: [PATCH] x86/microcode/AMD: Increase microcode PATCH_MAX_SIZE
Date:   Thu, 20 Jul 2023 20:28:13 +0000
Message-ID: <20230720202813.3269888-1-john.allen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT093:EE_|DM4PR12MB7718:EE_
X-MS-Office365-Filtering-Correlation-Id: 17a1e73b-56f1-44b9-bbb8-08db895fdf4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u0rTj2uiBmC7j08AnhbRxtsAHSpM2OhlarWRWnCxMKR4YspAVHtHBhbS6gM/BV3ssFebvTaDiPk1znx+mDx70KjHTR4RST2XBDVDamd39nXwSiGmcHrKDHagcaKrSlWM6lHPefmufJIxub7bc/DZccdZJ/6uhyqA2KHksR4fKR0sQAKkFHg6UprdIYF9g7ZcD+JDnI9UL8y8+GrW+YletvMKUmoc86Rx58Mqys8NK6Q5Lut1TGvW6HXJEWMBjImUMdC2qp+grQ2J663ZlpN3qHzN8Jc665aYYkQcMHz6/1iUp37XgLSswjWzw4y8BUOaU+orYDBPDhnLNSQa6dn3j2fW/H93ohGWLx8iZziKYyeyg5/WMfsFKzLmbyd2g1Gwx6XngCpb6qSMYSETVAQrr5vwr/fA6Jw5UIfV7QxVYiuPR1Z4vEQ+eTZ47i4Z0ceYnmfDo9Roc+avhO73PkQLA5uUUCAGnpajoczXfasU/7gD/Su20P34ufjt2j799sLKuYLtDlJmjmewjrLbaZ8HFhgQ0TwUSlqiP8yIXFVYxpirZov+ZJSBPIu9mws+Y/eDGRBFVz6hxIaGLmFYmKHeNsmMZ5zYJLcHuxoRdMPjtda0j8dI4sxTwgmONmDULjQHJHm26iowFJQ757zIOJiwBn+bdP9JRpIL+nDvy2HjVd7FricA+6oCtncjfzNdtGjJjtCghgoBZdrgrHnd9u0XKMwRNUGxgW94/Ciw8SSWLdZhTyvjRmDCmz0bY3W30J0SS+v5BEEFENgkZ1dhcNL/9g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(346002)(136003)(82310400008)(451199021)(36840700001)(46966006)(40470700004)(81166007)(82740400003)(356005)(40480700001)(40460700003)(7696005)(6666004)(86362001)(336012)(1076003)(8676002)(186003)(26005)(16526019)(44832011)(316002)(41300700001)(5660300002)(70586007)(70206006)(4326008)(54906003)(4744005)(2906002)(110136005)(8936002)(83380400001)(36860700001)(2616005)(36756003)(426003)(478600001)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 20:28:26.3834
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17a1e73b-56f1-44b9-bbb8-08db895fdf4c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT093.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7718
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Future AMD cpus will have microcode patches that exceed the current
limit of three 4K pages. Increase substantially to avoid future size
increases.

Signed-off-by: John Allen <john.allen@amd.com>
Cc: stable@vger.kernel.org
---
 arch/x86/include/asm/microcode_amd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/microcode_amd.h b/arch/x86/include/asm/microcode_amd.h
index e6662adf3af4..e3d5f5ae2f46 100644
--- a/arch/x86/include/asm/microcode_amd.h
+++ b/arch/x86/include/asm/microcode_amd.h
@@ -41,7 +41,7 @@ struct microcode_amd {
 	unsigned int			mpb[];
 };
 
-#define PATCH_MAX_SIZE (3 * PAGE_SIZE)
+#define PATCH_MAX_SIZE (8 * PAGE_SIZE)
 
 #ifdef CONFIG_MICROCODE_AMD
 extern void __init load_ucode_amd_bsp(unsigned int family);
-- 
2.39.3


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE9B75DBDE
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 13:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjGVLVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 07:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjGVLVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 07:21:30 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB47D35B8
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 04:20:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BsGBmjYvkwqFUq/Az6M7QOqbb1Z66QJIk32mVj9txXMCxms7t5MF0lBrLTjUntB3ZjfDW0zDjyd2MDf5+11y5KKDY21z32/+qimb/9Neytnt72b/4DfL0zGnLZmvN38zZQUdFX6FH/WP87J0Cq+6EnYxxnZnnW5Zya9TJCqF9/85K7+utwFLkANNY8+sTOZdWVyz8tX+o259uZ0wh4cw3qC58j/jL2Efz86bXqZZPkO26ASlNi202oLrvoETqaA6RFXMlH+moJ+EYd7xi0/HK1RJKDrXciDnq2Nhvr0cepUgQS55XEHUL+ZKIQwKPXQJpKHRbDVgzWcqJn6iGcfJHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bo1Evqk/mz2ev36gdunzlVNfClz3K9jqaUfvzUPSVMY=;
 b=moZwrNTDCKEZOtCSI7c/eoRmjQZNWBeq3nOBvGf/AebfZOjzFMRy33o8eG9KAcy4Unebdo0yguOFPh25yzQZaGnpGzjUjGifDwaP9xZ6t5z3bk/9mlwkpstCIyJPZOqibGByn+w3RsdA9skMhnJFzqd6II+OiXl+Ez4TjTjVNVwePbmfVGnknefOEgm1nEBzFr/HXf73x4iqn/BBma2su5Hw9aG0VcJmP2nm1ofG5W9n34LdJ9YKm34j373Dc1P/6Hvn2z1cJPO9Ws39Utb/tlcqeVLtwJCRQfPQlY2tVn5rbslwQqFCRJIS++qteSlasXtjqCGfIubBRkZ7T7VwfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bo1Evqk/mz2ev36gdunzlVNfClz3K9jqaUfvzUPSVMY=;
 b=tIh12WR04QnvhISjpzHGjq0XVv3IeKiACkdXXs95r9O3Pwa5SQGc1Vh/wyO84PLFJFI0pe1YnVBsInMfNn1F3981kgOh7aEPLFquR9lMfw63YShcyMq5SKlM3tU7sxT+gM6nMv7iEmsj/ecqQqBTGSJKZQAwnyeHvOwpEUNkNjM=
Received: from DS7PR03CA0166.namprd03.prod.outlook.com (2603:10b6:5:3b2::21)
 by DM6PR12MB4169.namprd12.prod.outlook.com (2603:10b6:5:215::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.30; Sat, 22 Jul
 2023 11:20:41 +0000
Received: from DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::6) by DS7PR03CA0166.outlook.office365.com
 (2603:10b6:5:3b2::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28 via Frontend
 Transport; Sat, 22 Jul 2023 11:20:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT027.mail.protection.outlook.com (10.13.172.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.22 via Frontend Transport; Sat, 22 Jul 2023 11:20:41 +0000
Received: from gomati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 22 Jul
 2023 06:20:38 -0500
From:   Nikunj A Dadhania <nikunj@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC:     <bp@alien8.de>, <thomas.lendacky@amd.com>,
        <dionnaglaze@google.com>, <pgonda@google.com>, <seanjc@google.com>,
        <pbonzini@redhat.com>, <nikunj@amd.com>
Subject: [PATCH v3 08/14] x86/mm: Add generic guest initialization hook
Date:   Sat, 22 Jul 2023 16:49:03 +0530
Message-ID: <20230722111909.15166-9-nikunj@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT027:EE_|DM6PR12MB4169:EE_
X-MS-Office365-Filtering-Correlation-Id: 9261fe10-b69e-4e5a-9f06-08db8aa5af4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z9wWSlcVFXHaVMlRQjamipPrKUbrXApzkghkAzQKlUaMQojCm9lhJO10oWxz0TqBmIBJoGkvbNHFTTi9buEl/1mzSgKitb2x2pSRY2+US4WCCNy4uuh5jbbDWx7MhUttUV7cNIa2Vj8BEYzkBg+GKa9BiuZzalgnMS2jPKM/xbH0yzTz3crEbs8odirxvoiXMd/4qgQE1QDwFgaEMhWRj7fd1GBNbz9vhXQ8QYKqwk/5la/B2u2/h5FlBbhDQfIOWAxMdA2AY3J4C0NBZdOFsazM1c6ewQG1MnJaDo3nEGHLfggjo4IPnJV7gQi2GYSDZdsohzoezbOpGv9amNurxDKByV6h7xUXdxUdPTyvcJu3+D4HoUQiMfQl21r/DmBCatPMrAmi5QtHeIlxnz080j+fwSKzyaWcbUhIUlOrSXO3g10/Yuw2iCVPrHaoB+eTqeVFNVRL50PG7Rm+PuC9sjTWdK9kBjUg2/1EPRO7dRAVMajDFuo6ZSz7AfVi37YlOeoyjyRb8bTyuu6gmQO1Msjfcvlt6ZCJnsb7GVDH5PqIiuFNLR1PD0rl7wk/Kf+3pi7Mp/gCEplYW6ilOkQgF34pCQoOyt1btM96pUDm/a4llSclcY1PRlvhEqZm9q4U8BeWcLRYeiqvqDCJV2YCtuPUy9ygF/fsqt0HE2PVSX9a3WopyTL5IcSpVcQBCSFDeW8DKdfnov4rtOPwf1xlXebqRfw1dOn3bqLRH4EGNxd1nVzNLQMZeMVkCGuYeeEp3NSclGsdBRANbVM3XKHLcVvHlW+ksIKOrVtaHuXrg84=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199021)(82310400008)(40470700004)(46966006)(36840700001)(40460700003)(81166007)(40480700001)(356005)(36860700001)(36756003)(426003)(2616005)(47076005)(83380400001)(16526019)(8936002)(8676002)(5660300002)(110136005)(478600001)(54906003)(4326008)(316002)(70586007)(70206006)(41300700001)(26005)(186003)(336012)(1076003)(6666004)(7696005)(2906002)(82740400003)(41533002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2023 11:20:41.7612
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9261fe10-b69e-4e5a-9f06-08db8aa5af4d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4169
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

Add generic enc_init guest hook for performing any type of
initialization that is vendor specific.

Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
---
 arch/x86/include/asm/x86_init.h | 2 ++
 arch/x86/kernel/x86_init.c      | 2 ++
 arch/x86/mm/mem_encrypt.c       | 3 +++
 3 files changed, 7 insertions(+)

diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index 88085f369ff6..5bca02769074 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -148,12 +148,14 @@ struct x86_init_acpi {
  * @enc_status_change_finish	Notify HV after the encryption status of a range is changed
  * @enc_tlb_flush_required	Returns true if a TLB flush is needed before changing page encryption status
  * @enc_cache_flush_required	Returns true if a cache flush is needed before changing page encryption status
+ * @enc_init			Prepare and initialize encryption features
  */
 struct x86_guest {
 	void (*enc_status_change_prepare)(unsigned long vaddr, int npages, bool enc);
 	bool (*enc_status_change_finish)(unsigned long vaddr, int npages, bool enc);
 	bool (*enc_tlb_flush_required)(bool enc);
 	bool (*enc_cache_flush_required)(void);
+	void (*enc_init)(void);
 };
 
 /**
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index d82f4fa2f1bf..451e0f39d053 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -135,6 +135,7 @@ static bool enc_status_change_finish_noop(unsigned long vaddr, int npages, bool
 static bool enc_tlb_flush_required_noop(bool enc) { return false; }
 static bool enc_cache_flush_required_noop(void) { return false; }
 static bool is_private_mmio_noop(u64 addr) {return false; }
+static void enc_init_noop(void) { }
 
 struct x86_platform_ops x86_platform __ro_after_init = {
 	.calibrate_cpu			= native_calibrate_cpu_early,
@@ -157,6 +158,7 @@ struct x86_platform_ops x86_platform __ro_after_init = {
 		.enc_status_change_finish  = enc_status_change_finish_noop,
 		.enc_tlb_flush_required	   = enc_tlb_flush_required_noop,
 		.enc_cache_flush_required  = enc_cache_flush_required_noop,
+		.enc_init		   = enc_init_noop,
 	},
 };
 
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 9f27e14e185f..01abecc9a774 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -84,5 +84,8 @@ void __init mem_encrypt_init(void)
 	/* Call into SWIOTLB to update the SWIOTLB DMA buffers */
 	swiotlb_update_mem_attributes();
 
+	if (x86_platform.guest.enc_init)
+		x86_platform.guest.enc_init();
+
 	print_mem_encrypt_feature_info();
 }
-- 
2.34.1


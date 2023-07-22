Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCB375DBD7
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 13:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjGVLUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 07:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGVLUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 07:20:19 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2D82691
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 04:20:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NyMAmxHAueuEBcjOf5YCQaRkOKIlyRbtoVHk/iTMu63f754FAWxR0Rix+schak+65AMIgv+xwBusXH73t1qYyTZ+gleiK8cGYSccJXJru8kRwUExvEHGE2hqRRXWPld8BNsWMyqOEGS9jkek48WEFZ/D3GRb92i9eT1A4eK0qF9ubXqMKUXrBpPLjJW+F9hk8qKQJ2NY9WI5gXS+cvd6GNpGMwD0uavN1KTlDTQZhjYIKFXagq/F5CrOHVht/+8AsLy40oSnB2NMsOsOb01hljoaDGqE78C//46lq5IBN2LL4lAPpuwD3tvFupjfS7rL5rE1LMmNkVj5Tr/uAzPRSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WxU8K7B7n3REfJkZo/jGbsHPAWM7qTZq7gcLCRwqdNs=;
 b=IEzDsqyC0n6WsKypwwX/iwlN+gp+XJF1Me0bCEh0TLY57NVb3UqHtnXhNXtLlkUK0LKluwy/aBxAS9kkoF5gUxbtzEVX2vBtay64hwx/SrJfl5Z7cZWTRQNpoekqFxiiPbuPlQ1ONZu6tnk1YwJiTm0Kr5HRF1neOXlFR7MruPTL1xijJ/OoeW1nHcIkVpgrsqaF5LmlmHZa8X0QpdoDr8HKstuPqYDyrZkVTC15anoXxSBA5vIju8VzQrbgi8rY9kp9QeWpov8LyrIGN8aB/4XFxF0b5eEcdU/BvKgwEogpWUurWScetKH3UdznM+QHa8nhCKG0KuoAMzgW/TnU0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WxU8K7B7n3REfJkZo/jGbsHPAWM7qTZq7gcLCRwqdNs=;
 b=AxtQtQeIe53GNJdxU2u+aRX5+6AXkpL5B2SsJtlTXY1JnfNJlLjtoHIZy6PFlF+t57zV6asE7KBl9NBMWpZb23B+ZkqkgT57XzTJG+K0fClHjwxqn4MOy1l6hl9udESNwMDOnYJoDF3gZSv/EqhDkmpqoNhPAirix+6iDyWLWEg=
Received: from BY5PR20CA0017.namprd20.prod.outlook.com (2603:10b6:a03:1f4::30)
 by MN0PR12MB6173.namprd12.prod.outlook.com (2603:10b6:208:3c6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Sat, 22 Jul
 2023 11:20:14 +0000
Received: from DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:1f4:cafe::e9) by BY5PR20CA0017.outlook.office365.com
 (2603:10b6:a03:1f4::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.30 via Frontend
 Transport; Sat, 22 Jul 2023 11:20:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT062.mail.protection.outlook.com (10.13.173.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6609.28 via Frontend Transport; Sat, 22 Jul 2023 11:20:13 +0000
Received: from gomati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 22 Jul
 2023 06:20:10 -0500
From:   Nikunj A Dadhania <nikunj@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC:     <bp@alien8.de>, <thomas.lendacky@amd.com>,
        <dionnaglaze@google.com>, <pgonda@google.com>, <seanjc@google.com>,
        <pbonzini@redhat.com>, <nikunj@amd.com>
Subject: [PATCH v3 00/14] Add Secure TSC support for SNP guests
Date:   Sat, 22 Jul 2023 16:48:55 +0530
Message-ID: <20230722111909.15166-1-nikunj@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT062:EE_|MN0PR12MB6173:EE_
X-MS-Office365-Filtering-Correlation-Id: 54e2c935-4edc-46bd-969e-08db8aa59e6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 42iUVNA/a1aU62vPRQpJIoLFv5kXgcXBtKhUBXZx3qpR9VzQFW5wJ3kSaPqzn7WWDNfwyUZ6IZDlasnx4zNNowf+s9OCj/OJ7GU1sBSm9XIDXqEL8uDIuSs6iqjcWui/TmK8IlGk42kJsGhST8BIXUmUzj/+GY6i/7pwb67bjZB9SLBYmr+s1SkKzgyUtj3frdDDP/Vrj9koqT95KhjdPykT7JPnFpGYPbc0aOi6oYeZ4YD4SFj4pRZAqWbpFl0YsHwXEP5bWtbAwjefHEF/z7+jfKpm6qVmTYf5Fmuy+zrps0Sj1nHIPXODX3Aqkk9EO2PpwliLlIOvOe9qiaRa8ynBGx6EidP4k++WXXCqAnA3Lvv9q6L0Y9SUZLbGiEnWtAzVCjakqK4qsyEdXdFLYDdeskHFuT5o60ZN78OLfB0zbMkRFyVeVoAgXKRORUYLWd1WTmBiZ+GxqQMmGheP/jA4ZqRWTvN9uLxirF8kNdZZzDpGx5QNtya3/1t8JApIQJF35p8f69Cc9jyXB1/nt9i2WEJRoMDPO8ubu3gy11ckMJTFAS5iXTvKmpva6JuKDjPJe1EDXUNTKMcqQWaa11+uEJ09y4YCoLFpkwdHd0TICklmzkxTMLRp3JfQjqNxf2YO/iOuSFijU+khdZSolJ5vUuMAc3hBnOvDEOOggedRjyO2bra7Yx7lR7YzirRq84iAch1oxWjF7Swjfr7c42ig9mMd5BraNjHZeqWmbYR8bW57HCvGFNRG5kWI8aRx0VSYcIgHM+nu2RH2iy7zNyMkEEcYsoBFoT4lf3DMqH4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(136003)(346002)(396003)(82310400008)(451199021)(36840700001)(40470700004)(46966006)(6666004)(82740400003)(7696005)(83380400001)(47076005)(1076003)(478600001)(966005)(26005)(81166007)(4326008)(356005)(54906003)(110136005)(70586007)(70206006)(336012)(186003)(36860700001)(16526019)(2616005)(426003)(40460700003)(5660300002)(41300700001)(2906002)(8936002)(8676002)(316002)(36756003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2023 11:20:13.4560
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54e2c935-4edc-46bd-969e-08db8aa59e6e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6173
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

Secure TSC allows guests to securely use RDTSC/RDTSCP instructions as the
parameters being used cannot be changed by hypervisor once the guest is
launched. More details in the AMD64 APM Vol 2, Section "Secure TSC".

During the boot-up of the secondary cpus, SecureTSC enabled guests need to query
TSC info from AMD Security Processor. This communication channel is encrypted
between the AMD Security Processor and the guest, the hypervisor is just the
conduit to deliver the guest messages to the AMD Security Processor. Each
message is protected with an AEAD (AES-256 GCM). See "SEV Secure Nested Paging
Firmware ABI Specification" document (currently at
https://www.amd.com/system/files/TechDocs/56860.pdf) section "TSC Info"

Use a minimal GCM library to encrypt/decrypt SNP Guest messages to communicate
with the AMD Security Processor which is available at early boot.

SEV-guest driver has the implementation for guest and AMD Security Processor
communication. As the TSC_INFO needs to be initialized during early boot before
smp cpus are started, move most of the sev-guest driver code to kernel/sev.c and
provide well defined APIs to the sev-guest driver to use the interface to avoid
code-duplication.

Patches:
01-07: Preparation and movement of sev-guest driver code
08-14: SecureTSC enablement patches.

Testing SecureTSC
-----------------

SecureTSC hypervisor patches based on top of SEV-SNP UPM series:
https://github.com/nikunjad/linux/tree/snp-host-latest-securetsc

QEMU changes:
https://github.com/nikunjad/qemu/tree/snp_securetsc

QEMU commandline SEV-SNP-UPM with SecureTSC:

  qemu-system-x86_64 -cpu EPYC-Milan-v2,+secure-tsc \
    -object memory-backend-memfd-private,id=ram1,size=1G,share=true \
    -object sev-snp-guest,id=sev0,cbitpos=51,reduced-phys-bits=1,secure-tsc=on \
    -machine q35,confidential-guest-support=sev0,memory-backend=ram1,kvm-type=protected \
    ...

Changelog:
----------
v3:
* Updated commit messages
* Made snp_setup_psp_messaging() generic that is accessed by both the
  kernel and the driver
* Moved most of the context information to sev.c, sev-guest driver
  does not need to know the secrets page layout anymore
* Add CC_ATTR_GUEST_SECURE_TSC early in the series therefore it can be 
  used in later patches.
* Removed data_gpa and data_npages from struct snp_req_data, as certs_data 
  and its size is passed to handle_guest_request_ext()
* Make vmpck_id as unsigned int
* Dropped unnecessary usage of memzero_explicit()
* Cache secrets_pa instead of remapping the cc_blob always
* Rebase on top of v6.4 kernel

v2:
* Rebased on top of v6.3-rc3 that has Boris's sev-guest cleanup series
  https://lore.kernel.org/r/20230307192449.24732-1-bp@alien8.de/

v1: https://lore.kernel.org/r/20230130120327.977460-1-nikunj@amd.com/

Nikunj A Dadhania (14):
  virt: sev-guest: Use AES GCM crypto library
  virt: sev-guest: Move mutex to SNP guest device structure
  virt: sev-guest: Replace pr_debug with dev_dbg
  virt: sev-guest: Add SNP guest request structure
  virt: sev-guest: Add vmpck_id to snp_guest_dev struct
  x86/sev: Cache the secrets page address
  x86/sev: Move and reorganize sev guest request api
  x86/mm: Add generic guest initialization hook
  x86/sev: Add Secure TSC support for SNP guests
  x86/sev: Change TSC MSR behavior for Secure TSC enabled guests
  x86/sev: Prevent RDTSC/RDTSCP interception for Secure TSC enabled
    guests
  x86/kvmclock: Skip kvmclock when Secure TSC is available
  x86/tsc: Mark Secure TSC as reliable clocksource
  x86/sev: Enable Secure TSC for SNP guests

 arch/x86/Kconfig                        |   1 +
 arch/x86/boot/compressed/sev.c          |   2 +-
 arch/x86/coco/core.c                    |   3 +
 arch/x86/include/asm/sev-guest.h        | 175 +++++++
 arch/x86/include/asm/sev.h              |  19 +-
 arch/x86/include/asm/svm.h              |   6 +-
 arch/x86/include/asm/x86_init.h         |   2 +
 arch/x86/kernel/kvmclock.c              |   2 +-
 arch/x86/kernel/sev-shared.c            |   7 +
 arch/x86/kernel/sev.c                   | 631 +++++++++++++++++++++--
 arch/x86/kernel/tsc.c                   |   2 +-
 arch/x86/kernel/x86_init.c              |   2 +
 arch/x86/mm/mem_encrypt.c               |  13 +-
 arch/x86/mm/mem_encrypt_amd.c           |   6 +
 drivers/virt/coco/sev-guest/Kconfig     |   2 -
 drivers/virt/coco/sev-guest/sev-guest.c | 638 +++---------------------
 drivers/virt/coco/sev-guest/sev-guest.h |  63 ---
 include/linux/cc_platform.h             |   8 +
 18 files changed, 882 insertions(+), 700 deletions(-)
 create mode 100644 arch/x86/include/asm/sev-guest.h
 delete mode 100644 drivers/virt/coco/sev-guest/sev-guest.h


base-commit: 6995e2de6891c724bfeb2db33d7b87775f913ad1
-- 
2.34.1


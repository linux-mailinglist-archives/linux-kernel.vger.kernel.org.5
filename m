Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D41E077B0E4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 07:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232717AbjHNFxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 01:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbjHNFwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 01:52:53 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E69E6D
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 22:52:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n28dEN+6YHvg9wX1QYGKSMekGx0Wv/w5HQSYuKfOq6KpmxH1WQKcTaCUCMOeT5hLueZyAClnXGem4u7Fa0t2JxFDhn8654M3tEACems4LGz8wECwF0L59zfAgGAqCPlojMULieCQpTBVppPVVsHhmgBrPaGstkGWlBBgMFkaWej4dl60SgC5Druxy1jr1dwlCD4mTlXYpZ76NmsJ6a6GUZ/ewRiqj+tPY1JlX/+o99VuFffwABOZVhoNEXIl/ggGoDyDTbSP4iUkKOLaVStNrOLQW42xjOTSUUwjFigkwfR8tJoM9XdpU6pNjZX5tPEBFtirb7L0y8lGPqFaiQnfcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YubIcnIqquB/qDhvtxlvkxhrDkErVRlwArXgLrvHe64=;
 b=acZxUMViKHlfctqELF5UepHHVJ4/K/GaBiJJ5nquFBo6aGDX91uMrbVgSDfHvX3mutYrefjkJZdiQ94iVVhvWoq67VnwYo8LPc0FQdSBZQQPuTKPBjRoMgJCUABlAb5fZrzdtcYKzVEy+lcRwD+A179gurGUU2oTZJYkjW7fV4pq87nIg8Gb2QVYjie/5QkhF4y//2JU60yZlP1e2idXQr7S0IHFjp5HRd1OQlx7y4hvr/2VdJNpV5KRoovVozTre+ZS2hA1Ud6+oCoOPf6wCIIrJWnWMOYjhV0Guc3SpBo0HigXNyDuPXfRN5pyLlh1lXPBsEuBkzrkw7kvw7Mtxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YubIcnIqquB/qDhvtxlvkxhrDkErVRlwArXgLrvHe64=;
 b=RzX+mtFBGjoDzUMPfcg0QX5S+IVxwVnl19WpRaXCqCGQBlGwh0K/eKBiDaZ0mxoDB0DjfFAVjcouDLtNnmN2PqBwiziy7bXfDRnUU+0iU9ngVE/iHeYvAr7HV8XeiFMLOPEuGguQLDQLxN2uZrYRjEZ6czaM4Fkb2a4vcaCIm00=
Received: from CYXPR02CA0075.namprd02.prod.outlook.com (2603:10b6:930:ce::28)
 by CH0PR12MB5219.namprd12.prod.outlook.com (2603:10b6:610:d2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 05:52:49 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2603:10b6:930:ce:cafe::35) by CYXPR02CA0075.outlook.office365.com
 (2603:10b6:930:ce::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Mon, 14 Aug 2023 05:52:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.142) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.12 via Frontend Transport; Mon, 14 Aug 2023 05:52:48 +0000
Received: from gomati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 14 Aug
 2023 00:52:44 -0500
From:   Nikunj A Dadhania <nikunj@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC:     <bp@alien8.de>, <thomas.lendacky@amd.com>,
        <dionnaglaze@google.com>, <pgonda@google.com>, <seanjc@google.com>,
        <pbonzini@redhat.com>, <nikunj@amd.com>
Subject: [PATCH v4 00/14] Add Secure TSC support for SNP guests
Date:   Mon, 14 Aug 2023 11:22:08 +0530
Message-ID: <20230814055222.1056404-1-nikunj@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|CH0PR12MB5219:EE_
X-MS-Office365-Filtering-Correlation-Id: 7baaef9e-4326-4f9e-5222-08db9c8ab0d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cvoanbmdoftCG8kacmX05E5P8KnAhfwmWPK/nRwPYXL5+cLooYvgX9y6YGokmeerBS9LhVW4cfCH079hAydAYk8DCYYJHmEhuYrjNTE3RuhVExe9ZEAT1kUvb/5xpjlRV/FEfauBp6KwaSApu0HK2L0daWmjJVoEN+CESky3BLYAYBEB/6Rea+XDcPjhgZRXp46CuioCAuQBMxTGbCxNfuYhFq4L4po6OqgM65tq3ZhvV9eb7souQvC97LdIDJX1FtVyNte7ENEpNAFF/2M+lc81LTkeOogs8aKpWlIIMzidXqYcDTC8h2mGCKQpd8IyGiNHaFRJlnQI4a2fh3x4xtX09T/0OsKyqc8UJIpHap/93WJtoGSfwyhq5cJ+WJPHCLnzAaMUqX4DSjx83JfYOSjXTEgqYrwXe23bVi0IKjN2x6JKxW5ii3PEIs732hXaJ1h2swuMf1GC85xrv8+sgQ3tXoUmh7t32NiO9psv9Ztl84WC+cjpepSUGVI+ZuLq1906B68SNzzeDrNotP2XwezUoBgsBH8m+71hsMk6kKBUALyjU8yk0W6jS4FgYGZw7yvlZ5tkSG/4TceF5Hgu8lM+On2HtKME8BgCImdLRqlujsqF24reGXvkwRpvqo0U0V2fKAc5cAd/w01UIQb+PzibHfNVCdVK+/21nM93aEpdDwN6xkKj3Znim0IxeVVrLZ9ReGNUyaSjDYtusIX9IgB4R9ZFIleqjM5gfFJawdEAzAWgsMA+ND1usgOgl7+ts7f65RyUIxTheV6bSCa1DAaYK18BwPEpvOEHPY9IwIc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(396003)(39860400002)(186006)(1800799006)(82310400008)(451199021)(40470700004)(46966006)(36840700001)(7696005)(6666004)(966005)(36756003)(81166007)(356005)(82740400003)(83380400001)(47076005)(36860700001)(26005)(1076003)(2906002)(336012)(110136005)(54906003)(478600001)(40480700001)(426003)(2616005)(16526019)(8676002)(8936002)(70586007)(5660300002)(40460700003)(41300700001)(316002)(4326008)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 05:52:48.7825
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7baaef9e-4326-4f9e-5222-08db9c8ab0d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5219
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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
v4:
* Drop handle_guest_request() and handle_guest_request_ext()
* Drop NULL check for key
* Corrected commit subject
* Added Reviewed-by from Tom

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
https://lore.kernel.org/lkml/20230722111909.15166-1-nikunj@amd.com/

v2:
* Rebased on top of v6.3-rc3 that has Boris's sev-guest cleanup series
  https://lore.kernel.org/r/20230307192449.24732-1-bp@alien8.de/

v1: https://lore.kernel.org/r/20230130120327.977460-1-nikunj@amd.com/

Nikunj A Dadhania (14):
  virt: sev-guest: Use AES GCM crypto library
  virt: sev-guest: Move mutex to SNP guest device structure
  virt: sev-guest: Replace dev_dbg with pr_debug
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
 drivers/virt/coco/sev-guest/sev-guest.c | 650 +++---------------------
 drivers/virt/coco/sev-guest/sev-guest.h |  63 ---
 include/linux/cc_platform.h             |   8 +
 18 files changed, 881 insertions(+), 713 deletions(-)
 create mode 100644 arch/x86/include/asm/sev-guest.h
 delete mode 100644 drivers/virt/coco/sev-guest/sev-guest.h


base-commit: 6995e2de6891c724bfeb2db33d7b87775f913ad1
-- 
2.34.1


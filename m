Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4766E758CE7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 07:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjGSFN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 01:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjGSFNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 01:13:24 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D011BF2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 22:13:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mjwlMntuZKDWvbRgMPbdbsSgIqg8BbL2GvW91jcDqULrda9LkJpk3eBRlm7QMl8nx6GPIQuqnSUd1+Cx8xRqi8heqrZczCVcBO3UefyuGZwO2v0qZIyUvZHSXb7OzrC5z7bTklu7JQRxHIG7YZREnJHNMFRMkxiBtY6f6jso7Ocqs5Go4wcndUvvs7iTxbLdQ/DBUR3TAvsbx5YH/bUmDgw4rWiaN5b+Zw7XoemCKp17vjhtwD7HtHIdTh9qKUJY3fk+9zJNNNRxnSQ0eEiRWo6wmGs77DGZdRUzu2FslRGX8Nbz+vmepGb2Q9RqknGIC9bF4clzjIgG8oUBN255Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iX07V6KxBdX1U9H9hgqczbTrlXM3xoikZcuVWgin61w=;
 b=b+hsqCxQ6br41YE965rMh+wqTRJ0+Fl5hLi6WP1ISD3kRi+Dh+iNyhzU7KaDtTLo7mwKfXpUomP3g1+xF+xl0MvAOVBkEVzgIXpnTOGiWraJDgLoV83OaZ3coyA5beF9Goo8YklUCGYJnUJiRKMvie9nRMsBM3TF1Nlt+PZy/hAbF1t2g+e90yeflxgXqPXU5Leb/kVJuMOSYey/uVi6nz/ZBrhb8KeN/rsLu8103XgYel9V/Tn/p8ht4RRHzDJXjpWerBjUolrs46yNNCuNfEPJh8k0DKL89d20Ko2I/kn61x9XaL/pkrDXZgoi+XCdTssVXD1b0sUxgjm6Xx4EqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iX07V6KxBdX1U9H9hgqczbTrlXM3xoikZcuVWgin61w=;
 b=xpBgOvpnmkYzk3J7IClne6BkrbDb2B921QT4nkS+9iMYfjUY0dMkRa1qXQ6D3QssvDfg1OvzV64nK/WNO32osZywlOolWnAtblJFQeaaNZwO/iAafkYkapYOyhd5PeZ5mCWI8q/33J49KHDzYjtilxgd29a88pI+N9ttAccZjVc=
Received: from BN9PR03CA0967.namprd03.prod.outlook.com (2603:10b6:408:109::12)
 by SJ2PR12MB7822.namprd12.prod.outlook.com (2603:10b6:a03:4ca::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Wed, 19 Jul
 2023 05:13:20 +0000
Received: from BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::b5) by BN9PR03CA0967.outlook.office365.com
 (2603:10b6:408:109::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33 via Frontend
 Transport; Wed, 19 Jul 2023 05:13:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT024.mail.protection.outlook.com (10.13.177.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.34 via Frontend Transport; Wed, 19 Jul 2023 05:13:20 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 19 Jul
 2023 00:13:17 -0500
From:   Vasant Hegde <vasant.hegde@amd.com>
To:     <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
CC:     <x86@kernel.org>, <dave.hansen@linux.intel.com>, <bp@alien8.de>,
        <mingo@redhat.com>, Vasant Hegde <vasant.hegde@amd.com>,
        "Dheeraj Kumar Srivastava" <dheerajkumar.srivastava@amd.com>
Subject: [PATCH] x86/smp: Validate APIC ID before parking CPU in INIT
Date:   Wed, 19 Jul 2023 05:13:02 +0000
Message-ID: <20230719051302.15801-1-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT024:EE_|SJ2PR12MB7822:EE_
X-MS-Office365-Filtering-Correlation-Id: abe8ea1a-dabb-414f-48a8-08db8816de45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wKFHApWqC/ZmMGGTFLIyKIg8jLVeCNPcuq/5t32/SagE5d4iyWtASRBgWGCxNXvsH25FLOKvyrUbmiI4DuRlNWnrgyTmo/OSj/yoKEy7aGPEKl0ddAiDjcbj/X795qxzH5TK5e1MJeZSdX7fYHcHBUMJKaUppPNZBiLU+gACHajJkdWRVHxWnoXKy9Y0eSgLuH9eRpZv6LWODW9akoTCbhkrwhUk5e6pvgS7olEhuoYnnkyk3mA/EFrpw3XyOlVxHVAvxV9FPR/0blITsdb6ECv3ZWo3ndXRgSsGy38QDEzyttDxmuYHQM0TUV6pxve+ADtrHmyUYr81+MhZWWuDFni3suDQMY7xP+yZb7d1eOsCQkAJ1ipwUcwUxKzACAo9pnc7rDTOgRcMwVP+HJaRytECGs9QBTq6ee4Nf2uZEqvoktr074wozrNMSQM3MCzBRZ5y636s81XHnRDAy7/bSHAgDQbDLD6kUC4+nEi+EPmm0V6W8yq2qejllJpMCRgghqIiTHSJaefU9QFT6lfhDcEsz3f3bTAuwO8s2d45v6nXTZkqnqemwPu1Rgf/hIk128yqT8rC1Uti0QG4vSc1Ti4Yiw3IyrHCZeU7F31fF/vAju441kTV3RZQCax1W1o5GMgL+3Djdfrrz8MwYHI87fEzqGFBVWy+3WK3NIHP56Umkbf8ufDY7knPEjcOxkTRSsCxMy8d3CSXvdmqggvOdief8RJ+gOMiCaFY88XeIgqSdmSw0PxpV+xE5i81uk8jMrtzXkt0Bz2jKOqJIo1wPg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199021)(82310400008)(46966006)(36840700001)(40470700004)(7696005)(54906003)(6666004)(478600001)(110136005)(82740400003)(2616005)(36860700001)(83380400001)(426003)(47076005)(40460700003)(86362001)(40480700001)(70586007)(2906002)(44832011)(356005)(1076003)(186003)(16526019)(26005)(4326008)(81166007)(336012)(70206006)(41300700001)(316002)(8676002)(5660300002)(36756003)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 05:13:20.2329
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abe8ea1a-dabb-414f-48a8-08db8816de45
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7822
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

Below commit is causing kexec to hang in certain scenarios with >255 CPUs.

Reproduce steps:
  - We are using 2 socket system with 384 CPUs
  - Booting first kernel with kernel command line intremap=off
    This disabled x2apic in kernel and booted with apic mode
  - During kexec it tries to send INIT to all CPUs except boot CPU
    If APIC ID is 0x100 (like in our case) then it will send CPU0
    to INIT mode and system hangs (in APIC mode DEST field is 8bit)

Fix this issue by adding apic->apic_id_valid() check before sending
INIT sequence.

Fixes: 45e34c8af58f ("x86/smp: Put CPUs into INIT on shutdown if possible")
Reported-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
Tested-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 arch/x86/kernel/smpboot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index e1aa2cd7734b..e5ca0689c4dd 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1360,7 +1360,7 @@ bool smp_park_other_cpus_in_init(void)
 		if (cpu == this_cpu)
 			continue;
 		apicid = apic->cpu_present_to_apicid(cpu);
-		if (apicid == BAD_APICID)
+		if (apicid == BAD_APICID || !apic->apic_id_valid(apicid))
 			continue;
 		send_init_sequence(apicid);
 	}
-- 
2.31.1


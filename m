Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5546577B0F4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 07:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233477AbjHNFzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 01:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233373AbjHNFyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 01:54:37 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on20628.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::628])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0B210D5
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 22:54:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UDa3ESRYUg5agOt2tF2h5PViwEr6DqGA065M/cMV5Hf+s3qlHv9ydozW0RP1M1Jwu3Djvzy8kiY5omBI4udBWXFsjOP7/EJzRGuetJ8uJacolUYHkYGBKb4/kkp9HeH6VlsGal2nunwyeiwzJQnKVkKMV9Xi7i/imN/5H3L3NY/SGPxvnww0MggfX1Nw7sfmJNTvI+eedkq6woReQiTlmQIT/7E4mxv07CFkmYv9P06DhdcU7yfdY0vpqxZGgceZ9Vnko2P+FbhJJOlJrLfi6G4GZHyRhELXzdCdl0njgg8tau7bxEW33ncVau8nj4A1yrABjA5YCxy8Dfa82yeWhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6y+5SDDPpRulwOlmXO3VSI8qEK9hnC3NPzAIDB6HvJw=;
 b=KTvN1vJm5t9eLbljg8IASAS/YaXN5SR3Puu/xhuvriM0v8L+z2iZ1zotr70Swp1CBDxBN3AjfXnt4AwI13QxpIaA9smWRZCdBdDtUscbL2Xl70k7csf8lnwJ6SeTTh55wWIplc8pc8ZApIl0g3w/IiNr7HUoRUPBnJDMG3/HAUZgUMnY41IzYfYYq+k3R7mvUCg878mFuamo1gYKVwB0pSVyqrAXTfxuTR5KbqRGYq6x7VedJOsnEklpE3jJ7XEFu8Qkt8JgxF7XLwwqjBQdZS0vX5zySCHy8zKfXMOnfIAx3+VtnuQl3g1HCy3WtE+ilyf2Q1TfqZN3dBcG7KxsXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6y+5SDDPpRulwOlmXO3VSI8qEK9hnC3NPzAIDB6HvJw=;
 b=3uP2w4KxySgfh67fHfuWWwQWa6yiK/6K4xxceoG9wa0FrbgHItJcDJ5UpdA87Vqt/C37Qrv+CNU9X786gpYcRO8nvL2VMfHlCiDoOzGTIqvAJ+hTm6fhyjqmla8J1uuGXb2s1/qhTWVe0aKimpofSHkUNt20CziigMJA1rwvFQ4=
Received: from MW4P221CA0022.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::27)
 by IA0PR12MB7651.namprd12.prod.outlook.com (2603:10b6:208:435::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 05:54:19 +0000
Received: from CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::ea) by MW4P221CA0022.outlook.office365.com
 (2603:10b6:303:8b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Mon, 14 Aug 2023 05:54:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT020.mail.protection.outlook.com (10.13.174.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Mon, 14 Aug 2023 05:54:18 +0000
Received: from gomati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 14 Aug
 2023 00:54:11 -0500
From:   Nikunj A Dadhania <nikunj@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC:     <bp@alien8.de>, <thomas.lendacky@amd.com>,
        <dionnaglaze@google.com>, <pgonda@google.com>, <seanjc@google.com>,
        <pbonzini@redhat.com>, <nikunj@amd.com>
Subject: [PATCH v4 13/14] x86/tsc: Mark Secure TSC as reliable clocksource
Date:   Mon, 14 Aug 2023 11:22:21 +0530
Message-ID: <20230814055222.1056404-14-nikunj@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT020:EE_|IA0PR12MB7651:EE_
X-MS-Office365-Filtering-Correlation-Id: ec00957d-9803-4cbc-b03c-08db9c8ae656
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gwdeVLfK/qxPpHtw22ygNyz51yuLpPI6XRDX7BNV/O6WQuz4m/ZyKX8BcUn3R4i1z1mqWzYnyIGkLjvRHUrfPHVZYtfcyvp8WnQ1ylD1NVXHo5Jy8HEJK2Fiq44z/i9fbc/nihGSm8MlroQkYg965hk2qdcCXzptZKnNIATZxa3w/nFCeOLTY/hO0m5SHJ4a1FxcX+8zr3o2tq6IRqqJToFMIIJgG4mCxliCcfXQSKTEZuw7brjIgS8m2qoTYKsYMCutO5G3rZ3M/6wJmBX9778YQOYcyMphudyEZ8lJXy+2E0kanFVQi/XVNbPR3WGADQd5J7pwyKuv5vIYfBYE1mnKdOY903YDBkyaowjaISdFnsTABzaT5F4zJygWKSXwh4zAm7w+CsoqNHME66S6J8LEMeUCGKYHYcupYRKSPX7tCYp8srV0zT2U2m4PPr72iTWwxw/kftm8xxfw0RbBvt5Q+JpWWjWclKSKwOf41UJbc4cudf+s8qJ/ZwxL8S86rFl9FsqqHoUQGx+yFGhgT5Op2eYvm76Frrta26950SfbIOBNJkRxt9X6uWEFKCovYOzfKrgH4LloFivb+CtKyXbkbGOKTodlaEfN1vLsJDTAqW96hzONJaDFoddhnnuIlFup2xCyo5VteR3Zl6G7wi9jesHVGrUBXZSLaLt5EY/njAN5nBnOEyLjipFtCnZK0JfKPtdeF9GTqLUDVr9dlou5mVyav7EhCX/1aNGf5PalO9FN87rFD9b4yU213Ao+TRdQ+3A0FaJFsa2Ydg9LEg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(396003)(136003)(82310400008)(451199021)(186006)(1800799006)(36840700001)(40470700004)(46966006)(36756003)(5660300002)(2906002)(4744005)(40460700003)(40480700001)(83380400001)(36860700001)(54906003)(70206006)(4326008)(70586007)(316002)(110136005)(41300700001)(426003)(16526019)(1076003)(26005)(2616005)(336012)(47076005)(7696005)(8676002)(8936002)(6666004)(478600001)(82740400003)(81166007)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 05:54:18.5511
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec00957d-9803-4cbc-b03c-08db9c8ae656
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7651
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD SNP guests may have Secure TSC feature enabled. Secure TSC as
clocksource is wrongly marked as unstable, mark Secure TSC as
reliable.

Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
---
 arch/x86/kernel/tsc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 344698852146..5f1e2b51ae3b 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1221,7 +1221,7 @@ static void __init check_system_tsc_reliable(void)
 			tsc_clocksource_reliable = 1;
 	}
 #endif
-	if (boot_cpu_has(X86_FEATURE_TSC_RELIABLE))
+	if (boot_cpu_has(X86_FEATURE_TSC_RELIABLE) || cc_platform_has(CC_ATTR_GUEST_SECURE_TSC))
 		tsc_clocksource_reliable = 1;
 
 	/*
-- 
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCBC75DBE1
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 13:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjGVLWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 07:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjGVLWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 07:22:22 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060d.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::60d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E456358C
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 04:21:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wkq205bdvY1MKoGm9wEAjdewqEUWY+7flbr2WCvbw2rjjMqV65FmyUr7OIYu2Z4ghzmoVzgIQRE7TrIgVruv5HnMgmRVa5DkX6yqVWMT4wuWRN55Of6ZIVXXd2s7oPcY6jUp7XI6+1oAIJjJ6kk95q0tO/5n1UZ8PiWG0b1qOEhsNQOXjfvMoVavcrlcWjL0PykfMtl0gTAUo73KAgUXMUPP8Ld8yuW96RL5SgLsM+Njas79no1/2CQbdy2BvNfN6gMcDrwGDHN5opWA2gqAPFzf4emxCZUH0Cf1XEddsf3GzVyrtvOLAYceLJAQXTnvDhyA5IQUvTGHWBw6/JtKXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6y+5SDDPpRulwOlmXO3VSI8qEK9hnC3NPzAIDB6HvJw=;
 b=hilqRGV1CApi7RPpGmyqTnGOL69XwaKZLcOIHZ4CRuV87Ijiif17V2l8d49dacwN7IlJNLFAFClrthrpSLox+vOv7szoOr7EytEs9dA56yqb5xfApFirkmH3wohUUenjoErMSeWl6tVx3F5ThbkClWyj7J93E/lbRrqNO/sAX6XrHafLqfuDDHTMHjG3kkoBYNBD7hozNtTfNrt899mTqh2Ay/1s98fPH5BcoKiTzHGJnxM+zYGA93Xex0B9tRBQ8au4XdCeulFa5YTA2UqNlK0tvxBlHUpRjvNl0baSc8H8LQLMX/OLMHnvBnVgPyzlulapvFqklAV72jCiwyIVcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6y+5SDDPpRulwOlmXO3VSI8qEK9hnC3NPzAIDB6HvJw=;
 b=yQOmRqFACqKQISTB260AUXhubL8u6BhlkPqoPS/Z1cjRsiN1AO/ddLD+xvLvMQf6jXGF1h3iVClZKpoUzToBmF8BdybP82r0Eg5N2iZQiN5EygnSYwPiMl8SMcYOHiHvQov770AEKf0rz+kpEdVrnnFpG7+GBhu+cuxwdTZQHXU=
Received: from SJ0PR03CA0018.namprd03.prod.outlook.com (2603:10b6:a03:33a::23)
 by MW5PR12MB5622.namprd12.prod.outlook.com (2603:10b6:303:198::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.25; Sat, 22 Jul
 2023 11:20:57 +0000
Received: from DM6NAM11FT098.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:33a:cafe::a8) by SJ0PR03CA0018.outlook.office365.com
 (2603:10b6:a03:33a::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28 via Frontend
 Transport; Sat, 22 Jul 2023 11:20:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT098.mail.protection.outlook.com (10.13.173.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6609.28 via Frontend Transport; Sat, 22 Jul 2023 11:20:57 +0000
Received: from gomati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 22 Jul
 2023 06:20:54 -0500
From:   Nikunj A Dadhania <nikunj@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC:     <bp@alien8.de>, <thomas.lendacky@amd.com>,
        <dionnaglaze@google.com>, <pgonda@google.com>, <seanjc@google.com>,
        <pbonzini@redhat.com>, <nikunj@amd.com>
Subject: [PATCH v3 13/14] x86/tsc: Mark Secure TSC as reliable clocksource
Date:   Sat, 22 Jul 2023 16:49:08 +0530
Message-ID: <20230722111909.15166-14-nikunj@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT098:EE_|MW5PR12MB5622:EE_
X-MS-Office365-Filtering-Correlation-Id: b087bf29-3428-4239-b709-08db8aa5b89b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ejrI7jBOmnZv2Mn4S7g8UpU3s9FNf22WxToI1niDcr846HoY+mNuB/efz78gL4IMGJ+H1A8Zp2YWjyajAsy+DKSrx3ywPofWCysKFXJXcBollVm4NqRzHk4kOdfzKFo8MdF22GINMbpdYPoouHx/got+KLvmyPEQziE2qR5vgwcJAxIP+XqPZ0Aeodlghuzf4AQSz7cSGQHQEQEO+qbLnV439GTsFvuhvinmvZTjKHrJCRyFacDXVNF3+1jMjXWc4hDwtsNnV/hxi5nnZK9j+03ri9M8llO1Scxp8knKaJY7sjEHWY/Eit9Cj6S+hGgVA7+uHG6+gt6SWvYg+qinDntdrOazF+Fo+7WGF0wrbg8/wF52iwowcgW6vhPSznRg7TP6NQiLHYb4Y95LVQS+ddM6IG3BBJCWQJct37oX8SDZQ8UKb3Hdesskx0Tzh/tm1ig20RdDzaUV0xR+c10meLNBOSKs31ObVdNfXSiBoIRU/d6ct5i5HnIB6/OMzJbsnC5xJZyBTUEg/31fxjLLOuAxCoPWWzfkkO+7PDKwG7et4YWgPrWpmD2kYV3hG5GcfebC1y6qWRd3OEuhWoCbJ3WqCI1RzqcBxr64NYNrBaGuCbHXGtIbfrCk3AohrAHCcSMsGJz+ff9AcUly87UQ7sd3soUTiSnsXnAQXIUBkqhuhD3ogRIcaphkEWrZLumIKGMaGvSWZ53m4ET++UlBiXJmnwgELO4ymN1PKo/bahs88lthfH803Vqjt/2AhBUxrEnd4Z98Fsd5IRKCtCqVPg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(346002)(376002)(82310400008)(451199021)(46966006)(40470700004)(36840700001)(40460700003)(83380400001)(2616005)(426003)(2906002)(4744005)(47076005)(36860700001)(82740400003)(356005)(81166007)(40480700001)(26005)(70206006)(70586007)(4326008)(316002)(5660300002)(186003)(16526019)(336012)(1076003)(6666004)(41300700001)(7696005)(110136005)(54906003)(478600001)(8936002)(36756003)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2023 11:20:57.3725
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b087bf29-3428-4239-b709-08db8aa5b89b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT098.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5622
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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


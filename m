Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5189177B0F0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 07:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbjHNFyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 01:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233513AbjHNFy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 01:54:28 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061d.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::61d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468D010F9
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 22:54:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V/tLGLSniNnlr6WoIOSzqKfWbcY5R0grFSfz2tuUrCHL36t5aJAI6XPzlySJG5/FuJlDIXozdnoB47eW59q6xy9/uLvXh+3b9pDlIqDGeGn4y4yyo7g6EilX/CqdsYeekoc0utD+UK3LFufNpJRg+YHR9qS9OTFH/UUtwMaPHnZRAfn6vu65MutdTaP3URk9UDgPAvgokWb53Xb+1QDPaM+UTaY6jCRFk8Cgj/sjLQy2bCqXSLqLOvfVZVMUSmX4AMfQufeamjTOrj+Aux9hLvtNNWc6ThOT/MRoimpBO3kSUWhPqWj7dZyEWTAk3fNGSAlhqlcB8R7XsBffapgaKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O3s6XRk5sDMEp4erAgDEJbeHlmXvoaQdohpW0ELcNPc=;
 b=QOs7/fwWnf27KjM0ta+TYr4Kpna81HMwBPblpXLuOVVWsOfaOE6nJTJ4m1mwzk72oF2mIjOhmOxGK2xqJqllIsf8ylxIbfRYPP3qKMxPmzyKDUhEklKdbHJ4z+dSys1car6OUxw9ISJNY78iTHfSzhAENwFowakPQN3m17B3W9OZCShZY5tb+sFzQeE/68mQv5XmDdj9kEC1YuwpfEQ1Ny2midbCbe+gDZb9BMXl2FckOS6rf2Z2uaRvG1fG9Hk3PDNo7hw7b+Vod+9d+ls+OZBl2RunhJFcTZBh1/D1Cv9H2J/o61ismAgZp7hhuPw8vZ711HO25OJuUiufTykDZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3s6XRk5sDMEp4erAgDEJbeHlmXvoaQdohpW0ELcNPc=;
 b=hGT+fRXzULYXJwh1U2zyNzOkP1Fo4IJniZzoQFViHirLY5Z0JBbkeTZG2g0hn/OH/nf9j8KuBFV6gnETpEM+oEpDfaxyT68LXU9AS9TGPeJLS1Ki8sHTffIfhprwnR4ajd9YYTTP03gwU4O7lGpxjunj+qXN6z7+NcZSt9ZoYus=
Received: from SJ0PR03CA0331.namprd03.prod.outlook.com (2603:10b6:a03:39c::6)
 by SA3PR12MB7806.namprd12.prod.outlook.com (2603:10b6:806:31d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 05:54:12 +0000
Received: from CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:39c:cafe::c) by SJ0PR03CA0331.outlook.office365.com
 (2603:10b6:a03:39c::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Mon, 14 Aug 2023 05:54:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT050.mail.protection.outlook.com (10.13.174.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.13 via Frontend Transport; Mon, 14 Aug 2023 05:54:11 +0000
Received: from gomati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 14 Aug
 2023 00:54:08 -0500
From:   Nikunj A Dadhania <nikunj@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC:     <bp@alien8.de>, <thomas.lendacky@amd.com>,
        <dionnaglaze@google.com>, <pgonda@google.com>, <seanjc@google.com>,
        <pbonzini@redhat.com>, <nikunj@amd.com>
Subject: [PATCH v4 12/14] x86/kvmclock: Skip kvmclock when Secure TSC is available
Date:   Mon, 14 Aug 2023 11:22:20 +0530
Message-ID: <20230814055222.1056404-13-nikunj@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT050:EE_|SA3PR12MB7806:EE_
X-MS-Office365-Filtering-Correlation-Id: af7f34cb-6c0b-41c8-8890-08db9c8ae22f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cTdd5yEZPnWzhWhsbvd7zrwiLbe53GEus71+ipJq9Y67q+tgCq1tk6qO5aGeZr+NA5ZLIet/ti22XVT3p4nxZJSaNHVzROFk5bi29Vl+lQHFxKAJLmxHZs3Cw45hq4oP8QTPy0b4y2nBQ2IVZDUpUX9aiUWq1qRQNMp7D+CErf5JsjW5PbIocTbase4VQ0TTEsVtu+L0Oz/3YNpS+7lh4LaCyKzlDnaLdKLqb2+mqSgVK/H0OeyE5xJc5UOyEdCbZDStyV+1KDKUFQzxI+yGocH1arKPNn5M2xEV+ASz8Q7HaKocrTM7bBTA8BrHQkmMkYhMtKF0awb3thVdQzZ3eUZCNMUI7mxS5lA2tglXo+7zpYFdXV6LxB2Kpt1BX+bc9rK3qkPtTl1cBziKEEgN3oMBdweL6RYMLFDsfGARzLd6TtgCAxpRAK6GarQ9Ljw2PlTjkJRTtKAPTHPmnTc6usRm7fVLBGvvwaYkUpEpp1MnZxlPdXdo74IPrqV2WCPLeP/v3ctwNxt4qSuL995B4Cygl8/Aebj5Y+4aER1Cd18/0He1O+XTw7XbFJzVIRzisAC0dUfqJ0AgYGLGUTtzF34JZ2DNxhoha+7QXPU+Jn66J/qE2q8hDL1SxOHr+Ki6C9/+aDiu4J2aX4eFT39GOZch8NftE5z7X71hN5K94f7SqFlNOaLXBBx7Qy4sQRqEtLG7XT3nKFFQzf//BECQhXUCXXBoCZBMHPHhvKeIIG9xsQs11e7j6e97XGBOFk58rzMY5oUZvGsnT1Tb3+UWEA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(136003)(396003)(82310400008)(451199021)(186006)(1800799006)(36840700001)(40470700004)(46966006)(36756003)(5660300002)(2906002)(4744005)(40460700003)(40480700001)(83380400001)(36860700001)(54906003)(70206006)(4326008)(70586007)(316002)(110136005)(41300700001)(426003)(16526019)(1076003)(26005)(2616005)(336012)(47076005)(7696005)(8936002)(8676002)(6666004)(478600001)(82740400003)(356005)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 05:54:11.5680
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af7f34cb-6c0b-41c8-8890-08db9c8ae22f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7806
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For AMD SNP guests having Secure TSC enabled, skip using the kvmclock.
The guest kernel will fallback and use Secure TSC based clocksource.

Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
---
 arch/x86/kernel/kvmclock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 0f35d44c56fe..1be342064851 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -288,7 +288,7 @@ void __init kvmclock_init(void)
 {
 	u8 flags;
 
-	if (!kvm_para_available() || !kvmclock)
+	if (!kvm_para_available() || !kvmclock || cc_platform_has(CC_ATTR_GUEST_SECURE_TSC))
 		return;
 
 	if (kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE2)) {
-- 
2.34.1


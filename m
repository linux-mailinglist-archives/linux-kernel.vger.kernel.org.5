Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C5977B0ED
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 07:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233489AbjHNFyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 01:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233499AbjHNFy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 01:54:26 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49D510EA
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 22:54:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aZlOSppKlwHjz2XirI2GzT2OIY8SLXy04xvW3j7ReEZYzgWqQo23el+WrTm/mKxTRDTV3GKrv0xNizhBtIiMD4X1EgAyoepZ1zDWeOXzRYMNLAwbvM9Br8I4OsKWzbdaawbEOMnYMfidCzrO6SXjoLBUIctXBusuegwCEnS/Y6NNkToaaF+wJgkw7LCkY417GtvpsfqbTN9bdwjo7YrdOS4nuamAI8HPY5JOQywaaOBu3xA/7mpU5YgmJPorq4V23rgcKwRRmot3UoVe9OafKj4DLqRIwdHpNaC1rjhDyuaqnoD3ZQC+6GTj7ykq17q7/cz6UcZjLq2OOrZG7RJN5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pP5EnYMWy6h0McrrcwvHxMH9bmi4Ie9BZNOR+xAO3B8=;
 b=jEqZo6WTM/rdTk+d1ihtlL88x2R6GIEfGxssYvBge2ZpFhiNsEfTUQLJCwOSa79re6xaGftRh9EwGRaO6wfHnknP299A1VcvBVOJgGTU/LpbKblXyPD7iCy2S5wQr/E+dv6WJD5YGPV7gQ28WY0AZwCndZ8rdYok7tR1H2RHid5Eg62x36FphYqfU3QYmVjbMQwiF4lT4dyxvPKXmiqYqJzRmsrhW3ZcGH8JOeNvku0+saFbkqa5jF/tK7edcNbs4NjlVyfcFqTNCgapFsgpAi397tt0QakBzTBCiWx8OTnxaLuZXmLt8BBLeGadYrv7eCqWdTGmdPxTPnI3vkMX8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pP5EnYMWy6h0McrrcwvHxMH9bmi4Ie9BZNOR+xAO3B8=;
 b=FfC+L0z8YmvXtF7xG+k0pqmXcg4gHyQeRDCyfDxkbgnIr038tV3Me8fwxnrzTIyds7xx3xdhU1iCxjfXGejdl7zyNPsSxjlbfMEXaR2OlcJLg7FiQCY7vRfFwQmUpdapc0iobm6SNCNNLOhpMYqIMy+b2dH8f0pOvlTvoA05z3c=
Received: from SJ0PR03CA0342.namprd03.prod.outlook.com (2603:10b6:a03:39c::17)
 by BL1PR12MB5731.namprd12.prod.outlook.com (2603:10b6:208:386::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Mon, 14 Aug
 2023 05:54:11 +0000
Received: from CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:39c:cafe::6) by SJ0PR03CA0342.outlook.office365.com
 (2603:10b6:a03:39c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Mon, 14 Aug 2023 05:54:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT050.mail.protection.outlook.com (10.13.174.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.13 via Frontend Transport; Mon, 14 Aug 2023 05:54:09 +0000
Received: from gomati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 14 Aug
 2023 00:54:05 -0500
From:   Nikunj A Dadhania <nikunj@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC:     <bp@alien8.de>, <thomas.lendacky@amd.com>,
        <dionnaglaze@google.com>, <pgonda@google.com>, <seanjc@google.com>,
        <pbonzini@redhat.com>, <nikunj@amd.com>
Subject: [PATCH v4 11/14] x86/sev: Prevent RDTSC/RDTSCP interception for Secure TSC enabled guests
Date:   Mon, 14 Aug 2023 11:22:19 +0530
Message-ID: <20230814055222.1056404-12-nikunj@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT050:EE_|BL1PR12MB5731:EE_
X-MS-Office365-Filtering-Correlation-Id: edd54d26-561c-400a-d605-08db9c8ae113
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p9gbujWiiTGIHuuqCQ5MKtc/Y7dQFcXGPJd2NICGSYK1FwNiiAI+aU34Akr/Nv8L5C48v7rg9TL7nbqIg5yiOxtjpqeWsa83Jes+60+OKjyvaioam7MNKZ8J1sIwF9cRLT0KlINVWLfdxNawzMvBYAYH729n9CoPa0Kg7Z2jZ6ozrWjA4/nD4RaVY30CVFpscLp2ZlBswMhJNDJpoPP9E8cAd8Xt0MUl/+SiHVVYNAd4lvswt3One5hM3kWronit23fhffvRFF3NArfap43QHrmlp/LPZcuEqpN4CJnm6j7COkiODtZPpy1smTbUjj23TuAimhZAUeut3JsxgQQISqn/Tc5YxK+4MUGo6+XFxbwQmG92lts/1QUuJQedS/kwuzHAwiaEtiu9Sn64iYveMUSznOSY1W7nI21zM2cE7Rb/TECet/xuqPlk82Og4dLb1SMr54Skj9y5F+vMFpgktHtlwgpwlL9e/siSyFf3hPI/WzC8OKOFOjk/+9eMJ4cTUFU/n7uWelKiRfnE4p7kAZ9Q6k1W8dIj8NP9+gWN49g7AaeIBfQEzy1hNaYaSV83n0RfgJBSmJxRAiVkjYR+tuPO24hXivgF22oIQjrWBuwz8q8NWuzT8bPuNHsTU0ION4jofIshgTIIVM+HqBSUILwVtGIlMDGuAZo61g8GJmTcwV6vVtsX7Ckx1frFUxK18i/9yYonpcL60oWPDL4Ykmzv27EcqE9wAgb1UPoQY6mYW7cpyMu/0ZVas9X56GolTblIHmhevUKSwSNbpIXfAA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(346002)(136003)(82310400008)(1800799006)(186006)(451199021)(40470700004)(46966006)(36840700001)(40480700001)(82740400003)(356005)(81166007)(36756003)(40460700003)(2906002)(6666004)(478600001)(7696005)(1076003)(2616005)(26005)(336012)(426003)(16526019)(316002)(110136005)(54906003)(41300700001)(70206006)(70586007)(5660300002)(8676002)(8936002)(4326008)(36860700001)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 05:54:09.7088
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edd54d26-561c-400a-d605-08db9c8ae113
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5731
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hypervisor should not be intercepting RDTSC/RDTSCP when Secure TSC
is enabled. A #VC exception will be generated if the RDTSC/RDTSCP
instructions are being intercepted. If this should occur and Secure
TSC is enabled, terminate guest execution.

Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
---
 arch/x86/kernel/sev-shared.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 3a5b0c9c4fcc..1c22025b298f 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -912,6 +912,13 @@ static enum es_result vc_handle_rdtsc(struct ghcb *ghcb,
 	bool rdtscp = (exit_code == SVM_EXIT_RDTSCP);
 	enum es_result ret;
 
+	/*
+	 * RDTSC and RDTSCP should not be intercepted when Secure TSC is
+	 * enabled. Terminate the SNP guest when the interception is enabled.
+	 */
+	if (sev_status & MSR_AMD64_SNP_SECURE_TSC)
+		return ES_VMM_ERROR;
+
 	ret = sev_es_ghcb_hv_call(ghcb, ctxt, exit_code, 0, 0);
 	if (ret != ES_OK)
 		return ret;
-- 
2.34.1


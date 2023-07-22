Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7285B75DBE5
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 13:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjGVLZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 07:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbjGVLZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 07:25:28 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C956F3C0D
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 04:24:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ixpMxZ1x4xx3/VVhIspMwJssF2kVFgx3K19HkqmHluulRv7Eeo0aSpdsJbKjjB90dQeCm6olx/0/Btrx1Mb+3QkCcE28Sbay0Tn++UEx5419UloRhyjmSvsAd7rCJovCxDa/o7KIdZUh5icGMuI7aVLbFef8Mpf4yA+TsdBVDfiwdTRQWmHEEWKJm2ckocKzHQi11D/KvNqXEof9mrvNcVWxdusZ4SpH9gMlcn/TxT2wkHzQb/Cjz9Nxt3iOdLM+QfECC206a1pSZ4y01cvDwbzCnY5mij7sIq5xiB530LhRXyrlvNqH8+z+NqD4yCRTlG8hQ7n1hPKdPcAcQdIkmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O3s6XRk5sDMEp4erAgDEJbeHlmXvoaQdohpW0ELcNPc=;
 b=HrSUtTd1ExjE+0eP8HBj53PFYKI46WAGZxmP1WoP8GEENtY9rGaWQUZeiasWnv9urSyJxpVvgnCaPHuvJqVAZqrwT/hf9j/PRSOUj+ki/P/8JAO6MU/sStOe5cS9KVMNdMfdnwXjmww/RJ09cytj6mp/GzxTKDSzFWHZzQbb2tjTg+bMJ9XBGkXVtTNCr7dMyKfTk9mptE46UU5y1BjVNartoCUbwAGizWyXRSgB/9gKVbGKZAAFVhaSyOQUYw09XOvJTpmUX0hWZ4QCMmypTWR8g+CAo1xk+/bYTU22fVkUOIl8Bhs7DmfEsahPcIG4p2wPsit1KIHaTBIMRC2yeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3s6XRk5sDMEp4erAgDEJbeHlmXvoaQdohpW0ELcNPc=;
 b=w6rcvI+WKW4V0+E72mjwmzxvU8kMaBluT/CH7VwMH1aYAoaIMHu6JGa2yvRYriA1Ag4QSrVqOKLGc1vgJeZcQkWZYAPW/DwQH/llA/DiWEQRTiEv59oPkLtn9fVlTDs9pHaw1yEbrOPJvt4EiDsJnI8vXXDTMHOdv0hbn5Z6aWg=
Received: from SJ0PR03CA0026.namprd03.prod.outlook.com (2603:10b6:a03:33a::31)
 by DM4PR12MB7645.namprd12.prod.outlook.com (2603:10b6:8:107::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.30; Sat, 22 Jul
 2023 11:20:56 +0000
Received: from DM6NAM11FT098.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:33a:cafe::c4) by SJ0PR03CA0026.outlook.office365.com
 (2603:10b6:a03:33a::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24 via Frontend
 Transport; Sat, 22 Jul 2023 11:20:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT098.mail.protection.outlook.com (10.13.173.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6609.28 via Frontend Transport; Sat, 22 Jul 2023 11:20:55 +0000
Received: from gomati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 22 Jul
 2023 06:20:50 -0500
From:   Nikunj A Dadhania <nikunj@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC:     <bp@alien8.de>, <thomas.lendacky@amd.com>,
        <dionnaglaze@google.com>, <pgonda@google.com>, <seanjc@google.com>,
        <pbonzini@redhat.com>, <nikunj@amd.com>
Subject: [PATCH v3 12/14] x86/kvmclock: Skip kvmclock when Secure TSC is available
Date:   Sat, 22 Jul 2023 16:49:07 +0530
Message-ID: <20230722111909.15166-13-nikunj@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT098:EE_|DM4PR12MB7645:EE_
X-MS-Office365-Filtering-Correlation-Id: 48bec2ad-b712-46fc-c8d6-08db8aa5b784
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ahqkD93P1iqWfg/HD94E4ixuvZyvmqXa8prwRYE9zgoXWyuexk5CCZ95sMsbfkiB2+sYJ6QJQDAyI5L5RSmon7xTKGAvwJg6LKlWArKrYlbN3Zo1iR+1YWVizMOqBoqog3FwjUFAoAj6eMxbUXiUOXO2ZS0wDz+GduoDaO/P3aNLm0aO5TvUkVIWEO2KUNlMDNVBRYo6bUWhpCt6yrP0JpW/j0Ez2Ra68wtsvU/OxX/7b0HpIftq8SEJGu8ftFA5dlmvYz2fn3hlK11p5Vj/Co2V3p/7oT1EnEe1Mu5/YtbreC00xnqEf+8AM+cIRVOkGvvANMgPj4sXBBdvUQN3eGjKeuCPKzhdpakogJCMyg59I3l4zS+m+AOTPfEPf+YTZx6fDbyWA3rDuH+suRa9MnhAJ7a9ujX4JZ2UCuf3H3BpTVm1o3Kpm9aQFDiRJFf2tB4y1iJIYWTC0Byz8xjvIfw83LBFmVcOKZPoVI4JO0tg0/qbmwuPwU4FphKSWem5BCgMLv9vd4C+muaDITXtJEYzkLJHP8uBCo9vWrqWRroYWloOfl2cRPERr/oPPtspmX8I5kPbBdc/Zcon+sAvhHA0LkZTpblF3w9H0ET999wYvzacUy64vtnX7NsGRjCc7AotOimTzaPUDxiG9nm9sr8+tOA4fL9OrxQh3XmXCeIlZGEo5EkmddrsoU4tIoXETWPo4ogwOwe3kSSb+1jFVxMjNlsA2TSRMu56A4JyosZMmAAoXo2UPuHvj2uzYZ+ocdv/Bx3JQHI/3I7CB5FECg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(376002)(136003)(82310400008)(451199021)(36840700001)(40470700004)(46966006)(4744005)(47076005)(1076003)(41300700001)(426003)(186003)(336012)(83380400001)(478600001)(26005)(6666004)(40480700001)(2616005)(40460700003)(2906002)(16526019)(7696005)(36756003)(5660300002)(70586007)(70206006)(4326008)(81166007)(356005)(82740400003)(8676002)(8936002)(316002)(36860700001)(110136005)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2023 11:20:55.5601
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48bec2ad-b712-46fc-c8d6-08db8aa5b784
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT098.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7645
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


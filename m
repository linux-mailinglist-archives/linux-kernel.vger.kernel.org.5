Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D0875DBD9
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 13:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjGVLUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 07:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjGVLU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 07:20:28 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8049A30F2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 04:20:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HHkURZqBeSLZqWE+XJNoVO7lJcFhNredH+1DyZzpirMlcxrZjCcLL6LhX5O+keczsSXZqb0Kx+2z8BJCv3ODPxGoWiCD3HqC+yWHY4moQNV4zMUGnRMcTlCNpbB5pGFFgbu6pC1DcN8KjwfTZFuQsQCwVbd/yw9F7f3JmPeAEd6ZhXTQcEYQKFg/gVXmT44S+wRTUf66FKZI0/lPop85ZR5VLgBqP1g1Qf0GzOdcHhpKg76cxZwNdqIi8mkI2QMOwWHFiLbDISFkwbP9eNk/xxmnOs5sRD9+nUTuChyiC4XefIx1Swms16mLclw8sF1XRC0Ajg6kt96iJtLBjzqQ2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wf2e9idX4lvI5Wg8UX9KE4a4P7OUa7ldcMXtVNnLRlA=;
 b=BA3jpmZVKeIOHRncHewN62rN4LtQE/6Kf6u3vbqwm6cRsGxX04F+1n41l4SBX6Iili3mHqoTqD/5e4IL5HriivcrcqYRxzszWSQgKOrojNrtIUFDM7aKQVq85VRbbEDtJbka6PI4g+OdFQvaODuc3uVYuomOQx+9OY3AxWPWEYRk4CzSZ9Id3XGb7f9KKYrl8WRty2LBcuSWgGJlVOOpAhMA2UKTrTmTCtaMzyLZld3/e1wypUQem7mY7hZCDrwhGi6hjiFFGlsYtD/x2tVDrmAhNZV1Dqr0qp5mOtvx/ghOjCFH3dKVYlnyZ2Ftg6goJUqzBx1azvEa2cadZda1ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wf2e9idX4lvI5Wg8UX9KE4a4P7OUa7ldcMXtVNnLRlA=;
 b=Iq4k2JgmV03KI6S/GkD5UbujwThxZVOnuSG5yqWg0yrcxz9ylrtpxDKnzxxJyUTT/4UXdzYbXvrsCc1P0lacA6WP7JiSYcJwNEMYeiRFOFf3IGGTLCagMFOJYCXMqJgPWKefdRWOhpuYfoKRH5cZPu3pP7wiehytIJUNSQOs5H0=
Received: from BY3PR04CA0025.namprd04.prod.outlook.com (2603:10b6:a03:217::30)
 by IA0PR12MB8085.namprd12.prod.outlook.com (2603:10b6:208:400::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.25; Sat, 22 Jul
 2023 11:20:24 +0000
Received: from DM6NAM11FT077.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:217:cafe::ec) by BY3PR04CA0025.outlook.office365.com
 (2603:10b6:a03:217::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28 via Frontend
 Transport; Sat, 22 Jul 2023 11:20:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT077.mail.protection.outlook.com (10.13.173.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.22 via Frontend Transport; Sat, 22 Jul 2023 11:20:23 +0000
Received: from gomati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 22 Jul
 2023 06:20:20 -0500
From:   Nikunj A Dadhania <nikunj@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC:     <bp@alien8.de>, <thomas.lendacky@amd.com>,
        <dionnaglaze@google.com>, <pgonda@google.com>, <seanjc@google.com>,
        <pbonzini@redhat.com>, <nikunj@amd.com>
Subject: [PATCH v3 03/14] virt: sev-guest: Replace pr_debug with dev_dbg
Date:   Sat, 22 Jul 2023 16:48:58 +0530
Message-ID: <20230722111909.15166-4-nikunj@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT077:EE_|IA0PR12MB8085:EE_
X-MS-Office365-Filtering-Correlation-Id: 93236ce4-7094-4372-c2e3-08db8aa5a491
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YScvlvQmevpRJ2OQR7ilqM+wCBOibQXgmQc92vqW+559z8+K/HSlUdkgnTStOlnvrQdo+Jn1UYDKWWrP6n26ktLAQpju7eCvQedSXC3V3eHJmeDDAkhFER1eXJCrtvfud5rcYIW7sN6QjfRds2T0U+VTbk0dD1ltdbZmW2E9B6736M3aB7gstFC9tvitjXNXePx7AkPXX7ywA12qPqJ+EJLmOY1R/6bol9dBVM5J4BqO5HhvyH2hL57u2++aCl2TOQdBHwmTpvR24KjzxZAO9giPEmS3iOPdnG6mjYBL8yqPREp4e2hNl8YOK/3cXUWy2bO/ctmjQqCc0U3bObm4bM4W3InMswVP57BxTSV+DEaMOYxj1mp9nQHUXUg6/XwcuvHIwNr3GVyeSEdQO6raLYIy+wZj98XLGduWCblsAl4ES4HBhmK3ClvnAqDcbWqS2jChYMW59cDqWEBeOvqwzAurnOI7ars9KFikImyj/PIjyRGNR7vHLHfVwjbA5MMx+iRlV86H0DU7Ye/ZO7k0Zm7nFGmBVFv0qPUdNl5emQ8EP0v7rXFzDQ4s7gLer9pcuvZmUuvjQh1BgLzQcGYdiD2tYo6Iug7RO5zPaLV5JiZ+2qwjRl96vU7NEUU8eNWlYszU/qYeRWQIqDBx7cbvVHiyJMTKeyk0TnS5ybmehPCJE34bVUNcSDHdI9YkEt3FJKyOP9xrruaKyGv6TZXg6ReUUXhOkD+2s+cWrog/IL/g6Y8GHw1Vj1Nn0wJLh0WV0rghA0nVFX+h+NLh9qbcIg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(346002)(376002)(82310400008)(451199021)(46966006)(40470700004)(36840700001)(40460700003)(83380400001)(2616005)(426003)(2906002)(47076005)(36860700001)(82740400003)(356005)(81166007)(40480700001)(26005)(70206006)(70586007)(4326008)(316002)(5660300002)(186003)(16526019)(336012)(1076003)(6666004)(41300700001)(7696005)(110136005)(54906003)(478600001)(8936002)(36756003)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2023 11:20:23.7528
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93236ce4-7094-4372-c2e3-08db8aa5a491
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT077.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8085
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

In preparation of moving code to arch/x86/kernel/sev.c,
replace dev_dbg with pr_debug.

Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
---
 drivers/virt/coco/sev-guest/sev-guest.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 8ba624088d73..538c42e64baa 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -206,8 +206,9 @@ static int verify_and_dec_payload(struct snp_guest_dev *snp_dev, void *payload,
 	struct snp_guest_msg_hdr *resp_hdr = &resp->hdr;
 	struct aesgcm_ctx *ctx = snp_dev->ctx;
 
-	dev_dbg(snp_dev->dev, "response [seqno %lld type %d version %d sz %d]\n",
-		resp_hdr->msg_seqno, resp_hdr->msg_type, resp_hdr->msg_version, resp_hdr->msg_sz);
+	pr_debug("response [seqno %lld type %d version %d sz %d]\n",
+		 resp_hdr->msg_seqno, resp_hdr->msg_type, resp_hdr->msg_version,
+		 resp_hdr->msg_sz);
 
 	/* Copy response from shared memory to encrypted memory. */
 	memcpy(resp, snp_dev->response, sizeof(*resp));
@@ -253,8 +254,8 @@ static int enc_payload(struct snp_guest_dev *snp_dev, u64 seqno, int version, u8
 	if (!hdr->msg_seqno)
 		return -ENOSR;
 
-	dev_dbg(snp_dev->dev, "request [seqno %lld type %d version %d sz %d]\n",
-		hdr->msg_seqno, hdr->msg_type, hdr->msg_version, hdr->msg_sz);
+	pr_debug("request [seqno %lld type %d version %d sz %d]\n",
+		 hdr->msg_seqno, hdr->msg_type, hdr->msg_version, hdr->msg_sz);
 
 	return __enc_payload(snp_dev->ctx, req, payload, sz);
 }
-- 
2.34.1


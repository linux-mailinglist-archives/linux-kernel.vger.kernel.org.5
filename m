Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33FE378B7C5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 21:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233269AbjH1TDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 15:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233300AbjH1TCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 15:02:43 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2060a.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8d::60a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F29C102;
        Mon, 28 Aug 2023 12:02:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cgwEW1nKCgKSyaJGheqqZBssa+DPo+sNE7poM43e/h3MIvDw4swDLHTC+vVZqYWMTsZzAoQioxXZXpD8y16QEaZ/CfrWbBD7uaG+UbEGYxkHjeKZmi+Z93FyWjCz7FR3hrRj047nvRqJilT48bIJKqL2+Z/miNC9BNwP4KgR2schee0Y3tDYFg5vkE9a1RcE7kuJFTM9f+R5Yo3zVEYj18ZbuHxGuZPk+mL0X6xprGWZf9LcErIavwmn9VeobqX0yCbl4wGde85FsqHzPAy9tokq4O0s7uGD6L4CpwFKh5+965fvhS9CDC0pLVlQcueY8yssakHeLTXO4wJPVawFxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=neVk4+DybMx9OiwO6U41dUaX0ObEgjI21xFTmhVQhik=;
 b=SBxP4CYlhMxW0fdrDCMJK6Nl2x//uQJhVz3u812okTzgDzQQkLcEc5Z/e7LiN6dww4R0lrvrEGbmjPbl34KLbjgoc4OPbUvBpPfD64IDmQQGcwb+uGx5mG3hClwq189aEabMFZCjgQZh9gVYUVBMsqaQcXou0PuX552FgYNLuYrXv5DskzcDE3MiN2iw6yWXR8OGiB+jSZY8Tt3QwzpCje1iU2SWjXUVLCZrFj/8+kax7ApAdPsJr1TGqakAwV/Nyimb4gqVmwyPryV8Qc7JIvIr3yY15HoiXNkEUjqunTkuX02Za253qZUmx3B4jIZGyuGk4vqJNn2Z1fhQP5upWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=neVk4+DybMx9OiwO6U41dUaX0ObEgjI21xFTmhVQhik=;
 b=v8Atz37YAsTyXRbBhQkXRTkofIfiMUQIrZJjt5HmSknPgxpZBve3LDiu/BdqmGrOHXYQr4hHAaCz+HLD1i4v6BGfjhym6ETDM7R1Pvy8oXtITdhfUpeKUot95blel1foGaBcr02g2QjkvA4a2VSMqIRRiUhj2vxuLtVVxTv7oKg=
Received: from CY8PR10CA0041.namprd10.prod.outlook.com (2603:10b6:930:4b::12)
 by BY5PR12MB4308.namprd12.prod.outlook.com (2603:10b6:a03:20a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Mon, 28 Aug
 2023 19:02:35 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:930:4b:cafe::6d) by CY8PR10CA0041.outlook.office365.com
 (2603:10b6:930:4b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35 via Frontend
 Transport; Mon, 28 Aug 2023 19:02:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.83) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Mon, 28 Aug 2023 19:02:34 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 28 Aug
 2023 14:02:32 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <thomas.lendacky@amd.com>, <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH 0/3] Fixes for dynamic boost control unit tests
Date:   Mon, 28 Aug 2023 14:01:57 -0500
Message-ID: <20230828190200.1598-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|BY5PR12MB4308:EE_
X-MS-Office365-Filtering-Correlation-Id: 395e85e1-2914-4587-2dff-08dba7f95664
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dACQuZsu9Z7iC7HrOrlsu1ZFbCnIA60u1QBApX66YhPZbFizrMHNQl+IdH0cmYSYS0QIqmApppqsUeEb4cllxt+9xn0vPGLkeR/6hnZLNRTsMq4oyLEY2S2K9HCjF6wEYaqwt3TzFM1qM7600QQu+m5dLUQS/eMNafdDTaKAG26cwwvRjpF/mRK31s6m4c2Cx046HqfWX7VKpD2KuGwwLDankkfJc2OWKIVKcHSy1Ob/+qZZ7fq4zPIGjgcW545CfwbCCI4JH1TPa0fRAZ8f9Nh10RF/skop/Z/OsaCHp/F2m8v8YQ2zIWKmY6ZR8sZq43VGHK7TN61wSAU0+rtEmVmUNjhsENb/GPTXqT94S8SXSdKsC+GufpBhriJ9Vf7XBLuBOldThNQ1GQIcn+m3NM3PsjWQOnnJuP3bkJZ+JPyuFBRBJ8+MC+rfk2h98+84Tu4kOkHLageJFLICOlEjwvpiD7DsvqtU7gOq7Pzkh3GrgG2/Afs7HJsJtTRXcP+9PvBYKl3dDkMWYxFbBbhjGcg0qFMBY7byFim8jx56Xe0xVhWLaFb2DtaMN9hI7dPWh1kh5mAcXVHK7uZavestPEbIMBHPLR+Vy6AedAiBXJOxjDsQv84BTa7usmOBAVgVmEYBvcH2fpW2mvQQeHeQrBGBCJcTcTIU4vHSk0n9niF3ivRaspjUCNUAPiHR8v25OW7yJpyPMgMObhHkwzqIF7AjFGTzPZGEuJO3GwvJmlo8+bogWZs4m/xvy1yd4Ej18ra9GJQWYXGnROxlCNLOpw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(376002)(136003)(346002)(82310400011)(186009)(1800799009)(451199024)(40470700004)(46966006)(36840700001)(7696005)(6666004)(966005)(83380400001)(478600001)(1076003)(2906002)(336012)(426003)(26005)(16526019)(4744005)(110136005)(2616005)(54906003)(316002)(70206006)(70586007)(41300700001)(44832011)(5660300002)(4326008)(8676002)(8936002)(40460700003)(36756003)(86362001)(40480700001)(356005)(81166007)(36860700001)(47076005)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 19:02:34.0064
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 395e85e1-2914-4587-2dff-08dba7f95664
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4308
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Further testing of the code being submitted to 6.6-rc1 against
additional hardware found some problems with the unit tests and
sample application.

These patches are produced and tested with the two patches already
posted [1].

Link: https://lore.kernel.org/linux-crypto/20230824221932.2807-1-mario.limonciello@amd.com/#t [1]

Mario Limonciello (3):
  crypto: ccp: Fix DBC sample application error handling
  crypto: ccp: Fix sample application signature passing
  crypto: ccp: Fix some unfused tests

 tools/crypto/ccp/dbc.c       | 17 +++++++++--------
 tools/crypto/ccp/dbc.py      |  8 ++++----
 tools/crypto/ccp/test_dbc.py | 22 +++++++++++-----------
 3 files changed, 24 insertions(+), 23 deletions(-)


base-commit: 85b9bf9a514d991fcecb118d0a8a35e754ff9265
prerequisite-patch-id: 4bcf7f3ea21472e4e28c2457cc9827f6023ec6ca
prerequisite-patch-id: 903be53a20306f0188e52015dbfe5196738bb2eb
-- 
2.34.1


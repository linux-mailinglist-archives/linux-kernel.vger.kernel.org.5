Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D1478CB59
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 19:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237917AbjH2ReU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 13:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237811AbjH2Rdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 13:33:44 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A0819F;
        Tue, 29 Aug 2023 10:33:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hep/POdMr1eJBmYAFuAK4f/46GSbocNxMHMw555BOLkRTQDzm+iwNAfbPnC7zPGpN6bI32UTvFKNBHIl5ewJUbcGSqQgOgvWTRrrRtqD+8ouWNQUiTDuzv8Og1ny2vQM9u6nvj/O2v5m8jeNyqJCHKfmgJn5yzhQfm9BiVGIpB2AHViYLFo96ePW0ele5AoM4IWBCtPBTWNmL3qNKNaaPdeC5SbqWIedakR69mKiqWMB4WGTHJ7iEVovw+azbE0crm18Do2fE3emC/sESJY5fwqnJEkNaZxLSTOdCUFrWY+jCEO1yNUoiH7neXSOUcEtwYov25BkPcChrPeo3hya5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VNBoCo6E7d9mDtlh2Ki3ZzYgx0aAz+Iw6ESonFUzvak=;
 b=S2qE5pem2Qr0FBWlvSDDVIEDmVQr0IrGOIQqtw0TRTajW7hQ6DN0g5wzNzjMJ+IgQtQvXLWEb8EFapZezXJfud5WfxxH68PaPhAjIiIOMvsvsGrPa/jMbA4Jz8I86447KIi6azrPEfi/4IR7JbbU+DzhK3HemV1dJ6LQcgIcFcBY4yfKc4kL1U0B6+C2AYmbLOsqF2hRUgDRVv3zJZylBMlx3QiUJ9aHZK2fmIEuKUZuvCwj0nUPDi30Yh+APiMHMvQm348APGJKSiApIf7tZt4W+LLgOnMwe3An1XaKMEQSaEh+DkiSdJ4HpRiQDMhII5ZtMVEEEOeEPJpg/yFxyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VNBoCo6E7d9mDtlh2Ki3ZzYgx0aAz+Iw6ESonFUzvak=;
 b=dPLZv+ANI7NZ54Jv9ezC+CSv+KUumMF+bFPKGuCpnmxjSvlNbUfO5PVm4ZBasG4+YfS7KVNXbcMf2TWKlszw5Ee7dRLjk/y2h6ww3QxAZXmTKYWWKRwwr0/FHptB/uMm+MHEKoOFlGnljEZ0QfDv/APOmkXG5HunrHBdGboIn5c=
Received: from CY5PR22CA0045.namprd22.prod.outlook.com (2603:10b6:930:1d::22)
 by CY5PR12MB6204.namprd12.prod.outlook.com (2603:10b6:930:23::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Tue, 29 Aug
 2023 17:33:37 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:930:1d:cafe::e8) by CY5PR22CA0045.outlook.office365.com
 (2603:10b6:930:1d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34 via Frontend
 Transport; Tue, 29 Aug 2023 17:33:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Tue, 29 Aug 2023 17:33:36 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 29 Aug
 2023 12:33:33 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <thomas.lendacky@amd.com>, <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH v3 0/5] Fixes for dynamic boost control for 6.6
Date:   Tue, 29 Aug 2023 10:07:54 -0500
Message-ID: <20230829150759.156126-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|CY5PR12MB6204:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e205917-0400-4d71-cee9-08dba8b61369
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tLtJVqtBqk7U7/H72v6Q4GdPcJBm4n4YABzIyxArV3rK+iak6Rp2SOlR91jBmBdgCO6FAPHo5FFzWhEBwduNPlB9bU9B70FmwkjW88r/Fz1aKo+PMX5szgkPA6Q68yuSVf8C9oBGq0HvUhx5m46Ckwhhh8jVPDhb1WovrOK/Df0ZsGYJU8ymYJqYxr6Rre848jrZvNWKU3C/S11GGgIeNCjR5gEuZYoAa2/KboNuEgU0FllritPtW05rlt99+3yIoeZmh6PNjcpMlT6NjthkURLTmendk+wGnp4eiih17TtCfPdqnvbufDObQQIOwuXS1F3aat2ZIzIZCJfbgcNtfDAH/iqU2Nc4dJU6xMwdXCjtetpookHBSO1ps9pQHsoaF07OGAwTR4pTr4aTtBl2OyUB4kVYGlooRzf7pyR6yjNjah8rsmm5MmNuyFKHn/8t1c4Igmi5KWW+ObwzihwIh9/GRc6V6uRgQQ7NMZuCpmrFjp5pKlZpLIhYpZcUfxYxr1SJo/EnDcxRlRacOEMX5iBWVM5Cl6Cy7K0RCCpn2WZ+laemtOXOHVr58BdCiEH3h4HBxZ6ylsVd1tbM6vaaBGQ2JAtYSGswfd+cOMbNdMHB137EXt3rrSR6GlIZDDgqFuXcKRUY/jQjotkXZA4facLqUeW787DUTOSvM6D++rkyNRf0MuEeKBtcGo2gzzQEemgeBQcCKYfsWf9ItoQvGoxVOo6VZPhmhOaJDRLmYcLin4khzSROo8T7KnNbMoXEUiBrzj6j1lNtihXHSNp416PDLXVxnrR+BQ4zG8MoOiE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(346002)(396003)(136003)(82310400011)(186009)(1800799009)(451199024)(36840700001)(40470700004)(46966006)(6666004)(7696005)(478600001)(966005)(110136005)(83380400001)(426003)(2906002)(16526019)(336012)(1076003)(26005)(54906003)(2616005)(316002)(8936002)(70206006)(70586007)(41300700001)(8676002)(5660300002)(44832011)(4326008)(40460700003)(36756003)(86362001)(40480700001)(47076005)(36860700001)(356005)(81166007)(82740400003)(66899024)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 17:33:36.5179
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e205917-0400-4d71-cee9-08dba8b61369
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6204
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Testing the code that is submitted for kernel 6.6 found some occasional
problems with memory allocation and with the test suite and sample
application as merged.

This series fixes all problems found. Ideally all patches should
be submitted for a future 6.6-rc, but, the most important is
"crypto: ccp: Get a free page to use while fetching initial nonce"
if the rest must be pushed to 6.7.

This series merges together the two previous submissions, re-orders them
and fixes one more problem found with unfused tests.
Link: https://lore.kernel.org/linux-crypto/20230828190200.1598-1-mario.limonciello@amd.com/T/#m5f336a50707d2426c2a0d47d751f06d233e5c816
Link: https://lore.kernel.org/linux-crypto/20230824221932.2807-1-mario.limonciello@amd.com/#t

Mario Limonciello (5):
  crypto: ccp: Get a free page to use while fetching initial nonce
  crypto: ccp: Fix ioctl unit tests
  crypto: ccp: Fix DBC sample application error handling
  crypto: ccp: Fix sample application signature passing
  crypto: ccp: Fix some unfused tests

 drivers/crypto/ccp/dbc.c     |  2 +-
 tools/crypto/ccp/dbc.c       | 17 +++++++-------
 tools/crypto/ccp/dbc.py      |  8 +++----
 tools/crypto/ccp/test_dbc.py | 45 +++++++++++++++++++++---------------
 4 files changed, 41 insertions(+), 31 deletions(-)


base-commit: 85b9bf9a514d991fcecb118d0a8a35e754ff9265
-- 
2.34.1


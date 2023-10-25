Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E9E7D63BA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 09:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233764AbjJYHob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 03:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233954AbjJYHny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 03:43:54 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CEEE385A;
        Wed, 25 Oct 2023 00:35:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=beA1qDmXEI7fd0GJkR52ah3VrzJQ0KaI7NweC9yqpHZU2lMFqRekhBYNDp8e3WZ1ebHZ30eFM19XgnARrOh89QZ73z/hNnuiV5CkkPaBe9tG2tR046fKYOvwV7OeSNJ3LphQhadsqtrJM78/wkb8/LNAr5ZzcbkEqsjwmefIVC5+kIx1Z67+GMSmFzM4Xgl3hNBQ3dtKvn20SEWOgF4P/smupFz8dkhIF8yVxQ7rR0DjoMc2qHl/TXU8x5ttXhHfRGKbhqx/uQ0xmjBTODnjyRGo6eUAaQQmuGkDERMA6WXux0Z04cqvQMq72ZeibYagI1qWgUX53Eemv5ZZkoGcYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fb1lA1A/zrQ11AAEuTb0poQjEohgg7ygwwoOdxYleTc=;
 b=Qaf7JRk0dwL7C0YxTvudfRR23VopYO46gmtS1f8uuPqEObSwWD4PrhsG/3HTzlmmUcyOHanpB+Xp2fLeu20w6UvI4ifbB9dALlSgHJaSl3Qv51+SjnBAQtU8FXCJOyhGXhnhyWr6gJ0yqZL3PnBoIs89B7HUcvDDbDVCKbUCGcmf/WgYjU+AJvYZRlRuTly+3YT+iNSLwaOVFlQgdH8qCXZXMcWo7WNLwA9ZpU54DSXhE54j42zIpNF9Nk1B0y6T+yQM0pT0beQ+unzgK5U97xXsD+w9LDpk0nZTvyHcVsxZqnHO4P9tYJFP2pwrXde7fdfMcTnmolZf5sBnWqES0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fb1lA1A/zrQ11AAEuTb0poQjEohgg7ygwwoOdxYleTc=;
 b=fT7AgoGa29IazgEl6buVVKX4ywwkD46jZHjbray3Ol5QEK8cbZ8cZMrPCmflSBAMuTFN5fyzfzLSBkplrLJ2obRbIwW6Di2Fwz7IghOxCG5+DvoSFG7tU6UCWe4SusRXKlTKxSTkHQ9rvoR7jBTj3xf6z+XGwDMNOLgvFnNUWJU=
Received: from CH2PR16CA0011.namprd16.prod.outlook.com (2603:10b6:610:50::21)
 by DS0PR12MB9322.namprd12.prod.outlook.com (2603:10b6:8:1bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Wed, 25 Oct
 2023 07:35:09 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:610:50:cafe::5e) by CH2PR16CA0011.outlook.office365.com
 (2603:10b6:610:50::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19 via Frontend
 Transport; Wed, 25 Oct 2023 07:35:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.18 via Frontend Transport; Wed, 25 Oct 2023 07:35:09 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 25 Oct
 2023 02:35:07 -0500
From:   Muralidhara M K <muralimk@amd.com>
To:     <linux-edac@vger.kernel.org>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, Muralidhara M K <muralidhara.mk@amd.com>
Subject: [PATCH 0/7] Address Translation support for MI200 and MI300 models
Date:   Wed, 25 Oct 2023 07:33:32 +0000
Message-ID: <20231025073339.630093-1-muralimk@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|DS0PR12MB9322:EE_
X-MS-Office365-Filtering-Correlation-Id: ac3c7c43-9fe8-450b-dba8-08dbd52ceab2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aqoZvIt1YgLXGUwd5iKcr/08V1LkkEWdagZBvK2B0YDBt6NbkfxPjy14Zz8Ry0qvgvyAXiFypWsyvcecXSnzBTt+TrKXzYK6eq6SM4nar6SLYZEbdOE3lZhtabemZUFVK38sGg+XgLmtJkubq+5Yl87U0A7Y9WynKiUfJtlJhCjJU9EM/8NH37FDL0NMWZZMNnTdvpYGYPl7flsqujF3kt5nFEd+nhF5Duk92s4Fl6W+IIxoTlMYJvEbiJ52icXHsOAoXO0npUOtP1Py74jFtvq/R1JyFmRzmClYHT+SFXR8qnN9NppcL6u5cyjSJuAMhPcimXrLyU/1sCt71zY/eEJT8jVaFZRGdRwXeDTRAieGKYLFXZsm3zpRpubtnLmVtBfpJ/ghXiyu9Z2t4WoOSOssM85Unw43NfDV09O72rHAG7Rs+CEAjeJtXr/jCyUDwQeL/gZKu0+vjwnVyTHRCcn+1d348hrxsxBdvxvmZh7iWx4MSM0iIPVwkcTN4ePYQkgkVjeqkZAheknU5GQ6Svvfge6dWPLaclqbVKD3xNpM7vI9TMupnZPvGod+AM9pTHTNiRPYd1Bx4UJJFSlsw6VqD+1bMj5roNsHSMP+cZXqOy0p7DLZwJ6dw5slJryO4K3DMhhOkQbGVxGZSUlTvLsZFSDoGPzcdn9d3kMeIpf73hSVMkaroorlZmYCoBF0otOPDzJp0DKaspGxXgNa88trZ7k+xstLZsGdKLuzIqRAHQHppsJDFF0r9lyVxfcF24X3mCFP5FCchK/QcyidnOTCuo7VDrFsXz26oEHsvfo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(136003)(39860400002)(346002)(230922051799003)(451199024)(64100799003)(186009)(82310400011)(1800799009)(36840700001)(40470700004)(46966006)(2616005)(426003)(336012)(36756003)(26005)(16526019)(81166007)(1076003)(40480700001)(40460700003)(7696005)(47076005)(83380400001)(82740400003)(356005)(966005)(8936002)(8676002)(4326008)(478600001)(2906002)(316002)(5660300002)(41300700001)(6666004)(110136005)(36860700001)(70586007)(70206006)(54906003)(170073001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 07:35:09.5143
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac3c7c43-9fe8-450b-dba8-08dbd52ceab2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9322
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Muralidhara M K <muralidhara.mk@amd.com>

This patchset adds support for MI200 heterogeneous address translation support
and MI300A address translation support, fixups on HBM3 memory address maps.

The patch set depends on the Yazen's patches submitted
"AMD Address Translation Library"
https://lore.kernel.org/linux-edac/20231005173526.42831-1-yazen.ghannam@amd.com/T/#m4a9ddb63b334f367219ab0002a9a133e891f6aac

The patchset does following

Patch 1:
MI200 heterogeneous address translation support.

Patch 2:
MI300 heterogeneous address translation support.

Patch 3:
Convert HBM3 MCA Decoded address to Normalized address.

Patch 4:
lookup table to get the correct cs instance id for HBM3.

Patch 5:
Convert physical cs id to logical cs id by static lookup
table.

Patch 6:
Reading correct bit fields to get cs_fabric_id.

Patch 7:
Identify all physical pages in a row to retire all 8 columns
of pages when the error is injected to avoid future errors.


Muralidhara M K (7):
  RAS: Add Address Translation support for MI200
  RAS: Add Address Translation support for MI300
  RAS: Add MCA Error address conversion for UMC
  RAS: Add static lookup table to get CS physical ID
  RAS: Add fixed Physical to logical CS ID mapping table
  RAS: Get CS fabirc ID register bit fields
  EDAC/amd64: RAS: platform/x86/amd: Identify all physical pages in row

 drivers/edac/amd64_edac.c         |   5 +
 drivers/ras/amd/atl/core.c        |   5 +-
 drivers/ras/amd/atl/dehash.c      | 149 ++++++++++++++
 drivers/ras/amd/atl/denormalize.c | 110 ++++++++++-
 drivers/ras/amd/atl/internal.h    |  27 ++-
 drivers/ras/amd/atl/map.c         | 158 ++++++++++++---
 drivers/ras/amd/atl/reg_fields.h  |  42 +++-
 drivers/ras/amd/atl/system.c      |   4 +
 drivers/ras/amd/atl/umc.c         | 309 +++++++++++++++++++++++++++++-
 include/linux/amd-atl.h           |   2 +
 10 files changed, 778 insertions(+), 33 deletions(-)

-- 
2.25.1


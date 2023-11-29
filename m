Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A617FD5A8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 12:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbjK2L3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 06:29:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbjK2L3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 06:29:30 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BE484;
        Wed, 29 Nov 2023 03:29:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gywo5gdoqA8Qs4d1qrY3F4aAaGB63qvD3/iK6dSyo05duFGRqxe7lDAMk/q3zqB2nZTBHgxLyWwIiFsYnO7+rSaY9+6r9uuQLLxcPyZosficprQs9P1tuOoC2XXIISS4K3h5BVGzzL8QahvPNKw5f+hQZ7HqLHV4Nfb618xvpxpPHHCPuwrwAuE5jzxDE2r9T19oe2kbIV/eMTO5vph3CQhaWzKUhCj0fYl5dl3K0EEp06MKCWAevaJj0by52p2YYvRp7PymMh4zIKb2DFeaF1+pjmWYcJdC6ikVKxDKHJ4rMk1bOgMS4UWvASPdnvfN3yhGlVJjKTYGHLhOivZhPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PYPC5aA5vCT0RpUFzi3Ffqik11yqzDWUr5NuVUz8Hmg=;
 b=U0e89/UE/Fu0QBHPbwemawUvKyWZomsOHkX20Ojp5HW+2OLETIgDMy4OSlesEvcpKTQmhYREIAx0cWXv3nwbcyeYkFixGt0i/MmQJMDiwSb9d9nNttQs9akMSTgYnVWlsmzkmHYD+AoZ828S2obuG+hnAhjrausvKeQYkEzuHljNVp8zTdZv1ceZwVhe0Rv5fXukr1U3ekytKJz9+18HT6vAtyvIYsJHlWOQYBPRpXPpizcSHK6SpMUVXQXb6EnFn7CWxo1lqnkFVFKT7JvVQiuzxiqCXnH/3+NiqWCLGNpGhARqUW/np+sWubcmhXYsJTI5EpHPjCuG3ZYubRL9gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=baylibre.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PYPC5aA5vCT0RpUFzi3Ffqik11yqzDWUr5NuVUz8Hmg=;
 b=mkX+n+6ZLPY/p8pNiUkm5BtLgSijZcttLVWmQsVe+GXfrSRXLYkC7todBcQayOaX7GL72N4F5nh2Yl+w+7oBkl4j/DaGX+I9NKh7whKDMOQAhGN+1pTyGMx0kWlXwD0MB2uDQMUmvxy5h8gTy2dPBzka0gM0+5MzI5LYd8CxzCw=
Received: from BL1PR13CA0441.namprd13.prod.outlook.com (2603:10b6:208:2c3::26)
 by CY8PR12MB7515.namprd12.prod.outlook.com (2603:10b6:930:93::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Wed, 29 Nov
 2023 11:29:34 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:208:2c3:cafe::b4) by BL1PR13CA0441.outlook.office365.com
 (2603:10b6:208:2c3::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22 via Frontend
 Transport; Wed, 29 Nov 2023 11:29:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Wed, 29 Nov 2023 11:29:34 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 29 Nov
 2023 05:29:33 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 29 Nov
 2023 03:29:33 -0800
Received: from xsjarunbala50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 29 Nov 2023 05:29:32 -0600
From:   Jay Buddhabhatti <jay.buddhabhatti@amd.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <michal.simek@amd.com>, <shubhrajyoti.datta@xilinx.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Jay Buddhabhatti <jay.buddhabhatti@amd.com>
Subject: [PATCH RESEND v2 0/2] update for versal net platform
Date:   Wed, 29 Nov 2023 03:29:14 -0800
Message-ID: <20231129112916.23125-1-jay.buddhabhatti@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|CY8PR12MB7515:EE_
X-MS-Office365-Filtering-Correlation-Id: d892225e-fad4-48ba-d414-08dbf0ce764f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MxL/3Z0k+2xXubfPeH3Sx4HCWKWs7kZDE0nWwwIeflm7x7Ukgj3JzBynmV0v3SjTsHntyFrhic0nBLq5o2EW98YjexdvKbuq281OB64sXLUt2jxmKTo7Moe3n+3NpPwLOne1hwpI2/uBnmTyD5fCO2sljA9gGWbXEHYSFZPb2ReqY/6CmNPwdc4W8jp9rGhi+xb29ESctslbjYu3ZXB0MVk7z6aEGCaJE3RDsRD7LGgN7+Lr0X0iwN28SdoYUvMrJDDnLitLgflKlvIWmzkEkf92sRd4RJ+wpaa4jq5ZR3QB8Y5xl0CXCkSkD2G+6jKKZfziOyaJpRgyPnUS4cj3QOnpBU64IxVVtsA01EmvuBEOQF42TfQbZxhyPLlio9IvqX1g4iOQojSZtDAPQ7mKSnEvqz5lrNUWC3LDKrAT92sQbSNro9QEluovJ0uzBwa6JD/fgjwiLk2IcXqi9UjofLQhkLXFz++k1IbdB09TxpoV+35OUqVFBG6Jb6CTKugZ7ocPPZmLEbN9WAo4aXoDpqN3BbzTzl9PjGedCu21yE8RlCnN5JnbI3TASsOcuu+svrR1gyKcNe0/T92kr8883Km8Tuq2ZgIJ94O1hGUYYvOsVMGN8lz2LwS1mpx/PlZyiAIi5VnD3LWWAk9h7yuvnq5iuZQ0QwD0goHgB9lebBYrJ7tPYAsBKpMuwTaFq1KYhfuNeV0X43+iW2xhHZvflxpa1zqgy/JlmTAaSKm4KtbScGcqaAWy4/7jjmtE0dMSZhjQHfNJG0fWqfyyefqwlg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(39860400002)(396003)(136003)(230922051799003)(64100799003)(451199024)(82310400011)(186009)(1800799012)(36840700001)(40470700004)(46966006)(40460700003)(316002)(110136005)(70206006)(54906003)(70586007)(426003)(36756003)(36860700001)(336012)(6666004)(26005)(2616005)(1076003)(478600001)(966005)(82740400003)(356005)(81166007)(86362001)(83380400001)(47076005)(40480700001)(44832011)(4744005)(5660300002)(15650500001)(2906002)(4326008)(41300700001)(8936002)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 11:29:34.1616
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d892225e-fad4-48ba-d414-08dbf0ce764f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7515
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update clock driver to support for Versal NET platforms.
Versal Net is a new AMD/Xilinx  SoC.

V1 link: https://lore.kernel.org/lkml/20231016113002.15929-1-jay.buddhabhatti@amd.com/
V1->V2:
 - Updated logic to use fls() to get max width of divider
 - Added fixes tag in patch #1

Jay Buddhabhatti (2):
  drivers: clk: zynqmp: calculate closest mux rate
  drivers: clk: zynqmp: update divider round rate logic

 drivers/clk/zynqmp/clk-mux-zynqmp.c |  2 +-
 drivers/clk/zynqmp/divider.c        | 66 +++--------------------------
 2 files changed, 6 insertions(+), 62 deletions(-)

-- 
2.17.1


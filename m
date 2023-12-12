Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C576780EE3E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 15:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376391AbjLLOB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 09:01:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376357AbjLLOBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 09:01:24 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CBF7123;
        Tue, 12 Dec 2023 06:01:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l42lHiFPT/E9ciOlhM1T6pSR1SLfIu6Yv4arMtE1yxfLQXe7uPiEPkbtwHvouk4gCVBoeq0UcKUrDdh8r+TzPsDldOH/X6HMgg4zHSgNscFkbr08K21mMSHz3HXw/cT61EOdcomljnOmRNpYtQuJ5LnDOaoIJPVwk8oM8GdHCJmCrnGXz3YqURsS3182RNtkR850xxcdd18t5hBJjo0IF5pxPDlkv1kCNIDWHfegeY4bntFdfTfWexXMnPrpUfXjwhybkShQbTs4i1SHke9+H6gbj0Qgc3pvyRZ9An4OZ+FGVwgt/s1huSfR0zRyAwrnfZsrGdQTBYB8PzpGXIhTaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BSnd2IGkkS0MWVY0uJF8r6OlttqJpc66bQcN81UroT0=;
 b=ScLcrWlsKziKdVAEo9hxIVckZu+8I9FB4y1f0MZazDVMFFrE+rw7w8o4dopq+f9nIRZhbeuqhBzwRVJBbkzmKTmfF9OrRhRZ/mi2ZZMS74JhsKbTJQDNXrLwyYkzRhfeQC0WXLG8AWsnpXlSU9u++GCOV2NEV2HLHOyAT7oab5YD6OFEg45+SOr3u6yn8QtCHTc0M7Jh6aPxqWx7BcVYAnJky/dEqzH1yjrzgaPDbzI9+DnhjY+V9Btp66RQkRZmh18iTH/1kvW/QeWecqSGu8mNd59mjcYdAJ7PkgfQKTLKZYLonvbxM0MxC8qQHx3HgKn5NHGHiWZmi+Q6Kzc7Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BSnd2IGkkS0MWVY0uJF8r6OlttqJpc66bQcN81UroT0=;
 b=4+qSdh8Dr/RW6GerktCiMmSmP2ZsW9PzNlIwelfK+42qVrqsPIed3rEMtszoPPqFep7u3FcgSFrPuLwplNoaDslhg92lRas9r3kCR/0V7aVvB0HnV1zfDWORNP3J5vgHuVw8Gxkxs+1W/s4UohLn3eJypHPVs+ceUSsbsfKxsvo=
Received: from BN1PR13CA0021.namprd13.prod.outlook.com (2603:10b6:408:e2::26)
 by DM6PR12MB4185.namprd12.prod.outlook.com (2603:10b6:5:216::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 14:01:26 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:408:e2:cafe::7c) by BN1PR13CA0021.outlook.office365.com
 (2603:10b6:408:e2::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.23 via Frontend
 Transport; Tue, 12 Dec 2023 14:01:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Tue, 12 Dec 2023 14:01:18 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 12 Dec
 2023 08:01:14 -0600
From:   Sanath S <Sanath.S@amd.com>
To:     <mario.limonciello@amd.com>, <andreas.noever@gmail.com>,
        <michael.jamet@intel.com>, <mika.westerberg@linux.intel.com>,
        <YehezkelShB@gmail.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Sanath S <Sanath.S@amd.com>
Subject: [PATCH 0/2] Add support for downstream port reset(DPR)
Date:   Tue, 12 Dec 2023 19:30:45 +0530
Message-ID: <20231212140047.2021496-1-Sanath.S@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|DM6PR12MB4185:EE_
X-MS-Office365-Filtering-Correlation-Id: 58e0e8a4-fc56-48f8-433b-08dbfb1ad3b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FrR0mJzN1bsvi8q+i6la4+fB04+gBfmwOnwAw/fNTxnCNcAn01ho1nyBQqeDvHtG1OsSmlUYe+jsybSz5zZ0kryq90CdiNPbd/rqiOuveLXd19rb8cVy/ES/yxJL3oh59okcHItDL1so8D5l5hccDex6RAI4/SCSBsb1WdCmgz5duCSGb/F6tjEryppUvg/QdC4ngFU/Wdvc42Jed6frm3Fa2ovu6OfgJY08sZPtJ41zesE6QxpUr/ADjOrnj55qqgOS9YEVkHyj78Kvl8BleaJNJT0aURc8TNhKqoc30r6cyV3t6kX+bEPeMsF84gOw+VEzPHZCtM7VCo0Cd+K3IlmiShim8HvLrWmMisU5tPEinThChWmvwGaQWqYnD8dHA8x8cpS7/dqICO3wAfUbn1RNbFGUzH6zKaglDiGOkhpLAG2YE5mVo78OzQnHX2ZfRD25NFYD02sPWRR+rCFewRwLg6PVq5D1bZAwq1UIx29nsy7SKCOgGiQctuDu1I0mEwNhf6DyoGITa+0cDVWFaJ4a+OxXgclvphmefejWn97Y3h9K5wSZC20v3xspXtg3tqGnyIMaHzvrmuy4PZrdbJOk2uA0I0DRRusZ4fnTzyv2TaBCEZhofcZU35IybJAdHr7rI/E+nIzgotRnfcJfmUzZh4ygCyC62S+31D/7MV6ShzFmsPOS7rYl4l6QFxDYouQmgAa0QBaB+2NGOfv9ZEc+2VvjBKZTL0pEDPmB+xFtRr+Lk0GgQdZWNj1C9cLOUXtyvXX4jx2FBsBPSUTsyaqpqavzbxMuP2vtzDRunYk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(396003)(136003)(39860400002)(230922051799003)(451199024)(186009)(82310400011)(64100799003)(1800799012)(46966006)(40470700004)(36840700001)(41300700001)(81166007)(82740400003)(8676002)(8936002)(86362001)(316002)(36756003)(70206006)(110136005)(70586007)(478600001)(356005)(2906002)(16526019)(426003)(7696005)(336012)(40480700001)(4744005)(1076003)(26005)(5660300002)(2616005)(83380400001)(40460700003)(47076005)(6666004)(36860700001)(4326008)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 14:01:18.8990
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58e0e8a4-fc56-48f8-433b-08dbfb1ad3b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4185
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tunnels created by boot firmware results in incorrect PCI resource
allocation, which results in failure of extending daisy chain.

This series aligns with windows behaviour of performing a teardown of
tunnels and resetting the downstream ports using DPR during the init
sequence.

Sanath S (2):
  thunderbolt: Introduce tb_switch_reset_ports(), tb_port_reset() and
    usb4_port_reset()
  thunderbolt: Teardown tunnels and reset downstream ports created by
    boot firmware

 drivers/thunderbolt/switch.c  |  31 ++++++++
 drivers/thunderbolt/tb.c      | 137 ++--------------------------------
 drivers/thunderbolt/tb.h      |   2 +
 drivers/thunderbolt/tb_regs.h |   1 +
 drivers/thunderbolt/usb4.c    |  39 ++++++++++
 5 files changed, 80 insertions(+), 130 deletions(-)

-- 
2.34.1


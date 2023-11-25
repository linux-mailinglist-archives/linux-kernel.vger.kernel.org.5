Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5FD7F8A16
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 12:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbjKYLQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 06:16:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjKYLQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 06:16:09 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A85127;
        Sat, 25 Nov 2023 03:16:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N5tOhrgZEELKhEdyq9gZ9tR1SaJ69cf2JWQKApNCVkLvOgL/3ael0hBk/095/ox1vetjMxOs9EcKZD0ZgfsXU3ZaidC+hEwHKtXN4WYX0MRKCzX3DQJuEaLvE7LLwMJjP8UXizyk/7tF44eWsucHi59sz6PR1jyscgxHrhsYqHkGFVMkKoWXQWwWO2ed0/Rye/L6KRdnMNjxT4B/CzRgK9FJAlxTRf9L/EFzwDAL9fyQnofGZZi7qKGcjRFf0eLmNfJ39VzmswLltEb/BZ4eyC8Iwb/mOpOAP6a1oxGOwkq7NjF6Q928IiaYs+xmEV0Dp3NLOF2U+MZFPIUwAhm/sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hkHDGOZTkp5gZ4OBAd5yvPjRBrZOWac0U4thWag6mmM=;
 b=cPzjyRqTrYcq5v2dApG+M2mtWtkjxccMNkV0T5dkaBq/+YY7puCuJSjjde5Zw8B4jXsC3nAIGCs7qx3aHQ8xPTYoDWhHOJNPfxXq20SO02wRdulNZ2eKLyU93NZkxjqCAOqWOpui8tav3mkWH0Zp8aJodxdqKHG/+Cb7fMvbOJSBE+ReR8gFjzeQQU9xsw3mc4vFah5HKZVkfBRLgp4lDMV2JZmE4eo8sLhx0UWXP/N3l4/wH9WIqhmbQx7xsP/QqhaGGcUaVSoaBaYt81ojzOTYZdIK3FM7w8Ex4PokT82mky+t4gyBQm5qMqbJHaPhAsR22Hdz5USOon6aDl+8qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=grandegger.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hkHDGOZTkp5gZ4OBAd5yvPjRBrZOWac0U4thWag6mmM=;
 b=Seoz3Qz2t8HSNa+pSY0yMK3jbpv6qUG7EcI24TNkWa6TdhAsez5Gn6yBmH2PdK24MtDJW4pxqZyeiZ6fk2q5V8NUOSsPn45H3mPiJvLT/skc9t1xErEEs/fbtUn7Dw2OAIvzRDSH0JOrT8zZyQFAblatJPkZ9tYyGhtxPBr4wi8=
Received: from SN4PR0501CA0131.namprd05.prod.outlook.com
 (2603:10b6:803:42::48) by IA1PR12MB9031.namprd12.prod.outlook.com
 (2603:10b6:208:3f9::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.25; Sat, 25 Nov
 2023 11:16:10 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:803:42:cafe::af) by SN4PR0501CA0131.outlook.office365.com
 (2603:10b6:803:42::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.16 via Frontend
 Transport; Sat, 25 Nov 2023 11:16:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Sat, 25 Nov 2023 11:16:09 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sat, 25 Nov
 2023 05:15:48 -0600
Received: from xhdvnc205.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Sat, 25 Nov 2023 05:15:43 -0600
From:   Srinivas Goud <srinivas.goud@amd.com>
To:     <wg@grandegger.com>, <mkl@pengutronix.de>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <p.zabel@pengutronix.de>
CC:     <git@amd.com>, <michal.simek@xilinx.com>,
        <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <appana.durga.rao@xilinx.com>,
        <naga.sureshkumar.relli@xilinx.com>,
        Srinivas Goud <srgoud@xhdsgoud40.xilinx.com>
Subject: [PATCH v6 0/3] can: xilinx_can: Add ECC feature support
Date:   Sat, 25 Nov 2023 16:45:30 +0530
Message-ID: <1700910933-23868-1-git-send-email-srinivas.goud@amd.com>
X-Mailer: git-send-email 2.1.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|IA1PR12MB9031:EE_
X-MS-Office365-Filtering-Correlation-Id: d6bbbd35-057a-4064-2b21-08dbeda7ed44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NjcIhP+AJDRVD23BjQcpQeG4uJuulZVnB1s5ttOlZgiEtccCGfusCwPF8gv50eIe6rx65L9a40dsb2IfDatzCfJxPg3aZnMRvYv93lWZUDfDZnnKJD1zCReX710vUETBX5PYV2xnZicIPZMH2vGSRa10cLXjgNuTnhClZkT01RFwNxGvdloOV6QbnnY6hYYaxa4paYigMm05j5cjHGASwBGlqEOKXkc0raF+s5snSxGJ8AHodDm7z3eOt8Xa580TQrP77eZkHADwf40Yh+7BA9Siehb1uPsZkmECjsGMPqismMsHKDJj8mOALXMTFTL7INB4N8OZEQHbydbK/zB/iY7rJpL70yha79M9pi+pgFnWa+miUYQMvZmHwhlr9BrXrtjv6zSzePZ1On2w+lUplHtb6mNAVYkX+6c4Zl+RhWtKraL9DMf/5Kmpxq8pp99AOsAd0K+/bbEYh7Lr3Gk1P9dK7DvYsovGOxuwrI/sAeiBDjGiZDZ5UArGlnqO7kJkjmu1G7edWLUCiTNLPKYbtCWn5BlqtUQ2r1PmahOsWhcY9hHG89cEBsqsdrLrQqzzqC1ZJ/3MWRYE+jWzSqvjm03D+HNhcKvi3eYlCiXsAb5e2ML3eG63Dmu/kY3nxqRCjovcDYfc8Izcsm2raUJTE2LAclhmQwrqudVc6NIR7U1X1WZcrATX/fKzBU07PU0vUzSzhiiqvFGcX6vUg4iGNqJTFXYbPUbdonhOXg2mkaX/dRQdUhAr1RMO+qC4XQw22JaND1jIzt2f1NPxNQfDHQObtQEVCZatgQtrIqYtB/PswZmrJOlykeAjnwHrizDLmrRWhxv6X5tXW9ZVwhCmkw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(39860400002)(346002)(136003)(230173577357003)(230922051799003)(230273577357003)(64100799003)(82310400011)(451199024)(1800799012)(186009)(40470700004)(46966006)(36840700001)(83380400001)(426003)(336012)(82740400003)(26005)(2616005)(44832011)(8936002)(8676002)(4326008)(86362001)(40480700001)(36860700001)(47076005)(81166007)(356005)(478600001)(40460700003)(6666004)(54906003)(70586007)(70206006)(316002)(110136005)(921008)(36756003)(41300700001)(2906002)(7416002)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2023 11:16:09.8421
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6bbbd35-057a-4064-2b21-08dbeda7ed44
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9031
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Goud <srgoud@xhdsgoud40.xilinx.com>

Add ECC feature support to Tx and Rx FIFOs for Xilinx CAN Controller.
ECC is an IP configuration option where counter registers are added in
IP for 1bit/2bit ECC errors count and reset.
Also driver reports 1bit/2bit ECC errors for FIFOs based on ECC error
interrupts.

Add xlnx,has-ecc optional property for Xilinx AXI CAN controller
to support ECC if the ECC block is enabled in the HW.

Add ethtool stats interface for getting all the ECC errors information.

There is no public documentation for it available.

---
BRANCH: linux-can-next/master

Changes in v6:
Update commit description

Changes in v5:
Fix review comments
Change the sequence of updates the stats
Add get_strings and get_sset_count stats interface
Use u64 stats helper function

Changes in v4:
Fix DT binding check warning
Update xlnx,has-ecc property description

Changes in v3:
Update mailing list
Update commit description

Changes in v2:
Address review comments
Add ethtool stats interface
Update commit description


Srinivas Goud (3):
  dt-bindings: can: xilinx_can: Add 'xlnx,has-ecc' optional property
  can: xilinx_can: Add ECC support
  can: xilinx_can: Add ethtool stats interface for ECC errors

 .../devicetree/bindings/net/can/xilinx,can.yaml    |   5 +
 drivers/net/can/xilinx_can.c                       | 159 ++++++++++++++++++++-
 2 files changed, 160 insertions(+), 4 deletions(-)

-- 
2.1.1


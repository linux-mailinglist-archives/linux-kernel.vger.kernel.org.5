Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A997EDBFA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 08:29:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344862AbjKPH3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 02:29:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234630AbjKPH3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 02:29:49 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C81DD;
        Wed, 15 Nov 2023 23:29:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CMpjtVQVc7A8NOOkJar4gQdGe8zvJ6OXSd0HV4CXmBr/NFXw3veuRrtbEMarEPZPHgFF3AsH0/wtKJCgco9X1bcoZzBFXlfTRDEbC7EAKq71pZXTq9zXDpFL5tOU0k96cLiG6axfpaasex+hQ0YEG3OCzJgBPw3Di1pMqch5IoL9Fm6Hdfm8ChLuSxYw9vXzJjib2KNLn33SAEhwiGRbIBgwTp37MoJAKzqkqrcEAI3OfnoimdDsp21IDJlVAGAIgSEvhrhNVgZWwnv2uM16lGvJf1s6eHeMpnzsvv4ScmKEqy3Fj52lxeKeeaXfoEfN9c+d0ne+/tm3AFHDPPVDiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CxR8xMFAhG2TUHWQmLP3smlv1S3w+JMczYvoufXEdrE=;
 b=edO/V6bZCEw54Len8nlC5ak75C1xEsIl9XDpR/MlN4JHSieLbz2x0XRddyZtbXjWCFCheL/BoLd/PdYrDgAjocdwTm291Ip+9BV+shwWkplV1l9XT8M4NKEBmVerCB5CYqYBUGA2R/WIbzPblcrqkzLppRZ9Ae3/NEo+4NbN+tOo5LltdX4RYHCBQiUyolPEhSGJy5a0BvT9pIkYzeGiyTmst2JMEQtnPhXPk0gKjWY1iPtSzu01vuvGmDT9PvBSTTFD2v8YJmWFeFI4UEQUXH9zfoIMSAAnkzBSZVlkSaX2/A4hxF/efn49F/qufWl5WKmPUoeUvd6OutaEaOJpvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=sunsite.dk smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CxR8xMFAhG2TUHWQmLP3smlv1S3w+JMczYvoufXEdrE=;
 b=yrTk88OIoZZ4fXF+Cj33RZYBozU3J/fopsWnKoDkWuXM99gaPswkcTVNv4kKCBjbZNTdf85d/oG4tmvZCTpbvxDDPcMkmglW2kW/9PuS2UduagPc8T7agMUxpOOdBmT7ie6J74yVbsaZnWS39Xc02O2QNvuhXLZjH8LDoos37FU=
Received: from SJ0PR03CA0048.namprd03.prod.outlook.com (2603:10b6:a03:33e::23)
 by DM4PR12MB6662.namprd12.prod.outlook.com (2603:10b6:8:b5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.18; Thu, 16 Nov
 2023 07:29:41 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:a03:33e:cafe::1d) by SJ0PR03CA0048.outlook.office365.com
 (2603:10b6:a03:33e::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21 via Frontend
 Transport; Thu, 16 Nov 2023 07:29:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.20 via Frontend Transport; Thu, 16 Nov 2023 07:29:39 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 16 Nov
 2023 01:29:38 -0600
Received: from xhdsgoud40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32 via Frontend
 Transport; Thu, 16 Nov 2023 01:29:34 -0600
From:   Manikanta Guntupalli <manikanta.guntupalli@amd.com>
To:     <git@amd.com>, <michal.simek@amd.com>, <jacmet@sunsite.dk>,
        <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <corbet@lwn.net>, <christophe.leroy@csgroup.eu>,
        <rdunlap@infradead.org>, <airlied@redhat.com>,
        <ogabbay@kernel.org>, <linux-doc@vger.kernel.org>
CC:     <radhey.shyam.pandey@amd.com>, <srinivas.goud@amd.com>,
        <shubhrajyoti.datta@amd.com>, <manion05gk@gmail.com>,
        Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Subject: [PATCH V3 1/2] Documentation: devices.txt: Update ttyUL major number allocation details
Date:   Thu, 16 Nov 2023 12:59:14 +0530
Message-ID: <20231116072915.3338387-2-manikanta.guntupalli@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231116072915.3338387-1-manikanta.guntupalli@amd.com>
References: <20231116072915.3338387-1-manikanta.guntupalli@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|DM4PR12MB6662:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c0635d1-0fde-483a-ac6a-08dbe675cb47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2eWSPJPdtIxifjse3g+nzQ1NDF8QCg14GBzO6Jw8cjI/ADd//tNA7RvRyZdUFW1UFXZyVD8hyzxNew9MwYZRbt/SCPKs3B+5cmfrPi7TgiQvOKI1eICn3bZmgDBf0Gd18ERb8ZDGcpdbxmkuDbFSpWMKC6oRAWWb1nrfzXaQnGLFMdYC/NzjiI2r9ZMQbLBrvhZLxGJ0GV+UlVhpvobAkkGTM/U0p2H6ugzT+UIModjXTHP+Ka6T/T6oURp2HuAWtv6Y9gD1qd0xNZefgLtTyMdd1eiUkaMWA9GM9IGZgt6H2ey9sk6ubNaDPfnEQDrOfDK5cZb49V3TCwSEU1LjpJXB8mOW+/IiPiRjrrPJ3YeA3erLae2KBAqZO77e2WDICY/V0iwaF4/OXy41ygOZCxVl8nBLzAosRcgCq6rW8CuiI8ErReh+6bQGzX8x/zKa57Fh7DOsEt/PH0jYMuKNLDbkVm5VGkLRFeqX1cm4+4i2LiP8IXKncTmQM7q+ErQ8rrXzjYzrbo0sTdKe2dvpQNjWwOuukQs3CFFHbagWNWxdCZ0trKhbzcJ8tF1UYIqIC+umk5SsIY/FAuD52uCTWRvttYNbrb1vrsmzbthPmar0I/EZE5C0RZ0Fc58yTH1U33JqkAskdhhPq9pU95LMCGi45/j4WiZUlezSHB1/Kihtf4gHEqGOcImkiqQDWI1ZuYSkZ4nn/VbBW5lz+GlJp4BQe4QCThfDYByWP/t3+o/F2dRL7gAfmjLw2gg9BOpPSZGeHXYfxfw4Nyf8Sw3n8UMVFSffZmfAYJGHxb2FEL6jwrEqXQbBHQtiVs9nVByrsLpDI0IMIHYXn7SOaiLMlQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(82310400011)(40470700004)(46966006)(36840700001)(8936002)(7416002)(4326008)(40460700003)(5660300002)(44832011)(54906003)(110136005)(70586007)(70206006)(8676002)(316002)(921008)(4744005)(2906002)(41300700001)(36756003)(47076005)(36860700001)(26005)(1076003)(83380400001)(336012)(426003)(81166007)(356005)(82740400003)(86362001)(40480700001)(478600001)(6666004)(2616005)(36900700001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 07:29:39.7685
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c0635d1-0fde-483a-ac6a-08dbe675cb47
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6662
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describe when uartlite driver uses static/dynamic allocation for major
number based on maximum number of uartlite serial ports.

Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
---
Changes for V2:
This patch introduced in V2.
Changes for V3:
Fix typo.
Move description to above of ttyUL.
---
 Documentation/admin-guide/devices.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/admin-guide/devices.txt b/Documentation/admin-guide/devices.txt
index 839054923530..ae7431e317ad 100644
--- a/Documentation/admin-guide/devices.txt
+++ b/Documentation/admin-guide/devices.txt
@@ -2704,6 +2704,9 @@
 		    ...
 		 185 = /dev/ttyNX15		Hilscher netX serial port 15
 		 186 = /dev/ttyJ0		JTAG1 DCC protocol based serial port emulation
+
+		 If maximum number of uartlite serial ports are more than 4, then driver uses
+		 dynamic allocation instead of static allocation for major number.
 		 187 = /dev/ttyUL0		Xilinx uartlite - port 0
 		    ...
 		 190 = /dev/ttyUL3		Xilinx uartlite - port 3
-- 
2.25.1


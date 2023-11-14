Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5467EAD17
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 10:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbjKNJdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 04:33:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232369AbjKNJdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 04:33:33 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0F111C;
        Tue, 14 Nov 2023 01:33:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C/A3zqab1tcHeWoVodgha2R7UiV92ITzYucSgSlti8DHP10L4J9txSBNNMMGV02UwQPYawLp/x91nfCpMoFxnTADRlh/qH2fnDguRbLWUi/hBbMpdqaI0EzbgbOeV9DZ20kJ2xdlSAvy3Bxl6W7X8+aKGx7IBl3qNPdSxuUF4vBZPFXA7n4umNt76tRyDxGw9AX4JMOAEkGQ1ZTWvpZ6tMHlNbREfiiwnssi38FqlaYIWiCFGDoYnAZAPOYI0XjIQsqWAWBD7lWSiAe9GK/35ya0XuLGjlMBszJyYNfFau//7PsclIxxTfWa9d+tPPXUD/AsZNYhwW4+OugzfTVlsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YN+9zIbxJYVwBBnBE59b380ioHPB9hnguz01SImruDQ=;
 b=Go5O8PMDgBBJmrmDyHSIzEGjGxPJCQgboqDt3WJ3Jq9XBC8YHneSjI5QOo8dn4rW2gMdx9909HxGV6a0auEGArYV2OTJGopxLh34V7wbIw6RJ6bw6VAx9kS9aFoSZk5C2cvahQH/bZ1Jf5ZQSFPPk9vL3QmCUoQV7doFMEWaPkSeSJriHfkxO4G0ff2yLqoY+epXBf9YG8pl6tp60LpzJespklOB1xT3B30VFyB4LC6Lo2wtavrU+l36nWDo2qdyPHoqF0HG5rzlWuV3nXJVVUvQw1JpOkDucqGYAapVZ+Lqtz9EEOfWuS5irkoDN/rlBbi3whsW1a4hgizE5kqP4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=sunsite.dk smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YN+9zIbxJYVwBBnBE59b380ioHPB9hnguz01SImruDQ=;
 b=UQX57LlKig/SG5/fgHsh9hj3ojZcyA/huDTDbTSqvDUWJ3AcoDV19b61AvXzU5BUaySve/M01/rkryL7Qv0L35Im6WzWAeXqzGVw7ZwHvBBtXRfIGTPHUV35lDM6YrNOXZfcoC57MDHoWyAwvhyqtjJlfVVJ33duCb/NUIAGhAo=
Received: from CY5PR16CA0021.namprd16.prod.outlook.com (2603:10b6:930:10::27)
 by DS7PR12MB5862.namprd12.prod.outlook.com (2603:10b6:8:79::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.29; Tue, 14 Nov 2023 09:33:27 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:930:10:cafe::9b) by CY5PR16CA0021.outlook.office365.com
 (2603:10b6:930:10::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31 via Frontend
 Transport; Tue, 14 Nov 2023 09:33:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.76) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.13 via Frontend Transport; Tue, 14 Nov 2023 09:33:26 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 14 Nov
 2023 03:33:25 -0600
Received: from xhdsgoud40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32 via Frontend
 Transport; Tue, 14 Nov 2023 03:33:21 -0600
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
Subject: [PATCH V2 1/2] Documentation: devices.txt: Update ttyUL major number allocation details
Date:   Tue, 14 Nov 2023 15:03:02 +0530
Message-ID: <20231114093303.2718141-2-manikanta.guntupalli@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231114093303.2718141-1-manikanta.guntupalli@amd.com>
References: <20231114093303.2718141-1-manikanta.guntupalli@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|DS7PR12MB5862:EE_
X-MS-Office365-Filtering-Correlation-Id: d856ee46-da42-4f08-55a6-08dbe4f4c13e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TP/QadzqFRra85M48N55Q4YOKmqZSPXfNlv7UT9EV2IVDu4Hl32ZRnug84rUdgA+0q9MjZduhEw0vNmSPkFueZwA+yM8yFiUX0jA/5oR5ilwy4y8hI5qi16jcbiFIXansrmeimqDJRMk4NqP3zYr1Z4XykwK0n/QTvmMznllnVJfWK7jZVHC8vR+cZQUj6GARNmv18siN023CdzKeXJAUcvH9ZmsFVlOIQTTsGKw6xobfOqIJYqKxraXijQSvT8VczohKCA9wdE4v+ZBU44GKSPTa3cUcplkOa/wRBuidd4dwxEEMcSKt5y9b3mhhgzBcAMt1QXlpC++1ypNeNJuX7pssDdwBkU4MemI2CZRFMRMTa4YYamjacnvluYLM9OwN4X5HbIuS4YvEwZBSD+rxQCKMRxcoXaoAPywMTIow2ouxTgsnQJIF3s3el/0Vfhqpq+h97VMkgVdp4BzhHYag2LsDbw7J9mFq47dohGRRTFR5gINYWCstw6E99FQlycTtXqYgk2IApQHaZMfnLhpKYuo2Ctft7emq4j3tvAnCvco7CcqmMSiSz01PC8rLq1at7eClfRyhvP1uNRfLwYCyytC3TopFPKgzbphmPAtv9vY8yngJ0E03jA/Rlzzp/ErdgrXYkOkt0EpdhbpgOvSoJNkybDHDwBj3F7vV6HyfIVitGO9q4/Peuo7wi3CtizP2659+9QcdYxubJdPzOD8AadCKDEhN8Id1k+GkZ4DWLYhOKa+ni+RhTsLaHQXUP88qz1K1DL56LoMixCowHSMU428y/0/L7QJGbgUXi0wf/l0HACx9w26LeycRG63GIdrDLaHyx+MJS62oR69rdZ3CA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(376002)(39860400002)(136003)(230922051799003)(64100799003)(82310400011)(451199024)(1800799009)(186009)(36840700001)(46966006)(40470700004)(54906003)(70206006)(70586007)(316002)(83380400001)(82740400003)(110136005)(8676002)(40480700001)(8936002)(4326008)(478600001)(81166007)(36756003)(6666004)(356005)(44832011)(40460700003)(7416002)(86362001)(5660300002)(2616005)(921008)(4744005)(1076003)(36860700001)(2906002)(26005)(426003)(336012)(47076005)(41300700001)(2101003)(83996005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 09:33:26.7204
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d856ee46-da42-4f08-55a6-08dbe4f4c13e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5862
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
---
 Documentation/admin-guide/devices.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/admin-guide/devices.txt b/Documentation/admin-guide/devices.txt
index 839054923530..d2f2c9f436db 100644
--- a/Documentation/admin-guide/devices.txt
+++ b/Documentation/admin-guide/devices.txt
@@ -2707,6 +2707,10 @@
 		 187 = /dev/ttyUL0		Xilinx uartlite - port 0
 		    ...
 		 190 = /dev/ttyUL3		Xilinx uartlite - port 3
+
+		 If maximum number of uartlite serial ports more than 4, then driver uses
+		 dynamic allocation instead of static allocation for major number.
+
 		 191 = /dev/xvc0		Xen virtual console - port 0
 		 192 = /dev/ttyPZ0		pmac_zilog - port 0
 		    ...
-- 
2.25.1


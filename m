Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE037EDBF6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 08:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344012AbjKPH3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 02:29:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjKPH3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 02:29:40 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39159DD;
        Wed, 15 Nov 2023 23:29:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RmcoS2KLPNfTOEklFmJoZBqD5q83EYlENLQykkM6lN/xAHYCXO+7HZXQBT/qp7MyHtaSPspgQ7smDjT8f0Nfqqpy8kJiD8EMWCOsNZxTIkDaxO2uKr8pwcGwRdffs3ti/wGlVLlPZn05W2XW9G1uSF5fx9sBEWso8clracSvD3gEfnUOOcDGx/WgmuAWnyRjZ7oY0NqXfuEgpOH3FbAsbck1l+SDKWCe4u//HVNSwiPqHad6APxrNm4w0pVUFooRLtLrKj0Vxps4NAm7Ty7V+IjwC3DrksWj8cJw22AXy7wuGGkUndqitCMYTWUXL6MbMnE6lpLGxG3hpU3fkOZajw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sg80hLBx9qlagOVjSjIkFD9JuHO43M7YtQX4y8BEAtE=;
 b=Fu8CYAvvswbHkCXZK8flzafWerFWa+5U4woh36vBgDJ8gyJ+xRFYCZNA2Imbc/qP8s7BlRBOkiy7ASqfXIFMwjVddtN/vXhaSjMgNl47KPI0lZ5z2r8utpgDswR8otdDySChQ0IBzN9RLqqKEGxzRa0qdyKc00NqET7E/D9gTSEwaffHqTP0PStEey9wHd1haGmcPoXURH4QKhrZB1VuJOi4a68ZvXSn3uIwCJ5S7Z7LorFyfjKZ3XEgEGDT5qbvzYJY7XVtnRPVrzKoeelwMdNtkfPvLMQ1QbBSOErtBm3+LlB6PcfLS+vOrWPyY4nFI4X5xlGCF8PzP5k3g0fX7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=sunsite.dk smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sg80hLBx9qlagOVjSjIkFD9JuHO43M7YtQX4y8BEAtE=;
 b=kXK3pZOThBAbjCQVYXQf3iy+LdHv5oOoO7ukRTcuQ8UH/4yeCvWctbGI3P5xZxMiRSUwNenRfMaaDW0VpONgLc2x7kIPEvVYVTFITqCehmr/2WGWJ3heYvFse7wrkzS0VEDDs9ttBlv9mtQxF9xkTbeZ6Qvw3vMeWSboG0jkEcw=
Received: from CH2PR05CA0057.namprd05.prod.outlook.com (2603:10b6:610:38::34)
 by SJ0PR12MB6806.namprd12.prod.outlook.com (2603:10b6:a03:478::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Thu, 16 Nov
 2023 07:29:34 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:610:38:cafe::dd) by CH2PR05CA0057.outlook.office365.com
 (2603:10b6:610:38::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20 via Frontend
 Transport; Thu, 16 Nov 2023 07:29:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.20 via Frontend Transport; Thu, 16 Nov 2023 07:29:32 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 16 Nov
 2023 01:29:32 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 16 Nov
 2023 01:29:31 -0600
Received: from xhdsgoud40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32 via Frontend
 Transport; Thu, 16 Nov 2023 01:29:27 -0600
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
Subject: [PATCH V3 0/2] Use dynamic allocation for major number when uart ports > 4
Date:   Thu, 16 Nov 2023 12:59:13 +0530
Message-ID: <20231116072915.3338387-1-manikanta.guntupalli@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|SJ0PR12MB6806:EE_
X-MS-Office365-Filtering-Correlation-Id: bf32a324-5a37-433e-e1c6-08dbe675c71c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L0HHPMKejd++qAxcYXqn0Ca5RqDuUlhDw1H9M5J9ijbXUC97s2p79QFxV+NpIwdpwYSpQIMgraZOJOXfzdDuAH1Z2mB5a7oahLufXrqpSpjax6pjG/UfHbFedsC9ekIIvkt0VEhTLQ1d+/Nj6QiHNlHIzWqfINFr0lJ8Y2zivXDylyFHUisjamquF9ilEccDc/JD/9ZmxRH9HI59U5QX2UUldm+HORAZGimU52mTqaKqKnn3o47Yf4HYlwIGn0C/aUHoiQrOtj4bvZuCFTIZF/aVMe12WTR94TQCbhlmKuRtTvUM6KQlnuAkvLlGLbptX31AebyXrUuAnp3uSNdLNC2ANz1JoGyr86BTvGx19eZ1wK7MsTHCzuL3UBA08Z18djqvBoGa+N2mq8tKhGy8RtyW/mxM9iz8FbBxayb3SiH6ugzTWoivbXLTTEVOqsoOMXVj8yqJG/6XPTqMEKlJaFxYQtErYn+ztai6TV2VO76KIMJYpb/tki4Wp0sNb/6WOOZgh13ChNc7CaPatLaa2SbHXcqrwAkq01CsfMw4wFfDAaa0ItVDi2Kq3kWatj3wbTrRAGzmd3zm0NXSi2XEFmHRjk3wyPzgoHNS/5BmEXJ28ssiUJtmC2WyrxHZVlM0e28D5sqpfIDoPpPg/6qiWZyYRWvReoUA1FZ7w33/PQLVPUVnk2ug56j2cWK1d4oF9wg7W0q7sIe+OddRbDFgoOneP8Yh322EGFgItl9vdx79azMpZTdsuQtRYHPSp4pEVWYF+5VWmq1ITK/pR0iBsA/I2vRKMvkeupA1KliABIW/J03AJEtbxTi9f1U4kSKpysu7IEm4vDGyfU95BHi2LA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(136003)(39860400002)(346002)(230922051799003)(186009)(451199024)(1800799009)(82310400011)(64100799003)(46966006)(36840700001)(40470700004)(8936002)(40460700003)(478600001)(41300700001)(36860700001)(86362001)(70206006)(36756003)(1076003)(110136005)(54906003)(70586007)(316002)(7416002)(356005)(4744005)(5660300002)(2616005)(81166007)(82740400003)(2906002)(426003)(26005)(47076005)(44832011)(6666004)(4326008)(336012)(8676002)(83380400001)(921008)(40480700001)(36900700001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 07:29:32.8240
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf32a324-5a37-433e-e1c6-08dbe675c71c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6806
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

Update ttyUL major number allocation details in documentation.
Use dynamic allocation for major number when uart ports > 4.
---
Changes for V2:
Introduce 1/2 patch.
Update driver to use either static or dynamic major allocation.
Update commit description.
Update description of SERIAL_UARTLITE_NR_UARTS in Kconfig.
Changes for V3:
Fix typo.
Move description to above of ttyUL.
Remove parentheses.

Manikanta Guntupalli (2):
  Documentation: devices.txt: Update ttyUL major number allocation
    details
  serial: uartlite: Use dynamic allocation for major number when uart
    ports > 4

 Documentation/admin-guide/devices.txt | 3 +++
 drivers/tty/serial/Kconfig            | 2 ++
 drivers/tty/serial/uartlite.c         | 5 +++++
 3 files changed, 10 insertions(+)

-- 
2.25.1


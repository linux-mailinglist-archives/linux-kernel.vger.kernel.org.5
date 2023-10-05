Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B88F27B9E7E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbjJEOGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbjJEOEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:04:23 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061d.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::61d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8853C2754B;
        Thu,  5 Oct 2023 06:11:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gJ9cNH3O0DX0e3VvJnIzbvaZFW9/XTP4LIp4IsM7GHBWDrF5t6iQXlHATvZFZUtLRsiwqVDCUzUpVOn8HolvP9zPFpfIFAdD7dao16+YuYTbuxIOEbPGMtYNla2jvu/6N6AJiEuokS4Rl4qeDGZ2jgrlUqSl2AjnYqQrYn9ShU8vPZrDTz9bd2ofFY2ReAME8YFrZ10fHYz7O8naGvjPw+N8rtlF+lj2i+ww66Sp0e/18EKcA4Ce28ur0Tm38aG3TztfmmiWFOCfPRGIVrNmGVp4lbjyGmQnRA0pRyFYBVaJTH8fUKfMhyKJ691b7nxy6o+Ewj8f4ze8VfoZ12ATdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hnX3GY+UMWUJ7I9J9bGhVbe0a7Xsp9/YkMeWG4j92cI=;
 b=hXZ0Haw5XsdExQvr/xjSRqzEsY9tXH7wkQJGFN4khJR8ZJecns55Q5q+qbCA8P3MT/vPwiIw2e3SzB7qVNZZr/4EQyuBFmXekrFEGi5O/Nqi6eZA2zHI5eFMFmudzPjW5YE1FFpgD8PBWvoB/2ga7DMZUlo1KUmVCLvye0LRaF9yw7JtNhKH8FW5Yr1KS8iNVa0EK4n9KbfkDpUlAjmaURfCaUiUBxmGJ1NgyNF1MjH3HexNUHomuD7w7rIo20JOkEzMaQTmieOurCHBZ/c1xRvr4yWB7QXbg5P2npoGRfMM+ybNb0VRPVJCeL69iCWKG42yZA3wH0AuqZ8RNZnE9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hnX3GY+UMWUJ7I9J9bGhVbe0a7Xsp9/YkMeWG4j92cI=;
 b=2Qn3soMe5t4ztdgSmedTSqgfiwsbCebtkf/bsRJ8uagpA4CnHoYbBb9LE4Bb4JvvoEz/3iZ7ljWoa8qpngj7fK2Q9ZvxH7jMC/pLL8mbwgMPAdJBH7XX5Nc2SQa51d2HdpAbY+ufz2WFqplSfMlp//PdVSazel9CREeS5pHof9o=
Received: from MW4PR04CA0373.namprd04.prod.outlook.com (2603:10b6:303:81::18)
 by DM4PR12MB8475.namprd12.prod.outlook.com (2603:10b6:8:190::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.22; Thu, 5 Oct
 2023 13:11:04 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:303:81:cafe::f6) by MW4PR04CA0373.outlook.office365.com
 (2603:10b6:303:81::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.37 via Frontend
 Transport; Thu, 5 Oct 2023 13:11:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Thu, 5 Oct 2023 13:11:03 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 5 Oct
 2023 08:11:01 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 5 Oct
 2023 08:10:44 -0500
Received: from xhdharinik40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 5 Oct 2023 08:10:40 -0500
From:   Harini Katakam <harini.katakam@amd.com>
To:     <davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
        <pabeni@redhat.com>, <esben@geanix.com>, <jsc@umbraculum.org>,
        <christophe.jaillet@wanadoo.fr>
CC:     <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <harinikatakamlinux@gmail.com>,
        <michal.simek@amd.com>, <harini.katakam@amd.com>,
        <radhey.shyam.pandey@amd.com>
Subject: [PATCH net-next] MAINTAINERS: Update LL TEMAC entry to Orphan
Date:   Thu, 5 Oct 2023 18:40:39 +0530
Message-ID: <20231005131039.25881-1-harini.katakam@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|DM4PR12MB8475:EE_
X-MS-Office365-Filtering-Correlation-Id: 259475cb-6751-46a2-73d5-08dbc5a48727
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4PKvaW5IGuG6Pwt4xw8tau0cEKh4yivPWdwi33GWJavJbW62zwigBCAS0eBiv8yJYEPFW7Zq4sbsANc2+uMKIJijYve94xfWHVmTw0uMnGGETqAaAmopdAhkHkb51oXTK6ucXKMEbulAsOaOAC8O0RsYgrB9lq1Ek8zyCdXiDRRfDs5SmisP2lErmjwEEgX22IzX8LMsBHn+DsG5/8XuXKDkvpiPFo2GrTHG3bPRAyGKUMYRqfcI5pDl5TTRYxJZkdNFAjYdNdKaBFmLm1s6HywLzR9/huOG54k6Xn6wqIOi0hwaiIK5pGQi8UhdWTE4n6Nu90MhMCI5ck2CqpNR5xYvu7VFC912rSopyj32k90JMiSWJwBwm6aESqOVjSp9HOPNx75HenjapDWULhMOhMvMnsajd3H6FPAVyoWNsOIM3VgoWPuASOrBozTWS4o3tdUApWQ/dkeLqKQ0NHDL3B3o0s0AtQvXwc/nDL2OTApTWFRKTgf05cNDFcTHfTwNZ8uS+nW56lXabnFeC8sm+yiPNx4prkHOFNJ+gTZSRBEeb1SGhBkKxTFSHk/FfbPoVtqbWqEwWUuBRuuzH35U2fcNtnNBmufT/a71G0uLg30f8oDs4AoiHehHGA29BompIrTlSgSgNAoholv1Yzw4Dj0WjxxnuPLu6GRfx/0dNBcdlGOifI3XOCa94f8RpZ90txFCgndZYxKxRdBmTRi6AC5Va81PG4Nu2vXOL3gpnVrB/8lct6/fcW8bQQ5RWD4l3Wjs7KWCKllV5hhEHAO5oQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(136003)(396003)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(82310400011)(46966006)(36840700001)(40470700004)(40460700003)(83380400001)(4744005)(2906002)(1076003)(86362001)(26005)(36756003)(40480700001)(336012)(2616005)(426003)(478600001)(82740400003)(41300700001)(316002)(47076005)(44832011)(5660300002)(36860700001)(8676002)(54906003)(4326008)(70206006)(8936002)(7416002)(110136005)(81166007)(356005)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 13:11:03.4312
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 259475cb-6751-46a2-73d5-08dbc5a48727
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8475
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since there's no alternate driver, change this entry from obsolete
to orphan.

Signed-off-by: Harini Katakam <harini.katakam@amd.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 03011d7ee087..4fa34902d379 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23698,7 +23698,7 @@ F:	drivers/gpio/gpio-zynq.c
 
 XILINX LL TEMAC ETHERNET DRIVER
 L:	netdev@vger.kernel.org
-S:	Obsolete
+S:	Orphan
 F:	drivers/net/ethernet/xilinx/ll_temac*
 
 XILINX PWM DRIVER
-- 
2.17.1


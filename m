Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB247DB2FC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 06:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjJ3FxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 01:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjJ3FxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 01:53:18 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2389A9
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 22:53:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=McaGI3QeioRJGU+CZtmkRoILlocE0hZuIabzzp3uruWE40S/DcwGbceMpV6fnRXog60ZBEIVZP+1LahznqUep2eAHQZBgrjqAem9vUOrO6AQR7LGcEwxfbjTjmZtrBlRhFYVlYBxXxCmMsB6NEUyEcu7s2Hpocrx7WTRGbwLK7YFq0hv1MigOgpcAdhNpiChDbT0Kk6j6ullw+nDk3/1kfI569AXa2zF5L5yh2uv3lsSrQGqnwjBX45dNhXlCKi3j4lU1PX2gUVQmv+qZS/nsLoI4tzujHqhUrvUugMKTvdPQ/V483+K/MfVMCwoTspBwfTFzx1LpfV4ZAEbouZ71Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tPDTcQ6vbEu9o+8HC9W4VMXlWpRyQR20APUAYn2PD2U=;
 b=mNd5wJTwz2ggThMegpdBtKnmRnIUwD0P2VUHgmv2hweyMokQk/I3j1X9Ht1k6t4/eNlOGjYTWDnUn6+EPUPIZSWBRoUW7npe7D6yIYbr7wamB13jMsEC39uAt04rH3q2YLQCxCgV+r2ymqMQWb2zDA5ZRQMtLE9qP4lOKejMz6funmDknoYjc7shZnQeT2NpkP7TS3dWx/8TXirQdWb1owkehd4mFhcK/cOTkyqovTi480pkN2XL2kvW9ZeNpEkTMXOx8GjPrJFCAEqGRatA0bfvn1MN1Ytq8KlL0u8ridxaE1qaxFUKC64ddzkYYlVqulUMf6H6l1HkPoNiADbkNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tPDTcQ6vbEu9o+8HC9W4VMXlWpRyQR20APUAYn2PD2U=;
 b=lyy7AlKXL2xYhp54yqulqLLYuLR5i8Fg7+XhfUXwNYIIzq0sKERqXTvn3sfydLjvnkZ9SCaQIv4/PRR8dTw+iiWkoGXtBbViBObH2gHSnPkZnbQg8EuW2gvTwMnk90Z1Y/xF1kKBcqk2lzRn4EdvfX981PtPZ6a9sBU4Nn9sJr4=
Received: from CH2PR08CA0001.namprd08.prod.outlook.com (2603:10b6:610:5a::11)
 by CY8PR12MB7611.namprd12.prod.outlook.com (2603:10b6:930:9b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.26; Mon, 30 Oct
 2023 05:53:12 +0000
Received: from DS3PEPF000099D8.namprd04.prod.outlook.com
 (2603:10b6:610:5a:cafe::46) by CH2PR08CA0001.outlook.office365.com
 (2603:10b6:610:5a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28 via Frontend
 Transport; Mon, 30 Oct 2023 05:53:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF000099D8.mail.protection.outlook.com (10.167.17.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.18 via Frontend Transport; Mon, 30 Oct 2023 05:53:12 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Mon, 30 Oct
 2023 00:53:12 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32 via Frontend
 Transport; Mon, 30 Oct 2023 00:53:09 -0500
From:   Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To:     <michal.simek@amd.com>, <gregkh@linuxfoundation.org>,
        <nava.kishore.manne@amd.com>, <tanmay.shah@amd.com>,
        <ben.levinsky@amd.com>, <marex@denx.de>, <robh@kernel.org>,
        <dhaval.r.shah@amd.com>, <roman.gushchin@linux.dev>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Subject: [PATCH] firmware: xilinx: Use proper indentation in kernel-doc
Date:   Mon, 30 Oct 2023 11:23:01 +0530
Message-ID: <1698645181-2874487-1-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D8:EE_|CY8PR12MB7611:EE_
X-MS-Office365-Filtering-Correlation-Id: b8c1eb16-b314-4d46-5f23-08dbd90c80ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yiR0DoAHFE0kc8tCkfCN004JuCqgxSZWLrMoAQ+UCv2ccB0EKyfbvhpUYdFohb3i+GlRz03E1yBBBTncjnwhzbckIU0jhucBXw6LBHdoDJxmZkqAf5nNIYXwfRYzNcu2wjUZ6qjCjA5snPrr2x+OhMqniRLvuUDYSGEHzG0CznTU/1ADFCduIGA0HxB1NSGoiNyHSEA6pPQwVw3yKv0EM68hVk+YosVRHJ6M1V1cV3Uk0mkA3i/LPNj/4bNCaY1ZYiHdgUDVTvIxXxssd6YJcHkSZEEHi2QWaCPnKhS4Zh56poj3Vt1cVHAlSZfbRNkd4hz2KnYuU1Djo9vcOhfBKuANdI2y8sSLxG2ZhsTZLhD3c8/+rxKXIijdOhIrIHMo5bgSRvU/7Fd+n+fsNNy29M5gTMXXq0vG8SUkLAYAG3XlE60EgDFsKPV2HZDa84vuZEtFAsrnrrnj44LgWKxodQQ2Q9uc2ySmer5OV4d0XFK5c/BZbJt4z0raeUuRstO55syzJ8oZROHil1sxkqXpAdZKkglbgXrQE2ZA7N7y+7FZM6F0qJ161HCXtr8G81h0ynnYE3ow61NJYIntS34v6AGgANnuPjGdTgP2OD7PTMv5VrtOYg5slxGZg/jJMvvgEdS0Tw7i941toLr0Bf6ZRuxc8s7hfz/tswLEBjXchZgyTB/pBiNdA98Vv6EUlpYhy4TF8fJKTAzr0E/7zpOQ4I+sQsqWUATWUXJcMJEVFkr+m1RatnZNLkuJ/NriazzcE01IrKkyIB/zSKG4Mp+WVw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(39860400002)(346002)(376002)(230922051799003)(82310400011)(1800799009)(186009)(64100799003)(451199024)(36840700001)(46966006)(40470700004)(2906002)(40480700001)(316002)(40460700003)(36860700001)(47076005)(54906003)(356005)(82740400003)(81166007)(6666004)(26005)(110136005)(478600001)(83380400001)(70586007)(426003)(70206006)(5660300002)(2616005)(336012)(41300700001)(4744005)(4326008)(8676002)(86362001)(8936002)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 05:53:12.6119
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8c1eb16-b314-4d46-5f23-08dbd90c80ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7611
X-Spam-Status: No, score=1.8 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Simek <michal.simek@xilinx.com>

Use tab for zynqmp_pm_load_pdi() arguments doc indentation.
No functional change.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
 drivers/firmware/xilinx/zynqmp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 4cc1ac7f76ed..80d6e6a8cf38 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -1395,8 +1395,8 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_set_requirement);
 
 /**
  * zynqmp_pm_load_pdi - Load and process PDI
- * @src:       Source device where PDI is located
- * @address:   PDI src address
+ * @src:	Source device where PDI is located
+ * @address:	PDI src address
  *
  * This function provides support to load PDI from linux
  *
-- 
2.34.1


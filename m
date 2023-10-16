Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C0C7CA6C1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 13:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbjJPLag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 07:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232649AbjJPLab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 07:30:31 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782AEE3;
        Mon, 16 Oct 2023 04:30:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QkyET5IDNdZttaZz5zJsBcg9/EcZDLMdCSfV6esKS2MASCPYzTxobzfWdwcfmFSC+p8u0btAZsiJyLNI+HJoQK6FS+wvZxVrvIHXm1nIeNwNMXIAKXm0nSUi5VSW098iLqwN8/Z+WbXYTEpzu79Hs4Zzjw5V6CQlJyxSJ2eZhyh30jMn7AO7nH2RV6QSYs/ibWncnHhmx9Ew7/r+5npV1TyJPE/ouXnwx/gr1a8V0FqDiGU1SpWOobq0f+bhYMuCpGaoReDtU7XguoGcrtMbtHWL4BQhUIfBH1oRI7uQnEwOvDgAyVJc1TLvdu4dPUmCyiFkl9whj6/3ljyPuBhRJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GN4yVn9esUyFcQcbMxFoKgdLb/vw51euHpR+9+X+buo=;
 b=K09ZqKR+sovqLJw8ZBE5emHChTbiuaaj7vYDYKTw6bXm+wUxISLxlR0N2J5mujyp9dFyQJzVtxis9uvOBmYHJsyO82EYa6y03C/68d9iItKSzqMT7N+7VvRctTH78Ht+499iuKUenjeJ+O47Ed7nf4G5nevjDwJ8MbpPMIOMNytlKdJeQeBa7k+eYn2JNdwz5lGC2W9/x9MseMWEm6t8plFhHO1d7uqbsRE+BIKXg84soHK7hlKb7eyLRULzYuhW83Ngg5tGiSfGgG+3XGUZxRM7GhDH5lWQjdjwCP5T+rgkl06hAoGW2XuLlYjFmTkQaGt0MYeVGRID0TFAr3Sfdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=baylibre.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GN4yVn9esUyFcQcbMxFoKgdLb/vw51euHpR+9+X+buo=;
 b=TvLbHosi70HNf2be14zrv6vfYG910jwbEvSLTR6yDmPV8q7JkeuCyMKIhxowHBBwYzRNP/GCSoNiLDqCkF/K6+3xUjo9m5TU4maAjfu1QqzDj11h8ScsdyDCpyLR69bMikku3BnpaP4GjxGqcOlleYFvspJTZW9mUai3TgbieSM=
Received: from CYZPR20CA0020.namprd20.prod.outlook.com (2603:10b6:930:a2::25)
 by LV8PR12MB9229.namprd12.prod.outlook.com (2603:10b6:408:191::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Mon, 16 Oct
 2023 11:30:26 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:930:a2:cafe::b4) by CYZPR20CA0020.outlook.office365.com
 (2603:10b6:930:a2::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35 via Frontend
 Transport; Mon, 16 Oct 2023 11:30:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Mon, 16 Oct 2023 11:30:25 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 16 Oct
 2023 06:30:24 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 16 Oct
 2023 06:30:22 -0500
Received: from xsjarunbala50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 16 Oct 2023 06:30:22 -0500
From:   Jay Buddhabhatti <jay.buddhabhatti@amd.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <michal.simek@amd.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Jay Buddhabhatti <jay.buddhabhatti@amd.com>
Subject: [PATCH RESEND 1/2] drivers: clk: zynqmp: calculate closest mux rate
Date:   Mon, 16 Oct 2023 04:30:01 -0700
Message-ID: <20231016113002.15929-2-jay.buddhabhatti@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231016113002.15929-1-jay.buddhabhatti@amd.com>
References: <20231016113002.15929-1-jay.buddhabhatti@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|LV8PR12MB9229:EE_
X-MS-Office365-Filtering-Correlation-Id: b91e0025-6529-40f7-e0d7-08dbce3b4ac2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6/BNh4ah0V3Go8+Ow5EbE1iP0RDdcqeRQA526vDaQ37IrKC3pueYDGQoJ8KD/R84W6KPEAbRn7fGQiWNrD0YjOIyemrxePH0KAEc9WLKDK99bK+83s4yIu94r/xjR5oIQ/rFYhyiytFoSaAt8+CoDJdZCXxGlJFadnFUTBwr6BfzKXuNO6yKKUlj8MnpRjBw1aw3U+Q5oxinWHMAWNj1dzRrHTY4HqzjwxdUYq6zfTm4jylzXljtlArW2VHIIAX7OOkLTYgk4nWBT9yyU3GeEJsvVB9Sn0A5j+SQvZsvz2D1JeRhrDS3LbWl9cENsBVScNFeF8vbFBv4xuECs10zgKWfN29m7HtZoPZ2VqSyJ4dCcePrt+VRjW8kbb2lQPSEgQ62X7J/gecEbrCX32GCGGmGbLeX4zplnlZYqRbrvEBfZlK7dx4XJQnBxxJkAo4VpWhu1BTD4EW2nUDl1OS9e+n8WM8nnYgGBZXxUJEEaLB0eu0hXLgXzlQYoqOdWTHATWTRzrx3Xt4g9KPWTJ71oRL7IpHuFUi7lk9N2Fgk2tWEK5roPucFcjDy/KkHTq/QymljpPiumbkGQXPTyiiZ68A7kxGuzs01Vr/WpGKsVoHdc11o65+VrQ68zu3xJoZmBR7lHnQ9S6HAmoce/tGzwaHrcLxYnNGy42aqcGYCZcx2aHeuyC2BLHBHHgPHT5ophuYb3PUmxcXNzgOBc+pU5esPDmFQ4QqLCmxAXd/lOXIvlP+Tpm9mYChdkoWE7jOBVytP6+HJIq/IGoOZwz4Psw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(346002)(39860400002)(376002)(230922051799003)(186009)(451199024)(82310400011)(1800799009)(64100799003)(36840700001)(40470700004)(46966006)(36756003)(86362001)(2906002)(1076003)(40480700001)(44832011)(41300700001)(110136005)(478600001)(5660300002)(2616005)(6666004)(40460700003)(70586007)(70206006)(8676002)(316002)(336012)(356005)(426003)(4326008)(26005)(54906003)(6636002)(8936002)(81166007)(82740400003)(36860700001)(47076005)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 11:30:25.4641
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b91e0025-6529-40f7-e0d7-08dbce3b4ac2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9229
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently zynqmp clock driver is not calculating closest mux rate and
because of that Linux is not setting proper frequency for CPU and
not able to set given frequency for dynamic frequency scaling.

E.g., In current logic initial acpu clock parent and frequency as below
apll1                  0    0    0  2199999978    0     0  50000      Y
    acpu0_mux          0    0    0  2199999978    0     0  50000      Y
        acpu0_idiv1    0    0    0  2199999978    0     0  50000      Y
            acpu0      0    0    0  2199999978    0     0  50000      Y

After changing acpu frequency to 549999994 Hz using CPU freq scaling its
selecting incorrect parent which is not closest frequency.
rpll_to_xpd            0    0    0  1599999984    0     0  50000      Y
    acpu0_mux          0    0    0  1599999984    0     0  50000      Y
        acpu0_div1     0    0    0   533333328    0     0  50000      Y
            acpu0      0    0    0   533333328    0     0  50000      Y

Parent should remain same since 549999994 = 2199999978 / 4.

So use __clk_mux_determine_rate_closest() generic function to calculate
closest rate for mux clock. After this change its selecting correct
parent and correct clock rate.
apll1                  0    0    0  2199999978    0     0  50000      Y
    acpu0_mux          0    0    0  2199999978    0     0  50000      Y
        acpu0_div1     0    0    0   549999995    0     0  50000      Y
            acpu0      0    0    0   549999995    0     0  50000      Y

Signed-off-by: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
---
 drivers/clk/zynqmp/clk-mux-zynqmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/zynqmp/clk-mux-zynqmp.c b/drivers/clk/zynqmp/clk-mux-zynqmp.c
index 60359333f26d..9b5d3050b742 100644
--- a/drivers/clk/zynqmp/clk-mux-zynqmp.c
+++ b/drivers/clk/zynqmp/clk-mux-zynqmp.c
@@ -89,7 +89,7 @@ static int zynqmp_clk_mux_set_parent(struct clk_hw *hw, u8 index)
 static const struct clk_ops zynqmp_clk_mux_ops = {
 	.get_parent = zynqmp_clk_mux_get_parent,
 	.set_parent = zynqmp_clk_mux_set_parent,
-	.determine_rate = __clk_mux_determine_rate,
+	.determine_rate = __clk_mux_determine_rate_closest,
 };
 
 static const struct clk_ops zynqmp_clk_mux_ro_ops = {
-- 
2.17.1


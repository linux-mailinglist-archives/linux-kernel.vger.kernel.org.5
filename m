Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD1980F63E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 20:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377212AbjLLTMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 14:12:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235267AbjLLTMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 14:12:47 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98674EA;
        Tue, 12 Dec 2023 11:12:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R5tkyxAxGoOgOiJzf4OBARrzLDA5uPbf/MizYiccePYUIkO6fRJahFt/+f6AquzT/txTl3/i6PdrrhMhOTK39R49T8UfSsdBsSEqK98r89C0Yj2KRR6wZQLWGbQIyAR4W6Snk65HiKI1u851aBWH0R5ZkJu7fmExFAONhmOUxN76NogX49vb+fFNr+48cCXWkBmzgUC+w5qNuUqhq0Qto4k2AmzHlyhN9vPT2sheqWo1gB28XYLuBb+qyu3wmpY6vjUAMxHHiz+KKfF+PJKe2asCehBfNuPEWznxPJXOnhWpRkqsym74T9VaadUVAjS6bemHB89qoqRYlDSmvOBu6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bQZEUEcsAihho8q2jE6fb9Zp2WDLdvI1gr2KcTRApts=;
 b=LSPUah3rJc2ggNK9iyerR2DAHPpY9SYxMSjJLD4YC4jvNm/MUCIErZfZktpKf6pAJPX/cuSbwtWi0VeLIT3Purqwh66ZY2B2oLbBOd2qnVayr+i6djb9PdFh0caHmTA8b7/axlg3NU4mq4v3N3otQBF70fk1ObXlf/h0nBl8t9fGEZdUXpnUHDw8E7mtWUvGyIkz/IqGXmOVWpPi2anhyo/tL26D4fhVpBPlm4qcvm5CdYmqgDvsrYxLBwJuFKE+7gTijLdnAPIi4pjS8kFZOatjX9UdCoaEB6E2U2UFnNh8CZBCiWeBCbqByESEKuc92RguXTFfwi8H+rvUl3b3tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nbd.name smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQZEUEcsAihho8q2jE6fb9Zp2WDLdvI1gr2KcTRApts=;
 b=ku5sD/dErdPUYmwIoCuemes+8DVM4g7wUPSOcgsJN/NXirDpgukuV+6Ycx2jvAInAJGqrrf3uJQHVqi43dAhQc4Vas4lfkhtpG8JtjSiFS9pwySWzuw6UvazJF4kQpZBkBaaGmnD5dPMKzx2jyKPPvUt7xAmUtsGHfcS8UkZg90=
Received: from DM6PR10CA0036.namprd10.prod.outlook.com (2603:10b6:5:60::49) by
 DM6PR12MB4957.namprd12.prod.outlook.com (2603:10b6:5:20d::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.26; Tue, 12 Dec 2023 19:12:50 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:5:60:cafe::fe) by DM6PR10CA0036.outlook.office365.com
 (2603:10b6:5:60::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32 via Frontend
 Transport; Tue, 12 Dec 2023 19:12:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Tue, 12 Dec 2023 19:12:49 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 12 Dec
 2023 13:12:42 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        "Ryder Lee" <ryder.lee@mediatek.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Kalle Valo <kvalo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Deren Wu <deren.wu@mediatek.com>,
        Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
        Ben Greear <greearb@candelatech.com>,
        "open list:MEDIATEK MT76 WIRELESS LAN DRIVER" 
        <linux-wireless@vger.kernel.org>,
        "open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 2/2] wifi: mt76: mt7925: Disable powersaving by default
Date:   Tue, 12 Dec 2023 03:08:52 -0600
Message-ID: <20231212090852.162787-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231212090852.162787-1-mario.limonciello@amd.com>
References: <20231212090852.162787-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|DM6PR12MB4957:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d878ad2-65bb-4afe-550e-08dbfb4654ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: egKSY5nqVqEqmDjkJeJ14v9dhsO15aPR0Xacp1xgb3/PWk2wHUuikcCAFwbLLBRcJQ/MRcbL9RhUu+N3dWYsebZaAp5ikVd5UeNRi88VhCjcHXYTWS2WdoMzBc0Rt489BWWh7DsD/gcc1HWndEzvNqkELt7/ojNWjJdui3zhbTDNuWKRVJRWFnGe94EsFFrA37ZeimXpo9atxS6urw8hwDT+gcXIpgCaU3cezZxNMHP6W2Bdjj6qMnpiH+8tMqRRp6N1xEaH6OnJxlFGU88b1kZZXcfJz600ixEDdg2M7D7jRQpG1o4Pl2NhjnqviuhvKoFNn5+4nPreqofOPrDMpJKU0/1CRgyYUDdj+1MH81ZawUPNzO37/pb9YaCZAAJ/hKegXPRllW69R1Zt2e/POnV83A8ltqV6KgPfQlYUTcxVZlXl4zcafnvrJHRbFBHTMCabqHsx3FxI4f2/+y45G8iiGVE77z77w8B6cxwaNJkzvImjSJkS4LVTo0h5pYw8RJ2dqdMXCBcX5nr+H59yYxb1/apFn4z6PTmPJbPHnmu1COaxeZBFsim5cXHb+QHeTyoVAWgmuJRLr/NpSsYtnSkQTrYFZ/jUP9sI+deLkyhd/NyY/pkqXdxfigP/YuUIkawyxUdQy/t6cO1Cb6kRkD4cIqrTM2BKYrflgbxZLsaEQTgiFY6KBkD+YuY5n4hX7llN3Ep5EqtuOGQ3lrvuamBsb1n8tER1krmVxuAzVPlYiwczuhD9ZFzJlUcgljDeSroxMtliTO5lkWioXC4PQQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(136003)(39860400002)(396003)(230922051799003)(451199024)(1800799012)(82310400011)(64100799003)(186009)(46966006)(36840700001)(40470700004)(40460700003)(26005)(110136005)(426003)(336012)(16526019)(83380400001)(7696005)(2616005)(1076003)(47076005)(36860700001)(44832011)(5660300002)(4326008)(8936002)(8676002)(7416002)(41300700001)(2906002)(316002)(6666004)(478600001)(54906003)(70206006)(70586007)(36756003)(86362001)(82740400003)(356005)(81166007)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 19:12:49.0792
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d878ad2-65bb-4afe-550e-08dbfb4654ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4957
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a module parameter that would control the power saving
behavior.  Set it to default as disabled. This mirrors what some other
WLAN drivers like iwlwifi do.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/init.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/init.c b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
index 8f9b7a2f376c..370fe26d592b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
@@ -7,6 +7,11 @@
 #include "mac.h"
 #include "mcu.h"
 
+static bool mt7925_powersave;
+module_param_named(power_save, mt7925_powersave, bool, 0444);
+MODULE_PARM_DESC(power_save,
+		 "enable WiFi power management (default: disable)");
+
 static void
 mt7925_regd_notifier(struct wiphy *wiphy,
 		     struct regulatory_request *req)
@@ -184,11 +189,13 @@ int mt7925_register_device(struct mt792x_dev *dev)
 	dev->pm.idle_timeout = MT792x_PM_TIMEOUT;
 	dev->pm.stats.last_wake_event = jiffies;
 	dev->pm.stats.last_doze_event = jiffies;
-	if (!mt76_is_usb(&dev->mt76)) {
+	if (mt7925_powersave && !mt76_is_usb(&dev->mt76)) {
 		dev->pm.enable_user = true;
 		dev->pm.enable = true;
 		dev->pm.ds_enable_user = true;
 		dev->pm.ds_enable = true;
+	} else {
+		hw->wiphy->flags &= ~WIPHY_FLAG_PS_ON_BY_DEFAULT;
 	}
 
 	if (!mt76_is_mmio(&dev->mt76))
-- 
2.34.1


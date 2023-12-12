Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 387E580F640
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 20:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377210AbjLLTNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 14:13:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235211AbjLLTMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 14:12:50 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4C118C;
        Tue, 12 Dec 2023 11:12:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UHlzv5CRBlkPupsH/14SrWQ/fa5izQhvrwpStP4w0O1rNpe0SurUr3aWyiQaLM5rtvfxW85zbOnD2kF6om2u1xM9NVpOZ/+ho0QZ2COfZYm+JRZ2Slk9SqxaBO3WuA/AuBiKD/mo/OwIHIUf1tmaSQu4+qgZw4i1nNstwm5PBmBbA88yA8phC5HNQW6nHwhaA8s3V7lF07aNI4koHXHzS61yp2jGYZaQYTwJQtXbk7bl4NUt+BYEbnWJYMAl3WYj3LK3cw7UYZpsD6Z/X5Ksz5c0p60Fsui9VOcqw5Wydw8LKyrdXMzUlSH1yAC2fGmJDUWdPrIet8BgNIFL/ZwGqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fcgbQM4ALqnSs6ru3rO50qX/lNt2lNuPpIMGk5S898c=;
 b=Nz746+Mp7nW05OWnp/mKwDvc4Y+qI4tm4+Lkwo943CV5jtLCBh9ybXpo+zMP5Ijtm7Q13dYlDvJW1Kq9Ax21OmcrKRThATnSh807tFdDKRR8mWRrlR8sRHoKQheuSXogsbhxyrUiBEVaPF1nF3icjO7+gq0mCW8by7d6tDBQg0bK2IZiMxh8Ezy9qsMiRFaJ1kLjDiZ/vxzNWS0bLGkznln1o4YyBdvf+AV6KcSvQMsk3CxVCKx4Gj8Pa44WgBipsjJR45GtS60mkpBA+yPfYcBcRgvQzeunQ57WUqptJ3QB67L91LOZOmKABpxoBYCy6tDWFcJnOoxMwUk/qt0xhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nbd.name smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcgbQM4ALqnSs6ru3rO50qX/lNt2lNuPpIMGk5S898c=;
 b=1Nr+IYxyz0DnPWXOWYcpEOKV5RtEdo1+0gMOD9U2i4BOZ9aeXWjhwVX9aMMa4fM+hwhfs3cSLjhrbnN46wQ5oee55l35wdkSo++tcSNOU+fAG//nR+iffNOiHZoFT13V+HR9ijvgYbf/UTkh1fLJIBGeh8hQ0tAIWMdjeM1VKzI=
Received: from DS7PR07CA0011.namprd07.prod.outlook.com (2603:10b6:5:3af::22)
 by SJ2PR12MB9114.namprd12.prod.outlook.com (2603:10b6:a03:567::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Tue, 12 Dec
 2023 19:12:49 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:5:3af:cafe::2b) by DS7PR07CA0011.outlook.office365.com
 (2603:10b6:5:3af::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Tue, 12 Dec 2023 19:12:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Tue, 12 Dec 2023 19:12:47 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 12 Dec
 2023 13:12:41 -0600
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
        Mario Limonciello <mario.limonciello@amd.com>,
        Sultan Alsawaf <sultan@kerneltoast.com>
Subject: [PATCH 1/2] wifi: mt76: mt7921: Disable powersaving by default
Date:   Tue, 12 Dec 2023 03:08:51 -0600
Message-ID: <20231212090852.162787-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|SJ2PR12MB9114:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c414a05-002d-46a9-074b-08dbfb465403
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jzAtQM6Y4rNn0KFUE0OGZJ1JJ7Ye26l611QesZ1JWjrygUv6Tcv6JOi28qpqXy6oBTe7j/gbNbbEafZQZsz3VbYAx5NTV3DrwlVrYkzyGu9pIC64WtEeuvvnK2jQ6zEpY1FR+BbskUG8bwqs/YH0uk0sid4fE3bSIscwmlIzBTlfIbh+ix3GdZDfDqOBt+dG5uK5k0TLxdGgBm+0dcezy2KrdD8LlTTFquEQd0hTCSPQPOz3jbXbgMfvRyAgCLEx+yRBv7tgG/BDxzIkHp3CkN8I4Vm6s4b4tIeBGepJQlYeWX+Hittskv2CR6bo2d+hOrGRTu3CvvPv9fYsXmAZQLdF+cfv4F9I4n+4jjA18Vtl3025q/Gal/GuW1ZFacsbg1IWZ9KOtvAeRBVLRc1ZU+qSblBW8BhefFjeuNz47RLH8xsVSlWGq8iaXEoZ/aszznJyJONS+0JtwRhyyxxVzSjPkdk/utxhF/vi5hpOLRNf1+X1CLLdW2u06diw1Ea0+5DZBsl6AQQ+ySpkReQ7jliysMoqxDIfM+AfZQqecU2qot4KIwoHv+TL7XWKSWqnDfPsv/Mifhy3y4BxiRneXfgIo4QHcJ9v2JAsHnJ59ElNaGumpNQeMZIkzNTJ9KzbFx+33KFI+fYkoyX97156SdZKGHZgXHFxNkKSDoXbEMjGLHe8hoUeKvSzN4rsUQsUs1zhX/qwP6Bp2OuEdRkkMXBTPBC/iFUUVqIDV9BKLFkGeIilNiOk+NxpBOLRb/Z+
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(39860400002)(136003)(396003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(82310400011)(36840700001)(40470700004)(46966006)(40460700003)(2906002)(7416002)(41300700001)(36860700001)(110136005)(36756003)(86362001)(82740400003)(2616005)(81166007)(356005)(1076003)(336012)(426003)(26005)(16526019)(83380400001)(7696005)(47076005)(478600001)(966005)(6666004)(44832011)(54906003)(4326008)(5660300002)(316002)(70586007)(8936002)(70206006)(8676002)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 19:12:47.7886
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c414a05-002d-46a9-074b-08dbfb465403
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9114
X-Spam-Status: No, score=4.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FORGED_SPF_HELO,PDS_OTHER_BAD_TLD,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLACK autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several users have reported awful latency when powersaving is enabled
with certain access point combinations. It's also reported that the
powersaving feature doesn't provide an ample enough savings to justify
being enabled by default with these issues.

Introduce a module parameter that would control the power saving
behavior.  Set it to default as disabled. This mirrors what some other
WLAN drivers like iwlwifi do.

Suggested-by: Sultan Alsawaf <sultan@kerneltoast.com>
Link: https://codeberg.org/Hybrid-Project-Developers/linux-tkg/blame/branch/master/mt76:-mt7921:-Disable-powersave-features-by-default.mypatch
Link: https://aur.archlinux.org/cgit/aur.git/tree/0027-mt76_-mt7921_-Disable-powersave-features-by-default.patch?h=linux-g14
Link: https://community.frame.work/t/responded-strange-wlan-problems-with-kernel-branch-6-2/41868/4
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/init.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index 7d6a9d746011..78d4197988c8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -10,6 +10,11 @@
 #include "../mt76_connac2_mac.h"
 #include "mcu.h"
 
+static bool mt7921_powersave;
+module_param_named(power_save, mt7921_powersave, bool, 0444);
+MODULE_PARM_DESC(power_save,
+		 "enable WiFi power management (default: disable)");
+
 static ssize_t mt7921_thermal_temp_show(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
@@ -271,11 +276,13 @@ int mt7921_register_device(struct mt792x_dev *dev)
 	dev->pm.idle_timeout = MT792x_PM_TIMEOUT;
 	dev->pm.stats.last_wake_event = jiffies;
 	dev->pm.stats.last_doze_event = jiffies;
-	if (!mt76_is_usb(&dev->mt76)) {
+	if (mt7921_powersave && !mt76_is_usb(&dev->mt76)) {
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


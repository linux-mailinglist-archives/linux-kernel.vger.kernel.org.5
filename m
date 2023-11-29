Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779027FD20D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 10:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbjK2JPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 04:15:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233171AbjK2JOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 04:14:45 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E3510E4;
        Wed, 29 Nov 2023 01:14:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bzlyTDY5xSR/g2IpngCwxosfuGK17lIjoSAZTz5Mi+trEI6/qUxce5/C7RgK4WqhVj98jnweE/ZgT9m05ISKD9GOwXeoTFpZGgVOkoeyUW+rGce97h4yeSBuVjm6vII8bmnR+wqrdmxqm9o7+aOW3yLl9rGJbhUB7qRR9fICvzqvzOlODskJ4VuqM5wFC56Lbg1PuEkpm9fjNILytPqJs73i4D2DN0frS4aWA1N4BFgXhp1lUiTRe/+0+J0ck+H0c8fjjwS4173HiTKbzH0Cl+JsB/9vTMjqX//ximqfG9jFDCuf3mTEXTv3aAFqPGZLsMxpK6fD+bEDJlBc2VyY9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bttUKqwJUPN6jJABYzXAVbvz0oMxc1gHVVluGh6R+j0=;
 b=GvB0WChiLmB4/OLmahkxMpkTNYzN3+uC3oWxnUPHpJ+Xnv2Vtyr3GYdXwTL69DiI9cp3C+ky4ENEN+nVbCX4ZPbflIuvsrbux6uKCkp+HMB7Vm5J32+6uZ3riRUXYCkl1IZfite9poz7I8fgXN/eZij7/WDPUCrwlCilWmWGbeoqEWXOZCleJX/lv1EKnmK4Psl6hOYfyL5rc8VXTIlt6UPUpibcqkSrSKjbJVINzkrBv/r1tkkj6BXj3dGToUhVXsIOyfEs3S/BVIiBChfpkvikAoac7tDn67ap6BufsMHh/TpebLgMvE0U1O/ZEJtMhiulHwmZSntRGY/p7Rje0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bttUKqwJUPN6jJABYzXAVbvz0oMxc1gHVVluGh6R+j0=;
 b=Xv9UV82R2mpHglioXAEn0Cw8Vv7d7TaFpjaR25+KzZOFLtHhWEQ2uK/Qa/4ZvzwnAXzU4DL/Ty0Dz22pptyOwfZCh4mibuCa9uajrFqGaeuKrBO85cGhkj4KJDxKRnYj3rRvTy2Hzq1+E7N7Qjq8gDV07bh0Rfv9bx1LQlF65gw=
Received: from BL1P223CA0030.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::35)
 by DS0PR12MB7996.namprd12.prod.outlook.com (2603:10b6:8:14f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.28; Wed, 29 Nov
 2023 09:14:38 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:2c4:cafe::78) by BL1P223CA0030.outlook.office365.com
 (2603:10b6:208:2c4::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27 via Frontend
 Transport; Wed, 29 Nov 2023 09:14:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Wed, 29 Nov 2023 09:14:38 +0000
Received: from compile-server.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 29 Nov
 2023 03:14:32 -0600
From:   Ma Jun <Jun.Ma2@amd.com>
To:     <amd-gfx@lists.freedesktop.org>, <lenb@kernel.org>,
        <hdegoede@redhat.com>, <johannes@sipsolutions.net>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <alexander.deucher@amd.com>,
        <Lijo.Lazar@amd.com>, <mario.limonciello@amd.com>,
        <netdev@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>
CC:     <majun@amd.com>, Evan Quan <quanliangl@hotmail.com>,
        Ma Jun <Jun.Ma2@amd.com>
Subject: [PATCH v14 3/9] cfg80211: expose nl80211_chan_width_to_mhz for wide sharing
Date:   Wed, 29 Nov 2023 17:13:42 +0800
Message-ID: <20231129091348.3972539-4-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231129091348.3972539-1-Jun.Ma2@amd.com>
References: <20231129091348.3972539-1-Jun.Ma2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|DS0PR12MB7996:EE_
X-MS-Office365-Filtering-Correlation-Id: f2845fb7-8307-48cf-1d45-08dbf0bb9cf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dsnStSmM/6vAIye++eR5XIS96HmSWlJ7KHwkC0FFRBOvgpDVALJd9MKAb5vTn323PnWRHo00xSEZIWxXjx4nNLq6J2lHHwuftCwMy/7vo0PC96hDqbZ5RKRu2mugcoVAk+a79usi/HQZx5hFeQMgm6WS76sQv+LkeV+q5WX1iYJnB2PfMnRh6szka1Jec5FLzQFST/Tb0uDT+fDgiFuSPy8FbAgvEDTwnJ9HlekjC7PuKxsXY6i8ao5MQu1AZdwNh0qhUtjVLLI0fomi8a4J6nRaPbqHkmXLCJ3yQGIpIyCsUac0JYoZOVsDm46knrvqEY+Lgoh61jWxWb7WVlQXDIcewhqQ+f9kqlyu9gD2YRSH+CxdYRM3xLdASlT5aCyvVoGP/wM9pspI4Le4IdGWO/xgv7I5omC0ujGOtX+9UzYMjd2W2cFxp2hP5jLtjgDnaKaTvqXWHYhuiLWG0oObiSI/5t+Rgs2G8bqaPluJpaVczD3mhySSa/GL/iuHVf3VN66BtU8sWvNl9iNmCUjjtRh2npeV/wIrDQBO1XOMsShTJNm7Mii+9CW/6GG+ADjgQ6bv6+erUPiS8xTc8kjzbIJCSyEgCKUAkCK00O+elp+EZNM/qGWOn9nZaIHdUOA++gIdDuSJO9ttLabsa9eU/7kgU9zEx6vVlEgG2/0Xx7AMs/0mrA32F/qHLEa/tQno6ArzCfCsZsSTREUhFty89RNTRRp2x1fw0DaCkLZCMVvXGKRKlX6u8x9YjC+OoqSxjg+OwZ79W/uNR6ruQexK14Akc3swLRo9qxtlMBp3qdg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(346002)(39860400002)(136003)(230922051799003)(82310400011)(1800799012)(64100799003)(186009)(451199024)(36840700001)(40470700004)(4326008)(41300700001)(8936002)(2906002)(40480700001)(8676002)(336012)(2616005)(7696005)(426003)(86362001)(316002)(921008)(54906003)(5660300002)(7416002)(1076003)(478600001)(36860700001)(32650700002)(82740400003)(16526019)(36756003)(26005)(6666004)(70206006)(110136005)(45080400002)(70586007)(81166007)(40460700003)(356005)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 09:14:38.5317
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2845fb7-8307-48cf-1d45-08dbf0bb9cf3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7996
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Evan Quan <quanliangl@hotmail.com>

The newly added WBRF feature needs this interface for channel
width calculation.

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
Signed-off-by: Evan Quan <quanliangl@hotmail.com>

--
v8->v9:
  - correct typo(Mhz -> MHz) (Johnson)
v13:
 - Fix the format issue (IIpo Jarvinen)
---
 include/net/cfg80211.h | 9 +++++++++
 net/wireless/chan.c    | 3 ++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index b137a33a1b68..08f0d7184167 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -976,6 +976,15 @@ const struct cfg80211_chan_def *
 cfg80211_chandef_compatible(const struct cfg80211_chan_def *chandef1,
 			    const struct cfg80211_chan_def *chandef2);
 
+/**
+ * nl80211_chan_width_to_mhz - get the channel width in MHz
+ * @chan_width: the channel width from &enum nl80211_chan_width
+ *
+ * Return: channel width in MHz if the chan_width from &enum nl80211_chan_width
+ * is valid. -1 otherwise.
+ */
+int nl80211_chan_width_to_mhz(enum nl80211_chan_width chan_width);
+
 /**
  * cfg80211_chandef_valid - check if a channel definition is valid
  * @chandef: the channel definition to check
diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index 2d21e423abdb..dfb4893421d7 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -141,7 +141,7 @@ static bool cfg80211_edmg_chandef_valid(const struct cfg80211_chan_def *chandef)
 	return true;
 }
 
-static int nl80211_chan_width_to_mhz(enum nl80211_chan_width chan_width)
+int nl80211_chan_width_to_mhz(enum nl80211_chan_width chan_width)
 {
 	int mhz;
 
@@ -190,6 +190,7 @@ static int nl80211_chan_width_to_mhz(enum nl80211_chan_width chan_width)
 	}
 	return mhz;
 }
+EXPORT_SYMBOL(nl80211_chan_width_to_mhz);
 
 static int cfg80211_chandef_get_width(const struct cfg80211_chan_def *c)
 {
-- 
2.34.1


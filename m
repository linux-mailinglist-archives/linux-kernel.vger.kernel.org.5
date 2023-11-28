Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD9067FB432
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 09:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344120AbjK1Id2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 03:33:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232806AbjK1Id0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 03:33:26 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2050.outbound.protection.outlook.com [40.107.22.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 310552710;
        Tue, 28 Nov 2023 00:33:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C89kq+PxzKMi+f8lQDZ6Q6Q+JnIo41DSZ/J9SqCD7uSclwoPU8DFM+iAxp8xVjjAEwdITW+LPxykMBfOyVAARdZtDSJakGZziPDzG6BvxH89oROeloZM8hm2NI5H6C4B666IyjUVZiXKF4ylJmFoerWen39OMpxxbP5mn7OtwAoT1DH+Db7zuxspOhUnPof1QZHkHzyi18LwxowHMdbvni8yvmGsZ090aFRsJtfLXsHWvOJMnzUPeQ++ZrAOpLHfwUctjW47LYFcWxh/jyOlBFKIzOawmhLqEXriF7QWsd4cyeCK7Nil6bvUrjEz2ve7h+jou388L7b0Kqfc2s9k2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sZrG4C4q1H5THFoH+tI44/yFuOw6ffv1Nnud6P0dn5o=;
 b=AWzkYmbnIpho7G4Q26jcV5aOvckeKDkM6G0FLBWAq/R27kh+Vis3Wjd2prV0opDcI1SVxHSeWhwq93aYvapaMjJeKqGJzLer7zuHj6q6gC5GBILUmVldq48VGbfZ5OuGGc7kpkdwkGWaDk4r9K+dmCtc/80+5UzbJ4ohJZ7Bg4mY+KHd+cOP6soJeVQI+gJfSJFWsIqt5vjfsRrFh66jn+1Q/RPil897/j7i44OYdVKk/WA0M6tFzmQsFWNevVieRvIvdy3oG13x/DzYl7cvwxSDoYNa/nVTH7jzJbpR0Q1N35B+5gg8dITceAmKdXoeEPq4rQvl+XSarWqO/x8TUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZrG4C4q1H5THFoH+tI44/yFuOw6ffv1Nnud6P0dn5o=;
 b=pirNeDjpTHfXhp1NQTWlm2E9HyDoeGAw1u8w2XRjKSj9JGTLqkgSU1DwaUBX92j5y6OGMFSALCoTZzw/qNbteH2LlmSOOVKF6/evGGPHx3tHunXbx7y3by5jikD58Jh1qaYDLyKeWUv+zsZ7v8uqCEPcw7VNxN+UH3lHD7GilMI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by PAXPR04MB8653.eurprd04.prod.outlook.com (2603:10a6:102:21c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Tue, 28 Nov
 2023 08:32:13 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b%7]) with mapi id 15.20.7046.015; Tue, 28 Nov 2023
 08:32:13 +0000
From:   David Lin <yu-hao.lin@nxp.com>
To:     linux-wireless@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, briannorris@chromium.org,
        kvalo@kernel.org, francesco@dolcini.it, tsung-hsien.hsieh@nxp.com,
        David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH v7 10/12] wifi: mwifiex: fixed AP issue without host mlme.
Date:   Tue, 28 Nov 2023 16:31:13 +0800
Message-Id: <20231128083115.613235-11-yu-hao.lin@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231128083115.613235-1-yu-hao.lin@nxp.com>
References: <20231128083115.613235-1-yu-hao.lin@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0019.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::13) To PA4PR04MB9638.eurprd04.prod.outlook.com
 (2603:10a6:102:273::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9638:EE_|PAXPR04MB8653:EE_
X-MS-Office365-Filtering-Correlation-Id: d074516f-7629-4b76-c7af-08dbefec8549
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vm18zIdthFvU0Md0H7Fdr0YdJtuT0j6GW3AcKUAM6/Q11W4JBhD1LnFaJT81aziWtX29ihfFS6ZPW/YE/f7SXafiQkMmRlTAJ+5m9q/VZ5IRKA6ugN8BHp7x33kgqVcsL9oChQ/Unu3D6V6AYgr/iVVGFV59T1YUpivAEGrkeFntVfuRqXlnb3uJ6mYJx2njcskVe2ehAJ90uzqKuuFtnIQt4asm93WaGO8jS0KivUNzSJnxVuTHG9xCECXh6k8uNguCJvRlShXLVtY7GgBQIfsEyc0ZosycY9L+/V9k+ApGYCpV1N2Npj2U7l95mQG1Mwme43BIjEZ50ofWhmw9RpDxqyTiztYbHLgPCkUNvXcwo4JdSHTuNrsG4gdgArF1e7xIwhQhTwiG92udX3WfzqXwosIxEbLwUZwf0i1x/k3Jo8sAbA9cY8HE945TjjnX1WaX4EZk1zlDO7kSaE8sFl27uYKFDMk3tq8dIUltRlYIngQR5T3b+wdVE4X2QQ1u5kdC7naA26/Hzv5cAQI5l3QT2zrE7K06TVf4a9kx06TWV+xMl4JaHjKkrNTspESv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(366004)(376002)(39860400002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(83380400001)(66946007)(478600001)(6512007)(52116002)(6486002)(86362001)(66556008)(66476007)(6916009)(316002)(8676002)(4326008)(8936002)(6506007)(1076003)(2616005)(5660300002)(38100700002)(41300700001)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2Y+He+H/4a4QEY1/341MOIolyQV/j6FlZ44Dp7D6aeIfBNxYpH/9gT4RrKF+?=
 =?us-ascii?Q?uG4OBr/p5j1sdmTrvlSMavXlZLK6vy+pLjAb+3at0dqri3j5Ov/LGh2gX1mS?=
 =?us-ascii?Q?ByFQ9hMvgrRBp/KGDCKzHaKCW0pMajV00CaASCtQNnr2PAQgnJlqJhZtNvPn?=
 =?us-ascii?Q?5tsdsHvkUUe7QABzG9WEgiA14vU7qv+LCYrlvutjK1yGi7Nlq24/MU8f7B1O?=
 =?us-ascii?Q?TapH48JblW91Op72uJoUTdkJ5M/rfr+1Qi8yLuQcZRS0cHFMtPVYS0ega950?=
 =?us-ascii?Q?puawZdKc06k3+x3+LP12/FSCqhfE2OU+wBUUODDXzL/9m1RGKxdz4KOMFyWp?=
 =?us-ascii?Q?kmHUbgm9+Xw9XfLGRIonTSeQvDiiMwvhKcCRHluFQEi/pyf367hC7kFAgB7C?=
 =?us-ascii?Q?B47ZTsUYfu8SBeUTvq4kbANU/E5lIcXgfe6fEqWyUca0d9uHPhg6O+Q26oGz?=
 =?us-ascii?Q?W6A7g9fMLOXc9OHyYe/Bh4lRLE345D4HppLk675YwuXbutOm1Y/RefcGqqEK?=
 =?us-ascii?Q?10cZG+bg2K7iz/kCZfdyaEubceeIbX1oyyevSZULUsTIBkZ3yhu2iEnNDijj?=
 =?us-ascii?Q?nqWzw95g6HNa12DIILWJbgIOnG9+F1yU5yY2T/68EU1F16tR5rTQf/g0kqOj?=
 =?us-ascii?Q?Pm1nsnxEvU+Y6tDP53TXNf87lP8UjhCj0Y7e51DFO0//Yd9yb9xfUmAKWxy6?=
 =?us-ascii?Q?0f3K81R9+BKVycLAoA64tX5XreUsEooKjYt3b61IdSQePCo60ZH4MaeA/VTX?=
 =?us-ascii?Q?7GdcwEyq9tYm079Mq6lKkvezDq6Mw4Cjks9k8L6+qKd1/7aPHiKPvwVcAN8m?=
 =?us-ascii?Q?qRguPXBB872iQAuVJUFu6si93MWGWodi5OMpQEgWkbbHCX1AMJLQzVdncsYX?=
 =?us-ascii?Q?TwWEOnvzLz8R4leFRXWAcnwiqn6M8t2WX23NdYDOG8jAl1tZOgFbhRqzdXRI?=
 =?us-ascii?Q?13ccqjXL//O7kKD8qIpVoVNb0rya3ENzHzxQyCn6RULA2a2G6LyY5yaZDvOQ?=
 =?us-ascii?Q?8/TeIExzgohx/8fm2IwrsP3QElgJEzHa+9sr0a+IcptYN/bOLfsxpovIVH7d?=
 =?us-ascii?Q?3z1iQB71aLoVK2MpWfnwybJmP2XPiO5yE/LYijVuWUbFwnX1lxEA0c3qPKPf?=
 =?us-ascii?Q?RmQkaZyQ9zZ9DxvIN3jSv/lOQtik5hf5QqXFy3LSrXwIK3qynQwwmwfnn+hw?=
 =?us-ascii?Q?uCZwfQRjwf/gM1XOcPDCZyJrks4KaaHAlglkutFqSjZ3NodsB8ChSm16kZ6A?=
 =?us-ascii?Q?TSKnyblcKpJvfClmSlmw27BSzqBv+5SPg+n/Ci0x4rTpManDAGHRKXEJeg/8?=
 =?us-ascii?Q?9pDJubthWYnoiz9ulmDHDQpmExaBQroRlZioEkpB/AgLZt3qY0CEleQ0BjpV?=
 =?us-ascii?Q?VOiko42CufS8mk7Tq2qROnmFKnfsEZ411dB393Lhn45NAKOblCUP8MPNUQMm?=
 =?us-ascii?Q?++hQ0mZMA7y5Gqq6YS7CrJmxPxt0HGj3o8aDfyZwTkT8+fqfWqWzfYfekPx0?=
 =?us-ascii?Q?NGZBvLe4XVHcgUoLLgpI0bbZMWyZn6lYoFK4raHHSNoJiyglL6DvCIcpRj7c?=
 =?us-ascii?Q?JGlshCsAiklJUy3xq49OZ6IXf8hNvrZtpZ9srFJEuB66UVAIVLcjQgAD9tcE?=
 =?us-ascii?Q?TxS90/62BSyhUaKDlB2Y/CFniW/sXGXyVX253W0spA/L?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d074516f-7629-4b76-c7af-08dbefec8549
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 08:32:13.1838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uaTcqgVVLDFEcdYyDJux7VHZkEvWo8d+CJ98GVmZl08PLlK5oM1Tp1a/kep9sqYnZPB3g6qfjLuj5Ku6xeGo4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8653
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without this patch, station can't connect to AP if host mlme is
disabled.

Signed-off-by: David Lin <yu-hao.lin@nxp.com>
---
 .../net/wireless/marvell/mwifiex/cfg80211.c   | 25 ++++++++++++-------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index 588a500fe1b9..2792996e027f 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -1761,7 +1761,7 @@ static const u32 mwifiex_cipher_suites[] = {
 };
 
 /* Supported mgmt frame types to be advertised to cfg80211 */
-static const struct ieee80211_txrx_stypes
+static struct ieee80211_txrx_stypes
 mwifiex_mgmt_stypes[NUM_NL80211_IFTYPES] = {
 	[NL80211_IFTYPE_STATION] = {
 		.tx = BIT(IEEE80211_STYPE_ACTION >> 4) |
@@ -1770,14 +1770,10 @@ mwifiex_mgmt_stypes[NUM_NL80211_IFTYPES] = {
 		      BIT(IEEE80211_STYPE_PROBE_REQ >> 4),
 	},
 	[NL80211_IFTYPE_AP] = {
-		.tx = 0xffff,
-		.rx = BIT(IEEE80211_STYPE_ASSOC_REQ >> 4) |
-		      BIT(IEEE80211_STYPE_REASSOC_REQ >> 4) |
-		      BIT(IEEE80211_STYPE_PROBE_REQ >> 4) |
-		      BIT(IEEE80211_STYPE_DISASSOC >> 4) |
-		      BIT(IEEE80211_STYPE_AUTH >> 4) |
-		      BIT(IEEE80211_STYPE_DEAUTH >> 4) |
-		      BIT(IEEE80211_STYPE_ACTION >> 4),
+		.tx = BIT(IEEE80211_STYPE_ACTION >> 4) |
+		      BIT(IEEE80211_STYPE_PROBE_RESP >> 4),
+		.rx = BIT(IEEE80211_STYPE_ACTION >> 4) |
+		      BIT(IEEE80211_STYPE_PROBE_REQ >> 4),
 	},
 	[NL80211_IFTYPE_P2P_CLIENT] = {
 		.tx = BIT(IEEE80211_STYPE_ACTION >> 4) |
@@ -4751,6 +4747,17 @@ int mwifiex_register_cfg80211(struct mwifiex_adapter *adapter)
 	}
 	wiphy->max_scan_ssids = MWIFIEX_MAX_SSID_LIST_LENGTH;
 	wiphy->max_scan_ie_len = MWIFIEX_MAX_VSIE_LEN;
+	if (adapter->host_mlme) {
+		mwifiex_mgmt_stypes[NL80211_IFTYPE_AP].tx = 0xffff;
+		mwifiex_mgmt_stypes[NL80211_IFTYPE_AP].rx =
+			BIT(IEEE80211_STYPE_ASSOC_REQ >> 4) |
+			BIT(IEEE80211_STYPE_REASSOC_REQ >> 4) |
+			BIT(IEEE80211_STYPE_PROBE_REQ >> 4) |
+			BIT(IEEE80211_STYPE_DISASSOC >> 4) |
+			BIT(IEEE80211_STYPE_AUTH >> 4) |
+			BIT(IEEE80211_STYPE_DEAUTH >> 4) |
+			BIT(IEEE80211_STYPE_ACTION >> 4);
+	}
 	wiphy->mgmt_stypes = mwifiex_mgmt_stypes;
 	wiphy->max_remain_on_channel_duration = 5000;
 	wiphy->interface_modes = BIT(NL80211_IFTYPE_STATION) |
-- 
2.25.1


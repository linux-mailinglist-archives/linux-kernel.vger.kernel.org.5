Return-Path: <linux-kernel+bounces-296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A133A813EDE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 01:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 234561F22C39
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 00:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBA9807;
	Fri, 15 Dec 2023 00:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="o11Y6W0V"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2052.outbound.protection.outlook.com [40.107.8.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCA41879;
	Fri, 15 Dec 2023 00:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bDJSEdS4fkGRcJxiYe4PQ2ztxKbAYMtPh4mM2GP45V70/mBu3d4RJ22lAeNbWOaXnmUv6xMgEJivLHyg+ijoDir95nBpx2YIsN4SUiWwxFtAwjhJyZK0cDFW8D8YA+xQ2BqWLXhAplyVsokClehLJ65j/ZLUD53hhmgtrbGorQ7vJOrecuaBI1W8k06Vkhf6+Ccg7DhPyqz2iAHNAn6ffOVsBCIWcvfT5xLdOgId28Q1Kx8/zoJpMibp8r/JB6orwxJK1iF8xS2XsT974SfYlFR+fa3OOMWOElCTJr4+QETjAjfA1/FsHt7CVAr2qQ2csKfzm6fVFRj4BTKMgO3/YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ab9blAguUcILGfIrLlPilcyYWkuKcH2esCRlsoiOgQY=;
 b=En16NU4UQuOSrAIotduQCSN5mxBldczr6IQvvoCQZuLi+/SwwmwZAkU08OMcK4wYQPNTx6W7LwOfu4sfpcv4YWK+bLOPGiIRT2xGDcIbgNLp5PX5phNikqUM7tGnzf0QAWJ5EyBPjPT9PS9JCs8IdyTlG0dsi/vlrYUADsifdMxnLnOuls3qT1Z+zeBTy1u9kzblkO7zd1Fjv94tSeWc11VoerwfkKTzK92fpE2K4wWwW4nrCtsixUorVVDuTaXA/c5+YxLO8oq2HaT1qHdMpRx7BshIeRQWooOj2vR/OTZS90UBU9O5VyeHW+vfKhTokDdHjcwUFlT5al6JRtdd1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ab9blAguUcILGfIrLlPilcyYWkuKcH2esCRlsoiOgQY=;
 b=o11Y6W0VOswBvCxBMcMdPQxgjH4PIUPTzbAIQGDC3E39IgJ09d0MDbLU4nVOq3f/qSHcoyXDLPreIX2GXrRZxFokR3bZ1tNOQZM6+X80TITm6I7F4VanPR20+Z7zSN47sOFD+ICwG1vBEvgm0e5QHCDQs2Yz/nB2aInMmt+S1zg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by PAXPR04MB8176.eurprd04.prod.outlook.com (2603:10a6:102:1c9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Fri, 15 Dec
 2023 00:52:05 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::ef2d:51b6:463f:846]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::ef2d:51b6:463f:846%4]) with mapi id 15.20.7091.030; Fri, 15 Dec 2023
 00:52:05 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	kvalo@kernel.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	David Lin <yu-hao.lin@nxp.com>,
	stable@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Rafael Beims <rafael.beims@toradex.com>
Subject: [PATCH v3] wifi: mwifiex: configure BSSID consistently when starting AP
Date: Fri, 15 Dec 2023 08:51:18 +0800
Message-Id: <20231215005118.17031-1-yu-hao.lin@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR0101CA0030.apcprd01.prod.exchangelabs.com
 (2603:1096:404:8000::16) To PA4PR04MB9638.eurprd04.prod.outlook.com
 (2603:10a6:102:273::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9638:EE_|PAXPR04MB8176:EE_
X-MS-Office365-Filtering-Correlation-Id: 81bb39ab-956c-4938-c58e-08dbfd080edf
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
 mmk7/VvKFNFkYuCHz575596IrEP/il3KyMljfe1yMGKbXNMBq/qTDeTa4s7H0hwz4qpvqIDtOEJePmIQWa0EixpHhY50cRYTzhMjpVFYYuwqZNKm1mLX3i6+7Ykdsv+yK1wAw2bCQFKAqlzVCmoSBG2RkviWhF41Wvn+yq34NNFm/Uy2LBfUsjhhUcQYv4Uku0Ol/7hZYixfDutBkujnC8yUS9HUTeDtPLxD0Wnv7G9t2Z66ycJfe7gvcjOSbuBBmv/K3mg/BYWEvAZxMpi2fufeXATZu1tJdN7b9X/l1kgFwQHRkRYyT8yyYWZFwiNjyiGMqBVEu4iSOD1/889aaoy5nCfF5TP9eWH3m7v7hMRbbz9cqkw6npr+4al2pHNF16bKkdKp2fGgY1RGMBEveIMSaXQPy2F5HvJQ2czZmCtgFFu/s5I2JN+vuDfayuGMRYek+qwbOZrPvJ5IrECumvPJfWAlxrqwqMyKCwDyO0mdfR8aOUb4rq3D6+xIh1wvj5F95b8RHC9eKKDglfyXntPVmPu4HDDsUO5l+zeZTYQlZJCrCy1Nk8ftKUmSXfA+
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(346002)(39860400002)(136003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(6666004)(478600001)(6486002)(38100700002)(1076003)(2616005)(66899024)(6512007)(6506007)(52116002)(5660300002)(2906002)(8676002)(41300700001)(36756003)(8936002)(4326008)(86362001)(6916009)(54906003)(66556008)(316002)(66946007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?8/bUv8rgDpVHAnfiEzzZVzRlnDO5ovMKhlzyhp/VmnZLqn3ojQPUd79zjEt4?=
 =?us-ascii?Q?VsmxZagzTax78ijjZF3ewUXuVGGIUZG05M3yUB0txI+RvQgTGKryrjZsyBay?=
 =?us-ascii?Q?p9EmGPJNhz8uiMt6mRlFkdW8XIGKuZemzRzk/E0hMSMWcv59burTAmdiO74C?=
 =?us-ascii?Q?vnx244rR7YPtC2/CGGRAZlFQ0/FTHEjwwNIxtp0B6dJVal2v0AA793PgjDkS?=
 =?us-ascii?Q?PsOv4Fxdg++C2qHMH3sEcx14JGQewkr/L5em6B6G9MxFqurueGg471BGQcB3?=
 =?us-ascii?Q?JavHuVVwJJh3daRVPi+yk59H4YxwPhQalZOwWNPcYnxjud7CIyyCt1SH/pF/?=
 =?us-ascii?Q?Qsc+oZtdudhv2XNJydybABqmOM+Jz2f79JwtMQZTNYrW2GmplfeXCoGrlLBG?=
 =?us-ascii?Q?dGwOmFPx+Wb4Lh+ZeM0kDTzdT03b41TGKoLwayh2BFhl4qlPqcExffVt5375?=
 =?us-ascii?Q?cWmyzka4tqsVPFYp+D5yC5ZGc3hFLNrkHstLFTmUGF74QpFcwxyom7yEUfi9?=
 =?us-ascii?Q?Mf2mY189D4CUkoi4jn0+pvnd4HKCjMc2qweVcoXxg8NxWZsqxVMyPvi1AZ/t?=
 =?us-ascii?Q?GNnE5/WydjPPiPVEicol2LxPtkwwspg18EARF7BiVaKNgapK28pv7K5xiwYW?=
 =?us-ascii?Q?K/52lBwALQwFZatBI6hi8XnWE4Ujb53nBYyyslmUU1Qe+VAr8vbi/8BhVfN4?=
 =?us-ascii?Q?lzdXY32hAe+FIaq3x6V5w3JgoRwYMEX1I/qxrgeeTvZJGYOqxBXAQIryZGUF?=
 =?us-ascii?Q?SdIevc3aeh5EGRkkgeZWr4FxKjPyBhoi010zcFxUjXiHO4/HfnYe3cjYqp0P?=
 =?us-ascii?Q?sBTx+pEUDQDst8KI5PpKXLuo7VsQB5oKilR/UG7h90UaNf94lbkLqj29aBeb?=
 =?us-ascii?Q?36MT/kmqwGNmIt1NR3QXESSmzriisrANkUtc1El5xrZ+gQGxdIrAJ4nYHwGH?=
 =?us-ascii?Q?GnFarJ3mS13KIgWy5HgvO7aWKZhFy6OAlqAPDYjYk0f3vE+i2NjMBWAVR4Ze?=
 =?us-ascii?Q?+Em+aFt1APJXxx1eLYFL27Px4mO48sFtNQ9riMaak/RWxzaE/eB0AZoEaUmi?=
 =?us-ascii?Q?2U6rEwt6lz0n1r34CrvTly5mLXqEOgciA0+ooJ9NQlaie15aNts9o6y5sMrP?=
 =?us-ascii?Q?9ypdXAqjOYssZIxUm4f7zkYS0fU5xYnmIFlc3PKX7FxiVfDbv3jKThGk7AA2?=
 =?us-ascii?Q?dtLxZMb3pDhYgeh62nrHcmBgmJjiKP3dM9m0LgP+w1T5W7sCCBbRPXf+FkNS?=
 =?us-ascii?Q?+gLk356IO0/LiU2VQKC3dt454yF85/ovxLRy259O5qjv32Zrd+ZyF+VGj5p7?=
 =?us-ascii?Q?gBUmjyXg17uylvkQYnuoTzn+2uWXirQgjRM80JwvEr6U7AgBH1CjGfzPsyDO?=
 =?us-ascii?Q?byIok/Ynfy+O8LNqgSnXQgsrH6OEI66ivvvCxs1uaXeeYlq8kvwPoAAuusz7?=
 =?us-ascii?Q?5BCxF0/0I+xoT2fzRG1CTyQNoT9kyDMHPHZsQ06/6jd90bHqV0t4XR0Ai16O?=
 =?us-ascii?Q?8CX5CT1kkOiussSds7aAbGu6g0FEUdUOWVlMsJuINLKoytbEvtyzqlteS4e4?=
 =?us-ascii?Q?EZrqzFny3XqWhOVKQjxHRNEiuYxR7Ehna8FLsRW9aB5hEzrA7nmepnV3VCLa?=
 =?us-ascii?Q?hvBx95n2y8+be1vroyWzsiliAGlta7Gxte08e0FW1+lI?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81bb39ab-956c-4938-c58e-08dbfd080edf
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 00:52:05.5517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G2NXeVyV9DaCzYFxg3CSPYEIjMjM+H9M2qnjILvb4KUCoMNksSHjSrlnmpdVssXxHxLScCHVSOII4iY7mMT4pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8176

AP BSSID configuration is missing at AP start.
Without this fix, FW returns STA interface MAC address after first init.
When hostapd restarts, it gets MAC address from netdev before driver
sets STA MAC to netdev again. Now MAC address between hostapd and net
interface are different causes STA cannot connect to AP.
After that MAC address of uap0 mlan0 become the same. And issue
disappears after following hostapd restart (another issue is AP/STA MAC
address become the same).
This patch fixes the issue cleanly.

Signed-off-by: David Lin <yu-hao.lin@nxp.com>
Fixes: 12190c5d80bd ("mwifiex: add cfg80211 start_ap and stop_ap handlers")
Cc: stable@vger.kernel.org
Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Tested-by: Rafael Beims <rafael.beims@toradex.com> # Verdin iMX8MP/SD8997 SD
Acked-by: Brian Norris <briannorris@chromium.org>

---

v3:
   - patch title change from "wifi: mwifiex: fix STA cannot connect to AP"
     to "wifi: mwifiex: configure BSSID consistently when starting AP".

v2:
   - v1 was a not finished patch that was send to the LKML by mistake.
---
 drivers/net/wireless/marvell/mwifiex/cfg80211.c | 2 ++
 drivers/net/wireless/marvell/mwifiex/fw.h       | 1 +
 drivers/net/wireless/marvell/mwifiex/ioctl.h    | 1 +
 drivers/net/wireless/marvell/mwifiex/uap_cmd.c  | 8 ++++++++
 4 files changed, 12 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index 7a15ea8072e6..3604abcbcff9 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -2047,6 +2047,8 @@ static int mwifiex_cfg80211_start_ap(struct wiphy *wiphy,
 
 	mwifiex_set_sys_config_invalid_data(bss_cfg);
 
+	memcpy(bss_cfg->mac_addr, priv->curr_addr, ETH_ALEN);
+
 	if (params->beacon_interval)
 		bss_cfg->beacon_period = params->beacon_interval;
 	if (params->dtim_period)
diff --git a/drivers/net/wireless/marvell/mwifiex/fw.h b/drivers/net/wireless/marvell/mwifiex/fw.h
index 8e6db904e5b2..62f3c9a52a1d 100644
--- a/drivers/net/wireless/marvell/mwifiex/fw.h
+++ b/drivers/net/wireless/marvell/mwifiex/fw.h
@@ -165,6 +165,7 @@ enum MWIFIEX_802_11_PRIVACY_FILTER {
 #define TLV_TYPE_STA_MAC_ADDR       (PROPRIETARY_TLV_BASE_ID + 32)
 #define TLV_TYPE_BSSID              (PROPRIETARY_TLV_BASE_ID + 35)
 #define TLV_TYPE_CHANNELBANDLIST    (PROPRIETARY_TLV_BASE_ID + 42)
+#define TLV_TYPE_UAP_MAC_ADDRESS    (PROPRIETARY_TLV_BASE_ID + 43)
 #define TLV_TYPE_UAP_BEACON_PERIOD  (PROPRIETARY_TLV_BASE_ID + 44)
 #define TLV_TYPE_UAP_DTIM_PERIOD    (PROPRIETARY_TLV_BASE_ID + 45)
 #define TLV_TYPE_UAP_BCAST_SSID     (PROPRIETARY_TLV_BASE_ID + 48)
diff --git a/drivers/net/wireless/marvell/mwifiex/ioctl.h b/drivers/net/wireless/marvell/mwifiex/ioctl.h
index 091e7ca79376..e8825f302de8 100644
--- a/drivers/net/wireless/marvell/mwifiex/ioctl.h
+++ b/drivers/net/wireless/marvell/mwifiex/ioctl.h
@@ -107,6 +107,7 @@ struct mwifiex_uap_bss_param {
 	u8 qos_info;
 	u8 power_constraint;
 	struct mwifiex_types_wmm_info wmm_info;
+	u8 mac_addr[ETH_ALEN];
 };
 
 enum {
diff --git a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
index e78a201cd150..491e36611909 100644
--- a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
+++ b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
@@ -468,6 +468,7 @@ void mwifiex_config_uap_11d(struct mwifiex_private *priv,
 static int
 mwifiex_uap_bss_param_prepare(u8 *tlv, void *cmd_buf, u16 *param_size)
 {
+	struct host_cmd_tlv_mac_addr *mac_tlv;
 	struct host_cmd_tlv_dtim_period *dtim_period;
 	struct host_cmd_tlv_beacon_period *beacon_period;
 	struct host_cmd_tlv_ssid *ssid;
@@ -487,6 +488,13 @@ mwifiex_uap_bss_param_prepare(u8 *tlv, void *cmd_buf, u16 *param_size)
 	int i;
 	u16 cmd_size = *param_size;
 
+	mac_tlv = (struct host_cmd_tlv_mac_addr *)tlv;
+	mac_tlv->header.type = cpu_to_le16(TLV_TYPE_UAP_MAC_ADDRESS);
+	mac_tlv->header.len = cpu_to_le16(ETH_ALEN);
+	memcpy(mac_tlv->mac_addr, bss_cfg->mac_addr, ETH_ALEN);
+	cmd_size += sizeof(struct host_cmd_tlv_mac_addr);
+	tlv += sizeof(struct host_cmd_tlv_mac_addr);
+
 	if (bss_cfg->ssid.ssid_len) {
 		ssid = (struct host_cmd_tlv_ssid *)tlv;
 		ssid->header.type = cpu_to_le16(TLV_TYPE_UAP_SSID);

base-commit: 783004b6dbda2cfe9a552a4cc9c1d168a2068f6c
-- 
2.25.1



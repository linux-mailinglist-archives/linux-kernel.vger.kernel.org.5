Return-Path: <linux-kernel+bounces-9286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D178E81C36A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 04:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18BF8B23F26
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 03:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33753C8CB;
	Fri, 22 Dec 2023 03:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AvKguNuF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2088.outbound.protection.outlook.com [40.107.14.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CE9B65D;
	Fri, 22 Dec 2023 03:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nV7FyzaRwG0MmnX6Of+t1GjXJ568tkteQp+yN1e9YsI/D/JxMPAutg7b4pQytIrMihfxSvuBaNMZ0aj9PWYCW7eKwCT/3UgJOHLOh6w/W/+yD7vHDTJ3524GelTJvelIsxdi9QWOZlWeTsQAepaKciF+Epb5bm3SSjst/0YKtDLthK9DMXVyDZvnpP5Cot3yflawn/kbPZN150Y5a87xkWeEuWLUiR5JhQPIXvEjpjnUWwfIF+J5eZd5NLM+AMQzCg0gSQowwn1u7D67x3mOBXgPJ+JmV5iB9ZmHA5k7lc7OGIFPhPzEG98R4NolGewWvuQobhi9P4GYzzZv6aoouQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7cvBwjt9LgJbwRz7H4z5Mi3P/kTwMLdfA1+F1kxvBvo=;
 b=e+/US7RJpx3Nr/Qj5MeIt2lXhRT0AJ9QP1/2g7E1CfW9We7rhpdM5L9tPr4E067pIUHMtPOwM6CMpMzI3UtI1CkCMXQxjVOgs/7hMXj1MkE6tCshaHEAuEM2Rclh7qb6rMD7RlEia0xehMSc+0T2TPPO2E/lwE9pz2VL0ZQh96CcKe1/PdnO9nOPCpfLGrwgbJCfoFJCw/48vLtGCqQmdVzkmUW95XGcQmujA334u/OLGd7GlIhLuCaNM2GosxJvqSXZHwhdKF+b4uE+5aGqt+gwBpC1vj6uMuPMUqhkW6A5qsM5nVk75+qvz8nsk0I4xXP6Mi0CpNtAVTBBR/a7CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7cvBwjt9LgJbwRz7H4z5Mi3P/kTwMLdfA1+F1kxvBvo=;
 b=AvKguNuFO9c/OefcwtIMfHwU6WJWOjGCUFH5zFjpn3Eq2rc3huhmKeFE0nkpdye1CzQBKC0EHXYRX28SEqwZX2SCYaiBYVq7fJi6k+6X35ZBgadojsE+2fIhd3Xl6YB7burgtBKPu9roMiIkfewS7ooLDepBksBJLg588o3ZQ+4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by AS8PR04MB8358.eurprd04.prod.outlook.com (2603:10a6:20b:3fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Fri, 22 Dec
 2023 03:21:56 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::b0b2:5cbb:3f6a:6630]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::b0b2:5cbb:3f6a:6630%4]) with mapi id 15.20.7113.019; Fri, 22 Dec 2023
 03:21:56 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	kvalo@kernel.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH v8 2/2] wifi: mwifiex: add host mlme for AP mode
Date: Fri, 22 Dec 2023 11:21:23 +0800
Message-Id: <20231222032123.1036277-3-yu-hao.lin@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231222032123.1036277-1-yu-hao.lin@nxp.com>
References: <20231222032123.1036277-1-yu-hao.lin@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0064.apcprd02.prod.outlook.com
 (2603:1096:4:54::28) To PA4PR04MB9638.eurprd04.prod.outlook.com
 (2603:10a6:102:273::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9638:EE_|AS8PR04MB8358:EE_
X-MS-Office365-Filtering-Correlation-Id: 9355d56c-7834-4de7-41a0-08dc029d26fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KTfO2s8wRTdD0CeKgDYkmpTc07JMt1wuxNGmO3IfeEweUo7VmOJ9IXNaJV09/eIHWy1fpTKWQdpy0P+XUMO0hsNF7NJvKE/BdAUwaQEjWvpp33quQy2McRGvIFUZocQiVqVw1G8Fwr+ItIbIaGnRrZi0pXhDCaP/KPAoop9lh/X1EbKB8ZZnsqBqEe8wh6M45+lttJHwly6z4Flvd9JBhD363tnLvgNwol/1Z0PReW3ZKVfpsDU5JNDWiZGhUpXG4qEI9Wn1EKT3LzWNBQ82WYU0qhpR80EWSx+Zt6VOm1okAvCFNh9YbP1Kdrt39CW4N3pOU2b7WFh8OhDSSZzZq6sYbqwgyOU0Sz/H4jkB2H+DvC3lKlJS2AYcK4h/SWI6mGv0S4P+Xfmw4OPejqtA+da77k3o8u/P+UzMa2O0hgsgH+0qmyU3An37VatOQ38mRdJDh4M3vcKAB9no4gjY7uWKZP9ISxek7aGd/EU8GSdMap05aY44iF7B9+IKSqAnBl5/x6LubHj+xCEhkzoLn4ETI0pD7QOP13YZ50fAzEaga+ut6FZvAy9A7AHKpidljXLF/CVWlvN1WYfN+4uysL/KDg9cjsjxBEGwJIBUNfUo1EA9iemGfu7FRbhsQi73pcO9StKe1iRj+Np79MLA/c6KKd5JKd9R0XKARp+PLL8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(136003)(376002)(39860400002)(230922051799003)(230173577357003)(230273577357003)(451199024)(1800799012)(64100799003)(186009)(4326008)(8936002)(8676002)(5660300002)(2906002)(30864003)(478600001)(52116002)(6512007)(6506007)(6666004)(66946007)(66556008)(6916009)(66476007)(316002)(6486002)(66899024)(41300700001)(38350700005)(83380400001)(38100700002)(36756003)(26005)(1076003)(2616005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lup+7NBlssQ1sWiEHU8REdEQzDdY+Ij6JwwE28aLxoWq+gnjEOZIr7NMDiRX?=
 =?us-ascii?Q?ajrNAEeE8DAgmwBjYkA1VOYDJeT35p1xnyA1DqeEo2QgYMK+0c/6b458Tjyf?=
 =?us-ascii?Q?AiBr1nPZsgy4mml9UK4ivR8LEoGb0dksJyTXcoBXwJ2Sg0oDSYHL2tMfOKfa?=
 =?us-ascii?Q?s+R09G9rHBxXzRImPD8CiOxsJHan7ec/c3JmMJew4MclovR8CvgcUMYKc3sh?=
 =?us-ascii?Q?bgJDz+EKk/b78/vvy2O0ak7BCBoaoZ8IyyRhgQILGZ57BBZmPluvhKcMlBoj?=
 =?us-ascii?Q?bwoQVH5AdmWmr7HCHsyDYqHFp0KnTI3Xw8Iz/BnhHW7ZDpt+eI/oIdIj0tHg?=
 =?us-ascii?Q?yKHcqJvZEi5H+5iPI20Is4hOvFd6wVMRYT7X92uGd0Lcco1kakBrwiYMHKQ0?=
 =?us-ascii?Q?gwN/+dv6IKEFIVVovWUabrhVivPx3f2i24QpCZIzcE3qQ0eUHlhX+TMjqboz?=
 =?us-ascii?Q?5ebKFDeqvzbpkap91PqGa0URnD1R2Et0rrpBw5PuYwQWoEsUkDdEyyZJf0ft?=
 =?us-ascii?Q?YNmP4GcoWPaB/Rqljg2dwUC1lUt5/NTDu4Edm2B7sy6Jd5RM5QpOXT4lsOBJ?=
 =?us-ascii?Q?EQ2PyKXPU9XPyefKhKBs6/tHKD8QM0Vn5p4htGv3XqGA1u7z73xlMVnYxPIO?=
 =?us-ascii?Q?7grx2UbPsR0cPrQozPaESYieT4mFGubxwrdv98OKOR4mQVEwg66pyPrnWWqL?=
 =?us-ascii?Q?mKHRhLyBeUYAPsZrXVoi9NDEnow3Z5NYPcl7AV2fce5AI/CnQRSW4Z5XHW6G?=
 =?us-ascii?Q?V2B0b8veMxeiqE+CTjWm5Zu6LipKNtoss7idCLFO8Va1PN4npCAZ7pFZspIU?=
 =?us-ascii?Q?Y6WHbTaXfUMvDH1ioM4JqbQJpShBzrrg8zpXelM9IbdvAUQIC5Ev7bLa+xbH?=
 =?us-ascii?Q?NLFWe4v+mnYHZeitYuGyFcCVsIopZkah7bN42dvw/5Q8IJihUxXBxP++pEdC?=
 =?us-ascii?Q?Sk+t60Z3hu1t8JJDrMv/9PYjyPWPH/ttbzRo7QEB6R21HzBBnW3n+jWoj8X4?=
 =?us-ascii?Q?ql5cAetw2NtEdV8Th9Pyw79+AoYg7/EVuVz+xTifmbbqEcdaju/40tXrlFZh?=
 =?us-ascii?Q?0DAVVbWydc9XaoUgY+RJc+7TnQTDuaWW0xUnLXEtzLPm0LFNm+KFIOl3RN9k?=
 =?us-ascii?Q?UBC6yqPwZDUZ6IMVLK6Fz32hHO2jpKx0QHuQV5HjMnVu5O8hR3S/1uxOVEE1?=
 =?us-ascii?Q?8KrBjNHEMbUi9ejIPSLVeUhC9+o4/J1zcXcw5vs5pyU13ENbw+iqgKJsYuLv?=
 =?us-ascii?Q?PwC5at3neM88boKtJ/rQMbOe7gGIXMg71Lm+b9IBC3eZMwNPtH/fHHuGF0+y?=
 =?us-ascii?Q?aX+HCQEUUMGg3hS1lioC47ha8jtidSmxjQEMTAEK8LXj6ytu4IRAmEKLYDhA?=
 =?us-ascii?Q?PvX2KuGtdtgYmJDHo/CO1hKBDj6BiuZxhQOqRePu7XoXhlSTdbTY4uoNZwde?=
 =?us-ascii?Q?/Aw3+YeOzA8Ky2mQZbxLo34bWZOi1UWZpPTSQj0OCucNt0WXa/sfp57iUwFt?=
 =?us-ascii?Q?KUCSoRtQIow3GEfvBe9/F2jVBrPDnx2qnD8LYgwfZylFG8VpGrs1+TYpbf5/?=
 =?us-ascii?Q?s2UgerDY8m4EnDGiXfHJdiQzPaLLSh0IqTJewox1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9355d56c-7834-4de7-41a0-08dc029d26fb
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2023 03:21:56.8426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1UHQFV3enl2OhtkbGI/ri0uH9boT1D5cSrGQhp4hHPR7GbLhmqkAFX+QgIcKOtiu/4D7ct26Q4Vqn+OxtzjV1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8358

Add host based MLME to enable WPA3 functionalities in AP mode.
This feature required a firmware with the corresponding V2 Key API
support. The feature (WPA3) is currently enabled and verified only
on IW416. Also, verified no regression with change when host MLME
is disabled.

Signed-off-by: David Lin <yu-hao.lin@nxp.com>
---

v8:
   - first full and complete patch to support host based MLME for AP
     mode.

---
 .../net/wireless/marvell/mwifiex/cfg80211.c   |  79 +++++++-
 drivers/net/wireless/marvell/mwifiex/cmdevt.c |   2 +
 drivers/net/wireless/marvell/mwifiex/fw.h     |  21 +++
 drivers/net/wireless/marvell/mwifiex/ioctl.h  |   5 +
 .../wireless/marvell/mwifiex/sta_cmdresp.c    |   2 +
 .../net/wireless/marvell/mwifiex/uap_cmd.c    | 171 ++++++++++++++++++
 drivers/net/wireless/marvell/mwifiex/util.c   |  24 +++
 7 files changed, 301 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index 3cee1b58465e..eec2525331b1 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -221,6 +221,26 @@ mwifiex_cfg80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 		return 0;
 	}
 
+	if (GET_BSS_ROLE(priv) == MWIFIEX_BSS_ROLE_UAP) {
+		if (ieee80211_is_auth(mgmt->frame_control))
+			mwifiex_dbg(priv->adapter, MSG,
+				    "auth: send auth to %pM\n", mgmt->da);
+		if (ieee80211_is_deauth(mgmt->frame_control))
+			mwifiex_dbg(priv->adapter, MSG,
+				    "auth: send deauth to %pM\n", mgmt->da);
+		if (ieee80211_is_disassoc(mgmt->frame_control))
+			mwifiex_dbg(priv->adapter, MSG,
+				    "assoc: send disassoc to %pM\n", mgmt->da);
+		if (ieee80211_is_assoc_resp(mgmt->frame_control))
+			mwifiex_dbg(priv->adapter, MSG,
+				    "assoc: send assoc resp to %pM\n",
+				    mgmt->da);
+		if (ieee80211_is_reassoc_resp(mgmt->frame_control))
+			mwifiex_dbg(priv->adapter, MSG,
+				    "assoc: send reassoc resp to %pM\n",
+				    mgmt->da);
+	}
+
 	pkt_len = len + ETH_ALEN;
 	skb = dev_alloc_skb(MWIFIEX_MIN_DATA_HEADER_LEN +
 			    MWIFIEX_MGMT_FRAME_HEADER_SIZE +
@@ -505,6 +525,9 @@ mwifiex_cfg80211_set_default_mgmt_key(struct wiphy *wiphy,
 
 	wiphy_dbg(wiphy, "set default mgmt key, key index=%d\n", key_index);
 
+	if (priv->adapter->host_mlme_enabled)
+		return 0;
+
 	memset(&encrypt_key, 0, sizeof(struct mwifiex_ds_encrypt_key));
 	encrypt_key.key_len = WLAN_KEY_LEN_CCMP;
 	encrypt_key.key_index = key_index;
@@ -1712,7 +1735,7 @@ static const u32 mwifiex_cipher_suites[] = {
 };
 
 /* Supported mgmt frame types to be advertised to cfg80211 */
-static const struct ieee80211_txrx_stypes
+static struct ieee80211_txrx_stypes
 mwifiex_mgmt_stypes[NUM_NL80211_IFTYPES] = {
 	[NL80211_IFTYPE_STATION] = {
 		.tx = BIT(IEEE80211_STYPE_ACTION >> 4) |
@@ -3949,12 +3972,43 @@ mwifiex_cfg80211_tdls_cancel_chan_switch(struct wiphy *wiphy,
 	}
 }
 
+static int
+mwifiex_cfg80211_uap_add_station(struct mwifiex_private *priv, const u8 *mac,
+				 struct station_parameters *params)
+{
+	struct mwifiex_sta_info add_sta;
+	int ret;
+
+	memcpy(add_sta.peer_mac, mac, ETH_ALEN);
+	add_sta.params = params;
+
+	ret = mwifiex_send_cmd(priv, HostCmd_CMD_ADD_NEW_STATION,
+			       HostCmd_ACT_ADD_STA, 0, (void *)&add_sta, true);
+
+	if (!ret) {
+		struct station_info *sinfo;
+
+		sinfo = kzalloc(sizeof(*sinfo), GFP_KERNEL);
+		if (!sinfo)
+			return -ENOMEM;
+
+		cfg80211_new_sta(priv->netdev, mac, sinfo, GFP_KERNEL);
+		kfree(sinfo);
+	}
+
+	return ret;
+}
+
 static int
 mwifiex_cfg80211_add_station(struct wiphy *wiphy, struct net_device *dev,
 			     const u8 *mac, struct station_parameters *params)
 {
 	struct mwifiex_private *priv = mwifiex_netdev_get_priv(dev);
 
+	if (priv->adapter->host_mlme_enabled &&
+	    (GET_BSS_ROLE(priv) == MWIFIEX_BSS_ROLE_UAP))
+		return mwifiex_cfg80211_uap_add_station(priv, mac, params);
+
 	if (!(params->sta_flags_set & BIT(NL80211_STA_FLAG_TDLS_PEER)))
 		return -EOPNOTSUPP;
 
@@ -4192,6 +4246,10 @@ mwifiex_cfg80211_change_station(struct wiphy *wiphy, struct net_device *dev,
 	int ret;
 	struct mwifiex_private *priv = mwifiex_netdev_get_priv(dev);
 
+	if (priv->adapter->host_mlme_enabled &&
+	    (GET_BSS_ROLE(priv) == MWIFIEX_BSS_ROLE_UAP))
+		return 0;
+
 	/* we support change_station handler only for TDLS peers*/
 	if (!(params->sta_flags_set & BIT(NL80211_STA_FLAG_TDLS_PEER)))
 		return -EOPNOTSUPP;
@@ -4661,6 +4719,17 @@ int mwifiex_register_cfg80211(struct mwifiex_adapter *adapter)
 	}
 	wiphy->max_scan_ssids = MWIFIEX_MAX_SSID_LIST_LENGTH;
 	wiphy->max_scan_ie_len = MWIFIEX_MAX_VSIE_LEN;
+	if (adapter->host_mlme_enabled) {
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
@@ -4703,14 +4772,18 @@ int mwifiex_register_cfg80211(struct mwifiex_adapter *adapter)
 
 	ether_addr_copy(wiphy->perm_addr, adapter->perm_addr);
 	wiphy->signal_type = CFG80211_SIGNAL_TYPE_MBM;
-	wiphy->flags |= WIPHY_FLAG_HAVE_AP_SME |
-			WIPHY_FLAG_AP_PROBE_RESP_OFFLOAD |
+	wiphy->flags |= WIPHY_FLAG_AP_PROBE_RESP_OFFLOAD |
 			WIPHY_FLAG_AP_UAPSD |
 			WIPHY_FLAG_HAS_REMAIN_ON_CHANNEL |
 			WIPHY_FLAG_HAS_CHANNEL_SWITCH |
 			WIPHY_FLAG_NETNS_OK |
 			WIPHY_FLAG_PS_ON_BY_DEFAULT;
 
+	if (adapter->host_mlme_enabled)
+		wiphy->flags |= WIPHY_FLAG_REPORTS_OBSS;
+	else
+		wiphy->flags |= WIPHY_FLAG_HAVE_AP_SME;
+
 	if (ISSUPP_TDLS_ENABLED(adapter->fw_cap_info))
 		wiphy->flags |= WIPHY_FLAG_SUPPORTS_TDLS |
 				WIPHY_FLAG_TDLS_EXTERNAL_SETUP;
diff --git a/drivers/net/wireless/marvell/mwifiex/cmdevt.c b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
index 3dd6db3cc4c3..ecf6431c3854 100644
--- a/drivers/net/wireless/marvell/mwifiex/cmdevt.c
+++ b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
@@ -635,6 +635,8 @@ int mwifiex_send_cmd(struct mwifiex_private *priv, u16 cmd_no,
 		case HostCmd_CMD_UAP_STA_DEAUTH:
 		case HOST_CMD_APCMD_SYS_RESET:
 		case HOST_CMD_APCMD_STA_LIST:
+		case HostCmd_CMD_CHAN_REPORT_REQUEST:
+		case HostCmd_CMD_ADD_NEW_STATION:
 			ret = mwifiex_uap_prepare_cmd(priv, cmd_no, cmd_action,
 						      cmd_oid, data_buf,
 						      cmd_ptr);
diff --git a/drivers/net/wireless/marvell/mwifiex/fw.h b/drivers/net/wireless/marvell/mwifiex/fw.h
index 4cd82120832e..98e43f551fe7 100644
--- a/drivers/net/wireless/marvell/mwifiex/fw.h
+++ b/drivers/net/wireless/marvell/mwifiex/fw.h
@@ -210,6 +210,7 @@ enum MWIFIEX_802_11_PRIVACY_FILTER {
 #define TLV_TYPE_CHAN_ATTR_CFG      (PROPRIETARY_TLV_BASE_ID + 237)
 #define TLV_TYPE_MAX_CONN           (PROPRIETARY_TLV_BASE_ID + 279)
 #define TLV_TYPE_HOST_MLME          (PROPRIETARY_TLV_BASE_ID + 307)
+#define TLV_TYPE_UAP_STA_FLAGS      (PROPRIETARY_TLV_BASE_ID + 313)
 #define TLV_TYPE_SAE_PWE_MODE       (PROPRIETARY_TLV_BASE_ID + 339)
 
 #define MWIFIEX_TX_DATA_BUF_SIZE_2K        2048
@@ -406,6 +407,7 @@ enum MWIFIEX_802_11_PRIVACY_FILTER {
 #define HostCmd_CMD_STA_CONFIGURE		      0x023f
 #define HostCmd_CMD_CHAN_REGION_CFG		      0x0242
 #define HostCmd_CMD_PACKET_AGGR_CTRL		      0x0251
+#define HostCmd_CMD_ADD_NEW_STATION		      0x025f
 
 #define PROTOCOL_NO_SECURITY        0x01
 #define PROTOCOL_STATIC_WEP         0x02
@@ -416,6 +418,7 @@ enum MWIFIEX_802_11_PRIVACY_FILTER {
 #define KEY_MGMT_NONE               0x04
 #define KEY_MGMT_PSK                0x02
 #define KEY_MGMT_EAP                0x01
+#define KEY_MGMT_SAE                0x400
 #define CIPHER_TKIP                 0x04
 #define CIPHER_AES_CCMP             0x08
 #define VALID_CIPHER_BITMAP         0x0c
@@ -501,6 +504,9 @@ enum mwifiex_channel_flags {
 #define HostCmd_ACT_GET_TX              0x0008
 #define HostCmd_ACT_GET_BOTH            0x000c
 
+#define HostCmd_ACT_REMOVE_STA          0x0
+#define HostCmd_ACT_ADD_STA             0x1
+
 #define RF_ANTENNA_AUTO                 0xFFFF
 
 #define HostCmd_SET_SEQ_NO_BSS_INFO(seq, num, type) \
@@ -2330,6 +2336,20 @@ struct host_cmd_ds_sta_configure {
 	u8 tlv_buffer[];
 } __packed;
 
+struct mwifiex_ie_types_sta_flag {
+	struct mwifiex_ie_types_header header;
+	__le32 sta_flags;
+} __packed;
+
+struct host_cmd_ds_add_station {
+	__le16 action;
+	__le16 aid;
+	u8 peer_mac[ETH_ALEN];
+	__le32 listen_interval;
+	__le16 cap_info;
+	u8 tlv[];
+} __packed;
+
 struct host_cmd_ds_command {
 	__le16 command;
 	__le16 size;
@@ -2408,6 +2428,7 @@ struct host_cmd_ds_command {
 		struct host_cmd_ds_chan_region_cfg reg_cfg;
 		struct host_cmd_ds_pkt_aggr_ctrl pkt_aggr_ctrl;
 		struct host_cmd_ds_sta_configure sta_cfg;
+		struct host_cmd_ds_add_station sta_info;
 	} params;
 } __packed;
 
diff --git a/drivers/net/wireless/marvell/mwifiex/ioctl.h b/drivers/net/wireless/marvell/mwifiex/ioctl.h
index 091e7ca79376..80ba79ca74c5 100644
--- a/drivers/net/wireless/marvell/mwifiex/ioctl.h
+++ b/drivers/net/wireless/marvell/mwifiex/ioctl.h
@@ -157,6 +157,11 @@ struct mwifiex_bss_info {
 	u8 bssid[ETH_ALEN];
 };
 
+struct mwifiex_sta_info {
+	u8 peer_mac[ETH_ALEN];
+	struct station_parameters *params;
+};
+
 #define MAX_NUM_TID     8
 
 #define MAX_RX_WINSIZE  64
diff --git a/drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c b/drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c
index 7b69d27e0c0e..9c53825f222d 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c
@@ -1398,6 +1398,8 @@ int mwifiex_process_sta_cmdresp(struct mwifiex_private *priv, u16 cmdresp_no,
 		break;
 	case HostCmd_CMD_UAP_STA_DEAUTH:
 		break;
+	case HostCmd_CMD_ADD_NEW_STATION:
+		break;
 	case HOST_CMD_APCMD_SYS_RESET:
 		break;
 	case HostCmd_CMD_MEF_CFG:
diff --git a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
index e78a201cd150..1e7f4afe9960 100644
--- a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
+++ b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
@@ -72,6 +72,10 @@ int mwifiex_set_secure_params(struct mwifiex_private *priv,
 				bss_config->key_mgmt = KEY_MGMT_PSK;
 			}
 			break;
+		case WLAN_AKM_SUITE_SAE:
+			bss_config->protocol = PROTOCOL_WPA2;
+			bss_config->key_mgmt = KEY_MGMT_SAE;
+			break;
 		default:
 			break;
 		}
@@ -743,6 +747,28 @@ mwifiex_cmd_uap_sys_config(struct host_cmd_ds_command *cmd, u16 cmd_action,
 	return 0;
 }
 
+/* This function prepares AP start up command with or without host MLME
+ */
+static void mwifiex_cmd_uap_bss_start(struct mwifiex_private *priv,
+				     struct host_cmd_ds_command *cmd)
+{
+	struct mwifiex_ie_types_host_mlme *tlv;
+	int size;
+
+	cmd->command = cpu_to_le16(HostCmd_CMD_UAP_BSS_START);
+	size = S_DS_GEN;
+
+	if (priv->adapter->host_mlme_enabled) {
+		tlv = (struct mwifiex_ie_types_host_mlme *)((u8 *)cmd + size);
+		tlv->header.type = cpu_to_le16(TLV_TYPE_HOST_MLME);
+		tlv->header.len = cpu_to_le16(sizeof(tlv->host_mlme));
+		tlv->host_mlme = 1;
+		size += sizeof(struct mwifiex_ie_types_host_mlme);
+	}
+
+	cmd->size = cpu_to_le16(size);
+}
+
 /* This function prepares AP specific deauth command with mac supplied in
  * function parameter.
  */
@@ -760,6 +786,144 @@ static int mwifiex_cmd_uap_sta_deauth(struct mwifiex_private *priv,
 	return 0;
 }
 
+/* This function prepares AP specific add station command.
+ */
+static int mwifiex_cmd_uap_add_station(struct mwifiex_private *priv,
+				       struct host_cmd_ds_command *cmd,
+				       u16 cmd_action, void *data_buf)
+{
+	struct host_cmd_ds_add_station *new_sta = &cmd->params.sta_info;
+	struct mwifiex_sta_info *add_sta = (struct mwifiex_sta_info *)data_buf;
+	struct station_parameters *params = add_sta->params;
+	struct mwifiex_sta_node *sta_ptr;
+	u8 *pos;
+	u8 qos_capa;
+	u16 header_len = sizeof(struct mwifiex_ie_types_header);
+	u16 tlv_len;
+	int size;
+	struct mwifiex_ie_types_data *tlv;
+	struct mwifiex_ie_types_sta_flag *sta_flag;
+	int i;
+
+	cmd->command = cpu_to_le16(HostCmd_CMD_ADD_NEW_STATION);
+	new_sta->action = cpu_to_le16(cmd_action);
+	size = sizeof(struct host_cmd_ds_add_station) + S_DS_GEN;
+
+	if (cmd_action == HostCmd_ACT_ADD_STA)
+		sta_ptr = mwifiex_add_sta_entry(priv, add_sta->peer_mac);
+	else
+		sta_ptr = mwifiex_get_sta_entry(priv, add_sta->peer_mac);
+
+	if (!sta_ptr)
+		return -1;
+
+	memcpy(new_sta->peer_mac, add_sta->peer_mac, ETH_ALEN);
+
+	if (cmd_action == HostCmd_ACT_REMOVE_STA)
+		goto done;
+
+	new_sta->aid = cpu_to_le16(params->aid);
+	new_sta->listen_interval = cpu_to_le32(params->listen_interval);
+	new_sta->cap_info = cpu_to_le16(params->capability);
+
+	pos = new_sta->tlv;
+
+	if (params->sta_flags_set & NL80211_STA_FLAG_WME)
+		sta_ptr->is_wmm_enabled = 1;
+	sta_flag = (struct mwifiex_ie_types_sta_flag *)pos;
+	sta_flag->header.type = cpu_to_le16(TLV_TYPE_UAP_STA_FLAGS);
+	sta_flag->header.len = cpu_to_le16(sizeof(__le32));
+	sta_flag->sta_flags = cpu_to_le32(params->sta_flags_set);
+	pos += sizeof(struct mwifiex_ie_types_sta_flag);
+	size += sizeof(struct mwifiex_ie_types_sta_flag);
+
+	if (params->ext_capab_len) {
+		tlv = (struct mwifiex_ie_types_data *)pos;
+		tlv->header.type = cpu_to_le16(WLAN_EID_EXT_CAPABILITY);
+		tlv_len = params->ext_capab_len;
+		tlv->header.len = cpu_to_le16(tlv_len);
+		memcpy(tlv->data, params->ext_capab, tlv_len);
+		pos += (header_len + tlv_len);
+		size += (header_len + tlv_len);
+	}
+
+	if (params->link_sta_params.supported_rates_len) {
+		tlv = (struct mwifiex_ie_types_data *)pos;
+		tlv->header.type = cpu_to_le16(WLAN_EID_SUPP_RATES);
+		tlv_len = params->link_sta_params.supported_rates_len;
+		tlv->header.len = cpu_to_le16(tlv_len);
+		memcpy(tlv->data,
+		       params->link_sta_params.supported_rates, tlv_len);
+		pos += (header_len + tlv_len);
+		size += (header_len + tlv_len);
+	}
+
+	if (params->uapsd_queues || params->max_sp) {
+		tlv = (struct mwifiex_ie_types_data *)pos;
+		tlv->header.type = cpu_to_le16(WLAN_EID_QOS_CAPA);
+		tlv_len = sizeof(qos_capa);
+		tlv->header.len = cpu_to_le16(tlv_len);
+		qos_capa = params->uapsd_queues | (params->max_sp << 5);
+		memcpy(tlv->data, &qos_capa, tlv_len);
+		pos += (header_len + tlv_len);
+		size += (header_len + tlv_len);
+		sta_ptr->is_wmm_enabled = 1;
+	}
+
+	if (params->link_sta_params.ht_capa) {
+		tlv = (struct mwifiex_ie_types_data *)pos;
+		tlv->header.type = cpu_to_le16(WLAN_EID_HT_CAPABILITY);
+		tlv_len = sizeof(struct ieee80211_ht_cap);
+		tlv->header.len = cpu_to_le16(tlv_len);
+		memcpy(tlv->data, params->link_sta_params.ht_capa, tlv_len);
+		pos += (header_len + tlv_len);
+		size += (header_len + tlv_len);
+		sta_ptr->is_11n_enabled = 1;
+		sta_ptr->max_amsdu =
+			le16_to_cpu(params->link_sta_params.ht_capa->cap_info) &
+			IEEE80211_HT_CAP_MAX_AMSDU ?
+			MWIFIEX_TX_DATA_BUF_SIZE_8K :
+			MWIFIEX_TX_DATA_BUF_SIZE_4K;
+	}
+
+	if (params->link_sta_params.vht_capa) {
+		tlv = (struct mwifiex_ie_types_data *)pos;
+		tlv->header.type = cpu_to_le16(WLAN_EID_VHT_CAPABILITY);
+		tlv_len = sizeof(struct ieee80211_vht_cap);
+		tlv->header.len = cpu_to_le16(tlv_len);
+		memcpy(tlv->data, params->link_sta_params.vht_capa, tlv_len);
+		pos += (header_len + tlv_len);
+		size += (header_len + tlv_len);
+		sta_ptr->is_11ac_enabled = 1;
+	}
+
+	if (params->link_sta_params.opmode_notif_used) {
+		tlv = (struct mwifiex_ie_types_data *)pos;
+		tlv->header.type = cpu_to_le16(WLAN_EID_OPMODE_NOTIF);
+		tlv_len = sizeof(u8);
+		tlv->header.len = cpu_to_le16(tlv_len);
+		memcpy(tlv->data, &params->link_sta_params.opmode_notif,
+		       tlv_len);
+		pos += (header_len + tlv_len);
+		size += (header_len + tlv_len);
+	}
+
+	for (i = 0; i < MAX_NUM_TID; i++) {
+		if (sta_ptr->is_11n_enabled)
+			sta_ptr->ampdu_sta[i] =
+				      priv->aggr_prio_tbl[i].ampdu_user;
+		else
+			sta_ptr->ampdu_sta[i] = BA_STREAM_NOT_ALLOWED;
+	}
+
+	memset(sta_ptr->rx_seq, 0xff, sizeof(sta_ptr->rx_seq));
+
+done:
+	cmd->size = cpu_to_le16(size);
+
+	return 0;
+}
+
 /* This function prepares the AP specific commands before sending them
  * to the firmware.
  * This is a generic function which calls specific command preparation
@@ -777,6 +941,8 @@ int mwifiex_uap_prepare_cmd(struct mwifiex_private *priv, u16 cmd_no,
 			return -1;
 		break;
 	case HostCmd_CMD_UAP_BSS_START:
+		mwifiex_cmd_uap_bss_start(priv, cmd);
+		break;
 	case HostCmd_CMD_UAP_BSS_STOP:
 	case HOST_CMD_APCMD_SYS_RESET:
 	case HOST_CMD_APCMD_STA_LIST:
@@ -792,6 +958,11 @@ int mwifiex_uap_prepare_cmd(struct mwifiex_private *priv, u16 cmd_no,
 							  data_buf))
 			return -1;
 		break;
+	case HostCmd_CMD_ADD_NEW_STATION:
+		if (mwifiex_cmd_uap_add_station(priv, cmd, cmd_action,
+						data_buf))
+			return -1;
+		break;
 	default:
 		mwifiex_dbg(priv->adapter, ERROR,
 			    "PREP_CMD: unknown cmd %#x\n", cmd_no);
diff --git a/drivers/net/wireless/marvell/mwifiex/util.c b/drivers/net/wireless/marvell/mwifiex/util.c
index af82f0401c63..c0614c246b5f 100644
--- a/drivers/net/wireless/marvell/mwifiex/util.c
+++ b/drivers/net/wireless/marvell/mwifiex/util.c
@@ -497,6 +497,30 @@ mwifiex_process_mgmt_packet(struct mwifiex_private *priv,
 		cfg80211_rx_mlme_mgmt(priv->netdev, skb->data, pkt_len);
 	}
 
+	if (priv->adapter->host_mlme_enabled &&
+	    (GET_BSS_ROLE(priv) == MWIFIEX_BSS_ROLE_UAP)) {
+		if (ieee80211_is_auth(ieee_hdr->frame_control))
+			mwifiex_dbg(priv->adapter, MSG,
+				    "auth: receive auth from %pM\n",
+				    ieee_hdr->addr2);
+		if (ieee80211_is_deauth(ieee_hdr->frame_control))
+			mwifiex_dbg(priv->adapter, MSG,
+				    "auth: receive deauth from %pM\n",
+				    ieee_hdr->addr2);
+		if (ieee80211_is_disassoc(ieee_hdr->frame_control))
+			mwifiex_dbg(priv->adapter, MSG,
+				    "assoc: receive disassoc from %pM\n",
+				    ieee_hdr->addr2);
+		if (ieee80211_is_assoc_req(ieee_hdr->frame_control))
+			mwifiex_dbg(priv->adapter, MSG,
+				    "assoc: receive assoc req from %pM\n",
+				    ieee_hdr->addr2);
+		if (ieee80211_is_reassoc_req(ieee_hdr->frame_control))
+			mwifiex_dbg(priv->adapter, MSG,
+				    "assoc: receive reassoc req from %pM\n",
+				    ieee_hdr->addr2);
+	}
+
 	cfg80211_rx_mgmt(&priv->wdev, priv->roc_cfg.chan.center_freq,
 			 CAL_RSSI(rx_pd->snr, rx_pd->nf), skb->data, pkt_len,
 			 0);
-- 
2.25.1



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5627FB434
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 09:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344135AbjK1Id5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 03:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjK1Idy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 03:33:54 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2047.outbound.protection.outlook.com [40.107.22.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A5110C3;
        Tue, 28 Nov 2023 00:33:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PoG12SKW+4TGcaiPtQz6c8oKoR7XM1mLdlNbP6m9BQ2PeCtJRhSY3i//s9kzw+w0qnJIhfaX/xHhir0BKaNquPCtlu1vB4Oqen0vBo8ro2YlMUey9sECO4q9I6Cer5HFIA/gHKoe+eTRaz6pub2iTPfiKVsljiU/qB8cLh/gMN7/a2837XnqRmErgFOKqhj5OeXhT2fSj+JaywLX1wtlwVLD4+jznbsDYilX6vDnoH5i2flfVkZj5koxmCoJ2bWfJtc1jbYwknJX7lhO0kEnVWNs5el0NUVqE1y0MyyJh5dpbaIOKtJpVZiNwZvm++3W4c68io60piGEENKQUBp1rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YCL1iomnw4k7Rk1/ycXqY7MZHK26xof6L3vDXJg/Kmk=;
 b=R4YK+oF7O2KWJ3hZ/Zd0MnS433dHIr8EujglgL1KmF3CPkfYo9YTBv9Kbo3wQLLKB0pC/Bdi3kfvFFai+TFFR7KFO2EvHBLXmBqk4a2X44VLv5HKxs9S9u/Uy913RXY4gYltUrdDDgYMNm5SX9KKv7QnJCLGBmohaAqi99MEJjXsTwX+spOrWxyKSnUHN3IM/OZCo5Dkva5UHdlvXq87fTl4vjXI92shoaGXC90aIYuu9Mx1R5JPeWrW3EdYFECAJmsQRkTeD4gGZt7kK83jRpYtTZ3k3rpwffx9ViLLlvtv/susma/zRQuZpj9W1zvt8Yp4d8vJYlTVHGhVC36o7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YCL1iomnw4k7Rk1/ycXqY7MZHK26xof6L3vDXJg/Kmk=;
 b=o9S5/jiXSKwgb0m3twNtpolMr5StS2ZHfEgh+4/c2/gZ3K5Ry0Tggg69FKUXXvpUMopf1cl57Su27Xm3OcdV/92VpGI8DXxFrHDfu2TfO3kHKbfncvymIAHC8Q90ZW0WntfgFGN2zdSM6XhLWmoDVSQTVmZF4NOIm/DdQSKgt7c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by PAXPR04MB8653.eurprd04.prod.outlook.com (2603:10a6:102:21c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Tue, 28 Nov
 2023 08:32:16 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b%7]) with mapi id 15.20.7046.015; Tue, 28 Nov 2023
 08:32:16 +0000
From:   David Lin <yu-hao.lin@nxp.com>
To:     linux-wireless@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, briannorris@chromium.org,
        kvalo@kernel.org, francesco@dolcini.it, tsung-hsien.hsieh@nxp.com,
        David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH v7 11/12] wifi: mwifiex: misc modifications for review comments.
Date:   Tue, 28 Nov 2023 16:31:14 +0800
Message-Id: <20231128083115.613235-12-yu-hao.lin@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: b37ad126-0716-464a-39d9-08dbefec86f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o3CEf8S8ccryPBHKa9O08fKYaztG8U4JGD6waGa0VqMJpTCCB91hW/ZdwQGMNE0FaExCwSNQBgzKGsJ6KbcJJgB1ElNsBUDxSftT86RBfQeVCpEBW/kPMeXyU4ZpLVL13lR7YG+r+Jl2xSN9i6updUe1WBiT8izqeAaSPO43A8mStsxH+gPF1PHxIwQdKiZdQX1ylCObskOvPmaISDcQNAuqsUfq6wzqCG0xNcJBSkybF9nK9cbY0ChI3A1giEcmgMTkSbyVFynLYXf3Hpz4iVUyqz6WQX4fLX1tyIpLiqShq0ZtIdK1Fu/yNClwp0gDQ9eYD7s/1Hsm+xuL+676zEqT8wPSowq9TqA8CR3mpeBJn0srGzALukoyOGafm1xzWvV9xPpvyvhgLTQjDj8jP91y7ysmiGsflYqDNx9IxJocDJHMYZFEFJh/K15uHKtIL6COHv7cqG3qIRkj7LVzL9l8HKKIJmQC7+TiS+d2Sc0jbcwNEhDjfNaBgGmc44UeqHaBeVkCqosnUbh9S2taZ0WYIbVwahMYYhnq1CHzvPzibPxXM6i5yrSAW6J1Hi0q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(366004)(376002)(39860400002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(83380400001)(66946007)(478600001)(6512007)(52116002)(6486002)(86362001)(66556008)(66476007)(6916009)(316002)(8676002)(4326008)(8936002)(6506007)(1076003)(2616005)(5660300002)(30864003)(38100700002)(41300700001)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5Ykc9VMaUxsiNKRaYKIXmMeoWcz2sm4NT36ZsKI5ozp/JrvdDgWj5rrh5uMy?=
 =?us-ascii?Q?QcUMuBozSJ4HbKj758A2w0MHTBFZ5jTS6XQFH9EWqthaZhY5mr74fhxR3q7Q?=
 =?us-ascii?Q?dGob1M5AwIi10RM0iKKS33T3Pa2IuOE6OTMHrhUcf1eWzRZsVIHazMCUzXNR?=
 =?us-ascii?Q?6XDHXclGP5BHvvl5VCNU6gL7/zVAj17+u/0hSYkbr7N1Njw+S6/cMkN/8JRz?=
 =?us-ascii?Q?ZUy2Dbx5DBMcchAxUWEcScMG0awSf0Lg3dBiJ7t06v8J+ivZ+bAlQjzf62po?=
 =?us-ascii?Q?MZp617fswB+grJzEoelN/RUIqAk+qihYxUqLgFGeSaQ01GDPFScrPRd3Y8r3?=
 =?us-ascii?Q?BAT5tFvXnK7gYKgkY9jyaH0QeNCdozgHGjGieOQ402XlGDMW5YvwscEQ2m4z?=
 =?us-ascii?Q?Ws7jIBtMD5ddQusmSVi1ocKsMQ59eBrLu7oeXJg1oUlDuYqzkDnW0mZQ/WFQ?=
 =?us-ascii?Q?JnPPRT2BJdH368ZPMvA/jHlpWpoYWYmZYGPcOtqPLYu+1Yj2yPnF6/ql/aVN?=
 =?us-ascii?Q?wwuUOjWf/SyYZrIVUS+iR2GwLgrTkFdOOkcqb/ZCtsaLTtqwB3YivKkl1MPy?=
 =?us-ascii?Q?qYN+thz9VSZiX84p0SSxukcjXUcshjlmQNgFVH+coqdKlRM9wjk/LZ91y0NP?=
 =?us-ascii?Q?xlCWb1IBTqdumfLH66GibiAIDz7Owri245c/hhcNVSeQzaj1FSTrYfH2OJto?=
 =?us-ascii?Q?65YHTqwMUvl0/hBA3+QPsZi+KIRUchgeBgwQ28H2Slu9WgEY4Enm3B2+tTSw?=
 =?us-ascii?Q?E2lKg3vTCcgrs/4WBCAS9ULtqLdhrK4dqsZG1ns1fwKxUvqSHKQiMDcnNAMb?=
 =?us-ascii?Q?hbtCZqBIkYHsHhwbnPVgLj4Z/hJvupb8Xt1XK38a2GX6yXMMxTPT+grXP/EB?=
 =?us-ascii?Q?6OtH2cSAcjWKqbrsm5iYjkICvhYlRz2BWIwyeDDfSOwoW0gQ7xb9CN5nHXRi?=
 =?us-ascii?Q?/9aH8ETm9mKefihEvWtsRz9mJm/yYustMr8l17jJeupx9rV3NaK9xC3zuYiP?=
 =?us-ascii?Q?FHH7zFK6s2Y8YAZzClfp1gXjutvN2+womSWtIgNVCGd9T9n6yFtVkALzuk5l?=
 =?us-ascii?Q?K77UKc1qnC4irx4lvo22ZJ0x3AFg72MgMDERKV2WN/R1VHqfMjioVC7RMrTx?=
 =?us-ascii?Q?tmwCsAYI2Sli/Z1R4s6jYhLIe2+i+nPXwvj7ddwPcaj4Sck/SvjjLg0rnyYL?=
 =?us-ascii?Q?AwnFuqL0NaYAk5BY3KdsUtQJDxpICfnUDKH3vMdErzLjZG3G+Sm/D4vKiUBs?=
 =?us-ascii?Q?2LBpVMHCYgpXkK/3Yyxjg7AXf8OFodwp2weyX5t7E3g6hQ2tiUBtF7plTzAY?=
 =?us-ascii?Q?W5blOKFmvvtZ8JgfbhcXBoTbctYyfj+Lhs9uoLWpMKi1jjXXJ2FmFh/eiArt?=
 =?us-ascii?Q?6qCAgQT3nfJyInde8CurX8WeTId394zoyevkCsd5HnP4Y5oCrkJVnvNL1rDV?=
 =?us-ascii?Q?crio0I0Ie12L9UvPjs0X5E6iFzaxUEIx0QRKPlNZtMdeQq9J2hPbH+NwvJDu?=
 =?us-ascii?Q?lreLK/zBL85M9DjaEgm13FwhSVeDgFFAjVl20oBBpuXr/xs7yoVyjJRmPubq?=
 =?us-ascii?Q?g+z/7APTSqOQF8dgVHjFt+rTHuDqVnmCw7iZRbxmTR8qWFJTtxuQcfj6NbVy?=
 =?us-ascii?Q?U4Yxj14YKUEnrGcQjQKGVwipjSWc3pHBMbbWvLjExQDo?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b37ad126-0716-464a-39d9-08dbefec86f7
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 08:32:16.2247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dx8YI4A59RPSXufGsaOWLj2EsqKkaQJgqbc1HDRVRJqXD5MUDX4QHPRWyaxD1yzL88jIHHPIUfabhLl+JkiTEQ==
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

1. Moved struct mwifiex_ieee80211_mgmt from cfg80211.c to fw.h.
2. Defined WLAN_AUTH_NONE instead of using 0xFFFF directly.
3. Changed host_mlme of struct mwifiex_adapter to host_mlme_enabled.
4. Moved mwifiex_check_key_api_ver() to end of mwifiex_ret_get_hw_spec().
5. Redefined MWIFIEX_MGMT_HEADER_LEN and MWIFIEX_AUTH_BODY_LEN.

Signed-off-by: David Lin <yu-hao.lin@nxp.com>
---
 .../net/wireless/marvell/mwifiex/cfg80211.c   | 47 +++++--------------
 drivers/net/wireless/marvell/mwifiex/cmdevt.c |  9 ++--
 drivers/net/wireless/marvell/mwifiex/decl.h   | 29 ++++++++----
 drivers/net/wireless/marvell/mwifiex/fw.h     | 25 ++++++++++
 drivers/net/wireless/marvell/mwifiex/init.c   |  2 +-
 drivers/net/wireless/marvell/mwifiex/join.c   | 10 ++--
 drivers/net/wireless/marvell/mwifiex/main.h   |  2 +-
 drivers/net/wireless/marvell/mwifiex/sdio.c   |  2 +-
 .../net/wireless/marvell/mwifiex/sta_event.c  | 10 ++--
 .../net/wireless/marvell/mwifiex/sta_ioctl.c  |  2 +-
 .../net/wireless/marvell/mwifiex/uap_cmd.c    |  2 +-
 drivers/net/wireless/marvell/mwifiex/util.c   |  6 +--
 12 files changed, 79 insertions(+), 67 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index 2792996e027f..f840b0559bd3 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -57,31 +57,6 @@ ieee80211_iface_combination mwifiex_iface_comb_ap_sta_drcs = {
 	.beacon_int_infra_match = true,
 };
 
-struct mwifiex_ieee80211_mgmt {
-	__le16 frame_control;
-	__le16 duration;
-	u8 da[ETH_ALEN];
-	u8 sa[ETH_ALEN];
-	u8 bssid[ETH_ALEN];
-	__le16 seq_ctrl;
-	u8 addr4[ETH_ALEN];
-	union {
-		struct {
-			__le16 auth_alg;
-			__le16 auth_transaction;
-			__le16 status_code;
-			/* possibly followed by Challenge text */
-			u8 variable[];
-		} __packed auth;
-		struct {
-			__le16 capab_info;
-			__le16 listen_interval;
-			/* followed by SSID and Supported rates */
-			u8 variable[];
-		} __packed assoc_req;
-	} u;
-} __pack;
-
 /*
  * This function maps the nl802.11 channel type into driver channel type.
  *
@@ -551,7 +526,7 @@ mwifiex_cfg80211_set_default_mgmt_key(struct wiphy *wiphy,
 
 	wiphy_dbg(wiphy, "set default mgmt key, key index=%d\n", key_index);
 
-	if (priv->adapter->host_mlme)
+	if (priv->adapter->host_mlme_enabled)
 		return 0;
 
 	memset(&encrypt_key, 0, sizeof(struct mwifiex_ds_encrypt_key));
@@ -3683,7 +3658,7 @@ static int mwifiex_set_rekey_data(struct wiphy *wiphy, struct net_device *dev,
 	if (!ISSUPP_FIRMWARE_SUPPLICANT(priv->adapter->fw_cap_info))
 		return -EOPNOTSUPP;
 
-	if (priv->adapter->host_mlme)
+	if (priv->adapter->host_mlme_enabled)
 		return 0;
 
 	return mwifiex_send_cmd(priv, HostCmd_CMD_GTK_REKEY_OFFLOAD_CFG,
@@ -4033,7 +4008,7 @@ mwifiex_cfg80211_add_station(struct wiphy *wiphy, struct net_device *dev,
 {
 	struct mwifiex_private *priv = mwifiex_netdev_get_priv(dev);
 
-	if (priv->adapter->host_mlme &&
+	if (priv->adapter->host_mlme_enabled &&
 	    (GET_BSS_ROLE(priv) == MWIFIEX_BSS_ROLE_UAP))
 		return mwifiex_cfg80211_uap_add_station(priv, mac, params);
 
@@ -4274,7 +4249,7 @@ mwifiex_cfg80211_change_station(struct wiphy *wiphy, struct net_device *dev,
 	int ret;
 	struct mwifiex_private *priv = mwifiex_netdev_get_priv(dev);
 
-	if (priv->adapter->host_mlme &&
+	if (priv->adapter->host_mlme_enabled &&
 	    (GET_BSS_ROLE(priv) == MWIFIEX_BSS_ROLE_UAP))
 		return 0;
 
@@ -4426,8 +4401,8 @@ mwifiex_cfg80211_authenticate(struct wiphy *wiphy,
 	}
 
 	mgmt->u.auth.auth_alg = cpu_to_le16(auth_alg);
-	mgmt->u.auth.auth_transaction = trans;
-	mgmt->u.auth.status_code = status_code;
+	mgmt->u.auth.auth_transaction = cpu_to_le16(trans);
+	mgmt->u.auth.status_code = cpu_to_le16(status_code);
 
 	if (req->ie && req->ie_len) {
 		if (!varptr)
@@ -4545,7 +4520,7 @@ mwifiex_cfg80211_associate(struct wiphy *wiphy, struct net_device *dev,
 
 	if (ret) {
 		priv->auth_flag = 0;
-		priv->auth_alg = 0xFFFF;
+		priv->auth_alg = WLAN_AUTH_NONE;
 		eth_zero_addr(priv->cfg_bssid);
 	}
 
@@ -4735,7 +4710,7 @@ int mwifiex_register_cfg80211(struct mwifiex_adapter *adapter)
 			    "%s: creating new wiphy\n", __func__);
 		return -ENOMEM;
 	}
-	if (adapter->host_mlme) {
+	if (adapter->host_mlme_enabled) {
 		mwifiex_cfg80211_ops.auth = mwifiex_cfg80211_authenticate;
 		mwifiex_cfg80211_ops.assoc = mwifiex_cfg80211_associate;
 		mwifiex_cfg80211_ops.deauth = mwifiex_cfg80211_deauthenticate;
@@ -4747,7 +4722,7 @@ int mwifiex_register_cfg80211(struct mwifiex_adapter *adapter)
 	}
 	wiphy->max_scan_ssids = MWIFIEX_MAX_SSID_LIST_LENGTH;
 	wiphy->max_scan_ie_len = MWIFIEX_MAX_VSIE_LEN;
-	if (adapter->host_mlme) {
+	if (adapter->host_mlme_enabled) {
 		mwifiex_mgmt_stypes[NL80211_IFTYPE_AP].tx = 0xffff;
 		mwifiex_mgmt_stypes[NL80211_IFTYPE_AP].rx =
 			BIT(IEEE80211_STYPE_ASSOC_REQ >> 4) |
@@ -4807,7 +4782,7 @@ int mwifiex_register_cfg80211(struct mwifiex_adapter *adapter)
 			WIPHY_FLAG_NETNS_OK |
 			WIPHY_FLAG_PS_ON_BY_DEFAULT;
 
-	if (adapter->host_mlme)
+	if (adapter->host_mlme_enabled)
 		wiphy->flags |= WIPHY_FLAG_REPORTS_OBSS;
 	else
 		wiphy->flags |= WIPHY_FLAG_HAVE_AP_SME;
@@ -4841,7 +4816,7 @@ int mwifiex_register_cfg80211(struct mwifiex_adapter *adapter)
 			   NL80211_FEATURE_LOW_PRIORITY_SCAN |
 			   NL80211_FEATURE_NEED_OBSS_SCAN;
 
-	if (adapter->host_mlme)
+	if (adapter->host_mlme_enabled)
 		wiphy->features |= NL80211_FEATURE_SAE;
 
 	if (ISSUPP_ADHOC_ENABLED(adapter->fw_cap_info))
diff --git a/drivers/net/wireless/marvell/mwifiex/cmdevt.c b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
index c8d94cc6706f..85429c51c407 100644
--- a/drivers/net/wireless/marvell/mwifiex/cmdevt.c
+++ b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
@@ -1499,11 +1499,11 @@ int mwifiex_cmd_get_hw_spec(struct mwifiex_private *priv,
 
 static void mwifiex_check_key_api_ver(struct mwifiex_adapter *adapter)
 {
-	if (adapter->host_mlme) {
+	if (adapter->host_mlme_enabled) {
 		if (adapter->key_api_major_ver != KEY_API_VER_MAJOR_V2)
-			adapter->host_mlme = false;
+			adapter->host_mlme_enabled = false;
 		mwifiex_dbg(adapter, MSG, "host_mlme: %s, key_api: %d\n",
-			    adapter->host_mlme ? "enable" : "disable",
+			    adapter->host_mlme_enabled ? "enable" : "disable",
 			    adapter->key_api_major_ver);
 	}
 }
@@ -1617,7 +1617,6 @@ int mwifiex_ret_get_hw_spec(struct mwifiex_private *priv,
 						    "key_api v%d.%d\n",
 						    adapter->key_api_major_ver,
 						    adapter->key_api_minor_ver);
-					mwifiex_check_key_api_ver(adapter);
 					break;
 				case FW_API_VER_ID:
 					adapter->fw_api_ver =
@@ -1712,6 +1711,8 @@ int mwifiex_ret_get_hw_spec(struct mwifiex_private *priv,
 	if (adapter->fw_api_ver == MWIFIEX_FW_V15)
 		adapter->scan_chan_gap_enabled = true;
 
+	mwifiex_check_key_api_ver(adapter);
+
 	return 0;
 }
 
diff --git a/drivers/net/wireless/marvell/mwifiex/decl.h b/drivers/net/wireless/marvell/mwifiex/decl.h
index f9b21b13d6c3..be42040822b2 100644
--- a/drivers/net/wireless/marvell/mwifiex/decl.h
+++ b/drivers/net/wireless/marvell/mwifiex/decl.h
@@ -24,10 +24,24 @@
 #define MWIFIEX_RX_HEADROOM	    64
 #define MAX_TXPD_SZ		    32
 #define INTF_HDR_ALIGN		     4
-/* frmctl + durationid + addr1 + addr2 + addr3 + seqctl + addr4 */
-#define MWIFIEX_MGMT_HEADER_LEN   (2 + 2 + 6 + 6 + 6 + 2 + 6)
-/* 6   = auth_alg + auth_transaction + auth_status */
-#define MWIFIEX_AUTH_BODY_LEN     6
+#define MWIFIEX_MIN_DATA_HEADER_LEN (MWIFIEX_DMA_ALIGN_SZ + INTF_HDR_ALIGN + \
+				     MAX_TXPD_SZ)
+
+#define MWIFIEX_MGMT_FRAME_HEADER_SIZE	8	/* sizeof(pkt_type)
+						 *   + sizeof(tx_control)
+						 */
+
+#define FRMCTL_LEN                2
+#define DURATION_LEN              2
+#define SEQCTL_LEN                2
+#define MWIFIEX_MGMT_HEADER_LEN   (FRMCTL_LEN + FRMCTL_LEN + ETH_ALEN + \
+				   ETH_ALEN + ETH_ALEN + SEQCTL_LEN + ETH_ALEN)
+
+#define AUTH_ALG_LEN              2
+#define AUTH_TRANSACTION_LEN      2
+#define AUTH_STATUS_LEN           2
+#define MWIFIEX_AUTH_BODY_LEN     (AUTH_ALG_LEN + AUTH_TRANSACTION_LEN + \
+				   AUTH_STATUS_LEN)
 
 #define HOST_MLME_AUTH_PENDING    BIT(0)
 #define HOST_MLME_AUTH_DONE       BIT(1)
@@ -35,13 +49,10 @@
 #define HOST_MLME_MGMT_MASK       (BIT(IEEE80211_STYPE_AUTH >> 4) | \
 				   BIT(IEEE80211_STYPE_DEAUTH >> 4) | \
 				   BIT(IEEE80211_STYPE_DISASSOC >> 4))
+
 #define AUTH_TX_DEFAULT_WAIT_TIME 2400
 
-#define MWIFIEX_MIN_DATA_HEADER_LEN (MWIFIEX_DMA_ALIGN_SZ + INTF_HDR_ALIGN + \
-				     MAX_TXPD_SZ)
-#define MWIFIEX_MGMT_FRAME_HEADER_SIZE	8	/* sizeof(pkt_type)
-						 *   + sizeof(tx_control)
-						 */
+#define WLAN_AUTH_NONE            0xFFFF
 
 #define MWIFIEX_MAX_TX_BASTREAM_SUPPORTED	2
 #define MWIFIEX_MAX_RX_BASTREAM_SUPPORTED	16
diff --git a/drivers/net/wireless/marvell/mwifiex/fw.h b/drivers/net/wireless/marvell/mwifiex/fw.h
index 699c7ffcd0e5..0f9d860b5d59 100644
--- a/drivers/net/wireless/marvell/mwifiex/fw.h
+++ b/drivers/net/wireless/marvell/mwifiex/fw.h
@@ -752,6 +752,31 @@ struct uap_rxpd {
 	u8 flags;
 } __packed;
 
+struct mwifiex_ieee80211_mgmt {
+	__le16 frame_control;
+	__le16 duration;
+	u8 da[ETH_ALEN];
+	u8 sa[ETH_ALEN];
+	u8 bssid[ETH_ALEN];
+	__le16 seq_ctrl;
+	u8 addr4[ETH_ALEN];
+	union {
+		struct {
+			__le16 auth_alg;
+			__le16 auth_transaction;
+			__le16 status_code;
+			/* possibly followed by Challenge text */
+			u8 variable[];
+		} __packed auth;
+		struct {
+			__le16 capab_info;
+			__le16 listen_interval;
+			/* followed by SSID and Supported rates */
+			u8 variable[];
+		} __packed assoc_req;
+	} u;
+} __packed;
+
 struct mwifiex_fw_chan_stats {
 	u8 chan_num;
 	u8 bandcfg;
diff --git a/drivers/net/wireless/marvell/mwifiex/init.c b/drivers/net/wireless/marvell/mwifiex/init.c
index 87121018abc6..a336d45b9677 100644
--- a/drivers/net/wireless/marvell/mwifiex/init.c
+++ b/drivers/net/wireless/marvell/mwifiex/init.c
@@ -82,7 +82,7 @@ int mwifiex_init_priv(struct mwifiex_private *priv)
 	priv->data_avg_factor = DEFAULT_DATA_AVG_FACTOR;
 
 	priv->auth_flag = 0;
-	priv->auth_alg = 0xFFFF;
+	priv->auth_alg = WLAN_AUTH_NONE;
 
 	priv->sec_info.wep_enabled = 0;
 	priv->sec_info.authentication_mode = NL80211_AUTHTYPE_OPEN_SYSTEM;
diff --git a/drivers/net/wireless/marvell/mwifiex/join.c b/drivers/net/wireless/marvell/mwifiex/join.c
index 00720c6840ef..06db8e358c01 100644
--- a/drivers/net/wireless/marvell/mwifiex/join.c
+++ b/drivers/net/wireless/marvell/mwifiex/join.c
@@ -511,7 +511,7 @@ int mwifiex_cmd_802_11_associate(struct mwifiex_private *priv,
 			sizeof(struct mwifiex_chan_scan_param_set);
 	}
 
-	if (priv->adapter->host_mlme) {
+	if (priv->adapter->host_mlme_enabled) {
 		host_mlme_tlv = (struct mwifiex_ie_types_host_mlme *)pos;
 		host_mlme_tlv->header.type = cpu_to_le16(TLV_TYPE_HOST_MLME);
 		host_mlme_tlv->header.len =
@@ -672,7 +672,7 @@ int mwifiex_ret_802_11_associate(struct mwifiex_private *priv,
 		goto done;
 	}
 
-	if (adapter->host_mlme) {
+	if (adapter->host_mlme_enabled) {
 		hdr = (struct ieee80211_mgmt *)&resp->params;
 		if (!memcmp(hdr->bssid,
 			    priv->attempted_bss_desc->mac_address,
@@ -724,7 +724,7 @@ int mwifiex_ret_802_11_associate(struct mwifiex_private *priv,
 					    "ASSOC_RESP: UNSPECIFIED failure\n");
 			}
 
-			if (priv->adapter->host_mlme)
+			if (priv->adapter->host_mlme_enabled)
 				priv->assoc_rsp_size = 0;
 		} else {
 			ret = status_code;
@@ -1538,9 +1538,9 @@ int mwifiex_deauthenticate(struct mwifiex_private *priv, u8 *mac)
 	if (!priv->media_connected)
 		return 0;
 
-	if (priv->adapter->host_mlme) {
+	if (priv->adapter->host_mlme_enabled) {
 		priv->auth_flag = 0;
-		priv->auth_alg = 0xFFFF;
+		priv->auth_alg = WLAN_AUTH_NONE;
 		priv->host_mlme_reg = false;
 		priv->mgmt_frame_mask = 0;
 		if (mwifiex_send_cmd(priv, HostCmd_CMD_MGMT_FRAME_REG,
diff --git a/drivers/net/wireless/marvell/mwifiex/main.h b/drivers/net/wireless/marvell/mwifiex/main.h
index f0158d217bb8..b5aef4c92b98 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.h
+++ b/drivers/net/wireless/marvell/mwifiex/main.h
@@ -1010,7 +1010,7 @@ struct mwifiex_adapter {
 	bool is_up;
 
 	bool ext_scan;
-	bool host_mlme;
+	bool host_mlme_enabled;
 	u8 fw_api_ver;
 	u8 key_api_major_ver, key_api_minor_ver;
 	u8 max_p2p_conn, max_sta_conn;
diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.c b/drivers/net/wireless/marvell/mwifiex/sdio.c
index f5039d158f46..e7b488fca52f 100644
--- a/drivers/net/wireless/marvell/mwifiex/sdio.c
+++ b/drivers/net/wireless/marvell/mwifiex/sdio.c
@@ -2504,7 +2504,7 @@ static int mwifiex_register_dev(struct mwifiex_adapter *adapter)
 		adapter->num_mem_types = ARRAY_SIZE(mem_type_mapping_tbl);
 	}
 
-	adapter->host_mlme = card->host_mlme;
+	adapter->host_mlme_enabled = card->host_mlme;
 
 	return 0;
 }
diff --git a/drivers/net/wireless/marvell/mwifiex/sta_event.c b/drivers/net/wireless/marvell/mwifiex/sta_event.c
index 9c6fac91204c..b5f3821a6a8f 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_event.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_event.c
@@ -136,7 +136,7 @@ void mwifiex_reset_connect_state(struct mwifiex_private *priv, u16 reason_code,
 	priv->media_connected = false;
 
 	priv->auth_flag = 0;
-	priv->auth_alg = 0xFFFF;
+	priv->auth_alg = WLAN_AUTH_NONE;
 
 	priv->scan_block = false;
 	priv->port_open = false;
@@ -225,7 +225,7 @@ void mwifiex_reset_connect_state(struct mwifiex_private *priv, u16 reason_code,
 		    priv->cfg_bssid, reason_code);
 	if (priv->bss_mode == NL80211_IFTYPE_STATION ||
 	    priv->bss_mode == NL80211_IFTYPE_P2P_CLIENT) {
-		if (adapter->host_mlme && adapter->host_mlme_link_lost)
+		if (adapter->host_mlme_enabled && adapter->host_mlme_link_lost)
 			mwifiex_host_mlme_disconnect(adapter->priv_link_lost,
 						     reason_code, NULL);
 		else
@@ -753,7 +753,7 @@ int mwifiex_process_sta_event(struct mwifiex_private *priv)
 		if (priv->media_connected) {
 			reason_code =
 				get_unaligned_le16(adapter->event_body);
-			if (adapter->host_mlme) {
+			if (adapter->host_mlme_enabled) {
 				adapter->priv_link_lost = priv;
 				adapter->host_mlme_link_lost = true;
 				queue_work(adapter->host_mlme_workqueue,
@@ -1015,10 +1015,10 @@ int mwifiex_process_sta_event(struct mwifiex_private *priv)
 		mwifiex_dbg(adapter, EVENT,
 			    "event: Remain on channel expired\n");
 
-		if (adapter->host_mlme &&
+		if (adapter->host_mlme_enabled &&
 		    (priv->auth_flag & HOST_MLME_AUTH_PENDING)) {
 			priv->auth_flag = 0;
-			priv->auth_alg = 0xFFFF;
+			priv->auth_alg = WLAN_AUTH_NONE;
 		} else {
 			cfg80211_remain_on_channel_expired(&priv->wdev,
 							   priv->roc_cfg.cookie,
diff --git a/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c b/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
index 046541713318..23639aacf092 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
@@ -340,7 +340,7 @@ int mwifiex_bss_start(struct mwifiex_private *priv, struct cfg80211_bss *bss,
 			ret = mwifiex_associate(priv, bss_desc);
 		}
 
-		if (bss && !priv->adapter->host_mlme)
+		if (bss && !priv->adapter->host_mlme_enabled)
 			cfg80211_put_bss(priv->adapter->wiphy, bss);
 	} else {
 		/* Adhoc mode */
diff --git a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
index eb7e39146b8a..e393cc78bb98 100644
--- a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
+++ b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
@@ -765,7 +765,7 @@ static int mwifiex_cmd_uap_bss_start(struct mwifiex_private *priv,
 	cmd->command = cpu_to_le16(HostCmd_CMD_UAP_BSS_START);
 	cmd->size = S_DS_GEN;
 
-	if (priv->adapter->host_mlme) {
+	if (priv->adapter->host_mlme_enabled) {
 		tlv = (struct mwifiex_ie_types_host_mlme *)((u8 *)cmd + cmd->size);
 		tlv->header.type = cpu_to_le16(TLV_TYPE_HOST_MLME);
 		tlv->header.len = cpu_to_le16(sizeof(tlv->host_mlme));
diff --git a/drivers/net/wireless/marvell/mwifiex/util.c b/drivers/net/wireless/marvell/mwifiex/util.c
index 9e36bb4a8d67..c0614c246b5f 100644
--- a/drivers/net/wireless/marvell/mwifiex/util.c
+++ b/drivers/net/wireless/marvell/mwifiex/util.c
@@ -392,7 +392,7 @@ void mwifiex_host_mlme_disconnect(struct mwifiex_private *priv,
 		       ETH_ALEN);
 		memcpy(mgmt->bssid, priv->cfg_bssid, ETH_ALEN);
 		priv->auth_flag = 0;
-		priv->auth_alg = 0xFFFF;
+		priv->auth_alg = WLAN_AUTH_NONE;
 	} else {
 		memcpy(mgmt->da, priv->curr_addr, ETH_ALEN);
 		memcpy(mgmt->sa, sa, ETH_ALEN);
@@ -486,7 +486,7 @@ mwifiex_process_mgmt_packet(struct mwifiex_private *priv,
 					    "auth: receive deauth from %pM\n",
 					    ieee_hdr->addr3);
 				priv->auth_flag = 0;
-				priv->auth_alg = 0xFFFF;
+				priv->auth_alg = WLAN_AUTH_NONE;
 			} else {
 				mwifiex_dbg(priv->adapter, MSG,
 					    "assoc: receive disasso from %pM\n",
@@ -497,7 +497,7 @@ mwifiex_process_mgmt_packet(struct mwifiex_private *priv,
 		cfg80211_rx_mlme_mgmt(priv->netdev, skb->data, pkt_len);
 	}
 
-	if (priv->adapter->host_mlme &&
+	if (priv->adapter->host_mlme_enabled &&
 	    (GET_BSS_ROLE(priv) == MWIFIEX_BSS_ROLE_UAP)) {
 		if (ieee80211_is_auth(ieee_hdr->frame_control))
 			mwifiex_dbg(priv->adapter, MSG,
-- 
2.25.1


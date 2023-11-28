Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F447FB428
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 09:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344141AbjK1Ibz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 03:31:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344123AbjK1Ibs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 03:31:48 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2074.outbound.protection.outlook.com [40.107.22.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B239F100;
        Tue, 28 Nov 2023 00:31:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hK1Ohcq2kp8BiGA8c5Pv/9lwtmet/qMfjFLxtNigJH5nCuvU4iBup9rN34PRG1ZYKPf8ghJMczmls3caalsSP160sWAuZpHYjdUnK2iYB0Qu/e2kfCHAjkQU33mkuFp/ui5S9/7F42+ya9DTzI/zp6MgGetf1YLl/tKB4HWGfqqIrmEizXj/xDsdRTJZCjIvI1my3Cxh4/8QiGLQlGGtACRpYVjD2lWfITDcKFFjlcShzGvGZJe4WPoKucbNvFrsL6RnVw/1RfJifKvdcTEaSMAfPmWIRGXK7v++GawQkpZhDY/3v9IeeJwTxTJSl86f9kCw7yUEhCoLbCcrVJti4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=quZ5oyAP+t8I2RJ9E8PB+luLtVBTB8mvEzr6Okc9zNg=;
 b=nemHLA1YF0q/j4XCOBLBfbS1Kk4PMkf18A2+gbzbdZl0UBQ9h3K+0LL97BaquUmxhh5hIFfUTLmelh4XHyo7g7SkrYIUzQIig0eqZJfvX532jiGa2NOxnpnvVImmJmPM6GHlpiEUVMYceITG3avEVtAAizAI0az7cq10LX8KiIMdYErfbcln+sIulE0Kh05vjcbGVmpuuT5aiY50N8eB94UT1nil3UmkJc5Vx8KJnYoou8+wl9r2rESpLOvo4Ch1YKKpBRre7Nxn1RYldnJg9xXbnVP1dHxIU8IoMqQFTCR5FKqbH2rjwRSiAfj+AOd7f9bAkODP4Sepk+4RnTrtRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=quZ5oyAP+t8I2RJ9E8PB+luLtVBTB8mvEzr6Okc9zNg=;
 b=S6aSOrC2L+KyPVDuEb7UA5wXImWEbSOt+dhMiYvKONZZ8XDDQ5bVyVNwom+E8VXfRe3IcUELlBizvtcu2LxR4UMLHB+tzTSLlFzfYlCx/9xqR/mPK8Wf7uJ3pCNLj3ayW59LW6xw9qtOTdl1lElGr59LEa7Wsftck8x/BrLrbM4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by PAXPR04MB8653.eurprd04.prod.outlook.com (2603:10a6:102:21c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Tue, 28 Nov
 2023 08:31:46 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b%7]) with mapi id 15.20.7046.015; Tue, 28 Nov 2023
 08:31:46 +0000
From:   David Lin <yu-hao.lin@nxp.com>
To:     linux-wireless@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, briannorris@chromium.org,
        kvalo@kernel.org, francesco@dolcini.it, tsung-hsien.hsieh@nxp.com,
        David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH v7 01/12] wifi: mwifiex: added code to support host mlme.
Date:   Tue, 28 Nov 2023 16:31:04 +0800
Message-Id: <20231128083115.613235-2-yu-hao.lin@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 808f9a68-3133-480c-3b8f-08dbefec7537
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5KT99Hk+rKpGDfk5q87qetPCrK3PBs7Zp8hdFi1egOZmknWuKZc8CSWfUD9pK2YfJvUY7mWsgS0EWCx53JVwqilH4DB53mJQUkXfZrcnvLx0x6MbdFlPFGz8qoh5w3HE/1voJA2IrZi30uiAJ+W8pyEzEjeZf44AM8Lq0Yotp0ZuGbZ9w2t59dVixYus/+kScVV/PIYwD19eVWWOi8DRyaqjxJNGMFsSCYMXG559CQBl2N53eTAlFmPDtlX4jltKLmvbXVJOygwV5vZmPAB+buFMcttgMTs3CL5I5Mm6N9N4EnglejjEeWfdazreZAwnQYNO33oA1NTMUWzhDVtJmCPFicsj2DCrcWp/TuhCx18nwcaJcKkHdBN469WzSYLn+FHXwE0L46cJ0VYLCkjzhS9xZAmImNFg4AdJOBAxmIxlmyptlLBi3pEt0fkv0DI+8m57vFo2PfKNv42xddxBZTyAbkbpj3TCeTc7qaoR1KhiuvoLk6hOrHWy+Hrnr/2o3AjFaEY6CNKk23GDJzU5mnv+tfZJQTXnai5g3XVAVrBFucsBxieFI7o2cm0Ogk5n
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(366004)(376002)(39860400002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(83380400001)(66946007)(478600001)(6512007)(52116002)(6486002)(86362001)(66556008)(6666004)(66476007)(6916009)(316002)(8676002)(4326008)(8936002)(6506007)(1076003)(2616005)(5660300002)(30864003)(66899024)(38100700002)(41300700001)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UMJ+8tR7HqPozf3V6jYuidRAMQEu92jLB2zEc3uJuWznpWWpxDIGNahw4gjG?=
 =?us-ascii?Q?DdQ2DEBfweLbRFsQMUgholXdW7GQGl/h/hKCva9XLQXTuXhUprK3SdE4ji0D?=
 =?us-ascii?Q?nHCtOaLIiG+17McjmxNI+30SrzyFjBhETzeiqWDWXzXpJIrtESWHNmsUnZTX?=
 =?us-ascii?Q?391ZojVmVZHc3w93D7/RTRYm6bg3/JIXfqscOHs7StxaxhPM2gh4ZVKqm6SJ?=
 =?us-ascii?Q?MT+5CM+ru6xycgfPj6oGNo08RC2CMPZQUCo36HdaqbqheosMci8ZF3ooTg7w?=
 =?us-ascii?Q?glhxCkTdZhlsCYZWzDM9KnOmvSqbxeURu0bHd+bIvSfmQFNzQISXZU3hwdpN?=
 =?us-ascii?Q?OkSVi3kKpQEolP8MWH5BlFJjmB2pepBDfiMJdS6ifgnchUWVuvp9GTHiIHIj?=
 =?us-ascii?Q?e3wMEyHKiQxI74WzUvQCHqORQMqEiQYygBXVl87saBsQSv2OPANyKXqVJvLG?=
 =?us-ascii?Q?s4ww/i2QCTmCJ4NKu0rwLEOy7oXCsf/r2Ap8mAvTNB17A55j3dV5Nt5y6GjV?=
 =?us-ascii?Q?tU7c0o7DDuanbzoFsN4WEUi9Jod2KByqv58W3wXP9pP31o+y+5ALGoVfbk7X?=
 =?us-ascii?Q?EpcOKmVGRGgcsZFxiNywZHDQxwxNL7MwR9wVlXQwm9yNJNo37ndySxoVcUUc?=
 =?us-ascii?Q?1eL6zerh1p1MC4pRL6CLSWA/by1MQNt+8bujaxaU2W/KvQ+xI+eYFQiNxTRy?=
 =?us-ascii?Q?MhgOQONqBXIVEIZh0slzyJRvrHIaTnHLL7uN7t9sC1rVzCInvgoRk+Rsj47G?=
 =?us-ascii?Q?+goNn7yWgEdbGuCZvr8MhzbooqDcHGdtsUAW8ZBcNP5disenckiPukP6Tg7t?=
 =?us-ascii?Q?dfBNDizkrDk6+/lQk1hyeN67nCA9u6TjA6oSqQhmI5SLXlPiFyXKySb1K053?=
 =?us-ascii?Q?p1eBe1/ivftt/SwjxG5xKMQMSsn3EvGRVG4jVd0MgKqbCoil9ecZiX132A9L?=
 =?us-ascii?Q?geZDN1+O72BP3YSoAQok3PO9SwGXENp0PSgiubyyXBiOTpckuQ5iPzYF2H/y?=
 =?us-ascii?Q?XM1rjoqk4y8pf1L8YdSiAvx8TFHCrmG3+aYzdhDfK/mxsZwbn2BjIIiQ30F3?=
 =?us-ascii?Q?E3Qs1WQZBGUcQmPQ3EFGZKzPRHSPokHF6SWMXAe/h10bCuWoV/ao0U+78Bq5?=
 =?us-ascii?Q?XVHWn/unDyjWUfo3Spk7opWWTCZ5NI95gfBxIM4sYkaA5Tq+J9IL5NQ5fVXd?=
 =?us-ascii?Q?LIzpwEvOsSQvSyputcBg/lgcXQ0MyskDXfHxPvxH+jAE/wbjxCEFCOBO2gRA?=
 =?us-ascii?Q?e6K2FZZ8FAnqrv279WpG9rbAPGO3J1p+j/UGmt3IXUV9QxaoLqWVtxUpzDPS?=
 =?us-ascii?Q?kJJJOI5cy6gcmgMv14GZgtyCFniTnG9kymmPD54jzp0xdrGqQHVKj5/6x+eI?=
 =?us-ascii?Q?sktqOppPDnYgs/Bm6WsAF53q0uxorPuwvPsmXVqAp0BVk1Zo+1ND090PB7py?=
 =?us-ascii?Q?cJMfvahaxAZWtfeY4xyMPFf6lO1rWay+JsvPnDCiaMjVqmMNz8tVnAVl7/lS?=
 =?us-ascii?Q?V+PKtNdf8yw6ijfqvIjiLW/3ZeuZnxdYMV/WfGQFbwpnVy2GG5IsFKipYtkS?=
 =?us-ascii?Q?O/qOqd1hg8tlCOlrBN+0lo/PLmoyCeqKthSEyRbHdQkhNQ0fPhUihFPM0v/+?=
 =?us-ascii?Q?eJkGyJNn0po0VP9fHg6HD9BDPVbHekVYU4bIsCJXupCv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 808f9a68-3133-480c-3b8f-08dbefec7537
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 08:31:46.4563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SCoXVAkkLsZ9wLE6pmaSCgI2EjenTWiKIokdzpsZfJp7GaNetGHmAz+wHh8GCZl+X1gakHGcb1vmgapEQ46LsA==
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

1. For station mode first.
2. This feature is a must for WPA3.
3. Firmware key api version 2 is needed for this feature.
4. The code is only enabled and tested with IW416.
5. This feature is disabled for other chips.

Signed-off-by: David Lin <yu-hao.lin@nxp.com>
---
 .../net/wireless/marvell/mwifiex/cfg80211.c   | 327 ++++++++++++++++++
 drivers/net/wireless/marvell/mwifiex/cmdevt.c |  14 +-
 drivers/net/wireless/marvell/mwifiex/decl.h   |  12 +
 drivers/net/wireless/marvell/mwifiex/fw.h     |  15 +
 drivers/net/wireless/marvell/mwifiex/init.c   |   3 +
 drivers/net/wireless/marvell/mwifiex/join.c   |  64 +++-
 drivers/net/wireless/marvell/mwifiex/main.h   |  10 +
 drivers/net/wireless/marvell/mwifiex/scan.c   |   6 +
 drivers/net/wireless/marvell/mwifiex/sdio.c   |  13 +
 drivers/net/wireless/marvell/mwifiex/sdio.h   |   2 +
 .../net/wireless/marvell/mwifiex/sta_event.c  |  18 +-
 .../net/wireless/marvell/mwifiex/sta_ioctl.c  |   3 +-
 drivers/net/wireless/marvell/mwifiex/sta_tx.c |   9 +-
 .../net/wireless/marvell/mwifiex/uap_cmd.c    |  26 ++
 drivers/net/wireless/marvell/mwifiex/util.c   |  73 ++++
 15 files changed, 582 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index 7a15ea8072e6..40c39e4765f7 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -57,6 +57,31 @@ ieee80211_iface_combination mwifiex_iface_comb_ap_sta_drcs = {
 	.beacon_int_infra_match = true,
 };
 
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
+} __pack;
+
 /*
  * This function maps the nl802.11 channel type into driver channel type.
  *
@@ -268,6 +293,8 @@ mwifiex_cfg80211_update_mgmt_frame_registrations(struct wiphy *wiphy,
 
 	if (mask != priv->mgmt_frame_mask) {
 		priv->mgmt_frame_mask = mask;
+		if (priv->host_mlme_reg)
+			priv->mgmt_frame_mask |= HOST_MLME_MGMT_MASK;
 		mwifiex_send_cmd(priv, HostCmd_CMD_MGMT_FRAME_REG,
 				 HostCmd_ACT_GEN_SET, 0,
 				 &priv->mgmt_frame_mask, false);
@@ -848,6 +875,7 @@ static int mwifiex_deinit_priv_params(struct mwifiex_private *priv)
 	struct mwifiex_adapter *adapter = priv->adapter;
 	unsigned long flags;
 
+	priv->host_mlme_reg = false;
 	priv->mgmt_frame_mask = 0;
 	if (mwifiex_send_cmd(priv, HostCmd_CMD_MGMT_FRAME_REG,
 			     HostCmd_ACT_GEN_SET, 0,
@@ -4202,6 +4230,292 @@ mwifiex_cfg80211_change_station(struct wiphy *wiphy, struct net_device *dev,
 	return ret;
 }
 
+static int
+mwifiex_cfg80211_authenticate(struct wiphy *wiphy,
+			      struct net_device *dev,
+			      struct cfg80211_auth_request *req)
+{
+	struct mwifiex_private *priv = mwifiex_netdev_get_priv(dev);
+	struct mwifiex_adapter *adapter = priv->adapter;
+	struct sk_buff *skb;
+	u16 pkt_len, auth_alg;
+	int ret;
+	struct mwifiex_ieee80211_mgmt *mgmt;
+	struct mwifiex_txinfo *tx_info;
+	u32 tx_control = 0, pkt_type = PKT_TYPE_MGMT;
+	u8 addr[ETH_ALEN] = {0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF};
+	u8 trans = 1, status_code = 0;
+	u8 *varptr;
+
+	if (GET_BSS_ROLE(priv) == MWIFIEX_BSS_ROLE_UAP) {
+		mwifiex_dbg(priv->adapter, ERROR, "Interface role is AP\n");
+		return -EFAULT;
+	}
+
+	if (priv->wdev.iftype != NL80211_IFTYPE_STATION) {
+		mwifiex_dbg(priv->adapter, ERROR,
+			    "Interface type is not correct (type %d)\n",
+			    priv->wdev.iftype);
+		return -EINVAL;
+	}
+
+	if (priv->auth_alg != WLAN_AUTH_SAE &&
+	    (priv->auth_flag & HOST_MLME_AUTH_PENDING)) {
+		mwifiex_dbg(priv->adapter, ERROR, "Pending auth on going\n");
+		return -EBUSY;
+	}
+
+	if (!priv->host_mlme_reg) {
+		priv->host_mlme_reg = true;
+		priv->mgmt_frame_mask |= HOST_MLME_MGMT_MASK;
+		mwifiex_send_cmd(priv, HostCmd_CMD_MGMT_FRAME_REG,
+				 HostCmd_ACT_GEN_SET, 0,
+				 &priv->mgmt_frame_mask, false);
+	}
+
+	switch (req->auth_type) {
+	case NL80211_AUTHTYPE_OPEN_SYSTEM:
+		auth_alg = WLAN_AUTH_OPEN;
+		break;
+	case NL80211_AUTHTYPE_SHARED_KEY:
+		auth_alg = WLAN_AUTH_SHARED_KEY;
+		break;
+	case NL80211_AUTHTYPE_FT:
+		auth_alg = WLAN_AUTH_FT;
+		break;
+	case NL80211_AUTHTYPE_NETWORK_EAP:
+		auth_alg = WLAN_AUTH_LEAP;
+		break;
+	case NL80211_AUTHTYPE_SAE:
+		auth_alg = WLAN_AUTH_SAE;
+		break;
+	default:
+		mwifiex_dbg(priv->adapter, ERROR,
+			    "unsupported auth type=%d\n", req->auth_type);
+		return -EOPNOTSUPP;
+	}
+
+	if (!priv->auth_flag) {
+		ret = mwifiex_remain_on_chan_cfg(priv, HostCmd_ACT_GEN_SET,
+						 req->bss->channel,
+						 AUTH_TX_DEFAULT_WAIT_TIME);
+
+		if (!ret) {
+			priv->roc_cfg.cookie = get_random_u32() | 1;
+			priv->roc_cfg.chan = *req->bss->channel;
+		}
+	}
+
+	priv->sec_info.authentication_mode = auth_alg;
+
+	mwifiex_cancel_scan(adapter);
+
+	pkt_len = (u16)req->ie_len + req->auth_data_len +
+		     MWIFIEX_MGMT_HEADER_LEN + MWIFIEX_AUTH_BODY_LEN;
+	if (req->auth_data_len >= 4)
+		pkt_len -= 4;
+
+	skb = dev_alloc_skb(MWIFIEX_MIN_DATA_HEADER_LEN +
+			    MWIFIEX_MGMT_FRAME_HEADER_SIZE +
+			    pkt_len + sizeof(pkt_len));
+	if (!skb) {
+		mwifiex_dbg(priv->adapter, ERROR,
+			    "allocate skb failed for management frame\n");
+		return -ENOMEM;
+	}
+
+	tx_info = MWIFIEX_SKB_TXCB(skb);
+	memset(tx_info, 0, sizeof(*tx_info));
+	tx_info->bss_num = priv->bss_num;
+	tx_info->bss_type = priv->bss_type;
+	tx_info->pkt_len = pkt_len;
+
+	skb_reserve(skb, MWIFIEX_MIN_DATA_HEADER_LEN +
+		    MWIFIEX_MGMT_FRAME_HEADER_SIZE + sizeof(pkt_len));
+	memcpy(skb_push(skb, sizeof(pkt_len)), &pkt_len, sizeof(pkt_len));
+	memcpy(skb_push(skb, sizeof(tx_control)),
+	       &tx_control, sizeof(tx_control));
+	memcpy(skb_push(skb, sizeof(pkt_type)), &pkt_type, sizeof(pkt_type));
+
+	mgmt = (struct mwifiex_ieee80211_mgmt *)skb_put(skb, pkt_len);
+	memset(mgmt, 0, pkt_len);
+	mgmt->frame_control =
+		cpu_to_le16(IEEE80211_FTYPE_MGMT | IEEE80211_STYPE_AUTH);
+	memcpy(mgmt->da, req->bss->bssid, ETH_ALEN);
+	memcpy(mgmt->sa, priv->curr_addr, ETH_ALEN);
+	memcpy(mgmt->bssid, req->bss->bssid, ETH_ALEN);
+	memcpy(mgmt->addr4, addr, ETH_ALEN);
+
+	if (req->auth_data_len >= 4) {
+		if (req->auth_type == NL80211_AUTHTYPE_SAE) {
+			__le16 *pos = (__le16 *)req->auth_data;
+
+			trans = le16_to_cpu(pos[0]);
+			status_code = le16_to_cpu(pos[1]);
+		}
+		memcpy((u8 *)(&mgmt->u.auth.variable), req->auth_data + 4,
+		       req->auth_data_len - 4);
+		varptr = (u8 *)&mgmt->u.auth.variable +
+			 (req->auth_data_len - 4);
+	}
+
+	mgmt->u.auth.auth_alg = cpu_to_le16(auth_alg);
+	mgmt->u.auth.auth_transaction = trans;
+	mgmt->u.auth.status_code = status_code;
+
+	if (req->ie && req->ie_len) {
+		if (!varptr)
+			varptr = (u8 *)&mgmt->u.auth.variable;
+		memcpy((u8 *)varptr, req->ie, req->ie_len);
+	}
+
+	priv->auth_flag = HOST_MLME_AUTH_PENDING;
+	priv->auth_alg = auth_alg;
+
+	skb->priority = WMM_HIGHEST_PRIORITY;
+	__net_timestamp(skb);
+
+	mwifiex_dbg(priv->adapter, MSG,
+		    "auth: send authentication to %pM\n", req->bss->bssid);
+
+	mwifiex_queue_tx_pkt(priv, skb);
+
+	return 0;
+}
+
+static int
+mwifiex_cfg80211_associate(struct wiphy *wiphy, struct net_device *dev,
+			   struct cfg80211_assoc_request *req)
+{
+	struct mwifiex_private *priv = mwifiex_netdev_get_priv(dev);
+	struct mwifiex_adapter *adapter = priv->adapter;
+	int ret;
+	struct cfg80211_ssid req_ssid;
+	const u8 *ssid_ie;
+	struct cfg80211_rx_assoc_resp assoc_resp = {
+		.uapsd_queues = -1,
+	};
+
+	if (GET_BSS_ROLE(priv) != MWIFIEX_BSS_ROLE_STA) {
+		mwifiex_dbg(adapter, ERROR,
+			    "%s: reject infra assoc request in non-STA role\n",
+			    dev->name);
+		return -EINVAL;
+	}
+
+	if (test_bit(MWIFIEX_SURPRISE_REMOVED, &adapter->work_flags) ||
+	    test_bit(MWIFIEX_IS_CMD_TIMEDOUT, &adapter->work_flags)) {
+		mwifiex_dbg(adapter, ERROR,
+			    "%s: Ignore association.\t"
+			    "Card removed or FW in bad state\n",
+			    dev->name);
+		return -EFAULT;
+	}
+
+	if (priv->auth_alg == WLAN_AUTH_SAE)
+		priv->auth_flag = HOST_MLME_AUTH_DONE;
+
+	if (priv->auth_flag && !(priv->auth_flag & HOST_MLME_AUTH_DONE))
+		return -EBUSY;
+
+	if (!mwifiex_stop_bg_scan(priv))
+		cfg80211_sched_scan_stopped_locked(priv->wdev.wiphy, 0);
+
+	memset(&req_ssid, 0, sizeof(struct cfg80211_ssid));
+	rcu_read_lock();
+	ssid_ie = ieee80211_bss_get_ie(req->bss, WLAN_EID_SSID);
+
+	if (!ssid_ie)
+		goto ssid_err;
+
+	req_ssid.ssid_len = ssid_ie[1];
+	if (req_ssid.ssid_len > IEEE80211_MAX_SSID_LEN) {
+		mwifiex_dbg(priv->adapter, ERROR, "invalid SSID - aborting\n");
+		goto ssid_err;
+	}
+
+	memcpy(req_ssid.ssid, ssid_ie + 2, req_ssid.ssid_len);
+	if (!req_ssid.ssid_len || req_ssid.ssid[0] < 0x20) {
+		mwifiex_dbg(priv->adapter, ERROR, "invalid SSID - aborting\n");
+		goto ssid_err;
+	}
+	rcu_read_unlock();
+
+	/* As this is new association, clear locally stored
+	 * keys and security related flags
+	 */
+	priv->sec_info.wpa_enabled = false;
+	priv->sec_info.wpa2_enabled = false;
+	priv->wep_key_curr_index = 0;
+	priv->sec_info.encryption_mode = 0;
+	priv->sec_info.is_authtype_auto = 0;
+	ret = mwifiex_set_encode(priv, NULL, NULL, 0, 0, NULL, 1);
+
+	if (req->crypto.n_ciphers_pairwise)
+		priv->sec_info.encryption_mode =
+			req->crypto.ciphers_pairwise[0];
+
+	if (req->crypto.cipher_group)
+		priv->sec_info.encryption_mode = req->crypto.cipher_group;
+
+	if (req->ie)
+		ret = mwifiex_set_gen_ie(priv, req->ie, req->ie_len);
+
+	memcpy(priv->cfg_bssid, req->bss->bssid, ETH_ALEN);
+
+	mwifiex_dbg(priv->adapter, MSG,
+		    "assoc: send association to %pM\n", req->bss->bssid);
+
+	cfg80211_ref_bss(priv->adapter->wiphy, req->bss);
+
+	ret = mwifiex_bss_start(priv, req->bss, &req_ssid);
+
+	if (!ret) {
+		assoc_resp.links[0].bss = priv->attempted_bss_desc->bss;
+		assoc_resp.buf = priv->assoc_rsp_buf;
+		assoc_resp.len = priv->assoc_rsp_size;
+		cfg80211_rx_assoc_resp(priv->netdev,
+				       &assoc_resp);
+	} else {
+		priv->auth_flag = 0;
+		priv->auth_alg = 0xFFFF;
+		eth_zero_addr(priv->cfg_bssid);
+	}
+
+	cfg80211_put_bss(priv->adapter->wiphy, req->bss);
+
+	return 0;
+
+ssid_err:
+
+	rcu_read_unlock();
+	return -EFAULT;
+}
+
+static int
+mwifiex_cfg80211_deauthenticate(struct wiphy *wiphy,
+				struct net_device *dev,
+				struct cfg80211_deauth_request *req)
+{
+	return mwifiex_cfg80211_disconnect(wiphy, dev, req->reason_code);
+}
+
+static int
+mwifiex_cfg80211_disassociate(struct wiphy *wiphy,
+			      struct net_device *dev,
+			      struct cfg80211_disassoc_request *req)
+{
+	return mwifiex_cfg80211_disconnect(wiphy, dev, req->reason_code);
+}
+
+static int
+mwifiex_cfg80211_probe_client(struct wiphy *wiphy,
+			      struct net_device *dev, const u8 *peer,
+			      u64 *cookie)
+{
+	return -1;
+}
+
 /* station cfg80211 operations */
 static struct cfg80211_ops mwifiex_cfg80211_ops = {
 	.add_virtual_intf = mwifiex_add_virtual_intf,
@@ -4347,6 +4661,16 @@ int mwifiex_register_cfg80211(struct mwifiex_adapter *adapter)
 			    "%s: creating new wiphy\n", __func__);
 		return -ENOMEM;
 	}
+	if (adapter->host_mlme) {
+		mwifiex_cfg80211_ops.auth = mwifiex_cfg80211_authenticate;
+		mwifiex_cfg80211_ops.assoc = mwifiex_cfg80211_associate;
+		mwifiex_cfg80211_ops.deauth = mwifiex_cfg80211_deauthenticate;
+		mwifiex_cfg80211_ops.disassoc = mwifiex_cfg80211_disassociate;
+		mwifiex_cfg80211_ops.disconnect = NULL;
+		mwifiex_cfg80211_ops.connect = NULL;
+		mwifiex_cfg80211_ops.probe_client =
+			mwifiex_cfg80211_probe_client;
+	}
 	wiphy->max_scan_ssids = MWIFIEX_MAX_SSID_LIST_LENGTH;
 	wiphy->max_scan_ie_len = MWIFIEX_MAX_VSIE_LEN;
 	wiphy->mgmt_stypes = mwifiex_mgmt_stypes;
@@ -4428,6 +4752,9 @@ int mwifiex_register_cfg80211(struct mwifiex_adapter *adapter)
 			   NL80211_FEATURE_LOW_PRIORITY_SCAN |
 			   NL80211_FEATURE_NEED_OBSS_SCAN;
 
+	if (adapter->host_mlme)
+		wiphy->features |= NL80211_FEATURE_SAE;
+
 	if (ISSUPP_ADHOC_ENABLED(adapter->fw_cap_info))
 		wiphy->features |= NL80211_FEATURE_HT_IBSS;
 
diff --git a/drivers/net/wireless/marvell/mwifiex/cmdevt.c b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
index 3756aa247e77..311af5f40c3e 100644
--- a/drivers/net/wireless/marvell/mwifiex/cmdevt.c
+++ b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
@@ -654,7 +654,7 @@ int mwifiex_send_cmd(struct mwifiex_private *priv, u16 cmd_no,
 	if (ret) {
 		mwifiex_dbg(adapter, ERROR,
 			    "PREP_CMD: cmd %#x preparation failed\n",
-			cmd_no);
+			    cmd_no);
 		mwifiex_insert_cmd_to_free_q(adapter, cmd_node);
 		return -1;
 	}
@@ -1477,6 +1477,17 @@ int mwifiex_cmd_get_hw_spec(struct mwifiex_private *priv,
 	return 0;
 }
 
+static void mwifiex_check_key_api_ver(struct mwifiex_adapter *adapter)
+{
+	if (adapter->host_mlme) {
+		if (adapter->key_api_major_ver != KEY_API_VER_MAJOR_V2)
+			adapter->host_mlme = false;
+		mwifiex_dbg(adapter, MSG, "host_mlme: %s, key_api: %d\n",
+			    adapter->host_mlme ? "enable" : "disable",
+			    adapter->key_api_major_ver);
+	}
+}
+
 /*
  * This function handles the command response of get hardware
  * specifications.
@@ -1586,6 +1597,7 @@ int mwifiex_ret_get_hw_spec(struct mwifiex_private *priv,
 						    "key_api v%d.%d\n",
 						    adapter->key_api_major_ver,
 						    adapter->key_api_minor_ver);
+					mwifiex_check_key_api_ver(adapter);
 					break;
 				case FW_API_VER_ID:
 					adapter->fw_api_ver =
diff --git a/drivers/net/wireless/marvell/mwifiex/decl.h b/drivers/net/wireless/marvell/mwifiex/decl.h
index 326ffb05d791..f9b21b13d6c3 100644
--- a/drivers/net/wireless/marvell/mwifiex/decl.h
+++ b/drivers/net/wireless/marvell/mwifiex/decl.h
@@ -24,6 +24,18 @@
 #define MWIFIEX_RX_HEADROOM	    64
 #define MAX_TXPD_SZ		    32
 #define INTF_HDR_ALIGN		     4
+/* frmctl + durationid + addr1 + addr2 + addr3 + seqctl + addr4 */
+#define MWIFIEX_MGMT_HEADER_LEN   (2 + 2 + 6 + 6 + 6 + 2 + 6)
+/* 6   = auth_alg + auth_transaction + auth_status */
+#define MWIFIEX_AUTH_BODY_LEN     6
+
+#define HOST_MLME_AUTH_PENDING    BIT(0)
+#define HOST_MLME_AUTH_DONE       BIT(1)
+
+#define HOST_MLME_MGMT_MASK       (BIT(IEEE80211_STYPE_AUTH >> 4) | \
+				   BIT(IEEE80211_STYPE_DEAUTH >> 4) | \
+				   BIT(IEEE80211_STYPE_DISASSOC >> 4))
+#define AUTH_TX_DEFAULT_WAIT_TIME 2400
 
 #define MWIFIEX_MIN_DATA_HEADER_LEN (MWIFIEX_DMA_ALIGN_SZ + INTF_HDR_ALIGN + \
 				     MAX_TXPD_SZ)
diff --git a/drivers/net/wireless/marvell/mwifiex/fw.h b/drivers/net/wireless/marvell/mwifiex/fw.h
index 8e6db904e5b2..8b22cd993a79 100644
--- a/drivers/net/wireless/marvell/mwifiex/fw.h
+++ b/drivers/net/wireless/marvell/mwifiex/fw.h
@@ -209,6 +209,9 @@ enum MWIFIEX_802_11_PRIVACY_FILTER {
 #define TLV_TYPE_RANDOM_MAC         (PROPRIETARY_TLV_BASE_ID + 236)
 #define TLV_TYPE_CHAN_ATTR_CFG      (PROPRIETARY_TLV_BASE_ID + 237)
 #define TLV_TYPE_MAX_CONN           (PROPRIETARY_TLV_BASE_ID + 279)
+#define TLV_TYPE_HOST_MLME          (PROPRIETARY_TLV_BASE_ID + 307)
+#define TLV_TYPE_SAE_PWE_MODE       (PROPRIETARY_TLV_BASE_ID + 339)
+
 
 #define MWIFIEX_TX_DATA_BUF_SIZE_2K        2048
 
@@ -802,6 +805,11 @@ struct mwifiex_ie_types_ssid_param_set {
 	u8 ssid[];
 } __packed;
 
+struct mwifiex_ie_types_host_mlme {
+	struct mwifiex_ie_types_header header;
+	u8 host_mlme;
+} __packed;
+
 struct mwifiex_ie_types_num_probes {
 	struct mwifiex_ie_types_header header;
 	__le16 num_probes;
@@ -905,6 +913,13 @@ struct mwifiex_ie_types_tdls_idle_timeout {
 	__le16 value;
 } __packed;
 
+#define MWIFIEX_AUTHTYPE_SAE 6
+
+struct mwifiex_ie_types_sae_pwe_mode {
+	struct mwifiex_ie_types_header header;
+	u8 pwe[];
+} __packed;
+
 struct mwifiex_ie_types_rsn_param_set {
 	struct mwifiex_ie_types_header header;
 	u8 rsn_ie[];
diff --git a/drivers/net/wireless/marvell/mwifiex/init.c b/drivers/net/wireless/marvell/mwifiex/init.c
index c9c58419c37b..f86a527fd7ca 100644
--- a/drivers/net/wireless/marvell/mwifiex/init.c
+++ b/drivers/net/wireless/marvell/mwifiex/init.c
@@ -81,6 +81,9 @@ int mwifiex_init_priv(struct mwifiex_private *priv)
 	priv->bcn_avg_factor = DEFAULT_BCN_AVG_FACTOR;
 	priv->data_avg_factor = DEFAULT_DATA_AVG_FACTOR;
 
+	priv->auth_flag = 0;
+	priv->auth_alg = 0xFFFF;
+
 	priv->sec_info.wep_enabled = 0;
 	priv->sec_info.authentication_mode = NL80211_AUTHTYPE_OPEN_SYSTEM;
 	priv->sec_info.encryption_mode = 0;
diff --git a/drivers/net/wireless/marvell/mwifiex/join.c b/drivers/net/wireless/marvell/mwifiex/join.c
index a6e254a1185c..ef7cc40c3ba4 100644
--- a/drivers/net/wireless/marvell/mwifiex/join.c
+++ b/drivers/net/wireless/marvell/mwifiex/join.c
@@ -382,7 +382,9 @@ int mwifiex_cmd_802_11_associate(struct mwifiex_private *priv,
 	struct mwifiex_ie_types_ss_param_set *ss_tlv;
 	struct mwifiex_ie_types_rates_param_set *rates_tlv;
 	struct mwifiex_ie_types_auth_type *auth_tlv;
+	struct mwifiex_ie_types_sae_pwe_mode *sae_pwe_tlv;
 	struct mwifiex_ie_types_chan_list_param_set *chan_tlv;
+	struct mwifiex_ie_types_host_mlme *host_mlme_tlv;
 	u8 rates[MWIFIEX_SUPPORTED_RATES];
 	u32 rates_size;
 	u16 tmp_cap;
@@ -448,7 +450,7 @@ int mwifiex_cmd_802_11_associate(struct mwifiex_private *priv,
 	mwifiex_dbg(priv->adapter, INFO, "info: ASSOC_CMD: rates size = %d\n",
 		    rates_size);
 
-	/* Add the Authentication type to be used for Auth frames */
+	/* Add the Authentication type */
 	auth_tlv = (struct mwifiex_ie_types_auth_type *) pos;
 	auth_tlv->header.type = cpu_to_le16(TLV_TYPE_AUTH_TYPE);
 	auth_tlv->header.len = cpu_to_le16(sizeof(auth_tlv->auth_type));
@@ -460,6 +462,24 @@ int mwifiex_cmd_802_11_associate(struct mwifiex_private *priv,
 
 	pos += sizeof(auth_tlv->header) + le16_to_cpu(auth_tlv->header.len);
 
+	if (priv->sec_info.authentication_mode == WLAN_AUTH_SAE) {
+		auth_tlv->auth_type = cpu_to_le16(MWIFIEX_AUTHTYPE_SAE);
+		if (bss_desc->bcn_rsnx_ie &&
+		    bss_desc->bcn_rsnx_ie->ieee_hdr.len &&
+		    (bss_desc->bcn_rsnx_ie->data[0] &
+		    WLAN_RSNX_CAPA_SAE_H2E)) {
+			sae_pwe_tlv =
+				(struct mwifiex_ie_types_sae_pwe_mode *)pos;
+			sae_pwe_tlv->header.type =
+				cpu_to_le16(TLV_TYPE_SAE_PWE_MODE);
+			sae_pwe_tlv->header.len =
+				cpu_to_le16(sizeof(sae_pwe_tlv->pwe[0]));
+			sae_pwe_tlv->pwe[0] = bss_desc->bcn_rsnx_ie->data[0];
+			pos += sizeof(sae_pwe_tlv->header) +
+				sizeof(sae_pwe_tlv->pwe[0]);
+		}
+	}
+
 	if (IS_SUPPORT_MULTI_BANDS(priv->adapter) &&
 	    !(ISSUPP_11NENABLED(priv->adapter->fw_cap_info) &&
 	    (!bss_desc->disable_11n) &&
@@ -491,6 +511,16 @@ int mwifiex_cmd_802_11_associate(struct mwifiex_private *priv,
 			sizeof(struct mwifiex_chan_scan_param_set);
 	}
 
+	if (priv->adapter->host_mlme) {
+		host_mlme_tlv = (struct mwifiex_ie_types_host_mlme *)pos;
+		host_mlme_tlv->header.type = cpu_to_le16(TLV_TYPE_HOST_MLME);
+		host_mlme_tlv->header.len =
+			cpu_to_le16(sizeof(host_mlme_tlv->host_mlme));
+		host_mlme_tlv->host_mlme = 1;
+		pos += sizeof(host_mlme_tlv->header) +
+			sizeof(host_mlme_tlv->host_mlme);
+	}
+
 	if (!priv->wps.session_enable) {
 		if (priv->sec_info.wpa_enabled || priv->sec_info.wpa2_enabled)
 			rsn_ie_len = mwifiex_append_rsn_ie_wpa_wpa2(priv, &pos);
@@ -634,6 +664,7 @@ int mwifiex_ret_802_11_associate(struct mwifiex_private *priv,
 	u16 cap_info, status_code, aid;
 	const u8 *ie_ptr;
 	struct ieee80211_ht_operation *assoc_resp_ht_oper;
+	struct ieee80211_mgmt *hdr;
 
 	if (!priv->attempted_bss_desc) {
 		mwifiex_dbg(priv->adapter, ERROR,
@@ -641,7 +672,19 @@ int mwifiex_ret_802_11_associate(struct mwifiex_private *priv,
 		goto done;
 	}
 
-	assoc_rsp = (struct ieee_types_assoc_rsp *) &resp->params;
+	if (adapter->host_mlme) {
+		hdr = (struct ieee80211_mgmt *)&resp->params;
+		if (!memcmp(hdr->bssid,
+			    priv->attempted_bss_desc->mac_address,
+			    ETH_ALEN))
+			assoc_rsp = (struct ieee_types_assoc_rsp *)
+				&hdr->u.assoc_resp;
+		else
+			assoc_rsp =
+				(struct ieee_types_assoc_rsp *)&resp->params;
+	} else {
+		assoc_rsp = (struct ieee_types_assoc_rsp *)&resp->params;
+	}
 
 	cap_info = le16_to_cpu(assoc_rsp->cap_info_bitmap);
 	status_code = le16_to_cpu(assoc_rsp->status_code);
@@ -778,7 +821,8 @@ int mwifiex_ret_802_11_associate(struct mwifiex_private *priv,
 
 	priv->adapter->dbg.num_cmd_assoc_success++;
 
-	mwifiex_dbg(priv->adapter, INFO, "info: ASSOC_RESP: associated\n");
+	mwifiex_dbg(priv->adapter, MSG, "assoc: associated with %pM\n",
+		    priv->attempted_bss_desc->mac_address);
 
 	/* Add the ra_list here for infra mode as there will be only 1 ra
 	   always */
@@ -1491,6 +1535,20 @@ int mwifiex_deauthenticate(struct mwifiex_private *priv, u8 *mac)
 	if (!priv->media_connected)
 		return 0;
 
+	if (priv->adapter->host_mlme) {
+		priv->auth_flag = 0;
+		priv->auth_alg = 0xFFFF;
+		priv->host_mlme_reg = false;
+		priv->mgmt_frame_mask = 0;
+		if (mwifiex_send_cmd(priv, HostCmd_CMD_MGMT_FRAME_REG,
+				     HostCmd_ACT_GEN_SET, 0,
+				     &priv->mgmt_frame_mask, false)) {
+			mwifiex_dbg(priv->adapter, ERROR,
+				    "could not unregister mgmt frame rx\n");
+			return -1;
+		}
+	}
+
 	switch (priv->bss_mode) {
 	case NL80211_IFTYPE_STATION:
 	case NL80211_IFTYPE_P2P_CLIENT:
diff --git a/drivers/net/wireless/marvell/mwifiex/main.h b/drivers/net/wireless/marvell/mwifiex/main.h
index d263eae6078c..83449ad84d15 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.h
+++ b/drivers/net/wireless/marvell/mwifiex/main.h
@@ -384,6 +384,7 @@ struct ieee_types_aid {
 
 struct mwifiex_bssdescriptor {
 	u8 mac_address[ETH_ALEN];
+	struct cfg80211_bss *bss;
 	struct cfg80211_ssid ssid;
 	u32 privacy;
 	s32 rssi;
@@ -426,6 +427,8 @@ struct mwifiex_bssdescriptor {
 	u16 wpa_offset;
 	struct ieee_types_generic *bcn_rsn_ie;
 	u16 rsn_offset;
+	struct ieee_types_generic *bcn_rsnx_ie;
+	u16 rsnx_offset;
 	struct ieee_types_generic *bcn_wapi_ie;
 	u16 wapi_offset;
 	u8 *beacon_buf;
@@ -527,6 +530,8 @@ struct mwifiex_private {
 	u8 bss_priority;
 	u8 bss_num;
 	u8 bss_started;
+	u8 auth_flag;
+	u16 auth_alg;
 	u8 frame_type;
 	u8 curr_addr[ETH_ALEN];
 	u8 media_connected;
@@ -649,6 +654,7 @@ struct mwifiex_private {
 	u16 gen_idx;
 	u8 ap_11n_enabled;
 	u8 ap_11ac_enabled;
+	bool host_mlme_reg;
 	u32 mgmt_frame_mask;
 	struct mwifiex_roc_cfg roc_cfg;
 	bool scan_aborting;
@@ -998,6 +1004,7 @@ struct mwifiex_adapter {
 	bool is_up;
 
 	bool ext_scan;
+	bool host_mlme;
 	u8 fw_api_ver;
 	u8 key_api_major_ver, key_api_minor_ver;
 	u8 max_p2p_conn, max_sta_conn;
@@ -1063,6 +1070,9 @@ int mwifiex_recv_packet(struct mwifiex_private *priv, struct sk_buff *skb);
 int mwifiex_uap_recv_packet(struct mwifiex_private *priv,
 			    struct sk_buff *skb);
 
+void mwifiex_host_mlme_disconnect(struct mwifiex_private *priv,
+				  u16 reason_code, u8 *sa);
+
 int mwifiex_process_mgmt_packet(struct mwifiex_private *priv,
 				struct sk_buff *skb);
 
diff --git a/drivers/net/wireless/marvell/mwifiex/scan.c b/drivers/net/wireless/marvell/mwifiex/scan.c
index 72904c275461..7ecff7ce06e4 100644
--- a/drivers/net/wireless/marvell/mwifiex/scan.c
+++ b/drivers/net/wireless/marvell/mwifiex/scan.c
@@ -1383,6 +1383,12 @@ int mwifiex_update_bss_desc_with_ie(struct mwifiex_adapter *adapter,
 			bss_entry->rsn_offset = (u16) (current_ptr -
 							bss_entry->beacon_buf);
 			break;
+		case WLAN_EID_RSNX:
+			bss_entry->bcn_rsnx_ie =
+				(struct ieee_types_generic *)current_ptr;
+			bss_entry->rsnx_offset =
+				(u16)(current_ptr - bss_entry->beacon_buf);
+			break;
 		case WLAN_EID_BSS_AC_ACCESS_DELAY:
 			bss_entry->bcn_wapi_ie =
 				(struct ieee_types_generic *) current_ptr;
diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.c b/drivers/net/wireless/marvell/mwifiex/sdio.c
index 6462a0ffe698..f5039d158f46 100644
--- a/drivers/net/wireless/marvell/mwifiex/sdio.c
+++ b/drivers/net/wireless/marvell/mwifiex/sdio.c
@@ -331,6 +331,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd8786 = {
 	.can_dump_fw = false,
 	.can_auto_tdls = false,
 	.can_ext_scan = false,
+	.host_mlme = false,
 };
 
 static const struct mwifiex_sdio_device mwifiex_sdio_sd8787 = {
@@ -346,6 +347,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd8787 = {
 	.can_dump_fw = false,
 	.can_auto_tdls = false,
 	.can_ext_scan = true,
+	.host_mlme = false,
 };
 
 static const struct mwifiex_sdio_device mwifiex_sdio_sd8797 = {
@@ -361,6 +363,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd8797 = {
 	.can_dump_fw = false,
 	.can_auto_tdls = false,
 	.can_ext_scan = true,
+	.host_mlme = false,
 };
 
 static const struct mwifiex_sdio_device mwifiex_sdio_sd8897 = {
@@ -376,6 +379,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd8897 = {
 	.can_dump_fw = true,
 	.can_auto_tdls = false,
 	.can_ext_scan = true,
+	.host_mlme = false,
 };
 
 static const struct mwifiex_sdio_device mwifiex_sdio_sd8977 = {
@@ -392,6 +396,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd8977 = {
 	.fw_dump_enh = true,
 	.can_auto_tdls = false,
 	.can_ext_scan = true,
+	.host_mlme = false,
 };
 
 static const struct mwifiex_sdio_device mwifiex_sdio_sd8978 = {
@@ -408,6 +413,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd8978 = {
 	.fw_dump_enh = true,
 	.can_auto_tdls = false,
 	.can_ext_scan = true,
+	.host_mlme = true,
 };
 
 static const struct mwifiex_sdio_device mwifiex_sdio_sd8997 = {
@@ -425,6 +431,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd8997 = {
 	.fw_dump_enh = true,
 	.can_auto_tdls = false,
 	.can_ext_scan = true,
+	.host_mlme = false,
 };
 
 static const struct mwifiex_sdio_device mwifiex_sdio_sd8887 = {
@@ -440,6 +447,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd8887 = {
 	.can_dump_fw = false,
 	.can_auto_tdls = true,
 	.can_ext_scan = true,
+	.host_mlme = false,
 };
 
 static const struct mwifiex_sdio_device mwifiex_sdio_sd8987 = {
@@ -456,6 +464,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd8987 = {
 	.fw_dump_enh = true,
 	.can_auto_tdls = true,
 	.can_ext_scan = true,
+	.host_mlme = false,
 };
 
 static const struct mwifiex_sdio_device mwifiex_sdio_sd8801 = {
@@ -471,6 +480,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd8801 = {
 	.can_dump_fw = false,
 	.can_auto_tdls = false,
 	.can_ext_scan = true,
+	.host_mlme = false,
 };
 
 static struct memory_type_mapping generic_mem_type_map[] = {
@@ -563,6 +573,7 @@ mwifiex_sdio_probe(struct sdio_func *func, const struct sdio_device_id *id)
 		card->fw_dump_enh = data->fw_dump_enh;
 		card->can_auto_tdls = data->can_auto_tdls;
 		card->can_ext_scan = data->can_ext_scan;
+		card->host_mlme = data->host_mlme;
 		INIT_WORK(&card->work, mwifiex_sdio_work);
 	}
 
@@ -2493,6 +2504,8 @@ static int mwifiex_register_dev(struct mwifiex_adapter *adapter)
 		adapter->num_mem_types = ARRAY_SIZE(mem_type_mapping_tbl);
 	}
 
+	adapter->host_mlme = card->host_mlme;
+
 	return 0;
 }
 
diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.h b/drivers/net/wireless/marvell/mwifiex/sdio.h
index b86a9263a6a8..4f253d8cae42 100644
--- a/drivers/net/wireless/marvell/mwifiex/sdio.h
+++ b/drivers/net/wireless/marvell/mwifiex/sdio.h
@@ -255,6 +255,7 @@ struct sdio_mmc_card {
 	bool fw_dump_enh;
 	bool can_auto_tdls;
 	bool can_ext_scan;
+	bool host_mlme;
 
 	struct mwifiex_sdio_mpa_tx mpa_tx;
 	struct mwifiex_sdio_mpa_rx mpa_rx;
@@ -278,6 +279,7 @@ struct mwifiex_sdio_device {
 	bool fw_dump_enh;
 	bool can_auto_tdls;
 	bool can_ext_scan;
+	bool host_mlme;
 };
 
 /*
diff --git a/drivers/net/wireless/marvell/mwifiex/sta_event.c b/drivers/net/wireless/marvell/mwifiex/sta_event.c
index df9cdd10a494..69426ddd9c3a 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_event.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_event.c
@@ -135,6 +135,9 @@ void mwifiex_reset_connect_state(struct mwifiex_private *priv, u16 reason_code,
 
 	priv->media_connected = false;
 
+	priv->auth_flag = 0;
+	priv->auth_alg = 0xFFFF;
+
 	priv->scan_block = false;
 	priv->port_open = false;
 
@@ -999,10 +1002,17 @@ int mwifiex_process_sta_event(struct mwifiex_private *priv)
 	case EVENT_REMAIN_ON_CHAN_EXPIRED:
 		mwifiex_dbg(adapter, EVENT,
 			    "event: Remain on channel expired\n");
-		cfg80211_remain_on_channel_expired(&priv->wdev,
-						   priv->roc_cfg.cookie,
-						   &priv->roc_cfg.chan,
-						   GFP_ATOMIC);
+
+		if (adapter->host_mlme &&
+		    (priv->auth_flag & HOST_MLME_AUTH_PENDING)) {
+			priv->auth_flag = 0;
+			priv->auth_alg = 0xFFFF;
+		} else {
+			cfg80211_remain_on_channel_expired(&priv->wdev,
+							   priv->roc_cfg.cookie,
+							   &priv->roc_cfg.chan,
+							   GFP_ATOMIC);
+		}
 
 		memset(&priv->roc_cfg, 0x00, sizeof(struct mwifiex_roc_cfg));
 
diff --git a/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c b/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
index a2ad2b53f016..046541713318 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
@@ -136,6 +136,7 @@ int mwifiex_fill_new_bss_desc(struct mwifiex_private *priv,
 	const struct cfg80211_bss_ies *ies;
 
 	rcu_read_lock();
+	bss_desc->bss = bss;
 	ies = rcu_dereference(bss->ies);
 	beacon_ie = kmemdup(ies->data, ies->len, GFP_ATOMIC);
 	beacon_ie_len = ies->len;
@@ -339,7 +340,7 @@ int mwifiex_bss_start(struct mwifiex_private *priv, struct cfg80211_bss *bss,
 			ret = mwifiex_associate(priv, bss_desc);
 		}
 
-		if (bss)
+		if (bss && !priv->adapter->host_mlme)
 			cfg80211_put_bss(priv->adapter->wiphy, bss);
 	} else {
 		/* Adhoc mode */
diff --git a/drivers/net/wireless/marvell/mwifiex/sta_tx.c b/drivers/net/wireless/marvell/mwifiex/sta_tx.c
index 70c2790b8e35..9d0ef04ebe02 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_tx.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_tx.c
@@ -36,7 +36,7 @@ void mwifiex_process_sta_txpd(struct mwifiex_private *priv,
 	struct txpd *local_tx_pd;
 	struct mwifiex_txinfo *tx_info = MWIFIEX_SKB_TXCB(skb);
 	unsigned int pad;
-	u16 pkt_type, pkt_offset;
+	u16 pkt_type, pkt_length, pkt_offset;
 	int hroom = adapter->intf_hdr_len;
 
 	pkt_type = mwifiex_is_skb_mgmt_frame(skb) ? PKT_TYPE_MGMT : 0;
@@ -49,9 +49,10 @@ void mwifiex_process_sta_txpd(struct mwifiex_private *priv,
 	memset(local_tx_pd, 0, sizeof(struct txpd));
 	local_tx_pd->bss_num = priv->bss_num;
 	local_tx_pd->bss_type = priv->bss_type;
-	local_tx_pd->tx_pkt_length = cpu_to_le16((u16)(skb->len -
-						       (sizeof(struct txpd) +
-							pad)));
+	pkt_length = (u16)(skb->len - (sizeof(struct txpd) + pad));
+	if (pkt_type == PKT_TYPE_MGMT)
+		pkt_length -= MWIFIEX_MGMT_FRAME_HEADER_SIZE;
+	local_tx_pd->tx_pkt_length = cpu_to_le16(pkt_length);
 
 	local_tx_pd->priority = (u8) skb->priority;
 	local_tx_pd->pkt_delay_2ms =
diff --git a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
index e78a201cd150..eb0b8016d43d 100644
--- a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
+++ b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
@@ -743,6 +743,29 @@ mwifiex_cmd_uap_sys_config(struct host_cmd_ds_command *cmd, u16 cmd_action,
 	return 0;
 }
 
+/* This function prepares AP start up command with or without host MLME
+ */
+static int mwifiex_cmd_uap_bss_start(struct mwifiex_private *priv,
+				     struct host_cmd_ds_command *cmd)
+{
+	struct mwifiex_ie_types_host_mlme *tlv;
+
+	cmd->command = cpu_to_le16(HostCmd_CMD_UAP_BSS_START);
+	cmd->size = S_DS_GEN;
+
+	if (priv->adapter->host_mlme) {
+		tlv = (struct mwifiex_ie_types_host_mlme *)((u8 *)cmd + cmd->size);
+		tlv->header.type = cpu_to_le16(TLV_TYPE_HOST_MLME);
+		tlv->header.len = cpu_to_le16(sizeof(tlv->host_mlme));
+		tlv->host_mlme = 1;
+		cmd->size += sizeof(struct mwifiex_ie_types_host_mlme);
+	}
+
+	cmd->size = cpu_to_le16(cmd->size);
+
+	return 0;
+}
+
 /* This function prepares AP specific deauth command with mac supplied in
  * function parameter.
  */
@@ -777,6 +800,9 @@ int mwifiex_uap_prepare_cmd(struct mwifiex_private *priv, u16 cmd_no,
 			return -1;
 		break;
 	case HostCmd_CMD_UAP_BSS_START:
+		if (mwifiex_cmd_uap_bss_start(priv, cmd))
+			return -1;
+		break;
 	case HostCmd_CMD_UAP_BSS_STOP:
 	case HOST_CMD_APCMD_SYS_RESET:
 	case HOST_CMD_APCMD_STA_LIST:
diff --git a/drivers/net/wireless/marvell/mwifiex/util.c b/drivers/net/wireless/marvell/mwifiex/util.c
index 745b1d925b21..23675c1cecae 100644
--- a/drivers/net/wireless/marvell/mwifiex/util.c
+++ b/drivers/net/wireless/marvell/mwifiex/util.c
@@ -370,6 +370,46 @@ mwifiex_parse_mgmt_packet(struct mwifiex_private *priv, u8 *payload, u16 len,
 
 	return 0;
 }
+
+/* This function sends deauth packet to the kernel. */
+void mwifiex_host_mlme_disconnect(struct mwifiex_private *priv,
+				  u16 reason_code, u8 *sa)
+{
+	u8 broadcast_addr[ETH_ALEN] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
+	u8 frame_buf[100];
+	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)frame_buf;
+
+	memset(frame_buf, 0, sizeof(frame_buf));
+	mgmt->frame_control = (__force __le16)IEEE80211_STYPE_DEAUTH;
+	mgmt->duration = 0;
+	mgmt->seq_ctrl = 0;
+	mgmt->u.deauth.reason_code = (__force __le16)reason_code;
+
+	if (GET_BSS_ROLE(priv) == MWIFIEX_BSS_ROLE_STA) {
+		memcpy(mgmt->da, broadcast_addr, ETH_ALEN);
+		memcpy(mgmt->sa,
+		       priv->curr_bss_params.bss_descriptor.mac_address,
+		       ETH_ALEN);
+		memcpy(mgmt->bssid, priv->cfg_bssid, ETH_ALEN);
+		priv->auth_flag = 0;
+		priv->auth_alg = 0xFFFF;
+	} else {
+		memcpy(mgmt->da, priv->curr_addr, ETH_ALEN);
+		memcpy(mgmt->sa, sa, ETH_ALEN);
+		memcpy(mgmt->bssid, priv->curr_addr, ETH_ALEN);
+	}
+
+	if (GET_BSS_ROLE(priv) != MWIFIEX_BSS_ROLE_UAP) {
+		wiphy_lock(priv->wdev.wiphy);
+		cfg80211_rx_mlme_mgmt(priv->netdev, frame_buf, 26);
+		wiphy_unlock(priv->wdev.wiphy);
+	} else {
+		cfg80211_rx_mgmt(&priv->wdev,
+				 priv->bss_chandef.chan->center_freq,
+				 0, frame_buf, 26, 0);
+	}
+}
+
 /*
  * This function processes the received management packet and send it
  * to the kernel.
@@ -417,6 +457,39 @@ mwifiex_process_mgmt_packet(struct mwifiex_private *priv,
 	pkt_len -= ETH_ALEN;
 	rx_pd->rx_pkt_length = cpu_to_le16(pkt_len);
 
+	if (priv->host_mlme_reg &&
+	    (GET_BSS_ROLE(priv) != MWIFIEX_BSS_ROLE_UAP) &&
+	    (ieee80211_is_auth(ieee_hdr->frame_control) ||
+	     ieee80211_is_deauth(ieee_hdr->frame_control) ||
+	     ieee80211_is_disassoc(ieee_hdr->frame_control))) {
+		if (ieee80211_is_auth(ieee_hdr->frame_control)) {
+			if (priv->auth_flag & HOST_MLME_AUTH_PENDING) {
+				if (priv->auth_alg != WLAN_AUTH_SAE) {
+					priv->auth_flag &=
+						~HOST_MLME_AUTH_PENDING;
+					priv->auth_flag |=
+						HOST_MLME_AUTH_DONE;
+				}
+			} else {
+				return 0;
+			}
+
+			mwifiex_dbg(priv->adapter, MSG,
+				    "auth: receive authentication from %pM\n",
+				    ieee_hdr->addr3);
+		} else {
+			if (!priv->wdev.connected)
+				return 0;
+
+			if (ieee80211_is_deauth(ieee_hdr->frame_control)) {
+				priv->auth_flag = 0;
+				priv->auth_alg = 0xFFFF;
+			}
+		}
+
+		cfg80211_rx_mlme_mgmt(priv->netdev, skb->data, pkt_len);
+	}
+
 	cfg80211_rx_mgmt(&priv->wdev, priv->roc_cfg.chan.center_freq,
 			 CAL_RSSI(rx_pd->snr, rx_pd->nf), skb->data, pkt_len,
 			 0);
-- 
2.25.1


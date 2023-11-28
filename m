Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805987FB42A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 09:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbjK1IcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 03:32:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344164AbjK1IcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 03:32:07 -0500
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2069.outbound.protection.outlook.com [40.107.241.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4AD1D59;
        Tue, 28 Nov 2023 00:32:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YaQit2xAnnwRZrTy/qgoX6fbbSbbuKkVs7itKE/aAIoD2y07454fnXWpg/74ENRea8QnE063Om8CoZzmZAXbV8+phsoUK2OQPnk33+fyDSwzgzNXT4yvae8Gto8EiRifCOxh/TzOyVPNVXtRWMjdcpc2Ts/uckALEa/yx/dzqrt6NaajNwA1fLt/UzNulABot1INXuGi+ioDcoFulUtigazHsZ18D45PfjavGh1gcBROFso50RSmf9bcHOiIm/35ct+lOICOWLsmjZ8+t+7csvEdzIERxgC9gQd/FdRuEgnR4/ABvr8X+EhvqJ1XYsSHgBaTkQbhQSg516//JRxPQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C035kGY4S1lfiGSdH8eBw2TM7dNuBhd6S1Q6Otb7i7o=;
 b=DXYXUmepP/P05cK4h7QjnjLalXIReHw2Za2VpRGm9+YOPU6YIX2AJ/U5ZXBz1RBNJCICte6/ADVdgpIwTVrz72XGVgWBT9y8dZAT35B16WSxhTDGIEWW2E9iy9P4DwU1aiQMy3PKINeMnssy+wixgxbvdiwvh/lo9nT/nJX51TJzfxYqKk7k8VlTsewjUqDZSfUdMSRNAOM4nQ9cCws9F7Sb9K4EACd8OelvhHT1DRjYcXYuwFaOjMPIqiYq+i9dyThmDStxAcuX9+PetDfZrZDtT+4GAavLV2auT9sEN6EwwfzGCuBMGrclnuhxbv1gWDfyq69C8dkYPBcdeHC/ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C035kGY4S1lfiGSdH8eBw2TM7dNuBhd6S1Q6Otb7i7o=;
 b=Y4wCHZEJUCfstxJKz4xWt9RqcXKl0YLqcfrMo3kGnOv+mcZJLN00uSoVIgEhsDa4ByBtPC2Z/O429kd90i7rGYHD7fh1I3UODEPICauNR31c1pwWm3F7WY070AyFiuKD7+ACEZrMOxxwuwR51c6Nu1JmnTH9DFRhLLKeWDk8WWk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by AS5PR04MB10043.eurprd04.prod.outlook.com (2603:10a6:20b:67f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.18; Tue, 28 Nov
 2023 08:31:58 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b%7]) with mapi id 15.20.7046.015; Tue, 28 Nov 2023
 08:31:58 +0000
From:   David Lin <yu-hao.lin@nxp.com>
To:     linux-wireless@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, briannorris@chromium.org,
        kvalo@kernel.org, francesco@dolcini.it, tsung-hsien.hsieh@nxp.com,
        David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH v7 05/12] wifi: mwifiex: supported host mlme for AP mode.
Date:   Tue, 28 Nov 2023 16:31:08 +0800
Message-Id: <20231128083115.613235-6-yu-hao.lin@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PA4PR04MB9638:EE_|AS5PR04MB10043:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a19d38d-326f-4dad-02d5-08dbefec7c6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RebSAkcvh4ErOZyn6/93nAW2gy7VojKyWXndZplPg3TFrsss7NfULPFF+Aj1gZH7jrMFhLrn/2H7hR5SVkm7FOJSTz3GBikX/XR13Gd0/anDqblFKRG6Eu91Z7wDNayMM89uuELY4oAN1qH/1Q6+8e21MlociC1baO5qA0kUFXf5jDjU7K34JBVOUqv0PQGc6fICOodKNkHZfxUBWJDzvQQusbqqvtRRGdZRRENP/c/mcwIcT7NLUxbEa5pa0D9TMDrQYEBmzJ8UrxIcBNgMQAqvMm06Sj1L/qhNwgh6eJyXT2qjN6y7ypg6qzyhscFww6d5jY3uocoP7leFkhLdcFcrBDy4hiwztUQtJdwzPAu7fpENA4RQH9chgHa+2sG6xZjzxASAecrRTYCiAWYMa8/ezj13RyXn6FAGfxW4ZeNCdbAgyDXXpowj1IfO9KjAeVqr68IkfoVsdaeFmJETYXSXgxwK8YYkwFBdHuoT1b5Zt7pDB/YX04B720cYaVqVi/M0QJZ2v943cWE7SCFp3jE72qCTLJLK3vXrpcPIRw5JHkQzTdOpbRjNdYO5t4TpMjGj0D+nlty+GPPtdEGUTppi9z2cojsSDBDOG3lC/5h4iMrn0cpT9kJRtIo6VNwy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(396003)(136003)(39860400002)(230922051799003)(230273577357003)(230173577357003)(1800799012)(186009)(64100799003)(451199024)(86362001)(30864003)(2906002)(5660300002)(6506007)(83380400001)(6512007)(52116002)(41300700001)(38100700002)(36756003)(6666004)(1076003)(2616005)(66899024)(478600001)(66556008)(66946007)(6486002)(8936002)(6916009)(8676002)(316002)(4326008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cf+fpMlBKbebqdpLJFm3m610eOQ4QuWYu0onNXFYSNUSl7nNcYdeAFBUzwJ6?=
 =?us-ascii?Q?YSYsZ/sLFXv8VPkB0sGsgDMz81zUyqkUxV6W7jOQC4UM56KpAer87A3Ynhdu?=
 =?us-ascii?Q?9//BbWhs4x0U+6CshJGO+1+h2jfNb5rZZ/oqr5uqSW4FqZbZE64z1iHvjxEy?=
 =?us-ascii?Q?UGjJ8jmqEYh32mFTO3GSHEoeJ+ql7HAN8E+uLhu1b52yhO1CeYTQgBmQdolF?=
 =?us-ascii?Q?mTFS1t2CNl7SchdWGuETlN7HxOmuX6SN8ODedFIB0H7zeGT4ih1poEmBvPuR?=
 =?us-ascii?Q?3aKUB1YkqXwdLv4TO/41wIXyUwbuHIwE6I/0i6w+kLM+opU/vReGLzvoAXT1?=
 =?us-ascii?Q?pndFew2UZ7UixNjF2v01amQuowJDdbKOZeoxkBxm3BVR4ZSpkHo17PCbKhLu?=
 =?us-ascii?Q?tskoKGvKSXd8sscZuE9mhaOpHc8uIjb1zCiehYwSv6GX9x1dwR9SJGnfC2uM?=
 =?us-ascii?Q?VfKk8AgJkMUDKcETKzNTEop6vJ59zJ6qz1qhEej1kVxYjhClCioA0LXA2qU4?=
 =?us-ascii?Q?8XfxZB0E7CaX7Ykjwee9oY+A1tpkAifLdgbtZzAbj4FwC2/Jm3/Hj9fVVUr+?=
 =?us-ascii?Q?7owCqUFzTSmCZicDMG0h3ZleZ5mS16Ay7LU94zlGEtN9yf5UULr8EdDpVlGf?=
 =?us-ascii?Q?bHThBUJkLG7e/BC+rp98SzZVpMSxPfT06TCG6/8sdt72TiggYWUpuVwYflbE?=
 =?us-ascii?Q?ZLyGiY3b+V/qST7pSj2MBtbT9qew29kJQ+aNaN4HQu0a3Mq0/2q4livGKhOm?=
 =?us-ascii?Q?/7vvVEqEMfJmjKMPDY8Gi4Nt1OUtxl6Y4m/DsEYj+s7lFt3MvSWvMIELOiPn?=
 =?us-ascii?Q?0wuht5LJ+44KmMs4hjg8Uus3dXe9cU2YZlPYGdnOJxHbjGWw9dkGXbCnR7Yw?=
 =?us-ascii?Q?tSyYzBHQo9cvzf6cHNg5MbzQn8hLHJwfxoxxnk0A9kpLCI+z/XI4Z4Z8xDY5?=
 =?us-ascii?Q?aNCCvymMHOPBvENTtXMIuzK5P+QdevBUKj/5BWs+6LuQVbXZW40ceukUcUn9?=
 =?us-ascii?Q?BMt3lV2WoB+WsopPUe5++Nl7x34PoRZJqS6aFiHHbVbhwR8qZSxzheBHbpje?=
 =?us-ascii?Q?LJw5cIuUdVJbrTkjRJpxbQ7jFRtMHVZzytqFYbO/FPs0uGiPFENiLMAawsML?=
 =?us-ascii?Q?Pp72VZP3/gW6dG2UKHYjAt8wN/yGAx5+KwmsSvoq7/AlRWW3e7O4YKwefbBl?=
 =?us-ascii?Q?t7zd/Cb1nFZmQyz54xPvPYPj7eXiKXRap6I6QVaY8hq+URq2qZGLmlQ2YHnd?=
 =?us-ascii?Q?t8cnuTuAQjt3AUzf6IDZt176pTc+WB/vTcxtZDc1lcT+mdp/6tD8x8FEvPz0?=
 =?us-ascii?Q?9EDC9YaScjt3eXhwr16Hu26BdIEs+NBEQ+y+55DvhS8i7olALoMvv5Q67kr0?=
 =?us-ascii?Q?+uhZoUPgVu5so1i72VDIY2P9USMgiqsLD1RKdK4dKFvEJBYCyzt0asyXRVzg?=
 =?us-ascii?Q?IMu1/NstJxb7WDp4QVHre8wok3g/HWdCwJtKv/ESMRh76eoOmeu6bsRcbvbw?=
 =?us-ascii?Q?9096xTKGv/bMuKVGZJ274fsEtTX5sBv9TkRRdPZreuC68WwUiGBCq+SpRZFs?=
 =?us-ascii?Q?IOVOONplAH5JKoKOFchIf7gGdzAEbyLSKJxaFRg39tYGc7ISyiq5d7bxUvw8?=
 =?us-ascii?Q?sVWiqm2HWmd+/7kEkeal1Ooh/tpaTtzLeq7T9/VxoaBT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a19d38d-326f-4dad-02d5-08dbefec7c6e
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 08:31:58.5594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IZFDCcl8TG5bbHNFk2PXDtntHbvQLhDwIG3CMw3hQd2c0GGJHfFodoCvG3P+lY3SG5vorkuQnW0Bq48lfsjPUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10043
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added code to support host mlme for AP mode and let WPA3 work.

Signed-off-by: David Lin <yu-hao.lin@nxp.com>
---
 .../net/wireless/marvell/mwifiex/cfg80211.c   |  81 +++++++++-
 drivers/net/wireless/marvell/mwifiex/cmdevt.c |   2 +
 drivers/net/wireless/marvell/mwifiex/fw.h     |  22 ++-
 drivers/net/wireless/marvell/mwifiex/ioctl.h  |   5 +
 .../wireless/marvell/mwifiex/sta_cmdresp.c    |   2 +
 .../net/wireless/marvell/mwifiex/uap_cmd.c    | 148 ++++++++++++++++++
 drivers/net/wireless/marvell/mwifiex/util.c   |  24 +++
 7 files changed, 276 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index b99de9f4ca14..2968db643ab4 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -246,6 +246,26 @@ mwifiex_cfg80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
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
@@ -293,7 +313,8 @@ mwifiex_cfg80211_update_mgmt_frame_registrations(struct wiphy *wiphy,
 
 	if (mask != priv->mgmt_frame_mask) {
 		priv->mgmt_frame_mask = mask;
-		if (priv->host_mlme_reg)
+		if (priv->host_mlme_reg &&
+		    GET_BSS_ROLE(priv) != MWIFIEX_BSS_ROLE_UAP)
 			priv->mgmt_frame_mask |= HOST_MLME_MGMT_MASK;
 		mwifiex_send_cmd(priv, HostCmd_CMD_MGMT_FRAME_REG,
 				 HostCmd_ACT_GEN_SET, 0,
@@ -530,6 +551,9 @@ mwifiex_cfg80211_set_default_mgmt_key(struct wiphy *wiphy,
 
 	wiphy_dbg(wiphy, "set default mgmt key, key index=%d\n", key_index);
 
+	if (priv->adapter->host_mlme)
+		return 0;
+
 	memset(&encrypt_key, 0, sizeof(struct mwifiex_ds_encrypt_key));
 	encrypt_key.key_len = WLAN_KEY_LEN_CCMP;
 	encrypt_key.key_index = key_index;
@@ -1746,10 +1770,14 @@ mwifiex_mgmt_stypes[NUM_NL80211_IFTYPES] = {
 		      BIT(IEEE80211_STYPE_PROBE_REQ >> 4),
 	},
 	[NL80211_IFTYPE_AP] = {
-		.tx = BIT(IEEE80211_STYPE_ACTION >> 4) |
-		      BIT(IEEE80211_STYPE_PROBE_RESP >> 4),
-		.rx = BIT(IEEE80211_STYPE_ACTION >> 4) |
-		      BIT(IEEE80211_STYPE_PROBE_REQ >> 4),
+		.tx = 0xffff,
+		.rx = BIT(IEEE80211_STYPE_ASSOC_REQ >> 4) |
+		      BIT(IEEE80211_STYPE_REASSOC_REQ >> 4) |
+		      BIT(IEEE80211_STYPE_PROBE_REQ >> 4) |
+		      BIT(IEEE80211_STYPE_DISASSOC >> 4) |
+		      BIT(IEEE80211_STYPE_AUTH >> 4) |
+		      BIT(IEEE80211_STYPE_DEAUTH >> 4) |
+		      BIT(IEEE80211_STYPE_ACTION >> 4),
 	},
 	[NL80211_IFTYPE_P2P_CLIENT] = {
 		.tx = BIT(IEEE80211_STYPE_ACTION >> 4) |
@@ -3974,12 +4002,43 @@ mwifiex_cfg80211_tdls_cancel_chan_switch(struct wiphy *wiphy,
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
+		struct station_info *sinfo = NULL;
+
+		sinfo = kzalloc(sizeof(*sinfo), GFP_KERNEL);
+
+		if (sinfo) {
+			cfg80211_new_sta(priv->netdev, mac, sinfo, GFP_KERNEL);
+			kfree(sinfo);
+		}
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
 
+	if (priv->adapter->host_mlme &&
+	    (GET_BSS_ROLE(priv) == MWIFIEX_BSS_ROLE_UAP))
+		return mwifiex_cfg80211_uap_add_station(priv, mac, params);
+
 	if (!(params->sta_flags_set & BIT(NL80211_STA_FLAG_TDLS_PEER)))
 		return -EOPNOTSUPP;
 
@@ -4217,6 +4276,10 @@ mwifiex_cfg80211_change_station(struct wiphy *wiphy, struct net_device *dev,
 	int ret;
 	struct mwifiex_private *priv = mwifiex_netdev_get_priv(dev);
 
+	if (priv->adapter->host_mlme &&
+	    (GET_BSS_ROLE(priv) == MWIFIEX_BSS_ROLE_UAP))
+		return 0;
+
 	/* we support change_station handler only for TDLS peers*/
 	if (!(params->sta_flags_set & BIT(NL80211_STA_FLAG_TDLS_PEER)))
 		return -EOPNOTSUPP;
@@ -4727,14 +4790,18 @@ int mwifiex_register_cfg80211(struct mwifiex_adapter *adapter)
 
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
 
+	if (adapter->host_mlme)
+		wiphy->flags |= WIPHY_FLAG_REPORTS_OBSS;
+	else
+		wiphy->flags |= WIPHY_FLAG_HAVE_AP_SME;
+
 	if (ISSUPP_TDLS_ENABLED(adapter->fw_cap_info))
 		wiphy->flags |= WIPHY_FLAG_SUPPORTS_TDLS |
 				WIPHY_FLAG_TDLS_EXTERNAL_SETUP;
diff --git a/drivers/net/wireless/marvell/mwifiex/cmdevt.c b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
index 16777af50097..c8d94cc6706f 100644
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
index 8b22cd993a79..7080f8701952 100644
--- a/drivers/net/wireless/marvell/mwifiex/fw.h
+++ b/drivers/net/wireless/marvell/mwifiex/fw.h
@@ -210,9 +210,9 @@ enum MWIFIEX_802_11_PRIVACY_FILTER {
 #define TLV_TYPE_CHAN_ATTR_CFG      (PROPRIETARY_TLV_BASE_ID + 237)
 #define TLV_TYPE_MAX_CONN           (PROPRIETARY_TLV_BASE_ID + 279)
 #define TLV_TYPE_HOST_MLME          (PROPRIETARY_TLV_BASE_ID + 307)
+#define TLV_TYPE_UAP_STA_FLAGS      (PROPRIETARY_TLV_BASE_ID + 313)
 #define TLV_TYPE_SAE_PWE_MODE       (PROPRIETARY_TLV_BASE_ID + 339)
 
-
 #define MWIFIEX_TX_DATA_BUF_SIZE_2K        2048
 
 #define SSN_MASK         0xfff0
@@ -407,6 +407,7 @@ enum MWIFIEX_802_11_PRIVACY_FILTER {
 #define HostCmd_CMD_STA_CONFIGURE		      0x023f
 #define HostCmd_CMD_CHAN_REGION_CFG		      0x0242
 #define HostCmd_CMD_PACKET_AGGR_CTRL		      0x0251
+#define HostCmd_CMD_ADD_NEW_STATION		      0x025f
 
 #define PROTOCOL_NO_SECURITY        0x01
 #define PROTOCOL_STATIC_WEP         0x02
@@ -417,6 +418,7 @@ enum MWIFIEX_802_11_PRIVACY_FILTER {
 #define KEY_MGMT_NONE               0x04
 #define KEY_MGMT_PSK                0x02
 #define KEY_MGMT_EAP                0x01
+#define KEY_MGMT_SAE                0x400
 #define CIPHER_TKIP                 0x04
 #define CIPHER_AES_CCMP             0x08
 #define VALID_CIPHER_BITMAP         0x0c
@@ -502,6 +504,9 @@ enum mwifiex_channel_flags {
 #define HostCmd_ACT_GET_TX              0x0008
 #define HostCmd_ACT_GET_BOTH            0x000c
 
+#define HostCmd_ACT_REMOVE_STA          0x0
+#define HostCmd_ACT_ADD_STA             0x1
+
 #define RF_ANTENNA_AUTO                 0xFFFF
 
 #define HostCmd_SET_SEQ_NO_BSS_INFO(seq, num, type) \
@@ -2312,6 +2317,20 @@ struct host_cmd_ds_sta_configure {
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
@@ -2390,6 +2409,7 @@ struct host_cmd_ds_command {
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
index eb0b8016d43d..91a8a581e3f5 100644
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
@@ -783,6 +787,145 @@ static int mwifiex_cmd_uap_sta_deauth(struct mwifiex_private *priv,
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
+	struct mwifiex_ie_types_header *tlv;
+	struct mwifiex_ie_types_sta_flag *sta_flag;
+	int i;
+
+	cmd->command = cpu_to_le16(HostCmd_CMD_ADD_NEW_STATION);
+	new_sta->action = cpu_to_le16(cmd_action);
+	cmd->size = sizeof(struct host_cmd_ds_add_station) + S_DS_GEN;
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
+	cmd->size += sizeof(struct mwifiex_ie_types_sta_flag);
+
+	if (params->ext_capab_len) {
+		tlv = (struct mwifiex_ie_types_header *)pos;
+		tlv->type = cpu_to_le16(WLAN_EID_EXT_CAPABILITY);
+		tlv_len = params->ext_capab_len;
+		tlv->len = cpu_to_le16(tlv_len);
+		memcpy(tlv + header_len, params->ext_capab, tlv_len);
+		pos += (header_len + tlv_len);
+		cmd->size += (header_len + tlv_len);
+	}
+
+	if (params->link_sta_params.supported_rates_len) {
+		tlv = (struct mwifiex_ie_types_header *)pos;
+		tlv->type = cpu_to_le16(WLAN_EID_SUPP_RATES);
+		tlv_len = params->link_sta_params.supported_rates_len;
+		tlv->len = cpu_to_le16(tlv_len);
+		memcpy(tlv + header_len,
+		       params->link_sta_params.supported_rates, tlv_len);
+		pos += (header_len + tlv_len);
+		cmd->size += (header_len + tlv_len);
+	}
+
+	if (params->uapsd_queues || params->max_sp) {
+		tlv = (struct mwifiex_ie_types_header *)pos;
+		tlv->type = cpu_to_le16(WLAN_EID_QOS_CAPA);
+		tlv_len = sizeof(qos_capa);
+		tlv->len = cpu_to_le16(tlv_len);
+		qos_capa = params->uapsd_queues | (params->max_sp << 5);
+		memcpy(tlv + header_len, &qos_capa, tlv_len);
+		pos += (header_len + tlv_len);
+		cmd->size += (header_len + tlv_len);
+		sta_ptr->is_wmm_enabled = 1;
+	}
+
+	if (params->link_sta_params.ht_capa) {
+		tlv = (struct mwifiex_ie_types_header *)pos;
+		tlv->type = cpu_to_le16(WLAN_EID_HT_CAPABILITY);
+		tlv_len = sizeof(struct ieee80211_ht_cap);
+		tlv->len = cpu_to_le16(tlv_len);
+		memcpy(tlv + header_len, params->link_sta_params.ht_capa,
+		       tlv_len);
+		pos += (header_len + tlv_len);
+		cmd->size += (header_len + tlv_len);
+		sta_ptr->is_11n_enabled = 1;
+		sta_ptr->max_amsdu =
+			le16_to_cpu(params->link_sta_params.ht_capa->cap_info) &
+			IEEE80211_HT_CAP_MAX_AMSDU ?
+			MWIFIEX_TX_DATA_BUF_SIZE_8K :
+			MWIFIEX_TX_DATA_BUF_SIZE_4K;
+	}
+
+	if (params->link_sta_params.vht_capa) {
+		tlv = (struct mwifiex_ie_types_header *)pos;
+		tlv->type = cpu_to_le16(WLAN_EID_VHT_CAPABILITY);
+		tlv_len = sizeof(struct ieee80211_vht_cap);
+		tlv->len = cpu_to_le16(tlv_len);
+		memcpy(tlv + header_len, params->link_sta_params.vht_capa,
+		       tlv_len);
+		pos += (header_len + tlv_len);
+		cmd->size += (header_len + tlv_len);
+		sta_ptr->is_11ac_enabled = 1;
+	}
+
+	if (params->link_sta_params.opmode_notif_used) {
+		tlv = (struct mwifiex_ie_types_header *)pos;
+		tlv->type = cpu_to_le16(WLAN_EID_OPMODE_NOTIF);
+		tlv_len = sizeof(u8);
+		tlv->len = cpu_to_le16(tlv_len);
+		memcpy(tlv + header_len, params->link_sta_params.opmode_notif,
+		       tlv_len);
+		pos += (header_len + tlv_len);
+		cmd->size += (header_len + tlv_len);
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
+	cmd->size = cpu_to_le16(cmd->size);
+
+	return 0;
+}
+
 /* This function prepares the AP specific commands before sending them
  * to the firmware.
  * This is a generic function which calls specific command preparation
@@ -818,6 +961,11 @@ int mwifiex_uap_prepare_cmd(struct mwifiex_private *priv, u16 cmd_no,
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
index ff1b2f162c30..9e36bb4a8d67 100644
--- a/drivers/net/wireless/marvell/mwifiex/util.c
+++ b/drivers/net/wireless/marvell/mwifiex/util.c
@@ -497,6 +497,30 @@ mwifiex_process_mgmt_packet(struct mwifiex_private *priv,
 		cfg80211_rx_mlme_mgmt(priv->netdev, skb->data, pkt_len);
 	}
 
+	if (priv->adapter->host_mlme &&
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


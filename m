Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375CD7D0725
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 05:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376329AbjJTDtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 23:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346999AbjJTDsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 23:48:47 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2050.outbound.protection.outlook.com [40.107.21.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE96D79;
        Thu, 19 Oct 2023 20:48:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W02nkRRnBXUDFETs+KKZwlJtEextIB74atQQ5c2rG9qpbU1O+A8/zC5D/lEGMypW5cq2mGXBGV/t+aEze9YyvW8EC7oHxiXF8lNj+Cc1bCBYKS9lsZ56AquFXmf5Em4SDtfsjbVJpceBSSZwMFA9kP2KLjJJl8z+S+psH2EnrSl3/O2M34iIke3AseKkZ8lcOjoc/i9jJvmujcDayCyzr5X22W+PKZg7X1cKnVYg5yZTzrSdtP7BTIx2FK2rVCkHCEt5ZxIAC+8qm5AlejLF77+x0Z1tgRynCWEBfUcNu9F4hKdU2V3sf3Kf6FurTiBy16CxMUFWAH54fe/gcCHokA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ysWULn5r2ulql1x1U1BTLzMnHQqNo1+u/i7q/0e68l8=;
 b=Q4uDmWI6wVDiHQdBr5dQ5a5qJn4hf/VXH7vNEip8qQIPQD2ZRA34NOu2iqA68dQOyAPFqaVeaRPHLUN7nUWulEZmRjzjWQ/0+vebKnyMoX+SuF5GpGrYVd/ZgX9f+8IV9qkzGxN/THwp90Jx7YI2jChqfVHGT92FU4nVicToGTfdKeJXtzyLFcJLMO1uBPXqaZ4Te68tFNr3XsXah4gHDpQl+6GTF56KNjjiXST5gm/g/60AtmGZl2Io9nbGe7t8SQyDkxcT0oZ3a7U3Mqy12F0W1m9Ch8RPoZ75UudQwgpdZvHwSu7GIn+9i6awlTz4Grw3WJ3L0tIyxImlLamlSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ysWULn5r2ulql1x1U1BTLzMnHQqNo1+u/i7q/0e68l8=;
 b=hw3LFGrb4ULlbEqow12ie/uaHZyFQXqCKBYk8gWppqt+BYlIAjnRhKtBIa2Qc3y+kVCic4AgRtOZg+XwXIi9DpYDKOlhUvnbayj9Iv89GGGsPDvPrVJTKIIAHrUKZ1yMEbv8fWTAR8uReTtpYyhrCMvRjKdhzPR+aT6ZTYor7CU=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by VI1PR04MB7069.eurprd04.prod.outlook.com (2603:10a6:800:127::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.11; Fri, 20 Oct
 2023 03:48:26 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b%7]) with mapi id 15.20.6933.011; Fri, 20 Oct 2023
 03:48:26 +0000
Content-Type: multipart/mixed;
        boundary="_000_PA4PR04MB963810163D84020486AC720DD1DBAPA4PR04MB9638eurp_"
From:   David Lin <yu-hao.lin@nxp.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "briannorris@chromium.org" <briannorris@chromium.org>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "francesco@dolcini.it" <francesco@dolcini.it>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        David Lin <yu-hao.lin@nxp.com>,
        Pete Hsieh <tsung-hsien.hsieh@nxp.com>
Subject: [PATCH v6 5/6] wifi: mwifiex: supported host mlme for AP mode.
Thread-Topic: [PATCH v6 5/6] wifi: mwifiex: supported host mlme for AP mode.
Thread-Index: AdoDCEZkNa8a4Iv/RwSnAs5s8DeG7A==
Date:   Fri, 20 Oct 2023 03:48:25 +0000
Message-ID: <PA4PR04MB963810163D84020486AC720DD1DBA@PA4PR04MB9638.eurprd04.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: <PA4PR04MB963810163D84020486AC720DD1DBA@PA4PR04MB9638.eurprd04.prod.outlook.com>
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|VI1PR04MB7069:EE_
x-ms-office365-filtering-correlation-id: 400d4f01-ade9-43e5-d8a8-08dbd11f6a4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s9SWoCx5LcNqXLLvrBLglXzYEjn7S3t12Ii6ElwvY7IYulI6XAjAuTlRxpJ7OTEfc7TmB+aEoLJwzzlWHPO3S19fgK6OiESo057YTpgGymZH4lCOTqXjvh0H9XXk/4TJvEzt2MHdyLSBsgnJQrgTcK45VZZIHQI00dIX+93bjPm38XvPLPm8wOjQKxZhybUmnHtnZXETVcE5rRjIkdSOLHUUhDgUdxLpOnxvDE2C5QH1V+EJdr1XwVUQPepBmBcO35/4UHoSjhzdOMZeJbdMzUKo/SJdVdlVpbYbOGOB8Rwq6bHAioI6LsAynpIRSJupjDtukrATJi0hMeOV5+SHOID1Ih1Ud8I3Ci6QL6TjFLznp3pYBVKom7ZUvkoKrF4CxsPWQjZasjOuz/hX8E1i3ay7mI0VuCPNyspmMsIt7fJ5HAgrX5ZLV2X5DDfIMZgJAsOQ9MZLK3rPMpCbEJPHN7aRagLIB8fgwrhpN/LaDdT0yVSSopjNn9rdMOre7aWF52je0bOwIhHidta4EAwWnnJYbb143DlEobacR03l0LhMzuWPEkY3gN5nuohh3WCoTsRtaNvg1r/hTJPQBFYC5hLyovCIsH3OVwYLRkAM58+5ud0BrByZWuPHSQzjV1Nm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(376002)(39860400002)(346002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(30864003)(55016003)(38100700002)(66899024)(41300700001)(4326008)(5660300002)(8676002)(8936002)(52536014)(86362001)(33656002)(2906002)(122000001)(478600001)(83380400001)(9686003)(7696005)(26005)(71200400001)(6506007)(316002)(38070700009)(66946007)(76116006)(54906003)(66476007)(6916009)(66446008)(64756008)(66556008)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7GGLCbpP7Uz94/AIqzCO5KtdRpCsdiKTTgT5FM6aK3Ls1Ahd6ZXYFuiuWvHL?=
 =?us-ascii?Q?1qLP4u/QNTt+NYXb8VkczMDgJkafI6PRQBW8WhLhK0XPp9fTlsiI893k5YlC?=
 =?us-ascii?Q?zNm6qjD2NtsFxmTDYOy0sKrZlftG3Z6XDeXnBPw/yoSXEedpaIHeo79mCs+d?=
 =?us-ascii?Q?D9x/KUAUkzAk0nH7SehJ03sMN8vQNcItuD3wyLAp+NAOfjxm3YchqRz6YV68?=
 =?us-ascii?Q?4O9Yv9gLJFqxG68L/LrxWptOERzKaEqHXzlLKcAgSzzMRczbrHiIK7ICYjbS?=
 =?us-ascii?Q?PkVGJOPoRD8WrVyZ7/e9i4+9BvZTPXVc2YGOfSa2I01by2Vc0SCdT6A+xrPG?=
 =?us-ascii?Q?5tNOnPUGGkasx18ZDBkn3KxUNr7SUTMwb+Lm2IGYLpXHQy06eL+JYx1gt7JN?=
 =?us-ascii?Q?2mMf9Q5QYOBC4TpqvwOTjpkzgb34qMrCswo1lu3gEuRvM7iKk4OkwEdzFkYV?=
 =?us-ascii?Q?1HEiQ0zOmANjoQnqF+gTb3EZt3hCE7cw8mZv+/d9X/gMyceCfhRunPToObRW?=
 =?us-ascii?Q?SCVO4ncqzU974/9eBSZWAteI/g75RvhaGaqnVryYy4wLs8X01tqFfRCMIAXI?=
 =?us-ascii?Q?K18xeiXn87Ln0LX7RZtGaRZlAFD2HItbu/rMjWj0mBNXyjL7cepGrvGvRzyi?=
 =?us-ascii?Q?LUMe3PTMp82PbvUc11cmypnt/sX2RowU+aXamwcI6UmHlh4/J6QzDoE+zYkr?=
 =?us-ascii?Q?hRJlFi9JtJLfsMUWsdfUErqg81YTfctmTr/VNXE2bACAjpKt9GMwBlme8n4F?=
 =?us-ascii?Q?S54A0cFGD4StW3oQFczW8bC5MwNcoUnUFR0H6TE5EJW6qo58hmjYdmHLXfCQ?=
 =?us-ascii?Q?bz3OSTXPzfAL0SsfE1FhMwmajY6pFqdFhTky5qYMV2jYIt8VUJggM4mRTk8F?=
 =?us-ascii?Q?Wzlh+ZWtA5FVQ+2gZsRDrhK5/R2Na6T1l7a5GpfODliZ3LYNVUIDMUgLwLo5?=
 =?us-ascii?Q?Bx8PHYVLzTt7aXXu758nP3d9odtkeDRxz6izIX7Y5J3GI0XmI7SN0L3zzkRs?=
 =?us-ascii?Q?YpPtdRK+ShhSjCXBjVYA+CP+OdhEn5NwIsKyrH+wNPoN0Dy2vHE+JjX9RLrL?=
 =?us-ascii?Q?0/rHOP1QkymwNGn41bzJMz8VshMi7aj7NmVNaDtSNdW7A5K2Oe/OI6GCjJ/p?=
 =?us-ascii?Q?2e+5fKc7FM7UNXWKkDQMzmX7DuJ92PI4YjskdiJaxqrZRsSdw7jSr9Amjzb3?=
 =?us-ascii?Q?sBPloBDuFRNGwGSfjkqxaHJZhHWcYIFG5IwzIbgyeER0jGBrdoe/tHKtjzEw?=
 =?us-ascii?Q?Czo19Ezf/F+tO1/AVpPjRi7cwIlsSfmPI7v3uUQfuCh1BB3pZy3W//fWL8b1?=
 =?us-ascii?Q?zrhMzjR05uEvB5VyFuIP8FRoQwU/7q5NURwkneWGpj7FhuaBSsJWODVBN9H3?=
 =?us-ascii?Q?nnuZxgiIKVxBTokJg/SqXkYLewTP2KYF4JUWCM/Z8NtetjpsPtSr9GXLLbDJ?=
 =?us-ascii?Q?wi+zY+CD7SxmOOVFRaz9HCMpoZpEDuPbEYuwszYDzrdb1tg/DErfRraHuMYM?=
 =?us-ascii?Q?TmCvh6rCc691P9IiIMqQaKfXmLCXdOWjJXT8NHvlnq5hC++vMmpbXwQMYfIy?=
 =?us-ascii?Q?PxFwrf71egXaiQiJMsuo7riwTgED7V+4oxUoshET?=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 400d4f01-ade9-43e5-d8a8-08dbd11f6a4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2023 03:48:26.0125
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KRv8oYlaSjePJIZ6dPdw+rz+cr0x0RYNsZCY2sE00zhOtHU0FRRUrnKhZ3jMzdfn/pPCPXx+xMHFT5p4LNVp2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7069
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--_000_PA4PR04MB963810163D84020486AC720DD1DBAPA4PR04MB9638eurp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

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

diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/=
wireless/marvell/mwifiex/cfg80211.c
index b99de9f4ca14..2968db643ab4 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -246,6 +246,26 @@ mwifiex_cfg80211_mgmt_tx(struct wiphy *wiphy, struct w=
ireless_dev *wdev,
 		return 0;
 	}
=20
+	if (GET_BSS_ROLE(priv) =3D=3D MWIFIEX_BSS_ROLE_UAP) {
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
 	pkt_len =3D len + ETH_ALEN;
 	skb =3D dev_alloc_skb(MWIFIEX_MIN_DATA_HEADER_LEN +
 			    MWIFIEX_MGMT_FRAME_HEADER_SIZE +
@@ -293,7 +313,8 @@ mwifiex_cfg80211_update_mgmt_frame_registrations(struct=
 wiphy *wiphy,
=20
 	if (mask !=3D priv->mgmt_frame_mask) {
 		priv->mgmt_frame_mask =3D mask;
-		if (priv->host_mlme_reg)
+		if (priv->host_mlme_reg &&
+		    GET_BSS_ROLE(priv) !=3D MWIFIEX_BSS_ROLE_UAP)
 			priv->mgmt_frame_mask |=3D HOST_MLME_MGMT_MASK;
 		mwifiex_send_cmd(priv, HostCmd_CMD_MGMT_FRAME_REG,
 				 HostCmd_ACT_GEN_SET, 0,
@@ -530,6 +551,9 @@ mwifiex_cfg80211_set_default_mgmt_key(struct wiphy *wip=
hy,
=20
 	wiphy_dbg(wiphy, "set default mgmt key, key index=3D%d\n", key_index);
=20
+	if (priv->adapter->host_mlme)
+		return 0;
+
 	memset(&encrypt_key, 0, sizeof(struct mwifiex_ds_encrypt_key));
 	encrypt_key.key_len =3D WLAN_KEY_LEN_CCMP;
 	encrypt_key.key_index =3D key_index;
@@ -1746,10 +1770,14 @@ mwifiex_mgmt_stypes[NUM_NL80211_IFTYPES] =3D {
 		      BIT(IEEE80211_STYPE_PROBE_REQ >> 4),
 	},
 	[NL80211_IFTYPE_AP] =3D {
-		.tx =3D BIT(IEEE80211_STYPE_ACTION >> 4) |
-		      BIT(IEEE80211_STYPE_PROBE_RESP >> 4),
-		.rx =3D BIT(IEEE80211_STYPE_ACTION >> 4) |
-		      BIT(IEEE80211_STYPE_PROBE_REQ >> 4),
+		.tx =3D 0xffff,
+		.rx =3D BIT(IEEE80211_STYPE_ASSOC_REQ >> 4) |
+		      BIT(IEEE80211_STYPE_REASSOC_REQ >> 4) |
+		      BIT(IEEE80211_STYPE_PROBE_REQ >> 4) |
+		      BIT(IEEE80211_STYPE_DISASSOC >> 4) |
+		      BIT(IEEE80211_STYPE_AUTH >> 4) |
+		      BIT(IEEE80211_STYPE_DEAUTH >> 4) |
+		      BIT(IEEE80211_STYPE_ACTION >> 4),
 	},
 	[NL80211_IFTYPE_P2P_CLIENT] =3D {
 		.tx =3D BIT(IEEE80211_STYPE_ACTION >> 4) |
@@ -3974,12 +4002,43 @@ mwifiex_cfg80211_tdls_cancel_chan_switch(struct wip=
hy *wiphy,
 	}
 }
=20
+static int
+mwifiex_cfg80211_uap_add_station(struct mwifiex_private *priv, const u8 *m=
ac,
+				 struct station_parameters *params)
+{
+	struct mwifiex_sta_info add_sta;
+	int ret;
+
+	memcpy(add_sta.peer_mac, mac, ETH_ALEN);
+	add_sta.params =3D params;
+
+	ret =3D mwifiex_send_cmd(priv, HostCmd_CMD_ADD_NEW_STATION,
+			       HostCmd_ACT_ADD_STA, 0, (void *)&add_sta, true);
+
+	if (!ret) {
+		struct station_info *sinfo =3D NULL;
+
+		sinfo =3D kzalloc(sizeof(*sinfo), GFP_KERNEL);
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
 	struct mwifiex_private *priv =3D mwifiex_netdev_get_priv(dev);
=20
+	if (priv->adapter->host_mlme &&
+	    (GET_BSS_ROLE(priv) =3D=3D MWIFIEX_BSS_ROLE_UAP))
+		return mwifiex_cfg80211_uap_add_station(priv, mac, params);
+
 	if (!(params->sta_flags_set & BIT(NL80211_STA_FLAG_TDLS_PEER)))
 		return -EOPNOTSUPP;
=20
@@ -4217,6 +4276,10 @@ mwifiex_cfg80211_change_station(struct wiphy *wiphy,=
 struct net_device *dev,
 	int ret;
 	struct mwifiex_private *priv =3D mwifiex_netdev_get_priv(dev);
=20
+	if (priv->adapter->host_mlme &&
+	    (GET_BSS_ROLE(priv) =3D=3D MWIFIEX_BSS_ROLE_UAP))
+		return 0;
+
 	/* we support change_station handler only for TDLS peers*/
 	if (!(params->sta_flags_set & BIT(NL80211_STA_FLAG_TDLS_PEER)))
 		return -EOPNOTSUPP;
@@ -4727,14 +4790,18 @@ int mwifiex_register_cfg80211(struct mwifiex_adapte=
r *adapter)
=20
 	ether_addr_copy(wiphy->perm_addr, adapter->perm_addr);
 	wiphy->signal_type =3D CFG80211_SIGNAL_TYPE_MBM;
-	wiphy->flags |=3D WIPHY_FLAG_HAVE_AP_SME |
-			WIPHY_FLAG_AP_PROBE_RESP_OFFLOAD |
+	wiphy->flags |=3D WIPHY_FLAG_AP_PROBE_RESP_OFFLOAD |
 			WIPHY_FLAG_AP_UAPSD |
 			WIPHY_FLAG_HAS_REMAIN_ON_CHANNEL |
 			WIPHY_FLAG_HAS_CHANNEL_SWITCH |
 			WIPHY_FLAG_NETNS_OK |
 			WIPHY_FLAG_PS_ON_BY_DEFAULT;
=20
+	if (adapter->host_mlme)
+		wiphy->flags |=3D WIPHY_FLAG_REPORTS_OBSS;
+	else
+		wiphy->flags |=3D WIPHY_FLAG_HAVE_AP_SME;
+
 	if (ISSUPP_TDLS_ENABLED(adapter->fw_cap_info))
 		wiphy->flags |=3D WIPHY_FLAG_SUPPORTS_TDLS |
 				WIPHY_FLAG_TDLS_EXTERNAL_SETUP;
diff --git a/drivers/net/wireless/marvell/mwifiex/cmdevt.c b/drivers/net/wi=
reless/marvell/mwifiex/cmdevt.c
index 16777af50097..c8d94cc6706f 100644
--- a/drivers/net/wireless/marvell/mwifiex/cmdevt.c
+++ b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
@@ -635,6 +635,8 @@ int mwifiex_send_cmd(struct mwifiex_private *priv, u16 =
cmd_no,
 		case HostCmd_CMD_UAP_STA_DEAUTH:
 		case HOST_CMD_APCMD_SYS_RESET:
 		case HOST_CMD_APCMD_STA_LIST:
+		case HostCmd_CMD_CHAN_REPORT_REQUEST:
+		case HostCmd_CMD_ADD_NEW_STATION:
 			ret =3D mwifiex_uap_prepare_cmd(priv, cmd_no, cmd_action,
 						      cmd_oid, data_buf,
 						      cmd_ptr);
diff --git a/drivers/net/wireless/marvell/mwifiex/fw.h b/drivers/net/wirele=
ss/marvell/mwifiex/fw.h
index 8b22cd993a79..7080f8701952 100644
--- a/drivers/net/wireless/marvell/mwifiex/fw.h
+++ b/drivers/net/wireless/marvell/mwifiex/fw.h
@@ -210,9 +210,9 @@ enum MWIFIEX_802_11_PRIVACY_FILTER {
 #define TLV_TYPE_CHAN_ATTR_CFG      (PROPRIETARY_TLV_BASE_ID + 237)
 #define TLV_TYPE_MAX_CONN           (PROPRIETARY_TLV_BASE_ID + 279)
 #define TLV_TYPE_HOST_MLME          (PROPRIETARY_TLV_BASE_ID + 307)
+#define TLV_TYPE_UAP_STA_FLAGS      (PROPRIETARY_TLV_BASE_ID + 313)
 #define TLV_TYPE_SAE_PWE_MODE       (PROPRIETARY_TLV_BASE_ID + 339)
=20
-
 #define MWIFIEX_TX_DATA_BUF_SIZE_2K        2048
=20
 #define SSN_MASK         0xfff0
@@ -407,6 +407,7 @@ enum MWIFIEX_802_11_PRIVACY_FILTER {
 #define HostCmd_CMD_STA_CONFIGURE		      0x023f
 #define HostCmd_CMD_CHAN_REGION_CFG		      0x0242
 #define HostCmd_CMD_PACKET_AGGR_CTRL		      0x0251
+#define HostCmd_CMD_ADD_NEW_STATION		      0x025f
=20
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
=20
+#define HostCmd_ACT_REMOVE_STA          0x0
+#define HostCmd_ACT_ADD_STA             0x1
+
 #define RF_ANTENNA_AUTO                 0xFFFF
=20
 #define HostCmd_SET_SEQ_NO_BSS_INFO(seq, num, type) \
@@ -2312,6 +2317,20 @@ struct host_cmd_ds_sta_configure {
 	u8 tlv_buffer[];
 } __packed;
=20
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
=20
diff --git a/drivers/net/wireless/marvell/mwifiex/ioctl.h b/drivers/net/wir=
eless/marvell/mwifiex/ioctl.h
index 091e7ca79376..80ba79ca74c5 100644
--- a/drivers/net/wireless/marvell/mwifiex/ioctl.h
+++ b/drivers/net/wireless/marvell/mwifiex/ioctl.h
@@ -157,6 +157,11 @@ struct mwifiex_bss_info {
 	u8 bssid[ETH_ALEN];
 };
=20
+struct mwifiex_sta_info {
+	u8 peer_mac[ETH_ALEN];
+	struct station_parameters *params;
+};
+
 #define MAX_NUM_TID     8
=20
 #define MAX_RX_WINSIZE  64
diff --git a/drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c b/drivers/n=
et/wireless/marvell/mwifiex/sta_cmdresp.c
index 7b69d27e0c0e..9c53825f222d 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c
@@ -1398,6 +1398,8 @@ int mwifiex_process_sta_cmdresp(struct mwifiex_privat=
e *priv, u16 cmdresp_no,
 		break;
 	case HostCmd_CMD_UAP_STA_DEAUTH:
 		break;
+	case HostCmd_CMD_ADD_NEW_STATION:
+		break;
 	case HOST_CMD_APCMD_SYS_RESET:
 		break;
 	case HostCmd_CMD_MEF_CFG:
diff --git a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c b/drivers/net/w=
ireless/marvell/mwifiex/uap_cmd.c
index eb0b8016d43d..91a8a581e3f5 100644
--- a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
+++ b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
@@ -72,6 +72,10 @@ int mwifiex_set_secure_params(struct mwifiex_private *pr=
iv,
 				bss_config->key_mgmt =3D KEY_MGMT_PSK;
 			}
 			break;
+		case WLAN_AKM_SUITE_SAE:
+			bss_config->protocol =3D PROTOCOL_WPA2;
+			bss_config->key_mgmt =3D KEY_MGMT_SAE;
+			break;
 		default:
 			break;
 		}
@@ -783,6 +787,145 @@ static int mwifiex_cmd_uap_sta_deauth(struct mwifiex_=
private *priv,
 	return 0;
 }
=20
+/* This function prepares AP specific add station command.
+ */
+static int mwifiex_cmd_uap_add_station(struct mwifiex_private *priv,
+				       struct host_cmd_ds_command *cmd,
+				       u16 cmd_action, void *data_buf)
+{
+	struct host_cmd_ds_add_station *new_sta =3D &cmd->params.sta_info;
+	struct mwifiex_sta_info *add_sta =3D (struct mwifiex_sta_info *)data_buf;
+	struct station_parameters *params =3D add_sta->params;
+	struct mwifiex_sta_node *sta_ptr;
+	u8 *pos;
+	u8 qos_capa;
+	u16 header_len =3D sizeof(struct mwifiex_ie_types_header);
+	u16 tlv_len;
+	struct mwifiex_ie_types_header *tlv;
+	struct mwifiex_ie_types_sta_flag *sta_flag;
+	int i;
+
+	cmd->command =3D cpu_to_le16(HostCmd_CMD_ADD_NEW_STATION);
+	new_sta->action =3D cpu_to_le16(cmd_action);
+	cmd->size =3D sizeof(struct host_cmd_ds_add_station) + S_DS_GEN;
+
+	if (cmd_action =3D=3D HostCmd_ACT_ADD_STA)
+		sta_ptr =3D mwifiex_add_sta_entry(priv, add_sta->peer_mac);
+	else
+		sta_ptr =3D mwifiex_get_sta_entry(priv, add_sta->peer_mac);
+
+	if (!sta_ptr)
+		return -1;
+
+	memcpy(new_sta->peer_mac, add_sta->peer_mac, ETH_ALEN);
+
+	if (cmd_action =3D=3D HostCmd_ACT_REMOVE_STA)
+		goto done;
+
+	new_sta->aid =3D cpu_to_le16(params->aid);
+	new_sta->listen_interval =3D cpu_to_le32(params->listen_interval);
+	new_sta->cap_info =3D cpu_to_le16(params->capability);
+
+	pos =3D new_sta->tlv;
+
+	if (params->sta_flags_set & NL80211_STA_FLAG_WME)
+		sta_ptr->is_wmm_enabled =3D 1;
+	sta_flag =3D (struct mwifiex_ie_types_sta_flag *)pos;
+	sta_flag->header.type =3D cpu_to_le16(TLV_TYPE_UAP_STA_FLAGS);
+	sta_flag->header.len =3D cpu_to_le16(sizeof(__le32));
+	sta_flag->sta_flags =3D cpu_to_le32(params->sta_flags_set);
+	pos +=3D sizeof(struct mwifiex_ie_types_sta_flag);
+	cmd->size +=3D sizeof(struct mwifiex_ie_types_sta_flag);
+
+	if (params->ext_capab_len) {
+		tlv =3D (struct mwifiex_ie_types_header *)pos;
+		tlv->type =3D cpu_to_le16(WLAN_EID_EXT_CAPABILITY);
+		tlv_len =3D params->ext_capab_len;
+		tlv->len =3D cpu_to_le16(tlv_len);
+		memcpy(tlv + header_len, params->ext_capab, tlv_len);
+		pos +=3D (header_len + tlv_len);
+		cmd->size +=3D (header_len + tlv_len);
+	}
+
+	if (params->link_sta_params.supported_rates_len) {
+		tlv =3D (struct mwifiex_ie_types_header *)pos;
+		tlv->type =3D cpu_to_le16(WLAN_EID_SUPP_RATES);
+		tlv_len =3D params->link_sta_params.supported_rates_len;
+		tlv->len =3D cpu_to_le16(tlv_len);
+		memcpy(tlv + header_len,
+		       params->link_sta_params.supported_rates, tlv_len);
+		pos +=3D (header_len + tlv_len);
+		cmd->size +=3D (header_len + tlv_len);
+	}
+
+	if (params->uapsd_queues || params->max_sp) {
+		tlv =3D (struct mwifiex_ie_types_header *)pos;
+		tlv->type =3D cpu_to_le16(WLAN_EID_QOS_CAPA);
+		tlv_len =3D sizeof(qos_capa);
+		tlv->len =3D cpu_to_le16(tlv_len);
+		qos_capa =3D params->uapsd_queues | (params->max_sp << 5);
+		memcpy(tlv + header_len, &qos_capa, tlv_len);
+		pos +=3D (header_len + tlv_len);
+		cmd->size +=3D (header_len + tlv_len);
+		sta_ptr->is_wmm_enabled =3D 1;
+	}
+
+	if (params->link_sta_params.ht_capa) {
+		tlv =3D (struct mwifiex_ie_types_header *)pos;
+		tlv->type =3D cpu_to_le16(WLAN_EID_HT_CAPABILITY);
+		tlv_len =3D sizeof(struct ieee80211_ht_cap);
+		tlv->len =3D cpu_to_le16(tlv_len);
+		memcpy(tlv + header_len, params->link_sta_params.ht_capa,
+		       tlv_len);
+		pos +=3D (header_len + tlv_len);
+		cmd->size +=3D (header_len + tlv_len);
+		sta_ptr->is_11n_enabled =3D 1;
+		sta_ptr->max_amsdu =3D
+			le16_to_cpu(params->link_sta_params.ht_capa->cap_info) &
+			IEEE80211_HT_CAP_MAX_AMSDU ?
+			MWIFIEX_TX_DATA_BUF_SIZE_8K :
+			MWIFIEX_TX_DATA_BUF_SIZE_4K;
+	}
+
+	if (params->link_sta_params.vht_capa) {
+		tlv =3D (struct mwifiex_ie_types_header *)pos;
+		tlv->type =3D cpu_to_le16(WLAN_EID_VHT_CAPABILITY);
+		tlv_len =3D sizeof(struct ieee80211_vht_cap);
+		tlv->len =3D cpu_to_le16(tlv_len);
+		memcpy(tlv + header_len, params->link_sta_params.vht_capa,
+		       tlv_len);
+		pos +=3D (header_len + tlv_len);
+		cmd->size +=3D (header_len + tlv_len);
+		sta_ptr->is_11ac_enabled =3D 1;
+	}
+
+	if (params->link_sta_params.opmode_notif_used) {
+		tlv =3D (struct mwifiex_ie_types_header *)pos;
+		tlv->type =3D cpu_to_le16(WLAN_EID_OPMODE_NOTIF);
+		tlv_len =3D sizeof(u8);
+		tlv->len =3D cpu_to_le16(tlv_len);
+		memcpy(tlv + header_len, params->link_sta_params.opmode_notif,
+		       tlv_len);
+		pos +=3D (header_len + tlv_len);
+		cmd->size +=3D (header_len + tlv_len);
+	}
+
+	for (i =3D 0; i < MAX_NUM_TID; i++) {
+		if (sta_ptr->is_11n_enabled)
+			sta_ptr->ampdu_sta[i] =3D
+				      priv->aggr_prio_tbl[i].ampdu_user;
+		else
+			sta_ptr->ampdu_sta[i] =3D BA_STREAM_NOT_ALLOWED;
+	}
+
+	memset(sta_ptr->rx_seq, 0xff, sizeof(sta_ptr->rx_seq));
+
+done:
+	cmd->size =3D cpu_to_le16(cmd->size);
+
+	return 0;
+}
+
 /* This function prepares the AP specific commands before sending them
  * to the firmware.
  * This is a generic function which calls specific command preparation
@@ -818,6 +961,11 @@ int mwifiex_uap_prepare_cmd(struct mwifiex_private *pr=
iv, u16 cmd_no,
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
diff --git a/drivers/net/wireless/marvell/mwifiex/util.c b/drivers/net/wire=
less/marvell/mwifiex/util.c
index ff1b2f162c30..9e36bb4a8d67 100644
--- a/drivers/net/wireless/marvell/mwifiex/util.c
+++ b/drivers/net/wireless/marvell/mwifiex/util.c
@@ -497,6 +497,30 @@ mwifiex_process_mgmt_packet(struct mwifiex_private *pr=
iv,
 		cfg80211_rx_mlme_mgmt(priv->netdev, skb->data, pkt_len);
 	}
=20
+	if (priv->adapter->host_mlme &&
+	    (GET_BSS_ROLE(priv) =3D=3D MWIFIEX_BSS_ROLE_UAP)) {
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
--=20
2.25.1


--_000_PA4PR04MB963810163D84020486AC720DD1DBAPA4PR04MB9638eurp_
Content-Disposition: attachment; filename="winmail.dat"
Content-Transfer-Encoding: base64
Content-Type: application/ms-tnef; name="winmail.dat"

eJ8+Iu5iAQaQCAAEAAAAAAABAAEAAQeQBgAIAAAA5AQAAAAAAADoAAEJgAEAIQAAADkxMDBCMDg5
MjFGQjcwNDc5MzExMTA2OEJGOUQ3M0IzAOsGAQ2ABAACAAAAAgACAAEFgAMADgAAAOcHCgAUAAMA
MAAZAAUAXQEBIIADAA4AAADnBwoAFAADADAAGQAFAF0BAQiABwAYAAAASVBNLk1pY3Jvc29mdCBN
YWlsLk5vdGUAMQgBBIABAD8AAABbUEFUQ0ggdjYgNS82XSB3aWZpOiBtd2lmaWV4OiBzdXBwb3J0
ZWQgaG9zdCBtbG1lIGZvciBBUCBtb2RlLgDEFAELgAEAIQAAADkxMDBCMDg5MjFGQjcwNDc5MzEx
MTA2OEJGOUQ3M0IzAOsGAQOQBgC4SgAAWgAAAAIBfwABAAAAUQAAADxQQTRQUjA0TUI5NjM4MTAx
NjNEODQwMjA0ODZBQzcyMEREMURCQUBQQTRQUjA0TUI5NjM4LmV1cnByZDA0LnByb2Qub3V0bG9v
ay5jb20+AAAAAAsAHw4AAAAAAgEJEAEAAABwHAAAbBwAAPlXAABMWkZ13SeimWEACmZiaWQEAABj
Y8BwZzEyNTIA/gND8HRleHQB9wKkA+MCAARjaArAc2V0MCDvB20CgwBQEU0yCoAGtAKAln0KgAjI
OwliMTkOwL8JwxZyCjIWcQKAFWIqCbBzCfAEkGF0BbIOUANgc6JvAYAgRXgRwW4YMF0GUnYEkBe2
AhByAMB0fQhQbhoxECAFwAWgG2RkmiADUiAQIheyXHYIkOR3awuAZDUdUwTwB0ANF3AwCnEX8mJr
bWsGcwGQACAgQk1fQuBFR0lOfQr8AfEL8PAyIEFkAQAcYAWgAQCBHMBvIHN1cHAJEcwgaBkQBUBt
bAeAHHD5BbFBUCNAIhIAcBxgHnCBBUBXUEEzIHcFsNBrLlxsC4BlCoEllEhTaWcYUGQtGTBmgC1i
eTogRGEdYAUcYEwLgCA8eXUtCRHQby4lkUBueHDSLgWgbT4lhS0poCWFlCAuKlAvGFB0LwPwNwlw
HnAEEC8AwBohbGwLK1AD8GYIkHgvY2ZAZzgwMjExKOAghS0AfC0AODEgKy2WfSnHZAUQGjErQCqf
K6ttWQEAdnQs4S0xICGAK4cuPy9PK7lmdy5oLQEfLRMhcS4PMu8rjGlvY+x0bDTyMZI1MegqUjc/
2yvmH2FfMQEJcHMo0TUlxzHKKl8wDnVhcDxCPMb4MTQ4LYgtlzX/Pm8/emZ0AxAs5jI0LYI9ljdP
HHADEAeRGZRkLDHAN3w2IAuAEgAAIDjAAIAofCspR9BBMAEAJKFIky0uKSWMDeABICApoGdpuQVA
YS9C/0QPLDxiS68/TL8sLCWFHbEQME6gOTlxAQA5ZjQeUEEQPhAyADk2OGRiNjQz7wGgRhAekVPQ
NCk4S49Pv39QzyWULZFOr1ZfV28llECmQEsgRgA2LEgQK1zSPjJIEFyRWwU8QCx1X20qZxAQXwzQ
KB9gcnWHOOAlIAUgaHkgKl/jd0fQX3daFF8xIWAxMSEs1z2WDIQBoCAJcHQIcAOg/jAWIGJ5AzAg
QGJ2WHVjI0EGkCAoR0VUH+BTAFNfUk9MRShwIVlBKSA9PQXQV0mQRklFWGa3X1Uj4P1nkFwAAGWJ
ZfcIkAngXpRJBABfYUVAaChe8i16PgNQYQeAPEACIQNgbL4pSfZp12MjXeZTsGdnQ3lsEGFkQDAb
oUfQBeBH72JWbZtjIzUSImuCJzASAAckcWuCIkIlcE1cXNxuIkfQa9RvoClj9mnf/2roAQBrj2yf
ba9uv2/PcN9/ce92xHM/dE91X3ZlBABh/wQQONB3L3g/eU96X3tvfH//ciGCgn3mglV+v3/PgN9r
Jf2Cgl88goLPg9+E74X/hw//iB+JLIo0PIKKipNffNqLX/+Mb2roCXCOH48vl3+RT5Jf/54flH9y
hZvllk+hT5hvmX/nZMhCZ2MjcGtfIB5wA6CPZ8CqUljwZpBIX0FnIPJOY/xza2NQZ8AxIWtwV1rQ
nDGscShn5k0gIF8AREFUQV9IRUHwREVSX6thMeimL623hEdNZqBGUkFNaNBhrsVTSVpFMedckznE
MyxG4CszMbPgQTD/Xb9ewSKQoIAQIF7knRQJcP9LUF9xGIBIk19/YIFk/WR052ZCAMCscCAhZ8Cg
FLZJ/7qiaSli2LsvuqNnwLqiY/b/KcCaWqAUIwJe4CNhtuKd/+PAn8GlICYmwi81EmaPf2eQuvFn
72jyr4+9j76XfJHHYEhPU8ZATUyyEeGxk01BU0tj+58LcqJXPEJnQ0fQSCMRQzEQX+hDTUSxilIg
AGJffMi5z3ZBQ8ZAxiCuUFPGMM1H0DDRFlySNTPUEF0R4DU1MSw5tI9eshIBNWGxZnbgbMFxXwJr
ZX55t8+432RWX+Ofw2BVIu8SAUkx11OnIyDYAUfQ2AHzSCFSUT0lCzCLA9gBa0D/UkKZp2VvoAzB
KcIfY2+pPGUHgG0SASgmCfAFAHmPBTDX8tPyInBpemUZMH/YNp9XYaDluZ3gY/zluS4j3nKqVFdM
Qa5QS0XuWa8iz+DP8FDpH+orUjTPx2Ded2P2XJIxN1zhHpD7LYDwEDfUEEEQ1ape8x9gI+XwB5Bb
TlUf0E5MA16Ux6BUWVBFU10PqoG8n300LQBCSVQon8fA9eBelMvQ84FfUGcAAx/w0NFRID4+IDS/
SPBkDffM8oDy66tAUPPLfcAILgzQqoH1n/py01BJfk+vUPdzLSD7L/U/9k9T9yPw93v7mXL8X/1v
/n//j88An/cfmhr8NDB4SwBLAM8JrwN/BIlm0E9DCQgF5//FTAdfCGPQ4A5PD18QbwgvzxKvE78U
z65gSVMSIxZ/8xePGJ9BVasgGi8bPxxP/67wHV8ebx9/BO73z/jf+eooUDJQz+BMx8BOVJ/zz/vf
I28FT1x0MznwIMvwUDWhNFRQMixT4NWv8V6ydGRsjfBTEOhQWiDvPEBHca1gWfB0R2DYP9lLv2Sd
ZO88EUVQPNDuQHRYZv8uf0AioHDOsDTTSKDnHsbyn7YBYDDPFJ1xtzAgdUEw+ipagGMLj3zIMQU3
hTjgv1qQnTGgsUdAOXA9YnPiON9pW2C2zgciMN6hZoqgN0U/p8w1QeNC495l5OUxY3D72CA3RS7y
UFlwvCE6oL8x/0XxqxanvUUHPiMK8T4UQz8/4wa/Es4fzy+u4NAQTkX+VxVxroAr0Tq/ImnSu01C
Q03B5mModm9po8Aq/CkmN0VGUDER4iBJX2X3viFjcWkvP7k81kEjKuaw50EyCwDykExMUv9VmFeF
/Gt6rRMw8ObEV2QlAMYQ1kYoEOugUk2ATFLvmjzfW1RU7yJF1mcGMHc3cqAF/wYwL4Cs4EYFV3Nb
v18v3PD/nRCNYF5VY6+omqhvShvjgv9DC6i/NN8ubzc/MU48VmGx/XaxdjUQOVFh4tEvInc57P88
Xz1vyMgo6z/uOPtK6WG07F9n1wHG8iis0d8P4B+34S/ErU+DKMYvvHA9x2//yHTiP+NGbL83Dkwk
RdM+FT/j31QITBA+I5zwQOJmbOxhZ43w2/ImKlPy1k3Bg7HQ62BHX1RETMggH/OQrwCCIMjP40Yt
RU+AUE5PVFNVUOxZtbMoNPMQN9USj7A38EP/Lk/zITBCekBt/28PcB9xLP9CvncPeB95L3o/e098
X31vf35/f4+An4Gvgr/jzyaULxYqMWA5UHO10HBvcrvcEJH8IDBRL5DhYCC3kH5sMbBBQKfAi4Kq
AEWRc/wqL4ePiJ+Jr4q/i8+M3zuN749zN5BA8OItsDc5//DRtHNCwpDmtvRFodZm5x6fnXUxwJ11
rejsi3RoRaF7bcGzUW9E0TFzneBFgHL+bbejRlCdd7jH6Q24VeawPGduWnAvcPJBCvFDRuJHFSVJ
R05GsK0gFaL4TUJNv4u7dqsjy3KhUIxQSOvArONIQVb6gn9Q8MwgBe9PNMA5wTEBaF/0T0as4E9N
QCGMvy/DD+/EH3FPws+iQlPI78n/wNHhoEFFTUFJ64Ar4OwQ/cDgTlxBy5/Mr82yzpXTsD2hUFTO
kM8P0B9cQFROeaBAT0vST9Nfy2DOUkLL68AgwEYg4ExUm3+chx+df+Ivxd/AKhIAUE9S/44gyHCg
IUcMMBBLkNrf2+//wE/BUqQ/nIcZsI4yrSRG0NRBQkbARNmYZmDwL9D/hPBbY63v4H/hiY4y3cOo
c2/U/9XPrQahkFRcIb2hUzef8I5A2AZkLpCqEC0tc7MAtFBhL7fQTEB1MS/dlKEvLoCy4Kegc+/w
OoDecu/AWoDw0C6EL0vhmnD0dC41IGLvj/Cf8aq2BUe2IJpgCuAxNjf2UGEsZjUt0C1ALvJAOGSQ
OTRjY/ZAMDaqEPOQgPegNDQGBu8Q72/zf3/0j+Mj/FDyb/n/+w8stjb8MzWP8gAysd9Ll5fPORvu
dfYwYDBM0W5iwOcvL9DfS5BMe6JRrJMgxDoFHwYklk9RAEz0UE0CU1nN0v/t8QgfCS8KM6yxKEBR
AAsG312IBi/Okt2FFjJVyEAN338O700vCw9Kb7TQNwKgsGX/dMGmwEvoBKUEkzqQN7IFD3/rX3KF
EwFRoUZQ2bBA8WL8dWYZLxo/G0i1ILqI7s/n/P/+DuZQLmj8jyHvIvhB9Ws4YjIyY/cwOTwzYbGA
9vD3kL0AZjjx95AxOTUtkPfvIO8kv38lzvxfKr8rz49FvSCxoDnPkBAwpI9xS6B1baE3vQFmX70x
x9BJVlCA4cFJ99fgraB2aSOaYIPwweCoYJxMVr3EEBNN4FRSzoA7vOBPhCjH0TLhn/BBUtvhwDTy
QtEwwRBJy4AtIHgyMzfnFzR/zhChoEP9ThBOT4Y2jzecsYA4nzT3eQmDTUzBcTrfO+8tIDP6MDiH
Kz3fBzas4qigP8+ZQN4xMz1PNPdTQcEQdFBXvgFPB7A/r0VvM14zPTjBt0bNoUZUoaBEoxQQrMBC
VUa9UVrBEIYy1NBJBTIwNDi2Dm9HNqAwzkDOEFNPB6QQeHkgUGYwjwpB0I/zU4E3/zFvMn8zjzSU
ErqsojpxoXA8R1XN8B5NUmCzsDNm81bPD29FRxQxNhJZX7Ow94+wWq8SyVBV8GMwoACtADZHNgE1
8ExdX7OwNTH/Qg4SvxPIYW9icVqXRr7H0bxUTzpwvbCOAO3hQ1kgfavwWVHoKHBnP2hGE/ND+l9I
kFBR2bOwjwqP1bHAP1QfVS9WP0zmYJDhwE1H/k2gAI4A0aA6uVoFKSZxr//W8VHIbI90n6AAB8Bs
WGmP72MYcjdIQXj/eFNwUrZHJ+5D4ZGtoK0gS+GQe/5z7/9+CUhQ0UFkMH7sWkFPx0zm/3BQDaAP
8X5Uq+HOEGxb/3rt9qAyj/L2oDQxSZDnp2H/weC8QOikcR9jp3BgoACf4t9N4H8v9rCDP4rOQq/A
0jC/jB71VtiHja+LUc3xT8EB/xPxf2uRD4rZE3KTO1Izeif9Rr5SToDOsO2AzsCswAfR/k9+/1Jg
xKDEoGa/Y03t8Z3t4VFosqAizjBGTwJwfGVxuVBu8blQvGKg8Fz/n4AwCUZwhxOgUbEQT5Cx4ve0
BdozBKJkq2EcUbgA5tBfvACvMAPQiaga83UA4HSUbHYccma1QFtd2AgYfSBfA2AYwGtlZP/YD7QN
iIC8U6KUqyKJmN7U/6fPqNW3cNmgtUGsRN5cpjDtLmAzKLCpRnPeWKYf41f/p7ah+rpRoqIY4qnO
rfIEcf8YxK0ftFMb8N5cpIG6AKyAa9pwGMBbnVBIx5DlgE7/pWetm5CQY9ACAOax2eEDoP5suK+0
UuaGtn+ksaVYr3/v4zqxT6KQovBt/gACEKOOD7vGwaSmuLPpc2l6ZbumtqAUOTDAoKJTcDluhL/A
b8F/C2rHX8hhiNFfLkD3IKAZAIiwZqmwy7HMEsPrs8nvokVwa9pg6MBnt7D5qwBybLdwzzrM383v
oo//orPMuBHI0f+yXKKyvHrj5PO+oRcRYW2u56X/kMkgP+8tr/4OGPCrAGwjf91P3l3j9Wv2wDFl
N+aAJ8A4cHY29vBvsGInseNR91A1/yjP3F/gX+FvLN/mb+d/L9t8MTVTk+zib/DHGYhGYv/qkNez
o48A4O7hG/C4D9ni/6a/qs3XhqnOt1+4b9WGsrX/2kHZMeoA6bED4dkrvpG/X+NM5zpBTlVNfqA4
EUkC20/P+7pSOlBNcE5OokkA/+Tg20/lv+pfIvTUAxdwAgDwc3AuY+lPAg8DHwQgQSZbN2I2OWQ9
EGUZhiAwZSfg5DA1Mzj7ZoEnQDLB8OS/AQ8FbwZ//4Y26R8L/w0PB0rso0swbnD/7SITEvBwhrG6
YYg3F6De4P8QQaKkA8SecKrcFOAPULLQb4Eg+YAPQRwQdcNCA8RfnG5vHL8PABAQYWvD7D+8MJ6A
Y6tDlkjgmZFIOv8Y/xoLqmQbP2R9HSbU+BoP1x9WPvIgQ1BYQ1mB0JLA/51BHS8ijx9PIFE/UE6A
XSHvJZYAXw9/Lr51vEHWUQQv5yt/LI/iO2Vi4/BvsMNAGGQ0My1gCTAxYTj4YTU44yBagOSfCw8u
n78vrw5/NK81vzA8hrI3hxO/O5EzIBPunoDSkJ6AY6NR/fjEcxYfFyslriYo7vGi9JQtPtqAefYg
Z22rEP49dSvQ39iVRA8mf9T4J+MkV0xcgUFL/JBTVb+FIJMRe9Ahf0F/FOF03uCub8/gQxBoN1dg
YDJHH39Kv0KPe5RNT0Z/0UmA0WH4dWx0JZ9R79FJRVc7U9Q4MzuzOO1xNDMAxyP/stEtgBQq1lIt
AtQC4sBT0Lx0aD5fP2+j9zjgdKNQDbMQMNl5kI4vKiBUwmi6ACBmdW60o/XQ9zjg2RE5ECB40QQA
PZDz0W8tgLJx+EbDZi6/ZvlwL//yyFj/WgayeVsvXD9RLtiT94xV1Z/IaCrWUWkPah4YBWeyYLSj
nrB2b7ZQ+XBk97LQ1CCk8Sm/Z6nv1c+yidoqn9B3oqJDASZzMUuh3dkjLteOqm/z+yqydUMB+2c+
eDgpcHZ2b/gf+StDAf+ydXVWe695vhjA4sD5cNQCvnCq0Ly/+YAf0IKfcR/Q+4iwvEBhg+3DQaxE
rgGzELNDEMUyb2ZnPqu9KYV/36SjhwF/v4gPrAkqpLGLX7+Mb6kLghOuooPsFCJpsD+PJ5R1MsiG
QxBjcHWr0PpvtDMoH88g2Im9dHVPQP+0lJU9b1iJvXUjxTKHP3LvVbLEKTvQICUgRCUgR//xUJMf
knQqEJqZQwBDEJYm/EFDQ6AgghyBcPjVGIJDN0MBZYaydV+6MI9QeSj/F6R+yPX1m0048D1Ao8+k
33xfZz1Spk+nX6AfoSYhf4Ilo79dxuzQrg/Yk/kQbf+VYKxgmMf15qzPtJL2dq3/j6EPoh9DoCVA
TU9WSVH7o5/YsWdL4VOQy/DFZ5Oc/5jIcDGVTNkUvfOX35jlXxB/lkCsINexfdEXQEwylWcz/jK/
J8Ftv++Y5YUx7xS+X/O/Y4UyYmlfEI1Qto+O5P+DsUMBmMeOO7c+vzaRZtMBoziQdQAgTkzj4DLt
kPUcc0ZIkEf/ICjwun+qdvNPQGBQX3djQKwRVQA5AH+VIrHJqkaRA3lfkC+RMSlvg7+RZk9AiVQu
jVKVPVTkTFb8oFlQSVAcRs8yvlObTddvhwSVapz1X8Lj/inbD9eGzXfCX80fOJCbTf3KMiuHT9Sv
kXWbT5xW5J//5a/mv8vfvydl0J4ByDKG8v+fQHGMRQOK4dPvjQ/WL+9Ia8sB2I8oSINF/MD1QFhD
JEFhoEFCSUxJMFl/5zzvZob17R+LH/M43Q8o/4rl9n+zF++yN8CGmBfg+E/vF+D8L1ZX5FUohpk3
wACPf0eo6DoCnwOvRTnr/8M5bqZrWnN1dnVwyjByfdD/loB9kH3QkKDuP+9P8F/xb68Mz/OP9J5J
EFAcYFIhIP8lUAPv948KLws/+V/6b/t//wPf/Z/+qBv/aqUWLxc/C/P/AG8BfwXfIr8EryR/JY8H
3xcI779UNqFzloBxdWVzLNBgYHx8/0dscIFhcH8Mjw2fDq8Pvy6/Ed/0y1H+T5+A9dIl/xVqnPWE
9jX//xnfGu8434T2+BksbMzYLeTgIDw8IDU7zxzv/rj+JoT2In8jjyfvQ+8mv0Wvf0a/0E/RX9Ju
Kj8rTyB/aP//9C5PL18wbzF/Uk8zn/TL/kj1v1Yfhv95smXArYDOlP9RZFnfOc86312vQY/+3lBv
///0Hn8fhmAvRN9JP2cfSA//aN9p70s/kKDOwH1QTK9t/+dL8i3if4FkdXTgcH5N43+V0pWSlWFP
31DtxhifQCZzcs9N8klFePDOlFkEXwhNQVijME1TRFUMID93n03yTVdJRmt44HoQVHoQRJeA2pBC
JFVG2mBJWrogOEucIDp6r3u/fMo0S01f905vT391fHZRb1J/U49Un+9Vr1a/V8/1YVZZD4mPWy//
XD2E1Y1vXp9fr5FPYc9i3/+D72TvZf+T/2gfbH+a/2tP95y/nc9ufzG4cG+vgR+CL0ODP1DXb3Bt
b4jAX+Zuu6CrQF91zhC/0IVvP4Z/h4+In5GPir/02k9QxbnwRLogTk9UfzChP/OOf95wdTixP5I/
k0+zv/+Vb5Z/p0+oWJj/mg+7v5wv/6CPnk+fX7/PpF+lb3dArNDkKGmqwTA7XHBAAH8AcXoBTlVN
2dD1YMbhK/4rqU/slm6/o4TPv6Ic/4DGcHKA1ZJbaV1yr3N42R+lcmm04eDwZ8Lw0AFtdHB0o6DN
wS7NNKkBcvHAryBlbOMwzh/Mb814zCBC2pDacFJFejCw0sF6IExMT1dFx+DEDy/FH7ez4zHJyHIu
AWVx8ULwMHhmu5CPKNp73vr52KVkb9jAfbvBua8MwcfL3T/nxHLaIHVywzDG0APhp9iOIC8qIFRo
80wwxjB1bqtA0NDDMNAA1mX/UT7BdKyAIDXAjyBV6qBjq5FjrxBvTHBh5G5kvvBiZcZBwkCpEOvo
EOHAZ+aybeSmrOCqgLZv5rOroHKrcOZxLumJ9+VT5XE9YGeO4KzA55Hlp5J35WBjaK8QYWzTQB/n
L+YlIjDl8eGlQEAgQC04MTgsNkIgOeg2MSxc8CDwgeHAq1j/PiHQoeZTdIDB0Kr+0AIiMfes4NAC
QvB1WEDBsqiRu6Y3yFDOrc7dZCIwUNBide5m3SD2L+K5LaQX9pfoQDni8GFr15wAEKkQIEhJrSB0
Q/XBQ001UEFiRDVQTkVX1mF/0En8T059v6Zjq3b1svKSrKD/PmB1oeXiPxD1I8HBAsNyQP/l07uv
92/4n3M8+o+8KPw7h/aTBeDoYGF1bHT/ZuP7mKt2ZGJnAnPNEQXwB6KgrMBC8EVSUk9Sc/YfH0ci
UNaQE+D+MTo39WB1cKigd8MwwcEgJcAjeFxcbiIDFKigj8CX6PDbgPCgLWdpq1CYYS9k0BGswHMv
4dDcdC+rgOLwWCBzFBByEJ5yE+DuEBTwq4QvdajA9Gwu56BiE68UvxXI4aUL4cCssHjGMGYxYjIB
GiA2MmMzMC4uADllMzZiYjRhEDhkNjdwQDAwNuw0NOGlEzAtE48XfxiPP6VxyCAWbx3fHu/wZDQ5
Pjfw8iPSGrDxkvQIb2NhIYFfbWdtkNA9UGMea9oj87/0yAtPY2Zn83kk2uFtbLfQJdMNBSDx46yw
9UFza2J2wAXyuUH+a5DQw7oKZOQHyFClvw0qfXbAaP3BKjNDAHeLvMMoZEdFjKBCUzWQDiBMdkUC
c8hAPcJwfxYyll/+VYzQ3SDIX6ZFXIhMMQrw3+bANoOscCBwdsBmuYHzMfPeYKsQb2wGfwv/DQ56
QP5HA98PLDdiEIDi8CWQIJEv7FA3ccYwJXBtEVBwTZ8RkzyPvEo3uAHBcjLAn/82P0xArLA3bzh/
OY86nzuv/0efPc8+1UVkP49K30GvQr/vQ89E2G9A/XBzJYBFz0bf/0fvSP9KD08fTCVT4kzJU7X/
Tc9ZP0/vUP9SDzbYU+IqAP/bIFQvVT9WT1dfWG9dr1qP/z8DXBNikVxfZ99ef1+PYJ//Ntf8QWJP
Y19r72V/Zo9r3/9or1sacOVqz3ZvbO9t/9fv1+SIKT8qkybQBHcrc9AE7yVx80ApkBZAaO8gFkCO
4H0NsV9yQNshDm+8g4zATHMywDKgSSja4c1QwfFu+w3RhbVu+QArr7kSg8+8gw4wbqccoeGlMi4y
NcwuMeGl4aV9faVwjIAfAEIAAQAAABQAAABEAGEAdgBpAGQAIABMAGkAbgAAAB8AZQABAAAAJgAA
AHkAdQAtAGgAYQBvAC4AbABpAG4AQABuAHgAcAAuAGMAbwBtAAAAAAAfAGQAAQAAAAoAAABTAE0A
VABQAAAAAAACAUEAAQAAAFwAAAAAAAAAgSsfpL6jEBmdbgDdAQ9UAgAAAIBEAGEAdgBpAGQAIABM
AGkAbgAAAFMATQBUAFAAAAB5AHUALQBoAGEAbwAuAGwAaQBuAEAAbgB4AHAALgBjAG8AbQAAAB8A
Al0BAAAAJgAAAHkAdQAtAGgAYQBvAC4AbABpAG4AQABuAHgAcAAuAGMAbwBtAAAAAAAfAOVfAQAA
AC4AAABzAGkAcAA6AHkAdQAtAGgAYQBvAC4AbABpAG4AQABuAHgAcAAuAGMAbwBtAAAAAAAfABoM
AQAAABQAAABEAGEAdgBpAGQAIABMAGkAbgAAAB8AHwwBAAAAJgAAAHkAdQAtAGgAYQBvAC4AbABp
AG4AQABuAHgAcAAuAGMAbwBtAAAAAAAfAB4MAQAAAAoAAABTAE0AVABQAAAAAAACARkMAQAAAFwA
AAAAAAAAgSsfpL6jEBmdbgDdAQ9UAgAAAIBEAGEAdgBpAGQAIABMAGkAbgAAAFMATQBUAFAAAAB5
AHUALQBoAGEAbwAuAGwAaQBuAEAAbgB4AHAALgBjAG8AbQAAAB8AAV0BAAAAJgAAAHkAdQAtAGgA
YQBvAC4AbABpAG4AQABuAHgAcAAuAGMAbwBtAAAAAAALAEA6AQAAAB8AGgABAAAAEgAAAEkAUABN
AC4ATgBvAHQAZQAAAAAAAwDxPwQEAAALAEA6AQAAAAMA/T/kBAAAAgELMAEAAAAQAAAAkQCwiSH7
cEeTERBov51zswMAFwABAAAAQAA5AIAKM0cIA9oBQAAIMPbgw0cIA9oBCwApAAAAAAAfANk/AQAA
AAACAABBAGQAZABlAGQAIABjAG8AZABlACAAdABvACAAcwB1AHAAcABvAHIAdAAgAGgAbwBzAHQA
IABtAGwAbQBlACAAZgBvAHIAIABBAFAAIABtAG8AZABlACAAYQBuAGQAIABsAGUAdAAgAFcAUABB
ADMAIAB3AG8AcgBrAC4ADQAKAA0ACgBTAGkAZwBuAGUAZAAtAG8AZgBmAC0AYgB5ADoAIABEAGEA
dgBpAGQAIABMAGkAbgAgADwAeQB1AC0AaABhAG8ALgBsAGkAbgBAAG4AeABwAC4AYwBvAG0APgAN
AAoALQAtAC0ADQAKACAALgAuAC4ALwBuAGUAdAAvAHcAaQByAGUAbABlAHMAcwAvAG0AYQByAHYA
ZQBsAGwALwBtAHcAaQBmAGkAZQB4AC8AYwBmAGcAOAAwADIAMQAxAC4AYwAgACAAIAB8ACAAIAA4
ADEAIAArACsAKwArACsAKwArACsAKwAtAA0ACgAgAGQAcgBpAHYAZQByAHMALwBuAGUAdAAvAHcA
aQByAGUAbABlAHMAcwAvAG0AYQByAHYAZQBsAGwALwBtAHcAaQBmAGkAZQB4AC8AYwBtAGQAZQB2
AHQALgBjACAAfAAgACAAIAAyACAAKwANAAoAIABkAHIAaQB2AGUAcgBzAC8AbgBlAHQALwB3AGkA
cgAAAAsAAIAIIAYAAAAAAMAAAAAAAABGAAAAABSFAAAAAAAAHwAAgIYDAgAAAAAAwAAAAAAAAEYB
AAAAHgAAAGEAYwBjAGUAcAB0AGwAYQBuAGcAdQBhAGcAZQAAAAAAAQAAABoAAAB6AGgALQBUAFcA
LAAgAGUAbgAtAFUAUwAAAAAAAwAAgAggBgAAAAAAwAAAAAAAAEYBAAAAMgAAAEUAeABjAGgAYQBu
AGcAZQBBAHAAcABsAGkAYwBhAHQAaQBvAG4ARgBsAGEAZwBzAAAAAAAgAAAASAAAgAggBgAAAAAA
wAAAAAAAAEYBAAAAIgAAAE4AZQB0AHcAbwByAGsATQBlAHMAcwBhAGcAZQBJAGQAAAAAAAFPDUDp
reVD2KgI29EfakwfAACAE4/yQfSDFEGlhO7bWmsL/wEAAAAWAAAAQwBsAGkAZQBuAHQASQBuAGYA
bwAAAAAAAQAAACoAAABDAGwAaQBlAG4AdAA9AE0AUwBFAHgAYwBoAGEAbgBnAGUAUgBQAEMAAAAA
AB8A+j8BAAAAFAAAAEQAYQB2AGkAZAAgAEwAaQBuAAAAHwA3AAEAAAB+AAAAWwBQAEEAVABDAEgA
IAB2ADYAIAA1AC8ANgBdACAAdwBpAGYAaQA6ACAAbQB3AGkAZgBpAGUAeAA6ACAAcwB1AHAAcABv
AHIAdABlAGQAIABoAG8AcwB0ACAAbQBsAG0AZQAgAGYAbwByACAAQQBQACAAbQBvAGQAZQAuAAAA
AAAfAD0AAQAAAAIAAAAAAAAAAwA2AAAAAAACAXEAAQAAABYAAAAB2gMIRmQ1rxrgi/9HBKcCzmzw
N4bsAAAfAHAAAQAAAH4AAABbAFAAQQBUAEMASAAgAHYANgAgADUALwA2AF0AIAB3AGkAZgBpADoA
IABtAHcAaQBmAGkAZQB4ADoAIABzAHUAcABwAG8AcgB0AGUAZAAgAGgAbwBzAHQAIABtAGwAbQBl
ACAAZgBvAHIAIABBAFAAIABtAG8AZABlAC4AAAAAAB8ANRABAAAAogAAADwAUABBADQAUABSADAA
NABNAEIAOQA2ADMAOAAxADAAMQA2ADMARAA4ADQAMAAyADAANAA4ADYAQQBDADcAMgAwAEQARAAx
AEQAQgBBAEAAUABBADQAUABSADAANABNAEIAOQA2ADMAOAAuAGUAdQByAHAAcgBkADAANAAuAHAA
cgBvAGQALgBvAHUAdABsAG8AbwBrAC4AYwBvAG0APgAAAAAAAwDeP59OAAADABMSAAAAAAIBAIAT
j/JB9IMUQaWE7ttaawv/AQAAAC4AAABIAGUAYQBkAGUAcgBCAG8AZAB5AEYAcgBhAGcAbQBlAG4A
dABMAGkAcwB0AAAAAAABAAAAIgAAAAEACgAAAAQAAAAAAAAAFAAAAAAAAAAAAAAA/////wAAAAAA
AAsAAIATj/JB9IMUQaWE7ttaawv/AQAAABwAAABIAGEAcwBRAHUAbwB0AGUAZABUAGUAeAB0AAAA
AAAAAAsAAIATj/JB9IMUQaWE7ttaawv/AQAAACgAAABJAHMAUQB1AG8AdABlAGQAVABlAHgAdABD
AGgAYQBuAGcAZQBkAAAAAAAAAEAABzBy3HtHCAPaAQIBCwABAAAAEAAAAJEAsIkh+3BHkxEQaL+d
c7MDACYAAAAAAAsABgwAAAAAAgEQMAEAAABGAAAAAAAAAMilJbGII5JKg6pkkAqkqyoHAE8+IND8
Jt1ErmEHWjoK3ScAAAAAAQsAAE8+IND8Jt1ErmEHWjoK3ScAAiEalRYAAAAAAgETMAEAAAAQAAAA
Na8a4Iv/RwSnAs5s8DeG7AIBFDABAAAADAAAAGIEAADbMOKnQQAAAAMAWzMBAAAAAwBaNgAAAAAD
AGg2DQAAAAsA+jYBAAAAHwD4PwEAAAAUAAAARABhAHYAaQBkACAATABpAG4AAAAfACJAAQAAAAYA
AABFAFgAAAAAAB8AI0ABAAAA/AAAAC8ATwA9AEUAWABDAEgAQQBOAEcARQBMAEEAQgBTAC8ATwBV
AD0ARQBYAEMASABBAE4ARwBFACAAQQBEAE0ASQBOAEkAUwBUAFIAQQBUAEkAVgBFACAARwBSAE8A
VQBQACAAKABGAFkARABJAEIATwBIAEYAMgAzAFMAUABEAEwAVAApAC8AQwBOAD0AUgBFAEMASQBQ
AEkARQBOAFQAUwAvAEMATgA9AEMAQgAwADQARgA2ADUAOQAxAEEARAA2ADQANAA2AEIAOABBAEEA
QgBDADkAQgA2ADUARABBAEUAOQAyADAANwAtAE4AWABGADUANwA2ADIANAAAAB8AJEABAAAABgAA
AEUAWAAAAAAAHwAlQAEAAAD8AAAALwBPAD0ARQBYAEMASABBAE4ARwBFAEwAQQBCAFMALwBPAFUA
PQBFAFgAQwBIAEEATgBHAEUAIABBAEQATQBJAE4ASQBTAFQAUgBBAFQASQBWAEUAIABHAFIATwBV
AFAAIAAoAEYAWQBEAEkAQgBPAEgARgAyADMAUwBQAEQATABUACkALwBDAE4APQBSAEUAQwBJAFAA
SQBFAE4AVABTAC8AQwBOAD0AQwBCADAANABGADYANQA5ADEAQQBEADYANAA0ADYAQgA4AEEAQQBC
AEMAOQBCADYANQBEAEEARQA5ADIAMAA3AC0ATgBYAEYANQA3ADYAMgA0AAAAHwAwQAEAAAAUAAAA
RABhAHYAaQBkACAATABpAG4AAAAfADFAAQAAABQAAABEAGEAdgBpAGQAIABMAGkAbgAAAB8AOEAB
AAAAFAAAAEQAYQB2AGkAZAAgAEwAaQBuAAAAHwA5QAEAAAAUAAAARABhAHYAaQBkACAATABpAG4A
AAADAFlAAAAAAAMAWkAAAAAAAwA3UAEAAAADAAlZAQAAAB8ACl0BAAAAJgAAAHkAdQAtAGgAYQBv
AC4AbABpAG4AQABuAHgAcAAuAGMAbwBtAAAAAAAfAAtdAQAAACYAAAB5AHUALQBoAGEAbwAuAGwA
aQBuAEAAbgB4AHAALgBjAG8AbQAAAAAAAgEVXQEAAAASAAAAAtOhbmgrvG9MqSzZnFwwFjUBAAAC
ARZdAQAAABIAAAAC06FuaCu8b0ypLNmcXDAWNQEAAAMAAIBQ42MLzJzQEbzbAIBfzM4EAQAAACQA
AABJAG4AZABlAHgAaQBuAGcARQByAHIAbwByAEMAbwBkAGUAAAAbAAAAHwAAgFDjYwvMnNARvNsA
gF/MzgQBAAAAKgAAAEkAbgBkAGUAeABpAG4AZwBFAHIAcgBvAHIATQBlAHMAcwBhAGcAZQAAAAAA
AQAAAHAAAABJAG4AZABlAHgAaQBuAGcAIABQAGUAbgBkAGkAbgBnACAAdwBoAGkAbABlACAAQgBp
AGcARgB1AG4AbgBlAGwAUABPAEkASQBzAFUAcABUAG8ARABhAHQAZQAgAGkAcwAgAGYAYQBsAHMA
ZQAuAAAACwAAgFDjYwvMnNARvNsAgF/MzgQBAAAAJgAAAEkAcwBQAGUAcgBtAGEAbgBlAG4AdABG
AGEAaQBsAHUAcgBlAAAAAAAAAAAAHwAAgB+k6zOoei5Cvnt54amOVLMBAAAAOAAAAEMAbwBuAHYA
ZQByAHMAYQB0AGkAbwBuAEkAbgBkAGUAeABUAHIAYQBjAGsAaQBuAGcARQB4AAAAAQAAAEQBAABJ
AEkAPQBbAEMASQBEAD0AZQAwADEAYQBhAGYAMwA1AC0AZgBmADgAYgAtADAANAA0ADcALQBhADcA
MAAyAC0AYwBlADYAYwBmADAAMwA3ADgANgBlAGMAOwBJAEQAWABIAEUAQQBEAD0ARABBADAAMwAw
ADgANAA2ADYANAA7AEkARABYAEMATwBVAE4AVAA9ADEAXQA7AFQARgBSAD0AVABoAHIAZQBhAGQA
RgBvAHIAawBpAG4AZwBJAHMARABpAHMAYQBiAGwAZQBkADsAVgBlAHIAcwBpAG8AbgA9AFYAZQBy
AHMAaQBvAG4AIAAxADUALgAyADAAIAAoAEIAdQBpAGwAZAAgADYAOQAzADMALgAwACkALAAgAFMA
dABhAGcAZQA9AEgANAA7AFUAUAA9ADEAMAA7AEQAUAA9ADEAAABAAACACCAGAAAAAADAAAAAAAAA
RgAAAAC/hQAAEFZnRggD2gELAACACCAGAAAAAADAAAAAAAAARgAAAACChQAAAAAAAAIBAIAIIAYA
AAAAAMAAAAAAAABGAQAAADYAAABJAG4AVAByAGEAbgBzAGkAdABNAGUAcwBzAGEAZwBlAEMAbwBy
AHIAZQBsAGEAdABvAHIAAAAAAAEAAAAQAAAASqsVsIwrdU2CYsN5uVg4HwMADTT9PwAAHwAAgIYD
AgAAAAAAwAAAAAAAAEYBAAAALgAAAGEAdQB0AGgAZQBuAHQAaQBjAGEAdABpAG8AbgAtAHIAZQBz
AHUAbAB0AHMAAAAAAAEAAACyAAAAZABrAGkAbQA9AG4AbwBuAGUAIAAoAG0AZQBzAHMAYQBnAGUA
IABuAG8AdAAgAHMAaQBnAG4AZQBkACkAIABoAGUAYQBkAGUAcgAuAGQAPQBuAG8AbgBlADsAZABt
AGEAcgBjAD0AbgBvAG4AZQAgAGEAYwB0AGkAbwBuAD0AbgBvAG4AZQAgAGgAZQBhAGQAZQByAC4A
ZgByAG8AbQA9AG4AeABwAC4AYwBvAG0AOwAAAAAAHwAAgIYDAgAAAAAAwAAAAAAAAEYBAAAAIAAA
AHgALQBtAHMALQBoAGEAcwAtAGEAdAB0AGEAYwBoAAAAAQAAAAIAAAAAAAAAHwAAgIYDAgAAAAAA
wAAAAAAAAEYBAAAALgAAAHgALQBtAHMALQBwAHUAYgBsAGkAYwB0AHIAYQBmAGYAaQBjAHQAeQBw
AGUAAAAAAAEAAAAMAAAARQBtAGEAaQBsAAAAHwAAgIYDAgAAAAAAwAAAAAAAAEYBAAAANgAAAHgA
LQBtAHMALQB0AHIAYQBmAGYAaQBjAHQAeQBwAGUAZABpAGEAZwBuAG8AcwB0AGkAYwAAAAAAAQAA
AEgAAABQAEEANABQAFIAMAA0AE0AQgA5ADYAMwA4ADoARQBFAF8AfABWAEkAMQBQAFIAMAA0AE0A
QgA3ADAANgA5ADoARQBFAF8AAAAfAACAhgMCAAAAAADAAAAAAAAARgEAAABQAAAAeAAtAG0AcwAt
AG8AZgBmAGkAYwBlADMANgA1AC0AZgBpAGwAdABlAHIAaQBuAGcALQBjAG8AcgByAGUAbABhAHQA
aQBvAG4ALQBpAGQAAAABAAAASgAAADQAMAAwAGQANABmADAAMQAtAGEAZABlADkALQA0ADMAZQA1
AC0AZAA4AGEAOAAtADAAOABkAGIAZAAxADEAZgA2AGEANABjAAAAAAAfAACAhgMCAAAAAADAAAAA
AAAARgEAAAA4AAAAeAAtAG0AcwAtAGUAeABjAGgAYQBuAGcAZQAtAHMAZQBuAGQAZQByAGEAZABj
AGgAZQBjAGsAAAABAAAABAAAADEAAAAfAACAhgMCAAAAAADAAAAAAAAARgEAAAA6AAAAeAAtAG0A
cwAtAGUAeABjAGgAYQBuAGcAZQAtAGEAbgB0AGkAcwBwAGEAbQAtAHIAZQBsAGEAeQAAAAAAAQAA
AAQAAAAwAAAAHwAAgIYDAgAAAAAAwAAAAAAAAEYBAAAAKgAAAHgALQBtAGkAYwByAG8AcwBvAGYA
dAAtAGEAbgB0AGkAcwBwAGEAbQAAAAAAAQAAAA4AAABCAEMATAA6ADAAOwAAAAAAHwAAgIYDAgAA
AAAAwAAAAAAAAEYBAAAARAAAAHgALQBtAGkAYwByAG8AcwBvAGYAdAAtAGEAbgB0AGkAcwBwAGEA
bQAtAG0AZQBzAHMAYQBnAGUALQBpAG4AZgBvAAAAAQAAAAIFAABzADkAUwBXAG8AQwB4ADUATABj
AE4AcQBYAEwATAB2AHIAQgBMAGcAbABYAHoAWQBFAGoAbgA3AFMAMwB0ADEAMgBJAGkANgBFAGwA
dwB2AFkANwBJAFkAdQBsAEkANgBYAEEAagBBAHUAVABsAFIAeABwAEoANwBPAFQARQBmAGMANwBU
AG0AQgArAGEARQBvAEwASgB3AHoAegBsAFcASABQAE8AMwBTADEAOQBmAGcASwA2AE8AaQBFAFMA
bwAwADUANwBZAFQAcABnAEcAeQBtAFoASAA0AGwAQwBPAFQAcQBYAGoAdgBoADAASAA5AFgAWABr
AC8ANABUAEoAdgBFAHoAdAAyAE0ASABkAHkATABTAEIAcwBnAG4ASgBRAHIAZwBUAGMASwA0ADUA
VgBaAFoASQBIAFEASQAwADAAZABJAFgAKwA5ADMAYgBqAFAAbQAzADgAWAB2AFAATABQAG0AOAB3
AE8AagBRAEsAeABaAGgAeQBiAFUAbQBuAEgAdABuAFoAWABFAFQAVgBjAEUANQByAFIAagBJAGsA
ZABTAE8ATABIAFUAVQBoAEQAZwBVAGQAeABMAHAATwBuAHgAdgBEAEUAMgBDADUAUQBIADEAVgAr
AEUASgBkAHIAMQBYAHcAVgBVAFEAUABlAHAAQgBtAEIAYwBPADMANQAvADQAVQBIAG8AUwBqAGgA
egBkAE8ATQBaAGUASgBiAGQATQB6AFUASwBvAC8AUwBKAGQAVgBkAGwAVgBwAGIAWQBiAE8ARwBP
AEIAOABSAHcAcQA2AGIASABBAGkAbwBJADYATABzAEEAeQBuAHAASQBSAFMASgB1AHAAagBEAHQA
dQBrAHIAQQBUAEoAaQAwAGgATQBlAE8AVgA1ACsAUwBIAE8ASQBEADEASQBoADEAVQBkADgASQAz
AEMAaQA2AFEATAA2AFQAagBGAEwAegBuAHAAMwBwAFkAQgBWAEsAbwBtADcAWgBVAHYAawBvAEsA
cgBGADQAQwB4AHMAUABXAFEAagBaAGEAcwBqAE8AdQB6AC8AaABYADgARQAxAGkAMwBhAHkANwBt
AEkAMABWAHUAQwBQAE4AeQBzAHAAbQBNAHMASQB0ADcAZgBKADUASABBAGcAcgBYADUAWgBMAFYA
MgBYADUARABEAGYASQBNAFoAZwBKAEEAcwBPAFEAOQBNAFoATABLADMAcgBQAE0AcABDAGIARQBK
AFAASABOADcAYQBSAGEAZwBMAEkAQgA4AGYAZwB3AHIAaABwAE4ALwBMAGEARABkAFQAMAB5AFYA
UwBTAG8AcABqAE4AbgA5AHIAZABNAE8AcgBlADcAYQBXAEYANQAyAGoAZQAwAGIATwB3AEkAaABI
AGkAZAB0AGEANABFAEEAdwBXAG4AbgBKAFkAYgBiADEANAAzAEQAbABFAG8AYgBhAGMAUgAwADMA
bAAwAEwAaABNAHoAdQBXAFAARQBrAFkAMwBnAE4ANQBuAHUAbwBoAGgAMwBXAEMAbwBUAHMAUgB0
AGEATgB2AGcAMQByAC8AaABUAEoAUABRAEIARgBZAEMANQBoAEwAeQBvAHYAQwBJAHMASAAzAE8A
VgB3AFkATABSAGsAQQBNADUAOAArADUAdQBkADAAQgByAEIAeQBaAFcAdQBQAEgAUwBRAHoAagBW
ADEATgBtAAAAAAAfAACAhgMCAAAAAADAAAAAAAAARgEAAAA4AAAAeAAtAGYAbwByAGUAZgByAG8A
bgB0AC0AYQBuAHQAaQBzAHAAYQBtAC0AcgBlAHAAbwByAHQAAAABAAAAmgQAAEMASQBQADoAMgA1
ADUALgAyADUANQAuADIANQA1AC4AMgA1ADUAOwBDAFQAUgBZADoAOwBMAEEATgBHADoAZQBuADsA
UwBDAEwAOgAxADsAUwBSAFYAOgA7AEkAUABWADoATgBMAEkAOwBTAEYAVgA6AE4AUwBQAE0AOwBI
ADoAUABBADQAUABSADAANABNAEIAOQA2ADMAOAAuAGUAdQByAHAAcgBkADAANAAuAHAAcgBvAGQA
LgBvAHUAdABsAG8AbwBrAC4AYwBvAG0AOwBQAFQAUgA6ADsAQwBBAFQAOgBOAE8ATgBFADsAUwBG
AFMAOgAoADEAMwAyADMAMAAwADMAMQApACgAMwA2ADYAMAAwADQAKQAoADMAOQA2ADAAMAAzACkA
KAAxADMANgAwADAAMwApACgAMwA3ADYAMAAwADIAKQAoADMAOQA4ADYAMAA0ADAAMAAwADAAMgAp
ACgAMwA0ADYAMAAwADIAKQAoADIAMwAwADkAMgAyADAANQAxADcAOQA5ADAAMAAzACkAKAAxADgA
NgAwADAAOQApACgAMQA4ADAAMAA3ADkAOQAwADAAOQApACgANgA0ADEAMAAwADcAOQA5ADAAMAAz
ACkAKAA0ADUAMQAxADkAOQAwADIANAApACgAMwAwADgANgA0ADAAMAAzACkAKAA1ADUAMAAxADYA
MAAwADMAKQAoADMAOAAxADAAMAA3ADAAMAAwADAAMgApACgANgA2ADgAOQA5ADAAMgA0ACkAKAA0
ADEAMwAwADAANwAwADAAMAAwADEAKQAoADQAMwAyADYAMAAwADgAKQAoADUANgA2ADAAMwAwADAA
MAAwADIAKQAoADgANgA3ADYAMAAwADIAKQAoADgAOQAzADYAMAAwADIAKQAoADUAMgA1ADMANgAw
ADEANAApACgAOAA2ADMANgAyADAAMAAxACkAKAAzADMANgA1ADYAMAAwADIAKQAoADIAOQAwADYA
MAAwADIAKQAoADEAMgAyADAAMAAwADAAMAAxACkAKAA0ADcAOAA2ADAAMAAwADAAMQApACgAOAAz
ADMAOAAwADQAMAAwADAAMAAxACkAKAA5ADYAOAA2ADAAMAAzACkAKAA3ADYAOQA2ADAAMAA1ACkA
KAAyADYAMAAwADUAKQAoADcAMQAyADAAMAA0ADAAMAAwADAAMQApACgANgA1ADAANgAwADAANwAp
ACgAMwAxADYAMAAwADIAKQAoADMAOAAwADcAMAA3ADAAMAAwADAAOQApACgANgA2ADkANAA2ADAA
MAA3ACkAKAA3ADYAMQAxADYAMAAwADYAKQAoADUANAA5ADAANgAwADAAMwApACgANgA2ADQANwA2
ADAAMAA3ACkAKAA2ADkAMQA2ADAAMAA5ACkAKAA2ADYANAA0ADYAMAAwADgAKQAoADYANAA3ADUA
NgAwADAAOAApACgANgA2ADUANQA2ADAAMAA4ACkAKAA1ADcAOQAwADAANAApADsARABJAFIAOgBP
AFUAVAA7AFMARgBQADoAMQAxADAAMQA7AAAAAAAfAACAhgMCAAAAAADAAAAAAAAARgEAAABcAAAA
eAAtAG0AcwAtAGUAeABjAGgAYQBuAGcAZQAtAGEAbgB0AGkAcwBwAGEAbQAtAG0AZQBzAHMAYQBn
AGUAZABhAHQAYQAtAGMAaAB1AG4AawBjAG8AdQBuAHQAAAABAAAABAAAADEAAAAfAACAhgMCAAAA
AADAAAAAAAAARgEAAABKAAAAeAAtAG0AcwAtAGUAeABjAGgAYQBuAGcAZQAtAGEAbgB0AGkAcwBw
AGEAbQAtAG0AZQBzAHMAYQBnAGUAZABhAHQAYQAtADAAAAAAAAEAAACCDAAANwBHAEcATABDAGIA
cABQADcAVQB6ADkANAAvAEEASQBxAHoAQwBPADUASwB0AGQAUgBwAEMAcwBkAGkASwBUAFQAZwBU
ADUARgBNADYAYQBLADMATABzADEAQQBoAGQANgBaAFgAWQBGAHUAaQB1AFcAdgBIAEwAMQBxAEwA
UAA0AHUALwBRAE4AVAB0ACsATgBZAFgAYgA4AFYAawBjAHoATQBEAGcASgBrAGEAZgBJADYAUABS
AFEAQgBXADgAVwBoAEwAaABLADAAWABQAHAAOQBmAFQAbABzAGkASQA4ADkAMwBrADUAWQBsAEMA
egBOAG0ANgBxAGoARAAyAE4AdABzAEYAeABtAFQARABZAE8AeQAwAHMASwByAFoAbABmAHQARwAz
AFoANgBYAEQAZQBYAG4AQgBQAHcALwB5AG8AUwBYAEUAZQBkAHAAYQBJAEgAZQBvADcAOQBtAEMA
cwArAGQARAA5AHgALwBLAFUAQQBVAGsAegBBAGsAMABuAEgANwBTAGUAaABKADAAMwBzAE0ATgA4
AHYAUQBOAGMASQB0AHUARAAzAHcAeQBMAEEAcAArAE4AQQBPAGYAagB4AG0AMwBZAGMAaABxAFIA
egA2AFkAVgA2ADgANABPADkAWQB2ADkAZwBMAEoARgBxAHgARwA2ADgATAAvAEwAcgB4AFcAcAB0
AE8ARQBSAHoASwBhAEUAcQBIAFgAegBsAEwASwBjAEEAZwBTAHoAegBNAFIAYwB6AGIAcgBIAGkA
SQBLADcASQBDAFkAagBiAFMAUABrAFYARwBKAE8AUABvAFIARAA4AFcAcgBWAHkAWgA3AC8AZQA5
AGkANAArADkAQgB2AFoAVABQAFgAVgBjADIAWQBHAE8AZgBTAGEAMgBJADAAMQBiAHkAMgBWAGMA
MABTAEMAZABUADYAQQArAHgAcgBQAEcANQB0AE4ATwBuAFAAVQBHAEcAawBhAHMAeAAxADgAWgBE
AEIAawBuADMASwB4AFUATgByADcAUwBVAFQATQB3AGIAKwBMAG0AMgBJAEcAWQBMAHAAWABIAFEA
eQAwADYAZQBMACsASgBZAHgAMQBnAHQANwBKAE4AMgBtAE0AZgA5AFEANQBRAFkATwBCAEMANABU
AHAAcQB2AHcATwBUAGoAcABrAHoAZwBiADMANABxAE0AcgBDAHMAdwBvADEAbAB1ADMAZwBFAHUA
UgB2AE0ANwBpAEsAawA0AE8AawB3AEUAZAB6AEYAawBZAFYAMQBIAEUAaQBRADAAegBPAG0AQQBO
AGoAbwBRAG4AcQBGACsAZwBUAGIAMwBFAFoAdAAzAGgAQwBFADcAYwB3ADgAbQBaAHYAKwAvAGQA
OQBYAC8AZwBNAHkAYwBlAEMAZgBoAFIAdQBuAFAAVABvAE8AYgBSAFcAUwBDAFYATwA0AG4AYwBx
AHoAVQA5ADcANAAvADkAZQBCAFMAWgBXAEEAdABlAEkALwBnADcANQBSAHYAaABhAEcAYQBxAG4A
VgByAHkAWQB5ADQAdwBMAHMAOABYADAAMQB0AHEARgBmAFIAQwBNAEkAQQBYAEkASwAxADgAeABl
AGkAWABuADgANwBMAG4AMABMAFgANwBSAFoAdABHAGEAUgBaAGwAQQBGAEQAMgBIAEkAdABiAHUA
LwByAE0AagBXAGoAMABtAEIATgBYAHkAagBMADcAYwBlAHAARwByAHYARwB2AFIAegB5AGkATABV
AE0AZQAzAFAAVABNAHAAOAAyAFAAYgB2AFUAYwAxADEAYwBtAHkAcABuAHQALwBzAFgAMgBSAG8A
dwBVACsAYQBYAGEAbQB3AGMASQA2AFUAbQBIAGwAaAA0AC8ASgA2AFEAegBEAG8ARQArAHoAWQBr
AHIAaABSAEoAbABGAGkAOQBKAHQASgBMAGYAcwBNAFUAVwBzAGQAZgBVAEUAcgBxAGcAOAAxAFkA
VABmAGMAdABtAFQAcgAvAFYATgBYAEUAMgBiAEEAQwBBAGoAcABLAHQAOQBHAE0AdwBCAGwAbQBl
ADgAbgA0AEYAUwA1ADQAQQAwAGMARgBHAEQANABTAHQAVwAzAG8AUQBGAGMAegBXADgAYgBDADUA
TQB3AE4AYwBvAFUAbgBVAEYAUgAwAEgANgBUAEUANQBFAEoAVwA2AHEAbwA1ADgAaABtAGoAWQBk
AG0ASABMAFgAZgBDAFEAYgB6ADMATwBTAFQAWABQAHoAZgBBAEwAMABTAHMAZgBFADEARgBoAE0A
dwBtAGEAagBZADYAcABGAHEAZABGAGgAVABrAHkANQBxAFkATQBWADIAagBZAEkAdAA4AFYAVQBK
AGcAZwBNADQAbQBSAFQAawA4AEYAVwB6AGwAaAArAFoAVwB0AEEANQBGAFYAUQArADIAZwBaAHMA
UgBEAHIAaABLADUALwBSADIATgBhADYAVAAxAGwANwBhADUARwBwAGYATwBEAGwAaQBaADMATABZ
AE4AVgBVAEkARABNAFUAZwBMAHcATABvADUAQgB4ADgAUABIAFkAVgBMAHoAVAB0ADcAYQBYAFgA
dQA3ADUAOABuAFAAMwBkADkAbwBkAHQAawBlAEQAUgB4AHoANgBpAHoASQBYADcAWQA1AEoAMwBH
AEkAMABYAG0ASQA3AFMATgAwAEwAMwB6AHoAawBSAHMAWQBwAFAAdABkAFIASwArAFMAaABoAFMA
agBDAFgAQgBqAFYAWQBBACsAQwBQACsATwBkAGgARQBuADUATgB3AEkAcwBLAHkAcgBIACsAdwBO
AFAAbwBOADAARAB5ADIAdgBIAEUAKwBKAGoAWAA5AFIATAByAEwAMAAvAHIASABPAFAAMQBRAGsA
eQBtAHcATgBHAG4ANAAxAGIAegBKAE0AegA4AFYAcwBoAE0AaQA3AGEAagA3AE4AbQBWAE4AYQBE
AHQAUwBOAGQAVwA3AEEANQBLADIATwBlAC8ATwBJADYARwBDAGoASgAvAHAAMgBlACsANQBmAEsA
YwA3AEYATQA3AFUATgBYAFcASwBrAEQAUQBNAHoAbQBYADcARAB1AEoAOQAyAFAASQA0AFkAagBz
AGsAZABpAEoAYQB4AHEAcgBaAFIAcwBTAGQAdwA3AGoAUwByADkAQQBtAGoAegBiADMAcwBCAFAA
bABvAEIARAB1AEYAUgBOAEcAdwBHAFMAZgBqAGsAcQB4AGEASABKAFoAaABIAFcAYwBZAEkARgBH
ADUASQB3AHoASQBiAGcAeQBlAEUAUgAwAGoARwBCAHIAZABvAGUALwB0AEgASwB0AGoAegBFAHcA
QwB6AG8AMQA5AEUAegBmAC8ARgArAHQATwAxAC8AQQBWAHAAUABqAFIAaQA3AGMAdwBJAGwAcwBT
AGYAbQBQAEkANwB2ADMAdQBVAFEAZgB1AEMAaAAxAEIAQgAzAHAAWgB5ADMAVwAvAC8AZgBXAEwA
OABiADEAegByAGgATQB6AGoAUgAwADUAdQBFAHYAQgA1AFYAeQBGAHUASQBQADgARgBSAG8AUQB3
AFUALwA3AHEANQBOAFUAUgB3AGsAbgBlAFcARwBwAGoANwBGAGgAdQBhAEIAUwBzAEoAVwBPAEQA
VgBCAE4AOQBIADMAbgBuAHUAWgB4AGcAaQBJAEsAVgB4AEIAVABvAGsASgBnAC8AUwBxAFgAawBZ
AEwAZQB3AFQAUAAyAEsAWQBGADQASgBVAFcAQwBNAC8AWgA4AE4AdABlAHQAagBwAHMAUAB0AFMA
cgA5AEcAWABMAEwAYgBEAEoAdwBpACsAegBZACsAQwBEADcAUwB4AG0ATwBPAFYARgBSAGEAegA5
AEgAQwBNAHAAbwBaAHAARQBEAHUAUABiAEUAWQB1AHcAcwB6AFkARAB6AHIAZABiADEAdABnAC8A
RABFAHIAZgBSAHIAYQBIAHUATQBZAE0AVABtAEMAdgBoADYAcgBDAGMANgA5ADEAUAA5AEkAaQBJ
AE0AcQBRAGEASwBmAFgAbQBMAEMAWABkAE8AVwBqAEoAWABUADgATgBIAHYAbABuAHEANQBoAEMA
KwArAHYATQBtAHAAYgBYAHcAUQBNAFkAZgBJAHkAUAB4AEYAdwByAGYANwAxAGUAZwBYAGEAaQBR
AGkASgBNAHMAdQBvADcAcgBpAHcAVABnAEUARAA3AFYAKwA0AG8AeABVAG8AcwBoAEUAVAAAAAAA
y3Y=

--_000_PA4PR04MB963810163D84020486AC720DD1DBAPA4PR04MB9638eurp_--

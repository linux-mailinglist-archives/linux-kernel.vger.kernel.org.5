Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFC477CB05
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 12:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235961AbjHOKMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 06:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236328AbjHOKMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 06:12:30 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2047.outbound.protection.outlook.com [40.107.6.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F69CE63;
        Tue, 15 Aug 2023 03:12:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZYkuvhHo4jrIJwm7RbGN+bVqWSKvmPygwssYJi3gIpiPcvB2JN11pSY/8wzyzwcmrdmFIghRz6ruBm9q5zWjLCZ7TLWyKD/YdCLNlaN+TCPl3FRe6A3H/xXHEKd5HNOM7w8v1xle2JxoslsY8eATwQ+PqUHPIP/+ccTbqAAnfGtMqy8vucMK7T07NHH6lL7Ors56Fwp+3WOlaG4cklgsJGcQs3oj8T96NQB0g6be3zgmXEZf4LbE2OFmJD7mNB/Nf7biRCCatYO6/OQz0NQg9z29hrqz0rCnHEF9P8jPxizWJoHC5eR1VFHIisygL1xuDDNro3kY52lf/S/K/TBCLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1JYnaNXS+R9dEQ6T4L5NwvBYJCABaC5Fp4EME7rdj6U=;
 b=Jj3bwKvo3z6AQIWQfg4NkVhBNsm3ES3AZYnTgWDdCb/0jM2tY2r3WCj78kCzboK5eGHIEhDsfshD9iWV7/2AQnsCC9Z0WQtHqeRv8jKHQyL6C8DYNyu7LgtYR/M0Ek/RfSFELTfQ9IFHRZzsuxLbJq8YQ8uFC4hGDdgq2mpnzEhS/1o69XaJTExQzlZkAbtTTD42C8f4Vo9i/axFy5JI4fi77rZ7WtBPgv0uTh4kRX06C/77B564SwZECFj6+/cPLZ7sU9VkzwSOuoIFLST0kHmGoaUnZWP7UcSnjkEjDMAYmDL80aaXXmPMTtZH89T8sCwpnIIWMAgWQ7TBoq2r1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1JYnaNXS+R9dEQ6T4L5NwvBYJCABaC5Fp4EME7rdj6U=;
 b=aQJEarWjxre1PzW5B0iTa8KPhHobMnKX+ZiCr86TfEn4MUIhz2uLO0NbzlLr684kzz3n2GoTKs7DnXFJHa3/vl0MAVpx1czh07zMNjrVpGc/Wkc1Y6oRs+yx+KcbNYT21cs9tgOcm4D3vy3v3aqgrLqtXQeHTJSp3391MOVnZz0=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by AM0PR04MB7156.eurprd04.prod.outlook.com (2603:10a6:208:19b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 10:12:23 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::693d:8782:eae1:2460]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::693d:8782:eae1:2460%4]) with mapi id 15.20.6678.022; Tue, 15 Aug 2023
 10:12:23 +0000
Content-Type: multipart/mixed;
        boundary="_000_PA4PR04MB963838F12BADC1B9FD377CB7D114APA4PR04MB9638eurp_"
From:   David Lin <yu-hao.lin@nxp.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        David Lin <yu-hao.lin@nxp.com>,
        Pete Hsieh <tsung-hsien.hsieh@nxp.com>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "amitkarwar@gmail.com" <amitkarwar@gmail.com>,
        "ganapathi017@gmail.com" <ganapathi017@gmail.com>,
        "huxinming820@gmail.com" <huxinming820@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernelorg" <kuba@kernelorg>,
        "pabeni@redhat.com" <pabeni@redhat.com>
Subject: [PATCH v4 1/1] wifi: mwifiex: added code to support host mlme.
Thread-Topic: [PATCH v4 1/1] wifi: mwifiex: added code to support host mlme.
Thread-Index: AdnPYPldbsu6r+COQYGwN88j9fWESg==
Date:   Tue, 15 Aug 2023 10:12:23 +0000
Message-ID: <PA4PR04MB963838F12BADC1B9FD377CB7D114A@PA4PR04MB9638.eurprd04.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: <PA4PR04MB963838F12BADC1B9FD377CB7D114A@PA4PR04MB9638.eurprd04.prod.outlook.com>
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|AM0PR04MB7156:EE_
x-ms-office365-filtering-correlation-id: d1508feb-ce37-4800-d54c-08db9d781e47
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZfU3m/vJQ8EmH56jHgj2RO7gOLj7KIh9cR8Ulsx/7Wp4GD091aT1f/F60BUfnVY76o8pRgsjGTJ6D/RcofKX9wxbXgc7ZaKAqu1buWdV0w5nbMpg+U3UWKcWO1GSvSsWAAT5zhwdc+/UoNUrWxJWl44ZBAEryEQmG5oRMpypEvYDpJ7+GAuUGDKfcyi3tdBU9E8Vgg9MZfA4bAq11CvCdk57wh1zYx6CXMcCiLDDlLtQFNljQOZRcyqHSGWJjtygnI3uPodYljnLBZbBdbb1bZlJ6IpiiYDZQVF3rtSFRiz26rTsUKDKMHb4eYB+kdDmQjNJ0/ZRTQicN7NUZB0Yn4FxOoKAgNCaS2H5YCHPOnfGhYqVjnsbo/rHA6HmMyztkFxqke3LrSUwZvFknCh4yX38XLGfJ6Vb/p6R08ffRKGM18tXy5CHLxDKumXLablDHQSdGcmg/YTgnsrYhiMQ5EasQDMNf2Ae6yUdKfy/OEbQPImHWWFGbuPUHuRqvzH7Crr5/I7XuyomRW4X4XlM69TzAUJcJrz1VxyryleBs1Vt2SFto1ysRCAwldHFVlpBYCCbVIh1TKib2Y7OVkgX9LV0oB+khWlnXSQQJ1mdKkc1UzRLTr+fGoDhwZ1OK8Fy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(396003)(376002)(39860400002)(136003)(186006)(1800799006)(451199021)(66899021)(7696005)(9686003)(71200400001)(33656002)(86362001)(38100700002)(122000001)(83380400001)(38070700005)(6506007)(26005)(52536014)(30864003)(2906002)(55016003)(54906003)(478600001)(41300700001)(66946007)(8936002)(66476007)(8676002)(66556008)(66446008)(5660300002)(64756008)(76116006)(6916009)(4326008)(316002)(559001)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OSKfW3Lfn34jQC7UoSIra9Oi/1AK3Woq1e1z0J5oL7B8xduARwkUyp1wt/RY?=
 =?us-ascii?Q?py72rxl5Els7XXn0/k8Gn4UHG1N68U80iM7DOd5/Fk31t+EkwjIRYGXjyoln?=
 =?us-ascii?Q?O4EHRuFkfXIgLNe5otONX1CY3AFlLe5lK9jP7GPpvZPF6o+LqSBSnDIe93Tl?=
 =?us-ascii?Q?r/i7NQwhCilKQAShHRLZWZBEh83ovowX4Lii3rXRsFsBmHdbze8XguoOIxXp?=
 =?us-ascii?Q?TN3BAcbV2k0RgwIxlkMMq5zIXAZBBAej/dhH11fFVGesmKP3poEVMJxhLg8n?=
 =?us-ascii?Q?Qj4qDeNh++Xhg5rTxRAj3Yt8m1hrEN2wFBiIK92GW/082j+0Bjy6ei67ybd9?=
 =?us-ascii?Q?N9NAdO9EXYLKoXy8+GyoovvbWYUX+DsX4DYt2fKSS5Hnf0xxwxFrmlKGXCvV?=
 =?us-ascii?Q?+tLjwxlLjSzwfamHvlNXrJSolL6TLrxbCwBRDyQUq2mAmE0CSZYBFqPwX7Za?=
 =?us-ascii?Q?BsTkddb/w0UTdvKfhNPaFntiku8Mc1EnfxI4ajXu6OxmyhQaO/RahMbG6sJw?=
 =?us-ascii?Q?Wuq7S0WH9lvAuv8RBtOSq6Bkz5HYH9BGCoG0NvGDfmxFHxvu+NadoeMqSmwy?=
 =?us-ascii?Q?b8Lc+sw7oIyEbNQ+XlOsEhtWlltUncidCB7/qLlZoJUN7QYlnHbm4MIMTRFq?=
 =?us-ascii?Q?Ydlv8n0L08SRNr+ShuQx2FUNWYq5grW2WyPdW/+1axcg0SOLqdU+Js7o/SGN?=
 =?us-ascii?Q?T0y9kIOSrITGDie3StDpZM6d91v70zUmsUbAoHhyccSF08STbHkhJK0Ah+UL?=
 =?us-ascii?Q?tWBDjhyoOG/swsPx0epIIthxVFtBlJSGn1iBlsoNsGG8IK1GVAtxghVC2A5G?=
 =?us-ascii?Q?PUfvs8H1vi3ZW2GMIb43wAF7/KSH6iJRadGvSc6GDg5eX9apnzoOwmpD0Rb+?=
 =?us-ascii?Q?ZKk9LAPrMjHu6hg4dWTa0lq6//XlVxPRUuA6Sr45UYVy08lvPr0RUD6S1A7H?=
 =?us-ascii?Q?iEJUsTMoVFvkuw2NKstswXhousL2hOa58lni0T9dnqhOnn7pCLrhrziVDQY9?=
 =?us-ascii?Q?li2cPe+ltRycQ+vwSYX0Da8zyNdVfYuPPiaVWjgNzyM30o5+SV0yhKukBd1T?=
 =?us-ascii?Q?MzaQRLw8dzTojXHczFLV31G9ylXc9zwuEMJMCaTtDsjs6KGkSQo80ZKOAoeH?=
 =?us-ascii?Q?fa6crwP6sA9gcehJcqDcEPO+8QHcwQ9Q4uhef94fBMKLxgmbOurqaFKstDTB?=
 =?us-ascii?Q?Wy16/suj/JmH2afVDD6ggYCzmBOXTLw7OFD+KRRlmyPfCzNEfqw96ffj3NIP?=
 =?us-ascii?Q?LmohZkn1+2YYwfqR2a0gCXgy6VTG8QstqOdj/mbq0oqY7VypKXD4XsV64WLn?=
 =?us-ascii?Q?YbTitWk+5haJG5/AX+6opduLu4uE8Wa3gls494jHV8QM+OU/WeANP7ilWfai?=
 =?us-ascii?Q?cUokLwpv9s2DrHQaElXGTIfDJIGGGwSQ7CykG/lHV2BJoqaXZBoijq8Lf0Oe?=
 =?us-ascii?Q?v++JLmsHNVk1SR5ixnDA65Fbq4HQt6LkEhK8hYy1Lt/WnZ6LH8YRD7B3i8Iy?=
 =?us-ascii?Q?5DoapvLE+4Fv59n6KNzwHiTYdRWoiBbpXNwKi7YhmGhCTukB1ykRKGDvAO0t?=
 =?us-ascii?Q?o0lM6tcISpexgGLGFLgSW3HBj6jggsT54LUjKBjQ?=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1508feb-ce37-4800-d54c-08db9d781e47
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2023 10:12:23.2245
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N1GlcA0zGCZUJeJ+MUGauw1ayIEeJhuz+0o8J4vE9xmXad46Auw82ZCWCeu3kLqq1D9jaurmqH4YGPfX0HDXAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7156
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--_000_PA4PR04MB963838F12BADC1B9FD377CB7D114APA4PR04MB9638eurp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

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
 drivers/net/wireless/marvell/mwifiex/sta_tx.c |  10 +-
 .../net/wireless/marvell/mwifiex/uap_cmd.c    |  26 ++
 drivers/net/wireless/marvell/mwifiex/util.c   |  73 ++++
 15 files changed, 583 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/=
wireless/marvell/mwifiex/cfg80211.c
index ba4e29713a8c..605952ee0aa9 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -57,6 +57,31 @@ ieee80211_iface_combination mwifiex_iface_comb_ap_sta_dr=
cs =3D {
 	.beacon_int_infra_match =3D true,
 };
=20
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
@@ -268,6 +293,8 @@ mwifiex_cfg80211_update_mgmt_frame_registrations(struct=
 wiphy *wiphy,
=20
 	if (mask !=3D priv->mgmt_frame_mask) {
 		priv->mgmt_frame_mask =3D mask;
+		if (priv->host_mlme_reg)
+			priv->mgmt_frame_mask |=3D HOST_MLME_MGMT_MASK;
 		mwifiex_send_cmd(priv, HostCmd_CMD_MGMT_FRAME_REG,
 				 HostCmd_ACT_GEN_SET, 0,
 				 &priv->mgmt_frame_mask, false);
@@ -848,6 +875,7 @@ static int mwifiex_deinit_priv_params(struct mwifiex_pr=
ivate *priv)
 	struct mwifiex_adapter *adapter =3D priv->adapter;
 	unsigned long flags;
=20
+	priv->host_mlme_reg =3D false;
 	priv->mgmt_frame_mask =3D 0;
 	if (mwifiex_send_cmd(priv, HostCmd_CMD_MGMT_FRAME_REG,
 			     HostCmd_ACT_GEN_SET, 0,
@@ -4201,6 +4229,292 @@ mwifiex_cfg80211_change_station(struct wiphy *wiphy=
, struct net_device *dev,
 	return ret;
 }
=20
+static int
+mwifiex_cfg80211_authenticate(struct wiphy *wiphy,
+			      struct net_device *dev,
+			      struct cfg80211_auth_request *req)
+{
+	struct mwifiex_private *priv =3D mwifiex_netdev_get_priv(dev);
+	struct mwifiex_adapter *adapter =3D priv->adapter;
+	struct sk_buff *skb;
+	u16 pkt_len, auth_alg;
+	int ret;
+	struct mwifiex_ieee80211_mgmt *mgmt;
+	struct mwifiex_txinfo *tx_info;
+	u32 tx_control =3D 0, pkt_type =3D PKT_TYPE_MGMT;
+	u8 addr[ETH_ALEN] =3D {0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF};
+	u8 trans =3D 1, status_code =3D 0;
+	u8 *varptr;
+
+	if (GET_BSS_ROLE(priv) =3D=3D MWIFIEX_BSS_ROLE_UAP) {
+		mwifiex_dbg(priv->adapter, ERROR, "Interface role is AP\n");
+		return -EFAULT;
+	}
+
+	if (priv->wdev.iftype !=3D NL80211_IFTYPE_STATION) {
+		mwifiex_dbg(priv->adapter, ERROR,
+			    "Interface type is not correct (type %d)\n",
+			    priv->wdev.iftype);
+		return -EINVAL;
+	}
+
+	if (priv->auth_alg !=3D WLAN_AUTH_SAE &&
+	    (priv->auth_flag & HOST_MLME_AUTH_PENDING)) {
+		mwifiex_dbg(priv->adapter, ERROR, "Pending auth on going\n");
+		return -EBUSY;
+	}
+
+	if (!priv->host_mlme_reg) {
+		priv->host_mlme_reg =3D true;
+		priv->mgmt_frame_mask |=3D HOST_MLME_MGMT_MASK;
+		mwifiex_send_cmd(priv, HostCmd_CMD_MGMT_FRAME_REG,
+				 HostCmd_ACT_GEN_SET, 0,
+				 &priv->mgmt_frame_mask, false);
+	}
+
+	switch (req->auth_type) {
+	case NL80211_AUTHTYPE_OPEN_SYSTEM:
+		auth_alg =3D WLAN_AUTH_OPEN;
+		break;
+	case NL80211_AUTHTYPE_SHARED_KEY:
+		auth_alg =3D WLAN_AUTH_SHARED_KEY;
+		break;
+	case NL80211_AUTHTYPE_FT:
+		auth_alg =3D WLAN_AUTH_FT;
+		break;
+	case NL80211_AUTHTYPE_NETWORK_EAP:
+		auth_alg =3D WLAN_AUTH_LEAP;
+		break;
+	case NL80211_AUTHTYPE_SAE:
+		auth_alg =3D WLAN_AUTH_SAE;
+		break;
+	default:
+		mwifiex_dbg(priv->adapter, ERROR,
+			    "unsupported auth type=3D%d\n", req->auth_type);
+		return -EOPNOTSUPP;
+	}
+
+	if (!priv->auth_flag) {
+		ret =3D mwifiex_remain_on_chan_cfg(priv, HostCmd_ACT_GEN_SET,
+						 req->bss->channel,
+						 AUTH_TX_DEFAULT_WAIT_TIME);
+
+		if (!ret) {
+			priv->roc_cfg.cookie =3D get_random_u32() | 1;
+			priv->roc_cfg.chan =3D *req->bss->channel;
+		}
+	}
+
+	priv->sec_info.authentication_mode =3D auth_alg;
+
+	mwifiex_cancel_scan(adapter);
+
+	pkt_len =3D (u16)req->ie_len + req->auth_data_len +
+		     MWIFIEX_MGMT_HEADER_LEN + MWIFIEX_AUTH_BODY_LEN;
+	if (req->auth_data_len >=3D 4)
+		pkt_len -=3D 4;
+
+	skb =3D dev_alloc_skb(MWIFIEX_MIN_DATA_HEADER_LEN +
+			    MWIFIEX_MGMT_FRAME_HEADER_SIZE +
+			    pkt_len + sizeof(pkt_len));
+	if (!skb) {
+		mwifiex_dbg(priv->adapter, ERROR,
+			    "allocate skb failed for management frame\n");
+		return -ENOMEM;
+	}
+
+	tx_info =3D MWIFIEX_SKB_TXCB(skb);
+	memset(tx_info, 0, sizeof(*tx_info));
+	tx_info->bss_num =3D priv->bss_num;
+	tx_info->bss_type =3D priv->bss_type;
+	tx_info->pkt_len =3D pkt_len;
+
+	skb_reserve(skb, MWIFIEX_MIN_DATA_HEADER_LEN +
+		    MWIFIEX_MGMT_FRAME_HEADER_SIZE + sizeof(pkt_len));
+	memcpy(skb_push(skb, sizeof(pkt_len)), &pkt_len, sizeof(pkt_len));
+	memcpy(skb_push(skb, sizeof(tx_control)),
+	       &tx_control, sizeof(tx_control));
+	memcpy(skb_push(skb, sizeof(pkt_type)), &pkt_type, sizeof(pkt_type));
+
+	mgmt =3D (struct mwifiex_ieee80211_mgmt *)skb_put(skb, pkt_len);
+	memset(mgmt, 0, pkt_len);
+	mgmt->frame_control =3D
+		cpu_to_le16(IEEE80211_FTYPE_MGMT | IEEE80211_STYPE_AUTH);
+	memcpy(mgmt->da, req->bss->bssid, ETH_ALEN);
+	memcpy(mgmt->sa, priv->curr_addr, ETH_ALEN);
+	memcpy(mgmt->bssid, req->bss->bssid, ETH_ALEN);
+	memcpy(mgmt->addr4, addr, ETH_ALEN);
+
+	if (req->auth_data_len >=3D 4) {
+		if (req->auth_type =3D=3D NL80211_AUTHTYPE_SAE) {
+			__le16 *pos =3D (__le16 *)req->auth_data;
+
+			trans =3D le16_to_cpu(pos[0]);
+			status_code =3D le16_to_cpu(pos[1]);
+		}
+		memcpy((u8 *)(&mgmt->u.auth.variable), req->auth_data + 4,
+		       req->auth_data_len - 4);
+		varptr =3D (u8 *)&mgmt->u.auth.variable +
+			 (req->auth_data_len - 4);
+	}
+
+	mgmt->u.auth.auth_alg =3D cpu_to_le16(auth_alg);
+	mgmt->u.auth.auth_transaction =3D trans;
+	mgmt->u.auth.status_code =3D status_code;
+
+	if (req->ie && req->ie_len) {
+		if (!varptr)
+			varptr =3D (u8 *)&mgmt->u.auth.variable;
+		memcpy((u8 *)varptr, req->ie, req->ie_len);
+	}
+
+	priv->auth_flag =3D HOST_MLME_AUTH_PENDING;
+	priv->auth_alg =3D auth_alg;
+
+	skb->priority =3D WMM_HIGHEST_PRIORITY;
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
+	struct mwifiex_private *priv =3D mwifiex_netdev_get_priv(dev);
+	struct mwifiex_adapter *adapter =3D priv->adapter;
+	int ret;
+	struct cfg80211_ssid req_ssid;
+	const u8 *ssid_ie;
+	struct cfg80211_rx_assoc_resp assoc_resp =3D {
+		.uapsd_queues =3D -1,
+	};
+
+	if (GET_BSS_ROLE(priv) !=3D MWIFIEX_BSS_ROLE_STA) {
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
+	if (priv->auth_alg =3D=3D WLAN_AUTH_SAE)
+		priv->auth_flag =3D HOST_MLME_AUTH_DONE;
+
+	if (priv->auth_flag && !(priv->auth_flag & HOST_MLME_AUTH_DONE))
+		return -EBUSY;
+
+	if (!mwifiex_stop_bg_scan(priv))
+		cfg80211_sched_scan_stopped_locked(priv->wdev.wiphy, 0);
+
+	memset(&req_ssid, 0, sizeof(struct cfg80211_ssid));
+	rcu_read_lock();
+	ssid_ie =3D ieee80211_bss_get_ie(req->bss, WLAN_EID_SSID);
+
+	if (!ssid_ie)
+		goto ssid_err;
+
+	req_ssid.ssid_len =3D ssid_ie[1];
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
+	priv->sec_info.wpa_enabled =3D false;
+	priv->sec_info.wpa2_enabled =3D false;
+	priv->wep_key_curr_index =3D 0;
+	priv->sec_info.encryption_mode =3D 0;
+	priv->sec_info.is_authtype_auto =3D 0;
+	ret =3D mwifiex_set_encode(priv, NULL, NULL, 0, 0, NULL, 1);
+
+	if (req->crypto.n_ciphers_pairwise)
+		priv->sec_info.encryption_mode =3D
+			req->crypto.ciphers_pairwise[0];
+
+	if (req->crypto.cipher_group)
+		priv->sec_info.encryption_mode =3D req->crypto.cipher_group;
+
+	if (req->ie)
+		ret =3D mwifiex_set_gen_ie(priv, req->ie, req->ie_len);
+
+	memcpy(priv->cfg_bssid, req->bss->bssid, ETH_ALEN);
+
+	mwifiex_dbg(priv->adapter, MSG,
+		    "assoc: send association to %pM\n", req->bss->bssid);
+
+	cfg80211_ref_bss(priv->adapter->wiphy, req->bss);
+
+	ret =3D mwifiex_bss_start(priv, req->bss, &req_ssid);
+
+	if (!ret) {
+		assoc_resp.links[0].bss =3D priv->attempted_bss_desc->bss;
+		assoc_resp.buf =3D priv->assoc_rsp_buf;
+		assoc_resp.len =3D priv->assoc_rsp_size;
+		cfg80211_rx_assoc_resp(priv->netdev,
+				       &assoc_resp);
+	} else {
+		priv->auth_flag =3D 0;
+		priv->auth_alg =3D 0xFFFF;
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
 static struct cfg80211_ops mwifiex_cfg80211_ops =3D {
 	.add_virtual_intf =3D mwifiex_add_virtual_intf,
@@ -4346,6 +4660,16 @@ int mwifiex_register_cfg80211(struct mwifiex_adapter=
 *adapter)
 			    "%s: creating new wiphy\n", __func__);
 		return -ENOMEM;
 	}
+	if (adapter->host_mlme) {
+		mwifiex_cfg80211_ops.auth =3D mwifiex_cfg80211_authenticate;
+		mwifiex_cfg80211_ops.assoc =3D mwifiex_cfg80211_associate;
+		mwifiex_cfg80211_ops.deauth =3D mwifiex_cfg80211_deauthenticate;
+		mwifiex_cfg80211_ops.disassoc =3D mwifiex_cfg80211_disassociate;
+		mwifiex_cfg80211_ops.disconnect =3D NULL;
+		mwifiex_cfg80211_ops.connect =3D NULL;
+		mwifiex_cfg80211_ops.probe_client =3D
+			mwifiex_cfg80211_probe_client;
+	}
 	wiphy->max_scan_ssids =3D MWIFIEX_MAX_SSID_LIST_LENGTH;
 	wiphy->max_scan_ie_len =3D MWIFIEX_MAX_VSIE_LEN;
 	wiphy->mgmt_stypes =3D mwifiex_mgmt_stypes;
@@ -4427,6 +4751,9 @@ int mwifiex_register_cfg80211(struct mwifiex_adapter =
*adapter)
 			   NL80211_FEATURE_LOW_PRIORITY_SCAN |
 			   NL80211_FEATURE_NEED_OBSS_SCAN;
=20
+	if (adapter->host_mlme)
+		wiphy->features |=3D NL80211_FEATURE_SAE;
+
 	if (ISSUPP_ADHOC_ENABLED(adapter->fw_cap_info))
 		wiphy->features |=3D NL80211_FEATURE_HT_IBSS;
=20
diff --git a/drivers/net/wireless/marvell/mwifiex/cmdevt.c b/drivers/net/wi=
reless/marvell/mwifiex/cmdevt.c
index 3756aa247e77..311af5f40c3e 100644
--- a/drivers/net/wireless/marvell/mwifiex/cmdevt.c
+++ b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
@@ -654,7 +654,7 @@ int mwifiex_send_cmd(struct mwifiex_private *priv, u16 =
cmd_no,
 	if (ret) {
 		mwifiex_dbg(adapter, ERROR,
 			    "PREP_CMD: cmd %#x preparation failed\n",
-			cmd_no);
+			    cmd_no);
 		mwifiex_insert_cmd_to_free_q(adapter, cmd_node);
 		return -1;
 	}
@@ -1477,6 +1477,17 @@ int mwifiex_cmd_get_hw_spec(struct mwifiex_private *=
priv,
 	return 0;
 }
=20
+static void mwifiex_check_key_api_ver(struct mwifiex_adapter *adapter)
+{
+	if (adapter->host_mlme) {
+		if (adapter->key_api_major_ver !=3D KEY_API_VER_MAJOR_V2)
+			adapter->host_mlme =3D false;
+		mwifiex_dbg(adapter, MSG, "host_mlme: %s, key_api: %d\n",
+			    adapter->host_mlme ? "enable" : "disable",
+			    adapter->key_api_major_ver);
+	}
+}
+
 /*
  * This function handles the command response of get hardware
  * specifications.
@@ -1586,6 +1597,7 @@ int mwifiex_ret_get_hw_spec(struct mwifiex_private *p=
riv,
 						    "key_api v%d.%d\n",
 						    adapter->key_api_major_ver,
 						    adapter->key_api_minor_ver);
+					mwifiex_check_key_api_ver(adapter);
 					break;
 				case FW_API_VER_ID:
 					adapter->fw_api_ver =3D
diff --git a/drivers/net/wireless/marvell/mwifiex/decl.h b/drivers/net/wire=
less/marvell/mwifiex/decl.h
index 88648c062713..385b5119f2ee 100644
--- a/drivers/net/wireless/marvell/mwifiex/decl.h
+++ b/drivers/net/wireless/marvell/mwifiex/decl.h
@@ -24,6 +24,18 @@
 #define MWIFIEX_RX_HEADROOM	    64
 #define MAX_TXPD_SZ		    32
 #define INTF_HDR_ALIGN		     4
+/* frmctl + durationid + addr1 + addr2 + addr3 + seqctl + addr4 */
+#define MWIFIEX_MGMT_HEADER_LEN   (2 + 2 + 6 + 6 + 6 + 2 + 6)
+/* 6   =3D auth_alg + auth_transaction + auth_status */
+#define MWIFIEX_AUTH_BODY_LEN     6
+
+#define HOST_MLME_AUTH_PENDING    BIT(0)
+#define HOST_MLME_AUTH_DONE       BIT(1)
+
+#define HOST_MLME_MGMT_MASK       (BIT(IEEE80211_STYPE_AUTH >> 4) | \
+				   BIT(IEEE80211_STYPE_DEAUTH >> 4) | \
+				   BIT(IEEE80211_STYPE_DISASSOC >> 4))
+#define AUTH_TX_DEFAULT_WAIT_TIME 2400
=20
 #define MWIFIEX_MIN_DATA_HEADER_LEN (MWIFIEX_DMA_ALIGN_SZ + INTF_HDR_ALIGN=
 + \
 				     MAX_TXPD_SZ)
diff --git a/drivers/net/wireless/marvell/mwifiex/fw.h b/drivers/net/wirele=
ss/marvell/mwifiex/fw.h
index f2168fac95ed..5e6bda38f22c 100644
--- a/drivers/net/wireless/marvell/mwifiex/fw.h
+++ b/drivers/net/wireless/marvell/mwifiex/fw.h
@@ -209,6 +209,9 @@ enum MWIFIEX_802_11_PRIVACY_FILTER {
 #define TLV_TYPE_RANDOM_MAC         (PROPRIETARY_TLV_BASE_ID + 236)
 #define TLV_TYPE_CHAN_ATTR_CFG      (PROPRIETARY_TLV_BASE_ID + 237)
 #define TLV_TYPE_MAX_CONN           (PROPRIETARY_TLV_BASE_ID + 279)
+#define TLV_TYPE_HOST_MLME          (PROPRIETARY_TLV_BASE_ID + 307)
+#define TLV_TYPE_SAE_PWE_MODE       (PROPRIETARY_TLV_BASE_ID + 339)
+
=20
 #define MWIFIEX_TX_DATA_BUF_SIZE_2K        2048
=20
@@ -802,6 +805,11 @@ struct mwifiex_ie_types_ssid_param_set {
 	u8 ssid[];
 } __packed;
=20
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
=20
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
diff --git a/drivers/net/wireless/marvell/mwifiex/init.c b/drivers/net/wire=
less/marvell/mwifiex/init.c
index 7dddb4b5dea1..ca23be8d3ac3 100644
--- a/drivers/net/wireless/marvell/mwifiex/init.c
+++ b/drivers/net/wireless/marvell/mwifiex/init.c
@@ -81,6 +81,9 @@ int mwifiex_init_priv(struct mwifiex_private *priv)
 	priv->bcn_avg_factor =3D DEFAULT_BCN_AVG_FACTOR;
 	priv->data_avg_factor =3D DEFAULT_DATA_AVG_FACTOR;
=20
+	priv->auth_flag =3D 0;
+	priv->auth_alg =3D 0xFFFF;
+
 	priv->sec_info.wep_enabled =3D 0;
 	priv->sec_info.authentication_mode =3D NL80211_AUTHTYPE_OPEN_SYSTEM;
 	priv->sec_info.encryption_mode =3D 0;
diff --git a/drivers/net/wireless/marvell/mwifiex/join.c b/drivers/net/wire=
less/marvell/mwifiex/join.c
index a6e254a1185c..ef7cc40c3ba4 100644
--- a/drivers/net/wireless/marvell/mwifiex/join.c
+++ b/drivers/net/wireless/marvell/mwifiex/join.c
@@ -382,7 +382,9 @@ int mwifiex_cmd_802_11_associate(struct mwifiex_private=
 *priv,
 	struct mwifiex_ie_types_ss_param_set *ss_tlv;
 	struct mwifiex_ie_types_rates_param_set *rates_tlv;
 	struct mwifiex_ie_types_auth_type *auth_tlv;
+	struct mwifiex_ie_types_sae_pwe_mode *sae_pwe_tlv;
 	struct mwifiex_ie_types_chan_list_param_set *chan_tlv;
+	struct mwifiex_ie_types_host_mlme *host_mlme_tlv;
 	u8 rates[MWIFIEX_SUPPORTED_RATES];
 	u32 rates_size;
 	u16 tmp_cap;
@@ -448,7 +450,7 @@ int mwifiex_cmd_802_11_associate(struct mwifiex_private=
 *priv,
 	mwifiex_dbg(priv->adapter, INFO, "info: ASSOC_CMD: rates size =3D %d\n",
 		    rates_size);
=20
-	/* Add the Authentication type to be used for Auth frames */
+	/* Add the Authentication type */
 	auth_tlv =3D (struct mwifiex_ie_types_auth_type *) pos;
 	auth_tlv->header.type =3D cpu_to_le16(TLV_TYPE_AUTH_TYPE);
 	auth_tlv->header.len =3D cpu_to_le16(sizeof(auth_tlv->auth_type));
@@ -460,6 +462,24 @@ int mwifiex_cmd_802_11_associate(struct mwifiex_privat=
e *priv,
=20
 	pos +=3D sizeof(auth_tlv->header) + le16_to_cpu(auth_tlv->header.len);
=20
+	if (priv->sec_info.authentication_mode =3D=3D WLAN_AUTH_SAE) {
+		auth_tlv->auth_type =3D cpu_to_le16(MWIFIEX_AUTHTYPE_SAE);
+		if (bss_desc->bcn_rsnx_ie &&
+		    bss_desc->bcn_rsnx_ie->ieee_hdr.len &&
+		    (bss_desc->bcn_rsnx_ie->data[0] &
+		    WLAN_RSNX_CAPA_SAE_H2E)) {
+			sae_pwe_tlv =3D
+				(struct mwifiex_ie_types_sae_pwe_mode *)pos;
+			sae_pwe_tlv->header.type =3D
+				cpu_to_le16(TLV_TYPE_SAE_PWE_MODE);
+			sae_pwe_tlv->header.len =3D
+				cpu_to_le16(sizeof(sae_pwe_tlv->pwe[0]));
+			sae_pwe_tlv->pwe[0] =3D bss_desc->bcn_rsnx_ie->data[0];
+			pos +=3D sizeof(sae_pwe_tlv->header) +
+				sizeof(sae_pwe_tlv->pwe[0]);
+		}
+	}
+
 	if (IS_SUPPORT_MULTI_BANDS(priv->adapter) &&
 	    !(ISSUPP_11NENABLED(priv->adapter->fw_cap_info) &&
 	    (!bss_desc->disable_11n) &&
@@ -491,6 +511,16 @@ int mwifiex_cmd_802_11_associate(struct mwifiex_privat=
e *priv,
 			sizeof(struct mwifiex_chan_scan_param_set);
 	}
=20
+	if (priv->adapter->host_mlme) {
+		host_mlme_tlv =3D (struct mwifiex_ie_types_host_mlme *)pos;
+		host_mlme_tlv->header.type =3D cpu_to_le16(TLV_TYPE_HOST_MLME);
+		host_mlme_tlv->header.len =3D
+			cpu_to_le16(sizeof(host_mlme_tlv->host_mlme));
+		host_mlme_tlv->host_mlme =3D 1;
+		pos +=3D sizeof(host_mlme_tlv->header) +
+			sizeof(host_mlme_tlv->host_mlme);
+	}
+
 	if (!priv->wps.session_enable) {
 		if (priv->sec_info.wpa_enabled || priv->sec_info.wpa2_enabled)
 			rsn_ie_len =3D mwifiex_append_rsn_ie_wpa_wpa2(priv, &pos);
@@ -634,6 +664,7 @@ int mwifiex_ret_802_11_associate(struct mwifiex_private=
 *priv,
 	u16 cap_info, status_code, aid;
 	const u8 *ie_ptr;
 	struct ieee80211_ht_operation *assoc_resp_ht_oper;
+	struct ieee80211_mgmt *hdr;
=20
 	if (!priv->attempted_bss_desc) {
 		mwifiex_dbg(priv->adapter, ERROR,
@@ -641,7 +672,19 @@ int mwifiex_ret_802_11_associate(struct mwifiex_privat=
e *priv,
 		goto done;
 	}
=20
-	assoc_rsp =3D (struct ieee_types_assoc_rsp *) &resp->params;
+	if (adapter->host_mlme) {
+		hdr =3D (struct ieee80211_mgmt *)&resp->params;
+		if (!memcmp(hdr->bssid,
+			    priv->attempted_bss_desc->mac_address,
+			    ETH_ALEN))
+			assoc_rsp =3D (struct ieee_types_assoc_rsp *)
+				&hdr->u.assoc_resp;
+		else
+			assoc_rsp =3D
+				(struct ieee_types_assoc_rsp *)&resp->params;
+	} else {
+		assoc_rsp =3D (struct ieee_types_assoc_rsp *)&resp->params;
+	}
=20
 	cap_info =3D le16_to_cpu(assoc_rsp->cap_info_bitmap);
 	status_code =3D le16_to_cpu(assoc_rsp->status_code);
@@ -778,7 +821,8 @@ int mwifiex_ret_802_11_associate(struct mwifiex_private=
 *priv,
=20
 	priv->adapter->dbg.num_cmd_assoc_success++;
=20
-	mwifiex_dbg(priv->adapter, INFO, "info: ASSOC_RESP: associated\n");
+	mwifiex_dbg(priv->adapter, MSG, "assoc: associated with %pM\n",
+		    priv->attempted_bss_desc->mac_address);
=20
 	/* Add the ra_list here for infra mode as there will be only 1 ra
 	   always */
@@ -1491,6 +1535,20 @@ int mwifiex_deauthenticate(struct mwifiex_private *p=
riv, u8 *mac)
 	if (!priv->media_connected)
 		return 0;
=20
+	if (priv->adapter->host_mlme) {
+		priv->auth_flag =3D 0;
+		priv->auth_alg =3D 0xFFFF;
+		priv->host_mlme_reg =3D false;
+		priv->mgmt_frame_mask =3D 0;
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
diff --git a/drivers/net/wireless/marvell/mwifiex/main.h b/drivers/net/wire=
less/marvell/mwifiex/main.h
index b95886e1413e..6d0b9fcfe07c 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.h
+++ b/drivers/net/wireless/marvell/mwifiex/main.h
@@ -384,6 +384,7 @@ struct ieee_types_aid {
=20
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
@@ -536,6 +539,8 @@ struct mwifiex_private {
 	u8 bss_priority;
 	u8 bss_num;
 	u8 bss_started;
+	u8 auth_flag;
+	u16 auth_alg;
 	u8 frame_type;
 	u8 curr_addr[ETH_ALEN];
 	u8 media_connected;
@@ -658,6 +663,7 @@ struct mwifiex_private {
 	u16 gen_idx;
 	u8 ap_11n_enabled;
 	u8 ap_11ac_enabled;
+	bool host_mlme_reg;
 	u32 mgmt_frame_mask;
 	struct mwifiex_roc_cfg roc_cfg;
 	bool scan_aborting;
@@ -1012,6 +1018,7 @@ struct mwifiex_adapter {
 	bool is_up;
=20
 	bool ext_scan;
+	bool host_mlme;
 	u8 fw_api_ver;
 	u8 key_api_major_ver, key_api_minor_ver;
 	u8 max_p2p_conn, max_sta_conn;
@@ -1077,6 +1084,9 @@ int mwifiex_recv_packet(struct mwifiex_private *priv,=
 struct sk_buff *skb);
 int mwifiex_uap_recv_packet(struct mwifiex_private *priv,
 			    struct sk_buff *skb);
=20
+void mwifiex_host_mlme_disconnect(struct mwifiex_private *priv,
+				  u16 reason_code, u8 *sa);
+
 int mwifiex_process_mgmt_packet(struct mwifiex_private *priv,
 				struct sk_buff *skb);
=20
diff --git a/drivers/net/wireless/marvell/mwifiex/scan.c b/drivers/net/wire=
less/marvell/mwifiex/scan.c
index 644b1e134b01..27eb9a073666 100644
--- a/drivers/net/wireless/marvell/mwifiex/scan.c
+++ b/drivers/net/wireless/marvell/mwifiex/scan.c
@@ -1388,6 +1388,12 @@ int mwifiex_update_bss_desc_with_ie(struct mwifiex_a=
dapter *adapter,
 			bss_entry->rsn_offset =3D (u16) (current_ptr -
 							bss_entry->beacon_buf);
 			break;
+		case WLAN_EID_RSNX:
+			bss_entry->bcn_rsnx_ie =3D
+				(struct ieee_types_generic *)current_ptr;
+			bss_entry->rsnx_offset =3D
+				(u16)(current_ptr - bss_entry->beacon_buf);
+			break;
 		case WLAN_EID_BSS_AC_ACCESS_DELAY:
 			bss_entry->bcn_wapi_ie =3D
 				(struct ieee_types_generic *) current_ptr;
diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.c b/drivers/net/wire=
less/marvell/mwifiex/sdio.c
index a24bd40dd41a..6ba0339ccc65 100644
--- a/drivers/net/wireless/marvell/mwifiex/sdio.c
+++ b/drivers/net/wireless/marvell/mwifiex/sdio.c
@@ -331,6 +331,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd=
8786 =3D {
 	.can_dump_fw =3D false,
 	.can_auto_tdls =3D false,
 	.can_ext_scan =3D false,
+	.host_mlme =3D false,
 };
=20
 static const struct mwifiex_sdio_device mwifiex_sdio_sd8787 =3D {
@@ -346,6 +347,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd=
8787 =3D {
 	.can_dump_fw =3D false,
 	.can_auto_tdls =3D false,
 	.can_ext_scan =3D true,
+	.host_mlme =3D false,
 };
=20
 static const struct mwifiex_sdio_device mwifiex_sdio_sd8797 =3D {
@@ -361,6 +363,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd=
8797 =3D {
 	.can_dump_fw =3D false,
 	.can_auto_tdls =3D false,
 	.can_ext_scan =3D true,
+	.host_mlme =3D false,
 };
=20
 static const struct mwifiex_sdio_device mwifiex_sdio_sd8897 =3D {
@@ -376,6 +379,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd=
8897 =3D {
 	.can_dump_fw =3D true,
 	.can_auto_tdls =3D false,
 	.can_ext_scan =3D true,
+	.host_mlme =3D false,
 };
=20
 static const struct mwifiex_sdio_device mwifiex_sdio_sd8977 =3D {
@@ -392,6 +396,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd=
8977 =3D {
 	.fw_dump_enh =3D true,
 	.can_auto_tdls =3D false,
 	.can_ext_scan =3D true,
+	.host_mlme =3D false,
 };
=20
 static const struct mwifiex_sdio_device mwifiex_sdio_sd8978 =3D {
@@ -408,6 +413,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd=
8978 =3D {
 	.fw_dump_enh =3D true,
 	.can_auto_tdls =3D false,
 	.can_ext_scan =3D true,
+	.host_mlme =3D true,
 };
=20
 static const struct mwifiex_sdio_device mwifiex_sdio_sd8997 =3D {
@@ -425,6 +431,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd=
8997 =3D {
 	.fw_dump_enh =3D true,
 	.can_auto_tdls =3D false,
 	.can_ext_scan =3D true,
+	.host_mlme =3D false,
 };
=20
 static const struct mwifiex_sdio_device mwifiex_sdio_sd8887 =3D {
@@ -440,6 +447,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd=
8887 =3D {
 	.can_dump_fw =3D false,
 	.can_auto_tdls =3D true,
 	.can_ext_scan =3D true,
+	.host_mlme =3D false,
 };
=20
 static const struct mwifiex_sdio_device mwifiex_sdio_sd8987 =3D {
@@ -456,6 +464,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd=
8987 =3D {
 	.fw_dump_enh =3D true,
 	.can_auto_tdls =3D true,
 	.can_ext_scan =3D true,
+	.host_mlme =3D false,
 };
=20
 static const struct mwifiex_sdio_device mwifiex_sdio_sd8801 =3D {
@@ -471,6 +480,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd=
8801 =3D {
 	.can_dump_fw =3D false,
 	.can_auto_tdls =3D false,
 	.can_ext_scan =3D true,
+	.host_mlme =3D false,
 };
=20
 static struct memory_type_mapping generic_mem_type_map[] =3D {
@@ -563,6 +573,7 @@ mwifiex_sdio_probe(struct sdio_func *func, const struct=
 sdio_device_id *id)
 		card->fw_dump_enh =3D data->fw_dump_enh;
 		card->can_auto_tdls =3D data->can_auto_tdls;
 		card->can_ext_scan =3D data->can_ext_scan;
+		card->host_mlme =3D data->host_mlme;
 		INIT_WORK(&card->work, mwifiex_sdio_work);
 	}
=20
@@ -2493,6 +2504,8 @@ static int mwifiex_register_dev(struct mwifiex_adapte=
r *adapter)
 		adapter->num_mem_types =3D ARRAY_SIZE(mem_type_mapping_tbl);
 	}
=20
+	adapter->host_mlme =3D card->host_mlme;
+
 	return 0;
 }
=20
diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.h b/drivers/net/wire=
less/marvell/mwifiex/sdio.h
index ae94c172310f..d2da8c45a9be 100644
--- a/drivers/net/wireless/marvell/mwifiex/sdio.h
+++ b/drivers/net/wireless/marvell/mwifiex/sdio.h
@@ -258,6 +258,7 @@ struct sdio_mmc_card {
 	bool fw_dump_enh;
 	bool can_auto_tdls;
 	bool can_ext_scan;
+	bool host_mlme;
=20
 	struct mwifiex_sdio_mpa_tx mpa_tx;
 	struct mwifiex_sdio_mpa_rx mpa_rx;
@@ -281,6 +282,7 @@ struct mwifiex_sdio_device {
 	bool fw_dump_enh;
 	bool can_auto_tdls;
 	bool can_ext_scan;
+	bool host_mlme;
 };
=20
 /*
diff --git a/drivers/net/wireless/marvell/mwifiex/sta_event.c b/drivers/net=
/wireless/marvell/mwifiex/sta_event.c
index df9cdd10a494..69426ddd9c3a 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_event.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_event.c
@@ -135,6 +135,9 @@ void mwifiex_reset_connect_state(struct mwifiex_private=
 *priv, u16 reason_code,
=20
 	priv->media_connected =3D false;
=20
+	priv->auth_flag =3D 0;
+	priv->auth_alg =3D 0xFFFF;
+
 	priv->scan_block =3D false;
 	priv->port_open =3D false;
=20
@@ -999,10 +1002,17 @@ int mwifiex_process_sta_event(struct mwifiex_private=
 *priv)
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
+			priv->auth_flag =3D 0;
+			priv->auth_alg =3D 0xFFFF;
+		} else {
+			cfg80211_remain_on_channel_expired(&priv->wdev,
+							   priv->roc_cfg.cookie,
+							   &priv->roc_cfg.chan,
+							   GFP_ATOMIC);
+		}
=20
 		memset(&priv->roc_cfg, 0x00, sizeof(struct mwifiex_roc_cfg));
=20
diff --git a/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c b/drivers/net=
/wireless/marvell/mwifiex/sta_ioctl.c
index a2ad2b53f016..046541713318 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
@@ -136,6 +136,7 @@ int mwifiex_fill_new_bss_desc(struct mwifiex_private *p=
riv,
 	const struct cfg80211_bss_ies *ies;
=20
 	rcu_read_lock();
+	bss_desc->bss =3D bss;
 	ies =3D rcu_dereference(bss->ies);
 	beacon_ie =3D kmemdup(ies->data, ies->len, GFP_ATOMIC);
 	beacon_ie_len =3D ies->len;
@@ -339,7 +340,7 @@ int mwifiex_bss_start(struct mwifiex_private *priv, str=
uct cfg80211_bss *bss,
 			ret =3D mwifiex_associate(priv, bss_desc);
 		}
=20
-		if (bss)
+		if (bss && !priv->adapter->host_mlme)
 			cfg80211_put_bss(priv->adapter->wiphy, bss);
 	} else {
 		/* Adhoc mode */
diff --git a/drivers/net/wireless/marvell/mwifiex/sta_tx.c b/drivers/net/wi=
reless/marvell/mwifiex/sta_tx.c
index 13c0e67ededf..6aed6a334d15 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_tx.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_tx.c
@@ -36,7 +36,7 @@ void *mwifiex_process_sta_txpd(struct mwifiex_private *pr=
iv,
 	struct txpd *local_tx_pd;
 	struct mwifiex_txinfo *tx_info =3D MWIFIEX_SKB_TXCB(skb);
 	unsigned int pad;
-	u16 pkt_type, pkt_offset;
+	u16 pkt_type, pkt_length, pkt_offset;
 	int hroom =3D adapter->intf_hdr_len;
=20
 	if (!skb->len) {
@@ -58,9 +58,11 @@ void *mwifiex_process_sta_txpd(struct mwifiex_private *p=
riv,
 	memset(local_tx_pd, 0, sizeof(struct txpd));
 	local_tx_pd->bss_num =3D priv->bss_num;
 	local_tx_pd->bss_type =3D priv->bss_type;
-	local_tx_pd->tx_pkt_length =3D cpu_to_le16((u16)(skb->len -
-						       (sizeof(struct txpd) +
-							pad)));
+
+	pkt_length =3D (u16)(skb->len - (sizeof(struct txpd) + pad));
+	if (pkt_type =3D=3D PKT_TYPE_MGMT)
+		pkt_length -=3D MWIFIEX_MGMT_FRAME_HEADER_SIZE;
+	local_tx_pd->tx_pkt_length =3D cpu_to_le16(pkt_length);
=20
 	local_tx_pd->priority =3D (u8) skb->priority;
 	local_tx_pd->pkt_delay_2ms =3D
diff --git a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c b/drivers/net/w=
ireless/marvell/mwifiex/uap_cmd.c
index e78a201cd150..eb0b8016d43d 100644
--- a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
+++ b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
@@ -743,6 +743,29 @@ mwifiex_cmd_uap_sys_config(struct host_cmd_ds_command =
*cmd, u16 cmd_action,
 	return 0;
 }
=20
+/* This function prepares AP start up command with or without host MLME
+ */
+static int mwifiex_cmd_uap_bss_start(struct mwifiex_private *priv,
+				     struct host_cmd_ds_command *cmd)
+{
+	struct mwifiex_ie_types_host_mlme *tlv;
+
+	cmd->command =3D cpu_to_le16(HostCmd_CMD_UAP_BSS_START);
+	cmd->size =3D S_DS_GEN;
+
+	if (priv->adapter->host_mlme) {
+		tlv =3D (struct mwifiex_ie_types_host_mlme *)((u8 *)cmd + cmd->size);
+		tlv->header.type =3D cpu_to_le16(TLV_TYPE_HOST_MLME);
+		tlv->header.len =3D cpu_to_le16(sizeof(tlv->host_mlme));
+		tlv->host_mlme =3D 1;
+		cmd->size +=3D sizeof(struct mwifiex_ie_types_host_mlme);
+	}
+
+	cmd->size =3D cpu_to_le16(cmd->size);
+
+	return 0;
+}
+
 /* This function prepares AP specific deauth command with mac supplied in
  * function parameter.
  */
@@ -777,6 +800,9 @@ int mwifiex_uap_prepare_cmd(struct mwifiex_private *pri=
v, u16 cmd_no,
 			return -1;
 		break;
 	case HostCmd_CMD_UAP_BSS_START:
+		if (mwifiex_cmd_uap_bss_start(priv, cmd))
+			return -1;
+		break;
 	case HostCmd_CMD_UAP_BSS_STOP:
 	case HOST_CMD_APCMD_SYS_RESET:
 	case HOST_CMD_APCMD_STA_LIST:
diff --git a/drivers/net/wireless/marvell/mwifiex/util.c b/drivers/net/wire=
less/marvell/mwifiex/util.c
index 745b1d925b21..bd9bf2888485 100644
--- a/drivers/net/wireless/marvell/mwifiex/util.c
+++ b/drivers/net/wireless/marvell/mwifiex/util.c
@@ -370,6 +370,46 @@ mwifiex_parse_mgmt_packet(struct mwifiex_private *priv=
, u8 *payload, u16 len,
=20
 	return 0;
 }
+
+/* This function sends deauth packet to the kernel. */
+void mwifiex_host_mlme_disconnect(struct mwifiex_private *priv,
+				  u16 reason_code, u8 *sa)
+{
+	u8 broadcast_addr[ETH_ALEN] =3D {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
+	u8 frame_buf[100];
+	struct ieee80211_mgmt *mgmt =3D (struct ieee80211_mgmt *)frame_buf;
+
+	memset(frame_buf, 0, sizeof(frame_buf));
+	mgmt->frame_control =3D (__force __le16)IEEE80211_STYPE_DEAUTH;
+	mgmt->duration =3D 0;
+	mgmt->seq_ctrl =3D 0;
+	mgmt->u.deauth.reason_code =3D (__force __le16)reason_code;
+
+	if (GET_BSS_ROLE(priv) =3D=3D MWIFIEX_BSS_ROLE_STA) {
+		memcpy(mgmt->da, broadcast_addr, ETH_ALEN);
+		memcpy(mgmt->sa,
+		       priv->curr_bss_params.bss_descriptor.mac_address,
+		       ETH_ALEN);
+		memcpy(mgmt->bssid, priv->cfg_bssid, ETH_ALEN);
+		priv->auth_flag =3D 0;
+		priv->auth_alg =3D 0xFFFF;
+	} else {
+		memcpy(mgmt->da, priv->curr_addr, ETH_ALEN);
+		memcpy(mgmt->sa, sa, ETH_ALEN);
+		memcpy(mgmt->bssid, priv->curr_addr, ETH_ALEN);
+	}
+
+	if (GET_BSS_ROLE(priv) !=3D MWIFIEX_BSS_ROLE_UAP) {
+		mutex_lock(&priv->wdev.mtx);
+		cfg80211_rx_mlme_mgmt(priv->netdev, frame_buf, 26);
+		mutex_unlock(&priv->wdev.mtx);
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
@@ -417,6 +457,39 @@ mwifiex_process_mgmt_packet(struct mwifiex_private *pr=
iv,
 	pkt_len -=3D ETH_ALEN;
 	rx_pd->rx_pkt_length =3D cpu_to_le16(pkt_len);
=20
+	if (priv->host_mlme_reg &&
+	    (GET_BSS_ROLE(priv) !=3D MWIFIEX_BSS_ROLE_UAP) &&
+	    (ieee80211_is_auth(ieee_hdr->frame_control) ||
+	     ieee80211_is_deauth(ieee_hdr->frame_control) ||
+	     ieee80211_is_disassoc(ieee_hdr->frame_control))) {
+		if (ieee80211_is_auth(ieee_hdr->frame_control)) {
+			if (priv->auth_flag & HOST_MLME_AUTH_PENDING) {
+				if (priv->auth_alg !=3D WLAN_AUTH_SAE) {
+					priv->auth_flag &=3D
+						~HOST_MLME_AUTH_PENDING;
+					priv->auth_flag |=3D
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
+				priv->auth_flag =3D 0;
+				priv->auth_alg =3D 0xFFFF;
+			}
+		}
+
+		cfg80211_rx_mlme_mgmt(priv->netdev, skb->data, pkt_len);
+	}
+
 	cfg80211_rx_mgmt(&priv->wdev, priv->roc_cfg.chan.center_freq,
 			 CAL_RSSI(rx_pd->snr, rx_pd->nf), skb->data, pkt_len,
 			 0);
--=20
2.25.1


--_000_PA4PR04MB963838F12BADC1B9FD377CB7D114APA4PR04MB9638eurp_
Content-Disposition: attachment; filename="winmail.dat"
Content-Transfer-Encoding: base64
Content-Type: application/ms-tnef; name="winmail.dat"

eJ8+IghvAQaQCAAEAAAAAAABAAEAAQeQBgAIAAAA5AQAAAAAAADoAAEJgAEAIQAAAEVBOUE5QUMx
MUQwQUU1NEVBNkE5NzI4NjkzMDU5RDFFAFMHAQ2ABAACAAAAAgACAAEFgAMADgAAAOcHCAAPAAoA
DAAXAAIANAEBIIADAA4AAADnBwgADwAKAAwAFwACADQBAQiABwAYAAAASVBNLk1pY3Jvc29mdCBN
YWlsLk5vdGUAMQgBBIABAD8AAABbUEFUQ0ggdjQgMS8xXSB3aWZpOiBtd2lmaWV4OiBhZGRlZCBj
b2RlIHRvIHN1cHBvcnQgaG9zdCBtbG1lLgDjFAELgAEAIQAAAEVBOUE5QUMxMUQwQUU1NEVBNkE5
NzI4NjkzMDU5RDFFAFMHAQOQBgCIZwAAWgAAAAIBfwABAAAAUQAAADxQQTRQUjA0TUI5NjM4MzhG
MTJCQURDMUI5RkQzNzdDQjdEMTE0QUBQQTRQUjA0TUI5NjM4LmV1cnByZDA0LnByb2Qub3V0bG9v
ay5jb20+AAAAAAsAHw4AAAAAAgEJEAEAAAB9OQAAeTkAADa1AABMWkZ1qF6f5mEACmZiaWQEAABj
Y8BwZzEyNTIA/gND8HRleHQB9wKkA+MCAARjaArAc2V0MCDvB20CgwBQEU0yCoAGtAKAln0KgAjI
OwliMTkOwL8JwxZyCjIWcQKAFWIqCbBzCfAEkGF0BbIOUANgc6JvAYAgRXgRwW4YMF0GUnYEkBe2
AhByAMB0fQhQbhoxECAFwAWgG2RkmiADUiAQIheyXHYIkOR3awuAZDUdUwTwB0ANF3AwCnEX8mJr
bWsGcwGQACAgQk1fQuBFR0lOfQr8AfEL8MAyIDEuIEYFsR9htHRpAiAgBGIccGkR8FB0LlxsC4Bl
CoAy2SGwVGgEABxwZRiACHDrGeAkAWEigHUfYBxwBbHwV1BBMyM2JcAhwCLwjG13CsAZ4GtleSTQ
+HBpIBoxAJAiYSGAJAFvGFAJgBxSBbF0I/kjNjS/I8IZ4AWgIrEkAQIgbCcw/wnwAaAecBxgAHAc
YBAgH2AHHFED8CkQIElXNDHqNiM2NSPPIA3hK7QlUs5vKRAbsiPwcHMjNiNFSFNpZxhQZC0ZMGaA
LWJ5OiBEYR1gBRxgTAuAIDx5dS0JEdBvLiNRQG54cNIuBaBtPiNFLTTAI0WUIC41cC8YUHQvA/A3
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
AB8AHwwBAAAAJgAAAHkAdQAtAGgAYQBvAC4AbABpAG4AQABuAHgAcAAuAGMAbwBtAAAAAAAfAB4M
AQAAAAoAAABTAE0AVABQAAAAAAACARkMAQAAAFwAAAAAAAAAgSsfpL6jEBmdbgDdAQ9UAgAAAIBE
AGEAdgBpAGQAIABMAGkAbgAAAFMATQBUAFAAAAB5AHUALQBoAGEAbwAuAGwAaQBuAEAAbgB4AHAA
LgBjAG8AbQAAAB8AAV0BAAAAJgAAAHkAdQAtAGgAYQBvAC4AbABpAG4AQABuAHgAcAAuAGMAbwBt
AAAAAAALAEA6AQAAAB8AGgABAAAAEgAAAEkAUABNAC4ATgBvAHQAZQAAAAAAAwDxPwQEAAALAEA6
AQAAAAMA/T/kBAAAAgELMAEAAAAQAAAA6pqawR0K5U6mqXKGkwWdHgMAFwABAAAAQAA5AIBdp/tg
z9kBQAAIMOflx/tgz9kBCwApAAAAAAAfANk/AQAAAAACAAAxAC4AIABGAG8AcgAgAHMAdABhAHQA
aQBvAG4AIABtAG8AZABlACAAZgBpAHIAcwB0AC4ADQAKADIALgAgAFQAaABpAHMAIABmAGUAYQB0
AHUAcgBlACAAaQBzACAAYQAgAG0AdQBzAHQAIABmAG8AcgAgAFcAUABBADMALgANAAoAMwAuACAA
RgBpAHIAbQB3AGEAcgBlACAAawBlAHkAIABhAHAAaQAgAHYAZQByAHMAaQBvAG4AIAAyACAAaQBz
ACAAbgBlAGUAZABlAGQAIABmAG8AcgAgAHQAaABpAHMAIABmAGUAYQB0AHUAcgBlAC4ADQAKADQA
LgAgAFQAaABlACAAYwBvAGQAZQAgAGkAcwAgAG8AbgBsAHkAIABlAG4AYQBiAGwAZQBkACAAYQBu
AGQAIAB0AGUAcwB0AGUAZAAgAHcAaQB0AGgAIABJAFcANAAxADYALgANAAoANQAuACAAVABoAGkA
cwAgAGYAZQBhAHQAdQByAGUAIABpAHMAIABkAGkAcwBhAGIAbABlAGQAIABmAG8AcgAgAG8AdABo
AGUAcgAgAGMAaABpAHAAcwAuAA0ACgANAAoAUwBpAGcAbgBlAGQALQBvAGYAZgAtAGIAeQA6ACAA
RABhAHYAaQBkACAATABpAG4AIAA8AHkAdQAtAGgAYQAAAAsAAIAIIAYAAAAAAMAAAAAAAABGAAAA
ABSFAAAAAAAAHwAAgIYDAgAAAAAAwAAAAAAAAEYBAAAAHgAAAGEAYwBjAGUAcAB0AGwAYQBuAGcA
dQBhAGcAZQAAAAAAAQAAABoAAAB6AGgALQBUAFcALAAgAGUAbgAtAFUAUwAAAAAAAwAAgAggBgAA
AAAAwAAAAAAAAEYBAAAAMgAAAEUAeABjAGgAYQBuAGcAZQBBAHAAcABsAGkAYwBhAHQAaQBvAG4A
RgBsAGEAZwBzAAAAAAAgAAAASAAAgAggBgAAAAAAwAAAAAAAAEYBAAAAIgAAAE4AZQB0AHcAbwBy
AGsATQBlAHMAcwBhAGcAZQBJAGQAAAAAAOuPUNE3zgBI1UwI2514HkcfAACAE4/yQfSDFEGlhO7b
WmsL/wEAAAAWAAAAQwBsAGkAZQBuAHQASQBuAGYAbwAAAAAAAQAAACoAAABDAGwAaQBlAG4AdAA9
AE0AUwBFAHgAYwBoAGEAbgBnAGUAUgBQAEMAAAAAAB8A+j8BAAAAFAAAAEQAYQB2AGkAZAAgAEwA
aQBuAAAAHwA3AAEAAAB+AAAAWwBQAEEAVABDAEgAIAB2ADQAIAAxAC8AMQBdACAAdwBpAGYAaQA6
ACAAbQB3AGkAZgBpAGUAeAA6ACAAYQBkAGQAZQBkACAAYwBvAGQAZQAgAHQAbwAgAHMAdQBwAHAA
bwByAHQAIABoAG8AcwB0ACAAbQBsAG0AZQAuAAAAAAAfAD0AAQAAAAIAAAAAAAAAAwA2AAAAAAAC
AXEAAQAAABYAAAAB2c9g+V1uy7qv4I5BgbA3zyP19YRKAAAfAHAAAQAAAH4AAABbAFAAQQBUAEMA
SAAgAHYANAAgADEALwAxAF0AIAB3AGkAZgBpADoAIABtAHcAaQBmAGkAZQB4ADoAIABhAGQAZABl
AGQAIABjAG8AZABlACAAdABvACAAcwB1AHAAcABvAHIAdAAgAGgAbwBzAHQAIABtAGwAbQBlAC4A
AAAAAB8ANRABAAAAogAAADwAUABBADQAUABSADAANABNAEIAOQA2ADMAOAAzADgARgAxADIAQgBB
AEQAQwAxAEIAOQBGAEQAMwA3ADcAQwBCADcARAAxADEANABBAEAAUABBADQAUABSADAANABNAEIA
OQA2ADMAOAAuAGUAdQByAHAAcgBkADAANAAuAHAAcgBvAGQALgBvAHUAdABsAG8AbwBrAC4AYwBv
AG0APgAAAAAAAwDeP59OAAADABMSAAAAAAIBAIATj/JB9IMUQaWE7ttaawv/AQAAAC4AAABIAGUA
YQBkAGUAcgBCAG8AZAB5AEYAcgBhAGcAbQBlAG4AdABMAGkAcwB0AAAAAAABAAAAIgAAAAEACgAA
AAQAAAAAAAAAFAAAAAAAAAAAAAAA/////wAAAAAAAAsAAIATj/JB9IMUQaWE7ttaawv/AQAAABwA
AABIAGEAcwBRAHUAbwB0AGUAZABUAGUAeAB0AAAAAAAAAAsAAIATj/JB9IMUQaWE7ttaawv/AQAA
ACgAAABJAHMAUQB1AG8AdABlAGQAVABlAHgAdABDAGgAYQBuAGcAZQBkAAAAAAAAAEAABzC0Hyz6
YM/ZAQIBCwABAAAAEAAAAOqamsEdCuVOpqlyhpMFnR4DACYAAAAAAAsABgwAAAAAAgEQMAEAAABG
AAAAAAAAAMilJbGII5JKg6pkkAqkqyoHAE8+IND8Jt1ErmEHWjoK3ScAAAAAAQsAAE8+IND8Jt1E
rmEHWjoK3ScAAiEalPYAAAAAAgETMAEAAAAQAAAAbsu6r+COQYGwN88j9fWESgIBFDABAAAADAAA
ALYJAACYjt8SMQAAAAMAWzMBAAAAAwBaNgAAAAADAGg2DQAAAAsA+jYBAAAAHwD4PwEAAAAUAAAA
RABhAHYAaQBkACAATABpAG4AAAAfACJAAQAAAAYAAABFAFgAAAAAAB8AI0ABAAAA/AAAAC8ATwA9
AEUAWABDAEgAQQBOAEcARQBMAEEAQgBTAC8ATwBVAD0ARQBYAEMASABBAE4ARwBFACAAQQBEAE0A
SQBOAEkAUwBUAFIAQQBUAEkAVgBFACAARwBSAE8AVQBQACAAKABGAFkARABJAEIATwBIAEYAMgAz
AFMAUABEAEwAVAApAC8AQwBOAD0AUgBFAEMASQBQAEkARQBOAFQAUwAvAEMATgA9AEMAQgAwADQA
RgA2ADUAOQAxAEEARAA2ADQANAA2AEIAOABBAEEAQgBDADkAQgA2ADUARABBAEUAOQAyADAANwAt
AE4AWABGADUANwA2ADIANAAAAB8AJEABAAAABgAAAEUAWAAAAAAAHwAlQAEAAAD8AAAALwBPAD0A
RQBYAEMASABBAE4ARwBFAEwAQQBCAFMALwBPAFUAPQBFAFgAQwBIAEEATgBHAEUAIABBAEQATQBJ
AE4ASQBTAFQAUgBBAFQASQBWAEUAIABHAFIATwBVAFAAIAAoAEYAWQBEAEkAQgBPAEgARgAyADMA
UwBQAEQATABUACkALwBDAE4APQBSAEUAQwBJAFAASQBFAE4AVABTAC8AQwBOAD0AQwBCADAANABG
ADYANQA5ADEAQQBEADYANAA0ADYAQgA4AEEAQQBCAEMAOQBCADYANQBEAEEARQA5ADIAMAA3AC0A
TgBYAEYANQA3ADYAMgA0AAAAHwAwQAEAAAAUAAAARABhAHYAaQBkACAATABpAG4AAAAfADFAAQAA
ABQAAABEAGEAdgBpAGQAIABMAGkAbgAAAB8AOEABAAAAFAAAAEQAYQB2AGkAZAAgAEwAaQBuAAAA
HwA5QAEAAAAUAAAARABhAHYAaQBkACAATABpAG4AAAADAFlAAAAAAAMAWkAAAAAAAwA3UAEAAAAD
AAlZAQAAAB8ACl0BAAAAJgAAAHkAdQAtAGgAYQBvAC4AbABpAG4AQABuAHgAcAAuAGMAbwBtAAAA
AAAfAAtdAQAAACYAAAB5AHUALQBoAGEAbwAuAGwAaQBuAEAAbgB4AHAALgBjAG8AbQAAAAAAAgEV
XQEAAAASAAAAAtOhbmgrvG9MqSzZnFwwFjUBAAACARZdAQAAABIAAAAC06FuaCu8b0ypLNmcXDAW
NQEAAAMAAIBQ42MLzJzQEbzbAIBfzM4EAQAAACQAAABJAG4AZABlAHgAaQBuAGcARQByAHIAbwBy
AEMAbwBkAGUAAAAbAAAAHwAAgFDjYwvMnNARvNsAgF/MzgQBAAAAKgAAAEkAbgBkAGUAeABpAG4A
ZwBFAHIAcgBvAHIATQBlAHMAcwBhAGcAZQAAAAAAAQAAAHAAAABJAG4AZABlAHgAaQBuAGcAIABQ
AGUAbgBkAGkAbgBnACAAdwBoAGkAbABlACAAQgBpAGcARgB1AG4AbgBlAGwAUABPAEkASQBzAFUA
cABUAG8ARABhAHQAZQAgAGkAcwAgAGYAYQBsAHMAZQAuAAAACwAAgFDjYwvMnNARvNsAgF/MzgQB
AAAAJgAAAEkAcwBQAGUAcgBtAGEAbgBlAG4AdABGAGEAaQBsAHUAcgBlAAAAAAAAAAAAHwAAgB+k
6zOoei5Cvnt54amOVLMBAAAAOAAAAEMAbwBuAHYAZQByAHMAYQB0AGkAbwBuAEkAbgBkAGUAeABU
AHIAYQBjAGsAaQBuAGcARQB4AAAAAQAAAC4BAABJAEkAPQBbAEMASQBEAD0AYQBmAGIAYQBjAGIA
NgBlAC0AOABlAGUAMAAtADgAMQA0ADEALQBiADAAMwA3AC0AYwBmADIAMwBmADUAZgA1ADgANAA0
AGEAOwBJAEQAWABIAEUAQQBEAD0ARAA5AEMARgA2ADAARgA5ADUARAA7AEkARABYAEMATwBVAE4A
VAA9ADEAXQA7AFQARgBSAD0ATgBvAHQARgBvAHIAawBpAG4AZwA7AFYAZQByAHMAaQBvAG4APQBW
AGUAcgBzAGkAbwBuACAAMQA1AC4AMgAwACAAKABCAHUAaQBsAGQAIAA2ADYANwA4AC4AMAApACwA
IABTAHQAYQBnAGUAPQBIADQAOwBVAFAAPQAxADAAOwBEAFAAPQAxAEMAMQAAAAAAQAAAgAggBgAA
AAAAwAAAAAAAAEYAAAAAv4UAAHC3X/lgz9kBCwAAgAggBgAAAAAAwAAAAAAAAEYAAAAAgoUAAAAA
AAACAQCACCAGAAAAAADAAAAAAAAARgEAAAA2AAAASQBuAFQAcgBhAG4AcwBpAHQATQBlAHMAcwBh
AGcAZQBDAG8AcgByAGUAbABhAHQAbwByAAAAAAABAAAAEAAAANOCznJMrs9Lhjej79Ni00kDAA00
/T8AAB8AAICGAwIAAAAAAMAAAAAAAABGAQAAAC4AAABhAHUAdABoAGUAbgB0AGkAYwBhAHQAaQBv
AG4ALQByAGUAcwB1AGwAdABzAAAAAAABAAAAsgAAAGQAawBpAG0APQBuAG8AbgBlACAAKABtAGUA
cwBzAGEAZwBlACAAbgBvAHQAIABzAGkAZwBuAGUAZAApACAAaABlAGEAZABlAHIALgBkAD0AbgBv
AG4AZQA7AGQAbQBhAHIAYwA9AG4AbwBuAGUAIABhAGMAdABpAG8AbgA9AG4AbwBuAGUAIABoAGUA
YQBkAGUAcgAuAGYAcgBvAG0APQBuAHgAcAAuAGMAbwBtADsAAAAAAB8AAICGAwIAAAAAAMAAAAAA
AABGAQAAACAAAAB4AC0AbQBzAC0AaABhAHMALQBhAHQAdABhAGMAaAAAAAEAAAACAAAAAAAAAB8A
AICGAwIAAAAAAMAAAAAAAABGAQAAAC4AAAB4AC0AbQBzAC0AcAB1AGIAbABpAGMAdAByAGEAZgBm
AGkAYwB0AHkAcABlAAAAAAABAAAADAAAAEUAbQBhAGkAbAAAAB8AAICGAwIAAAAAAMAAAAAAAABG
AQAAADYAAAB4AC0AbQBzAC0AdAByAGEAZgBmAGkAYwB0AHkAcABlAGQAaQBhAGcAbgBvAHMAdABp
AGMAAAAAAAEAAABIAAAAUABBADQAUABSADAANABNAEIAOQA2ADMAOAA6AEUARQBfAHwAQQBNADAA
UABSADAANABNAEIANwAxADUANgA6AEUARQBfAAAAHwAAgIYDAgAAAAAAwAAAAAAAAEYBAAAAUAAA
AHgALQBtAHMALQBvAGYAZgBpAGMAZQAzADYANQAtAGYAaQBsAHQAZQByAGkAbgBnAC0AYwBvAHIA
cgBlAGwAYQB0AGkAbwBuAC0AaQBkAAAAAQAAAEoAAABkADEANQAwADgAZgBlAGIALQBjAGUAMwA3
AC0ANAA4ADAAMAAtAGQANQA0AGMALQAwADgAZABiADkAZAA3ADgAMQBlADQANwAAAAAAHwAAgIYD
AgAAAAAAwAAAAAAAAEYBAAAAOAAAAHgALQBtAHMALQBlAHgAYwBoAGEAbgBnAGUALQBzAGUAbgBk
AGUAcgBhAGQAYwBoAGUAYwBrAAAAAQAAAAQAAAAxAAAAHwAAgIYDAgAAAAAAwAAAAAAAAEYBAAAA
OgAAAHgALQBtAHMALQBlAHgAYwBoAGEAbgBnAGUALQBhAG4AdABpAHMAcABhAG0ALQByAGUAbABh
AHkAAAAAAAEAAAAEAAAAMAAAAB8AAICGAwIAAAAAAMAAAAAAAABGAQAAACoAAAB4AC0AbQBpAGMA
cgBvAHMAbwBmAHQALQBhAG4AdABpAHMAcABhAG0AAAAAAAEAAAAOAAAAQgBDAEwAOgAwADsAAAAA
AB8AAICGAwIAAAAAAMAAAAAAAABGAQAAAEQAAAB4AC0AbQBpAGMAcgBvAHMAbwBmAHQALQBhAG4A
dABpAHMAcABhAG0ALQBtAGUAcwBzAGEAZwBlAC0AaQBuAGYAbwAAAAEAAAACBQAAWgBmAFUAMwBt
AC8AdgBKAFEAOABFAG0ASAA1ADYAagBIAGcAagAyAFIATwA3AGcATwBMAGoANwBLAEkAaAA5AGMA
UgA4AFUAbABzAHgALwA3AFcAcAA0AEcARAAwADkAMQBhAFQAMQBmAC8ARgA2ADAAQgBVAGYAbgBW
AFkANwA2AG8AOABwAFIAZwBzAGoARwBUAEoANgBEAC8AUgBjAG8AZgBLAFgAOQB3AHgAYgBYAGcA
YwA3AFoAYQBLAEEAcQB1ADEAYgB1AFcAZABWADAAdwA1AG4AYgBNAHAAZwArAFUAMwBVAFcASwBj
AFcATwAxAEcAUwB2AFMAcwBXAEEAQQBUADUAegBoAHcAZABjACsALwBVAG8ATgBVAHIAVwB4AEoA
VwBsADQANABaAEIAQQBFAHIAeQBFAFEAbQBHADUAbwBSAE0AcAB5AHAARQB2AFkARABwAEoANwAr
AEcAQQB1AFUARwBEAEsAZgBjAHkAaQAzAHQAZABCAFUAOQBFADgAVgBnAGcAOQBNAFoAZgBBADQA
YgBBAHEAMQAxAEMAdgBDAGQAawA1ADcAdwBoADEAegBZAHgANgBDAFgATQBjAEMAaQBMAEQARABs
AEwAdABRAEYATgBsAGoAUQBPAFoAUgBjAHkAcQBIAFMARwBXAEoAagB0AHkAZwBuAEkAMwB1AFAA
bwBkAFkAbABqAG4ATABCAFoAYgBCAGQAYgBiADEAYgBaAGwASgA2AEkAcABpAGkAWQBEAFoAUQBW
AEYAMwByAHQAUwBGAFIAaQB6ADIANgByAFQAcwBVAEsARABLAE0ASABiADQAZQBZAEIAKwBrAGQA
RABtAFEAagBOAEoAMAAvAFoAUgBUAFEAaQBjAE4ANwBOAFUAWgBCADAAWQBuADQARgB4AE8AbwBL
AEEAZwBOAEMAYQBTADIASAA1AFkAQwBIAFAATwBuAGYARwBoAFkAcQBWAGoAbgBzAGIAbwAvAHIA
SABBADYASABtAE0AeQB6AHQAawBGAHgAcQBrAGUAMwBMAHIAUwBVAHcAWgB2AEYAawBuAEMAaAA0
AHkAWAAzADgAWABMAEcAZgBKADYAVgBiAC8AcAA2AFIAMAA4AGYAZgBSAEsARwBNADEAOAB0AFgA
eQA1AEMASABMAHgARABLAHUAbQBYAEwAYQBiAGwARABIAFEAUwBkAEcAYwBtAGcALwBZAFQAZwBu
AHMAcgBZAGgAaQBNAFEANQBFAGEAcwBRAEQATQBOAGYAMgBBAGUANgB5AFUAZABLAGYAeQAvAE8A
RQBiAFEAUABJAG0ASABXAFcARgBHAGIAdQBQAFUASAB1AFIAcQB2AHoASAA3AEMAcgByADUALwBJ
ADcAWAB1AHkAbwBtAFIAVwA0AFgANABYAGwATQA2ADkAVAB6AEEAVQBKAGMASgByAHoAMQBWAHgA
eQByAHkAbABlAEIAcwAxAFYAdAAyAFMARgB0AG8AMQB5AHMAUgBDAEEAdwBsAGQASABGAFYAbABw
AEIAWQBDAEMAYgBWAEkAaAAxAFQASwBpAGIAMgBZADcATwBWAGsAZwBYADkATABWADAAbwBCACsA
awBoAFcAbABuAFgAUwBRAFEASgAxAG0AZABLAGsAYwAxAFUAegBSAEwAVAByACsAZgBHAG8ARABo
AHcAWgAxAE8ASwA4AEYAeQAAAAAAHwAAgIYDAgAAAAAAwAAAAAAAAEYBAAAAOAAAAHgALQBmAG8A
cgBlAGYAcgBvAG4AdAAtAGEAbgB0AGkAcwBwAGEAbQAtAHIAZQBwAG8AcgB0AAAAAQAAAG4EAABD
AEkAUAA6ADIANQA1AC4AMgA1ADUALgAyADUANQAuADIANQA1ADsAQwBUAFIAWQA6ADsATABBAE4A
RwA6AGUAbgA7AFMAQwBMADoAMQA7AFMAUgBWADoAOwBJAFAAVgA6AE4ATABJADsAUwBGAFYAOgBO
AFMAUABNADsASAA6AFAAQQA0AFAAUgAwADQATQBCADkANgAzADgALgBlAHUAcgBwAHIAZAAwADQA
LgBwAHIAbwBkAC4AbwB1AHQAbABvAG8AawAuAGMAbwBtADsAUABUAFIAOgA7AEMAQQBUADoATgBP
AE4ARQA7AFMARgBTADoAKAAxADMAMgAzADAAMAAyADgAKQAoADMANAA2ADAAMAAyACkAKAAzADYA
NgAwADAANAApACgAMwA5ADYAMAAwADMAKQAoADMANwA2ADAAMAAyACkAKAAzADkAOAA2ADAANAAw
ADAAMAAwADIAKQAoADEAMwA2ADAAMAAzACkAKAAxADgANgAwADAANgApACgAMQA4ADAAMAA3ADkA
OQAwADAANgApACgANAA1ADEAMQA5ADkAMAAyADEAKQAoADYANgA4ADkAOQAwADIAMQApACgANwA2
ADkANgAwADAANQApACgAOQA2ADgANgAwADAAMwApACgANwAxADIAMAAwADQAMAAwADAAMAAxACkA
KAAzADMANgA1ADYAMAAwADIAKQAoADgANgAzADYAMgAwADAAMQApACgAMwA4ADEAMAAwADcAMAAw
ADAAMAAyACkAKAAxADIAMgAwADAAMAAwADAAMQApACgAOAAzADMAOAAwADQAMAAwADAAMAAxACkA
KAAzADgAMAA3ADAANwAwADAAMAAwADUAKQAoADYANQAwADYAMAAwADcAKQAoADIANgAwADAANQAp
ACgANQAyADUAMwA2ADAAMQA0ACkAKAAzADAAOAA2ADQAMAAwADMAKQAoADIAOQAwADYAMAAwADIA
KQAoADUANQAwADEANgAwADAAMwApACgANQA0ADkAMAA2ADAAMAAzACkAKAA0ADcAOAA2ADAAMAAw
ADAAMQApACgANAAxADMAMAAwADcAMAAwADAAMAAxACkAKAA2ADYAOQA0ADYAMAAwADcAKQAoADgA
OQAzADYAMAAwADIAKQAoADYANgA0ADcANgAwADAANwApACgAOAA2ADcANgAwADAAMgApACgANgA2
ADUANQA2ADAAMAA4ACkAKAA2ADYANAA0ADYAMAAwADgAKQAoADUANgA2ADAAMwAwADAAMAAwADIA
KQAoADYANAA3ADUANgAwADAAOAApACgANwA2ADEAMQA2ADAAMAA2ACkAKAA2ADkAMQA2ADAAMAA5
ACkAKAA0ADMAMgA2ADAAMAA4ACkAKAAzADEANgAwADAAMgApACgANQA1ADkAMAAwADEAKQAoADUA
NwA5ADAAMAA0ACkAOwBEAEkAUgA6AE8AVQBUADsAUwBGAFAAOgAxADEAMAAxADsAAAAAAB8AAICG
AwIAAAAAAMAAAAAAAABGAQAAAFwAAAB4AC0AbQBzAC0AZQB4AGMAaABhAG4AZwBlAC0AYQBuAHQA
aQBzAHAAYQBtAC0AbQBlAHMAcwBhAGcAZQBkAGEAdABhAC0AYwBoAHUAbgBrAGMAbwB1AG4AdAAA
AAEAAAAEAAAAMQAAAB8AAICGAwIAAAAAAMAAAAAAAABGAQAAAEoAAAB4AC0AbQBzAC0AZQB4AGMA
aABhAG4AZwBlAC0AYQBuAHQAaQBzAHAAYQBtAC0AbQBlAHMAcwBhAGcAZQBkAGEAdABhAC0AMAAA
AAAAAQAAAIIMAABPAFMASwBmAFcAMwBMAGYAbgAzADQAagBRAEMANwBVAG8AUwBJAHIAYQA5AE8A
aQAvADEAQQBLADMAVwBvAHEAMQBlADEAegAwAEoANQBvAEwANwBCADgAeABkAHUAQQBSAHcAawBV
AHkAcAAxAHcAdAAvAFIAWQBwAHkANwAyAHIAeABsADUARQBsAHMANwBYAFgAbgAwAC8AawA4AEcA
bgA0AFUASABHADEATgA2ADgAVQA4ADAAaQBNADcARABPAGQANQAvAEYAawAzADEAdAArAEUAawB3
AGoASQBSAFkARwBYAGoAeQBvAGwAbgBPADQARQBIAFIAdQBGAGsAZgBYAEkAZwBMAE4AZQA1AG8A
dABPAE4AWAAxAEMAWQAzAEEARgBsAEwAZQA1AGwASwA5AGoAUAA3AEcAUABwAHYAWgBQAEYANgBv
ACsATABxAFMAQgBTAG4ARABJAGUAOQAzAFQAbAByAC8AaQA3AE4AUQB3AGgAQwBpAGwASwBRAEEA
UwBoAEgAUgBMAFoAVwBaAEIARQBoADgAMwBvAHYAbwB3AFgANABMAGkAaQAzAHIAWABSAHMARgBz
AEIAbQBIAGQAYgB6AGUAOABYAGcAdQBvAE8ASQB4AFgAcABUAE4AMwBCAEEAYwBiAFYAMgBrADAA
UgBnAHcASQB4AGwAawBNAE0AcQA1AHoASQBYAEEAWgBCAEIAQQBlAGoALwBkAGgASAAxADEAZgBG
AFYARwBlAHMAbQBLAFAAMwBwAG8ARQBWAE0ASgB4AGgATABnADgAbgBRAGoANABxAEQAZQBOAGgA
KwArAFgAaABnADUAcgBUAHgAUgBBAGoAMwBZAHQAOABtADEAaAByAEUATgAyAHcARgBCAGkASQBL
ADkAMgBHAFcALwAwADgAMgBqACsAMABCAGoAeQA2AGUAaQA2ADcAeQBiAGQAOQBOADkATgBBAGQA
TwA5AEUAWABZAEwASwBvAFgAeQA4ACsARwB5AG8AbwB2AHYAYgBXAFkAVQBYACsARABzAFgANABE
AFkAdAAyAGYASwBTAFMANQBIAG4AZgAwAHgAeAB3AHgARgByAG0AbABLAEcAWABDAHYAVgArAHQA
TABqAHcAeABsAEwAagBTAHoAdwBmAGEAbQBIAHYAbABOAFgAcgBKAFMAbwBsAEwANgBUAEwAcgB4
AGIAQwB3AEIAUgBEAHkAUQBVAHEAMgBtAEEAbQBFADAAQwBTAFoAWQBCAEYAcQBQAHcAWAA3AFoA
YQBCAHMAVABrAGQAZABiAC8AdwAwAFUAVABkAHYASwBmAGgATgBQAGEARgBuAHQAaQBrAHUAOABN
AGMAMQBFAG4AZgB4AEkANABhAGoAWAB1ADYATwB4AG0AeQBoAFEAYQBPAC8AUgBhAGgATQBiAEcA
NgBzAEoAdwBXAHUAcQA3AFMAMABXAEgAOQBsAHYAQQB1AHYAOABSAEIAdABPAFMAcQA2AEIAawB6
ADUASABZAEgAOQBCAEcAQwBvAEcAMABOAHYARwBEAGYAbQB4AEYASAB4AHYAdQArAE4AYQBkAG8A
ZQBNAHEAUwBtAHcAeQBiADgATABjACsAcwB3ADcAbwBJAHkARQBiAE4AUQArAFgAbABPAHMARQBo
AHQAVwBsAGwAdABVAG4AYwBpAGQAQwBCADcALwBxAEwAbABaAG8ASgBVAE4ANwBRAFkAbABuAEgA
YgBtADQATQBJAE0AVABSAEYAcQBZAGQAbAB2ADgAbgAwAEwAMAA4AFMAUgBOAHIAKwBTAGgAdQBR
AHgAMgBGAFUATgBXAFkAcQA1AGcAcgBXADIAVwB5AFAAZABXAC8AKwAxAGEAeABjAGcAMABTAE8A
TABxAGQAVQArAEoAcwA3AG8ALwBTAEcATgBUADAAeQA5AGsASQBPAFMAcgBJAFQARwBEAGkAZQAz
AFMAdABEAHAAWgBNADYAZAA5ADEAdgA3ADAAegBVAG0AcwBVAGIAQQBvAEgAaAB5AGMAYwBTAEYA
MAA4AFMAVABiAEgAawBoAEoASwAwAEEAaAArAFUATAB0AFcAQgBEAGoAaAB5AG8ATwBHAC8AcwB3
AHMAUAB4ADAAZQBwAEkASQB0AGgAeABWAEYAdABCAGwASgBTAEcAbgAxAGkAQgBsAHMAbwBOAHMA
RwBHADgASQBLADEARwBWAEEAdAB4AGcAaABWAEMAMgBBADUARwBQAFUAZgB2AHMAOABIADEAdgBp
ADMAWgBXADIARwBNAEkAYgA0ADMAdwBBAEYANwAvAEsAUwBIADYAaQBKAFIAYQBkAEcAdgBTAGMA
NgBHAEQAZwA1AGUAWAA5AGEAcABuAHoAbwBPAHcAbQBwAEQAMABSAGIAKwBaAEsAawA5AEwAQQBQ
AHIATQBqAEgAdQA2AGgAZwA0AGQAVwBUAGEAMABsAHEANgAvAC8AWABsAFYAeABQAFIAVQB1AEEA
NgBTAHIANAA1AFUAWQBWAHkAMAA4AGwAdgBQAHIAMABSAFUARAA2AFMAMQBBADcASABpAEUASgBV
AHMAVABNAG8AVgBGAHYAawB1AHcAMgBOAEsAcwB0AHMAdwBYAGgAbwB1AHMATAAyAGgATwBhADUA
OABsAG4AaQAwAFQAOQBkAG4AcQBoAE8AbgBuADcAcABDAEwAcgBoAHIAegBpAFYARABRAFkAOQBs
AGkAMgBjAFAAZQArAGwAdABSAHkAYwBRACsAdgB3AFMAWQBYADAARABhADgAegB5AE4AZABWAGYA
WQB1AFAAUABpAGEAVgBXAGoAZwBOAHoAeQBNADMAMABvADUAKwBTAFYAMAB5AGgASwB1AGsAQgBk
ADEAVABNAHoAYQBRAFIATAB3ADgAZAB6AFQAbwBqAFgASABjAHoARgBMAFYAMwAxAEcAOQB5AGwA
WABjADkAegB3AHUARQBNAEoATQBDAGEAVAB0AEQAcwBqAHMANgBLAEcAawBTAFEAbwA4ADAAWgBL
AE8AQQBvAGUASABmAGEANgBjAHIAdwBQADYAcwBBADkAZwBjAGUAaABKAGMAcQBEAGMARQBQAE8A
KwA4AFEASABjAHcAUQA5AFEANAB1AGgAZQBmADkANABmAEIATQBLAEwAeABnAG0AYgBPAHUAcgBx
AGEARgBLAHMAdABEAFQAQgBXAHkAMQA2AC8AcwB1AGoALwBKAG0ASAAyAGEAZgBWAEQARAA2AGcA
ZwBZAEMAegBtAEIATwBYAFQATAB3ADcATwBGAEQAKwBLAFIAUgBsAG0AeQBQAGYAQwB6AE4ARQBm
AHEAdwA5ADYAZgBmAGoAMwBOAEkAUABMAG0AbwBoAFoAawBuADEAKwAyAFkAWQB3AGYAcQBSADIA
YQAwAGcAQwBYAGcAeQA2AFYAVABHADgAUQBzAHQAcQBPAGQAagAvAG0AYgBxADAAbwBxAFkANwBW
AHkAcABLAFgARAA0AFgAcwBWADYANABXAEwAbgBZAGIAVABpAHQAVwBrACsANQBoAGEASgBHADUA
LwBBAFgAKwA2AG8AcABkAHUATAB1ADQAdQBFADgAVwBhADMAZwBsAHMANAA5ADQAagBIAFYAOABR
AE0AKwBPAFUALwBXAGUAQQBOAFAANwBpAGwAVwBmAGEAaQBjAFUAbwBrAEwAdwBwAHYAOQBzADIA
RAByAEgAUQBhAEUAbABYAEcAVABJAGYARABKAEkARwBHAEcAdwBTAFEANwBDAHkAawBHAC8AbABI
AFYAMgBCAEoAbwBxAGEAWABaAEIAbwBpAGoAcQA4AEwAZgAwAE8AZQB2ACsAKwBKAEwAbQBzAEgA
TgBWAGsAMQBTAFIANQBpAHgAbgBEAEEANgA1AEYAYgBxADQASABRAHQANgBMAGsARQBoAEsAOABo
AFkAeQAxAEwAdAAvAFcAbgBaADYATABIADgAWQBSAEQANwBCADMAaQA4AEkAeQA1AEQAbwBhAHAA
dgBMAEUAKwA0AEYAdgA1ADkAbgA2AEsATgB6AHcASABpAFQAWQBkAFIAVwBvAGkAQgBiAHAAWABO
AHcASwBpADcAWQBoAG0ARwBoAEMAVAB1AGsAQgAxAHkAawBSAEsARwBEAHYAQQBPADAAdABvADAA
bABNADYAdABjAEkAUwBwAGUAeABnAEcATABHAEYATABnAFMAVwAzAEgAQgBqADYAagBnAGcAcwBU
ADUANABMAFUAagBLAEIAagBRAAAAAAADiw==

--_000_PA4PR04MB963838F12BADC1B9FD377CB7D114APA4PR04MB9638eurp_--

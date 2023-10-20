Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 323337D071E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 05:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376291AbjJTDsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 23:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346903AbjJTDsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 23:48:19 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2050.outbound.protection.outlook.com [40.107.21.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4229E8;
        Thu, 19 Oct 2023 20:48:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lWQH7qz8MFwBEqPpF1PLeMvVWb8rcYXnaL+Mv00f/j8LqM3RnHei8C5TVdlr/dx4Y5N9dfY/iVlOjUVEhjismBD1YdFSt1pi0LrUFrtXwgNhdLB/2kZVptCO9MolaNkT58POEr44Wyb7LjcTYT3FZFrOCmoFy6NPHUWopF92kVw5DGGGhxBeJb1wxkQBD5VP0vT8jkRQuBta65Vr3EDtm5YhZm7eYKy7KfJ8H+H8jG8XJZU6qBE6uT9OxNW4ds7qLUzmOuCcK4ylC9LCwxbIINlAPXBn8iSRdKbBhac8u59Rt2aztrMLyLBMoJh0mdp/FtId0Ptwl+dj+88otpX4qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wL1IhBpw0yNmBAU1xmDYS5FXFTsz2zjurwEpQ9GmpQQ=;
 b=DtbUpNoZ/SS+/QmiaX5AitmeBDBHHdMPZy47Yhv1WOSu+EgwE52feQzvzGuifyYxSaqLtNm1LuHwTr9Hxxv4NRWXf1iONo1l1/LSihttc4beodgQu/trM7FRWtoZa7aBkD56xK/XYBBqvZggo4oVu11Lr/yrBNJ7qMpcLP6y+sVKErsnmmhOKqQkAxfj/+o/g/mTcPIx0aC5M66ni8ogN1Xq0EeWA11R6+xHSOQED5WTe0kfOUDVtINqisQx3XxrSX08PYdIk5xcqpjVbrFobfGpOpqrrO22qb3EFxRsn0uQGrFXS3u/0dSXuVzawBZlo6cvW2TNmZwmYroQBVvxzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wL1IhBpw0yNmBAU1xmDYS5FXFTsz2zjurwEpQ9GmpQQ=;
 b=fj1fS5a0YcIgyOY+zgb0MaFBifrWGKlOFdRYL9X4REqm6m60L0U/9eU4zUvvJln4KUk1ogsx9dGd9vHtjK8QnWQVxrVYbD8f7pvg0TvLOwOdKlVNUkQYMB9St7x7Vb+lWJdjjv6djv8Ef+uI2Z0KhLjFIWn0IVqLgZa6HZool2M=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by VI1PR04MB7069.eurprd04.prod.outlook.com (2603:10a6:800:127::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.11; Fri, 20 Oct
 2023 03:48:11 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b%7]) with mapi id 15.20.6933.011; Fri, 20 Oct 2023
 03:48:11 +0000
Content-Type: multipart/mixed;
        boundary="_000_PA4PR04MB9638DEFC074F41AAEE3AC471D1DBAPA4PR04MB9638eurp_"
From:   David Lin <yu-hao.lin@nxp.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "briannorris@chromium.org" <briannorris@chromium.org>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "francesco@dolcini.it" <francesco@dolcini.it>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        David Lin <yu-hao.lin@nxp.com>,
        Pete Hsieh <tsung-hsien.hsieh@nxp.com>
Subject: [PATCH v6 1/6] wifi: mwifiex: added code to support host mlme.
Thread-Topic: [PATCH v6 1/6] wifi: mwifiex: added code to support host mlme.
Thread-Index: AdoDCD3HfqdGXSjhR7u7/u1lbWxIUw==
Date:   Fri, 20 Oct 2023 03:48:11 +0000
Message-ID: <PA4PR04MB9638DEFC074F41AAEE3AC471D1DBA@PA4PR04MB9638.eurprd04.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: <PA4PR04MB9638DEFC074F41AAEE3AC471D1DBA@PA4PR04MB9638.eurprd04.prod.outlook.com>
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|VI1PR04MB7069:EE_
x-ms-office365-filtering-correlation-id: 27b5cce3-d470-41e7-481b-08dbd11f61a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0gMzFd5i+wS9pEhVGmDMlDtbuyM9Je8/7pNKNnrYMnRyiWBzkcvY40zapojz0f/x8YJSzcrTn6uC1Q8iHjaxnsU8XzOU2WPfvP8t3dqiOvCWiEm42Gk3DaQovQuBt5ZeCF4GamQJi3e2IxF7FcyuABTSQ8HQbBImseZeZ4Rdl4mwH3LIHq7mOvdTN7nfA/Aq0lQ3ZIUwfxUw6BW0thOQOuyBEApOGmumKY1CJMk9gmAKfIOnuNFbEpsw+sjcPjEnWzbHW7Nqo/nWZN1f405QclDTiidq2jSYaMz4CbbprWvkbLQ4TQNXWuH96keQE7FEZgKXggrTR+I/iQhjnxNqazBmzHfUvyfFn40qQoPw0xT6F4Z8Pvk2W3+dN/jtIr/S4PMlCAbGSxP5mV58JxXVRAVlTdNQoVqSPCvCM9Fhcy2N8DaKs9epHbfb29UD5z3yv57kKL0cMk9xYUuuagwpMSISKAdC15lQPZJ0C9q3KgGnj7oTILDP2ggXew2qr4ZS8Wj2iOuwDui2mZGspRwVSCeluNcKUzI372lnG3eBKf4n4OuP6P/uLDZVq+BRz0bB2ZvJTH92VrNPbeaZIUuprN9ojtrtdYzPaTqZxyVgJ8JXW4kmkjXt+/ton5/0vvP/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(376002)(39860400002)(346002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(30864003)(55016003)(38100700002)(66899024)(41300700001)(4326008)(5660300002)(8676002)(8936002)(52536014)(86362001)(33656002)(2906002)(122000001)(478600001)(83380400001)(9686003)(7696005)(26005)(71200400001)(6506007)(316002)(38070700009)(66946007)(76116006)(54906003)(66476007)(6916009)(66446008)(64756008)(66556008)(579004)(559001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WcsDhMRMtPNrtryLRk4cbe4TKNXeYZIZUrCnla3rA60fTMGoiqb2dTaKOjqV?=
 =?us-ascii?Q?2wQnQvg+AxLM3Bey24UiDNNMKmPyT5ANjznhZgn6VoQzfWQVl7PNnY4lhFp9?=
 =?us-ascii?Q?QYtR/pdgCl5niYRAz5/jg8mfe+Lk6bymipWOwh8btJx5NeDEX4HGO86qU9aE?=
 =?us-ascii?Q?2BnaNjEGDUOT+46sUZ2diPRFF9AR6BAJ3m/NUAbzxdkZ190R7NdxXRocfQMr?=
 =?us-ascii?Q?efR6b4PoJo0bdliuZizLUVSigCSk94gAWyOsfw+6CaeOAPii+7JpbCbLa6zK?=
 =?us-ascii?Q?so8sjwsqsHDlWbxTI+qed6hDg+LHIeecRbHKxvOndCpXQBJRwYKGhPhRvKF7?=
 =?us-ascii?Q?AmjagQEsCD9i6Wq/TwmjpHbfgE1+aoF2q//QwVF6cRIz+GAw7LheF3/cEkJR?=
 =?us-ascii?Q?FiyVFCZXcy726qw8kFfiogHxZLF7d0ruB3SF+6bpW9Uw/0uP9eU91IXA9DbW?=
 =?us-ascii?Q?oe1tIzM2olVpKcX2O6P/RBeWol7H/pWBWBWLMQcqJdOz6WGcLMQXpF7tn7Gq?=
 =?us-ascii?Q?vS7irIiRll+aiwjMbgrCME4GzB6qCxBLXGs5VDCirGdfHWt+0RTX0/3vXdyb?=
 =?us-ascii?Q?Ep9W0eig57vseJmh4LWHAKlmvHbe1PELQUtjAe3IKH0Sc6xu1eZ74fDG2Ynk?=
 =?us-ascii?Q?pgrOaOmE8QCiXgnNTYqXk4NJkcNGQZgrOPcwxb6e5qUbaxxJB2Oa7pJDSLeJ?=
 =?us-ascii?Q?XGk899ZQaHVTBsxGm1zfi67W2GokJS6FOStobwj0I+6xIOoToEyLZG8Tr1Ga?=
 =?us-ascii?Q?E2sjCtYOeUHyCvxkHkce3hJDPYOPLJ9lZlmVjEGgcJjJ4yxKDPL0nUgo/8J8?=
 =?us-ascii?Q?F/VezwrH+UkiRW/T4zQSu0iR/SwoFI3uMWeqDazRZM2W3fSGZraZo2w64RAG?=
 =?us-ascii?Q?QuzdvruFPuOatUETWngzIDITgjvWsqvexA8TgtILCUYZ6Bp2BeFEl/n5ZXTa?=
 =?us-ascii?Q?/gs0o/KGoW7ijtCuv1NgHnbCXDmBFyJOveIt+7UHAJ3IdelHFWm0m5qeb599?=
 =?us-ascii?Q?iR9mZlBN/u1B2bHl32/1nt4EO1l536Mcc1lz4w4f3TaiJ15F2eA+z1iuJczm?=
 =?us-ascii?Q?QA7AyZ7rGCFrJ48WZOeibJPnZB5xeChT/l+GQe1ASxc9bNtKYeASGkoGyVlP?=
 =?us-ascii?Q?bgbaeha9IiKWm5Y4iB5Sd/dfRMyKu4fZ7Dg6ROD9Y6ODj5l6+aDUEIIiScc+?=
 =?us-ascii?Q?gVi+QyycH9G0B2BvQKhfpHlD5aqf35Lx3xwrbQNPNgUPL1yJWCwMKKVRfR0Q?=
 =?us-ascii?Q?ArG79vJOFz8/uuxfJbOVNeYj8rqSnvLuJ/ySMmWx6rPiJni90APaHjgieWbZ?=
 =?us-ascii?Q?wU7THU/F0bqZubz+bCkYROX7JNywOonoM5ZpiwcBVfC9LtXCsfaFqimiUQdk?=
 =?us-ascii?Q?UfzpdwjGM5W93sEZrdHEgkfQuEfQxH7GVFrjY9eIC+MEMhNcHKrIgcvwnkPm?=
 =?us-ascii?Q?03Ox9DweSrwsjVg7fGNBjCxP+n2fLtPQcS07xBBEl0PVU+POP/0H30DO2ymL?=
 =?us-ascii?Q?DGjIMWv73k5JGg7waM6qSp8sWTZSyjI30hei0vsDSn3JVnNVwU+NZfj87vat?=
 =?us-ascii?Q?LWWvwfJ8s04VMk6Z1JoRK9U4gPz2sizKT0BhzgSo?=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27b5cce3-d470-41e7-481b-08dbd11f61a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2023 03:48:11.5330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qMwrCv/t6R5nQZekgIj3Q64Iqg5RXhNfdCw/wsA8Ba14QVqdOhwLhPatqpdg/6EwOcf5WGATmnUW+Mf1T5rEQw==
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

--_000_PA4PR04MB9638DEFC074F41AAEE3AC471D1DBAPA4PR04MB9638eurp_
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
 drivers/net/wireless/marvell/mwifiex/sta_tx.c |   9 +-
 .../net/wireless/marvell/mwifiex/uap_cmd.c    |  26 ++
 drivers/net/wireless/marvell/mwifiex/util.c   |  73 ++++
 15 files changed, 582 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/=
wireless/marvell/mwifiex/cfg80211.c
index 7a15ea8072e6..40c39e4765f7 100644
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
@@ -4202,6 +4230,292 @@ mwifiex_cfg80211_change_station(struct wiphy *wiphy=
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
@@ -4347,6 +4661,16 @@ int mwifiex_register_cfg80211(struct mwifiex_adapter=
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
@@ -4428,6 +4752,9 @@ int mwifiex_register_cfg80211(struct mwifiex_adapter =
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
index 326ffb05d791..f9b21b13d6c3 100644
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
index c9c58419c37b..f86a527fd7ca 100644
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
index d263eae6078c..83449ad84d15 100644
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
=20
 	bool ext_scan;
+	bool host_mlme;
 	u8 fw_api_ver;
 	u8 key_api_major_ver, key_api_minor_ver;
 	u8 max_p2p_conn, max_sta_conn;
@@ -1063,6 +1070,9 @@ int mwifiex_recv_packet(struct mwifiex_private *priv,=
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
index 72904c275461..7ecff7ce06e4 100644
--- a/drivers/net/wireless/marvell/mwifiex/scan.c
+++ b/drivers/net/wireless/marvell/mwifiex/scan.c
@@ -1383,6 +1383,12 @@ int mwifiex_update_bss_desc_with_ie(struct mwifiex_a=
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
index 6462a0ffe698..f5039d158f46 100644
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
index b86a9263a6a8..4f253d8cae42 100644
--- a/drivers/net/wireless/marvell/mwifiex/sdio.h
+++ b/drivers/net/wireless/marvell/mwifiex/sdio.h
@@ -255,6 +255,7 @@ struct sdio_mmc_card {
 	bool fw_dump_enh;
 	bool can_auto_tdls;
 	bool can_ext_scan;
+	bool host_mlme;
=20
 	struct mwifiex_sdio_mpa_tx mpa_tx;
 	struct mwifiex_sdio_mpa_rx mpa_rx;
@@ -278,6 +279,7 @@ struct mwifiex_sdio_device {
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
index 70c2790b8e35..9d0ef04ebe02 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_tx.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_tx.c
@@ -36,7 +36,7 @@ void mwifiex_process_sta_txpd(struct mwifiex_private *pri=
v,
 	struct txpd *local_tx_pd;
 	struct mwifiex_txinfo *tx_info =3D MWIFIEX_SKB_TXCB(skb);
 	unsigned int pad;
-	u16 pkt_type, pkt_offset;
+	u16 pkt_type, pkt_length, pkt_offset;
 	int hroom =3D adapter->intf_hdr_len;
=20
 	pkt_type =3D mwifiex_is_skb_mgmt_frame(skb) ? PKT_TYPE_MGMT : 0;
@@ -49,9 +49,10 @@ void mwifiex_process_sta_txpd(struct mwifiex_private *pr=
iv,
 	memset(local_tx_pd, 0, sizeof(struct txpd));
 	local_tx_pd->bss_num =3D priv->bss_num;
 	local_tx_pd->bss_type =3D priv->bss_type;
-	local_tx_pd->tx_pkt_length =3D cpu_to_le16((u16)(skb->len -
-						       (sizeof(struct txpd) +
-							pad)));
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
index 745b1d925b21..23675c1cecae 100644
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


--_000_PA4PR04MB9638DEFC074F41AAEE3AC471D1DBAPA4PR04MB9638eurp_
Content-Disposition: attachment; filename="winmail.dat"
Content-Transfer-Encoding: base64
Content-Type: application/ms-tnef; name="winmail.dat"

eJ8+Iu4mAQaQCAAEAAAAAAABAAEAAQeQBgAIAAAA5AQAAAAAAADoAAEJgAEAIQAAAEE5RjlDN0Yx
QTQ2MUFDNDNBREM0Q0RDMzEzRUMzMDVFAHMHAQ2ABAACAAAAAgACAAEFgAMADgAAAOcHCgAUAAMA
MAALAAUATwEBIIADAA4AAADnBwoAFAADADAACwAFAE8BAQiABwAYAAAASVBNLk1pY3Jvc29mdCBN
YWlsLk5vdGUAMQgBBIABAD8AAABbUEFUQ0ggdjYgMS82XSB3aWZpOiBtd2lmaWV4OiBhZGRlZCBj
b2RlIHRvIHN1cHBvcnQgaG9zdCBtbG1lLgDqFAELgAEAIQAAAEE5RjlDN0YxQTQ2MUFDNDNBREM0
Q0RDMzEzRUMzMDVFAHMHAQOQBgDkZwAAWgAAAAIBfwABAAAAUQAAADxQQTRQUjA0TUI5NjM4REVG
QzA3NEY0MUFBRUUzQUM0NzFEMURCQUBQQTRQUjA0TUI5NjM4LmV1cnByZDA0LnByb2Qub3V0bG9v
ay5jb20+AAAAAAsAHw4AAAAAAgEJEAEAAACLOQAAhzkAAFq1AABMWkZ1JHvfw2EACmZiaWQEAABj
Y8BwZzEyNTIA/gND8HRleHQB9wKkA+MCAARjaArAc2V0MCDvB20CgwBQEU0yCoAGtAKAln0KgAjI
OwliMTkOwL8JwxZyCjIWcQKAFWIqCbBzCfAEkGF0BbIOUANgc6JvAYAgRXgRwW4YMF0GUnYEkBe2
AhByAMB0fQhQbhoxECAFwAWgG2RkmiADUiAQIheyXHYIkOR3awuAZDUdUwTwB0ANF3AwCnEX8mJr
bWsGcwGQACAgQk1fQuBFR0lOfQr8AfEL8MAyIDEuIEYFsR9htHRpAiAgBGIccGkR8FB0LlxsC4Bl
CoAy2SGwVGgEABxwZRiACHDrGeAkAWEigHUfYBxwBbHwV1BBMyM2JcAhwCLwjG13CsAZ4GtleSTQ
+HBpIBoxAJAiYSGAJAFvGFAJgBxSBbF0I/kjNjS/I8IZ4AWgIrEkAQIgbCcw/wnwAaAecBxgAHAc
YBAgH2AHHFED8CkQIElXNDHqNiM2NSPPIA3hK7QlUs5vKRAbsiPwcHMjNiNFSFNpZxhQZC0ZMGaA
LWJ5OiBEYR1gBRxgTAuAIDx5dS0JEdBvLiNRQG54cNIuBaBtPiNFLTTAI0WUIC41cC8YUHQvA/A3
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
AGQAIABMAGkAbgAAAB8AHwwBAAAAJgAAAHkAdQAtAGgAYQBvAC4AbABpAG4AQABuAHgAcAAuAGMA
bwBtAAAAAAAfAB4MAQAAAAoAAABTAE0AVABQAAAAAAACARkMAQAAAFwAAAAAAAAAgSsfpL6jEBmd
bgDdAQ9UAgAAAIBEAGEAdgBpAGQAIABMAGkAbgAAAFMATQBUAFAAAAB5AHUALQBoAGEAbwAuAGwA
aQBuAEAAbgB4AHAALgBjAG8AbQAAAB8AAV0BAAAAJgAAAHkAdQAtAGgAYQBvAC4AbABpAG4AQABu
AHgAcAAuAGMAbwBtAAAAAAALAEA6AQAAAB8AGgABAAAAEgAAAEkAUABNAC4ATgBvAHQAZQAAAAAA
AwDxPwQEAAALAEA6AQAAAAMA/T/kBAAAAgELMAEAAAAQAAAAqfnH8aRhrEOtxM3DE+wwXgMAFwAB
AAAAQAA5AIDP2j4IA9oBQAAIMDd9KD8IA9oBCwApAAAAAAAfANk/AQAAAAACAAAxAC4AIABGAG8A
cgAgAHMAdABhAHQAaQBvAG4AIABtAG8AZABlACAAZgBpAHIAcwB0AC4ADQAKADIALgAgAFQAaABp
AHMAIABmAGUAYQB0AHUAcgBlACAAaQBzACAAYQAgAG0AdQBzAHQAIABmAG8AcgAgAFcAUABBADMA
LgANAAoAMwAuACAARgBpAHIAbQB3AGEAcgBlACAAawBlAHkAIABhAHAAaQAgAHYAZQByAHMAaQBv
AG4AIAAyACAAaQBzACAAbgBlAGUAZABlAGQAIABmAG8AcgAgAHQAaABpAHMAIABmAGUAYQB0AHUA
cgBlAC4ADQAKADQALgAgAFQAaABlACAAYwBvAGQAZQAgAGkAcwAgAG8AbgBsAHkAIABlAG4AYQBi
AGwAZQBkACAAYQBuAGQAIAB0AGUAcwB0AGUAZAAgAHcAaQB0AGgAIABJAFcANAAxADYALgANAAoA
NQAuACAAVABoAGkAcwAgAGYAZQBhAHQAdQByAGUAIABpAHMAIABkAGkAcwBhAGIAbABlAGQAIABm
AG8AcgAgAG8AdABoAGUAcgAgAGMAaABpAHAAcwAuAA0ACgANAAoAUwBpAGcAbgBlAGQALQBvAGYA
ZgAtAGIAeQA6ACAARABhAHYAaQBkACAATABpAG4AIAA8AHkAdQAtAGgAYQAAAAsAAIAIIAYAAAAA
AMAAAAAAAABGAAAAABSFAAAAAAAAHwAAgIYDAgAAAAAAwAAAAAAAAEYBAAAAHgAAAGEAYwBjAGUA
cAB0AGwAYQBuAGcAdQBhAGcAZQAAAAAAAQAAABoAAAB6AGgALQBUAFcALAAgAGUAbgAtAFUAUwAA
AAAAAwAAgAggBgAAAAAAwAAAAAAAAEYBAAAAMgAAAEUAeABjAGgAYQBuAGcAZQBBAHAAcABsAGkA
YwBhAHQAaQBvAG4ARgBsAGEAZwBzAAAAAAAgAAAASAAAgAggBgAAAAAAwAAAAAAAAEYBAAAAIgAA
AE4AZQB0AHcAbwByAGsATQBlAHMAcwBhAGcAZQBJAGQAAAAAAOPMtSdw1OdBSBsI29EfYagfAACA
E4/yQfSDFEGlhO7bWmsL/wEAAAAWAAAAQwBsAGkAZQBuAHQASQBuAGYAbwAAAAAAAQAAACoAAABD
AGwAaQBlAG4AdAA9AE0AUwBFAHgAYwBoAGEAbgBnAGUAUgBQAEMAAAAAAB8A+j8BAAAAFAAAAEQA
YQB2AGkAZAAgAEwAaQBuAAAAHwA3AAEAAAB+AAAAWwBQAEEAVABDAEgAIAB2ADYAIAAxAC8ANgBd
ACAAdwBpAGYAaQA6ACAAbQB3AGkAZgBpAGUAeAA6ACAAYQBkAGQAZQBkACAAYwBvAGQAZQAgAHQA
bwAgAHMAdQBwAHAAbwByAHQAIABoAG8AcwB0ACAAbQBsAG0AZQAuAAAAAAAfAD0AAQAAAAIAAAAA
AAAAAwA2AAAAAAACAXEAAQAAABYAAAAB2gMIPcd+p0ZdKOFHu7v+7WVtbEhTAAAfAHAAAQAAAH4A
AABbAFAAQQBUAEMASAAgAHYANgAgADEALwA2AF0AIAB3AGkAZgBpADoAIABtAHcAaQBmAGkAZQB4
ADoAIABhAGQAZABlAGQAIABjAG8AZABlACAAdABvACAAcwB1AHAAcABvAHIAdAAgAGgAbwBzAHQA
IABtAGwAbQBlAC4AAAAAAB8ANRABAAAAogAAADwAUABBADQAUABSADAANABNAEIAOQA2ADMAOABE
AEUARgBDADAANwA0AEYANAAxAEEAQQBFAEUAMwBBAEMANAA3ADEARAAxAEQAQgBBAEAAUABBADQA
UABSADAANABNAEIAOQA2ADMAOAAuAGUAdQByAHAAcgBkADAANAAuAHAAcgBvAGQALgBvAHUAdABs
AG8AbwBrAC4AYwBvAG0APgAAAAAAAwDeP59OAAADABMSAAAAAAIBAIATj/JB9IMUQaWE7ttaawv/
AQAAAC4AAABIAGUAYQBkAGUAcgBCAG8AZAB5AEYAcgBhAGcAbQBlAG4AdABMAGkAcwB0AAAAAAAB
AAAAIgAAAAEACgAAAAQAAAAAAAAAFAAAAAAAAAAAAAAA/////wAAAAAAAAsAAIATj/JB9IMUQaWE
7ttaawv/AQAAABwAAABIAGEAcwBRAHUAbwB0AGUAZABUAGUAeAB0AAAAAAAAAAsAAIATj/JB9IMU
QaWE7ttaawv/AQAAACgAAABJAHMAUQB1AG8AdABlAGQAVABlAHgAdABDAGgAYQBuAGcAZQBkAAAA
AAAAAEAABzCUp6Q+CAPaAQIBCwABAAAAEAAAAKn5x/GkYaxDrcTNwxPsMF4DACYAAAAAAAsABgwA
AAAAAgEQMAEAAABGAAAAAAAAAMilJbGII5JKg6pkkAqkqyoHAE8+IND8Jt1ErmEHWjoK3ScAAAAA
AQsAAE8+IND8Jt1ErmEHWjoK3ScAAiEalRIAAAAAAgETMAEAAAAQAAAAfqdGXSjhR7u7/u1lbWxI
UwIBFDABAAAADAAAALoJAACS7U1FMQAAAAMAWzMBAAAAAwBaNgAAAAADAGg2DQAAAAsA+jYBAAAA
HwD4PwEAAAAUAAAARABhAHYAaQBkACAATABpAG4AAAAfACJAAQAAAAYAAABFAFgAAAAAAB8AI0AB
AAAA/AAAAC8ATwA9AEUAWABDAEgAQQBOAEcARQBMAEEAQgBTAC8ATwBVAD0ARQBYAEMASABBAE4A
RwBFACAAQQBEAE0ASQBOAEkAUwBUAFIAQQBUAEkAVgBFACAARwBSAE8AVQBQACAAKABGAFkARABJ
AEIATwBIAEYAMgAzAFMAUABEAEwAVAApAC8AQwBOAD0AUgBFAEMASQBQAEkARQBOAFQAUwAvAEMA
TgA9AEMAQgAwADQARgA2ADUAOQAxAEEARAA2ADQANAA2AEIAOABBAEEAQgBDADkAQgA2ADUARABB
AEUAOQAyADAANwAtAE4AWABGADUANwA2ADIANAAAAB8AJEABAAAABgAAAEUAWAAAAAAAHwAlQAEA
AAD8AAAALwBPAD0ARQBYAEMASABBAE4ARwBFAEwAQQBCAFMALwBPAFUAPQBFAFgAQwBIAEEATgBH
AEUAIABBAEQATQBJAE4ASQBTAFQAUgBBAFQASQBWAEUAIABHAFIATwBVAFAAIAAoAEYAWQBEAEkA
QgBPAEgARgAyADMAUwBQAEQATABUACkALwBDAE4APQBSAEUAQwBJAFAASQBFAE4AVABTAC8AQwBO
AD0AQwBCADAANABGADYANQA5ADEAQQBEADYANAA0ADYAQgA4AEEAQQBCAEMAOQBCADYANQBEAEEA
RQA5ADIAMAA3AC0ATgBYAEYANQA3ADYAMgA0AAAAHwAwQAEAAAAUAAAARABhAHYAaQBkACAATABp
AG4AAAAfADFAAQAAABQAAABEAGEAdgBpAGQAIABMAGkAbgAAAB8AOEABAAAAFAAAAEQAYQB2AGkA
ZAAgAEwAaQBuAAAAHwA5QAEAAAAUAAAARABhAHYAaQBkACAATABpAG4AAAADAFlAAAAAAAMAWkAA
AAAAAwA3UAEAAAADAAlZAQAAAB8ACl0BAAAAJgAAAHkAdQAtAGgAYQBvAC4AbABpAG4AQABuAHgA
cAAuAGMAbwBtAAAAAAAfAAtdAQAAACYAAAB5AHUALQBoAGEAbwAuAGwAaQBuAEAAbgB4AHAALgBj
AG8AbQAAAAAAAgEVXQEAAAASAAAAAtOhbmgrvG9MqSzZnFwwFjUBAAACARZdAQAAABIAAAAC06Fu
aCu8b0ypLNmcXDAWNQEAAAMAAIBQ42MLzJzQEbzbAIBfzM4EAQAAACQAAABJAG4AZABlAHgAaQBu
AGcARQByAHIAbwByAEMAbwBkAGUAAAAbAAAAHwAAgFDjYwvMnNARvNsAgF/MzgQBAAAAKgAAAEkA
bgBkAGUAeABpAG4AZwBFAHIAcgBvAHIATQBlAHMAcwBhAGcAZQAAAAAAAQAAAHAAAABJAG4AZABl
AHgAaQBuAGcAIABQAGUAbgBkAGkAbgBnACAAdwBoAGkAbABlACAAQgBpAGcARgB1AG4AbgBlAGwA
UABPAEkASQBzAFUAcABUAG8ARABhAHQAZQAgAGkAcwAgAGYAYQBsAHMAZQAuAAAACwAAgFDjYwvM
nNARvNsAgF/MzgQBAAAAJgAAAEkAcwBQAGUAcgBtAGEAbgBlAG4AdABGAGEAaQBsAHUAcgBlAAAA
AAAAAAAAHwAAgB+k6zOoei5Cvnt54amOVLMBAAAAOAAAAEMAbwBuAHYAZQByAHMAYQB0AGkAbwBu
AEkAbgBkAGUAeABUAHIAYQBjAGsAaQBuAGcARQB4AAAAAQAAAEQBAABJAEkAPQBbAEMASQBEAD0A
NQBkADQANgBhADcANwBlAC0AZQAxADIAOAAtAGIAYgA0ADcALQBiAGIAZgBlAC0AZQBkADYANQA2
AGQANgBjADQAOAA1ADMAOwBJAEQAWABIAEUAQQBEAD0ARABBADAAMwAwADgAMwBEAEMANwA7AEkA
RABYAEMATwBVAE4AVAA9ADEAXQA7AFQARgBSAD0AVABoAHIAZQBhAGQARgBvAHIAawBpAG4AZwBJ
AHMARABpAHMAYQBiAGwAZQBkADsAVgBlAHIAcwBpAG8AbgA9AFYAZQByAHMAaQBvAG4AIAAxADUA
LgAyADAAIAAoAEIAdQBpAGwAZAAgADYAOQAzADMALgAwACkALAAgAFMAdABhAGcAZQA9AEgANAA7
AFUAUAA9ADEAMAA7AEQAUAA9ADEAAABAAACACCAGAAAAAADAAAAAAAAARgAAAAC/hQAA4EnKPQgD
2gELAACACCAGAAAAAADAAAAAAAAARgAAAACChQAAAAAAAAIBAIAIIAYAAAAAAMAAAAAAAABGAQAA
ADYAAABJAG4AVAByAGEAbgBzAGkAdABNAGUAcwBzAGEAZwBlAEMAbwByAHIAZQBsAGEAdABvAHIA
AAAAAAEAAAAQAAAAKlh02ff+EEC0+RKRYdUX/gMADTT9PwAAHwAAgIYDAgAAAAAAwAAAAAAAAEYB
AAAALgAAAGEAdQB0AGgAZQBuAHQAaQBjAGEAdABpAG8AbgAtAHIAZQBzAHUAbAB0AHMAAAAAAAEA
AACyAAAAZABrAGkAbQA9AG4AbwBuAGUAIAAoAG0AZQBzAHMAYQBnAGUAIABuAG8AdAAgAHMAaQBn
AG4AZQBkACkAIABoAGUAYQBkAGUAcgAuAGQAPQBuAG8AbgBlADsAZABtAGEAcgBjAD0AbgBvAG4A
ZQAgAGEAYwB0AGkAbwBuAD0AbgBvAG4AZQAgAGgAZQBhAGQAZQByAC4AZgByAG8AbQA9AG4AeABw
AC4AYwBvAG0AOwAAAAAAHwAAgIYDAgAAAAAAwAAAAAAAAEYBAAAAIAAAAHgALQBtAHMALQBoAGEA
cwAtAGEAdAB0AGEAYwBoAAAAAQAAAAIAAAAAAAAAHwAAgIYDAgAAAAAAwAAAAAAAAEYBAAAALgAA
AHgALQBtAHMALQBwAHUAYgBsAGkAYwB0AHIAYQBmAGYAaQBjAHQAeQBwAGUAAAAAAAEAAAAMAAAA
RQBtAGEAaQBsAAAAHwAAgIYDAgAAAAAAwAAAAAAAAEYBAAAANgAAAHgALQBtAHMALQB0AHIAYQBm
AGYAaQBjAHQAeQBwAGUAZABpAGEAZwBuAG8AcwB0AGkAYwAAAAAAAQAAAEgAAABQAEEANABQAFIA
MAA0AE0AQgA5ADYAMwA4ADoARQBFAF8AfABWAEkAMQBQAFIAMAA0AE0AQgA3ADAANgA5ADoARQBF
AF8AAAAfAACAhgMCAAAAAADAAAAAAAAARgEAAABQAAAAeAAtAG0AcwAtAG8AZgBmAGkAYwBlADMA
NgA1AC0AZgBpAGwAdABlAHIAaQBuAGcALQBjAG8AcgByAGUAbABhAHQAaQBvAG4ALQBpAGQAAAAB
AAAASgAAADIANwBiADUAYwBjAGUAMwAtAGQANAA3ADAALQA0ADEAZQA3AC0ANAA4ADEAYgAtADAA
OABkAGIAZAAxADEAZgA2ADEAYQA4AAAAAAAfAACAhgMCAAAAAADAAAAAAAAARgEAAAA4AAAAeAAt
AG0AcwAtAGUAeABjAGgAYQBuAGcAZQAtAHMAZQBuAGQAZQByAGEAZABjAGgAZQBjAGsAAAABAAAA
BAAAADEAAAAfAACAhgMCAAAAAADAAAAAAAAARgEAAAA6AAAAeAAtAG0AcwAtAGUAeABjAGgAYQBu
AGcAZQAtAGEAbgB0AGkAcwBwAGEAbQAtAHIAZQBsAGEAeQAAAAAAAQAAAAQAAAAwAAAAHwAAgIYD
AgAAAAAAwAAAAAAAAEYBAAAAKgAAAHgALQBtAGkAYwByAG8AcwBvAGYAdAAtAGEAbgB0AGkAcwBw
AGEAbQAAAAAAAQAAAA4AAABCAEMATAA6ADAAOwAAAAAAHwAAgIYDAgAAAAAAwAAAAAAAAEYBAAAA
RAAAAHgALQBtAGkAYwByAG8AcwBvAGYAdAAtAGEAbgB0AGkAcwBwAGEAbQAtAG0AZQBzAHMAYQBn
AGUALQBpAG4AZgBvAAAAAQAAAAIFAAAwAGcATQB6AEYAZAA1AGkAKwB3AFMAOQBwAEUAaABWAEcA
bQBEAE0AbABEAHQAYgB1AHkATQA5AEoAZQA4AC8ANwBwAE4ASwBOAG4AcgBZAE0AbgBSAHkAaQBX
AEIAegBrAGMAdgBZADQAMAB6AGEAcABvAGoAegAwAGYALwB4ADgAWQBKAFMAegBjAHIAVABuADYA
dQBDADEAUQA4AGkASABqAGEAeABuAHMAVQA4AFgAegBPAFUAMgBXAFAAZgB2AFAAOAB0ADMAZABx
AGkATwB2AEMAVwBpAEUAbQA0ADIARwBrADMARABhAFEAbwB2AFEAdQBCAHQANQBaAGUAQwBGADQA
RwBhAG0AUQBKAGkAMwBlADIASQB4AEYANwBGAGMAeQB1AEEAQgBUAFMAUQA4AEgAUQBiAEIASQBt
AHMAZQBaAGUAWgA0AFIAZABsADQAbQB3AEgAMwBMAEkASABxADcAbQBPAHYAZABUAE4ANwBuAGYA
QQAvAEEAcQAwAGwAUQAzAFoASQBVAHcAZgB4AFUAdwA2AEIAVwAwAHQAaABPAFEATwB1AHkAQgBF
AEEAcABPAEcAbQB1AG0ASwBZADEAQwBKAE0AawA5AGcAbQBBAEsAZgBJAE8AbgB1AE4ARgBiAEUA
cABzAHcAKwBzAGoAYwBQAGoARQBuAFcAegBiAEgAVwA3AE4AcQBvAC8AbgBXAFoATgAxAGYANAAw
ADUAUQBjAGwARABUAGkAaQBkAHEAMgBqAFMAWQBhAE0AegA0AEMAYgBiAHAAcgBXAHYAawBiAEwA
UQA0AFQAUQBOAFgAVwB1AEgAOQA2AGsAZQBRAEUANwBGAEUAWgBnAEsAWABnAGcAcgBUAFIAKwBJ
AC8AaQBRAGgAagBuAHgATgBxAGEAegBCAG0AegBIAGYAVQB2AHkAZgBGAG4ANAAwAHEAUQBvAFAA
dwAwAHgAVAA2AEYANABaADgAUAB2AGsAMgBXADMAKwBkAE4ALwBqAHQASQByAC8AUwA0AFAATQBs
AEMAQQBiAEcAUwB4AFAANQBtAFYANQA4AEoAeABYAFYAUgBBAFYAbABUAGQATgBRAG8AVgBxAFMA
UABDAHYAQwBNADkARgBoAGMAeQAyAE4AOABEAGEASwBzADkAZQBwAEgAYgBmAGIAMgA5AFUARAA1
AHoAMwB5AHYANQA3AGsASwBMADAAYwBNAGsAOQB4AFkAVQB1AHUAYQBnAHcAcABNAFMASQBTAEsA
QQBkAEMAMQA1AGwAUQBQAFoASgAwAEMAOQBxADMASwBnAEcAbgBqADcAbwBUAEkATABEAFAAMgBn
AGcAWABlAHcAMgBxAHIANABaAFMAOABXAGoAMgBpAE8AdQB3AEQAdQBpADIAbQBaAEcAcwBwAFIA
dwBWAFMAQwBlAGwAdQBOAGMASwBVAHoASQAzADcAMgBsAG4ARwAzAGUAQgBLAGYANABuADQATwB1
AFAANgBQAC8AdQBMAEQAWgBWAHEAKwBCAFIAegAwAGIAQgAyAFoAdgBKAFQASAA5ADIAVgByAE4A
UABiAGUAYQBaAEkAVQB1AHAAcgBOADkAbwBqAHQAcgB0AGQAWQB6AFAAYQBUAHEAWgB4AHkAVgBn
AEoAOABKAFgAVwA0AGsAbQBrAGoAWAB0ACsALwB0AG8AbgA1AC8AMAB2AHYAUAAvAAAAAAAfAACA
hgMCAAAAAADAAAAAAAAARgEAAAA4AAAAeAAtAGYAbwByAGUAZgByAG8AbgB0AC0AYQBuAHQAaQBz
AHAAYQBtAC0AcgBlAHAAbwByAHQAAAABAAAAqgQAAEMASQBQADoAMgA1ADUALgAyADUANQAuADIA
NQA1AC4AMgA1ADUAOwBDAFQAUgBZADoAOwBMAEEATgBHADoAZQBuADsAUwBDAEwAOgAxADsAUwBS
AFYAOgA7AEkAUABWADoATgBMAEkAOwBTAEYAVgA6AE4AUwBQAE0AOwBIADoAUABBADQAUABSADAA
NABNAEIAOQA2ADMAOAAuAGUAdQByAHAAcgBkADAANAAuAHAAcgBvAGQALgBvAHUAdABsAG8AbwBr
AC4AYwBvAG0AOwBQAFQAUgA6ADsAQwBBAFQAOgBOAE8ATgBFADsAUwBGAFMAOgAoADEAMwAyADMA
MAAwADMAMQApACgAMwA2ADYAMAAwADQAKQAoADMAOQA2ADAAMAAzACkAKAAxADMANgAwADAAMwAp
ACgAMwA3ADYAMAAwADIAKQAoADMAOQA4ADYAMAA0ADAAMAAwADAAMgApACgAMwA0ADYAMAAwADIA
KQAoADIAMwAwADkAMgAyADAANQAxADcAOQA5ADAAMAAzACkAKAAxADgANgAwADAAOQApACgAMQA4
ADAAMAA3ADkAOQAwADAAOQApACgANgA0ADEAMAAwADcAOQA5ADAAMAAzACkAKAA0ADUAMQAxADkA
OQAwADIANAApACgAMwAwADgANgA0ADAAMAAzACkAKAA1ADUAMAAxADYAMAAwADMAKQAoADMAOAAx
ADAAMAA3ADAAMAAwADAAMgApACgANgA2ADgAOQA5ADAAMgA0ACkAKAA0ADEAMwAwADAANwAwADAA
MAAwADEAKQAoADQAMwAyADYAMAAwADgAKQAoADUANgA2ADAAMwAwADAAMAAwADIAKQAoADgANgA3
ADYAMAAwADIAKQAoADgAOQAzADYAMAAwADIAKQAoADUAMgA1ADMANgAwADEANAApACgAOAA2ADMA
NgAyADAAMAAxACkAKAAzADMANgA1ADYAMAAwADIAKQAoADIAOQAwADYAMAAwADIAKQAoADEAMgAy
ADAAMAAwADAAMAAxACkAKAA0ADcAOAA2ADAAMAAwADAAMQApACgAOAAzADMAOAAwADQAMAAwADAA
MAAxACkAKAA5ADYAOAA2ADAAMAAzACkAKAA3ADYAOQA2ADAAMAA1ACkAKAAyADYAMAAwADUAKQAo
ADcAMQAyADAAMAA0ADAAMAAwADAAMQApACgANgA1ADAANgAwADAANwApACgAMwAxADYAMAAwADIA
KQAoADMAOAAwADcAMAA3ADAAMAAwADAAOQApACgANgA2ADkANAA2ADAAMAA3ACkAKAA3ADYAMQAx
ADYAMAAwADYAKQAoADUANAA5ADAANgAwADAAMwApACgANgA2ADQANwA2ADAAMAA3ACkAKAA2ADkA
MQA2ADAAMAA5ACkAKAA2ADYANAA0ADYAMAAwADgAKQAoADYANAA3ADUANgAwADAAOAApACgANgA2
ADUANQA2ADAAMAA4ACkAKAA1ADcAOQAwADAANAApACgANQA1ADkAMAAwADEAKQA7AEQASQBSADoA
TwBVAFQAOwBTAEYAUAA6ADEAMQAwADEAOwAAAAAAHwAAgIYDAgAAAAAAwAAAAAAAAEYBAAAAXAAA
AHgALQBtAHMALQBlAHgAYwBoAGEAbgBnAGUALQBhAG4AdABpAHMAcABhAG0ALQBtAGUAcwBzAGEA
ZwBlAGQAYQB0AGEALQBjAGgAdQBuAGsAYwBvAHUAbgB0AAAAAQAAAAQAAAAxAAAAHwAAgIYDAgAA
AAAAwAAAAAAAAEYBAAAASgAAAHgALQBtAHMALQBlAHgAYwBoAGEAbgBnAGUALQBhAG4AdABpAHMA
cABhAG0ALQBtAGUAcwBzAGEAZwBlAGQAYQB0AGEALQAwAAAAAAABAAAAggwAAFcAYwBzAEQAaABN
AFIATQB0AFAATgByAHQAcgB5AEwAUgBrADQAYwBiAGUANABUAEsATgBYAGUAWQBaAEkAWgBVAHIA
QwBuAGwAYQAzAHIAQQA2ADAAZgBUAE0ARwBvAGkAcQBiADIAZABUAGEASwBPAGoAcQBWADIAdwBR
AG4AUQB2AGcAKwBBAHgATABNADMAQgBlAHkAMgA0AFUAaQBEAE4ATgBNAEsAbQBQAHkAVAA1AEEA
TgBqAHoAbgBoAFoAZwBuADYAVgBvAFEAegBmAFcAUQBWAGwANwBQAE4AbgBZADQAbABoAEYAcAA5
AFEAWQB0AFIALwBwAGQAZwBDAGwANQBuAGkAWQBSAEEAegA1AC8AagBnADgAbQBmAGUAKwBMAGsA
NgBiAHkAbQBpAHAAVwBPAHcAaAA4AGIAdABKAHgANQBOAGUARABFAFgANABIAEcATwA4ADYAcQBV
ADkAYQBFADIAQgBuAGEATgBqAEUARwBEAFUATwBUACsANAA2AHMAVQBaADIAZABpAFAAUgBGAEYA
OQBBAFIANgBCAEEASgAzAG0ALwBOAFUAQQBiAHoAeABkAGsAWgAxADkAMABSADcATgBkAHgAWABS
AG8AYwBmAFEATQByAGUAZgBSADYAYgA0AFAAbwBKAG8AMABiAGQAbABpAHUAWgBpAHoATABVAFYA
UwBpAGcAQwBTAGsAOQA0AGcAQQBXAHkATwBzAGYAdwArADYAQwBhAGUATwBBAFAAaQBpACsANwBK
AHAAYgBDAGIATABhADYAegBLAHMAbwA4AHMAagB3AHMAcQBzAEgARABsAFcAYgB4AFQASQArAHEA
ZQBkADYAaABEAGcAKwBMAEgASQBlAGUAYwBSAGIASABLAHgAdgBPAG4AZABDAHAAWABRAEIASgBS
AHcAWQBLAEcAaABQAGgAUgB2AEsARgA3AEEAbQBqAGEAZwBRAEUAcwBDAEQAOQBpADYAVwBxAC8A
VAB3AG0AagBwAEgAYgBmAGcARQAxACsAYQBvAEYAMgBxAC8ALwBRAHcAVgBGADYAYwBSAEkAegAr
AEcAQQB3ADcATABoAGUARgAzAC8AYwBFAGsASgBSAEYAaQB5AFYARgBDAFoAWABjAHkANwAyADYA
cQB3ADgAawBGAGYAaQBvAGcASAB4AFoATABGADcAZAAwAHIAdQBCADMAUwBGACsANgBiAHAAVwA5
AFUAdwAvADAAdQBQADkAZQBVADkAMQBJAFgAQQA5AEQAYgBXAG8AZQAxAHQASQB6AE0AMgBvAGwA
VgBwAEsAYwBYADIATwA2AFAALwBSAEIAZQBXAG8AbAA3AEgALwBwAFcAQgBXAEIAVwBMAE0AUQBj
AHEASgBkAE8AegA2AFcARwBjAEwATQBRAFgAcABGADcAdABuADcARwBxAHYAUwA3AGkAcgBJAGkA
UgBsAGwAKwBhAGkAdwBqAE0AYgBnAHIAQwBNAEUANABHAHoAQgA2AHEAQwB4AEIATABYAEcAcwA1
AFYARABDAGkAcgBHAGQAZgBIAFcAdAArADAAUgBUAFgAMAAvADMAdgBYAGQAeQBiAEUAcAA5AFcA
MABlAGkAZwA1ADcAdgBzAGUASgBtAGgANABMAFcASABBAEsAbABtAHYASABiAGUAMQBQAEUATABR
AFUAdABqAEEAZQAzAEkASwBIADAAUwBjADYAeAB1ADEAZQBaADcANABmAEQARwAyAFkAbgBrAHAA
ZwByAE8AYQBPAG0ARQA4AFEAQwBpAFgAZwBuAE4AVABZAHEAWABrADQATgBKAGsAYwBOAEcAUQBa
AGcAcgBPAFAAYwB3AHgAYgA2AGUANQBxAFUAYgBhAHgAeABKAEIAMgBPAGEANwBwAEoARABTAEwA
ZQBKAFgARwBrADgAOQA5AFoAUQBhAEgAVgBUAEIAcwB4AEcAbQAxAHoAZgBpADYANwBXADIARwBv
AGsASgBTADYARgBPAFMAdABvAGIAdwBqADAASQArADYAeABJAE8AbwBUAG8ARQB5AEwAWgBHADgA
VAByADEARwBhAEUAMgBzAGoAQwB0AFkATwBlAFUASAB5AEMAdgB4AGsASABrAGMAZQAzAGgASgBE
AFAAWQBPAFAATABKADkAbABaAGwAbQBWAGoARQBHAGcAYwBKAGoASgA0AHkAeABLAEQAUABMADAA
bgBVAGcAbwAvADgASgA4AEYALwBWAGUAegB3AHIASAArAFUAawBpAFIAVwAvAFQANAB6AFEAUwB1
ADAAaQBSAC8AUwB3AG8ARgBJADMAdQBNAFcAZQBxAEQAYQB6AFIAWgBNADIAVwAzAGYAUwBHAFoA
cgBhAFoAbwAyAHcANgA0AFIAQQBHAFEAdQB6AGQAdgByAHUARgBQAHUATwBhAHQAVQBFAFQAVwBu
AGcAegBJAEQASQBUAGcAagB2AFcAcwBxAHYAZQB4AEEAOABUAGcAdABJAEwAQwBVAFkAWgA2AEIA
cAAyAEIAZQBGAEUAbAAvAG4ANQBaAFgAVABhAC8AZwBzADAAbwAvAEsARwBvAFcANwBpAGoAdABD
AHUAdgAxAE4AZwBIAG4AYgBDAFgARABtAEIARgB5AEoATwB2AGUASQB0ACsANwBVAEgAQQBKADMA
SQBkAGUAbABIAEYAVwBtADAAbQA1AHEAZQBiADUAOQA5AGkAUgA5AG0AWgBsAEIATgAvAHUAMQBC
ADIAYgBIAGwAMwAyAC8AMQBuAHQANABFAE8AMQBsADUAMwA2AE0AYwBjADEAbAB6ADQAdwA0AGYA
MwBUAGEAaQBKADEANQBGADIAZQBBACsAegAxAGkAdQBKAGMAegBtAFEAQQA3AEEAeQBaADcAcgBH
AEMARgByAEoANAA4AFcAWgBPAGUAaQBiAEoAUABuAFoAQgA1AHgAZQBDAGgAVAAvAGwAKwBHAFEA
ZQAxAEEAUwB4AGMAOQBiAE4AdABLAFkAZQBBAFMARwBrAG8ARwB5AFYAbABQAGIAZwBiAGEAZQBo
AGEAOQBJAGkASwBXAG0ANQBZADQAaQBCADUAUwBkAC8AZABmAFIATQB5AEsAdQA0AGYAWgA3AEQA
ZwA2AFIATwBEADkAWQA2AE8ARABqADUAbAA2ACsAYQBEAFUARQBJAEkAaQBTAGMAYwArAGcAVgBp
ACsAUQB5AHkAYwBIADkARwAwAEIAMgBCAHYAUQBLAGgAZgBwAEgAbABEADUAYQBxAGYAMwA1AEwA
eAAzAHgAdwByAGIAUQBOAFAATgBnAFUAUABMADEAeQBKAFcAQwB3AE0ASwBLAFYAUgBmAFIAMABR
AEEAcgBHADcAOQB2AEoATwBGAHoAOAAvAHUAdQB4AGYASgBiAE8AVgBOAGUAWQBqADgAcgBxAFMA
bgB2AEwAdQBKAC8AeQBTAE0AbQBXAHgANgByAFAAaQBKAG4AaQA5ADAAQQBQAGEASABqAGcAaQBl
AFcAYgBaAHcAVQA3AFQASABVAC8ARgAwAGIAcQBaAHUAYgB6ACsAYgBDAGsAWQBSAE8AWAA3AEoA
TgB5AHcATwBvAG4AbwBNADUAWgBwAGkAdwBjAEIAVgBmAEMAOQBMAHQAWABDAHMAZgBhAEYAcQBp
AG0AaQBVAFEAZABrAFUAZgB6AHAAZAB3AGoARwBNADUAVwA5ADMAcwBFAFoAcgBkAEgARQBnAGsA
ZgBRAHUARQBmAFEAeABIADcARwBWAEYAcgBqAFkAOQBlAEkAQwArAE0ARQBNAGgATgBjAEgASwBy
AEkAZwBjAHYAdwBuAGsAUABtADAAMwBPAHgAOQBEAHcAZQBTAHIAdwBzAGoAVgBnADcAZgBHAE4A
QgBqAEMAeABQACsAbgAyAGYATAB0AFAAUQBjAFMAMAA3AHgAQgBCAEUAbAAwAFAAVgBVACsAUABP
AFAALwAwAEgAMwAwAEQATwAyAHkAbQBMAEQARwBqAEkATQBXAHYANwAzAGsANQBKAEcAZwA3AHcA
YQBNADYAcQBTAHAAOABzAFcAVABaAFMAeQBqAEkAMwAwAGgAZQBpADAAdgBzAEQAUwBuADMASgBW
AG4ATgBWAHcAVQArAE4AWgBmAGoAOAA3AHYAYQB0AEwAVwBXAHYAdwBmAEoAOABzADAANABWAE0A
awA2AFoAMQBKAG8AUgBLADkAVQA0AGcAUAB6ADIAcwBpAHoASwBUADAAQgBoAHoAZwBTAG8AAAAA
AMSZ

--_000_PA4PR04MB9638DEFC074F41AAEE3AC471D1DBAPA4PR04MB9638eurp_--

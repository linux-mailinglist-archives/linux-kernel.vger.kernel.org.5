Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35D03755F76
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 11:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbjGQJhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 05:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbjGQJg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 05:36:58 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2135.outbound.protection.outlook.com [40.107.215.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327A3213F;
        Mon, 17 Jul 2023 02:35:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GuASlM1+KerEudBkinOmJLP1IbdL1GrKsu+UtqiQjQWbmW3WizyIRR7Ox1/thvOI0m36YHUwv+Pr7zE1rMCCQfso2ZFRaDoMoa2IEfDont9+NNUnFlTzVS7b/6fMpbdNog1lCcE8+lriHBT9qLIo4r3NSrUptcSVt9VR/dio068KeFA7QqOIFuu5nbuyy4eSmk2owXeWvkxsAZZe+XXmw2zDzyGaUUvEHFNJC05jhLVNgTroEVITxQD6uLj7QnzdBiHakRAFrTcZwfHlEah6Qgqv73Y/yZyl+TA/dAo67bzpQS6lC9pVyYAE52dBG/ydP/BQIbV+SQ+Cq2YKknFzDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oMX0jy4gYHS97Nfb2xwHgsa5e0riPqpbQaPwvR0CPWo=;
 b=mxhXAl6omTXZIEFjlEpfvahwHRfhWOXXlafcNyYQN2lAJ2BiBUmfrpNY81dNRNjUbtB+Y/wmz2hM8hhqlC/YoOAfM3/sPTYI/eP3APL0HAlzwIqpvzjuGORRzqongbR6JZLfEG482TgHl0xyO7L9Amj1uag+Y4Hj3NE5sxCxF1puLvYQR3eYZae7g6FJuf/CSEdmD4Sw+gUaUAl7/L8H7NyAx0CbyXBovNJ0wALO9fC/j5ZcPnMRBxb8kARoXA6nFsRcjVwZ6Uq8C0JJaeIi0JE4Lj4arMf9Cyn9tUMetvoidD1qvFXNZRWnhFKt5Az275lXZw9S+cWzuC3R1205EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oMX0jy4gYHS97Nfb2xwHgsa5e0riPqpbQaPwvR0CPWo=;
 b=YivgxDG2WEYVfY7uA8+xMNT+25/vC55JZizI5S4Iy+PzOClH7YhvPqbVmf3bhl1JpPjiJBrpBoQxvBQgUsvksbxA4bhxWQ4jNLK7Imu9lWSVb9MR8Pj34ghxVemeBx0uN1kUKIG0cCawO8qvyQwq9/EFgAH8F9ANHmXLMBJI8Z+T14D9W2hN0TJOaqO7uWnswzNvg6yw0HiPXSZb2GcjWgT66ADonZTyMDyfAKmoTbHSDL2k+8I5Z60ZIk6Nhll2Azw2zvqeGqpRpWetUrs8YZY8HbhUUUer6WQ5ZhOG1iwOyY/ctvjI1vyDE0ZKBbbO3GVToqnlV0Tk4mIgCeQhcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com (2603:1096:4:d0::18) by
 TYZPR06MB4126.apcprd06.prod.outlook.com (2603:1096:400:25::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.31; Mon, 17 Jul 2023 09:35:10 +0000
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c]) by SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c%4]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 09:35:10 +0000
From:   Wang Ming <machel@vivo.com>
To:     Ajay Singh <ajay.kathat@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Kalle Valo <kvalo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Wang Ming <machel@vivo.com>
Subject: [PATCH net v1] net: wireless: Use kfree_sensitive instead of kfree
Date:   Mon, 17 Jul 2023 17:34:43 +0800
Message-Id: <20230717093456.17474-1-machel@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0114.jpnprd01.prod.outlook.com
 (2603:1096:404:2a::30) To SG2PR06MB3743.apcprd06.prod.outlook.com
 (2603:1096:4:d0::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3743:EE_|TYZPR06MB4126:EE_
X-MS-Office365-Filtering-Correlation-Id: 285a6b74-4d2c-4208-4d57-08db86a91d07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4lLxqF1d0kmf7MZzg8D4vPezcYgaht/E+B88W2UPxUhkAJU3pSZo9MGfdOffJ4sBytO/TqHnCVRZIWzYC19DtOj4N0LUdrAfdl0hzxyVcA6EuxGilR+r8KIcb62SpWGu/pTQjDK/G3FQGoX6O1T85Pzi1ZM1ZkQ9jupnsl6shitgvkhhhuVXr0bhq1pRnhszXUHQrjUiXOEcPeoTfpUe5tMyAJq9RkaxpUD5jdlmXZnVUXgF9Xl6vTA5QF8klev83G+8kZj6Ed+Uaa6nJsf0FkTVrGs6kW14tJzxstZI21MidtG/ct3bcZveLU5t13Zml/5/+VgqYOpk4cUJxFnVpsAaePUZoZVbwkWcmnYyEtVUDVIqeMy/UpUbPwHqChTKu3yh1/ZihEaj4aKc1BgyT3S7y3jM+mB3jT3Cz1vAfCI5sDNgdKxZVOG0WuMDNiQ1S8aH/Zf0VsCDp1O1k4SZq/3JGXsAUmqz+s0ZfvtlNT4IICJwjt6Iub/BIJcHuSWmHklAYaR3awkPNui/9mqJKfStyK1akeUpThQQOAP4XbIiatj7W41uQKf6lIztgTDvZgqpALFzKPE3fna5wrwMNF29/HWEADHYxTDTLgAqAAyacYuwbXSthTMaLRsrp5Ex
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3743.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(366004)(346002)(376002)(396003)(136003)(451199021)(86362001)(2906002)(36756003)(6512007)(186003)(83380400001)(1076003)(6506007)(26005)(107886003)(38350700002)(38100700002)(52116002)(6486002)(6666004)(110136005)(316002)(66946007)(66556008)(66476007)(2616005)(4326008)(478600001)(41300700001)(5660300002)(8676002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JMZPkxLeP3S9uFtmnz4R8YFFj94Bsxz1q0Ev/+SWktCQ2P2fXtkMPeN6rHf6?=
 =?us-ascii?Q?E/nAtz9RID6mC1DueRh5pi7fZegWGIvNgDNuDUOH+O+88b8FE6aKnW3ETVFO?=
 =?us-ascii?Q?jVRJnqrBqOEFqqImpcgis2aPfWkaW+vj2f58kLSwWf4aKCuIZwp8cMqtP1bi?=
 =?us-ascii?Q?whv2PSrwHkQdAi/pldSV24NiVDQhJjMc2C+bALWuWke+mqdHZpZJahFxFct1?=
 =?us-ascii?Q?d4asnbtW8vTKXaNlx0GaRwTLlGcHkQoorWIUgbdVGsTnft0Ps0y6ZnXsmEkW?=
 =?us-ascii?Q?gbXoYhNruXuFE/T+R39Ai9jBh63J6hppVVMZVhjGWm+7dJvWOMXQMzTmWs6f?=
 =?us-ascii?Q?CEVhDbXPtuc/jahH9kDcs8sD/xrkllJXF6QSnShIj7PkiR+ALxxotgl7JpCs?=
 =?us-ascii?Q?IiqkTlo6K1w1RE3Yz1eMNsppD7FMLLsohpeBE6qrCKWE1AEOyhEU5RnA7iZH?=
 =?us-ascii?Q?r6KYAKrFJowzR/gkEYF6hNMwwFxK7uV4x+flYuURCHEHkH0XYZm9UI+P46iU?=
 =?us-ascii?Q?HxcM/TyVtEW21E46IDXyRIBwvtfvlsQNU8fyfVBEmAWmzVciDLHw8L0j+ykI?=
 =?us-ascii?Q?6j+rZCqfyDksg4n4Mp4Y+hrYJTt5tRod4e5/FkDN9b0lUovoCu1XnFxFIUvP?=
 =?us-ascii?Q?RMI5+1i7G+5iHSjlViYpNJDH/Uvm1rWTL0ReRbZKqE6FNjQLHPl2yeOOy2AE?=
 =?us-ascii?Q?2FwgZfeZgnhM9HThVI9UPr8sWIfJ+QvN2z5donDoCdWXuW2obWVili/lbo7V?=
 =?us-ascii?Q?+aSmBg7mFFDuEeMO+7exab69hA0dczOCkTbLkSYazzV2sCgBmN3TghlLsDxU?=
 =?us-ascii?Q?LuEvQ2Mlp7AAfiQ9Ycj904docUMpn0V6AcTQjBQEcmce/WN9LgzSXoqCeUP7?=
 =?us-ascii?Q?yi3SEDrtYxGqiUVCwh7eVNJX9kn0FhWNT3O+2Tpi8ujp0+NsacXbJDmKjMRu?=
 =?us-ascii?Q?D0mwpjuCkBMZ6VF1IVfbqgpqNL9h2RaiQHu+gKh8AMV+bzXDShJlonCj1ODD?=
 =?us-ascii?Q?wAN9ZG9+CVim35mnXWkRDrLds6QcHeC8szfW8TUn+kLZVjOThG4Ho1yH7ON/?=
 =?us-ascii?Q?7iyKxg8fFub6m77hZcmZYWm+T09o4Umx33H+9wiK/fWa8XO6cqBpNx8TO7HU?=
 =?us-ascii?Q?KAmUAsb84fOuI2cj+851DVTd9QUHn4VACXYqFXngp70Jfj5A8AwID+IZw+0X?=
 =?us-ascii?Q?x7cm1anpvL7Xc7g90r0a9y9873fEyZrBghRB9H6DqYHYes6EQy6pklQUlJgx?=
 =?us-ascii?Q?f/hYJN4e13a7IOae5Rgc0N2TQy4k9GSl0lpMgOMsNExU0YChiWejVW9/B+14?=
 =?us-ascii?Q?j828pyPVhlsxLaldXeP8mUgj4tsAqkMNN87ogUxGd/jGBzDoqBNpW9+frlDM?=
 =?us-ascii?Q?RsYNzU41hGlViy8rTWGtUws1bxLMyoqxxR/SMSLymDAZKyRbtJZmbmynsrKm?=
 =?us-ascii?Q?GgCkBmCJWbRMp3DoMmsRUbOdOBJ9uJzNyHDjR+b2zwnSKpsM/0jEveQ+MgZD?=
 =?us-ascii?Q?DbjnFZwml6woRLTTIqkQV6cEFdxwk43RpCYO8oucFVEJhRk5P8YSyPvE0noC?=
 =?us-ascii?Q?lvGUq+LIfi1hOTs1mInZyHwHgSTyD0xzLLreoHc5?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 285a6b74-4d2c-4208-4d57-08db86a91d07
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3743.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 09:35:09.9341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n5aro7VbB6mmgDyDKxEtIXSowqI0C4lkRMnTD70iXMzcdbPd/r0vsCNAnBLxVFu/9MsUPItFKhdgK/M+33NzVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4126
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

key might contain private part of the key, so better use
kfree_sensitive to free it.

Fixes: 7cec84fdfd88 ("staging: wilc1000: split add_key() to avoid line over 80 chars")
Signed-off-by: Wang Ming <machel@vivo.com>
---
 drivers/net/wireless/microchip/wilc1000/cfg80211.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.c b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
index b545d93c6e37..45bcadeba2da 100644
--- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
+++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
@@ -518,7 +518,7 @@ static int wilc_wfi_cfg_allocate_wpa_igtk_entry(struct wilc_priv *priv, u8 idx)
 static int wilc_wfi_cfg_copy_wpa_info(struct wilc_wfi_key *key_info,
 				      struct key_params *params)
 {
-	kfree(key_info->key);
+	kfree_sensitive(key_info->key);
 
 	key_info->key = kmemdup(params->key, params->key_len, GFP_KERNEL);
 	if (!key_info->key)
@@ -656,7 +656,7 @@ static int del_key(struct wiphy *wiphy, struct net_device *netdev, int link_id,
 	if (!pairwise && (key_index == 4 || key_index == 5)) {
 		key_index -= 4;
 		if (priv->wilc_igtk[key_index]) {
-			kfree(priv->wilc_igtk[key_index]->key);
+			kfree_sensitive(priv->wilc_igtk[key_index]->key);
 			priv->wilc_igtk[key_index]->key = NULL;
 			kfree(priv->wilc_igtk[key_index]->seq);
 			priv->wilc_igtk[key_index]->seq = NULL;
@@ -665,7 +665,7 @@ static int del_key(struct wiphy *wiphy, struct net_device *netdev, int link_id,
 		}
 	} else {
 		if (priv->wilc_gtk[key_index]) {
-			kfree(priv->wilc_gtk[key_index]->key);
+			kfree_sensitive(priv->wilc_gtk[key_index]->key);
 			priv->wilc_gtk[key_index]->key = NULL;
 			kfree(priv->wilc_gtk[key_index]->seq);
 			priv->wilc_gtk[key_index]->seq = NULL;
@@ -674,7 +674,7 @@ static int del_key(struct wiphy *wiphy, struct net_device *netdev, int link_id,
 			priv->wilc_gtk[key_index] = NULL;
 		}
 		if (priv->wilc_ptk[key_index]) {
-			kfree(priv->wilc_ptk[key_index]->key);
+			kfree_sensitive(priv->wilc_ptk[key_index]->key);
 			priv->wilc_ptk[key_index]->key = NULL;
 			kfree(priv->wilc_ptk[key_index]->seq);
 			priv->wilc_ptk[key_index]->seq = NULL;
-- 
2.25.1


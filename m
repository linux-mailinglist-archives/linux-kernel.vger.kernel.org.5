Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBEE37FB42F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 09:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344167AbjK1Icg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 03:32:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344124AbjK1IcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 03:32:21 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2086.outbound.protection.outlook.com [40.107.22.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F34D4C;
        Tue, 28 Nov 2023 00:32:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DRVpTr+Hj1DoQm7g8N+Rhp51nl53h8qfEODYnR9K33sPgedI5Ax1MJgI+xCYWg8RrGZ1qqk50OrRHhJ7DWT4s5JCyPFPSWDaUmV7AglLg/a/K/4IGHaF+uUWxNl8gZXW2pFYAt6lQfR8+jgUmd+m71zvzl6HMt8TtQG3G9AUfW+DzpJpsTF4CSRFlFJ6mUIY0riIIIQx08nOGDnlKZBWL8UtsyyAbn7IAVicY6KdzAccrl6+rYlOZsGUOavZH9D+YnwXpoMYodMl8zmmO8861Ws2r1rIHYKWmEJ3iMH/tVpvMks3phpadfhpQOl2FrksI5kvaWgw/Vt35VSslKUOnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZ7GKKLZNzBJwSK0KCfnrPqMHfh7ixsv8ewCJo3g0HE=;
 b=eu4JE/QIBHoF64FTGqrJz5auf5yZjKM1CnXFP6NI6Unp2XmnEGNgz1MVVOr8zGtpzdbOoySwYT/LvqpvGJzS4eLPyb4nJy0Tva9prmlBl8qmDebny3Fm4HSDYvwnCEnaBZmUlMH/0lH4ynOKpdyIuRY1VLr4bDgOxsdr0KxH7Pq54zfyuBKHd7cCG0ksN7WFqI0TKiHtaLM0ZIMvqH7vldY+2oyVOAQqk06fItjuPQm9aXVdpkQbDERH09etoNJA63XqbeCEcRMtmH3vnk1kHpqRhWnxF01jDsqo/C5iP/ocm0MZ6o3a6DKizRQOrAdOpsXY+zwtSS8+toqUPSSpWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZ7GKKLZNzBJwSK0KCfnrPqMHfh7ixsv8ewCJo3g0HE=;
 b=f+XiBxAabVkSgBm81ZNPAxLRCarQw5o62YyFc/R8yUFAltGywUTADxBeIrswKYwRVNb1ZW7LAPb5MiG211VorD1YbNuvcb+U9E6yIwz6ZIXBfcdE/ss0HrbDkAFK9DF6w0wFeGEnObaOHtsRxXYVJDqYr1K2y+1vN3d5UVx4mfU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by PAXPR04MB8653.eurprd04.prod.outlook.com (2603:10a6:102:21c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Tue, 28 Nov
 2023 08:32:04 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b%7]) with mapi id 15.20.7046.015; Tue, 28 Nov 2023
 08:32:04 +0000
From:   David Lin <yu-hao.lin@nxp.com>
To:     linux-wireless@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, briannorris@chromium.org,
        kvalo@kernel.org, francesco@dolcini.it, tsung-hsien.hsieh@nxp.com,
        David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH v7 07/12] wifi: mwifiex: fixed TLV error for station add cmd.
Date:   Tue, 28 Nov 2023 16:31:10 +0800
Message-Id: <20231128083115.613235-8-yu-hao.lin@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: d4d8d950-3136-4b2c-d6fb-08dbefec802d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MG+8QqDU+SSFUxlDsGdRKYP663s7wB4584KnjoHXy22Vb+0QcosYYA8IwQFIhlHuu+FK0fD5smUgmrvL0DoppKnfl6dyfPGKXsJm0Lpw2WUc1ip0KT2PlKog09G0zDzzmvmAQtVwJe8MxdxvZbRjPlg0LSa7rIPgXzdw5r0H/5gYKsbg9p9UoIyf41ZkTPvp95jwqydM91sP+vYs/hAo4kdke2AaA2zvOYC/BqVrxhtcny2y01wwMeD1fRfKhxBM1/gZWDXemWwqi/xlYBfFdTM8CQ0qT/ZWa87dZ//lZ+y+c88f6fKF66WdSsgm3+ZaPPC4z+IzgJ8uKwtrLLMoMWA2WN5nXetj8x8Z6ZMxzuK/5f6YpME+BtZjXUIDZKLGG7ffjgVoMR2nO8bec47mpTMcIT1185oDCl+qey+a1xgU2kxwX0sTGDRwYyE5dj8PGV5cJAxLWNKVVYAMjbjy/zET0UPbny6CwXkl8EYmor90zI022XQLyS/+1WRkfJ/LbJrVD0BLy7ToEWB2ApbNy7OAPN04v+FpeJxmT1HMjfjYW8kVOjhCde2zfu3YFtUU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(366004)(376002)(39860400002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(83380400001)(66946007)(478600001)(6512007)(52116002)(6486002)(86362001)(66556008)(6666004)(66476007)(6916009)(316002)(8676002)(4326008)(8936002)(6506007)(1076003)(2616005)(5660300002)(38100700002)(41300700001)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ItNs+oxaMif1vmZDwUZAQy1CVcBjyWJITQ6FaAC1UX8KUNaRCqyOOPmq51ha?=
 =?us-ascii?Q?boe9b4IlG6+pHyAegGRomiKWzAzHJUVpopZXNyh+0zp1jO1oauYIx3gKMBsJ?=
 =?us-ascii?Q?7+CxFs8Ln4oSQzt0L7dbBB+dHsxADQa1kYxB0ZuSBf5FutqUn1Zxbe0JdtNr?=
 =?us-ascii?Q?1pQfzOc3rJFkjq8FJB+PIicwc5mLBTpajXa5rFi0otamGf+SiOG4Fa56TE7N?=
 =?us-ascii?Q?rKfZVj0xWnFj7MTjvooXmmMI65BXevh7Ir9ByEdfYjmKHezXEFCRtk3Zpjr2?=
 =?us-ascii?Q?A1kXDMRt5v+4WreJ2D2tA83HWsaFb0Lyj6uIiM8UVtJInrd7eDhwTcVy7q+W?=
 =?us-ascii?Q?k//QQU5pg5b3kTB8pDoHD5fAY7D/Us0K/+qrc+3V5sV/WkON6FDGuYXOiDe4?=
 =?us-ascii?Q?TTQ6AGgde9/DX1ZRtREluVmLRePPnpsNWDImrxTktycGrjWa/DPNkBOX6l4P?=
 =?us-ascii?Q?UUEZjfSd8spd7yR0deRYHI1s8WcIBreQdDHXY2J6qEXQbUvnvh12w7+C9Bbv?=
 =?us-ascii?Q?U/1MDa00QRGYXEEyR+f7YfSlnVWYZZOc0omcC5Yo1rnguWJqn5caANDQ7/FW?=
 =?us-ascii?Q?BUehs+2zi4PVX4B2XjLKFjzNoxL7nrRoOcocZaKXPUIFEhirTXKNob2C7bbC?=
 =?us-ascii?Q?qjDORJyHemCPU86sB/tyyOPoMxPL2E3x4txnh3P3lYBcHU8V8g3DqkKt2SkW?=
 =?us-ascii?Q?+v8HhRSbFbxrKADdkPVf1u/0rW6pr5Aui58PXGOYF83hePL62qneNU5Post3?=
 =?us-ascii?Q?gaS20BYE+7Quv3t9XxNBBhhWs1Bx3wAPh/WISjcis4KnraoVzQhJWaTd1NIp?=
 =?us-ascii?Q?opAqpX7XH8TyL+LOZA/rrpoNwP1GZNgDi35qmYZQ6MaTYfO4amYDjfF0G0ew?=
 =?us-ascii?Q?GdB20waiqcvgqXHRMz633aQ7pJlsYNz+iZnZRWHe8frGafWYLMb6rz50DUxu?=
 =?us-ascii?Q?rYkFS6bRNJOkr2LGF8sbhR8kAKYR8vLf/2JULZI87fyhuFltOFaFt9Zc26lr?=
 =?us-ascii?Q?H7hnvjsFrei5IWE6elYx3YwvXo8Ems7CWrgPML/sC0hWgC3MLJhrMAfpNn2G?=
 =?us-ascii?Q?nn1OzjLe3F2DJQrwMoYt6ybqJPtWE8DAoHlXT20ENOc7CmX/VK1NCac2qSIB?=
 =?us-ascii?Q?s3JVJh9TTs6/aERpD4XwLZtXYECpC+rOZZX+AUo0AKuNagMk24C09MmHV5Ca?=
 =?us-ascii?Q?2AvU50ZUYm9BHcU/hXYfvAsveqN65ZXCIccuYJVdhGMOz2y4FFwdu4m/dYIJ?=
 =?us-ascii?Q?CIOHWWW2aH5moxUsfGxYEoAQthNQZxf+TdCQ+759DTMPCnDYMe0KivClwpLY?=
 =?us-ascii?Q?8e9hUWTj6GOD1yn4fCudMqNckA9iLTbkZk4gPJb13grgrr7fg7e5XS6heeq3?=
 =?us-ascii?Q?xzihOw2hRcCtB5wpgpdWLTtfqqtN59CVUZf/KeYU0SNTW/gjyCdSeq9C90zi?=
 =?us-ascii?Q?AF3/rgceXxujXVALXQKxjRCRAxWl5o16sigYHJo+zuClqq+KQOcUYHv2qP5R?=
 =?us-ascii?Q?I1tQuqBJiI9E0iDfrnk1b0dWA+BkB7sltWRARI2xEwFuypy7+5pK+kAwbDKn?=
 =?us-ascii?Q?/fCm9+s8D5LADbph71AMoy4JvOXCK/6IkKgY9waMnVbajYpoIdc12XobQunv?=
 =?us-ascii?Q?5j682bxHq/3Z8hw1klRm8GlvheE0dJQTuuEJWA/deSBy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4d8d950-3136-4b2c-d6fb-08dbefec802d
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 08:32:04.5996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rGCukaewpao4bUK9u59AHCnoPez6D5NErvDNwH+LXwnkiA/HjXNyHJO+00cdfWj2JM1xpDFxRJlsgxK2HLyw4Q==
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

TLV commands setting for host command HostCmd_CMD_ADD_NEW_STATION is
not correct. This issue will set wrong station information to firmware.

Without this patch, transmission will get 50-70% low throughput for host
mlme AP mode.

Signed-off-by: David Lin <yu-hao.lin@nxp.com>
---
 .../net/wireless/marvell/mwifiex/uap_cmd.c    | 52 +++++++++----------
 1 file changed, 25 insertions(+), 27 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
index c1133da28bc6..eb7e39146b8a 100644
--- a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
+++ b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
@@ -809,7 +809,7 @@ static int mwifiex_cmd_uap_add_station(struct mwifiex_private *priv,
 	u8 qos_capa;
 	u16 header_len = sizeof(struct mwifiex_ie_types_header);
 	u16 tlv_len;
-	struct mwifiex_ie_types_header *tlv;
+	struct mwifiex_ie_types_data *tlv;
 	struct mwifiex_ie_types_sta_flag *sta_flag;
 	int i;
 
@@ -846,45 +846,44 @@ static int mwifiex_cmd_uap_add_station(struct mwifiex_private *priv,
 	cmd->size += sizeof(struct mwifiex_ie_types_sta_flag);
 
 	if (params->ext_capab_len) {
-		tlv = (struct mwifiex_ie_types_header *)pos;
-		tlv->type = cpu_to_le16(WLAN_EID_EXT_CAPABILITY);
+		tlv = (struct mwifiex_ie_types_data *)pos;
+		tlv->header.type = cpu_to_le16(WLAN_EID_EXT_CAPABILITY);
 		tlv_len = params->ext_capab_len;
-		tlv->len = cpu_to_le16(tlv_len);
-		memcpy(tlv + header_len, params->ext_capab, tlv_len);
+		tlv->header.len = cpu_to_le16(tlv_len);
+		memcpy(tlv->data, params->ext_capab, tlv_len);
 		pos += (header_len + tlv_len);
 		cmd->size += (header_len + tlv_len);
 	}
 
 	if (params->link_sta_params.supported_rates_len) {
-		tlv = (struct mwifiex_ie_types_header *)pos;
-		tlv->type = cpu_to_le16(WLAN_EID_SUPP_RATES);
+		tlv = (struct mwifiex_ie_types_data *)pos;
+		tlv->header.type = cpu_to_le16(WLAN_EID_SUPP_RATES);
 		tlv_len = params->link_sta_params.supported_rates_len;
-		tlv->len = cpu_to_le16(tlv_len);
-		memcpy(tlv + header_len,
+		tlv->header.len = cpu_to_le16(tlv_len);
+		memcpy(tlv->data,
 		       params->link_sta_params.supported_rates, tlv_len);
 		pos += (header_len + tlv_len);
 		cmd->size += (header_len + tlv_len);
 	}
 
 	if (params->uapsd_queues || params->max_sp) {
-		tlv = (struct mwifiex_ie_types_header *)pos;
-		tlv->type = cpu_to_le16(WLAN_EID_QOS_CAPA);
+		tlv = (struct mwifiex_ie_types_data *)pos;
+		tlv->header.type = cpu_to_le16(WLAN_EID_QOS_CAPA);
 		tlv_len = sizeof(qos_capa);
-		tlv->len = cpu_to_le16(tlv_len);
+		tlv->header.len = cpu_to_le16(tlv_len);
 		qos_capa = params->uapsd_queues | (params->max_sp << 5);
-		memcpy(tlv + header_len, &qos_capa, tlv_len);
+		memcpy(tlv->data, &qos_capa, tlv_len);
 		pos += (header_len + tlv_len);
 		cmd->size += (header_len + tlv_len);
 		sta_ptr->is_wmm_enabled = 1;
 	}
 
 	if (params->link_sta_params.ht_capa) {
-		tlv = (struct mwifiex_ie_types_header *)pos;
-		tlv->type = cpu_to_le16(WLAN_EID_HT_CAPABILITY);
+		tlv = (struct mwifiex_ie_types_data *)pos;
+		tlv->header.type = cpu_to_le16(WLAN_EID_HT_CAPABILITY);
 		tlv_len = sizeof(struct ieee80211_ht_cap);
-		tlv->len = cpu_to_le16(tlv_len);
-		memcpy(tlv + header_len, params->link_sta_params.ht_capa,
-		       tlv_len);
+		tlv->header.len = cpu_to_le16(tlv_len);
+		memcpy(tlv->data, params->link_sta_params.ht_capa, tlv_len);
 		pos += (header_len + tlv_len);
 		cmd->size += (header_len + tlv_len);
 		sta_ptr->is_11n_enabled = 1;
@@ -896,23 +895,22 @@ static int mwifiex_cmd_uap_add_station(struct mwifiex_private *priv,
 	}
 
 	if (params->link_sta_params.vht_capa) {
-		tlv = (struct mwifiex_ie_types_header *)pos;
-		tlv->type = cpu_to_le16(WLAN_EID_VHT_CAPABILITY);
+		tlv = (struct mwifiex_ie_types_data *)pos;
+		tlv->header.type = cpu_to_le16(WLAN_EID_VHT_CAPABILITY);
 		tlv_len = sizeof(struct ieee80211_vht_cap);
-		tlv->len = cpu_to_le16(tlv_len);
-		memcpy(tlv + header_len, params->link_sta_params.vht_capa,
-		       tlv_len);
+		tlv->header.len = cpu_to_le16(tlv_len);
+		memcpy(tlv->data, params->link_sta_params.vht_capa, tlv_len);
 		pos += (header_len + tlv_len);
 		cmd->size += (header_len + tlv_len);
 		sta_ptr->is_11ac_enabled = 1;
 	}
 
 	if (params->link_sta_params.opmode_notif_used) {
-		tlv = (struct mwifiex_ie_types_header *)pos;
-		tlv->type = cpu_to_le16(WLAN_EID_OPMODE_NOTIF);
+		tlv = (struct mwifiex_ie_types_data *)pos;
+		tlv->header.type = cpu_to_le16(WLAN_EID_OPMODE_NOTIF);
 		tlv_len = sizeof(u8);
-		tlv->len = cpu_to_le16(tlv_len);
-		memcpy(tlv + header_len, params->link_sta_params.opmode_notif,
+		tlv->header.len = cpu_to_le16(tlv_len);
+		memcpy(tlv->data, params->link_sta_params.opmode_notif,
 		       tlv_len);
 		pos += (header_len + tlv_len);
 		cmd->size += (header_len + tlv_len);
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8787FB42B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 09:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344140AbjK1IcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 03:32:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344170AbjK1IcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 03:32:14 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2086.outbound.protection.outlook.com [40.107.22.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA7A10E7;
        Tue, 28 Nov 2023 00:32:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DqMRizaG0rZl9Gwu4wCjJyqzXM+0RJzHdNXCCtXkcbDF9/O1wyADx9pU2GvCNtSZyFSgCY1umR7HbcjI+H0af0awOy8u6CGbjEzDfwumDErEHMlJ41UDbXwimqv6PzM8CQ+2BMr4rSJPQ0Y6lZuXgYxNEH6q/+AVSz2oe0OHwzj+jPV0kxpNwqdGAYoNtPeoSVNhuPGvihbncMYv5NdA1UzgXUPs3GpYJtgoMPx3t6mAplLUY/xRv6GnikbLrdISuZM5efR32WlC6iqiYwoOJ4o4Zk6n/jlp+TfW+ueb+pqPjWgMPWiPIDPxlmpgN5FZT0LB1GHjyhDb9KGCPTzsdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mp2O7UM8gLmHwHcUiqTis1VHoTzZ7+MrO7hBp8xrSW4=;
 b=QF8gEu5WMVy7UMaMqbpa9Z0k0GVpLryE1ZFjQqp4czCghzacqqEkEvg7oMJ4COwRTn2kAurTf0H62HR3RgVEXJC/GNPYmG/HnU/9dm8ltG5cYmiH/Q7DdoaWdbqy8oeLjYuxT2bdOcLu8wueY5wOUdQ4W3okb1S05FiG1d8Yo2TYpgIyFSvAXVC1zwEE9PeR+RCGwW7v2652Q3+JzeDJ/1Epqd6DfVVdXdVTjHZ+p+htZ1MnHDIYzEEwhgSFuA8Ngi4dGX/QOTqhdhs0j0mquVKTSE369H2ItzOD+lViULBb5t/VPNWYIexzhg0ZN5iXSt9nN9809CRgYCizPyKCFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mp2O7UM8gLmHwHcUiqTis1VHoTzZ7+MrO7hBp8xrSW4=;
 b=Qns2NWgJQb3uamxVHeI6qxRE4zQh413csB1FiL+wEqrw96EMJEnXhmwnz0Yd0V4AeyE7tSeWy8hEoqmCZQHuxoB0osxC62DxJkJUtbYkVahUwM3GMhAnRWwzv8JeKKPAI8MotVSBG5CtnCY2Mn/EriEdwlX6H1q0m2bjor/qniI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by PAXPR04MB8653.eurprd04.prod.outlook.com (2603:10a6:102:21c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Tue, 28 Nov
 2023 08:32:01 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b%7]) with mapi id 15.20.7046.015; Tue, 28 Nov 2023
 08:32:01 +0000
From:   David Lin <yu-hao.lin@nxp.com>
To:     linux-wireless@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, briannorris@chromium.org,
        kvalo@kernel.org, francesco@dolcini.it, tsung-hsien.hsieh@nxp.com,
        David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH v7 06/12] wifi: mwifiex: added mac address for AP config.
Date:   Tue, 28 Nov 2023 16:31:09 +0800
Message-Id: <20231128083115.613235-7-yu-hao.lin@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3ae09f17-9dcf-4731-a054-08dbefec7e3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t/PeriRdxqtw3fxnIpwSDBYeEP/eoi6mKddA09+NxRrE7bhs8lpJmTd70RR1C3gp8xKR+ebtGljIPNrfms7NB+wbyzU2pOwtr4OlA7bqsH5h+2SlaWP80Pu4CE4cRaL3Q7INJKhloBrrsyRAMHCUTsMsXjOS9JGJRVFKgJ6caoLCbTImSDGACqtvFJJ9sEzX7jbBzP8rE3H1qDNU4WBLpW3wpJPTx4ACIgkzaRVoEji94Zb32Drkw0tuW1zeNSj4PKfWwnjEhZ+Bg4NKyzuh7LkJIILjS+Cjr45h1PHZoTxq5mcwDCHuUhay3Lfk1FaWDSmI5Bb8pf9IbTBF6dpdae5sZHH116FlWq549gSI5KqzNciPrLnO3ttrt6rsNtYWevwafzQQeuLIOXsAjaZQA1gndSuMVKRpvNt/PJwmYtU2yZP4ocIZr/CqMHOBZMfHD51lstq2xcNHJrybqvitBZ7flEq9GzbcEnss4SCRKOxtxXsa9ZGuM1SQejGBF2RcRF3/gyp7o2MXD5tAnj9e4Qht1bJNBxfaLU2LxXtxgClnbTu638GXagzRQ1tUuZFG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(366004)(376002)(39860400002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(66946007)(478600001)(6512007)(52116002)(6486002)(86362001)(66556008)(66476007)(6916009)(316002)(8676002)(4326008)(8936002)(6506007)(1076003)(2616005)(5660300002)(66899024)(38100700002)(41300700001)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dUp6orpOzC8xeP+zJOetdlRBjw5wyt4GIL1sCPf+DDvcHLYRfcVEmJfvO+fd?=
 =?us-ascii?Q?hFKHnaVIaTFyKFm9r1z8RkYlQtYArwDoscdqxkrxBAcuMjqr0amZ3VeMzM2y?=
 =?us-ascii?Q?kKsHmmVMAPTD3lDrRiJB5EIP59kMJ9dSC4PP24SH7mgi0f9SbkcyMfa7wWgq?=
 =?us-ascii?Q?yCX7DbRg0yXtwLEavMtrgo6lI80besckt7eP77g+iYXwEpP9vlraV+B9LIME?=
 =?us-ascii?Q?wYUF/l7G+Fp6y3jkd/SCtfDiSG2nKhf047poX4cmCz0fNyNt05jXJ3yUR+jA?=
 =?us-ascii?Q?VlMIC3OMqYc76RurjRFExqLw+Sei1TpqU3asUsMTrFzu+dB+wxBXU60pMmp/?=
 =?us-ascii?Q?6etfbep7rb8OoGvi89GYm0LWQ8m02PFsUlNSBCTHamGfM5f1A9Rjaw7FORok?=
 =?us-ascii?Q?vsHoebpF7FV617ZO1zENljCQZD6aQLOfwxdyUVwlJ7pQWngIy5YPK4ZNJIdY?=
 =?us-ascii?Q?WQsLLay0dHaqHpo7BKz0z6UGb3wolPYmY7685vTdySeFufDzKX+j4qVzqcDi?=
 =?us-ascii?Q?uxaQyM8k+LF/xhKE4BYWMGx47+fRknFcE00QNaXtFd0pqFKM3G3zddZdTzp1?=
 =?us-ascii?Q?cCU2RCovwV0BlXxDcA6yhCZCs66UnQ1qySW3IMl92hdmMKn7ERiTcuk3oRSZ?=
 =?us-ascii?Q?IRVglMCp1D8m/I2PqLvgnBH3JXzbk98yiZg9xOZ+VczqVJLFD7Q1ZptF4U9f?=
 =?us-ascii?Q?kUtUlBysfhLG93yzQRSIwEwiasm5JolG8Sfvlr3t7ykhUgbtNizYhrEQ9nPF?=
 =?us-ascii?Q?wYknKsDk7zgdHoV6QyVhkYDOjsR52CfUbgHlRZzlqpXX7Zy9B7UBvem8/hJi?=
 =?us-ascii?Q?pQTLXclDAdtJhwCtk7XdSCFAdX0YZbLLMSas4cAE9m/gVdtNLGNMgh1wa35V?=
 =?us-ascii?Q?GeYoDXHBXP2jIKfXkHiE4i4P9NbVsq+NXLjYik/VMiN7BD2rwMOBc1kgGPiI?=
 =?us-ascii?Q?qcZpDRK3pjznmZWCuHsYmOZbJMdKiimyPRQJLYuaSOEIBTjymIpbMKEX3Nop?=
 =?us-ascii?Q?xx/HSVpc+zaSiC7quR3mH845eV3Do31zfzPcpoy97fa2lL7haCSz7eC3PwLl?=
 =?us-ascii?Q?db8LgKIs98z1Xp/FuikA9S/9k89eQgDncmHdDSHUB7wFx6SrMuP++uUZJu5m?=
 =?us-ascii?Q?6t56PiwoWrQnqFxWU6kRadWcXnrWmZpOnyhIQ8GdHiwD7Xcg7gWB4m/ok/xh?=
 =?us-ascii?Q?btil/Vob8NJ4hGBlFJSTXByXvqZXE/ZusQVt9GF4yG1lCB67YPD6Vk+WozPP?=
 =?us-ascii?Q?6PIJR+rBsPc9r6EhKAsM63ZTg0TOzV2GdK6oGD3anHrQMK0cT+HbeGAmmWy5?=
 =?us-ascii?Q?QkV5Egbpd4mGJ4DaD8O/SsC+uvmtn61+SeYMyNTOEqqjNgEo1aKcmQOyZYfy?=
 =?us-ascii?Q?obvBQxYTh1FT6tuId2Deg3MdujfAdi6mX5TS8uv4jUE71JU2ct03cFb/+VHG?=
 =?us-ascii?Q?EihKysJ5cdLRUsaE4YVa8EtD3eTGsot+UTa6A5+EFtr5H4NIDu73QL0Pooak?=
 =?us-ascii?Q?5pKOsrB8hldmHZH6Qp/l2IotnBOgQamEnsd6P3SUDAHnzSty70vzib9ScW8F?=
 =?us-ascii?Q?f8hO6ze/k+4AiMjGPtZ040ARHKjZsTRT0EXyZjjfsjhXK6tjEw2FrRpE3CGI?=
 =?us-ascii?Q?S+8Ss2OY6TwwO56J67ZW8h5K8XG/hD1nUGZJa/jcdz0Q?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ae09f17-9dcf-4731-a054-08dbefec7e3c
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 08:32:01.3628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5bskH+Ni/CWZNt6rXmmxQI4UeTv0eoR44FHSkBv5SHEwi02ngHoT+YIqF9jKImJr96AT68SQhY7juz8fHPU9Xw==
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

Added TLV command TLV_TYPE_UAP_MAC_ADDRESS for AP configuration.

Without this TLV command, client can't connect to AP after restart of
hostapd.

Signed-off-by: David Lin <yu-hao.lin@nxp.com>
---
 drivers/net/wireless/marvell/mwifiex/cfg80211.c | 2 ++
 drivers/net/wireless/marvell/mwifiex/fw.h       | 1 +
 drivers/net/wireless/marvell/mwifiex/ioctl.h    | 1 +
 drivers/net/wireless/marvell/mwifiex/uap_cmd.c  | 8 ++++++++
 4 files changed, 12 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index 2968db643ab4..40ab3e8d0c1c 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -2103,6 +2103,8 @@ static int mwifiex_cfg80211_start_ap(struct wiphy *wiphy,
 
 	mwifiex_set_sys_config_invalid_data(bss_cfg);
 
+	memcpy(bss_cfg->mac_addr, priv->curr_addr, ETH_ALEN);
+
 	if (params->beacon_interval)
 		bss_cfg->beacon_period = params->beacon_interval;
 	if (params->dtim_period)
diff --git a/drivers/net/wireless/marvell/mwifiex/fw.h b/drivers/net/wireless/marvell/mwifiex/fw.h
index 7080f8701952..699c7ffcd0e5 100644
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
index 80ba79ca74c5..fbbb5aafb803 100644
--- a/drivers/net/wireless/marvell/mwifiex/ioctl.h
+++ b/drivers/net/wireless/marvell/mwifiex/ioctl.h
@@ -83,6 +83,7 @@ struct wep_key {
 #define MWIFIEX_OPERATING_CLASSES		16
 
 struct mwifiex_uap_bss_param {
+	u8 mac_addr[ETH_ALEN];
 	u8 channel;
 	u8 band_cfg;
 	u16 rts_threshold;
diff --git a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
index 91a8a581e3f5..c1133da28bc6 100644
--- a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
+++ b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
@@ -472,6 +472,7 @@ void mwifiex_config_uap_11d(struct mwifiex_private *priv,
 static int
 mwifiex_uap_bss_param_prepare(u8 *tlv, void *cmd_buf, u16 *param_size)
 {
+	struct host_cmd_tlv_mac_addr *mac_tlv;
 	struct host_cmd_tlv_dtim_period *dtim_period;
 	struct host_cmd_tlv_beacon_period *beacon_period;
 	struct host_cmd_tlv_ssid *ssid;
@@ -491,6 +492,13 @@ mwifiex_uap_bss_param_prepare(u8 *tlv, void *cmd_buf, u16 *param_size)
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
-- 
2.25.1


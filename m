Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D1280B0A9
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 00:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234065AbjLHXlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 18:41:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjLHXlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 18:41:44 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2084.outbound.protection.outlook.com [40.107.14.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2281724;
        Fri,  8 Dec 2023 15:41:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RfpyFj16WPdJTXo4wO9Ao3ZkQ9bbixT1Sjj/1T9SE3iXCPyLIkrSA1xmvmaybTMpuYdcvi8t5EVY68MePCk6nDdD8RbHsa3lSJ9kUXMOeTHgUTUvwGuUQlpc5qcwtK1x75hbw7AU4NuSqwTR7TkqMuIlkvMI0unqxytR2ehYDxPTiyXME3o8zmZHpGjuqILCIufZmGTFdwU1iB4PzkQKxZSwVVpu4q/OIQ0SF1jpjRjO6QiwAjT3cVp8Z00VVd7AzWI8mASNYVbARBquQiInYb9s1iMS7sunsIBXbHWIW65ofNXpR3ZLEh1I0XbYYniGnhMkXThWXy5Ow2aVXOeLcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PNboH0XfIKfT5utrpuZZElz/9GT6KwpAkeI0DvCNrC4=;
 b=VjBnQm9igqErkiQB02smI3ZGCSQ1qojFqZCHI7Yt7JRv/VOOZi5SU2ZVqTrZcR7by50zi3WUXOPiTQ7LILhazlnXg7I2pMqbx4yqqDrRZDCp7mK275P91+oekFSNm1pnSrkHc+la/Tet+bHPRL+4M75Th9HZJXeBDFv7xsI7NIufOOLFuyvSAR0kveiCsDuuelRIB619R02Gga/NhaLrNmm0XX/0CkiudJi/kWTI9rBKbZijVO2jp+SpGhGB4f9QDRfsBLWPhoyeCXD4w6iwLjlZY0Ut3STRguj1zyq7VXKmAWCod5wdLTkATZ9nn+ogxYSvYArSuefA62QcuCDf/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PNboH0XfIKfT5utrpuZZElz/9GT6KwpAkeI0DvCNrC4=;
 b=n55NEuH9lUQ5cFoPYDsOLN3QsgqRgKFJTc7kz0gMl7ko7zGkKIwQza/6u5evlf0HIwrMStzGXmdbhmNjDGOoGXjbXDgmmEcwy5a5gsu0rN1Y87uFvu3Nc15ViuZaWtGG4Ab5vTcIw3PHcGFho1YGO8bf9qQ1+UFg7L8cAwh7ikE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by AS8PR04MB9110.eurprd04.prod.outlook.com (2603:10a6:20b:449::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.29; Fri, 8 Dec
 2023 23:41:47 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b%7]) with mapi id 15.20.7068.028; Fri, 8 Dec 2023
 23:41:47 +0000
From:   David Lin <yu-hao.lin@nxp.com>
To:     linux-wireless@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, briannorris@chromium.org,
        kvalo@kernel.org, francesco@dolcini.it, tsung-hsien.hsieh@nxp.com,
        David Lin <yu-hao.lin@nxp.com>, stable@vger.kernel.org
Subject: [PATCH v2] wifi: mwifiex: fix STA cannot connect to AP
Date:   Sat,  9 Dec 2023 07:41:27 +0800
Message-Id: <20231208234127.2251-1-yu-hao.lin@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0056.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:384::18) To PA4PR04MB9638.eurprd04.prod.outlook.com
 (2603:10a6:102:273::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9638:EE_|AS8PR04MB9110:EE_
X-MS-Office365-Filtering-Correlation-Id: 347b1a54-6ab4-4f9c-a2ca-08dbf8473e6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aQtRmxeMYxil/16Pw/gZxN6nQeIRT3rNf1lS85LIt3kBvYEo2iZay8isViyC25GhcnALJCpL+aLUNNkLQPT4dR+KFI8ZoZFYymzrgbP09F01KOc9By3Ow6GwZnL2I8nXOFpWoVGimrICCZaL0ZuxzdYxjV2l8+ZFlmLW5obEmvJV+ctfnuwsaJqKFQ38EjKeyZpss6Bde9Y7o1pGeQTd+Ck3eWIbDOVmddwZz1eQ3fxi4pY+A/ow0t1KgerdZHNWjIc6jb8deVBwnFQYLPaN2Dfx4grVqSW7rOgKsTMLk3dSeQC8x6oOT7tR9D6u3Ri38IqmumEZrHx/DEwUajQYKj1/bysWYn0MDwYY2jcyD/HEKjPLtHBa+VaY+MTSmaKIICDh6PPtbLzXjt824h4Zi6WfIBLTC5zFjrf6zxqypWQgl2Qt5sLZM06y7ZGmpZQuNG5qWU4UjSP+RWOZsmrpd4YXCT2xHHqfw+JrXK0uxk2LdD8S2pKNnyn9ki0llcRN/hdCHL8B6OH9K7wC8KfP0h/StotYAawpYzv5TTVMP+SS5gMbQGRvP3HYppOKYRYi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(396003)(136003)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(1076003)(6486002)(6512007)(2616005)(478600001)(6506007)(52116002)(6666004)(2906002)(5660300002)(66946007)(66476007)(66556008)(8676002)(4326008)(8936002)(316002)(6916009)(38100700002)(86362001)(41300700001)(36756003)(66899024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kB2g2G5InAK1ZFdZG5Xk4ARUuKNoxmMyfl2IGLGA9pFpqmHWhD4yH19xPOFh?=
 =?us-ascii?Q?qo5SFtxV3zwFuZ7198GHJJreiSHo+7xOmbDqdGtqEYngyjDxqX/R70s4J3Z7?=
 =?us-ascii?Q?qUUUH7O+asd++g9Yz365aZBHuldU9d1MS6jYOAsHojopmnDXU1+CCwV1gi6v?=
 =?us-ascii?Q?BTMhsYCChnDqRLytwcC2Rw0/SGx/wFsQ2pSK70o69q776+fqiEJu1XcSVFL5?=
 =?us-ascii?Q?98e0HrfcAzQPw0kzhFPYKAOgoO7HqEzrm8uiict4QRyBR5GXOpUhSgII5Vaa?=
 =?us-ascii?Q?BfdFQW8SAQpIQP4RgynNcWgr05cfJ40IxlV7ULVpPQCR8E5Zz31Vp0uj2KaN?=
 =?us-ascii?Q?AeZj1daZKHnp/6XVs1Dwu2kQMh2CnubiMuLYGzc/ZCcDdRGtEROQklGfhEBE?=
 =?us-ascii?Q?09kmTSZK5chxxI3G3ShKXPXDTwdiD2yf6z9bPsXIRpwCEJaxZ1KmNFhjkotq?=
 =?us-ascii?Q?2QhDCuFbzW+VQofwbQ6S3cIf8xe3ymyzm2Cq+jB0PpsrpIXF8GyRYu+OuinX?=
 =?us-ascii?Q?qFGeRwrKBk0qU6pgCznoy/PZectIxS5KrRS++5odDBK0FPnnUigQz+Fxtnvn?=
 =?us-ascii?Q?wf9nDAZxLqRsFX99IW+7d3O9mRuqi+zoKErKyqwLrT03P2J8RA9s5qrb/aAK?=
 =?us-ascii?Q?npTE/3sSaemCFTJv5wTseh2UzlX4hM0osgdcsEJ+IMBDyT1Auf9kPzOLUNmu?=
 =?us-ascii?Q?Uma53bayyv1N9gZFr0ymAFr7ntGJqKx8qL01C8Zbl2k8n7rsH9UE+NO9LcAb?=
 =?us-ascii?Q?3CnJcRcyfU+TgC5d9DAcbnqQQhDNdfazNyTc/+kJKqB2rTR2kjBOLbUpR8JI?=
 =?us-ascii?Q?CuEDZsBdOqv/C0Cz6JA5UhIKSUhrXnkK6cEl2wx/JVJEr8lptC7h3T49jE6f?=
 =?us-ascii?Q?rvMOF5M2yJTzTV83qrGzmuRUSOQMMC4Uwq7WEvcEBQFW0FN16nka1sS7WLxu?=
 =?us-ascii?Q?GCRTE4Vv2Kl/OCdSxAW5bE8fqxeAKTivaasp2cjAHvfJUxt9iCK3NOM7cE6Z?=
 =?us-ascii?Q?KE7cWLnpdVhYcQc7ip0lUpfO5Ki5pJHBK2dFm22EjPrAb9Kdi80jpyJOYSyz?=
 =?us-ascii?Q?hGawlM4igiCyikPV+mZE/AJ8oEOZ6+s6/lTE4zO1Axa9XN1kXfmngpaw6Eej?=
 =?us-ascii?Q?YCGLgDgoFfyOVNIFUN8S/SH3lYLcw3U5lupr9V+otCvS6bPdRg2CANODSbCo?=
 =?us-ascii?Q?GbDINFMA2X2FB1Co93qGCRNc1pXa/gQ+PDn6iuTpCx1zR/OZXHd3dyEjgn/k?=
 =?us-ascii?Q?lphVUpz8bvXPL/ot1+QD1wfTMF7Lofw/AnbkhBQhxYoTNrdg4bR0MNHo/eOc?=
 =?us-ascii?Q?EBMmX0+FG+G5inpwpo+2wp+N0T3jFzzjy7sIX7gpCLREjx3zplGyXy/8w1ba?=
 =?us-ascii?Q?9jSdI0zq0oJVtT+Mioi9t/BkK8phMmvawbZU4VnZHn1S0YU3V2/f6DuzVd3n?=
 =?us-ascii?Q?wNeRE88GwGqf7VBSsGFHmctwyNMF7VYg4JM+CvcohelncebbmZk60W0gdS20?=
 =?us-ascii?Q?fzeVDTcCTtiCp9czG7cpU/Q+pwvDa952K3V7DShCtTXiBw77r6MFmqubSAWN?=
 =?us-ascii?Q?QVibYGNoTCzGazqSoQ5rW/bx80rEOBZ+ggC2CybH2CTGPwOKz+Ul3DVLzui6?=
 =?us-ascii?Q?pw1DWJY5Po6iaA7xJfJc1t7DQbJoUoTDmo0PGD30fhjp?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 347b1a54-6ab4-4f9c-a2ca-08dbf8473e6d
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 23:41:47.7967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: myaOMbwfqxqgVR1S7hw1mBwYdlY9zAc+c+K6T9KtSh4N1fvCy/4wie06AP6UdVfr+P4WnkMAz7EHJY0PRgzeUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9110
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AP BSSID configuration is missing at AP start.
Without this fix, FW returns STA interface MAC address after first init.
When hostapd restarts, it gets MAC address from netdev before driver
sets STA MAC to netdev again. Now MAC address between hostapd and net
interface are different causes STA cannot connect to AP.
After that MAC address of uap0 mlan0 become the same. And issue
disappears after following hostapd restart (another issue is AP/STA MAC
address become the same).
This patch fixes the issue cleanly.

Signed-off-by: David Lin <yu-hao.lin@nxp.com>
Fixes: 12190c5d80bd ("mwifiex: add cfg80211 start_ap and stop_ap handlers")
Cc: stable@vger.kernel.org

---

v2:
   - v1 was a not finished patch that was send to the LKML by mistake
---
 drivers/net/wireless/marvell/mwifiex/cfg80211.c | 2 ++
 drivers/net/wireless/marvell/mwifiex/fw.h       | 1 +
 drivers/net/wireless/marvell/mwifiex/ioctl.h    | 1 +
 drivers/net/wireless/marvell/mwifiex/uap_cmd.c  | 8 ++++++++
 4 files changed, 12 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index 7a15ea8072e6..3604abcbcff9 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -2047,6 +2047,8 @@ static int mwifiex_cfg80211_start_ap(struct wiphy *wiphy,
 
 	mwifiex_set_sys_config_invalid_data(bss_cfg);
 
+	memcpy(bss_cfg->mac_addr, priv->curr_addr, ETH_ALEN);
+
 	if (params->beacon_interval)
 		bss_cfg->beacon_period = params->beacon_interval;
 	if (params->dtim_period)
diff --git a/drivers/net/wireless/marvell/mwifiex/fw.h b/drivers/net/wireless/marvell/mwifiex/fw.h
index 8e6db904e5b2..62f3c9a52a1d 100644
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
index 091e7ca79376..e8825f302de8 100644
--- a/drivers/net/wireless/marvell/mwifiex/ioctl.h
+++ b/drivers/net/wireless/marvell/mwifiex/ioctl.h
@@ -107,6 +107,7 @@ struct mwifiex_uap_bss_param {
 	u8 qos_info;
 	u8 power_constraint;
 	struct mwifiex_types_wmm_info wmm_info;
+	u8 mac_addr[ETH_ALEN];
 };
 
 enum {
diff --git a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
index e78a201cd150..491e36611909 100644
--- a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
+++ b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
@@ -468,6 +468,7 @@ void mwifiex_config_uap_11d(struct mwifiex_private *priv,
 static int
 mwifiex_uap_bss_param_prepare(u8 *tlv, void *cmd_buf, u16 *param_size)
 {
+	struct host_cmd_tlv_mac_addr *mac_tlv;
 	struct host_cmd_tlv_dtim_period *dtim_period;
 	struct host_cmd_tlv_beacon_period *beacon_period;
 	struct host_cmd_tlv_ssid *ssid;
@@ -487,6 +488,13 @@ mwifiex_uap_bss_param_prepare(u8 *tlv, void *cmd_buf, u16 *param_size)
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

base-commit: 783004b6dbda2cfe9a552a4cc9c1d168a2068f6c
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A807FB435
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 09:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344152AbjK1IeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 03:34:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232422AbjK1Idy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 03:33:54 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2050.outbound.protection.outlook.com [40.107.22.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C47D56;
        Tue, 28 Nov 2023 00:33:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IY6Jk1ZmfyMEfLCLEOg/fS2ky/j1LvAFSsd9NFFk1lDRxXbxhARAG8Qo4rqVXQlcutv7doBqinpLim/RWj6tJnaEVeVoatKsNCrNMJmKS1IE9w1RQvuBIa8gtXrQUtS2XRkyLWB4CAp8dRGvihAC4YE13mD86hfYhQd4U86LEEIj7gtz6q3Ve3NA+AuQrvm6ZRfitJq+9dnjlRk5RgW4p2B+hpw5oIH4tEbAvXku9THUWSGIif/Jwy95FW/RkVdbeChn5/ApHhLQ9RB0EjqQW3f3QdPV4APKLLGkr3FpQdTiiJiLshjX/AWolEc6G2+ePZOXmGn5mtl710OzhGJTqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ObAhNAFRkqzLbzmid5PnkGoNqrKaVeHOcSzklM/w//0=;
 b=Hl6Utxmq09n0klo9VlW8+MFXrquVs3HV5qKjv3y40coPqNQzdo41M3atzj32hRdWeAkHlwNc6BYPvEz4HjuMWfXEvY68z0AwnG+i/6KfsmlfC3Azb5OmmwsXU5zTAAYLErux96v/3LnbDET9nxouGklg3vpkg6lmlORp8V5KX3IAPEwFwckT6175QYseibRX/SR9KEpKafSb+MKn1VN/ELdIvpV8WljyM82vMY/HKxFtw3d/tjdB9x0F7/rLzOVEsqvDu+mGYksN1B1Z96avNSJ7TDkR1xgXjZd29aRxya3/FL7ikObz3FpGj6tjSJRpijiJnMveanNP91ZCHHQKoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ObAhNAFRkqzLbzmid5PnkGoNqrKaVeHOcSzklM/w//0=;
 b=FK9vWYGNAVJ8ppOUwHVlmKqDr5lYCb00Pg4vdlXs6Dmh9xKYdUkQcgKMm9J0HqhvJ81C9xq6/OLTqTRuKOaFyYnuF3BuBnh64n7GjndhHjXXoTl4PeiVTfyoddqqXccUaeQhXHTd5BxX8l198peWsKA8P+SGFkrzivy7ElDlJZU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by PAXPR04MB8653.eurprd04.prod.outlook.com (2603:10a6:102:21c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Tue, 28 Nov
 2023 08:32:19 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b%7]) with mapi id 15.20.7046.015; Tue, 28 Nov 2023
 08:32:19 +0000
From:   David Lin <yu-hao.lin@nxp.com>
To:     linux-wireless@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, briannorris@chromium.org,
        kvalo@kernel.org, francesco@dolcini.it, tsung-hsien.hsieh@nxp.com,
        David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH v7 12/12] wifi: mwifiex: fixed compile and coding errors.
Date:   Tue, 28 Nov 2023 16:31:15 +0800
Message-Id: <20231128083115.613235-13-yu-hao.lin@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2af1c722-dedb-4648-3ab6-08dbefec88c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hASxrlyd+LzoqYZz84iCzm5fqsDmHiLpgCAN7px9J+IWS6btGK+1gBF3twyxWn3DHST57Q2ZtNOUeeSLov+ISg8O6cEzcdrDzrk6HJboJc0AnbdVqDRcCiJzLk3CVLm7MwNr+MNbPkH/HL8cEs98agbls5t3LfACt4qwaU2+KumbnCShCvKoTbjqZ3k/r6rU68PEBZUjnUwkynaqUiRF5k66xHQfjcgznyIjii6LhZczd5+FQfFHkEZAAC3mNwRUzFkyLquCrsGCdHx5X/dC2UNya6OWut8/4ZDTrh4ohcQ90HMncd1yzi2j4S34s+HGTSuPbYcqYDIAY6uTnFXNHzExfNvyKOiO2uukelh78WPsbu8EbMrCcje/94lxUN3H3G8HKpXCHHhUvOsSfUluUswvi6T6qXYeUvBvTRJzAmLx4GqeM4Hx/yDOJeDmU0od/t2Xcmb+rOZ+HMUhZeqg6vhItUhjL28HOTk7i/UX3LXj/op2CTPzZtEmW6o4PqBwaAXudsQAUbpR9MrGXNxzY8sB4w4/xVV8NoT0PC4gBkJlqtovfgPE+HLsm348XRs/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(366004)(376002)(39860400002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(83380400001)(66946007)(478600001)(6512007)(52116002)(6486002)(86362001)(66556008)(6666004)(66476007)(6916009)(316002)(8676002)(4326008)(8936002)(6506007)(1076003)(2616005)(5660300002)(38100700002)(41300700001)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Cf7K+EW/tfsGMPSr8dZfjELNhX3zMo8tluMWpl2bw8+2/MUy7FIBsuenhVt5?=
 =?us-ascii?Q?FPnUleE11CsXiWi/+MADnhk4vQSzHTx9q9CL8EJFM429Vbheh4kc4ha/8KD6?=
 =?us-ascii?Q?dymu9Q8YUOFP5Z2cukNwupE/MchAjBRAQHG3WLpG3413YLYr3nh9/tk6GXVI?=
 =?us-ascii?Q?3p1lqTDKFS1fJX8lTALZTFVFHodYfLHgfuEKU3TUmZ5q2I7QC4u4F29D2+8L?=
 =?us-ascii?Q?cTkD8H2HelCyJxyzu7EV8cQDzOkksojMQlEMyOGerTRryCyagaWvQC43O4J8?=
 =?us-ascii?Q?/uexlgnODWQjGbowVnj14yiAx1yUQcWU06tDhvQLTt8bzGN6liKIbSUb5hNb?=
 =?us-ascii?Q?VeMpn2hVUiG5lulh8fqyA0T9Pah9lB91VmYnHzY4BKuz1cW/y4Z8CSoGTZZa?=
 =?us-ascii?Q?NgqFD46kh+7aKdZCWlKWcucNM2avT8qpHr6Q7ftHSawInTJejuF0XgRWojtY?=
 =?us-ascii?Q?OEeUPZFGXLv0qCpC2eyohE+t4V4YgP7i5SkQVKUYnlJYbOzwcL9PiW1HDVL+?=
 =?us-ascii?Q?vcrdbb0ACby8D9kTz7WQbhwj7KmhPFC04dgYjujsJHbIrMWDPjiDrPdGk4D3?=
 =?us-ascii?Q?TA8CcXdgZybuxJ0It90Gb4q5G4vTR1QmrcHep6+fx2RytWpBxRDGtzHelV+T?=
 =?us-ascii?Q?z8CmepCRFNEX4gPqaI90ke0NprxGnl3nDR/Fjdy0RVfEkARnXzTlsCpYm9pm?=
 =?us-ascii?Q?fVjvsxOPCqvFheG8QMb25yqrzMFBh8QpuPYWehHa1/w3ilj6RPsNCFH3C94n?=
 =?us-ascii?Q?1e7N9hNpLH+nGnYKN+5SyT8j6uYUkgMums3tavYVMKipZrlEspLTOfTCBkBJ?=
 =?us-ascii?Q?AZJssDY8BmLG2hl/h+H/GhUKjng1T3rDGyHZ+rm4urhqmK0ofozi7ZNVg67P?=
 =?us-ascii?Q?PBcxf1x1F3Uc0pp2hBYRimuX0HcoLGb0nJcsftl2l9hQ0zCMcZ7WMsI5/4iC?=
 =?us-ascii?Q?ilQtEpXsRbNfW6coOhHDuAUszzDaroYKjVp6LIeouAZfpftkJn1D3lbygbLE?=
 =?us-ascii?Q?tNIEkcvfy1bn026e2Ck0Lst3yMRPo0e7gvrFOtIVrE7hnSMS92ICrTg/QXXe?=
 =?us-ascii?Q?f461Tv5j2iBtvuZlCCMB48xHXJo+XxvH1sdJlas5tK+fMQFAV3nptkQIwD4Z?=
 =?us-ascii?Q?WV2xyiTyesNML5mUXQkD1bFB4EWQl0TEmpgKXasslViaFpTk5tcYN1o4zb5r?=
 =?us-ascii?Q?OqKNHbeqvYqtoDGJ5X4RcVJK/XzRw08dtyUuWF5rHxwioz+t14gA5kmvS9N5?=
 =?us-ascii?Q?Vg9n1AEUZeJUG+ytRhY0irPruCSjqwtEoKToKdAfDb6NBGOqhK1+vSYuPcw/?=
 =?us-ascii?Q?xCXAMRfHUHl9zKnsj53fXspmRLun1oKQgR3sRFtWqJKlIMgT80DwmOelbAQJ?=
 =?us-ascii?Q?is7yQt5bUqaQmAfW1dfEMXukXEli5Xy6VRNvELd7gmXRPjve+Ji7hUdPzWAq?=
 =?us-ascii?Q?NsbEvehcM3+yOraqLXx2ZjCTystMWA7B8oaZBM6Mvopl3we+HGMfWID6CRWR?=
 =?us-ascii?Q?fyCBUY5pddxf/2GsUZF5OL9iUlKjdoRd0qbOWjF9If387tk5YKEFMAPsMRBg?=
 =?us-ascii?Q?VCIUv+laoIGnb7Ynz0sNoX7uqOXv4qYDCuLgE4oBCFEUqDhmx5HTSD0bD1JR?=
 =?us-ascii?Q?01zU50ixl112P6hBqMUg6r07gjpdnt9Uztgp+4VvjhPG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2af1c722-dedb-4648-3ab6-08dbefec88c5
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 08:32:19.0469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WWRZ8g3Q1+//D88s8ADndv0yU+ooglnaQUvRBVcqkrK+gZzessVAmZ9253tMMNazNxhmEKld5rte6jFWZUxl/w==
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

1. struct cfg80211_rx_assoc_resp -> struct cfg80211_rx_assoc_resp_data.
2. Pointer should be used for memcpy.

Signed-off-by: David Lin <yu-hao.lin@nxp.com>
---
 drivers/net/wireless/marvell/mwifiex/cmdevt.c  | 2 +-
 drivers/net/wireless/marvell/mwifiex/uap_cmd.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/cmdevt.c b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
index 85429c51c407..63246cdfed65 100644
--- a/drivers/net/wireless/marvell/mwifiex/cmdevt.c
+++ b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
@@ -928,7 +928,7 @@ int mwifiex_process_cmdresp(struct mwifiex_adapter *adapter)
 
 void mwifiex_process_assoc_resp(struct mwifiex_adapter *adapter)
 {
-	struct cfg80211_rx_assoc_resp assoc_resp = {
+	struct cfg80211_rx_assoc_resp_data assoc_resp = {
 		.uapsd_queues = -1,
 	};
 	struct mwifiex_private *priv =
diff --git a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
index e393cc78bb98..1ed3ba6aaefe 100644
--- a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
+++ b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
@@ -910,7 +910,7 @@ static int mwifiex_cmd_uap_add_station(struct mwifiex_private *priv,
 		tlv->header.type = cpu_to_le16(WLAN_EID_OPMODE_NOTIF);
 		tlv_len = sizeof(u8);
 		tlv->header.len = cpu_to_le16(tlv_len);
-		memcpy(tlv->data, params->link_sta_params.opmode_notif,
+		memcpy(tlv->data, &params->link_sta_params.opmode_notif,
 		       tlv_len);
 		pos += (header_len + tlv_len);
 		cmd->size += (header_len + tlv_len);
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 473B97FB43E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 09:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344170AbjK1IeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 03:34:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjK1Id6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 03:33:58 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2086.outbound.protection.outlook.com [40.107.22.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FDB519A3;
        Tue, 28 Nov 2023 00:32:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bKS474wcTWHiS066RhS7xLu5TunOXfGq+Zr3b5eYDk868z7Phqb/vRVkRWJeP2fq1+WomQdoC9x79V5/0ak0FeyfsQzRKuwJUrScwQIztIDNFEao6Dw8zmEnWxrBThMeA0GPdqoDIXpmKAVIsOtTO4XsSWcZUbAoOvPlF7QH1Bd+44HYxsbydIFaKKhQG8tDROWqvYwAmGZaPU62I+Qwp1qKsAEv7fBlPaSZZrZeVID9KIiDXl8npsBXWDDc1hMU0ccYuG2FYP15ROg9AL6s2E5q/5yiQ9sbJv7x+nlqThoh+5cl3boN4AZDpu1t/5AwMXHoqgVCvutY8haxCj/SJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0nG190phW/zEeDWMzaxJTOQNoc728q9tAnr7iDWpFTA=;
 b=djVZxSbIkzxUYyxCPwk+MZFZu8C0c/XLkKq6qrIgiC+XsQ7DJPwxvXRmk/OwS2bldeLHlT4b1eIW3oi3SRQnmwAT0YnMEDmLPdHhTij8VbyClG6T89ecDLs4AiFcmwXqnebQ2QatKGsnH/JAG7ms21RjpiUnIgrg6odAHdeGCpIy8k/HeE+SKmDi8QN+/fxqZz0XnpPtqhQgEwQsJ2W4YpYFHl6E+wVjtaEknDtMhc47r1RNrWG7pe4V9bcaDdHE2aMxwjgYGKo6Mt0cfKgClIGtN/21TsGJIXKmGMRU3VM/GdwDeh7mt4ono9DxdVJ9BjPfIk7t1XYH6TwxxYdCTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0nG190phW/zEeDWMzaxJTOQNoc728q9tAnr7iDWpFTA=;
 b=IHy6OfV53L/7JUfb9qjWQX/LqgtnlH9+0w9Mx8TY8Xbt1rhAq/70wSr+8gJJ+k3WnmT1Om1w1bKqgZRdgw7juqo3lVCzQ01q/A5oikT8IaVi1Y/gLU7xha6+a/ph/KWT1tncqgqawrZIDJ2zXUhvX6qdM09C32PJcHBrHTE1iO8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by PAXPR04MB8653.eurprd04.prod.outlook.com (2603:10a6:102:21c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Tue, 28 Nov
 2023 08:32:10 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b%7]) with mapi id 15.20.7046.015; Tue, 28 Nov 2023
 08:32:10 +0000
From:   David Lin <yu-hao.lin@nxp.com>
To:     linux-wireless@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, briannorris@chromium.org,
        kvalo@kernel.org, francesco@dolcini.it, tsung-hsien.hsieh@nxp.com,
        David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH v7 09/12] wifi: mwifiex: fixed the way to handle link lost.
Date:   Tue, 28 Nov 2023 16:31:12 +0800
Message-Id: <20231128083115.613235-10-yu-hao.lin@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6ae21bca-303b-4fd6-cab5-08dbefec839f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7W9PXM8iyaw5O5rglbWFIDp7W3jsoMIBo/F0vk2r08r+k5T8p6ruG4ML1TNDWFkhJDFVFeNU8NWo9JCfM5o8wAAW/emjMvAU0tETa5Uf9e3Dzn7bs+JdfF6pSdCt3sau8UeJuDSMYJbvak/PQZTrBoqBxRoIiKNr86YcoCVyHREmA41+7rvJ5QpgQhBY7+BmD2oInbhbzxTr4g+6nuf1TS+4ZCdTkjyN8MODGyqxx1LLvIU2RcK7iSL2hl9YwpydReR5EaGX6eBIQIHgjp1h73C9sNq9Q5Uk4ODKebJbMj+HsAS7R2lW16ns7O2v5wOTDg+AjBTwFMZYkOTQbC6jGksf+J26gtgvmlPj55lc84c1ENLU4jtw+AJ58AFoUlq95h2Yo2yF80dNswwodg9YKkZQGIykxgmgUN/xwCMnTlRfP2H/uTb3iE0GBnreVsU4bal3n/5Pu/0dRxoqN3/MWIaUeeME2qPIkDU4I5DCi3gagC2s8vCaQBUCD6cftu4KhfHaMwogitRuj2527dB2N6JrUWiFjYH/BLVMlBCqIfWopDtuQoNetyNBH7F8xW8waCAYwQws9tc07dRdXIkGh32L38eTU2UxcDWsuYWxR7I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(366004)(376002)(39860400002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(83380400001)(66946007)(478600001)(6512007)(52116002)(6486002)(86362001)(66556008)(66476007)(6916009)(316002)(8676002)(4326008)(8936002)(6506007)(1076003)(2616005)(5660300002)(38100700002)(41300700001)(2906002)(36756003)(43043002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UaLe/ZRZBYX/SjqQyWqSwdV92+fJNmmAmbLznsl0l6c/V/uRl9mYuwRr19CU?=
 =?us-ascii?Q?EaeY3Nr/lz8FOD4imHLN9yxjxlGB0zy4Mtlv1v+WBwfGMrI03NT45nW4myaF?=
 =?us-ascii?Q?TL+mtytlZhoJmJ+rahumH56kHg0Cm5CPOHLKbxJpkCRxUWZU9N52JNwg7ZO7?=
 =?us-ascii?Q?H9m6nDDRGXNjYuHohNwnk19OP/MGtwE0qdsZK6/+u9J2JmgJSPHKdmeHGnW+?=
 =?us-ascii?Q?0ELrDtID6dAsD5rvWLvY9EF228BgI1/gQXXXJSksw4uk2J0Ud1M/Vse2cqpM?=
 =?us-ascii?Q?BZBzOHaAGqeITGwx5iHImwOrLWizleUGZCuFE/kGn4FAMAOpw0XawQuC8XzA?=
 =?us-ascii?Q?6BQeu9hPJkeHgwAb6OpdSsFE4SZN2sVPbjYAdKaVCcnMapVBqIqvKecHQLuF?=
 =?us-ascii?Q?JoM3z6wWpyL+MmC5n8chNg+gp9aV/f/HfP1USN8VWfk2VQKwEuFYzgrHUN13?=
 =?us-ascii?Q?dmJli5Qmva4dBr9fc0HMHxcw0ci9BY1LzMXeMZDlHxVMb4JNVnC4XQs0+UeF?=
 =?us-ascii?Q?x3++ikEmAH/BRbVEo+FfkgGr/eEvIYjx0mvfsASgZkHg1JyTvGd92tVE8J8l?=
 =?us-ascii?Q?kPHi5cdR1O/snkJBhDtgmV7CXSqv3kOGseMWY33VZEkQL/tkLX6Ur3u5Tsjl?=
 =?us-ascii?Q?UrlOY8o/ztpEBtzrB68JOBSkB+wvTwlVRY9XEaISqaz9hPPb7+wuDYRhugzF?=
 =?us-ascii?Q?Sjzg/Y+cwwadQyKioPG0W7QHY9I6MSOQC51s432nM0j/kPFX0ww4zL1EXphT?=
 =?us-ascii?Q?40xwWjD4qjdcX4zSH3InB7tx9oGLfZWFW3z4HrvcpEU2WkJjr+3rys/uub9W?=
 =?us-ascii?Q?CJHGZV6OK5qGVwr30TZsqkZ12EtXIhm4WFvfFnZpWTefcXrnJR54kga+XuJ3?=
 =?us-ascii?Q?3mkrYNlbZ74xqJawVCwMfHPhJFKbgdiqvol4olYw/5XA4HH3kGwV5RnoNpyg?=
 =?us-ascii?Q?kQI84TS3NNQL314VApLIFxkkd2AwUL/vM28vL5jgHOWhE+1rFO66UL5Cedxc?=
 =?us-ascii?Q?7DiGrJ2qujvIZ9j/SnZDI1M/BRP5lgVzcrMKrYzMmWcYbSJFEtAyuYkRMmWv?=
 =?us-ascii?Q?aTWJNreUIqxwm/90AzQtwvOnPcQgNqmR0LEPLLqBZoBZxyLKlb0Zys2Tt/YT?=
 =?us-ascii?Q?R3dXQ9a+/fmGwnlh3ItZzsgQQldWdxVqlL3u1w/rPboRtYsZaTTCK2uMA1Ao?=
 =?us-ascii?Q?AmD4VXBUTxd/D+mWI1CbtgE4lfCjGLsZGafe1mu8VxghdHMHpTjKCsYV1wHS?=
 =?us-ascii?Q?UWLmJ8hE9DhaKbkIDJ/OEzv2d6CWTPNE48eeNddMniu/OHZp5C4Msm2v+fU/?=
 =?us-ascii?Q?nINJwCgqdtrFDY//C+wY4/YpRWSDtdwfiw/6ZXdVKxXZWmW9acMdDcFnLf2f?=
 =?us-ascii?Q?DGzlTGpPXVv06KcBxfdA8de+wevTUJgihp0C+AZKGx7LD4MdPnoB7FGiwwWz?=
 =?us-ascii?Q?8vwOAjuOpblxGdxxYLuLakXNyCSjCMElaLVnnwXM/tOdBy7USw2HM6vvckNI?=
 =?us-ascii?Q?qErBrbJ6Ns2/Oc39+vzeNYlx2Zx962B0rzzyswse8K5ofByVZiRpIdDU+1Zi?=
 =?us-ascii?Q?kRpc4DXngLExYeWRlWGEj7h2TC/n+m1y6K6eFr1i6eI3FZbL/CfG7rPvlO+3?=
 =?us-ascii?Q?Tqyf3aU5gRnH/pXKKnX/ZZijxJV8Hmv482hd0TjoXkI1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ae21bca-303b-4fd6-cab5-08dbefec839f
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 08:32:10.3930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I9/GbXSUhmRKx/7wiSCcG4MyDVptcj6oEQrj0a0PjqsUsjHv/EoIXJ7igd4JZcgTmQo9RbMd87FsgcNyVDiAeQ==
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

If host mlme is enabled, event EVENT_LINK_LOST must be handled with
sending deauthentication to upper layers.

Without this patch, if AP is leaving and station won't receive
deauthentication from AP, station won't reconnect to AP again.

Signed-off-by: David Lin <yu-hao.lin@nxp.com>
---
 .../net/wireless/marvell/mwifiex/cfg80211.c   |  3 +-
 drivers/net/wireless/marvell/mwifiex/init.c   |  2 +
 drivers/net/wireless/marvell/mwifiex/main.c   | 56 +++++++++++++++++--
 drivers/net/wireless/marvell/mwifiex/main.h   |  4 ++
 .../net/wireless/marvell/mwifiex/sta_event.c  | 18 +++++-
 5 files changed, 73 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index 40ab3e8d0c1c..588a500fe1b9 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -4556,7 +4556,8 @@ mwifiex_cfg80211_associate(struct wiphy *wiphy, struct net_device *dev,
 	if (priv->assoc_rsp_size) {
 		priv->req_bss = req->bss;
 		adapter->assoc_resp_received = true;
-		queue_work(adapter->workqueue, &adapter->main_work);
+		queue_work(adapter->host_mlme_workqueue,
+			   &adapter->host_mlme_work);
 	}
 
 	cfg80211_put_bss(priv->adapter->wiphy, req->bss);
diff --git a/drivers/net/wireless/marvell/mwifiex/init.c b/drivers/net/wireless/marvell/mwifiex/init.c
index 4326e03a66d3..87121018abc6 100644
--- a/drivers/net/wireless/marvell/mwifiex/init.c
+++ b/drivers/net/wireless/marvell/mwifiex/init.c
@@ -224,6 +224,8 @@ static void mwifiex_init_adapter(struct mwifiex_adapter *adapter)
 	adapter->event_received = false;
 	adapter->data_received = false;
 	adapter->assoc_resp_received = false;
+	adapter->priv_link_lost = NULL;
+	adapter->host_mlme_link_lost = false;
 
 	clear_bit(MWIFIEX_SURPRISE_REMOVED, &adapter->work_flags);
 
diff --git a/drivers/net/wireless/marvell/mwifiex/main.c b/drivers/net/wireless/marvell/mwifiex/main.c
index 1dac77946813..f8cef2673502 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.c
+++ b/drivers/net/wireless/marvell/mwifiex/main.c
@@ -365,12 +365,6 @@ int mwifiex_main_process(struct mwifiex_adapter *adapter)
 			}
 		}
 
-		/* Chekc for Assoc Resp */
-		if (adapter->assoc_resp_received) {
-			adapter->assoc_resp_received = false;
-			mwifiex_process_assoc_resp(adapter);
-		}
-
 		/* Check if we need to confirm Sleep Request
 		   received previously */
 		if (adapter->ps_state == PS_STATE_PRE_SLEEP)
@@ -536,6 +530,11 @@ static void mwifiex_terminate_workqueue(struct mwifiex_adapter *adapter)
 		destroy_workqueue(adapter->rx_workqueue);
 		adapter->rx_workqueue = NULL;
 	}
+
+	if (adapter->host_mlme_workqueue) {
+		destroy_workqueue(adapter->host_mlme_workqueue);
+		adapter->host_mlme_workqueue = NULL;
+	}
 }
 
 /*
@@ -1394,6 +1393,35 @@ int is_command_pending(struct mwifiex_adapter *adapter)
 	return !is_cmd_pend_q_empty;
 }
 
+/* This is the host mlme work queue function.
+ * It handles the host mlme operations.
+ */
+static void mwifiex_host_mlme_work_queue(struct work_struct *work)
+{
+	struct mwifiex_adapter *adapter =
+		container_of(work, struct mwifiex_adapter, host_mlme_work);
+
+	if (test_bit(MWIFIEX_SURPRISE_REMOVED, &adapter->work_flags))
+		return;
+
+	/* Check for host mlme disconnection */
+	if (adapter->host_mlme_link_lost) {
+		if (adapter->priv_link_lost) {
+			mwifiex_reset_connect_state(adapter->priv_link_lost,
+						    WLAN_REASON_DEAUTH_LEAVING,
+						    true);
+			adapter->priv_link_lost = NULL;
+		}
+		adapter->host_mlme_link_lost = false;
+	}
+
+	/* Check for host mlme Assoc Resp */
+	if (adapter->assoc_resp_received) {
+		mwifiex_process_assoc_resp(adapter);
+		adapter->assoc_resp_received = false;
+	}
+}
+
 /*
  * This is the RX work queue function.
  *
@@ -1568,6 +1596,14 @@ mwifiex_reinit_sw(struct mwifiex_adapter *adapter)
 		INIT_WORK(&adapter->rx_work, mwifiex_rx_work_queue);
 	}
 
+	adapter->host_mlme_workqueue =
+		alloc_workqueue("MWIFIEX_HOST_MLME_WORK_QUEUE",
+				WQ_HIGHPRI | WQ_MEM_RECLAIM | WQ_UNBOUND, 1);
+	if (!adapter->host_mlme_workqueue)
+		goto err_kmalloc;
+
+	INIT_WORK(&adapter->host_mlme_work, mwifiex_host_mlme_work_queue);
+
 	/* Register the device. Fill up the private data structure with
 	 * relevant information from the card. Some code extracted from
 	 * mwifiex_register_dev()
@@ -1724,6 +1760,14 @@ mwifiex_add_card(void *card, struct completion *fw_done,
 		INIT_WORK(&adapter->rx_work, mwifiex_rx_work_queue);
 	}
 
+	adapter->host_mlme_workqueue =
+		alloc_workqueue("MWIFIEX_HOST_MLME_WORK_QUEUE",
+				WQ_HIGHPRI | WQ_MEM_RECLAIM | WQ_UNBOUND, 1);
+	if (!adapter->host_mlme_workqueue)
+		goto err_kmalloc;
+
+	INIT_WORK(&adapter->host_mlme_work, mwifiex_host_mlme_work_queue);
+
 	/* Register the device. Fill up the private data structure with relevant
 	   information from the card. */
 	if (adapter->if_ops.register_dev(adapter)) {
diff --git a/drivers/net/wireless/marvell/mwifiex/main.h b/drivers/net/wireless/marvell/mwifiex/main.h
index ae4b44ad6c50..f0158d217bb8 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.h
+++ b/drivers/net/wireless/marvell/mwifiex/main.h
@@ -885,6 +885,8 @@ struct mwifiex_adapter {
 	struct work_struct main_work;
 	struct workqueue_struct *rx_workqueue;
 	struct work_struct rx_work;
+	struct workqueue_struct *host_mlme_workqueue;
+	struct work_struct host_mlme_work;
 	bool rx_work_enabled;
 	bool rx_processing;
 	bool delay_main_work;
@@ -917,6 +919,8 @@ struct mwifiex_adapter {
 	u8 event_received;
 	u8 data_received;
 	u8 assoc_resp_received;
+	struct mwifiex_private *priv_link_lost;
+	u8 host_mlme_link_lost;
 	u16 seq_num;
 	struct cmd_ctrl_node *cmd_pool;
 	struct cmd_ctrl_node *curr_cmd;
diff --git a/drivers/net/wireless/marvell/mwifiex/sta_event.c b/drivers/net/wireless/marvell/mwifiex/sta_event.c
index 69426ddd9c3a..9c6fac91204c 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_event.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_event.c
@@ -225,8 +225,12 @@ void mwifiex_reset_connect_state(struct mwifiex_private *priv, u16 reason_code,
 		    priv->cfg_bssid, reason_code);
 	if (priv->bss_mode == NL80211_IFTYPE_STATION ||
 	    priv->bss_mode == NL80211_IFTYPE_P2P_CLIENT) {
-		cfg80211_disconnected(priv->netdev, reason_code, NULL, 0,
-				      !from_ap, GFP_KERNEL);
+		if (adapter->host_mlme && adapter->host_mlme_link_lost)
+			mwifiex_host_mlme_disconnect(adapter->priv_link_lost,
+						     reason_code, NULL);
+		else
+			cfg80211_disconnected(priv->netdev, reason_code, NULL,
+					      0, !from_ap, GFP_KERNEL);
 	}
 	eth_zero_addr(priv->cfg_bssid);
 
@@ -749,7 +753,15 @@ int mwifiex_process_sta_event(struct mwifiex_private *priv)
 		if (priv->media_connected) {
 			reason_code =
 				get_unaligned_le16(adapter->event_body);
-			mwifiex_reset_connect_state(priv, reason_code, true);
+			if (adapter->host_mlme) {
+				adapter->priv_link_lost = priv;
+				adapter->host_mlme_link_lost = true;
+				queue_work(adapter->host_mlme_workqueue,
+					   &adapter->host_mlme_work);
+			} else {
+				mwifiex_reset_connect_state(priv, reason_code,
+							    true);
+			}
 		}
 		break;
 
-- 
2.25.1


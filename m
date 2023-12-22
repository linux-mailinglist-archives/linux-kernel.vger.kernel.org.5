Return-Path: <linux-kernel+bounces-9284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE0281C366
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 04:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAA67287D71
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 03:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9D79444;
	Fri, 22 Dec 2023 03:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fO328SDO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2088.outbound.protection.outlook.com [40.107.14.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8528F49;
	Fri, 22 Dec 2023 03:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h0k5hE60RgdLRIoLv5DoOVc9NDWDPfuot5kWvVlDGiEy/1PoUHiNKB/u2qBhuMLnss0ytrBhwTA85/OimZfjWQhSIruV5eXJwaaAH4P78gKxpacoSNpSr3udftwYdL8UBxKbSbjSMvwjuHKpaeYVcjMNtgln28+sGGyGBeSN9egVqkN9wYR0mbn9rQX/jWDW3aoriMDDNwdOSU3a1ZazEZq3XyYrwj8ixOrd0FxjxR5WeoimQM96Hwx36rQQTrQ6WtFOUGl/UgSpx9yL0C8YI0Nv7xQdA3RKf63S7dUPGeUMQK+Xhwm2Ea0MjI1OmrdWg9/K1BplDSKGIjUHPBNXGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gwBkTQ0l3zuGsIzij9Knn2blwY06aevVskcNb0d+DLk=;
 b=EnmxVcRbvniW6phsoLoGLhkDfO/NL0YTH9iB8GWXYyY1ZlCkJuRpW2ly9zVwklOpN11CPxQPS3WTACJucb+PzX2WJiOQ44G5fcmECmI9Ap9BW4VKYbAEePGA4NvYTENrPCoxtGdGf/TSbMylRwhlL9KL67dFLzCOg0YEgtcTC4R/o6X1ih1WDrnF0N2/Zu3keUoOONhE7W/vhBRwWdGz67jAe3ssP8IBKBgyeLdPZD/6DaMNULAd7Twm0gvDeMgLa/VIZwwK5BOYS633kgRjkr0m3kZxQIAsHoAGoZm5Q6pEuMHLo2diBoQhV8prjGo0Ph6sY9SVlav86c7OScZZTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gwBkTQ0l3zuGsIzij9Knn2blwY06aevVskcNb0d+DLk=;
 b=fO328SDOpgr1K6AlwMsIEA5TEwp2qyAfiue/q24jwlQJGd8gq/396hkW9cRthCx+HzQ0U+80HzbJJ6Qu70IVIP4Fx8Glkk+KIvoIo+u7GXrFlnWP0cuEO8skRRTUjP+NTHQk51iOPDG9QR5mgIGmli+5LIbHk+QlTf9+X4ulHf4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by AS8PR04MB8358.eurprd04.prod.outlook.com (2603:10a6:20b:3fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Fri, 22 Dec
 2023 03:21:52 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::b0b2:5cbb:3f6a:6630]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::b0b2:5cbb:3f6a:6630%4]) with mapi id 15.20.7113.019; Fri, 22 Dec 2023
 03:21:52 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	kvalo@kernel.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH v8 0/2]  wifi: mwifiex: add code to support host mlme
Date: Fri, 22 Dec 2023 11:21:21 +0800
Message-Id: <20231222032123.1036277-1-yu-hao.lin@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0064.apcprd02.prod.outlook.com
 (2603:1096:4:54::28) To PA4PR04MB9638.eurprd04.prod.outlook.com
 (2603:10a6:102:273::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9638:EE_|AS8PR04MB8358:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a9b2e5e-050b-474e-ebba-08dc029d241c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QT/8pZIGtBnSRlEu7HM6OV0CjozWAIaOArmlrH9CeEnb9OOdcTwmUy6rrBOlPs0i+fH+3x3wqxb5Lv5ukWhhefMDDnhOUUSVqUTXdRLOyVz3gq9nymY63DxagRSrSI9Dj7XsocSutaaKqBNaGV3kos268HEKT2QLMFcOpqXQKzdwGjUjiJY08Dvmkq+MtoDSORr3S3UhqAC9gSfOLJUEfbQEGnKwthXTEPPgXXIP6gHE2oHabl6czpawTsqn4uj1LT2/mlTskDTJQ3PpaG8AxOW4lhsGWVVYdExIXFu8f0UYTtxPtODEQgxkDZtN9V7ZR5kMTSsMC+MFcQwio1S9qbQH4F8zV8oNjEZcNlihMUEBGlPrp2DSPEN3O7i6sYU1wva7ykKtq9GpRPP2yMBv7/yP+agHyfAbIStMTuS+I4Ipdtt6Jir3gKgfQivV+d27zEw97kJtxC/EWyVMYaJjDXGEItQzNVTsdaPkP846KfvXZN30GH7W3z0KEnDMU/MwkZ3VU4hHMzTmvGicPbyu05c7oR17SAlhpqn8mq5lh8shY3KtNxEZtK/sPGjOi0XNZrA7XbjKysphl05Preddk8NIVt0WyaXC30h+cEYxS5DEAiAxbXuTfNLThzjLHZUe
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(136003)(376002)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(4326008)(8936002)(8676002)(5660300002)(2906002)(478600001)(52116002)(6512007)(6506007)(6666004)(66946007)(66556008)(6916009)(66476007)(316002)(6486002)(41300700001)(38350700005)(83380400001)(38100700002)(36756003)(26005)(1076003)(2616005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V6jwfrd7EDsXrlCyMeBkJlCCAlsbXt4nrQ5Ub++OlFI5o5wAO6kGYvTZ4R1E?=
 =?us-ascii?Q?+liEw9Ybpo16oIc5srsxCtXVl6RkxcSShgQRla3SZryR3s5+nCnAGytp/xx4?=
 =?us-ascii?Q?4D8OHBeKgIeMNPpNJWxUuRsXfNvmueW1QkLXeL21AdS/r6MRYLWHh8iD2/RQ?=
 =?us-ascii?Q?TGARnxY+2ake7eGoPsejDv7dgcQmPfZaTOe8593JjwrZ7BiAkkeMl+NkSKui?=
 =?us-ascii?Q?wDaaCu2vZSWtkJ4mxcOSmb/bhlr3q1nZ6aP4JzJG9tElmYrTNpreyzfGzTpq?=
 =?us-ascii?Q?xwDUvObBKo89Nv1BuOYsN0M0mIjS4SvKuxu5YrzOtwlFZqlgZU3VJ3S6+Noj?=
 =?us-ascii?Q?NgoEexIe82Rp+Ue685Gka+Ity7mF73n1wsDFYOvao0qrjY+JLDOkOy/72T/W?=
 =?us-ascii?Q?Oi4AEJczwshyVCD5t4GMBdAk2bQEidjUX+ADgzwpUDdsSV9h6Ju1DO9Jrmyo?=
 =?us-ascii?Q?Wam/psfAF7TQdwgGXzRqnJdIvA77Ot1UccPuujZgYXtlU+1EhvxY26I05SPO?=
 =?us-ascii?Q?KFPRTCYqLcEp8F1ai1Gz/+pL1EvIpCEQ6v/5QmQLxc9c1vyT5rBqSsILSQvb?=
 =?us-ascii?Q?DFI7XDewxIOCEYGx9SHLd1laAv/1TRueCcWJ2lL/zG26obG4FyhzxEYxzCG1?=
 =?us-ascii?Q?fNnHh20HtJEVSCj1+sUI2n8plsnCyc0oFirt1rEBYjQHMqtCL97fxmmPFgTS?=
 =?us-ascii?Q?bViwg/iINssIreLYDFq7ySCw7oJufP3fgntEpRMtVjNTP8UrccWxsesSokVY?=
 =?us-ascii?Q?bs/eTfXqTEWyA+ecpci+YLiJsBqP1jx/xYVQNNYmBJSafvcevT2ZY8N3ozYN?=
 =?us-ascii?Q?4ZMepOSi5fdEBvewTNstIU8qzyQ6GzA/NnIuyQbOLbkCpmwPP+nhb9z1VC8E?=
 =?us-ascii?Q?pqYHsdDrqgOkveXtgDR+dgLPWJUpwsN9rWWcX/17SbXPbvsuuPcWSjSxa1At?=
 =?us-ascii?Q?70Cm5pIoPX9xQLzgMtHAlHfQOG6O+0T5+lw5zTYOFtq22jlYQ7s5N0Aj5FBg?=
 =?us-ascii?Q?bXUnZLFEja74ksqO0HIJayUVeyXjofIij4/kb2Pg7C0kD8qJNiWiYiOuiM64?=
 =?us-ascii?Q?+VocNk4XORO6jk1/N2YRf27ymhroLfhBhWCUzLOu4shT7YtH8e7/ydj4vSp4?=
 =?us-ascii?Q?JHMpQ59Guke8poqPMbrNS6wgIJhhxWJr+YAC5TmevxEqrHmVZ/LJluakj8nX?=
 =?us-ascii?Q?K+kU7prX7Cgu9NzLiW/NlmzmE8bD01Frm40wcMJk75YQPfjsJ6ZSn6UNn7Ts?=
 =?us-ascii?Q?4DbF/DVi8Z3HT35INlUm42LIKycGhRwBUQtUY8tUkkFYD/NGP0+bfoO0Tnqp?=
 =?us-ascii?Q?4iBV0JXMKrc1y0qpt11FeigNG0CEEJ6nEt3orNB5TBiVaBpJalUCx8ZP7oQP?=
 =?us-ascii?Q?KP2Bmmfl83XWm9ZNbahSsiD/JU1WBU2FwVzNQMByLBVLm+vSNaqtmVhxnzXK?=
 =?us-ascii?Q?pQoiHPewrpEl5ViTS4xzkd0NWE3Fxz8f0cRZU4SO9cvbUtH2YBvyUdzc4EdY?=
 =?us-ascii?Q?M/uypYRxXT2cVXFfV7gk0iVXo6ZDtCrDpg1OlV6Ef4BXoPqCRElGjHWvrOpB?=
 =?us-ascii?Q?shoimkDf+PINuS9O/NcX20H2g8UI+V1P0uz8FkAr?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a9b2e5e-050b-474e-ebba-08dc029d241c
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2023 03:21:52.0262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3GapHL4TDxAbRwLQIMo2BRU5BiiKd4B75Bxrq1geGnxcKoAkhvS21tfZqIcTB5hyJrAgZZvdr2Fz4qWyjXAfyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8358

This series add host based MLME support to the mwifiex driver, this
enables WPA3 support in both client and AP mode.
To enable WPA3, a firmware with corresponding V2 Key API support is
required.
The feature is currently only enabled on NXP IW416 (SD8978), and it
was internally validated by the NXP QA team. Other NXP Wi-Fi chips
supported in current mwifiex are not affected by this change.

v8:
   - Separate 6/12 from patch v7.
     As it's a bug fix not part of host MLME feature.
   - Rearrnage MLME feature into 2 patches:
     a. Add host based MLME support for STA mode.
     b. Add host based MLME support for AP mode.

v7:
   - Fix regression: Downlink throughput degraded by 70% in AP mode.
   - Fix issue: On STAUT, kernel Oops occurs when there is no association
     response from AP.
   - Fix issue: On STAUT, if AP leaves abruptly and deauth is missing,
     STA can't connect to AP anymore.
   - Fix regression: STA can't connect to AP when host_mlme is disabled
     (impact all chips).
   - Address reviewer comments.

v6:
   - Correct mailing sequence.

v5:
   - Add host base MLME support to enable WPA3 functionalities for both
     STA and AP mode.
   - This feature (WPA3) required a firmware with corresponding Key API V2
     support.
   - QA validation and regression have been covered for IW416.
   - This feature (WPA3) is currently enabled and verified only for IW416.
   - Changelogs since patch V4:
     a. Add WPA3 support for AP mode.
     b. Bug fix: In WPA3 STA mode, deice gets disconnected from AP
        when group rekey occurs.
     c. Bug fix: STAUT doesn't send WMM IE in association request when
        associate to a WMM-AP.

v4:
   - Refine code segment per review comment.
   - Add API to check firmware encryption key command version when
     host_mlme is enabled.

v3:
   - Cleanup commit message.

v2:
   - Fix checkpatch error (pwe[1] -> pwe[0]).
   - Move module parameter 'host_mlme' to mwifiex_sdio_device structure.
     Default only enable for IW416.
   - Disable advertising NL80211_FEATURE_SAE if host_mlme is not enabled.

David Lin (2):
  wifi: mwifiex: add host mlme for client mode
  wifi: mwifiex: add host mlme for AP mode

 .../net/wireless/marvell/mwifiex/cfg80211.c   | 394 +++++++++++++++++-
 drivers/net/wireless/marvell/mwifiex/cmdevt.c |  27 ++
 drivers/net/wireless/marvell/mwifiex/decl.h   |  22 +
 drivers/net/wireless/marvell/mwifiex/fw.h     |  54 +++
 drivers/net/wireless/marvell/mwifiex/init.c   |   6 +
 drivers/net/wireless/marvell/mwifiex/ioctl.h  |   5 +
 drivers/net/wireless/marvell/mwifiex/join.c   |  66 ++-
 drivers/net/wireless/marvell/mwifiex/main.c   |  54 +++
 drivers/net/wireless/marvell/mwifiex/main.h   |  17 +
 drivers/net/wireless/marvell/mwifiex/scan.c   |   6 +
 drivers/net/wireless/marvell/mwifiex/sdio.c   |  13 +
 drivers/net/wireless/marvell/mwifiex/sdio.h   |   2 +
 .../wireless/marvell/mwifiex/sta_cmdresp.c    |   2 +
 .../net/wireless/marvell/mwifiex/sta_event.c  |  36 +-
 .../net/wireless/marvell/mwifiex/sta_ioctl.c  |   3 +-
 drivers/net/wireless/marvell/mwifiex/sta_tx.c |   9 +-
 .../net/wireless/marvell/mwifiex/uap_cmd.c    | 171 ++++++++
 drivers/net/wireless/marvell/mwifiex/util.c   | 104 +++++
 18 files changed, 974 insertions(+), 17 deletions(-)


base-commit: 783004b6dbda2cfe9a552a4cc9c1d168a2068f6c
-- 
2.25.1



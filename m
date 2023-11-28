Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB637FB429
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 09:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344160AbjK1IcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 03:32:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344120AbjK1Ibw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 03:31:52 -0500
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2042.outbound.protection.outlook.com [40.107.241.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC904D5B;
        Tue, 28 Nov 2023 00:31:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k1/TdqBa/cpyiUk/D0SMC5AJHAklr/Oa86Z0Cl84YNVuBFY3X+sjukSg651osjfUZMunGVqZ3NXgTBJgxXnojIj/zNeOPcP+CTj0/1E5pTaDJhhM8RxEP9ioXHPrq2raf49HZSAoJNJg0NGp2kHX5yxKYLCh7LgBJPa6uIaRfHAP+3HT/aY8suVwrCu+JxoUgbAQWivCi+CgbL/5VS0aeDYGBvkjx2l3xWo1Ez9TngG55V+b3TMsEmEZ2lK9AuV7Uo0VzoQIL0rBT7OboOtobwVwjwVpe9bA9H5bo7rknmrSc81Q9d0TaqaGBlAJdXX0bFxAAgFWFtLLrAd7Reafwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RHQlhPnoPjoc1KM06W5fx9fuzzwAv4JpdmH3WpAtwaw=;
 b=iFKrtYdr4bodFf9QYVXHrkpLjlAr0veXh2k6Tga88HRY1nVZ7tJ39QcaN4cLbzrw32jDOqDMQyVrtzrRp19q292/ARfB3xhYq/Dcq8DUAK+iXwO53HPafJoO83FqscHHZ91aSMEfShBM1CZLlB6DN9gP/XxMIBhy+f/zWQ+96BM54wvEbnRbf8/CycKeEn1qbyiIOCJYKPj7sPOkFsKoo8t/q3G95+k0Kwqjk3HUPqfkSzPo6cY9m5nMk3NyB+4jXipMRMzWIvDGlo4QqXgtusItwUEB8VbPlc/oX01lzp6oDVQNToBskGCW7/OZ3KnatUB9N05OvfDeIMahyzNAtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RHQlhPnoPjoc1KM06W5fx9fuzzwAv4JpdmH3WpAtwaw=;
 b=MAWcpgoELrvnB3o27O3wwZ+4sPEczzXLer3bvxpyXy744FKmATOoXBT2wznwC2NSr5gnpWA28sUfwvJPTTgc9Jrn131GIIwMdiMdt3u0XX9TPhVX18f5N+TbLlbwhwRYKZcNNhN1v1nzOdA3vxkd+yHqvQIFW+QidpMcIni2jh8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by AS5PR04MB10043.eurprd04.prod.outlook.com (2603:10a6:20b:67f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.18; Tue, 28 Nov
 2023 08:31:55 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b%7]) with mapi id 15.20.7046.015; Tue, 28 Nov 2023
 08:31:55 +0000
From:   David Lin <yu-hao.lin@nxp.com>
To:     linux-wireless@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, briannorris@chromium.org,
        kvalo@kernel.org, francesco@dolcini.it, tsung-hsien.hsieh@nxp.com,
        David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH v7 04/12] wifi: mwifiex: fixed missing WMM IE for assoc req.
Date:   Tue, 28 Nov 2023 16:31:07 +0800
Message-Id: <20231128083115.613235-5-yu-hao.lin@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PA4PR04MB9638:EE_|AS5PR04MB10043:EE_
X-MS-Office365-Filtering-Correlation-Id: 63cf6c96-b111-45b8-5ddf-08dbefec7a9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1VSh2ByHfqB8eGkQ6tI4S4FHhV35MwLyy8qDfk71CiojXf+zQJ5khTheHq/+r8qdgyEjCzA8cwF+HsU/hdw5JaIGoQLucbICVtYk+XKdW4JmU9G8pcHy1sZrOr6LHwtpOL8iIlSZH5Yce4/xgAEjzbW8u+EpwuRd2t2ZLi2xvvIvZ8G23/hpN7HhYWihFHJoxhv6fMeow+2+J6VAZtMY5H2O7ejSGjPWMqgS3TnpytNtmuaLSuptpR7d0/kH4CHU9ALDy6MaaUC0JmmQrGZrS1BID1ExwzKcGRdKO3Vg98zUfg57V2J7m9o2bBUI8GaPSM4mkVYwcXsMPfoKaG6tCMyxhuBQ4Q8lBCnS2NNCWFUePXPJcVol7k9LILcq2dhF6ianFJXIHAFlzUbKBubWV5BuQtY6Et34QZ8ck4OOPR7bFxKDITobPTrCNCyT4X83cxfUzX5I+//zoUoZ4WXe/ncYzvyTk2ennyS5z5MWnp8rL4+PKy5KpzS/PQF23vFJEyagahfqlHpkX47sZQ/QXygwMWKAak6PZEXDZ60oL1fXYiwqTk4mRwCFGxBWoHx8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(396003)(136003)(39860400002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(86362001)(2906002)(5660300002)(6506007)(83380400001)(6512007)(52116002)(41300700001)(38100700002)(36756003)(6666004)(1076003)(2616005)(478600001)(66556008)(66946007)(6486002)(8936002)(6916009)(8676002)(316002)(4326008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g7L6GvU9brkLXxCw+TNGuxhXY+SiHtCFJ0ak6nGFNbgCnxANohm4IwOEX7GX?=
 =?us-ascii?Q?pa1ISFk40QDLZsWmyhiBvkx1G711ScaoWE4DZu8sw0U5hkjvL+IqhwRajJ/3?=
 =?us-ascii?Q?Q5/Y0x0G13OtlwfRNUVmV+iaRrk9Rfe11FT7C2BkNUxXN8usE2dfpw/aAhVP?=
 =?us-ascii?Q?KQ7yQOcmQY2+r8dxKW1WyDXq5im0j/8U/T2+f6yQKbPt/LCc7/pS+NuKlvNA?=
 =?us-ascii?Q?bUnhlY94+NlyPIJBx9gNKWnfzM5xZ7vRJQu4fyH8d2cYpByzS5J7dv066HLm?=
 =?us-ascii?Q?kmYUxOj2scV5yF2TNtecQX6m7HfUe0Dvg1CdoPTTONobPh0VVnbN71bbGe/J?=
 =?us-ascii?Q?3nIorng86tFp/dtQln9U0IcHh1vfbb0WSEP7BujIp9BWjsmukLNiDvcGE1YG?=
 =?us-ascii?Q?/ShbsHM8WKOjnlfNHwc3qoRsJBeLe6y01p/Pdr+8FqQfwQXxUd6URi/9e1OD?=
 =?us-ascii?Q?JYPoBXlfB7reBHfBiwG6hf8IMxgeEpnY/msxLAlv2TnTRAwst/ioAAYdRd1p?=
 =?us-ascii?Q?D/4qScE37/GyP0/BIlAJr/lvdifJ3aXBwfYwEpd3MSDiZ1EZa3R4vo6EQcDf?=
 =?us-ascii?Q?vRJ4ka77KIEzkeatt15SGygG1ptxwtUuMO2rRieB6qrZvI4nqrxOrVcuRYnX?=
 =?us-ascii?Q?hmU6ABoJmeaiMke8oP1MpNA/ajZ+Wr1sCCIas01Vof4tqCNXd0PbLtbE2OpW?=
 =?us-ascii?Q?IwZFRWWrZXGL3RNQ88bDvDrHvn3ZQ1GHsJ2o1d48Tn2Jf433ddrsL6WaBtBO?=
 =?us-ascii?Q?CQSFMVA47BuRMI6mmJkBFCYqFdA/96ZVVa88O4WREOF7yhekXMiLyWji6GXF?=
 =?us-ascii?Q?2wg65alrPkm3KEUaX3wXU2EDBbC3/lk4SVw69O8nVUjuWMx+q7p8N1Q73c/+?=
 =?us-ascii?Q?iUe+GRkwEMdGB8k51bJJEKlJJ3LCasgX8K7IdJLqSur3RDt7SBfvGaYAu2Ra?=
 =?us-ascii?Q?rkEVrcgfRu/COIB/rgSBo4tozz+hxHRQxJUxirhUsMxdLRPveExECfXhOPHl?=
 =?us-ascii?Q?dc2ZMkhZL6A5dfiOqleyRR9svyptmSiXRIex/T7KuvCiyCEgQi3fbX4UKB4A?=
 =?us-ascii?Q?wBz2ovBy+MoKQ5y4DRCsBwCncQ7gK4pEUgi/KCXbicLsVHEB8rVf/Sy6trC9?=
 =?us-ascii?Q?1Zglp32SFMbC9ubhIPZGrdYeX33OvKVSJjxNk8V40USN53bkAY3AuL72juw0?=
 =?us-ascii?Q?2dMogkwreZHB2yLL6Rz/iJTRr3z1BL0IZVEW6ACSeV6KD8iEBdzo6uxqWQNP?=
 =?us-ascii?Q?G6Sza3Etd2sYRktNfst9DzyNSPBo0Cgz3DSa88QWXYGhWea8TCwslQc+SPdM?=
 =?us-ascii?Q?FKXeScO3DtLrU13rm7IiCU7KOhK2BqhWtrLV9/WPtwrOb8SN6ysl7J6Wdeib?=
 =?us-ascii?Q?Ntqk8gNMeEGXOzf6eJf+VgCcm+hneL7VHKALUD+upXkRgauB9kKYVgfg6N9O?=
 =?us-ascii?Q?Fyi0c5O3xUa2CVKNAfz6hPSluPcvuyn8EwjKnqCEd0Vs0eUlSMeDuMieDGtm?=
 =?us-ascii?Q?khNaLiQad7m1iUvUmga2K7mRGlGq1bZomqUGpS/exrqhS8zROq2fuevI29Ww?=
 =?us-ascii?Q?qMTuYQpEvQ7/kXmvcAMVDObKDp5PiYn/YKoonh4t2lpY2LbbGXlCKZ0Yu9cp?=
 =?us-ascii?Q?fqEZlyORY+P+xBidvchePxCyjEvoeh5lDcEGtdKGON5X?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63cf6c96-b111-45b8-5ddf-08dbefec7a9f
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 08:31:55.5091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pWQSDAc4PJ4XsgrLhT/y4rlhRAKNLjafQMnzFUJr+hb3HuwbOxwR7Ap191yQkk6/yMCyc1vv7M96awB/Taw8TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10043
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remain on channel must be removed after authentication is done.
Otherwise WMM setting for assoiation request will be removed.

Signed-off-by: David Lin <yu-hao.lin@nxp.com>
---
 drivers/net/wireless/marvell/mwifiex/cfg80211.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index a21310f3807c..b99de9f4ca14 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -4306,6 +4306,8 @@ mwifiex_cfg80211_authenticate(struct wiphy *wiphy,
 		if (!ret) {
 			priv->roc_cfg.cookie = get_random_u32() | 1;
 			priv->roc_cfg.chan = *req->bss->channel;
+		} else {
+			return -EFAULT;
 		}
 	}
 
@@ -4418,6 +4420,16 @@ mwifiex_cfg80211_associate(struct wiphy *wiphy, struct net_device *dev,
 	if (priv->auth_flag && !(priv->auth_flag & HOST_MLME_AUTH_DONE))
 		return -EBUSY;
 
+	if (priv->roc_cfg.cookie) {
+		ret = mwifiex_remain_on_chan_cfg(priv, HostCmd_ACT_GEN_REMOVE,
+						 &priv->roc_cfg.chan, 0);
+		if (!ret)
+			memset(&priv->roc_cfg, 0,
+			       sizeof(struct mwifiex_roc_cfg));
+		else
+			return -EFAULT;
+	}
+
 	if (!mwifiex_stop_bg_scan(priv))
 		cfg80211_sched_scan_stopped_locked(priv->wdev.wiphy, 0);
 
-- 
2.25.1


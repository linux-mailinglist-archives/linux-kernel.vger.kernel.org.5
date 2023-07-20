Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0B975AB1D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 11:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjGTJld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 05:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjGTJlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 05:41:04 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2042.outbound.protection.outlook.com [40.107.13.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E6A3A94
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 02:37:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BEXUP4atnx5r8+rzyP9L/APsLc0I6DSICidB7YatLHviKp0uih9f7+NWfuW9NaAwESWFMaD5zTY1xLAQ3nsNoyYrqxx7wAvUXtpwdUgpsgXCItFEPxGccYLooAPqF2dSFSyVDv1XnGBb3uz68praNTMeXKJXUj2B080i+YqaWN4bdmREnX3IooP7xPKZvh+YXNqfRsgxrEhklunDbpqjZP5mGx+MQjXU+ojzYVVXnYeSn1ekruKF2mlzvd8dX/YspO5Rn3opPa6c17NTg74UBsTxvMqO75QXTON0/s14PL8ivWSf8g3NTj/+K04/IDRQK8bJRkXLLRJgmLoT/4pDXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QALHUzHVhQKD3fKu06vGPOUlJ4GnUotQExquzQP0wVA=;
 b=Sa3JyQuDXa76uYdFpcmI7geqFkZT14wrw3E3eQOE/mcj6naRCEjOCgfJ9KFk9wlOkSFsEPyzSsKbWvVUyewQSDLxboPaaawvmeCezaOOD1UoHHvcbX4fG0JOMpIIPf1QV3eMOr0AAgpLd5DLnPnztHaz9NJk5VBxqpf9IFNGbANR8U83HDdHdftDSar4GTKTW/PE+nx/CPM8Jq1Jp49jcTeqXF2GIWJTGg1fKStnxf6vW92v+fw+lxoK1qLyaBZKiUiWiRCmBzSPQhQxkUZaUnkNDyk2ryjpkHRExYtj2k9iGSEpp+dzb4SyEdBRHyOO10Af5FWwFyXq6tkEemngLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QALHUzHVhQKD3fKu06vGPOUlJ4GnUotQExquzQP0wVA=;
 b=doYiCL/8MkODqeA0bfXaefKmEQaeiwkr/HMw+/U/D4Zvfl9Hs8xtO0K7UPcYrYyBhIKXOGAp0SN9Ve06l0enqYeaLF5qNDbhKdXoVNjipkV/fYSwG4lKTVLXfaBXPLAbBzHPUOXH+e9T/v/iuiSledfkrdFzsugf2D2IaLpjvyE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8388.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.35; Thu, 20 Jul
 2023 09:37:09 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c874:7c87:c13b:64f8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c874:7c87:c13b:64f8%5]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 09:37:09 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, alexander.stein@ew.tq-group.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 7/8] firmware: imx: scu-irq: enlarge the IMX_SC_IRQ_NUM_GROUP
Date:   Thu, 20 Jul 2023 17:41:27 +0800
Message-Id: <20230720094128.536388-8-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230720094128.536388-1-peng.fan@oss.nxp.com>
References: <20230720094128.536388-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0110.apcprd03.prod.outlook.com
 (2603:1096:4:91::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8388:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a66b296-cf4e-4afd-756f-08db8904e34f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d6OZu6zSUarqqj0quNXRO+fKjiusQE/Hjzv6bq0tcFm58o5fRvrMtcxAJC4zLrZk5vXelxkoaIi+9S0q/sDRfdMyV1xPtgUweb7xaBrCXKrfNDSESamCZLTSgRk+Xj1rNSIc0uhmBRNqJYG0lYRqdKgSDJUpktVqtMj+PEUpPzAQOv9pOvRE6kFTe+0hYcjI50lXHje1VP+dvFdIqR4YLgXJpklyV66gA+fhSGc/QfSBwtXsX3FL+BtLSSznSt8Pi2NJhHBPGniuEI4N4DviocWgKeQXeLuRQDtecbwoc0XX1Iwoh7560FENwSHCj7wQR4XqM75DlBsY7cQa01Jlzaa7iGaP4lLen8nKOLnUchX85yeJCtwty3tBt8RG3xJybJW6zFEOvdMcFL/gzalFb+bO2Y2Vw08FXGVrU7+PtFkxsGWBG9H1vcluj5TtAcfqWP4SkjM4rN/cbYFTzFeM+6YpAdjKGBq+n4ubnrWjCQCJ4wOTS91dUW0o3TOKc2RRv2tduxRtrP9clVfUSQmaaovXuZ5BpfKNlJ05OUvXKd87NgJDDeTJ0I57ThQFGv5pBE45vrApDyaiZAJ9JvmLTSfFWEnjtwD/HRQtM81RiXyfB3KRwlnq6reNdta0lWPAOA9u5iJX5IRnzRbBrk7J9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(451199021)(186003)(2616005)(6512007)(1076003)(6506007)(26005)(83380400001)(316002)(41300700001)(4744005)(66476007)(66556008)(66946007)(5660300002)(8676002)(8936002)(2906002)(4326008)(6486002)(52116002)(6666004)(478600001)(38100700002)(38350700002)(86362001)(147533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zCRLbIEiR9+UCWdqQ3Ki8nq2Wg9PS75nYtoPs9MD+SvyObNOm7dV8Nhb/bJJ?=
 =?us-ascii?Q?3Q3mjvcNsgkdo2spffKm7W+Wogr0+p9UJJvLWX53hL2pWYrhjFL+p7MZ4fiP?=
 =?us-ascii?Q?RG7RAoJOpRfcQg2XGseNGDJFIcyW6+5FJxorLQTDh/XlKogBVcjWOVr0fTDA?=
 =?us-ascii?Q?Rvh/B+/fmEhFJCPq7lF31GWxhSAU9uREwQQQ36fmvsHjHCHThlcDlQE9Fdxk?=
 =?us-ascii?Q?0at+TDahIYfzHA+5GIPcR4XXBiCrLIWGmkFgodlzGUy45c+Ft+xn1DytgzRS?=
 =?us-ascii?Q?qLJ0eoiGYTYluq8RgNHZEea1ZIFMKvohiPyIFzEY/GTqE6zAEIKBCF8Ge5Gb?=
 =?us-ascii?Q?nzcWFQBIJBvn1jWoWhjtMKv8N4balsyycv1SigU3MKVOnNVUDB708ltH1N94?=
 =?us-ascii?Q?BWb3XmZLfzal6nF5sq0to+aSBHDl30qXEIN48OWAhIxDCRELdtKbcJUAbwEH?=
 =?us-ascii?Q?aLC93NDoQUsYlDvn+liYCT8QTuHG6rG/txZGtpxgdHl0dTF0sSinwNRV8Yqr?=
 =?us-ascii?Q?lBIS6zI96H/T0GmIjdY/2poEpbFB0GXmFFWTZGexQzB3zJouMRuzWk+3l0ST?=
 =?us-ascii?Q?dK3DkG95UuINX6kOEdgkR/1vudpUYWXYUbzAYWAg0XbLbVVTc3HoJYeNi3tm?=
 =?us-ascii?Q?3iZoMJc/cE5KLoUbH3o+15zEM8pDI5DoEtVgAGAhNgBJBIbLmervPWdwiiO0?=
 =?us-ascii?Q?OmU4m0nSVH0es3xW6/OhSnCqqY0/CZZIPNt6qG67MDG+uzGy0GLqHNCJs3q0?=
 =?us-ascii?Q?wGJ+V6VWH5NmGVBAl3uSM2eI58HS2OeauXtIJtPqw2lveSOpDj2gwSCo10pz?=
 =?us-ascii?Q?xNjB1NIgQnQPnj6tLWa1mpO/BoO1Pgwdhd6s1nUL/SZTzCk3emvAb9V88tHt?=
 =?us-ascii?Q?KiJhLG0xbT0kudR1L4OOH9WS4VwU2oGw/yICrGkZ9Vz0sQMzG4ZCPd7K+tJE?=
 =?us-ascii?Q?MK2LpsJLI+xLxiKALnpBlySTr33YQBW8BAoc3MUzvF0AqhEv9k1eajndYPc3?=
 =?us-ascii?Q?hQtSdpNnRoG4A79C0mTCKkatJzU9301+znXvOvy/JsKwW5kIyuW3psIRCYgM?=
 =?us-ascii?Q?BGvPw/UCjo7ruTI6jpxNuiuyl3H02wa+blm7LrVXOhG6LXKNNXetpWGzJ2c6?=
 =?us-ascii?Q?bgtqPuO0dFAtilQAKChzCd1hGk14WwZc9mztpJErHqIQ0F4LVbRg5e8PenQb?=
 =?us-ascii?Q?J/SQTTarZg9Di9ViyzGHi2Oeeh6coiiyt2+PD8s/Q/WxAXkVvWRJph+decLx?=
 =?us-ascii?Q?hjSdPJFVNWjWI5HtIZybf3eEHUqyeWaFVLpX9Fpkr6QjbOj2d91l1e7v8mzs?=
 =?us-ascii?Q?U1mltJrRMWPTv5sQGdQ6/iG7cRayFhNgBgkCh2dA4V3eFUQHQrMfxRBY97Qg?=
 =?us-ascii?Q?6OFP4TJHXde5XMeOelCbEI2ZBUZxtFSwf7CTuKjDUx2RB3E7p6nneTzHEDqK?=
 =?us-ascii?Q?ul8M7xNj4Lm8S2yUcbs7RXbRQmL+qO5wtpGaJtk4/xVBktU24sj5iERv1VMB?=
 =?us-ascii?Q?ASkkUXn5E2jjeyGiWusC2UeWszfi/qABEnb2nC+3Wg9qW6/KLnNVSlHrN+4h?=
 =?us-ascii?Q?y9kSl/XGetEp0IXwlNYUn+YZqpbuOldFTj7HWikx?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a66b296-cf4e-4afd-756f-08db8904e34f
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 09:37:09.2819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FbBbgrDs1rilAU5fVCNGfB1x/Iof1cjTuthWrVrdWzsH5r0EqqAfPpnwshmTWFNRVeb9emYaKeCB3ryu/1nssw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8388
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Per SCFW update, update the IMX_SC_IRQ_NUM_GROUP to 9.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/imx/imx-scu-irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/imx/imx-scu-irq.c b/drivers/firmware/imx/imx-scu-irq.c
index 6549f3792a0f..8d902db1daf2 100644
--- a/drivers/firmware/imx/imx-scu-irq.c
+++ b/drivers/firmware/imx/imx-scu-irq.c
@@ -14,7 +14,7 @@
 
 #define IMX_SC_IRQ_FUNC_ENABLE	1
 #define IMX_SC_IRQ_FUNC_STATUS	2
-#define IMX_SC_IRQ_NUM_GROUP	4
+#define IMX_SC_IRQ_NUM_GROUP	9
 
 static u32 mu_resource_id;
 
-- 
2.37.1


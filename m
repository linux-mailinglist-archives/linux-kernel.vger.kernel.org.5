Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7FE27535FF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 11:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234735AbjGNJE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 05:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbjGNJEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 05:04:55 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2071.outbound.protection.outlook.com [40.107.7.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20BFE65
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 02:04:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IBLUYmduY3eaiTQkhQq7dbu7Qc0C28WSDAvA8l88uNEwNeaYDsasZle3Nv6PaliIcmcKAA2VyIMoyWO25JvYT6obKsb0Y0PPOTiJwA7W3nqwxHHI40RijKC3iwI4z0sWpgwND4WF6zMI9w0Cmo14RjzPsZQRKKOS280hPRKAI+/quS0LFaVaIDrsG7SbQZpUMDrUURRnWbYgnPG0WJQsajv0iJyVuBLLhQ1+8/5cbfBAwAAIOcrF12CNqPnBpNlPi0y0Nc2NfyANwfnkgjApkRoziDFvtfRKow23n8Vd/Jt0syyTQMF+f+LxxlbJ6sIFtv2r544W7LNCCCdoNYt3Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CanF7n+OLLutOd3VBiQIjbDc2uzD/NwEsUI0ySCkOUo=;
 b=dAaL9KkNZms7RNqFTtYN45Se3ZbQU0F1K80I5EGvQZl4uc90r2g0iZgdf+61AGqIlmVwzE3mHTAay+EWBk0mZlfM/VPRPc99WdLl1DqZre89oB7qpZsT9Lit/7MokQQ+2k+ScVK42h/GUf9lsiT3nPOVoWJZmM+01Xkuh/l0W2CvVUDi6mubdbHdunBIRsHYkQdw4RIg28Yw1BIg+s78+ctbfnbrvVQlV0I/lPCWDORAC3dpwvG3jESDxiDBdTyd4m28d8P4qVXL0ajieDxhH6BZ4sHu7RvaHDVRBsrdaX2BitBVbjoQw4Js0yx1i0Aj/obod2AqWpupWSGR+o7fFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CanF7n+OLLutOd3VBiQIjbDc2uzD/NwEsUI0ySCkOUo=;
 b=A+WY8QwMMDakhcKoACpLpiMbM5ojy9VNTy+5uaWKUtBBr3YFux/pjDTjrSR+FAXdAAspLVME9CZK+IQ9881J7XQavN2YR/yJxm7ZVfFqIJB5lA0enJmYRxEW3KeewI4OIhRzWBdk4USnYKRTT7JFUTv9FpOsQhkb+eEG4dU9xqQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7736.eurprd04.prod.outlook.com (2603:10a6:20b:2af::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Fri, 14 Jul
 2023 09:04:51 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5c40:ed07:b875:18c0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5c40:ed07:b875:18c0%3]) with mapi id 15.20.6588.027; Fri, 14 Jul 2023
 09:04:50 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Frank.Li@nxp.com, aisheng.dong@nxp.com,
        marcel.ziswiler@toradex.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 0/7] firmware: imx: scu-pd: misc update
Date:   Fri, 14 Jul 2023 17:09:29 +0800
Message-Id: <20230714090936.937344-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0130.apcprd02.prod.outlook.com
 (2603:1096:4:188::8) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB7736:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b900a61-bf68-424a-5900-08db84496165
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q4IJ+FiD0hkQMG4tedwxawoQeWfixJcxih6sz6xjRrhSOYLQKZ7Q6EEcLIi3afDSxKqlCj7A4C80WqU16Bm98aRe/0Oe76Qb3ghtSR4psLxZYufx+LnQLObA6NnhlVGgK8D3D0R4sG4e5xxcZpKW2NhamUuIxUXLCqYMRtao3DWEee5H1vKBrvAXHNJqgaixfreR6nFD7Zt8OvJgnMHdPpONoo4N3pHYrwvfJLq71kN/RIRvnECIAyjruAZhvs67wiODD90fHRFvabrkex1rx0H2/QJO1zj3jpEjRIQ8NGtuuR0w0MNilavxKZEXA/3EiXn+Suc5AYhEnQsZKc4SYaiDcGVL2pziuPCvMaTZTaVdRG3Ssr29ALYyPKposApR2aBCk07JoGZ7wvzzge5VGbG24OinvdyNpOm1MrmDHr34f4qmh+HKFNA2jC/ekIJsGTAxN+60uMsnJkVaVUk5bRXZXdgt3Ak318tZI/3wfV5CFJFcahTGP4Y+0ulLK460oV/RdFlhXb5AgH8ufTUbWBDhnId/Fqf1aFM6lWE4IHoG3gbe3Qzjz7z70U+W0xvshUkdg5TvWrpJ6ureOdjlYzPM+3BWPvpEm2vkyecJ9ADGLpTbD5TQ0vbEZPRqXPwu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(451199021)(38100700002)(38350700002)(86362001)(8936002)(6506007)(5660300002)(6666004)(1076003)(8676002)(41300700001)(26005)(186003)(2616005)(4744005)(2906002)(15650500001)(83380400001)(6512007)(66556008)(52116002)(316002)(4326008)(478600001)(66946007)(66476007)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Uof4KCjyD+HN8Tp0ihBsZNJshk4VtP0MtPWV9qKBWgs6z+KYnIaEbXHOGd9p?=
 =?us-ascii?Q?Ki/sOddKG+TNlvszYCyx01k51c+ikPSnJn80ZtWXEjW8StH2/h8qLwdsDe5+?=
 =?us-ascii?Q?eVYbp2p+X5kqvNBa3CvrwSJFWRmnK46tv+gS1xH+2Lx/sioxPx2yE2f6hKOK?=
 =?us-ascii?Q?1j0uZVxglHRqYd71SWk3fnWsBWYQ83o60KA0/WbLxxHLjIpj/hffl5k513fU?=
 =?us-ascii?Q?56qSJNCmil3RzbUEaqNhUS/NN1RbHcTsDLG8+/KhCbQWlf/LlkHO7fJYQSUc?=
 =?us-ascii?Q?m9E6osNEgTRkuoaz0s8n3F5htMxzimmNxIysNlkNZj2AgUWWygaEgjKeLosA?=
 =?us-ascii?Q?GQaFDj6c5oR+qi2TW2hVjo3TqZuqTsbNm/iIf2/SxTL1sO0w6vQxCfj9gpeR?=
 =?us-ascii?Q?JyoCytH14I5B/zL6s4is9xMejfEnknYH3LD7Y95FZljrjHRPbbCBXJ0lQ9X/?=
 =?us-ascii?Q?2CTyBHHclNenZmv99LyptKFqOg6HSbAm9DSmlHrxpCD8VzDtV0D/0osMWKzO?=
 =?us-ascii?Q?Ari+kx7uXy3k4iHAkkbyX7CzAkxw1iHGupa5bFId72T572JGPBX98pQQqeGu?=
 =?us-ascii?Q?eT6wrYlUiBi+p+kNS9uU3L5cFjVYVchflQORBk5osXBkL8xc/h8xcGIPxIsb?=
 =?us-ascii?Q?q6P/ahg6tcHXFhMmJRn2J0oWxvzA1By4zbYyCZWpL7BlUTUgQPKJudBr9fRe?=
 =?us-ascii?Q?/jZUVhRZ18REqEN+Wcp55tdVlO0Fo685WbI+d95R9hBtfpMmfPJaJQcMFdZP?=
 =?us-ascii?Q?43ENynJP1aiUYeYR9SNIJUw285HDtIwE3XRwEGJgizia5gHQcFsDIiaddKgc?=
 =?us-ascii?Q?sMxHowGigBbUo6OXCwO8TIhpKvNTPT0m8VO8pZ5LlDYJxTH+XtKhZ7hDhRsQ?=
 =?us-ascii?Q?WB0dCaOeMxXrZbYjuhH+6ccf2vkz2UYBDE57AZTWOML8cl58a6ATaeJKDtfm?=
 =?us-ascii?Q?9Q52OSUU6Ej6/ZVp1qRtVDI6GRhON1Dc+FHH/c6D61HMRoT0yxkzX9RmwjIN?=
 =?us-ascii?Q?2I5bFWhBJ1Hvujt8SkFGbaf39/Dr7J9CqaMKmJzlGJENM8fjUcwBVT9gtTTX?=
 =?us-ascii?Q?K+Q4c9M1zXWLz4bYeqD5QBWk7BzTn6uqEj3hNN0YGRXquEFPQSHvMW+95QN5?=
 =?us-ascii?Q?kJaUXISfT4pkI4ALkEBttKzUi0cVhRH3aue4+pJBzcyqiZ8n1C99kPf5N+5g?=
 =?us-ascii?Q?oQkIBHjYXTqSLSI4vXLaCMEhPjGrW4lYpcGxfyzo4z+3O2TxoLCZv4xAfKbg?=
 =?us-ascii?Q?IORLvmGRdviOgoj6rLcQLhnTJ1r1exjVuP6K13OMbuznR557BNDxzmFwhXgl?=
 =?us-ascii?Q?y2ke4TyejgmSofdMSvwjnG2Hd2R0VooXCxkSKIIgA3BRxKskl/jgU630sWJ9?=
 =?us-ascii?Q?08oIV56TVNlZcC7WQcm/qKUzgZtI1HCrQml5dVU7EPDi5WKl/jSGQDulFWQ+?=
 =?us-ascii?Q?fMLzCUBbsrLubBAANIjCwuLRsEq3lIZmyOn/oE2Pv5jhEs0qvlKcpldwKEDT?=
 =?us-ascii?Q?4dhGXUzl8w6AzhWOnvboNKKIR6GL2TK/3mGriXuBrTyo8r8pdjsayEbGc6N4?=
 =?us-ascii?Q?Pya9aUSzjmgFy2BKf477hAmbzsquI3dm1VYqNmKw?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b900a61-bf68-424a-5900-08db84496165
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 09:04:50.9075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GePfBhrdm2DLNkuNRf4wNsQdMI4DebWoGygbM7oqmfhvMdCeiOiC89Kq4CgCNpCK917vv6foMsyfGczDXX7CaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7736
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

This patchset is to upstream NXP downstream scu-pd driver patches.
patch 1,2 is to support more PDs
patch 3 is to not power off console when no console suspend
patch 4 is to suppress bind
patch 5 is to make genpd align with HW state
patch 6 is to support LP mode in runtime suspend, OFF mode in system suspend.
patch 7 is to change init level to avoid uneccessary defer probe

Dong Aisheng (2):
  firmware: imx: scu-pd: do not power off console if no_console_suspend
  firmware: imx: scu-pd: change init level to subsys_initcall

Peng Fan (5):
  firmware: imx: scu-pd: enlarge PD range
  firmware: imx: scu-pd: add more PDs
  firmware: imx: scu-pd: Suppress bind attrs
  firmware: imx: scu-pd: initialize is_off according to HW state
  firmware: imx: scu-pd: add multi states support

 drivers/firmware/imx/scu-pd.c | 193 ++++++++++++++++++++++++++++++++--
 1 file changed, 182 insertions(+), 11 deletions(-)

-- 
2.37.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9097C889D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 17:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbjJMP15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 11:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbjJMP1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 11:27:55 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2077.outbound.protection.outlook.com [40.107.8.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB38BF;
        Fri, 13 Oct 2023 08:27:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L5REoFkpaeOtRAprOjpbbscGKTmaq0S+b/Gi7rXreizPsmldkEF43Q5tEOIHH0H1Kjo8Rdz4SVeaTpzXcmgzF7h6JqvUxYF65vzklslDGdmdYm0Q/xOam90860APk7gK7SIWxdB6vET79QWDteopaUcHISxR/fICpa/YFYx1G0+DyiLA+E8Aw8NEewj4rZMQ94K/i6j4eOWQAyL+NMrmt94fD0JVr4NA4vHyR77FXw6+p5ywSIALrggVOFCXlVYtTk5yMqSWvEtnjRPTqmRy78zGO5MQVj+IYsrpg1CgBDVwwE7BusdsqK7KLgD425ocaWBWFWxOgGK/CuK8dGcSgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4qIOOEi6PDTlN7F+W+FeWKv8dBsaMG7HMOGC2bc7fEs=;
 b=INRzhdk5rpwFvVNcU+uZScmgL6ZO0pU9pRrv5CocFbtSIMdh2kufjxvM8MI/Dw004r/SiKKM2IdmkJDFgZu0MHKM2hIm2ds3CsyB5JqObBHDzkrNQ8ZXlgBzEFAzxcHHGNSsAQ9RgqsEI4rR/RVXQ3RCFDJTYnbL4OaiGjtHWDCa0nGokBmqv/X4wT3uUe2WpfI3RVgzdl2IEWEtzxqxMJCmQrsIDq6ghjXrIC7nvVa9s+Fzai+aGxK3p7h8t2tMfrMtv3CI4S9a194DbAICMtl4rhMM2EiYZrX/CSwfA1tz+GfnW1g1B3HJw/yPOxO6oPbWUnsxdDWiIbNjOqAO4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4qIOOEi6PDTlN7F+W+FeWKv8dBsaMG7HMOGC2bc7fEs=;
 b=H5j9fg90yWUrPsUvpW1tP0yXpGFTrHQMIrR185Q3MZO7uH/ZZhMvJ/FY1ig59ap1B+GGaDGE/fOtx2ok0A7d1k3S71NEJc1qfiFjH0g0KdJ4zWN5UW5D4jPu/J1ymvHP4YRfAU++GaaCdaPOwB9RPMn+geK28xO530E3VDgZuN0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com (2603:10a6:10:2e1::21)
 by AM9PR04MB8114.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Fri, 13 Oct
 2023 15:27:50 +0000
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::ad2:49f8:14b:25c7]) by DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::ad2:49f8:14b:25c7%7]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 15:27:50 +0000
From:   "Iuliana Prodan (OSS)" <iuliana.prodan@oss.nxp.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        alexander.stein@ew.tq-group.com,
        "S.J. Wang" <shengjiu.wang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mpuaudiosw <Mpuaudiosw@nxp.com>,
        Iuliana Prodan <iuliana.prodan@nxp.com>
Cc:     linux-imx <linux-imx@nxp.com>, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        LnxRevLi <LnxRevLi@nxp.com>
Subject: [PATCH v4 0/2] Rpmsg support for i.MX DSP with resource table
Date:   Fri, 13 Oct 2023 18:27:29 +0300
Message-Id: <20231013152731.23471-1-iuliana.prodan@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0169.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::6) To DU2PR04MB8774.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8774:EE_|AM9PR04MB8114:EE_
X-MS-Office365-Filtering-Correlation-Id: 441a5c8d-967e-4338-4d5a-08dbcc00f631
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6q4X0c9BNxTiDTbc6xHoSHKpWSxrQxu7a7iX3qpXe66HtcDOtsYAsLFFqco6Cy8R+J1zACPf28lJT0eCfJIxCicbDQ35obTCqscuNLB/TeWg7cmQtw6AQA8e2NsHM0gAkvtDC+OiMAHxwCn0cHZ1aT/qGNjTGtcygzV2H28zifp943RKGWsDfJfWAoMPtvnEL0JGQc50y/C0fPpEJ8mLM4rhaf7oTwe/wuByJzbWGhbT4c0PTnuvYmdLtz6OnIEzmBk3h0YolJEhNt92+YZcTfMV0Ry3b65Iz6lskct/GVFfY/PMBOVWQ4q9UoTGOaEZnG2tZxL5IirnYG5/RSTbE+dpjgL1VVQMA+PQKI2tM2F6Ax06hF9IcR2pHhJubVVC8wSIYK9oE8APuUy71V7BZsa61pjdkxglqzT5dh2feHeaMMLRUgd0dQezjT15VbPyuLzEKUGwfJi9t2Ybz9LIZONs/Ry8psF9tFcVXel2NCKdjeWuo5VN32IMKAGflorSfB18ksBeMQSbnMRNVf18Vl+4bSSk2mDMQhQ9yh4HEDeMG0bbd9cN1JfaXuaWUHzCIOCah920QsunUevV7OfItZ3C78tcfeMYKZ3qAn85UzmMAjU9ePTJ2uIVkONHni6icYdsHBtoAHCO2vDmL2hDVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8774.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(396003)(346002)(136003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(8676002)(5660300002)(66476007)(66556008)(54906003)(316002)(110136005)(66946007)(2906002)(4744005)(83380400001)(4326008)(8936002)(41300700001)(7416002)(38100700002)(38350700002)(921005)(26005)(478600001)(1076003)(2616005)(6486002)(6512007)(6666004)(6506007)(52116002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VArnlZm5BDdO1ZhFxCAHuagmi2TCfrLNozHMqrZzYFQnF6IHHnpFq3x5FpXv?=
 =?us-ascii?Q?kyakWatuZ6nmMcyrGb8+Eua+xbFqZ1a2d/AfvKU7BAOmspSUFXrKpBedlDi3?=
 =?us-ascii?Q?8OFov07uJeMzqjMX6Hkor3wvRi9zXPVzOcINdH1r3avEXCf49AA0sDFSEwVS?=
 =?us-ascii?Q?evQGiVL34BkwIR+nznDIPDNiAYqEs2Owm+7M9j1/SSdaa+OETXHnJs4V+/4G?=
 =?us-ascii?Q?6Lt6oVgEWv/rTUFvrxw/XjU317GEzlcopIbwsIyKzXUgMTB7vgB2rBk9aPFk?=
 =?us-ascii?Q?V+dT/b3KKESVYWCwKiJkpIvLtbV4Ic2Gh5N26pp4UwRd1nZonFEQ9KHM3IR0?=
 =?us-ascii?Q?0fdkfM0t1rQjGDLSAM3roV+7tq/bNHo3HmAJscP2XOH1LuXFZlZVxFCaW+uU?=
 =?us-ascii?Q?D/HG3TBejIE/UBkc0hrHzEG9iYJHIZV9ADtBeEdctlL782BJurJwaa2nPLjO?=
 =?us-ascii?Q?atdYaMapm7OUNBMnI8ZJnBnlmxXmmwdQHngvxXnLdZIGdkEpfLg0zwSmzDlm?=
 =?us-ascii?Q?H5DuZlmdEjqvbNHA6WaCSV9lFglecNkCw+gxCzG89w6QzazlwBRTPqtYrxK3?=
 =?us-ascii?Q?HMJjSNXfakCKd80LNfgmj4parDomawGcygQHjrcpg8ebLT5zVvXPIpedYqVk?=
 =?us-ascii?Q?zvj/M4Swf0V9pAKZYqjYL9DE5D0d9M4dQx1AJmum+YR2SBLpZzsIUhCB3Ce3?=
 =?us-ascii?Q?nUlfnDYpcmPmZW3khB+SKa+kdAtRtHXz9e93Jkk+u8AtUMiEI9mTweBxSEFK?=
 =?us-ascii?Q?10Rfyq1QbhiVmtSyvtPZSsejxa/+dKeUoSpFrUPnelYqO7uN6tP6AG9fFjSF?=
 =?us-ascii?Q?RlcyyUgH0g0kaeZpiF99sF6MEGhThdfWIqSSY/syx7JPdwoETmVG7uyuAQ/3?=
 =?us-ascii?Q?XPtus1E9igo5bYsMmM5h3XLBTidgoGnDcy60JIceUmY/VfRd0ScgyyzXG5wH?=
 =?us-ascii?Q?H+CX6hGQX3BmIITe99NUx2eCTb1FjZxhKUEi+wumhSt3XMQzP8SAGkiqS2Zs?=
 =?us-ascii?Q?BQKMVpHM1r9b0HfL2hWCgvL4AvEEinQsLI2FYY72B/QVeC3Jgw+JMZdwgLae?=
 =?us-ascii?Q?csA5POlelGw2kgXMUbQhyTiZZHQW2mt59rOYenmh8VdArSkEbehmTBSiswd3?=
 =?us-ascii?Q?srSDzRckfmx3wJqW8LVjfNIzzj5oKJFSyf29HsWTtd2NeqWffFmosf8Xlzjd?=
 =?us-ascii?Q?u95SWeEVMy9VaOllzZJYBI+RjoeJrkOWHhBF88GjEfHQvLEZ/bSjxpK6YKkW?=
 =?us-ascii?Q?iGoDS87nl8hEd/mPSqBj7j3JIbhcOKITOqXSwVtJKH2IUh6mlyxh3WQ+xiTx?=
 =?us-ascii?Q?VmYywpA9322UKHe7X2VqBlHrt3v0WAgT/9E42Ibrk0mUT+DfiVdMv19q/BNX?=
 =?us-ascii?Q?RdorLPr27u0XwTSnDr3wWPtaA2czSurDmUpIAvWRkv6vcqir+08sdyUnLlBN?=
 =?us-ascii?Q?Zfck33R10g7RsxtZV3K7U8jZnlBQMKed273M0vJGwbHSlSSk1/tn1QmHicrN?=
 =?us-ascii?Q?PjUtw7UFMpqS8ZdXWqqh1u3ffWJwIsffrpGr+8EIrraplZM9IsvVBY2ArRTP?=
 =?us-ascii?Q?NVUgGhCQLQwnjuqjKe8BMt0kL423TNg604um114GhBa+c/DTKej+WaixBuni?=
 =?us-ascii?Q?Ag=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 441a5c8d-967e-4338-4d5a-08dbcc00f631
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8774.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 15:27:50.7326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eD102p0WlYPibJUA7JxF7nlJCRgzBIrJbrKjhGGN+/s8xiP2CkP0kJcyoxAvktVXUbr5VX0/xm/J2bzFHNG5Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8114
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Iuliana Prodan <iuliana.prodan@nxp.com>

These patches are needed in order to support rpmsg on DSP when a
resource table is available.

Changes since v3:
 - add reserve-memory nodes in imx8mp-evk.dts rather than .dtsi (patch 2/2)

Changes since v2:
 - add newline between nodes in dtsi (patch 2/2)

Changes since v1:
 - add missing bracket in dtsi (patch 2/2)

Iuliana Prodan (2):
  remoteproc: imx_dsp_rproc: add mandatory find_loaded_rsc_table op
  arm64: dts: imx8mp: add reserve-memory nodes for DSP

 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 22 ++++++++++++++++++++
 drivers/remoteproc/imx_dsp_rproc.c           |  1 +
 2 files changed, 23 insertions(+)

-- 
2.17.1


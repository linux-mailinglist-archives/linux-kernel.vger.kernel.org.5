Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA45787642
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 18:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242859AbjHXQ7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 12:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242889AbjHXQ6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 12:58:50 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2064.outbound.protection.outlook.com [40.107.249.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936651BDA;
        Thu, 24 Aug 2023 09:58:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q/53RJZeDb0f4XTYy7kxgjrDuBGCYFnwub3zqvgvcyIefNYYK/9eWzBjdNbrHRbGHJWaJdKOrpwW6cTTtg9IDuksw4JuXnbXqEkJ9HdcjRj6cDhm9Q0ekTWMhOZvHMXmZluUf5kqQUmeoTDQOQ18XBCa9EygW2J2tSHHtLOwf0g+RbvQ6oHbSZWi9yCxOm9DExRtvsM0f8Sf2dnQcSxQCNEHvF4gZscs6PoUW+gG2av/BwHR6PVWIVuVqQcpjNHsTie3eP61FSM8slVEj4+GcruGXQ5dXW6dIJad+FP+GPAyvc/UcaJt7C4nlJjOZKUoRhhPHbu4UULw9aPijdUQZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lvLetO68Fjqw6jc/9zV6XNM3BEaggyQ4lbbSCzKQM4A=;
 b=lVyHOrUAR6NTY6eUsYM+Y6+DJ5Pz7/ABnPjeegHcm1HBGA/sQ9z5aunwLN6onoKsdFMZN0fWcGuPhX9JotUSyS76nM8/pdU9ftt2N8W9KtEuBEpfXh5K93dGapYfvQq+ohvhpOvSplOVf3N1NxTK/umHhQPtj07atbQEBm/TM240jdy2i8hwA0CrOUyupA8GjKOYpXlQRYOD7ns/FyHE0zeuyOA+eeKRWvZVf3fWd3dg0Xwf8yNntPSUlw+y3ZEcDZjXwqWlr53wTtg55pb8jD5W7Y+fJJlIIViu67LnZ2dvcKe9w1I4AWtYRkatGKZW069OG/vEzLeH/kpepXmqVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lvLetO68Fjqw6jc/9zV6XNM3BEaggyQ4lbbSCzKQM4A=;
 b=MCBEi5Nx5OjeRv9Wfi5eFXzJ2pTkvrbQxMECj8Si4REzM0aNdVUOSuIPtQwTZ80vsnjZFgrMOCWGegnzkb58awYNXFW29qrlatUmCF8NvJUi3T2E8wNlZb1P0Y0jzcQXkArP6jzSYAMEsySnbAtv7KRYRxb4YI5bIfzG6Qqlmdg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DU2PR04MB8582.eurprd04.prod.outlook.com (2603:10a6:10:2d9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 16:58:22 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8%3]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 16:58:22 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     festevam@gmail.com
Cc:     Frank.Li@nxp.com, clin@suse.com, conor+dt@kernel.org,
        devicetree@vger.kernel.org, eagle.zhou@nxp.com,
        imx@lists.linux.dev, joy.zou@nxp.com, kernel@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, pierre.gondois@arm.com,
        robh+dt@kernel.org, s.hauer@pengutronix.de, shawnguo@kernel.org,
        shenwei.wang@nxp.com, sherry.sun@nxp.com
Subject: [PATCH v3 0/3] arm: dts: imx93: add edmav3 support
Date:   Thu, 24 Aug 2023 12:57:50 -0400
Message-Id: <20230824165753.2953431-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0052.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::27) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DU2PR04MB8582:EE_
X-MS-Office365-Filtering-Correlation-Id: e05bc3f4-4db6-42c9-08af-08dba4c35326
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pp0UM/pfEu/os5YSMjTfVOvZXl3c3XA92uniOoDxBEN66yweFKQUTlHQ5TNSj9151B2oIEYrZ9/cnkyDFulAsdrdTCk4W6uX9AaM+QWeGIaUV5e8fFnJBAcnIaCnf9rMVCW0VPN7abB4NfJjUjYUJBvYxEUB5jRuGWa9VFYMCCEWLqj7KDoIJ4awEis3JmF8QZLOTuHhWjJHtnIYS53f4UCK1EOElsJWPIPovj6eZRrQqBAQe4stPen1WvDWwV4pBBQyiblGYUmF+TXwdIztdRKGfg8qpSbOIlcZAyOjWD86C1vvHnO6Ji0RcgRvPytp/5g9BaDnKYz8Z8xBZYQL5dNbQlAKq1nzsXuljE/JL/lkIeYwZnqj7Zj8TBs+Hdt8yGoZTfN5oKw2LFCk87TooknQ2UzyGa2j6xH1iCaDy6hKkCLKJDnSnTe/9BQGNlpBv4rqLc8MXhr4wikvLEdzrBmExfm3SiaijMRyyDjmke6OOsXy0KXHdeO6flA3JsN0sGqf28LNQt0zEtf5DMm3Jhzq++dnYnGRILfyJXnJXKe1700FvIMLZ1jp4gFwVw0ZBoTZSXi22XPs0lXLJqOMpXw1H3rZDqj2k4L8GkA9ntw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(396003)(136003)(346002)(186009)(1800799009)(451199024)(1076003)(2616005)(5660300002)(4326008)(8676002)(8936002)(36756003)(4744005)(7416002)(26005)(38350700002)(6666004)(38100700002)(66556008)(66946007)(66476007)(6916009)(316002)(478600001)(966005)(41300700001)(6512007)(6506007)(2906002)(86362001)(52116002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+eCxGrefYSLE3jRMd+oKlfRZpJDB5isSS9fh5fatfB/32s/3FyTqlAEDkQEz?=
 =?us-ascii?Q?g+BKfACllTNzX042TRmJsAn0G0oDNdAu7C/LSsd3NKEgmIwIz8Q91CW0PfdP?=
 =?us-ascii?Q?kUeLxsbqz/OPrT6vIqUOMm7meNdSqbiHQRP99B8cL5bmBTh0CAcICUZGmuiD?=
 =?us-ascii?Q?YqYX7k1VA2OVJaWvMx5MPN9udVv43/xzSPe7nXiOqZp42T0aFkE6jIEGA71u?=
 =?us-ascii?Q?6uouXbFmSA4rQbNZFpk0u8OO6jZlsNf2uCM7VGqKj8T75hiMATz1/MHyYe3t?=
 =?us-ascii?Q?Yu4N8W+WMwOe1Nrk8zca/naVxMWTYbTwEWhICbGMDxQEUw0wKujO462bg7SO?=
 =?us-ascii?Q?DltY4wZR0y7p3jzGxYCx/9pq19bDdU9cFdJzhiMg4PPEKUny9DSsGHCP1eYD?=
 =?us-ascii?Q?Ge+tJU6blmfbgHthLZXZp2EM0V4PY4MJL3pepGxYMgRSwU4LM55vdorYZga2?=
 =?us-ascii?Q?+cBhlVRC0UIjhPYw8Ym0L3igPu+VXbT4ALKjof0H+1juRA6RYQWmy0thT9tl?=
 =?us-ascii?Q?xkjD4L9r+RVwA9sxYsFahEoevC2TOLfyLyexpFBnl9EDuLcZuEe+Nw4D16dN?=
 =?us-ascii?Q?p8m/+19aDNLLgrd4gkzECe8/UAPsLzqWzgrZKzcq9gYkdctFyLlKzddvVufb?=
 =?us-ascii?Q?c1jtxoEsX40ik0lJMZstLFmeHfJuc++tHFiXgLpp+7Qmg76NwA8uxCmNJsJS?=
 =?us-ascii?Q?Y+5GLEOBDE4PnzJ1cGaNbHHeLr/eXA9jGDdVEza04BxvSkxBPuu3gz84N0J/?=
 =?us-ascii?Q?YUm8IRR75qHlph16ZE94ofB6TxCKWwWN/sVX0U6yKdFGyW92HGpGr+zxXHyE?=
 =?us-ascii?Q?RJdpUO61AsuZu+0GIrXaUKFRp3m6+N1p77N864ybYKM0MninUAYFNNttzcDX?=
 =?us-ascii?Q?1yaoISP7TBcxb5Ctqh8DaTow8qiMLDqbDXZLPpodCpMn68a4lec3ub7XxO7v?=
 =?us-ascii?Q?quTpV5nnt2H1BJNKtsv0NARETt0Zl/JN7cYt4hg84Joix1mZmDf3myxHFRrz?=
 =?us-ascii?Q?tpV2hiydBHGYiYG4xdAF7XdThV6MX8ClHeyqaSbjP3NuS0FYvw9bVTx+6gST?=
 =?us-ascii?Q?KKJQhSqEt3JGKMSVbtcvirQv7Z2xINqEt+C0cII/SKjA8g8Elybc2/3T+AMG?=
 =?us-ascii?Q?T+FX9qC7s6NnCHG2FQkADNKlMQEpJbYTfBJBPtcoNnArokfnjPqTC/QDkI2w?=
 =?us-ascii?Q?uVwCULAYKekreQAjsWFMUbsG97m1jz6Qytg5LIDSAX+tHq0brFOYuXAFihzG?=
 =?us-ascii?Q?65pyNIIwgNMH2oGgS1MHyGS3uuESTWXMmv+0PUXOyLTgoEg1qCmTtZ9xg8lm?=
 =?us-ascii?Q?3ybm7KqhYow7ycK/Ga8RUTzTpvQlLSmc7S1Sbf0rD9zgmmHB/uqRhvDp3qP6?=
 =?us-ascii?Q?xw7ip+9i2X+PtrfEWBjyu/tmzc6W6B2cSCOEnXT68CVyzV39izFvwFTdTv43?=
 =?us-ascii?Q?SLEum1XRxPdanLweSZU1PqxAyZlyGfeeJz6ydgkq7s9O+/+gAXwNhW1syxBP?=
 =?us-ascii?Q?ohHWbwFsZh2tRCROkyhlcEN2q6ln/K53odprOEWoAv6xovl5KbA5lGpNzunT?=
 =?us-ascii?Q?Faa3acCoW5JgBN97ReA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e05bc3f4-4db6-42c9-08af-08dba4c35326
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 16:58:22.7900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N1LWmHThexKh/WluK3JU7riUC1I1fKYwWPURO/PQBolYUnrzcSEdAHKHuFujfH/qteiYOs16n1c87k5hz603Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8582
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

edmav3 patch already accepted.

https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git/log/?h=next

Add dts part for imx93

Change from v2 to v3
- fixed Krzysztof's comments
- drop unused fsl,edma-axi

Change from v1 to v2
- Enable UART1 also, lpuart driver will disable dma when it is console

Frank Li (3):
  arm64: dts: imx93: add edma1 and edma2
  arm64: dts: imx93: add dma support for lpuart[1..8]
  arm64: dts: imx93-evk: add uart5

 .../boot/dts/freescale/imx93-11x11-evk.dts    |  15 ++
 arch/arm64/boot/dts/freescale/imx93.dtsi      | 130 ++++++++++++++++++
 2 files changed, 145 insertions(+)

-- 
2.34.1


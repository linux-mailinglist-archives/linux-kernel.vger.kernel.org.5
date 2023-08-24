Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB5B078759E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 18:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242338AbjHXQkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 12:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242400AbjHXQjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 12:39:46 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2070.outbound.protection.outlook.com [40.107.241.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8404F1736;
        Thu, 24 Aug 2023 09:39:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V9C40hZBZZlelrsSFYRhuTGDyEZS5SDTgmS2Z3BBGgRqukv4XX8R0Y7kSsfAaxjdKj17fZmjfy1zT9jSTaZmWSY5Eepe5qLq4mmUsDd7SgyGZsFkzo+tgsnrP9MKJtQRTY+6QL0c1TpKnnwfwt1zelM5V5nTmvhihw/Psv4vwOsP2ZQqCpHbbadwNn0I55KXQ+dwktNZX4qM3Pv9Zf3GA6Ae7aVGuM7ypcRxEmoRu/oiMA8Crp7QUQrjZY11BPCmXsHV62D3P5V1EzjO/c15C7Ofmf5ktNDXpQOzYXYuwqSykQigfhVpWP0EyD68lj3TN+Gah8G3ldqqOYZvvJf6qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jZHt7HfYu1+rQojXWpMLhoNBO5ey22/DJwBE0FEwCEs=;
 b=EdY8LclaNnlcfRWGN3JXT8/NlrfcDThU0SVOE6LDiMkTGIPszLjakR20gtqqVqG0ol7fvdZD5P/J4TUj89EiTa9N5OZtJfFmD0klKt80v4K143019W4o9XgX3gTp+sjBMYnI6U6Y58el6NfpoVWGtzytRqEj+v+EzKJdE3XJuZwPaDnMrDt0A+rWigu693wQvu+1GlcB5ea5vfwwxpeMP3irs5d61jJbf5W300Llol86mSqeuYqmlRMvjNabNxdafPH1CJdteNDS/3VVCYcaaq1wlU0KicJrdJnyY0Dk0pSykP6kUz3ceApuc2WkMhiKD5pzmbhRALv8DtjA+dx/Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jZHt7HfYu1+rQojXWpMLhoNBO5ey22/DJwBE0FEwCEs=;
 b=li4KBt88lczMChbMZZdXYFZRDkGmRnFGNBhnPADVDx7zc9Z9i5tp6zwp8osqNbrrijVu746B2LXoROfynfv/xByUZ9mtm2luz84sgBpZ0K+4ifcI048xbKXGiWw+MNMmM96p4Cb1nw33n0xcstoSk4V4acK2I48VL9e8LLFrlTQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PA4PR04MB7517.eurprd04.prod.outlook.com (2603:10a6:102:e0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 16:39:42 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8%3]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 16:39:42 +0000
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
Subject: [PATCH v2 0/3] arm: dts: imx93: add edmav3 support
Date:   Thu, 24 Aug 2023 12:39:17 -0400
Message-Id: <20230824163922.2952403-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0198.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::23) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PA4PR04MB7517:EE_
X-MS-Office365-Filtering-Correlation-Id: 910a71d1-3cd8-4f03-5f8a-08dba4c0b723
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FPU2IkHqg1JDVrjkWT1T4Bolw4WNSmkWwj9J2hsU0iNswh2kBzr6PvEuARGY8ZFOlZis/JYeOXMz6W6Vh0RBhmD+i8Bagx4Rero6dV6GEbHmo8ipx4R73f7otxpJ6hi7S4fAyWYBV0pmrzegG0h6Z658/42ADyi5cta70AhqudDM9/3gvcLUDlBQULMs4ch5lD8RFP3fHSSivTlHSKqQKaGleCmqUZA20Pw8eXbfUPtJqutUGAcZKNnTVpcztBz5yc8JbA0OjU0d40d23yolTNv23XUyJLGnlpShoYz3xuvHzLMFD6zUgN3dRgg0gf6JAMeUfctP6JdFMqdcP/OaWAXZDfq/wzfj75GfVeq4d+nuYRPEn+uKqK5AxfP3rxkU26NLDPUZBv0Xz1NRWwmDX4vPGaWTa0DlwvZMEcmY8bk8wockael7R0tXa8mXXJtxS1pq3FVRNyulGaKwAslJD6J6idiQAfsZdiov8P9kqvUpFaMUAPKMrBPbRvOZgELhANvYo1Rn5LZhrLSNx3ZN/SUrBHYilMyBbwfnQ+dvT7W4/oqzaEytELjda+aGwJhSKzplrVWJOlpDtSMQKnbaKDt8yDOTt/4cWAuUciZw4Kg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(396003)(136003)(346002)(186009)(1800799009)(451199024)(1076003)(2616005)(5660300002)(4326008)(8676002)(8936002)(36756003)(4744005)(7416002)(26005)(38350700002)(6666004)(38100700002)(66556008)(66946007)(66476007)(6916009)(316002)(478600001)(966005)(41300700001)(6512007)(6506007)(2906002)(86362001)(52116002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nh4HR7KMcHJnpTCvL5OWX/yWWgZBSr/SNhoAZF+KiAckh7nLGkRXpixzztqO?=
 =?us-ascii?Q?n1B16+TaNuUvD9iVIozWGuVSIB5sfK659oqnvIGIiHlbGMAkvjrFX1tj0GS8?=
 =?us-ascii?Q?0ktdcjjqNQmupQFButK+0NCBCrUZhBxDhHxT8c7x4lHh/4c5mSGDG4stZuco?=
 =?us-ascii?Q?9aS/Ez6lkTI97hcTt+PiTJK9IRfPMQA0DnIcQPz/1g/TI5kKdLS1cTyvijqN?=
 =?us-ascii?Q?9h1Hh3y/xB+nm0JntIP8m20cP97KpAGIgUBO13ohf8uuIa3BejWG6QyVGB9W?=
 =?us-ascii?Q?ho6sbl4OjP6gV07ODu+SYuKAuG85YdNLEvM6vv0GcSeV5FCKtir4UIISKLDB?=
 =?us-ascii?Q?qF1OGVLjl2Fy7Xj7xZdAS8pFElYhHcz/ZOxVmLxauxJZM7ynZewzmBHTJO6t?=
 =?us-ascii?Q?MXGXUFcMGYSaqdcbba6XUCxAhZNV4HqcIeUQWrX3wTUXbNj+RhoR6xfo5vyN?=
 =?us-ascii?Q?EiPJBjB8aIYtwJKXtxBciEcEFIssQXshtC98WacrbVqc25OZSs/o/MZrd650?=
 =?us-ascii?Q?VoEY/3CvOjpUvV9b8vXpY42e0EwNY8r6xq+PT1jdtluT77DrN/8puP5UQDhl?=
 =?us-ascii?Q?rd1/7gzSvehO5pHlDPgV+JEYnKUyJYbpI8E/bftlGfoQLWWfgS3pEjCGuGC3?=
 =?us-ascii?Q?SAtvqIq30TrD+LQTqNfYx6yyIncMd2BS3mdtBr6XAJ9cUWGKop0EiN6z5AUW?=
 =?us-ascii?Q?Dc/GK5RWKtBCroYId0x7aQxnkCMdRMGUN3Ombt4bahns/PQ4KhyIQmZaMJPf?=
 =?us-ascii?Q?KraWX/ps30uguSaMWuOr/VVp9MUjWeUQ1cxevJpzXbaY5F0HDe9Lu+wU7nKD?=
 =?us-ascii?Q?VEQlX8lboG/JbugH6SIGbTxi+0ANOo/WoA9CIaTjeQxyWrFH17fWJPAngYHZ?=
 =?us-ascii?Q?rFu9NIeGT6zHsQuW4d3/NZpzOAFQl8/Ou7DMAAtSMZjsxQnMcYHmOqA0y6jV?=
 =?us-ascii?Q?g4eThGQz/8J+PROu+ZqJN10kZtCJfvTnhthKbppy6idIQ2D66IoHy3WH3x/p?=
 =?us-ascii?Q?tNvxa+3uMOq/EtgVZXCCck05FC0r3sHow0M51dYU9cL4L0TsZqCqzdknTnwv?=
 =?us-ascii?Q?fwkOvhyr4ahssy6+Q5rmyLaSaonsWxig7LTs987V2doK2Ds2iTLYNQjaOTB7?=
 =?us-ascii?Q?/k7VvLmnAFpZCs9JpECTLtSEFlhswpZvgL3B4IvJwQe0UVFpAM3aZfQQNVDl?=
 =?us-ascii?Q?1M0rh3guHC6nADVXCa3V6gFxfGKRhM/aYU41zFzoPbhcfy0RWdvr+qqYvjUd?=
 =?us-ascii?Q?/C/4SzZgJooskoLcaRbWVC45Sdc6fl1aD1Xgx8fAQc6HRXSBicdx3v/wj38q?=
 =?us-ascii?Q?jWyunDVsGkWAJBvUHa7pNrLrhyOun+8WcUOJ5lbUzzdM4Aa4tjmktwQlWzV5?=
 =?us-ascii?Q?24MocLskX2PMEJ8tOsgMTQkWRVfnAazXbHmK/loSjirExJPwmBXLy2aGegti?=
 =?us-ascii?Q?Ol0a4ascoxINuInhduyCNkWUle57TN74oWjRYUXpEYuBrNkH7pittT1+uKFi?=
 =?us-ascii?Q?p34zUPw6xPl25HeS/NTUjdcjv55nttDWDTCTQA2lVO4uOJqGPm6C8avl7ghe?=
 =?us-ascii?Q?wbh8+CmEReHIg4coBlM6h7mYVE392ew9siyq5fLe?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 910a71d1-3cd8-4f03-5f8a-08dba4c0b723
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 16:39:41.9560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QrByTPezt7PQ7PLjOeqxwmTRMjO1QZ/HPm3E/BEF6QKtkZRrmIryHX3mstVM15SQWzkWQ0m5e6HU3aEVTMiV8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7517
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

Change from v1 to v2
- Enable UART1 also, lpuart driver will disable dma when it is console

Frank Li (3):
  arm64: dts: imx93: add edma1 and edma2
  arm64: dts: imx93: add dma support for lpuart[1..8]
  arm64: dts: imx93-evk: add uart5

 .../boot/dts/freescale/imx93-11x11-evk.dts    |  15 ++
 arch/arm64/boot/dts/freescale/imx93.dtsi      | 132 ++++++++++++++++++
 2 files changed, 147 insertions(+)

-- 
2.34.1


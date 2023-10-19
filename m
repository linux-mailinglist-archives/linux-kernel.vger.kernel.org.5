Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6544A7CEE31
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 04:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbjJSCs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 22:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjJSCs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 22:48:28 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2073.outbound.protection.outlook.com [40.107.15.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A320125;
        Wed, 18 Oct 2023 19:48:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gsRKTAVyAqm0HTWMJESvYebpra6UzNmPk9O7RBcsUBrt67bA3uLMXZnm1kKaf5Ej/cH+zXiTWXP2AOXqc2QpsQQaFeodN0agsEpKxT4THv7fbC77sY6deHxKyjMPBQDnWNTIKvBDnHtlc3/lsGqkugYou3EFH0N8nWwGEQl7dsX8pt/sWuixRb5VM1Gt9JvAo9g2ZC3iptbMo52iUmsCpYj+iHOjojFcV0iaHxyaEcDY2H2HCP4ituDkfCv7s1a15lvgB0ECwY5AvzuAbXxdHvYh7PKtnw6pNIzwUekhG1PZu//AQ45RLE6PTJcync8B9vtIKmI4JU6jhyt/K0uJ0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eyynim2anQ84B90m57RBhLrpHIhOLcB7Ur6osaWy2E8=;
 b=BWyAziNv6d9+Ef/6NOK0yPmhcT1Yr2xSDc/hMipHsvQwMV81qSgV1bWjvLhJWGMAlBRgfhyvsFOZ/aNnN6Tk+NP9yrC795uyOimUwFVHTixiH76ApLvyjmLCbhPrIOjMo5VwnmPii5T4UJi5D1NVO7szoODg5F9O4EGJKpNBk0xFJKecEDFKP2G95L/JQozKyUSmUbNcofUl5F5n95w1VanUw+iwL93AsvV15wdh/zvEi0pqM3N21XDc5Yh6mGkwoZn7F0zxKkDx19lFo4szHAsJphRVFCqrB+3Wew+/oRa7BwTF7qs0BkTXE6zDkOlM+z1Jrb5nWVdCH3GH/mqMag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eyynim2anQ84B90m57RBhLrpHIhOLcB7Ur6osaWy2E8=;
 b=cJqUgAbB9vQPgl7y/Y7oLxNDy1Rv3Lq5yO9Py6nJb0aEs3fhdFY4zqBrRGmhJlWkY1Gz4eD1R4o8nP8Ie1mAqOM7FyrC+zxnqM4fXH94B0oep0QRO4+TwnubWYYpiU479VBABoSGabv6TUnl9hg4J02jJMSR7YgBcLYD2hXuqxk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AS5PR04MB10000.eurprd04.prod.outlook.com (2603:10a6:20b:682::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Thu, 19 Oct
 2023 02:48:23 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::6e53:39fc:f010:30d5]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::6e53:39fc:f010:30d5%4]) with mapi id 15.20.6907.021; Thu, 19 Oct 2023
 02:48:23 +0000
From:   "Ming Qian (OSS)" <ming.qian@oss.nxp.com>
To:     mirela.rabulea@oss.nxp.com, robh+dt@kernel.org, shawnguo@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        xiahong.bao@nxp.com, eagle.zhou@nxp.com, tao.jiang_2@nxp.com,
        ming.qian@nxp.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 0/3] media: imx-jpeg: Assign a single slot
Date:   Thu, 19 Oct 2023 10:47:59 +0800
Message-Id: <cover.1697597713.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0169.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::25) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|AS5PR04MB10000:EE_
X-MS-Office365-Filtering-Correlation-Id: 66e2c82e-7030-453d-bcb6-08dbd04ddc23
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q4l5BtlnRByotquWwNlTBzcSTkVhKsgVxbwlSN3pBfzzZSQlEPaV7TQUju1RozMxWRhXm1Tf5o8zJErPgJlkcGRlXrPT/e8uYNstRgd6sLf+rW555n+IvXYvRNjkCb4zBtAlhuC6If4hzxFuTZeHYxoAw9LQCIOs3tuKCPrbGKw1vPaESwLqA3KOMk5BauvzxyvJRrMfQRVQJB7/MFBSNlKbGPq5fB2/pyXNZr/aHMgr/9/HPaqhTFG5oUus234346ZFXcOGbBUfsaogNADIpsR99Z2qLRSZAn8YzOfZiP7DItHY8lgaLfuVXXLBd+pAnYU2aJ/1/UL41SZDLrUcoqxv3kAnUrxEE7Qd2+R0uaL1Ytmvdg3Jpc9VqjbTZDEOgn3sOKgKyi2leZdVm4sDsENiPoMes5uoXq3kPpLn3zntzDNgDWRxDoxK2gP/oukGDhgCrSIGglPidlvzA1qAQlAYf8YR9qV/vtWWQibEgKuCiAJ7AZsdNzrxRtHWfqnGcfrlPTLmsyNkg9ZuyvAW/gezl1+W5xJghkgDYlHZLvSxOzpiRwofUG3dWCLSrRwSzQD8Fucv7XnoEH7YaMiUSo9YwwvqUV0lDJ9SmA7IXIozGEo7qmdb0Rqw84DrVuED
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(136003)(366004)(396003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(38350700005)(6512007)(86362001)(36756003)(9686003)(8676002)(66476007)(66946007)(38100700002)(316002)(83380400001)(52116002)(6506007)(6666004)(66556008)(41300700001)(6486002)(478600001)(8936002)(7416002)(5660300002)(4326008)(2906002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IsMs2GnuTjVCVPdKD2axjhsmI3tRVMumJ/V5s0er6Dm90kCHRaQgsDew1+mU?=
 =?us-ascii?Q?wFJ89dmQxrdpa44O7jhs5UuV5lOrUQOvemB6uyalHfVYr99ImI9IFwDPdyXI?=
 =?us-ascii?Q?HabR1+8oj3CHzRV6dr8icqs/y5qXscZICZzxDeqA9WSK78TIM6P52eVm2Em0?=
 =?us-ascii?Q?8bc00d3xK/fmyhyEyMMPflAdFW6uzvRWBYHDWMVDeqpDODkYVlnm0pcbVIFE?=
 =?us-ascii?Q?eNJCG0QW1v7FvB+gXCVReY0foBd1XIqJ3fzDEbXbLzi1hDTqLB+qWBtjx79S?=
 =?us-ascii?Q?c3so984aszdnNTNgM8b8wJArSi91YraWnMn4X4x2bZSxk+b7Xo5C3BnOCRe4?=
 =?us-ascii?Q?VJVyDwARV/daOMiRPzdnuk9LSwpUb4u10/7bE2RrqwaK7a1ihcSjJMU0PzR6?=
 =?us-ascii?Q?QHarh6i6m+sZMixwzGB5Yvxhc/p2oKP7tmjXs9HSHO2WwYWeCEI3rtP+c+Tj?=
 =?us-ascii?Q?5z1M5zjspzVyUmE3xB1+DiD5VQPEooTO5pPuYGi1ca9BAuAXdTxFLjhRG95T?=
 =?us-ascii?Q?gaVj+W7xNkS7KOew8Ddbobf4hF/+GHvyq4n7g61nCbW+LAeE/bp5jrTRkCWP?=
 =?us-ascii?Q?OszY/XXkcGP1i1FpkNxn5bcQmBAlMO08h1VNI14KqlzR8rXeIopCRQMbS21i?=
 =?us-ascii?Q?ucTaBmqp4J3FiLBY1vIsm8AlNpX54UhFW6PDEfTSJZecy0t7Hqa7D18vUAT4?=
 =?us-ascii?Q?0lTUgcweeeJICxj3+jQedWc1oUkWO+bn4JCImfZFqvUXaOTvv4W5kOu0vs3m?=
 =?us-ascii?Q?TBXDwH2Arj0sZl8U94wI6I8QWc9HnIKN8oCEChA8tMLrB0ty9MiCDIeUXicn?=
 =?us-ascii?Q?hr18J5IfUY9hhx4MisDnv+oQEFWnMnx5fZAT1YYWIV9bBGhOQNufBEPliV7P?=
 =?us-ascii?Q?vEnXt+n76PafrGOC0JVayVliFu75kPkCxP7hV7LxqpwvwGKQWWxS73jQlyKa?=
 =?us-ascii?Q?AcgRd42MhRK9DOPsaGDc6wJmfwEuSeIphSU/lR6X5+Tmy3RGQZ//9D6GfuKS?=
 =?us-ascii?Q?Fbax+qIIP37vcwP/ZLFjlZb/o/94SfYcQm9ycCd6Nv0kcAZl70GrUoi8YAHi?=
 =?us-ascii?Q?TDvWULXw97OiNeuzkkpCsNKXW1ukpB8HEICkYbK7uJnJ1EeZEcfZXLMmo9wa?=
 =?us-ascii?Q?s0UwHi/MXLErscsinVYqAs3llUTq+yqeZEzwPxyZFD6utSviyDhuPkCx2moR?=
 =?us-ascii?Q?z2ce54s6MNu/W80eUw/+humtw545OOEjoW8xZ48/2+0lheDO2rFw+TpP17R3?=
 =?us-ascii?Q?LF3o/Wj58Q83A56lJawFsXRSf6h4ElzELbWB1Iv/EZenbUI+1XIUrMN36E+4?=
 =?us-ascii?Q?zJlcIXjhsvGbv5CYs7nSbgh4go4JVLq3C6aNh3yYFgE8CZ9HH1HdNqfoGCGw?=
 =?us-ascii?Q?khx7bGiLzWvHgpW+kkqscFXNUsybZelelVQh3hOqs7b/I/SG9d2ij35pI8nH?=
 =?us-ascii?Q?2kkOF5pcIebUXn3jNiBunjgb0Lws48t+e6mPTxA+SaBTHUF8hZZQ+u4nLr0v?=
 =?us-ascii?Q?gIyczsWBW6JZ8l7ZMtCRNRWfgrAo72ld6gM7qYNwVudFt130ZB2Kq7MBbbTE?=
 =?us-ascii?Q?6y0rDlDoOgeB5srmwQ0t5uUp7rMnTP6+Lfove4Cs?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66e2c82e-7030-453d-bcb6-08dbd04ddc23
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 02:48:23.1787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qx1wWRXF48/02SUMzB7aZYPzfs/YGbZ30shWm3J4KCNu1s05B0UNQo0gM0lDR+JIv30tDX9/LETQlB3D1GEV9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10000
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ming Qian <ming.qian@nxp.com>

This IP includes a jpeg wrapper and a jpeg engine, the wrapper is
working on descriptor based manner. It supports up to 4 slots, each slot
can have its own chained descriptors. Host won't configure the engine
directly, but fill some descriptors to encode or decode one jpeg
picture. Then configure the descriptors to certain slot register. The
jpeg wrapper will schedule between different slots. When some slot is
finished, the slot interrupt will be triggered. The purpose of slot is
that engine can be shared across multiple VMS and os.

Currently, power domains and interrupts are enabled for all 4 slots, but
only one slot is used. There is no benefit in using more that one slot
from within the same OS, as the slots are scheduled in round-robin
manner and not executed in parallel.

Use the property "nxp,slot" to assign a single slot, and just expose the
parts of the h/w for the assigned slot. For example, only put slot 1's
power-domains entry in the DT when slot 1 is assigned. If not specified,
0 is used by default.

v5
- improve commit message
- improve property description in bindings document
- update patch based on linux-next next-20231017 (DTS patch already upstream)

v4
- improve commit message
- drop line making the property required, to avoid ABI break

v3
- add vender prefix, change property slot to nxp,slot
- add type for property slot in bindings document

v2
- add a new property in bindings document

Ming Qian (3):
  dt-bindings: media: imx-jpeg: Assign slot for imx jpeg encoder/decoder
  arm64: dts: imx8-ss-img: Add vendor prefix in slot property
  media: imx-jpeg: Add vendor prefix in slot property

 .../bindings/media/nxp,imx8-jpeg.yaml         | 46 +++++++++----------
 .../arm64/boot/dts/freescale/imx8-ss-img.dtsi |  4 +-
 .../media/platform/nxp/imx-jpeg/mxc-jpeg.c    |  2 +-
 3 files changed, 25 insertions(+), 27 deletions(-)


base-commit: 4d5ab2376ec576af173e5eac3887ed0b51bd8566
prerequisite-patch-id: ecdb5f6c6975c1c8f10a56ef7fdb96d9f7d16720
-- 
2.38.1


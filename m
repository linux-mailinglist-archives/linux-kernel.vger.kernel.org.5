Return-Path: <linux-kernel+bounces-12744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8170181F98B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 16:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5F7F1C2260D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 15:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554E7E575;
	Thu, 28 Dec 2023 15:16:22 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2134.outbound.protection.outlook.com [40.107.215.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4249CE56D;
	Thu, 28 Dec 2023 15:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yunjingtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunjingtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cp3wxd5VoVRge34z3pH8amivOxKa3U4PxHoVClTbTHK7//bVY70QhGdNZpSP7EIjc4vMUeXx5RVsdru2R69KhCFCMt8lbiypZsqT+j3x78K5s8kKm1EgQkwCLhsMglqihWbeiyOHtHP+KQwjeNdIB+IT4SYB8rT/ESw4yxs89RS7LbGuxodYjGNGIVYLKmLjJzGfHHOcapkajyKfu67IIJEw/8WrrkSGj3BxBGw6aPXlHKd8lKPLVWwLogZh7ALXvpozGM7u2Bo8Ltq5P6s8QNLK2Xzf00ChIGEk+hV/KsHaYrxi9Cs3ZCylE+wJc+FxeUJSl+2/nzQwcuPrc/MPhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+kMX+iaQF7eV2eG4yRS9BO0ucCvnAayyILyKPd0OpWE=;
 b=ERN3iKK68ySforf4BRjkvdsp/D7zKeLHVXx3KLOcBs6hcAoJbPmtkhb2KlE5/G7m4ylpTIi17Ea5A6YOTv+nUvmJ8XUBBAYnOV2cWl4UCF0kUTWRQCrzimwvvMsOM41EYa0xHo8EnA5q7tSuVKrEOuyB5Y8zi1RSlkR18WgqCADqAnfOm6Y5aMAjZXx5xHsNC4Ud709FTytYd8gDkvYjB/dy+fPQyWxkxUxeBIEcuiKqsYwJzZwv2Y5G7Q/w7kQFs5LevybY2uU32t+5AtqMYfpAKo99wmXN81AkIoCSotlAa2eEtqXQRpUbyGa0zAglEi3lZ5R5GE2eiJTDGpfXEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=yunjingtech.com; dmarc=pass action=none
 header.from=yunjingtech.com; dkim=pass header.d=yunjingtech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=yunjingtech.com;
Received: from SEYPR06MB6507.apcprd06.prod.outlook.com (2603:1096:101:177::9)
 by KL1PR06MB6650.apcprd06.prod.outlook.com (2603:1096:820:fc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.26; Thu, 28 Dec
 2023 15:16:13 +0000
Received: from SEYPR06MB6507.apcprd06.prod.outlook.com
 ([fe80::883b:97ce:6565:e5e]) by SEYPR06MB6507.apcprd06.prod.outlook.com
 ([fe80::883b:97ce:6565:e5e%4]) with mapi id 15.20.7135.019; Thu, 28 Dec 2023
 15:16:12 +0000
From: "larry.lai" <larry.lai@yunjingtech.com>
To: lee@kernel.org,
	andriy.shevchenko@linux.intel.com,
	linus.walleij@linaro.org,
	pavel@ucw.cz,
	krzk@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-leds@vger.kernel.org,
	GaryWang@aaeon.com.tw,
	musa.lin@yunjingtech.com,
	jack.chang@yunjingtech.com,
	noah.hung@yunjingtech.com,
	"larry.lai" <larry.lai@yunjingtech.com>
Subject: [PATCH V8 0/3] Add support control UP board CPLD/FPGA pin control
Date: Thu, 28 Dec 2023 23:15:41 +0800
Message-Id: <20231228151544.14408-1-larry.lai@yunjingtech.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0039.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::8)
 To SEYPR06MB6507.apcprd06.prod.outlook.com (2603:1096:101:177::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR06MB6507:EE_|KL1PR06MB6650:EE_
X-MS-Office365-Filtering-Correlation-Id: 0eead564-e176-4df6-2e80-08dc07b7ec36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FVGnxHVJvlklSI5XYjqU9Qlmuq5ujw1LUdCfXjbtJpwsKtiA7SwAzGBYhG9h7uqo/+g3Y63W+P4RM43ybrl50uEsK/sG7zMmfrMgbOafsqze8yP9TR4Kdnsv0CDwvHy8QGT3BmNgYn0b8MlJJV02j+LdT2ia56eRBsxCcgDYnyOD4kmePC6j8LTvSv/LZeiGnxq5QJRopLqKG+fH9Gy1y2/zULliIidqcKzgilN53AewPhP94tfARF7+hadecSErvfcqweNu+XrFOjCCTmRk5cK4hc1YQINe4dsa7SEf83rOTkrGvb+YAy1piN5fBgLVSbS/0wFyokEvG1esOLIAWtkn5F8szRdnG21ZkPOV5eWTyq7/5GHquxjc2pKgpfs413KlLjf8DAqa0oglvx3V50C4CHhSiM6eQ5J3ph8ej5Un6+VJyfocijPRfwoxMDilHgyb+HmBtfyV8lXehHbhGgl1w6Q+5NxQUGZIB4baNbpvLyuOpwjo9EPYQSd2E6G4iNmwJCNBnqeXVFgkP+7HaSo9dDmvnUGsRlA1JLWiLXIxHyGtA7syvPZB9X8p+0SxHB0NbxgIMbL9qxe3nNCG1zxNeNwbHuvwwt0+yZyGDtw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB6507.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(39830400003)(346002)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(38350700005)(86362001)(2906002)(38100700002)(36756003)(41300700001)(66946007)(66476007)(316002)(66556008)(83380400001)(6486002)(6506007)(52116002)(1076003)(107886003)(26005)(478600001)(2616005)(6666004)(5660300002)(4326008)(8936002)(8676002)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MQTaqJf70eSmTmfgHmSqIA8QYmiQqtsyL6XmZoSfJnGkXgyJF/7l7YUL0opw?=
 =?us-ascii?Q?2dxWmr/Dpe8joxYva/yk5mrX14mIpig9hXiB3t60UQxeY5ky8vupabCKOYH3?=
 =?us-ascii?Q?g+tIvWBFmn1vJXrhaIEQEncOHPQ6KzEVRj/U1x5JVBZObzx2ndI058DuVCGX?=
 =?us-ascii?Q?EZD/w7DiJg00JDZHwNSqUNMtMYSwc4tDcEEe5mx5FwNb9/2wSFcPL8J1Ybi/?=
 =?us-ascii?Q?pAhqvXdLabHWYEWPZtXM+X1CppWykI7DppjK6cKS5Hp+hVb/n6OY4nH4zzaK?=
 =?us-ascii?Q?Qwfue64Vj9DYQ9l4+jz91HXHgv1Uah4ptvyg9cZKEE3vXFdCHeyPpsd/Lt02?=
 =?us-ascii?Q?sYZYPEWG2Rs0h9piqA1GVOY0VPApljMu8MLzvujfGQb5EhKcCq/umX8hUDMx?=
 =?us-ascii?Q?cyJjJdqfcNn7vX6uawzbwR+FTNGL995FxmmsJsesg90yIUlQB8hPuZOFeJ8+?=
 =?us-ascii?Q?0/zeDzNLsXlbPsfzG38bX3iYlkjY1rY6EDEvdZueDojJAStkl5yQFeDn96ap?=
 =?us-ascii?Q?XZHoZtokc0pQaBbsl3vgEDSoomTnFiyxNBgCzCrNnf5G+UnN6e70TrxWuMBU?=
 =?us-ascii?Q?scOpLeK0Vn2RHmdiPJLR2kybrYzOOtDSt0MVAaq+ktkWVDe3eLh8xP2qA+7o?=
 =?us-ascii?Q?st7r0GAVIKu0wAKTWQt5/3VIndzNlVh6WtL2w9Ka8dE0pWh+ihsnIPb06U1T?=
 =?us-ascii?Q?rs5Tfc/LVx7QBy9Kqmyd5O6WCYrYS/JEwCa0S6EgOpQyTtsLCvm0wnoKmeC8?=
 =?us-ascii?Q?COelabjkLarXmQS41OU+k8koOwX2n4ay0cWWzdHWQmrz7P/zKr/52Er6FruL?=
 =?us-ascii?Q?eI5z/+k+A8AVWEaRc70D2RkKhtUO+LzRjadsVze7igkuthiK4WxmMmkNoMIO?=
 =?us-ascii?Q?Fcxp8aVLuQK3uws0l2iDdOzPWwCN8kXaxEcacOaVSnmxz9eGBf+8rCqB6lbr?=
 =?us-ascii?Q?g3lgyY4k13FbPLAhx/d854rE3jan3ZsC02uCrKQTbFBgdrOD4bVKxen2gI8J?=
 =?us-ascii?Q?bT4CUFhnTL9OB3KKdLVUOCj+S5dgADwPikQJ6BHoq1hqMR2v4tkM4VwEOjfV?=
 =?us-ascii?Q?YFJuNCI4m1U1warF6pxC6YmbZNkQ/yUy9mCeZWjPVZuwhQnTE+JBs9KObnE6?=
 =?us-ascii?Q?4Oq7JTA1npPxPSmYbIjs9HIIe4QFyFEUPYPwIW/jNweMq+lyALg/5A+dtjWi?=
 =?us-ascii?Q?8KhXFMwM+AyC6wTyfzzK3xM/ek3rp1MI6caV80sbM+vzcBlfddf4DJTHVTZS?=
 =?us-ascii?Q?BfJmiaNORB1HgHe/hOHaPoZ8sg+EypZGwJ+zBaYDkvmX6wfQVTmiUd5x5Z10?=
 =?us-ascii?Q?bWmeSFh/hvdmdIE6BI/NsALQKqAY2dXVKGMeu1t1/ej+W8KZLL9btJnXRh/B?=
 =?us-ascii?Q?skMGrILCvNVwV0V4wJEu5yP5HnuaikajRo9MMUz55kmQijEXyBDi0wyviVhq?=
 =?us-ascii?Q?0RRWBMrkr0vbGe4hWnjRWL/IHrk4RddLjWjwwwHw4HgMYy3MmwFE99gPvEuv?=
 =?us-ascii?Q?VNFnJEb/HUBBE+sj+/uq+S0r82QqM16mg0MRUvzDa/tkBGlckFYAV1gw63YX?=
 =?us-ascii?Q?X9h2oBxKsmC32GwJ1aKzEgtKyzZQc9zF4mgqv5yfc1AvV/BEolgRU4qXb5pT?=
 =?us-ascii?Q?GQ=3D=3D?=
X-OriginatorOrg: yunjingtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eead564-e176-4df6-2e80-08dc07b7ec36
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB6507.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2023 15:16:11.1224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: be2d5505-f7e6-4600-bbe2-b3201c91b344
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wzj5XLWMeItG18y5vdFphr3BdomdEg9njcOz6wb81qgTHojg+l5uniKNCzW8mU2mB9I6RWWgQET92sPsr02+Es4Yfz0Rx0JHWYDjjG+kqL8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6650

The UP board <https://up-board.org/> is the computer board for 
Professional Makers and Industrial Applications. We want to upstream 
the UP board 40-pin GP-bus Kernel driver for giving the users better 
experience on the software release. (not just download from UP board 
github)

These patches are generated from the Linux kernel mainline tag v6.0.

This is the PATCH V8. It fixed and addressed Andy Shevchenko and 
Krzysztof Kozlowski review comments.

larry.lai (3):
  mfd: Add support for UP board CPLD/FPGA
  pinctrl: Add support pin control for UP board CPLD/FPGA
  leds: Add support for UP board CPLD onboard LEDS

 drivers/leds/Kconfig              |   10 +
 drivers/leds/Makefile             |    1 +
 drivers/leds/leds-upboard.c       |  154 ++++
 drivers/mfd/Kconfig               |   12 +
 drivers/mfd/Makefile              |    1 +
 drivers/mfd/upboard-fpga.c        |  364 ++++++++
 drivers/pinctrl/Kconfig           |   15 +
 drivers/pinctrl/Makefile          |    1 +
 drivers/pinctrl/pinctrl-upboard.c | 1309 +++++++++++++++++++++++++++++
 include/linux/mfd/upboard-fpga.h  |   59 ++
 10 files changed, 1926 insertions(+)
 create mode 100644 drivers/leds/leds-upboard.c
 create mode 100644 drivers/mfd/upboard-fpga.c
 create mode 100644 drivers/pinctrl/pinctrl-upboard.c
 create mode 100644 include/linux/mfd/upboard-fpga.h


base-commit: 4fe89d07dcc2804c8b562f6c7896a45643d34b2f
-- 
2.17.1



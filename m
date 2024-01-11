Return-Path: <linux-kernel+bounces-22983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFC182A60B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 03:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0564128A647
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 02:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FE1A52;
	Thu, 11 Jan 2024 02:32:24 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2089.outbound.protection.partner.outlook.cn [139.219.146.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8ECB10E8;
	Thu, 11 Jan 2024 02:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yg0QSTbCpzMem8AyKipxQltFXZh4dsm4ypeoVXRaO1jwx6mgfAdLNXFpVh1NN9SLXwWd+WcHrN0GByQCvRZ5k+Btw7SYc2sdw0RFZxpWFw2nVh5bygIQ17KknCPfg47uMGoLzwm+rKdk0o9av1b1DjK9UsjdmwEogUCH6FeiECJfrF11NTlLrHd1j1jv9XA0xrPdNouNT1FYOwNSBUevTJZAEG8iuAWZm97zQgQqz56MXIlfLTSyE/pnP2vCump0JgZuKH0QIhuN3fEdHN+BVyTbvi0CLnRwFZNYkuc9183cWDQcdnurmRjob3LPitRhCzKtNJUkZxaQMfAz5HDdtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vXuQIGfFVEBtr/N8W+aiZSJxha3wD+yJ1vsRrviJTHA=;
 b=jZ8NEffwqof3rxpegQzpUjQViV7w6LTV5vpUIoacyKRPQSqj2AJbALVzkTaOoe4k3xDkJRqmZ9RrQypxyZB22pU7m42u7qSuUJy6JNVDo86wEHgXHN72ji5joaL+ym60XxrwjGNvkdIJPienK8PzApgo6+JRjzryAPN6b8nZwTXDBHBr27fvIGXBZ2aMPfrr9j/0mgValtpvsGDNhk6ol6dRpsmCJ1xq1EYfVJwxrZfCt2NtZ95bXISIY6to9rtV0lTgwovd30CrpZ0F2tgbkvDhbzCAGChvfuLB+2p4dHloLUK2Zcyx7b/SDY/bgfLnx0PobcEIYqLOLBuNAULFCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:20::21) by SH0PR01MB0859.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:23::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.32; Thu, 11 Jan
 2024 02:32:09 +0000
Received: from SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn
 ([fe80::e255:98f3:ba27:8c7d]) by
 SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn ([fe80::e255:98f3:ba27:8c7d%3])
 with mapi id 15.20.7135.033; Thu, 11 Jan 2024 02:32:09 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	Jack Zhu <jack.zhu@starfivetech.com>,
	Changhuang Liang <changhuang.liang@starfivetech.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v1 0/2] Add JH8100 external interrupt controller support
Date: Wed, 10 Jan 2024 18:31:59 -0800
Message-Id: <20240111023201.6187-1-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0025.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:2::22) To SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:20::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SH0PR01MB0667:EE_|SH0PR01MB0859:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cd8a5dc-d2db-493d-e1d6-08dc124d82c7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eKdvUjpHizSTffBK5H72o4nnOevacbsp271U06qpkZ8lu6z+yP1DEnk25XcPV2LivvXN1/mwf4IWRAYLTubjKkWAGvNodUJzysLFk7y1m6maYiOv4WTPrrrF/hZtabtozo6xkyW7YNdcsRaWuuYzMVEkQtKF4L4qXRyEuGhgAgCf0NIdUz/7b425EaXq4VdbB/Bz3fOdHtmTb/dprY2wZgR1an4qWJlNMBPfREqa6gIm4lWTnJhlH//j2bv16IXHzq4V6wWUm307+phEYyskWyLweTkYDzenJsQwv9gXX0Y+KtqEe3o6MR/En2hLedxdYEEs1pPLcWEU4bVvZwPNH/AXnOIN/W7vdsvRv5g1vr2tB/jOV1S9fGy6dQE1+LRjnLRWQf4ZO85pab/tb7EN9RqjqHVTFpBQtNK7Af2lAOp3BwHloJcic21FwFFbkG5vEEWZjMJ1lSjMNLsbZ8sZw4sokRnZ2cVaD6tABUc1X2v1wA+5RFU2KtqrIXPLwvk/xS9k3NhULot/WL+LyiPC9ZicvmbJXfSaGvbLzbdlf8l0WLBgdJouZ7qe9mKpcf5j4JI5FBizJKL17dwQjNNKvNhZf9ntkojJt5b99rDwPRQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(396003)(39830400003)(230922051799003)(230173577357003)(230273577357003)(451199024)(1800799012)(64100799003)(186009)(1076003)(38100700002)(40160700002)(36756003)(38350700005)(86362001)(2616005)(6666004)(66476007)(66946007)(54906003)(52116002)(508600001)(110136005)(66556008)(26005)(40180700001)(41300700001)(2906002)(4326008)(4744005)(8676002)(5660300002)(44832011)(41320700001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6ErEREc9ooa027VZ2jJGvderyO3eA1ygc8jj8EhxzIm0L8YfoNlvP6Kkj6xg?=
 =?us-ascii?Q?KSnrzPvy11T6+YXcCrKg9RSFry+yUfwHTZmX/rk9WTWr3FezklHSjTnOkC7M?=
 =?us-ascii?Q?sbuDtXI0aP+yPG9SxgSTHLFQAOheCiQXGjQ33itOt4BKn5Pp0MoJBpUqdpXg?=
 =?us-ascii?Q?4jomU7UvvZ2ijXtNqWfcICQkAg2gW4+PKcJaRcyp8MvzjHwigrLPYLPUDxZp?=
 =?us-ascii?Q?/pAOfyZPtMN7MYKyPIQU1YzPTu+ZO4NXbS4Fj+7/J8MoLF+CSPLUWatoCZFO?=
 =?us-ascii?Q?MgoFdgbhcMChbWj2oLpUIRNJScJXkcBWkIIQb5P+lm9fMvNGnCmzuO8Tc20u?=
 =?us-ascii?Q?k6SuXY9t64zV0+I9KyTuWav6UpyNrQcbdFHA3YxlHKNutznK7jgtWKI5u4ot?=
 =?us-ascii?Q?AOalG8mMiN57t/BYWi9ZUxxhZs2xoJtLqB7sbTA62gChvlBOUtKBPrBBDqqU?=
 =?us-ascii?Q?A3SQ891SzZbcx69yFRm8JdcFrSZXOuUYJ+ei4z/b4Wfqlidip9Nacp6MtZXq?=
 =?us-ascii?Q?92kpFS8oW7/UO9wIVKTZ8uCGk/HzgJSRdQJnuTjODvcLbSNoiiTl/7k2nSte?=
 =?us-ascii?Q?+N85LltCctq/E6X+PqHRh3J7m59OwIPdjAGwL174bMpVS09jhVapeevd/zCv?=
 =?us-ascii?Q?5lwVhbO+IgpUwa+Z3CS1O01qKB/k5VHpBsQUDUbnoK6JqhJrKVROYvGZm4nV?=
 =?us-ascii?Q?3mgEL/HU2vqNx8gKZcQlLI9aeMAkgZjfobUT4Db7NWvPXo3MJ9Q4HSpfgn8F?=
 =?us-ascii?Q?1og50cuYrQsIeAT2okDn9Z2J41eMdUd5DFhoDclH7QUmLmGgwTyp2q9TJcUK?=
 =?us-ascii?Q?1o5W6XrqNHry0O2nC3BLkW2yFveYqceVSvf+8b0HFaL9wtDB0ENaqc8ufXXe?=
 =?us-ascii?Q?BRqkHtf5+XadX9Np8bvuZoPQr8Q0wcmoF3s5994qa5WxrlIpZykLw6bWPzbP?=
 =?us-ascii?Q?C8BMhhtiqgVibdgDeM16sIhh3uOB/Mo0HTx7Mitc/XZyOhIoGsTQ0caaUzvG?=
 =?us-ascii?Q?5Tv4xFqpHTzJ3w8Iwu+ttDZbWMMzjDr0u8jwt1Hdz9bQsNxsxurqpuY4vUaj?=
 =?us-ascii?Q?33AtPut5K5EVQi9EVpj+0A4USOM6SkhmTf5Fr/bwIQouzFcYWouVG4aHXItG?=
 =?us-ascii?Q?e/5GatmapCitG0CRrmTvmv+Ds5TKgfF39iCsQ5Fs2aCblbgGSbcoW1EINWux?=
 =?us-ascii?Q?2yz3JrTprFajWa0QAQa6h8KJdfdmDyOnHKpzxtWk2eG9rm/O1fiK0fCl1Fw3?=
 =?us-ascii?Q?7gg5cXNQUvnjGgxaOutbnqLZDaVbEHZ9uMNyEBWButO5ts+5z1HWhRa6pSSn?=
 =?us-ascii?Q?5yS/jY1iLhhlDjjFR5gwOKhi9mFtmbkS8w9SmSf8wfb+oWlrnsizf/S41n+q?=
 =?us-ascii?Q?i/87xxU7H+pCAbmwyY2yvYYKlXjZTFdEYPli9NWPIlA7tD8lnHPNOrsXKF3P?=
 =?us-ascii?Q?feRvQoqPLBiAe5L7WYUurqusi3ladLvW1sg8KzLqkvfD64IlBLbF8HQFIPnF?=
 =?us-ascii?Q?UyiWa0a2zZfcgxb97F1UKVjLaRcmeag+SXRr6xTi8e8aQco0kIruI2DmLW4u?=
 =?us-ascii?Q?1LySsQD0SE6ndPEs1V0m1bXY5VNUD93DTsv856//KUYJG/2bRVWnU+8H0uci?=
 =?us-ascii?Q?qZZY+GJr03MlaxUBxZ1YFvQ=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cd8a5dc-d2db-493d-e1d6-08dc124d82c7
X-MS-Exchange-CrossTenant-AuthSource: SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 02:32:09.7228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: py9KwMJ0q5ugcIqjttsobqDubLiyQMoOcdO7nry3k4mZiNXoDd/zZBYgRo2IrbkYKEUwNp4MvGXLjv3OwQLYDwiy7XI0dV8F9LFf+871z+b6iuBLmDSQXRm2bGp+QnBl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SH0PR01MB0859

This patchset adds external interrupt controller driver for the StarFive
JH81000 SoC. It can be used to handle high-level input interrupt signals.
It also send the output interrupt signal to RISC-V PLIC.

Changhuang Liang (2):
  dt-bindings: interrupt-controller: Add starfive,jh8100-intc
  irqchip: Add StarFive external interrupt controller

 .../starfive,jh8100-intc.yaml                 |  61 ++++++
 MAINTAINERS                                   |   6 +
 drivers/irqchip/Kconfig                       |  11 ++
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-starfive-jh8100-intc.c    | 180 ++++++++++++++++++
 5 files changed, 259 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/starfive,jh8100-intc.yaml
 create mode 100644 drivers/irqchip/irq-starfive-jh8100-intc.c

--
2.25.1


Return-Path: <linux-kernel+bounces-11781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C685B81EB9E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 03:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2950283510
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 02:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A737C2119;
	Wed, 27 Dec 2023 02:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="YV9OyVYm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2014.outbound.protection.outlook.com [40.92.40.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2BA20EE;
	Wed, 27 Dec 2023 02:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e8RTO9vHlLvKIvy3aIElDYKlqoJZYySc7WKikjSRpLirp86t4dDrpTX/JUAu2XoZjHOyXQM9vw1RlenFZp8tBwiD07gi/5fPWaNhGqE5IDgRHuCB1y3PMpnPOgqVhc/U4QJdpAPmbLuZZbsqHaObCepjnYecn7JheTz/EPMwGzoYOcaJodKW+tiP2ot4u9qzy7id86uR5wDQDLj+R7VgiOe+OnvPpI3SzDtR6ET6vXtDV3iWxvahJJYRwPCwn4VBTQ1hJ5AdXhc0IyaRKYsNgUr1BSTJzbZissuW8k5znwtb7hdOOHLuqIE9vMuJH9MJwh8d3d6+DI1CKAZSRwC2sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XQNYIFHT/ZSjUd5uGGQfInJhJZ0NIgD2qlRp+fM4cuE=;
 b=mxT1CEXODC88XYUjRl9FABPFq0CWOiRIPkNbZmGWCJk5nAy6it7rVvKHcW5dg88Hg0GnBcNQtCjQpEWfkGcoA0b8CWr5TpKoyvOSAJTqImOXtFvYYfKcl1uQEhDEECQ1HY+aPHQX9NgtdJYrCb+zsTR9/M3oYsOkm3sZ++MnbbFmUEOKtVyAEA9dNxJMJ7OP8IjUrGidKLCX7RudtoiGUiVAF5KU6moUVx4QTavkbic0um56DNo71N9ANGyY9MNAFuHl753AAX/BqRggbA4i0/ZIHA2/BPFzG+M5cdBxb7ICaAv1CmwfTtUn2qmkunUI3idWX+p8ppqhij86rq1SHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQNYIFHT/ZSjUd5uGGQfInJhJZ0NIgD2qlRp+fM4cuE=;
 b=YV9OyVYmE9XLvzRUktPEuDADwQRLmT/Z+KVSkkiu0qyyyiSU9NUziCUwKqDeNM2MbWo0SreB09cmbAlVAohHvFIE4MiUxR+pWDe6bq1o/koiM7J3BpueJ3H+RAt+JvQQCq0TUkrtXuXV1rdGAP27DRRcPvkjwlSddjqY12AhPNBBvLItLkcWQjszQnSIG2wGfdVmiaNHYzR/+qKcOIBwOIk4MyfDLy7U3sUZsJ5CSh4b2hSNX14rSz3EPFMC9UjRT1qjWGnIXwS1VfSIyouLL6PQKMP+cJFPqfTlhzIUqTUBCswTEyWBn6PLtjF41aD587hTUoSL+ZvpWQbm+Hbj2Q==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by PH7PR20MB5948.namprd20.prod.outlook.com (2603:10b6:510:271::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Wed, 27 Dec
 2023 02:52:44 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::406a:664b:b8bc:1e6b]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::406a:664b:b8bc:1e6b%2]) with mapi id 15.20.7113.026; Wed, 27 Dec 2023
 02:52:44 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chao Wei <chao.wei@sophgo.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Inochi Amaoto <inochiama@outlook.com>
Cc: linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v5 0/3] riscv: sophgo: add clock support for Sophgo CV1800 SoCs
Date: Wed, 27 Dec 2023 10:52:02 +0800
Message-ID:
 <IA1PR20MB49539CDAD9A268CBF6CA184BBB9FA@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [QHCqluXM+ts8dfjtjqWldrizcAWJwGgl0OcNjwb0YDs=]
X-ClientProxiedBy: TYAPR01CA0195.jpnprd01.prod.outlook.com
 (2603:1096:404:29::15) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20231227025203.295571-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|PH7PR20MB5948:EE_
X-MS-Office365-Filtering-Correlation-Id: d1a79c63-a1e8-4d88-2f0f-08dc0686e6b8
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TXxXjXO7mYyA7haDmZWuimm9F7xz9HEmbb2N0yrgOgMshTWnnvUS1uAutPv0A4CwE0RcaPLVZ2G9soHo4AYdsoT/bA4IVwzfu66QYxp0ZlDMiENdZcxLKAqMZxbYdBt6ObcjHb8P1BUCwxgdVZ0ynJEU63hgnFTrS4Fz/pmACYLNAQ/WFuc0SltSHoZW7RBHsdXvCeX+T8l/MXI/Nq2tKK/5kf18GjCn+R0H5g+ee52Oh6aGvTD6p92ieJwSQ1AXiRS4lU96QvOjIVNch6GBxKi3xZhyma/jGnaHnP4YNij41jy4OuNDFFh7SnBykaBnSLqAt96NAvkLRtNKmkqdQ2u3dc+T9W8JeMPqZi1B5KpU7KdIDSx1hhIef/mqXd/7eKYUnBAIXI8J4pVcNThK2Bd/fLNpridpxL+Xj/TFhzMncxQZtPDXWRcKHdfywfPd/hCm7RSWy0veB4HzeRC36hW2+BRHKCBbqK1T59bvfEwxPP6ATNUL7vbeLxzQ01FzeQLXme452EnZwXIkQtN4Om5N73ekw1I8PHTUPkMQdoFgjX28SJXOIXT34XVgsztxzIfcQoyC2F1Sj01Wkypn3Lf91ELA5CVSpSAUcg7dQ2vccoN7V0y4c5BI1NkdPFKlZi7yIjBKaMq2ouwlOnpFs97E6Rlkr6aG3qV6SsNLg1U=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6hhWq8n6rdzTkwxjP3jY45gbQDmoXu3IwT+oB47vdmGGoPSKVQG3LLTujZ+Y?=
 =?us-ascii?Q?ZwxdKmeoxkK+5gz4dzm6StxV28utK0o2sn6ratswAONmOEgGLHb6zXY3BVVq?=
 =?us-ascii?Q?GYy9Mno1idALaJhym78cnMp1PaoTNuQL4a+v+5+cNmgIJTJUi9mLx+3//1/S?=
 =?us-ascii?Q?7GJcrjCN6Fuh2D5yXxV2n20vqJS96OLv6IKTR/75rPqjjnEOboeTHQenTFPr?=
 =?us-ascii?Q?YAoQWR0xD1nGz5AnA0EtkoBB+eI8tv/UckL76geMGY6pZhDJBUdght3fL0dH?=
 =?us-ascii?Q?dMPyzSr40ZSGg2EzmfxhE5TDjxYX/G+jaqvTScOuzyUJ2W8SMfTs3GF8GB7t?=
 =?us-ascii?Q?6IUIgXs4v5WuE5S4qzMAg029STVsIznuF97+aA5N5MI/YROAacM6CAHyJcwd?=
 =?us-ascii?Q?xGFjgW+WP8lpG06wM5K27PtBP5ZWmOUBB/JgK++x6DZingX01zjftvhOlAH7?=
 =?us-ascii?Q?50BDzJ4cU1pRkU4/ukSQT47kT8yd33QC22ovWEmhXVhmgpX8W8+rCVxnlRX3?=
 =?us-ascii?Q?MF8Tys9962PyaDVZlgCaSI5301xwqz8GcT3tPBXbllHd35hbW4kFjej0/T13?=
 =?us-ascii?Q?+hlDiQbM9k7lzw7XtIxRiXCovaDYtJ+BnlH0tOJrD9Vy9+/xSzA7Teg8GRFu?=
 =?us-ascii?Q?91/WHJI9WhdppKTroYBb4riLG9G+Pzo/dyFmmgRiB86/hd5oLW2ZnpohrpMy?=
 =?us-ascii?Q?9CvJ1qREvEY9KwL63RHQZLmlc3n/sTXUuLRY7AKe3ExDZEB5wW2gkXdq4j5t?=
 =?us-ascii?Q?LaBDoqZ6S5xj3gGORUNJlLNofHQTxhWAhq4+rZotbSoCOnqYyvAHOsrdT5VW?=
 =?us-ascii?Q?tlp3X1JEBtLnsBafU7FnmZmQptVtSy7ZJ0PSS7c5UeQ8Jyzus4pc7Qd7kcvq?=
 =?us-ascii?Q?ljUl7mbICwgPBmohvMRNfD2k1w9wyEmKS9Io8vPBJnBqf7PIjMZ25BZcAFW+?=
 =?us-ascii?Q?hpt/H1Q/QRZh8pebmhI71RRCaSOvueDS9nkAbB3aGVPgH1AOjk6cWytWcnff?=
 =?us-ascii?Q?MlPs02Hdbw9fcS65sDjByk79+AHSQryOoHe09LY3Za8k/GojwzBDgBdKlXxU?=
 =?us-ascii?Q?ojKokJbv5/7+Dig12QbUly/TYju4c4zIn14WC5c86CpbhvqeT31bhJyZApKa?=
 =?us-ascii?Q?9I6k7zFcJ4QAI/k6fxc6yT9IDU2gsBGktMJx8ukiOQG9a6/cFa9PKfalOYd+?=
 =?us-ascii?Q?l3d77R33u/kLVHhdNAy8BX8CcXcc/iYgb98rpJJJopOMyR0+fAQhjni/Mzc?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1a79c63-a1e8-4d88-2f0f-08dc0686e6b8
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2023 02:52:44.8573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR20MB5948

Add clock controller support for the Sophgo CV1800B and CV1812H.

This patch follow this patch series:
https://lore.kernel.org/all/IA1PR20MB495399CAF2EEECC206ADA7ABBBD5A@IA1PR20MB4953.namprd20.prod.outlook.com/

Changed from v4:
1. improve code for patch 2
2. remove the already applied bindings
https://lore.kernel.org/all/IA1PR20MB49535E448097F6FFC1218C39BB90A@IA1PR20MB4953.namprd20.prod.outlook.com/

Changed from v3:
1. improve comment of patch 3
2. cleanup the include of patch 2

Changed from v2:
1. remove clock-names from bindings.
2. remove clock-frequency node of DT from previous patch.
3. change some unused clock to bypass mode to avoid unlockable PLL.

Changed from v1:
1. fix license issues.

Inochi Amaoto (3):
  clk: sophgo: Add CV1800 series clock controller driver
  riscv: dts: sophgo: add clock generator for Sophgo CV1800 series SoC
  riscv: dts: sophgo: add uart clock for Sophgo CV1800 series SoC

 arch/riscv/boot/dts/sophgo/cv1800b.dtsi |    4 +
 arch/riscv/boot/dts/sophgo/cv1812h.dtsi |    4 +
 arch/riscv/boot/dts/sophgo/cv18xx.dtsi  |   22 +-
 drivers/clk/Kconfig                     |    1 +
 drivers/clk/Makefile                    |    1 +
 drivers/clk/sophgo/Kconfig              |   12 +
 drivers/clk/sophgo/Makefile             |    7 +
 drivers/clk/sophgo/clk-cv1800.c         | 1530 +++++++++++++++++++++++
 drivers/clk/sophgo/clk-cv1800.h         |  123 ++
 drivers/clk/sophgo/clk-cv18xx-common.c  |   66 +
 drivers/clk/sophgo/clk-cv18xx-common.h  |   81 ++
 drivers/clk/sophgo/clk-cv18xx-ip.c      |  905 ++++++++++++++
 drivers/clk/sophgo/clk-cv18xx-ip.h      |  265 ++++
 drivers/clk/sophgo/clk-cv18xx-pll.c     |  425 +++++++
 drivers/clk/sophgo/clk-cv18xx-pll.h     |  119 ++
 15 files changed, 3560 insertions(+), 5 deletions(-)
 create mode 100644 drivers/clk/sophgo/Kconfig
 create mode 100644 drivers/clk/sophgo/Makefile
 create mode 100644 drivers/clk/sophgo/clk-cv1800.c
 create mode 100644 drivers/clk/sophgo/clk-cv1800.h
 create mode 100644 drivers/clk/sophgo/clk-cv18xx-common.c
 create mode 100644 drivers/clk/sophgo/clk-cv18xx-common.h
 create mode 100644 drivers/clk/sophgo/clk-cv18xx-ip.c
 create mode 100644 drivers/clk/sophgo/clk-cv18xx-ip.h
 create mode 100644 drivers/clk/sophgo/clk-cv18xx-pll.c
 create mode 100644 drivers/clk/sophgo/clk-cv18xx-pll.h

--
2.43.0



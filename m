Return-Path: <linux-kernel+bounces-25394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E83082CFA4
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 05:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEA261C20E51
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 04:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1F71852;
	Sun, 14 Jan 2024 04:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="eA6j+gDf"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02olkn2060.outbound.protection.outlook.com [40.92.15.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADE51841;
	Sun, 14 Jan 2024 04:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FDo+cutGyHj9MND7h5DdhZOl9Sp9oNlbwvXCSqTQfASS204Uk6YGZ39bmumk/C3M/6Gionwz2LKWYg3lT6rvtXwwj9c3OZWe+m4FDFIidI5kbMcEEDOGwlBgor4KSUfLxltaWJXZ9VkojxEz47wr/Jtajf+VSHij2J7nz6lil1Q96kgM7g122Q1On5MnoUbqAvv/iHT0bUEC4a8TVxVDIVfAQw0ITouZipITyEED5jA71PMezc/8TjLIzyE1pDKL7KHuP3ocOcCYngT0BEEEJ+EC0MVAl5zUbM38xEy1fXIHPH2C6VilXpoB/vJWTrqtoT8R+SfVxRqFXcU867ZfKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z9LV8xY6m+yrPmHzl9yaQtyXezmiCEUE5ZGuPv3mjYQ=;
 b=WR/JBnjOIwHZaWUlK9dpd6KNA7YsStsBpPICwd8gzLpnKxP74iZuBxbXo6bVUKgSJz/H2pOada0eltIaoebwp5kIJexG4ITPkCvr/YMG/Co9NsnW4LD4tjm1FCJwTlQZQbTuQ7A86CLY06IjmT6ZTcKvWO/SS140oNg0BUmwD+VrAA4YnypEBgNVeaYrgwixrqkuRyhEao6hDgUjscZ4QqJS9OeczrJN8MQGBufx/hUXU1ZnPeJyulncLI1gi5SVdu3BIIazWOFDclQcsQpuyLxEfWYsaxM7U4+rpURK1936+6/W36Yq7D5Jz2/jFgMl+uSH/CbIBsxLmOynP6p1Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z9LV8xY6m+yrPmHzl9yaQtyXezmiCEUE5ZGuPv3mjYQ=;
 b=eA6j+gDfS4DGl1lbsneMYq/FiISPca3lIbcy4I1Dg7E0GjCOeiQuaAAvwpyGCW0zn833wBVfkuXKEZ3Jikd4e60npDTQhxr0bbX49WP25b39M1thNao0JvHSpWdFE7FpA6fxSez6CScFIf5yOHYt7u1/ElqOuS1ZwHiasfAr4EiqZ75yxtoIgiojVyYKPRN4lXPcRnbsBR/gAmx9ocPVW+wVgJHdPq+pSj1/roT0gQJ0a3hssNw3JCrkF4ozg76ztrlzz3QnypahoFnjhX9R4LTpwYbsucb6ddQdT09TCfdjdFeie62PMUsfHTA0lZTf0pS91NwybKr1So0jfce/Vg==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by MN2PR20MB3477.namprd20.prod.outlook.com (2603:10b6:208:265::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Sun, 14 Jan
 2024 04:16:05 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::406a:664b:b8bc:1e6b]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::406a:664b:b8bc:1e6b%2]) with mapi id 15.20.7181.020; Sun, 14 Jan 2024
 04:16:05 +0000
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
Cc: Jisheng Zhang <jszhang@kernel.org>,
	Liu Gui <kenneth.liu@sophgo.com>,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>,
	dlan@gentoo.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v6 0/4] riscv: sophgo: add clock support for Sophgo CV1800/SG2000 SoCs
Date: Sun, 14 Jan 2024 12:15:49 +0800
Message-ID:
 <IA1PR20MB4953C774D41EDF1EADB6EC18BB6D2@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [rGpn4lst4WMLBvfu9MwdM8OLQHemRgeZ6ElFrwcUYa4IzLpWJaQ++5vOMKlsgXD4]
X-ClientProxiedBy: SI1PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::6) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240114041550.641859-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|MN2PR20MB3477:EE_
X-MS-Office365-Filtering-Correlation-Id: a1d13a5f-495f-465d-dc93-08dc14b78680
X-MS-Exchange-SLBlob-MailProps:
	Om8TgR6f4EDHDmDz1kJnX51tgKpLn0gov2fc+D3OJcERD+AaFy+An/pZu+ZA11trO/TRQX0oYPRTUOApPdnd7UYbY7E+zBxU1B4Xjr7AHHzDAoi+gKPEe1O2OvB4M62TOy6HnBd2cIWa3pI05hFsl7SnuDAq3PZ1LCEVLNuqKlkYoMnAvlu0+EvgatStRNHqdlnI//FCYgws9JVHZdku/IfFR0GnyJ7nZcbbk1d6xrzHzB1K6XBinGeazw+PF7O1FSk+JkDDMVrTuRYDmATCr7AdSpH5Vh1/1yNk9FYUkyxnpUqsdpy3vIAr6kSAQWpw1h+p38rMP3v5yLukVagxr0tHsAvXY1Looj1+94NxPZ/GDbH/y3454AHAxpOo5PkGRt4A6myCv8Tiy/+Jm5r0icTnpcNnUOnsaScQ/luQ/5AYIW6tsIwgZMJINVPk9K2xvwwIZ970wyewKhmi2uRraT6spCASPJSFyLVQ2UP/RjXy7CslH6VxgJetLxAqgpkxp1ONYCoowfcExsyNWjRM8InPzvQnFtF0tCbsRNhjsO/S5C48kQLFa/GirNIPPms84xCONZAtnbyuHMrFgwBMY8lLj8GnLUW4zA4MIRRLXg356dg6PZbETYBhG3BQjtdH0IBYd9W2p59ceM6YkP1R6bGO+3CZjXUU25tMrV33meJVGLxhh/nsFsvC82ksEfJsmQOj4xE7cIeZBb3DHI6FkJ2+If6Yh1OUfix4xxT7FP4qewoyJRdxnKAAkyjeGvxEKu7uQPspMRGwTDD7p1q6qsAJ3qVsQzTrojOJHv8Bz3ZBw21+ddGl/cl0IrfoNPQMM0DwUJYK04TxeKDsLPgdZGGwaYwT5wKb
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	d+UwCN5JGRcu+CXarO/zg9JiYWARF0Ix+fIwwLRyK+WUEHhg7ItxRejEp9NZzqhcIzwJETw6CfD1JLKWGz0dkLG30mPZ7ICa9zRVAzziRIKpqZI8/B8rCh1R8ZBPqmfMsMFc3B2XuXu0kqkswxk84oC0u83ugBY/JwJPJiH0XonXNz3+A3VNVdFzVshGshDYG6pxJ/1xTbsmaQSohkaGhyTB3zw9EMCgyKzb/Pf8JFPdSp9+Nac7MTmkZ8bmxin2YrXrs2Ukxq0X1wDDbMJ/EYnF07BxjQUCnG+hbKJcGhF6g1wsn1t8+TDQ45ziKpbnk7vq2WM0g4yaxeWpleAMDEkdIjHeUEZJMAdJI6Mavfii4uEJ2DYfL4ql6V2hmS1CMLlqn2n7pJLKiF04zxLyufoRD38wqzw9etFtkKgpAUOJixgztsjW39pTZaNsoz8hiihFBOtNmv1H+rgGKV7WfkdJfYh06wv+8h6fBhkKYeX6RahGV4hZAdJ6AEfz2ceBNB8G5zqCautyh0NKFuM9Rxlfq775sa3N1WWlp35P96MyMLpAoa6SBrsBpVFs5dk1iA/yGQlIr0sqmfoHHoyMfnMtlRnT7jbjvnMafTDfd++13cm/0vFZRbCPCJhm9cQ2
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jbaDtKPbDsGGUIwR80EJb8oT88KphH0BwoupbqqjJ58mN+oen4G+k1aBv+QA?=
 =?us-ascii?Q?F5+odZ4scRlzIDVN1UqEM3fTyfy+7PmFHJ9czAICYR9TxqJxybwqOaZf8kK3?=
 =?us-ascii?Q?9RWlFHicSU4MrwmzTHD4Vbp0GoHL2XacseYgKErwOqTJRuj5S88gTQJFexQZ?=
 =?us-ascii?Q?XPHpbGExlrHkDR13u2mpg4IBrcl91gZTVvlyLUPstBlKyXfuAMLzW7e595hk?=
 =?us-ascii?Q?pLFJwcwxBFcKJjOX7deopCChM30V/ZOxt/BHoF+LHOTKzPI0L4gyRzzpQq58?=
 =?us-ascii?Q?o06SV9QVWppn73fW7FwK3jUQn60Preg9yUbGhsqN9tgTrdtfgYu9xtUBvHhi?=
 =?us-ascii?Q?DlL5rpIZUZfKgfd1w5AnJpx5UT6Bl1gPwjKZXlQdDS0ebewbxoZcEswrwznA?=
 =?us-ascii?Q?H4ScV/Lilsju1r6GH/xhqQUaWpFnrajRbA6Awhlxj2VuctGNcvwiZuD51c2R?=
 =?us-ascii?Q?OEQqcsJJodIIrcSktNhlryoHylrkEHmG4hgyZTuYHn5Kmk+7IBN6uXLz70u7?=
 =?us-ascii?Q?ojpCAdITqnQoU4HpWU+rcgZ1+gZ27jDqDHQAbEqJ+lh5gsbHC/5Uzl6F5UIu?=
 =?us-ascii?Q?4wgBpvSIS1XzRYMzaPFg4cbSeczE+m+iFOp1wslm+kNWJBJ9VVSZO9NpkYOP?=
 =?us-ascii?Q?6sd/Z9RKRi5qGongaskfOHFfiTS83V3peBdx2YC8xhwwpXimwTP1eDnE2z/F?=
 =?us-ascii?Q?QXkVqpvfuRqEWmORTgynvtZQ8iOVoP2jmi+6N2pwkBgnv9L7k12uyk5luByJ?=
 =?us-ascii?Q?3UgyicPnBjQjBhnNsKexN6XSygtcoOZFwL6m2qNXZhAlq0R3v/3zeVpSpyYv?=
 =?us-ascii?Q?UutPcmQzZLxl142WZ0xgGP5SGF1ORWsmfqtB391Toq1sCxrxJR1bCgnwdCxU?=
 =?us-ascii?Q?2jd2D90UH4rTQ6eKOBFFlcdLqAzbGVcTw9+22zfvCeCvK5UKker0EpCPV4Uv?=
 =?us-ascii?Q?fL6VM7bNexZdrmSL2a6LpmvO5ijOErqAuqcQC8gX22zwmi2JHMHR6qcQPXHB?=
 =?us-ascii?Q?97atLIXY/5TG95XgaADwVoO9F/2ONdxXVvIZxiCiwzHRHJQMLvyFi+L2vlfB?=
 =?us-ascii?Q?/+w8326x1RZ3o5yE8r4MpqFUGzOon1D1J/u5DYXJbWJrK1GuH8/yFdDbZ/xE?=
 =?us-ascii?Q?oHjL6s0waQZE9p+KpyWicCFrJl5BDlUyChoux1GY6kF2QxYNHoduMIce/LPR?=
 =?us-ascii?Q?Pyj+58XPIPA8lgowaYe5q4VBSitzIP3qPiS5UHz4ER56lYES62+w5MqN5p6A?=
 =?us-ascii?Q?dE31mu4dPcFqxozpSqcVirGGaZlp4zCZGgRBeNdwZQ=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1d13a5f-495f-465d-dc93-08dc14b78680
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2024 04:16:05.1323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR20MB3477

Add clock controller support for the Sophgo CV1800B, CV1812H and SG2000.

Changed from v5:
1. rebased to mainline master tree
2. add SG2000 clock support.
3. fix document link

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


Inochi Amaoto (4):
  dt-bindings: clock: sophgo: Add clock controller of SG2000 series SoC
  clk: sophgo: Add CV1800/SG2000 series clock controller driver
  riscv: dts: sophgo: add clock generator for Sophgo CV1800 series SoC
  riscv: dts: sophgo: add uart clock for Sophgo CV1800 series SoC

 .../bindings/clock/sophgo,cv1800-clk.yaml     |    3 +-
 arch/riscv/boot/dts/sophgo/cv1800b.dtsi       |    4 +
 arch/riscv/boot/dts/sophgo/cv1812h.dtsi       |    4 +
 arch/riscv/boot/dts/sophgo/cv18xx.dtsi        |   22 +-
 drivers/clk/Kconfig                           |    1 +
 drivers/clk/Makefile                          |    1 +
 drivers/clk/sophgo/Kconfig                    |   12 +
 drivers/clk/sophgo/Makefile                   |    7 +
 drivers/clk/sophgo/clk-cv1800.c               | 1545 +++++++++++++++++
 drivers/clk/sophgo/clk-cv1800.h               |  123 ++
 drivers/clk/sophgo/clk-cv18xx-common.c        |   66 +
 drivers/clk/sophgo/clk-cv18xx-common.h        |   81 +
 drivers/clk/sophgo/clk-cv18xx-ip.c            |  905 ++++++++++
 drivers/clk/sophgo/clk-cv18xx-ip.h            |  265 +++
 drivers/clk/sophgo/clk-cv18xx-pll.c           |  425 +++++
 drivers/clk/sophgo/clk-cv18xx-pll.h           |  119 ++
 16 files changed, 3577 insertions(+), 6 deletions(-)
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



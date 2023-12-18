Return-Path: <linux-kernel+bounces-2979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E1A81657F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 05:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D875A1C2217C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 04:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7E85399;
	Mon, 18 Dec 2023 04:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="KkPLTDgo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2076.outbound.protection.outlook.com [40.92.19.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC27B63A3;
	Mon, 18 Dec 2023 04:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bFPwkQvHpaIR1dubsEBLivNRHBAISxT1AvsQ/hG93Fcm9m21RSrnoAH1pJUlyIro+E+i8XpAxiNSZoHlH/x0HiCtPCQLE8C0ozigIzrxpM0Z3gDBFMbwz/YbrsGqSSI6YqPcAIqveB48UsitNSZ6bO76R5DEku6P9IfPQ0pkEc3mX+WnuWTviIrFqMx3NAGIglQj9JiQDRfxh8uzRv1GGyDRRhiThqD5fQv2ca3fTDt7CPgZXwHgJ9aD0NDhLeQaJbCwJMuOSONo60UqyHCusdzHtzRSrcCM4RJPJLA5vqSEcnPHpgwV43ahRSwcDZkLFXo5DrBX9qU/7QxW//0fvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U+P4L/WHsJp3x8Jh/OLM1Mxx7QRubFgj11wkXWUlymk=;
 b=j1KU8Vhk876Sw4O/z7VTGIJOOVvWjaNHU56rGpIafaFCQQm/TgOKeCUSecnMwnd1Tm8KJW6JAWyjs8c7KnH1YO40G+YF+LZKKYif0LNHmpQ1CHhMpTxqWyVEp6Fl1Ne52VPlGVJFfI2X2rIGoxGOuRwmRSQ3+6ZjjaC1iCWMhoRUQW5NufEJIF7sPQc2dbZU4mmdrTrNfWJmIjdx7WOaZrzl7TIzaTLekjS0dqIee2/HpuBsJ5e93zqkG682PBeIlmS1J9mTa1kyP01SNISPnv/Ws0uzmbvcUfrlNlq+cBFdefGhT6gtCbwR5lRTbBlluV5rdxqxoc6PAoZ+DaUeEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U+P4L/WHsJp3x8Jh/OLM1Mxx7QRubFgj11wkXWUlymk=;
 b=KkPLTDgof3EHRgypO/VHbeyfrob7bBK/rlK/RoBgsS9tLUNB5bFa9Xstnqs4Cfei+fZrYgouQujwv2NaWAPdhjcMT3RcYkEkPCrVheOcFVaTcWWe24mil3IRQMkV3WhZBbIEgfNGPRjo795lTuR/HPh/RXwvp1PzzWRXhwraN1op/CVDKsfF+ElX2iaqFmP2gmhICE1qfhnd2AYJNh9WkXih3YHgYWOum+SAS0NRet4hvKca5GF/Nbd1i8VO3YKwVb1RH0ASQcefXUSuSGlbQfLuCNKmtyJL32Up0qcrV6hteFJr9yvK/7p4VfIqHW9j9QNwSHe7h8/it3IiqjgMRw==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by BN0PR20MB3976.namprd20.prod.outlook.com (2603:10b6:408:127::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 04:03:05 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8%6]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 04:03:05 +0000
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
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>,
	dlan@gentoo.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v4 0/4] riscv: sophgo: add clock support for Sophgo CV1800 SoCs
Date: Mon, 18 Dec 2023 12:02:39 +0800
Message-ID:
 <IA1PR20MB495354167CE560FC18E28DC5BB90A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [5iN7sq26rjzr1Hne3m/Hqx809wc6HKOXD/NGU+iHzX8=]
X-ClientProxiedBy: TYAPR01CA0109.jpnprd01.prod.outlook.com
 (2603:1096:404:2a::25) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20231218040255.573954-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|BN0PR20MB3976:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c364a42-b7c1-4bb2-b73c-08dbff7e3c58
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+bDMCGfCvPTtcMMkEGzVZPWsJVwQIiCD8Jc/yO36++FpkaQRl67uDZ4216kh+IzakRGrU/96/0mUtr4CmIvAND0r/+RqUBS6RkNx6vdSnxl5Tb0qMyo9NRe8E/ylXaqElCySljW9FpjBdlMdseXcXv6FVBbYZPmufZ8hG+NqFTztR1mcMq+ZonYkqYRHnOX5xWW44T9f0Tpvb3k6CCPSAJ20t+YlI2VXGbxsfdbLKvZK5fI+tk2ystqwZIqTozrSVY/vWoZx6P/UwL9PCdzd1O00ajpSzotWW/A5PsotmZOsSfKd1CI+flMtlbdxmI44w1ItBAJK5cOj96i3utziDh0fJk0ZiolQCv/POYaYSW3lhJ21QisM3F1cGQP+47KOfH87sC26GOvs6QIpDTPP36Knef6UL/SglEaXTymkohvFkzDx3JvIhm1XkY2YRtoZwhbb7gB6kkrR5dR4uLM78cRU6wM0b41tZLAKFUiKfuZs5d8PLueiytXu0FdNJSlBd+LOhxqJKSesbwbffLikVAMcmk8+u4SLJuIw3yMGp9v76VraciC+mLY89ldRiP0IwMBY5ba0PE+r7R0pJlRsBmHNc7logiD1Law17C3KHKawINAnNYFjAJcYgUsMDaZ4
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2X0uKM5JE4sMLlRvm+VJ+iuZsG1ELoeyPe0zMHfsczRi84Jdk1X2oc6vbIRd?=
 =?us-ascii?Q?DoWtqf/TsQD4Hb84oSCaif7hu9QRPFoG7OdNzt4THDD8mpvBrBRf+34fVJzt?=
 =?us-ascii?Q?YVShjW98j1X7goDEyyvG/liw6kUA7naeGzy2XlbUDYQ9n2sR99G0nt/mkp+3?=
 =?us-ascii?Q?xjnuVgL4nXaabUdBgRGluY9SDNtwAwSruI2+TLFA40Ij6zcBRHcuO8yHFwGy?=
 =?us-ascii?Q?KdrxmMdFO1zZpzOm9iDRFRRa1jddmeCLb+7Ty5eAXmoHbZbsqKJtFZk891yR?=
 =?us-ascii?Q?ozQYm/55Nkj9i/Yd97VGrUCTd2fbKbSQx0kCqOMhSFBd9yyGSE726EnWbk+Q?=
 =?us-ascii?Q?tQYfJbKvyb42HKQVyz3/SyX9tRFdxXsd8XpPFlT+3oBGHe1M1Ioky74l6D4f?=
 =?us-ascii?Q?y1FTOpdWhxr6ScqINkWo1Nym543GWrAeMb8WzcEecr6y0u08tv+W5P1EuhZ9?=
 =?us-ascii?Q?yvkt/CTIJcRArBXnmrktnZx6jph8r4zVORMBUVN7f5PlZAqILjj00izfgxX4?=
 =?us-ascii?Q?0Zs7fckJ/esEhgxIUtO1Nyrlu5PoIhIZKkyVriMZv5IKNjlYjoX0PVpGikNr?=
 =?us-ascii?Q?ydq5GpvPQmptGuvOZPHWeSSSusvucyVfRaDInQ8pmIXitZbaLPg2rJA7A15E?=
 =?us-ascii?Q?B9wJ+0tJxjD44EHocqvGVpKGzeiBGoyrgzr/8OUDORy/06CUsVUTo1BqmYgh?=
 =?us-ascii?Q?Z+AKmV6jTkH731tfsDPsWPMQtjkJGzj8f4r0l8AeNL/Z/4aOBu60MMpunx1x?=
 =?us-ascii?Q?uZ0Dn/BBHE7dvxt69eAIhfgMvxqdJm3xwEKFs3p0wtQ976VvnnPnHTMHbsU4?=
 =?us-ascii?Q?j6FEsy/xSvycIWHNCNKv6c0Omfl/mIkSQpMvnldGEBf2wgqacYamrEW3aNs9?=
 =?us-ascii?Q?hvs4tdVPMr+nEIusZEiW6as1Bn7Ip2xWNPw5WXuR7Oh6NZnZdUkZhP9P+Phw?=
 =?us-ascii?Q?Vp7wNMPWdabItKTtMvfC6aS3tF8p6qJB7tHPQM0Nx88t8qFwDPzp9xtbOj8A?=
 =?us-ascii?Q?rm2ooQFjaaByi2lBaSkgsx5Coi0x+8RuVmX/T9/5iwoewPRtX+KZdvR5Mdys?=
 =?us-ascii?Q?+bh++VwFhMpo47urld6ggdwD3F+TdcqhwDGD+I+Q7jaKHzIhrrT+Uyt/wV4A?=
 =?us-ascii?Q?aCDAOr7zss6aMVjfWKjEMhMDi5Yua0OUEbgIclXkbkt/dbyEfUzRjTYOKBQM?=
 =?us-ascii?Q?z9LQRAviu8FHOpjPWG23t9p3lPdpSkNXPLxseT0bAYSpUoZvETzraA6E9fo?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c364a42-b7c1-4bb2-b73c-08dbff7e3c58
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 04:03:04.8789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR20MB3976

Add clock controller support for the Sophgo CV1800B and CV1812H.

This patch follow this patch series:
https://lore.kernel.org/all/IA1PR20MB495399CAF2EEECC206ADA7ABBBD5A@IA1PR20MB4953.namprd20.prod.outlook.com/

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
  dt-bindings: clock: sophgo: Add clock controller of CV1800 series SoC
  clk: sophgo: Add CV1800 series clock controller driver
  riscv: dts: sophgo: add clock generator for Sophgo CV1800 series SoC
  riscv: dts: sophgo: add uart clock for Sophgo CV1800 series SoC

 .../bindings/clock/sophgo,cv1800-clk.yaml     |   46 +
 arch/riscv/boot/dts/sophgo/cv1800b.dtsi       |    4 +
 arch/riscv/boot/dts/sophgo/cv1812h.dtsi       |    4 +
 arch/riscv/boot/dts/sophgo/cv18xx.dtsi        |   22 +-
 drivers/clk/Kconfig                           |    1 +
 drivers/clk/Makefile                          |    1 +
 drivers/clk/sophgo/Kconfig                    |   12 +
 drivers/clk/sophgo/Makefile                   |    7 +
 drivers/clk/sophgo/clk-cv1800.c               | 1565 +++++++++++++++++
 drivers/clk/sophgo/clk-cv1800.h               |  123 ++
 drivers/clk/sophgo/clk-cv18xx-common.c        |   75 +
 drivers/clk/sophgo/clk-cv18xx-common.h        |   85 +
 drivers/clk/sophgo/clk-cv18xx-ip.c            |  893 ++++++++++
 drivers/clk/sophgo/clk-cv18xx-ip.h            |  265 +++
 drivers/clk/sophgo/clk-cv18xx-pll.c           |  464 +++++
 drivers/clk/sophgo/clk-cv18xx-pll.h           |   78 +
 include/dt-bindings/clock/sophgo,cv1800.h     |  176 ++
 17 files changed, 3816 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/sophgo,cv1800-clk.yaml
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
 create mode 100644 include/dt-bindings/clock/sophgo,cv1800.h

--
2.43.0



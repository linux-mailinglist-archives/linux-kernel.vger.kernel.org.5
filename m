Return-Path: <linux-kernel+bounces-19654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB9A827060
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 14:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CAFEB22388
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C034595E;
	Mon,  8 Jan 2024 13:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nuvoton.onmicrosoft.com header.i=@nuvoton.onmicrosoft.com header.b="vF/VpPeh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2085.outbound.protection.outlook.com [40.107.255.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BEB45BE2;
	Mon,  8 Jan 2024 13:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuvoton.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cpuZPh/VEjOIFeHu9nqnk9vs5Dtwb0hYfgCapXdP2alVZbzrKES4EilkXzTOs+A1DglkDARezebwsPusZ6iDxmH4f2A8UdVSshci3n4yQuRsmqphEcM92WQpYFU7QILsiF7jFo2JiL2IUQ1jhb7XabvAY6/BsjnsMMGiksY6Bjm56GQtVbpxUR37uGB2e6GlviLokygqZIVH54LTA4QT4wzioiQIU2n+besr3q/yJaYI71Njv7Y+UIDxfGt+8mOoS19rsLv35nANcyUZdsx9Vh0xgkzrbuWCpEopuJSpn6bXGrppKZFTbxQLK+fI20Ih03yBM2hG+x1ONOHtsbEuRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ptIFbG2C2GApepsr4NAZlobdsnS5QR5bCkE9PiYHtuw=;
 b=KjPpmCDs2YwH4kPwry+5E42Un1cGqCZRuGTSKuCd9QCRKlOb4kWhO8T/wwoB53vT86pTADfUSMDCJ6qxYgrhX7FeladAss0jtWJnSFoF5e1/vQGy2/Z18IZWzjulKNqztHnCsRswJqnQVRXfWUBJq92aYiFkvKgjPzNOZSlxJvNWu8weKu+q2fZcCFK0izRb5pVBLhxyoeKfVRAYniIzt7VDTHqYoj9i0rWBqZLZ1ftq8/pJMpxcL6/kaKC+sn2caPRTsCeaF0w7HCEZWUSNPwN6KlhaWUpruip0RH/wrC0Dc+B1eWl4+U0EeIj69W7x7LsvadmXjj0SnJ/S7LGyUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 211.75.126.7) smtp.rcpttodomain=baylibre.com
 smtp.mailfrom=taln60.nuvoton.co.il; dmarc=fail (p=none sp=quarantine pct=100)
 action=none header.from=gmail.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ptIFbG2C2GApepsr4NAZlobdsnS5QR5bCkE9PiYHtuw=;
 b=vF/VpPehbV6bcgRIoeCR6//VONDwwA1l+oifn1mEZn5XbBCsa+ve49vYOqz8SWXHQ8WLK0q3BkH7Sy89Ispfn3kIU72kFhZZumEEUL25g55CiCqTRsT7slx0NyBmt/N5qNYIkET7PDWAVSjzzyeiB6CjFBNB1MhVPbc7VDR5Pig=
Received: from PS2PR02CA0074.apcprd02.prod.outlook.com (2603:1096:300:5c::14)
 by KL1PR03MB5780.apcprd03.prod.outlook.com (2603:1096:820:71::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 13:54:26 +0000
Received: from HK2PEPF00006FB5.apcprd02.prod.outlook.com
 (2603:1096:300:5c:cafe::39) by PS2PR02CA0074.outlook.office365.com
 (2603:1096:300:5c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21 via Frontend
 Transport; Mon, 8 Jan 2024 13:54:26 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 211.75.126.7) smtp.mailfrom=taln60.nuvoton.co.il; dkim=none (message not
 signed) header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of taln60.nuvoton.co.il: DNS Timeout)
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 HK2PEPF00006FB5.mail.protection.outlook.com (10.167.8.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.12 via Frontend Transport; Mon, 8 Jan 2024 13:54:24 +0000
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 8 Jan
 2024 21:54:24 +0800
Received: from taln58.nuvoton.co.il (10.191.1.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 8 Jan 2024 21:54:24 +0800
Received: from taln60.nuvoton.co.il (taln60 [10.191.1.180])
	by taln58.nuvoton.co.il (Postfix) with ESMTP id 6E51D5F5D2;
	Mon,  8 Jan 2024 15:54:23 +0200 (IST)
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
	id 65106DC0047; Mon,  8 Jan 2024 15:54:23 +0200 (IST)
From: Tomer Maimon <tmaimon77@gmail.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <tali.perry1@gmail.com>,
	<joel@jms.id.au>, <venture@google.com>, <yuenn@google.com>,
	<benjaminfair@google.com>
CC: <openbmc@lists.ozlabs.org>, <linux-clk@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, Tomer Maimon
	<tmaimon77@gmail.com>
Subject: [PATCH v22 0/8] Introduce Nuvoton Arbel NPCM8XX BMC SoC
Date: Mon, 8 Jan 2024 15:54:13 +0200
Message-ID: <20240108135421.684263-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB5:EE_|KL1PR03MB5780:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f145de4-a5df-4e90-a407-08dc105152d9
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/Neu2iX7Jl0y15N69bLpmvc9B3gdVs2nlNrXEj21MQotlbwsSTy50zF93vaSfnn/z7BRt6vOj8V815aLeH6ySZW/TIpeAnGuy4oPlyPpB2m2BcTm0/UBLilTXMkzUU4HxaeR2CSWAiRibJtg2oDmcPzou4ryG0FoFyrQWTM8P9NX2WPOdACPeBbPb3s8Xu5H5BtGUsvnSwToTpFla//pCeVrbwLTO9E/Z4OK2CDAT4C8Oi7u+wMH/Yj7q/r9Rop4012ewZdAuVEf1Ovk1AvgnRxfS64/hT/BZLM2yaH26vOpI/mYKhOmy2EvG5d85/x3ncm0odjcNsg4k6KRmCD2MC+L2aVqg+wD5umDl2k7m9eXKKLJh+Yg9YDiQnqzaMAxkMRcJOgeABqb9IcdY+h65Gu5awFLatHh20+7Vxq2MJ7OYKsgjmqTd24vRRBqqIFwMMdfCTfgKp8c7YMay0Dz9aUaHHL98rRvsgczHnt5iye3rD9oXhaCm/3L916y7vb2HSq8XywUjdSzNqnKUy8mAlm5au2qRyLDNxw8DHz/wSxOusQkfkaT+s8NmbwYnB4Q85/vdKY4PAOqlrdJMwUsThBoxs+UvTZ5z0vlA8i74h5QGjELDm6HMgKS3BRadn7RvWZqZ4drOhBu9+Kz6Nyw0yj0PV1SplZo+2HaenVUdFH1Q7dVJ19oysxhc0OuO/Ic0rz4clxKkGRjnozF49XBOrI1LjoEaWECjXCePB6B7ueg2nkEO8tqUqwg5aQCF+7BNMEzrrYMg9WTMjw4BNiEthVMq46NjrxEfkByDO0dxXnQ0RetRK+yx4hJivwk2rRXAkishUNooTcohk+X7PIS/0yLZqPp92t5+Zn3L4NVI5VOIKQLZc4FWYDi/EP30REgThTrht4fbroNDaGqLmRJyg==
X-Forefront-Antispam-Report:
	CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(396003)(39860400002)(136003)(230173577357003)(230922051799003)(230273577357003)(61400799012)(64100799003)(451199024)(48200799006)(82310400011)(46966006)(40470700004)(40460700003)(40480700001)(336012)(73392003)(42882007)(63350400001)(966005)(6266002)(498600001)(4326008)(83380400001)(7416002)(5660300002)(8676002)(70206006)(8936002)(6666004)(70586007)(76482006)(1076003)(2616005)(82202003)(26005)(82740400003)(2906002)(81166007)(54906003)(36756003)(83170400001)(356005)(110136005)(316002)(42186006)(35950700001)(55446002)(47076005)(41300700001)(45356006)(32563001)(35450700002);DIR:OUT;SFP:1101;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 13:54:24.7689
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f145de4-a5df-4e90-a407-08dc105152d9
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB5.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB5780

This patchset adds clock support for the Nuvoton 
Arbel NPCM8XX Board Management controller (BMC) SoC family.

This patchset cover letter is based from the initial support for NPCM8xx BMC to
keep tracking the version history.

all the other initial support patches had been applied to Linux kernel 6.0.

This patchset was tested on the Arbel NPCM8XX evaluation board.

Addressed comments from:
 - Stephen Boyd: https://www.spinics.net/lists/linux-clk/msg93838.html

Changes since version 21:
 - Since using regmap instead of ioremap replace reg to syscon 
   property in dt-bindings and dts.
 - Add reference clock property to the dt-bindings and dts.
 - Using .index instead of .name in clk_parent_data structures.
 - Using string where any macros are used once.

Changes since version 20:
 - Using regmap instead of ioremap.
   the clock and reset modules are sharing the same memory region 
   and cause failure when using devm_platform_ioremap_resource
   function, this version uses regmap to handle shared 
   reset and clock memory region, in case it is approved I will
   modify the reset driver to use the regmap as well.
 - Using clk_hw instead of clk_parent_data structre.
 - Divider clock definition to one line

Changes since version 19:
 - Remove unnecessary free command.
 - Defining pr_fmt().
 - Using dev_err_probe.
 - Return zero in the end of the probe function.

Changes since version 18:
 - NPCM8XX clock driver did not changed from version 18 only build and tested under kernel 6.6-rc1.

Changes since version 17:
 - NPCM8XX clock driver did not changed from version 17 only build and tested under kernel 6.5-rc3.

Changes since version 16:
 - NPCM8XX clock driver
	- Using devm_kzalloc instead kzalloc.
	- Remove unnecessary parenthesis.
	- Modify incorrect spelling.

Changes since version 15:
 - NPCM8XX clock driver
	- Remove unused regs parameter from npcm8xx_pll_data structure.
	- Using index and clk_hw parameters to set the clock parent in the clock structures.

Changes since version 14:
 - NPCM8XX clock driver
	- Remove unnecessary register definitions.
	- Remove the internal reference clock, instead use the external DT reference clock.
	- rearrange the driver.
	- using .names parameter in DT to define clock (refclk).

Changes since version 13:
 - NPCM8XX clock driver
	- Remove unnecessary definitions and add module.h define
	- Use in clk_parent_data struct.fw_name and .name.
	- Add module_exit function.
	- Add const to divider clock names.
	- Add MODULE_DESCRIPTION and MODULE_LICENSE

Changes since version 12:
 - NPCM8XX clock driver
	- Use clk_parent_data in mux and div clock structure.
	- Add const to mux tables.
	- Using devm_clk_hw_register_fixed_rate function.
	- use only .name clk_parent_data instead .name and .fw_name.
	- Modify mask values in mux clocks. 

Changes since version 11:
 - NPCM8XX clock driver
	- Modify Kconfig help.
	- Modify loop variable to unsigned int.

Changes since version 11:
 - NPCM8XX clock driver
	- Modify Kconfig help.
	- Modify loop variable to unsigned int.

Changes since version 10:
 - NPCM8XX clock driver
	- Fix const warning.

Changes since version 9:
 - NPCM8XX clock driver
	- Move configuration place.
	- Using clk_parent_data instead of parent_name
	- using devm_ioremap instead of ioremap. deeply sorry, I know we had
	 a long discussion on what should the driver use, from other examples 
	 (also in other clock drivers) I see the combination of 
	 platform_get_resource and devm_ioremap are commonly used and it answer
	 the reset and clock needs.

Changes since version 8:
 - NPCM8XX clock driver
	- Move configuration place.
	- Add space before and aftre '{' '}'.
	- Handle devm_of_clk_add_hw_provider function error.

Changes since version 7:
 - NPCM8XX clock driver
	- The clock and reset registers using the same memory region, 
	  due to it the clock driver should claim the ioremap directly 
	  without checking the memory region.

Changes since version 5:
 - NPCM8XX clock driver
	- Remove refclk if devm_of_clk_add_hw_provider function failed.

Changes since version 4:
 - NPCM8XX clock driver
	- Use the same quote in the dt-binding file.

Changes since version 3:
 - NPCM8XX clock driver
	- Rename NPCM8xx clock dt-binding header file.
	- Remove unused structures.
	- Improve Handling the clocks registration.

Changes since version 2:
 - NPCM8XX clock driver
	- Add debug new line.
	- Add 25M fixed rate clock.
	- Remove unused clocks and clock name from dt-binding.

Changes since version 1:
 - NPCM8XX clock driver
	- Modify dt-binding.
	- Remove unsed definition and include.
	- Include alphabetically.
	- Use clock devm.


Tomer Maimon (8):
  dt-bindings: clock: npcm845: Add reference 25m clock  property
  arm64: dts: nuvoton: npcm8xx: add refernace clock
  arm: dts: nuvoton: npcm7xx: modify rst syscon node
  dt-bindings: soc: nuvoton: add binding for clock and reset registers
  arm64: dts: nuvoton: npcm8xx: add clock reset syscon node
  dt-bindings: clock: npcm845: replace reg with syscon property
  arm64: dts: nuvoton: npcm8xx: replace reg with syscon property
  clk: npcm8xx: add clock controller

 .../bindings/clock/nuvoton,npcm845-clk.yaml   |  38 +-
 .../soc/nuvoton/nuvoton,npcm-clk-rst.yaml     |  40 ++
 .../dts/nuvoton/nuvoton-common-npcm7xx.dtsi   |   4 +-
 .../dts/nuvoton/nuvoton-common-npcm8xx.dtsi   |  19 +-
 .../boot/dts/nuvoton/nuvoton-npcm845-evb.dts  |   6 +
 drivers/clk/clk-npcm8xx.c                     | 510 ++++++++++++++++++
 6 files changed, 597 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/nuvoton/nuvoton,npcm-clk-rst.yaml
 create mode 100644 drivers/clk/clk-npcm8xx.c

-- 
2.34.1



Return-Path: <linux-kernel+bounces-47285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA98844B79
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9C781C29058
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69EF63A8C5;
	Wed, 31 Jan 2024 23:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nuvoton.onmicrosoft.com header.i=@nuvoton.onmicrosoft.com header.b="QpMSWLOs"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01rlnn2071.outbound.protection.outlook.com [40.95.110.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13973A278;
	Wed, 31 Jan 2024 23:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.95.110.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706742077; cv=fail; b=n3uS/njCo8I7lw8ZZH5d388CEk1g2FRdbgj9REA5r3mHSrzzpZ4N29wFQIMbo8cppTtU5Qfc7qo3ESU+ODVmoWjoyYNMV8FdLK7zELeOs7uMa5q+ZMVO3puXEpFRrJIiUSgdngZDpQOaDKvUGq7q2dB4/0/uSxoLtiLiEj28NxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706742077; c=relaxed/simple;
	bh=HOIk5hOyCVFgOSj4e6/gfavrpPbVrh75/J9NSBoyED4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bPPltNrbrV8EtpAuB5tEURFVx+Q3WejjNDSezN2yEy1/8Fmpi2vMAdJYbFHssIWv++Pw6rrkag3miiuNIjsUmBRaBKIL/9U+Nt0FDmUcFWHmaG7xPRLows++Zz8PLFLXFF4tl9+4xtdq99BiRKFlJg+QojZJHw0rD96JvjzV0nI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=none smtp.mailfrom=taln60.nuvoton.co.il; dkim=pass (1024-bit key) header.d=nuvoton.onmicrosoft.com header.i=@nuvoton.onmicrosoft.com header.b=QpMSWLOs; arc=fail smtp.client-ip=40.95.110.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=taln60.nuvoton.co.il
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dlCT5+TU0R8VDaSXvDJszf02MouMXYi1s61TsuXMYCsqj/b79+lNjfm6Y5fmoL1ixQYSliSvBYi/0f3qkromOW5GpPaV/YuKhR3yc1tCxZEbtwWvkZ4f1J5JoA8rctPGDaksDCu719H7jB9hoXtAGMLZnEhCi8UfyN/woSsVHNKQsGjBJsfzCk7TgtEgp86WOaOod3WNrfDtNv8hi49sAYLaNkRQxke/fEc8KSLHTSK67PbaOhhoz11OjZwRJtu3jcSWAyodQ5ps70rXrYUxhL9KaPmZETQcKlBpERmtftiqw72C6vQwLVf0oTbfWNVh3irT+icYoNGxVOWacy7MnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fcf7HEaWwTnjxtqPtzrQ0yutuH/a9ktuQHkZWeTUwno=;
 b=DAOsqPtsi1Caq0utXC1WoWj9WIVzT+y6KsCDauZyc/TDEBtqeVSN5LXrAN3o9kkvOiyqpPPjn2F/BPuOzU0Xh+pYn0Q5uzkUwGWjL8uyhT363aVYz3gJ0OBiRzXPP86gE33I7Uqxc7AtPVS9iNW50OA0rR/S3bAtoohJQ2+pSqJKdyKmiy09REUYTVpJe+W193LwzZoECOjhVUwbMJzZkWjuAQ95/DswV7rvS+Z/ZVvDRf0nmi52QlxmHgy2tX4ZZaVVb7nujKNG0Ekbq5BcSoxelZiCsfX8BWW3MQWqvgFNEZJ4LNy83lX3rCM/WxorlZ6K/hwUTU7ygsD8XGSa8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 175.98.123.7) smtp.rcpttodomain=baylibre.com
 smtp.mailfrom=taln60.nuvoton.co.il; dmarc=fail (p=none sp=quarantine pct=100)
 action=none header.from=gmail.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcf7HEaWwTnjxtqPtzrQ0yutuH/a9ktuQHkZWeTUwno=;
 b=QpMSWLOscg+oe1nnuVc9/6Kuh4PWfvnZATRReXbb9L9+u9yVlMf13cj4UViGSvYwg/8Q3pN7DF/XMJtwrJY2fiOrWUunEnCOl+lfArTBSofmgXf19qR11ajnho6NvfJ/ER2u3vPjZ240RNAFOgDPzjZlUXBRgv5QRy6sQg8Ijw0=
Received: from PU1PR06CA0009.apcprd06.prod.outlook.com (2603:1096:803:2a::21)
 by KL1PR03MB7872.apcprd03.prod.outlook.com (2603:1096:820:ef::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23; Wed, 31 Jan
 2024 18:27:11 +0000
Received: from HK2PEPF00006FB0.apcprd02.prod.outlook.com
 (2603:1096:803:2a:cafe::3e) by PU1PR06CA0009.outlook.office365.com
 (2603:1096:803:2a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.26 via Frontend
 Transport; Wed, 31 Jan 2024 18:27:11 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 175.98.123.7)
 smtp.mailfrom=taln60.nuvoton.co.il; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: None (protection.outlook.com: taln60.nuvoton.co.il does not
 designate permitted sender hosts)
Received: from NTHCCAS04.nuvoton.com (175.98.123.7) by
 HK2PEPF00006FB0.mail.protection.outlook.com (10.167.8.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.7181.14 via Frontend Transport; Wed, 31 Jan 2024 18:27:09 +0000
Received: from NTHCML01B.nuvoton.com (10.1.8.178) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.14; Thu, 1
 Feb 2024 02:27:07 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCML01B.nuvoton.com
 (10.1.8.178) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Thu, 1 Feb
 2024 02:27:07 +0800
Received: from taln58.nuvoton.co.il (10.191.1.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 1 Feb 2024 02:27:07 +0800
Received: from taln60.nuvoton.co.il (taln60 [10.191.1.180])
	by taln58.nuvoton.co.il (Postfix) with ESMTP id 9AA2B5F612;
	Wed, 31 Jan 2024 20:27:06 +0200 (IST)
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
	id 79F9ADC08DB; Wed, 31 Jan 2024 20:27:06 +0200 (IST)
From: Tomer Maimon <tmaimon77@gmail.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <tali.perry1@gmail.com>,
	<joel@jms.id.au>, <venture@google.com>, <yuenn@google.com>,
	<benjaminfair@google.com>
CC: <openbmc@lists.ozlabs.org>, <linux-clk@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, Tomer Maimon
	<tmaimon77@gmail.com>
Subject: [PATCH v23 0/3] Introduce Nuvoton Arbel NPCM8XX BMC SoC
Date: Wed, 31 Jan 2024 20:26:50 +0200
Message-ID: <20240131182653.2673554-1-tmaimon77@gmail.com>
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
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB0:EE_|KL1PR03MB7872:EE_
X-MS-Office365-Filtering-Correlation-Id: a804c1e2-5b8d-4618-ad92-08dc228a3c8d
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zl85MkL7JxQwC6QUAyuQ3q5H/OYqMVHHms8/O52RsF8ljlYCFynxfI2xaTm1G8eoN9xAbPXcrcVrzcg9Cul7Ccc/58vu98sMPvljOSjX3dZDJOiL9sMiYHcxMBL+71JBWa2sp1JBXqSEZ7+uIl7b0V2crAoHtKTiT/wSpujjHM3jycF3qvh6qTsPixa6pR3IomQZ96IFjPn7i9sHJeN+nBaXcHyVPOj0gQbtoEkRyy7JuwE5QqVFWz+t3pG9pO45yGM59zYN0s9UndnG24FETKS16kwHn5iho3c7ZB7hV0Yx3ElX928+aH5JCwySOl4rKjQrFs55FLlSY6naXv9o7cNVp6kEODR2ifPuQWkk/d0d+BqhPWNc6+i/EAJrxD8zxppCAjaqjmzP9GpTvNRLGpmA//ak7CZT5JgsleCE7JGzy1PH1P3kuj+IhCXfCXuh3CvuvYc4q3yJ+Ipq7qbASkIX1vPf1NjzRPcK8BKySw1Ie12AKC0o+mICPhUU886ZIXMJoGmYi6/aiiwTlfGaJEeosgZ9V37nUQIOIcNBRDL+LryFlJvk3p6qydRmArkdrtGPAd4vNG99KlE2Ggxc54gmdwJn1D93m46T45Tk/XVuzGILzLvQd2V2whIV9L+8KhxeV6z9k4fLCGYS+6p6KvWLwYl3ee6RtF1hWDAF/1JeYcFli9PmFMxRHUzGLAh7H8SX8hy18E7HN1tibPQNYuaNt1i86kd54QaoBSDeWt4OvUQDuAal9Hmd0qaEWXv5F72iacQYvQwqsLzxVNjmTrWSlZIbCoSQunOeGfNMqrfsgQvvmYTFAYyITrhn7kj/ktPpRLf/YVku2Uy972PfaMxdmqTVpeuvR9hiLvlHB5E=
X-Forefront-Antispam-Report:
	CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS04.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(346002)(136003)(396003)(230922051799003)(230273577357003)(230173577357003)(64100799003)(451199024)(48200799006)(82310400011)(61400799012)(46966006)(40470700004)(73392003)(26005)(6266002)(336012)(42882007)(2616005)(1076003)(82202003)(83380400001)(966005)(41300700001)(6666004)(498600001)(36756003)(8936002)(4326008)(8676002)(356005)(316002)(42186006)(54906003)(40460700003)(40480700001)(2906002)(81166007)(83170400001)(70206006)(5660300002)(7416002)(82740400003)(110136005)(70586007)(76482006)(55446002)(47076005)(35950700001)(45356006)(32563001)(35450700002);DIR:OUT;SFP:1022;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 18:27:09.6048
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a804c1e2-5b8d-4618-ad92-08dc228a3c8d
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS04.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB0.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7872

This patchset adds clock support for the Nuvoton 
Arbel NPCM8XX Board Management controller (BMC) SoC family.

This patchset cover letter is based from the initial support for NPCM8xx BMC to
keep tracking the version history.

for your note:
 1. dt-bindings clock modification started from v22 since the upstream npcm8xx 
    clock driver haven't merged yet and requires dt binding update according to 
    the new npcm8xx clock driver.

 2. all the other initial support patches had been applied to Linux kernel 6.0.

This patchset was tested on the Arbel NPCM8XX evaluation board.

Addressed comments from:
 - Rob Herring: https://www.spinics.net/lists/devicetree/msg663403.html
 - Krzysztof Kozlowski: https://www.spinics.net/lists/devicetree/msg665206.html

Changes since version 22:
 - Modify commit message to explain broken ABI in dt-binding
 - Using regmap parenet regmap memory therefore remove use of npcm8xx rst-clock patch.
 - Leave npcm7xx rst node as is
 
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

Tomer Maimon (3):
  dt-bindings: clock: npcm845: Add reference 25m clock property
  arm64: dts: nuvoton: npcm8xx: add reference 25m clock
  clk: npcm8xx: add clock controller

 .../bindings/clock/nuvoton,npcm845-clk.yaml   |  12 +
 .../dts/nuvoton/nuvoton-common-npcm8xx.dtsi   |   2 +
 .../boot/dts/nuvoton/nuvoton-npcm845-evb.dts  |   6 +
 drivers/clk/Kconfig                           |   8 +
 drivers/clk/Makefile                          |   1 +
 drivers/clk/clk-npcm8xx.c                     | 509 ++++++++++++++++++
 6 files changed, 538 insertions(+)
 create mode 100644 drivers/clk/clk-npcm8xx.c

-- 
2.34.1



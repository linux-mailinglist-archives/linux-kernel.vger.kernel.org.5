Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8837A59BE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 08:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbjISGLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 02:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjISGK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 02:10:58 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2056.outbound.protection.outlook.com [40.107.117.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0CBFB;
        Mon, 18 Sep 2023 23:10:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i4qEF3YHQMkOqUINoIZOZv7Y2PxeT9/PCKFZDbLWermfHXclHLQKKH8EqBFOXtXeHLPz0uuYI0mYtmmPaBobJ9lJH1STaX3tlP0rIj2+VegpEJN2N9GOKzLsrEEbORw/zYJllNcm6dQ0V897EuoCH8+/K//Z1JO+uL2U4t9nTZ2t3Ktvd+RYkKPpjhvQQN/K4l7bb+zDZ528WzadY4kS/scFp7GnTkIPG/Mx+pVXv0Kb70grIr7ViCyvVxjyDyQyitJg/m8blTwDwr/aGwgiFErzt3W3MIQXi/b7h3slaMp4Zq+UbVSmNjCL+Dpf5mqhl0JwAc15WYLPCzMaFB3BmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sEZdlCAUki5Q1b8G7PRruWoCImxyst+7dMJfb3pd2hs=;
 b=KGwPXjWljtb0dfiY+rQWsJFSiMQuJbQr8UzRoFxc0zkpu8k7kAn6lX8rS4gKx6bucHBPuEeloJ07PFG9w0TL47QNVCkwCqkIP7pyHwLcH0fD0QJVS3dkkTF6uZlHfpKQzvJ1cg7qv7kQinSC4U8y8JANkyBshTOFqW22LHO79xk5Z9NJXaxbzoavTJubJawp3z/FhJeQA13UPNSdCTiUdcf1XuhYug+KIiTF8jd/kXrWLrTroe1d/ruLaPJjQ6i79mLe0MJMHo/r3t/fcwsGmvBDw+/scIsdIUQY4u8+5eSNxoKuNf8uYl6wVWmrwz094c4wUwTJBNC7vjMku9iBmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 175.98.123.7) smtp.rcpttodomain=baylibre.com smtp.mailfrom=nuvoton.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sEZdlCAUki5Q1b8G7PRruWoCImxyst+7dMJfb3pd2hs=;
 b=W6KzVgKm4/FhCeINvBe/ae1mXAyqLek4KHiEA/N6fPjrULNwHSaWKVjCIP1tsCdVtyfLYlvip6fKQuNFZzc88LAUh6jgLwi/6odS991IcLGYyNiKCkRP7vje/gxT85Z5KpgioJrBileW3UtRTFlDxXUZvK8nNl9Kes+zBDS8QvE=
Received: from KL1PR0401CA0001.apcprd04.prod.outlook.com (2603:1096:820:f::6)
 by SI2PR03MB6565.apcprd03.prod.outlook.com (2603:1096:4:1e0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 06:10:47 +0000
Received: from HK2PEPF00006FB3.apcprd02.prod.outlook.com
 (2603:1096:820:f:cafe::21) by KL1PR0401CA0001.outlook.office365.com
 (2603:1096:820:f::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27 via Frontend
 Transport; Tue, 19 Sep 2023 06:10:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 175.98.123.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 175.98.123.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=175.98.123.7; helo=NTHCCAS04.nuvoton.com; pr=C
Received: from NTHCCAS04.nuvoton.com (175.98.123.7) by
 HK2PEPF00006FB3.mail.protection.outlook.com (10.167.8.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.6792.20 via Frontend Transport; Tue, 19 Sep 2023 06:10:46 +0000
Received: from NTHCML01B.nuvoton.com (10.1.8.178) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.14; Tue, 19
 Sep 2023 14:10:45 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCML01B.nuvoton.com
 (10.1.8.178) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Tue, 19 Sep
 2023 14:10:45 +0800
Received: from taln60.nuvoton.co.il (10.191.1.180) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 19 Sep 2023 14:10:45 +0800
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 4BD6E64740; Tue, 19 Sep 2023 09:10:44 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <avifishman70@gmail.com>, <tali.perry1@gmail.com>,
        <joel@jms.id.au>, <venture@google.com>, <yuenn@google.com>,
        <benjaminfair@google.com>
CC:     <openbmc@lists.ozlabs.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v19 0/1] Introduce Nuvoton Arbel NPCM8XX BMC SoC
Date:   Tue, 19 Sep 2023 09:10:40 +0300
Message-ID: <20230919061041.124415-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB3:EE_|SI2PR03MB6565:EE_
X-MS-Office365-Filtering-Correlation-Id: adcc01c3-370c-4cb5-b1c2-08dbb8d729ea
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NCCNJL9rk6nqZShB0TBAf71i5U/xY7EKwPZ1nv+is/aTLykP2j6BoqdiuhgoOKLMA5/Mzq82SvRXsNR3h732sBf9hFfJ14oHj3HaGwf8j3xTwAoyH3gYj5szPVYSE9CJCEuyQUiyeAdjwEkoTtV38J/jmVqFYoO1QQDPGZCB8V7om5W0hnvotLCT/MwpxhREVOD76Ijd+GeDfgdBObzh2PK2JubP8WtKIX1ivn8LM5lAj0d9IRTZoQduBeMc06qa29AgSAdksYx3o68VAoDmhqsWT6yr+A5sYaOPwKgXP0/EUgi2BoLV3hxQjJ7+e4LFUBVrpxYAXrt5hOwgFzQrWLfUuWLVUgu0+FzmpACvWafS4zQfYb/tVN/ND+GPE5UGnwWGBRCGsG46v1RP9FaHosJ5gedAL2AAHyYLKFImh8uehHCqx1G2DJby9XR6lkzmty0CzVLFU0e2JQYmvtTmK9SEyARUhh/lW0vwX5JK+s6Jq9BRYaD5aBjsGa0tEYUL3ycPXm45L2280CCanCI9HF9NQgkoUR+E11FhDF1nZStIXEzTRZxk00H2ui35XlSaXYiNVbsrC4/2DsQwQIYB8z83Rrth8wEzTgoOK456m0NfUFMnS6k72TL1sisoB+dq9cT4kDNZMXAs7XK7jrN5iSmiS32/a/bNKIzN1xYlmb5Et4qijbjajoMQF6dJnXF/7WTXnWqvhfkXVlrkBw3eQGnMCPdoJinhVeyA4k/Bnz2YGMCq0Hj4GhTNgliwv8ajiLnhLPPHkmLYqUowF954kqFbhGmQIELMm6lst/J1PKDawgT30NrI0jsnlvTm0a6SmOO6tpQZAv4APOv/mR/S1uqbCN4rM7s33Mplrxwdv5sL90eU+AsZTlY9daVKyfIPPdg8OmQttQhgl8ZgKdsVcQ==
X-Forefront-Antispam-Report: CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS04.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(39860400002)(136003)(376002)(84050400002)(48200799006)(61400799006)(451199024)(82310400011)(186009)(36840700001)(46966006)(40470700004)(40480700001)(81166007)(83170400001)(36756003)(356005)(82740400003)(55446002)(40460700003)(2906002)(478600001)(76482006)(70206006)(54906003)(5660300002)(70586007)(6666004)(4326008)(8936002)(8676002)(42186006)(42882007)(336012)(83380400001)(73392003)(6266002)(82202003)(36860700001)(47076005)(316002)(7416002)(41300700001)(110136005)(26005)(2616005)(1076003)(45356006)(32563001)(35450700002);DIR:OUT;SFP:1101;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 06:10:46.3158
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: adcc01c3-370c-4cb5-b1c2-08dbb8d729ea
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS04.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: HK2PEPF00006FB3.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6565
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NML_ADSP_CUSTOM_MED,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds clock support for the Nuvoton 
Arbel NPCM8XX Board Management controller (BMC) SoC family.

This patchset cover letter is based from the initial support for NPCM8xx BMC to
keep tracking the version history.

all the other initial support patches had been applied to Linux kernel 6.0.

This patchset was tested on the Arbel NPCM8XX evaluation board.

Changes since version 17:
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

Changes since version 6:
 - NPCM reset driver
	- Modify warning message.
 - dt-bindings: serial: 8250: Add npcm845 compatible string patch accepted, due
   to it the patch removed from the patchset.

Changes since version 5:
 - NPCM8XX clock driver
	- Remove refclk if devm_of_clk_add_hw_provider function failed.
 - NPCM8XX clock source driver
	- Remove NPCM8XX TIMER_OF_DECLARE support, using the same as NPCM7XX.

Changes since version 4:
 - NPCM8XX clock driver
	- Use the same quote in the dt-binding file.

Changes since version 3:
 - NPCM8XX clock driver
	- Rename NPCM8xx clock dt-binding header file.
	- Remove unused structures.
	- Improve Handling the clocks registration.
 - NPCM reset driver
	- Add ref phandle to dt-binding.

Changes since version 2:
 - Remove NPCM8xx WDT compatible patch.
 - Remove NPCM8xx UART compatible patch.
 - NPCM8XX clock driver
	- Add debug new line.
	- Add 25M fixed rate clock.
	- Remove unused clocks and clock name from dt-binding.
 - NPCM reset driver
	- Revert to npcm7xx dt-binding.
	- Skip dt binding quotes.
	- Adding DTS backward compatibility.
	- Remove NPCM8xx binding include file.
	- Warp commit message.
- NPCM8XX device tree:
	- Remove unused clock nodes (used in the clock driver)
	- Modify gcr and rst node names.

Changes since version 1:
 - NPCM8XX clock driver
	- Modify dt-binding.
	- Remove unsed definition and include.
	- Include alphabetically.
	- Use clock devm.
 - NPCM reset driver
	- Modify dt-binding.
	- Modify syscon name.
	- Add syscon support to NPCM7XX dts reset node.
	- use data structure.
 - NPCM8XX device tree:
	- Modify evb compatible name.
	- Add NPCM7xx compatible.
	- Remove disable nodes from the EVB DTS.

Tomer Maimon (1):
  clk: npcm8xx: add clock controller

 drivers/clk/Kconfig       |   8 +
 drivers/clk/Makefile      |   1 +
 drivers/clk/clk-npcm8xx.c | 565 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 574 insertions(+)
 create mode 100644 drivers/clk/clk-npcm8xx.c

-- 
2.33.0


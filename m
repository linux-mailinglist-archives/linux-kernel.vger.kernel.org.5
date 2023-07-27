Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE6D76494F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbjG0Hu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233561AbjG0HuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:50:03 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2065.outbound.protection.outlook.com [40.107.255.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99085272E;
        Thu, 27 Jul 2023 00:43:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M1DFD4OVahGhL3lwMNBnrTpFm94K0kZvGYQuflPBy9PW3KYzl2IKf6a1IkZzCl2xtyk3A0XfnAs3zHb6TVZo1CYUqmIMMLwzMVvmjHfIpm45TwQgA4rfwcyIpFu1l4YSBbTx58NqurHz1hQ4v3GVk//wlk2iiuG4of/H8T3B3y0vR4eGJYcaRny1/e6lF5F1tibXrl6BiWKgv/3grMIsB5JRYvj1O97xBVFl7OSckbl0q9KZXgCkhh3AHv+EGHD4jEX1sxe2x/B9BGMTIboSnTsU48pxGJVM/htGnx24AP6sGkKxTYeT96B7Q/g5sgiXFFX1Pz0WY8FMJk2SWELqJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uAR100qg24jW3v+EYBFVaMTnJkcucJoDl2533ugBoL0=;
 b=jSoKGrJAygAvHc4VImwBjD8+1s100w4Xz58gmfqNP8G0NXTmbdd/IMgVFETUufgY1Ggdy6Lb+PzW43s5m+NNIHmolRyYOTioqG2CtXm9zMsyyINASsq4r0XEUHFphViNhMQtTGpENs0S/D7LZIS/BOL6DqnEjItoVJGeemVFiYXwmTRxnQhFl3efwEU7OYgBsFs6PJ1bObhv8JiEbW+CrT/BwOWavXYH3Xy8dotpdj+rw0XXGqtY++F1oswzOiKEeSe5Bmlz2Lj6OCew7fkBswf3OAyKipnM/CVdnECVLt/Tiw66ahO8FS8x9PWXZN49XN9rbe84nWpw9JfGUV+yBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 211.75.126.7) smtp.rcpttodomain=baylibre.com smtp.mailfrom=nuvoton.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uAR100qg24jW3v+EYBFVaMTnJkcucJoDl2533ugBoL0=;
 b=OQsrvNLeFkmloAA7f8GwGgNwfnk5ZvhgrZJseu3N+9NZtAYsuRXqAmR8r/828edIELnZRVwagspqtdu6AiFAQNNO9ON9l0fpqonhciSISXy4wDl7wMfcohlReZal2ny2TO3/5h+1m0+NJ6ptHnsblMF5zrAWz7iDvGzfanMnvKY=
Received: from SG2PR04CA0175.apcprd04.prod.outlook.com (2603:1096:4:14::13) by
 TYZPR03MB5661.apcprd03.prod.outlook.com (2603:1096:400:82::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.33; Thu, 27 Jul 2023 07:43:40 +0000
Received: from SG2APC01FT0059.eop-APC01.prod.protection.outlook.com
 (2603:1096:4:14:cafe::b2) by SG2PR04CA0175.outlook.office365.com
 (2603:1096:4:14::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Thu, 27 Jul 2023 07:43:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 211.75.126.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 211.75.126.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.75.126.7; helo=NTHCCAS01.nuvoton.com; pr=C
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 SG2APC01FT0059.mail.protection.outlook.com (10.13.36.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Thu, 27 Jul 2023 07:43:38 +0000
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 27 Jul
 2023 15:43:38 +0800
Received: from taln60.nuvoton.co.il (10.191.1.180) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 27 Jul 2023 15:43:37 +0800
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id D2D2164740; Thu, 27 Jul 2023 10:43:36 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <avifishman70@gmail.com>, <tali.perry1@gmail.com>,
        <joel@jms.id.au>, <venture@google.com>, <yuenn@google.com>,
        <benjaminfair@google.com>
CC:     <openbmc@lists.ozlabs.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v18 0/1] Introduce Nuvoton Arbel NPCM8XX BMC SoC
Date:   Thu, 27 Jul 2023 10:43:27 +0300
Message-ID: <20230727074328.34144-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2APC01FT0059:EE_|TYZPR03MB5661:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ccdc3a4-d433-4227-237e-08db8e753131
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IbNnj9GZA4FDg3qUyqcyo5DrCONLILMJtnMIS7jzPCdtK52nkYiV9xH4wu8dPNwOqiqR9nvHZ03oownq8EEzD+Z9t1skajAH6biZ+4KOfBPyca8wMXl4hpGyg0ZijEohRxS914iiAUuOnQuPvpusst9EinLW4+h3CC7NiKRnGEdFeh2aYb7+kWNHs9LiuQXC4J6+h7BahB4mSp2w5jdsgnXX9D22BihcqjkfDFX66cbCoPZilRxIQHclW+ms5s+De6d95hyC1XthjnuMqXu+aHgGEdCn/3k9InWYht4cuJHcqx9p2nnhGvNOEpw23RxCiQGX3m3oBUBn4DxLZjrVTsMiVGdJtr88nOg6GeEwJVirzsu0oHP8JdIX1YcqzLL6JM5Xjc2W+UDrDbS2cGSjysV0c1yrRKVwPlLmW/iBmOPvnhP8JEv+KCqDQqp+mCwuwIBxTv2idJdlHboCBdtPYM72O0Sj4zoCZF6SjkoKDRvmWF4zBQo0+KXfKLW7wHPGEPB+gMkCdx7D7Mx8Edwz+GER9RukaGdxtOtvwjsZnIs8x0UJee6Q78wm7ltsu4DmNzBvRX0Q9pU4Cz+iEV2oFrzlIKJPrAv+VWIZpRXMNDBFWn7PLCXXQy42hXNUxvvdGUq/s4bs0Wdng25Ps31MZa8nhzdPJ1BF15AriW9xIsTuam1yoJUyKGYdk2lfsluy7gdyIKkpd5aAjGNemuXFKXiGtn+dRwUGtCKHnjM68pPdHODLWjumNSJr8rUvXre7/y9/UTl9ANeyFjEbEyS176yafo5BMMcfGkeytvvO69FTNzZ5sYB3WVqr+uMUISnYM/A93sCfXvjhssYI1TfLrmSYXvasa4fOAKbNr4nr+CcJbXI4aXm8Vs8M+rkmxlLY/JHGJIdeTFmNf/Z1F4/Etw==
X-Forefront-Antispam-Report: CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(376002)(396003)(84050400002)(61400799003)(82310400008)(451199021)(46966006)(40470700004)(36840700001)(36756003)(55446002)(7416002)(2906002)(40480700001)(83380400001)(36860700001)(47076005)(336012)(42882007)(6266002)(186003)(26005)(82202003)(1076003)(41300700001)(356005)(6666004)(110136005)(54906003)(83170400001)(478600001)(76482006)(81166007)(40460700003)(82740400003)(70206006)(73392003)(4326008)(316002)(70586007)(8936002)(42186006)(8676002)(5660300002)(2616005)(45356006)(32563001)(35450700002);DIR:OUT;SFP:1101;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 07:43:38.9585
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ccdc3a4-d433-4227-237e-08db8e753131
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: SG2APC01FT0059.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5661
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NML_ADSP_CUSTOM_MED,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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


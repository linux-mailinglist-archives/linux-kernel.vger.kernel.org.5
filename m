Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE98769633
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 14:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbjGaMYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 08:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232623AbjGaMYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 08:24:24 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2064.outbound.protection.outlook.com [40.107.117.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6003173F;
        Mon, 31 Jul 2023 05:24:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ko1mHyk3NFwyFN1ULcv2STV7PA5TmmO6uvsBJXaoPRgelpvQdN1tQY3eErBUZxwvjIABVE+Vv+R9Lyt/zplkGlyS4VHEIPlhg/JKxEjhpPsMs+NLZ3XhbqweiyRNMqRHQdkVlA6nnProSl+eYHEOA1L2s9Rl4VZS1dnA+jmWYOtQMD07362Q2wmYRtl5vfNgAW5u/0/mnkc10HvuOIlIQPDOQFlMOI+4a8jWKKyUJl4i7ym8LO/xM99tjzKQdO9EJsFDsOi4HFeFHKSpOOWOszpJ6QDjbYcrVyZhVe3nZjt4FsfRflpVKJXISDlsLDlsj0K1LVgEjNTPvoymjEqoGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e3esm4LY+Pj8ife1TSh+B2LZa63/Rio2S15CiuzVgiE=;
 b=UQG1Zy6E7e4f+ilviCIUB1CCfbNCftH91dJkyNP+kJ5uJ2AZzYwkHYJgZfr/uKz2WGZ7lkrSYwdEj9Yg565sKS9B46jaWj2G1NcZQzqBpC+hqZ+S/Kd5nWNF7Houc8goQ+RgO7tvUoa1e82wG/dY5C9YcZcvL7GkhK/XWKBZDjaSLrgb4TaUmdf4+WAuNcPGSpNw55ioEhO+3hSYd4xr4KzsBmeXzxYAnSRtTJoi/+1EiqRn4MbvwPNtT7dHW1mD3DWzfYj/lYMygY+USOsgNgJJqjIkG4dPOmTswDeCjcaaTbTIF6s3HelR3dSPwU4J9SqE/S2II6gU93UwcDJFSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 175.98.123.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=nuvoton.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3esm4LY+Pj8ife1TSh+B2LZa63/Rio2S15CiuzVgiE=;
 b=Ncf0wl6Syliq505USBFpr0652YTVI8QLSR9K/E2t8lCSunoGkicp0UCC1NvRt+H+25ROiGuFexyNeEyRCuRMru28V3CU72ww08rnOP4gvFNrur4qvodDYMgTRJnEeKj70Vs7XNoEhx9B7/S8BSaSA4T+B3rpwwkAjXjM6Yt4FFY=
Received: from PS2PR03CA0018.apcprd03.prod.outlook.com (2603:1096:300:5b::30)
 by PSAPR03MB5717.apcprd03.prod.outlook.com (2603:1096:301:7a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 12:23:26 +0000
Received: from HK2PEPF00006FAF.apcprd02.prod.outlook.com
 (2603:1096:300:5b:cafe::ab) by PS2PR03CA0018.outlook.office365.com
 (2603:1096:300:5b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.17 via Frontend
 Transport; Mon, 31 Jul 2023 12:23:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 175.98.123.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 175.98.123.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=175.98.123.7; helo=NTHCCAS04.nuvoton.com; pr=C
Received: from NTHCCAS04.nuvoton.com (175.98.123.7) by
 HK2PEPF00006FAF.mail.protection.outlook.com (10.167.8.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.6631.22 via Frontend Transport; Mon, 31 Jul 2023 12:23:26 +0000
Received: from NTHCML01A.nuvoton.com (10.1.8.177) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.14; Mon, 31
 Jul 2023 20:23:25 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCML01A.nuvoton.com
 (10.1.8.177) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Mon, 31 Jul
 2023 20:23:25 +0800
Received: from taln60.nuvoton.co.il (10.191.1.180) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 31 Jul 2023 20:23:25 +0800
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 781BA6473F; Mon, 31 Jul 2023 15:23:24 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <avifishman70@gmail.com>, <tali.perry1@gmail.com>,
        <joel@jms.id.au>, <venture@google.com>, <yuenn@google.com>,
        <benjaminfair@google.com>
CC:     <openbmc@lists.ozlabs.org>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v4 0/2] pinctrl: nuvoton: add pinmux and GPIO driver for NPCM8XX
Date:   Mon, 31 Jul 2023 15:23:21 +0300
Message-ID: <20230731122323.172834-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FAF:EE_|PSAPR03MB5717:EE_
X-MS-Office365-Filtering-Correlation-Id: 452ada47-868c-4cf4-d5bc-08db91c0f0db
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jn6AkhhEq3DS4sVK4xGMsWxyvuRdXEMyM/KcAmq27R4H9ouI8y9Weclu+MfL4SRK601vwyX3lgghXMVnXKJMbWfo5o1bouh2iLQsiQqhpZvCLPEOWf9CHuIq+QmAkR68FKc7vVsn7hck8eb6t3xMEbPuLR1Aki/C2LO6O1oibRt2Hy8zjmmgCTXcJrAt8TgTT8ZcqkYs+sDu3R+YGC7lRNQjD5gSyiaox4fx2G6P//xMPJMm41s2DmSos9RZCNfGBqULDE9wZ7MnEVuoV1dR8WKVC6jZid6+jh1yw0eU5UML0TsPJ7B4K5Mc2zb5YBuAmgrh/AfzsiRmzntF8mp2/kkOLDaIRTdi2QrzUQUlQEHEivsAsPMblPRrEJBfXIgJnDG3pMxaFznv7MSxwn1f5nybyyXY2dbUfqtUn0GpxMtRTFbAGDPcocUXe23KtssPvIMDMjeZuGyGUCoffamRUSjvJS6YwiARNxLlFtZ21CAWXNRxHlhjlr3Vf00vNeq8qpwfojX5dZku49G+Y/J4Fhar24D5S9MCF6T1zIkqubiROlprUuD9DvVr5hak+VA0Jm6dhH1zgMGwa3gYf5iZiYvjvxCxmkSGoPu71lbEWISjntZnjFQJLua/hsKKC12Guir0a7HXj6qI37GRCs+laUabfnMwhPxcLyUEAQqL6xAefniUY0+8WnUAC0bDAMRmARnqJC9fDf3xL5N73vNKDawRMS5S/t00AF/w0jWFL8p5ysXpBZZenYSsoC3GOL5+zAQwdn1qW4JA1e3V3rXzu+TkEQrtkfcbhjdq69RBCMFmv9jZvDzOyUgXbuoQEz6THY4teZgJa9TAN2HUOdGHE+vADxuMZXDin0eheQZIZu7SFUV1TLlflp/tCZ58iPyB+U+NIifYG2FtM2rTlN9hgS6D+0zjxjGGDn4JwgM0N09TBWLD3wK5uRQ2QNaCwwrZ
X-Forefront-Antispam-Report: CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS04.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199021)(82310400008)(61400799003)(46966006)(40470700004)(36840700001)(40460700003)(6666004)(966005)(36860700001)(42882007)(6266002)(336012)(186003)(47076005)(73392003)(2616005)(36756003)(83380400001)(55446002)(81166007)(83170400001)(921005)(82740400003)(356005)(1076003)(26005)(82202003)(40480700001)(2906002)(4326008)(70586007)(70206006)(42186006)(316002)(478600001)(5660300002)(7416002)(41300700001)(8676002)(8936002)(76482006)(110136005)(54906003)(45356006)(32563001)(35450700002);DIR:OUT;SFP:1101;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 12:23:26.3275
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 452ada47-868c-4cf4-d5bc-08db91c0f0db
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS04.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: HK2PEPF00006FAF.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5717
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NML_ADSP_CUSTOM_MED,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds pinmux and GPIO controller for the Arbel NPCM8XX 
Baseboard Management Controller (BMC).

Arbel BMC NPCM8XX pinctrl driver based on Poleg NPCM7XX, except the
pin mux mapping difference the NPCM8XX GPIO supports adjust debounce
period time.

Arbel BMC NPCM8XX Pinmux functions accessible only for pin groups 
and pin configuration parameters available only for individual pins.

Arbel BMC NPCM8XX has eight identical GPIO modules,
each module has 32 GPIO ports.

Most of the GPIO ports are multiplexed with other system functions.

The NPCM8XX pinctrl and GPIO driver were tested on NPCM845 evaluation board.

Addressed comments from:
 - Krzysztof Kozlowski: https://lore.kernel.org/lkml/d39b63eb-e994-ac55-ff36-145a22d3c99e@linaro.org/
			https://lore.kernel.org/lkml/699d3c00-ed41-9e08-dd86-f06a332fa7a8@linaro.org/

Changes since version 3:
- Pin controller driver
	- Remove unused line in Kconfig.
	- Add GPIO 183-189 GPIO support.
	- Add SPI1 CS pins.
	- Modify SMB23b pin list.
	- Remove unused module pins.
	- Fix PIN-CONFIG_OUTPUT setting.

- Pin controller dt-binding
        - Modify pin and function items.
        - Use consistent quotes.
        - drop unneseccary quote.
        - pincrtl node name modify to pinctrl@f0800260 since
          the pin controller handling was done in 0xf0800260 
          offset.

Changes since version 2:
- Pin controller driver
        - Modify kernel configuration.
        - Adding and removing include files.
        - Using the same register format size.
        - Reducing lines by command combination.
        - Remove unnecessary parentheses use.
        - Use GENMASK and BIT macros.
        - Using traditional patterns.

 - Pin controller dt-binding
        - Modify GPIO description.
        - pintcrtl node name, Sorry, I know we have a long discussion about it.
          Still, I think the best header pinctrl node name is pinctrl@f0800000. 
          because the pin mux is handled through the GCR.
	  BTW, same pinctrl header name is used in the NPCM7XX pinctrl version.
	  https://elixir.bootlin.com/linux/v6.0-rc6/source/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi#L560

Changes since version 1:
 - Pin controller driver
	- Remove unnecessary debug prints and comments.
	- Use fwnode functions.
	- Remove Redundant 'else'.
	- Use switch case instead of else if.
	- Use GENMASK and BIT macros.
	- Use dev_err_probe in probe error.
	- Use callback GPIO range.
	- Add GCR phandle property.
	- Parameter order in reversed xmas

 - Pin controller dt-binding
	- Modify name from pin to mux.
	- Add phandle property.


Tomer Maimon (2):
  dt-binding: pinctrl: Add NPCM8XX pinctrl and GPIO documentation
  pinctrl: nuvoton: add NPCM8XX pinctrl and GPIO driver

 .../pinctrl/nuvoton,npcm845-pinctrl.yaml      |  215 ++
 drivers/pinctrl/nuvoton/Kconfig               |   14 +
 drivers/pinctrl/nuvoton/Makefile              |    1 +
 drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c     | 2491 +++++++++++++++++
 4 files changed, 2721 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/nuvoton,npcm845-pinctrl.yaml
 create mode 100644 drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c

-- 
2.33.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1573180C0D7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 06:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjLKFrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 00:47:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjLKFrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 00:47:31 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2077.outbound.protection.outlook.com [40.107.255.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1782D9;
        Sun, 10 Dec 2023 21:47:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NmZzyxwXJdSVxGAVncw6Ys3MeCCMkMyd09O6IvrVtMimEug/OjIyiTRHFXCGOFo5pgqC2+swsSnpmR1s7jTTr4Gf4cdJNl4dvsXuNBStXVflGH4JMvb9V6CYXj7D6XNiOQ11yDXwkRyv7ZXDu6sFz1ErImjtRm1Ht3O+/JA4woNy4RneCU4fPYOyoiN0ynKAQvM3rP2Xl8+3PFy7dp+UJ1/yr3M8lRewYUqE1jPoQHAp2py+wto9ejQk6CNzpzy/sEqFVxfl/NBFD6bhrhCuW6tZk6Lald7sdWNrsBFsQP7J6qa4mGc61p2UFEiuJiWAy/9pRb82FVNsx8KOqbzYJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QXxakjvTI779Au1LcBAD7L7pqq0cduo+wQstHyYpkt4=;
 b=QARVwXfOJmPwFR8ZaubtB0MDvEQslThP0myv9N8+8FxxVgxefmeBRPdeY8NgEuXBlynEnbpXLoMTNoVK6GvDmrGa3vkLezf7U3yHor9Gwg1Rn/+LBLSSFv6SIKK58JuvgjOr9C4dC3FX/QqIlGKasBeo1uBZKHnm7E94Nck5R2t9g1vWrAymbW2VGBCXXDtBPekgajw6MOZTXXu7zf9M6WzZC512SjLI7UiQIcMBK+o1Qz1gtQ11a4XGVurRtPTHNz7Jv8n8UaGc2RZWxSN8Gwh53ngTRR7ZPKqJ9FR/RFNxc/WIa3pXBF6xnZVMqZ3UDE2mVTSx/oHARoLOajvIPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QXxakjvTI779Au1LcBAD7L7pqq0cduo+wQstHyYpkt4=;
 b=TTDV+tzN6MOuhw0klg7p5Am+buZw14+rvtmhyR2WvUBTF+A0VYmNyP0uJE4FhxgAmQQmnQpQh7SbyAYc34gJQMOX0y07+wgRAVt4N04YFqhyt6xkq9G0ww/4w1tTdedq8maoG8NnTfnwQevQJ+8shPGzuVFwvrT1fDqD9E+wPa/+4mplZFfIS6zCquyMqYwaE3G+nWp1vUFffvXsc2e6fwUVf+BzjUXfIQyyVZ0FlU3+x96COtrWllOffPzWcK3kl2LVsSqs7qz2vi+IpGko1KzfOf1BsbiWR6mbUME8D4ljt/RwfPOMpoekqGZ7+x6u/etR8Hck7LeGlpQxy5h5AA==
Received: from SG2PR02CA0049.apcprd02.prod.outlook.com (2603:1096:4:54::13) by
 JH0PR04MB7071.apcprd04.prod.outlook.com (2603:1096:990:34::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.32; Mon, 11 Dec 2023 05:47:33 +0000
Received: from HK2PEPF00006FAF.apcprd02.prod.outlook.com
 (2603:1096:4:54:cafe::6a) by SG2PR02CA0049.outlook.office365.com
 (2603:1096:4:54::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32 via Frontend
 Transport; Mon, 11 Dec 2023 05:47:33 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FAF.mail.protection.outlook.com (10.167.8.5) with Microsoft SMTP
 Server id 15.20.7091.18 via Frontend Transport; Mon, 11 Dec 2023 05:47:32
 +0000
From:   Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To:     patrick@stwcx.xyz
Cc:     Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 00/14] Add i2c-mux and eeprom devices for Meta Yosemite 4
Date:   Mon, 11 Dec 2023 13:47:15 +0800
Message-Id: <20231211054730.208588-1-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FAF:EE_|JH0PR04MB7071:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 506195b1-7c89-4d98-f291-08dbfa0cab7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LKt4lEXifW/cSuH6/KQrV/7F6lcP3/TBN+K12/lh+1UaLopFt1/n2Q2JsnvEB+aSayikuoPlekOaP4nHhGP29+Vserx+kTYn9rWgnUtujJ2p9zitIol/xd0A9sT5L2DgAA51jHGN3pdsO2oPLiSLG+kMZS9URaKz0U6TVD3Aoqvz5EABQjbq8X/IcicDZnqQ2BYqQ3fY6F7GcTaQNBImLjXExMkIt4b7fyXdrpL4vI0Tdv2DdQ9oIZ3FBI6dlgG++nX/ErxTQMsq19ncqofh2ItHLWWzJ4rxsPemq//1QAByKAXyRSX5xi+8f3zDAu/KwZq0mP1JxFpfMw2i3IgaHCRDemzJDebOjSmmeoI1xelzcTjsBsBx8Vf+Hd+bHzLtEZSu8sgUoZlYaL2N6F64zjo1fCAgafsbmoVhX62VaKsfV5lGgouCiwT5KTqDbiu7Q7uAN/yNfP7FSWBGP6TEthtH9cry7zv1gq9qOqaoIHfgIEdWHt0/wuicxRSNIkjFPYVAjIvnZQ2CtZJqRO1zHCRbZGWglfFelYucwMq3T0PxNPw8C3gWSapZ2p5IT0QyiHyyANkCSHPD6przUnZ4OBpiGcU+tKxg7eNeXNqnGOmnZoTDjcnCborFOcj675OYDkE+bvMQTBZPckoO2KI6bxy3jK4aatdwTaGnqjqQTO1J59c0qfmiuBek0B6saUIg6eJvSnADNAFUHoTFel339Q==
X-Forefront-Antispam-Report: CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(6069001)(4636009)(376002)(396003)(346002)(136003)(39850400004)(230922051799003)(64100799003)(1800799012)(186009)(82310400011)(451199024)(46966006)(36840700001)(86362001)(316002)(36736006)(356005)(40480700001)(82740400003)(81166007)(36860700001)(47076005)(41300700001)(336012)(26005)(83380400001)(956004)(2616005)(1076003)(6486002)(6512007)(6506007)(36756003)(6666004)(2906002)(478600001)(7416002)(70586007)(70206006)(6916009)(54906003)(8936002)(4326008)(9316004)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 05:47:32.4382
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 506195b1-7c89-4d98-f291-08dbfa0cab7a
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: HK2PEPF00006FAF.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR04MB7071
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog:
  - v3
    - Correct patch for revising gpio name
  - v2
    - Revise mx31790 fan tach config
    - Add mctp config for NIC
    - Support mux to cpld
    - Revise gpio name
  - v1
    - Add gpio and eeprom behind i2c-mux
    - Remove redundant idle-state setting for i2c-mux
    - Enable adc 15, wdt2,spi gpio for yosemite4 use
    - Revise quad mode to dual mode to avoid WP pin influnece the SPI
    - Revise power sensor adm1281 for yosemite4 schematic change
    - Add gpio pca9506 I/O expander for yosemite4 use
    - remove space for adm1272 compatible
    - enable interrupt setting for pca9555
    - add eeprom for yosemite4 medusa board/BSM use
    - remove temperature sensor for yosemite4 schematic change
    - add power sensor for power module reading
    - Revise adc128d818 adc mode for yosemite4 schematic change
    - Revise ina233 for yosemite4 schematic change
    - Remove idle state setting for yosemite4 NIC connection
    - Initialize bmc gpio state
    - Revise mx31790 fan tach config
    - Add mctp config for NIC
    - Support mux to cpld
    - Revise gpio name

Delphine CC Chiu (14):
  ARM: dts: aspeed: yosemite4: Revise i2c-mux devices
  ARM: dts: aspeed: yosemite4: Enable adc15
  ARM: dts: aspeed: yosemite4: Enable spi-gpio setting
  ARM: dts: aspeed: yosemite4: Enable watchdog2
  ARM: dts: aspeed: yosemite4: Revise quad mode to dual mode
  ARM: dts: aspeed: yosemite4: Revise power sensor adm1281 for schematic
    change
  ARM: dts: aspeed: yosemite4: Add gpio pca9506
  ARM: dts: aspeed: yosemite4: Revise i2c11 and i2c12 schematic change
  ARM: dts: aspeed: yosemite4: Revise i2c14 and i2c15 schematic change
  ARM: dts: aspeed: yosemite4: Initialize bmc gpio state
  ARM: dts: aspeed: yosemite4: Revise mx31790 fan tach config
  ARM: dts: aspeed: yosemite4: add mctp config for NIC
  ARM: dts: aspeed: yosemite4: support mux to cpld
  ARM: dts: aspeed: yosemite4: Revise gpio name

 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 1215 +++++++++++++++--
 1 file changed, 1091 insertions(+), 124 deletions(-)

-- 
2.25.1


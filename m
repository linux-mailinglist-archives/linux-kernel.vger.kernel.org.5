Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE35C78837F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 11:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243466AbjHYJZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 05:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241247AbjHYJYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 05:24:51 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2064.outbound.protection.outlook.com [40.107.117.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F801FC3;
        Fri, 25 Aug 2023 02:24:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RC5Yg1HaZ9XPGytjCWQqA9QcXtxTJBVzVziJwTLUA9Ax4ucKw/Qal51L+pkPA1FjxPpCHybhvNLeOJetsoOFMrwTagPQuk0FAym2hfmyPi6XQKOUjfCpIT1CJ+kmV3iuFP9t0xjxqgdOl7NIe38p+TJo4jJ5H7u5p2J2Vz4arA4eORROpBbzWj09XEm4CEpKLbZXPwwCPWbiniTvI4Q2jdZvRRMzFvAjKZ1AUZdrCaLIwdPoNElhdFbWGkyJgZv8O3xJVgRc7LjzfmtrhNi7itphxLitiCtrIVJkRCiJb2lMPVQgHDuyTX3MGmoP7GrbsTJWM37Ongg3uynN4Aul0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xH3IzbED46jcHIu8ANMo/JSmZFVL49rnfledr5HxCl4=;
 b=hC4VpSAF/uP8yo1KAyvYwIhiMLy9ou3+W12CbSqooOx0suZC75WWFadAarQx689HRAyVAP614j3KQ41IT9bfVBGRcYeAmOZ7BE2TE4KOfQtHHGnYTVSsY6JgTgq9AzvQtAVggwxwfb/NvB8KIlRDXUyZsrekcutY6RgUo9Rh/VkwJ5GnLOjJmuMG6hHePz/MKrBwcMH/XxDHtJmC2vkgbUMgom5SDoG/4QNoe2lggr/sXFvjAPtacKmTnBMFcbA1a0Jc2RGUJ53ykyvYR2uRwKtn69fHTcuDVSMfQaRyYqI6v3FbkbXBymBrYG07NF197NTyhIoZpK49pWj6zoDGaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xH3IzbED46jcHIu8ANMo/JSmZFVL49rnfledr5HxCl4=;
 b=oYipo8fKbGSEue1gt/adLL2eqDA5QDN7RfqEC/Ah66o2nnHc/krTlW/yAGqoBNJ9etWznvdEPRfRsW5LTnCR/l5ZyxvAz9sV9AuGlNe3M0UDiodpRoVWiR25cWMhxn0nLrYtxQzsrOQTSCkbVD8/3JYCZpw9iZ2g+qh05MeWDW8XqHTdk6EoD0+COguRNMroyRDZcQcbbw21PvOOT0ouLZZ5fjxa1MUDgU7QpPI59eEfplsbsoZAzYwy+8pZhPBjlXRYmNGBIxWNz4vtHZ1Ur+9SvANEiHM+TYPSvfhqgzWnQC7rxvP+2L9cduahOqOdorp+qDgcDlAp5yVj7v6LJg==
Received: from SGAP274CA0008.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::20) by
 PUZPR04MB6843.apcprd04.prod.outlook.com (2603:1096:301:107::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.29; Fri, 25 Aug 2023 09:24:43 +0000
Received: from SG2PEPF000B66C9.apcprd03.prod.outlook.com
 (2603:1096:4:b6:cafe::db) by SGAP274CA0008.outlook.office365.com
 (2603:1096:4:b6::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.30 via Frontend
 Transport; Fri, 25 Aug 2023 09:24:42 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG2PEPF000B66C9.mail.protection.outlook.com (10.167.240.20) with Microsoft
 SMTP Server id 15.20.6699.15 via Frontend Transport; Fri, 25 Aug 2023
 09:24:41 +0000
From:   Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To:     patrick@stwcx.xyz
Cc:     Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v11 0/2] ARM: dts: Facebook Yosemite 4 platform
Date:   Fri, 25 Aug 2023 17:24:35 +0800
Message-Id: <20230825092438.2082402-1-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66C9:EE_|PUZPR04MB6843:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ea514e13-e4cc-4c08-47ec-08dba54d1cf0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /W3dNldsLINX7xGuIIAneXoLl5RSywErQ03AEMBDsCvNbe4hcFHkerSgpaoNEf9pebqAyJIgHzjQwO+kau88ew8yG6ooKepTFdypuL1ZXiFHFElvIgIQAoEOgH6lX2+urmBsVInDiFT8CYvO6H15Ebt7Em9oM3weu/RUFZ8j8QJc/ocbb6xSaQAoaXNPeFeHUrIYMD/YF9tR7h3ysWYVs4agcfy+qsirBbqLWWUNeTcEkxiqGiyzNYUxZh06ZCjMtdbMplOT4djWm9pPJQQEEa30aY9mRHLczSf0Lom9kg73Q4RqPyNFSfrHIfFLdXpISuPgicd7mURbpPLy2GQULs06KqHBZfodY+xF7kFPp32EAA6WAeCqwKcfRoRvZiokHwvy6zJFydBX5+uakU89MXZtiTmdwegR44pjL1dL5WZQaF8yUXMudl+O/w8ONsN8OHFHnfUzQNpZafQLDd5jpCyUj4rllxSR//TN9fBHH9nwCx3QcvXyuD3ynB9ABUYNWhpmj3Ez1YI5Ou1BETnflna7b94e/tfpIo9Sxahd9q+vrb/LrY2yXwa819NHwCqfRP5CUpdUMpP0hAuNtO45lJqTYyBAxU+xG7Rb5hx7ajrcMltXJ21MRu3dVNwMq9UdScMcHsPIsghswqHwdutbp7WbK+mZdSgD10Ui6zyo94ew4+PUFPCbTDo0Cgvqt8S7/JVzbyekSxRoNy9QazWvdA==
X-Forefront-Antispam-Report: CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(6069001)(4636009)(39860400002)(136003)(376002)(396003)(346002)(47680400002)(451199024)(82310400011)(1800799009)(186009)(36840700001)(46966006)(82740400003)(81166007)(356005)(8676002)(4326008)(8936002)(54906003)(41300700001)(6486002)(6506007)(6666004)(316002)(9316004)(36756003)(6916009)(36736006)(70586007)(70206006)(86362001)(6512007)(40480700001)(47076005)(26005)(478600001)(336012)(36860700001)(1076003)(83380400001)(7416002)(2906002)(2616005)(956004)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 09:24:41.3224
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea514e13-e4cc-4c08-47ec-08dba54d1cf0
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: SG2PEPF000B66C9.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR04MB6843
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add linux device tree entry related to
Yosemite 4 specific devices connected to BMC SoC.

Changelog:
v11 - Add imux configs for i2c-mux
    - Add gpio and eeprom devices
    - Remove temperature-sensor 11-004a and 11-004b
    - Change power-sensor ina230 to ina233
v10 - Change to 128MB flash layout from 64MB
 v9 - Remove mac2/mac3 duplicated setting about no-hw-checksum
 v8 - Add description of Yosemite 4
    - Remove unsupported ncsi config
    - Revise i2c-mux config
    - Correct power sensor i2c address
    - Restore i2c 11 bus-frequency to default
 v7 - Revise changelog format
 v6 - Change project name from yosemitev4 to yosemite4
 v5 - Revise rtc setting
    - Remove duplicated multi-master setting
 v4 - Resend with cover letter
 v3 - Revise the bootargs to stdout-path
    - Revise i2c devices
 v2 - Revise the DTS node name
 v1 - Add binding document

Delphine CC Chiu (2):
  dt-bindings: arm: aspeed: add Facebook Yosemite 4 board
  ARM: dts: aspeed: yosemite4: add Facebook Yosemite 4 BMC

 .../bindings/arm/aspeed/aspeed.yaml           |    1 +
 arch/arm/boot/dts/aspeed/Makefile             |    1 +
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 1083 +++++++++++++++++
 3 files changed, 1085 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts

-- 
2.25.1


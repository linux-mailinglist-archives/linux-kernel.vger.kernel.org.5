Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5678C776EAA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 05:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbjHJDoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 23:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjHJDoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 23:44:32 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2086.outbound.protection.outlook.com [40.107.117.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C801FF7;
        Wed,  9 Aug 2023 20:44:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bWbWNNWoPBEc6ceij4YQARcJhk7V7yS0V5QUr7dIW1+cgY3lL7toeAwpSmfdO313ZgCkAT77AZ6CgnoRy0k5OKxSYnUpNPhyn/iZuTyVer0o1EY+Q/nm1a21TGzmt5uWFuc3SAwU0XRC3eRw4p3dGO5pEvI6KDv+F1DX/mke496VWV8mQDojQ3ys6UzQkn46b/6SChgqvsGpNUppfaCImBATYtyMvqn5bAEqLqE4C6Q3SMnQ2yRiM6bKGc2d/KWI624ERIjhjnXOvfIffo0NMSg/aaNZAh9klPP4KM9nd5bSSi+EvhO8WO5nTO8X/hvj2yuByFsje/AODYCeOq75gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ejM72s73HVOX/AkBpXIeXl3SPxsJfIxUPmywfGVowt4=;
 b=mfpguZFlt7T4NuYzU/+4xElUW+gr1T4NT2gHdrIkfZZbceAo3D4irkqM4EaIwt31UZs5fTmU18svoWbl8I6A0nC2aMPtmFr0LHLzmsBDaKdP4B67hI7oGGpaB0QObhGA+QFImgorRPlp3YisfSiMlP67KIB02qtvZvVcmoqnOC9iABrjSLiFXWjRxbpdaU7AEpjDmhA53JNkPC8+toc36sJxZ3kbOj8DWIRp0+JoIr9m8zIYYN3w2PN1dH6TMe2YtovJWmAr1T34bdvgWowMRza8/VdySBVOXLCn5xm8SnaCNznOrJkWfniE1NuIv9POv1+8gSUyu2SS2U4akhzRew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ejM72s73HVOX/AkBpXIeXl3SPxsJfIxUPmywfGVowt4=;
 b=zAzQcnXDBHJ+eUV8Vv6eUeO6si9+tE9uLBewZnmOIWlcRiBWa3U+uDa4hcQPsYCB3V2uAPtod8D3B4pmrhx0DpgBR77AJ7tsnzpuu4ETelQb46AAzJiUNz7ljJ5DnNSTkS7UbbMceKXLECxCmNCAOXnLVwls75tv16uGE+LPLoe79SmBwYZfGgBZ2rEVwQfU2hnUefcZR5s4M9xe2gQKhmUEV+ORt/RypCsBIpgpAz2TXHeoEmYKSbzhS5jgYAYPkjOSN4DMbTB/pXrtJ/mDKKv1gLS6eQjPD6japj7OAbYI3NcogjmSsya70qWS0Y0SocLiyEI0xotyILWLsKvrSw==
Received: from PS2PR04CA0016.apcprd04.prod.outlook.com (2603:1096:300:55::28)
 by TYZPR04MB6303.apcprd04.prod.outlook.com (2603:1096:400:289::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 03:44:23 +0000
Received: from HK3PEPF00000221.apcprd03.prod.outlook.com
 (2603:1096:300:55:cafe::b6) by PS2PR04CA0016.outlook.office365.com
 (2603:1096:300:55::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30 via Frontend
 Transport; Thu, 10 Aug 2023 03:44:23 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF00000221.mail.protection.outlook.com (10.167.8.43) with Microsoft SMTP
 Server id 15.20.6652.20 via Frontend Transport; Thu, 10 Aug 2023 03:44:22
 +0000
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
Subject: [PATCH v8 0/2] ARM: dts: Facebook Yosemite 4 platform
Date:   Thu, 10 Aug 2023 11:44:17 +0800
Message-Id: <20230810034421.742166-1-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF00000221:EE_|TYZPR04MB6303:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 115d3cc3-5071-4d00-7e37-08db9954163c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ij+ZjNefE+8a9Cll410ZLQXxPcvfTa439/VtGEzqSgIHIQzF4sWQGb1A+Lh3KWqYaHtEm0S38pt95dBN93+HbEIJcVJ5KuzJ1mOfH+KEN3RKaau9S8/ms6AhAoCQMDGVgwiZruvY4uS50ydBkoxoQl81oWAxZ1gOS7CA/QRiWACpQN9pAoBnvhwHhEHM/1/6jTLx9dmJDy6cl+/J1rUYiWNhlUE/kCCDSB88qGhuqyF3GdO9xanqHcKaDQKSxu+RnOsltgOtcDJ1CPZgbUj/56GlRuJOC2wSWwsOKolFnti3Co5KI9HFO/omCpfoxhPJFuJL53LLeqHI4DzyW8R5O5dYkU3jy1rWNnL/GEDAicdU1BJUK3CWsP9UXmYZDx31ezidHr0VkUxG7eZ4uckdZcRPV5CvtCw5hQHFr2WLGTtsDOcCPjPikbD6Jz5pH4RZrrItiWXtbi3xOOwfwg1XqGoeSmV7PK1CIX1sDOQ3hIGb9/3j2pzD1+9zc6FfUJhNVxcm2ncvmIZqv5Qr37lhjatno4/wJf0N4wn9G4s1Btj+6qmTnEG0deWkkQpiboRn4QrTVMPvoH08y+ZbrRXVsyj2eMG4TFhBt6XMhuffDFXEgSefcO8ioyE/kZJO7se59JPNcpMUPqL0UyvA20oj7JJG0BUmdXo3H9Ng9XF1dY8Wm6JgvkgtiKmENP1so4Ioe3Q9Wxvb2hq18owgpd/JEQ==
X-Forefront-Antispam-Report: CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230028)(6069001)(4636009)(346002)(396003)(136003)(376002)(39850400004)(47680400002)(186006)(82310400008)(451199021)(1800799006)(36840700001)(46966006)(8936002)(8676002)(36736006)(316002)(41300700001)(4326008)(70206006)(6916009)(70586007)(9316004)(86362001)(36756003)(5660300002)(7416002)(40480700001)(4744005)(2906002)(6486002)(47076005)(336012)(6666004)(36860700001)(6512007)(1076003)(26005)(356005)(81166007)(478600001)(6506007)(54906003)(83380400001)(2616005)(82740400003)(956004);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 03:44:22.9922
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 115d3cc3-5071-4d00-7e37-08db9954163c
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: HK3PEPF00000221.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB6303
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

 .../bindings/arm/aspeed/aspeed.yaml           |   1 +
 arch/arm/boot/dts/aspeed/Makefile             |   1 +
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 627 ++++++++++++++++++
 3 files changed, 629 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts

-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 505D576FE0E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 12:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjHDKFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 06:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbjHDKEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 06:04:50 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2067.outbound.protection.outlook.com [40.107.117.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FEA2118;
        Fri,  4 Aug 2023 03:04:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QM9rP/ZWcRZP9cyDJaApAfSoQy6RMBXA+7N0bLYH7lA5pIRfCXv2T+wUXwLziMG6c9Tp60gRN8DNJqZG0/+WjeAvO+YztqZb1KTf8V5Wl6ZX5on9vqGvKTVVc/gqNGfaxt0F/9Ul+3i77QnkzBZu8AfWeshYxPFHUmlMLJ4AxATLOAeUIs54OEzbInkLsUQJ2P98oiHtmDirHLlpWPvBr1rrUi3p6kWlwxKvFZcs9awuIsoF9uhmDc3LM3U0fQFBNHeAiSm2T0t3IcrhlOrVXQJoN6nua19Zi9TyUxPyvqL7klM1if3QL4rw8CajxF/Wp4Rk2laJrbjpgEiMnm2thw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I6Kmdm14PBGea0+yG19zea4h/bzJswq6HLOz29oQBg4=;
 b=MW3BiC/1nZQNFTxClgnGx8QXeNr6xzrDIKDZ1xdBx0A9c8Kv4KLaYOlh+Ek+YEtUl6kXccSpq1JAo4GuGzwgPCfaK6pGJm4QX7B5UBrTWK6B+fE5LAxaMiBQ/hlJNgoqwUaJb8Y9HHdSZvyNHXbeLVOK2ZfcSUqx8r3qyFMubLa1h+9D4NqdbyFHOGZIkL9A02ahoKLXS8qTq9zzuDQO+Vzx8hKWH1682Eq3oU/lXxKARuaMEnBiyKlGzPIwjkzsQbw4+mRYMZBXb90dY/djH2EHWq5EGRtzfzi7XzVsryIzke5uLLto6hsgQ/7Yi18HHOvqD9Z48spBFQBrERT7WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I6Kmdm14PBGea0+yG19zea4h/bzJswq6HLOz29oQBg4=;
 b=MS85Urrk0a1RXHcl58ygT51xPN0ZRPejimsPxNndMMqllkN1e9AmJoAwp2lutL5vp57/bYNETDaO1f/3huP50W0V0tJA+IhT5OinWS343U6qdkwtOOD0QdKsXyz6fZ55pRzsxa9bkO2Rgyq00GlgTkMzdQWpUenpKyrFJB6fwrDXRclTiaWx3TamigpZXXq3dsoSTWMaKwT0mVdStdBdijcCaA84TM3Kev3u8jFdLmwuqG3hXOK8QloUwCSvY2Ni0VFTGlYhm8C7RT06cGEiScFge7uLPlI0MlxWPBNtwaj6Duw8ILeh4B/0F/O0Gb1PkDQ2rp3kYsKyX2Pxr1t8Ew==
Received: from PS2PR01CA0040.apcprd01.prod.exchangelabs.com
 (2603:1096:300:58::28) by TYZPR04MB4432.apcprd04.prod.outlook.com
 (2603:1096:400:28::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Fri, 4 Aug
 2023 10:04:43 +0000
Received: from HK3PEPF0000021F.apcprd03.prod.outlook.com
 (2603:1096:300:58:cafe::25) by PS2PR01CA0040.outlook.office365.com
 (2603:1096:300:58::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20 via Frontend
 Transport; Fri, 4 Aug 2023 10:04:43 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021F.mail.protection.outlook.com (10.167.8.41) with Microsoft SMTP
 Server id 15.20.6652.19 via Frontend Transport; Fri, 4 Aug 2023 10:04:42
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
Subject: [PATCH v5 0/2] ARM: dts: Facebook Yosemite V4 platform
Date:   Fri,  4 Aug 2023 18:04:34 +0800
Message-Id: <20230804100438.1983745-1-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021F:EE_|TYZPR04MB4432:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6f1549ff-bbe7-45c8-842e-08db94d23909
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1ve3VDrzPe0TQEgitcnfLoIIKpnVEdvw+xyY5HO3ReMTS9a7THpCyomBIRtTdbJNhjFFpAe9Zl3p41bb0dw338vy986ng+QslgSipBZ/fytwayOM3A+uVf1WiPJkq462f0AZBEgcPh6Uw5LiUJenwV25YpgxiKnQoLOPpAEQ1eJR7QiTkFoKY/rlGZN4DdA/vJUpoyNO4KLLLScsQ9Z3Y2TW27DanD3vRDyJcQM1vEgUm8lIrRj/ROlewI05EuHJYn9+1L4snh9eBw9UtAVnskIcacJj5KnKRs4zNDHlYbIW5+UOvKLQmLufJWxZyPm7ttE5S5B6UPj2CiwTxu7M7B52f+qXW0gClmMyjveN+agcolhdl/T6GdV7iHQS9zRBdCJ22sNIdbqFATIq/m5XPct2S9zWF9VyHCFXHrJuXh5DAqAU/SUc+B+4oaXNZ0bYSwG4SuUTeEaOxuhPUkRsAGLsafAOkxkBAzqT92pFvo+8epqiJ9ug7MiRQFfIkPQ/RWgqVFIo2sUJStIZx3/oZaOndSRiKjqfIzSQJJbiuJaJuD9tqBjUPAb8HUXfQYcompHY73z30UqLw5WTLxSZEVjN1yRwv7RqSLqyVUi443OSPA87A3jO++VPBujQBDVqqSyyfjOArp8qHH/7GeNACJBMc76GHgAcNmDa3PS8NYSIdwfyA6bfnhv5REYAzSe9xoXNxqgmD5JlIQnWj5sR3w==
X-Forefront-Antispam-Report: CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230028)(6069001)(4636009)(376002)(346002)(396003)(39850400004)(136003)(47680400002)(1800799003)(451199021)(186006)(82310400008)(46966006)(36840700001)(81166007)(2616005)(956004)(1076003)(8676002)(26005)(6506007)(336012)(47076005)(4326008)(2906002)(36860700001)(316002)(4744005)(70586007)(5660300002)(6916009)(36736006)(70206006)(7416002)(8936002)(41300700001)(6666004)(6486002)(6512007)(478600001)(40480700001)(54906003)(356005)(9316004)(36756003)(86362001)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 10:04:42.1525
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f1549ff-bbe7-45c8-842e-08db94d23909
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: HK3PEPF0000021F.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB4432
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add linux device tree entry related to
Yosemite V4 specific devices connected to BMC SoC.

Changelog:
v5 - Revise rtc setting
   - Remove duplicated multi-master setting
v4 - Resend with cover letter
v3 - Revise the bootargs to stdout-path
   - Revise i2c devices
v2 - Revise the DTS node name
v1 - Add binding document

Delphine CC Chiu (2):
  dt-bindings: arm: aspeed: add Facebook Yosemite V4 board
  ARM: dts: aspeed: yosemitev4: add Facebook Yosemite V4 BMC

 .../bindings/arm/aspeed/aspeed.yaml           |   1 +
 arch/arm/boot/dts/aspeed/Makefile             |   1 +
 .../aspeed/aspeed-bmc-facebook-yosemitev4.dts | 633 ++++++++++++++++++
 3 files changed, 635 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemitev4.dts

-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE0A6773D7A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbjHHQSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232444AbjHHQQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:16:19 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2053.outbound.protection.outlook.com [40.107.117.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0696330F1;
        Tue,  8 Aug 2023 08:48:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gf3gOi2g3CKFxj5fGMVQs3MZr6VwEuDGiuH+Sl/OkuskE8yJQeOnfiFgnWsJlF1iXvwuB5N79A7ytnYdAesYelnyfBqNRGUFTwnYrIs080ovK6pxS/oyefZ1IbhElNwXrAIphoDfnupQd9hYOn9I5t/OpZTmSUiYDzNbrrjc8VouZvJodObS3M6S954fApy1SY/Hb8ZQql0hTH3DBF2yt45YBWxWxX8lQt5CNfZk8rN8AbLVCuPQuIDcA5P36m44op6UKeF8KrnyYknhdu1WQqov/Faw6/KimFVGYqzSE1uZuv3S/mfaKJ54SV7Tk5ZDx0JurE/0tZ/Uj56olqt6hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KsZPi+q3HBpCOzimVQ2fjPm+kgalowtZDG8YHoSCFks=;
 b=gXmJS3vzX9DwHz+DTiiP+fSs7BHnDb/e/YbnjzDD60yKSWaUayPlmxG9JhcHO1sRGCSTKmbuTIY8q/rbtfWfpVQGf9HzAZNrsGlgGFGIzm6BLgOI1jLvXFtrFdA4Ixv+sULqtebonw/VAexjSDZiXGyrIhdWznB8vkLh9LVP/EGZ4nL1OZLGHLSk/AmCZ57FI/hulnwd2THGF3k3lH0EpDXGM1a8dFu04uHzkjvjLir3GUz/I8J1a65k0pV76vMnF0zpftXyTyNgyRkuLRCa+totNcT7eUIFA3su7lOYm7ypiByAua94Oxjl+vEmA3ByUwo33LNFTibQ3E4D8vHZ6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KsZPi+q3HBpCOzimVQ2fjPm+kgalowtZDG8YHoSCFks=;
 b=Qlee3Oats0yQAL/9waI1d0CWFusxsdyjT1Ma7wA0HKyCEt7tX1t7Oxnk94m8KSDkizLu5YiFvadkFNGPj97Zo7FVvvErcFPznEgmJMLelBC7czM7zNy4oN5noXJLD41X/3wzZzY1JXv3OQviUHPrNQt0ZyTI38SoVIeBGndrIQfa8it2v90vqj10VCNGXv5vI3D2HV3qfD8+JmwA+A+r9V20A3neJyRBUCO0e5DCnt+UwEe6seRh571n8OgJh3luLD5pmkMzHQVOY8Qn9tJJFvBMDH/HzeUqtA+hlAqVZdCxOv7RidesKipu0igGq4NCgwI/UeNvp7dmKZheUCnO7Q==
Received: from SG2PR06CA0191.apcprd06.prod.outlook.com (2603:1096:4:1::23) by
 JH0PR04MB7227.apcprd04.prod.outlook.com (2603:1096:990:36::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.27; Tue, 8 Aug 2023 08:42:50 +0000
Received: from HK3PEPF0000021F.apcprd03.prod.outlook.com
 (2603:1096:4:1:cafe::2e) by SG2PR06CA0191.outlook.office365.com
 (2603:1096:4:1::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26 via Frontend
 Transport; Tue, 8 Aug 2023 08:42:50 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021F.mail.protection.outlook.com (10.167.8.41) with Microsoft SMTP
 Server id 15.20.6652.19 via Frontend Transport; Tue, 8 Aug 2023 08:42:49
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
Subject: [PATCH v7 0/2] ARM: dts: Facebook Yosemite 4 platform
Date:   Tue,  8 Aug 2023 16:42:44 +0800
Message-Id: <20230808084248.1415678-1-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021F:EE_|JH0PR04MB7227:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6596279e-8dd7-47cd-4d53-08db97eb729c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HRkp+z7f6PbkGL0AvO8RDxSePZkxdCjj8yArc2vy1YMf0GXvkqBfzSadF2c6CPFJKFEjZZF9aIdDkjbzkMrHhCylFpUDmsrv3DoHjdZbIVYJVA6MCANh/A7zo8Zcoy7jnvn/ndbgldAXlpzM4fLtpV0GM6OIrnK8uOBQGzVY9JpNXga33Lw7jyJCyvte/r/WbDpOOsLArAPmJIyjy0KwApaBg64O1qlUWGKnD+OdIUXu4nHNoDK7Cz8cswqDjJTc6PiwSPUEEy5cjs6Il9bZJQ1zu2fvzwdlJtwpejNQj6c4phrYCeyWNsT7TIHwcDrMDXT+TK2CSpVkjfrn7FQ1CCHtp143d47o3GryvxnuaZcV/4SQdCaEUnEQb8HcGbwcCffRa6I8gRRSR8HBU8prmw6qHYF6v5JTtBGci+Z80rqXHFQze2mC9JVSk6+FkaMge97Bs4uxaTmx3ZnXyUwv3W8KWC8q9H3Dp2l1uB1cxkiBJwB6EgtFFzKA0bxmfDJoRhMCHXYx68nsM89Sv+La2YTVk6fE3vs77XqwSRm4Uq+PheeX16EhJ9GZsLwtqYq0pCBN3gWUyPndRJHhfIWdNDtz63Sg4++jfZLiY/m9SZef7uD7saugF2SR8kveAfET7ETpCTdY3FEDk1CtnOYHuHSpXNPxYlLRNfhPHMQGiV9CQaxPwGpM1TSkaz89nM3PQUzLWQKFl4qdxw0StYhw6g==
X-Forefront-Antispam-Report: CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230028)(6069001)(4636009)(39860400002)(396003)(346002)(376002)(136003)(47680400002)(451199021)(1800799003)(186006)(82310400008)(46966006)(36840700001)(47076005)(36756003)(2906002)(956004)(2616005)(5660300002)(4744005)(36860700001)(9316004)(54906003)(6666004)(6486002)(6916009)(70586007)(70206006)(356005)(6512007)(4326008)(81166007)(82740400003)(316002)(36736006)(40480700001)(41300700001)(86362001)(8676002)(8936002)(26005)(7416002)(6506007)(1076003)(336012)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 08:42:49.6511
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6596279e-8dd7-47cd-4d53-08db97eb729c
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: HK3PEPF0000021F.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR04MB7227
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
Yosemite 4 specific devices connected to BMC SoC.

Changelog:
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
  ARM: dts: aspeed: yosemitev4: add Facebook Yosemite 4 BMC

 .../bindings/arm/aspeed/aspeed.yaml           |   1 +
 arch/arm/boot/dts/aspeed/Makefile             |   1 +
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 633 ++++++++++++++++++
 3 files changed, 635 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts

-- 
2.25.1


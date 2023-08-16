Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0C077D920
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 05:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241606AbjHPDgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 23:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241693AbjHPDd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 23:33:28 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2048.outbound.protection.outlook.com [40.107.215.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF1D30F8;
        Tue, 15 Aug 2023 20:31:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PZClmWy9AiO5fqFonny3sncj9zBQWuF3F6h/Ls7yKtQBw6efL9WQFLityAXzbk0y//S4z+Tfj9vmFonWv+HFzXUAbYZfsWFdy5LybQFYifOk7cKUCmuPVi21St0MZ7fOkR1baND7XBokLGJxGRO4KDh2nu0rYp8Ks1JX/j4lCJRvjdPAG3U1SovBE73+J1R9hnDuWnF+Ez8FnOCKWPX0aSXLIanXkM51mrPLgEqiDPOgvOVl6xvyHWPQKnWEghlPL2XbkLwpq95XGsHhU/W6Nm/54Mnaiu9/arlt7Nej3XC1iDlSgC/EFwHPYz7j1lNieqAC2t8HoEdK34fV/VJNSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H53+xw6y1ppEJj7t65dwlPjf7ukfprpesDdkDOIs3Io=;
 b=QK/NVbW19n8UUmUVJpyGWhJArMkfAm98xdPI7NhtgcD/RKTsDh+jPOrxc7EMIju2zLsTgjzddSqNiPHRzqPyQoyScpkOqisfHD58dQvWSAzfSrSprqx0WOBcOZHViqM+cDYWKQaA/MiEQ6YL9IkVwsn08nsqScaaNKE8HZHMCURAuXjcJVAdVOxuorsnSREkBFrSknGIP5Zv21QzXc7xQHQgMgHnDQyXmy9pwxvg0AmczfRtPlWtGjNy0DvUtd12SEsYhaKDTEvulKG0CJsD4VV7YG0oq80sEGGifC/jRTgtGhxH93C49jLGN6B2R+NR87B7qTUcPSqGR6GMBu9pww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H53+xw6y1ppEJj7t65dwlPjf7ukfprpesDdkDOIs3Io=;
 b=0urh74cSPgdDvsqmnIF+D14a4ngqAjvP7hsUlqTbPNqkFGIVSNs2005GMybn5CeRYS5D5xE3S/UW1EnOevi88H/NvNnOZZ3bGvJhezO2nIm5KVgugk8LCcqYauu9M9SNaLfF3Yo4mJ45UgCZkA890uuMnQNemdBghsb42sKOVeet3L586iTHRLs1CJSFuDGSFOeEQXzWH8bOdbqJGhclmrw2QvFncYX1FC86YWvxzFweG7putdexPjhte6V3IGT6AKydmj8zMsbxlvDAp2DCgENns1z1qMz17oxomApi6Zj8zOVULVRU1UJENwWQ9QMT3owZgNc4gZU73atLxaE6Mw==
Received: from PU1PR01CA0043.apcprd01.prod.exchangelabs.com
 (2603:1096:803:16::31) by PUZPR04MB6698.apcprd04.prod.outlook.com
 (2603:1096:301:115::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 03:31:43 +0000
Received: from PSAAPC01FT064.eop-APC01.prod.protection.outlook.com
 (2603:1096:803:16:cafe::f5) by PU1PR01CA0043.outlook.office365.com
 (2603:1096:803:16::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Wed, 16 Aug 2023 03:31:43 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 PSAAPC01FT064.mail.protection.outlook.com (10.13.38.172) with Microsoft SMTP
 Server id 15.20.6699.14 via Frontend Transport; Wed, 16 Aug 2023 03:31:42
 +0000
From:   Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To:     patrick@stwcx.xyz, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
Cc:     Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v10 1/2] dt-bindings: arm: aspeed: add Facebook Yosemite 4 board
Date:   Wed, 16 Aug 2023 11:31:31 +0800
Message-Id: <20230816033134.3750232-2-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230816033134.3750232-1-Delphine_CC_Chiu@wiwynn.com>
References: <20230816033134.3750232-1-Delphine_CC_Chiu@wiwynn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAAPC01FT064:EE_|PUZPR04MB6698:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 26aad2b8-73bf-410e-50e0-08db9e094fb2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U8jy/qnAetEx/UKzGi8ZXtfD9CJWIvC/Jx6UWXrGSUQqI4UGHmZcq1XzqrlYaVwziytkOAcFt7M9cKRxzB28Mb1XcSxeVhZMOpxahgHDMDMRYyuhhZ35Yl4t99rGLQ2Ue8y65hwxGrppIIowayxubTGFl47QrXuGMGxmTT+vz4bUj9yln04SnqqW0lYOU/ZE9z3excNS1urlJGR60DtXaYU1pKYZ2bYrlRrr06alzfROpPKAcR7i2IqP4MGIu7ZO5A/4sPVeV+kqUQVcK36W0tVmLfsOHLTNJroKBH+oJwDTcg08X6N4YUk3+Tcr08kyyCcGAMZlXkoOuSJG45dbnAgafv4Tu8E7iXMxTazx57QikMNyyWVd71EJxINHwfQXd3bEEQSmK8riBbQGBI4af8hRlcZb4M/1TYd0Kh1zZn49hxIN144GEZbInX2JJghPxyovej1qe+A/Jx+OreuH598xUdT2wr45U6RVKsuK35hzwIzkrTECMYnHZ8a7PXR1usXx0kvXzcE6NxzuBXIkAssXllgiY4qxxr4UN/tI2xDEl9WyvgEDe2uB0JhToITYXbdqdtcfG5plrRD27WqFPvGwEYslw890iqXSIUer6OcdK7o35t5Ccitw2fQxqwZhW9rORHBy2ajl+ekAc45yOgIRl+8p5e9d2tjBiv6qH1tzbOCemmKv/z7YIPi7vaPI718L0uebTrx5KFS2Ir9gjw==
X-Forefront-Antispam-Report: CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(6069001)(4636009)(376002)(39860400002)(396003)(346002)(136003)(47680400002)(1800799009)(82310400011)(451199024)(186009)(46966006)(36840700001)(6666004)(36736006)(54906003)(70586007)(70206006)(6512007)(6486002)(6506007)(4744005)(2906002)(478600001)(1076003)(336012)(26005)(9316004)(110136005)(7416002)(5660300002)(2616005)(956004)(41300700001)(316002)(47076005)(36860700001)(8936002)(4326008)(82740400003)(8676002)(81166007)(356005)(36756003)(86362001)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 03:31:42.5163
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26aad2b8-73bf-410e-50e0-08db9e094fb2
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: PSAAPC01FT064.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR04MB6698
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the new compatibles used on Facebook Yosemite 4.

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changelog:
 v7 - Revise changelog format
 v6 - Change project name from yosemitev4 to yosemite4
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index e0eff4c05879..23ee325bfed0 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -79,6 +79,7 @@ properties:
               - facebook,elbert-bmc
               - facebook,fuji-bmc
               - facebook,greatlakes-bmc
+              - facebook,yosemite4-bmc
               - ibm,everest-bmc
               - ibm,rainier-bmc
               - ibm,tacoma-bmc
-- 
2.25.1


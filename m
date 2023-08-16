Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8998677D91D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 05:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241637AbjHPDfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 23:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241675AbjHPDc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 23:32:56 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2084.outbound.protection.outlook.com [40.107.255.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C47A2712;
        Tue, 15 Aug 2023 20:31:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EB0zkkVoBAT7VmcIh380LXcpLkWCi088z6vAJHACJXKAQ4z57eKFCNbxwG+cwtz41zFmytSpbScdSkSfXRq43l0j7dvDT73b0D6FUNdo8VEeC6z2+XbnyhqVCdQwQud0ntF535HZYnequVJMVrfT74/yhyA1xaSF3DQ4YND4udp9iiuDG6KOqkPZw3J6aobSji8DVc7a6Idr637pkunZlaeUb2jw94E0AQSyBbNyEzXQoH7sjCmPkcemj1R8+Rw1uNcNORY981s/k0cgbfhBa2BP/uviz8ko1lkdCgkQIbn/EuU6+zRizpmuYBlmh5nVwoW10BZxF4f0qrKfE64MGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ATd8aUqFCTFkpiBNPDzM14dQZl5km+8PheWzRJoENeg=;
 b=mSIkh9gT6kd26sAeLMD30j5G5momEYQ+e0Q/FfC/Iu56fQjYucmMX7GtyS2UwUbA1rjEEwfPSBR5bmngqeaKpCUjiWFxzUQWKkYQ/mynNXuDEgDo5LDWKgKdh9bYOuDV9DT4a8Y+9bF2QPRPR5Aqunt4P2t42f86SD3x3bfMgSijuHwPLAgnLC/V1PxZA+OLiOD8c2D7ABu/SonWYeV2JpCPFUHBs+aBfNZ3U97UVYU8ugl9nFhxBL1t8Y/S+RMb4/wG4u41xEyk70UFNZgFIlQNVfCjtfabtyw3KAi9BAuPqyShlqS8p+S4LQAb5uHvjKvRXXRAFesjeJukJk5s+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ATd8aUqFCTFkpiBNPDzM14dQZl5km+8PheWzRJoENeg=;
 b=bAurM1hOB9Ux/ybFbqaE9hjzBbZb+edYr2lqe8w4ElaMsrk4UfR7MQ3nit8EIBxMJTjURR1C6x3nso9lTny3UNwN609hqMggnkMstLxHbvnObOirDNBc5kum+feRA1UYbvw1z5q8AOH+I2P8EC1pHTjFJJN8Y1enFRjK4LD1xXCnQtbcMCt0SZXL0x5JSnAfeZLqXu410eYlnIt/ASjZmRJHHO4ih3OrXudgqvHHOscVWNir/S4rre3sBhc4TRmhu4u9F8RLHd8N4nOOrIPrNfprJw9eEN9q3O/RWGfTNUVf6xm9/jjrxZyuNDcVQtWOlAOmHhcEJeLLaeHJE7rm/g==
Received: from PU1PR01CA0042.apcprd01.prod.exchangelabs.com
 (2603:1096:803:16::30) by SI2PR04MB5669.apcprd04.prod.outlook.com
 (2603:1096:4:1a4::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 03:31:38 +0000
Received: from PSAAPC01FT064.eop-APC01.prod.protection.outlook.com
 (2603:1096:803:16:cafe::52) by PU1PR01CA0042.outlook.office365.com
 (2603:1096:803:16::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Wed, 16 Aug 2023 03:31:38 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 PSAAPC01FT064.mail.protection.outlook.com (10.13.38.172) with Microsoft SMTP
 Server id 15.20.6699.14 via Frontend Transport; Wed, 16 Aug 2023 03:31:36
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
Subject: [PATCH v10 0/2] ARM: dts: Facebook Yosemite 4 platform
Date:   Wed, 16 Aug 2023 11:31:30 +0800
Message-Id: <20230816033134.3750232-1-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAAPC01FT064:EE_|SI2PR04MB5669:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 733bd0a5-e97c-4a2f-efe3-08db9e094c12
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PBg/S868v1o9aNfPq5THhev/eJHgN8qiIEGZJDn8NvvJgb9pvEQo9ZXXP0Joynf8ty1FkaK7nF21LglpPZxdncdL459RnVUAJzvepjG5yxJctAYFCyJanecdGNHlJAcH1BvQ9f2UukInZWC0Ygu2EeanHh0KddQc0VcK8RMWjbDpMzO9qkgmN74gX2wDZOjNCPg/YLvLwH1U9NU06CM2j1Ud4ORXPvo34WAt+RhwewlsZhMDFZVqV2AKxXQmbvE10p9GWAZqTnC91V129dCcoXb57bk/2G9wHQ3SO8yoLWT1HTkyMGFRYBxsdSy3TSDiBAybuSciIbbiBoN9pebSGmOwvw6GrcdBTaOXh2HUH0LQOPPhLe2QUncHWuX5b6p0SSqKJD6qNL00qsTa/szWEmg1ZbSaLEUheAWAh/f/vDrY8tFxcDaZhHKPHfG+PunQdSfBhozOXSnHjeyRAlLT2+4TIVXcyVr4N/En0s4ww4LkDnKQcGnLW0bcbYuMJj/6s9WeBKFU2R/Jw2Aj71qbH1fHRBQXmO2JsJuD8oNJaGEu8gKWfJMmhlGXe+RylXzcfjTYZM+eyp2ac1ZzRiAnuEBVhSrcERSKnEpyEIq/5NkCmX/Cdg1pNvkQkgjpubi13V2JDWHOo6oX+yOdrC4uNc+GupcDwVAz/HqSZ0Q5CcXpyPeumoRv1ohuat4aHOURXBPqtPZw/GKa65qImlZzhg==
X-Forefront-Antispam-Report: CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(6069001)(4636009)(376002)(39860400002)(396003)(346002)(136003)(47680400002)(1800799009)(82310400011)(451199024)(186009)(46966006)(36840700001)(6666004)(36736006)(54906003)(70586007)(70206006)(6512007)(6486002)(6506007)(2906002)(478600001)(1076003)(336012)(26005)(9316004)(6916009)(7416002)(5660300002)(2616005)(956004)(83380400001)(41300700001)(316002)(47076005)(36860700001)(8936002)(4326008)(82740400003)(8676002)(81166007)(356005)(36756003)(86362001)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 03:31:36.4855
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 733bd0a5-e97c-4a2f-efe3-08db9e094c12
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: PSAAPC01FT064.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR04MB5669
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

 .../bindings/arm/aspeed/aspeed.yaml           |   1 +
 arch/arm/boot/dts/aspeed/Makefile             |   1 +
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 624 ++++++++++++++++++
 3 files changed, 626 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts

-- 
2.25.1


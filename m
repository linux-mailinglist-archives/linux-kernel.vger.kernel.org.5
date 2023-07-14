Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56FD0752F70
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 04:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233488AbjGNCfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 22:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbjGNCfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 22:35:14 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2077.outbound.protection.outlook.com [40.107.215.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DCD9271C;
        Thu, 13 Jul 2023 19:35:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lw/WtHV7Lb7uvnICBhiufMQ4gs9dwcDKSOXwTGzFmig/QWwnGfJ5FyG+AguE2GgC+/B5Om8ei1n8kxrN5PJeVdxDvziEpYja7Vq+/x36rQocRTubc+a1L66ZvoGBZg52LPCTNeHYYnaQxU7yJcwpIb8mrqLX6j266sRfE79k14ON9RdwWukN4VfqRHIXTD87idaUj0R7ZHOto7JQtk4P3uMO1uB8nhF9QqZJ/F1Q3Yjqr5KMSyGIt3w5kNinzryGX07q4K12mOYf8iONB7X6wp93Wfh9zx6nanFfeXo7eVTpqNVICg2cYDguX/7gakycbTgGzQw19knwmCLsl9PmPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hRvFUOLRDG7CJiHMBjPEqlghbHz+dZewv7fdI22by4I=;
 b=Q/Ovr67L8ht7s2u/MI2UGeQhxaqzrfKlXEDueoVlDg/HvN+7LJx3ArN1Xq9lZEX748JL7VtbbvAwRkUnqmGQb38i2xchUrLFnZAFFxoykik/NKJdF8YaLErPa/cH5nfl3O26Y2E8ox1xq+vrdFA5/3Sq7T7vc2P5TWI6nRutwi9QYtgyPuPKAekazIrubYfypHv05/Q0bR/U944jtY0IywmFyWsVSdFfv/kBdwTnMJLzhIhArZ9tNZmRXtIE0c7oGR8Eod3QWXBIyBR8LtpZZFW09oPo8AQ4iJ4eVkPsUCB8+qUe49LrIPgjgKsjilnxey5XFaweONDo4KbsHhwAGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hRvFUOLRDG7CJiHMBjPEqlghbHz+dZewv7fdI22by4I=;
 b=fV1eHdJLVX0KVHU0dp34K/AYhNB6adnGZ9iGzdOg3r2dTePOrFNc4Dc1cgkD4nFfiV8ZXhBK23kCnrJhubpDRXLVFGv2cYrEz94Xt8iB7H64FAhLUnbtwXS1WBND1XN12+N2seYbFZNn/PpA8cKHuLJQ8nD6qh3aTX3barwbI0dNvKUggZOxPGJYr1kp2Lo4AnP4LdHDfkXA7D30FzSXlkvI9T0wREhkwuyK2RBoZGkJS+iKFngp0KB6w+GlQtQMFmXVuxVw6gGJ7bjhoWXEEAwmKtnQS2JTlUTiqrymqBV2La0vlYO3O4PI5wXsIuRQMQJuNRemKq4MsmUMshw6QQ==
Received: from SG2PR04CA0162.apcprd04.prod.outlook.com (2603:1096:4::24) by
 TYZPR04MB4495.apcprd04.prod.outlook.com (2603:1096:400:5e::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.27; Fri, 14 Jul 2023 02:35:08 +0000
Received: from SG2APC01FT0057.eop-APC01.prod.protection.outlook.com
 (2603:1096:4:0:cafe::aa) by SG2PR04CA0162.outlook.office365.com
 (2603:1096:4::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.25 via Frontend
 Transport; Fri, 14 Jul 2023 02:35:07 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG2APC01FT0057.mail.protection.outlook.com (10.13.36.138) with Microsoft SMTP
 Server id 15.20.6609.14 via Frontend Transport; Fri, 14 Jul 2023 02:35:06
 +0000
From:   Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To:     patrick@stwcx.xyz
Cc:     Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Add Facebook Yosemite V4 (AST2600) BMC
Date:   Fri, 14 Jul 2023 10:34:58 +0800
Message-Id: <20230714023502.3225096-1-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230712073752.54624-3-Delphine_CC_Chiu@wiwynn.com>
References: <20230712073752.54624-3-Delphine_CC_Chiu@wiwynn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2APC01FT0057:EE_|TYZPR04MB4495:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2917e836-f4e0-4ecc-471d-08db8412f01c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KSzN7y5zp9pZYxYKqwuRW1eZ22dKgK8gaZ+6UYafCrAx4ve8EfJnEbOYzgjFPMEJwtnW8U7/NlYGAVjRNMd3y29dEDEMOtw7UcXNR0nF9yjzKSqEjDKleELgGDgWpJuOX7MK9rjbjZe+k+vL9mpuEUAP4ffSlicTYnbnwhG1/25r7VTd60Wq49aTXWRF9UXNvhHN6SefRihlHU+8YjMB/q23QMHGh8PQdflTXkB4ibXQvWuvfoBo4amKKnLULht0lIeVl5jtz1pcFsj+vzBP6g55bRdJqYdBZ2DJXtLt6BY+Y8PFGVe4SPk0GPKAHH7hCaKtzele0WksVbSqMeLCGsyB3s8fWbSM1rwbJ6c0LeJ7va4JPMoLTVdeOpJTstxihNzzgM3OGrYmaD2arjMNhGwblStQjm0/kGS6VPjs6fnOqAKc1dYPiwXdynRXuaLwpfxYjqs3iP8t+Ge0i3SndfMPjzAHU0jDTEVhCr3fX97z8KjwTZ5ce1DUMlg/Z/GgAjaFbHy6s32OtXTf6ulv9Iowv3UZMImppBPc1H3dEtY35qzUWiDSY3sCNBwsAndtQJEL2mCPr/PW/bGdtaWj7cM52akNz57RYKkLAFyt949222mIaO39ViMjPtEX+dfeMrw8vwVI7LumsQToNHL6aTvqEnzpD0vZHXw0XoSZac/JznxQJvKpc2WJKXgrdzBj++VrPAdpnr+3+dcn90qNwQ==
X-Forefront-Antispam-Report: CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230028)(6069001)(4636009)(396003)(376002)(346002)(136003)(39850400004)(47680400002)(451199021)(36840700001)(46966006)(54906003)(41300700001)(40480700001)(7416002)(4326008)(70586007)(70206006)(6916009)(478600001)(4744005)(5660300002)(2906002)(8936002)(36736006)(316002)(8676002)(6666004)(6486002)(6512007)(356005)(86362001)(82740400003)(1076003)(26005)(6506007)(186003)(336012)(36860700001)(47076005)(9316004)(2616005)(82310400005)(956004)(36756003)(81166007);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 02:35:06.7282
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2917e836-f4e0-4ecc-471d-08db8412f01c
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: SG2APC01FT0057.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB4495
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2 - Add Facebook Yosemite V4 (AST2600) BMC

Delphine CC Chiu (2):
  dt-bindings: arm: aspeed: add Facebook Yosemite V4 board
  ARM: dts: aspeed: yosemitev4: add Facebook Yosemite V4 BMC

 .../bindings/arm/aspeed/aspeed.yaml           |   1 +
 arch/arm/boot/dts/Makefile                    |   1 +
 .../dts/aspeed-bmc-facebook-yosemitev4.dts    | 577 ++++++++++++++++++
 3 files changed, 579 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev4.dts

-- 
2.25.1


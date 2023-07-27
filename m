Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5AE9764469
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 05:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbjG0DfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 23:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjG0DfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 23:35:01 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2084.outbound.protection.outlook.com [40.107.215.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAAD11BF4;
        Wed, 26 Jul 2023 20:34:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MQjumIzOj7KeLm00IcVw7GORbr4EZTYMeI72AulWdURxKoodEI4ZVAVuAnVxW4FLk5zYGDSJPZooNb/Db4vq5VT4FpH90241IwgJsVBD3zqLdYQsY97waK5jtHIQmrBuOwPIsztuXJgkSJRfRA02etke1zrSR4QSp2956mvFlUbmXAjNKHoujzaKc6tZxmHgO7eFqTRac91RaqPLahdvlrdGkLaE4VE/BovuKTRCnQlqp+nkHi+rYc+DyKOnntqAB47y2y0e6F5Xt4eIuOeMx0qxnHBSK7n1XcZywkgYA5YwHWwQYFEwGq/pNU8aypk4KtahKEe5LxxszWrsvgxAcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FvwKzWDypqFoyT/5pNg4W+cTRPm+3P1A9+KTXwD9dYc=;
 b=jWUMy1/fdBAyFp5HweyjvGfVNWRwDfjCKS6V+TCQiP2OpUpjdnVDykyNbvgZ9x7LdRXdip69dISElJZq/nRbNFLOUiydZpekladRDpvNQSGdDXB8QVeQBMEbF6LnmUo8O2+oXZWRnzB0OHb3SHp6YuBAbUk6GuBwNpzMRFbU4X6WA/BJOL0r1FwTD19nGjHE+WiiCp931SqCq2zovkvzVTKQPoybLndeFHVOmrL0c6ajcxYUuVDiX/GObzaLsIPZAQDXYaJ7/rBsIc6zYhkVqchHWi064US2f7woq6Ovc7RZ8G/b0p4iuaR/tcCIVX9ceoW5+DDFge4Ew6oZLTrzXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FvwKzWDypqFoyT/5pNg4W+cTRPm+3P1A9+KTXwD9dYc=;
 b=fWqUP2JZpPxufR2fEHOwJwx6UNEkzI3GwCaapzMhM3hxtzBp7jFMudC6vegRUzeZ7LmTxvaU139ENOFk4B5ulWcBs7sPnrqKYTjkSS7sAv4/mpqn8DZNGM6tgsuuzwatK4FT9W8gMtTDp2+KsMN92fqpt1vTDazgo2PLQcIvyC4XQFEnn/fnG/dSsf+8OFBILPsu1g4XI2T9VOk9y4z/royp86H0H6Sjq/Psp8bMx9jsyew0/k88eClMQKwbNCT1t7VXK+TL9Z4tjLmz5I/+CB/nrivdJX62bXghDwKOjXPN2xroXyRPDLUtLxJtAp1GssFtEMB6kwFCXfvDHFEiAw==
Received: from KL1PR01CA0068.apcprd01.prod.exchangelabs.com
 (2603:1096:820:5::32) by KL1PR0401MB6609.apcprd04.prod.outlook.com
 (2603:1096:820:b7::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 03:34:46 +0000
Received: from HK2PEPF00006FB3.apcprd02.prod.outlook.com
 (2603:1096:820:5:cafe::30) by KL1PR01CA0068.outlook.office365.com
 (2603:1096:820:5::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Thu, 27 Jul 2023 03:34:46 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FB3.mail.protection.outlook.com (10.167.8.9) with Microsoft SMTP
 Server id 15.20.6631.24 via Frontend Transport; Thu, 27 Jul 2023 03:34:45
 +0000
From:   Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To:     patrick@stwcx.xyz, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
Cc:     Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: arm: aspeed: add Facebook Yosemite V4 board
Date:   Thu, 27 Jul 2023 11:34:32 +0800
Message-Id: <20230727033435.1904180-1-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB3:EE_|KL1PR0401MB6609:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: aa38e969-0bd5-45e5-f487-08db8e526c6d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PbRn/u4NZdFO0OSJlYJa7QpEIO2rtj9p692Y5q/YkegTBZcBRtWqz52aMOQX42blpA5GT5psqyiGN4spubsgCJLySuvhwzrI0he3TJuiuCF01I2rIn/qb49iPoOHIHnSu2tf6/FVVLkvXHK1SFwu9NrV4wOiFIfYJvFmK37XSPQWABnPN9lexpNWflVGGV9fJs/3IgoIyiE0QZTyDOlohVPfmCNZYzVB3UdY4ybJb1TL1VKZw6NCMW2Z6yD4ctZ1rQEpcfmgwUK4MXa+UszEAPusDIeJZjoav43EIzPK7SYHenKwV/Atk5S+pYUrg+Ywi0MF9ZUvZvNyGp/iVYnbamcjgVbLuGosLW+SRDzxCBKVYbHVxG0IWFtmYWt2n4Y8ptQsBat74eMHiltcUmJ17Nbw4I6J8ZcXlsUYuOOoo0OcrKJFI+Scwp4w93fWej1jatUblFsfXqeESAk98tMUbcWPBAwy9RRQoO7O9L1o2d9VL9rV4eoC6egt6LgugvYxRBjWcsf/JtDgRn5ESHe6ISQ28ByonOLwZ3eXlop+SJcVnaz5M3axxyCLRd8SgnYvFyR9BZZYqYEWxf3Gs+CUZtGqsXqASZO9LJo5rexb2gay6z1+lW2IVNYFsXF0HjPC7dStHpgy8E0YwErBgQDDH8LkVVPZwIoLrHgwVpn9IJXyydm2tqmj7Iia2zaF2Cs9xHVla0VA4Y4+viwb84XEdw==
X-Forefront-Antispam-Report: CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230028)(6069001)(4636009)(39860400002)(136003)(396003)(346002)(376002)(47680400002)(451199021)(82310400008)(46966006)(36840700001)(6666004)(6486002)(478600001)(356005)(82740400003)(47076005)(1076003)(6506007)(26005)(6512007)(4326008)(110136005)(81166007)(70586007)(70206006)(186003)(336012)(36860700001)(2616005)(956004)(5660300002)(7416002)(316002)(8676002)(8936002)(41300700001)(36736006)(2906002)(4744005)(86362001)(40480700001)(9316004)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 03:34:45.8321
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa38e969-0bd5-45e5-f487-08db8e526c6d
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: HK2PEPF00006FB3.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0401MB6609
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the new compatibles used on Facebook Yosemite V4.

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index e0eff4c05879..2ef6821e3648 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -79,6 +79,7 @@ properties:
               - facebook,elbert-bmc
               - facebook,fuji-bmc
               - facebook,greatlakes-bmc
+              - facebook,yosemitev4-bmc
               - ibm,everest-bmc
               - ibm,rainier-bmc
               - ibm,tacoma-bmc
-- 
2.25.1


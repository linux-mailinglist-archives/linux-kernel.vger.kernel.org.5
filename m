Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43C6E773D7B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbjHHQSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232457AbjHHQRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:17:01 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2071.outbound.protection.outlook.com [40.107.117.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83CF9358E;
        Tue,  8 Aug 2023 08:48:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O2FXpjMYMmVt0VVbbZjKXssiN2NuqhZYdJjkAngvBNKSbdrDQNqZgvWqBOPHQbJwB0hRrccVwQPhYd/zsSbtNaThXP2cy19W4edUpYnkIbOU1DLjiNBrTSEREA6q2R4C7DkUdtvzSr9I7V9UXQBItpOgSksGr1pKVC3lOp9X08FZ5hmLrgbSzhGmCxY+Xf4y//6P19zdtU5R73I/8tUbdMl67lzQ6cnRanmt2b//0jEDBt76Ec/m7OjK4LAXgKDf0TuNDbJ/LNNLnUWNfu36pjN1J6slMAACswFQ8fEVFlu4pjy35ZQyc8zkB53I1gn/bb3SNjVCzhhKVUwQsXqTXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vuTIDIUObtSe0i+uRKLlqdNmsnHFdANzVapwIuBzESM=;
 b=Fgzo6Np49N6yySjR4YO4TQuJ98WsMrvIV5U+UtXnvNPqQKQsTevY9qS3gtxKixXxvUlBWRIiYLg8prjAZLfNiLEpCxCDsYiEqPMRlLFw2VrPaTGd76vC5dm7ohIl/eZKhEEFidsJYDzOcLiBGdlFV9GQEj4UrAQS0geJxDj8rgjo4ka9//iXovkdbZfi0Kff0hsQXSBVAJlffKQG4eMapqcunErWp/ZP+cgqtDpIvuZA4/DWIj4L2J8tT0mpSUXmsXp8ip5o5FOHTcXKZTbR49XCZL35WKv/sEyJ6lkzU++zEoKSHQM/2p6W23dDK+Iv9sUj7DIdCsIB/df3L2MTZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vuTIDIUObtSe0i+uRKLlqdNmsnHFdANzVapwIuBzESM=;
 b=YGQPqdnLyusfAF+I3OcreD5CM/8SW1867iOlo1HCMP22BNftVk7YESMlBe7tVjqeBHiRtw2k4ATyU3eFhalp/9HbXAuJ82XPzlMZvLSgYzH8RANRtvfX2+Z2RLPoa0G9nB3xM89Xbc7bbhDKdOEK+/TJ4+8isPsqocZ5O+9ByzleuNSo+cDSxDJTqqd4j6nL1DnpSu4yCxeIKrZ4XqHilFLV7LH2KYqeWK7geF+2G/FCiZrZohVtreSGj1E7YFM/YJ1+5/uB/3tnrrpHpPg8LeZJxiugYS2PZERf3UoZVLl1vcHSWcwRJUPZc/SZObmsdQQryQ6bedkOSBlj0wu7dQ==
Received: from SG2PR06CA0195.apcprd06.prod.outlook.com (2603:1096:4:1::27) by
 TY0PR04MB5717.apcprd04.prod.outlook.com (2603:1096:400:21f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Tue, 8 Aug
 2023 08:42:54 +0000
Received: from HK3PEPF0000021F.apcprd03.prod.outlook.com
 (2603:1096:4:1:cafe::8e) by SG2PR06CA0195.outlook.office365.com
 (2603:1096:4:1::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27 via Frontend
 Transport; Tue, 8 Aug 2023 08:42:54 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021F.mail.protection.outlook.com (10.167.8.41) with Microsoft SMTP
 Server id 15.20.6652.19 via Frontend Transport; Tue, 8 Aug 2023 08:42:54
 +0000
From:   Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To:     patrick@stwcx.xyz, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
Cc:     Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 1/2] dt-bindings: arm: aspeed: add Facebook Yosemite 4 board
Date:   Tue,  8 Aug 2023 16:42:45 +0800
Message-Id: <20230808084248.1415678-2-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230808084248.1415678-1-Delphine_CC_Chiu@wiwynn.com>
References: <20230808084248.1415678-1-Delphine_CC_Chiu@wiwynn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021F:EE_|TY0PR04MB5717:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9c063fe7-b265-4b77-9153-08db97eb7548
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 505GDQi6QlV0OpHUVUvN/+8nKaxwRfxtOjq3nP5OlMpBJ4brGAsb3Cpq7X/Y7s5rV1CBZ1rg0he7TeJptFPjUe+FDPCCpbIKc35nNyC1ZqlOzM0hOObBY835/tXlXJSKNUvih4vhIE+5u+I6wGQUwjmAcayMBfvFhNmKLbE4Y+ClbuKVTFeQyh1HIXZR2loVl56hT3HYN0cIiroG+37Be+JD48+XS3N3cMtoxrn6Lv3UVo2LVWEE1zKWU/P0tpw18rG/Kg6gXRup+8jzzg3Qqz8wR24ih+agRwsgRv1V+ZC247sYNXH76s+/pssnWX1jANCa6mLkXUenp0jqBHrfI/2qolMc/QSzlwgU9xgRe0bhoW/H4IgWgasBCo1KijoRJ9CnsA3hj47LBT7jcXcIFBor26eDrq0vZQ9hxpZbs+W67oneRblPsR4usKPRXaOWgRqOj665CNwDNzAVSEo6CywYJVpfv3zSFlEutPzPZ9a9dagM5iK57cY9hsV5SNJoqEYemx+ZPTJHyOxcLuB6FRAnPNSuHX/R7j4VZi9RZPgs6Lr4xfzoKGKExq04jIbg/vKkYFCNrv4wBVYZvBfzHzfZkbGeEP0Sx7EI/3kDtWMgAxNFeayXiq0ODOOjW/F/qlgefNaP7Nu94x6BT4Lp/IjGKRMdY57HPCwb0SuyiIN8Tvw37g7MDZTpuBy4stfedZIp96E2mznsDZTV453CnQ==
X-Forefront-Antispam-Report: CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230028)(6069001)(4636009)(396003)(346002)(39860400002)(376002)(136003)(47680400002)(451199021)(186006)(1800799003)(82310400008)(36840700001)(46966006)(40480700001)(478600001)(6486002)(6512007)(6666004)(26005)(336012)(70206006)(36860700001)(70586007)(36736006)(316002)(4326008)(47076005)(110136005)(36756003)(2906002)(4744005)(5660300002)(86362001)(82740400003)(356005)(6506007)(41300700001)(9316004)(1076003)(81166007)(2616005)(956004)(7416002)(8936002)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 08:42:54.1512
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c063fe7-b265-4b77-9153-08db97eb7548
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: HK3PEPF0000021F.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR04MB5717
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


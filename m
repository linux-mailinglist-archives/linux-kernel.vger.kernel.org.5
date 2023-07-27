Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97518764496
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 05:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbjG0DyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 23:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjG0DyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 23:54:05 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2077.outbound.protection.outlook.com [40.107.255.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B0726B8;
        Wed, 26 Jul 2023 20:54:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FMl6vmjIvkIPvXakP1394jB2kmHZdFxQ73O/XmIR8gvi94/JjinoymIgVhRXQQm/Bc7Bh2GlAMxJa+FVFF6NTSq6WQ4sJIBMSETF5WtDeL4pzIVsfLIfxkW7Y+7ODg3C3tivPSFw44CZFPiytrxEYGLxhThThOUtTFgq96OTVCmGDhmXOfc9FsrHGw/pZt44OegPe2dvlzTtjnJByW+uwTkHBuArBUIL86TwfuI5dQ5dcVDtUDlxzQHMIZvyDbK65E3qntrySjPx8TYFEH+JI/aP93lxbpV7Pf1RTAsqL9fbWxLE4M9CzQ1O6ACzzgvWYLEy+nMo/rzzHyvtzRJGww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u+44Ya1rfNIyoje9DhGQK7jKOzFKKBC1l3WjDp18DPs=;
 b=VlhpKYea7/PgME2ys8vUD7my/SeSs1V4bTeJj01/TzjUAlJVOLaGw4nUiZ/4x9IO+G/iA1VzAlOW/oWr4ysye/zEwcudTYKkdNfkAzJptwOAldh88YLrKfWJcQFIoqeNgy9Azd6mmCT1dclcJL4dI9EJ/Jzn3tNRvrnhMcBMNNP3TVXVim0tFgxeFE7d0ubwdYbc0BpACH7u3aXQ0whWh6fZffmjBYGmdyVZd/lVHn9MjUaN+oD+AbA93beZ6ndbhXV0P0NqoQeXZnueDsGmLM5YbNayJ6z0f2xV8eBZ1ATOMtTOTp5QN1i/BV2hCgvJENVJ27dyLyiwW34yOaP/UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+44Ya1rfNIyoje9DhGQK7jKOzFKKBC1l3WjDp18DPs=;
 b=ve+4sWE1C9AAdYdN8yUPme681OZKkw1d41CEks3Y+2ga3XFiDEc2U1PghnzDY7w13rp7CPh5iwtqv2ZIhR/R+GKMfMT2za5SkIb+PCixGr7fofeWI94iZjXmcpMrv9aRRUd1uXNCRQHSYwdDwyA6bGm6yGu2yLLo+yDobWUV9nbGFd4z2oBNKApyj4BR7UnCqOvMFALZWg5ytIlKqtt3VDPA1BivCJFTRNBlPhBx3EQ1s8veMiiBoP/JJ2tCTaYl4iQEfxLsXCntfHfta4hRu2+GdtYsXhV1SxcSihQ8cGDVOG03tNeQDBfySvL1CdaJV4SCGUbeTRfkyK6HuzwReg==
Received: from PSBPR02CA0012.apcprd02.prod.outlook.com (2603:1096:301::22) by
 SI2PR04MB5751.apcprd04.prod.outlook.com (2603:1096:4:1e2::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.33; Thu, 27 Jul 2023 03:53:58 +0000
Received: from HK2PEPF00006FB4.apcprd02.prod.outlook.com
 (2603:1096:301:0:cafe::56) by PSBPR02CA0012.outlook.office365.com
 (2603:1096:301::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Thu, 27 Jul 2023 03:53:58 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FB4.mail.protection.outlook.com (10.167.8.10) with Microsoft SMTP
 Server id 15.20.6631.22 via Frontend Transport; Thu, 27 Jul 2023 03:53:57
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
Subject: [PATCH v4 0/2] ARM: dts: Facebook Yosemite V4 platform
Date:   Thu, 27 Jul 2023 11:53:48 +0800
Message-Id: <20230727035354.1906590-1-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB4:EE_|SI2PR04MB5751:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: fe72e879-b8e7-4db7-cb67-08db8e551ae2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fFI1Hh5OmUNsx0XCskljkIGgAa7BPsKLIE/UnMGyMt2YUkBMW/u56pgPGiMeANRqQL0qCJz3kQulRLYK/8aQXwpj/56ot+2HRHaK3YNvLbqhboHaawaHDODLC9694JUOkBqngzxGQTfjQDbFmkQNEe6mQbUdJjf1HUkosXC5xFF8GSClf8qqxi+O1vOk48ETd6GM1fft1Pe2BesE6SWHwM2xg/x1f8kQBUuXeZk/K696xqcuREMLZNnmM3MgddvY7JHWNelhtKj7rbFb4NKlQ/l2FU5AZD7nGRguwTI6GS44MSFi+SpV0hS8rZAN4MhImYmRrVhawGeLYQI0V9eGrwQ7EM9aloL0FhlHFt2yP59GPj3/MTqStSG1FtKLx7ZnxWc6LEPJaZ4xKkMXJjawYyvix7KdIyZicgLN8amluUaQS4eQwbKEAXGxGB57OpC6AbrJyfuy12wUU+RmYuQcCBeApyvUy7GyAORpiPiFQnk51a2K2NFyuCF1f9uFLGUTd4yzlwZneaBhcJ8Oc2UAMLcxQFwBglDlW28yOVNgb3fe741IyLWvamZ/lMSU4txlb9Getjdy2H9P+PzVa7tIO2J3E9theFQ25/A3CyvNFXfu82f3DzeGVEQf4M/BJTFEd1O2aU8WcdLpnD4NzRHZJ8EtaoE9mm/mN4zBssRy/ni5vlo6iHI8jI3FzXnM13QdiYQQm16pgwFzGaRoNfJUiA==
X-Forefront-Antispam-Report: CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230028)(6069001)(4636009)(396003)(136003)(39860400002)(346002)(376002)(47680400002)(451199021)(82310400008)(36840700001)(46966006)(336012)(1076003)(186003)(47076005)(26005)(6506007)(956004)(36860700001)(2616005)(6666004)(70586007)(4326008)(316002)(36736006)(7416002)(8676002)(5660300002)(41300700001)(6916009)(6486002)(70206006)(6512007)(8936002)(478600001)(40480700001)(4744005)(54906003)(2906002)(81166007)(356005)(9316004)(36756003)(86362001)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 03:53:57.5148
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe72e879-b8e7-4db7-cb67-08db8e551ae2
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: HK2PEPF00006FB4.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR04MB5751
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add linux device tree entry related to
Yosemite V4 specific devices connected to BMC SoC.

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
 .../aspeed/aspeed-bmc-facebook-yosemitev4.dts | 640 ++++++++++++++++++
 3 files changed, 642 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemitev4.dts

-- 
2.25.1


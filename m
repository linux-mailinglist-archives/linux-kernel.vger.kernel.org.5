Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEFA47AA932
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 08:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjIVGll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 02:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjIVGlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 02:41:39 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2044.outbound.protection.outlook.com [40.107.255.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC42C83;
        Thu, 21 Sep 2023 23:41:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j0MBVoWoPOxUXAsFEMDXo7bE6ptifOl8L4tIN4LreF+ExRhpyJsNAeysY1FpTfLHvR4mKTKgXs6u5xSGNUoGt/fa+nAe/r68lIEARNct9oCMw9lKTZm2/9LivHJnj0MMuudgxVf0SGMLOvoU73+OjRf3kXec7LcxcGNABzwX7fxwEE0lFf7TvhIGxeoQxE5SwNB99Jl4okOuv+yQZaXMN314k6T4Muk7RYzdn8C2lgUnPuGiz62IrvQlwOWiQMRfeZYvv6d854KX9OHdaLx40ZmD0fMg7NVlQz0sYMeRctGgR8rKWI3qdQEmfoTOw/TO0IVwK1TLGnAprYXCaEfCNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YoEKmYm/H6yX86Jc4JpKNCVSZVIXN1SOiJnARtuPyBs=;
 b=ENqCb8vdiX6A+WJZyR2WxsIU0gUOY3c6Y2Olz0PjbvxNILM17K5yE/DH0EVpCZ8RIqq7yfLXN64hie4S4C/ObDmpwuxsyHEolbM67OBuTnWwTxSymESkocePwDRzODAaJ693JqcrAkILRTPfQGHcDEVRzrMpigONPt+CKEudEVBkpPJ9R5Q+BsAUxxlzu3THgbbIhMrSqrBlsBT6kk0hb6vWut1cpmswZqSWnmHjUZLc9lZ49N2Q6IDBh7t5k0pR77KsBK53ZBzSALZEIhxXXJ0DVSthrkkBGjUKJIY7CBFAWdDiacl9pHeSRxmj2y+FdwqjdlxptPLE1c09jNMtbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YoEKmYm/H6yX86Jc4JpKNCVSZVIXN1SOiJnARtuPyBs=;
 b=xiahYMy1VvPCJVksK/FgXjDiT19sEEeH4fJQLzdCR+czL+hOve6q+qv1Dy7JGRCpVcAP47na1P8Hz0nCOroEWFZiECZYWSGrJh+jO9TwPekmmhkDvN64aB2do6Pd1x1SrkrqSrExgVng2QkFGYRdTbMM34qbYQqdV2zuYsJRbJ8U4jDmfZ0tJ5WqW5zA2XCHGM1zCsD7TURdIJ2IQ70b87Doykui5XkGTJmj3i9JsJAe/4qMAsTapfSlQSaouGKxuk5lwbOvYhkfHKkUfGWBnICjFCd3LMYDrIwTPIS5iiqW6TD21RpAx9EaIYhyPHjGWKBAbdyRFGjGo+2VfvsKtA==
Received: from KL1PR01CA0120.apcprd01.prod.exchangelabs.com
 (2603:1096:820:3::36) by TYZPR04MB4431.apcprd04.prod.outlook.com
 (2603:1096:400:29::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Fri, 22 Sep
 2023 06:41:30 +0000
Received: from HK3PEPF00000221.apcprd03.prod.outlook.com
 (2603:1096:820:3:cafe::fd) by KL1PR01CA0120.outlook.office365.com
 (2603:1096:820:3::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.32 via Frontend
 Transport; Fri, 22 Sep 2023 06:41:29 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF00000221.mail.protection.outlook.com (10.167.8.43) with Microsoft SMTP
 Server id 15.20.6792.20 via Frontend Transport; Fri, 22 Sep 2023 06:41:29
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
Subject: [PATCH v1 0/1] Add devicetree changes for Meta Yosemite 4
Date:   Fri, 22 Sep 2023 14:41:25 +0800
Message-Id: <20230922064127.283625-1-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF00000221:EE_|TYZPR04MB4431:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 848c43d0-ccb2-4161-2dc3-08dbbb36f3b1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: scTCEnkBDUW6hXoyJy/2TVgKil/q1kgCHBuoMFRiTUFSzS0u4Gm7UZV9fzmjkd3TdlM5GDcYfAki7sSIzc0T0Rxfu0FpcQtPIPghApxQglqjbqRnvlvzFuAE6rLIrEaGtFliCq0pyU4isG4I5gZbGPPYwhqtDx7creCYOyc7d7qek+CZSrJ7S3rL4aVXrDpdh4h3Hg2YlzZSw/AkTDeAPLzp3L6UVWO2YwzxSIZi0Yo8cqvTl0mnIgdiUgRNIyR6ZI9DJHdy7QUUXgSZAjL4yH+cYuFyu3ERWiEz4MWp5npeJbYQIjYmupZdBDNvT0pa9mxL5fXR5Rxnn+TvzsrFz4f1rZY6webxv5aQIKLEUwusUkg0c93SfdewZk+rgE3J89SHqQvh51ajWiG6qi/wZ0sXpZjU7zIn09Vg3zN4kJCC6jcksFbpLE2SuZzGZRBr7sNRNvAZBdPtS/MTSbfVEO+4FdFjFt3JcJ8HXTBNcTHOQZ0Pk6mQcl3EFyJ5GnMcCZh8kg3ltEjFYR6MJKhHBrR/rsVo+5FIeWdTwQmvrw8ub4HuYxZwGuM6AhiQvjoDcKKvjGxg7nbcAZp/c86RH/mGrL/t8vsKh3k6A8g3C5VXkTF0WPBgY7Wf5wKhXQucud2DKhAmxLuPxjXnYtKUFq/j5QSlgPHjknQ/KV8WzdzNMboXVYwb9GfiQTclRd3inNeaIEE5amKuwNy+kHRWI8oHPzDMkynGSy2V7cKaz0bq8nT8tTLb5AULYPBdXizA
X-Forefront-Antispam-Report: CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(6069001)(4636009)(136003)(346002)(376002)(396003)(39850400004)(230921699003)(451199024)(82310400011)(186009)(1800799009)(36840700001)(46966006)(83380400001)(2616005)(956004)(36860700001)(26005)(1076003)(47076005)(36736006)(40480700001)(9316004)(336012)(5660300002)(316002)(4326008)(7416002)(8936002)(8676002)(54906003)(6916009)(70206006)(4744005)(2906002)(41300700001)(86362001)(478600001)(70586007)(6486002)(6506007)(36756003)(6512007)(81166007)(356005)(82740400003)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 06:41:29.1972
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 848c43d0-ccb2-4161-2dc3-08dbbb36f3b1
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: HK3PEPF00000221.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB4431
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree changes for Meta Yosemite 4,
binding documents will be sent from corresponding driver patches.

Changelog:
 v1 - Add gpio and eeprom devices
    - Enable adc 15, tpm, wdt2
    - Change spi-tx/rx-bus-width to duo mode
    - Add device mp5023, pmbus for Flex power module
    - Change ina230 to ina233, pca9846 to pca9546
    - Set adc128d818 and max31790 config
    - Add jtag1 and gpio0 config
    - Separate binding dosument to corresponding driver patches

Delphine CC Chiu (1):
  ARM: dts: aspeed: yosemite4: Add i2c-mux/eeprom devices

 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 897 ++++++++++++++++--
 1 file changed, 843 insertions(+), 54 deletions(-)

-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 845157DEB55
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 04:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235395AbjKBD2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 23:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbjKBD2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 23:28:51 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2055.outbound.protection.outlook.com [40.107.255.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371CD9F;
        Wed,  1 Nov 2023 20:28:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eoDUvUFPpjWItJZYSQZZNtckGo0SJzAQFmt25Vo+zcF5if7nkynXdHhGR9S49VJZwFB0yBeiyeo7nB3ZNPTA+cmnh7tH6MWoDBhwdqG25BYWFKSp7JIGYHtECZetJgfKgYutwTTPlsmaJWnH3Wk6axUbEsy4Hv34uwwhcuACG+K66/DN7YpXXlQi9z2X3wWi706Y6550L+4c/hmW/ZNmRjFmlRNzTALExQyEQwgTUtO43NooPtKnvl9ksgxJ+Q26qe/vxLfp/RgbPuIs037MjlRRN1AwU5gWK/u+z5T0omkIUAgntkQwjNk/IPrq/b2HRxrJbq73bAtwfPBTPafFkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RE0Cr8SKYUNobX4lN9yreYfkeYD53klnk59YxgpJZ+c=;
 b=YjnfLyjy/zsgJEcDyFJZgYjDWx626nnI9+TTpGaBikewDPh2XM2Fww9rU6hLmsMAFizPVjDu+yh/KYNbh8gkoEc92qfv462Nb2fVTKM8GyEEpEM67SPqd8CIElMmeJurgzMbuOFUJsl67dar/elJ/44LlOr2EzThFffbA9S6oG0bqWRzEqr61w6fuW9DXk3XE7D9sTbq7lPuDaj33liYDpLbsdGTDmyE0eBdpmFJ7JcdGeznRLReLhEjNOWGXMSSgkPrxSijdPiA3Svt6bCQvGbFuRl/rvuo4ZwFFFGNvy5rX4CgHeqd4ZFiIVPPh0v732KBRERG9+bR7Vuj2qdF5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RE0Cr8SKYUNobX4lN9yreYfkeYD53klnk59YxgpJZ+c=;
 b=i/FSLVWDronw1w+kJsmahnThwgvh1tse3TzpgasN2ZvbqpH8UDJzHw5AxUu8sAIy+UHOZAm5gazvUz9VOlRoR1WZMz73/aXUyvXJVhPYLql3LUmWHTWXniVq8d3r8BZE31CqvdUFDyvYgc3qhieEDIpGi9YkS1+b//mw7KWpSWT8RJWrHsp8qVTWdjuiNPSUXbPQ7nSu5lFA/bUQQTVJha8js573YU8Ek5Ex4rheOPAC9jgenQjUD56ZwN7WYuFq+eIn9ZDxHOtc/H88eer9U0IfgUwWA0MS+oJTluLRk07PiuUIpu5lht06D3PJJWD7Q1uNZm1zton98F1S/f6zZg==
Received: from SG2PR02CA0011.apcprd02.prod.outlook.com (2603:1096:3:17::23) by
 TY0PR04MB6469.apcprd04.prod.outlook.com (2603:1096:400:275::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.27; Thu, 2 Nov 2023 03:28:40 +0000
Received: from SG1PEPF000082E1.apcprd02.prod.outlook.com
 (2603:1096:3:17:cafe::27) by SG2PR02CA0011.outlook.office365.com
 (2603:1096:3:17::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19 via Frontend
 Transport; Thu, 2 Nov 2023 03:28:40 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG1PEPF000082E1.mail.protection.outlook.com (10.167.240.4) with Microsoft
 SMTP Server id 15.20.6954.19 via Frontend Transport; Thu, 2 Nov 2023 03:28:39
 +0000
From:   Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To:     patrick@stwcx.xyz
Cc:     Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v4 0/3] hwmon: max31790: support to config PWM as TACH
Date:   Thu,  2 Nov 2023 11:28:29 +0800
Message-Id: <20231102032834.3827289-1-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E1:EE_|TY0PR04MB6469:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1a5f5b56-3526-413e-ce6e-08dbdb53cef5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rARWfTqNY0RX9Xna1Wh4eAEHLGm81lVMzNMOIpfvy/IOMNzF9xrTj7eOPFNrTreXTFFitc66+zGRRL2AUd4PDgtmPY/xwISsjhfcVxy0xhSR272jtJg5ddlCA3+7RwnZAiATU7OEbP5iO1MYk4CV7aX9U5EHpVGLyA36lSSrRGOc9X2zdomtSQe0DZBtN9wdfC+pObWvAWA+8iZK6CJQowZSRZnYO2+sA3bjYDktlKMvpqp2oId/07F1CClG11li54ht0j1t8UwR6q7s8m1zrK8P/XjIozG5ebZtGvb3C7ukRYRhJ+OUIR91HSBNKrnTWWzGWjjdYCLIBhy97M2AcNyz5UaziH8qGHuPM9TOhYzxCjGx2f9Q1viBmIQippNq+qy6oNXMnI/7uyYzfMEu4yj0aLuSbtbYu3EdsxaQkFajmmbZPC2JY1MBsAuxE2TYKbYiee1QMjrhBBYn5FO1eUL9rG8KoA6ZP+AJyRpYTaVWwRd4PBbvJVHM4Es+cTBPY8bSeC0Y4TBPa3HUSBCi9Q63f6gwk5GBEmIMOnuEy6NeiP9Ip2NexT+y7Sxa4NVODyAaMkurDpAG6Ntrejtj2d71AeDMJyoFgGkgXSblG9QgvMyFxo2HoYOZs+YM3o3acCl6MlJinlQjQGyJa/kvRd8VUtJIIOgpO9ovZLZxmhdG6rzEOf+FyJQ8IXFSSj/kZuOXz8Q5Bga1lm8XB25idQ==
X-Forefront-Antispam-Report: CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(6069001)(4636009)(346002)(396003)(376002)(136003)(39860400002)(64100799003)(82310400011)(1800799009)(186009)(451199024)(36840700001)(46966006)(41300700001)(8676002)(8936002)(4326008)(316002)(5660300002)(6916009)(54906003)(36736006)(7416002)(956004)(6512007)(6506007)(6486002)(4744005)(336012)(2906002)(478600001)(26005)(1076003)(2616005)(83380400001)(36860700001)(70206006)(70586007)(47076005)(81166007)(6666004)(356005)(82740400003)(9316004)(36756003)(40480700001)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 03:28:39.6541
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a5f5b56-3526-413e-ce6e-08dbdb53cef5
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: SG1PEPF000082E1.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR04MB6469
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support to config PWM as TACH in MAX31790 driver.
Add binding document for MAX31790 driver.
Add fanN_enable for all fans

---
Changelog:
v4 - Add fanN_enable for all fans.
v3 - Use 'sensor-type' in 'channel' node to config pwm as tach.
   - Changed the status in MAINTAINERS to 'Maintained'. 
v2 - Remove unnecessary parentheses.
   - Add more error handling.
   - Change the type of "pwm-as-tach" from u8 to u32 to match binding
     document.
   - Add dt-bindings for the MAXIM MAX31790.
v1 - Support to config PWM as TACH

Delphine CC Chiu (3):
  hwmon: max31790: support to config PWM as TACH
  dt-bindings: hwmon: add MAX31790
  hwmon: max31790: add fanN_enable for all fans

 .../bindings/hwmon/maxim,max31790.yaml        |  89 +++++++++++
 Documentation/hwmon/max31790.rst              |   2 +-
 MAINTAINERS                                   |   6 +
 drivers/hwmon/max31790.c                      | 140 ++++++++++++++----
 4 files changed, 210 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/maxim,max31790.yaml

-- 
2.25.1


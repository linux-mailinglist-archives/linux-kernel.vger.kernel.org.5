Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDAF97A1617
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 08:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbjIOG3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 02:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjIOG3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 02:29:40 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2088.outbound.protection.outlook.com [40.107.255.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3901FE0;
        Thu, 14 Sep 2023 23:29:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OXZQ5+4oEHKiOzUItDZEzDIjlD/9Bhxr3VyFK6QpWYlq6Dz6sjal/9VFJ/3ZwiMm0r27iCiY8mJv6ZS/I4B/j04sjElvd4ft7/fZ/daqjXusNs7hTJbpxTVLiwJ7A5tAeHT2Uj6qdHiqBJI7M15i8DEgsGCresaPJZ3SZ/X1KaXBdsISkMjiVpIsBHmyAETtyp2QH36+XHA8h8nallbZwdfc1G9Vt2r90SqBhKpFvVJfapqhoIE2o1JJTZV7K5MDauC5k7SFu57KQvqoDuAic+eucRxQDiA1PQUtjhB95jem9NJ2hc2BuH3jkkeVjaBNhCSox9aBKCOThQCvWBZbyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kgexxNRe/NC/MpCosgyZ5Nd9Wd1bZHY4ntWodx60VBw=;
 b=FyZkBYzKktohQtwNDDq6zqXEevCiVInuco2Y9BII3TIv/WZsHSnufiJMf9VkGpSgvoIIm5GscI1JIEZjF6U2H0VL+ibcTiMODmNBpYeUZoMiRuI47+spLRaSa3tAADHA8s7NtyUlqSHcm+SDLf5EjWK48TmIULRZESicDLHsOYaOsxZ1LdzvDx2fUQrvlKElPC0dCDEJ0GcQI/Gy5Mx8vq/g5A3Knbs+5jV58hm5r84jUWXhOqCdoutOk3ZlLs4DytHf0RVWcxCEOSgChAnL2mYMXhEP9oGKcAwpGU2J3uDvctbAZDnVQ3h8p3j7JujVzEeZzG3qF6PmhflMLOnlTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kgexxNRe/NC/MpCosgyZ5Nd9Wd1bZHY4ntWodx60VBw=;
 b=RMZ3UmrDBaCqBcsag6eJqqYicB494fFNxS28fr+3QAYHPNj/i6mSffGdQOjGMmwDVF86b1Ly0E1klgMXayCv9cF0klrovE0NojotKi41tzFuDCMBIqZY0ICUw2YQxDG76jjXS4UU8/pyc044CPBxvCi+Mw9Z3cL63VzzQH4WmrF+he7WHZ+Dk1f5PhDtY+H2+N2dJy0mFMveZ2nZm6ZU1RzTpX8ZqQR7GqlJVHJYhkBaS99keMgqzrnl8w4MYPCSGmCbuFRLC0Yi0yWmhQ89Rhgj5QrmA1H3H90iwEn3hWj0WD2OE8a082At7FdQchv2Ec+BrPtZ2Mn4lLV+XgJfiA==
Received: from SG2PR02CA0039.apcprd02.prod.outlook.com (2603:1096:3:18::27) by
 KL1PR04MB7210.apcprd04.prod.outlook.com (2603:1096:820:fe::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.21; Fri, 15 Sep 2023 06:29:31 +0000
Received: from SG1PEPF000082E1.apcprd02.prod.outlook.com
 (2603:1096:3:18:cafe::5c) by SG2PR02CA0039.outlook.office365.com
 (2603:1096:3:18::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21 via Frontend
 Transport; Fri, 15 Sep 2023 06:29:31 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG1PEPF000082E1.mail.protection.outlook.com (10.167.240.4) with Microsoft
 SMTP Server id 15.20.6792.20 via Frontend Transport; Fri, 15 Sep 2023
 06:29:30 +0000
From:   Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To:     patrick@stwcx.xyz
Cc:     Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] hwmon: max31790: support to config PWM as TACH
Date:   Fri, 15 Sep 2023 14:29:22 +0800
Message-Id: <20230915062926.2460502-1-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E1:EE_|KL1PR04MB7210:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 778c726b-30c5-47a3-85a7-08dbb5b51ee8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: njewxRjxWB/z5AHsxWlApPve4v6wTLvhuhrKDENOuREeGmoLZKyroWPunsXf5aQqT+RAG6PjiSk8pfdq4v/6lv+kGfDIMtD0yaq6LwRJbUoZK1sqr4SssOW3DyQsIVyNagzcIs+7tgKqGVA4pg/QVhFMT71bETpODAtmuLKvxtpZrhZ4HwvIcHN2UKHz6Wn+u9kShwIQ7pcQEUqbRIrJEnqRdU6t5Rj9iSDWJuga7ENuuA55/z8cL0oOV/OOyocncABqtvluqtHh5tp5ekjh5Rs9FrI1377WwP52x+F9FG066xTOHjg3PRzLtHambU1LksjKnhiJaKNvQrayr9Wfu17ySiU35C6qx9R6mO5zk8uaoKYPSE2wZiDDipUA2JFqL044DthQQKa2+2zFt1MuGwvVlvoqAw3xqLJNzOMfzLfcGrZx3a+HtcPKNZgzioDlEqqK9SqZ/WuMPUd7NKeD6jKCvBOqnzv1Q5kexYDEg2HPAwkfONBaSRcJY51HpSAcj3RU9ByX07Nlh23VSm3srsrtkfJZTilNPAQ2AYmSKUF3rFkrJaOkegyL4ori1uKJ1smtNWkvpZgR2a+T+vKkZkxnWBM61tk8LXlSgXUDoyc0y30bXXV9xMYiYCIExU/F2c3esLgut6ttAuFjgPDJhD7eMiedCDKzFWU2qL0epcakZVg78K9MPUs7ZbSFoDlqIT0F19qPEDMEEdlZwYai8g==
X-Forefront-Antispam-Report: CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(6069001)(4636009)(396003)(346002)(136003)(39860400002)(376002)(82310400011)(451199024)(186009)(1800799009)(36840700001)(46966006)(6666004)(6506007)(6486002)(6512007)(26005)(2616005)(956004)(4744005)(336012)(2906002)(8936002)(54906003)(70206006)(47076005)(70586007)(36736006)(8676002)(9316004)(4326008)(41300700001)(6916009)(5660300002)(316002)(1076003)(86362001)(36860700001)(36756003)(82740400003)(40480700001)(356005)(81166007)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 06:29:30.9226
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 778c726b-30c5-47a3-85a7-08dbb5b51ee8
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: SG1PEPF000082E1.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB7210
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support to config PWM as TACH in MAX31790 driver.
Add binding document for MAX31790 driver.

---
Changelog:
v2 - Remove unnecessary parentheses.
   - Add more error handling.
   - Change the type of "pwm-as-tach" from u8 to u32 to match binding
     document.
   - Add dt-bindings for the MAXIM MAX31790.
v1 - Support to config PWM as TACH

Delphine CC Chiu (2):
  hwmon: max31790: support to config PWM as TACH
  dt-bindings: hwmon: add MAX31790

 .../bindings/hwmon/maxim,max31790.yaml        | 59 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 drivers/hwmon/max31790.c                      | 58 ++++++++++++++++++
 3 files changed, 123 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/maxim,max31790.yaml

-- 
2.25.1


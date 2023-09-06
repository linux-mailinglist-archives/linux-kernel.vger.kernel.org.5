Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8DF79376C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 10:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236103AbjIFItI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 04:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235918AbjIFItC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 04:49:02 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2080.outbound.protection.outlook.com [40.107.255.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5B7E6C;
        Wed,  6 Sep 2023 01:48:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hg6xhDJsb6e3AAiRcNkWk0vyqyx+CRAz4ZQNDlm83kt19q1hExAWxQFHF8rUJ8FcB4p0p3GBsES5j/bHxo7cWSC42OT5T+MJ7aMlWltkHq1z2gDVgixxu53zljkGLmAMxcU3a9U+jbY8vmFe1+0/UlKNJi18eAGnaOuk8JfsbRFF9sLRZcIPvABtRxu79noOBGWF46FzBOuUbB6ZTd7xvElrn4FdGEw8PVw4ZO1SGqY6w9x5rOV0Kd/04wxgdhwL47XfdfO0GIwDVRP3Ieh4hzi36Qr5Qa3H95dQg018RQi7dGlM3y1O1Nl/UKM+b8RBwxzpfNf5DqdAPWdcnpFRaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MKOe+ZzWxhMdEmAjJEm3tY4Cae77kCt6hxxiXzaoHT8=;
 b=TMSZo22iyHsRoCHQAAThad9fqeWYPHwraaicmz88Uz32BLZhg/vGTyi2Yt3T3EZUsxa6r2bnG+gPhGQDbVWk+kUk0H7KTy476RmYZtkSqdxW9cGqp6D4t0IeV8xEtW0KZXvXjqvP1LS6MTL4eg311Tv7PWTxXg/U3NRVy0rsMbsGJKl7P8g8nHPULQCxa7RSWgzNsxpSV0YJxCzMNdWnYdm2ZNrYeLgtYK/e8Gv8HILPEqz0Ew8JCy+YGrJHvS/yADkW9cLwzSlfUfUQMv4HibCP+2SQZR+QxwKBkJ2GGVhcmbCNgOPevt+EtePuZXv+joYKElmEXqopJmp88EdqbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MKOe+ZzWxhMdEmAjJEm3tY4Cae77kCt6hxxiXzaoHT8=;
 b=ZLp0Qw3P982Wkm8ZzP+NceIBh8bQ28/ji0EgRyOWESm5T4MZdRXBa7J9TDh54o8+ytmaNBl3AZJcmz+SnibZR1wh+ip7Ojq3c8tdc8FrQ6X/0NSRLrhJ5WLimTeYLDgIcgy40hrFas8L7tOQmarncoxIMOhwoPl97xnsI+hN4h4N62PIkHI7YFJL1RPz2RkREfEktqWsTxGWTYpOVZN+YTrLWlm+RfKa3GEHcoHxQeGShAaM3ixdrfz02pg9vt/hIFviT9gpJCWBKEROfSrzKr56m10+yN1aFJwLI25VKSEBOs94vXlwfwrfhG4/i27ZfUZiwGb/VRfS8k9Cue00uA==
Received: from SI1PR02CA0051.apcprd02.prod.outlook.com (2603:1096:4:1f5::6) by
 SI2PR04MB5869.apcprd04.prod.outlook.com (2603:1096:4:1e8::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.33; Wed, 6 Sep 2023 08:48:42 +0000
Received: from HK2PEPF00006FB4.apcprd02.prod.outlook.com
 (2603:1096:4:1f5:cafe::39) by SI1PR02CA0051.outlook.office365.com
 (2603:1096:4:1f5::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34 via Frontend
 Transport; Wed, 6 Sep 2023 08:48:42 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FB4.mail.protection.outlook.com (10.167.8.10) with Microsoft SMTP
 Server id 15.20.6768.25 via Frontend Transport; Wed, 6 Sep 2023 08:48:41
 +0000
From:   Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To:     patrick@stwcx.xyz
Cc:     Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/1] hwmon: max31790: support to config PWM as TACH
Date:   Wed,  6 Sep 2023 16:48:34 +0800
Message-Id: <20230906084837.3043030-1-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB4:EE_|SI2PR04MB5869:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9330ecdb-f820-43fc-9f93-08dbaeb61273
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ErcwTW8XrpWKPEUV+If+kbJ5X9Qb+QOE1Wc+rbev7ifQXmh6q++QvbZqyXBpGgRCN9STY3VhVmWEKsY9rrmCU68mbciBvEUqy0edZtavMf2l6dws2rz+xfO6V0YQenZVRe2lqEBE58Nt55/DmnJdDOw5GVFNpjgDYX3gR4fKP2HmIl/pbwf8zAXG53asBRQ4cL9UGap9XCyJTzYMfnMvdLFq8EUAYzwgCzEDy6Op/r8g2mE+RKaAlsIykuJcWtAVKQhGBDQ0K7c4DRTbQhFsYp5DclO09J5SjAx983ZGNWzrNBeIbbrvfJEi7/VVkf6p6cxA9qU+23DZShEZ2m+bnMN8crygrfQoH6NHwh4Dj9o5Awnx2V5/nO85L1EdFfKEF/o161Cn43EEAPykpm6q3lr6ApL2Pp0ix2+5abxGiHNjOqRl0jKFRT5ff6cbwVH14x1O3A2yPh6p2T5XWfSkX5yh0ymjXENlRfFzGNe8BLGNa8B9sdfl5CWwR0KitwnumEXtrvk74tga8WE42vgHth/ThrDWh+e4j8H8e3uUiO15chMPYrtnjzRnPvdBFfW4abTC51pdwP8m8WbnD/3xpW39dY55kArajh6aa4BBc9zDnuCo3HUQXvV6WBF3pFBOsBZpZjzPVomjglNfL4cIRAmcHFWYrlyECHcHSNYUGNPHWKsRLkLW4JzeYdBG4Zutq/ctd73Toe9WuyviClzLqw==
X-Forefront-Antispam-Report: CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(6069001)(4636009)(396003)(346002)(39860400002)(136003)(376002)(82310400011)(1800799009)(186009)(451199024)(46966006)(36840700001)(40480700001)(6666004)(81166007)(47076005)(2906002)(36860700001)(356005)(6916009)(6486002)(70206006)(54906003)(316002)(6506007)(70586007)(36736006)(478600001)(1076003)(5660300002)(26005)(6512007)(8936002)(4326008)(956004)(8676002)(41300700001)(2616005)(336012)(9316004)(558084003)(36756003)(86362001)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 08:48:41.8499
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9330ecdb-f820-43fc-9f93-08dbaeb61273
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: HK2PEPF00006FB4.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR04MB5869
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1 - Support to config PWM as TACH in max31790 driver

Delphine CC Chiu (1):
  hwmon: max31790: support to config PWM as TACH

 drivers/hwmon/max31790.c | 50 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

-- 
2.25.1


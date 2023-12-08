Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 365B9809AAB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 04:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573103AbjLHDrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 22:47:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235643AbjLHDrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 22:47:18 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2064.outbound.protection.outlook.com [40.107.20.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0A810F9
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 19:47:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JSfPL1978GyMDqkznDnhgjLZEmNjoX6pYR4CWvlPChqqQ3H8T9NH5pp5C0f7fPoVNEVKLdCSHukNYFuFwlNiDitC7I7apsroGhCt3Ni7ONxw2CMG3KJlCRvpSLsLeAejNhTfHE7/G6BANrEvDyjDKCsq/fsnc1aG8IR87QkKD5wb25WD4Hw6H4ZiPe2z6FWeBUBmCH2qs5/uTU3gGuk8c4jQUqvVLnsj4w5nL2VdU3dmx4Ojl7IpfeLu5a/ccxwXwA90FJQNJKgmUU45aRuBJq6I0uy2sg71Zu+zRfaQHvCQNCFhDjlLUBS1IFYW3jTEdK0wSO/vSXAHFFZhKr7dug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oBCTvpdghwkm24ptVX1/S0RP7AdgBCPnYW6wIAb71+c=;
 b=S6czSxO1+DNacgekOGyOcjOU7rilcasTW/Sf3WJs6pRz6/k2lP0gtOqz0D44/Hr6J0yZ55ucoa8XdkpahEW81bf9ICbqcu2d5Ri+8VBrwLHn+LxVxklt7jLJ+/Mzacl5rb3aaFd0fVEvdcylDLQKjPv+18qhBKWUB2LOizikmmLOH3p7cBNv9WePigidsx8LlcSXBVPhdahGGcP8E4Zo5EyVMVWSvNEaX/VXhVqP903HtvdykIff/LXcwT5cjnrw0dIsLmj6uxUlXmuKWmBKC2qh3MOdEM/G60bwBBAKS55UsL+0Nag/2TWNg5e81Rf5JX0ben3KDKVMvqD3lcj81A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 195.60.68.100) smtp.rcpttodomain=kernel.org smtp.mailfrom=axis.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBCTvpdghwkm24ptVX1/S0RP7AdgBCPnYW6wIAb71+c=;
 b=gghuqD1C+XdhAipvg6rJX3ShT390A8V40zia/OG/EfXAqoAhXpeYqwmcYCR2jft9++asNIYftMy/hwFoAf+Dvza6ZA6TRMmv/iOZueS/qgSDuKzaAXP1MOaNx8AbmksAANMLqQb+Cw8dcAXVBDE7yF/pL6wJZ2h80ADuGc51mk0=
Received: from AM6PR01CA0055.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:e0::32) by AS8PR02MB7158.eurprd02.prod.outlook.com
 (2603:10a6:20b:2e3::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28; Fri, 8 Dec
 2023 03:47:18 +0000
Received: from AM1PEPF000252DD.eurprd07.prod.outlook.com
 (2603:10a6:20b:e0:cafe::dd) by AM6PR01CA0055.outlook.office365.com
 (2603:10a6:20b:e0::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Fri, 8 Dec 2023 03:47:18 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=axis.com;
Received-SPF: Fail (protection.outlook.com: domain of axis.com does not
 designate 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com;
Received: from mail.axis.com (195.60.68.100) by
 AM1PEPF000252DD.mail.protection.outlook.com (10.167.16.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Fri, 8 Dec 2023 03:47:17 +0000
Received: from se-mail01w.axis.com (10.20.40.7) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 8 Dec
 2023 04:47:17 +0100
Received: from se-intmail01x.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 8 Dec 2023 04:47:17 +0100
Received: from lnxchenhuiz2.sh.cn.axis.com (lnxchenhuiz2.sh.cn.axis.com [192.168.77.59])
        by se-intmail01x.se.axis.com (Postfix) with ESMTP id 214D5F7DC;
        Fri,  8 Dec 2023 04:47:16 +0100 (CET)
Received: from lnxchenhuiz2.sh.cn.axis.com (localhost [127.0.0.1])
        by lnxchenhuiz2.sh.cn.axis.com (8.17.1.9/8.17.1.9/Debian-2) with ESMTP id 3B83lFkm1248417;
        Fri, 8 Dec 2023 11:47:15 +0800
Received: (from chenhuiz@localhost)
        by lnxchenhuiz2.sh.cn.axis.com (8.17.1.9/8.17.1.9/Submit) id 3B83lFxk1248416;
        Fri, 8 Dec 2023 11:47:15 +0800
From:   Hermes Zhang <Hermes.Zhang@axis.com>
To:     <sre@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel@axis.com>,
        Hermes Zhang <chenhuiz@axis.com>
Subject: [PATCH v4 0/2] power: supply: bq24190: Add BQ24296 compatible
Date:   Fri, 8 Dec 2023 11:47:06 +0800
Message-ID: <20231208034708.1248389-1-Hermes.Zhang@axis.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM1PEPF000252DD:EE_|AS8PR02MB7158:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d6b23fd-cb4b-4992-95f5-08dbf7a05ff7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1QVeUpxKQB4IhLLV+NsSjOLVrp+jUw73h0FhQPI56yL+bEN0s6h3ilw3WzYRu/ystrUgZgmAXMbQnjqKaVMW7/8nFcTud/Rm4am5JtkIb5UBfhUlQkV/12LBv+j2Te14LyyQlujG6dmcFE9hssaHriwziU2/KxYE1Uuc4YrCRu2UGExK7oxp6R7YK5L05tHx5UD6Lmp0AJZYWO0QYGkCFMlskPipZ3VM6Jv+9Sc/gNQXeIOkJozLP78VaWPuyJyPZ75/ZmgOewd8YNDjFBWTqwk8F2YZiwdyucv7MLsiE1G2SpMXUsxyxRIHqNXFURU/7yvjLkAE88cmELqYNCUXviOj7iOSk1WCUyGcZT7d1xcPnFB5mO538bibOUSpTRU3Zwpd9uaCYz9ysVd/R6vTNWfz07b98Mc6+k7MUFB1WkhgmDK84qW/xLPZSalyaSPSYQglsq1AKEOlPGQRgXiXNC+XHY0QwrNcKTUMrHPsr8XP18RB2z9Y1voZc2kvNthNCsOoplNiXN+e4O/bMJEzSAFJJsw5/7Teh9h98xzC+ytpLhZw39gJesrusogygxNOEny1qh4rW/UTmpUCWgzKEAftYc0OWETm7OAFZLB09NyiyNPujo81GxD4PxbdpkZIizAizIc22ftGUW2Zfo68K1cSaqWMp4QnY3Awyh8yZiJCQhwMtDDZVn00C6c+Ng3BPoak9sXVB0B3Fd09ifVkKbl2VhSHSTlEUb4aAGGiKigURHURf4Dd6jojUjrThjbvMwrHQHMJ6yivGONei56wXQ==
X-Forefront-Antispam-Report: CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(396003)(136003)(376002)(230922051799003)(451199024)(1800799012)(186009)(82310400011)(64100799003)(46966006)(40470700004)(36840700001)(82740400003)(40460700003)(4744005)(2906002)(4326008)(8676002)(8936002)(5660300002)(36756003)(86362001)(41300700001)(81166007)(356005)(426003)(83380400001)(40480700001)(2616005)(336012)(107886003)(1076003)(47076005)(26005)(36860700001)(70206006)(54906003)(70586007)(110136005)(42186006)(316002)(6666004)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 03:47:17.9633
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d6b23fd-cb4b-4992-95f5-08dbf7a05ff7
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: AM1PEPF000252DD.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB7158
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hermes Zhang <chenhuiz@axis.com>

The BQ24296 is most similar to the BQ24196, but the:
1. OTG config is split from CHG config (REG01)
2. ICHG (Fast Charge Current limit) range is smaller (<=3008mA)
3. NTC fault is simplified to 2 bits

Notes:
    v2: restructured the code to support bq24296 and add Acked-by tag
        from Conor
    v3: handle the match_info in the modern way
    v4: fix compile errors

Hermes Zhang (2):
  dt-bindings: power: supply: bq24190: Add BQ24296 compatible
  power: supply: bq24190_charger: Add support for BQ24296

 .../bindings/power/supply/bq24190.yaml        |   1 +
 drivers/power/supply/bq24190_charger.c        | 457 ++++++++++++++----
 2 files changed, 355 insertions(+), 103 deletions(-)

-- 
2.39.2


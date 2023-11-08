Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 128CB7E5A9A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 16:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbjKHP5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 10:57:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232692AbjKHP5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 10:57:11 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2075.outbound.protection.outlook.com [40.107.14.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E361BC3;
        Wed,  8 Nov 2023 07:57:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JrtChNqOIZcmcgpWRYnZ+13Q0gimyFEkf5Cd9E8Q4z8vyJBFjzJqzYmAVKkhLGzKZOesP4A8BmQw7KTG7d6yNkNjIHfsA9noVPfJRDH1Lc6zk4xHWouT6y4t7OI4WVVD+otV3WH5CU4sP+UZGWKsFx/oGMTZHV0Xoh2Rj6ysrNVbF2lp+KmOxc01Sk/aQZBh1iAQMYDmcqGkSMdt1Ky3j2VNh9NdjdAR58zmCiiA2CfET8Uk/ULJ2i+ferLfPn0nELIjRlk8AqkTtNmfXdDqOUGAnw3cb7C+PRFGJVRCFBHwv3HofkyNrvkRrOZdFfHkuSyspuvWBOPFnlNmDCVHWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5xQe0ZSfxo8hZWt5rpcjHQRYKCgdfUclVsr9eP8/VuU=;
 b=LLSSe/7BKcNNZsVO3xA7pQmQffyf2oPSJeqgHp1GnXcbA7DVZmZr0VaHfH3bmt3VL4tMjGRWNBAWNe1wsXlC7rmi5grabvP4N6q82/8xAb8q4//oGxI86hviaj2742ZLe5yZEUFxPV2CZNXD8R74vl3WEK0LpdTJRa4RkyeNfzQy4On+HU39uLkEnZRj/FhqbT2Dd9uD7MRKRVdYjRs7TYU0QW+ktqoOdQ2ZP0Wpw63+GlemqLrR/5PKjLoIzQ9DQos1cdhHmCpNUrkO5PZ5/erSbSo7fjzgMX9/n1pVWiTqIPkCftthFwk67J+tBydgHKOl6ujPxpFGTEOmQdqUTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 195.60.68.100) smtp.rcpttodomain=linaro.org smtp.mailfrom=2n.com; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=axis.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5xQe0ZSfxo8hZWt5rpcjHQRYKCgdfUclVsr9eP8/VuU=;
 b=Km/EBo3fIs+q3Z+DCg7KcHqo4mGEiwxP2x4e19At5fm9Kl833r0aqkyVO73iprVcxPtbcD3Jjs20SByct0RLwru2PAxb4OMRCoQziaXqbZ7+Mg1J4mAfroujgNOC+lgYBahDSjomvDYky5296OfOWKYg7ivfAmq2P7Zqy+lWrMw=
Received: from AS9PR01CA0001.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:540::6) by AM9PR02MB6835.eurprd02.prod.outlook.com
 (2603:10a6:20b:2c4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Wed, 8 Nov
 2023 15:57:06 +0000
Received: from AM2PEPF0001C714.eurprd05.prod.outlook.com
 (2603:10a6:20b:540:cafe::8) by AS9PR01CA0001.outlook.office365.com
 (2603:10a6:20b:540::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18 via Frontend
 Transport; Wed, 8 Nov 2023 15:57:06 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Fail (protection.outlook.com: domain of 2n.com does not
 designate 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com;
Received: from mail.axis.com (195.60.68.100) by
 AM2PEPF0001C714.mail.protection.outlook.com (10.167.16.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.17 via Frontend Transport; Wed, 8 Nov 2023 15:57:05 +0000
Received: from lap5cg227217h.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 8 Nov
 2023 16:57:04 +0100
From:   Jiri Valek - 2N <jiriv@axis.com>
To:     <krzysztof.kozlowski+dt@linaro.org>, <dmitry.torokhov@gmail.com>
CC:     <jiriv@axis.com>, <devicetree@vger.kernel.org>,
        <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v5 0/3] Input: cap11xx add advanced sensitivity settings
Date:   Wed, 8 Nov 2023 16:56:44 +0100
Message-ID: <20231108155647.1812835-1-jiriv@axis.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail02w.axis.com (10.20.40.8) To se-mail01w.axis.com
 (10.20.40.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C714:EE_|AM9PR02MB6835:EE_
X-MS-Office365-Filtering-Correlation-Id: b41ccd38-05a8-4f4b-62b4-08dbe0735b08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R3i79IkxFN5TXq5jjGcoRlNnOCl0de4kc5aA3VLjaaj8OdzrEOYu3rjBQM44nEj9G2J1HPP+LXyk/gHO4KRJyKz1KUb1K7XGCjPcJej51m0qsu86mUkxLScvvUd3s3QpEdHkIpjofpMg0W8PI9cPwSf/LfPQ5z6PjuLg/cNczlGvdwYWcKT2ObZlhatY//XCjKd+l90jfKSz53+K6NhLM4TylUIMlpAY0SE41NkwoiE0W4fVvx/7en22laRnil7gqQBJYbeSTy9pE+X7HmZuz06cCyuGcZrtFRlJDSpxRfZX3evHJsMzLcLD89Uw4xe1MaIHO78Spa+2N32gs4Unsy1k4zJTpl3i/9eT1GtJM4xWZayvHrhTeg7oTTZ3t6dxQI04KLG4NntwNwT6vdx3u6CoRoalqMPttK8FT0YP/63btZSkqUAPRZ6EjJ3RyRUDdifsK8NWe0lI+ICHPywKXNEwaATfxL1penrXxiE//cVrTFF0O5rBZH2nooor1YYcFSr9hEMa0zT0lPzjIeKrWrpGFU4jU/6AW5y05d8HHeKHUJK7P7KHbVWgxiT8ziixjcLauttq/y1j0YdLTs59JuzRbOLLg/LHoL4FDWqXVSk53+OssdTH9Lm+4GdRpEgX8x1KZx/gqQKHJg98IhZorsGkGpx8WeFLCwQzX9fGjSnXTYeBBxa2+Y/Y1LpraLF1uhREpkLkVOHGTR/Wz7oiB2pYoLCqULatCZBZ3YBZpuzwwgjqNY4PeNj0Z+NinuR8CFivKq+HGGU2dO0ugdIlXQ==
X-Forefront-Antispam-Report: CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(346002)(39860400002)(376002)(230922051799003)(451199024)(82310400011)(64100799003)(186009)(1800799009)(46966006)(36840700001)(40470700004)(40460700003)(40480700001)(2616005)(478600001)(26005)(36860700001)(47076005)(36756003)(16526019)(356005)(82740400003)(83170400001)(83380400001)(81166007)(70206006)(42882007)(426003)(336012)(316002)(7696005)(54906003)(70586007)(1076003)(6666004)(2906002)(5660300002)(4744005)(110136005)(41300700001)(8936002)(8676002)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 15:57:05.5881
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b41ccd38-05a8-4f4b-62b4-08dbe0735b08
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C714.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR02MB6835
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PATCH 1 - add documentation for new options
PATCH 2 - add support for advanced settings into driver
PATCH 3 - remove unnecessary IRQ parsing

Changes in v2:
  - Removed "sensitivity-base-shift" parameter (not HW propertie) in PATCH 2.
  - Used IRQ from I2C subsystem instead of parsing it again.
  - Fixed some documentation issues in PATCH 1
  
Changes in v3:
  - Remove incorrectly used "Reviewed-by" tag in PATCH 1 and 2

Changes in v4:
  - Remove unused variable in PATCH 2

Changes in v5:
  - Revert IRQ parsing in PATCH 2 and move to separate PATCH 3
  - Fix 'if' condition for properties in PATCH 1

Jiri Valek - 2N (3):
  dt-bindings: input: microchip,cap11xx: add advanced sensitivity
    settings
  Input: cap11xx - add advanced sensitivity settings
  Input: cap11xx - remove unnecessary IRQ parsing

 .../bindings/input/microchip,cap11xx.yaml     |  76 +++++-
 drivers/input/keyboard/cap11xx.c              | 248 ++++++++++++++----
 2 files changed, 269 insertions(+), 55 deletions(-)

-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1360B7F32BB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 16:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234440AbjKUPxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 10:53:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbjKUPxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 10:53:13 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2075.outbound.protection.outlook.com [40.107.6.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C80132;
        Tue, 21 Nov 2023 07:53:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fkh7tq3Ggfj9pOxtIeVF5n6eSZDx9GUQmI4j9Q/ejvCQ55hiR6Ww6X30N3Wxqjw2nLIE3H/bWUpLLbd8Ag7QlMceibTG1T23+aR0oD+DLCZ9V8oPvve8qQ5IDx/wXYKRe4c80MIVSgkHH2EFM7zVsliEAuAgysEFNAJyELJ8E9sinQv7eeXihV6R+TR+baMJX3vgowpNvoUfee8QEz2+fZZpYk69B5XgGwdIf+2HZOHNgWe1r9/mHUlTuysZfaPuprsKXRmYJR9GHxuiOyRhYoCdMBWBqyvMMfA3P3wUgzGDQ9dovcmxuqkopj4xnTY8C3uHH1+Kg3dt1OBm6DLPKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cp5Bd5Dc2cafLcc1SqxB1pIoTRtbtzvQAIdyqS4OH10=;
 b=hv2Y7YMWgL8spbCgMGbsZZDFxugGreJLmh3vxwHv+j/Y6EQpIQKyPJaxeklqxCcg3EOD1DgxQ8vs8j4ID5Se0GlN0ZD+CSd9CILaZtNAX2iBokVW87hLHzXpqBuvm9sYxuLRBEjuAouYF41is0AwxYCCcCNYR0VNwHu8iaq71rky6rIVkvdKGIX4P6QlE9OjMVVTh/JCj0kdtYZgaP3RZY9ne4UFSQa4OMw5zbmGS3k5cUgjl2mlHBKX1Mc67/wIwhYp2cznQKJfTFnggYfqQhWJB5Z3hr3aNXqU0WUCGv96rXh1u2UH3WvN0pbYhEpmPdMCS9BSeFDqJMAyqNejhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 195.60.68.100) smtp.rcpttodomain=linaro.org smtp.mailfrom=2n.com; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=axis.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cp5Bd5Dc2cafLcc1SqxB1pIoTRtbtzvQAIdyqS4OH10=;
 b=EHP3tdxuB/hRsoGOoGoTcNVfx25nTzGkMvLADyEQ84HjiqrCLkiQdnbNJKkqrfwa+/Uy0Eg9a711ffgw9zVNyAuKZPqMfNafO4rJ2PVSL6f0ewGji34rW1cLSL9RKtMtfAV3Cfal1KHporY+vY9iXoliGWBvucmoaqliKi4jZrs=
Received: from AS8P250CA0002.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:330::7)
 by DU0PR02MB8783.eurprd02.prod.outlook.com (2603:10a6:10:411::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Tue, 21 Nov
 2023 15:53:06 +0000
Received: from AM2PEPF0001C70A.eurprd05.prod.outlook.com
 (2603:10a6:20b:330:cafe::93) by AS8P250CA0002.outlook.office365.com
 (2603:10a6:20b:330::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28 via Frontend
 Transport; Tue, 21 Nov 2023 15:53:06 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Fail (protection.outlook.com: domain of 2n.com does not
 designate 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com;
Received: from mail.axis.com (195.60.68.100) by
 AM2PEPF0001C70A.mail.protection.outlook.com (10.167.16.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.13 via Frontend Transport; Tue, 21 Nov 2023 15:53:05 +0000
Received: from lap5cg227217h.2n.cz.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 21 Nov
 2023 16:53:04 +0100
From:   Jiri Valek - 2N <jiriv@axis.com>
To:     <krzysztof.kozlowski+dt@linaro.org>, <dmitry.torokhov@gmail.com>
CC:     <jiriv@axis.com>, <devicetree@vger.kernel.org>,
        <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v6 0/2] Input: cap11xx add advanced sensitivity settings
Date:   Tue, 21 Nov 2023 16:52:48 +0100
Message-ID: <20231121155250.613242-1-jiriv@axis.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail01w.axis.com (10.20.40.7) To se-mail01w.axis.com
 (10.20.40.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C70A:EE_|DU0PR02MB8783:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cc22c6e-ee60-4c19-1500-08dbeaa9f351
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QkMfT7i5ogmO8RT5rH/8xdmWps9jtzUrp4VdtldF/NAKjRUbXnv9QbG3GH+XRr4enQB2nRQMOF+//bsPDAhljuY19oGlZBADX91pPFI2v+oVe1rC2848DHw4UVRxOSrZShxPlI+9rRGqgolIwq5KVGCsk3jIUx79dhfXffW9WvEP8GDrYwOw4L+/Cmf942mG5roU412+MZ2xGLDnaXXBaVxLdusUTbvNW/P8UADXf+2EYUx+7/ZR0Ec9vHC96ESbE5tKY2IKS6d5ISZWaqIZI8AefAbL6SmnyhsrCC/CafQFYCmiAU26q57799zX9w8bO/gpUhEO57JFtW5Dc/9QINjRyB3cUIraegQcUo0IXU99goZtlEIjF8NZk58QUwBDgzC/GPwF79vep2M+/+NRDwvmU7+wIJyVapkdlRfOKQ8ZKskDLYDBA07CcyjbWzz9W4lP6ixjlzZp8yr2YNwS/LWUHkpt4ef0nVfbkFv9jdFXEE+jU4sITrianKNV4EMTpB8X+6Zuwb/EPBLuGZj8beHODGHV3uBDPspFjOc85GQqzbckIE+2v5QQcX1MvJ+D+jHGKNkwKl/o7VnZ8F2/kf1GVcWix+mDm/C08GWTZbsqMgO3UtEg6o4In/u2XCJUEILO9wlcxOuvWE6r4AN/RbFGwREIirUaWzy1XdbJSblhMeN84IHmILpyBiElZVu3oaCU1scbqZn5nJ9ZDBtr0pEui9D0t/eWF3DFIlZ8xhWYhcspDUQBqbnNOXMQKUhd8PK3AJUF5ZgJph6JD03JBw==
X-Forefront-Antispam-Report: CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(376002)(39860400002)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(82310400011)(36840700001)(40470700004)(46966006)(36860700001)(40480700001)(7696005)(83380400001)(6666004)(478600001)(16526019)(82740400003)(316002)(8676002)(8936002)(336012)(42882007)(2616005)(70586007)(110136005)(70206006)(426003)(54906003)(356005)(81166007)(83170400001)(47076005)(4326008)(1076003)(2906002)(5660300002)(40460700003)(26005)(41300700001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 15:53:05.5294
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cc22c6e-ee60-4c19-1500-08dbeaa9f351
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C70A.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB8783
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PATCH 1 - add documentation for new options
PATCH 2 - add support for advanced settings into driver

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

Changes in v6:
  - Fix typo in PATCH 1 and 2
  - Added more description to some params in PATCH 1
  - Removed redundant "optional" label in PATCH 1
  - PATCH 3 already applied, so it's not part of this set

Jiri Valek - 2N (2):
  dt-bindings: input: microchip,cap11xx: add advanced sensitivity
    settings
  Input: cap11xx - add advanced sensitivity settings

 .../bindings/input/microchip,cap11xx.yaml     |  80 +++++-
 drivers/input/keyboard/cap11xx.c              | 242 ++++++++++++++----
 2 files changed, 273 insertions(+), 49 deletions(-)

-- 
2.25.1


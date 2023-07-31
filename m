Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 452717695A6
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 14:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbjGaMJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 08:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjGaMJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 08:09:10 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4B710F2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 05:09:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fyGTScSeu9BGhEyF3TLlQNIZ4Dm9kJpLxDdDUMTFEsNN9VvB3kZOYdz3RAzWOf4PK3TJ7p0uRwMbic8WdBvQhnYmXDr/Zg1aUk5xWSokyQGPJNuxFkwTXzycv58PskCqoMrGsccukfavXQGkhEz6n9wLJjsQS0UArBQUEIYzZ+xCaCpZpxLKtMxa79/lMCmUIdgJ18X/K6c2nz6pJlX2x9dqhEvSDCdpOzzR9iUzHZpTxrZ3przePTAt7nuNtzFcFZpzNryU3RFjkrXjEe58nnsVqNb9S5GUih3Gxy+s2ygiug9gXZl735Og91767mZsTBaQHQU3rSkYQB3W7YdUwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ijqX6NzBii9B5uz2SCChU2W7nhodp2PB65Gv5ihjDM4=;
 b=gANQE/6v0++cIq7Jd+oOpW2fxvpNW3rkKNstmWVEuKAk48dy2wxjriwNHf4ySMprHXJTSkK4KkP7PceGfuPk53CsA6wa2OwNUJDnw2mJbm+cxeZix5UXlZonRMevLrai4C4tqs+VALW92X/yT5hyyLNtW6ZFZIH09hcHnA1B1GEXVhHXB3O8swtmKNCr9BLF2IoP5RSiueG8YXOn57aUX5cZyqKWmWniqKICafSYFAHia9VLjC4zowkc0FZ/AofZPrUJtAZxOdbuyB9glPi3rm5/alf/0PQmPH44peDUcQsneFKqtaN3JXUbtFSkarRQh0QV15QDrr0c34tITBWE2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ijqX6NzBii9B5uz2SCChU2W7nhodp2PB65Gv5ihjDM4=;
 b=2pBSosnqPproInnHlfk7d2T/qCAcA3WDEJqcC0VUnWJmp0rsucgv5VsG2UpTMRhSk1CURY5lSCaIio4wqksGh9H66lzCJ9ZegV2fL/w+umVGL91ZlVbo89Alve1c/R/kgjKr/QwLEVO/buV5z/y4sUs1mwCesK4D8oa1m5JhniU=
Received: from MW2PR16CA0067.namprd16.prod.outlook.com (2603:10b6:907:1::44)
 by PH7PR12MB7870.namprd12.prod.outlook.com (2603:10b6:510:27b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.41; Mon, 31 Jul
 2023 12:09:04 +0000
Received: from CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::24) by MW2PR16CA0067.outlook.office365.com
 (2603:10b6:907:1::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44 via Frontend
 Transport; Mon, 31 Jul 2023 12:09:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT051.mail.protection.outlook.com (10.13.174.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.44 via Frontend Transport; Mon, 31 Jul 2023 12:09:04 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 31 Jul
 2023 07:09:03 -0500
Received: from xhdipdslab59.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 31 Jul 2023 07:09:00 -0500
From:   Abhijit Gangurde <abhijit.gangurde@amd.com>
To:     <gregkh@linuxfoundation.org>, <masahiroy@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <michal.simek@amd.com>, <git@amd.com>, <nikhil.agarwal@amd.com>,
        <Nipun.Gupta@amd.com>, Abhijit Gangurde <abhijit.gangurde@amd.com>
Subject: [PATCH v2 0/4] cdx: provide sysfs interface for cdx device resources
Date:   Mon, 31 Jul 2023 17:38:09 +0530
Message-ID: <20230731120813.123247-1-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT051:EE_|PH7PR12MB7870:EE_
X-MS-Office365-Filtering-Correlation-Id: d5adc35f-bcee-4e85-6cff-08db91beef14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OdGj9Ne5h7tvohrsvU+FaajtaVBB40OY8jTxjjgLgM+kvFGJ2ZfXWD7guvVXN0cjN5d+OpLpNtqrP6sTom0QfIxJA+GmB4ehoXoBz+XyIsITFvxXoL7ZmifAHMXzmcfRFL+tjcT1ydpRkniAUYnUqTKlGMYL2SyF+qEmQqSPgYBdjIbHI1zOpTdfravVLpla75Hh8uA1rofdjrWoin4WM5B+hoQmtdY2bZPXEM0benZ74TKqd2SiSzm12D8tjCzJwDr/1mVXqTPl3oH8gFergrIjlEByTgTKNS9TSrkfDD3AUYWiWcWRr8G3bDA9x86FrKloP9YPRcTe2U0AB0vdpFfnOdWaRcgPDIVd/9lWvlzl3vFXGraXC97vPL1Z4UBRECkBu8izzcDChxVN401IU2H0hKfgYsdQxBErwn+b6gy3c01t03ukPa/FivAnCcjOYLMYQuHTCQe1O96xlVDTP6xG31o8WSa6ZL+a4xRsWGiJR3FgOrGDexYpImOFRBNTZcfoW0GAOkprjVBMvslankht3yMZihITGQxVHecVyHPtYUTVOWGLYEgK7bV/ni/zs+l4aoq6CV+YO2BIaUswIpg3uuraNmtB6s7GNdfaaBVhuP2zKYivgpTf3+W8ygPdOjhtDSz/x+UXQh006r0+8ZOxLAze6sHjuzWyCoZBRvQGtxcUVPlu0WTtw8v3vgBZZA4W0Db8/95ab/bJzRSN2s4JXvKvKDEin24pI1geP/oCCFzfSaJakeDsQRZ8LaHJyAXtTY7vpkM8tEGUrEtqew==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(136003)(396003)(346002)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(82740400003)(356005)(81166007)(40480700001)(86362001)(36756003)(40460700003)(478600001)(2616005)(186003)(336012)(26005)(1076003)(8936002)(8676002)(44832011)(5660300002)(70586007)(70206006)(54906003)(110136005)(2906002)(41300700001)(4326008)(316002)(36860700001)(83380400001)(426003)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 12:09:04.2245
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5adc35f-bcee-4e85-6cff-08db91beef14
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7870
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series provides sysfs interface to
 - enable and disable of cdx bus
 - reset for all the devices on cdx bus
 - subsystem, class and revision for cdx device

Changes in v2:
 - Introduce lock to protect controller ops and controller list
 - Split sysfs entry enable to enable and disable
 - sysfs entry enable and disable take bus number as an argument
 - sysfs entry reset takes bus number as an argument

Abhijit Gangurde (4):
  cdx: Introduce lock to protect controller ops and controller list
  cdx: add support for bus enable and disable
  cdx: add sysfs for bus reset
  cdx: add sysfs for subsystem, class and revision

 Documentation/ABI/testing/sysfs-bus-cdx |  87 +++++++++++++
 drivers/cdx/cdx.c                       | 156 +++++++++++++++++++++++-
 drivers/cdx/cdx.h                       |   8 ++
 drivers/cdx/controller/cdx_controller.c |  50 ++++++++
 drivers/cdx/controller/mc_cdx_pcol.h    |  54 ++++++++
 drivers/cdx/controller/mcdi_functions.c |  31 +++++
 drivers/cdx/controller/mcdi_functions.h |  18 +++
 include/linux/cdx/cdx_bus.h             |  39 +++++-
 include/linux/mod_devicetable.h         |  10 ++
 scripts/mod/devicetable-offsets.c       |   4 +
 scripts/mod/file2alias.c                |   8 ++
 11 files changed, 462 insertions(+), 3 deletions(-)

-- 
2.25.1


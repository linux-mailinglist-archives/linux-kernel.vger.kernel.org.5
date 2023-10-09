Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBBF7BD7F5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 12:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346026AbjJIKGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 06:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346012AbjJIKGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 06:06:09 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C0BBC5;
        Mon,  9 Oct 2023 03:06:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bBGIqF+59d9Xb1fkT3nXSR9gpGomAAYynyH8iK3lHVJstGenfOev1foyEHb6WjuCGThoTGfyhSf7Z5UpLAGZdHJg4F6zC5JUbDSW6BtAjj4lLpgte047kbKVLIhyVcdpekoi4zTHz7MdNAf2Zdbdy10QGCU8xuCI/JMEhnda+Ar3nepuVRbPNrkGNwCryOeEOUpujeajjuip2D2cI7KfYEMtFlXQ50cmbGuUaD7gd67xDegk+h7dhUTmZhKAJhhHqWf//nOPTepJO5JDP1rFsF7lTDS/e7/KqrZZmEeVyYZ9cL3C2Y19BkW/jWTVAhzh9pXn3PJTEiwOlY/s4dBuxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fhtDu3dlpDyLT3O51XqE6CU6hOgHMRqaYCGR0q+W5V8=;
 b=k8FsHBM9Nv9ywhtfe8Xsirk15xNOLGcTqmxy2YZrLTClEGW9IIRrQWSl484tUVA03O/E6oufNc/zKoIu3/Bmmxo9PspQ6wS1Di34nddfHVudwCqHkTExlR3Fda1kSgg///5lIT4frknpl5xHJuQ58HZ+vW2BOiVO0UAWxvarp+S9tiw4an0VkP/Yfpkgaw4Jt0deAgHf6ZBbpIBw7XNA9UDws4lcmz3lNaBdYvbStuHqY2rfKUpps8jPOM3y0nNtD+CI4Q9LgnbPHzp037b6V/aJJncRlSM72HqX52kBV/M/Qa9ZKMSq0n2OFXS0nIi7qp8almISCRLKuoeVQVFbEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fhtDu3dlpDyLT3O51XqE6CU6hOgHMRqaYCGR0q+W5V8=;
 b=qt0OX5O6JvQ6yNFS9Z7XNDe+4W1A2CDuDggACRKpZ6SwMuxx2ZX1CGhcqN4vZCPVUZ6b41spUasjbOZoQrrX/zwHTah5jtipIlTa0DSYUWQqKQaw8QDW0uiSi63abSDNd6mK5VIqLjTbkSKmxv82nqSomTyLtVjEO63ZjfNU7hhOfbK7V8+xs7RZWXPROvFMoqQ9FaxCJZiWZFhEt2WE1y3511TxgHVTm/aCHHBA/5AYUk6duf3HWgjfQstZ7iYVHiMVYZY82ZTLOt+O2QINB+pUh317Vv9gfXdrDjs8qO6+5qUo9GaKqeTeuNMjK7EJsqVfAviQ5OQoQKNbFevbGw==
Received: from DM6PR13CA0015.namprd13.prod.outlook.com (2603:10b6:5:bc::28) by
 MN2PR12MB4270.namprd12.prod.outlook.com (2603:10b6:208:1d9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.41; Mon, 9 Oct
 2023 10:06:04 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:bc:cafe::f6) by DM6PR13CA0015.outlook.office365.com
 (2603:10b6:5:bc::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.20 via Frontend
 Transport; Mon, 9 Oct 2023 10:06:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.14 via Frontend Transport; Mon, 9 Oct 2023 10:06:03 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 9 Oct 2023
 03:06:02 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 9 Oct 2023 03:06:02 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Mon, 9 Oct 2023 03:06:00 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <treding@nvidia.com>, <jonathanh@nvidia.com>,
        <krzysztof.kozlowski@linaro.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [Patch v2 0/2] Fix hang due to CPU BW request as BPMP suspended
Date:   Mon, 9 Oct 2023 15:35:55 +0530
Message-ID: <20231009100557.18224-1-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|MN2PR12MB4270:EE_
X-MS-Office365-Filtering-Correlation-Id: 310aa01d-3fdb-439a-5e24-08dbc8af5902
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w0WmnOUa4LVXUfdQ40nmks+7BMfjazEAfxefgJx/avBP270jLek5SBKzHjVlcWtJq9Z8y2a9nuqM9DjRQDECJpmIMArYfLTrnoUSMmM8AQpIE8VG2/D8z1gNyNieRGmRBMh94/D+16sJOUox0SObZiBLNnX38OQLpxEGLzM0TFaWAaC5d8ppai2igxwyCsy1MaQyNl4oBuHj2DK24boRg8FtPL6oeM0CtmCgzMPGNDY+nyEb/QQ1wNwOvixZS+G3BmAu7z3TmkGJ6YOhSwPnMsyUypuODggjuxOodq6xryBAJNwMMz4W/df0iSIVFgrnU4XNyqFJLN/7H5wE/zqvXnXCuZYB2cO48fFCC042S0VjykrRdptUF8W60LpN5YLt+tqzQwv7rvvUpEwNzApdrNjki8d23bwn33EGw+ElYZTfqemW9fPBTYtS8w8Hy9k9nERGSn0DzY1TXLCfh41wEK35msMSvGgGbOxSejiVn5F+nfTg46rgkwaBgpyr58oQnckUZ53fY8UoGaGvGfSrPG2if+aMN0hJnGcSqafIWbED65FnG8RmcsLPsbPbJQch3CRyppV0dAPmxMlCQOkq1gfXinMQA6gipgU9ZQBMXdtE+j3Tnkp22IuKI6VD9L+GbwD7E43aXqIJTFwCuFUnTxDxE10qJ2ylYRvGW+iztFYsnnvmbBcEmFd6uRG8sXS+xgnoBb/0h3Igd3vWvDLZfBIuL3rZpmHQ1PSptqyzZFNKL9ENGKv6UghN2nHscd4iIQsSEdltW/3pEksiGAQ7boQJBhB9nfpommEtmS9YHBs=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(376002)(39860400002)(396003)(230922051799003)(451199024)(82310400011)(186009)(1800799009)(64100799003)(36840700001)(46966006)(40470700004)(40480700001)(40460700003)(426003)(83380400001)(107886003)(1076003)(2616005)(336012)(26005)(47076005)(36860700001)(70206006)(70586007)(110136005)(54906003)(316002)(8676002)(8936002)(5660300002)(7696005)(4326008)(41300700001)(6666004)(2906002)(15650500001)(966005)(82740400003)(478600001)(36756003)(356005)(7636003)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 10:06:03.9810
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 310aa01d-3fdb-439a-5e24-08dbc8af5902
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4270
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set fixes hang during system resume which started coming
after adding Memory Interconnect and OPP support to the Tegra194 CPUFREQ
in below change:
 f41e1442ac5b ("cpufreq: tegra194: add OPP support and set bandwidth").

Tegra194 CPUFREQ driver uses 'CPUFREQ_NEED_INITIAL_FREQ_CHECK' flag
which causes a CPU frequency set request from the 'cpuhp_cpufreq_online'
hotplug notifier during resume. The CPU frequency set call also triggers
a DRAM bandwidth set request but the BPMP driver hasn't resumed yet
which results in hang during resume.

Fix this by resetting the BPMP IPC channels inside tegra_bpmp_transfer*()
API if the bandwidth request came from CPU clusters and the BPMP driver
is still suspended.

---
v[1] -> v2:
- add suspend hook instead of reset hook based approach.
- add suspended instead of needs_reset flag in 'struct tegra_bpmp'.
- add flags field to 'struct tegra_bpmp_message'.
- set TEGRA_BPMP_MESSAGE_RESET flag from MC driver for CPU BW request.
- use suspended and flags to reset BPMP IPC early on resume.

Sumit Gupta (1):
  firmware: tegra: add suspend hook and reset BPMP IPC early on resume

Thierry Reding (1):
  memory: tegra: set BPMP msg flags to reset IPC channels

 drivers/firmware/tegra/bpmp.c   | 30 ++++++++++++++++++++++++++++++
 drivers/memory/tegra/tegra234.c |  4 ++++
 include/soc/tegra/bpmp.h        |  6 ++++++
 3 files changed, 40 insertions(+)

[1] https://lore.kernel.org/linux-tegra/20230830115829.23977-1-sumitg@nvidia.com/

-- 
2.17.1


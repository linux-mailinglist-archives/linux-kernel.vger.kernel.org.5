Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E233F7A0BF8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 19:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240130AbjINRsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 13:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239124AbjINRsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 13:48:07 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2041.outbound.protection.outlook.com [40.107.95.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8BC21FF5;
        Thu, 14 Sep 2023 10:48:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q27bdCOkERVWYMJlGLm3+RSRk8s/j7ScDT5ORWKw6cPgyJ7EMyfSCGWU0BZBeCCn5MBOY2p576iwJ+u/LolrvF1+D+jr1Fx1c2Z8t4cSiSfzo9qCplox4okxsnQCUrEbTYhqkEfDS4JKQuPraTnFmp0bx96paKBcybzE1ggwxymaW6ljqdDsd8QQqMAAYEOullvLhwWSaAJBSV5bMfz7vblhM3DPuHYxqQR7iY0Hm90mOG2+7XX2QyN2SiidX9Ki7WCgXqOxOh+uMfuJj67YfS8cc2p0k7PdqVTenIBRhpdSh5w6+qJt7qb3E4IfwiAbMVgZlCgK/2B84+FllD2S/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jzbNOomNNBZ5CqIvwlDBtIRYpGdY8cX5qkdO4//fdFc=;
 b=jmy7qxowkul1JwEgs2Y5475at13dJZeaNIfr2Z94NzqYvm9pQYWSuRiEOhRsID6j1c0c2HMymZJnEClpXTZbCppctZ/nO22fpoX/WKsQDOXSk4+BHy2f1/8YNXarJ9Wu1eimWcgqr3UVCoUVZkTjtNfOHeutbmbPppa1gVkaPz75aW1j9FzwGbR+9VC/N0V9LoRlhosCHVuInLlrJuH30rSinG3LmZjLOLI5GECBEcCD7kLBrIR1q7KydhLIsAc3LtZ2mCs38qLxPNr6XGfmwM+AktAWWY7BSuWBi+dKOHPcQiLbU5EgyO9VXDj+rpgyyY7i1q5mAhP/3IXP3zwQYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jzbNOomNNBZ5CqIvwlDBtIRYpGdY8cX5qkdO4//fdFc=;
 b=d3z0MVKheKVkWEGeyaLefjwMbcVV8zZ7yqXy2zRNgYazakfAr5AOIiBXZtMP5NkuV7bCHGtjk6sgQz3r9liaDQvHFC8G7wewEXWTEEy3PkPLDo/iqi1Oq455UbpPzJI2onCCFZiE4upFvjNg4zeS+Jwphr2I6bAZWdyDBvya70I=
Received: from BL0PR02CA0143.namprd02.prod.outlook.com (2603:10b6:208:35::48)
 by MN2PR12MB4317.namprd12.prod.outlook.com (2603:10b6:208:1d0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Thu, 14 Sep
 2023 17:48:00 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:208:35:cafe::66) by BL0PR02CA0143.outlook.office365.com
 (2603:10b6:208:35::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20 via Frontend
 Transport; Thu, 14 Sep 2023 17:48:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Thu, 14 Sep 2023 17:48:00 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 14 Sep 2023 12:47:59 -0500
From:   Avadhut Naik <avadhut.naik@amd.com>
To:     <corbet@lwn.net>
CC:     <linux-doc@vger.kernel.org>, <carlos.bilbao@amd.com>,
        <linux-kernel@vger.kernel.org>, <avadnaik@amd.com>
Subject: [PATCH 0/2] Spanish translation of security-bugs and embargoed-hardware-issues
Date:   Thu, 14 Sep 2023 12:47:50 -0500
Message-ID: <20230914174752.3091407-1-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|MN2PR12MB4317:EE_
X-MS-Office365-Filtering-Correlation-Id: cdf9b4a1-ae5a-4e4b-1fb7-08dbb54abcee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YrKd+SpPVj4H71TGVbOdE/Cp6LjQ60ikzZZhJSCm+mg/dKlCrTeRTzvOCK8RxD5vZZKcWvXwqwzKyL3HGnpSYHeiQCB2c6wcwHY30pNTtpi0pOX4kba8aq/ZtW039QsgH0CX4ZG8eXX1zu5fXMiSrfXJxhA7njn7/GTwqsj/2Y6hQQaauelvw41ZeXb1IWjODWFURl+8GmshEWI1GldRbjksXjP1OX1LbO7uGMt5gBG/8+WAdQneHBeSab0Zxk0wiRW+pswOBZIFUoZqGm3eAvP9MqTtGqzMu3xoC6uKmeXZC9RKzp8LnRu1NTeFU4vgbOO6jc4ve6XyXRqdJPkTs5AGsFnif62wSd9xajv/7AO4QfKzHqVYQLLJkzHHr45qmKbH2IS0GBS21RYtwFHNfU9iAIJChvVn3i2HaOTfz7zX37koC/ua8C+E4xScx4uEMDr04G8c3PRh8Vog4x5Az0vujWhUo9DJdf2Ikf8aDlC/LdWXOUluwwIBGnbuXLL3HvnnwZbATTD/P4lNIrmGMlPDhF7u9O9bdqMokLMK4f3tVal0aXNEfdNw98kvB9Sggx/FcA1jjwpwHMriBoARjlhagaV268zUsncPtFgfMZPYBq8gRhld2DIUf1Dlpp7LGwMSPiJsOMUTnLAxLvjtiJEb4awEOq85MtHPEIWgqyDa3t48N0RYAVS6Ql5G2T25Wsc69qo2lBQi4/l6sSd0TT+l6D520RRr/1CnBhQqInmrGjzDrMNZ446FgMzfaEoO0wMp0FnJMDiDAFrcNcKJig==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(136003)(396003)(346002)(1800799009)(451199024)(186009)(82310400011)(36840700001)(46966006)(40470700004)(7696005)(6666004)(478600001)(82740400003)(86362001)(36756003)(40460700003)(356005)(81166007)(40480700001)(36860700001)(16526019)(1076003)(426003)(4744005)(83380400001)(15650500001)(2906002)(44832011)(2616005)(26005)(4326008)(5660300002)(47076005)(8676002)(41300700001)(8936002)(336012)(316002)(70206006)(6916009)(70586007)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 17:48:00.4518
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdf9b4a1-ae5a-4e4b-1fb7-08dbb54abcee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4317
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset translates process/security-bugs and
process/embargoed-hardware-issues into Spanish

The first patch translates Documentation/process/security-bugs.rst into
Spanish

The second patch translates Documentation/process/embargoed-hardware-issues.rst
into Spanish

Avadhut Naik (2):
  docs/sp_SP: Add translation of process/security-bugs
  docs/sp_SP: Add translation of process/embargoed-hardware-issues

 .../process/embargoed-hardware-issues.rst     | 341 ++++++++++++++++++
 .../translations/sp_SP/process/index.rst      |   2 +
 .../sp_SP/process/security-bugs.rst           | 103 ++++++
 3 files changed, 446 insertions(+)
 create mode 100644 Documentation/translations/sp_SP/process/embargoed-hardware-issues.rst
 create mode 100644 Documentation/translations/sp_SP/process/security-bugs.rst

-- 
2.34.1


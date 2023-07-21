Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2889E75BD21
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 06:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjGUEMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 00:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjGUEL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 00:11:59 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E592D53;
        Thu, 20 Jul 2023 21:11:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K6Ken3s4BtIerKwN4f3jQDWgkZ7Zjfbt7AXq3AdRxE/WD5HQPbbHvCa1jVe8QJoSvqMVPVCLm3EQfZGU5+LRy4RspaT1ADi+SzAXnYwTdQMtE52yplmkXBhqvV8xIUvUlOsb65udX5vlZz9gOwqfpLO3dGfeoK03nzYSAJ1bC4jSwwcWI1Hw5v+c5s3cDEflMs9qWgLtW4SGBrgRKqh7VfeH5EeLpXaxlE0Zf/L5rMd8CEbzGt+Js9MbxttIflST+SBznqpLnIifk+wjBqBpkdnc3vU4TSQ9EmAWB3CupDnocLJrBNz29VS85aRLO0zcPEyTZDOrWAKZK2Q6yeXMmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PbLQYhDxuVFSTKvf7VgOIyW1Xx0qX62Jo1O9HosdcGo=;
 b=oIS83YRo6vpZP6AgGFNtfGEck+wHmzc90FOwjlYQLocs3XaCthd9qRnGvqsTXH0VkJ+X0tFSmyh+wKSGvNPNj55cevU7ZQ66ZdPf40b/yUwDz/HeDBFwG6Sevea6rARnxpIrlZAKSChmXvMV97tVLBbda2dgwHMu6z74HPyjs4S6lJGtdkqDV7ZGRYq3J94lBnDchRBnR+mDiGB8mB5Lcvjeo4pkeQnJUhMF0i4/cIVDEwRCT+LaWuJyLYt0WH91f8gqT1eVfLyPaqtf095BktEae3Q87l0jf8uix2FfmZNs7yu0G1WsMsllTVAvFNnWLCeZ7SNKBjrHSUdlVX6Lrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PbLQYhDxuVFSTKvf7VgOIyW1Xx0qX62Jo1O9HosdcGo=;
 b=FV66upQLWkdQ3tgzbW6jHt7O4Iw6P5yZ/aqwqjk7H9W/hoOj095KOFnt15h/xJe8GAa17+5KRg/6+Z4rNjnezrTg2fGpo+cb1YJosx1diO1Q0czNX+Gdmlpx/s6jp1PDsGHzjnCaLFBfuTsisssGi11Pn5t58tZyGPwaswsW06M=
Received: from MW4PR04CA0337.namprd04.prod.outlook.com (2603:10b6:303:8a::12)
 by BN9PR12MB5273.namprd12.prod.outlook.com (2603:10b6:408:11e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Fri, 21 Jul
 2023 04:11:54 +0000
Received: from CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::70) by MW4PR04CA0337.outlook.office365.com
 (2603:10b6:303:8a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28 via Frontend
 Transport; Fri, 21 Jul 2023 04:11:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT039.mail.protection.outlook.com (10.13.174.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6609.28 via Frontend Transport; Fri, 21 Jul 2023 04:11:53 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 20 Jul
 2023 23:11:53 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 20 Jul
 2023 21:11:52 -0700
Received: from xhdnavam40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Thu, 20 Jul 2023 23:11:50 -0500
From:   Piyush Mehta <piyush.mehta@amd.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <p.zabel@pengutronix.de>,
        <michal.simek@amd.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@amd.com>, Piyush Mehta <piyush.mehta@amd.com>
Subject: [PATCH V2 0/2] reset: reset-zynqmp: add support for Versal NET platform  
Date:   Fri, 21 Jul 2023 09:41:17 +0530
Message-ID: <20230721041119.4058430-1-piyush.mehta@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT039:EE_|BN9PR12MB5273:EE_
X-MS-Office365-Filtering-Correlation-Id: acb62e40-0ee4-4178-97e4-08db89a09dda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NISNFOsnJ2rNsF3CKlTc3Iji1ENXGzu/dzgsejWG0y3XXLhPMLZNrAWF+gCkJ3+P8Jw1SVCTKrGeq8QmRlOlUOX/uhnxkbo4ErF7+1cVEHBDNaY1J8kli/TMHNd51KmTZdGHJozsCvgwJH4x4V/ZGwOAWhF16QjqBTKhljHQNlBr7Hz2xqhE8O+ET0KZXH9rMAc1q2MULuMhWvnIWXtOnps9bWjnt5Acl56no9fq6retpT8yusfsojEqRHRlC9TT3AGoUJGlNKz/DpAlqjCKLiANjqPPWTohanQT1N8/OzkZlsG2+547Bll4e8b4COy3FW8XkKQDT2aM6djGkJIfEu09SI3ReU6YzE1BuLmJDNQJr8fQ3iPpbgxDgx7hrCCybaZ49t80dDsiRbPrTvAfNHZmLvQLIgxKc6Mx/7vz5Ps7Jp9sRExFNq4KeFpO9r8qtZlTPZfRnLqlxY5sGygoqvtGn1udRkwEtrryBts2jB6/cwqThDEo4k+uq0ahZ+8YHMzlXzZN4mLu7+jhgKBLAH1pHnpHCZkVNSrjwzASVUE/MSkzlH3bqxl+OC6z4CdJJnTrIAl35T3f0aAUUzpsrkLZ/8C4RLgMAEknffptrUZTNJMBdsTHpI35D2hliGt4pN1lNyl9IMe+9fAjOnZdztXuEZa16hCUTQtsZDGbBtwoHsWlOXgCD7I6TSTURIjFtW/ZNUmFbg+grLoROlxQv2GwuzH5tE+gwL0lZyIBJidKDXQoQugqYhXO1FHK2XFoYFms8ktTIGCjfMcnbRjd0g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(346002)(136003)(82310400008)(451199021)(40470700004)(46966006)(36840700001)(4744005)(40460700003)(83380400001)(2906002)(36860700001)(2616005)(426003)(47076005)(356005)(81166007)(36756003)(86362001)(82740400003)(26005)(40480700001)(336012)(110136005)(1076003)(41300700001)(186003)(6666004)(966005)(4326008)(316002)(6636002)(54906003)(70586007)(8676002)(8936002)(70206006)(44832011)(478600001)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 04:11:53.7616
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acb62e40-0ee4-4178-97e4-08db89a09dda
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5273
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extended the ZynqMP and versal reset driver to support Versal NET platform,
accordingly added compatible string dt-binding for the Versal NET platform
specific.

The Versal Net  device includes more security features in the platform
management controller (PMC) and increases the number of CPUs in the
application processing unit (APU) and the real-time processing unit (RPU).

---
Changes in V2:
- Addressed Krzysztof and Conor review comments:
 - Updated the commit message [1/2] with detail description of Versal NET SoC.
 - Removed the dt-bindings include versal NET header from the binding documents
   as it is not used by the driver.

Link: https://lore.kernel.org/lkml/20230717112348.1381367-1-piyush.mehta@amd.com/ 
---

Piyush Mehta (2):
  dt-bindings: reset: Updated binding for Versal-NET reset driver
  reset: reset-zynqmp: add support for Versal NET platform

 .../devicetree/bindings/reset/xlnx,zynqmp-reset.yaml       | 1 +
 drivers/reset/reset-zynqmp.c                               | 7 +++++++
 2 files changed, 8 insertions(+)

-- 
2.25.1


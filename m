Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1867C5787
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 16:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232512AbjJKO4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 10:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjJKO4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 10:56:15 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D2B94;
        Wed, 11 Oct 2023 07:56:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EsrQrWKhzoT4V9udEn4SYergsTi/Eje5SvXB3p0buUXgo110oMji4TsTY4cMw0WhqCbT/pIiyi4MlRTcwWrE5JbvT4S/Wpdy+SWGaPwcY6YVB+f6mzpYkIESw0ibnjc9aTabH/VCxsecPYcrgYMf/WTTq2ccPcP9wMnmRcBm1BN0ePQ/kCsm9BDY04U0n4LotqLYFi8Y+nCZlkKpWRiFTtQNaRkdXSAW6VxFox6kGCbUcES5of9A6s+kS8VUdujl5apEsrjjPyyHgVqQTWQWSbuAs7WrRQRQOYAHTkaUwS8cV73uvMkh76+SOa9YyFTY+o1NHZ8ShUPoR7nCMIRhvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WTZuU97T/nd0HNvsHkCqgZJ5An5LTGnuwhiUR5qHSkg=;
 b=OqF5/neA37K8J1OYpZKM5L2foY3DZKz+JZorGLyTRAyp1tsiJz2l4YY9ajl7Og/aozQimxm2efxSv6pCN9CtQOjtMa0r5b8lxbZXvJZDFD74NUXWSo8sFQX/H/xbWyWSqAeZ476GHVEJoSykiIiyyUrADbG8O9Cim0nqUli2lxADftd/cyQiaFDF6VSNLcTkYFZyOs2pkv7izE2v5vqqcwPhGfvw8cjIa13pAbxRnjfqLOg4o7/WAtuCMJa7Y2OF2dl+dMpIK2djfdxFelwBj/O7rirDXKPfVKQVBAyDgnV8nDH3tJ7HVBcpwhH0sMtI6z6/h4CRUHb4OS+Vov5AnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WTZuU97T/nd0HNvsHkCqgZJ5An5LTGnuwhiUR5qHSkg=;
 b=itDfPbJ/xZ55io+DNclrlKzJUtWCZSDLGAkjLs0Y5n2JDRsyni3fq9mH7R3XbMFN7QU4kFFYXfO1+BFJRIVJux0f9hsHT+1um1oe6GarNppyo8Pw8yM7XbVH9JZtLaImNjlyxqdUIVAB053nZ1gzfktjpd1RUyucPGm3zGJJ89E=
Received: from BL0PR03CA0011.namprd03.prod.outlook.com (2603:10b6:208:2d::24)
 by CY8PR12MB7147.namprd12.prod.outlook.com (2603:10b6:930:5d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.42; Wed, 11 Oct
 2023 14:56:10 +0000
Received: from BL6PEPF0001AB4F.namprd04.prod.outlook.com
 (2603:10b6:208:2d:cafe::f5) by BL0PR03CA0011.outlook.office365.com
 (2603:10b6:208:2d::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.27 via Frontend
 Transport; Wed, 11 Oct 2023 14:56:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4F.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Wed, 11 Oct 2023 14:56:10 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 11 Oct
 2023 09:56:09 -0500
Received: from xhdsgoud40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 11 Oct 2023 09:56:05 -0500
From:   Manikanta Guntupalli <manikanta.guntupalli@amd.com>
To:     <git@amd.com>, <michal.simek@amd.com>,
        <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jirislaby@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <radhey.shyam.pandey@amd.com>, <srinivas.goud@amd.com>,
        <shubhrajyoti.datta@amd.com>, <manion05gk@gmail.com>,
        Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Subject: [PATCH V2 0/2] Add rs485 support to uartps driver
Date:   Wed, 11 Oct 2023 20:26:00 +0530
Message-ID: <20231011145602.3619616-1-manikanta.guntupalli@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4F:EE_|CY8PR12MB7147:EE_
X-MS-Office365-Filtering-Correlation-Id: 90c1400a-b71c-4a64-454c-08dbca6a34b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bONnUggd1fsNFsaQu2A2NO5cwV0HiiFuTsgujHG+S43q5D5+e752l8o2YDfSKB57U/KMcgoks0AH/2afJp4gewOZ5su/uYjlXlUsZIoA4FmUTJKXxK7czulKinSMjLTzmyUAPST8Yt46bKx2tzq5MJHrJTWNza3AKnzYi+AVtZH5MLomTaxjd28FPKnEBOYGRJFdHZRW9C8zPjpbRToAA1Br42H69eTblHFIXh2NZLpYaPHxqg6fuo6QmDhk+t8c3LJWlKSdvezRaHZYJczjJMdB3m49WrDaeF5+QxuB9Q1FD/RrjahNISNND44V5T5z50h9SztWx34jprbbdu8IjgoLZfrP6lWJKDO44UAdBxnuGEhNrrW1Dtbjn70oYDLzbzlRJHqvGenuPF8UtOv4QL2WNoyYg40BwGfsZY4fLL5Sw04P+Y6/qfRcNZsXLqmbZxvLlhG2jj38AzDKFH1WfSq2W3eE3xlK28IVm1ScSdXdNi/5phabPd1bNucQuXeHS+MykiVog3skSiA1W4BTNJ26jUc+tkw2CXcY06WLbol+WGrT4jqFMktXA5orOex3M24mPyMp31KBObh0udsPAF+/N9Qxvcr6kdN1eHImuViCCE/4qlRbocZpLkf1vIMlgJxVABgdGMlmsGIZLLU7ga8lueaJ3zgV2Cg3lAUOx2kIQlLtyAVLr+NQocu4JNfquCPbLkQnDkDH6vEmHHW7XJGJd921hVTHefOQfRUSNmBXVHQic468wujMm7Vm4KdHC+wJIXXIs8KIOmTwXmcOmVe9WodG1JVkRWxmbZm57RI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(39860400002)(346002)(376002)(230922051799003)(451199024)(1800799009)(186009)(82310400011)(64100799003)(40470700004)(36840700001)(46966006)(40480700001)(40460700003)(2616005)(356005)(81166007)(1076003)(41300700001)(26005)(82740400003)(921005)(70586007)(36756003)(86362001)(70206006)(110136005)(316002)(54906003)(83380400001)(4744005)(44832011)(7416002)(336012)(426003)(36860700001)(2906002)(8936002)(8676002)(4326008)(47076005)(5660300002)(478600001)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 14:56:10.2424
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90c1400a-b71c-4a64-454c-08dbca6a34b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7147
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add optional gpio property to uartps node to support rs485.
Add rs485 support to uartps driver.
---
Changes for V2:
Modify optional gpio name to xlnx,phy-ctrl-gpios.
Update commit description.
Add support for RTS, delay_rts_before_send and delay_rts_after_send in RS485 mode.

Manikanta Guntupalli (2):
  dt-bindings: Add optional gpio property to uartps node to support
    rs485
  tty: serial: uartps: Add rs485 support to uartps driver

 .../devicetree/bindings/serial/cdns,uart.yaml |   6 +
 drivers/tty/serial/xilinx_uartps.c            | 116 +++++++++++++++++-
 2 files changed, 121 insertions(+), 1 deletion(-)

-- 
2.25.1


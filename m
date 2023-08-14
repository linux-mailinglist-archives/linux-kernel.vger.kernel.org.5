Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D8077B692
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 12:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233896AbjHNKXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 06:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234016AbjHNKWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 06:22:44 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD6094
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 03:22:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WTr6v03tpmCftaWSZRAf52Vfomz39OBSxqb2qCOw7BhE1AlRyAffAZ5l/11zdeU2CEo3d+GZsplqDtBiP7pApyoPC3ONc7k/sTxzirxIEyJ4nLT62inA0ONZRo4ZLenbtCZR5lWuVaHYuyuZ9ihuf9GNpAsKaOnH9DHi+oQazr0HyPUbsFamiCRpTUdL7BGdEdUIzvQgnaLiacxBuw3+DKtuovN7dUObfcdXPHw32UN26U+DAIdXRBj9RkXz/JFHNko8wqsOaSzeB8ZJmUV3B0aqI11kPB/EhW3GTIarMa85+9cA5XOkXoUvv4kp3GqOP2uXYloJ8xjjKcUw0flYDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i8C0VYzEcQ2CIPx9OOIb91Zg9b6aho+B937CIcbDK2M=;
 b=Auy2QHVh5EF83QQN6mIbiUvurgXVOl/1bT/WEciWrNc6CjT2suNfVQycvo/pFatvUQzsgFRPMutRYqxC1r6i4Hp5xeqCz6ikYaxlydErypmf8OKt98axeVRt42NauUGj4jxeSx3dyFKuClJCYVqMGaTn01dv8/ZgPIo5UuFf/msqUOo+h1UxboS4CxBYkc1UgBLaibs62VWgVUeu5W7C5DCgNEVZO6ZvGfLCHKEC25vExAV+zG2tUz9Ev35xNldLEM6LaguENU5Jo/O1JmssgEuE0FqMSoB/pCoeej+i4Kewoi1BsMi+GvNEQKLO6Ed8gEK4aEMd/thDkG3/IDajRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i8C0VYzEcQ2CIPx9OOIb91Zg9b6aho+B937CIcbDK2M=;
 b=mWhtGkf2Dd2mMtotmaa6EkodnXYOcFR30AXP250a5PzYPGWD8uC3q3PCMdDZkcY0D/gvyYo1GkZe/MDxiEtvn8y1d9Vc1qaDa0w/qjtMSQTOP+XZFN4gm+gEqKUzcT3918N4Naq87jnX1UJtj+jQWbP2N3u21hOlzJ+r/evrgVU=
Received: from DM5PR07CA0088.namprd07.prod.outlook.com (2603:10b6:4:ae::17) by
 SN7PR12MB6716.namprd12.prod.outlook.com (2603:10b6:806:270::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 10:22:40 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:4:ae:cafe::3e) by DM5PR07CA0088.outlook.office365.com
 (2603:10b6:4:ae::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Mon, 14 Aug 2023 10:22:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.13 via Frontend Transport; Mon, 14 Aug 2023 10:22:40 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 14 Aug
 2023 05:22:38 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 14 Aug
 2023 03:22:37 -0700
Received: from xhdipdslab59.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 14 Aug 2023 05:22:35 -0500
From:   Abhijit Gangurde <abhijit.gangurde@amd.com>
To:     <gregkh@linuxfoundation.org>, <masahiroy@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <Nipun.Gupta@amd.com>, <nikhil.agarwal@amd.com>,
        <puneet.gupta@amd.com>, <git@amd.com>, <michal.simek@amd.com>,
        Abhijit Gangurde <abhijit.gangurde@amd.com>
Subject: [PATCH v3 0/5] cdx: provide sysfs interface for cdx device resources
Date:   Mon, 14 Aug 2023 15:52:18 +0530
Message-ID: <20230814102223.418046-1-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|SN7PR12MB6716:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d97c0da-9c52-442c-170b-08db9cb063cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b41ecSGsiOysiIv9ee0tvtVpRqqGVZb/yJV0OCI5wfnXVBPdCw4cd1JXvArQiVVMV9rjP+6Fb4L1Yg0BiB/RZc6AnrdR0q3PJbFtdXLx4dQ0JHyiIhG2stNz2ZwDQ9VbhGiITiCEYTXelZ9HXZWINxtBr05nHM1J7fFYry71lOu5VjxPdURXIF4UaqZkK8dhM6qdE7Hz7SWBM2w7+oSRFFK4kBHGYVYUw/S3QaAlVBUVCCwhdiu1AFHHzTM4Kn0wwX8YGI01+1RzW7Qq6pdhr2bg5qu3JcB6Sd6sdFKah2vtOTEZWJld0MvwmHZMC3pHYqgYvaiJHkSlY6v1qFsoYY5lIfbgP4Loe7ba0JUyBWNHVKiq94bqTO1BVY6RvFmoOpW8a+44AoyuR8LoMacS1ApsVSGMcdwJS6XscBWv0kVbeeJg0FAIYLMY4uj4I0AqWPXO0P9UWLxCuJoMQEkM1AdlqIxRrLIzHPpSu+yZc7RjVstY3NZD+tU6yxmc+N2b/JbVt2UklCfuucJtsVXttvRNtf74pVCTa8k4VrDCYWYpeJadrfqG52LOJwW2DBEaUyLYYH42QqzXi5wFziT2UO1C0EW/y4bPQ5nfoCtxesdZ/9vCEslS+QiPTCCK8YN9EwKurPU/r24pb5ryOZK6T9hqlCP2+z0lXR11zCXZay4HYJHHyYdiOLqEvbd3GULCCXPzNWKpdAREin8+2jT96QNm7StqzlVeg4PNp3K+HfT+kUbKzcTWGMdoiCMuHSQ6cjVOi5Ecocwpf2zLzEfV0A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(376002)(396003)(82310400008)(451199021)(186006)(1800799006)(46966006)(40470700004)(36840700001)(86362001)(40480700001)(40460700003)(2906002)(6666004)(2616005)(26005)(1076003)(82740400003)(54906003)(316002)(70586007)(70206006)(478600001)(356005)(41300700001)(110136005)(81166007)(5660300002)(44832011)(8936002)(4326008)(8676002)(426003)(336012)(36756003)(83380400001)(47076005)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 10:22:40.4656
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d97c0da-9c52-442c-170b-08db9cb063cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6716
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series provides sysfs interface to
 - enable and disable of cdx bus
 - reset all the devices on cdx bus
 - subsystem, class and revision for cdx device

Changes in v3:
 - Remove local cdx controller list from cdx bus system and
   instead use platform bus to locate controller

Changes in v2:
 - Introduce lock to protect controller ops
 - Split sysfs entry enable to enable and disable
 - sysfs entry enable and disable take bus number as an argument
 - sysfs entry reset takes bus number as an argument

Abhijit Gangurde (5):
  cdx: Remove cdx controller list from cdx bus system
  cdx: Introduce lock to protect controller ops
  cdx: add support for bus enable and disable
  cdx: add sysfs for bus reset
  cdx: add sysfs for subsystem, class and revision

 Documentation/ABI/testing/sysfs-bus-cdx |  87 ++++++++++
 drivers/cdx/cdx.c                       | 215 ++++++++++++++++++++++--
 drivers/cdx/cdx.h                       |   8 +
 drivers/cdx/controller/cdx_controller.c |  50 ++++++
 drivers/cdx/controller/mc_cdx_pcol.h    |  54 ++++++
 drivers/cdx/controller/mcdi_functions.c |  31 ++++
 drivers/cdx/controller/mcdi_functions.h |  18 ++
 include/linux/cdx/cdx_bus.h             |  41 ++++-
 include/linux/mod_devicetable.h         |  10 ++
 scripts/mod/devicetable-offsets.c       |   4 +
 scripts/mod/file2alias.c                |   8 +
 11 files changed, 510 insertions(+), 16 deletions(-)

-- 
2.25.1


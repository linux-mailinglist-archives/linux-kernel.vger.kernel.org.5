Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 221C97FD5A1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 12:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233023AbjK2L1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 06:27:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232607AbjK2L1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 06:27:35 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2052.outbound.protection.outlook.com [40.107.95.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAAB8D5C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 03:27:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L3Nx5j649DfrdA1AP3OqgJha1CFbgbHRJITEmo0mgoI8IYTzEoCFDEIzls5lX6sa23GIYPIrwF/kl4kG0zORAGQO3l5Zn+O4XiOrVFXlTUNhlZmtycpghU6IagL6v1EqMRuHqGC642g66sj717F7xPb8jzPCq3keNdSnu1ptVq5K2LZKaJ4B628GOuu6T1+pI8TjpqylH81TYZeXmRnvcDYUVatlNdqZ8XlREz9vmzs7v0nGcoD93+jf9HmO7gda+TZDyIf0TAA5OEiYcZw0HjBfe4TpkHM1YWxWGNd/TaSn4w8RRDsJePByLH8xmGAvUNSZhjcei1Fzf2Dx/J20xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9KTMhOuv4uA3Yrr4UWpwqWwm+9e2Naf8fnZXz90ugM=;
 b=JxotdSPz2ZBbUxe0xYLn8XYs/Bc20XXDsdYhrBVWtUTaATwrey9rM/BapRhVAvdBaeXN+LOKKbkA7BZwxCxJusZgzZwLJ4qv2GVZHEdzlZKatrOYtLhOTO+1npte2NC8iDwuLgQOLOPDu7UOmosEoy8l28agbwvYpmziyhHQsDuORVdGv/rwgsWh2vAawSt8SV7C32gr606Qq71OMvVo7TxEm+6AdPTWnTGYWw7G2U+3m6CsQgfsaBvIJpWXQKSuC6Z3STCw3o1dRZuwjQIuznrBVTB2rKYHZFAM5woNuUEGRnj50huIFumGzcRh8Sn47Rd+VGpbravEXESWGBin+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9KTMhOuv4uA3Yrr4UWpwqWwm+9e2Naf8fnZXz90ugM=;
 b=a43EHdRwmAfo70EzQrIQF63sK3w8tpj/4FiWG55Lul3PuPU5cTmsqc/Jl7a7fnDivwjccPcxRX02JliO736Y9NPo7V78dZtvMxYE/ESVexqOM7nKuc0qywn8YA0LE2BtzEQq4aOqMU9UaIuIwpoxPBK1ALJa9AxlV+hN77WutlI=
Received: from BLAP220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::15)
 by SN7PR12MB7854.namprd12.prod.outlook.com (2603:10b6:806:32b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Wed, 29 Nov
 2023 11:27:23 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:208:32c:cafe::5b) by BLAP220CA0010.outlook.office365.com
 (2603:10b6:208:32c::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29 via Frontend
 Transport; Wed, 29 Nov 2023 11:27:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Wed, 29 Nov 2023 11:27:22 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 29 Nov
 2023 05:27:22 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 29 Nov
 2023 05:27:22 -0600
Received: from xsjarunbala50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 29 Nov 2023 05:27:21 -0600
From:   Jay Buddhabhatti <jay.buddhabhatti@amd.com>
To:     <michal.simek@amd.com>, <gregkh@linuxfoundation.org>,
        <nava.kishore.manne@amd.com>, <sai.krishna.potthuri@amd.com>,
        <robh@kernel.org>, <marex@denx.de>, <arnd@arndb.de>,
        <izhar.ameer.shaikh@amd.com>, <ruanjinjie@huawei.com>,
        <linus.walleij@linaro.org>, <shubhrajyoti.datta@amd.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Jay Buddhabhatti <jay.buddhabhatti@amd.com>,
        Naman Trivedi Manojbhai <naman.trivedimanojbhai@amd.com>
Subject: [PATCH v5 5/5] firmware: zynqmp: Add support to handle IPI CRC failure
Date:   Wed, 29 Nov 2023 03:27:13 -0800
Message-ID: <20231129112713.22718-6-jay.buddhabhatti@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231129112713.22718-1-jay.buddhabhatti@amd.com>
References: <20231129112713.22718-1-jay.buddhabhatti@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|SN7PR12MB7854:EE_
X-MS-Office365-Filtering-Correlation-Id: 83a115a4-9604-4ad5-44b0-08dbf0ce27e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qTjIdL49/eQsmvgfCOI8S6j83FzyCMHlpwap3eV7Vgk9huKerU4U5Nm9Zsk9GN1hSR1IuA0gRmJuVVT/x7ZwQQwmPDJrsd2mGpvEnB7I2zAzRMo7XC7+XQjtL6GM22uijZBaJEMugVkNVR0OMmXvxphhBaofdurKTtS/HzbELDM0MmvezCHnxQV/FlDcWxGx4YrIGmoHsgG8eSTt631JqprnY8BlsGlSCREwO4EJ4amV83DRDuaZMt7UWwKUfXBLQ56FC58FyakDvAmqH0aCLDblQbwtostCxQ4Mw3os/zYnqB+tWyOadT+jVV6ZjEUr9GTWEF+lBaIzC+P5NGqj2VLdCKfzdFVD/Wvx11D8K6qnmeBMJNcdDF+bV1gVPfJ1SL5euAK3nOMs0j3bt/xxsuJxT1CDRes+zlEq+187j5tn7Lw03s4G3aGmeD2lVGU4ORsrA5lNC0ecUxvzHbFomnS4Ho6JXsgOVjG5Ko6DXfcf2jRll8Zv6xlf82waRntncbqmcFRPpIthejldGLHx/S3KetIOWG1H98fyArBc+UliFMO7qC9+5oi/kvF0gEzukRfnSC2buZvyNOPOELxtfKw0W5jEm7KRK/MaLllriLXM/PIS1o47TbFMtG0miHYtNcOyrXNQxyM/cm1d1/yZacYfNERdO4NBUS0Q7IQVTdPf3huqm5jWRQve3f3uxQwlmwm9eGA77nxbHAvjWHoHpBddAIJZW/QuFgo8DwYQU0TBUIuf80/ButbWDumHpJVFJrs4trSUC6QqlpyyIp6DAUQEZXlmVDCY4kwUdUoJLH4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(82310400011)(36840700001)(40470700004)(46966006)(82740400003)(426003)(336012)(36860700001)(40480700001)(81166007)(40460700003)(83380400001)(47076005)(356005)(2906002)(110136005)(86362001)(44832011)(5660300002)(8936002)(8676002)(4326008)(6636002)(316002)(70586007)(54906003)(70206006)(478600001)(6666004)(41300700001)(36756003)(921008)(26005)(1076003)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 11:27:22.6116
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83a115a4-9604-4ad5-44b0-08dbf0ce27e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7854
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added new PM error code XST_PM_INVALID_CRC to handle CRC validation failure
during IPI communication.

Co-developed-by: Naman Trivedi Manojbhai <naman.trivedimanojbhai@amd.com>
Signed-off-by: Naman Trivedi Manojbhai <naman.trivedimanojbhai@amd.com>
Signed-off-by: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
---
 drivers/firmware/xilinx/zynqmp.c     | 1 +
 include/linux/firmware/xlnx-zynqmp.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 84fdec772a46..00f87c81b293 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -103,6 +103,7 @@ static int zynqmp_pm_ret_code(u32 ret_status)
 	case XST_PM_INTERNAL:
 	case XST_PM_CONFLICT:
 	case XST_PM_INVALID_NODE:
+	case XST_PM_INVALID_CRC:
 	default:
 		return -EINVAL;
 	}
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index c28b1d69e6a3..7e6cb8cdcd10 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -174,6 +174,7 @@ enum pm_ret_status {
 	XST_PM_SUCCESS = 0,
 	XST_PM_INVALID_VERSION = 4,
 	XST_PM_NO_FEATURE = 19,
+	XST_PM_INVALID_CRC = 301,
 	XST_PM_INTERNAL = 2000,
 	XST_PM_CONFLICT = 2001,
 	XST_PM_NO_ACCESS = 2002,
-- 
2.17.1


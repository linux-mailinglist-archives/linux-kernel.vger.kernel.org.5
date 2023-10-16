Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8177CA660
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 13:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233254AbjJPLN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 07:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233053AbjJPLNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 07:13:45 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2044.outbound.protection.outlook.com [40.107.212.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD935E3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 04:13:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iAwYgz9yZ4IK68RkTunTYCJU3Bt6N19E+cG6/1/8amboyORosCLyTOdLqjQwZPkKGjhNKi36/t2jlyu01bF8Pb6j8DAbFWgiFh85WkDQ78gcDPZWhIxzZMu95/maKzAUXyqKUN3NPg/JMfOQ4UOphXgTLmgxLMnZS7Y2y9i/J4blWlLkWmhgvVA7vX3gaDXz3D3+vzyyIwkEvuf//NzoXVTlvEmOV9FA15mN+3L5MUXfGnAzOYfonEn0XRpF7U7UtyQMIFGjnJ4PMOxxBvmwEZoXa1AEBszLsSXnDLxzTHxQMYdAQv+gdyxnE010roxjavLoyk+CsWghBG7L8uyABQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NXY4j9RBaywm4BtUACIAxxbEFr0Orn+oqy9voYofOf8=;
 b=AfKAncLrztwNh/8c35qbnS+dvVlp+InJse2g9tBdbY7yh0p9p3Sk+RxAyaPAvdZp4RxR+SLdHLaNhWIqHF0YhW9TIKTiAgHx7uYIGWFOKgsUnzW60tOqb8FeEvjoRboCHpQvSHsnLlKqONIftkCkVj+Zo2NM6LBcX8bnBScZh6nNGgmpxWxwmOg/McZeTYkR3vju0kIzNhbezW1gWOGJ1OVGuR/b4rDzeEudBGMQ/Ywfj6asiKPu9hM/v/enccvFnzkb6cNyvjTVCDom4MS0GhHkU7wZTUBVvJCkgvxk/GnuJHYiP1K4BhGh4YQti3zFLQwbnIlf9lEx7uviFoveMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NXY4j9RBaywm4BtUACIAxxbEFr0Orn+oqy9voYofOf8=;
 b=3AE6eSGi9xpMdAM+AhtRFO8ZYYSBkHbnYMPRkIEYmupV68AAhzB82pY9wT5m0ec+4WuVLshKQHzIUeYSu/W5nW7xqU7yOI719z22KXxuV+xW6PAbxF2k9BZLBJht4bSjd4LKw/ExOHZQH2F6LQ4D5EBpjzYHKT0LicT4jSHXVZM=
Received: from MW4PR04CA0356.namprd04.prod.outlook.com (2603:10b6:303:8a::31)
 by CY5PR12MB6300.namprd12.prod.outlook.com (2603:10b6:930:f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Mon, 16 Oct
 2023 11:13:39 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:303:8a:cafe::8b) by MW4PR04CA0356.outlook.office365.com
 (2603:10b6:303:8a::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35 via Frontend
 Transport; Mon, 16 Oct 2023 11:13:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.6 via Frontend Transport; Mon, 16 Oct 2023 11:13:38 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 16 Oct
 2023 06:13:35 -0500
Received: from xsjarunbala50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 16 Oct 2023 06:13:33 -0500
From:   Jay Buddhabhatti <jay.buddhabhatti@amd.com>
To:     <michal.simek@amd.com>, <tanmay.shah@amd.com>,
        <gregkh@linuxfoundation.org>, <mathieu.poirier@linaro.org>,
        <ben.levinsky@amd.com>, <nava.kishore.manne@amd.com>,
        <marex@denx.de>, <robh@kernel.org>, <arnd@arndb.de>,
        <ruanjinjie@huawei.com>, <sai.krishna.potthuri@amd.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Jay Buddhabhatti <jay.buddhabhatti@amd.com>,
        Naman Trivedi Manojbhai <naman.trivedimanojbhai@amd.com>
Subject: [PATCH v3 5/5] firmware: zynqmp: Add support to handle IPI CRC failure
Date:   Mon, 16 Oct 2023 04:13:01 -0700
Message-ID: <20231016111301.13369-6-jay.buddhabhatti@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231016111301.13369-1-jay.buddhabhatti@amd.com>
References: <20231016111301.13369-1-jay.buddhabhatti@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|CY5PR12MB6300:EE_
X-MS-Office365-Filtering-Correlation-Id: d849cd7d-f714-436a-c84e-08dbce38f2a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pOh0WIHhWzCq8V5Hyyk4oS5Ud/DRi8yW7D5Ot6nxFQnst46Qul0mqA75dqG5Q+qX1Bm+C/pn7o1aLgcL+ntMi5Z46DKSYtRdGKVYw8t88Lw/OENMR4HY6zyorxPD97Oc7SSuxy0Kt/uCyul0yqvcTFAP883JCnDmcgbEiJRFXcSsXrKVyfkGTyT66g9UtPJW4+k72mepsa4STth2FI24Xx8YCjfe7JPj64Pizy4k0zAQ1gOQeFKeHBRagavRitbwAyzeDol8L+s3Yd4/QpipDLkkj0cyIQcv5zR/V+WyLptXQc8n/t/WRQsLGzH0g+vaWjS/kthpH7VYt0lrUxl56O3GFxNUQ7TUgTMpFDKDYJKyONCZq4zNYrcHgjrjP8CopdI0c+f9e6QSiS3OA6uuQkYpkySEnjFxD1qhqPIShmfzOLDdXzXnaeaEDDrh5dTrWkZtwMHsZTiBgY/8QYlXWYY4q8g13e3wPFl+iYfQvjHm+bY90owbxSKgGhBRgOE98DfwcG8vL2T4NBfUOSp0aA0UX0+xLhbkiKLvVo6nscEBA6+IZoXtipV2PMdUOq0N6E5fEBx2keAxGa7HsrtjYtUcaIfAbhIKM3sRnr2DdQG2EiyK0yWxO+F/1yEhFAyT1U5r+6QITe2IHhdqAH1F5lhd4MsnlnuUzc7f8YJ4xzkgiAptx03e2+xJlnvvThDkM7a/ekD9wwkUypv3stv5lDd3E39USmXctaTPLEz/oI5fF44lMpBpOHLqeigPqoaLz/ty8DG81gHaDUTBL+agum9l2CQNW+nRq25Bt2tqEW8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(376002)(346002)(396003)(230922051799003)(1800799009)(64100799003)(82310400011)(451199024)(186009)(36840700001)(46966006)(40470700004)(110136005)(2906002)(41300700001)(40480700001)(921005)(81166007)(356005)(86362001)(478600001)(54906003)(36756003)(70206006)(70586007)(36860700001)(6666004)(6636002)(316002)(8936002)(8676002)(40460700003)(44832011)(336012)(426003)(82740400003)(26005)(1076003)(2616005)(83380400001)(4326008)(47076005)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 11:13:38.6001
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d849cd7d-f714-436a-c84e-08dbce38f2a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6300
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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
index eebd47d482b1..7d79e6558835 100644
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
index 7abbb4ab4490..453d6f54a6de 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -162,6 +162,7 @@ enum pm_ret_status {
 	XST_PM_SUCCESS = 0,
 	XST_PM_INVALID_VERSION = 4,
 	XST_PM_NO_FEATURE = 19,
+	XST_PM_INVALID_CRC = 301,
 	XST_PM_INTERNAL = 2000,
 	XST_PM_CONFLICT = 2001,
 	XST_PM_NO_ACCESS = 2002,
-- 
2.17.1


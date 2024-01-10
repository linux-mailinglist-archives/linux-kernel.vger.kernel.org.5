Return-Path: <linux-kernel+bounces-22044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C633582985B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E9581F217EF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB0A46B81;
	Wed, 10 Jan 2024 11:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="090pK9T9"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1099240C07
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 11:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jfZtOEdKPRujDZBpKQoggK+bw234MX7gO6MXKHDGpIZVeVx+09bjnVvhamDg9IL66pNf9cBiJRNLmaDJETWq/RxISQoDUNdxt0KBLOLsAlFWLraVYHnjMNoN5DOdqdR9S/9MsHXfzzouYur0nBKY4CYgGUf00B8vNO+jvohKX1+0j+5QULK6eTF5uJCV9XG1jGlc009+J3nUgA3I0+LOBpfBLiY9ktlJDmeeNL+G1D1exlWoFalANNU2tcYXGXNE8xFeVRAK3XcgCJVSoeRVUSpHIVDqp2IDImybgJN4h+W1OhDiAXRYRDPsJk6G/Nz6eYuURgigiD2etMMRYIOpVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/cOE6gEG4Rh5N57xCK2a+LraEjxxwobm9S1nK1Uz+HI=;
 b=jIvNSZL3W9hSjrvum5gUcu/MCWSHMmqqmznGQ5AUhhCUet8G7yz66gIXnWBcUevafhedIPXlq9PqAgHMKpzGXxw8eJ+gFFMr1jY8y2Vb+S5eCqIf8XhywV0XMLJAvromvIS00qgzJQqUW93HqaR5bf+iDTjAzPl8PX2zcfjvJ0YCnRH+CM1Ka76HJQWqcx9LcT6DMxxiqb57EoFXKbdFX9KSWPqYXv8ivu+eFxeEm9EssW8cM3pFhkYe/ndrI3AIPoTe881aEahaGR+DR6XJs+bwcQ7mIfF4Geh/1eYzpbUE15BXtsMslDjXKDvKPX/6Dq743GmBex9j+qb7jGtgbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/cOE6gEG4Rh5N57xCK2a+LraEjxxwobm9S1nK1Uz+HI=;
 b=090pK9T94Uc4PvkKW79ysmuRyTe+MPw0MLHzMQYsd4jJr9Lf8GA/8a76Q7YitM3fqWZPBwAnVxA0MpCMPoWzK8M78iq4sw6nDeurCprapr9nKf1WldU+cHUWfR0RjQEQNgjtS3R6IsA+Xs6TzKqq7kxEkx3G59hjHq2d88t5wos=
Received: from CY5PR20CA0016.namprd20.prod.outlook.com (2603:10b6:930:3::19)
 by DM4PR12MB7696.namprd12.prod.outlook.com (2603:10b6:8:100::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 11:10:40 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:930:3:cafe::6a) by CY5PR20CA0016.outlook.office365.com
 (2603:10b6:930:3::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18 via Frontend
 Transport; Wed, 10 Jan 2024 11:10:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.147) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Wed, 10 Jan 2024 11:10:40 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 10 Jan
 2024 05:10:38 -0600
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Russell King <linux@armlinux.org.uk>, "moderated list:ARM
 SUB-ARCHITECTURES" <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] ARM: zynq: Remove clk/zynq.h header
Date: Wed, 10 Jan 2024 12:10:35 +0100
Message-ID: <d7b129c8e3f867c2fda5fb0adbb1983103c5be5e.1704885029.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=575; i=michal.simek@amd.com; h=from:subject:message-id; bh=RAcTP7dic5cJVbZTHa2C8q+324FvduJzQXkoZiYqddY=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtR51WrlD943TIj99VTmm7pYRPLk7l/mTxdJ9vQdn3lG/ 7LChBUOHbEsDIJMDLJiiizSNlfO7K2cMUX44mE5mDmsTCBDGLg4BWAiXyQZ5kr21VQ0X5m67qZs 8YEvTxalr/om/IBhfm6Et903JpHeGYkzd/3l7+vPW8J7CAA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|DM4PR12MB7696:EE_
X-MS-Office365-Filtering-Correlation-Id: c56304ff-b62d-4a25-2da5-08dc11ccc7f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0zbrt1MFFF7KCYuD4iNOVnhJTdtJg2JM21/SF1cgEKbkV9tVkjODoMnRtvXJU22ECj0KHAsVi9ueMFX5iZXbZ9nyvzanRyurgUvTs1wQAryWwajUIcBsed33+BzG99E7HCxBsPh633TbW9x71teM/ptk01RT0UF4iX1LtOrJChORth1E/I0VI0mGsowPjITnjTBrzESFl4piYqwB+oY9i4+Hv7vGqwfKQMX+pP+QIntfWIs5DUfezDE4sviW+zzW9p2vAOblxjUO/nPYmJJz5eowgmO07QW/V0IsEu/GgDfuNP0c52ntERza+Z4oeg82eSRH60jhp70kyGJQoPvFpc9NhqjwJd+1G2dyXY6pcmr7SJhB7J6H74RFSO0Q/IOaqga7MNISLkc+aRcc5m9u8OXea/T1XH5q/7P3ONHcmLTL99i6cUPnHoi+y77beXKrKJf/95ztsv1uff045SZR30iHI3vQKwW64hjSF5fAAZZf7bQaQq//mfcrgkTobS6hdKJbwpIdRGETNolA2pE1S4Oa1HZD+Oz0OTUihGVePl/b610zOGZS+QVkwWogC5zBFWIwFo8cQif7NQ78PPDk582/qwg+nZxVKl+f+pG6YaRnT99Qzy8YFQP8h0C8Y6I/gWqEnXX5Q+yVM8CAfc4kbZyuDz1l0wkHnjyQnv1pfFlVOO88eXatjzOrbN43Y7Hw4l+YB8f5Hj5UMQb346zXTGhCop+B4TBx1NHiutMiZG6NkyqP6+JnblnIKTSYK9qJWBl/NrZ309qDP6t1IsDHU69AYWlywNHHB2yKdZVr84I=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(376002)(396003)(39860400002)(230922051799003)(1800799012)(82310400011)(186009)(64100799003)(451199024)(46966006)(40470700004)(36840700001)(40480700001)(40460700003)(83380400001)(70206006)(41300700001)(70586007)(356005)(36756003)(86362001)(81166007)(36860700001)(82740400003)(47076005)(16526019)(426003)(26005)(2616005)(336012)(110136005)(2906002)(478600001)(316002)(6666004)(44832011)(8676002)(8936002)(4326008)(4744005)(5660300002)(54906003)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 11:10:40.4277
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c56304ff-b62d-4a25-2da5-08dc11ccc7f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7696

slcr.c is not having any reference to clock that's why remove it.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/mach-zynq/slcr.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-zynq/slcr.c b/arch/arm/mach-zynq/slcr.c
index 9765b3f4c2fc..c517cd4a7737 100644
--- a/arch/arm/mach-zynq/slcr.c
+++ b/arch/arm/mach-zynq/slcr.c
@@ -10,7 +10,6 @@
 #include <linux/mfd/syscon.h>
 #include <linux/of_address.h>
 #include <linux/regmap.h>
-#include <linux/clk/zynq.h>
 #include "common.h"
 
 /* register offsets */
-- 
2.36.1



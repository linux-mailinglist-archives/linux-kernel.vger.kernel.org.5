Return-Path: <linux-kernel+bounces-3258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED12E816A03
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94747284671
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77430125A1;
	Mon, 18 Dec 2023 09:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vvIiVoLJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2060.outbound.protection.outlook.com [40.107.101.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6947811CA0
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 09:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=djwz5RLceIr0pyCbX7ztiL4DdgvL3QxY5rZoDETtMofHLuuuqbfN+gMXlAaNcvpgHqxMnoxqptw7rilqJsiIBjbMK6e+UUAFI70ZvZykk8cjhTIcvIWGL/iJqIDgvVHsipM9RA6iuRFLsJs06F+ADFGD8jwjKt85uMHZbYq1AOMB8HjwTDvCZKFyXATkbsqXtFYZ8G6ZOtt4uyJOXbJ5Ey2U8+to5OTa20jEdUbTly+3cVeYXmHpUko5/QNZeIKC66C5nfu4wOYwCGVSKfZGkzM3p1/Hgta+5qRAF5m2lRO3fxXuu0dNnaHl8IZ0wfdaTXX2fYv135wGYIoOccRm6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/iTkEo/GDkyrKe3swsv8RETdMWLOTt6O26f7yFrU1l0=;
 b=QY1Zq32LjCMooqTsbvGRUAdinkaD9QEOyvtT52Qr3Tmvnx2iOaXOoCVuAEpUl0eFBkDmhpwBta1m+Tc17T5J69+C8rdEdgUDb5Saag0daV7L1KHcBjKvMDg2q37Tk9ckZUE49rHornH/7Y9+voY28DPwHZ9zPEjdhAUrzUsbkcAMy/GdiO2GJqsgst7SQZRNzfc1m8wygrOaBnbvy5O6RkCwThmBhIdA5mdAn9MVkNNU0P2Jh2QVYKT85luSkE6D00aNi8owb5p2Q7nEZjzZTptdNaUYA6bGwgRy0N13viG0TYzWp+BV5yswv96vXDL0H2HvBNqbsdUG+v3V57U+OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/iTkEo/GDkyrKe3swsv8RETdMWLOTt6O26f7yFrU1l0=;
 b=vvIiVoLJjHM+tiCH+6tdAp34xqkoKebwgI5b6mPCOVoq/kxoBUZeGam+5le6nd6oqiHgMJVTD7OPsVCPir9+Eu7hDFYl65FwIPSBX4OXFR+X0aHHM1YmciVl0Z49Zf1T4GLLDR1Mq4akoFYFFivp824uhvMvuqbo3WobXUr8Z8g=
Received: from DM6PR03CA0044.namprd03.prod.outlook.com (2603:10b6:5:100::21)
 by SN7PR12MB7980.namprd12.prod.outlook.com (2603:10b6:806:341::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 09:41:36 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:5:100:cafe::a2) by DM6PR03CA0044.outlook.office365.com
 (2603:10b6:5:100::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38 via Frontend
 Transport; Mon, 18 Dec 2023 09:41:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Mon, 18 Dec 2023 09:41:36 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 18 Dec
 2023 03:41:34 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 18 Dec
 2023 03:41:06 -0600
Received: from xsjarunbala50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Mon, 18 Dec 2023 03:41:05 -0600
From: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
To: <michal.simek@amd.com>, <gregkh@linuxfoundation.org>,
	<sai.krishna.potthuri@amd.com>, <linus.walleij@linaro.org>,
	<nava.kishore.manne@amd.com>, <dhaval.r.shah@amd.com>, <robh@kernel.org>,
	<marex@denx.de>, <roman.gushchin@linux.dev>, <arnd@arndb.de>,
	<shubhrajyoti.datta@amd.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Jay Buddhabhatti <jay.buddhabhatti@amd.com>
Subject: [PATCH 0/2] add platform check in event manager driver
Date: Mon, 18 Dec 2023 01:40:07 -0800
Message-ID: <20231218094009.13528-1-jay.buddhabhatti@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|SN7PR12MB7980:EE_
X-MS-Office365-Filtering-Correlation-Id: f44f0df1-a8e5-43c7-d376-08dbffad8756
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	R3wHFRBjDEwS6uNRvT645cz/1VFNqzsK2ZtWIEGvCeVdvvyrurmrB8d8/tOCqsTpZmu5QNHwoLiHBL/wqPHTC5yNi3NkVg1smQ/euTUXKNE51bbAMAE1TgG01DdfCQ07otwWRhnNUsisrEEcRDyjgpX4/A9E+as1GBFRnMOkDkRObjecF0bj+xjbY418NlVCDOLPGHVnfT2Y6rv0qZaYJxnXe5bCTAT50Fcfn3gpR6ZMJx0TvdIcizZ62Ztg98sn8+U7hgWqzUhpB8gBoJtH3REkAMpmrrHCc0WvKPHDV7nXMZBN9vxJZbXYimpbhEFiYFfIr0T45tV+FQRa2nYHmNDZX6Ee66+Rad3BxfC+CFA+frgKUn4A46xKmfydLm5b1n6v8D407cAK5uvhOEW/DSlcXDct9GCLkkVa04YZaWtPlJk2xM0rc52AAxR0RelxnvnZQ0D5z7xvnSQbQnhL1RcAh1rNT37cwtWhFEksbv414dd4kHx93CZ7dysYo+InniIG/t6GG6ezoP5j1q+pov2mfrjPwvmcAR9A8IHcOEgTp2fW5YEvbva8+AC1pE7XAbZFwIoyOoPS3dOTi0pd5mmL2h9LFS25xe7J9FJVs5VQN8LP58PItmilNm4Gwswl6t+KjDACD76NbkTgDxWbcZ2m8ppBjpETXL2Xt6Tc7zVLbhHqqPPY1xv6/D3e0yQyBMBbeEKUI5yfvEPPs5E7eKhX3iwoMU1kg2XgIGMshD851Swkg0Y3VnH+YrRDqs15zyzQIjipmuQvgAUBZTxuIjij5N8nVU6xUd3XDZOO+4k=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(346002)(376002)(396003)(230922051799003)(451199024)(1800799012)(82310400011)(186009)(64100799003)(46966006)(36840700001)(40470700004)(2906002)(86362001)(36756003)(4744005)(921008)(478600001)(36860700001)(83380400001)(47076005)(1076003)(356005)(82740400003)(81166007)(26005)(426003)(336012)(41300700001)(2616005)(5660300002)(40480700001)(54906003)(70586007)(70206006)(110136005)(8936002)(8676002)(4326008)(6636002)(316002)(40460700003)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 09:41:36.7315
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f44f0df1-a8e5-43c7-d376-08dbffad8756
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7980

Some error event IDs for Versal and Versal NET are different.
Both the platforms should access their respective error event
IDs so use sub_family_code to check for Versal or Versal NET
platform and check error IDs for respective platforms.

Jay Buddhabhatti (2):
  firmware: xilinx: Export function to use in other module
  drivers: soc: xilinx: add check for platform

 drivers/firmware/xilinx/zynqmp.c        |  3 ++-
 drivers/soc/xilinx/xlnx_event_manager.c | 25 ++++++++++++++++++++-----
 include/linux/firmware/xlnx-zynqmp.h    | 22 ++++++++++++++++++----
 3 files changed, 40 insertions(+), 10 deletions(-)

-- 
2.17.1



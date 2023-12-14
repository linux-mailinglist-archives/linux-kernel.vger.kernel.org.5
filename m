Return-Path: <linux-kernel+bounces-119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA869813C67
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 22:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAFEF1C21BC4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 21:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07496DD0E;
	Thu, 14 Dec 2023 21:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EZyfvwcD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB63561FD9
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 21:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y5EAH3dMxW0qzbc8/3Iz4/YGUCAK97k5WU8E9ALNo40tk5kIYk3o8imRqbflBLqAU9f90cfjQ2SjRDRGgjH4F4G9vRx12q/nyGnV87VG8H7WrP+iVu/iB1EcJJlIYK7yCLA6dH/2PycUgoHHaacQzKhp07Zc9hnBayMYLOsIOKxmMyvCF7+yTinPNp24M6mwCqOcHgGTdT5n8YlqGSiH7vMnlkHiWz1WM45Nr5luvfdLoZYBkJcCKLtkxOo7ugjk6b0Z3xFWr0DHdccZKU46ByPVpkkzZERObokIpD9Mt8+C4EOmq3nih3LRK0PPU1wn5yjT8lWP/3hPF+KePCDR9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c9Jds4HcGu2nSWaRS5CcCFwDCeE5f30J+ReXAjen9As=;
 b=HzbgjXs8B9S4p3nMJj2WWYM/XMIzO4nH2Idpx/PI22ESFIcgdIXOpabjxG9CdLhTK4CmYPLdeDRPQsqJ0qyglqoTdU/F9AO+JePsVoyQHqyLbN1sCMzst07tFI/24n3dJTYmrJ77ToRSw8bZKvKF5WJ6aU1JMKZu++ObW7B67jRiwoIPgmNr39G2E1TwRscEPw9fwcn6+mp5cPmg0Cmyg6MwW8diqNpqGmyHzfX4nIyuXoaL1cV9yzTV0wnmDo3Tey1+wjnxrx3ZngnsNx5wZ7evRfKukGcWmDh3t1yXgsD2xvNHEEg4IfXqozxDhJs0p7yuGElyks4MT6o/ICkDpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c9Jds4HcGu2nSWaRS5CcCFwDCeE5f30J+ReXAjen9As=;
 b=EZyfvwcDnrnPU2RIH8XmWg7bcA3U6m5Gpdgf289Va5hUP8cRHLV9gXvY2EvlKAZ4TL2DKfh9zvbTdT0Jrz7Z5W//jwKlwLBCr2J7YdNAoO1PiNIdgmZ27YmbmkK17ACaqfnlOIUJ83SAZoVtzKVHUYQJdGF6LfNanKKI7JEdlBY=
Received: from SA1PR05CA0016.namprd05.prod.outlook.com (2603:10b6:806:2d2::25)
 by SJ0PR12MB8138.namprd12.prod.outlook.com (2603:10b6:a03:4e0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 21:13:56 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:806:2d2:cafe::21) by SA1PR05CA0016.outlook.office365.com
 (2603:10b6:806:2d2::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.8 via Frontend
 Transport; Thu, 14 Dec 2023 21:13:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Thu, 14 Dec 2023 21:13:55 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 14 Dec
 2023 15:13:55 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 14 Dec
 2023 15:13:55 -0600
Received: from xsjblevinsk50.xilinx.com (172.19.2.206) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Thu, 14 Dec 2023 15:13:54 -0600
From: Ben Levinsky <ben.levinsky@amd.com>
To: <jassisinghbrar@gmail.com>, <linux-kernel@vger.kernel.org>,
	<michal.simek@amd.com>
CC: <shubhrajyoti.datta@amd.com>, <tanmay.shah@amd.com>,
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 0/3] mailbox: zynqmp: Enable Bufferless IPIs for Versal based SOCs
Date: Thu, 14 Dec 2023 13:13:51 -0800
Message-ID: <20231214211354.348294-1-ben.levinsky@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|SJ0PR12MB8138:EE_
X-MS-Office365-Filtering-Correlation-Id: a09f04b1-44e8-435c-e0a5-08dbfce994e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	E88xC0xAxFKL8ko5/tUuqoa+SdYlvL5HwiowHJ/YMQNBUTlHXJZb0kTqyzcqEbXCy2mE4FfwV8t4x7QTFKLa994E9vI+8hROJ5TS/HnAt8ZQhqife7l5Nw4Y1nXKJNBsZUG/JvWOxhn3PBfJrNzWmbM2OyZOnXO1TcE+gewa1OFd3v+uOUQOOP97fp8dnzk8dEToiDsnYR2sR3T7V6k9abLORzxGioq0inovhUc2Bo+d/4+O5Yml2DL8N8McESRdXLEpisIOc2KNICEo8HjeMQ+OXmQjqPda+eEdRyYgPn8m8eGzjHLVLVVb/1qtaF0MJ7i/ad098cNu/jcn8RhkNDcbwhZRzPR2lamTmnoPrC5LmXZkf4O3xzc+il/1vfMz1ulJcw6k+0QvZysYLj9em/EZecii+jC0231fsDc2lG0F3X8Vvnw7KjGAquBDiVBX4p6OW0rsecJTJSJNkKUT7EcdgMpFaDe31BbCWyUQ3a3Olx31pIJz//9ZGjHFhz+b/UMiCym4DRYwRuRrHMz6pFlEZxLlvB8ZIyw7cj69nFW2mM4V1mS6wdjM4G+mQ6p81CsMWhoEjAy+Fbd7A3/z7mTQvgNXdYS0D4hDeRI/Murt/Aqh+q0wFPy0zey8bwrzT4me5YZ5mJl7+yeTi+MukcYktWSdidDb7K6qBh6Ijw8UtR6nbM8mUhyVC21R1mZb4UCE7TxaGH+/e6HEtR5UpL1YPj3gmw/uTkepNTTFFV20OIGoFXdCnBNVU/jjzsOdtlT8hVoOnjkauzwEMGeoxw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(136003)(39860400002)(346002)(230922051799003)(451199024)(186009)(64100799003)(82310400011)(1800799012)(46966006)(36840700001)(40470700004)(40480700001)(26005)(1076003)(426003)(336012)(2616005)(40460700003)(36756003)(356005)(82740400003)(86362001)(81166007)(83380400001)(44832011)(5660300002)(4326008)(70586007)(15650500001)(36860700001)(6666004)(70206006)(6636002)(110136005)(316002)(8676002)(54906003)(8936002)(966005)(2906002)(4744005)(478600001)(41300700001)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 21:13:55.8104
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a09f04b1-44e8-435c-e0a5-08dbfce994e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8138

For Xilinx-AMD Versal and Versal NET SOC's there exist also
inter-processor-interrupts (IPIs) without IPI Message Buffers. For these
enable use of IPI Mailbox driver for send/receive as well.

This is enabled with new compatible string: "xlnx,versal-ipi-mailbox"

Original, buffered usage for ZynqMP based SOC is still supported.

Note that the linked patch provides corresponding bindings.
Depends on: https://lore.kernel.org/all/20231214054224.957336-3-tanmay.shah@amd.com/T/

Ben Levinsky (3):
  mailbox: zynqmp: Move of_match structure closer to usage
  mailbox: zynqmp: Move buffered IPI setup to of_match selected routine
  mailbox: zynqmp: Enable Bufferless IPI usage on Versal-based SOC's

 drivers/mailbox/zynqmp-ipi-mailbox.c | 275 ++++++++++++++++++++++-----
 1 file changed, 231 insertions(+), 44 deletions(-)

-- 
2.25.1



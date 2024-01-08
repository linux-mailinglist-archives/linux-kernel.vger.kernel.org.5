Return-Path: <linux-kernel+bounces-19787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD5A8273E8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F0A4284E7D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0BA52F89;
	Mon,  8 Jan 2024 15:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aLqDVYP2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEFD52F6B;
	Mon,  8 Jan 2024 15:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m9jKLrXkAb04SR6BDwH9/qXyW4a/pLus/m9rdcBGeETCpBuzP9MCyj6RHvHM8zI9/vAuDasLFo9vitFMi/KPi1+mZ5KHWVbEgMp02VKDh1mIdtVSTWXR5N4KnyzCMe9oePVoI7Av2IGcPk1IiA8xeNkpk6ByF5NVesw/6rddv35fu/RwIMvpDzKQOTz5kYuA5vne576+qZACp2HmhGEbeVoSqWh6NmEI4K6mhQb+Lw1RZUb4ty5UWvQRvO2ERe3ZVTcBqTrt+ZK1BWVKmf7eytcsWSd2cEy6JE1bte5Xa/DWQGpC8UoBfE19ajQb8s6ADqQz/SuCFy7saqmIvJxE0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vLAHgR+AxR0Q8aoWscQREXCidHlY882TZO1lZMnldsA=;
 b=Jh41UwCBUcohGWAkD2BDy/2DwXIoAnqdrqKyDv/2jGNaY/5Vtu7FmamsH4gJRqQBLdIpfZkuBTons0t5zShapqSho92WUcl+9jQcFTIx6fAvRjolizsazLMtVi15begyCJfTJmBAKoFMiuBoQP3PanqMxilzj5AaMfSe3h0H9OKA14ciTcK7eCrWzlQnHX8Hpqa+2+Ajq2RrmKev1SHsV65GIume0jUZWknV8Z/bUGU27u3oMx5k1ysBVEX34VhpkTIiA1xsT9VI6z55KI7Z+y8vVDWYGoLUoWicVJ5p2K7X05Srda9EI9hCB0TGF7jAS6wzmKyYYLBhUKRsRazX+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLAHgR+AxR0Q8aoWscQREXCidHlY882TZO1lZMnldsA=;
 b=aLqDVYP2ZjqwFVJLsiClHHp2PWKD8+ERIlqC5UVzNUJNc+GeGZAKHqvSgoJgRQ0p+kTAVqU3uP2rcw449/OhHZIdZ9RI0lZ1jyGtIJYku/ixgq4oU4C04Q6ec/6FJueOh7ixJyEJ9uinSPK7g9Q/ZJC7hdoNYV7xB71CBeRhpPs=
Received: from BL1PR13CA0271.namprd13.prod.outlook.com (2603:10b6:208:2bc::6)
 by DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Mon, 8 Jan
 2024 15:40:18 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:208:2bc:cafe::ff) by BL1PR13CA0271.outlook.office365.com
 (2603:10b6:208:2bc::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.14 via Frontend
 Transport; Mon, 8 Jan 2024 15:40:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.13 via Frontend Transport; Mon, 8 Jan 2024 15:40:18 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 8 Jan
 2024 09:40:16 -0600
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh+dt@kernel.org>, "open
 list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree@vger.kernel.org>, "moderated list:ARM/ZYNQ ARCHITECTURE"
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 06/14] arm64: zynqmp: Describe assigned-clocks for uarts
Date: Mon, 8 Jan 2024 16:39:17 +0100
Message-ID: <21579f273554a19bc95a40f49956793b5261627f.1704728353.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1704728353.git.michal.simek@amd.com>
References: <cover.1704728353.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=800; i=michal.simek@amd.com; h=from:subject:message-id; bh=wc1aczHGqp45I0rwsgL+yysvPlLmVGSstdLA9YT0Qzw=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtQ54upHxFOun7NWi/1xd2LO5MSOvEdM7dv2KD1XZvs7c +mWYzFXOmJZGASZGGTFFFmkba6c2Vs5Y4rwxcNyMHNYmUCGMHBxCsBE1q1jmJ+54+vWQ4fb74mr cP9Zbrx7l+HF2kaGucJGS//8PduxgWXXyub71yurcuov8QAA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|DM6PR12MB4401:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c9b38f3-7bbb-453e-c1c8-08dc10601dde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mjUsrAJ6eKDJ3OOf6nhSzGjdvSa9BXJCetj8GFoaUcADAOApezhQa3bBT0YNbzB4Fs1S5kUPgJOjj0dHKv3ovsN+nD0KG6ElXs+tqtwuiro0c3uaq3994XJf2/uBC49zQ+UdCBlWW2jAIRVGDNrerTz5iLyUszHsag0UuWX/gW2NqwwCrWDe2PhF3UH5xasxG0Io+CixP8y2EQyDq3yUUZylUlFTknCUpqcaoiwtemPmVpREGJRyqLrR+bVsi7wrLrXlOYvDBKaSZyWaXj+BvThvJIr+cxpExi//11VPHi4KOfnabDCKe9o6oBdyBKf7pxB/+ie452fBKOCfabMhN1CzNaw9OYrPXSLhkppowfMPSV/aPxCfI8rs75o+FQOaaI6WSI18aH5zdxIXWXDUtVXCpr8S8+cp83rgnZp+YYRJeW99h6QORKsCur67jJ1aMnwlwkXxvACdlbLbM1vU0EkaT5yWEi8N79wA7p0TlNSnEag0sQZyE7/hUQ5H7I5bDWecv9Op2cnOFjCVlVAqJCChcK7fZFCj2ZD0c4KZlEKRki0rKQ8okERbKEzHaKXLw2bgTkhAztyRPgA34J0XkciwZcDdkMRQNgYlQPwRAY+4juq+yEpDAIYZlqDnRhvthreDuBu1iXR1gSWp7hTuPWRcVBNJUiiYiq9DnVetQNLyGwLCPJ216E9JwHtA/9qmbHXLKGdYUxQ4li021dKcRh4X9xhx+GehFfksx5n99C0PYkDT3JDrVyW7Yeu47lld20AuzkE9Nxadu6WaDA4Yy2shAsjE56WLbRV/i4aunt0=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(39860400002)(396003)(230922051799003)(186009)(451199024)(82310400011)(64100799003)(1800799012)(36840700001)(40470700004)(46966006)(70206006)(70586007)(47076005)(316002)(8936002)(8676002)(26005)(478600001)(336012)(16526019)(426003)(2616005)(83380400001)(2906002)(5660300002)(82740400003)(41300700001)(4744005)(81166007)(4326008)(356005)(40480700001)(86362001)(36860700001)(110136005)(54906003)(36756003)(40460700003)(44832011)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 15:40:18.3341
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c9b38f3-7bbb-453e-c1c8-08dc10601dde
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4401

Describe assigned-clocks for both uarts. SOM is using this functionality.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
index ccaca29200bb..ca1248784f59 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
@@ -230,10 +230,12 @@ &ttc3 {
 
 &uart0 {
 	clocks = <&zynqmp_clk UART0_REF>, <&zynqmp_clk LPD_LSBUS>;
+	assigned-clocks = <&zynqmp_clk UART0_REF>;
 };
 
 &uart1 {
 	clocks = <&zynqmp_clk UART1_REF>, <&zynqmp_clk LPD_LSBUS>;
+	assigned-clocks = <&zynqmp_clk UART1_REF>;
 };
 
 &dwc3_0 {
-- 
2.36.1



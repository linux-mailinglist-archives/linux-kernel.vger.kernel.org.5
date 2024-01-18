Return-Path: <linux-kernel+bounces-29776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0697831341
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02332B240F7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 07:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C932B11CAD;
	Thu, 18 Jan 2024 07:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="InfiefTF"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1424C127;
	Thu, 18 Jan 2024 07:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705563693; cv=fail; b=o5k5tEJQwvs1mEUge5xeQFUmKNGYFX60UHbFPGeKquEjAwb/r9Mu47oSyAUuw39d6Mw+e92ILt5zW/VEZ20+sdzRJ7DO9zTJC/SFGwkuxFAsV089XOS0I86aBTtckZTvvoHUW3cYozljKuIuLaZx01kDQXhqGv6VwflCCBV7//o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705563693; c=relaxed/simple;
	bh=TYEgEqpFG5YkW4ZwlKKsgXX+Zc4497q5kjfjQJr7LFQ=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=WXCKh+Ca0VTP4L8V+3hEpOuCkjy41ecjSEGKi28Viz3lSmBe5Cq3HFaIKBwbysZ0lRYbYTK68roabfyZwN2vRRx5IzQUvvXbDIWFa8GqgQ35TgIMwrknjlkC3qjO+nsGn8CcXAx6UicLPIXNnSfIfAoGy0QG5kB6Fzf7zrfMg2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=InfiefTF; arc=fail smtp.client-ip=40.107.243.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ejscTUSh8ochwCnbvfxp6w7Tm/f0cuXW/4lLpjccRuAKyRHDgZeRC3P8PLaoKjDBwy0023JL2ZtiIjwmERUkuCz3XaLUGEtXRmBQMB+cydta0tWjJbHejheNN9UUlqMSjXMhukWfDT+r2I5qpB4nuUvSZd1cY/9gzRDBhj0iwQLaf7ghv5ZimUh9I9W6OOdplxuog+XvRO0Jv1Al/U+8PqHg0ZdEnWI3sQNY3R52edbRy3Dev+wOUERG7P08afIWyKzHLc6Jf8Vs1SchadAMv+E707s98ZRC39pQwQFFJoY7tMjp9U+diN87Ozkp5e+eI3rPA3C3LMRC8cRQ7++R+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zRKGuLs+835hff+TGPL7YUfDyZhAKGJZy4+ZhQVa8UE=;
 b=kWnRL8b87EyNSK/2JeY00AJ7ZjxSnLCVTK/6IXyXRoUXoKines10L+FwY9BgK744fdgUYGQYa50EONJNPb7giN/1FNDNYyVbQFy9krxFPfb4yG4S9KHKOKXxM6PYd2QNVDKCR0Xg7wuDroRN0qEVFBFH9fFKunWWn8lry5FgdncjslALlo5tNGJJPF2IJExObB3li+2Wp8wHqBqapAsBkSGm1djyRTViSM7PtPpSZHEDolYPs/uN1s7MY3HhItUQnHeTHauXm4eMHl24EmR9+u+vET9F4M7o2qnGWU3E6G1ochtGA33DIvad1nfNC8GDAXofBIPFDdHukXrOo27TlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zRKGuLs+835hff+TGPL7YUfDyZhAKGJZy4+ZhQVa8UE=;
 b=InfiefTFQ3ooPi8tWceTQey7Ml4ss8mcVxYZUuX/q53FZyfq9TSThCh+XSKJgDuH2ZYK21D3E1A7WIq9QtfK/As7b0boB0Kb9uBMptymrJYkCbv2/Yf3ZTsLkNzJCWJsZKJEd4XfaSEwkn0lvlrWF4XVF2kVHRaVnKwMxsw6MSA=
Received: from SJ0PR13CA0048.namprd13.prod.outlook.com (2603:10b6:a03:2c2::23)
 by IA1PR12MB6555.namprd12.prod.outlook.com (2603:10b6:208:3a1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Thu, 18 Jan
 2024 07:41:28 +0000
Received: from MWH0EPF000989E6.namprd02.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::cf) by SJ0PR13CA0048.outlook.office365.com
 (2603:10b6:a03:2c2::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.8 via Frontend
 Transport; Thu, 18 Jan 2024 07:41:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000989E6.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Thu, 18 Jan 2024 07:41:27 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 18 Jan
 2024 01:40:59 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 18 Jan
 2024 01:40:59 -0600
Received: from xhdsgoud40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Thu, 18 Jan 2024 01:40:55 -0600
From: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
To: <git@amd.com>, <michal.simek@amd.com>, <gregkh@linuxfoundation.org>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <linux-serial@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<jirislaby@kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <radhey.shyam.pandey@amd.com>, <srinivas.goud@amd.com>,
	<shubhrajyoti.datta@amd.com>, <manion05gk@gmail.com>, Manikanta Guntupalli
	<manikanta.guntupalli@amd.com>, Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH V9 1/3] dt-bindings: Add reference to rs485.yaml
Date: Thu, 18 Jan 2024 13:10:01 +0530
Message-ID: <20240118074003.2334348-2-manikanta.guntupalli@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240118074003.2334348-1-manikanta.guntupalli@amd.com>
References: <20240118074003.2334348-1-manikanta.guntupalli@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E6:EE_|IA1PR12MB6555:EE_
X-MS-Office365-Filtering-Correlation-Id: 931b4ecf-762c-40b3-6993-08dc17f8e122
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4cJrGXGpnq7HobY0QiCl9CEUj3WZ8Isdpm4Q6t/gRI+OlBEDeYm+CariMGKUsMbkQctfjWLZ0nh8LGK825TPM02bncqxhPqb4toX/CDiTQjE1aJGlyJaND+FpJ9AUieruxbdg7ik53VV/8zRRDoz4wadmyYTXsIiYxNZDLsegJRR8Tg+zO3Jt5l+jer5TFZ5PkgxwYoRsNI3qgbo8g8YBs0QKhR2uqrb4vjlZMWUWKSOcZrbM5RNasjKBDm3/NFHhozYOT03/E5nZQJbn4dhkxnXCA/Md2HA3AG1MEyTHjvvzYf3+pES8oq8JHYWP8YccnmHtUgCU6Gu7Z8TUdFrIP4Nw0NDrfEQadPECtpJfJ9yCJZZ7iSiroY7BkfnMrFyky+vQw6JAlKI+nPeUBH/kKPmzzAx1hDfZ3RW/oZaREJJhgWjejrQll/a9T3UgFsxBk3utCa0j+IhkdyCi7WxO5dbGWEsY0Nj8miTdyQGZ1VjMiz7y1ZEhCrqGto4z7FkMMjtyQd/DfgNl47A8NUw9SWY82m0D4dzrgEASexIAO5te/Ff78O8f+X2MP56rpTh2PDwHR0CmHSWGDEGmbiijgbRBComMYLyNTQQ9D241+fASYhqbvjOdulmc53NSbh10GMmMDBxjs6i3u2n0p7hkdqdnXGXiztCCmsPM1gn32gnYElBfmvd+60vKN+C+gGRL+SuFJPJs2AYUspPLF9bRaAlVo6trlRY0R6Y3ig/3U9U10mTxpzmqds6iEYAdrLyJzgkzhdfLQV3VH7pgRhgqL5TF/n6gQrvVHAsbe4xZ6A=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(39860400002)(396003)(376002)(230922051799003)(186009)(64100799003)(82310400011)(451199024)(1800799012)(36840700001)(46966006)(40470700004)(40480700001)(40460700003)(83380400001)(921011)(86362001)(36756003)(81166007)(356005)(36860700001)(82740400003)(8676002)(8936002)(4326008)(1076003)(47076005)(2616005)(26005)(426003)(336012)(6666004)(110136005)(70586007)(70206006)(54906003)(5660300002)(316002)(478600001)(44832011)(41300700001)(2906002)(7416002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 07:41:27.4818
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 931b4ecf-762c-40b3-6993-08dc17f8e122
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6555

Xilinx/AMD Kria SOM KD240 board has a rs485 compatible peripheral.
Update the binding to have rs485 support.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
---
Changes for V2:
Modify optional gpio name to xlnx,phy-ctrl-gpios.
Update commit description.

Changes for V3:
Modify optional gpio name to rts-gpios.
Update commit description.

Changes for V4:
Update rts-gpios description.

Changes for V5:
Remove rts-gpios description.
Update commit message and description.

Changes for V6:
Update commit description.

Changes for V7:
Update commit description.

Changes for V8:
None.

Changes for V9:
None.
---
 Documentation/devicetree/bindings/serial/cdns,uart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/cdns,uart.yaml b/Documentation/devicetree/bindings/serial/cdns,uart.yaml
index e35ad1109efc..2129247d7c81 100644
--- a/Documentation/devicetree/bindings/serial/cdns,uart.yaml
+++ b/Documentation/devicetree/bindings/serial/cdns,uart.yaml
@@ -55,6 +55,7 @@ required:
 
 allOf:
   - $ref: serial.yaml#
+  - $ref: rs485.yaml#
   - if:
       properties:
         compatible:
-- 
2.25.1



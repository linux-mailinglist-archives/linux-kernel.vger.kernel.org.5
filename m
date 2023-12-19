Return-Path: <linux-kernel+bounces-5354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC4A8189C6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B169B2888B9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461521B297;
	Tue, 19 Dec 2023 14:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OnSp2IvH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2052.outbound.protection.outlook.com [40.107.95.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACB91CA95;
	Tue, 19 Dec 2023 14:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jubs98i4ja+WcfD/dHpRmLL0vWypfp0vSvimtEPrA8CAOcq9Yu98ALefUYs/sR7gwYkUxAYb+TNg5g3zLtJ0DG63PixtN98ZVXqlNi+bSb3aD9ERNF8aAXPEO39v6+PsFWuX67QPYXyDWnqkrKlwwmWgVs+3zpsitmzyYwxhTmdUjNEFn6+arImztks0v84V0cm0cXRBuGp/H7b1G9a7w2Pq6RPWLkpPL2JnuJUJ07l+ZyNC4cciWqG5fR/S4jtGShaTrCcFzrXPU0sr53SpckFwKWXaHmQ5a8/582QGj4BB4QwVBt7jx9Y1CS2pBSL12Lbqo6jyys0R88oN+YHDqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8T4YR1mNBkAXSSS0EIBP7Fh2AgCzUDF+gl4yGWBWIcw=;
 b=F6YrUMptzo1nN7Hqz3tifCQ8W6Oi0N9zTm0K8vlU71INEdKeVf+n0glTJtypFBfHmolyysbbkUBvdF5j3Cnfo5jHFVOuQj7G4vfl4RMKXp85b4wLzXOl1MZV/ZBAVRB9fq50Q/pSMt7h+N2KjtHVGGRTDSpIVX763UUwITDeIwWZlebvXGHIq1FGWxhv861pgRbQRCPFCIVR3xtusTgsJ06AE6G8I6T02/F52+WJgXz7yEsslQWFy4QVn0V4H/PJ50zH7H444yBa5HSUQ/g3klRsiVBmL7itU4BjvRVRq36G/JbBOiSo+nVSi/T+GPexSiWuvG9pUyykRBk41QJ1gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8T4YR1mNBkAXSSS0EIBP7Fh2AgCzUDF+gl4yGWBWIcw=;
 b=OnSp2IvHgOS7PoAZx8EYxgTAz38X8VJ4HcAn2kTRtKXA4gmC6rqCywEEWl1J+shOusylYgwXAljpKfPUO/zlmbSObrxyipOSSccq47GLFdRPjqNa+q3dkPnqIhX1X76d2E+94oJLrj0fhDJplTMlc8PTh80zhPtOdPUvhAj2+d4=
Received: from SA9PR03CA0020.namprd03.prod.outlook.com (2603:10b6:806:20::25)
 by BY5PR12MB4194.namprd12.prod.outlook.com (2603:10b6:a03:210::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 14:25:20 +0000
Received: from SA2PEPF000015C7.namprd03.prod.outlook.com
 (2603:10b6:806:20:cafe::7c) by SA9PR03CA0020.outlook.office365.com
 (2603:10b6:806:20::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18 via Frontend
 Transport; Tue, 19 Dec 2023 14:25:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Tue, 19 Dec 2023 14:25:20 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 19 Dec
 2023 08:25:19 -0600
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] dt-bindings: soc: xilinx: Add support for K26 rev2 SOMs
Date: Tue, 19 Dec 2023 15:25:16 +0100
Message-ID: <6673abb84e542c2841cece9336571f97b19882fe.1702995908.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1314; i=michal.simek@amd.com; h=from:subject:message-id; bh=1BG1yY90XncfYzqpTB1Qy/aVMukcaDEBubg5eaawYmA=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtTG5UfeNO5znJ5ddXWKzGWNIyw2a35qlRVuWr6OX175I zPHzDVhHbEsDIJMDLJiiizSNlfO7K2cMUX44mE5mDmsTCBDGLg4BWAi5+YyzLPwulqizH43N+eA 10l1sxUZSieUYxnm+86JXXn5uWBO44Jy0yNd7x/Ffe9KBgA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C7:EE_|BY5PR12MB4194:EE_
X-MS-Office365-Filtering-Correlation-Id: a4dff409-9a75-447a-4195-08dc009e54ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6KXVp1/q3nupKbERdhJcJ9SnzNrf4+fyYdykFbTgxMgpUh2tSkOSt2TtLBdmyKxmajOmquRZE8Lkx12qJD3KEFsUjeu92w/UmXYziRUJ7SI0KuUeJLyL9+aRn1A3zE5fWxPRnolwYWUnTgptwvOGQxJ/nlj33ylIQ4xcqekrFUYmvk4L8vE6iMEO2uPhmj/Y9575NkBs1mAvzFLoPBhlrIiEruGvXStLofD8rh3DoLibSfWlgZLgb5HnO1a3PWlrxDSqbGmwSjRsp2T80MjPd0JkOPD+dc2mo3u/LgZQBc1qDHkrOs/wOHIHbVpBBi0DqD98iTvir+kW1p2eFA2Ufc4r25gdM5pAdGiurb3kd95UWJIh77Au3txErxB0CJ/xb0mTW0rujNjxaapWW07jrPdxYvXJVjOgMOyFdKJEawI4rLFPOcZr4TGFhCSLpLqGrDUqgpNb9Wgwkt97N8UFMkiEvXnMmwLl0zTyIWBuoE2o1eLyhJaZ6UygNGCMv7HVNp/B6QrU43kdnY1iOohXAy6h9NP3LUjfQfIFNYQHjzRL4A2q4ejchcYEU+G1QtyyR9/ATZ55ZH1w5LsjunOleICneTaCFTVxMgCOfmMPMDhKrkUnssMr0hEjLktNU6Og/OwyVUjWRwLt0rX1RIQuNmuMmSGLq4omGarP8J8DuOCuNmCxCHLjE/c5UBV2LoW6HhRMhGGwlJq2QHwztLi5RgJK1fKOiH8EcFdehdDv+9b9+i6iLqi3eJEJC6jvQNwTtPSGn1jvFC43vkuI3S9KM1RJbbVWUanmiEYhIr7lPi8=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(136003)(396003)(376002)(230922051799003)(64100799003)(82310400011)(1800799012)(451199024)(186009)(40470700004)(46966006)(36840700001)(40480700001)(2616005)(426003)(16526019)(26005)(336012)(40460700003)(81166007)(356005)(82740400003)(6666004)(36756003)(86362001)(47076005)(44832011)(5660300002)(36860700001)(8676002)(70206006)(4326008)(70586007)(316002)(110136005)(54906003)(8936002)(41300700001)(2906002)(478600001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 14:25:20.6622
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4dff409-9a75-447a-4195-08dc009e54ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4194

Revision 2 is SW compatible with revision 1 but it is necessary to reflect
it in model and compatible properties which are parsed by user space.
Rev 2 has improved a power on boot reset and MIO34 shutdown glich
improvement done via an additional filter in the GreenPak chip.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 Documentation/devicetree/bindings/soc/xilinx/xilinx.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/xilinx/xilinx.yaml b/Documentation/devicetree/bindings/soc/xilinx/xilinx.yaml
index d4c0fe1fe435..62617e1ea74f 100644
--- a/Documentation/devicetree/bindings/soc/xilinx/xilinx.yaml
+++ b/Documentation/devicetree/bindings/soc/xilinx/xilinx.yaml
@@ -118,6 +118,7 @@ properties:
 
       - description: Xilinx Kria SOMs
         items:
+          - const: xlnx,zynqmp-sm-k26-rev2
           - const: xlnx,zynqmp-sm-k26-rev1
           - const: xlnx,zynqmp-sm-k26-revB
           - const: xlnx,zynqmp-sm-k26-revA
@@ -126,6 +127,7 @@ properties:
 
       - description: Xilinx Kria SOMs (starter)
         items:
+          - const: xlnx,zynqmp-smk-k26-rev2
           - const: xlnx,zynqmp-smk-k26-rev1
           - const: xlnx,zynqmp-smk-k26-revB
           - const: xlnx,zynqmp-smk-k26-revA
-- 
2.36.1



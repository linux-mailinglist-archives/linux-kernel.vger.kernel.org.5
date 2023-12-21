Return-Path: <linux-kernel+bounces-8333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 499B381B5CF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00E5A28774D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D6E74E00;
	Thu, 21 Dec 2023 12:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AXZPsO/w"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC5D745F1;
	Thu, 21 Dec 2023 12:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ek+VACDlnK4fqpi+LEPutzXzJrLvgDK5CGkRMFBC2ocOiMpaoljdbwV4PLVF/biZiCJn9oVS0Rkanq79XIHEINGoD7VeWmIDQOrdMWKyzzddzCDSY7WgILmdpip0wlbcO+LD4ylXZVwI62Rv8QbdlcR3dD1dkO+jb73AU3nX8zZGurWmClj7sJm9WHnRsQGDaFF5ygGsy7+9v4jzlzAIGGDLJNZ0ATlDSXhHJWbCmbCGpoW99/JumVAGbwfXR8qp0xqRnxyTHHSQOec2FgeiEucvQG7lHRNKrvcSTm8mMWPTCKp+ATIS8ADw9YQmgXFv2eXnFQ5I0uLulCv+Q8hVww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tW8YFj4bY+C+9+JPx/nreRIrasMX4Ci//3HgKJ0R62I=;
 b=h9zp2sxwHuHofeNqzbsCfVl7u/G7f9PnHCUzxvqMQzMdqsW1LkZSY6XuejknBIP3KLKJC0xUuRJ05BmZGStAjw3FqfnJSboQhYxUMmyGdHHSsuNYXutYcR/aH0wYM2qes9ZAJswXJnBEY1k8v2F2CFQBhBPF5H0/Un4B9vyVm/y4Py4qiH6q8V4PIPIZ54aPvzV2Wwx2vrT6OHVz6+v021TZ4/9poYsCRR/gCCO9pMU34kGixdPrlm44V9/TgEQBX62Irtj3cF/iTAgOCzCu+ZRkdFZ4dhC56B08hzaURca/zANh1ucoo4e0eIHThf13oticzZ5qfBzfQXTufIcphQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tW8YFj4bY+C+9+JPx/nreRIrasMX4Ci//3HgKJ0R62I=;
 b=AXZPsO/w5SRz+VDOTfeKtBaNIvelI/42SWprvcpPV5VcOKB0oTpRh9tMWQNxHTxLJHihLQ3geZwu3ZQj1AgsfEcbQzJVLGc2qGXcqKXpEmPTznCaGKW7dW86MHh6pmdpjHlKCrPToNr8gru5eMspLegkLihLjyc/GVLRKlz1xP0=
Received: from MW4P221CA0022.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::27)
 by CH0PR12MB5058.namprd12.prod.outlook.com (2603:10b6:610:e1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.19; Thu, 21 Dec
 2023 12:28:23 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:303:8b:cafe::15) by MW4P221CA0022.outlook.office365.com
 (2603:10b6:303:8b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18 via Frontend
 Transport; Thu, 21 Dec 2023 12:28:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Thu, 21 Dec 2023 12:28:22 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 21 Dec
 2023 06:28:20 -0600
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh+dt@kernel.org>,
	Sebastian Reichel <sre@kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>
Subject: [PATCH v3 3/4] dt-bindings: power: reset: xilinx: Rename node names in examples
Date: Thu, 21 Dec 2023 13:27:56 +0100
Message-ID: <920c839ae2c9c5803c6c08b8705a0d8338bb94bc.1703161663.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1703161663.git.michal.simek@amd.com>
References: <cover.1703161663.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1255; i=michal.simek@amd.com; h=from:subject:message-id; bh=qVrvpz8Il4FZNCPKd9oussz0ew4UkcAivJt5txBH6Sg=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtQWfa/3j38Hbl2/vmiK5JxOj26pcEN9Hm/GvxphHex+J f/etl/oiGVhEGRikBVTZJG2uXJmb+WMKcIXD8vBzGFlAhnCwMUpABPpVmCYZ73A/G7u2a4fBUl/ v7Lbfj/jcU51HcMcjh3b9Rm3yexOXxx89yi75KI/3Dw/AA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|CH0PR12MB5058:EE_
X-MS-Office365-Filtering-Correlation-Id: bd80ab48-55a3-4007-8125-08dc022052a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VuRABSc2jhdD9l/TTLradHz5GN6r0tqZudYZe3xJOYXYnfTnhn2+JS2CfUTLySuxe/b15ANqPhVyZw2aetypBTeslGK0+cHOA3AxbQpMBTQ6voBxnug9Y8furSHwVvfm6Cwkq4LVoaaGN11jeIOWKbRr6uGxwuMAx/rJEHMYxJSqYdMwCRJbBhOjxuaTH0GC9PTlMhjoNkQ7alUg1q6+BXjB6z8I7vN/urxOiEk1VcQkDH3Mhx5r89eJmetPIUL2vau+TGzMI5x+wwaByhnWDpzEMr7/fa8bAIA81qEoSOe52Mpcd9MWbtp3ZFFm5sNR0xMwBfaGNewT3673wcZdwRwhEg5z7oa8urF1krnhjfoggUKgSx5zhPV62Uvl+ecyAahHMVebXlUQGuHmfmTfYv1/IllR0xXdTstZAmGRRgxdQFnMR36xFx55ErA4GcgFUvangVC9amnM3BAcars9UtYSqE5Xkk7Bin8HV5xsg3zbRxTNEgwq+nSAD9GIFpKnxw740FPqGEptL9+1Hjehen4OZ4AAu9o7NPgeB1nF0qjsfiMpQE4AoMdBXXYde5kY/PG2i5qRfPqXkoZWkcBEUudLoFOPSOEsWbGeqbeOY1dFT9y+eLYZ+4aAPKIHhz4eHD870dOh6si2Aw7v83HrLJh/O7Z7JCVmdrE8zPgwVWsY8MB+522nr6WgK8yvGWchZ9YJsESNjLNQkcw0VyWTD7IiuHYEvGC3Z28DyVTZw++lVWj9bt75jIVQnbhM/kx2LgBAT/LuP5S3SddFNvGFjLEQyqnf8ztSMfXdlIQA1Y8=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(136003)(346002)(396003)(230922051799003)(82310400011)(64100799003)(451199024)(1800799012)(186009)(46966006)(40470700004)(36840700001)(83380400001)(47076005)(40460700003)(110136005)(36756003)(70586007)(70206006)(36860700001)(54906003)(316002)(4326008)(8676002)(8936002)(356005)(6666004)(2906002)(40480700001)(7416002)(44832011)(81166007)(82740400003)(478600001)(86362001)(5660300002)(426003)(2616005)(26005)(336012)(16526019)(41300700001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 12:28:22.6901
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd80ab48-55a3-4007-8125-08dc022052a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5058

Rename zynqmp-power node name to power-management which is more aligned
with generic node name recommendation.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v3:
- s/power-controller/power-management/g
- align commit message

Changes in v2:
- New patch is series

 .../devicetree/bindings/power/reset/xlnx,zynqmp-power.yaml    | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.yaml b/Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.yaml
index 45792e216981..799831636194 100644
--- a/Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.yaml
+++ b/Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.yaml
@@ -57,7 +57,7 @@ examples:
 
     firmware {
       zynqmp-firmware {
-        zynqmp-power {
+        power-management {
           compatible = "xlnx,zynqmp-power";
           interrupts = <0 35 4>;
         };
@@ -70,7 +70,7 @@ examples:
 
     firmware {
       zynqmp-firmware {
-        zynqmp-power {
+        power-management {
           compatible = "xlnx,zynqmp-power";
           interrupt-parent = <&gic>;
           interrupts = <0 35 4>;
-- 
2.36.1



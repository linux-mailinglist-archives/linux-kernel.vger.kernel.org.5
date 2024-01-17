Return-Path: <linux-kernel+bounces-29411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95960830DEC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 21:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 813961C209A6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 20:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611AA24B41;
	Wed, 17 Jan 2024 20:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VDLDgHZS"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A7A249F2;
	Wed, 17 Jan 2024 20:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705523161; cv=fail; b=VcMY7bJp+8MtYRdrrzKwY0vZb9CcEGQQRO24Hb6xhy9vTAUQgCQzbtXqGLJfuEJfU+A6T4QXwFoOkrlsyajbPpda4vqX3HvJ+DXlazS5HsPy1pP3L9WOmZNDSeyttUqjkvcriscDuwPbWt0ixXCr2LxyppqndhpPUFyrKvGHCco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705523161; c=relaxed/simple;
	bh=qh/BS2q2u+lbk7H0oklQ2t1Fz/cwpSc0jmVi7wEBE74=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
	 Content-Type:X-NV-OnPremToCloud:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=XXDEqXQOJXJksRlYepBP1wnTTjmdXCCjpKJ2pz7GaQn64pJ5VbuIBqLivW0y4OGF9enyGGt7/RAIfmL/w5pgG/Xm1Y5y4X0wILOEs4X+cxHgYNlrIpeQLkg6xZw0Xp8WNOtiwFCmmZlSidYhcgNu2Cd2ybnYl6df/N1ea59Aw08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VDLDgHZS; arc=fail smtp.client-ip=40.107.94.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GVzHAN+yvn1xkbnsHRNaIk7BsNPpOEZW1LOXSenTZqaffr/U7gLnwyYVRxTtJ5dx8KFHjcw/ztM93aX/SCT8I1VEeMh9TEcl+GLrZC1gZzIJjk8KAovfIX8NvT/Q9VB4CfApWM3pFYIN21+ASR7H2DlxTWy333JVwXEijNfDPCodjw/5bOQ5SfqXkBe3+p+fUCGnr/S363O26+mmareF8PJ9NcK0HlL1iPuCVUDVWtWANEoiasRCjp7hSNuxTA10YbZpxR2yK1J8/SXUxlzFR0doXjd6ad2pQzfFNoUh0gKRKFHdIPaofgDlI/QP9LEokgQRIc5pSMJiZt4AhMFA/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o57JK280gmHCOydivIoOrMswrkcnPdXk0j/ddle3pTg=;
 b=ZN1dAbR9Jh4mqVYUqUjDG+GlR2DuCWJMW3deaYBIBaJO4JU2gELP6GfAp/Wlo758n+q7aRSJ8Rs4Y0HrGaZA1X9nszwUv1NC9SMTKRp7jTa41Jh/8VWATdYPYJzsZa6PueHIYeRWFxuV+SP5XFH8R8o5hm/RaCm0G1EK2ZbftBQX0NxqVHMufuLBb/OcCtZzHLXBD1iXbRZVHuwcG7l7XCoVyJaTXmFoL4gUSr9xUburihjvp4oo8CdBapMMIZ3UTWVcpXVGIahcZ82F4HnluZ8AO2Wn6sw6V+p2KRUY5JqwqYTB4dJM2vOmBUuKnGggXaZbBsSGOL0tuCoX6arzxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o57JK280gmHCOydivIoOrMswrkcnPdXk0j/ddle3pTg=;
 b=VDLDgHZS93RXhyxKZCtsPwrD0+5azC/5HWkJVdeAM/N4zonewDyXCjrih5PTuxjbnhMXVAOeTBH72vGXyVRqnR/dLasiDy8xijspFHDygySwbizt1KgirYkwYKuvO7/m2mnW5HTNqAy3066Vr/jrOFj2jIzUM5zOKPHM90UCVex9pQ267bV7j1KUdXaTlkejMXR8qFgKlxhsGMuXUj60qwIMsoQ583hB6JOksOmAgiWDZqNUSGIGrQ6bC8Vtve7rhY1EE0qrI95/uCZgIuY2cElhkgWr/6VV5T2jmDSH9VPnvIOkmqCnwIRM0RzqF+chIzbdmV6sGg5A1otT7JMctw==
Received: from CY5PR22CA0090.namprd22.prod.outlook.com (2603:10b6:930:65::12)
 by BN9PR12MB5368.namprd12.prod.outlook.com (2603:10b6:408:105::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Wed, 17 Jan
 2024 20:25:56 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:930:65:cafe::16) by CY5PR22CA0090.outlook.office365.com
 (2603:10b6:930:65::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24 via Frontend
 Transport; Wed, 17 Jan 2024 20:25:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.146) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Wed, 17 Jan 2024 20:25:56 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 17 Jan
 2024 12:25:48 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 17 Jan 2024 12:25:48 -0800
Received: from build-petlozup-20240109T002231482.internal (10.127.8.12) by
 mail.nvidia.com (10.126.190.180) with Microsoft SMTP Server id 15.2.986.41
 via Frontend Transport; Wed, 17 Jan 2024 12:25:48 -0800
From: Petlozu Pravareshwar <petlozup@nvidia.com>
To: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<p.zabel@pengutronix.de>, <dmitry.osipenko@collabora.com>,
	<ulf.hansson@linaro.org>, <kkartik@nvidia.com>, <cai.huoqing@linux.dev>,
	<spatra@nvidia.com>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: <petlozup@nvidia.com>
Subject: [PATCH V2 2/3] dt-bindings: tegra: pmc: Update scratch as an optional aperture
Date: Wed, 17 Jan 2024 20:25:03 +0000
Message-ID: <20240117202504.943476-2-petlozup@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240117202504.943476-1-petlozup@nvidia.com>
References: <20240117202504.943476-1-petlozup@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|BN9PR12MB5368:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fea15eb-417c-409b-7798-08dc179a8287
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hPoaJ0GgMsvDWksNrcfXKSGIBREX7XsoSi9L8dmP94dftBtYsHf11yIkOp4c9+tC4+GpDQgrirjl4OiN4y79cG1lIbFNcKFOnIwQQPXy230wPV1ioS9ieljKQs1Mf1FNdLk6yQPLseghaFoGUJlGtlhdHbeAQPirsRY/3dWw4tH22kkW0lUa5xtLK9jmwzRtWOqWf5Of4xXkyaokcUAh5iC5UMsCCnoqvbml3GZqFiELmhtk4qhhKE377vquKYBG5oqJr0Ab7vTo8exPMGBaOspGeapOBbGi6wnRGSlJb0dYt56p9cvfTw/FwKWy0V2m9WmND0RM6sq5dmlP/M3Iq1MLDzAPJYxUK2G5mabg8aqExK1c57uAJa5spc7HzdoD9KHUAgopUZZt+SwZDmPoUOeOGGjckTHWszylUzSiGA3pv4/cRSkYuGq4CO8j/90+C/HT0K4XEDapIeoAZ2wd+ncBvAqhLoexOXOiXU/YXyFNOo8/sR03hkLUe6Zs6T2f1jHgXqOQOrR9workOAQQKHRycS0w3Jx292Ho0OxCQ5/WIBqnyRVFjGV+lRC6FffhyWSttf2RtefxEOmfRb88a0iSiVQ4HCzu+W32V69Zn3bu56+kkZREY2syUCJx7yXoeK2/HSd5sj2VdzQ6rdn9e9COYkvkdVGBbkOkcLTaGdIDsrYxvqvgsAOn7V88G9/N7XmViMhbeU6mVGlFTBp4ObAtJgMLcYGRsg30F5w4nnwkJsEu1Yi/YGw3yuIr9ztgd3XC6+nVwFKZmL0lmpGZPikmOTM3NA6iW4FEZrJ+MZRbp/wU61RkBY0TrEXu4Awh
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(136003)(39860400002)(346002)(230173577357003)(230273577357003)(230922051799003)(64100799003)(186009)(451199024)(82310400011)(1800799012)(36840700001)(46966006)(40470700004)(41300700001)(82740400003)(356005)(47076005)(83380400001)(36860700001)(7636003)(86362001)(36756003)(921011)(110136005)(70586007)(70206006)(7416002)(2906002)(15650500001)(4326008)(8676002)(8936002)(5660300002)(1076003)(2616005)(336012)(426003)(26005)(107886003)(316002)(478600001)(6666004)(40460700003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 20:25:56.0992
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fea15eb-417c-409b-7798-08dc179a8287
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5368

Scratch address space register is used to store reboot reason. For
some Tegra234 systems, the scratch space is not available to store
the reboot reason. This is because scratch region on these systems
is not accessible by the kernel as restricted by the Hypervisor.
Such systems would delist scratch aperture from PMC DT node.

Accordingly, this change makes "scratch" as an optional aperture for
Tegra234 in PMC dt-binding document.

Signed-off-by: Petlozu Pravareshwar <petlozup@nvidia.com>
---
Changes in v2:
- Fix dt_binding_check indentation warning.
- Update 'reg-names' property items list.

 .../arm/tegra/nvidia,tegra186-pmc.yaml        | 78 ++++++++++++++-----
 1 file changed, 58 insertions(+), 20 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.yaml b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.yaml
index 0faa403f68c8..79928824005d 100644
--- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.yaml
+++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.yaml
@@ -27,7 +27,7 @@ properties:
       - const: pmc
       - const: wake
       - const: aotag
-      - const: scratch
+      - enum: [ scratch, misc ]
       - const: misc
 
   interrupt-controller: true
@@ -41,25 +41,63 @@ properties:
     description: If present, inverts the PMU interrupt signal.
     $ref: /schemas/types.yaml#/definitions/flag
 
-if:
-  properties:
-    compatible:
-      contains:
-        const: nvidia,tegra186-pmc
-then:
-  properties:
-    reg:
-      maxItems: 4
-
-    reg-names:
-      maxItems: 4
-else:
-  properties:
-    reg:
-      minItems: 5
-
-    reg-names:
-      minItems: 5
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: nvidia,tegra186-pmc
+    then:
+      properties:
+        reg:
+          maxItems: 4
+        reg-names:
+          items:
+            - const: pmc
+            - const: wake
+            - const: aotag
+            - const: scratch
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: nvidia,tegra194-pmc
+    then:
+      properties:
+        reg:
+          minItems: 5
+        reg-names:
+          items:
+            - const: pmc
+            - const: wake
+            - const: aotag
+            - const: scratch
+            - const: misc
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: nvidia,tegra234-pmc
+    then:
+      properties:
+        reg:
+          minItems: 4
+          maxItems: 5
+        reg-names:
+          anyOf:
+            - items:
+                - const: pmc
+                - const: wake
+                - const: aotag
+                - const: misc
+            - items:
+                - const: pmc
+                - const: wake
+                - const: aotag
+                - const: scratch
+                - const: misc
 
 patternProperties:
   "^[a-z0-9]+-[a-z0-9]+$":
-- 
2.25.1



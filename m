Return-Path: <linux-kernel+bounces-20646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 785B68282EA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 10:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BA6A2877C5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 09:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDBD36AE1;
	Tue,  9 Jan 2024 09:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UrCCZZAw"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88751364D3;
	Tue,  9 Jan 2024 09:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XabzUH/d8PKWJl5q9srAlRXTYlkWhA5dk1rcspWlpPhA0WVTO35Hs6/fLSVZcfv5EzCvp8FkhSNkBppiuGXZeMnqkXFWimFUVxFvYdulntwRSfAaLiDzX0b42R+L9xYUp9+NqP/hcIervtmbMlEpvpxUaF1cXcAkzvE1QrIxQc2RO4XClT4tbHxdhme9OCdFp9acgpaGw7HGcmp3mtx/pTtqQNSq0t4T4+mabt7HbxLDSfVzXd8odFeF/sAaU7zG9r2D/vO2mo6zzoO2GJVY3Jzb/JQ0S3s7T1xmCc24xDHDuIhK493riynfH1PGayGRWF+hG52DtgQWCC4d7C54eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=35FoBArWZXwnebkbQ+WasDLBbonHVzGK0vRKV01R988=;
 b=C94A8ZmyEORbnxPKc1XSZ6AXxmsqF3PmiAo5kl8j1r9lmOwHUvl2T1r16AK3yB5XGYm9RVDgmjl6xpDL+xGOoWQX8x/H9F74i12faEF9O0xugLDdaxpZlONCOTkLbHWUWXILVOnDZkF7Sf2Sd0VRYkNF6nbf9nKiN9OSlVTDsCCFSG5MZEVucRimoYid016+NNY6Y+IKsXDO5vkpTFoZX4a7vn9iSIc/mh1GILALitYOURr3NxfSnnkGf5GcoI3A3NGb/FfA58sEk8ilLSz9nGKLv4CTETTvjMtytPs2aeRsHf4pNc2twHmJ49tKhLkDo9muccLsbs/zqA0ZVaNvmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gondor.apana.org.au
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35FoBArWZXwnebkbQ+WasDLBbonHVzGK0vRKV01R988=;
 b=UrCCZZAwhqEc1mShZvrxqtef4rUnw0FSHbqV1pAOqYaPfUNIpmpmFR3knwlDJ1DmhVnaUFiRM3/i/5WOTFGQdlbDzUjPYXw3AD4myN2i44zOooOnnbEwJvmBGCEVtup0WWuE/4nkICYCiTMnDtusjUNjTUARGo8kMA2RamgLHh8bd1/FcoiIAYCGoiEJKsHcuLQLj89M8loBgPjn1wcm8nSJR6y41TZDb2qj1hhaYlExRHqJMbMDo4/7ALwPNeKCqfMcdz5cfgs2CEIz7w/qAxk/DKDBkzFEzg7PO/e13/3gpIPiP2cfNDnh5dyFllUwrjU02BJGJp6czCp3HAO/zg==
Received: from PH8PR15CA0024.namprd15.prod.outlook.com (2603:10b6:510:2d2::9)
 by DS7PR12MB5816.namprd12.prod.outlook.com (2603:10b6:8:78::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 09:17:56 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:510:2d2:cafe::d9) by PH8PR15CA0024.outlook.office365.com
 (2603:10b6:510:2d2::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23 via Frontend
 Transport; Tue, 9 Jan 2024 09:17:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.13 via Frontend Transport; Tue, 9 Jan 2024 09:17:55 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 9 Jan 2024
 01:17:41 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 9 Jan 2024
 01:17:41 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Tue, 9 Jan 2024 01:17:36 -0800
From: Akhil R <akhilrajeev@nvidia.com>
To: <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<catalin.marinas@arm.com>, <will@kernel.org>, <mperttunen@nvidia.com>,
	<linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<krzk@kernel.org>
CC: Akhil R <akhilrajeev@nvidia.com>
Subject: [PATCH v3 1/5] dt-bindings: crypto: Add Tegra Security Engine
Date: Tue, 9 Jan 2024 14:47:04 +0530
Message-ID: <20240109091708.66977-2-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240109091708.66977-1-akhilrajeev@nvidia.com>
References: <20240109091708.66977-1-akhilrajeev@nvidia.com>
X-NVConfidentiality: public
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|DS7PR12MB5816:EE_
X-MS-Office365-Filtering-Correlation-Id: c14a38fa-6af2-49d8-176f-08dc10f3dd3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KmBX+yZjla7NXzg6mG9ZW+TXLPKdXDRBoO8Pg3v3qotLDXZJ9f5r8kATCG75vmN0y1K5fJjsSjoSNzkUPR6iIo+qWgmkFcp7hR40iBttG9oiaJE1iXiyBlEFgqky8WkTemNe3aklYUeZ/Yla1htC1JjxTg1Ui3c8NNRJgzxlSN8TDuEqBC/UuQc+Vn01Zt8pkQOaSC0fg1Y18Z9D0agcRXN3rUl+xhRjMwhY6fQP8CkVaekK/yC4JX4uxkelq6QVqLBGu74hN9TX49rT9zqkXRT3D/0volPdPADjEqKhggGuEMKemActwtZ8mhuQKaiv8cFUhkaoGfH88vvRo3VhyGxQXvyEsQNU8qYquK40HSJJ70T69RSphxMTM/bnQAe03oGhglCdCYvs/1TVdTJEQAklVc+sC7bDUabjb8DMx8EJIwIPCklL2aSBJbuw/ClchmTU/UPZI84+4MnBrXJTT/T703uSSwxwNj7rCe3sM/BfyMQbM8r2aNvqHFpm7/TPGAqqLklo7ko2Fgpt7jAH9dn2GzRTSE8MVsnqc2RRTJlcMCMa/JK3tQ0CQinsWgSvCS1RIUmKbH8JYpp7gJtLgyRagkLR7y0J3TEgWIfWJ3Iug4yOEBZtiB58avjAcaKyMxNmgm0ZDha/aWNUMurx1LPAcTGicswdEgGXwWlGUsXAcqUr1jV6gVRXL4qTV21IyfPdMm2i55SQV8De4SQuN/Hf9TydCpF11AeEbleHvbv9+JFxxeW5y1KaEj3mnpOyRMu2tAhaU3giHNHqOtszlmxL7PGXE/mQY1SssFhRhaA=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(396003)(39860400002)(376002)(230922051799003)(1800799012)(82310400011)(64100799003)(186009)(451199024)(46966006)(40470700004)(36840700001)(426003)(336012)(2616005)(1076003)(26005)(478600001)(966005)(6666004)(7696005)(36860700001)(47076005)(107886003)(83380400001)(15650500001)(7416002)(41300700001)(5660300002)(70586007)(70206006)(316002)(110136005)(8676002)(8936002)(4326008)(2906002)(921011)(82740400003)(86362001)(36756003)(7636003)(356005)(40460700003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 09:17:55.3097
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c14a38fa-6af2-49d8-176f-08dc10f3dd3b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5816

Add DT binding document for Tegra Security Engine.
The AES and HASH algorithms are handled independently by separate
engines within the Security Engine. These engines are registered
as two separate crypto engine drivers.

Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
---
 .../crypto/nvidia,tegra234-se-aes.yaml        | 53 +++++++++++++++++++
 .../crypto/nvidia,tegra234-se-hash.yaml       | 53 +++++++++++++++++++
 2 files changed, 106 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/crypto/nvidia,tegra234-se-aes.yaml
 create mode 100644 Documentation/devicetree/bindings/crypto/nvidia,tegra234-se-hash.yaml

diff --git a/Documentation/devicetree/bindings/crypto/nvidia,tegra234-se-aes.yaml b/Documentation/devicetree/bindings/crypto/nvidia,tegra234-se-aes.yaml
new file mode 100644
index 000000000000..206910e70ab3
--- /dev/null
+++ b/Documentation/devicetree/bindings/crypto/nvidia,tegra234-se-aes.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/crypto/nvidia,tegra234-se-aes.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVIDIA Tegra Security Engine for AES algorithms
+
+description:
+  The Tegra Security Engine accelerates the following AES encryption/decryption
+  algorithms - AES-ECB, AES-CBC, AES-OFB, AES-XTS, AES-CTR, AES-GCM, AES-CCM,
+  AES-CMAC
+
+maintainers:
+  - Akhil R <akhilrajeev@nvidia.com>
+
+properties:
+  compatible:
+    const: nvidia,tegra234-se-aes
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  iommus:
+    maxItems: 1
+
+  dma-coherent: true
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - iommus
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/memory/tegra234-mc.h>
+    #include <dt-bindings/clock/tegra234-clock.h>
+
+    crypto@15820000 {
+        compatible = "nvidia,tegra234-se-aes";
+        reg = <0x15820000 0x10000>;
+        clocks = <&bpmp TEGRA234_CLK_SE>;
+        iommus = <&smmu TEGRA234_SID_SES_SE1>;
+        dma-coherent;
+    };
+...
diff --git a/Documentation/devicetree/bindings/crypto/nvidia,tegra234-se-hash.yaml b/Documentation/devicetree/bindings/crypto/nvidia,tegra234-se-hash.yaml
new file mode 100644
index 000000000000..7fb32568756d
--- /dev/null
+++ b/Documentation/devicetree/bindings/crypto/nvidia,tegra234-se-hash.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/crypto/nvidia,tegra234-se-hash.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVIDIA Tegra Security Engine for HASH algorithms
+
+description:
+  The Tegra Security HASH Engine accelerates the following HASH functions -
+  SHA1, SHA224, SHA256, SHA384, SHA512, SHA3-224, SHA3-256, SHA3-384, SHA3-512
+  HMAC(SHA224), HMAC(SHA256), HMAC(SHA384), HMAC(SHA512)
+
+maintainers:
+  - Akhil R <akhilrajeev@nvidia.com>
+
+properties:
+  compatible:
+    const: nvidia,tegra234-se-hash
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  iommus:
+    maxItems: 1
+
+  dma-coherent: true
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - iommus
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/memory/tegra234-mc.h>
+    #include <dt-bindings/clock/tegra234-clock.h>
+
+    crypto@15840000 {
+        compatible = "nvidia,tegra234-se-hash";
+        reg = <0x15840000 0x10000>;
+        clocks = <&bpmp TEGRA234_CLK_SE>;
+        iommus = <&smmu TEGRA234_SID_SES_SE2>;
+        dma-coherent;
+    };
+...
-- 
2.17.1



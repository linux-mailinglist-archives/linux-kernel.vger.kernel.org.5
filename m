Return-Path: <linux-kernel+bounces-28283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB1882FC7F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61165B240DA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF041EB4F;
	Tue, 16 Jan 2024 21:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rd01i8Q/"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5741F947
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 21:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705439285; cv=fail; b=AJb8sIBMmpWxmVAoFP68P+AWB0Lys1XSu2Snrn5+6kl3FaWOPMrzYRyW+zz3PnOb+gmYFxQJAr1+6NjVM63dS1bBIXHsbbjdkAkf91uw9ASEU8+3aAJwrdupgYPKSklqFauhDofEj1aHn//uKNekNBGd8KnVFO1iSfPTlCrJTqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705439285; c=relaxed/simple;
	bh=7JlPwWIX8nkLcax2y49pXGk7e5CAW8IVlQOXl6heEss=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=NLDmVq7OUe3RyOnmXkaNFKi4XR52V+mSmQ9sARttWPtKLuna412crQXTk9P0saICxOHf8PQspoTHkvMiZ72zOzuk+2+ZKqP/UqGoEf4ftCiFs9o/+37jEsltyjgtyh2ksy8htv1sy3oxSaw6U2u0NsnvR80qxWhDUAOy1q+m7BI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rd01i8Q/; arc=fail smtp.client-ip=40.107.94.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K5Ek9jM6A5hTBILbIqWlLCsYWNO8iTucADXb6p+EOuwATL1d+euigHE5Rp54rdx+2m3LZhXU14My/C85CeYFN5g8mWI1vHiVc9kmFtBsoLrdEvypLCSdL/zyFVReNHXqcZO2MiOhfAnkof9tHP0neD8kqeoFAKjXDT3sqfLwtcrfJM0GK7lsjsXUizhthghFEnLN92rMwCsV8C2M2ObePBgCyBcOuwNCkzN6xMwBAmnf0JKL5j8iqyxI7G09W2uh39Epy4rJiGTL7jxz9Mc3Dv03qJOC/rR+M8byRkCdP8ytAGp0V42WUj36cGzl2cHp0W5L5hsJWmBxtclZmS9KTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OnGFXj8MDkTND3xWZzZ433ZP9hstmADQNbxHWJE1mDg=;
 b=lTsjrJrVsh6Gt9TWKQschx7kjCCyq7GrBrLC/HVSKWkdjOl+Rjf6jUib8fLMwAjx1jDbTimaIhIvpuR/M8tdfp1TI9rdo/rlhaf7X09f9JBnUVE24W2UiNMM0z64hdLNeAs+iEeHZsKTRBYcaFKFlDPUGMUvGw48q9WjJ1V8JyKIM3c3Jv4t59OGDeZWZoCYvq2VikLSw8jym8DRIbkh27Hv7iDPZ+vBso48yUuSrhUG81zJ1jZK5lTy16Cq8sdlUclZptar4+rCFZPtnLH/YmbMm4q1SCdISXupZ3U6ikrLj7pWbWkupQFePw17aHcAlkMgoAG+y+B7/Rlc9+K8Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OnGFXj8MDkTND3xWZzZ433ZP9hstmADQNbxHWJE1mDg=;
 b=rd01i8Q/HhOEgAGb4KYrHyrvVooofzWy6dDlENsxrbkFLqpEyEnKhlhIIt4mmF63Gr7MA13HJAdRk2RMn7iZFueh2JeExPbZ1GlPLQjf1XXPnYsIRPUkObIdqDNePPgx2nlHRfk9XvUO4lWlkAhemPAE1/k8eIKbjFNT7Ph/MNs=
Received: from MW4PR04CA0233.namprd04.prod.outlook.com (2603:10b6:303:87::28)
 by BL1PR12MB5826.namprd12.prod.outlook.com (2603:10b6:208:395::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Tue, 16 Jan
 2024 21:07:58 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:303:87:cafe::d9) by MW4PR04CA0233.outlook.office365.com
 (2603:10b6:303:87::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26 via Frontend
 Transport; Tue, 16 Jan 2024 21:07:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Tue, 16 Jan 2024 21:07:58 +0000
Received: from jallen-jump-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 16 Jan
 2024 15:07:56 -0600
From: John Allen <john.allen@amd.com>
To: <jwboyer@kernel.org>, <linux-firmware@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <suravee.suthikulpanit@amd.com>,
	<bp@alien8.de>, John Allen <john.allen@amd.com>
Subject: [PATCH] linux-firmware: Update AMD cpu microcode
Date: Tue, 16 Jan 2024 21:07:43 +0000
Message-ID: <20240116210743.3719008-1-john.allen@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|BL1PR12MB5826:EE_
X-MS-Office365-Filtering-Correlation-Id: 0867810e-5ac7-4d7e-9b65-08dc16d73768
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0EqISMIDZ0cEOSlMh9MXE6DzHchNRpvhJgbdHnDrjVj8VfljrstrTMEoVoXE/AsCFy+Cg0s0KRlkBz4mA6Hz72Oj42YsYhEXOJZ590oRdqY5sAHr5b4J4LDu2exyOpCS8YK8vfeCdMOIjvOIyOF9nkvb8NgYAdlhWKJ5zMpyTTuHjweVNwVZUcS73+lO5/nnwg9m4CaKm5iIDDvjVU6xKCXfhIAa78UH0cw2V72pXdYqJgeiv1rIcproSGLUujzFA49Q2IyJ47a3Pj124mvUukJAmN1zWpvsWDzMQfaIpw53CKB6UJuxVdz2+HSREdX9TrYkceVfejgCOnlg8xpTArbcdJO0F6G4xmzTql+jy9w+Tp6A27/szRviAqFXrk442iYjkcjlxYBDnbzAHLPkS6wKRba1kZX4VczyWC9u11XA8BtOxeUafy/Ev7dmz+Btl5LtZgX4a7NG8pAcAm2E7W8OsKUuaWHeq+UuSgSiFOyP14yFMgqgSElRGdnlp1jZINYEAv9vU4AfCZ4tr1GaKBOMPXSViB9HHmtrA3KQ9HQm5yNAaSVjEJxGMwyUeCb1nSXBju3Qqe5NT7e2N1h4N4iaNBCrNTGZMniEIWjK/ODHZM3zBiK72USlJANhO4kmvEcr4lwWRH8RuPXhxptOc7HUi39/4FztYsCYaVHIpSr1G6sz7McDlYLuLFy0MLVc3NuZdDj9LVBacBl2CHqdW0EhKsnjF7eIBtrxYbR2DvusMlwJ/M7W5lppwubrNvZGBlUt71yPh4Ovh/Gc6YNE2A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(136003)(376002)(396003)(230922051799003)(82310400011)(64100799003)(186009)(451199024)(1800799012)(40470700004)(46966006)(36840700001)(40460700003)(40480700001)(426003)(26005)(1076003)(6666004)(16526019)(83380400001)(336012)(86362001)(36756003)(356005)(82740400003)(81166007)(5660300002)(30864003)(15650500001)(4326008)(44832011)(36860700001)(2616005)(7696005)(47076005)(54906003)(70206006)(110136005)(70586007)(2906002)(8936002)(316002)(4001150100001)(41300700001)(8676002)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 21:07:58.1431
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0867810e-5ac7-4d7e-9b65-08dc16d73768
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5826

* Update AMD cpu microcode for processor family 19h

Key Name        = AMD Microcode Signing Key (for signing microcode container files only)
Key ID          = F328AE73
Key Fingerprint = FC7C 6C50 5DAF CC14 7183 57CA E4BE 5339 F328 AE73

Signed-off-by: John Allen <john.allen@amd.com>
---
 WHENCE                                 |   2 +-
 amd-ucode/README                       |   4 ++--
 amd-ucode/microcode_amd_fam19h.bin     | Bin 39172 -> 39172 bytes
 amd-ucode/microcode_amd_fam19h.bin.asc |  16 ++++++++--------
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/WHENCE b/WHENCE
index db019cfa..9db8b41f 100644
--- a/WHENCE
+++ b/WHENCE
@@ -4078,7 +4078,7 @@ Version: 2014-10-28
 RawFile: amd-ucode/microcode_amd_fam17h.bin
 Version: 2023-12-05
 RawFile: amd-ucode/microcode_amd_fam19h.bin
-Version: 2023-10-19
+Version: 2024-01-16
 File: amd-ucode/README
 
 License: Redistributable. See LICENSE.amd-ucode for details
diff --git a/amd-ucode/README b/amd-ucode/README
index a982ea1f..9fd019c6 100644
--- a/amd-ucode/README
+++ b/amd-ucode/README
@@ -38,10 +38,10 @@ Microcode patches in microcode_amd_fam17h.bin:
 
 Microcode patches in microcode_amd_fam19h.bin:
   Family=0x19 Model=0x11 Stepping=0x02: Patch=0x0a101244 Length=5568 bytes
-  Family=0x19 Model=0x01 Stepping=0x01: Patch=0x0a0011d1 Length=5568 bytes
+  Family=0x19 Model=0x01 Stepping=0x02: Patch=0x0a001236 Length=5568 bytes
   Family=0x19 Model=0x01 Stepping=0x00: Patch=0x0a001079 Length=5568 bytes
+  Family=0x19 Model=0x01 Stepping=0x01: Patch=0x0a0011d3 Length=5568 bytes
   Family=0x19 Model=0xa0 Stepping=0x02: Patch=0x0aa00213 Length=5568 bytes
-  Family=0x19 Model=0x01 Stepping=0x02: Patch=0x0a001234 Length=5568 bytes
   Family=0x19 Model=0xa0 Stepping=0x01: Patch=0x0aa00116 Length=5568 bytes
   Family=0x19 Model=0x11 Stepping=0x01: Patch=0x0a101144 Length=5568 bytes
 
diff --git a/amd-ucode/microcode_amd_fam19h.bin b/amd-ucode/microcode_amd_fam19h.bin
index 412e5fc83dafd35177aeb39bd75c463658694587..2717d54cfe69831e89143514eb28b2767aa71f41 100644
GIT binary patch
delta 10238
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
E09s*$0{{R3

delta 10238
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
F{{hVS(ANL}

diff --git a/amd-ucode/microcode_amd_fam19h.bin.asc b/amd-ucode/microcode_amd_fam19h.bin.asc
index 3955e529..9793fb43 100644
--- a/amd-ucode/microcode_amd_fam19h.bin.asc
+++ b/amd-ucode/microcode_amd_fam19h.bin.asc
@@ -1,11 +1,11 @@
 -----BEGIN PGP SIGNATURE-----
 
-iQEzBAABCgAdFiEE/HxsUF2vzBRxg1fK5L5TOfMornMFAmUoW6AACgkQ5L5TOfMo
-rnMHAAf/SxaKEu5l7FGXR+QJYc2oSJDpf9ZsHTkVnxqF1I3ReItEGAR3iqSWrsRw
-KA4niP9Ihr8EqwhOaOtqkRKKF9D5yg+DksnRWbh2VTUECO4KQxjHNrPp3JWEzBwb
-Xn+vRVP02ZRi3u4MCYbnDC4AfUSnKnldY3TTlNi/6HUaGS2pcw8Vjli/C06zwfgh
-WwUAoFMQl4SDJhbGfC9cb93MKjBl/0Hv4uhK5W8fJ1iUkMvY8Ijna/oDTZCNPqP0
-0AgOwdAdzoyOYWjbUXcwofz2Umpz12xmJW8yXNwdv1pmaCvv9aCJz1L49lGwFH9E
-lhhoFQ1SQL3hhPjTXO6DbeeT9+fjOg==
-=9Xav
+iQEzBAABCgAdFiEE/HxsUF2vzBRxg1fK5L5TOfMornMFAmWm4Z0ACgkQ5L5TOfMo
+rnOnPAgAl9jY26pXhFO3qVTFhjdZMVU7YxmzX9RQqJz3pNHWo4hIRj6m2i2pY3lr
+zJYNO9jeQj/XeKdq5VikAwmZxverrHAlQQiFg0XLd+BEt4yeuq0QvcQAToCCd3mO
+OvgkfT87ePU2SOZ7/HT+Blz25qEyR4WnJgUonTsJeVPyfWbcOjXynqnDjhMRlp/r
+Fc06bGrnu5dXT0Bom8zJ3WPLTfxwDyf5AW4CxH5dDspfd7skCYM0vXHxtL0Rb0l7
+ycQ8XruNYMXz2zy9lR2COu3+yx/oEB+Skr6Bhsr2zBX7niqb6Zt7Yt1S21+W5Wge
+Vv5LBIfslMGAM3ZphlwuSepDwGvCUA==
+=5Znh
 -----END PGP SIGNATURE-----
-- 
2.25.1



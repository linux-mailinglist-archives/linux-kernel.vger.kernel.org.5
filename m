Return-Path: <linux-kernel+bounces-4270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53FAA817A8E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 20:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECEF12835F6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 19:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8AB71470;
	Mon, 18 Dec 2023 19:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QeGDw5RF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB6D71454;
	Mon, 18 Dec 2023 19:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IdietPITXr8cbHuEqJ0iZFv6Vxq+AWvVZ2YZb1HXtCx8qh8gKxzGu9fIH+SdeTd7nPns5YJpKWdZel6sP6E/mwVx5w951C6nugJ0bH+q7i+T2PmwVxfOhOX/nPqCpwIB2T9GDeqZih1B8lRhL672IeFXM3Yr6CXVoE2z5XK/XpTF8Dm4BcUkA7t5b8AkC9sR8sc302YOf4ISr/Ldr+elinVd+arjYyI583Sn/N6JAwEN7x4yoJ4wdN2KKFHkaP2ql6E5I7sEO7xitDAUXQHhnP6DY+XD3+xN/zjYPp3IU9FMAFI7/2scQ8PbNA/SAgDy6oIkjBtSD/ZJ7D/0jzitUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zLH3yW1uH5bDerqp6quJAyeThSTZNbWhhKn/RyDT+so=;
 b=oeEghgL1ayEMDfX4Wd9yMUS5UsjMvC2VpmnraDx6VHY8gohkL0o5R6JunouSJte59sUwVdvvkwnLCQNa3JRqkL+nwUaA8uOja4lSZah7HU1Z9kKrTcAXnGQWGHnLgt4MwV/4EKo1aVEqro0UIGdHfKoLjERuU9BrGjGkT7crv23+acFOV5VlvwkT9bPcNlmIIdlc7rTYbL2XBe5UDt8Eh6TjOW34GZvTByONK2m0VVhyGDZvI3c74XbBrgVIWoPJA7H6TsRuHe3Yf2cmGtPPb6sNXgLbyavNh0+FfDEBh3CFf51jPklwTATQDWtozcBdCw5EUqQCjFPFPzjbQUFI1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zLH3yW1uH5bDerqp6quJAyeThSTZNbWhhKn/RyDT+so=;
 b=QeGDw5RFQ9NPaTJrt2ZypimF+Qkg++9YuGQvQ4iNaTIifZbEkN8qbH0Lfav5XQeIiJ1aWo3cLHPStGHYP6w2fAchoLWQelbQMIj7VGeA6MEqySE8rhd9WVRJvzSRXnOhlyZ88/qzeHYYFO0Pcd42xyDKqX/XxghAVeEbKtsKkqc=
Received: from DM6PR13CA0007.namprd13.prod.outlook.com (2603:10b6:5:bc::20) by
 IA1PR12MB6602.namprd12.prod.outlook.com (2603:10b6:208:3a2::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.37; Mon, 18 Dec 2023 19:04:24 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:5:bc:cafe::6) by DM6PR13CA0007.outlook.office365.com
 (2603:10b6:5:bc::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.17 via Frontend
 Transport; Mon, 18 Dec 2023 19:04:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Mon, 18 Dec 2023 19:04:23 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 18 Dec
 2023 13:04:20 -0600
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <bp@alien8.de>, <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <avadhut.naik@amd.com>,
	<tony.luck@intel.com>, <john.allen@amd.com>, <william.roche@oracle.com>,
	<muralidhara.mk@amd.com>, Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v4 3/3] Documentation: RAS: Add index and address translation section
Date: Mon, 18 Dec 2023 13:04:06 -0600
Message-ID: <20231218190406.27479-4-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231218190406.27479-1-yazen.ghannam@amd.com>
References: <20231218190406.27479-1-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|IA1PR12MB6602:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c1ecb56-1aa2-4de4-6b0e-08dbfffc2603
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aRNQRAlorU8Crgv05c4V+9LOtfmG2vE1C+WNqVabPtXZhrGH1wAYgmaxwdrmc0FcDuONaEOogQL/D0WiyQGOjFvhkjRLQFfei1YnnF6miGcYNITyZXkxL9wpvu3mEcfWu3U3pgsURNGZipqy5w9UX5lhhGZ/8i9Rn2VJxh2yM/XuTOebDDnhXC7TTIh7hr+RQCbdxZqB4oBbt0/dHDMcEj9MZcixKCAcmRw3EsufpRuHTX0Y+C0YW3hqs6Pfqhh65E4z6HUzvAeScGEWKKihH1hFJ7D7COnFgw4JnHQ0ZnHeKz318P66badYYMSBXPs335EKBPUyh25ZvzI1u9yJ+ciruoRjIVVmA6bFqJOpKVRNkh1FIQeLJgbU74A8EM14TdIPAicRms2HCFa8gQkx0o7BQQhk2opjWY2x9cYeNl29WRS0IRL+6MBPlLhTKT76E2FnwPuWkqGrHYxMuURr+rujQR74H6r3pNBfzuC9fOFCwTqiydwPYWKugcuuR54mQp15Yh31M1QEQ0JU6ooscLrhCR1J6sOvNU9nV4zJSj7oBUmB2UlUk6nOonxOTSpdJI2gtO+KQbRb9WiVQ1zGLRxjQTfYffNvSQ+aCPkObolcmKVjvw9cPyiNtBhAcAut8E2jUkqtnT2e3U8BLwgotcJIz0fl0akJYzTDMBUsXiu6q4U2EAjfXC2Cg7g1H7wL7CyMvA098lgdxN0L1pS5zyjR4Dtmaprm007zT4nNd/pFSzQECpKtR7mOL+t0Qi5S4V2YV6tekmSf8n4j3DnQsgZZLSjSAJzAejiXwZWeNwU=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(136003)(346002)(396003)(230922051799003)(64100799003)(186009)(82310400011)(451199024)(1800799012)(40470700004)(46966006)(36840700001)(40480700001)(1076003)(16526019)(336012)(426003)(2616005)(26005)(40460700003)(82740400003)(356005)(36756003)(86362001)(81166007)(83380400001)(5660300002)(44832011)(47076005)(2906002)(7696005)(6666004)(36860700001)(8676002)(4326008)(70586007)(70206006)(54906003)(316002)(110136005)(8936002)(41300700001)(478600001)(966005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 19:04:23.6719
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c1ecb56-1aa2-4de4-6b0e-08dbfffc2603
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6602

There are a lot of RAS topic to document, and there are a lot of details
for each topic.

Prep for this by adding an index for the RAS directory. This will
provide a top-level document and table of contents. It also provides the
option to build the RAS directory individually using "make SPHINXDIRS=".

Start a section on address translation. This will be expanded with
details for future translation methods and how they're used in the
kernel.

Move the error decoding topic to its own section. Links to other error
decoding kernel docs will be added.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lore.kernel.org/r/20231210194932.43992-4-yazen.ghannam@amd.com

v3->v4:
* Replace "CS" with "COH_ST" in glossary.

v2->v3:
* New in v3.
* Move term glossary to Documentation.

v1->v2:
* N/A

 Documentation/RAS/address-translation.rst     | 24 +++++++++++++++++++
 .../RAS/{ras.rst => error-decoding.rst}       | 11 +++------
 Documentation/RAS/index.rst                   | 14 +++++++++++
 Documentation/index.rst                       |  2 +-
 MAINTAINERS                                   |  1 +
 5 files changed, 43 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/RAS/address-translation.rst
 rename Documentation/RAS/{ras.rst => error-decoding.rst} (73%)
 create mode 100644 Documentation/RAS/index.rst

diff --git a/Documentation/RAS/address-translation.rst b/Documentation/RAS/address-translation.rst
new file mode 100644
index 000000000000..f0ca17b43cd3
--- /dev/null
+++ b/Documentation/RAS/address-translation.rst
@@ -0,0 +1,24 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Address translation
+===================
+
+x86 AMD
+-------
+
+Zen-based AMD systems include a Data Fabric that manages the layout of
+physical memory. Devices attached to the Fabric, like memory controllers,
+I/O, etc., may not have a complete view of the system physical memory map.
+These devices may provide a "normalized", i.e. device physical, address
+when reporting memory errors. Normalized addresses must be translated to
+a system physical address for the kernel to action on the memory.
+
+AMD Address Translation Library (CONFIG_AMD_ATL) provides translation for
+this case.
+
+Glossary of acronyms used in address translation for Zen-based systems
+
+* CCM               = Cache Coherent Moderator
+* COD               = Cluster-on-Die
+* COH_ST            = Coherent Station
+* DF                = Data Fabric
diff --git a/Documentation/RAS/ras.rst b/Documentation/RAS/error-decoding.rst
similarity index 73%
rename from Documentation/RAS/ras.rst
rename to Documentation/RAS/error-decoding.rst
index 2556b397cd27..26a72f3fe5de 100644
--- a/Documentation/RAS/ras.rst
+++ b/Documentation/RAS/error-decoding.rst
@@ -1,15 +1,10 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-Reliability, Availability and Serviceability features
-=====================================================
-
-This documents different aspects of the RAS functionality present in the
-kernel.
-
 Error decoding
----------------
+==============
 
-* x86
+x86
+---
 
 Error decoding on AMD systems should be done using the rasdaemon tool:
 https://github.com/mchehab/rasdaemon/
diff --git a/Documentation/RAS/index.rst b/Documentation/RAS/index.rst
new file mode 100644
index 000000000000..2794c1816e90
--- /dev/null
+++ b/Documentation/RAS/index.rst
@@ -0,0 +1,14 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===========================================================
+Reliability, Availability and Serviceability (RAS) features
+===========================================================
+
+This documents different aspects of the RAS functionality present in the
+kernel.
+
+.. toctree::
+   :maxdepth: 2
+
+   error-decoding
+   address-translation
diff --git a/Documentation/index.rst b/Documentation/index.rst
index 36e61783437c..07f2aa07f0fa 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -113,7 +113,7 @@ to ReStructured Text format, or are simply too old.
    :maxdepth: 1
 
    staging/index
-   RAS/ras
+   RAS/index
 
 
 Translations
diff --git a/MAINTAINERS b/MAINTAINERS
index 9db88a691bdf..c566cd9654ef 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18106,6 +18106,7 @@ M:	Tony Luck <tony.luck@intel.com>
 M:	Borislav Petkov <bp@alien8.de>
 L:	linux-edac@vger.kernel.org
 S:	Maintained
+F:	Documentation/RAS/
 F:	Documentation/admin-guide/ras.rst
 F:	drivers/ras/
 F:	include/linux/ras.h
-- 
2.34.1



Return-Path: <linux-kernel+bounces-21085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37752828985
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 16:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F1881C245D6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D349B3A1D0;
	Tue,  9 Jan 2024 15:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AB4qyjH9"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2060.outbound.protection.outlook.com [40.107.95.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFBC39FE8;
	Tue,  9 Jan 2024 15:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W814sEKkK2Uclal5E5djdEFSOZKSnyJvdnYIdg83DWDLGTllj0jYJ/XkFrz/1zUcODvKT+AMClWShRJTKAFiQyNh+Igyfi4BZN6x2sypM0plovzbZ6jkl2rQqigxlRX8M1PQHNO9nM8OqXL5zr53em8DFjfvr75rkVmpXZRZ7OKJ7oM/pPTkAU6wENRmGNMVSLf1p/wBC/ImD9q0C4crXmFMCfpj/iyH6fw9y3gf6xmAh5vDmDfvK7qz7qBtircCijNgmGfHOiVqfcQVYSPTajCSU6Ztjuil7KM+uG1Pem7YgTdDUXybbIXQlVbnmjkDXnbKDnpIpeMdUPb4ddnZdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=67csm03dMuxVzC+WJ123BgapIAofK7Fqg6WZczWTLZw=;
 b=VwD0WClhMRqz8a4M56zIjOGmxRE2zAOGDKNbwGFXgTWeFes6XeLQKzH5oihfs9wY1ZpJF1yZRigDciOHkzKw1vp6dWrzQpjfQhOK39j5PAwUzVtZLVE3dFab2gYlyq92ZgFP//JFcio9qP+UiW0AIrf+19hOuFRmzIo6ycRdJOog70ZpEfAHGyazqU9ek8UDPCnpzY4DaBQWccEdTxwVTo4pU2uzip6IwhbeJf3+623DoGTj+iytxmoaRpXBlOJuh8x5OCIgJTmJukZCgm/8cchuPW6WYcXoFQqlNyTvGynKD6xwzv9qtM57WHqQXaFLWz+N8W/q5dyfKpANtvTznA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=67csm03dMuxVzC+WJ123BgapIAofK7Fqg6WZczWTLZw=;
 b=AB4qyjH91g+tkFPFIlIut179zIvd4A/QFU6fY4gz2sp/y9kI+Y0DEqtUgUf/AByve+0cI34sHdaoyGbRb5fpRywoWa9QLTczVVutyma+/9z8phvCB5b4YljgY7hT+BBA3shhKghVM2ALm0+CKwFH/DVbDrPkE6G1Yk8qCOvyV84=
Received: from SJ0PR05CA0078.namprd05.prod.outlook.com (2603:10b6:a03:332::23)
 by DS0PR12MB7826.namprd12.prod.outlook.com (2603:10b6:8:148::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 15:56:47 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:a03:332:cafe::88) by SJ0PR05CA0078.outlook.office365.com
 (2603:10b6:a03:332::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17 via Frontend
 Transport; Tue, 9 Jan 2024 15:56:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.4 via Frontend Transport; Tue, 9 Jan 2024 15:56:46 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 9 Jan
 2024 09:56:45 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 9 Jan
 2024 09:56:45 -0600
Received: from iron-maiden.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Tue, 9 Jan 2024 09:56:44 -0600
From: Carlos Bilbao <carlos.bilbao@amd.com>
To: <corbet@lwn.net>, <rdunlap@infradead.org>, <vegard.nossum@oracle.com>
CC: <bilbao@vt.edu>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Carlos Bilbao <carlos.bilbao@amd.com>
Subject: [PATCH v2 2/2] docs: Include simplified link titles in main index
Date: Tue, 9 Jan 2024 09:56:43 -0600
Message-ID: <20240109155643.3489369-3-carlos.bilbao@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240109155643.3489369-1-carlos.bilbao@amd.com>
References: <20240109155643.3489369-1-carlos.bilbao@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|DS0PR12MB7826:EE_
X-MS-Office365-Filtering-Correlation-Id: 66324a41-cee9-4ed9-a882-08dc112b9567
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xdrwvK/2NYNr1JvPzd5Gq9Q0dQRVC8qsS5AhuAHlbxr8xIh5SwpS05tLVAZy180iEa/v7Vbvk3PVfEmizXX9iyas6rEo0mEC79ZRqx9UY/tiTxi57JQNLFfn1seQJ90UovTZwK2U1DuzKg1/XR3eGn5OjddBq69Fyb+fCcuzTEDmk6HZOH7psMYY71ALHzw/sVt335mE73PvcfFAMDX1VgOxSFxdGEiODf4hAfnWftqtgPSE1T1aKu/kaJp+3tsc+NjZTdb5/TO1TD9DAXuJWma1LxYwGdi0JW89OKaeFzm2z35mnoogKejDGPG4f1QOvLgJIChEG/dA2KxNFvdwUf3P/+cZRV/K/jWEzTAV6AmTQ2o/wdCXP9admo/g3rZN8a4lmXZycrAfDqmjZF71m4HsKx5JJlJMQxz0ZxBhpQ30LRVhqmOw3hhIS6llMZxfqKWbcZEdKgwaccIb05vIZSEk+F0OhTT1OGgdmxIx8MuQbF98emB8Yw9ao7cbhTpmcj6ehs2tcg1fu6L6aTmMoudE4VYWiEuYAXuSkUCy0QtsxVTDAro2N1V+WC6cyvzrE32Izr129ag1XyIy9cQOe//cSKc2aA/koKk8GsYqicsgo75ukBG1s01MCQNHpm9w2uqBYlWAAVeUBCylov+CvLBt4AXDq+XMcW7tQR44frcHT8WAIUQgPETNffTQylFTFcJ8xP0kvOxa4ENA2kLDa5ri1MQ6x1oZ5Rpwosmz7zg=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(39860400002)(136003)(346002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(82310400011)(40470700004)(46966006)(36840700001)(40480700001)(40460700003)(83380400001)(41300700001)(70206006)(70586007)(36756003)(81166007)(356005)(86362001)(82740400003)(36860700001)(47076005)(316002)(1076003)(336012)(426003)(2616005)(26005)(478600001)(2906002)(54906003)(110136005)(7696005)(4326008)(44832011)(8936002)(8676002)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 15:56:46.6226
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66324a41-cee9-4ed9-a882-08dc112b9567
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7826

Include simplified link titles in the main page's documentation index to
enhance website's readability and UX. Update the text that directs users to
various documents without changing the actual titles chosen by the authors.

Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
---
 Documentation/index.rst | 52 ++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/Documentation/index.rst b/Documentation/index.rst
index 9dfdc826618c..5298611e00ee 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -22,10 +22,10 @@ community and getting your work upstream.
 .. toctree::
    :maxdepth: 1
 
-   process/development-process
-   process/submitting-patches
+   Development process <process/development-process>
+   Submitting patches <process/submitting-patches>
    Code of conduct <process/code-of-conduct>
-   maintainer/index
+   Maintainer handbook <maintainer/index>
    All development-process docs <process/index>
 
 
@@ -38,10 +38,10 @@ kernel.
 .. toctree::
    :maxdepth: 1
 
-   core-api/index
-   driver-api/index
-   subsystem-apis
-   Locking in the kernel <locking/index>
+   Core API <core-api/index>
+   Driver APIs <driver-api/index>
+   Subsystems <subsystem-apis>
+   Locking <locking/index>
 
 Development tools and processes
 ===============================
@@ -51,15 +51,15 @@ Various other manuals with useful information for all kernel developers.
 .. toctree::
    :maxdepth: 1
 
-   process/license-rules
-   doc-guide/index
-   dev-tools/index
-   dev-tools/testing-overview
-   kernel-hacking/index
-   trace/index
-   fault-injection/index
-   livepatch/index
-   rust/index
+   Licensing rules <process/license-rules>
+   Writing documentation <doc-guide/index>
+   Development tools <dev-tools/index>
+   Testing guide <dev-tools/testing-overview>
+   Hacking guide <kernel-hacking/index>
+   Tracing <trace/index>
+   Fault injection <fault-injection/index>
+   Livepatching <livepatch/index>
+   Rust <rust/index>
 
 
 User-oriented documentation
@@ -72,11 +72,11 @@ developers seeking information on the kernel's user-space APIs.
 .. toctree::
    :maxdepth: 1
 
-   admin-guide/index
-   The kernel build system <kbuild/index>
-   admin-guide/reporting-issues.rst
-   User-space tools <tools/index>
-   userspace-api/index
+   Administration <admin-guide/index>
+   Build system <kbuild/index>
+   Reporting issues <admin-guide/reporting-issues.rst>
+   Userspace tools <tools/index>
+   Userspace API <userspace-api/index>
 
 See also: the `Linux man pages <https://www.kernel.org/doc/man-pages/>`_,
 which are kept separately from the kernel's own documentation.
@@ -89,8 +89,8 @@ platform firmwares.
 .. toctree::
    :maxdepth: 1
 
-   firmware-guide/index
-   devicetree/index
+   Firmware <firmware-guide/index>
+   Firmware and Devicetree <devicetree/index>
 
 
 Architecture-specific documentation
@@ -99,7 +99,7 @@ Architecture-specific documentation
 .. toctree::
    :maxdepth: 2
 
-   arch/index
+   CPU architectures <arch/index>
 
 
 Other documentation
@@ -112,7 +112,7 @@ to ReStructured Text format, or are simply too old.
 .. toctree::
    :maxdepth: 1
 
-   staging/index
+   Unsorted documentation <staging/index>
 
 
 Translations
@@ -121,7 +121,7 @@ Translations
 .. toctree::
    :maxdepth: 2
 
-   translations/index
+   Translations <translations/index>
 
 Indices and tables
 ==================
-- 
2.34.1



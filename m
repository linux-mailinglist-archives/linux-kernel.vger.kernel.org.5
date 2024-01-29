Return-Path: <linux-kernel+bounces-42501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE52584023E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52C0B1F22251
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954965821B;
	Mon, 29 Jan 2024 09:52:42 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2056.outbound.protection.partner.outlook.cn [139.219.17.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F082E5730E;
	Mon, 29 Jan 2024 09:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706521961; cv=fail; b=Ql2PUChx/Ku0Ol5x6Hl1WcPGNLli2wlQrXoTz8EncZjkwAO3tIHuS0uPrGCEQv7HWx82Q6AIuOju+VzNMcyiIxT4LerNXiyPV0CdZ0QyJQ/P/TWzepQSncR3ukhMHDl+/mZBREldAcKuFLzvdjBlEFrkC59BUrg9weuTmeKIYmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706521961; c=relaxed/simple;
	bh=CB99zG8HhfF22E7aqWlXnOKkEPjAQhb/STW3349+S/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j6CTIyZG8jAdtW0Te1fsT/qJn1rkOdtM34BIjmqfOQ+W26RmXk085++1oR1pl1sVzX3N8UOX9TcQE5p71mJqRrXJq3HJpEGmP054TaDaOGK8aaoRitaJIgOeTTpM8FtOto0ulu5hf83g/lsdNCOV4dFns4kAK0HIVc4niX/KtNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RDLVDrTIZnk+H8gDi0tkF6uJglF6O0TVrfsJs1Z+dRrYhPvk4xMphiWtEglcdeUswRDSH0+ZW+2UOozegl0BTrjXviou4D4x9bBK8neb66w1iAF0QDoux4wCdKTxxmDffYVuXGWupF58pRL+sZMHp/WFFEKNuTfQMjmdUT2YD4uX7PfnUU4F3jJDP6WZyPtseVKA7EbLip7IOE01BuUceXDt1lOaOgUCbV1ursBDBkI5lUjIAKx5tukFq6fdhnNCofqmtZMSaf/HvbrG6U2mHymwbf5h9Moh10hrkuxnfjdG8vS0ZXENL01VLtibmAxSl+ha4fUeqlcjOa5kQflmFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1FFxmi1pkgFbG+fBdZqjANt92yeGgJun+j8l/3qx9o=;
 b=V0nbX/SgfMfGQD6PGIb8xZZ7fPIcAQrSzA7EZFl2LZ+ctMkj1+OgJ29kTrb6xq8RgG+7qPpJOIku7sOoD1F274ooT5Et2uKmXcBeEeMXy82idFpPNaqOD7iIoXRx5NDU7+0kg1kdUfcb43TfW6B10xUdpaEXl/VfZBnIDFA7LcbMbo6E6fD48SA4T1k9myCT0lHEPjFS0GCYMg6mychkAolmcYyNjeow8U4Et8W2friz73z/z0tKiOyVrFRH12c4Dm3meWu46HyLC7oBiOijYE9SZNRNS8nEkA1u0OZpNtFlQ7TtvSA0rIJIuZduXKY6mk3tMP2PBZLR6SZE3a2/RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:19::6) by ZQ0PR01MB1096.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:c::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Mon, 29 Jan
 2024 09:52:30 +0000
Received: from ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn
 ([fe80::1dbb:b090:7d89:4e22]) by
 ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn ([fe80::1dbb:b090:7d89:4e22%4])
 with mapi id 15.20.7228.028; Mon, 29 Jan 2024 09:52:30 +0000
From: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>
Cc: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>,
	Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: [PATCH v6 3/4] docs: perf: Add description for StarFive's StarLink PMU
Date: Mon, 29 Jan 2024 17:51:40 +0800
Message-ID: <20240129095141.3262366-4-jisheng.teoh@starfivetech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129095141.3262366-1-jisheng.teoh@starfivetech.com>
References: <20240129095141.3262366-1-jisheng.teoh@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SH0PR01CA0003.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:5::15) To ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:19::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB1160:EE_|ZQ0PR01MB1096:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bef0a80-2c29-487c-4861-08dc20b001f7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	I8SbE16cffhpoKkFS8+m/3oR32oUtkGJfHLCNVAbabBH4KukNs15bX5RTndlj7Ax8QeTGvqqZF6V3JMTY0hzfqu6ptCnrutifoidq5x22YT8llS3S0NX8aDV86mzKSBN0/adh9YeuJL2YKmt5DdtC1Nrrbwi0xhtJ0E4bCGMEX6bm/KS3CCTx41Qt4GYnmZ5nzG2c1sAZ6SzTnedw7G7jlne9N7cLaLvi1lSiSkwEGphkeba488KfZ+REDdBKPQTbrMHT7yeEvMczAZwZZtxr2wmc44GOBpo2UI72BU5W9Q3YCosBTdG5FoMAssXh0zzMBFyNIIj8OMR/bmosIQlhfQxa2X0KSP8xraVWlqhHZxn2Y89Ni0NGkO0eXD9YMzcTU8df/lMCYm2ALIgqXDD3MFNiYSXoi2xBqJsanyf5edddFQwqSt+sTtH6ruqW0VbPgvG4Khm/YqDi31MsCsllUyqvZq7AA7zQo9YS9oKsdf/6gO5hMA9+u0hhR7NYCELczLTSk3sQxjWtCgsEU2B963b25AjlXTmI7JQqnjq1ctGFzgglI23lBEKk9fjeDcLTU18PeVCEYIM6gZVsmOsPQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(396003)(39830400003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(41320700001)(4326008)(7416002)(8676002)(8936002)(66946007)(66556008)(5660300002)(110136005)(86362001)(2906002)(40180700001)(38350700005)(36756003)(52116002)(54906003)(508600001)(38100700002)(40160700002)(66476007)(83380400001)(2616005)(6666004)(41300700001)(1076003)(921011)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uHh6anpbjDjWu9nwpNSOG430bhReBLG/utxD/mYa0yDvq6gdFbZrA/EpuGkg?=
 =?us-ascii?Q?++ZmbNknIj7NQEjGpVANY4+Q+cDqFdfi2Oho2g0O6GZyCFF4XGMxuA3oVjE8?=
 =?us-ascii?Q?5VTLF47Ik2s+0LjjJ4Ttn+9Ka1TaFEyuX2cwz4ed/es0+ar8c2QLTQEddROl?=
 =?us-ascii?Q?HZRmywqXisa8GObs8GDIi4x7eMLIWYXIuGqb7biybGA62HW7+r98B6GD7CgD?=
 =?us-ascii?Q?b6Kn2xUL9idg7+uhwpZFc1Ioxxc2O/zywXp/hTS0ABH3AQv2hSNPWYPNiEAE?=
 =?us-ascii?Q?v3leCrcKJOKaXa8dEsfAGSsLEEbdZPfZCiHJ9TQ3tWm1B28+nfRgJ0v5vb2f?=
 =?us-ascii?Q?I7Y56uohXa1RG2h3zCps14fj+JwcCZbhdK0Sm+MwbNqMHvV1YFVEckHLDy6g?=
 =?us-ascii?Q?T6rllfzMshsSxDxOr3ajZG021jIXpGSWJGBOxdG8b5gx1lgUhvUyJPTfq50p?=
 =?us-ascii?Q?sHmZY/6K0jpC1iBaWD/FRbqRpjKFlLf1wNLjti3EJTqHHnDP2cvWGzsGWlGM?=
 =?us-ascii?Q?JvwxLsLSQIUvLiH2UMdPoSdYzqUUri79PlBwkmqJdoQ53PAqrDUIXYS4WW2C?=
 =?us-ascii?Q?K0WoxvsOuZHfyI+cNcDJ1gw1VWF6YVSYR+gwYhwVeJ+GD6t2WRI3t61LsItv?=
 =?us-ascii?Q?kqKveO2QpKE75uB5+Mc7hODdDZjD+61twkjh0BdkFfYLp3iNOEgFsGvNKt00?=
 =?us-ascii?Q?dWpqgzvXiXPy6GnvSwRFOU5mrYgmUQ5O2NL63wtvbSwVE/iL31R6MCDDKqci?=
 =?us-ascii?Q?mHgpWmJS9zQ0a6gonV/uRdV4YidEQNU16KuHBX7GuMg2dCbN1iKmXt54FAEp?=
 =?us-ascii?Q?PdVcLLTvTJDs1QpMwxQLCK8sGN/u55e5KIbvvZeKpaXwAnUWRV/Z5tFZ0HJN?=
 =?us-ascii?Q?hvXEnZKsTDaZa/z/Gy2N60mwlmdDj2MeVFVPUuJJc8LfPq9RmY+g2KhnFJzR?=
 =?us-ascii?Q?JHUD6zCkkMX2Rq0diKegj/OAZkOGtuiXwyYP7dm6aDGQZc3TOcFJ9yqfnXb8?=
 =?us-ascii?Q?fHfw9cCdZfrvxaUlPh11Vk2oEfHX/hcEwXfs5R2zgMEn2gKreDAI0laxBrZQ?=
 =?us-ascii?Q?p/zbd7hUU3Td08ImMTBtXwkEa0y3dnRlrf/eRA/L92a53e4SKYsXxzzG0kiD?=
 =?us-ascii?Q?m20y0nAN7r9E24Qt0i+nVTD8mi3MBpmYar0hIEyvZzER4eCk8J/cxCOqPK+T?=
 =?us-ascii?Q?NDIpzUuPTsOz8a/HW/79fh0h55qGPAni5kfDM6FrAkpOCCRsx0CVgp5fUxLK?=
 =?us-ascii?Q?7b9cji2lxl9wxNiq/8dxVG3ptcfBrDRAcz1wy6gnVB7YgpsaYIc97+NjsVfP?=
 =?us-ascii?Q?H2VwtF//5IzcKFlMHbys7u357KU8dg52WVJuKNUJMpdam2NcgAzReYYj9vqY?=
 =?us-ascii?Q?H+Bp51HTxSS3W7qQ9teoyVYpIlSgcHUrMnvf9f1VPGbw73y9CjI1Xptve9Ba?=
 =?us-ascii?Q?UoO/B/vwlGv8cgvMFa4RPcxf++AvQU+3U2m+MaHHObiTdy6mnYnVLat0SBUC?=
 =?us-ascii?Q?2PFj2JtAJGnVlelVssty9zHrSvfPvRdReQ+ssebs5raE7gJk9cu63G1F0rO1?=
 =?us-ascii?Q?bW6XnQYwTBZ8fW8hgtnir6yQZnqFh9pNpzQUAIbVnLfg94UN1528ISOp6dBb?=
 =?us-ascii?Q?lg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bef0a80-2c29-487c-4861-08dc20b001f7
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 09:52:30.0912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nc7G6yoB2ugdC2RJav0B2XpyWajoR3a14mTK5o2XJdzuSh+mm3YBLrVRiqm5cT8go+yeoBXW/CZ1jBPjlqMzFR4driVjnCF8n2TA9Zv02qY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1096

StarFive StarLink PMU support monitoring L3 memory system PMU events.
Add documentation to describe StarFive StarLink PMU support and it's
usage.

Signed-off-by: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
---
 Documentation/admin-guide/perf/index.rst      |  1 +
 .../perf/starfive_starlink_pmu.rst            | 46 +++++++++++++++++++
 2 files changed, 47 insertions(+)
 create mode 100644 Documentation/admin-guide/perf/starfive_starlink_pmu.rst

diff --git a/Documentation/admin-guide/perf/index.rst b/Documentation/admin-guide/perf/index.rst
index a2e6f2c81146..c5de7579a71b 100644
--- a/Documentation/admin-guide/perf/index.rst
+++ b/Documentation/admin-guide/perf/index.rst
@@ -13,6 +13,7 @@ Performance monitor support
    imx-ddr
    qcom_l2_pmu
    qcom_l3_pmu
+   starfive_starlink_pmu
    arm-ccn
    arm-cmn
    xgene-pmu
diff --git a/Documentation/admin-guide/perf/starfive_starlink_pmu.rst b/Documentation/admin-guide/perf/starfive_starlink_pmu.rst
new file mode 100644
index 000000000000..2932ddb4eb76
--- /dev/null
+++ b/Documentation/admin-guide/perf/starfive_starlink_pmu.rst
@@ -0,0 +1,46 @@
+================================================
+StarFive StarLink Performance Monitor Unit (PMU)
+================================================
+
+StarFive StarLink Performance Monitor Unit (PMU) exists within the
+StarLink Coherent Network on Chip (CNoC) that connects multiple CPU
+clusters with an L3 memory system.
+
+The uncore PMU supports overflow interrupt, up to 16 programmable 64bit
+event counters, and an independent 64bit cycle counter.
+The PMU can only be accessed via Memory Mapped I/O and are common to the
+cores connected to the same PMU.
+
+Driver exposes supported PMU events in sysfs "events" directory under::
+
+  /sys/bus/event_source/devices/starfive_starlink_pmu/events/
+
+Driver exposes cpu used to handle PMU events in sysfs "cpumask" directory
+under::
+
+  /sys/bus/event_source/devices/starfive_starlink_pmu/cpumask/
+
+Driver describes the format of config (event ID) in sysfs "format" directory
+under::
+
+  /sys/bus/event_source/devices/starfive_starlink_pmu/format/
+
+Example of perf usage::
+
+	$ perf list
+
+	starfive_starlink_pmu/cycles/                      [Kernel PMU event]
+	starfive_starlink_pmu/read_hit/                    [Kernel PMU event]
+	starfive_starlink_pmu/read_miss/                   [Kernel PMU event]
+	starfive_starlink_pmu/read_request/                [Kernel PMU event]
+	starfive_starlink_pmu/release_request/             [Kernel PMU event]
+	starfive_starlink_pmu/write_hit/                   [Kernel PMU event]
+	starfive_starlink_pmu/write_miss/                  [Kernel PMU event]
+	starfive_starlink_pmu/write_request/               [Kernel PMU event]
+	starfive_starlink_pmu/writeback/                   [Kernel PMU event]
+
+
+	$ perf stat -a -e /starfive_starlink_pmu/cycles/ sleep 1
+
+Sampling is not supported. As a result, "perf record" is not supported.
+Attaching to a task is not supported, only system-wide counting is supported.
-- 
2.43.0



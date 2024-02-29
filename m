Return-Path: <linux-kernel+bounces-86260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 894E786C307
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7586D1C21463
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E51481AD;
	Thu, 29 Feb 2024 08:05:25 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2119.outbound.protection.partner.outlook.cn [139.219.146.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B6A4E1CB;
	Thu, 29 Feb 2024 08:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709193925; cv=fail; b=t7gWZs/4Cz3Qs7F8Wv3b2V8aVx4VfzDGz7z7jMO/JmvK7wZIUexoDE/8SAHv7gxSnvDSbd528NNZ8FxkY+b8oMzFA7Gze8AmRmxvFDBSTlnhxSX7ZaepVTq1vgk8W6vSh4rnfcfcTcOZkG/Y74O1OXfGJ6dZ714JpETF87yBpMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709193925; c=relaxed/simple;
	bh=CB99zG8HhfF22E7aqWlXnOKkEPjAQhb/STW3349+S/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I3Pm9LpS9r4i5Mlb3FcujdtZK8hoB6ZybKtjf4AFFGyUuZMs+OeH4dZ73oy9ZSvzj73ag1HpQ43+y4R7yjwLkgFlPXHDnbYcL26cmDg7s4KgwnNwmUnRVygBOjYo427h3sgxLwJsPWE0xNWRrc329FgbZ0qQ8b0Ivz9vS4iWDnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ma7WNjNB8RWGF7D4s3fgkSFfBM/zNY80kWMWjLI/NuWdut+QIasVCO7x7F22F1/3G5mvVRI0Qp8Uy9Y67XQK8odg7+ol5A8xu//688RdIvhkD5RG7Pq95sKC+xszEY7AUSFWQfA4qJdRT4DKbf0o9w+Bgtn/CJPDqih7dIqgpdDENOVVhM3rQ29CbJAs4DnamFw0GJLvvwnAvQXUJqa8FLiZtY1IvWjrx/k/ED+Lvuhy+qjyZ9jU4x4Fk7BGiIk8XABHvgHMLxbP9M/FvMBAdx+uA1uxgT5yvea5FQWvOVyBj/uxgEYoeyY3bqGADioFhL4vrXHFnCc3pJwz8PKrhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1FFxmi1pkgFbG+fBdZqjANt92yeGgJun+j8l/3qx9o=;
 b=g03sDGRdIyYnpp3jzcnvarhxDj5jgLNRYx7JPpPum0WwNjFG8r0PWLMX2yJvUiNhNJnXEF2AZrecOY02LpfJVi0lSKM1eqZSqFm1noAYS5Tw9DGjkbjWfeRYRmbHQ6BY3msAZIOqENDFvl8Tz0g8Ks+GOZxvbgEHcVp0YMSB7VuBQl+NgBC3GPXWjOnHZ9TBdmCP/zbs6nXnkAFjzI2rsda2/a/gOihbpCBYrJIBLCqC5MvuO5xNt14nyQxxwXPklGpbwVngdjoAfm+JpoSGZly7m3QTl81idm0ycHlJQQYXttjuCMEPtinDYyh1TI5jeGdE5JMIGLL30b/1SxqgKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:19::6) by ZQ0PR01MB1013.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.47; Thu, 29 Feb
 2024 07:30:20 +0000
Received: from ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn
 ([fe80::2f41:68f:6f07:6c8b]) by ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn
 ([fe80::2f41:68f:6f07:6c8b%4]) with mapi id 15.20.7316.039; Thu, 29 Feb 2024
 07:30:20 +0000
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
	Dave Jiang <dave.jiang@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>,
	Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: [PATCH v7 3/4] docs: perf: Add description for StarFive's StarLink PMU
Date: Thu, 29 Feb 2024 15:27:19 +0800
Message-ID: <20240229072720.3987876-4-jisheng.teoh@starfivetech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229072720.3987876-1-jisheng.teoh@starfivetech.com>
References: <20240229072720.3987876-1-jisheng.teoh@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0026.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::21) To ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:19::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB1160:EE_|ZQ0PR01MB1013:EE_
X-MS-Office365-Filtering-Correlation-Id: fc89ab16-21ce-401f-983c-08dc38f84883
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1v5qkKOkMb36mtE/vm7lS3W21DFGu/RLS+UplzXvc59EoeQ09nOyFhX81goiwMCGfar3Z7JsTuC9qZX+d1qAilxVpS24aWKuPwqt0X7cO85H6gGHzrGOR4QFsvlUgy04jVmvSHfSeGEwjspmVwagRmNyx8QXoyNNwyWeSzhebyX5l+hsJdjo651dZdrHCUkchD1J3xvcMsU0L3nAh/3fV9et3w2HPEXYwfp3LoWOZn6ELzmmvRpM1SMfKqcNwEUAwmImQ2D0y/Y+vn8YVtlSznnRaTD2OmohKZMWwc2/5TE1kzJGL4wePWQp3iVlr+xbSIpu95bK5ggRjglQcvKR0QdGMS7X6Y70vSFmjlq3WRO7zLco5AGKaKoZs62amEK6DriaQhELaOqGCwGxk9b2GmTINp5W0U1lG7AM2274O5hznPiiJBkiktIzXsRGiC7n81WzRQn6onVm0JSUjGgVpS7PtwNpgjzxmsMw3g5TEuUa2CeqUQwipa+rbJOEeMAvLqB/3zLNi9SbBXXrdZeO6G956lsfNTi05T73hcYYfveDh1iAkBlsnv4im2j0vCz0McK1cLqECP9lw8qnBEYzoUwXLjuaK51vo2zi7oK2Df0gAD3YUGjqQVt1OuF/BWiXlab9/3rD4i4q4fH2PQKLXQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+xDynYGYR/OfggKTHSufGmbuNx8bFRlfaeey/zVXJGBRlY7Xaqtx9XMUw0Uq?=
 =?us-ascii?Q?jyIrjetqkCfKo/LcLZROuTKiaMuHZdLIL0GefwHNg4Q/PpUdwwrNYCxZkFa0?=
 =?us-ascii?Q?9KzwTZ1rxcwfzsrJAvp7efN4PxJ2pwdbxDcc49I0NtWaeG//F3piIaBnsLNx?=
 =?us-ascii?Q?DEmoZCou1E/0eXxvMlJB3CtPj6cILlqzgZVcoCmVEz6I5+TcLFIZBUaH1+XR?=
 =?us-ascii?Q?BYBm/Mo5UyxE9xQ8evjeglaMsQYmwgiOcW2hRUK/xMtKGF/kX+XkWaMTXagG?=
 =?us-ascii?Q?zltBP4Zh6NdbfmjrjHXvtHjCh0GNNH4olhNA9RIuEKxa3XNWpe9T7YydrPjL?=
 =?us-ascii?Q?SArDujSA3ow+p84aJ2dVzL37PJgZhe8M9YtMIx5/M3onp8gYZMHW3Na3Whab?=
 =?us-ascii?Q?01PYjfrb2d41voY2TDuoPzSrsdFDjuYzvtXQIe3SOmWjAa0IpLJ2YNoEnrWR?=
 =?us-ascii?Q?Pj2TNW5ckvFSl7tCNs7AKcLWIWkKVABDPwTXFHUvXBZo7+MiLiz3wtFjQXhf?=
 =?us-ascii?Q?gkNrDdlDQHuZIDvxvR07WqtJcvNgXkiO05gxfib5y9PBGNKWX5JFX2lI5DxL?=
 =?us-ascii?Q?e7aMlih24o/VAT9Sg3PqEDf8ZuCrTbGvTlPmmvLeiHTKFQUc0y62Vjlziejt?=
 =?us-ascii?Q?I0eY8xExR1zP5au2qsK4gE7b+etB5PA1zLoVizcHkMGgdz3iP7dK6uLi5HcR?=
 =?us-ascii?Q?1SEw7DZyYONJ7PZUUdDuiZ4WZcOBaQ/+28Zeo9Ymd6qmuoDhdTSH0aeaPGPT?=
 =?us-ascii?Q?21A++5CQ2+e6uytlc0kXRCdg1y8bOBSltPvB+P7/7OpSjp1U/Ez+yGSIGKBX?=
 =?us-ascii?Q?rFDTUvALZ6yp/kfcgc4hovq8/dbLAlqkdQ310Hr1V/ECD3gAouJzAA1Dd8nz?=
 =?us-ascii?Q?/n1qdCY4H9KYHujkbXTKhdldYZnC5qimLM0FkAqBQqkkf0JOOcQJ9ejEOEdm?=
 =?us-ascii?Q?aXunvtrj2lpzAppJ/4hlVnCz0R5xDKtu1RJtBp6QQGGsI13QCBwYRMpNvf4A?=
 =?us-ascii?Q?4aKkpNREOhOI4wxZxJcvgV0ZgTeifitmZizauIW2Py3DztFGf3ntLltKouj4?=
 =?us-ascii?Q?dIqjZsftFeoPvPoAJIhv0awQ1a8p06npUcr3yJdFrBk9iedVwy+Rvhc8sbVL?=
 =?us-ascii?Q?UKqPQhxDbBxgDwzUtv0NXbvZLb5s4cwqZVnucH7PZw72nchIFbV6OERjskM7?=
 =?us-ascii?Q?uS1ctppS7wHY+AOmfRFgExKXWrnwWap34xiKAQMp8f5slGHRlhwyIzhkL3Pb?=
 =?us-ascii?Q?6NHahpopvJXLn1mB7mQ6jW8vPhE4waWylUzppr3q84KX4PYZRKlnZhaIFwR+?=
 =?us-ascii?Q?T4RtK+svXmxCiMbU7U7FEkDZFOo7Qk0H7EHHfr3l978DlU3YRrp30PtCtWhW?=
 =?us-ascii?Q?1bTMV/n5dsSvpVMWDcDsSOYQ94kuh6VxXBBbGtw0afwOBULtYf4quZWXLaAg?=
 =?us-ascii?Q?KTjS9Uw482HS7ojMCLh299dytq4CgwS3W2gpMRZxiiTlFa4GEofpwRAXwif4?=
 =?us-ascii?Q?EWrGq0C1UL9cROEErwzZhbg1FTKtkvbim5aBOHIa+KPQagV2KGBEFF34y7FB?=
 =?us-ascii?Q?5ksJ53D/85I+wAHnr/6NhIXcyHWG6gJr3mLpjRdfmm4GGDdmE5vSs9PbZd1D?=
 =?us-ascii?Q?Ww=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc89ab16-21ce-401f-983c-08dc38f84883
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 07:30:20.1527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6aV9pWcktfKvOp6rwP3J685BjtpAjjIIwprK2v9fUJLjxfn2blplMm6koLkqGfwmyStfXFv2NpCsMBCRV71h/W0eF5T7OthsrGxJhEI0WvY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1013

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



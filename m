Return-Path: <linux-kernel+bounces-19041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84376826721
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 02:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C69A1C21779
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 01:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFC379DF;
	Mon,  8 Jan 2024 01:32:03 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2054.outbound.protection.partner.outlook.cn [139.219.146.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968EB6119;
	Mon,  8 Jan 2024 01:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k3VhsiNcFNUCHe3T8PrZGJLbHdzUjWMGDZ6LVm6fSzNtYSuKs36uhcLR6AUaGTegk2lSWlHBa9+VY7w+68YgPtHssz0gws2YaihkztOpQQT06Yc1F6d9zox4+nkDFdIKYrbo6PmTMh0fier76mX9e4DzBryeNKkb1d4207au+wFxxKAh2L7zuyakKLbWbtBow6YJpXFlWxpBkqJWHljlbYAeXlbBnwM9ZIHunmbeoIypid/KQjP3DYvPlabluypl1+sswNy64AW/sgMmKh35B7OvCs6whgqOiHGCG+qOYBZSFwN9m8JKBsN/MSbGtRn38iTaOYvjCk0oR+5l9JjLuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZHHneR8AyWkEqGP1wSCsTElF3KwuL8QQUAKM8OrLWY=;
 b=K95bEforwOl5JbtHPG60HkWpdqc5F0OzysUocY743qbb3dyU6JV4s5+oIN9VfWnbRF9yk30l9oemyO/N85pOgvkJpp+ApbBy8aurwgMeceuXgZ1VdIE6uyiuGZd6yeycEOCLZC1NYj88SfRFGMgxAmrV6PlNjASM0EzY7EhDNRhWdwC7UO2elrNiWdvUxbD3QCUcG/VWENWqhrFKQtVnRncVWZalbWWBlhhkSG47EKEB2iol2Fl66SpVBuTpgqzZCluhcooUFEcMls2CGXbL4agJ5vp1B0rkM+PwUOckUOivk16rBJIAz78VxeNPZd20Rn719jTVov5wJUJGDSb63w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:19::6) by ZQ0PR01MB1032.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.21; Sun, 7 Jan
 2024 23:57:52 +0000
Received: from ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn
 ([fe80::1dbb:b090:7d89:4e22]) by
 ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn ([fe80::1dbb:b090:7d89:4e22%4])
 with mapi id 15.20.7135.032; Sun, 7 Jan 2024 23:57:52 +0000
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
Subject: [PATCH v5 RESEND 3/3] docs: perf: Add description for StarFive's StarLink PMU
Date: Mon,  8 Jan 2024 07:56:57 +0800
Message-ID: <20240107235657.2372910-4-jisheng.teoh@starfivetech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240107235657.2372910-1-jisheng.teoh@starfivetech.com>
References: <20240107235657.2372910-1-jisheng.teoh@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0015.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:5::9) To ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:19::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB1160:EE_|ZQ0PR01MB1032:EE_
X-MS-Office365-Filtering-Correlation-Id: 4588136e-4952-4ece-6589-08dc0fdc757a
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cIFc1OMkY703rwGmlosPUeEbZeHeFWY/W6ykrm2lw87icUvgPxNrhYczZQsvAGxBi3foLe2LzMeF2zpYnvDX3f5RAYvv/U0U0UkU/GS/VK2kITiUCQMLWXIIydc3+vz9L1QmBcHOSdjMOfBPcSKm5WJLHVXoknu67D2fcDM9+gjPvqP0lBTFLjn2QxBcYR+PQx5dwPgUClRqTC62vwCFiuFHGpxJSdEtmrS5a2JrfLiQ+8O3weVljiwOxLqvdyZkjWuXOL1TyPhKECV9MSb5Rb84Zpya6Y4+MI/1/RrtK7YBi0VmQCXHpChBeRWYVP4wvRAWxOdOjGbDVh093Lk6Xwc2df5P8HiB3BiXvecITIXaZod8WklXDDBJZ4aTOgk+vfsjjG0yUUAc5hhDPkQDCTdeUKCd0+oitpf201S4MSYCawRlh/LwkLB33LwEF6VBghas8ccO05pvJoOHJToClBo1820jTWjbOOKDyMRWoVz4Ygt5I9e1CGMbqVrleG8HAlq3cTtCc5oe1XKxS1JGZXN8qzgvkLrsHvAby775YNS3cHXRFu1TZPMBkRVnwiizKqS3mq/BV5I7OKh9mq8rHg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(346002)(39830400003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(36756003)(38100700002)(921011)(38350700005)(86362001)(83380400001)(508600001)(41320700001)(8676002)(4326008)(1076003)(66946007)(66556008)(40180700001)(110136005)(2616005)(26005)(8936002)(40160700002)(54906003)(52116002)(66476007)(7416002)(5660300002)(41300700001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1O69EnH3fObF/HtHUcCTpGLeMOGIdNy464qzETTj3delJrkpXPRLEADVyjEV?=
 =?us-ascii?Q?KTHchSFg4c3QdzeOzCVADroMozCHYMBInj92DAc3PhuaS7Deo482rtxqW5U9?=
 =?us-ascii?Q?w0jja8NKtFJ0+lrBbvhcRBKWqxyhto5TxdiVLdddJepOYOcTowY9d61+yc0S?=
 =?us-ascii?Q?N3ifvOfBl5ATRISu07S7qfk5w98uSm9s4zGe0cE+x/86a8zjsMKtP77McZeq?=
 =?us-ascii?Q?VZ++jWCRIGtM17uFO+HZ2Q+FqNR06H4TIMmkCpU8NwaJGcAr7QfB9obXL9EG?=
 =?us-ascii?Q?r4JgPcJghurmrwY9oS9vA7Pl+FuAC7xS+DD5dRuJBphe092F3CNXndSI/iJp?=
 =?us-ascii?Q?tyjnTWazoPdfSXe6w+f0ji13iijmUBSxK+Ve9iIKReMLQUzlOVUdBt6SOnHi?=
 =?us-ascii?Q?X7mGp5L3dObz9Ek4qAJOPKtoo1fkscZMbTWohbvYU927bbEm1XG/WMCkcJu4?=
 =?us-ascii?Q?3bz2fywTibY9rk4RZBMxo+sp1En+gPbefEUFSQKX83DKyv+M02iVq0j+KjUl?=
 =?us-ascii?Q?FBvpcMWPL5h+PhLM5Y0eAsW5S+lmvqVSLKdjOrpYygZlXy0bzISjYa4nga/4?=
 =?us-ascii?Q?+kPo5qulV2jE+JWCga3Kfyv58lFq470gtNU4PjhmO9UfvQg3fyIhMQCYBG6R?=
 =?us-ascii?Q?+dzBGN5fgXYnnZEh+ODXa3Uy5F9uAyCeZ4feJGkIWr+hdW7T7i+yHT66sH74?=
 =?us-ascii?Q?Dd3K3MbUZhHuxk25rsHZqQJb6h6LbFisDWeUc+HriCfZYApj3p6An3bgn7Rg?=
 =?us-ascii?Q?vtKBZ+roPcN7dDw2MOqBC8lyRy1mf4ns5DLhwi3fp0AUVEWYQuw1wuM0bw5p?=
 =?us-ascii?Q?jJ604+Q7bR31fZ1QtxVn60etdzi5KykuDgj+9wN7WSRer9lOiFGd+iJT8zpA?=
 =?us-ascii?Q?M/e5W+y9x2Z7DUguc884TxQX8gAKT8Hv9zH826AV5SA3Oec5eMtTMQiTvJ83?=
 =?us-ascii?Q?NflabtOUkRlIkgeoTjjA5vBIt/5HWL8KHSw5tSalQVjDd6buh96kxGsH/tXt?=
 =?us-ascii?Q?Jjfr7SMQCPR2GCVxrt8KUgPnMnxZ8gXEJ6oIXpbS8R8hxBgiajuI6es8iMDh?=
 =?us-ascii?Q?kUHXFuZjtsg/eh7rjBBxez9GnNLwvXk0+5vFLEXgmW4P6NZDOb/0B8P5GJQh?=
 =?us-ascii?Q?HSv8CyKNJ4TjqkyGbjvN498hgJY9YhpwpzYap+q9j5Oa6kv3Z2pdQhfuSOTP?=
 =?us-ascii?Q?mZsjfUDuzXnzeyK6qaHNzz4R86nrRLpeh/4KaTxVDLdBu+e78ni+nV4nDa+v?=
 =?us-ascii?Q?CSpBLI3RbROZU0HfYw2x5J9zCispgw5ksbYQfN1AofdmYG3tB7QTWHTEaEE9?=
 =?us-ascii?Q?2yQ7mCAQrqo7QMWx4a38R47xEwvhixSCQ6IqIm/S3C3/KYD1arW+yjDLTsKk?=
 =?us-ascii?Q?jLJmgCDX2sQNdOQiRoJw0IRpsFXaAZ514bnF/8UrqCJQ2v4xunbrNlCVYzaR?=
 =?us-ascii?Q?Rf+uazM9igPcZykQPKCBCKLgrR1RTirFjySgq2+zGaOjtvmLhnMjXsRBpC32?=
 =?us-ascii?Q?aKtqpqv3xqH/NbNxSenhtZ+t1jvUsBaZIx120ahSl/xiwnbrRfw6HttcYqkF?=
 =?us-ascii?Q?Rn7xHv7fvSxoFY10T5n1OY1O8K4VkFydJ6epI+gjRPETQshPFAOm+pKCYwWF?=
 =?us-ascii?Q?RQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4588136e-4952-4ece-6589-08dc0fdc757a
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2024 23:57:51.9953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ovtr2P7ECRqwaYOzbsOzFmgxamZju67aJituGtTz9cXuKHiq4/4waum4gwaMR5PBMgmTGrOwTPMJh3XjcZAeuTP0CL4e2uP/O9dgjve5ME=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1032

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
2.25.1



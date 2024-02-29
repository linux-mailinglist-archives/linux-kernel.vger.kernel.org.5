Return-Path: <linux-kernel+bounces-86243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CEF86C2B8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B8991C21D18
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 07:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2030481DF;
	Thu, 29 Feb 2024 07:45:34 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2116.outbound.protection.partner.outlook.cn [139.219.146.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232C145955;
	Thu, 29 Feb 2024 07:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709192734; cv=fail; b=ZIItPnB2mmcV7MUCrZZS+drkb9Fcjo+SDdHhNoW0bxDmEgDcNZJTPY1ntCAZR4HNPkN8jJcgMBtLQNNmduPvMG8wL6kETriKYK6o+GaHh+uwY2HLUWc6Vy9Tg0WaMzQ3BNENjUZBjivano6WKxULkfeoZI9oq9DOWCu4uw2dzjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709192734; c=relaxed/simple;
	bh=kfOgi4JGeCW0woisOvhN74rXTb6WJEURkD3k9ZKZimw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Buymv/5AVDP/nkFy45Toa1hRUDohYQtRdZVF6JYqMZ8g8J/6LfkIf0WaSdQt3bDjcUgkiWHYQx+2R1KjkOZoCZfGiLQq08ey5IVWNV0uu67cPOSKRdgwO9bZ4AvRP1ElXmcPCFkLiYSPp2GVc037+WBH3c6dxqa7urzqyreQtQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KRzEB5XoTWNAnzbe5VpmfjuWdP+iqFwAwZCbDIqT1y4Wm1tWcC33XTBPdOQWC1pFeXobG9nxJx07F7AfO2e0VwwS4fF997xehW6NIeNbHBwut6Ti4fpAl04Sk+GTbuT3QnWXFXa93GPZmnh8CqCcKaOKYOzU8+73lJOyWY3GeVddwBMd6EBYOka7Eevi5G12RzaG4ZOt4dezox1n+lvaI7LUAagcjJ/fcy4UY9/fxEShrMfiZlq9z1/JDAAWodVZP87sfJp+ALB7XUwwGJ8Gv2wVgeu1RdZvVM+GxxUBPICrFoEGRSxwjz259Ig2IMRk5RiAfHGkshW9SfWmKTkdbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zp8FbaXxs9K4B9KJkviYLlBYUubtPkGmpyn2WDeAIzc=;
 b=FNq3pbD+YF/eiZLk5k3HYR72pyQimOpGYCMLrK+a4yHGLZCV2qNrts4oMqI+BVJuoCesnDtViL9xG5Fw0REGZVlS/bnRJNI8BQPCp6IDN4UwJN9mZLSehMmZEas/V2UUfmxxTKh5DYSVubpp1beqwvl2q5PZmagMc7ALieFJmQheYssgdCFZqq4KZhmmEZ9mdM/faSqjGwJRpkgEDMwvRto8PYkReBXUPFUYK9M5VNOJi44MewJx4QXtwVnWaGLiJnbyjSmdFucI5RivnOhXnoNxf0oFGuWBSXKD9v047PtNgnP8XJceY2dDZHTVNHRkEPTxqTqRqefv1SfxYTe+5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:19::6) by ZQ0PR01MB1013.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.47; Thu, 29 Feb
 2024 07:30:09 +0000
Received: from ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn
 ([fe80::2f41:68f:6f07:6c8b]) by ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn
 ([fe80::2f41:68f:6f07:6c8b%4]) with mapi id 15.20.7316.039; Thu, 29 Feb 2024
 07:30:09 +0000
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
Subject: [PATCH v7 0/4] StarFive's StarLink PMU Support
Date: Thu, 29 Feb 2024 15:27:16 +0800
Message-ID: <20240229072720.3987876-1-jisheng.teoh@starfivetech.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-Office365-Filtering-Correlation-Id: 2d73a6fa-d306-4377-7210-08dc38f84248
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nvvQOvsLVjYycXbwWDcCLx4NUzespTKXZ6sxUly4GPEmtLpONMFowyuCRmzLjzoZeSeZmWaxXfgCxR8VB+6Lx+lBx9rsSojK2bCqv9UYkJYst4Pu+Qefj90yYYD4+g46gnsbH2U2ASg2zmxyDXFUZpTu+xllOcRxFonm2hW3o6JJqPvrDTBpAzlxuA3QaChxOEalF4UYuFroKtzuiiL0jg+fNRjcCKRUyEaHriJiGw/3RFOQVWzite9Uc3ghCl+wlli5HXIeo1kQ8GA7Uy8yaovbF+NkdJtukMse/L8oy8VOElHa0UNBPlpxEfiGGr1UmJ2JH8DdeZ8BHwgriiLE3l1MIDG/D7hndrdaHghAsJA2DBixo7MFR230EAODgOaFU74JVwx90KOPAa2d9T8GIFgPCpXalOpE//x6pECV+XHTCvN+B4VqNVGN9ZDIo4TrqGHRIdXwADqQ9MY6KvqHSfoTAD8VKefVRA9WG/H6g9MUGfxVCcCWfu+FKWOegPr57Yl01ZBthN+oFUGZovDeF0qJNNcEwOCyTjFPzP9RiujHtJO8DxL7PUBTfIKD+UG0QJxndw0BvoQsUVG6COZDwhwxVSBF9SbFXmjEu0a8DG7aDp3ydkCIp4byGGSLwM/NmW6FY5G2V146HE0isrK23g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?noRj8JAsqdi8Og9m6OxD0NVNW7ntLOHtIHF51vD89BDQozV9rj/oRHvz3ENE?=
 =?us-ascii?Q?J1xrw4GRM0Hbb1tVuDG3j5FF/sYEeAg+uxA73UBdq4qgt/U6Ylkbfg3SZg7c?=
 =?us-ascii?Q?bMZ4QuBZ18Lh/AfyVkmjA21H7Z6oVE47JOupvIuUe/pm4KL4zlOOE68c1tem?=
 =?us-ascii?Q?s0EFuFX/Y06Hf9C5pv993Pe7LoeEKUYbTKEHItoyhESlkJIPSUySgO8NdSqT?=
 =?us-ascii?Q?dc2W4SYQE3R58eoqXVbKSAtJpPyZeiOoZcpao65t++ZoL52D0Qw3tq83Uc4W?=
 =?us-ascii?Q?JLpuc+IPHlownnYc28XJH/VjILuGPehHw5ITncCL1PZKWDOSonH//hinvQ2G?=
 =?us-ascii?Q?jbmRzHkFBuZglITL4jWQcYBKq88da08l+KY13BImnvHfMEmmHML6zNCHr1Py?=
 =?us-ascii?Q?md6hVs0dKzFkJB9obCABrCy+i12L6sWNiSLKbfU/bVFkdZdevSwVgDGpGiiw?=
 =?us-ascii?Q?dgvwxfXOZWlL0EaPczJEyA3ucAVy366cN7sXv/6xtb/rR5O5Wft85jH6jSat?=
 =?us-ascii?Q?oHQOm5E6DpRvZZc/o/QkZGsVz+VZpcFarIlXSMWFAHQSsqqjdDzw1F7NRwfQ?=
 =?us-ascii?Q?BY8n5Yp2U8sax/t6xUtQCjYn53yL1naM9A6HqwD70Jz4ydDL0LRa+Nf9sUGO?=
 =?us-ascii?Q?NI8mVe0iUCH0Lgz+rqs6wtc291KXAuQld0XVMc5XXiZ/TFDu4XI9UJncYgpF?=
 =?us-ascii?Q?YiNjjL2EJHLmRZIwPbvnbFaxMTQvXIagsb+WYLr9DN0TPP9To1hLESK7EagT?=
 =?us-ascii?Q?SkA5I88IyEobQF/a9wXOzf8geYyeEXnN+9uDqEYgtm+bdSA7MMrjwCVZ0YII?=
 =?us-ascii?Q?PyKQefRnbIiQOWIvpqsvpegxc2zS00nRMmWbK4jKAMF5foBoZf/fEthzXoYR?=
 =?us-ascii?Q?YAE6trtBwnW612UHt8G+jjU4nZgS7atfdodEUdowCpbWfH6xlm6GDukCfKT7?=
 =?us-ascii?Q?baBs2SeZ30Ng6+C6EKYhV2Ul8evQaQkH6OLHoqB3muhhbcNHfi3DVeyuxq+f?=
 =?us-ascii?Q?C9ZkzrrtCeyMGyDiBL9Qi8HEG6l3XDNSTQDOAke2nt4EJ0G4zb7NrpqM4+kA?=
 =?us-ascii?Q?SofjApN9JkHWFec5Uh/Os7LPKrnVj871lRd0H/M4Er++flirbKTFAXKWrQSf?=
 =?us-ascii?Q?gRR2jyv73C2fmsHrcjF5hGyhOkqH6l1V8OpX823B19W8hyHkebHs7gkhhIPC?=
 =?us-ascii?Q?Mn257WDBFv9w952Yf9JB53QhvoGN4wSRN+dD5DIQi0hmcmAtztjEHbma0+s3?=
 =?us-ascii?Q?jzwLbv70nXbOrcE9Zp7oErmxrLNLdwSzrqG0rT4HlA4MwCl5jN34lFoxNqvv?=
 =?us-ascii?Q?ZQ6Jezbygqwa7hcw98A71OrlsohsT/m6btbEqloo+sp4Y9eqVunLUm5ci2rl?=
 =?us-ascii?Q?NP4LoKWDTHtSSQy9qfh99kYRLZ+EJ8cpVi9fnRd4yqGBpvAGp/p1FA8B440U?=
 =?us-ascii?Q?QcKOUEeCZIJX1QceqY5B8oUVpYHbcdtfVIaiJBiy2xAaWB/RkD6q5jxsqima?=
 =?us-ascii?Q?o+M0JrsnW1+Vf9nrv6k9Fd4L1qKDriJb0GXhRQox1eTZAXJySoW3NDHp6bhs?=
 =?us-ascii?Q?inS8J4MfwLv9nP+fFd2jTcDM4/idDMiwDP8c+9dqgFDPJCJV1Ij9C3K89p3W?=
 =?us-ascii?Q?kw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d73a6fa-d306-4377-7210-08dc38f84248
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 07:30:09.6949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UFZDv/ugyGVPo9+6YRZ0Ca3pV7GEToAhUYOU6f46FpLaOXZGq9NeJbINOfCKeHGJOOksQ5Yynoeg87V7JqHe+V//vOqM68a+idY5pYOmrrY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1013

Changes since v6:
- Address comments from Will
  - Add "COMPILE_TEST" to STARFIVE_STARLINK_PMU Kconfig dependency.
  - Fix incorrect bitmask with BIT_ULL().
  - Drop kfree() which is not needed in devm_kzalloc() allocation.

Changes since v5:
- Add entry to MAINTAINERS and mark the driver as "Maintained".

Changes since v4:
- Add Reviewed-by tag from Conor to dt-bindings.
- Add Documentation/admin-guide/perf/starfive_starlink_pmu.rst.
- Rework starfive_starlink_pmu.c based on Jonathan's comment.
  - Use <linux/mod_devicetable.h> in place of <linux/of_device.h>.
  - Prefix CYCLES to STARLINK_CYCLES.
  - Fixup error handling, remove unnecessary comma after NULL and
    comments.

Changes since v3:
- Change dt-bindings filename along with the compatible field to
   "starfive,jh8100-starlink-pmu" with SOC specific naming
   convention.
- Drop unused label defined in examples section in dt-bindings.
- Update compatible field in starfive_starlink_pmu.c to the
  aforementioned.

Changes since v2:
- Change compatible field from generic "starfive,starlink-pmu"
   to "starfive,starlink-500-pmu" with specific IP versioning
   in bindings and driver.
- Fix warning '-Wmissing-prototypes' reported by kernel test robot,
   by appending static to starlink_pmu_set_event_period() in
   starfive_starlink_pmu.c.

Changes since v1:
- Change 'depends on SOC_STARFIVE' to 'depends on ARCH_STARFIVE'
   in Kconfig

----

This patch series adds support for StarFive's StarLink Performance
Monitor Unit(PMU).
StarFive's StarLink PMU integrates one or more CPU cores with
a shared L3 memory system. The PMU supports overflow interrupt,
up to 16 programmable 64bit event counters, and an independent
64bit cycle counter.
StarLink PMU is accessed via MMIO.

Example Perf stat output:
[root@user]# perf stat -a -e /starfive_starlink_pmu/cycles/ \
        -e /starfive_starlink_pmu/read_miss/ \
        -e /starfive_starlink_pmu/read_hit/ \
        -e /starfive_starlink_pmu/release_request/  \
        -e /starfive_starlink_pmu/write_hit/ \
        -e /starfive_starlink_pmu/write_miss/ \
        -e /starfive_starlink_pmu/write_request/ \
        -e /starfive_starlink_pmu/writeback/ \
        -e /starfive_starlink_pmu/read_request/ \
        -- openssl speed rsa2048
Doing 2048 bits private rsa's for 10s: 5 2048 bits private RSA's in
2.84s
Doing 2048 bits public rsa's for 10s: 169 2048 bits public RSA's in
2.42s
version: 3.0.11
built on: Tue Sep 19 13:02:31 2023 UTC
options: bn(64,64)
CPUINFO: N/A
                  sign    verify    sign/s verify/s
rsa 2048 bits 0.568000s 0.014320s      1.8     69.8
/////////
 Performance counter stats for 'system wide':

         649991998      starfive_starlink_pmu/cycles/
           1009690      starfive_starlink_pmu/read_miss/
           1079750      starfive_starlink_pmu/read_hit/
           2089405      starfive_starlink_pmu/release_request/
               129      starfive_starlink_pmu/write_hit/
                70      starfive_starlink_pmu/write_miss/
               194      starfive_starlink_pmu/write_request/
            150080      starfive_starlink_pmu/writeback/
           2089423      starfive_starlink_pmu/read_request/

      27.062755678 seconds time elapsed

Ji Sheng Teoh (4):
  perf: starfive: Add StarLink PMU support
  dt-bindings: perf: starfive: Add JH8100 StarLink PMU
  docs: perf: Add description for StarFive's StarLink PMU
  MAINTAINERS: Add entry for StarFive StarLink PMU

 Documentation/admin-guide/perf/index.rst      |   1 +
 .../perf/starfive_starlink_pmu.rst            |  46 ++
 .../perf/starfive,jh8100-starlink-pmu.yaml    |  46 ++
 MAINTAINERS                                   |   7 +
 drivers/perf/Kconfig                          |   9 +
 drivers/perf/Makefile                         |   1 +
 drivers/perf/starfive_starlink_pmu.c          | 642 ++++++++++++++++++
 7 files changed, 752 insertions(+)
 create mode 100644 Documentation/admin-guide/perf/starfive_starlink_pmu.rst
 create mode 100644 Documentation/devicetree/bindings/perf/starfive,jh8100-starlink-pmu.yaml
 create mode 100644 drivers/perf/starfive_starlink_pmu.c

-- 
2.43.0



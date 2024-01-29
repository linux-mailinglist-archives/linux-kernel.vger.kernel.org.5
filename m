Return-Path: <linux-kernel+bounces-42509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A07840262
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF1A8B21B45
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C7B56449;
	Mon, 29 Jan 2024 10:07:06 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2078.outbound.protection.partner.outlook.cn [139.219.17.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D01655E52;
	Mon, 29 Jan 2024 10:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706522825; cv=fail; b=RNWt+OP1ptiAslPVRFzeruipIMp+EgrTrb884JBg8rG9zx+5ZMuSG4jwq6j5n8BHITKHzhBP7sS4IjzfJPWmirLGwgACpH8Xv9HlXFrYSxqL+DzpCwjkIlhepHy5YfOnC/syK5nkAjrQ0G7+h4Qx67s5/HXwxRvu1BJ11wws3yQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706522825; c=relaxed/simple;
	bh=qHZ4k68QwDxbeugZFjfXcaJZ8QbjqmvVRqfUOf02drs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=OwA9XP6oDI3MaqtUP3qYw9Tt0YOCDAqQtgOB3OmdxOraCnT7//5ScJ51vbRNa417wrO7Zpy+ttjr1hHeueh0Y6BBZUcjMVIxh007eEqAiH85UvpxSnCN8L7pqJCBwVqOhJ5FiB+6RMaWnCgFjzkW/HQXYJ0smUX5nBHGSAp9xnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y/04ABzUJp4RyGEBf7R/Iehxqt1tDSEV8gaCcEgre9kXQm+8ne94Z4lLibBW/WJjV0vEGzas37DCzEZlldjNRuIIBHH2plv1dChkODwuVd4SelDOtglejJrL1JLq7nfdIZ/YPE4gSECe9BF4dGwpyQF8VnaG/U7pe1/Q5sbkyHtM5XwYuFhN6ssWcJK+2gYXmZVFsM54GmS9qcwlQaFfxghWEIT9Zfp75keoBmCBUMsxC9RjqJSOxBpijB16XX6WFVFN2sE0nIRAWTZNSkbIEZOEcvrXROkbI1dxsiX6Jj80z5pnSTrSXk3kksb7fA/fT2t05AlXL6rovPg2BDagjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7gsq/fTh85hPUpqQokgxn7fOGa6u54SKDSjz6iKGcGI=;
 b=l9Zp6xJlLF/owYq2gRAiKnpU7i+FivEY41vD9kDrfPLwIIopsId8vrQySPhZ8tkKGe8ra9/D00ch65gDtX4OluTDoZVyfUElBBEwIeefUaTdUZr6g5I4r/Rd8u7TqYzax/gDiY4iy7f4K7+zjSslPHSWMY56LkojavWeYXEJDVdizs2xy8yPqG+hEyBopa97K1tInUsHaUe2jGK1Fk0CAbh0Ki74N6DN5C5rsdGACoiZF7p93ownk4S6TgkXRL7Jmf+2gU2LXTAyXh/AL8J1ppIG46qMyvSTs6DLUmN0tLpxISBs0IwcEDqxrFpy9yiybpc1mEDDeARa6SUs1J/g5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:19::6) by ZQ0PR01MB1016.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:c::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.28; Mon, 29 Jan
 2024 09:52:20 +0000
Received: from ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn
 ([fe80::1dbb:b090:7d89:4e22]) by
 ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn ([fe80::1dbb:b090:7d89:4e22%4])
 with mapi id 15.20.7228.028; Mon, 29 Jan 2024 09:52:20 +0000
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
Subject: [PATCH v6 0/4] StarFive's StarLink PMU Support
Date: Mon, 29 Jan 2024 17:51:37 +0800
Message-ID: <20240129095141.3262366-1-jisheng.teoh@starfivetech.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB1160:EE_|ZQ0PR01MB1016:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d970747-1289-4ba1-5177-08dc20affc14
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EohCljLX9xXSZmHwbi916HV1UYwCv/Q/hu7zQXPOqPm4jqdXvdormCavnF1leWxWoUxEaMJmrwyfx/RxIuVjNXhs8AjaOk4VitVYy0xqqoP1ziaFfUVSd9om148b413wwe+4KjfmSoemrTcvvONhCnlLqxPTfG9HtgkATVo8GsrUkBAZ0Z2KsSXqSEPMkW6J8aRLKxHOZbcEypgmZ364LJjeEavQ0PS+hyEU1wBUQNDMSiG+/jMifS9Uq1opRd2Nn9qM+aK97lvoaR3KyZCHEdkN5R5tZjmhqsRnoSSTMiLJ+klyyOJ3Iu7Kw+7e2FkUYX6VYYEsrRAia7P7/h303dM+hqzFzlSTOukdLAHcfA5FRak+jszCtozQBnGE3GPn5qj4CKkJsk52IqmONoVeOdcnlKIexC2Hu46ws2yoDv0y3iG65k3P6vcFhaoUo/zL1yEb0C74pYM0cCHVYhYpERnMN0RvCZWMUmN+lcsRT9vFD0nKEGOcYq1lUcnZ3LP7rbE02NxP3/7xGOXZvakYciT3QZG75k8XROHVo3TrtOJta3EyZUaFY3zIwYG3edaoxKAzUhuVFkPoBK+yq/jiZLLFAxxd/0PyCsN9VfKX3qT9H20VMIKY+25L7DmYdegZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(136003)(366004)(346002)(396003)(230173577357003)(230922051799003)(230273577357003)(186009)(64100799003)(451199024)(1800799012)(36756003)(41320700001)(8676002)(8936002)(4326008)(2906002)(7416002)(5660300002)(66556008)(110136005)(86362001)(66946007)(66476007)(54906003)(38350700005)(40160700002)(40180700001)(38100700002)(52116002)(508600001)(6666004)(83380400001)(2616005)(1076003)(26005)(41300700001)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WsmeOPTWdTbAmU+EWEp3SbLEpJwfLT4ZY8qj++nSWBoFvKB4Fhixt+7MkXaO?=
 =?us-ascii?Q?thCy0LXWPLVQ6nJxTfcpKBfKbJ04m707+mUq8C8by7lIikBfPVcCUkpRv/iP?=
 =?us-ascii?Q?CQV8pxvahU6DWvBesXwDEh1zifrmrO49wxQs8sypSnco5ZiWLS9wm0itsd3P?=
 =?us-ascii?Q?K16DICN0Q3wyjBD+AjgFA3rA2nY1xkQ91EUAEf3OUTRo27nS5N9T67ngYoCp?=
 =?us-ascii?Q?3m0YRPY0VL6UUTnMM4iRA00ueIYhY4pASC1Nt2pgYiHlAUGMwI0Kt6YE/D7V?=
 =?us-ascii?Q?FG3boPgeZyfaUXhtfoaINP+dsSO+mFrj99BDrXK7ivp47/5zCIdkcb6u4s8Y?=
 =?us-ascii?Q?/wek9Hx5UcDu+GeB/ASMRGC3ZLQH+oVPUyystDZ18khh54bfeySQCnlzDTDD?=
 =?us-ascii?Q?b1uxyWQLOiW63JslG89jAJ6Yq4e+mrr2/4cFwhs98AshrlAQoAV3JEnXVbnw?=
 =?us-ascii?Q?JuoBoNJeFZplMYWMpbF6OS4ShIXoz4p1fMEDiArUBztdAyb0FUM5m0Ni1sFu?=
 =?us-ascii?Q?6Ou0TBvWEJEEkMWvO4JZFiRW1Qx2kySd2YCOgMpccIRWNoc7jrMUtL9UL6dc?=
 =?us-ascii?Q?W08kJ2Pdia6zx9VRqvHoSmgFt6rZh8428JbD60E13GySEOi+M8NStto3sMuE?=
 =?us-ascii?Q?4QZJzhtzinhyfMfMMfthTswZuBHP7vqsl/sAsMOcZbdu6Jgte++GuDXnf+pi?=
 =?us-ascii?Q?GtXGPUc6kfRd2Vl2k5KLkZMKAwSKITNwTLUJyuDEMpwMMAa7B+XnYTY8DQvj?=
 =?us-ascii?Q?qNQntM8zu99tnW3gB9I3gejqiX54D2iRxJgFfEkVDJJzFK/Hw8YhgCNYBGR4?=
 =?us-ascii?Q?IiLLe/8TCp03xr/VdkBEOD4Ud6MTYn4jC1fS1ZHY/zwKiDs3xh8SHFdMWjPP?=
 =?us-ascii?Q?JimiDt8u2cKXaqsFVETPxIFX0lgEiBL81Jp2/vB4nzTho78Pj1eQ84xKzpTj?=
 =?us-ascii?Q?qzsF4LuMR4BRN0rRGww5vxdlWXopFmZ3a+xf8l/xsctOe0S7/Kqcjsh+FPAm?=
 =?us-ascii?Q?EDJ04PQJHrfnzxODnUB2twUssySgY6x6xTvi5e06qqGX3sPl+p7m+65pmQ1D?=
 =?us-ascii?Q?UBR1ZSaNHv5CQLCpo+yNJ+a+S1jh1kT8PYhmydAaUvwpEP1ctxInObt+vYUN?=
 =?us-ascii?Q?xABsu6Zli6NtuYuaMTRzIXhoPwPRSe+7m27ZRydOeJPWhha4xqnb/an2PWek?=
 =?us-ascii?Q?chPL3tBzbeFpOg94ZRSPCJPo8JqmJUSO2Bkkv6LxPhrza5ieycnZ/mVU3W27?=
 =?us-ascii?Q?0qM7fbWsL2MvXK3pbbCtGvUtzJkoUUa93p7uLCBbd5fvIilbxY14Jk0ejDXC?=
 =?us-ascii?Q?iFkVpp+12nxrVK1Vo38LxLx8xffoq1oXEQRNiX6dJfebjCbjP23Nlidgl0sq?=
 =?us-ascii?Q?fEFNkMZ1XMropID1O65qWApoINS35Sc5b5l9Nz7D8Y2r9LZ5w/+aL2ykFMxl?=
 =?us-ascii?Q?0x2lIUTD5TFex9zs9JaHNHkTnqjtYKQiHQ1OaWsk459ssvnHmG8xmk6akzxc?=
 =?us-ascii?Q?+13cMta0+NIQyvFydzVtIH6AZv+i05mI+yWBeuQjPHmTGjG+ZbEbMUXWCmcn?=
 =?us-ascii?Q?lacSnNCG248RYGg2V4BYLt7vkl05Wl+uN27Ba4cwjADuD2Hq5Pp98GZbYPwS?=
 =?us-ascii?Q?tA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d970747-1289-4ba1-5177-08dc20affc14
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 09:52:20.2243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6cMj7uMuCKGsG8jZAIE5QbSF0mOoo0BB2pIO9mu/ot92TzInkLCgLqT4vm2HEEaaHfR1nExl/tg6r90lzQRd0LTeFy4IQCYAv2KzsWK6SrU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1016

Changes since v5:
- Add entry to MAINTAINERS and mark the driver as "Maintained".

Changes since v4:
- Add Reviewed-by tag from Conor to dt-bindings.
- Add Documentation/admin-guide/perf/starfive_starlink_pmu.rst.
- Rework starfive_starlink_pmu.c based on Jonathan's comment.
  - Use <linux/mod_devicetable.h> in place of <linux/of_device.h>.
  - Prefix CYCLES to STARLINK_CYCLES.
  - Fixup error handling, remove unnecessary comma after NULL and comments.

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

This patch series adds support for StarFive's Starlink Performance
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
 drivers/perf/starfive_starlink_pmu.c          | 643 ++++++++++++++++++
 7 files changed, 753 insertions(+)
 create mode 100644 Documentation/admin-guide/perf/starfive_starlink_pmu.rst
 create mode 100644 Documentation/devicetree/bindings/perf/starfive,jh8100-starlink-pmu.yaml
 create mode 100644 drivers/perf/starfive_starlink_pmu.c

-- 
2.43.0



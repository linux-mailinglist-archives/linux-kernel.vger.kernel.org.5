Return-Path: <linux-kernel+bounces-22299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AAE8829BFA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00A71B24CA3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2714A98B;
	Wed, 10 Jan 2024 14:04:48 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2041.outbound.protection.partner.outlook.cn [139.219.146.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F1E487B3;
	Wed, 10 Jan 2024 14:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mPFtdHtu85TXRPew9cC9aUNzCFpOGBiusPRYv3tHPAMFAysIBjbscT/bbBPcGPKd2+L6FNHLLMHQct2DW4StHZO1du1b9iHHiWxFVPpwtHXovlSfM14d9SMTZlOQwqzY2DkprDv4yX2+CiDqk2k/ieZVS5ffc4l79UQ+lc1IxoMWwGqr4tHZtR13KTSr0UHWTvoDmOaq6oUHWNFgc7O0W07GNQs8dDEr+3Oej6VDDz2yZl7QBdJn6ZBhDuQsJDeHKHTgbV+othm4t4XEedE5gTwWFIHvY9jRU/fzPOaW2mdJNrGMdllgAyULGEaIGshH4PiUBKU1c90lq7vbLMrIgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YnTUXH+pUo6M0Q6oajT18IpPnYIwpsDx13xFbvE6VKA=;
 b=iAGFyMMzQ6qrnCnH3v12snGPF9CglFIarHvCo2WQiId4d2efKhZiaaN5Yb/MdW53Pt7FGdytLMpPQCcVspTXc/WMOwseF05ngkEjNsc8DQVtqTl7bv5qlMwjYusMYBaGbwi55E8uSxC8iKoCp2CeddWph/4YVqUQuug82FpLkJHGxV0KKZItI2zT/CJJS9xeXJEMfc6BViaZFsK6oS3WE7+fWNidVcubb+ej9144nFtQ/9taSFPMeItVQBx1w9j35v6BLGnfuKTHOZRPm3r2nDNs/0RFSZLhV+AV1UUUoKdID33sPVGQCOoeVCN0CHVIdUjGGJK4vW7n/wPjC0uwwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:f::16) by BJSPR01MB0865.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.33; Wed, 10 Jan
 2024 13:31:41 +0000
Received: from BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 ([fe80::3862:65b4:c857:c4a6]) by
 BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn ([fe80::3862:65b4:c857:c4a6%4])
 with mapi id 15.20.7135.033; Wed, 10 Jan 2024 13:31:41 +0000
From: Sia Jee Heng <jeeheng.sia@starfivetech.com>
To: kernel@esmil.dk,
	conor@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	p.zabel@pengutronix.de,
	emil.renner.berthing@canonical.com,
	hal.feng@starfivetech.com,
	xingyu.wu@starfivetech.com
Cc: linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	jeeheng.sia@starfivetech.com,
	leyfoon.tan@starfivetech.com
Subject: [RFC v3 00/16] Basic clock and reset support for StarFive JH8100 RISC-V SoC
Date: Wed, 10 Jan 2024 21:31:12 +0800
Message-Id: <20240110133128.286657-1-jeeheng.sia@starfivetech.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0067.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::34) To BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:f::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJSPR01MB0561:EE_|BJSPR01MB0865:EE_
X-MS-Office365-Filtering-Correlation-Id: 012f0b45-0173-4cdf-e4d1-08dc11e07af4
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6mA/GkTwgGtOI/evLr5vpJZ3RspM8yeiNy3dMHkNgL3pTBw4KkhQdKFditIx3bTabH1jSr5VSj5Woo6f3zfzze7VFGEezux8+uWGXaAAfR6067auZDPZLeNRa495AEzRaF3PPsdotQLbPyxHh8ckjj75D17BMt4GgKf8j1xol8U4A3ogXbu2MKtw7FbfFhwQdDzwKd+CcH2XDX1j7xpPjLOOtZ91JkPFJFnmHM1x4THJxeNz4hQ21L+P+27Gt+LqJmzKCo1gaCxTJdwwGpHVFsoYyMjNzhWPdBaSDsVO96lxeOhGhW+nLunqRdVBPpUTGKgbA3k4ghL44++LufmcmeQ4zVIYjxooOF8nUjDG0V61n6JAPoBa5Uzg2xkgvLYTFfEwgXHq7gD7ScmnyrexF7/kKGuD24DVcDlI7Stts6YD5JGIZ2Ay9/HM9Qqtm6pk1ecEMuDWo+rE8fB4/GZMDhX0y8BfTJ8yXfsYusA+ZVEt8quLFTF35HrBvTuvfjNALeUMzweLCQt0ZCGCzFUAOCL33hPsg23M3Wu24RJdYCbxVYzzHhESpExPlcYtomOzF2qpePYQMBJBG/b41YeFHQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39830400003)(346002)(366004)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(41320700001)(6666004)(966005)(508600001)(55236004)(52116002)(2616005)(107886003)(1076003)(26005)(38100700002)(40160700002)(38350700005)(921011)(86362001)(40180700001)(36756003)(41300700001)(4326008)(7416002)(83380400001)(5660300002)(2906002)(8936002)(8676002)(66946007)(66556008)(66476007)(6636002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Hd+jvhFnrXIRJW/YB1jvzMZAs2CQ9aa+jM9SBlRCLHekyJRknYTdqIp97InO?=
 =?us-ascii?Q?XYV10449bGjJjVdDdklX3jO6QFZ0WfCsM0Nl8j7UqznWvvNiHwp7C3Fy9nmd?=
 =?us-ascii?Q?i39ggtvtfLwWuSdthwPsu4Wcdzrv1UgN8v05J6DGMr6c07bWNGooDd30SWyI?=
 =?us-ascii?Q?zn+fK9MFxLd67Oek87xE1oP5Wiod1q62sYFkVNANuPmCac5/Dz02TTsIARqH?=
 =?us-ascii?Q?UYfpa1FIU7rTG831jgL53KKajE0Bx9WyWAKGK5D+5QW2Vi1MJsazHHwkmVm/?=
 =?us-ascii?Q?tnILNNksar8TaDgwchj/HGVfmXdkZYwYBYCtkCDU6vh+CXAPw0KN0pL9x8tK?=
 =?us-ascii?Q?jmb7exJVHWGFl3+OPC/Ar7V3W4ygEyqfLzSj+T9AlMAnAGgIKhVVvfJbMzhT?=
 =?us-ascii?Q?NN/d8fOjV0ddcCDkxYIoqtbBABCImqw77Z5tAX1Ju3OeF6owiMUA/OpMNy4c?=
 =?us-ascii?Q?ia/1dJYfSHUhC8cEWPvEGeQY9v6PmZ4Z17gq2mCOZgNVT/HHUZnheEgcYPrs?=
 =?us-ascii?Q?JvR0Dq+G4xe0LmAJbw2ZpOCn9JMn1hcTpU79wpIEQu0pPGFt3/KadWEDXF1g?=
 =?us-ascii?Q?av0SW1IBiUP+JGngRTzYZpptiIFgvqWaaK5Zw3A0JXOsB3tm5gqmOqUbzEty?=
 =?us-ascii?Q?X5Mr9td3x0nywpNYNwO4/+VvppIuTSMK8ZLa2+ur6toAZYzHLr86a2vMbTm1?=
 =?us-ascii?Q?UOuXsEEtdZcQnko0G2EuUWU7GqEf+p7ettpFCmvUuuhdIdy/FndVKPgKlgNi?=
 =?us-ascii?Q?Ule2gTtJupZYd5zkr5jemAdlhrQp106sDsdXxMKKNQRAekalH4fNPD36l3VQ?=
 =?us-ascii?Q?5FcJ5vCRN8CiNcqN4C9UzqWw4epYe7ePI4zDQM47EWfaIQevIi0a2DBG+dtM?=
 =?us-ascii?Q?+8ZgPWsczPqkK0L61HJN1APFWVyEBdoufl/FDG2j8CYixoj0krALSpp4M3rC?=
 =?us-ascii?Q?qD4dkpzV1iPxQ9NnVvpAGX//emuxiEkQMPqSgGK0Z+pxWovQPGJ9Ll4bCI70?=
 =?us-ascii?Q?Vmd3KH9JU9ZfELRTYdKNFTLAu14Eo7u7wAVk755KVM2mHUbl4W3JWKu6e0vd?=
 =?us-ascii?Q?Ey2x4ftdsMRUXsOwot1JNI2J68bVR9z3YePlVGrk4v9vLfN9BnF7oCBU50sF?=
 =?us-ascii?Q?IKBphpg1rYch56Qs1EoM2swk+u1GZ+J+zmPcbT62dsvwHXT6VfYNMWX3rUnJ?=
 =?us-ascii?Q?6h7kXLRGtzCOWvYyJTWnDm0pcnKgRohi0tdPmnbJdGUrFdZ8GsDydNz/a8Kc?=
 =?us-ascii?Q?++PaUlw+4GM6kfp/gTdfr5aMyEzbC9TkwU3vgOXADkOePbOi6Lte6g1a8YGS?=
 =?us-ascii?Q?m+260BN3c1Y5PeUv6oTFaDfjsxltKOZcV2tce2vHJ7D58K5gZ9V+Ev7eZYYZ?=
 =?us-ascii?Q?yKEuNtQr0wQkzNVRq5k1s3z4z8xIhXkxGFZEJQf5w3zqDL/go3aV/lDjWR7z?=
 =?us-ascii?Q?UsdMYGHlQY2suK4HHLM3zvojvXkoYAYVvNARTeJJvSVRowvRETPq4urLebyc?=
 =?us-ascii?Q?UrNeJVmnhs1T2Td/8VjIuJIJc9M17ZwXqgZd0J56He7qJvy67Ln+MeIg3siG?=
 =?us-ascii?Q?4RpRk4mVkhw3S3JH++n7FALu/Dh6vyXcYqTIR2T1zTnXo8D7aXkx3QfFMoWm?=
 =?us-ascii?Q?BA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 012f0b45-0173-4cdf-e4d1-08dc11e07af4
X-MS-Exchange-CrossTenant-AuthSource: BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 13:31:41.5298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OQG3qtl7eBEk7Dw9khJBUSa6haThNHtgqnSo1Txx2Vlq2giuBI06FOGmJKGT5LA5qNjgeOka2JW+vzNEA27/Q4E7JWs+DIxpR+Fk8vw7BEc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJSPR01MB0865

This patch series enabled basic clock & reset support for StarFive
JH8100 SoC.

This patch series depends on the Initial device tree support for
StarFive JH8100 SoC patch series which can be found at [1].

As it is recommended to refrain from merging fundamental patches like
Device Tree, Clock & Reset, and PINCTRL tested on FPGA/Emulator, into the
RISC-V Mainline, this patch series has been renamed to "RFC" patches. Yet,
thanks to the reviewers who have reviewed the patches at [2]. The changes
are captured below.

StarFive JH8100 shares a similar clock and reset design with JH7110.
To facilitate the reuse of the file and its functionalities, files
containing the 'jh71x0' naming convention are renamed to use the
'common' wording. Internal functions that contain the 'jh71x0'
naming convention are renamed to use 'starfive.' This is accomplished
through patches 1, 2, 3, and 4.

Patch 5 adds documentation to describe System (SYSCRG) Clock & Reset
binding.
Patch 6 adds SYSCRG clock driver.

patch 7 adds documentation to describe North-West (NWCRG) Clock & Reset
binding.
Patch 8 adds NWCRG clock driver.

patch 9 adds documentation to describe North-East (NECRG) Clock & Reset
binding.
Patch 10 adds NECRG clock driver.

patch 11 adds documentation to describe South-West (SWCRG) Clock & Reset
binding.
Patch 12 adds SWCRG clock driver.

patch 13 adds documentation to describe Always-On (AON) Clock & Reset
binding.
Patch 14 adds AON clock driver.

Patch 15 adds support for the auxiliary reset driver.

Patch 16 adds clocks and reset nodes to the JH8100 device tree.

Changes since RFC V2:
- Renamed the patch series to "RFC v3" because the reviewer suggested
  patch series at [3] to be RFC v2 instead.
- Added the "Reviewed-by" tag from Krzysztof for patches 5, 7, 9, 11,
  and 13.
- Renamed the clock nodes to clock-controller to align with the name in
  the dt-binding YAML documentation.

Changes since [2]:
- Renamed the patch series to "RFC" patches.
- Added the "Reviewed-by" tag from Emil for patches 1, 2 3 & 4.
- Removed clk_ prefixes.
- Used 4 spaces for example indentation in dt-binding documentation.
- Used the same license in dt-binding.
- Moved number of clocks from binding to source file.
- Moved number of resets from binding ro source file.
- Removed the subfolder for new clock files.
- Followed the JH71xx files naming convention.
- Followed the JH71xx clock naming conventions.
- Followed the JH71xx resets naming conventions.
- Moved the PLL fixed clock from the source file to Device Tree.
- Dropped clk.dtsi and moved the clocks node to SoC.dtsi.

[1] https://lore.kernel.org/lkml/20231201121410.95298-1-jeeheng.sia@starfivetech.com/
[2] https://lore.kernel.org/lkml/20231206115000.295825-1-jeeheng.sia@starfivetech.com/
[3] https://lore.kernel.org/lkml/20231226053848.25089-1-jeeheng.sia@starfivetech.com/

Sia Jee Heng (16):
  reset: starfive: Rename file name "jh71x0" to "common"
  reset: starfive: Convert the word "jh71x0" to "starfive"
  clk: starfive: Rename file name "jh71x0" to "common"
  clk: starfive: Convert the word "jh71x0" to "starfive"
  dt-bindings: clock: Add StarFive JH8100 System clock and reset
    generator
  clk: starfive: Add JH8100 System clock generator driver
  dt-bindings: clock: Add StarFive JH8100 North-West clock and reset
    generator
  clk: starfive: Add JH8100 North-West clock generator driver
  dt-bindings: clock: Add StarFive JH8100 North-East clock and reset
    generator
  clk: starfive: Add JH8100 North-East clock generator driver
  dt-bindings: clock: Add StarFive JH8100 South-West clock and reset
    generator
  clk: starfive: Add JH8100 South-West clock generator driver
  dt-bindings: clock: Add StarFive JH8100 Always-On clock and reset
    generator
  clk: starfive: Add JH8100 Always-On clock generator driver
  reset: starfive: Add StarFive JH8100 reset driver
  riscv: dts: starfive: jh8100: Add clocks and resets nodes

 .../clock/starfive,jh8100-aoncrg.yaml         |  74 +++
 .../bindings/clock/starfive,jh8100-necrg.yaml | 153 +++++
 .../bindings/clock/starfive,jh8100-nwcrg.yaml | 119 ++++
 .../bindings/clock/starfive,jh8100-swcrg.yaml |  64 +++
 .../clock/starfive,jh8100-syscrg.yaml         |  77 +++
 MAINTAINERS                                   |  15 +
 arch/riscv/boot/dts/starfive/jh8100.dtsi      | 313 +++++++++++
 drivers/clk/starfive/Kconfig                  |  45 +-
 drivers/clk/starfive/Makefile                 |   8 +-
 drivers/clk/starfive/clk-starfive-common.c    | 327 +++++++++++
 drivers/clk/starfive/clk-starfive-common.h    | 130 +++++
 .../clk/starfive/clk-starfive-jh7100-audio.c  | 127 ++---
 drivers/clk/starfive/clk-starfive-jh7100.c    | 503 ++++++++---------
 .../clk/starfive/clk-starfive-jh7110-aon.c    |  62 +--
 .../clk/starfive/clk-starfive-jh7110-isp.c    |  72 +--
 .../clk/starfive/clk-starfive-jh7110-stg.c    |  94 ++--
 .../clk/starfive/clk-starfive-jh7110-sys.c    | 523 +++++++++---------
 .../clk/starfive/clk-starfive-jh7110-vout.c   |  74 +--
 drivers/clk/starfive/clk-starfive-jh7110.h    |   4 +-
 drivers/clk/starfive/clk-starfive-jh71x0.c    | 327 -----------
 drivers/clk/starfive/clk-starfive-jh71x0.h    | 123 ----
 .../clk/starfive/clk-starfive-jh8100-aon.c    | 256 +++++++++
 drivers/clk/starfive/clk-starfive-jh8100-ne.c | 499 +++++++++++++++++
 drivers/clk/starfive/clk-starfive-jh8100-nw.c | 237 ++++++++
 drivers/clk/starfive/clk-starfive-jh8100-sw.c | 134 +++++
 .../clk/starfive/clk-starfive-jh8100-sys.c    | 415 ++++++++++++++
 drivers/clk/starfive/clk-starfive-jh8100.h    |  11 +
 drivers/reset/starfive/Kconfig                |  14 +-
 drivers/reset/starfive/Makefile               |   4 +-
 ...rfive-jh71x0.c => reset-starfive-common.c} |  68 +--
 .../reset/starfive/reset-starfive-common.h    |  14 +
 .../reset/starfive/reset-starfive-jh7100.c    |   4 +-
 .../reset/starfive/reset-starfive-jh7110.c    |   8 +-
 .../reset/starfive/reset-starfive-jh71x0.h    |  14 -
 .../reset/starfive/reset-starfive-jh8100.c    | 108 ++++
 .../dt-bindings/clock/starfive,jh8100-crg.h   | 421 ++++++++++++++
 .../dt-bindings/reset/starfive,jh8100-crg.h   | 118 ++++
 ...rfive-jh71x0.h => reset-starfive-common.h} |  10 +-
 38 files changed, 4327 insertions(+), 1242 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh8100-aoncrg.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh8100-necrg.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh8100-nwcrg.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh8100-swcrg.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh8100-syscrg.yaml
 create mode 100644 drivers/clk/starfive/clk-starfive-common.c
 create mode 100644 drivers/clk/starfive/clk-starfive-common.h
 delete mode 100644 drivers/clk/starfive/clk-starfive-jh71x0.c
 delete mode 100644 drivers/clk/starfive/clk-starfive-jh71x0.h
 create mode 100644 drivers/clk/starfive/clk-starfive-jh8100-aon.c
 create mode 100644 drivers/clk/starfive/clk-starfive-jh8100-ne.c
 create mode 100644 drivers/clk/starfive/clk-starfive-jh8100-nw.c
 create mode 100644 drivers/clk/starfive/clk-starfive-jh8100-sw.c
 create mode 100644 drivers/clk/starfive/clk-starfive-jh8100-sys.c
 create mode 100644 drivers/clk/starfive/clk-starfive-jh8100.h
 rename drivers/reset/starfive/{reset-starfive-jh71x0.c => reset-starfive-common.c} (55%)
 create mode 100644 drivers/reset/starfive/reset-starfive-common.h
 delete mode 100644 drivers/reset/starfive/reset-starfive-jh71x0.h
 create mode 100644 drivers/reset/starfive/reset-starfive-jh8100.c
 create mode 100644 include/dt-bindings/clock/starfive,jh8100-crg.h
 create mode 100644 include/dt-bindings/reset/starfive,jh8100-crg.h
 rename include/soc/starfive/{reset-starfive-jh71x0.h => reset-starfive-common.h} (50%)

-- 
2.34.1



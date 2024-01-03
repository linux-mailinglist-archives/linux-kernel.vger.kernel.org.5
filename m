Return-Path: <linux-kernel+bounces-15766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0B3823178
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 17:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E3CB1F249B3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 16:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91F21BDEC;
	Wed,  3 Jan 2024 16:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="OlpmG679"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2058.outbound.protection.outlook.com [40.107.15.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7D41C287;
	Wed,  3 Jan 2024 16:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WSO9hrBJGDOZbWS7BfIKFff4AMJbs4/JIHBa42MR76ezLKQ4nj4aAh6RhCTmkJIjVLj2tkgiqhf4nwFkHzdGIIVQ6aSlqlLYP4yCOn1oOnJCj7FlPbwFjXs0XE3rR3OmYXO6cLMdW8HMm5f0HWZTgrt3+RRN8rYLJ5gPVs/759QpNqJ4zUF1RsSPq/oT7pVXcjJn+qliiL6Ab/hbumjD99Xr5RvIH6DuyexG/feFz6LNRSgWkF5KltsDW5HmCSkomDYHl5aDr+VeyBsHNakR6ERqQyerhD6wxq1HnRveQ5583qFFd/zAdzvTI3FvCb5cfq4PEAIp727eNTOGgSma6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I9yMYUt6yt3mDJ5Zu76UoO4nZlgHgH9hpvVYIewn5xM=;
 b=GXRjAGe1BJOzFq2BdjZKdZVoYMxko5AjOXLt+IpCXQL78xhIjMq7FE+cyDPcDdhdV+UOycyR31P6xxDAraegvWnL8WVYACB/81e6CqNxM0nK3WGQyW56HVld1m8YDZJjh+Cs285EsL1Qm8bykwjRQTHUjKCWyFS0rYtIsQv4OLchKSbhK4P84BV6Ho2kYPdql1uty+89PLR+9GgJfmdHxvZjvb5Dq+e5/ACDZ/iVsifsGFKSd02ItCTinHZ+3FfRh0Zn/xIcSNaWz0UY8v4eLSZzTfxy1VyQcoiqNIszPvkHIz5hm3hpdP5aaShntb+szdD+U1NOemFK9n7D8UEaKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I9yMYUt6yt3mDJ5Zu76UoO4nZlgHgH9hpvVYIewn5xM=;
 b=OlpmG6791Ss6w7Z06RAUPhN9064VFSOLnju579Ksb7JnZzhy7yFdcOzDtL4IYlHbg+J1eNR25ni3HbduI+5+FA8tkuZoSJdkuRy7Ao8Z7MyRs5FEtJwZVuYXv59bLBS50yFyiXNQxLdu5A1ZRL9JgaSZMZPrDwHKoyYvN7QLkB48aWUnR184YKrd/3sry54K8ryasDXS7XcDcUfHEv/JXn6J/u1F1P9Py3DriMFXVV6NqycUk1btCpgE1Z1ty7DA8OKAuuhh+PHXvBhDCk3R5YRkaQf/nmGTDk5Os1WkYJIOkknLCIIShaxWy3bhEA5xbxOH3tPi+WRil8F+Cj4INA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from VI1PR04MB6013.eurprd04.prod.outlook.com (2603:10a6:803:cb::15)
 by AM7PR04MB7144.eurprd04.prod.outlook.com (2603:10a6:20b:11b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Wed, 3 Jan
 2024 16:47:41 +0000
Received: from VI1PR04MB6013.eurprd04.prod.outlook.com
 ([fe80::cc4a:6b4:812d:7c8a]) by VI1PR04MB6013.eurprd04.prod.outlook.com
 ([fe80::cc4a:6b4:812d:7c8a%5]) with mapi id 15.20.7159.013; Wed, 3 Jan 2024
 16:47:41 +0000
From: Iskander Amara <iskander.amara@theobroma-systems.com>
To: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: quentin.schulz@theobroma-systems.com,
	Iskander Amara <iskander.amara@theobroma-systems.com>
Subject: [PATCH v2] arm64: dts: rockchip: add missing definition of pmu io domains 1 and 2 on ringneck
Date: Wed,  3 Jan 2024 17:47:34 +0100
Message-Id: <20240103164734.1151290-1-iskander.amara@theobroma-systems.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P194CA0036.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::25) To VI1PR04MB6013.eurprd04.prod.outlook.com
 (2603:10a6:803:cb::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6013:EE_|AM7PR04MB7144:EE_
X-MS-Office365-Filtering-Correlation-Id: c5494a30-5d53-46b5-80f8-08dc0c7bb395
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qSYKJxZ1T9o3/BkT//iQdPHyKpmmpui2oXEM0/qMJUUaKGA5f48n9VZOLG6zvtpi3BqOzOUcFtoZg0t/QZuM8K6XZN9LOLkI9T433ETzokQI331tWg6S9bsQPx+4m8SkLoOiD3d730ytFlejqTAa9MWb9ZooylWHrTnwpBpugElYrzkpqBnr9z9Ux+BDCWZCXasqyo1D6MDZuNIHe7BWW2cQUsULaRiTUvPuUwGwTO8lMxLSK4NIeGVzLCvW157oXFv42/nAwoA9s7K7N6LBvznL48ozh4tdnlsD9Tre0oGXkQFbIu39Z36gV/vejp0z/UhkXCoBKmZWf1D0nZTLb9ydR0YaigBo/HcfpRWSH+aHOcVd/BuMFDaXSPqCeXMvq7z7tIaCyt58ezFZD6Fygk/JJyBMmk8Qo7nrwmH5FOyFG/ojheIP6Oedz6lao+ky98Rl4aoXh8Jv1Isg4v89PDt0Zaexl5NZNMhBLP7JJdvbS6HyPDsVBNhsGo3xJ30Snu8ldzJOHCq2kDqo51KpOoKMcxL7C3TiU5A4ArunxHKa3Y/EeYD4zPkeLUpgoBVxP6GBWsJxH/P/Yo4IpANfJfDqTd83LiG46N24169B6RwsVZ3T6g/CKk1nYaMzgmo4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB6013.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(136003)(366004)(39840400004)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(36756003)(52116002)(6512007)(66476007)(6506007)(66556008)(66946007)(6486002)(86362001)(38350700005)(38100700002)(2616005)(1076003)(26005)(107886003)(41300700001)(2906002)(5660300002)(478600001)(4326008)(6666004)(44832011)(8676002)(316002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VTe6MtLbn99JRVveEVxIFGG7X7FWiQDnG0nJKFeDUsdW66MaxXyMZxo3YK8v?=
 =?us-ascii?Q?En5+RBDGUxGO2vvE4DWhYd3Bws9krx2eyX9ccUHEGkDaqC/26dHqkRCdwKD7?=
 =?us-ascii?Q?ls9N+bMLoYzVrLdei2h90r61NaxbqGSrA3FoAF2LHpJ0o96TLbPVhfAdTnIm?=
 =?us-ascii?Q?K7lsm360ctZvR89SdJ6cSdoodTK27SBWNuf6TkPFDmFlUDYIXPMBdmQHqNZ1?=
 =?us-ascii?Q?iQ4teyy9+OitHAey3LvCsmtu0CplBcyKmf4ba9k8hOR3qcL68MA5cO6QcUW4?=
 =?us-ascii?Q?3W6Nci77TA1fDOnqlLoKW9kWHngcMtQUKjsCSwS+LCHoHJIyaTe6UWOdJK8i?=
 =?us-ascii?Q?TyVS5jPYx/LiCq0FvFwK/IhBkE9s4ZfZqk7NGqu6K1lEb8k4oUE+ic8mRUMg?=
 =?us-ascii?Q?T2s0TUDY/a/Cw9QE/2GSexevYVr21wtWdkS7rshPc2FmvEp9RDg7uPC0m1We?=
 =?us-ascii?Q?QXmuxRrWJaGxagudcRXNsc15GWFzt1Rb7pv7ldUItbCuc5wMzQa7cnWw7tA1?=
 =?us-ascii?Q?6P4Dkh/w44kLdRCcDewsyDfNJQtYZkWcHaZJuK3lKmP68I4kPAtR77MJEPST?=
 =?us-ascii?Q?Z4AAAlaGh+PM+L7geA764AhH03CMy7IxcaUKIfO7PXu7Kgx38kO/1xjBPXHC?=
 =?us-ascii?Q?P7MWrpkAPmTEyo57/aKn6PccJhxNStjDkA3iD9pPp/o4eCOEM2S5n9yDKzs0?=
 =?us-ascii?Q?7o+nNp4iP+G5nYptGH9B/esfKi7IC06O3mYTsIdxzaUvQkuWS3Co1mzk7itv?=
 =?us-ascii?Q?I5H/5QMxXfMZlDsQ4I7tjBW12sMxEu/wjMdMH2zQudH3Uh92Ea0gSkR4lK0i?=
 =?us-ascii?Q?om/Yw//LcUfXfx636sf6yuHgO82qZBKBCi8mX/xp70fC5dsWXBtk8KdBOBTZ?=
 =?us-ascii?Q?5Cd3nyVU68DFQaeM0QDMHkCIUTzO/eA4ArsH1RnQ2R03qjFg5muA/TzgUtID?=
 =?us-ascii?Q?7MmkczcEPMP9RIaDsL0AqOVNl663SHrp99v7CVfgmhLAM72Lr4z+oseB9L9M?=
 =?us-ascii?Q?8icCe5Hc0rGuGfBm+1zlhGQwNW6CnZo9nYkZ1xsYlyRwQvRua5D8YZ9TW6RA?=
 =?us-ascii?Q?7+uv8GVRVpTcb+iGzqfuhNvP6mjeSEHu/ftGXh2/O4JOiVch8MDcL5u5eUCb?=
 =?us-ascii?Q?ffYWfLdwL2hPNIUqaU0wRDis0FkGzRUxRJm4S1W88Q7SAstlfzo9CCgm5DRY?=
 =?us-ascii?Q?PothQq8Rpm5v3YPSlWaAnTKyo/aOvc0qjsnEjwbVS3jueb2TrITeEtp1jABv?=
 =?us-ascii?Q?8ASCDls77WA6sFFSe0xuCt3HiS+uhu90vk+q/aMrIQ7H4+i2oMpT2RT5WcvD?=
 =?us-ascii?Q?vUofFzV2DA354NE2/rh0sX2OazR6Wip5zCYdg8/cvoJGdTFWNzC6R3NN86jN?=
 =?us-ascii?Q?uQGKma/5Zhmvy8Qgwmu/hyECWjGMbdMA8YbCY4OjHbFRLc0xi5AR2MELC8Ke?=
 =?us-ascii?Q?qhTqkZtPaLalDuBZK7oU0yzn8t47Fck6YMcYH4O7+Akh8JfZVR4VmJrZZRm9?=
 =?us-ascii?Q?GlaYwbd05fUR+o0sLCGSPaMo/ht0AFjA2JJdefqFvDJMfIk0Fy8aCgMjFQxj?=
 =?us-ascii?Q?7KzHXrL4smnfWLFn1RsNWIiBi4b5gpaCpYL852tPy7l/eDV97Wh9tzNdMmeX?=
 =?us-ascii?Q?03V4FOtSLb1iSGONpWgSV28=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5494a30-5d53-46b5-80f8-08dc0c7bb395
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6013.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 16:47:41.4815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XzK1zDAhhOEaI6DktyEYnA5FjLuqscm0iFzTDdGUmcX50amUzkwFFPHMi0Ee+5R3NVgZD7sdym7mhdWHr5xRa1gGmvbSFI+kNltfAB7/hKypI9az8GrI3mrbTAwvnR7D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7144

Two pmuio domains on ringneck are not defined:
	1- PMUIO1: supplied by vcc_3v3 regulator(PMIC RK809)
	2- PMUIO2: supplied by vcc_3v3 regulator(PMIC RK809)

The reason why no functional effect was observed is because of that
the above mentionned PMUIO domains were supplied by a regulator
which is always on.

So let's add their definition in the dtsi.

Signed-off-by: Iskander Amara <iskander.amara@theobroma-systems.com>
---
v2:
	- Fix indentation
 arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi b/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi
index 12397755830b..bb1aea82e666 100644
--- a/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi
@@ -347,6 +347,12 @@ pmic_int: pmic-int {
 	};
 };
 
+&pmu_io_domains {
+	pmuio1-supply = <&vcc_3v3>;
+	pmuio2-supply = <&vcc_3v3>;
+	status = "okay";
+};
+
 &saradc {
 	vref-supply = <&vcc_1v8>;
 	status = "okay";
-- 
2.34.1



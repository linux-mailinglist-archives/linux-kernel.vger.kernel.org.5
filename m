Return-Path: <linux-kernel+bounces-142334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1938D8A2A4F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B0551C20B56
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D575FBB1;
	Fri, 12 Apr 2024 09:01:20 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2124.outbound.protection.partner.outlook.cn [139.219.146.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54B95F575;
	Fri, 12 Apr 2024 09:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712912480; cv=fail; b=Y8gB47YydwVWAE0V7hlVPJWtnyFUfHQtj8lc8ex91P8Opi0QEfu6h1olziR7Oar5fOM3igi+DuqTK5VGFnYnhkDXKML+7hed42TYjvAbjAImhQlQ2mkVUmk/Vu9Wj5HRjw5VVb5JiK8RO6G8keqIJ4BO6jDjc3H8c0uJGazGoS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712912480; c=relaxed/simple;
	bh=IPeNxs0GV5RvHF5K7iSXacxrWUJqpDZI0Xijsw/Pgb4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZB8yz2xBytfReJKVmnnns61888eMu0arvwhyBHB7WWlVwyOxTQ3zZrhm50pwUJqbFD3x3rR7VtKEmmhR5qsiFZAcJbLqt+kuPLE7VSOhwwx1ySizSpbw25UrcWHivr5ZdW9lH2xqvI795nkKDJiD3QV2VViXEOdUlOQy3tAhTt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ACpKZda6SmDJsc/IOg8Gh1/15z72aol7wxR5kwtWzkyDH0szftm48wCZVJfpyRXHcqR0Kz9Jg2j9vWlCx76vvVfiATeE8xXBnzmd28RpD/O3W1wv+tI54NgzLiY/PCFnveE7VqXUU/USxsvlFK4+6reoz/XNmXJOaysd06d10QLncp5Qc3BIaCqubr+89ftAl1OX0EqDjEEsAUvICvynBaf2RDHfFqKTDhJgGuFQbbikse+NcEDEtRIxr7Lek8ruFkd3jigjdm0654ndg2NR7gr6tylMHMKcGsIKucJ2gt8UFVSg5SZqLzSP4iabjo+sLxX73osnzypoXo/erBBHTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bExzAKbkuv5ZSIZLS/yH7MN0OlgkBE4W2QQ9sd5lUcc=;
 b=Toa4eZMC0Cd0k20gPFebSkJVZJjtRnKumaOSJXaLTub/APJMhJCC67i7rG0ApXl283dQPFBoeFOuXH7jsCHBL1KHUrPEQGg05uYjxFWWuEb6GgAkaMz85Z/Hd9uUBzUY6bQRg1bO+DiLeG79vakazuE24n24Vw+WjOmMWtc0IougfS3p++OSUY5wYL3rMdkME4H6qlVXlhAIo6Q7neEQO0BSZZIN0AmOnpnABCuhTwfO71DXKOWd/F5oELMbYIv6b5N9TKJoYUjwPGBbIjofCiwsmRLYHCqbMbD3jC13kosQwLzaMB3H4Px1ClNCjKmYH2I8n/9+bol6FKvq0uMfDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NTZPR01MB0986.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:b::14) by NTZPR01MB1129.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:a::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 08:45:56 +0000
Received: from NTZPR01MB0986.CHNPR01.prod.partner.outlook.cn
 ([fe80::8dad:760b:621:c490]) by NTZPR01MB0986.CHNPR01.prod.partner.outlook.cn
 ([fe80::8dad:760b:621:c490%4]) with mapi id 15.20.7452.019; Fri, 12 Apr 2024
 08:45:56 +0000
From: Ziv Xu <ziv.xu@starfivetech.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Walker Chen <walker.chen@starfivetech.com>,
	Xingyu Wu <xingyu.wu@starfivetech.com>,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor@kernel.org>
Subject: [PATCH v10 3/3] riscv: dts: jh7110: starfive: Add timer node
Date: Fri, 12 Apr 2024 16:45:43 +0800
Message-Id: <20240412084543.7243-4-ziv.xu@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240412084543.7243-1-ziv.xu@starfivetech.com>
References: <20240412084543.7243-1-ziv.xu@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0007.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:5::21) To NTZPR01MB0986.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NTZPR01MB0986:EE_|NTZPR01MB1129:EE_
X-MS-Office365-Filtering-Correlation-Id: 54a4f127-ca77-4482-24b2-08dc5accf802
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YBI5ecyynr93FUk6fYpJaEtbF9e3W+vZDE6NX49HnsdJRZYbAhRvKuJPq0zjc8l/XVNqn7+UIaUpTi9Tqt73boOae+ui8pf8gVTCb2Y10FNHH86U735z8gnNlakZt/sc7HdrIYrFccH+eA1DL+NoNM9denv+ehMu03hUlYsjAW2fF3A6LE50B6OqLzzR8/o9U6mAyUKLiwc68HruENhMwFHmkJ7UPBfQJ8EECrTWWkuK2kAaIEPEKFhrLXpn9z42IRBMQywdOMn59ShVWs/A5xaH+xm0BNmMNfQ4K/1FjXKCLUY9gTZH4vpIu2dZXDrz60FyLZOgcPcNf47ZhL3ya4nNhNVUe4BBW5n1xkNqQ+83vvvebiCHzl8utmFROYBYaKMSMcLam9H6ONCE1AztcqZoh1s9NH/oHSfMSuf1L9/QJP1k3HoRV5FaA+YwpcaHdmUnSXW39HtW9p++HRyAN1t87GarG/Vf/tPme7KS7net8f3gYJsIp3c1Ct6fSsOSkDKXwhcN1VnqFbKKCadolMGb++nuN5lxW/95iDNLNT9lmuGCMAgzbjyfh5enIa5YaHmyO/krx3SllhqkwtkBSTi+YvyorgsHFhqzvkJzCTIFaBxq1uVIsIn0p4awSb+d
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB0986.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(41320700004)(366007)(7416005)(52116005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H82LDo8hwsIq3aimdDbbqt/g8K1gODmcDaCfeQJlMBsP14ZJNDQBl/t6vBz8?=
 =?us-ascii?Q?nZ3kAV3WSGfoEWsgtMfNfDOKWRilyRUdAXVv4V8edjydOvrnh5m2UMAnPIAv?=
 =?us-ascii?Q?htVApXeyLm1sSXLE8hrTTW1tAAl62oOsW1NAvQhfp5dHVpybpA9DOji84m4X?=
 =?us-ascii?Q?DbKdezmRbQJq3M4/2DKpO7qvCMjOmKn4yAe3bX0bfDciqsOjc6xWfy6clNb2?=
 =?us-ascii?Q?dCGtA+MyMWp1CpaEydIEeFCycAkNm4vuj4iFej9vEHK2KR+dJ36ExwixRObF?=
 =?us-ascii?Q?z0VCJvZxkEDVY6KramdMLrv0TIWAEdCf//aBIPQS56SA5Hv5+pwbeNkIO7s9?=
 =?us-ascii?Q?/6Llwbi01/VPSiWZZlLGOP3jvQ7bH+/RTunz//FrY3e1SIRs94uXz4iObynk?=
 =?us-ascii?Q?ivS+egBrB0LsR2HCL3So07J/oo4q3ft0VghtlTvPVnmtgDYZsBNvS8LUl6Bd?=
 =?us-ascii?Q?wRWZlOWIRrwroU6u9IuA3NE5d/Ioa9XIvRfWxDl9EYbEprIqDV3KbNJnGo5R?=
 =?us-ascii?Q?hpOciD+A8NOeWcrz94bxVwkgTQ85iYaHpwwxH+3HTAVwGSgm7Qqinqw6CRea?=
 =?us-ascii?Q?a6E0USPZmGLggmR1cHro9G9SOzHhl1JUUT6FTOeM+DJL/Te0ZBTZJc8dVV+3?=
 =?us-ascii?Q?5OMzn/F/53hm8ktbfKeBctaOYprf6jze20h6vmqbBjMbjeEyNqNUYEjNinRb?=
 =?us-ascii?Q?G3GqaezsovudJE1V1/PSbb1d7ZnstSKV+lGlI0kkDDM/Q0SpiJEqlT0Ku1hC?=
 =?us-ascii?Q?pFZbR6aoSCdO6bW8je72ujGFQCRBqCeGRBffa4qq0Ib+fixoLq1AblyIZYrU?=
 =?us-ascii?Q?TqUBqF/XdnrHBDE7LR9T6T/lFNbIE7IlIznO8qILfVdLHrt8qYBPWFuCsqSK?=
 =?us-ascii?Q?wZuIOD6tbeGlsxGCMthXR6oMgmFh9WDlFfqBTPCBPgd3zwe7rO5pN7JRgB9V?=
 =?us-ascii?Q?josK1iK932EcxctFtRC9plu0y6yIZF2hThQOAOjW3T5fMEv2jjQdOTbdPVoP?=
 =?us-ascii?Q?GLkT9S3BZl/0wWfBDmRa3FSFiOy+CoDy/id3cuPazJhRVOGqyP0Dy/j7AVEy?=
 =?us-ascii?Q?yAhE/iVEreFWBuXMf7LdcZyzmiRWzUN9PGTfFMBifcOQ46Df+/MxcwRMVied?=
 =?us-ascii?Q?5jMqAZnlYTv+8qvrQ03R907z3QhwMD6/5Gb0zhy6PpplmDx6qvICYK9G+3QI?=
 =?us-ascii?Q?JgeIayvDrns7i7gJ0jKmgH5DIjzc3bxdFyBsTz3ki9v+oHd7RVsk/T8ByfDz?=
 =?us-ascii?Q?goplMuSy4FP6irc5D+zrmzIJ7ZuCTMVkyUBvZmOiquSXa8kApYk/uXV5WIrv?=
 =?us-ascii?Q?QFtYTIQccOHxzln1A4yS8B0jYIqHtasIb0tIB931IXFDm/k9rSi+g1FGu5ND?=
 =?us-ascii?Q?1uc69z0CPj5b8s6gvoAWdsraixBZCGqoqxtujZ9hqMgmhCxwsPvgXWXrmlSU?=
 =?us-ascii?Q?mxM0qq5MZ54A0MaFufLRic7t9GIIP7VfvemHokdohfaHDsihqf6nwf1MIkMV?=
 =?us-ascii?Q?Gdnj9uZi4HFbzDJc9xOMeXgkBM5C3fzi4ZklLtTd+aXj1xRPJiAOiKDctFzD?=
 =?us-ascii?Q?XU7GkCmOtZ71MWrJOpGwrHoSDcXtoVP0bBEcfo5EIrCzZ/3rMHmHN66MRTxN?=
 =?us-ascii?Q?oQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54a4f127-ca77-4482-24b2-08dc5accf802
X-MS-Exchange-CrossTenant-AuthSource: NTZPR01MB0986.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 08:45:56.1696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PawE4zwu8kHA/fxHLVtk5qmCVJUccGe+C5yHb+XX0ErNxOp+J+uRr/OhMAL8NZg00jR7CFHaRyEb5W0FWGdQtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB1129

From: Xingyu Wu <xingyu.wu@starfivetech.com>

Add the timer node for the Starfive JH7110 SoC.

Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Reviewed-by: Walker Chen <walker.chen@starfivetech.com>
Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
---
 arch/riscv/boot/dts/starfive/jh7110.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
index 4a5708f7fcf7..0854be18d922 100644
--- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
@@ -913,6 +913,26 @@
 			#gpio-cells = <2>;
 		};
 
+		timer@13050000 {
+			compatible = "starfive,jh7110-timer";
+			reg = <0x0 0x13050000 0x0 0x10000>;
+			interrupts = <69>, <70>, <71>, <72>;
+			clocks = <&syscrg JH7110_SYSCLK_TIMER_APB>,
+				 <&syscrg JH7110_SYSCLK_TIMER0>,
+				 <&syscrg JH7110_SYSCLK_TIMER1>,
+				 <&syscrg JH7110_SYSCLK_TIMER2>,
+				 <&syscrg JH7110_SYSCLK_TIMER3>;
+			clock-names = "apb", "ch0", "ch1",
+				      "ch2", "ch3";
+			resets = <&syscrg JH7110_SYSRST_TIMER_APB>,
+				 <&syscrg JH7110_SYSRST_TIMER0>,
+				 <&syscrg JH7110_SYSRST_TIMER1>,
+				 <&syscrg JH7110_SYSRST_TIMER2>,
+				 <&syscrg JH7110_SYSRST_TIMER3>;
+			reset-names = "apb", "ch0", "ch1",
+				      "ch2", "ch3";
+		};
+
 		watchdog@13070000 {
 			compatible = "starfive,jh7110-wdt";
 			reg = <0x0 0x13070000 0x0 0x10000>;
-- 
2.17.1



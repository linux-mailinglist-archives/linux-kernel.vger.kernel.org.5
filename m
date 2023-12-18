Return-Path: <linux-kernel+bounces-2986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46733816596
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 05:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 371101C22154
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 04:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158235690;
	Mon, 18 Dec 2023 04:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="KOVWs4pY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2035.outbound.protection.outlook.com [40.92.22.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92806538D;
	Mon, 18 Dec 2023 04:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=noULYUg4UNrp7XyyAw1WnlDX7b4EZGqThYBkK+/zJIod9GTFqGrYR7J/JeG+JOzyEoZgSolHRyxJSnnptMwqbIAwiyaoQ9l5P+NHJw5aDsZ8C2D3m8GrEpMg6zUWyNFUonpg7BV4gqJVcGShh3m5LrjiaQcEjwRR7qnG7CO4cSTiYiDoD3zlHWTLCiQ+HDDQo6kTqz4Z8ah/1oIrKUltT2ighnjt9MG8HuAA/9oZKTuKTVGZchbRthvOkPyPTEx2YF+pgbFoQfLGLgB53n2o9vLxobKqJFa9hvYJgVVoEzoVM1SWKeYbGTlz6oyAPuUcZHVUZDc+Od2KKSGHSY9WLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V7LoElwMN7arx3uYQfs+gIkmMqkFMhQjtR2nsLeLhiw=;
 b=IycW9J3Xk1HX8HLrf6fPBu+niVlvhypM/ihe1Q1DTKRP8LSJg3n+uuipGWIOK1zaiYKOOkVVqpDVU2moNMvAzDSOBzA2cGGM+8/Snhx9AWACSbEJcNBNp10rINTtOF1xvMETVUm46BSrfSzI4WUKuYi3tZ3FYPa8rkWO5hNnx0Z1UqgSF/0DHTDIbPSRW4tjWxGT44HsXXEsAR7CMxS4WkpUsSxiTxk1O8r/DGDttt5kOqMToH/IiRUVU6Eo1G0HINKmZhiJYMQwrYtxZHDCrYk/7VWKPcA9daZuK3HWZ7WCpdqH9qv9yS9s/Q3v8UrE0+712jdSdH30sysHLfVkDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7LoElwMN7arx3uYQfs+gIkmMqkFMhQjtR2nsLeLhiw=;
 b=KOVWs4pYJhGnI+3l1Ukbf3wNMj6UzSSWYCNsw10GoOG4CxLdDzEeYFq1+ERMnIGVZMmgbyCv5d2YKkWhd4C9jqA7k1aL2dF6lwxCxjlXO12C1kZZv23fryRWHDzWZ8sYF+LwTed3M1/DNiLEF33eIoYSf4vK5y5RbaqIzUmdW1nsazrwn9ZeoeijDT3CnCqV3aUKMpGDmY+fQALmhwXNR/m+2VRhkCCtiKRXRxVYpWHoA44/K1QSzJTHcvGhFXrUkgZ461+kj7hXNVQWii8MZk9NhqLsTnJwFtNiTPCI7SQctPEtYZUEZkCyGk5Kf8cm+r1baAKOWExu7UGGnASPBQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by PH7PR20MB6138.namprd20.prod.outlook.com (2603:10b6:510:2bf::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 04:15:40 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8%6]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 04:15:40 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Jingbao Qiu <qiujingbao.dlmu@gmail.com>,
	a.zummo@towertech.it,
	alexandre.belloni@bootlin.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor@kernel.org,
	conor+dt@kernel.org,
	chao.wei@sophgo.com,
	unicorn_wang@outlook.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Cc: Inochi Amaoto <inochiama@outlook.com>,
	linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dlan@gentoo.org
Subject: Re: [PATCH v2 3/3] riscv: dts: sophgo: add rtc dt node for CV1800
Date: Mon, 18 Dec 2023 12:15:14 +0800
Message-ID:
 <IA1PR20MB49538A79892CC58B13C61DB9BB90A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231217110952.78784-4-qiujingbao.dlmu@gmail.com>
References: <20231217110952.78784-4-qiujingbao.dlmu@gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [vMBBASEldvm2F6kW7LZSyh62g/HAaQlI7eW1g9dBMCM=]
X-ClientProxiedBy: TY2PR06CA0045.apcprd06.prod.outlook.com
 (2603:1096:404:2e::33) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20231218041514.579018-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|PH7PR20MB6138:EE_
X-MS-Office365-Filtering-Correlation-Id: 83466a76-86a5-4734-e556-08dbff7ffeb9
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	exqwH3famwu1triOiLxP2PSSR/W0PlMlq//YYj/bd0DHKI7wQt5NeUFhpX4447h+I6GW9lG8ptTYovwxv+xtr+unmqLdDBaFUE0jeLoaOQSAt94bT7zdP5/Zoi8VvbfB236dvCVfFu5TYrYzrgSMW02aOdsSU8M2ejBQbVizgWBHH/pGe57Gt1enP/2z/Yz8mT+RNDjhtCS/lCDY+/qjc2yaaFp7r2X90gDcx8xhwr45t2bzWJeEuDZ4J44eumDKBJdK2spLpneQKUEd30SuMSTGe6ZvsKgYC/XUpIg+SqLKj12LXFc2bhy6h54WRFojuAfhbMruRhuXA7xEKQvkmgU7JJWTrLVt4/UIguatLK8W3DxNyGh9VPrHBMkTf5NhJ6PmnPZ0dG7zmbpMTniBAYKIWxFaoJiovprWF/R0BRgv2HE7ch3yQmSuqAHOS1xGUTHWSih29s+l2muRFKQXOlDeVpc8XjDnvflcQ9YuotsNsl6OrGPd4v7isV5Q3zZ92ONk7XIlL4YTCPNumNV+PKABHeHZYQneqN2WyWzaywAGimCl6x6E8yGyYUj/tHOAnBn5MMieQZCnkxihYbLRNH7KjpoyEwj/qcYst9l2qNHIsLwf+U65lB+NMviQjqrA
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WEniHVH8XAqMsEpTglnfjTEDLB0yX/ViTidmXb5Z4aOi8jCmgm0vCKQ3Edxx?=
 =?us-ascii?Q?rIVvLirawhWEN2PEJIrolOnKKPWj1WxDMAsj3ci5klTsfRGVBtiGJCttuYTF?=
 =?us-ascii?Q?NgBYMM6BxBnyyeyeGnwGjpe6kz9rjupGHKn4a232UMv19QBPSOCjsLZj7nW+?=
 =?us-ascii?Q?PfCBvtjRMxx4IrvbllKpD+7FQP4O2/PdaYN45r+zMbYdw26nY1De6SQYzylF?=
 =?us-ascii?Q?Adus3lOyGdSGYCZWMnvnTNnsLcuq2Odk3NLg29EkfizyGsfAId2isxKuuTrH?=
 =?us-ascii?Q?q5iVr5/5GYt0d+dwfCGJWQVJ4NyLyEY5S3cexNOyD0DsX+LrZxnBfSWvCAAk?=
 =?us-ascii?Q?roTI0JBDgfwEUtcAWbUKJ1wYD5PL96ztdmQ6Q4QNKLkzk+KfiZ22DLjoivBE?=
 =?us-ascii?Q?WqO3+Q2TwVhO5vRVbYZgU3r1JLBcpBznzq79ZVR87PWU5RvisizVnDNe292P?=
 =?us-ascii?Q?6nsHg2b7UmvH4TTZvUG6QWqjI6AG9PKqZk0UsHdu4YhMOacp7L9AVh7Bnawg?=
 =?us-ascii?Q?6NcX4i+8mYwFHVvPX7NEMoq3e8OpLZCiGlVJaEQat0rmuWwKPBfeMR3UzUgH?=
 =?us-ascii?Q?km1kF+hDRyQEk57syQ0LOo3NPiNaEecXVgnFw4LHlr9hYq/pgSh04Ow6IdHQ?=
 =?us-ascii?Q?F+cjSGShpjzjkHii639JuJbcQaZ2+MLclMQ068dgTD5OA0CBCcmvBJfe0pvR?=
 =?us-ascii?Q?FOb70/3ztsLHUvbtBEUsjVy6+lsiDvn1mNKULA6MpfsiLT0Gq+2ok8o2g4fS?=
 =?us-ascii?Q?rCR+aOy9LPER4bpokq5R7yUNeosFZvCHH5Tzm/yVZVn95ZBfl7/b1SdP5TaU?=
 =?us-ascii?Q?MW7kVqjrRp5IQFhfIUwn7wWLdOvx592mfndQyP73J8DUw7pTOsBZxW5McyCZ?=
 =?us-ascii?Q?WeLL5m5ulELI8l5yAvj1hd1EiaIJtMlY6kRQ8uvHnsQMGDfHvUbbc8rhde9T?=
 =?us-ascii?Q?cjfhBHscRwe9AfmZGaunD4IE2hbTAGlDIXkQin+cmFTcHC6jrvJsvyzw76PT?=
 =?us-ascii?Q?CJhgzAUR2dnsjVw0ewBQlB8gmkKOP11HEDfZjXMOD3mfEgtzQiU4AoNuQZcv?=
 =?us-ascii?Q?wf0jdtf+Cx9dZAq9H16hpmECFqY2zDSaaDA6p5Tuh80asitXK89bkn6wHunw?=
 =?us-ascii?Q?cNQMhuOTw54QCQ2fu7qMolMjCNiALbgbxotwz4gxV1CgQ2UQx+wB3/9yBzCO?=
 =?us-ascii?Q?GQHGPGZAkQfgXj2hHeGO5D6r8WCCHnyhQoup9qNqCqH8LpML61vMU+dX7AY?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83466a76-86a5-4734-e556-08dbff7ffeb9
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 04:15:40.5157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR20MB6138

>Add the rtc device tree node to cv1800 SoC.
>
>Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
>---
> arch/riscv/boot/dts/sophgo/cv1800b.dtsi | 7 +++++++
> 1 file changed, 7 insertions(+)
>
>diff --git a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
>index df40e87ee063..429bee76f677 100644
>--- a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
>+++ b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
>@@ -119,5 +119,12 @@ clint: timer@74000000 {
> 			reg = <0x74000000 0x10000>;
> 			interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>;
> 		};
>+
>+		rtc@5025000 {
>+			compatible = "sophgo,cv1800-rtc";
>+			reg = <0x5025000 0x1000>, <0x5026000 0x1000>;

>+			clocks = <&osc>;

IIRC, the clock is not osc, but the clock controller with id CLK_RTC_25M.
Please read the manual again and ensure this is the right clock.

>+			interrupts = <17 IRQ_TYPE_LEVEL_HIGH>;
>+		};
> 	};
> };
>--
>2.25.1
>


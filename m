Return-Path: <linux-kernel+bounces-15445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4F5822C17
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 12:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3754B22CE8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 11:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38D819459;
	Wed,  3 Jan 2024 11:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="aBfW1VNJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2082.outbound.protection.outlook.com [40.107.21.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E719518EBB;
	Wed,  3 Jan 2024 11:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=augBU6ph4Cn8JPbusz1pnqkLNIRsDYP5EwbSscBwkJQ9SSEucBYtOWxNdEY8PLPbREGFF9nyLH3SfpGTFHCu7v1JWBZtTJyoR9sddmj7VH1srxd+J/+mIrdABnN0XaIoHlKu/WQG9LcpMRN1DShB6nZHuRcPWj1kbV1c1PUEwiEZ3fgVBXMap3E9HFgbAacuMU2RHM7rCoeDNRsKyzwbfEJTACGBe8yg0nXQNtQgCedzoAyL9nJzsI99MXyfbvNvXaFDEjpfDkEvAZszdaDKZy2ISZvMopnQMWkRXhccY4v9+Hqx/bSsGyKzQncVNC6nY31UFbTMLsSGXnwEx2ayxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hdZIOrMaPy5OjJB09X/fc+y+BgPdvE8C36qmLD05+MI=;
 b=kL7njTXmF6UBoA9BmVtGDoiYVDhzsMMluEkcQ/zYZXGba0wJkZ1dpSmfehZCygS6ih+DnnZL8K50Dy5bM+4wS9Hx7JV2QUN/tO8ngGQhJFdeQp5981Yi+19BiSLLVZVW5jwxP54Br0bjrV78UIbdP5RnQSVuI6QRqP+mD1WqpJsZ1VCKIlx4hKaG+/h88eodZZHIQsRJDCtvJk1eOVgLH94+x/hfU8uCiwGQq12+FQiKOskL0D5aNGkc3IWzJvt5+LVG+8iQqK+fm5j4U/Fv/1NFxR0D1np8Hlh5lM+LiMnXTWInPuuKF1IvPZtZY+pT7YPJkixVqqScoe5NpTu2lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hdZIOrMaPy5OjJB09X/fc+y+BgPdvE8C36qmLD05+MI=;
 b=aBfW1VNJubUqBVx2p/dgHrsG0TvXRHeZaxvKGWlEVqJRLlhi5as2fDZKN2FzWIfLD/Pxoq3cN4Z2sU0B4JEiXJe0/4psowu2bMbRQ/UZGdt4J8gqaAcgZOcO4GnNBbBCt+bYPzxoVKSewpLJ4CLyeGfoB1c9mpLuxS9R9u3ZMpk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by GV1PR04MB9136.eurprd04.prod.outlook.com (2603:10a6:150:27::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Wed, 3 Jan
 2024 11:27:21 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::4db1:aae8:c643:2e73]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::4db1:aae8:c643:2e73%6]) with mapi id 15.20.7135.023; Wed, 3 Jan 2024
 11:27:21 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Wed, 03 Jan 2024 12:27:15 +0100
Subject: [PATCH 5/5] arm64: dts: ti: am642-sr-som: enable iep for pru
 ethernet ports
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240103-add-am64-som-v1-5-dda1f9227aef@solid-run.com>
References: <20240103-add-am64-som-v1-0-dda1f9227aef@solid-run.com>
In-Reply-To: <20240103-add-am64-som-v1-0-dda1f9227aef@solid-run.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR0P281CA0232.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::16) To AS8PR04MB8963.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|GV1PR04MB9136:EE_
X-MS-Office365-Filtering-Correlation-Id: dfc001c7-25ec-4569-b627-08dc0c4ef38e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aiEWogiUcqK7aGOvU0K90sYRltLHsZmNHBOU7L3SqFJiUnwcmEej4QEDMoZIGTuLeLlBctZLCszJIhp2i2BdxINocFPvm9NgRqSzlC13FrNB18duG6Sul/EWiJwm8n3HauiHqYZeIC08O1E0SzXdlOZocSmZErLAK6IQ/jL6ajIqdPKuWh63kco/MLbK2W3oCpBVzo+NdthDVysryfN8KXbCjE4qsEG88/zSmkDmTVp0wcNaayfgen1+Qr/AewllSeuaNybdxDaLRyJL1PwzTNKRDAdxVIoA0VqZT8Yapw3DVDRPeipPwY6+doWrsO96YKPuXOqd41I6qcrCIZJL9vVA/p1scmW1L18imCl/+nf1KPZCa/OvetX3GEYEqzVkql3RU2Wk5Mk78vuiiGH0m8m+3X2YLOwapI/ORRxJknD2Tn+57nF4f8nQ6y8olPVVTYYHV37H8a6Am2JQWD7Czvq7FMuEYB6MDAGsbGf3SIEryNetor76QZIYQL1Tc9fkpF5hzPBN51Sm58V0A1PD1mhukHZ19heFwX/BWM/939KCl8ThIflaQnDSHebYpwd5DFhE3lrTm+9wAS4qyD4pU5XWAP7uE46Zrb1shlBBP0bgOyX8amuDnfxirkxsrIuj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(376002)(136003)(39840400004)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(2906002)(4744005)(5660300002)(6486002)(38100700002)(26005)(107886003)(478600001)(2616005)(41300700001)(36756003)(86362001)(52116002)(66556008)(110136005)(38350700005)(316002)(66946007)(6506007)(6512007)(66476007)(8936002)(4326008)(6666004)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b2N2TVlpM3JWbDRPR01iT2Z4MFRyQkE5VW5ZaXN4THRuYWg0Myt5Q0xoSU5k?=
 =?utf-8?B?ZE1LWDI3aUNrbW9JeU84VGh6S1JHU2N5WkgwUm4xUzlrMTVXY1Q2VTlkRmFQ?=
 =?utf-8?B?TVNyU20vd0oxcC9XTkFZRXMzRWxVRXArM1ZFclFqWllDRXdCWjcrN2JsaHpl?=
 =?utf-8?B?UEJaaW5qeUFsNk9PWCtQMkh2OG9aSE1ETzRCTHZHNCs2RG1nK2t4V1hqVkpP?=
 =?utf-8?B?bjltTVJ5SWhvSllsZVhVUStvQ1laM3pDdWt0NTNyQ0gyTVJkeG4vbXZPakZZ?=
 =?utf-8?B?b2YyZFJOYzFmcjFFRTNlMmg3Z1lFdDNTKzdZZFpHS0N1MmdLOFIrME9rNXh2?=
 =?utf-8?B?ZjJlajlFZTROTUtXZW03UkRmYysyanplRXlVUEUwZk00M0pNUUpGRmpxOGN3?=
 =?utf-8?B?S2JCV3hUWHZiVEhLQnBHNm9BRDdjQUEzb1FGV0pIOEFyKzRuK0oxc1gzbkxS?=
 =?utf-8?B?NGR3MS9kbElBYnAwRzN0anRDb1I3R2Fha3AwMStXZTR4NzFvekt3aWo4dUdW?=
 =?utf-8?B?WmJ6N1V4Ry9mQllmWk8ybWZIWUM2YndMN0p4cE1leVY4U21YcTNxcDUrWXlI?=
 =?utf-8?B?UnNBQmNqV3B6UG41NWVDcW5TOWNxL3k1S3FGZU1uY3g1Njg0RXFKMWtzZjVw?=
 =?utf-8?B?bUdCTVZhanhjczlVallTaSt2TXhlOW1xT21XSXp4U3JDTzJIZVlIVHFjRTRq?=
 =?utf-8?B?Vi9lVTRQaTR2QWpNU0NKWGRLNVBnUkVXUW9RVFNCNW95TkZOK2JHRE1FV3BU?=
 =?utf-8?B?L2xzZ2JteTl0QWhNcGg1SVNNUU8reUlRdWZDVTEvUHZkbVJxamJFSGlYbmIw?=
 =?utf-8?B?U2hISjA3RHI0dTlQUEkyR0tmZWs2VmRkOTk2eVdGUXkyd2F1aXJ0ZklpN0NK?=
 =?utf-8?B?SEZYOUNsell4RkFxWlA3cXBTN0ZUcnBPUW9yVkJwYzI0WkRsK3Vsd0pmSVkv?=
 =?utf-8?B?aTBZUytMUVRucWp2TjNyWjZaOE1QRm9kcmJXL1hwL2kxazIrNnhWcXREbnEr?=
 =?utf-8?B?bTNZcU8wWmRjVWRxbVpCSnJUNWRmTW5iZmRhMzZ3UDU1MXdZUGJ5UnZreFNB?=
 =?utf-8?B?RVdKS3gyL09scXdBN1VySVNvZ2NuK0hjK0Y5dFl6alBJcmFKNmU3M2hydG1p?=
 =?utf-8?B?S3JKc1JkTkpVeHQzbWFkM290Sk9aWEtSN1VKRVFuc1c1dHU5Z1hxdjgvR0Rk?=
 =?utf-8?B?bHpxdjc3NERPUGhndWRFWEhKR203NTRTVGtyRCtJZTUrTkVmQU44VHZZMmlB?=
 =?utf-8?B?aDJCK01Mb2VUejFTTHZJdEQ1WnBjN1NocFB3VEw5WEhHdjBYenRJandSZk9y?=
 =?utf-8?B?NmprQ0x6T1VHMFZoeURTY01JODRBbXBHSnZRcWRaeHRLMVJMblVnWDY5Wk1R?=
 =?utf-8?B?TzBqcG9PemdKT29JVXFxTUszSDdmR2tiek0xSHA2bGs3WGRjQ2IxeEhhekVw?=
 =?utf-8?B?SWJDMjJjQlJvYzZ0cjZMclBhMXNUZzljN09sbHRETXlrM2VMSmVJWDc0STg5?=
 =?utf-8?B?SXl3V3dPN3RWdC9Jb05yUnV1U1VMYjBnNTAwdFBHOFhoOVdYV29obm4rcTd1?=
 =?utf-8?B?aUlsSWQydStXUWNIZk9Ta0pzSm56MW85aXE5WjI3RW41QytESTNCUzcybTFs?=
 =?utf-8?B?UUZCM1Bia1QxQmdubXdnYUQ0Qy9vUnRzcFNXSXk2WWdOM0JtalVXT2hqUmNn?=
 =?utf-8?B?U0dab2QxS3F3MTNZN0dQNXUwNEtkenFVMVNlaEJ1ckh1QWlZLzE3TUoxZmtW?=
 =?utf-8?B?akxCNnlXdjgrRlhucXAxTUJLN25wUFh3SlFyaUJGek1nRlRqTnBTaUFOM1dr?=
 =?utf-8?B?aWFNTXNwUlBLMnIyblBTOTBQaGhHQjBZb0F3T09XQXlmd2dFb0JVaUg3cGJQ?=
 =?utf-8?B?b0N2UncxYzdFTnpPajREeEcwL3FZVERJSEtJWTgzakw4OVFKZjNWeWZ5R0E3?=
 =?utf-8?B?MENqSVZtazN5ekFjbHZIVENqci8yUGpMUWg5RXhkRlFNR0o4N3pzZ2hpZVdG?=
 =?utf-8?B?bGUzbHA1TXljQW80K0NPMHB1OURoRE9Bek9kUWI0bFZWRXAweEIxd0pwa2l2?=
 =?utf-8?B?OVRlcitITjdVaHhtNmFvcW9oWTFMVTBWbHFEVXRSeFBWUGhBN3QyRUtvb2xS?=
 =?utf-8?Q?HTAGun8FZ4yriTcUNC5Xh+fLn?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfc001c7-25ec-4569-b627-08dc0c4ef38e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 11:27:21.3810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rhOBZB20MVyGug2hmBkXUnzYRU9wUW+aWehtvZeu/9ii7HB+rPvxNBZunmhujMP0FKZvxPbz2Ap8GGlO57OSEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9136

AM64 SoCs have "Industrial Ethernet Peripherals" (IEP). Link them to the
icssg pru ethernet on solidrun am64s som.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi b/arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi
index 952a262d6874..92f60ae7dc8d 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi
@@ -49,6 +49,7 @@ icssg1_eth: icssg1-eth {
 
 		ti,mii-g-rt = <&icssg1_mii_g_rt>;
 		ti,mii-rt = <&icssg1_mii_rt>;
+		ti,iep = <&icssg1_iep0>, <&icssg1_iep1>;
 
 		interrupt-parent = <&icssg1_intc>;
 		interrupts = <24 0 2>, <25 1 3>;

-- 
2.35.3



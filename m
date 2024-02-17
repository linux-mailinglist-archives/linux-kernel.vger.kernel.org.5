Return-Path: <linux-kernel+bounces-69790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E7F858E9C
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 11:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 391DA282E5D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 10:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48891DDF6;
	Sat, 17 Feb 2024 10:13:23 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04olkn2015.outbound.protection.outlook.com [40.92.74.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9403D1D528;
	Sat, 17 Feb 2024 10:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.74.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708164803; cv=fail; b=iWq+ResTbjEk2gyPrdvSzhhxhGgpMHAAX5NnoQY+ZT/UUurPi8+rCYzOvuFEXfSr1/fgPkpfA0roD2cKFkyR8RiTEfmnDQaFtk75R7EnKTjZCwOT270qrk14H3q3G2Dk6i8fKcBhwA8OfozWrepAWqaNbnS0zBCJpmDrbsQxkoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708164803; c=relaxed/simple;
	bh=2XT6XWYRa0shVjWsCfFCbZ6bwiKwTRbmDMyMqvEVwAA=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bH128BPQwQZ9JcUg2WdpS4PpzI8IZEnKgFcsZaogumwDX41dVMzVO9e3FQ0W7tpQIZxXNUb1fMvFCjngQeVok6Ub+6r2VFp/QkcpyjUHpECl3VcxwgGKDzO77dJDgIQKvt9eqiu+4Hpm37tprWlTK9qd3ww5BFPRTMgLx8mPqJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.it; spf=pass smtp.mailfrom=outlook.it; arc=fail smtp.client-ip=40.92.74.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.it
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LA3jDA2JXOhHVE9OgdJ66iVnrR82J9tSiKd9OoH4gdfr65G1GlpOUNuXc5Dj5Mn/Skb8auFikMn8Z8SzyqiNJx631avzpZbFlVJhMdPdoe0ygCRcMquiLSUs9TR05fYyGFNjCmkDO5k6HGsXoOJeWohlRAGWiQalnbgYYuhHf2qRRXj1G10jz7FQ3O+Vdmpi6RMORG259mREVD2z7wCR/IgGwWugdu9cZgKSWn0uNjDQawvLGiEJab1RrddmogxO6A9FuHDCAXABlat5wQonrpK9kU6T0E7tfee/wRNAos/ufIIAOxYyO706Y5snyg9LxWonNGqcmNyk7wd6+iKOMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1LXWk9qHuhxZxhbEh4lQ2NlLHTHhrHYyOOtrXmbeYbw=;
 b=SyaNNSn23bIiwZSxUItoQQRqCm/UqeZ/lz1w2vOu4qngOiU2gZanxqAU/duHaBZqgRxOkZ83NxjM+NLICe76zb1DsbhC+SXXpV+Unz8WA3a4wp+vDFaTupkBeoE992k78z0J9JPknSYtAjWGLNdbF3Yx/sngiYhmgDZi51vtR1w2URr3dJ8n4MOQhTxE+FR6HGKpbUgYPrj44AjGEZSC6pY0Y3VFdkG7IQTCh+kXZ6qM703B7lpAEsmf5+ib9XzsrcChqsNwHEKsUF+8HhLauGCYSEM/+YkX7t9flFSNo38yao9PGdcg5xsoW1TZdhFcW06kuGhT/hWtK7WXiqESgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AS1PR03MB8189.eurprd03.prod.outlook.com (2603:10a6:20b:47d::10)
 by DU0PR03MB9567.eurprd03.prod.outlook.com (2603:10a6:10:41f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.32; Sat, 17 Feb
 2024 10:13:17 +0000
Received: from AS1PR03MB8189.eurprd03.prod.outlook.com
 ([fe80::ffb3:3ff8:6ea9:52b5]) by AS1PR03MB8189.eurprd03.prod.outlook.com
 ([fe80::ffb3:3ff8:6ea9:52b5%5]) with mapi id 15.20.7292.026; Sat, 17 Feb 2024
 10:13:17 +0000
Message-ID:
 <AS1PR03MB8189ADFF1A475AE7DB281BE782532@AS1PR03MB8189.eurprd03.prod.outlook.com>
Date: Sat, 17 Feb 2024 11:13:14 +0100
User-Agent: Mozilla Thunderbird
From: Sergio Palumbo <palumbo.ser@outlook.it>
Subject: Re: [PATCH net-next] net: sfp: add quirk for OEM DFP-34X-2C2 GPON ONU
 SFP
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <AS1PR03MB8189D48114A559B080AF5BEA82422@AS1PR03MB8189.eurprd03.prod.outlook.com>
 <Zb1+p6FiJwUF53xc@shell.armlinux.org.uk>
 <f8cf41f2-4a90-4ef5-b214-906319bd82d4@outlook.it>
 <AS1PR03MB818911164FB76698446CFEDC82472@AS1PR03MB8189.eurprd03.prod.outlook.com>
 <ZcI+7grKa33oLtwc@shell.armlinux.org.uk>
 <AS1PR03MB818926990092981B0E09E60B82442@AS1PR03MB8189.eurprd03.prod.outlook.com>
 <ZcSZtLSWd09xqc10@shell.armlinux.org.uk>
 <AS1PR03MB8189A24B92030AA8F011C7B582442@AS1PR03MB8189.eurprd03.prod.outlook.com>
 <ZcTzMgxmA6WOoiA/@shell.armlinux.org.uk>
 <AS1PR03MB81891A5F3C8B1A7542746CB582442@AS1PR03MB8189.eurprd03.prod.outlook.com>
 <ZcUBP3g0XNMG/aU2@shell.armlinux.org.uk>
Content-Language: it
In-Reply-To: <ZcUBP3g0XNMG/aU2@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [1u+wdsksHtR2OVUywKL3EMa7r9uqgQELqCPx45QW0PMRRIbaw0B7SjmLKqbeyrC8]
X-ClientProxiedBy: MI1P293CA0016.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:3::8)
 To AS1PR03MB8189.eurprd03.prod.outlook.com (2603:10a6:20b:47d::10)
X-Microsoft-Original-Message-ID:
 <b6dc4151-3878-474e-84fc-2874f8fd9d85@outlook.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR03MB8189:EE_|DU0PR03MB9567:EE_
X-MS-Office365-Filtering-Correlation-Id: a36d8fb6-3d5f-4888-6f23-08dc2fa10f66
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cBtKFD1uUkeRjY0YVSl9Y6vkWcGIK4bT8vkTgSVr9mt3QMTGhNM3eoY8v6uAIJbGDGZDD3MzdD2jwAzxDzen0fZVTPO3Fhpd99zkU52mfzTTgrUjrn6jk3ikpN+70sJJ94namnbz5G+3iKKKNlmJqPhiehExZo55BML7AAlZA7sFIMentRkYxiICVuebHqZNzGwvsxfX8DimT3x5ZAHjsCSH9I8uEp+dmSQqcBe4hGUZRKMeyWVSZ2BvvxlFUOUVV2yHDrusDV7PSn943uXlv0046tn0HBM2pBeuLlArc4IJ5D2Z4ggPi10VQLHcnGckkXFtXcuFdwbnC9UXzdq7M96oRNAuRj4RbuOvsLbKCMvckGtUjuwGfxowmVHL6xUWkxrPbhvYw4Ngk+Aqq1AdCKhQHm1vOxMNJe8d1gUBSY+8xfkXu/Cj15bwaIfAQv1kRqufvehrDnEPAghgd8ibz3CX/e9Vayzt546o98zHNafRa7QxEh4yVWsBIXMBNpAupBB5oz7yTugyfcilgwY4EwrbFGnZLojuQ9WQPlP30UXBa2DX/nbTs9JoBHNtwUnv
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RmdXQkFXekRwaDNxT05sRlVBSmtNSUpHZzlUWWx4S2I1TlBCVVVKTmwzN29V?=
 =?utf-8?B?QVI0VG0yUmdBc1VaUkRBNVRIWVprcjRjWWkyV2kvby9xV24wMENGNyt2M3Bs?=
 =?utf-8?B?WVI2b2RTSytGKzhnQ0d5UFpOcDc3enVKb1pEb2tYMWFwQWVOVDBRbk1jazEz?=
 =?utf-8?B?MDhWbmx5VlNJRUpWaml1MFZ2UWdxUExlR3BkanM4dUt5bnlwZmlZOWtRcVpq?=
 =?utf-8?B?cmdubWdZelQ3L0RHRGxscFRTeURWUzFtZmtxMzJ6eldncGdlM1h3RWdtZVpR?=
 =?utf-8?B?MktFTG0rRlpESWppZGRxRFFrYlQzSkZGeGJ1OUJzdnFaa2ZXM1pKZkErdXBQ?=
 =?utf-8?B?NWtFaytMZWpWS1lCZVFPMzZ0U2NMbEFyd0x2amxtdkQwbFIxNkVKbGZqNk4v?=
 =?utf-8?B?V0RYeE1qY3ZqUXpGeTNRZ2pUeE1lZEtkcU9nRVVsVitKRHprUGZPV0dWeDJL?=
 =?utf-8?B?MURmWkZPWHFnbEdaTXFIOWhtMCtyRzgyVGNxNEhpaDN4VVlTWXRRUnVoOVlK?=
 =?utf-8?B?SW9xNE5lWlZnb3hDWTQvWE5uWHhsMzZPaUNHc1RFdHJzeTBpTVE2UWUvTjY4?=
 =?utf-8?B?YmsrdDc5MksrMUluVm50OUF3WXZjL2dxa1Z3SkJwOVhjeTQ0L1VDWG5XQXZt?=
 =?utf-8?B?OGZFVk9iYjA3NUl0SVFoTmJSZ3B1aUtyR1pNc04wMTZGWm9qWGVnK2RuMUhh?=
 =?utf-8?B?ZzBGRTVOMVR4blZ1UVMzQ0hreUorU1dZaHNieHF2R2VRQlJ0R3pFSnFaU296?=
 =?utf-8?B?dUVRcnRZSnFaYmtlVUlRdmw3OFBvUXZlQVhyZUFTUUh1RG1VbWVGY0oxdng4?=
 =?utf-8?B?VjgycU56VHUrWWRZSmxyd3drQkI3MUhOU2RNTS9MN1YxQzNsRnM1TW9WS1RP?=
 =?utf-8?B?bFgrTHBpSlZtK2xuRFFyNWF3VFRYOEUzR1Bjd21IYkxVcDhxc216MzNySEcw?=
 =?utf-8?B?SzhtQUdrSXNWcnFDVHBDVkwybGV2OThJOXNKd3pBSEhEVDBiR08vdllzVUcx?=
 =?utf-8?B?NC9McVFYeC9IckZSRXRxWVNCbndqZDZCa0tzN3Job3BkZ0NYemZDNkRYWExs?=
 =?utf-8?B?a0NzV2RDdFAyUXMySVJETnRIZTdLMGhGbDJGY21paEJUeWtGZWwrMjQ1V1hR?=
 =?utf-8?B?Y05FaUhGME1zbGhMMlRrQWpMbTBpOWRNSS9HS2N2L0FuME15U1RQUWUvb3lD?=
 =?utf-8?B?QlRQUkprdmlPVTIrWmFDbVE1a21QTkE2YjlMbW1nSDJ6ZHpNa0VaTEFzU1BP?=
 =?utf-8?B?R2p5TEVRNU9yZnZnM095UlBJZjFWaU5mUG9GdGhjWnorZ1JCTU1pSWV5T0Z2?=
 =?utf-8?B?QUFmOGZUNi8xQlJ2NHg4RTNrZzRzaE5jVGQ3VVhmcWtBRDlvaURmWUx5MnhL?=
 =?utf-8?B?bE16Mk0rSWZoUWI4bTRVUHRMQ3Y3ZkhLbXFMUWdMdFp4bVdpSytESkZMYU04?=
 =?utf-8?B?V2NHaktLbGJPTnRDN016S0Jhcyt5RUgreEo3cm5vNzU1STJsOTNxNDZtSVZR?=
 =?utf-8?B?N0ptdytIRUM0TkNHMDlTZTVxZkYzRzk3akR4a2pzSDk4ODIreHhnbm02d0NN?=
 =?utf-8?B?QWhrV1pEQlY5Y090bkNPV0dYaEJ5ekwyQU1kRTd3WU9YZERHMjVKNC9NYkpM?=
 =?utf-8?B?a0JBQkp5QkxHM2xDSG9ieGk2Ykxsc1dHOGh5MUFxcWhiWGV4M240dElqUUVn?=
 =?utf-8?B?d2dCL0lwazZMQm5jc09vTStpdEk1c3p0bXQ4d0YycEkwRkpnWGI1NXgreEJ4?=
 =?utf-8?Q?C7Iza/1Z7rGZlzpfJhm1Au2zt43yEgpQkd2azCz?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-76d7b.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: a36d8fb6-3d5f-4888-6f23-08dc2fa10f66
X-MS-Exchange-CrossTenant-AuthSource: AS1PR03MB8189.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2024 10:13:17.7553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB9567

Hello Russell,
unfortunately I did not have time imediately to run tests.
Now I had some time available to run some more test, this is the result:

The current situation:
Host supports		Module		Mode		Functional
1000base-X		LAN_SDS_MODE=1	1000base-X	Not tested
1000base-X		LAN_SDS_MODE=6	1000base-X	Not tested
1000base-X + 2500base-X	LAN_SDS_MODE=1	1000base-X	Yes
1000base-X + 2500base-X	LAN_SDS_MODE=6	1000base-X	Yes

I recompiled the linux firmware with the #define DEBUG in phylink.c

With the quirk:
Host supports		Module		Mode		Functional
1000base-X		LAN_SDS_MODE=1	1000base-X	Not tested
1000base-X		LAN_SDS_MODE=6	1000base-X	Not tested
1000base-X + 2500base-X	LAN_SDS_MODE=1	2500base-X	Yes
1000base-X + 2500base-X	LAN_SDS_MODE=6	2500base-X	Yes

 From the above it is clear that:
- using the quirk the module is always working at 2500base-X if the host is capable of 2500base-X
- the internal settings of te module does not affect the speed

Here below an extract of the kernel log with phylink debug for 1000base-X + 2500base-X	LAN_SDS_MODE=1	2500base-X :
sfp-1/eth1= DFP-34X-2C2 module
sfp-2/lan = sfp/ethernet copper module working at 2500base-X

Sat Feb 10 19:17:29 2024 kern.info kernel: [    2.111137] mt7530-mdio mdio-bus:1f: configuring for fixed/2500base-x link mode
Sat Feb 10 19:17:29 2024 kern.debug kernel: [    2.118440] mt7530-mdio mdio-bus:1f: major config 2500base-x
Sat Feb 10 19:17:29 2024 kern.debug kernel: [    2.124099] mt7530-mdio mdio-bus:1f: phylink_mac_config: mode=fixed/2500base-x/2.5Gbps/Full adv=0000000,00008000,00006240 pause=03 link=0 an=1
Sat Feb 10 19:17:29 2024 kern.info kernel: [    2.138585] mt7530-mdio mdio-bus:1f: Link is Up - 2.5Gbps/Full - flow control rx/tx
Sat Feb 10 19:17:29 2024 kern.info kernel: [    2.147273] mt7530-mdio mdio-bus:1f wan (uninitialized): PHY [mt7530-0:00] driver [MediaTek MT7531 PHY] (irq=146)
Sat Feb 10 19:17:29 2024 kern.debug kernel: [    2.157515] mt7530-mdio mdio-bus:1f wan (uninitialized): phy: setting supported 0000000,00000000,000062ef advertising 0000000,00000000,000062ef
Sat Feb 10 19:17:29 2024 kern.info kernel: [    2.180320] mt7530-mdio mdio-bus:1f lan1 (uninitialized): PHY [mt7530-0:01] driver [MediaTek MT7531 PHY] (irq=147)
Sat Feb 10 19:17:29 2024 kern.debug kernel: [    2.190651] mt7530-mdio mdio-bus:1f lan1 (uninitialized): phy: setting supported 0000000,00000000,000062ef advertising 0000000,00000000,000062ef
Sat Feb 10 19:17:29 2024 kern.info kernel: [    2.213265] mt7530-mdio mdio-bus:1f lan2 (uninitialized): PHY [mt7530-0:02] driver [MediaTek MT7531 PHY] (irq=148)
Sat Feb 10 19:17:29 2024 kern.debug kernel: [    2.223598] mt7530-mdio mdio-bus:1f lan2 (uninitialized): phy: setting supported 0000000,00000000,000062ef advertising 0000000,00000000,000062ef
Sat Feb 10 19:17:29 2024 kern.info kernel: [    2.246219] mt7530-mdio mdio-bus:1f lan3 (uninitialized): PHY [mt7530-0:03] driver [MediaTek MT7531 PHY] (irq=149)
Sat Feb 10 19:17:29 2024 kern.debug kernel: [    2.256552] mt7530-mdio mdio-bus:1f lan3 (uninitialized): phy: setting supported 0000000,00000000,000062ef advertising 0000000,00000000,000062ef
Sat Feb 10 19:17:29 2024 kern.info kernel: [    2.279159] mt7530-mdio mdio-bus:1f lan4 (uninitialized): PHY [mt7530-0:04] driver [MediaTek MT7531 PHY] (irq=150)
Sat Feb 10 19:17:29 2024 kern.debug kernel: [    2.289490] mt7530-mdio mdio-bus:1f lan4 (uninitialized): phy: setting supported 0000000,00000000,000062ef advertising 0000000,00000000,000062ef
Sat Feb 10 19:17:29 2024 kern.info kernel: [    7.482162] mtk_soc_eth 15100000.ethernet eth0: configuring for fixed/2500base-x link mode
Sat Feb 10 19:17:29 2024 kern.debug kernel: [    7.490445] mtk_soc_eth 15100000.ethernet eth0: major config 2500base-x
Sat Feb 10 19:17:29 2024 kern.debug kernel: [    7.497041] mtk_soc_eth 15100000.ethernet eth0: phylink_mac_config: mode=fixed/2500base-x/2.5Gbps/Full adv=0000000,00008000,00006240 pause=03 link=0 an=1
Sat Feb 10 19:17:29 2024 kern.info kernel: [    7.510911] mtk_soc_eth 15100000.ethernet eth0: Link is Up - 2.5Gbps/Full - flow control rx/tx
Sat Feb 10 19:17:29 2024 kern.info kernel: [    7.556750] mt7530-mdio mdio-bus:1f lan1: configuring for phy/gmii link mode
Sat Feb 10 19:17:29 2024 kern.debug kernel: [    7.563831] mt7530-mdio mdio-bus:1f lan1: major config gmii
Sat Feb 10 19:17:29 2024 kern.debug kernel: [    7.569386] mt7530-mdio mdio-bus:1f lan1: phylink_mac_config: mode=phy/gmii/Unknown/Unknown adv=0000000,00000000,00000000 pause=00 link=0 an=0
Sat Feb 10 19:17:29 2024 kern.debug kernel: [    7.585159] mt7530-mdio mdio-bus:1f lan1: phy link up gmii/1Gbps/Full/rx/tx
Sat Feb 10 19:17:29 2024 kern.info kernel: [    7.586893] mt7530-mdio mdio-bus:1f lan1: Link is Up - 1Gbps/Full - flow control rx/tx
Sat Feb 10 19:17:29 2024 kern.info kernel: [   15.122661] sfp sfp-1: Host maximum power 3.0W
Sat Feb 10 19:17:29 2024 kern.info kernel: [   15.127875] sfp sfp-2: Host maximum power 3.0W
Sat Feb 10 19:17:29 2024 kern.info kernel: [   15.459629] sfp sfp-1: module OEM              DFP-34X-2C2      rev      sn XPONxxxxxxxx     dc 230912
Sat Feb 10 19:17:29 2024 kern.debug kernel: [   15.469121] mtk_soc_eth 15100000.ethernet eth1: requesting link mode inband/2500base-x with support 0000000,00000200,0000e440
Sat Feb 10 19:17:29 2024 kern.info kernel: [   15.509967] sfp sfp-2: module                                   rev 1.0  sn 2307210038       dc 230721
Sat Feb 10 19:17:29 2024 kern.debug kernel: [   15.519434] mt7530-mdio mdio-bus:1f sfp2: requesting link mode inband/2500base-x with support 0000000,00000000,0000e440
Sat Feb 10 19:17:31 2024 kern.info kernel: [   24.360320] mt7530-mdio mdio-bus:1f sfp2: configuring for inband/2500base-x link mode
Sat Feb 10 19:17:31 2024 kern.debug kernel: [   24.368145] mt7530-mdio mdio-bus:1f sfp2: major config 2500base-x
Sat Feb 10 19:17:31 2024 kern.debug kernel: [   24.374258] mt7530-mdio mdio-bus:1f sfp2: phylink_mac_config: mode=inband/2500base-x/Unknown/Unknown adv=0000000,00000000,0000e440 pause=04 link=0 an=1
Sat Feb 10 19:17:31 2024 kern.info kernel: [   24.389679] br-lan: port 5(sfp2) entered blocking state
Sat Feb 10 19:17:31 2024 kern.info kernel: [   24.394948] br-lan: port 5(sfp2) entered disabled state
Sat Feb 10 19:17:31 2024 kern.info kernel: [   24.402405] device sfp2 entered promiscuous mode
Sat Feb 10 19:17:31 2024 kern.info kernel: [   24.414853] mt7530-mdio mdio-bus:1f wan: configuring for phy/gmii link mode
Sat Feb 10 19:17:31 2024 kern.debug kernel: [   24.421873] mt7530-mdio mdio-bus:1f wan: major config gmii
Sat Feb 10 19:17:31 2024 kern.debug kernel: [   24.427355] mt7530-mdio mdio-bus:1f wan: phylink_mac_config: mode=phy/gmii/Unknown/Unknown adv=0000000,00000000,00000000 pause=00 link=0 an=0
Sat Feb 10 19:17:31 2024 kern.debug kernel: [   24.443005] mt7530-mdio mdio-bus:1f wan: phy link down gmii/Unknown/Unknown/off
Sat Feb 10 19:17:31 2024 kern.info kernel: [   24.472639] mtk_soc_eth 15100000.ethernet eth1: configuring for inband/2500base-x link mode
Sat Feb 10 19:17:31 2024 kern.debug kernel: [   24.481074] mtk_soc_eth 15100000.ethernet eth1: major config 2500base-x
Sat Feb 10 19:17:31 2024 kern.debug kernel: [   24.487693] mtk_soc_eth 15100000.ethernet eth1: phylink_mac_config: mode=inband/2500base-x/Unknown/Unknown adv=0000000,00000000,0000e440 pause=04 link=0 an=1

A stated by you the system is still connecting at 2500base-X even if the module is set for 1000base-X, as far as I can see, without any error.
My assumption that the module could have forced the speed down to 1000base-X was completely wrong.

Making a final recap:
- The module without the quirk is only showing up at 1000base-X due to a wrong EEPROM data
- The module without the quirk is working at 1000base-X in both of the 2 internal configurations
- The module with the quirk is only showing up at 1000base-X and 2500base-X
- The module with the quirk is working at 2500base-X in both of the 2 internal configurations

This module as is a GPON-ONU/ONT and is configured by the OLT same as FS GPON-INU-34-20BI and HUAWEI MA5671A already validated for the quirk.

Thanks for your patience and suggestions.
I remain at your disposal for any further test I can do.
I hope that with the above evidence the patch could be acceptable for both OEM and ODI vendor.

Sergio Palumbo







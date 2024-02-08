Return-Path: <linux-kernel+bounces-57619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 027DD84DB73
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BA4B1F26A31
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935FB6A8CE;
	Thu,  8 Feb 2024 08:31:00 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01olkn2065.outbound.protection.outlook.com [40.92.66.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB22D1D54D;
	Thu,  8 Feb 2024 08:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.66.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707381059; cv=fail; b=VPTV7DXNJg609IMh7xMlOl86da7KCCw4MERSp4XEz3AoWejnPss57/C2Mv+FI+lkuE96YyEe0/3rvpV2m2k2lq9TrO9p6aLqN/pfeHudzczqosHK+xJU4vUX2NzdW8lT7LBL8FiGUCIz6NM4S0qc1Zpg7FqO+tLkfKHcbkPpzmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707381059; c=relaxed/simple;
	bh=7IpiKfYKVacJ1t4P6O5c1ugnropKbaWyydy42TgHZkA=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=diLGKdy5KRaKsF6ERzYtNjuk03ZVMDX51e1e2pTzwVsxS9ad0kAKMmGlWiEZZu2HKvz1/tQbNm2wfPLg2S40LaSRpGTACNOX9tpgVQGEiaZURw1j8JnrI8TcJpPyP1Pvw0bIw145RgbCdeb10RR6TynxTi1pBJFc6KghvHRxXW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.it; spf=pass smtp.mailfrom=outlook.it; arc=fail smtp.client-ip=40.92.66.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.it
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KlJyaBGsMHI5cRJcQbDvjyux5EdM3X08g/Kvr9lOb4TTmCNIM9Nyj6p9Eo4DPG6jFGZ0GyhGLuGx3DfbIFBkdJii222/Odgp570lQqfkyv7SH0ieQsOg1B4CmyjECueJqrqu0OLVZhEDZ6pRVvbkyt4/tuIDgbvKEWFg6GJzGhD1H2a17HPaI4BwZZdA3e2HmoUaNLdNN13o22W4VpYWBF32MK9dFXU4o3tqv1WH4PUnRGMa1bxzHJkKJw/qD+cusQ0zxbqKP+fwjZVOPJ/tsEcG+IapWK/Fa79tLDxfe/2TB3w7gW3zNaUhl8a7tj3Ypc20jOj0v3aVsG0ofmpbCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KRStz896llpSM7qMGVKNvhUPpVQs/Yo1dv3hQf54n/M=;
 b=jxyHgQYXo1L1GrAQrHT1ioXBc1HGa+cRi/z+Z4lLHY/W8Ris4MepnrEx2vLwqqj73X83UoZ5jIRrFGPffd6fA8TuJqUmwru6s7VT/DvkpcJf9H+waI4qDd50/VDFLOYX6YPtG7dNEk5PRQ2PVdlY4DDBFryxlT73OHxu+OvM8P4oZZxKQ+jY6vCrHo/M2ZiKmlJlndOhkACGzXnh5lAEJFkdM80lkukazdv1Mk/ZPWXONiiyeCn2r3acztX5hzqdwi7G5s60JnNF9jvST1U8CvIFSyjIrw0o3Nwe/QMbRSSyrCyVk2+V81e36NU+ixf/+ms86EHjO6cb8pFN9D+Jpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AS1PR03MB8189.eurprd03.prod.outlook.com (2603:10a6:20b:47d::10)
 by DB4PR03MB9484.eurprd03.prod.outlook.com (2603:10a6:10:3f4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Thu, 8 Feb
 2024 08:30:54 +0000
Received: from AS1PR03MB8189.eurprd03.prod.outlook.com
 ([fe80::ffb3:3ff8:6ea9:52b5]) by AS1PR03MB8189.eurprd03.prod.outlook.com
 ([fe80::ffb3:3ff8:6ea9:52b5%5]) with mapi id 15.20.7249.032; Thu, 8 Feb 2024
 08:30:54 +0000
Message-ID:
 <AS1PR03MB818926990092981B0E09E60B82442@AS1PR03MB8189.eurprd03.prod.outlook.com>
Date: Thu, 8 Feb 2024 09:30:48 +0100
User-Agent: Mozilla Thunderbird
From: Sergio Palumbo <palumbo.ser@outlook.it>
Subject: Re: [PATCH net-next] net: sfp: add quirk for OEM DFP-34X-2C2 GPON ONU
 SFP
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <AS1PR03MB8189AD85CEB6E139F27307D3827F2@AS1PR03MB8189.eurprd03.prod.outlook.com>
 <ZbZn8oCiyc1aNPuW@shell.armlinux.org.uk>
 <AS1PR03MB8189B99C360FB403B8A0DD6882422@AS1PR03MB8189.eurprd03.prod.outlook.com>
 <Zb0t+zKHx+0wTXH5@shell.armlinux.org.uk>
 <AS1PR03MB8189D48114A559B080AF5BEA82422@AS1PR03MB8189.eurprd03.prod.outlook.com>
 <Zb1+p6FiJwUF53xc@shell.armlinux.org.uk>
 <f8cf41f2-4a90-4ef5-b214-906319bd82d4@outlook.it>
 <AS1PR03MB818911164FB76698446CFEDC82472@AS1PR03MB8189.eurprd03.prod.outlook.com>
 <ZcI+7grKa33oLtwc@shell.armlinux.org.uk>
Content-Language: it
In-Reply-To: <ZcI+7grKa33oLtwc@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [QwV3UvbXfYaYAIrFQf/fChZd8cpMpZQW9Sd48hqf06gsuQV3zjqF5kfMk3VF38D3]
X-ClientProxiedBy: MI1P293CA0019.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::16) To AS1PR03MB8189.eurprd03.prod.outlook.com
 (2603:10a6:20b:47d::10)
X-Microsoft-Original-Message-ID:
 <8b1a4992-4db6-45a7-9f72-f47b2069a592@outlook.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR03MB8189:EE_|DB4PR03MB9484:EE_
X-MS-Office365-Filtering-Correlation-Id: 998a1c6b-c4ce-48f2-d8c4-08dc2880437b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BXKPnuJxaClcn9e+NwTbX/mTxRWlqDqd7/q4Hd8Hm/cAzoLN2Uih+PnNU0EPt5ZsBwCZ5EBMt3fbbdSvzrEr+JdOq2J+wQ2UxIK/mYeYApjTrmS6bx44fD3LCk5WKv78niM4Xa8ePvTOAxv+ahuR+uitVv2izVket/vkkY+8CyfKIwSRQRYuehX6j3sE0XBBwDodQv62EMvdazSNd3LQ58JqKbhjw9II6kDKZJJdI5ETDYv4PQycSps+TOP0yWquFnULsPxALz0jwDYrUDLsmoQLG0bmbmu3/ThNnhFHf8tBE/wk5lxuFqtZ97o4GC6mEicD228Btzg1olqxO8Z+7g7miM5tNjCcO8cPFnycHzPIAv9hyjJ+LA2CzM58VSvIFO3TmaP5AMlqtScBn9LoU1RT/Sq1foWVsgPvQkofXdTzVeF0uJHHHTwPGHUGA3yxochQUeY9x8LYu8CWPODQ14MzmZd3kL6YGX+2P5yv04dYSpeGQUnRHKkC9a14c2+DGeuMP6B2d4h8wKVrZfpupQJEYZ+ShSzUvKlEt+16Rf65sNsrr9v+MdQnfwkNHgtm
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cHU2dFZVcG8vbzVOd3kyVDZDOEVBV0RPTzlYL2JoaEdGbWVLb2JzTVhKaGRF?=
 =?utf-8?B?SWx4QVBJb2ovTHFVVVRPVENHRnNYaWprRy83bW9TaFZuZ1pvVzQrdnVVcTQv?=
 =?utf-8?B?VkdMdHBPTVhpSnF0WUFIejdiWUZjOVk1WXpmWU5NTENIR1RLVmZPbGp1RUYr?=
 =?utf-8?B?Mk5PSllWajQ2OU43VjNLUFoxNFVLbnFWRDFVSFZVNEZFQ1VJNldUVUxFRWRT?=
 =?utf-8?B?K2tMM2tMdHlTRnJiYVF3Y3VSTUx5VmVES1VmeFJxYXh1NkdrdkxiNmttSjA4?=
 =?utf-8?B?VGhiQW9ab2pDQ2JyaldWV1FCUjN0RDJGK2x6OHdXcUUzcHp6U2pncytNRTlI?=
 =?utf-8?B?c0FvU3lUTCtRVHR6QTlGTUgxSE5CMlZPaHVvWUdQeVFvU2VNYWhkVWNsbFd5?=
 =?utf-8?B?L0d4dVlKdXhySDI0Y2V3Q2pBTU5uTkViU0hIa2xkYnMrNEp1K3pBUnVvQ3RT?=
 =?utf-8?B?MWZWZFVKNnNTK2N3SzJPcEd4WDcwa1BwUlNYd3BtRXZsZGhhZ2UwOG5xZCtI?=
 =?utf-8?B?L1dQSHVTT2NEUTd2dlg3NDZ3MjFTRlNiRUp5Y082Qzl0V2UwV0tLZmJhK1N0?=
 =?utf-8?B?MFZUVnBzNVFQMDF5dTdsdk9KZ3Ftak9TbkhlRi9JSjZlaFJXay9hOE92cGpJ?=
 =?utf-8?B?bGZVNUMyVENtVFJiOFJ0c2taRzJCY2M3WmNKNUt5UVBMQldoUHh0b29BME1a?=
 =?utf-8?B?eWVrb1NmdzhJVEdhTlpoYk4yUmRpTzJMMndJZzJmNE96MHJXUE9lV0tGa2Rn?=
 =?utf-8?B?RTF6SE0zWDR1QldaNjd0YU1jejFMeG5HRlBmTFFYS29XbTdCRkhMeHl3d0Jm?=
 =?utf-8?B?M2hhbHp4NTJ4cDVvdW5BazFES3lSQXJUd1RlSzhuellhakpIMENWQU1SUmZm?=
 =?utf-8?B?aVZqbm9UTUhVbE5SaWZmNlNZV00reDBQTzZsY2RJNmVVWlpweVRJb2xGK0tC?=
 =?utf-8?B?UGZLZzlTS2ZOZ0I3WEZmK1U4bkllQ0hxb3BzZVU5Zm9LQVNhbU9UM3JWWFZF?=
 =?utf-8?B?VXRJbXRuaDNmMGRzcmZUbTUzTHRJOGUrekRReFByMmZWeDNhTVdsc1ZYWlZj?=
 =?utf-8?B?cUJ3c3EwaVBjSEpuYTJWN1lhdnlmSTdzNE56a0EvYWlyOStBZlBsenZ5K1Ar?=
 =?utf-8?B?WjJlc0RYUVM2TlJOZDVLZzY2Y0Z3b2RUL0hrZFVOU3ludjFqT1lNb1BLb0VL?=
 =?utf-8?B?MFJLdGZTa0FSeEczanZiSndieE11d0ViUER1cjdFb3gxYS80UEMxVnViUzFX?=
 =?utf-8?B?ZHlmd1E5VjM1YzRzWVVGMlRzYmF2OGFDTHVpeS9SWE5oeVdyME9oMWlvWWdN?=
 =?utf-8?B?cjB6Tkwyamk4bHpjK1E4L2ZiOGx2c1VBbW1yMG9tRDVhSFdlRkZRUkJNblZl?=
 =?utf-8?B?azhvUTlyVjRaM0VjckJDTVI3MTNLZXhGQkJBQW9iZU1UdklTRzI0TGJGWEZO?=
 =?utf-8?B?elFCQW9zOGZYUVlPQkFjY0h1dnhwV2lyeURkMWdpSUtoaEJxOEhUQU5sbWdI?=
 =?utf-8?B?MmYweXBORVZrcXhHK2Nmci9UbUlneGxYb3llajNoeVpkYUFTcDdDZFFDVkY3?=
 =?utf-8?B?RDlDMVRQbi9GNU9MZ29sMjg1bmRLTlIrREFuU0RRcS8xM1VsdEVYazMvb1hZ?=
 =?utf-8?B?ancreE1rcW5aYThVZGswZHVlRmpocUt4bVY0eVliUHVJeDhCRmFPYWRiSCtQ?=
 =?utf-8?B?MFV6QXFYS09keXhsRU12S3NaNTRhNy9lMjR0ckp4QUlZa0UzQkZNWE80WHNR?=
 =?utf-8?Q?quLNVAgSZJSuzrDTbc=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-76d7b.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 998a1c6b-c4ce-48f2-d8c4-08dc2880437b
X-MS-Exchange-CrossTenant-AuthSource: AS1PR03MB8189.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 08:30:54.6780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR03MB9484

Hello Russell,
I did the requested test

- host that supports 1000base-X and 2500base-X with your quirk (Banana PI R3)
- SFP inserted with LAN_SDS_MODE=1 (DFP-34X-2C2

and here below system messages concerning sfp:

Sun Feb  4 00:35:06 2024 kern.info kernel: [   14.686771] sfp sfp-1: 
Host maximum power 3.0W
Sun Feb  4 00:35:06 2024 kern.info kernel: [   14.692137] sfp sfp-2: 
Host maximum power 3.0W
Sun Feb  4 00:35:06 2024 kern.info kernel: [   15.029727] sfp sfp-1: 
module OEM              DFP-34X-2C2      rev      sn XPONxxxxxxxx     dc 
230912
Sun Feb  4 00:35:06 2024 kern.info kernel: [   15.068806] sfp sfp-2: 
module                                   rev 1.0  sn 2307210038       dc 
230721
Sun Feb  4 00:35:08 2024 kern.info kernel: [   22.767328] mt7530-mdio 
mdio-bus:1f sfp2: configuring for inband/2500base-x link mode
Sun Feb  4 00:35:08 2024 kern.info kernel: [   22.777097] br-lan: port 
5(sfp2) entered blocking state
Sun Feb  4 00:35:08 2024 kern.info kernel: [   22.782390] br-lan: port 
5(sfp2) entered disabled state
Sun Feb  4 00:35:12 2024 kern.info kernel: [   26.970294] mt7530-mdio 
mdio-bus:1f sfp2: Link is Up - 2.5Gbps/Full - flow control off
Sun Feb  4 00:35:12 2024 kern.info kernel: [   26.978403] br-lan: port 
5(sfp2) entered blocking state
Sun Feb  4 00:35:12 2024 kern.info kernel: [   26.983623] br-lan: port 
5(sfp2) entered forwarding state
Sun Feb  4 00:35:12 2024 daemon.notice netifd: Network device 'sfp2' 
link is up
Sun Feb  4 00:35:08 2024 kern.info kernel: [   22.834307] mtk_soc_eth 
15100000.ethernet eth1: configuring for inband/2500base-x link mode
Sun Feb  4 00:35:08 2024 kern.info kernel: [   22.846214] device eth1 
entered promiscuous mode
Sun Feb  4 00:35:58 2024 kern.info kernel: [   72.800035] mtk_soc_eth 
15100000.ethernet eth1: Link is Up - 2.5Gbps/Full - flow control off

sfp-1 is linked to eth1
eth1 is running at 2500base-x

Same result with ethtool:

Settings for eth1:
         Supported ports: [ FIBRE ]
         Supported link modes:   2500baseX/Full
                                 1000baseX/Full
         Supported pause frame use: Symmetric Receive-only
         Supports auto-negotiation: Yes
         Supported FEC modes: Not reported
         Advertised link modes:  2500baseX/Full
         Advertised pause frame use: Symmetric Receive-only
         Advertised auto-negotiation: Yes
         Advertised FEC modes: Not reported
         Speed: 2500Mb/s
         Duplex: Full
         Auto-negotiation: on
         Port: FIBRE
         PHYAD: 0
         Transceiver: internal
         Current message level: 0x000000ff (255)
                                drv probe link timer ifdown ifup rx_err 
tx_err
         Link detected: yes

Please let me have your comments.

Sergio Palumbo


Il 06/02/2024 15:15, Russell King (Oracle) ha scritto:
> Hi Sergio,
>
> I did ask for the kernel messages from a specific scenario:
>
> - host that supports 1000base-X and 2500base-X with your quirk
> - SFP inserted with LAN_SDS_MODE=1
>
> What I expet to see in the kernel messages is that the system will
> use 2500base-X, and a failure.
>
> You claim that the kernel will link at 1000base-X. There is no
> mechanism in the kernel for this to happen, and I believe that
> if you look at the kernel messages, this will prove my point.
>



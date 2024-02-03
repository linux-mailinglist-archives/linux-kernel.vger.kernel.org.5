Return-Path: <linux-kernel+bounces-51006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B058484EC
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 10:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 600DC28E18A
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 09:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6AD5D461;
	Sat,  3 Feb 2024 09:16:58 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04olkn2087.outbound.protection.outlook.com [40.92.73.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195315D720;
	Sat,  3 Feb 2024 09:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.73.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706951818; cv=fail; b=TvyLsrTofsSM+Vlv4nlIyeW10YZmhP9vW6R9qFHBYNY+dNzlHeMEL3YK0gtlBSeUk3/bMQAuZrLkJDI/+m1SyKrRpykL6xT+tkN5u4dqKsHC/9awT9EVvQ+hldTUd8egkwTaoBnf1iMGtOXZ87zglprQy7Hm3szIJbSyva00mnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706951818; c=relaxed/simple;
	bh=55pAwv2Ef5t2iTEevbGIvayNImdOe4pT+Sa1xxWKuOg=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BzorG2sQFUYgnfSU2ztlMvzjDLoz1bfLb8M3Brmk22tWmxxpJVBOSVQBgNxQfn6C6pvmfRzshW5OK5IHHLTOdTWIQmAc1vSQIOdS8FvDYDbGfrdgYNsqJX1yYyFBqUvapjKekZ1yWJhh9fpOt5r/j5Iq+CpMwQyCgb4wB3pJXqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.it; spf=pass smtp.mailfrom=outlook.it; arc=fail smtp.client-ip=40.92.73.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.it
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hNOZ7/CO97bE2SEoFSUy+Asw5PMkFcyrZdUsE9l0OQ51GQrRmTVQwdqcEtH2TnE4B0Fexm5OHWWw4xjy6wxs1+aQXK4c/+3pLROgVaotX7h5fdmaxmuKbwtWasFZ5nyiUZ27V9WSCUDHyNEwwcftJpaWvaITeUaDS1ETG4m4DppQqW7ziIT8Ne2ot/unzzBpNQBtlpFcKv3QKMuUE9YiH3yQKaVAJwc7Nx6lip9a5V+pgd5KduG7fBTvxTSeZr7omvFm/yWROg/96Az8APwVg8tRCFEIXca9u3LY4GbZlUxUTSUn0dp2LadXGKOiSLkkQZV97bRn3DOZ77FJXY+UCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uuMqsTVR6f8s2b00XMsxeXCsnhsQOWg3MY2IYVRiluk=;
 b=AZMLnyytVnQQVsnHuC3Ws/Bllaf8BvotaEUjc+xBtrMlhWuN3SM8S/SxbHphI3zu8Tp6XFkEzQN/SvZxzqirnezFlDet2W80ULCa7J7rNTaW3a25ZdVkUjVAPXLDqJdUmu1qGwEnKt1wa9DizQWGMFNf1y/2yaViafE3nDHFCxct+Q0PduXuV0pFIv2i/aFxo+ncLRip5XevOGxjpJF6dYgMxiZpmpaKJRLW57VxiJl02qp9Afe2mS/JlJRWzfMr3eNRDttJjWV7zrPAx/VnXfV+XPCppivP0CX+avadGEBsxhlid2DNJrG7JtdheZGE7AoR1Whht89vvGKvmy8EAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AS1PR03MB8189.eurprd03.prod.outlook.com (2603:10a6:20b:47d::10)
 by AS2PR03MB9718.eurprd03.prod.outlook.com (2603:10a6:20b:60e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.30; Sat, 3 Feb
 2024 09:16:52 +0000
Received: from AS1PR03MB8189.eurprd03.prod.outlook.com
 ([fe80::ffb3:3ff8:6ea9:52b5]) by AS1PR03MB8189.eurprd03.prod.outlook.com
 ([fe80::ffb3:3ff8:6ea9:52b5%5]) with mapi id 15.20.7249.027; Sat, 3 Feb 2024
 09:16:52 +0000
Message-ID:
 <AS1PR03MB8189C3FAA5D3AC95CA1F5D9D82412@AS1PR03MB8189.eurprd03.prod.outlook.com>
Date: Sat, 3 Feb 2024 10:16:47 +0100
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
Content-Language: it
In-Reply-To: <Zb1+p6FiJwUF53xc@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [HHC8CRkMwpkwfZe3fPvE5igbpSRxepMKF06ndDOAi+HNRzKvZGgu7ZLVtDzdedFK]
X-ClientProxiedBy: MI2P293CA0011.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::11) To AS1PR03MB8189.eurprd03.prod.outlook.com
 (2603:10a6:20b:47d::10)
X-Microsoft-Original-Message-ID:
 <f8cf41f2-4a90-4ef5-b214-906319bd82d4@outlook.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR03MB8189:EE_|AS2PR03MB9718:EE_
X-MS-Office365-Filtering-Correlation-Id: 9531a97c-8714-4e5e-e411-08dc2498db76
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uNp9AfTgvIOytDAocBRtLedjfc65adIkzre0Ot3t0xWHkdseB/LXve1MfBFVVHeihOhz6qpvV1BULmuL4/U/UUGWa4Csr/S+tZcKHyLnuj/8sd05gTCAFcQGFFJ9gt4Yl+5bwM4Cb7zLHXGiLBIIL47hY+wO4+NPA8JeSAPatvOgnks3sQaNWWCwxIHbcIjFLQnbpmLIlH77o8YJwDPdZC0Hxe62JTHyFXWwgss6K4zppZf7RIKPtwUKHFijUaMmY6Tbj+VgaxOM/787h7Ek4SHFlP/MV2VBdufXVkm88cAUytbyPSBmLtmaR8F48zXCPHWUip0kk/AQxBfrnZOghSsDDn6iqhfR2B7mvAb49IOeepnV/Kgq6zmKGdJZNHwORwRE/PjqxODo/q1+x3wAHNFdyvvEZvhrpad1fEg1QGuvO+x/7pbgQnwYlHUPm7czhjCgRr3U5PMjpGU+rV2pshuFf1GFikbkGeCR6zUkaYTAL1rGb2tRThC20fJtGX9xLQ63a6YFo/xl5UzOJTHm/x++AiSGM/wRuyogRKW4m8m3cQb3GSzY8+1GCk7bG97G
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RnpNQnBGS2lwUFpyUjRVTUowenoyeXpvM3poZVg4VGlhaitNSXQyWVRNMzVx?=
 =?utf-8?B?aGVFbTZMTVFhZ1dTd1VxWFljd29EUkpTN21mbFRidnZqQ2hGclJ4L1ZBRW9Z?=
 =?utf-8?B?bkFYMzR1RW1zeXc0UVNaS3VwcXU5QmJnUWk1OFVTVzhmWUpXcEdJa0NyV04y?=
 =?utf-8?B?Tm8xQm1GcUtxL1JCcWFlZExDNjRGTmFTZDIwWWRKWWIveEQ4SzN5VmszRThK?=
 =?utf-8?B?UlVKcWQwWit0S0VEd1JkOTRJTHhvVnB0NG5nZ05pOGlIQ3lEUDZidzdMbHZh?=
 =?utf-8?B?VHk0QVJFbHlkeTJ1MENSaFlRZVZPRUVxK2lZcmpIWnpja0dMTG9CVVF3SXI1?=
 =?utf-8?B?OVVFNFIybEZWR1UyRnlGY2s5VXhFQnNPSzJGZXpSMnlwQUpUSk16ZlpMK0Vp?=
 =?utf-8?B?aWNweVYxUHVHWGJBaTk2YWtlaGJNaFh6OHBiODhDR2pSOWRiTWJ1S1MyVnNB?=
 =?utf-8?B?Ri9JYkc2eEF4ZkVFcE1Ld3Y5L2grUWU5M0ZBeGtZSEd1ZHovTGMzR0dLNTVD?=
 =?utf-8?B?d21oU3JKejNKZ0QvSSt2eXJDVE1lQXlLMGpzZzJmSFNHQVA0S21rWkZQdjBU?=
 =?utf-8?B?TGpMcDdONzVuWDdDRExVZ2RpQ0JwTWJmUXAzc1dPV1o0QnhPQ1N2NDZvRDFq?=
 =?utf-8?B?bVpEeGRmQnlhODg1RWw4TExvQ3FnN3Q1QWNOU0lreWFVQlBucWNZU0QrTjdF?=
 =?utf-8?B?TDhwMWhaZTk5NEpXVk1DZmU3QThsdlk4MEdRbGE0bkpVYzZOOXhuNlNKeU9Z?=
 =?utf-8?B?cXBNVkN4VlN1c2greHJDTTBXMEFlazc2T3ZFUXY1NDBuVEpFY1lXSHlHSWdH?=
 =?utf-8?B?WFc4QktxaDJVU1ptTDRYaWptdlorbHBXbkdRQ0NDcUNBa3p3ZS9qaG1xdVNU?=
 =?utf-8?B?cExyaHB2TzhZYjJ4czNrSm1vdUZnSUZHbGxFdHRQdW9WUi9uT2lnTU9XOCth?=
 =?utf-8?B?VEJZZGRKbFdLU1c2K3ZHNStoL1AyeDlVeXVNVUNsRXc1OFZvRkV6aFc5Y2NJ?=
 =?utf-8?B?YmFzOWNDQ3FTRDhyd1d2Q21rblNxY2NwSHJ4T09zNitkUVBsVFpTT0JiNWNj?=
 =?utf-8?B?RWZ5M0YzWUp5c3ZBV2RhQjdhS21sSnlRNHVzRkJFa3NJeFp3ejBnS2U0QnYw?=
 =?utf-8?B?ZUtoLy9VSm93WDFLeUxnM2FpN0o1M3ZMK0kxZFFCdHRIMjFXMUFSa05TYUhS?=
 =?utf-8?B?S3p1aUdHMTlDb0RSeFdldzYyaXNEMWlEV1pLRjJ2N1J5TTJtNlhQRU5qdzB6?=
 =?utf-8?B?UFM1RzFVeGJZTzJ6K1RnZDNuUGhMWUwveS9qNkIyOFl5Mmc1ZFE0UTdXY3Q0?=
 =?utf-8?B?ZlFOZlEvYlE0bTA3Z3VOSmJZZmFUTzMwUTBkQWZPeEFXeW5aN3MveVBpV0J4?=
 =?utf-8?B?WWs5Um9tcEZEendUVms5M0U2U25yQnAxclBSdVJ5eG0vSjBBTldGWjBhSHNi?=
 =?utf-8?B?TEFlRFJibWZINloxRFJnSTY2V2tEZTlHWkpIai8rZVB0TzdDazBRRmdsN1JV?=
 =?utf-8?B?NEhrMjlMdHI2VlhLREtYZHZGR3J5b05JZDgrelloOVc0blJkcnBhRDdGQ1cx?=
 =?utf-8?B?bTIrdUNpTmNVa3Y4dHo0YWxsQmVpb0xXcU9yTHVyODRBSlpQOGFDQXlPMm9X?=
 =?utf-8?B?OG96MTJHTzhWd2JGc1BPUDkrTkY3TVVLY2xUbmwxRTZNS2o4U0QvdURYOVRt?=
 =?utf-8?B?TjhPejZ2d2JJM3VIT01qTllkR3UvRjlHYWdvcjdRTTk2T0haWklyVmc2amJj?=
 =?utf-8?Q?5zqTmHr4d3IHFq//Hc=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-76d7b.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 9531a97c-8714-4e5e-e411-08dc2498db76
X-MS-Exchange-CrossTenant-AuthSource: AS1PR03MB8189.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2024 09:16:51.8103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR03MB9718

Hello Russell,
I understand your point on third line, but I quite sure that it is 
working at
1000-X because with LAN_SDS_MODE=1 makes the module to show up
at 1000-X to Linux host, but now you made me doubtful.
I'm now out of home and cannot do this test. I will test it on monday 
evening
when will be back at home.
Unfortunately not so skilled to:
"Add #define DEBUG in phylink.c, rebuild and run that kernel. Try
that exact configuration. Report to me the kernel messages."
Would it be enough to check if using LAN_SDS_MODULE=1 with the quirk, the
confirmation that  ethtool will report 1000-X only and speed connectioin
reported by ethtool will be 1000?
Will let you know the result of this test.
Thanks for your kind support.
Regards

Sergio Palumbo

Il 03/02/2024 00:45, Russell King (Oracle) ha scritto:
> On Sat, Feb 03, 2024 at 12:18:13AM +0100, Sergio Palumbo wrote:
>> Hello Russell,
>> thanks for your  explanation. I have to say that:
>> Module default is LAN_SDS_MODE=1
>> Host banana PI R3 supporting 1000base-X + 2500base-X
>> I would update the table as follows:
>>
>> The current situation:
>> Host supports		Module		Mode		Functional
>> 1000base-X		LAN_SDS_MODE=1	1000base-X	Not tested, but expect to work as 1000base-X + 2500base-X
>> 1000base-X		LAN_SDS_MODE=6	1000base-X	Not tested, but expect to work as 1000base-X + 2500base-X
>> 1000base-X + 2500base-X	LAN_SDS_MODE=1	1000base-X	Yes
>> 1000base-X + 2500base-X	LAN_SDS_MODE=6	1000base-X	Yes (host forcing module at 1000base-X)
>>
>> I suppose that Banana PI R3 host is forced by linux drivers
>> at 1000base-X so first two cases should be same as second two cases.
>>
>>
>> With the quirk:
>> Host supports		Module		Mode		Functional
>> 1000base-X		LAN_SDS_MODE=1	1000base-X	Not tested, but expect to work as 1000base-X + 2500base-X host
>> 1000base-X		LAN_SDS_MODE=6	1000base-X	Not tested, but expect to work as 1000base-X + 2500base-X host
>> 1000base-X + 2500base-X	LAN_SDS_MODE=1	1000base-X	Yes (module forcing host at 1000base-X)
>> 1000base-X + 2500base-X	LAN_SDS_MODE=6	2500base-X	Yes
> Your third line is just wrong. Given the capabilities of the host
> _and_ the capabilities of the module adjusted by your quirk, phylink
> _will_ choose 2500base-X _not_ 1000base-X for that. With your quirk,
> there is no way for Linux to know what LAN_SDS_MODE has been set
> in the module. Even without your quirk, _unless_ the module updates
> the EEPROM contents which is unlikely, there isn't a way to know.
>
>
> Adding a quirk that makes it not work in its default state is
> technically a regression. We can't know whether people are already
> using this module with Linux in this state. Adding this change
> potentially breaks users setups.
>
>> I suppose Banana PI R3 forcing Linux drivers at 1000-X when
>> module in LAN_SDS_MODE=1 and expect it should work alpso with
>> hosts at 1000base-X only in LAN_SDS_MODE=1 and LAN_SDS_MODE=6
> There is no way for Linux to know what LAN_SDS_MODE the module is
> in.
>



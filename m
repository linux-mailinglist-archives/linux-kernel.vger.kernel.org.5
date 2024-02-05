Return-Path: <linux-kernel+bounces-53261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9B784A2D2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D7711F275B9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06ADA4878A;
	Mon,  5 Feb 2024 18:55:57 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2011.outbound.protection.outlook.com [40.92.89.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085B1482E4;
	Mon,  5 Feb 2024 18:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.89.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159356; cv=fail; b=Z076QwkWJ6js19bVe9YpUDFSsO3raOvy9CL77Jxaz9RXc823pG9HzCMrVBxCJUoQeK/vKwui0oDFhGIX7+uRO8qYdd7gnWp1MXTZnhsJmlHzl4iC8xkEcoi0rB0Kciw/YsqZ5HeQT2nz5Kevfv2dDQ+Y4XmPXCvgS/k05eJf9M0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159356; c=relaxed/simple;
	bh=nm4nx7UII0sZtu4X6UE1liJIHpvEgRFve3vct/ks2RE=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=flU8TAMxUe2SYJwhe1QyynW4PU0llY4Q7EI7INuXUFlosU56ZrKK5tx5ypwly0GPMITYacIm2zzw2bijWiAETisfQV+6ou6O5h+3cqhHefYzov6CzVzqBRByCDcEVQm53EIi2oyzB7LRESofksCsWE3SpYGcNzrbGV9txst2nes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.it; spf=pass smtp.mailfrom=outlook.it; arc=fail smtp.client-ip=40.92.89.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.it
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X2fiW2ELQffd47kdCKqC+vO/EgB1kIdtdsCWbt7cVHq4rmkTd5rMomNgo7X62FjOK4Dfi88rklH9RI6Qi38S+9To82q2nKia86sbuFv7AX6vRj6epd4s84fx1VHNaKtJe+B1X8NzRjzCXA5d4cAg7/lCk2cKMHOKazr7KOh4/FHxQLlUByz97j0o88f8YC7JJfISAiKuQpdTZ08qwgl73RRwH3FyhBp88m7AWIObwacpRzdvRPPpcdy3ZmjdfyDq10Q60Wa2sMeYCeirb1s52zzFKGunxtdgh9avydcU/5Ewln7OGGDXMeBjdhKA1J6wamFK3YUXJvWSHUZjwu8FCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=piJNI8acByYRLLUjHYqdIPBwuzco4hbyGgWnYUrEfc8=;
 b=NS+voWQg6Td28s0TJSAFi+Q7hHpMSl7NULXPtBZxSFfSoX6b2KURY/44tHMUb15il/oFRE721pBLqhAhJk6AxtMsuhfB82Vumui+zn6L/66oU+eBzsTMnyHg/lVn8QIE1cf+nuUqEIVwUDL8Vx3Twps9fjpxZxY0h0tVWyXD+va9M9sbDIV6iBPMOIhyGBKg4OHZdcEGtuhC+T6pdF8L1F3gng/27wcHKnAZPZqLELY+THkA7RlYXAZKFEmBuE2ZLP18kOB9063MLqcixJd9m87hciGMQ4JCpqP+/1VqVJvinTxE40lyKGjTwhq4K2GLOX97u+JpXhxs3FPhI2caXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AS1PR03MB8189.eurprd03.prod.outlook.com (2603:10a6:20b:47d::10)
 by AM9PR03MB6914.eurprd03.prod.outlook.com (2603:10a6:20b:2df::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.31; Mon, 5 Feb
 2024 18:55:51 +0000
Received: from AS1PR03MB8189.eurprd03.prod.outlook.com
 ([fe80::ffb3:3ff8:6ea9:52b5]) by AS1PR03MB8189.eurprd03.prod.outlook.com
 ([fe80::ffb3:3ff8:6ea9:52b5%5]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 18:55:51 +0000
Message-ID:
 <AS1PR03MB818911164FB76698446CFEDC82472@AS1PR03MB8189.eurprd03.prod.outlook.com>
Date: Mon, 5 Feb 2024 19:55:49 +0100
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
Content-Language: it
In-Reply-To: <f8cf41f2-4a90-4ef5-b214-906319bd82d4@outlook.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [QcFesF0ZzyPN8PWj8O4EN6Q3L2XkOi7Bownmn36wnpOf9dYyESbgUwwgND0EfaE5]
X-ClientProxiedBy: MI2P293CA0015.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::9) To AS1PR03MB8189.eurprd03.prod.outlook.com
 (2603:10a6:20b:47d::10)
X-Microsoft-Original-Message-ID:
 <3b08b468-42a1-4668-bcb5-5ab7d2a35a4a@outlook.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR03MB8189:EE_|AM9PR03MB6914:EE_
X-MS-Office365-Filtering-Correlation-Id: 15390332-2fdb-4638-3daa-08dc267c12db
X-MS-Exchange-SLBlob-MailProps:
	AlkLxVwsndlzyWWAZDSMMWV06JcxP2VXEiQagEbcTVQ4OvNPVOEW7NW5GIZw47c78c0nEGhvh3naIXS4DG7zST96ZiIulnrFEP7sbfgIKaGLcMljtctBSr5d5rXfjishePghkQkXFjmmEJv7etwLgvmoocUpkqU0hCmNOsNPr37yZbZOh61Ai8/l49h5FiZBDNV4OD0gQou6v1Bg8UdfaC4ptF7/JlipBgn1LlZhc6vjECH6kL0+RnnjvJ+zVyb1FvlScKA3CyWUY0BvFB7+p7gu7L+S/sNvlLRNvkLnOnnV62CKQiHKYkgmpz5kozUVyljwvbuQKq8rWyt//vTG1M9B3zIjd1wDQl+NJqTbowJzqSCD/YMcgsz+q83gjNnK7cvuEWrNzsx41+8j+AxMkDQ0pTXyH8CG7Wj86gB3jg92MjMx2vWkBtmY7kth6AfSc8NIDrubjycBUWLV7diobgzwVXQH3PHulNBQxN5hXgMk8X5/LWJVZcxaIIUkIJufwUcfrGkpKcU8yU58UmzIuXg3bDxMym2gVo8MI8vnyLXCRkh/DrCXlD98xD8NZBeCxQXeNrkO0DBH2YGkDWIxxxUXSETb3jdKQoVREebSbjefitQVRrN01vgw5ACM00zPjK0glwUX+a+U2YYOY5NsHcjnJ8TN2Nmr+wWyg3OUG1Km4fez5LhLwFG1hsOuZa3cckw4WGSib66zli9JC2NL2mxQmm4I7wF/x7GFnOs6xktsht1HdCjmlLbayBACkk0VVfxo2pwun0IyPRcXP+BnwXSHsQBbwb3B
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wN42qsXznBgMmO4eLLctwYmeKzMc9YXR5G07pq7ylh71th2NeZSI/lV7SAOtQSITMk5mDIKz65NKtvtb6RekuA2UZzj9w70HhJZOPXmLFkihK1zCjl4u4+XFsb7Rv9vSax0o2157sPPRsVeUy8pGyLNFkzsf+GfFpI3uJO+3RBsnMjf6wvxQQPgonXtEuJClnL13slEUIiJD+2hrbQozPNs5tErEcUPJeEf/XTRl671pOeHsG5Y5QSFMhJbcTh+uBGhMKg4vaU75N+qzECMjP8hXbff8mayCkrB6FQu5iFB4hmf46Qr6CiA8wqyrnC9cPV8Tqx3l6R4Nv87GGIHPLX+b+qYi4FIXZkj1+SYSTBWFBrlox3LvLFFBQpxt4EO84CKNP6qtsxzF7RzbLnS1eNOaLBLyX8eWem2v6Tvp6oR9fezsKGgHEICE1avHJMk3Uj/+BVDNLY+Pd1cCI0c6DW9c4ezWaEWI8mEpn0IMCRTh2eEvd0zoOq3HTL//Ivv+YBwTSbro7l4AfomDgvdfIb0MIP28qwWFhiz4BhTl5+IImSGbym7VLr9FK0Ke7o8l
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WmxNQVowdVdYVTZsMzFwM2FreHVjK0lQcGhTZTVBQXFwQWNpclpQTC81c0p3?=
 =?utf-8?B?U2l1QjhzUTBSYTRuQnZMSWxlUXc4S2JTNEp0ZzZmYkV0STBNVCtFcEJjMU5y?=
 =?utf-8?B?bnpkK2IxYXJycEg4aEJ4Sm1TZ095ZThNWWl5Wm01MUJWSEJxUHQ0WnRhYkgw?=
 =?utf-8?B?MGZHMDE4L2pJN2FJenFGOEFaWnJnYS9JV0dQR21aWGoxMVNvQjhJWENMUE04?=
 =?utf-8?B?SzVUSWJIOVl0eTdzSmZhbUIzRHBZT2VtdUExdjErUWYrLy9sSWluc2ZIZjRP?=
 =?utf-8?B?Mk0wRkw2MnYwc0Fab1dxV2pCQ0tNUU5vdWwyUVczUHNvZy9MTWJCL2VuT0RB?=
 =?utf-8?B?aHpScEpvbkZKWHBEbER2Tzl5SzRTSmlpT0JuL0tsbE05b2FaVjA0cVB5Mnlh?=
 =?utf-8?B?VldDam9RTW9VMVNwTmllWHdIcG5aZUx0cDNoaEpOekh5SGhxWThDSHRTaExv?=
 =?utf-8?B?emk5QUpxbHhCTjM4R0V1VFBXNGJiZWdDL3l4V0ppVHhYNHZ2dnZlbEwwNHY3?=
 =?utf-8?B?SkFsWnhDczRqQVdDMy90V05oWHNWMFV2ZmZWZkV4ckNYUG9BZGRwNXYxc2RQ?=
 =?utf-8?B?bWw1MWFRVVdKcGpxOW9uRVgyWVpOYTVWWVl0dDUvVG5WbGVReS9veGtWM0xy?=
 =?utf-8?B?aUN2T3RkRUlQSGkyNDNxRnlkbDgrdE56UFovdDREaVE2allhMjloQlB0Skdi?=
 =?utf-8?B?cUVCKytRWTZsVS9YQzRHZzNrUVJpd0pRQjZSRWQ2SWorLzhUTXhKODN0Z3gy?=
 =?utf-8?B?MzFwNmluYkxiSForaXJ4SS9WNzhMVUtzRnljSzRvblZ0c1dUN21hT3Y0bkNx?=
 =?utf-8?B?RjVZVXZkaTI4S0s3aUt0NHNiUHVEeWFoRXdILzZnaFFUOGhCc2ppcS80OVJ6?=
 =?utf-8?B?OUVtVSt3SGEzYmtEMExnUXhKOU03NGJUa2t2eUNabG5aTUJ4N3NJNWd5RHNF?=
 =?utf-8?B?WDIxMkc3b0dCbGVDOE14eHZnWUVXWFlCR2JITy9lQnFQUDZJaFRBTkVXVko1?=
 =?utf-8?B?cStlNmsxS3YvbnVLVGU3SlVpVHZkRjBrUzBKWEFYdEp1YUpabDA3ZzNqR0dN?=
 =?utf-8?B?LzFReUZPb2JrcjE2b2d0TE8zcWVkdEoraWpENDBBb044TWdlbWJUNGZaRlp6?=
 =?utf-8?B?Q2ZqZWFPcVhsUmYzOTVnZi9hKysvMy9PL1c5TlVQa2FaZUI2M29QcXBSMmJG?=
 =?utf-8?B?Y0xvZFRzMzRnR2JqRWNtMVgyb0NGU1FxektreklkdC9YcHNyTk8rdTZhQ3lK?=
 =?utf-8?B?ZTVkL2RWd1k3TzNVZEpxd0ZBaHhDYjdBYkVKM2crZDVXSjhpcEY0ZlUxSEJY?=
 =?utf-8?B?SzBNbFEzeGF3bDViaWtYSndpR2JaUlo1VEQyWXZ5eGlSajNQVEJZaVE1Y0ty?=
 =?utf-8?B?UGdabzgyM1FLd2F4ZitPMWtwTkVrZm5iNkN4c3kraklJMFkrMHIvbGJTcTlG?=
 =?utf-8?B?cXpyOXozSnhTSlJBVTFOckc3WDZUaS9ZamZCbkdxQ0tCWW5WVGErUk51Y1NZ?=
 =?utf-8?B?U3k3dHZIYUlSQTc0ZXh3WExOb0FIQ0dBUG5HTGZMc3VFbVdqNGlrd3RIa1lh?=
 =?utf-8?B?OSs4YkdGQ0Z3MUhhUWJIQVdXNzZDck5uV000MnFLdVV5dWF1d2Izc1VyT3I0?=
 =?utf-8?B?WmxSeTFVUEh2MjhIMzBUbHpIeHhaNE9RRGx4L3RvUmlwRG5WZE51NWZxVW9D?=
 =?utf-8?B?OHBoMmZZSnBZcENxNSs1ZzNaWlh5aTdYR1hiZVFBZmM0ZXlHWUZwVlVOWVV3?=
 =?utf-8?Q?2/uV+YP70aCQd6wKn8=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-76d7b.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 15390332-2fdb-4638-3daa-08dc267c12db
X-MS-Exchange-CrossTenant-AuthSource: AS1PR03MB8189.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 18:55:51.6304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB6914

Hello Russell,
I back home and did the test for line 3 after the quirk:
SFP module still showing up
         Supported ports: [ FIBRE ]
         Supported link modes:   2500baseX/Full
                                                     1000baseX/Full
         Speed: 2500Mb/s
         Duplex: Full
Probably auto-negotiating at 2500base-X

Tried to change speed to 1000 using ethtool, but retuning an error.

However taking in consideration that without the quirk the module
is working at 1000base-X with both LAN_SDS_MODE=1 and
LAN_SDS_MODE=6 on my host 1000+2500 there i no reason why
it should not work at 1000base-X with an host only supporting 1000.

Unfortunately I do not have any host only supporting 1000base-X.

Awaiting your comments

regards

Sergio Palumbo

Il 03/02/2024 10:16, Sergio Palumbo ha scritto:
> Hello Russell,
> I understand your point on third line, but I quite sure that it is 
> working at
> 1000-X because with LAN_SDS_MODE=1 makes the module to show up
> at 1000-X to Linux host, but now you made me doubtful.
> I'm now out of home and cannot do this test. I will test it on monday 
> evening
> when will be back at home.
> Unfortunately not so skilled to:
> "Add #define DEBUG in phylink.c, rebuild and run that kernel. Try
> that exact configuration. Report to me the kernel messages."
> Would it be enough to check if using LAN_SDS_MODULE=1 with the quirk, the
> confirmation that  ethtool will report 1000-X only and speed connectioin
> reported by ethtool will be 1000?
> Will let you know the result of this test.
> Thanks for your kind support.
> Regards
>
> Sergio Palumbo
>
> Il 03/02/2024 00:45, Russell King (Oracle) ha scritto:
>> On Sat, Feb 03, 2024 at 12:18:13AM +0100, Sergio Palumbo wrote:
>>> Hello Russell,
>>> thanks for your  explanation. I have to say that:
>>> Module default is LAN_SDS_MODE=1
>>> Host banana PI R3 supporting 1000base-X + 2500base-X
>>> I would update the table as follows:
>>>
>>> The current situation:
>>> Host supports        Module        Mode        Functional
>>> 1000base-X        LAN_SDS_MODE=1    1000base-X    Not tested, but 
>>> expect to work as 1000base-X + 2500base-X
>>> 1000base-X        LAN_SDS_MODE=6    1000base-X    Not tested, but 
>>> expect to work as 1000base-X + 2500base-X
>>> 1000base-X + 2500base-X    LAN_SDS_MODE=1    1000base-X    Yes
>>> 1000base-X + 2500base-X    LAN_SDS_MODE=6    1000base-X    Yes (host 
>>> forcing module at 1000base-X)
>>>
>>> I suppose that Banana PI R3 host is forced by linux drivers
>>> at 1000base-X so first two cases should be same as second two cases.
>>>
>>>
>>> With the quirk:
>>> Host supports        Module        Mode        Functional
>>> 1000base-X        LAN_SDS_MODE=1    1000base-X    Not tested, but 
>>> expect to work as 1000base-X + 2500base-X host
>>> 1000base-X        LAN_SDS_MODE=6    1000base-X    Not tested, but 
>>> expect to work as 1000base-X + 2500base-X host
>>> 1000base-X + 2500base-X    LAN_SDS_MODE=1    1000base-X    Yes 
>>> (module forcing host at 1000base-X)
>>> 1000base-X + 2500base-X    LAN_SDS_MODE=6    2500base-X    Yes
>> Your third line is just wrong. Given the capabilities of the host
>> _and_ the capabilities of the module adjusted by your quirk, phylink
>> _will_ choose 2500base-X _not_ 1000base-X for that. With your quirk,
>> there is no way for Linux to know what LAN_SDS_MODE has been set
>> in the module. Even without your quirk, _unless_ the module updates
>> the EEPROM contents which is unlikely, there isn't a way to know.
>>
>>
>> Adding a quirk that makes it not work in its default state is
>> technically a regression. We can't know whether people are already
>> using this module with Linux in this state. Adding this change
>> potentially breaks users setups.
>>
>>> I suppose Banana PI R3 forcing Linux drivers at 1000-X when
>>> module in LAN_SDS_MODE=1 and expect it should work alpso with
>>> hosts at 1000base-X only in LAN_SDS_MODE=1 and LAN_SDS_MODE=6
>> There is no way for Linux to know what LAN_SDS_MODE the module is
>> in.
>>
>



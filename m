Return-Path: <linux-kernel+bounces-29221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8AC830B27
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 17:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15A1B1F23A36
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 16:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA37225CC;
	Wed, 17 Jan 2024 16:35:38 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02olkn2061.outbound.protection.outlook.com [40.92.48.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14617225A4;
	Wed, 17 Jan 2024 16:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.48.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705509337; cv=fail; b=cvft3RvZh0uIv36IbtpJcTz2g6pwxcnItCsSFa20Glssu36rdmGHBxEkPvFryh+UH0c+iwnx20ra520o84d5Enh7zk0sMJcMV+HPo+Nfx9Y98Vo6eVK9gaj9CX7bWCXX+uEgWoNjLH1GMG8g7VGFsXZy2ki8N+G86dyxSEbvmFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705509337; c=relaxed/simple;
	bh=+D4tWsEoM2OrzLOfxrR+M5scNxOUB9PiqhrItWR9E1k=;
	h=ARC-Message-Signature:ARC-Authentication-Results:Received:
	 Received:Message-ID:Date:User-Agent:Subject:To:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-TMN:X-ClientProxiedBy:
	 X-Microsoft-Original-Message-ID:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SLBlob-MailProps:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=WDeTwsbMbNSoTDDSo4o5ANpUNlJ0xaxlQib1msBoO3HeIH939JrrEM92aery8tcgQzsY92zvvghrqsas15PUdTp3CThbA0HM34yBWqXldyQG3wIaH8lQhRK8YXdigyTHtkztTrtedfbQ7ND8vkm9zt+Trxqv/9SD5j5mKapM9AY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de; spf=pass smtp.mailfrom=hotmail.de; arc=fail smtp.client-ip=40.92.48.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z4kN4EALZyLD4Vl/KBT0rksi53wc78xDsgiHEMISoKWrd2OhZ9BLK3cPNZiFFEERUIwKmyD8gXk1/B94K8+SmKPTrg8ZXh4M+p/rZDhGvBMSC40NX7DP04I/bAZiRrrxA9vsuFyiSMxHOhk+aVWJAFesYBWuzRXHfPgab3bIR5e+orVr/V38dMUsuc45gxjbNXeSG/ZnkaFaADjysnQ+1rQ+joJM7K+JJAz9pefHTUDW5F3yRZvO98ohmWempizGZig3+HeEI+HLgt4EiVUnetBunTh0ts7zD7iNQxe2HMLAYz3K2hJH6rPS66SyXFWmR5G3g7lavIUIoDPcmPnocA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ouXI60Rff+AQzOcciXLsiM5+c5RZDDUoHWczm7qxC4k=;
 b=LxKZWEmNaAm4VxozAo/nKuc6g/Yh+xCXPj6j03DFwNFf4D4fsuvK2aWwL5dqHvQLd9bMYnlQNRPpdTZEsrlj2mphkQiOAtZjxZypyKYiG5S4pvxJyhbpUL8Npe5SMBubaOSEH/u4CynGsJFPvZnY9Lw7X0Y3TZv9a0wGmfWSX792xdu71B2Hq664eapRqvYZeqreEGKDjCz/piYcIVdSa5fHtpLJOr1e6SXh9M+3CKdeodW04vrzYsN8GsNTWsg20LSQ83aDP3k2eUsCF0bbn3ZARGic3AKkETlETIS9zKtEJHAXi+skTEBUnJVwIN1QaUGaSYvwkgGxD3HJvwRWGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AS8P193MB1285.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:333::21)
 by PAXP193MB2042.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:233::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.28; Wed, 17 Jan
 2024 16:35:33 +0000
Received: from AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
 ([fe80::897e:cfd5:b29b:c611]) by AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
 ([fe80::897e:cfd5:b29b:c611%6]) with mapi id 15.20.7202.020; Wed, 17 Jan 2024
 16:35:33 +0000
Message-ID:
 <AS8P193MB1285F065377246F347231567E4722@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
Date: Wed, 17 Jan 2024 17:36:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: stmmac: Wait a bit for the reset to take effect
To: Paolo Abeni <pabeni@redhat.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jiri Pirko <jiri@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>
References: <AS8P193MB1285DECD77863E02EF45828BE4A1A@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB1285EEAFE30C0DE7B201D33CE46C2@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <f5ddf800df95cdce32637d41bc1539aed0a7b6f3.camel@redhat.com>
Content-Language: en-US
From: Bernd Edlinger <bernd.edlinger@hotmail.de>
In-Reply-To: <f5ddf800df95cdce32637d41bc1539aed0a7b6f3.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN: [hddFFBG+zeoc7G3cKArf9Nqq0weg2ODvoDbEj5En5uZSxhWtH2vUDb18lANsQW+I]
X-ClientProxiedBy: FR4P281CA0213.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::13) To AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:333::21)
X-Microsoft-Original-Message-ID:
 <023b9ecf-0c53-4376-8bbe-231c41b844fb@hotmail.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB1285:EE_|PAXP193MB2042:EE_
X-MS-Office365-Filtering-Correlation-Id: 54380be5-0921-43ec-a8d1-08dc177a52fb
X-MS-Exchange-SLBlob-MailProps:
	feAVlmA1hHUZZmI+UTsz2TlcID54zgy25WkyCZRWecTk5rYFuVB3uflnSjqT5MdgM5bnqIEWJMcXyko8/fTOE1N7rU7VRZL1vnMB0LYJbgDYG2QXbnRBXN2X3usLu6cMQUk8NKCYU9PhJoCB0KXeWNcIx3YzQVI40P9g674Dr3JINpKaFNMWW+Ol7Jb3YnJfcmNduN9lQXe4t0TUa3WIa6KQF4LQoiC5cHi6V3a+WcC7Sfa3oRK2rPOhZ3PtwugxzIXm1UbIzcmu/wdw3+XMlYuIcwP8YSopWVPOQA3K/zgOCs69OBvEYt4kt//xfB2cLSfMDkSfph/1AmiqCQnwWoT4ENUiJYeKf7PVW8pkWZWSwF+AvjOPbC+B7jkfXrrr3o2ErnpdFXnjCHxGY6Fwv2KXosJE0O2odeFGsi48YGI7HMNfzlfQEDqGJPOOcoNLJmpIvyzvNYTmmL4zY3CZrDeSFtlPaZPu0wlnkRuESbu5hsfsxCg7fqFA/vCY0T2UAvfAl4AP9pMvd3IZiUIzC63hf30rzKLDMwUieW016eUl8uowHUXPDH9xXxoTnz1pxM+R6ffMAXFIx1nbLNGxJOToew4akJeNvvBAxLlVTd5yKuujJ1hIZtd4c5WJn6Slz1JujlinVLgvM5uc+nanQURx9y6o1Aj0ZKoUsSLIgzQf3GGvsYhm4mRv+0crNLX419bA+pVhBSsOTAg+jjidAA==
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yrRXuL/1JdTk2RKDOt0HPGxr1poO67UBHEnNBS8ZrGCgvaw3h1ef4mX1Pn8GKkTW+r9RfQva3jPlf6ajhc/3FLB0mniy/wBavHhgmOhu/SBxNMas16aIW9NOBb5SeEsz3QpykMUF71Q2PxnFsn/jKEUpmGYQV84Jg6aGzpWIwXOwKREmHSikCQ7puv2Yt9NSO7TuSBMvSo07Uqg1laRdPlLCyHjvvNE1JSVZHxAZHZ/Utv/N2wcJwrylArn9Zs4/T7VolIInV6eX3bOU2CVhehTNtZBkcHyxjx6yOcio/w6Jn3S91mU7V3t1DLuqqULvbtBLfACVxIws4kws76n1ggQ0jC/CIRqh+UZ85UZHlr/cAFfYsUXbOBgmTtV2F8hY3LaqGQVpJDUQdPlT6u5L4NZIvSsTVx6W2MjoFwz8rBC3uPiYO8dz/wp+ECv3Cr6R0K6UVNfYMFq18VnYFicsk8hHTf88AdNSEFIUEQO5qByNc0zMWek+eVUdwo4vuGjhQ4Mq8+lc4O4ylDN9kXhLG+I7BaXQm8q5SodTpKOaSxRbuQBb6LtCknCmmcXoucNt
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S1Y1TUVNc28zSCt0aU0vNVZrdUVDQkcxVGhXN0Rvamo2cUJBZ2NacWNJUVps?=
 =?utf-8?B?MGNLUnBEejVFYVY4ejVBYUFpTDVzY0ZpTXd0c3NLbk9CTmZmY0FHcjJwM2Nn?=
 =?utf-8?B?dGZsaXFZT0JGS3JiM3Fqcmc0SHlqcWcwOFAvVzkxQm0rUG8vN09objgvaVpi?=
 =?utf-8?B?MXNxb0dxbWxod3VwZDRNUmFkZG50VDNkbWNxN01VTjZlT2dCVS9ncmRoN0wv?=
 =?utf-8?B?TUxKQmc4Tm0zWXplT2JsdEdReFBrU1lkR0Rjb1ZJd1hnUFpiZ0svQXlaRWtp?=
 =?utf-8?B?Nkx1bXRqeXdtRjAwalU3b0c3ZWZUSk45OXVtMVY0M0Z6Q2lWM0dwbHVjTFcw?=
 =?utf-8?B?N3crck84TEEwSnIzU3J5Y2VxanpnUHVGMUJsa0p0U1lRTTQ4N1NPcmJFeTJG?=
 =?utf-8?B?dC9pQU1xOW5KdHlORzdqVHJNanNwczlGZTArTG5wdlkvaXBmd0VCSW45aitU?=
 =?utf-8?B?aDh0WEdJUi9FOXNQNnozR0tQLzJkZDRJZWozdldyUkRSc3d1dWVxelZiYlp2?=
 =?utf-8?B?c0NaZzdXSGVUZlVQbER3MGRXQWxwbzlYM3BJVlZYUXFleWFuckl1WjBDYmU5?=
 =?utf-8?B?Q1V2V0paVjFjbUZ2UVNJSk5WRUVoTmZMdkEzTnVDc2JzaUYzd24wK1UrZzR4?=
 =?utf-8?B?eFMzTStvdHRLWExiMy9WUmZHbVNYclMwZzFOQmlhaDJ2di9aVHNvcjdNVERp?=
 =?utf-8?B?V3N3STlsVDliYXpIbVhMVVpUNkVES3FPNmFJbjRPdkNkQmhZd0xYOVZsOE1T?=
 =?utf-8?B?bTNIazBOUEJnQkVoS3lhVXN4WHFwS0ZhNHNZbHVYZkJLR0dwNFZqcTNvYkVk?=
 =?utf-8?B?cjhyd2ZXUDF2aG9GMUp4d2lvZ0E4Vjdkak9lZ3h0b3JFZmN6RDNGUFhubXJh?=
 =?utf-8?B?eFJJcmxoUFNlNWxFajZqT1ZFcUpDdFVpV2tlalN4SnEyYytxR0ZDS2ZEeTB6?=
 =?utf-8?B?czBWL3JJdWNjWlRVWFhiYjZHVS8rSnJ6VHVMNk8xOFFBN1V2ODlFUDdBWUNN?=
 =?utf-8?B?RUNta0ppb1UxTHFTQXZJVmZOdlFtRFgxQzNrdjBLTlBmN1BzZWtDa2s1Rklx?=
 =?utf-8?B?dnE2bDFkYlN2Y3NVSjRZVEFJSDVwUVJnb2JHOGRWdXBvcDhIaFd2ZkVoOXBy?=
 =?utf-8?B?eXpPVFZWWk0xMXlKbFhvYm45NDBndzdnT0N2dUdHbktnOWRsdmErL2wvZGEw?=
 =?utf-8?B?amIxNHh2OWk5Rk9UaWdZSk1BVlBYY3N2OHpObG4wU0dEN1BqWjhEeDFibG5S?=
 =?utf-8?B?SXE0SGx2VURiRUx2cTlyZGQzbDI0QzF4ZEJHRnlDV200cjVsUmNSSDRtcFkv?=
 =?utf-8?B?WmVDTE9CQzh3UjVlMTBDVklseVhCQUhJcjFrRUdQemVsZ0ZFc2ZlQjZXSTgv?=
 =?utf-8?B?QTlDNnQwRVB5YlVMcTRLSjlFZ0tyMURyWitKZGRpMnFBY21obUo0VEJ1Wk8v?=
 =?utf-8?B?ZnVlTDl3dHlGaSszSG05VGx1N0hLZWQvcWtCYnJKL09Ma0FMNkhVUndPMXBU?=
 =?utf-8?B?azNUTXU2am01aDZGaXlZTENrTForOUh1VEpBckhDdkRocFF1c29CZzBhdGtM?=
 =?utf-8?B?bjdaOStlbWdQVGtwZkVUS04rN0tXWlFLMzZMZlJJRjAzVC9ld0h2V3dKMi91?=
 =?utf-8?B?TU40RVdneHpjdk1RVFIrYmJPam1nMjdYLzN6S3dlRWJ5VUNhb2l3OTU5Vkl0?=
 =?utf-8?B?NlpMbjhXSWVIVmFtZVV6d3graDVMTk91VGxQRXFVRXhmeldzUTNYMjFQZ3RU?=
 =?utf-8?Q?oMkd+/SXYiWJ3wpvVE=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-80ceb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 54380be5-0921-43ec-a8d1-08dc177a52fb
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 16:35:32.9647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP193MB2042

On 1/16/24 13:22, Paolo Abeni wrote:
>>
>> Signed-off-by: Bernd Edlinger <bernd.edlinger@hotmail.de>
>>
>> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> 
> Please have a better look at the process documentation.
> 

Yeah, I'm still new here.  Thanks for your patience...

> No empty lines are allowed in the tag area.
> 

Ah, okay, understood.

> A fixes tag is requires, something alike:
> 
> Fixes: <blamed commit hash> ("<blamed commit title>")
> 
> A bisection is not strictly required, you just need to be reasonably
> confident about the the culprit.
> 
> You need to include the relevant target tree into the subj prefix (in
> this case 'net').
> 

The subject line is now:
"net: stmmac: Wait a bit for the reset to take effect"

So what exactly should I use here, next time?

> Please include in the recipients list the persons that provided
> feedback on previous release (Serge is missing).
> 
> I'm unsure why/how Andrew landed in the recipients list!?!
> 

My mistake, sorry for the spam, Andrew.


Bernd.


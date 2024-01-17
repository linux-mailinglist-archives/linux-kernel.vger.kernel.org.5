Return-Path: <linux-kernel+bounces-29237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FFB7830B6E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 17:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B15891F28879
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 16:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B41A224F5;
	Wed, 17 Jan 2024 16:47:31 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04olkn2087.outbound.protection.outlook.com [40.92.75.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35410224D4;
	Wed, 17 Jan 2024 16:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.75.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705510050; cv=fail; b=HCqb7AuWC03i6p4+dduSlK5aXOg0k+K62v0KlLzbkcEgW/psnSqMgK6RAwSvdiyoVAAI8ILk32EV4DZsBp+BvTd2cLYB+n9XIuCWehrsE2rNbWwWECNIDqeGo8IwC2vkmXtIWSc8Xf7+jGeATMCo/at/uNtGKIoEBSfFSrVyx3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705510050; c=relaxed/simple;
	bh=lw8yCPGvGTxIhhwkbggUJp2ZmzXfKjZV9ansc4iAI9k=;
	h=ARC-Message-Signature:ARC-Authentication-Results:Received:
	 Received:Message-ID:Date:User-Agent:Subject:Content-Language:To:Cc:
	 References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-TMN:X-ClientProxiedBy:X-Microsoft-Original-Message-ID:
	 MIME-Version:X-MS-Exchange-MessageSentRepresentingType:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-Microsoft-Antispam:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=l54SYQ5/pYsYbY6XPovdxN4669VuXjsiS+FcZsFFSzmoUFjHCudTF1OO15072wVFG3Sb6gPJca2+MqT5q/G5zXj4Xjncn5mjDs7+RORmyfxpY+Dc1CAMi840MSuL/31Ih+H7lhA6A9+2SJR5Qlb7RlFvD3/OPaqQS1Qw7VYoUIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de; spf=pass smtp.mailfrom=hotmail.de; arc=fail smtp.client-ip=40.92.75.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eq9Fkaen5QTclbzBoihVQtnngJZlLtc/gbQBVPBwbocrFdCixxmodGyF5p9H6+fCY63mx709a9YUcIx9muZraIEH1NJBWm7meL0vpe+oRCaoYMEXsOuepphfvgYO5QcfANBcGyLan/I74OqUl/BrP1LTplepkTFLlqXzV5QVZ/hRwwb+pQw/CCOKziI8mBipKp1OIPfn2yyKbD8xfwjCJHMDrjvHJvjGZncpHdwWVdSSYkjV8VwC7HKCs0cWurHKS9YUEnxm9ci0qv1eiXaHW/WxHQ3VDo7YDNn8ooI79MvIv4fdQcoDVt2fhuJHPLz0xKVk72Udh6VP+z2/6NT+vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SON1owT1/DioZ7mRVLuf6NxiZTP1z2I3grXoH7Ns5UA=;
 b=UKFaHDS/uPFRw+psCWLd3jHmv9n0+9W6UWwCz16J+L3xS1ZcbI0pgjuRtZcycU9ESfh2FLsMnvX/5wEEhyOQCam3eceJrOuRvUdFDxkqLKBoL3+PhryQef0reLEU2X9o1tX3WUc2hTfGCarnGNNqHR32s2DGnpQanRogh/DWWSn+9g9DFVZiNBCzZTRpajjgsEgtTq3MvjE5U0QcgvnRFv3d65mCjbxKu1lZPOC7wm/1j4iKRoW1m923GyzZ8iltgDBbFbTHdTYIDX62yQycCBdC2qY0lBiFuuBxZk73wxMLgyQZOTLlyH2hc2umC/6t/HCZAii0vhHwWIS0OIcyaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AS8P193MB1285.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:333::21)
 by AM8P193MB1202.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:368::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Wed, 17 Jan
 2024 16:47:26 +0000
Received: from AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
 ([fe80::897e:cfd5:b29b:c611]) by AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
 ([fe80::897e:cfd5:b29b:c611%6]) with mapi id 15.20.7202.020; Wed, 17 Jan 2024
 16:47:26 +0000
Message-ID:
 <AS8P193MB128591BBF397DC664D7D860EE4722@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
Date: Wed, 17 Jan 2024 17:48:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: stmmac: Wait a bit for the reset to take effect
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jiri Pirko <jiri@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>
References: <AS8P193MB1285DECD77863E02EF45828BE4A1A@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB1285EEAFE30C0DE7B201D33CE46C2@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <6e33c038-45a7-4941-b5d9-ce5704e13d48@lunn.ch>
From: Bernd Edlinger <bernd.edlinger@hotmail.de>
In-Reply-To: <6e33c038-45a7-4941-b5d9-ce5704e13d48@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN: [MK2bao9eRJ0T4QnzDkecUkPazn0jCA7dF9EjOYpb8BBK5ccWsEzCeiclUSefSSOW]
X-ClientProxiedBy: BEXP281CA0013.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10::23)
 To AS8P193MB1285.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:333::21)
X-Microsoft-Original-Message-ID:
 <f992bc4a-e871-41a8-bab2-69093e991e4f@hotmail.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB1285:EE_|AM8P193MB1202:EE_
X-MS-Office365-Filtering-Correlation-Id: 562a42a8-8f36-4410-3360-08dc177bfc49
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8SBNLY1nKyzAVXv6OjxihSzf9rqgH/0TyM5QwFK63QU1IHZrYfGNGdDeJffgA9ZP5mNWlwZLJsJIFIL4JBUMpu012KjaCy5RKc5JOGVC7cTVg10Qv8JYyOwr7KLcyDqY8TtFu+KgzFDjRnP1lcjMLT9wmiUn2ovO5dRidzx+aWdAk0p1bpBtSQ0jX9vuputB4m4n6u76YJwONy63I073/Q1PU/5C9HuJ7mWYmPkEWPvVpXcub3G2zu9rpQxzEvd4OCKroBtMPCJ7nS9iU89wJCeRzdyMMRcmLqunZPxa8FNo5Zbp0UCKXXLNv2ZpOh8W520SwcgOdB7goT/DvnCXGK0HDBWwXxHdT6+jawn2AJmSP/w/J5ZDwZ6pW+8vhtc/ztjvSeV4k4Hi+03hRzeIB/1+C4gH446A4/1EkjSN8+LzVaajVBKoezCiQ5hIT3+LMm477lswsIt0Y57fC7NY3z/LygKMm8pnNjWYiYvAzOHeaWlAafEve4kuVCc28yi6MnFNtTu5xFabQtJ9TFebnPELYwYcTfjgrkHgab4Kkx+G12Stt5ftThQyjF5Zwe7i
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dkpyVXJOT1gvalNVNFg1a2Fha0tvOWlCbkdGVjBscERMVnh6V0d1RmFPSlJ5?=
 =?utf-8?B?QlM0cGdCRGxzSUN3enVnNktBaXdGM25uRFZRNmZLMWYwT1YxUGRlRXE5eTZa?=
 =?utf-8?B?bWVOVFpyMUs3SG1qTnpEOTlVSlpUQW9KYXM2eVNiV21QVHF1RlVubit4RVlI?=
 =?utf-8?B?cTdsTWR1eEVQc1BZR21oTDFja0htcS9ueVhzaThZYzUvckhiNmdEa3BnY3pJ?=
 =?utf-8?B?YjBxQnE1WUFIOWVmT1VISnRqZXpzYVUyN1R6a3VzVXV2SUlqa0E3QXh0aXlT?=
 =?utf-8?B?ei9yNDk3L010WHJRaGF4TWszQldaSCtwbHp6My9xazJ6NnVuU3ZrQ3NlTFZZ?=
 =?utf-8?B?aE4vcGZBbGRUTGhxd1NJRVE4YW10Q1A5NTNRR2RMZnVoVmRDZC82dkhMWXd4?=
 =?utf-8?B?N0dLUnp2ZVNUcHhUOFhOamVuQ2VabittSC9IT1Vjc2NJUXBvcVFhVVBFYVhJ?=
 =?utf-8?B?R0gvdlBKQmNhSllRa2ZTa3ZSVmFHQitvcFlucEtkajZMeWxlTjVBN2t5N0k1?=
 =?utf-8?B?S2NEMEhudHJWaDUvV3lhakxSVlFDTy9vYmJmTWRyMjVjTnNPbjN6djRuK1Y3?=
 =?utf-8?B?OEk1MW5pUkJuRTdaNHV3alRZNmZFMXdFSFYyOVRoejQ1a2RadjY4UGlydDFo?=
 =?utf-8?B?T3lIc1lQbmhNU3BHaitZNTZJYlhwTHV0b09SUG1BaWVjQUFqYjZKMDZjbWJI?=
 =?utf-8?B?YjNUZVk4aTB6TThqWXpsNkhJMTJvTUtGeFE5am4za3N4bFVXNmdTWm1rOFV0?=
 =?utf-8?B?ZlFrMU40NTdwQWlyaHk1Z0hlNi82NGhWWEd5VEVaTG1uaEtrbFVxbm1tVzAx?=
 =?utf-8?B?dENUTlF6UGVwdGQ1L2VCTDh4dUhKQ0VwT05HNDRSSUhIRDRtM0dDYS9mUFNO?=
 =?utf-8?B?SkhZVjNhT1ZrWnQ4a0ZzVHR2ZS9CbFJTT0IwTTJpYXIyRHc3TnVTcVJ2Tjd6?=
 =?utf-8?B?ei93MDBxVDNkazFEYVJCTXJ4MVB5UXFiSUliajVSakxBbk5UK3hMd0JOTnNq?=
 =?utf-8?B?ZUQ1SndzbUNJU2Q2Q1haRW03L1k2SWQvb21yNVFaMDV4OEt5b2Q3SUpzUnl5?=
 =?utf-8?B?OEZlaDRwdlFpb1Z1MzBmaGpkTmc0VkRPTTVjZjhtaEp3RVhCVHppZm91NDJs?=
 =?utf-8?B?Z1pQbVhSdmtXM3E5Smd4czViZWh3anNVR2NnMXNrNlVZcWJiOFAyVmlTRVZ3?=
 =?utf-8?B?a3VNYnNnWVhZVGZHZC9xZDFqU08rQ1lyMHlkU2xrcThFb3NlbzJwazlSNzlt?=
 =?utf-8?B?ekszWUtURlI2OTJMd0M2K2dkTTFLVGFUUzVLRU9OYWlIR3pxOUJXZUg0eExH?=
 =?utf-8?B?OHdZNXp2ZWF5dmlmSUFDcXdjUnNZUUhsY1NIMXU5cUpUd09SNUIva29tQ2pO?=
 =?utf-8?B?aFltbnBkaUlZRGt6YldzSGhyVCt1QU1ONEJHYWFkdms1VjRZSFBQT1JJQXps?=
 =?utf-8?B?UVpEZ0xseHRWSFJ0dkY5SWZidTBsblEzOVEwWXBKNlE2MzhObUZEcStQQ1BC?=
 =?utf-8?B?VkE3dDlPTTFQc0E4QllxMGo2NjI4eDlxOFdvYzRRaGhLSVFSaktZbGp2cTdU?=
 =?utf-8?B?UFU4clN4OG9NZm96d0lIRjQ3MllXTHNYVWQ2eHJHck81QWwwS3M2SXlvdkFR?=
 =?utf-8?B?Q2hxTjZvbnNrWlQ3THgvVzVKVytPZnNETDV1REtRK0owbkpEU0NZeHdBMTdD?=
 =?utf-8?B?cjlVMGR4RW1weHF5cWNTaHdtU1g3cnJSOWdXaTg1ejR6NlVIcTlqZ25Ma1lE?=
 =?utf-8?Q?PAqUCCIKA1N3Fl/slY=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-80ceb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 562a42a8-8f36-4410-3360-08dc177bfc49
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 16:47:26.4878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P193MB1202

On 1/16/24 23:35, Andrew Lunn wrote:
> On Mon, Jan 15, 2024 at 08:21:42PM +0100, Bernd Edlinger wrote:
>> otherwise the synopsys_id value may be read out wrong,
>> because the GMAC_VERSION register might still be in reset
>> state, for at least 1 us after the reset is de-asserted.
>>
>> Add a wait for 10 us before continuing to be on the safe side.
>>
>>> From what have you got that delay value?
>>
>> Just try and error, with very old linux versions and old gcc versions
>> the synopsys_id was read out correctly most of the time (but not always),
>> with recent linux versions and recnet gcc versions it was read out
>> wrongly most of the time, but again not always.
>> I don't have access to the VHDL code in question, so I cannot
>> tell why it takes so long to get the correct values, I also do not
>> have more than a few hardware samples, so I cannot tell how long
>> this timeout must be in worst case.
>> Experimentally I can tell that the register is read several times
>> as zero immediately after the reset is de-asserted
> 
> Is zero a valid synopsys_id? If its not, maybe do the wait conditional
> on the first read returning 0?
> 

I don't know at all.  And actually, I am more concerned that other registers
might be unreliable within the first microsecond after reset is de-asserted.

As I mentioned earlier the VHDL source code is obfuscated and I cannot
tell anything about it, maybe people from synopsys can shed some light
on the issue.


Thanks
Bernd.


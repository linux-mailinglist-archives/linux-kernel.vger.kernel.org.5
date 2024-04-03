Return-Path: <linux-kernel+bounces-129374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB078969AA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A2D51F28756
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077FC6EB41;
	Wed,  3 Apr 2024 08:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="fktyLSc3"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2094.outbound.protection.outlook.com [40.107.105.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74AE6DCE8;
	Wed,  3 Apr 2024 08:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712134537; cv=fail; b=eSKvAd4spltzkD2LgjFowU8AfkULZsoNrE2X/rqNSk3nZRAuWXZ1uqGy86KlhyrEETBptz7upqYyikdn4gNJLYBohVt/cxXqU5UvO7AGLPr5LywNICwf2DW44gcTgvOgM686n4K97CrZUa5mRneXkX0lsrXoHpp8NyecQEtMqWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712134537; c=relaxed/simple;
	bh=4dR8e5FNu9tVrbPlVB+OVQ9ZUdPwQM8CZfPiTpRbPbE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DczoI3msVoaXFSrvjAWqUUyLVUGtyv8cYuMEPsfyF01Gh8AQwlnNqdy+baqIxkFbv/0ShrR7yY7hzQ0W10KwDFxdwF4sSI4iQXXvRBJSXx3piKkMZwOt1RxUca7tIa0qWqhqLfWSlm33v+Qq8CX3VRKckvR4v+HTa1h+1kX25Hk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=fktyLSc3; arc=fail smtp.client-ip=40.107.105.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ANy6LtlDnTP/qPZJ/LBTwcaNnV1sGJexxH+r5CoapNvNrfIV1ExV1T1z+chZRUjXdVam94WLSjCTqe/Ff3HA2sWUmqKAiOmU7v6ZRx3FCrHRk4csqeoMTo9WlPUkE4zUuAOAu7JVVBxa3bqmRPaz+ptSKVvWl+UNsnqWhjFNPEYt1PtdE48E2aoGp/PeXr6E4tIuA1JIP9OcbUCGAZi4Ec3idzAYq3DKAttB08V1QRIDoWZQpxc0JwF8rpWQ8xOcnTJJCZvlHDFiuCe4SFuUz7UApILkUI4b6Ru65XJxPTfXAOAnPbXc3TH0gfdPqzLiXmwApT0Wbnz5HRLa/rdt9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dcoVjw1IXLsFXyb8QE0BXJ0283R9eGHIhEizrFPqn2M=;
 b=WKqlkH7B6Sgvfh9pMO6K0oNnoe7YruKBVcK32oMu8YoijJuTDqBfMq6gR6J6uPFS1+glLoCJbLzcfZNgWl7pzV8XJv9xjL5XCFIZEzTOsPBFzw3hs/WYgc1Hwhw0K1c1EcyEcdUeZdzaELu/XJCQgFfhFVyQyNB3V+SJCGUlnFnqKKV14bD0knHcouQi5O8qgloXcZQvzoxckg/BIzpzvEPRptb+dISoa0/pm0AdKnr8XE7Pli61q9SLJDDbmG1ZL3Oxv9ku0Cjj3ZLDr1K2uQL+XgsmaqogPnROHmygwguItf5Kc3ak9r05zWEkOcInTBV5XyVB6FeE30AakS+gGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dcoVjw1IXLsFXyb8QE0BXJ0283R9eGHIhEizrFPqn2M=;
 b=fktyLSc3fNhaU73O58GmWQuM7F02iOgBFGE4mRTv8y+Z1OabMRLtsLqKIg2vQf8Chv7jmfxF5qJm0GCwb8rS1Sfka2N7ex5os+CrwsDyiZ6xVzVWTaTiJgDKDNKIuxFy1IIgIdG/GCTVwH5Rj6AExMYvVlRPfamJe2YelVpITBo=
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by DB9PR08MB6539.eurprd08.prod.outlook.com (2603:10a6:10:23f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 08:55:31 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::9e35:6de9:e4fc:843f]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::9e35:6de9:e4fc:843f%7]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 08:55:30 +0000
Message-ID: <b6bf7f8e-7d46-4b70-930c-9483f13fd80a@wolfvision.net>
Date: Wed, 3 Apr 2024 10:55:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 2/2] usb: typec: tipd: fix event checking for
 tps6598x
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Abdel Alkuor <abdelalkuor@geotab.com>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240328-tps6598x_fix_event_handling-v1-0-502721ff705b@wolfvision.net>
 <20240328-tps6598x_fix_event_handling-v1-2-502721ff705b@wolfvision.net>
 <ZgveG5Ly3mw0O0eo@kuha.fi.intel.com>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco@wolfvision.net>
In-Reply-To: <ZgveG5Ly3mw0O0eo@kuha.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR03CA0061.eurprd03.prod.outlook.com
 (2603:10a6:803:50::32) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|DB9PR08MB6539:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PRqQrv1OHpPR2sRTamIahjQprW6AYCYBDaGH37YRavpSusYXR/CU32PTUl6hBpsZGgHUkPCnhC/7S2INLwkA3jlnGqDEI1z3bBxHr63BilAbmwbUe2gaf45WowKbiYLEVDQNvy236Xyt9vhqXxQgunaB8ojQtYFMUxZr44Sem/ihBv3WCB3O3lXusFU0ZLYynjPcOzH4iODcD/YEML+MuktrvdoAWxK9ves8uv1XIh5EJ6swp5w4OlVTb894tIVQ82Ug1dYyMDkhccxVcNWnynlVO2uAZeQkl4gFRGv34Lj07XB758DlQ2z3DlK7fgu0fuk73ihgehUsJxcp3u+Z5Jwi1NMcBOSBWOJNJHegzPUBb0poDw293VSfoZnkb6UL0VHe9jJAvP6coOOyh8BwgNVSgie3nl2fPrVD+tuXqe5lG8+c90z/mIPPHiWCjpQiSknuKzBQRG5QUpfO+JkDblV2i3LBhjeyWEewmjRkXrJw8MXtSIM9JPPkuOABYgWqrGMWscPYRoYIq8dlmoRgTn+i+y/IPeGjrZG/B7FP+P+Rp71jvx1/hy0iD7CajYs0vBv6TItHJ/traGSNssL/vZuz3O2wFSNJ5KHpLKiuF4MDqWgLS/uLsJkViEi2kNjohuUIAGCyUfoc5jo6ysacugC3jGdwJGnOAjkJ6uDiOaQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TEJCb2JnbzVqc2pjRDRVWlVFU24vME50QzMyalpNUzdnUEtCK1lEZitpRUZH?=
 =?utf-8?B?cHhmV21Bd3cwclNSVUxQbytsWUJXOTRXTlg1NmhqYVlvZm9aaUhxRmFESmlK?=
 =?utf-8?B?ZFFVK2lwTHZvMnY1djUzdmRrSHc5K0RQWWl6aXp3QTNwTnhBV2FrN1Ntclg4?=
 =?utf-8?B?NDZKaEhraHZYR0UzajJOZlhOY0xjY0htWFNFRmVKb1BNMmJWSm41UWllSHV1?=
 =?utf-8?B?N2xRTU9qT01TOGY1b1lLOWdUa090SFN0UlBQSzJNRURUT1BOeHZMMkVidDZs?=
 =?utf-8?B?a1F4NDAyQTJQZWZ6UFE0anBHend6QXJCUGYyTEUrc2krWCtDU0pxOG4yMVN5?=
 =?utf-8?B?TUgyYjY3Z1NsRExEZGxpcTFGY29XZG8wRG12aFh0UkFnNmhIOGFYeVRMdzNX?=
 =?utf-8?B?NU9SMjhTaWRnd0YxbHBhYnB6UXpQVE1ZQVlEMDlkNU8zVEYxcTVHWjQ0N0RJ?=
 =?utf-8?B?VGNhY09vdFNaMVpmcFNzT1YzUThUUlNNc2pkeUtJZzM0YnBoM1MxUTJTd0M4?=
 =?utf-8?B?TnZZSTJ5YzBLVTRUb21XUFdvWVZwa2JkZkUzV0lTTE1DNkdhKzFqaWV4RWJE?=
 =?utf-8?B?TU50NU9qWUY3dnZUc2NROFJmaEhLV3N3bFRLTTdodlhXRWpRVENVdW9qUjQ2?=
 =?utf-8?B?RGl2d0VQUjk2a0QwMC9kclBhNGk3Q3oxenZLU2Uva1lLeEhuQldHT1dQOWdv?=
 =?utf-8?B?K1RXZjFZUXY4MnJ2ZnV4NFFnZjJmVVJoSGpBQjd4MjlWTlY5WENCZGZpeFR0?=
 =?utf-8?B?Q29zWVJrWENWdTRyMnl3OGlOR0NXL1RLN3JrbTZhdmNCbG8rUTFERWZsR283?=
 =?utf-8?B?bFpZV0JSa0tWTGtMWloxU2xFTGFmMmtKak9xZzJlQ2FoakZ2TG8yRHBSZEhv?=
 =?utf-8?B?dUhQdWt6RTRKNSswb0I3Y1pVRU1Dc1JRWmRLRFN6RjRhZExhZmhheDNFd3Nl?=
 =?utf-8?B?Vzd2T1YydU1TeWVaczA4MjhwMWg0UUhwbGZDcE5aK0toQVBDZnlrdnpoUmcz?=
 =?utf-8?B?cDlBalJJc05RUlFoZVA3UmtZcmhkSEdaejd6bHZLREdNWG1yNjZ2YWNFMCt1?=
 =?utf-8?B?UjlZOTVIK09NT2x5OC8vODhwd0R1Zy9kMlQxMFkzYWNDdGR6T0N6VmJMME91?=
 =?utf-8?B?ZEFuTllzdmxXZlpoZU9zSG9lZjQ2dS9PMEpiek9Oa2FiU1M4WWo3UGEyQVR3?=
 =?utf-8?B?WDNtQytWOWs1c2JJcWxnZG5jeGx0Q2hoaStwcEdtWHRlSUNQZitncDRVUU0r?=
 =?utf-8?B?MDBrd0JVcHBnbG9pMXQ3em5wKzEzWlNZMk1MVkl1T0Y0cnZNdW4wUHNZWENJ?=
 =?utf-8?B?MWxCY3dBQ3EzR2NhSjhOanpFdUpxVjlnWTQ2TGtNVWU1ZW14NkVKZ3BtdVdK?=
 =?utf-8?B?dm50cGVmMWtPQXd4QU15K1NiV1BqenhNVGg3UjN3WlM1Ump3cHgvWkt5OTF2?=
 =?utf-8?B?YlVJUngvZVliaHVoYVBsNkI5b3grMytCbHpVS1h3c2ZVZUlOa0NHUzRqNkdR?=
 =?utf-8?B?SUtaejcrTlE3RVdUbWtQeExOek1pbWZWbklkL1ZOR0F4cGJlK3Q2TWQ4Q05Y?=
 =?utf-8?B?V3lvM2NxbEdacEpYckNuQnArR0hvMU9JbWtpaHFFTWV0UWlXdWRzSkR4dzBx?=
 =?utf-8?B?QVJnTjhDVUNLMm1kaG5EdG1taHVxZkloMmJDOW9XQ3dHTW1WNElhMlRHeWVo?=
 =?utf-8?B?R3RaQTNPalBqVS9lTmR2VDVpK3dvWENXemhxNitkNXVHMzRiQ2xNOHFYWm1h?=
 =?utf-8?B?QXhPdkVUY1g2ZE9SVHNVWXRYY1A4UDJpN0xmcFJQYjhvNWh1dEdvczNONndY?=
 =?utf-8?B?ODA3RGtxL0ZxZ3hyUm11cmpqZjV2MjNiVzRiVkt6K0ZrQ1pZQStsUmpXa3RQ?=
 =?utf-8?B?aWpXeTRUdFdUU0JrM0VEeHJ4d1pRY1RIdEdlWUdnU3M5anBDaHp3c00xQVha?=
 =?utf-8?B?dVFiZ2FocDhuTFdkcWQ3UDR6cEd1K3EzcXZzSEZ3djc1a0s5UTRGVmpKZGMr?=
 =?utf-8?B?RnpuMnJRMVYrQXpUUENiUkVFTExVTkw0dmIzZjIwWDFNejJRL3dBSUNHdFBq?=
 =?utf-8?B?SHZpNlBOc285RTBWUzhKNmg4TWNXdCtRR1RnOGMrNTYvN1E0OGUyOG1KUWhJ?=
 =?utf-8?B?VmJiMEJzV0Q1TFV6Q2x6UlVBYmR2YndqbnlhNlJKR1Nyd2JlVE1rQ1M0TFU1?=
 =?utf-8?B?TlE9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: d20f59db-deb5-4fa5-4b69-08dc53bbd09f
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 08:55:30.5163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UiYWwT2t+NdT/uLwETvZVDzFvi8Jr7CLoBiWbBYfUYVUK0nTVl3rQlmu6Tpd/zeZYdehtg0eQh8KG/K+19CebekUZ2YkC+rIAnkgL1lQXAQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6539

On 4/2/24 12:29, Heikki Krogerus wrote:
> On Thu, Mar 28, 2024 at 05:55:52PM +0100, Javier Carrasco wrote:
>> The current interrupt service routine of the tps6598x only reads the
>> first 64 bits of the INT_EVENT1 and INT_EVENT2 registers, which means
>> that any event above that range will be ignored, leaving interrupts
>> unattended. Moreover, those events will not be cleared, and the device
>> will keep the interrupt enabled.
>>
>> This issue has been observed while attempting to load patches, and the
>> 'ReadyForPatch' field (bit 81) of INT_EVENT1 was set.
>>
>> Read the complete INT_EVENT registers to handle all interrupts generated
>> by the device in a similar fashion to what is already done for the
>> tps25750.
>>
>> Fixes: 0a4c005bd171 ("usb: typec: driver for TI TPS6598x USB Power Delivery controllers")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
>> ---
>>  drivers/usb/typec/tipd/core.c | 31 ++++++++++++++++++-------------
>>  1 file changed, 18 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
>> index 7c2f01344860..308748d6cae6 100644
>> --- a/drivers/usb/typec/tipd/core.c
>> +++ b/drivers/usb/typec/tipd/core.c
>> @@ -637,48 +637,53 @@ static irqreturn_t tps25750_interrupt(int irq, void *data)
>>  static irqreturn_t tps6598x_interrupt(int irq, void *data)
>>  {
>>  	struct tps6598x *tps = data;
>> -	u64 event1 = 0;
>> -	u64 event2 = 0;
>> +	u64 event1[2] = { };
>> +	u64 event2[2] = { };
>>  	u32 status;
>>  	int ret;
>>  
>>  	mutex_lock(&tps->lock);
>>  
>> -	ret = tps6598x_read64(tps, TPS_REG_INT_EVENT1, &event1);
>> -	ret |= tps6598x_read64(tps, TPS_REG_INT_EVENT2, &event2);
>> +	ret = tps6598x_block_read(tps, TPS_REG_INT_EVENT1, event1, 11);
> 
> This is not going to work with the older TI PD controllers.
> 
> The lenght of these registers is 8 bytes on the older TI PD
> controllers (TPS65981, TPS65982, etc.). I think we need to split this
> function.
> 

That is a good point. I had a look at the older TI PD controllers and I
agree with you that we should split the function to cover both register
lengths separately.

I was thinking about adding a new compatible for the newer PD
controllers (tps65987 and tps65988), keeping the current tps6598x for
the older ones as well as backwards compatibility. But backwards
compatibility would also mean that flags beyond the first 8 bytes would
be ignored.

On the other hand, the upper flags are only relevant for firmware
updates, so we could check those (i.e. read 11 bytes) if a firmware was
provided via "firmware-name", and ignore them (i.e. read 8 bytes) otherwise.

Other ideas or improvements to mine are more than welcome.

Best regards,
Javier Carrasco



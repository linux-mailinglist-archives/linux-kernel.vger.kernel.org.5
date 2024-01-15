Return-Path: <linux-kernel+bounces-26210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F3482DCD8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 16:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99DA9B21B56
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1EB179A7;
	Mon, 15 Jan 2024 15:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="HR7YVebv"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2089.outbound.protection.outlook.com [40.107.22.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1C61798C;
	Mon, 15 Jan 2024 15:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HL/nxefhRQfahT3/cGd0ajFLZklZmZwwIkD9vyv5pqWSzc/y6uxTk0TnkNplKpjVlez/kfmCiBzYnLY6Tn1sHafzx00RXRL2xCGuUSX8SHGCuvhOXKgBHSnBL9wnhNhzcqaImMgJ6Zv3nh+5hza1JJ8aYZaykvildepJpd86tJZhTdY8Yy5vIUlDkcLuHGIIAhaSCZTgk0xk2vldaSXJyr6uLH2A4V7NQ/vOG8TzRE38jVcEboTf8dNCbzMRnA4bV0uLxIhz6jxmolT4HKs7xTzSxypZ72Eij55EGpazviJxplPnhRiAngTaPJVU7iuRIL5ooznnCleA3ETNbrMArw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xuZlw3vrAsEp3bpDkwAqT8eeRS8Mq0gVX0taiUEtCYk=;
 b=FH32O9cp4DrXt44gkc0u5QzhRgKVqvjQZhttlrjb7V1Y8BRO4fusxDT0wCMNDY/hRr8wjrIhJoKMQvtshfEOjhwdRO8FiB1TV8I4Rxyj62Wu9g6fwnDKVGthru1qQyz6mTlhDJXIu8/fcMpxehq9ezxYLhD7MG2+YxQPZ5K4m0pgoEKsaogmTSOBaARLdp/tVG+/K5/Ri9Or+maED/n9JVX78potjsEysXLkdLud8IQVFv3K/kZUAZJ6yALPMFfGFOWyrcN3R3jnj9eovdcf4//eAnHZ+QSjXNAjt/+cSd3qArK3gryYThqtt0UCMzAts/pWINsF2Jv9EsoVDMgf5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xuZlw3vrAsEp3bpDkwAqT8eeRS8Mq0gVX0taiUEtCYk=;
 b=HR7YVebvn4jskSIyEdWQJ8veoqoJqqE2TQztaMiRmIHcq/Yfb3gFvq7I43721Y9MLk44jxMwpJF/k52HftxoYzbgOMcxxxvjilu+yFeU16+aCztixHPjxzTc5BExDbylSKvmj/rxPXt4jPKHE1Rvo1OPJeVhy97LFXLho2H3kxs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by DU5PR08MB10496.eurprd08.prod.outlook.com (2603:10a6:10:527::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Mon, 15 Jan
 2024 15:59:04 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc%4]) with mapi id 15.20.7181.026; Mon, 15 Jan 2024
 15:59:04 +0000
Message-ID: <5db4b898-93d5-446f-bfed-b57847f9967a@wolfvision.net>
Date: Mon, 15 Jan 2024 16:59:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] ASoC: dt-bindings: xmos,xvf3500: add bindings for
 XMOS XVF3500
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
Cc: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
References: <20240115-feature-xvf3500_driver-v1-0-ed9cfb48bb85@wolfvision.net>
 <20240115-feature-xvf3500_driver-v1-2-ed9cfb48bb85@wolfvision.net>
 <333c2986-c7c2-4a46-90cf-b59ae206e55a@linaro.org>
 <96abddcc-fa65-4f27-84fe-2281fe0fcf1c@wolfvision.net>
 <644f7f02-405d-47fb-bc72-4d54e897255f@linaro.org>
From: Javier Carrasco <javier.carrasco@wolfvision.net>
In-Reply-To: <644f7f02-405d-47fb-bc72-4d54e897255f@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P191CA0014.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::14) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|DU5PR08MB10496:EE_
X-MS-Office365-Filtering-Correlation-Id: b7e7fde7-53d9-4e8a-8ca9-08dc15e2e5af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sS3V0dqEQtGl7H+QXQlLRalNRJrA5hejGzbtkSj3XDJb6wNTwZYYCwlYLpklS43wcuRmaS0jC30TqNqL84bCDMOX5+90hwo/Af/dK59MV8brU3Lr+p7vJh5ilOsUsMNYBMLBBta4RrJYsvRYWnx8dOD/VfjfTYDvZJ6hFTfJUJtpycD+Dt3wHqjEMxenu+2oiuF6/xA5RpSi+ukSd9GGkltb6o79xZxgarVY/BKD5oGg10+puN6gLCEsdgjN8r4nRSBLBD1kbVwr+5MWUJtrHoYJp7GfW8z4IKW+bqKy2SF+bZFZJqL2wVgiPqRzLerdUsyyIJALGKcwGMyec3Y8PiV85q5CBeh5cCi4vJAQQngacULh+jDB1XeoDMce5dXCQqmAvG8QTKnQidzT6RgTQzHxC5scSf58hp0qpiGMWHit1pLAYnyCBoLBwyNidnaK0nyPgWfCmfFaGaI1qb1Gqbgcy/TrA3IuI7tGVEmUnYSed38xX5uQCEVHeX+ZT9JCzY0BA5OO6pwRloIfWe+G+lweLf0UAsRUNxcKpkJ/HaR4FuQgqZkhcqyu7fbmNa9peX1/CuInvcqca1ddfv2e+oJ+cppjL2clsXtRtZefhMGvs6s4opmL+LUQMDiC9E+SWBfNRpN9EUKuRnG22ntgdA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(136003)(366004)(396003)(376002)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(38100700002)(41300700001)(36756003)(6512007)(5660300002)(7416002)(26005)(2906002)(31686004)(2616005)(6506007)(53546011)(44832011)(478600001)(966005)(6486002)(6666004)(110136005)(316002)(66476007)(66946007)(66556008)(31696002)(8676002)(4326008)(86362001)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UEVCUkRFaW9xaUM1U3pFbEpIYW4ydXpQb3AvY2cvT2ovM0dmUU1sK1BZbXpz?=
 =?utf-8?B?bWlBN3JTOUEwYzlZdWlOc2piUGc1TkNYUUNoNWJ6QkkvQi8xQnIySEgzUVR4?=
 =?utf-8?B?RWxIODNzUGwwQW5LV2lHVnMrTEp6dGtTVmdpVE9oaTZpS25JTUhFNXBZWWxT?=
 =?utf-8?B?UW0vREJnK3dRc2kxYkRoR0tPeFYvZHNXNzRqMDhWNzY4elNZQmh5d0NUOWNG?=
 =?utf-8?B?ZFcrSmVjV3RxZHpMcS9IM3JIZzVtdHg1WWV0T0o3VGZqZGgyUmZhdVZDS01D?=
 =?utf-8?B?ME92RGpvOEtBWlJWN3BJcU5ob1ZPYmNacEN1czJ0b1YrZUpLQ2I2aGxHTm1G?=
 =?utf-8?B?RE5JbGNIbjVwK3ZoRDg3SXdKN2NtdEIzNnFOVWhxSkRZaGZ1dE44R0ZZSXNq?=
 =?utf-8?B?VStvRERBeHhCZTN4Skt3anRPYjJEa3Q1Z2RxWVVKcGMvYVEwNEczeXNSNGpr?=
 =?utf-8?B?U2pDZDE1ckxIVjhsOHJyaDN4Mk4xMVFMRjlXdTJsQktoNUJhT3VFSk8wc3hY?=
 =?utf-8?B?Szk2UE5Vd0FveDhQSkJPOFRGRkh6ZWJ3Y3RjbzJJanJIMHl0Y2REdmpnQ3Yr?=
 =?utf-8?B?cWRWd05Gbm1Jb0RUY1JzTkVydnF2d1VHQ1Q2SWdDOEwvL0dIWDcxMkJ2cER3?=
 =?utf-8?B?YkVoU3VaTk1zd01RaDJlMTByZUE0S3dSem5rYTVZYXlFTzFZYlhFWWkzQmZo?=
 =?utf-8?B?Yk9RVi9nNk9Vd0Y3aTNzTWFYV2dIMk0vdWdqNVVHcUNtdVFVMG1MRE1YSlZi?=
 =?utf-8?B?Z0d0OWRQVmJlWDRKTXpKYXBBQ0dla3RWNW9GdFhJV3pHOUNLcUhCRFVuVnpL?=
 =?utf-8?B?MVRoaUY3WWEvOVJaaGR5WE96cmpkdUpkRVN2V0UvOWxRMy95SXRRbEFNN3c3?=
 =?utf-8?B?KzFnRW1kVWNxZ3JaYUNLeDJUMHRvY1VVQkY1d3NOTVQralNIZmJrUElGS0po?=
 =?utf-8?B?TVNWa2hsSzl6bWhpMkNpenBiZllMZDhJbWFSTjVORGlLRG5vN0tsT3lkUUYy?=
 =?utf-8?B?NVdQZ1dqbzRJSnZjZXNsS2dlQUVPWlNwbWEraWdMTUc5MTdFUGFjVUh0Ky9X?=
 =?utf-8?B?a3FLUVVPc25pR0J6aTJ4eGZIQzdMUnQwQWl5VnhHb013cGdjYTQ2ZEVWR2xz?=
 =?utf-8?B?UThXd1RnV0ZUb1lDYUhCSlJ4cnNIekQ4b0NhODBrT3Y3SDV2TGUvL0JaYzR0?=
 =?utf-8?B?YnVUY0c4YjFEV1l3bmQ2bmg1TkVkMENyQU5XUndDK0VlV002SEY4U0llL09N?=
 =?utf-8?B?SVcxMXRJZDhTWDlob1pEeklJOUViMGZNdXpobkpWOUQvUWZHaWdrT0xiYk9x?=
 =?utf-8?B?Ykg5b05qY0VzMjR4cExOQzBBL3lpa3ZoenFNOVZXaXptN09pU3Rzekt1SUYy?=
 =?utf-8?B?TVpNMmN3OVZEYXVGU0k0MFZjaHREMWdqTzU4d1RIUlZxU0NKZ2FtNnFYTEhh?=
 =?utf-8?B?ckMyZ2Fqb2J3Rmxid1RmZFBCTVB0UjZQSmNlWWdDdmt5RHdHaVVNK2NaSEpj?=
 =?utf-8?B?WVVLVHA2WElDcTVZNjhEVlFxQnBOa3k0aURyZzU4ZXludU92aFB2Rm1hRHhS?=
 =?utf-8?B?K2ZVNVExamFmMTlnMUtBZDNidW9KQ2lkQnE5LzlzVVVLOVBycnZrVGRyeCsw?=
 =?utf-8?B?bW1nWVpTUVJSR2FWUWdnWXBrNHNqWTA3ZlJVSk9BVWFKSWNFbHhMWndWcm02?=
 =?utf-8?B?SWtMZzUxTWo2Q1gxNzZELzRySjNYVVNSazVGMHlSM05TRUxIR1l2a0NscDQ4?=
 =?utf-8?B?RFlwY21nZWVmWWRwQUMyQ3hZbmlXZEZBVmVOV09CQ1ZLMElnYmFVdllQbW5F?=
 =?utf-8?B?RWhLYW8wNHEvTnV2MjBENjZLMlpnLzJUWk1hRkI0U2VYYWt2K21pZGhENHlB?=
 =?utf-8?B?MnZlSVFYN0Zpdys1Y09QN3kwRmlVTVBiMU1MTkxuK3NEUW83ZEFDRHFsK2Z1?=
 =?utf-8?B?UHNmajYvMElvSk0vdU41MmhPUG5pR1BFYWlSd3R5ay9qdkZ2YVpFcjI0YXhK?=
 =?utf-8?B?b2lmdVJkYzhjQWlRcXZROWtoUmlwbkNjSTVzUXNpQ3praHNsN0QzcTcvODIy?=
 =?utf-8?B?NWNXa05iS1BHSFBSVzcxbHJUdVFHVXNYWTMrZkZ3UFgyNVlxMXJFNmJ1eUht?=
 =?utf-8?B?SFF1bmQ1UzdpYTFZYWFzSHVFWVRMcHQwODVmQ21aaFpYOExtWTdUa0p5ZkhE?=
 =?utf-8?B?OVE9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: b7e7fde7-53d9-4e8a-8ca9-08dc15e2e5af
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 15:59:04.2497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tGj8bvdYVJfHzGLaIognAfsWNdqQ3DsX86GozJojOrXyl9SofbwsDnQZmPajZlSAAiKzjkw8PkHDIw/K+7j6TqZBp3B4Nsc+0W/nlz+9y/I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR08MB10496

On 15.01.24 15:35, Krzysztof Kozlowski wrote:
> On 15/01/2024 14:58, Javier Carrasco wrote:
>> On 15.01.24 14:02, Krzysztof Kozlowski wrote:
>>> On 15/01/2024 10:16, Javier Carrasco wrote:
>>>> The XMOS XVF3500 VocalFusion Voice Processor[1] is a low-latency, 32-bit
>>>> multicore controller for voice processing.
>>>>
>>>> Add new bindings to define the device properties.
>>>
>>> I don't see any bus, so how does it work? How do you get the voice data
>>> from it? I also do not see any DAI: neither here nor in the driver...
>>>
>> The voice data and any other information can be retrieved directly via
>> USB from userspace. Once in normal operation, the device acts as a
>> regular "onboard" USB device and the driver does not need to do any
>> further management.
> 
> So is this an USB device? If yes, then shouldn't be just auto-discovered
> and you add here some bindings for other device? This looks like coding
> power sequence not in USB node, but in some other, new node.
> 
> Best regards,
> Krzysztof
> 
It is an USB device that requires two power supplies and a reset to
boot. Afterwards it is auto-discovered and functions normally as a
regular USB device. In that sense it works like the onboard USB HUBs:

https://github.com/torvalds/linux/blob/master/drivers/usb/misc/onboard_usb_hub.c

The onboard USB HUB driver is of course more complex because it has to
support other features, but the idea of enabling the power supplies and
toggling the reset signal is essentially the same.

Best regards,
Javier Carrasco


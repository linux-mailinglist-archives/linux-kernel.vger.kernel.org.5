Return-Path: <linux-kernel+bounces-19084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 617B68267A9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 05:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C44141F21AC6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 04:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E737A611A;
	Mon,  8 Jan 2024 04:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EL2R+umI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759304685;
	Mon,  8 Jan 2024 04:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SUJklAoPYlrnw7Zrist9UIBqca/u22J9QbL7w1GVb2GJFiobhIe1aoHcC8RvhQh98VKdcdOKxqn9haPSX1EOgec2HppwlgWKy3O48+T2Z5bxDjzFHVjOHhhZ+7qLUbFr84MxrnIox83pUv6IJGFcpuSCrBTLhQus/hFqsUnIawv2oktFtfTT8gKZyWNqzyqOwfODD1nHOG4aZoz+ktIkqsrscVt1PH2TOVDIDeP4NaHJSMJmh03+bQoJQ+A27pe+1tYqm3vsf0wmn2Dnh32cWJ5/JwcNquDsk2XjeExbkuYPprgpu7DTmG9E4ALs8WT+CbUZSiepIGlCguapB37tQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WiydmimZ69v49XBPKJsQHDefh0zIL3eVY8gAXgLQrHU=;
 b=b0nOg2G4sL3GHUVrvm9byyM6YW+socuzo44CQdknGdRqbs871QLAefPSyYFVGmgphdHwRAj4LSCbP3w7PI44wRUfSDkBETVjfGS9b85YzZCPWTm9YPJ9RZxAZV13Z+rOZVOCHkryCg4uVe/6rTNkG96Br2M+e1gYR1nYElRWfj6F5zqp5upwfJUIXJilgMRs0ZBxYnysGiIGS80sMYpBPuCpeimeHj1kQymdJ7Tr03xohmrAPQ++emsfoIbr9aT/9R2n3v6e98yZsBAs4hR+Oqwno/Pjl+Yj9tKVrb+HEnC5DNjB/SDiD6y6NkkwZbKt3qGl1PLnxomys+nmuf9kRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WiydmimZ69v49XBPKJsQHDefh0zIL3eVY8gAXgLQrHU=;
 b=EL2R+umIyP3o32mUaga8jPrJ+eJ7ZWwAuRUzhMpVuAsC4w6sz96hCLX7+joHQQh7m/6wW3p6748jHJ9ZzXM3sQsMox22irjIL/ZR7bXsODeFkv8xlFPDzuq1URRcWvrZ6HUCOr45CSLSUcEWbbghUjNf0i2pbjfMbF2dTwU2hE0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB7016.namprd12.prod.outlook.com (2603:10b6:303:218::14)
 by IA1PR12MB6385.namprd12.prod.outlook.com (2603:10b6:208:38b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 04:56:20 +0000
Received: from MW4PR12MB7016.namprd12.prod.outlook.com
 ([fe80::9906:988a:788:1079]) by MW4PR12MB7016.namprd12.prod.outlook.com
 ([fe80::9906:988a:788:1079%7]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 04:56:20 +0000
Message-ID: <ff6243f8-4487-2290-1d31-93acbedb27da@amd.com>
Date: Mon, 8 Jan 2024 10:26:13 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [Patch v2 2/2] thunderbolt: Teardown tunnels and reset downstream
 ports created by boot firmware
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Sanath S <Sanath.S@amd.com>, mario.limonciello@amd.com,
 andreas.noever@gmail.com, michael.jamet@intel.com, YehezkelShB@gmail.com,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231219122634.GJ1074920@black.fi.intel.com>
 <0816caa4-81b5-d0f9-2305-80c7fec6abb9@amd.com>
 <20231219180424.GL1074920@black.fi.intel.com>
 <20231220125857.GA2543524@black.fi.intel.com>
 <5bfaa405-b15e-36ef-a4e0-04b93dd983b1@amd.com>
 <257c694f-5aa2-c29b-891d-3a1f480dd4a1@amd.com>
 <20231221095307.GB2543524@black.fi.intel.com>
 <6308b3e6-d935-93cb-b05d-7c9790b091d4@amd.com>
 <20240103171709.GL2543524@black.fi.intel.com>
 <39fc8ce8-baab-bf53-d177-1034dfc81be9@amd.com>
 <20240105070809.GN2543524@black.fi.intel.com>
Content-Language: en-US
From: Sanath S <sanaths2@amd.com>
In-Reply-To: <20240105070809.GN2543524@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0032.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::7) To MW4PR12MB7016.namprd12.prod.outlook.com
 (2603:10b6:303:218::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7016:EE_|IA1PR12MB6385:EE_
X-MS-Office365-Filtering-Correlation-Id: 685a0a60-4466-4413-0a0b-08dc100627c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	upLdtb3y6WE4p/Q7BXFLsSH8ya2tqrNq8K0FJRDD5z1/Uo5ta0Ahg2M+4pU6KhKrA6zSYkf0gm7QF8b+q5EjmoyfySgb0Ea58FthhveA0/d54Yn2XsxMRkBtBqxluFHW5JQu+jY8D4o06VtSXfW8QwDe+KSAPr9ckZpPlOGFfZyZu1cKiHXqCyKL1zwSupuAi3tO4dmVvn55OVPwdUxwtuIX0ZKbKH34vhR+W7pGgH12lvvyuyoaGPuqb2raB5R50bQ3TMA20zXFf9SHzjlWe6RjtvHuZzD/3mzGbaXQ92RU2/Up+kixx9UF6Y5M7XOvvoxlis7Gw7bUakG1R81ZGXQU7D0M3wyXDLOjua43iQTCA5teDJngqEkBtZ+GWxVJ1ijSIpJ1QWgsMbIyz69MLuu0/g3yLTKX15KkPjkTptLRRq7dA+62asV1wH/zy5+DnWvr3HnxNMxD4qinHWfadf8sjIZsrhN+YT0Q41glBoct4AA+CX2/FwlmLz9EeC/nmK2e3p3cGkVDWlk7s89vVofJ3MDuvsXMeJqnKVbGpQ5vJ1fv4endIFSWqHXmA/QksWJit77R6y5/nkc7BuS8BdRZY0e5yeFFeI/LR/XdUoVWPny9ITaw975O0WQtOAJNZqn9pFAQeWFkOS0q4HZqjQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7016.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(376002)(396003)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(31686004)(6666004)(478600001)(38100700002)(83380400001)(53546011)(6512007)(6506007)(26005)(2616005)(8936002)(8676002)(316002)(5660300002)(2906002)(31696002)(4326008)(66556008)(66476007)(6916009)(36756003)(66946007)(41300700001)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RThHd1hYNnBIdm0zbmU0L1lMeTh1UlQ1QnRZdngvNWxQVlk4dmRCWU5ac2Js?=
 =?utf-8?B?dENvOGxDczVXa1RqQk9yQzdveHpONDhyR201VDRWYVJMZEFvdG1vbWtMc0tk?=
 =?utf-8?B?bjB5Z3hTck43ako0YzBkSnd1dmV5WENtZ1hPdk9JQnZ2ZzRWSW1COVRnTGIv?=
 =?utf-8?B?ajVwNUxrdXZzQTNrK3BvN1lPWHc3bmQzSkVpcC9nQVhEMnVqelQvaHdJYjNM?=
 =?utf-8?B?UU5xTEc5T1JMbFNnWnozSFRsTnVpUmFGNUd0MTNPbFEza1JxT09vNGhjeHdn?=
 =?utf-8?B?MXBTY1E5NEhXY1ZJV3dtZ0VYeTZuTENubzdOMll4bEdsZHptNnlmd1dHa0Y0?=
 =?utf-8?B?bkhhS3dUK1c2U0YyT3dNYXpPWW9JeVk1OXY0TlJtbE12c0Q3UjFQbWx1bVJ0?=
 =?utf-8?B?QTRWVUxtT0hiL0p3K0REdGRnNkFaSkQwYmE2dW5MVDh2VlEveVlsUXZORHlU?=
 =?utf-8?B?SitlSTN3RWdvS0Nsalo5L1BPVVNoT0ljS1BzSlcxczYxQ2ZONGNxeFgzdXEz?=
 =?utf-8?B?cklrTjVmRm55Q0FzdHY4ZE5IVHgwMTVNSGtmcVMvVTB4aFE5Rjk0bDNuOXJR?=
 =?utf-8?B?T01yeDlrNEpsdFFSMEh4SFRJcWZzdDUzTXROenN5bm40NTB5d1JGNjAzS1Rq?=
 =?utf-8?B?bXhxMFRSWDRCd1Z6cDAzMnUyeURpU1lIT0Ezc3YrM1FCc0RFVTF6SUhlY0kz?=
 =?utf-8?B?YzI5c2ZlSXp5bHNyanMyYmFFT1FPSGtNTVBKWWdTb01uTm5saFMvajR1Unc5?=
 =?utf-8?B?YUVINVFjRk5TYWJzYysza3VZK0tPNlpPdlYza0c0cktsZzNkSXcrT092Sm10?=
 =?utf-8?B?cVpKMTdTUzNqMnh2bHd0bC9JZzFwa0pkREM2L1BBYWVUeEVtQlVYbnh4bzhi?=
 =?utf-8?B?eDdTU2Erd3h3aGxLZUg1ajdrTVU3SEVoS0xXOUdreWNhWUdleUFOV252SGdW?=
 =?utf-8?B?Mm9WbGErbU9OT2R3endscEtJN3BGVmpKNFcrbWdhZjhPZVVjdmRGN3dCOTYy?=
 =?utf-8?B?R3E4V1ZzTHBIMTdPWTk0Mi9yWTdTWFVOTUMwL3BiRDhkZ3RtSzV6MGsyRmcx?=
 =?utf-8?B?b1ZGRHZFU1B4c3NHTDBwUjJ6alIwa29WUllQNGRtNjdKZjZJbFZIN0NvS3ds?=
 =?utf-8?B?MXJyOEcwUHdRQi9kYVFHWlVlZGFYUG16Y3JjUGpUNFNhenJlbFBlN0c2a01U?=
 =?utf-8?B?OE9QSnlzVUtLVCtDeElsUWo2NHliNXNTT0tuVGozRWVOZUFlTk4xVG9XZVhm?=
 =?utf-8?B?azMwek92M21mYmMzZGtLbFZMTUptL1NuamVWSUpsZStnY2VFWHdrZ3IvZS9q?=
 =?utf-8?B?L1pOaVIzdWZYdWE1aXUxeTg4djNiVXlzRWpma2FMSlBsTUhETXpzRHlCeW9t?=
 =?utf-8?B?d3JWWTZuTS94WGw5VkpkRjJNQi9mKzBKc29BSWxSSHdhdGxXcWdRNWNDYkIz?=
 =?utf-8?B?Q1I5RHNpWkZ6K3ZUVnVJTEM1TGRXZWFqU25iSENUOURaMDZxY01XeG5HUWN2?=
 =?utf-8?B?c3VIekdLZ3N1RzdMR214RC9sd3Y5eHNzZkEwYWJhMTR1bkJiWkJ0Vk1Gbm5x?=
 =?utf-8?B?SUFUU09GL2ZrV0dIUFh4dTVVcTlCbldqK3lGMGwrSGVRTXc2RVRVUmNVN21V?=
 =?utf-8?B?c2FSQmRWbGk1UFFCRHovVFFNNnFCckRheWoxaWo5ck1zNXVjanBBaXhyLzNv?=
 =?utf-8?B?SHJrV0JxTmc4bU9IemZ1emNpa0o4amdlaGQxcEZJZThveCs5NGZZYW1nMWZp?=
 =?utf-8?B?ZFlER0ZDRGczY0tJVmV4OG5aOHg2dmwxQ3ZpK042M3JLbkk0YjM1UFF5VDA2?=
 =?utf-8?B?RjFxeS83cm1Ta1RicUpUbWlZeUlieEYvV3haSXhSVi9XbGNOL1Zya29vZFFU?=
 =?utf-8?B?bGpxRFZrYjU3cWw3UE55VEQ5R3ZLQmVOV001UFZURlZZZzZES0c1a3JEejZ3?=
 =?utf-8?B?TWV4ZjJNRFZ5MWpkVEJxRWYxVi9qVnBFRjZyZVZ6SUdqRzRLNVZNSHdZYlRE?=
 =?utf-8?B?RjNaOUtwWG5qYzEwaUVCZGVTVVMyWmx2amNNYUVZS1FmT1gvbkx4NEV1RG9l?=
 =?utf-8?B?eVVPaHFhL3VTV0tDcXQyem8yQUdtbWRMSUhidW1tK09uRmJuK0F6QXBWT1Za?=
 =?utf-8?Q?tIJCK8ugS17/L8KV+8LvDuSK5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 685a0a60-4466-4413-0a0b-08dc100627c4
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7016.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 04:56:20.6844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oGrDISHXwnznMUP0fm3XMzxCRKrOH8+NeveyLj0ZwK96Kfc0bIm1sG8Y/l5xVEmdwR7ZqEDXlbo8LF5E0IFBIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6385


On 1/5/2024 12:38 PM, Mika Westerberg wrote:
> On Thu, Jan 04, 2024 at 07:20:05PM +0530, Sanath S wrote:
>> On 1/3/2024 10:47 PM, Mika Westerberg wrote:
>>> On Wed, Jan 03, 2024 at 07:45:56PM +0530, Sanath S wrote:
>>>> On 12/21/2023 3:23 PM, Mika Westerberg wrote:
>>>>> On Thu, Dec 21, 2023 at 03:01:50PM +0530, Sanath S wrote:
>>>>>>> Sure. I'll check with these combinations.
>>>>>> Can you name any docks that meets these requirements ? I'll try to get
>>>>>> hold of it here and check.
>>>>> Pretty much every Titan Ridge based dock. For instance Dell WD19TB.
>>>>>
>>>>> I have some hardware here that I can use to try it out too.
>>>> It seems that issue is seen on Dell WD19TB too. So this fix may have to
>>>> extended to TBT3 as well ?
>>> Hm, what issue? I thought this works accross all the supported devices
>>> due to the DFP, no?
>>>
>>>> I'll give it a try this week and share the observation.
>> Got my hands on Dell WD19TB. And it works!
>>
>> Here is lspci -t output with and without fix
>>
>> without fix:
>>             +-03.1-[04-62]----00.0-[05-07]--+-02.0-[06]----00.0
>>             |                               \-04.0-[07]--
>> With fix:
>>             +-03.1-[04-62]----00.0-[05-62]--+-02.0-[06]----00.0
>>             |                               \-04.0-[07-62]--
>>
>> I'll send out v3 with with splitting into 2/3 patches(Will see how it looks
>> good).
> Okay and you checked also that with the WD19TB (and its integrated xHCI)
> there are no additional boot delays because of the reset?
I did not observe any delays. As now we are not doing any discover as 
well before resetting.
It was ready to use as soon as I see login screen.
>> Any other comments, we can take it on v3.
> Sure.
I've sent v3.


Return-Path: <linux-kernel+bounces-16736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03955824319
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 078FE1C23E58
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 13:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4257F23755;
	Thu,  4 Jan 2024 13:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wbwyxLBc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C4B21362;
	Thu,  4 Jan 2024 13:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q8lBxiV2GJefMtLUxLm98DJ4wviLPhOjdKE0NKuVpzjulXlZbl1KSDFEKrZRARsoo2vEPSDdg2CRX7J29ayva0Scjxg6rpHSTGYEsBD23zZ/IYAX/EIAq+QB1cMO5YZtkDvIHfLX/IRVvUPS+4YzLXJ6HRVYbclKbXX2hXu8Yn96HhJ3ixsL5MCKgKSKDl97XyzrgoGYFxCSh/iwK6hZKGd2rtGkeEwS/REcKIBuvhIe0gylkwt5pyvr56b+chdkEooLfYdLZwnoSXLq6S2uQx4Y7I7VgDRE+P9wreLQi1Ete/5nDIhaMPWn+XeYd6zKqZMt8zKlxGGLxqKIUllLYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WPXO6NRqsF75xnNNyd8R9SlWlUZHtKzmer9F+eDV4VM=;
 b=Ipkk/XptTwdO8jg/9WMPn3/sSIyiGLfAaA0c90z70FSFBsJb/Yv0Mpy+RHr5WpSUC1z2EZ1K43Q/CbHYvtZa2fkNN8/MjeZ0ulmzpKGPj8N4/16HVY9G1KXDSBoiTos0XPRca0nAQoUZT/yMNDC9yvVmTt0l/4578iEr8WCzblv1LYvjyXMvic83nk0t2s9Do6n6f/5x9RbQH2YqdYLSNo4smW8+7wXFuUg/xtWejpmrNQ1BwGhR35/S1MK0ycKdlWxMcO9KAej5fUxLcVnMgR1aE4jLkhTIfY88B10Fqq/ccx50MwtIR96nJ8/FO0iHos4JPGWJnBjuQGS+8IrBgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WPXO6NRqsF75xnNNyd8R9SlWlUZHtKzmer9F+eDV4VM=;
 b=wbwyxLBcXosz9XKuZ3NgWMIaHtZDXBz+3FjYM8Jv+UqaJb8L/kIz9E0XnnUmFwhmoJGTSeu3kyKGO3iTBj/pQYOLetjIoCAk+ZDb0jLbm28+H430tT2BfVJ/Piw7d9Q20N4dix/AjxZvnr4FrJu6tN9mMDEbWXD2ojdr+wL0ga8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB7016.namprd12.prod.outlook.com (2603:10b6:303:218::14)
 by PH7PR12MB6539.namprd12.prod.outlook.com (2603:10b6:510:1f0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16; Thu, 4 Jan
 2024 13:50:13 +0000
Received: from MW4PR12MB7016.namprd12.prod.outlook.com
 ([fe80::9906:988a:788:1079]) by MW4PR12MB7016.namprd12.prod.outlook.com
 ([fe80::9906:988a:788:1079%7]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 13:50:13 +0000
Message-ID: <39fc8ce8-baab-bf53-d177-1034dfc81be9@amd.com>
Date: Thu, 4 Jan 2024 19:20:05 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [Patch v2 2/2] thunderbolt: Teardown tunnels and reset downstream
 ports created by boot firmware
Content-Language: en-US
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Sanath S <Sanath.S@amd.com>, mario.limonciello@amd.com,
 andreas.noever@gmail.com, michael.jamet@intel.com, YehezkelShB@gmail.com,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231218131840.GH1074920@black.fi.intel.com>
 <0fd5c09f-1cf2-8813-a8f9-1bd856e3a298@amd.com>
 <20231219122634.GJ1074920@black.fi.intel.com>
 <0816caa4-81b5-d0f9-2305-80c7fec6abb9@amd.com>
 <20231219180424.GL1074920@black.fi.intel.com>
 <20231220125857.GA2543524@black.fi.intel.com>
 <5bfaa405-b15e-36ef-a4e0-04b93dd983b1@amd.com>
 <257c694f-5aa2-c29b-891d-3a1f480dd4a1@amd.com>
 <20231221095307.GB2543524@black.fi.intel.com>
 <6308b3e6-d935-93cb-b05d-7c9790b091d4@amd.com>
 <20240103171709.GL2543524@black.fi.intel.com>
From: Sanath S <sanaths2@amd.com>
In-Reply-To: <20240103171709.GL2543524@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0215.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::8) To MW4PR12MB7016.namprd12.prod.outlook.com
 (2603:10b6:303:218::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7016:EE_|PH7PR12MB6539:EE_
X-MS-Office365-Filtering-Correlation-Id: 796b3d89-9735-44ce-7b38-08dc0d2c1300
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	G4+aGEQnyAOaghG8YEphI3LGbpjxEaargSuyfQfjRHcTLqpWzkVN/dMCxsRd0OHNgzLyc0YbUZBe2VfmpNdpsX+wRK5L4aTURTVmgl4VItfyTyMA+anKMD+uPvvtiSTSXuWrQZLqAnIemjZWFt9s0CfAfZH2jVCkRWuvQu+XdEZBl3wUgRvkLMvZbcbpcav6MXJh9s09It3ZHQpljU3ODWqqzns0wCen3rJGT/n3iIMtNCQBvCAZc9VFFJGqTxhDFQMSfADs/6cMJo1x3XBm1F98A/V9huJ5vIdeUA+wazbbOkmxws1ivi/4ZBKHOMdg+v18oBQKZp73OOj4ZB7/+fPkG6LBpYaxt+/u55Nh1kbxMfd2pbncqB4blF7oyVPIPVFtHezK/l53Szx4rs/7Lv7vgomel/Z9K7O1OzuhruXNeiN93ybioEHuDnIQ+N2VpkA4zlDGZ0r4d9LMZLfpuiC/GZ9FygOmZc6HQanGbwvgdzskAPXcVeRf5ZLspECFRjxvm0hLh0SgnlcK6bUzk+aLXMMXG9f8/b6sQ+Rfsko5PT6VtLTkFlUOGCKLCYZ1qi1j+fjmVkGWeOD5s4ttZMHLfEzcZJ/kxxCaARsLwj2Ij7xpZ7994N0jaCv7lkV2KhG0oxd2WqeWfeU/HxI05Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7016.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(346002)(136003)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(38100700002)(2906002)(5660300002)(31696002)(36756003)(41300700001)(316002)(6486002)(8936002)(53546011)(6512007)(6506007)(66556008)(66946007)(66476007)(6916009)(31686004)(4326008)(6666004)(2616005)(8676002)(26005)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SFVuNlJEaVkxMHNOT3pkdGlwSFRTNXFDTGRMRXpBa0Uva28xdmFmaGpXWkc3?=
 =?utf-8?B?TGtxcUdBWkF3WEVsMW1YWW9WZFNYbm43Nnk1OTJydXlva0JFTGhueFVDODBa?=
 =?utf-8?B?RHFFSWFGQWQxNmhLVkNHMVlCTnYrZU16MXhpbGJ5aVV2NTgzelROb051ZzJs?=
 =?utf-8?B?UGFVRVlzL3Rva1RWTmh2OWF1TmRsZno3TWZ5dVpBM0JpS3hWZUNzTFJlQU0z?=
 =?utf-8?B?OEZ3VHh6SnRrYzdMK1l1aFJCaWlPT2lPM2Q2MzZWNWgyQkh1aU15UmtEdW02?=
 =?utf-8?B?N29DN0tZRVFhNkR4a0RBNHU3c2c1eUNpYUYwbld2dkZzRnZyTGUvL0h3WnpP?=
 =?utf-8?B?RGFlLzRGMUlTMjVWMHpXYVRYaEozaFFXYmtDUzlrV0tEMXErREtESlhzYU1y?=
 =?utf-8?B?Sk1HQ21pLzB1Q3BjMVRNekFjSHJmbnNDYnMvaEZhYisyVkZCWmRHNk42NzZh?=
 =?utf-8?B?bDFHLzRMM29tWTRvSkwxZW9JZ1pOVlpwTWhJQVVtdXZ2Z1g3Z01jNWhydytS?=
 =?utf-8?B?RGJsTWM2WWwwT2hCcmxOcC8rTlBCaWFtbVZidHJtVTJidXl6QnRDdnNWYlZV?=
 =?utf-8?B?S2NHWFlhcXBvMU9ocDR6dS94VHFSMWVsSERXUm5TS1NTNmhQZUZFQ1dmUXVV?=
 =?utf-8?B?YlpPR2NTamNSTCtOTWNOZytWOFMzQTFGdGNmUnpiRDFpcUV4VDZNdStIcGRr?=
 =?utf-8?B?Qk1kbHhRVlVwc2dOZFNwdkliYjU4c0tnRUViQWw1Sk5oQStNUmIrU0FUN1VY?=
 =?utf-8?B?WHg3QTUwSElTTXRRaERFWC9KdTNaanJIR2FadFpVcEdDOFVCWGlBOGJPMHNa?=
 =?utf-8?B?YlEyK21tQjB4UWxiaHVOZTBlazRGZEg0OHhLbTFOMCtHS1RCWEI4Z1YyZGtn?=
 =?utf-8?B?YUhxbEVLdDF2QnU5aDlxWkJ2TjBQTkt3TmQrRm9JcFpUVnVrYmlXMGloOElu?=
 =?utf-8?B?NElqRHZ4Z0RnanZNVC9hMVF0MjZrM2M5QUZ0Y3JFVDAyRTd4cW0zc29rK3N1?=
 =?utf-8?B?WHpDUktNdXpvUlF2ZDZmeUkyN1k1N28yVTYrYzg1YVArV3A3NlVvNlZZQkVr?=
 =?utf-8?B?MENvU3VkK3JBYUZFdGVNQmg0SFFJRGNiVUc3cTROWE0zZ1dOTXRhVVNqaHow?=
 =?utf-8?B?aWdHb01lME43N3M5NXF5RHJ4cVZKa29Gd3piV2w5UmYvWmV2VkhUcFhaeXFi?=
 =?utf-8?B?bnNiSDdIblkrQitMRnV1WEYrOWltcDc5MG9aOUZSZG0zR2h0OUxJb0M1MkpG?=
 =?utf-8?B?REF5VUx2QjBWbU9JbE84RE02SDAzZkNGT0JISkYrbGlzNXJqS0IrdFgrdWdJ?=
 =?utf-8?B?MldRbVJPQVVpeGgrRGQ4cnVvbjJBM1JEZE1mN0svbjRDMVgwcEVpc1FaVlJa?=
 =?utf-8?B?elYzQ21lNDVQclkwQ3BmZ1lXRVNrV1AwT3pjbkdFYWRzYWhjaGdJZ09DOFhq?=
 =?utf-8?B?S1paejhKcWlPa09ySC96VmFnVWM0b0YzMHBLNEE1aDhwMUFBMnVRQ0hhNEhU?=
 =?utf-8?B?ZHFYbjQ2Rko1Y05wZXRVSmowQS9HeFBCZjJrcTNTVk9hL3Zyd1dZODE1OHJr?=
 =?utf-8?B?VkM1b3BlVnRWa042NzZPT2RKK2NpN3RWdFZBa1J0eDZleHJSY3ZwMnV6NHBF?=
 =?utf-8?B?OGFMWm1mSVVTclJRaG1KUVJmZUtxMU1sdHVuSVE4NTJHSmZyZjVkSWZSOGNk?=
 =?utf-8?B?N1ZVcXJJa2RURUJ3R1J4Q3ZlcnlvRkh4SkxYeXhrUHNhc1JnOUg1Y0tqWGsy?=
 =?utf-8?B?WlNkQXRkUXdRam1YZDlubGFSN2FXUVIxd3FMMzd2cVRjWVptanJUQ2M1OGho?=
 =?utf-8?B?ZEk2b1VsbVdZTkk5bjlrRlVQT3plWVNvMjIzU2NmTXNUV0FyTFlFazJKVyt1?=
 =?utf-8?B?dUJZMTJ2dXRJVW1wL0I1VGt4TU1zdFFZeDRsWjhrTzNGSE9sb1dTT2Qybi9W?=
 =?utf-8?B?dkg4cDVqYThYRlhNaldRNXFob2wrR3lyS3NScUNSRUE1akdtekpGVHU1K3lB?=
 =?utf-8?B?UFllbDh4RWV1SjRWQVM1ODdkUVU0YzJMTGlrK09sYWRlWUpBRDNNQVYvTFlt?=
 =?utf-8?B?RjdXUkU2YU1xdDQ4R3RVY01Eb3Y0aWhwSElDVmZwWm9TT3lwNVlsRUJ5ZU5j?=
 =?utf-8?Q?cUwy9UuXw7EFb3SuKOHJilpFn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 796b3d89-9735-44ce-7b38-08dc0d2c1300
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7016.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 13:50:13.1393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZjL0h53cspY5/nbFjAsBfAywjaBNxjZACyD2WyPDBVEAR6D7cmUEhYpz3YA3WaLEWYmk2RrqhbsDwD6+neG72Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6539


On 1/3/2024 10:47 PM, Mika Westerberg wrote:
> On Wed, Jan 03, 2024 at 07:45:56PM +0530, Sanath S wrote:
>> On 12/21/2023 3:23 PM, Mika Westerberg wrote:
>>> On Thu, Dec 21, 2023 at 03:01:50PM +0530, Sanath S wrote:
>>>>> Sure. I'll check with these combinations.
>>>> Can you name any docks that meets these requirements ? I'll try to get
>>>> hold of it here and check.
>>> Pretty much every Titan Ridge based dock. For instance Dell WD19TB.
>>>
>>> I have some hardware here that I can use to try it out too.
>> It seems that issue is seen on Dell WD19TB too. So this fix may have to
>> extended to TBT3 as well ?
> Hm, what issue? I thought this works accross all the supported devices
> due to the DFP, no?
>
>> I'll give it a try this week and share the observation.
Got my hands on Dell WD19TB. And it works!

Here is lspci -t output with and without fix

without fix:
            +-03.1-[04-62]----00.0-[05-07]--+-02.0-[06]----00.0
            |                               \-04.0-[07]--
With fix:
            +-03.1-[04-62]----00.0-[05-62]--+-02.0-[06]----00.0
            |                               \-04.0-[07-62]--

I'll send out v3 with with splitting into 2/3 patches(Will see how it 
looks good).
Any other comments, we can take it on v3.
> Okay thanks!
>
>> Any luck from your end ?
> I did not have time to try it out yet unfortunately.


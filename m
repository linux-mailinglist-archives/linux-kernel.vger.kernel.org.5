Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A21A579FFDD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 11:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235923AbjINJVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 05:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234427AbjINJVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 05:21:06 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664DDCF3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 02:21:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oFTYcYOTc3NH+7yFmpAXJRMYg2vBvpL0YgKDkW5y/+eu4mFbJTip5qVfODmCr3FWnkFaeNvI0rztsbICTBWYAeNTSR8lL58DK6ciDcDo9ZrlFMefy+7izyVXUnoZbbtpvcU2Fzw91++H68ylmNmRxTI7rR2QaqeVpyJv0mwPG2+Jespn1Ji/kBDPqqgL3Q6bfaq2BRjm3B1z0RnrtY6oaeZJ5An71RE7QQmmL5u0yU1tkx5Wp3W+ikILjcyEwrav7KCalQHf+vCV3dymXZWNm+dDx3+Kqmx/AbsqFegN45KCBBwL8bcytjPk0PxvBlF4IdyiwGmKWq9TDfkql9nY6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8KZzrMmnxCeVSunLU/q5h6Z8vZlUx0HJai4eX+w/e7w=;
 b=RR6qhw8+1wMtDa9o8rguKvhDmA2YHxdopbgZ8w3Z1HcrPqUgnl0rCBONhuYftR72EHZUaQB3qfbQp6dox8cNVSnB6U2uTW5PXUwgkudLwoF5/Lu00qEqbMxDp73c23yD53gxZ1T7ueUMapnkobTysmRLVQcMoNB8B5YehsvYb5jFryZsrkmrM7qSHyBpRBJ44VfGvz3CO5dxAHCm4BUcLjCDdInQ9rn477EPEklkZFPK0525Jvc0OEqniz5b6OLGpqvQX3ycUtL7AOFeeOLVTodFfer3yWHA+UB2oKMynJYA1svWNZWt/NR8OjjJBg0Jr9ABVUhPY3XR6vPO8VO/Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8KZzrMmnxCeVSunLU/q5h6Z8vZlUx0HJai4eX+w/e7w=;
 b=3zOVfvBf2AzZuQ6nK8jDjNKz8YifFeOw4sVTik13LPUK3jrrA70F96Ay/Ln5UIorgtvA3hH3jIbz1VpqVyPPfDkXsF7iTEYQZRThXujzdks2EP/EIrBcpooZfRHSAHwsvXZ+ekwewFfAZRJYHEHpid42oO93DLUTWIJb9KsBB6I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by DM4PR12MB7550.namprd12.prod.outlook.com (2603:10b6:8:10e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 09:21:00 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::319e:591f:38a0:6bbb]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::319e:591f:38a0:6bbb%6]) with mapi id 15.20.6768.036; Thu, 14 Sep 2023
 09:21:00 +0000
Message-ID: <011011ee-4f83-3545-4ca2-55bc0bef284a@amd.com>
Date:   Thu, 14 Sep 2023 14:50:45 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [patch V4 24/41] x86/cpu: Provide cpu_init/parse_topology()
Content-Language: en-US
From:   K Prateek Nayak <kprateek.nayak@amd.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Pu Wen <puwen@hygon.cn>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Gautham Shenoy <gautham.shenoy@amd.com>
References: <20230814085006.593997112@linutronix.de>
 <20230814085113.471353147@linutronix.de>
 <934072fe-eca2-44df-94e7-9fed1dc8b502@amd.com> <87r0nn8ots.ffs@tglx>
 <4a4d5a89-b024-ea49-8740-1f3aef412c15@amd.com>
In-Reply-To: <4a4d5a89-b024-ea49-8740-1f3aef412c15@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0170.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::12) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|DM4PR12MB7550:EE_
X-MS-Office365-Filtering-Correlation-Id: e078798c-22ff-42e2-168d-08dbb503e872
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EhemGrlbqfryhlkjwNNz2dy3bgCdNRcBXRzx2tagXDqQ+5oY6qxpKRzuetoZVs8UTlG4ivrtFkAphMhsyN5+gmfrHtVuceY5nvNK7e/DiwzQQQHHsUXCvkaZfDoeCkjvcfO/8vk9QpnizfVvxzUR8/axktWv/AoeKYilYJj2/zViD+6F9s1SXK7wYrTXrXfB4NLC9uoMd3k3HZsxNUkLrNVGk+woGhK8iM7JJ2LoJ4huDncw1QyeGSE6vKBm2slBZPiFZVhokEzMct/PdRxm7y6sqYrMTlahHwp1tkwMjU7ogoMnzw8B55/CpI6q3fm8S+tTLAAMeXsQyevReSZ8XIQRden3ItTTaq/gTW2sKphFldUhprYGm4ZUsmny5CFrC2gm31g/yECCdBXEKwQN5Hd92IR4IttFLzWQWIpAxM5PVuaFK2GOWPbW1cNgOWhhdZ+glAHeR+rTOBX3naaSJNr5QjFPUkoyH7BLkVjJqr0xH8WqQzaqf7x95Z+XrSXT5SBmV9dx/vyUp8Qas4Nh9v4VDFN8QRvRWOpJa2xCvdrlhRfiRFpP/c+jmelB6+PPYf5K/Q6xknDp4UO+XF+GnAoCW67QAWUzc13U4KWf3DAkyyEprmCexnvFrjQ2bbvdOqEzF7bsJb4nEwgQOT9y3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(396003)(346002)(376002)(1800799009)(451199024)(186009)(2906002)(31686004)(5660300002)(7416002)(8936002)(8676002)(4326008)(41300700001)(66946007)(66556008)(86362001)(31696002)(110136005)(54906003)(316002)(66476007)(6506007)(38100700002)(6486002)(478600001)(26005)(2616005)(83380400001)(6512007)(6666004)(36756003)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1BRam93dmVwYzJKTVBYL01ZaHNObzdTSERJcGVyTk5qUjltNzZKNTNyOXlI?=
 =?utf-8?B?cm1sRFdXTEJMbWxIWWplNU12N2JpVjIxend3SFlyVnU3T2RkWHU0RDZvRlhz?=
 =?utf-8?B?czRyWWJXc0Zjd1c3eTdXengxUmpBbWQ1SWozaW83b2thWmNYV21nU3JVTFpB?=
 =?utf-8?B?c0I3bDNtTUpENG9pMHFwV1FYL2s1NTRWRm0zK3U5MzJ5dzNsaTdkSXVJU0RG?=
 =?utf-8?B?RVNhdzJzOEhMWjZ2RTc2c251U3A1MUk3ZVpHS3ZzWHduQzZzUkpTWFpGSkVK?=
 =?utf-8?B?RWIvQTFPWlVUUFQrejIxR05VMGJ4NmNmWWpSL0RubHJZMHpwVXhHMER6Q0p1?=
 =?utf-8?B?REFuNGVENlVHUDNZMGtob2NYdi9Pd1lsUEJhU1NLK3dHZjhZSU1lL1dPTlhy?=
 =?utf-8?B?bWdDYUZHNE5DbCtVREZqbWQrQU9Za0dhRk1OTFgraXVXY2ZLYnNLV0lkWkdw?=
 =?utf-8?B?OFMyNzFIZ2pVUDBqN0wxT3VQaWhvK0dCanNFNDcvYzE5SUpkZGpFT1lvYWhy?=
 =?utf-8?B?ak9FTzhIaG95RGtBS1JiUlQ1UU9zTzczc2dqRHRRREtibkxPV2FGRFdiRnFs?=
 =?utf-8?B?cnRjMUtWNUM0c1VSRitBcEQ0N0Q3ZVVoWTRxWUY0UDBqSkg2UGhtZ1RON2JS?=
 =?utf-8?B?SkdXWnUvcTI5Smh5dmt3OEdFU2ZlY0QrbFNXZ09wSUs2SThqYXp2eVpDd1dG?=
 =?utf-8?B?Tm1YQm1wVm9ES3pHVEl4dkVUR0JUQ1A0M3FGSGUzUlFSbE0wZ3hzb2FaK2tE?=
 =?utf-8?B?ZjlJajZQVmYxM2V2UG1zL1Y5VnRaUEJzTTBrYjR3N3IwbGJJMlZBNUlkaEVG?=
 =?utf-8?B?bS9OZitvYUZaN0dLeWV3K25DM01STGVyeHJmYVJzdEZoQVA5N1ZpODlUYmRT?=
 =?utf-8?B?aU0xQVk0SC82WEVrM3ZleDZEdzdsdzJ5VThWUVpmNmxnLytDeWk4SU1SZ3Mx?=
 =?utf-8?B?Q2lncWN4TUk2c0liZTd0YVh3Q0ptTHNna0ZsUVZzZjFOQ1V4NXZSZDg2YWZy?=
 =?utf-8?B?ZGRJUlNPZ0NLT1UyQXM2YjNEQ1c0azFCZzEvNjhhSGZ2S3UvWWF3VkRQTlhn?=
 =?utf-8?B?RjUzMm1mS25aUzVURmhUR3FIZE5pckRIRzMybXBlTFVPclFSbCtWcHNMUHBk?=
 =?utf-8?B?LzhKWldHLzVOQ2ExNC9qc1BuUFVYeWZBQ2tLdWdTSDVlSkxKbDJRdVV0YWlB?=
 =?utf-8?B?anZsdkxUUWNEMXVRUVhybE0reGNqS1hwTms2VHQ2VkU3M0Y1WlBZMVhHSjQ4?=
 =?utf-8?B?cC9Ibi9vRzhjSzFXWVAzY2RCUUR5OHMrcm9uMTFKRHQzeHFjWjl5bFZTSjIv?=
 =?utf-8?B?ckc3NVJERStueTJxQ0lPaVdmWE1NLzRUNUtnamx5ZTVHeEEvcUF5dlRHWE10?=
 =?utf-8?B?ekU1bU55L0tGNGJmejlSNzdxc3dycDRScnlFdUkyN0ZyU2ZtVkNteWIxV3BQ?=
 =?utf-8?B?ZGw2SXdHaHFGSWdBVHZRYnlpMm1HTnIyTWp2Sk1nS0tHdlBkTHVkeTRqb0d0?=
 =?utf-8?B?dnlDZ2JPWERaYkpWb2RPRGFZOFljc2Q2UVZoTlY4RXB5d2RMT21rZUpSMEdE?=
 =?utf-8?B?ZktoTzEydnIvK1VVZUd5NHlCN3FvM04ycGRtV3Qvdmo4MktYYlpNa3ZQYUky?=
 =?utf-8?B?YkprT0xVSHVDNzRKUVMyWVlSYWJCU2l2dGN4YTJZL2lPamRWbkJWNE1oQzh3?=
 =?utf-8?B?TWJSVDZkRHhoaHNRSVIvL0ZwZTZHMExuMC9nVyttRHBpRVhWODZxQzR4aHVM?=
 =?utf-8?B?THNnRy9iN3lvVkEya05yVEFYa250N1N0RTdSMENkQlpnSVNEQndLMTk1U25O?=
 =?utf-8?B?MGhwY3RtN1NVbm5uRVdTZW4rYVJQdnFVYmdqazlaTENDdUE0R2JvMHJweHY2?=
 =?utf-8?B?NzhnV0pNdmQ5KzZoR1ZOMzkxcU9VNzRnT1FtUzdQdktBN3RZejZ3YWpWbmNO?=
 =?utf-8?B?QzRJQUZVU0lHOVV1ZDVubDVWWkwwZVowelJWTkswS3oyaTE3aFFNVHNYZFZL?=
 =?utf-8?B?SXVmRFg1eUZlWXlobW5OYmZtbEdxSnB1RXUvSWRBT2xteHFNaVU1RHd0SE4v?=
 =?utf-8?B?Z2E5SEE2bTJWc1A3RW1rODNHWHJscUFBWGp2V2poOEVvREhEeVRsZ1hzcEZ2?=
 =?utf-8?Q?rmFGEBnEGfjOQ18YUc7ryNyD8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e078798c-22ff-42e2-168d-08dbb503e872
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 09:20:59.6062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WpfT8cbDi9Z7bUvPdOLwIq9bCPItLNu0r1TAAG3vs0mgAmhfwcc3Qmq6Keel74FK2r/1UgfazLDjPQgQNzInTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7550
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Thomas,

On 8/28/2023 7:58 PM, K Prateek Nayak wrote:
> Hello Thomas,
> 
> On 8/28/2023 3:35 PM, Thomas Gleixner wrote:
>> Prateek!
>>
>> On Mon, Aug 28 2023 at 11:37, K. Prateek Nayak wrote:
>>> On 8/14/2023 2:24 PM, Thomas Gleixner wrote:
>>>
>>> Since these enums come from the description of level type of CPUID leaf
>>> 0x1f, can we have a short description clarifying what each signify. This
>>> will also help clarify the mappings for AMD's extended CPUID leaf
>>> 0x80000026 (specifically for CCX and CCD level types). I had following
>>> in my mind:
>>
>> Makes sense.
>>
>>>  	TOPO_MODULE_DOMAIN,
>>> +	/*
>>> +	 * If exists, represents a group of tiles within
>>> +	 * an instance of the next domain
>>> +	 *
>>> +	 * On Intel: This level contains a group of Tile
>>> +	 * type as described by CPUID leaf 0x1f
>>> +	 *
>>> +	 * On AMD: This is the group of "Complex" type
>>> +	 * instances as described by CPUID leaf
>>> +	 * 0x8000_0026
>>> +	 */
>>>  	TOPO_TILE_DOMAIN,
>>> +	/*
>>> +	 * If exists, represents a group of dies within an
>>> +	 * instance of the next domain
>>> +	 *
>>> +	 * On Intel: This level contains group of Die
>>> +	 * type as described by CPUID leaf 0x1f
>>> +	 *
>>> +	 * On AMD: This is the group of "CCD (Die)"
>>> +	 * type instances as described by CPUID leaf
>>> +	 * 0x8000_0026
>>> +	 */
>>>  	TOPO_DIE_DOMAIN,
>>> +	/*
>>> +	 * If exists, represents a group of packages
>>> +	 * within the root domain
>>> +	 */
>>>  	TOPO_PKG_DOMAIN,
>>> +	/* Topmost domain with a singular instance */
>>>  	TOPO_ROOT_DOMAIN,
>>>  	TOPO_MAX_DOMAIN,
>>>  };
>>
>> Now this begs the obvious question what the actual meaning of these
>> domains is and what's their relevance for the kernel.
>>
>> It's probably undisputed what SMT/CORE mean and what their relevance is.
>> The PKG/DIE domains are pretty clear too.
> 
> Yup! Those seem to be clear.
> 
>>
>> Now we have:
>>
>>     MODULE      (Intel only)
>>
>>     TILE        Intel, AMD names it "Complex"
> 
> So here is my interpretation of 0x1f since I could not find much in the
> SDM for these level types.

Turns out, there is indeed more information about these types in SDM.
Intel SDM Vol. 3A, in Sec. 9.9.1 "Hierarchical Mapping of Shared
Resources" contains description of these level. I'll quote it here for
ease of readers:

"""
The decomposition of an APIC_ID may consist of several sub fields
representing the topology within a physical processor package, the
higher-order bits of an APIC ID may also be used by cluster vendors to
represent the topology of cluster nodes of each coherent multiprocessor
systems:

o Cluster : Some multi-threading environments consists of multiple
	    clusters of multi-processor systems. The CLUSTER_ID
	    sub-field is usually supported by vendor firmware to
	    distinguish different clusters. For nonclustered systems,
	    CLUSTER_ID is usually 0 and system topology is reduced.

o Package : A physical processor package mates with a socket. A package
	    may contain one or more software visible die. The PACKAGE_ID
	    sub-field distinguishes different physical packages within a
	    cluster.

o Die	  : A software-visible chip inside a package. The DIE_ID
	    sub-field distinguishes different die within a package. If
	    there are no software visible die, the width of this bit
	    field is 0.

o DieGrp  : A group of die that share certain resources.

o Tile	  : A set of cores that share certain resources. The TILE_ID
	    sub-field distinguishes different tiles. If there are no
	    software visible tiles, the width of this bit field is 0.

o Module  : A set of cores that share certain resources. The MODULE_ID
	    sub-field distinguishes different modules. If there are no
	    software visible modules, the width of this bit field is 0.

o Core	  : Processor cores may be contained within modules, within
	    tiles, on software-visible die, or appear directly at the
	    package domain. The CORE_ID sub-field distinguishes
	    processor cores. For a single-core processor, the width of
	    this bit field is 0.

o Logical Processor : A processor core provides one or more logical
	    processors sharing execution resources. The
	    LOGICAL_PROCESSOR_ID sub-field distinguishes logical
	    processors in a core. The width of this bit field is
	    non-zero if a processor core provides more than one logical
	    processors.
"""

So some questions to Intel folks to determine whether mapping AMD's
Complex to Tile makes sense or not:

- What are the "certain resources" a group of module / tile share?

- Module and Tile both use the phrase "set of cores" in their
  description. Does this mean their existence is mutually exclusive?

AMD's Complex (CCX) marks the L3 cache boundary. If either of the
"certain resources" refer to L3 cache, then Complex can be safely mapped
to the respective level without any fear of misinterpretation of the
characteristics.

Also, I do not see a "DieGrp" domain in the "x86_topology_domains". Is
this because of the lack of "software visible" aspect of it despite its
possible existence?

> [..snip..]
--
Thanks and Regards,
Prateek

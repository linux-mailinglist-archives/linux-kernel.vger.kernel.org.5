Return-Path: <linux-kernel+bounces-25050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6000B82C6E4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 22:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9EE3B21E00
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 21:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C72F175B0;
	Fri, 12 Jan 2024 21:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WDACWI9J"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D6415E94;
	Fri, 12 Jan 2024 21:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fd/9T53Gh+7idJ323io9J0NXkXSIFLv1/ZK9EfqGk+8eHRWnJDu2WGqCHKPO8JzvDbmkqcYCblrHoM7QqeESQVDV+yDV2gCDJrSmVu3oNkN+lH89IgkGYMPnsg8EhtQIZBmlWZjNmoW/j5E8XS7tmooNUK27neY3BDQG27RPu/CYm3jTztMx9JoPGva0juZRe0RxmEbaWJS2RoVSdjgn551tNg3D97cbNugrmuTkkfilvbv4ylvyOKjJS7NLbhGgQ7v3K6a8mjbwMXzcmZWAfs04TceTNw77EodHgSxL7foXdtf9ON1efZjkNHH6YN0K1Fvv0s7tX+Su+vxgOTCxEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sevUwa48a7Og2C8OUcw9D78OmqWv5oyTyNenWiiDtCQ=;
 b=STm0R+/jHXPnV1ebrFaXktLxdnvuxtNnmsoSOGzXYMH5BHbkdDd0NRqFGCe/kTGXz5ft2J0QkGhRTBJzncPVQWweogRfvjWzSIyCP9VSHALMHQqMjv7h6gD+4G/5pDcMEMw8i//BPkNlu70x/f/iY/m5GNQREm+ZP4+aAbN7YMHqDeOUmeIqJ3b2BrVRYc61clOZYhKSw/oI5fNcz6qxWuAyOSJ6VrsRC4N4Iyt2RItWpNEWii2p4g+uv0ahMGeuSgQRDPukcU7a5d5C1Jt88wNNjQcKtDGGP87OyvyqSwmmudOEZuNGGAzyIF18ZI+hikjyeUtya+7VPOHSClc8Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sevUwa48a7Og2C8OUcw9D78OmqWv5oyTyNenWiiDtCQ=;
 b=WDACWI9JftvQcCTSQfm3hEBC3ltpcvjxNtepYMr3e6ZeTTZEbP13Vq0sMPxS6aThoav1eT+gk6bbkWX4jFOPV7yJbvBZiqmfAqax+dfhR2erPmazD4XOHWDhFYl9snm26q3WYISSlSBm9Nkt5poExuGocd9YdGv4lZcwCLM5pbc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SA0PR12MB7003.namprd12.prod.outlook.com (2603:10b6:806:2c0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Fri, 12 Jan
 2024 21:54:11 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::f1ae:6833:99e2:9dd4]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::f1ae:6833:99e2:9dd4%6]) with mapi id 15.20.7181.020; Fri, 12 Jan 2024
 21:54:11 +0000
Message-ID: <f75232ea-9e3e-1b21-4369-9a5798afbd6b@amd.com>
Date: Fri, 12 Jan 2024 15:54:06 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v4 2/2] x86/resctrl: Read supported bandwidth sources
 using CPUID command
Content-Language: en-US
To: Reinette Chatre <reinette.chatre@intel.com>, babu.moger@amd.com,
 corbet@lwn.net, fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org,
 tj@kernel.org, peterz@infradead.org, seanjc@google.com,
 kim.phillips@amd.com, jmattson@google.com, ilpo.jarvinen@linux.intel.com,
 jithu.joseph@intel.com, kan.liang@linux.intel.com, nikunj@amd.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com,
 rick.p.edgecombe@intel.com, rppt@kernel.org,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com, peternewman@google.com,
 dhagiani@amd.com
References: <20231201005720.235639-1-babu.moger@amd.com>
 <ba1305bf2a29ce2667d01cf997718126a7ea607b.1705009003.git.babu.moger@amd.com>
 <4c5bb5ac-1e84-4021-845d-cafea5a1fbde@intel.com>
 <3bd2a660-82fd-51fe-f7cd-492908d90ca7@amd.com>
 <920e6d40-78d8-4e98-8f85-6d015681887f@intel.com>
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <920e6d40-78d8-4e98-8f85-6d015681887f@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9P221CA0008.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::13) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SA0PR12MB7003:EE_
X-MS-Office365-Filtering-Correlation-Id: af6b9153-9115-477f-a431-08dc13b90261
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7Cshp5767gwAWpUpDG7LjTaTs7TRwqAI1oKv1LY31vOTXRCb2DP1Q8qEREYn9BRJdj+it5SCLBmLDn6BMkyc7aU9tQo6NWb5qG60KVakoWdhlXT2EvVNpNKi1zzB6ZQdEOE/7JMFQrdgEOe0eFWrDon/hwSmIZnjtIpKGc7pUUW1RbqjrsVZT6YiOBmcGEsldsFiTrCIj4K3axsX1/Z2N60IzC0UVuIQU2pSjYMWpTFgw3P1OLvjICQYbsJ/XEtTgQDix2NwgVRkKpKshO8HKela0SOxVlELtHgnYFGGZUqbyMML2KIUq1pUZlpptE3l7UAg1Ch2jh+y640ilpkfUpGZ7ybU1YixAlFHYlax5qsNCJRf8wnzzkZMxofZeu4jHU3hBFnbhy+rUR2AkgKYwDIh5eGiVKYZLgl/rVIr6Q9EC6jEXjgw5Xoar8WaFKo2XYWwJAIOFWtkGq7rG7DGXeJ+waDVhP597krghT+8YdgntntuEHqoJgsxavuOxHxEQpqG176p5eubQvuBLti4ereVoMKR0h+7R2j/z4kN+aKba+LL7Y8PGMktTIWkvokL8A0GLfbbwAzdl4/XK/Hiz7EKPSapgIiMQg15rI5AtYwRpkK9qWwCJP9zAHgywitCuHdkvu0VVfg3mQ/irmEufw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(366004)(396003)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(31686004)(2906002)(5660300002)(478600001)(7416002)(4744005)(2616005)(4326008)(36756003)(66556008)(8676002)(66476007)(41300700001)(8936002)(316002)(66946007)(31696002)(6512007)(6506007)(53546011)(6486002)(6666004)(26005)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y2lvcHF3bHUxc054QWhycTl3SUJzTkVKVEFGaVhUTUtsN0pDNmFyQ2M2cHpx?=
 =?utf-8?B?QUUydG92M2ZaZTYvVVlGSXdUaUZTVHZmZ3pVUGpQVnhtVU1MZGxZNzBYRVBj?=
 =?utf-8?B?Z1lEaFFseG1oenRiMXg3LzRwbDIwVHJLbm1ZZnZuckxiVjRaT0JnaDhnNHYr?=
 =?utf-8?B?dVdrclY3TVhsbHdzZW5laHNWYXRoWWk0ZE8yV0FrTHg4dGJaUjFGTTlSTVJW?=
 =?utf-8?B?WXBKWGxqQThTeVc1NkJwbnA0cHlMNVp5THlaOFlZbXVCdjkwOWsxcGs5dkRt?=
 =?utf-8?B?azM4TyszODZWRkxZWUxxODdFN1ZzR21Qc091WE5VcU1rL0M5T0RIdTZ1NTFY?=
 =?utf-8?B?N1RRRVphdWF4c01LZmk3VW1GakhscTNSYzgzRFZvU0lDeUt6OGcyVmVmOC9P?=
 =?utf-8?B?R3lsbUJTK3BxMTFWQlA5Q0s1d0srZ2kxaEVHQ01ScGVLQUVRcmlPVFE1ZXJU?=
 =?utf-8?B?YW9Nais4U1N2UklyblNpMmJoUGdLMjZ5dHJMd0piQUhMMjJ4OElCMzFURkQx?=
 =?utf-8?B?N0FCcEwwZi9jaDdEekpoWjlFZGg4SWs3V0NsT0NmUzVDa0lVSGh2d3VjYk82?=
 =?utf-8?B?VGQ1NWs2QmhOZGNwNEV4Uk1HY0lHYmM1K0IrNURZc2NJMDZvdk0xcDFMUmQz?=
 =?utf-8?B?VXNudk4zdi9qeDJQSmFNZmxScGpiSUE1K0pDVnI3aE9BS21ycUNPRURWQTh0?=
 =?utf-8?B?SmlLa3NpbVFZbzA2U25wRlYzcGFJaXF1T08rOWdhK3FRUy91T05KTFMzYjlv?=
 =?utf-8?B?aEFJTVJYdjhXM0Z4SEM0WWlLcGhGN3dvTytnZVY3clJ5UVRGMTlpZ1V6VmN2?=
 =?utf-8?B?YllWZE9vTHB1cHE5MUN3TzFrenMzZmhaV2dnUmo1aVo3M0k5VXloSDdiUldN?=
 =?utf-8?B?NFIxVTJQL1F1ZDl5aHZXaC9mRGtpdmg3R1l5VmswN3dzcng2SkNQWDBBTVhi?=
 =?utf-8?B?d3p0c0dYTmwrWS9iWjFSQnMrZ2dncHRrM3N1L05jOVJ3MzM0akt6Rk1FSlNB?=
 =?utf-8?B?MGkvWHNsRVRnNFAxMHRwSlVMTFZYWXpJdklqZzIvNFhvbkorZDAvZ3FScW5B?=
 =?utf-8?B?NjdFbmo3cFh2dFNZZzNITTNVYklmSUR3Y05UeVAyNHl3YlRXd1FXOFBhdUx0?=
 =?utf-8?B?SGZUVmRPRjVVOUxWMHU1dk1TU1ZNeWxFVmxzRnJObHJ4dWIwMzdudVV1b0Q2?=
 =?utf-8?B?VUY1LzZjUEJnbU1VTGJvQjVXNjhWVUc3ZzhXQUNXRHBJRU9tU05INm80NFVO?=
 =?utf-8?B?R21HVCtnOUcrdUkvN3RJSmFsVEJHbC84dDZCY1U2Z29meWo3YmdMTDZYKzh1?=
 =?utf-8?B?Z1dxQkliWTFZVkROTVNoanpnVW1SSVBtZ0syUlBqMXBKM0FUVS9Pc095RmNJ?=
 =?utf-8?B?S0Rod2FBOVd2QnBENHFzQk5pdFB0bXhTZkpBZUwxNzNNc0tzZXNMQjVadHA4?=
 =?utf-8?B?MkE0bUJraGVVWlBYRGxrd3JuSFdZUHhMdnRWTEVhaWE4d1B3S1ZYQzRyVldo?=
 =?utf-8?B?Y3pPUDU4c0RML29SeklaU05wQWx0ZHhPNlF6V0lsQUVSNU1pd09YUVM4NFZV?=
 =?utf-8?B?eFVCd0pBb05sVDMvckR1NThVZlhBZldqblRKNG9SZ1NieiswRDBoL0MxLzVt?=
 =?utf-8?B?YytiNlBpTDhPUmFKT1VGM1laT1htSit0M3hneVNLeS9FaFpGRE9WZ09VYzlJ?=
 =?utf-8?B?bkhyU3NCeGhBTGd2Z09qMTh1MFd3WG1rL1hKblJxaGZqRDlQRDZZRTZ1VE5h?=
 =?utf-8?B?S0YxNFNadG5CQXNWY3lLTFVvV0dPNndVUHQ1VTVpMnRzU2R5U2dQUjVXZXpZ?=
 =?utf-8?B?S3A4UnQyVE81V2lMTDZpbjhHS2crRGdac1QydkNQSFhVVHlmektQMUY1NHZq?=
 =?utf-8?B?dUVoRlpyUElsbGh0MDlBR0NYSEFLU0xqbVFyRkkvQ2pVNU4yVlJQYWtQYThy?=
 =?utf-8?B?OXh4RGw2OXRPZFlEcmoxd2JITG5EazF3TUlLR1FhTGthK3RTRWNUWWVZZm90?=
 =?utf-8?B?ekFSS1BOZHd4aTJvYkxNcTNSWTI2VDU4V2Z2ZU5HbGt3RkZNNGVCVGN1emdX?=
 =?utf-8?B?RmptdjNCNDZqeEVqTkFKQUVMeCtaU3ZGc0RWNGNFdmtiVGk3a0ZzQVc2RFdF?=
 =?utf-8?Q?qhTcfpI52n2d5sEsuH3BXBjtE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af6b9153-9115-477f-a431-08dc13b90261
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 21:54:11.0945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pLbQmcaFBnyomvKk/UWi2GmzsNZglOwF5p/gHhf34gIyrFUl6ifDXVBBW66CRwIz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7003

Hi Reinette,

On 1/12/2024 3:24 PM, Reinette Chatre wrote:
> Hi Babu,
>
> On 1/12/2024 12:38 PM, Moger, Babu wrote:
>> Hi  Reinette,
>>
>> On 1/12/2024 1:02 PM, Reinette Chatre wrote:
>>> Hi Babu,
>>>
>>> On 1/11/2024 1:36 PM, Babu Moger wrote:
>>>
>>>> @@ -1686,6 +1681,13 @@ static int mon_config_write(struct rdt_resource *r, char *tok, u32 evtid)
>>>>            return -EINVAL;
>>>>        }
>>>>    +    /* mon_config cannot be more than the supported set of events */
>>> copy&paste error? There is no mon_config in this function.
>> Yea. it should be mbm_cfg_mask.  Will fix it.
> I do not think it is correct to replace mon_config with mbm_cfg_mask. Is this comment
> not referring to the user provided value (that is checked against mbm_cfg_mask)? So
> perhaps something like:
>
> 	 /* Check value from user against supported events. */
> 	or
> 	 /* Value from user cannot be more than the supported set of events. */

This looks good. Thanks

Babu



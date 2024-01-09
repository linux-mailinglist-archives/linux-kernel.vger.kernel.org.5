Return-Path: <linux-kernel+bounces-21039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2448288E7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 16:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2F33287DE9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155E83A1AC;
	Tue,  9 Jan 2024 15:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZBtt0KCj"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2061.outbound.protection.outlook.com [40.107.95.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A26939FD7;
	Tue,  9 Jan 2024 15:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GW/v+2wNlYboIBdhdJ9+ceVIZlrCwnVslwRiesLa9h+/FNm4I6Vq53OQtF7DLHgDF9XD8ZOiuog7/SUaRkSyDtyV7lsCFu3y3xtEPE4jEI/JxvhMCw5ARXucxy9htjaHFlV7APiJtXQyRKnLmJGSr9JIIHzv2qgcY0IFB+DfegXXzgdbeB7DUVcciJrPSBiaG6LmR5Z82jrPcUiiJz2wREkKlRvjNJtpmOMkmAtsAGcE92Z+K5P/7M961DQbDmdHQD0rHwTGUKCNymDptx/JxbRH9Dkr6+HJsmVFKnb8sQFkGbKUjFdfbRZDqRI1oM9lf4dMaFTCQJp/GxJZsU6e3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JfsaY1YQhPxcKLLdmfn/Rt+dTHJNhVqt+jnKuwNyOEw=;
 b=Awj1FHiZzDLkHZVHsYFyemvL8cxdSoXcEtp+NFiLh6D+DwHDpBL8RhCJu8bbdYssad2hOOiREkIZXO7WwSUvA2zGQlqnTVqGzbAJUP154c8Lel6KM+JTOtW9FvCvrA7M63A5TrQL+kNVjVioxfHHEIcJUYNYAQwXG3YrvYWIZpSGqX3DWmu16PzdF+uOBlp2mBhzNMMHJggTcSaGYoQAxIFChEtS6V5dqjqL+9B+d+GVFGT7W9Om0OHd7bGQHcD2bNFbheen3sI4fjp2LRDdnBY6r+WgKUxqgopu34wxCgA9e+rvPYK9jXiginkdqscd1UsY7O/nYV2CjoCXTz51JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JfsaY1YQhPxcKLLdmfn/Rt+dTHJNhVqt+jnKuwNyOEw=;
 b=ZBtt0KCjPgdXYkhr9/NRNOyRGbcdZmGys6TfGEbprJ/NLCvPBBE6pVli5+JRXzwsZ6se4kMlRe2sCc07LSGiWtuA02E9m5iXLlm6JVZVxSZtb+IA0J01Y43b9Do0B7WXpouge37jM/xDIANFSFjHBp4hcZk9BkxQyk6ufS7qH8I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by MN0PR12MB6002.namprd12.prod.outlook.com (2603:10b6:208:37e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Tue, 9 Jan
 2024 15:21:52 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::6452:1eb:50fa:311d]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::6452:1eb:50fa:311d%4]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 15:21:52 +0000
Message-ID: <01f5686d-2fcc-49e5-8e78-7b4048c8be7b@amd.com>
Date: Tue, 9 Jan 2024 09:21:49 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] docs: Include simplified link titles in main page's
 index
Content-Language: en-US
To: Randy Dunlap <rdunlap@infradead.org>,
 Vegard Nossum <vegard.nossum@oracle.com>, Jonathan Corbet <corbet@lwn.net>,
 Carlos Bilbao <bilbao@vt.edu>, Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng
 <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl
 <aliceryhl@google.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
References: <20231211005442.95457-1-bilbao@vt.edu>
 <87o7erqxhm.fsf@meer.lwn.net>
 <b55dc12b-0cd3-4f56-803e-4b26f1117c91@oracle.com>
 <aa2ddfcc-8f2e-42c7-a81d-651a281eb6a3@infradead.org>
From: Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <aa2ddfcc-8f2e-42c7-a81d-651a281eb6a3@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR04CA0076.namprd04.prod.outlook.com
 (2603:10b6:805:f2::17) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|MN0PR12MB6002:EE_
X-MS-Office365-Filtering-Correlation-Id: 233d7cec-bc7e-483f-08cc-08dc1126b4e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qwIclbL6lSoMv23M9oHYjFiC7KApZByXi2+AzpCjqDNU8EJ3ulfDLvwiXRM6NKPfAnlpL5arkNgeEik1M4HJTXJNhb9Qcoxahz+CYB7gS8J7QgEBo6I2g/Pva5tM9cFKug2js1I6wAK7NBB6McvmMZxGMr5Yq+1AIt5TH1RjatM4AQZO/0m1Ae1ay1jaF5D+vWOA6aNYockyiPZ5TX0HoVeaMfmaGxXf5b/EjULnKwTfs0IMCB3nZQbjyZ8P952cFOHPmx6a2vCAv4KZ1iZlo1xNXZBsFY/X7RiYjmMWFAeIIA/S7XXzPUJVHn5bdc+OLlja7Zn4vSvGhTNSiqApRwmaQwiW2NSd/J86c/8X4Y/vdjKj3Eq7AvkkzuukNAw66Td3OwD6KbDbQCrUJNAUjWAEaVdaMMsDAcEzkQQgSO1kWgiKHYNmQQvPqEgyzJvAJe+ZR5+UuVZGWmDA1kQBMg7C4yKyXpcUxXZdVv6vke7BxjxAoJKd/JtgOWa5m0/uYgtgDjGr8Lkn9YImU9JOAVge99UrZD03E3jwyKzemQxemnh2oO6kB51glm9FZj6jrk4j1TiyxV7ggHBXVxJQA5eIFP2SKQTJt13u2Tfcojl1pcq4P9/i/EAVVHpGFt+HTm7a3l4OOq6Gfd2QmAkcvQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(346002)(376002)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(31686004)(66946007)(41300700001)(36756003)(86362001)(31696002)(38100700002)(26005)(2616005)(6512007)(53546011)(6506007)(966005)(6486002)(2906002)(66556008)(66476007)(110136005)(6666004)(316002)(54906003)(478600001)(8676002)(4326008)(8936002)(7416002)(44832011)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Tkd6ZFZDNnJ0bTdZTnJrcG1PaHBUUWpVOFhTTmpib29QNjRJbU1WTWZFVzF6?=
 =?utf-8?B?a2hhbTFQWlphaXJpZEdiamk0REVTUFZPbnVzNUZVOTlOZU9FMCtlWXY4QVdR?=
 =?utf-8?B?czlna3lqZ1hxUGxnU3VsSDVlR0RMMHBaTHo1ZDJFZmpIWFFaRkh2Z3RTVmpz?=
 =?utf-8?B?Skl3M1ZTWmtJM3c4NlZuUDRTcnVvMHdjeThtRmcrWHJDcVlhT0JybXlxbVY4?=
 =?utf-8?B?cXo3OXZFZ2NYMGUwQ0MvZkoyVnhtZ0VVbXZvM0ZkUVl4dS96UGdqY014aDNT?=
 =?utf-8?B?MHFlZWllK3ZXRSs2STRNaG01MEhPZXRtOW5USTRUVnZGcU5LWkpxL2dDZmkx?=
 =?utf-8?B?aFJ0RENFT0xibndQRUgyV012MGcvbEcxOTFRcUlkNVNvQ0pTN2xtQ1hRRjJQ?=
 =?utf-8?B?ZUFHcTZDTFBSNkkwNHp4UUY2eEVlNDVaR25ZQUNObDg2OGxUMTkyenlXejhn?=
 =?utf-8?B?L3M1bExBWUhmZlp5amhzeTNqM2Q2UnVDOXh5SDRzS3hzSUVYbnEzUzR6RWRG?=
 =?utf-8?B?WXBYamdXaVB6U1F5SCtpMWlpcVF4b01kSnlsN2MxSTJTWDRzdjZsSFMxT3Az?=
 =?utf-8?B?Q3o4enI3MllzZnhhQzFUYmdWZFZRdHNYSFhKQm5aaDRadnNtMUh5bDYzUzJz?=
 =?utf-8?B?YXJlOFBtV0xxNFlWSTl1TDRqMkFDTCtLRUJCREVHMGpzTmRhS1pIVkVJTmZa?=
 =?utf-8?B?Z0E1MzlvY3VoQmd3RXNnTDRkNHRwN3V2dGY2WFhqS1hGd0RlWVI5OEt1WGs1?=
 =?utf-8?B?eXoza0ZXcG9hU1F6V09kb1BTVStCeFZWY3hYbmZOQUxuNHZmQnRuTWt6bER6?=
 =?utf-8?B?dzFORGVaY0VtWFJjVzFCZ3NpZ2llQ0JaTXUzb3lnUEFVZXVNRWFOSGtmSkFH?=
 =?utf-8?B?L1BwUkFIalZKMWkyV2JEa2hBamh0OG10bXNyVDZtM3ZIZXNKanpFczZBcktv?=
 =?utf-8?B?ZGJHN3ZuakJYQzRXb0V5eE8xdFN2NURDQWdZR0NHMHQ2YjNSRkRLTndnOS95?=
 =?utf-8?B?MVBkSFJxS1hDYU5adDFLUnlSSlNhaXhtelRpU1NUWjZRa0tEUE1tOWtqMGFO?=
 =?utf-8?B?WnFUdUtJeDZsNmh1ODluVlFZQUxzRi84SnpKcVhoY3NlODh1Sk1sTWppaE9V?=
 =?utf-8?B?eEdaSTFyZFZ2MDNsSXczODhWVUgvZkhjQ3JnZ2pmcEpXWVZ5Tzg1YjRhd0NK?=
 =?utf-8?B?U1NVcnBlODF0QmVXYzdhVWlRRTg0NVlUanY4clo5VU5zUFBoZTBtOWdCYk42?=
 =?utf-8?B?S1pSR1YvalpuOFpLQ0l5YW9MUy85YjZoN0tMTUhYTC8rVDhZWkRoTlVZc1cr?=
 =?utf-8?B?WEhJd2duMk9JNHlrU3RaaFNVQitVSmt1RzBINFVqTmRaWCtMTTVNcXZtejlk?=
 =?utf-8?B?MTVsR2E4Ukx2MEJZZEhpVXlDVDhqRWZtZXMzTkI0cWcxUW9FU3BNOGZ2ZDZQ?=
 =?utf-8?B?eFNFUlhCZStMWDNROGZodWlwSUwrQmVXTUpwcFBwOE1zb09aWlFGdjh2WHBx?=
 =?utf-8?B?cm5xbXRKTXBWbWZJNGJIRGZuQmxxNFYycmlKUTliN0tad3FPZFAxRnMvd3J1?=
 =?utf-8?B?dGc5bXlyTXNkc2o4clFiVlUrdEU5YVlWTHBOUklKNDR1UnZPeC9LeEZUUnM2?=
 =?utf-8?B?VVRNM2R1NUREWWh5S1dFdXNYMmF1dVp3REVVT2VJcGloSVkwYzBsOXVmNytX?=
 =?utf-8?B?VVhwcHFWYXhaeGk4WTdHeEtHRnNQM0tRaTR5aHVDOTZlZHZXVE1rUmRzVzJV?=
 =?utf-8?B?VDdtOTVGWXp2bE84WHhQaVAxaUFaemM2K0U3WFk5MGVBNnVscUk1SmR4TFNp?=
 =?utf-8?B?R3MvWnJ2N1Y0THpDNFRFVEE4K0FsZ21LWFJ3MmRrMldDM2IrZGxoM2NPK2ZU?=
 =?utf-8?B?c0tBL0dMa29ZLzRpb3h4cmU1RVFzWjd6WUExdklBclBtMGEwMEt4a2VnN0xm?=
 =?utf-8?B?dW5lc25yRnVhaGwwU0htZGY3aS8yWDZkcXBWbU9GcHdtV2wrSlBVbDRJN1hr?=
 =?utf-8?B?dlhVWjduMzdkK01zN2NiQmxpZW5BU3lwQktLRlBxMTBpaUNYWkdoeGhYRmtQ?=
 =?utf-8?B?UXl0UTdXU2E0aWJGODJVWG9oZkc3ZTRTc01NT3hqbXRVYXFyM1AyT2VseVhv?=
 =?utf-8?Q?V2dC7gf09Sjc9WdtObPiGHQhi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 233d7cec-bc7e-483f-08cc-08dc1126b4e3
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 15:21:52.2651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A0MIqH9JJO25zJekT6udKxzLdqcDBMsDqrf2xsBV1eoPvJ50n349bLQ5MRXOc4Pdc+cwvAzfdP1gJe7AmumVBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6002

On 12/21/23 00:11, Randy Dunlap wrote:
> 
> 
> On 12/20/23 21:59, Vegard Nossum wrote:
>> On 15/12/2023 16:47, Jonathan Corbet wrote:
>>> Carlos Bilbao <bilbao@vt.edu> writes:
>>>
>>>> The general consensus is that the documentation's website main entry point
>>>> and its sidebar leave room for improvement.
>> [...]
>>> Meanwhile, I'm pondering on this patch, would like to know what others
>>> think.  Carlos nicely put up some comparison images for us:
>>>
>>>     https://github.com/Zildj1an/linux-kernel-docs-compare/blob/main/comparison.png
>>
>> FWIW, I like it, but I would suggest these changes:
>>
>> Driver implementation API -> Driver APIs
>> Testing -> Testing guide
>> Hacking -> Hacking guides
>> User-space tools -> Userspace tools
>> User-space API -> Userspace APIs
>> CPU Architectures -> CPU architectures
>>
>> I know "user space" is technically two words, but the one-word form is
>> MUCH more prevalent in the kernel, for example if you check the mainline
>> log you'll see something like:
>>
>> $ git log --grep 'user.*space' | grep -o 'user.*space' | sort | uniq -c | sort -g | tail -n 3
>>     3135 user-space
>>     7835 user space
>>    26917 userspace
>>
>> I think it makes sense to pluralize API -> APIs in most places, so e.g.
>> "Core APIs", "Driver APIs", "Userspace APIs". Just to emphasize that
>> these are really collections of disparate APIs (e.g. workqueues is one
>> API, linked lists is another, etc.).
> 
> +1 for all suggestions.

These are good suggestions, sending v2.

> 
> Thanks.

Thanks,
Carlos


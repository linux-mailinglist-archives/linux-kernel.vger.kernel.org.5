Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239647FE075
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 20:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233581AbjK2TrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 14:47:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233713AbjK2TrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 14:47:13 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3981710C8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 11:47:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S+htZ5ops9A3nM7BIHgq4L8rEqGGtUpPeUnU17qNQoB6ZfQyoeHG2L12O/4ypCc7pCEevKM1cwUIVMYf0WTFZLJqccucWOUxRwT6GTf9Bqy3HTG70y202dKiKdjEuPMZ/hnmC4ncrgvvB7YhCOO1AVpywaPu23BYIIF/TtY3P9MvPB6exdnjRTKfaeRinJaGQDTkRt6R1Qz2ckrUsbmPVNc5qGqyVALnGma9UyoqjQE35aq+3BTeC5W+34qrwmVK+IB4YouMDqW9mc4S2srNFUjbkzkassPwzV92dJOsCEoWZOeVC61CVbojV0K1Fl6wVGuniuuYQ825hGHtB5Zy3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EambDCrw/rWaHC+JKGcsbw1er7EEuN1uxEzbpgwnSyA=;
 b=EjCIGfxufeDkBIbQP83rO34dOMzlFULH9JI9//4SYsrC5jp01nNUWA/o53YhtdAkjwjHGXYTMVp9fbLvhiHLq1L5nMy1kxiwjRMm8csSiDsahv+5Fqx9Rstv3IgUziTxq6Uj28RcqCWL5o/Z/IovBzJdwtOVu4bOlukET4+tddEFq+bPKrYmLhcu69QCmFCx2gI9HqBJMlZ6x6EgBZ7WcOG2bUTPsYXDQZWfJWIJ++CElRXuL2f6Kx9asLm8miYf8mtJZfYLNidHyoYCYpSYny9U67s+yGq9zNvpXJ3Wpp9NuQjdtOx1Dqaf4QXZkZqJQL4epQNm3iQ0pJUZkSQ1yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EambDCrw/rWaHC+JKGcsbw1er7EEuN1uxEzbpgwnSyA=;
 b=aP+PCCa9FQSDmiqhJOSnwL077Hp4Fx6EUqQRN4rgY9hQJaPjuODuw90VM0lC5GXq3sR7uqGnv05if8emi1FiJYBOc5o8NXsVQYL9pxa72NAJGD31cY74cjmO9z21siRyy5Z0iAiGlXExaFpWjZZtMNPj+5fqDIFUBgEoGVY6thQRgnVJd/aSy0IZ1MX/o6S82xuhISNcafZyCjbMjxgFZIiLTe35oVuR7yfPiO8rzfhMGcTJpHDeW3ls6lWXiqdrDsosf6VwF+eXOfjMk4Qcv6dHvKNUKhKk/hsNi4kvqOZDduX9IqJJaILJDiN4G15tDyp+M225kosznDrijCu7+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by SA1PR12MB8967.namprd12.prod.outlook.com (2603:10b6:806:38b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Wed, 29 Nov
 2023 19:47:15 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::6b9f:df87:1ee2:88ca]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::6b9f:df87:1ee2:88ca%6]) with mapi id 15.20.7046.015; Wed, 29 Nov 2023
 19:47:15 +0000
Message-ID: <84636e85-8b94-4b68-8b3b-6f09d26aefbe@nvidia.com>
Date:   Wed, 29 Nov 2023 11:46:53 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v7 00/10] Small-sized THP for anonymous memory
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Alistair Popple <apopple@nvidia.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231122162950.3854897-1-ryan.roberts@arm.com>
 <ZV9267tQEhoPzCru@casper.infradead.org>
 <f8e518f2-fb15-4295-a335-bea5a8010ab2@arm.com>
 <ZWC9lwDAjMZsNzoG@casper.infradead.org>
 <9c8f6d2a-7ed8-45d2-9684-d77489bd99b8@redhat.com>
 <ZWDG6BYqmZVpyTLL@casper.infradead.org>
 <26c361bc-6d87-4a57-9fae-ef635c9039c7@redhat.com>
 <87sf4rppuc.fsf@nvdebian.thelocal>
 <51e6c9f1-e863-464b-b5f3-d7f60a7ebed6@arm.com>
 <b2d19306-0d68-4aef-9b68-15948ddc8ea0@nvidia.com>
 <afb92816-25ed-41c8-a48b-94fb2d885d8e@redhat.com>
 <58af512c-3d7d-4774-88f7-6336c9384b61@arm.com>
 <137902b6-24dc-4d51-9be2-6f94aa9dbc3a@redhat.com>
 <f4c3972e-f341-4d15-baa2-bedda8d7a8ad@arm.com>
 <47d27539-6cf1-4375-9bbb-2ebb9a2acfb3@nvidia.com>
 <832a486c-7f22-49cd-a3f5-3709dc6c6d09@arm.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <832a486c-7f22-49cd-a3f5-3709dc6c6d09@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR04CA0028.namprd04.prod.outlook.com
 (2603:10b6:a03:40::41) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|SA1PR12MB8967:EE_
X-MS-Office365-Filtering-Correlation-Id: 315f278e-1878-4a06-8d25-08dbf113fce6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yfAtq9c/33wsR5waDm7yqLOy/ZQBUOOJa9Go5LiAjT+3KNuMgg5+xrdmSNQ/l+FAXIoN+dDp5KlFB/OmiUoz9wqwP60PRB68fLiPH1cFSMf5dq+Cvl5iMUHYPtQjzTD8ZtFF2wlxsn5qp12lIqB9WPSsUHINHIL6/R/3WAXRTn/xap3rBzGiBD1xpqxL8oEYdkqEFPp9XU+4Ej+16v1r2qoJ1maiqdOCCvr6XEIUZIwkUA7WVbvZMektQJGhWaSitG6O+Gadzt9Evgt41U++x70OX6Q7zOiZNMoUESK2rvEy3T/5wDP7DvCqop2k3VMxkSMOu0G92iAU6MVu+voC89sLuunI+roj2B7EL54pCE0Jzxqf+ED6nKyLqmcsSD8OXXfu5pNz5w1oOF8VVPhJSnbg3vpfs8Pv4URh6m/jB/tLC3M1ZbPeqEQx1kGowat9MhZmzq0x8Ora64bwQVNF2TPWbAPEP/kwvA5X3FXU0LxI47sqSVgymXBnS4y1kJVXA9sIzC1KxqNjBlH2ptbukV16bVOrr2jYzR+NPspMda3kDxeZ3aYkIbe0RmGnc6oTKOUYZiJQ2eWc0P1Uiu3+wFqAn7qOBAdZeldPScHyBnWVBz6Hsi2cwp33ul/7vpoQW6Evuual0n+ThXWoQTcumcA5GgZ3rGzFcMUX+zp4o5S5co3oLudIfk2anx0A9EZB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(366004)(39860400002)(136003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(2616005)(6506007)(31696002)(66946007)(316002)(66476007)(66556008)(86362001)(54906003)(6636002)(110136005)(6666004)(8936002)(4326008)(8676002)(478600001)(31686004)(6486002)(53546011)(6512007)(202311291699003)(7416002)(5660300002)(38100700002)(41300700001)(36756003)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWU3bEQxenRxVXp5MTVBb3lvekNHNHlYM01NRW9hN21yVFpiZDRzOEZpejJn?=
 =?utf-8?B?dUJ6NGl6U1ZZQTVkTmIvMGkyVlp6U00rUFN6d3U5aTVqa2I3R2V6OHFXLzFz?=
 =?utf-8?B?RWV0VTZSOVZNL1NTU3A3TVN3MHBvQkdLNUNpSXRpQkxiU0NQTjhFVFlFM1B4?=
 =?utf-8?B?UkRoL3hVVjhBaUtNTktEcDdqbWlkQlpLY1A2QWwzT0RhZWhPSnlhVHJtWDhJ?=
 =?utf-8?B?bjdnL1hpVEc0bnc1RFFlQ292V3l4d3BsQ3ZpT1RXbzVseXVrdFB4eDdhd2g3?=
 =?utf-8?B?RDl5YzMyS1ZpNTlPMkI1WlFOQ2Q2RnpDVTRiTjBmN1A1Q1VxVGhtdmdFVUdq?=
 =?utf-8?B?dXN3Wjd5RHIzR0JNTkpXcEVXYWNsaHpWU2xDWE95TkhLMXpYOFJjRWpvdTNK?=
 =?utf-8?B?cjBZUEFLZ00zNW5XeXd3anNxQzB0VW5ObmJXRE1hcmduNE1ybTV5d3VZbEl0?=
 =?utf-8?B?TU44U2QrMnFGYVhUQSt4SFlTNFM3TzJBNU10VVBldnR1bnRBYkJHVGV3M25j?=
 =?utf-8?B?T2JjRURQSVAxb3YzLy9VQ3hhL3VmaDZPbkpKQmgyQ2daK25ERk1xeUJyaVlN?=
 =?utf-8?B?ZVRBekt4dHR1R0hMWno0Ylo0by9jK2R6VFlPRUlPSHh4M1ZNNTB1ZG9uNW5K?=
 =?utf-8?B?MHAzUHNPZkVlV2JkY0Z0eld2dk0vUkdJUC9ZNEE1YXlZemdVTUVocDNHajFa?=
 =?utf-8?B?MTVOTTM3b3NWSytqa2R6RHdRMzVIc1hCdlo5TVZvRHlCd0lOVGYwQlA4OUdS?=
 =?utf-8?B?VFkyNm90TG1aUHVxQS9tNnI2R25RZGxvd3M3d2U4c1JJK1p1OWZEWStZekhK?=
 =?utf-8?B?RmdUUFFoQnZ5c2p6a3hqT0QvcDBXTER1Z1NYYkkrTXFQUTlLWHdwWjV0OFJn?=
 =?utf-8?B?MzJNS3JqalRGV3JBWTB6eFM3SEp4K1ZsM0lzTm5VdFAwNnpGNjNIVTR4c0pR?=
 =?utf-8?B?WnVrL1VQaCtBQlFFc08wUDNvS2IvcExxV3lRaHoyQzhUVkt1R3cxWWkxKzcw?=
 =?utf-8?B?ak5DWG5Udkc0M0Y5LzB1VHQwY1Nwc2IzN1c2a296UmlBNks2c1RKWFUvVVd5?=
 =?utf-8?B?TURHMzF4eDBMZU02SzF0Wk5wekNVTjU1SjJqdGZwY2tKQWFlQlFPM0xwZDRQ?=
 =?utf-8?B?VUpBeHFkQTZUT0c5VklzaTdVdHhpQ2J6YkRyNTN2RmdkVUpMcjBYSERJeXV0?=
 =?utf-8?B?a01WcFJhMnhvNWkyUDN1ZFhiYUxIRS92ZjBJSHFTcExaT2dUSHYzNFN4cVRl?=
 =?utf-8?B?QU9Qbi82bHRsMEFTTTNQdTVUQUxyZytoZ1pPMTRUSWRCc0lMbDRCQnlZNy9x?=
 =?utf-8?B?d0ZMS1FENkRZK1hWVFFML1dCMVRJVnVGUS9MRXlhcFUrS3BjR1QralVQQndj?=
 =?utf-8?B?WGp0Rm11NGFDaUpOQjR6OWFYOXk2QkFQWTBLWENPaFBZRkNWUXdoL3NubnZo?=
 =?utf-8?B?MXVqZG9nOXJGNXgwUjlQa2hRdWVTSUIzWktkc1dheWFGWFhuaGFINmE1REkv?=
 =?utf-8?B?aWMwOFpzZ3RYMytYUnZpSEo3VVZ3b3U3MGhvbk9MQ1VlRlQ1aUcrVkpCeUkw?=
 =?utf-8?B?blJiRnlhbW5UYkpzclJkL3lCUVhYWHpONzJ0SE1hNUZDenFJQnJvLzJQUWhr?=
 =?utf-8?B?V1F2aGorclNGbU9uUXVreE5UVEpUZzZSY3hUWEc0OEpGTlZWS2xEWmFBMU9n?=
 =?utf-8?B?YlNuSi9DckJ3ZG12R0M1U1NnTnNRY21rdmZsQXhIekdsaCsvemhEbjVLQ25F?=
 =?utf-8?B?TW1pUlo3Wk92T2FIVm83KzlPOVFTL2haQ01YTlIyUEpieWx3Ylp5RGdPdnZx?=
 =?utf-8?B?RXdBd3pmV1g1ZFd0R3pqeFZ5S0hjeHhIUDFLYnZSU1M4YS9QYk5qMmxPYzRX?=
 =?utf-8?B?elRWelBsTjNYZVIzZEZIZWwwSzM0Z0lDK2Z0SFpEMnVEd1hzUnR6R3RlU2FN?=
 =?utf-8?B?dkFtcGRVRXlrUHQxRXNnbDRuWFRORDVxdlJDT3NzZkVuWlB6Rk9ReVFJMHZ0?=
 =?utf-8?B?QlJmZUE1eVI0T0tFSFFpZ01BaEsxOHdWOEI0SFYzZzlpRDZjWHRmVWMyWmRu?=
 =?utf-8?B?NUpQQlJwOHRROGlKRTNVU2ZwMXJhNmliVmJaTm1VNE92bnJ1bGFIVXhOYTdB?=
 =?utf-8?B?aWFDQllBUnpmcEhJZzlpR1gzOSttdHRlZmVBa3NLZlRZK3NmblhpVVA4b2Vu?=
 =?utf-8?B?dlE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 315f278e-1878-4a06-8d25-08dbf113fce6
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 19:47:15.3779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z3GXQQ5BCV5HYtTgt4jPaB+tlQ9MVDk1e65UWBRNYe5cB9wDNM06gU88BvXpuAChIxgCCusCy8ewYN9gY2JSaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8967
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/23 01:59, Ryan Roberts wrote:
...
>>>> Regarding new stats, maybe an interface that indicates the actual sizes would be
>>>> best. As discussed, extending the existing single-large-file statistics might
>>>> not be possible and we'd have to come up with a new interface, that maybe
>>>> completely lacks "AnonHugePages" and directly goes for the individual sizes.
>>>
>>> Yes, but I think we are agreed this is future work.
>>>
>>
>> We do want to have at least some way to verify that mTHP is active from
>> day 0, though.
> 
> Could you clarify what you mean by "active"?

I was thinking of the *pte* counters that we had in v6, in /proc/vmstat and
/proc/meminfo. I missed those, they were helpful in confirming that the test
was actually using the new feature. It's easy to misconfigure these tests
because there are so many settings (in addition to kernel settings), and
people were having some difficulty.

> 
> Current plan is that there will be a per-size
> transparent_hugepage/hugepages-<size>kB/enabled sysfs file that can be querried
> to see if the size is enabled (available for the kernel to use).
> 
> But for this initial submission, we previously agreed (well, at least David and
> I) that not having a full set of stats is not a problem - they can come later.
> So the only way to verify that the kernel is allocating and mapping a particular
> THP size is to parse /proc/<pid>pagemap and look at the PFNs for now. Is that
> sufficient?
> 

ugh, that's a little rough for just a command line sysadmin or QA 
person, isn't it?
Still, I expect we can survive without it for an initial release.

thanks,
-- 
John Hubbard
NVIDIA


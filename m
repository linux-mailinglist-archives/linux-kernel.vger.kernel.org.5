Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF897F6A0E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 02:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjKXBPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 20:15:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKXBPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 20:15:01 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793A4D56
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 17:15:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iw01N3zzszFXRD7bAESbKJKs4c9H2EtqxOeFj7poHlsJMuqXsDc6T2inoEcReSlt8G60IjAC2/t85EnbhDBa2HsZNHKef+niKtsSq918USAoBsgQebyyOtlrAYsl4VNvVqtuLvAFEjilOB3pE7qNvGlpl38Z7yIBA64fMUYOCysf3K5I8x6oNOmDXw9rk6TPzEhkWQsMrjiBpucYlPlYw8/55V1Z43wIOxdb4iOGx5lRHrCv83lSKbzxu1Jw5qhEbhUkzEDZdDOg5GW9I8D/3GYd2E4k3DCA67d5cJOxj41zIodO9QGR5Qmkk3E9zqytEVw1HUInCYYuyFqqtCOjtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ywbDS5mUEMlExfMKe8IaLTShh9Gz2liVAy0qQ1Jhz8M=;
 b=cyAlrlJxUzUNLdmnyksLowIQRdAykaDqM/1tVRQeyVk+wHc8sTzbUb9hCkRgk0/73JfcnL0ON0Qv4pr9fJJyW9mr3qyOLQsfC0Luaphrn9xMRRupR9+24Dm7ooBBTIoshArdd8D9F45AsHjqM2vCqt2QxFZ9qFWh5qGh0EqzfOwU94nWt3vg/GmFcvm+WudwpsmKCygvZUFlMwrMpfdWoGmjlqO5eiRwC14FcO8+XAXPumqS1+VJFDGB1aHbJMCOSpoqsEBC2OTrbzJ2F7j3XV6AHzzkbhS9cmrCBIkRmGI/VV/V5U9CV3XocLMAIw7TZfAXWWUxMIahZRH6eF6svA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ywbDS5mUEMlExfMKe8IaLTShh9Gz2liVAy0qQ1Jhz8M=;
 b=Q3R5LC7xNUCkpCiCVMsRC2y4YRu3JM00zfRzNuJF6C/Vszxwk0cTclbKZwpfJHBEY2z3GihmbtP3ZIuLO2txkD/DpIpKhVmQRWZuAzRaD/wjfUAlAgYtS6hqG/Eu9n9pLGAI5rq3q0t0dY4J9UQnhAEt0m5vKKUE5LFxpu2JFjyA6kSDBpFTilEYkci4nN6Hr/3MW/aHuAxjm2YFXoUSDWWgoPOsjx6W62tiZxQmETffNFnntmP4ZzMBVnEzr70U0qx4ImddMg6PlPgFGah7GOw1F495/O7QU+v4qaCEmmL3LMtMssaTAuaQsJR1uRsljjjGn1L1pmozqAy0LU7BgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BL1PR12MB5352.namprd12.prod.outlook.com (2603:10b6:208:314::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.21; Fri, 24 Nov
 2023 01:15:01 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::6b9f:df87:1ee2:88ca]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::6b9f:df87:1ee2:88ca%6]) with mapi id 15.20.7025.019; Fri, 24 Nov 2023
 01:15:00 +0000
Message-ID: <f102daf5-aa26-4f78-941e-e885bf541d6d@nvidia.com>
Date:   Thu, 23 Nov 2023 17:14:39 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v7 00/10] Small-sized THP for anonymous memory
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Ryan Roberts <ryan.roberts@arm.com>,
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
 <7f76ee6c-f0e6-443b-bcff-3637895dec66@redhat.com>
 <ZV97RO3i02+NmwD2@casper.infradead.org>
 <7d4efbe8-5690-4db0-be06-399353679982@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <7d4efbe8-5690-4db0-be06-399353679982@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0203.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::28) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|BL1PR12MB5352:EE_
X-MS-Office365-Filtering-Correlation-Id: db174ce7-9e79-4ae6-1110-08dbec8ac77d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6IcGNABYEWFjNLSqCBRykOslf9eyGvJxXVknvK4KHW+DWifiG1Srgl3Pj+xdyG7EmkH2w/UVdR1qVemBDocjJDli5Aidb5APeot0EeIx4SLUlK58/tM6lzgzh8WY7EkvPYRLzuUCIY/TXfpbYVoztCh/+yVk1/MqT95ZWw9MH6TVmRBJ4VCZTFuprq7STO+L2sy2tiUVenpJAKzAmhq9krsnKfmyD2La8OfZjDDltXYPGyJFtJQzMhlfd0cHI4Y0QsEcdDKGRpEcJqmlKRQmDh/nxg6J9FV31pc6+AvdZjhlM+iDQM2g2fXL8bN6FtM354iw+2dB6fNSysLYDBWPPGLeMVluL/nfNObTk6ySXMUbEHU2zwF8VK5w3Vy1xdi7pJV6/LlXOpWhfbyTe6ibjAH9HrP1IZROC9ARyzrO0SxQb7avd8Qnzn8t4m2ouXjY/6nMFTW8TCXcPZ7bD9ieVdYf67kwhmu0kNawiakB/0I46NROU5wSrdqS9pZeLLs2NMHJyi+QFk2vsbkAsP6HJCw6oJgEsacHH0AoHOorJqIEV4XvYjEak1k7NRQAkt2kxG/7E+Hvd1CSWj+EXvMPbhb1xyVhG3EPRNNBUHo9CbA899x4nZf/9/jIDP30bX1pLENHYZqyNa6Z96J9LnHa0teS857m9Ah8RVlYhI4W6fPTkUeBAdyK8tC4SgCFuSCZfAONatrmTl3OmuXUlj9vcK/RKuz4al2AqwKd8q5SH38=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(39860400002)(396003)(136003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(83380400001)(31686004)(2616005)(31696002)(86362001)(41300700001)(7416002)(5660300002)(2906002)(4326008)(8676002)(8936002)(316002)(66946007)(66556008)(66476007)(54906003)(110136005)(38100700002)(6512007)(36756003)(53546011)(6506007)(6666004)(66899024)(6486002)(966005)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RC9rT01kWC8xMlJyeGJWQXNUL2NSSE5SU3dEdXNWYzJrMHJOUFJQYUN5NWF5?=
 =?utf-8?B?TXd3RWJEQUdSV1NJN1YzOVUyWiszV0lxR2pXU1pOMEI1Tks1eWp5emNJVXVS?=
 =?utf-8?B?a0ZYbm5KN2hYNHVMVGhnQmh5QU1XNjFQbzdPK1UzNXRtNDNoZ2xxVE5ZeXJh?=
 =?utf-8?B?RDVzQjE2ZVV6QllQdnFUSVdESlNvdU5nY3piTUdVMVhlT2lzaUpWZUMwZWwz?=
 =?utf-8?B?STBUdTc3RjBLS0pDNHd2WWU0M28waWk2dGtTSzc5MExKZUtTVStucEpDRUdF?=
 =?utf-8?B?aUxVTU9Cb0d4czJsWWNwR3VJVjFjUFVCckxYa3N4RnA5eU9rRytXdE1ITk1m?=
 =?utf-8?B?ZWVVdHJlMFBFTHA3N3dPelVTRUpXenk5RWNvWmlWUDNRNHJLUEw1Y1dZUzdJ?=
 =?utf-8?B?dldhZjFndHZENjJHZTlWRStjYStjVFNMMmFzTVBidzBKdXE4b0xDdjhaWlIy?=
 =?utf-8?B?b1BkNGVITkNSd2l5c3pjbGdoSm9yc1MvR3A5eU8xQXhpTEtPRjRqU1ZNb0NI?=
 =?utf-8?B?ZlpMVURCRURNQ0xmTVMwY3pjd1ZEY0tvNFNMWjRHTmV0eUVWNWdxalJ3QzBh?=
 =?utf-8?B?a2JhWmNFVU1ld3F2RFIvRisrb2JucUcxZUtSM2pLMklucnFSeGVTN3pySmhn?=
 =?utf-8?B?REI4MzhabFFFRzA4WTh4ZU43aDRRRTBOVjRZVE8rNE1hdVNYQktFTDdTejBx?=
 =?utf-8?B?MFEwcXhHUDl4OU13enhXZVJnZFY1Z1Jyd2Z5UnBocVVRM2U1THZoaVI2ZG9h?=
 =?utf-8?B?eXhpZllnbTlaV2JURHNvVlFnQ2NMMjd1WEhjWWE2ZkFGWkRIUjNoZUF2RWFQ?=
 =?utf-8?B?TkZQNENkR1g4cVRuZFdnMGY0U1pmb3NTekI4bEdXM0tJaUNRSG4zVm9YNWZm?=
 =?utf-8?B?U1IwT29IUVE1aDdKWWxxRUdGQjNqRDBPMXZxUFdFcEZrQVYvYVRRdDVUb2x1?=
 =?utf-8?B?d3dqSVNyY3RxTklmbVlXNEJaR0F4KzByamNYSWtLRkFvWmsyYzRTSEk4RC9m?=
 =?utf-8?B?UlVwQzZyOUlLODZUZk1uUVRObk9EcmpELzVseEtTbjhDeEtsS0t0WXV3d3Zs?=
 =?utf-8?B?ZXpERWdWTkVkazBZZlBPS1hOSmlHaVdlQWZMa3J3eStKbUplWGJYNTdCWE4w?=
 =?utf-8?B?dHlGMDZvQzNtR3ZjRUpINzduamtVVFRPVW5tVy84S1JZYjFiUmRMcDVPZkty?=
 =?utf-8?B?ZldYWDBtY0pNblVwOHBYZ1VZakhZWEFTbktzb1pYTTAvUSt4S0l1dlBNMDRK?=
 =?utf-8?B?YS9WL0ljaC9meTREMUpSYTVqWEtOVG9WRi8zdWxvck5YZkpxeGFwQVpadXJ0?=
 =?utf-8?B?c3NRZDJvWjhjRC9LSVNhT3YzTGpxRzVtMDVUcEw4KzRwaEh6c1o1bktpUStp?=
 =?utf-8?B?cU8zZ1hxcmhTMVZMYkxsMkFEeis5dXJYdkRNUjNRNmFzdEVQTDJOWlV1cDRo?=
 =?utf-8?B?RXcyblBoTVhkQVhIY3BpYXhZb3k4bFFaT216M2VIY2djd1JadkNBSG5BY2xO?=
 =?utf-8?B?SDFqbEtYd0pmQ1Y2TE5WS3BLMXNDN2x0Nlgxa2RQNzR2MmxZTFY0NUJpSEp3?=
 =?utf-8?B?b3dhaWhvQnJNd2JwUUZIaDNSRDFBN3gvN2ZiZ1ZVbno3dFh5Y2JxRWJlcUww?=
 =?utf-8?B?RVNQaENSVlp6SGJ6cFZDMWhxZXBubEdLUFV2U1F4cFRIV1FJS09HVEYvb3ZC?=
 =?utf-8?B?OWhGQmVGWnE0WElkT3Q1NVBZYU1Na0V6eTFmK3owdmNuT0thUC8yU3R0YjZm?=
 =?utf-8?B?eFNJNHdaWTlUMnBqTUx0d29JQjJxOUtOUkV4R3F2WERRdGttdUN5aldvTm0x?=
 =?utf-8?B?eFdtSnNtWnl3K09Yb0hoMUFqek8rRjF4MzBNU1RoNUQxY25Mc1F3TXdjNW9j?=
 =?utf-8?B?THhpOWZKWllOTUZ2c3UzUmdRVjdkTll3K0x6akozZEZaLzhDWk5sdmJUUkNz?=
 =?utf-8?B?YUxyTmVNSXYvb1RPRHN4ZjJRUWlFQ1JjQ0N3N3NSZEZ1dlQ0Q2lRU2ZsbXF2?=
 =?utf-8?B?Um0zT2sxaWlHZVFpaERFMEJJTE9KbTZjTUw0ZGtuQWU5d2JIemtDYTl1anJE?=
 =?utf-8?B?Lzk1MW1QaloxbmhjOTBLUDVDeWVLRGZNbG5oa3ZvKzF5aE5hT2Jtc1NuOFVL?=
 =?utf-8?B?ZzZmVDNMeElPMktXa1JpUzl1UFFCRmF6RVhSZFUzWWJJb3M3U2pSSzFNSUJZ?=
 =?utf-8?B?UGc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db174ce7-9e79-4ae6-1110-08dbec8ac77d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2023 01:15:00.0781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MaxHkKLbW8IdHOTXMuc+9XYsxvxD+Xp6dg7SD1CcqczlC58lOoRPTvQXKxVwIoMdv7FQtQNUZ3BRXFCXxgXOEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5352
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/23 08:50, David Hildenbrand wrote:
> On 23.11.23 17:18, Matthew Wilcox wrote:
>> On Thu, Nov 23, 2023 at 05:05:37PM +0100, David Hildenbrand wrote:
>>> On 23.11.23 16:59, Matthew Wilcox wrote:
>>>> On Wed, Nov 22, 2023 at 04:29:40PM +0000, Ryan Roberts wrote:
>>>>> Note: I'm resending this at Andrew's suggestion due to having 
>>>>> originally sent
>>>>> it during LPC. I'm hoping its in a position where the feedback is 
>>>>> minor enough
>>>>> that I can rework in time for v6.8, but so far haven't had any.
>>>>>
>>>>> Hi All,
>>>>>
>>>>> This is v7 of a series to implement small-sized THP for anonymous 
>>>>> memory
>>>>> (previously called "large anonymous folios"). The objective of this 
>>>>> is to
>>>>
>>>> I'm still against small-sized THP.  We've now got people asking whether
>>>> the THP counters should be updated when dealing with large folios that
>>>> are smaller than PMD sized.  It's sowing confusion, and we should go
>>>> back to large anon folios as a name.
>>>>
>>>
>>> I disagree.
>>>
>>> https://lore.kernel.org/all/65dbdf2a-9281-a3c3-b7e3-a79c5b60b357@redhat.com/
>>
>> And yet:
>> https://lore.kernel.org/linux-mm/20231106193315.GB3661273@cmpxchg.org/
>>
>> "This is a small THP so we don't account it as a THP, we only account
>> normal THPs as THPs" is a bizarre position to take.
>>
>> Not to mention that saying a foo is a small huge baz is just bizarre.
>> Am I a small giant?  Or just a large human?
> 
> I like that analogy. Yet, "small giant" sounds "bigger" in some way IMHO ;)
> 
> I'll note that "small-sized THP" is just a temporary feature name, it 
> won't be exposed as such to the user in sysfs etc. In a couple of years, 
> it will be forgotten.
> 
> To me it makes sense: it's a hugepage (not a page) but smaller compared 
> to what we previously had. But again, there won't be a "small_thp" 
> toggle anywhere.
> 
> Long-term it's simply going to be a THP. Quoting from my writeup:
> 
> "Nowadays, when somebody says that they are using hugetlb huge pages, 
> the first question frequently is "which huge page size?". The same will
> happen with transparent huge pages I believe.".
> 
> 
> Regarding the accounting: as I said a couple of times, "AnonHugePages" 
> should have been called "AnonPmdMapped" or similar; that's what it 
> really is: as soon as a THP is PTE-mapped, it's not accounted there. But 
> we can't fix that I guess, unless we add some "world switch" for any 
> workloads that would care about a different accounting.
> 
> So we're really only concerned about:
> * AnonHugePages
> * ShmemHugePages
> * FileHugePages


The v6 patchset had these counters:

/proc/vmstat:  nr_anon_thp_pte
/proc/meminfo: AnonHugePteMap

...which leads to another naming possibility: pte-thp, or pte-mapped-thp,
something along those lines.

pte-thp avoids the "small huge" complaint, at least.


thanks,
-- 
John Hubbard
NVIDIA


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D77D47AAF63
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 12:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233290AbjIVKXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 06:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232913AbjIVKXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 06:23:46 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB11CE;
        Fri, 22 Sep 2023 03:23:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m3QmW4VDHadpDtY/JvvGUyMBN40Sp0zZ/mfeWFTTpmvFpcwpxuBe9KkYK73WpVmz32l4mHIq+Iec+zbMDw7KG1I5wbrBhL5aXFVyIdtQncIpuVfm6/f5sTlJvS5mmURtt1+v3KLUPk6gJNJ5ydHzQ/wWrSj0rJbgBCWrHIVGIUmvsAQe9ouiwcnpL/kiZCoHe2k8Q+dczYFRz+3kyekeQ7bVWM+7emWw5XblNX8SWXGX8EIIR7X9U6b+VQuF56gU3zsdA1DaDvk0NgIh85MRO5/hMWh3JU4XclpTBPqtZ76BdaYuRmunm65NXrEws94f+pxPEFO692J5VViE6/R7tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X+5L9GGwtex3HVLIen2scRqjmkvW0WBUfR10o9bLMpY=;
 b=a6bKef3V2jPl7fpNqOCccr9d/gvxk+e61lUbabLYq2JTEtH1wyxwMyRHfWtn4tvcKaRW6zpU3XUGQ4sXJ2IY+Tg/b/GWCMTTfGSxz2MPuHTml7j9gSbkfKc4rYerMz+VB1F/zky79zRV2jYO8v+ynSioi4mmS0seDwUqshggKFcghuJPaQ2KljX6ZskML/2PpnzNQBxTSK5q4N7ONoufwx0Yj86lH1S3vQLssr76Mz9aWz7yRvBgJ7r0J9o4alPlc4Lt39Uyd2FK44okwA/4eRmSSaLRSSfo5MoWEM/dbOCOqnqsPGby1/E7y4MM68AEtJNdotmNH4kDKEqSRQRjtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+5L9GGwtex3HVLIen2scRqjmkvW0WBUfR10o9bLMpY=;
 b=aUIqXirUbDo8I+bF2+NREh9sIW45OatiReWU55252vs4HbV6N/pi45hKQxXoclwg9nbTSLeRAAQPLY1Ill6UclTmTq3m4qDirskHXiq4+FO59XaU8hWpmirbFjQbTYFiIjzyJS6EPfEG862ILFo7XDuyD30GKlhbswrm9h/4q9o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by DM4PR12MB5310.namprd12.prod.outlook.com (2603:10b6:5:39e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Fri, 22 Sep
 2023 10:23:38 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::a285:eb6e:8fc:7cd7]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::a285:eb6e:8fc:7cd7%4]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 10:23:37 +0000
Message-ID: <641d0bc9-94ba-478b-9626-b5acef4ef892@amd.com>
Date:   Fri, 22 Sep 2023 15:53:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: rom 3540f985652f41041e54ee82aa53e7dbd55739ae Mon Sep 17 00:00:00
 2001
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org, peterz@infradead.org, leitao@debian.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, leit@fb.com, dcostantino@meta.com,
        jhladky@redhat.com, eranian@google.com, ananth.narayan@amd.com,
        ravi.bangoria@amd.com, santosh.shukla@amd.com
References: <20230914140604.267672-1-sandipan.das@amd.com>
 <ZQ1mdoMBJd4PCvZa@gmail.com>
Content-Language: en-US
From:   Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <ZQ1mdoMBJd4PCvZa@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0104.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::6) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|DM4PR12MB5310:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b1f564b-656e-4725-9f2a-08dbbb55fba3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BMIqgOar+BA9+Y69P5O58X842NE0aiG8n2DUdacPHJPypF7Y71O6IEDymk2o3TckpunX9BDy8urOXGYbWkNT6/3WcGhY+Nuo5x6LdzaivINWbPE5DINwDq86cuJaG1uTy8i8T6FzEX3eA5FWD7f6LQ7wLEzOcJ4GCSzvRRVM2RnqMHYygH4WsOwS2gEtezbFR7zZqhI+RdRtakTpUt8f2rRUdV3ncgCJBQQ4xzffe2+UkU0Kn3VZJ8oJ8Q1LDz/MnkPQJCbrhSlwcDKi1cRfU2ZsBxnxn3PXhWtwTSr5aG5pCIz8y9stuvekCUyyVCwuGoHrHQD3U1CEGPApLzKpVhXj5IF5fAHXILSK/JGhWwXsAkaZYtS/1aiB1AINFyKoAiMF99l/R8fBtrYHzsUbpO4hR4VjGSOUg7wYyGpHeVz6QlYWoGSpF9NW3G5yBWNlq5HB/eZN2DbhaPVHO/+G3Wl6JobwRoQKFMZKKmpAsVYQeGXMad/5B14GhpuRwwcBWNE/SO8N0nVvjiQX9pNhPNSljlUa0Tmh/G+1pojB9U+21LfWkXBasDO6TApr+20R8UyYB219z6KwRtSJzCblgfCf4IjmTWrBKsuvJkxiTiHe7DBZp18eAtAomWo8LhNjMQuV/gL6NNllkx7uUyPHoEAHxlL25jOBI1DUu3eZfFA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(136003)(39860400002)(366004)(186009)(451199024)(1800799009)(83380400001)(31686004)(53546011)(6512007)(6666004)(6506007)(6486002)(38100700002)(86362001)(31696002)(36756003)(2616005)(7416002)(2906002)(44832011)(8936002)(966005)(478600001)(26005)(5660300002)(8676002)(6916009)(316002)(41300700001)(66476007)(66556008)(66946007)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NU9OcGxBZitYVW02OGxvajMwVFJLUXhQWjVITStOeFZHcmZGaDRWQTc3T2RO?=
 =?utf-8?B?YzNkbld0ckZwL1hxdjcySnJsc3RiaE1hRmNORVYrMjBESEV4akVKY1U1ZThC?=
 =?utf-8?B?Y1VCWll3M29IVFZFL3VtMjFDbGtmQWJPOWp1QVR3Zzl4SlpCM3E1MzhLR3VG?=
 =?utf-8?B?WlpvTDZSZG1BUHZMamRNOHgyR3VPTlFic29za1Z5UXE4czFhVGpYODVlYlRB?=
 =?utf-8?B?Q0FuQ1RPV2pjaWhXUFBPb0liWFE1QmNsdGpZR3RTbkxaMStNZTlEQklMaXVw?=
 =?utf-8?B?N0VHSlNhNW9MTzRJNzlCaVZ3am80S2lVNnhva0NuVjB2QXNvenF2NEhtdlV5?=
 =?utf-8?B?N2pwUmxwQjNueCthRzdPS0tJOTRobFp5dVVabGEyOEpSVTl0VGxiUlNubGtU?=
 =?utf-8?B?bmZCTjVwVi9PV3NjV0cvQTRZR242VUZZSGpvckZZYjFQbmNaTjA5aUpaeWIw?=
 =?utf-8?B?WVlHTC9iOFBUaTBzSWVSWHlzUURDNmdQTTFoZkE0SDlrdUVHcmxnVWk0aDQ1?=
 =?utf-8?B?ditBZGR6ZTdkZ3NhaHlMUTIzbFAvRjlmR1ZVVVQvWGVQNXZPYXNZZW10bUdH?=
 =?utf-8?B?TTZYN0lhOWhlU3RxdG9GSGk3anl2MkQ2YWdhSlJEU2gyYWwrSVhrbUFqNjdu?=
 =?utf-8?B?c1dnWEJEaUY2aTdGQStXdE95ekxVbkZSU1hLMUd4ZnNHWXZEMS9yR3ZOYjI3?=
 =?utf-8?B?Vnd0V2IzNnIrMFRhcVh6a3JITnBrOW9GTWs5VU9kL1Vrb2NnR3M5all2ejcw?=
 =?utf-8?B?TU1maWNBUzhlZDZqZ2ZQTjZTNlROUTFaLzRGTWxwajF0ZGdDcDlWSUtJOTV0?=
 =?utf-8?B?T3R3Q2FjRlNZQURnalVGUkk2b2lrZzE3US85ZExrN1dRVi9oeDhjcXFFMEVw?=
 =?utf-8?B?amM4U3dscGg4N01Ed1lQNW1waTIrUFdabjdNVTVZZytLOGp5UXVNZHI0NHNw?=
 =?utf-8?B?RUNsRm1qYkgzQzdGNEtSZmF3d2lPSVRHdHlMVDVOVXE2cGFtQ3U1dlFQZm83?=
 =?utf-8?B?VVczKzFIbkluL0YwSkh0Ym90RkY5LzFKZkNUeWN4aVJaUnA4dXd0SGx4ekZJ?=
 =?utf-8?B?bEl5MTZnUHh1QXhKanlsTzBhQTJPZVB5NTVmcVhEdW9JSFJaU0pCL3U4WFkr?=
 =?utf-8?B?TE85K2swY2dMTzkrczc1NXBDR21sSkpyS0FacmRiY0svUmhzWFl4Nmp1b3NI?=
 =?utf-8?B?dmExY2x3cGhISDVaWFRpbC9nZitXV0ZEZ1ZvSkpXeE83SmFXcGpLR25QRGdW?=
 =?utf-8?B?cFBsOGFBTnNFQXg3VWc1MytzUm5OUWZXWVQrRUJTZTJGa3RHYlFCRFFOMllC?=
 =?utf-8?B?WDAvK1k2QjNHS2srR3hkbG50bGZvcEdoTU9zWjBwMFBkVS9EWmorZDhwMUpL?=
 =?utf-8?B?WEh5SEJZUGtmVHNoMjllcFNNbHpWS081Qjl2cXZ6cnVidUhISEl0NHRlNXZR?=
 =?utf-8?B?ek5iKzJSNEFsdElVOHJHSzRRcHI2ajQvNGZuaFBBZk83RTlmUmdaVmg3dEZw?=
 =?utf-8?B?NmJDTWVpbUU1aldrcmpVVjVyN2lMbStsQS9rbDFSRSsxSjJhLzlRNEJHQUdi?=
 =?utf-8?B?eGZTcXpvWVBYS2NDZVBxTXZhWXNwUjhZMi9NMU9CUHEzd1JTWC8rZDRCTlls?=
 =?utf-8?B?TVQxb0N4VHBCck5iNDlLWGRMN0RMSGhBZTBxVGZ6WmhBSHcwa2pGWEFtYUVa?=
 =?utf-8?B?QmZMZXNvTisyZGJreFVOM1pKY1JsRkIzZWpJbkQwQVFScjFPOFU2RWpuMDZw?=
 =?utf-8?B?MFdLNVN3RVd1d08wa1dNOGJyUEVBUVcvZnhWOGxCYU9QbXo2SmYrRjBEZDE5?=
 =?utf-8?B?eXdTVE5MN0JUeit2RHhTMlM4aUE0ZDNSc01BZS8xOU1UN2pzZGJCUTRKOHRR?=
 =?utf-8?B?QXN5c0RWVEpuTkU5UUREOCs4UW12d2FzenVSYWNKeXRZQ3B1QldqUC90MzBJ?=
 =?utf-8?B?SkZLdURpUVpKb1R4NE5paTZMWVpwL3ROK2dqMFl4TDJ2dTYvb2F5dFdKcVhK?=
 =?utf-8?B?eEJFVUgrU3UrTWdwYVBwU3M0TkRQMVRrRTVZVTdXZFNMZW5EREVLR1VudVdu?=
 =?utf-8?B?T1lXcFpTZmJocDMwUWN4emI2bVMyUnAyaC82Zng1SnloVkp5YWlqSUZrVGhX?=
 =?utf-8?Q?HOBWlsFeN51MlYasuYremXXs4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b1f564b-656e-4725-9f2a-08dbbb55fba3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 10:23:37.5469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Wsw/FynxVcpuT1bDnxUzJfkR2XBT5knifBzIU6V1ylhs0bdHc4mOMbPy8t6g8u+nAvSCNE+r3eFJ7u04qZjHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5310
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/22/2023 3:33 PM, Ingo Molnar wrote:
> 
> * Sandipan Das <sandipan.das@amd.com> wrote:
> 
>> Zen 4 systems running buggy microcode can hit a WARN_ON() in the PMI
>> handler, as shown below, several times while perf runs. A simple
>> `perf top` run is enough to render the system unusable.
>>
>> WARNING: CPU: 18 PID: 20608 at arch/x86/events/amd/core.c:944 amd_pmu_v2_handle_irq+0x1be/0x2b0
>>
>> This happens because the Performance Counter Global Status Register
>> (PerfCntGlobalStatus) has one or more bits set which are considered
>> reserved according to the "AMD64 Architecture Programmer???s Manual,
>> Volume 2: System Programming, 24593". The document can be found at
>> https://www.amd.com/system/files/TechDocs/24593.pdf
>>
>> To make this less intrusive, warn just once if any reserved bit is set
>> and prompt the user to update the microcode. Also sanitize the value to
>> what the code is handling, so that the overflow events continue to be
>> handled for the number of counters that are known to be sane.
>>
>> Going forward, the following microcode patch levels are recommended
>> for Zen 4 processors in order to avoid such issues with reserved bits.
>>
>>   Family=0x19 Model=0x11 Stepping=0x01: Patch=0x0a10113e
>>   Family=0x19 Model=0x11 Stepping=0x02: Patch=0x0a10123e
>>   Family=0x19 Model=0xa0 Stepping=0x01: Patch=0x0aa00116
>>   Family=0x19 Model=0xa0 Stepping=0x02: Patch=0x0aa00212
>>
>> Commit f2eb058afc57 ("linux-firmware: Update AMD cpu microcode") from
>> the linux-firmware tree has binaries that meet the minimum required
>> patch levels.
>>
>> Fixes: 7685665c390d ("perf/x86/amd/core: Add PerfMonV2 overflow handling")
>> Reported-by: Jirka Hladky <jhladky@redhat.com>
>> Signed-off-by: Breno Leitao <leitao@debian.org>
>> [sandipan: add message to prompt users to update microcode]
>> [sandipan: rework commit message and call out required microcode levels]
>> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> 
>> v2:
>>  - Use pr_warn_once() instead of WARN_ON_ONCE() to prompt users to
>>    update microcode
>>  - Rework commit message and add details of minimum required microcode
>>    patch levels.
> 
> 1)
> 
> I don't think you ever re-sent this patch with the correct subject line.
> ( Or at least it's not in my mbox. )
> 
> 2)
> 
> So if the fix is from Breno Leitao originally, then there should be a:
> 
>    From: Breno Leitao <leitao@debian.org>
> 
> at the beginning of the patch to make authorship clear.
> 
> You might also want to add:
> 
>   Co-developed-by: Sandipan Das <sandipan.das@amd.com>
> 
> to make your contributions clear.
> 

Sorry for the confusion. I did resend this patch with the correct authorship
and it can be found here:

https://lore.kernel.org/all/3540f985652f41041e54ee82aa53e7dbd55739ae.1694696888.git.sandipan.das@amd.com/


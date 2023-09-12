Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5A7579D9BF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 21:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233160AbjILTpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 15:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237728AbjILTph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 15:45:37 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2089.outbound.protection.outlook.com [40.107.212.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95D71AE;
        Tue, 12 Sep 2023 12:45:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cl2mguDO7XuVUpnIisnLQ0sGgaOGB1Z1XwaSQNv3VTbR4JTZZz5TLQUzxOgsES4PnER6iPKwyCDjVi3J3D9lMn0bnz88lcgMcJJLz+6AWYMmqetXtREJJ0102pRdCPyJSWEiFG5QII5jbHa3+8uZZ4NiGlZot5RCp7tjz3/OpSmfkldG1sGUfZbCK8pyxlC8v2dyCWxcwOXaOUScdjNM5PB3CewK0C/dtFE/6P+gHa8E3E9rrDJePjQ++I2pGF06uMrfI/2WNufviOU6Aafeu7N/G7iabxg1hGDKhE4n7fuHUFHTloJgg4Iq8AsURh9+e27Iqhyli3JZUqaWU4X1xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LOiWhEU22s8qP7c7cHCkXzkt0VWNM9wBovdzZ9ghjNk=;
 b=heHo36R/A2HbV6pJ6NVWxBEIvtLqFlCZ+EnUFwN8e1GuAVsOWU7COlx23A/xWfL21/FrEq0DTGacZaxHBjuZuClaORjeoV/ckJxz+T/tZv4rPHtJS+Y8fXwXxz0UsZKR48CemtqAMzS4lKExKqLLt0bZiVPNgTVqakqTMhjISSLbZiKJBNzvtkF6pQEskzSeNwXlM5JGRkGL2GUG7x5yS4StdsweqIaFIU383IAh+paBFOQwM+SNlxRdr/Db9GRBjEEr7VfXMJbeY57W5/7PkN8RYcvuY1B2h/4rymg6TommNRNia3gtFpspziu5U/K0ghMqwxYQeCsw/0IdS/RWwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LOiWhEU22s8qP7c7cHCkXzkt0VWNM9wBovdzZ9ghjNk=;
 b=C+OJGr+v/0tSwcYzjcZL4qAKSJ+8nEdHp71hAOqcTWzklMvZbQhrJjw/mnukkhMh9gT9e/DlD79Pw66MBD+ZR/bfAoh4X7DdGSN+DlPq43+01aE/EB0uUrxpNHxBspCPuV+w3R5Xs1/+aHXWUcTr0HXHGe0w/cs6bCp7BZbR7E0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH7PR12MB8013.namprd12.prod.outlook.com (2603:10b6:510:27c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Tue, 12 Sep
 2023 19:45:28 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e%5]) with mapi id 15.20.6768.036; Tue, 12 Sep 2023
 19:45:28 +0000
Message-ID: <2f5cd2a6-4f1f-c841-2a5f-862a0cc5d96d@amd.com>
Date:   Tue, 12 Sep 2023 14:45:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v9 9/9] x86/resctrl: Display RMID of resource group
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     fenghua.yu@intel.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, paulmck@kernel.org, akpm@linux-foundation.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, songmuchun@bytedance.com,
        peterz@infradead.org, jpoimboe@kernel.org, pbonzini@redhat.com,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        jmattson@google.com, daniel.sneddon@linux.intel.com,
        sandipan.das@amd.com, tony.luck@intel.com, james.morse@arm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bagasdotme@gmail.com, eranian@google.com,
        christophe.leroy@csgroup.eu, jarkko@kernel.org,
        adrian.hunter@intel.com, quic_jiles@quicinc.com,
        peternewman@google.com
References: <20230907235128.19120-1-babu.moger@amd.com>
 <20230907235128.19120-10-babu.moger@amd.com>
 <fbf1f7e5-1a82-303c-3802-2f246505c8a4@intel.com>
 <1b6d1121-00a8-5f30-26fd-d5137fe9d9c1@amd.com>
 <902ae38f-fbd5-2686-0467-ca440e9a7a50@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <902ae38f-fbd5-2686-0467-ca440e9a7a50@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0085.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:35e::28) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH7PR12MB8013:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f9868b3-bfb3-4273-35f5-08dbb3c8d0c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mo2PUSekP2wD/Qic5tkVpR7l1c9hXO3XZd51DxGi5wYwBn7bNXIqs1eDE5P63Zz88Sdxt6TPa/Y1XnYDwA3ieaG6p0mTT7ZtVWXO5+wJCdwYG1EzPB7/tnKRfTOIQxdL6/zS6AtouKl6SGLZvqzAE3RGFd8CFRMvLBHSqe2i6fkhGWq+v7ovk3lRnT4pVLcuBaxk8wnunnDE69x67jTHkgAmyVqoWnnT54lMkYpEFelWU/zPpQX5XbQ1gdBms28aBV+Yu78YHXsSdaWVTwMjKVsE2eXBotT4ZROaiuCsWj5i+sZ+a9dcgiSacEqFb7KlNyPhtimbcXcf2/gS3LqK5ToWN29vst5VHUlRCF39qsSeE9/9LEveR+L/vBPqQHvueZooSj8sdWKwuUW8fDbBUF8FKyRuey2RblNarKZRUCUJuxojQOejiXDdLPh3DgCxdesjaDOH/TZDKfdeNIL88cGnZY0ZYigjTRxrdcsvSJzKOSVwAYADL14Hrb8bpbgw1Wm4n2cUiOAhBUNNW3SMBS6JZIIaOfgWRXJFlY4pR9FMz5HvagWjFwGS9Q3/ywk3QkMZE2ZzLyy6mtUKw2FmiCVHy7IkOT+w6TBB23WC0BxSLnWdvcTRD2Yq4iTBccUYYyr+/2dg+JGHL8SCBjbcdw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(376002)(39860400002)(366004)(1800799009)(186009)(451199024)(66946007)(66476007)(316002)(5660300002)(53546011)(2906002)(6666004)(3450700001)(7416002)(7406005)(66556008)(8676002)(26005)(478600001)(6512007)(6506007)(6486002)(4326008)(8936002)(41300700001)(2616005)(36756003)(38100700002)(86362001)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUZib1l6LzVGd3ljeWhRT0orZjJVeFhxUzRCVlZjekpQVHRDMUVrOTZ4eGlt?=
 =?utf-8?B?V2hZeWdjOUVKZVlXWGppMDdQRWdZRUl1UHQ4Q296aitCQnVLZStTOTBDdyta?=
 =?utf-8?B?L2M5L2xlVmhjUWMwZy9NeXluc1hkMVRSQXNFb0RXeFovTTExRXk3MldvOGZC?=
 =?utf-8?B?SExKZUhNU2Y5R0dGRHhIZXhheWN0SjFzaUhEZTZMaytBaWZFclk4bU9rQTR0?=
 =?utf-8?B?T2lkSzBRSm44eFJiQThEejhDd3plYiswN1dtOEw2aHFyTVYyQkoremVkckFM?=
 =?utf-8?B?ai85VEp1dmxOeEdGY1FzRGRCZE1hYzdCWGQrekV5WHo2eWdkNGlVTUgzWisy?=
 =?utf-8?B?M3FvR0ZkekcrZTFkWmdJTXZJWmVxYUo5TUNPeG82N0ZBZWE2V083S1Nua29v?=
 =?utf-8?B?YW91dDJTanIwR1pWS2RMRTlLOEdNNjFsdmpkR20ycDFNOEo2Z2g0NXNZYlhG?=
 =?utf-8?B?d2ZXN2JOZlhpUTVjd2J3Wm1mQ296TEo2UVZSbXc2d3QxaVluV1ZhSGxtUlpp?=
 =?utf-8?B?dWM3cXNsYVdiL1R0bUd3SEtrdURzSjBnUE5TQUdvS01COGNjQStxeHdlYUdU?=
 =?utf-8?B?MDNibWcrMVMvSkJOTUVpdnpndXBYR0xaVUgyMzdYYUFlaDdkZktrb3RSa0l3?=
 =?utf-8?B?aWhOdW1FbzBUeCtZdGpFcWcwZGRMUGltbTFYK3QrZ1YwcWViY1pEZmxQaWdV?=
 =?utf-8?B?RnFZcXQxZ3N1UkdrNi9ZbUN3K1gwMEtHZVl3Ymg1TXRKVldwNDdOUVZhR2dJ?=
 =?utf-8?B?Qkw3UEpZVktrUE5Ic0pWWTI3RWErKy9MNTJkYmVDYkdEZFlNVmFtUmJCYWky?=
 =?utf-8?B?SzVHMXVuUWVobEVkWEpKei9TTWMyakxoWjFGYUFhdytqdzBtSURPNFZDY0Mw?=
 =?utf-8?B?YkhKWkg4aDRIMGhLQXdIcEZsL2hPMmdOdDAvbzVkTG56dVVTUnNWQ0YrL1Nv?=
 =?utf-8?B?UGJFZnlLdlA1bi9Qb3lzN0svcU8yT0tuemFyMmtSdHVHQ3RxVUFLT0p5Y1o1?=
 =?utf-8?B?aFVFNW1tejdhYjY2Q3RZaWJnWFNnZnpOU00wTEsydTR4SG56SXA1YnJJWTlC?=
 =?utf-8?B?SXZMT0kyNEhDcktKdnJlb0Y5QmxPUUh5Ykk4WkdFT2U2RGpMQlNNenVpY0xy?=
 =?utf-8?B?akpPazNkMGR3Slo1dERUK1lOM0ZXRENwejloOTV1Qkt3TVV2c3dzaFdJMDJu?=
 =?utf-8?B?eDhwVW5YN0J1dW15a2VaZ0NBOGkvTjdaclZMeW9YSjB5TFNSS3lCekhDT2ht?=
 =?utf-8?B?Y3NRbzBTR2VhbHJ4WEwxOWs4OXVTZVJWWU4yZlN5OGxRVTkzYjlsdERacVRp?=
 =?utf-8?B?d09vVEUvQzIyRFVZMGxvUW04bTVndnNaLzhrUXZKV1hEYlF6aDdTcHVZUWFI?=
 =?utf-8?B?blovbGVHSGYyTFdTWXp0WlBLNlVaSFBCYVdublZvc3o5ckJRc2svclNLWjJD?=
 =?utf-8?B?SStXa1BJTnEzZzFKTUxjMXladFVpUzUrM08vZ0kvbkFBSWUzdVp6VS9aenRk?=
 =?utf-8?B?RmR3KzdKOFdLMnZSZldiS2crazNrZDk3S2E0MnZWangvSzBITHpCbXN5WnNi?=
 =?utf-8?B?WklXeXlLNGMvdVFKRk1QNlhIMk9EZWFlUzBVSzRodWc3VlllQjZYZG82elBU?=
 =?utf-8?B?VFVZVnIxcDNjcDhxYUdsU1NDTUFYT2ErQm9JQzBqWmxrYStkZ0dsL21ObEdW?=
 =?utf-8?B?U2I3eFBZNlNjbllKb1U4dUJkZnFNM29CWlFYaGQzd0NTaStjbWRIS1o4Q3lH?=
 =?utf-8?B?cGYyUWZPWjlvTDZCZU1WQW0zUjdrelBsQmtPSytyQ0xtRDlHd25vUUM5NXNI?=
 =?utf-8?B?ME8wTXlBZ0t3WG5mTnRiVDIyVzV5MUJzNnNTRW53VFVoYitZTkd0S0k4QnZB?=
 =?utf-8?B?R2l6VFBwVDNjV083cUFESVltWmpyNis0NWhIMWZVSUdad2dBaDFOMGt1d1l4?=
 =?utf-8?B?b0NwL2FUVktiVVpKZkFucFhJRmZPTDFaYWJsMUpEMEQ1QU9uK1FMNzhHTkxt?=
 =?utf-8?B?OTM5VkpkOUQrMENyek1jSHFmbllUdDErTFRrUmRQdFd5d3A2TVl6VXBqeWps?=
 =?utf-8?B?cVRONXpYRmtMdllhbWVXL2dONVowME5zZU5vbE9wMHN5R1BuMDhteFBXOXNC?=
 =?utf-8?Q?bKwI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f9868b3-bfb3-4273-35f5-08dbb3c8d0c1
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 19:45:28.2468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rhLuYaTNYCEd+T6YkZSNNcU+GusAMe69uCuoZQk0nAKzsrANuIrPFJCWLNoqhB28
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8013
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 9/12/23 12:57, Reinette Chatre wrote:
> Hi Babu,
> 
> On 9/12/2023 10:39 AM, Moger, Babu wrote:
>> On 9/11/23 18:08, Reinette Chatre wrote:
>>> Hi Babu,
>>>
>>> On 9/7/2023 4:51 PM, Babu Moger wrote:
>>>> In x86, hardware uses RMID to identify a a monitoring group. When a
>>>> user creates a monitor group these details are not visible. These details
>>>> can help resctrl debugging.
>>>>
>>>> Add RMID(mon_hw_id) to the monitor groups display in resctrl interface.
>>>> Users can see these details when resctrl is mounted with "-o debug" option.
>>>>
>>>> Other architectures do not use "RMID". Use the name mon_hw_id to refer
>>>> to "RMID" in an effort to keep the naming generic.
>>>>
>>>> Add the flag RFTYPE_MON_BASE, which contains the files required only
>>>> for the MON group.
>>>
>>> As I mentioned in [1] I believe adding support for files with RFTYPE_MON flag
>>> to resctrl needs to be in a separate patch. With the core support added a file
>>> with this flag can be introduced separately. 
>>
>> Yes. We discussed it. Thought it may not fit as a separate patch on its
>> own. So, i combined it.
>>
>> Now, I split patch 9 into two. Let me know if it looks ok.
>>
>> ==========================================================================
>>
>> Author: Babu Moger <babu.moger@amd.com>
>> Date:   Thu Sep 7 18:51:28 2023 -0500
>>
>>     x86/resctrl: Add RFTYPE_MON_BASE for MON groups
>>
>>     Add the flag RFTYPE_MON_BASE, which contains the files required only
>>     for the MON group. Files with these flags are only visible when
>>     monitoring is enabled.
>>
>>     Signed-off-by: Babu Moger <babu.moger@amd.com>
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h
>> b/arch/x86/kernel/cpu/resctrl/internal.h
>> index ccdbed615d41..72988e5c52a7 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -296,6 +296,8 @@ struct rdtgroup {
>>   *     --> RFTYPE_BASE (Files common for both MON and CTRL groups)
>>   *         Files: cpus, cpus_list, tasks
>>   *
>> + *             --> RFTYPE_MON (Files only for MON group)
>> + *
>>   *             --> RFTYPE_CTRL (Files only for CTRL group)
>>   *                 Files: mode, schemata, size
>>   *
> 
> I think it would be ok to add above hunk as part of the patch
> that adds mon_hw_id, similar to what you did in patch 8.

Ok. Sure.
> 
>> @@ -315,6 +317,7 @@ struct rdtgroup {
>>  #define RFTYPE_MON_INFO                        (RFTYPE_INFO | RFTYPE_MON)
>>  #define RFTYPE_TOP_INFO                        (RFTYPE_INFO | RFTYPE_TOP)
>>  #define RFTYPE_CTRL_BASE               (RFTYPE_BASE | RFTYPE_CTRL)
>> +#define RFTYPE_MON_BASE                        (RFTYPE_BASE | RFTYPE_MON)
>>
> 
> This hunk may be appropriate for patch 3.

Sure.

> 
>>  /* List of all resource groups */
>>  extern struct list_head rdt_all_groups;
>>
> 
> This is not how I expected it to look. There is currently an issue
> in resctrl where files with RFTYPE_MON are not created for CTRL_MON
> groups. This has not actually been a problem because there are
> no files with the RFTYPE_MON flag. This series introduces the first
> file with RFTYPE_MON flag and thus this resctrl issue needs to be fixed
> before this new file can be supported.
Yes.
> 
> Considering this I expected to see the changes in rdt_get_tree()
> and mkdir_rdt_prepare() done as a separate patch. This will add
> support for RFTYPE_MON files to resctrl. After this change
> a separate patch can add the file that has this flag.
> 
Sure. Got it.
Thanks
Babu Moger

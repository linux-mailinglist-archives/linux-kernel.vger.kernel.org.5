Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6AF28076BE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 18:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379722AbjLFRhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 12:37:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379740AbjLFRhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 12:37:19 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783EBD66;
        Wed,  6 Dec 2023 09:37:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eroBN9tV71H2+b5HW3maaAEufdQp1Hs5EYETYa7S8+UYZ7IcEmUtCYBoPWAhhSidIbs2VdlPAbFR5/2q4NRmSzxtRwrAjGAe5FgvORELj05uDR5bmIahJXefrZI+AvQNSXt73ltWkHyKYJaXr80G9Jd9oDCK4orseedq9XN7dZ6czvvolngVPck+WvEQrWMcWD2wUBd7RId6aB+y5dckw9mXi3gcV9CrBonYdJyCvm7dFY0stfQM6uI0PApHhxyjNt5nNd1KvI6xs8/q67yDC4B79rzvIsxV/gMdBgghLqwlu5S0irC9f3msaUq+LufgO8GC8/2ETrrtVw7b+/IpjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VUsGFccPMUzvxpPDQAu2JWmlHp+JsbL8eOHBo85W1Uw=;
 b=KN3hzmVH0R5hWCMui5ya4MY7hxxsw/Z6/Rr/PIDXO8umzsVvoD0Igx5qfxobPqeeIdyb3Kt0KDxv8MMDjwujDFEsXV0Eg3PVig9YoAiZsjXH10cNepCaTr3S0Kt41WZnogjl8aZiY6/x3tro4CR61h4ISykTp5bcDP3SXK0VL69/kRDQCEQz+tivy0Z5rwIRUOFOLqBWx9UZ3Bit+6whDv1RIY9bEoMu+LHB5V1aY1cjWCmPHCRWXclKAQIoGpiyCFJ/ventTrJaBUXwOO74YRhy0vZ9d6BI61txxIwv2faONOKbvShs8DxUadPy/K6+4zy05cbJH5TqJb4vmhiaeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VUsGFccPMUzvxpPDQAu2JWmlHp+JsbL8eOHBo85W1Uw=;
 b=j0mBHfN+n5I4rELYClTOzQbcX0JamImik3xIeHa4/w9BjMBTK/4uSIMr81pdothrMuvymnR/6yuDtMfySDR1QSmv2ZR4YFu0Ggerb5fNAsjigYboBT/iXc3ASur8umzUgxlypJQOuLYieCgT5s3Si0eQhgszrCw71XoZ/JAct6U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MW6PR12MB7085.namprd12.prod.outlook.com (2603:10b6:303:238::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 17:37:22 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b%5]) with mapi id 15.20.7068.025; Wed, 6 Dec 2023
 17:37:22 +0000
Message-ID: <746f6e3f-db20-453a-b9d0-41d0d398d5cf@amd.com>
Date:   Wed, 6 Dec 2023 11:37:18 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH 01/15] x86/resctrl: Remove hard-coded memory bandwidth
 limit
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
        fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com
Cc:     x86@kernel.org, hpa@zytor.com, paulmck@kernel.org,
        rdunlap@infradead.org, tj@kernel.org, peterz@infradead.org,
        seanjc@google.com, kim.phillips@amd.com, jmattson@google.com,
        ilpo.jarvinen@linux.intel.com, jithu.joseph@intel.com,
        kan.liang@linux.intel.com, nikunj@amd.com,
        daniel.sneddon@linux.intel.com, pbonzini@redhat.com,
        rick.p.edgecombe@intel.com, rppt@kernel.org,
        maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, eranian@google.com,
        peternewman@google.com, dhagiani@amd.com
References: <20231201005720.235639-1-babu.moger@amd.com>
 <20231201005720.235639-2-babu.moger@amd.com>
 <4bca7ca1-d452-4cb7-b721-b2273f9a71b5@intel.com>
 <90245ee3-8357-4375-b735-66acfe89ff90@amd.com>
 <68f2c64b-9d46-4077-a183-0abc21ff0535@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <68f2c64b-9d46-4077-a183-0abc21ff0535@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR10CA0004.namprd10.prod.outlook.com
 (2603:10b6:5:60::17) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MW6PR12MB7085:EE_
X-MS-Office365-Filtering-Correlation-Id: facaa0cb-845d-47a4-ab05-08dbf6820108
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OpkQnZes24fLallr2VlusRVypHl9YqU1z0FhAkLAVSFt514gK/7pxXN5HE9i5ADbpGtbJVyaU/hYP+OT1EFLxAW8tdzWqGf6qW1GUny39dG1goCp15MUHPEvM2+JL7DfZUkBy45jDzFAHvbG9ZJGc7Zqq2LSqIfmf5RVb8xfTUWmnfDfdBYTgAw1sVB/ZxTAh7R1kT9vylCiAZcYBoKPmKfSKZt+8tf8LER6vNYsXEzf682ugLoqb8A7cn4C/UDpHxRrNnV+DzjDWXRoWRsUrC70J9xCre41ek9ju3SAhku39HWiUWkda+F1F5Cs1ZfNx9NFGLaLuNJS6vOCzV1R6aSS4P3ZuaC1NMkmzVxhuyKXoHQwMMBk+jCXmGQ9AwBxWXd0mtPhAOELjTIm58P7G0oJsVkH6Kj6ZIWsQHPhhZv95wlvof7inOXTHZtkSVuNiUoUJK06UqzYf/RgBmDFADvkpJwK20Q7KVY0VnbLztAtsDwzpW5V3FA64/HqVcsZkIwbYBC4SrQPTC2Jb4gXX4azur32bT7FN1HanSbXYtt4KgjUGm+PRdeSek7oFxqCA+eeuKGavZPcUJMs3qVzg9oUURY4Obr6XRAXcIi67a0tG0ZszWzr4RlQ8S7nCH7B4j7QF6LcGQGJelb5lmaBMY5Q3hEb0kjj1kyZ0NJrUPDs62/dA1dBtlTby+b05eIh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(136003)(376002)(39860400002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(41300700001)(36756003)(5660300002)(2906002)(3450700001)(7416002)(86362001)(2616005)(6666004)(478600001)(6512007)(53546011)(6506007)(83380400001)(26005)(966005)(31696002)(6486002)(38100700002)(8936002)(4326008)(8676002)(66946007)(66556008)(66476007)(31686004)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2Z5MUd4VkV1MnE0SUZvdlI2eHBxUlhNMmRKbGJtbm42dDB1Z3p5YnVQL0hG?=
 =?utf-8?B?RExXMVFveHJySkNmYmwxZVYzOFIrQ2NlMm44bnNIL2xEL1VvNEVNU2V6dWJ0?=
 =?utf-8?B?clF4OHFOeld6OTd3eU1Tem5KZUxXM2ZXaUFXNTdGOFA5WW0zVHRkUnFST29y?=
 =?utf-8?B?MHpqSXRhZzBubjlBUUM4NHR2WFI5N2hDMUh1Qm1Sb3dkc2Mrc2o1RDF3aHBW?=
 =?utf-8?B?L2ZZZ2FHanRjSCs0UWxXdCtFSy9CVVBpcGlNZWJqTCtIMlhEdkQrWXE5SmFV?=
 =?utf-8?B?T2dVZnkvc01nRFF6bDBlSXhiMFFreUtZRHFlNXlXWWM1MWpYcmIrc0ZhU2tl?=
 =?utf-8?B?cnBmK3FxSkFlbHhqb2c0ZWM0bXVMWkVVQjlsQ0E5Zk9KYlRoaWhjSjZPNHgz?=
 =?utf-8?B?aS9rQTVWTkNXNE9BSTg5NTEvQWtCMTFpYVppamhCNHI3UEg2NHphY0RqQ3RH?=
 =?utf-8?B?dHBxVFl3bUIvWFpIOEk4d284SDR4clVBM0pUbVN4SS9yV01lU29FWmhIYmln?=
 =?utf-8?B?Q252NCsydVBDU210TDZvUGtjYlY3QXlKeXU5c1ZVQ3l2ZUZCa2tkd21BZ0o4?=
 =?utf-8?B?SDRmMVBsbklIVnhVTE53ekQrZ3QwU2hyVCtWOENoUDVYYTdUMU93aTE5azVO?=
 =?utf-8?B?THlzck5jNE9WVzdxTHRtTGhUM2dqZUpmYlJXa21wUEFKKy9CZ3FZZjZIZXlk?=
 =?utf-8?B?NFlrdkYwYktxSExXL0hVeGJtTDI3a2JWZFZkWnNwRmVsRXNsb1RxaDYzVk5w?=
 =?utf-8?B?dU9qa0QxZ0J6OTJFaW9hQkhDcno5RkJDLzY3SnZNa3FLVHNhbElCenpmc1hj?=
 =?utf-8?B?ZFQvS1lZZzBRL2VSRXdtMlhsdlZOa2tKMnVZNEdGbE5xUHEwbFNIcmczWnB1?=
 =?utf-8?B?bjJTdEtZTDZWeGVuVTZ2T05VUHVaQ3NuZzQ0U2FZSFJRc0tKeE8wb3pGSGdP?=
 =?utf-8?B?K1FJYjd6VXpBRFJ3WWl2eFV3YUloMHAvVTdiejJTSCtQeklJWGlsS0NWNVQ2?=
 =?utf-8?B?Qnh3QTR1WGRrN2UxZnhBUEl1MHgrV0Vub2ZQc0JlR0RXUWVuMHhyQWdjeU8z?=
 =?utf-8?B?Z05CRThBWmx2R0IvaTA4cE1lYnVMTnk5MlEvWUdWQ3A4aVArVHVmSHBwZjFR?=
 =?utf-8?B?SVVFL0d4RW9kbHBudmVaeUFaZEJmZHFPTnNncmVSOGRHNVhQQS9INno1M25F?=
 =?utf-8?B?Um0zdDNVSXgvRU9RQVl4R1NEK2Frb21WejUwdU5kVUpOUmlQRTFBSWhTT05x?=
 =?utf-8?B?VENjZ2tpNks3RWNpb3ErOFFNUnQ3bjU1NUcrK3JValpJWVg3cndodmprLytz?=
 =?utf-8?B?Q1FyOE8yV01OTVRtblBTSjlzVVlESlhrTCtGc29hY0hnUFNVUmlwTVdGN2dx?=
 =?utf-8?B?YnJVNVdnTjBueVE3b1BzQlBrcmxRZmtWUUdXN0d0eEFyMkZLOElZMGJjNzE1?=
 =?utf-8?B?UEtaNnBnZlFXd09CUkpodnhSTndYa3N4bnhvR29IMDZOWTVOZWo4WWdTZHFG?=
 =?utf-8?B?dzBMUTdqZUtrVnlqREJabkcrNUthUkY4VTNVMlRuVVpKckJWa1V2REp1SnQy?=
 =?utf-8?B?ajl0aEtCS1RVYlUzbzc3czZBcmlvSzhIY2doeENtYnRRVWlLRkx6Uit0RXYr?=
 =?utf-8?B?TFZZeUdXcEtGN1RBa1NBUlNGV0lObGd6emY2cWt5Y3pndGptdnQ0b1VmWldD?=
 =?utf-8?B?SkRlQzhNRDFuUGhiMnArVlRGbFlWdDlHRkVXdWZDeTIwcndXR01CT0krWWhN?=
 =?utf-8?B?eGpsZ2ZGRzJ0RDFDbDJ6anVRMUFmZWJ6OStoUHZ5QnNKcmNqTVRlOFNnYWh4?=
 =?utf-8?B?c0tJV1puNk5JNGQwTW9rZzZqT09ja24ranJaMk1vdkM1MWU2OXk2c0lVZnps?=
 =?utf-8?B?NG5XTk5aTk10dXQ0QmZQYUFQWVBzUGxKN1hON2J0cXcvNHJoaUNDT0dGWjRv?=
 =?utf-8?B?b3pZSjAyZW40aERmRmJFcDlVY0x4V243VVluY01OWlNVWXpsY2VyekdzWm5R?=
 =?utf-8?B?cXB3OU1mQVA3ZEpPTDhSU3ZqMVZaaHl1NEVaSWxFc1dOV2NKWkUxNVpHcmhy?=
 =?utf-8?B?KzAwU203NHltOFpQeEVwWms5WGwxSGJKeTJCRExxSjJlb0pMa2VNT3VBYVVt?=
 =?utf-8?Q?GBts=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: facaa0cb-845d-47a4-ab05-08dbf6820108
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 17:37:22.7875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Ig+bYQq/y5ax2Eg81aOSLv0IG12OHQYQS7akEgP4xCUC54kINUtSIwjtDPgUanY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7085
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinetee,

On 12/6/23 11:09, Reinette Chatre wrote:
> Hi Babu,
> 
> On 12/6/2023 8:29 AM, Moger, Babu wrote:
>> On 12/5/23 17:18, Reinette Chatre wrote:
>>> On 11/30/2023 4:57 PM, Babu Moger wrote:
> 
>>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
>>>> ---
>>>>  arch/x86/kernel/cpu/resctrl/core.c     | 2 +-
>>>>  arch/x86/kernel/cpu/resctrl/internal.h | 1 -
>>>>  2 files changed, 1 insertion(+), 2 deletions(-)
>>>>
>>>> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
>>>> index 19e0681f0435..3fbae10b662d 100644
>>>> --- a/arch/x86/kernel/cpu/resctrl/core.c
>>>> +++ b/arch/x86/kernel/cpu/resctrl/core.c
>>>> @@ -243,7 +243,7 @@ static bool __rdt_get_mem_config_amd(struct rdt_resource *r)
>>>>  
>>>>  	cpuid_count(0x80000020, subleaf, &eax.full, &ebx, &ecx, &edx.full);
>>>>  	hw_res->num_closid = edx.split.cos_max + 1;
>>>> -	r->default_ctrl = MAX_MBA_BW_AMD;
>>>> +	r->default_ctrl = 1 << eax.full;
>>>
>>> This does not seem appropriate. You are using eax because it
>>> it convenient but if you take a look at its definition it does not
>>> match the AMD CPUID instruction output at all.
>>
>> Not sure where you see it. Here it is.
>> https://bugzilla.kernel.org/attachment.cgi?id=303986
>>
>> Here is the definition.
>>
>> CPUID_Fn80000020_EAX_x01 [Platform QoS Enforcement for Memory Bandwidth]
>> (Core::X86::Cpuid::PqeBandwidthEax1)
>> Read-only. Reset: 0000_000Bh.
>> _ccd[11:0]_lthree0_core[7:0]_thread[1:0]; CPUID_Fn80000020_EAX_x01
>> Bits Description
>> 31:0 BW_LEN: QOS Memory Bandwidth Enforcement Limit Size. Read-only.
>> Reset: 0000_000Bh. Size of the QOS Memory Bandwidth Enforcement Limit.
>>
>> In this case, limit size is 12 (0BH) bits. Max limit is 1 << 12.
>>
> 
> I see it in the definition of the data type you are using. Specifically
> it is:
> 
> 	/* CPUID.(EAX=10H, ECX=ResID=3).EAX */
> 	union cpuid_0x10_3_eax {
> 		struct {
> 			unsigned int max_delay:12;
> 		} split;
> 		unsigned int full;
> 	};
> 
> How the kernel interprets the register does not match with what you paste
> from the spec. This is an AMD specific function, __rdt_get_mem_config_amd().
> Tt does not seem appropriate to use the register definition of Intel
> systems if the Intel and AMD registers do not have the same format.
> Yes. You are right. Our current code has the problem already.

        union cpuid_0x10_3_eax eax;
        union cpuid_0x10_x_edx edx;
        u32 ebx, ecx, subleaf;

Will fix both. Just "u32 eax, edx" should be fine for AMD.
Thanks for pointing.

-- 
Thanks
Babu Moger

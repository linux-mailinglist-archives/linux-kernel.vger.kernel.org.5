Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89AF978E333
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 01:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344439AbjH3XZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 19:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344448AbjH3XZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 19:25:16 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A112BE;
        Wed, 30 Aug 2023 16:25:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Str6VWeWOBh/1tGEQ/O69siu5DRAzFUZjYKbp5DsS8gPZoyUHB8S6HSaWXFNY/19QBsQ+t+SCgJBdFvC+0vMGccl/IpQ0x1aGA3hgovQmJmW2uG95HHHBFLh4BB710yWQ5cDwiW/7MWw4vp9qH0kh1p7nj9YO/151j6ach8NjH95y67/dNG6hLZKnfSocZRxJ5kU7tR2KmAYRvdQNVJ+LppQcoJkvIkbHuhWmaI/pnUj9dsARZWEyTtdHetuLf72cJZeKtTgZ+ww8nRG8BhMmCju1mIfrhbWqxX0EbnCmhFLa6NF2Af6vF0oN7whek07hAAnYyYYMDc7SmL+GHgc6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=djKajlTfon+Er30y35VhoTEPVQC7zSJBfLJGcwsmHW8=;
 b=k2QbN23/HT3+zju82YCh51Ygt8cZ9jcsXAWJBQ29BfDalABvt7UwEfvtrGcuQznXqcy3DFkjGO9Dba/WM9Kg2pjdh7mpDdIR6VBSSYgKxBLaWQpwMH5zChk0ySqAcGiiaPS5waGz4mtFit2zmyy3CKQiZFnPUnNwIqCEpLXuC7u/4Bx4d02+b56DKSlrXsyn1sHRFIXnlgCyeAUom4J+pAO5dYRyOYFp8XGD05UIUQIqilZLGXaTxm3Co3KrwDyOZle/oUFqZ4I7Cv01hgpuGTjZfdh41IdR3Zl/FvGwyqgOv7ZtH8uvWUo64U/fbfGz/8MSx7SDq3k0jpRwY8P7UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djKajlTfon+Er30y35VhoTEPVQC7zSJBfLJGcwsmHW8=;
 b=AmKo0TRdLu4X+tT4l2Ft5ikD8kqUcavKBmv4P/Msj+J7u2EPb0rzQiZnzTgFBvCjVjOuUPr5VnV46PIr0JH2XoGLRxUwyVxq8yRO+nKqa3gg5A43zxVYLlC6CSHar/d98GL9LaVZ740kx0Z1WjbCLVy6zTBkEIdmDKTYUf3RClU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by MW6PR12MB9020.namprd12.prod.outlook.com (2603:10b6:303:240::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Wed, 30 Aug
 2023 23:24:58 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::8ee:edb7:48bd:667a]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::8ee:edb7:48bd:667a%3]) with mapi id 15.20.6745.020; Wed, 30 Aug 2023
 23:24:58 +0000
Message-ID: <f0116f39-25c8-f90e-6d6d-625e363acf6a@amd.com>
Date:   Wed, 30 Aug 2023 18:24:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v8 6/8] x86/resctrl: Move default group file creation to
 mount
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
References: <20230821233048.434531-1-babu.moger@amd.com>
 <20230821233048.434531-7-babu.moger@amd.com>
 <972db626-1d74-679d-72f2-3e122f95c314@intel.com>
 <5e1c084a-e224-a798-65c1-60f827634ee4@amd.com>
 <05b312d1-9873-f006-cf40-1db695b4603f@intel.com>
 <674d9d94-28a1-2468-b2d8-1bf784933d6e@amd.com>
 <8fae1e7c-30da-651c-5761-e2ab2b69eeaf@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <8fae1e7c-30da-651c-5761-e2ab2b69eeaf@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0033.namprd03.prod.outlook.com
 (2603:10b6:5:3b5::8) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|MW6PR12MB9020:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b9b9aed-2b59-440b-4108-08dba9b05368
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B52LIqGKmWfbe9+54iTMhmJucVCETagkrvkTexELX0MAQIqZKBjm7pFuDegQvhpbNk/r3+HGuvi1iAJ+KnCnjPA/CbG5FswJrYUr+mxSRD1Jp+Qp8cQIb1RXUB2wqVUwKEqTIz3otdUOJiqKb1o/NLE7T4qn2L2AINaq1hCxHu5rGfmdXY6egABD89SzC5/b5+CzHj0b6DXhOGQPOYGL8Dds20zK56djK142z8Bg7rO/1yy3KDeoG7Ugk1godfiYFQ0wbv5q+wspjQUMNS+IcKJG4bXIAejClEg3prpTMzr8abcaoDfktxwHvtgx4XT7rXaTkhOxLisWeWLdUWSfn+0Fmv/m9Lj/CLRjDBxZ1BhNkG26LyRMd2TqOS2t11r0yHxNrkhZiU44LqAJO36CWf4E3FqxCIBxqUc4EISYBP+YVAgE7QnQa5ETqSG9KWi4QwBG8GL36VKMEGSYDf3LixtvRfKKf/Asf6Qf+PiPm5nRmnadnQzgSDpMXrxslGOToMFf1P8Gm1N9B4gIdb6Thp+ULmnPizpn6gu4B4KhynIV1WFJYblNO6GERG4sJvSnnfYXSTDN+lnXb0GC0fCSR1O8o09X70weISqRarrvH/US4roU9kB6ZlHmfqwUbiPqZDgyoc7dliQ9T15kEcESSQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(39860400002)(136003)(366004)(1800799009)(186009)(451199024)(31686004)(3450700001)(38100700002)(2906002)(36756003)(5660300002)(7416002)(31696002)(7406005)(86362001)(4326008)(8676002)(66556008)(41300700001)(83380400001)(8936002)(6506007)(26005)(316002)(6512007)(2616005)(6486002)(53546011)(6666004)(66476007)(478600001)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXM2L2YyazMyOHlmV1F5MGF1SWdGcjM4UUpPN0lNOHAzbnNWQXg0aUFnMk9O?=
 =?utf-8?B?M3dPekcvMitxYUM3T3NPejZRQUhuWGd6MkVxM1Y0NUZNekpWMUx5R25qZHU1?=
 =?utf-8?B?SzNDRmZuY29ucTZTUmNVY0s1ZFBQVGVaaVNJNVlmUHhVK0VSRzlSM1E2Rzhu?=
 =?utf-8?B?QmUwNlpjbWt1ZnpOM0lNTVhxQmVHWVJqR1ZiTXIrZ3h1VUQyQU1OeUdoaVg0?=
 =?utf-8?B?bW0vWlNVSVBEMnR4OGZkc1pha2w0dlNkNzh4bmYzcTg5Qmc3N2RReHVlVmRr?=
 =?utf-8?B?ZU9WRHBiR0ovcDFLRFErSVNtd1M3TGZhK1ROR1ZGTjVxWVhvKzlzVGc5VGJ3?=
 =?utf-8?B?SWVQdEZSMEI3T296bzVhQmdHcGw4UGFkMjd4N0NUbDlnWWpxOHpzR3JWRzdU?=
 =?utf-8?B?ZG9UdlFqeVBkVzF1R2JQb1BFLzRONVVkek9YS1k2WVVGR3pnSGc1MFkzNTZY?=
 =?utf-8?B?WXJaODdVQlo0RXBGS2VJSm5qKzhrTExZZWFHYjVLbVRzU1B1ekdBTmlweWQw?=
 =?utf-8?B?RGgvNzhnVGVFd1Y3Z3M5ZEdscWlqOFo3Q1VkTU9nQ0U4SWh0QjVEY0lQY0Fz?=
 =?utf-8?B?ejhhbm1oeGpWM0VrRjhpcWtRTXRmVUg2Rm92Y2t1eHlucFB2SkFkQ0FlS2ds?=
 =?utf-8?B?eUdQYVk3QWt5UkpMeHhSeHpxOVpFNGdqZjRSdXBEK0p5b2phN3BNZElIV1JQ?=
 =?utf-8?B?QjRoVVNJSURLZWpCayt1Qk5yOG9VQmFkUFdXNWh0azBtN0dCS2xvNFdpZTM5?=
 =?utf-8?B?MEt2V2pwck00Wi9NNDR4bU56dU1Dd1VNWUp3Y1RLdUdiakplTVZqQXN3YXdj?=
 =?utf-8?B?eEFKV0pVLy90aGpZVk1XMmlxUWM4U29tOTJNWXdjcXowVXl5V0E4cDFBZTZN?=
 =?utf-8?B?OTdUTm53anZzZTJRNmRGMm9ubFBCbi9Fc2JDUm1FK0FSZ0Myd3dPTml4Vko1?=
 =?utf-8?B?c0RhZE04TElaOXFkeDJ0L0ltZC8zWTk4ZkdtbkpsUlBUdnYyVUVIM0FYM3lE?=
 =?utf-8?B?WllxTnJoQW0wZHlyWkhRQlgxckhmZ1Y3MVVmeDJra1N1bVV4N2J0MzlMbWpT?=
 =?utf-8?B?Y3ZQTmZzc1AyM2F0R3gvUmhRNUtRUG5vdFZuMWoyUVVMS2RmNTBCcVJPZHlG?=
 =?utf-8?B?RUxjOXZLNjk3MWtHcTJ0YlQ0eFdNclprSUtTZGxTOFBFaXRXTWhyQk9VOWt5?=
 =?utf-8?B?emxkTzZoT2JaQVQxVHY3MWcvODBjdVJJWXhpdTE0MGQ3VXVhWFQxZGhXSkNV?=
 =?utf-8?B?UEZ3b1Nta2x3clFDOHdpU2F5OEtEdmpHSWNEbkZGNWE4Tk41MmdCV1Bwc1pz?=
 =?utf-8?B?Yk5aYXN6cDhpMU95SjQvK0srNTZPOE42NUhadk1mc05nZjh2SXQ4aXZjbHFG?=
 =?utf-8?B?ZGM2T3ZZQnhNN2x1a0NLcHJZMG16cVNISktjRUxXRSthUGo4ajI0cjV5ZTl4?=
 =?utf-8?B?ZXpNSHpOT3NhN2ZlVGczVWJDWEVSU2R5My9YZG1JampzcWYxWDYyeFBoUkl4?=
 =?utf-8?B?Y3d2WXQ2S2Jia2VPTVdRRlRhSzU1dVF3bzdLN3lGdlQ2TDVteFM0VHFyL21t?=
 =?utf-8?B?S0hmZFhaaC9UaFVxbkxUa1NiOGgwRkdZRXVEV2UxZ2h1QkJqUGRXTHlHd3Zx?=
 =?utf-8?B?cC93elZ5RHJ3QVpMUE5JZ005ajk2TzhTVHR5bXAyWktHdG9qeTNDN0xLV3RV?=
 =?utf-8?B?ZStJU2huUHRlOHdyMG9Ic3JVVGtuenBMc0dVSmZIYk1CRmwwVHRrNWhhL1N6?=
 =?utf-8?B?cEJTOXg3S0tTVmxBUzkzZGpua0svVGtWMWY3Umx1a0d2UThIRkdxYjdVMy9C?=
 =?utf-8?B?RUdUazF2SlA1TzY2WU5EZlVGeHBTaGNWOVZiN1k1RUJJR3gxY01pUDI5Q09l?=
 =?utf-8?B?ZGk5MXgvT2ZRQXMvQTlZdnpSRjZUUHhtbGgxcGFjK1FSbjJUN1NCVDBEc0Fz?=
 =?utf-8?B?UmhjeFRsVm1zWEJiTW9TMWZiKy9nVTFYNUZpNnlsRGxySFhZckF0dmp0WnlB?=
 =?utf-8?B?d0xTY1R4UCtXcFdDR1JXTFloU1ZYcCtmZTVja241b1VZb2ZzOVdQVTRKSmhT?=
 =?utf-8?B?M0RGTHF1TzdWSHZ4ZjBSK21OUmRRVjBIVmRFTW5uT2c1TnNIV0JSYkZUSHFG?=
 =?utf-8?Q?5LgA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b9b9aed-2b59-440b-4108-08dba9b05368
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 23:24:58.5188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XwvDyvvhpkSKB3j221+Nh3QclsHhfzEyJqyN1LZd0A9qAhM73f7myk1p25qOhZpn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9020
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 8/30/23 17:05, Reinette Chatre wrote:
> Hi Babu,
> 
> On 8/30/2023 2:18 PM, Moger, Babu wrote:
>> On 8/30/23 15:00, Reinette Chatre wrote:
>>> On 8/30/2023 12:50 PM, Moger, Babu wrote:
>>>> On 8/29/23 15:11, Reinette Chatre wrote:
>>>>> On 8/21/2023 4:30 PM, Babu Moger wrote:
>>>>>> The default resource group and its files are created during kernel
>>>>>> init time. Upcoming changes will make some resctrl files optional
>>>>>> based on a mount parameter. If optional files are to be added to the
>>>>>> default group based on the mount option, then each new file needs to
>>>>>> be created separately and call kernfs_activate() again.
>>>>>>
>>>>>> Create all files of the default resource group during resctrl
>>>>>> mount, destroyed during unmount, to avoid scattering resctrl
>>>>>> file addition across two separate code flows.
>>>>>>
>>>>>> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
>>>>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>>>>> ---
>>>>>>  arch/x86/kernel/cpu/resctrl/internal.h |  2 +
>>>>>>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 55 +++++++++++++++-----------
>>>>>>  2 files changed, 33 insertions(+), 24 deletions(-)
>>>>>>
>>>>>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>>>>>> index b09e7abd1299..44ad98f8c7af 100644
>>>>>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>>>>>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>>>>>> @@ -611,5 +611,7 @@ void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
>>>>>>  void __init thread_throttle_mode_init(void);
>>>>>>  void __init mbm_config_rftype_init(const char *config);
>>>>>>  void rdt_staged_configs_clear(void);
>>>>>> +int rdtgroup_setup_root(struct rdt_fs_context *ctx);
>>>>>> +void rdtgroup_destroy_root(void);
>>>>>>  
>>>>>
>>>>> From what I can tell these functions are only used in rdtgroup.c.
>>>>> Can this export be avoided by just moving these functions within
>>>>> rdtgroup.c and making them static?
>>>>
>>>> Yes. It is used only in rdtgroup.c. We can make this static by adding the
>>>> prototypes of these function in the beginning of rdtgroup.c file to avoid
>>>> implicit declaration compiler errors.
>>>
>>> Why not just place the functions earlier in rdtgroup.c so that they are
>>> located before all callers? 
>>
>> Couple of problems with that.
>> 1.  rdtgroup_setup_root needs the the definition of
>> rdtgroup_kf_syscall_ops which is defined later in the file.
>>
>> Static struct kernfs_syscall_ops rdtgroup_kf_syscall_ops = {
>>          .mkdir          = rdtgroup_mkdir,
>>          .rmdir          = rdtgroup_rmdir,
>>          .rename         = rdtgroup_rename,
>>          .show_options   = rdtgroup_show_options,
>> };
>>
>> 2. rdtgroup_setup_root is called in rdt_get_tree which is defined earlier
>> in the file.
>>
>> So, this needs re-arrange of all these functions. That is reason I made
>> these functions global. Thought it may be too much a change for this purpose.
> 
> I see, yes, to accomplish this would trigger a lot of churn and also seem
> to cascade into other dependencies needing to be taken into account.
> As you suggested the static declaration can be added to the top of rdtgroup.c
> as proposal for the next stage.
> 

Sure.
Thanks
Babu Moger

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D8B77F8A8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 16:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351800AbjHQOUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 10:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351807AbjHQOUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 10:20:52 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2042.outbound.protection.outlook.com [40.107.212.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2CB82D77;
        Thu, 17 Aug 2023 07:20:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UY5AWGZGzBbqlOVrW9npQ/FxK68825QM+6uwIHzpEQo+5DjtispuEOpI89IwDVlNZW1prHYZpDOhBZAkBZ4mG8q00Prz8ONvKnRUMcJMsJFo+2C+jZqWRcI5obf+HiCXi0I1FYeoEYXCfOki9KzmeQXnW4SJe61u8RehGMWlvproP6YDgwvXOqXwHWKSvqcAahQOOPtQMdY6QVfUJYrcdty1ipCLJgXcXCORkkS+aZjD3d0aL6EzZIchzCsxrO6koJ+7jw4w5L4KrwlbQTaA/ZwNJeY1BQ+FBu4Un9C6rGEQQ0CBfIvSOgTP5SttuPLLfhZ3XCOXb2OiG9VsKRhkyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8/cMB2q8u2FS0v1BEc4qEqBHUQh2wvI29llvNxoP+X8=;
 b=TGk7VhcQWUPL7xV2zCP2Qim63zg0jEWjaKHmEQrpWWPVFFbUS52q5T8RMkXO2ar5VFvDSCtaNrkjG/wDQPIaWyeozumX8t4riyHOs+9GjQ2w9kGXs8shDS7At7vQaCEvY9qEy9RDYaf1+bKeJsedGIgLecivE2PqVdmDbzDqsL+QaQOLc+5W7lFcHx6kN+ecCjPbCHz6NEPIx3L5fZJN6WXa7u85KEYCrCC2oeJJexSVj9XcIn9jT276Q0UZyhZsPaWSDdnjxC6Y//lc01GsS3UhjtMGUc1BL+TyaZ9HIwfXg39p0WZsXilgIwQZRVDygZy0AXEfcIsXnJclKC+gjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/cMB2q8u2FS0v1BEc4qEqBHUQh2wvI29llvNxoP+X8=;
 b=ekASVgCEb+OLzlNrZmThh8AZB6eyhnqHIOCTn2X6Rdh9XT4oc0ev6Wq0Whmo3maCPBgXo0/gG3HscuSD14qk8FRpD8NWkZJhpjN9LuVifDiHcOQqXzXDBduGLiIce3Us1vkk3MdTBI1/Z/4L3g7v165LK4KLSSty4+KpSwbP6Ws=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by CY8PR12MB7611.namprd12.prod.outlook.com (2603:10b6:930:9b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Thu, 17 Aug
 2023 14:20:47 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::93bd:7d4:6a9a:45ad]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::93bd:7d4:6a9a:45ad%6]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 14:20:47 +0000
Message-ID: <702d2d05-d37e-c275-ab05-a88cac49a81b@amd.com>
Date:   Thu, 17 Aug 2023 09:20:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v7 4/8] x86/resctrl: Add comments on RFTYPE flags
 hierarchy
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
References: <169178429591.1147205.4030367096506551808.stgit@bmoger-ubuntu>
 <169178458575.1147205.16331131496340363561.stgit@bmoger-ubuntu>
 <37986ad0-4519-0f16-c09b-86fcf2f8a763@intel.com>
 <c341b2cf-7ebc-f52b-76ba-77a106dc20fc@amd.com>
 <25c23223-520b-f6ff-ec8f-678e2524c511@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <25c23223-520b-f6ff-ec8f-678e2524c511@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR11CA0041.namprd11.prod.outlook.com
 (2603:10b6:5:14c::18) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|CY8PR12MB7611:EE_
X-MS-Office365-Filtering-Correlation-Id: a1e6d39e-3a4c-4eca-0e1a-08db9f2d263b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tbEqUhsTOJJQOT2+URPznAnWCNqECRr+dIk6L8MApQBkjiYdAJKUeKvFSNgQPR/IrGtg9ALpW2QZPZVh9gThFh1NkfaayECmuUMbyYvZ68i56f2Y6N3X5cpEhlK9Jqq2UIV+8WaX30gwWRJhLX2So9XdBSX2zo9J6+WAqt2y/CztyavlxTijZWZJHxt9DcusfyNCJbbFsc7AvFzSF3E0hbR5RkCYq+aYVlHC90LhBIUrXSPp6vcJ2/tpajC2JyxeywEtWhWZKJ0+pKdBZKRhwY+zHfZYswUy/Te6zS1mFWwjcbOjwDJPn5Xjj0M5ugoEJatX/OGSS6jSI66ewbA8M/XxCVKsC4bKxuij0pkWj7AF5HgdSte4iFHlqI0ym0vES7vrjio92xsvS2ahY8qzQT25iagGv90P2CfIkRTRHUOEkPCIP2Fa5c8Ntbie0+4B1VOcCRHfUTYczUz03oC+GtsLFOE/bxF+HWX5qmTVHz0u11qEvawYerqb1UWy7V930K+Ji5DQONzxAGk1rP3DbwZyK6GVQIQgluXAjFkuTHdw4HayPHpDxx4wU+sZ7GTYHmm6XkptEbvQ4apX0dPMyI1PaurnoxW/zpFOu1TcYZeib6WQ+z7H/2SQambNCQP+IQ9ga9qmuuWvVWe3tpKc7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(346002)(39860400002)(396003)(186009)(451199024)(1800799009)(31696002)(2906002)(3450700001)(83380400001)(26005)(7406005)(86362001)(7416002)(478600001)(6506007)(36756003)(6666004)(2616005)(6486002)(6512007)(53546011)(5660300002)(41300700001)(316002)(66946007)(66476007)(66556008)(31686004)(4326008)(8676002)(8936002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTd6TTFSL1lZMmpsV1hzSG52NVZCRjFzUW5MLzNUa21sV0ZqY3k1bjZneC9P?=
 =?utf-8?B?UTc3WDFndjlxaEd5UDlKeTFGK1kycVRxMlJ1THNMdFVGdUtqaDBYZVo2UGtM?=
 =?utf-8?B?a1VPRjBZd3kyY3c3WkkxMy9IVHlpaUFVVW4wdm5Kem5zWExkMC9reXVOMFRY?=
 =?utf-8?B?SkliUkNIQ2Z5M1E2S2JwOHlrcnFidXF0WGw2Vk1HUHZJbHhqUmpkU095RTJP?=
 =?utf-8?B?QTZzbUMrRnpyYU5PZ21acEJPVjJYZVpnSUg1MUVIZ0hLNmpXK3J2K0I2TElP?=
 =?utf-8?B?SUNrcTNEcnpJaHlTL2E0U1ZWRllSTlRUbFI2Vkxvanc0eDBidmN5QmR3VzBi?=
 =?utf-8?B?MWtpN2Y5ZjFYM0lDemNFdmFNNEJsNU0vc1BsOEFMTlRZdmlySWJwYTVZU0R3?=
 =?utf-8?B?d2pZcGE1eWJKSVBaT09hQmVzYmIwQnN0c1B2VVRZMUJweFpFOW5EODlJS21y?=
 =?utf-8?B?cnNnZzd1K0xFREJ3NkVEcmxEM2RrMGpSbjdXRnI4QUJ4SHBXWDlWVFI4cXhD?=
 =?utf-8?B?MlZpeE5MV05PY0pWVVVWRU0wVHNQRVlJVURmRkpQZkQwOVlpTWUxZ1lwb1FX?=
 =?utf-8?B?a0h0NlliTElGeDBYWjJGRHJ0MGxESHBCN3JIZlJnNDJnN0F2dHBreDN6VHNa?=
 =?utf-8?B?aFBsQ1ZSUG5DSDY4TUZqcEZ3WUFNS0E1QkZVS2NtUmRzMDNGTFhRU04xeWlT?=
 =?utf-8?B?RTRJb0R6NGcxai9NSWFmYlBFUlFaeTd4dVYxRWFHbXFOSnhGTm9yYWdES1dk?=
 =?utf-8?B?NFRZNE9hNXpTdDR0QkYrNURyU1o5RlA0VmpjMlpJSGQvTkhZVDJMbUpEdEFj?=
 =?utf-8?B?U09jL0k2TmVHQU1JQkRoNk9HSHM3ZGRuRVJ5WVNGcncwcHZ4SXNQY2h2ZjZU?=
 =?utf-8?B?MVBscWxIVGZOSFFJQ2VBdU5Ea2xiZFF3WjRJbC9yTkhsR3ZsWUwyNmlWVmlj?=
 =?utf-8?B?NnZzVWJXb3lmTERISTMvMXVnc041Uk83LzRJRTdNbFdwTGdFMUo5SXdLM0F1?=
 =?utf-8?B?c2toeEJaZ2NuRFM4T1FRY3l5QzZQckpQSXI3amNWYWJnQ3h1aDUzNkQycmNS?=
 =?utf-8?B?UlFnNzhYbDExaXFiM2l4N2lvblFQUWt4dTFSYWVNbGhLRWlEajkvcDBzTm5o?=
 =?utf-8?B?b0g3WTFyQVFXb25YWDl0bnZqTGVnMlJPZGxubC9IdTZ4NTBGMVNoNzhrVEo4?=
 =?utf-8?B?TThUeTFtV3NTNXNHcDlsYnhqY1JLQjFEcjlnVlVmVmN1TEkvcHlLdzBhVEVi?=
 =?utf-8?B?SmFicXlwb3lqVFlCUWhpaFdjV01nZ0JTMUJJK3JTOHN1M0J2QXBIdVJsRU9G?=
 =?utf-8?B?S2NQM21JNW11SDd1WWJydEhjMENqdFZiamhuaVFsQmk5bUZOMndmQXE2VXhH?=
 =?utf-8?B?UDVUSjdOQ3Y0UU84SEVUMmhZaXhoeVhtT25BYmo4NWEreGVZcEs3Ty9Wa3E5?=
 =?utf-8?B?dkl1aVdpV2wzWVFpMW80WHptVDdoekRkUU1ObG1MTFdTZnpkZnJIM0FYNis5?=
 =?utf-8?B?Mld2MDNxdXVTdDgvSHh5OWFjakhaS25PVTE4UEVvVjl6R1pPT3lnMGdaWHVZ?=
 =?utf-8?B?WU92S2o5TnlIdTFrVC9wUFRSMWlPaTZiakRIMnNSVzV4NGszTno1d0d1cC9Q?=
 =?utf-8?B?QWpRUXpabFBoMVRLdkdKRFVxcUxLWmQxTHJtWGRkWFdvNVZ1Rk44T3MwaHYv?=
 =?utf-8?B?K0J5T3J0ZnYxM0g1aXlZOFcraUJaUlF0c3Y1clBsNGhKdzZCQXloc3lJSDdr?=
 =?utf-8?B?TzdYa1RsdlpJcHl2UjdNMG1IQ24wc0k4REkyUXBiQVhUQktXVUVlQmtQb3pB?=
 =?utf-8?B?QTlFOHdhU3pJMVJTRmhDMzdhR3JiNndvcEh3bzNBczJDVmpxT1pIUDE3cnFu?=
 =?utf-8?B?MVFZd0VaYzNFOU1Pbm5hZ05lMk9yOGZLcWRRN0NvMUY1QUt4Ny9kdVJTZVpl?=
 =?utf-8?B?WTUyRjc3aUhwajJyck9HR3h0K0tWS1JGMWx2VnNoc0dCU0JINDNtMy9TZno3?=
 =?utf-8?B?Ris2ZHgvTjJiSis0Y2FPR25hUGoyY0szTzdJMmVkRG43ZjRSc0FiZkhxNzdS?=
 =?utf-8?B?UmRoOXdDSlFrYnJNemxPdlIzdlZySUR5TEtObFV0WlZMcEhYQmpZa09ZNkYr?=
 =?utf-8?Q?t/rI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1e6d39e-3a4c-4eca-0e1a-08db9f2d263b
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 14:20:47.3572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u0q58IokBKirCj10QvG3xiTc0DKwiXpTcBVljLCq6qRjNRmOd+BF7Cv2CoPF/7p2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7611
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 8/16/23 13:36, Reinette Chatre wrote:
> Hi Babu,
> 
> On 8/16/2023 8:34 AM, Moger, Babu wrote:
>> Hi Reinette,
>>
>> On 8/15/23 17:45, Reinette Chatre wrote:
>>> Hi Babu,
>>>
>>> On 8/11/2023 1:09 PM, Babu Moger wrote:
>>>> resctrl uses RFTYPE flags for creating resctrl directory structure.
>>>>
>>>> Definitions and directory structures are not documented. Add
>>>> comments to improve the readability and help future additions.
>>>>
>>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>>> ---
>>>>  arch/x86/kernel/cpu/resctrl/internal.h |   49 ++++++++++++++++++++++++++++++++
>>>>  1 file changed, 49 insertions(+)
>>>>
>>>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>>>> index 2051179a3b91..37800724e002 100644
>>>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>>>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>>>> @@ -240,6 +240,55 @@ struct rdtgroup {
>>>>  
>>>>  /*
>>>>   * Define the file type flags for base and info directories.
>>>> + *
>>>> + * RESCTRL filesystem has two main components
>>>> + *	a. info
>>>> + *	b. base
>>>> + *
>>>> + * /sys/fs/resctrl/
>>>> + *	|
>>>> + *	--> info (Top level directory named "info". Contains files that
>>>> + *	|	  provide details on control and monitoring resources.)
>>>> + *	|
>>>> + *	--> base (Root directory associated with default resource group
>>>> + *		  as well as directories created by user for MON and CTRL
>>>> + *		  groups. Contains files to interact with MON and CTRL
>>>> + *		  groups.)
>>>> + *
>>>> + *	info directory structure
>>>> + *	------------------------------------------------------------------
>>>> + *	--> RFTYPE_INFO
>>>> + *	--> <info> directory
>>>> + *		--> RFTYPE_TOP_INFO
>>>> + *		    Files: last_cmd_status
>>>> + *
>>>> + *		--> RFTYPE_MON_INFO
>>>> + *		--> <L3_MON> directory
>>>> + *		    Files: max_threshold_occupancy, mon_features,
>>>> + *			   num_rmids, mbm_total_bytes_config,
>>>> + *			   mbm_local_bytes_config
>>>> + *
>>>
>>> I think the monitor files need the same split as what you did for
>>> control files in this version. That is, there are some files
>>> that depend on RFTYPE_MON_INFO and others that depend on
>>> RFTYPE_MON_INFO | RFTYPE_RES_CACHE. In above it appears that
>>> all files depend on RFTYPE_MON_INFO only.
>>
>> ok. Sure.
>>
>>
>>>> + *		--> RFTYPE_CTRL_INFO
>>>> + *		    Files: num_closids
>>>> + *
>>>
>>> Looking at this closer I can see some potential confusion about where these
>>> files appear. A note saying that these files appear in all sub-directories
>>> may be helpful because at this point it appears that this file is at the
>>> same level as the directories.
>>
>> Sure..
>>
>> With both these changes. Here is the diff on top of current patch.
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h
>> b/arch/x86/kernel/cpu/resctrl/internal.h
>> index 37800724e002..412a9ef98171 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -264,12 +264,16 @@ struct rdtgroup {
>>   *
>>   *             --> RFTYPE_MON_INFO
>>   *             --> <L3_MON> directory
> 
> I understand that resctrl does not use flags for directories
> but I do find it inconsistent how the L3_MON directory is
> layered when compared to how the, for example, L3 directory
> is layered below. I actually start to wonder if it may not
> simplify interpretation if the names of directories
> are removed entirely from this documentation

Yes. I agree. But I was thinking of adding notes about directory may be
helpful. See the patch below.

> 
> I also think that the current hierarchy is confusing since it
> uses combined flags while also creating a hierarchy.
> What I mean is, the documentation looks like;
> 
>       *	--> RFTYPE_INFO
>       *	--> <info> directory
>       *		--> RFTYPE_TOP_INFO
>       *		    Files: last_cmd_status
> 
> If I understand correctly the hierarchy is intended to mean
> that all items below flag at that level has that flag set.
> The confusing part is when combined flags are also used, like
> above where RFTYPE_TOP_INFO is (RFTYPE_INFO | RFTYPE_TOP)
> If hierarchy is followed, should it not rather be:
> 
>       *	--> RFTYPE_INFO
>       *	--> <info> directory
>       *		--> RFTYPE_TOP
>       *		    Files: last_cmd_status
> 

Yes. Agree. This makes more sense.
> 
> 
>> - *                 Files: max_threshold_occupancy, mon_features,
>> - *                        num_rmids, mbm_total_bytes_config,
>> - *                        mbm_local_bytes_config
>> + *                 Files: mon_features, num_rmids
>> + *
>> + *                     --> RFTYPE_RES_CACHE
>> + *                         Files: max_threshold_occupancy,
>> + *                                mbm_total_bytes_config,
>> + *                                mbm_local_bytes_config
>>   *
>>   *             --> RFTYPE_CTRL_INFO
>>   *                 Files: num_closids
>> + *                        These files appear in all the sub-directories.
>>   *
>>   *                     --> RFTYPE_RES_CACHE
>>   *                     --> <L2,L3> directories
> 
> 
> I made an attempt at capturing all the items I mention
> above. Please do not just copy this into your next version but
> consider first if it makes sense to you with the goal of
> reducing ambiguity.
> 
> *	info directory structure
> *	------------------------------------------------------------------
> *	--> RFTYPE_INFO
> *		--> RFTYPE_TOP (Files in top level of info directory)
> *		    Files: last_cmd_status
> *
> *		--> RFTYPE_MON (Files for all monitoring resources)
> *		    Files: mon_features, num_rmids
> *
> *		    --> RFTYPE_RES_CACHE (Files for cache monitoring resources)
> *		    Files: max_threshold_occupancy,
> *			   mbm_total_bytes_config,
> *			   mbm_local_bytes_config
> *
> *		--> RFTYPE_CTRL (Files for all control resources)
> *		    Files: num_closids
> *
> *			--> RFTYPE_RES_CACHE (Files for cache control resources)
> *			    Files: bit_usage, cbm_mask, min_cbm_bits,
> *				   shareable_bits
> *
> *			--> RFTYPE_RES_MB (Files for MBA and SMBA control resources)
> *			    Files: bandwidth_gran, delay_linear,
> *				   min_bandwidth, thread_throttle_mode
> *
> *	base directory structure
> *	------------------------------------------------------------------
> *	--> RFTYPE_BASE (Files for both MON and CTRL groups)
> *	    Files: cpus, cpus_list, tasks
> *
> *		--> RFTYPE_CTRL (Files only for CTRL group)
> *	    	Files: mode, schemata, size
> *

Yea. We can go with it. How about adding a little note about directories?
That might be easy to compare directory structure on a systems with these
flags. Something like this.

+ *
+ * RESCTRL filesystem has two main components
+ *     a. info
+ *     b. base
+ *
+ * /sys/fs/resctrl/
+ *     |
+ *     --> info (Top level directory named "info". Contains files that
+ *     |         provide details on control and monitoring resources.)
+ *     |
+ *     --> base (Root directory associated with default resource group
+ *               as well as directories created by user for MON and CTRL
+ *               groups. Contains files to interact with MON and CTRL
+ *               groups.)
+ *
+ *     Note: resctrl does not use flags for directories. Directories are
+ *           created based on the resource type. Added directories below
+ *           for better understanding.
+ *
+ *     info directory structure
+ *     ------------------------------------------------------------------
+ *     --> RFTYPE_INFO
+ *         directory: info
+ *             --> RFTYPE_TOP (Files in top level of info directory)
+ *                 Files: last_cmd_status
+ *
+ *             --> RFTYPE_MON (Files for all monitoring resources)
+ *                 directory: L3_MON
+ *                     Files: mon_features, num_rmids
+ *
+ *                     --> RFTYPE_RES_CACHE (Files for cache monitoring
resources)
+ *                         Files: max_threshold_occupancy,
+ *                                mbm_total_bytes_config,
+ *                                mbm_local_bytes_config
+ *
+ *             --> RFTYPE_CTRL (Files for all control resources)
+ *                 Files: num_closids
+ *
+ *                     --> RFTYPE_RES_CACHE (Files for cache control
resources)
+ *                         directories: L2,L3
+ *                               Files: bit_usage, cbm_mask, min_cbm_bits,
+ *                                      shareable_bits
+ *
+ *                     --> RFTYPE_RES_MB (Files for memory control resources)
+ *                         directories: MB,SMBA
+ *                               Files: bandwidth_gran, delay_linear,
+ *                                      min_bandwidth, thread_throttle_mode
+ *
+ *     base directory structure
+ *     ------------------------------------------------------------------
+ *     --> RFTYPE_BASE (Files common for both MON and CTRL groups)
+ *         Files: cpus, cpus_list, tasks
+ *
+ *             --> RFTYPE_CTRL (Files only for CTRL group)
+ *                 Files: mode, schemata, size


-- 
Thanks
Babu Moger

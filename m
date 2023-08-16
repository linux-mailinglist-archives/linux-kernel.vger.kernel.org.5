Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0DC877E979
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 21:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345740AbjHPTOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 15:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345737AbjHPTOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 15:14:24 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45042701;
        Wed, 16 Aug 2023 12:14:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SvUIttUEVeL0KMRiVnsUcq83xVCUYF1SdVvLVXHWVTgIjScei9LuYZjga13ScFNRJav0LkPip5eDyMBP+G/JOxq4yGo+37zsMjkO20F+AClHfaSsIwHWxEGbF0bpAFK/JynUI2U7UjQJIPuPBtU7bIOq0riveEZOAX7+GKn+iH49YkLd9r/ItD5rjGIXmZlzq1xDi4Yt/qUTvVxx6tI/IYaX9H1OGykS3iqeRKSmFQkWL4mddViUv+HsR5zZ85sPLzpWiEDNYdumDSkNl7lEa+8ZWINUlPRtxNGQZL6/nTRw9Kn9Kltexli3rijv2v9ntwcUhdjf73JmxzU5+lcyZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X3PaIIIoUbIL7ZbmGmojSYeTyKy+mUuaCGvj0r2FdsA=;
 b=VZmJSBkxm0hRLd7zXn+U8OOApZ+TG0hKKbRzjNbv0OUU0ZsJPAe/MR1n0G5MqjVYuKF9lWduD+lYFQSl7APrnNNK1sg20ORh1EpsjLbvmaxMkcXJBhIb2onstoHiDeJdmYrHuCRQw7FVVMsg0v6wsyYm+NaSK3o2P5vsSMu1XXmLlPCj8FBo1Ap3QvMkVrgHDtIRMY9Apynj911Z0pptrs/7kOF1Nxp1V/sth7KgOGB2klCKYxc1ZPt8Oe3bMDnSxCEYMKlFxt5B6+R++BlCBcDexyt9tOKvO8u03EF4OG0qGdipD9qI0CuO4FTKpANqzbvxik+0kBf6B9aSCYZIWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X3PaIIIoUbIL7ZbmGmojSYeTyKy+mUuaCGvj0r2FdsA=;
 b=0L/SgFjQzUKS0JvhBMoFsScreYxx/9TaFrEi7OMdPpVcyHaR7X1rAUt2YsfgVnORngbr/O9f8wLPVT9zGOgSTGo9u0TfYOn6Nt3/4/xSyOOV39Q8o5aIzC3spqF12UMOitACS0+sEJ5VsxMR1AxBtPhQSDI79yMzlm6UxkTQGcQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DS7PR12MB6119.namprd12.prod.outlook.com (2603:10b6:8:99::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.29; Wed, 16 Aug 2023 19:14:19 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::ae3b:f153:4d30:73a8]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::ae3b:f153:4d30:73a8%7]) with mapi id 15.20.6678.029; Wed, 16 Aug 2023
 19:14:19 +0000
Message-ID: <b9eed930-1a8d-7cf7-0515-1f9d33089953@amd.com>
Date:   Wed, 16 Aug 2023 14:14:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v7 6/8] x86/resctrl: Move default control group creation
 during mount
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
 <169178463637.1147205.7411319721706077266.stgit@bmoger-ubuntu>
 <b84a9ec3-5b65-9334-becc-0d90bfbbccfa@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <b84a9ec3-5b65-9334-becc-0d90bfbbccfa@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR05CA0034.namprd05.prod.outlook.com
 (2603:10b6:805:de::47) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DS7PR12MB6119:EE_
X-MS-Office365-Filtering-Correlation-Id: c6245f82-bc54-4bd6-d77b-08db9e8cfdc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ACe5p3hdW4h4qFqlDHatJ7/SmExUahOJM6pSKcg4l3nS+YlqyJ3roJ+RQPgfF1sWxoJuxYmoV7z74Iz8/JajICcSWkS4U3ERVPeeVK/sRiZxfSww/ENkqsz5N0JHaUl1fVpnyWtPSHaSRFjCx1t3fKPQtmKlScWDKmXMSFZdoPGconaDlr6Uo1AQ2QIOGECwAeNkbRflxMKyMpFto6S3JJoZXrd63MuG80EMiPYgLCCG+c21uW6ZEqrG/GCBSgce23mladCvAFUrfOrZM43sJL4FE2dGGGmNliYJ2o4fvgZBxHeScIntX+mWqwbNmufDNjUTF0NjrigjUIGGk38hkku4phFCS0IJVCop2mimcoMYVtA9ZC9YO2qXiJLLJ85KHbP8FcxLvVpQ/uWxPY/D4QsgFzs4zWpf5Qcy18mMzUeh16t8aK60X9rXqGVnUjonwsqinxLALkIwMRrgAEKOGCoOrhaTNnfOS+2Uk6rOajkmSybPQRFCrLLwUGktH99W22skJca+6/RSTHsU34m0Pn8E1sikbb+unZeEJiIA9p/r8tebFtLY3QSNqnILszjIhKMUQqoecjme+cMARoihq+D0/ql8SyjZkuQYyFYQN7aRXHleVZKlndUJC2FJVaqcqrGVO2VkH7fd/efil1GF7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(396003)(136003)(366004)(451199024)(1800799009)(186009)(316002)(66946007)(66556008)(66476007)(5660300002)(41300700001)(38100700002)(31686004)(8676002)(4326008)(8936002)(2906002)(83380400001)(3450700001)(26005)(478600001)(7406005)(7416002)(86362001)(53546011)(6512007)(31696002)(6506007)(36756003)(6666004)(2616005)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUgyUGlHaHV0RVdXMVk2NlJJNWJheDlWU2ZuY2MwUFpvTDczSUpyc1FqazVt?=
 =?utf-8?B?TFE4VzBGdTM5Y2cxTVN0L2ttckpGbUs2NGFaakJJWkpZektYTTJRQ3FxR2Zj?=
 =?utf-8?B?NEZDOWlvUXNKSXF4aklqWXN2dVhXTjZmbW1XaFZzVmZYL2wxcFdNQ1VkMTgr?=
 =?utf-8?B?ak9OQzNWMTlPaVppTGNKMG5jb05vSUpLTFVEQ29LZHlwQnVDODlUZngzcm1D?=
 =?utf-8?B?SWV2V0Znc0o1N2d5NmdaNW9DeFRPazFNVTRtMCsyWWhIL042WHoxbHNyNFkz?=
 =?utf-8?B?WWw4UE9lbmF2eTVCRVVhMXo0SWx5Mm1lTDdBamRFY0ozQmlsa1ozT0RJWis4?=
 =?utf-8?B?SkZ0cjNtUGlHZEFYa2Y2cHRldjUvTWFBVGR1OGVjNDk0ZjEyN2JobWcvekZ0?=
 =?utf-8?B?dis1MGdHaldMWnNhMXhzdVgyMjBoaVV6bjZBY1NoUTJORUVQZ0lRNEhJa2or?=
 =?utf-8?B?Z1VjZDdtTUdVMng1Z3pEZ2V6Q1RzS0paVHl6TkFzSVIzR0JCNng2dllnMjVK?=
 =?utf-8?B?VXcwSlBMYkR0RGpnZUdzRnNtd2wrOW1IZE1TdVBMUisyRzRuMUdhMDhjbnBm?=
 =?utf-8?B?d0NCMllnWkVHR1NOOGpmRGxBOFBOeThOVlBFbkFxTEYzenVQSHFFVm40bEp4?=
 =?utf-8?B?OFF1WUwrMEZBcXBKS1pOT0twUE5nNytmZklCWkFvOVlnZnFMbWZpN1JnZ2Ja?=
 =?utf-8?B?RVhGVTl0d1JvV01XSnFvRGhLajhseE5sdGJiVnBKdmFvZVF4TzlGdGJBaEJt?=
 =?utf-8?B?UUlsMHlaS3duaVpVRG1jdGZMQVEzZkdPL25DcThhcGQwNENOMTV6cVg5b1N5?=
 =?utf-8?B?d1lKb29mTHlTQ0lMTGlIdGNObjZNTW9vRndsMTN4eUR1VHAzSjgyOE4rM1Nu?=
 =?utf-8?B?MndPaFJkZlRUS2FSTEdNK2JJUmZQRTNGVVpLRFY0YjR6ZkhlMzE4YjludUFk?=
 =?utf-8?B?WnI2SmlkN3I5QU9IS2QxRk1hVGVJNnRTYm1IUlpOeTgrNVJQY2dvazBYTXVa?=
 =?utf-8?B?dnlJMmJpUGdwbE5DR0FJOExKV0tWVm1zMUNrcW44bW9jaDlOSCt1QWFzbHE1?=
 =?utf-8?B?bEh1R0dRcm9maXArVWxsV1RPMno2dDlpYWsxc3EwdmNvTFhCb0ltY21wZDEx?=
 =?utf-8?B?dHgyN3BEVlhMb0pUSHZYUGZISVJSM1NxcnVySXJGdVl3OGJRcXFjYU5XSms0?=
 =?utf-8?B?eHIwa0d4L2dITEhzaGJiM2sweVBCb1dkWXV3Y1BoTEZ0b09iNWpCL1lMOWps?=
 =?utf-8?B?YTNXdXh2eEtGZ2twRXI3ZnFOeWI2TlpPb3NZYTUyOWdMZ1dqeXMybk1Ja3p6?=
 =?utf-8?B?THdiRnJ2dnc1UjBWQ1IxTzdYeW1ieVpvZmdHR3VmeldOQ2xHUnlYRWpsUzZX?=
 =?utf-8?B?Z0VVZEgwK2J3TFFHYnQwZzdyWGh4Z0dXY1c1bGJFUEpIVUNjclhvQ0NodWpU?=
 =?utf-8?B?ZHVxSFEyQmtjUDE4bUZwUk1LNlBBY1dzYTdvNnF5V0FoZENvbHZuYnZxa29C?=
 =?utf-8?B?WDhYaWpzOHJkYjJFa1pCR2trN0l6aFJweEM1UVlOYSt5dWpSMk9pN08vN0xn?=
 =?utf-8?B?d3B0OWdGV0VaT0VLRVM2dVdkZXovakgyMGlEeWUzWUU3MnJnczNxQTFjUEds?=
 =?utf-8?B?TXlHRmdZWFpJOUphUjVRc1d1V0xyUGtQOGdRendYblprMFdPTVFqZlpub3lp?=
 =?utf-8?B?U0Q4RVN0NEJFY0FHb1VTMzl2VFpwaE5XY254SzlzN3Ewekk2S3p2d1BNdFFs?=
 =?utf-8?B?TFdkN25qdW8xZjNLNDdSYlpzVW9NZEJ1akdCM2QvdlZ4MzA1em5oZlB5YjBC?=
 =?utf-8?B?K3RPRU1qUUU0dzI2WC9UN0FxdWNXanprVldMa2psMnhJS254Qm45T2xQV1U2?=
 =?utf-8?B?NWZOQkJMTEZMQ2I5QW84VnBUTVFqcjVWKzdTZnR2akVUVGI0SzRubDZHZGZK?=
 =?utf-8?B?cWgxNFJKckk4M3MrRzBKc2c3ZC9XL05PVVorZ291c29XUDVGVTV3YVRaVjdF?=
 =?utf-8?B?eTlxQXFLa2xVNWIyTjQzdHRiRllWSWtGbkNsc2k2TnhhUFdySVo4S2Y5bUpm?=
 =?utf-8?B?QllUYWN0dU9HSGdnVFZ1VExDaWltSlIzeUx2UWJLYndxVjR2UDA5d2cyL3RT?=
 =?utf-8?Q?KyP0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6245f82-bc54-4bd6-d77b-08db9e8cfdc0
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 19:14:19.6303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uw9cedB7becPe7n8c9sIIv/PdMfJ3CQwz+0XMBSXr3dqsPWREUiwO0yimwoAjxDt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6119
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 8/15/23 17:50, Reinette Chatre wrote:
> Hi Babu,
> 
> Please do note that the subject is no longer accurate.

Changing to

x86/resctrl: Move default group file creation during mount

> 
> On 8/11/2023 1:10 PM, Babu Moger wrote:
>> The resctrl default control group is created during kernel init time.
>> If the new files are to be added to the default group based on the mount
>> option, then each file needs to be created separately and call
>> kernfs_activate() again.
>>
>> This can be avoided if all the files are created during the mount and
>> destroyed during the umount. So, move the default group creation
>> in rdt_get_tree() and removal in rdt_kill_sb().
> 
> How about a slight rewording (please feel free to change):
> 
>   The default resource group and its files are created during kernel
>   init time. Upcoming changes will make some resctrl files optional
>   based on a mount parameter. If optional files are to be added to the
>   default group based on the mount option, then each new file needs to
>   be created separately and call kernfs_activate() again.
> 
>   Create all files of the default resource group during resctrl
>   mount, destroyed during unmount, to avoid scattering resctrl
>   file addition across two separate code flows.

Sure. Looks good. thanks

> 
> 
>>
>> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>>  arch/x86/kernel/cpu/resctrl/internal.h |    1 +
>>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |   50 +++++++++++++++++---------------
>>  2 files changed, 27 insertions(+), 24 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>> index 37800724e002..2bd92c0c3b0c 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -602,5 +602,6 @@ void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
>>  void __init thread_throttle_mode_init(void);
>>  void __init mbm_config_rftype_init(const char *config);
>>  void rdt_staged_configs_clear(void);
>> +int rdtgroup_setup_root(struct rdt_fs_context *ctx);
>>  
>>  #endif /* _ASM_X86_RESCTRL_INTERNAL_H */
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 0805fac04401..a7453c93bad4 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -2521,10 +2521,14 @@ static int rdt_get_tree(struct fs_context *fc)
>>  		goto out;
>>  	}
>>  
>> -	ret = rdt_enable_ctx(ctx);
>> +	ret = rdtgroup_setup_root(ctx);
>>  	if (ret)
>>  		goto out;
>>  
>> +	ret = rdt_enable_ctx(ctx);
>> +	if (ret)
>> +		goto out_root;
>> +
>>  	ret = schemata_list_create();
>>  	if (ret) {
>>  		schemata_list_destroy();
>> @@ -2533,6 +2537,12 @@ static int rdt_get_tree(struct fs_context *fc)
>>  
>>  	closid_init();
>>  
>> +	ret = rdtgroup_add_files(rdtgroup_default.kn, RFTYPE_CTRL_BASE);
>> +	if (ret)
>> +		goto out_schemata_free;
>> +
>> +	kernfs_activate(rdtgroup_default.kn);
>> +
>>  	ret = rdtgroup_create_info_dir(rdtgroup_default.kn);
>>  	if (ret < 0)
>>  		goto out_schemata_free;
>> @@ -2589,6 +2599,8 @@ static int rdt_get_tree(struct fs_context *fc)
>>  	schemata_list_destroy();
>>  out_ctx:
>>  	rdt_disable_ctx(ctx);
>> +out_root:
>> +	kernfs_destroy_root(rdt_root);
> 
> Please ensure that all rdtgroup_setup_root() cleanup is done
> here. It seems to me that rdtgroup_default.kn can be left pointing
> to freed memory. Since this cleanup is done multiple places (here
> and rdt_kill_sb()) it may help to create a helper.

Ok. Sure. Will do.

-- 
Thanks
Babu Moger

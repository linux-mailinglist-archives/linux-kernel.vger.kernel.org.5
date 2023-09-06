Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A961794027
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 17:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242437AbjIFPTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 11:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjIFPTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 11:19:46 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03EAE5C;
        Wed,  6 Sep 2023 08:19:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=anF1sa0xnzt3AaB4TYn+pJlhAPlj9nyvhTBO33pb2Je83+keCNmfpVeTcGkEl5In3PhrkDM4nlMdhdY3gElcEw6/WxPjG517ykZ8jhJptMn6qpB4RXuTdD9MfvM/jDywywENVwliSeNc0UDxB/l9nXY4eegr58Auc0XOfmqbIIaqVTrz/bbnPgaf/ynEs7Rp+Iw9RlsRq5dKD8REvhPm3FgGErQPYxJYMVS39DmF7b+7gw9+/NrN+9LQPEsSGNJjtZU15DI0hL2x0njL5/5c/et6RaHFLxV1tBkot1A13TLDsOu0hA161fJKH8PNQlESI1r/tEUsLcEzbrqYZl13OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AkUulbezwecy90Mv4hzGwPcXvmIw7MzD6MtD4s+AZBM=;
 b=FvWXHwZM2xmBPU4KoQVR0iYWNw007nXjq4PYtzsJPzEHdIry7WEe7K6rZla1yTLP+q4XBUE2J6myFql+p6eJJWtaBj3CuznJ+w9MKmRYO72sLG1EAHsf7tevaN1h6auR1MlgeWcEVX92eD9FIdKVejH0Mwl7wAxs2xH/DjhTAbwbd0WctwtSBmCbKF3zKlf2FVPm++5yeuooLehIrojWgRERK7xCBAxjpNCj/ErfPTOBgCTaJyUxmRHB15ZVcaQoPFFtrpzWE1gxFcEutyURl4HJgNTAeDjLUuW0iI8e8vg1gCegXu4lF/38v947Rf4KoloNJ5VevrrS/ZiVTJHRlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AkUulbezwecy90Mv4hzGwPcXvmIw7MzD6MtD4s+AZBM=;
 b=SDZyLKYnxCOhP7ULT+IRcDroNWQp5s1lT0ZdeQ7CJCVVXfqf10nsyWAlVHZhT8hxy2CCWyp+yVR/sfmRe3RWe+3SaiLnwxpPLfNOLxdg9iHcUjBxhzosBaUeViEtasJ9pFBLrH4JO7W7d/SQNdrTBzyA92mSGGWAYScQoICcIIo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SA3PR12MB7973.namprd12.prod.outlook.com (2603:10b6:806:305::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Wed, 6 Sep
 2023 15:19:39 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e%5]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 15:19:38 +0000
Message-ID: <c8930384-4fc8-b21b-3ead-537fd80c296e@amd.com>
Date:   Wed, 6 Sep 2023 10:19:33 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v8 6/8] x86/resctrl: Move default group file creation to
 mount
Content-Language: en-US
To:     Fenghua Yu <fenghua.yu@intel.com>, Babu Moger <babu.moger@amd.com>,
        corbet@lwn.net, reinette.chatre@intel.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de
Cc:     dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        paulmck@kernel.org, akpm@linux-foundation.org,
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
 <d6af932b-4e1b-103f-77f0-d91c2f3fd75a@intel.com>
From:   "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <d6af932b-4e1b-103f-77f0-d91c2f3fd75a@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR17CA0027.namprd17.prod.outlook.com
 (2603:10b6:5:1b3::40) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SA3PR12MB7973:EE_
X-MS-Office365-Filtering-Correlation-Id: ab7b0a86-041a-405c-5c64-08dbaeecafbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yl4Ebk8ZIrtfINKopdGcgTIApbTlElB3iP7PAYyNpAnFQRnGf0qvympCdSV8lcrt+c6DMbkrKbOQC+cMWTM+lcuoZZcZmFmcof671VQrB/JhbzVHwJ6DgRItec9qhkkBSgihodnASzv45KUjdv9xMJiDb95of+0J+PvUris8lLjxt7amQBjPjJT2E/CGcWnHdWOHqCWbNoQJT3D7+izF3v1fevACyVIBkqrezTuOR8c5GdTAbF9jqd0y66aLAWqR478nrG2qxTGLfxaYHnainZQ6Jom8IjGusQ3baQyn+9K0NBBTxxKEVrzZph3cnZvMuCOSAiJ/lLFOdMZqoMk5TZagRLr96XiKvlrpThF0U7QJ3XXcVpSGYUNoluzoi47xKAQswLFMSQkUChOXwsDVrnHvbcUP7lSsDtJ5fLhg66R4hIvu9d5fnG4JMSADtejXMKpvdUtSgA5CD+ZAFVWbElglldwUD7EIdgq+BwdVy4pT2JlYkUHbZbwPX1qIRTTlxpckOJBK8BX41Ct42dOYp3trEVFYhuKnjWGCtipK5p69NBttbRWdJlLZRCGlYm09JR3uOZBuzENp+pVPWFaAIsxdEhQm6pl/rHVtiEA2A5+dDz1ZXuWIFK4dmfVnziMJWKk6HaPChiYCxRGchDyyUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(39860400002)(366004)(136003)(1800799009)(186009)(451199024)(41300700001)(7406005)(7416002)(6666004)(6486002)(53546011)(26005)(478600001)(6506007)(83380400001)(2616005)(6512007)(38100700002)(2906002)(66476007)(36756003)(110136005)(316002)(31696002)(66946007)(66556008)(31686004)(5660300002)(4326008)(8676002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ky8wdWFTL2JYM0ZuNWt2VjlpcDFyNzIyUkRhamtyTEM4Nk93ck5nRUhleTM2?=
 =?utf-8?B?dDhoUVRwbHVTL3dYRitLb3ozK1M1Y3ZhRlV4RURHaFFmT3JUa1NpWk5kQkd1?=
 =?utf-8?B?WVRiRVlkWlNLZnhWUkhzdm0zRGVqYytXQXY3V0xIelF4SlJMaUY2MnJTbWZz?=
 =?utf-8?B?Z2xQUkFMVVhDOE15N1dwKzQ4SDdKSGZPSXdLOENsQTUzbnlwdzB5SzdWVDFh?=
 =?utf-8?B?cmVReGVDcUJVaWgzYTJhdUViT3MxaXBjbkdYK0F2cjAvaS9RNHJZNHNZTkg1?=
 =?utf-8?B?VWdqRnB5ekYvbnRhVnIrNXVmaXFRR3B1TGVneUNDL1FQSXlJY2kwMGZ3ekFI?=
 =?utf-8?B?ZGpYU0xBdk9RanRpRWF0bkY4Q0xaZGlDVVE4VTRrdWRlY21wbE5xejExUWs1?=
 =?utf-8?B?SkE3OEpBYUl5Q09tRXYxa2NBbHJTeTdzUVB0QlpQVzM3WCtUdnQwanJNbmhS?=
 =?utf-8?B?dGZQVDhQZXI0YnNpZnlmaENXS3o5dmYycWVrMHZBZ1kwaW9BbG5oVWlQZDlr?=
 =?utf-8?B?cmdpTUFOc1BqaVAvS1NnRVU1a2x4R2plQVgwamtiRGFHQ3Rsai9icmZPMFZa?=
 =?utf-8?B?eGFnTmVTakExU0hwZWdFdkNNZlRVOVgyVzAvcGFoNVZuUW9FbFBtNk40d2ZR?=
 =?utf-8?B?UFRCNVVLZ0NoelhRWUExZFA4L3hoejZ4UDBEK3JUZGlxSlNZQ1p3Tzg3bHg3?=
 =?utf-8?B?OGZERjhXWWt1ZWtiK0dGdWo3ZDcrUGEzY3F5cHpwSFBCTGlIckJRaWFnanF1?=
 =?utf-8?B?TDc4Y2lWbStkZURlSWJ4SHNpeHQwVjVHTjZNNGphN3VTY2QxbmREc3ZMODFv?=
 =?utf-8?B?bjRyNmI4QUJnY1JMSUU4QkdsYWN3R3QyTU15QXJoU21ibDJlRDBySHFBQVpa?=
 =?utf-8?B?Q0hqdGRtZFliNlBMeGRMMGtIeEVObk01b0FzbnRiMWh5S2YxZFV1MmpuOUtD?=
 =?utf-8?B?Zk56Y21tNWFVek1ZdzRxZ1NMb1RuSXJMUFpqTzBLTTNram5UNUY3NkhJaUxS?=
 =?utf-8?B?dmtPTnpLRldoMUFYcVcyUlNhZzNiU1NqYXNnclRBSGpqS0NYdGZ2TC9oSXFs?=
 =?utf-8?B?elBLTFFpWUhxdkVGQ3V2Um9lTDlLSTVkRndhNjdPcDNUN1FEdHNjTG4zWVIw?=
 =?utf-8?B?dHVoVXQvdTViVVk1MXRMNUtSQ2d5bkxsbExxTWZKQkpYbENHaGhsdWdYRkpm?=
 =?utf-8?B?NjNOd2dRdUpUTFpreldOMCszeElad2JuOVhadTE4ZUZ4NlVtWmhickNNOFE2?=
 =?utf-8?B?Sm1wYmYvUEV0MWlFUGdSdjFIQVRSdWJwcGFxZ0VKVTFmTW52RDBlS1NhcWhk?=
 =?utf-8?B?N1I3UXk2RWdCMkdwRVpIaGJrQ085MGNUcHJjaGFjZ29hQ3pacEl0NzRsajU1?=
 =?utf-8?B?VzFtRXE1VlE3K2JCL1dhQ0tOMzNkYU1mTTM0SkphWlA2QXAzMDdUYTF5aFJq?=
 =?utf-8?B?bXRBbVVEY3o5MTFpNGhzSlJpdVJMV3RiRUllbjkzNklzLzZodTNxL1d4Ti9x?=
 =?utf-8?B?UmNqSFBPblZRNmlTTDNOTXNoRmVPaG5KbHZPVHlBRndub3l0bElURGdqdXhw?=
 =?utf-8?B?ZkxjL0xUdXZMdHk0aU0zSFB0eTBFSXdMOXVVdlRZZ0pjNFVxWVltWS9mRFht?=
 =?utf-8?B?aCtOeUcxMFRWbTh2YXB2STZnMVUyTUtEYjB6SUlwdEg4OVpQRnVMbjdEV2tX?=
 =?utf-8?B?SUVzbjBXVGwxcUZlU0xUQ1FscUtIY3ROR2hkMzkwazJnRTEwVEQya0VaZ21p?=
 =?utf-8?B?bGY3R0hGczJaR0VBMmltMEZUSCtXUTFBalJIVnY5dnJwdGhXV1VBcTF2azZ6?=
 =?utf-8?B?V0JuRGZSVUFNVHRrbWRCS25ZRXZpK3BESWFCdzBRdVNMazhYaWFVQVBaZVZw?=
 =?utf-8?B?VUdEdTJrbjNBQnYxZjZWcjN0SVpST3dKdnlHb2daV3pjL0xVdkk4K1RQZHZI?=
 =?utf-8?B?d21kTHQvZngvajhzVDhxQ2NiRDN3aG4xTGJDQThwWkhFcjhHOGplWHMvK2Nl?=
 =?utf-8?B?MXg1aDdTZDZCa2I5MytSbXVzY1kvdEVvS2NTcGx3cDNpODM5S2FJUmNjQUZn?=
 =?utf-8?B?WUJkTUtNaEhsNGNFT1lteE5LZzcxL01ySWZ4TW1Wb3VjZUFQYU9Yb2VhUHdY?=
 =?utf-8?Q?Tp0m2kZ2IVy3ssoIxrvMfJdZB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab7b0a86-041a-405c-5c64-08dbaeecafbf
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 15:19:38.9119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LYimtvQ/lSd88Qm3mndWWRWvWT6YHGaJSmsVztUkxHbwXFxGfjHzDFnymF0JRD+F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7973
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fenghua,

On 9/1/2023 6:21 PM, Fenghua Yu wrote:
> Hi, Babu,
>
> On 8/21/23 16:30, Babu Moger wrote:
>> The default resource group and its files are created during kernel
>> init time. Upcoming changes will make some resctrl files optional
>> based on a mount parameter. If optional files are to be added to the
>> default group based on the mount option, then each new file needs to
>> be created separately and call kernfs_activate() again.
>>
>> Create all files of the default resource group during resctrl
>> mount, destroyed during unmount, to avoid scattering resctrl
>> file addition across two separate code flows.
>>
>> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>>   arch/x86/kernel/cpu/resctrl/internal.h |  2 +
>>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 55 +++++++++++++++-----------
>>   2 files changed, 33 insertions(+), 24 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h 
>> b/arch/x86/kernel/cpu/resctrl/internal.h
>> index b09e7abd1299..44ad98f8c7af 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -611,5 +611,7 @@ void rdt_domain_reconfigure_cdp(struct 
>> rdt_resource *r);
>>   void __init thread_throttle_mode_init(void);
>>   void __init mbm_config_rftype_init(const char *config);
>>   void rdt_staged_configs_clear(void);
>> +int rdtgroup_setup_root(struct rdt_fs_context *ctx);
>> +void rdtgroup_destroy_root(void);
>
> These two functions are called only in rdtgroup.c. Why are they 
> exposed here?
Yes. Removed it now.
>
>>     #endif /* _ASM_X86_RESCTRL_INTERNAL_H */
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c 
>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 80a4f76bc34b..98f9f880c30b 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -2516,10 +2516,14 @@ static int rdt_get_tree(struct fs_context *fc)
>>           goto out;
>>       }
>>   -    ret = rdt_enable_ctx(ctx);
>> +    ret = rdtgroup_setup_root(ctx);
>>       if (ret)
>>           goto out;
>>   +    ret = rdt_enable_ctx(ctx);
>> +    if (ret)
>> +        goto out_root;
>> +
>>       ret = schemata_list_create();
>>       if (ret) {
>>           schemata_list_destroy();
>> @@ -2528,6 +2532,12 @@ static int rdt_get_tree(struct fs_context *fc)
>>         closid_init();
>>   +    ret = rdtgroup_add_files(rdtgroup_default.kn, RFTYPE_CTRL_BASE);
>> +    if (ret)
>> +        goto out_schemata_free;
>> +
>> +    kernfs_activate(rdtgroup_default.kn);
>> +
>>       ret = rdtgroup_create_info_dir(rdtgroup_default.kn);
>>       if (ret < 0)
>>           goto out_schemata_free;
>> @@ -2584,6 +2594,8 @@ static int rdt_get_tree(struct fs_context *fc)
>>       schemata_list_destroy();
>>   out_ctx:
>>       rdt_disable_ctx();
>> +out_root:
>> +    rdtgroup_destroy_root();
>>   out:
>>       rdt_last_cmd_clear();
>>       mutex_unlock(&rdtgroup_mutex);
>> @@ -2654,7 +2666,6 @@ static int rdt_init_fs_context(struct 
>> fs_context *fc)
>>       if (!ctx)
>>           return -ENOMEM;
>>   -    ctx->kfc.root = rdt_root;
>>       ctx->kfc.magic = RDTGROUP_SUPER_MAGIC;
>>       fc->fs_private = &ctx->kfc;
>>       fc->ops = &rdt_fs_context_ops;
>> @@ -2824,6 +2835,7 @@ static void rdt_kill_sb(struct super_block *sb)
>>       rdt_pseudo_lock_release();
>>       rdtgroup_default.mode = RDT_MODE_SHAREABLE;
>>       schemata_list_destroy();
>> +    rdtgroup_destroy_root();
>> static_branch_disable_cpuslocked(&rdt_alloc_enable_key);
>>       static_branch_disable_cpuslocked(&rdt_mon_enable_key);
>>       static_branch_disable_cpuslocked(&rdt_enable_key);
>> @@ -3705,10 +3717,8 @@ static struct kernfs_syscall_ops 
>> rdtgroup_kf_syscall_ops = {
>>       .show_options    = rdtgroup_show_options,
>>   };
>>   -static int __init rdtgroup_setup_root(void)
>> +int rdtgroup_setup_root(struct rdt_fs_context *ctx)
>
> Since rdtgroup_setup_root() is called only in this file, need to add 
> "static".

Yes. Taken care of it now.


>
>>   {
>> -    int ret;
>> -
>>       rdt_root = kernfs_create_root(&rdtgroup_kf_syscall_ops,
>>                         KERNFS_ROOT_CREATE_DEACTIVATED |
>>                         KERNFS_ROOT_EXTRA_OPEN_PERM_CHECK,
>> @@ -3716,6 +3726,20 @@ static int __init rdtgroup_setup_root(void)
>>       if (IS_ERR(rdt_root))
>>           return PTR_ERR(rdt_root);
>>   +    ctx->kfc.root = rdt_root;
>> +    rdtgroup_default.kn = kernfs_root_to_node(rdt_root);
>> +
>> +    return 0;
>> +}
>> +
>> +void rdtgroup_destroy_root(void)
>
> Ditto.

Thanks

Babu



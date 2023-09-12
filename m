Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8AC979D768
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 19:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236957AbjILRSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 13:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237034AbjILRS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 13:18:28 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819401705;
        Tue, 12 Sep 2023 10:18:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qg79ylRdmuHgd03hvztvr3jBo4wFMU5fD73hZlR5DUPU6Ae7ereaAbh36RlUpd6X3ov/W3qcwQQzSYij4Ye5RFBCtZp7QZMXW9Gt/AUuUxDwKoQQuD/42sc+yXwvAc2QHsZW5QcFGBHMRpauBLwS5LcZvNrrLJtWvVbHbvvohbtrp7eko5ko5zvaRhYqc/10ctmPcj8DxHAzQnmref/lJpyh6CxUhR95vvpCmWUeyYM+X8Cm56vAy6llXbs1QeJIQ/NfrF7QB+c2fvPWleoCGBRVQFEZr4hIeH8WzZKgk5D5OnUcfqUeZ+zA69ez164oZv4BauRHwpez1DlTMKArKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PFk0l2iupUpaXsP/H2zTKA2iSxWKJ3kHZEYZL42wDtk=;
 b=drAEyWZ6vPoRjc9QvLG+ZUJ8JRGNT/bohsoPjL8jDOzIJPN13fvnOrboPYQX2Zt30R3DYnVfHng78kmYdisp1gxMUCp1KJwumMd4ae+fGtzm01AjoONz38Eq07PRHsFoNadpTVYPMcsFOpSlhRE9YcJtXgA7zddGe257yV5wnGc5LomR2+uPJjtrgkqWOk6x8JT7gLGBE8lA+T3bE++n56uDJHboHDVQEDRrL2l3z/67kM2ObdITHg4oHIxNUPS4pL/I8zoNaKaTyISOgBrOORlobvRUOfsjP0V073gDIS+Epkd/ZmdYnaTC2FO4xwHSyMb95VcZjrtkREf8bH3MPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PFk0l2iupUpaXsP/H2zTKA2iSxWKJ3kHZEYZL42wDtk=;
 b=Huqvsr4WrjlLgy5ZyMer9kwyvdsstcMGxLMZrboCj39wyVMtqtnVu3bGz9PFVD7JVRu6fkcZeSmgbSmb3PUpkBIWPxkKTt2LZWVsV7L0BNCxe87JNrPwPEUrArty+hUc8lJtymRVR6TtUZ0DroepnVLObE4d1tp1JWWuoX+Nql8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SA3PR12MB7973.namprd12.prod.outlook.com (2603:10b6:806:305::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.34; Tue, 12 Sep
 2023 17:18:22 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e%5]) with mapi id 15.20.6768.036; Tue, 12 Sep 2023
 17:18:22 +0000
Message-ID: <fa4c4cad-cc21-fe55-fafa-4afe12bd195d@amd.com>
Date:   Tue, 12 Sep 2023 12:18:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v9 9/9] x86/resctrl: Display RMID of resource group
Content-Language: en-US
To:     Fenghua Yu <fenghua.yu@intel.com>, corbet@lwn.net,
        reinette.chatre@intel.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de
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
References: <20230907235128.19120-1-babu.moger@amd.com>
 <20230907235128.19120-10-babu.moger@amd.com>
 <f4458988-1b3c-92a6-d628-4154a15bbb74@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <f4458988-1b3c-92a6-d628-4154a15bbb74@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0114.namprd04.prod.outlook.com
 (2603:10b6:806:122::29) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SA3PR12MB7973:EE_
X-MS-Office365-Filtering-Correlation-Id: a200b885-1126-4917-5c40-08dbb3b443db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: obHnFTuIWBlo+cJwGlhIQxcFbltFxjFjCZmMhOW0YmU6WUzrDIu4YgNm8NImOvLK4z5jmheSESUX5/zSISVmsy7p4ogoPYst+vcq/M5C/do0UrO/aeUFkplktHuK7O07gsPdf+WYg2tyNoYOLottQw5SlQwx/kkl7eMwy2gMudOBmmP4P1DiuqzoGRcd3DHLHkmWsZ8lVbZGgHIy6ATWI43zbgisUFxxRJZbZhO9wyqyfQJzorogdnRyNgIxiYlD5aprgoECJth6bnGWMooxhgy1FNvk0Bu9d1V/vxragVk8Ib2zuqExKcqWky0SmBMwJbTGuLfEPXfnOSqBu4O07KCLtxUzO/1ka2M8mwAM8YvaJqe/HDMnELb2xuXjneL3xm3vf9Vz1qtx0eZcFnQNObW5/LDG/d1OVl27yFeI4buxmsFZahGB3oGi9Vl8ovirFaSVO3qpZw+4uhHF5DPunrtZF3mtS0CQQU+IX4kTjlPpT38uaj+OEb9BvfrCRB0UcbjHTml+AABndF+W2rpVPZyeJ3QbA8p2CDQjsxROtoZHKlvpdAdQGnjEWqZ0Sdm2pChxW2OSzwmvJjq250k8JVgBuHOnxOVxGSPH8YB40hHQ/+6Sc0kJQBlI9s1CSkKtPeKxrSzz+30mEu9V2wAh2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(39860400002)(366004)(396003)(186009)(1800799009)(451199024)(6486002)(53546011)(6506007)(6512007)(6666004)(83380400001)(86362001)(36756003)(38100700002)(31696002)(2616005)(316002)(26005)(3450700001)(66556008)(66476007)(7416002)(41300700001)(7406005)(66946007)(2906002)(8676002)(8936002)(31686004)(4326008)(5660300002)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZU9TSDNzNk5FMWdNaW40bCtUTTllOUpBU3ZGNGIzSXMyVk00RUc5RXVCYzNW?=
 =?utf-8?B?MFE4SVdVUVEyRHpvOE9xbEpkQjNhaFlEcHZuYzdpVWd1S1NwRjdHRUlHd0tm?=
 =?utf-8?B?dGJOYVlRVnhlM0R2bVFtZnl2MDZhTnBUZ0FPMm8zbk55WFpDU1BBdE1TTTcz?=
 =?utf-8?B?VnBsQUNkQ2U5VlNjTnYzUDBka0UxdFllM3h2d3pTUkdkTmVZVUZtbDM2ZVI0?=
 =?utf-8?B?RFNWdWJLQUsycStuRVZISFJsQVMrQUZjdGRGN21CZlg4ZS9RWFRwRVVQVFFY?=
 =?utf-8?B?b0xYRXNDZWw1eTI1MjExdllRNEpzOWs3NUZ4dFRlakZEZnVqMjBMdDl2TkdX?=
 =?utf-8?B?Qmd1SjlJZ1lscnpVWHhKc05lclhHNkRybjc5MmFYbDBuTlV4OVZ2S016NDUr?=
 =?utf-8?B?VlBaY3hwekdhZzBicnhxOEgrSkliOGdoRW9xODFMS3pUb1JGaE1Kcy9CRXRH?=
 =?utf-8?B?dkVIdHFPNGhURTh3WG50ODBDWFRrUzRSU3FXUDNXWmllTFY1Qnd4bGorTlJ2?=
 =?utf-8?B?TGFBc294c205Vm9jaU5jUERZTlVNLzRKa1ZYdDNEMjBjOTJjVGY5TGt4MkRQ?=
 =?utf-8?B?a0gveDBmQ3RFUy9MRWJ2a0V2M003V1ZtclJUR2FsUXJUMG15SkI0M1pCdi9K?=
 =?utf-8?B?ajFOSTVGMW54RVJlWXhjWTlVK21acFZWSU42TnR2QUJkakxUNHQ2R0lKRU1t?=
 =?utf-8?B?Zmd0UXI2RzdZOXlrbzM2SzJtSStUYmVkeldqTHM5c0dZK2owYnJaR2xSb3Rk?=
 =?utf-8?B?cGVJanBibFhWaHFCc3cvM1pscWQySWZUMkNtVkR5cFRHdTJ4ZWYzeTdkSHFj?=
 =?utf-8?B?c05vaDh2dTgrUndDVGs2TlRzZ21KMkgyemIzWnVQVldqK3NqU0VsY093bnU5?=
 =?utf-8?B?Q0hMSGtvYkJlZ213d3loaHIxQU9qWUJDM2pYTDVoQVNFMnlDTC9QY3NhQjl2?=
 =?utf-8?B?TG1URGd5Vkg1bDBIcWIvTElreVQySFh2cjZQZ0FJbzZ4YUZZMUVDREU0cG45?=
 =?utf-8?B?TSsrQk8vV0ttNWFWbEtYcithZEFhTmF3RUMydmg5azJrQmJTdHFISCtqd3c4?=
 =?utf-8?B?YUhDL3NiVTJsVzBYUFhzU3plNEFZU0RUcDBBVi94aEs3c3pZMnNSbm1BelpI?=
 =?utf-8?B?elpBemZQdjU0MVJiSnhiV1hKNGNZRWNaeFhEWVp4SE5Qa25zN1BIOFVuM09s?=
 =?utf-8?B?SjRSSXpuVVcyRm9LM1BML2oxcE90M1FWUVJFK0twZmtLcEM0a2NpbVFwdWhE?=
 =?utf-8?B?ZHB6RTZoWHVvb2pGUXNITW5hK2RpZmZTNlFBb0RDNFVIbHdOR0pBZ05VVTRm?=
 =?utf-8?B?dGJFNlFBMmZNSTVXUVdtUDI4TmpnZGhKZVgyOHV4QXhyVzRZMzFjajZFNFI1?=
 =?utf-8?B?ditoeWY3NC83c05QbExQMXU3S29uMFZTNWVwVEVKUjFoS0ticVh0eHE2cEpQ?=
 =?utf-8?B?dmJKTlFGa0oySmpGdDYzRGlOTFVZTG9BelU0L215OXJ1NTE5ckdZUzBuUk5s?=
 =?utf-8?B?Skc0SHVuUGpmdit6Y1k4WVpLZUU5Z1ZiUVpwaEFkQnhSYWhnd3hicFNuZ25Z?=
 =?utf-8?B?T0p4aHFqSnoyK3puMndEYnErbVBWVkZDZjVsNzRlZ1EvMGlsOXQ4YU45bCtz?=
 =?utf-8?B?UG5XcmEwUkN6VUFsdEtHWnlxSFFZVWdDVWFjVkk4NnZqc08yUXkwMXRsV0xn?=
 =?utf-8?B?RDNjdXZrTWdaVm9PWWpIQVFaWEQ1akV0Q0xCYkdJTEhJLzZZNUUvOGUvRlNN?=
 =?utf-8?B?dVY5MExtUmo5VVJDUmQwbUNIdVhuZUYzcmgyaGpkTWJjRjBrZjFSb2Q3UkI4?=
 =?utf-8?B?eGNZNEdVZTd4UEtWZWY3bENMUXdFTHpMRVkyd2R0cERMZUttY0tJYlNBSjFz?=
 =?utf-8?B?VGlRUitJRmlCeVhTSXhPcnRubDh3eStLZm45WURnWUw1WFY3KzZHMmFNMHVU?=
 =?utf-8?B?a0dYK1BPWWJySkQ1L3RyZUVULy9TZ1ZoRnA5SkdMZmlkS1JCa3V5YWJEQ3N4?=
 =?utf-8?B?Zld6UUJiUVVraHpJLzlhOUdkV2Z4RXZlQmJtK0tMcGtaM0Q3MWdBemNyd3li?=
 =?utf-8?B?MWhlVUx2dmtmb3MybGpybjRSNi83MG1NZ1o2Zmo0dkFiMkdFUWM4cnl3Y2tE?=
 =?utf-8?Q?hyjY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a200b885-1126-4917-5c40-08dbb3b443db
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 17:18:21.9048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8YPkHNb6HPFYf7yxyjC5TLU9cfZD0uz6i7giuVi/UiKc3BpAy7/nDIPoS172PAqq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7973
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fenghua,

On 9/11/23 13:14, Fenghua Yu wrote:
> Hi, Babu,
> 
> On 9/7/23 16:51, Babu Moger wrote:
>> In x86, hardware uses RMID to identify a a monitoring group. When a
> 
> s/a a/a/

Sure.
Thanks for the review. Reinette has already addressed other comments.
Thanks
Babu

> 
>> user creates a monitor group these details are not visible. These details
>> can help resctrl debugging.
>>
>> Add RMID(mon_hw_id) to the monitor groups display in resctrl interface.
>> Users can see these details when resctrl is mounted with "-o debug" option.
>>
>> Other architectures do not use "RMID". Use the name mon_hw_id to refer
>> to "RMID" in an effort to keep the naming generic.
>>
>> Add the flag RFTYPE_MON_BASE, which contains the files required only
>> for the MON group.
>>
>> For example:
>>   $cat /sys/fs/resctrl/mon_groups/mon_grp1/mon_hw_id
>>   3
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>>   Documentation/arch/x86/resctrl.rst     |  4 +++
>>   arch/x86/kernel/cpu/resctrl/internal.h |  6 ++++
>>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 38 +++++++++++++++++++++++---
>>   3 files changed, 44 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/arch/x86/resctrl.rst
>> b/Documentation/arch/x86/resctrl.rst
>> index 54691c8b832d..98b0eb509ed4 100644
>> --- a/Documentation/arch/x86/resctrl.rst
>> +++ b/Documentation/arch/x86/resctrl.rst
>> @@ -369,6 +369,10 @@ When monitoring is enabled all MON groups will also
>> contain:
>>       the sum for all tasks in the CTRL_MON group and all tasks in
>>       MON groups. Please see example section for more details on usage.
>>   +"mon_hw_id":
>> +    Available only with debug option. The identifier used by hardware
>> +    for the monitor group. On x86 this is the RMID.
>> +
>>   Resource allocation rules
>>   -------------------------
>>   diff --git a/arch/x86/kernel/cpu/resctrl/internal.h
>> b/arch/x86/kernel/cpu/resctrl/internal.h
>> index ccdbed615d41..b4910892b0a6 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -296,6 +296,11 @@ struct rdtgroup {
>>    *    --> RFTYPE_BASE (Files common for both MON and CTRL groups)
>>    *        Files: cpus, cpus_list, tasks
>>    *
>> + *        --> RFTYPE_MON (Files only for MON group)
>> + *
>> + *            --> RFTYPE_DEBUG (Files to help resctrl debugging)
>> + *                File: mon_hw_id
>> + *
>>    *        --> RFTYPE_CTRL (Files only for CTRL group)
>>    *            Files: mode, schemata, size
>>    *
>> @@ -315,6 +320,7 @@ struct rdtgroup {
>>   #define RFTYPE_MON_INFO            (RFTYPE_INFO | RFTYPE_MON)
>>   #define RFTYPE_TOP_INFO            (RFTYPE_INFO | RFTYPE_TOP)
>>   #define RFTYPE_CTRL_BASE        (RFTYPE_BASE | RFTYPE_CTRL)
>> +#define RFTYPE_MON_BASE            (RFTYPE_BASE | RFTYPE_MON)
>>     /* List of all resource groups */
>>   extern struct list_head rdt_all_groups;
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 8be0fb323ad3..fc830ffce82a 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -795,6 +795,22 @@ static int rdtgroup_closid_show(struct
>> kernfs_open_file *of,
>>       return ret;
>>   }
>>   +static int rdtgroup_rmid_show(struct kernfs_open_file *of,
>> +                  struct seq_file *s, void *v)
>> +{
>> +    struct rdtgroup *rdtgrp;
>> +    int ret = 0;
>> +
>> +    rdtgrp = rdtgroup_kn_lock_live(of->kn);
>> +    if (rdtgrp)
>> +        seq_printf(s, "%u\n", rdtgrp->mon.rmid);
>> +    else
>> +        ret = -ENOENT;
>> +    rdtgroup_kn_unlock(of->kn);
>> +
>> +    return ret;
>> +}
>> +
>>   #ifdef CONFIG_PROC_CPU_RESCTRL
>>     /*
>> @@ -1856,6 +1872,13 @@ static struct rftype res_common_files[] = {
>>           .seq_show    = rdtgroup_tasks_show,
>>           .fflags        = RFTYPE_BASE,
>>       },
>> +    {
>> +        .name        = "mon_hw_id",
>> +        .mode        = 0444,
>> +        .kf_ops        = &rdtgroup_kf_single_ops,
>> +        .seq_show    = rdtgroup_rmid_show,
> 
> Similar to showing ctrl_hw_id, is it better to rename "rdtgroup_rmid_show"
> as "rdtgroup_mon_hw_id_show" for arch neutral naming?
> 
>> +        .fflags        = RFTYPE_MON_BASE | RFTYPE_DEBUG,
>> +    },
>>       {
>>           .name        = "schemata",
>>           .mode        = 0644,
>> @@ -2535,6 +2558,7 @@ static void schemata_list_destroy(void)
>>   static int rdt_get_tree(struct fs_context *fc)
>>   {
>>       struct rdt_fs_context *ctx = rdt_fc2context(fc);
>> +    unsigned long flags = RFTYPE_CTRL_BASE;
>>       struct rdt_domain *dom;
>>       struct rdt_resource *r;
>>       int ret;
>> @@ -2565,7 +2589,10 @@ static int rdt_get_tree(struct fs_context *fc)
>>         closid_init();
>>   -    ret = rdtgroup_add_files(rdtgroup_default.kn, RFTYPE_CTRL_BASE);
>> +    if (rdt_mon_capable)
>> +        flags |= RFTYPE_MON;
>> +
>> +    ret = rdtgroup_add_files(rdtgroup_default.kn, flags);
>>       if (ret)
>>           goto out_schemata_free;
>>   @@ -3255,8 +3282,8 @@ static int mkdir_rdt_prepare(struct kernfs_node
>> *parent_kn,
>>                    enum rdt_group_type rtype, struct rdtgroup **r)
>>   {
>>       struct rdtgroup *prdtgrp, *rdtgrp;
>> +    unsigned long files = 0;
>>       struct kernfs_node *kn;
>> -    uint files = 0;
>>       int ret;
>>         prdtgrp = rdtgroup_kn_lock_live(parent_kn);
>> @@ -3308,10 +3335,13 @@ static int mkdir_rdt_prepare(struct kernfs_node
>> *parent_kn,
>>           goto out_destroy;
>>       }
>>   -    if (rtype == RDTCTRL_GROUP)
>> +    if (rtype == RDTCTRL_GROUP) {
>>           files = RFTYPE_BASE | RFTYPE_CTRL;
>> -    else
>> +        if (rdt_mon_capable)
>> +            files |= RFTYPE_MON;
>> +    } else {
>>           files = RFTYPE_BASE | RFTYPE_MON;
>> +    }
>>         ret = rdtgroup_add_files(kn, files);
>>       if (ret) {
> 
> Thanks.
> 
> -Fenghua

-- 
Thanks
Babu Moger

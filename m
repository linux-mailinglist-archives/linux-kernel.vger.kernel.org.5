Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9293B78E328
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 01:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbjH3XTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 19:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344402AbjH3XTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 19:19:47 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290B1BE;
        Wed, 30 Aug 2023 16:19:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mHK3veFmVSCdH9+2cLHcFMs9xyruEXMcMDQod7jb6bgRVjgg2GLVd9lUxMxNfLwhl7wKCqpP9v/gD1TvpBMT07VAPianK7QHE80rQ4NmrNSKVAPEmoeMgnDsMaSo1FICQORj23sYZhjovGkY8PBgIz4IOjASWn6PCqYQfJuKnpq8gYdjqex6bemxDaX8cNv5vmESTRfuElxAsRTEpwbjMhbNA4o5lobfAoYMmmV6mz9dLJdi14H30ME8VOuPkmNZO0DeXLlxE4g988PbIygSLaUSvNw3v6TFszC9Tv4snfKDfS2E4cT2+u8rrNGB2tfvIDM1bNCHXGiwE5sm+OcQDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gscxf5MK7py9oPsIa7Ijf6Al9z52Dqxbe33HmYu6yWI=;
 b=akD+wQoOCJxhY/hppy1jgBbUsTBBWz1WLV86uuOo7T3PQdi5EejoN6N85kuPU8AuVjmTuj33be9cl3Vb8lJ+AD+Vvu+wZVvQGH0QWC7eUQbo9eL/iYhBkjohJDMHLt1PUw7siqW/k9NXliYZUH4U+wYWFBYmzhiGHOjtrnxP51eabL8JldY5lQa0SheJrVGDHD3L9rio9JLZc6BeZ7WZy3wqtmdrRfUCK0Dm41Nha7D7pT5pMWWTrTNjsgeCQHa4An6G8T1cn/FRyqone/YakYCU5eYqjuvB1svNaut+1WfA5DLDMO3sLVJ46eNa1bxi1V7iLMUVoWAhEwYByHs1zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gscxf5MK7py9oPsIa7Ijf6Al9z52Dqxbe33HmYu6yWI=;
 b=1X4XF95beNdGPm9jppValzL8EsFI6zDy8kT2nt9Bfhvz/oUND3HCTUhbOeCL72Rx+Ovpxm+Kem5o/+afl0Ue7oOy54qefY1kpDDwWBZ7abnwZKcZEMNEMQ9l7mLCH7s0VIpUnT8XDhUisiOUBP0DvidiXM9Oo00ZDkXTZBPIVts=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by BY5PR12MB4051.namprd12.prod.outlook.com (2603:10b6:a03:20c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Wed, 30 Aug
 2023 23:19:05 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::8ee:edb7:48bd:667a]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::8ee:edb7:48bd:667a%3]) with mapi id 15.20.6745.020; Wed, 30 Aug 2023
 23:19:05 +0000
Message-ID: <da47698a-aa9e-3760-1321-5ec3ea1a14e6@amd.com>
Date:   Wed, 30 Aug 2023 18:19:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v8 8/8] x86/resctrl: Display hardware ids of resource
 groups
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
 <20230821233048.434531-9-babu.moger@amd.com>
 <4019a73a-8478-f18b-7f34-b8d838dfc7fe@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <4019a73a-8478-f18b-7f34-b8d838dfc7fe@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR07CA0066.namprd07.prod.outlook.com
 (2603:10b6:4:ad::31) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|BY5PR12MB4051:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a089af3-136c-4782-9046-08dba9af80df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0/Xa0/B6dPw3K37WFJngzcWRHx0RHw1nkKx7DwqnLQ9kc4CccGnE4kDMe3JbFqLVcH/+GfYhAauTuuPA0l5KpSp/zf/riGQ4IuC7nN7vbIGj7PxbBsb8cbBLkcY0gCPvw3MsomZVqOscQjUShCbYFKkfpCDVPkUEf8dtbC1DajXiRlHjUuUjl+qABnVH9JgwG499hLICscUo3fPoaS99OE/MPKpw4AtYQQnndBNQqM8Vo8k8z24ZnaFcgjfqJiBl9UxpRrXsPKF4s50oQt/DKBTIAuT/2oH6U4QGf8FRClgQQscQr5tayH7H/hxidgKMnH86B8qJf5JfOK6ANCeO1d8fKDs9LM+gRLXgNrCMGl5KBbSUyMW4xz4L4Ts0HGSHgSoeaLVH9iEDM21X1aH68ymP9qIFyXm8c73f4NK97GxJa5ZZm577Cu0XJWlPh68Wi5omcHExVey7ik5ZBvpMNNxfdDrsaBaMiL9F8/figt2GCEgjQsN/7M4BHirzWCbPEDt/VsqwEVymZ/5DWDqaEsLHsFBHYquHwvq11/LusI1VVG+PX9gW8RKx7UtGZaKivBSzBnfG+guTwFysRbGn0EIT1YtMkPTXsct2UZdqEX2ZvxgYoONzIg1x1TSzKqLuA29gr3GQHdQuPxJH956bQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(346002)(39860400002)(376002)(451199024)(186009)(1800799009)(31686004)(6666004)(6512007)(6486002)(4326008)(6506007)(31696002)(86362001)(36756003)(38100700002)(26005)(53546011)(2906002)(478600001)(83380400001)(66556008)(8936002)(8676002)(7406005)(5660300002)(316002)(66476007)(66946007)(3450700001)(2616005)(7416002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGkyMWZNVTdNd1VNR3M4bXRvc1J3QzlUejVRbTBMZnZqM1RZYm9GNEtiVWFK?=
 =?utf-8?B?dXZvUVIraW5NMTN3dWZ4YTJDYUxac2RTeWlYSGhzOE5JR25tNHRhWitGWTNV?=
 =?utf-8?B?YjlQRXg2aFpMUzlESWZrZytIRXNGRzlYZHJvL05tRzZuUEN0eDViSUp6UUZp?=
 =?utf-8?B?NHlaYmxqTnVzVEhreEFOVVZtVU4rQ1BsUWtDcEp2eE5hNzA1d1VJcUtvSnVk?=
 =?utf-8?B?ZEdlTzVIZjIwTzZkL2F1ODNydFFmZkZBM1V4ZEwzejJXZ0JxL3Q0UnA2YWtP?=
 =?utf-8?B?ZnlFUGNHR29XV2p5cFNNRko5ZkI3dGNSVTdRWXJ0eTF5VWE3OWN0dG9hS0Nj?=
 =?utf-8?B?aXQxT3lVTUwwSGZXS2xDQnFUZlB4c0pEQkRUYitjTm10TGl1S3lTK3loeE5M?=
 =?utf-8?B?eWcxK2R0WlFVU0VqREszc1RqNm5MaEFEZGpROXRlRkhEWXZzZXV0YytqQ0VR?=
 =?utf-8?B?NjVGTExtWGxtNFNicGNNM1pjcStRbzNTVmdjZG90bmF0U0lOdWtEU213VGRz?=
 =?utf-8?B?SFNkeHF0ZVA4WWZod2dmQml2M2xiMy8zNi9SMHNJekxrdkMrOGUvVmRadUQz?=
 =?utf-8?B?cjFQMmJ1eW1nak41UzVHRXZoQ1ZMRUlDaHp1ZUxDQXZvdTFQU3Z0WWllMjlk?=
 =?utf-8?B?OCt4czVEMlFVWW9nMDRqZHJxeS91ZGFDbHFJRDVLQ3hKN3NwUE9NNWhkL3Br?=
 =?utf-8?B?SkZVUkNHSEpBbUV2cU1LdCs4MzFhT2NyeEM4OEljMUNZNzMxNnRBRDNJZVJT?=
 =?utf-8?B?R28yUGRjVVNyUXZkUnlvZ3J4cThjaUl4aFUvdEd2SkcrdGFhODM4WDJQcVFt?=
 =?utf-8?B?MHFvdklkSjZEUm1IckFJS1p5SU9oYk1oeG11bGVTWGNyelBRK1FqeEtGZlV1?=
 =?utf-8?B?aThOUDRpbGkrVXVxSmxMNmdqWURDY1VRc3FiNXFOb1ZmSktSYWl4OENkR0Jy?=
 =?utf-8?B?bVBEenEwRm9qRzNhVlovU0JtY3NZcS92aEQ1ckZBcXliMENJZnRMbFk3RmMx?=
 =?utf-8?B?dnFsZmloSVdLazVjRUNURVJYc3JxU3ZnR2hWTHhzTGdLRzNETDZOaTN6NlBV?=
 =?utf-8?B?ZnUzT1BOQktPK0cvc1B2NnZyekhOUXQ0NmI1NjRHZGFhRnk5eTgySWdCczJC?=
 =?utf-8?B?QU9QN2ZuYW1YV0M2eW40L2gxTFFJY25kMUJGZDlqdzRuSmtyRmFNclZLUitj?=
 =?utf-8?B?ZUpTZ0Zoa2t3dEUwODl4bHlBbjAvLzdaVlRVM3J0bWR6MCtxcG9oeUozalFH?=
 =?utf-8?B?cHRTQzd3aVZxU1h6WmQ4ZFdHT3g5amxhV3d3dXcxd1ZEVk5ndmo2eGhGcWNY?=
 =?utf-8?B?ejdxRFZtcmlCMVJNdUtKWThaWHMydEZBeXg2aWF4WllZZDJhK0EyUWYwY3F4?=
 =?utf-8?B?ZnlOTnE5T1BadjFXS3ZTZmlCNTIyN3NhTzlSeTlCOGZEMHJHZkF4UWhCYU1X?=
 =?utf-8?B?TS9lVXp1OTFvN0IwZUt3azQyckxzamk3bnF4TzkwK1pxUnp4TWtwNFpqd1Nq?=
 =?utf-8?B?VnQ4S2pEUWI0QysvNU1vbnJjWGZBbStZMGFtNXliUm11UnBKYUJkWVpMUHJa?=
 =?utf-8?B?VFdTbGtreVVva25CNnhHVEloVlkwa3BEYU50VU95ejdqNllDVlZuQ0JrN1JP?=
 =?utf-8?B?SFVIVkZqR2xYUWlDODNuRFZBV2ZzaDVTSVdyOHFYMUVLTjNCdVhwbFRUelJT?=
 =?utf-8?B?dVFTSGQvTVc0eDlMSTRXZ29FZGw0OHI2MmZmQWp3eGhNdDJScDJsUlV0SEpy?=
 =?utf-8?B?YWVjdFBhVkVHNlo4bHFGNTdpcnNiKzJlMUlST1AzK1NnZS9zL0xYMjh1SFEx?=
 =?utf-8?B?MnU0WEdFYmlZM2xPUHh2TDVxbWRBYXIzQjJEMzR4VlJZeWdsbGFKbSthNlR1?=
 =?utf-8?B?WkdqOFYrZ2dtL3g4Ry91SjhVT2dKb0t4N0dpdHJuUG5KVTcxUkxNeGlNeWI1?=
 =?utf-8?B?SnFYNzNoQldWNVk1WUkvZlFIN0UzYW9kVTYvQzlCRmdXb2ZHdkdHMUU5NXla?=
 =?utf-8?B?M0IzR1VzdVZFODAwL3FwZGxuWHhlS3pKUlZHVElTNXdxa0ZqbGpYSmhjT3pq?=
 =?utf-8?B?M0lCM1d2eWpKaytIOXc5aWhxclZPUUZXTmtIYmx2bHEyVDZuUjY3bVVFZWxW?=
 =?utf-8?Q?vARA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a089af3-136c-4782-9046-08dba9af80df
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 23:19:05.0744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DjvTM4nWbEj8Lngu+kM05TxPCMTEToPsTSQ7PKZ7hE/b6JCWk2zI6cuFTVEZljvx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4051
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

On 8/29/23 15:14, Reinette Chatre wrote:
> Hi Babu,
> 
> On 8/21/2023 4:30 PM, Babu Moger wrote:
> 
> ...
> 
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>> index 2fae6d9e24d3..3fa32c1c2677 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -296,9 +296,15 @@ struct rdtgroup {
>>   *	--> RFTYPE_BASE (Files common for both MON and CTRL groups)
>>   *	    Files: cpus, cpus_list, tasks
>>   *
>> + *		--> RFTYPE_DEBUG (Files to help resctrl debugging)
>> + *		    File: mon_hw_id
>> + *
> 
> This does not look right. I think mon_hw_id should have RFTYPE_MON
> (more below).

I am not sure about this (more below).

> 
>>   *		--> RFTYPE_CTRL (Files only for CTRL group)
>>   *		    Files: mode, schemata, size
>>   *
>> + *			--> RFTYPE_DEBUG (Files to help resctrl debugging)
>> + *			    File: ctrl_hw_id
>> + *
>>   */
>>  #define RFTYPE_INFO			BIT(0)
>>  #define RFTYPE_BASE			BIT(1)
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 94bd69f9964c..e0c2479acf49 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -776,6 +776,38 @@ static int rdtgroup_tasks_show(struct kernfs_open_file *of,
>>  	return ret;
>>  }
>>  
>> +static int rdtgroup_closid_show(struct kernfs_open_file *of,
>> +				struct seq_file *s, void *v)
>> +{
>> +	struct rdtgroup *rdtgrp;
>> +	int ret = 0;
>> +
>> +	rdtgrp = rdtgroup_kn_lock_live(of->kn);
>> +	if (rdtgrp)
>> +		seq_printf(s, "%u\n", rdtgrp->closid);
>> +	else
>> +		ret = -ENOENT;
>> +	rdtgroup_kn_unlock(of->kn);
>> +
>> +	return ret;
>> +}
>> +
>> +static int rdtgroup_rmid_show(struct kernfs_open_file *of,
>> +			      struct seq_file *s, void *v)
>> +{
>> +	struct rdtgroup *rdtgrp;
>> +	int ret = 0;
>> +
>> +	rdtgrp = rdtgroup_kn_lock_live(of->kn);
>> +	if (rdtgrp)
>> +		seq_printf(s, "%u\n", rdtgrp->mon.rmid);
>> +	else
>> +		ret = -ENOENT;
>> +	rdtgroup_kn_unlock(of->kn);
>> +
>> +	return ret;
>> +}
>> +
>>  #ifdef CONFIG_PROC_CPU_RESCTRL
>>  
>>  /*
>> @@ -1837,6 +1869,13 @@ static struct rftype res_common_files[] = {
>>  		.seq_show	= rdtgroup_tasks_show,
>>  		.fflags		= RFTYPE_BASE,
>>  	},
>> +	{
>> +		.name		= "mon_hw_id",
>> +		.mode		= 0444,
>> +		.kf_ops		= &rdtgroup_kf_single_ops,
>> +		.seq_show	= rdtgroup_rmid_show,
>> +		.fflags		= RFTYPE_BASE | RFTYPE_DEBUG,
> 
> I missed this earlier but I think this also needs a RFTYPE_MON.
> Perhaps patch 3 can introduce a new RFTYPE_MON_BASE to not
> have the flags of the two new files look too different?

We have two types of files in base directory structure.

 if (rtype == RDTCTRL_GROUP)
                files = RFTYPE_BASE | RFTYPE_CTRL;
        else
                files = RFTYPE_BASE | RFTYPE_MON;

1. RFTYPE_BASE | RFTYPE_CTRL;
   Files for the control group only.

2. RFTYPE_BASE | RFTYPE_MON;
   Files for both control and mon groups. However, RFTYPE_MON is not used
for any files. It is only RFTYPE_BASE.

Because of the check in rdtgroup_add_files it all works fine.
For the control group it creates files with RFTYPE_BASE | RFTYPE_CTRL and
RFTYPE_BASE.

For the mon group it creates files with RFTYPE_BASE only.

Adding FTYPE_MON_BASE will be a problem.

-- 
Thanks
Babu Moger

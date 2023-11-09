Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524D77E7301
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 21:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345201AbjKIUkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 15:40:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345197AbjKIUj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 15:39:59 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2086.outbound.protection.outlook.com [40.107.96.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997D7E5
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 12:39:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CJCcbNuPZfgd1Uf94Uj7/DpZzUPmrbPwXA4xnIqHDrjGY27x9UXkzEcq96lmvygRbRo6hm5XpPCZYp+RpV/6daQJAYyMpvfrq3lF3QEGNZGnGC9uyN0NdhgJDkq6IihpnjS6zRO5HWU2ymuhXt0M2bcGa5aPoXillAKwDTgVOKbAGHDc+CrH3Vea9wxATpvP7xLM/SOnOD9GXCy+6vI0aLGWnpypr8dm8W7QAsPzX3FJvrLoN1PoKtm5uL4FytcX9hz9kU52G+LPxLcKRKluAZsd/1CJ7255K1Wq8LlKFBFRuqcWvCiPTtN3TqBR+KpO9pIWGcUPfQGVqqisPYrjjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cB0dbHr10iMabZZzJ1de+iC1CWE+BmlzI2KXvmYR6No=;
 b=BK6zYe1pdVRIWf0loD0WTMK14C/z9ZUtqkMZC5dlE7CqpPMd3ix7WYad9jXuE0oLdhJhQWB6mCuL9RkkaTk2Mt8sYDRNouKz/JNqy7D8RHJd3djdAEZI0PLiLVPqxcbdCLKZFK1BRixbmlRtnWVm7xi7Mq6j//x1d8N/T/FdeZrKpoiw4nCAQd/LH0jtXcZy1jnu0WMd22hJ+G4SKlw3b2yEY2t3svxpkYGOCxl3n3KcJB1zulLrzLwFy6dfD3hoVpl8ZQe86j/qPP8Zq3b2b6KP/bVXZCpf+OTijSoQEshv8dLqs4dbTbqk3bE9vlVCyzbm/xsd2S8IxuzXIWYJkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cB0dbHr10iMabZZzJ1de+iC1CWE+BmlzI2KXvmYR6No=;
 b=I0E4znZH0bLdr9rAlRQGLXTTCMXqNODK0TL6LVOY8rMqm+c1N+p4Lg4SiL5N8LtYyM0R0qNzdv1THtv5MNOrmpsP2Fpblm42ljlkTdUbwJbUN9MgN4SGrtsi/3RgtgMOAoktC3a+gqazJ8biqH1fa6ycoJvil3VB5YZBQq9NfB4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SA1PR12MB6917.namprd12.prod.outlook.com (2603:10b6:806:24c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Thu, 9 Nov
 2023 20:39:54 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b%4]) with mapi id 15.20.6977.019; Thu, 9 Nov 2023
 20:39:54 +0000
Message-ID: <ba0c782c-3269-4f06-a097-f9d29e4d9a9d@amd.com>
Date:   Thu, 9 Nov 2023 14:39:52 -0600
User-Agent: Mozilla Thunderbird
From:   "Moger, Babu" <babu.moger@amd.com>
Subject: Re: [PATCH v7 11/24] x86/resctrl: Move CLOSID/RMID matching and
 setting to use helpers
Reply-To: babu.moger@amd.com
To:     James Morse <james.morse@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        carl@os.amperecomputing.com, lcherian@marvell.com,
        bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
        baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
        dfustini@baylibre.com, amitsinght@marvell.com
References: <20231025180345.28061-1-james.morse@arm.com>
 <20231025180345.28061-12-james.morse@arm.com>
Content-Language: en-US
In-Reply-To: <20231025180345.28061-12-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR01CA0029.prod.exchangelabs.com (2603:10b6:805:b6::42)
 To MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SA1PR12MB6917:EE_
X-MS-Office365-Filtering-Correlation-Id: fd970265-034e-4f4d-f2a7-08dbe1640771
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wDqoR2xKbiF82dOIIhlEj5iYLjuWpmndcbQL68/uYSrzrkexBtFPeQEGmMqmY0Jzg1TxGER+4OQi80Oqez0ZtnYFsbd+sn+XyKGB2SaDIh03z6R0cB1FgHuMAhqFXRLH4+OD31C1BCN+CQcAyOF0NDfR3j7PfPTwc8E4+1Aod4BY5e7stl8qD5TDWH4J14s+NW7jg+JW+ePKJBTlnSRD83aENU5u3J6xpvHOakwKnV5uxxsDcSr8JJvq0br7XSB304aCfhfHn9A4Y2FTSKQDWZhY13TX25uDThmIXYjr508fs2q8/ewNQ0Kf2NBfgHi3VKKbWo+w5v5qZ2RgEwDvKdAXE2VWk3s6wZcSFGxjyonaQbkOKWoxFunUChZAIdkaZ+TzPHwn7S8QWBNmrK/Y3fhbVkmFxX1gVgn0oM8ivKeraqCr1qkPzvEHrohH43YIcyjuNymzOu2goEzXKsTKYf2Swv0CXe7mjP02p7RVjbM7/czpNIVa/oOYqbbFTK04RNHYr1YqrI54Bstx8SaF1G1niRDr02SvcXA7RtVoscwo38GJb7Ffeka8yis+t987Ii16HzUv44uWWiWbE7zXobonh5xvs0Hu7KoZGDH06sqi7PBf9OI3IEn4U4abTjdWYELVMS5QhDaGIeUBqbJ9gw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(136003)(39860400002)(366004)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(31686004)(2616005)(53546011)(6512007)(66556008)(478600001)(6486002)(6506007)(2906002)(54906003)(38100700002)(316002)(36756003)(5660300002)(31696002)(86362001)(41300700001)(3450700001)(66946007)(26005)(8676002)(7416002)(83380400001)(66476007)(4326008)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWlJZFE1Q0VyU0NOS3dLL1JmRW55em9kbjVVOUZUY25TeWxMVEMxWWZSUEpn?=
 =?utf-8?B?dmNQUlVhdVQ3NTN4WCtTU1dHWlRoQ0xOM2Q0M0VFc3BRRGlibjlxWWRHYzFQ?=
 =?utf-8?B?ejhwN1dzeDUzcGxhSkdpN2xaYTBHcnRMN0ZTbkdocDg0Z2xLbmhFWTBmSDda?=
 =?utf-8?B?dGFzaXdqcDRHNGRSZWZrSGM1Y1dQQmUwVDJLdzBkOUs5bHhYVTNlZmQ5QTc3?=
 =?utf-8?B?bUZRSVdMSE1Gbml0a3c4aEs5VEMrSndyczhPelpFNVVNU2g4YXJsOTVpdzhw?=
 =?utf-8?B?S3VFaWV4MUFVUlVjL1AvY0tOMjlIMHhuM2FvdldNOHpTYUtWQWZqL2M3VTRr?=
 =?utf-8?B?Q1ltNjZrYkE5QjZxcnpqS2FzRmY5V1lWcmQrYWJaRDdkYlpPNEJ2ODVvVlNY?=
 =?utf-8?B?SldxaGtnTDgrKzVHZzQzT0UzUEJYSGdrZVhKcWdOdTdOUTc1a1BwaldscDQv?=
 =?utf-8?B?Sk8zOHdva1VyZkVrSG5xenlZYWpvR0FmbjNIajhmRGpwZ2RqaG0xQWNLeENI?=
 =?utf-8?B?RVRHa1BXTXJiVGVLbGpyQzBKYVBlSUZCb2wwNTUxdlo3T1ZiQTlIdHZnbHJl?=
 =?utf-8?B?OWxVL2FtSkYyNzdzeEFac25ha2JyZXZnMkJQemdGbXR5SXgzZTJ1VzJBS29J?=
 =?utf-8?B?cDh2QVZEaU5jVmdVenEyd21KdTIxcXQzb0RlSkFOZ21XdVZTckltanFObkdP?=
 =?utf-8?B?dFFOWFZock1TME1VblFUZjFnOGZFaU9LNVBmOVpnTk9XK000QTJMb3pqKzI3?=
 =?utf-8?B?aXpXTGdTS0tFdnVXanJzVEMva0Q2MUZ4aFhIU2FIT0xiVnVpdkluSEE0OHdD?=
 =?utf-8?B?cG5nd2VJTi8wM1AzZmhmN1RhbTlTNzhIZGp1UmJ3d3lVK2UyWUs1ZjFZUHhn?=
 =?utf-8?B?ZlBwRGt1SUptM0l2QjVsemUyUWpVa1lwRnk3YjlRdFI0TWxHTjhzYXk2WW5E?=
 =?utf-8?B?L2NsTHk3RTIrZmdHRmhlRXFCV2lvU0pxelNpbS91dlpkamI2U2o0Y0pEZThB?=
 =?utf-8?B?S2FhVEljMDAzTUJUY3JZUDd3TXpmQUlqc0trakNvazQrbHhmbi9jOUI0TTJI?=
 =?utf-8?B?QWhOWlNScXBxOE4zS1dOZVNaRnRiWVJtRzNVQll3TEUxcGo1UnNQZkVrQnd1?=
 =?utf-8?B?ZVA3VVEzblhYNUtWRjR5cUdaRU9vT3cwK3llMGFEOGp1RnQ3VGFoMHdpVHRC?=
 =?utf-8?B?T1Ard05qaWZyQiticVNic3cvQ2w4RzRYZ3IzVmN5TVFXazFpY05HNHUrMnFG?=
 =?utf-8?B?ZUN5VjNRS0gxeFJYM0FxSHRJUlhPUnJWYXBzcDh0L0NEUVhIejJFSGQ3Q3Q5?=
 =?utf-8?B?R0ZuTzhpdFJzdTNlbWJpWDRIMW00aWRPcE5GUUxjUGhEbERhbUF2eFVuKzZx?=
 =?utf-8?B?RnZZRDk3MkY4OFgzTnpMS0dTU3NWR1FoV0dia3Nlc1NrcERJU2xzRTgxUDZu?=
 =?utf-8?B?OU9sUStjOFp2eFBqV0J3Y1BVeldsUlk1Wm1VY0pTRmhVcXZTSTVENmRnR2RW?=
 =?utf-8?B?STZlblAvSXlVRTZRVU4za1VVdlViRXN5U1JUZFFHRG8vMFg5Z1FwRm5CNG9k?=
 =?utf-8?B?REYydzEyblRCODRieXQvSDFnTW12TmptZ2l1TU9Yb2FxN0xObExTK1RRaGhh?=
 =?utf-8?B?YjVGSk8weXBFV3Y5Y29XUHY5Z0dZYUJlbGNZditrbmYwK2NMWTNBcThrQjha?=
 =?utf-8?B?cXF4Skk5MzViVzFJRnZ1a2RMTnMyZkp0WnZnaWpwVTVDL3VtMUFFUnk3Tk9T?=
 =?utf-8?B?TjRNQXcvREVyMmdLUzU4MVd2Rng1ZE96eGh3WkFwb2U1YVk3T3hnVE44Nm41?=
 =?utf-8?B?TUpiTUJYTzVTT0NJTTVMWXNNNHA4WG0vVldUWTVkdUtDYkkrR3M3VmJWTi82?=
 =?utf-8?B?ejAxQ0dsR1RSYklRSVlaUDlyNWxlRXM5Q1BhQ1ZQbjMrdVJqUStUWVZJS1kr?=
 =?utf-8?B?SVVFQ3Z1QWoxY2RCYXlZMkx4dnBiNjE4M3ErS3RMKzJpbGMzT29qU2o1YjRk?=
 =?utf-8?B?STc4am5JY1hWMXMvdklCVEJFRm83Z1BYYUlWQnVHNGFjOFBlcVpVczN4YUc2?=
 =?utf-8?B?KzNnbWhMRUdYS0NjTmZJZFRRZ3ZLbFBsc0VRbnVSUFpUc3RvU2ZtVlpab3h5?=
 =?utf-8?Q?G9FU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd970265-034e-4f4d-f2a7-08dbe1640771
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 20:39:54.2081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eEtFXmJi7CkP2Jz5JCef+JN7ao+l8V40DSUVZ5XJmjYzZ1ZILimu73dXz50zdxcu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6917
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/25/23 13:03, James Morse wrote:
> When switching tasks, the CLOSID and RMID that the new task should
> use are stored in struct task_struct. For x86 the CLOSID known by resctrl,
> the value in task_struct, and the value written to the CPU register are
> all the same thing.
> 
> MPAM's CPU interface has two different PARTID's one for data accesses
> the other for instruction fetch. Storing resctrl's CLOSID value in
> struct task_struct implies the arch code knows whether resctrl is using
> CDP.
> 
> Move the matching and setting of the struct task_struct properties
> to use helpers. This allows arm64 to store the hardware format of
> the register, instead of having to convert it each time.
> 
> __rdtgroup_move_task()s use of READ_ONCE()/WRITE_ONCE() ensures torn
> values aren't seen as another CPU may schedule the task being moved
> while the value is being changed. MPAM has an additional corner-case
> here as the PMG bits extend the PARTID space. If the scheduler sees a
> new-CLOSID but old-RMID, the task will dirty an RMID that the limbo code
> is not watching causing an inaccurate count. x86's RMID are independent
> values, so the limbo code will still be watching the old-RMID in this
> circumstance.
> To avoid this, arm64 needs both the CLOSID/RMID WRITE_ONCE()d together.
> Both values must be provided together.
> 
> Because MPAM's RMID values are not unique, the CLOSID must be provided
> when matching the RMID.
> 
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: James Morse <james.morse@arm.com>

Reviewed-by: Babu Moger <babu.moger@amd.com>

> ---
> Changes since v2:
>  * __rdtgroup_move_task() changed to set CLOSID from different CLOSID place
>    depending on group type
> 
> No changes since v6
> ---
>  arch/x86/include/asm/resctrl.h         | 18 ++++++++
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 62 ++++++++++++++++----------
>  2 files changed, 56 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
> index db4c84dde2d5..1d274dbabc44 100644
> --- a/arch/x86/include/asm/resctrl.h
> +++ b/arch/x86/include/asm/resctrl.h
> @@ -95,6 +95,24 @@ static inline unsigned int resctrl_arch_round_mon_val(unsigned int val)
>  	return val * scale;
>  }
>  
> +static inline void resctrl_arch_set_closid_rmid(struct task_struct *tsk,
> +						u32 closid, u32 rmid)
> +{
> +	WRITE_ONCE(tsk->closid, closid);
> +	WRITE_ONCE(tsk->rmid, rmid);
> +}
> +
> +static inline bool resctrl_arch_match_closid(struct task_struct *tsk, u32 closid)
> +{
> +	return READ_ONCE(tsk->closid) == closid;
> +}
> +
> +static inline bool resctrl_arch_match_rmid(struct task_struct *tsk, u32 ignored,
> +					   u32 rmid)
> +{
> +	return READ_ONCE(tsk->rmid) == rmid;
> +}
> +
>  static inline void resctrl_sched_in(struct task_struct *tsk)
>  {
>  	if (static_branch_likely(&rdt_enable_key))
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 0b9bd5f0f60d..fe6dfea471f2 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -102,7 +102,7 @@ void rdt_staged_configs_clear(void)
>   *
>   * Using a global CLOSID across all resources has some advantages and
>   * some drawbacks:
> - * + We can simply set "current->closid" to assign a task to a resource
> + * + We can simply set current's closid to assign a task to a resource
>   *   group.
>   * + Context switch code can avoid extra memory references deciding which
>   *   CLOSID to load into the PQR_ASSOC MSR
> @@ -574,14 +574,26 @@ static void update_task_closid_rmid(struct task_struct *t)
>  		_update_task_closid_rmid(t);
>  }
>  
> +static bool task_in_rdtgroup(struct task_struct *tsk, struct rdtgroup *rdtgrp)
> +{
> +	u32 closid, rmid = rdtgrp->mon.rmid;
> +
> +	if (rdtgrp->type == RDTCTRL_GROUP)
> +		closid = rdtgrp->closid;
> +	else if (rdtgrp->type == RDTMON_GROUP)
> +		closid = rdtgrp->mon.parent->closid;
> +	else
> +		return false;
> +
> +	return resctrl_arch_match_closid(tsk, closid) &&
> +	       resctrl_arch_match_rmid(tsk, closid, rmid);
> +}
> +
>  static int __rdtgroup_move_task(struct task_struct *tsk,
>  				struct rdtgroup *rdtgrp)
>  {
>  	/* If the task is already in rdtgrp, no need to move the task. */
> -	if ((rdtgrp->type == RDTCTRL_GROUP && tsk->closid == rdtgrp->closid &&
> -	     tsk->rmid == rdtgrp->mon.rmid) ||
> -	    (rdtgrp->type == RDTMON_GROUP && tsk->rmid == rdtgrp->mon.rmid &&
> -	     tsk->closid == rdtgrp->mon.parent->closid))
> +	if (task_in_rdtgroup(tsk, rdtgrp))
>  		return 0;
>  
>  	/*
> @@ -592,19 +604,19 @@ static int __rdtgroup_move_task(struct task_struct *tsk,
>  	 * For monitor groups, can move the tasks only from
>  	 * their parent CTRL group.
>  	 */
> -
> -	if (rdtgrp->type == RDTCTRL_GROUP) {
> -		WRITE_ONCE(tsk->closid, rdtgrp->closid);
> -		WRITE_ONCE(tsk->rmid, rdtgrp->mon.rmid);
> -	} else if (rdtgrp->type == RDTMON_GROUP) {
> -		if (rdtgrp->mon.parent->closid == tsk->closid) {
> -			WRITE_ONCE(tsk->rmid, rdtgrp->mon.rmid);
> -		} else {
> -			rdt_last_cmd_puts("Can't move task to different control group\n");
> -			return -EINVAL;
> -		}
> +	if (rdtgrp->type == RDTMON_GROUP &&
> +	    !resctrl_arch_match_closid(tsk, rdtgrp->mon.parent->closid)) {
> +		rdt_last_cmd_puts("Can't move task to different control group\n");
> +		return -EINVAL;
>  	}
>  
> +	if (rdtgrp->type == RDTMON_GROUP)
> +		resctrl_arch_set_closid_rmid(tsk, rdtgrp->mon.parent->closid,
> +					     rdtgrp->mon.rmid);
> +	else
> +		resctrl_arch_set_closid_rmid(tsk, rdtgrp->closid,
> +					     rdtgrp->mon.rmid);
> +
>  	/*
>  	 * Ensure the task's closid and rmid are written before determining if
>  	 * the task is current that will decide if it will be interrupted.
> @@ -626,14 +638,15 @@ static int __rdtgroup_move_task(struct task_struct *tsk,
>  
>  static bool is_closid_match(struct task_struct *t, struct rdtgroup *r)
>  {
> -	return (rdt_alloc_capable &&
> -	       (r->type == RDTCTRL_GROUP) && (t->closid == r->closid));
> +	return (rdt_alloc_capable && (r->type == RDTCTRL_GROUP) &&
> +		resctrl_arch_match_closid(t, r->closid));
>  }
>  
>  static bool is_rmid_match(struct task_struct *t, struct rdtgroup *r)
>  {
> -	return (rdt_mon_capable &&
> -	       (r->type == RDTMON_GROUP) && (t->rmid == r->mon.rmid));
> +	return (rdt_mon_capable && (r->type == RDTMON_GROUP) &&
> +		resctrl_arch_match_rmid(t, r->mon.parent->closid,
> +					r->mon.rmid));
>  }
>  
>  /**
> @@ -884,7 +897,7 @@ int proc_resctrl_show(struct seq_file *s, struct pid_namespace *ns,
>  		    rdtg->mode != RDT_MODE_EXCLUSIVE)
>  			continue;
>  
> -		if (rdtg->closid != tsk->closid)
> +		if (!resctrl_arch_match_closid(tsk, rdtg->closid))
>  			continue;
>  
>  		seq_printf(s, "res:%s%s\n", (rdtg == &rdtgroup_default) ? "/" : "",
> @@ -892,7 +905,8 @@ int proc_resctrl_show(struct seq_file *s, struct pid_namespace *ns,
>  		seq_puts(s, "mon:");
>  		list_for_each_entry(crg, &rdtg->mon.crdtgrp_list,
>  				    mon.crdtgrp_list) {
> -			if (tsk->rmid != crg->mon.rmid)
> +			if (!resctrl_arch_match_rmid(tsk, crg->mon.parent->closid,
> +						     crg->mon.rmid))
>  				continue;
>  			seq_printf(s, "%s", crg->kn->name);
>  			break;
> @@ -2825,8 +2839,8 @@ static void rdt_move_group_tasks(struct rdtgroup *from, struct rdtgroup *to,
>  	for_each_process_thread(p, t) {
>  		if (!from || is_closid_match(t, from) ||
>  		    is_rmid_match(t, from)) {
> -			WRITE_ONCE(t->closid, to->closid);
> -			WRITE_ONCE(t->rmid, to->mon.rmid);
> +			resctrl_arch_set_closid_rmid(t, to->closid,
> +						     to->mon.rmid);
>  
>  			/*
>  			 * Order the closid/rmid stores above before the loads

-- 
Thanks
Babu Moger

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D497E7300
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 21:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345163AbjKIUjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 15:39:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234623AbjKIUjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 15:39:40 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2040.outbound.protection.outlook.com [40.107.96.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332E544B9
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 12:39:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LBj+iT7B9jlppe+JJFUWdBjVgocYMofWndZifAxBJMSUOswcZdLnkE8Y4UPv4O52UqM1Iy/7oBXBS0iZfzxJyY4REzZt6tmYAcId2skpTXe0MR6ONmN3PvCe0ViRjv1OReTdYcBnTxebzMviUUyYOlxUWOFrgOgt7VpX+6CciUk3xAv6tiZxZMsLF534XU12P19qocgX1KK/N2HajsDBgrlI/1W3f+UyScMDIioeLz+WYvLeTDjGiXtI1N5n3G0hMsl66J+xaxLkW9b7f7XEiC3jJMqIExwPmfylSHVB1Epw8oaQePNofwGYG+nLW15lFdtx4YVTIGhWegLSLOr0lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HinSXP73uXIr5Q6MJBtn/ALCMS8gVJbrkwmAesrn+h0=;
 b=YPalGHfC6p7bzA+sN4jWVYVlu0Voi1NRKsjmqYf9vl4eTkLDmCQ5zlR6cg2vsE5aAK5gL0/+lN4f2JN04U/PL7FcQN8voBd+VSl1B+t2MFduZoKVqaMNu/gUml4fkEpjzX2qvsywQd2l7Gg3/B0H4ZcTigeNtiTtFr0USW/GoRZTrTLNn3JNHTMvqYvK9EGR4b/5UYSyQbJwWWCxG0DkPqJhtSGD0uKI32dkKfe0L737izzG0U+DfF65IU16m4yP1/PRH5xzonedtsEsdgNLgu5tgSCwlmHEIHZnXIGV+ChJEjQX9B8jxxjtSMK/T6NBHGF3D9vr/mjY/7+3mFQboQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HinSXP73uXIr5Q6MJBtn/ALCMS8gVJbrkwmAesrn+h0=;
 b=ix8EjJ4Gsxc1OS0XWjKAqcuIbhhn/WM4ojWB+2Jmq3La5CMOx2Q+1owDR4Gwg/NahU09D6VVqWJAJL2VT/yVM9pnNkbthkqk9K4FBl5YdLPMJTA7c2+cqTZUGc0YhXCyC0EVB49DCkq2ZZJHHZJMEw4hYhX5cBoukn7fXkHFU4M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SA1PR12MB6917.namprd12.prod.outlook.com (2603:10b6:806:24c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Thu, 9 Nov
 2023 20:39:35 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b%4]) with mapi id 15.20.6977.019; Thu, 9 Nov 2023
 20:39:35 +0000
Message-ID: <9ea2218e-3f0c-4e62-97f7-1d0b1f57b46d@amd.com>
Date:   Thu, 9 Nov 2023 14:39:34 -0600
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
X-MS-Office365-Filtering-Correlation-Id: 79e24b25-bbd7-4d3f-f8b7-08dbe163fc76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7ayDyaE2L34olE55oEE3Yl6r7+0qkVACWE1gpGZCjBO2pjsLOzJCEcNfCJvW6Og4a/zwGp529mGyBvhKV17Zb+gzXfzLoijFzNvA7PNdjC+Mufk/oDZRnrCtItW7ItLPRAS9BPwNkDZmIjz833LEFJR6Z8LPFQXuHhVFfxJ1Locr1Ha2PZynrJXnSs1E0GTgKauEvp3TwUhdoWorT+wZg6uUZL0LYzK3DYmsR8KAVA3H9NPli9rw8MogpQxGDOtDPmhfuDK+g1KTYPK69yr9EMy0V18dcqyiVs+W4WJDdwOrmeq5DqDyvyLS+Bx+TKKEZrmoUeK8oGRQAmBwJu2LJfDvPeGBRnYIdk9LoEutfWS6q17tN72E3qUnxY7m2/a1bkdYeauBKd/ghYkvxlkGhBfeH6pdDQoGsQbO7m4YH1QvPEJDaawge5ahZi6yzxIGH7m2fEUpIT4IDSNsnrh/Ebosb91eyo8zcYkRbFPbox+jkzf19aOnzuoNHFLtTKNJXIKzUL0N14rRcchHI+SyCgBPekmjX0Huukv8Bwl4Vo6hK3cmd+gPdVI4ew6XN3xdYm1chZ4EWc4faZMSeq1nw07OkskyezsSKgbWHJIkXpY3NZ1WxWsB5orff+faSMDU5fTbOZ7PdTMqpnN4l8+CwQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(136003)(39860400002)(366004)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(31686004)(2616005)(53546011)(6512007)(66556008)(478600001)(6486002)(6506007)(2906002)(54906003)(38100700002)(316002)(36756003)(5660300002)(31696002)(86362001)(41300700001)(3450700001)(66946007)(26005)(8676002)(7416002)(83380400001)(66476007)(4326008)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3pkR2pvVVFiT2F3OWhDaEhyWUp6eVVDeWV6OEswb0ZSa01iRUZZQUl6SFRW?=
 =?utf-8?B?Z2FuZEQrNk83Q2srLzErcFRXbkpVc2ZQTCthT2h6aFJNZEptWUE5dzBDTVdz?=
 =?utf-8?B?YXNTaVhzdkRNWVNXMmkxejZrZENQVkZJU05ZSDIrSDIzMlUwZGl1QXY2bk9O?=
 =?utf-8?B?QnJOcC9QeXRGaDRXUUoxeURlcTBuQnJFdExRalMwSVgreC9SaW1zNTZPa3dT?=
 =?utf-8?B?U2c5YWZ5UGg1bU1ZNW0xNlJ4RmNyUWlobUZyMkYySGcrWUZDSUg1S2p4MWg3?=
 =?utf-8?B?MWY4RTdtL05JY3hTc2ROanJvdFozbHZ0MjVCYS9MUUJ4NWpJM2cvWGNSS0RJ?=
 =?utf-8?B?cGxIUC9Ybm9BSENudVZ2aWhySG1UT1A1blBIcHJ2ZThaZjlVb3d0d3dTSTV3?=
 =?utf-8?B?MzdMaWROVmxaLzJlZDhQNEQ3aVVsalJNR1BxWDE0RlVvYVdKa1NNRURySTJu?=
 =?utf-8?B?cXpPeEJvbngwSkh6S0VVeVM1ckc4VlBXRXBBOHlvd2pUTUs1TWRNK2NsbTBE?=
 =?utf-8?B?blVrZmYwWGtxalBtbG8zTlk5SWpqQVRZRDJ5ZFp2ZHlPL1ZPU1V2WHd3Z1ll?=
 =?utf-8?B?dXdaSnM1c2twMnFQZkJpUEFDUk9PTU5iVzhyVGQ1UTBISzgvUzVuQUh6WUU4?=
 =?utf-8?B?NnNYbDJoUDFWaHRzdzByWHpQc3Fia21MbXVlL3NYUDlDVDFqc280dzgyTTA4?=
 =?utf-8?B?Yy83M2lxRHZEdDNiK213NDluMkJQMkRINVB6S2FBVzlKV0drZTRBUEY1Tk5l?=
 =?utf-8?B?azd2ZGtrZ3RMZmovSFZPM1dYT21yOUI2U3kvR2RPQ1hPTjBzYXZKeldwZWdn?=
 =?utf-8?B?MkY5MVNtMmdLUFg4cWFpOWYrbWoya0tnQ21zQWpzamN0bXBkQ01STGNuVk0z?=
 =?utf-8?B?Z05hM0IrdTcySXlLbXV1MGFRR1RUVmNDd1pUOEdTUDNkOXBadGlyem4vekxz?=
 =?utf-8?B?SmJ1eUVsTmMxQnEyVlFnOXhYNEUrTzhFNDNNZ2JZQjgrUGM2KzB1U1JSa2Fl?=
 =?utf-8?B?QldXcHZOb3R3NCtJWFhLcGJlYkRuNHVGcjgrY2NPeTNseFlRZFEzM25zbFB0?=
 =?utf-8?B?bnBiRnJVQ1F1eXJwTHFrMEZLUldDNnl4cGJqR1JGWEZWNThPQ0lZMHlsYWdO?=
 =?utf-8?B?SUNUZE9pQUJGWDFKMlhFWktPT0h0aFRrZzAwUVh2dkFBVDVtUHdua1d3UkpY?=
 =?utf-8?B?UDhqSFc1Y09sN0h4NDZiNGhlc29OVDhqNHJZK2swT2ZnMzZNak9pSWo3ditE?=
 =?utf-8?B?SDkzQVFCMG43MUY2TVAwU2RaVXh4dVF0NHp4bFNPaU1XWHZ2a1NzeSswZUpL?=
 =?utf-8?B?Y1lBYjEwUm1IdlVaQXNEbGNYZ0VqcHpGS2g3L000ejF2WDVlSFozMTVsd2xy?=
 =?utf-8?B?UlhSUlYyT3dGVHkwWTBkcVowZDZ1UkVDZHR3ZXU0a0UzVnMvbFJNZWkyOXZ5?=
 =?utf-8?B?OTlOYWdSM0lRVTg4K2NaSVdiOE52NU5BcUNQVW9tSkFEcVV2c010N3BjYjlZ?=
 =?utf-8?B?LzdXTFc2ajZRYjYybWZaUlluSUhoTXUyaHhJNWhDRlJuOGU2WWFmcFgwZ0kv?=
 =?utf-8?B?Uys3MWFSeW5NWFVDcHRpNFRhTHpMbGUwdEhGb3lyU05sbDJUbG5oL2hQOHIz?=
 =?utf-8?B?S1AwUlZVelM1TEpwbXdWdllFTXM3TGZqTjJscGlpZDZOUTRUMW9ZZjdvQUpU?=
 =?utf-8?B?SGdzTEdWNng4ZlFWNmpEN2ZZRzVLS0U2dnVBOXgyRllldThvZHhGLzZ5Unlp?=
 =?utf-8?B?ejdRbndlZnZNUU9JSk03NE9QWkdGM2xtcHpheGNkY2pTOFZSMlBXNnRCVThM?=
 =?utf-8?B?VktKOTlDUTZvekdGQ3hPQU4wc0ZCYjRTMEc0WEVmdVNZMG1oQ1RFalhhM00w?=
 =?utf-8?B?dTJ5U3dMV3g2VCt3VGthN3h0ZHZ0NXJzNWNRbFo0OTJYN05UZlNSaEU1YlVI?=
 =?utf-8?B?OGlkVVAvRGIyOVpjUTlKWUFDQU94YlplRUJ6eWlOWW5FNFpQSGx4dHNzbG5j?=
 =?utf-8?B?SExJTlpWUmJ1ZzJoUjJ0SjczZWthQUhSUlNtV0dJZGpYM0lYdEppdnRsWlRt?=
 =?utf-8?B?ZGFrVnVld0dyK1ZmQk1ST3RNU0ozMGR6RnBJOW5YTWxYWGc1SEkzTm5jcDJE?=
 =?utf-8?Q?5C+g=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79e24b25-bbd7-4d3f-f8b7-08dbe163fc76
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 20:39:35.7983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YeUxrCPy9zED6ODxKv/wsWG59C7EDFlBFjOiPNYIaTZHT0wfDV5kF3ob50yWRaGT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6917
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

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

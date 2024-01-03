Return-Path: <linux-kernel+bounces-15922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C166A8235B5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 20:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C9411C243CE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 19:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049251CF8C;
	Wed,  3 Jan 2024 19:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FKMdVu4+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6329A1CF81
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 19:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FwJ15wlSzF4/vHT7hJ9id4ejMIjuRmQYp22jUIL0Oe4iPmfIT6iME/n3lx+btVb7Zr5Xr8NONRvzzEDnuQ3VEiCrDlcPsG9wjNHG+J0VdR1sXNAfi+MBzvfn3rfJx6NDQZ+1Tw/oUqJ0aC12tu1QHjgpe/TSszcT55NedV4gKnUtXa+UtinATsPuHsC/0QQdFFYJtiMbU5KuCGu2svMcmkCRuI6nlT00VmMAKWJXd3diBCz9U8wTX12rz68qUNZnR8I0yu1PmPTTXWA3JuB7RmEl4hb4csq3NouwyfqZWquHYtLvuyTSloy1f0IMQPA/4dllB3L7NTJEyKD5x8Vwjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=raBj4c3+FMDCNFIgj6XdPmbxXugjDrni4g1vnesG2j8=;
 b=KcgGI9o2pVbdqrAiSS2bx/LGE8xSDXyxrQKeyw1BlsKGuXPMMSUsCO9cDUCoKgNtxZ3rp0VZr6vXiSs1V/te2I7/KqpTVneeyA/VxxbHjjdtgKAfBYiVDKxj3khhrxKAesSFHJhgBoguQcNZcBW+qT7OKMTTh32kIR/PKud9spQa20V7QREAeGuHqr02Jdc7yRIMBZ3eoN9DrlvqpOK1YG7Ds9qfvw8vNfRnHA7MEC3TDHF7n3qaRrmt8qUpLqXMGlQO23rMoj4Tz9l8RHrTCzOiNNwYfwuA4BI+piqvwF/7DapNUWvC++YjDlKk0kQBh+zEOJYdgQ/6iL6JlTBg8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=raBj4c3+FMDCNFIgj6XdPmbxXugjDrni4g1vnesG2j8=;
 b=FKMdVu4+AYNxE/g3ZnNxX57wsEob2mBKhK5M2hJHcQGSEwFRxKWAUTFpryEDTRZOvhaUF6OWB8IY/HR9EanQVWOUDYjM0bA+xQwl5uHuhbFUoMxST1/NS0GkhDoz4ObEqQTNBwpLK72n0j3ab0R7tZFVxDFNOZzwtT6d+sbNDqg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DS7PR12MB5813.namprd12.prod.outlook.com (2603:10b6:8:75::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 19:42:49 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b%5]) with mapi id 15.20.7135.026; Wed, 3 Jan 2024
 19:42:48 +0000
Message-ID: <b23341cb-0efb-416c-91e3-0538836af890@amd.com>
Date: Wed, 3 Jan 2024 13:42:45 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v8 00/24] x86/resctrl: monitored closid+rmid together,
 separate arch/fs locking
Content-Language: en-US
To: James Morse <james.morse@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Fenghua Yu <fenghua.yu@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
 shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com
References: <20231215174343.13872-1-james.morse@arm.com>
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <20231215174343.13872-1-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0078.namprd12.prod.outlook.com
 (2603:10b6:802:20::49) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DS7PR12MB5813:EE_
X-MS-Office365-Filtering-Correlation-Id: f1935caa-bd69-43a1-d5b8-08dc0c942a5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1WtjYe++PR+7eL9ziBnELSMPOMwSbF2Kl/NjcZpxRcfmeb7eQtFqbJWJolGEkmOF/9OJAeyNH9ou9oAVkENbEhujYgzlECu380rR/NIFdAzkCahJz9ArSNDLae1bTM5In4WzUtEIW4ygXaM1lRPEWJzH7SH64XKRGoiNrQxkUwLlTNyNujmXz7oWjOvFoMzAQbE9ZeOY8ZYU21cdMFQ05qxvv81eoENTC3uzbvBuRXKdhGRXAxwQ2sUlE+WLumZVuA907856Yt293ugx0p9oR9LUuXv9P5NBUFW0Lzqlx5uOgjK1Ju3ziMxFpcZYVzbdPdku0oEOtw3q1dR/RA0H2xYe0QBqHgbc4DV6ZJIaG5N9n981HdPdNV/3EXbq7X6N4TlMZCPNz3YXYJL/hZvbGiEJANtulWmHSlTB0rlWa27A18EXa57+ftn/nkNc7nfP8B/DTFcz18CmmokxYOGpGH+90r4QSZRC07Qx8lk29Uu1kk2AjV8b+vBADmNqWc87aaKpsBKmOyTE7o+KLqyZsPxzlT88ZfFhJzBCgw2CDwA0yxwGUnMmxac8dg/Tca0U3rl3/6YJ1rUCgfxDZoFyBltzSzCx3iYcT4+57ADRZ2+yqnZcdPXkkj++vkUPs33t
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(136003)(346002)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(4326008)(66476007)(66946007)(66556008)(6486002)(8676002)(54906003)(478600001)(966005)(316002)(8936002)(83380400001)(66899024)(6506007)(53546011)(6512007)(6666004)(26005)(2616005)(7416002)(3450700001)(5660300002)(2906002)(41300700001)(36756003)(38100700002)(86362001)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dlZVN3NSdk9NMVRmTnRiZlVxanUvOGh6QUxCYVRNQzdydjNmTEhqQkdBdnJ4?=
 =?utf-8?B?NTgwR1lKWWQ4ek5VanB2QjBIMVVCZS8rbjh6czFwbVV1eks0d2QzLys1ZXdR?=
 =?utf-8?B?d0NNbE9aaU9SSkNxd1ZtTDJGSmtndmR4UWJPNDVUckEwUDdpSGNTQjRhbmtt?=
 =?utf-8?B?N0RCVlFUbzhUdktLd3k5dUV5aEhMeDhraWdZMEVRRFk1U0lYOG1Ec3NKdUhv?=
 =?utf-8?B?WFI3ZnM0QkE3SHVIZGJGT0ZwdC9nd2xuUUVmZXRBa3N6eE5pNlI2RXA4aDNV?=
 =?utf-8?B?U1NOWndvZGpGSlZtWU1MNjdQV0xFZXpWUkN5enQ5K3VBZHJSdXd5elZSYUNN?=
 =?utf-8?B?MVIyWVlOVVl3R1IwMVFMeUtrZDcrWHU3WXJ4WjN5czQ5ZVZ5VnF2ckd6c2xP?=
 =?utf-8?B?NmNpVE41L2l0WjhOMWo4dFZlc0Jid0lOaUp3Sm1DUHVISEVwNVBaY0lvWmJI?=
 =?utf-8?B?NVBKWGY1ak9neGUzc2NYSnlmUzdUdWtJYUFkME9iekoxc3B4VmJpWDNMd1dh?=
 =?utf-8?B?akt0QUlMdzMxdjVRaGJBUjJjcUwyVWhZWFB3MDRxc3dQRE1sM3VvL0poaDhK?=
 =?utf-8?B?RjdOK2NOMFlRc3Z0R3FDYnowZWJkSERuOS9qQmhXa2plZTgwY1NCU29XOVB6?=
 =?utf-8?B?blV0ME45OXA3WU5WWWc4THBGV0pUVjFuek51eVlUK1RlUHF6eCtqSnl6WHdx?=
 =?utf-8?B?WlFUa0oyWWUwa2h5czArR0ZGTHdMVDF6a0JicW5uQmp6VkNEa1liZTZ5VjFp?=
 =?utf-8?B?YnhqdjUycGMyWDE0Y1RJSmh2UTQxZXBKeEtDTTJXYmhZaG1YTTVLNExud0h6?=
 =?utf-8?B?U1ZRS3cxbnZONlk2V2ovL0FLcDh1aTR0YWYxaDNnL2FUOHdLT1hrL2lKU2Ur?=
 =?utf-8?B?OHlSM3pUczQ2YklRZEdIemxyRmdIMkRBblVxQVhjakdhSDhuWTdEcndzdysw?=
 =?utf-8?B?UzMzR2p1UlBEZmJiTmNKZ2psdlFDdXFMYVpqTTYxOXlIejE3U3BoaUdpQmdy?=
 =?utf-8?B?d3VjcWRCcThYcHhZdGJvbytEVzZSSzU1azRVdTBZeWJZc3B2TTJyU1R1MmhQ?=
 =?utf-8?B?eUY1dXJrY29oY2xIb0JwSjBLMlQvU1NQOGw4S29EOU80QmRPZ2ZoVGozTVVn?=
 =?utf-8?B?REF2dEs4MC9BQTkrYjhaVmJzbUxuR0RzSkZhZFF5Z2VzNCtLZ3dYM2xVbUho?=
 =?utf-8?B?RDNndGJIdjBMZnpCVERkMjlSQlN4QUxXOXpBMi83L29mQm9jc2tUczJYaFFZ?=
 =?utf-8?B?NWRHT2VsYzFrVTBlaDFJM29QbkNsTzNhbS85S2txZmw4bURxT3NYWmREekVF?=
 =?utf-8?B?cWpyNFlFd3VTOHJJTHpjMVZZcTNxTjlhNi84S1ZDK05RaWNPQWQrbDBsVytz?=
 =?utf-8?B?TkdySlJZeXNjVitMYTJBdEJTZzgvSUVseWFWQkh4MHl3MFJiZUV3c0dhN2hq?=
 =?utf-8?B?b2hhRlNRS1JsZzJENkhxUmd5ZVZlckhOdHp2YWVEeEJsK0QrNmFLcWVYSFlv?=
 =?utf-8?B?SFc3d0pyUVN6bUFJQjkrVjlGODlIa3Ixd0g0c1VWQk9wY0FHM1diZTVlVTZa?=
 =?utf-8?B?R3BYemwxZEpSZFR1b0JlRHNFOUlDNXRoOUx6a1Q4SXMwWmVIUFg5d3ZDK1hY?=
 =?utf-8?B?ekR4Zk05QmNMaTNMbXFPWmlOb3duMGdtc3p6YlpaSHJSUTZDM2xPcGFLV1A0?=
 =?utf-8?B?eWM4SnU2dDZhVlA3ekJaWUx6bmJWWGtOMkNlQ3BHdXY3eGxpblE4d1JycWhV?=
 =?utf-8?B?NzJqL2EzQ0xGdnErMTB1bXZOOXpTY3FmL0hxZm16STZjblcvTC92NmZhYktB?=
 =?utf-8?B?T2pjMnBqano5d08yUWFDa3M2SGJFeXE2Wm1lQUl6NHJkRzVScGUrcUFyOSth?=
 =?utf-8?B?MWpFNzVCWVh3bHVkSmJWVk5lQnJXWlJLYmplT254VmFmZHMvcmY1QWVmYkVM?=
 =?utf-8?B?ajVhNzgyMUJDMnQvbnJoREVTSVBiM2lkelMwSlVZK0hqdXNJMUM2Mm9pTVVo?=
 =?utf-8?B?WC9ZN1pqM2N6MDdqb1hSaC9XdVBLZjJkakF4NkZjdHRxaGQzOFRDN0I5VXQ4?=
 =?utf-8?B?MkMvVE5ObnFnRHRoaDBmRmp6bVlLNW01UDd0V2JYV1NKSnd0L3NjWUtzeUFn?=
 =?utf-8?Q?6Mbk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1935caa-bd69-43a1-d5b8-08dc0c942a5b
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 19:42:48.7659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B/t+PyG1mPT0+vsUTiRT/m/Yj50A6Fj0KAoERwu4FDQyypNV33jtuneriAL1q5jP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5813

Hi James,
Tested the series. Looks good.
Thanks
Babu

On 12/15/23 11:43, James Morse wrote:
> Some of the changes this version are:
>  * Fixed a bounds checking bug in cpumask_any_housekeeping(),
>  * Moved the kfree() of rmid_ptrs[] later,
> 
> Changes are noted in each patch, I've not added 'no changes' notes
> if these need double checking anyway. I'll try again next series.
> 
> ~
> 
> This series does two things, it changes resctrl to call resctrl_arch_rmid_read()
> in a way that works for MPAM, and it separates the locking so that the arch code
> and filesystem code don't have to share a mutex. I tried to split this as two
> series, but these touch similar call sites, so it would create more work.
> 
> (What's MPAM? See the cover letter of the first series. [1])
> 
> On x86 the RMID is an independent number. MPAMs equivalent is PMG, but this
> isn't an independent number - it extends the PARTID (same as CLOSID) space
> with bits that aren't used to select the configuration. The monitors can
> then be told to match specific PMG values, allowing monitor-groups to be
> created.
> 
> But, MPAM expects the monitors to always monitor by PARTID. The
> Cache-storage-utilisation counters can only work this way.
> (In the MPAM spec not setting the MATCH_PARTID bit is made CONSTRAINED
> UNPREDICTABLE - which is Arm's term to mean portable software can't rely on
> this)
> 
> It gets worse, as some SoCs may have very few PMG bits. I've seen the
> datasheet for one that has a single bit of PMG space.
> 
> To be usable, MPAM's counters always need the PARTID and the PMG.
> For resctrl, this means always making the CLOSID available when the RMID
> is used.
> 
> To ensure RMID are always unique, this series combines the CLOSID and RMID
> into an index, and manages RMID based on that. For x86, the index and RMID
> would always be the same.
> 
> 
> Currently the architecture specific code in the cpuhp callbacks takes the
> rdtgroup_mutex. This means the filesystem code would have to export this
> lock, resulting in an ill-defined interface between the two, and the possibility
> of cross-architecture lock-ordering head aches.
> 
> The second part of this series adds a domain_list_lock to protect writes to the
> domain list, and protects the domain list with RCU - or cpus_read_lock().
> 
> Use of RCU is to allow lockless readers of the domain list. To get MPAMs monitors
> working, its very likely they'll need to be plumbed up to perf. An uncore PMU
> driver would need to be a lockless reader of the domain list.
> 
> 
> 
> This series is based on v6.7-rc2, and can be retrieved from:
> https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/monitors_and_locking/v8
> 
> Bugs welcome,
> 
> Thanks,
> 
> James
> 
> [1] https://lore.kernel.org/lkml/20210728170637.25610-1-james.morse@arm.com/
> [v1] https://lore.kernel.org/all/20221021131204.5581-1-james.morse@arm.com/
> [v2] https://lore.kernel.org/lkml/20230113175459.14825-1-james.morse@arm.com/
> [v3] https://lore.kernel.org/r/20230320172620.18254-1-james.morse@arm.com/
> [v4] https://lore.kernel.org/r/20230525180209.19497-1-james.morse@arm.com/
> [v5] https://lore.kernel.org/lkml/20230728164254.27562-1-james.morse@arm.com/
> [v6] https://lore.kernel.org/all/20230914172138.11977-1-james.morse@arm.com/
> [v7] https://lore.kernel.org/r/20231025180345.28061-1-james.morse@arm.com/
> 
> James Morse (24):
>   tick/nohz: Move tick_nohz_full_mask declaration outside the #ifdef
>   x86/resctrl: kfree() rmid_ptrs from resctrl_exit()
>   x86/resctrl: Create helper for RMID allocation and mondata dir
>     creation
>   x86/resctrl: Move rmid allocation out of mkdir_rdt_prepare()
>   x86/resctrl: Track the closid with the rmid
>   x86/resctrl: Access per-rmid structures by index
>   x86/resctrl: Allow RMID allocation to be scoped by CLOSID
>   x86/resctrl: Track the number of dirty RMID a CLOSID has
>   x86/resctrl: Use __set_bit()/__clear_bit() instead of open coding
>   x86/resctrl: Allocate the cleanest CLOSID by searching
>     closid_num_dirty_rmid
>   x86/resctrl: Move CLOSID/RMID matching and setting to use helpers
>   x86/resctrl: Add cpumask_any_housekeeping() for limbo/overflow
>   x86/resctrl: Queue mon_event_read() instead of sending an IPI
>   x86/resctrl: Allow resctrl_arch_rmid_read() to sleep
>   x86/resctrl: Allow arch to allocate memory needed in
>     resctrl_arch_rmid_read()
>   x86/resctrl: Make resctrl_mounted checks explicit
>   x86/resctrl: Move alloc/mon static keys into helpers
>   x86/resctrl: Make rdt_enable_key the arch's decision to switch
>   x86/resctrl: Add helpers for system wide mon/alloc capable
>   x86/resctrl: Add CPU online callback for resctrl work
>   x86/resctrl: Allow overflow/limbo handlers to be scheduled on any-but
>     cpu
>   x86/resctrl: Add CPU offline callback for resctrl work
>   x86/resctrl: Move domain helper migration into resctrl_offline_cpu()
>   x86/resctrl: Separate arch and fs resctrl locks
> 
>  arch/x86/include/asm/resctrl.h            |  90 +++++
>  arch/x86/kernel/cpu/resctrl/core.c        | 102 ++---
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  48 ++-
>  arch/x86/kernel/cpu/resctrl/internal.h    |  67 +++-
>  arch/x86/kernel/cpu/resctrl/monitor.c     | 449 +++++++++++++++++-----
>  arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  15 +-
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 359 ++++++++++++-----
>  include/linux/resctrl.h                   |  48 ++-
>  include/linux/tick.h                      |   9 +-
>  9 files changed, 911 insertions(+), 276 deletions(-)
> 

-- 
Thanks
Babu Moger


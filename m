Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EAAC7BAE18
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 23:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbjJEVqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 17:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjJEVqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 17:46:19 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51B79E
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 14:46:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LWpIHykic40dwIJeNhpn9b7zhC7/0YcHlJZXi2QeDbRdhqcMbBwYssBQuMMZoiuVw7SSkwryyM4XbTXnP4DXRCJ9xvzn9qVMqPXWD7CG8/+jN9ZaZBqt4WhpJdBojZbkc6/Flfx1Ww9r/17sIUJ2l7LgyTaGU5eTw8AfzrbvIbPo5ru7rYIF/C/ZfpfFz5cA56Ubk+mFTQPjlgI6pS8HtIgDd6JhqgjKGmfmid4uOwI/pXap2Pmm4mZBqhZbXqPhCO1Bw1olP2tQAzFuRWg26K7KeA8J5PME+zVqgNzIakFRmWWx5izZ+ukKYn9Wp+VXIJ6e2Rr4s39weuA2w37tjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v75zQfMsWfs1TAjSZPjxeEH5goCGEHiXSHydR5x9xRQ=;
 b=BICYREzbUm/BJTNFfCo//jaTGyOaRfTGKiqICXFgS0BZTaADjJ34ctk76sRl7YZKEVcQ9XXg4siUywge8e46B+dTkOFrIMjsWdUkkw0tuCdfMIUrO9sIE2nWu897n/TSqekeKPu0pzpajE59G1uxdtOIlei0T/iXvzXPQJyNISr9fBtZH/o2EcGDZFKAEzo5wuFWgcQdtMQebuPTT3UYoZEcKFcedFecuEBz8FLuVfAyXOTGSpWsqnEyhUTFGcOt/yzMxVMBwicd9vuweLlKNjU20wPWyWx1NzVeDtwZ4aApxquyKsTBJvhS8oG53kh0T32y5EuR6tcIY8+essN1Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v75zQfMsWfs1TAjSZPjxeEH5goCGEHiXSHydR5x9xRQ=;
 b=kSElZGi2Om+moX8y8g6Q1JxxEQb92d9Jzug+t4jBHrr1Pv/Y+o844fAmcIqJ9W095vquei5Q38zFvdDNHlXRje5FJoCs6IhAZ9cplTsweVgOUnakdMmNQHq+XS6eAiZzgJ4oZY0gYVTLcOogvTMTbrz7XvrYmnLvtN7LnoT3Fb8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DM4PR12MB7575.namprd12.prod.outlook.com (2603:10b6:8:10d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.36; Thu, 5 Oct
 2023 21:46:14 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b5d1:8b74:fe73:bd39]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b5d1:8b74:fe73:bd39%6]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 21:46:14 +0000
Message-ID: <14289ca5-5e33-6cfc-fe65-e5fd9651ed99@amd.com>
Date:   Thu, 5 Oct 2023 16:46:10 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v6 15/24] x86/resctrl: Allow arch to allocate memory
 needed in resctrl_arch_rmid_read()
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        carl@os.amperecomputing.com, lcherian@marvell.com,
        bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
        xingxin.hx@openanolis.org, baolin.wang@linux.alibaba.com,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
        dfustini@baylibre.com, amitsinght@marvell.com
References: <20230914172138.11977-1-james.morse@arm.com>
 <20230914172138.11977-16-james.morse@arm.com>
From:   "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <20230914172138.11977-16-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR13CA0009.namprd13.prod.outlook.com
 (2603:10b6:806:130::14) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DM4PR12MB7575:EE_
X-MS-Office365-Filtering-Correlation-Id: fe179391-e076-4c8a-3e65-08dbc5ec7f95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jLKlqt1n5AnoDQIHI1uf/WsKo85f4iRc3av5aPPXS+dIaUYWuFHDD5KYB0lCv3qNXnP4o8FXmuut/cnTucRVVqvCGoJgFM8Us5Fu9tpv4XLjjJ/w4oT+WXY0m+fvpuCoHexpOepX0OKZAvgNioTrv5RNDPblQ1HI9CkQBJmt1wcXjjbfYuXGivKC/LcZ2xdEBegkgSo3ANLvQh1PYOLEh5DUVe0QY5J7DYCTw8OYGBT/98S7TnYbPUn2VZXRB3NrZAS94uLOC+agfsF9Tsaw9hB+DRHZR5uMTsXUC8xB8ASfc6vHxRelLIBL9PZaibZ2Ya5p1RLUFDnCEoAJulzPfC1FzsQNhPz1kaFV/gdQ8LSX9GxnKWkQ+bu73EaXykvdEU6RUQrWzqBj4SwZp+2ZlSu6VkUopCmpphY9yM54H8EoNhyiK+TtsUegY6DRt32lG9DwGoHHel0rswdf3O3iiEkU/AtRCZaM65jIWzElo920VYcvBn6US7q3o+SS+aWXqNy2NExO8MbojxCRHXf6XgBapwO6QcNEU057JbysoPvoBWibx31rZxwL9+661bdfxIQwiAdURLZzcaK+fk30yH/PLZ3srL0OKiNBG+2JjGmB6o0CGWCWHpn82tNWnsyy6OhQyknvs+M1EWw/kal3jA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(136003)(346002)(366004)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(7416002)(5660300002)(8676002)(31686004)(2906002)(4326008)(8936002)(41300700001)(54906003)(53546011)(316002)(66946007)(66476007)(66556008)(2616005)(26005)(6666004)(36756003)(6506007)(6512007)(83380400001)(31696002)(478600001)(6486002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjAwaEo4bWVzRzNjc3ZKdGpCb1M2dUQ4dXlEbXoydGxtd01SR3VYWjA2Ni9Y?=
 =?utf-8?B?MXJqM0xjY0tSeFllV1JtUXlOWUJVYlJCSDN0elI3TmtvZ1lyc1RoMnlsTDBh?=
 =?utf-8?B?U210SUYrU1NyU2NTYm11Q3NKOVZxQWM0UGNmQ0tJV2VPUWh3NnJGRXB1UUx0?=
 =?utf-8?B?KzZHcDNWK1JzdWhPZU1SajBiZXZMUnlPcmFtSnRtRU04cUdwZWtoaTR2UmFQ?=
 =?utf-8?B?V3NLVS8rUVBuSFBSVTR2elUvdTgxSmQ0OEhtcjdxRVJsUkdEYUNWNHBUR2Fp?=
 =?utf-8?B?QStZSzQ1eDJJZmU4VnpXWXZiaDMvWXNDOFJPUFVsekkrNEsvOXh1bWxBc2hO?=
 =?utf-8?B?eVJmUVR5RnFHRmt2cUhrOTUrL1R1aG9aZHhuRWhwWHVoNFFGRDYzUjlTd0Ft?=
 =?utf-8?B?R043TVBpMlk1QXhjdHpTdHY0QWl0dmZIMm1GcEl6UXZzS0Z1UjFReC9tUGo0?=
 =?utf-8?B?ZXR2ZG1mTmRaeTdRYTF0cjJKK3RUZnRlNGkwZ1VZbUlTNld2Ylg4MWcydzFH?=
 =?utf-8?B?K0FZTlZTSWl1dG1DMVVaRnE2ME9nVXdLcmpqMTJvYzZSNE9LZ2MxVFdiVUpM?=
 =?utf-8?B?c1puOWt6UjRCQ2toZ1lRWVFCakJpamZYbktKT0J1dEJ5QmkzUUZBeDZuZFpQ?=
 =?utf-8?B?dmRpNEQyb0l5K1ZSY2dmNUNUekl0eHRlcWcyTlFnSFU0eG80YVVlOTVqOFc3?=
 =?utf-8?B?dmxtRGdmU0RvK25leVdPaERDeDh5VFB1TDBTN3hRVTdVdm1kQUgrNmVqOVNV?=
 =?utf-8?B?L1hQME8zRmFWVnRhbjVLUE9GVHVLUGhvV0tydGVPVmpnTVk5QlNtQTdqTVla?=
 =?utf-8?B?L1g5cW1SWGxKalgrNytVUCtqKzBIUEIvUmVYbUJGL1VNOUlxanJEUnY0M0ZM?=
 =?utf-8?B?d1ZucFdYV1FBOFVwK3BrVHRxQlA3RlVxay9RbkdaQUVjUmJwam5vRUd4WE5h?=
 =?utf-8?B?VDREamxKZWdRZG9weHpFdUJqeG50SUZWSTlJUkUwWFh6eW5lUFRrcmpQc2Ft?=
 =?utf-8?B?VDZYOEFlTFZyMzdTVVZOSWcvbkp0NnkreUMyOU5IcE1UREhId1V3N0NIaVdL?=
 =?utf-8?B?RllZRDRxSHVzWWpRejBJN2RBcmpEVXQ4YVd3ajBIcERlU0c5azZBVjRoSGdl?=
 =?utf-8?B?bmc1NHYrMlpocDBkRDFjcHlYOWhxNW1kNFFaMi9jRUdqeVdXUFFKaml2MjNl?=
 =?utf-8?B?K3BJOU9RNWUzZisxOUpwcHo2d2RKUTZZREsyb1VoMXdZSkduUWYzbTA4Vjdo?=
 =?utf-8?B?VEc2UGU2SUFyaTBmNWtFTllhUkk1ZGRKTXdUWEphTitmZXAxbmIvZ2JkbE5r?=
 =?utf-8?B?UVdEOUJaMlJGa2s1UFNFNStUTVNtT3lPcTI0ZTBFS1FCQmFLejJ3NWxsQnl1?=
 =?utf-8?B?ajVhMGM0ZmN1WHY4L2JlRWtWYmIwbGxsclhzNmNiSFhmSFlTQWtya0pKUWx5?=
 =?utf-8?B?REpxSVVlZnMxWVlCUkFuK2V1UHloOVc1SWF0YjFlTTNHVW9nbmpvNFUxN1g0?=
 =?utf-8?B?L3plNngyZGZ3Wm1SMTlUR20zaVpuN3FuckM4dGZuQkZuWThNZ0cyNWw2NFlJ?=
 =?utf-8?B?OXBXcUk4a0JEUDU4UDMvN1ZkMVFrZm1qVmRSdWUyeWFxOXQ3WjBXTkErNlV3?=
 =?utf-8?B?M25iNkZveVFwTzFGakZuN2JPcGlDV1F4dlpTc09ESFJja2YvQVAwQ2pISUk5?=
 =?utf-8?B?Z0tKTTNYWXM2SG03WkZKUk1mcXNDamdkS2VSQ3FQTDk3QjJablZqaFFyRVFM?=
 =?utf-8?B?NURBckUvRVc5a1pXd212NlZOaTVpVW9nVnZNRE0vampvL2ZveGViaTIxZHRQ?=
 =?utf-8?B?Nml6STlGMmxKbUVsOUY0ZWM0RkNBYlZ4c2k4VzRaQWdESWRuMkNmdGIxN3c1?=
 =?utf-8?B?a0JxZmNnRWl3N0loTlR2NmxWYVFBNVhsTDJVcDVadTAwSWdWRkJvT1pmMkhq?=
 =?utf-8?B?WUI1VnhyNUFPLzdxRXZmSE5MaDU5MjRMRUhrQmkySFpSTlNtamFKS3hVQ012?=
 =?utf-8?B?WUloYTdBa3VFd2tldEdnRGxTWlJHcWNlemhwN2Uzbmtla3V5TDJobUtIVnYv?=
 =?utf-8?B?UE9lMk4xYVhxaTBTdXdTTy9uQ01VWlJuNFR5anNqOTlvaGFqT3djbjgxa3lt?=
 =?utf-8?Q?daGGz91iS05roxGR/TqCa9K3m?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe179391-e076-4c8a-3e65-08dbc5ec7f95
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 21:46:14.7997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eakvdKbfSdwfVZdbzsMb38TPGruQQuCGw3izxWpYC+k4uxs9fiaExS4+5e1sZIut
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7575
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 9/14/2023 12:21 PM, James Morse wrote:
> Depending on the number of monitors available, Arm's MPAM may need to
> allocate a monitor prior to reading the counter value. Allocating a
> contended resource may involve sleeping.
>
> add_rmid_to_limbo() calls resctrl_arch_rmid_read() for multiple domains,
> the allocation should be valid for all domains.
>
> __check_limbo() and mon_event_count() each make multiple calls to
> resctrl_arch_rmid_read(), to avoid extra work on contended systems,
> the allocation should be valid for multiple invocations of
> resctrl_arch_rmid_read().
>
> Add arch hooks for this allocation, which need calling before
> resctrl_arch_rmid_read(). The allocated monitor is passed to
> resctrl_arch_rmid_read(), then freed again afterwards. The helper
> can be called on any CPU, and can sleep.
>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-By: Peter Newman <peternewman@google.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v3:
>   * Expanded comment.
>   * Removed stray header include.
>   * Reworded commit message.
>   * Made ctx a void * instead of an int.
>
> Changes since v4:
>   * Used IS_ERR() in more places.
>
> Changes since v5:
>   * Pass the error back from mon_event_read() as -EINVAL/Unavailable.
>   * Add some ratelimited warnings when failing to allocate a mon context
> ---
>   arch/x86/include/asm/resctrl.h            | 11 ++++++++
>   arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  7 +++++
>   arch/x86/kernel/cpu/resctrl/internal.h    |  1 +
>   arch/x86/kernel/cpu/resctrl/monitor.c     | 34 +++++++++++++++++++++--
>   include/linux/resctrl.h                   |  5 +++-
>   5 files changed, 54 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
> index 1d274dbabc44..29c4cc343787 100644
> --- a/arch/x86/include/asm/resctrl.h
> +++ b/arch/x86/include/asm/resctrl.h
> @@ -136,6 +136,17 @@ static inline u32 resctrl_arch_rmid_idx_encode(u32 ignored, u32 rmid)
>   	return rmid;
>   }
>   
> +/* x86 can always read an rmid, nothing needs allocating */
> +struct rdt_resource;
> +static inline void *resctrl_arch_mon_ctx_alloc(struct rdt_resource *r, int evtid)
> +{
> +	might_sleep();
> +	return NULL;
> +};
> +
> +static inline void resctrl_arch_mon_ctx_free(struct rdt_resource *r, int evtid,
> +					     void *ctx) { };
> +
>   void resctrl_cpu_detect(struct cpuinfo_x86 *c);
>   
>   #else
> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> index bd263b9a0abd..ce4821ea111b 100644
> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> @@ -546,6 +546,11 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
>   	rr->d = d;
>   	rr->val = 0;
>   	rr->first = first;
> +	rr->arch_mon_ctx = resctrl_arch_mon_ctx_alloc(r, evtid);
> +	if (IS_ERR(rr->arch_mon_ctx)) {
> +		rr->err = -EINVAL;
> +		return;
> +	}
>   
>   	cpu = cpumask_any_housekeeping(&d->cpu_mask);
>   
> @@ -559,6 +564,8 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
>   		smp_call_function_any(&d->cpu_mask, mon_event_count, rr, 1);
>   	else
>   		smp_call_on_cpu(cpu, smp_mon_event_count, rr, false);
> +
> +	resctrl_arch_mon_ctx_free(r, evtid, rr->arch_mon_ctx);
>   }
>   
>   int rdtgroup_mondata_show(struct seq_file *m, void *arg)
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 37bb3de37a4a..66d9ebb5e03a 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -136,6 +136,7 @@ struct rmid_read {
>   	bool			first;
>   	int			err;
>   	u64			val;
> +	void			*arch_mon_ctx;
>   };
>   
>   extern bool rdt_alloc_capable;
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 05d949ec94f1..28a2c8765faf 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -270,7 +270,7 @@ static u64 mbm_overflow_count(u64 prev_msr, u64 cur_msr, unsigned int width)
>   
>   int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
>   			   u32 unused, u32 rmid, enum resctrl_event_id eventid,
> -			   u64 *val)
> +			   u64 *val, void *ignored)
>   {
>   	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>   	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
> @@ -325,9 +325,17 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
>   	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
>   	struct rmid_entry *entry;
>   	u32 idx, cur_idx = 1;
> +	void *arch_mon_ctx;
>   	bool rmid_dirty;
>   	u64 val = 0;
>   
> +	arch_mon_ctx = resctrl_arch_mon_ctx_alloc(r, QOS_L3_OCCUP_EVENT_ID);
> +	if (IS_ERR(arch_mon_ctx)) {
> +		pr_warn_ratelimited("Failed to allocate monitor context: %ld",
> +				    PTR_ERR(arch_mon_ctx));
> +		return;
> +	}
> +
>   	/*
>   	 * Skip RMID 0 and start from RMID 1 and check all the RMIDs that
>   	 * are marked as busy for occupancy < threshold. If the occupancy
> @@ -341,7 +349,8 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
>   
>   		entry = __rmid_entry(idx);
>   		if (resctrl_arch_rmid_read(r, d, entry->closid, entry->rmid,
> -					   QOS_L3_OCCUP_EVENT_ID, &val)) {
> +					   QOS_L3_OCCUP_EVENT_ID, &val,
> +					   arch_mon_ctx)) {
>   			rmid_dirty = true;
>   		} else {
>   			rmid_dirty = (val >= resctrl_rmid_realloc_threshold);
> @@ -354,6 +363,8 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
>   		}
>   		cur_idx = idx + 1;
>   	}
> +
> +	resctrl_arch_mon_ctx_free(r, QOS_L3_OCCUP_EVENT_ID, arch_mon_ctx);
>   }
>   
>   bool has_busy_rmid(struct rdt_domain *d)
> @@ -532,7 +543,7 @@ static int __mon_event_count(u32 closid, u32 rmid, struct rmid_read *rr)
>   	}
>   
>   	rr->err = resctrl_arch_rmid_read(rr->r, rr->d, closid, rmid, rr->evtid,
> -					 &tval);
> +					 &tval, rr->arch_mon_ctx);
>   	if (rr->err)
>   		return rr->err;
>   
> @@ -743,11 +754,27 @@ static void mbm_update(struct rdt_resource *r, struct rdt_domain *d,
>   	if (is_mbm_total_enabled()) {
>   		rr.evtid = QOS_L3_MBM_TOTAL_EVENT_ID;
>   		rr.val = 0;
> +		rr.arch_mon_ctx = resctrl_arch_mon_ctx_alloc(rr.r, rr.evtid);
> +		if (IS_ERR(rr.arch_mon_ctx)) {
> +			pr_warn_ratelimited("Failed to allocate monitor context: %ld",
> +					    PTR_ERR(rr.arch_mon_ctx));
> +			return;
> +		}
> +
>   		__mon_event_count(closid, rmid, &rr);
> +
> +		resctrl_arch_mon_ctx_free(rr.r, rr.evtid, rr.arch_mon_ctx);
>   	}
>   	if (is_mbm_local_enabled()) {
>   		rr.evtid = QOS_L3_MBM_LOCAL_EVENT_ID;
>   		rr.val = 0;
> +		rr.arch_mon_ctx = resctrl_arch_mon_ctx_alloc(rr.r, rr.evtid);
> +		if (IS_ERR(rr.arch_mon_ctx)) {
> +			pr_warn_ratelimited("Failed to allocate monitor context: %ld",
> +					    PTR_ERR(rr.arch_mon_ctx));
> +			return;
> +		}
> +
>   		__mon_event_count(closid, rmid, &rr);
>   
>   		/*
> @@ -757,6 +784,7 @@ static void mbm_update(struct rdt_resource *r, struct rdt_domain *d,
>   		 */
>   		if (is_mba_sc(NULL))
>   			mbm_bw_count(closid, rmid, &rr);
> +		resctrl_arch_mon_ctx_free(rr.r, rr.evtid, rr.arch_mon_ctx);

Space before the last line would be cleaner.

                 if (is_mba_sc(NULL))
  			mbm_bw_count(closid, rmid, &rr);
+
+		resctrl_arch_mon_ctx_free(rr.r, rr.evtid, rr.arch_mon_ctx);


>   	}
>   }
>   
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index f7311102e94c..5e4b4df9610b 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -235,6 +235,9 @@ void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d);
>    * @rmid:		rmid of the counter to read.
>    * @eventid:		eventid to read, e.g. L3 occupancy.
>    * @val:		result of the counter read in bytes.
> + * @arch_mon_ctx:	An architecture specific value from
> + *			resctrl_arch_mon_ctx_alloc(), for MPAM this identifies
> + *			the hardware monitor allocated for this read request.
>    *
>    * Some architectures need to sleep when first programming some of the counters.
>    * (specifically: arm64's MPAM cache occupancy counters can return 'not ready'
> @@ -248,7 +251,7 @@ void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d);
>    */
>   int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
>   			   u32 closid, u32 rmid, enum resctrl_event_id eventid,
> -			   u64 *val);
> +			   u64 *val, void *arch_mon_ctx);

Just wondering.. Have you thought about passing rmid_read structure to 
this function?

Because most of the information is already inside the rmid_read 
structure. We can avoid passing 7 parameters.

Thanks

Babu

>   
>   /**
>    * resctrl_arch_rmid_read_context_check()  - warn about invalid contexts

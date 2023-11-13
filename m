Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03E97EA28D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 19:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbjKMSIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 13:08:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKMSIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 13:08:30 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE69AC2;
        Mon, 13 Nov 2023 10:08:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N/nuBIdAAPJK3NpKdGn7IWZFJSP+bBZRwEyhz8O0Gbg9gHXkclZnVif/dzXJt2mX+30rzzTsHN/ALfu5v8y0cWlO+L7r9MjRtK/E+eRg6+VSYw8ZZoL5KV1fU1powv8PXTJnnQCmmnqY9QLC2hxPIXRV5gnFETnVTfqJCAG1H8DYgCacRzpIxfmV4XmWu/XyxwHCYdGvwML2lCLFDOV4X4ePNoeTZ6HG/Ys4hWIWNK/rBJb6yPYLCzqKW5fFh3YpcJ25wM3OlnN4E0i1wu6T/BNj2h7BMT9BIIdlQoTI2TQIYMZa9UXeZOpfK4kFm24SDt2Eo70v/xk/5d0YMbv6Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lfmj9gvLYOf0crZ2u31Fpr7rE0HPByQ+KLnqiHkFEr8=;
 b=DcTcdeZmrFLEhjIbmpDBcGRxjeKItu1QPAnmo2Ps6ERFLuuORZejshYeB8g9xGWTazfM3LWgvs9OGCW2xJ8IqTB0IhBdX90B0byasoCkwlqFvjsU9AgMHkw9EvM+teK9CPNDi49T9v+ywkWAQe90esE75LvcZVc9PRltkUHHguCJ/8nAM6u31YWp9ZJtz1KU57wfb5Zne+PsfSlmDe8QGAC0N37Yl2BEOGsTz1HSg2DpFil7Ew+FqRSemGYvI3eDVLz5BQC50bL/+yQDioKTYVUD/DUxeywih3uz5pizl2ORAEFqC7XnEStSN6ou650/X82WaZ4tzjiPb6togG0FJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lfmj9gvLYOf0crZ2u31Fpr7rE0HPByQ+KLnqiHkFEr8=;
 b=RDh6ziyNVKADnrOPrfGyTR9sA3B3CrpU/39OdbR8FiNG5Uny3u9aFE5ce8RuiHF1tALkVjzEC5ivvqEpEB/4vH4cShE7HgyFRe7MXvNQ0EgpJbEyX4/WdnHkbazMxdD/h7ngao31RnaXBN/NOyF2TiX8L9nIpAr0MDbBHEt/svs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SN7PR12MB7934.namprd12.prod.outlook.com (2603:10b6:806:346::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.28; Mon, 13 Nov
 2023 18:08:21 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b%4]) with mapi id 15.20.6977.026; Mon, 13 Nov 2023
 18:08:21 +0000
Message-ID: <678ea7e8-e4e5-4848-b77c-a94a1d326f5b@amd.com>
Date:   Mon, 13 Nov 2023 12:08:19 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v11 2/8] x86/resctrl: Prepare to split rdt_domain
 structure
Content-Language: en-US
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org
Cc:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        patches@lists.linux.dev
References: <20231031211708.37390-1-tony.luck@intel.com>
 <20231109230915.73600-1-tony.luck@intel.com>
 <20231109230915.73600-3-tony.luck@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <20231109230915.73600-3-tony.luck@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0128.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::10) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SN7PR12MB7934:EE_
X-MS-Office365-Filtering-Correlation-Id: 48d1bcf0-a13a-46eb-768d-08dbe4738576
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bm2bHJ+Q37eyKZUQK8YUUk19bRscsDxFvE4DqfZlzjDDW6sjo9Y/a44Qg9LkQx42SOHeWIzuGISKOn6SBBxUBsgGYjO4qvG6o/2S9ZZLpladBwkKZws8FXwUVyn5sXVaaZUFtH55qKowNYRj4s5YfTLpTUSZUL05RTMYYqMJusrDj85TKEqENggwKB9xpu+dKow8Y8+cjwolBFsmnU1LiARv+zKqowTZiKuUtPAe9ugPnRBcNKaNgyWcbb+TEv+tBo7cs3LEZcsytkkwXRuLtvD95MMLaPEvWuGGtpWAHFNe9yEAR24ivZvY4KCBHFs4NQR0BzYHSlpSvex/C02SxhPAPiu7teV3bnYdz9noGwI4lG1hGU+TW+0+UFdqm685mvN2qvj8jxFmxP8YGDtov6rUbhsCfuxxhb1umRSCLtyh4n8CZe+asgWcKT2RRGn6sxJqDcL4Vz99d/l8vPxhmN+e2la5Zoma13/+++rcVAoKlBmW4OW67cbEyUGjn9w5yAKaeN63MqFM0gSOl1x/zhwW+uiO685I71IRjFzQ3aYuJD3zzBuxc2C5P0ZOFYLoFqOOoOPBOiR711fNwq7A1MZHlS4DDlfiYBRrTZL/5sB/+HloDe8MxnoT3HKPhclAsJWPVSoxnE3ZEwM6C9XkTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(39860400002)(366004)(376002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(38100700002)(2616005)(8676002)(8936002)(4326008)(53546011)(6512007)(6506007)(83380400001)(26005)(31686004)(6486002)(478600001)(110136005)(316002)(66476007)(66556008)(66946007)(54906003)(36756003)(41300700001)(2906002)(7416002)(5660300002)(86362001)(31696002)(3450700001)(30864003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXZBWUxNLzJnUklqYnBPSzFkZ282R3dXVHdhajJxeEFHczl6aTNiTHFSdDNR?=
 =?utf-8?B?TFhWaU9CR21qamNlcFhTWEZTNEFiT2gxZ2JHQnRSK1gwckorcFkxYURUZ09T?=
 =?utf-8?B?VlV2UFRDY3dZdU10SE4wdUQ1TWtBdmc1VVJ0d0F5UHRTOGd5NlFwZFBiSEJq?=
 =?utf-8?B?QWVlWVo5Sytoa1RYdHdFNnpsQmZGYUx5d0l5d21Lb2EramNrY3BrdHl3Rnh6?=
 =?utf-8?B?bTZrV0plcHcrRlZmVjE0c1BoM05YZWtVRzhFYWlWRlRnVk5SQTk1bTFJRVpQ?=
 =?utf-8?B?NFhlZlQ3bk9VVWVUbkM5M0puSUFPancyS3A3SlpYcGZwbW1yUTUxeDhQY2VJ?=
 =?utf-8?B?VnRreElucjBoNDlwdUdJYWdXUmpJbDMvSnR6TWRjMG1oVFhZZDlCMDZpV1Vj?=
 =?utf-8?B?a1VyWkNPbDc4OHJxK3ZrRmd2bzAya3g4Z1ZJTlZYbVdEOEhxclFNMkdlZUF3?=
 =?utf-8?B?S0h6S1RSaGJYWnVaOEZxSW4xeGVWRk9tR3NaeTYvVk9BZVBvM2VudlVTeFdR?=
 =?utf-8?B?dytpTmY0RHlwbEFId0RyakVDdlJ6eWlRQzFadlJ5UkZrYTc5YVVTam4xcVE2?=
 =?utf-8?B?RU1pdFRGSWlnWWR5Yis5UXd6R1Z5MGRUMWRMN1RjWWpzZTBnanpINHVvU0dO?=
 =?utf-8?B?aXFXYnN3ZjVhcmdrTUlpN01sSXVIOGoySVBRcTJIb24xcmQwQW05dGxUZ2N0?=
 =?utf-8?B?MzdDSjVtOVdMUFhhWEtCRmNySVhaUjhPclYyMU1kaDh3dU1wNWJaTHVRYmJJ?=
 =?utf-8?B?N1F3V2JuRkVyd0JNRHJ5ZlUzVTVkRGNrNm5wb3FKZGwxdEJGK1BqZHdZOC84?=
 =?utf-8?B?M3lCNGZOY1l3NjMwcHZGR3JQV1BzdUNMUVNmWXZST1k3S0tzUTZtV0NhcVdp?=
 =?utf-8?B?dXFXZW5zUHlvaGwrVDdPejRjRGRJNHlrUUc5ZW0zcFBKSFVFMlVjeEVnRUx0?=
 =?utf-8?B?Vnh3Zjh2MzR1ZXp6dDZCM0ZBeEUwZXdnaG9sNTJ2ckx4SmZ1WDNkUEdKY00y?=
 =?utf-8?B?VzU5L1FkTVNzQ3Nhbm9iYjNodzhoS01vQnArQk4vVUZrbDlLbmlEMWtDRWJH?=
 =?utf-8?B?VnFXZHRqdWxNK0srenVkTnlwb1E0Ynk4OVlvbHFSTFl4YlZmanJMczVjQjBp?=
 =?utf-8?B?ZkNWcStGSDcwSHNxMnkwaHBMcXNrSStNNEh5TG5RK1E0T09tRWtXUWo4bnBK?=
 =?utf-8?B?Z3lOenZBdHlJTGRJRmdwRktCU1prVFJwUVY1aU55UGxPbUlnN0htNUYyL1Av?=
 =?utf-8?B?WStEMHlPQ3FhWjNQK1hDSWFjeWRMV1QzQzZkNFVmYldVVDVBOUZDNm1XR3Ez?=
 =?utf-8?B?TDM1VmFmclgwdTllQ3dDRm9aTzdwbERHVFpMbGo3SkVpa3VCR0N1ZmZVcHl0?=
 =?utf-8?B?LzdLM3hyck1yS1ZKVlViZ0diVWZuVFEzSmJ4dmhpK1hTT2dKdmpCSjB1QVNz?=
 =?utf-8?B?UlZudTlOaXh1dmNQYnd0MHo5eXpxbXVVemloTmVscFQvNlpPQlpjSXNnS3Nx?=
 =?utf-8?B?dC9sRnFpbTM5MFFYK1hwQjRkL1l3R3djY3IzcDdieERERG43Qjlja3FtV2Iw?=
 =?utf-8?B?WVI2OUdFbWtHcSt0Z01DUmpTWkUrSkRqMWtoV3lqV0IwZmo5dnJneTZRaXBH?=
 =?utf-8?B?TkhDZGhQUzFEaC9TTkVwZk9DZnMrYm1kOWZYMjZpNThrbFlYSXV5UEVaSHA0?=
 =?utf-8?B?KzFmTUdpS0ZwT2xTU3RxZFpuOHJhRzZhZWlGVmhGNVAxb2dqNkgwV1NXVTI2?=
 =?utf-8?B?VXV2eUM1Mk5mT0liMm13akhXRWI0enA0dmpwR1J2dkh3dS8yR2FOQW1vbm9Z?=
 =?utf-8?B?elNSUHB3QlE3QjJ6NnR5OHIvaXp3eTdZbU9lbUNpTEhoUWJWUkUzQm5rbmxY?=
 =?utf-8?B?VjZ4ZERucWpOOWVlODhkU1M3SExGdVZMU1gvdFhHdEYyUHpZYXBjOVBISnRZ?=
 =?utf-8?B?cWw1M3VKY0dQamFIUTdIZXdmaHN5eU5EMVNDV0lwQVFYUVVOeG9qOFhReGpX?=
 =?utf-8?B?NG9xYTVxVm9lWkZZNHhtUit0Tmt5eGsyeUY4eHorcXNTZzQwRll3MGVqdngv?=
 =?utf-8?B?dEF5THlSd1QvMzJDMGgxRms0VnN3aHVTMk9pRUZvLzAzdGI5Q3dXZE4vdzhz?=
 =?utf-8?Q?A5Jg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48d1bcf0-a13a-46eb-768d-08dbe4738576
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 18:08:21.6202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KfITDu3Eyuf5SQ8VcFkyllc767e5OIYsey4StZ9ck4naNl1Rb3SkbIO4/rCcrWyQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7934
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

Sorry for the late review. The patches look good for the most part. But we
can simplify a little more. Please see my comments below.


On 11/9/23 17:09, Tony Luck wrote:
> The rdt_domain structure is used for both control and monitor features.
> It is about to be split into separate structures for these two usages
> because the scope for control and monitoring features for a resource
> will be different for future resources.
> 
> To allow for common code that scans a list of domains looking for a
> specific domain id, move all the common fields ("list", "id", "cpu_mask")
> into their own structure within the rdt_domain structure.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  include/linux/resctrl.h                   | 16 ++++--
>  arch/x86/kernel/cpu/resctrl/core.c        | 26 +++++-----
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 22 ++++-----
>  arch/x86/kernel/cpu/resctrl/monitor.c     | 10 ++--
>  arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 14 +++---
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 60 +++++++++++------------
>  6 files changed, 78 insertions(+), 70 deletions(-)
> 
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index 7d4eb7df611d..c4067150a6b7 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -53,10 +53,20 @@ struct resctrl_staged_config {
>  };
>  
>  /**
> - * struct rdt_domain - group of CPUs sharing a resctrl resource
> + * struct rdt_domain_hdr - common header for different domain types
>   * @list:		all instances of this resource
>   * @id:			unique id for this instance
>   * @cpu_mask:		which CPUs share this resource
> + */
> +struct rdt_domain_hdr {
> +	struct list_head		list;
> +	int				id;
> +	struct cpumask			cpu_mask;
> +};

I like the idea of separating the domains, one for control and another for
monitor. I have some comments on how it can be done to simplify the code.
Adding the hdr adds a little complexity to the code.

How about converting the current rdt_domain to explicitly to rdt_mon_domain?

Something like this.

struct rdt_mon_domain {
        struct list_head                list;
        int                             id;
        struct cpumask                  cpu_mask;
        unsigned long                   *rmid_busy_llc;
        struct mbm_state                *mbm_total;
        struct mbm_state                *mbm_local;
        struct delayed_work             mbm_over;
        struct delayed_work             cqm_limbo;
        int                             mbm_work_cpu;
        int                             cqm_work_cpu;
};


Then introduce rdt_ctrl_domain to which separates into two doamins.

struct rdt_ctrl_domain {
        struct list_head                list;
        int                             id;
        struct cpumask                  cpu_mask;
        struct pseudo_lock_region       *plr;
        struct resctrl_staged_config    staged_config[CDP_NUM_TYPES];
        u32                             *mbps_val;
};

I feel this will be easy to understand and makes the code simpler. Changes
will be minimal.

Thanks
Babu


> +
> +/**
> + * struct rdt_domain - group of CPUs sharing a resctrl resource
> + * @hdr:		common header for different domain types
>   * @rmid_busy_llc:	bitmap of which limbo RMIDs are above threshold
>   * @mbm_total:		saved state for MBM total bandwidth
>   * @mbm_local:		saved state for MBM local bandwidth
> @@ -71,9 +81,7 @@ struct resctrl_staged_config {
>   *			by closid
>   */
>  struct rdt_domain {
> -	struct list_head		list;
> -	int				id;
> -	struct cpumask			cpu_mask;
> +	struct rdt_domain_hdr		hdr;
>  	unsigned long			*rmid_busy_llc;
>  	struct mbm_state		*mbm_total;
>  	struct mbm_state		*mbm_local;
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 9f8d87abd751..c0659e84c9e3 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -356,9 +356,9 @@ struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r)
>  {
>  	struct rdt_domain *d;
>  
> -	list_for_each_entry(d, &r->domains, list) {
> +	list_for_each_entry(d, &r->domains, hdr.list) {
>  		/* Find the domain that contains this CPU */
> -		if (cpumask_test_cpu(cpu, &d->cpu_mask))
> +		if (cpumask_test_cpu(cpu, &d->hdr.cpu_mask))
>  			return d;
>  	}
>  
> @@ -402,12 +402,12 @@ struct rdt_domain *rdt_find_domain(struct rdt_resource *r, int id,
>  	struct list_head *l;
>  
>  	list_for_each(l, &r->domains) {
> -		d = list_entry(l, struct rdt_domain, list);
> +		d = list_entry(l, struct rdt_domain, hdr.list);
>  		/* When id is found, return its domain. */
> -		if (id == d->id)
> +		if (id == d->hdr.id)
>  			return d;
>  		/* Stop searching when finding id's position in sorted list. */
> -		if (id < d->id)
> +		if (id < d->hdr.id)
>  			break;
>  	}
>  
> @@ -530,7 +530,7 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
>  
>  	d = rdt_find_domain(r, id, &add_pos);
>  	if (d) {
> -		cpumask_set_cpu(cpu, &d->cpu_mask);
> +		cpumask_set_cpu(cpu, &d->hdr.cpu_mask);
>  		if (r->cache.arch_has_per_cpu_cfg)
>  			rdt_domain_reconfigure_cdp(r);
>  		return;
> @@ -541,8 +541,8 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
>  		return;
>  
>  	d = &hw_dom->d_resctrl;
> -	d->id = id;
> -	cpumask_set_cpu(cpu, &d->cpu_mask);
> +	d->hdr.id = id;
> +	cpumask_set_cpu(cpu, &d->hdr.cpu_mask);
>  
>  	rdt_domain_reconfigure_cdp(r);
>  
> @@ -556,11 +556,11 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
>  		return;
>  	}
>  
> -	list_add_tail(&d->list, add_pos);
> +	list_add_tail(&d->hdr.list, add_pos);
>  
>  	err = resctrl_online_domain(r, d);
>  	if (err) {
> -		list_del(&d->list);
> +		list_del(&d->hdr.list);
>  		domain_free(hw_dom);
>  	}
>  }
> @@ -581,10 +581,10 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
>  	}
>  	hw_dom = resctrl_to_arch_dom(d);
>  
> -	cpumask_clear_cpu(cpu, &d->cpu_mask);
> -	if (cpumask_empty(&d->cpu_mask)) {
> +	cpumask_clear_cpu(cpu, &d->hdr.cpu_mask);
> +	if (cpumask_empty(&d->hdr.cpu_mask)) {
>  		resctrl_offline_domain(r, d);
> -		list_del(&d->list);
> +		list_del(&d->hdr.list);
>  
>  		/*
>  		 * rdt_domain "d" is going to be freed below, so clear
> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> index 3f8891d57fac..23f8258d36a8 100644
> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> @@ -67,7 +67,7 @@ int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
>  
>  	cfg = &d->staged_config[s->conf_type];
>  	if (cfg->have_new_ctrl) {
> -		rdt_last_cmd_printf("Duplicate domain %d\n", d->id);
> +		rdt_last_cmd_printf("Duplicate domain %d\n", d->hdr.id);
>  		return -EINVAL;
>  	}
>  
> @@ -146,7 +146,7 @@ int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
>  
>  	cfg = &d->staged_config[s->conf_type];
>  	if (cfg->have_new_ctrl) {
> -		rdt_last_cmd_printf("Duplicate domain %d\n", d->id);
> +		rdt_last_cmd_printf("Duplicate domain %d\n", d->hdr.id);
>  		return -EINVAL;
>  	}
>  
> @@ -226,8 +226,8 @@ static int parse_line(char *line, struct resctrl_schema *s,
>  		return -EINVAL;
>  	}
>  	dom = strim(dom);
> -	list_for_each_entry(d, &r->domains, list) {
> -		if (d->id == dom_id) {
> +	list_for_each_entry(d, &r->domains, hdr.list) {
> +		if (d->hdr.id == dom_id) {
>  			data.buf = dom;
>  			data.rdtgrp = rdtgrp;
>  			if (r->parse_ctrlval(&data, s, d))
> @@ -274,7 +274,7 @@ static bool apply_config(struct rdt_hw_domain *hw_dom,
>  	struct rdt_domain *dom = &hw_dom->d_resctrl;
>  
>  	if (cfg->new_ctrl != hw_dom->ctrl_val[idx]) {
> -		cpumask_set_cpu(cpumask_any(&dom->cpu_mask), cpu_mask);
> +		cpumask_set_cpu(cpumask_any(&dom->hdr.cpu_mask), cpu_mask);
>  		hw_dom->ctrl_val[idx] = cfg->new_ctrl;
>  
>  		return true;
> @@ -291,7 +291,7 @@ int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_domain *d,
>  	u32 idx = get_config_index(closid, t);
>  	struct msr_param msr_param;
>  
> -	if (!cpumask_test_cpu(smp_processor_id(), &d->cpu_mask))
> +	if (!cpumask_test_cpu(smp_processor_id(), &d->hdr.cpu_mask))
>  		return -EINVAL;
>  
>  	hw_dom->ctrl_val[idx] = cfg_val;
> @@ -318,7 +318,7 @@ int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
>  		return -ENOMEM;
>  
>  	msr_param.res = NULL;
> -	list_for_each_entry(d, &r->domains, list) {
> +	list_for_each_entry(d, &r->domains, hdr.list) {
>  		hw_dom = resctrl_to_arch_dom(d);
>  		for (t = 0; t < CDP_NUM_TYPES; t++) {
>  			cfg = &hw_dom->d_resctrl.staged_config[t];
> @@ -466,7 +466,7 @@ static void show_doms(struct seq_file *s, struct resctrl_schema *schema, int clo
>  	u32 ctrl_val;
>  
>  	seq_printf(s, "%*s:", max_name_width, schema->name);
> -	list_for_each_entry(dom, &r->domains, list) {
> +	list_for_each_entry(dom, &r->domains, hdr.list) {
>  		if (sep)
>  			seq_puts(s, ";");
>  
> @@ -476,7 +476,7 @@ static void show_doms(struct seq_file *s, struct resctrl_schema *schema, int clo
>  			ctrl_val = resctrl_arch_get_config(r, dom, closid,
>  							   schema->conf_type);
>  
> -		seq_printf(s, r->format_str, dom->id, max_data_width,
> +		seq_printf(s, r->format_str, dom->hdr.id, max_data_width,
>  			   ctrl_val);
>  		sep = true;
>  	}
> @@ -505,7 +505,7 @@ int rdtgroup_schemata_show(struct kernfs_open_file *of,
>  			} else {
>  				seq_printf(s, "%s:%d=%x\n",
>  					   rdtgrp->plr->s->res->name,
> -					   rdtgrp->plr->d->id,
> +					   rdtgrp->plr->d->hdr.id,
>  					   rdtgrp->plr->cbm);
>  			}
>  		} else {
> @@ -536,7 +536,7 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
>  	rr->val = 0;
>  	rr->first = first;
>  
> -	smp_call_function_any(&d->cpu_mask, mon_event_count, rr, 1);
> +	smp_call_function_any(&d->hdr.cpu_mask, mon_event_count, rr, 1);
>  }
>  
>  int rdtgroup_mondata_show(struct seq_file *m, void *arg)
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index f136ac046851..dd0ea1bc0092 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -238,7 +238,7 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
>  	u64 msr_val, chunks;
>  	int ret;
>  
> -	if (!cpumask_test_cpu(smp_processor_id(), &d->cpu_mask))
> +	if (!cpumask_test_cpu(smp_processor_id(), &d->hdr.cpu_mask))
>  		return -EINVAL;
>  
>  	ret = __rmid_read(rmid, eventid, &msr_val);
> @@ -340,8 +340,8 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
>  
>  	entry->busy = 0;
>  	cpu = get_cpu();
> -	list_for_each_entry(d, &r->domains, list) {
> -		if (cpumask_test_cpu(cpu, &d->cpu_mask)) {
> +	list_for_each_entry(d, &r->domains, hdr.list) {
> +		if (cpumask_test_cpu(cpu, &d->hdr.cpu_mask)) {
>  			err = resctrl_arch_rmid_read(r, d, entry->rmid,
>  						     QOS_L3_OCCUP_EVENT_ID,
>  						     &val);
> @@ -661,7 +661,7 @@ void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms)
>  	unsigned long delay = msecs_to_jiffies(delay_ms);
>  	int cpu;
>  
> -	cpu = cpumask_any(&dom->cpu_mask);
> +	cpu = cpumask_any(&dom->hdr.cpu_mask);
>  	dom->cqm_work_cpu = cpu;
>  
>  	schedule_delayed_work_on(cpu, &dom->cqm_limbo, delay);
> @@ -708,7 +708,7 @@ void mbm_setup_overflow_handler(struct rdt_domain *dom, unsigned long delay_ms)
>  
>  	if (!static_branch_likely(&rdt_mon_enable_key))
>  		return;
> -	cpu = cpumask_any(&dom->cpu_mask);
> +	cpu = cpumask_any(&dom->hdr.cpu_mask);
>  	dom->mbm_work_cpu = cpu;
>  	schedule_delayed_work_on(cpu, &dom->mbm_over, delay);
>  }
> diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> index 2a682da9f43a..fcbd99e2eb66 100644
> --- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> +++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> @@ -221,7 +221,7 @@ static int pseudo_lock_cstates_constrain(struct pseudo_lock_region *plr)
>  	int cpu;
>  	int ret;
>  
> -	for_each_cpu(cpu, &plr->d->cpu_mask) {
> +	for_each_cpu(cpu, &plr->d->hdr.cpu_mask) {
>  		pm_req = kzalloc(sizeof(*pm_req), GFP_KERNEL);
>  		if (!pm_req) {
>  			rdt_last_cmd_puts("Failure to allocate memory for PM QoS\n");
> @@ -301,7 +301,7 @@ static int pseudo_lock_region_init(struct pseudo_lock_region *plr)
>  		return -ENODEV;
>  
>  	/* Pick the first cpu we find that is associated with the cache. */
> -	plr->cpu = cpumask_first(&plr->d->cpu_mask);
> +	plr->cpu = cpumask_first(&plr->d->hdr.cpu_mask);
>  
>  	if (!cpu_online(plr->cpu)) {
>  		rdt_last_cmd_printf("CPU %u associated with cache not online\n",
> @@ -856,10 +856,10 @@ bool rdtgroup_pseudo_locked_in_hierarchy(struct rdt_domain *d)
>  	 * associated with them.
>  	 */
>  	for_each_alloc_capable_rdt_resource(r) {
> -		list_for_each_entry(d_i, &r->domains, list) {
> +		list_for_each_entry(d_i, &r->domains, hdr.list) {
>  			if (d_i->plr)
>  				cpumask_or(cpu_with_psl, cpu_with_psl,
> -					   &d_i->cpu_mask);
> +					   &d_i->hdr.cpu_mask);
>  		}
>  	}
>  
> @@ -867,7 +867,7 @@ bool rdtgroup_pseudo_locked_in_hierarchy(struct rdt_domain *d)
>  	 * Next test if new pseudo-locked region would intersect with
>  	 * existing region.
>  	 */
> -	if (cpumask_intersects(&d->cpu_mask, cpu_with_psl))
> +	if (cpumask_intersects(&d->hdr.cpu_mask, cpu_with_psl))
>  		ret = true;
>  
>  	free_cpumask_var(cpu_with_psl);
> @@ -1199,7 +1199,7 @@ static int pseudo_lock_measure_cycles(struct rdtgroup *rdtgrp, int sel)
>  	}
>  
>  	plr->thread_done = 0;
> -	cpu = cpumask_first(&plr->d->cpu_mask);
> +	cpu = cpumask_first(&plr->d->hdr.cpu_mask);
>  	if (!cpu_online(cpu)) {
>  		ret = -ENODEV;
>  		goto out;
> @@ -1529,7 +1529,7 @@ static int pseudo_lock_dev_mmap(struct file *filp, struct vm_area_struct *vma)
>  	 * may be scheduled elsewhere and invalidate entries in the
>  	 * pseudo-locked region.
>  	 */
> -	if (!cpumask_subset(current->cpus_ptr, &plr->d->cpu_mask)) {
> +	if (!cpumask_subset(current->cpus_ptr, &plr->d->hdr.cpu_mask)) {
>  		mutex_unlock(&rdtgroup_mutex);
>  		return -EINVAL;
>  	}
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index c44be64d65ec..04d32602ac33 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -91,7 +91,7 @@ void rdt_staged_configs_clear(void)
>  	lockdep_assert_held(&rdtgroup_mutex);
>  
>  	for_each_alloc_capable_rdt_resource(r) {
> -		list_for_each_entry(dom, &r->domains, list)
> +		list_for_each_entry(dom, &r->domains, hdr.list)
>  			memset(dom->staged_config, 0, sizeof(dom->staged_config));
>  	}
>  }
> @@ -295,7 +295,7 @@ static int rdtgroup_cpus_show(struct kernfs_open_file *of,
>  				rdt_last_cmd_puts("Cache domain offline\n");
>  				ret = -ENODEV;
>  			} else {
> -				mask = &rdtgrp->plr->d->cpu_mask;
> +				mask = &rdtgrp->plr->d->hdr.cpu_mask;
>  				seq_printf(s, is_cpu_list(of) ?
>  					   "%*pbl\n" : "%*pb\n",
>  					   cpumask_pr_args(mask));
> @@ -984,12 +984,12 @@ static int rdt_bit_usage_show(struct kernfs_open_file *of,
>  
>  	mutex_lock(&rdtgroup_mutex);
>  	hw_shareable = r->cache.shareable_bits;
> -	list_for_each_entry(dom, &r->domains, list) {
> +	list_for_each_entry(dom, &r->domains, hdr.list) {
>  		if (sep)
>  			seq_putc(seq, ';');
>  		sw_shareable = 0;
>  		exclusive = 0;
> -		seq_printf(seq, "%d=", dom->id);
> +		seq_printf(seq, "%d=", dom->hdr.id);
>  		for (i = 0; i < closids_supported(); i++) {
>  			if (!closid_allocated(i))
>  				continue;
> @@ -1302,7 +1302,7 @@ static bool rdtgroup_mode_test_exclusive(struct rdtgroup *rdtgrp)
>  		if (r->rid == RDT_RESOURCE_MBA || r->rid == RDT_RESOURCE_SMBA)
>  			continue;
>  		has_cache = true;
> -		list_for_each_entry(d, &r->domains, list) {
> +		list_for_each_entry(d, &r->domains, hdr.list) {
>  			ctrl = resctrl_arch_get_config(r, d, closid,
>  						       s->conf_type);
>  			if (rdtgroup_cbm_overlaps(s, d, ctrl, closid, false)) {
> @@ -1417,7 +1417,7 @@ unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r,
>  		return size;
>  
>  	num_b = bitmap_weight(&cbm, r->cache.cbm_len);
> -	ci = get_cpu_cacheinfo(cpumask_any(&d->cpu_mask));
> +	ci = get_cpu_cacheinfo(cpumask_any(&d->hdr.cpu_mask));
>  	for (i = 0; i < ci->num_leaves; i++) {
>  		if (ci->info_list[i].level == r->scope) {
>  			size = ci->info_list[i].size / r->cache.cbm_len * num_b;
> @@ -1465,7 +1465,7 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
>  			size = rdtgroup_cbm_to_size(rdtgrp->plr->s->res,
>  						    rdtgrp->plr->d,
>  						    rdtgrp->plr->cbm);
> -			seq_printf(s, "%d=%u\n", rdtgrp->plr->d->id, size);
> +			seq_printf(s, "%d=%u\n", rdtgrp->plr->d->hdr.id, size);
>  		}
>  		goto out;
>  	}
> @@ -1477,7 +1477,7 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
>  		type = schema->conf_type;
>  		sep = false;
>  		seq_printf(s, "%*s:", max_name_width, schema->name);
> -		list_for_each_entry(d, &r->domains, list) {
> +		list_for_each_entry(d, &r->domains, hdr.list) {
>  			if (sep)
>  				seq_putc(s, ';');
>  			if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
> @@ -1495,7 +1495,7 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
>  				else
>  					size = rdtgroup_cbm_to_size(r, d, ctrl);
>  			}
> -			seq_printf(s, "%d=%u", d->id, size);
> +			seq_printf(s, "%d=%u", d->hdr.id, size);
>  			sep = true;
>  		}
>  		seq_putc(s, '\n');
> @@ -1555,7 +1555,7 @@ static void mon_event_config_read(void *info)
>  
>  static void mondata_config_read(struct rdt_domain *d, struct mon_config_info *mon_info)
>  {
> -	smp_call_function_any(&d->cpu_mask, mon_event_config_read, mon_info, 1);
> +	smp_call_function_any(&d->hdr.cpu_mask, mon_event_config_read, mon_info, 1);
>  }
>  
>  static int mbm_config_show(struct seq_file *s, struct rdt_resource *r, u32 evtid)
> @@ -1566,7 +1566,7 @@ static int mbm_config_show(struct seq_file *s, struct rdt_resource *r, u32 evtid
>  
>  	mutex_lock(&rdtgroup_mutex);
>  
> -	list_for_each_entry(dom, &r->domains, list) {
> +	list_for_each_entry(dom, &r->domains, hdr.list) {
>  		if (sep)
>  			seq_puts(s, ";");
>  
> @@ -1574,7 +1574,7 @@ static int mbm_config_show(struct seq_file *s, struct rdt_resource *r, u32 evtid
>  		mon_info.evtid = evtid;
>  		mondata_config_read(dom, &mon_info);
>  
> -		seq_printf(s, "%d=0x%02x", dom->id, mon_info.mon_config);
> +		seq_printf(s, "%d=0x%02x", dom->hdr.id, mon_info.mon_config);
>  		sep = true;
>  	}
>  	seq_puts(s, "\n");
> @@ -1646,7 +1646,7 @@ static int mbm_config_write_domain(struct rdt_resource *r,
>  	 * are scoped at the domain level. Writing any of these MSRs
>  	 * on one CPU is observed by all the CPUs in the domain.
>  	 */
> -	smp_call_function_any(&d->cpu_mask, mon_event_config_write,
> +	smp_call_function_any(&d->hdr.cpu_mask, mon_event_config_write,
>  			      &mon_info, 1);
>  
>  	/*
> @@ -1689,8 +1689,8 @@ static int mon_config_write(struct rdt_resource *r, char *tok, u32 evtid)
>  		return -EINVAL;
>  	}
>  
> -	list_for_each_entry(d, &r->domains, list) {
> -		if (d->id == dom_id) {
> +	list_for_each_entry(d, &r->domains, hdr.list) {
> +		if (d->hdr.id == dom_id) {
>  			ret = mbm_config_write_domain(r, d, evtid, val);
>  			if (ret)
>  				return -EINVAL;
> @@ -2232,14 +2232,14 @@ static int set_cache_qos_cfg(int level, bool enable)
>  		return -ENOMEM;
>  
>  	r_l = &rdt_resources_all[level].r_resctrl;
> -	list_for_each_entry(d, &r_l->domains, list) {
> +	list_for_each_entry(d, &r_l->domains, hdr.list) {
>  		if (r_l->cache.arch_has_per_cpu_cfg)
>  			/* Pick all the CPUs in the domain instance */
> -			for_each_cpu(cpu, &d->cpu_mask)
> +			for_each_cpu(cpu, &d->hdr.cpu_mask)
>  				cpumask_set_cpu(cpu, cpu_mask);
>  		else
>  			/* Pick one CPU from each domain instance to update MSR */
> -			cpumask_set_cpu(cpumask_any(&d->cpu_mask), cpu_mask);
> +			cpumask_set_cpu(cpumask_any(&d->hdr.cpu_mask), cpu_mask);
>  	}
>  
>  	/* Update QOS_CFG MSR on all the CPUs in cpu_mask */
> @@ -2268,7 +2268,7 @@ void rdt_domain_reconfigure_cdp(struct rdt_resource *r)
>  static int mba_sc_domain_allocate(struct rdt_resource *r, struct rdt_domain *d)
>  {
>  	u32 num_closid = resctrl_arch_get_num_closid(r);
> -	int cpu = cpumask_any(&d->cpu_mask);
> +	int cpu = cpumask_any(&d->hdr.cpu_mask);
>  	int i;
>  
>  	d->mbps_val = kcalloc_node(num_closid, sizeof(*d->mbps_val),
> @@ -2317,7 +2317,7 @@ static int set_mba_sc(bool mba_sc)
>  
>  	r->membw.mba_sc = mba_sc;
>  
> -	list_for_each_entry(d, &r->domains, list) {
> +	list_for_each_entry(d, &r->domains, hdr.list) {
>  		for (i = 0; i < num_closid; i++)
>  			d->mbps_val[i] = MBA_MAX_MBPS;
>  	}
> @@ -2653,7 +2653,7 @@ static int rdt_get_tree(struct fs_context *fc)
>  
>  	if (is_mbm_enabled()) {
>  		r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> -		list_for_each_entry(dom, &r->domains, list)
> +		list_for_each_entry(dom, &r->domains, hdr.list)
>  			mbm_setup_overflow_handler(dom, MBM_OVERFLOW_INTERVAL);
>  	}
>  
> @@ -2780,9 +2780,9 @@ static int reset_all_ctrls(struct rdt_resource *r)
>  	 * CBMs in all domains to the maximum mask value. Pick one CPU
>  	 * from each domain to update the MSRs below.
>  	 */
> -	list_for_each_entry(d, &r->domains, list) {
> +	list_for_each_entry(d, &r->domains, hdr.list) {
>  		hw_dom = resctrl_to_arch_dom(d);
> -		cpumask_set_cpu(cpumask_any(&d->cpu_mask), cpu_mask);
> +		cpumask_set_cpu(cpumask_any(&d->hdr.cpu_mask), cpu_mask);
>  
>  		for (i = 0; i < hw_res->num_closid; i++)
>  			hw_dom->ctrl_val[i] = r->default_ctrl;
> @@ -2986,7 +2986,7 @@ static int mkdir_mondata_subdir(struct kernfs_node *parent_kn,
>  	char name[32];
>  	int ret;
>  
> -	sprintf(name, "mon_%s_%02d", r->name, d->id);
> +	sprintf(name, "mon_%s_%02d", r->name, d->hdr.id);
>  	/* create the directory */
>  	kn = kernfs_create_dir(parent_kn, name, parent_kn->mode, prgrp);
>  	if (IS_ERR(kn))
> @@ -3002,7 +3002,7 @@ static int mkdir_mondata_subdir(struct kernfs_node *parent_kn,
>  	}
>  
>  	priv.u.rid = r->rid;
> -	priv.u.domid = d->id;
> +	priv.u.domid = d->hdr.id;
>  	list_for_each_entry(mevt, &r->evt_list, list) {
>  		priv.u.evtid = mevt->evtid;
>  		ret = mon_addfile(kn, mevt->name, priv.priv);
> @@ -3050,7 +3050,7 @@ static int mkdir_mondata_subdir_alldom(struct kernfs_node *parent_kn,
>  	struct rdt_domain *dom;
>  	int ret;
>  
> -	list_for_each_entry(dom, &r->domains, list) {
> +	list_for_each_entry(dom, &r->domains, hdr.list) {
>  		ret = mkdir_mondata_subdir(parent_kn, dom, r, prgrp);
>  		if (ret)
>  			return ret;
> @@ -3209,7 +3209,7 @@ static int __init_one_rdt_domain(struct rdt_domain *d, struct resctrl_schema *s,
>  	 */
>  	tmp_cbm = cfg->new_ctrl;
>  	if (bitmap_weight(&tmp_cbm, r->cache.cbm_len) < r->cache.min_cbm_bits) {
> -		rdt_last_cmd_printf("No space on %s:%d\n", s->name, d->id);
> +		rdt_last_cmd_printf("No space on %s:%d\n", s->name, d->hdr.id);
>  		return -ENOSPC;
>  	}
>  	cfg->have_new_ctrl = true;
> @@ -3232,7 +3232,7 @@ static int rdtgroup_init_cat(struct resctrl_schema *s, u32 closid)
>  	struct rdt_domain *d;
>  	int ret;
>  
> -	list_for_each_entry(d, &s->res->domains, list) {
> +	list_for_each_entry(d, &s->res->domains, hdr.list) {
>  		ret = __init_one_rdt_domain(d, s, closid);
>  		if (ret < 0)
>  			return ret;
> @@ -3247,7 +3247,7 @@ static void rdtgroup_init_mba(struct rdt_resource *r, u32 closid)
>  	struct resctrl_staged_config *cfg;
>  	struct rdt_domain *d;
>  
> -	list_for_each_entry(d, &r->domains, list) {
> +	list_for_each_entry(d, &r->domains, hdr.list) {
>  		if (is_mba_sc(r)) {
>  			d->mbps_val[closid] = MBA_MAX_MBPS;
>  			continue;
> @@ -3864,7 +3864,7 @@ void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d)
>  	 * per domain monitor data directories.
>  	 */
>  	if (static_branch_unlikely(&rdt_mon_enable_key))
> -		rmdir_mondata_subdir_allrdtgrp(r, d->id);
> +		rmdir_mondata_subdir_allrdtgrp(r, d->hdr.id);
>  
>  	if (is_mbm_enabled())
>  		cancel_delayed_work(&d->mbm_over);

-- 
Thanks
Babu Moger

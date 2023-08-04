Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1DD7709EB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 22:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjHDUmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 16:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjHDUmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 16:42:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14AC04ED6;
        Fri,  4 Aug 2023 13:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691181738; x=1722717738;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OjRiIB0BQGce4tAJu08/b6c22KEuS4Agg/WJPbGB/bE=;
  b=ZYtfNHFPXRh353qaphJMBjC1wqIxeLNK+ER1rQnl5v9hTUXD6Z3oO6/r
   zrM48vLL0HfMrHbuxDJCSfwz0ZufNVLboQYj7dmICBlUB0CP+DasCJk+N
   Pv/jkE9NiA1jAaTlztlTBn4Ut+lri1EvCQFXoC3jFgS41G0M2Jjs6GHdY
   hU7x0QhA8SsAQ/6ewCeESBPN0mZXGBXafEnI/0iLebhMUmMpEENTok/Rb
   EjWb+I3w3N7Sq5T1kgn7AQPZY6nFL/RJOGouBKwlqmsIOioeXF9hzYFjO
   u5IxLlv5HSouJH2iAyE+TyFc2EWrJ2Ah/JV1SEmdVuJuAaqW+mLqIndDb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="373896622"
X-IronPort-AV: E=Sophos;i="6.01,256,1684825200"; 
   d="scan'208";a="373896622"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 13:42:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="759705317"
X-IronPort-AV: E=Sophos;i="6.01,256,1684825200"; 
   d="scan'208";a="759705317"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga008.jf.intel.com with ESMTP; 04 Aug 2023 13:42:16 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 13:42:16 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 4 Aug 2023 13:42:16 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 4 Aug 2023 13:42:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Si9sSaHybY58lj5SW8wSqtMpdvY2mZ2kAt+fgrB8WiAzwK7CEyHWSKVX4Mo8MQ8RJb299h+Wj9g6xANb56YVOXp1ojiNH292NPrjJZIR2nygkuQuhgQ22eIH/KlXHQP8DqWJ1NJXlOW6tBQSWFWLLGExq59sBeusjzqMPSIH4Es3w/LYiV2hT7P1ZK4ZIWl+knuXMFqXkWV8UpxAyojGKseV/eINbTIlIT7Ecg/YZsB/mntP8nLTqC1n38+eRqg884ix6vB4+5uAGogrVdu1NVNRvBWxBXlEfcGtKXZ4LQMJpMWRcnU/37ZLsiTkbdT4gz6KA+LkgyCkYAwvjAI9FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8L/oCyXO16WxuT9j42G+q4AKEiyHnCeNuBEzHqOc2Yg=;
 b=OMbK5fD07ISinRsSa25wP8/QuFq0hoE+UpSsyFAkgsww0Oma5yKorB/4lGxM3xveNkD5d34qoX4zPN9WOFJzeVPQeyINYagoyZtnz1njwZ/xD+PrwG/raS/u5aU4nwNjh13eVO4Cst3lesWrxRE7qdfW9tlcWFExUyoXqHBeFWHfWe3Zudqcad7w+/jPy6ODdxOhQYO442Mvx+eNFmvLtHKyE1/jqX7jNnvxIK8E786ZsWfJg8HTBSF6KjcYEJz1CEhY/LSh6+EAmj8+qZtzzFKgkq67b3+atWf9IquEy/BHlUqfXQ7rQcX3CMlahEtmLV+6TUjP1xievn5G9w7TmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH0PR11MB5077.namprd11.prod.outlook.com (2603:10b6:510:3b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Fri, 4 Aug
 2023 20:42:13 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6652.020; Fri, 4 Aug 2023
 20:42:13 +0000
Message-ID: <2a48c57a-ff8f-b657-8138-a5da6c7806db@intel.com>
Date:   Fri, 4 Aug 2023 13:42:10 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v6 6/8] x86/resctrl: Move default control group creation
 during mount
Content-Language: en-US
To:     Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <fenghua.yu@intel.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
        <akpm@linux-foundation.org>, <quic_neeraju@quicinc.com>,
        <rdunlap@infradead.org>, <damien.lemoal@opensource.wdc.com>,
        <songmuchun@bytedance.com>, <peterz@infradead.org>,
        <jpoimboe@kernel.org>, <pbonzini@redhat.com>,
        <chang.seok.bae@intel.com>, <pawan.kumar.gupta@linux.intel.com>,
        <jmattson@google.com>, <daniel.sneddon@linux.intel.com>,
        <sandipan.das@amd.com>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bagasdotme@gmail.com>,
        <eranian@google.com>, <christophe.leroy@csgroup.eu>,
        <jarkko@kernel.org>, <adrian.hunter@intel.com>,
        <quic_jiles@quicinc.com>, <peternewman@google.com>
References: <168980872063.1619861.420806535295905172.stgit@bmoger-ubuntu>
 <168980893158.1619861.8945141367681744527.stgit@bmoger-ubuntu>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <168980893158.1619861.8945141367681744527.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR2101CA0025.namprd21.prod.outlook.com
 (2603:10b6:302:1::38) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH0PR11MB5077:EE_
X-MS-Office365-Filtering-Correlation-Id: 05fc7870-288a-4c02-20d1-08db952b4892
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ib7IHxIvFIeDwLlykvKFDdBPOaDk9qx9J+TMFYn0lTEaUSvdtg9CIfsYw88jg7ClTEpr4Q04UFt5d0zWnA1XlyRHV1lXzljscCvDKCTSy69RkdTs98BknxGmiljbaWOZVXO51M5kMbQxluPxjAjfhJ1MS8w1i6ffOjb/zIodLqBcD5P6bBE9NjQwMX1cmop0G7Tuku1Nyx/14xq9NhyltNUNJNXbLaKBhCWhleXaeyc+xu8AVXXuzqOanszCpEpBImUO5c8hJPWM4zyE2ry8jTTDTlQ5auJW749xNcuP1G6fDxxYpNEyD+4AEYkNAtDJfKpUbX8o5vgJIXCG4yvRXnDOpxLbz1Yi2nbGJfMhTcRfC48n0jlQZJWltgzFm6TF+c/IzG5sdDgR3PHYqsMa3B9HxpcmCZYEPjGZdLYlJ9FKQNmoxjs8tHuZg0/3oIlgUDVW9dARYWAUvgwWDga7NK04rk/wS7jB/TRFIEx1ViZSRE0s1TABBLe95LiD/TiGLSBtqFV9q71hCTDkXfwfyym9kaHyPf6x1I16+LrzYp+1GJ72PhxUd8f9jbVY5gUL+ituCMPW5r1Y8WRtHnJ13AGr3esWHbiQMCFWQUrqtvpvOBZDWJXcssPHu5JHSx6DYOrDRhl2TmmWruMBW6RuWw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(376002)(136003)(39860400002)(346002)(186006)(1800799003)(451199021)(36756003)(86362001)(31696002)(31686004)(478600001)(82960400001)(38100700002)(8676002)(2616005)(83380400001)(6506007)(26005)(53546011)(6512007)(8936002)(44832011)(6486002)(7406005)(7416002)(41300700001)(66556008)(316002)(2906002)(66476007)(4326008)(5660300002)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHZFcXd5ODNNMzhkcXFUNEV1cFkzVWc4b0ZHRkREdkFDOXdHYiszaklYcWtS?=
 =?utf-8?B?T3Q2Z3JFUzZvckVKaER0Sk1QNFVRWHhxTkhkRHI4SUdGaHN5UDVsdWFWWjRM?=
 =?utf-8?B?WmJMUzVJK1ZLL2tGeTMvSE8rdXlHR09LOUNleWE4ZlM3RUlsYXdzYlU2MGpY?=
 =?utf-8?B?bCs5RkVsNlNEckhRaUdBY3NPVHpsYm5ISmZJcFR0Ujg1KzBoc1VTMVE1L0tY?=
 =?utf-8?B?ZTdvaWdHUWF5cnNPdzl0eSs2RW5aMmhEaVBCVkRFWFYwTFBjVmtPc1p0OVY0?=
 =?utf-8?B?cThodmFYVUtGZTJTUXZGUjZXYmtqc3RtdzQxejhTWUtrUlBOMU16VTFjTEFN?=
 =?utf-8?B?NnFzRXZZTGluMm9JaDE0aTVvWmI1ZW9yVVROSXAyUWFQcjhqNDRnTVlsR0JX?=
 =?utf-8?B?OENtRStEN29FSHJyWTdYclNMVmVLSVkyNnVIUzkyMTRQejhUQWhydzdGemIw?=
 =?utf-8?B?NFhpYnZuT0RWQWtnakxFT1Nkcld3OENFWnM0RWZSc1ZFZERQK1B5K1A4NHRQ?=
 =?utf-8?B?bzVYaVgzMDBBWWVsakNzOHFqNEtRaWNjS3NqTkwzTGZnQ01FUXJNV0I1M1pP?=
 =?utf-8?B?OE9tS0NpV21FTUFDSEZRbEFGQ0s4NWhMQkQrVCtqZk00Nm80cWMrNGlJUm10?=
 =?utf-8?B?RG84Z2JjWngvTmRhSjhhNlprczVlOG4vUVJCdHhCMzBCc2Y1VkF4RUZvaXVR?=
 =?utf-8?B?eEZML1d5cHloaGxhSHl6SjNXamtEMUw2aTFreE5nZUhEK0hPTTFGMzRRWDVm?=
 =?utf-8?B?OUk3RndkQTVYUXFHMUZvamNqRkVVbEZ5V1M3M011cHFzNG5Ca3lYS3hvMnBH?=
 =?utf-8?B?MnRMMFY4WHlLZmpxWGlzS1g2N0dWVkdWTnFIendpUm5UVlIvWVFaS0lvUTZh?=
 =?utf-8?B?ZCttc3U5UlVMRnFBZklRT1V3NG94RVV2R09sYXlNWEl3OEFiZFpFOWJXZWhp?=
 =?utf-8?B?WWl3MExYL2RGTjFxUHM1VGgxR0g2Wm9sOEtFdXdOTitwWUw0WmxDREQ1aTlm?=
 =?utf-8?B?WEhuT1JwWklySTFaRWRKdE83S2IxbUM5VmxsVjBDb1FUZndVVUt5MU9sL1FW?=
 =?utf-8?B?bC92UzJZc3Jub1d6V3FkamxJQ0VtWWFabC8xQ1ErZnlCZHUwNjdRQS9yWllz?=
 =?utf-8?B?OGVYWnJnMTJWWjkxRk9OR2tzeWF5M04vS3dLazRVQ3d4ZmtMbEoyTUxSY0to?=
 =?utf-8?B?Nk52OEppa2dFMWdHWjhJRTAxNytJQ0ZFWUFuU3luZ0JydER6U2dPblJKMEZR?=
 =?utf-8?B?Z1pxTkcxWm82U25VdCtmaUNVUUU5clBBN2VuVkpvSUtUSnI0eXhrU0FQVjMr?=
 =?utf-8?B?cGRDeDVjK2hqcEJxWnpEdGdLZUErdWVmRHpXMDgwOS9DdExZSFZrV2NGbFhu?=
 =?utf-8?B?REVvV05RM2NqalFNc0d2NGVuKzgzY3ZSN2VmbDVodlVqVktsNXBrZW4zTXJ0?=
 =?utf-8?B?UVRsdXdzNC83NDVNUjM3L1dFdGdSTHFralBRUVNRbTRXeVlpSTdKZVJ4U1VC?=
 =?utf-8?B?ZGp0dWxTZk9JRzh2Z3FiSUJUU21pV3NxM3Q4WGplb0pPS1Q2bUhJdUk1azhE?=
 =?utf-8?B?SGgvOG9GK1AyR2h0MXpLWTF0Q055VGg2QmZid0F4eUpNbWwvUlhiUXgxNnpW?=
 =?utf-8?B?UnVDQnYzUGVrc2hxM3p1N1NIUHY2cXJqSVNjOGFpYjlIOTMrV2RaODN6SEtT?=
 =?utf-8?B?VllXV28vMEdSZFRRbkQybVdhY0pCNEc3MmxxMlVHdEVsL0lEWERzeXRvQloy?=
 =?utf-8?B?T3UvME9OMmtvOW1zUWk5NmUrRzVNcFVDY0NiNURnZjBBekZKRURxNHpQc09E?=
 =?utf-8?B?V2pSWGdKWkRsMlpHUEpPQkFra0lleHFFdXM4bGVSdE1yYzVoSGFqbmVqUlZN?=
 =?utf-8?B?SGU0NkRpeTlKY1EyVkJLWFVndHZaUjBXYnVRUjY1S2tTZmZXclJLZ21UZVF3?=
 =?utf-8?B?UmxoaElFeFBNY2NlZzNEa3FiSjhFZWRkYlVCUnVZMWJXNkVodGZVYjZlTi9C?=
 =?utf-8?B?Q2JnaUxuMXY0dUNpSG1namxCSzBtdy9tOU9Obzd3ZEtUZkFqZG5zMjhaNFdD?=
 =?utf-8?B?SWVvRTM2ZnpDZVMza1ZldDcrWGlNeU81K2pvdmhtaXpRV21UL2NiRzdQUTJN?=
 =?utf-8?B?WDY5d1U4b2dzcXBRSkVBZVJOdVR0NVJpMlc4V2lYTXNrWFpPVTRZa2NWR3FE?=
 =?utf-8?B?dVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 05fc7870-288a-4c02-20d1-08db952b4892
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 20:42:13.8051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lDccbEV9KCtjRYl6FnCzSoJiUYP6vbqnCwADQpDIS3GrLuKoY9EovNBj2G9lc0/aLV/JYvXebFH9eaUG2ZQVPCh54BOQVvlXmiWr58v17l4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5077
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 7/19/2023 4:22 PM, Babu Moger wrote:
> The resctrl default control group is created during kernel init time. If
> the new files are to be added to the default group during the mount based
> on the mount option, then each file needs to be created separately and
> call kernfs_activate.
> 
> This can avoided if all the files are created during the mount and
> destroyed during the umount. Move the root and default group creation
> in rdt_get_tree and removal in rdt_kill_sb.

Please use () to indicate function names.

> 
> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

...

> @@ -3704,10 +3720,8 @@ static struct kernfs_syscall_ops rdtgroup_kf_syscall_ops = {
>  	.show_options	= rdtgroup_show_options,
>  };
>  
> -static int __init rdtgroup_setup_root(void)
> +int rdtgroup_setup_root(void)
>  {
> -	int ret;
> -
>  	rdt_root = kernfs_create_root(&rdtgroup_kf_syscall_ops,
>  				      KERNFS_ROOT_CREATE_DEACTIVATED |
>  				      KERNFS_ROOT_EXTRA_OPEN_PERM_CHECK,
> @@ -3715,28 +3729,17 @@ static int __init rdtgroup_setup_root(void)
>  	if (IS_ERR(rdt_root))
>  		return PTR_ERR(rdt_root);
>  
> -	mutex_lock(&rdtgroup_mutex);
> -
>  	rdtgroup_default.closid = 0;
>  	rdtgroup_default.mon.rmid = 0;
>  	rdtgroup_default.type = RDTCTRL_GROUP;
> +	rdtgroup_default.mode = RDT_MODE_SHAREABLE;
>  	INIT_LIST_HEAD(&rdtgroup_default.mon.crdtgrp_list);
>  
>  	list_add(&rdtgroup_default.rdtgroup_list, &rdt_all_groups);
>  
> -	ret = rdtgroup_add_files(kernfs_root_to_node(rdt_root), RFTYPE_CTRL_BASE);
> -	if (ret) {
> -		kernfs_destroy_root(rdt_root);
> -		goto out;
> -	}
> -
>  	rdtgroup_default.kn = kernfs_root_to_node(rdt_root);
> -	kernfs_activate(rdtgroup_default.kn);
>  
> -out:
> -	mutex_unlock(&rdtgroup_mutex);
> -
> -	return ret;
> +	return 0;
>  }

I am missing something here. Why is it now needed to re-initialize
and add default resource group on every mount of resctrl? I expected
only the kernfs related changes to move.

Reinette

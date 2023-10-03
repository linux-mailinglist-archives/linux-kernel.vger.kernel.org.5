Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15BE97B7322
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 23:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241161AbjJCVNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 17:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241156AbjJCVNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 17:13:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68810AB
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 14:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696367629; x=1727903629;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VINpv1uk5DielT/c/vKYJGiJAF7lcFUexmjYN4FMPec=;
  b=LQtBADA69q8/+Ky+r/elwYqzjmmkO0NvLyZM0GhB3pju6VB2nqlpyzRz
   J8cfPbA+LgU3j86i7SI8t6iU3LoG95Qbw2cr+PzHIDgJzJH8tnUuS7Av6
   uYbpLvSjDjM4UGdWUTPHBMt15ilLtuPNRDcDgwX27vIGpscnOdJcRs/8Q
   XK9nombUfa2N9dgdAczwSh+kAoqTJkJoWUalgLQteiudtXphoEJfcGTqX
   vJB8XGRizv2jqAC+Gr5Qz60kf24+jd942DbCqzolop/P+XLf5ZsTc3N0K
   bzk22LlOkc+Jn7UHYP1/lvDajJYTtgZMsub8Evbpiu2REtjG/L0rtrc2l
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="449473144"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="449473144"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 14:13:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="821400104"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="821400104"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Oct 2023 14:13:47 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 3 Oct 2023 14:13:48 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 3 Oct 2023 14:13:46 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 3 Oct 2023 14:13:46 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 3 Oct 2023 14:13:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g9bVU5NeOn9osvTPvEkuDINNR0zWh03spcdt98GvwBbKc2qMpqwd2N8LpOYY9Ca58QGBWvOkNNCwAeN1BIGoSmDhMFcyfSjjyHtxnid45S47EPy1bX/ei7+HItL33vqfyQwBdDSnZXFG4EzC6ow7CbZA5wQGCMZCg2hIgph8QyxK/zRHwD16t2ThPVUxR/gKBFt+KYhlhd9iT0bpxhhL3bUS2DLN4q5Kts69o8cyh1b/7Uug9BasKqWiWQkHRooCYAnFei7H0wc+6UxPvzie0CCkWstF2yJk2B18LKCVEWaw1Qc2Hf4BwrIeeR6hqYuCgo3Jf6ap/bgnZCdApKfNEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H+E1CVP8YZ5buHZ+bM6fy0ymWiWfW5j6JSUrXXhGQ8M=;
 b=LAAURNfzkcQmekDKSf3qdLFy2TepBVWpxhtWsMG+uwJwdOuTld5oVN028s5/XDhb5+p6/PwoTggsarXptocsrC0Jy+OpvxbuvswyA4q++BvkxCdXiGgZbHx6r7yN0J/+hJ2fZfSTi+QkgL+btoHWc2sV5gbUAN0kUnhfkN/yhi9AYvBtVm6cEp459OjLD0WQYpyKdu7UBDTzx554OejY9P7A7Uthtezs8mvhd/FKqoIMUlIfnXuyyJ4TtQbMtoyQfDOZIOQtB3z439GvqYz0DzZ+cZHY+FN74mHzsht/M1m6pbqBJdDFpayUra8O8/ogULAX1NzDsyPXUxAmW9APkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB7577.namprd11.prod.outlook.com (2603:10b6:8:142::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.27; Tue, 3 Oct
 2023 21:13:39 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6838.033; Tue, 3 Oct 2023
 21:13:39 +0000
Message-ID: <3f448b5e-de75-35fa-02ab-7cbd37389227@intel.com>
Date:   Tue, 3 Oct 2023 14:13:35 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v6 08/24] x86/resctrl: Track the number of dirty RMID a
 CLOSID has
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        <carl@os.amperecomputing.com>, <lcherian@marvell.com>,
        <bobo.shaobowang@huawei.com>, <tan.shaopeng@fujitsu.com>,
        <xingxin.hx@openanolis.org>, <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, <peternewman@google.com>,
        <dfustini@baylibre.com>, <amitsinght@marvell.com>
References: <20230914172138.11977-1-james.morse@arm.com>
 <20230914172138.11977-9-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230914172138.11977-9-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:303:8f::18) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB7577:EE_
X-MS-Office365-Filtering-Correlation-Id: c6aedd7b-a6e3-4bd3-27dd-08dbc4559d26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RRp0sH9N1xr/m9JYnvfE9isaK5yw/DnALXI44NwBPTJRiqo+lJCOPfbLhkiqdIiz4WO9OWPrFPDE74H7p7Nb+TQJVXH9PwXBQfpApCPAwc1qYdRAdEDlH6O92h4SHoEadW6EvnOM/lWs6qVON5wRUZ1mefD2Z8B2EwcnhMo62jyUA876A0WZ8PLyencFrqv0onwN0LsWZ2X1XqFJpevkku/cFe4LHLPcy/uxpu7gLZSHi4P+JoU0geYASrfu89nqXLjx1Oq/By6aWDcoDGC3sTO8nBZeiLQYk83h3nlSFJ4ATF8Ur20C8cH8eubWrW7pch5rfy5x8ywaQeWdz3HG0NwYN36itfEDRPSlgHjr/coaMFzSSkdNyYGXxexhUDuGfa/iCEWRj6Dih4GUf6zGEfQ6Eewu649Hl3lhkjcgSr5YY+dkGfsw9V8Z55RbmE68xX1S72FLFMosDfc4cTm0BVOdvXKUuAG2UrIcLh/z+d6Dg/Anyn8hu/G7/5/zXlxIN9fmziamIExhPyguRHu75qeG56dOSYYECi60Z13p6OKqioG8YVDZ1D+W8O5Yn7EyVnKbb+8YEwjF+3RCbeUjGftS82HtaVIoPiLX/EuHthpZ6gaujoMVYBLZeYNgSILQFaCEm2lBpki7C8lDljxx+sY3VhLuDA65IHTWsaum0SY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(366004)(396003)(376002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(66476007)(66556008)(6486002)(66946007)(54906003)(2616005)(8676002)(41300700001)(8936002)(4326008)(26005)(36756003)(478600001)(6666004)(86362001)(83380400001)(38100700002)(31696002)(6506007)(82960400001)(6512007)(316002)(53546011)(2906002)(7416002)(31686004)(5660300002)(44832011)(14143004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFdoMUtiN2JyRm4zS0hwTU8wdzlpdkNUUzJLeHkyRjRjMkM4Q0VnVFJubU50?=
 =?utf-8?B?ZEM5NXoxSUExcUFQdENjZWdBMHNjMy80VHZhOGJVbTJXeVY2M1pnYmRBU0ln?=
 =?utf-8?B?Z2lxYUdrdWdaR1VwTHoxQy82ejhncnVZMVhaNERNY3lXSHZZc1h3YVRsR1J1?=
 =?utf-8?B?cGRTK1Y1emsrRTJhU1gvdDZNSE9vWnhoRFRWdVljOUdYT3gxWnNLQkdzZnRY?=
 =?utf-8?B?V1VldTZ3WWNwUFMwT1RrcEwxU1RMVDRWd2cvYldDY0R2dlFpbmJWd0UxQ3l3?=
 =?utf-8?B?N2R5ZWhJNGxoa0FPRUttNE00aWt0eFRJM0dGbmwxclY5Wlhad2Q5OXkwMjhK?=
 =?utf-8?B?eDJCZHpNWjBWMVRpemk1SGVkSkE5b2dXY2pFbFdqZkNBcWRhWEtRK3pyK0Ja?=
 =?utf-8?B?UWMwdDZ4VldTcWZIOGsvVFNyUE9VU2U1V0trZ0tORHdtSURIRjZuSE90QUE4?=
 =?utf-8?B?dmRnRmQxQjVKVUtubC8rVFVtZnlrUWJkVXNqUldSUHhvMkVlZWFvdFBvOFI2?=
 =?utf-8?B?YVZheFY1NEVacitBVUdnRmxTb3FUUUtVdVY3Q0pwa2c1LzV0T0lja0tNc0ln?=
 =?utf-8?B?SlhhT3dPNUs2NUkvOHhBeXU0Qk5JN25qTkxmWThha0pCa0Fac1FzR0gxTlFR?=
 =?utf-8?B?TWVTWVlETGg0OXVvd2xNM2lTWVJKTC9RZk1TaDFrVFZXa1VXVVo4MFA3Z3ZV?=
 =?utf-8?B?U2JZRERSWjV4cSsxK0g3Y2JhTk8xUTk5S2c0MXVMVVdNUUhldm5CU3BqS01Z?=
 =?utf-8?B?WGt1QmFOeDlRQ3V2dWlJMzA0WlR0QlIzZVB6SzlpVmdTN2hSNzczay9mYnNQ?=
 =?utf-8?B?VlhYMWVva0ZqNjBCM2N2VmRlcDI0NHE4RnRTaGRYMDNLR0ZEbks3NDNOQVA2?=
 =?utf-8?B?NUx2YkVnMkt6c21naElmUkZKeVhVODBLVWRHZTJ3OFh5WDliQ3ZaaktIVUdG?=
 =?utf-8?B?ZTc5Y2dBUlFLS2pEYVVoSEVXeDJtYzRsdU5jK3dORk5POGo0bWw1SFRXTDBx?=
 =?utf-8?B?MGpvVlplRU1ncjFJak9ScmtITkFZdlRldWNPN2wyOUNvL2JtVWNWR0k1QUpk?=
 =?utf-8?B?NVI0TmVKTUxNWUxlZVNmNGs3SlJrREZUa1FXWldKa2NlZEExNzJDZCtFRC9o?=
 =?utf-8?B?N0xpYUpud1NtNFVBcS83VDVqdGRtQlYvNVhxTjVKc29JekhIaWtNR3VqSnNZ?=
 =?utf-8?B?SnNPdlV5WXNsbWU1ZlFsZmRvS05qQ0ovSUhiUjJ3NUdadEFLbENBUU1FbTJ0?=
 =?utf-8?B?Sm5yeHRnbklwSVBsU0tDcmMzN2pMbkE5OVlvbnAyVWFQRHdwZFE5eGhjdmxj?=
 =?utf-8?B?cU90RmVtUEIxSmVUbFYxS01ER1duRUpWRGVmOERYYmdIcEhUNnF1ZHB4cDBP?=
 =?utf-8?B?RmowTmNSL2UxY054TlNueXJlYkJQazM1a1dKamxhL2ptZ1lLN0hlZWNLOHFq?=
 =?utf-8?B?ZVFDanZnMVgrdkZIdTV0Qzc0Q3N3MTNHMFdyTktncGtNWWVtOTMwaGxndkpk?=
 =?utf-8?B?VGg1aGlrUnd0b2c5anVVdDN5ckRkTHhNWnpUWXdQV0cxeGpNbm5TalZBakxQ?=
 =?utf-8?B?SWIwWWFLVGZ4dGk5bDBHTTlLYmdDNENsNGY2QVdUTXhESGI4S0FjdUszbUtW?=
 =?utf-8?B?dENsWGEwME1hbU1tYVl2eFY3bmIxclJ2WHVQYytzd2Vyb0t3MzdUenJCV2lh?=
 =?utf-8?B?VVFIellNZXg3UUdFc1Rkbkhub2pRazdweDZYNXI2ZlZ5NHZGODlrR05kWUQ4?=
 =?utf-8?B?eS9MSHF5bUExK0FvMHZUa1NUQkNwK2lZbDJmMjQ5bDhDaUtPbFRzRnM2djVG?=
 =?utf-8?B?bDdYWFNGN0V4RXlUK05rZzN5L3hYcWczSjRjSWREQUF5NFdEb3NvZnNBdTAw?=
 =?utf-8?B?SDRNMXIvMEgvSkFDWHRqSExQTzl3RTdrTzhheUtiWFRRQVZWa1IwMGJmUk1P?=
 =?utf-8?B?NWdBOWhOY2JLTlZxRTFyYUppZFRTM0VWLzI0YXZINGJtQVVJbWphTmpJbkdE?=
 =?utf-8?B?SlRKRHFmMEpHUkNxaExxY2U2bWxyL3VjS3ZGVTFxZ1FzZ2dyTTB6Q0hNYUl5?=
 =?utf-8?B?Y0hGLyt4QkpHUmlOMk16QXhTczk1RVFVb1licmMxY2RJemdQTXRYanpNRzVC?=
 =?utf-8?B?dWlPQ0VaQzltcUdPcG5TUE53N0xpbkNiM0ZmQUhuUVR6UFVzc0Z0NnJIUUVU?=
 =?utf-8?B?ZXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c6aedd7b-a6e3-4bd3-27dd-08dbc4559d26
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 21:13:39.2670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IF+7D4yzVPhPF7sSLyHlZO2O3eDrvlP4lW6Vqh3XbmcPaGk4W4xIz8S7dzM0U32xtA5S75vfhwlmPt8i0lHC4CzXUOaCG7zpi5XlXCjK19M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7577
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 9/14/2023 10:21 AM, James Morse wrote:

...

> @@ -796,13 +817,30 @@ void mbm_setup_overflow_handler(struct rdt_domain *dom, unsigned long delay_ms)
>  static int dom_data_init(struct rdt_resource *r)
>  {
>  	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
> +	u32 num_closid = resctrl_arch_get_num_closid(r);
>  	struct rmid_entry *entry = NULL;
> +	int err = 0, i;
>  	u32 idx;
> -	int i;
> +
> +	mutex_lock(&rdtgroup_mutex);
> +	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
> +		int *tmp;
> +
> +		tmp = kcalloc(num_closid, sizeof(int), GFP_KERNEL);

Shouldn't this rather be sizeof(unsigned int) to match the type it will store?

> +		if (!tmp) {
> +			err = -ENOMEM;
> +			goto out_unlock;
> +		}
> +
> +		closid_num_dirty_rmid = tmp;
> +	}
>  
>  	rmid_ptrs = kcalloc(idx_limit, sizeof(struct rmid_entry), GFP_KERNEL);
> -	if (!rmid_ptrs)
> -		return -ENOMEM;
> +	if (!rmid_ptrs) {
> +		kfree(closid_num_dirty_rmid);
> +		err = -ENOMEM;
> +		goto out_unlock;
> +	}
>  
>  	for (i = 0; i < idx_limit; i++) {
>  		entry = &rmid_ptrs[i];
> @@ -822,13 +860,21 @@ static int dom_data_init(struct rdt_resource *r)
>  	entry = __rmid_entry(idx);
>  	list_del(&entry->list);
>  
> -	return 0;
> +out_unlock:
> +	mutex_unlock(&rdtgroup_mutex);
> +
> +	return err;
>  }
>  
>  void resctrl_exit_mon_l3_config(struct rdt_resource *r)
>  {
>  	mutex_lock(&rdtgroup_mutex);
>  
> +	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
> +		kfree(closid_num_dirty_rmid);
> +		closid_num_dirty_rmid = NULL;
> +	}
> +
>  	kfree(rmid_ptrs);
>  	rmid_ptrs = NULL;
>  

Awaiting response on patch #2 related to above hunk.

Reinette

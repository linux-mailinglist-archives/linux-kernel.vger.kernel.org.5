Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75D5776C2F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 00:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbjHIWdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 18:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbjHIWdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 18:33:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA8AE2
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 15:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691620416; x=1723156416;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CtZ7x7AbrbD4kZOCJJ8kF5JAY+W9N0VLj/M+cUsnsx4=;
  b=jrNafHvLA3OknSs5OfmGFB5AIZKMDu+d7XgdVLXRTKFDk+1d93JEjWCN
   L8jbUK79RYZ0VS0slQWGB9SZN7wJH/Fof7L/bGXHVqM3Ma+pdbY4Fq3Hi
   Hoh6oe/2KvoBII1AO/p4X99nqH1vetFF7l+f+0UPvEM4curBXrduw8GyP
   P4CDckTLqo68khFJ/gYEPHBh6DMP6Mf2dAUVIDBHcvWR7jzKBe3wtP4al
   nTDDhdybAGPDZ+XWV2E6MPN9Am4nFrV9IbGiUfHeo3QrQ2Xt+C1jOpCOg
   yOugz9RwYA7RoqUFJBEO2etv4GobL/94m8Y+G2cjzjwBQJUFOKM8h0hdR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="356212322"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="356212322"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 15:33:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="797364881"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="797364881"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 09 Aug 2023 15:33:35 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 15:33:35 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 15:33:34 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 9 Aug 2023 15:33:34 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 9 Aug 2023 15:33:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GKGAIBY4nzrWknhXX6pfxLR6LS/g19CDI4GAXdb5Us2yTWhSAFd0/k/qG/p1rGNRb0LvmSAnWc26YB3LexlUInvYx0esLvKzqAzBDywMStfDN1UulWoyc3RtYydSAwWBE+EPtiwccY8Fu5NJU2e7rsp6twHLW5F14r8+BjFWQkAHd9WDmIq4J+s1MnKNXiM4xBv1rd0CiJkiLq65cHxjS9cOwJUYuhIcgsXQItDLWyFyJfYHqtBgssMNVa2HXG6N9szYpxskzR7COxdE0GevUBtfNpjiGE+FPvfG/g8HviBF9XMvDsfwflgdlC0SnjxssNjJ9yac9RToyMy4rtIDVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=swd1dihwqCe3pDHTAWD9qNtIRugRRsgbDZa75qvemUs=;
 b=m9Bpe+yov5VE6stmRUPMWU57TlCYXVJEQi5zBlhu0aLLR8kFsaky4cRnO+VLLZlNBiR5CXmblb5xL3TCO475VIeRca8zAsl4Q4mQ/M2UMOhpkDmTUEj5MN+JitluZEwDlkoHRZyCEFqhUNz/gv2pHkg6qxKoBjUexMpXsX5H/bn+Fo7MzGFs6ln97KTJ/t1etJcjE+O+SADfx+xkgkpDtBaSK7mxwitZ+BlzjZdoupNGHqxXzvyMmN/Chfca5ptt+5kJfjN5H1jNWlAl5bPvV6uV3c2qYsNRB2rEINGoFw029aehyhtC1dYy5CjCqxJqAng33QnikZb49tPZdNo8bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA3PR11MB7413.namprd11.prod.outlook.com (2603:10b6:806:31a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Wed, 9 Aug
 2023 22:33:27 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 22:33:27 +0000
Message-ID: <f7c88827-fa50-0f5d-4a9c-ef147e8820d3@intel.com>
Date:   Wed, 9 Aug 2023 15:33:24 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v5 05/24] x86/resctrl: Allow RMID allocation to be scoped
 by CLOSID
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
        <dfustini@baylibre.com>
References: <20230728164254.27562-1-james.morse@arm.com>
 <20230728164254.27562-6-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230728164254.27562-6-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0235.namprd03.prod.outlook.com
 (2603:10b6:303:b9::30) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA3PR11MB7413:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ed4f10c-2c5b-4751-747c-08db9928a643
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w5qiKZlj2UpbQXkIDbRp2BEzIS0TA60w9BZ6CUGyUceW4nCVe5BqcnP//hMQuTQxwzmbP5gVxPAyFRUaN070VFMjs86MqEjYJxyU8cPlAf8JU1zIrH8tuK65KAldF5vNZclSy6VvdVWMErdvzHHwEEucV/R8ucR3YI0XMkBYJTMkdAl1Q5HdCQ0tPza2SDWLi/LucwKU1rDWy+6X3sym0M8EQpf9kQCmdUDQt2GvFm9I1GOzFUzaguw9uIMrLmHjDSBBcj7mrJkI4NaWFj0X5ThM0zc8HhS9dm4F/AOVpSvu5SYKZoQAypqsxlzpknYFO+vA6SE1lzm7+gyYqlKgyzMNoFHqYmOy51t8bBprV9BTaWEE9RyXLYf6A+bW4+O7rwd8yp02LWXTq5KG9LqFR8Fg2WOmWW50c7q9Hc6e09qDEsheIiW729cI+qSLtoMFLyu0oIa3aSG15+zJkNToGE1N6ShgPXI6GAk9KDmu6imy+zzH6p/ubGhMtDIS+FznPQw5nh3b7u7ileCem0LDJAquPYTBSGw0yqVC92l4FaGHrWMebxFkVXx0HSwTcGpGjkXv0w5XrsSKITS60UKhhhl1bl4iepw8hSMEJ7HyxH5+m2iUziwfFcl6U3UJ07BzVLCQnP3ykuzsFlQ8NvegFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(39860400002)(396003)(366004)(136003)(186006)(1800799006)(451199021)(26005)(8936002)(41300700001)(2906002)(44832011)(5660300002)(31686004)(7416002)(83380400001)(8676002)(2616005)(38100700002)(316002)(53546011)(478600001)(31696002)(86362001)(66556008)(6506007)(6486002)(54906003)(82960400001)(66946007)(6666004)(66476007)(6512007)(4326008)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVBYOTlmbjlocGdVb0lJYlY0SjlDSkpHcHF3UnVsQmdjcjFlZG8rZ2ZhMWgw?=
 =?utf-8?B?T2F6Q1h5Z3ZQTW1kdUdGVFQxRmgrZ3J6Z0U3bm1DUkIxbjkrQjV6UzBmVks3?=
 =?utf-8?B?RlRhTkNxRXFzdVBxc0ZjcjlzRTgzWlVZWE8xWTR3L1lSalpLMFdXQXhVbE0x?=
 =?utf-8?B?S1hZM0dITHFaWjI2Skdld0tETXdSR3ZwQ0hrYkdGaExNbEYxRzNvRW1TQVJn?=
 =?utf-8?B?Z3ZZQ2lOb1I0VWc1NWJLeU9OMmNlaHc4Q3dEZTZwTnFleDNQcThSRDlmdlpm?=
 =?utf-8?B?b0JTd0NCRnZLYUdJZHZ3UExHQTQvN0NQd1JsQzZ1MVo0V3FIUkdaNlpzSHNE?=
 =?utf-8?B?U2lkSmJPWUFQWVJYbUdRcE04dXVlUCtnVzNmUTA2TmFReFc0cjE5SHQxUkVO?=
 =?utf-8?B?bmhsM1hIeDhOUXIvTy9yTlUyMjk5UFpvaWpTTkFPaXkrWUtkTFZwS3VIU0Qv?=
 =?utf-8?B?RzNDTWo4dHZVSXB0QkFGVU9acVdhclVBaTZwN3BQZHRZOHJ5dDZKRE5kRDdX?=
 =?utf-8?B?QkkwcHF4OVBOTGVMTjl5MU9SeWs0a0oyZTlxVDgwOVBRcDVnVDl3Z0kxamdW?=
 =?utf-8?B?elZib3ZtWDVSRzdPVTNhb3l0WFdwOFlDUTRLYmRwQzdjQVZHaUxXckMwd2Zs?=
 =?utf-8?B?OHc2STBGWDRVbHZRRjNRa0dXZEdKOUpMQ2h6bUVaYVQ5ZVlVYW1nWEdMbktJ?=
 =?utf-8?B?N2RQUzBuUTQ1WVh5RDltUzJBQVlUVUZER1pGM2E2T2Jic01laWVkaWtEK3pq?=
 =?utf-8?B?Y1VtMmRoV01Pek9SYkxqN2ZUUENnQzIyM0NqNnJOS2JNaTNkRDR0MGhZT0dU?=
 =?utf-8?B?ZU9ZK1JKVFFSNVgzWXU1YmFZRWNITFc5NzZSV1lQdzYyK3RvdkQzWE83N0Fa?=
 =?utf-8?B?aVQ0Z1MvYndRL3ZZbWVONzJZbjdUWFoxWkNoY0tvMEhmNzhETlQ1U2hXK1FY?=
 =?utf-8?B?cDdWc0ZqdWtpbmtSYnpGWWVDdU0xclFOZTJDMWxZY2dxUWNmTng3REJUYXc5?=
 =?utf-8?B?WC8yQmNvOE91NGM1TUkxS1V1NjNpZmRDS0RETXY5SmxyZWhzdm5BYWVhTU54?=
 =?utf-8?B?VHRPOCt2M0ZwSUZzWUpiNlpzRnRJaUV2cVNVOUowOW1EUVlkUVlxaWdEcXBJ?=
 =?utf-8?B?Y1p3V29WdGNoV09PMnRRMzhHQi9GckNZL1prSmlBSC9MTU9Sby9HSEFrdkZs?=
 =?utf-8?B?M2w0bmpZV1pjWkZiMTFmSG1jN3VUWE90K1JzZTcvcVNxMTk5bmF3ZWo2RVdT?=
 =?utf-8?B?bnhEeGRSejZzemEwT3dYcDU5L3RjbFQ0c1BNNXNWZS80QVp0cisrYlFDdWxM?=
 =?utf-8?B?UVZiWGMyMVFNbnZWRk5pZkx1QXBhU3JNNnJoR2ovZDRaRUsxY1NMVnBSWmp4?=
 =?utf-8?B?NFFNZ040YmtTbDY1ZjdXMjR6bGRPRUc4TUNwS0hqUDdHUW5uc3RObE8wOTNJ?=
 =?utf-8?B?TmY5dkxHbExDUjA5MHFGRjBGd1VncWlQUlphMWJzODNmV2JWUDkvb05Fd2FM?=
 =?utf-8?B?bWRCUElmNGdER2lIaW5WRkJyYXVuWkp6NkQrL1ZVNHFHdFNSNUNDOEUvLzZM?=
 =?utf-8?B?L2I0c2h3Y1huN05xZ3daN2NhYjV1NytvcWtJN0cwam1wWk4xemRTOEpNc3pP?=
 =?utf-8?B?SGIzeGtKMW5NdnRkRkR1cUFkZ0N6RFkwQW5BblBmK0RZZjVwRkxYbUxJdmpX?=
 =?utf-8?B?TkdHNC93cStaOU9Id2hHZG1RQlFSdDFmYUJUakRpQjB0VHUxQjVpV3B0dFZM?=
 =?utf-8?B?MHRFOWY3cWhrY2VTZkRZdFkrRm5CMGxFZjVDQ1lnRDI0MVZiZEo5ZHhudmls?=
 =?utf-8?B?T3pBTUtUZTFaTE44dkF0ZWxIemNOUDBTU2ZuNWQ2aFNUMFVQdWhJK3hDNEdB?=
 =?utf-8?B?bFBCaTF6ZUE0NisvRmhZRlVxSnN4YXBtN1NhSUNOYnhCVHJtU29QbU9DSito?=
 =?utf-8?B?MGw5dFFYUXIyUGFIVGpDYlRHRUFaaDVFMklHN3Fmcm9QN21tWVhBQldLRjRp?=
 =?utf-8?B?SzRpZTJXR2xtMVE3VjNuckFiM1pxZ1RqQXFvRTVlc092QTdncHpIQXl1WW84?=
 =?utf-8?B?UXBPOGE3ZWdxZTBkZUV4eVhTV0x3aWtHdDhScGMyQ1d6M1YxRVZQTnhVVVo1?=
 =?utf-8?B?SGcreUhreVFmSWNPbjM2MFYwR3A5RmFIMzVZQWZBQlR5SytseEs2MjlpNlZ3?=
 =?utf-8?B?NGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ed4f10c-2c5b-4751-747c-08db9928a643
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 22:33:27.1753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rrr8csfRiGOy7BXsVyixRCH2J+Y+Igv0DeEhPYuE1avHqOv6j8CzMQYSC3cyAvnuX3gFDvarAfpH1beNYQx7edc/xL4OG8qovZWZo9aDxas=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7413
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 7/28/2023 9:42 AM, James Morse wrote:
> -int alloc_rmid(void)
> +static struct rmid_entry *resctrl_find_free_rmid(u32 closid)
>  {
> -	struct rmid_entry *entry;
> -
> -	lockdep_assert_held(&rdtgroup_mutex);
> +	struct rmid_entry *itr;
> +	u32 itr_idx, cmp_idx;
>  
>  	if (list_empty(&rmid_free_lru))
> -		return rmid_limbo_count ? -EBUSY : -ENOSPC;
> +		return rmid_limbo_count ? ERR_PTR(-EBUSY) : ERR_PTR(-ENOSPC);
> +
> +	list_for_each_entry(itr, &rmid_free_lru, list) {
> +		/*
> +		 * Get the index of this free RMID, and the index it would need
> +		 * to be if it were used with this CLOSID.
> +		 * If the CLOSID is irrelevant on this architecture, these will
> +		 * always be the same meaning the compiler can reduce this loop
> +		 * to a single list_entry_first() call.
> +		 */
> +		itr_idx = resctrl_arch_rmid_idx_encode(itr->closid, itr->rmid);
> +		cmp_idx = resctrl_arch_rmid_idx_encode(closid, itr->rmid);
> +
> +		if (itr_idx == cmp_idx)
> +			return itr;
> +	}
> +
> +	return ERR_PTR(-ENOSPC);
> +}
> +
> +/*
> + * For MPAM the RMID value is not unique, and has to be considered with
> + * the CLOSID. The (CLOSID, RMID) pair is allocated on all domains, which
> + * allows all domains to be managed by a single limbo list.
> + * Each domain also has a rmid_busy_llc to reduce the work of the limbo handler.
> + */

I find the above comment to be contradicting - it talks about a single limbo list
yet there is "also" a limbo list/bitmask per domain. Should "single limbo list"
perhaps be "single free list"?

Reinette

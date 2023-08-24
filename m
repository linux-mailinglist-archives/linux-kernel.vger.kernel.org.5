Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542ED787BC7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 01:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243988AbjHXXDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 19:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244009AbjHXXDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 19:03:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3B61BE5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 16:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692918178; x=1724454178;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=W9emtYBeRbLr1ZcvwZMlMiAZ6+z43TlAndZ8F5i9+uY=;
  b=lvQlduL25A9rqPAA3TcwDX090iuzgYUNI68E64TC0WvjKGG+rp6r34Db
   vs5Br3UtyfCGfsKRilLlqHyy+VZm8+OrPxGJsV0aX3fM9sF7qsjVJf3p4
   pj/Xg5/HcCt1aiNS7AvHiBPqUDHxBnMdbVmmCDhU7Pss8SXH45lN17gTX
   LUTGD/U/Hn3TuPfeDFfGVn7Tzkn0SFHsqlhWQd82g6POAWVcOnfSwlHCc
   rn267ZGSh5yz0Leu+eGnDf1lee63j3Ordz+3+IZpMakcyXK9J3bkgjhUe
   zigpHIDfGSLBITZeDRwrp0nZE8vYUY1QEhV4U2CN7vxzEK758wAhxmDkb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="460938619"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="460938619"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 16:02:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="730823163"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="730823163"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga007.jf.intel.com with ESMTP; 24 Aug 2023 16:02:56 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 24 Aug 2023 16:02:57 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 24 Aug 2023 16:02:57 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 24 Aug 2023 16:02:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jDrQq18FWmC2DIhiLcpaqDWzI6+jAhhA4tO6U0i6j8ncf/XooOG9wkUDP4i7y+qWQL6Iw9Oegof5oh1n0Fp2XzzQ4lhN722nt3G8CTu6r1e3R8lqZ1GjZRl9V/BriktOsJ7yZmxPbD8eHR3sN7i4JbDhVDQdDFpByx4uQdneuwjiY4sQZUGzxdeY8hb/0Flxxs95CK2uhG+6gDIZA07R1RI28vwLkzDUd8cuGe2F2s3hQSocqZLiYUfIjHSYs59qKAtNxUX6MgeyweYHBBtN7YftTK7vRCapHgXZ1RCcnFO14L2cETwLcbckpkOUblHoS39gghP2DVgBjEqwqgEz/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IO5zZsUqaje7VC94Ymhyw3TrqfcFinQPJu0oB4wj3dE=;
 b=YIsKq/m9StUGphiiUs8jRXxlZdp1dvMwTjqx5DS6b8Ph5tUoOX0qdVzMf3IKkMwhrYM3NXIIQ6rYqW9OqSBQEazuNseb9S4tWflCptk/TGzS7jaMrl2E727FXDlbp2U44e/WVUubGzDN8rFUyfWKz4ut0tD1r6QWqYuOlRGKmb5ByWpUbPFsDWfLZmolAQO1S5VfTZMWJ7jgwYkddKNva+DQqvpSmHGRrtUDr6lmzKy/81CvIkmDSLRICf+PR+tz4Z6HoEWENYSWjwC8kb/+M3WBjWrRlpujPgzjagMOhR6rWG+zniKCfVbNs91hnghKXO0uZH59GPrxQpuIIW/3kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SN7PR11MB7137.namprd11.prod.outlook.com (2603:10b6:806:2a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 24 Aug
 2023 23:02:48 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 23:02:48 +0000
Message-ID: <5c0a3df6-3b1c-ff99-194e-3c7901ffa716@intel.com>
Date:   Thu, 24 Aug 2023 16:02:45 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v5 14/24] x86/resctrl: Allow resctrl_arch_rmid_read() to
 sleep
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
 <20230728164254.27562-15-james.morse@arm.com>
 <4a0f777e-5dec-296e-c326-61e3630c3608@intel.com>
 <b842c00b-7537-a14a-1a2a-a9a17b98bbce@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <b842c00b-7537-a14a-1a2a-a9a17b98bbce@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0244.namprd03.prod.outlook.com
 (2603:10b6:303:b4::9) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SN7PR11MB7137:EE_
X-MS-Office365-Filtering-Correlation-Id: 76569f1e-362d-44d2-f3e4-08dba4f63c28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lfLkNbEqJcwO3glnOtxXTpGmKaIcVXGAv/zDCSll8FPIJP9rJWhkW9GZIryttfLVf+1chci4aN4KX9qP8T7Xl/3+nQDBUKoy6VArZlWxkuTgQu+SCrHMdqTfA0H9T5i3yQOm05yLhkSd8t7HAMjwOlCDhwCSlnruT8EbW2OSdxmxodevUoeNnudEohoZo2mBsNffQyiQHSMdVV2brLoHn9TtN4XNwQsLSxgEsQGj992cMK4YAzBUp5LC9jy5R/wnay8QHiY4+Cog4zZmPu48Rd2MUcNEIoJOjn1IiqvbBmW5DbLdSSJOq3uG9kEN0W/0Atna7bMmt8iKv/zbhnY4d5vcV343sqNnZZqp2pKOjf9CfgIAMwVc0gYg/yzDY5CvPfrTs1oj3FyirYLkuK0oqTZmMzAOv57qVU51yD/w4R2cDq2A904jxOayRKIBZ26f0772vyI7U/OtyalirKowp3fNjeo7UBc1l8QuzcsQ2/flbV6XKkmPXvasVt3ry4rS2l4Bd0jiUAfI5+PzW9P4KIRBWBrD34GcoV3iAfK9ModwkBquy2VJZuhCjvlW8qx5fb7QAgFq0Yj/W1MOu9JfN6VnkmJ66xf2P+u6S4xaqqbkxEwFzAkGCUNSL6w5LE+2UrjlgjfuYXQFCFFzpSNxng==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(376002)(39860400002)(366004)(451199024)(1800799009)(186009)(36756003)(86362001)(31686004)(31696002)(38100700002)(82960400001)(44832011)(54906003)(66476007)(6666004)(6506007)(66556008)(6486002)(4326008)(5660300002)(53546011)(26005)(316002)(41300700001)(6512007)(8676002)(8936002)(2616005)(478600001)(83380400001)(66946007)(7416002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWhRbE9pVG0wOEJxK0lHYytWbFZOL2Joajl1aUdtbm1TS1dpejhuNVdqaC9G?=
 =?utf-8?B?V2NDYWlIWkpzVDZTRXc1MkFzYmJzS0pvVWIycHExRGozUmdPeStwSUNxdW02?=
 =?utf-8?B?LyttemhyN3UvY2xhTGtITUtoVTg0Q3hmT1lJVlJRZ2dhS3VuTllvWmEwYjNI?=
 =?utf-8?B?VGpIeGlaRWdHb2NlZlZ1aCtBYmNpUDhJazVzRmxsYnoyd1Vpd3QwbURJM1Ex?=
 =?utf-8?B?d21XNDJ3d0FzYkY1Skh0T0s4WXZXeEg5UGdta2tXL3htNUp1aTc3VFIydzJh?=
 =?utf-8?B?RENJQlFzbXJ3YWJwSzNEZmpDenFzZEhTL1Z0L0NINEdEUG1VQURGZzl5V2JT?=
 =?utf-8?B?eHc4SFNpMURKWUpSWDB1UnMyN2tteTdSNkdWUXFzQlQ2ZDJndGFQM3FzNFZI?=
 =?utf-8?B?aHpPWDFNT0lPaUFIckg2V3Z3SXVoblpjVytyWTNsUHBranJuR3RvNmZ5WFNj?=
 =?utf-8?B?Mm82Y1hGeC8vQkpLd0t0YW1qcWNmZVdoajdWWUlpYStyYUxJRWQ0c0UzTndl?=
 =?utf-8?B?dWppZGJic3oremk4aTI5UlJUbTV6YnZCRExSbmQxbFM0c2p6bGUvUlVWWjVo?=
 =?utf-8?B?ZGJuMWtYclpMYjZBWjVvTWdYbVlBQ1FvN3dFUnNwOW5tUjRRRXJ5WVVSZ2gw?=
 =?utf-8?B?U2ZwS0F0RWtsTVJ5VWMyMTI5cWpDWFBueDNSNWRnZlhTY1FxUGJFa3RwZXhx?=
 =?utf-8?B?UXBIL0p3NU9PQld1RmgyTTE3K2ZVSFN3THJ5QnIzTkJOMlNjeGVYKzhvbU8w?=
 =?utf-8?B?Yi9ob1JpWkxnSml5OXAwY213QlJxVjNHOWRha1VBb2ZONng4VG00MzQxazVM?=
 =?utf-8?B?NnFzcWhDdTdyd284UGQwcUFhUWI3VzdpS0RPZk8yRVJWV1Bubk5tLzBNbnFY?=
 =?utf-8?B?c2N2RW00N04rL25sUC9kWGI5dnV2K0R2OGhqUTlRZWhlZGc5cjE1RFd6bHNr?=
 =?utf-8?B?VFZDREM5QnMybzZPUGlCN2pvRDZIUlY0aGZvdDI0ZnNsdTNhc0MxaitmRTk5?=
 =?utf-8?B?YXl3empMVENXNExsNDBHbU9BSi9td1Z0TjAwc1d3TlZjRXphbm0wUWd0bkxu?=
 =?utf-8?B?OHBlcFV6NHJSRkhaSkNUSVkrOW1pUm9zbmo1Mi9zTG1hS2Yzc1J6cFd5UWFh?=
 =?utf-8?B?ZDVQcU5oY0pYMnNLU0NGL3lpd1ZLU245V2pOekdKU2gvaFo4NnZCZ3ZIL0RC?=
 =?utf-8?B?SUM4eU5KaVZVMXlsT0VVUjQ3R1hjeTUyWFRFbUpZQUFmc2t1RXFWTi9qVVY0?=
 =?utf-8?B?d1dzcnVpQlJTNXduN1N6RXU5WGhITk9QQURqMlZrL3dpNzNSRUgyemJVZEk3?=
 =?utf-8?B?L00remlxMjZnSnhtQzFHZHhZZU5VNG9hY2hEVFM2M010NHYwdXUreWFOVjlt?=
 =?utf-8?B?QXNuZDhibUdRK25Ldy9IWms1aHhLVll2dkdiODV4N3ViUjFqOUxlWWpuU3Y0?=
 =?utf-8?B?RnV1VmxjU1FhaXh2S3FGQlo3d0F5enlKblVyRkt3ZFR6OXFpUDlCZFIvQndO?=
 =?utf-8?B?Q2xlbTNYR0dWNHNxaG1lVG9CSVFBS1hpclRiVHJTZlgxUGpYSHdEbG50MVk4?=
 =?utf-8?B?elBwdzlnSkw4S015Wlp0YjhNeTFwcWtCZlRRSk1GN1BITnBkWCtCZXhkZnhu?=
 =?utf-8?B?YUZ1dlgrRnl0T0M4VVFZTXVHZVlwTFdhckxpN2pPTU9UdFpwN0M5MkhiN2hu?=
 =?utf-8?B?Rlk5SGh1QktMK2E5SGpGNFBZcmlIWkUyMnFtOHVJK1k0R0g5N2JibThBRHVL?=
 =?utf-8?B?YkNkTzlSQ282WW1BSUFRMDg4WEhwTGlzeXdmNGlQR1hQNmxSeDQxTE9SN0xJ?=
 =?utf-8?B?cW5NZlgrV2xKQUVpMGt6OVk1bzVoL0ZvUit2WGlTdGdoOXVnT1FTTmZUYmVz?=
 =?utf-8?B?ck1TZ3hSZE4vSjlBVCt4TDNmdWdqSmZTeVp6S1V6c213Y0pmUzJPZlplcXEy?=
 =?utf-8?B?MzNOYndBZFcyMHlqUHQ5SE9Bei9JRHRkMFptL2NXZVhzN2Q5Uk9pc21zd2NK?=
 =?utf-8?B?N0hpcTNSSnV1eHJmM0l5MHM0UGhaTVd0c1Nucm4yaUw2MUEyTFdMcDZla2pB?=
 =?utf-8?B?OVJPc21tdjRzV0Vla1pzZHkwMllQZ29KT25maVBGSktOMTZGNEZjYmlocGd1?=
 =?utf-8?B?TXlEeHhONmUxd0xXRk9IZUFYaVhZVGZOUVlLdC9QcHJLQ3MwSmhrc0s1WjBm?=
 =?utf-8?B?d2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 76569f1e-362d-44d2-f3e4-08dba4f63c28
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 23:02:48.2828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VfcNwCnk6oYLseftboifOumXVX7cg5G0Z7ISsWZcust6m5qw2cQZenAVvliL93+fRjk71LwgmMGo/dQR+bauAy3Ec69upiu39a5OLh2g7TY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7137
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 8/24/2023 9:56 AM, James Morse wrote:
> On 09/08/2023 23:36, Reinette Chatre wrote:
>> On 7/28/2023 9:42 AM, James Morse wrote:
>>> MPAM's cache occupancy counters can take a little while to settle once
>>> the monitor has been configured. The maximum settling time is described
>>> to the driver via a firmware table. The value could be large enough
>>> that it makes sense to sleep. To avoid exposing this to resctrl, it
>>> should be hidden behind MPAM's resctrl_arch_rmid_read().
>>>
>>> resctrl_arch_rmid_read() may be called via IPI meaning it is unable
>>> to sleep. In this case resctrl_arch_rmid_read() should return an error
>>> if it needs to sleep. This will only affect MPAM platforms where
>>> the cache occupancy counter isn't available immediately, nohz_full is
>>> in use, and there are there are no housekeeping CPUs in the necessary
>>> domain.
>>>
>>> There are three callers of resctrl_arch_rmid_read():
>>> __mon_event_count() and __check_limbo() are both called from a
>>> non-migrateable context. mon_event_read() invokes __mon_event_count()
>>> using smp_call_on_cpu(), which adds work to the target CPUs workqueue.
>>> rdtgroup_mutex() is held, meaning this cannot race with the resctrl
>>> cpuhp callback. __check_limbo() is invoked via schedule_delayed_work_on()
>>> also adds work to a per-cpu workqueue.
>>>
>>> The remaining call is add_rmid_to_limbo() which is called in response
>>> to a user-space syscall that frees an RMID. This opportunistically
>>> reads the LLC occupancy counter on the current domain to see if the
>>> RMID is over the dirty threshold. This has to disable preemption to
>>> avoid reading the wrong domain's value. Disabling pre-emption here
>>> prevents resctrl_arch_rmid_read() from sleeping.
>>>
>>> add_rmid_to_limbo() walks each domain, but only reads the counter
>>> on one domain. If the system has more than one domain, the RMID will
>>> always be added to the limbo list. If the RMIDs usage was not over the
>>> threshold, it will be removed from the list when __check_limbo() runs.
>>> Make this the default behaviour. Free RMIDs are always added to the
>>> limbo list for each domain.
>>>
>>> The user visible effect of this is that a clean RMID is not available
>>> for re-allocation immediately after 'rmdir()' completes, this behaviour
>>> was never portable as it never happened on a machine with multiple
>>> domains.
>>>
>>> Removing this path allows resctrl_arch_rmid_read() to sleep if its called
>>> with interrupts unmasked. Document this is the expected behaviour, and
>>> add a might_sleep() annotation to catch changes that won't work on arm64.
> 
> 
>>> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
>>> index 660752406174..f7311102e94c 100644
>>> --- a/include/linux/resctrl.h
>>> +++ b/include/linux/resctrl.h
>>> @@ -236,7 +236,12 @@ void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d);
>>>   * @eventid:		eventid to read, e.g. L3 occupancy.
>>>   * @val:		result of the counter read in bytes.
>>>   *
>>> - * Call from process context on a CPU that belongs to domain @d.
>>> + * Some architectures need to sleep when first programming some of the counters.
>>> + * (specifically: arm64's MPAM cache occupancy counters can return 'not ready'
>>> + *  for a short period of time). Call from a non-migrateable process context on
>>> + * a CPU that belongs to domain @d. e.g. use smp_call_on_cpu() or
>>> + * schedule_work_on(). This function can be called with interrupts masked,
>>> + * e.g. using smp_call_function_any(), but may consistently return an error.
>>
>> Considering that smp_call_function_any() explicitly disables preemption I
>> would like to learn more about why did you chose to word as "interrupts masked" vs
>> "preemption disabled"?
> 
> smp_call_function_any() while it works out which CPU to run on, which may be this CPU. It
> can't be migrated once it has picked the CPU to run on. But actually doing the work is
> done by generic_exec_single(). This masks interrupts if calling locally, or invokes
> __smp_call_single_queue() to raise the IPI. Obviously the other end of an IPI is running
> with interrupts masked.

I see, thank you for the detailed explanation.

> 
> (If you wanted to schedule work on a remote CPU, that would be smp_call_on_cpu())
> 
> 
>>>   *
>>>   * Return:
>>>   * 0 on success, or -EIO, -EINVAL etc on error.
>>> @@ -245,6 +250,17 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
>>>  			   u32 closid, u32 rmid, enum resctrl_event_id eventid,
>>>  			   u64 *val);
>>>  
>>> +/**
>>> + * resctrl_arch_rmid_read_context_check()  - warn about invalid contexts
>>> + *
>>> + * When built with CONFIG_DEBUG_ATOMIC_SLEEP generate a warning when
>>> + * resctrl_arch_rmid_read() is called with preemption disabled.
>>> + */
>>> +static inline void resctrl_arch_rmid_read_context_check(void)
>>> +{
>>> +	if (!irqs_disabled())
>>> +		might_sleep();
>>> +}
> 
>> Apologies but even after rereading the patch as well as your response to
>> the previous patch version several times I am not able to understand why the
>> code is looking like above. If, like according to the comment above, a
>> warning should be generated with preemption disabled, then should it not
>> just be "might_sleep()" without the "!irqs_disabled()" check?
> 
> This would be simpler. But for NOHZ_FULL you wanted to keep the IPI, so the contract with
> resctrl_arch_rmid_read() is that if interrupts are unmasked, it can sleep.

Thank you. This appears to be the key. Could you please add this
information to resctrl_arch_rmid_read_context_check()'s description?

> If it needs to sleep, the arch code has to check.
> A bare might_sleep() would fire when called via IPI when NOHZ_FULL is enabled.
> 
> This check is about ensuring all code paths get checked for this condition, as it doesn't
> matter for x86.
> 
> 
> This results in MPAM's implementation of resctrl_arch_rmid_read() checking if interrupts
> are masked before sending an IPI when it has to read the counters from a set of CPUs. In
> the NOHZ_FULL case it can't do this, so it will always return an error.
> Platforms needing this should be few and far between, I'm hoping people running NOHZ_FULL
> on them is even rarer... they'd need to carefully select their housekeeping CPUs to make
> this work.
> 
> 
>> I understand how for MPAM you want its code to be called in two different
>> contexts so I assume that the MPAM code would have two different paths,
>> one that can sleep and the other that cannot, both valid. It thus sounds
>> as though you want the x86 code to have context checks so that any issues
>> that could impact arm can be caught on x86? In that case, should the
>> x86 code also rather have two paths (one unused and the other has the
>> context check)?
> 
> I did toy with having resctrl_arch_rmid_read_nosleep() and resctrl_arch_rmid_read(). But
> this resulted in more code for both architectures, I felt it was simpler to just document
> this requirement with this check. It's what resctrl is already doing.
> 
> resctrl_arch_rmid_read_nosleep() could be called from irq context.
> resctrl_arch_rmid_read() can sleep.
> 
> On x86 resctrl_arch_rmid_read() would call resctrl_arch_rmid_read_nosleep() ... and on
> arm64 the exact same thing would happen as the interrupts_disabled() check is buried deep
> in the mpam driver, the resctrl glue code doesn't need to check for this.
> 
> The split approach would be simpler to document - but much more confusing as both
> architectures call one helper from the other.

I see. Than you for considering the idea.

Reinette

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B1E77961A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 19:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232942AbjHKR3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 13:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234086AbjHKR3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 13:29:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7CE30D0;
        Fri, 11 Aug 2023 10:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691774973; x=1723310973;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MFaesahTnBNaO7rnp6C9bSA0U8tXJCkU+X/+ndiyFLA=;
  b=M0Ih1sMLZARc4VYDHLv+0ULjud5K40chxhMTkVaOcX1p3ZTvUElWSz0m
   TdanfZhgGqNLf6DlR9UsCJntQM3evAIRjVI/tJf7oidbUzY1PVgtUOScP
   KjWFrIHGQYlLVHKNl5Q7WnGvaB8wmVTHCz2DMSi1YwdzwLXIayFuUEaDh
   JP2o89ScddheXBJcJLoSQLk85gZl7LA06R7L7U3fYi1ju5TwhHl8sTS9C
   BFpwcuVLFdnqDAnPsPRX9V8XA8PHUyVUzvdMNrIlNTtKtZ9UX2TdKM5tm
   CanYrmNJ51ws4TxjBY2ddAxoeSkxtLVv4h+sqhP7Nds3nS8ACspQ2wYod
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="374492354"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="374492354"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 10:29:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="682603142"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="682603142"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 11 Aug 2023 10:29:31 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 11 Aug 2023 10:29:31 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 11 Aug 2023 10:29:31 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 11 Aug 2023 10:29:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OIJCg1lVbOl4+Jsql5rIqoH7W4y3bvEi6BJUH9jpRyKgeQMUk4tDcdWoMOtyBTCA4ID8SMJ4+JBb0QilAI2tlF/6+MUJqrrnEdlddaLXajErBe2N/KwZLgPimwbFaLItZAC53jp5oZQNyfcbBs8IbzelBwU/3VmPmtasIqKoyXhy4OEpbkqqgSG+hKPgZKW1QI8Axy2+2SG2QTt2z70VzktOFtrfcmLHdE2v+ta1C6Gnlg+HMQGn5i3A0+acOf5sfD8xjjI6tJf5XTicm0hkHXhmDZcdg72RLYD6zP8VD9L0lVocSY0NkWHdOfN+SoylWlRLwmW4uiCBW9/9hX8KHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=90gP4thcMJ7bdSs4I1D6/fix5lfouS8xn6mbe7FdiLs=;
 b=cxxrKxIZtt7YGozskyTzAbtaDoJ+QyiqxgPQ1eB++pWsY2dBb+dbzxPIkDa78qAUJnD4u7WkibhDvaWIrzdOqJEWnW1AbYQ4x5bVDrWiZYeSbhMBF8DgM3YhdrZ5iVLkMQBgkp4/mSsrhRnNETsWpQgoGQoXAmTAL0+dBLwGoK6Kw6y9qF2k9yxbj8LMaNBOyI/9MKkjzBeGr8g3a2o7gEgp2ZTwfZj8NuqI/pReCkX2IHAABPA0zUN5X/zpdfFLkTN7NXfk16iCVMmhyCvuFEnQipw5TErAqrWLrfNUxLAWcGTlMMdXpe60DksOlLpr0Szyk4ivrBvX3PHLEc+QKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH0PR11MB5609.namprd11.prod.outlook.com (2603:10b6:510:e0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.20; Fri, 11 Aug
 2023 17:29:29 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 17:29:29 +0000
Message-ID: <cc1a144f-6667-18fb-7fe7-cd15ebfedd08@intel.com>
Date:   Fri, 11 Aug 2023 10:29:25 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v4 1/7] x86/resctrl: Create separate domains for control
 and monitoring
Content-Language: en-US
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        "Peter Newman" <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, <x86@kernel.org>
CC:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <patches@lists.linux.dev>
References: <20230713163207.219710-1-tony.luck@intel.com>
 <20230722190740.326190-1-tony.luck@intel.com>
 <20230722190740.326190-2-tony.luck@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230722190740.326190-2-tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0332.namprd03.prod.outlook.com
 (2603:10b6:303:dc::7) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH0PR11MB5609:EE_
X-MS-Office365-Filtering-Correlation-Id: 126e8482-a2c9-4518-d2e7-08db9a908461
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RDBfX2UZjteRLKgtjph3ljTobEm9lC741gix4RMjmDatuDHPXSwDye37KlBVJmumGv8hdteky841Fbv+JedJ2NZHPqxuFzrnk1HsASe1ObJV9uovV79K756bYHJzpIOAdk7P7CzqUgYM+sgtZFgxdbTPNh6GHSkTJEPubwkiWmWsmYkQaybN62KIMWxAXFno/QL6KzY0T8zyYpS8zglAQZcRxM1JG+3B3q1Mc233YsrT/c+YRQsJxyDF54LTnxweQUqIrVeF/uaQTcl2HU3+AhisEPeTqHhD6hqNbmWP0s0G6Sx4hMkjBTWzRGPIGn0v5h0khipmU0AtBRguvs7Mhr514HJ+BtgzNgCNVf1SgJXn6ykOgKrnVDUs1uAomXnQWbt0oJTUfgfeFV2ATqQkvobMgTJE6kdMST2cdQMTDnBqPsHxBuC7a4fLaeA7CQXcbxnE28oO7IDW+ZUOOe5cIf7/O9vPhk57/6yMWiMTe9R2NFVAq5mK+5cQvCcKjD/TBVc0WbrH4YpXxieN1AeJBKjVDmZpkMFY3Irt86z5OkfaPqGRoNu/ycZa62sgbp90vcPLHXjerIXP1qSoH/IxrFnSp3xm+bx9qzJnrZevR1jdrHaHDt++ER/rhiDoYZP1e8l9ApprYuVTj/y4Ae0hRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(136003)(376002)(39860400002)(366004)(1800799006)(451199021)(186006)(36756003)(31696002)(86362001)(82960400001)(38100700002)(31686004)(110136005)(4326008)(30864003)(8676002)(8936002)(44832011)(6506007)(6666004)(6486002)(478600001)(6512007)(83380400001)(2616005)(26005)(41300700001)(53546011)(2906002)(7416002)(54906003)(66476007)(316002)(66946007)(66556008)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVBvSlY5R0p6clZNaGRtRm1temxvYldwamhyNTlKc09ESjduWGYzaWRRU3o1?=
 =?utf-8?B?ako1cTh1QzRUb2VRVjJ1N2dNWlcyOGY2bThZVVYvRjVzWTVkN1hkcU9xK0tD?=
 =?utf-8?B?aGVkRy9mc0hiblZFdUlQQXRuQXd3d0c0RmN1aDdXOE8rNDJ6ZjIxanVFUnRZ?=
 =?utf-8?B?SVlmbldQa0NibXJBbUJIWHIzcjByazlYNG1tZXJYR1NseGpUTTdUcG1ZS3pR?=
 =?utf-8?B?RkpVZGRzY0pwd21DZXpxb0lvbTQzeTRVTERFcUd6L3dJQWlOZzRmbmU3SlJn?=
 =?utf-8?B?K3lraldmUDlTYU4vdU56U0hxU3oySWI1L1RESmo1dkF3NEpyWFBUeFE5dE1O?=
 =?utf-8?B?WkNYVFcwTHEyZ1BaVko0emxQazgvZHplTkNXV3RRbnBlNDlmc3NuVU5Ld1dL?=
 =?utf-8?B?RXRKaEE2WCtMRG8ybjFaS1FnSTg1bXZ4NERzQmprRXJGNmNrTEtzQzJseGZY?=
 =?utf-8?B?WmdMQTZyTG13SnoyeS9OQ3N5MmFRNHRGNEYzRVZOREVmbUlZdUxXYkhoZXFa?=
 =?utf-8?B?cnVIYk1TR3M2U0pHRXJvY0xBQklFT0REbU9LMHpWNzVIa0NBUU9yQXdISXdl?=
 =?utf-8?B?bkdQaTNmZWNoYTZRVVN5dDNJTU1sdGZWY25maXJ5ZmREVkhMU3VqWUh4eXRV?=
 =?utf-8?B?Sngyb0pzS3VTQUlROU9oMHgwM1RZQUhXVysrQkd4K1h0TnQ5TGJYRjhMTlhj?=
 =?utf-8?B?NmNFWVpxMVZVYmJ4ZkxHSkFsU0c3WHBwdlpseWF6ZmU2dFlaUlVzZytTbFFK?=
 =?utf-8?B?Yy9kSjQrNjlhcW94R3MzU1QzYlNIaHhmbXd0OEZ4TjV0VG5FQWpyZ3RFZzht?=
 =?utf-8?B?QkJqb3I5UmFxTFpsckRHNmp5UElTUHJ4ekxrOExpR2dkT1FwMVNvbWVnWWky?=
 =?utf-8?B?R3cvT0JoNk92Ujk0c05IOTUzUkMwOUtsT3FiKzQ1TW4xdFVTeTJTUWRGYyt2?=
 =?utf-8?B?Z1dzbE9JMDlkYXhNUVREYkZINFUrdzZXUVdwUXBzekRONDFTZmt5TVhuK3dm?=
 =?utf-8?B?Wm16SFltR3NOYVpURjlqRUQ4SUxQYklUemp5VXhMdWFBc1dza0RNaFpCZTJt?=
 =?utf-8?B?cVkrWTJWcUk3QlVUbkRuUFNzNnhDVnBndVJ0ZzBpT21yTnNKVHYxZVVvSmRB?=
 =?utf-8?B?Yk9GVDdpZm1oNzYvY0h5dW10VFE1VzZYa3RnSVQ2U0xwZ1Q1TTlSMThHRHpS?=
 =?utf-8?B?cy9YcCtMZ2RkbTJDYlhack5JaDVjN0dZUWVRR0VxcHFuT2NVU2ttNFBXdytN?=
 =?utf-8?B?RmlBRjBmZzV6YjRha0dSYmFFYitMbEpnZ1B6LzJiY0ZucEdVVklQR2N6bXBS?=
 =?utf-8?B?UzVWWUZDMkpEdVpYc0c2enNyK2VXam84bERQeFFoNzhoWEFKUGRXZzVETzAv?=
 =?utf-8?B?VW43NzliQldhbjEySDdxSXlJKzFVTVlWbDBmSVo2aEdSTVljREt6QXY2OWNo?=
 =?utf-8?B?bStleXJhaXRaT1NKT08yY0dFdXU1SWUzSmpPVjZsK0QybjVYQlRWS0tMNXJR?=
 =?utf-8?B?ZTRjakJmVE1nOE04MXdnRDdyQmxLZ0s2dDByL1VNUHBlMTRDWFFMbTVEa2o1?=
 =?utf-8?B?QnhhQnZGaUFGN3RxTVRSeGRHZmZodUlxa2s5M0ppZ0NDU2l3eFZobktib2I1?=
 =?utf-8?B?d0V3TlFMTkZRN3BSTDBSOTZTWVVKWGNVcjI5K0xlQjFFTFJDWThONVJGdTFS?=
 =?utf-8?B?UU9VRm01TFpTZzJXd3lVdUNPQmhNMzE3REk1N1ZqNDZaZjNSRmgrTC9VT2N5?=
 =?utf-8?B?bHcxU0wvckdPTDlva0JsUm9xZGVjSVNBUWVseWtMekJxRnlobFJjc1dvNWRv?=
 =?utf-8?B?RUQ4ZlFOQ1hWek9qUnIvaEcrRjZRYXlhSlVQRm5CVi9wc3A3UlhBamlFNUgw?=
 =?utf-8?B?ZnhuSGhqZ0tJS1lQM2J2eXZMdThRekRTNlRrUUZkV3kxMGJUVGdGcUlKcHJk?=
 =?utf-8?B?T1BFaHhDckFBbUk3SE81QXJmdThVSnNMNEQxV0JxdWZMbUROZlF5SU9zNExo?=
 =?utf-8?B?Y1doeFM5STdlK3daNmJWa2FLSlJaMTNLUjFCZUxscDFLVzJTdVNHbEdDRElt?=
 =?utf-8?B?UTZHZ3Iza0ZYQ0ljVGNMYURkRjBCMjQ5SkZnVHA0Y3RLdXlUdDkrSnNZQzc5?=
 =?utf-8?B?U2NEeE1mRkRLNTJUbXVYcExrMnhOK0haajduZE5RQUgxWXZCVlh2czIxWUM4?=
 =?utf-8?B?NUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 126e8482-a2c9-4518-d2e7-08db9a908461
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 17:29:29.1417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0OqFu0gGou93Mlxbi/6x1rNfK/0fuUzVIFSVDKncYLVhJOGILrtja/9kM/zK3wFsGDCvTU/EShUIi3JthsP24Mr8fV+w5oNIh+B8kTii1qs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5609
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 7/22/2023 12:07 PM, Tony Luck wrote:
> First step towards supporting resource control where the scope of
> control operations is not the same as monitor operations.

Each changelog should stand on its own merit. This changelog
appears to be written as a continuation of the cover letter.

Please do ensure that each patch first establishes the context
before it describes the problem and solution. For example,
as a context this changelog can start by describing what the
resctrl domains list represents.

> 
> Add an extra list in the rdt_resource structure. For this will
> just duplicate the existing list of domains based on the L3 cache
> scope.

The above paragraph does not make this change appealing at all.

> Refactor the domain_add_cpu() and domain_remove() functions to

domain_remove() -> domain_remove_cpu()

> build separate lists for r->alloc_capable and r->mon_capable
> resources. Note that only the "L3" domain currently supports
> both types.

"L3" domain -> "L3" resource?

> 
> Change all places where monitoring functions walk the list of
> domains to use the new "mondomains" list instead of the old
> "domains" list.

I would not refer to it as "the old domains list" as it creates
impression that this is being replaced. The changelog makes
no mention that domains list will remain and be dedicated to
control domains. I think this is important to include in description
of this change.

> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  include/linux/resctrl.h                   |  10 +-
>  arch/x86/kernel/cpu/resctrl/internal.h    |   2 +-
>  arch/x86/kernel/cpu/resctrl/core.c        | 195 +++++++++++++++-------
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c |   2 +-
>  arch/x86/kernel/cpu/resctrl/monitor.c     |   2 +-
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  30 ++--
>  6 files changed, 167 insertions(+), 74 deletions(-)
> 
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index 8334eeacfec5..1267d56f9e76 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -151,9 +151,11 @@ struct resctrl_schema;
>   * @mon_capable:	Is monitor feature available on this machine
>   * @num_rmid:		Number of RMIDs available
>   * @cache_level:	Which cache level defines scope of this resource
> + * @mon_scope:		Scope of this resource if different from cache_level

I think this addition should be deferred. As it is here it the "if different
from cache_level" also creates many questions (when will it be different?
how will it be determined that the scope is different in order to know that
mon_scope should be used?)

Looking ahead on how mon_scope is used there does not seem to be an "if"
involved at all ... mon_scope is always the monitoring scope. 

>   * @cache:		Cache allocation related data
>   * @membw:		If the component has bandwidth controls, their properties.
>   * @domains:		All domains for this resource

A change to the domains comment would also help - to highlight that it is
now dedicated to control domains.

> + * @mondomains:		Monitor domains for this resource
>   * @name:		Name to use in "schemata" file.
>   * @data_width:		Character width of data when displaying
>   * @default_ctrl:	Specifies default cache cbm or memory B/W percent.
> @@ -169,9 +171,11 @@ struct rdt_resource {
>  	bool			mon_capable;
>  	int			num_rmid;
>  	int			cache_level;
> +	int			mon_scope;
>  	struct resctrl_cache	cache;
>  	struct resctrl_membw	membw;
>  	struct list_head	domains;
> +	struct list_head	mondomains;
>  	char			*name;
>  	int			data_width;
>  	u32			default_ctrl;

...

> @@ -384,14 +386,15 @@ void rdt_ctrl_update(void *arg)
>  }
>  
>  /*
> - * rdt_find_domain - Find a domain in a resource that matches input resource id
> + * rdt_find_domain - Find a domain in one of the lists for a resource that
> + * matches input resource id
>   *

This change makes the function more vague. I think original summary is
still accurate, how the list is used can be describe in the details below.
I see more changes to this function is upcoming and I will comment more 
at those sites.

>   * Search resource r's domain list to find the resource id. If the resource
>   * id is found in a domain, return the domain. Otherwise, if requested by
>   * caller, return the first domain whose id is bigger than the input id.
>   * The domain list is sorted by id in ascending order.
>   */
> -struct rdt_domain *rdt_find_domain(struct rdt_resource *r, int id,
> +struct rdt_domain *rdt_find_domain(struct list_head *h, int id,
>  				   struct list_head **pos)
>  {
>  	struct rdt_domain *d;
> @@ -400,7 +403,7 @@ struct rdt_domain *rdt_find_domain(struct rdt_resource *r, int id,
>  	if (id < 0)
>  		return ERR_PTR(-ENODEV);
>  
> -	list_for_each(l, &r->domains) {
> +	list_for_each(l, h) {
>  		d = list_entry(l, struct rdt_domain, list);
>  		/* When id is found, return its domain. */
>  		if (id == d->id)
> @@ -487,6 +490,94 @@ static int arch_domain_mbm_alloc(u32 num_rmid, struct rdt_hw_domain *hw_dom)
>  	return 0;
>  }
>  
> +static void domain_add_cpu_ctrl(int cpu, struct rdt_resource *r)
> +{
> +	int id = get_cpu_cacheinfo_id(cpu, r->cache_level);
> +	struct list_head *add_pos = NULL;
> +	struct rdt_hw_domain *hw_dom;
> +	struct rdt_domain *d;
> +	int err;
> +
> +	d = rdt_find_domain(&r->domains, id, &add_pos);
> +	if (IS_ERR(d)) {
> +		pr_warn("Couldn't find cache id for CPU %d\n", cpu);
> +		return;
> +	}
> +
> +	if (d) {
> +		cpumask_set_cpu(cpu, &d->cpu_mask);
> +		if (r->cache.arch_has_per_cpu_cfg)
> +			rdt_domain_reconfigure_cdp(r);
> +		return;
> +	}
> +
> +	hw_dom = kzalloc_node(sizeof(*hw_dom), GFP_KERNEL, cpu_to_node(cpu));
> +	if (!hw_dom)
> +		return;
> +
> +	d = &hw_dom->d_resctrl;
> +	d->id = id;
> +	cpumask_set_cpu(cpu, &d->cpu_mask);
> +
> +	rdt_domain_reconfigure_cdp(r);
> +
> +	if (domain_setup_ctrlval(r, d)) {
> +		domain_free(hw_dom);
> +		return;
> +	}
> +
> +	list_add_tail(&d->list, add_pos);
> +
> +	err = resctrl_online_ctrl_domain(r, d);
> +	if (err) {
> +		list_del(&d->list);
> +		domain_free(hw_dom);
> +	}
> +}
> +
> +static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
> +{
> +	int id = get_cpu_cacheinfo_id(cpu, r->mon_scope);

Using a different scope variable but continuing to treat it
as a cache level creates unnecessary confusion at this point.

> +	struct list_head *add_pos = NULL;
> +	struct rdt_hw_domain *hw_dom;
> +	struct rdt_domain *d;
> +	int err;
> +
> +	d = rdt_find_domain(&r->mondomains, id, &add_pos);
> +	if (IS_ERR(d)) {
> +		pr_warn("Couldn't find cache id for CPU %d\n", cpu);

Note for future change ... this continues to refer to monitor scope as
a cache id. I did not see this changed in the later patch that actually
changes how scope is used.

> +		return;
> +	}
> +
> +	if (d) {
> +		cpumask_set_cpu(cpu, &d->cpu_mask);
> +		if (r->cache.arch_has_per_cpu_cfg)
> +			rdt_domain_reconfigure_cdp(r);

Copy & paste error?

> +		return;
> +	}
> +
> +	hw_dom = kzalloc_node(sizeof(*hw_dom), GFP_KERNEL, cpu_to_node(cpu));
> +	if (!hw_dom)
> +		return;
> +
> +	d = &hw_dom->d_resctrl;
> +	d->id = id;
> +	cpumask_set_cpu(cpu, &d->cpu_mask);
> +
> +	if (arch_domain_mbm_alloc(r->num_rmid, hw_dom)) {
> +		domain_free(hw_dom);
> +		return;
> +	}
> +
> +	list_add_tail(&d->list, add_pos);
> +
> +	err = resctrl_online_mon_domain(r, d);
> +	if (err) {
> +		list_del(&d->list);
> +		domain_free(hw_dom);
> +	}
> +}
> +
>  /*
>   * domain_add_cpu - Add a cpu to a resource's domain list.
>   *
> @@ -502,61 +593,19 @@ static int arch_domain_mbm_alloc(u32 num_rmid, struct rdt_hw_domain *hw_dom)
>   */
>  static void domain_add_cpu(int cpu, struct rdt_resource *r)
>  {
> -	int id = get_cpu_cacheinfo_id(cpu, r->cache_level);
> -	struct list_head *add_pos = NULL;
> -	struct rdt_hw_domain *hw_dom;
> -	struct rdt_domain *d;
> -	int err;
> -
> -	d = rdt_find_domain(r, id, &add_pos);
> -	if (IS_ERR(d)) {
> -		pr_warn("Couldn't find cache id for CPU %d\n", cpu);
> -		return;
> -	}
> -
> -	if (d) {
> -		cpumask_set_cpu(cpu, &d->cpu_mask);
> -		if (r->cache.arch_has_per_cpu_cfg)
> -			rdt_domain_reconfigure_cdp(r);
> -		return;
> -	}
> -
> -	hw_dom = kzalloc_node(sizeof(*hw_dom), GFP_KERNEL, cpu_to_node(cpu));
> -	if (!hw_dom)
> -		return;
> -
> -	d = &hw_dom->d_resctrl;
> -	d->id = id;
> -	cpumask_set_cpu(cpu, &d->cpu_mask);
> -
> -	rdt_domain_reconfigure_cdp(r);
> -
> -	if (r->alloc_capable && domain_setup_ctrlval(r, d)) {
> -		domain_free(hw_dom);
> -		return;
> -	}
> -
> -	if (r->mon_capable && arch_domain_mbm_alloc(r->num_rmid, hw_dom)) {
> -		domain_free(hw_dom);
> -		return;
> -	}
> -
> -	list_add_tail(&d->list, add_pos);
> -
> -	err = resctrl_online_domain(r, d);
> -	if (err) {
> -		list_del(&d->list);
> -		domain_free(hw_dom);
> -	}
> +	if (r->alloc_capable)
> +		domain_add_cpu_ctrl(cpu, r);
> +	if (r->mon_capable)
> +		domain_add_cpu_mon(cpu, r);
>  }

A resource could be both alloc and mon capable ... both
domain_add_cpu_ctrl() and domain_add_cpu_mon() can fail.
Should domain_add_cpu_mon() still be run for a CPU if
domain_add_cpu_ctrl() failed? 

Looking ahead the CPU should probably also not be added
to the default groups mask if a failure occurred.

> -static void domain_remove_cpu(int cpu, struct rdt_resource *r)
> +static void domain_remove_cpu_ctrl(int cpu, struct rdt_resource *r)
>  {
>  	int id = get_cpu_cacheinfo_id(cpu, r->cache_level);
>  	struct rdt_hw_domain *hw_dom;
>  	struct rdt_domain *d;
>  
> -	d = rdt_find_domain(r, id, NULL);
> +	d = rdt_find_domain(&r->domains, id, NULL);
>  	if (IS_ERR_OR_NULL(d)) {
>  		pr_warn("Couldn't find cache id for CPU %d\n", cpu);
>  		return;
> @@ -565,7 +614,7 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
>  
>  	cpumask_clear_cpu(cpu, &d->cpu_mask);
>  	if (cpumask_empty(&d->cpu_mask)) {
> -		resctrl_offline_domain(r, d);
> +		resctrl_offline_ctrl_domain(r, d);
>  		list_del(&d->list);
>  
>  		/*
> @@ -578,6 +627,30 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
>  
>  		return;
>  	}
> +}
> +
> +static void domain_remove_cpu_mon(int cpu, struct rdt_resource *r)
> +{
> +	int id = get_cpu_cacheinfo_id(cpu, r->cache_level);

Introducing mon_scope can really be deferred ... here the monitoring code
is not using mon_scope anyway.

> +	struct rdt_hw_domain *hw_dom;
> +	struct rdt_domain *d;
> +
> +	d = rdt_find_domain(&r->mondomains, id, NULL);
> +	if (IS_ERR_OR_NULL(d)) {
> +		pr_warn("Couldn't find cache id for CPU %d\n", cpu);
> +		return;
> +	}
> +	hw_dom = resctrl_to_arch_dom(d);
> +
> +	cpumask_clear_cpu(cpu, &d->cpu_mask);
> +	if (cpumask_empty(&d->cpu_mask)) {
> +		resctrl_offline_mon_domain(r, d);
> +		list_del(&d->list);
> +
> +		domain_free(hw_dom);
> +
> +		return;
> +	}
>  
>  	if (r == &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl) {
>  		if (is_mbm_enabled() && cpu == d->mbm_work_cpu) {

Reinette

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B550579B582
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349747AbjIKVeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243819AbjIKRwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 13:52:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B24FDD;
        Mon, 11 Sep 2023 10:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694454720; x=1725990720;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HnHMoAvGhIaazHVX1zNSqOZTtaUvrWQ7x3StzdIHA6o=;
  b=X4DkHyD5cNROhDv7UQsNUU3Fmv0FvTJOSyj8NQr5l5RyVCAJt2MNMFSm
   h7MqnBmf1kwTFebLA+mw/zBhVY9/f4yZMnP+Qvha7aPSHcWv4VBpWAJbs
   14O/ekEzS1lY+hJsD692FtfqJrd5fugGAeLwtsSx+Rk9hmVZwOKPkWOr2
   DL46jlj853gY3HTFSTpJxf4fZh8gZJgcJmctmo5pHid7dNC1mykdhs6wr
   uEmrQWc8KsZxgmIlwGFsldHt3GUW4CuxHOc3fZL9Jc0zIl7kh12NVyYb3
   WCLG95fwmop/B7nYYw2t2aU85gHBBext6r/HmQZguCgo9BWIr3i+bcVTM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="409119836"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="409119836"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 10:51:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="720067790"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="720067790"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Sep 2023 10:51:59 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 11 Sep 2023 10:51:59 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 11 Sep 2023 10:51:58 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 11 Sep 2023 10:51:58 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 11 Sep 2023 10:51:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UF4nPDvPSt6g31SU7ZUy0IAHUTeElUeg+PLoO0PRCuHio5mJIURRbjhhok2NCJkLlTQO6CT+cyB0JnI7hRJcl/DZyPx8m84sCZ1MMVABDd4OR4wbsgMyrSrJmN2z8X5XBKSakCAtcQmlVcAw0qybDK8khcuMzZ0lOgfw1dchHfT8qjSzxBF0KI08tWo7b4r+o4gYv4C3ohxMdbXBUPjaQrbNWetpmpCvd1mrzO54vwuD0h7VwP5NIr5elHHgGQqZ/4rY9WDemt+qrIj5ZxT7AoYPMe6a+jWeNCLmk1jrITAiRf4UL0dTAHkUKOewBA6sv8Ux8vcbqd6sjNp7jDk+Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T8CAvgCl01jlOYlYMBiADKF0MCchDovrTXnA8oQx/nM=;
 b=f51Xxf8Q+PkZgac15zRXwNeO3Igb6ZcBD//lGiAr3CN3wr4mQoR8to79f/3t1zTl2GX+Sue7rdFihXwdePnGd9p/LvjB7MWLkPfjb8gTryu9vfHbwf+FLBa+TtZ9zMEUh4zKrNhXbhI9STpo3qB70qbv/P9U5JYpVsGc9bW+dKVsaTmSPrm0+SxjtgepZtmVrS9dVpkYa/RGfwthGu0yqcIlnim50MuFNwh6PgpcD436ZmkFQvecbcteuKoGfAbSGHU61J1a9neyld8oxZ2M17zSOA1tQDc8vzV8uXkVYz3EplQng0jvSx9zb/moLJQkqedAAJKlmSuJu1ymai/qmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by DM4PR11MB5567.namprd11.prod.outlook.com (2603:10b6:5:39a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.34; Mon, 11 Sep
 2023 17:51:53 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::7109:4aa5:6a6d:c3d4]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::7109:4aa5:6a6d:c3d4%5]) with mapi id 15.20.6768.036; Mon, 11 Sep 2023
 17:51:53 +0000
Message-ID: <643c5a52-451e-2f0d-5238-7611a632e4ba@intel.com>
Date:   Mon, 11 Sep 2023 10:51:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v9 1/9] x86/resctrl: Add multiple tasks to the resctrl
 group at once
Content-Language: en-US
To:     Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>,
        <reinette.chatre@intel.com>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>
CC:     <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <paulmck@kernel.org>, <akpm@linux-foundation.org>,
        <quic_neeraju@quicinc.com>, <rdunlap@infradead.org>,
        <damien.lemoal@opensource.wdc.com>, <songmuchun@bytedance.com>,
        <peterz@infradead.org>, <jpoimboe@kernel.org>,
        <pbonzini@redhat.com>, <chang.seok.bae@intel.com>,
        <pawan.kumar.gupta@linux.intel.com>, <jmattson@google.com>,
        <daniel.sneddon@linux.intel.com>, <sandipan.das@amd.com>,
        <tony.luck@intel.com>, <james.morse@arm.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bagasdotme@gmail.com>, <eranian@google.com>,
        <christophe.leroy@csgroup.eu>, <jarkko@kernel.org>,
        <adrian.hunter@intel.com>, <quic_jiles@quicinc.com>,
        <peternewman@google.com>
References: <20230907235128.19120-1-babu.moger@amd.com>
 <20230907235128.19120-2-babu.moger@amd.com>
From:   Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <20230907235128.19120-2-babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0016.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::29) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|DM4PR11MB5567:EE_
X-MS-Office365-Filtering-Correlation-Id: 908f20c4-a44b-4b72-c374-08dbb2efc87b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JzOLYnezJgbrEiqpIHy5vnVPgLVxAuVlv+GgHwLfsolM/Ev/4mXZhB0TCrUMBjrIfikTG6CIlV2Q3etYWd92wsCcu7hEfAqDjf0WWqEcpbKmCyXaoDRBdI0DrW/xShFJ0ZLvBdjl+1y4xjp/g+FSVIboRhiLYkvWm+41SKqLXwrzeqpmEO0+cHCNXl8iOvb8yCa1orUxaCIa5ClY4aN2yW90hVyqejwjhO9iDOBufzm+fBLvraBp9LWmpvIouQPy7Z+cz7wI4pXD5PS0ze9AdZJya6itxt5NtesgwT46q2zRWSHuUCnvIOBTPrbsSA4abwrOjSgc7lVlUDO48opm3Ic924eE41gAEWffhtBJwY43hdGlKgvd0MwXFcpt5Mky/IdlkbG7L05jQF9k2K5uuk/Vgh3ygVUnW8TgLm7ep7+G1rVSwyRyyVEdJyBXYD9HdPDMLuIaEDuEIQLHwkcvuwOceHYNc/9w81avkGS5uc/pGNMj69Ta7ax6P53ReD8TZpdS3hoRObY2h6MPykMA2B9nr8Lqz1eY8mcxJ022sGsX+WpArTDddn0LwAcOBa6TJ9lHYGRYdyI+lAJI5hPGnMIbojkWTJTnggj7WOqLexEEGa6+Zfnche4UR3xl0LzZBm6Hn2Lpy7PiCeEq2ovNNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(366004)(376002)(396003)(186009)(1800799009)(451199024)(53546011)(6506007)(6486002)(6512007)(478600001)(26005)(2616005)(4744005)(7406005)(7416002)(44832011)(66476007)(66946007)(66556008)(316002)(4326008)(2906002)(41300700001)(8676002)(5660300002)(8936002)(31696002)(82960400001)(36756003)(86362001)(38100700002)(31686004)(66899024)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bitrdmdnaTBhYmdhT0pSUENiZ3E5NVRERS83Q25QYzI2WVZkV0lsMTZacjl3?=
 =?utf-8?B?bGN4SnFBYUh1Wk93YmFFZnU2YVd2WDZybGFSL3I1SUp5WEZqUlgwWmZadjRs?=
 =?utf-8?B?eTRvNFI0OTJndVc3bnQvekwvV3NhYXgvWXhFclFCaEV6SFg2T0l6cTIrNGVp?=
 =?utf-8?B?eVJaQnZaMmZjOEVkckZLYSszeGtjVGlXNlBPeURTNzBUK3NRSUlEcmlkcVc5?=
 =?utf-8?B?cGhBTWhXNk4wWmVBQkdHQ0pnOHc4a3QvR3JNWWtWNCt4K0VGeHBTMXVES3ll?=
 =?utf-8?B?Z2RTWUJ3cmFVUk9oUW91OUJRZDlpZkw0U1hMUjFXeXB2eC8vVHJMcnJvVks4?=
 =?utf-8?B?YTFkbWM2NWFEUFNrK0xhK0poRU0rVjJXZ1A1THdVVDkxb2pab0UzK1NLZWJp?=
 =?utf-8?B?dzJDRmNSdXdDdEw1VjJqd3huMEdPWTJVSzlQL1lsdy9SM3d6Z0hsSkZJTGVK?=
 =?utf-8?B?OTcyUDZibFAwV004ZXZHL1Y0L3EvcXMwanhiSlhRL2Yvb3dlYk9UZE16RVdL?=
 =?utf-8?B?NEZnaHZhNHl3Z0RWSnFoVmw2Y24yNXh1eW85KzJpS083endjQmZqc29iMFZN?=
 =?utf-8?B?c3o1dktvb1NGS0lNdEVPYWl6cjhBY05tdTZLNWxnT1MvVllQZGVJdUNjVEN3?=
 =?utf-8?B?Z29INk5RcElYTHJUSFo5REtPWVl5MC9zS2Yxc0dHcFZjaVh4a2hYOVdyMjFq?=
 =?utf-8?B?OG1nVURrLzMrM0tHeWdXNmQvakZSYldtQ0xOTTdBNGhKcmJubmRzK3JvQ2Jn?=
 =?utf-8?B?VHhoanMxRDhaWnFhUFJoODRZSWt0VHNVNVlZdHlDY0o1T1FWMW53SThoVlE3?=
 =?utf-8?B?WVlFSnd0Znp4RmNZVnFZVHN4RmxSZ1FwWXRTTldQcGxKMW1TNTkxWm51YXI5?=
 =?utf-8?B?QmhQN1FkRGVEdXc4QnVxMnZkc2liY04xWXlEV1BzcGdSMm41Ry9RRzRHU29M?=
 =?utf-8?B?bDFZVVBiUzRLTzVrMkhBVklQN3FhblQ4emh0MmVOVTE2d3FNQ3NybG5yejZp?=
 =?utf-8?B?K0s4d0FiZ3l4RHhaQ1gzV25SS1BtZU5LMWlLU2pmUU44TE92ckhKVUVzaDFh?=
 =?utf-8?B?YVZKa1NUQjd3ZDY0N1NIbFBxTVNKK1dZTGc2WktrdDNSOXJFQnF1REsvdkpK?=
 =?utf-8?B?b2ZEQTRmVzQyRUZIY3N2QjRtaTkwYUYxTElXM3ZKeGhadTM0SHBlN3ladGQr?=
 =?utf-8?B?TmhsNVdTZ0ducGJYWUpwN2F2VFNmVTdZMVVFbU1ZZHhvR1NpZmpSZk5JM2Vs?=
 =?utf-8?B?WU5oRFhaN1dabWZXUU95d1dWd05WQndCNTNmM1NOUlZKc2lLR1c5bGlkbGsw?=
 =?utf-8?B?bkdBMzVtUTFjM3gwRk5NQmlHVjBvQm1DZ1dBL3FGbmFpM0YxS21WYUZoTVZt?=
 =?utf-8?B?dk4ydW5QRzZUQUR6RWptV2VSckh6RGlHQXl0YXRGVTRpbEgvSWZlUSswcTAr?=
 =?utf-8?B?YmVJZWFLOFBEM3lhcjFwVmVaYzZ3bXpSZjE2bUNYdkdIUlBkV2QzNGRDWmth?=
 =?utf-8?B?d3hudnpuQmszaDBFYnpLZDh1RTk5VTBGM1EyWEtwS0JzQWM4ZEVnSEhPU2Ix?=
 =?utf-8?B?TTB2cjlSSXRyL3JDUGl5VHI4eDhTM2tLQmVReDhaTndLU3RUYmR0QklwRFhE?=
 =?utf-8?B?UURlN3pqN1lpWWU5WDExWTR5VHZSSENzNThSanhtR3NreW93RjYyb0I5R05J?=
 =?utf-8?B?NUxuci9BaERqN2M5K2t2R1kvZ3MzdmRabHVaUm1NRmFvckUzVWhndGt6b1pF?=
 =?utf-8?B?cElIK1FodGF0U3pyN0s3ci9XaUNwUDlBSitVMTBORHRHMXN2aWFYWnNMT0R4?=
 =?utf-8?B?Y3BrcUVYRzZja0lFcEx6bzZFZ0xOUHRsNjdwR3JxVGZ0SzRuL2JsYWlxbVp2?=
 =?utf-8?B?Q0V6Z0c0cTlPSlphVk9xeEdWZDNKd3o2OXQzOUJPQjNTTjhlRUd3Z3ZzWkp1?=
 =?utf-8?B?OGlTVFgvblNpaXFBUnhaTHpPQTB2d0M4YVBlRmEvY3BiVzJVb3d1L3FlczVS?=
 =?utf-8?B?MnFEVUphN2NTaCtpdlJXMFBjcEJYZEl6T1d1V2Y2cTBDZ0NCakxWWERHNW95?=
 =?utf-8?B?TDEyaklUR0JKTkZwWSthbXU3elUxenh3US9lSEdxK3A2cTc2WFp4YW1lWW0r?=
 =?utf-8?Q?VVJcvWI9lpeK4KMxw8bL7P3h8?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 908f20c4-a44b-4b72-c374-08dbb2efc87b
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 17:51:53.6883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ifTfKBZHDaiQAsO4ETo836qbj/5Zhz7F7qwyJYIcVHtHFYMtqQiMW6AaOJzil3LsFhuJAqcLtELb2bj2x9eRjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5567
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/7/23 16:51, Babu Moger wrote:
> The resctrl task assignment for monitor or control group needs to be
> done one at a time. For example:
> 
>    $mount -t resctrl resctrl /sys/fs/resctrl/
>    $mkdir /sys/fs/resctrl/ctrl_grp1
>    $echo 123 > /sys/fs/resctrl/ctrl_grp1/tasks
>    $echo 456 > /sys/fs/resctrl/ctrl_grp1/tasks
>    $echo 789 > /sys/fs/resctrl/ctrl_grp1/tasks
> 
> This is not user-friendly when dealing with hundreds of tasks.
> 
> Support multiple task assignment in one command with tasks ids separated
> by commas. For example:
>    $echo 123,456,789 > /sys/fs/resctrl/ctrl_grp1/tasks
> 
> Reviewed-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
> Tested-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Babu Moger <babu.moger@amd.com>

Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>

Thanks.

-Fenghua

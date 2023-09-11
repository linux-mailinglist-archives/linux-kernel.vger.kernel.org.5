Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE31B79C2A0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236464AbjILCTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236740AbjILCS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:18:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9BBECD8D;
        Mon, 11 Sep 2023 16:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694474289; x=1726010289;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=x5WQjsjhvjPg6nZs4nbVwQ0+ijATaOAaXDG6F4BIRzY=;
  b=iPuC+bmeSF0tNWY5Eizaq36Bfou1XYxFHz9Z59YQvsoSyDakdtYj646Z
   5ZixFbPyAXyv14mmJa5FgkX0DsPoJLFnvsIpMHJTu2LXeH73LgDVj5/Ew
   3S9gnUxL54/dTCBv4i6iYicPifIpymBlPgCszR9ksGuGORymZnOV+0gp/
   Tushg5IcK7K4Mc4lAZ3UI3VBioh82/q0AijzQh9GYlfSOM+N/NMZzoR4y
   zSxbOsRMlwrPVAuQ+IsdILrkvapH+6QiiRJxn0Cg2ZbwtIL9//A8Ewl5r
   UCIIIAnUmLZGOc3KboViymbyD313QN3IqB/jnYSzeO1nbJRMRgbxVPOCX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="375562409"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="375562409"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 16:09:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="990277219"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="990277219"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Sep 2023 16:09:02 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 11 Sep 2023 16:09:01 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 11 Sep 2023 16:09:01 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 11 Sep 2023 16:09:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=boTOPrP4nTC33D6JVRFEsc56ecbDsxQjLNigMgj9yQ04igTGpBH2N/ln5vB5lMuvd6Y6b+gkn8b45+qMJwcPBxJHioXNtFUdbVe+CMgLY0BM9qZ40fNX8+m3nidpzFUbeHHUATIkAKjkMf4pcVCj1/4mEX2/ntuJC0ZrbpK5gIbDpxZb0xRVxgbbsx3GAujZLOBRV67bc1JZG+fhiBnzsSMerXxA/1255WYK8S7Pqd66uL+JcpJn2Dkb1u9hDnNlI1sJY9W5sgFK5QiErp/6EWtK3pdhY1lTDd9vxZwIYm5fpei2EcSrtSaurzrtgVoK/Xuko95ulISrtLadZuSFHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dK5tbTf/AijqE3Kqzh6hJGQSQVE3NQzb5MSDbLPO1fY=;
 b=VKcyDjz41x5ISkxNFs+vQCAyQYtullRau3SpHnAbBrjMx+ZaheBPIfStUdei28aemTEv9KiUTcHC2kj5uJmR8uUn+x3T8bn8YkR+ev7kNWU9E/jlTH1ZJY3xFY9Cuv/Oz7Zz7N07xcwLBlnCMAKL1g5XQ8wC/arG4VVYaH2wurOpU4Vfz7nRUr9K49gk/ymJn54v+sk3iVnY+7VB1Pp9x9oe5B68C4YVFA/oOY1qBHZeRFF2vObeAKpmuzqEqH5Hex367l0Rr3vY284iTdMG1+PbwHun685/3zVOGxvCSL6JYV724dgwzZn42lr8ZdKvmr5dcEO6UddSAWvBpNTUrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by BN9PR11MB5516.namprd11.prod.outlook.com (2603:10b6:408:105::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.34; Mon, 11 Sep
 2023 23:08:59 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::afd6:ce92:6244:7203]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::afd6:ce92:6244:7203%5]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 23:08:59 +0000
Message-ID: <080318bb-4237-b320-b775-3abcc09cb2ae@intel.com>
Date:   Mon, 11 Sep 2023 16:08:55 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.0
Subject: Re: [PATCH v9 0/9] x86/resctrl: Miscellaneous resctrl features
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
References: <20230907235128.19120-1-babu.moger@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230907235128.19120-1-babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0332.namprd03.prod.outlook.com
 (2603:10b6:303:dc::7) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|BN9PR11MB5516:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fffe6ea-6dc4-4b2d-d7c9-08dbb31c14b3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cLGLmWSNwQYR7mBj6EkvthjBHeh3k8lmhBkb7olOFHw/84+zpRUDCM8V5o5SpfvmSyj/ArnY3KnoQ5iArUNK4hzH9qsWUWE5uPyWBqHF/eZq6QWXatoWAkTXxdJHMy/tGcxaQA8FD5fkFrJNMN7yXtLKmnmvVGPpEMakhuqJ0HkFJkthDSkAl+2KA0soPnSCNngQ6uVRRrJqhK9F34vt4lCAjOu7IhAc9p8uOCVtiufmCAVCaKcxbOuIu3C1vZJiBIry9++oOeqBJnULhIjzGqIqT4sSw3THaVNcArPer245IA6y0FxFQ7fDuShXx2NTGaU4Wun+/hxjFh42s0v8/5N698BAyhQvViaFYVzSOzHu+ICGI8d8unzI5TohptP5wDUMYaMuMUNjPQwiq0vxXaLFyS/LRrZuZhkT+iVW1/bIGxsdkN+eogW3SVj12XguRqYCbVD3+1CbefVJG9ZkckGbWn7ymmhhQ0B9mjvR0Qe1zTtrOMaU66lEBTGeVk9DSVVtgnjryh1yDgeNa3+DBOHpt0oYlrnerp6jIpxTfNOxqcRogdsNXkBKEIoLqVsz3LT1ZiyXlvGWquYKgT9FCfJzmKVwt4G+G/a+87GXzvpuwQzt1oS0Tc4UKMDXQ0sKXHvegls+DO4xYDg5aKUxaw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(366004)(396003)(346002)(451199024)(1800799009)(186009)(31686004)(6506007)(53546011)(6486002)(6666004)(5660300002)(41300700001)(36756003)(86362001)(38100700002)(82960400001)(31696002)(2616005)(6512007)(83380400001)(2906002)(478600001)(8936002)(7406005)(8676002)(4326008)(26005)(7416002)(316002)(44832011)(66556008)(66476007)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXNCKzFxWnAxL3lHSGdvRlN1YS80U2VxdDhnU0pzMEZheEJKZ05hSE1OdXpR?=
 =?utf-8?B?Y2NSRGtldU02bGtTUy9paElvWldiM3ZUMGsrVEErSFJFNzErYVk0U2V4Mld2?=
 =?utf-8?B?T2V1L0lIY1BEQUpIaXZhZExIbDZySCtESDUrVW12Njd4ajRxWjIvSy9FUXNU?=
 =?utf-8?B?cUVpa00zNVF6ZElZMXMveFREZWpiUkhIQ1JxVHlXaHMzRnphWjU0d3YxWW1p?=
 =?utf-8?B?Qkg0aG9XVElmT1UyK2c2TXl2OXdpTXYzcm9lVFZoN05KRmxibWRncTVsSTVX?=
 =?utf-8?B?L3lkTFJuVkhLckZCaEQ0Tk9zSENGRk9YcDVVQ1FUU3dQTmNQL2E1RXdXSTcz?=
 =?utf-8?B?VkVEdUdDemNXM0tiTVJBRCtHVWRzLzAwajR4YnJUL1cyQkU0V0RBRTNnWDhq?=
 =?utf-8?B?bmF2SS9mRjkyc3FMT3VkbDd3cHIvemh3SlpIOE4wekFUcjh1MEJFbjQxdlJl?=
 =?utf-8?B?UUVqdnJTK3ljZDllVzhiMUZ0c0EwNEhBZVNPM0NIRGRVUG1XNTVBd1o2YXkx?=
 =?utf-8?B?TVpuQmo0c0hDek5FRVNWckczNWtDSjV4ZUhwMFVhZG9YdlBKakdPclpVY3ox?=
 =?utf-8?B?SzB5cWhZWnZMUmJESmtnMExyeHFKbW5IUWQwelhoUndRb0R3NmF4QURCZ041?=
 =?utf-8?B?d1lxcWlORVo0OGVOVXVZSDFiQ3J3M0Q1VmRpa3JrdWZQczJNUXBRUW1mL0Jm?=
 =?utf-8?B?Mlpad0FkNDRwTTJMcjc0bmw5NXN3RnRKazMrcVhUQ1FYQzFBS0pnQlZOTmQ0?=
 =?utf-8?B?aGZBV1IxckdXRE45SmcvdFF5a0JTUmhkNnFraExadXJadmpTMmVDVktOUWNs?=
 =?utf-8?B?MUdxTnRVdTVmVG1lOGo0c1hQdTdGelZlNmlSOUdhbjRnUnpyQ1phYzNyS2Vl?=
 =?utf-8?B?VHBBdjhrWE1tQkU0ZjJ6MHU2TFFTd0JrMXpSeHNVckMrbk82eExqV09KaHVt?=
 =?utf-8?B?Y3dMMm42TE9JQkxMR0swOS82dzNjVk5BQ3p5SEY0MWE0eE13cUZRVEpPS3Ev?=
 =?utf-8?B?MnYzeWczRktxRlJnazRpZlFWYTNzenFpbGFlWHgwSlRSRDlRUHMvUWdVMSta?=
 =?utf-8?B?Y1NoeHdTbk5FdTh0dk1UcC92TmE1dXh3eEs2UW0xNEkrMnVvWDJZVWZDcmtK?=
 =?utf-8?B?U2lZZzh5b21MTEpPN21GQnAzczFMOHpxMXJ6WjBsemkwYXNMMGRDSFZQMzI0?=
 =?utf-8?B?bGZobDA2ZnhGS3luRVlOajl1cmFoYjArY2R2MFVlZjRacXJkNnZIa1lSMmgx?=
 =?utf-8?B?TERyQVZjNXlWVG1YaENjYmFnMlFRREJzUUptMXh4YVpSSGtxcC9Tc2kwNFA4?=
 =?utf-8?B?TW1NblgvL0wzc0ljV3JLVDRwU2xONjl3V3gwVWFFOTFCd1B0VDdLTnFtbThp?=
 =?utf-8?B?UVlkVWswb2tudU93b1NDT0xjQXZXNjdOaXBnb1VWdzI4TUxrWVpMVjR3SjI4?=
 =?utf-8?B?RXNMa2Z1REUyQ0NKdlorTWlCNjczb21wb3BnQ0RKRGEwNHdGTWpLOVFteWRl?=
 =?utf-8?B?R3dNMjJmbk8xd3IwaWNndEFyWXRKaU5aSjJ3Snd2RDdLWXNXWFJEZVh6L3lR?=
 =?utf-8?B?U05PL0g5dE12K2d5RGdVLzQ3MEF1VU8zVmVra2t0REhoRnBYZUNRSjd2NGM3?=
 =?utf-8?B?SlY5ZEJQakZhdzJxY0lVVTk5TDdEMlNwbkZ1MjNVTWU2RHc4TFFMeTViZXB2?=
 =?utf-8?B?TGt2eTdqbkdRelBWR0NqdEtlR3pTY1R2U011czNOandSVnZleVFLL1NHc0RR?=
 =?utf-8?B?a2F2bFRJUDZsZkpMcFY3YnNQNzliVTNqRmZNeG4rRU9ZWGVPWjdvTFp6eGdt?=
 =?utf-8?B?QzBsZEJpaFR3OCtSRmo1RGd5c0F0Q2g5eGtlNlhTdnI5SCtrUmNGWTlXUUJC?=
 =?utf-8?B?MXlvSFlvVGc0Mm5STi9yN09MU2ozSzNLcXBnVUlaZ25taGw2YnRJZ0lReVN1?=
 =?utf-8?B?d0NKaUpZc0ZTM24yazZrTXB1THFBeWdNQ0xheEpsVk05SHE4SmtJNVZCcmQ5?=
 =?utf-8?B?SWJseGxuUzVVTXdNOXJGeTdUUVFIOFM1MGNyT05JRm90d2hGczQ1UHpwcFdk?=
 =?utf-8?B?Yjl5UmljaG8zcWVZajdLcVNTcWRyWGlWdVVhR256UlN3eHgwYndxYndCZEhO?=
 =?utf-8?B?cnhqN2FWMW9iNEthTnJhdWhTTHVEREVNNWVxbUgwTTBlaFpDMUFwUFIzRXBF?=
 =?utf-8?B?WEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fffe6ea-6dc4-4b2d-d7c9-08dbb31c14b3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 23:08:59.2168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9HChwb0qyQjMj3BVwviPwBVweGD9aYE5151TBppwz3pLxE2/GIMR5sYzwodehCp2ErTUL9r6aqVu20j9TFiXSJhuBBT7s+7nud7noNutmlc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5516
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 9/7/2023 4:51 PM, Babu Moger wrote:
> These series adds support few minor features.
> 1. Support assigning multiple tasks to control/mon groups in one command.
> 2. Add debug mount option for resctrl interface.
> 3. Add RMID and CLOSID in resctrl interface when mounted with debug option.
> 4. Moves the default control group creation during the mount instead of during init.
> 5. While doing these above changes, found that rftype flags needed some cleanup.
>    They were named inconsistently. Re-arranged them much more cleanly now and added
>    few comments. Hope it can help future additions.
> ---
> v9:
>    Changes since v8:
>    Split the RMID display in a separate patch. RMID is a special case here as it
>    should be printed only if monitoring is enabled.
>    Made rdtgroup_setup_root and rdtgroup_destroy_root as static functions.
>    Added code to print pid_str in case of task parse error.

fyi ... I found this version difficult to review. The cover letter contained this
high level list of changes while some patches were changed without getting a mention
here nor in patch-specific list of changes. I ended up needing to do a diff with the
previous version to get an idea of what actually changed.

Reinette

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED5779039C
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 00:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350808AbjIAWZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 18:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350790AbjIAWZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 18:25:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDE71FFC;
        Fri,  1 Sep 2023 15:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693606478; x=1725142478;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9xuUNQjEs508EKyYExCRRY/T2jVt30K+8j9BD9jwQD4=;
  b=dkDiIFUvBZG7nVlmKKZpOLxgES3vvWd9uXn0/102Hm+ttPCtgTm4gWXA
   3WTJz4cikbxiukxLYmq8hY0xQj6vuQxMmXjOniuSGome/DjC/8cSYXgPB
   AA2iqqqaSpahduQDQH/hgp1F0Say7PaaWZbs4ncJ3iaKdiPMSNySGNR3Y
   V/ve0Vr0oSn+Tl7JSrFMjMnDPmGDZ18D6mrp9G0hZthYrgmuxus6km1kh
   kVjsQliJRtRVc83SYX5E7MG8cTZmj+cUz3ueicCEO2DtGcr8EKm4bURw8
   KsereyC+2NcEu3M+F5yIxZfil61+i2feh8mHKR7fl5056c/ekGdaXVjoL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="366548646"
X-IronPort-AV: E=Sophos;i="6.02,221,1688454000"; 
   d="scan'208";a="366548646"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 15:14:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="883350216"
X-IronPort-AV: E=Sophos;i="6.02,221,1688454000"; 
   d="scan'208";a="883350216"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Sep 2023 15:14:38 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 1 Sep 2023 15:14:36 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 1 Sep 2023 15:14:36 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 1 Sep 2023 15:14:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I52To/xy1fXLpqeKzcq2B9fGM47miAIiTTgsuKdbU+uZx6USm9geR6mmmPoeBukbRpFKD/hmxX8ze5wJe77cnR1ILvQ79bNt+tZZVIkNlCAYdDsUIQr2nU69oSFgu5QVEhsvyBmrUVfwOWS1bJT/ptPypIjYRYynhwc8oO3b+eko43M3+DZN+3dZX7feSbNLIhSUThZvYijNmqAwqXZPoIv18mcxephlH/CfrYYzGpTmHK/sEzt8nZC+e0ftfwJaJ+DU2aUcv6Q0QOUrqmFgO2EMqUkavmsnduqLYvbxI9e7fKLNKsV/veWJkb5LrYBKVQI10To802+AW+weONwh+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FKwNJZjxDmFYOqUcHBGs6zq48ug7yQGgUoXb0+HUdZg=;
 b=fP+uUFz70ltI+WF1X5LPVvNficiM9Ay7PkCnujbtCCfiJRaGRGD7xhLvKh6chaGLGXd6pOcB/bTcmg52hWKqHOZddfJd/dbcXobtyayoMPNKH2yahm9SUD/cneq9rFqSqHbp42z4/QW2g+ls8gt/xdlNFAD0wCmtTWU4J4tGLMih2wENEIqBtiG2ojE966PI2hCJd6q+5Cje0QnCfjYyMK3GicBqTWL9xQs5rVAfE8DaXjXgPs8TFEHI1/dG450RrUGsjt9JOSzkLcl9JXcvwTSz6/m/T9kTUDImSrRzeG6naUZGmrnbQK/GeV5Mp6GZ3pSBpd2kOaMLpU/hJhU6kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by MW4PR11MB6981.namprd11.prod.outlook.com (2603:10b6:303:229::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.27; Fri, 1 Sep
 2023 22:14:33 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::7109:4aa5:6a6d:c3d4]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::7109:4aa5:6a6d:c3d4%5]) with mapi id 15.20.6745.023; Fri, 1 Sep 2023
 22:14:33 +0000
Message-ID: <9d80f21c-ee30-9891-5da2-a1113ceffd21@intel.com>
Date:   Fri, 1 Sep 2023 15:14:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v8 2/8] x86/resctrl: Simplify rftype flag definitions
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
References: <20230821233048.434531-1-babu.moger@amd.com>
 <20230821233048.434531-3-babu.moger@amd.com>
From:   Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <20230821233048.434531-3-babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR04CA0002.namprd04.prod.outlook.com
 (2603:10b6:a03:40::15) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|MW4PR11MB6981:EE_
X-MS-Office365-Filtering-Correlation-Id: 5500f92b-7c72-4972-384a-08dbab38d1b5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BRdjgs8ibSjV7a0d7+9P5TW0lwLZgwhHtMgzvbiwYdRDs8zfVYzVeBhUW3Y4EOaqx17bb6+w9Hn7Q0SshTR3hi9KOi0Tgjt+ViI2QMFBWw7JD+zbwRrrEvArnomvGUVGitctm3IuS1vxVTApQKMj8OGjc/gknwge4NswZi2Vd2ojE15Jq7Y8jGQevjRAxl/DKl1wW/kq4QNmAokcXarLeUUZkKzssfiTE6AdNDsaVSgymk6gT65ELvnWdw2CzirqdaOyUhlCJSAV8dvi/UQ1r4h0yhFJmu1cjHFPP2Qzuxwq0hOsxvA215L+1K1KDcpmV37k73F/KY5/5+EDdAiVMaLarp2nIcJmeGEBoEYDKUvg6/LEhPpUxr/NGjo5P7zmVmom9GGDMLmfYXqGETFs9Ls+63ekicLvFvtar6ED2T3/tPhuJkQkyoeUHmc3WjT0GNXgO0dQbi6IaU8N1cgNZbIlBzrvhGog9Gy3IAV6L8k99Ss3PmtdIHjrQK6uKwAkOY3y34n/MccFOxdtt+Wd66lGUU2c4zw5EU0JENIO0dNI5jyGUN4PFBlEqqnYViO8IqURmlAZEM8PyaIt8jIcP7RAfaF5OqMLij5eg7rfFV64F0u5hfFF3SiLfCMtJFxoWBQ5cnrVSX33wRhhp/ZVxA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39860400002)(396003)(346002)(376002)(451199024)(1800799009)(186009)(66476007)(66946007)(66556008)(2906002)(4744005)(41300700001)(7406005)(7416002)(2616005)(31686004)(5660300002)(478600001)(4326008)(8936002)(8676002)(316002)(44832011)(53546011)(6506007)(6486002)(6512007)(36756003)(26005)(38100700002)(82960400001)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmR5Z3dUUlZwOXI0NUNrd2Z0TytlTEd0QjdZVWtkM2VFZmlCaFZ4ZXBHUkJp?=
 =?utf-8?B?TVNLblVORVVBVUtZZU45YURwZ1graGpTUUdNamh0MHhQZHJ4NjIwdDZQZ1Rj?=
 =?utf-8?B?V3ZMTXFuMGVmNDVpNXFDUHZGSGY2ZHpjZTlMOFpqOHFRbDFHU2I2V2xqaTh6?=
 =?utf-8?B?aTI4b3hub0Z0dWNTOWF6RjRqMy9pcXIxMlR5dEptdS9xUXgyMFNYQ1RuQXVo?=
 =?utf-8?B?SGZnQ28vaW5BNTBMTWxZNTZNNjVpSGRUdGVyT3hiZ1VBaGJyc1k3M2tVQ3c0?=
 =?utf-8?B?UGYvZjVSWmUyRWIrV1lzcGtLT1B1QjZWM0JydXFOSjl4VkJ2NzJBd3ZPU2N0?=
 =?utf-8?B?RVBKQXE4NElnK1FPbTdXQ1BsOUVTcDdtZ05GaWMrOHZoY25aOTdQZDMwRDhJ?=
 =?utf-8?B?TmJCMzdtTklQNEpYdGgzaWtXY2lTNWJESCs5MElRSzJ4M3FRVWZ5Y045eUdN?=
 =?utf-8?B?M3B6K2pJUXk1WVFIT1BnVDIzZU5qd2ljZGhyeW1ZOFNmTFg0TVdodkltMnR0?=
 =?utf-8?B?bkd4ZHhCNEwwV2NFMU52L0pXV1RmYWlLMmhkMldUV3JlWU9DajV2S01Rc3hP?=
 =?utf-8?B?OEcrL3VQY3drRjF2MnE2QjdnbXhjc0ZSMnk1UWJ3WnA4bSs2ZVVwZHFNUlRR?=
 =?utf-8?B?ZEIwVk1vODBVYXVtR2w0dkNLRDJucFpRdzE0UTUrbzZOZXkvRVlMU0tmWHJB?=
 =?utf-8?B?a1hWSE5URjc4cGlxNVRPYW1nT1c4bTUxTW1tSFZXVWphV3c1YzR0UyszMnpQ?=
 =?utf-8?B?YmgycThTU29TZEQxU0o0LzBJNG5yUEVZcjF3YkdQd0JEejAxK0tteWpuV2pG?=
 =?utf-8?B?MUlGSVF6bUt4aS94ZjV2ZG5BS3ZkOEVPWFRaZWcyYWdYbW80ZGdFQTkwUjZ5?=
 =?utf-8?B?WFQvTVYzU3kzQi9jTDhnOFoxd25YZE5ZY2c3cUowb3pqRDFZUDZselpBSFdw?=
 =?utf-8?B?UWpUUUFUM2RZUTN0dFBYdkZqalNqamxDU3FlN2tzWGFtcDJ1L1kvalQ3ejZ6?=
 =?utf-8?B?b1hXcVd1Qnp3YjYxS053MUY5WXowVlh2VVNKVXp1cUNuMm4zMXU2YjkwZWk0?=
 =?utf-8?B?eDVWeGxoemI2YnZYMVI1a1V2Y2JvUndLWkI5OHdNWmo2L1g0MFk3Mm5USmli?=
 =?utf-8?B?SXZvd0d2R0FuaHFINGRWakN0ZEM0S1ZqbGJMazVqVFdCenFpcStLTFdlNUkv?=
 =?utf-8?B?aHRLQzhpSnlFaTVUbmZkOTdEQ2VzY2UzeFVJVFRWUVhiVjVnNnBPZnZGbFB1?=
 =?utf-8?B?a0NEajlzQ1plY0xEWmY1TUpDOXZVeURGUnczVC83ckZGWUhsQk9OcGs1Sjhv?=
 =?utf-8?B?SUNIaHNqZ21Od01PcTBXQTVwVFlmbHJ0R2xEcE9vOHNySlVuZjBFWTRqNEZv?=
 =?utf-8?B?TUp5eG14ZkVPR3FsNFovSUlzVnhUdDVkOExYQ3hrS05EbUZRamRwL3IzMjhh?=
 =?utf-8?B?ZnpDWHp3WFlaRVhCUGVBSFFNQ0p1UzgxZFh0VlVVdkxPQWV0cmc5Q3hEWDhR?=
 =?utf-8?B?M2J1dGpzMWtDN1Vma1ZCQm1mQWpDSUJvUEY0Y2JpYTgzODRWeTZZUTFYL2Vh?=
 =?utf-8?B?VWdkY1pZWHdQY2NQd2JSanpYMTF4Z2VFNjFnNEdOUEhkRVh3WG81K0ZNYmhS?=
 =?utf-8?B?Y1lMY3lSMXVoY0NRckRlRkpZaTFPaUtpWE80aG9CcUg1eER0SzExREdCR094?=
 =?utf-8?B?NXFiSkZTZm1QTHR6dUtjSHR2aWh5Sm43UXNlWUlsYnE5U1dNUHBadDl0c2lO?=
 =?utf-8?B?WDhlVEpGYWFUK1RKVFdPMmpETWtUaWFtSUpUVTJQcnptRXVwSFp1eFlkS3FO?=
 =?utf-8?B?SEIzTk9oWEdHbGxsd2NTY3JOTEtwQzdlbW9EMDhBT0VtTVZNSmI0bGxoN0JN?=
 =?utf-8?B?NUNXa3RPbjRUNldNWGZ2N09UVE9zbzljYy9BWmZDZXdiZ0VUWllxclNSOHp2?=
 =?utf-8?B?Q2NydTZRSkxuOVl6U1FKa3J5NmtGNHc5UERBZStTcDlsQVBGU2lrZDRObnda?=
 =?utf-8?B?SEJpZ3hieitHT1FIZEx5UWtNdlhmd3N2TS84MlRWdU43OXFuVGV5Q1FsNkE5?=
 =?utf-8?B?bEowNGlaUHk2QjZkOUxWdXlBNjRseWNTU3dCNExWeUpVTm1OZVNlWGdpZlJK?=
 =?utf-8?Q?m1f6cfeRRoGEEcOHUVjdmROln?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5500f92b-7c72-4972-384a-08dbab38d1b5
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 22:14:33.0109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vh336vO0dSh4xKF3bqGQFuMHIqbYPz8hDmlamNKZzw7TpBpgMWt0e4azYnQafaxdu3ByByIX/QaZXeoQlBoiIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6981
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/21/23 16:30, Babu Moger wrote:
> The rftype flags are bitmaps used for adding files under resctrl
> filesystem. Some of these bitmaps have one extra level of indirection
> which is not necessary.
> 
> Make them all direct definition to be consistent and easier to read.
> 
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Babu Moger <babu.moger@amd.com>

Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>

Thanks.

-Fenghua

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6DB790405
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 01:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345902AbjIAXhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 19:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbjIAXhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 19:37:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3C9E65;
        Fri,  1 Sep 2023 16:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693611430; x=1725147430;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=y9HIfmH5mNL2In169+EVWJTPwyUG1dt87ytXwsxWmL4=;
  b=ByeJ0YGD/rG5zUNzBUtVHJVm4+vfDPN5yxvz7FRH9AfSKAj3c7Pz6sI4
   ZMd312K6ggBKouQDzgAfjnWiTdv5dpWUvMztFMsAfsZ1zRoDYC+Dzm4Sm
   6s80GBFFghbtueczamBa689E8UvjF3yHudnT7PC6fmlwM6xYkDWyF2UCC
   oGnMVBYB4eecTkgEb0kv6lNKI3FA8sJqjDv8kNbUDBBuN5otEjyTLOxbE
   GG+d6/h9pgltbfn5nJLxhtVgZCcGDZasjpw9dHsUBzj5U+4zHIQjFrOvc
   C/aQLhVlFqYiPDm4oDRCb8+zV1Uxe5kD/0uFlE9LGrZSrVVLAFAfrfJR/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="379050922"
X-IronPort-AV: E=Sophos;i="6.02,221,1688454000"; 
   d="scan'208";a="379050922"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 16:37:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="883371886"
X-IronPort-AV: E=Sophos;i="6.02,221,1688454000"; 
   d="scan'208";a="883371886"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Sep 2023 16:37:09 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 1 Sep 2023 16:37:07 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 1 Sep 2023 16:37:06 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 1 Sep 2023 16:37:06 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 1 Sep 2023 16:37:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J4Q5RMy/y4cte53KWuLY6rRmVg1w63n0D7whye+UXwEr01hmDk3Qw8zyK4LLkXhcwunIKYl6iqZlsLtW11PMKDvNf+aArrJGYv93SKSl9a0h2Q0rxeBDOISuwuCnkvqC67Sz3fw5auZ6s69nMZHkrtj/pMy5xo5DwRYTRyjyOF0VG718NBSW1/ALox1ecCFNS8f5Ou3zKYaMpT9FFC6Krl2k3N7zxnLGZHsPMy2jJGPfjX/k7T5I5Nq5Q5+riR4mRMD/FoGWa85CkHUvd4z3SfkpK9QbCoHSNtQcVDLey5Yu+icSHTDrnxuNJtSEYra/DD6CJ6UTYRm1PxmSyJGQtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uktmb08bvKShRkgTO7RWfwnmEb92KsweVPaXItmGpvU=;
 b=DoTz6T0uRhBOklbA3qgf2rZdJzRLqVS7JLpXKFlfLv1bpeR6q4fHW+H1vWxLvDnZujmLS1au+aMBbZrpTViHlQW4zwpL/ZoNS0axjIdHl6r3eS5MR8s5Xkl4SzpOS8L6x5L4Og6bMV2eYbRXA/eQI/Psir/QE5CrjXPUpAvoRDt/7NIT6y0JT0GgS7ObKbLbi+T18u94wAZ2nRiOWVKQp620hWszZ+JhMM8JyhLzzQ2vqVWnHacJULuJ8X0JdPfclvDdEYEZGtoNXd0I1qI4iYMWVUhJld0sWLwQm2s77atJHERdf0oJX2zUKRgEfv9jFgqVUhwEbyaC5GS1FIBe6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA2PR11MB5210.namprd11.prod.outlook.com (2603:10b6:806:fa::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.27; Fri, 1 Sep
 2023 23:37:04 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::afd6:ce92:6244:7203]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::afd6:ce92:6244:7203%5]) with mapi id 15.20.6745.023; Fri, 1 Sep 2023
 23:37:04 +0000
Message-ID: <f33d96b1-ef46-f1fd-94e3-52baab2fd29f@intel.com>
Date:   Fri, 1 Sep 2023 16:36:59 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.0
Subject: Re: [PATCH v8 6/8] x86/resctrl: Move default group file creation to
 mount
Content-Language: en-US
To:     Fenghua Yu <fenghua.yu@intel.com>, Babu Moger <babu.moger@amd.com>,
        <corbet@lwn.net>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <bp@alien8.de>
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
 <20230821233048.434531-7-babu.moger@amd.com>
 <d6af932b-4e1b-103f-77f0-d91c2f3fd75a@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <d6af932b-4e1b-103f-77f0-d91c2f3fd75a@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0225.namprd03.prod.outlook.com
 (2603:10b6:303:b9::20) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA2PR11MB5210:EE_
X-MS-Office365-Filtering-Correlation-Id: 22cabf72-4f3e-4250-0f6a-08dbab44589b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xfr9oVduPiKJuQIgaE6OMGZXYIg1vN7s6Jk7SvSFCR04m/oEeXZZzO96Tle670Zgi7jT4WBwFCmA7cnyNXwYOHJOPelRPv4S9h7tzUfWysOyAy9gpLdCAv6kTKxbt+6/MgooFIY740c7dX9y53AIuLZFZwKjDNkku5UNQrqKphgCWa9ooYXmHMEluYPIOlM1uujMRF6qJWKJfnlWWj74WBJcbH4TV3BRXGnNCph3vIRxFnTYMIhiGeuitm3eRB8r9glmOeU5vO4VIoh3gMgNEFWOEHs+E8YMfEa8w+BQBx8OAzoDIFns91aW86TsfF1apgqDhOEEVh0b194vmIToPCPkTUbH4G6zy3VOATglS2Chz0DS5vkVerKbA9jt24xMosZsVP0aEiLY7uIsy/DpAPUaUteTeI3D+hYk/dt92cKsvlKb+4QHaRFw64lh2IlHFy7sDIwVoFYN4ZzpUpy90mLOoV/bruzXvraPZpfbYjKmsdCbT7sk2oHri+iIQKWqG/hF7aOqOmOWFwNEFGRl8FkFzyvemXqJftnUKKseS+c+VnbJZPIPTdzIAjwbQikp6azTFWS0q/IPzkGokEkWjGhJa7U6dTJ2tGcskhXm69S+iW9BMW206R+VYDMmNCvwNF+Vm40EtZsd2NOoTbwiXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(136003)(396003)(39860400002)(1800799009)(451199024)(186009)(8676002)(8936002)(4326008)(44832011)(7416002)(7406005)(2906002)(5660300002)(2616005)(31696002)(478600001)(26005)(86362001)(41300700001)(31686004)(6666004)(6506007)(6512007)(110136005)(82960400001)(83380400001)(66556008)(66476007)(966005)(66946007)(6486002)(38100700002)(36756003)(53546011)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVUzV05LbFkzVk40Y29GYnhXd2REUkJSSG5hQ3cydlVMOHhORGIrUERzdUYv?=
 =?utf-8?B?c0cvMUlveWdMWFRvakhDNHBBbFk0M1o4QWpLUzgva3FIcGgzY1B6ckN6TnBB?=
 =?utf-8?B?MzZpZ2dROE0va003TURqa0VMbUFyMXhHcDd0a3U5QjNpc1BEQUdCWTF1UmJP?=
 =?utf-8?B?RWNSYzgwektEUktCVEoyWFFER01Rb0pTdGV3TmJWR0ZZdTM1QzZEVjhUd1dy?=
 =?utf-8?B?bDVva2NJU0IrYmY2QndtMjhyenB3QUpxMkt5YVFjZlBxaytwckVjREVOWW1q?=
 =?utf-8?B?aVR2SHlTRzd3aWpxdVAzTVNiUUVoSFk3c3J0Sm1vQndKY0N4SUp1WVR3UXhs?=
 =?utf-8?B?YXJvR3AwdXBjVjZMaHRzOTl1c0pibEMxUmxNeHRrODBrc1pQanl5QWQ4OURL?=
 =?utf-8?B?SjZnSXNjMmJkV2tsRHB1ZGkyT3NYNFJUQVorWm5nK3k4dWZMR015RVFqSVk0?=
 =?utf-8?B?c2RQbUdYQnBzcHc3Q0QrK2pSajloaXE0TDhpNVhFbUg1RkR1MlYyZklCblRD?=
 =?utf-8?B?RnZXTUxiMENuNUVXUWhJSWptYVlCa1pxQ00yMGV3UmVxRTVab0tXZjVINXdR?=
 =?utf-8?B?ZEUvY0FRb2dTNHQ0MmZsdDd1dVZsaUd4UjJlTFVyR1RQSTFWYWNndVhlVGVn?=
 =?utf-8?B?UUZycUdCVzlFSDd5cENZYThRSFpjZE5XdHpqd205VHZ4Yng4U0VZMkh1QnE4?=
 =?utf-8?B?bW9NWW5ZUXM5V3Q4blNubXAyWHF0Qngza1pFdENGaFZJbVZ4ekJRTXpzNDcw?=
 =?utf-8?B?VUcwQ1M0a1IvQ3dsMkhJSlNaOEdKTWJNV2pPUHNlS29lcDluRmtWK2V0Y2dR?=
 =?utf-8?B?dS9CM09pOXNJd1hiOGF3WThyT3dSRWg5QkpDK25FaGwyRC9BNWZ4M1lEbURQ?=
 =?utf-8?B?amdqZEowaWhXZGtvZ1RTVkdIVGFsR3lIeGdzRjh5TUQ3WnZRZDJtU01VOElS?=
 =?utf-8?B?WHdQay9oNW1oRDBYekdOOXhwY2h3dUd2UlRCSFhaNHdNZ250K0NJY0pxdGgz?=
 =?utf-8?B?V1Y0WWhsWStDNmU5MHlIUXYzQXlPNE9KWnRUVVVHc1VrRUw1dkl3UUQyaVdr?=
 =?utf-8?B?dlp0N2dMRjExK3dERGZIdlhVdk1YdE9KRlVHS2lGaWU1RUFIYXZBbWV4OC9H?=
 =?utf-8?B?Tzc0ODZzVXRxYVRJZHp3QkY3SkJXL0RjRFNKV1JRTk1JM1hMYnBveXdhMVJv?=
 =?utf-8?B?ZE9zVlBuMm5hZGlsNFBON3N3SER3byt3a21reGdzbVFXQ2pEK3g5dDVTSXpK?=
 =?utf-8?B?WDhVcmJkOE5BQSszbFhUNkVDVDFKVHBYMFFTUkRra2dUbGpoKzFYQjdSMzcy?=
 =?utf-8?B?S3V0YjlQQkQzNkw3djhGQmhPNmRHRDJ0QXJSODMyOFA1U2NZMzJZaVJONTRz?=
 =?utf-8?B?bkxrKzViR1QvY2lxaXU1bE9GUmNFK25uOGFsVC9SdnRGK1JQV3ZPYnNCbkFl?=
 =?utf-8?B?UlFyd0I2NW5lSUJDYzhNd3cyVmpyVi9MVXJvVzRORFdBUlV4WGdXM3JrWktz?=
 =?utf-8?B?NEI4QkR0UlhydjQwSDVJU25ZU0RkRFptUE1XWUUxL0IvaWNicWNyUVI3SXdu?=
 =?utf-8?B?eWRtYmRDR1dGeXlWRC9UMnMrRld5V29BbzZkRzVlR0EzTDEwQUpOckJuSk56?=
 =?utf-8?B?SDZOOXFmVmtuM3QzaFNmbFplQjV3VEhzMCtwNytDRXJWT1VQckllek9McHdy?=
 =?utf-8?B?MDJ1NEVSaW52MjY1WVdPeElrMTRNQkZOSjFReUhNeE1KMWZTUGtqemZjZWRC?=
 =?utf-8?B?THhwdEtiL3JiUUJsTVRYa1lWYjJuMnJZSk1MWm5udUY2eGM4aXlhRGY1MjJT?=
 =?utf-8?B?L2NUSkc3R2FnSW1UdTdqcGd5VTcwelU2bHVZY1FMcTBHSzA1eWl4czRnRVBs?=
 =?utf-8?B?K0ZEWDFscWxrcEluTUwrdk9tOTNYcUVnVFp1WWdmcXExMzZoUXRQN0JtaGVv?=
 =?utf-8?B?bzY0aUZtZ0l1aHEyb3lyVVUyNzl0R2FtdWpId0k2RytJV3RJem9ZV2NEQzZ4?=
 =?utf-8?B?MWRDd3BsK2dSL1lNQlh2SG53QU9RNUdFbXZYK2gxYUN6SXRyeVV5R2lNMkNE?=
 =?utf-8?B?VDVBbVl3NVpHcFNZR1lRUEd5a2hLbGtYSGFJaEY1djRxWUdrSXRON0pQT05D?=
 =?utf-8?B?NU4vaXJPWmhPdWxoQU5lN0Z0K1hFNDdkb0tLYmVQdVFDNHhva1Q1Ymo5clkz?=
 =?utf-8?B?enc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 22cabf72-4f3e-4250-0f6a-08dbab44589b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 23:37:03.7053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8yBGlZNgK6d+jzgAbXdl7ZEK4/3tlEkHcT5k24gUQ9FbUPlZT1NPGzm4kahu0WAfY3u30FA1WF07rJUn4ANQM4MZqz3N5t8p0fmzUfsfyTc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5210
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

Hi Fenghua,

On 9/1/2023 4:21 PM, Fenghua Yu wrote:
> On 8/21/23 16:30, Babu Moger wrote:
>> The default resource group and its files are created during kernel
>> init time. Upcoming changes will make some resctrl files optional
>> based on a mount parameter. If optional files are to be added to the
>> default group based on the mount option, then each new file needs to
>> be created separately and call kernfs_activate() again.
>>
>> Create all files of the default resource group during resctrl
>> mount, destroyed during unmount, to avoid scattering resctrl
>> file addition across two separate code flows.
>>
>> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>>   arch/x86/kernel/cpu/resctrl/internal.h |  2 +
>>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 55 +++++++++++++++-----------
>>   2 files changed, 33 insertions(+), 24 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>> index b09e7abd1299..44ad98f8c7af 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -611,5 +611,7 @@ void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
>>   void __init thread_throttle_mode_init(void);
>>   void __init mbm_config_rftype_init(const char *config);
>>   void rdt_staged_configs_clear(void);
>> +int rdtgroup_setup_root(struct rdt_fs_context *ctx);
>> +void rdtgroup_destroy_root(void);
> 
> These two functions are called only in rdtgroup.c. Why are they exposed here?
> 

Could you please take a look at the email thread [1] that
discusses this? We reached a compromise but would appreciate
if you have any guidance on the right solution.

Reinette

[1] https://lore.kernel.org/lkml/972db626-1d74-679d-72f2-3e122f95c314@intel.com/


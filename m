Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF7B787CA1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 02:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235628AbjHYAoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 20:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233446AbjHYAoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 20:44:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1D0A1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 17:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692924247; x=1724460247;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TzAW+OAxUunfMy4g6yPGuhe8Mk9eRXY5OnBTmHqaIsM=;
  b=HmY7OBacOzzX8DaQvKb/vfDUH5/EeqrmApbO8CH3aaln7ApXw+4WQoaO
   lXkSKT/zVjjEOZ+1SsLbCGNNNqpPXhpLM3s17tenK895S0jiq9u31f5/2
   uHNLdfdVZsXMQz65p2CcYEd/pdtZ04TgCnrKTrHpEYMUFjvcnr2fOQk75
   +NmXaX9V4P7l/u0pHCOtQece+jddKaL8HYMc1VIYS37/OinpAqTy3fvRv
   BWO/ugkwE7UvmbGSckeCDYP1oAu07iH7GJcI/YT/lIb88jJsmevBTjb7T
   BOi2EBb5/eirWzL2C5+R0RIoSnSXxqKPO09FjauF4oRR2lYNDzLVya2I6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="374572693"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="374572693"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 17:44:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="766772466"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="766772466"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga008.jf.intel.com with ESMTP; 24 Aug 2023 17:44:05 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 24 Aug 2023 17:44:05 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 24 Aug 2023 17:44:05 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 24 Aug 2023 17:44:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eoDWif9R2ciDkUDz15DSzMLpZoyS4BF3szwueX5oRQBoXwLiUkdiAk31mMyAE+BuuZdTRba0HcaExcAQwrK0CfCimZS2jqhfn7RKZcb0pI7CP3Qo55x7hwr3e3ke8lo0xO1Qi4QTYgLvqVM8ZIO0sgBHmBuuQksx6s5UjNVcwUPZ9UkRVkhuL8xrMw3TlNHApThC+LBIEhC9s99XbUplzifPSjEjI99giBKF+qqoRexJlpAv2ieOl2bfcp1A+8UtymGiaoCMcbDQDodpAtqJa1pOoSrZb/MXa8dujCVMpvAQCrcr8/C97U0PBvDXoEJS2WhVVgYob7hFdcSASos+kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zOOi6bZja0DxereV56hBeG+wwgC8WJPy7668ZK3+GK8=;
 b=NSicVXdnEAUdbiSqlDDuxIiai9h80ZMjwaWl/bUPWW3OwwmfSG1RPXFH3M6qrjtSq56ek8Kpet1F6MJIYRsjbZb1/jK0e0dCVLxpbojqiZxesQuYqpn5dit4H6vjHR1cTx/cm5QG6bP9WM3W8TCk0xj0aeAxxksdCh+tkqONedAo1qfMez9PViQ6VvLuQMADLkvUxeXWGpegNXPoySBt+3FZ6nikWKo2LbhyqWYZbDx9S7ZEW3IE5iPA06iF5koO36ZqNsi4WR81OzgePo93cWVXErwXW0xKMrHPL/28LOo6wEBFDeJjVwGx3OeYEvrLVdc39bpcOK3rZ8nthT09rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB7959.namprd11.prod.outlook.com (2603:10b6:8:fd::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.27; Fri, 25 Aug 2023 00:44:03 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6699.027; Fri, 25 Aug 2023
 00:44:03 +0000
Message-ID: <c9706a35-4a61-df51-2c70-d4bab62f9eab@intel.com>
Date:   Thu, 24 Aug 2023 17:43:59 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v5 10/24] tick/nohz: Move tick_nohz_full_mask declaration
 outside the #ifdef
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
 <20230728164254.27562-11-james.morse@arm.com>
 <989616c3-ea4c-1c9b-b857-6d8bcb4843bd@intel.com>
 <fb244874-da8f-ac6f-511f-92861a340abe@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <fb244874-da8f-ac6f-511f-92861a340abe@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0153.namprd03.prod.outlook.com
 (2603:10b6:303:8d::8) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB7959:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d620062-1ed4-4d12-a730-08dba5046131
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XoBoooaWvNciY08/kb7gs6/OlwWWglRMr/Hg/QxS44JdU8MphMD8n+3bdcZUUJYsA7Y93Brg2MuqlDyejDcG6jOvluiaisyzq4H0rdfnuBoQ0dXEGa7zuc9OvL1XUkOuWMS8RUbg672d5zNLAMuIZiyx9ZrK9Jf82IzKTu3gLH1Xo+p7CUEF4xknC6+J9oQDF3osVTenyYNwWJR4cMnw7c2cbl+a9HVQjN8J6Bl2wj2CPRWJKxuhxsxCaukk1gJyBOx/bDQ/F+IGubrzZ7EDgAKVL8D4+424ajfIomwlekd96ovWfNsPEete5fph0SZUEZYe3RxUyx8DVY1Rp5cnCYeJ3xTAUx/MhqODBBh01xkDuoNPa9RFP90U7KbeYCR4CP6r1EIeJ+KE/QBwIJHe+JGzasu/0keyWswKkYGZTOtGiymwIkgXCARKT+snUedAaPxot14D0V+ZBWgFDXg2nHap/oF+7n+oNcy1JJ5ypjgC2rOn87vkHm8dj6KHdFFJvNxa1U74/SqXlgk5oDDUnZ3+YF9xDfo9C9vh/IqdImAqfUUqwx22IOcot1LUs1GH/Q+7eNixEpFt9baPCAQG4C11J3tWjgul3Seaj9H0/X5QdeQRjDroCj4WFNEXc/xl8vrcfJbun00rRRUOpl/gog==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(366004)(136003)(346002)(186009)(1800799009)(451199024)(2616005)(5660300002)(8936002)(4326008)(8676002)(36756003)(83380400001)(7416002)(44832011)(26005)(38100700002)(6666004)(82960400001)(66556008)(66946007)(66476007)(6506007)(54906003)(316002)(478600001)(31686004)(53546011)(41300700001)(2906002)(6512007)(86362001)(6486002)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmVEVXBXQytTNm9tOTkwVXBOYTkyNEtlTDFLWmI0aHFJb05TZW1xZHg1d0Yx?=
 =?utf-8?B?bFlzTXUycFYwTzFDeFJXUFRkblFiZU1QTmowKzZ0cDRPeXFIcE9sWGNKakJo?=
 =?utf-8?B?VEJlall3Wnk4WllrS1I1WHI2RnBvelFwczlZUERhbklOa3JVQjZOVmVJcCt1?=
 =?utf-8?B?NWc0MXRhZlBvd3dwcW11QTlmR1JiYjZ2cnVWU01Dc05oR3pjd0tia1ltQ1ZY?=
 =?utf-8?B?SExMelVOejFZNVhQMkI1dTJoWUZ3clBBS3JrcWgyeUU5MmxXN1UvaWptTWdm?=
 =?utf-8?B?WEZkT0Raa1BwclFQNkVRZ2pjdjQ2TklBVjNja2ZuZXRVVXVVMENOWkgwYnpR?=
 =?utf-8?B?dE40UGZwRzZMelBvNGovdUsyYnhMakkvSXVlYUE2K05hUURpRndpaitpTUkw?=
 =?utf-8?B?Z1IxSksreWpmWm5nVnpJZ3gxQWJRK0dsUHozU0FoUlNrTlE3cE1uTmhGZWxh?=
 =?utf-8?B?VEduOWdnWUJFK3ZsSmNsVEYyNS81OUlyTS9KY3VWWnJYa3NjdlJyTjFtcVdL?=
 =?utf-8?B?SWoyTFNKQ0h4RHJucG9SajRLb0JQak1ZL25tcnV6NTdhbURHaHduWVN6OUZn?=
 =?utf-8?B?b1ZOLytOSy9XanJ0OHNHOXdibXZkR0hvVTlLVWVhK2dQL2JtVktHQ1MyVEY4?=
 =?utf-8?B?ZTBsSVRyNXpFUGJFN01TNDljajZyNmVYMEhyVkVVRDlpRGM5YlBCYjB0Z1Bq?=
 =?utf-8?B?WjlKaEtRdVpPcW83dndzZ2k0empGYytackd3T2w0NEUybGIzL2xwQW9zTGNC?=
 =?utf-8?B?SjdOMmx6a3lqc2FKTVc2RXp3cWZ3MUtkem9mcndscUM5dkowMFgyQk85aHpK?=
 =?utf-8?B?dWhxS0JBb09yWUNMODZRazYzc0d6aEpnU04rdlNFQ2ZoeFpMYzhldnU5ZnYy?=
 =?utf-8?B?TzhVRG5BUUVGdGJTdktwdjNKeFVoQ1MvZU0rOXkwcWxtSFRYQUY1bWNGUlA1?=
 =?utf-8?B?KytWMlRvcW83dnZvbmF0a25mbzlOa1lpNVhESXVxRzlDNzQxVEZENnRCN1JB?=
 =?utf-8?B?NGYxb0dydzJ3SDh6MmRoZUo4WTExalRXdWUwSllpMlptTmVhZVI5d0gzSWFT?=
 =?utf-8?B?YnpSSG9tWkZHR2pOU0ZBSTlQai9hUnNlQmNhSTJjRDNTc1BoZjdUajRJNUdS?=
 =?utf-8?B?K1o4R1FnOE81aUV0UlpTTGpOT1FyTGVyVFh4S204SUJkK0dua0dVUmVZYmxr?=
 =?utf-8?B?Q2doTHFndXhCVUpUK2dKV0hSa2dSWTdxRHg5TEN1bnRGTVVYQUxHVFJyUC9C?=
 =?utf-8?B?cmRuaGwxam55Ymdoc3BqRmFXalhTdkVPTnBtTjFnZ0E4eGcxeWhmaXlSRWw5?=
 =?utf-8?B?T2J2Y3pxMm1wRktpTHJyeW9HdUg2OVpFa05WTmljWkVjcSswU1FvYkRGS1J2?=
 =?utf-8?B?V25Qdm03S2JjZnpCUkhFR0pWU05uUmlONjFSOEFEZGlSazNGdG1GeDc2dE9w?=
 =?utf-8?B?dGdYZFowVlFCTWRpKzFEeVRVUWxBaHo3bDhiUHNmSldDVDFneGNZK1poYlRC?=
 =?utf-8?B?Mm1uNFlPOGNza1I1bHd2SEZDcVF6eTZsSEtkZ2xvYTB3WWZGdGZvdFFJamxP?=
 =?utf-8?B?bnNYVXhkYXVuVytDUjc3d1lkazJhMTZOUkJYa3NkNmdTS1ZpV2NGSXZNQTFh?=
 =?utf-8?B?MlpMRkJvZzVPSmlScFZ0NmpEY1VyeUNGM1N3VjRFdUdOUnAyZlNlOWQ5bXF0?=
 =?utf-8?B?YU8zZkNzbm1IU0ZSM1g3VmpabzFtUkNoTy9ZMTdHeHdtR216ZnlmTkxDcC9Y?=
 =?utf-8?B?ZkRTY05CbW9YMmRwcTJwWFlBK0kyT2NGTG51N2QyYjR1Z0NwWnZndnoxTFV5?=
 =?utf-8?B?UlJlUmFlUkRaT2Jpb0dxb0NkS3VWK24zMHp6ZTNzbkVFKzUxMStyN1VycGRk?=
 =?utf-8?B?TGhsRHhPS1R0YTcrQ3BhL2ZoOVhGZlpCQ3E0RWg2S2dDZUpCUjRpVWE3VjV6?=
 =?utf-8?B?UmJqa1QrbWFEV09RSDlMd1FIdWNiREVablZ1SWtnK3hxMzhaV0g1TUM4U1k0?=
 =?utf-8?B?NEZHdS91NHY0eCt4VGw2K1M2QmpJdnhORE9nK2dZbUxtcEhBbEE2OWNkZXRI?=
 =?utf-8?B?SXJjSlp5WWVQaVJRYU5iMlI2dlhqMHBydzlXYzQ5NVk1bG5hT01FTE1WcWJw?=
 =?utf-8?B?ZG05QzZrQmM5aXhMbUxPeEo4UldyR1NXaUpIQ3l3d295a1RLMGs0UER2RGdD?=
 =?utf-8?B?Y2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d620062-1ed4-4d12-a730-08dba5046131
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 00:44:03.3287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E29lJVY7DojKqQB9db8uJ/z8tCE3RnNwwbC21tqsTtlbq6rg8fVYH8B34Dl6MknjtA4+aMdcPuEUgdkctV+Jcvx+ZqoPUYSk0e9Lo1Hy/kw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7959
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

On 8/24/2023 9:55 AM, James Morse wrote:
> On 09/08/2023 23:34, Reinette Chatre wrote:
>> On 7/28/2023 9:42 AM, James Morse wrote:
>>> tick_nohz_full_mask lists the CPUs that are nohz_full. This is only
>>> needed when CONFIG_NO_HZ_FULL is defined. tick_nohz_full_cpu() allows
>>> a specific CPU to be tested against the mask, and evaluates to false
>>> when CONFIG_NO_HZ_FULL is not defined.
>>>
>>> The resctrl code needs to pick a CPU to run some work on, a new helper
>>> prefers housekeeping CPUs by examining the tick_nohz_full_mask. Hiding
>>> the declaration behind #ifdef CONFIG_NO_HZ_FULL forces all the users to
>>> be behind an ifdef too.
>>>
>>> Move the tick_nohz_full_mask declaration, this lets callers drop the
>>> ifdef, and guard access to tick_nohz_full_mask with IS_ENABLED() or
>>> something like tick_nohz_full_cpu().
>>>
>>> The definition does not need to be moved as any callers should be
>>> removed at compile time unless CONFIG_NO_HZ_FULL is defined.
>>>
>>> Signed-off-by: James Morse <james.morse@arm.com>
>>> ---
>>>  include/linux/tick.h | 9 ++++++++-
>>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> This is outside of the resctrl area. What is the upstreaming
>> plan for this patch?
> 
> Once you're happy with the rest of it - we can give the other folk on CC a poke.
> I'd assume changes to this file also go via tip. It would just need an ack from the
> relevant person.

At the moment this change is buried within a pile of resctrl
changes so we need to make sure that folks are not surprised by this
thinking we are trying to sneak it in. Please note that
CC is currently missing Frederic Weisbecker.
I wonder if it may help to change cover letter to be something like
"x86/resctrl and tick/nohz: Monitor ..." Just an idea.

Reinette


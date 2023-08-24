Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2565F787BCA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 01:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243969AbjHXXFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 19:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236155AbjHXXFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 19:05:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A661981
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 16:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692918298; x=1724454298;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1xvy1T78oQ6pzoiHodv65UAvoigFaf4vr7XfjigZEzE=;
  b=fugtA4g3ey6Q5j59c+Ds5PIpwRCrpLOZBsS0OwpYoR/h0HxNruxduujX
   Kj9QCGMQop2SAxtPAeEvdfKqokHt1GaAvM5/s9rHR634yCDO9OUfJajsG
   sdVx2E0rVewdNvZTL9wlSt0SUeIyf/BXBBROZ44sCBuKIzi0so5mjhJ7a
   596+Fn6uzYtg3P7HaX7vLA72n1h5EPGpmJTbDvCeCxGZRgUYn11wRI4Fd
   vEy8nW8EYC8UfLa4UYZJThF/0JiCTin99mvGB01GEpVXe6bokuUMO7AcM
   K34AXaoPLCoo32mgYi8O0eiVhUosbOFRkFEAQewTCI5PyqvGhrtGkZhgG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="364771055"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="364771055"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 16:04:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="714140289"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="714140289"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 24 Aug 2023 16:04:57 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 24 Aug 2023 16:04:56 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 24 Aug 2023 16:04:56 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 24 Aug 2023 16:04:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VMIjjFZv+5XQ/bSrqtBwwOnRBuLxQgGvBZb07jzptgvAzAv7QHyNV+zV2EdxBBD/TLo+n6eeCKgmT+XApWavsEWLVeL1JMQ/D6XXYfLMGVoFFCsqN3493zRWYDgnMOdvMql0TiB3cxVwIxaezMDVP0a8URO31fLLx59LkoS+GVU+AXm0G1OkHAl4anc6asRgpYqLOwSJhIHz9qckLgCbkyPkMjmDKNvbhl6hYKAHZIvPRuKS6X9x04jc4MZpne63V50kn5WYevHI4sV6TFRq9gvMqTQQVdqtlbEAXltEp38dwxkqikAmH/19e/9EdJUYqCjle49MsLtfsodXDk+Flw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XL1YD8+NOcRQ7QVyXKCeBuZeXI9xWeJjEh6cZYB5Suw=;
 b=lGPdyNaIpHY//I2a6u61WdkRPb95Jl45m2SPQTru24Vwrk7WqZbapMjO0WOn6JHuk1d49ONXr/tCWIG5D/+yTB7dSGttYpzHoRqaev9hRDAobQMYAVQQVce7xueNds98sYxq7Iivm2G/3ZRZxQupVNqu8jSzdzUmwheafTkdeg/aNqyciXp+t906dvJdzYe2JUA/CPAfEAS6YuDmq229NzGq4JNCwCzWib0I/5BJiTQU27z4IRNDUYUueC3UtnwsDyUsefZs+hbta8Sk8j+cE5rdivyf/YKWdELA7GtXLOOI5Z4PQAb+QbsGwReBaGZswHYrrWZmF9M71y19FBS2tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SN7PR11MB7137.namprd11.prod.outlook.com (2603:10b6:806:2a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 24 Aug
 2023 23:04:49 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 23:04:49 +0000
Message-ID: <4f7facea-ffc4-63c3-b960-fa92eb03b04c@intel.com>
Date:   Thu, 24 Aug 2023 16:04:46 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v5 15/24] x86/resctrl: Allow arch to allocate memory
 needed in resctrl_arch_rmid_read()
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
 <20230728164254.27562-16-james.morse@arm.com>
 <d5dc4710-6036-88f3-1081-0759aa956624@intel.com>
 <8ba79ccf-a1e0-d486-178c-5dfb6553a400@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <8ba79ccf-a1e0-d486-178c-5dfb6553a400@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0311.namprd03.prod.outlook.com
 (2603:10b6:303:dd::16) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SN7PR11MB7137:EE_
X-MS-Office365-Filtering-Correlation-Id: ce69d4e9-3b1d-4a18-5810-08dba4f68487
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4sANQ/hbUVQ4tj8rR/R8HHOpkGfzkvsh3mBZBjHYnJhLrQrrK90R249xwJuJs3kg6SxBrWx7RqVBBFaQmElR+oC55zs91qldq9+Zo/RY1a/gjr4A6n0yp3Y1KolH0ygdBsd2yPmGDgb9RKXxfHF3Q3iwHjvLaVBTuvrGNBNn1jID9U+3iNWCcPK5XtYzc+43TTn7xITwhWiYvamZ4iPiyfo2rzb8DCD8/CsU6IDiWE1w7dCIA2KbWknRr3DSTKJeqLZjgnmzAAE72sRtRV9zccboMgGUPPekhnbslEePN3IkPXRQhgOnG2FWWLbXfQEurnPc23Iw4iR9kkbx9U2BtCPzGO1tHoRKasWbUCilIyQlaVYRu2vefFMRygVVzP7EoPGNf8bb9Z4U/lwCKsgzjObeBldB1M+JbI7OlhuFbOyi1vnh06DbfGJFRuFHxScAAMFy+jfDyoq5uPNvyRQBrMahtuCWTuDsTAmXdSN6L0uW46BZZYRBOZEtZ3pGnm2/ParDW80TmKCC0lgOM5/ohcTwtIYk6J/VqpoiFLSYGvLfQxCJb1i+oCT40sYPCdhrQzUqvxNrGkRPSDmFJwmcxnAvhCH7+vpc/PESnKeI6avbGiAncOHIUX+b6s7Jd1Zt6vgexqgpI1YIqRR+Dqrztg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(376002)(39860400002)(366004)(451199024)(1800799009)(186009)(36756003)(86362001)(31686004)(31696002)(38100700002)(82960400001)(44832011)(54906003)(66476007)(6666004)(6506007)(66556008)(6486002)(4326008)(5660300002)(53546011)(26005)(316002)(41300700001)(6512007)(8676002)(8936002)(2616005)(478600001)(83380400001)(66946007)(7416002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1ZrM0xJSnhaRmpNc01vRlhPbE91bGg0NnhmRUR0eVFMZ0RBSmlZN2MrT1VY?=
 =?utf-8?B?WllKQVQzRGNoSlY2S2FUWHJRSWZMeWxnVmlKeW1pMEh4dXJ6V21SdXUwVjda?=
 =?utf-8?B?UjhPUmtUWGRibXJpenhpeWhoZkQ2N2pWb0Fka3BTN2VMeVZuNmk3NUU4ZDAx?=
 =?utf-8?B?WlFrdlRRbjJUUTljbmVhR1BvVTEvczlWbEZMbE8xakRGWitJY2s4VjV4WnZH?=
 =?utf-8?B?dkk2L1BoZFR5K3c4d294Y3UwTk5hSUZjMjZ2MTRudW0rdm00aHBjeHhmNkpX?=
 =?utf-8?B?bU4xNHBvV1BMWno0b2Y2WU9id2RIajVmR0loTlhIZnFTMFJ6L1R5OVZMU050?=
 =?utf-8?B?a09ZN0Rvb3laZjNiL0xISmZleVp3bGhEZTl1MXRadHZXbWRJQ08zYWlKUTlr?=
 =?utf-8?B?Q3l1aTFNd0xCb0dzMmE0dm1JRFRNRUp3YXlXYzRyOC8rS0o5VXgzejhzenZB?=
 =?utf-8?B?RHBVR3hZQ3kvTzExRnlJejFsRHdQeUxXcERzeWRzbHRtZmFxNTYrSThTQm40?=
 =?utf-8?B?M2ZSK3NPbHB3NE1wY3BpY29aSmpoaWMyR2o3akNBNG1aNlJOZ2RkQ2M3Tm55?=
 =?utf-8?B?TWE5ZW4xRUdIa0NjRUM3VGJ3MExzejIwQ2QyQkRSMFMzdDhWN25pOHNGMUc0?=
 =?utf-8?B?TFJmTy8wMW03eUsxeUtoMTNLSVNvbHBFYlFzNHFRZVMwR2xJV2JLbm5maERD?=
 =?utf-8?B?WmtHMHB4d0Q4TUJLSWhKd1NmQ3NHRzhtTWorYVMyRDUvaDBWL1lhQ1JvYU10?=
 =?utf-8?B?YkVPd2ZPTDFMOGo5YUYyTC9sSjR0cDg4ZnpEWTRoZ3Ztd296UmtIWmJwbDRL?=
 =?utf-8?B?bUQrNHkzQ04wS2hEQ2I4U0lDaTJIVlg2bzhDTkxhSGNJTHZDR3FRb01TQlAx?=
 =?utf-8?B?RXFMK1Z0c1ZwS1hQdWhZQjdOdXN6Q0poYjUxbEg2NFZ4TjBjdUd5a2RManJF?=
 =?utf-8?B?eFVJaEJpQVR5ZkRBZHBjb1o0MWpxWjk2RjZUdHRVdjVGdWRKbVlYcGE0L05s?=
 =?utf-8?B?YWx4YmIrTWdwa0NUS0VLY3U0aXNUTnNFbzBScHBWZHN0SGdVN0hEaC9MdkdL?=
 =?utf-8?B?cDhNSXRaZldnL05odDA2dVVyQ0dVa2ljY2hOWEtpOGNka1ZNYTJkc0JNQnZO?=
 =?utf-8?B?ci9lUVdzTlRVTm85cVhITWhocTVoRCtqK3B6ZnBNU1YwYmI0aGtMQW5OUTZP?=
 =?utf-8?B?UUt1dUxrUEVmeDdGemxUUTZmT1dEOGpTZDRQWEYvUUJNUER0QU1odnpucVFY?=
 =?utf-8?B?bHpiMlBKSjFUQlMxUWM0RTdUeGdJam1NaDAvbDh0RllDMlV3dld1SDl2TmlX?=
 =?utf-8?B?Tk1yUU5WekVsalZXZmZWWE54QjdtQitZeEdxckJkTkdQbTFZTWZ5akthbU9D?=
 =?utf-8?B?aXZwbmJzcFBMRTZ2WmQ2Z3BRNXRUb0dyVmRRaDVLR0FLbHFkem9SekRscTRK?=
 =?utf-8?B?R21NaldIZi9sUFpPajd0UzFMNUF0ZjlKMnZydzRjZlEyL3NlVFlIajFJeE1O?=
 =?utf-8?B?SmQ5WUVMYnhIWHdWbThYTWd4YVpZTG1udVhqQlNJK0NRZ3Jyb0NrWnFVWWpB?=
 =?utf-8?B?Sy9VUXFick04ZVVVQnNOY0pmY01zOVJ6eE1pbXR1QWZUSTN6MVFMQ0RXUzd1?=
 =?utf-8?B?UzgvRlJWS2RySzlJOEJYOHFkd3RSVVVJR2dlOUtkdEIvcmdObXZqN2VpQ1Rv?=
 =?utf-8?B?azRiaE5PalYrbGMydmkvRnpGVWd4dnFycnZsM3ZUdWNPMGI2OEQrWFYvclpY?=
 =?utf-8?B?Z2pCa1JvNW9acm9QSmZCTitaNTVGd3VCUXZ5VkVaa2V2a2tvc0RiMFlyZ0Zo?=
 =?utf-8?B?Ukk1SzFMUStSQUphMkVBVG9DcUlZb2ZyT0FhbVhCWjBCdWE0UGZETVpLQlYv?=
 =?utf-8?B?cklFeUp3eWNpVkpFcm1VNFoxNUhZRDR2dTdIOUVSdnlnSElSdEMzdVM1dXZE?=
 =?utf-8?B?WDRrVHR2d3N2ZC8yOFFqNHBna2xaQzA0OHl3WWpVOEFsZWZOZUN5cEh6YlNo?=
 =?utf-8?B?V3RKWFdwMUI3S2w4M3hJNVBLZjFMTVVtakpXUnVWc1FSMWVVajdyZFRhYldE?=
 =?utf-8?B?V2pZVTZObmovcGtMOUgzZzJxM21OR2V4c2tqR3dJd1BSWU5waVJGaVhVWHpE?=
 =?utf-8?B?U2lVTE5tM3NwWTFVSnRqdVAveWgwZU5IVFBTZnJOaTBPZGk1NE8zcnFRTndN?=
 =?utf-8?B?Y0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ce69d4e9-3b1d-4a18-5810-08dba4f68487
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 23:04:49.7377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vNf5FkPSIrfodZ0kxXnoG2iFxtj7Afq9e+NRissU5NdkI+4Ld0kzyN3tWWOrssYgeF6DgMrltaxnLtXdntjLgFF7pzxXoBZuDPdFA9s4Mck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7137
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 8/24/2023 9:56 AM, James Morse wrote:
> Hi Reinette,
> 
> On 09/08/2023 23:37, Reinette Chatre wrote:
>> On 7/28/2023 9:42 AM, James Morse wrote:
>>> Depending on the number of monitors available, Arm's MPAM may need to
>>> allocate a monitor prior to reading the counter value. Allocating a
>>> contended resource may involve sleeping.
>>>
>>> add_rmid_to_limbo() calls resctrl_arch_rmid_read() for multiple domains,
>>> the allocation should be valid for all domains.
>>>
>>> __check_limbo() and mon_event_count() each make multiple calls to
>>> resctrl_arch_rmid_read(), to avoid extra work on contended systems,
>>> the allocation should be valid for multiple invocations of
>>> resctrl_arch_rmid_read().
>>>
>>> Add arch hooks for this allocation, which need calling before
>>> resctrl_arch_rmid_read(). The allocated monitor is passed to
>>> resctrl_arch_rmid_read(), then freed again afterwards. The helper
>>> can be called on any CPU, and can sleep.
> 
>> Looking at the error paths all the errors are silent failures.
> 
> Yeah, I don't really expect this to ever fail. The memory arm64 needs to allocate is
> smaller than a pointer - if that fails, I think there are bigger problems. The hardware
> resource is something the call will wait for.
> 
> As you note, it's hard to propagate an unlikely error back from here.
> 
> 
>> On the 
>> failure in mon_event_read() this could potentially be handled by setting
>> the "err" field in struct rmid_read ... at least then the caller can print
>> an error instead of displaying a zero count to the user.
> 
> Sure, that covers the one a human being might see.

Right.

>> The other failures are harder to handle though.
> 
> I don't think the silent failure is such a bad thing. For the limbo handler, no RMID moves
> between the lists until the handler is able to make progress.

ok, so it needs to ensure that the handler is still rescheduled
when such a failure is encountered.

> For the overflow handler, its possible an overflow will get missed (I still have an
> overflow interrupt I can use here). But I don't think this will be the biggest problem on
> a machine that is struggling to allocate 4 bytes.

As I now (I think) better understand for MPAM it is 4 bytes of memory as well as
reservation of a hardware resource. Could something go wrong attempting to find an
available hardware resource that as you state later is indeed scarce? I wonder if
it would not be helpful to at least have resctrl log an error from the
places where it is not possible to propagate the error.

>> Considering that these contexts are allocated and
>> freed so often, why not allocate them once (perhaps in struct rdt_hw_domain?)
>> on driver load with clear error handling?
> 
> Because the resource they represent is scarce. You may have 100 control or monitor groups,
> but only 10 hardware monitors. The hardware monitor has to be allocated and programmed
> before it can be read.

I think I misunderstood what "context" is when I wrote the above. I
was thinking about memory allocation that can be done early and
neglected to connect the "context" to be an actual hardware resource.

> This works well for the llc_occupancy counter, but not for bandwidth counters, which with
> the current 'free running' ABI have to all be allocated and programmed at the beginning of
> time. If there are enough monitors to do that - the MPAM driver will, and these
> allocate/free calls will just be looking up the pre-allocated/pre-programmed monitor.
> Doing the allocation like this keeps that logic in the mpam driver, and allows concurrent
> access to resctrl_arch_rmid_read(), which is something any future PMU support will need.
> 
> I don't have any numbers how many monitors any platform is going to have, but I'm
> confident there are some that won't have enough for each control-group or monitor-group to
> have one.

Right. My question was not relevant to what this change does. Sorry for the noise.

Reinette

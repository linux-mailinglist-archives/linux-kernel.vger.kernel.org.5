Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A979B7E602F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 22:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjKHVtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 16:49:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjKHVtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 16:49:50 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCCCC258D;
        Wed,  8 Nov 2023 13:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699480188; x=1731016188;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zNkBUQLFBpVGY8Zo6PwAaUyId7MNY8X1l0u/ChRFBkg=;
  b=irbnMFdInirMdt/odCP2e2UcG1fCDEALxFTkfv24mFs5KF3Uivt9NBsE
   BkDTGjXuFHYO0jOQbqpWwoeb6sY/DNY0W3zOjfven+xsx5pvERKiFmnVH
   i6opuoocDBD6DDHn8QuMKymLhjCSxPbIPXwmDoPCYtUzd6fNn2/yRgrjj
   IG6W/63PkTn+QKgz3UE5X/woKBif+m1co8SFtDhVmfeiBsRmakY8j0K2X
   nCEOpBx8YQUSg1HVyXwrA5RpXJteAeWwIgbjsO8bp5fmxBvmSxKLZ4OJw
   6tlmKaxZc+BrAGt4Z+psYQcqFuTTpOW1UdwfbyLUNZowWkpc1hx1aW4jO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="393774148"
X-IronPort-AV: E=Sophos;i="6.03,287,1694761200"; 
   d="scan'208";a="393774148"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 13:49:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="1094647726"
X-IronPort-AV: E=Sophos;i="6.03,287,1694761200"; 
   d="scan'208";a="1094647726"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Nov 2023 13:49:44 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 8 Nov 2023 13:49:38 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 8 Nov 2023 13:49:38 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 8 Nov 2023 13:49:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PKFQBoClK1IKPidVH2LPvQKv0h+lhgRSxlgXv7A+JajNTKrsEgPsZUDdx6zkGiYMGA8NC9r3yEtzunW4JOluSP/3cH6f30Nv894H02blztgUlwrf64MVqX2oO2klrBsxyvKI8vLuD9UXcL/mTnx1jRfeN7cwSi8VW9Z3TCFSQKnDC+86B/II21C74955KivumqS2eKs7IbgtXUiBNT3USW4KU0pHxQ2ef7xTB/uKbxfT1d9CQWK8iFOmQtUaE7NBNXb2juOPFhjV53eLqmJAD/mBy6uAcMqLCMleYYpsSPT5Q/dSWV7whl+fuqqMKY9x3qIT59uWSOFks7vQmh+Z3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UCbcZiG7IJ/cF/JFgwysiHZxZZeQ6hc21AVijvKQ3EE=;
 b=Nm6siohUzGnwdFA1UErljHSq5eyGQ/Xkv+BFlqws7tSMJoz/U86tZ9+1XjNRBiqCQv54EBCOH8M8DRjinFj2dkOzG6ZAlspuSriIsiVd2nzaZEyNWTNgtEIXdPMpkyBXAnoEd2dFlwROO4SqudAiBqFCdo/zn2pxVXaNr8yu7VMXbpGH+IdTKEI+ZwPEmmJCmryNXcKFBT4b6PLqb6Z5Orm7KLJ+oPn7b/YsN56Fr8Rrs7OhyXKruGKXW2j8eyyi7yTGQnkAWti08CGtdTw32inZ00JfGglhz+U3P0guB+az6Rx37XLl7nlmCNAXMUPYaKHDovd9bGKXt9BXHbVSvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB6171.namprd11.prod.outlook.com (2603:10b6:208:3e9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Wed, 8 Nov
 2023 21:49:35 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.6954.029; Wed, 8 Nov 2023
 21:49:34 +0000
Message-ID: <1a198614-d79e-44c0-b4d4-0e1e0d0c04de@intel.com>
Date:   Wed, 8 Nov 2023 13:49:32 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] x86/resctrl: mba_MBps: Fall back to total b/w if local
 b/w unavailable
Content-Language: en-US
To:     Tony Luck <tony.luck@intel.com>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, <x86@kernel.org>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <patches@lists.linux.dev>
References: <20231025235046.12940-1-tony.luck@intel.com>
 <20231026200214.16017-1-tony.luck@intel.com>
 <0cee68e9-e188-46e9-83a8-02259a9c081f@intel.com>
 <ZUqo+MsEQi2Xc/pO@agluck-desk3>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <ZUqo+MsEQi2Xc/pO@agluck-desk3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0320.namprd04.prod.outlook.com
 (2603:10b6:303:82::25) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB6171:EE_
X-MS-Office365-Filtering-Correlation-Id: c1adbe52-4589-4a4a-2238-08dbe0a498c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gpBoK5iiYQq6kb4aQtqFk1rUdvYmXJ6d3Lh0ro7NFK8mJbaVp3e3ngdSL53/cbDyEW0UlwJxXwgUvkXOZV+3dFVy03Iw7IML+nGSGBXPtuYupFd9BXDJYyupqEaPO1cfCGkeyj4cC4TocKvOCUHsxgiRn1O8mhkrqiA4eKYGGndwJqy9qzTCvmlxUzdEoNdVMfPgKWb5PtPRybA/WID5ZSac37R0NhkPpFx331s5ZUtkfBshDc0V/4VD6dmJvtaN2zwGmwTKxnsCkIUZbltX2D1QDk1SVzqvr7NhR5QVjRJ5n9QZhf8rvW6MFPEe0TAQuO/i2iqlxxhq+JTUUat+c7rdnJvwDasHKQGXB6/8cIW5TKqFtIp0MRayrxb9Qd3n8hH4MCyoK30GChWi9/xq7wXMsA98SMZRHc94+ZLWV/QG3tl9owL2XJxdVbmbTLlNmF/HH+4d5XrUaHWx3OFPiCk9rg46i62RPvxGjXrQs/csJDqWn3aY/eVPumAqbSjNgdlf7VhqjusTUtYN/XFriTOXYvZRRtcaePoQ3tjtcgQQuA16V9LqjEw6TmoqhaWNz7hUyp9TfLjLEd/8l8W8hXfGzW01q8ET7nea+XwBoDDUEsFQJg8aUmz0e+qpnzKWAM09wLQxsvChmaKt7+x7YA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(136003)(376002)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(478600001)(41300700001)(7416002)(53546011)(6512007)(6506007)(2616005)(6486002)(83380400001)(44832011)(8676002)(8936002)(316002)(4326008)(2906002)(5660300002)(6636002)(37006003)(6862004)(54906003)(66476007)(66946007)(26005)(66556008)(38100700002)(82960400001)(31686004)(86362001)(31696002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVNGRnA4bjY0Y0VjRnVucnhDWFRUYVJPZUkxV29zY052OVBLR2IyV1NlUXRn?=
 =?utf-8?B?VWFobWVycTZNQTR3WUVwOGVFaXFUMmQvSllmVHdrUCs1VkZSUG5pSGFHTkZ0?=
 =?utf-8?B?ZXB5RW02Tk0yakVoTVBCK0p1aENZOG0raFJuZHJwZ3VEUCtZNDFUcEo2V3lC?=
 =?utf-8?B?WnphTjI2VkFZMmNHcHlFNllBN0NJeU01anFjcDFmNmM4Sy9aVFMwQ3dzb3ZW?=
 =?utf-8?B?MDZ1TXA4b25zVWYvdms1R1JxUlptVzNhQS82REF6THErNDd6UGNqaUVxV21p?=
 =?utf-8?B?L0xRV3RjZ3NhcUllblAxYmpPb3IyelI3R3RJUFRQQkpwUm1VZ0NNM0ZXTEt5?=
 =?utf-8?B?enpNWDc2UFJMV1lIWnhLSTJOWS9KRDBBS05YcFV1VEZaeUU4MlZjVnlsdUxX?=
 =?utf-8?B?c1VQeHVyMFpCS1JSSTkxdGNGaGcyeXhmRnRvM1B3QXBQM2FVaitnNTRITzNG?=
 =?utf-8?B?ODJFbjF1b1dRbThySmxjZkxOclJCaEhpNW5YQkt5VjUrdXRJY0JlNHM0N3pt?=
 =?utf-8?B?R2pwcTByQzl1eElVRGcybm1Ta2lWNCtZZVM4TFQ3NDliVnFLd3RZY1plcDZa?=
 =?utf-8?B?NjlMbTM3SG9COXZDL0Z1ZGVzQndHVUZMQ3dPMnBWQ21aeXRBQkYxRVc3K1g3?=
 =?utf-8?B?WmZ3cjA5Sm5wZzdXQ0lNcUQ3VFJkbmkrM0szWUdmTlQxVXlHUHMyMXNTek1t?=
 =?utf-8?B?ZTU5Y3pGTjA1aFByTEJyTFErV3FWSzBzODBXd2RHMlhYV0l2ODlCdWJtUE8v?=
 =?utf-8?B?Y3YwV1JBK0FWdWJ3eWZiRkoyVzREcG42b3BpQXBtS1phOXFFWmkvaEVOekpm?=
 =?utf-8?B?bmpmN1pvT1NiWCsyekp0bTlJVGtYMWY5aTlCSXJqQnRTakRGcGZTcjdxZm9r?=
 =?utf-8?B?TWlKN1hQR0RwSWM5ZVgwSThUNng0dnFLOHJRQ3BFUnVkWWpya0NrWXVHV1ZY?=
 =?utf-8?B?MlVIZ2FRTkNILzYxSlh0QVhBQVBHNTBZRGNKSHlxQ2FLYVVBankwSFFYdEdz?=
 =?utf-8?B?eDVhTE5jTFVQUXlhODlscGg5VDVDSHpVYUhtMWRVM2lwZ3JvUzkxUktDVUFw?=
 =?utf-8?B?dW82M2lsNmZ3SDE2VS9HMkJ5NXBnUlBSeE0vYlRINHJEdzFvSjZIQnhMWEJk?=
 =?utf-8?B?K1FFTFg4NHpmRjR3bGQxWTVwczRNQVVXQVlzVndSR2VGMzdMaFFNNHRHSUJG?=
 =?utf-8?B?Q3kvSlpib0NyVG5CakR3VmtTV3lXdDhDaElRWnJXNU1majRBOTZvYnFaMkt6?=
 =?utf-8?B?QlA2VnhrdnF4OHBZeTJWSzVPdGRGeFl1UDk5c3F4NXVLSjJ4SHpBNnU4djJr?=
 =?utf-8?B?N2thSFNtQlBYMkNhd1k0aCtwbEIyaldLMU1WUWI1MUdnT0ZDSkZ5ekFNcWI1?=
 =?utf-8?B?dFErSW1FUHJWQTFvVzNGeHJLMVVva1BvS2F3Q25OWTVlMHU5clVlWGhGSzdi?=
 =?utf-8?B?NEV2SkxBR2hzU2NFQllVaHZGZ0RpeWdWUTZ1VS95U3QwY290NFBRUjRVQU5w?=
 =?utf-8?B?bWxhOGpPYVhtNFIxUlVGcHUzbHB4Q2dydDY5ck0xVThFaWM2V1JYWWs3YlZK?=
 =?utf-8?B?aEs2VDQrVVZrQzV1WEdiRUZsbHhIRXNTbGl3N1gxUDh5ZVFJYzh1bDYxV1Vy?=
 =?utf-8?B?RWJKanBGOUZWUmE4RmtRMHFuUStvdXNBMTB6VHJKZDZPbUt0UDBwUTVTaUtI?=
 =?utf-8?B?c0RqVjZRS1hMeVFkN3dnN2UvbFR6c29DS3dVbFovaEhMVk9wRG5iVEEvWTVP?=
 =?utf-8?B?QmhsbWgwRlhIdnUwdnZya3pQZDJMYjhqV3JRV1NrNktwVUJoa3IrTlVvMElp?=
 =?utf-8?B?N3IvMEg4cnNZeFNhc0lmSFpVODVMekI1MVQ2OWN1SFZ3NWI2Wm9TdTlSb21y?=
 =?utf-8?B?UXQ4NDQ2bGloUFpVMHVVSkd4TGEwMkIwR0pYQ2s5TUswL2lxMDhFSHUweEFx?=
 =?utf-8?B?UmVvZEhpL3hacTdzeTR4aFVxQjg2OUVzQ0lWNWxaSVBQQUlYSmRLaHF4VVQ3?=
 =?utf-8?B?K3RjeE9WcVNrR29LQXBjeXhPRWtZcjRFUTJ4WTdpZWkyaFRrUmVkNEtjd3Zk?=
 =?utf-8?B?TTRIZjFTak03d1VCVVd0ZXg0NTBaVm9tRmJmT1RHYnQxRDYvRWdrMlBpRk5q?=
 =?utf-8?B?UzMvREVvK2VZU3ZGL3p3TktjdW5VeWF0VzVnSFZLeXpNVVA3SmJMV1l2N1Uy?=
 =?utf-8?B?Wnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c1adbe52-4589-4a4a-2238-08dbe0a498c6
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 21:49:34.7545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yUbSViF1jBLhz1kYKOPeFt1lIK4da3dJ59VKhVCWO0IiEOgaAXppFjuyUmKUhI0HcmzOroadz8XDAR2ulpERjrNrF/ky07770nrWP4UVNr0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6171
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 11/7/2023 1:15 PM, Tony Luck wrote:
> On Fri, Nov 03, 2023 at 02:43:15PM -0700, Reinette Chatre wrote:
>> On 10/26/2023 1:02 PM, Tony Luck wrote:
>>> If local bandwidth measurement is not available, do not give up on
>>> providing the "mba_MBps" feedback option completely, make the code fall
>>> back to using total bandwidth.
>>
>> It is interesting to me that the "fall back" is essentially a drop-in
>> replacement without any adjustments to the data/algorithm.
> 
> The algorithm is, by necessity, very simple. Essentially "if measured
> bandwidth is above desired target, apply one step extra throttling.
> Reverse when bandwidth is below desired level." I'm not sure what tweaks
> are possible.
> 
>> Can these measurements be considered equivalent? Could a user now perhaps
>> want to experiment by disabling local bandwidth measurement to explore if
>> system behaves differently when using total memory bandwidth? What
>> would have a user choose one over the other (apart from when user
>> is forced by system ability)?
> 
> This may be interesting. I dug around in the e-mail archives to see if
> there was any discussion on why "local" was picked as the feedback
> measurement rather that "total". But I couldn't find anything.
> 
> Thinking about it now, "total" feels like a better choice. Why would
> you not care about off-package memory bandwidth? In pathological cases
> all the memory traffic might be going off package, but the existing
> mba_MBps algorithm would *reduce* the amount of throttling, eventually
> to zero.
> 
> Maybe additional an mount option "mba_MBps_total" so the user can pick
> total instead of local?

Is this something for which a remount is required? Can it not perhaps be
changed at runtime?

> 
>>>
>>> Signed-off-by: Tony Luck <tony.luck@intel.com>
>>> ---
>>> Change since v2:
>>>
>>> Babu doesn't like the global variable. So here's a version without it.
>>>
>>> Note that my preference is still the v2 version. But as I tell newbies
>>> to Linux "Your job isn't to get YOUR patch upstream. You job is to get
>>> the problem fixed.".  So taking my own advice I don't really mind
>>> whether v2 or v3 is applied.
>>>
>>>  arch/x86/kernel/cpu/resctrl/monitor.c  | 43 ++++++++++++++++++--------
>>>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |  2 +-
>>>  2 files changed, 31 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>>> index f136ac046851..29e86310677d 100644
>>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>>> @@ -418,6 +418,20 @@ static int __mon_event_count(u32 rmid, struct rmid_read *rr)
>>>  	return 0;
>>>  }
>>>  
>>> +/*
>>> + * For legacy compatibility use the local memory bandwidth to drive
>>> + * the mba_MBps feedback control loop. But on platforms that do not
>>> + * provide the local event fall back to use the total bandwidth event
>>> + * instead.
>>> + */
>>> +static enum resctrl_event_id pick_mba_mbps_event(void)
>>> +{
>>> +	if (is_mbm_local_enabled())
>>> +		return QOS_L3_MBM_LOCAL_EVENT_ID;
>>> +
>>> +	return QOS_L3_MBM_TOTAL_EVENT_ID;
>>> +}
>>
>> Can there be a WARN here to catch the unlikely event that
>> !is_mbm_total_enabled()?
>> This may mean the caller (in update_mba_bw()) needs to move
>> to code protected by is_mbm_enabled().
> 
> All this code is under the protection of the check at mount time
> done by supports_mba_mbps()
> 
> static bool supports_mba_mbps(void)
> {
>         struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl;
> 
>         return (is_mbm_enabled() &&
>                 r->alloc_capable && is_mba_linear());
> }
> 
> Adding even more run-time checks seems overkill.

Refactoring the code into a function but then implicitly assume and
require that the function be called in specific flows on systems with
particular environment does not sound appealing to me.

Another alternative, since only one caller of this function remains,
is to remove this function and instead open code it within update_mba_bw(),
replacing the is_mbm_enabled() call.

Reinette

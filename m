Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329FE7A68C3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 18:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbjISQW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 12:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbjISQW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 12:22:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F6392;
        Tue, 19 Sep 2023 09:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695140541; x=1726676541;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WgN+QNXzHH9MX6TYItG7yCGk+xi7fBfC1h5Xj7LUPnY=;
  b=bC+8Ed1+G0NgviJknS+DLzOKIlZUFU6EBihh7H9vbSegqu55YiiNU4MI
   eq1CWP7exh9gAo63GpXOoSU6oTnUJmoTbdcfhWn30whY6CiiWmAtx47iK
   EJam/V29+ZtKZ/JHHenfFhLK70XaGb3s8O4rbYhBUa51tnr0Ioc3SB99I
   Fh0hvzk8S19CB1A/e0i1NbxjlH/mWjb4M9qWDIDU4E0s49VE0nmkPZUV/
   4aex4gOrFXs/qPylH7g3jaRS3kn0xs7n1PStcAvkFPjIouUpLtuFExt+X
   UEcLBAx3vII2FjRPUkWJQwyLGGKEz8qgC6zDzlvcMBk/NxrwTNMTQfKtu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="410916056"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="410916056"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 09:22:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="836490947"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="836490947"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Sep 2023 09:22:20 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 19 Sep 2023 09:22:20 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 19 Sep 2023 09:22:20 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 19 Sep 2023 09:22:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ca9GLJawRkQq2UPvzmHjeZM94B9ayrPzEoM0DmB/bAd0kpBHRnHfFh0CPZpShmsng8GVaSUVGlN0w14ccWFTKNlfApcOx9HoZvmOKra8rETmU+f+uo+61Xg66dUdY71soR0q/KqpRup8Dwigoso+birCc1TSuxzdpYz1pPyzxPG3GuOmlEQEVU/yG1jF6KK7EKCCShRu2CZRTLBkI0yQdsPwq1Lpd1fKohT2zlDmA+0/zgjV3pbZQi1KTQKzPIS+rHkGaeY3LW0MJCXvEN0+EbHFiaP0MZQYKCFOUCzHsqOC8XtGE4QeR3Yal3YG0EbOyyy387mXPksPwIEjmvcwkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/VA0wdEgqCJLFK/yZLCknWziTDxi9m8oruQYll2yyFw=;
 b=IZnnOaVvp1n3r26mKwHmhSy0ofc3Yk2e+tmkDxtJDVU92TmpjRZ6+ugPiYrID+KuWZ0ucMagB7qCE9i4MdnOxeLMHNVHNn2LDxr6EvlDXnAYYMDTlta7YLNymbjWHXGLH5HY50tK3A2Dgpba3hWzbwJ7dPJEUfWmr1Zl+2uBhhnvvMfzV2UNaZQERhYiZNKuCgK9Y1CKtf7bijfhcDg0tvJr4qeRoenaZTMvpd/l99EyDG1rHXqFN4lf8nG3QWkMkzjEu0R7pqG+skiweRG0VWQpkYbY3pCVVp6HGbcW9lDIrpZSS+GzQ21kuVku0bGn/CDLRGSrzcU/Pm6At3kVyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3768.namprd11.prod.outlook.com (2603:10b6:a03:fa::20)
 by SA1PR11MB6616.namprd11.prod.outlook.com (2603:10b6:806:257::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Tue, 19 Sep
 2023 16:22:15 +0000
Received: from BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::fca6:a86:a250:ad54]) by BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::fca6:a86:a250:ad54%7]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 16:22:15 +0000
Message-ID: <274d2502-4304-b8bd-ca42-5d53c8c778d9@intel.com>
Date:   Tue, 19 Sep 2023 09:22:12 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 04/10] platform/x86/intel/ifs: Scan test for new
 generations
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     Hans de Goede <hdegoede@redhat.com>, <markgross@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <rostedt@goodmis.org>, <ashok.raj@intel.com>,
        <tony.luck@intel.com>, LKML <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <patches@lists.linux.dev>,
        <ravi.v.shankar@intel.com>, <pengfei.xu@intel.com>
References: <20230913183348.1349409-1-jithu.joseph@intel.com>
 <20230913183348.1349409-5-jithu.joseph@intel.com>
 <74882e91-f41e-7672-3835-d74f1364bbdd@linux.intel.com>
 <5a66a02d-3504-ab5f-5373-789c8789557f@intel.com>
 <d94e516f-6331-2f20-468-bb8c6cf899c4@linux.intel.com>
From:   "Joseph, Jithu" <jithu.joseph@intel.com>
In-Reply-To: <d94e516f-6331-2f20-468-bb8c6cf899c4@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR11CA0046.namprd11.prod.outlook.com
 (2603:10b6:a03:80::23) To BYAPR11MB3768.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3768:EE_|SA1PR11MB6616:EE_
X-MS-Office365-Filtering-Correlation-Id: a5fc75a2-aaa9-4009-8ba7-08dbb92c9636
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s024lji56cR+rdGhmjbphyJlQ/ANWZ++bjK6ena4s4lC4CKrWMj7hlL8MWdH/cnhy5fq2m84R/CA6Amzgvy4XnS0EtZ75Z54HQYSUG8NRRCfqY9cRvwXHYSuYMz4nO6to4u4ff+HwG6Sv8snXnV9mcmLOkVVqbTdQkmDLfdjff4EK71vFqXxT0XMLG7iP/GR5qRpZNBsxsmQ/XP/gcTnHNBKmjfpouRwe3EZf83W+a0wRq05tXhkIiUiMTEMgVbr3vd0hi32HqbnRQutoNCnJKHRu1xZHQK/FTpR7DafnhmjXPjNCM1IwiQ4KlVAQduicx/uzYEhe18iqiZOoKm761zkCk3ZdY/zFpp/rPER9W4tYgvcZyCRuYrQQYkDiJSXGGGXdfiTtAsMOWIsaKMNwrJMxRjIqTmCTtp2a2V9YjQazLA64KsBrJbLqI1hIutU3SBdPjUEMnkouoW+DeRxSQtzYvkYMgUxHPb93DgreWBCkzQwcJWc2ppdvAiZkWn96+YpCDYCoiDY+PLT3ESG6LcG7siUTzTXm5sY/jUdiseo6pYA8NRlm5eUoPrqAvr2oQE1EL3DreBB7dC8uQNDb5/y3jCVCA4yh2oiBZm3+S+/HvY9Wda2EQkn6QaH4BsiuDL49EHFwhUfyM4K7cKL0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(39860400002)(376002)(396003)(1800799009)(451199024)(186009)(6512007)(2906002)(26005)(83380400001)(2616005)(54906003)(6506007)(316002)(66476007)(6916009)(8676002)(4326008)(8936002)(41300700001)(66946007)(66556008)(6486002)(7416002)(6666004)(53546011)(5660300002)(38100700002)(82960400001)(478600001)(31696002)(36756003)(86362001)(66574015)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlVzRnRjQ2ljUnM5SjdISE9qSGNFOEpUK2NaOE9HM3Y4ajVoaDBBZEsybnVj?=
 =?utf-8?B?SDJhejFjUEtTRWNWZHpDNml0WHhjZlZQdXMzTDZabzZXL3VnTnNGWlVVeVFn?=
 =?utf-8?B?Q21NdFBSaGtuQVErWHI2NXBxa3Z2WnBWSHVyKysyeEIrZWNmZllyVVNYNHA1?=
 =?utf-8?B?MFRTMUZmSnpJbDhnblBoc3pNcWVJTTBsa0x2bld1THBxbktWamVSRTQ4ajBM?=
 =?utf-8?B?Ni94YXM3Y3A1SmdVMGFDTnlJZ0szRjNLWFQxcDhtdHBDTXdWa2NIU0Nienoz?=
 =?utf-8?B?OHdyVVJuQUxVVE1ZRFBOc3dLU3NzWnhMZmYreTlzU3NWZEhxcW50d3NtazAy?=
 =?utf-8?B?L0phd1pQdW41aDNJaGU3L3BkTm9MakcxbldTZjZ2eHF4VS9hVlUrSHJEdkZP?=
 =?utf-8?B?dUVHb2NnM1dydVJVTENMdldXTUNHbjlPVmNLTFNxZTJqcHJWd0xTMkVDRjAy?=
 =?utf-8?B?b0ZXb3c0aUlCMW1aVGh0RkY3TGpHRi9OdTZJQWVEUHYyTDE5SDBDbW1oWWNC?=
 =?utf-8?B?OFpTRFBJb3dnZkVOSG9raVUwamlyRjR0cVlNUTU2ZFJPYW1yaWdzTExhQS9a?=
 =?utf-8?B?L0ZtMGtpMTRBa2RHTnBqUnRJQWo4MDBndG80U0JSUVNIK1FPL2dkVTRLNE9i?=
 =?utf-8?B?K0hSUlMrSHdGY0xBRExmUHhLZUg4SEVXSSt2MmpwcDAyVThCclBKaWF5cmtp?=
 =?utf-8?B?TUxXeGFUZGJkTWxJT1dGOTRTd3RqYk1kT3RoczNwektjaG1wMTJteC93N09T?=
 =?utf-8?B?RGRrNTc0bmRyaHpBVU9ZSCtBQXNWdUMwZGNYQ294OXBjeWgzc24yci8yaWZy?=
 =?utf-8?B?UHFKUTJzQzlBT2wxb2dQZERuTzFDSkpBT21LQVdsR3QvY1RTMmtOR0U5SlFu?=
 =?utf-8?B?QzRWVWpvNDQ5N1c4N1Rsa3VPSjJDMWJKbzhFeVBxRFBpZFlMdlpQV21yeVRI?=
 =?utf-8?B?ODVrc3gvajBiMGUwN09lN0ltc1RTb1hPaTdSVGx2Rlo2NllSc2pJdk55N0Uz?=
 =?utf-8?B?RnpqMHpjOTh6cGlpNzZvZ2lnOWlVTDJ6QldOcDFYMW0vRklQNTlMUmYwVXdX?=
 =?utf-8?B?N1pFUFVmSGN2T3c2WU9Edlh6MlcxMGUvUDRudWZYdDJYbndLQjI1TEVsNDFH?=
 =?utf-8?B?V2tFRE1GK1BRSDVOU1pTUU9Tbmk1aXBzL1lWbFMyemhtNlFCbjZpaUtpcFds?=
 =?utf-8?B?M1RPblgyRE51Z3BpM3VFSXVpZzF5QmdHalFONmJ5enFSRDcwb3dGN2VBZWJB?=
 =?utf-8?B?VHRDS0dQeTIyVkVFNm1kNysrSFJzYjZzVy9uUk8rWjBqK1g5VHV3Q3Vhd2E4?=
 =?utf-8?B?WnpBMnNtSUFuRy95WUQ3V21jZzBGMTFlS2p1WWNrTkNLYW1VbGliekhJQms0?=
 =?utf-8?B?T0RtNTJJMXdheHZ5Wm5CZXVoMGxvVllNLzBrNGZIVGVnTU9qV2huZ0E4WndI?=
 =?utf-8?B?bHovRXZ0RlB1U0RxYUcxVllXbHJMc2ZLSUFKRS9DaUh1bTFtaFBTd1BiYjY5?=
 =?utf-8?B?RHpMWnpQR2JodGVINUxCSFpUY2cyTzJSUG1mbjk5M2dLVUt5RnN5UURNczJS?=
 =?utf-8?B?YUhIelo5N0pEc09STWVzZWpDTWdDcThWWlZkM3NPNVNGSWpFSGZRMUlMWjl2?=
 =?utf-8?B?NVIwWVhzVGJ4YytNcTlSUDV4cDRRaXJjNDNYci9jOFhHMFpxd0cxTDlvMFlL?=
 =?utf-8?B?ZHlwTnZERnZRSVdmaml6dk5MKzBpM0R0Qmw1L0RDRTM1VllxejRLZFZPQzZT?=
 =?utf-8?B?b1VEUmtEREZmcUxHc0hqR0ZCQUNIKzdFU00weWFvQWdrei9OdHJUbkZmWkEx?=
 =?utf-8?B?dWJuRWwwN0NoTmJWTkJzVkcvamIrbjVaNDZxbStVbUxSOTNseGZuUDZqRW1m?=
 =?utf-8?B?U3oyUWxCemY4N1VsUGRUMWs5dzAySTg2eGdNSk1DazJLazdXRThJdVFBUUNo?=
 =?utf-8?B?bEhhbEdMY2E2Wm81OVVVNU1lV2MvR3Rpa2pldFhHd2E0ZG82YXNMQjZhc2Ry?=
 =?utf-8?B?Y1hjUnFrQ1puWlhQTDR6dEhwYmRraVBXOURBK2VlbkVIT0lhb3lqR2RjV3Np?=
 =?utf-8?B?cThaQVZmRzFoNzNLRStjamlnOGlpclJXWFdGSTJxM1M0TWdyWTk4SkhjYmd2?=
 =?utf-8?B?WTRqQUp3d0QrZFBUUWk4cGovL1lwTWFGazdoay9KWFpVYnhuZ25uYm9OUnBo?=
 =?utf-8?B?Qnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a5fc75a2-aaa9-4009-8ba7-08dbb92c9636
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 16:22:15.4389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KuzUZEx5dOUUqNuo2WkL7SxzBiy71KwLySCUy0s6HYxT9fJFiS2kw6xDwY8pdz7g8RMMwp9Tv4TogmiGC22rZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6616
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



On 9/19/2023 12:44 AM, Ilpo Järvinen wrote:
> On Fri, 15 Sep 2023, Joseph, Jithu wrote:
>> On 9/15/2023 9:51 AM, Ilpo Järvinen wrote:
>>> On Wed, 13 Sep 2023, Jithu Joseph wrote:
>>>
>>>> Make changes to scan test flow such that MSRs are populated
>>>> appropriately based on the generation supported by hardware.
>>>>
>>>> Width of chunk related bitfields is ACTIVATE_SCAN and SCAN_STATUS MSRs
>>>> are different in newer IFS generation compared to gen0.
>>>>
>>>> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
>>>> Reviewed-by: Tony Luck <tony.luck@intel.com>
>>>> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
>>>> ---
>>>>  drivers/platform/x86/intel/ifs/ifs.h     | 14 ++++++++++++++
>>>>  drivers/platform/x86/intel/ifs/runtest.c | 23 ++++++++++++++++++-----
>>>>  2 files changed, 32 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
>>>> index 886dc74de57d..3265a6d8a6f3 100644
>>>> --- a/drivers/platform/x86/intel/ifs/ifs.h
>>>> +++ b/drivers/platform/x86/intel/ifs/ifs.h
>>>> @@ -205,6 +205,12 @@ union ifs_scan {
>>>>  		u32	delay	:31;
>>>>  		u32	sigmce	:1;
>>>>  	};
>>>> +	struct {
>>>> +		u16	start;
>>>> +		u16	stop;
>>>> +		u32	delay	:31;
>>>> +		u32	sigmce	:1;
>>>> +	} gen2;
>>>
>>> I don't like the way old struct is left without genx naming. It makes the 
>>> code below more confusing as is.
>>>
>>
>> Given that less than half the fields (2/4 in ifs_scan and 2/5 in ifs_status ) are changing across
>> generations(and rest are common) , I felt the code would be more readable if the common fields are
>> accessed without generation as is done now. 
>>
>> That said I don’t mind changing if you feel strongly about this
> 
> I would certainly prefer the generation dependent fields to marked as 
> such. However, it does not say you couldn't have the other fields remain 
> w/o gen.
> 
> How about this definition (it comes with the added benefit that you 
> cannot accidently use start/stop without specifying gen which guards 
> against one type of bugs):
> 

Yes this looks better. I will adopt this in v2.

> union ifs_scan {
>         u64     data;
>         struct {
> 		union {
> 			struct {
> 	        	        u8      start;
>         	        	u8      stop;
> 	        	        u16     rsvd;
> 			} gen0;
> 		        struct {
>                 		u16     start;
> 		                u16     stop;
> 			} gen2;
> 		};
>                 u32     delay   :31;
>                 u32     sigmce  :1;
>         };
> };
> 
> Note that I used start and stop in gen0 without the bitfield that
> seems unnecessary.
> 

Thanks
Jithu

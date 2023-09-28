Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 272147B28A7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 01:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbjI1XJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 19:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbjI1XJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 19:09:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2271AA;
        Thu, 28 Sep 2023 16:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695942546; x=1727478546;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uDZD5hP+FnmvHSuQUfoiNYdEM5mMHp5qJqC4vsiOhA4=;
  b=Lu8UAU+wS/Rn6ScVu0LQ3S2HWms2mQ/GCNfHptGlZb6ZRryURG+3bKpW
   zayi3v73yb4YAFVs6CtD6jwcFuBJUl4bviWvMkxmjIpHTGuz5uh/Rn6zD
   03Ps8qp8hHd1/4pTJGssQCvb+CNoE0/YJ/w3Iv4c+qr5+JF0PWqdGUGjd
   YwYXjt0GJdDCOnP41kVYaTIESKIrGfWs4j1QbuRdgUqnaE5Pik96kF+h4
   5TK8kpmWOgddsdqUoxJXf/b7uqNGMI8GJ/uzU5i+poIfjKshaLDwF6nDB
   PdYcFUn45t3FCwRg9UZulhyahH/6izgc5EAoPIbNajHrJBMlyqgCQYdhp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="446357917"
X-IronPort-AV: E=Sophos;i="6.03,185,1694761200"; 
   d="scan'208";a="446357917"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 16:09:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="749776421"
X-IronPort-AV: E=Sophos;i="6.03,185,1694761200"; 
   d="scan'208";a="749776421"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Sep 2023 16:09:01 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 28 Sep 2023 16:08:59 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 28 Sep 2023 16:08:59 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 28 Sep 2023 16:08:59 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.47) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 28 Sep 2023 16:08:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E261w4WKXd5UELs3tix+hv2gqVcAxA8LML/Ahl6lUFBDk4fpuMTYAg2L5N3KRPWuAouNdYy/nitbwVGo6021br395s/n0u15b5SkYDYD3guMvFNT4vIQ/8veFLqZnctKM1TWfJqpwfaVxlHyrUWM3uShhvcvA5JaVgtN1sZxNlyQUTT75eTosF59GHXBN+GuOqL1p4aV0lTOvkNUhHi2zJdPFPjHY5MhQSYCsRkr2iwxIPUZ3ErkJiCnvM8qPTRF6+a4UEVaFfXJB3YvSw8svlTx3y+0VM1BHXKD6JZtNXm1vG9oh1+5/VbSwq/4Bk1fs5A9dnlsAjn3mpNkx0x6QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Kmx78P8NyZIbJW9IGHss9lNCE0/63ixxGdNzg/uO78=;
 b=mUYO/rUHNWiC34Tv85EVRbPdN4jKVb878eBBorm7h/eDuFEBLShSqle0EHZyZZy0mApzMu+0qZy/EwLMEd6bWNP8d6Gk4fTKPL9GWbnJ6MQSOo+2H1tmpHhAhsWH22/OghneCgbormGhwFOzC1M46FL3Y+LihxAS3YskD0VwMmu7O4jLWmYue2pcdDFR/07qmS6gqPJk/uQc4zAWHecVSGrXRHnlUAXeXTHwI/GKtnay5PPeGFzYlk27llpSxydFO5OAOHseZENd/nxRawZiJD8RDrHD5LH8AY+W4iVnbgSOWcWq8rgAMORK86EENp4EtROVZoe7mY5XcnkN/s4aXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CY8PR11MB6915.namprd11.prod.outlook.com (2603:10b6:930:59::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Thu, 28 Sep
 2023 23:08:56 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6813.017; Thu, 28 Sep 2023
 23:08:56 +0000
Message-ID: <f2b00069-e837-ff1e-2d03-b446df49bff0@intel.com>
Date:   Thu, 28 Sep 2023 16:08:53 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v6] x86/sgx: Resolves SECS reclaim vs. page fault for EAUG
 race
Content-Language: en-US
To:     Haitao Huang <haitao.huang@linux.intel.com>,
        <dave.hansen@linux.intel.com>, <kai.huang@intel.com>,
        <jarkko@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-sgx@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
CC:     <dave.hansen@intel.com>, <kristen@linux.intel.com>,
        <seanjc@google.com>, <stable@vger.kernel.org>,
        <sohil.mehta@intel.com>
References: <20230728051024.33063-1-haitao.huang@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230728051024.33063-1-haitao.huang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWH0EPF00056D19.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:1a) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CY8PR11MB6915:EE_
X-MS-Office365-Filtering-Correlation-Id: 7daa3103-b15d-40f8-ecc5-08dbc077e3de
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vVdJOBe7w1KYKwvA/U4m2NzPMp/Pl0ycw5OHJr6AyNa9KbwSAGsEz8POpxxlsgD0H3KimtiBz5XBNlFuZEfXvtAwR9fTOQXT6K+AYJ7VlutUnLM8BGvUyeNqa88sJpZl6aI9eU7SBT7jt0L+q+ZEE/mzkYZuE6rGdS0GIezNg3KdmAv2VzoENCZUGj3T++4UQLdiLfmF1udMK3a0B6Uhu56teNnDw724wIug2pu+seMqWWB8fVCgnYWCtWHCXrLYjaXrTJRutDeA9u0nCuPTUIz5TOS/+dZ/P35N9fGLB8jzeBiwr1wTld52ZJLc0MHN85sJSE4zAw3fkKShGgMhGWb8QVM0YEIaSEDnkSyayeuhraySrrXVnfSxVaCkzkU3kKQnAf2/emRG506yUYI/56rq6smICAhvGQz1VeiviKtpiXNT/FktTCor7HQtNf+cN2UcveUIoDtbNvIDAbskHIhmUX5S8TDHInIs/PZgVIktfTUzeD1YSH+c66zf0t6nOmwwcD+XhHRVohdEIi6nTz09Zw/thqIzJSykxtZ2LOTey6eSCzGk1HkXX4zQn31OD+vjC00RS5BVuehDQZaPe26G7ZMfou7xEtMadYiWARXOBuML124xuIeDYORMIN3Yhb5Q0PPcx2T715fX6xaee5SquuQDIHt5mrgH3hd4eeo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(346002)(366004)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(478600001)(53546011)(44832011)(8936002)(8676002)(66556008)(110136005)(66476007)(31686004)(66946007)(316002)(6666004)(6506007)(6512007)(83380400001)(6486002)(38100700002)(5660300002)(921005)(31696002)(4326008)(86362001)(41300700001)(2906002)(26005)(2616005)(82960400001)(7416002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjlRS2d2Y3ZyYllDbk1EWDVMM2xxT1M4elBBUk1PNHhGOVFlWEt2cHgxalM5?=
 =?utf-8?B?QzgzQVRiVy9LSVFTbS9PeFZ2a1lMZVBza05jNTdQNmVQVXpqYkZWcVh6Szdz?=
 =?utf-8?B?NWx6YytvdGhEbEkxblpBcUg3M0ovV0lwSm9SUHJlL0tmVkdNQlN4dFJpN21x?=
 =?utf-8?B?ZHUwZzlvMkNOTW5DUm85RjdiSko5OWJpd1lNWG9uY2hVeWhERC9scjU1TWRD?=
 =?utf-8?B?YlRjTnRkZGw2c3BQSE45NCtkL3pCQU5WZmgyTzNSa0xCRm15cksrcUdZdy9q?=
 =?utf-8?B?SndRTmFBRUNDSmcvNS8xT0hYU0k4NGRCWUpRY2lwdDVQUm5rbnMvOGthN09C?=
 =?utf-8?B?Qkw3UW9xV05oZTFZa1VvYmF4L2hNT3ltbnFqVkRkRytxbmYvQXJEUzEzZDh4?=
 =?utf-8?B?M0h6OVNkeEZBSkpNMy9yQmZSb3R1K1p3bkNQZ05vaHZOdEwyNi9EaWJzTHlK?=
 =?utf-8?B?bkoxTXJQaHNtQXAvU0ZXSTZDaGxlYXMyVENJaVNWeWNPUldPOXdmOEpPdyt6?=
 =?utf-8?B?T0RXOFRGTjl3L0ttZ2I4T1VGVW0yTFhJN2N5YjRIcE9kOFphTUhPT1lrK0Q2?=
 =?utf-8?B?alJyRW9UTTAzYUxpNnd2YUpNZk15bVdubjk4VEtRbmtMTVNxT1FTVGhTSnk2?=
 =?utf-8?B?VTBKVWk0cUo4emNPUGdhT1V6cEIrUzNPaldTUWVseUJzTlQrZGlCQzdKWUV6?=
 =?utf-8?B?QXRjUFBpd3l2MXpMeWsybi9PM3RheGFiS1RhMCt4U3lEbXJXT21wZW1vWjlp?=
 =?utf-8?B?RXJjYkVhSnprWWR5QmxXTGU4ekZwZlo2TXZnYkNXdU5oTXB4bzVxNUtGMWxj?=
 =?utf-8?B?TjBNZEVTbEk2TVlFQm14V2lCMk5xNGxtZVFYTUhrSlFsbnlBbGdyL3pwcU5p?=
 =?utf-8?B?SUZFQXk3c2RYeTlMUXgrbHNBR0dkYVVwSXdZOHJLeXNlT1lhek9uRjNNZ2pF?=
 =?utf-8?B?OTA0T3dSTEVCRHRFaXdKeGhkbnN3dVhWVUcrM0dKSGRLSnBqSHMyRVl5TWpN?=
 =?utf-8?B?Z1pEWFJMSUg4VU1MQlBYdDUvaW80ZzY2NjdqcW9KUFNZQjR1bENqNnFQL1I1?=
 =?utf-8?B?Mzd3cjhienBOK0M1TElIeGdKSFR4ZC9oYmFEUVR0YnVLYk10emc0T01kMUpZ?=
 =?utf-8?B?ejZXVFNZaUkyL0JMNzRtWEozK2RKeFF1ZzVwa2pDTWpFd0EzeE8rLzRXZG9J?=
 =?utf-8?B?ZXVnZ1lrK0FlRUdZVUV0SDg2c0JmSlhoU1pOTXFZRWg2c2wza21pcDNQUjQv?=
 =?utf-8?B?S2pIMFB5NFJmajZTVUlad2NESHNUY1YvZEhxWUpFNUhxcTE2Y3lqeHR2RUVq?=
 =?utf-8?B?dStRY1FWWFlxbWxIL1B1R1ZsVVlBVHZpMDNndEVLR203U0ZScllHemVsNW1l?=
 =?utf-8?B?Y0lTWk1INjhGdkhiK0JVZm9KWXF2emZBcGN2akpCUjczUG5pSFkrNUlaWWdl?=
 =?utf-8?B?Zmk2N0l2V05oWkJnbXgrbElpOWJENDAyMFBNK2orNkNGK3kvczAyZHVpeUpt?=
 =?utf-8?B?WjlwbUxBd1ExQU82dGt5Mk9XMCs2R0xLRWI0NjRlaE5kWXM2ak9tMUNNdnUw?=
 =?utf-8?B?K3lBdllQWFZxNyt1dmRtYzV6SFR6ZG5LUmxQWUF0ZmdwT2taTHlSSFhaWnBx?=
 =?utf-8?B?NFQrUEhoMlBBYTh3dGJDRU5WN2hOTGMrY1FXMUNyZnh1bnQ0M2dxeDUyODR2?=
 =?utf-8?B?d3ZIUWlWUklrYzFTckNkSmxFbTZlbVVVcEljbHFXYTFqYnZFWG1LakpmMmpo?=
 =?utf-8?B?RXRUbVlSbTZaMnJWNkgzZzJBSzN2NDgvZnI0VFVFa2dyT2FaMXR2Z1huVHFL?=
 =?utf-8?B?WjkxMWYxYUU1TXM2ZWN4NDE4Mzg5TVkxLzQwSER6MEdkejB5VE9raWc1Ukox?=
 =?utf-8?B?NTQ3Y2VCVGJjL0VrbUxndnFNeDlmN2ZZTTBCZVNnRUFmaEFSK010Z1diZDVv?=
 =?utf-8?B?NjhObTJZMFJhZVowRzluc2pNdWV0R2kwNWhlVWI1ZlFPVVBVelAwUldubmZs?=
 =?utf-8?B?Q04yUFBOVU16bXMrNzlsc3VaWldLWmc0TTNVU1RFYU81R1h6THo0TjFJVnht?=
 =?utf-8?B?TlNmZGgzeVFueEsydmthTHFCRlVlais5SEllVmh4THUzVHFoQlcrMzZjcHZp?=
 =?utf-8?B?T05jaEFPVDUwNjRtZGtqS2hhb29WelNwSGdSRmROZ3c2bnpKak9WRWhudWNW?=
 =?utf-8?B?eEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7daa3103-b15d-40f8-ecc5-08dbc077e3de
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 23:08:56.1336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qc7mSKe3+4qM6P3wunFIJCKkVbk5bn4mLCtC1Kshwp5Mn6z6Vh8r0wMJ4lL9jOaWnPttAht2I/tROt1HU/cZQffWly26sKHyquM/TQWbPxo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6915
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Everybody,

I'd like to check in on the status of this patch. This two month old
patch looks to be a needed fix and has Jarkko and Kai's review tags,
but I am not able to find it queued or merged in tip or upstream.
Apologies if I did not look in the right spot, I just want to make
sure it did not fall through the cracks if deemed needed.

Reinette

On 7/27/2023 10:10 PM, Haitao Huang wrote:
> The SGX EPC reclaimer (ksgxd) may reclaim the SECS EPC page for an
> enclave and set secs.epc_page to NULL. The SECS page is used for EAUG
> and ELDU in the SGX page fault handler. However, the NULL check for
> secs.epc_page is only done for ELDU, not EAUG before being used.
> 
> Fix this by doing the same NULL check and reloading of the SECS page as
> needed for both EAUG and ELDU.
> 
> The SECS page holds global enclave metadata. It can only be reclaimed
> when there are no other enclave pages remaining. At that point,
> virtually nothing can be done with the enclave until the SECS page is
> paged back in.
> 
> An enclave can not run nor generate page faults without a resident SECS
> page. But it is still possible for a #PF for a non-SECS page to race
> with paging out the SECS page: when the last resident non-SECS page A
> triggers a #PF in a non-resident page B, and then page A and the SECS
> both are paged out before the #PF on B is handled.
> 
> Hitting this bug requires that race triggered with a #PF for EAUG.
> Following is a trace when it happens.
> 
> BUG: kernel NULL pointer dereference, address: 0000000000000000
> RIP: 0010:sgx_encl_eaug_page+0xc7/0x210
> Call Trace:
>  ? __kmem_cache_alloc_node+0x16a/0x440
>  ? xa_load+0x6e/0xa0
>  sgx_vma_fault+0x119/0x230
>  __do_fault+0x36/0x140
>  do_fault+0x12f/0x400
>  __handle_mm_fault+0x728/0x1110
>  handle_mm_fault+0x105/0x310
>  do_user_addr_fault+0x1ee/0x750
>  ? __this_cpu_preempt_check+0x13/0x20
>  exc_page_fault+0x76/0x180
>  asm_exc_page_fault+0x27/0x30
> 
> Fixes: 5a90d2c3f5ef ("x86/sgx: Support adding of pages to an initialized enclave")
> Cc: stable@vger.kernel.org # v6.0+
> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> Reviewed-by: Kai Huang <kai.huang@intel.com>
> Acked-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
> v6:
> - Removed 'Under heavy load' as it is not the required condition though
> it makes the bug more likely happen. (Kai)
> - Added mentioning of the NULL check and reloading already done for ELDU (Kai)
> - Added Reviewed-by (Kai)
> 
> v5:
> - Trimmed trace and added Acked-by (Reinette)
> 
> v4:
> - Refined the title (Kai, Dave)
> - Added a trace to commit meesage (Kai)
> - Added a few details for the race.
> 
> v3:
> - Added comments on sgx_encl_load_secs(). (Dave)
> - Added theory of the race condition to hit the bug. (Dave)
> - Added Reviewed-by, and applicable stable release. (Jarkko)
> 
> v2:
> - Fixes for style, commit message (Jarkko, Kai)
> - Removed unneeded WARN_ON (Kai)
> ---
>  arch/x86/kernel/cpu/sgx/encl.c | 30 +++++++++++++++++++++++++-----
>  1 file changed, 25 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
> index 91fa70e51004..279148e72459 100644
> --- a/arch/x86/kernel/cpu/sgx/encl.c
> +++ b/arch/x86/kernel/cpu/sgx/encl.c
> @@ -235,6 +235,21 @@ static struct sgx_epc_page *sgx_encl_eldu(struct sgx_encl_page *encl_page,
>  	return epc_page;
>  }
>  
> +/*
> + * Ensure the SECS page is not swapped out.  Must be called with encl->lock
> + * to protect the enclave states including SECS and ensure the SECS page is
> + * not swapped out again while being used.
> + */
> +static struct sgx_epc_page *sgx_encl_load_secs(struct sgx_encl *encl)
> +{
> +	struct sgx_epc_page *epc_page = encl->secs.epc_page;
> +
> +	if (!epc_page)
> +		epc_page = sgx_encl_eldu(&encl->secs, NULL);
> +
> +	return epc_page;
> +}
> +
>  static struct sgx_encl_page *__sgx_encl_load_page(struct sgx_encl *encl,
>  						  struct sgx_encl_page *entry)
>  {
> @@ -248,11 +263,9 @@ static struct sgx_encl_page *__sgx_encl_load_page(struct sgx_encl *encl,
>  		return entry;
>  	}
>  
> -	if (!(encl->secs.epc_page)) {
> -		epc_page = sgx_encl_eldu(&encl->secs, NULL);
> -		if (IS_ERR(epc_page))
> -			return ERR_CAST(epc_page);
> -	}
> +	epc_page = sgx_encl_load_secs(encl);
> +	if (IS_ERR(epc_page))
> +		return ERR_CAST(epc_page);
>  
>  	epc_page = sgx_encl_eldu(entry, encl->secs.epc_page);
>  	if (IS_ERR(epc_page))
> @@ -339,6 +352,13 @@ static vm_fault_t sgx_encl_eaug_page(struct vm_area_struct *vma,
>  
>  	mutex_lock(&encl->lock);
>  
> +	epc_page = sgx_encl_load_secs(encl);
> +	if (IS_ERR(epc_page)) {
> +		if (PTR_ERR(epc_page) == -EBUSY)
> +			vmret = VM_FAULT_NOPAGE;
> +		goto err_out_unlock;
> +	}
> +
>  	epc_page = sgx_alloc_epc_page(encl_page, false);
>  	if (IS_ERR(epc_page)) {
>  		if (PTR_ERR(epc_page) == -EBUSY)
> 
> base-commit: 6eaae198076080886b9e7d57f4ae06fa782f90ef

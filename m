Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB82178BA31
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 23:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233564AbjH1VUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 17:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232995AbjH1VUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 17:20:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA39A95;
        Mon, 28 Aug 2023 14:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693257613; x=1724793613;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=66pfUIKNkVIVYBJi64qG4oN5qXNCHKowteOrPiE0yuo=;
  b=oB+fh6CgmDb3KtcoNHBpmZOWgf5MlBQR1NUKuy0iCfhZl29ecJs6/WuF
   +4NSDfc2zfO/qotQJ3p/UJ/8GPdgoLNB1BsdVNO+m05DNcbxo3rfDbt6W
   YIV/hUtOv09CgEHRB82GB/fkcCSqt+aDHIQwu/MDVYcxAdEsMUNVmQQVj
   UCBWB4cdlBiIQ9xOqvTm/oYV3mVvvPkVQyKJFIcnUasrp8R+XT98Pa+mm
   6coK4Cy6W4wU2WI2qq1cLrn8+U/F0rztQKCPLKPmXK/D80ExdewRH6XoI
   krVz7tXmT6oR01w7OfnY83gjhMapTmA+6PxIqUrb/1E43NIXQGRO0mZyE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="439158101"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="439158101"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 14:20:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="882072648"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP; 28 Aug 2023 14:20:17 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 28 Aug 2023 14:20:11 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 28 Aug 2023 14:20:11 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 28 Aug 2023 14:20:11 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 28 Aug 2023 14:20:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P95h1JUOGcEOhA12e6gWE1nv57+g5zjSM2tFrvgrMSv62U0BZ74AMHpk2og/h5KpLH/BzcmcN49V4Y04je79ZHBv988O3MfjjM2E6QGobDiCWmx/7vABAyfUixCKQoHrm/6JbTY98UIPUH3cZZNYOmmq18rO95u6xzsg7ocrpurSFo2oLfmbbnsTDN+EmgFF1Krfhi7Fl3aAeteisIV6r3xWzYVhzc5HlvOAKnvAdOye2OngZxmwWckNDZTnPlQWEzjMggg3m2kLtea481IyqEqqPguhG1ANHJFJ3I4f3XKkliQv7I/2H9lNsaLLpv0S0Oi141265nhJjbCZTrUTJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n0aWEEiysxfNErW7s750B3A6fo/KkI0oHQhfzMXLzLQ=;
 b=I8SZoJ/k2smUIAGmy+lL8x18+eRG1bys8irHI10w+9vAoaryTEkm6ffv8H1Bu87gf7sAFDJIt3cpj4xqB8MTe/ezBkyil22ZeKoDHvgurnNoLBLZmx04uJkM3GPlGEVMjhXJlHPWRfb2Id0O/oz9vJWijqYljwBXQZsQNUf6idNLwYAmdyyZAB4qX3oUPcuB6f4Kfuxkxf6+mVlW8dMMZJ0gnpcy4V3UgpPkjDst8/DQWoMC7roC5t+6JYVBsPnL2NKCu1vaCXeBwB9zHNEegKw5BqNpskJ1hq4rYCpcDK4VLhQYrjd5bVmgedQL19vJgukFiaT3V/VmjcTaYGTiKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW6PR11MB8390.namprd11.prod.outlook.com (2603:10b6:303:240::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 21:20:07 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 21:20:07 +0000
Message-ID: <e3cbefc5-e686-5561-a71e-06417ab51d07@intel.com>
Date:   Mon, 28 Aug 2023 14:20:04 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v4 1/7] x86/resctrl: Create separate domains for control
 and monitoring
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
References: <20230713163207.219710-1-tony.luck@intel.com>
 <20230722190740.326190-1-tony.luck@intel.com>
 <20230722190740.326190-2-tony.luck@intel.com>
 <cc1a144f-6667-18fb-7fe7-cd15ebfedd08@intel.com>
 <ZOjfPx8iwTULTqdg@agluck-desk3>
 <da2c0e45-56d0-e04d-774d-4292d156e1d0@intel.com>
 <ZOzroJqc22HFZOXq@agluck-desk3>
 <5b5962d3-6a7b-cc60-4221-8267bfbc3bfd@intel.com>
 <ZO0KtAefCStikXEm@agluck-desk3>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <ZO0KtAefCStikXEm@agluck-desk3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0316.namprd03.prod.outlook.com
 (2603:10b6:303:dd::21) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW6PR11MB8390:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e7a8943-bcd9-435b-f4db-08dba80c8d9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MHDBYlG3777m0hSSfZp2cnLRrCBke3hlkc9OzqICuziCAcmxZmGNr2VDDOw41zGs5JGtJclqID8DdpAATX+bH1YMhdh2QokVGV1Zy54d+wTCoW0HRb9hoVrX7jiyFeX/vKzfbLWIBYCXXqqsXWFQUide9iR3OKAOuYVuynjQa5aZmlI/rT18BhZgdYHaHsmkbGPpgxbGOvYEjlE+Cnsh8YcpHaS4l+2LtyMr25Au9Y/LydAepbVgIgxFb8JPmp3YRP4gCMfvfp2rjk5C7EJl14chari0Ytt0xalyISlAUWQOfuyF9NdFG3fzMxrcc47jRNqvTE7zDy2Zv1HUEwatMMAI8hawY6/4ByVqw8a/6Meffhozef94xE98FNRMiveE5BuS1kTrJeJSNgJkfz/RGH62FrfRmSvGULlY6b3j44iZl9FQGGKqKHNvehMYBp64FYRk+pBwSku3kD6VGiHb2/Me765zkKiHNDMZEhDfvczA+YwmH8YwPLjGINEjiFCIe9fY+3ttttBF8kWQYs5fpnNK2POjkNntk5MngqfwhAyuw2DrZaxYYpjKuqg3vk9RKgMzPQ5AkubXRFZt17gCoYloFKwYn+VYBYhLV5Eei8egI8f4Vcptt+3XWKkHxKKDqbKLijFmTq/E6McXjno4eQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(136003)(346002)(39860400002)(1800799009)(186009)(451199024)(83380400001)(478600001)(966005)(31686004)(26005)(2616005)(6486002)(6512007)(53546011)(6506007)(6666004)(31696002)(86362001)(5660300002)(82960400001)(2906002)(6862004)(54906003)(8936002)(38100700002)(7416002)(316002)(66556008)(6636002)(8676002)(4326008)(66946007)(37006003)(66476007)(36756003)(41300700001)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWRFQTVSclZzemJ6SGs4Y2pKVXJ5dkNwV0R3Y29iTmk0Z1c1QmpEbG16RFBQ?=
 =?utf-8?B?MTJaN3FJQmd5MTNyOVgxMGh6UE9jL0pFYldTTEZWYkxDcHBYaTBuNFZSUDFK?=
 =?utf-8?B?NEl3WlNBODhCNC90aFVITFNUSFJkWEhkVEF0RXQ2Q1dyS3d6bHBQK3pMb2Mr?=
 =?utf-8?B?OEFnVnYzTjB6S2NITGVJWW4xNEM0dEVCdkU0LzNjaHNtRXl5S1p0NVdWaHhw?=
 =?utf-8?B?ZEtrdU5jeUN4cXJDRW1VMWlZbVNrbDFRdW81eW5CRGd6cU56WmN3aXFnazJ4?=
 =?utf-8?B?dVNhaTVGT1V6NFZJT1huajFVVVpRNjRNZldwdVNDaFd4Z3I2M3pieXNoN3NV?=
 =?utf-8?B?YzlqTzB5dXBCMHpEMEc3WXU1Z3hVSy80RUVyeUlKTUliSkFZVGh5dHFEaDli?=
 =?utf-8?B?TFJZRmxSZnIvWk1mczBoMTN3dlVScUJxc3hBSE5TaUhTZWJwK0lZZG02KzRU?=
 =?utf-8?B?N0drYTBJUWk5RHZQMmdpam9QNDFOUHB3QkI2QzROUGRkZWhKY3YxaXZ3dEM0?=
 =?utf-8?B?TWMyTEJNeGJCTllrR1dPcS9FWjRpZVJUZno3dVZndFYrcFpxcmNyMFMrbjBI?=
 =?utf-8?B?U3M2R0R3NDFjSXZoMDdWVUdwMjZmZjYrYVAwRlZzZHFnUFo0eWVCbThOMlNo?=
 =?utf-8?B?c3BHNVZoRFdQcS96bDFFUFhZcW9LVW9TazhwblVOeWR1TDFkWk5WVGZFbnRW?=
 =?utf-8?B?Snh3cUxXN3hYc3d2VmhPTTNvWUdLQXVSZC9tVTFrdVJ5ajMrenVkb3pobERT?=
 =?utf-8?B?MUhtL2pBVC9FQ21uQmF2TVZPeXpWYjNjN3JPS05xaUZnTzgwbzNSOVJhempZ?=
 =?utf-8?B?aUdZQjVpS2gzL2h2Qi9KRDZqUHYvSjdsWUhRbnFMUldYNWE0YmFoMCtyYVVs?=
 =?utf-8?B?QnJsdnhPczBWcllOakd3QW0ycU9RM3lnMFhSZ3VuV2ZvTjdKS2xnSVVmVVRC?=
 =?utf-8?B?clpvZHYybkh3SS9teHdYQVVpNFlVSGZGcWF5eEZCT1BBcHdRR29KUlVFbzdV?=
 =?utf-8?B?RGFwbDZER1VJRXl3VlloSVI4UFpNZStSWVBvOEJYbEk0aVkrUHBuQXBsRk9V?=
 =?utf-8?B?YWx0RlB3ZlVUMWxrQk1XbTBrdEpsR0NqKzAyM0ZrQXNaU2o5d3l6cFNHd01o?=
 =?utf-8?B?REpPSGNQbW5ZTThraVhsZkZEcXVoRVhjYTdVWExZdDNleEo2UTlCU0JDMkpu?=
 =?utf-8?B?NmtPS2p3cUs5OVFxZFZJUSt1QUZnTlE0aU5wc0tiZVVQaVlVd0ZKV3hxeVhB?=
 =?utf-8?B?VERxa1JTUWFnQTlzRCt2eTBSUExlbUdHaEM0dzZ4dDF3NW0rR2hzQ0hVamtT?=
 =?utf-8?B?a3pWWDZYWitSMXF6M1ZjUXFVa0xEZVNyNzNWdGlHbEw4dzR1QzBmL09EWnpJ?=
 =?utf-8?B?UEp2UmJPWUJRL1lIM29IQzM5UTRiTDJJYzFhYkd5ZDJnay8wakZDaU4rNTRk?=
 =?utf-8?B?Y29YNklWVnREYitFNFZjZERBQ1NxSUI2Z0xPL2tXOWE5L3pjREJNUFg4V3lh?=
 =?utf-8?B?VnhaUzB0VjhhSzdnMkd2eDN1U3RvdXRQYnRuRzlTM2tGMDRHZWFCREp4RUhT?=
 =?utf-8?B?d3lkM0lKRGZaSWwzMnpEU1YwdUFKYzlobWRtQzJHUDJzUkEyemRhZWhMUUV4?=
 =?utf-8?B?dUMxWVl5L0dScmlWaEZlc2lOSUphc0kzVXBoZEt6L2x5b05GMjhBV3hXMXov?=
 =?utf-8?B?Y2RnQ1BUbC9tcWVEUFlha0FJTzd4QzdCdDBkaTM0aEw5UEM1OUdDcVVRbjNJ?=
 =?utf-8?B?WmpMSXNYczVmV0tQTy9oSzFyWVhYUmtjaUNNVmpScWpUK2Ria3dXZjA1WWpI?=
 =?utf-8?B?d0VRRjFIZ0RnUEFtbmN3a1Z2dThKUUZuQlhGZGppMEVkdUlGOWxnY2plZlE3?=
 =?utf-8?B?UHFWUnpPQnBXVjRDQ1ZOdlhvRFhPNzBwcnExOUFoZWU5cTN0ZkYrSmNRcGtN?=
 =?utf-8?B?RnlySU5EdjNoMWJqR2hyR3YwRVJ0QnV1L2lMbTNwUjQvQWYvaEI4alJuaUxU?=
 =?utf-8?B?TjI2N0cwSkw0bzR0eFBMOUZpdllGelJQcDlmQzZTOHJFZ0xrdXU0Q0dTcnRh?=
 =?utf-8?B?ZUlWL0VXdlNtNjNmKzJIeE9abFMxS1JXU3dTamJQSU1CYnJVZi90dW5LUy9j?=
 =?utf-8?B?M1BzRTRWQUllTk9yZGM5djdkR0dpc2xsSlZuSUQrekhKNExJcEU0S05QVWJR?=
 =?utf-8?B?ZEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e7a8943-bcd9-435b-f4db-08dba80c8d9e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 21:20:07.3405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cpvpcbn70fLMp4Lu9D0alzNctqUBhik+jp6WHjsy5N6u4yl8o0VY7GIEQ92na/w7cmGSTC9p8vxeBbgXSXsEtO2hzXDciT9uwc1nRwaPYm8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8390
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/28/2023 1:59 PM, Tony Luck wrote:
> On Mon, Aug 28, 2023 at 12:56:27PM -0700, Reinette Chatre wrote:
>> Hi Tony,
>>
>> On 8/28/2023 11:46 AM, Tony Luck wrote:
>>> On Mon, Aug 28, 2023 at 10:05:31AM -0700, Reinette Chatre wrote:
>>>> Hi Tony,
>>>>
>>>> On 8/25/2023 10:05 AM, Tony Luck wrote:
>>>>> On Fri, Aug 11, 2023 at 10:29:25AM -0700, Reinette Chatre wrote:
>>>>>> On 7/22/2023 12:07 PM, Tony Luck wrote:
>>>>
>>>>>>> Change all places where monitoring functions walk the list of
>>>>>>> domains to use the new "mondomains" list instead of the old
>>>>>>> "domains" list.
>>>>>>
>>>>>> I would not refer to it as "the old domains list" as it creates
>>>>>> impression that this is being replaced. The changelog makes
>>>>>> no mention that domains list will remain and be dedicated to
>>>>>> control domains. I think this is important to include in description
>>>>>> of this change.
>>>>>
>>>>> I've rewritten the entire commit message incorporating your suggestions.
>>>>> V6 will be posted soon (after I get some time on an SNC SPR to check
>>>>> that it all works!)
>>>>
>>>> I seem to have missed v5.
>>>
>>> I simply can't count. You are correct that next version to be posted
>>> will be v5.
>>>
>>>>>
>>>>>>
>>>>>>>
>>>>>>> Signed-off-by: Tony Luck <tony.luck@intel.com>
>>>>>>> ---
>>>>>>>  include/linux/resctrl.h                   |  10 +-
>>>>>>>  arch/x86/kernel/cpu/resctrl/internal.h    |   2 +-
>>>>>>>  arch/x86/kernel/cpu/resctrl/core.c        | 195 +++++++++++++++-------
>>>>>>>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c |   2 +-
>>>>>>>  arch/x86/kernel/cpu/resctrl/monitor.c     |   2 +-
>>>>>>>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  30 ++--
>>>>>>>  6 files changed, 167 insertions(+), 74 deletions(-)
>>>>>>>
>>>>>>> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
>>>>>>> index 8334eeacfec5..1267d56f9e76 100644
>>>>>>> --- a/include/linux/resctrl.h
>>>>>>> +++ b/include/linux/resctrl.h
>>>>>>> @@ -151,9 +151,11 @@ struct resctrl_schema;
>>>>>>>   * @mon_capable:	Is monitor feature available on this machine
>>>>>>>   * @num_rmid:		Number of RMIDs available
>>>>>>>   * @cache_level:	Which cache level defines scope of this resource
>>>>>>> + * @mon_scope:		Scope of this resource if different from cache_level
>>>>>>
>>>>>> I think this addition should be deferred. As it is here it the "if different
>>>>>> from cache_level" also creates many questions (when will it be different?
>>>>>> how will it be determined that the scope is different in order to know that
>>>>>> mon_scope should be used?)
>>>>>
>>>>> I've gone in a different direction. V6 renames "cache_level" to
>>>>> "ctrl_scope". I think this makes intent clear from step #1.
>>>>>
>>>>
>>>> This change is not clear to me. Previously you changed this name
>>>> but kept using it in code specific to cache levels. It is not clear
>>>> to me how this time's rename would be different.
>>>
>>> The current "cache_level" field in the structure is describing
>>> the scope of each instance using the cache level (2 or 3) as the
>>> method to describe which CPUs are considered part of a group. Currently
>>> the scope is the same for both control and monitor resources.
>>
>> Right.
>>
>>>
>>> Would you like to see patches in this progrssion:
>>>
>>> 1) Rename "cache_level" to "scope". With commit comment that future
>>> patches are going to base the scope on NUMA nodes in addtion to sharing
>>> caches at particular levels, and will split into separate control and
>>> monitor scope.
>>>
>>> 2) Split the "scope" field from first patch into "ctrl_scope" and
>>> "mon_scope" (also with the addition of the new list for the mon_scope).
>>>
>>> 3) Add "node" as a new option for scope in addtion to L3 and L2 cache.
>>>
>>
>> hmmm - my comment cannot be addressed through patch re-ordering.
>> If I understand correctly you plan to change the name of "cache_level"
>> to "ctrl_scope". My comment is that this obfuscates the code as long as
>> you use this variable to compare against data that can only represent cache
>> levels. This just repeats what I wrote in
>> https://lore.kernel.org/lkml/09847c37-66d7-c286-a313-308eaa338c64@intel.com/
> 
> I'm proposing more than just re-ordering. The above sequence is a
> couple of extra patches in the series.
> 
> Existing state of code:
> 
> 	There is a single field named "cache_level" that describes how
> 	CPUs are assigned to domains based on their sharing of a cache
> 	at a particular level. Hard-coded values of "2" and "3" are used
> 	to describe the level. This is just a scope description of which
> 	CPUs are grouped together. But it is limited to just doing so
> 	based on which caches are shared by those CPUs.
> 
> Step 1:
> 
> 	Change the name of the field s/cache_level/scope/. Provide an
> 	enum with values RESCTRL_L3_CACHE, RESCTRL_L2_CACHE aand use
> 	those througout code instead of 3, 2, and implictly passing
> 	the resctrl scope to functions like get_cpu_cacheinfo_id()
> 
> 	Add get_domain_id_from_scope() function that takes the enum
> 	values for scope and converts to "3", "2" to pass to
> 	get_cpu_cacheinfo_id().
> 
> 	No functional change. Just broadening the meaning of the field
> 	so that it can in future patches to describe scopes that
> 	aren't a function of sharing a cache of a particular level.

Right. So if I understand you are planning the same change as you did
in V3, like below, and my original comment still stands.

 @@ -1348,7 +1348,7 @@ unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r,
  	num_b = bitmap_weight(&cbm, r->cache.cbm_len);
  	ci = get_cpu_cacheinfo(cpumask_any(&d->cpu_mask));
  	for (i = 0; i < ci->num_leaves; i++) {
 -		if (ci->info_list[i].level == r->cache_level) {
 +		if (ci->info_list[i].level == r->scope) {
  			size = ci->info_list[i].size / r->cache.cbm_len * num_b;
  			break;
  		}


>>>>>>> @@ -502,61 +593,19 @@ static int arch_domain_mbm_alloc(u32 num_rmid, struct rdt_hw_domain *hw_dom)
>>>>>>>   */
>>>>>>>  static void domain_add_cpu(int cpu, struct rdt_resource *r)
>>>>>>>  {
>>>>>>> -	int id = get_cpu_cacheinfo_id(cpu, r->cache_level);
>>>>>>> -	struct list_head *add_pos = NULL;
>>>>>>> -	struct rdt_hw_domain *hw_dom;
>>>>>>> -	struct rdt_domain *d;
>>>>>>> -	int err;
>>>>>>> -
>>>>>>> -	d = rdt_find_domain(r, id, &add_pos);
>>>>>>> -	if (IS_ERR(d)) {
>>>>>>> -		pr_warn("Couldn't find cache id for CPU %d\n", cpu);
>>>>>>> -		return;
>>>>>>> -	}
>>>>>>> -
>>>>>>> -	if (d) {
>>>>>>> -		cpumask_set_cpu(cpu, &d->cpu_mask);
>>>>>>> -		if (r->cache.arch_has_per_cpu_cfg)
>>>>>>> -			rdt_domain_reconfigure_cdp(r);
>>>>>>> -		return;
>>>>>>> -	}
>>>>>>> -
>>>>>>> -	hw_dom = kzalloc_node(sizeof(*hw_dom), GFP_KERNEL, cpu_to_node(cpu));
>>>>>>> -	if (!hw_dom)
>>>>>>> -		return;
>>>>>>> -
>>>>>>> -	d = &hw_dom->d_resctrl;
>>>>>>> -	d->id = id;
>>>>>>> -	cpumask_set_cpu(cpu, &d->cpu_mask);
>>>>>>> -
>>>>>>> -	rdt_domain_reconfigure_cdp(r);
>>>>>>> -
>>>>>>> -	if (r->alloc_capable && domain_setup_ctrlval(r, d)) {
>>>>>>> -		domain_free(hw_dom);
>>>>>>> -		return;
>>>>>>> -	}
>>>>>>> -
>>>>>>> -	if (r->mon_capable && arch_domain_mbm_alloc(r->num_rmid, hw_dom)) {
>>>>>>> -		domain_free(hw_dom);
>>>>>>> -		return;
>>>>>>> -	}
>>>>>>> -
>>>>>>> -	list_add_tail(&d->list, add_pos);
>>>>>>> -
>>>>>>> -	err = resctrl_online_domain(r, d);
>>>>>>> -	if (err) {
>>>>>>> -		list_del(&d->list);
>>>>>>> -		domain_free(hw_dom);
>>>>>>> -	}
>>>>>>> +	if (r->alloc_capable)
>>>>>>> +		domain_add_cpu_ctrl(cpu, r);
>>>>>>> +	if (r->mon_capable)
>>>>>>> +		domain_add_cpu_mon(cpu, r);
>>>>>>>  }
>>>>>>
>>>>>> A resource could be both alloc and mon capable ... both
>>>>>> domain_add_cpu_ctrl() and domain_add_cpu_mon() can fail.
>>>>>> Should domain_add_cpu_mon() still be run for a CPU if
>>>>>> domain_add_cpu_ctrl() failed? 
>>>>>>
>>>>>> Looking ahead the CPU should probably also not be added
>>>>>> to the default groups mask if a failure occurred.
>>>>>
>>>>> Existing code doesn't do anything for the case where a CPU
>>>>> can't be added to a domain (probably the only real error case
>>>>> is failure to allocate memory for the domain structure).
>>>>
>>>> Is my statement about CPU being added to default group mask
>>>> incorrect? Seems like a potential issue related to domain's
>>>> CPU mask also.
>>>>
>>>> Please see my earlier question. Existing code does not proceed
>>>> with monitor initialization if control initialization fails and
>>>> undoes control initialization if monitor initialization fails. 
>>>
>>> Existing code silently continues if a domain structure cannot
>>> be allocated to add a CPU to a domain:
>>>
>>> 503 static void domain_add_cpu(int cpu, struct rdt_resource *r)
>>> 504 {
>>> 505         int id = get_cpu_cacheinfo_id(cpu, r->cache_level);
>>> 506         struct list_head *add_pos = NULL;
>>> 507         struct rdt_hw_domain *hw_dom;
>>> 508         struct rdt_domain *d;
>>> 509         int err;
>>>
>>> ...
>>>
>>> 523
>>> 524         hw_dom = kzalloc_node(sizeof(*hw_dom), GFP_KERNEL, cpu_to_node(cpu));
>>> 525         if (!hw_dom)
>>> 526                 return;
>>> 527
>>>
>>
>>
>> Right ... and if it returns silently as above it runs:
>>
>> static int resctrl_online_cpu(unsigned int cpu)
>> {
>>
>>
>> 	for_each_capable_rdt_resource(r)
>> 		domain_add_cpu(cpu, r);
>> 	>>>>> cpumask_set_cpu(cpu, &rdtgroup_default.cpu_mask); <<<<<<<<
>>
>> }
>>
>> Also, note within domain_add_cpu():
>>
>> static void domain_add_cpu(int cpu, struct rdt_resource *r)
>> {
>>
>>
>> 	...
>> 	if (r->alloc_capable && domain_setup_ctrlval(r, d)) {
>> 		domain_free(hw_dom);
>> 		return;
>> 	}
>>
>> 	if (r->mon_capable && arch_domain_mbm_alloc(r->num_rmid, hw_dom)) {
>> 		domain_free(hw_dom);
>> 		return;
>> 	}
>>
>> 	...
>> }
>>
>> The above is the other item that I've been trying to discuss
>> with you. Note that existing resctrl will not initialize monitoring if
>> control could not be initialized.
>> Compare with this submission:
>>
>> 	if (r->alloc_capable)
>> 		domain_add_cpu_ctrl(cpu, r);
>> 	if (r->mon_capable)
>> 		domain_add_cpu_mon(cpu, r);
>>
>>

I'll stop trying

Reinette

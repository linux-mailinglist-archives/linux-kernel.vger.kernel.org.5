Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B591F7CD5BB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 09:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344584AbjJRHwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 03:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjJRHwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 03:52:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDDDBEA
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 00:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697615560; x=1729151560;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9xp/50kNWyZjGGI2ZQhifT7cyKIRe4n5TvBOqvjQvSc=;
  b=WlsYZwflYZ+ahgdYI2DzBTs47Cc0EB9kbOxpgavHDyGPAZxxZ0mmQK1+
   uEtYZkK2ye/5aerpCZ3BmYSGSuDe9h8KGf3yn1f8RzO9Vaa9cwgl8bzxG
   92JhRqGrwyZ30o3IVvbV48akkgeQaCnN+0WELvdyKhAaClU6+4TwBTohS
   tY0mZ+KmUt4ho1UmILsdx7QuHF2A+NX0fKr5vGL/3Vsf/3ziv0dEhpR87
   pod4Jdkpo9Uf0pqH7K989a4/jRzhpcoV4SpyvNSpfVOe2juRaHG+y1wGY
   L7rKLYgU6VJ9E9/gmbGBYPnzepkDW7QyHj1J/Qu8fKcV7j8uhy7hAf0nj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="383183492"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="383183492"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 00:52:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="930075772"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="930075772"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Oct 2023 00:52:39 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 18 Oct 2023 00:52:38 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 18 Oct 2023 00:52:38 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 18 Oct 2023 00:52:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QUT5kK8B/FURSm3Ret4qHMcgrmb+9oCyEs9z4zsLEvq+Gll9KH3ujdoEzVNeeqPl9uN8iFQIw/RbMVl++ieqbN8xkwKEPn/3+VINOgVfxWWZ6HM+AjCJTImE+e+GZ7iePRVoVfS4CkhnEiq/o+U8tn35BgAUxcyYzdA1ChL/CIkRLVXv+5l2Hq7a9aBpGph3GMBSv9NKWrhPSn6u+bXDuTmlauGAZqMqIOsxnoukOKumHclTwY8P92zrX2Mm6EbIu6UAfsbErZ7ZNGMPU1GDRlWFyLdu2SHtDhGqAAM0A9U5vSjCN0idc6yDyID1bec7SZOA25Cfavnq0zoTCM8PcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DDMVUPs9HKqcN3J8uhaQ9ii5ckop6yR2eE5wG3DD9Dk=;
 b=ajQ/fA/cvJE/8yZM6m6EsDwHueAcn5zG5OB3WyYEO9gH+1epzHO1FGtPVIH9ldC5ihF9xQ6vyuNlSJsFwzeodnsOA24xD38y10IEy7pweIlbVwWa7+pJvBs40XHPKRTkGPMI3gmFFw1QtHmoIv9mz5mWFiuzUsJh1eNCp83s9LVmV/iM10jG+tSOb+2PEiBOfUOn5pnI/zXlr6+ww1MuOEAAoHoBzASkoR2Sq2Es9MOQJVAAO2ribY2AowDyMu0S6BNd58pgV4RUPkT5DcVczg8rlU91gikYCGiLleK9KwgzDUe9Oue7J8LEMm2CDL/Ldcj8kD9x1Sr/H2QQLreNhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4243.namprd11.prod.outlook.com (2603:10b6:a03:1c8::16)
 by MW3PR11MB4554.namprd11.prod.outlook.com (2603:10b6:303:5d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Wed, 18 Oct
 2023 07:52:31 +0000
Received: from BY5PR11MB4243.namprd11.prod.outlook.com
 ([fe80::59cb:e244:fe8b:184d]) by BY5PR11MB4243.namprd11.prod.outlook.com
 ([fe80::59cb:e244:fe8b:184d%5]) with mapi id 15.20.6907.021; Wed, 18 Oct 2023
 07:52:31 +0000
Message-ID: <7dde176b-1059-e9a4-a023-0243cce61d01@intel.com>
Date:   Wed, 18 Oct 2023 09:52:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] staging: rts5208: Replace delay function.
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Julia Lawall <julia.lawall@inria.fr>,
        kenechukwu maduechesi <maduechesik@gmail.com>,
        <outreachy@lists.linux.dev>, <shreeya.patel23498@gmail.com>,
        <linux-staging@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <20231018004300.GA3189@ubuntu>
 <7bc719c4-459f-3d8-7ed-b1e1adf158@inria.fr>
 <1118ec6d-e1e7-79f3-08e4-9a79c996eed1@intel.com>
 <2023101853-axis-stylist-f1b9@gregkh>
From:   Karolina Stolarek <karolina.stolarek@intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <2023101853-axis-stylist-f1b9@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0003.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::14) To BY5PR11MB4243.namprd11.prod.outlook.com
 (2603:10b6:a03:1c8::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4243:EE_|MW3PR11MB4554:EE_
X-MS-Office365-Filtering-Correlation-Id: da15a763-1866-401b-00c2-08dbcfaf2ec6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UkLKSmb/iIsO61tZiVa0OoBlIozCDRQQqtQZsOHjAKzxq0by+aBTYiVlr/2w/3iI7LllTNpVuy/i1qdcEmHwOF68ZEjANh9bZ6QbFk9SlsH//7n0f6FXeBUrEPe/VLZ5Tkb4DnGnaFHcoO8Dxn0XyvmF9BULAVUVnh5xX1agOsbysmh9g6VIWi4Mv1N5wMYfwFNGtwpu6Grvasztyn8HsiCJKEmCKtTyVW1J3RCOSOQ4qV73CcxEGsQNiGiB4BCzTwOT90hitogZl9DFyerYXI5Dn9XT/m0Bu8yObYN5nnjQ7MObAzO31b01OkISFkcitXSUuYj6KzffeaBT7q2oHDSbYtry6JgmJjBOA7XcIvK6SWwodJCnCKa/CtSvHsiAzAbWbruKbwAWQUViDFoELdeQbdij1aCYDxc0f9MbhQXZujbc2sZzfvPTCRnctreaoMaIfRUxnBzQRZMeGkkCUCwXJNyiM7SGPtZLbumDNSe1PgP4lJJ1pRZXoFr8AQTfc9kAmVb35hw+j50xLmMk7H7uH4Z1u6agwYHOxPFKv8KK7ltDkus4fsXNx9a1a8gJvwwFnQjzaf1Bgwbc/uKUChx97MSBMOICS9ZfcNWeDSFe1TgL+IdfObsTo99z5SH3m2cJVqpUZym10tmkv9mmnQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4243.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(396003)(376002)(366004)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(316002)(66946007)(6916009)(53546011)(6512007)(66556008)(86362001)(83380400001)(36756003)(38100700002)(82960400001)(2616005)(31696002)(36916002)(478600001)(6486002)(6506007)(54906003)(66476007)(41300700001)(44832011)(5660300002)(26005)(31686004)(2906002)(8676002)(4326008)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXkrazNFQ3QwWEZJMTgvSFJXZCtuVkk2eDhzRnEvZUZmbzEwRVNTbXdYTmJG?=
 =?utf-8?B?SlUydENMZ2lRT05MeGJNN1FjMGVGdEJTNXcvOURWdUVsTVJhWmFIazJEd0ZK?=
 =?utf-8?B?eVM2eTY0REs1Nklkc3NHalZJZ0tqTHMzenowVjZvRWNnSVNRUUUwdnhDbDdD?=
 =?utf-8?B?OUdIZ25vbGNsclRPdnlTaWNWQXNQdFNSUC9GVlZWTmJMM0IyVks3WEMrMjFq?=
 =?utf-8?B?RE95MU1CNEI4cjBuekdQZytiN1M4ZHpBeDFVL1JSRFBEUWN1cU0velMraHJu?=
 =?utf-8?B?anNyVVRQZkhyT3dZRzJmSnJQeE11MDViOXhxazJFUjVFb1VVV1ExVXhuKzZO?=
 =?utf-8?B?MEFTaDRUN20rMUROZlJPZitHdGJJQ1BGRzFsQ3UyN21OSFVkWTlEVGZNckY5?=
 =?utf-8?B?ZXMzK0hNSUNtNVZqZXgyL0ZtZFp2dWRXY005UWF3eGVIUkR1amQzRHdVak54?=
 =?utf-8?B?eG9FZzRvNlduWUc0L1JnODh6M1VBTUcwQXpvUEJ1MzBWN1I5cjcyVGpZOEJi?=
 =?utf-8?B?Z3RvVTJXdnVWb2wwRWpLaHBJbzEyYU9UdFVUTlQ1eEdONUQvdDh1VSthTXcy?=
 =?utf-8?B?RU15TWRGODNOK0tWRWJha3o2NkVHelZVNDhHNXNadExDQTdWN1FPQWxuM0dD?=
 =?utf-8?B?Z1BmZWdVK2lEWWUyeXdFT0FNaDNRcFJoRUVaUGN4ZVh1Z2ZXYUtOOE4vLzcz?=
 =?utf-8?B?K1l6b3lsM3h0eFFpUUYxWStwRFh3TndHeXE0N2FvZzl5ZVFiSTlWb3J0bnJk?=
 =?utf-8?B?NVBFQjV4d1E4alMzWnp3N2JpeFJ3dlZxK3k0UVgyaGdlQ2RBMGFseU9jakhC?=
 =?utf-8?B?dkdmY0RNUXJIR1RxQm5sTmd3VTJEWnhKWUlLSkZ0THRwSmROZUdxdmVPSUU5?=
 =?utf-8?B?VXZ5QVBKTHVHVCtmZGxJNDRhSXhPNVVvcmlabys0OGNVenR5SnZuT3c3VmhJ?=
 =?utf-8?B?MG91dUp4Z2orMEdodDNzK0twRlNPMXB5OVJMUDkvMWwydUZQeG1FblM3cVhs?=
 =?utf-8?B?WW1vWFg4Z09MbkgvNjQ2bFdIaTJlT0JMaDhVTW40RnZEdFVlcWtkWFhXRHMx?=
 =?utf-8?B?YWkrb0s5SXVidmZpSitXRUhJdS9pckFFVWFiMytpYTRtQUhhNTA1SVJ0aVpv?=
 =?utf-8?B?SUZ1UlJIQWlNRzVEcFFIdGVGTHVpMC9RYlBFNFJzeXZiTyt3WmhDSEhUdlFR?=
 =?utf-8?B?ZUgzOVVqQm9hUWZmbXV5SUtzVElSdlRzdk1RZnFDWDY5OEtVY3M4NnUyRHk4?=
 =?utf-8?B?Qit2Y2pCakkzUkxzWk9RSm84T3hTZnZqYnMzNnNBa0k3SHhnNkJOaHh2dDlK?=
 =?utf-8?B?NGpGRVJHckNHaGdkMzJjWWQ0TE9mR0gxNGYydktvSTgzTE5aS0N4TmdJSG1z?=
 =?utf-8?B?NFArajI2NzR0WDQ0cXRQSWw5dTF0NytqcENlK1NZcWtrR3pqcVlIZkRVcXlQ?=
 =?utf-8?B?WWIweE51d1hpMGRtYStNWUpETFZ5TFlwTXhJSFVCVGs3ZHRhTTh4dUtIQUdS?=
 =?utf-8?B?Qmh2cDdWYzFHVVVmRWJMMEtNenlGQ2dOcktrYjdSenFTajhOSUdmaGJFb3Zq?=
 =?utf-8?B?d0p5Z3RIV2tCbkd1a3pSdk1lYUZhT0RjM01JWHVFcUhyNnk0cGp6TVRDMzJF?=
 =?utf-8?B?WWh2ZGFSWEY1bElUdFlnOGYzbFVpbzVDd3ZXUll2a2dqeWRrSlhjV1JkamRu?=
 =?utf-8?B?SVYrclUvcUJDQURQQ2kwZThhWkhjZkxKNDFpRE1ORlFRM0lOMEl6TUVhaDRr?=
 =?utf-8?B?TmNZMk0yUlNNU3FtSmhRd05UM1BtM3hHVjlaQjl1eEpaUjVSdC8rbThiNE9C?=
 =?utf-8?B?dGZLRE55cjEwM0FZVEorekdCc1hqMG4yNkZyWndIRWVudHBIWjVQbUx3TVgy?=
 =?utf-8?B?LzQ5N202VTd0RE9Ua3ZadFEzL2lxckw1Y2czMndqanlocWZkWXJyY2JWOHNs?=
 =?utf-8?B?eVZzdXpKVE9RZ0ROdHdBOEdkeDhHUWwxTVZ2b2xic1hlbjlWZy9DUzNqZG1O?=
 =?utf-8?B?ZE1NTnpZUHRsTUFjVTFQSmZsWDBHcW1tQ0RYWnMwMW9XV3F0VTh4NVNCTVpT?=
 =?utf-8?B?dDJZWDhRUWdXQTJVc1MxQUZQc2t2cXNjT3M2aFA0aEtjU292Ym02QXlMWlVy?=
 =?utf-8?B?RlBGM0NqQjk1NUlVTjA5Ui9HTWFGTy8xSHNDclc5N3BmdG5vcVlicmpLbEZO?=
 =?utf-8?B?RkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: da15a763-1866-401b-00c2-08dbcfaf2ec6
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4243.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 07:52:31.6377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: woGk3/2n+Zy6WHUB/sWQgtyKEmR0pVEmlmT34pEVTysl6iijVADkcZ0e6jB+wTBjbs2Of1gCNXBd3N73A+RjLAqVJxtsGC+uDgxxL06rAt0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4554
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.10.2023 09:45, Greg Kroah-Hartman wrote:
> On Wed, Oct 18, 2023 at 09:32:46AM +0200, Karolina Stolarek wrote:
>> On 18.10.2023 09:03, Julia Lawall wrote:
>>>
>>>
>>> On Tue, 17 Oct 2023, kenechukwu maduechesi wrote:
>>>
>>>> Replace udelay() with usleep_range() for more precise delay handling.
>>>>
>>>> Reported by checkpatch:
>>>>
>>>> CHECK: usleep_range is preferred over udelay
>>>
>>> This message is typically not a good candidate for outreachy patches,
>>> because you need access to the device to be sure that any change is
>>> correct.
>>
>> Could we add a paragraph on how to pick good checkpatch.pl error to fix to
>> the Outreachyfirstpatch docs? This could go to "Find a driver to clean up"
>> section, for example.
> 
> The ability to find a "good" error changes over time, so this might be
> hard to do.

I agree, but we can all agree that experimenting with udelay during 
Outreachy is not a good idea, and people should know about it

All the best,
Karolina

> 
> good luck!
> 
> greg k-h

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18CAF7BD55F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 10:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234483AbjJIIkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 04:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234407AbjJIIkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 04:40:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030FC9F;
        Mon,  9 Oct 2023 01:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696840830; x=1728376830;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/QZ5/EKlHn/SlnptrZeCdEO2is8/89UtABQhdwTJUu4=;
  b=NEVW4h9AN7TfjCBd7dVIX3joJzEJdFxlW1Vmq1yEYKyKR2b86DukMioi
   VfVUBzX68DJTii4YzgG3vJaw5Rf6BibukFwsRhQlRaQy/9z1DpXh701lg
   rmDt8JgXwx8Fp2c7hhmXCcBMzt5q804avY0/6koIyWtLKHKbx6p2bARp5
   tADB0yfVQeMeGM+81ef6nGtiO1j8OTXMDlZJjLWcp1R2Ls3aiasQt/wVM
   bJjhIjaHUby+OQe7UYosWHWpUdIBh3gLQzqSm6LF/ZNEJ2StzplatYxzN
   bbKnm1Y6wCl7e2ZHcb4ReeCj56obkRMCAz2IQGyxGS4+5t8cCkgHwi0O4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="386942861"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; 
   d="scan'208";a="386942861"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 01:40:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="702813030"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; 
   d="scan'208";a="702813030"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Oct 2023 01:40:28 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 9 Oct 2023 01:40:28 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 9 Oct 2023 01:40:28 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 9 Oct 2023 01:40:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JzSfkU5WJ8c90qOLvjNy9B9HxFpK0elc/9/7+KgPTfmnAv6g+XrWQXvU6pthEoPBj9i8GV2wckfLxY1WmE6lEK+N+eZu92ZdrL3SR0+KTYtAeoZXZcWAekOpiEppSXOtA7gqn6sAH3k2iUpGWDmn9Wbjm3yDEGW2E7YnwAyH4/WG6Rmioh5OT66OKCoCnYzHnqMG0kAnERwtl0SsODsGWMYpdEbySYVyCENtKBALjbydsuh8CpGeOpZqHEXPLWwOkKXOSSJTwR7OgqnF8h8Rtenzpe885fn7mf6EMKaCH6wBPqCYRg5CoxrIRJk6QxXXpQzidnUaLtK0/sGRvEc4yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lf0VypmJCElyGvmj49asOlIfnxxQMn/+qazmoRe7eAI=;
 b=a6oKsR6Q2lEFmVd8s01DXbhcPhOMIWLyPNpjJ5khqGb8+Tx+/29lJzUITDteaon6My9Tuy7llhBguZ81ixVUERdpz8hTvyqo2BPNAqnQlpN82WuHjtGMj4LZFfJ6rErGCKwu4TsXRnNg3CcVfTUr7y4ddGsPkEaXodlGXYDH5qb1rYoemoISpze9zdkrMrn7Oik+SbsSSTtgFH91+XZhTGpdd3U+ZeCC0qfbN+FBRLO9UH1DtO3hyqY5lKkbDsgCaW7DrdosMCNI+5YadLc67f7P/KBPF+f2evzgqoVUK/Cw4LCNncy0BAEpN5eRtjDvk8hI+Ixww75azGA3ZZIcAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5603.namprd11.prod.outlook.com (2603:10b6:5:35c::12)
 by SA1PR11MB5899.namprd11.prod.outlook.com (2603:10b6:806:22a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Mon, 9 Oct
 2023 08:40:21 +0000
Received: from CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::dbe4:218c:1bdd:510]) by CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::dbe4:218c:1bdd:510%4]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 08:40:20 +0000
Message-ID: <f8ff3c4b-376a-4de0-8674-5789bcbe7aa9@intel.com>
Date:   Mon, 9 Oct 2023 10:40:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] ACPI: AC: Replace acpi_driver with platform_driver
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <rafael.j.wysocki@intel.com>,
        <lenb@kernel.org>, <dan.j.williams@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>
References: <20231006173055.2938160-1-michal.wilczynski@intel.com>
 <20231006173055.2938160-4-michal.wilczynski@intel.com>
 <CAJZ5v0jKJ6iw6Q=uYTf0at+ESkdCF0oWaXRmj7P5VLw+QppKPw@mail.gmail.com>
 <ZSEPGmCyhgSlMGRK@smile.fi.intel.com>
 <CAJZ5v0gF0O_d1rjOtiNj5ryXv-PURv0NgiRWyQECZZFcaBEsPQ@mail.gmail.com>
 <CAJZ5v0iDhOFDX=k7xsC_=2jjerWmrP+Na-9PFM=YGA0V-hH2xw@mail.gmail.com>
From:   "Wilczynski, Michal" <michal.wilczynski@intel.com>
In-Reply-To: <CAJZ5v0iDhOFDX=k7xsC_=2jjerWmrP+Na-9PFM=YGA0V-hH2xw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0041.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::17) To CO6PR11MB5603.namprd11.prod.outlook.com
 (2603:10b6:5:35c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5603:EE_|SA1PR11MB5899:EE_
X-MS-Office365-Filtering-Correlation-Id: 17b9c4bd-68aa-4c1d-cc92-08dbc8a35edf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: alpFWkBpORirrXA7OIx76VV8xJ5Y5ELHbK6erIQ3qZ7vd5LBXMoNMSslTV0P7FD+DK0t0KzQ0xg7V4UHGy6QJ9T4NNUzgdPqmtH6sebvxGv9pkYXQIKXx1Zj7y04RU6Pk1n1+h/TSEaOkb4nftcw0pj6dRGrJrKCuD55UORKwLWoUJPA9oMVF9PkthD1G2bk6t96VA8aYgws9MhvBhuOywFUT4trF0kF4ko2RRudUjGFQOSW//6S09UUeULU+44bpeNc/13T5s79wqLr+gIjrHI8NEUReDLDivC9Cfs6ZEhD+HAQFbHC0wwBKh8iT3MtvU/PooFoPaA4NjzF4QMA0zSyZSCRsIKpqUjc8qgkOAVHMOlazMUZM+MebfnjAZUdqN6iHFt1hEiRNVSW+RdDO3PLGk/JK8Eg5RVlm5lWARGjdyhoxinYyy1qYmrFLjhEZ9gDcgWIaztCnkg0iRiweZk/EGTvZ2eNki4w+1id5WuBtjW0AwH89MfCYlz5Ip2iow/OSz8if2MdH41Nfr2+VQKT8lwZh4KBEuGmlgY5t312GwFR3uqIq3yIThMv1EfANTILW+01XJ39hc376SDaPiq8OA02/y624LbWqcz3T2GhpP1N4uvx2ipuc0uDJD4ccSelxRK5wLB48mniebH6sw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39860400002)(346002)(396003)(376002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(86362001)(31696002)(38100700002)(82960400001)(36756003)(31686004)(6486002)(2906002)(6512007)(478600001)(8936002)(5660300002)(4326008)(8676002)(41300700001)(6506007)(53546011)(83380400001)(6666004)(2616005)(107886003)(66556008)(66476007)(66946007)(110136005)(6636002)(316002)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YURRUGV1TE4zbGpwMWZHZVhqSGt4SkJXbGc2NW4xNmxWdmh0UTVHc0Q0Uk5X?=
 =?utf-8?B?b2NSenJtVGhJZnNaM2VseEsrQnBRVG1Zc1RVRjZmMUR0Z3BqQmNRS1lpRitz?=
 =?utf-8?B?NktPemplSWJsYzdjVmlWMytrWkZiQjhKYVRqNFo2aW9JeFpsYzFSb2JiazJs?=
 =?utf-8?B?dk9icjBPMFdDbEJYcHVSYmxQeW5LNEpha1lNSDBDZi9OQ1FDMU9Wd2dsN0FF?=
 =?utf-8?B?cHp2VEdQVGwvdEtUVDR4ZVBBa2xiYVU5MnRXcHpmWUpXS2IvMllOOHRBbkU0?=
 =?utf-8?B?eHhEeU1jT1FOd1I1VUlGS2gwMjJPR1NDcGRMeVE1OUR5ajQ4SUV4dnZIRUNy?=
 =?utf-8?B?WGpkbm9pNERnTVJLVitDaFBkMWdaSXpkZGpzelRlMlhOQWxpMTQxMmRxVS9W?=
 =?utf-8?B?NXF4V2pvMk1FdkVOTytIaURYWE0xejdIWGhET25iK2JXdDY3dXRxMmhUaHFW?=
 =?utf-8?B?R3hPUXJNc1kzakprS3dyUDJYQ1Vuem0xZ2lISS9jZE5NTE9PNE5tL1krNUtT?=
 =?utf-8?B?VVo2QVBTVU54UlRkUDBLUFhvcUNndFJsZkJOcW8yb2IzUzM2a1hvVFc0dGk2?=
 =?utf-8?B?TXBDL0NZRndhbUhUY0FYaVc2ZWtnTkJ6aVFCYWhXOHEvSVdTYVNEeHJkRFVh?=
 =?utf-8?B?OVZIK1dmNkpzSzVGYXREMForQ1NIRFdnQVROOVBDeWtwV1lWTVBIcldXRkJW?=
 =?utf-8?B?TW8xbHNRNDg5Q1Z6a2kxRC9xMjNCOWdYM0EvRHpRWlV2eWM5dEhjVjd4eHpp?=
 =?utf-8?B?bVhiZHp0dGJwdWc0U0E3M3F4L05MNXA5QU1ORmNTYmdZcUFKdnB6OTcxelp0?=
 =?utf-8?B?L2tUZ0ZhMWhFd3B4M3U5M2RIN25KTnJ3ZGV5ZE53QnhWUFZ1YlFxczhOampI?=
 =?utf-8?B?dWRLUFVNN0VWaHcyVUR3Y3NCZVpWTEdiSFRWOXhDdGlueTBnZmtmOUNsbkRU?=
 =?utf-8?B?d1REVTR6UEpLeGZaNnJmMitmNHhzdDE5dEo5RnNFY0lmODFYMmkrWnV0Zi96?=
 =?utf-8?B?enNxaEJENXd3NHpFRVVHY0lJdWgxSi9JNlRKbjlaODRnVTM0VlNhM2NscE04?=
 =?utf-8?B?MWN2d1NsODF6WWVhaUFjN2U3bERVYS9XZkY0SFl6SVFIT2RHWjJ6UEJ4M29a?=
 =?utf-8?B?Tkx3VmJzdDVabE9qSnNnNGVVb0YvMzl3VUlFUW1lNElTQlFYZWVVNVEzYXFn?=
 =?utf-8?B?WUZybFpKN2szWjVsOTBUTk9FKzFQUUJ2akRiNE5BVEVEaUprTnFmL3JxUUg0?=
 =?utf-8?B?K0dRZHhHRCtLQU9oVUY5OTJ4VG1uNDlmNzIrczZDeTIzcFZvY3M1TVkraGVw?=
 =?utf-8?B?alNMeCtpeklPTmJwMDNucXI2cUdNc094d3BMVVVNRGw3VFZIT25ZRzROZjha?=
 =?utf-8?B?QkhMS0hrKzQ4R1RzZzlWaVpkaXRDamJuMm9uS3pEMjVPMEFtQkNJSmtrNWU3?=
 =?utf-8?B?SjJpcmxybEE4VEZoQTRhaTRsb0d0SnY4dU95MlR6UUQvZzJmUktGNkh5Nzly?=
 =?utf-8?B?RFFqR1lwTFNRR1g5SDB3RzlpWWdmYXQxWFFOL3NuZWErb29IU3dpdGE4TDBC?=
 =?utf-8?B?WktIZW5KSXVBSmhuVEFhc1pQWTlNY29mNTlUZ2hHYXRjOFZUM1FIbGExbFpZ?=
 =?utf-8?B?a0piMWZGeEVLTTVTbHJ4ejRDMG1LQnZDaktERzFvaVY4eGhWSlNCdVo5YnZn?=
 =?utf-8?B?cElSM3ZCWWQ1N1Y4SFFNTlhaR1JuR1R5bHlBN3k4OVN2MXVNOGM3RzNxR1FS?=
 =?utf-8?B?NlZDdlBpU29nZzIwVEZocGlLbjBDeG9hUERDakRXY3c4dmo5dnkwcVI2engr?=
 =?utf-8?B?dDFKMkNYYll3N2xLZUV5QTJaR1RJa0hYUEpiQy9CMzFWQndyUzRVRjI0bEVQ?=
 =?utf-8?B?eTFCUkV6dXNHL1lYYjBUZnR3Q1o5Yy8rZ3B0dFlQOFRwM0k1QjkzKzVMTmhl?=
 =?utf-8?B?RjZZYkxocWxFMkJsZ1I5R1NMZUE4L1JoazUya3JjMW1RWmtRa1BVdGdqSm04?=
 =?utf-8?B?WHRyUWUxVnNnK05rSGhKY1RCMUNvdUlpNFJhbzBaVG9ObFgzQVJ3YXRCeDI1?=
 =?utf-8?B?c2xPa0F1bEpiOFh6OHZ0ak9MQy8rcGdCUnRYLzl1N01ZY3ZNZkUrdFV6N0N6?=
 =?utf-8?B?bDV0L2dlamlSU3hTdTlmZUsyVTZjbXJqVGM2Z0xBanZobzRYa0VlYjhuYTBQ?=
 =?utf-8?B?bmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 17b9c4bd-68aa-4c1d-cc92-08dbc8a35edf
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 08:40:20.2634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OaGoYYAE+xhOwO2QlgV437b1Uwg8MIJRxK7rbetPNHQJ1ZYKtKkzUulMtx3RVVhHxuYmQQTr9nTfNkmmeEvr/TKU6z7mgRUEL1APz9r6n4Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5899
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi !

Thanks a lot for a review, to both of you ! :-)

On 10/7/2023 12:43 PM, Rafael J. Wysocki wrote:
> On Sat, Oct 7, 2023 at 12:41 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>> On Sat, Oct 7, 2023 at 9:56 AM Andy Shevchenko
>> <andriy.shevchenko@intel.com> wrote:
>>> On Fri, Oct 06, 2023 at 09:47:57PM +0200, Rafael J. Wysocki wrote:
>>>> On Fri, Oct 6, 2023 at 8:33 PM Michal Wilczynski
>>>> <michal.wilczynski@intel.com> wrote:
>>> ...
>>>
>>>>>  struct acpi_ac {
>>>>>         struct power_supply *charger;
>>>>>         struct power_supply_desc charger_desc;
>>>>> -       struct acpi_device *device;
>>>>> +       struct device *dev;
>>>> I'm not convinced about this change.
>>>>
>>>> If I'm not mistaken, you only use the dev pointer above to get the
>>>> ACPI_COMPANION() of it, but the latter is already found in _probe(),
>>>> so it can be stored in struct acpi_ac for later use and then the dev
>>>> pointer in there will not be necessary any more.
>>>>
>>>> That will save you a bunch of ACPI_HANDLE() evaluations and there's
>>>> nothing wrong with using ac->device->handle.  The patch will then
>>>> become almost trivial AFAICS and if you really need to get from ac to
>>>> the underlying platform device, a pointer to it can be added to struct
>>>> acpi_ac without removing the ACPI device pointer from it.

Yeah we could add platform device without removing acpi device, and
yes that would introduce data duplication, like Andy noticed. And yes,
maybe for this particular driver there is little impact (as struct device is not
really used), but in my opinion we should adhere to some common coding
pattern among all acpi drivers in order for the code to be easier to maintain
and improve readability, also for any newcomer.

>>> The idea behind is to eliminate data duplication.
>> What data duplication exactly do you mean?
>>
>> struct acpi_device *device is replaced with struct device *dev which
>> is the same size.  The latter is then used to obtain a struct
>> acpi_device pointer.  Why is it better to do this than to store the
>> struct acpi_device itself?
> This should be "store the struct acpi_device pointer itself", sorry.

Hi,
So let me explain the reasoning here:

1) I've had a pleasure to work with different drivers in ACPI directory. In my
    opinion the best ones I've seen, were build around the concept of struct
    device (e.g NFIT). It's a struct that's well understood in the kernel, and
    it's easier to understand without having to read any ACPI specific code.
    If I see something like ACPI_HANDLE(dev), I think 'ah-ha -  having a struct
    device I can easily get struct acpi_device - they're connected'. And I think
    using a standardized macro, instead of manually dereferencing pointers is
    also much easier for ACPI newbs reading the code, as it hides a bit complexity
    of getting acpi device from struct device. And to be honest I don't think there would
    be any measurable performance change, as those code paths are far from
    being considered 'hot paths'. So if we can get the code easier to understand
    from a newcomer perspective, why not do it.
   
   
2) I think it would be good to stick to the convention, and introduce some coding
     pattern, for now some drivers store the struct device pointer, and other store
     acpi device pointer . As I'm doing this change acpi device pointer become less
     relevant, as we're using platform device. So to reflect that loss of relevance
     we can choose to adhere to a pattern where we use it less and less, and the
     winning approach would be to use 'struct device' by default everywhere we can
     so maybe eventually we would be able to lose acpi_device altogether at some point,
     as most of the usage is to retrieve acpi handle and execute some AML method.
     So in my understanding acpi device is already obsolete at this point, if we can
     manage to use it less and less, and eventually wipe it out then why not ;-)
   

Thanks again !

Michał



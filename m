Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF5B7BDD13
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 15:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376669AbjJINEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 09:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376800AbjJINEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 09:04:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090E3111;
        Mon,  9 Oct 2023 06:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696856650; x=1728392650;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=S/X7pV0Gw9nr2Okjrb16i5k8FuYLHrnEoU1W+Zq70Dw=;
  b=hUWgtLxFLaLrovc3r6K6x/7k+uFkC55l1rT7AlkyJJvpmCpcBjmz/l1D
   a47mU4iN26awzQQgTT603044HyO0T6O7x2MLmq6YEmnlbjZX1blep9DmL
   XleuMferfKUCeg7MoH0sUDdPVXQUJIR3r1nMEO0ZokSc9K5L0BmtKaeB1
   XDyBHlj8F83wG1fe6CXcS2NnPxFEqRBTzzqdGuRmrO4snhp+B18zM9nNm
   RnDDVvmqxhT88HZZ7+X+WxuQPysskEYgy+Jmws4/bYqawJrKxGSNt7dGY
   JZAxWcHPFvFO0WhS1GG28UXqO5QbxIfIVQXFr+JLuylnCXhG4IG87O0fX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="5682671"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="5682671"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 06:03:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="753007131"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="753007131"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Oct 2023 06:03:26 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 9 Oct 2023 06:03:25 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 9 Oct 2023 06:03:25 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 9 Oct 2023 06:03:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mtXRNEcxn5/12hZPIJELUmhoL+4z10GPTFq5PHraSorBWdcYMzx8p3hIgyB7weuyZTyK5aBUBIKuqME6k21ZDnpxVzpxAAjGCw/cHLa4UwG2WVvQ1tZ7JGQpDVwep/1hLHq8koVaLyf2b8pC3FC0OFnT2t1RNV6OJa5hHSwRiYRafn6MgM25EzSmURMCtoKsc90+h0HRBlxkn9w0JxHR3af7iDlVsOPd2CuYNdr3rrJ0kPCNkxQFUEx8BYbVqvhy08Pi1WLAKzylp3PzzhQPsTcLMAk2lq7jlOK/lKgvS1qQcONb/Vb7Uje5IkNgBTtNIHi6tw3KjS3YZJ9oO/NB/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aPzycL5JZ8wVq5yUwcK1qNOUS5XjQVpy594+NwsXtYc=;
 b=mfvth86tEMllmZu5JRXVIucyIJL1hpF0qUTc6NTj9DmQUlYrj/kYJ2M4yupZAgZ0/gvRCqz8rFSVxLv90yrvMkDR+fmDZVQvyoichtzku5x6KkWT9ylcL6K4kK/Nac5AX4pTsqA7kKEfTroT7pB1NJgTuTKVfRyro6AFHtv5oxg1VX0dW2GuGOeuEJlhuKI3sKoiECPsYA6xUPw9bpHiZHfHPLzbznTn0uRFx5MOgxQeusX/RJTSbvGTSTYdiuuWB+F/Cwo1FS2cYjwnF45kzxXw2kAu0u1NZB8PLP/NLws+acVUQQ+UDTyZcoRgjWmDDU+1TEtP5HWH+La33e/0jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5603.namprd11.prod.outlook.com (2603:10b6:5:35c::12)
 by BN0PR11MB5709.namprd11.prod.outlook.com (2603:10b6:408:148::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Mon, 9 Oct
 2023 13:03:22 +0000
Received: from CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::dbe4:218c:1bdd:510]) by CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::dbe4:218c:1bdd:510%4]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 13:03:22 +0000
Message-ID: <be180b68-d31f-4e7f-aeaa-071be74e2696@intel.com>
Date:   Mon, 9 Oct 2023 15:03:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] ACPI: AC: Replace acpi_driver with platform_driver
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <rafael.j.wysocki@intel.com>,
        <lenb@kernel.org>, <dan.j.williams@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>
References: <20231006173055.2938160-1-michal.wilczynski@intel.com>
 <20231006173055.2938160-4-michal.wilczynski@intel.com>
 <CAJZ5v0jKJ6iw6Q=uYTf0at+ESkdCF0oWaXRmj7P5VLw+QppKPw@mail.gmail.com>
 <ZSEPGmCyhgSlMGRK@smile.fi.intel.com>
 <CAJZ5v0gF0O_d1rjOtiNj5ryXv-PURv0NgiRWyQECZZFcaBEsPQ@mail.gmail.com>
 <CAJZ5v0iDhOFDX=k7xsC_=2jjerWmrP+Na-9PFM=YGA0V-hH2xw@mail.gmail.com>
 <f8ff3c4b-376a-4de0-8674-5789bcbe7aa9@intel.com>
 <CAJZ5v0i4in=oyhXKOQ1MeoRP5fAhHdEFgZZp98N0pF8hB6BtbQ@mail.gmail.com>
From:   "Wilczynski, Michal" <michal.wilczynski@intel.com>
In-Reply-To: <CAJZ5v0i4in=oyhXKOQ1MeoRP5fAhHdEFgZZp98N0pF8hB6BtbQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0182.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::10) To CO6PR11MB5603.namprd11.prod.outlook.com
 (2603:10b6:5:35c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5603:EE_|BN0PR11MB5709:EE_
X-MS-Office365-Filtering-Correlation-Id: 379d642b-ce86-4e5b-d289-08dbc8c81e01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dbqhsgw6mRngPzodN795JmuWIhWRwsgPjGXxmJQYLiGvaC+fZW/wqKqNPmrrJJ5veLgBYoBq/XpPnggy3oUz/ak7kUacgBwyxuub0Od6v9Ekf3MgJBPH6ejK2js1u7DzavE6ZhsvvSUzsq4Gr2FPiNNDFw/saB35c3SFmdnVC7PpVeSJox9v9/0K9djrzuy94T8gdQkzTA2kHg/17xKzPPRJTP5mxSnKgrMmSXzW16dO8W0S1H5BkXFD/QC/h8WLQtjLOm6ibBfBO5uKokjXOuax6BOe0nNB8e6D15a7HEicvoVa/LuW+fB8E4Usi8tCgrKCqKKgQzBL40+zhGXnrv1dpVGO7aFnN9Q+2k4Qa67TCJqa5+8yWZZriNutYLaEf/xxPxYe7BPXI/u9Ng9BaCUMqjeWWM5OQ2gCz964CDrXrG7Z78Q1TTV158mpn3AVWdYP0E9jrxgNteAT53E33gzM7dPH3K3wlGIUAcVq6glzccF04V8iV9y+xUrdatkfFj1VdOvNFcC7nvgCmZx4/xI4Y9+C9f1AXw9r9rEqzRAKtthgO+xWKcwtHpnqse5ecEQxT7UyVhTQrPFTWlUvO9ADwIcDsUq0+hMhteg1zEYzEIKKThJPh0EI8gm/8mX2wntC7on5SqMSlrxXNut6hQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(136003)(39860400002)(376002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(31686004)(6506007)(53546011)(107886003)(2616005)(6512007)(82960400001)(36756003)(86362001)(31696002)(38100700002)(26005)(83380400001)(2906002)(6486002)(966005)(41300700001)(6666004)(478600001)(4326008)(8936002)(8676002)(316002)(5660300002)(66476007)(66556008)(66946007)(6916009)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjNuWVIwTWpadGNaS3hzSjRqeFZJTlloTmhwTnhlVGNoQm5ib0lmQ0c4TmRY?=
 =?utf-8?B?YnJUL2g2L0hFeEN1ZzlKK3VJZFcwemhpV3Z5U3ZiQkZVZkt4T21uWWpCTkhu?=
 =?utf-8?B?WGhZSjVJMTA1RXpobGgxWWpqVjVsVXY3Rndmb0tOcy9SOXlrV25iU2tHWGQy?=
 =?utf-8?B?TWhUQlFIWVlYSEJoa0x5MUxVaWdkVjRmWWVYcEVqZzVsZXJMUW9ic2dBUzAz?=
 =?utf-8?B?TksrUUM0enBmaFhqaVFLK2h4M0RyRFc4aStYYUZ6RFVZYUFFUDFyWDhGcFh4?=
 =?utf-8?B?UmVqT1VJQVJDTnltVFZhNEhjNEE0M3ZGbzdEdjQ3R2U2NHdyUGNzWUNKOUZi?=
 =?utf-8?B?NWtzbytqYXl4eHBSaW12aGdVaWJ2QUNrZWZTL3dnWHBXK09XWFZvT3VaUkl0?=
 =?utf-8?B?clhqbnB1VHBhUFdnZENtNmpJTExwQlV0Nm5yUTlESjVNd1YxdDZRVnJFUXhq?=
 =?utf-8?B?cDhvUTE3YWZ6eW5Ec1pOeGpsV0tISXVaclg1dXpTRXNDTGt5YlNXcHZqdTlm?=
 =?utf-8?B?WGQ4d254VmVqWTNKR3p3eUpMTDRqSkg4bGt2YXA0UFVnOVd4Q1NpMG5ZVks0?=
 =?utf-8?B?UEY3MEhSWDg1cHAwRkMzZmtKR0s5TWRMUy9WeUh2bmJscTBFWll6Y05nbEFj?=
 =?utf-8?B?SEY0NW41NkRuQjQyb28yOFhvd3BTajdONGZIQjYreGd6SkdtSGJnWmxqaWw2?=
 =?utf-8?B?VWtraGJ6WUVSeG8rZk03QzN6TnNQcFIyYjA0aXREa2pFMUoveUJzb2c5T1c5?=
 =?utf-8?B?bkZwdXE2QjNYZFkrNlFGSlVkWU1zaU0zUUdmMkNYeWR1ZXJ2YnJkQkQzRjNK?=
 =?utf-8?B?R1E0SGd4dEh3QjZDU1JhKzZsM2NYM0xRbU5WaDZicGkvQ0JoVFdQYSswemd1?=
 =?utf-8?B?U0ZFZUM3QjNjV2VwU0VTVldwV0dISjhoYTNTSXBBdFNnZ2hqdVBnNWYxVlo2?=
 =?utf-8?B?RlBLYmg1WVZSK3NWZGNUTldYRElKdC8xSVd5cWdITGZKNk5zWFBUMEZsZ1pm?=
 =?utf-8?B?cFpyZ09TWkpBMEZxazdOOUNvRy9uYUV2QW1lRzVnZUpkcDNRTWpsY1RXcitS?=
 =?utf-8?B?UDVtQ2poRWtPeFZraDRuVW1TandqRlBvSEtVMXZZOHQva3dKd0xKVmJJV3Bv?=
 =?utf-8?B?WWE1TmhCU0luaVhOTDdNR242VlYvK2JUQ1RNNERvTGdUMnVHeDV6bHJZK2du?=
 =?utf-8?B?ZVZ0TVBSakZDaWV6UFJkWWdkV2UreW1mUGJtbjU4blphQ0JwY1hhTm83T3A2?=
 =?utf-8?B?enp3UHdFZDl6RWJrU3dFSUk5UlRiYXArVFVKTndvdjd5ZjdVak1kYlJMaUJN?=
 =?utf-8?B?ZVNuUjdpanNGRzcwUE9GaU5EeklCWVg0enhvd2hiaklkUFJxSXkzUnZ5WGR2?=
 =?utf-8?B?My9WTWZxcllmZ09SaDlLWFU3RkpmdHhEZ09VR2N5TEw2RGZBNnJtaVNjdnBv?=
 =?utf-8?B?TktsbjRJNy94Z3o1VVlKK0YzN08wMGFMWVBtSUQ1R0NXNC9wMlJzTzZtM1Mx?=
 =?utf-8?B?TlBYWWF5UkZuejVQaENRRFU0cExFejhYTWhNQ1pkN3NkcWhvT2tMNjhrQ3Ay?=
 =?utf-8?B?TTFMc3F3SXBEMEZScndmeDdnVXg5bkpsTmlFdk1TeDdlc1RhaEJWK1QrSVU4?=
 =?utf-8?B?U21aTzMvcG5vakJSYTUva2hTeGwwemY5a0s5TVdQZm5xSWhVKzlpMWduNXB5?=
 =?utf-8?B?SE45d1BCVlpVcjREbTQwbzQ5cHFCTjJ5d040SnlTRGwwN1h0OUc2Y2djQzFr?=
 =?utf-8?B?bVJpbEZEcUNQcHdrc2tTZitLVGRlU1MvZ29vN2VWc0cwSXQwZlFpbERQQ1hF?=
 =?utf-8?B?KzR2QmNuWVg0cUNFVlhMN2d3SU9mT2VXckhUVG5YVjh4N2FNaGhFU3NzSHV5?=
 =?utf-8?B?SCtHdTlwaFh1RThsN3Y1MTZEUWExamJQUlZOMjl4MkhjTXVWdW1sM1FLdy9J?=
 =?utf-8?B?c3gyZE1QODlRZ2RDZjR5NDZrdW5oZFN4bk9FZm1qTjczNVBOZUxQUW1lOGhT?=
 =?utf-8?B?ZzhrNjU0VkhaSVdyeW41WkpLTUo3eTVZL0taQnRIS3VZaGROVnA3bnprN2ll?=
 =?utf-8?B?NHhOMXcrUEpkdlpENzNsaGlXNmJPenRwazdwZXl3Q0M0a0ZxREIwcFU1a1Ey?=
 =?utf-8?B?eFdBZlZpR1hUZDNTcEcyYm9NRWsraUpPclZXbmtuM1ZwdWRHVkhmUndCMmx4?=
 =?utf-8?B?Qmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 379d642b-ce86-4e5b-d289-08dbc8c81e01
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 13:03:22.8207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lwzYGlgUe+iLkF5c1N9ET5kfwvJJ+ftMsNpqUdVFEQ4Cq5eD+tW6SECQsDu9rDhWnP3E34lIQ8yGUBlkHss9ShOHNGLlbSmyoPkYAlDJsS8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR11MB5709
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/9/2023 2:27 PM, Rafael J. Wysocki wrote:
> On Mon, Oct 9, 2023 at 10:40 AM Wilczynski, Michal
> <michal.wilczynski@intel.com> wrote:
>>
>> Hi !
>>
>> Thanks a lot for a review, to both of you ! :-)
>>
>> On 10/7/2023 12:43 PM, Rafael J. Wysocki wrote:
>>> On Sat, Oct 7, 2023 at 12:41 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>>> On Sat, Oct 7, 2023 at 9:56 AM Andy Shevchenko
>>>> <andriy.shevchenko@intel.com> wrote:
>>>>> On Fri, Oct 06, 2023 at 09:47:57PM +0200, Rafael J. Wysocki wrote:
>>>>>> On Fri, Oct 6, 2023 at 8:33 PM Michal Wilczynski
>>>>>> <michal.wilczynski@intel.com> wrote:
>>>>> ...
>>>>>
>>>>>>>  struct acpi_ac {
>>>>>>>         struct power_supply *charger;
>>>>>>>         struct power_supply_desc charger_desc;
>>>>>>> -       struct acpi_device *device;
>>>>>>> +       struct device *dev;
>>>>>> I'm not convinced about this change.
>>>>>>
>>>>>> If I'm not mistaken, you only use the dev pointer above to get the
>>>>>> ACPI_COMPANION() of it, but the latter is already found in _probe(),
>>>>>> so it can be stored in struct acpi_ac for later use and then the dev
>>>>>> pointer in there will not be necessary any more.
>>>>>>
>>>>>> That will save you a bunch of ACPI_HANDLE() evaluations and there's
>>>>>> nothing wrong with using ac->device->handle.  The patch will then
>>>>>> become almost trivial AFAICS and if you really need to get from ac to
>>>>>> the underlying platform device, a pointer to it can be added to struct
>>>>>> acpi_ac without removing the ACPI device pointer from it.
>> Yeah we could add platform device without removing acpi device, and
>> yes that would introduce data duplication, like Andy noticed.
> But he hasn't answered my question regarding what data duplication he
> meant, exactly.
>
> So what data duplication do you mean?

So what I meant was that many drivers would find it useful to have
a struct device embedded in their 'private structure', and in that case
there would be a duplication of platform_device and acpi_device as
both pointers would be needed. Mind this if you only have struct device
it's easy to get acpi device, but it's not the case the other way around.

So for this driver it's just a matter of sticking to convention, for the others
like it would be duplication.

In my version of this patch we managed to avoid this duplication, thanks
to the contextual argument introduced before, but look at this patch:
https://github.com/mwilczy/linux-pm/commit/cc8ef52707341e67a12067d6ead991d56ea017ca

Author of this patch had to introduce platform_device and acpi_device to the struct ac, so
there was some duplication. That is the case for many drivers to come, so I decided it's better
to change this and have a pattern with keeping only 'struct device'.

>
>> And yes, maybe for this particular driver there is little impact (as struct device is not
>> really used), but in my opinion we should adhere to some common coding
>> pattern among all acpi drivers in order for the code to be easier to maintain
>> and improve readability, also for any newcomer.
> Well, maybe.
>
> But then please minimize the number of code lines changed in this
> particular patch and please avoid changes that are not directly
> related to the purpose of the patch.

Sure, like I've stated before I felt this is part of this patch, we only narrowly
escaped the duplication by introducing contextual argument before ;-)

>
>>>>> The idea behind is to eliminate data duplication.
>>>> What data duplication exactly do you mean?
>>>>
>>>> struct acpi_device *device is replaced with struct device *dev which
>>>> is the same size.  The latter is then used to obtain a struct
>>>> acpi_device pointer.  Why is it better to do this than to store the
>>>> struct acpi_device itself?
>>> This should be "store the struct acpi_device pointer itself", sorry.
>> Hi,
>> So let me explain the reasoning here:
>>
>> 1) I've had a pleasure to work with different drivers in ACPI directory. In my
>>     opinion the best ones I've seen, were build around the concept of struct
>>     device (e.g NFIT). It's a struct that's well understood in the kernel, and
>>     it's easier to understand without having to read any ACPI specific code.
>>     If I see something like ACPI_HANDLE(dev), I think 'ah-ha -  having a struct
>>     device I can easily get struct acpi_device - they're connected'. And I think
>>     using a standardized macro, instead of manually dereferencing pointers is
>>     also much easier for ACPI newbs reading the code, as it hides a bit complexity
>>     of getting acpi device from struct device. And to be honest I don't think there would
>>     be any measurable performance change, as those code paths are far from
>>     being considered 'hot paths'. So if we can get the code easier to understand
>>     from a newcomer perspective, why not do it.
> I have a differing opinion on a couple of points above, and let's make
> one change at a time.

OK

>
>> 2) I think it would be good to stick to the convention, and introduce some coding
>>      pattern, for now some drivers store the struct device pointer, and other store
>>      acpi device pointer . As I'm doing this change acpi device pointer become less
>>      relevant, as we're using platform device. So to reflect that loss of relevance
>>      we can choose to adhere to a pattern where we use it less and less, and the
>>      winning approach would be to use 'struct device' by default everywhere we can
>>      so maybe eventually we would be able to lose acpi_device altogether at some point,
>>      as most of the usage is to retrieve acpi handle and execute some AML method.
>>      So in my understanding acpi device is already obsolete at this point, if we can
>>      manage to use it less and less, and eventually wipe it out then why not ;-)
> No, ACPI device is not obsolete, it will still be needed for various
> things, like power management and hotplug.

Sure, haven't reviewed all that use cases yet, but the name 'acpi device'
implies like it's part of a driver framework, and it won't be anymore after
transformations are completed.

>
> Also, I'd rather store a struct acpi_device than acpi_handle, because
> the latter is much better from the compile-time type correctness
> checks and similar.

Sure that makes sense

>
> I can send my version of the $subject patch just fine if you strongly
> disagree with me.

Well I can disagree, but still change it ;-). Just explained my reasoning so
you can make a decision with all the data points provided.

Thanks a lot !
Michał

>


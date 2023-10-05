Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCE47BA491
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239628AbjJEQHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239324AbjJEQEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:04:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512232D0D4;
        Thu,  5 Oct 2023 07:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696516081; x=1728052081;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=v1CmrraQyEJ62f4ZXsobUAkyuLiWs/bw4jOGWH09i6k=;
  b=FsUbKM8IwbQRgmkqRzApknLHsFcUGOAA52LzHlOXeYtMN+zg2mpEkbL6
   Hu8qDDfXQuHx62/pUEDbPNgt4kmqB2dIveUIS4mSVlz6zoSbZDf6qkqmC
   BcRadq2QLHQQitPGxr6YmwdjlgLfRDNcmxJCt6P+y0foaQojCl1s6wFNA
   AbWRlPznAZmwHTmE8+TbdsR0jh289UpYmouAx+LQTG7ytE6Ym0CSEV4PU
   0QCzQgtFsOXytcEEPEBGObs4/AAiVU/9vlqQncleGWK4eMW/DA6aWHQ8q
   66fUDHciSkvfCUTi8V6e6ZyH5hQ+yEfU2C3Ejfb6Zb4WHny1yiz7WlskZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="2078417"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="2078417"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 05:05:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="842358702"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="842358702"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Oct 2023 05:05:29 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 5 Oct 2023 05:05:29 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 5 Oct 2023 05:05:28 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 5 Oct 2023 05:05:28 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 5 Oct 2023 05:05:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aK3aYqOOdrvnk/fAZM8qi99HATdZI/noOv7maeYNA/LePxlAi1tuRKSMDijR0F4se16HpV2VcOmyxNb0HCq5R3/PKaV24qT35ijCrE0Ue2NNA2BIOuhrv0oPeTj80wYp/PgOU3zXxlopwef49YjMjprrG7pgc+TsIkzvu7pGig6LFne0AQiaMfES+lDaBRTRc4oeLhdJMXEte8Ia08R8o0CUKRq7Iyl2Z0MgO3+azCLMeuxaKiyy9H0oDmLF7gg1FVRxrTDrEUvfGHDDFBxguhjJ3nGfW3FR3NkPbcdo6nENfrkFk+PL1StA3S2tHCMoJMjOKVrP8mYeF+/kKv6w0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tw78a7cl4okrkTBMzHH7MjnXwN6jzpQJjsNsRkXOG0E=;
 b=UTsd1DlHjYyEn2VyUcJFQN8ngAL9xXFUUy/Cv6HMhx0GFYXwOpY7FCATXlJoYwfCjZo3qGYuXkdevXV59oklx8dQ2KrDqGmc/tPDL9QQc+e3O16jTBlXm12mhxDxcAKRqpvbHD7gyxwDbfBNJT/tvHcxAUzmsZ+lY90i7XIaNwYHzVrR8m+1ZtMk+x5X9ss/X4GOqzadP/PSrSIxJNSzqgmdJPZ73QtUEme9bgKhHffLDsINs6K1NH1tFtr/QvmpG0qRxwWryY4EKWLYGY6LhMm2RuBk04uUYUmvLEzTc308Ap+mLR0sTRJfbUc/FuZbCoyJvuuImLCjxm0dCWtlWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5603.namprd11.prod.outlook.com (2603:10b6:5:35c::12)
 by PH8PR11MB7991.namprd11.prod.outlook.com (2603:10b6:510:25a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.34; Thu, 5 Oct
 2023 12:05:26 +0000
Received: from CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::dbe4:218c:1bdd:510]) by CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::dbe4:218c:1bdd:510%4]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 12:05:26 +0000
Message-ID: <86a68f57-0e5e-4a92-8cfe-93249ba78a72@intel.com>
Date:   Thu, 5 Oct 2023 14:05:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/9] ACPI: bus: Make notify wrappers more generic
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <rafael.j.wysocki@intel.com>,
        <andriy.shevchenko@intel.com>, <lenb@kernel.org>,
        <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <rui.zhang@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20230925144842.586829-1-michal.wilczynski@intel.com>
 <20230925144842.586829-2-michal.wilczynski@intel.com>
 <CAJZ5v0jyjH48XZ6vytncodYhsS6ODYg2yaZBPfRWb_qm99FMuA@mail.gmail.com>
 <f8b9cfb4-aa0f-44c0-84fe-613f005a2baf@intel.com>
 <CAJZ5v0jF_okRNkYySRQTSKBohaFk52V7Tcm=a1kVFaY6MWD4Hg@mail.gmail.com>
From:   "Wilczynski, Michal" <michal.wilczynski@intel.com>
In-Reply-To: <CAJZ5v0jF_okRNkYySRQTSKBohaFk52V7Tcm=a1kVFaY6MWD4Hg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0135.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::19) To CO6PR11MB5603.namprd11.prod.outlook.com
 (2603:10b6:5:35c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5603:EE_|PH8PR11MB7991:EE_
X-MS-Office365-Filtering-Correlation-Id: 4547b5f0-d408-446a-c11b-08dbc59b5be2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YgJkbHoGPGvIrELcSJKJFCh8XwC+Jr1RnmDLVj7CwsHdm5f7ltNIJKN/y9EdIyyBrBj6lpns6yZX+CnFAa+QPphpHdvhyv6mJZ+1OgLLrPHu9Vc0cep4YnPYRuXauLesDE9MmR7oauw0Uc8ISuhHYS4fSdCOgyKoLuazr45TVBZisF+dwfY/4o/oXeJl8wGxEYYxAsFfDFmQP9jXOAZz1II8mFGI7sgi8dnjG7WFKhR6peA3fK72sopSxVjpNcuWtswuFVyRxYBnHSlx/GJLlLOTmhKBf67zPrp9cGWdkwCFaSW1AQkqfMpw33ETK6Yj2wRsns1qm4rx/ZReWaKodVWW4iKeKJtNUwpMuV2B7+jvxZRubg8AIS+p4k++xCBgWb+XXo+0RcQYMe27Qxv7hOu95sGpMhoeKXyWecPoc2jrlNbD9aJ0OTU4l2bEtk0eZimgmGM0Chki18JQeHGdA8Y7GTMldpqvtCnlstKKHRTSR1Oa1m0D7WkpmX/4qGf6APEGlaVKVmf3Kgow85+OPLKK07hqKE5nPTBYbbZjgrd6f8bdSY1jryE4mZfCFlbJ5gQZrfyUJWv9DfixF7U1sUzXKi1QsyMG/DcE2sVh6JbXEJg7uHvyD92Am7lGn1/7zZogXduO2wFsGzUXX6Y5n7zbRy9hJq6m50Wnisc85tc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(396003)(346002)(366004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(2906002)(6666004)(478600001)(966005)(30864003)(41300700001)(83380400001)(38100700002)(31696002)(86362001)(66946007)(316002)(6916009)(66476007)(8676002)(8936002)(31686004)(5660300002)(66556008)(4326008)(6506007)(6486002)(53546011)(82960400001)(6512007)(36756003)(66899024)(2616005)(26005)(41533002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGlqeVdRd3NZM2h1ZDlpOXNKSzN1ZTEyaU9MRlhtSkNzeVptTWtGSzZxb3dw?=
 =?utf-8?B?SVJLOUFMMUpoM2VOdWdjdERlbGVkajNpOXRRSjZ3TWwrKzN3dEZMSkJ1dmNh?=
 =?utf-8?B?VE04dVk3eDgzQ3RINUg3emVqc08xUGNKcE9OSkhwWGR0dE5LV3IzTUxOMHNo?=
 =?utf-8?B?UWhhV05UTDQzeWZlM2NPbXVkc281bENJREZBcHpmb3AxVC9jMmpxbnNMZHdy?=
 =?utf-8?B?cnBLY25PejlHWmtkSlNLUmdUWEtvbzZENTRQeDVRSFhMYjRPVXJha3BvdTRM?=
 =?utf-8?B?Z05nNXdsc3FGeng4bVR0eW9tVHVFWDY0U3RnaUtIemxFMEpNL1F5dTJ3ekEy?=
 =?utf-8?B?Wjl4ZHFhcE5xeVV0MS9RYVJBdjd0aXFGVTU3aHlJWVp5YkJpZzRJeWNtQ2Nt?=
 =?utf-8?B?NDdDTVJKRWZKa3hhR2theUtzRDhHbk5NWUNFeEVNc0kxUFYzUk9acGc2eXVw?=
 =?utf-8?B?TkdHRWpBRm5IYkR6d2hGTXE5YUNOOTNVRVhscUtCeGFjV05pTnQrNCt3V1JJ?=
 =?utf-8?B?aUV2a0d4bjJ1VDdHcnBFNXB5VERhQ09reVl1TCs4Z2txKzNIbTMvNkl5V1Fu?=
 =?utf-8?B?M2s2cVc1N2NteVIxOXNhcndlWXh3OGJQdEYxbllnU0pQYXdNVFZnckUwWE5y?=
 =?utf-8?B?dFZVQWV1ZEZmdGtTT2ZpYXNBV2NLZnI2cTltNXp1NTdFTlMyMXBBZGtTZkhv?=
 =?utf-8?B?S2phVjVsaEhCa3kwV0NmVUVUMU56aGw3MVljVGZKS1liWDhxUW9DWW9pdWlr?=
 =?utf-8?B?TzVPUDdOL0NGOHhTRzh5MDdodkNhZUNRN1pMcURGZ1dodUtBNDhiQ0hucmRh?=
 =?utf-8?B?bVpQckNaSk9sQTYzNmFlYlB4b29FeDU2OGx2UTh2SDlRLytTdUxMT1lnQ3lq?=
 =?utf-8?B?VDMzSi9DUzlIUFUxQ1g4MVJhbUtJamdpWmgxSWZmMEhSSnlUOU1FUkQ4anRK?=
 =?utf-8?B?NnFPcjQ3UUdCNU1hNU9VT05SMHRsckhjTm9Ub1phK2syaXRKWnNoUFg1Qy9X?=
 =?utf-8?B?cGJPdUo3SFlMMkYrYnVRYlF5Y2R2V1JpVG9qSno1QmVXWS9xZFRObkdCbTVM?=
 =?utf-8?B?WGdES1JMZTBGYndrSmxCdHhGbFZtdmlodG5Nd3Vsa3FNNUpya0dKcFNab0Yx?=
 =?utf-8?B?aU9UdFhTTFo2ejhoNEJqby9Ta082TFU1R1BzSHR6REI5eXoxckRTeW1qelps?=
 =?utf-8?B?MXR4dS9XTVp6d2x3ZERuWWw2MDFJeElGQU91TkthUmM0L2tUdDhKQU5tdGVz?=
 =?utf-8?B?Z1VzUU0vMUhwMlJ4N2NGaGJuelRLc3JzN2REN2V5cTFaTm1wUE5iVG5mbkNW?=
 =?utf-8?B?V3RIVkltYXNuYkZaQmZNUkN4d3U2OVdGOUk0U2hvK0cvOGUxTGNWRkUxcG50?=
 =?utf-8?B?SW5LU1NObDJFK20vY2V4ZHZkV1dqbnc3dDgzS0NhenVtb2FSZERkZ2hsOVlP?=
 =?utf-8?B?UmhYTkR3RWg0amZIM0tJNzZvOXdEakdZUnA0Yk5ESkN1b2lTczdmWEs1NTZT?=
 =?utf-8?B?MTYydHRYbTY0T3BDR0hnTElqeUxyV2ppVXhNVjMrdGxTM3Y3UmwyYllOYXFn?=
 =?utf-8?B?OEJQTGx1Vkd6Q0ViME5nVFA5S2FrbzQ5RVB5M2M1c2ZNbW1ZRWpJK01Sa2xI?=
 =?utf-8?B?VEJNb1dZRmRtVWFLNGE0OVhzRlVJTUlyMTB6OXBXQW84dVpPblpiem9XTzFF?=
 =?utf-8?B?RUdFeW1XcGpZZC9GZTQ0OUlUU3IvRXdlVlp0NHN4UjZRMk5ZYmlIQUdHWFFD?=
 =?utf-8?B?bmp1eERRUGs0dFdRUHNWYjBiaUU2bllSNmFHSXhhVmhUV2xSbWNkNHpGSUZL?=
 =?utf-8?B?bWo1aUJ4SE92VW44NjNHWEdnQVRnc3NXd1FQWjB3NFFmSmNtQmw3dXlQY0lO?=
 =?utf-8?B?RjFmaWlpd0lqZEhpRXJ2emJCc1NEaDBiOURUVUxPVVBtanZuTzRueEdQdkFB?=
 =?utf-8?B?NjBCZUZ3dWladXVlNGxZSHVnMWNWOWd5c2tUZVVvQU91c1l1Z09SUld4QXg0?=
 =?utf-8?B?NWVPWGthcW1URlV0V1pORXgxbGdHL3orVld2a1pSTWlBK0hEdHZQU0NoeGVY?=
 =?utf-8?B?dE1DUlVPcHJHbHNVbVc3cWdRaGhNN2dCcFRHV0MrSmptRERLKzlvMGFlRFlR?=
 =?utf-8?B?UHFPTHFNOWlWZ0NUbzNDbU1KK0ZCelo5dmlXU0hFZ0FMZC8vN21LNjRVSzNn?=
 =?utf-8?B?RkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4547b5f0-d408-446a-c11b-08dbc59b5be2
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 12:05:25.7985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n1odrQYMz7z8pP7HH9jmqwSXq3nhwryspr5pirNaBoYpv8OQEhmu6aCZ5uxFMkmGfxs9tF2S6FoA7JshsuIabNy45GoMA5I7CFUSAvcqtcA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7991
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/5/2023 12:57 PM, Rafael J. Wysocki wrote:
> On Thu, Oct 5, 2023 at 10:10 AM Wilczynski, Michal
> <michal.wilczynski@intel.com> wrote:
>> Hi,
>>
>> Thanks for your review !
>>
>> On 10/4/2023 9:09 PM, Rafael J. Wysocki wrote:
>>> On Mon, Sep 25, 2023 at 6:31 PM Michal Wilczynski
>>> <michal.wilczynski@intel.com> wrote:
>>>> acpi_dev_install_notify_handler() and acpi_dev_remove_notify_handler()
>>>> are wrappers around ACPICA installers. They are meant to save some
>>>> duplicated code from drivers. However as we're moving towards drivers
>>>> operating on platform_device they become a bit inconvenient to use as
>>>> inside the driver code we mostly want to use driver data of platform
>>>> device instead of ACPI device.
>>> That's fair enough, but ->
>>>
>>>> Make notify handlers installer wrappers more generic, while still
>>>> saving some code that would be duplicated otherwise.
>>>>
>>>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>>>> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
>>>> ---
>>>>
>>>> Notes:
>>>>     So one solution could be to just replace acpi_device with
>>>>     platform_device as an argument in those functions. However I don't
>>>>     believe this is a correct solution, as it is very often the case that
>>>>     drivers declare their own private structures which gets allocated during
>>>>     the .probe() callback, and become the heart of the driver. When drivers
>>>>     do that it makes much more sense to just pass the private structure
>>>>     to the notify handler instead of forcing user to dance with the
>>>>     platform_device or acpi_device.
>>>>
>>>>  drivers/acpi/ac.c         |  6 +++---
>>>>  drivers/acpi/acpi_video.c |  6 +++---
>>>>  drivers/acpi/battery.c    |  6 +++---
>>>>  drivers/acpi/bus.c        | 14 ++++++--------
>>>>  drivers/acpi/hed.c        |  6 +++---
>>>>  drivers/acpi/nfit/core.c  |  6 +++---
>>>>  drivers/acpi/thermal.c    |  6 +++---
>>>>  include/acpi/acpi_bus.h   |  9 ++++-----
>>>>  8 files changed, 28 insertions(+), 31 deletions(-)
>>>>
>>>> diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
>>>> index 225dc6818751..0b245f9f7ec8 100644
>>>> --- a/drivers/acpi/ac.c
>>>> +++ b/drivers/acpi/ac.c
>>>> @@ -256,8 +256,8 @@ static int acpi_ac_add(struct acpi_device *device)
>>>>         ac->battery_nb.notifier_call = acpi_ac_battery_notify;
>>>>         register_acpi_notifier(&ac->battery_nb);
>>>>
>>>> -       result = acpi_dev_install_notify_handler(device, ACPI_ALL_NOTIFY,
>>>> -                                                acpi_ac_notify);
>>>> +       result = acpi_dev_install_notify_handler(device->handle, ACPI_ALL_NOTIFY,
>>>> +                                                acpi_ac_notify, device);
>>>>         if (result)
>>>>                 goto err_unregister;
>>>>
>>>> @@ -306,7 +306,7 @@ static void acpi_ac_remove(struct acpi_device *device)
>>>>
>>>>         ac = acpi_driver_data(device);
>>>>
>>>> -       acpi_dev_remove_notify_handler(device, ACPI_ALL_NOTIFY,
>>>> +       acpi_dev_remove_notify_handler(device->handle, ACPI_ALL_NOTIFY,
>>>>                                        acpi_ac_notify);
>>>>         power_supply_unregister(ac->charger);
>>>>         unregister_acpi_notifier(&ac->battery_nb);
>>>> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
>>>> index 948e31f7ce6e..025c17890127 100644
>>>> --- a/drivers/acpi/acpi_video.c
>>>> +++ b/drivers/acpi/acpi_video.c
>>>> @@ -2059,8 +2059,8 @@ static int acpi_video_bus_add(struct acpi_device *device)
>>>>
>>>>         acpi_video_bus_add_notify_handler(video);
>>>>
>>>> -       error = acpi_dev_install_notify_handler(device, ACPI_DEVICE_NOTIFY,
>>>> -                                               acpi_video_bus_notify);
>>>> +       error = acpi_dev_install_notify_handler(device->handle, ACPI_DEVICE_NOTIFY,
>>>> +                                               acpi_video_bus_notify, device);
>>>>         if (error)
>>>>                 goto err_remove;
>>>>
>>>> @@ -2092,7 +2092,7 @@ static void acpi_video_bus_remove(struct acpi_device *device)
>>>>
>>>>         video = acpi_driver_data(device);
>>>>
>>>> -       acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY,
>>>> +       acpi_dev_remove_notify_handler(device->handle, ACPI_DEVICE_NOTIFY,
>>>>                                        acpi_video_bus_notify);
>>>>
>>>>         mutex_lock(&video_list_lock);
>>>> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
>>>> index 969bf81e8d54..45dae32a8646 100644
>>>> --- a/drivers/acpi/battery.c
>>>> +++ b/drivers/acpi/battery.c
>>>> @@ -1213,8 +1213,8 @@ static int acpi_battery_add(struct acpi_device *device)
>>>>
>>>>         device_init_wakeup(&device->dev, 1);
>>>>
>>>> -       result = acpi_dev_install_notify_handler(device, ACPI_ALL_NOTIFY,
>>>> -                                                acpi_battery_notify);
>>>> +       result = acpi_dev_install_notify_handler(device->handle, ACPI_ALL_NOTIFY,
>>>> +                                                acpi_battery_notify, device);
>>>>         if (result)
>>>>                 goto fail_pm;
>>>>
>>>> @@ -1241,7 +1241,7 @@ static void acpi_battery_remove(struct acpi_device *device)
>>>>
>>>>         battery = acpi_driver_data(device);
>>>>
>>>> -       acpi_dev_remove_notify_handler(device, ACPI_ALL_NOTIFY,
>>>> +       acpi_dev_remove_notify_handler(device->handle, ACPI_ALL_NOTIFY,
>>>>                                        acpi_battery_notify);
>>>>
>>>>         device_init_wakeup(&device->dev, 0);
>>>> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
>>>> index f41dda2d3493..479fe888d629 100644
>>>> --- a/drivers/acpi/bus.c
>>>> +++ b/drivers/acpi/bus.c
>>>> @@ -554,14 +554,13 @@ static void acpi_device_remove_notify_handler(struct acpi_device *device,
>>>>         acpi_os_wait_events_complete();
>>>>  }
>>>>
>>>> -int acpi_dev_install_notify_handler(struct acpi_device *adev,
>>>> -                                   u32 handler_type,
>>>> -                                   acpi_notify_handler handler)
>>>> +int acpi_dev_install_notify_handler(acpi_handle handle, u32 handler_type,
>>>> +                                   acpi_notify_handler handler, void *context)
>>>>  {
>>>>         acpi_status status;
>>>>
>>>> -       status = acpi_install_notify_handler(adev->handle, handler_type,
>>>> -                                            handler, adev);
>>>> +       status = acpi_install_notify_handler(handle, handler_type,
>>>> +                                            handler, context);
>>> The wrapper now takes exactly the same arguments as the wrapped
>>> function, so what exactly is the point of having it?  The return value
>>> type?
>> I considered removing the wrapper altogether, but decided not to do so.
>> One trivial advantage of leaving this wrapper is the return value type as
>> you noticed, another is that the removal wrapper actually does something
>> extra and removing it would result in duplicate code among the drivers.
>> So I didn't really want to remove the 'install' wrapper but leave the
>> 'remove' wrapper, as I think this might be confusing for the future reader.
>> In my mind if something is removed by the wrapper it should also be
>> installed by the wrapper.
> I agree here.
>
>>>>         if (ACPI_FAILURE(status))
>>>>                 return -ENODEV;
>>>>
>>>> @@ -569,11 +568,10 @@ int acpi_dev_install_notify_handler(struct acpi_device *adev,
>>>>  }
>>>>  EXPORT_SYMBOL_GPL(acpi_dev_install_notify_handler);
>>>>
>>>> -void acpi_dev_remove_notify_handler(struct acpi_device *adev,
>>>> -                                   u32 handler_type,
>>>> +void acpi_dev_remove_notify_handler(acpi_handle handle, u32 handler_type,
>>>>                                     acpi_notify_handler handler)
>>>>  {
>>>> -       acpi_remove_notify_handler(adev->handle, handler_type, handler);
>>>> +       acpi_remove_notify_handler(handle, handler_type, handler);
>>>>         acpi_os_wait_events_complete();
>>> Here at least there is the extra workqueues synchronization point.
>>>
>>> That said, why exactly is it better to use acpi_handle instead of a
>>> struct acpi_device pointer?
>> I wanted to make the wrapper as close as possible to the wrapped function.
>> This way it would be easier to remove it in the future i.e if we ever deem
>> extra synchronization not worth it etc. What the ACPICA function need to
>> install a wrapper is a handle not a pointer to a device.
>> So there is no need for a middle man.
> Taking a struct acpi_device pointer as the first argument is part of
> duplication reduction, however, because in the most common case it
> saves the users of it the need to dereference the struct acpi_device
> they get from ACPI_COMPANION() in order to obtain the handle.

User don't even have to use acpi device anywhere, as he can choose
to use ACPI_HANDLE() instead on 'struct device*' and never interact
with acpi device directly.

>
> Arguably, acpi_handle is an ACPICA concept and it is better to reduce
> its usage outside ACPICA.

Use of acpi_handle is deeply entrenched in the kernel. There is even
a macro ACPI_HANDLE() that returns acpi_handle. I would say it's
way too late to limit it to ACPICA internal code.

>
>>> Realistically, in a platform driver you'll need the latter to obtain
>>> the former anyway.
>> I don't want to introduce arbitrary limitations where they are not necessary.
> I'm not sure what you mean.  This patch is changing existing functions.

That's true, but those functions aren't yet deeply entrenched in the
kernel yet, so in my view how they should look like should still be
a subject for discussion, as for now they're only used locally in
drivers/acpi, and my next patchset, that would remove .notify in
platform directory would spread them more, and would
make them harder to change. For now we can change how they
work pretty painlessly.

>
>> It is often the case that driver allocates it's own private struct using kmalloc
>> family of functions, and that structure already contains everything that is
>> needed to remove the handler, so why force ? There are already examples
>> in the drivers that do that i.e in acpi_video the function
>> acpi_video_dev_add_notify_handler() uses raw ACPICA handler to install
>> a notify handler and it passes private structure there.
>> So there is value in leaving the choice of an actual type to the user of the
>> API.
> No, if the user has a pointer to struct acpi_device already, there is
> no difference between passing this and passing the acpi_handle from it
> except for the extra dereference in the latter case.

Dereference would happen anyway in the wrapper, and it doesn't cause
any harm anyway for readability in my opinion. And of course you don't
have to use acpi device at all, you can use ACPI_HANDLE() macro.

>
> If the user doesn't have a struct acpi_device pointer, let them use
> the raw ACPICA handler directly and worry about the synchronization
> themselves.

As mentioned acpi_device pointer is not really required to use the wrapper.
Instead we can use ACPI_HANDLE() macro directly. Look at the usage of
the wrapper in the AC driver [1].

-static void acpi_ac_remove(struct acpi_device *device)
+static void acpi_ac_remove(struct platform_device *pdev)
 {
-       struct acpi_ac *ac = acpi_driver_data(device);
+      struct acpi_ac *ac = platform_get_drvdata(pdev);

-       acpi_dev_remove_notify_handler(device->handle, ACPI_ALL_NOTIFY,
+       acpi_dev_remove_notify_handler(ACPI_HANDLE(ac->dev),
+                                                                     ACPI_ALL_NOTIFY,
                                                                       acpi_ac_notify);



[1] - https://lore.kernel.org/all/20230925144842.586829-1-michal.wilczynski@intel.com/T/#mff1e8ce1e548b3252d896b56d3be0b1028b7402e

>
> The wrappers are there to cover the most common case, not to cover all cases.

In general all drivers that I'm modifying would benefit from not using direct ACPICA
installers/removers by saving that extra synchronization code that would need to be
provided otherwise, and not having to deal with acpi_status codes.

>
>> To summarize:
>> I would say the wrappers are mostly unnecessary, but they actually save
>> some duplicate code in the drivers, so I decided to leave them, as I don't
>> want to introduce duplicate code if I can avoid that.
> What duplicate code do you mean, exactly?

I would need to declare extra acpi_status variable and use ACPI_FAILURE macro
in each usage of the direct ACPICA installer. Also I would need to call
acpi_os_wait_events_complete() after calling each direct remove.

>
> IMV you haven't really explained why this particular patch is
> necessary or even useful.

Maybe using an example would better illustrate my point.
Consider using NFIT driver modification later in this series as an example:

1) With old wrapper it would look:

 static void acpi_nfit_notify(acpi_handle handle, u32 event, void *data)
{
    struct acpi_device *adev = data;
    /* Now we need to figure how to get a 'struct device*' from an acpi_device.
         Mind this we can't just do &adev->dev, as we're not using that device anymore.
         We need to get a struct device that's embedded in the platform_device that the
         driver was instantiated with.
         Not sure how it would look like, but it would require are least one extra line here.
     */
    device_lock(dev);
    __acpi_nfit_notify(dev, handle, event);
    device_unlock(dev);
}

2) With new wrapper:

static void acpi_nfit_notify(acpi_handle handle, u32 event, void *data)
{
    struct device *dev = data;

    device_lock(dev);
    __acpi_nfit_notify(dev, handle, event);
    device_unlock(dev);
}


So essentially arbitrarily forcing user to use wrapper that takes acpi device
as an argument may unnecessarily increase drivers complexity, and if we
can help with then we should. That's why this commit exists.

>
> Thanks!

Thank you :-)



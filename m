Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D44B7BE75D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 19:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377272AbjJIRH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 13:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376329AbjJIRH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 13:07:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02549E
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 10:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696871244; x=1728407244;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yiC3drxqQyp9xFjtDj1t024La7gB59DNuBIP3qcq+8k=;
  b=eZuMb8wujZZl131LexS2wul0WTtAhU2CFgyJ8+beakD9X6lDNxI34+/B
   kt5WfmWMSr9zLf0it/5CuffCGRiNp65aqSOrxMH/BsR04lbj31LVksqvW
   YQ1WCXmFXz+12KBsRrJotMX+ud75Q6IdubxAwIFWMW3Nk0X6pyABPdrXF
   u1JUJ1usTKWJ3tpI78S3S7PwZd3whcugEkPVIeHfB5uistrjLeRXaOeLF
   YTq+yn51FcY5pPm6I3B7A7TFE3/0HX9VA5pW7bTp0YK+uD5GAJpZLTq64
   wW6c4SRhFW5Kfqu+M6AfK5Fjvn/C7FYkXsICw0DHnd9zavgcx048htk0e
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="470458257"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="470458257"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 10:07:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="756779128"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="756779128"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Oct 2023 10:07:07 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 9 Oct 2023 10:07:06 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 9 Oct 2023 10:07:06 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 9 Oct 2023 10:07:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mhhU9n35RVUsAU6YpHNZh9kgLOQo1Z2wNSnsPKPdlpiws2sKpXK/LjJkaoWsVwY0+qMNyWtSpw/LhGDp2z1gKzlK1ECycGDrRfboCev51eE0B6j+7HQY3nlqF3FN/vrO676LyFg8uAmybEQbRzP6jpBQ+PuIe/i0NPwFyYvYKxGy2g+MKEKUgz4gqd10MgXw+KwmXmVfv73YJ8sFebUBt7j9I9At0lDIurpewysgA8hTtDW/sTHvQfphjUZMScWqYO4+HnFnAIp8qPD5cIZh9Q5IEoov99ZFlLd1/JIg5orqdlz2VQVBdEHLmu84OhJ+9yYdOHFa9FxAvvhGuvdlUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1qBe5DrSUPb3npFEpOXhed76KiqjfX08ePhDyf4Ym/U=;
 b=bEj18s+WmOYg0ViSs1RfsM43a/FieQ/pD3HcrIUt/CcdHuGmPVgnI9yntIBauHd+UKahKUnYOxwP0pUDIClUae9024hPbWxesfavf8QPdH96mmnR+I4e+SIneeyJqO2bqniUtl3RqNRMjGswCQkG+o5yvKH27sd3AaZMhtIDCOqA6e8I9zSZO2OpTtr70o+XzB73NX04DUf0kLxEGAl3ypy8dCr5PkLE3tQ0CDeJPndsC8XNdYjc1PFCnxqobi2xq8oTkBLBEzcbPrgRZ//26uGzG6wfLtosY4PJ3DIGZsMv00XaDEE/fr7xyLZq63bbFaJzTChtcwJ5mqIWa++jXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM4PR11MB5277.namprd11.prod.outlook.com (2603:10b6:5:388::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Mon, 9 Oct
 2023 17:07:05 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 17:07:04 +0000
Message-ID: <5589e93d-9a9c-4199-a187-ab60fb127236@intel.com>
Date:   Mon, 9 Oct 2023 10:07:02 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/intel_rdt/cqm: fix kernel-doc warnings
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     kernel test robot <lkp@intel.com>,
        Vikas Shivappa <vikas.shivappa@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>
References: <20231006235132.16227-1-rdunlap@infradead.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231006235132.16227-1-rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0249.namprd04.prod.outlook.com
 (2603:10b6:303:88::14) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM4PR11MB5277:EE_
X-MS-Office365-Filtering-Correlation-Id: 73e1b6a0-0e31-401d-7e08-08dbc8ea2985
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5ykETDcxueU10uS/3GkDozmoqMWdgIF37qrJE1nLbos94dloDmR5Zl0tP5xBdqBagqe+AoZBn5cIgEl0FUE30K+s08j89bhtdPLe+b3MLQXh4VZspFp/ks76RUAFDEdRWOIlsGA0V6DamTYfkWV9vVhMMh1bosHzFV3e7RJXGpcZru0tEX4ZRoA3X4rf6uCj7AghABpGmXmNC/1w9TC2OdG/t2eK0ks6SLQKIe5A5sfAilAgPzBchvE1fEjQf2kzlsdeUajthYPn+CwM9k9HYl2B2fOT54BvqyhS6x1fVciuGXOSG5CX3p5XWpeGRN1m0iD0HABb9DMhFN2iirGat3GY2nq/S6qe0WIikrQGwa83x9HESjA/TNlntWyEbGdyV8Z2TCrHggZOE9asqsK0bKPGFnpcit2Mh9mJ/ggFa26v+rB/E0rfOn+E1wH5FhbJFYyWL7wOLAg1NtOqCDw1qSGAkOt2gwO8lxPfvb1+cIXBTQ5QuuY6l0mvqLOkwKcO1fOZstcqsGULMJOzvVpldziWUSI8aDOZWcYu84f2RPa0CkQx/hkiLbdCM7Tp56wqsULU/3gorC9A3Z1EzI3zXu3Rv463n9+j7gglivunQfdDnokJN8rV4VWkX52Z20ra
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(346002)(39860400002)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(2616005)(53546011)(26005)(6512007)(478600001)(8676002)(83380400001)(4326008)(44832011)(2906002)(6506007)(8936002)(54906003)(66476007)(66946007)(5660300002)(6486002)(41300700001)(316002)(66556008)(966005)(82960400001)(38100700002)(36756003)(31696002)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHNLZTlhWFgvVC9mdm5NTzJUbEZaeTF2ZDR4SS96OWo4T3BEMW5EUENUaFYr?=
 =?utf-8?B?RWl4S3p4K3dZNUxXclM1aGM2RnRXUHg2RnljaXA0UmNJVlY0T0sxSmp2dSt0?=
 =?utf-8?B?a1UyZFlVZThFbDJsY1pRSjJVV25BYUpKcGRZVnh1Y2pkRTc4aVdEYUtEbGxQ?=
 =?utf-8?B?NUJ6VDBjanpaaHY0cTB5SVRaaldWSVE1YXBrb2hsTDFLWEJaMk5Ia0owV2d4?=
 =?utf-8?B?Tndhb2xxcnpXRG5IV25zcGd6R01laGF5OEU4QVZycmEreFA2NmxncnpHUFVz?=
 =?utf-8?B?ZlVLTnRtazR4UTg4SlBnZXJ0UXNCY3E0aWswcnNJM0swUkF2OGJyQTl5dS91?=
 =?utf-8?B?cjRnTFU5UCtCRTNCUXFWSlNycHZFUk1DaGt6Y09ta29PQmoxL2xSejBmSGF5?=
 =?utf-8?B?cnREKy9BdFFkUnBWcXNucGtDd1dsaFR5MWFDQ0hhcVZCRC9qTFV5L1JPczA4?=
 =?utf-8?B?Qy9vRUlJaTAyNmV5YlVHRnJ5U0JhL05XSW1xaU1MNnRvSytSZUx1dFdCZEpC?=
 =?utf-8?B?R1p6bTdLOXlTUlhaZFY0YUJnREtUTkllanF3b3dGSjBmd3ErR3E1SWhtdjBm?=
 =?utf-8?B?ZUFlUkliVUdBRUgxNnp0TGQzZXlrMXdCVlNKK0t4TU5vbDRyL1pYSml5SzBV?=
 =?utf-8?B?TFhIOXBBQmhzemFFM2N3ZHp6NVFYcU1OWTQrQXJsTmEwVVRpeFN0L2tFNWF6?=
 =?utf-8?B?T3BwOGR5WFUxOVFNdWFQOGFxaCtUVEdzbVo5ekRvNzRGSEdSVnJlUGdFOEd2?=
 =?utf-8?B?WWpzRjV6NlVsTThodUsyaTcxLzk2VzJGTFZ6TkIvVUdFSWNPak81QUVCUi9Y?=
 =?utf-8?B?UDBya1l5SlBsZTQ4STRoN2dnZGE3T1NBdXhhZ3NEWFpQQm10bkpUdVBVOU1T?=
 =?utf-8?B?eDdsMWREYlJqRGNiWThnTm1RTUR1L0dyMmZwbHEzS3poNUtMSWhZU0sxdnkx?=
 =?utf-8?B?SnFpSE9ubTNIYTVWM2lXOCtTRThNbEJwS05EVklsTDVrcGFWRlBRY0NxZVN4?=
 =?utf-8?B?aFNOcElvU1lkWGo1VjQyelBWdEFJZHo2NWZ3cFRwVU5lSWNIWmVjanZ2d2t0?=
 =?utf-8?B?ekR5U2x3eXhaZklBalNIMDk4VDkwdVpLYWFDcmVKaFAzNm15L3dsQXhPTFJS?=
 =?utf-8?B?eVoyY2NpVFV6NXZOVDZRWXN3RGRWOTAwVkxZTDZ2aWVGZ2c3UVVFZEJVSngy?=
 =?utf-8?B?VHNkYy9ENEF3ZzlNTlZxQXZZUDVqUkRQanR5NEFtMXNTdkw5S2M4Tm8wVUZL?=
 =?utf-8?B?amkxVHhOdlhqakQ0MjdVeEhnbUN6NGsvUjVUdVJ4b3dKVnErdXl1S3FVbzRR?=
 =?utf-8?B?OGc3Rng1VXVYUkZtUXB2MXl5V0syZnRtYXdDU0p5UEprVFI4TlV4dE0ybDZL?=
 =?utf-8?B?LzEzSHplaGR4TTBqZE9XbG1NUVVIYzZwTytMRE9nVm1kUEtoUncvcTMxMmd0?=
 =?utf-8?B?ZU5IRVI5eXY2SWpRMGF0aGx3OTJkOTc5b2JFUGZackhMVlc1NDF0cW9LdStT?=
 =?utf-8?B?QUdKN3J0c2c2bFUzeC9NSGtFOFBEZDR1K0VsK0FLeVVXWi9oN0NBN2lTdzZY?=
 =?utf-8?B?VHpSLzRNajBjNjNMeE1HaThiNzBaanJ4cWYyMTcxTzl3RFN1RW11UE1YSzNn?=
 =?utf-8?B?cStEOGliZEFMakZ2dnRpSjYwZ0ZLZ0FNQXZwYWcrNzdBNGE5K0RzMmFDTzU2?=
 =?utf-8?B?Ry8veTVETzJyUHFqcFNTWi9pQ2FlSjFKMG9JTHFKMUtKTC94UjV1ZDFueHJi?=
 =?utf-8?B?WDhDcjF4U3RnVWVwMXZXbVJiSXJlcDdGTDhiNjYyV3ovS3pqMkt3OHhMdFlE?=
 =?utf-8?B?OUM2QzJKZUs1aWwxWmEvcWVwK25uRm81TGlWcnQxV21WYW5tM0lxVVhnNnBw?=
 =?utf-8?B?WjVRVTh6cUs5WW0vVGRwanFBNTRVbEdRVWxRNkgwR1VVc3ZFeHJRN2dkZlFp?=
 =?utf-8?B?Z0NQemJhb0x5MnNzNEk3NnRpT3FwdGE4NzFyMkJlTXNDMlFocGxlempOeGRG?=
 =?utf-8?B?a0RhN0hnS3N5YUdjMit0YmtYTzI3V3QwYUxreHdNanljVkVQMWRpRkk2Vkht?=
 =?utf-8?B?Q2VqM2oweVpwUWFTcGxjK05qTUU4S1Z5dEJxczlWTzl3VFdCZ2JZRGtmbHln?=
 =?utf-8?B?UFJvekpoQTFqellZSkZXME85N3d2T1E1WTlpSkhOM1dGbnFNaUFZS01nLysr?=
 =?utf-8?B?dXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 73e1b6a0-0e31-401d-7e08-08dbc8ea2985
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 17:07:04.9052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Li/OR9yy6I5HGADvfeeN0+6cgQOqu8FqmWAo9tHASkfA5XNVLVrLjDkVdxArW+F3YyKds9er/kEbr9Kng9UnzWL9MFVFKx47wPyRY9HOwaI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5277
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

Hi Randy,

Thank you very much for noticing the bug report and taking the time
to fix it.

To match the custom of this area, could you please modify
the subject to be:
	x86/resctrl: Fix kernel-doc warnings

On 10/6/2023 4:51 PM, Randy Dunlap wrote:
> The kernel test robot reported kernel-doc warnings here:
> 
> monitor.c:34: warning: Cannot understand  * @rmid_free_lru    A least recently used list of free RMIDs
>  on line 34 - I thought it was a doc line
> monitor.c:41: warning: Cannot understand  * @rmid_limbo_count     count of currently unused but (potentially)
>  on line 41 - I thought it was a doc line
> monitor.c:50: warning: Cannot understand  * @rmid_entry - The entry in the limbo and free lists.
>  on line 50 - I thought it was a doc line
> 
> We don't have a syntax for documenting individual data items via
> kernel-doc, so remove the "/**" kernel-doc markers and add a hyphen
> for consistency.
> 
> Fixes: 6a445edce657 ("x86/intel_rdt/cqm: Add RDT monitoring initialization")
> Fixes: 24247aeeabe9 ("x86/intel_rdt/cqm: Improve limbo list processing")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>

Could you please swap the above two tags to follow the tag ordering
custom followed by the tip maintainers? For reference you can find the
details in section "Ordering of commit tags" of 
Documentation/process/maintainer-tip.rst

Also, below the "Link:" follows the "Cc:".

> Link: https://lore.kernel.org/all/202310062356.lX3xpLP9-lkp@intel.com/
> Cc: Vikas Shivappa <vikas.shivappa@linux.intel.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: Reinette Chatre <reinette.chatre@intel.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: x86@kernel.org
> ---
> Not using Closes: since this patch only addresses some of the issues
>   reported.

I am aware of these issues. The person working on this previously
seems to have moved on. I'll share this work with folks looking for
this type of opportunity and ensure that it is completed this time.
 
>  arch/x86/kernel/cpu/resctrl/monitor.c |   10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff -- a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -30,15 +30,15 @@ struct rmid_entry {
>  	struct list_head		list;
>  };
>  
> -/**
> - * @rmid_free_lru    A least recently used list of free RMIDs
> +/*
> + * @rmid_free_lru - A least recently used list of free RMIDs
>   *     These RMIDs are guaranteed to have an occupancy less than the
>   *     threshold occupancy
>   */
>  static LIST_HEAD(rmid_free_lru);
>  
> -/**
> - * @rmid_limbo_count     count of currently unused but (potentially)
> +/*
> + * @rmid_limbo_count - count of currently unused but (potentially)
>   *     dirty RMIDs.
>   *     This counts RMIDs that no one is currently using but that
>   *     may have a occupancy value > resctrl_rmid_realloc_threshold. User can
> @@ -46,7 +46,7 @@ static LIST_HEAD(rmid_free_lru);
>   */
>  static unsigned int rmid_limbo_count;
>  
> -/**
> +/*
>   * @rmid_entry - The entry in the limbo and free lists.
>   */
>  static struct rmid_entry	*rmid_ptrs;

Thank you very much.

I just have the comments regarding this area's customs. With that
addressed:

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

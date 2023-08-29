Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBCDC78C693
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 15:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236579AbjH2N7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 09:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236490AbjH2N6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 09:58:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C81F7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 06:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693317525; x=1724853525;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0uz5BOwpcvGujftKQ4I8Ml8p/0taShifwrKuFaRBBds=;
  b=BK0UdFKcDyQmBLMlQtsQv4hptDUrBZbR598yCjpo5hKtW/ItvDnmPOPK
   RYlBuvOxZrPheLJpXWsE9LWn/0fPVUv2TTtrfDXM6w9vstE5txXfqC0jm
   rT+Mnq+kqGRtMQOgSYijERl3Fv//6tvIpb8OJzJwMT3wg4YGeIRuYAw62
   erguMTvG+tnYxVmbHUfKqizMvnSYkMDRN9mv2KfcUtE0M5mrLdic9sdrT
   AnmNrETKjOchTH3aLPxuB0WBMVaU3+JQC00SuG3wdWoYc52tM1RedwrQj
   ctMpXrXbGlhEI0HBqGGmdTJWphp88wvAY8B2kLu6s5n4RECzzhObaipfQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="379142772"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="379142772"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 06:56:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="985357802"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="985357802"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP; 29 Aug 2023 06:56:53 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 29 Aug 2023 06:56:53 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 29 Aug 2023 06:56:53 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 29 Aug 2023 06:56:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WBOQW5zljDky24KhMuYhD91uI2O/0DTPne+9rr7+qhOZz2NXWA6jUoOFlvc65b9TWAZep7F3/HzfDGOAx1D257vxJUQQvKSTiW1YSdLhft3EYRvmKEanIhs9d68YEENrxj4UMEUvBtjpeTYQtGl7xrkq+7obOVlq7CAWY7bMbWhplAHM9uaRge+MCEgfFPwXKKmm+s1E5DU5SYCgn2t1Jirrv8I7W/GhO6vH/HDHRA6mrppRmEb6LNMPGkRZXhb9c521TdGE7pY7QGRZ9WfLyn12jh944uEmwYWK0FjXOTTL2AXS+zkGHLb2DFxgjTRzYUr3Z+xRggQD/zq92X1h9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ED6ARwX26FLMD1xse1DWMXjhuwFMuR0OYkQ3BGhFIig=;
 b=hZimEDQMKb+/dr+UQdx5b/8jtejF3mx509dkgSxK8uygrsgI38edFMOi1ZD87pHVMGzMxv2zZuJUPYRj94ViKAOBORBhQgUW/t7bBsSBvFRUt3HC4jxODYCHv1xuSt1n7+EBquZ6WXil1IMfqgysJIIxphHKBIP2M0gX8DXJWW0fsuw4azQf9aAhrn9QSbJCiISsRhhqGBrEQtFoe9+Pi/3j0oUKgwBxf3CaWqrOiIRBdxVbN2iXz/ZLAaTXjztXNgeW8UTpYhGucqvduxTOxwxD3TLGZsa76MrLf0I6sQqRcdvY4V9mk9pYGzEHsu1+BeZ/e+iXzyvwREUGb9uk/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5603.namprd11.prod.outlook.com (2603:10b6:5:35c::12)
 by PH7PR11MB6032.namprd11.prod.outlook.com (2603:10b6:510:1d3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Tue, 29 Aug
 2023 13:56:48 +0000
Received: from CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::dbe4:218c:1bdd:510]) by CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::dbe4:218c:1bdd:510%5]) with mapi id 15.20.6699.035; Tue, 29 Aug 2023
 13:56:48 +0000
Message-ID: <3fd2e62d-0aa9-1098-3eb3-ed45460a3580@intel.com>
Date:   Tue, 29 Aug 2023 15:56:41 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] ACPI: processor: Move MWAIT quirk out of acpi_processor.c
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
CC:     <andriy.shevchenko@intel.com>, <artem.bityutskiy@linux.intel.com>,
        <mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
        <hpa@zytor.com>, <lenb@kernel.org>, <jgross@suse.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
References: <c7a05a44-c0be-46c2-a21d-b242524d482b@roeck-us.net>
 <CAJZ5v0jASjc_RYp-SN5KMGJXDv8xbMOqJscLF3wG8rdE2_KJGw@mail.gmail.com>
From:   "Wilczynski, Michal" <michal.wilczynski@intel.com>
In-Reply-To: <CAJZ5v0jASjc_RYp-SN5KMGJXDv8xbMOqJscLF3wG8rdE2_KJGw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0305.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:85::7) To CO6PR11MB5603.namprd11.prod.outlook.com
 (2603:10b6:5:35c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5603:EE_|PH7PR11MB6032:EE_
X-MS-Office365-Filtering-Correlation-Id: d7a55de2-adc5-4507-bac8-08dba897c9bc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SudTyjfgNjeXxZCeMfCzugQyj2Eg0KrSFaRDzfASvkZz08I5AewF2KyQvSUunM1pzWeIr1t3iWCkFTw5ltwzEHJDcMiSlpfS+U0oifUntFEZ6va+hkKIvhp2mGvdNeOofz+THbn7x/q5AkjAkJX3AhpswlCE5YzvNrgXZzdV7TPjjGFqZNVpz3BtQFLXMZFNhCa1QPq3GJNDOp4MDVGu9MFvQmjklxw8xa7cB/8mzq7tlzihIEbygasBX0HidA9e0r9rtgG57Jto58I975p2moHyCfzyG/RGpKzDp2ywrDtj/VM4ZBSQ7rjUvHUd7MdmcFjZrkVGnJeVTg5aEoepbPPxI7oMnkyw96dm53LpbBgg1Y3YwDz45XjZh9Y9+VV+/gvylgoFC2o2wx/ZZVvAw1UcCcLHqA63sfDjHP7saBnU56NekXAaFxwJZvkvOV5breFy1haGz7tVjZnmYbhKw4oVYb15Di3MnkalgK7emVeL0axjY2tpnyL9mRxIAjvKmm8YKtXnDI79hnYsnlWdTfiz3gfItA9Q/RrGNXbsosE0naCSLsffWhsLKZtW2+941XoxoRtmu/TN07pyLfjKTGy7GvHdA+ZnGwrouCS+JZU6asT+Otc90WyylqfyCj5PODdCqKWqYIe8zmTXOvKEhg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(366004)(39860400002)(396003)(186009)(1800799009)(451199024)(41300700001)(7416002)(38100700002)(31696002)(86362001)(83380400001)(478600001)(6666004)(82960400001)(26005)(6486002)(6512007)(6506007)(53546011)(2616005)(66556008)(110136005)(36756003)(2906002)(316002)(66476007)(66946007)(5660300002)(4326008)(8676002)(8936002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXJtUnZyWEVQQktvL0ZEc2dDS1E3T1dpS1BZaWlFQ1FjRHp3RGtWUVZkNSs3?=
 =?utf-8?B?dm85aXhIdEljR2F5aGpkWURqV3VkWmVOZEJNcE5TMVZMRktERmRycWZ4TmRN?=
 =?utf-8?B?N3YvekNyZFVYZzlKbEswZ0kyU0tEd1QzbmdTS3lQYW92REYwYXd2VlExN0Jt?=
 =?utf-8?B?K1BrS3JjNkRtc0FUSGFISm5MQkt1WlY4aGVWeS9PaXZERm9JOHRzVWg0U2Fo?=
 =?utf-8?B?a2d2MG16eThOeG91ZGpJbXB6UjFIN0pTWEE4S0F6L3U2aXAwamJFUG5pUTZa?=
 =?utf-8?B?VE94WFRkaW84M2N2Vzl1N2tnb2lLYWUyS0Zad2pBMzJPUFFCSjdJOEk1SEtO?=
 =?utf-8?B?SmErZFhHSG5rRWhZZ2M3LzR4MzUvUDJ3WkxuUHNPUXFWOG9ZTGhwK2V2M0dS?=
 =?utf-8?B?WC8rNEhiSGJLZGM3WEJvRlhPNElwdEdjMDdKOFhMQkJKWTJBQWhQZElpaXVi?=
 =?utf-8?B?ZGF0bm1Kakc0SDc2bW00Wmp0ZHBaem9uUWZJeXB6VXhYMnVpRCtJQkZKTXlZ?=
 =?utf-8?B?aFZGcGltaDJuaHRFVUlZaUo4TU1POEQ5SE9aWFl5RUdzWmRVU2xOZ0EzWnd1?=
 =?utf-8?B?VWFtVHdianFQZ2l1WDJWOGpaQkVRUWU4ZXdsSHQ2SmpqR1loV2NSYVY2bE55?=
 =?utf-8?B?Umd2R1NSYXRLYVlCZnNRZlZPTnV5Mk9oOTZKdnpzZnliU0pENUhrTllnamw2?=
 =?utf-8?B?dWo1MDBXQkcxSVA2Zzd1cllZUytXSmRqQ2ptbkRJZlRGYTRhd0ZheTBEbG9L?=
 =?utf-8?B?ZnJiWUp5dUgvb0gyYXova2t1NFRBL2JnRXR2TnluMHF0RTZIMFBuckFScHZH?=
 =?utf-8?B?ZnVJdWpkTU40aGMyLzhTQkpldWJ4a3JsS3Y0ZEVkeVIvYzA2QmZOQlU1V1pn?=
 =?utf-8?B?clE4VnJObWVMRHAydEpVOU9xdEQyRnMzN2tLeXlNVjFIVFYvRmJZM2hsU3Zk?=
 =?utf-8?B?ZUFJbE8xdFA2TVFFTUtQblFDV29mcjV6RkllZmM3am5kMWc5eDd3T0sxUG02?=
 =?utf-8?B?ZjVidmlFS0pCazlpTG9zaDVrRGFYMzZNTDdMT1B0VTNkUktJVE15eDlrOWVm?=
 =?utf-8?B?eWxQR1BCLzVzT0FXN2ZOWkorM3RsamFGbG5qOEdQMlUxaGtKWDZydnFoL0Zs?=
 =?utf-8?B?NXhubE5KL2lrSDNDRjBEMHZ1cWkvRkRuVnczc2dMOE42aHRFalRicXY3Z0h1?=
 =?utf-8?B?enVqWXUvcEkxQVdlZUJQa3J2QU5jWTNJemxpN1Znc2NLRXRNYWRSTDlWVTdO?=
 =?utf-8?B?TVRvemIwS0FMbXlZVWxzNHdOeVlJZUxZRXlPejBJZ1hUNjhZaWtYVU1zaUho?=
 =?utf-8?B?VmY1M2xVaWdMemhmUjhHd2loSlA0R0hldG5hWFA1VmhUUmtaaGRmeDZQZmVC?=
 =?utf-8?B?UlM4TnVqUG5FS2luemNoaHJ2NlVyMEJlVDZRNVpValFqbk9DYkwxVm9JcytL?=
 =?utf-8?B?bkF2L1EzbXpZWXdQU3lmeHJzWUhuUS83UFhraHZyZlJpN3M3NmR2TTFUYks5?=
 =?utf-8?B?RDBBVng3d2xud3RYdWtwZjNNaDM3eTBEYzFOVTZ2ZS9uekFYdlhtQzVrTGdo?=
 =?utf-8?B?SDNVUFltclRjZWpITVhNN3B1U1VnYVBHREQwcHBxVFcyN2JHZEFJamp2Und5?=
 =?utf-8?B?OHhKVXpyQjAzM2lzaVdXOEFmUCtRN0ZKQTkvNkR4M0loYSsxYjlPaTNHRHIx?=
 =?utf-8?B?SHFSaUNDc2JJTlVtR255Zk9qWE9kTTBJVG5iMzFBMWVXWGcxMTAxNkI0aHNx?=
 =?utf-8?B?QnRURkw1d3JmR1FwUXdSYWE3OGZUcVdqN0w3Z1ovUWM3MHNuQ2dsMENEL1Ir?=
 =?utf-8?B?TmdrK1ZUYnBudlVUSEdBbkM5QjVLS0MrQVZDVjFiZFlhZzVGcGI0MkV2ZXJi?=
 =?utf-8?B?Y25ROXFQVUNLWmxlVjlzaFZNeURRREZFSWZTVlRJbFNuRkZVbCt5ak1icVF1?=
 =?utf-8?B?d3ZyS3U1QWx0ejRzbmdjNHVIYTNKQ1duVW5hb2xrZkYxc2tzNkdGMWxVbVM4?=
 =?utf-8?B?Nm9RQWh1eVRHVlZ4VzlJeVV4c1RBQktYeDZxS0hVdjVtR0dLN2xyakFaZTA1?=
 =?utf-8?B?c212RytXYlZRcVdYZEpVQ1BxcTMrZVpnR0I0Qkc5d0RpMjdLbkNSV3c1dE95?=
 =?utf-8?B?clJxT0p3Z2x1cmhHWksrTHlGRitGMng1eCs4M09oOWxRTW1aaENCY0ZSbjNX?=
 =?utf-8?B?NGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d7a55de2-adc5-4507-bac8-08dba897c9bc
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 13:56:48.4084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IoRdCg+hNLP4A1/jo9ugLhRmVVcOE/+AkXHp185/PagoYmJIMUdinDI6G+5OeG7wDJR3rV/kstgght6rVmnp6wVfRbn39TXn2nK2W//iy/g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6032
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/29/2023 3:54 PM, Rafael J. Wysocki wrote:
> On Tue, Aug 29, 2023 at 3:44 PM Guenter Roeck <linux@roeck-us.net> wrote:
>> On Mon, Jul 10, 2023 at 05:03:29PM +0300, Michal Wilczynski wrote:
>>> Commit 2a2a64714d9c ("ACPI: Disable MWAIT via DMI on broken Compal board")
>>> introduced a workaround for MWAIT for a specific x86 system.
>>>
>>> Move the code outside of acpi_processor.c to acpi/x86/ directory for
>>> consistency and rename the functions associated with it, so their names
>>> start with "acpi_proc_quirk_" to make the goal obvious.
>>>
>>> No intentional functional impact.
>>>
>> Except for:
>>
>> ia64-linux-ld: drivers/acpi/acpi_processor.o: in function `acpi_early_processor_control_setup':
>> acpi_processor.c:(.init.text+0x712): undefined reference to `acpi_proc_quirk_mwait_check'
>> ia64-linux-ld: drivers/acpi/processor_pdc.o: in function `acpi_early_processor_set_pdc':
>> processor_pdc.c:(.init.text+0x72): undefined reference to `acpi_proc_quirk_mwait_check'
>>
>> which breaks all ia64 builds.
>>
>> Time to retire that architecture yet ? No one but me seems to even
>> build test it.
> Including 0-day it seems.  This had been in linux-next for several weeks.
>
> Michal, can you have a look at this please?

Hi,
I'll take a look and get back to you with a fix,

Regards,
Michał



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A52C7CC613
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 16:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235032AbjJQOl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 10:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234982AbjJQOlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 10:41:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E2CF5;
        Tue, 17 Oct 2023 07:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697553683; x=1729089683;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uAWEdZORcvoQWYRNYQyzCAuW6fB0nrVcw7xIANF8i68=;
  b=UPBVeoLlTnpYoMrLZKkIz1xj2bRUj7J5AtRJUnFjCrB9Yn0NVyI6CJ7p
   4b5an1EJcFYeKoqHD/kpaXxk6r5RXLRbAqBqE1ofX6fTPlSDyPhKvqgSz
   ELtj4vhlf+8FeqUuBS3k9STBsOht3Hx/ETQNTa3HzCyfZ5N8LP5yaRb9Y
   ANLAWiSMyBk9/vL80FFtJtLenEwxL5Icd8xi7h+61yQAxm9d0Xz2ughpD
   h2kLCZaQObUlg+nkPvr13/3uXOBs/0TktsO7G+RgyRSEF0fsONPNqZ2hA
   3WpTVhM6TemtYuaLS9/83whPgHR9cU1oPpCGBpZcAiBfx2OQtA//8WIzr
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="366059106"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="366059106"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 07:41:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="826472217"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="826472217"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Oct 2023 07:41:23 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 17 Oct 2023 07:41:22 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 17 Oct 2023 07:41:22 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 17 Oct 2023 07:41:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P3jpMGyiYfDdf3F/WfjjkEmP9ccnCWYThLa2PUpMuWcAC+MaJJM6C4PRFNqZZPyOa+raKmdoYBXuGuU+xtwDXyv16Z9o9OlSxvgtsGrfyzaseBNVTF94qvqEFTit7FcsBCiZfDr5YTGQ6wR/vnZnRSJCvi8gaCHWXnEfxUwoRU5wo6d8EFeMgFz/bToEN3AgPvEJ3LgFTEEj2EuILRLWwvRtsnRjb8knhaXcb93wco0LAyAf/2Qn4vaQ8/XrShPwsmzwjKrswOPoeJhKjXE2/EpAHE758u0ZRwrr9lIjt/17A4XSTe1mm7g0/RTTz40GiyK9O8x1mzCSzJq0jTrKHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=awZ9QIJZ+YOphMmLZQFCWFOQv8c6m842DRY4oXTCE9A=;
 b=cU+28Sa427A2zqmJqNNR5zr2yqGou69GSY54nwyEcR/MfoC8nkO9j550g7Tq0Hq+LPpIeBXm7nzcz9IEU+ZsmMA73Lf4C/xqnPFmwC3HdYycLAY9g+53yz0y17iFboVxHYC8AOxKsRaOQH6l/WtKEoXklEj4j/EAwNPaFUc0v7qIkAza6IjBUOF/gUDJRCd8haSORguHjO/BK7TeoVrREQY6hkhub99I8YUMA+Lqp8Qagla3UciSdHvhna9SFbhLfssZS1eLaq4ehXxGWBb1b50ZpSbNXpqpbLbOxYz3vB9yXqFeIUCjpIL+YSEeP15UxPYKXd0wTolBodRat74wkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN2PR11MB3728.namprd11.prod.outlook.com (2603:10b6:208:f4::21)
 by DS7PR11MB7836.namprd11.prod.outlook.com (2603:10b6:8:e3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 14:41:15 +0000
Received: from MN2PR11MB3728.namprd11.prod.outlook.com
 ([fe80::4286:c28:4465:752]) by MN2PR11MB3728.namprd11.prod.outlook.com
 ([fe80::4286:c28:4465:752%3]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 14:41:14 +0000
Message-ID: <5398da4c-5286-4e1b-924c-6df91f932427@intel.com>
Date:   Tue, 17 Oct 2023 23:00:01 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] x86/mce: Set PG_hwpoison page flag to avoid the
 capture kernel panic
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>
References: <20231014051754.3759099-1-zhiquan1.li@intel.com>
 <SJ1PR11MB6083A23BB89F4EE0F44B2794FCD1A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <233e17ac-0ae5-4392-a5e4-ab811a155805@intel.com>
 <20231016091143.GCZSz+T1xFf5tCFi2w@fat_crate.local>
 <759ccb97-cf5a-4787-b699-27551d5d2865@intel.com>
 <SJ1PR11MB60834039F485FEBC8031398AFCD6A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20231017111817.GAZS5teT4rFkXVD2KA@fat_crate.local>
From:   Zhiquan Li <zhiquan1.li@intel.com>
In-Reply-To: <20231017111817.GAZS5teT4rFkXVD2KA@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:194::8) To MN2PR11MB3728.namprd11.prod.outlook.com
 (2603:10b6:208:f4::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB3728:EE_|DS7PR11MB7836:EE_
X-MS-Office365-Filtering-Correlation-Id: e247e908-f88e-4b13-6d05-08dbcf1f1d5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZM7q6XqGuqIBROEwieeXAZRfaWuLfKWDuqnotDVMC0npY6z/geuGJJ8OQMbXPcAxOSWHS2e+WIawJdWVpAWnAVLe+M9vUi+Z7S+4+0AsIU4wzPRwB/jTEt699qNRNX4j00c2dfU44/P6GEu9uMMXrmH1l9HaO3WlIhvKekQtfFWsXSLm+SvanWazf9TVui5IBTeeYq5ItKjpGp3fpoiX9TGE00xQpNu5SfnDHaryfPVOJYLXZAqIv0OVQ3Yl/4OA1JLnuVrqutKyMg5YKZZ5dckBAVOEKAK91U8khaONhMUPsx5nRvBWcIcLwq6b8wKSOG4bADFUOlP5nKvK07h/G0JRsct8hJrZZl9FPIe45T7VE0/SRT+PpQPFcrovQVeVylct0BP8VAUXprVZuA90BQ+6zS/9EicnzB+RJOX5f4prAXlCv4vbIlB+dIcrlczE6wsxfhAAOoHkrvUs55fLJayT2TFPcAL4vxwe3Uu8pkYf7NYPcU+NVRUGknqtc6OiGZI77BkIk9YIUpTRNl1WEbzynddeAMZUpCdyaet9OGQPURdVAmJdnGOuMJZhkro+sCsVB7l/XyK++7DIM7amjl1VRcob2jWkb5b6SbAxy8EzBQf5yD0JoAUnh3ThiqW8F55SiYcnOWbKRHEc2zX4uw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3728.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(376002)(136003)(39860400002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(8676002)(8936002)(83380400001)(316002)(4326008)(66946007)(66556008)(110136005)(478600001)(6506007)(6666004)(6486002)(66476007)(26005)(54906003)(53546011)(6512007)(6636002)(2616005)(2906002)(5660300002)(86362001)(31696002)(36756003)(38100700002)(82960400001)(41300700001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2c2ZG44U1JNSWYyZkxPUW5TWXVwVkJMWm9BMWd5TmwxM3Y5c3R5b0pRVUdP?=
 =?utf-8?B?a3JKMTNrY2Nma2kxZk1WWXRWazVuQkNQQ0M0UDJnSUo5M3AwclhWcFJwRkcx?=
 =?utf-8?B?R1p0UjBtTlA5cHRUOEV2bTluUmNKYzRmZkhFdFRzaXY2a0kzWGpuN2liQmt0?=
 =?utf-8?B?OWc2eDBMRUhqUjFiL01qS0FOaUd6Mk01NG1RM01BcWdWTGw1OWlYVUllN3l0?=
 =?utf-8?B?SE11eXJwYSs5WGhBRWNpOUh2V0thVXdpUzhmditYbnI0c1hER1RmZEx6aDRo?=
 =?utf-8?B?dGdTYXlxak9mcjBFQUdZbmtHSHFTd3hJK0ZrdTRvdnFoZ0xsTlFlSjZ0YmVV?=
 =?utf-8?B?UkVweWRDeHRpdkZ5S2Q0SklNUUE2WjEvVXdZOFBaSy9YN2oyRVpkbWxFWjJI?=
 =?utf-8?B?YkJYUUtSNEZvS0ZTMkdTb3o3UGlicVBmK3AxRUJVK2ZwNTF6SXJiMGgzZzRE?=
 =?utf-8?B?d3IyWjN1ZDRlQkNPTFpFbXo2V0pUWG1Fby9NWUMwNTN3bWFVUlpkY2hxMlhV?=
 =?utf-8?B?LzJoTlpYY2lwZTM3dEJDemRDdVJSYUZvUUxScnlaekJqdDMxWXRqUGt3b1Nw?=
 =?utf-8?B?MWdPS0pEaktMZkxTV2E3bTR6bEVQZUU5WUs1eXlwc1JUcmNhU0gvNzlDSmhI?=
 =?utf-8?B?WC9SUTlhT09uMmtqcFI3UkpaRlRXMHFaRkNMbmNQUzN2SVh4RkcrU1BTRmpV?=
 =?utf-8?B?U256YUNUTVNuUnpoYjJxWHgrbjE3NHpKaUJOZlY5RVlYaHcvWHZHd3p5LzRY?=
 =?utf-8?B?Nzdja2JFQzdmWEJ1NTNwOGR0SUV6dmRsVkxrL1hkdWJycVBHbHZ4V01KL0ZD?=
 =?utf-8?B?UjFlQ0hha0VjWlFyZHRLVmdHRkVHWEZxbzZVNFhaaUJmYUsyak9mdmFqSWZs?=
 =?utf-8?B?QTZ2VHBLM01pVDZBcGwzbjdZSVgwUTB0MFE2Ulo4dGFEcFIxdHNvanlWTXJk?=
 =?utf-8?B?emNNQ2R3UGtXaFl4UWdPQ3RiSnh0S2lZUUV1N0o0SmxuNWw4TTBCRVZjbEJm?=
 =?utf-8?B?MEE5cGxXeTNESHJ3bWRLQjdkME1YUXpuYzlXVmtZREVDdk1GbURUeHBTRG8w?=
 =?utf-8?B?b0JlY3pScnVWNWIvMlRReXpqbkZuMzEzRkFYaTkrYjRrRlhKUjdtSmQyWWZm?=
 =?utf-8?B?WHpHano1cmZud1oxdS96TE52Z3pnUDVPNjlCYk1QbUFmYUo2ZXpITU8vYnpp?=
 =?utf-8?B?SzgyYmNZTStnZDBTVGtJWVUwbDlGK21PM0R4NEU0eVZPcHIzUmR0c1dMMDV4?=
 =?utf-8?B?L1NzOHJRcTAyVkpEakMxZUJEa1ZWVFV2aVZMRmlFOXJKa0toZU5WZkJHQWRE?=
 =?utf-8?B?N2lQQWYrenBRSWd0LzM2TzV0Z04wN0ZXVEU0M0lFTzc4UHVZNnJlSlZSTlZy?=
 =?utf-8?B?NXpzMndVWjFQT3M5UklSdW53L2JtZ0hINzk0VHMyVHpmN0FQOW82Y0xMNWIy?=
 =?utf-8?B?cy9zdUpDOXJubHRKbzZlV21YS2MrcGMyeW5VdXpWakR4dG9aL3Qrb0ZvR2xo?=
 =?utf-8?B?ODFrMFBVdkVOeVRUMGVOV0ZmM2xSeTNob1FDM3kvU2d0dnRyMFdDZklXZkg3?=
 =?utf-8?B?VHJHdFh5UEJSdzRuaEx2RU82S2JqZW5IeHBLSHNQLzJTaDlzWWFPakw4WHI4?=
 =?utf-8?B?UW5Zekt3R21zQnVoQWs0SXhEa0d2bStSSVZmTUdPeXRWWStOQ05QTjFCTE91?=
 =?utf-8?B?Y3ZKdmFUNHFKUEdRZVducUNIY3J2Z1A2djUxaFhnbE9PWmVORzZvTDVQT2Rq?=
 =?utf-8?B?KzBZcnYrellmaW5TbHNtektDcU8wK0tFUkhzRmJsVFRYamZFU29ucWYrVkFB?=
 =?utf-8?B?empXdG5lMXFCcUZ5Y1B5YWpxeEpCTW84YVBUWC9nUEU3RHdCck1NR1BKcHVI?=
 =?utf-8?B?NnpwU2kzZkw0WFNaWjQzRWUxbnlLU3pLOG1pWXU4L0Y3K2o0OUpEVTdGRDJv?=
 =?utf-8?B?ZmxiQWpVN2IvZU94Y2NubWppTnVGNWY4UEZTenFqU3hCaldhbFN1S0dXUlpk?=
 =?utf-8?B?T0IwalNqQ2k5c0NpSHV6OExibUpBYTN5QXREcjA1dVc2UlJnZFVKclQwVkdR?=
 =?utf-8?B?L0RZdkhTRXJYQXNiaVRXMCtGMFAxQWszVVNndnUzL2JNNW81LzNiVEp0Yjgr?=
 =?utf-8?Q?oZSHEmJHhuEh1zc25RhLl0qmb?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e247e908-f88e-4b13-6d05-08dbcf1f1d5e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3728.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 14:41:14.8247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0tEu+Youy+bvklPDBY6BHLQ+Tc1J1yL0n114sJUAvjkBQX/tT9dZLWhmqNADxUFTBuGtCLVb7YPMOKRNClP98A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7836
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/17 19:18, Borislav Petkov wrote:
> ... for the simple reason that the kernel cannot allow itself to do any
> unnecessary work but panic immediately so that it can stop the
> propagation of bad data.
> 
> Now, it's a whole different story whether that's the right thing to do
> and whether the data has already propagated so that the panic is moot.
> 
> The whole point I'm trying to make is that the machine panics because
> the error severity dictates it to do so. And there's no opportunity to
> queue recovery work because it simply cannot in that case. So the commit
> message should simply state that we're marking the page as poison for
> the kexec'ed kernel's sake and not because of anything else.
> 

Wonderful!  Thanks for your detail explanation, Boris!

I think I got the point why you emphasized "can't make the kernel
survive" before.  In such scenario the consideration for recovery
doesn’t make sense at all, even thought there is opportunity it
shouldn’t do that, the only choice is panic ASAP.


>> If kexec is enabled, check for memory errors and mark the
>> page as poisoned so that the kexec'd kernel can avoid accessing
>> the page.
> Yap, yours makes sense.

Tony, your commit message made me realize how verbose my commit message
is. May I simplify the whole commit message as following for next version?

---start---
Memory errors don't happen very often, especially the severity is fatal.
 However, in large-scale scenarios, such as data centers, it might still
happen.  When there is a fatal machine check Linux calls mce_panic()
without checking to see if bad data at some memory address
was reported in the machine check banks.

If kexec is enabled, check for memory errors and mark the page as
poisoned so that the kexec'ed kernel can avoid accessing the page.
---end---

It already covers the scenario, root cause and solution, and focuses on
kernel.  No need to talk something else.

Thanks to both of you for great insights.

Best Regards,
Zhiquan

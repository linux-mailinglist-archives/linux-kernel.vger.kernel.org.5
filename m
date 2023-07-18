Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09ED757E0D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 15:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232949AbjGRNqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 09:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232930AbjGRNqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 09:46:25 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F40D1FEE
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 06:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689687952; x=1721223952;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8ZoeT+/X4QN31vJ/YQBx3PnErL1NLnTHKhlFU+8PGV4=;
  b=Q6qewy9ue2vN1cosmwLRC0zjLFeuQfQBjDMLpLKo7ItEM3k9WapBIYgy
   YtqyDghLbIC2cwbhrj+BaAc15XK2sjDIU2qneU0Ey/8KGXkcUR4UQrK9H
   qGVcNVrpDTD4c8KsLwQM1kneU1vuHjZXqxMDM5EaXak4V23gK8PFDsUU+
   gWyeuSzRmh2DmG/T6E39gAm3A70IKk59l7ArB5HYWt1zqPaTV76jY46FS
   xrvXEShSALsVsP3b+AkF+w2hqcucYmHcH0LxAj0E3Jk8XudHcNx+b44uO
   Y1y5br5tuT8P8Al0nLC0qIzTe/B28NuzkWaFiOV9FIDy8dR69WMBV59si
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="345801671"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="345801671"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 06:45:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="847707313"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="847707313"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP; 18 Jul 2023 06:45:46 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 18 Jul 2023 06:45:46 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 18 Jul 2023 06:45:45 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 18 Jul 2023 06:45:45 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 18 Jul 2023 06:45:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RfAouk1hXvzw/UJbn0AtkzLudH7YVt+xRByB2aW4bvNz2mgMGTu5mPwRPTzWh4M1kKIgnN8+NYSgW70k1+hHY64zjICnpiUnrWmljMrI20d3ZkGLvF/e/RCgbzgtCKjUbva4TV7ezzINTUYTq5mpdP9RN3TflnC1vh1wLU6QNXFLoaXfylbTUmSaiahp8nzbZ3LwySLgpGIr/CMkvdQHAKeou0cLIVEgGExqTIjSgMu1P+8vk+RXPjhPXMaOMhp/qBKsyOFbdmZIr4WwPNiG5m1ygM2SGYkf2bh5mpWm3hilI/EblkXa7lhXgQSE52hLyYEU2v7v4IXNysRMLbFeqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JjxXcI37+trlcgnb1jezPkBwcqK6zkpk7rkYtwDCiA4=;
 b=cKwDD1xn1WFfk4g05HtzORNdy/NXZqFYEbUfyotRcr3NM6m4fGlD4QeWDetisSXdCC01UkjsAyYQAwVvXWnseGgM7Mxg3VG80WGb97JOdF4xuQrUX4g9NCbfOWY8GbuwBIZDut+pFZzznuRtyIlmTONXkI57A/KohjXrXjdsRpPXru1C4TU092JaOAJ9IHxTcgRerfF05yfPIOkohJJIvbVK7bMx5F1kj9RX5WcEi2K3bxH3y9lAf04r2+He4h2HQlKufeIdv48WMy6gKAsoyLzYz15kDKr1VGfK2Atz+JRd8Txs0YsiJvTjQGIW5SDy2jXoU0/bYkzes3IUBaAa8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by PH8PR11MB6976.namprd11.prod.outlook.com (2603:10b6:510:223::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 18 Jul
 2023 13:45:42 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a%7]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 13:45:42 +0000
Message-ID: <0bd7caa5-8f04-8787-1e72-93ecb71b8197@intel.com>
Date:   Tue, 18 Jul 2023 15:44:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] lib/bitmap: workaround const_eval test build failure
Content-Language: en-US
To:     Yury Norov <yury.norov@gmail.com>
CC:     Nick Desaulniers <ndesaulniers@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, <oe-kbuild-all@lists.linux.dev>,
        kernel test robot <lkp@intel.com>, <llvm@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
References: <20230717220435.57640-1-yury.norov@gmail.com>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20230717220435.57640-1-yury.norov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0182.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8d::15) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|PH8PR11MB6976:EE_
X-MS-Office365-Filtering-Correlation-Id: acc4cae0-6387-4fc4-e14d-08db87954789
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O6dbzUJh/sLVEkmOV6crNlGMwFoX+GJLo3rCbOk9D3su5UtyWL5rCyCL0lUBnon/OGjr60hE5spIsGw8VSOrigFfssZjcDkP3G+1koQXUhrZCzlBj711PpbkDEIWm7SMyDR/NcGrZBlNDZQ1GpGeOrqjhdmPvbOiTxOIKDaEJueYbU3amZhx7FOc/nLoRaRcs+4/ORADKtYJstj7D2MX31VCZTGfeCJX6gMy/c/VhJk6cYu92CJKMkxZ8G1lHLRoYLq0aAYMF/f97Us75ZpSlImX7InJvU6aYxLxGzK2kzqqB0eXh9nHuciohWV6jbjDLQ8rZbV0gfkRvuLwYU7Yge7njtx+Fq9c1h6ZFsF0XW6hNHV88QzdeK5KBCSSjtqIBQ3737Hai5RRbtWSr0t+FoH1uWc36N8V6IM6WkY6yB5x24Pk08qDhotdp4qFPBdLWNVGVxYavT4OavcORCXcCjtsgcCQFeS3qB5HE+UefUkoJlJ8vbInkoQhacvohg/2De3+qyHa86S2JCQsW6mdJfFXI7mJLp6/VtfqfqR1sQawzJXdCyHH5QoDXjreuOhn7P1q+gM0az8BE5fwzcT7DUBuT6viPannXNfhw+1iDyw4bBJ3EK12XRbG4s84GQN8mIdoE9933+xHHP3ZTQ1SPjvIzgkNCA0K9Vlt7Le4HmfpDd7RuvrRRMOXNmvKrtkH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(346002)(39860400002)(366004)(376002)(451199021)(966005)(41300700001)(316002)(83380400001)(186003)(31686004)(6512007)(2616005)(26005)(6506007)(6486002)(478600001)(82960400001)(54906003)(6666004)(66946007)(6916009)(4326008)(38100700002)(66556008)(66476007)(7416002)(86362001)(31696002)(5660300002)(8676002)(36756003)(8936002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eG9GSUJ3VWNBR2F4NllnWFpwSFpLUWR2c3hJNkY5U1RaT3pMc3hwZ3hjRlJ4?=
 =?utf-8?B?alhWd29sR2toaTk1aHZzNlJsK0VEZS95QjU5aGtnS1VORTJSS2JZSGpYVVFR?=
 =?utf-8?B?dEVRbjdVYjg0Z3hENXB2OTNBUVprUHY5SmtURDQvQjZLNHNFblNQZTNtdHpm?=
 =?utf-8?B?Qk5kTXZyazk3RmcwNjE5U2NlaitTNGNjaWNodWxCcDBUL29LMHJsWVpkMnJV?=
 =?utf-8?B?em44cU1YclBxZTVhNXBJbXlqbTlKTE9VTVZlNEdmUVJhVkpQa1ZwWUxrVzZ3?=
 =?utf-8?B?S0dzdGd6L3RXTkVrbDVCQ3FhZG56ajlwaEpPQWtaZ0hpVlBjY3BMTFlaTGFq?=
 =?utf-8?B?dEVvalZYSzZFRFdGVmNNNmVCbVA2UXlWV08vWDVlMWhheVBUQkdYVU9tclVn?=
 =?utf-8?B?cnlhOEV0RlRLNG1lV1ArbHdNL1B5bkREZXRWSlRnQ0xaR2oyZEJFOTRIZU1K?=
 =?utf-8?B?S2JiY2E2WGUvVHF1K0RUc2NzcXZ5SE5paksvMjlpRmRtWkZxMk00TFZwZFBj?=
 =?utf-8?B?YWFlNE5IanBLY0N3Qnp1cmhlcHl3MWRLZkJNTUlRdTMvdzdiVWtRLytEWFNZ?=
 =?utf-8?B?bm45Z0lFY1N4ejROZUhCQmUwV0NBRUlqUG03SnltWXI4Qk51SWFwelp2c3Rn?=
 =?utf-8?B?RkhucU9SRlZKQmd1ZHczUE9NRmp2ZkhHcmxXamJiWU9nNC9JQVNPUzZiSDNJ?=
 =?utf-8?B?QTduaXcyYklWYlZhN1VyK09kcGdwVFpWalJ5SFRYMlFrZlhiOUJSN09YQjlR?=
 =?utf-8?B?ZEZtQ2w3eEdONGw1T1R1L21QeGgxS0ZLOWpnM0FlM3VSNXlUclZtMnhid3Vy?=
 =?utf-8?B?WU05TTZYdXFTcDNrNWF0Tkp0dG0wOEhZaldXeGZBTC9EcVMvYjVZcktqWlhK?=
 =?utf-8?B?MHRBUExwa0tmVHhMdkptSU9VQW9XQ2tPMndRQ2ZDcWh1UTVscjBnTkdqZG9m?=
 =?utf-8?B?Y2RYc01lUUp5ZU1RYStVdUovVnh0KzlmQTNxbFhpbFFZNzFCWFlqMUVBN0Nw?=
 =?utf-8?B?VGJSWXltTlhuTittZW1OMkw2VnVmaG90Mnc4UU1ITjFpWHFsWVJhdGI0Q3Zl?=
 =?utf-8?B?L1lnaGRXNTVJZlFveG5rNWJaQmNOUFFpMDVFenVkS2pVUFdWZWFXNk5wN0Fk?=
 =?utf-8?B?Tis4eGJZSHV1Y1ZRSytOUFFKTnFaSEtTTTNTenFGVjREWUxWelFZb0U5dGoz?=
 =?utf-8?B?a3NZRzRwcjdEdERnUkxzZnNpUkkwa3JUbGVwaHR6dXZjd3VqR3hlc2drV0dN?=
 =?utf-8?B?Vy9MUUtVT0wxTS9UMW1FMG54NWxKaDZCUnNiZ0pCMTU3MEpocHdrZVpFTHRD?=
 =?utf-8?B?eWI2bUpBVzlXaXlZcGJPRWxyUVEvWklrcDdaclV6TFcrZDVPWTlLMWdta1VP?=
 =?utf-8?B?cXY0SkhKZ0o2WFRsRFo1STYwQjFNa2E5TFlLTEl3R0llS0FwcCtzQ1Avd1Nv?=
 =?utf-8?B?ZUowa0RFZ0psK3ExNWpNejkxOEMxa2dHaGZhekpNVHMwWDcvbEI1S0IzRlow?=
 =?utf-8?B?TEZ2RWp5SE9UY083aU5WaHY5UVNLRzFkWFdQN3RNMmswaWhtSXQyd3hPZkp3?=
 =?utf-8?B?eThhQ0VZK051TUp1cHE1aGpWeUE3dG1pM01QQ2RuR0lkYi9KZkYxTHNqWVFF?=
 =?utf-8?B?OUhpR0NFNTBLRzF6NVk2bzRUdy80K0duRW1wUWZmR1A4V1FTcEJaZXVoalNO?=
 =?utf-8?B?RHhBd3ozay95YjRvQTFaVDEzV1hFOWJSd1JyYkFJeE1CYmVTUkl6T3o3U1BV?=
 =?utf-8?B?NDU1NGc0TlNSWmRnTzgrNDFVVjZGa0NkSVFUSW1FY2tvd0lqSGtTNEVHMEFs?=
 =?utf-8?B?T09yTVVrKzU2Z284ZzdBS2xHcmVzVXNqWUNzdVA1eXVoUXcyV24xWExGNXBQ?=
 =?utf-8?B?Q2lSY3hhTUYzK2xkaVp0djg2UzdTbUw5S3V2TlYyQm1lSW1pVWtiMkY3bHNS?=
 =?utf-8?B?dDRsb0xRR1R6MlVnVEV4MWxNMm50a3FQbkhUSXp6UjB4dzNCQjZnc2ZMNzJW?=
 =?utf-8?B?aFcrcHppbDlBNzloSUNBWkZzR09XNk1CYzZUci9yUE1zejFUaXR1aXoxVnZO?=
 =?utf-8?B?d0VrZDhxY0VsbXdpS2FHVkRWdHR0ZTZvK2xFWFNqTGQwR00xQXhmeXNyZ29E?=
 =?utf-8?B?aVFBZUY3cnZzTUF0amd3V0lPcWhXbWNxQjhRaWtteDFkelpYTXVoU2NjN01x?=
 =?utf-8?B?c1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: acc4cae0-6387-4fc4-e14d-08db87954789
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 13:45:42.5547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XCYkiA83T3rpukOF0LWcUGHg1zRwv92y5KVaSjumE/AHjBnAPU9CL/KygVT+ywryOU539tItYgjnA2nm5P2oVE3Buhky7Gu3Qt/unqTnWJQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6976
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yury Norov <yury.norov@gmail.com>
Date: Mon, 17 Jul 2023 15:04:35 -0700

> When building with Clang, and when KASAN and GCOV_PROFILE_ALL are both
> enabled, the test fails to build [1]:
> 
>>> lib/test_bitmap.c:920:2: error: call to '__compiletime_assert_239' declared with 'error' attribute: BUILD_BUG_ON failed: !__builtin_constant_p(res)
>            BUILD_BUG_ON(!__builtin_constant_p(res));
>            ^
>    include/linux/build_bug.h:50:2: note: expanded from macro 'BUILD_BUG_ON'
>            BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
>            ^
>    include/linux/build_bug.h:39:37: note: expanded from macro 'BUILD_BUG_ON_MSG'
>    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>                                        ^
>    include/linux/compiler_types.h:352:2: note: expanded from macro 'compiletime_assert'
>            _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>            ^
>    include/linux/compiler_types.h:340:2: note: expanded from macro '_compiletime_assert'
>            __compiletime_assert(condition, msg, prefix, suffix)
>            ^
>    include/linux/compiler_types.h:333:4: note: expanded from macro '__compiletime_assert'
>                            prefix ## suffix();                             \
>                            ^
>    <scratch space>:185:1: note: expanded from here
>    __compiletime_assert_239
> 
> Originally it was attributed to s390, which now looks seemingly wrong. The
> issue is not related to bitmap code itself, but it breaks build for a given
> configuration.
> 
> Disabling the const_eval test under that config may potentially hide other
> bugs. Instead, workaround it by disabling GCOV for the test_bitmap unless
> the compiler will get fixed.
> 
> [1] https://github.com/ClangBuiltLinux/linux/issues/1874
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202307171254.yFcH97ej-lkp@intel.com/
> Fixes: dc34d5036692 ("lib: test_bitmap: add compile-time optimization/evaluations assertions")
> Co-developed-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  lib/Makefile      | 6 ++++++
>  lib/test_bitmap.c | 8 ++++----
>  2 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/Makefile b/lib/Makefile
> index 42d307ade225..1ffae65bb7ee 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -82,7 +82,13 @@ obj-$(CONFIG_TEST_STATIC_KEYS) += test_static_key_base.o
>  obj-$(CONFIG_TEST_DYNAMIC_DEBUG) += test_dynamic_debug.o
>  obj-$(CONFIG_TEST_PRINTF) += test_printf.o
>  obj-$(CONFIG_TEST_SCANF) += test_scanf.o
> +
>  obj-$(CONFIG_TEST_BITMAP) += test_bitmap.o
> +ifeq ($(CONFIG_CC_IS_CLANG)$(CONFIG_KASAN),yy)
> +# FIXME: Clang breaks test_bitmap_const_eval when KASAN and GCOV are enabled
> +GCOV_PROFILE_test_bitmap.o := n
> +endif

Oh, quite elegant!

> +
>  obj-$(CONFIG_TEST_UUID) += test_uuid.o
>  obj-$(CONFIG_TEST_XARRAY) += test_xarray.o
>  obj-$(CONFIG_TEST_MAPLE_TREE) += test_maple_tree.o
> diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
> index 187f5b2db4cf..4a678de9c350 100644
> --- a/lib/test_bitmap.c
> +++ b/lib/test_bitmap.c
> @@ -1161,6 +1161,10 @@ static void __init test_bitmap_print_buf(void)
>  	}
>  }
>  
> +/*
> + * FIXME: Clang breaks compile-time evaluations when KASAN and GCOV are enabled.
> + * To workaround it, GCOV is force-disabled in Makefile for this configuration.
> + */
>  static void __init test_bitmap_const_eval(void)
>  {
>  	DECLARE_BITMAP(bitmap, BITS_PER_LONG);
> @@ -1186,11 +1190,7 @@ static void __init test_bitmap_const_eval(void)
>  	 * the compiler is fixed.
>  	 */
>  	bitmap_clear(bitmap, 0, BITS_PER_LONG);
> -#if defined(__s390__) && defined(__clang__)
> -	if (!const_test_bit(7, bitmap))
> -#else
>  	if (!test_bit(7, bitmap))
> -#endif

...and even allows to remove that ugly piece.

>  		bitmap_set(bitmap, 5, 2);
>  
>  	/* Equals to `unsigned long bitopvar = BIT(20)` */

I like this version the most.

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Thanks,
Olek

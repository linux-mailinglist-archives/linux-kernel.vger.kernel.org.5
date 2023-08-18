Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 455117814EF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 23:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241301AbjHRV5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 17:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241279AbjHRV4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 17:56:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F18C3C31
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 14:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692395800; x=1723931800;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Y3hGEUt+2ztpz3LL0HyVYMAWS0iOzjerK5NfeWa1ftU=;
  b=Hoo5kZPbpJtOxx91s/ugLjsuI9hUzWdg83EFJhg5T974iQGXHcTXhQEs
   gP8UdMtuFqmgNfX0FTeO/3CT4n2bvigpjCdK081Z0FdBYJutB+BxPSs4b
   V0gC83H+ExwTu/5t7WxpCVmDV7DNq6ra7hlXuV9y1DuKfM7npsKESGrOS
   9o2z5IXiXIwXu/K1sBm2NpAUJE5QGr8cnc6cU6nuD2B6TkFQZKwSFBLaA
   Sq9K9cWrw+HUM1/M0yxYiVRdHSTueH5DtsFhbCUIkyvXLh5seqaqwEQpR
   IO8VoQRNQioDYZBOdPN63kegbITn3IG4GO2SMTLHFiUmZfcOXjc3wrTZQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="459572714"
X-IronPort-AV: E=Sophos;i="6.01,184,1684825200"; 
   d="scan'208";a="459572714"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 14:56:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="685021653"
X-IronPort-AV: E=Sophos;i="6.01,184,1684825200"; 
   d="scan'208";a="685021653"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 18 Aug 2023 14:56:39 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 18 Aug 2023 14:56:38 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 18 Aug 2023 14:56:38 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 18 Aug 2023 14:56:38 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 18 Aug 2023 14:56:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nubP7HSQPtjaVAZwLW9OYsIk+Um7/qXBpIKri/AlJeuiv+pFQ2yV8QKOUklakddpnv/IbzfNWjuyhrapbiVRHe5/Wtc7qLql5/lwQ7p7Gi8cej/6Y1j6Cn7xWMGKP/RHp2I6ZOXv9uWz3IvrHGpfNCqx9Vq4G9eytXMPN0uuyPx5VLvzMnTj5O+YVgTusgM7eJGvNyRKNb8rGGcNZLy+8L+mN9GrPUkjin9zq+IhbDoZRiUuYnOOIpk2ZwwpyCxhaw1axHpgegkiYekMzzkB857CoY7VBIRHXF6k7t8wLSZXCa9mwSyuQPijXE+8J0husvM/vZ9uTsp5z/bOisLxQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ovIuNDAxzb0qfX5zZdS7j9uyqNnaCuBN00uMEgZyNW8=;
 b=PrwEEqD2bsPgS6QSnfKhKMZtI3lKtKzf5rVgnl8rfzoh7PdT4ALZc78+Xbrfv4yR6X1xuwBhagxiZIG9LLcU7RBJzWdvB8zX6APvcQKfNU3+vzBPTCIFwu/uoFV5M8KubYb7Ft5nuQEgtOCVTZ5dlTkHSHplBuR0qoWbcoxNCABZdikjdnCYa/cyrxwIJmJ9qJsrFMiRfECjyXz5BvqMO5bQm7j2aaTufAZkQ0lhwcwAzCgTZ/hyK7NhK2PASjxWFXVkoEH+bJsPQHVFQT8OdDHJHsAYyoCDwK1+Vjgq6NYNKvTErqfPJRYlyzjmvYXknhDYCDcztU66K+Wy5DSA/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by DM4PR11MB6358.namprd11.prod.outlook.com (2603:10b6:8:b7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 21:56:34 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::ad4c:86ce:d99e:9740]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::ad4c:86ce:d99e:9740%3]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 21:56:34 +0000
Message-ID: <96d2a7b5-bb7a-01e7-fab0-d4874818dc64@intel.com>
Date:   Fri, 18 Aug 2023 14:56:32 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] x86: Use __fpu_invalidate_fpregs_state() in exec
Content-Language: en-US
To:     Lijun Pan <lijun.pan@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <x86@kernel.org>, <hpa@zytor.com>, <dave.hansen@linux.intel.com>,
        <luto@kernel.org>, <peterz@infradead.org>
CC:     <linux-kernel@vger.kernel.org>
References: <20230818170305.502891-1-rick.p.edgecombe@intel.com>
 <9e9c629f-eab0-6643-4e47-0a4b39e2a3f8@intel.com>
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <9e9c629f-eab0-6643-4e47-0a4b39e2a3f8@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0070.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::15) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|DM4PR11MB6358:EE_
X-MS-Office365-Filtering-Correlation-Id: de857763-b15b-4b50-b790-08dba035fce3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q6guDGLf3hJyVtw+zr4RqlNhCuyhkTtAWyGL4Gtyttwv8pvf4mPah/gOSNxrST7dP3PzTMbWUc0E9UuenCcZY2uW5vO+VzVAp8+cPIOUr2xnW0c9+ZjHPILOjTqZY2tnyN+MRptuAYysgF1ZABU2Vracw1gHdL/L0Y2clgL2yT9wJnwqEzLUVpset8yfN8jw+s8YzOp3bKWL3za95+ccdzmm6InFRTGSijLLPuaHQwYh5DjXB2LO4N4zjvgpe/hmabpGVvZTWEreF5nKXwAC15G0Zy7ga3Asmkx4E+XsYKAXLxqfO7l71IMD78pYezH3cwFXrrk+EU26z5+4XctejbpMDw02jDJjQyVIpCrt+5MwPBV06DV1XM74L3V4wQXLsUk5nZZZFhSyoT3zrf52A20EP7gSps1sb/IzaSgm2qZeJQ2gT38epivUOdsQGdrUSyK0Ks2nlX29pJubOWcKwzkhkugXkQuLEzRnrtMhHyC17Pr3qEFJdlERrV0HfKhZu+r6xVxUp/3i5WQcIjFjItd9QqYjLXU1sYX+PwcbFzeBE4astxDtfp7bgtcP39LA9fvc1VPSPCkj628iTTAnKvMoErbZbxVoX0D2icGxuDrgCTcS8ZRNMyry5nleCp+dG13OZ00Oh08oNDu+8FSMGWVd+TmEvF1QNJX9p34wynY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(376002)(39860400002)(366004)(1800799009)(186009)(451199024)(6486002)(6506007)(38100700002)(6512007)(53546011)(82960400001)(31696002)(26005)(83380400001)(36756003)(921005)(2616005)(66556008)(2906002)(316002)(66476007)(66946007)(41300700001)(86362001)(110136005)(5660300002)(44832011)(8676002)(8936002)(4326008)(478600001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEZoSkdMUGNXSE80YU03UEpvcFlrMTY5QVNnaFh6K2RwUGNMUW4yck52Q1Uz?=
 =?utf-8?B?MXRwRmR2MTZwbnR0QlBCQm13TENBN2FocnFubVdKem1STmh6aTVFRnZvdXdV?=
 =?utf-8?B?THZzYnA4MGRrZTNUc052ZUtKaVd6WG1vME9lSnZYVzQ5TllJR3BjUUdUQkZq?=
 =?utf-8?B?YjZ5cWpTZEpzMi9NNDczNWpaUlIrc0hINW9uYjJDSGlpV1BocFNBY2lWMFVP?=
 =?utf-8?B?NGlqZ0pTcGZKejZMUXlvTE1nU1NtTUVwQ281azVNdHA2bnJjc2loRzV4MHh4?=
 =?utf-8?B?bG4vMlFBUWUvUGFqNHdwNVB6OWQveXB2YWVZY2xHQlJkTzFBSDNhNTFzSXpY?=
 =?utf-8?B?YkMvaGF6dEROUW1ENHAxT3ZqSkF0V0J1NEx2cXl2akpNaDlpWStKVVJUcHhs?=
 =?utf-8?B?eHl6QWJEd2VqbFhubXVkTExTQ1ZYcVcycTJUV0hWU0FVME50QnROT3VnUFhB?=
 =?utf-8?B?VzJEVEVPK1RTTzQvTlBLT3ViOVJ2RDJsTDJaUmpSVGZtYWtydmxseDdmTGFi?=
 =?utf-8?B?T1ExSWxCVFdScmd4ZGg4aHliVHVJMVgvMkJLYVd5Sm9BVnhUbGFJaENoeFBF?=
 =?utf-8?B?WWxEZXFsa1FwQUpKU3hHVjdRbituLzVLTC8wTVQ1TmpGUEJxMjNYaGxSOWFs?=
 =?utf-8?B?a2NsVjVmLzI0QlhSUXdHRld2aFNEcFNJbTA5U0t3Y2NwOEsxcmJMTURLQ2Jo?=
 =?utf-8?B?VEkwK1l4L0UzY1ZYRlJKcFdGRzQ0NnUzSENwOWc3RWJOK0ZXWkZNeFBUNW5z?=
 =?utf-8?B?MFVQUzVGUHJFSVhPdE5RTzRrbFRUT3hKc2wvTUY3bFYyR3RIVS9URDdVRGRK?=
 =?utf-8?B?aTZBOUJLQTBqY3JQRkxNZjk3VUR5emREYm56WFVCYTF1ZUFyZ1oxemJDRDF1?=
 =?utf-8?B?NTczdUc4Vjh3WkFrR2hycEUxQUNaRVUrSS9PZldrT2M2VHlXS0tLOVZhbHVP?=
 =?utf-8?B?UkQrd2hVSzlZbVpEQkljdWVzSHdWbXVrajdGSEtIUGNOUzBndEF5ZHUxVGtB?=
 =?utf-8?B?cDZWS2xPenhXK21sV0VJUkdud1p4SzkyaUJZRDF4enkzQkV0alArUlZQT0VV?=
 =?utf-8?B?aWE5bmt3bk8vbEs3bGhNQ3JSRkJKdjRSeGM4K05uSW1iVG03dkVWbVM4ZzN3?=
 =?utf-8?B?cXMwOVcrbDNCc29QdjhPSzlweEtpNElmb2RMcnZhNXc3WjFqUVhTMit4TUF5?=
 =?utf-8?B?UjNPZ0xQYm9hQ3ZrMjh6NkFXQ1RHbEo0QkU0ZlBESjJSNTE0enA3L0FrNE9C?=
 =?utf-8?B?cisxeWdvUzQ5VXB6YzA5MldvM0RCMUZMaHR0YjlLdUoxSHhJcXpTWFZUeFh5?=
 =?utf-8?B?VUNPcUNHcUZNdHZjOWk4bXlDcEhCY0NWY3lmQmN2N2ljOHJONzBtNjIyd3l6?=
 =?utf-8?B?YWtRSEdqUVM3TkMxeU1UY3pNV0M1ZXVGVUVURk13MDByVFBqQi9iU2FxZkNS?=
 =?utf-8?B?UjVNWlN5YVFhSFI5ZDlkbUxWdmJMd2t4d1p3eldoK3dnNWdwMDhZYUI3dW11?=
 =?utf-8?B?RVo1djIrMUMvWWdmMGJJRklPeGIzbW1jZFo5SitoUGFNdzdkQlgrdk9ZMHMv?=
 =?utf-8?B?NTErNm5HZXFsbTQzaXk0bWxTOGJZSDBLV2VCRUtpQy82bVNoYy9CMlEvYTIw?=
 =?utf-8?B?aVVOY3pPcTBDdDlURVhlZ0dNUVhtK0FnWUxvQ1YzcDFwdHVScTQ2OXErZmEr?=
 =?utf-8?B?elpreXdMUVhHTWNNNkcwWEhLYytnL0oyTHY1c2hZWDJ6ejRERVc2dGdNMTln?=
 =?utf-8?B?ZnRLeEhzZlVGeW4wUUNHY05PRlhKOEFZTExTOGVNRHZFNnRzcEU0S3YyYWd5?=
 =?utf-8?B?RThIb3ZmSmpBSkNGamNkY2tXOEhlbXdUS1VPUUUzUjdtMk83N2ZtWmR4ekdF?=
 =?utf-8?B?MlU2QXdDN0hINXNjb3ErdEI4Wm1kS0JWUk5rOEtuSHh1M0xTa0Fza0VCUllT?=
 =?utf-8?B?amN3Tm9YREVFR2ZoT1ZRNXNqUGY3UW1udjJLUWNaK2hiMlB0U1ZiL0hRWmcy?=
 =?utf-8?B?K3VSQWNKbFNoUnBPNHZGK284ZGdSbGpuSkl5NjUxdXZzNGQwbzBIREFWMjU1?=
 =?utf-8?B?N1hnSHN4S0NoZVBqdTFzUnZpM01QazUxVXp4R0JyajhBVVAzMUZsMTRCR0VR?=
 =?utf-8?Q?VzeleMJschJdrz/HWHtCo+5DF?=
X-MS-Exchange-CrossTenant-Network-Message-Id: de857763-b15b-4b50-b790-08dba035fce3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 21:56:34.0502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 28T9eqWYfReiPgiGgfROKN17AnB97TIQY2z3dQPX6iDd11NOhW66lg6aeNz6J7L3M4powmYb4ea+KBhjXJ7YPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6358
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/18/2023 12:35 PM, Lijun Pan wrote:

> So, I am thinking if it is more rigorous to have both 
> (__cpu_invalidate_fpregs_state, __fpu_invalidate_fpregs_state) 
> invalidated, similarly as fpregs_state_valid checks both conditions.
> 
> code changes like below:
> diff --git a/arch/x86/kernel/fpu/context.h b/arch/x86/kernel/fpu/context.h
> index 958accf2ccf0..fd3304bed0a2 100644
> --- a/arch/x86/kernel/fpu/context.h
> +++ b/arch/x86/kernel/fpu/context.h
> @@ -19,8 +19,8 @@
>    * FPU state for a task MUST let the rest of the kernel know that the
>    * FPU registers are no longer valid for this task.
>    *
> - * Either one of these invalidation functions is enough. Invalidate
> - * a resource you control: CPU if using the CPU for something else
> + * To be more rigorous and to prevent from future corner case, Invalidate
> + * both resources you control: CPU if using the CPU for something else
>    * (with preemption disabled), FPU for the current task, or a task that
>    * is prevented from running by the current task.
>    */

This is a general comment in the header to guide multiple scenarios. I
am not sure if invalidating both would be feasible in all scenarios. For
example, in cases such as the fpu_idle_fpregs() there is no task fpu
available.

I think the current issue stems from the fact that the code in exec()
doesn't really control the CPU. It is mostly running with preemption
enabled which can cause the CPUs to change as described in Rick's
scenario. Thus clearing CPU1's FPU pointer in step 4 seems unnecessary.

An extra invalidation probably won't impact performance for such a rare
scenario. However, replacing it with __fpu_invalidate_fpregs_state() to
invalidate the task's fpu state looks correct to me.

Maybe, we can expand the comment above to specify exactly when a
particular invalidation is expected vs when both are expected.

> diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
> index 97a899bf98b9..08b9cef0e076 100644
> --- a/arch/x86/kernel/fpu/core.c
> +++ b/arch/x86/kernel/fpu/core.c
> @@ -725,6 +725,7 @@ static void fpu_reset_fpregs(void)
> 
>          fpregs_lock();
>          fpu__drop(fpu);
> +       __fpu_invalidate_fpregs_state(fpu);
>          /*
>           * This does not change the actual hardware registers. It just
>           * resets the memory image and sets TIF_NEED_FPU_LOAD so a
> 
> Thanks,
> Lijun
> 


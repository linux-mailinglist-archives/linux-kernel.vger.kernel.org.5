Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1FEA784B29
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 22:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjHVULG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 16:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjHVULF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 16:11:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4F6CE6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 13:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692735064; x=1724271064;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6abiqpS/nm8t5nYN/zqt99YH16ON8OXruwgiBm/baqY=;
  b=SwWSb6pXg7oWYeOaoulw5TCS1Uqs2cFzM0Aw/ihHvZQ0iJR/gKGIV/tA
   uR4iHUvCMneHSvwaqVd00QU51Se5lVzg4SfV0rlajZ7klFyjSe/MW3GOa
   M5UeplnxNl9vtpNN1cNCe0YCwEepKjupY8FemXQ+39ECblf6/0sXstpjT
   7sXVhsHirJX5dZCWrrARB/s4SUOcB/GnnH59adZ9o3gy44Xad/bOx3RY4
   VaUdznXFmA2vkuNm0KUhqGhftpP7hLKqavb200M360NdhM4fVxFKy7M6m
   syTGGKuObL3q18W2T0+iLZRLRxlLcbBK8mnyufG/CDCGNNnN4KC20a/Qg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="440350751"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="440350751"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 13:11:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="765881975"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="765881975"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 22 Aug 2023 13:11:03 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 22 Aug 2023 13:11:02 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 22 Aug 2023 13:11:02 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 22 Aug 2023 13:11:02 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 22 Aug 2023 13:11:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j3d3tBcB6pRcNOEH/Zkeht4+Z5BEOeeyAFgZp/eJyv75qATYzbwZEAmKeLmpJ13nn8EQkkHIF5gGm0wWnA2NgfQpAccW4XzmoE6cI3nEn2cBxQzL54+Wh4c68bsEpab3NJlc9yEurd3TO2OPCbWP5GR6APp7uvuUw7tA1JI8AVyoUCyamB1YcDRmvjOF9FtTR3JZpq/wX6Y2zZDkeZV+bcVOOT82jIcq4kHEBunmmmaSDT/BAjRPNDDZn40eUJZjUoMcm23pmO2OFzwkJk2MZjA9Rsul4RzCrwUFCIZ8eCEa1HaoDwmBbDJ5FBB6KyU+jzu9fWtMjfhb3tQQIl3Rxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E6ZJB/zC/Kk0Q4pMWHNRj9SSeawYAfqVvHuDrYIXGfY=;
 b=SFgmOPijUlZbXtYEza/wS4aLCOvvXKy9MwGpODBjw3Pex+pruXDZg45wGUcw+VGiwW1TYznjB45iSfzsxeUns6bd+J5xaw6e3HzkKnC3fRu0+nJw2qQjZJYskwCVZQ36eB+CNA05Gd9yM98S4+HFY2OkRMReQJdoNCYAPHnx/KgQ6zrRAFXCn8HItl/7H/Ry0QNDDzXLdJHrxrfxGBjUUwnzNOm7frYtZPBy5nh1hNAuZd4K+vDLN7XOazjZtc/V7ojFqTPAKB/iSudKS+k2i0K9T+MrF05UKLOi1D1q9cGxcE9nJ0wXXp59HxV4NfeoWQUqy2pAIQYdQNpeVLPxDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by SJ1PR11MB6252.namprd11.prod.outlook.com (2603:10b6:a03:457::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Tue, 22 Aug
 2023 20:10:59 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::ad4c:86ce:d99e:9740]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::ad4c:86ce:d99e:9740%3]) with mapi id 15.20.6699.022; Tue, 22 Aug 2023
 20:10:59 +0000
Message-ID: <2398119e-a03e-4bf9-12e7-722fb23f8c72@intel.com>
Date:   Tue, 22 Aug 2023 13:10:57 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] x86: Use __fpu_invalidate_fpregs_state() in exec
Content-Language: en-US
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>, <x86@kernel.org>,
        <hpa@zytor.com>, <dave.hansen@linux.intel.com>, <luto@kernel.org>,
        <peterz@infradead.org>
CC:     <linux-kernel@vger.kernel.org>
References: <20230818170305.502891-1-rick.p.edgecombe@intel.com>
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20230818170305.502891-1-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::10) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|SJ1PR11MB6252:EE_
X-MS-Office365-Filtering-Correlation-Id: 110e5e0f-d15e-49ff-d91d-08dba34be6ef
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qy1dWzV99FB0L2M+nm9FwcjSg+v6e8sTvgPZvrmjBzFvy34FDN1PGtLbFLBk12oaDKn0vxVDVkpFaI4hDTkzma4jYPUyQueC4jPw/hsnuEbo3z/D74ws9+IvExMu/qH86t2BDHH3kQl4U2uMoefP3Wy2Ado3Hd8O9okQLUYklgQBATfQ1s9WetdD8tOAXDmK+Jc20Gz5iyJQMTE4KHsFgPH8KQRVny35zInMEtIE2pD2Kp1m+NF5ydCBUPMXyz3mSp5Z6vHN60nhRW8Gc3upCnFni33TDdK0nl3oxIdcAFhfOkVlov//zfNyfTk8nNvejUK1rnPDlfpoaJngrI/waMy8gNLSx80B+WlKtoK0i4MjutLHCWeIwNlbSFLb+cQH4VWook+YCXQCGPquQzy+cGk3gPQ7YAA1UICMGx3LeWzev1tdDoi23N4RkmuzZkVqJ2A6vmgPcwGKm+Ebya3KrcOKyKm8ezh9GByhKzVxY76kkI/8dbOJmR6sbftge7x/L1J9PB5Rh9/Uah/zC0iFgmqzlCP/bj+guJ/cxjSlxu0R9/H8CE0yEqWoOX77hc15GN8D7pXQ+uAuYFFO0IFd6CMrXg8glzxEBZ1CRoj3pjDnQFpVn0Igigc/g1a173xN3RkR9FkiUoH/owis920jiQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(366004)(136003)(346002)(451199024)(186009)(1800799009)(86362001)(41300700001)(5660300002)(44832011)(66556008)(2616005)(66476007)(66946007)(2906002)(316002)(31686004)(8676002)(478600001)(4326008)(8936002)(82960400001)(31696002)(6486002)(53546011)(6506007)(38100700002)(6512007)(26005)(36756003)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGkwNS9EY1VKZlhiOTIvSHRwd00zNjFZRXhNVjg4VCtlZkN1ZFcyNEEwM0pm?=
 =?utf-8?B?L3JjZjY1aU1KNVZ4VUN4ejUvSXJvb01pV012bUdTYVFkS3IrQjl4MGRZUFBj?=
 =?utf-8?B?RnpMblhzdTFhYXlZbDc5dGU0RjNhcU96T082SitMZ1V3UnhUNmhvSjVQenVT?=
 =?utf-8?B?VE03a3V5YnpwRlh5Smx1dVdrN2c0eHAyenJaLzFFelY5SVBuS1pPYTV2a0p6?=
 =?utf-8?B?TUFYTFB4dGExV3A4dHFiYXRMYjRLYTdCSWhsY0U5bEFCT2R1bXpGME9QWTVP?=
 =?utf-8?B?VHBhY1pVVUlrZXhzWk55amEzUmdEQXNYOVZLZWcrMW5rNHc4UERGNFpVNS9k?=
 =?utf-8?B?TklNZ3NFalNFV0VxRDlyQW1aUXoxNTgwb2FrZjdncDh6T0R2MWZVa2dkOGds?=
 =?utf-8?B?WGZNeUJXekRBWU91eVNyMitIUi9jZXpLZDEyQzFJNDNMUE93aUJNNjI5b25n?=
 =?utf-8?B?dGdaQ0RWb2Q4MTgyUmVVQ01aYnVZT09scEFXWWE2dFN6OU1uMktWbUtydHZJ?=
 =?utf-8?B?VWlrWXJJRy9aZEovVzVjMnF5WkJ2L0dadjkyVUtOWXBnUFZNWUV4eWc5TUd0?=
 =?utf-8?B?ZGYwVVhpM3hEVTkvQU1PUlBpOFVpMEY2cWFUUStnaVoxZGNla0wvRXdTQjZI?=
 =?utf-8?B?MVQzRkhDT1ZIL1g4Nnp6TUYwMWtiNVFKUEJzQTdSbW80Y3gyVXJuenppRTFU?=
 =?utf-8?B?bG5yb0R0dEZ3eWdNdFF3VjRudTJ1OUN0VDRsNnNUNk5BNkhaa2NFaVRCNkJK?=
 =?utf-8?B?TzRuanBUR3k1SmFUemwwOHdRbWdnOGQ2SjY0a2Y5V2N2YUxWbkZKZUZiTjh3?=
 =?utf-8?B?dkw2eDN4d0VEaFUwaXZhWW9xSmt3bjJ1U1lMeFVodXBTK2RFUnVEZjJmRlBv?=
 =?utf-8?B?aERJWS9MekxpOFB1Z3NINWNOa3dvbDFtZ2Fod2orY0tnZXRndlhpWDYzY0NN?=
 =?utf-8?B?ZmJ5YXRrOFRVTENWOUN4N2ZyeUJ2MXlPYTJWQWpzN0RsUzZhMkdnR0JCclFX?=
 =?utf-8?B?N25IMU56aTNhQ3czeU5KQXhtOVFCTThpM2UzbE4zbWVzYjhtMUlHb1l2YjNz?=
 =?utf-8?B?QldlQ0E3OUZiU0JmVlVZeVFlTmpqOGFWZXpYTXdBdVJoY3lKVVFoQlJudmJP?=
 =?utf-8?B?RFBiY3FoRklmVk9Pc0FLOXRRdkRUbDhZZ1MxZS9nS1lzeXNabXVRaGl0a0hR?=
 =?utf-8?B?QzJXNEt3ZFc2VkMyMTd4cmZaMm1aUGxZVVlZNnl4Y2s4TElIVFhtajJDMlFG?=
 =?utf-8?B?N1lUclY4SzkwTC9oWWVBUTdVbEcvbFVVYU5VeXdPVXJVQXJXZHRRSVlaQzJ5?=
 =?utf-8?B?K3RreFltRnN1dHpsTW4rM05GNFZ3Q1pqZllYQStxY1VsajZDVkxkRVlFdHBB?=
 =?utf-8?B?bkRPRHZiUmlZU1dhUkdvVTFWVHpwbnJEMlJCdElnVHo2RDJ1bmxHNFRZWlZT?=
 =?utf-8?B?Z1pEa3A1UDJ1Sk1yRVpVL2JFV04xN0dKbUZ1Mm4wbWpSb1lHOElXYkNVR2lv?=
 =?utf-8?B?YWFvWGVXazZXZWpHOW41RWwveDBOYTFJSnhuY2p6UzByN3FWNzFXKzdxWW5U?=
 =?utf-8?B?OFJtQ3hWRTV1Y25jbEhaaUdUanprVDNiTFRXWEplWE1qWUhCTHpUZjVST2VJ?=
 =?utf-8?B?b281aWJtV3ZEb3hNeHVVVytxcVV6WGRhRVBoWTliRGRVcEN6UUNGNlFPYk9G?=
 =?utf-8?B?NGRpU1l3TWppNVNtaUYwT2NDcHA5V081Y0I2VjV3ekZaQ1Y1cTR5OFp0bXRW?=
 =?utf-8?B?WCtBblM4djIzZVFFQUd0Vk84VzZZaU9zbDhiWFFtNkcvS2FXMDFmajV3dXlE?=
 =?utf-8?B?TTZvVDRLN3hlWVduL3QvajlIWlJ3L2Y2cWR3Z3Q0WG41YjdnaUxSeGpZWWg0?=
 =?utf-8?B?enhMdnU5ZDlDRzYzc1hyYTBsOGpRRTNaWG9xYVNrcUVwLzVhckhGTG9oOTBI?=
 =?utf-8?B?aDhPWmJZZmNwaWtuS3UzVlRWUllYakJRY01iOGZaeEh3Q2tSQkZxcHNGV3lj?=
 =?utf-8?B?RzVOci9VUFZMMzZleHR5QWRtNW14dEJCM2JYNW9aODlEUzdBU3lmbHNZYmpV?=
 =?utf-8?B?clpPYkhianNYb1p2cFl5dkJmdzBZd3hmSmtXMnExQ3luZUpnRER2TEp2TzJQ?=
 =?utf-8?Q?27/EjX8OmJrm2ccrDz3cvvzwr?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 110e5e0f-d15e-49ff-d91d-08dba34be6ef
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 20:10:59.7915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8bRTeIail/eewsyUi3EQsB4R2DE1eV4F63Bx/S6F3xkPRGjJDGmj8CkUP5tybtaxo/naYObaFcGFINILwlqWRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6252
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rick,

The comment below doesn't change anything meaningfully, but mainly helps
clarifies the original comment.

Maybe something like this:
>   * If the FPU register state is valid, the kernel can skip restoring the
>   * FPU state from memory.
>   *
> - * Any code that clobbers the FPU registers or updates the in-memory
> - * FPU state for a task MUST let the rest of the kernel know that the
> - * FPU registers are no longer valid for this task.
> + * Any code that clobbers the FPU registers or updates the in-memory FPU state
> + * for a task MUST let the rest of the kernel know that whether the FPU
> + * registers are no longer valid anywhere for this task or if the FPU state on
> + * a particular CPU is invalid.
>   *
> - * Either one of these invalidation functions is enough. Invalidate
> - * a resource you control: CPU if using the CPU for something else
> - * (with preemption disabled), FPU for the current task, or a task that
> - * is prevented from running by the current task.
> + * Invalidate a resource that you truly control:
> + * - Use __cpu_invalidate_fpregs_state() or equivalent when using the CPU for
> + *   something else (only with preemption disabled)
> + * - Use __fpu_invalidate_fpregs_state() or equivalent when modifying the FPU
> + *   for the current task, or a task that is prevented from running by the
> + *   current task.
>   */

Please disregard my suggestion if you think the existing one is
sufficient for now.

On 8/18/2023 10:03 AM, Rick Edgecombe wrote:
> diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
> index e03b6b107b20..a86d37052a64 100644
> --- a/arch/x86/kernel/fpu/core.c
> +++ b/arch/x86/kernel/fpu/core.c
> @@ -713,7 +713,7 @@ static void fpu_reset_fpregs(void)
>  	struct fpu *fpu = &current->thread.fpu;
>  
>  	fpregs_lock();
> -	fpu__drop(fpu);
> +	__fpu_invalidate_fpregs_state(fpu);
>  	/*
>  	 * This does not change the actual hardware registers. It just
>  	 * resets the memory image and sets TIF_NEED_FPU_LOAD so a

The code fix looks fine to me.

Even if you don't update the comment, please feel free to add:
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>

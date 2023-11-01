Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132E77DE1A9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 14:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344269AbjKAN1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 09:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343920AbjKAN1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 09:27:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F96F4
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 06:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698845234; x=1730381234;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=WQG4/a6WfeY8EPqYgb5KcaJXIVp7ilIei7VOP8x9JFY=;
  b=bhbstTpHq5ICJf3T/VtuyubmYARqiU5mRLWvLJIrFsbedJD9QwYhEvxR
   BhqQkof2//4rzdY4soOf/puZ7jUaJpT4TcPwHRF6CGxufen/c6yIPWTDR
   aEreQcN7iNvd2n7dAmxXdds3ibSoITefZsDTeDzWiXNRWGUQv8e0mm2S0
   gDr3SBLCf62aEwVMcr2McvOv7heKEQEclqNCm8qNLerq5eu8aNOYQXp6I
   5e3K63azqRphdlQbv+gLVZRs8j2ujHxxWlpppZlcajGQNSS4d8O9PL0uY
   9BeXZuLyax4ApQw6FqrZ2cw8n5Rh/86x+flL9JWfzxgm/OFLb5ERw7MgW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="454968073"
X-IronPort-AV: E=Sophos;i="6.03,268,1694761200"; 
   d="scan'208";a="454968073"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 06:27:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="1008100938"
X-IronPort-AV: E=Sophos;i="6.03,268,1694761200"; 
   d="scan'208";a="1008100938"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Nov 2023 06:27:13 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 1 Nov 2023 06:27:12 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 1 Nov 2023 06:27:12 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 1 Nov 2023 06:27:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dbon9VYOJeQAxfJ2RGf0GqkZWcZNCwL/ZsZIz/Wsqbocd71qeglhqRyI9DRzJ3L9ovLm80J899AjvTaMfpkR5zmnZtUZGlHi6BLojt2b/euHFubJ8F3gx/mSTgw/CKDZ+NZUZh5q1iOqXLs9V7nwfknChSwPLFJk0sWJ6+429YR6s/YEZH/ltoRyjKAmbBHB9mbqBHl/WOnBYs63h78hV6mC5jGjR1ImsQArthLPR+eZHP/YsX93mBaP0kCFA+aTeGkqjFK9LNO9poBUhfAenF2YEE/G8J3O/SZ+NLrbjuVy3HNe+61SPWhLScAA9b0EZ8XuLLGpIVS4oIJdEiPNEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4NWEB6UC0zWmQLAgidoB9zDBVQPUv9aR0A9os+Jz9mc=;
 b=T8M+7jhc2siq5j48GaNKfqXEq9tSgFl52Z1iI6OS3+nBYobxBBpD3a9iRdB02B15Zqz8DNnN/yXUE5q/RFefRpGyRdUnFm0l3AJPNyR/7UcRR6Pq1DKX4/q8zK+4+kvpz1ccCNSWD1gjVs4NrFvHkfabpeHBnYvOLZMiVZfNzZ91whyU2e63NAKBqikFC4U+6wazS32V//MWd5JLtt1kB6I/F/jHfJFBrpVYcmOz+Es7mmOjUnO97wN0VKtpSIgBI32L7pFbPcY6ebf0FsyYsR8Dhlcvb9DKTxjhy9GmHH1NwNZ49zvG+AZuB6FrMeMNTtfCAEHGOGf0RXPcwpaF0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by CYXPR11MB8710.namprd11.prod.outlook.com (2603:10b6:930:da::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Wed, 1 Nov
 2023 13:27:04 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::24ce:9f48:bce:5ade]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::24ce:9f48:bce:5ade%7]) with mapi id 15.20.6954.019; Wed, 1 Nov 2023
 13:27:04 +0000
Date:   Wed, 1 Nov 2023 21:17:54 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arjan van de Ven <arjan@linux.intel.com>,
        <paulmck@kernel.org>
Subject: Re: [PATCH v2] x86/tsc: Have tsc=recalibrate override things
Message-ID: <ZUJQAprWVQWbAXO/@feng-clx>
References: <20231030160050.GA15024@noisy.programming.kicks-ass.net>
 <20231101111621.GC19106@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231101111621.GC19106@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: SG2PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:3:18::30) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|CYXPR11MB8710:EE_
X-MS-Office365-Filtering-Correlation-Id: b95e08ef-8372-4d86-f47f-08dbdade3ca9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uFodFsQzkYgtU1OR+R6Gd9Wjb7zMAfWH25oOUqGy6ctraET72f1TARYJR9t6Lsz1F6mr6pX5pi1NeJ8OXaWn7dWjxuc4X87oRWNOUq+ukbcy/gu2+oRfVuuZQJztNfvULmWY5ukn5EK4PTLU3S4yeqRB8sLQkz6YEnH/SPVThObjCMj0FNl4wow4yZPzfqLOliBqWmirQWdD5fJTbjAj6dHtnut+N6m6PNNIytwqDdWpHoNBbddhSpYXlmxXcA40pzzESk+AxvOCDiv+7Pmj0BA8Ayx9rjilS7kC+h316ff22aVsMZFmxTokf4yn7LLyEQdYxYplV9in0GS7QtJZRdv6zmjWf8eSoz51Xxl5XDeFrBgiGe6UsLkok+EnDgEXr7G6XUlfMc17iv3IB5dpiO3VhwzywKJ3ZD/El1e70aeJ1J9fOm1qUmDQuEZVi75XQ0UmPXL7nCQIReJtQlJP/YWI6cb1CvMQ/0Cb1c01u+Tmb5mDkFd4MRRsAmOYhirfeQ8P8Mn6m8qB9GBULQRKV3KU9R8Mr6hORPaUkH4Kbc3ZSQNbz5jbcMLshNZkuO+AQJPh61mm3JQiQtgZtefx8GAOoPSgJE/aIzuVFlROWFLT9EKl4Fr6hAOPhU75C3Jz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(366004)(346002)(136003)(376002)(396003)(230922051799003)(230173577357003)(230273577357003)(451199024)(186009)(64100799003)(1800799009)(2906002)(6512007)(9686003)(26005)(6666004)(478600001)(4326008)(83380400001)(5660300002)(6506007)(6486002)(41300700001)(66946007)(33716001)(8936002)(316002)(66556008)(6916009)(54906003)(66476007)(44832011)(8676002)(86362001)(38100700002)(82960400001)(66899024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VzEIOBZb4bvkTB+3xOmj0M7Y5GE071lC4m2rbBBTfch1nxsekXPyk1xEGC5Y?=
 =?us-ascii?Q?vTZB0vcdWQBON197gKKeMmA4Sn0+4ns3gvjdRkb8KVCHxuLSVQnwPZ1Pf1Up?=
 =?us-ascii?Q?0tEP+oEj6pfIsPMwrDA9Tys2djKpBn0PiHFMLP02xKaLwfpcOhFXbJ3nBIZ6?=
 =?us-ascii?Q?Iir0som1nt/l6mzxhFld7SGPAW48AfGXjjLVhRMwYgg0Mn10YhOFNAMJx2aC?=
 =?us-ascii?Q?Ml+8AcVj0cgtSO71+kYxJKy7LiUfqk5TWqaEO17vIStIep08aTOYnecXoxFl?=
 =?us-ascii?Q?BVgVnzbjzlWUzyFicryO27da/DDJqyCFg6sJ5c7b0Y00Yrx21YNUvX4l8iMn?=
 =?us-ascii?Q?O6S8E2JjA07Qjw773CO2kV2//av4fCYO998NwRQ9YBwHY7j/pFFcWOhrSMbZ?=
 =?us-ascii?Q?xFXdzVAOp9s6afjhTKdIpT0QQ7PAnbpTj1CZt8Xw3IDMGXZhy8uvzFPhNmTJ?=
 =?us-ascii?Q?o8IhgsXn5B63YO0YY0Fsn2xS2wGqnTWCYZkkrWyxAueoSe0RvajkZiLXCfOW?=
 =?us-ascii?Q?ue9YaBvBuQy03Ks6d8lPDhMBxxK9f/hD5VTEqhcW8w3LgktqVvZwGcIaf3NM?=
 =?us-ascii?Q?bofA0mQFHQUQumtOGZXRNY6KHlkjwYlKe8ZGZgcEVXL0C/ynTICPFV9lmH6j?=
 =?us-ascii?Q?ERguJTTQnc3vyKypFAOtzKOr8NQF7ODJFewpTZ3DnJS/zrNyg4tsVXYVjzVW?=
 =?us-ascii?Q?APRRl/yGC+aDvackPeDLvvrguGO14fefGgQhj++OxxtxhaD2Uv3anStJ6Qyu?=
 =?us-ascii?Q?AUTsikkL2lm2ePHTDnxDcSyV4vik5UOsSpL7bpQ8e3zdE9OxsmiYhDClvVuT?=
 =?us-ascii?Q?WeTTbllv6MNWX9G7p8yoVu6e66jXcrPKsq2fHo59MPTSjxRf2bUXCb2DyQhu?=
 =?us-ascii?Q?bR77KSHB0O0XvF1GFHsPd8MfV/IF1/0hF1G4Y+wZE9ulTBvcCJ8lzL+Teu2k?=
 =?us-ascii?Q?b1lWd/8ZrkWNMABOmhZ2g+E3rhkhMAoRkhrjtHZgYnc8jXEynVw+bWG9kWoC?=
 =?us-ascii?Q?OyHJAQeKmm+EciDpbEXOQMX2HXE99hrn2/OomTqLPADbNSssAcSFzbauSPDZ?=
 =?us-ascii?Q?zwQwykKOh3TW/epzK1Xf4+ryFovwX6OrJHD0w458oG6zk8N8KvlqWxNjo3g2?=
 =?us-ascii?Q?OCP61SfPmontqY7i+GxGFXXHMyH41vNwxCJa/J86zGXQ8lSsgWAx5OUK6P44?=
 =?us-ascii?Q?SZ7JATN0Ld6RfkbR/f7gPin4VztqaO0EOyOffRY4FYN1PeTMMhjuNU2mGzoI?=
 =?us-ascii?Q?hBovdseXOxkjQd4O8npV6zRmiq5C4IFo95qCA7D+7tgcuEB45QsMra43qTYK?=
 =?us-ascii?Q?UUp7WB9MiObbZhwvwkjQK1AIDPfSCeXFgdCaCdkeQ6pUBhIBiA2tIO/gGBGW?=
 =?us-ascii?Q?lrTkoYywUqYjiaeBl10Lgpb4gsQUIA8apts+SOFPuiI1Ccty/kEk5Hkj2AdB?=
 =?us-ascii?Q?IXQ5uezdRZQgHd3RQrB/95lRKiMYwpiMcQf2/IbxwrUQyICAcp4r6YJ9bh3z?=
 =?us-ascii?Q?nQuRupPQ5ZCOcFOJzTSvN0B3kLzA54eriXdDxoUnCQb5jnUP8tayL/nPK/o+?=
 =?us-ascii?Q?8Kb+gAJ0L3x2EMjfcvwq0EIYcJo4nj2MULr5tupL?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b95e08ef-8372-4d86-f47f-08dbdade3ca9
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 13:27:04.8251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sOceJ9PLZ/7DV3pm6QBgx5ICPoFYicIlooYEPrNSNq9KDjufv3HNWuJdZNWPfcxXFkswKIkmkrFmioE3ODnbsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8710
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Paul as he also met similar issue before.

On Wed, Nov 01, 2023 at 12:16:21PM +0100, Peter Zijlstra wrote:
> Subject: x86/tsc: Have tsc=recalibrate override things
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Mon, 30 Oct 2023 17:00:50 +0100
> 
> My brand-spanking new SPR supermicro workstation was reporting NTP
> failures:
> 
> Oct 30 13:00:26 spr ntpd[3517]: CLOCK: kernel reports TIME_ERROR: 0x41: Clock Unsynchronized
> Oct 30 13:00:58 spr ntpd[3517]: CLOCK: time stepped by 32.316775
> Oct 30 13:00:58 spr ntpd[3517]: CLOCK: frequency error 41699 PPM exceeds tolerance 500 PPM
> 
> CPUID provides:
> 
>     Time Stamp Counter/Core Crystal Clock Information (0x15):
>        TSC/clock ratio = 200/2
>        nominal core crystal clock = 25000000 Hz
>     Processor Frequency Information (0x16):
>        Core Base Frequency (MHz) = 0x9c4 (2500)
>        Core Maximum Frequency (MHz) = 0x12c0 (4800)
>        Bus (Reference) Frequency (MHz) = 0x64 (100)
> 
> and the kernel believes this. Since commit a7ec817d5542 ("x86/tsc: Add
> option to force frequency recalibration with HW timer") there is the
> tsc=recalibrate option, which forces the recalibrate.
> 
> This duely reports:
> 
> Oct 30 12:42:39 spr kernel: tsc: Warning: TSC freq calibrated by CPUID/MSR differs from what is calibrated by HW timer, please check with vendor!!
> Oct 30 12:42:39 spr kernel: tsc: Previous calibrated TSC freq:         2500.000 MHz
> Oct 30 12:42:39 spr kernel: tsc: TSC freq recalibrated by [HPET]:         2399.967 MHz
> 
> but then continues running at 2500, offering no solace and keeping NTP
> upset -- drifting ~30 seconds for every 15 minutes.
> 
> Have tsc=recalibrate override the CPUID provided numbers. This makes the
> machine usable and keeps NTP 'happy':
> 
> Oct 30 16:48:44 spr ntpd[2200]: CLOCK: time stepped by -0.768679
 
Hi Peter,

The patch looks fine to me.

One thought is the original semantics of  'tsc=recalibrate' is just
to recalibrate and print out the frequency, and with this change,
it adds 'override' semantics, so the description for 'recalibrate'
in kernel-parameters.txt may also need some update. 

Thanks,
Feng

> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/kernel/tsc.c |   15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> --- a/arch/x86/kernel/tsc.c
> +++ b/arch/x86/kernel/tsc.c
> @@ -1430,14 +1430,13 @@ static void tsc_refine_calibration_work(
>  			hpet ? "HPET" : "PM_TIMER",
>  			(unsigned long)freq / 1000,
>  			(unsigned long)freq % 1000);
> +	} else {
>  
> -		return;
> +		/* Make sure we're within 1% */
> +		if (abs(tsc_khz - freq) > tsc_khz/100)
> +			goto out;
>  	}
>  
> -	/* Make sure we're within 1% */
> -	if (abs(tsc_khz - freq) > tsc_khz/100)
> -		goto out;
> -
>  	tsc_khz = freq;
>  	pr_info("Refined TSC clocksource calibration: %lu.%03lu MHz\n",
>  		(unsigned long)tsc_khz / 1000,
> @@ -1479,14 +1478,12 @@ static int __init init_tsc_clocksource(v
>  	 * When TSC frequency is known (retrieved via MSR or CPUID), we skip
>  	 * the refined calibration and directly register it as a clocksource.
>  	 */
> -	if (boot_cpu_has(X86_FEATURE_TSC_KNOWN_FREQ)) {
> +	if (boot_cpu_has(X86_FEATURE_TSC_KNOWN_FREQ) && !tsc_force_recalibrate) {
>  		if (boot_cpu_has(X86_FEATURE_ART))
>  			art_related_clocksource = &clocksource_tsc;
>  		clocksource_register_khz(&clocksource_tsc, tsc_khz);
>  		clocksource_unregister(&clocksource_tsc_early);
> -
> -		if (!tsc_force_recalibrate)
> -			return 0;
> +		return 0;
>  	}
>  
>  	schedule_delayed_work(&tsc_irqwork, 0);

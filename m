Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006C37BC9C6
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 22:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344153AbjJGUfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 16:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343782AbjJGUfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 16:35:03 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EEAD93;
        Sat,  7 Oct 2023 13:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=P0XjgGcwROeVVGyQzp4eM0gt2uiSNUTYGxKdqCX9ND8=; b=hkNzELmrNfiMGUcaxH+u8YbfpY
        qnkF3Jy1w8uNeNbEmmnHdSF20DY/Tg6WDSFh7VuNTkDFmuxKPk1lUXh62Z3kYUCeVVdNU3cwDI1jd
        PB3be/MQLikguwYykHf0d0qQpzJ9nd9UXcKz5X5+JONUa4tG0OquU/vyKWGfjRQPhJ9GpfFwVhOjq
        ohVjIfGkMDhiP0m4eyG5Wm7E+iV6/F9JzCYzhdSQ8AXl68IlfRCXsfHk/OMuHyAOuIlwf0L8BSJNM
        12XLPwMwoJPj4qTFcW/3XlqGHssDxFtELdeQ4kX/SWrhoIuUwYu//DBUBR/+++GdwBuZmNg05PVLY
        VVtkmQJw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qpE04-00DzC5-2C;
        Sat, 07 Oct 2023 20:34:16 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 66AA4300388; Sat,  7 Oct 2023 22:34:11 +0200 (CEST)
Date:   Sat, 7 Oct 2023 22:34:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Lucy Mielke <lucymielke@icloud.com>
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/x86/p4: Fix "Wunused-but-set-variable" warning
Message-ID: <20231007203411.GA8085@noisy.programming.kicks-ass.net>
References: <ZSGpl_hT23B6ix0M@mainframe>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZSGpl_hT23B6ix0M@mainframe>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 07, 2023 at 08:55:19PM +0200, Lucy Mielke wrote:
> This fixes a compiler warning when compiling an allyesconfig with W=1:
> warning: variable ´high´ set but not used [-Wunused-but-set-variable]

What compiler and what .config?

> Signed-off-by: Lucy Mielke <lucymielke@icloud.com>
> ---
>  arch/x86/events/intel/p4.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/events/intel/p4.c b/arch/x86/events/intel/p4.c
> index 35936188db01..69aaf7c0f340 100644
> --- a/arch/x86/events/intel/p4.c
> +++ b/arch/x86/events/intel/p4.c
> @@ -1366,7 +1366,7 @@ static __initconst const struct x86_pmu p4_pmu = {
>  
>  __init int p4_pmu_init(void)
>  {
> -	unsigned int low, high;
> +	unsigned int low, __maybe_unused high;
>  	int i, reg;
>  
>  	/* If we get stripped -- indexing fails */

Right after this we have:

	rdmsr(MSR_IA32_MISC_ENABLE, low, high);

which should get high unconditionally used. If there's a problem then
it's probably inside that rdmsr macro.

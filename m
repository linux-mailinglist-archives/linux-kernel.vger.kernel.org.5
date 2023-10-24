Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2AFA7D5948
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 19:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344008AbjJXRB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 13:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232602AbjJXRBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 13:01:50 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4205118;
        Tue, 24 Oct 2023 10:01:47 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-54041e33845so4119973a12.3;
        Tue, 24 Oct 2023 10:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698166906; x=1698771706; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tJLSiRFgr+vLugH53T/KVTL1ow4JkI7JxvtTgGarGgg=;
        b=CVXprM8E3LNLGBlK8gbWhSNMFC0T7cvHR1MMjdbVaxXHRj5DY6xbE6BT3JLDMhtFsm
         0AJxTc2Ufpwidj788vLJoZEtnFstFB2AJCw8iY8DduOvb9fY8ffmt/AKtEJNfPUZv9Wv
         WfV+ZK9Qj2WNyHf03LmI3xEWJ9YFnZIIgVYHIHHJih9GP6QXptBXj2/UOc58KRA4Oxk7
         xJCGuxDdIwgshnksH8kObDYXoze9omw3WoOJ404SQLSFs80CgxcnJxvn2rj8efcMJgqX
         CYFnUBJNUEbUXx9YPSru1rYYOqa+jOxoE+bKt0Eh7A0F3z00m/6eyRcZMJUaI2xlFl05
         6asg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698166906; x=1698771706;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tJLSiRFgr+vLugH53T/KVTL1ow4JkI7JxvtTgGarGgg=;
        b=VS9f55CxZYSYQwUWpYydAps0+/zSvgUt6lTBMknxuh4eZDnVjQgcutwWvZHYHNvKfq
         Bizk1zs54520x47hKN4msGaC3T6kFIgpMbi7GTuLwhnp+XRGTGqOg7/L4dWdBB22SFtP
         Wmvv2WPNEfAKtxl3Rr50RKoCwRv/MAqzPpUXSH34YHwJ9mH42H/qWiylgRRl/BE3CfkP
         TIwvGzjdjFDEBT+QYO3Mw2jFYn5KkSV0LZHpy7kMFdswxc7TUQP5KiXs1vSzXy1szPrR
         whV7naq1gQt4VpuE4J81Bj/WPCOXfSs8ti+XxIngjHFBeTmp5y6GCcmVCMjTuCkJs+cA
         QVag==
X-Gm-Message-State: AOJu0YxpNnxRHrBE3wOhZOwU2D0Q1Dc/53fFYaDFpHlyHTDwNx1bPhMF
        sm7iXa0X7jmgpDfWAUsUWxk=
X-Google-Smtp-Source: AGHT+IHL7UMfiDcI9b7i6CuEP2RbI/XnIVBaFe2aZzyRZY7FPfL0RBwkSa6uIa0OZH/cy5TAIXfvcg==
X-Received: by 2002:a50:bae5:0:b0:53d:e5d7:4148 with SMTP id x92-20020a50bae5000000b0053de5d74148mr9651463ede.1.1698166905845;
        Tue, 24 Oct 2023 10:01:45 -0700 (PDT)
Received: from gmail.com (1F2EF1E7.nat.pool.telekom.hu. [31.46.241.231])
        by smtp.gmail.com with ESMTPSA id dn22-20020a05640222f600b005401a4184ddsm5235818edb.27.2023.10.24.10.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 10:01:45 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 24 Oct 2023 19:01:42 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-pm@vger.kernel.org, rafael@kernel.org,
        pavel@ucw.cz, linux-perf-users@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 1/2] x86: Enable x2apic during resume from suspend if
 used previously
Message-ID: <ZTf4dtWBTjiKIntj@gmail.com>
References: <20231023160018.164054-1-mario.limonciello@amd.com>
 <20231023160018.164054-2-mario.limonciello@amd.com>
 <ZTeB9K4NYu1sRiZ1@gmail.com>
 <6894bebf-15ed-4bd2-aebc-f4ac0a30a395@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6894bebf-15ed-4bd2-aebc-f4ac0a30a395@amd.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Mario Limonciello <mario.limonciello@amd.com> wrote:

> +Tom
> 
> On 10/24/2023 03:36, Ingo Molnar wrote:
> > 
> > * Mario Limonciello <mario.limonciello@amd.com> wrote:
> > 
> > > If x2apic was enabled during boot with parallel startup
> > > it will be needed during resume from suspend to ram as well.
> > > 
> > > Store whether to enable into the smpboot_control global variable
> > > and during startup re-enable it if necessary.
> > > 
> > > Cc: stable@vger.kernel.org # 6.5+
> > > Fixes: 0c7ffa32dbd6 ("x86/smpboot/64: Implement arch_cpuhp_init_parallel_bringup() and enable it")
> > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > > ---
> > >   arch/x86/include/asm/smp.h   |  1 +
> > >   arch/x86/kernel/acpi/sleep.c | 12 ++++++++----
> > >   arch/x86/kernel/head_64.S    | 15 +++++++++++++++
> > >   3 files changed, 24 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
> > > index c31c633419fe..86584ffaebc3 100644
> > > --- a/arch/x86/include/asm/smp.h
> > > +++ b/arch/x86/include/asm/smp.h
> > > @@ -190,6 +190,7 @@ extern unsigned long apic_mmio_base;
> > >   #endif /* !__ASSEMBLY__ */
> > >   /* Control bits for startup_64 */
> > > +#define STARTUP_ENABLE_X2APIC	0x40000000
> > >   #define STARTUP_READ_APICID	0x80000000
> > >   /* Top 8 bits are reserved for control */
> > > diff --git a/arch/x86/kernel/acpi/sleep.c b/arch/x86/kernel/acpi/sleep.c
> > > index 6dfecb27b846..29734a1299f6 100644
> > > --- a/arch/x86/kernel/acpi/sleep.c
> > > +++ b/arch/x86/kernel/acpi/sleep.c
> > > @@ -11,6 +11,7 @@
> > >   #include <linux/dmi.h>
> > >   #include <linux/cpumask.h>
> > >   #include <linux/pgtable.h>
> > > +#include <asm/apic.h>
> > >   #include <asm/segment.h>
> > >   #include <asm/desc.h>
> > >   #include <asm/cacheflush.h>
> > > @@ -129,11 +130,14 @@ int x86_acpi_suspend_lowlevel(void)
> > >   	 */
> > >   	current->thread.sp = (unsigned long)temp_stack + sizeof(temp_stack);
> > >   	/*
> > > -	 * Ensure the CPU knows which one it is when it comes back, if
> > > -	 * it isn't in parallel mode and expected to work that out for
> > > -	 * itself.
> > > +	 * Ensure x2apic is re-enabled if necessary and the CPU knows which
> > > +	 * one it is when it comes back, if it isn't in parallel mode and
> > > +	 * expected to work that out for itself.
> > >   	 */
> > > -	if (!(smpboot_control & STARTUP_PARALLEL_MASK))
> > > +	if (smpboot_control & STARTUP_PARALLEL_MASK) {
> > > +		if (x2apic_enabled())
> > > +			smpboot_control |= STARTUP_ENABLE_X2APIC;
> > > +	} else
> > >   		smpboot_control = smp_processor_id();
> > 
> > Yeah, so instead of adding further kludges to the 'parallel bringup is
> > possible' code path, which is arguably a functional feature that shouldn't
> > have hardware-management coupled to it, would it be possible to fix
> > parallel bringup to AMD-SEV systems, so that this code path isn't a
> > quirk-dependent "parallel boot" codepath, but simply the "x86 SMP boot
> > codepath", where all SMP x86 systems do a parallel bootup?
> > 
> > The original commit by Thomas says:
> > 
> >    0c7ffa32dbd6 ("x86/smpboot/64: Implement arch_cpuhp_init_parallel_bringup() and enable it")
> > 
> >    | Unfortunately there is no RDMSR GHCB protocol at the moment, so enabling
> >    | AMD-SEV guests for parallel startup needs some more thought.
> > 
> > But that was half a year ago, isn't there RDMSR GHCB access code available now?
> > 
> > This code would all read a lot more natural if it was the regular x86 SMP
> > bootup path - which it is 'almost' today already, modulo quirk.
> > 
> > Obviously coupling functional features with hardware quirks is fragile, for
> > example your patch extending x86 SMP parallel bringup doesn't extend the
> > AMD-SEV case, which may or may not matter in practice.
> > 
> > So, if it's possible, it would be nice to fix AMD-SEV systems as well and
> > remove this artificial coupling.
> 
> It probably isn't clear since I didn't mention it in the commit message, but
> this is not a system that supports AMD-SEV.  This is a workstation that
> supports x2apic.  I'll clarify that for V2.

Yes, I suspected as much, but that's irrelevant to the arguments I 
outlined, that extending upon this quirk that makes SMP parallel bringup HW 
environment dependent, and then coupling s2ram x2apic re-enablement to that 
functional feature is inviting trouble in the long run.

For example, what guarantees that the x2apic will be turned back on after 
suspend if a system is booted with maxcpus=1?

Obviously something very close to your fix is needed.

> I've looped Tom in to comment whether it's possible to improve AMD-SEV as 
> well.

Thanks!

	Ingo

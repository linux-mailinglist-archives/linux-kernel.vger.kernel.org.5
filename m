Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67EE87C814E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 11:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjJMJDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 05:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjJMJDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 05:03:46 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82AF895;
        Fri, 13 Oct 2023 02:03:44 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-32d849cc152so1781575f8f.1;
        Fri, 13 Oct 2023 02:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697187823; x=1697792623; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mVXzaNCQ+HvBISgUOUJ4L9y3uEa9RCaldYHVY2YAQiM=;
        b=k20zYg/bYmrGUQvX3T6N+NxkeIHyufUrLU5ZOQVuAabVIfSdj7TrxFmZHV+6WtrP3/
         Zy1xv6NBHQPClOOAojsgsR7hWTKviJIySdikbDsIo/cURoj9JHDuQ8CBGycei2BM03eq
         CiK4aLPw9OalKAYeTXbsnazt6K6bIYwCKayuI4HcGwxO8yKC9sc+A1J2qlqnDJgWFQH0
         hyccD4l4GBLVTt1RMt/IokssGQDBpCmd/1AoWNL1cM9g1i2XHdb7l/3xc89Msn2lSOhG
         3I/dU53e8OxIP26/vfHgWczsnDWP9x/hGtwa2+o67eCAlaDlRDzYU9bBnSaAQRYNxYjA
         Yc9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697187823; x=1697792623;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mVXzaNCQ+HvBISgUOUJ4L9y3uEa9RCaldYHVY2YAQiM=;
        b=gXcA7pygHWZzakysZjvuEmhaQec5MqCOtdLC1TaqyitYKLCL5ewZg7E4o6oYCBcjeg
         k0wc+6j87VTOpeH6JGH3WPWCl55bEIL2kktPMjLANURcMWohSpCMNXGwZTTN6rsWstqs
         96LUhHV8X+pc2gt3G2OE8qAio1kT0W4hCsqfC769z0jEAvw8oZtYJjxcCQozps0pDxle
         wCfqp/eAvRiX9ClFTher29aTHNg2gMF8+IbuE/g0VhSrYbbmPS6hr9wjjz42t6yEYe2Q
         IL3jCw0K8qFWL2Eqjls4VHSOds5g0quuLCjt2Q/cBo5qzV3XppjObNAvOj0hE//lSLNa
         rKgQ==
X-Gm-Message-State: AOJu0YwAVz5TpUYa248SCTE3CtZ4JDhDdgllohohIA41EZNpWoCtl1aV
        hJHrDUiWoRdLLaFVvR+hZZ8=
X-Google-Smtp-Source: AGHT+IGBJbJOOMt2ygR5MBho8elPwZ41u1q9oxDLqPoxSsf1UOx0K63NlPMgoUjBfzna0nS+3W/5dA==
X-Received: by 2002:a5d:5a86:0:b0:32d:260b:5b7b with SMTP id bp6-20020a5d5a86000000b0032d260b5b7bmr9876635wrb.11.1697187822845;
        Fri, 13 Oct 2023 02:03:42 -0700 (PDT)
Received: from gmail.com (1F2EF405.nat.pool.telekom.hu. [31.46.244.5])
        by smtp.gmail.com with ESMTPSA id m8-20020adfa3c8000000b0032d7fde2d3csm8136690wrb.79.2023.10.13.02.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 02:03:42 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 13 Oct 2023 11:03:39 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Sandipan Das <sandipan.das@amd.com>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] perf/x86/amd/uncore: fix error codes in amd_uncore_init()
Message-ID: <ZSkH64SpvOTOJSpE@gmail.com>
References: <cec62eba-c4b8-4cb7-9671-58894dd4b974@moroto.mountain>
 <fbc90ef0-1418-4c7b-8f3e-7dd1a0d7499e@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbc90ef0-1418-4c7b-8f3e-7dd1a0d7499e@amd.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Sandipan Das <sandipan.das@amd.com> wrote:

> On 10/13/2023 12:48 PM, Dan Carpenter wrote:
> > Some of the error paths in this function return don't initialize the
> > error code.  Return -ENODEV.
> > 
> > Fixes: d6389d3ccc13 ("perf/x86/amd/uncore: Refactor uncore management")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> >  arch/x86/events/amd/uncore.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
> > index 9b444ce24108..a389828f378c 100644
> > --- a/arch/x86/events/amd/uncore.c
> > +++ b/arch/x86/events/amd/uncore.c
> > @@ -1009,7 +1009,8 @@ static struct amd_uncore uncores[UNCORE_TYPE_MAX] = {
> >  static int __init amd_uncore_init(void)
> >  {
> >  	struct amd_uncore *uncore;
> > -	int ret, i;
> > +	int ret = -ENODEV;
> > +	int i;
> >  
> >  	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
> >  	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
> 
> 
> Thanks for catching this. I see that 'ret' remains uninitialized for cases
> where the hotplug callback registration fails and was thinking if the
> following is a better fix for this as the reason might not be ENODEV.

Yeah, passing through the real error codes is usually better.

Here's it's probably a bit academic, as I don't think we are even using the 
init return code in the init sequence iterator, see how the return code by 
do_one_initcall() gets ignored by do_initcall_level() & do_pre_smp_initcalls() ...

Nevertheless, mind submitting this as a separate patch?

Thanks,

	Ingo

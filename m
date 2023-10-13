Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C608D7C8156
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 11:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjJMJGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 05:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjJMJGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 05:06:44 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECE495;
        Fri, 13 Oct 2023 02:06:43 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9936b3d0286so309924266b.0;
        Fri, 13 Oct 2023 02:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697188001; x=1697792801; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SYCXmUlUlbkeZWXSKQCOfZubKeGAvOpPkTEQglD2zzw=;
        b=MO4lwK5uxQrSjcQpT1uWzKPFcLAE3SwhNrVWPl9FYG8b+Bz0uoD+aQlLIs7UsFgwhz
         uHRFGMhGDRuTLIY1LLRoO3IhSa6mUh7LZct3/22gxPf5AvQim7wFtNlGu9ZHcXH3THzd
         UyStCf71qGxtygxe0vepjXTA9f34gvUiFhH25L5u3VP4hFjy3//FhTSWUEhNUxoNJXr2
         oMsJT0jTphBUKURgTG6CK5BuUmd28TyqObVjadELpXoiPHXnl6zvnNoml/l0o/EA+7Wd
         8nGhtRzHGPQyddZ3TxmTV1+VhqiYJy0FKqUnMO//mAzI2oLInXICEsVvoAY9l4T8XsQ5
         hQGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697188001; x=1697792801;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SYCXmUlUlbkeZWXSKQCOfZubKeGAvOpPkTEQglD2zzw=;
        b=mS0CR/8jDBqQXRhQ4mK85taU+mAa1FjH/f+iL4oqefPRczyto52YLV1Hi5jD1ShxqM
         E2EIQF57H/uVebRxYAxRlo+g+2+xkCXxttjwkQl+V82jtza9lkiCfNp0WAqV2P0sZfUU
         SYgaHxgzMHF0x868X19uZOt1z6BribwFQq2dLwu3Hsv5YXVik1387amSSnu8/pc3I+dQ
         08rE4Rz+HyDBb3EGqVmxrEH8ZsC/NlNXsAcNZrTZfJaOLl6iamDYI0WAiYndjhp8OSi0
         Cfr33g27cpE71rRxZkYi/bqVcADzuYqfkPCW+zQjKeALH3ys1goXBe7pq1uYizkhGsG5
         9JDQ==
X-Gm-Message-State: AOJu0YxuL1rwxFouon8Fmql1ErvWi6+ZXHOcMFThkg2ii/tQJR8/+VJM
        MCOX0jMeARcNCsPjbdAlHKU=
X-Google-Smtp-Source: AGHT+IEVhYLxqSknJcU+xVT4VirzpyubA3VLnZK5A7fsOp0vNRceduxO+T0cVRzCujNZeWy7luf/2w==
X-Received: by 2002:a17:906:31cc:b0:9ae:56da:6068 with SMTP id f12-20020a17090631cc00b009ae56da6068mr15949758ejf.57.1697188000823;
        Fri, 13 Oct 2023 02:06:40 -0700 (PDT)
Received: from gmail.com (1F2EF405.nat.pool.telekom.hu. [31.46.244.5])
        by smtp.gmail.com with ESMTPSA id lc11-20020a170906f90b00b009b9aa8fffdasm12051982ejb.131.2023.10.13.02.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 02:06:39 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 13 Oct 2023 11:06:37 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Sandipan Das <sandipan.das@amd.com>,
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
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Uros Bizjak <ubizjak@gmail.com>
Subject: Re: [PATCH] perf/x86/amd/uncore: fix error codes in amd_uncore_init()
Message-ID: <ZSkInflBriOL9V3M@gmail.com>
References: <cec62eba-c4b8-4cb7-9671-58894dd4b974@moroto.mountain>
 <ZSjyJuqk3z0RyKP2@gmail.com>
 <0c973a20-e10c-4989-b7d9-86cb0f522718@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c973a20-e10c-4989-b7d9-86cb0f522718@kadam.mountain>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Dan Carpenter <dan.carpenter@linaro.org> wrote:

> On Fri, Oct 13, 2023 at 09:30:46AM +0200, Ingo Molnar wrote:
>
> > Ugh, why on Earth didn't GCC warn about this? The bad pattern is pretty 
> > simple & obvious once pointed out ... compilers should have no trouble 
> > realizing that 'ret' is returned uninitialized in some of these control 
> > paths. Yet not a peep from the compiler ...
> 
> We disabled that warning years ago (5?) because GCC had too many false 
> positives.

GCC had some pretty bogus notions about 'possible' uninitialized use that 
encouraged some bad code patterns, but in this case there's readily 
provable uninitialized use, that a compiler should warn about.

Is it possible to disable just the unreliable, probabilistic part of GCC's 
uninitialized variables warnings?

Thanks,

	Ingo

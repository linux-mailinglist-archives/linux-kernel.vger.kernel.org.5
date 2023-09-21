Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6559F7A9AF7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 20:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjIUSwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 14:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjIUSwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:52:22 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A54C900D4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:46:21 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-4053c6f0e50so624155e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695318380; x=1695923180; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PZJCsdLzutgfF2WmT4E/VmrTiPqUKFREB2gVIRmp/cw=;
        b=hbuInmYvZLer3b+p50wSq4DjG7wPmoiouANwdKo/9FzLzyHOOWT/xlmFyIcemKw5g6
         pN/5gkj9vZAW+8qsAv+zmlvImqBMwxKpJAKeOdnmcxGnPxzW2nuPAmRP1Qqm7YEoziN8
         FOV/Qpc5l7hXBLClMF15r9+qZ8pLnp7SacuQaSkA9U8pJOvFtJQAzuZHTIgEXiDNoQde
         nMdIa8cHwH3fpnIHjSc70MiaEmGgdLnyxbeDVkYj/unoW0wF4nYh7o729HKpiYQAiGQ1
         PxfgL+zv4s7sujGJmMZVTrBFuJ6cdf1c7PVPwLfl7jXyDcZnKIxivDX3WShVgpS5KTTs
         P9Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695318380; x=1695923180;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PZJCsdLzutgfF2WmT4E/VmrTiPqUKFREB2gVIRmp/cw=;
        b=XexFxTrRB9U6awsL/YhILPsRdpYCpekc6yJPP7lXXMNNpX7lOetDFLr4ixCXQsSynH
         way7FlyFAgWp1r3X/z50zcNQDZlHVXcWTdj/+ZSAkxzuA+5NLFLlCWZT4KCxPwwud0zq
         47FEPy+WVC+ECLEUye4MtzCYAn9InZiC7BZvhelS5Hjw8zk5M8dLZrpZflMjvxyo0BJK
         aaM7a7jtvaSBNGnWBCSAG2eHcZPEwjlKBzBioblsis9kFJN+gwL0GlUSYMjx7+a5bKll
         4xSRSLZ5lOP7suJhVK7WfQfm8/RP6Zx4Lv6VbHXNR/RKSpTtIqZYBVhvcbp8m58m1PrE
         3UFQ==
X-Gm-Message-State: AOJu0YyqJHrBUWA8VSxXcFJrm7VBx0fT4JxpB5nS4RJeGUo1v8iEfuln
        YNaD9tDdmBXeV2nqDSzDU1ScnKHUyKs=
X-Google-Smtp-Source: AGHT+IEgNKTcfR/TcBzxudXMEUyvF9fPpjEr/LBcCWxT3Ha/aj+wxmWmqgvg/TlxLwUgAJ8GK2ZBzQ==
X-Received: by 2002:adf:9dc5:0:b0:321:9979:99ef with SMTP id q5-20020adf9dc5000000b00321997999efmr1071103wre.48.1695279813023;
        Thu, 21 Sep 2023 00:03:33 -0700 (PDT)
Received: from gmail.com (1F2EF265.nat.pool.telekom.hu. [31.46.242.101])
        by smtp.gmail.com with ESMTPSA id s16-20020a5d5110000000b0031aca6cc69csm885389wrt.2.2023.09.21.00.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 00:03:28 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 21 Sep 2023 09:03:26 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Yi Sun <yi.sun@intel.com>
Cc:     dave.hansen@intel.com, linux-kernel@vger.kernel.org,
        x86@kernel.org, sohil.mehta@intel.com, ak@linux.intel.com,
        ilpo.jarvinen@linux.intel.com, heng.su@intel.com,
        tony.luck@intel.com, yi.sun@linux.intel.com, yu.c.chen@intel.com
Subject: Re: [PATCH v7 1/3] x86/fpu: Measure the Latency of XSAVE and XRSTOR
Message-ID: <ZQvqvpSbyub6gFZX@gmail.com>
References: <20230921062900.864679-1-yi.sun@intel.com>
 <20230921062900.864679-2-yi.sun@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921062900.864679-2-yi.sun@intel.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Yi Sun <yi.sun@intel.com> wrote:

> @@ -113,7 +116,7 @@ static inline u64 xfeatures_mask_independent(void)
>   * original instruction which gets replaced. We need to use it here as the
>   * address of the instruction where we might get an exception at.
>   */
> -#define XSTATE_XSAVE(st, lmask, hmask, err)				\
> +#define __XSTATE_XSAVE(st, lmask, hmask, err)				\
>  	asm volatile(ALTERNATIVE_3(XSAVE,				\
>  				   XSAVEOPT, X86_FEATURE_XSAVEOPT,	\
>  				   XSAVEC,   X86_FEATURE_XSAVEC,	\
> @@ -130,7 +133,7 @@ static inline u64 xfeatures_mask_independent(void)
>   * Use XRSTORS to restore context if it is enabled. XRSTORS supports compact
>   * XSAVE area format.
>   */
> -#define XSTATE_XRESTORE(st, lmask, hmask)				\
> +#define __XSTATE_XRESTORE(st, lmask, hmask)				\
>  	asm volatile(ALTERNATIVE(XRSTOR,				\
>  				 XRSTORS, X86_FEATURE_XSAVES)		\
>  		     "\n"						\
> @@ -140,6 +143,35 @@ static inline u64 xfeatures_mask_independent(void)
>  		     : "D" (st), "m" (*st), "a" (lmask), "d" (hmask)	\
>  		     : "memory")
>  
> +#if defined(CONFIG_X86_DEBUG_FPU)
> +#define XSTATE_XSAVE(fps, lmask, hmask, err)				\
> +	do {								\
> +		struct fpstate *f = fps;				\
> +		u64 tc = -1;						\
> +		if (tracepoint_enabled(x86_fpu_latency_xsave))		\
> +			tc = trace_clock();				\
> +		__XSTATE_XSAVE(&f->regs.xsave, lmask, hmask, err);	\
> +		if (tracepoint_enabled(x86_fpu_latency_xsave))		\
> +			trace_x86_fpu_latency_xsave(f, trace_clock() - tc);\
> +	} while (0)
> +
> +#define XSTATE_XRESTORE(fps, lmask, hmask)				\
> +	do {								\
> +		struct fpstate *f = fps;				\
> +		u64 tc = -1;						\
> +		if (tracepoint_enabled(x86_fpu_latency_xrstor))		\
> +			tc = trace_clock();				\
> +		__XSTATE_XRESTORE(&f->regs.xsave, lmask, hmask);	\
> +		if (tracepoint_enabled(x86_fpu_latency_xrstor))		\
> +			trace_x86_fpu_latency_xrstor(f, trace_clock() - tc);\

This v7 version does not adequately address the review feedback I gave for 
v6: it adds tracing overhead to potential hot paths, and putting it behind 
CONFIG_X86_DEBUG_FPU is not a solution either: it's default-y, so de-facto 
enabled on all major distros...

It seems unnecessarily complex: why does it have to measure latency 
directly? Tracepoints *by default* come with event timestamps. A latency 
measurement tool should be able to subtract two timestamps to extract the 
latency between two tracepoints...

In fact, function tracing is enabled on all major Linux distros:

  kepler:~/tip> grep FUNCTION_TRACER /boot/config-6.2.0-33-generic 
  CONFIG_HAVE_FUNCTION_TRACER=y
  CONFIG_FUNCTION_TRACER=y

Why not just enable function tracing for the affected FPU context switching 
functions?

The relevant functions are already standalone in a typical kernel:

   xsave:                # ffffffff8103cfe0 T save_fpregs_to_fpstate
   xrstor:               # ffffffff8103d160 T restore_fpregs_from_fpstate
   xrstor_supervisor:    # ffffffff8103dc50 T fpu__clear_user_states

... and FPU context switching overhead dominates the cost of these 
functions.

Thanks,

	Ingo

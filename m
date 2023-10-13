Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEB57C7E95
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 09:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjJMHaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 03:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjJMHax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 03:30:53 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F27B8;
        Fri, 13 Oct 2023 00:30:51 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40537481094so19401545e9.0;
        Fri, 13 Oct 2023 00:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697182250; x=1697787050; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vzVL5vVmRYO7lL+aDIjM1G9uTaxxQRQWQ2vKxVi0PEE=;
        b=aVDSiankkK8vXZeHSgWVWxEcPu7tkybVPvPmusHLHOfPoTKLWS+pUCSuROzuDaeHgL
         oZG5iXUrw+gTe9m8hHLTdalAP6mw7KDu1e+W+mJ47g1cKVC8VNAqT4CrqSf1yzG6Xb1Q
         +bsW5AdSNdxOrm2ySJHxb4Q5DOIbqbdwich18k3bI/d9LAaR8gBh/s8FYkR9AX93B3u8
         hL0U0btNw2R3zpdqk5wMNCoyLt6MrbjPiq5y0dknbcYzFtepDLbJvY4AH+30iOuApnVo
         6BDN/ocz7yOrnXyBSjlfSdIo+/fWZeL2/xDz85/AvaJ4opKDKjVDFjbW8ZElWoHnt55t
         D6Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697182250; x=1697787050;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vzVL5vVmRYO7lL+aDIjM1G9uTaxxQRQWQ2vKxVi0PEE=;
        b=jFnm6lS5b4f/28OmjPS1AxQEmmnYqqLp8xiXAW0j1MRYql4cW/b6ohVi9cWG6q2N9e
         NQAGNrV1Lix2ynn2GyOeCTQ0v2ko+Tt1d6manfLe2oy66S+RudyPkgu7zyIxlXMAWtx8
         jKAmJ3ju0Si4HKGVySUmUEmoulw+IQJZc4+CPp3KtYFIYrsbqGAXjym+2qTY5UIm2vT/
         FJz+8X77XqTLLcP2zEyuhQjtn74UOExMVtP+8bYwj+jR79ncHS+2ch7tVgbTQHllyD5n
         XVFu8Bn9866AxKANlvOebwzO1NyNvODMPiNlHW+zrAws1xH7QbyDpAF0JTAZp5Vnls0B
         yOVg==
X-Gm-Message-State: AOJu0YzcgWCCZi2fyWHmZtXeuvzWYiI6Pk0Wjz+RUiIFVipxOmZc5Gab
        mjZzhDahXQJzsMva6m+yJ5k=
X-Google-Smtp-Source: AGHT+IGQSk4HywK3W12gZApu9SDZ1U/7aZSF8TJnTms0OUo172gVR9nFhI8WW/HWhSIhw74vG/hXEw==
X-Received: by 2002:adf:a31e:0:b0:32d:888a:c2cf with SMTP id c30-20020adfa31e000000b0032d888ac2cfmr6034412wrb.7.1697182249845;
        Fri, 13 Oct 2023 00:30:49 -0700 (PDT)
Received: from gmail.com (1F2EF405.nat.pool.telekom.hu. [31.46.244.5])
        by smtp.gmail.com with ESMTPSA id h15-20020a05600016cf00b0032cc35c2ef7sm9889328wrf.29.2023.10.13.00.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 00:30:48 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 13 Oct 2023 09:30:46 +0200
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
Message-ID: <ZSjyJuqk3z0RyKP2@gmail.com>
References: <cec62eba-c4b8-4cb7-9671-58894dd4b974@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cec62eba-c4b8-4cb7-9671-58894dd4b974@moroto.mountain>
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

> Some of the error paths in this function return don't initialize the
> error code.  Return -ENODEV.
> 
> Fixes: d6389d3ccc13 ("perf/x86/amd/uncore: Refactor uncore management")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  arch/x86/events/amd/uncore.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
> index 9b444ce24108..a389828f378c 100644
> --- a/arch/x86/events/amd/uncore.c
> +++ b/arch/x86/events/amd/uncore.c
> @@ -1009,7 +1009,8 @@ static struct amd_uncore uncores[UNCORE_TYPE_MAX] = {
>  static int __init amd_uncore_init(void)
>  {
>  	struct amd_uncore *uncore;
> -	int ret, i;
> +	int ret = -ENODEV;
> +	int i;
>  
>  	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
>  	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)

Ugh, why on Earth didn't GCC warn about this? The bad pattern is pretty 
simple & obvious once pointed out ... compilers should have no trouble 
realizing that 'ret' is returned uninitialized in some of these control 
paths. Yet not a peep from the compiler ...

Thanks for the fix!

	Ingo

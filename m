Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4323579076E
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 12:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352019AbjIBKuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 06:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234809AbjIBKuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 06:50:05 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1C01704
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 03:50:00 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-31aeef88a55so2319924f8f.2
        for <linux-kernel@vger.kernel.org>; Sat, 02 Sep 2023 03:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693651799; x=1694256599; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I7KPFwHs19Qi15qhrrII49ralT5uxL6ucFhXBjQigx8=;
        b=rG1Vkgem8NRxD0B/Jp3SY8U0uVSllcUgZdj59npQcJJp20W0q5Bq/5WONTFwBqQy9A
         KrWCO+rRFlLg3FSMqYkNxIMI0qwgOMpYO57BrHRb7fQ253bhr6hWQOp7qYLMNh+Jvv9S
         mArxdercEc/blXFGawi9pNUIOmKx9wFCh3hJtuvg3pCQaMtxayc3WdtHUKEVVKvwQsm1
         eftJLeFdjeA0i3Yr+u9aBMDZhg00okM3w72IJ+zlWOQ1ISS6RyQPnjT2QrOCmutUWhr9
         kc/rM2P9SV/NpqcS0JeFzISbnAMWceTgyF2gVnFQO5jqf7yddy2qQJGI1wN0POBPzGH5
         eCdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693651799; x=1694256599;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I7KPFwHs19Qi15qhrrII49ralT5uxL6ucFhXBjQigx8=;
        b=M05XXYgZcpXJjXWM6hHycohzwdZK+4buU1w1yYarScG9lQITMI/ETJHrMq0pMjGp64
         +NT5w6v8UCVKB8spI3lxGJBa5GwsFUvILuwtOQmSgOgoBdXrNzJceYxjZH8dhu9Cap1A
         fKYS8492rNRL5RRIi2Ws1T5V0Qmx0bG8eVE1QeBp/07bDTIdFLvT8Qac5IUoSTBjgczl
         AIfNQCfn7NmfCEK2WsuLV1Qzvqr/b5AksTBsUnaJmCfDlKoTPUptPe0hDL30T7HrO1WA
         YXq9ZLtlGEbByrzB95VlgGI/k9XFtnuruPs6Z2B520uxb+/08WEMVYwuJIJSZqiUKN8Z
         yoWg==
X-Gm-Message-State: AOJu0Yx4t+x3GEDKoUjRRpmcVjive9KGtGqcUxpKrLQ01RQMKVQnQaBo
        wMw3w7y75YpYrDX1leNL+iZo74JbBak=
X-Google-Smtp-Source: AGHT+IFSSk6zv9MOO9iGWa5NLU3ch/m8c4viVwQe1aQuu/DDquzMU3cI7YANoEsbWort3Rr0Q+n+Bw==
X-Received: by 2002:a5d:474e:0:b0:319:790e:3bc5 with SMTP id o14-20020a5d474e000000b00319790e3bc5mr3610158wrs.41.1693651799187;
        Sat, 02 Sep 2023 03:49:59 -0700 (PDT)
Received: from gmail.com (1F2EF6A2.nat.pool.telekom.hu. [31.46.246.162])
        by smtp.gmail.com with ESMTPSA id r12-20020adfce8c000000b00317afc7949csm8066467wrn.50.2023.09.02.03.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Sep 2023 03:49:58 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sat, 2 Sep 2023 12:49:56 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Yi Sun <yi.sun@intel.com>
Cc:     dave.hansen@intel.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        sohil.mehta@intel.com, ak@linux.intel.com,
        ilpo.jarvinen@linux.intel.com, heng.su@intel.com,
        tony.luck@intel.com, dave.hansen@linux.intel.com,
        yi.sun@intel.intel.com
Subject: Re: [PATCH v6 1/3] x86/fpu: Measure the Latency of XSAVES and XRSTORS
Message-ID: <ZPMTVNM2oBCdSYjJ@gmail.com>
References: <20230901143414.1664368-1-yi.sun@intel.com>
 <20230901143414.1664368-2-yi.sun@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230901143414.1664368-2-yi.sun@intel.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Yi Sun <yi.sun@intel.com> wrote:

> +#define XSTATE_XSAVE(fps, lmask, hmask, err)				\
> +	do {								\
> +		struct fpstate *f = fps;				\
> +		u64 tc = -1;						\
> +		if (xsave_tracing_enabled())				\
> +			tc = trace_clock();				\
> +		__XSTATE_XSAVE(&f->regs.xsave, lmask, hmask, err);	\
> +		if (xsave_tracing_enabled())				\
> +			trace_x86_fpu_latency_xsave(f, trace_clock() - tc);\
> +	} while (0)
> +
>  /*
>   * Use XRSTORS to restore context if it is enabled. XRSTORS supports compact
>   * XSAVE area format.
>   */
> -#define XSTATE_XRESTORE(st, lmask, hmask)				\
> +#define __XSTATE_XRESTORE(st, lmask, hmask)				\
>  	asm volatile(ALTERNATIVE(XRSTOR,				\
>  				 XRSTORS, X86_FEATURE_XSAVES)		\
>  		     "\n"						\
> @@ -140,6 +168,17 @@ static inline u64 xfeatures_mask_independent(void)
>  		     : "D" (st), "m" (*st), "a" (lmask), "d" (hmask)	\
>  		     : "memory")
>  
> +#define XSTATE_XRESTORE(fps, lmask, hmask)				\
> +	do {								\
> +		struct fpstate *f = fps;				\
> +		u64 tc = -1;						\
> +		if (xrstor_tracing_enabled())				\
> +			tc = trace_clock();				\
> +		__XSTATE_XRESTORE(&f->regs.xsave, lmask, hmask);	\
> +		if (xrstor_tracing_enabled())				\
> +			trace_x86_fpu_latency_xrstor(f, trace_clock() - tc);\
> +	} while (0)
> +
>  #if defined(CONFIG_X86_64) && defined(CONFIG_X86_DEBUG_FPU)
>  extern void xfd_validate_state(struct fpstate *fpstate, u64 mask, bool rstor);
>  #else
> @@ -184,7 +223,7 @@ static inline void os_xsave(struct fpstate *fpstate)
>  	WARN_ON_FPU(!alternatives_patched);
>  	xfd_validate_state(fpstate, mask, false);
>  
> -	XSTATE_XSAVE(&fpstate->regs.xsave, lmask, hmask, err);
> +	XSTATE_XSAVE(fpstate, lmask, hmask, err);
>  
>  	/* We should never fault when copying to a kernel buffer: */
>  	WARN_ON_FPU(err);
> @@ -201,7 +240,7 @@ static inline void os_xrstor(struct fpstate *fpstate, u64 mask)
>  	u32 hmask = mask >> 32;
>  
>  	xfd_validate_state(fpstate, mask, true);
> -	XSTATE_XRESTORE(&fpstate->regs.xsave, lmask, hmask);
> +	XSTATE_XRESTORE(fpstate, lmask, hmask);
>  }

Instead of adding overhead to the regular FPU context saving/restoring code 
paths, could you add a helper function that has tracing code included, but 
which isn't otherwise used - and leave the regular code with no tracing 
overhead?

This puts a bit of a long-term maintenance focus on making sure that the 
traced functionality won't bitrot, but I'd say that's preferable to adding 
tracing overhead.

Thanks,

	Ingo

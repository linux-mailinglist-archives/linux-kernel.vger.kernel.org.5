Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECB57A1D56
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 13:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234001AbjIOLXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 07:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjIOLXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 07:23:01 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE64C1AB
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 04:22:56 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-401ec23be82so20991825e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 04:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694776975; x=1695381775; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fCZPvKJZFLYsRKxBEXIvSXuAd3mfyz+vRzHl+fPG8MY=;
        b=Ho4Os4fue8m/1Fx9QHfplA7j4Xy9Dq9BnSmeONCy/Hhd16kO9zGh8HYud+q5ZhO6yL
         6VPC3CQiBCvzbWj987MYIZUIcdtE525JY3OVuDI9Rk2culNVEm27UeMaOQUqPVwOP1Fo
         Y8/4dtsoSJoT2sHlfHPzSNk0Wb8sMmRDOIMcYhVCqJFGbGwI0PXeDx8NkKmYS+B1vsfw
         sssDTLZpk4SQWyShDmmpw//I+rZu8moLr7MgsRRFuSBG6NLc3DZj/qsiNd7W2roQCU+j
         VxDC9SEaNjMVhiaE6Ev/+z8bYWg81c7CBysfIFZH4vM+rs3d60LnQJhOjWBFKKB3jt4K
         7CWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694776975; x=1695381775;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fCZPvKJZFLYsRKxBEXIvSXuAd3mfyz+vRzHl+fPG8MY=;
        b=uCCA69bCuXxKhwxZs/AmvsRg54ARWYuNVZRJUAFMPhHoJ+mIcAiteoIjP6uIXC3AmD
         QY1AKUmKAvHREhQiQifYPRkwCEvBnXWXFA++0t5Nbmw/jQmktThSDsR0hTLlmE4/iiak
         tbT/isYHj6qJtItqcu5UdSTdEGTYWfVLitiSnGqhgiqJivx0FUP3hgmc0MHPMrpCOXY0
         86QhsLjTHCEHQafWcAKcSXspxtK59blLPWI1meiNcQwUGQ2kXTIUGk5HwvRPWZ2BmS46
         kfNj2MjYX6D9ScXjFkKFi2Uqg7WVxzCC1M6ujcV0y5HGXt8MPpD10FaK6Bv3/++AWhtR
         jNFw==
X-Gm-Message-State: AOJu0Yw49px6u9GlwSxarYTpZVOUU3/stoz5DWD3lqH9X/ATWuoNVgsX
        NCXBd4cIQmx8halepBbf4Mk=
X-Google-Smtp-Source: AGHT+IFnGW5dp3zhCTdpYIaDBV1kseyK2epSygpwjQ86f1UcDudDJA8hF4uDKAM4II2OiMFAHJ/iag==
X-Received: by 2002:a7b:ce07:0:b0:401:bdd7:499d with SMTP id m7-20020a7bce07000000b00401bdd7499dmr1290628wmc.25.1694776975183;
        Fri, 15 Sep 2023 04:22:55 -0700 (PDT)
Received: from gmail.com (1F2EF265.nat.pool.telekom.hu. [31.46.242.101])
        by smtp.gmail.com with ESMTPSA id m10-20020a7bce0a000000b003fee53feab5sm4394256wmc.10.2023.09.15.04.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 04:22:54 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 15 Sep 2023 13:22:52 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 2/2] x86/percpu: Use raw_cpu_try_cmpxchg in
 preempt_count_set
Message-ID: <ZQQ+jKenSo6cgMeN@gmail.com>
References: <20230830151623.3900-1-ubizjak@gmail.com>
 <20230830151623.3900-2-ubizjak@gmail.com>
 <ZQQoHWkJ5or/K7UH@gmail.com>
 <ZQQ817oApcALz9jy@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQQ817oApcALz9jy@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Ingo Molnar <mingo@kernel.org> wrote:
> 
> > 
> > * Uros Bizjak <ubizjak@gmail.com> wrote:
> > 
> > > Use raw_cpu_try_cmpxchg instead of raw_cpu_cmpxchg (*ptr, old, new) == old.
> > > x86 CMPXCHG instruction returns success in ZF flag, so this change saves a
> > > compare after cmpxchg (and related move instruction in front of cmpxchg).
> > > 
> > > Also, raw_cpu_try_cmpxchg implicitly assigns old *ptr value to "old" when
> > > cmpxchg fails. There is no need to re-read the value in the loop.
> > > 
> > > No functional change intended.
> > > 
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: Ingo Molnar <mingo@redhat.com>
> > > Cc: Borislav Petkov <bp@alien8.de>
> > > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > > Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> > > ---
> > >  arch/x86/include/asm/preempt.h | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/arch/x86/include/asm/preempt.h b/arch/x86/include/asm/preempt.h
> > > index 2d13f25b1bd8..4527e1430c6d 100644
> > > --- a/arch/x86/include/asm/preempt.h
> > > +++ b/arch/x86/include/asm/preempt.h
> > > @@ -31,11 +31,11 @@ static __always_inline void preempt_count_set(int pc)
> > >  {
> > >  	int old, new;
> > >  
> > > +	old = raw_cpu_read_4(pcpu_hot.preempt_count);
> > >  	do {
> > > -		old = raw_cpu_read_4(pcpu_hot.preempt_count);
> > >  		new = (old & PREEMPT_NEED_RESCHED) |
> > >  			(pc & ~PREEMPT_NEED_RESCHED);
> > > -	} while (raw_cpu_cmpxchg_4(pcpu_hot.preempt_count, old, new) != old);
> > > +	} while (!raw_cpu_try_cmpxchg_4(pcpu_hot.preempt_count, &old, new));
> > 
> > It would be really nice to have a before/after comparison of generated 
> > assembly code in the changelog, to demonstrate the effectiveness of this 
> > optimization.
> 
> Never mind, you did exactly that in the September 6 variation of these 
> changes. I'll apply those.

I mean, this third patch of yours:

   [PATCH] x86/percpu: Define {raw,this}_cpu_try_cmpxchg{64,128}

Had a proper disassembly comparison - so I've applied all 3 optimization 
patches to tip:x86/asm as:

  b8e3dfa16ec5 ("x86/percpu: Use raw_cpu_try_cmpxchg() in preempt_count_set()")
  5f863897d964 ("x86/percpu: Define raw_cpu_try_cmpxchg and this_cpu_try_cmpxchg()")
  54cd971c6f44 ("x86/percpu: Define {raw,this}_cpu_try_cmpxchg{64,128}")

Thanks,

	Ingo

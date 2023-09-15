Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDB17A1D3A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 13:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233188AbjIOLPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 07:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbjIOLPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 07:15:47 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B531BF
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 04:15:40 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-31aec0a1a8bso1328522f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 04:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694776539; x=1695381339; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qk/FijrZBqF14qcLhaLuag4OEieqki7GgwoaTvwFh3I=;
        b=WnTenQ5hS4s+aJDNTI15k1smihROvyu8KUZ2PafzIEt7FtPDgM55OvulOqKERDeUA+
         mkTwu3h6Vip5wP/dPuJP9kcJGgyp82+jzFKiywr1dKgdGp9HVxmYnKtRMxmE9QVUq/vz
         qrUwtx8SxQ0hXn0xvSgy6FSLLkAde8pqrhQWXdgKhhMi1VPyx4MqPkzZw3sinnJCkOT4
         USlh0YYOZg8el17cFw0i3R7+pVSqo9VDrjlAIPoYq/RsKPkIi7GQcqSU5/i+f185C9Lb
         wPmqve2etMNItgb11RAOV7gKb+QQiirJT+pi0YLVEHZLf8AthxL61PP+3UJ+J0Q0FJQg
         c1Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694776539; x=1695381339;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qk/FijrZBqF14qcLhaLuag4OEieqki7GgwoaTvwFh3I=;
        b=mICZA+LRNNWlqmMvEaQopMh8Ig83QD5XMmsIx4l27UL+ykIilyBY1i6BV1lGXO9dto
         5G2kBoeRDoT6v19YuVzs1zm88D2zMpgkttD6yyYbFTB4nZIPfV8nk00oDnnGi/L5NyzF
         /o2GkaaY1cM/87ds/8FC8qBDx15QTjGAV/wkNqbI4dd3JAG7pn4gO4woJzjExMaq25l3
         N9CWYoTmLI+qtcoVs9ZVneJ2v1WcCCL310ZZEv+qyDxkRSXw1BFqq80FyexfQjNwNUSn
         jOpvXuu7BDxugJdhUOVKn3iy0nJ/ea85sjDGDXqwj2pcDdUhYpQpeltQNOwz8K+znHsx
         ldzw==
X-Gm-Message-State: AOJu0Ywod2SfZQvblwTm+Dbi3DDCKiCFcz7TuR95Cs84OlgunhsHeIMX
        kfbjcKvYvt7QNdLgc4XIWzY=
X-Google-Smtp-Source: AGHT+IHHR7071Lofsum0pnMAwHBLUJw+J3zW5LV0ooMobbEvwoQ17UGo6FfniAJGbwclNoqdmmLITg==
X-Received: by 2002:adf:fc42:0:b0:31f:d8be:a313 with SMTP id e2-20020adffc42000000b0031fd8bea313mr965395wrs.5.1694776538932;
        Fri, 15 Sep 2023 04:15:38 -0700 (PDT)
Received: from gmail.com (1F2EF265.nat.pool.telekom.hu. [31.46.242.101])
        by smtp.gmail.com with ESMTPSA id k15-20020a5d628f000000b0031f729d883asm4150018wru.42.2023.09.15.04.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 04:15:37 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 15 Sep 2023 13:15:35 +0200
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
Message-ID: <ZQQ817oApcALz9jy@gmail.com>
References: <20230830151623.3900-1-ubizjak@gmail.com>
 <20230830151623.3900-2-ubizjak@gmail.com>
 <ZQQoHWkJ5or/K7UH@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQQoHWkJ5or/K7UH@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Uros Bizjak <ubizjak@gmail.com> wrote:
> 
> > Use raw_cpu_try_cmpxchg instead of raw_cpu_cmpxchg (*ptr, old, new) == old.
> > x86 CMPXCHG instruction returns success in ZF flag, so this change saves a
> > compare after cmpxchg (and related move instruction in front of cmpxchg).
> > 
> > Also, raw_cpu_try_cmpxchg implicitly assigns old *ptr value to "old" when
> > cmpxchg fails. There is no need to re-read the value in the loop.
> > 
> > No functional change intended.
> > 
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> > ---
> >  arch/x86/include/asm/preempt.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/x86/include/asm/preempt.h b/arch/x86/include/asm/preempt.h
> > index 2d13f25b1bd8..4527e1430c6d 100644
> > --- a/arch/x86/include/asm/preempt.h
> > +++ b/arch/x86/include/asm/preempt.h
> > @@ -31,11 +31,11 @@ static __always_inline void preempt_count_set(int pc)
> >  {
> >  	int old, new;
> >  
> > +	old = raw_cpu_read_4(pcpu_hot.preempt_count);
> >  	do {
> > -		old = raw_cpu_read_4(pcpu_hot.preempt_count);
> >  		new = (old & PREEMPT_NEED_RESCHED) |
> >  			(pc & ~PREEMPT_NEED_RESCHED);
> > -	} while (raw_cpu_cmpxchg_4(pcpu_hot.preempt_count, old, new) != old);
> > +	} while (!raw_cpu_try_cmpxchg_4(pcpu_hot.preempt_count, &old, new));
> 
> It would be really nice to have a before/after comparison of generated 
> assembly code in the changelog, to demonstrate the effectiveness of this 
> optimization.

Never mind, you did exactly that in the September 6 variation of these 
changes. I'll apply those.

Thanks,

	Ingo

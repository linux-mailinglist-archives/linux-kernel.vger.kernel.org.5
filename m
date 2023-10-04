Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6ADA7B8584
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 18:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243449AbjJDQkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 12:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233684AbjJDQku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 12:40:50 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07AF8AB
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 09:40:47 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9b2cee55056so3103766b.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 09:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696437645; x=1697042445; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j7nrS7h1c5kJRtH/fsc8FkvBlZl/ybH9lqaL9mHamzs=;
        b=ACSsUgYAfY/ktkNMgzds7EMJBbyKbjyYUzme90vmDd/kjOzQSP8jvRHVOF5MoDZaC4
         yARMOElfaN+ocOrt9lKSffWZDxRuj/eUojf9YH063cTHwQEhy9wIBM0m2JX+9UCPHGn8
         L3VUGnCncUOkT7RZLRspr0+VMtNtStWxyC7y1rll+q4f8SXT5Zn9ARdowfnCfpZ7znJG
         p++Yaq+I7C79u7lTnHxoo/8ykqGp+DibzOPSdXAM02TTj5lHKpetfbRDwZ0xh+qX9sTq
         XspmMzhLJ2jvO0bO1SXa0NxI5g/rvzHiL2WRDC1nfp4RXG/AcKQlHuTRo5S3YW56vIDr
         F4aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696437645; x=1697042445;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j7nrS7h1c5kJRtH/fsc8FkvBlZl/ybH9lqaL9mHamzs=;
        b=RCv8Jb2U80OTSMuWGPXAXdJKsBq0BzEL+mP4MVBOzGFio+ClFBKRhsReR/yPJI3ccN
         I8Dbkd1CzI0jl1Ubiwv0C4SawZKsFHa8Gh1LYRb2CfUjQ1DXgZ82LOPy56wpCtL3bHWa
         5nj9ElcQ9HXHSSuj3GaFfBZYTww44bDjyyyLkrFzUDSpwhHbXP4nsfSuMA5huVJQuUyH
         GDytnVuf4onTbiPt/4dAZWor+f0O2UgCYWpIox5PuM/R6jOIGUD0lUcP1GbmHv9ZQ2Zq
         PgJAdM0TjbziATs2pa0MgytYbiwAMb5PQstOJKJsMmmHuZ+SZ2E13X/DnWbILwWeNCAP
         iQ9A==
X-Gm-Message-State: AOJu0YwzaMxcGH6v7hi3MvwDV334FY6s119tHczgJalfdt7/ZWXy3e2G
        1w1cdajE/LntMWqAQwWTQLk=
X-Google-Smtp-Source: AGHT+IEDzulVPNNuJtz8jR+NEpbySMBb220XfZx1lDc10tCOd9sb1aYNMvHlTXJf/9GbeN0juD0Tew==
X-Received: by 2002:a17:906:9c2:b0:9b2:82d2:a2db with SMTP id r2-20020a17090609c200b009b282d2a2dbmr2472912eje.28.1696437645140;
        Wed, 04 Oct 2023 09:40:45 -0700 (PDT)
Received: from gmail.com (1F2EF530.nat.pool.telekom.hu. [31.46.245.48])
        by smtp.gmail.com with ESMTPSA id cf26-20020a170906b2da00b0099cb0a7098dsm3080318ejb.19.2023.10.04.09.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 09:40:44 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 4 Oct 2023 18:40:42 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Nadav Amit <namit@vmware.com>, Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH 4/4] x86/percpu: Use C for percpu read/write accessors
Message-ID: <ZR2VitjPb6Miksim@gmail.com>
References: <20231004145137.86537-1-ubizjak@gmail.com>
 <20231004145137.86537-5-ubizjak@gmail.com>
 <ZR2U4DLycLT5xFH6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZR2U4DLycLT5xFH6@gmail.com>
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
> > The percpu code mostly uses inline assembly. Using segment qualifiers
> > allows to use C code instead, which enables the compiler to perform
> > various optimizations (e.g. propagation of memory arguments). Convert
> > percpu read and write accessors to C code, so the memory argument can
> > be propagated to the instruction that uses this argument.
> > 
> > Some examples of propagations:
> > 
> > a) into sign/zero extensions:
> > 
> >  110b54:       65 0f b6 05 00 00 00    movzbl %gs:0x0(%rip),%eax
> >  11ab90:       65 0f b6 15 00 00 00    movzbl %gs:0x0(%rip),%edx
> >  14484a:       65 0f b7 35 00 00 00    movzwl %gs:0x0(%rip),%esi
> >  1a08a9:       65 0f b6 43 78          movzbl %gs:0x78(%rbx),%eax
> >  1a08f9:       65 0f b6 43 78          movzbl %gs:0x78(%rbx),%eax
> > 
> >  4ab29a:       65 48 63 15 00 00 00    movslq %gs:0x0(%rip),%rdx
> >  4be128:       65 4c 63 25 00 00 00    movslq %gs:0x0(%rip),%r12
> >  547468:       65 48 63 1f             movslq %gs:(%rdi),%rbx
> >  5474e7:       65 48 63 0a             movslq %gs:(%rdx),%rcx
> >  54d05d:       65 48 63 0d 00 00 00    movslq %gs:0x0(%rip),%rcx
> 
> Could you please also quote a 'before' assembly sequence, at least once
> per group of propagations?

Ie. for any changes to x86 code generation, please follow the changelog 
format of:

   7c097ca50d2b ("x86/percpu: Do not clobber %rsi in percpu_{try_,}cmpxchg{64,128}_op")

   ...
	Move the load of %rsi outside inline asm, so the compiler can
	reuse the value. The code in slub.o improves from:

	    55ac:	49 8b 3c 24          	mov    (%r12),%rdi
	    55b0:	48 8d 4a 40          	lea    0x40(%rdx),%rcx
	    55b4:	49 8b 1c 07          	mov    (%r15,%rax,1),%rbx
	    55b8:	4c 89 f8             	mov    %r15,%rax
	    55bb:	48 8d 37             	lea    (%rdi),%rsi
	    55be:	e8 00 00 00 00       	callq  55c3 <...>
				55bf: R_X86_64_PLT32	this_cpu_cmpxchg16b_emu-0x4
	    55c3:	75 a3                	jne    5568 <...>
	    55c5:	...

	 0000000000000000 <.altinstr_replacement>:
	   5:	65 48 0f c7 0f       	cmpxchg16b %gs:(%rdi)

	to:

	    55ac:	49 8b 34 24          	mov    (%r12),%rsi
	    55b0:	48 8d 4a 40          	lea    0x40(%rdx),%rcx
	    55b4:	49 8b 1c 07          	mov    (%r15,%rax,1),%rbx
	    55b8:	4c 89 f8             	mov    %r15,%rax
	    55bb:	e8 00 00 00 00       	callq  55c0 <...>
				55bc: R_X86_64_PLT32	this_cpu_cmpxchg16b_emu-0x4
	    55c0:	75 a6                	jne    5568 <...>
	    55c2:	...

	Where the alternative replacement instruction now uses %rsi:

	 0000000000000000 <.altinstr_replacement>:
	   5:	65 48 0f c7 0e       	cmpxchg16b %gs:(%rsi)

	The instruction (effectively a reg-reg move) at 55bb: in the original
	assembly is removed. Also, both the CALL and replacement CMPXCHG16B
	are 5 bytes long, removing the need for NOPs in the asm code.
   ...

Thanks,

	Ingo

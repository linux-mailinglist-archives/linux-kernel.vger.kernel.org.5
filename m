Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803307BDA4A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 13:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346324AbjJILwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 07:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346281AbjJILwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 07:52:01 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADF894
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 04:51:59 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40651a72807so43107515e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 04:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696852318; x=1697457118; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QXAKj/7AkzuxGnbV+WvDfr1ujwsq/S+2CpiuERLuNt8=;
        b=QynhCd4PT10MWGPxJGkPaRiGlbSWlh9MS4GbsazuEtYr8joKRRfVhyjsePRhWiIond
         +q4Z6wezdgZRsRfj37BojshSVAY1k5im62kRarBxN1h0SLjYZz07cpGtW1CHdX+jeLv0
         ejYZ6zeZjjm90NgYfIUqgKRZYdzmreEjfckkT1EwbReNbqLw8DxVMnb4GPBWczM+f5tQ
         38guPIxlrtSrMaNX7GBqR3yl6djwYMeWjc11wzYZG8VwBXFzXxOVQlR9MN/lSOANf+uE
         HUIGN6+h5xVFo3RSkH9XSyLhKwr8w7ctFsKo6Ymz318XosJBTzq/1zkfJHSD+wtctyyc
         8ofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696852318; x=1697457118;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QXAKj/7AkzuxGnbV+WvDfr1ujwsq/S+2CpiuERLuNt8=;
        b=kdYCYC3s9a2Rfy8DZ+GtzbaTn8N+4RydkxOTlU3bR7kZ/Hr5b9a2vzzCS7nIpZyev3
         OlWq9RsGC/to+cRsSa2yauIRjdVFVtsfnAcxuDnF+8fwS96YTpi7dNNZZ3Akqt3bBA3F
         4VNr/GZiiWPCq5WfagD6OM4fIKSO8WicUpf/KsPNcYRBwOOUyiL6pW9JWF+ugRN2tTaj
         A41tkyyFY0ngFxPvqtyyYr9dN99pdFPMnrVgYcd1xtIfh2tBgUezmQMlCORjoVYRq44E
         niaNhOTK3XjfEu7KE+WnDCBx7fDbiZsqLGNddau0x7Y+FcDUtYRg5QJQVY16a+GaSdQg
         pw5Q==
X-Gm-Message-State: AOJu0YyCdLo/erXOrT/pw8YCSahCWT99SlrjOlcDx7ON1e6bqUWGPSaX
        +/xX6hrmFBRXMlpq3XhTDpviMj8VWtQ=
X-Google-Smtp-Source: AGHT+IGOZK+YFEV9b54mBSE/b9qRn4NNDY/nyS9aWduygpYQIxFHEqNyvZarUG0WIBziOPSPU8g11g==
X-Received: by 2002:a05:600c:2b0e:b0:406:848f:8711 with SMTP id y14-20020a05600c2b0e00b00406848f8711mr13425463wme.21.1696852317947;
        Mon, 09 Oct 2023 04:51:57 -0700 (PDT)
Received: from gmail.com (1F2EF237.nat.pool.telekom.hu. [31.46.242.55])
        by smtp.gmail.com with ESMTPSA id o13-20020a05600c378d00b004063cd8105csm13149363wmr.22.2023.10.09.04.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 04:51:57 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 9 Oct 2023 13:51:55 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Nadav Amit <namit@vmware.com>, Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH 4/4] x86/percpu: Use C for percpu read/write accessors
Message-ID: <ZSPpW3zLTn7IohOJ@gmail.com>
References: <20231004145137.86537-1-ubizjak@gmail.com>
 <20231004145137.86537-5-ubizjak@gmail.com>
 <CAHk-=wgepFm=jGodFQYPAaEvcBhR3-f_h1BLBYiVQsutCwCnUQ@mail.gmail.com>
 <CAFULd4YWjxoSTyCtMN0OzKgHtshMQOuMH1Z0n_OaWKVnUjy2iA@mail.gmail.com>
 <CAHk-=whq=+LNHmsde8LaF4pdvKxqKt5GxW+Tq+U35_aDcV0ADg@mail.gmail.com>
 <CAHk-=wi6U-O1wdPOESuCE6QO2OaPu0hEzaig0uDOU4L5CREhug@mail.gmail.com>
 <CAFULd4Z3C771u8Y==8h6hi=mhGmy=7RJRAEBGfNZ0SmynxF41g@mail.gmail.com>
 <ZSPm6Z/lTK1ZlO8m@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSPm6Z/lTK1ZlO8m@gmail.com>
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
> * Uros Bizjak <ubizjak@gmail.com> wrote:
> 
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index ecb256954351..1edf4a5b93ca 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -2393,7 +2393,7 @@ config CC_HAS_NAMED_AS
> >  
> >  config USE_X86_SEG_SUPPORT
> >  	def_bool y
> > -	depends on CC_HAS_NAMED_AS && SMP
> > +	depends on CC_HAS_NAMED_AS && SMP && !KASAN
> > +	depends on CC_HAS_NAMED_AS && SMP && !KASAN
> 
> So I'd rather express this as a Kconfig quirk line, and explain each quirk.
> 
> Something like:
> 
> 	depends on CC_HAS_NAMED_AS
> 	depends on SMP
> 	#
> 	# -fsanitize=kernel-address (KASAN) is at the moment incompatible
> 	# with named address spaces - see GCC bug #12345.
> 	#
> 	depends on !KASAN
> 
> ... or so.

BTW., while this OK for testing, this is too heavy handed for release 
purposes, so please only disable the KASAN instrumentation for the affected 
percpu accessors.

See the various __no_sanitize* attributes available.

I'd even suggest introducing a new attribute variant, specific to x86, 
prefixed with __no_sanitize_x86_seg or so, which would allow the eventual 
KASAN-instrumentation of the percpu accessors once the underlying GCC bug 
is fixed.

Thanks,

	Ingo

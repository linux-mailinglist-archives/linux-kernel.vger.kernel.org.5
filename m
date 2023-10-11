Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE9F17C5EA3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 22:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233369AbjJKUpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 16:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbjJKUpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 16:45:38 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA0C90;
        Wed, 11 Oct 2023 13:45:32 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so2964548a12.1;
        Wed, 11 Oct 2023 13:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697057131; x=1697661931; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vF57FMszPTH1ctRnfsdLQnAKN0gbFWDA+OoyuLf2Za4=;
        b=QOl1XQCGqCDmVe+7+G2i/qpDo2eLxm8n+LB22qwIaIWmPbYqsHEfrfv9s7Efl3QL7D
         rGgV7/mb/pnyRqaL8RtiLJzZiYyRJYvK/DbXE7q09rkwY+p9skReWcsyQydwWse5hTjg
         A04XQaBgATYj9SqkN11/O1hlGW3Wz22BenYH6EmeoyJTydFC0w+NDtyIiJF5yawG/HeL
         eReTkLrgkEGZI5DDxWA/Fa3CVFgZMKTlrZVuYTNVdMjqV0FrUaLinHBUANB64og8oTll
         2r2F9GxpgIaqcQdeu7gdq6wOwM7u1itH/N1gplsFxVjJrYnpBgLUDIh52wE/UBmgIPJf
         oUTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697057131; x=1697661931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vF57FMszPTH1ctRnfsdLQnAKN0gbFWDA+OoyuLf2Za4=;
        b=dJc7HHwKQr7xxmyHkRwudHi6O+hGLfFTOOojW5njB5mCBk7Y7TvcUIukywj7PYQH6X
         2aNt7K0atiIGLU9N/mNGP1JqIb0UoM9sxkE96tm2pWcoE+aP9YRdaQeVO0PAwdVYNQty
         eVoKQ8ERZNr71zLxQQxEuERAUYsyMukixgaT2LxmiXfQq86pNb7s6SgVrUmgsICf75vX
         W2V2qLH/ovGG/1YPsildYd+ocwVbFnm1uJEQKJx9Jqs9O9ka5aZxj+ontbmom8sFFJne
         PsRNpbCXHau6Wv/AvMaPSzA6EBe6wgWX3gqduXWT/YBUkTLtltzhGfAG0rbnEH8mKw7X
         6NNg==
X-Gm-Message-State: AOJu0Yyoegmk0wV0542mDOIwkHoFOHOaele2Kgr2rJaCG1rsFkv99UmV
        JJOZGEcGVDyVLjmXCJFROoA=
X-Google-Smtp-Source: AGHT+IFu/1J1GJc5CjpzfN0/U/wBjhVReW2ZSV11oOnQm2il+laGaU0uZhiHb43XjK7sapTmyFuPrQ==
X-Received: by 2002:a17:907:7f86:b0:9ae:50ec:bd81 with SMTP id qk6-20020a1709077f8600b009ae50ecbd81mr16519816ejc.21.1697057130688;
        Wed, 11 Oct 2023 13:45:30 -0700 (PDT)
Received: from gmail.com (1F2EF405.nat.pool.telekom.hu. [31.46.244.5])
        by smtp.gmail.com with ESMTPSA id j17-20020a170906831100b009a16975ee5asm10059245ejx.169.2023.10.11.13.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 13:45:30 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 11 Oct 2023 22:45:27 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Fei Yang <fei.yang@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCHv2] x86/alternatives: Disable KASAN in apply_alternatives()
Message-ID: <ZScJZ7Uc6aJNyvRg@gmail.com>
References: <20231011065849.19075-1-kirill.shutemov@linux.intel.com>
 <20231011074616.GL14330@noisy.programming.kicks-ass.net>
 <20231011132703.3evo4ieradgyvgc2@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011132703.3evo4ieradgyvgc2@box.shutemov.name>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Kirill A. Shutemov <kirill.shutemov@linux.intel.com> wrote:

> On Wed, Oct 11, 2023 at 09:46:16AM +0200, Peter Zijlstra wrote:
> > On Wed, Oct 11, 2023 at 09:58:49AM +0300, Kirill A. Shutemov wrote:
> > > Fei has reported that KASAN triggers during apply_alternatives() on
> > > 5-level paging machine:
> > > 
> > 
> > Urgh @ KASAN splat, can't we summarize that?
> 
> What about this?
> 
> 	BUG: KASAN: out-of-bounds in rcu_is_watching
> 	Read of size 4 at addr ff110003ee6419a0 by task swapper/0/0
> 	...
> 	__asan_load4
> 	rcu_is_watching
> 	? text_poke_early
> 	trace_hardirqs_on
> 	? __asan_load4
> 	text_poke_early
> 	apply_alternatives
> 	...
> 
> Is it enough details or I overdid summarization?

No, that's perfect IMO. I'd even leave out the unreliable '?' entries:

> 	BUG: KASAN: out-of-bounds in rcu_is_watching
> 	Read of size 4 at addr ff110003ee6419a0 by task swapper/0/0
> 	...
> 	__asan_load4
> 	rcu_is_watching
> 	trace_hardirqs_on
> 	text_poke_early
> 	apply_alternatives
> 	...

... or so.

> 	/*
> 	 * In the case CONFIG_X86_5LEVEL=y, KASAN_SHADOW_START is defined using
> 	 * cpu_feature_enabled(X86_FEATURE_LA57) and is therefore patched here.
> 	 * During the process, KASAN becomes confused seeing partial LA57
> 	 * conversion and triggers a false-positive out-of-bound report.
> 	 *
> 	 * Disable KASAN until the patching is complete.
> 	 */
> 
> Looks good?

LGTM.

Thanks,

	Ingo

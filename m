Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E01377B53EF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 15:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237362AbjJBNW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 09:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237299AbjJBNWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 09:22:25 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC10AAD
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 06:22:21 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9b2a3fd5764so1350814766b.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 06:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696252940; x=1696857740; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BGYoLUnLzaZLpXUSHuD1x8imzBKWTH0+I6v2Ivt44T4=;
        b=i13BCMwzsY9p9EOY4c4Yu6G+0fwq0CXXp+g9lq6vI3H2ydS6yx8JY64R5UMecBC6V4
         LaWT1OCWWbLf+6Vw8AHp2PfxoeIChX94kiHKCS2PGgb9IiKoiXJngysN8s6GFm9mTJj8
         jvxaF/JpFxmFv7Qfg8L7BpXQ6DWLc6ivKk1aqbh+NyZi60Nd2r8xZSkKdx9KVx20JPSM
         5vu1qI5clP9/f6zNFdXdMxz2JIFE/JVaddrA1T3+uL+fTBLEQZbcj5goTjmLb9duPXpj
         izc+zjXxFoo75p91ByeXQZKkX0s5WyL3nf94XIYHiHaUAkK4AC0mG8um7ML2I2IWbeRv
         7QVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696252940; x=1696857740;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BGYoLUnLzaZLpXUSHuD1x8imzBKWTH0+I6v2Ivt44T4=;
        b=K6iVdLBnkyt/hCi7hagvjxm9D4jHNPG9WhWTK+fXOOYbLLbOSFchOAbSx6mM1DpA1i
         nw2QRgeBYw+v+bwRMPR2uOuxrscsauVFFnItf7pYGGmWWARQPUBdT5no9LQwajhmaM0v
         cHPoLS1Sn2EkKnztlIaazhxf640k2hDEyrUgH5rJCG5XYSt02MsvH66UZ7RPcYiaFeS9
         p18RRCTW0lZJbqQ1w611euDAi78uMaMftZvWz5Wtbe+DK6FxEIGSnLQsm7+NO4Eg0NhS
         e4sWXfl+GISY4uBeMQIiMjc/tYf64ttg9OD7HLEaNaG7vElw94molKClpuBGorNZQvU3
         5FMw==
X-Gm-Message-State: AOJu0Yxh/17VJ4oKXpo6QXLmqMGk/3XZRToGvgKCwp5bwGH75prDTezE
        xGxQtek84/r7gONLcgeOYTw=
X-Google-Smtp-Source: AGHT+IE8/5+M0ccoQYq73JpeAGFF0/4WT21sdXk6i5eMJcanJEj12URSUuPU6NNPucgV64Q5cVckvg==
X-Received: by 2002:a17:906:1010:b0:9aa:23c9:aa52 with SMTP id 16-20020a170906101000b009aa23c9aa52mr10751281ejm.20.1696252939911;
        Mon, 02 Oct 2023 06:22:19 -0700 (PDT)
Received: from gmail.com (1F2EF530.nat.pool.telekom.hu. [31.46.245.48])
        by smtp.gmail.com with ESMTPSA id fr33-20020a170906892100b009b2d46425absm5497166ejc.85.2023.10.02.06.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 06:22:19 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 2 Oct 2023 15:22:17 +0200
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
Subject: Re: [RFC PATCH 0/4] x86/percpu: Use segment qualifiers
Message-ID: <ZRrECdIoKCXALl39@gmail.com>
References: <20231001131620.112484-1-ubizjak@gmail.com>
 <CAHk-=wg6P8pPg-x4BPUQj-wE0xC7HkGzFk89ftuji8MVo+RRxw@mail.gmail.com>
 <CAFULd4Y+HXuditB51Q0LznqiBsvxJr3BjEYvx4_224XmqrycCw@mail.gmail.com>
 <CAHk-=wh+cfn58XxMLnG6dH+Eb9-2dYfABXJF2FtSZ+vfqVvWzA@mail.gmail.com>
 <CAFULd4atO8uy_5PbjV8vw-yk0tv_=4kh_JwJ+6Xq-2myStCnmw@mail.gmail.com>
 <CAFULd4YsPnCfw-NV_0ck1_za=WPc-FxYKV1bb99UcAwMJ=34YA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFULd4YsPnCfw-NV_0ck1_za=WPc-FxYKV1bb99UcAwMJ=34YA@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Uros Bizjak <ubizjak@gmail.com> wrote:

> > > Clang isn't much better, but at least it doesn't generate bad code. It
> > > just crashes with an internal compiler error on the above trivial
> > > test-case:
> > >
> > >     fatal error: error in backend: cannot lower memory intrinsic in
> > > address space 257
> > >
> > > which at least tells the user that they can't copy memory from that
> > > address space. But once again shows that no, this feature is not ready
> > > for prime-time.
> > >
> > > If literally the *first* thing I thought to test was this broken, what
> > > else is broken in this model?
> > >
> > > And no, the kernel doesn't currently do the above kinds of things.
> > > That's not the point. The point was "how well is this compiler support
> > > tested". The answer is "not at all".
> 
> I don't agree with the above claims. The generated code was the product 
> of a too limited selection of available copy algorithms in unusual 
> circumstances, but even in the case of generic fallback code, the 
> generated code was *correct*. As said in the previous post, and 
> re-confirmed by the patch in the PR, the same code in GCC handles 
> implicit (__thread) and named address spaces. At the end of the day, the 
> problematic code was merely a missing-optimization (the bug with the 
> lowest severity in GCC).

Yeah, so the feature generated really crappy code for Linus's
testcase. That's never a good sign for compiler features, full stop.

Do we want the kernel to be at the bleeding edge of an 
unusual compiler feature that is only used internally by the
compiler in a very specific fashion?

Maybe, but Linus's reluctance and caution is justified IMHO,
and at minimum this feature needs some careful evaluation of 
long-time suitability [*] ...

Thanks,

	Ingo


[*] euphemism for: "I have no idea how to evaluate this risk"... :-/

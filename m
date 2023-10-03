Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6BAE7B71F3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 21:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240940AbjJCToA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 15:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjJCTn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 15:43:59 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00EA093
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 12:43:55 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-5335725cf84so2181157a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 12:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696362234; x=1696967034; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rxvqNmKfHQ4xqmaDDDxOUVFilJfgdcdsdtg7CqYIp7M=;
        b=XWBLj3KAE+Apb+SYhi+nt7O+8Gc7y2U9HeukPJctfuJR5zJLS8SINvlNN7QB+h2auf
         N8duoXrPYi6LbeO9hBmNqNOAXwrec3yMuF0Q8wkQCFlqzbOKnm2R7M5lKfaRIaVlyPXd
         m49nPt4H/y71CS4UOhzkKgslB46AGDq/xgONX1ZLGH6rNfoQZb76lJO+h2dubrCEcw7O
         y2aEQjbl79typ/4ZhNTNLKMaChUbMRYnUiyzOUDaj1ya7OdN100dFT3jN4L4cAmOYcrz
         J801EkE3EjO0ZFZ812Ks0i7vydNiEaKP24IWERTkFPSYr8dZOEZCkpPNb2mU2uun3tVq
         0Yuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696362234; x=1696967034;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rxvqNmKfHQ4xqmaDDDxOUVFilJfgdcdsdtg7CqYIp7M=;
        b=vyoPb4NYPcRZ7y5xNCuYpcP8/JE4fk+8qrSaQ1Ik0fiFtp1AAEQrMua+ZdWke1Kywm
         s/4YtmK2pKIk6CXfQ0HEocOTOdLatACc0KORJBS3p1ukzGi7XPNq/UnbYYoIg4fchluJ
         1rea7Kc7itXENPeLxek8orgdyIxV23R9D61VKoMZqUQv5YLmHL1r+vDVGQsP0WhrimTh
         1P30UlazQtXijX5a4Veu3ndd5BfqSyj83JvfVSuaUW8Fehp2DE+hUovyYDYGSPaXRdzt
         uvY4a83ttPIHbMqD1vCfnTW9swr0A2XjW2uY7cBtZJYB4rtcp7OjiDMVLmMsDWHzCPRw
         l5fg==
X-Gm-Message-State: AOJu0Yym0KNWrGZeyQgb5i5Q/91BZWIZ4/y6cNoUFvyscUmvoPXuHJ6C
        S81gXn4MgJ0K48oUMUN9GCn5TdwPS2I=
X-Google-Smtp-Source: AGHT+IGsRk/CSAGSI9zKGvQCEBDdRcwaCjKGlaI9KhDNlNGuYfIOOcwwWCng/NilGDYMA69bObreMw==
X-Received: by 2002:a05:6402:6d4:b0:533:4c67:c911 with SMTP id n20-20020a05640206d400b005334c67c911mr147821edy.19.1696362234226;
        Tue, 03 Oct 2023 12:43:54 -0700 (PDT)
Received: from gmail.com (1F2EF530.nat.pool.telekom.hu. [31.46.245.48])
        by smtp.gmail.com with ESMTPSA id w10-20020a056402128a00b00536031525e5sm1285990edv.91.2023.10.03.12.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 12:43:53 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 3 Oct 2023 21:43:51 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Uros Bizjak <ubizjak@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Nadav Amit <namit@vmware.com>, Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [RFC PATCH 0/4] x86/percpu: Use segment qualifiers
Message-ID: <ZRxu9+ZJqjY/u8ku@gmail.com>
References: <20231001131620.112484-1-ubizjak@gmail.com>
 <CAHk-=wg6P8pPg-x4BPUQj-wE0xC7HkGzFk89ftuji8MVo+RRxw@mail.gmail.com>
 <CAFULd4Y+HXuditB51Q0LznqiBsvxJr3BjEYvx4_224XmqrycCw@mail.gmail.com>
 <CAHk-=wh+cfn58XxMLnG6dH+Eb9-2dYfABXJF2FtSZ+vfqVvWzA@mail.gmail.com>
 <CAFULd4atO8uy_5PbjV8vw-yk0tv_=4kh_JwJ+6Xq-2myStCnmw@mail.gmail.com>
 <CAFULd4YsPnCfw-NV_0ck1_za=WPc-FxYKV1bb99UcAwMJ=34YA@mail.gmail.com>
 <ZRrECdIoKCXALl39@gmail.com>
 <CAFULd4bBzAWoY7MDQN+YV5tpw7vDitFNMuSVt53KGofdZRvTpg@mail.gmail.com>
 <ZRwZOtANkcwtL+5B@gmail.com>
 <CAHk-=wi2d159z-KgZTAk52GZHB8=B-HZ-fQ_890fN7CL6Yt89g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi2d159z-KgZTAk52GZHB8=B-HZ-fQ_890fN7CL6Yt89g@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Tue, 3 Oct 2023 at 06:38, Ingo Molnar <mingo@kernel.org> wrote:
> >
> > So I don't think it's a good idea to restrict it to the devel GCC version
> > only, the cross-section of devel-GCC and devel-kernel reduces testing
> > coverage to near-zero in practice ...
> 
> In fact, while the clang failure was arguably worse from a code
> generation standpoint (as in "it didn't generate any code AT ALL"), it
> was actually better from a kernel standpoint: I'd *much* rather have a
> compile-time failure than bad code generation when it's a particular
> issue that we can avoid by just not doing it.
> 
> IOW, *if* this is the only actual issue with named address spaces,
> then I'd much rather have a compiler that says "don't do that" over a
> compiler that silently generates absolutely horrendous code.
> 
> That is not unlike my "I'd rather get a link time error from trying to
> do a 64-by-64 divide on x86-32, than have the compiler actually
> generate that horrendously expensive operation". There's a reason we
> have "do_div64()" to do 64-by-32 divides, because that's usually what
> you actually want.
> 
> We should not be doing big structure copies from or to the percpu
> area, so clang then failing with an admittedly horrendous error
> message is not a bad thing.
> 
> And again - my worry really isn't this "copy a percpu structure"
> issue. It's literally just that I feel this doesn't have a lot of
> coverage.

I share all those concerns.

So we could do this: we let it live in -tip for a cycle, in a separate
branch, and observe what happens - it gets picked up by -next on
a daily basis and most x86 developers test it. It won't be merged by other
branches in -tip, it won't be pulled by others or relied on. If it
conflicts with other bits we rebase it cleanly, no questions asked.

While -next test coverage is still limited in many ways, it's also
certainly not zero.

If it's problem-free for a cycle I'll offer it up to you as an RFC pull,
summarizing our experience with it. (Should it ever get to that point.)

That's the best I think we can do - and worst-case we'll turn it off
again and go curse flaky compiler features. Will be easy to turn off
if it's compiler version triggered anyway.

Thanks,

	Ingo

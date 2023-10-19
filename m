Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC2E7D014E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 20:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346413AbjJSSXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 14:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346411AbjJSSXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 14:23:01 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC21712A
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 11:22:58 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9bda758748eso151866b.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 11:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697739777; x=1698344577; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B+Dy0MUMF9MZCSycKOdW+CXIYj6FYRJemuf8QIgQ7dk=;
        b=T4D53ncIzJWVVkwMuFT4mG8nIEotQ5W1BrVJfdO3z4yE8LjvwJwOA89kOpH7A/EYsZ
         yZjtH3EpdevSntZ0znHxj9vuEeDBFkZq9LeQ8kCyLlJ8JXHvk/HOJeK8O2p17qiUZRMv
         Mx0LLwiyMbQ0NemO4ED8mvYbogOK3fupL4WBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697739777; x=1698344577;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B+Dy0MUMF9MZCSycKOdW+CXIYj6FYRJemuf8QIgQ7dk=;
        b=PmlIEwG48WLquip3Oaxj5cKLUiFiVTqwdNCNcnyFl7Dt3vjvARZu6wz9iXxb3tmwWQ
         QTuPtenFeiGltJH9fBOWxwuSJetG7d33fCBByGDiXGhskoJQiPA5k4GUFM2mPEm4wX6a
         mkJHRqCFKV+nHYds6i6nM4IAN+CEKaoNHJHGzs3WukKWXKrbUznx3kL92INlVs8qStiu
         cvk5xHprVLTM92yzGJ8mlIqPZh7wR6Wb4yh7rwu0eYM3uAtGPCK1jPO1RE4agj/q7NK9
         rAIPk05DKQwKNJXe2SHfZCCp/Q9Ro+CRlDv40xzkUFuQyOKd3Y1VUbfZ7KT4PCXv2jcV
         IGUw==
X-Gm-Message-State: AOJu0YxcwEMFIZiEiiWqcoIliCSQXX7KoJ3lmMrJELhp/GXH6m8nuGou
        Z0rV2acVY9VICuqp2EPrLMgBbrJx+9sl08/DaOTTl59e
X-Google-Smtp-Source: AGHT+IFXkIpoOS6lh+ZfYpdkYa3s1XCggdHNp9ChG6O/DblEPFD5tZ2Ttzn1WfsA6bigVLTZbeLJRw==
X-Received: by 2002:a17:907:3687:b0:9be:cdca:dae9 with SMTP id bi7-20020a170907368700b009becdcadae9mr2241620ejc.36.1697739777177;
        Thu, 19 Oct 2023 11:22:57 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id xa17-20020a170907b9d100b00982a92a849asm8374ejc.91.2023.10.19.11.22.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 11:22:56 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-9bda758748eso147766b.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 11:22:56 -0700 (PDT)
X-Received: by 2002:a17:907:983:b0:9ae:6ad0:f6db with SMTP id
 bf3-20020a170907098300b009ae6ad0f6dbmr2275816ejc.71.1697739776227; Thu, 19
 Oct 2023 11:22:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAFULd4autFT=96EckL9vUDgO5t0ESp27+NDVXQHGi7N=PAo-HQ@mail.gmail.com>
 <CAFULd4Zhw=zoDtir03FdPxJD15GZ5N=SV9=4Z45_Q_P9BL1rvQ@mail.gmail.com>
 <CAHk-=wgoWOcToLYbuL2GccbNXwj_MH-LxmB_7MMjw6uu50k57Q@mail.gmail.com>
 <CAHk-=wgCPbkf0Kdi=4T3LAVvNEH0jxJBWcTiBkrFDBsxkC9mKQ@mail.gmail.com>
 <CAFULd4aTY002A7NHRCX21aTpYOE=tnpouBk6hkoeWND=LnT4ww@mail.gmail.com>
 <CAHk-=wia9vFmyCJPkYg0vvegF8eojLy+DxVtpfoDv-UHoWKfqQ@mail.gmail.com>
 <CAFULd4Zj5hTvATZUVYhUGrxH3fiAUWjO9C27UV_USf2H164thQ@mail.gmail.com>
 <CAHk-=whEc2HR3En32uyAufPM3tEh8J4+dot6JyGW=Eg5SEhx7A@mail.gmail.com>
 <20231019085432.GQ33217@noisy.programming.kicks-ass.net> <CAHk-=wg98L2qaw1U-7NDFQi6dOK=CRO6H-1q1LXuEh348Dk=2Q@mail.gmail.com>
 <20231019181359.GA35308@noisy.programming.kicks-ass.net>
In-Reply-To: <20231019181359.GA35308@noisy.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 19 Oct 2023 11:22:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgHE-6z1CYGrZx0XSrPif+s7MuA+JZKCWWL5CvbdqWK+A@mail.gmail.com>
Message-ID: <CAHk-=wgHE-6z1CYGrZx0XSrPif+s7MuA+JZKCWWL5CvbdqWK+A@mail.gmail.com>
Subject: Re: [PATCH v2 -tip] x86/percpu: Use C for arch_raw_cpu_ptr()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Uros Bizjak <ubizjak@gmail.com>, Nadav Amit <namit@vmware.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Oct 2023 at 11:14, Peter Zijlstra <peterz@infradead.org> wrote:
>
> But are you really saying this_cpu_read() should not imply READ_ONCE()?

Well, Uros is saying that we may be *forced* to have that implication,
much as I really hate it (and wonder at the competence of a compiler
that forces the code-pessimizing 'volatile').

And the "it's not volatile" is actually our historical behavior. The
volatile really is new, and didn't exist before your commit
b59167ac7baf ("x86/percpu: Fix this_cpu_read()").

So the whole "implies READ_ONCE()" really seems to be due to that
*one* mistake in our percpu sequence locking code.

Yes, it's been that way for 5 years now, but it was the other way
around for the preceding decade....

                    Linus

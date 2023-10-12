Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B747C738F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 18:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379533AbjJLQ4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 12:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378915AbjJLQ4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 12:56:49 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F085C0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 09:56:47 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9b2cee55056so209143066b.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 09:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697129805; x=1697734605; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jmrTXUYBrl82zPk6xTsWXlr1/jpE50Bjd2FIS9se3Js=;
        b=gaF/Jl0WfZpYm4GGXPdKkPEzLHd6jnnZBRz/tZd1n+KqNo17OQSpGqZOX3gKGAARha
         ksTqqrCCufAjEifAab1Vc4PhGnZrS+Azw4W1J5jUWthVOFuf5ltZPPpHS2AyzwEe/FB+
         bwlvwFtIfGbdm4NNzIHxSKgk8j4W2rzVV3Uzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697129805; x=1697734605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jmrTXUYBrl82zPk6xTsWXlr1/jpE50Bjd2FIS9se3Js=;
        b=fMrLpAp0krDkLLCCl4b8gdvf3SM4aP0fKe4MKh6a7XpuZf4vQUHkXf47ltcdIZimbq
         RsMzy2AXrxMF764epJoQwYhCJbstNgsCOtUDFLVi1IEE707NxrfFji89fe2GSBQOo7lj
         LNhgmJkNG5797eickPP1hwibfMAkI24kqfnlljgtWnWJQYqbAQjdDiSab20TTzPsC0wD
         t6vuLXV4K6WgbV6nhKNZC7Z86MITD8Ssxd5W6fnMjjwkR93LOiFfVa77oEgHdTQE9fku
         JfH3GrKr8ywN1hYnswtXiNXMLqvPXcHXiFPUr5XFr70iptYRqcOQVvoeSYT8uVpcwDwt
         TRwg==
X-Gm-Message-State: AOJu0YzfBHVT+Yx076FIovWGDvdoCSJQh2Nrm3hRf2nF/fdfzE2v8QC0
        Ft7ouAYcuDQX2AlqbgytyD6D74wZlbXWNTtm/K/hyKYS
X-Google-Smtp-Source: AGHT+IERuR9DZJmcBTbJEibGLWn+MHNW4xUtJfYWmhNMB1wGDE8dCzZKgdEPmOyAP6B63jX9VDT3JA==
X-Received: by 2002:a17:906:220c:b0:9b8:a556:87a5 with SMTP id s12-20020a170906220c00b009b8a55687a5mr20866248ejs.22.1697129805544;
        Thu, 12 Oct 2023 09:56:45 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id gq7-20020a170906e24700b009adc5802d08sm11310289ejb.190.2023.10.12.09.56.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 09:56:44 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-9b6559cbd74so210922266b.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 09:56:44 -0700 (PDT)
X-Received: by 2002:a17:906:518e:b0:9ad:8a29:f26a with SMTP id
 y14-20020a170906518e00b009ad8a29f26amr22916310ejk.63.1697129804061; Thu, 12
 Oct 2023 09:56:44 -0700 (PDT)
MIME-Version: 1.0
References: <20231010164234.140750-1-ubizjak@gmail.com> <CAHk-=whYWhZN52SJN-Th9x2L2V-vHtAXUgiy_nSJ3+vQU6ak4Q@mail.gmail.com>
 <CAFULd4ZqH3FeG8_mjDvUAU9QiGB36wDu3MzUtadgAgoVuQ9QRg@mail.gmail.com>
 <CAHk-=wiALZxieQQmvv5sW15HYB_YwC3d_ma9sdp7Zb4Fb4uK2w@mail.gmail.com>
 <F48A9D34-3627-4372-B555-B58CBFC3F241@vmware.com> <CAHk-=wjF4gzCZKh-zN-sY0WpX1kCo+s9gYE9sOcSv0QieH1dwQ@mail.gmail.com>
 <CAFULd4bmOa7G2dXd_mu4J=_bsEs+TbxH691tYx9QQBwJPAma9w@mail.gmail.com>
 <CAHk-=wj2Co_g3RQ=JkDZC7PYbRqDPq7mePQ0=eYhhtpEgqJD0w@mail.gmail.com>
 <0617BB2F-D08F-410F-A6EE-4135BB03863C@vmware.com> <CAFULd4Zp-eDsxpStBznMHUE3OcHZ97NAZrZEjJW63oEFWtM3OQ@mail.gmail.com>
In-Reply-To: <CAFULd4Zp-eDsxpStBznMHUE3OcHZ97NAZrZEjJW63oEFWtM3OQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 12 Oct 2023 09:56:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiqpJfBicroWizUsc4k2Zyg+yHMgfbCSvU_gkT45KK0Cg@mail.gmail.com>
Message-ID: <CAHk-=wiqpJfBicroWizUsc4k2Zyg+yHMgfbCSvU_gkT45KK0Cg@mail.gmail.com>
Subject: Re: [PATCH v2 -tip] x86/percpu: Use C for arch_raw_cpu_ptr()
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     Nadav Amit <namit@vmware.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Oct 2023 at 09:33, Uros Bizjak <ubizjak@gmail.com> wrote:
>
> For some reason existing percpu_stable_op asm uses %P operand
> modifier. This will drop all syntax-specific prefixes and issue the
> bare constant. It will also remove the (%rip) suffix. What we want
> here is a generic %a modifier (See 6.47.2.8 Generic Operand Modifiers
> [1]) that will substitute a memory reference, with the actual operand
> treated as the address. In combination with "p" constraint will DTRT
> and will emit symbol with the (%rip) suffix when available, also when
> -fpie is in effect.

Well, I have to admit that I think the main reason we used "p" as a
constraint was simply that we knew about it, and I don't think I've
ever even realized "a" existed.

In fact, we historically didn't use a lot of operand modifiers, and
the only common ones (at least for x86) tend to be the "register size"
modifiers (b/w/q)

I just did

    git grep 'asm.*[^%]%[a-z][0-9]' arch/x86

and while that will only catch one-liner inline asm cases, all it
finds is indeed just the size ones.

A slightly smarter grep finds a couple of uses of '%c' for bare constants.

So I think the "we used P for percpu_stable_op" is really mostly a "we
are not actually very familiar with the operand modifiers".  We use
the constraints fairly wildly, but the operand modifiers are a
relative rarity.

I suspect - but it's much too long ago - that some gcc person just
told us that "solve this using 'P'" and we never went any further.

So changing it to use 'a' sounds like the right thing to do, and we
can only plead ignorance, not wilful stupidity.

              Linus

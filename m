Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 798AC799095
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 21:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245365AbjIHTtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 15:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244353AbjIHTti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 15:49:38 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6878926AA
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 12:49:16 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-52e828ad46bso3236552a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 12:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1694202506; x=1694807306; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d1dUW7fJkCquDjjruKJF9ic5ByrdeDFJnU0IlXTs1QI=;
        b=DNLBQWL2KZVgU78u3fLxHSc0mygkAU2IEWDxkI3IdmX2GS5y3Bj5/9SaipU4Jl5AQC
         S469Sz43zBq7HjGO2Rn5WJH6ptzAqtOOlydtXzNyqT6De+oMhPwzlygDD3RnkPDxhmO6
         pFIYI5YYLa31RJLIwMWT/0StowSTsU9/vQsA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694202506; x=1694807306;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d1dUW7fJkCquDjjruKJF9ic5ByrdeDFJnU0IlXTs1QI=;
        b=YTxyHbj/irzADHze6aeMG6qmtjAL/ih2vMpOsmr6QI1F4wZXQdqJWfz2/5k1rvsTiI
         Y40WBEx5VFlwLwY9Vvly4N1FWRBzHwdHMdNlRCohZXKLj4ylgEolKXi0rrbU3JxGDR0h
         b8x3ZLL0tEcI1vT0M310j088o9fD7T8IsL032gywoojyGu4vk1Y7Ay/DhjkIDonUKgG1
         +oShDiSnokVA2MgQ/ZCIuZBLOKW31MMAmC+rN5E4a5l9fJz8nN/mWvuJqu1t0uw02dvc
         CpO52RIvlw9mnItMZlOSI2K1lllN0YY6Xo5jl3xiy3IL4hmcCXPEKaKnfR0XeGiYSf2v
         /5SQ==
X-Gm-Message-State: AOJu0Yy8i+kjxYyh2mSnpspf0sbowQwqmZbDwMC/BUrfjvn7aneWV2AS
        /Mzgfc6/mX7trLID707S1ysmsERA/oVhFfIb693TN1QO
X-Google-Smtp-Source: AGHT+IFckFNmRvjHZo3Zp2mYUJ7zpidAgGZ4ixM9zLa7K5/5JA11k6pa7KppbwAAFHr7er0aYUxe8w==
X-Received: by 2002:a17:906:10c9:b0:9a9:fc74:8d50 with SMTP id v9-20020a17090610c900b009a9fc748d50mr2037229ejv.66.1694202506007;
        Fri, 08 Sep 2023 12:48:26 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id v14-20020a170906338e00b00992b1c93279sm1422938eja.110.2023.09.08.12.48.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Sep 2023 12:48:25 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-9a5dff9d2d9so299998366b.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 12:48:25 -0700 (PDT)
X-Received: by 2002:a17:906:cc12:b0:9a1:e293:9882 with SMTP id
 ml18-20020a170906cc1200b009a1e2939882mr2646204ejb.63.1694202504918; Fri, 08
 Sep 2023 12:48:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230908111053.1660033-1-chenhuacai@loongson.cn>
In-Reply-To: <20230908111053.1660033-1-chenhuacai@loongson.cn>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 8 Sep 2023 12:48:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh-uoZ_XsZ4fDodqjUY+rYJq=D3RVme3f=zBDB5neWhKQ@mail.gmail.com>
Message-ID: <CAHk-=wh-uoZ_XsZ4fDodqjUY+rYJq=D3RVme3f=zBDB5neWhKQ@mail.gmail.com>
Subject: Re: [GIT PULL] LoongArch changes for v6.6
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>,
        loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>,
        Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Sept 2023 at 04:11, Huacai Chen <chenhuacai@loongson.cn> wrote:
>
> 7, Add KASAN (Kernel Address Sanitizer) support

I have pulled this, but please at least consider

 (a) don't use the stupid and random __HAVE_ARCH_xyz defines

Yes, yes, we have historical uses of it. That doesn't make it good.
Instead of making up new random symbol names, just *USE* the names you
are defining per architecture.

IOW, instead of doing

  #define __HAVE_ARCH_SHADOW_MAP

and defining your own helper replacement functions for
kasan_mem_to_shadow() etc, just use those names as-is.

So if you have an architecture that has its own version of
"kasan_mem_to_shadow()", then use *THAT* name for the #ifdef too.
Don't make up another name entirely of the form "__HAVE_ARCH_xyz".

Example: architectures can override the default generic versions of
"arch_atomic_xyz()" operations, and the way you do that is (for
example)

  static __always_inline int arch_atomic_add_return(int i, atomic_t *v)
  {
        return i + xadd(&v->counter, i);
  }
  #define arch_atomic_add_return arch_atomic_add_return

note how the define to let you know the name exists is the name itself
(and because the implementation is an inline function, not the macro,
the marker is then just a "define the name to itself").

End result: no made-up secondary names for other things. When you grep
for the thing that is used, you find both the implementation and the
marker for "look, I am overriding it".

And also

 (b) do you really want to inline those kasan_mem_to_shadow() and
kasan_shadow_to_mem() things?

Yes, the caller is addr_has_metadata(), and that one is
"__always_inline",. because otherwise objtool would complain about
doing function calls in SMAP-enabled regions.

HOWEVER:

 - on LoongArch, I don't think you have that objtool / SMAP issue

 - and if  you did, the function should be __always_inline, not just
plain inline anyway

so I get the feeling that the inline is simply wrong either way. Maybe
that function should just be declared, with the implementation being
out-of-line? It seems unnecessarily big to be an inline function, and
it doesn't seem performance-critical?

Neither of the above issues are critical, and the second one in
particular really is just a "did you really mean to do that" kind of
reaction, but since I was looking at this, I decided to write up my
reactions.

              Linus

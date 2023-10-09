Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678957BE2F4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 16:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233454AbjJIOf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 10:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbjJIOfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 10:35:24 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1813D9E
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 07:35:23 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-53b32dca0bfso6496593a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 07:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696862121; x=1697466921; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VVuzGRM0+235Dw/cvpufLU0wqCwQ31kVmAzdeU61ySM=;
        b=cmgyiov8ffUuwSGtT4TGhHL8BBbID2NyMArIVrr66Cmak6/3y4Ee8YXYEjFV4P0rfl
         bRgzIAjZ+6OO/K/wAW/6SxvOcAw5I595S+vpn8DXq4kZJwQZvxgBJ9rzEhauF3y6y5Vc
         JdmPQn+fwtDGMsu0J8kplvU39tSuGNk1Li4TLQBXXeBwkLa4WWRc6tbDTew5MiJmZNIp
         qaYP6GvgZW7WG8B1VwFAbAxSl0fZqyYF/PJnLS5L9CU5AXwhGuxIKU/kxprIm2szwHjt
         dLXSRiVKAEnabmnS8Bt2ZlbtgEYXNUCmIB3kxABHagw8/eAMespKdm/s4SdPpvT7EsuR
         gm9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696862121; x=1697466921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VVuzGRM0+235Dw/cvpufLU0wqCwQ31kVmAzdeU61ySM=;
        b=andmcsiL4s6JnQtLXo0wkmYDYLEFVjZw/iPbfqTQL2CUtAtI+2YriWWIbrk5lcKO38
         7VtWzcZOBFRrEuK5elmjcW2X0GoNXSueo9WaNGzXoOw/XVQ8Q/UbxY3tN+1Go6c03lZ6
         cwX1UK2KkShH/oQ6I9VBZEVwiA2rUOqwEteNT+RWkmwSlDKVjunopcqhySu8u/+5/7i7
         G+EJz8ODf1MYoJZlxlw5Tjl6ZenAmur8kM0fBKqR87KJ7UlL13BzGzxprJRl0lY5ri+l
         gcc3nbvABTx4e8xlRip7cKS9qTjuCHkrzIB+ZlYxKdwuqFqeCwnLbomqjnbj5aEHThsF
         J9Ug==
X-Gm-Message-State: AOJu0YxyZ7IYZcYmy4fiy9vj10tTAIFgynHg7T6J1T7nzkyUqqAHS7Nb
        g0eR1fNVjrlvRXb8il9qp4GEzjaVV2tLnv4mFCo=
X-Google-Smtp-Source: AGHT+IHub4DXnzvaVMukc3AvXGcVEbrN65n639Sm5dyBQQVs30NG91uUuf03qZ8HMO96t/7q/iweWXVyO5okYLO3kaY=
X-Received: by 2002:a05:6402:5114:b0:522:405f:a7 with SMTP id
 m20-20020a056402511400b00522405f00a7mr11091090edd.16.1696862121276; Mon, 09
 Oct 2023 07:35:21 -0700 (PDT)
MIME-Version: 1.0
References: <20231004145137.86537-1-ubizjak@gmail.com> <20231004145137.86537-5-ubizjak@gmail.com>
 <CAHk-=wgepFm=jGodFQYPAaEvcBhR3-f_h1BLBYiVQsutCwCnUQ@mail.gmail.com>
 <CAFULd4YWjxoSTyCtMN0OzKgHtshMQOuMH1Z0n_OaWKVnUjy2iA@mail.gmail.com>
 <CAHk-=whq=+LNHmsde8LaF4pdvKxqKt5GxW+Tq+U35_aDcV0ADg@mail.gmail.com>
 <CAHk-=wi6U-O1wdPOESuCE6QO2OaPu0hEzaig0uDOU4L5CREhug@mail.gmail.com>
 <CAFULd4Z3C771u8Y==8h6hi=mhGmy=7RJRAEBGfNZ0SmynxF41g@mail.gmail.com> <ZSPm6Z/lTK1ZlO8m@gmail.com>
In-Reply-To: <ZSPm6Z/lTK1ZlO8m@gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Mon, 9 Oct 2023 16:35:09 +0200
Message-ID: <CAFULd4Z=S+GyvtWCpQi=_mkkYvj8xb_m0b0t1exDe5NPyAHyAA@mail.gmail.com>
Subject: Re: [PATCH 4/4] x86/percpu: Use C for percpu read/write accessors
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Nadav Amit <namit@vmware.com>, Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 9, 2023 at 1:41=E2=80=AFPM Ingo Molnar <mingo@kernel.org> wrote=
:
>
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
> >       def_bool y
> > -     depends on CC_HAS_NAMED_AS && SMP
> > +     depends on CC_HAS_NAMED_AS && SMP && !KASAN
> > +     depends on CC_HAS_NAMED_AS && SMP && !KASAN
>
> So I'd rather express this as a Kconfig quirk line, and explain each quir=
k.
>
> Something like:
>
>         depends on CC_HAS_NAMED_AS
>         depends on SMP
>         #
>         # -fsanitize=3Dkernel-address (KASAN) is at the moment incompatib=
le
>         # with named address spaces - see GCC bug #12345.
>         #
>         depends on !KASAN

This is now PR sanitizer/111736 [1], but perhaps KASAN people [CC'd]
also want to be notified about this problem.

[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D111736

Thanks,
Uros.

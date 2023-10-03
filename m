Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23EF07B65D8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 11:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239701AbjJCJtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 05:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbjJCJtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 05:49:16 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679EB91
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 02:49:13 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99de884ad25so117492066b.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 02:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696326552; x=1696931352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E+N+tVGAA5egSmR75YiQ67ulIObp4L3VVB963HxoCgE=;
        b=Od5i2V2IMVBvp41JP2n4jfank5c/ws6iQC6R8dDyGvsFEaNc4jhGaKsOJLTWhxnndC
         sHcClojGNqMJRkuElWlsxITg57E3QTRJmqpkSKUSSTPTT+5Bv1OoqfZ0ky5nu4r27Spi
         Pp54hPNiEFzSl8zQzf0aKH+iKQk1kulkLKkfUuJBg5UrrkYJnFs5fm2GAX+D7gE6qfpc
         Y4KUePs9oEI9eIgmmWqORWWFAfuCWTEDZovgViC2ozWFVX33IWrboV3YIN9kwTu5BEST
         Z0kqBFE7Fbl7UXfGR5XzJBo2QBV84R36XdEGmMhEqDI/uCcKWc0lyJshKCS4M5SfkOsM
         WDZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696326552; x=1696931352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E+N+tVGAA5egSmR75YiQ67ulIObp4L3VVB963HxoCgE=;
        b=YXVf3BUYlPsqlDqt2hOEyDXvReHhq5IzMqxekoZBB/v1ZFcQZL6BCxbx4/BwytAYFa
         bKlVgvhLypz5kAgPZc9EyVES/DNdadN3Sov25YyQZMMGwKFYD6Rp4itnuFHQxaSzRB4+
         ye1wdGL6mOvg2VvvUtBdyd8mt2/JvNKA2qNBU8IFeBDrIO0hlB+ouBAuHN1hjNaeD8ae
         BIucrOgF2hYSuU6/mt9OgB4AJjXFbkv2CtvW0r/3BMUpycvdxaQxO81d6o7ynh6SR/9N
         J9jwQOiJqx0FoCtaNqC+8bs0skLQgKEMf0GX7KDVPrvJgKKq8cXzlAaeUehoi2N5WWV3
         D9bA==
X-Gm-Message-State: AOJu0YwIjst4xUBpRyKtndxO63yGzNiuCkBw2fo6fYz8lLeBEmJQVuB4
        UoCoBFR/osRWvMvzQrEhjLFaOyKbYqNb/piqdKI=
X-Google-Smtp-Source: AGHT+IG6TrF3Id0khUy/8BsYpLoaqCLGK5kHdk2ST647UXjhvEojaKulJGznwSczNmXxO5LJBDfcIXrEoEAJVQCnsY8=
X-Received: by 2002:a17:906:bca:b0:9b2:b149:b81a with SMTP id
 y10-20020a1709060bca00b009b2b149b81amr10462422ejg.64.1696326551645; Tue, 03
 Oct 2023 02:49:11 -0700 (PDT)
MIME-Version: 1.0
References: <20231001131620.112484-1-ubizjak@gmail.com> <CAHk-=wg6P8pPg-x4BPUQj-wE0xC7HkGzFk89ftuji8MVo+RRxw@mail.gmail.com>
 <CAFULd4Y+HXuditB51Q0LznqiBsvxJr3BjEYvx4_224XmqrycCw@mail.gmail.com>
 <CAHk-=wh+cfn58XxMLnG6dH+Eb9-2dYfABXJF2FtSZ+vfqVvWzA@mail.gmail.com>
 <CAFULd4atO8uy_5PbjV8vw-yk0tv_=4kh_JwJ+6Xq-2myStCnmw@mail.gmail.com>
 <CAFULd4YsPnCfw-NV_0ck1_za=WPc-FxYKV1bb99UcAwMJ=34YA@mail.gmail.com> <ZRrECdIoKCXALl39@gmail.com>
In-Reply-To: <ZRrECdIoKCXALl39@gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Tue, 3 Oct 2023 11:49:00 +0200
Message-ID: <CAFULd4bBzAWoY7MDQN+YV5tpw7vDitFNMuSVt53KGofdZRvTpg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] x86/percpu: Use segment qualifiers
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Nadav Amit <namit@vmware.com>, Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
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

On Mon, Oct 2, 2023 at 3:22=E2=80=AFPM Ingo Molnar <mingo@kernel.org> wrote=
:
>
>
> * Uros Bizjak <ubizjak@gmail.com> wrote:
>
> > > > Clang isn't much better, but at least it doesn't generate bad code.=
 It
> > > > just crashes with an internal compiler error on the above trivial
> > > > test-case:
> > > >
> > > >     fatal error: error in backend: cannot lower memory intrinsic in
> > > > address space 257
> > > >
> > > > which at least tells the user that they can't copy memory from that
> > > > address space. But once again shows that no, this feature is not re=
ady
> > > > for prime-time.
> > > >
> > > > If literally the *first* thing I thought to test was this broken, w=
hat
> > > > else is broken in this model?
> > > >
> > > > And no, the kernel doesn't currently do the above kinds of things.
> > > > That's not the point. The point was "how well is this compiler supp=
ort
> > > > tested". The answer is "not at all".
> >
> > I don't agree with the above claims. The generated code was the product
> > of a too limited selection of available copy algorithms in unusual
> > circumstances, but even in the case of generic fallback code, the
> > generated code was *correct*. As said in the previous post, and
> > re-confirmed by the patch in the PR, the same code in GCC handles
> > implicit (__thread) and named address spaces. At the end of the day, th=
e
> > problematic code was merely a missing-optimization (the bug with the
> > lowest severity in GCC).
>
> Yeah, so the feature generated really crappy code for Linus's
> testcase. That's never a good sign for compiler features, full stop.
>
> Do we want the kernel to be at the bleeding edge of an
> unusual compiler feature that is only used internally by the
> compiler in a very specific fashion?

I understand your reservations about the new feature, but please allow
me to bring up some facts about it. The feature is *far* from being an
unusual internal compiler feature in GCC. It was introduced for gcc-6
(mostly for embedded targets), but in 2017 the complete thread local
storage (e.g. __thread) handling was switched to named address space
and released in gcc-8. I don't remember any reported problem with this
feature (and I know what I'm talking about, the switch to named AS in
the compiler was done by myself [1]). Since named AS uses the same
compiler code, I'm quite confident that it shouldn't be considered a
bleeding edge unusual compiler feature.

The "crappy code" happened due to the limitation in the completely
different part of the compiler. It was stringop algorithm selection, a
feature orthogonal to address spaces (tangential only in the sense
that several algorithms are not available with non-default address
space). Colorful language notwithstanding, the generated code is
nothing more than "missed-optimization" and the gcc bugreport was
qualified as that. With -mstringop-strategy=3Dloop, the testcase
produces expected code, and the stringop selection in the compiler
will be adjusted accordingly also for the very limited selection of
stringop algorithms for named AS. Even when the kernel will never use
these algorithms for its percpu functionality...

> Maybe, but Linus's reluctance and caution is justified IMHO,
> and at minimum this feature needs some careful evaluation of
> long-time suitability [*] ...

I do have a proposal on how to introduce a new feature while
minimising risk as much as possible. I must admit that detecting the
feature for all released compilers that can handle __seg_gs seems
quite risky (I have to curb my enthusiasm somehow ;) ), so perhaps a
staged approach with a currently unreleased compiler is more
appropriate. Using:

+config CC_HAS_NAMED_AS
+       def_bool CC_IS_GCC && GCC_VERSION >=3D 140000

would enable the new feature only for currently unreleased
experimental GCC. This would allow to qualify the compiler and weed
out any possible problems, before the compiler is released. Please
note, that the patch is written in such a way, that the code reverts
to the existing approach for undefined CC_HAS_NAMED_AS.

I would also like to point out additional possible improvements that
are not in the proposed patch. Using named AS enables the kernel to
move one step further to PIE, as noted in the original patch
submission [2].

> [*] euphemism for: "I have no idea how to evaluate this risk"... :-/

[1] https://gcc.gnu.org/git/?p=3Dgcc.git;a=3Dcommitdiff;h=3Dcfc72af0fbdf
[2] https://lore.kernel.org/lkml/20190823224424.15296-1-namit@vmware.com/

Thanks,
Uros.

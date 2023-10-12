Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6FA7C7970
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 00:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442989AbjJLW1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 18:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344180AbjJLW1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 18:27:06 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79B9BB
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 15:27:04 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9ada2e6e75fso257505166b.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 15:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697149623; x=1697754423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cHyo9fSi27Id6LrPtS/9KH9PdJ59imXr1RZnXM53Toc=;
        b=Fc6Wu7AxnwLnFyy6wpgTW0M8x+YAUjXBLShtkcjTRNYBjS/G2TBOfw+BUwjEG4jwf2
         uuDrECctgZN+L+YfhZ7xxs0+8+bdMTSXSAlsNi1YF5Zy2dVJrhZ+msZJfou8iQiBWDDJ
         tZCacoKvCglAIwtzQ1bZF2Ovjh+vMbZyeE1nUwsZcfXy8Aq92fltbNtlRRl3gduOhXXX
         KcMVzqHMb2FJsf9X7PIk0kj94OnVDPoYgPShWGooftLUHgFxZtm7dgqs/ARCXECeNnAy
         c+vwDU6eS4fP/RMfLV9ed1Oe7lB/KQAsn3Ut80k/gQbeCXtgWSlJuBe+QLJDKqI0av0y
         FyOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697149623; x=1697754423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cHyo9fSi27Id6LrPtS/9KH9PdJ59imXr1RZnXM53Toc=;
        b=HCcq4HSh8JnFT8T5FULXC4n5GxAyFfVDCbqvlAKxRpO5VYIlrV14AGUeHlyNdnjaWC
         Y/pfALp/ir3R9iW9fkFo6AOzRPAUSxkQBDCQ0yAwCV+cyNQOhiR2Hj8qVxbNZQrTZzCm
         rqlsdnmXSxOq7fRPML5nna1rGvTX6vZ+bLvUpugH96Uyw9Nc/xsnoQKYCRdJvwmZvF3X
         PeRtWrANiLpV//qH87sxlNJXONTba3OtJEXIe6GCkexn2ik39GgiMocik2QZVNefv4JH
         xKq7P8SNJK/BsCWodJ97jm3MGcJX2XFOVZRrrOWu605YlOyfeEs9+kyDQGkuV/wzgifT
         Tvbg==
X-Gm-Message-State: AOJu0Yxf+tkscTpVZMfy9VmhT+nDTE65H9Otsm4kqGQeAvowMLikxHGI
        0fNK1/GePgPv+ySanTfyJ1KIqct1YIV3/eQU9tLt9g==
X-Google-Smtp-Source: AGHT+IGD1I7+hyhaygsRIBsksA6Z/9zQPJAvNgjGjr1zN+qJjt0GOQkR8nkHht+PI3KDyCs/v0xOZqolHjxki1yoH0A=
X-Received: by 2002:a17:907:760a:b0:9bd:8bf6:887c with SMTP id
 jx10-20020a170907760a00b009bd8bf6887cmr2835890ejc.53.1697149623041; Thu, 12
 Oct 2023 15:27:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220927131518.30000-1-ojeda@kernel.org> <20220927131518.30000-26-ojeda@kernel.org>
 <Y0BfN1BdVCWssvEu@hirez.programming.kicks-ass.net> <CABCJKuenkHXtbWOLZ0_isGewxd19qkM7OcLeE2NzM6dSkXS4mQ@mail.gmail.com>
 <CANiq72k6s4=0E_AHv7FPsCQhkyxf7c-b+wUtzfjf+Spehe9Fmg@mail.gmail.com>
 <CABCJKuca0fOAs=E6LeHJiT2LOXEoPvLVKztA=u+ARcw=tbT=tw@mail.gmail.com>
 <20231012104741.GN6307@noisy.programming.kicks-ass.net> <CABCJKufEagwJ=TQnmVSK07RDjsPUt=3JGtwnK9ASmFqb7Vx8JQ@mail.gmail.com>
 <202310121130.256F581823@keescook>
In-Reply-To: <202310121130.256F581823@keescook>
From:   Ramon de C Valle <rcvalle@google.com>
Date:   Thu, 12 Oct 2023 15:26:51 -0700
Message-ID: <CAOcBZOQ=M7zpXTA7Ue1=2436N4=MFgKVRPmTQ1H=b1mUwJEqEQ@mail.gmail.com>
Subject: Re: [PATCH v10 25/27] x86: enable initial Rust support
To:     Kees Cook <keescook@chromium.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        David Gow <davidgow@google.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 11:31=E2=80=AFAM Kees Cook <keescook@chromium.org> =
wrote:
>
> On Thu, Oct 12, 2023 at 10:50:36AM -0700, Sami Tolvanen wrote:
> > On Thu, Oct 12, 2023 at 3:47=E2=80=AFAM Peter Zijlstra <peterz@infradea=
d.org> wrote:
> > >
> > > On Fri, Oct 14, 2022 at 11:34:30AM -0700, Sami Tolvanen wrote:
> > > > On Fri, Oct 14, 2022 at 11:05 AM Miguel Ojeda
> > > > <miguel.ojeda.sandonis@gmail.com> wrote:
> > > > >
> > > > > On Tue, Oct 11, 2022 at 1:16 AM Sami Tolvanen <samitolvanen@googl=
e.com> wrote:
> > > > > >
> > > > > > Rust supports IBT with -Z cf-protection=3Dbranch, but I don't s=
ee this
> > > > > > option being enabled in the kernel yet. Cross-language CFI is g=
oing to
> > > > > > require a lot more work though because the type systems are not=
 quite
> > > > > > compatible:
> > > > > >
> > > > > > https://github.com/rust-lang/rfcs/pull/3296
> > > > >
> > > > > I have pinged Ramon de C Valle as he is the author of the RFC abo=
ve
> > > > > and implementation work too; since a month or so ago he also lead=
s the
> > > > > Exploit Mitigations Project Group in Rust.
> > > >
> > > > Thanks, Miguel. I also talked to Ramon about KCFI earlier this week
> > > > and he expressed interest in helping with rustc support for it. In =
the
> > > > meanwhile, I think we can just add a depends on !CFI_CLANG to avoid
> > > > issues here.
> > >
> > > Having just read up on the thing it looks like the KCFI thing is
> > > resolved.
> > >
> > > I'm not sure I understand most of the objections in that thread throu=
gh
> > > -- enabling CFI *will* break stuff, so what.
> > >
> > > Squashing the integer types seems a workable compromise I suppose. On=
e
> > > thing that's been floated in the past is adding a 'seed' attribute to
> > > some functions in order to distinguish functions of otherwise identic=
al
> > > signature.
> > >
> > > The Rust thing would then also need to support this attribute.
> > >
> > > Are there any concrete plans for this? It would allow, for example,
> > > to differentiate address_space_operations::swap_deactivate() from any
> > > other random function that takes only a file argument, say:
> > > locks_remove_file().
> >
> > I haven't really had time to look into it, so no concrete plans yet.
> > Adding an attribute shouldn't be terribly difficult, but Kees
> > expressed interest in automatic salting as well, which might be a more
> > involved project:
> >
> > https://github.com/ClangBuiltLinux/linux/issues/1736
>
> Automatic would be nice, but having an attribute would let us at least
> start the process manually (or apply salting from static analysis
> output, etc).

An idea would be to add something like the Rust cfi_encoding
attribute[1] and use it with something similar to the Newtype
Pattern[2], but in C[3], for aggregating function pointers that
otherwise would be aggregated in the same group in different groups.

[1]: https://doc.rust-lang.org/nightly/unstable-book/language-features/cfi-=
encoding.html
[2]: https://doc.rust-lang.org/book/ch19-04-advanced-types.html#using-the-n=
ewtype-pattern-for-type-safety-and-abstraction
[3]: Wrapping a type in a struct should achieve something similar even
without using the cfi_encoding attribute since the encoding for
structs is <length><name>, where <name> is <unscoped-name>.

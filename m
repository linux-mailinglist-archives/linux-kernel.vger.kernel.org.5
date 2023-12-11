Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20D0180D0A6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 17:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344053AbjLKQLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 11:11:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343886AbjLKQLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 11:11:52 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827779E
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 08:11:56 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-548ae9a5eeaso12462a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 08:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702311115; x=1702915915; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ac5CXHbB9EVvU7FGXILRzOHBDMiYKvXAj6dgYe06Vw=;
        b=jRIEVIfpG9wemGooInt/Yl7R2xKwxocom7ZrDOnYg4xdjIIOoAGttn8av0Qm/gCg8Y
         Wuf2XxgyXIF2GZ9Z8A5qj1lOURePzS85LnIaeG5ztFsZu9Dkp4PvBTOHEsbRNTncF+Ou
         csWz393H7h/ybItHlNcRQzQrRNFL+0iVAdp1d8ObZBka6ptcD1BZpSQUh7kCvu0P1KQf
         CyubCYMbufpBgK1OzX45pquXRecUT/zueDEFFHl1+0+fPZI9jmwgcPAVRJK3dbNCZJvi
         1o4xrIT7vtzgfOJY4i2LhtfmjJez6QANezn76VV1ZQvxFdj581HX55CjJ/h3AtfxbL09
         GXJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702311115; x=1702915915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ac5CXHbB9EVvU7FGXILRzOHBDMiYKvXAj6dgYe06Vw=;
        b=HDeWKhlFjh2lrvKo7ht31anp6D7msDh9IUWyh47+Q3VNB0ssRMez6sdtKe/aCiM+8q
         y0ezQMBktlvBhhckUFmRvcCTXG4t2KznFd0Cim5hW3u8othwG9d7/IpwGdwHmQzUOxgL
         7jagx/Cl64LOpKcBhf5TCDb12PniMRKGN1hdEISfTN5dFeiEb8OeaW/GiYum8m9oxOvA
         7L399BXThhTMAiNGUEeQNiM5clYVHS9xOtKoJrcGV6tn+0fSYWFKuATRilisUVgX7406
         w+qqnvoWNFh9wxuXrttUOeBDeEcLgCElYzN5zo+Haq+4TPtseuu2ITSQQWSF3Q4Qt0Dd
         1Eqg==
X-Gm-Message-State: AOJu0YwWEQnkP3Nr0BoZnKHGdhBn9SmAUJLBJRsYgXNN/bJFGue+DEQN
        Zl0IqJ2L9bJQSeQ3cRqgwGBFNYQIacYoswlVpT156w==
X-Google-Smtp-Source: AGHT+IFuGBJJrq+tVIvYyNR8QMM6gpxijJhMVkgf/4HC8SE1EFAy0QM1Zmzrl9//BuLZVZQqFldq140ye6hdah7svII=
X-Received: by 2002:a50:ccde:0:b0:54c:384b:e423 with SMTP id
 b30-20020a50ccde000000b0054c384be423mr206505edj.5.1702311113654; Mon, 11 Dec
 2023 08:11:53 -0800 (PST)
MIME-Version: 1.0
References: <20231211150753.293883-1-mmaurer@google.com> <CANiq72nrCThY3mtHRMncRFDsu8XUmdb=W4WBs5Ua6oNugkDZhA@mail.gmail.com>
In-Reply-To: <CANiq72nrCThY3mtHRMncRFDsu8XUmdb=W4WBs5Ua6oNugkDZhA@mail.gmail.com>
From:   Matthew Maurer <mmaurer@google.com>
Date:   Mon, 11 Dec 2023 08:11:40 -0800
Message-ID: <CAGSQo03EPpPFy9ppE7wjv_NG8P_pRqLN21TvoMnYzA=+Z_gCnw@mail.gmail.com>
Subject: Re: [PATCH] x86/Kconfig: rust: Patchable function Rust compat
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 7:36=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Mon, Dec 11, 2023 at 4:08=E2=80=AFPM Matthew Maurer <mmaurer@google.co=
m> wrote:
> >
> > +       def_bool $(rs-option,-Zpatchable-function-entry=3D16,16)
>
> We don't have `rs-option` in mainline yet -- missing dependency? We
> will likely eventually need it, but currently we only support a single
> Rust version anyway, so we could add it (and the flag check itself)
> when we upgrade (especially if it is going to be supported soon).
Sorry, I just realized this was only in a local patch. I hadn't sent
it previously because,
as you pointed out, we currently only support one compiler revision.

I was taking this approach because Android's compilers can have patches
backported onto them when needed, so our 1.73.0 could have this flag
and make use
of it.
>
>
> Speaking of which, I can't find the flag in upstream Rust (i.e.
> outside the LLVM submodule), and I couldn't find a PR adding it. Could
> you please add a `Link:` tag to the tracking issue / PR / ... if it is
> submitted / when it is submitted? Or am I very confused?
I haven't uploaded it yet. I'm hoping to send it up later today. I can
wait until it's
uploaded for a v2 of the patch series so I can link to it directly.
>
> Cheers,
> Miguel

If I don't get the PR for `-Zpatchable-function-entry` done in a
timely fashion, I'll send
up an alternate version of this patch that just makes it depend on
!RUST, as this can
currently cause random runtime failures if features which assume
patchable entry are
used with Rust.

Re: Martin's comments (unfortunately they aren't on the same email so
I can't reply inline)
would you like me to file an issue against the R4L repository about
this before sending a v2?
I thought that repository was just for staging/discussion, and this
didn't seem likely to need it.

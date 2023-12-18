Return-Path: <linux-kernel+bounces-3548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B322E816DAF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62ACF284A36
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA83495DB;
	Mon, 18 Dec 2023 12:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VMt5W2sj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AC24EB2B;
	Mon, 18 Dec 2023 12:10:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA781C433CB;
	Mon, 18 Dec 2023 12:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702901412;
	bh=dVhbJOfI8GErd5dfLBSnmMb7qs6cI4l8iJg2KjHOMTw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VMt5W2sjKUFRbmlF0uFTyH5aFKb5Dg3BXypmyT9/0lPMZxs/w7zE9tnZEociYvRD8
	 Weo9zfxOvZXT48e47NOG58a08J7S9gWE24Q4BPlIkiYXQmb3dOramC1NjiCQ1r52s0
	 0oDJPMUccdKYjsdMHRNORc60OdGKrtimY/S2va9WAVssULJY6fZ8OFwlPU/AXNz0Q9
	 F8dFXVthcguRVQa7nk3EtX+92U85Ftd/lvmbzUZ+IQQVxC058HE7p7eILnY/JEXFcf
	 qH3Y9Aa0i3gWlmiriwRY/XFcZi/pGT0ieu2OXZIrPfCwgd5hku0oJOvq1QhiJ9Byx+
	 kOEtts5GoGUow==
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3ba41c956d5so1159515b6e.0;
        Mon, 18 Dec 2023 04:10:12 -0800 (PST)
X-Gm-Message-State: AOJu0YzG6RiTJIx/Fl1igqIA/DTplZig0XtAMilO00auiTwMh+rSk9Pj
	hLtH7VCZF/vhPKNP/gdrfKinVBdds3eASjzLdtk=
X-Google-Smtp-Source: AGHT+IEZW3FQNw/4Vt+xM4dZm5GhhaMkBP3+ahQQDb7BO00WfUFjHcGrZ093eN/yg5n2w9j+/L5OcrfKTE6mzJ7gtRA=
X-Received: by 2002:a05:6808:f8b:b0:3ba:2508:abb1 with SMTP id
 o11-20020a0568080f8b00b003ba2508abb1mr3648183oiw.55.1702901412011; Mon, 18
 Dec 2023 04:10:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214222253.116734-1-ojeda@kernel.org> <CABVgOS=LXUzRD-c63sxn0FMfGWvxCPP1t_8nY5Xgk30Y9qMAcw@mail.gmail.com>
 <CANiq72kw326HyrDM0v0mFNu5jfb=eL1a+k-idr-5Vbc6_gmY2A@mail.gmail.com>
In-Reply-To: <CANiq72kw326HyrDM0v0mFNu5jfb=eL1a+k-idr-5Vbc6_gmY2A@mail.gmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Mon, 18 Dec 2023 21:09:34 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ7A79fMg3Teh7H+NRwnztrNU73s5C_fybUVH+vEX0YeQ@mail.gmail.com>
Message-ID: <CAK7LNAQ7A79fMg3Teh7H+NRwnztrNU73s5C_fybUVH+vEX0YeQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: rust: add `rustupoverride` target
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: David Gow <davidgow@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Nicolas Schier <nicolas@fjasle.eu>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, linux-kbuild@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 8:27=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Fri, Dec 15, 2023 at 8:38=E2=80=AFAM David Gow <davidgow@google.com> w=
rote:
> >
> > Would having similar targets for bindgen help? What about having this
> > install rust-src? Updating / installing those required a lot more
> > looking up of documentation (and then adding --force), so it'd be nice
> > if there were some way to do a similar override or make target.
>
> Which docs did you need to check? i.e. we have the commands for those
> steps in the Quick Start guide. I think you may be referring to the
> case when switching between LTS and mainline, due to the `bindgen-cli`
> vs. `bindgen` name change that the tool did (since that is where
> `--force` is required, not for normal upgrading or downgrading). That
> is definitely a bit painful :-( At least `cargo` mentions the need for
> `--force` in that case. Or are you referring to something else?
>
> I considered having a `rustupsetup` target (or script) instead that
> does everything (with a `BUILDONLY=3D1` option or similar, given some
> dependencies are not strictly needed for building), since having all
> this "switching logic" is useful, but then:
>
>   - I am not sure we should "hide" the details of the setup too much:
> I thought `rustupoverride` would be OK-ish because the output
> directory is needed (so it is justified) and the command is
> straightforward, but the others do not "need" that information.
>
>   - If we include `bindgen` there, it wouldn't be `rustup`-only
> anymore, so perhaps we would need another name like `rustsetup`. But
> that may mislead others (e.g. those looking at the Make help), because
> it is just one way of setting things up and it is not required.
> Perhaps this can be alleviated by not including it in the `make help`,
> so that everybody comes from the Quick Start guide and thus hopefully
> they have read the document at least diagonally :)
>
>   - Given there are different ways to set different sub-steps, and the
> fact that we don't have such a script for C does not have (please
> correct me if I am wrong -- I am aware of Thorsten's recent guide,
> which covers `apt` etc., but that is a Quick Start-like approach
> rather than automated script), I am not sure it would be welcome as a
> Make target (but perhaps it would be fine as a script?). Masahiro may
> have some guidelines here.



'make rustupoverride' potentially requires internet connection
if the required rustc version is not yet installed on the system.

Even if it is already installed, it changes ~/.rustup/settings.toml.


If I do rustupoverride per-directory,

$ make O=3D~/kernel/build0 rustupoverride
$ make O=3D~/kernel/build1 rustupoverride
$ make O=3D~/kernel/build2 rustupoverride

it would accumulate the overrides entries in ~/.rustup/settings.toml


Rather, I will manually do this one time for the parent directory:

$ rustup override set --path=3D/~kernel $(scripts/min-tool-version.sh rustc=
)


and use ~/kernel/build0, ~/kernel/build1, ~/kernel/build2
as output directories.



In principle, Kbuild does not require internet connection,
or proactively change the system setting.

If you want to provide a way for automated settings,
you can do it in a script you maintain.








>   - In the future we may have to change how the setup works or add
> steps, i.e. it is not 100% settled. Thus I am concerned about adding
> complex Make targets that users may start to depend on (i.e. with
> particular/complex semantics), vs. just having docs that are manual.
> For `rustupoverride`, it thought it could be OK-ish because it is just
> a single command and unlikely that it will change (and if we stop
> using it, we can make it empty with a warning and then remove it
> eventually; while it gets harder for more complex ones).
>
> What do you think?
>
> Cheers,
> Miguel









--
Best Regards
Masahiro Yamada


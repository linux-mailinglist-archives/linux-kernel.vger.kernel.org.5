Return-Path: <linux-kernel+bounces-3524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A42816D5A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D50F4B20DC5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55EC2032D;
	Mon, 18 Dec 2023 12:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LKUJGxHT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B93F1B282;
	Mon, 18 Dec 2023 12:07:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89C75C433CA;
	Mon, 18 Dec 2023 12:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702901221;
	bh=DrUER6FrPw2fjC9H9x1urksXUY0gGNG6zMiTe1yGdnU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LKUJGxHTrZ1gQyvq878M4w4HTVQcb8bbMxwpc19jT0HKCWZyr7ueaR6K9Nmol7qf4
	 oYBbD8AzPcLS+DHc2TbrwtzMr178ov8zgr2I7Jxfv58m6bGFAVjUojoZJ9MlcEH2Dj
	 qi69pp+NDQ/8Kav3JL/aUwfcOOOz+27WnDiUwk9SFR/pN6VrS1qJQT6FeRATOupFX9
	 8POziYZNVql6QVwrqMz0KFFD2lfeRP9FfvzHXTgMaeG5ZlwI17Ags7DaTZSvs9zYnI
	 9k0lKnHMvyELpUrEMLhHVNbbFTOHJrH01NGe0EUJPgM5MPGsVQQOA8BIlY7WjLg55H
	 NlcR6Bf/3H/bA==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-1fab887fab8so2526310fac.0;
        Mon, 18 Dec 2023 04:07:01 -0800 (PST)
X-Gm-Message-State: AOJu0YyFW6kC53iyOVWpp9ERjqzpi3NmNbENdme5lRRL3i35ULj+PzqF
	xvFdGbpwCvG3BQ3bo0lmsObtaxFGlGUMs9o6Hjg=
X-Google-Smtp-Source: AGHT+IHbXzdWjN3WLIrbJWsVdm5g8DLYEIA4IOfNJwqDUwnzQPJ+UKUh+M42CGcq0eJeYmSUPySQg3zPBGdpCR1G9Xc=
X-Received: by 2002:a05:6870:6b90:b0:203:7e47:3efe with SMTP id
 ms16-20020a0568706b9000b002037e473efemr7533561oab.64.1702901220899; Mon, 18
 Dec 2023 04:07:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e2b943eca92abebbf035447b3569f09a7176c770.1702366951.git.viresh.kumar@linaro.org>
 <1c03eb18-a6ac-45c8-8fea-46097bb4e132@gmail.com> <CANiq72=mvca8PXoxwzSao+QFbAHDCecSKCDtV+ffd+YgZNFaww@mail.gmail.com>
 <20231215064823.ltm55fk4zclsuuwq@vireshk-i7> <a2aca039-7360-476e-a1b1-e950698cd26b@gmail.com>
 <20231215112418.usky65sibhbiubyx@vireshk-i7> <CANiq72nuUpBCHaeyozDXAZrV+YLW_OR-QOUiVHPfTbNGG3RFXA@mail.gmail.com>
In-Reply-To: <CANiq72nuUpBCHaeyozDXAZrV+YLW_OR-QOUiVHPfTbNGG3RFXA@mail.gmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Mon, 18 Dec 2023 21:06:22 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS8kaRsWf6Grob5Vuj3eNx2c2=s+JmmshcXXJT2B4ph_Q@mail.gmail.com>
Message-ID: <CAK7LNAS8kaRsWf6Grob5Vuj3eNx2c2=s+JmmshcXXJT2B4ph_Q@mail.gmail.com>
Subject: Re: [PATCH V2] docs: rust: Clarify that 'rustup override' applies to
 build directory
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Tiago Lam <tiagolam@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Vincent Guittot <vincent.guittot@linaro.org>, rust-for-linux@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 8:53=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Fri, Dec 15, 2023 at 12:24=E2=80=AFPM Viresh Kumar <viresh.kumar@linar=
o.org> wrote:
> >
> > I thought people aren't required to enter the build directory now (but
> > just source code directory) and simply do:
> >
> >                 make LLVM=3D1 O=3D<builddir> rustupoverride
>
> Yeah, that is correct, but we don't need to write the `O=3D` in the
> commands themselves. The idea is that 1) the commands can be easily
> copy-pasted, 2) commands look simple (i.e. there are many other
> variations and options you may pass), 3) newcomers do not need to care
> about `O=3D` (so it is extra simple for them).
>
> > Will this still work if we are in the build directory ?
>
> Both should work (as long as the initial setup in the build folder is
> done, of course), so I think we can simply remove the mention about
> "enter ..." now and simply give the command.
>
> In fact, even if Kbuild did not support that, we could still remove
> the "enter ...", because then the `make` would need to be run like any
> other target from the source tree.



FWIW.

Kbuild is designed to be able to initiate 'make' from anywhere,
even if the build directory is not set up.

In that case, you need to use -f option to point to the top Makefile.



You can enter a build directory, then do this:

  $ make -f <path/to/source/tree>/Makefile defconfig all




Likewise, both of the following should work.


1)  Enter the source directory, and

  $ make O=3D<path-to-build-directory> rustupoverride


2)  Enter the build directory, and


  $ make -f <path-to-source-directory>/Makefile rustupoverride






> In other words, regardless of the
> answer, we could remove it thanks to the new target, unless I am
> missing something.
>
> Cheers,
> Miguel
>


--
Best Regards
Masahiro Yamada


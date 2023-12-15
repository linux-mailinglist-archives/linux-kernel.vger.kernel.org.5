Return-Path: <linux-kernel+bounces-836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1B98146DE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EE9B1F23289
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06972510D;
	Fri, 15 Dec 2023 11:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejYLrVyw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EEE24B47;
	Fri, 15 Dec 2023 11:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5cd81e76164so4594677b3.1;
        Fri, 15 Dec 2023 03:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702639651; x=1703244451; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=smDGabhS7vctxpO+deRKUcMYfvvkEi0FhsbNu+lkOzE=;
        b=ejYLrVyw97T5qygNZC7LN3aJ2mLL+0qxzWrJXvz1faNviNWdabvrI9qage5q9MAu4F
         O0EUFDQdcgQNdGavEPnmmcgEPq8Mmf3LQUXpM4GZ6JiLR2/p3OnNhaNGo0ajYyXVNEE3
         4BMnRLDufgMcbD4dXwFWZJEkkjMgwtk+h+nD2Oa90BoSfVWVfTMqhMXVJQNeon9WtdiH
         cQ0OgJqXe5SvH0ntObi7cvc1jErvo7dZrCCZ6M0Abuc+ZKikBN/4hqxJoG5k3tjaiul4
         hTGgGN6lgumxoIGjvEC/5j7HRpSX2GgNPBjX6FZtZ0URNrnAHxqmzfjYstvTD5tNuQzF
         qfKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702639651; x=1703244451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=smDGabhS7vctxpO+deRKUcMYfvvkEi0FhsbNu+lkOzE=;
        b=qOBHXabCNfFR6UQdr72LEkcP1nahB6f9A+I2GGJip4+MO5PFtEqSx2Bi6vyPvXGlxo
         ZJThSZjipAz2SXGWVOCfEhoudbcoxlPOz2eodANO+qi0IR5AEEZAiy+1bUHC0FSkhJti
         8+dM8EwewX9DGJpXhBaF62sj8s1zygojD5/aBp7V2BXQdqmcOtRkuqQIYp8mJG7S3xJh
         NQDTGX8SvhqecIQdgJm11c0Kb/HvU3/8Z4Nbut4Vr5OJsZjwAUoDcSDcwHY+AwSpJpP0
         uKkjN48Hy4ytdSu5CIl4fu2O3RwvjNRoOpbw+53D2/FyC4pokvl8KNQDVp2zWH48EFz1
         X14Q==
X-Gm-Message-State: AOJu0YzlvA3OOg/BnlW8rBuk21HSTusEjtjPpOBGNb3P6tpzqnM0URls
	phpPs1dUuJSkJ9koP87bZQpJFfTEfVXFZLTr8LM=
X-Google-Smtp-Source: AGHT+IGuFMMv68nUKNuq0aC/6kTpHtWXckeCIHxhvxv90ZN2tNAgt3p9+Pw0AKRTRjXfsBMA1xCqGKaRoRHmreap3fg=
X-Received: by 2002:a81:48c1:0:b0:5e2:62c0:f18b with SMTP id
 v184-20020a8148c1000000b005e262c0f18bmr4604862ywa.37.1702639650776; Fri, 15
 Dec 2023 03:27:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214222253.116734-1-ojeda@kernel.org> <CABVgOS=LXUzRD-c63sxn0FMfGWvxCPP1t_8nY5Xgk30Y9qMAcw@mail.gmail.com>
In-Reply-To: <CABVgOS=LXUzRD-c63sxn0FMfGWvxCPP1t_8nY5Xgk30Y9qMAcw@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 15 Dec 2023 12:27:19 +0100
Message-ID: <CANiq72kw326HyrDM0v0mFNu5jfb=eL1a+k-idr-5Vbc6_gmY2A@mail.gmail.com>
Subject: Re: [PATCH] kbuild: rust: add `rustupoverride` target
To: David Gow <davidgow@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, 
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

On Fri, Dec 15, 2023 at 8:38=E2=80=AFAM David Gow <davidgow@google.com> wro=
te:
>
> Would having similar targets for bindgen help? What about having this
> install rust-src? Updating / installing those required a lot more
> looking up of documentation (and then adding --force), so it'd be nice
> if there were some way to do a similar override or make target.

Which docs did you need to check? i.e. we have the commands for those
steps in the Quick Start guide. I think you may be referring to the
case when switching between LTS and mainline, due to the `bindgen-cli`
vs. `bindgen` name change that the tool did (since that is where
`--force` is required, not for normal upgrading or downgrading). That
is definitely a bit painful :-( At least `cargo` mentions the need for
`--force` in that case. Or are you referring to something else?

I considered having a `rustupsetup` target (or script) instead that
does everything (with a `BUILDONLY=3D1` option or similar, given some
dependencies are not strictly needed for building), since having all
this "switching logic" is useful, but then:

  - I am not sure we should "hide" the details of the setup too much:
I thought `rustupoverride` would be OK-ish because the output
directory is needed (so it is justified) and the command is
straightforward, but the others do not "need" that information.

  - If we include `bindgen` there, it wouldn't be `rustup`-only
anymore, so perhaps we would need another name like `rustsetup`. But
that may mislead others (e.g. those looking at the Make help), because
it is just one way of setting things up and it is not required.
Perhaps this can be alleviated by not including it in the `make help`,
so that everybody comes from the Quick Start guide and thus hopefully
they have read the document at least diagonally :)

  - Given there are different ways to set different sub-steps, and the
fact that we don't have such a script for C does not have (please
correct me if I am wrong -- I am aware of Thorsten's recent guide,
which covers `apt` etc., but that is a Quick Start-like approach
rather than automated script), I am not sure it would be welcome as a
Make target (but perhaps it would be fine as a script?). Masahiro may
have some guidelines here.

  - In the future we may have to change how the setup works or add
steps, i.e. it is not 100% settled. Thus I am concerned about adding
complex Make targets that users may start to depend on (i.e. with
particular/complex semantics), vs. just having docs that are manual.
For `rustupoverride`, it thought it could be OK-ish because it is just
a single command and unlikely that it will change (and if we stop
using it, we can make it empty with a warning and then remove it
eventually; while it gets harder for more complex ones).

What do you think?

Cheers,
Miguel


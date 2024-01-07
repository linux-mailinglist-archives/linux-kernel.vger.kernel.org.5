Return-Path: <linux-kernel+bounces-18880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 900E8826482
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 15:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32C9BB214C4
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 14:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F00D134C6;
	Sun,  7 Jan 2024 14:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JYizFOa7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C61134B3;
	Sun,  7 Jan 2024 14:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6dc02ab3cc9so886634a34.3;
        Sun, 07 Jan 2024 06:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704637771; x=1705242571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eGfKDZU2v02JYj8j4xt04rkLEro10sjs/HZeZU+mIfg=;
        b=JYizFOa70HBccYJOoZAJc2NAY4qe3jkaJK40VJsfbmP+qyx4qSxz5C86x2zVTiKtTi
         2FGwLjB5W7+86yoA7BlmPYR481bRau6p3K0ALhZ8vb4E+fAw9T1W+mfN1xOsOEzlanpW
         Ln4+oD1y9SFy1oKrEhW7GQO68qrHnogUnUnUB1i8cDs4Ww140kSEDs9Nt2sUQAnc7BSt
         0wDkcI67lGUQhuA4XZSeOBFRmIDNAq/lXTJhKLjg1jep7f4ihzD0cV1JMJaQNYi4Mmi9
         KesOOg2yb8/fq0l/732ukqRepgtDYHbRUujzifuemKMULtjS654p+y3bXar+mbiwrTWM
         lcrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704637771; x=1705242571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eGfKDZU2v02JYj8j4xt04rkLEro10sjs/HZeZU+mIfg=;
        b=WX7NkfFxIC1SH+XjmULXGAT/RRx8kercdU4G/jjLhoE9xbKzU+3z1XUgtoiILBfB7G
         iRWuu0FP4l/Afb+b5DWEvUs4+jjzwvtjljOPzP8arO1CNqH2szADNi+UDVlH0E7GbZva
         1kcpsw0/xZxr2d3vrUrMPjw4dYb+q1iNB0YM1koA6uw8oH1hgeFHK2knzKOrHsKbhmhk
         0KYXF5I1nJTkV/gSg9laI3PLGDSKT8fU2fo1Cp1kE8MPJjKxutJTjgjAATvaFFXFICJy
         tHOjChqnUwbE7Ls4FzUCEnUIu+D1Q///LY93v8qa8sFlOK2XdWptXq6isWR/H/bgC389
         7VWA==
X-Gm-Message-State: AOJu0Yy1/YvtgFSpYb2Ep/ZFhFvOBa7gtNkFb6jVUB8/GOTobPHkdV/M
	DAF5cjQgXacRUUOXdtNu/fMX31rcEQ2oABNehbg=
X-Google-Smtp-Source: AGHT+IGN0eC3tUJD1D2LgL2Ag3j92/KIUXQUEmoyoyxjkJa09kgyiqq1FJMICAshXVC9CqeiXAALCcuMb3opn+/A8cc=
X-Received: by 2002:a05:6830:314e:b0:6db:e5a0:f142 with SMTP id
 c14-20020a056830314e00b006dbe5a0f142mr2422716ots.58.1704637771617; Sun, 07
 Jan 2024 06:29:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240106065941.180796-1-wangrui@loongson.cn>
In-Reply-To: <20240106065941.180796-1-wangrui@loongson.cn>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 7 Jan 2024 15:29:20 +0100
Message-ID: <CANiq72=M5TrUL+9Z0nqKKcD=KHwyDA79fNYHgU2EJ+7u6Ct8qw@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Enable initial Rust support
To: WANG Rui <wangrui@loongson.cn>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, WANG Xuerui <kernel@xen0n.name>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-doc@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 6, 2024 at 8:04=E2=80=AFAM WANG Rui <wangrui@loongson.cn> wrote=
:
>
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>  Architecture  Level of support  Constraints
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> +``loongarch`` Maintained

On top of what Huacai said, it would be nice to add another character
and realign the table so that `loongarch` it doesn't overflow (perhaps
best done in an additional, previous patch).

> +    } else if cfg.has("LOONGARCH") {

Would it be possible to do it without a custom target in
`scripts/generate_rust_target.rs`? If it is not possible (e.g. there
is something that you cannot tweak otherwise on top of a built-in
target via the CLI flags), it is fine to use a custom target for the
moment.

For instance, this is how ARM is doing it:
https://lore.kernel.org/rust-for-linux/20231020155056.3495121-1-Jamie.Cunli=
ffe@arm.com/

Thanks!

Cheers,
Miguel


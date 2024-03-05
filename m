Return-Path: <linux-kernel+bounces-92039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1D9871A17
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91E5C1F217DE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D29C5473D;
	Tue,  5 Mar 2024 09:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGMCiHho"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B460E548E7;
	Tue,  5 Mar 2024 09:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709632732; cv=none; b=T9GyEa3FPQuMs425F5la+rBr7Xiq1oiZh0KofBeJJC2+0DI7W6L4odrI7RYtRTK2JdK9YfIphMsuMCWxTP6owHBiTpZSKkHPZZ2wKJMhMzMpAyNyUEgi0IcSBTgVJybUTbW3t+dzPWKfdiSOTl0EHSy5sUHDFcPKFFuR73Arp60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709632732; c=relaxed/simple;
	bh=xQNCkif+cWsWirZCvZKKjYkiBuTmgq18brMqbbYj1mE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MUZxUom3VMo8r+k8Fuly/GxNvxQHk/mkCV9c4KKuoADT/bUNpRa2PxddV/49pVDjc9Wxqh4hMGZl82LYzVVo+YdgE/CFM387FABgKypwm9VuJEvbtd5D1G1xcpkfeQ8ZLkioJ2OrRQBdbhNb/ZaDB3kO2pM+lOWj1aqSKpbik9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hGMCiHho; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D484C433F1;
	Tue,  5 Mar 2024 09:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709632732;
	bh=xQNCkif+cWsWirZCvZKKjYkiBuTmgq18brMqbbYj1mE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hGMCiHhofokcRE5JfgFOBmTbR2XvK/+ESy9pkicvirbuwtTsk1FbvVUXIhiCnwF2f
	 jieg7Kj4Bk+aps669t2TBWsrzfNvn38QLIIb0+PAkxhlRnEql5eqqJIlXQmvMwYkD/
	 q7cS6ET+3pUkCio0gPek9feIWB4Rvv++16nCaasTJmbE0WDuaFPRpP8l+wTr08ZEZv
	 /mQCyNYuw70l97csKHeQ1aBmIHllTVcu0eUY02wcMjzg5C+aeE8uLKQt1DVVZmKWts
	 YwOmqx3MPMfve5ys98I/9UKTXbeujBJ1VxkC3ujAE2//eBM4OXTntL7CsTVUljuhQe
	 YYKAU4gazCqjg==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a3566c0309fso55347366b.1;
        Tue, 05 Mar 2024 01:58:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWMsrR6pLKS8xqoaUrfFnIhE1VF2zy4083+XEKsi0doB6jBOBLBk+IDzp0Y1C0hAXWZOT/R1ipy+pNm+s5roUZGKE2lyhPly8JFkYmkfiYrQWdjqtn2CLp81XgsRozNjKTNXPhy/oI4PxrO1Ko=
X-Gm-Message-State: AOJu0YwwWiA9rUvg1PtMDf4ykOys/UIwbNe4j4jCGrbXRcnOc9ZRuCSd
	kjcnP6Rof/HdNGwSdVtSwp697lH7ReEug1bj6THn9DBHpGdjMlky6XFT/Wad7cMJwgkjmaIQKJR
	vE5jpY5zD89+PE2XlBBUTS35SBXA=
X-Google-Smtp-Source: AGHT+IHiIQAvS5A4oVe//HltDZalqGs0CsEdZNSpWCZkYfoXaxa5FGY1eSNm6bboOTqxb3P0NPqbFzJ01MJjvR8bpAk=
X-Received: by 2002:a17:906:aac5:b0:a45:3271:6c80 with SMTP id
 kt5-20020a170906aac500b00a4532716c80mr3542530ejb.25.1709632730800; Tue, 05
 Mar 2024 01:58:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304141426.163517-1-wangrui@loongson.cn> <CANiq72mvdVrzN19PC8pNrvuBLkOEEQ3yX0WG6JcWc+RVaSM2nA@mail.gmail.com>
In-Reply-To: <CANiq72mvdVrzN19PC8pNrvuBLkOEEQ3yX0WG6JcWc+RVaSM2nA@mail.gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 5 Mar 2024 17:58:42 +0800
X-Gmail-Original-Message-ID: <CAAhV-H666zsMadZuzvcRxxkUxSpkka1tt9AJO_WctHDL8j_HNg@mail.gmail.com>
Message-ID: <CAAhV-H666zsMadZuzvcRxxkUxSpkka1tt9AJO_WctHDL8j_HNg@mail.gmail.com>
Subject: Re: [PATCH] loongarch: rust: Switch to use built-in rustc target
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: WANG Rui <wangrui@loongson.cn>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, Jamie Cunliffe <Jamie.Cunliffe@arm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, WANG Xuerui <kernel@xen0n.name>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Miguel,

On Tue, Mar 5, 2024 at 12:07=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Mon, Mar 4, 2024 at 3:14=E2=80=AFPM WANG Rui <wangrui@loongson.cn> wro=
te:
> >
> > This commit switches to using the built-in rustc
> > loongarch64-unknown-none-softfloat target for LoongArch.
> >
> > The Rust samples have been tested with this commit.
> >
> > Signed-off-by: WANG Rui <wangrui@loongson.cn>
> > ---
> > base-commit: ("rust: Refactor the build target to allow the use of buil=
tin targets")
>
> I couldn't apply it on top of commit f82811e22b48 in arm64's tree
> (which is the base? -- the offset differs significantly in the arch
> Makefile), but I nevertheless applied it manually on top of that one,
> build-tested it for loongarch64 and boot-tested it for x86_64:
>
> Acked-by: Miguel Ojeda <ojeda@kernel.org>
> Tested-by: Miguel Ojeda <ojeda@kernel.org>
The base of the loongarch tree doesn't contain the arm64 modifications
now, so this patch is better to be applied on the rust tree with my
Acked-by. But if you have some trouble doing that, I can also manually
merge the arm64 parts to the loongarch tree, and then apply this
patch. Thanks.

Huacai

>
> Thanks!
>
> Cheers,
> Miguel


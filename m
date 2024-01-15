Return-Path: <linux-kernel+bounces-25603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F8682D34B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 04:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A2631C20DD7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 03:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0EF20E3;
	Mon, 15 Jan 2024 03:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UwzluulG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED061842;
	Mon, 15 Jan 2024 03:23:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60AFAC433F1;
	Mon, 15 Jan 2024 03:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705289032;
	bh=zVQ4Atjg+ZZXRw35BNYzt6eRLBSNn7IT89ZOhNOYHh0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UwzluulGpswDZu/e/NAeK7k8IsGLqOyBFpxkP29pXfVmi3Gvn569ub7FRhMyIkvR5
	 OSVn7a5b374DCez11xZDXpO1LP8TYoHr6lD++TEr+mff353sDc7PDMNeQQDJc290QM
	 entoRdaDOiiXRFcvNtqIiUnTV+YWgbtgOn37a6EsumFPNbHt9iuwm+6R2LZ1uBQ2hi
	 6REjtiyVNU9O3sLbDmEqpOWpb1NV0KoMD9zd6uRGInRnxkkTHZrscQUtNMpbUCmp+8
	 yhr++pD2YQjWMheSxxlYWcGvCyzJeXYCvO3n9JQgQqMr3h6YKWbZdmf/pbgAbivxqz
	 EscAFqJ2iF1eQ==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a26f73732c5so952027266b.3;
        Sun, 14 Jan 2024 19:23:52 -0800 (PST)
X-Gm-Message-State: AOJu0YxfZCiyuKrtvqQaAjiKXjGThe7SNMZMtf5kXcCxiCfdkpap/eZw
	++R+897FXflm4fMWk7CNs4ATXX+mhqvwuxjP+k0=
X-Google-Smtp-Source: AGHT+IGBw5yLuMBlpzqrb4QV0zgXvIN5QCGmmQPXNht56SQVwgPF/JD5WcbK+/kmXco6k37C8XFr71yW2zOsF3NW6bg=
X-Received: by 2002:a17:907:9515:b0:a28:88d6:5d9c with SMTP id
 ew21-20020a170907951500b00a2888d65d9cmr2067170ejc.131.1705289030867; Sun, 14
 Jan 2024 19:23:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108032117.215171-1-wangrui@loongson.cn> <ZZ2fn0scbDKBXWe5@boqun-archlinux>
 <CAHirt9iox8FGV2wrMyxwFRjab2avfOcyLKvBc9K=AqiHxqHXKg@mail.gmail.com>
 <ZZ38XMQw18mw2sTA@Boquns-Mac-mini.home> <CAHirt9jQSVvBF=1wc=sT9FxngeSP30P4FDpu8m0JH_0fOPSO-w@mail.gmail.com>
 <CANiq72=X3cggAn0HLMi7jVFAfypBhog=ZkPB57yfaX4ZUzT-HA@mail.gmail.com>
 <CAHirt9hdtGSsEofxDb0FCtcFeAw9n9LKJALz23Qdqh4n2=Ua5A@mail.gmail.com> <CANiq72n7K8LcKrs+beF2sbt1XLdr4zEhEw4xcy3yh4wgTrvYeg@mail.gmail.com>
In-Reply-To: <CANiq72n7K8LcKrs+beF2sbt1XLdr4zEhEw4xcy3yh4wgTrvYeg@mail.gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 15 Jan 2024 11:23:41 +0800
X-Gmail-Original-Message-ID: <CAAhV-H72Hbfy7n6+AFSFFOzizo0GtpzA074sgo48-W-Dt0VR+w@mail.gmail.com>
Message-ID: <CAAhV-H72Hbfy7n6+AFSFFOzizo0GtpzA074sgo48-W-Dt0VR+w@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] Rust enablement for LoongArch
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: WANG Rui <wangrui@loongson.cn>, Boqun Feng <boqun.feng@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, WANG Xuerui <kernel@xen0n.name>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-doc@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Miguel,

On Sun, Jan 14, 2024 at 11:44=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Thu, Jan 11, 2024 at 4:16=E2=80=AFAM WANG Rui <wangrui@loongson.cn> wr=
ote:
> >
> > 6.8
>
> Thanks, that is quite expedited...
>
> Please `rustfmt` the code to avoid failing the `rustfmtcheck` target.
> I see you already created the 6.8 tag but I have not seen it in
> linux-next yet and you did not send the PR, so it would be ideal if
> you could fix this before it goes to Linus.
>
> diff --git a/scripts/generate_rust_target.rs b/scripts/generate_rust_targ=
et.rs
> index 3edda6a10..0da52b548 100644
> --- a/scripts/generate_rust_target.rs
> +++ b/scripts/generate_rust_target.rs
> @@ -163,10 +163,7 @@ fn main() {
>          ts.push("target-pointer-width", "64");
>      } else if cfg.has("LOONGARCH") {
>          ts.push("arch", "loongarch64");
> -        ts.push(
> -            "data-layout",
> -            "e-m:e-p:64:64-i64:64-i128:128-n64-S128",
> -        );
> +        ts.push("data-layout", "e-m:e-p:64:64-i64:64-i128:128-n64-S128")=
;
>          ts.push("features", "-f,-d");
>          ts.push("llvm-target", "loongarch64-linux-gnusf");
>          ts.push("llvm-abiname", "lp64s");
>
> Thanks!
Thank you for your suggestion, but since this will be replaced by the
built-in target soon, and I don't want to change the tag to make Linus
unhappy. Let's leave it as is.

Huacai

>
> Cheers,
> Miguel


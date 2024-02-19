Return-Path: <linux-kernel+bounces-71001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB1E859F37
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29E182812C4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E9223755;
	Mon, 19 Feb 2024 09:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ufb9csAu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAA123763;
	Mon, 19 Feb 2024 09:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708333582; cv=none; b=f8n3J9JY43GLDP3ZAbwn33/ShFh4iqM4b1D1SzgPrifiWDYN2TgG5o1Ac3d94AhoQl2LAdXFPY9YbkGm94bH1lCNu7T/FUHFbw2YrNt5mzXqIwtnKiWmg+OU4Vb9OvrRYeYof/XghhUJHaEybf3icDLT8bXBmIGvK7JdB59tiVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708333582; c=relaxed/simple;
	bh=Uai0kd7i8VGE9hFUSFSUJh8cm8BNvR9mpqVA7T0AYAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KGEECJMphfeOFtnu9FhUlT1p+gviqr55Lz6K8phEiQF7tlEoNb2Nyn2TSLkCBCkX4qWnAYl3ydOGyZNOgMu6/F3CqYeCWn84ZuscOzmQUx860+npiF70QeqmxB5PeRPwhXQiTN5jXvrLKpOGE2eyVqwEDyiyODf1wOVrCyEbRUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ufb9csAu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EC5DC43601;
	Mon, 19 Feb 2024 09:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708333582;
	bh=Uai0kd7i8VGE9hFUSFSUJh8cm8BNvR9mpqVA7T0AYAU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ufb9csAuxDd5XY6B4h1hJv+la5QISLKB5Ziwdc//b9QkwtecK0Uw4zFxr64s2qeHr
	 oOJ8jgDtjA3mrZcPo/2K3c0a0QQ2+HAUS12OzJQpCL2aglQsvru/z+2mSKqzkDA1Oa
	 hzo5TAxgoPDCTz0y38DTUC8Q6sBEBHaSKLzR6Ye/6ocVRNJTMttxwyG86vid1sg7i/
	 VLXSu1HDenPSkHLPvs77VvU2ACWQuzM1uZYPZUfcpy4ekqRoVgfnHa8nWNju8TPCKd
	 oR+kaQm4FjwkMxSPZjVDDX7mYK5ZJHHUeJCHyAqywJe7DWtqe0riyF1gRr8IseTkBO
	 ahCswAFs6vMGg==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-512bce554a5so201929e87.3;
        Mon, 19 Feb 2024 01:06:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVKTEFAYL2rKQp1ErM4/sH2xyy5+9Vh3gEriuuW6cj/AJYQNmNpUj5/+VRdjtdiLYE6PQEAYVWWtfV0zlZHxP7pmFbNBjWpDXIRP75Qn9JvIVVEpNR/2t/5d9+gRWxau0KFu11GTNwKxv1o9+c9mAdvYWheihiSgVn7SuESmtc3pg9pVxlHeOv0Tq4=
X-Gm-Message-State: AOJu0YzSUfFMk/ZhMejrl0gRKKw2FbSEzmrZ1TfPAHO2SeBu/VYVGG0f
	nMQhp8Vf9oFo7+vu6n+8AdknvTHSL1PM6BIDWK+0dAM09EQYy5kU30v90c++FEu/4cvS8jX2Bn7
	YNtrzRye1DbWzHH+UsRpbmdZThZ0=
X-Google-Smtp-Source: AGHT+IFTnhLLDv2fjimXNtQph5eMOf2MRalN4zjLIUFKcQXJwgpPjyDtgjLDZbhq2rEi6Ff9dDp6pMnAW7fNoaBQ/zw=
X-Received: by 2002:ac2:447a:0:b0:512:b26f:d7d6 with SMTP id
 y26-20020ac2447a000000b00512b26fd7d6mr1500700lfl.5.1708333580696; Mon, 19 Feb
 2024 01:06:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231104211213.225891-1-yakoyoku@gmail.com> <CAK7LNAT4zKWn6+scn5wbaN2_x4wh4EYSuNxnaoQK1FfJK45MOw@mail.gmail.com>
 <e3562896-2d4f-42cd-be7f-6c7fb7fd08a1@gmail.com>
In-Reply-To: <e3562896-2d4f-42cd-be7f-6c7fb7fd08a1@gmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Mon, 19 Feb 2024 18:05:43 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS+euKhXrU7dxLG40TVvE43e3R-3jyfUH21Y8skZdHjfQ@mail.gmail.com>
Message-ID: <CAK7LNAS+euKhXrU7dxLG40TVvE43e3R-3jyfUH21Y8skZdHjfQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 0/2] rust: crates in other kernel directories
To: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 1:11=E2=80=AFAM Martin Rodriguez Reboredo
<yakoyoku@gmail.com> wrote:
>
> On 11/13/23 11:13, Masahiro Yamada wrote:
> > [...]
> >
> > I will not provide a line-by-line review.
> >
> >
> > Just one thing I'd like to point out.
> >
> > You assume the library (drivers/usb/core/*)
> > is built before its consumers (samples/rust/*).
> >
> > If Kbuild ends up with building lib consumers first,
> > it will be a build error.
> >
> >
> >
> > Kbuild descends into multiple directories in parallel building.
> >
> > You cannot predict which directory is built first.
> >
> > [...]
>
> Thinking with what you've said the same thing might apply to any Rust
> written code that depends on crates under the `rust` dir. Adding
> Make dependencies to object code made from `.rs` will be required if so,
> assuming that Kbuild is intelligent enough to build the crates first.


rust/Makefile specifies dependencies between crates.

I do not know how to specify crate dependencies
across multiple Makefiles, like you did in
drivers/usb/core/Makefile and samples/rust/Makefile.



--=20
Best Regards
Masahiro Yamada


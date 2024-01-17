Return-Path: <linux-kernel+bounces-28517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C6782FF98
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 05:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F01421F252AE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 04:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BBD6FDC;
	Wed, 17 Jan 2024 04:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CXDf1qJb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B602A67C72;
	Wed, 17 Jan 2024 04:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705466082; cv=none; b=SjIg62XmAes+/eqmHH6RER1rA7D13bRjtHkj9HMnriChMJya+7+aWu4izog9UCBiXXovJ2acmEaA1eaJv+fm9KsKWj+yt93NiiMZ7/6ZgjqgghuwMUaV6SSORFmroYZpheYV4St2y8a8l/3URT+eA8XEn3ixP85xTMk7Dhh2f4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705466082; c=relaxed/simple;
	bh=M0lHeEIbJSP8UEtQ7BzZHEeSSX3emAVPVhi6TmOdTmw=;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:
	 X-Google-Smtp-Source:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding; b=l5t3G4u9sTzvtWMmZpKMB4r3CPU6CfjL6qvE5giOu9zwME+nomxtDSc4y4dmxOBxvPc/IQWaqbd975pcCCuQYKePxUToOJOwXcrcj4jIxLI8GNdSwEahIZ2+EAMdlYj4a81pmWkfyt71CawJGZI/Cau/FslhL9mkYhbp1XEj67k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CXDf1qJb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35F65C433B2;
	Wed, 17 Jan 2024 04:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705466082;
	bh=M0lHeEIbJSP8UEtQ7BzZHEeSSX3emAVPVhi6TmOdTmw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CXDf1qJbqvdXoXU8dg7DU5ubXNQ7WNA9aX1ilbJscd7JrxbkXjjJ/HkYslSojP7d1
	 SZty9DEOw32ezbbNxF1uFPxjBzR/Wk3CVNwrHoczaPtWfKBvj0P1kMS5myspvnTFjf
	 WvtyjclcPMdCfaiHDMBhhyvKGwUYf6S1WjXYQvdTiC6XQASQ3KPr06lNk6qZdOYGYm
	 qEQIjWXFHn9Ra+7yDAzNkgQYljtNGaH9N7vuTmBRwFS0aJtgKsazR6yryDu0/AUPlB
	 7xL51I82l02yVMBLdlqOYJIFbcFTVuS10ISG39hTPjNxGTEJwtwma608nNzZ901cT2
	 Z16Gv4+XL9t8g==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50ec948ad31so10564127e87.2;
        Tue, 16 Jan 2024 20:34:42 -0800 (PST)
X-Gm-Message-State: AOJu0YwEfLEHZK77U+xtLhg/iQc2HVX1EQ2HVY0/zSjLN0dGl7TvijM5
	Mra1rJ7ayNQRt8vnlPM/Uj0vBbcTBxtC0i2gDtE=
X-Google-Smtp-Source: AGHT+IFBqnMfUgM4CRX5wiiomwTy15C6kBIJjo72WKWNLc+dQEyC4hkYoiqfUivkJJafe+zfYxjuMnrYThXWHtq4MnY=
X-Received: by 2002:a05:6512:3a86:b0:50e:7d6b:b5b2 with SMTP id
 q6-20020a0565123a8600b0050e7d6bb5b2mr4765644lfu.6.1705466080318; Tue, 16 Jan
 2024 20:34:40 -0800 (PST)
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
 <CAHirt9hdtGSsEofxDb0FCtcFeAw9n9LKJALz23Qdqh4n2=Ua5A@mail.gmail.com>
 <CANiq72n7K8LcKrs+beF2sbt1XLdr4zEhEw4xcy3yh4wgTrvYeg@mail.gmail.com>
 <CAAhV-H72Hbfy7n6+AFSFFOzizo0GtpzA074sgo48-W-Dt0VR+w@mail.gmail.com>
 <CANiq72mEPnB7yEZvtUXAM5w0GgYmzdrM9OhioLGb_LzbAJKNOA@mail.gmail.com>
 <CAAhV-H6BFkgN-KzEexXk9zdnOGNCdBesCEEaczEvEp8x2K2YHw@mail.gmail.com> <CANiq72nv3Uw8GLNqbdGBC3b+viF+o8BeppS9KWhpzBFvjqZLUg@mail.gmail.com>
In-Reply-To: <CANiq72nv3Uw8GLNqbdGBC3b+viF+o8BeppS9KWhpzBFvjqZLUg@mail.gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 17 Jan 2024 12:34:29 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4-dfBN3icg6kczRiZ67DOX66M-vXXCrz7Me0iunp8kRA@mail.gmail.com>
Message-ID: <CAAhV-H4-dfBN3icg6kczRiZ67DOX66M-vXXCrz7Me0iunp8kRA@mail.gmail.com>
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

On Tue, Jan 16, 2024 at 11:16=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Tue, Jan 16, 2024 at 10:31=E2=80=AFAM Huacai Chen <chenhuacai@kernel.o=
rg> wrote:
> >
> > OK, since Linus said the merge window is paused now, I rebase and
> > retag my tree and the Rust commit is like this, I think this is
> > perfect now?
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongs=
on.git/commit/?h=3Dloongarch-next&id=3D706f9e1ab7c7a58d80ef2c87d8720131253a=
2256
>
> Thanks a lot! That works, yeah.
>
> I also took the chance to build LLVM and QEMU and I tested the tag --
> it seems to work: I see the samples (built-in) printing in the kernel
> log :)
>
> So in case you end up rebasing for another reason and want to add it,
> even if it is a simple check I did:
>
> Tested-by: Miguel Ojeda <ojeda@kernel.org>
OK, if Xuerui updates this patch, then I will rebase again.
https://lore.kernel.org/loongarch/CAAhV-H7KteJvRVpj3Hz-Ui9VnmijcJq5D1Tb-KJv=
qTO_+jjp2Q@mail.gmail.com/T/#t

Huacai

>
> Cheers,
> Miguel


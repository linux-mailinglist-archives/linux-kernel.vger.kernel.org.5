Return-Path: <linux-kernel+bounces-27174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0D382EB8D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDE911F24164
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 09:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9C612B96;
	Tue, 16 Jan 2024 09:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="unN+9lmG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B5E12B7A;
	Tue, 16 Jan 2024 09:31:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2899BC43142;
	Tue, 16 Jan 2024 09:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705397510;
	bh=VLP6UgFM96N7y+o2qdkKbSUFQq0ljlGSoU8LbFEeobY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=unN+9lmG5I30QesWUCKaoL5o3AgVB4FIkuK8XMYneyhX0DMYpe83oEel57kmTBsEa
	 xK3QGZ4w1ZK/GnZK11fDsFiYZH06ibO4QbvbYzZxKAqoS6g0oO92nYHITmghW4335n
	 fy5/TRlxNh3MEUCYwzPngBRjMZYAr11P1qaj978i7W2tlO/wYL3tJtRAzXiuD07P1V
	 +SIYOWetQHxWKthhhmy9O18POg2x8PhrmYJ0H9KaOkoorK4ftAXUty3uVWhJjVCkUq
	 jTywdSrT+YH0Xy11sL0DE2m5B++HHf/HOGIgNj4NT+BE4IAN/+0jAKCJK9axnT6vo5
	 xsbSgdKQY8x8w==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-559afecee33so276202a12.1;
        Tue, 16 Jan 2024 01:31:50 -0800 (PST)
X-Gm-Message-State: AOJu0YwUtASq3ft5DM+ezkVG7Ve2CLMjmV4ebqY2ud6LucSEPVimt1qf
	+EAYLlKiHniXYSt1hsJUIOmNwM3XeR21kjzTVfI=
X-Google-Smtp-Source: AGHT+IGCUpSuIQgXHJTAuQmb/QACibD64SWuIXhc3fCqJpxMZRy6D1FcLP/Vc55ljvPLouJWBYUz2y+IU1A8msEcz6I=
X-Received: by 2002:a17:907:d38a:b0:a2c:b31f:f076 with SMTP id
 vh10-20020a170907d38a00b00a2cb31ff076mr4347078ejc.124.1705397508471; Tue, 16
 Jan 2024 01:31:48 -0800 (PST)
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
 <CAAhV-H72Hbfy7n6+AFSFFOzizo0GtpzA074sgo48-W-Dt0VR+w@mail.gmail.com> <CANiq72mEPnB7yEZvtUXAM5w0GgYmzdrM9OhioLGb_LzbAJKNOA@mail.gmail.com>
In-Reply-To: <CANiq72mEPnB7yEZvtUXAM5w0GgYmzdrM9OhioLGb_LzbAJKNOA@mail.gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 16 Jan 2024 17:31:36 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6BFkgN-KzEexXk9zdnOGNCdBesCEEaczEvEp8x2K2YHw@mail.gmail.com>
Message-ID: <CAAhV-H6BFkgN-KzEexXk9zdnOGNCdBesCEEaczEvEp8x2K2YHw@mail.gmail.com>
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

On Tue, Jan 16, 2024 at 12:08=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Mon, Jan 15, 2024 at 4:23=E2=80=AFAM Huacai Chen <chenhuacai@kernel.or=
g> wrote:
> >
> > Thank you for your suggestion, but since this will be replaced by the
> > built-in target soon, and I don't want to change the tag to make Linus
> > unhappy. Let's leave it as is.
>
> The issue is not a big deal and I appreciate that you made the effort
> to enable Rust for your architecture. However, please note that we do
> our best to maintain a clean formatting state for Rust code (i.e.
> `rustfmt` should be run) and that people may see this in tests/CIs
> that use the Make target.
>
> I don't think Linus would mind too much, and you could point him to
> this email if you want (or you could put the fix on top); but if you
> really want to keep the tag as-is, then we should consider it as a fix
> for this cycle, i.e. we should not wait for e.g. the next cycle for
> the built-in target. Could you please send it through your tree as
> soon as possible?
OK, since Linus said the merge window is paused now, I rebase and
retag my tree and the Rust commit is like this, I think this is
perfect now?

https://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.g=
it/commit/?h=3Dloongarch-next&id=3D706f9e1ab7c7a58d80ef2c87d8720131253a2256

Huacai

>
> Cheers,
> Miguel


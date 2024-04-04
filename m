Return-Path: <linux-kernel+bounces-131291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0BA8985BE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B12D1C20A78
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573CF81AC6;
	Thu,  4 Apr 2024 11:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dgFdV8Fb"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F94B745D6;
	Thu,  4 Apr 2024 11:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712228872; cv=none; b=ZWZlOEZfyqOSpk8UefPGxcn0gBOvzehnlHh6FjAzUTHkdLMa6M0tU65pwUHSWmzVR28t0mc1x2ZGodEnrtEg2xumDXc+GiIaNQslf0RxqMAGGxk3sgyyByGasOJcJqh2PcX+WGIFiuuiBYllieaUBKC4dMB5bQvJdcTccNS3fY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712228872; c=relaxed/simple;
	bh=Jz9p+DbQLxCMAFIchnPWt9cu3a/3wToOtgTzitOYqPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jLmOU9dNzJzGotwuNZHzrCaClzPqpfXXdxsfszov6ry6srprAAaEfInPgH4o7/xcNh6m1NwXQJKyILwGoLH1cIacuO1UShaAU7R6dEJMAxF4ertFGoYc3xz2MIwm12K5zT6bZVBL5XGE4amamd1c6tzbnvdVEZPo1d6Ci/MYm1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dgFdV8Fb; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6eaf9565e6bso576819b3a.2;
        Thu, 04 Apr 2024 04:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712228870; x=1712833670; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ogzEmHcsMc/gb2xe+XOOLIlBT5FMyLswBi0I3OYWLQI=;
        b=dgFdV8FbU2y5rdqCrCaCcMMgFEQwIkgmGtJFwpFZQhMJMN2Aa+5O7J4MDUpyPNmFOg
         0oxIzmHNcBuvnm4D11zsH27SH1amAOZYaPb1fRFrPoXmTI+hagDl5COu1ajcO/+70s5Y
         Gc3o5wd5lbnXhGBhuk/OPUqaPRuXmNX6cXfpe+Iqkz5sZ3Tpd3099WUw5dlltXM9k3nQ
         iPQ1kfZUUtoTFneBsCp94k5zm4cSTRq41fDdMrMEuxO2xuOlD0+3yrI5VegurcxdPa2u
         O3nU8XzkiEDlLLmn6E0TrmOAnGwCAR+FsrAU8iSN7w4HXu087CEW3UdPv7BRqQhll3rO
         +qmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712228870; x=1712833670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ogzEmHcsMc/gb2xe+XOOLIlBT5FMyLswBi0I3OYWLQI=;
        b=XjCIqW7c50GIqbqnAqf5dEzIVwdBLZNhj7uIoPol5Iuwa8lmc9nctHTNMQAAHriGJi
         SaCRVdHMpguOBRUvrQ6M4UEyzOGgmq8/lShMgXl38QfH+aGSCZOoqv1Jml1eYTSpPuWp
         FmfKzMUimdN5Z1vWQ6Yu8Ntomseol5uid5wq+i4o200tgQ0fR0Sd7kjDs+Bf7nowM0yK
         AkQCFfuixPWHZagQVfmQus3C5DcOjHU0jV36yStqGVcwOyPA2v/O2yYfWnJyd7D8JO0j
         SIV1bO20SfHih8iG48tbYoZoRMj7kAwKxpTyHMZYS/IhBTtHcmBV1btOPJiKQ+9t6vTI
         aDvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkaKQ3mN/L8deucN1tQhBpKrL0KXyDSFXK9axSwBXPFDPNnRqDHq0piXrPXEt8EC7c90EC7Gw44I97Z/8Cy7Q/OVZv5/p7A0wJ0Y2K1BB1oodnn2jpBxg1/RLe9Oer6xxgJXkHwvWMKyUq01Tm4LbI6xasjLv7tEgXLVeEX61/QNZgXuc=
X-Gm-Message-State: AOJu0YyVm+3Pju7REe+aWwkMQ/wqEUjcd2Y2Kx42vokxa8e6ckPIkZNi
	bgaeJGr60mtVHwqBRs3rgrs6PblmzCK10kYHM0jRoH6ZGx22QZFHxaMZLsM+DUrLbL4j+hl5d2G
	u3Y8cuswutymOQJlDx79Resnldv8=
X-Google-Smtp-Source: AGHT+IEz5P9kSGtfS29DeZ7LyXMiBHdAV3PkkgkFUpZhAkyfRiFGtrUYIbyut8xIB3UIoTVzaAYquulwbViRtTCs15A=
X-Received: by 2002:a05:6a20:5486:b0:1a3:c4f4:5bb3 with SMTP id
 i6-20020a056a20548600b001a3c4f45bb3mr2454966pzk.4.1712228870571; Thu, 04 Apr
 2024 04:07:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA160A4E-561E-4918-837E-3DCEBA74F808@me.com>
In-Reply-To: <CA160A4E-561E-4918-837E-3DCEBA74F808@me.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 4 Apr 2024 13:07:15 +0200
Message-ID: <CANiq72mz3qDrNQgKRPPAdZ8Gndn0W6VSggu0B8e0erNbxyL4YA@mail.gmail.com>
Subject: Re: [PATCH v4] rust: init: remove impl Zeroable for Infallible
To: Laine Taffin Altman <alexanderaltman@me.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, rust-for-linux@vger.kernel.org, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>, lkml <linux-kernel@vger.kernel.org>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 11:07=E2=80=AFPM Laine Taffin Altman
<alexanderaltman@me.com> wrote:
>
> In Rust, producing an invalid value of any type is immediate undefined
> behavior (UB); this includes via zeroing memory.  Therefore, since an
> uninhabited type has no valid values, producing any values at all for it =
is
> UB.
>
> The Rust standard library type `core::convert::Infallible` is uninhabited=
,
> by virtue of having been declared as an enum with no cases, which always
> produces uninhabited types in Rust.
>
> The current kernel code allows this UB to be triggered, for example by co=
de
> like `Box::<core::convert::Infallible>::init(kernel::init::zeroed())`.
>
> Thus, remove the implementation of `Zeroable` for `Infallible`, thereby
> avoiding the unsoundness (potential for future UB).
>
> Cc: stable@vger.kernel.org
> Fixes: 38cde0bd7b67 ("rust: init: add `Zeroable` trait and `init::zeroed`=
 function")
> Closes: https://github.com/Rust-for-Linux/pinned-init/pull/13
> Signed-off-by: Laine Taffin Altman <alexanderaltman@me.com>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

[ Reformatted the comment slightly. ]

Applied to `rust-fixes` -- thanks everyone! Please feel free to still send =
tags.

Cheers,
Miguel


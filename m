Return-Path: <linux-kernel+bounces-92142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DE3871BCD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A454F1F24A94
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F017C5FB91;
	Tue,  5 Mar 2024 10:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OKdfHfcm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B88D5F87D;
	Tue,  5 Mar 2024 10:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709634242; cv=none; b=rKUEV2TekXGvKU6j/G2D5io1R5ce4g24VXAwJ/LDoO2vp4uOTGU5J+uxfCghbYGixj+vnjahKXhORLFlqaKZ6Sl6qlZ6SnULwTffGXmxksSF+ufUwvEqoxJWfvale2QGqrd1dihxNhPx1q6aCRnuKaZwmvhNzn0Jsi/HX6iVRKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709634242; c=relaxed/simple;
	bh=i+xbX53pFEooWR3sjGG3TQr7rRgoWh5Ar98goRFmekY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gjdvspqsSb16zDDT1md4VGG36P8kxICtQ2TenHiOfQp0kDHBa+6faMnks842ErHAgiUryXLTVAf8rl5dctpW2Sdwzsw61qkHCYwwqsiWA6onZRJw8RpMyGa3L2xncFkUSPqWHi626RK1D8M54hC1AFHGW7AXWGQEz84F2W5kXn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OKdfHfcm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9776C433B1;
	Tue,  5 Mar 2024 10:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709634241;
	bh=i+xbX53pFEooWR3sjGG3TQr7rRgoWh5Ar98goRFmekY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OKdfHfcmPN+81pisf/rKa0Zwilc/5cJwS0t3t+RM7TVmVbw7w3TA7Hwu1DPzQ/9/Z
	 Q2d01B9fxgMNYgG8rtUdxYx2TJx9Kb75eWVofGYYsyAkt+1OoQxvf21J4wYeRulShx
	 5YRrbDHvpT1uCw9GfliSYHYk99ZIZ++iKdn6Ul70iWdcurULGz4CVmlwkCLlbNVsHp
	 RhNOtBIU0w+0V7Phra3E4pNa118C0vmx+hyDA4RLrruqJ1elULt3RGtmkQiZ7BF3wq
	 usTiEv+s3t6f1PmNdYQaKVE/qx3TY0Ow2pqrAxLWMraXAbKpVTcbnNas+CoEmjsE9k
	 uWaZfuQHLu5YA==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5658082d2c4so7531018a12.1;
        Tue, 05 Mar 2024 02:24:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU6+s/xdfl8kcPQJ49Pwe2ygEHhgFPHyFJDuVfqzBuio4RjMbE4OOXWuNDBCCj+0CLtSrG/aIFp5LBuYrAhXCtrviY7ya6TIQop7W/CvfG8fw/aaQkRlNj+tD9hNTUqB1Ze4IZOuKib1YAbPvU=
X-Gm-Message-State: AOJu0Yw+EJAad27P98e9FIM4ecjGWldX2T3MxfdGQ7r9cbECgY0m07ua
	sFavsvu+a1jfjJBXKB1hcUCSNjbU/4uF+c6YjhoDC+gCPSMnqTyUlQwDThYzHiTpA/CIPiyl7ZX
	WW7dKR7F2WHUNx6IAlaaKAirCE4s=
X-Google-Smtp-Source: AGHT+IHlFvWBz3wnmsSjVMW5AspWGuH7n2lGRkbQpThZBFkZw5/Abym9wGNUQUXXO0A5jDAM1F8DOoKv++tOu+LpUqo=
X-Received: by 2002:a17:906:4546:b0:a45:aef0:c3f0 with SMTP id
 s6-20020a170906454600b00a45aef0c3f0mr67378ejq.68.1709634240144; Tue, 05 Mar
 2024 02:24:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304141426.163517-1-wangrui@loongson.cn> <CANiq72mvdVrzN19PC8pNrvuBLkOEEQ3yX0WG6JcWc+RVaSM2nA@mail.gmail.com>
 <CAAhV-H666zsMadZuzvcRxxkUxSpkka1tt9AJO_WctHDL8j_HNg@mail.gmail.com> <CANiq72mHCNU2wGpELBbgOA8LKQhm_-RyG8+9bP9miYJOkUw2Uw@mail.gmail.com>
In-Reply-To: <CANiq72mHCNU2wGpELBbgOA8LKQhm_-RyG8+9bP9miYJOkUw2Uw@mail.gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 5 Mar 2024 18:23:48 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4-m8hETykn+i1pUzHEjAHtkm4rNXybAtDwc5QyXY+m6Q@mail.gmail.com>
Message-ID: <CAAhV-H4-m8hETykn+i1pUzHEjAHtkm4rNXybAtDwc5QyXY+m6Q@mail.gmail.com>
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

On Tue, Mar 5, 2024 at 6:10=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Tue, Mar 5, 2024 at 10:58=E2=80=AFAM Huacai Chen <chenhuacai@kernel.or=
g> wrote:
> >
> > The base of the loongarch tree doesn't contain the arm64 modifications
> > now, so this patch is better to be applied on the rust tree with my
> > Acked-by. But if you have some trouble doing that, I can also manually
> > merge the arm64 parts to the loongarch tree, and then apply this
> > patch. Thanks.
>
> The rust tree doesn't have the arm64 changes either (i.e. they are in
> the arm64 tree), so we would have the same issue.
>
> Since it is quite late and there is no rush for this, I would suggest
> applying it after the merge window in loongarch64 and thus avoiding a
> merge. But, of course, up to you!
OK, then you just need to do nothing, I will apply at a suitable time
with your Acked-by.

Huacai

>
> Thanks!
>
> Cheers,
> Miguel
>


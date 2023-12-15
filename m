Return-Path: <linux-kernel+bounces-853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31EBC81470F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F6F71C231A7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C40A250E3;
	Fri, 15 Dec 2023 11:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mVHfbYka"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753DD250E2;
	Fri, 15 Dec 2023 11:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-da7ea62e76cso443827276.3;
        Fri, 15 Dec 2023 03:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702640169; x=1703244969; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xlhIqyJiiodbXf2NuUmZM6lEWf4T2nhAdH/z6iYPn4A=;
        b=mVHfbYka2hq0LP0dDRwYLAB3F41k4IYyrfI+nxX7U4pehpdZlC8hGwH6CmjCeYlrGT
         mdX97kxbiE4IKI+C0WRIKVjsl53bdDcnwKqmlTwB6BsPMPbQZVTJ2U2dY1PR8C2+lq+2
         4klpXs4K9ZaAh2IWsVGoSHUomSija563W5Feqib5XRf3COGF3BeJJbxkKlQB0UlYQElM
         96I15mpB5+nnw/oxoM1Li+tCo6BmkgPw55m7egdmiO0FdPRFabLtgw1+jYWoNXVWaxRB
         qqzG2nVgoyFbgogcMJEdnZV1fw0MHo5Sj1DlKDUzp9SrgYS27RdSK/wug7/cuUywguMY
         54wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702640169; x=1703244969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xlhIqyJiiodbXf2NuUmZM6lEWf4T2nhAdH/z6iYPn4A=;
        b=LBrHyfxhax0/Q5wO6O0epJ7vxpFVh0FlyJb3H4pdALCPBkAq/nYzQMCy65T1RAu5t6
         mxjpe1IdmgkBvGvuTVEWmLocAaJqHX+KKuokn7j3OlKxJcRNHYZ2HNvIiRfHwHrzJSTH
         UPFwqAAdmyaaZYjJnuCEM87qlD5auHt4Zgkq6LZvPee9i+3OTDtljnXnwPlWYWHQUwLG
         CtmwbreXa4ClipmbMQRfKMlp1g2C6YkLRWpGuw2BGMRNobXxr/SroUTr2J2LPSwvL8Ol
         3g7BxVoz5isMUQMZ+phGLXs5K3t+NtWOp56UaALg4mimXC7+OyidnCJGjp2mQNKljRTt
         3lww==
X-Gm-Message-State: AOJu0YyBNQJtjNekMc8hJMvKDlHA62l0LGFMHn2VXSst49uKXGldLY4E
	Fpm0AN60w5nSgbhRRHS0/RzznPrImggeiQLN9Vw=
X-Google-Smtp-Source: AGHT+IF0S+7AxR1L+WVoLZPOJ/H8TXi0q/3n/mvrxFUKfU6+twuyNMD5h7Q7QnK2nOg3hrsYwEH77N0iaKvaBRZsmfs=
X-Received: by 2002:a25:4212:0:b0:dbc:c446:7632 with SMTP id
 p18-20020a254212000000b00dbcc4467632mr3763747yba.17.1702640169409; Fri, 15
 Dec 2023 03:36:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e2b943eca92abebbf035447b3569f09a7176c770.1702366951.git.viresh.kumar@linaro.org>
 <1c03eb18-a6ac-45c8-8fea-46097bb4e132@gmail.com> <CANiq72=mvca8PXoxwzSao+QFbAHDCecSKCDtV+ffd+YgZNFaww@mail.gmail.com>
 <20231215064823.ltm55fk4zclsuuwq@vireshk-i7> <a2aca039-7360-476e-a1b1-e950698cd26b@gmail.com>
In-Reply-To: <a2aca039-7360-476e-a1b1-e950698cd26b@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 15 Dec 2023 12:35:58 +0100
Message-ID: <CANiq72mT_N0eSkUAR9KYYWvFaVNYYOpFiJLr_whab=FNFcMVhw@mail.gmail.com>
Subject: Re: [PATCH V2] docs: rust: Clarify that 'rustup override' applies to
 build directory
To: Tiago Lam <tiagolam@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Vincent Guittot <vincent.guittot@linaro.org>, rust-for-linux@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 12:14=E2=80=AFPM Tiago Lam <tiagolam@gmail.com> wro=
te:
>
> I think we can drop the reference to the `--path <buildir>` to avoid
> giving too much information to the users following the guide. It doesn't
> seem to bring anything given users should now always go through `make
> rustupoverride`.

Yeah, the idea with the new target was to simplify this, rather than
have it as an additional way.

> But if I understood this correctly, the point here is that with the new
> target we can now abstract both cases behind the `make rustupoverride`
> target - i.e. we don't need to provide alternatives.

Exactly.

Cheers,
Miguel


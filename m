Return-Path: <linux-kernel+bounces-9091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5390181C05C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 22:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 868CA1C23DCE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 21:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36FD278E66;
	Thu, 21 Dec 2023 21:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y21p367r"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C88077631;
	Thu, 21 Dec 2023 21:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5c85e8fdd2dso13247257b3.2;
        Thu, 21 Dec 2023 13:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703194813; x=1703799613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aTI1OFjrcWP9wgBoTfoCNiKxKyxMm5mLbCOryqiWA0U=;
        b=Y21p367rKxW+BNuYUgZ0OFuFUkqXHpP8WU9laH/juigbd5fvlD1XGgUdVpLTYQN9dS
         Sx+rqRXak7buykyJInCwMrCvMiQ58T5/AmXzsQaK2wOBV2HBuKqYn+F2MXS7+Ap5GyOi
         mRJ5mPb6Qt+Y+gj4ONPq2jWKSs19a2EUimfdodj2o2e8WuiKoxb5sAQp221TiQrQbFuX
         6iybGtRNjn/BIk/YaV4NRR89MUFyjF1fZVOkf9FlHEZUU/gR9dds2bJJ6uBJt8gd00d7
         Zxt3od+X+pgnZZTuIXf/w+m1UBqFIriEIC1Y6DK5LF+qJn1Q89R9NQu1fYvuK7QyH867
         iULg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703194813; x=1703799613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aTI1OFjrcWP9wgBoTfoCNiKxKyxMm5mLbCOryqiWA0U=;
        b=GzS7LarW47xk6m6IJh0HyBkSBznVEAAwS1O0JKu/wqXkEjBC6EG42LSGiV5NIaGVoN
         SHVelXhXOcXB0IiyHuJwk6D8/jnSrdwDPhUY8rTntrd47+xBF/7tOqpGH+BVJlAtxheC
         gKUWwoLJTVPIjq+dSrwIvQ0Il+DHFIZlI8+Fw+Kjnx6XSlrRRvPqAptuzUq0LhJPnV6g
         hoW+cE8cQwYuA+nacvWOAtNu+4A0sBOcJorxG7JEU3/C7sxu/km4rEn12hZoI6eaIaPg
         AQNgnlmShL42IqSpnGF+6Umcmb2ulTsL+3SUk2pxlBv7jsWhrxneIov1igfEZj1yEswZ
         WdOg==
X-Gm-Message-State: AOJu0YwVkxCzTPZIVJUguQdAC/pm/H+w+xjGfbcnczOC1BpW4oHCtcTQ
	8MDje2I18vOQBaZv2qYmiFGY0uGTzHTwrJ7+Hv4=
X-Google-Smtp-Source: AGHT+IFZQggkJXTtouCLXwdPMeMSiEljIujIGL/TQToBqai5Bv73z4gb+uuZ/oV29fvBWdlUPqLqoM2bsALFvLVk4+I=
X-Received: by 2002:a25:dc8c:0:b0:db5:4b23:534 with SMTP id
 y134-20020a25dc8c000000b00db54b230534mr423500ybe.17.1703194813258; Thu, 21
 Dec 2023 13:40:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e2b943eca92abebbf035447b3569f09a7176c770.1702366951.git.viresh.kumar@linaro.org>
In-Reply-To: <e2b943eca92abebbf035447b3569f09a7176c770.1702366951.git.viresh.kumar@linaro.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 21 Dec 2023 22:40:02 +0100
Message-ID: <CANiq72mKL3_1Cfe3EQ8RN+_R3kjs96vgHtjO9CCXD-+p2CzQDg@mail.gmail.com>
Subject: Re: [PATCH V2] docs: rust: Clarify that 'rustup override' applies to
 build directory
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Vincent Guittot <vincent.guittot@linaro.org>, rust-for-linux@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 8:44=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> Rustup override is required to be set for the build directory and not
> necessarily the kernel source tree (unless the build directory is its
> subdir).
>
> Clarify the same in quick-start guide.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Since we are not going to use v3 given we will not have the
`rustupoverride` Make target, I have applied this one. It is also the
one that got more `Reviewed-by`s, I think Andreas preferred too and
Masahiro was kind enough to be OK applying this one instead of his
(which would need to be rebased and submitted to the list), so I went
with that one. Tiago's concern is still there though (i.e. the script
is relative to the source tree), but we can improve things further
later (perhaps if we add a script for this sort of thing).

Applied to `rust-next` (reworded and fixed quotes for `--path` and
`set`) -- thanks everyone!

Cheers,
Miguel


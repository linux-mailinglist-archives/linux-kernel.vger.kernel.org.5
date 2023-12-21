Return-Path: <linux-kernel+bounces-9089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B6D81C056
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 22:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD3B01C21B8B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 21:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790427764B;
	Thu, 21 Dec 2023 21:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HF1a/lYv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8337F76DCD;
	Thu, 21 Dec 2023 21:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5e74b4d5445so12188557b3.1;
        Thu, 21 Dec 2023 13:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703194804; x=1703799604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MES1Czfl9t1Rk/xm2E4F/wm2jtD8BoNGjFyADEumMGA=;
        b=HF1a/lYvdfxerZECwnVrH/vEu1/Fe7N4W4swpAXEBzy7gHjK20vyGIExdiD2QoP4Hc
         KTiyXOBIHTH0fAdI9bu7Q0AJu6IzW9gAfCKGxiKpg9dZ+tVzkUntnjvymLNbVMNHjEei
         xIslMZ7HvGtvXXZ0weYnb35fFXTNdTlTYRMvTxdhnqiHT65Vko/9m/akVm9acf+eYZmL
         oQh1yN1zZPlIP5SrInN88PuY+UitgxI+wLbU8aQYym1jaDf8+vuXBfanh87XTpX6uWEz
         63PU0Qd7rzEwR3rb1+lADxhJJJlWeZ1xFU7h1vqBR9tSpNhG2zpXDv1yzsn5FT/FhBzu
         U7Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703194804; x=1703799604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MES1Czfl9t1Rk/xm2E4F/wm2jtD8BoNGjFyADEumMGA=;
        b=pErlbeR228sWUbuoDk6ouj993oZDZsaAHmYaPUufGZC8Fp+TDeWA5jrEQAQ7PPvpWj
         Abu0C+sJWau1c/ewns6hxb/nn4ZiT/fLcXNXCipmUH5GGucdWQoF3dmqbbi/5vcEyosy
         qU2S/e6xM+zMMqqLa5veYboF9rEZWuxlQWz4DxS2JQppA1mXAbuUVy/gdTB5KQk0sxQa
         7dy1zcpO24vf3Sfvq7bOxrIRfrexASkCxpX9MPGGL1vX4ToR7f55ynMPb7Xd6r12BwMN
         z/63VdFNclS08UMlYyXThLvYULR3PR9SbGF+gH70sG6R725SqVLCq3ftkecaRkxR9QhT
         v2Bw==
X-Gm-Message-State: AOJu0YzexrqYe+qibkZo4pCn0o7kzLXzullhkCFfI3HG/TXROSCbcHPf
	+/5lQSbCuUQy6gSiA2ZCK8a55Ch0Z0kzESco1dM=
X-Google-Smtp-Source: AGHT+IHP5GL2To77rsNOn5DUqpCqzRAeGnI3g+YFmdF+IBbgKb8SDhVCXZz3JwaPE2cun4u0CYzAWKVv6g+GfyFFMiA=
X-Received: by 2002:a0d:d206:0:b0:5e7:402a:f8c0 with SMTP id
 u6-20020a0dd206000000b005e7402af8c0mr468095ywd.97.1703194804339; Thu, 21 Dec
 2023 13:40:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e2b943eca92abebbf035447b3569f09a7176c770.1702366951.git.viresh.kumar@linaro.org>
 <1c03eb18-a6ac-45c8-8fea-46097bb4e132@gmail.com> <CANiq72=mvca8PXoxwzSao+QFbAHDCecSKCDtV+ffd+YgZNFaww@mail.gmail.com>
 <20231215064823.ltm55fk4zclsuuwq@vireshk-i7> <a2aca039-7360-476e-a1b1-e950698cd26b@gmail.com>
 <20231215112418.usky65sibhbiubyx@vireshk-i7> <CANiq72nuUpBCHaeyozDXAZrV+YLW_OR-QOUiVHPfTbNGG3RFXA@mail.gmail.com>
 <CAK7LNAS8kaRsWf6Grob5Vuj3eNx2c2=s+JmmshcXXJT2B4ph_Q@mail.gmail.com>
In-Reply-To: <CAK7LNAS8kaRsWf6Grob5Vuj3eNx2c2=s+JmmshcXXJT2B4ph_Q@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 21 Dec 2023 22:39:50 +0100
Message-ID: <CANiq72k5C-pff+Kpvmb5hQcen2ZKmKT2hSENnyzDGxo0wfptjA@mail.gmail.com>
Subject: Re: [PATCH V2] docs: rust: Clarify that 'rustup override' applies to
 build directory
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Tiago Lam <tiagolam@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Vincent Guittot <vincent.guittot@linaro.org>, rust-for-linux@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 1:07=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> FWIW.
>
> Kbuild is designed to be able to initiate 'make' from anywhere,
> even if the build directory is not set up.
>
> In that case, you need to use -f option to point to the top Makefile.

I meant for the command that Viresh mentioned (i.e. without `-f`), but
that `-f` is meant to work is good to know, thanks!

Cheers,
Miguel


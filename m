Return-Path: <linux-kernel+bounces-765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C20858145B7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62D0A1F2241D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 10:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B84A241FB;
	Fri, 15 Dec 2023 10:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1rq1koYk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FA525553
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 10:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-4b2ee700323so182707e0c.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 02:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702636439; x=1703241239; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QUVhEwhGG5R6yJfLzMvql4u7DQlTyWt51m5KiZQOx4k=;
        b=1rq1koYk0LexYezdWSJHjWlecDo6CNjnXpsB/UgQIjxVHRpnULzBeHjsF1CqWMvXgc
         YDttL533OYoCSVdhLQquH3B/zk1JMLwAolYo4+PujSLjGA5A5an1LjtmFwa0a2Qy0SvZ
         U2wTgm9Wd3zRiFDsb0WuAEbz+yvCYEVuEKwHm2vJwb5au2k84S/ykNnTIWoWUeF8ZDgp
         oBJe88Xo2iZLZwXcqL1vwMReP2KK204rPXgHLkfFwyfAOcOyewPF/DI3BWzk+KYPHkcB
         /E43khiBVfUeJSMt6Clkjmw2NCbIxQYBO7TIGKMP3TM2eIUqGeANGbya/shUnYF59MB5
         +LIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702636439; x=1703241239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QUVhEwhGG5R6yJfLzMvql4u7DQlTyWt51m5KiZQOx4k=;
        b=Cy65yWxX/wUCCgJmWRGsHz6ibrxlTgMHIdSnQ9MwT5TLfS3lmaaPBYpof6DVqIA7Z4
         tTM9fH+HZ07+0G2465pWCXT+qj1nDcht7aXzDH0CwU5EBTULEDqeNsRM7v6CdkjCihlJ
         4Ezt+4lXKgc8VY0ePZlZCGY0S4W5UF6lZYsQ49zN4usfNsj0M8REP/rYq3YA7+RsfTm8
         JOSQbztVo+9vZ6bVhoZSid+KHI2pU8iOI1YkkWNWzG2DwgPl0ZjoutdzHq/grO24PLxE
         XVuPSAUQOz/NGDV/hPAjKhuiJCnCcKdcbIRxiU8sTvI/DbgrO9VHy1mXJr3ZuywcmVK/
         Tpqg==
X-Gm-Message-State: AOJu0YxMrYwIyvFGyJBn/DrXnKhOKli9ImOfXOKHUkRZFMzEVi+Oyz2q
	sqymtj23mxTu29/jmB0tUo/shmIbkbeU/ytSNHKERw==
X-Google-Smtp-Source: AGHT+IE5lEPjohScF8M2+o9L0ZurkGWcYGEHMF7ggwPClq4fWZTrD4KlogJkKTQ78bQH/IAIKHZqCt2tU/dbAqnvSDQ=
X-Received: by 2002:ac5:c38f:0:b0:4b2:956e:f651 with SMTP id
 s15-20020ac5c38f000000b004b2956ef651mr6658491vkk.0.1702636439100; Fri, 15 Dec
 2023 02:33:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214222253.116734-1-ojeda@kernel.org>
In-Reply-To: <20231214222253.116734-1-ojeda@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 15 Dec 2023 11:33:48 +0100
Message-ID: <CAH5fLgjPznV1pjaxoXovnfwSBOv6sKZc3G_MwfELbmwH0-Xf8Q@mail.gmail.com>
Subject: Re: [PATCH] kbuild: rust: add `rustupoverride` target
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Nicolas Schier <nicolas@fjasle.eu>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	linux-kbuild@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 11:23=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wr=
ote:
>
> When setting up the Rust support via `rustup`, one may use an override
> in order to select the right version of the Rust toolchain.
>
> The current instructions at Documentation/rust/quick-start.rst assume
> one is using an in-tree kernel build (i.e. no `O=3D`) [1]. We would like
> to provide also the way to do so for `O=3D` builds, but ideally in a way
> that keeps the one-liner copy-pastable and without duplication [2].
>
> Thus provide a new Make target, `rustupoverride`, that sets it up for
> the user given their build options/variables.
>
> Link: https://lore.kernel.org/rust-for-linux/20231207084846.faset66xzuoyv=
dlg@vireshk-i7/ [1]
> Link: https://lore.kernel.org/rust-for-linux/CANiq72=3Dmvca8PXoxwzSao+QFb=
AHDCecSKCDtV+ffd+YgZNFaww@mail.gmail.com/ [2]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>


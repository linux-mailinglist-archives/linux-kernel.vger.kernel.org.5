Return-Path: <linux-kernel+bounces-9096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E19A981C068
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 22:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAE381C23F2C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 21:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A2577635;
	Thu, 21 Dec 2023 21:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDRCchHQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8E4A5B;
	Thu, 21 Dec 2023 21:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dbd4a10735eso1259920276.1;
        Thu, 21 Dec 2023 13:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703195048; x=1703799848; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s2xa/S4NiPSIz3XLKoVY/N+TMiqQSaInpG+sBuNYEZw=;
        b=hDRCchHQx6AGxSb4f+hn/jWe1uQtLbLUKZthZHnzeq54y5jRozr4mLysZqXxR3yCSz
         s08sNc5yFkzl+nxh8aYd5mJJQ9bbYuZnp9HGbxy+imvdTCI08R4IyP7jqMI/aHlYHl4O
         CNN/sy/KrykiEn7fWq80FHnHqZbuidDhH/T802oad97X7O9U4Jg+rLnIPJUmm8MMw3U+
         4+jzRIgV6CwV6kIVjzt8XwQzgZSQo3D1VdSiW/sKuNmvIr/yPY99DgmdmVG2NmKC/6ac
         Sp23IwcjZC10TXPnj9+EOS2WG01l8kOsw4E6QYK2mghZ7JwDXG9wpJcDcOKgOJ8tUN6k
         B1ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703195048; x=1703799848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s2xa/S4NiPSIz3XLKoVY/N+TMiqQSaInpG+sBuNYEZw=;
        b=IXx8ZGR4U6uhsafF9/ebXnJCx+3lOsARQcYSgUzyqgCggGKgtWEe5FrEQu/fpYiIAh
         0sUsMBnB2w1VxOT0K2p7bqXgkhLdQIqr94boMa6ssZXNhPgC67hexbvD4QxRsEpbHDIi
         RDte575v7lAjhESSgRbbG7ITBktCIfBWOcMifTuUEG13VufOIyX0zjybzg8EgwswwN4J
         ryZzW8sXTSkinhn6kpCJWQFE+F+4a1bzmF3rj9dXQafSdNG2L/0e9fYW0CVpP79jjoDm
         JJAZYp9Pouzo5uyjRTbcLzpW3Qqqos7p2bHZ2nK9qzAZ0PjApe33qgPzBqUyaHYzYHa7
         SXuQ==
X-Gm-Message-State: AOJu0Yz3lwg5rcjW7sp5qrstmwnpSVkih6oMv+AQhG2WAqIYsGIUZR/M
	QgRbKW+8w+loDwYk0rfw0TmIwB56bi7hc70d/23lU6cI3qM=
X-Google-Smtp-Source: AGHT+IF8iVy//uPGGEz+20u8wFRe3kEu0vMOlFewXlSt737Kn2o8uBT4ZTiyCSOXGm8ucwoADus9wHhwoB60wsU9PJM=
X-Received: by 2002:a25:740b:0:b0:dbd:ae04:2eb9 with SMTP id
 p11-20020a25740b000000b00dbdae042eb9mr374851ybc.11.1703195047993; Thu, 21 Dec
 2023 13:44:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZXtebif2S1CyJRik@boqun-archlinux> <20231214200421.690629-1-boqun.feng@gmail.com>
In-Reply-To: <20231214200421.690629-1-boqun.feng@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 21 Dec 2023 22:43:56 +0100
Message-ID: <CANiq72=G-PX_nJctNwsU98pGfwbFr6DtfzWrcSPu=rae-1G54w@mail.gmail.com>
Subject: Re: [PATCH] rust: sync: Makes `CondVar::wait()` an uninterruptible wait
To: Boqun Feng <boqun.feng@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tiago Lam <tiagolam@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Alice Ryhl <aliceryhl@google.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 9:04=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> Currently, `CondVar::wait()` is an interruptible wait, and this is
> different than `wait_event()` in include/linux/wait.h (which is an
> uninterruptible wait). To avoid confusion between different APIs on the
> interruptible/uninterruptible, make `CondVar::wait()` an uninterruptible
> wait same as `wait_event()`, also rename the old `wait()` to
> `CondVar::wait_interruptible()`.
>
> Spotted-by: Tiago Lam <tiagolam@gmail.com>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

Applied to `rust-next` -- thanks everyone!

Cheers,
Miguel


Return-Path: <linux-kernel+bounces-9094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D060181C063
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 22:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D286283A40
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 21:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E774377644;
	Thu, 21 Dec 2023 21:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KKywA1WD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1889B76DBB;
	Thu, 21 Dec 2023 21:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dbdd013c68bso681181276.2;
        Thu, 21 Dec 2023 13:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703194962; x=1703799762; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qc6DvoHCBo6SR0ql109kb11eHuEG/z5z0j0o6Yh0aEs=;
        b=KKywA1WDE/ACl6IjRDzJydVy6Lrnl30SacU/U6zNQEWOVqBsIjClyPKTFUfYt/MJ84
         HRL0sMrxXvr4pqjbPDG9JAu5/ggrDIjGLaY5SKX9o+Ijao29j9QgzShp6Lf4mIm4wNZ0
         LhV7jnKm80QlQH1kaytk1DtLNccJNojEXrkYdPmi0y4oo4PxvgECpFOVIPP9UMB7Lc1c
         ARzjR8UeEjtffemL8szTyrAbCkUjM71Hhf2omv/HcqN+qihkA1YO7RcUnlVzksvtMzdO
         QedwCiFlDjY4C7NNB0s4iTqdw1guqqF99r5fRn4K9gDyphvZrsgJK/wFkyxCaOJe8lJW
         y4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703194962; x=1703799762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qc6DvoHCBo6SR0ql109kb11eHuEG/z5z0j0o6Yh0aEs=;
        b=EPkfp2aIZD3ys6I0nk1GgPGzeuEN5Mk9PKv8i7MHXS0jVhi8OAqCAf0q41yId9CJOU
         5eFBMi92g50bYsBclkX2r6GdSyuieJyxLW8+PEJevhnP90gEKpgsFenhhU/G9BXjWMZh
         elh3s2dLx2dW3ccIurRJSnIs3ZMQoz3WJ8eqZeBiez/aNNGbw+4jnPq2Gc/5jZ8tbhb8
         GbUQwj/G0diXAqgylSrt48X8T4f+EMkbTe1T8l3t0L865ibb7cb+7jvEy+E+dUt/TvcS
         XuAJc63WbgGu6exCcTY0gyqsLLQyUr4fqj7874lx94cFf3cOPfLFtDZqhUegzDvUKUWg
         tHZQ==
X-Gm-Message-State: AOJu0YwXkXGuZyPhjwplVJ3N/atSf1+6vs4QzUoU91WOUPCEmWj+R/DB
	nmhvV10xzIQb3izg07n8I387d+Cf21Brlcgn714=
X-Google-Smtp-Source: AGHT+IEDxN5fCuZZQgeRAfx8XcLajEsgJW1NOnjf/1K4gD06U74Wnhm26W0sYXsjWx1oM6A96HMSn3m5EMWm/hq7iIU=
X-Received: by 2002:a25:6914:0:b0:dbd:c9dc:8751 with SMTP id
 e20-20020a256914000000b00dbdc9dc8751mr380198ybc.102.1703194962157; Thu, 21
 Dec 2023 13:42:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214092958.377061-1-ojeda@kernel.org>
In-Reply-To: <20231214092958.377061-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 21 Dec 2023 22:42:31 +0100
Message-ID: <CANiq72mzBnHTZqsy+VN3dbHy1OF0DcSiknULpgMnxy_-FZRk4g@mail.gmail.com>
Subject: Re: [PATCH] rust: upgrade to Rust 1.74.1
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Wedson Almeida Filho <wedsonaf@gmail.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 10:30=E2=80=AFAM Miguel Ojeda <ojeda@kernel.org> wr=
ote:
>
> This is the next upgrade to the Rust toolchain, from 1.73.0 to 1.74.1
> (i.e. the latest) [1].

Applied to `rust-next` -- thanks everyone!

Cheers,
Miguel


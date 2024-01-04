Return-Path: <linux-kernel+bounces-16739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE8C824322
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92324B22B05
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 13:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2312C224D8;
	Thu,  4 Jan 2024 13:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C/qvNdU7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E192232F
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 13:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-4b7a3189d47so171586e0c.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 05:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704376392; x=1704981192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/MfPQh4H35nlx+QASSAm2zP9UXUv9F49uxYi2GkZRd8=;
        b=C/qvNdU7d/CWH9lPt5H1mQW1JRR+8r8Qw21HzKHMmyBbhXcS1pafSAv2oBQx8KRto2
         qOVX4PSihNQb0LBZ/UBJwJOtvO8rf/ucWl/xa+CcO8Uix29i8tzFPmtgI7Wtr0mnckA5
         ABG+8kgiqsFTivT680o25tGkE1vxnLZQxVptaWOr6fz9CVWKCvelQi1PJE6AZAK8Rzyj
         IBUzbPdthTzGMH4UmkyksnbDNnB6dA3b16XmqBvqio+HKfgIa60crbnVNUO8YW0YR89Z
         ktwjk6R59fxnoJTzEoYlPcb/5BMNgtXtUhydsvVNaiPwLVNtOt4D3XIwrAIgt0O0XQf2
         BFnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704376392; x=1704981192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/MfPQh4H35nlx+QASSAm2zP9UXUv9F49uxYi2GkZRd8=;
        b=f4tzCZSn97E2zigEMRaZRManEHmsCL5Et0Ip7xtXkR4Q0NKS0hQJ1hQrb9j1wdMgsL
         yFQdGb8qaI5JXX8lwD5L5C13Eos/4rXTs1aUC8Wn/p6TNBUi1xivMgOPmcQgq9NFqJdq
         UPJy7tl15F9BLqyCFDgVOnFzN/ykIowAXg0EuxmdwriTpiVLcfjhAhxN4UxgWG+e1YRU
         6rE5511fSPOvkgRahWCNuGbve+vJ5mNtkIPAhX6WmGi9IRSfrAahCp4HxBwIm12qMGHV
         +uM3QwUo8GEOpN2sUz0QKZKwlwZXPgmyeQ9SXK5Q1p+yi8aHGN/F8iz5WHAnmYr0lVdD
         7ykQ==
X-Gm-Message-State: AOJu0YwTvoYIwiQXO2ACWwFtVvLSRoKxtWT5ksK5BQ/xX8Z+ke7+wnYk
	GvmXF2Nf6aPKP0Qv2oRwaVE5gOdi7iCM5FUHQKlqfryKxaPd
X-Google-Smtp-Source: AGHT+IHEW8SkKUXbqV1XthfUkn/czEVyuhyc0c7T3AibMmU2Ekv3oCJE3085ZAMhEesImZ/BsxYPdvsMBjlPnUl1KPs=
X-Received: by 2002:a1f:fc06:0:b0:4b6:bee9:3cbd with SMTP id
 a6-20020a1ffc06000000b004b6bee93cbdmr470548vki.5.1704376392392; Thu, 04 Jan
 2024 05:53:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231216-rb-new-condvar-methods-v2-0-b05ab61e6d5b@google.com>
 <20231216-rb-new-condvar-methods-v2-2-b05ab61e6d5b@google.com> <ZYC0i875pOw4yjnK@boqun-archlinux>
In-Reply-To: <ZYC0i875pOw4yjnK@boqun-archlinux>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 4 Jan 2024 14:53:01 +0100
Message-ID: <CAH5fLgj2vRpMwn2C_JEJZhYtfStsSr2AfAOLvh+pJruR-4nknA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] rust: time: add msecs to jiffies conversion
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Tiago Lam <tiagolam@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 10:07=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> =
wrote:
>
> On Sat, Dec 16, 2023 at 03:31:40PM +0000, Alice Ryhl wrote:
> [...]
> > diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
> > new file mode 100644
> > index 000000000000..23c4d1a74f68
> > --- /dev/null
> > +++ b/rust/kernel/time.rs
> > @@ -0,0 +1,17 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +//! Timers.
> > +
>
> Please consider the following mod level description:
>
> //! Time related primitives.
> //!
> //! This module contains the kernel APIs related to time and timers that
> //! have been ported or wrapped for usage by Rust code in the kernel.
>
> Otherwise it looks fine to me.
>
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Sure, that sounds good to me. I'll update the module description and
add your tag.

Alice


Return-Path: <linux-kernel+bounces-45240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE2B842D7A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CE381C221A0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D750E71B4E;
	Tue, 30 Jan 2024 20:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XuxuCv2U"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB37871B29;
	Tue, 30 Jan 2024 20:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706645065; cv=none; b=gjYJ9EzUiaWUD0OQeKPcSMyatpdPpWt+TC+NQZ9nkhSVGOP1JpwlABi3ncCmmtHMWA6TSCuJ/vQ3JRw9VFjnXA5KA55ZGLzD+K/zwh4U7vo1vAyVb1enEoHQkMGr73iYjJYEUxHwNNMhrmZcnzvtt38P+Nj3WCc/AjfgDmIeHhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706645065; c=relaxed/simple;
	bh=qRwBSpUMX2fOZfTjaWwFZmmfdK7MSnWlmlcNVPNEZx8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=asK5ZEKx5yZPwYCROuS5vNhTyYXYqq4gs37hOgzBnyfW9/b3OFf+zRvn4YqoZsArjZtIAob0aj5vJCQk4KQHykmHNhVAOJ4JHBp9+jHcVcpHWiwYmqlQfqHRb5fNt6UzuFLaHLVhgaLqlXcSoXugQkrcxlarw361Re4CQB3VBYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XuxuCv2U; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-60407e7a6caso1453587b3.1;
        Tue, 30 Jan 2024 12:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706645062; x=1707249862; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qRwBSpUMX2fOZfTjaWwFZmmfdK7MSnWlmlcNVPNEZx8=;
        b=XuxuCv2UNQvm5TvQe+K1wHHo3JqhK1bCDXJso+8+4rVcDd1XPPn3Tn89DYVRAqf6N2
         22URxjDEzOhluZZj4W3rX/3+8qbSPyDiw+oM8M+9uOI/wm1ZWZvabSPvFrGN2NpyS90O
         ubuf6afv8Sd+LU5ex91HDTlhoL4bL5Poa6mmcuoVwglXDjWLLho9tgDygMCy32Kjwen9
         56nFTfPjeJlMyAj9L+8zxTw1Id66YOJQwuBrjpSa1KKwRkFTKzX1E2uHAbG6vcVROSic
         kwYffeQdZNPAfiQ9g+XbFmG1RcL4C1W44A1907WRF3H68GUMwmCISFXX+5gsJp3NfhF8
         Oytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706645062; x=1707249862;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qRwBSpUMX2fOZfTjaWwFZmmfdK7MSnWlmlcNVPNEZx8=;
        b=L1I9wDtmQPhFPpYHlxdhHyMy+sz84x8m6jKDFvYy/AdW1EHelCgEJnqrW+JsTR94Fl
         USgaHOAo07cHlxZE8QO/BfCCU6XOLuHVhnC+NAEyxGWbu+BKt3jVebOiO206sK+k9+0z
         EaXO8jsqdpuTTL9tIq+j4yqHPvwclYFTFD3Vd4f9mZbBck5nll2s4uBKoiYjF163L6dG
         gXnWwwMXaHszOzRUkMMK6jt3mQzmjgKjjbwL4ZWHpCQ3+OfpDOhsU6qI0Hz3vs0rrVM5
         /cch0SJIKclMCWozN8p0yIu1PA/WDIjR542VePLmHNMN8tumMdt/TUklyzS9T6oArIc2
         +DNA==
X-Gm-Message-State: AOJu0YwpFGJniRUMFBVjdoB2qfrWLxNASHV2TgfiAUTVZ2SxpR9W1zBI
	6Xa4QTZt5vAly6242nQo58fMRMJ2tvlVSNTjwAcDpKEFctwI6T4QChSQeNuTpafaLDSZ4DQQFny
	yMz2HBQxy3UG7twGwfGY6PP+ETxE=
X-Google-Smtp-Source: AGHT+IEja39y+Q4EKfOT5RmhpK84lce1sSRvGWSA7ngVNvTCI9c4w/mstph+BRelhpaiJN5ouih9Tn4whbP4K80VAsE=
X-Received: by 2002:a81:7e05:0:b0:5f6:cfc3:f5a3 with SMTP id
 o5-20020a817e05000000b005f6cfc3f5a3mr7629987ywn.50.1706645062604; Tue, 30 Jan
 2024 12:04:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130-rust-bit-v1-1-ed2ed6389a58@christina-quast.de>
In-Reply-To: <20240130-rust-bit-v1-1-ed2ed6389a58@christina-quast.de>
From: Wedson Almeida Filho <wedsonaf@gmail.com>
Date: Tue, 30 Jan 2024 17:04:15 -0300
Message-ID: <CANeycqror72LmGW2NVL3+Yk+GAx+i-9FdS3GxNmW8sXxSeHFig@mail.gmail.com>
Subject: Re: [PATCH] rust: prelude: add bit function
To: Christina Quast <contact@christina-quast.de>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Jan 2024 at 16:48, Christina Quast
<contact@christina-quast.de> wrote:
>
> In order to create masks easily, the define BIT() is used in C code.
> This commit adds the same functionality to the rust kernel.

The `rust` branch has a generic `bit` function that allows the
returned bit to be used with or converted to several numeric types.

https://github.com/Rust-for-Linux/linux/blob/rust/rust/kernel/types.rs#L344


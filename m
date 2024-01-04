Return-Path: <linux-kernel+bounces-16453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4598823EC8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 10:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 830F81F24A1C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 09:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8DD1208CC;
	Thu,  4 Jan 2024 09:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wp+avoIG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4889208B4
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 09:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4b72c944019so101777e0c.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 01:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704361142; x=1704965942; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DZeiLk6oF+6RO9eHA9R6LEyIeFZ5frTJ0yAyDVtKePE=;
        b=wp+avoIGIIsl6Hu+T9hUxKfrlFGt30bQ72x2L2b9mSc0r34oWBIYr7XGChgEGbTokn
         2qwnge9dHx+YnF5CIFvL5Sz1b2mGv69h7vjdiAviVaexkvCoN43CPytO0qOaxLApApp8
         qGVZOMZQsQ1yuE3FKJlch4IFQ5r1UHjKYXoYjbEm+wvXhjOpriKUxIAcbVSeHEKALhNC
         USLlu20dpCLvpV6256zYc1XFN8qvQ9IjV91kWMj5BbOVWa89EotTOBpmg4p56i5oBWdh
         tOXQa9hgDZlRtzCfMpjjn4LOA4jk/avPqZw93auzbuHtHf/bn6PoR6UaKFwbT65J9loG
         okSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704361142; x=1704965942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DZeiLk6oF+6RO9eHA9R6LEyIeFZ5frTJ0yAyDVtKePE=;
        b=sqe3g+uGDqBgfzmsQ8leLtCzq4FN6LS/3oPzJrtLtF8p8xHLWXKiJ3AY0x+uR5H+Nl
         3kl3y/k5vctOD22Yot1CHqSiXS+cA1W/q/u0tVRjPAPflTmU9rw5pKRuQKv+A17M/hV4
         o9AVXhS2Kw6yRe7H8Q9+NzffA2W6/G3WLHBnqbQrPa9Fy0oYpC4bLJUvvVLKtKZUl0Ww
         0rEB99O8RO3x6V7foCOP1t1UdDzwBdiAVJzXN56VYJ9cJiuBILE8pGMTFkg8kLG74b2C
         L26YyYNBdYGebmGCkWuKEkCmmixWeTkM2VFYoe20RVNxpxSI/bCX/pMcwFr/ZPeeSFfF
         Td2w==
X-Gm-Message-State: AOJu0YyihztBiyG+JpiYhKjD+KzHrYYl1kDiLLha3kXcraifemtoF1Ys
	GXlDsMmdxN2+UL1hYRACKittioHo8HeaoE+VLDOf7pvbyc6Y
X-Google-Smtp-Source: AGHT+IEOMY1Vj/Y9twOHHIiLLD6NFGauZ088jDqR8Tph8uDLopusypVmW0x4+T4q1f/cue82fXMbtTJfocpFsHftdN8=
X-Received: by 2002:a1f:7381:0:b0:4b6:c815:bedd with SMTP id
 o123-20020a1f7381000000b004b6c815beddmr244104vkc.18.1704361142581; Thu, 04
 Jan 2024 01:39:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215194828.2611213-1-mmaurer@google.com>
In-Reply-To: <20231215194828.2611213-1-mmaurer@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 4 Jan 2024 10:38:51 +0100
Message-ID: <CAH5fLgjeCTTbBV500edTNqMqOp=_v_27eULab=e9WBeYjrVeig@mail.gmail.com>
Subject: Re: [PATCH] x86: rust: Disable entry padding with Rust
To: Matthew Maurer <mmaurer@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 8:48=E2=80=AFPM Matthew Maurer <mmaurer@google.com>=
 wrote:
>
> rustc-1.73.0 used by Linux does not support entry padding. Mark entry
> padding support as explicitly incompatible with Rust.
>
> Signed-off-by: Matthew Maurer <mmaurer@google.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>


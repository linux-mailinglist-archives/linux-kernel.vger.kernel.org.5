Return-Path: <linux-kernel+bounces-41861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D05183F8CA
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 18:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE5ED2841DE
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EABF2E3E5;
	Sun, 28 Jan 2024 17:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ej++UgDX"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1FA1E535;
	Sun, 28 Jan 2024 17:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706464124; cv=none; b=M8AtaRhRLH5ewmbiczV3kJjka29am7ZJEiGpe5WUaeNg6W0RYuZu+5kTBr0LC5JC7WvbK6vwqiF8fa1efYyYRthWL3AshIlAsiNe5k+MRTxm0axN/cLkiVKkovGFVWyL0ZSbdX7T8SLYFZDkuskPKQxIe79hB03wYm+j8/qGoHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706464124; c=relaxed/simple;
	bh=U7RxjVEDeJKfeIK+ZxBy9hyG1uB/bUQuO/TGE+qZ4g0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gtC8yFKHyD7YvCzyF7ldtjD/CXT3tmx2Wy1XVqncphfAs3+oNRB2JSnxnAe+iJiGKpwVWtD17RbDOvCi5bGmYsD3ooqU+vx+bnCUSJoqvZhAG+WAJMAwq6nRG5MFiN0MvhBEdxq2t5yBEce23t3S8SFCnt1Vakqn8IWr/ED402M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ej++UgDX; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6002317a427so15135837b3.2;
        Sun, 28 Jan 2024 09:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706464122; x=1707068922; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U7RxjVEDeJKfeIK+ZxBy9hyG1uB/bUQuO/TGE+qZ4g0=;
        b=Ej++UgDXssjv7HwLgzp0XzDFpEZ4OxKaiQmxSe5wBYoAFotQjKiu1KpEa8wZdHJ2v2
         3BC4ANP/x51u3Vdfi2CnhHk5gnq1tuGq1VoyGE7sfmNWYoGsUPZjBktF/oKiEpa1idjq
         XpTquIO7Mzfw1NfA2qNfyISHJbaccd8YarG5vId8jLYOCaRpK4pX49jw1QjrgbxvyOuN
         5t6R/b94ggnwvjkfLZ9ZsE9i/2d2Z6NQxOxZKi2O+0phu/XPdhUR3vtZsti5W/z/cNGw
         mnvxK5NnfadZibc20PDi836kQaeZnZ5U3VP1gzDTpENHbjSxErjD1/mzkuV3ougtdv68
         pfIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706464122; x=1707068922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U7RxjVEDeJKfeIK+ZxBy9hyG1uB/bUQuO/TGE+qZ4g0=;
        b=HhriEqi/tb1m2RUs7q2i6f+uA6/rYVbRqMffdPx+Buqbj+N7Zf//LVN69vMRLKCBcU
         6EGBjXq3DRu7yOVcIY+4bA/8eRCaOnyAKCN2/BVAda2cIGDHpN6F6Bksa4+wxuewn/VM
         I5ZWmWVLjI184ZmN5OPJvocftMKcKH+4cuvFffQzFV0KqsQnUZG08toM3If2pZhvIlHF
         h1pK+U58L18WLKK0+YWASoyiA5vG/x5PRNYW3zPn6N5naSW2rofztZw2jQT4uVLWubYC
         qixiroGhHTwVudgQ62lXUYjgbJsiW2o58pwruksT4mWji1WuWqjsBMOH6yY/g88zzObi
         yIvg==
X-Gm-Message-State: AOJu0YwayCXnDqCoqhQs+htimOUS0rgjkqXzk8ndJlmvO2eY39Vrh7n3
	9Aq7KOhjE45cO0M598dvdl2I01wSHl6r/hWty4MwUS/YZ28d4j9X7kEaY707HKTS9xSL0Rk7Ml/
	yq/kcvP7vI32Qz5h5E3v3pfrrcpQ=
X-Google-Smtp-Source: AGHT+IHSSgk7hj4KVzNM+xZ+mFaeFeBUHNhSGrvqaOWtmvrK02jssfMBu44/fZYOXuMlH2Dnvv2mHTgKOeKRjdAIpBA=
X-Received: by 2002:a81:a085:0:b0:5ff:5a4e:569b with SMTP id
 x127-20020a81a085000000b005ff5a4e569bmr2827191ywg.71.1706464121580; Sun, 28
 Jan 2024 09:48:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215194828.2611213-1-mmaurer@google.com>
In-Reply-To: <20231215194828.2611213-1-mmaurer@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 28 Jan 2024 18:48:30 +0100
Message-ID: <CANiq72musVZbNW5MuhrRJEmA8G_D3D7Ms0pTYu16WrqhFx2pXg@mail.gmail.com>
Subject: Re: [PATCH] x86: rust: Disable entry padding with Rust
To: Matthew Maurer <mmaurer@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 8:48=E2=80=AFPM Matthew Maurer <mmaurer@google.com>=
 wrote:
>
> rustc-1.73.0 used by Linux does not support entry padding. Mark entry
> padding support as explicitly incompatible with Rust.

We are now at 1.74.1 and moving to 1.75.0 for the next cycle, which
does not support it yet, in case whoever applies the patch wants to
update it in the description.

> Signed-off-by: Matthew Maurer <mmaurer@google.com>

x86: are you picking this one up through your tree? Thanks!

Cheers,
Miguel


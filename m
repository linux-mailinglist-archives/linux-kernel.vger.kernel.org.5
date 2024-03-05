Return-Path: <linux-kernel+bounces-92331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 109C0871E9C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD0F928636D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A29B5A4C0;
	Tue,  5 Mar 2024 12:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mauQb4+r"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A4359B70;
	Tue,  5 Mar 2024 12:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709640579; cv=none; b=R0HXR5jBPOWeUGo03lEQaEuVLXFxCfSENFp5hvYjuEZWvCaZy2BJy8r+vPeNlKyOiJGI4/Qe/KqXJuo2IHGisl2I3DGAjdnGS3RFBwYgLi3E/BqBgTaGQysEYD4hLt+PRTzYn7X8ROO0lnFovzJ+6dHPEWybO8oLKf2R9VX3LOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709640579; c=relaxed/simple;
	bh=acImUU2ee6De98DXLz6jTADVPBNvRHY2si+1Gxs3+rg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eImX/cddOnR88Rincg3bYTE81JQaO0/ySJTXD2Iq0Xpt2ocmiz8sXcf5NrXNLSf5v7dbS8HAwDSBC5gM0/7RBf4avRC6sQ+iww2GD0UN1zuziSnPRmbSOsBhll1WYVjoP8yPQYEo09k9nvi4TJkq04Z2iddbxlcx3UENofbVdOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mauQb4+r; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-299566373d4so3550864a91.1;
        Tue, 05 Mar 2024 04:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709640577; x=1710245377; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=acImUU2ee6De98DXLz6jTADVPBNvRHY2si+1Gxs3+rg=;
        b=mauQb4+r9bWUOa/fgRNfB8Ksl1sXS9lfzZNS4mlYltYTRrj2ZOrBpd5dUzGcjaLLTk
         NCRVHdIOHPoW+JFmDt/uRy/PC2dTYThfhkJz4lkxcHcpBtXCvBqjE7BQ/tnF0ppGIU1s
         xtRY7vOO3U272FzKoZMQwwxBf/PP7M0UfCdiGsp4aGZIJxFl0l9EgRxl9V5oWmAR9Wr4
         ZotHocIny4BqI4qDZzwt0VyCrbBMaUx39pbPAIa+8ZwVk2m2V2CEU61T2LnkkMaKQipU
         PXF6SuLYUg5M34byEaiPOo8pyDm4VsHiTiTbL2fECIFIDx/pGOrKP++yBKKE98e9YCfJ
         faxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709640577; x=1710245377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=acImUU2ee6De98DXLz6jTADVPBNvRHY2si+1Gxs3+rg=;
        b=OEssbLZWrdwlTYGUFR8/r3CM3CSdXclkLbXGzCHyT/MREWUiVVGEcai1rcCM+522iN
         r4R7d/LFxuqxbi7V48tUVaAlExJx2GJtGbvq5YZQgMHWnRkL1o+apGWSR8MDAO+JKo2S
         O6fzgKlPSPmr+VoI9sPKAuAF9QMNl6JRWm+mEzVKG+RUoK4Yp691sYh3mVBEHtC+1Zco
         heXQAUkZbf+eGf7gULwelMhzhd5ZS1wj1QaRxKisjsJb+3gCYXQc+p9Hf1/rl93z7E+j
         PmHF0lAjutM6Vbr83syv/4tAcIAtThVTN+ZmeryVHyXlQC+0WCx51JHGwwz/fzg/BzYt
         c7eA==
X-Forwarded-Encrypted: i=1; AJvYcCVYyssbPhMXnt9M9dwxoR/mbszQMXFc9V7WEXjznnOBB1XHYwuaALcRJdjaa5bPQOJOoT0gdVUlTidnMjsyMmfD3IrsDYTGnr23e8duZy83t0e+vD0Q9jAcVXqj6VJddvAvF7iDlXd6ggH7r5hXXnVstNcjzliFU2i5nK6GONGo0F8HQc/3ZGUokCs=
X-Gm-Message-State: AOJu0YxYXobVSNz+L2cSBqc4v3x2aRryMWuKJmnZn9Kpwv7blbrjKz9J
	iMeXgJFSHUAWJwBFEppar7sv9rO2U20MZqqiscRb+wG7TElzWT3RTonfDNTuKuMVy68Z0pBaLyR
	7Sl+PmbTZGUjaqMWYHolQji1e2gc=
X-Google-Smtp-Source: AGHT+IEBlP3sVnHX1pjqltpYcsd6PeyZyHO4PCfL0i+X3dO0BirSfNyxncSN0TdpzHdL4I5sVSTM5uTjSmbh48b5VKw=
X-Received: by 2002:a17:90a:fb81:b0:297:17fb:4d79 with SMTP id
 cp1-20020a17090afb8100b0029717fb4d79mr8398479pjb.2.1709640577152; Tue, 05 Mar
 2024 04:09:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304-shadow-call-stack-v1-1-f055eaf40a2c@google.com> <CABCJKuem3GbLO-G7+wi8LPA8rFgNzFVjNof7zcAO1UGJR4u44Q@mail.gmail.com>
In-Reply-To: <CABCJKuem3GbLO-G7+wi8LPA8rFgNzFVjNof7zcAO1UGJR4u44Q@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 5 Mar 2024 13:09:24 +0100
Message-ID: <CANiq72nQOMjBgz+4gzDhT0kVjVwn23OD0F=S8oZf-yf0+js5rA@mail.gmail.com>
Subject: Re: [PATCH] rust: add flags for shadow call stack sanitizer
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Jamie Cunliffe <Jamie.Cunliffe@arm.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Ard Biesheuvel <ardb@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Kees Cook <keescook@chromium.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 9:10=E2=80=AFPM Sami Tolvanen <samitolvanen@google.c=
om> wrote:
>
> Sure, having a custom target description for the kernel might be
> useful for other purposes too. In the meantime:

Yeah, though to be clear: eventually the goal is to avoid using the
`target.json` since it will not be stable, i.e. the support we have
for `target.json` is good for having the maximum flexibility, but it
is only a workaround for the beginning.

So for each arch we need to get things stable in one way or another
that does not require a custom `target.json` (`-Ctarget-feature`s
where they make sense; otherwise "global target features"/target
options/flags or new builtin targets).

Cheers,
Miguel


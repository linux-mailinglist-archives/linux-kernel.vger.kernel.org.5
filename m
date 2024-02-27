Return-Path: <linux-kernel+bounces-83203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C59E786902B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 657811F21DF6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F1013A88B;
	Tue, 27 Feb 2024 12:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7RzuOTH"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B6113A877;
	Tue, 27 Feb 2024 12:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709035986; cv=none; b=BEWCLxQWV1bwA18tKItZc0C2q2omtN6GUGOBVw66QBjqmaS6Bdu95UnwbpU4LpRgE4NcGC5BLE614gGrdZ6nkr56OetKqE2RIhnO1qhsdkp/+bfEFFgLsPaiM6A++aJtUDrJ9K/MUdGimO+FVdkr4ANp6ET+tYX59FKjINxX2Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709035986; c=relaxed/simple;
	bh=PNfuFy5Ba+D5qLkPXV/F9tZVKt/ke8CC3TLHGloyd2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mgM1DsJkUa9/Tdtri+bw0ikMfdU0rrAF1xxfxPAxvkCv66W9KfSgQc+nxnfYATv2gkExG5p6WkIWZG2MhN0oUHQAMwjjPQMIsAYp6qnLquicrOtkoULgkAHjY7ZRv+97aJmt80Hw5Eml8kqJxh2smgnjz+QQvjuQTiiHf91qpDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A7RzuOTH; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5ce07cf1e5dso3310671a12.2;
        Tue, 27 Feb 2024 04:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709035984; x=1709640784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PNfuFy5Ba+D5qLkPXV/F9tZVKt/ke8CC3TLHGloyd2k=;
        b=A7RzuOTHT5lz7H92/ApnlKWkrpzABYAqTtBJob3puaeqDP3j8uvkkM9vaZcbzzr4hP
         cve7C/GSu3+ilq18saUNgNNoPyo3fSND4ON7zrzCnc77KlD1aNtaaFlxBe/YvKrJbco7
         56zQGnTMnTS9FITUmEqIhGQrbrnAkqXk4I1h7AbLgAe3cJMHuQzUUfvsPp9JUICBaehF
         epGbY+0dzpdC45ddGFmVVt87yy3LJZx0B9GHy7Ncr1ssIexs51tiL0Qi4aWzhp+Bv7wS
         mnV16H+SW6GonNihM0Lx3jRvgCUhrX3l1s/2ciKaOGi3iWfjSx8l9b8fQYps+b0cshkd
         gSUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709035984; x=1709640784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PNfuFy5Ba+D5qLkPXV/F9tZVKt/ke8CC3TLHGloyd2k=;
        b=vn+5+BZ52UbCI2vApJKwl06WFhO14jP+mpeKw5CD4NQ6B0F7Fuv/gsj2H82N/hAMpI
         DyXKoRBxRqfKEcVLy3f+I5chlujJHQz1NEeOesNLz6DpAfpUf1d00HLEQ5feKi8gtvAI
         gg+t8dV9yY4LtdMCxZqVYw9PxgOMTqy0rfzka2F1Fata0+UnLqhTcrrU8EhVa04EOj8c
         XEx5dv/QYnwMs2Ev63MeeumVUw1xmu0mQ5tApEoFiNVYKx22ElZAWC+xsgsubBg4Rcwg
         0t3Y37aGy9ob+HK66SKWfDY1XoaEJcUKrpiDhyVT3/llgaUzRBCMFjVs6U5dMpmZQGsC
         wVug==
X-Forwarded-Encrypted: i=1; AJvYcCVWi65WapItJITmttdmeB1zFHEUfmoBDk9a9wLxlScZ9L7BS9v8si3N4yn9llAGxIw6xMaYJdaaXkLbWgU3yZnrT0UWYcbveGY5uHELGC3YB9fQT8mVsxgE1HLaAWSMyUX+jKM+Ha0+ez+r5lyyVV+Gn+C31eCgNCChtxZKiH6ylplaccNxzzU=
X-Gm-Message-State: AOJu0YwiBLOXS/XAMfAdjMPcFdTgyi2eVrTGGumAW09QTQ2vubzkw3mb
	bX4dHtDYNX4f75/nBGhHhobzspqLKciQ80zqG2m7SVE7AP5hvynq68DHjGomewkrTWZ3mW/CQjk
	TQkfQFin9zpvbC7EDDpjxu5R1ZOk=
X-Google-Smtp-Source: AGHT+IEZrxxC5KTd1mUmyNpa02ckU0dvc0XT6naKz7W71hSie5HLJAV5L6JVbDjYli/t99gdzmOA0c0J+BbxKw9TRZg=
X-Received: by 2002:a17:90a:1b85:b0:299:6a7f:3f55 with SMTP id
 w5-20020a17090a1b8500b002996a7f3f55mr6019384pjc.45.1709035984277; Tue, 27 Feb
 2024 04:13:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223-leverage-walmart-5424542cd8bd@spud> <20240223-employee-pessimism-03ba0b58db6b@spud>
 <CANiq72ngEZskjH0f=8+cJuQsFTK227bGCxe5G0STMHuPbZYnXg@mail.gmail.com>
 <20240227-resolved-deceit-4a59a6af5b71@wendy> <CANiq72mwM+4Oh-H5WmRoqQ_nE1w-eJ1wn-nEwS=BR9JRwzxMMQ@mail.gmail.com>
 <20240227-glove-underwire-f562a56cf2c7@wendy>
In-Reply-To: <20240227-glove-underwire-f562a56cf2c7@wendy>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 27 Feb 2024 13:12:51 +0100
Message-ID: <CANiq72=f03_bw9B8ww8UxHkVyP2F7ZPyvC+KWCyhO3Nk1yqdaw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] scripts: generate_rust_target: enable building on RISC-V
To: Conor Dooley <conor.dooley@microchip.com>
Cc: Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, 
	rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 12:05=E2=80=AFPM Conor Dooley
<conor.dooley@microchip.com> wrote:
>
> My point though was more
> that either this was acceptable for v6.9 or would be v6.10 material
> with the same mechanism as arm64. Rebasing after v6.9-rc1 but not
> adapting to that way of doing things is what seemed silly to me, since
> if a resend is required then the other improvements should be carried
> out at the same time.

If avoiding the `target.json` is possible, definitely.

I didn't want to assume it is, though -- e.g. the native integer
widths you have is 64 but the built-in targets use 32:64 (perhaps
there is a way to tweak it with an LLVM param via `-Cllvm-args`, but I
don't see any obvious way from a quick look; `opt` does have it,
though).

(That is why we supported `target.json`, since it gives the most
freedom in the beginning.)

Cheers,
Miguel


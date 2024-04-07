Return-Path: <linux-kernel+bounces-134633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D064989B3E5
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 22:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71BFB1F214AC
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 20:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669643F8C3;
	Sun,  7 Apr 2024 20:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rz+iIqt7"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DA23D988;
	Sun,  7 Apr 2024 20:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712520212; cv=none; b=BUlT1+muV1y1u0oL74gZgHVb2kOyAMnn5Yeu90xHN4nzwc8NMMa1154Eulg/r1MkBFN4QUzUsLE16NVeIz7gV7zFLdJ9EZMm3YEQ8vsi5M9d+Jw9nZNteo4zkqp0+r7QfRL3kdGPcHT21ZwYbPmckQt4d5l3orfIeE/OHqI5Wp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712520212; c=relaxed/simple;
	bh=zzYff9yQtgJXPQgk/ATjyS1y8lhCcN/zh2bqNrpQlq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bTnQoS/Mqx6OzCNkQB+NDIIWkFF4KB3IJinCLaGC07nCfjlw/23VXaqaJ4HQoC1mm7GMvelq7UmrRSxXZFfte9Kip4tIRtaVpaM89r4DwMACjiaauv+AwqLY3d4J1f4Ct0dcFlsv43HKYKj9xadzXDkFzZ6HFyAcFT5wjUIq3R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rz+iIqt7; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2a4bdef3d8eso511209a91.1;
        Sun, 07 Apr 2024 13:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712520210; x=1713125010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yfMh48UYa1lhTnaBkcMEl7zleuPMjILYPz6KbF68Au8=;
        b=Rz+iIqt77VMsFA2kA24zP2sI+lF2ahNvmzO2Y73uclmnTzfVvs/TheyeWfSFyzncGd
         sidu3lYxMk0n4rQfOXpQ4yr3J6Xt6OlFQKq0BGWO76lkp4wqRC3xIvVIfnXADosyq9Xx
         H1nu3iJR14XxVh1mFiNbzAAZq0/c0PQ3AnyMvbSfZI/cyfjOwg5L7e6Zrl3rZBRjvjw0
         HvuHZSLbBiGDvfegcxPUQicWgAq9VspLZU7SN3K17urkMORclNip9axr6arCulQa/Zff
         1/SVu5hO05cRUdxnXTYRQ+TSetEcUlrOT6btJh13/apj9Tghfrse5X5pzgpr2P9J82Qa
         ebaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712520210; x=1713125010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yfMh48UYa1lhTnaBkcMEl7zleuPMjILYPz6KbF68Au8=;
        b=Tcurf4/yuc0fAEnTOQ63MQ2e6QMUiOmgL34EmybXq97hIMYPL4/1w9+Suh6hNBeW+r
         FbghTqpj0QaJtkwcKoZcS9kgBg9v47JnbxcEru8uCN54QtzrvOnaGFTXYjFRIKtsDkbH
         aBRYusSMBcIqJN+Kc/kO+OSfyjFJPJjwLh+l/xd4MlktrOfeXdPkTZor5g7tbGHE1SLz
         o7BtsaBqYBrvVlpugzAt5lCUIvtR6a0Acql42ndDHxkUAX40ozrMyay0CTYtz39OyQmx
         ZYtlCenEttdtd4+qcNWjN2gqZ/kmg9SwTRpB4HPHdGy6R0cR9uEkgJ5PzW3sF1lNkD4L
         z8GQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEAVGKNBvKFt5FgpVEKGh96BOuwrTpSpU81pB8GtkwaDzp52ji4BUhnJUviy5teyXRHbPpfqy1Y44gMFQ7YpJ6WSUCz6bxTNad6wPiWoee2xvPpKK2+NlR3U2GjkfIiPBUgYTwa0Qg6ZQM9LNEVXjNl6JF9NrxpOSZpZXfpq1AfB5OFFM=
X-Gm-Message-State: AOJu0YwxWE64tqqnUckTbvxqfj+A+hxImuPlEMzaEO+PHpm6FVYQWj1e
	WMHMs//PhK+HnrCDCWBchHO7jgwr1sjhDhFKg13jTaRSX5ETybpIf9Fj+eJ+L1UVsOgwp3VOnMd
	dpxKtHA7ZV5KRg/Wt4zUVJtn/sRM=
X-Google-Smtp-Source: AGHT+IEIt1Lru4k/Tnepu4IBYtQBsXst4gyHMFJlhgjYVHRQdcRfEYeE8aY/BvrRmgDuYCRzjKItROgB6OPb0gkL7mQ=
X-Received: by 2002:a17:90a:4dc6:b0:2a4:f53d:e732 with SMTP id
 r6-20020a17090a4dc600b002a4f53de732mr810440pjl.13.1712520210362; Sun, 07 Apr
 2024 13:03:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404-providing-emporium-e652e359c711@spud>
In-Reply-To: <20240404-providing-emporium-e652e359c711@spud>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 7 Apr 2024 22:02:46 +0200
Message-ID: <CANiq72mUGAXj+ajfojfMgOD7S22Q0Y0Y4QCTxNLoNxwCSpksdg@mail.gmail.com>
Subject: Re: [PATCH v3] rust: make mutually exclusive with CFI_CLANG
To: Conor Dooley <conor@kernel.org>
Cc: linux-riscv@lists.infradead.org, Conor Dooley <conor.dooley@microchip.com>, 
	stable@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Sami Tolvanen <samitolvanen@google.com>, 
	Kees Cook <keescook@chromium.org>, Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 4:17=E2=80=AFPM Conor Dooley <conor@kernel.org> wrot=
e:
>
> From: Conor Dooley <conor.dooley@microchip.com>
>
> On RISC-V and arm64, and presumably x86, if CFI_CLANG is enabled,
> loading a rust module will trigger a kernel panic. Support for
> sanitisers, including kcfi (CFI_CLANG), is in the works, but for now
> they're nightly-only options in rustc. Make RUST depend on !CFI_CLANG
> to prevent configuring a kernel without symmetrical support for kfi.
>
> Fixes: 2f7ab1267dc9 ("Kbuild: add Rust support")
> cc: stable@vger.kernel.org
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

[ Matthew Maurer writes [1]:

    This patch is fine by me - the last patch needed for KCFI to be
    functional in Rust just landed upstream last night, so we should
    revisit this (in the form of enabling it) once we move to
    `rustc-1.79.0` or later.

  Ramon de C Valle also gave feedback [2] on the status of KCFI for
  Rust and created a tracking issue [3] in upstream Rust.   - Miguel ]

[ Added feedback from the list, links, and used Cc for the tag. ]

Applied to `rust-fixes` -- thanks everyone! Please feel free to send
more tags for this one.

Cheers,
Miguel


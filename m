Return-Path: <linux-kernel+bounces-21356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC2A828E1D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 20:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D6D91C24A18
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACF33D97A;
	Tue,  9 Jan 2024 19:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iiRWnMAZ"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568B03D974
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 19:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-5e7409797a1so31307407b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 11:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704829356; x=1705434156; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EJNz4LIbNCqWmT96jTcSPLTNmx+8SCupIJghMk4NpfY=;
        b=iiRWnMAZkYUhPexlsl36YVm6hMJxvN/UaWzzEt3SaIOtLHVk6uUX/PpLkDebHSAv7E
         ZGEX17JKmGKGNNx5HZFy12k/xdcL1acs+j+6xAX0AUz07Nxhuapz9ADvwTtC2PIThoya
         0e6C0LVO3o40L4tigNCnRSa+faGU3Wf6RPqzmOBJrImgyeiud346wYnSkKUJNEsxEfHf
         CWt8Oan8r7o+Qcg5QeaNeCBMXBTzUsSbFEtxGlPQGtCo8otDgxcaZpkRwQNz0qDLzA55
         23dFDEEYkDuDLlXqGk+H3dnut1u0gCOhN/iq3uXEZFI6JwfIhSXrLBPrtt4jZ3UiWJKo
         YadQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704829356; x=1705434156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EJNz4LIbNCqWmT96jTcSPLTNmx+8SCupIJghMk4NpfY=;
        b=OIGfbny3i8fx8KlvJXUTkP19Ckg47tnmCRsSa5QTpeD/9oGn4N6Y3hLMpge/s5hsZr
         oCScZT+p2DiC4r1Y0cBHhxUsn531UNAwScCEBVcKEAKeJ5bh3MjPdtL7tlSl1Yx1/Zje
         bkNY+KAEHoCSLWqKvgWehPEb1YrddesG6Fl2WRGrbAfeiXxaqTJDSwZdiyPDyv8bIjph
         UT/hc69P3gUzf8C2djoO3lJaD1v/a7X5fryKnVuUgmwIYodHjw27Oh5qqjSFsv1f7ecQ
         KYMfhdK+BAHRcaj25/SnKYcO56X96cwdPoLBG9+jRomoaycrpOAXwYkoBV5uPrMaY1Hx
         s0dQ==
X-Gm-Message-State: AOJu0Yy7CJxCuuE1M9ZYUIpz5YljIS1wRSxkml2HwguBn9Qp4RrbK76K
	OFAFkcaDuo8UZVHS4GGlEOO14YoKttkJzuHuWMQnie9T
X-Google-Smtp-Source: AGHT+IEnjsjlf6q7BBk0JyZkpxLkg/tDZHUnVSv9y5kFt++WeXhKxSWpGd+TwWfnd9LbK5shT3+u3d5PnUGjEldL6LE=
X-Received: by 2002:a0d:ea52:0:b0:5e7:9474:bc7b with SMTP id
 t79-20020a0dea52000000b005e79474bc7bmr11976ywe.11.1704829356117; Tue, 09 Jan
 2024 11:42:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109133633.1103876-1-senozhatsky@chromium.org> <20240109153249.GA205400@dev-arch.thelio-3990X>
In-Reply-To: <20240109153249.GA205400@dev-arch.thelio-3990X>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 9 Jan 2024 20:42:24 +0100
Message-ID: <CANiq72kjHCh-inyv1aU=eNca1-+E0_85MGU-8qbZZtzbC_VwOQ@mail.gmail.com>
Subject: Re: [PATCH] Compiler Attributes: counted_by: bump compiler versions
To: Nathan Chancellor <nathan@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Kees Cook <keescook@chromium.org>, "Gustavo A . R . Silva" <gustavo@embeddedor.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 4:32=E2=80=AFPM Nathan Chancellor <nathan@kernel.org=
> wrote:
>
> It is still possible in theory for this feature to make clang-18, as the
> release/18.x branch is not scheduled to be cut until the fourth Tuesday
> in January, which is two weeks from now. I don't have a good feeling for
> how close that pull request is to being mergeable though, so this is
> fine for now. I assume this won't go to Linus immediately so we would
> have time to change it if necessary.

Yeah, I was wondering about the deadline too. If LLVM's `-rc1` is the
latest time possible to merge it, we can wait the couple weeks (which
are conveniently the merge window) and I apply it afterwards with the
result :)

Cheers,
Miguel


Return-Path: <linux-kernel+bounces-108468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D88A880AE1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 06:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D19A5B21F5F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 05:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC2C17BD9;
	Wed, 20 Mar 2024 05:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MOuL+v2E"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BC511C83;
	Wed, 20 Mar 2024 05:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710914374; cv=none; b=fak/v80jjeO2C/OGD/5ARMgS0MqfkiNtRXPqI1r4s0MCKuomA4hMpclRmosl9p+oIgd4HY8jQEaf2ePldbJGvDb+gDdTPnHwHhuOYmmo/7ChxXUYiiAWzGtH0h4+60cIwOcp+FmxUY/NpnFes/ogWzMucv1MCV5bDUj5brWdVtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710914374; c=relaxed/simple;
	bh=wnWVQmhHXO6OdkrpkR/yCVSPqVGouB39dOVXMCOUoG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eNFDx4JWSO+L4EuEv0eV+P/lNcWZYEtwGa+GIrFYJVfuF6W8pLfUniye8k9YxSu08Av8CGy6xN54ohKi0TtgGpjKr0NYHmnMThfnTuAYoSNmT5/NE9NIEWUY32jD7QIq0dNRY5F2ra1CYG2NI0Ks3S6MlrjwNNV/cr1PxAwd4jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MOuL+v2E; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33ed7ba1a42so2435867f8f.2;
        Tue, 19 Mar 2024 22:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710914371; x=1711519171; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZpRbuT9S1qz2rJkIt3EtSAXCW5aYksYriH4Qy/fKXiY=;
        b=MOuL+v2EuMmX3l5RjILiophWn1QkjST1W8KtboMWu2csIvnk+L3v5CV8JPuIS3ZJ4Y
         DtUSZWvI+WaQpufROY/BecWSWwQStSA/DXdNkargr3Kz0Z4NQJOiP8046hAXekrvAPo9
         7hv9DJZamiFMmkrwPaX7CPB0IgKJGj8v4oftpjfSWqcO0kiAwWnkvjTULBDWvTjn0DhI
         /Njt2MUia+oN1UfNSQkbStAIMONms75z8IXU4uwabHioNWBjJXcPgiTj/ayAQHGdOP9u
         qVNMoJ5at55lXDo8uRUMGZy7oZpKd/5ABuW23pkY1VAdWoqvbZczceHLPLZZ1aY4MjoH
         kuXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710914371; x=1711519171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZpRbuT9S1qz2rJkIt3EtSAXCW5aYksYriH4Qy/fKXiY=;
        b=a91UQAeJyLArwfbEHZrSsZ/I2ljp8wBOAxYAleNnX8QBWaEcSMsitv3CzBa1fgLvf0
         NNKPuzkImyr3FXULvU+9KAnmY56nVRF7o754E57sahyiS/355+A2vQKZRxjNM9Uq+7Li
         ZbZ+RtgZBxoJA4npboyJuGQ9bEefe88o70v8dHZbVzfYl13HAXePee526v13TS1fPKbb
         XI/mBxwL4n8iDoz8fTSCRrDO21KwG/FvjH7FC8jTzkBxOgwtia6QsJUrH5NnuXMHVozN
         nk8XV9nMtyqic9aMt7UJ+i8FIH52t5RnMcG9BzLrMZa1QGr7RW8pfitKx6x7BC6YyqCp
         iaYQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3CVu/7VqLQpjYW3AVtRh/kYPPPIuVj1MIjV2eJCbV1p13H2H62h32RExwR3FFAAuOkZPYDakajtNEwAUZT/QSu0uFIiaiAq+x5DCKROhVXZyH2EDbidFmNgHyQj2yHS6IQfKQiLAPUDHLrtAyHVjmuzD3ztugOZIi
X-Gm-Message-State: AOJu0YwG48q5jwBaHmvqddL/yakLGPvevXBvSdthxvR0oLaPXtQvgJ3K
	gj/8DCn8UZXbUdxgcxeW33vyM2qQa6C1R+lS66OWI9Sv6Zd1qDK/CW2Gr5Mr6xaHLxD8Np3hvb6
	A4y+vvQdQG+aEEorosDj+H2oEm20=
X-Google-Smtp-Source: AGHT+IEuKq/oeh8snLQ1ysN7bWmnWgb0yRXr8arOzHpM4V7w0eKbDoS/ntI55AumVzU20oSWmMMY7wkSNpe+2XjHps4=
X-Received: by 2002:a5d:4c82:0:b0:33b:187c:4ca0 with SMTP id
 z2-20020a5d4c82000000b0033b187c4ca0mr3345363wrs.62.1710914371012; Tue, 19 Mar
 2024 22:59:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313140205.3191564-1-asavkov@redhat.com>
In-Reply-To: <20240313140205.3191564-1-asavkov@redhat.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 19 Mar 2024 22:59:20 -0700
Message-ID: <CAADnVQKgkz=gUHbPc0-hcAcirzUe-mYhioACNpORuXGS6-moaA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] arm64: bpf: zero upper bits after rev32
To: Artem Savkov <asavkov@redhat.com>, Puranjay Mohan <puranjay12@gmail.com>
Cc: Xi Wang <xi.wang@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 7:02=E2=80=AFAM Artem Savkov <asavkov@redhat.com> w=
rote:
>
> Commit d63903bbc30c7 ("arm64: bpf: fix endianness conversion bugs")
> added upper bits zeroing to byteswap operations, but it assumes they
> will be already zeroed after rev32, which is not the case on some
> systems at least:
>
> [ 9757.262607] test_bpf: #312 BSWAP 16: 0x0123456789abcdef -> 0xefcd jite=
d:1 8 PASS
> [ 9757.264435] test_bpf: #313 BSWAP 32: 0x0123456789abcdef -> 0xefcdab89 =
jited:1 ret 1460850314 !=3D -271733879 (0x5712ce8a !=3D 0xefcdab89)FAIL (1 =
times)
> [ 9757.266260] test_bpf: #314 BSWAP 64: 0x0123456789abcdef -> 0x67452301 =
jited:1 8 PASS
> [ 9757.268000] test_bpf: #315 BSWAP 64: 0x0123456789abcdef >> 32 -> 0xefc=
dab89 jited:1 8 PASS
> [ 9757.269686] test_bpf: #316 BSWAP 16: 0xfedcba9876543210 -> 0x1032 jite=
d:1 8 PASS
> [ 9757.271380] test_bpf: #317 BSWAP 32: 0xfedcba9876543210 -> 0x10325476 =
jited:1 ret -1460850316 !=3D 271733878 (0xa8ed3174 !=3D 0x10325476)FAIL (1 =
times)
> [ 9757.273022] test_bpf: #318 BSWAP 64: 0xfedcba9876543210 -> 0x98badcfe =
jited:1 7 PASS
> [ 9757.274721] test_bpf: #319 BSWAP 64: 0xfedcba9876543210 >> 32 -> 0x103=
25476 jited:1 9 PASS
>
> Fixes: d63903bbc30c7 ("arm64: bpf: fix endianness conversion bugs")
> Signed-off-by: Artem Savkov <asavkov@redhat.com>
> ---
>  arch/arm64/net/bpf_jit_comp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.=
c
> index c5b461dda4385..e86e5ba74dca2 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -944,7 +944,8 @@ static int build_insn(const struct bpf_insn *insn, st=
ruct jit_ctx *ctx,
>                         break;
>                 case 32:
>                         emit(A64_REV32(is64, dst, dst), ctx);
> -                       /* upper 32 bits already cleared */
> +                       /* zero-extend 32 bits into 64 bits */
> +                       emit(A64_UXTW(is64, dst, dst), ctx);

What does arm64 ISA say about rev32?
Since rev16 is special, it kinda makes sense, but still.

Puranjay,
could you please help review this fix?


Return-Path: <linux-kernel+bounces-109150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B70A881559
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D4681C22D41
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4A054F92;
	Wed, 20 Mar 2024 16:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nOIiOsS+"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B2453E2C;
	Wed, 20 Mar 2024 16:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710951388; cv=none; b=JHUOYvxwgXax1PARaC3L/N/ykSQNeGJshznw6XeEbOEwAMe+y44QHCIyi5DYh7nMSSx+l5pKZVxYd3freeyNcexytf8CNf51tnI45/G6sj0CfoUJNDWKbluIpL2JMt9UnM4cyi23e0ogbHvTZS0SvJc+iTLY9FH49BRHWFO6VMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710951388; c=relaxed/simple;
	bh=broyNhC+LQwL1mbuvnbMJ5UwpBQ7u/XIopDlwALUS1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kumBSYj2I8Cn5A7pes3IDiQLwyl7/WTQ8rbhbVnRqMEWdCfZ9D5bbr5uSIzwInXHvdFAxgjwdAV1J3xl5+DUXH3CkL6zc+fCR2SxaVtd0DmCwaGeo9MOekrO7Kg95UwV71WC3SffNA6m1oCgjbz7I/ZY/0zFW0Xnv46F/0BDkVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nOIiOsS+; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dd161eb03afso6159668276.0;
        Wed, 20 Mar 2024 09:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710951386; x=1711556186; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J7zcKzLeLuV2QN7tdmgwY/Yj0bvv0ZFQ755DxYO1zlI=;
        b=nOIiOsS+vwx3KNQmPiVYh7E+qyGzUN7vZ8lF5mVvRPLpZZZTdSfGJ/BA5GqXdDPg50
         Xeb3NjlOjJORlwK44HHqzUQn56qdjvUpYYpV9IUUB5Suo3CfAUdAbBl/ZdEYaTMpuY/M
         lV48TJjp70Lq+T/sPN+sxM4aBdx2J/MHp7pgARoQPjgSFLasbS/LmJNX3aPRdaoEzpmS
         5YrVHhnvQUqLyfGjyt5o0uqszkVr5gWKygigc80tMunJ++lgRmUloXRoXUQ6e8fI37sd
         5r2MFJJU16ukiN/nuAF4Dt0hrhEEMZUBW7YNQscNerwkfoLNeoJ4ZGMD4V9slZx7xfn/
         IwUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710951386; x=1711556186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J7zcKzLeLuV2QN7tdmgwY/Yj0bvv0ZFQ755DxYO1zlI=;
        b=fK1FOzxHZ8zWAhRjyWMdzb3q1pZbTp43mypJgkPq9STdwTxbpCzgzHraIFVvM9DDjH
         SLHCVAIlCAZq/lSVZvagT+HghF2DAxLXOSCU8DoWGyEdHFWFGkj5Su8CNERoio+OGDqu
         wb8FLl6U7GoGhhyQ0N5jqhrZOITi9alZiaBLEvzW96jJq+Q/C0lfEOAVwO3UK4cCSyki
         8VzyUS/vvbO2+C4ETKP5j/9wycoNe1iiuZ8iR24CerBuhNZjpNjHlXNmGgESZ5U/JMhK
         zlv9WY3RHs7teX7bjeQzzBBRJ7El/8sDDn0ecR0jGV0dgJpmuzXJnSfp4nkXGcq3zJtv
         wZAQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3Dp3q7/jEGtVDqkDjfgfshkD9KMVS+UKHbyYnaMwZbDJb4UACBm+OQ0gwpVX/YL1dVQRzvm9EaAWDOEh0teQkLlbiIeOdsGgMGFVr2coeBXceUjDHRkAOyWfLA2FYQZ9JwAnf5CIRbdKaSXqgz+WNMJzwyBTM/w5d
X-Gm-Message-State: AOJu0YyAjsFJalUR5ieCKo3ctm7yw+b5H6fsoRV/8Fr/fM0bF+p5b+gU
	EEm0g4FluMaCrKnVN4Y2KWc2a7WwwMWp/8iTwADVIwHXhpeyN8pb/Jhomf5n04HiJg4wpuWZKYz
	C/Q9rjSX4N1wyvimIC9byqrCyuSw=
X-Google-Smtp-Source: AGHT+IFl748OBAngwciBWOI4C7e8gcggI8g74QLqeYC/6cWTTILObCfExGIgjGWeAJc0PdHdsK5QSm1FSXO75AU/z8c=
X-Received: by 2002:a05:6902:1889:b0:dc6:17d2:3b89 with SMTP id
 cj9-20020a056902188900b00dc617d23b89mr16530121ybb.61.1710951385062; Wed, 20
 Mar 2024 09:16:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313140205.3191564-1-asavkov@redhat.com>
In-Reply-To: <20240313140205.3191564-1-asavkov@redhat.com>
From: Xi Wang <xi.wang@gmail.com>
Date: Wed, 20 Mar 2024 09:15:48 -0700
Message-ID: <CAKU6vyZ1LOUtJz-XeQz8i8f9nyvN+TZxOMfEf6JP1Tfuwneiqw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] arm64: bpf: zero upper bits after rev32
To: Artem Savkov <asavkov@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 7:02=E2=80=AFAM Artem Savkov <asavkov@redhat.com> w=
rote:
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

This tag is not right.  It's unlikely that the bug has been around for 9 ye=
ars.

Maybe you meant 1104247f3f979 ("bpf, arm64: Support unconditional bswap")?

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

The fix can pass the tests, but emitting an extra instruction is
unnecessary as the bug applies only to unconditional bswap.

>                         break;
>                 case 64:
>                         emit(A64_REV64(dst, dst), ctx);
> --
> 2.44.0
>


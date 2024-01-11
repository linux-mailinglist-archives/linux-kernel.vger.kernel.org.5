Return-Path: <linux-kernel+bounces-24052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8C382B612
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 21:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1F6B1C23AEB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 20:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3365821A;
	Thu, 11 Jan 2024 20:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yA1hq8y5"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51A15812F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 20:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40e62043a5cso645e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 12:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705005269; x=1705610069; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZhucuI11iLm9jZSo5DyrLuQREbxS6U88O/YNonTCxz8=;
        b=yA1hq8y5Uw2ph0oQijZJOjlee/RLujzmEgrk2cYBtYcVwt8VYVyE1UKUGGuzqCD5Lu
         rPSGYMQ6dlpLWyWFnOgRCaLhmKjQHFW3mB5j8VkXAog/iiTViA0xf3NMaTb832m+jdKZ
         smKWjXXOys0Vt+In1nWTlhAjFPCIWtDoDzrQ3ieCHFIP4nvUiFT/By1z1q2xYDF3ZdpL
         wZwl1N6rkjckZwaYLbi1iP3E0RMQtEY/wjVBpYFqIUzMkte7WgJEnanv6N6tDPiBNm1M
         s5kPk3RVbjBl8CeIXXEGEQhoRiQ5D5HOC4SI2Nt9R3FghdBCpNy2cEel0bU8Y4AT33I2
         V7NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705005269; x=1705610069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZhucuI11iLm9jZSo5DyrLuQREbxS6U88O/YNonTCxz8=;
        b=o4zbyYIcYGcHYyr0cafMSAlZ1hkCzpMz/NKRBLzmNdhbcZ4cStsPcE8tUrtj2zPi8M
         MJ6vwVgIrAcL7Q4AVd/jHdQ/PVSWevduvjE/Q9U/3a5Jxy/CCPruzNW1ZYeAXGhgfnGD
         wg6NEoo1eID4Ht4bqsr4sIksY7aggyr3FIGplKPLj931HgjUufqOPBj6O2IPzR8VSBEx
         hgqJWAI99qg8pPwfZNjg5dwZ7SUnvCsiQk4mG/uIJqh9Qs7/+LheDgAE7NxhRdSNbjBH
         9fWPR9wwpK3R2BjJLOsnCnfK5yssMJwC9f6JaXKSfNJ+y5/zoHPoylymctksovvzihgS
         KtCA==
X-Gm-Message-State: AOJu0Yz6lG4Qx7LhSFMaPzk8YYxmRIS7qSu5xJc5Zlw1jG1gevYTHKrB
	Eq+o6XB0yYmEjj/6S4di0selJ0LjE/VfsNIhOeApJAIV8s1z
X-Google-Smtp-Source: AGHT+IEwsvtKygl+nvSOgn3WrpQlaoPEPZDIYAeAvmwuubPmfNOdEKX4uyCZcs5X4QVXtXNLJ5Llz2AVykCfzYGX6ws=
X-Received: by 2002:a05:600c:1d1f:b0:40e:61cf:af91 with SMTP id
 l31-20020a05600c1d1f00b0040e61cfaf91mr127026wms.7.1705005268801; Thu, 11 Jan
 2024 12:34:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109-update-llvm-links-v1-0-eb09b59db071@kernel.org> <202401101645.ED161519BA@keescook>
In-Reply-To: <202401101645.ED161519BA@keescook>
From: Fangrui Song <maskray@google.com>
Date: Thu, 11 Jan 2024 12:34:17 -0800
Message-ID: <CAFP8O3+947djoRjnVPuPhHUHbHv_9CugufuXQ+c=N03yLsaEcA@mail.gmail.com>
Subject: Re: [PATCH 0/3] Update LLVM Phabricator and Bugzilla links
To: Nathan Chancellor <nathan@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, akpm@linux-foundation.org, llvm@lists.linux.dev, 
	patches@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-trace-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-efi@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
	linux-arch@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	bridge@lists.linux.dev, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, mykolal@fb.com, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 4:46=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Tue, Jan 09, 2024 at 03:16:28PM -0700, Nathan Chancellor wrote:
> > This series updates all instances of LLVM Phabricator and Bugzilla link=
s
> > to point to GitHub commits directly and LLVM's Bugzilla to GitHub issue
> > shortlinks respectively.
> >
> > I split up the Phabricator patch into BPF selftests and the rest of the
> > kernel in case the BPF folks want to take it separately from the rest o=
f
> > the series, there are obviously no dependency issues in that case. The
> > Bugzilla change was mechanical enough and should have no conflicts.
> >
> > I am aiming this at Andrew and CC'ing other lists, in case maintainers
> > want to chime in, but I think this is pretty uncontroversial (famous
> > last words...).
> >
> > ---
> > Nathan Chancellor (3):
> >       selftests/bpf: Update LLVM Phabricator links
> >       arch and include: Update LLVM Phabricator links
> >       treewide: Update LLVM Bugzilla links
> >
> >  arch/arm64/Kconfig                                 |  4 +--
> >  arch/powerpc/Makefile                              |  4 +--
> >  arch/powerpc/kvm/book3s_hv_nested.c                |  2 +-
> >  arch/riscv/Kconfig                                 |  2 +-
> >  arch/riscv/include/asm/ftrace.h                    |  2 +-
> >  arch/s390/include/asm/ftrace.h                     |  2 +-
> >  arch/x86/power/Makefile                            |  2 +-
> >  crypto/blake2b_generic.c                           |  2 +-
> >  drivers/firmware/efi/libstub/Makefile              |  2 +-
> >  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c           |  2 +-
> >  drivers/media/test-drivers/vicodec/codec-fwht.c    |  2 +-
> >  drivers/regulator/Kconfig                          |  2 +-
> >  include/asm-generic/vmlinux.lds.h                  |  2 +-
> >  include/linux/compiler-clang.h                     |  2 +-
> >  lib/Kconfig.kasan                                  |  2 +-
> >  lib/raid6/Makefile                                 |  2 +-
> >  lib/stackinit_kunit.c                              |  2 +-
> >  mm/slab_common.c                                   |  2 +-
> >  net/bridge/br_multicast.c                          |  2 +-
> >  security/Kconfig                                   |  2 +-
> >  tools/testing/selftests/bpf/README.rst             | 32 +++++++++++---=
--------
> >  tools/testing/selftests/bpf/prog_tests/xdpwall.c   |  2 +-
> >  .../selftests/bpf/progs/test_core_reloc_type_id.c  |  2 +-
> >  23 files changed, 40 insertions(+), 40 deletions(-)
> > ---
> > base-commit: 0dd3ee31125508cd67f7e7172247f05b7fd1753a
> > change-id: 20240109-update-llvm-links-d03f9d649e1e
> >
> > Best regards,
> > --
> > Nathan Chancellor <nathan@kernel.org>
> >
>
> Excellent! Thanks for doing this. I spot checked a handful I was
> familiar with and everything looks good to me.
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> --
> Kees Cook
>

These reviews.llvm.org links would definitely be kept like
https://lists.llvm.org/pipermail/llvm-dev/ or cfe-dev links
(discussions have been migrated to Discourse).
However, I agree that the github repo link looks more official. I have
clicked a few links and they look good.

Since I maintain reviews.llvm.org and created the static archive [1],

Acked-by: Fangrui Song <maskray@google.com>

[1]: https://discourse.llvm.org/t/llvm-phabricator-turndown/76137

--=20
=E5=AE=8B=E6=96=B9=E7=9D=BF


Return-Path: <linux-kernel+bounces-71158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0816185A175
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B2A71C21B78
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EC328DDC;
	Mon, 19 Feb 2024 10:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HvqTtu1G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BF228DBD
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 10:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708340238; cv=none; b=A/qCDZ72TX45iINhEhcQBpQZlKmLSnzeUcsrvPJhmC1H/9aiXzQiziCvLWtvcLpJcTINhSDLs+2r08G1e6+e5w4C/X1LSjM6GKW7NRYvEN4szjZnimCry/lEn3f7O7NXqZMLcOzV0h89EVQz5IiRvwkKIA79WekPInC553Oyt5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708340238; c=relaxed/simple;
	bh=9dOeyiDJsSefv4EBMEfGuKU7J4MB2+An6FzWYy2il5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uGyYjhMZ3ilI4J6xGz93r4SkSG+l9jwgt/2vZEdzHfm2Y8c03lesVjJ5kN8q8danw+K5hJxdMXP22RCpZawGsiIrgNlFkKYzUoeFTMrL1WcltQzrPILOitxNOe8rHmSD3cxfWfKIp0+npCIyBlxw7D+1pzlCosHBET/lTGGsq/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HvqTtu1G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6541C43394
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 10:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708340237;
	bh=9dOeyiDJsSefv4EBMEfGuKU7J4MB2+An6FzWYy2il5o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HvqTtu1GDkne6c7hAAj4kowEJY0j5GUBUUZnIYkpw+D6Br7atvu5XQtpHhF80dNSD
	 5U8YYjjPENNs/6r6OKEWvmq4AU9+iclJ/FW//j+GXhl09mtA3xN66fb9vO1k/zmT4h
	 Ce+tnRbA1oMFTmv/2kcKxBrOEgDq+vmL3PcMFLXGUKOlM0V4c/szqTinzPZw9A60Ep
	 s++XUKH67LEna8+8jZghIMjHvfjrUzET9gecJr+yyElUqniFx4IkbruclWl/gFictk
	 62TyS/iy1oM0uzy+9SDkLEBfmjxo66z1nMsLsNGjjoOAHI2DRTZeADK2l5Wzv7EGls
	 wRymHK5x6lQfQ==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-512b84bdaf1so621992e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 02:57:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWSaDrngAgRLU07oLVsCsaPBTmlO5z5TSi9neX491QIFAwsY84ED+u4+6rxQa/fF+fM66hd+/mGu++pJ5WdxV41hY3h5d8s9aSP/PrF
X-Gm-Message-State: AOJu0YxHrTvNs4QTAEuIpnBykPRyN5bLWuZ2weV0x9XPNfy2L3QsPXKZ
	b1sp/7xwDCeDiayCBghYoV01p7u4Q7AEjL60eyeMP7KupdBpIoyzCy6XUkrfXGRJx2p/FGju5QT
	9f/cG1zicmjFSvhx/5JWmG0musVA=
X-Google-Smtp-Source: AGHT+IHmfgSZqvHpLB9jfTiYhxvcFbTevouQkei+SQG31nDOKxX4/f0K3SugmVJlMZ2zwMVxayLYcj4wPTVfUn25ENw=
X-Received: by 2002:a05:6512:239c:b0:512:ae18:7492 with SMTP id
 c28-20020a056512239c00b00512ae187492mr3296031lfv.11.1708340236084; Mon, 19
 Feb 2024 02:57:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206074552.541154-1-maskray@google.com> <CAMuHMdVOoxVFohcwwoQtY0KgZEvbjgJJ6mib8Fabo97P0krEqw@mail.gmail.com>
 <CAMj1kXGaF5bobHTr1pTg+-=s4Ft7+5SSbX72-NxsR_W_Yuxb8Q@mail.gmail.com>
In-Reply-To: <CAMj1kXGaF5bobHTr1pTg+-=s4Ft7+5SSbX72-NxsR_W_Yuxb8Q@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 19 Feb 2024 11:57:04 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGw+r7yEEBA8gYBcdrqkiP=VYOSzz9YLnNavJn2snmFwA@mail.gmail.com>
Message-ID: <CAMj1kXGw+r7yEEBA8gYBcdrqkiP=VYOSzz9YLnNavJn2snmFwA@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: jump_label: use constraints "Si" instead of "i"
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Fangrui Song <maskray@google.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	Jisheng Zhang <jszhang@kernel.org>, Dave Martin <Dave.Martin@arm.com>, 
	Peter Smith <peter.smith@arm.com>, llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 19 Feb 2024 at 11:56, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Mon, 19 Feb 2024 at 11:03, Geert Uytterhoeven <geert@linux-m68k.org> w=
rote:
> >
> > Hi Fangrui,
> >
> > On Tue, Feb 6, 2024 at 8:46=E2=80=AFAM Fangrui Song <maskray@google.com=
> wrote:
> > > The generic constraint "i" seems to be copied from x86 or arm (and wi=
th
> > > a redundant generic operand modifier "c"). It works with -fno-PIE but
> > > not with -fPIE/-fPIC in GCC's aarch64 port.
> >
> > Thanks for your patch, which is now commit f9daab0ad01cf9d1 ("arm64:
> > jump_label: use constraints "Si" instead of "i"") in v6.8-rc5.
> >
> > > The machine constraint "S", which denotes a symbol or label reference
> > > with a constant offset, supports PIC and has been available in GCC si=
nce
> > > 2012 and in Clang since 7.0. However, Clang before 19 does not suppor=
t
> > > "S" on a symbol with a constant offset [1] (e.g.
> > > `static_key_false(&nf_hooks_needed[pf][hook])` in
> > > include/linux/netfilter.h), so we use "i" as a fallback.
> >
> > https://gcc.gnu.org/releases.html says gcc-5 was released in 2015,
> > i.e. after 2012 ...
> >
> > > Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> > > Signed-off-by: Fangrui Song <maskray@google.com>
> > > Link: https://github.com/llvm/llvm-project/pull/80255 [1]
> > >
> > > ---
> > > Changes from
> > > arm64: jump_label: use constraint "S" instead of "i" (https://lore.ke=
rnel.org/all/20240131065322.1126831-1-maskray@google.com/)
> > >
> > > * Use "Si" as Ard suggested to support Clang<19
> > > * Make branch a separate operand
> > >
> > > Changes from v1:
> > >
> > > * Use asmSymbolicName for readability
> >
> > But it still fails on gcc-5:
> >
> >     arch/arm64/include/asm/jump_label.h:25:2: error: invalid 'asm':
> > invalid operand
> >       asm goto(
> >       ^
> >
> > http://kisskb.ellerman.id.au/kisskb/buildresult/15129281/
> >
>
> How odd. godbolt.org has 5.4 and it seems perfectly happy with it.
>
> https://godbolt.org/z/szzG3s59K

Wrong link

https://godbolt.org/z/GTnf3vPaT


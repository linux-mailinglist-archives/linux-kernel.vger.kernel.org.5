Return-Path: <linux-kernel+bounces-717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 025F6814507
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACC1C1F215C8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 10:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1404A18C11;
	Fri, 15 Dec 2023 10:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vrull.eu header.i=@vrull.eu header.b="MMsYH6Ei"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D8618B0E
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 10:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vrull.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vrull.eu
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-28694702c18so303127a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 02:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrull.eu; s=google; t=1702634533; x=1703239333; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dXyJbk2cqyX20aohZjN0F4Xli2SubkR+gZdBJV7wcH8=;
        b=MMsYH6EiyoMgpcinzucrjVT1TPrzYnfUMqhw/En0LGoqR0vcR4lFoBfLvPVaMH8Jwo
         +kpqKqOnZ6fLQBuXRKNuGXaoNv8k+2cVxn2a1nxfj5NmueGiroYsksHvamwxMRsnLIWv
         kcEfla3qqdDEZsvjiTEGySogR38B+w+CaCpHc7KRI3844DWP/oBJsoEJB81XiGscnc8q
         VF7rTDQWbwvCeXlEp/ZRvY60NRVFFh+Er89QDhrvONUXLlfPuhqYA1NnQAeb/KtMeY2o
         nlKrd2OplKZf3i8NlAT2cm1bOR2fhmBid94XVp+JtYHeEXyX5muA+/d3KBUxCu+PoRdk
         34/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702634533; x=1703239333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dXyJbk2cqyX20aohZjN0F4Xli2SubkR+gZdBJV7wcH8=;
        b=EjcqwhcPSfdH/TXpvd7Ap3yJbjK5/t9N9RCnCNhugPIk5NoTRJw3jD15m3KysX9Nor
         65MFr1WVje+8Fy8GLR1Q5+lN8kjiBKcHQjCTbHHjpJUz2/GFZW1jQoPzF0S+MmnAP2+f
         vghSOAFrXg+BsQKFu7QZNDXnak/ELOnppQz7EEnmTkTkK++vKGtb10Jj2kWn5GnREge+
         37hTS7jUSF0KHTACaw+AVatbvn89xx+Zb7F91k4ZXmwDmvWXpARsrWsUGZwO+rytGuIm
         hp1S78BT1YXZRpjn7FSTvLWvYPVVT8MtQv3tu2VHstrm03BeA+7TXribelsOkhCbW6nx
         IzbA==
X-Gm-Message-State: AOJu0Ywx1BhaQlxkeRY/T0RelkVfmhP/AUd9cU1cf7Xohj8boIpDPVBP
	B2UhmtLB+JV+Er8/5L9Af2bDkxEOuMttIwSqxEVNGg==
X-Google-Smtp-Source: AGHT+IHYA1xHp4lkOd1cCBALEFt0tY88icNCqMBZdHPqehqnfxzKl3xfuFkUXsO7UTy0nxhjaaNQsn4lPh3Pj50GGXU=
X-Received: by 2002:a17:90b:2792:b0:285:8d5c:9114 with SMTP id
 pw18-20020a17090b279200b002858d5c9114mr7926991pjb.19.1702634532837; Fri, 15
 Dec 2023 02:02:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231123185821.2272504-1-christoph.muellner@vrull.eu> <20231124-3934c1b3c4b6dc3f076b0f9a@orel>
In-Reply-To: <20231124-3934c1b3c4b6dc3f076b0f9a@orel>
From: =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>
Date: Fri, 15 Dec 2023 11:02:01 +0100
Message-ID: <CAEg0e7hfM9Pb+CoUXQ_Hw_tkWv-XG9VwS-g74-rcva3j_wODrA@mail.gmail.com>
Subject: Re: [PATCH 0/5] tools: selftests: riscv: Fix compiler warnings
To: Andrew Jones <ajones@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Shuah Khan <shuah@kernel.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
	Evan Green <evan@rivosinc.com>, Xiao Wang <xiao.w.wang@intel.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Andy Chiu <andy.chiu@sifive.com>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Charlie Jenkins <charlie@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ping.
It would be great to have these compiler warnings fixed before the release.

On Fri, Nov 24, 2023 at 10:40=E2=80=AFAM Andrew Jones <ajones@ventanamicro.=
com> wrote:
>
> On Thu, Nov 23, 2023 at 07:58:16PM +0100, Christoph Muellner wrote:
> > From: Christoph M=C3=BCllner <christoph.muellner@vrull.eu>
> >
> > When building the RISC-V selftests with a riscv32 compiler I ran into
> > a couple of compiler warnings. While riscv32 support for these tests is
> > questionable, the fixes are so trivial that it is probably best to simp=
ly
> > apply them.
> >
> > Note that the missing-include patch and some format string warnings
> > are also relevant for riscv64.
>
> I also posted [1] a couple days ago for the format warnings, but, as this
> series also includes rv32 fixes, then we can drop [1] in favor of this.
>
> [1] https://lore.kernel.org/all/20231122171821.130854-2-ajones@ventanamic=
ro.com/
>
> For the series,
>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
>
> Thanks,
> drew


Return-Path: <linux-kernel+bounces-126912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B85489445F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 19:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBADB1C2177F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 17:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC8F50255;
	Mon,  1 Apr 2024 17:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="edH4WDgd"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE60B4F88B
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 17:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711992856; cv=none; b=QxpemLRiiBeodOndqST9DUFAZxuRI/i4cF34gU2jnQ5x9W5qAvTAf0fRaQNFP31cQrNBkh/Cx7xlFKbL0LPp+v5s7hFCOYi+PpHKWHi7hGad/sWVLgATOlbP8vdgcT/Pi4bdTpJx+RT+w6N+fNbaPh4TWiBgadRlpW8205E22Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711992856; c=relaxed/simple;
	bh=n2s5tJq14PiUi3t6xvxViPgVvhmPK29s9bFhWMqxL60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GDrxvxO14V9JGJRA2vWEKF2eONdZSCdZK396rToAYQ0hmxeJdvyTixHkHrr2mTQhodQW7DcUUrk2zT4RqOnjYj8ngzWJzHUjwDTLcDy3Ciz9H0l66msNnzBQTxLmU0YHa758bxLUMflJ41a3Sfo5zjAU/5QnpTyimUfRhGXO2Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=edH4WDgd; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-615053a5252so4175937b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 10:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1711992854; x=1712597654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q4MAUcmgMKuhD5Gbh9i7N0D2vbnfTkjFUipl6Ki2fa4=;
        b=edH4WDgdscTllgyj04pndAGnNr7LyzQ/F0wYBuHEij9PNeKeAQc2jLBjc3GIzuV13I
         GjkW/FxXFq6HvFeWJMtO9o4YJaYJQe300GzuB8UcyrwirHtMS/udXVpcykwXEyUXMBZR
         6PCyUvLNl5ird/0jm4fdFtDbj9RHButZ7ieZrWBVg+PWNwxjHTyH+gmjGO2LvUQnvpBm
         FxBFB8hOOfXSsIdmaPIo4taz8dp99Kgas0KF9GKXPGT8cePtF4/w49s7aBSog5JjmSkU
         KlRV7xyzvBT4Jvbqr8l/uaJZIeOtlHNPU62SLw/dJCgSKjOmRJJUNg4HjHzdubBuEwXa
         IWEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711992854; x=1712597654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q4MAUcmgMKuhD5Gbh9i7N0D2vbnfTkjFUipl6Ki2fa4=;
        b=EFjAuZyNJEMeNZ5uAYlEKZLk0Co7izWLnOT8FWlIefZq0tZRdJRF2Bjeb6s8bnvNpw
         Mr1qDno/Pk1jBQOSgVZtn7lR5N8tNUegy0GdezC/YaKszdx/umRLwSI1imKJhadrpKWv
         jU+lN/l8Mb0x8eQmMjtEC4uDp/n2/EJjd07FIvi8R5rptD1Kx3ziS8kqxSJLSvpnF4Fj
         +oZ7k29SYnAB3clfj1XxiY+7jy8v0+Zr4aXUHhiQyDziATvQhPYwymF63oqPbsEp+OWj
         OCjA2H3Oqdaz2qkczKO7CFsY2SED8aLS0XTiZDrZ3HB67cBbt93Xm9wi178vGeFVERS6
         nJbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCpRLtMXVir18WbBTH+ZAH6pxUAyaPCR0+0aHm+mRztQ53UkRd5ylDWoMtljQ9yWo7WQVHFIOqD4+ptuVMGQjFNACYyFV74EcCtfHO
X-Gm-Message-State: AOJu0Yy74paoV5+xwAXyKk4DKTtNw1JA7jsNS1w7jsjnn1E+vl6kKX3v
	AvM9qC07ckXIs8JpooSWWuXq6Jmf/l3rXZU36sgifU5SM9efFfqU3mQ5o9ZKhpVvYa6eWcOgCFB
	kMTHB7EPlRxjO095WAvvBEvaCxw0EgUTWbYRMCQ==
X-Google-Smtp-Source: AGHT+IGWLd+uB6H49i9ExUSpS3d/6MA4XGgkBBQBM3nTLsDV2PwbysZLh8i9VvQ3W9VGzIjrMeAWK2hXdQjjikUWmc4=
X-Received: by 2002:a81:4849:0:b0:615:19b1:5367 with SMTP id
 v70-20020a814849000000b0061519b15367mr22572ywa.6.1711992853801; Mon, 01 Apr
 2024 10:34:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329044459.3990638-1-debug@rivosinc.com> <20240329044459.3990638-28-debug@rivosinc.com>
 <4b38393a-f69d-4a77-a896-b6cd42c7edcf@collabora.com> <CAKC1njQ_RU=uHhrna=MFVdjAMjjQNqZWnkjPoJvO7CxtPMeNuQ@mail.gmail.com>
 <ef72ae20-6b68-496a-a819-8818ade0d433@collabora.com>
In-Reply-To: <ef72ae20-6b68-496a-a819-8818ade0d433@collabora.com>
From: Deepak Gupta <debug@rivosinc.com>
Date: Mon, 1 Apr 2024 10:34:06 -0700
Message-ID: <CAKC1njQj7GfkdE1HJD54utkoPqJXyqMeoXOxa6ActqZ-fSDuKQ@mail.gmail.com>
Subject: Re: [PATCH v2 27/27] kselftest/riscv: kselftest for user mode cfi
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: paul.walmsley@sifive.com, rick.p.edgecombe@intel.com, broonie@kernel.org, 
	Szabolcs.Nagy@arm.com, kito.cheng@sifive.com, keescook@chromium.org, 
	ajones@ventanamicro.com, conor.dooley@microchip.com, cleger@rivosinc.com, 
	atishp@atishpatra.org, alex@ghiti.fr, bjorn@rivosinc.com, 
	alexghiti@rivosinc.com, samuel.holland@sifive.com, conor@kernel.org, 
	linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mm@kvack.org, 
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, corbet@lwn.net, 
	tech-j-ext@lists.risc-v.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, oleg@redhat.com, 
	akpm@linux-foundation.org, arnd@arndb.de, ebiederm@xmission.com, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, lstoakes@gmail.com, shuah@kernel.org, 
	brauner@kernel.org, andy.chiu@sifive.com, jerry.shih@sifive.com, 
	hankuan.chen@sifive.com, greentime.hu@sifive.com, evan@rivosinc.com, 
	xiao.w.wang@intel.com, charlie@rivosinc.com, apatel@ventanamicro.com, 
	mchitale@ventanamicro.com, dbarboza@ventanamicro.com, sameo@rivosinc.com, 
	shikemeng@huaweicloud.com, willy@infradead.org, vincent.chen@sifive.com, 
	guoren@kernel.org, samitolvanen@google.com, songshuaishuai@tinylab.org, 
	gerg@kernel.org, heiko@sntech.de, bhe@redhat.com, 
	jeeheng.sia@starfivetech.com, cyy@cyyself.name, maskray@google.com, 
	ancientmodern4@gmail.com, mathis.salmen@matsal.de, cuiyunhui@bytedance.com, 
	bgray@linux.ibm.com, mpe@ellerman.id.au, baruch@tkos.co.il, alx@kernel.org, 
	david@redhat.com, catalin.marinas@arm.com, revest@chromium.org, 
	josh@joshtriplett.org, shr@devkernel.io, deller@gmx.de, omosnace@redhat.com, 
	ojeda@kernel.org, jhubbard@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 1, 2024 at 2:48=E2=80=AFAM Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>
> >>> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> >>> ---
> >>>  tools/testing/selftests/riscv/Makefile        |   2 +-
> >>>  tools/testing/selftests/riscv/cfi/Makefile    |  10 +
> >>>  .../testing/selftests/riscv/cfi/cfi_rv_test.h |  85 ++++
> >>>  .../selftests/riscv/cfi/riscv_cfi_test.c      |  91 +++++
> >>>  .../testing/selftests/riscv/cfi/shadowstack.c | 376 ++++++++++++++++=
++
> >>>  .../testing/selftests/riscv/cfi/shadowstack.h |  39 ++
> >> Please add generated binaries in the .gitignore files.
> >
> > hmm...
> > I don't see binary as part of the patch. Which file are you referring
> > to here being binary?
> shadowstack would be generated by the build. Create a .gitignore file and
> add it there. For example, look at
> tools/testing/selftests/riscv/vector/.gitignore to understand.

It's `shadowstack.c` (a C source file) and not a binary file.


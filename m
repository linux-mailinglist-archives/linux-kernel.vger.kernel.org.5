Return-Path: <linux-kernel+bounces-112475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 872BF887A4B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 21:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DBDFB21446
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 20:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C914C1DFCE;
	Sat, 23 Mar 2024 20:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="d0QTy3pu"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411D6211C
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 20:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711226262; cv=none; b=CtCBfEK0Dy6hDhgKq9DCnIfam6AnFWxLc2+zR2d0VOVCW4XUV9fZCJ/zdufoH/z7XXleLf21kZ1aQcVDxbuNDCdaP3+JXDEycwnRgXvmkStuSpPT+2wPrfzbWnr2sXLwuA9d006L57aNWqhH0esOMlye5mqa8yyBfe/DuszVEFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711226262; c=relaxed/simple;
	bh=F/YPXLz2Mwerh5c3sVMFT48r3GG2KwGnkstMSeaVehY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o0TGtqs+9X9ZxbhhueVgfBtklWX7hpycRkHLLOJvcw1hWTQJn/O84M7k1XPl/5xwk6Xwjg7PDFTrJjRcGmBWqHLIXfpBR1ES2Jqs1pjRoz31bXOk3tQyH65zT3jueVIsEDEx7h/KN4KWTWN/muCY7DBrTf3JonzPS9/ZUJ6y6jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=d0QTy3pu; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-609ed7ca444so33007117b3.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 13:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1711226260; x=1711831060; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=24wJWvfMNNR4rY9ZJ72kq+zMk5fkM7haArePsqOnmfc=;
        b=d0QTy3pug2+hrioDXiuX4WEzadBLhhwfIxGhfWAd1QzalwL77nBJMa7cdsY5KDsDNC
         g3IvRgrBa02ajKtrtAX84rVgeCM1ykzF5Mj7/tHqQZy7cHjXQv0W1ZIsy3+68iR8ma3s
         /GRpE8/ImxQ93cdus+KQvvBgL3y+mo7QvMpc3hEHOylChtOUtYBQN0RapxF/+n9O/xfI
         oVVNIUGyAOBvcyirlkTqYPYtE5DiQ+OPALsXgcTgDqbyHARMPVcxiQXBx1eGazPxcdAp
         9NrgwDf1Lq4ITB24Sr/9jJIv2tP3cHt/rrYOgXt8+58Hr8CPEfLtVvgdHpE2i1ms/0oF
         rsDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711226260; x=1711831060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=24wJWvfMNNR4rY9ZJ72kq+zMk5fkM7haArePsqOnmfc=;
        b=s3oe3nrzMxGI5l18stMu9fk8h8NQcpGw8b/zb7hbbJJ+yy6kwmvLqM94nrNlsRpPK4
         pKCZ55A2O5jffFL8fDVxhJi+161RLPfInOXLP/55xlCRQgyGUo+NapI7nW4z2GWvxKz+
         Nl7kX0K2PHvUN1uA4v3PlXLQweaL+qeyaG4SfGLnOMTgmWN6Ssiz+ZmIDIfPzDobpauf
         krRfYzu9DCLlR3eOWak90fGy9t7L5XxH83RxkX40ZVrbhhVA+H/2ru/Gm2FUIkPeNGox
         VhNOwpNj+u1L/K0y2Di2x6q9woPtQU76V1vuru0G4+V6lRb619DaCwlyPe9PqAIiwDrT
         hwuA==
X-Forwarded-Encrypted: i=1; AJvYcCUNZbxSn0UhcCnFC1EvlAo9Pn2gNNt/RxFwem3t0FFeS0MUQNQCV1tToo4jTWUz5MLhVrOAQ+QWRHEgJ/j7uP5mU+wNzej12+YTRV9c
X-Gm-Message-State: AOJu0YwdwdoXvGhHHrmYNgtvpqsNMf41k/NJ2mHNqX86DnpR/hCv5zK1
	z08bcWLhaWP+FnqOnCmkBonMZfYgiL1AhHuv0q8RrNVI4EqILoyPe622//p+jtkPDmgmPOVcj/C
	B72DzIIujcZKMXKuhKhX3Jy/aEF0rbUWIXH0/wA==
X-Google-Smtp-Source: AGHT+IGKymQ6ArV3LTX39wPDQmJ+EcNQqIyE71qeKh8yulGXmkXtiwJzoMcBHLUtnhwBvRoabFlDgM5kHlMz+0M6rCw=
X-Received: by 2002:a0d:d981:0:b0:609:6eb0:4714 with SMTP id
 b123-20020a0dd981000000b006096eb04714mr2781546ywe.34.1711226259384; Sat, 23
 Mar 2024 13:37:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319215915.832127-1-samuel.holland@sifive.com>
 <20240319215915.832127-6-samuel.holland@sifive.com> <CAKC1njSg9-hJo6hibcM9a-=FUmMWyR39QUYqQ1uwiWhpBZQb9A@mail.gmail.com>
 <40ab1ce5-8700-4a63-b182-1e864f6c9225@sifive.com> <CAKC1njQYZHbQJ71mapeG1DEw=A+aGx77xsuQGecsNFpoJ=tzGQ@mail.gmail.com>
 <d9452ab4-a783-4bcf-ac25-40baa4f31fac@sifive.com> <CAKC1njRBbzM+gWowg1LOjq5GzVn4q+vJP9JUswVYfWmEw+yHSg@mail.gmail.com>
 <20240323-28943722feb57a41fb0ff488@orel>
In-Reply-To: <20240323-28943722feb57a41fb0ff488@orel>
From: Deepak Gupta <debug@rivosinc.com>
Date: Sat, 23 Mar 2024 13:37:28 -0700
Message-ID: <CAKC1njRqWYOsF9bQvWX99DhP8Ji_wDUc8J8N41=N6J_tncM3=A@mail.gmail.com>
Subject: Re: [RISC-V] [tech-j-ext] [RFC PATCH 5/9] riscv: Split per-CPU and
 per-thread envcfg bits
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Samuel Holland <samuel.holland@sifive.com>, Conor Dooley <conor@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, 
	linux-kernel@vger.kernel.org, tech-j-ext@lists.risc-v.org, 
	kasan-dev@googlegroups.com, Evgenii Stepanov <eugenis@google.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Guo Ren <guoren@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Paul Walmsley <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 23, 2024 at 2:35=E2=80=AFAM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> On Fri, Mar 22, 2024 at 10:13:48AM -0700, Deepak Gupta wrote:

> > > > Yeah I lean towards using alternatives directly.
> > >
> > > One thing to note here: we can't use alternatives directly if the beh=
avior needs
> > > to be different on different harts (i.e. a subset of harts implement =
the envcfg
> > > CSR). I think we need some policy about which ISA extensions are allo=
wed to be
> > > asymmetric across harts, or else we add too much complexity.
> >
> > As I've responded on the same thread . We are adding too much
> > complexity by assuming
> > that heterogeneous ISA exists (which it doesn't today). And even if it
> > exists, it wouldn't work.
> > Nobody wants to spend a lot of time figuring out which harts have
> > which ISA and which
> > packages are compiled with which ISA. Most of the end users do `sudo
> > apt get install blah blah`
> > And then expect it to just work.
>
> That will still work if the applications and libraries installed are
> heterogeneous-platform aware, i.e. they do the figuring out which harts
> have which extensions themselves. Applications/libraries should already
> be probing for ISA extensions before using them. It's not a huge leap to
> also check which harts support those extensions and then ensure affinity
> is set appropriately.

How ?
It's a single image of a library that will be loaded in multiple address sp=
aces.
You expect all code pages to do COW for multiple address spaces or
expect to have
per task variables to choose different code paths in the library based
on address space its
running in ?
On top of that, the library/application developer doesn't know how the
end user is going to use them.
End users (sysadmin, etc)  just might use taskset to put affinity on
tasks without being aware.
I just don't see the motivation in an application developer/library
developer to do something
like this. No application/library developer has time for this. Putting
a lot of burden on application
developers is mostly a nuisance considering they don't have to think
about these nuisance
when they expect the same code to be deployed on non-riscv architectures.

One good example of putting unnecessary burden on app/library
developer is Intel SGX
This is exactly the reason Intel SGX failed. Application developers
don't have time to develop
confidential compute version of the application for a specific CPU
while on other CPUs carry
a different version of application. But at the same time virtual
machine confidential compute is
better approach where all complicated decision making is delegated to
operating system
developer and application/library developers are empowered to only
think about their stuff.

>
> > It doesn't work for other
> > architectures and even when someone
> > tried, they had to disable certain ISA features to make sure that all
> > cores have the same ISA feature
> > (search AVX12 Intel Alder Lake Disable).
>
> The RISC-V software ecosystem is still being developed. We have an
> opportunity to drop assumptions made by other architectures.

It doesn't mean that it should try to make the same mistakes which
others have done.

If there is a motivation and use case from end user perspective, please pro=
vide.
Otherwise no point doing something which is just a science thought
exercise and no concrete use case.

Please note that these arguments are against Heterogeneous ISA on cores.
From power and efficiency perspective cores can still be heterogeneous.

>
>
> As I said in a different reply, it's reasonable for Linux to not add the
> complexity until a use case comes along that Linux would like to support,
> but I think it would be premature for Linux to put a stake in the sand.
>
> So, how about we add code that confirms Zicboz is on all harts. If any
> hart does not have it, then we complain loudly and disable it on all
> the other harts. If it was just a hardware description bug, then it'll
> get fixed. If there's actually a platform which doesn't have Zicboz
> on all harts, then, when the issue is reported, we can decide to not
> support it, support it with defconfig, or support it under a Kconfig
> guard which must be enabled by the user.
>
> Thanks,
> drew


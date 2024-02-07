Return-Path: <linux-kernel+bounces-56523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9E284CB35
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00E4E1F215DB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A311576C8B;
	Wed,  7 Feb 2024 13:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Lh1Cv6rM"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4843876C8A
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 13:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707311456; cv=none; b=gQu488h+BzIQbgg/i65ufOkmXwxsCDFTQpBTrUkQr+uhkufHCGUHKNTnfHauIbSr31EUy3D/woqlCpHNVxxSPpG/GEQWfnMQjEQcbrDPX+IW6Q3pveH8l5k2A3KlPj4lefhbVK+YKPoMSsFnEB+Wo5zAUYPK4LvQeEQHildVd7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707311456; c=relaxed/simple;
	bh=QeiQKTjUpaXlC5rTpAh57LecWBMIQwcK9WBuhzqF9Gc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E1F4Td8Il7sgoc48+HAcRIEX606bTF/Vwtw2XH7L3/SU43hKWvwPYDBK2xxMjlHLZUJToiKZxl9QbQfxsVWQxW32W7vSBZS4dAY6lPNLsG4uD/AjRSBjia/mnhffKTE3aeAhRVp4zQMeXwiVS9xqlJKuEpCnRqRKOPQaKJZ9ioM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Lh1Cv6rM; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-51124e08565so924928e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 05:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1707311452; x=1707916252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QeiQKTjUpaXlC5rTpAh57LecWBMIQwcK9WBuhzqF9Gc=;
        b=Lh1Cv6rMH7oADt8qkmoRXSJ6/fdGaTDDdQMuEER+HE6dWn5lz7zeuO3+0i/3jIgrQf
         016qOlOHcULn26X2CXLcLV6g3j+OBuKXFQ06e6dwFzmgNJ1JuFzUz36AaSUuXQMmWOhW
         GWPEFPgXZ+KOw/+GYswfZjCqqhoaYDAMHfFwSbaPEJ8ix3Y5hdxluNA/m2ToNd/oxTGZ
         WP/R0CuYC1CHO8we/XzuXMV225l00guXU3+iVVlbIJGoSpgGq4tQLDX1OCB6o9PgSSnO
         B8UG2XbYcCIm5BBKE31HExIwKNiTDf4+PApZCxI4wOxMLpDb84x8u4lQhL5z8rg7s3MQ
         SClw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707311452; x=1707916252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QeiQKTjUpaXlC5rTpAh57LecWBMIQwcK9WBuhzqF9Gc=;
        b=dqNQhxlTaCNxzOcNb7krWHmpQgugkiXvFtLD3Zo6x2uyj5kHWpXxfc84StXZmVpLv6
         VSpBR/8OtSqB6zpovdmyRXs3whmZW3apeUgNKqk+nONpwtshtc1RTY+YB0+zEZDj/XhI
         FkMfyxQauzqDi1cPGwKRJnI059r36orFnr3Xi8drUSa9vrxUxu/KYp6dTgdqCgQwt0e8
         7VUtd19/1x4j30SCRNmi+5z0Bnq6ccxdW/ovWvOKm4dtOzNJj3hP0Y3uqOsogn6ss5JM
         vTfhOYd1NTJzCgn5YX8YxSr+6tix82GaK7RUdmMvUVlh1sH8DFXe1TQKSRb+gyldX4ai
         M5OA==
X-Gm-Message-State: AOJu0YyeeMaxPKQ4Cz8QJo3zRvP3lH4UTves42HJV7fEBzb7L3p+8EbU
	Kgy3ekClIq89JK764SIaex97zhci6R8JtVT3fB+zM6/KNvjhgtsriYckyOHYLZq8hENwSXC+d42
	bvdey/mANkllgOGheP5rhMPsD9DxijCnMkoI7xZYARF9r0IC/6LY=
X-Google-Smtp-Source: AGHT+IEDiiJkE3kwGwtW/YKJfbR7qahBZMUX/dBC8fmDAROEYy79l0gPVz7ALeJMY4eBJ5z3ImHy8UPIS5Uk8HzPGLA=
X-Received: by 2002:ac2:4ac4:0:b0:511:551a:c330 with SMTP id
 m4-20020ac24ac4000000b00511551ac330mr4406484lfp.16.1707311452159; Wed, 07 Feb
 2024 05:10:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240127161753.114685-1-apatel@ventanamicro.com>
 <87h6ily53k.fsf@all.your.base.are.belong.to.us> <CAAhSdy2PPjS6++Edh8NkgiBmcovTUjS5oXE2eR5ZwPfAfVA0ng@mail.gmail.com>
 <874jekag3w.fsf@all.your.base.are.belong.to.us> <CAK9=C2XJYTfY4nXWtjK9OP1iXLDXBVF-=mN1SmJDmJ_dO5CohA@mail.gmail.com>
 <87plx8y5s3.fsf@all.your.base.are.belong.to.us> <87sf24mo1g.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <87sf24mo1g.fsf@all.your.base.are.belong.to.us>
From: Anup Patel <apatel@ventanamicro.com>
Date: Wed, 7 Feb 2024 18:40:40 +0530
Message-ID: <CAK9=C2VLf96D8cm86D26=hJMsqehUM5x_=Cjyy+7kVcAZ5KrUQ@mail.gmail.com>
Subject: Re: [PATCH v12 00/25] Linux RISC-V AIA Support
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Anup Patel <anup@brainfault.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Frank Rowand <frowand.list@gmail.com>, 
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	Saravana Kannan <saravanak@google.com>, Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org, 
	Atish Patra <atishp@atishpatra.org>, linux-riscv@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 6:25=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.=
org> wrote:
>
> Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> writes:
>
> >>> Hmm, seems like we're talking past each other, or at least I get the
> >>> feeling I can't get my opinions out right. I'll try to do a quick PoC=
,
> >>> to show you what I mean. That's probably easier than just talking abo=
ut
> >>> it. ...and maybe I'll come realizing I'm all wrong!
> >>
> >> I suggest to wait for my v13 and try something on top of that
> >> otherwise we might duplicate efforts.
> >
> > OK!
>
> I did some really rough code sketching, and I'm confident that you can
> get rid of all ids_enabled_bitmap, hwirqs_used_bitmap, and the
> corresponding functions/locks. I'd say one lock is enough, and the key
> is having the per-cpu imsic_local_priv.vectors change from struct
> imsic_vector * to struct imsic_vector **.
>
> Using smp_call_function_single() to IPI enable (and disable if you don't
> want to use the lazy timer disable mechanism) seems feasible as well!
>
> (Let me know if you don't have the spare cycles, and I can help out.)

If you can help upstream IOMMU driver then that would be awesome.

Regards,
Anup


Return-Path: <linux-kernel+bounces-143108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F048A344C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 19:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C98081F22779
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E5E14D2AA;
	Fri, 12 Apr 2024 17:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Xr7YNenY"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F3814B098
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 17:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712941496; cv=none; b=kSziFaTdi51NwjGf6yKyXSc6BLMmuoIhoLLhjc7br4Nzj8yKhHIsGjY63MlTEPJsMiRASgnq+qnjaF+64FfpfqAPs5m6eN7MiSR1bJJNF+aXKzWIFj9u9uW/zOQJC6fmjySM/ojMQIqeZa3BhyR8cil9Qg16KwLiA1lpnpv+Wdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712941496; c=relaxed/simple;
	bh=tYOCD7qA19/JAXwkJAfYs6ERNWjQ6TGuUnce7Ev3h1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tx1R1jYXfZ+LtwF9KSO2FukKJ6QhmtPYDYD/oUQgLQxvAcaiiBnihh1xWHON3fpneG2IZtFQn09I6vA9WjFvQClWnp6etHI4FFY75tK7raC0EhPNnfmbk3ZwvKt808uPx7rzmATqKzazIy2CFOZT+Fwu4tXklmGceI48EJHxWUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Xr7YNenY; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d717603aa5so13563101fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 10:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712941493; x=1713546293; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tYOCD7qA19/JAXwkJAfYs6ERNWjQ6TGuUnce7Ev3h1g=;
        b=Xr7YNenY6z2UXlDKpvatz9/y1VFS2A730bzjHAjR79X8VFwTti2DMi3xML+1KdltHW
         D481BNNJNaMn82LYh08nxknUD3HZhhUuTB9CScjtNbIkClnjmPgIriaj9+V78+LyYgo9
         ov/9zQvH0yMwqe4rD+uonDlmQnsQ8f0AThhngxcA2quv5Jw0E1edq7znJpigHEcn+Jef
         VN6+a0YxzHcO2vLQvfPrXD0M92LkZc1NOVs1a23n6R8YlIEoX8V4xFjeM9F136dSSW80
         Eub5ov14n4cpEpK6aXVPojI7nMz/6qidBx3qkqUrj0h9Q9QAuBa25sNfueiSaAlpuBC3
         iL6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712941493; x=1713546293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tYOCD7qA19/JAXwkJAfYs6ERNWjQ6TGuUnce7Ev3h1g=;
        b=TU89cb5VeNsSbkC/4HyNCsHLieiAwmw7g+zJR1/yAUcu5jVrwYs0KUU2Kn5TZWCrqH
         3B84dEbfV2zVpLLxbn7OuipG/MDgpO0XsxwQViHx6qA2Seo/YhO5RIlCzVm2oPHIIcSr
         XRwSb88C0tlX5McLmo/xCYs/Bs9d+lm4PXsG8C9S0xj0akzuW1NBkHjJgbNGyDjrWEcF
         ovVWNWv4xIrAqrH1R8tlfrqAkN3IrMsJ+ryJRoDCBGf99KI+TvRRedQSzZwPO2wXuEpx
         ui0tqHZPH+w0n53TfML32TvG6Bs32P4BlAaEEIURycqKqFrmZc5ruIPobA/JXMaI3Peg
         IeBg==
X-Forwarded-Encrypted: i=1; AJvYcCVLnTiDEAKKRA9VvJB8LKtPo66sb2JzQlgtF448EIosz61ni2iAeGwf2LLg0omup6jyakm5DgHlC4WqLNnkkumNAZQl8ebYgvdb9Hzf
X-Gm-Message-State: AOJu0YwacwgWYYsnow71B9qymySk6AyetCuKFym/1YQppqQFbsmuj0V/
	KgNOaqR02j+OdlmbKcAM4Mi6CqyoRDk6SrsmtGFbN4PkZ965yjR5Tang4t5qwsHU/OCu/ePN3nU
	aCNwhwB9+8VnnkHBEAiE0lBg+J6/18syaf/tBpQ==
X-Google-Smtp-Source: AGHT+IEVhmpSPd185VDGAisXX5CbjlYY2cqdA2jBznkqi4gMJsx6SWiduJXurWu4KxUaLTi372RCaB93r5g8yMqVxEs=
X-Received: by 2002:a2e:95cc:0:b0:2da:7af:e6a0 with SMTP id
 y12-20020a2e95cc000000b002da07afe6a0mr2360061ljh.38.1712941493181; Fri, 12
 Apr 2024 10:04:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411-dev-charlie-support_thead_vector_6_9-v1-0-4af9815ec746@rivosinc.com>
 <20240411-dev-charlie-support_thead_vector_6_9-v1-2-4af9815ec746@rivosinc.com>
 <20240412-tuesday-resident-d9d07e75463c@wendy>
In-Reply-To: <20240412-tuesday-resident-d9d07e75463c@wendy>
From: Evan Green <evan@rivosinc.com>
Date: Fri, 12 Apr 2024 10:04:17 -0700
Message-ID: <CALs-HsuMZOMpDh8kwQx6FE2mawzt+qTD-WZ6Mvhrt+hUhkZimg@mail.gmail.com>
Subject: Re: [PATCH 02/19] riscv: cpufeature: Fix thead vector hwcap removal
To: Conor Dooley <conor.dooley@microchip.com>
Cc: Charlie Jenkins <charlie@rivosinc.com>, Conor Dooley <conor@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	=?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Palmer Dabbelt <palmer@rivosinc.com>, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 3:26=E2=80=AFAM Conor Dooley <conor.dooley@microchi=
p.com> wrote:
>
> On Thu, Apr 11, 2024 at 09:11:08PM -0700, Charlie Jenkins wrote:
> > The riscv_cpuinfo struct that contains mvendorid and marchid is not
> > populated until all harts are booted which happens after the DT parsing=
.
> > Use the vendorid/archid values from the DT if available or assume all
> > harts have the same values as the boot hart as a fallback.
> >
> > Fixes: d82f32202e0d ("RISC-V: Ignore V from the riscv,isa DT property o=
n older T-Head CPUs")
>
> If this is our only use case for getting the mvendorid/marchid stuff
> from dt, then I don't think we should add it. None of the devicetrees
> that the commit you're fixing here addresses will have these properties
> and if they did have them, they'd then also be new enough to hopefully
> not have "v" either - the issue is they're using whatever crap the
> vendor shipped.
> If we're gonna get the information from DT, we already have something
> that we can look at to perform the disable as the cpu compatibles give
> us enough information to make the decision.
>
> I also think that we could just cache the boot CPU's marchid/mvendorid,
> since we already have to look at it in riscv_fill_cpu_mfr_info(), avoid
> repeating these ecalls on all systems.
>
> Perhaps for now we could just look at the boot CPU alone? To my
> knowledge the systems that this targets all have homogeneous
> marchid/mvendorid values of 0x0.

It's possible I'm misinterpreting, but is the suggestion to apply the
marchid/mvendorid we find on the boot CPU and assume it's the same on
all other CPUs? Since we're reporting the marchid/mvendorid/mimpid to
usermode in a per-hart way, it would be better IMO if we really do
query marchid/mvendorid/mimpid on each hart. The problem with applying
the boot CPU's value everywhere is if we're ever wrong in the future
(ie that assumption doesn't hold on some machine), we'll only find out
about it after the fact. Since we reported the wrong information to
usermode via hwprobe, it'll be an ugly userspace ABI issue to clean
up.

-Evan


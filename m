Return-Path: <linux-kernel+bounces-72389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9391985B2BA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A9CF1F22FAD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 06:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCDF58105;
	Tue, 20 Feb 2024 06:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="O/RcjSY9"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377D458205
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 06:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708409544; cv=none; b=rdJ9quAxwkOEAMKCdMbCZ4tig29zKivgd3neiB1zR9ColrU7FHhNFnEd2fVZLToUGXgcqAAD4aJopDFeg+ByDCmP7umBVv/s+gSk2Ylo7wGxxxQ7qLw95sriVjF6sMQzMTuDY8MsT0vf4xafSRedo+kObBLarERr7FusyyoRtZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708409544; c=relaxed/simple;
	bh=YwxziMJHXX2W98fYvbTdPERYnB552e6dw+lv8Xxeaik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dwwbd3kEui+Go9Tt/9E8Zd54Ol32vMni6eCf6BWBCmaQuIpoh5k0XmBQtnTM7NbBfdvEKU0Gu1vwtbgTvz1jEEh3MJwXaPub0WnocVSABgij1JoWXvO6teptakk4rSaMBPzAiFEbMnnGjfbKtwjcgrifm72pkKN2BB1HTi7jgB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=O/RcjSY9; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d0a4e1789cso60600161fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 22:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1708409541; x=1709014341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=45sEQuqSChb4TFdk2aFCbPunV2X7Zp2Ggfs8QlVxLCE=;
        b=O/RcjSY94OAL/Y9ZG6azBiEDoKYTLLN7PUZejAf3JPSFl0t5fd7dv+4EXsrnH0jqp/
         1YlYt0dNzU5gpnoQ9TzYxmpE4uX2Qg//pc5EEf1wtcYMUMRx05c1DsXew/Y30iA77mXX
         b99Z0LLzvUKtFVCw1cI28DsJ3Xzp6mAE2rjpdnWNNUAbcvYBc9e+BzYNyzYbkQGoEPzn
         So/axWQ5Y8KY2hBMqbc6xxHpOIZ/gTgA71ltfMFjgB6Dm2M/Kx6IZSWfo2Vba+uR1Dfj
         vwcrDmxcV0jQrxVGZD+fGLUpD512Oa5Mv13J+3+4ba8K8kZeSOhIhdsMJkMwIwJoZVaJ
         nVmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708409541; x=1709014341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=45sEQuqSChb4TFdk2aFCbPunV2X7Zp2Ggfs8QlVxLCE=;
        b=gED86vJ//fz/IraephNVFL5QqoUFMEI8G4q0wO/uiy1TSuwxtv0WXcHeSkgV9p0ehQ
         Fx6GTDrqwLkPMkAd/byZu4T9ca0KqHHzjGSMGNmDOvy3VUxqmOwv5cW+y9/erxaKrwHG
         tqsGHLSTy0VjSmV/MHMZl/wCorYbbk9/2IUVfroZM55ELCyCmINtcu2TlxeT9+tY/i8Z
         9kGtcpZ4Bu22Al2EprrG8s/Cc848UCn7g4Q2WQAIrrNIOnT3RBzXtDoGekrw8nLvhX43
         Yrk38cSza4wrl3QnZcwxWgll5a9QHlccpzM6etcD0SNWlkQjSqXbnaEvMdupBSZM/6cT
         Kviw==
X-Forwarded-Encrypted: i=1; AJvYcCUorxs30VM8/68q9sS1aETeeMYjtpI/tbNKrTbyXaJgA8OyG/EGmJygF3R5GO6IyKrvwbdupo3oTrc3g64ZK6uO8gkF38x9Cj3EK559
X-Gm-Message-State: AOJu0YxffUy6dLECRe/TUGAb4E13tKWkkUK8BEBurbRLkerhSciGnejr
	lUNjAoSo9kSx4PsIti0tTBLl9yzaa4ArtXdVDBdJwOf33Y1iezaELGZy/rtwuQnDWA0BR1t1QXg
	UUrcCNa0amhHhLFzfJgruqVaT2IOsNvFy2g/UPw==
X-Google-Smtp-Source: AGHT+IHMJBI/oMtcWEZVPK92GP05YnjcAeWF8XgBIuxDTLOi4XZzV5Qx4HMrS5IUdIaPjB4EYUfB3IKgxGQZLGSs3mQ=
X-Received: by 2002:a2e:b8c8:0:b0:2d2:bd9:f100 with SMTP id
 s8-20020a2eb8c8000000b002d20bd9f100mr10605944ljp.20.1708409541306; Mon, 19
 Feb 2024 22:12:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240127161753.114685-1-apatel@ventanamicro.com>
 <CAK9=C2Vwtj2gZg-P73yLMxu0rPXQ3YrRRuxq6HcpHMXgs-jHaw@mail.gmail.com>
 <87bk8ig6t2.ffs@tglx> <CAK9=C2WsSSHgDF+7ruxx_QF0Lk+Dsx2F2Y-_NabnxrJ_qWhgGQ@mail.gmail.com>
 <87v86pcxcb.ffs@tglx> <87zfw0azmn.ffs@tglx>
In-Reply-To: <87zfw0azmn.ffs@tglx>
From: Anup Patel <apatel@ventanamicro.com>
Date: Tue, 20 Feb 2024 11:42:09 +0530
Message-ID: <CAK9=C2W3cv0yd0faMrKjKwmSjGQ4zVVMkcbr=PtxJ1K0sn=SLQ@mail.gmail.com>
Subject: Re: [PATCH v12 00/25] Linux RISC-V AIA Support
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Marc Zyngier <maz@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, Atish Patra <atishp@atishpatra.org>, 
	Andrew Jones <ajones@ventanamicro.com>, Sunil V L <sunilvl@ventanamicro.com>, 
	Saravana Kannan <saravanak@google.com>, Anup Patel <anup@brainfault.org>, 
	linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Frank Rowand <frowand.list@gmail.com>, 
	Conor Dooley <conor+dt@kernel.org>, "Ahmed S. Darwish" <darwi@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 17, 2024 at 2:35=E2=80=AFAM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> Anup!
>
> On Thu, Feb 15 2024 at 20:59, Thomas Gleixner wrote:
> > I'm going over the rest of the series after I dealt with my other patch
> > backlog.
>
> Aside of the nitpicks I had, this looks pretty reasonable.

Thanks for your review.

I have sent v13 series. Please have a look.

Regards,
Anup

>
> Thanks,
>
>         tglx


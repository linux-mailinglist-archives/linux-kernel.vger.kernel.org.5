Return-Path: <linux-kernel+bounces-32197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C742383580E
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 23:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8A781C21187
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 22:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5722238DF2;
	Sun, 21 Jan 2024 22:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QaAirQCb"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEBA38DE2
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 22:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705875095; cv=none; b=JDPrm7xo5niZlmKMxOrGoSSIfKgSHI7QtFgcR2yoyEb2BDUTgWBse4n+pJScPlOlqYd/REIbv/f4kPgZIfm/6PjVjDEectTNQS4x7Y1zLJ47/48seuwC/BXKg3APhycEEl3ZeKQhMF839qH9JdXXNp5AzKpM5am+PIQd9mumpaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705875095; c=relaxed/simple;
	bh=1WshGn/r4yUtPgsq+2zvC3o8H0Z/O1lFjI+KiAN/Kfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P/GzyoARRQPTaKeBLfRobYtSOBihgGr7LHuJ05B8nMJ1tfW4u2VoZIZrunees0kTWEQRDJ4JgHfPhYADNiThhKXj0auXJrwu0dE519kZuB5pFZUeskOYe/psSU9rrvYTfG1cxJ63WNBNH+ArZEEg1URREdZcbwuyeN+2RHG82Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QaAirQCb; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-78324e302d4so265162385a.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 14:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705875093; x=1706479893; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wQx94V7P8SCvFtwg/55jgCd7aKBUyQ8m6oqo197QKQ4=;
        b=QaAirQCbaNAOHijY8N64CdARsU6yKFxELpm9Xcc1GIijti+ewZvRwZDMCN1bRZ+pMN
         vt0OU2+iJIuILMnJawB0vEK8gVo63aDYKgnqG2KYeQzHJU81NDfId9n3MIyJzQFo+HTn
         xW9uPc09gey962JJgd4LqjSZ4YwseATzfgcm2ZmXNWOL9EE6nvq0D3+p1kL2AEq/+1Uq
         a347oO+Fdb7JfsJYYU4u3BJMda4PSg6SRdCLC3rrHmcL3eTOKshkTZfk9zTJeqqr6qQn
         yoFcJtu9JUGuc8IqJt5ccyXKl54T/b91LfA1vETMT8uNRotIAgDU/PSTYuSu6HO1NSZA
         g6xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705875093; x=1706479893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wQx94V7P8SCvFtwg/55jgCd7aKBUyQ8m6oqo197QKQ4=;
        b=jUlpam6f1v0olSY7e1vhp7pVZ1lEW8ECaIrMeRQHqHJ0qTOj97YsBJ4y9bpOLNYZ0T
         Go3IcVSngRq/yGv76E5gqA7Ej7JPPIT/UgkgMrwwFcCOshxeDGSr7+gS/mb/H12jwVp/
         LdQAba9dlSl103iaVjZYtQTJ7isG+KERm4+z8yctgbB1p0cAhDC0PeXaVhKVNor5/08E
         VJne3r8gLSdGlSbK6R/XSfYQ4oaqIabRt2B+eHicwftccOFDhmVciYul1MZZZXm+ZmbF
         kBLqY4EOT0DqRDpWhUC0BlGmX68tpJ1IKk2Bg5b3EdAUfO4HyYGqoVg0azamhER8W/iv
         cIeA==
X-Gm-Message-State: AOJu0Ywr9bqJx+f/Z2X05Sf9CRrFAy7cGuvsRgb2Uabq271JyiwYlpGj
	il59xE6Z2W2ZdWgA+faakgIfLaTU1Na9uQ6WrI5IHMp4DiCdL/QKeCBvYsZp6kMP19+DUpFNcnq
	CWwDodES/8wlsSSpTEiUbaiNk/DbhedW+794p3Q==
X-Google-Smtp-Source: AGHT+IHvU8siwfpJaJqqNkTXM5eZ5047daz1HIwgSXnFzKXjH4wTei7iJY8jtoVu/z7rC9KXSwYCQydXweKK5eEVLjE=
X-Received: by 2002:a05:620a:5692:b0:783:7924:296d with SMTP id
 wg18-20020a05620a569200b007837924296dmr3956859qkn.90.1705875092989; Sun, 21
 Jan 2024 14:11:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240120170001.3356-1-semen.protsenko@linaro.org> <k5ih3vurmzrirgfzy62r5nezm2sxp3zf2qa2bhzowybthkvduv@wjywn55v5hmj>
In-Reply-To: <k5ih3vurmzrirgfzy62r5nezm2sxp3zf2qa2bhzowybthkvduv@wjywn55v5hmj>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Sun, 21 Jan 2024 16:11:21 -0600
Message-ID: <CAPLW+4nJKt4xNxXbqQ=c5rXCEau56Xd9ocNKqcuHLo7+-CH8-g@mail.gmail.com>
Subject: Re: [PATCH] spi: s3c64xx: Extract FIFO depth calculation to a
 dedicated macro
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 21, 2024 at 2:24=E2=80=AFPM Andi Shyti <andi.shyti@kernel.org> =
wrote:
>
> Hi Sam,
>
> >       void __iomem *regs =3D sdd->regs;
> >       unsigned long val =3D 1;
> >       u32 status;
> > -
> > -     /* max fifo depth available */
> > -     u32 max_fifo =3D (FIFO_LVL_MASK(sdd) >> 1) + 1;
> > +     u32 max_fifo =3D FIFO_DEPTH(sdd);
>
> Why have you removed the comment? Perhaps you could place it on
> the side in order to remove that awful space.
>

The fact that `max_fifo' contains max FIFO depth is already coded in
the variable name itself. And with that new FIFO_DEPTH() macro, it
would be basically stating the same thing the third time on the same
string. Thought the removal of that comment only made the code easier
to read. If you think I should bring the comment back, please let me
know and I'll send v2.

> Not a biding comment, though:
>
> Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
>
> Andi


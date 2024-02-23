Return-Path: <linux-kernel+bounces-78294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DEEF86117F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63108B240E2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1015E7C092;
	Fri, 23 Feb 2024 12:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2pTz4qB"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC357A70F;
	Fri, 23 Feb 2024 12:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708691421; cv=none; b=H3jg6AqTzdqQXeRHBvqASi+CgMWuiZxiF91x0r6RkcEleje7fcL2PpMh6mgK6079eTVK/wYXFP5tm2WUhtkLztEUtADVatweKrj5TOiD0HtseCifevX333M5yh6xSQ0gEy4Ne4ygQA6WGBiCQfg8SgOhbSk7ZxWDj3/U70saqNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708691421; c=relaxed/simple;
	bh=amyiBnlJbCnQhUudB+E+DN+Qey4LsTCqv0Y+x8SV0Yw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cn5ZfI21jY9BzV/8fYWbaW8mvDIXoPc0oxbFvoFgcPqjMueKqsH0iFV0WEgQPdEknASIf9bX5Tdnfvp2Dh6oULkT9dBG2bllDomUjj2i/yx9tQTbkNmXkSDRJ/84QYKbQWdopao3OnxNtfw+tEUCBQfBB0ssXvM8PVml+NDhKkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z2pTz4qB; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a3eafbcb1c5so99897766b.0;
        Fri, 23 Feb 2024 04:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708691418; x=1709296218; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z+sEM8TBzFwF52b1ptT4m8wa0TY+pHXRQ9G4oc6DYXE=;
        b=Z2pTz4qBo0tSQMSeKuCMhDeBq2MNAEcmpqjLkwzbJMFXxb9rMJ7G0txWJqIPvMIc6s
         x7PCE9gqASF45wKECrksOXkmjJVvMZnVy2z8gGs5LClJwLh3SsHOyvGIwDYRyyurE9pU
         lPnrJBUOBQ6MjV6YBddjUle0lmpD71glsHa8KRolU9To+7LXv7wjxd6PzTYEQ2TIFVTX
         nHrLiTof+q/BRbtfIKhBKtdBx9EUIhjJ4r3Ki4ViTH4WqeGGDPq5zBik69znrq7Fzk2+
         YRmLDSB92tzMxlqOoas6KyE1+KUE+ne8hlFz6OZtBSxcMod43fKNCzrRMFGCNhgwcXk1
         XRoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708691418; x=1709296218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z+sEM8TBzFwF52b1ptT4m8wa0TY+pHXRQ9G4oc6DYXE=;
        b=l/CAxxYLqxQehAIBuVtHy8NwCU3uXw1LW+L3Z75qKUub+OQBYdFbM5JsSTWmxvi2nq
         II/L02pPx/GudBdZZH1r0+ZGzwIW8KjXYqq64BDA64a8YixK+qZLPMxdSbeKIdRL5Fpp
         gdJoceFZvLpC9cR/ZbTZOI0q9KunmWU2FWiyL7dSjf6lwkeDoO94oOlo2vsWGjUP5vtd
         l/MP30mZbgQVeg2UW8jib2um0MRfe/4gW/sz8u0qbkFqZS1ajQ1DJZ7V80VXX/mFIEVd
         yqoEDjsDZe2i3f59K5P+xAG8aehsuRQx+46LcTFI980983EIzc6LH4JTQQhsxWWEFYfV
         P/hA==
X-Forwarded-Encrypted: i=1; AJvYcCVbE6n7NGrZIU9xbpaHt6NBJ+yrh3sTwWIhxX9zLrLGq7ECoKQ8xART3lx0Nf6Yx2thEvUWTA35B6Kk75HZJX4ysaoxey/FhFqgEbkZX3WSOFiLg/uXdezpYls0oc/deKCafMtGFqwXwg==
X-Gm-Message-State: AOJu0YzYogIZGeHPMIgb/FqdkIDPMEZ26unRZjL7XwAwZbZ+T8rS4tuJ
	4MjSl0y40LLrDoZA7Q/vx7L52PwRcDMPN/5yfKN0pT6ECwxUTdd844MoRkY/9yC1XSedwCy1rK1
	9EA5qxat3BQyXRpcUUW6oQndRAIpxD7ziLfA=
X-Google-Smtp-Source: AGHT+IGiezhcE/l+7DGjerhjscIkDU3wydPXg0uO3yekZ/O0X37aEVlx8Sy5K9Zu4NEQgK6LIwNzdQS3MJuuLg9aw8U=
X-Received: by 2002:a17:906:71da:b0:a3f:7e2:84cc with SMTP id
 i26-20020a17090671da00b00a3f07e284ccmr1470771ejk.6.1708691417557; Fri, 23 Feb
 2024 04:30:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223143309.5ec298ec@canb.auug.org.au> <CACMJSevZxCiqa8uz+XU36psCa5T_rQGi5tVkMejpZj22Bj1k3Q@mail.gmail.com>
In-Reply-To: <CACMJSevZxCiqa8uz+XU36psCa5T_rQGi5tVkMejpZj22Bj1k3Q@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 23 Feb 2024 14:29:40 +0200
Message-ID: <CAHp75Vf4=huDQ6211zY4aQem_BX3px4YwhfsA+YXcbGCJSV6Tg@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the gpio-brgl tree
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 9:51=E2=80=AFAM Bartosz Golaszewski
<bartosz.golaszewski@linaro.org> wrote:
> On Fri, 23 Feb 2024 at 04:33, Stephen Rothwell <sfr@canb.auug.org.au> wro=
te:

> > After merging the gpio-brgl tree, today's linux-next build (x86_64
> > allmodconfig) failed like this:
> >
> > x86_64-linux-gnu-ld: vmlinux.o: in function `bgpio_write64':
> > gpio-mmio.c:(.text+0x1489427): undefined reference to `iowrite64'
> > x86_64-linux-gnu-ld: vmlinux.o: in function `bgpio_read64':
> > gpio-mmio.c:(.text+0x14894a0): undefined reference to `ioread64'
> > x86_64-linux-gnu-ld: vmlinux.o: in function `bgpio_write64be':
> > gpio-mmio.c:(.text+0x1489527): undefined reference to `iowrite64be'
> > x86_64-linux-gnu-ld: vmlinux.o: in function `bgpio_read64be':
> > gpio-mmio.c:(.text+0x14895a0): undefined reference to `ioread64be'
> >
> > Caused by commit
> >
> >   36e44186e0ba ("gpio: mmio: Support 64-bit BE access")
> >
> > I have used the gpio-brgl from next-20240222 for today.

> I'm not seeing this issue with allmodconfig on x86_64, could you give
> me some more information on the build environment?
>
> Andy: Could it be that the ifdefs you added should depend on
> CONFIG_64BIT and not only on the BITS_PER_LONG value?

If so, it will be the old issue as I just used what is currently done
for LE 64-bit accessors in the same file.
I think the problem here is different, i.e. io*64*() are not available
on all (64-bit) architectures in comparison to readq()/writeq().
I'll look at this later today.


--=20
With Best Regards,
Andy Shevchenko


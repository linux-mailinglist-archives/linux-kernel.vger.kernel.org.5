Return-Path: <linux-kernel+bounces-82201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD4186808A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B8751C238E6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73F7130E5C;
	Mon, 26 Feb 2024 19:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wxeah69Z"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6423C12F5B1
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 19:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708974480; cv=none; b=Temm9RjC9EGeeFLsfHZ+vKLtvVVt2K3AUWxz67M7Dng/d6NVe+GK35qVSlHcb3WxGdnMKZwgjxkrvlPTBLDlrZaUGSQLSBvSbdhGSTpLaAhb/34dZSCO5aW4HzsBZU078q5tu5QJjgJV3ChcatKDT84u8fAvPzaQF4RzeCnlB6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708974480; c=relaxed/simple;
	bh=5V0Gu9RLETKaA+n6BwJAf4NMdmuGU5nGvxH6SUZsZ5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AGzc0i3MSYP6iQ5vEd0F/eZDJwSVB1wMU5Dm9YWR6l0Iu3V6Yyp7zCYpSbLURcI+KsXW+CRIKq2iZCS7ECX06SgPsZbJfDgXGoeIfm/DwNi+D4wXQaCZlP1E6D8LrslNCBxuyb5VyD1ziSE6enNngLXbtOy9RSn9Ki80TXQP8u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wxeah69Z; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-608c40666e0so22151957b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 11:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708974477; x=1709579277; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H2DfHajDWnecKNcsxr0AkxJp1yr1QIN2sBa8KKOJfCY=;
        b=wxeah69Zgmipp02F2FbWmCrIskEX2yruY7Sc5ANIkOwCXKh78rFPAtWDtOt6CTE+TY
         x74JjBXScomJ+LeJobvT2EuHfYkypYBLIMp9SZQFpUqDIu6FvyOMA7DNY7T5lW6hI1zU
         efmh/qnHPDgLJFaOaUI3pamz1YKCU86SYWombqtahyDDILFS0y6Nu4jyZRyViS+wV9ck
         2NZGhtlpZ333Z7hznXOTD84I+hhBPqCuHRzlmdUhWifco4kRka+FwWC6LQwYNllG4e2O
         WgTZ3Ph1U5L+hLcthz/TX/GnwW1dyIZ6yzwt12/OT6QJG0XWk14H+yZ5bAWsdcWpAwMX
         cV+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708974477; x=1709579277;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H2DfHajDWnecKNcsxr0AkxJp1yr1QIN2sBa8KKOJfCY=;
        b=em7Z5BQrXYd2vEBcZQOgTohdDCckQ4+2cx60t24cdlZB6D8+gVHfPnFn77TOi5tS3l
         WSB3bKri+woC9ZwxutZIRAKBpBaxHqzBcwcsOcu9/H4bAYteNd7n5EwvigNGi+Dzl9HY
         4GWMpkwxxtDtNONwZgqnoSuFoOATAJyd8X544XoVktm2Z+yhEfhx2w+u6ogs21fAqLym
         D8O5xSU/lEx3vUXCjNdRPm2JHJmGNULC1+kztDTtsQ3dnqRABTTOCIM8bFDk3C/o+yPR
         JygizuXfmt31F+cDbKvuMOZtvvNGXoBZLDK6+kxf/jBtepMEy1a+QpZAtY8ClC9+EH/G
         3ltg==
X-Forwarded-Encrypted: i=1; AJvYcCW2AEtDQG39Oba6wyj80B3Mni1dU0+34OV6dzXaWtX2DGJTxUKbHXYmibJBjZNAhnOrtGRtp6vMaBAD3dOcVmtYRc+WGg4LuAa2xlC1
X-Gm-Message-State: AOJu0Yw5dZ3mkhffU+hDrzBq6Ippx0GcwmcVwIsWZX7Mq04YHJ3haEro
	OSd25cRzf5EPjEuR5PVjNEnqpcTKY/cBvfYrXYUGV7X/hLe08IQ8Qr/xCVmpzdvHgo9Vznk5oIY
	aoVm0aaDCjwIaEYS85du/rJ/iL8sHAaBtK4N5UQ==
X-Google-Smtp-Source: AGHT+IETQYHYt3ExeOFTvzV1e1MenYiK22gNhHQCe2O6Awtsi2cTxN9aK+1GDMyHi0SemB0S0z9kJQmyu8sEjmOVbLg=
X-Received: by 2002:a25:2d06:0:b0:dc2:279f:f7e with SMTP id
 t6-20020a252d06000000b00dc2279f0f7emr108603ybt.10.1708974477312; Mon, 26 Feb
 2024 11:07:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223143309.5ec298ec@canb.auug.org.au> <CACMJSevZxCiqa8uz+XU36psCa5T_rQGi5tVkMejpZj22Bj1k3Q@mail.gmail.com>
 <20240225125815.2704bb3d@canb.auug.org.au>
In-Reply-To: <20240225125815.2704bb3d@canb.auug.org.au>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Mon, 26 Feb 2024 20:07:46 +0100
Message-ID: <CACMJSeuCF1wLMwGE9sFjnWMfb3CNmbtWn+6NY7DLV=-Fs7qr_g@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the gpio-brgl tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 25 Feb 2024 at 02:58, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Bartosz,
>
> On Fri, 23 Feb 2024 08:51:10 +0100 Bartosz Golaszewski <bartosz.golaszewski@linaro.org> wrote:
> >
> > On Fri, 23 Feb 2024 at 04:33, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > >
> > > After merging the gpio-brgl tree, today's linux-next build (x86_64
> > > allmodconfig) failed like this:
> > >
> > > x86_64-linux-gnu-ld: vmlinux.o: in function `bgpio_write64':
> > > gpio-mmio.c:(.text+0x1489427): undefined reference to `iowrite64'
> > > x86_64-linux-gnu-ld: vmlinux.o: in function `bgpio_read64':
> > > gpio-mmio.c:(.text+0x14894a0): undefined reference to `ioread64'
> > > x86_64-linux-gnu-ld: vmlinux.o: in function `bgpio_write64be':
> > > gpio-mmio.c:(.text+0x1489527): undefined reference to `iowrite64be'
> > > x86_64-linux-gnu-ld: vmlinux.o: in function `bgpio_read64be':
> > > gpio-mmio.c:(.text+0x14895a0): undefined reference to `ioread64be'
> > >
> > > Caused by commit
> > >
> > >   36e44186e0ba ("gpio: mmio: Support 64-bit BE access")
> >
> > I'm not seeing this issue with allmodconfig on x86_64, could you give
> > me some more information on the build environment?
>
> These builds are cross builds using Debian's cross compilers on a ppc64le host.
>
> $ x86_64-linux-gnu-gcc --version
> x86_64-linux-gnu-gcc (Debian 13.2.0-7) 13.2.0
> $ x86_64-linux-gnu-ld --version
> GNU ld (GNU Binutils for Debian) 2.41
>
> --
> Cheers,
> Stephen Rothwell

I dropped the offending commit from my for-next branch. Let's revisit
it after the upcoming merge window.

Bart


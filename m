Return-Path: <linux-kernel+bounces-25481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E24EB82D0E5
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 15:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77AB92821B1
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 14:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DBA23DE;
	Sun, 14 Jan 2024 14:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bhBah/QS"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13B823BD;
	Sun, 14 Jan 2024 14:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a26fa294e56so819078466b.0;
        Sun, 14 Jan 2024 06:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705242656; x=1705847456; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PGgDW1TWbu/IxiNbUJKSvwDw7b9go5u/b638eBN6ezo=;
        b=bhBah/QSA78acaw0yPLtExnhqNAiHX5WH4KbtpL5jbn5iujAK/CdZ9Z8zFPGVhcdMg
         ImjCjeiF0LDiomd6d3ymSNLL7/cYBDsJXrKh6fSljbRDJmu1LA3h8L4XcfZHzGbJDc45
         /kFj3na2Ie0DFjbIBniljEe76eyJCXmFrGQUsFkjqHp2E3e2+sHCJ3ZCDWqXJnZVMZQq
         nqepg367cK1kbCKvbIUD3A6Xj6LBD3HPa3r88Kr4KydHzm4NG7tdvjKvcBuYhDvwvpSO
         nUciuLJI2sLV+WoAcqyjRmu8BazSD+1A1iamOWgDs5tZTUQKKkeERvP9USxtWeQ0VKjn
         HAZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705242656; x=1705847456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PGgDW1TWbu/IxiNbUJKSvwDw7b9go5u/b638eBN6ezo=;
        b=S1j5a4Q8bExfCAlmYKyQgzohpmfJjGxYHtr6aV7RDaEGPEJV4WbrVGZeXk8/LLhWQq
         wF3AXhYGU8+6uuzhA9XGdsFdWP/IcHiZuha9Bls+LzrDXKPQ8J8fDUQgRO7pBtZlkSaz
         KzR5wPRLkSuq66+0yTVP3NaQG/whhSEC9xnSZMEqqd6li6Q7JaiTGUEjNP5Cb1bOu3bY
         FfunacZfEnUJEsC5izVZRc2EIyAPPvrqUM1a/NJqzW4gDPX/4MJXDg3BHzoHaXBNQLOk
         XWvm9hGvc9ZhOyukuRaB9tJEsCsAGfjKt+mOBQyDcRMwnDSWTFv4TPEsk5x+O1Z21+oY
         85yg==
X-Gm-Message-State: AOJu0Yw83KJSXzO/bbU/WNTXsj0PbzdrzYZR81zm9weTJxUpcH+EnWoL
	65Q6xbJrP4f7DyRl8AGkOSZGw90fOD4bM55HZNw=
X-Google-Smtp-Source: AGHT+IFLoSu+vMFwbQVcKYlBqjuE4eeLhavD+dG3mIJpEazMtvQYHKbfpjqoGMzTclqC5OCyURmUeAkZh2FoPndb1ic=
X-Received: by 2002:a17:906:33d0:b0:a28:c06d:2e0a with SMTP id
 w16-20020a17090633d000b00a28c06d2e0amr1968824eja.70.1705242655969; Sun, 14
 Jan 2024 06:30:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109140221.77725-1-warthog618@gmail.com> <ZaPrbi6GxqlfysWe@smile.fi.intel.com>
 <20240114141957.GA99741@rigel>
In-Reply-To: <20240114141957.GA99741@rigel>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 14 Jan 2024 16:30:19 +0200
Message-ID: <CAHp75VcdE-DfoSLOYyg5RdouBCs1QJ3AO6Ru49P_84-vTKi4DA@mail.gmail.com>
Subject: Re: [PATCH 0/5] gpio: uapi: documentation improvements
To: Kent Gibson <warthog618@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, brgl@bgdev.pl, linus.walleij@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 14, 2024 at 4:20=E2=80=AFPM Kent Gibson <warthog618@gmail.com> =
wrote:
> On Sun, Jan 14, 2024 at 04:10:54PM +0200, Andy Shevchenko wrote:
> > On Tue, Jan 09, 2024 at 10:02:16PM +0800, Kent Gibson wrote:
> > > This is a series of minor clarifications and formatting tidy ups for
> > > the GPIO uAPI kernel doc.
> > >
> > > The series is intended as a companion to my character device
> > > uAPI documentation series, but makes sense on its own too.
> > >
> > > The patches are self contained and trivial so not much to add here.
> >
> > Reviewed-by: Andy Shevchenko <andy@kernel.org>
> >
> > for patches starting from the second one.
> >
> > The first one I personally don't understand why, but I'm not a native s=
peaker!
> > I believe, it's correct, although the original version seems okay to me=
.
>
> The problem isn't the language, unless you mean I'm explaining poorly, it
> is the logic.  The original says "zero or negative value means error", bu=
t
> in case of an error the kernel does not actually set the fd.  So if the
> user sends a request containing a positive fd they might incorrectly infe=
r
> that the positive fd being returned implies success.
>
> The new wording is that the returned fd is only valid on success.

Ah, thanks for elaboration, now I understand the issue. Okay, feel
free to extend the Rb to the first patch.

--=20
With Best Regards,
Andy Shevchenko


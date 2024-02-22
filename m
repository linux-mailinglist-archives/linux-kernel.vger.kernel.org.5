Return-Path: <linux-kernel+bounces-76200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C686E85F41D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E85DB217A6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702A73717A;
	Thu, 22 Feb 2024 09:19:19 +0000 (UTC)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D440723747;
	Thu, 22 Feb 2024 09:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708593559; cv=none; b=aCGEhpnysoEtO9RdCRWI/UViaE8f+8rf0AuNWyimmp00spsBSZ6cVTbBcU5568DJsL8h7srrnZZJXQLPKhXRhrJg4qCrxV+Si03jc/YqcTZKRoXR8CBU3ChMFKdOI4RQ26U2emMgPgn9uY5R10vZdgf1AM5ALZdQcW2cj/dtNnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708593559; c=relaxed/simple;
	bh=Vymc4gK6nDb5Dw0fXiG3ef7wKVL5g7oOlzWlxmMt1Pw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AGk0xJM6ncMYpYfKLMCbaiIYiU6HBaETcsOtNqpZ0q+yBW+4cMirhGh6ikbHCWmEzNBuwpW7M4K0hbhWe4FlvxmYyRreCuKNoKWqRQMbZZWGHZxcO9KzhyigDQSDjiLLz41B4lS2AL5gchI3P5TYYJcR21hW/iFTUVT99VeqTFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-60495209415so74606477b3.3;
        Thu, 22 Feb 2024 01:19:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708593555; x=1709198355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OYC4j1AtfwI6qrp3pWynlDebhFoOBwjNL7JXQ2Z+8a0=;
        b=hHNJPMyguEIZHrqosL9GQSfSKn5bfIjhLoGyrgFD9IZDTv1ysmLE5qW+Vi1hdSLfGj
         xHF2AC0f+n4E4kRgxathcnG1w9m/n85w6J7MgOMKW3/4sQ6msIIz43fv9ju8XafQBu/5
         jztcITkTXdkr1wAGhivPmDsTM+0s11LEqpasObVCfF2kgQki6r242TOMZf2Z06gw2W0R
         jI4tNL4EykUdSlQmS0Sk+PtJ0xacHzbX1QaxrX3WdZo2Bluw51+d8ecr2Iz9aSXl26zM
         8UBVdBWODnClM901UV4kokqrzB/G9FzHapEaztfb96F4mqKHQQe5eMPA0Gvj23KCvphP
         aGBg==
X-Forwarded-Encrypted: i=1; AJvYcCU/eoVg+VHNy9EuO2+ZGNEkbOw0NRleinRKBoOep8q3TuKUFN0h5nFjCFQ2un9YiQxG5/SbbPf37Aizt7aPDPdP2h3GQFnN4Sdqu5QmwYvylO6h4ZUgh0EHASZ/XEOUk3tl13hIMyjo
X-Gm-Message-State: AOJu0YzoNP5xBVgtiT/TG766VGP2zT51/jNTqPtkKgMYdleoMilQdEip
	rOwS5n4K/5iUVAsTP15XHR/nW7Mbgsnq/pBSyj2FpBr75cRu+V0dr2vneZrtw7o=
X-Google-Smtp-Source: AGHT+IF36fcXGdxTUDjJA5Bms1PHDJA7bhCM+s8jxxgSboOu/y9jbupcMwBIBt/gmjy2LNG3IdQM5A==
X-Received: by 2002:a05:6902:1361:b0:dbe:a688:8ab8 with SMTP id bt1-20020a056902136100b00dbea6888ab8mr1859333ybb.0.1708593555542;
        Thu, 22 Feb 2024 01:19:15 -0800 (PST)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id y14-20020a056902052e00b00dc74d5e3ff7sm2654126ybs.31.2024.02.22.01.19.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 01:19:15 -0800 (PST)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-60495209415so74606377b3.3;
        Thu, 22 Feb 2024 01:19:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUBz76rZwwlUWSXvKuNMEOxTQyj5pCXpUtlUiadprj8qYkwnZozoKiTJDE55peKsupFmvuMGMIni8gGOjHeXiXqfWXUdNrp7oDxTX+i+YQvc/fxKX7OaimmTCxMAn0IwrwtgbAnRZMH
X-Received: by 2002:a05:690c:86:b0:607:d9f7:e884 with SMTP id
 be6-20020a05690c008600b00607d9f7e884mr21602878ywb.4.1708593555213; Thu, 22
 Feb 2024 01:19:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221-fix-sh-mmcif-v2-0-5e521eb25ae4@linaro.org> <20240221-fix-sh-mmcif-v2-1-5e521eb25ae4@linaro.org>
In-Reply-To: <20240221-fix-sh-mmcif-v2-1-5e521eb25ae4@linaro.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 22 Feb 2024 10:19:03 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUJi3khMmRXRquwKNF1ezEAokLs+n46O2JDDap6t9v=tQ@mail.gmail.com>
Message-ID: <CAMuHMdUJi3khMmRXRquwKNF1ezEAokLs+n46O2JDDap6t9v=tQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mmc: sh_mmcif: sg_miter does not need to be atomic
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

On Wed, Feb 21, 2024 at 10:23=E2=80=AFPM Linus Walleij <linus.walleij@linar=
o.org> wrote:
> All the sglist iterations happen in the *threaded* interrupt handler
> and that context is not atomic, so don't request an atomic
> sglist miter. Using an atomic miter results in "BUG: scheduling while
> atomic" splats.
>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Fixes: 27b57277d9ba ("mmc: sh_mmcif: Use sg_miter for PIO")
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Hi Geert, it'd be great if you could test this!

Done before (see the Tb above ;-)

You probably still want to s/does not need to/must not/?
(sorry, I miswrote that previously)

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds


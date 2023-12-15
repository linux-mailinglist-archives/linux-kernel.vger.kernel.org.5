Return-Path: <linux-kernel+bounces-744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F6581456E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48B721F2161D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 10:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFAF11A71F;
	Fri, 15 Dec 2023 10:22:06 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF4C1A720;
	Fri, 15 Dec 2023 10:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5d279bcce64so4116577b3.3;
        Fri, 15 Dec 2023 02:22:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702635720; x=1703240520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zIqyMLDoz3bUGP62JyhcKO5VrQi/N9+QK4f+5otTgHs=;
        b=KnL/SxQP8xtqjlIYBGfNHSIza/5jnuoRmUiad3gZu8EbVHF5NYKBIoqFO18Bg8KyXy
         DDpZvxTWqjMzDKg4/O0gaPWlB7asGix9+Lb4ZRrKwf3OY6rvd6Y/Wq3Rq2yV7QWY1P+V
         TerhfYCd/zWDOpXR3wBJHAlCgZ/aYpxvAsMDwEILlCDVf7cUxAe2KAx5cSCbfAeL5Rcw
         4SwGkfUa0I0LlEEre3ZaEq0yxI5Hhj4ngD21WKXGGBc8rFkKk4tFW7h37eBr+/g0konp
         qlWrDFJ07yqWC+uLUSmY9FKBDwMQlctbVfAtV+y1UcuuUqVZf7mfizZiGwHYYQt0PYme
         uNpA==
X-Gm-Message-State: AOJu0YxBk4Jnz5DckkIPCXB0dnNwNatHT4pLHmOvMVbHxIbrVMS8vkvt
	VdgHN8W5nP1mPGxkNck2Icq8oJgQSi/spw==
X-Google-Smtp-Source: AGHT+IHrK0C2ZiIt+zrexReq7miKG1eUegeuz9keqdLcdp0m93zdrcTPsp6CewNjd0XcWnLLfQBV4A==
X-Received: by 2002:a81:a04e:0:b0:5e2:93f0:884b with SMTP id x75-20020a81a04e000000b005e293f0884bmr3901907ywg.85.1702635719797;
        Fri, 15 Dec 2023 02:21:59 -0800 (PST)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id ey7-20020a05690c300700b005e33364be2bsm39852ywb.70.2023.12.15.02.21.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Dec 2023 02:21:59 -0800 (PST)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-db3fa47c2f7so338801276.0;
        Fri, 15 Dec 2023 02:21:59 -0800 (PST)
X-Received: by 2002:a05:6902:100d:b0:dbc:f470:33e1 with SMTP id
 w13-20020a056902100d00b00dbcf47033e1mr744766ybt.72.1702635719251; Fri, 15 Dec
 2023 02:21:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215004700.46147-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20231215004700.46147-1-yang.lee@linux.alibaba.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 15 Dec 2023 11:21:45 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVR-HgRkOkfGRaAVmxRQhepQSspyCS1YyOwwfPW5-R7tA@mail.gmail.com>
Message-ID: <CAMuHMdVR-HgRkOkfGRaAVmxRQhepQSspyCS1YyOwwfPW5-R7tA@mail.gmail.com>
Subject: Re: [PATCH -next] pinctrl: renesas: rzg2l: Remove unneeded semicolon
To: Yang Li <yang.lee@linux.alibaba.com>
Cc: linus.walleij@linaro.org, linux-renesas-soc@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Abaci Robot <abaci@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 1:47=E2=80=AFAM Yang Li <yang.lee@linux.alibaba.com=
> wrote:
> ./drivers/pinctrl/renesas/pinctrl-rzg2l.c:485:2-3: Unneeded semicolon
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D7749
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Thanks for your patch!

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

As the issue is not yet upstream, I will fold your fix into the original
commit in renesas-pinctrl-for-v6.8.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds


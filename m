Return-Path: <linux-kernel+bounces-17452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C3E824D6D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 04:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A892B23DEE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 03:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82BE522C;
	Fri,  5 Jan 2024 03:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i6QfD3df"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80944405;
	Fri,  5 Jan 2024 03:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-20451bc39b1so608673fac.1;
        Thu, 04 Jan 2024 19:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704425170; x=1705029970; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OfrqhYTGUJ9pcqbluJqareOb2HurY1Vh3HHdZ5Gd8c0=;
        b=i6QfD3dfYgdXj5XHFzVF8QRjQXE4L4lzxsrHzCG0Hc9uw1XFo7lorwMLNy4tyDw61d
         +oDsJzwEvCo2341tC0PizZWV/C8PD1HTbszXXaNOOEjhFHzbFGG8nWnpctfyTktnRZQX
         eQK2XTZ77tFp/PxXVQDTovm0mpIGM78y03c067Dah1lP85jBDp2/6jZLUR0eANosubag
         cKI6HSkQIMwixYRYzfx6YNicEQMM1oGJ+47oaVaB0dTdU77ywvVkVgLSAigwcSJVRPdF
         16ROd3m2DP+Cx7RptoRc2d6FI9IkcbzLYIvE+kxcxufExYm0iyX7zh+pPJFOWreRjdBs
         /6/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704425170; x=1705029970;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OfrqhYTGUJ9pcqbluJqareOb2HurY1Vh3HHdZ5Gd8c0=;
        b=cGPrwCzsisauRw4iydind4qgJ3u/BqA7Oc7R+QgLwsnQ+ZHrStIkXIrYUJX87GgZ98
         gCFd8fB0mmxoodjjCckgeOpbKtzpaxf06jqH/lvlv25c1fhtEIgbGecC2u+Q00pu+ELL
         hDsXDNakyrhn2S8unGtw5KeG/RotzME9tvpeVu+/5AUU2cwQLHuZQB87UwuLqE978tX1
         LN7ITLsi//MRIVcgRBDmyJTX4MCIfrw2Mh2iNsJIR4mCoWfl5UYOYKyjzmiO+CYWNZC1
         bKeUON+0aDG2qpZyxoDLzDQx1dPh2tl/kUknmxMWYJ1hjdG+xjKtuK6dFPY6yVt5G7A3
         otqw==
X-Gm-Message-State: AOJu0Yxm0ELv8ahrsSOdzkUv3Dh2HBNyqY8Qz7KbHAIdCuZh69SNXxdv
	ZyHfb80cwhVGH4tS3WaZQClfvIJ08+bXRnelWf+v6CNo
X-Google-Smtp-Source: AGHT+IEJJdh/Qjsp0GDBwgvwTgMsU4RRRkXQT0YqPoCz7PTSerEiTpOkQVUbvDyrq/rpi27sQXlA1pLvR2wjF/+1f9U=
X-Received: by 2002:a05:6870:36d5:b0:204:c0:5db3 with SMTP id
 u21-20020a05687036d500b0020400c05db3mr1418682oak.13.1704425169809; Thu, 04
 Jan 2024 19:26:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104024244.12163-1-Wenhua.Lin@unisoc.com> <20240104024244.12163-2-Wenhua.Lin@unisoc.com>
In-Reply-To: <20240104024244.12163-2-Wenhua.Lin@unisoc.com>
From: Chunyan Zhang <zhang.lyra@gmail.com>
Date: Fri, 5 Jan 2024 11:25:32 +0800
Message-ID: <CAAfSe-ty=BgDNxST7q=+0CR6pshP4LhgmEPeZLmasiS2UkTjYA@mail.gmail.com>
Subject: Re: [PATCH V3 1/4] gpio: eic-sprd: Keep the clock rtc_1k on
To: Wenhua Lin <Wenhua.Lin@unisoc.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andy@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, wenhua lin <wenhua.lin1994@gmail.com>, 
	Xiongpeng Wu <xiongpeng.wu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Jan 2024 at 10:43, Wenhua Lin <Wenhua.Lin@unisoc.com> wrote:
>
> The eic debounce does not have a clock of rtc_1k in the sleep state,
> but the eic debounce will be used to wake up the system, therefore the
> clock of rtc_1k needs to be kept open.

It seems that this issue is not in the latest SoCs. I would suggest
not changing for the time being.

Thanks,
Chunyan


>
> Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
> ---
>  drivers/gpio/gpio-eic-sprd.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpio/gpio-eic-sprd.c b/drivers/gpio/gpio-eic-sprd.c
> index be7f2fa5aa7b..bdcb3510a208 100644
> --- a/drivers/gpio/gpio-eic-sprd.c
> +++ b/drivers/gpio/gpio-eic-sprd.c
> @@ -24,6 +24,7 @@
>  #define SPRD_EIC_DBNC_IC               0x24
>  #define SPRD_EIC_DBNC_TRIG             0x28
>  #define SPRD_EIC_DBNC_CTRL0            0x40
> +#define SPRD_EIC_DBNC_FORCE_CLK                0x8000
>
>  #define SPRD_EIC_LATCH_INTEN           0x0
>  #define SPRD_EIC_LATCH_INTRAW          0x4
> @@ -223,6 +224,7 @@ static int sprd_eic_set_debounce(struct gpio_chip *chip, unsigned int offset,
>         u32 value = readl_relaxed(base + reg) & ~SPRD_EIC_DBNC_MASK;
>
>         value |= (debounce / 1000) & SPRD_EIC_DBNC_MASK;
> +       value |= SPRD_EIC_DBNC_FORCE_CLK;
>         writel_relaxed(value, base + reg);
>
>         return 0;
> --
> 2.17.1
>


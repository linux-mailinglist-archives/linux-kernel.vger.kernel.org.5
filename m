Return-Path: <linux-kernel+bounces-125567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 482BB8928D4
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 03:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04BF0282F53
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 02:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BAC81877;
	Sat, 30 Mar 2024 02:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TwEfoq0W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EB31860;
	Sat, 30 Mar 2024 02:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711764271; cv=none; b=XsWg95HIlN7EJgJV5mWYzhYmplKucbNfVo7/iNcwHmkh5Rrok03kk/d+V1lgJ9SbqyqFDfNWMindDW+uL3jP4vyMi+D/wdUIJgX9y91rYKvpm+T/qRS1cIoVWIyJHPuDZU0Qx4lfAV24yuu7pjKLoWdxlgS/Hh5WRGISVxAk/JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711764271; c=relaxed/simple;
	bh=Wk28etsJV9OLppkXGrvdl2+DqrkI79w+XXntZj2FBbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DpJVyPoE4hLYgDMYehFqNsy530rdjQePfJwcA8It7oX+iAY/CspLQ6zcm02tosx6KnOvBK5IApFxZpQXUGKPWL3v65MjAhi0ZrUwpmHaAFQpEjrUZXO3uTV/4NgZur8dtcX/Seu0wVUW13Ta/UjVbW/cHZaPM0Q8wX7B7iBmur8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TwEfoq0W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29834C43394;
	Sat, 30 Mar 2024 02:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711764271;
	bh=Wk28etsJV9OLppkXGrvdl2+DqrkI79w+XXntZj2FBbU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TwEfoq0WQ6BpJv7ip3oXNkO4gICUL7k8jsZTM5wR6Hbkpj+uf3yMrkjSITf8lg2oJ
	 LSPBR7yGJJstQw2/ymzK1ScvD1UWNVkkPx1J+UKlIiEPNVNuzb3FgCbXIzK8QgsD+Q
	 qXeoYWg+eso3HWrnPYQSJDHx25ite5Kr3qokAOlsUpfNvFzXX95rG5CkgYYPC+M7jg
	 BS0g+xYWYyXJqqHKdhp9Kd2Me9dM43JzyhW7rPRdUB6RrVq5UZaCG2k/8mBjxo71RN
	 Ea5ihAAyocKEcPn8iDAccLRzt3CVmyavPyWz1yU+Jii5W7M7x/T8qRE2Q4Tw2vmA9G
	 k0+DqH8MTzVYQ==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56c1922096cso3187880a12.0;
        Fri, 29 Mar 2024 19:04:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUteDGZWoA6sK+H7DbS2bdDxnzA7X/zx/t/wniT+u3y0rrt2i6dgSQm/YtYYLIgGtCV2tbgXOoKmUaMOZJ1ESCFZQbcFdau1wwWJHu7yabGDApRpxszHhfR0SwSQGTCp8PDHMQrwncXaXgOKC7hKh1QRCuLv/x3ybOJLvXaFjGZ2LUXRQ==
X-Gm-Message-State: AOJu0YxIWtexKfeZLPn+Ma9FdWM1LjUnkomRp+Vtv0ML0rpk4N87dr0x
	EfIDbnrjIEuNyLc/hjv3vox/Dn46cpdYL02jPq2Ir8ShJMN58NSyKVuSmtCo0TwzSI0VeKLH5jC
	qNPp+oZeFQ4kDMj3Fps64PYNcNDY=
X-Google-Smtp-Source: AGHT+IEAADUQy1Sg8zrh0aqV8FJVSevq0sivP9tiRStv3WrBnwPhBx8S+J/NFVmwsTVNfNzXHqaKOtMTVuCQ2ahr0dM=
X-Received: by 2002:a50:a44a:0:b0:56b:a155:4b39 with SMTP id
 v10-20020a50a44a000000b0056ba1554b39mr2573169edb.28.1711764269734; Fri, 29
 Mar 2024 19:04:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_2E60E33C1F88A090B6B3A332AE528C6B8806@qq.com> <tencent_9B2484D4343EF1ED092E6A1F3A66E206C40A@qq.com>
In-Reply-To: <tencent_9B2484D4343EF1ED092E6A1F3A66E206C40A@qq.com>
From: Guo Ren <guoren@kernel.org>
Date: Sat, 30 Mar 2024 10:04:17 +0800
X-Gmail-Original-Message-ID: <CAJF2gTR8cb842GWa9Lpxz4y62ZtMumECOps8ojnZQx0TJMRxnQ@mail.gmail.com>
Message-ID: <CAJF2gTR8cb842GWa9Lpxz4y62ZtMumECOps8ojnZQx0TJMRxnQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/5] soc: canaan: Deprecate SOC_CANAAN and use
 SOC_CANAAN_K210 for K210
To: Yangyu Chen <cyy@cyyself.name>
Cc: linux-riscv@lists.infradead.org, Conor Dooley <conor@kernel.org>, 
	Damien Le Moal <dlemoal@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-gpio@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 6:00=E2=80=AFAM Yangyu Chen <cyy@cyyself.name> wrot=
e:
>
> Since SOC_FOO should be deprecated from patch [1], and cleanup for other
> SoCs is already in the mailing list [2,3,4], we remove the use of
> SOC_CANAAN and use ARCH_CANAAN for SoCs vendored by Canaan instead from n=
ow
> on. Thus, we should also change the Makefile here to use ARCH_CANAAN.
>
> Then, since we have introduced SOC_CANAAN_K210 for K210-specific drivers,
> we should replace its drivers depends on SOC_CANAAN_K210 and default sele=
ct
> when it has the symbol SOC_CANAAN_K210.
>
> [1] https://lore.kernel.org/linux-riscv/20221121221414.109965-1-conor@ker=
nel.org/
> [2] https://lore.kernel.org/linux-riscv/20240305-praying-clad-c4fbcaa7ed0=
a@spud/
> [3] https://lore.kernel.org/linux-riscv/20240305-fled-undrilled-41dc0c46b=
b29@spud/
> [4] https://lore.kernel.org/linux-riscv/20240305-stress-earflap-d7ddb8655=
a4d@spud/
>
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
> ---
>  drivers/soc/Makefile       | 2 +-
>  drivers/soc/canaan/Kconfig | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
> index ba8f5b5460e1..fb2bd31387d0 100644
> --- a/drivers/soc/Makefile
> +++ b/drivers/soc/Makefile
> @@ -7,7 +7,7 @@ obj-y                           +=3D apple/
>  obj-y                          +=3D aspeed/
>  obj-$(CONFIG_ARCH_AT91)                +=3D atmel/
>  obj-y                          +=3D bcm/
> -obj-$(CONFIG_SOC_CANAAN)       +=3D canaan/
> +obj-$(CONFIG_ARCH_CANAAN)      +=3D canaan/
>  obj-$(CONFIG_ARCH_DOVE)                +=3D dove/
>  obj-$(CONFIG_MACH_DOVE)                +=3D dove/
>  obj-y                          +=3D fsl/
> diff --git a/drivers/soc/canaan/Kconfig b/drivers/soc/canaan/Kconfig
> index 43ced2bf8444..3121d351fea6 100644
> --- a/drivers/soc/canaan/Kconfig
> +++ b/drivers/soc/canaan/Kconfig
> @@ -2,9 +2,9 @@
>
>  config SOC_K210_SYSCTL
>         bool "Canaan Kendryte K210 SoC system controller"
> -       depends on RISCV && SOC_CANAAN && OF
> +       depends on RISCV && SOC_CANAAN_K210 && OF
>         depends on COMMON_CLK_K210
> -       default SOC_CANAAN
> +       default SOC_CANAAN_K210
>         select PM
>         select MFD_SYSCON
>         help
> --
> 2.43.0
>
For coming k230:

Acked-by: Guo Ren <guoren@kernel.org>


--
Best Regards
 Guo Ren


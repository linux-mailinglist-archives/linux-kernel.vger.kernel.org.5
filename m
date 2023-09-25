Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 675B67AD381
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 10:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232937AbjIYIiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 04:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbjIYIiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 04:38:07 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0773CBC
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 01:38:01 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id a1e0cc1a2514c-7ab68ef45e7so1109412241.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 01:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1695631080; x=1696235880; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HFOxYCls0sYCllQ1mgWfAFcNmLca119HNJQDnS3pKX0=;
        b=SDP1DoBzvzwYbnJRlieHhizSkuCDEETS0D84IJHpahNqDZG7PiaE8KEAt9vmyeTGSu
         N+PuaG/iCAHsShw/9D3HHS8ozcc4TOButU19GQep8RG2JviUmAoywM67McpzRsz/SX5N
         THcXKqF/UwwurI+4Rsl0qfDK3L+P+OJMWRbasJHIWxzD3TgqE3vNCpO+N9H8fAYVEZta
         +H/LuXOMEqCq0gxr+AjgCBuP1XthUaE1Y2kKKy40x43JBlO0YL2gQogsW4V58X+xROX9
         LDVJYhDM2d4rduKDwGPW5fWwfH4+cYPGhllwFKRRkpRYrd0Pyyft0OO8GSWztaGr6yIn
         pSMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695631080; x=1696235880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HFOxYCls0sYCllQ1mgWfAFcNmLca119HNJQDnS3pKX0=;
        b=oV6YzX9tpnNDakwLpRUE9wI+yv+BheVjCFmGX8QIzVkiIFGnXAkeQE9CPoDPFkUMZS
         TQXLvHFLIh7ITaXNZ4ASciFMQ5KQMovkD/evmBnv8NdyrpCWcYuKbQPsRN7H5LAMv0pH
         u/KLE/hvz+UM0CFQbRRh2jfj8Z4lxFIjszSf/mVL5CEFsdXEELUKjjsm5wA+Kq2S+RGL
         WSpfz4bXHwuY0KR8uQgtBxuYMGRojhhPu3ZJroXeLr9YWxMpkTe8DzqQvOa9/Q50FZkk
         55Vi/WYljf0v6ejahgtmsMMGnvxDumtisiWN3Bpba2dkMrux8HD6p617xiLTIlnErECo
         qNdQ==
X-Gm-Message-State: AOJu0YyKsgwwqx0o7TawCMeM/p6G5PRJQJIPVwdtNgTKxXTK0NBsVUNR
        fItDFbX4vswmSO59/6khvKvxrjLmlRa2Jal9QbG5Lw==
X-Google-Smtp-Source: AGHT+IHkGvxBZdjvWDB0bY3ahVJKD7QgsZAYcsxr6/DnPpYZSXZcLVj7/mrRGoGE8MLghxAusQ1uPxPjGj+qcralCps=
X-Received: by 2002:a67:eb16:0:b0:452:6ac7:cdf with SMTP id
 a22-20020a67eb16000000b004526ac70cdfmr2100526vso.24.1695631080119; Mon, 25
 Sep 2023 01:38:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230911094604.14179-1-brgl@bgdev.pl>
In-Reply-To: <20230911094604.14179-1-brgl@bgdev.pl>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 25 Sep 2023 10:37:49 +0200
Message-ID: <CAMRc=Mc2Yo61uivOWHagR2Raxh11dBb=S6jtCDu8_-csX3ozvw@mail.gmail.com>
Subject: Re: [PATCH] hte: allow building modules with COMPILE_TEST enabled
To:     Dipen Patel <dipenp@nvidia.com>
Cc:     timestamp@lists.linux.dev, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 11:46=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Allow building all HTE modules with COMPILE_TEST Kconfig option enabled.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> This was part of a wider series but since this is independent, I'm sendin=
g
> it separately.
>
>  drivers/hte/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hte/Kconfig b/drivers/hte/Kconfig
> index cf29e0218bae..083e67492bf2 100644
> --- a/drivers/hte/Kconfig
> +++ b/drivers/hte/Kconfig
> @@ -16,7 +16,7 @@ if HTE
>
>  config HTE_TEGRA194
>         tristate "NVIDIA Tegra194 HTE Support"
> -       depends on ARCH_TEGRA_194_SOC
> +       depends on (ARCH_TEGRA_194_SOC || COMPILE_TEST)
>         help
>           Enable this option for integrated hardware timestamping engine =
also
>           known as generic timestamping engine (GTE) support on NVIDIA Te=
gra194
> @@ -25,7 +25,7 @@ config HTE_TEGRA194
>
>  config HTE_TEGRA194_TEST
>          tristate "NVIDIA Tegra194 HTE Test"
> -        depends on HTE_TEGRA194
> +        depends on (HTE_TEGRA194 || COMPILE_TEST)
>          help
>           The NVIDIA Tegra194 GTE test driver demonstrates how to use HTE
>           framework to timestamp GPIO and LIC IRQ lines.
> --
> 2.39.2
>

Hi Dipen!

Any comments on this, the other patch with a comment update as well as
the one addressing usage of gpiochip_find() in HTE drivers?

Bart

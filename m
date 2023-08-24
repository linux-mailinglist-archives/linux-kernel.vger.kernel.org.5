Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B52786976
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 10:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235718AbjHXIFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 04:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240474AbjHXIFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 04:05:21 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC5D1725
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 01:04:48 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id 71dfb90a1353d-48d0edd8a81so1621234e0c.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 01:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1692864287; x=1693469087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LiEv4XqC+7KuHP099o9BoI+4py4527eV//6q5pjiRJE=;
        b=E13rm5T5vcsam81LPUzwMKLwwRHQF+5UrjbeiVh6MlwbFu+j3LNZArr8E1Kn0Kv1Ko
         1H4UnU8iFu/bBCF2AYWy6qZ6kIJNcv494b9Uzh88U47y1YIbDXAsTmjw+iIOlcgMI5x3
         ebPDSrHspCjcOcyce10Sd3Tp/lBRaybhdpcGDZvJKm0WTNoDfjsTX9GGn1l4iIhzUcRI
         0W/1q8GUdvkBpIkDnz1AncIb98z8gNYZ7GUcA9xDMcwzuw5x3k7K4jNK7Z8jQo1V0NZz
         J1cpJwvMVPna8cQVsMOsp2PYj4YqP45UYLAMBSRuU678ERh7XU/5rg+kq1e7dzGrL2QQ
         a3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692864287; x=1693469087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LiEv4XqC+7KuHP099o9BoI+4py4527eV//6q5pjiRJE=;
        b=cKHs2Lqr+deSn8x8hKsKM35ZfcIjMy7nxe5ude5lhecGRm06BKb8gShHkpXgFliWAD
         xexbW32PoP8ejvNdvhEdNkAvJqPDR7rtX9ehcp/m4L0WBzj6bGLhuoqyLdV4lXUjjRTn
         XY6Bp3QsJJ9r5lkbl7JkELSOZiMdirUnnNw9wyUh3Qk18uFt93G/lMG6m2Qwx3XX9ux9
         YptxzKIKaGUfxuKOygLa3UZmNMLpxQ/GnzGHScQTp/mgHL1D7ZVF1ptkLMhrPLyVJFCw
         vUdb6w/tC5YdfoChbqaVg2wpICoWF/Fx4lUyYdoo3I/fO7IyWBI5XpKthzzYTwZ6aElM
         X1Jg==
X-Gm-Message-State: AOJu0Ywcvu/Q3p+8yUFVMLXeRGgye9ZQP5CrA1OaGogfOplcvIzsvf/0
        FybfxB56ICPrjI8HxrLj2YszZLr5UpOFszHnVYsbCQ==
X-Google-Smtp-Source: AGHT+IFWFkHg7eaqOaB86gkOgbNQfghPr9mXzXtCYBVN+jkZIKo2EEPebwD0aYA651pru1Qz76lZD0swwYS5O/Diuhw=
X-Received: by 2002:a1f:e783:0:b0:48f:9c75:411c with SMTP id
 e125-20020a1fe783000000b0048f9c75411cmr6190288vkh.6.1692864287288; Thu, 24
 Aug 2023 01:04:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230823085258.113701-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230823085258.113701-1-krzysztof.kozlowski@linaro.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 24 Aug 2023 10:04:36 +0200
Message-ID: <CAMRc=MfcRHhP5J2D9JCYfMkcRYBiTe-bfywEYVWtcv51HY=ERQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: mlxbf3: use capital "OR" for multiple licenses in SPDX
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Wed, Aug 23, 2023 at 10:53=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Documentation/process/license-rules.rst and checkpatch expect the SPDX
> identifier syntax for multiple licenses to use capital "OR".  Correct it
> to keep consistent format and avoid copy-paste issues.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> ---
>
> Rebased on next-20230822, so might not apply cleanly.  What does not
> apply, can be skipped and I will fix it after next RC.
> ---
>  drivers/gpio/gpio-mlxbf3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-mlxbf3.c b/drivers/gpio/gpio-mlxbf3.c
> index 0a5f241a8352..7a3e1760fc5b 100644
> --- a/drivers/gpio/gpio-mlxbf3.c
> +++ b/drivers/gpio/gpio-mlxbf3.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0-only or BSD-3-Clause
> +// SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause
>  /* Copyright (C) 2022 NVIDIA CORPORATION & AFFILIATES */
>
>  #include <linux/bitfield.h>
> --
> 2.34.1
>

Applied, thanks!

Bart

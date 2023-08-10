Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4AF7777B4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 13:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233131AbjHJL7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 07:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjHJL7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 07:59:39 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1E11BD
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 04:59:38 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fe700f9bf7so1215334e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 04:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691668777; x=1692273577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mGlcXxJFaDzWj7nYjjY5lTpTdKnxKA43Fs7dmJrROTs=;
        b=MgcrPbRar/l6oMGaHcTK0fQsW1WsDKCUJqefc0cvv5nHR/Akz0OGJdfuIj3f2F8FyS
         TAZQSJ7496YEzennxAZlORdOz90i9jtqSdrxTyT95BtsWyqoGhCsGd5RKQnrWRr1poPo
         kGVGGCIvnSg0Dsgr4tqIvSKK4pCu3/L+GVE6FmKQ1YofeYusngo9zj4y1pe/IeYxfh9j
         mLp5LB2m68wwpIg9f30gVj70D42ysLY9kFHolhwnR0GLa7tl4UiN27ETWDO18nHr26gY
         v2Eh9TL+pmJLaZI+NSvdpLVo2kpeWFwnc7HHdbRa3fwEYDV7z8aunJj2J40IXqVDJ5cH
         6TsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691668777; x=1692273577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mGlcXxJFaDzWj7nYjjY5lTpTdKnxKA43Fs7dmJrROTs=;
        b=By1JuYn0fN4jNSTsS8e1Tezc8w2AM19Q5ATndD99EmbZobx6WMojBjFuUgnRCNJG6t
         3LpEXCNn3XYrI6AtRSSDGMq3q1N8sLMtuGK/YqF7V/YFP3H0AJGoavZf3fp5EdBb5FIK
         6xsUCANO0M53VpXpqFsjblCJkhGt6wsht+b0hKNrAFI97UdjzttiCAjkmqCP2LIMmSrf
         IBzchmJ/wkbmkl/hvr7L3Vr6cien+k0jCwtqr8IBnC5oknxCkZPB7A3nD0PtuWY48Cw6
         OAsaR9ZZasf3WG7vxfzt/w92hKYrbTIaY/1ebr6OcQy2e7biG61QNa+5Fc9Hqu2vQhYc
         2WCQ==
X-Gm-Message-State: AOJu0YyTBRjn8tZAx1rX58JjR07kdZX+hjN8n1csk8vf3GSISJmn49hu
        zO6xuxVE5pc7Crxtu5O5SDFYo7nnJ8cLEj4Zyjw=
X-Google-Smtp-Source: AGHT+IHg3W7ELaCcpGiqNdn1wCp7CnSqQN7+z8TWLXhOqRX7hQeEr2WbxSEy5bu9iB91ID87BUT/uAOMSUxiD4zdQpY=
X-Received: by 2002:a05:6512:2821:b0:4fa:e7e5:66e0 with SMTP id
 cf33-20020a056512282100b004fae7e566e0mr2116706lfb.48.1691668775709; Thu, 10
 Aug 2023 04:59:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230810095923.123388-1-krzysztof.kozlowski@linaro.org> <20230810095923.123388-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230810095923.123388-2-krzysztof.kozlowski@linaro.org>
From:   Qiang Yu <yuq825@gmail.com>
Date:   Thu, 10 Aug 2023 19:59:23 +0800
Message-ID: <CAKGbVbv12K6NkRAe7jm7jueu6XCKyAkK+gmFia8ZxL7WH_h7zg@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/lima: fix Wvoid-pointer-to-enum-cast warning
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        lima@lists.freedesktop.org, Andi Shyti <andi.shyti@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Qiang Yu <yuq825@gmail.com>

On Thu, Aug 10, 2023 at 5:59=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> 'id' is an enum, thus cast of pointer on 64-bit compile test with W=3D1
> causes:
>
>   lima_drv.c:387:13: error: cast to smaller integer type 'enum lima_gpu_i=
d' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/gpu/drm/lima/lima_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/lima/lima_drv.c b/drivers/gpu/drm/lima/lima_=
drv.c
> index 10fd9154cc46..884181708de8 100644
> --- a/drivers/gpu/drm/lima/lima_drv.c
> +++ b/drivers/gpu/drm/lima/lima_drv.c
> @@ -384,7 +384,7 @@ static int lima_pdev_probe(struct platform_device *pd=
ev)
>         }
>
>         ldev->dev =3D &pdev->dev;
> -       ldev->id =3D (enum lima_gpu_id)of_device_get_match_data(&pdev->de=
v);
> +       ldev->id =3D (uintptr_t)of_device_get_match_data(&pdev->dev);
>
>         platform_set_drvdata(pdev, ldev);
>
> --
> 2.34.1
>

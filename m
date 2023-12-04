Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7FBA802CF2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 09:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234668AbjLDIRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 03:17:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjLDIRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 03:17:30 -0500
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95E4FE
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 00:17:36 -0800 (PST)
Received: by mail-ua1-x92a.google.com with SMTP id a1e0cc1a2514c-7c4bcb4e890so1450013241.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 00:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701677856; x=1702282656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cv3+u5Nr1+Y2iihnZ3hSatBIAhuecZToXeDGh+GJlpE=;
        b=CEt0M3LbMiLT0Oatr+I66PVQ1N92XKD1jJKM7LYOktmNqMWthQk4/jad5yvezvxTVB
         1lqOB3o919JrWJaK5IlzKVv+4Hb++5xmPxX9JXpcVxJBDdnVQ2QTPN3f/2aBBQvNa+Ar
         S51GToWvxdg0+HGyC7Ks+UH2RG8VlHvdGldPv7dSp+kIISJpxG2UIZ8yA/enr1HvL+oP
         bDxiejYUeSWVqwWtvfeAeb3bi+VJprzzxc4iMFzMQUaDbLfn9GlYeHBMLbj7O0j9tr6m
         ju4sOCScf99PnVGIfx+PLjVJJVaX6x2+EsUN9nk4AENyMsi71AiW4NttFLAcCIPKnQul
         fEhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701677856; x=1702282656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cv3+u5Nr1+Y2iihnZ3hSatBIAhuecZToXeDGh+GJlpE=;
        b=iv9LG+ZBzb2eeJCJwG3aNk+eSzyp8HR1UWhfz3hjie06am8qlenrS0MLN3eCg80AjZ
         a4qmGbcb7AG+9EgpAre2zfgE7R8Okgr4aNsphHKk1RtLRSIqVaex8jgAPTNAL2KVguOQ
         ySrsxImtDxGhlKQOwBF2XlTS93qBKySr/i1eCl4mCYURB5VEZT2GUNCZz5gjU1S5uS6T
         89oISgPfudfg39deW2rVd9MyFOQercMSrprYp9+yFVkTpskk2rEhHPLUmMwN8NJQU2ee
         zWw2x+YoNznW+NClgVI5q1fKRC4iOglwUMUuaD24o+2e5pf3nuV+aG4Y2pYL/OWlWnuz
         /lmw==
X-Gm-Message-State: AOJu0Yzx57LZME5RLupCt4n/BC9X4/5IIoFLOrMqtZt1mQP7rb2Lbam2
        N9x0VBawBbCrhgMGukVF4ci/LpFHAjS7EZl/NSsP/w==
X-Google-Smtp-Source: AGHT+IEFSa80B07cTwAmhpt40ecCmW1UM52sS0ruQH7XfF6sbBKQu+W0s56XmAPRzwmmQR5CnWl+0e+6m4sTSN9/1eA=
X-Received: by 2002:a05:6102:292b:b0:464:77f2:554 with SMTP id
 cz43-20020a056102292b00b0046477f20554mr1865442vsb.38.1701677855333; Mon, 04
 Dec 2023 00:17:35 -0800 (PST)
MIME-Version: 1.0
References: <20231201140840.323762-1-heiko@sntech.de>
In-Reply-To: <20231201140840.323762-1-heiko@sntech.de>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 4 Dec 2023 09:17:23 +0100
Message-ID: <CAMRc=McaQf+p1F3fP3pc8-icm1hjKv8VDLRAoXs5QGize1J=CQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: gpio: rockchip: add a pattern for gpio hogs
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linus.walleij@linaro.org, andy@kernel.org,
        linux-gpio@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        quentin.schulz@theobroma-systems.com,
        Heiko Stuebner <heiko.stuebner@cherry.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 1, 2023 at 3:08=E2=80=AFPM Heiko Stuebner <heiko@sntech.de> wro=
te:
>
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
>
> Allow validating gpio-hogs defined inside the gpio controller node.
>
> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
> ---
>  .../devicetree/bindings/gpio/rockchip,gpio-bank.yaml       | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/gpio/rockchip,gpio-bank.ya=
ml b/Documentation/devicetree/bindings/gpio/rockchip,gpio-bank.yaml
> index affd823c881d..d76987ce8e50 100644
> --- a/Documentation/devicetree/bindings/gpio/rockchip,gpio-bank.yaml
> +++ b/Documentation/devicetree/bindings/gpio/rockchip,gpio-bank.yaml
> @@ -41,6 +41,13 @@ properties:
>    "#interrupt-cells":
>      const: 2
>
> +patternProperties:
> +  "^.+-hog(-[0-9]+)?$":
> +    type: object
> +
> +    required:
> +      - gpio-hog
> +
>  required:
>    - compatible
>    - reg
> --
> 2.39.2
>

Applied, thanks!

Bart

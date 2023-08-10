Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7F377759E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 12:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbjHJKUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 06:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbjHJKUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 06:20:36 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36FC9F;
        Thu, 10 Aug 2023 03:20:35 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1bb782974f4so676716fac.3;
        Thu, 10 Aug 2023 03:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691662835; x=1692267635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GE4pGueQV8y2D52sbpZ8fiifhgsCMak0CFYGf7FSEn8=;
        b=kN8NaS4+IX1YhOzjYiU/j5C2QaBh8E/y0dbQJPAdxDg6sA2hgAX8id7Gvsmzycd3dE
         rPgFrPDWW7iIfkuWbz6ILJQQaYrSUNi/TNnK4wW8Cekxl9Fx7cACO5dAQr/yZipImDnc
         9PCds7NQ4Y/NIVUMdCEVhOybMTYjC9ltWg6uEENCPCO+DtWqu2Tl5/XY/3uuLpZSL6zV
         uI8pl/PKSybsDURl+tllZ2Wpf5EAdShSCf0L3e+wSNspEt/PJ71t1HKkwqndh9aAYRbB
         xjspt7Io3VRoU3d3/7pEUnjajOJeHaPgHOLJYFeEutawJYqKKiAgxkqxwvsALgDrJdhz
         yQuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691662835; x=1692267635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GE4pGueQV8y2D52sbpZ8fiifhgsCMak0CFYGf7FSEn8=;
        b=kuh/I4RVEcjL36qXVpOoZ+LFfcG8eza14pb1NMpzYTU+bYKPZ5dR16ZFRUzS83kYnp
         N0wb7jI217Bs16DfRt5UB/bXiuobDLh2f5SeOdKLTzX6GfafAXUTB3B0CtjbBIHloVf7
         l030Geo4XREbzDGoMOfhZuOdxe8iwiMBIa4d/PbRjU098cp9GxM9VEAe8p3eFKS1glTh
         eocfxMY0GIGcTxyGS0jcfgu0X80r9l/UGmsOONioOyxtdoEBmcIJ8CCnvz5+RbuiHs9p
         EYYyh7Cc7cZ/AcbwzFXYufoisWvFCoO+g4zyMHBYPNNyOIODUahXQJ1vn6vodRNxjiw7
         +rJw==
X-Gm-Message-State: AOJu0YwKHhEfyvoOCsqW4RQ2xcrAb63edH008r/gNhFxe4Jaft8yr5ng
        MDUBAhnz49D0hn839VKlgg119fmo9mVkhiOKlZo=
X-Google-Smtp-Source: AGHT+IEU7jrkjc7QYAUzq3EGr7+QEUmHLkcB26vZh5ZVEFdlzpiXV73KEuu5+NYKbWwq9rOVg5C1fI/h0emJ/fIlnk8=
X-Received: by 2002:a05:6870:a249:b0:1bb:b9d6:a879 with SMTP id
 g9-20020a056870a24900b001bbb9d6a879mr2203559oai.38.1691662835044; Thu, 10 Aug
 2023 03:20:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230810095949.123473-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230810095949.123473-1-krzysztof.kozlowski@linaro.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 10 Aug 2023 13:19:59 +0300
Message-ID: <CAHp75VdoXWrAfDqWHDdyqbmNjFaOCkA+frzR80TUi7xJymk1Zg@mail.gmail.com>
Subject: Re: [PATCH] gpio: mxs: fix Wvoid-pointer-to-enum-cast warning
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Andi Shyti <andi.shyti@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 12:59=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> 'devid' is an enum, thus cast of pointer on 64-bit compile test with W=3D=
1
> causes:
>
>   gpio-mxs.c:274:16: error: cast to smaller integer type 'enum mxs_gpio_i=
d' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

--=20
With Best Regards,
Andy Shevchenko

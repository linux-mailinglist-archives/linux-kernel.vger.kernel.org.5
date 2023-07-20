Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E2D75B259
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 17:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbjGTPUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 11:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjGTPUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 11:20:48 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F270132
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 08:20:47 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b8390003e2so13490251fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 08:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1689866445; x=1690471245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ylREXqkz3fT0Pf+CqfXaE+BQjJpH6bs6sgNBPlTXhI=;
        b=eLtIQlQmHqbxvCJnjDOWTgaHJOOwYT6srOrs0dZW1ZWqHoGrwm8XvGUBNGapJkhmEo
         qRHi3020i91UaAeF4aM9lWpHWLSPLNcFA93AJzVXmUMGpZ8cSQ/SENE6f1sT6ANl6IUW
         he/Zqsvc7eif7bgAdSAkiUSFL/Ib46IwGwLxw3A8nh7Q4MVt+h8GYconsoN1pUgPbMO2
         JsXHf73zr6z1MZq9e/mKaAsA4ua0543e70maFxBcxUoXzNz3al7Cb2geIt5Yu/dUOTxg
         37FvKICFIE3nrfIRyBPUBifW6/RacBrL0tw/osRdJ4NCcgKnFxheCocCHJYKs9vIsZbw
         15Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689866445; x=1690471245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ylREXqkz3fT0Pf+CqfXaE+BQjJpH6bs6sgNBPlTXhI=;
        b=NodssyRfDk3kP+KdZ44PH+XSpH/2FKN+uZOFcHNDbhBpuPvnm3PcHlW0FU9rvtitN4
         BevVWif/DpweXvIohqCfGm9C6FKmT/CmrFVh6eqQ+ZbX0khYfEvX2cdpCD98/bgs4+8y
         awy+AlIkdtlaZ/4Ry5WQiINhFb8LOM3isF47KfljUblBkYgpQDpFDXt6kaM0aYn2y9qm
         T13S1lpuO5dmbCTVAH1upIBl8vPkz5YjNulZxaPWwRfGub8NYhbxh67mTmCgDWTUhSLO
         BEV7uN+m2974gHHpnQkS9efb3g79lBUW4wPgm4cXcLJ7mN5lAXURygKMUNP2DEueYtgL
         vB4w==
X-Gm-Message-State: ABy/qLbtNl3UGN3f5yvQr+wqnwz6Kp23rJfNiBRzBCkv4f7OkyLuswjG
        of2TIjTmsehFz4D1C4gRBKUOgLuZgs/oBXnO42vdQQ==
X-Google-Smtp-Source: APBJJlGfNUWyNpCrqPbSIXlMquubbeynlWBhna2HQB+0ToDiza9YnGsEanbvJwHqlXirOL1qasExPLPfmhAzG13Kkgo=
X-Received: by 2002:a2e:b17b:0:b0:2b6:cbba:1307 with SMTP id
 a27-20020a2eb17b000000b002b6cbba1307mr2352594ljm.0.1689866445627; Thu, 20 Jul
 2023 08:20:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230712074553.35907-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230712074553.35907-1-krzysztof.kozlowski@linaro.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 20 Jul 2023 17:20:33 +0200
Message-ID: <CAMRc=Mf3G1NfwZv8nDdBMA2kqyuA77e2GS_OdU8uyxvfn6NhYQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: gpio: snps,dw-apb: allow gpio-line-names
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Hoan Tran <hoan@os.amperecomputing.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 9:45=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Allow the GPIO controller subnode to define GPIO names.  Already used in
> at least on DTS:
>
>   bitmain/bm1880-sophon-edge.dtb: gpio@50027000: gpio-controller@0: 'gpio=
-line-names' does not match any of the regexes: 'pinctrl-[0-9]+'
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/gpio/snps,dw-apb-gpio.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/gpio/snps,dw-apb-gpio.yaml=
 b/Documentation/devicetree/bindings/gpio/snps,dw-apb-gpio.yaml
> index b391cc1b4590..209f03bba0a7 100644
> --- a/Documentation/devicetree/bindings/gpio/snps,dw-apb-gpio.yaml
> +++ b/Documentation/devicetree/bindings/gpio/snps,dw-apb-gpio.yaml
> @@ -61,6 +61,10 @@ patternProperties:
>        '#gpio-cells':
>          const: 2
>
> +      gpio-line-names:
> +        minItems: 1
> +        maxItems: 32
> +
>        ngpios:
>          default: 32
>          minimum: 1
> --
> 2.34.1
>

Applied, thanks!

Bart

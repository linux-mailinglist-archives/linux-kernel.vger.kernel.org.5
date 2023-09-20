Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCD07A7ECB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 14:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235721AbjITMUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 08:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235662AbjITMUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 08:20:44 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CAB0C2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 05:20:38 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-579de633419so65887267b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 05:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695212437; x=1695817237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=icfLG5H8eTi62n974zbQOBumyTDPxZ0tIkv/dGGuSnE=;
        b=NWJetOD6hieXDwyYe4VUv7gKfrLQIL4WXFB+NXT8qAlQZ1WPYI2R2jryP5+jL2XXc9
         NXubIwF6zGnBxXhtBrM+YDU2/zp2DwhVNH0nn+s3R9yXEAZ9XdNCucvQBklnxTsvvtWi
         hTiJU4DyaVyXEuBwfDoQsLlcOaC+ZoyZsyPMUSJNMMF+gp7ekwl2zAHvPPKmxSp+LbkB
         SNI53UWNNMmY9aXg0BLYA+JwEzB9XGqQNIpmtyQyhQI66j59F1J8bRdSU5yqev+BZ2qX
         B8C3WuDEhyWIzrfmJrMQyyNg3YT7h8ITo4GbetK07nKfSeUgGiKt+aKHouzBqWE9sihx
         nIJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695212437; x=1695817237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=icfLG5H8eTi62n974zbQOBumyTDPxZ0tIkv/dGGuSnE=;
        b=izAAi9L/Ro1Mm3EWughg8fTewaaXI3al5oo7GT/uFHqOcedr254qDv0TF7Pd3v8BQ/
         xtp8/tRLjb0+3c54Ew62w773oUHE9PHx2kvFdTFbD6WqlL1z7KoFrue0ndxbeyoxjovr
         Z6wQWxxG+bTzqnFHcVV1Aryuvzt6ghxNJNF/kVv7VKa90F2r2zHm3cXdC9LKHgmeVsMS
         B6v44MdJXx6IsXknhyc7QEP1wPbCfjrce1z6R9hpAmH0vZKAwhw7pm7Ha3n2DHMZQEHG
         sGUuoHeRHmCj41+eX+WOIdqQ6MnHI69ZJmbuFXB3mQt2T4bN/ZCJCtUiguaY1dkgD89F
         RKVA==
X-Gm-Message-State: AOJu0Yy+73nKxcVQP4B5e9UZyfajVHYgC9BlMO8aFkJdTv+VYc8PuXS0
        D1a0K9FFXzXXHHKltUPn40s3c3qHgDZxOkDOs2Muwg==
X-Google-Smtp-Source: AGHT+IFyUZxYn0JQYUy1iX3y9vfw4pnRnYeviVC7XxZvc1tNsed4UZQiiuXsKZpeKzd6+jIUMAlPZFXzZTLP7sT1k/A=
X-Received: by 2002:a81:6dc7:0:b0:577:3eaa:8d97 with SMTP id
 i190-20020a816dc7000000b005773eaa8d97mr2486266ywc.17.1695212437107; Wed, 20
 Sep 2023 05:20:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230918123355.262115-1-biju.das.jz@bp.renesas.com> <20230918123355.262115-3-biju.das.jz@bp.renesas.com>
In-Reply-To: <20230918123355.262115-3-biju.das.jz@bp.renesas.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 20 Sep 2023 14:20:26 +0200
Message-ID: <CACRpkdYYKAFLvpKH0ih5qZVbv7L3auny5WWx+qKa_HD1o-vsog@mail.gmail.com>
Subject: Re: [PATCH 2/2] pinctrl: renesas: rzg2l: Enable noise filter for GPIO
 interrupt input
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        Biju Das <biju.das.au@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 2:34=E2=80=AFPM Biju Das <biju.das.jz@bp.renesas.co=
m> wrote:

> As per RZ/G2L hardware manual Rev.1.30 section 8.7.3 GPIO Interrupt (TINT=
)
> and 41.4.1 Operation for GPIO function, we need to set digital noise
> filter for GPIO interrupt.
>
> This patch enables noise filter for GPIO interrupt in
> rzg2l_gpio_irq_enable() and disable it in rzg2l_gpio_irq_disable().
>
> Fixes: db2e5f21a48e ("pinctrl: renesas: pinctrl-rzg2l: Add IRQ domain to =
handle GPIO interrupt")
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Why is this called "digital noise filter" when the rest of the world calls
it "debounce"? It is a bit confusing to have differing terminology in the
kernel.

(There might be a good reason, such that the noise in question is very
different from mechanical button bounce noise.)

Is this only applicable to interrupt lines or also to GPIO lines in
general? Because I just want to ascertain that in that case
the existing binding for @PIN_CONFIG_INPUT_DEBOUNCE
and the corresponding backend call from gpio_chip() maps
to the same feature as well.

It seems hard-coded for some pins in the Renesas driver right
now but the day you make this configurable from DT please
call it debounce, if the usecase is similar.

Yours,
Linus Walleij

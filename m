Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738017B9E26
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbjJEN7M convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 5 Oct 2023 09:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbjJEN5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 09:57:10 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2934672BC;
        Thu,  5 Oct 2023 00:10:56 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5a21ea6baccso7249477b3.1;
        Thu, 05 Oct 2023 00:10:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696489853; x=1697094653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kyrdbpuLHB24ipYr+nJjPhE8QlUpRf2FnFEE0De7zV4=;
        b=YRIXubiyCCYR+2uM9V/2Sia6j+a1A4F2bIEJeGmq5XHkbFFhHA5C5b2e9xQ7R20vPO
         zPxzp+++293nE5O2QVXLmt2t6ffFPlBEAliMau8tmgEE9rENuJ84nSIzeceUO3bYqlfl
         zK0T31Pem5qAkVNVVnj0BDcp0/MhndIfCZSqWVpkAx9793+5Uow1ftNBexLNZm0qmKKP
         sQ3R/5Np7PJYQjsdR/MdpFUxPQQ6HqOEngaInbcc2/HQ/mkVorj01fFMf+3zxhBNmLDZ
         Dh62QTwnsRRROs+XkU3X1lLmBCWYXXEygq8slnCG5W1YQQmYzZ3LxYKNHVc+TPlKqPOq
         67LA==
X-Gm-Message-State: AOJu0YwFQskM8Fbhy5dOqeGln67r0we60BBM1W7YXYOaNCGmJLiNgSe5
        aEv7YlYbNyb99OM/S6KxnInJJe8jPuytmA==
X-Google-Smtp-Source: AGHT+IFdTKrKPAls6e1+0i2Og0vYKYUs57GQzTcJHaJMr4Onqg9GWE95nwBg2jAzKiXQbzzLSFB4Dg==
X-Received: by 2002:a0d:cbd3:0:b0:578:5e60:dcc9 with SMTP id n202-20020a0dcbd3000000b005785e60dcc9mr4462229ywd.10.1696489853207;
        Thu, 05 Oct 2023 00:10:53 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id n184-20020a0de4c1000000b005a4d922cf77sm315914ywe.119.2023.10.05.00.10.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Oct 2023 00:10:52 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5a21ea6baccso7249337b3.1;
        Thu, 05 Oct 2023 00:10:52 -0700 (PDT)
X-Received: by 2002:a81:a187:0:b0:59b:f152:8998 with SMTP id
 y129-20020a81a187000000b0059bf1528998mr4833243ywg.19.1696489852617; Thu, 05
 Oct 2023 00:10:52 -0700 (PDT)
MIME-Version: 1.0
References: <20231004200008.1306798-1-ralph.siemsen@linaro.org>
In-Reply-To: <20231004200008.1306798-1-ralph.siemsen@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 5 Oct 2023 09:10:39 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVEhVX8bcCVNYRuzdOpiW64dBELJp0ncdYsZUg4LLFLeA@mail.gmail.com>
Message-ID: <CAMuHMdVEhVX8bcCVNYRuzdOpiW64dBELJp0ncdYsZUg4LLFLeA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: renesas: rzn1: enable PINMUX
To:     Ralph Siemsen <ralph.siemsen@linaro.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ralph,

On Wed, Oct 4, 2023 at 10:00 PM Ralph Siemsen <ralph.siemsen@linaro.org> wrote:
> Enable pin muxing (eg. programmable function), so that the RZN1 GPIO
> pins will be configured as specified by the pinmux in the DTS.
>
> This used to be enabled implicitly via CONFIG_GENERIC_PINMUX_FUNCTIONS,
> however that was removed in 308fb4e4eae14e6189dece3b7cf5b5f453c5d02

You missed the first character of the commit ID.

> since the rzn1 driver does not call any of the generic pinmux functions.
>
> Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>

Fixes: 1308fb4e4eae14e6 ("pinctrl: rzn1: Do not select
GENERIC_PIN{CTRL_GROUPS,MUX_FUNCTIONS}")

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-pinctrl-fixes-for-v6.6...

> --- a/drivers/pinctrl/renesas/Kconfig
> +++ b/drivers/pinctrl/renesas/Kconfig
> @@ -234,6 +234,7 @@ config PINCTRL_RZN1
>         bool "pin control support for RZ/N1"
>         depends on OF
>         depends on ARCH_RZN1 || COMPILE_TEST
> +       select PINMUX
>         select GENERIC_PINCONF

... with alphabetical sort order restored.
No need to resend.

>         help
>           This selects pinctrl driver for Renesas RZ/N1 devices.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C2D760C61
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 09:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbjGYHuU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 25 Jul 2023 03:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232837AbjGYHuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 03:50:15 -0400
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FD918F;
        Tue, 25 Jul 2023 00:50:12 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-d124309864dso1506544276.3;
        Tue, 25 Jul 2023 00:50:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690271411; x=1690876211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EqNUObKtnWU7CrTgMoTHsyHzfdm6+8QmUNqv2A2543c=;
        b=W25unTmO+RfycN1l8WT7ryXU9FBMgt7QOmIwLHM1iX69xrN9udUj/2TaLbbJqXBTRi
         PJNgqYgQ76p9Iu3ygzYVoCl7hdEsCGBgG9u4R04ZWvUluliOKI3NhZNwfznVVmgJrMg3
         0IeHjRhd9HfdX7tDDuHRaoMqlPe068WvI4S0T90rtjG9PyjrTW4E5Z9DCb90VA//mX88
         4/UIO0iO+X3BHknO3LwiI+lEie2sWFl0NjQcwPoDvGlwdqAKZlu3h3+LyvKHbuZtZY7d
         yG8vkLQTJgRRYfOqn48z2Py42wN4EtL0XhAmZOpGGJT68sofqv6gvMhyld4RemnfLSnM
         g0QQ==
X-Gm-Message-State: ABy/qLasU/fcRjrSLC9l5iUV7/7NIrLi69gd6mlaDiB8kqy/W3HFtBfz
        XJfqJruz4wKDR4nP92hYC/U69D9lC+uvmQ==
X-Google-Smtp-Source: APBJJlElEeLzNDkqVv5Ha6SmFKBNhkmPkkd9zzOFXmZaCX/hlW8q997P44WTi7zH3O0d0LBIVjpn2Q==
X-Received: by 2002:a81:4602:0:b0:562:16d7:e6eb with SMTP id t2-20020a814602000000b0056216d7e6ebmr7561645ywa.40.1690271410776;
        Tue, 25 Jul 2023 00:50:10 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id j187-20020a816ec4000000b0058038e6609csm3372000ywc.74.2023.07.25.00.50.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 00:50:10 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-c5f98fc4237so4431004276.2;
        Tue, 25 Jul 2023 00:50:10 -0700 (PDT)
X-Received: by 2002:a25:dfc8:0:b0:d0d:cd30:3967 with SMTP id
 w191-20020a25dfc8000000b00d0dcd303967mr5769959ybg.51.1690271410365; Tue, 25
 Jul 2023 00:50:10 -0700 (PDT)
MIME-Version: 1.0
References: <a4a586337d692f0ca396b80d275ba634eb419593.1690058500.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <a4a586337d692f0ca396b80d275ba634eb419593.1690058500.git.christophe.jaillet@wanadoo.fr>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 25 Jul 2023 09:49:58 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW-Dp0TLixZMOcZfe9U05GKZY7S-wvNGCvzL=WVeZWeWw@mail.gmail.com>
Message-ID: <CAMuHMdW-Dp0TLixZMOcZfe9U05GKZY7S-wvNGCvzL=WVeZWeWw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: renesas: rzg2l: Use devm_clk_get_enabled() helper
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

On Sat, Jul 22, 2023 at 10:42 PM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
> The devm_clk_get_enabled() helper:
>    - calls devm_clk_get()
>    - calls clk_prepare_enable() and registers what is needed in order to
>      call clk_disable_unprepare() when needed, as a managed resource.
>
> This simplifies the code and avoids the need of a dedicated function used
> with devm_add_action_or_reset().
>
> While at it, use dev_err_probe() which filters -EPROBE_DEFER.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Thanks for your patch!

> --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> @@ -1471,11 +1471,6 @@ static int rzg2l_pinctrl_register(struct rzg2l_pinctrl *pctrl)
>         return 0;
>  }
>
> -static void rzg2l_pinctrl_clk_disable(void *data)
> -{
> -       clk_disable_unprepare(data);
> -}
> -
>  static int rzg2l_pinctrl_probe(struct platform_device *pdev)
>  {
>         struct rzg2l_pinctrl *pctrl;
> @@ -1501,33 +1496,16 @@ static int rzg2l_pinctrl_probe(struct platform_device *pdev)
>         if (IS_ERR(pctrl->base))
>                 return PTR_ERR(pctrl->base);
>
> -       pctrl->clk = devm_clk_get(pctrl->dev, NULL);
> -       if (IS_ERR(pctrl->clk)) {
> -               ret = PTR_ERR(pctrl->clk);
> -               dev_err(pctrl->dev, "failed to get GPIO clk : %i\n", ret);
> -               return ret;
> -       }
> +       pctrl->clk = devm_clk_get_enabled(pctrl->dev, NULL);

clk can become a local variable now.

> +       if (IS_ERR(pctrl->clk))
> +               return dev_err_probe(pctrl->dev, PTR_ERR(pctrl->clk),
> +                                    "failed to get GPIO clk\n");

failed to enable

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-clk-for-v6.6 with the above changes.
No need to resend.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

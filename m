Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCAE811429
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 15:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379055AbjLMOGs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 13 Dec 2023 09:06:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233539AbjLMOGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 09:06:45 -0500
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB4310C;
        Wed, 13 Dec 2023 06:06:51 -0800 (PST)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dbcb4747d84so2105998276.2;
        Wed, 13 Dec 2023 06:06:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702476410; x=1703081210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AHtA4+5hw0ZCgkf626DbpUSnNmhCHpzTn/EppkNnPGk=;
        b=STodZEAY1ZRbWScTqLUVmPUu6JqByrHbYPfhiL2r5O6ywVTrNKlkkmA9dhpLSG6rxz
         sZlb/PBEH+OwAd9leAa4OUTmWQQ2W7ZcYEkJXGZgk/GRLjeR8pJm2LKjGORdIp9d4bOQ
         c2JgvFj/rZeAY5JbhUlPki6L+HryTsT677mLZVQm0IBmY1Jxeg7HKQAz1/5IOd+0NQdi
         xcJtQC3xZTnZxONx8WEXel5U4MfFUo+BElNYn8x49TyLlUh4bc7HiqIdfIV0ikZiKuGi
         6kVMAY5kaeO+nUWfenMFhCiWJUe1O0thSCjgnzTb/xI0WS+rp7G1RhdYRJsK3u4UZlp/
         YNxg==
X-Gm-Message-State: AOJu0Ywa4vCQqN+nYsGyGEKxhigLW607yx30ZTdToRsO2wGy853C11sl
        lxhearvoCfGPkP7c5ylxZE+bmAdbd7oEEg==
X-Google-Smtp-Source: AGHT+IE/kSD4AerLImjJX51M2asFtS1RA6vUj5HhlglpmC7xw/mk9qcxuBMk48TxRahJipNvY1aulg==
X-Received: by 2002:a25:424e:0:b0:dbc:d05a:18a9 with SMTP id p75-20020a25424e000000b00dbcd05a18a9mr563828yba.55.1702476410177;
        Wed, 13 Dec 2023 06:06:50 -0800 (PST)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id p135-20020a25d88d000000b00dbccd3a2d02sm581815ybg.55.2023.12.13.06.06.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 06:06:50 -0800 (PST)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5cbcfdeaff3so69862747b3.0;
        Wed, 13 Dec 2023 06:06:49 -0800 (PST)
X-Received: by 2002:a0d:d3c6:0:b0:5d7:1940:f3f1 with SMTP id
 v189-20020a0dd3c6000000b005d71940f3f1mr7064945ywd.89.1702476409703; Wed, 13
 Dec 2023 06:06:49 -0800 (PST)
MIME-Version: 1.0
References: <20231207070700.4156557-1-claudiu.beznea.uj@bp.renesas.com> <20231207070700.4156557-11-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20231207070700.4156557-11-claudiu.beznea.uj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 13 Dec 2023 15:06:37 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXD4WO-LR02wOgd3SsQ8Rfb+SUErUTcO7wPhAdyb-NF_A@mail.gmail.com>
Message-ID: <CAMuHMdXD4WO-LR02wOgd3SsQ8Rfb+SUErUTcO7wPhAdyb-NF_A@mail.gmail.com>
Subject: Re: [PATCH v2 10/11] arm64: renesas: rzg3s-smarc-som: Use switches'
 names to select on-board functionalities
To:     Claudiu <claudiu.beznea@tuxon.dev>
Cc:     s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        magnus.damm@gmail.com, mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, prabhakar.mahadev-lad.rj@bp.renesas.com,
        biju.das.jz@bp.renesas.com, linux-renesas-soc@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 7, 2023 at 8:08 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> The intention of the SW_SD0_DEV_SEL and SW_SD2_EN macros was to reflect the
> state of SW_CONFIG individual switches available on the RZ/G3S Smarc Module
> and at the same time to have a descriptive name for the switch itself.
> Each individual switch is associated with a signal name, which might be
> active-low or not on the board. Using signal names instead of SW_CONFIG
> switch names may be confusing for a user who just playes with switches to
> select individual functionalities, but also for the advanced user that
> looks over schematics. To avoid even further confusions, use the switches'
> names here and instantitate them with an ON/OFF state. This should be
> simpler, even though the name of the switch is not that intuitive. The
> switch names documentation reflects the switch's purpose.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Changes in v2:
> - this patch is new and aims to replace patch "arm64: renesas: rzg3s-smarc-som:
>   Invert the logic of the SW_SD2_EN macro" from v1

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.8.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

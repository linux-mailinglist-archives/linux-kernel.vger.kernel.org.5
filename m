Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC152801131
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378351AbjLAQV6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 1 Dec 2023 11:21:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjLAQV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 11:21:56 -0500
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3ACD50;
        Fri,  1 Dec 2023 08:22:03 -0800 (PST)
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-58d9a4e9464so1144496eaf.0;
        Fri, 01 Dec 2023 08:22:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701447722; x=1702052522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XMzJQkWl3UCqt9MwlcLP28F/WjmJ8PvNuz3o00YLjoc=;
        b=AhEECuELoNFQJOyh58mkZdZ/MP+HM3W6XTkhM9vyTB+4sMMXQkvBB/+aqPSJng36Br
         M/K1qM1u5B4YAgRa7CYisnCAZ4BhjnrDGcNlK9PT03HbmCc9I6FAV7bMMbpqbb+R4AAK
         OOKcmhKpCH7S7qzqzoTZZIeYL8+GhR64twRfsY8ILBdTVgXKPCF4FCVfRRZLGKJlLz9g
         kDfSVacrVANTjDohkes8V++sC3M80gIO/AOeSQZ6Vul/diPYGO42w7JhCFC+pR5jfkuR
         EjKMLcT0aVPshSaF+BqKqNIxmTj+WPChYXUqezbC3cAr1pe1ORHHpsNobT/+CqeCibpd
         /uMQ==
X-Gm-Message-State: AOJu0Yw/MqX9xBpST/cgl6INpOxtA5OTMYSqjN4InAof/yXDqj+gl4VM
        xD92a+OPRI8cg0nEhr50kwheSrIfGLLTkA==
X-Google-Smtp-Source: AGHT+IEeTn1ywH3y2w92NrZfUJmeikZUGwFBsI/ecRejWx/2yva3XMTPLWpF6EsizqYwR2k7A9w9Zg==
X-Received: by 2002:a4a:621e:0:b0:58d:b174:9af6 with SMTP id x30-20020a4a621e000000b0058db1749af6mr3301490ooc.3.1701447722143;
        Fri, 01 Dec 2023 08:22:02 -0800 (PST)
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com. [209.85.160.43])
        by smtp.gmail.com with ESMTPSA id v3-20020a4a3143000000b0058d592deb89sm620159oog.17.2023.12.01.08.22.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Dec 2023 08:22:00 -0800 (PST)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-1fa21f561a1so361498fac.3;
        Fri, 01 Dec 2023 08:22:00 -0800 (PST)
X-Received: by 2002:a81:5258:0:b0:5d3:4923:2fed with SMTP id
 g85-20020a815258000000b005d349232fedmr5600759ywb.36.1701447366859; Fri, 01
 Dec 2023 08:16:06 -0800 (PST)
MIME-Version: 1.0
References: <20231120070024.4079344-1-claudiu.beznea.uj@bp.renesas.com> <20231120070024.4079344-6-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20231120070024.4079344-6-claudiu.beznea.uj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 1 Dec 2023 17:15:55 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWJJ=pjY5YFG=UxL+rWhYtWKicjbGUj-7KC1tgaz4tB3Q@mail.gmail.com>
Message-ID: <CAMuHMdWJJ=pjY5YFG=UxL+rWhYtWKicjbGUj-7KC1tgaz4tB3Q@mail.gmail.com>
Subject: Re: [PATCH 05/14] pinctrl: renesas: rzg2l: Move arg in the main
 function block
To:     Claudiu <claudiu.beznea@tuxon.dev>
Cc:     s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux@armlinux.org.uk, magnus.damm@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, p.zabel@pengutronix.de, arnd@arndb.de,
        m.szyprowski@samsung.com, alexandre.torgue@foss.st.com, afd@ti.com,
        broonie@kernel.org, alexander.stein@ew.tq-group.com,
        eugen.hristev@collabora.com, sergei.shtylyov@gmail.com,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        biju.das.jz@bp.renesas.com, linux-renesas-soc@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Claudiu,

On Mon, Nov 20, 2023 at 8:01 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Move arg in the main block of the function as this is used by 3 out of 4
> case blocks of switch-case. In this way some lines of code are removed.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Thanks for your patch!

>  drivers/pinctrl/renesas/pinctrl-rzg2l.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

Unfortunately your claim is not really backed by the diffstat.
What about moving index, too?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

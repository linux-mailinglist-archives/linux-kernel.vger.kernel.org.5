Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7867D7A1FA9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 15:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235265AbjIONSS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 15 Sep 2023 09:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235230AbjIONSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 09:18:16 -0400
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07651FF5;
        Fri, 15 Sep 2023 06:18:07 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-d818d4230f6so1883641276.1;
        Fri, 15 Sep 2023 06:18:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694783887; x=1695388687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PeKCNpXC9U5SuiucQeYE4o7+yLWv2iuRbCuYbucPsys=;
        b=HhbARRwG6pGLenRsfRVK1DRsXInO90Y+uHuh1dXtG4kFM54k8E9SAAZBnLOC4fEd5i
         yFLGNPqUiLxEsT/1AHD5QCGe/69VK6zyEVUrEtvgQcNnW+oAB71b6yljRj5hY1YhLTby
         /bl6MJQhOt0HGKFrppRhcIZuOQLI/0/LjW7xWzb21jUGtNUDkPkVH+qu8KHvTkNJPi7h
         Ms6o93R66j2zRD6iOb99RycCtuqt/4Os5XnG2xwe8IDk05K3Qwf1bg5qnfo04nBQft4k
         xBNNUsiNQ+xFYx7LD8YfHxfZSD2BlJkwJj4hzmCLq4qJUzebCysreg6WmK0BjA0OSRNC
         xoHg==
X-Gm-Message-State: AOJu0YwgLstFz1WzWSLUKQkpWI8mvo8bW2Ns78qmehJ8vebjNxFIk8OE
        rhCfpcj929GdrSpGbHL15wvG8hX3U74TZA==
X-Google-Smtp-Source: AGHT+IHi5NwStPEFiXr2DeAA/8mmuRjTvMQrnR5xW0xK38OM2hoNnXPktwr+VZoh+xqC8Iz6C+oWsg==
X-Received: by 2002:a25:29c3:0:b0:cec:81af:cf92 with SMTP id p186-20020a2529c3000000b00cec81afcf92mr1560066ybp.36.1694783886700;
        Fri, 15 Sep 2023 06:18:06 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id m18-20020a259e12000000b00d7badcab84esm779931ybq.9.2023.09.15.06.18.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 06:18:06 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-d8168d08bebso2122326276.0;
        Fri, 15 Sep 2023 06:18:06 -0700 (PDT)
X-Received: by 2002:a25:adc2:0:b0:d04:fc64:350 with SMTP id
 d2-20020a25adc2000000b00d04fc640350mr1727370ybe.2.1694783886095; Fri, 15 Sep
 2023 06:18:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com> <20230912045157.177966-33-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20230912045157.177966-33-claudiu.beznea.uj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 15 Sep 2023 15:17:53 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVv3uL+cF5YYNAmJ7wMoT4HuyaOYndndZZ-jPuVE3fQqQ@mail.gmail.com>
Message-ID: <CAMuHMdVv3uL+cF5YYNAmJ7wMoT4HuyaOYndndZZ-jPuVE3fQqQ@mail.gmail.com>
Subject: Re: [PATCH 32/37] arm64: dts: renesas: add initial DTSI for RZ/G3S SoC
To:     Claudiu <claudiu.beznea@tuxon.dev>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        magnus.damm@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        biju.das.jz@bp.renesas.com, quic_bjorande@quicinc.com,
        arnd@arndb.de, konrad.dybcio@linaro.org, neil.armstrong@linaro.org,
        nfraprado@collabora.com, rafal@milecki.pl,
        wsa+renesas@sang-engineering.com,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 6:53 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Add initial DTSI for RZ/G3S SoC. Files in commit has the following
> meaning:
> r9a08g045.dtsi          RZ/G3S family SoC common parts
> r9a08g045s33.dtsi       RZ/G3S R0A08G045S33 SoC specific parts
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

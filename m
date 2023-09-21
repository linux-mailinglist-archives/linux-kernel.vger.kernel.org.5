Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 943F57A99A6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 20:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjIUSQp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 21 Sep 2023 14:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbjIUSQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:16:27 -0400
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17CE5AE2E;
        Thu, 21 Sep 2023 10:21:40 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-52f9a45b4bdso1423259a12.3;
        Thu, 21 Sep 2023 10:21:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316899; x=1695921699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=78TMJJFlsLVACVaST0yD4fr1cOAvW144T6j75QycuXg=;
        b=BAV30hJkYC7gDJg8tJ5MgmwgAeTItbBEzWUcixCeM/pAGaCgaQ8iMiyn0XLG6VH9AG
         ATLhbdtVyCC4KBdQdSsCTH0JJXuR7XVOSpV3URxP7TbirqHqYFRHRbBWD7+I3DjzCUZ0
         iu65ni8UHH5hJfVmugdCvjEeqTP4zFi4RxIie6MPXhe9eTmsLORXD/5wosNIUBMifG9j
         lSBCLxcxr0nbNY41dJQU3tqmp4sKBbaCaM27tuidbCQzJUwFo7JleTbtt8kmem84QoDV
         zKqJa3Leqv9IUbhA64LQUI3GFTuCZ4samvzOPMyY2jFjLR5XbI/opUALhieLgtJd7xXY
         YUKA==
X-Gm-Message-State: AOJu0Yy11+ifoLtQMj0zsVqtcJIIdGl/qpKcTULNtlXmQqyT9qQ/0DL6
        JbaLbcnQYqAHQbj57DOkw4bWirx05e9jlYr9
X-Google-Smtp-Source: AGHT+IH+uBVw292r+sxaKfU8NLmvm5e2Jkc2m0Sb1GJILXn42+85/1qKFwBKoGAB4t0PUKVC9cnpbw==
X-Received: by 2002:a2e:8098:0:b0:2c0:c6a:eb2f with SMTP id i24-20020a2e8098000000b002c00c6aeb2fmr5027753ljg.1.1695302182923;
        Thu, 21 Sep 2023 06:16:22 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id p2-20020a2e9a82000000b002c001e57e1asm337469lji.73.2023.09.21.06.16.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 06:16:22 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2c007d6159aso15303351fa.3;
        Thu, 21 Sep 2023 06:16:22 -0700 (PDT)
X-Received: by 2002:a05:6512:3987:b0:500:bb99:69a7 with SMTP id
 j7-20020a056512398700b00500bb9969a7mr6201266lfu.14.1695301737311; Thu, 21 Sep
 2023 06:08:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com> <20230912045157.177966-29-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20230912045157.177966-29-claudiu.beznea.uj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 21 Sep 2023 15:08:39 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV5BuPPLkZUDfhjXzq_aQ+LFfEM=eXGT-XjmpxSjSqeJg@mail.gmail.com>
Message-ID: <CAMuHMdV5BuPPLkZUDfhjXzq_aQ+LFfEM=eXGT-XjmpxSjSqeJg@mail.gmail.com>
Subject: Re: [PATCH 28/37] pinctrl: renesas: rzg2l: make struct
 rzg2l_pinctrl_data::dedicated_pins constant
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
> struct rzg2l_pinctrl_data::dedicated_pins is constant thus mark it so.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-pinctrl-for-v6.7.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

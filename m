Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B41D97B8007
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 14:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242519AbjJDM7R convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 4 Oct 2023 08:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242362AbjJDM7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 08:59:16 -0400
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514A9A6;
        Wed,  4 Oct 2023 05:59:13 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-d89491dab33so2182655276.0;
        Wed, 04 Oct 2023 05:59:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696424352; x=1697029152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NbgEznJD4TxRTKE9Bc/b9u/1IzvkC4JvJP2YJ9vkopw=;
        b=lfQDhnsxLgTrB6jRezT4dlsiS8wJcq7AoYIJYW3laTnz/YpghgpVJ03noGdXDdvzrb
         uu0af5RaEqQxiei0bS55IcGuJi7i/bOA0HPYDyB8witJlU5M/okkbtiRn0A5+zXzePO4
         OCxf+fkmTYSCXW+Vfq0tbyKVUcIdHngBaBIzvG1rZHNNdCpaMzA3i0Mu4i3jsm9ADp5F
         bKonSOOkXdaJXpqP0KHGeJ7Ft0vKHWC+CQdNLKN2IvPwIxEtxtMqzNWd8w3H2dO+fkQj
         KJRu6j2dX9se1fLB2G8AOxdCyS4sBLko4aPqJJZ+G7AiFI9hjE1vH29tL+Thd7xBWpZ8
         b64Q==
X-Gm-Message-State: AOJu0YynTpl8aYZzbK1iymrf2tDZODRF7gs83eHUahDA4KmDF1LhM0EJ
        3vibofHfTKOjQ/4JIFtqeHUwlDsYBacsmg==
X-Google-Smtp-Source: AGHT+IGsis2eiRNkfZaBiG2hxgU5EHbRXHs/4ge/BaczYf4peAUMgu7vCUyhU9CY1OPC5qOqHo2WOg==
X-Received: by 2002:a25:d8cb:0:b0:d85:aa2f:5718 with SMTP id p194-20020a25d8cb000000b00d85aa2f5718mr1954416ybg.51.1696424351950;
        Wed, 04 Oct 2023 05:59:11 -0700 (PDT)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id x7-20020a5b0287000000b00d7b9fab78bfsm1011959ybl.7.2023.10.04.05.59.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 05:59:11 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-59f6041395dso25233857b3.1;
        Wed, 04 Oct 2023 05:59:11 -0700 (PDT)
X-Received: by 2002:a81:c24d:0:b0:58f:bda3:8dd with SMTP id
 t13-20020a81c24d000000b0058fbda308ddmr2392331ywg.32.1696424351066; Wed, 04
 Oct 2023 05:59:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230929053915.1530607-1-claudiu.beznea@bp.renesas.com> <20230929053915.1530607-17-claudiu.beznea@bp.renesas.com>
In-Reply-To: <20230929053915.1530607-17-claudiu.beznea@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 4 Oct 2023 14:58:58 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXv6-u6zktHe_cUOKpWnzyLRRowdjQRWv42GMnx1pkKjQ@mail.gmail.com>
Message-ID: <CAMuHMdXv6-u6zktHe_cUOKpWnzyLRRowdjQRWv42GMnx1pkKjQ@mail.gmail.com>
Subject: Re: [PATCH v2 16/28] pinctrl: renesas: rzg2l: adapt function number
 for RZ/G3S
To:     Claudiu <claudiu.beznea@tuxon.dev>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linus.walleij@linaro.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, magnus.damm@gmail.com,
        catalin.marinas@arm.com, will@kernel.org,
        quic_bjorande@quicinc.com, konrad.dybcio@linaro.org, arnd@arndb.de,
        neil.armstrong@linaro.org, prabhakar.mahadev-lad.rj@bp.renesas.com,
        biju.das.jz@bp.renesas.com, linux-renesas-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 7:39 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> On RZ/G3S PFC register allow setting 8 functions for individual ports
> (function1 to function8). For function1 register need to be configured
> with 0, for function8 register need to be configured with 7.
> We cannot use zero based addressing when requesting functions from
> different code places as documentation (RZG3S_pinfunction_List_r1.0.xlsx)
> states explicitly that function0 is GPIO.
>
> For this add a new member to struct rzg2l_hwcfg that will keep the
> offset that need to be substracted before applying a value to PFC register.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>
> Changes in v2:
> - in commit description mentioned that function0 is GPIO
> - collected tags

Thanks, will queue in renesas-pinctrl-for-v6.7.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

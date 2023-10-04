Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D757B7F5A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 14:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242326AbjJDMiI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 4 Oct 2023 08:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242371AbjJDMiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 08:38:07 -0400
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B77B198E;
        Wed,  4 Oct 2023 05:37:26 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-d86a0c97ae6so2231390276.2;
        Wed, 04 Oct 2023 05:37:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696423045; x=1697027845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m0eRmMumZAzpcA204HIbmaGshHcqOkFU7CedEjUB2w4=;
        b=WHpuGKIMw6PHJglUambBsLHBibIdoddNLjl35TCosAiWwzK1FHRIx4GeppfLBHeaqh
         nJ3qWqAR94uUDta8lHu5VLx1s9dTZ5idFEdYm6nxC8BMRsuzQ2+miFaDoynJJKMhPs2G
         Z+XKluqj1i270iyQLQk8OcdSPe50pH6Rc239UA/Y9PRZiaZ5d5K0TC0B0tpzSpjLiu+u
         UEln6+ComQjfzQ7VnSKiTAlM9iMELH09Y/ISY471mh3L5u+RKCdRxHxfFvd3ypuh7w7W
         gVtcE3LsxuzD39BeNrVf7/wk7xlDmHDhZFXwullxFMKBJ8de0uSC2nZ1saIFo1SJtKnT
         hOgw==
X-Gm-Message-State: AOJu0YzFUpRDbb0JHzokQwzBu9K3QmryYZAuKQz5xQqPw8LpFzgUJqzm
        iM4qLk6r/14rZOAKHF4Scpf+9dtzrmEx9A==
X-Google-Smtp-Source: AGHT+IE6aiPISN3Sy+GQHhlmGqas7LqydsUQB/Ki8oqiQroN5qUifjPwQEhEdkJyDSMcZLrmJMAqLQ==
X-Received: by 2002:a25:3601:0:b0:d22:c8b9:8c9b with SMTP id d1-20020a253601000000b00d22c8b98c9bmr1963001yba.13.1696423044823;
        Wed, 04 Oct 2023 05:37:24 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id 194-20020a250dcb000000b00d748501d9b4sm1025252ybn.21.2023.10.04.05.37.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 05:37:24 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5a1f00b75aaso23789787b3.2;
        Wed, 04 Oct 2023 05:37:24 -0700 (PDT)
X-Received: by 2002:a81:a24a:0:b0:59f:7f8e:dc4a with SMTP id
 z10-20020a81a24a000000b0059f7f8edc4amr2814911ywg.22.1696423044119; Wed, 04
 Oct 2023 05:37:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230929053915.1530607-1-claudiu.beznea@bp.renesas.com> <20230929053915.1530607-13-claudiu.beznea@bp.renesas.com>
In-Reply-To: <20230929053915.1530607-13-claudiu.beznea@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 4 Oct 2023 14:37:11 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUnt-bLeJmQxbviWAmgmCNHb8EDo1QM5LyhYJRA07KGqA@mail.gmail.com>
Message-ID: <CAMuHMdUnt-bLeJmQxbviWAmgmCNHb8EDo1QM5LyhYJRA07KGqA@mail.gmail.com>
Subject: Re: [PATCH v2 12/28] dt-bindings: clock: renesas,rzg2l-cpg: document
 RZ/G3S SoC
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
> Add documentation for RZ/G3S CPG. RZ/G3S CPG module is almost identical
> with the one available in RZ/G2{L, UL} the exception being some core
> clocks as follows:
> - SD clock is composed by a mux and a divider and the divider
>   has some limitation (div = 1 cannot be set if mux rate is 800MHz).
> - there are 3 SD clocks
> - OCTA and TSU clocks are specific to RZ/G3S
> - PLL1/4/6 are specific to RZ/G3S with its own computation formula
> Even with this RZ/G3S could use the same bindings as RZ/G2L.
>
> Along with documentation bindings for the RZ/G3S (R9A08G045) Clock Pulse
> Generator (CPG) core clocks, module clocks and resets were added.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>
> Changes in v2:
> - collected Rob's tag
> - squashed with
>   [PATCH 21/37] dt-bindings: clock: add r9a08g045 CPG clocks and resets
>   from v1
> - updated commit message to reflect that bindings were also added to
>   this patch
> - removed R9A08G045_USB_SCLK
> - @Geert: please note I haven't collected your Rb tag as I did the squash

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in a branch shared by renesas-clk and renesas-dts for v6.7.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

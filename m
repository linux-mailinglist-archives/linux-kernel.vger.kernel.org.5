Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 056897A9786
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjIURYy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 21 Sep 2023 13:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjIURY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:24:28 -0400
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D2819B4;
        Thu, 21 Sep 2023 10:09:37 -0700 (PDT)
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-34f6ce577a4so3741275ab.3;
        Thu, 21 Sep 2023 10:09:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316176; x=1695920976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5HYwGTI/K3y+X5a5etQVgBzGES/Yd2WtGgSCOPcsNEI=;
        b=r5S/Qy7SeynG1xjJWEDKgYT+o6dWRZnER3SylCxk27tm9MiiZ1qSMHqqKdHljrkTqH
         d2PgkM7OrEy5s+npMGLRxuvV3h/QGxFpjxTpL/7h2V5uV1L7jbkF8spIa1CdJAACVs1d
         h6+enlNC8Ivbr7kGJyxHrc+GAkzK/RlKVk2mQpmdNXNrFhFeGB26xOl/lsqRbQl4F3Vy
         opAMJe0xuxdKtxMVfk0DkmkQhZuZ84+VLIBDjK959MDt0MEEU0ss/L7YpXKUEbfeArDK
         K8mAA7GSsPTmONIERe+VFno87mD/a0Hb8yrD60buVJEm9Bjnce3RFRpcPfhSlUUIKsTd
         ITVQ==
X-Gm-Message-State: AOJu0Ywz1rkIVYyTQeKxdtJ9sfaD+vnfGV5C+ga6h8UmfYLxi2sTMpA+
        Q2VE+Ojm53Qpl4phXlR9vKRFET73CnbmsJB3
X-Google-Smtp-Source: AGHT+IG1SAsdr7OPjWMbeexcN/QMSjtdBRnDhBKSkhmAy69v8Y8E4xym73cC+3y98NwzomUw442ElQ==
X-Received: by 2002:a81:b40d:0:b0:59b:54b5:7d66 with SMTP id h13-20020a81b40d000000b0059b54b57d66mr6233999ywi.34.1695308591131;
        Thu, 21 Sep 2023 08:03:11 -0700 (PDT)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id h144-20020a816c96000000b00583d44b4b30sm368103ywc.99.2023.09.21.08.03.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 08:03:11 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-59c2ca01f27so12899837b3.2;
        Thu, 21 Sep 2023 08:03:10 -0700 (PDT)
X-Received: by 2002:a81:8385:0:b0:57a:2f01:31d7 with SMTP id
 t127-20020a818385000000b0057a2f0131d7mr6057323ywf.1.1695308590791; Thu, 21
 Sep 2023 08:03:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com> <20230912045157.177966-37-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20230912045157.177966-37-claudiu.beznea.uj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 21 Sep 2023 17:02:58 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW9Aj+sjka0n2fN4ME5YcqHSzsRrwEgSaBt-20SfGWr2Q@mail.gmail.com>
Message-ID: <CAMuHMdW9Aj+sjka0n2fN4ME5YcqHSzsRrwEgSaBt-20SfGWr2Q@mail.gmail.com>
Subject: Re: [PATCH 36/37] arm64: dts: renesas: r9a08g045s33-smarc: add
 initial device tree for RZ/G3S SMARC EVK board
To:     Claudiu <claudiu.beznea@tuxon.dev>
Cc:     geert+renesas@glider.be, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, ulf.hansson@linaro.org,
        linus.walleij@linaro.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, magnus.damm@gmail.com,
        catalin.marinas@arm.com, will@kernel.org,
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
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Claudiu,

On Tue, Sep 12, 2023 at 6:53 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Add initial device tree for RZ/G3S SMARC EVK board.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Thanks for your patch!

> --- /dev/null
> +++ b/arch/arm64/boot/dts/renesas/r9a08g045s33-smarc.dts
> @@ -0,0 +1,17 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +/*
> + * Device Tree Source for the RZ/G3S SMARC EVK board
> + *
> + * Copyright (C) 2023 Renesas Electronics Corp.
> + */
> +
> +/dts-v1/;
> +
> +#include "r9a08g045s33.dtsi"
> +#include "rzg3s-smarc-som.dtsi"
> +#include "rzg3s-smarc.dtsi"
> +
> +/ {
> +       model = "Renesas SMARC EVK version 2 based on r9a08g045s33";
> +       compatible = "renesas,smarc2-evk", "renesas,r9a08g045s33", "renesas,r9a08g045";
> +};

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Of course any updates to the DT bindings should be reflected here.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721967A0967
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 17:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241160AbjINPff convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 14 Sep 2023 11:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241105AbjINPfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 11:35:33 -0400
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F481FD0;
        Thu, 14 Sep 2023 08:35:29 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-59b5484fbe6so13317807b3.1;
        Thu, 14 Sep 2023 08:35:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694705728; x=1695310528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IGn0RiHyZw2DSAr2CB814hl7hb457z9EUqLLi0M5sq4=;
        b=D0i5QRQF4F5/JAruezsRJtPSF1Z8GxakPn0a9+MofSxgBrbe7aVduxE4u0FJB/k9F5
         4rEIt2ICgYvxfcAA21SRuy67Jc3wdrCQFb0xWmE4dp/wMAmZg0WR1e+PvHrLea7MLFRc
         2JsSmjmEwp6ZSh1E5LR35lf8SyGe5yrzuJYpUuT0Df/dQjYgLHkWaEidMsUPxDu2H9vn
         qCcX1Dld9voDkR7L38/JX5XK6rBL+4pAeEyzh0qQEYhSNUd5dLzBJx3uvvDWYXv5vLMB
         CNp2V8mGUHh3c1XZxYLjnhA9wh4kngJOeWhTJlw9rk6t3mCOYpXqHUkKJOT4UyJkaeUa
         0eKA==
X-Gm-Message-State: AOJu0YzSTGlc42QfBGjbozq960yKwcF8h/6hRCQlSeuOBueYTiLdBxJL
        Xd4TeUHiJZrzokrTVnXE4g8QV2cfI5FyjQ==
X-Google-Smtp-Source: AGHT+IH9URVAm+Kzolb63Se6nxQZFZvGSr3JDIiEG+FuOnIdxeJmgpGQh80V+nC8dF2Cz80HwINKWw==
X-Received: by 2002:a0d:df07:0:b0:59b:fda7:9d7f with SMTP id i7-20020a0ddf07000000b0059bfda79d7fmr1146235ywe.49.1694705728220;
        Thu, 14 Sep 2023 08:35:28 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id n124-20020a0dfd82000000b005925c896bc3sm377732ywf.53.2023.09.14.08.35.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 08:35:27 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-d81b803b09aso237127276.2;
        Thu, 14 Sep 2023 08:35:27 -0700 (PDT)
X-Received: by 2002:a5b:ac2:0:b0:d0a:353b:b939 with SMTP id
 a2-20020a5b0ac2000000b00d0a353bb939mr5402450ybr.52.1694705727063; Thu, 14 Sep
 2023 08:35:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com> <20230912045157.177966-32-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20230912045157.177966-32-claudiu.beznea.uj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 14 Sep 2023 17:35:14 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXMXfqG9whhgTwS9Ut8ZBAoEYsGBx_WX-BPE02kGbiR_Q@mail.gmail.com>
Message-ID: <CAMuHMdXMXfqG9whhgTwS9Ut8ZBAoEYsGBx_WX-BPE02kGbiR_Q@mail.gmail.com>
Subject: Re: [PATCH 31/37] dt-bindings: mmc: renesas,sdhi: Document RZ/G3S support
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 6:53 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Document support for the SD Card/MMC interface on the Renesas
> RZ/G3S (R9A08G045) SoC.
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

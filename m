Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 768EA7A00CE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 11:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237267AbjINJuR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 14 Sep 2023 05:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237357AbjINJuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 05:50:11 -0400
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FEFD2109;
        Thu, 14 Sep 2023 02:50:07 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-59bf1dde73fso3798127b3.3;
        Thu, 14 Sep 2023 02:50:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694685006; x=1695289806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=reSGUiP8hV4XNGsRBA5zYLT+AbqRJZRcFGb0bBuhV3M=;
        b=toWJKBgP86BIalmvxtqFu2pUDCa5IYl+bZTTL+SzWowWQ4DMIbVS41AlC1TXFIaJyJ
         XtTe/GWs3zC0WVjg1xAkj9NYpENY81HdD2iQAxuM9kmwip6IpdubnmeNT01cmZp4l0E5
         1HMSkd6gQdSHq1VrruMZL7Jrvk4t0p92saK5Y2KOscDYY8ywJiBKyN/uSxSQ/2UNw3UC
         28UFxnsgz9REgOSKruw0okazc5C0soUexf1q6jWqZwiQFCQFbnSXyKaRAqggb/ebFr4N
         LCMCP5UU+Q+TaLDJ9ExrExiUwTFhl/oLrYPMbP/WUTuIryhAxBEIG9C/1x4CNyZ/zcZY
         hoew==
X-Gm-Message-State: AOJu0YxjR46irB3GcqbIeXrDK7z2xq8kXBsxpafFUt2jxlOwJYF8aWTw
        6gV1AWKnNlpQjZ2cJ2q5951jW8bZbd0+tg==
X-Google-Smtp-Source: AGHT+IH4bKCWi6OIoYUAu19K34D5LzQ/qSdTsRJvwEAJ/0Q3bMwYJ51v+wiScaVWUG+5Wa0LaleLww==
X-Received: by 2002:a25:ab8e:0:b0:d7f:d6a7:d57d with SMTP id v14-20020a25ab8e000000b00d7fd6a7d57dmr4966190ybi.27.1694685006321;
        Thu, 14 Sep 2023 02:50:06 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id b9-20020a25bb49000000b00d0bad22d652sm246023ybk.36.2023.09.14.02.50.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 02:50:04 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-d8195078f69so394829276.3;
        Thu, 14 Sep 2023 02:50:03 -0700 (PDT)
X-Received: by 2002:a25:ae91:0:b0:d81:4cb2:eee3 with SMTP id
 b17-20020a25ae91000000b00d814cb2eee3mr4202874ybj.47.1694685003682; Thu, 14
 Sep 2023 02:50:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com> <20230912045157.177966-6-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20230912045157.177966-6-claudiu.beznea.uj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 14 Sep 2023 11:49:51 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUcXXTPr5gXMCGM8sZzyE-QnVzkNE8pv+bAVPXdep3wBA@mail.gmail.com>
Message-ID: <CAMuHMdUcXXTPr5gXMCGM8sZzyE-QnVzkNE8pv+bAVPXdep3wBA@mail.gmail.com>
Subject: Re: [PATCH 05/37] soc: renesas: remove blank lines
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

On Tue, Sep 12, 2023 at 6:52 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Remove blank lines.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.7.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

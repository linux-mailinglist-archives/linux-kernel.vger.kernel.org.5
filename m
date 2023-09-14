Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A807A00BF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 11:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237572AbjINJtp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 14 Sep 2023 05:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237541AbjINJtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 05:49:40 -0400
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC9CE3;
        Thu, 14 Sep 2023 02:49:36 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-58fc4eaa04fso8706007b3.0;
        Thu, 14 Sep 2023 02:49:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694684976; x=1695289776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kGHFgFrGIBAAVa6J4diJj00gDkB/jKzsHsTxxfM9spg=;
        b=Ih9H6SooXaJzm1BjyVT/fhz3j1ERxlUanTi2k4k6zkPDoC7e1f41t+tqzHw1LY1P7l
         5yxGBsfWfMf3ewPvnygAzFTCLtwALr413nrJxFTUqxHoTNvUnKSo6dpY9+07T7o6/nHy
         grmqtYYGmBWzx1M56Jj5kA1iglNGsQZwcvrvUC9+b+3dud/bjwnw+wFUCeU5ZAJcM+bi
         EyfTdgdNyvmJtd0i8eJ2xT2b3KCSzIf01wl3N5h/JldY6mJqm+AndO+i0Dhw/nCm8Orc
         Xt5Qn3muQD5ZQ9aRy7EhFbM1p6RI8oxZlcSdgQ54fx4VeNt9kStbLfLqpB3IWB9JCWaQ
         ec4g==
X-Gm-Message-State: AOJu0YymLfW0gHukWO3Ri7gBamdQqDVo8wlJEUHFK8UkzITq6M+ydcBY
        5CmOeqsZWBIHDC0atL5Q4QH8fiFUoVtA2g==
X-Google-Smtp-Source: AGHT+IE0FtO51OE2xXwaxCbYz29NQ16FH2YXTzXPBhgSLua7xJ5UWFHUxUZdAx9ijvoTXUKN1++Qhg==
X-Received: by 2002:a81:af1d:0:b0:59b:de0f:c23b with SMTP id n29-20020a81af1d000000b0059bde0fc23bmr3423536ywh.46.1694684975874;
        Thu, 14 Sep 2023 02:49:35 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id m126-20020a0de384000000b00594fb0e2db3sm236940ywe.138.2023.09.14.02.49.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 02:49:35 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-58fc4eaa04fso8705827b3.0;
        Thu, 14 Sep 2023 02:49:35 -0700 (PDT)
X-Received: by 2002:a25:29c3:0:b0:d80:1023:8222 with SMTP id
 p186-20020a2529c3000000b00d8010238222mr4854190ybp.34.1694684975146; Thu, 14
 Sep 2023 02:49:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com> <20230912045157.177966-4-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20230912045157.177966-4-claudiu.beznea.uj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 14 Sep 2023 11:49:21 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWXx_QNS0UKUdovnNGQFtWEqd1trfWYtQOZng2dVoXvtA@mail.gmail.com>
Message-ID: <CAMuHMdWXx_QNS0UKUdovnNGQFtWEqd1trfWYtQOZng2dVoXvtA@mail.gmail.com>
Subject: Re: [PATCH 03/37] dt-bindings: soc: renesas: renesas,rzg2l-sysc:
 document RZ/G3S SoC
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
> Document RZ/G3S (R9A08G045) SYSC bindings. The SYSC block found on the
> RZ/G3S SoC is similar to one found on the RZ/G2UL.
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

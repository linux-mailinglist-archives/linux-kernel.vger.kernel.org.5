Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92FF67AA026
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbjIUUdN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 21 Sep 2023 16:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbjIUUcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:32:51 -0400
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com [209.85.210.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906E78922E;
        Thu, 21 Sep 2023 10:39:46 -0700 (PDT)
Received: by mail-ot1-f65.google.com with SMTP id 46e09a7af769-6c0b8f42409so743807a34.0;
        Thu, 21 Sep 2023 10:39:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695317986; x=1695922786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+FnksNosVt+Hax24mR+RoN0eh3COVsIdIWx2BS+xejg=;
        b=rEkx3pMMnIU7MUJ9vcnx/DCHNMC/mOb17XNiDHTnHAIovYhOvhE/8768ey7Fg50mWi
         a2sDCOSJrJDSp+eWKsYJ5NQ49buCM5LBWumFy7qeSfPz8m4IsMHFmt3saylMWva5OgXd
         MPpfmb7HSMg9XHCNDPBXvyxfKy/IUud0pMwOwAk5sySBHiN0nOSEOK2hJV1YmTU0DIJn
         z/Jn7fjglrRBkWa8ZxUsPHae7XaTzGML++/2yKa8LKlTcjK3bAOfu4Flptr5wNE9EgEI
         HClm3bJbT1aWwetKW4CoKK2jPTvCLldfSb6vgAw4oUC7eYOg1rJS7+yx2IhuUFGhYMpl
         p0UA==
X-Gm-Message-State: AOJu0YxAOJnUnrAX9ZKwf9iDhnavooLEUzzrZqejmwa8GLOU/h4eim+A
        J8SqKKXgzvjdm/b0Nx9TamI2QQfinX0TFqO0qac=
X-Google-Smtp-Source: AGHT+IEkfGDj8wYGohG9vtgfxj2bFMU98AQDYeQGae+2uTcjv+ZyzSZBMyN3zQhcBm3QftLUqtmlQQ==
X-Received: by 2002:a81:83c1:0:b0:58d:7ec3:16c4 with SMTP id t184-20020a8183c1000000b0058d7ec316c4mr6054718ywf.34.1695308457056;
        Thu, 21 Sep 2023 08:00:57 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id e1-20020a0dc201000000b0057a8de72338sm364072ywd.68.2023.09.21.08.00.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 08:00:57 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-d81afd5273eso1309619276.3;
        Thu, 21 Sep 2023 08:00:56 -0700 (PDT)
X-Received: by 2002:a5b:78d:0:b0:d81:bfbf:dd3 with SMTP id b13-20020a5b078d000000b00d81bfbf0dd3mr5437539ybq.51.1695308456709;
 Thu, 21 Sep 2023 08:00:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com> <20230912045157.177966-30-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20230912045157.177966-30-claudiu.beznea.uj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 21 Sep 2023 17:00:44 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWC8W9+a+8mewin5irujsEeVnSQfaoaNpD1GLHES54rCQ@mail.gmail.com>
Message-ID: <CAMuHMdWC8W9+a+8mewin5irujsEeVnSQfaoaNpD1GLHES54rCQ@mail.gmail.com>
Subject: Re: [PATCH 29/37] dt-bindings: pinctrl: renesas: document RZ/G3S SoC
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Claudiu,

On Tue, Sep 12, 2023 at 6:53 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Add documentation for pin controller found on RZ/G3S (R9A08G045) SoC.
> Compared with RZ/G2{L,UL} RZ/G3S has 82 general-purpose IOs, no slew
> rate and output impedance support and more values for drive strength
> which needs to be expressed in microamp.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Thanks for your patch!

LGTM, once you have taken Rob's comments into account.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

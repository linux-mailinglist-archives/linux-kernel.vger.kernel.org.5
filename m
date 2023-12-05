Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFB1805C04
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346900AbjLEP3c convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 5 Dec 2023 10:29:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346917AbjLEP30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 10:29:26 -0500
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F77122;
        Tue,  5 Dec 2023 07:29:32 -0800 (PST)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5d6b9143782so41120787b3.0;
        Tue, 05 Dec 2023 07:29:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701790171; x=1702394971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nKR4eGh9Q8YilRGEEfPHT07Wa+ghJ3PZE9UUZkDUQSU=;
        b=keJkStga+jZ8Uo/hghHETxFv1rnAbPnVJYh/f97si3DN+oSv/dV5LVrp6cW17uTp7P
         XPSy9sDSuIVslUS+xMwXHGcaiBaGmXoLz9UflI74kZXyJOlMsXaiedV6N+IWsl/IOXIm
         leoO8YygGc9bEKFa6VUmyQ6Br9k2EJE0TsXeR6QpbdUjziDl5rqYZJghRWHnFJXrabaO
         QcIJ9rEeNAHwS1q/JKGGjLGpfDJFly9tT4g2ReLdG4L/K+l/g2t2Plb128lIXEnZGy/3
         mnGePHA7VIZm7epis3AyVuXTpcGz0h8b8soSE27LjzJk/CGn8cqRFPxEALijTQ2cb3TL
         sPOQ==
X-Gm-Message-State: AOJu0Yxy2TE4HDGwaUgRPYOE5T+cEDH7t3qIyOAiAN8iNeJ8BfpTn4RL
        bLAeG07zUYFwFYUvd+nesfAxAjcw01KY4g==
X-Google-Smtp-Source: AGHT+IGniOkt2In+ND9FjMFdQCNAS6I92uhwMneiOiO5M4fByOWCFxG9E/IRcrI00OxBWY6PTr24Kg==
X-Received: by 2002:a81:4c0c:0:b0:5d3:5887:edb9 with SMTP id z12-20020a814c0c000000b005d35887edb9mr4411016ywa.44.1701790171070;
        Tue, 05 Dec 2023 07:29:31 -0800 (PST)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id u64-20020a814743000000b00582b239674esm4218954ywa.129.2023.12.05.07.29.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 07:29:30 -0800 (PST)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-d9beb865a40so4101478276.1;
        Tue, 05 Dec 2023 07:29:30 -0800 (PST)
X-Received: by 2002:a25:870f:0:b0:db7:d3e0:46d1 with SMTP id
 a15-20020a25870f000000b00db7d3e046d1mr4072755ybl.32.1701790170465; Tue, 05
 Dec 2023 07:29:30 -0800 (PST)
MIME-Version: 1.0
References: <cover.1701768028.git.ysato@users.sourceforge.jp> <91a4cac133cb7244903e872b9e63fbbd57fbd68c.1701768028.git.ysato@users.sourceforge.jp>
In-Reply-To: <91a4cac133cb7244903e872b9e63fbbd57fbd68c.1701768028.git.ysato@users.sourceforge.jp>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 5 Dec 2023 16:29:19 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUNQ_u0O1ANv6zdao5SOp9H=WLuULnYuvAt2tgAfsp_GQ@mail.gmail.com>
Message-ID: <CAMuHMdUNQ_u0O1ANv6zdao5SOp9H=WLuULnYuvAt2tgAfsp_GQ@mail.gmail.com>
Subject: Re: [DO NOT MERGE v5 09/37] dt-bindings: timer: renesas,tmu: add renesas,tmu-sh7750
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     linux-sh@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Lee Jones <lee@kernel.org>, Helge Deller <deller@gmx.de>,
        Heiko Stuebner <heiko@sntech.de>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Baoquan He <bhe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Guo Ren <guoren@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Bin Meng <bmeng@tinylab.org>,
        Max Filippov <jcmvbkbc@gmail.com>, Tom Rix <trix@redhat.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Jacky Huang <ychuang3@nuvoton.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Sam Ravnborg <sam@ravnborg.org>,
        Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-pci@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sato-san,

On Tue, Dec 5, 2023 at 10:46 AM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> Add SH7750 TMU entry.
>
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

Thanks for your patch!

> --- a/Documentation/devicetree/bindings/timer/renesas,tmu.yaml
> +++ b/Documentation/devicetree/bindings/timer/renesas,tmu.yaml
> @@ -21,6 +21,7 @@ properties:
>    compatible:
>      items:
>        - enum:
> +          - renesas,tmu-sh7750   # SH7750

Please preserve alphabetical sort order.

>            - renesas,tmu-r8a7740  # R-Mobile A1
>            - renesas,tmu-r8a774a1 # RZ/G2M
>            - renesas,tmu-r8a774b1 # RZ/G2N

The rest LGTM.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

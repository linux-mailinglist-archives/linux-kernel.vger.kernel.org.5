Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C90D805C3B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345988AbjLEO5s convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 5 Dec 2023 09:57:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345775AbjLEO5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 09:57:46 -0500
Received: from mail-yb1-f196.google.com (mail-yb1-f196.google.com [209.85.219.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F221129;
        Tue,  5 Dec 2023 06:57:52 -0800 (PST)
Received: by mail-yb1-f196.google.com with SMTP id 3f1490d57ef6-db3a09e96daso4253926276.3;
        Tue, 05 Dec 2023 06:57:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701788271; x=1702393071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2OSy1fkE1VPCMMZW3HW28WvB6VxFaRMTrE1La3jBwPw=;
        b=H5EsiOalP3wPRYTrmCyX7LM5E6IlxQEl5ZpKo7uk0EnaN1FCXHYBwLP3t2tNe0aS9m
         DaFQp/om0wB97vG4+Xt00c7JfkCCaP+dqgDlRt+/dQB1vPMWiuLzk8mJ6Rlk++syoBa5
         xRJQuroejthMcN/RBYGCb3Rim9K9+jMZduxdrUybACWV5rsD3+pmKWjegcuXH0fXA2Wu
         z8P1RGlOy+dgtlPt99vhS/a0wy8428UNF507D153SjNB3tay1PR48FbVqdD1nJFYdyZc
         N5Zz7yGtK5SJex4ZppZ8tGOywv6ZTdWwXZeGqA68T2bwjmRpeFRbaSLbmeYVnh7yoSzx
         WJGg==
X-Gm-Message-State: AOJu0Yy0nOCHbpCu0qhu7ax/zxs3oBJkkUccKlMzNulBeGMwEXK3ZjXQ
        0Ig6I/17nVYPnvMOq8iO5+wMFX/w00RVCyGx
X-Google-Smtp-Source: AGHT+IFLodowK5y27eVR6eQAnJr24kgV1N0rDxhSnfD+dOfoslVZNjUyIGOONG4pfS50TELYBsRXoA==
X-Received: by 2002:a25:8543:0:b0:db8:357:f032 with SMTP id f3-20020a258543000000b00db80357f032mr3405933ybn.89.1701788271716;
        Tue, 05 Dec 2023 06:57:51 -0800 (PST)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id p82-20020a254255000000b00db3fdaaa4fasm3155660yba.1.2023.12.05.06.57.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 06:57:51 -0800 (PST)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-5d279bcce64so64342657b3.3;
        Tue, 05 Dec 2023 06:57:51 -0800 (PST)
X-Received: by 2002:a05:690c:c9d:b0:5d7:1941:2c27 with SMTP id
 cm29-20020a05690c0c9d00b005d719412c27mr4909480ywb.84.1701788271024; Tue, 05
 Dec 2023 06:57:51 -0800 (PST)
MIME-Version: 1.0
References: <cover.1701768028.git.ysato@users.sourceforge.jp> <9f1485220fbfaba9b30bf2d9352640f988f35b04.1701768028.git.ysato@users.sourceforge.jp>
In-Reply-To: <9f1485220fbfaba9b30bf2d9352640f988f35b04.1701768028.git.ysato@users.sourceforge.jp>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 5 Dec 2023 15:57:39 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWsBOs0Y7CkzhxkMYWWzyBpp1MesiCHc728FoTMNQs+qA@mail.gmail.com>
Message-ID: <CAMuHMdWsBOs0Y7CkzhxkMYWWzyBpp1MesiCHc728FoTMNQs+qA@mail.gmail.com>
Subject: Re: [DO NOT MERGE v5 21/37] dt-bindings: serial: renesas,scif: Add scif-sh7751.
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     linux-sh@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
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
> Add Renesas SH7751 SCIF.
>
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

Thanks for your patch!

> --- a/Documentation/devicetree/bindings/serial/renesas,scif.yaml
> +++ b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
> @@ -17,6 +17,7 @@ properties:
>      oneOf:
>        - items:
>            - enum:
> +              - renesas,scif-sh7751       # SH7751

Please preserve alphabetical sort order.
The actual compatible value LGTM.

>                - renesas,scif-r7s72100     # RZ/A1H
>            - const: renesas,scif           # generic SCIF compatible UART

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

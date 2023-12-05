Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D779E805B6B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442344AbjLEPCL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 5 Dec 2023 10:02:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346007AbjLEPCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 10:02:09 -0500
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00EB9C9;
        Tue,  5 Dec 2023 07:02:15 -0800 (PST)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5cbcfdeaff3so67388777b3.0;
        Tue, 05 Dec 2023 07:02:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701788535; x=1702393335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=01RE6ADoqVebgl/Ay4VLc+Nsg6c5Olp3h2V1YYqK/9g=;
        b=FCaxArgg67/TTMzd5ofAiy6xwfTILhTvQSmgPhrgsXEBOXtrQlWe1bDczFenqbKxS7
         HRB3YxOQmng9se/nVma5/+h4/jVxmjQrqmbUpDG7Po7mWNQ55TcMfMk3pIor8tycAn20
         RXzqoXiNLa+JJmiUEg0fg7fui9wZbchLLqQKq3gAUC5s+7sQYtX3a+NW1VhgJiTDNJES
         L9dSQQmn6FTQiKvVvCyFTYeCNt0bDOOkzZp8UMbK3i0Zntu03bi42irdwPhgMj4Yr17u
         m3GcxyzZv7/+I1geUBXL3/dl+H992NoSgchOCGG3eN3p+T9aOW61AcvXSTJAIvj9zhlz
         dBYg==
X-Gm-Message-State: AOJu0YzHw2XLrowDgOcznX1onQDXjUdds/u+zs7TvxvxYq1Vb+XrLuZp
        o8xa+W49TjmtHXQtR3zxGJ/Ic351XAxNjQ==
X-Google-Smtp-Source: AGHT+IEVXjBwfzAXy55fVVV7kVkEgQ08l2O2IcUVdHLuT1nhfP3rzVZ8ElIMnkQ98R6VhcDB0jQ91Q==
X-Received: by 2002:a05:690c:281:b0:583:c917:7ff0 with SMTP id bf1-20020a05690c028100b00583c9177ff0mr4651337ywb.51.1701788535091;
        Tue, 05 Dec 2023 07:02:15 -0800 (PST)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id i190-20020a816dc7000000b005d76f9e256esm2581439ywc.29.2023.12.05.07.02.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 07:02:12 -0800 (PST)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5d7a47d06eeso33067067b3.1;
        Tue, 05 Dec 2023 07:02:11 -0800 (PST)
X-Received: by 2002:a05:690c:4443:b0:5d8:204e:acdf with SMTP id
 gq3-20020a05690c444300b005d8204eacdfmr3526411ywb.101.1701788531025; Tue, 05
 Dec 2023 07:02:11 -0800 (PST)
MIME-Version: 1.0
References: <cover.1701768028.git.ysato@users.sourceforge.jp> <1fafcf1c70ee4e38847bac1379bcb4555a237505.1701768028.git.ysato@users.sourceforge.jp>
In-Reply-To: <1fafcf1c70ee4e38847bac1379bcb4555a237505.1701768028.git.ysato@users.sourceforge.jp>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 5 Dec 2023 16:01:59 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWXyn5+e8CxihmtFo_6chKkpZ_QyzEzAm_As1xQoDKnpA@mail.gmail.com>
Message-ID: <CAMuHMdWXyn5+e8CxihmtFo_6chKkpZ_QyzEzAm_As1xQoDKnpA@mail.gmail.com>
Subject: Re: [DO NOT MERGE v5 17/37] dt-bindings: interrupt-controller:
 renesas,sh7751-intc: Add json-schema
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
> Renesas SH7751 INTC json-schema.
>
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

Thanks for your patch!

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,sh7751-intc.yaml

> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/sh_intc.h>

make dt_binding_check:

fatal error: dt-bindings/interrupt-controller/sh_intc.h: No such file
or directory

sh7751-intc.h

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

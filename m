Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F6A804FA4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 11:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbjLEKAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 05:00:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbjLEKAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 05:00:02 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55DFBB2
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 02:00:08 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5d7692542beso28752037b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 02:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701770407; x=1702375207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i93Z/CqJ+EBecddDOnAmVzRbIcIUtO0ehOz5S54CfrQ=;
        b=YDRJRetfQA80jrjZYAlfT90vA6kpOsfF70/ktTGJ25Lk4nxospYByarCuZVETKVEX+
         T04DRfvWpjz7YsT/JikHiUPmjRMxckzN8B9eEohxgMhuq7QUvCZndWlRA1q+zTiXqVk8
         raIS3RFBgbsMdp/iYKWaZ6ehoAazJ2aYoUu+BtQviPhvZxEdC8ELMogHqNsWrplpuegX
         K/cI+VioTMwDX2wVOK7t+zmNadxVEtG6WgHcaC2menF1zD2agwrSdmG6LpvYGQH7xrhb
         l6V0g+FLpDsl8+R0qUAVUTFj57n7Ilf6hVnNXQfX7hiOzM/b6Ti9kN1yK9VZvctCVCrZ
         KiUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701770407; x=1702375207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i93Z/CqJ+EBecddDOnAmVzRbIcIUtO0ehOz5S54CfrQ=;
        b=AbXFMTU14VJYlsMOek9FleNLSl3qTogmbFo8rJMntLvqJYrYTsXg0N5AHhL5gF+5gm
         QOvlidivkhDVzXheWUVUxZiKOcXJ+1eRrlrjTLqQnjAqCklLSwaRqEQnEgfm82SVargc
         Vr27t8tUmgri4nXu1DgXNh6NFrrwt4VCOd+IDperXFgMe/obo2ywvR++7TLliCvrMdRM
         HnS/D6GhWl0+ZKIxorAnk8ybQtGUXcQG4RGPbzl4gR5/f/hslnN7EIyEydVeBfyOEMZl
         9G6NPUxeeVZUIhlg8N/cTk45iKJWboOjFxteBm24lrr4f6ECAEVnMP5JEV7qXMFcFF5G
         JlCA==
X-Gm-Message-State: AOJu0YzZe7M2Kn72cG+QHQ7hFatS8K51AA01o+SK68DO/JZYJzwPssmU
        QD6OMn6n6maxyeOqhaZpGndrnbbE0fj3d1yk4+zg4A==
X-Google-Smtp-Source: AGHT+IH5eTb2gwdS22rkWHvbJD/nbpWagDnymfw80erU7E8T3kEYsszdXZXrJ4vDy/yEfDwBBs/YnsUIOf3GGpmbFhk=
X-Received: by 2002:a0d:ccd6:0:b0:5d7:1940:53d6 with SMTP id
 o205-20020a0dccd6000000b005d7194053d6mr4529462ywd.78.1701770407103; Tue, 05
 Dec 2023 02:00:07 -0800 (PST)
MIME-Version: 1.0
References: <cover.1701768028.git.ysato@users.sourceforge.jp> <1fafcf1c70ee4e38847bac1379bcb4555a237505.1701768028.git.ysato@users.sourceforge.jp>
In-Reply-To: <1fafcf1c70ee4e38847bac1379bcb4555a237505.1701768028.git.ysato@users.sourceforge.jp>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 5 Dec 2023 10:59:54 +0100
Message-ID: <CACRpkdbFNyEn_ub3moh9f6zbBKzTBt-CPRykUfexd5fXjpKE3Q@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yoshinori,

thanks for your patch!

On Tue, Dec 5, 2023 at 10:46=E2=80=AFAM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:

> +  renesas,icr-irlm:
> +    type: boolean
> +    description: If true ICR.IRLM=3D1

That's a bit hard to understand. I suppose it's something that need to some=
times
be changed for a system so would be good to document it properly.

> +  renesas,ipr-map:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description: |
> +      IRQ to IPR mapping definition.
> +      1st - INTEVT
> +      2nd - Register
> +      3rd - bit index

Isn't this table always the same for a certain SoC, e.g. compatible
"renesas,sh7751-intc"?

Then don't keep it in the device tree, just look it up per-soc from a
table in the driver.

Other than that it looks good to me.

Yours,
Linus Walleij

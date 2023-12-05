Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48F82805720
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 15:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345956AbjLEOV4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 5 Dec 2023 09:21:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345941AbjLEOVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 09:21:52 -0500
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9081AB;
        Tue,  5 Dec 2023 06:21:56 -0800 (PST)
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-35d6c5f9579so7259825ab.0;
        Tue, 05 Dec 2023 06:21:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701786115; x=1702390915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wjEDTZbGLWl0kPzOEjqjXQ57XT0xydUQvJCUY6FowqA=;
        b=sVt1M6Tprvh5CcP1CA6V7cgPHTd5SEzTyA8LkIczss03OChTZp0Ij4BBuXXQR6kvBN
         ZHDbZ7h1Hy6tUFw9+NUa+rJt0NcqdRrmf31+NVZuUVI+q8xtR4VhtV/QOtgMyiICCk4i
         onNQoosikS5VrHQQ5iGTzTU10XqHrKtApOa33S9BlMPgpw9zOpnaEMtSuwIXLcYKrmcw
         WCg4nsRfkozywtj4gdwgtiy8CeTcReGEub9mrpNarnpRy9oZ3F1OrFi99FKPqYrkBCBY
         fFZbMOebDko6KkqWoy24aVdNw13u/sFHlAOFCniXgxr75yvkwpFTjVoXXZd+j/tQC1sZ
         D71A==
X-Gm-Message-State: AOJu0YzL0nAXJ0lRS2bnc7aqEQiCX8FwA39WO+lC+gKtqVoNo4aS18pR
        bWVeY9ZCnKVB+xr1hLxWMl9PzkCzPRmhdw==
X-Google-Smtp-Source: AGHT+IHiJ8ijq3rDLHlUKDIUoapWhxOdwFwIlkcpCJkHcU69YH7LK0vxP4cObCv99jQmSEB1+zHIIA==
X-Received: by 2002:a92:d292:0:b0:35d:482d:d5b3 with SMTP id p18-20020a92d292000000b0035d482dd5b3mr5821385ilp.10.1701786115219;
        Tue, 05 Dec 2023 06:21:55 -0800 (PST)
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com. [209.85.166.181])
        by smtp.gmail.com with ESMTPSA id l2-20020a056e0205c200b0035b0ad262e2sm615130ils.47.2023.12.05.06.21.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 06:21:55 -0800 (PST)
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-35d699ec3caso8281205ab.3;
        Tue, 05 Dec 2023 06:21:55 -0800 (PST)
X-Received: by 2002:a81:ee0b:0:b0:5d7:1941:a9a with SMTP id
 l11-20020a81ee0b000000b005d719410a9amr4666145ywm.53.1701785702584; Tue, 05
 Dec 2023 06:15:02 -0800 (PST)
MIME-Version: 1.0
References: <cover.1701768028.git.ysato@users.sourceforge.jp> <ca3122511b201a0da0a3f930c0f894bf11954423.1701768028.git.ysato@users.sourceforge.jp>
In-Reply-To: <ca3122511b201a0da0a3f930c0f894bf11954423.1701768028.git.ysato@users.sourceforge.jp>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 5 Dec 2023 15:14:50 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUY1aduN=6kaHFyfT=U3J3K3NPZDK2mCct8vS9XaMfaiA@mail.gmail.com>
Message-ID: <CAMuHMdUY1aduN=6kaHFyfT=U3J3K3NPZDK2mCct8vS9XaMfaiA@mail.gmail.com>
Subject: Re: [DO NOT MERGE v5 12/37] dt-bindings: pci: pci-sh7751: Add SH7751 PCI
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
> Renesas SH7751 PCI Controller json-schema.
>
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

Thanks for your patch!

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/renesas,sh7751-pci.yaml
> @@ -0,0 +1,128 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/renesas,sh7751-pci.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas SH7751 PCI Host controller
> +
> +maintainers:
> +  - Yoshinori Sato <ysato@users.sourceforge.jp>
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-bus.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - renesas,sh7751-pci
> +
> +  reg:
> +    minItems: 2
> +    maxItems: 2

Please add "reg-names", as there is more than one entry.
If that is not sufficient to document what each entry means, please add
"description"s, too.

> +  renesas,memory:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description: |
> +      PCI BMDMA src/dst memory area.

Isn't that the purpose of the "dma-ranges" property?

> +
> +  renesas,bcr1:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      SH7751 PCIC PCIBCR1 value. This value makes add the value of BSC's BCR1.

What does this mean?

> +
> +  renesas,mcrmask:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      SH7751 PCIC PCIMCR value. This value makes clear bit in the value of BSC's MCR.

What does this mean?

> +
> +  renesas,intm:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      SH7751 PCIC PCIINTM value.
> +
> +  renesas,aintm:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      SH7751 PCIC PCIIANTM value.
> +
> +  renesas,lsr:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      SH7751 PCIC PCILSR0 and PCILSR1 values.
> +      First word is PCILSR0, Second word is PCILSR1.
> +
> +  renesas,lar:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      SH7751 PCIC PCILSA0 and PCILAR1 values.
> +      First word is PCILAR0, Second word is PCILAR1.
> +
> +  renesas,dmabt:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      SH7751 PCIC PCIDMABT value.
> +
> +  renesas,pintm:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      SH7751 PCIC PCIPINTM value.
> +
> +  renesas,config:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description: |
> +      SH7751 PCIC PCICONFIG values array. Register Number and value pair list.

Several of these properties look like pure hardware programming.
Can these values be derived from other (standard) DT properties?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

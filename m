Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4257C7CF4BD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 12:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345216AbjJSKJ2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 19 Oct 2023 06:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345212AbjJSKJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 06:09:26 -0400
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0A5129;
        Thu, 19 Oct 2023 03:09:24 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5a7cc03dee5so95440137b3.3;
        Thu, 19 Oct 2023 03:09:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697710162; x=1698314962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xakoCHP0UqUBxiXAUCeloI+dGQZ3rFKCf0jLKLTYknY=;
        b=r10Cqd1rU6cy3CfWvgYlt4c5KqO7f2L5pgZ05tB2a+/xD95enaWLRIppRLqGb2f70X
         0NFcgT/zLTI5fTnmTokjhYtsumfjTjKYWS5a0/2+THHau95LAOX69AifnpldqIEMman1
         724dUJea9uWwy8wdHVA4nVkMDxVUEfVi1BsYTWOeucYHwfxzew/L7Wlww7u8cszneN+W
         ZnNgfVZiwhCULmmlrTCE+RkqPWLD8Y8qdigtf0zYl1j53e0ZVvih3KvPsLnZ1LGb3yhq
         K4Rbf8nLtwIbtNE6xYPMjsg/Hp4XSU2j+NKfqjw229AzcHslMg5ZuDgB+1TQdtCwFUb7
         3AKw==
X-Gm-Message-State: AOJu0YwCzTYwT2nnynssvWdHWefu36k+KEzrqlWiAEQdd8To3VIgV9Uo
        eZsfih+dbtkg8KLOpDXM9500JcgKqxy0yw==
X-Google-Smtp-Source: AGHT+IHzalEo6s11B+/Y2UPEZbUxPhiu3b5Nn9ALWSn4awdd7VH2o9e6IFYct4pz4pYf2eHLoJQRKw==
X-Received: by 2002:a25:37ca:0:b0:d9a:ccdf:3873 with SMTP id e193-20020a2537ca000000b00d9accdf3873mr1741281yba.48.1697710161656;
        Thu, 19 Oct 2023 03:09:21 -0700 (PDT)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id y33-20020a25ad21000000b00d7ba4c5e31fsm1956073ybi.39.2023.10.19.03.09.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 03:09:21 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5a7eef0b931so95806917b3.0;
        Thu, 19 Oct 2023 03:09:20 -0700 (PDT)
X-Received: by 2002:a81:8486:0:b0:5a7:a838:3fa with SMTP id
 u128-20020a818486000000b005a7a83803famr1994997ywf.3.1697710160501; Thu, 19
 Oct 2023 03:09:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230531111038.6302-1-francesco@dolcini.it>
In-Reply-To: <20230531111038.6302-1-francesco@dolcini.it>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 19 Oct 2023 12:09:06 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUkPiA=o_QLyuwsTYW7y1ksCjHAqyNSHFx2QZ-dP-HGsQ@mail.gmail.com>
Message-ID: <CAMuHMdUkPiA=o_QLyuwsTYW7y1ksCjHAqyNSHFx2QZ-dP-HGsQ@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: serial: 8250_omap: add rs485-rts-active-high
To:     Francesco Dolcini <francesco@dolcini.it>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        linux-kernel@vger.kernel.org
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

Hi Francesco,

On Wed, May 31, 2023 at 1:14 PM Francesco Dolcini <francesco@dolcini.it> wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
>
> Add rs485-rts-active-high property, this was removed by mistake.
> In general we just use rs485-rts-active-low property, however the OMAP
> UART for legacy reason uses the -high one.
>
> Fixes: 767d3467eb60 ("dt-bindings: serial: 8250_omap: drop rs485 properties")
> Closes: https://lore.kernel.org/all/ZGefR4mTHHo1iQ7H@francesco-nb.int.toradex.com/
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
> v2: removed reported-by

Thanks for your patch, which is now commit 403e97d6ab2cb6fd
("dt-bindings: serial: 8250_omap: add rs485-rts-active-high")
in v6.4-rc5.

> --- a/Documentation/devicetree/bindings/serial/8250_omap.yaml
> +++ b/Documentation/devicetree/bindings/serial/8250_omap.yaml
> @@ -70,6 +70,7 @@ properties:
>    dsr-gpios: true
>    rng-gpios: true
>    dcd-gpios: true
> +  rs485-rts-active-high: true

make dt_binding_check complains:

    Documentation/devicetree/bindings/serial/8250_omap.yaml:
rs485-rts-active-high: missing type definition

This property should have been added to
Documentation/devicetree/bindings/serial/serial.yaml first.

>    rts-gpio: true
>    power-domains: true
>    clock-frequency: true

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

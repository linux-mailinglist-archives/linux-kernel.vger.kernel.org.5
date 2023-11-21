Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A592B7F2AE4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 11:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233822AbjKUKpL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 21 Nov 2023 05:45:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjKUKpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 05:45:08 -0500
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA5A123;
        Tue, 21 Nov 2023 02:45:03 -0800 (PST)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dafe04717baso4940033276.1;
        Tue, 21 Nov 2023 02:45:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700563502; x=1701168302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7GTzvHmKsk8zPbgSYaWyVwHOKd3D2neB7akSCl7L0f8=;
        b=Q3WZBV6VPCIiY8uqNOoFIIj1JrcFcZ6WI+fdkIpqoU8ptT9cqoBZAye/v4PgKl6A33
         1m6kFOIO0VRfYYL4rc14Tta7SFbeKKpofebpyOYzenSxQhGWjtn3lkH++HHO1HgvNqzs
         AafPTIyNGYsmyEU2TJ2YEN7G4ZjqlJEDQ8jNvSa12XTzIoH33RoOj67ovNUqz/t5pAfX
         uz3hq57rxDERSlVc8Rpy85S3CBggms+kBmKYzyHuusY59G382sx/rF8RDH7UcqIaicLf
         89iFJKjdOgHm2jwPCRVPi2cnt/SdYkXzezoOMackfIfVYT0qWC2ziTSYtK7QwsFxDgO5
         d9ww==
X-Gm-Message-State: AOJu0Yxw7E+eHDNkDTeMRLgjn5A7QqQBKui4sPe1zL8Acbbdu5AaQubo
        EO9PzgtzUPDoxXeesvfIssmaSD0A+aMkGJrj
X-Google-Smtp-Source: AGHT+IH+wdoNWVetDizP2Zr204fx7+bVgu9Ha2R8h6hddA1YdzKRaO3oFwsRbpL7mfg8Lg+ubscvkA==
X-Received: by 2002:a25:8d85:0:b0:daf:7718:62b8 with SMTP id o5-20020a258d85000000b00daf771862b8mr9091289ybl.65.1700563502339;
        Tue, 21 Nov 2023 02:45:02 -0800 (PST)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id m204-20020a2558d5000000b00da07d9e47b4sm617066ybb.55.2023.11.21.02.45.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 02:45:00 -0800 (PST)
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-d9c66e70ebdso4939089276.2;
        Tue, 21 Nov 2023 02:45:00 -0800 (PST)
X-Received: by 2002:a25:4102:0:b0:d9c:aa50:2b5a with SMTP id
 o2-20020a254102000000b00d9caa502b5amr9776928yba.53.1700563499776; Tue, 21 Nov
 2023 02:44:59 -0800 (PST)
MIME-Version: 1.0
References: <20231120111820.87398-1-claudiu.beznea.uj@bp.renesas.com> <20231120111820.87398-9-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20231120111820.87398-9-claudiu.beznea.uj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 21 Nov 2023 11:44:47 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX88KRnvJchUwrWcgmPooAESOT2492Nr1Z_5UMng3q__Q@mail.gmail.com>
Message-ID: <CAMuHMdX88KRnvJchUwrWcgmPooAESOT2492Nr1Z_5UMng3q__Q@mail.gmail.com>
Subject: Re: [PATCH v3 8/9] dt-bindings: interrupt-controller:
 renesas,rzg2l-irqc: Document RZ/G3S
To:     Claudiu <claudiu.beznea@tuxon.dev>
Cc:     tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        magnus.damm@gmail.com, mturquette@baylibre.com, sboyd@kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
        Conor Dooley <conor.dooley@microchip.com>
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

On Tue, Nov 21, 2023 at 9:25 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Document RZ/G3S (R9108G045) interrupt controller. This has few extra
> functionalities compared with RZ/G2UL but the already existing driver
> could still be used.
>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
> @@ -26,6 +26,7 @@ properties:
>            - renesas,r9a07g043u-irqc   # RZ/G2UL
>            - renesas,r9a07g044-irqc    # RZ/G2{L,LC}
>            - renesas,r9a07g054-irqc    # RZ/V2L
> +          - renesas,r9a08g045-irqc    # RZ/G3S
>        - const: renesas,rzg2l-irqc
>
>    '#interrupt-cells':
> @@ -167,7 +168,9 @@ allOf:
>        properties:
>          compatible:
>            contains:
> -            const: renesas,r9a07g043u-irqc
> +            enum:
> +              - renesas,r9a07g043u-irqc
> +              - renesas,r9a08g045-irqc
>      then:
>        properties:
>          interrupts:

Prabhakar: How come we thought RZ/G2L and RZ/V2L do not have the bus
error interrupt? Looks like all the conditional handling can be removed.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

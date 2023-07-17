Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2747565A2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 15:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbjGQN6H convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 17 Jul 2023 09:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjGQN6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 09:58:06 -0400
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB1FD1;
        Mon, 17 Jul 2023 06:58:05 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-579dfae6855so46121057b3.1;
        Mon, 17 Jul 2023 06:58:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689602284; x=1692194284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6GY8g2XJYhobD5XMmXXGSiDcdH93n2WuBZ9x5pzjlb0=;
        b=R1P33IUvCbB1CyfeeqVN/J7QBLkZ6HY7yWB4XXj4ut7naPKTBJbgB75Pg6Rr2I5HkS
         dYjZgn5Sr6atxC3wkaPpV53q0ePWntXY6jssH3TyM+Av7vnwQq1SF8s8DXQcNGcJQWaF
         xyxO7blMYExPOmwHCil4A7VKNTdt18u4RaXhBvn4dVxgDrNc9Qq4xO+dRCSrvOApLQ8L
         u7SyNU7w+OHnMFjWZTo/PiWgY3+8fOlBvD5o7EKawnw8qqXmgAvKa9oky4Jvs/J5O+1u
         wfCgMHNBLNuXmuoH5MF01DAtqBcYGmuwQK2NyoqxBIwMyNsgh3Qi4scH1Jqc2s7pF0tf
         QFFA==
X-Gm-Message-State: ABy/qLaTFA8/br6jecLtaVxu74Bmc7LI60SPaLki2zxIc5WjzofqT9Nm
        Y2iBMDNuo8MknaeHjuWICcBfQajKbIVj8A==
X-Google-Smtp-Source: APBJJlFdT4/Yt2cig2+G2UVzhBFv1G+0PB7y2WmAYl2xvC+kVoF2lI69MNKxbyPzWK24ubSNY2GHNQ==
X-Received: by 2002:a81:85c7:0:b0:56d:464e:db7e with SMTP id v190-20020a8185c7000000b0056d464edb7emr13549710ywf.13.1689602284050;
        Mon, 17 Jul 2023 06:58:04 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id x134-20020a0dd58c000000b005832fe29034sm1023710ywd.89.2023.07.17.06.58.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 06:58:03 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-ca3cc52ee62so4604994276.0;
        Mon, 17 Jul 2023 06:58:03 -0700 (PDT)
X-Received: by 2002:a25:2105:0:b0:c14:68fd:6e30 with SMTP id
 h5-20020a252105000000b00c1468fd6e30mr9475180ybh.16.1689602283054; Mon, 17 Jul
 2023 06:58:03 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1687423204.git.geert+renesas@glider.be> <2259ff548f007afcb5a315a4c95c83a0ee4b7e03.1687423204.git.geert+renesas@glider.be>
 <20230622145213.GA1678457-robh@kernel.org>
In-Reply-To: <20230622145213.GA1678457-robh@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 17 Jul 2023 15:57:51 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX1Y9jkKv+cOAzs6YibkNoTrvY-qDY4FOzgrSyA4pHynQ@mail.gmail.com>
Message-ID: <CAMuHMdX1Y9jkKv+cOAzs6YibkNoTrvY-qDY4FOzgrSyA4pHynQ@mail.gmail.com>
Subject: Re: [PATCH 01/39] dt-bindings: display: Add Renesas SH-Mobile LCDC bindings
To:     Rob Herring <robh@kernel.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Magnus Damm <magnus.damm@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
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

Hi Rob,

Thanks for your review!

On Thu, Jun 22, 2023 at 4:52 PM Rob Herring <robh@kernel.org> wrote:
> On Thu, Jun 22, 2023 at 11:21:13AM +0200, Geert Uytterhoeven wrote:
> > Add device tree bindings for the LCD Controller (LCDC) found in Renesas
> > SuperH SH-Mobile and ARM SH/R-Mobile SOCs.
> >
> > Based on a plain text prototype by Laurent Pinchart.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/renesas,shmobile-lcdc.yaml
> > @@ -0,0 +1,108 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/display/renesas,shmobile-lcdc.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Renesas SH-Mobile LCD Controller (LCDC)
> > +
> > +maintainers:
> > +  - Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - renesas,r8a7740-lcdc # R-Mobile A1
> > +      - renesas,sh73a0-lcdc  # SH-Mobile AG5
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    minItems: 1
> > +    maxItems: 5
> > +    description:
> > +      Only the functional clock is mandatory.
> > +      Some of the optional clocks are model-dependent (e.g. "video" (a.k.a.
> > +      "vou" or "dv_clk") is available on R-Mobile A1 only).
> > +
> > +  clock-names:
> > +    minItems: 1
> > +    maxItems: 5
> > +    items:
> > +      enum: [ fck, media, lclk, hdmi, video ]
> > +
> > +  power-domains:
> > +    maxItems: 1
> > +
> > +  ports:
> > +    $ref: /schemas/graph.yaml#/properties/ports
> > +    description: |
> > +      The connections to the output video ports are modeled using the OF graph
> > +      bindings specified in Documentation/devicetree/bindings/graph.txt.
>
> Please read this file.
>
> > +      The number of ports and their assignment are model-dependent.
> > +      Each port shall have a single endpoint.
>
> I'd just drop the whole description.
>
> > +
> > +    properties:
> > +      port@0:
> > +        $ref: /schemas/graph.yaml#/properties/port
> > +        description: LCD port (R-Mobile A1 and SH-Mobile AG5)
> > +        unevaluatedProperties: false
>
> Don't need this.

You mean the "unevaluatedProperties: false"?
Or more?

Thanks again!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

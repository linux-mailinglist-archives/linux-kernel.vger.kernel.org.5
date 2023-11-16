Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 333187EE207
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 14:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345279AbjKPN6T convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 16 Nov 2023 08:58:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345280AbjKPN6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 08:58:17 -0500
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B1F187;
        Thu, 16 Nov 2023 05:58:10 -0800 (PST)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5ac376d311aso8777777b3.1;
        Thu, 16 Nov 2023 05:58:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700143089; x=1700747889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lwc94K2A3+xRSxt0ijmFzS8lZWk11pXwatY3W49Ncx4=;
        b=CAWUYhtleipfbULS0DBJzvVbmg9ad+LeLgpO92N0c58ULxXPsrXVEZWWgCfOqBL8NA
         Ll7U5Nj9Mgo+lnf3VOcmb0yncBAtzIe4uZLvsCa0e+WVs+zqKrrVO3o1qMXKLoiZNjiS
         1GLZdLbD0dvQVLb4JXwASsuOokWEoYiIkRAYc7Ju9cNUwa4W1XvkiXjPzgdfDp/Edd0l
         Nl41i0E9JOcUA83dLxkou0YS3hll2rSoc/778BGhWPiMiqBB8z5pABRi/jjxkQb/WItE
         vLeoggQAJYfkhUH5PAobbhj1/NpyGpom7LOZOcDIuLbTN1sysE4NnMfuCs+xk6EgU0Yz
         +xrg==
X-Gm-Message-State: AOJu0YxwNWFRso9xJxTKl6rHlp8Yhts1+tf80i+GS6RcR4nkwMd/mOxC
        SMVu0qmolivACx2E7KkTiyXEg8kTcDFcFA==
X-Google-Smtp-Source: AGHT+IH1xZWITsn5KY1joli91uail0bxhncz3cEkOuteo70SDGwUsDwrvCmf0ygR1Fkyph1FyFteIQ==
X-Received: by 2002:a05:690c:368f:b0:5a7:a817:be43 with SMTP id fu15-20020a05690c368f00b005a7a817be43mr4838978ywb.6.1700143089016;
        Thu, 16 Nov 2023 05:58:09 -0800 (PST)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id w205-20020a0dd4d6000000b005af5ef0687fsm1016513ywd.6.2023.11.16.05.58.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 05:58:08 -0800 (PST)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-da041ffef81so854284276.0;
        Thu, 16 Nov 2023 05:58:08 -0800 (PST)
X-Received: by 2002:a25:3302:0:b0:d72:a54d:4b7 with SMTP id
 z2-20020a253302000000b00d72a54d04b7mr16291259ybz.1.1700143088634; Thu, 16 Nov
 2023 05:58:08 -0800 (PST)
MIME-Version: 1.0
References: <20231115203254.30544-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20231115203254.30544-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 16 Nov 2023 14:57:57 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVWNn2jOx3CgBZx05Y-+Lvjt8ZuDELZZ7xc1hfcY+nrAg@mail.gmail.com>
Message-ID: <CAMuHMdVWNn2jOx3CgBZx05Y-+Lvjt8ZuDELZZ7xc1hfcY+nrAg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: renesas,sdhi: Document RZ/Five SoC
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

On Wed, Nov 15, 2023 at 9:33 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> The SDHI block on the RZ/Five SoC is identical to one found on the RZ/G2UL
> SoC. "renesas,sdhi-r9a07g043" compatible string will be used on the
> RZ/Five SoC so to make this clear and to keep this file consistent, update
> the comment to include RZ/Five SoC.
>
> No driver changes are required as generic compatible string
> "renesas,rcar-gen3-sdhi" will be used as a fallback on RZ/Five SoC.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

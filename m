Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9F847EE28A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 15:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344093AbjKPOQ4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 16 Nov 2023 09:16:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345273AbjKPOQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 09:16:52 -0500
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1FED55;
        Thu, 16 Nov 2023 06:16:45 -0800 (PST)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5a82f176860so9418057b3.1;
        Thu, 16 Nov 2023 06:16:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700144205; x=1700749005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ibmdabV7l5XTVe2k8R3JzSdJeiOB1me2z9/gej+1Tto=;
        b=GJ4gMj/gchRjIry1gEBriVfGP/xzWg2Jcy8BXbe/sB17IApoxwJcu5VdDbZEJHK5Lx
         haSCsyWS69LukKGux0pVAfrOD6gH8oB+zSkRtHyP5VbB9RV/76/T6Zyi36/hdfIf9Xiv
         8kCXiMlk1cI97Ufm+2LrWQGtEzpZ84uRnrnS1XnHNZHjURDjE4JV2M/KKLo0GypwUk4i
         cfSSLQWSD8GwAqRUnAPLpmg13egVlo8IsfJcTDSxd95d9xIWfCeSFfRJofhJLKgLM7SP
         I8TvO2F3Iv1fD8z5Ql4Mf1xcg3qqZ2EAmlAIQYHz4/pW2oV5XUMkrkz+sr+gPzojdmpX
         byuA==
X-Gm-Message-State: AOJu0YxbXptc61/KiUuUT1SiCGtzWd1HRp3rW09s+m7lv3hZCqXzK3JL
        ZtB+YoWrWmYQjVcTJ9mpaPFLGfVyaOZnSQ==
X-Google-Smtp-Source: AGHT+IHbcX04PGYeaUhKqhleU5CNVn4S+x2ZzvU6qX6U22YHkpdciZkxtyf3/SpSCmh/NUkh0c0MYw==
X-Received: by 2002:a0d:e3c1:0:b0:5a8:60ad:39a4 with SMTP id m184-20020a0de3c1000000b005a860ad39a4mr17955067ywe.3.1700144204813;
        Thu, 16 Nov 2023 06:16:44 -0800 (PST)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id w190-20020a0dedc7000000b005a7d9fca87dsm999245ywe.107.2023.11.16.06.16.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 06:16:44 -0800 (PST)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5b31c5143a0so9283847b3.3;
        Thu, 16 Nov 2023 06:16:44 -0800 (PST)
X-Received: by 2002:a81:49d8:0:b0:5a8:5079:422 with SMTP id
 w207-20020a8149d8000000b005a850790422mr16462532ywa.26.1700144204289; Thu, 16
 Nov 2023 06:16:44 -0800 (PST)
MIME-Version: 1.0
References: <20231102203922.548353-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20231102203922.548353-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 16 Nov 2023 15:16:33 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVmoknQLnkMmi-pGVjz5osE8Vx_TQy3OXH3GUfYbtDwMw@mail.gmail.com>
Message-ID: <CAMuHMdVmoknQLnkMmi-pGVjz5osE8Vx_TQy3OXH3GUfYbtDwMw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: dma: rz-dmac: Document RZ/Five SoC
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
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

On Thu, Nov 2, 2023 at 9:39 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> The DMAC block on the RZ/Five SoC is identical to one found on the RZ/G2UL
> SoC. "renesas,r9a07g043-dmac" compatible string will be used on the
> RZ/Five SoC so to make this clear, update the comment to include RZ/Five
> SoC.
>
> No driver changes are required as generic compatible string
> "renesas,rz-dmac" will be used as a fallback on RZ/Five SoC.
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

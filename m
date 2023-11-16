Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7687EE251
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 15:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345253AbjKPOG2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 16 Nov 2023 09:06:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbjKPOG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 09:06:26 -0500
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F60812F;
        Thu, 16 Nov 2023 06:06:23 -0800 (PST)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5bf58204b7aso8754877b3.3;
        Thu, 16 Nov 2023 06:06:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700143582; x=1700748382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pEPUom4+S9HspVdedIGhs90OWgXiSLz4bkpRQsQLtVY=;
        b=wDh2W52UAmJq+OUeg+wgykBKBLCJ6TFf8qd9xkhwdZY9z/mQwWuDJ2x6ZHVlYNDnNs
         eT/b0Hr2M5G88EHfFu90hhnexRQFATpv6yfoTJB4L7jqe4oR4bGR8vAKmtXCO6rMzEUL
         r3bVXjJUTaGr1Qgc/tr0443X4PAV+la4P0rLM47VWgaFBse8c4rGM7Resyh2rGmTDVBd
         G+b9Ihjxv4v0fx1YNihjtSfm46bb/ZQe23bFnNShYdkEFzqsysLwM5NFzBD3apqfd+Rg
         Dd3o8ZxhMn3HxLLLO5GX9FVDgAb43jtfSxCO3S1qPDYY5Ga2jHBAJQ1/yIyfFqXLrq74
         C+Hw==
X-Gm-Message-State: AOJu0Yw6B5ZYgRZOxo58U13j+7nIGM1JilOaiS0kQkWSoq+rO22drzds
        hE6WxjqP45Akz8YaGxxCiN7a3AlQhl+BCg==
X-Google-Smtp-Source: AGHT+IF8wudKwS97Tv3Klxmzo1yEYk5N+m59Gv7vf8mWO/WQc/WreLLot09iHG/ZwbggQDA2Ut6K6A==
X-Received: by 2002:a05:690c:368f:b0:5a7:a817:be43 with SMTP id fu15-20020a05690c368f00b005a7a817be43mr4875432ywb.6.1700143581817;
        Thu, 16 Nov 2023 06:06:21 -0800 (PST)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id i12-20020a81d50c000000b005af5bb5e840sm1005405ywj.34.2023.11.16.06.06.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 06:06:21 -0800 (PST)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-5c516f92759so8768687b3.2;
        Thu, 16 Nov 2023 06:06:21 -0800 (PST)
X-Received: by 2002:a81:6c41:0:b0:5af:a73f:53d3 with SMTP id
 h62-20020a816c41000000b005afa73f53d3mr16703732ywc.13.1700143581293; Thu, 16
 Nov 2023 06:06:21 -0800 (PST)
MIME-Version: 1.0
References: <20231115210448.31575-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20231115210448.31575-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 16 Nov 2023 15:06:10 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXRyvQ+z7O7wZ5U5y+1OcPWwzL0f1EYu1vuC67p=mBwWg@mail.gmail.com>
Message-ID: <CAMuHMdXRyvQ+z7O7wZ5U5y+1OcPWwzL0f1EYu1vuC67p=mBwWg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: net: renesas,etheravb: Document RZ/Five SoC
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Magnus Damm <magnus.damm@gmail.com>, netdev@vger.kernel.org,
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

On Wed, Nov 15, 2023 at 10:05 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> The Gigabit Ethernet IP block on the RZ/Five SoC is identical to one
> found on the RZ/G2UL SoC. "renesas,r9a07g043-gbeth" compatible string
> will be used on the RZ/Five SoC so to make this clear and to keep this
> file consistent, update the comment to include RZ/Five SoC.
>
> No driver changes are required as generic compatible string
> "renesas,rzg2l-gbeth" will be used as a fallback on RZ/Five SoC.
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

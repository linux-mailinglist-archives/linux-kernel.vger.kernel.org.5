Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFFA80B539
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 17:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbjLIQWj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 9 Dec 2023 11:22:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjLIQWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 11:22:37 -0500
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F03D5B;
        Sat,  9 Dec 2023 08:22:43 -0800 (PST)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dbc6658fda3so501161276.3;
        Sat, 09 Dec 2023 08:22:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702138962; x=1702743762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zXLi8btoKJJM+Y3mbDTAiN96eN6yPzf/fqmbiitK0RI=;
        b=vUsdZHpHpomHCWQzDmujWXh97uHAOssck5P1iGH+KCnnfiGcJ66Ld8rWL6GOtk1fvQ
         kOt62Jf9SJB/EDaip0/suHeMQuRdoxHLlxetpoMN3c61KuBIlybRu4ZuVuWnnumzuoTz
         XYAwt8bCVabDSgmImUuEypWfGaHnWLD8nyqDBHR0J/y9XAi+ylJleV9vtiiyDOnrEaDB
         1LqXfO57sBZ2s7sGdZlx95LuKTuaSPtv3NZOeODEkWtCj45SRxrZsZuM/oGfnZRrYUl8
         jYDprxr9GlrVhM3YzGG8LTwYBg+PRJLnSX1l5I3tJsBrK5YjxBNPDz1XeBuFlHnjTZQl
         kJUQ==
X-Gm-Message-State: AOJu0YzGKmr6d3fAKo7VIRFO0xgBxRRj/cRmI1Y/Gw+U3hWTodRgmo1p
        TylL8WpSdAHCNMrUpsa6NeY98Uh5aiunuQ==
X-Google-Smtp-Source: AGHT+IFCU7XFERhk9HsAv78kJrpS5GbvP2BDihMYP7wYKxRX44AUJ8Nh/X+xWa+DtpFHJqe8EgvqVw==
X-Received: by 2002:a05:6902:147:b0:db7:dacf:6206 with SMTP id p7-20020a056902014700b00db7dacf6206mr984506ybh.88.1702138962423;
        Sat, 09 Dec 2023 08:22:42 -0800 (PST)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id k18-20020a258c12000000b00d9cbf2aabc6sm1344109ybl.14.2023.12.09.08.22.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Dec 2023 08:22:42 -0800 (PST)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5cd81e76164so28977427b3.1;
        Sat, 09 Dec 2023 08:22:42 -0800 (PST)
X-Received: by 2002:a81:5cc5:0:b0:5d7:1940:dd83 with SMTP id
 q188-20020a815cc5000000b005d71940dd83mr1224179ywb.89.1702138961866; Sat, 09
 Dec 2023 08:22:41 -0800 (PST)
MIME-Version: 1.0
References: <20231120111820.87398-2-claudiu.beznea.uj@bp.renesas.com> <170207008477.398.7455050423203256596.tip-bot2@tip-bot2>
In-Reply-To: <170207008477.398.7455050423203256596.tip-bot2@tip-bot2>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sat, 9 Dec 2023 17:22:30 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVFZvrWGbwsVAfOrLGWqgoSieKrqH_kN4rvoGmw-Fsnrg@mail.gmail.com>
Message-ID: <CAMuHMdVFZvrWGbwsVAfOrLGWqgoSieKrqH_kN4rvoGmw-Fsnrg@mail.gmail.com>
Subject: Re: [tip: irq/core] clk: renesas: r9a08g045: Add IA55 pclk and its reset
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-tip-commits@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
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

Hi Thomas,

On Fri, Dec 8, 2023 at 10:14 PM tip-bot2 for Claudiu Beznea
<tip-bot2@linutronix.de> wrote:
> The following commit has been merged into the irq/core branch of tip:
>
> Commit-ID:     63385748bce1ef169438c123c7e32c021c0b9409
> Gitweb:        https://git.kernel.org/tip/63385748bce1ef169438c123c7e32c021c0b9409
> Author:        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> AuthorDate:    Mon, 20 Nov 2023 13:18:12 +02:00
> Committer:     Thomas Gleixner <tglx@linutronix.de>
> CommitterDate: Fri, 08 Dec 2023 22:06:34 +01:00
>
> clk: renesas: r9a08g045: Add IA55 pclk and its reset

Please do not apply Renesas clock patches to your tree without an
explicit ack (especially when there are nearby changes in flight).
Renesas clock patches are intended to go in through the renesas-clk
and clk trees.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

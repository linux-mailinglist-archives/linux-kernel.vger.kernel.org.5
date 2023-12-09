Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0139680B53B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 17:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbjLIQYS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 9 Dec 2023 11:24:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjLIQYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 11:24:16 -0500
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1918AD5B;
        Sat,  9 Dec 2023 08:24:23 -0800 (PST)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5d40c728fc4so22640567b3.1;
        Sat, 09 Dec 2023 08:24:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702139062; x=1702743862;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ftMXe68BPe7sn/wEG9nTEA4djliLUETYEQbnl5rzReQ=;
        b=DJow0Xo2uEs06Cl5yrTSatZzSq6kSNATCLZkA3lLOtP7yRC6zHRH4VEsQ3ECGublvS
         9hew/r9JGaPgZb0k8ch7frmkrQmhjgpdzPrxfqFY/T9mFC/6AJ3APnrpP7V55yOu9ldn
         s86nLuOsXrMY6j5k+Yp6/+qq9SEhQKY1c2QZZTye5XwKau7A6TUftmphBwHstI1vUaYg
         kxDIOJZkGmCODY9JrdVf0rv9e5yIkZ89efh2SoGKK06bXnk/SNrF6WPlYXs+6h+cdfI8
         xrYzULPoI/i08W4M1yKfDfzWrRnVCWsCA6YjTg4zjeh6R7991NpOPOg43fhxlQWkr7Mr
         +XVg==
X-Gm-Message-State: AOJu0YwfQhgB3SrjU6yVFkbpjGKxauF6NHuLWZNGdER0tbdcx4HWiP0I
        8SJ4k0CPxJmrfYZWcB4e19Xr8GCGvzsZ8Q==
X-Google-Smtp-Source: AGHT+IGiJ5UeZzU9kvUDP5lqVGRaLlcvLmVbIyfU20DuaxNCi2waXMER/WRdu4urWhf6MLITmg9JgQ==
X-Received: by 2002:a81:7102:0:b0:5d7:1940:3ef5 with SMTP id m2-20020a817102000000b005d719403ef5mr1536399ywc.38.1702139062166;
        Sat, 09 Dec 2023 08:24:22 -0800 (PST)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id fq13-20020a05690c350d00b005de8c10f283sm1341083ywb.102.2023.12.09.08.24.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Dec 2023 08:24:21 -0800 (PST)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-db54ec0c7b8so2692670276.0;
        Sat, 09 Dec 2023 08:24:21 -0800 (PST)
X-Received: by 2002:a25:b54:0:b0:db9:8492:c7ae with SMTP id
 81-20020a250b54000000b00db98492c7aemr1768008ybl.0.1702139061644; Sat, 09 Dec
 2023 08:24:21 -0800 (PST)
MIME-Version: 1.0
References: <20231120111820.87398-10-claudiu.beznea.uj@bp.renesas.com> <170207007858.398.5775493085982200914.tip-bot2@tip-bot2>
In-Reply-To: <170207007858.398.5775493085982200914.tip-bot2@tip-bot2>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sat, 9 Dec 2023 17:24:10 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUgvP9x3eTcvAnxYtH-79Mfb585EJOBYOyev_w0xfCZEg@mail.gmail.com>
Message-ID: <CAMuHMdUgvP9x3eTcvAnxYtH-79Mfb585EJOBYOyev_w0xfCZEg@mail.gmail.com>
Subject: Re: [tip: irq/core] arm64: dts: renesas: r9108g045: Add IA55
 interrupt controller node
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

On Fri, Dec 8, 2023 at 10:16 PM tip-bot2 for Claudiu Beznea
<tip-bot2@linutronix.de> wrote:
> The following commit has been merged into the irq/core branch of tip:
>
> Commit-ID:     8794f5c3d2299670d16b2fb1e6657f5f33c1518c
> Gitweb:        https://git.kernel.org/tip/8794f5c3d2299670d16b2fb1e6657f5f33c1518c
> Author:        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> AuthorDate:    Mon, 20 Nov 2023 13:18:20 +02:00
> Committer:     Thomas Gleixner <tglx@linutronix.de>
> CommitterDate: Fri, 08 Dec 2023 22:06:35 +01:00
>
> arm64: dts: renesas: r9108g045: Add IA55 interrupt controller node

Please do not apply Renesas DTS patches to your tree without an
explicit ack.
Renesas DTS patches are intended to go in through the renesas-devel
and soc trees.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

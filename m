Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1B2D759888
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 16:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbjGSOhe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 19 Jul 2023 10:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbjGSOhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 10:37:04 -0400
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4A310E5;
        Wed, 19 Jul 2023 07:37:02 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-5704fce0f23so74157877b3.3;
        Wed, 19 Jul 2023 07:37:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689777422; x=1692369422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=766U5ZrZx7633jGu4x/jDYUFK9E93rbSDM5/tiBPbjE=;
        b=Um3d7hU1HvrfIMqyVRykNN7Til291WQ7Gh8KiZW+swFFxo2AFacKMxcdLIXAaHQ72L
         G6lLypiqpDImxkDWAfnAQ+UPdgBH/Aim1bz0JiiYdWzBeEE2Grgvo55+YTyAHrPSSM7D
         SdzGg0KLXWbOcbS7pj/ZRpgRjUO2vTt4MVHHFwecefzZ9xxFAI0hmbLjnCRHDZn+LGMe
         3VV0KNItYajt1qZBr5GXilHq76BI2G4Q0brdZPKCCAleWllmNrM13Z/YuKDnUpKN/mxc
         Fw03Q53L0Th270b40VlgnBBPqCaNZomSWoPRspTzH28JnL11CC9Bwd8XdUXdfJ2zigPP
         6g6A==
X-Gm-Message-State: ABy/qLYMhtlD/NAI8cFX4CryEdT3B1QUaKNNnxv+gwH3oRYbA9bplc9m
        qbAyX5M4llw4mla/ny0l6TQHLQ7ryZDemg==
X-Google-Smtp-Source: APBJJlE0pkRGxBPVDcSO6vvzZZz1wEd90Knpum2vgyodq5EPMAxv7wLMRE9HRsWoWxmk3KVvegFF5Q==
X-Received: by 2002:a81:5294:0:b0:56d:1747:5bde with SMTP id g142-20020a815294000000b0056d17475bdemr2613531ywb.32.1689777421776;
        Wed, 19 Jul 2023 07:37:01 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id n5-20020a0dcb05000000b00579f1c5ebdasm1051532ywd.15.2023.07.19.07.37.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 07:37:01 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-cefa8fe4cc2so1449761276.1;
        Wed, 19 Jul 2023 07:37:00 -0700 (PDT)
X-Received: by 2002:a5b:1c7:0:b0:c69:54aa:d441 with SMTP id
 f7-20020a5b01c7000000b00c6954aad441mr2403900ybp.34.1689777420399; Wed, 19 Jul
 2023 07:37:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230719134058.2138934-1-arnd@kernel.org>
In-Reply-To: <20230719134058.2138934-1-arnd@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 19 Jul 2023 16:36:47 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUzuTXgd5wspGOy2-AL8sgXmr3GVDV3+hLCu5zkWM_yxw@mail.gmail.com>
Message-ID: <CAMuHMdUzuTXgd5wspGOy2-AL8sgXmr3GVDV3+hLCu5zkWM_yxw@mail.gmail.com>
Subject: Re: [PATCH] rtc: bq4802: add sparc dependency
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "David S . Miller" <davem@davemloft.net>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
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

Hi Arnd,

On Wed, Jul 19, 2023 at 3:41 PM Arnd Bergmann <arnd@kernel.org> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> The added HAS_IOPORT dependency might not actually be necessary as Geert
> points out, but the driver is also only used on one architecture. Sparc
> is also a special case here since it converts port numbers into virtual
> addresses rather than having them mapped into a particular part of the
> __iomem address space, so the difference is actually not important here.
>
> Add a dependency on sparc, but allow compile-testing otherwise, to
> make this clearer without anyone having to spend much time modernizing
> the driver beyond that.
>
> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: David S. Miller <davem@davemloft.net>
> Link: https://lore.kernel.org/all/CAMuHMdWEx0F=fNei4Bz_JPkuvoaN-+zk08h0i8KnSi_VjO615g@mail.gmail.com/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for your patch!

> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -1195,7 +1195,7 @@ config RTC_DRV_MSM6242
>
>  config RTC_DRV_BQ4802
>         tristate "TI BQ4802"
> -       depends on HAS_IOMEM && HAS_IOPORT
> +       depends on SPARC || (HAS_IOMEM && HAS_IOPORT && COMPILE_TEST)

I'd rather just add a line "depends on SPARC || COMPILE_TEST",
which is easier to parse.

>         help
>           If you say Y here you will get support for the TI
>           BQ4802 RTC chip.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

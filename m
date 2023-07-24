Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A349C75EEAA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 11:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjGXJGp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 24 Jul 2023 05:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbjGXJGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 05:06:37 -0400
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C307137
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 02:06:36 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5838881e30bso44141617b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 02:06:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690189595; x=1690794395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mnTcJANMzNU9SJo+kur+ytZi7HW/VI2ifVeb/K70ZlM=;
        b=X+Gf3xMrW/atILqsYHOLpYduS+gcGK9xuosXxIDwLRtpHgLmOAc6zpwJOuO2GQ41OO
         YUQaCZAPatFz+oJLNnyTc9rBj42QAZoPFqHFXal6owBha3WZLpAIygVP+LccQ7Owvuk5
         B7zDFgOuVOBsBBvNn3KACElMh6a8rhitWq2FehzPR7BRimHsFe4jKcR158lym/av+b0T
         JGsiEg3pNqpBtydzqfIgtY4Vy6u+SWZNfWKTt/rKalXIXKSbHW1XH4Xj0QO0ZBuVvLlH
         z1pWKjmu7c3V1TrdWcs6hQ+dGazuUwUAfvLtKr7DjOgvdsi4V5NQkMwadQ3W6TvWDOvw
         zlCQ==
X-Gm-Message-State: ABy/qLbZAYTdkWkL+cSAsjNwIJxLXekAr3ojoVzRK/E2mrxPFsjUztev
        3/hmgc/zQ1yFdmNukwYkOOzw9w4pDOobLA==
X-Google-Smtp-Source: APBJJlHkJJiYU+JiYCP8WOSzYKsEinyr4FqHF47iKWCma4vYBHZWnunqwsQK1k+9KBnypQMnZbh4bw==
X-Received: by 2002:a81:6741:0:b0:57a:8de9:16a3 with SMTP id b62-20020a816741000000b0057a8de916a3mr5575898ywc.8.1690189595520;
        Mon, 24 Jul 2023 02:06:35 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id p185-20020a0dcdc2000000b0057a6e41aad1sm2640441ywd.67.2023.07.24.02.06.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 02:06:35 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-cf284f4d7afso4624144276.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 02:06:35 -0700 (PDT)
X-Received: by 2002:a25:27c9:0:b0:c4c:fee5:428 with SMTP id
 n192-20020a2527c9000000b00c4cfee50428mr6804002ybn.24.1690189594869; Mon, 24
 Jul 2023 02:06:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230720033737.2092-1-xujianghui@cdjrlc.com> <006368d8cf146a4e41d860b615d4b3ec@208suo.com>
In-Reply-To: <006368d8cf146a4e41d860b615d4b3ec@208suo.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 24 Jul 2023 11:06:23 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV_hdNHcH5jbqc2kAZ4ba0uH=AXsKcj0teXN0Pj5G9s=A@mail.gmail.com>
Message-ID: <CAMuHMdV_hdNHcH5jbqc2kAZ4ba0uH=AXsKcj0teXN0Pj5G9s=A@mail.gmail.com>
Subject: Re: [PATCH] m68k: q40: add missing spaces around '='
To:     sunran001@208suo.com
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ran,

On Thu, Jul 20, 2023 at 5:54 AM <sunran001@208suo.com> wrote:
> add missing spaces to clear checkpatch errors.
>
> ERROR: spaces required around that '=' (ctx:VxV)
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>

WARNING: From:/Signed-off-by: email name mismatch: 'From:
sunran001@208suo.com' != 'Signed-off-by: Ran Sun
<sunran001@208suo.com>'

> ---
>   arch/m68k/q40/q40ints.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/arch/m68k/q40/q40ints.c b/arch/m68k/q40/q40ints.c
> index 127d7ecdbd49..fdd6e48f4fe3 100644
> --- a/arch/m68k/q40/q40ints.c
> +++ b/arch/m68k/q40/q40ints.c
> @@ -132,10 +132,10 @@ static irqreturn_t q40_timer_int(int irq, void
> *dev_id)
>   {
>         ql_ticks = ql_ticks ? 0 : 1;
>         if (sound_ticks) {
> -               unsigned char sval=(sound_ticks & 1) ? 128-SVOL : 128+SVOL;
> +               unsigned char sval = (sound_ticks & 1) ? 128-SVOL : 128+SVOL;
>                 sound_ticks--;
> -               *DAC_LEFT=sval;
> -               *DAC_RIGHT=sval;
> +               *DAC_LEFT = sval;
> +               *DAC_RIGHT = sval;
>         }
>
>         if (!ql_ticks) {
> @@ -171,7 +171,7 @@ void q40_sched_init (void)
>
>   struct IRQ_TABLE{ unsigned mask; int irq ;};
>   #if 0
> -static struct IRQ_TABLE iirqs[]={
> +static struct IRQ_TABLE iirqs[] = {
>     {Q40_IRQ_FRAME_MASK,Q40_IRQ_FRAME},
>     {Q40_IRQ_KEYB_MASK,Q40_IRQ_KEYBOARD},
>     {0,0}};
> @@ -189,7 +189,7 @@ static struct IRQ_TABLE eirqs[] = {
>   };
>
>   /* complain only this many times about spurious ints : */
> -static int ccleirq=60;    /* ISA dev IRQs*/
> +static int ccleirq = 60;    /* ISA dev IRQs*/
>   /*static int cclirq=60;*/     /* internal */
>
>   /* FIXME: add shared ints,mask,unmask,probing.... */

This patch is whitespace-damaged, so it fails to apply.

These problems are present in all your patches, so something is
wrong in your workflow.  Please test your patches by running
scripts/checkpatch.pl, emailing them to yourself, and trying to
apply them.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC7F75EEED
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 11:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbjGXJS7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 24 Jul 2023 05:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232217AbjGXJSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 05:18:48 -0400
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B706AE7C
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 02:18:46 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-577497ec6c6so46418137b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 02:18:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690190325; x=1690795125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=auSj/YqkFpBoqyvR9iArXsraNG0PdoY9urEx1pkdLEs=;
        b=S4iSpsUKFpcxD4Lwzg1BA9kMhUSMAcXOIEW4LEuq1OKFsc702MqiN1N4sbzFLn+Ppo
         ZBYL7ywC5LZ4fZdg7Lf170EQ7kOAz7s4pHjB4e17RWg1LsSnEB06e6C1w7LSxXFJjI+J
         zywFIAXcHeW4nUfsVnACSCToE8h3aiP0hO9FS+0qwqnK/SE0PAauLnCZERgkpZNbb21M
         I6uoVoGnDS1WEdDlu301UO+BtTyHfRC+Ax5uz/0svqy3VwfSlaYg/ko/ACYsHAcrDnG4
         QDUp+GmF0QoAKJD8Hv3IeOqpNI9SAKRZ6zKxhSeaUIfz0+grpwyp6T5Sjw7JunB7wRIi
         XlGw==
X-Gm-Message-State: ABy/qLY9HL4cvlWmK88TPJts/jVvXNznkK7EnbwckaMilHZn8upgDzlQ
        9602nIvesAXQ2DRo2/fhLJ1WaN5hqf5l4Q==
X-Google-Smtp-Source: APBJJlH05cy1CoeLeEyWdP80d+tKk9tju+SvSFkbiI5cWRCQR9NcuREQKHCgNSFPehKh+DMsyOw3Vg==
X-Received: by 2002:a0d:f446:0:b0:54f:9cd0:990 with SMTP id d67-20020a0df446000000b0054f9cd00990mr6152636ywf.18.1690190325678;
        Mon, 24 Jul 2023 02:18:45 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id v188-20020a8185c5000000b0056cd3e598d8sm2643818ywf.114.2023.07.24.02.18.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 02:18:45 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-ca4a6e11f55so3346018276.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 02:18:45 -0700 (PDT)
X-Received: by 2002:a25:6943:0:b0:d0b:47e7:9295 with SMTP id
 e64-20020a256943000000b00d0b47e79295mr3000359ybc.25.1690190324939; Mon, 24
 Jul 2023 02:18:44 -0700 (PDT)
MIME-Version: 1.0
References: <4994ede231971e39e3b7f51844d8868a@208suo.com>
In-Reply-To: <4994ede231971e39e3b7f51844d8868a@208suo.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 24 Jul 2023 11:18:33 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWTD756HS+Egt6uHWjJvt8Z+Oz8GpVcJGiP4q6O6fjP+g@mail.gmail.com>
Message-ID: <CAMuHMdWTD756HS+Egt6uHWjJvt8Z+Oz8GpVcJGiP4q6O6fjP+g@mail.gmail.com>
Subject: Re: [PATCH] m68k: Fix the following checkpatch error:
To:     zhangyongle001@208suo.com
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

Hi Zhangyong,

On Thu, Jul 20, 2023 at 11:50 AM <zhangyongle001@208suo.com> wrote:
> ERROR: that open brace { should be on the previous line
> ERROR: that open brace { should be on the previous line
> ERROR: else should follow close brace '}'
>
> Signed-off-by: zhangyongle <zhangyongle001@208suo.com >

Thanks for your patch!

But obviously you forgot to run scripts/checkpatch.pl on your own patch:

    WARNING: A patch subject line should describe the change not the
tool that found it
    #2:
    Subject: [PATCH] m68k: Fix the following checkpatch error:

    ERROR: Unrecognized email address: 'zhangyongle
<zhangyongle001@208suo.com >'
    #14:
    Signed-off-by: zhangyongle <zhangyongle001@208suo.com >

    WARNING: From:/Signed-off-by: email address mismatch: 'From:
zhangyongle001@208suo.com' != 'Signed-off-by: zhangyongle
<zhangyongle001@208suo.com >'

> --- a/arch/m68k/bvme6000/config.c
> +++ b/arch/m68k/bvme6000/config.c
> @@ -290,8 +290,7 @@ int bvme6000_hwclk(int op, struct rtc_time *t)
>
>         rtc->msr = 0x40;        /* Ensure clock and real-time-mode-register
>                                  * are accessible */
> -       if (op)
> -       {       /* Write.... */
> +       if (op) {       /* Write.... */
>                 rtc->t0cr_rtmr = t->tm_year%4;
>                 rtc->bcd_tenms = 0;
>                 rtc->bcd_sec = bin2bcd(t->tm_sec);
> @@ -303,9 +302,7 @@ int bvme6000_hwclk(int op, struct rtc_time *t)
>                 if (t->tm_wday >= 0)
>                         rtc->bcd_dow = bin2bcd(t->tm_wday+1);
>                 rtc->t0cr_rtmr = t->tm_year%4 | 0x08;
> -       }
> -       else
> -       {       /* Read....  */
> +       } else {        /* Read....  */
>                 do {
>                         t->tm_sec  = bcd2bin(rtc->bcd_sec);
>                         t->tm_min  = bcd2bin(rtc->bcd_min);

This patch is whitespace-damaged, and fails to apply.

These problems are present in all your patches, so something is
wrong in your workflow.  Please test your patches by running
scripts/checkpatch.pl, emailing them to yourself, and trying to
apply them.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

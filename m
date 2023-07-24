Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F08F75EEC8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 11:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbjGXJMp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 24 Jul 2023 05:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232152AbjGXJMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 05:12:42 -0400
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B86612A
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 02:12:40 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-583fe10bb3cso5070377b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 02:12:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690189959; x=1690794759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3j0v2+mohYZTqHHH0/BpIIhzkfCW49v4SBL4Epd6EJQ=;
        b=N5BEMVkhNM2cEKrl4dk3LAlkvcI8AJe2pStioOqMG2oYMvS+wB8vEijYpAOLw0MVkH
         U6UIUnmeEtc8qT9L/mj/S3r/W2Ik+Ws4g5JTU5LQmy8XQ4ZSY64/tNtJxnBUMBfSRP3V
         rJDA5lgQcQFAr9ulob5pg+CjIQnb5vgZB4uE8fjAXmeRbYg81JE9FbjJG7APvJgL9Ar9
         cUaqSdczV6BAaGs3a6xYYhlNZIs01CYCLBgFhVLNyZtmPcxhDWHioBTI1qes8Bs1YSR9
         vmPYi15MSVe5fTD3/MMKS6dRY994xCcmLxQXGBakRtJJNc2SOdyUSJQF14Rk8eGfsBbd
         elNQ==
X-Gm-Message-State: ABy/qLbVkLxxS4sHiMV7khXeKVktA8XkZnc0UexSY7YoiZB8qlkmMHtD
        EGHNkE8M7tXc01g/YMUCGLTSVy0730nYiw==
X-Google-Smtp-Source: APBJJlEdspMvCcDdGUdyzgjUPGkEh6jODpKUSTJoaAUC/1CnaQ4/mD+5kDiGFIyjWOeptXOoE3D6Jw==
X-Received: by 2002:a0d:db91:0:b0:565:f14b:6cdb with SMTP id d139-20020a0ddb91000000b00565f14b6cdbmr7860190ywe.21.1690189959435;
        Mon, 24 Jul 2023 02:12:39 -0700 (PDT)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id r11-20020a81c30b000000b0057a57a9a932sm2603189ywk.107.2023.07.24.02.12.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 02:12:38 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-577412111f0so50990007b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 02:12:38 -0700 (PDT)
X-Received: by 2002:a81:838e:0:b0:577:2f3f:dd20 with SMTP id
 t136-20020a81838e000000b005772f3fdd20mr8269635ywf.34.1690189958745; Mon, 24
 Jul 2023 02:12:38 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_2AC782146D133A82E7D99024161D14AD4209@qq.com> <b29994cca39551c7c3827a733e7c1246@208suo.com>
In-Reply-To: <b29994cca39551c7c3827a733e7c1246@208suo.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 24 Jul 2023 11:12:27 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVPQ-C-td4VKsm11Dsmt0G+sO-T2u0RazLBu15L46+ywQ@mail.gmail.com>
Message-ID: <CAMuHMdVPQ-C-td4VKsm11Dsmt0G+sO-T2u0RazLBu15L46+ywQ@mail.gmail.com>
Subject: Re: [PATCH] m68k: q40: Add space around '='
To:     hanyu001@208suo.com
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

Hi Hanyu,

On Thu, Jul 13, 2023 at 8:40 AM <hanyu001@208suo.com> wrote:
> This patch fixes the checkpatch.pl error:
>
> ./arch/m68k/q40/q40ints.c:135: ERROR: spaces required around that '='
> (ctx:VxV)
> ./arch/m68k/q40/q40ints.c:137: ERROR: spaces required around that '='
> (ctx:VxV)
> ./arch/m68k/q40/q40ints.c:138: ERROR: spaces required around that '='
> (ctx:VxV)
>
> Signed-off-by: maqimei <2433033762@qq.com>

Thanks for your patch!

But obviously you forgot to run scripts/checkpatch.pl on your own patch:

    ERROR: patch seems to be corrupt (line wrapped?)
    #81: FILE: arch/m68k/q40/q40ints.c:131:
    *dev_id)

    ERROR: Missing Signed-off-by: line by nominal patch author
'hanyu001@208suo.com'

> Fwd: [PATCH] m68k: q40: Add space around '='

Please do not forward patches, as this breaks the tooling.
The proper way to handle this is to add your own Signed-off-by tag,
and submit it yourself, cfr.
https://elixir.bootlin.com/linux/latest/source/Documentation/process/submitting-patches.rst#L434

> index 127d7ec..bede94a 100644
> --- a/arch/m68k/q40/q40ints.c
> +++ b/arch/m68k/q40/q40ints.c
> @@ -132,10 +132,10 @@ static irqreturn_t q40_timer_int(int irq, void
> *dev_id)
>   {
>       ql_ticks = ql_ticks ? 0 : 1;
>       if (sound_ticks) {
> -        unsigned char sval=(sound_ticks & 1) ? 128-SVOL : 128+SVOL;
> +        unsigned char sval = (sound_ticks & 1) ? 128-SVOL : 128+SVOL;
>           sound_ticks--;
> -        *DAC_LEFT=sval;
> -        *DAC_RIGHT=sval;
> +        *DAC_LEFT = sval;
> +        *DAC_RIGHT = sval;
>       }
>
>       if (!ql_ticks) {

This patch is whitespace-damaged and fails to apply.

Please test your patches by running scripts/checkpatch.pl, emailing
them to yourself, and trying to apply them.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

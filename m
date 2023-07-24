Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C86375EE98
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 11:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbjGXJBO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 24 Jul 2023 05:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbjGXJAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 05:00:53 -0400
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E698F10C4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 02:00:50 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-57026f4bccaso51338237b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 02:00:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690189250; x=1690794050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VOXvAdgGFfyUI6gOLSWZe+HVhUskG1Kl4mS4DRRwsNQ=;
        b=ku2ciN+aicHvMS6627qbhTKiHthrCORvIu6cKD72C4cjvtK5ZP/AmhXrgWQtol3cqm
         greAlndZ+9/FxKcKRn1WqfEgn7fvuMxd9aoWZiqE+CVX8Q5Zig5EuKKxf5w0maJ6ygxC
         aFsfjUnuh+MSyW1QQyVes7rBVRmav4ZfDFE2CD6jKVeGcSsnWaCf8cCn0PcA+s2POl1P
         LqkPGoRscy7lkoJrHIN5eTLlCTX336xx09QAR5X+hAvtZhh164PHJXtS5ndQmnlBdNGu
         mywVTep56rtMFQNiDTrt6O/nfiUe5t4/z/9Li+isqieOyiqVuPqoQbziNjY9UpkhVOGc
         u9Dw==
X-Gm-Message-State: ABy/qLZrdir4X1MlFpNCnnJ1u85XToZCPeEt/dIKDglcnRMDqJg3lY5a
        ZZ3HxuEz0z10KEKFgI9zxWQ5yMDKeU+gUA==
X-Google-Smtp-Source: APBJJlGDwtJ6BZlPZYJFzDJAaFWb4u6Ks1abETydkidvc1houi5L/AlQ+VdwS8nY1mXciaNglabheQ==
X-Received: by 2002:a0d:d002:0:b0:577:1a4e:51f with SMTP id s2-20020a0dd002000000b005771a4e051fmr6846317ywd.39.1690189249770;
        Mon, 24 Jul 2023 02:00:49 -0700 (PDT)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id i190-20020a0ddfc7000000b005837fe8dbe8sm2666495ywe.8.2023.07.24.02.00.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 02:00:49 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-570877f7838so51451607b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 02:00:49 -0700 (PDT)
X-Received: by 2002:a0d:cc0f:0:b0:56d:2d59:dc30 with SMTP id
 o15-20020a0dcc0f000000b0056d2d59dc30mr6549898ywd.24.1690189248957; Mon, 24
 Jul 2023 02:00:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230713080020.72931-1-panzhiai@cdjrlc.com> <9dc7423a9e54f849212f21a59074ffb4@208suo.com>
In-Reply-To: <9dc7423a9e54f849212f21a59074ffb4@208suo.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 24 Jul 2023 11:00:37 +0200
X-Gmail-Original-Message-ID: <CAMuHMdViE_OMQC=Y9T30oK6Ho1zXegLoYN4KhWGHzuimkpeGTA@mail.gmail.com>
Message-ID: <CAMuHMdViE_OMQC=Y9T30oK6Ho1zXegLoYN4KhWGHzuimkpeGTA@mail.gmail.com>
Subject: Re: [PATCH] m68k: sun3: idprom: ERROR: "foo* bar" should be "foo *bar"
To:     hexingwei001@208suo.com
Cc:     sammy@sammy.net, linux-m68k@lists.linux-m68k.org,
        linux-kernel@vger.kernel.org
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

On Thu, Jul 13, 2023 at 10:09 AM <hexingwei001@208suo.com> wrote:
> Fix one occurrences of the checkpatch.pl error:
> ERROR: "foo* bar" should be "foo *bar"
>
> Signed-off-by: Xingwei He <hexingwei001@208suo.com>

Thanks for your patch!
But obviously you forgot to run scripts/checkpatch.pl on your own patch:

WARNING: From:/Signed-off-by: email name mismatch: 'From:
hexingwei001@208suo.com' != 'Signed-off-by: Xingwei He
<hexingwei001@208suo.com>'

> --- a/arch/m68k/sun3/idprom.c
> +++ b/arch/m68k/sun3/idprom.c
> @@ -83,7 +83,7 @@ static void __init display_system_type(unsigned char
> machtype)
>       prom_halt();
>   }
>
> -void sun3_get_model(unsigned char* model)
> +void sun3_get_model(unsigned char *model)
>   {
>       register int i;

Whitespace-damaged, so it fails to apply.

These problems are present in all your patches, so something is\
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

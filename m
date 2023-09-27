Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C41E27AFF9B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 11:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjI0JOk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 27 Sep 2023 05:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjI0JOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:14:38 -0400
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5371492;
        Wed, 27 Sep 2023 02:14:37 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-59f6763767dso86982997b3.2;
        Wed, 27 Sep 2023 02:14:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695806076; x=1696410876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UCmAMEKxsbpyE7i3bverVeCE3tcUHYYc3K+oAbcgOZg=;
        b=NTcWhZhrTzyuRR3yNxa2MHSdW6fAwuj8b3tJnAuk2Sx1u9kiaQSzhBA0y0Zy0I5jTx
         fW4Th3FX0kYi1dCtQWZvdodzQ03jWxd/08+n/5ClH/4UJcLgiaomf+o2rotnZUTXEGhz
         y6oueZ3mYEpbXs24IB6l59CrgvgRymSSxfRpC1bN1X2HLr2Vc8N5vT2kbdRbdnc+N3hP
         MZYwYBARBW/Ya3Wx0Ei3V75LGFar+3wuE1SBUoyewevfddD3OWH7pAUnxCt1gTbh/aA8
         lhNPU/+rNRuUM8VlzgA9ZMiA97qyFxjDEqbHmOtz1EGYlQjuyZajTBNc4Mp3g0UJW6w5
         b5zg==
X-Gm-Message-State: AOJu0YyX57lpYG+NWne8AVEoGDk0L+1x/0XJ+TsIUxqrxUgGeXIby14A
        +ay5Yd7YInZ0keIa7ODqEfUlPnDUXzgaYQ==
X-Google-Smtp-Source: AGHT+IHfdRsRQz+EgeKfuGDZ8GoGTluhQYt85yQZNRRRI+7IqqVrFwoYlXuULGiaTo56w660j8cSbQ==
X-Received: by 2002:a0d:cbd6:0:b0:599:da80:e1eb with SMTP id n205-20020a0dcbd6000000b00599da80e1ebmr1946807ywd.24.1695806076350;
        Wed, 27 Sep 2023 02:14:36 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id r76-20020a0de84f000000b0059beb468cb4sm3608401ywe.1.2023.09.27.02.14.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 02:14:36 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-59f6763767dso86982687b3.2;
        Wed, 27 Sep 2023 02:14:36 -0700 (PDT)
X-Received: by 2002:a0d:e20a:0:b0:571:11ea:b2dd with SMTP id
 l10-20020a0de20a000000b0057111eab2ddmr1882319ywe.32.1695806075868; Wed, 27
 Sep 2023 02:14:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230927010207.78326-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20230927010207.78326-1-yang.lee@linux.alibaba.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 27 Sep 2023 11:14:23 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX_6PBsriisDvAzOJHjUC6fzFHakuajo39RhqHmq6PYYA@mail.gmail.com>
Message-ID: <CAMuHMdX_6PBsriisDvAzOJHjUC6fzFHakuajo39RhqHmq6PYYA@mail.gmail.com>
Subject: Re: [PATCH -next] ARM: shmobile: Remove unneeded semicolon
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     magnus.damm@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yang,

On Wed, Sep 27, 2023 at 3:02 AM Yang Li <yang.lee@linux.alibaba.com> wrote:
> ./arch/arm/mach-shmobile/smp-sh73a0.c:52:2-3: Unneeded semicolon
> ./arch/arm/mach-shmobile/smp-r8a7779.c:46:2-3: Unneeded semicolon
> ./arch/arm/mach-shmobile/pm-rcar-gen2.c:58:2-3: Unneeded semicolon
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=6704
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Thanks for your patch!

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

As the offending commits are not yet upstream, I will fold the fixes
into the existing commits.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

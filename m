Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9C37B0F7B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 01:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjI0XKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 19:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjI0XKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 19:10:42 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324B1F4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 16:10:40 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-59f55c276c3so117439747b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 16:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695856239; x=1696461039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wHwX/aglCTTh1ju8WlaQPdf+VO1J2oc+nQUTcYKzllc=;
        b=rzIrlgZ2tYhwunWSyePN1IfqkrGVuxPz7KEX/sYizwqdMIPv7jXEwgBEHFEVVCHYFU
         H+04fhE4P57RCqQCxO8GqeyxTdNAGRSODBE1wKt+CFPEnBQyYKBi7475Srj2nQb7MWcG
         /Wc4KUbJHwbGr18OU1mOC4A6a2G3v1Amo07ilyDmsoPbAgkeGfCj2pKkdCuQORq4RrR8
         CZ192Iu7hd3WVVj4ma40fmm6yleWd524UId0Dc0YECc8tHOfrxiNE9nieX/lDqEBh5Q3
         dxC5eVtEUvKMffv+9TvlBpCwF1aVX9npe4IzQMU6oROkc0GMdBSXW1vQUUHzO4XguLdF
         iEpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695856239; x=1696461039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wHwX/aglCTTh1ju8WlaQPdf+VO1J2oc+nQUTcYKzllc=;
        b=Zzd/MB4ubuzlJCxpna1CWdtxFDrcH4o6eS5O9asYUtwsi/ERFtxE0qAoR+AyqFb7EP
         xT1iNswMDSRv50HjqANy4XXKmZEOkxGe5cCpeQY1GDaWo99HPoLOzALuys05RTJj3MSD
         yFfxnd5DDcACn7BRnnmzWynidC8cVCHtof79+553Vf0ia0Ixkpfthevx0RfSyGkIwjgj
         2oo+n7levilirckXQrm9NaT/byGoLwtXnFgB18P72syZWsleyTBy3LlmUPGVbbKUPa/m
         V/e0BYJD0iWnJO/Ou9J3xn5ZkB8DXbV9PDaikkBYL59bH0KVQbqy+DQK1DS1gZzka8LZ
         68ew==
X-Gm-Message-State: AOJu0YzwijI02gUIg2Hn7kv2Lx/HC/rkXf+EQHx2+eaJhqOPYlaGdSxN
        MXwu8gWP5Y1kCYZbztFWsGl+706IijsLSt/2uzt7NA==
X-Google-Smtp-Source: AGHT+IH/8t4+WQwmGKXKh1PJPt6zrQ+pZbYnVAoCqi/9rPlYgXC8VEOVVrDdQLYQvzX/N+VMTXb7bRUZpa9Js/j6CuE=
X-Received: by 2002:a0d:e8d1:0:b0:586:b686:8234 with SMTP id
 r200-20020a0de8d1000000b00586b6868234mr4541727ywe.8.1695856239387; Wed, 27
 Sep 2023 16:10:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230926175208.9298-1-james.quinlan@broadcom.com> <20230926175208.9298-2-james.quinlan@broadcom.com>
In-Reply-To: <20230926175208.9298-2-james.quinlan@broadcom.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 28 Sep 2023 01:10:27 +0200
Message-ID: <CACRpkdYGPpUUCqmJLT4t+6CNOOmRAh_vYPSPK1SWy+tNycnSqQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] ARM: Select DMA_DIRECT_REMAP to fix restricted DMA
To:     Jim Quinlan <james.quinlan@broadcom.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Eric DeVolder <eric.devolder@oracle.com>,
        Nathan Chancellor <nathan@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jim,

thanks for your patch!

On Tue, Sep 26, 2023 at 7:52=E2=80=AFPM Jim Quinlan <james.quinlan@broadcom=
.com> wrote:

> Without this commit, the use of dma_alloc_coherent() while
> using CONFIG_DMA_RESTRICTED_POOL=3Dy breaks devices from working.
> For example, the common Wifi 7260 chip (iwlwifi) works fine
> on arm64 with restricted memory but not on arm, unless this
> commit is applied.
>
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>

(...)
> +       select DMA_DIRECT_REMAP

Christoph invented that symbol so he can certainly
explain what is missing to use this on ARM.

This looks weird to me, because:
> git grep atomic_pool_init
arch/arm/mm/dma-mapping.c:static int __init atomic_pool_init(void)
kernel/dma/pool.c:static int __init dma_atomic_pool_init(void)

Now you have two atomic DMA pools in the kernel,
and a lot more than that is duplicated. I'm amazed that it
compiles at all.

Clearly if you want to do this, surely the ARM-specific
arch/arm/mm/dma-mapping.c and arch/arm/mm/dma-mapping-nommu.c
needs to be removed at the same time?

However I don't think it's that simple, because Christoph would surely
had done this a long time ago if it was that simple.

Yours,
Linus Walleij

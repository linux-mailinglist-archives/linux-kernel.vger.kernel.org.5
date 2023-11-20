Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 831547F1A10
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 18:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233703AbjKTRci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 12:32:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233789AbjKTRcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 12:32:36 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A98112
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 09:32:31 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-a00d5b0ec44so54469766b.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 09:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1700501549; x=1701106349; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ObGB9aqfCaCmROEd5HBVW5NBm+BS50G0iVX32TIItAM=;
        b=KrxNkRWrgjXD0iLA1/Gl/7DRujhTakCf2ufYDnJ+d+B9ftQ23o1dzeWJGrih2iDMC3
         lsu9+NkIFCJSbun3E1WyM93byGTZvxknTQbVAo/He95+b/RZqLYIQKaR+1Wlme5lRILh
         WIMFPQrgVGXazeu/zlgQrTHSvA3U+s4lU3rDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700501549; x=1701106349;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ObGB9aqfCaCmROEd5HBVW5NBm+BS50G0iVX32TIItAM=;
        b=Z/aXvbe6rMWDaSAhPJuC0CUvrPVrcTsc1wrq420tCNnTsMQBVU6t9WP8s2MUjWapdU
         XpSoql5fTgmup4xc56ilyLeM1UTZmJO3KuHxNYp8I9kk0nr1cL1ybWf5snTCX8AyOA7e
         F3P0edAjmtRXV0R7d16mVyDUGrZYVx6dKnIVX/i1dww81oUaYMG6JXmf/IKMiTIvI47R
         hK4UbJwLKAJb7PezlqYw/EcHJZQwfkacLcLnCnOjrgu5h1QVDR/HClVaFzjis8Dt3KQv
         3+F4mFPzNWo9nRiwCTyVoAtw0IM+FWQtP4AsXxRGP7gwA3EePWR0K+zJ2TRVOqEaWGUo
         4wiQ==
X-Gm-Message-State: AOJu0YwiYG7xVfAl3qV7nDAjzln+UsYqea5Juc20vfkhKqDb/vfSAXli
        6bLMKvMaBLa20O2dR9mT/BOf6F1z4sx0+eGVRbFXnQ==
X-Google-Smtp-Source: AGHT+IH7oTEVe8JlgTZxV2j48HRHendJpzuJ62UpCJeA/DsmJTUVDrN0Cx+xvjOfX1mlhrQaa6uBTg==
X-Received: by 2002:a17:907:d40a:b0:9c0:99c4:79e8 with SMTP id vi10-20020a170907d40a00b009c099c479e8mr8492215ejc.6.1700501549373;
        Mon, 20 Nov 2023 09:32:29 -0800 (PST)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id g3-20020a17090669c300b009ae69c303aasm4095664ejs.137.2023.11.20.09.32.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 09:32:28 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-548f0b7ab9eso301489a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 09:32:28 -0800 (PST)
X-Received: by 2002:aa7:cccf:0:b0:53f:6ed5:4dab with SMTP id
 y15-20020aa7cccf000000b0053f6ed54dabmr62888edt.24.1700501548302; Mon, 20 Nov
 2023 09:32:28 -0800 (PST)
MIME-Version: 1.0
References: <ZVf/pqw5YcF7sldg@shikoro> <CAHk-=wi9a9u+1cAxxHw7KxXsfPvdWCbhatK7enFSjgwjrovCZA@mail.gmail.com>
 <20231120150515.GA32570@willie-the-truck>
In-Reply-To: <20231120150515.GA32570@willie-the-truck>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 20 Nov 2023 09:32:11 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgKAVyPtoQELWC-9DCwXQnZv+oVSOfPQtn237VT9h9A0Q@mail.gmail.com>
Message-ID: <CAHk-=wgKAVyPtoQELWC-9DCwXQnZv+oVSOfPQtn237VT9h9A0Q@mail.gmail.com>
Subject: Re: [PULL REQUEST] i2c-for-6.7-rc2
To:     Will Deacon <will@kernel.org>
Cc:     Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Rosin <peda@axentia.se>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andi Shyti <andi.shyti@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2023 at 07:05, Will Deacon <will@kernel.org> wrote:
>
> and I think the high-level problem was something like:
>
> 1. CPU x writes some stuff to memory (I think one example was i2c_dw_xfer()
>    setting 'dev->msg_read_idx' to 0)
> 2. CPU x writes to an I/O register on this I2C controller which generates
>    an IRQ (end of i2c_dw_xfer_init())
> 3. CPU y takes the IRQ
> 4. CPU y reads 'dev->msg_read_idx' and doesn't see the write from (1)
>
> (i2c folks: please chime in if I got this wrong)
>
> the issue being that the writes in (1) are not ordered before the I/O
> access in (2) if the relaxed accessor is used.

Ok, then removing relaxed is indeed the right thing to do. Because
yes, it's an actual ordering issue with the IO write, not some locking
issue.

Thanks for filling in the details, that patch looked iffy to me, but
it does sound like everything is good.

             Linus

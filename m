Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351427E8D18
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 23:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjKKWTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 17:19:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKKWTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 17:19:24 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB0E3253
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 14:19:19 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50949b7d7ffso4679175e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 14:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1699741158; x=1700345958; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B3Jt9is6S1LKbAxRYHakljguqJvQzE1dtY+7edLQpGI=;
        b=Dgu289nVhMo0sYVP4lOJIOUem51jxdanNRp1KVTCXuOqvfXCrw1vNREqOH9XT6Y0xo
         gLqXyElqSeGLB8bs0GWiVFGS9II40+p4KoPPlT2i6pPWz+J6fHnHnTVJ7cIS1+wD1+/J
         fTQ4jjfjh4b0CZHKedbSiXIpsAFNxfvf1vE1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699741158; x=1700345958;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B3Jt9is6S1LKbAxRYHakljguqJvQzE1dtY+7edLQpGI=;
        b=SD5YlaTKObmTwaN90dCwY8XQLjxg4Touxrs+iMPHuQmV7St12m22igxa4MlnqrTjWx
         6u6ZzzVlz3A+aFFPqnIeRj+pwqj+k6omnw7Xlpp17OHoVx62fQOhFxkoALeuVfs9WLH3
         cuT/JqdX3dnMEz9dyJ0Exy6O3B9U5feHCfuGoIk3Xak6jaSqCsYJkXy0l9j/RkLeqEU1
         Z4ueXUFA6Lno6fyoIVc41+STa30uRgQqnPZbQVVtzbim8wFQiS44kn79kbueT54qzut9
         VNsgerO9y03QZoIMYegkXptvHlP6szIbaB2l8vZ92+55FoUeon3laV7O9kbZMZm6m0bn
         0W4Q==
X-Gm-Message-State: AOJu0YyLCLlImn5mrwO0aaLeSOAALDIEaZRGshjqyryIdWw3fzhwmnxm
        Q914R2xIdfGaOPQQ77xU1TpeVvV6sRH3t3r0pBrGHw==
X-Google-Smtp-Source: AGHT+IFWgBM4YeHHOqe/G6caOMdUnNN+Rskqd02N3ADjDLtv1jo5qowbFogq9am4CehByE8mOEHwzA==
X-Received: by 2002:ac2:5294:0:b0:509:5d4b:44c4 with SMTP id q20-20020ac25294000000b005095d4b44c4mr1568657lfm.1.1699741157987;
        Sat, 11 Nov 2023 14:19:17 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id j15-20020ac2454f000000b004f755ceafbcsm395990lfm.217.2023.11.11.14.19.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Nov 2023 14:19:17 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-50949b7d7ffso4679158e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 14:19:17 -0800 (PST)
X-Received: by 2002:a05:6512:3f16:b0:503:1be5:24eb with SMTP id
 y22-20020a0565123f1600b005031be524ebmr2407702lfa.50.1699741156739; Sat, 11
 Nov 2023 14:19:16 -0800 (PST)
MIME-Version: 1.0
References: <20231103110600.GAZUTUGFjhoLm1KZzE@fat_crate.local>
In-Reply-To: <20231103110600.GAZUTUGFjhoLm1KZzE@fat_crate.local>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 11 Nov 2023 14:19:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg=+8rceshMkB4VnKxmRccVLtBLPBawnewZuuqyx5U=3A@mail.gmail.com>
Message-ID: <CAHk-=wg=+8rceshMkB4VnKxmRccVLtBLPBawnewZuuqyx5U=3A@mail.gmail.com>
Subject: Re: [GIT PULL] x86/microcode for 6.7
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Nov 2023 at 04:06, Borislav Petkov <bp@alien8.de> wrote:
>
> I believe this is the last tip branch from the lineup this merge window.
> It has a lot of nice things, it has been tested on everything we have
> access to so it should be good.

Well, I only now looked more closely at dmesg (because I was testing
an entirely unrelated patch of mine), and I see this:

    smpboot: x86: Booting SMP configuration:
    .... node  #0, CPUs:        #1  #2  #3  #4  #5
    microcode: CPU4: new patch_level=0x0830107a
      #6
    microcode: CPU5: new patch_level=0x0830107a
      #7
    microcode: CPU1: new patch_level=0x0830107a
    microcode: CPU2: new patch_level=0x0830107a
    microcode: CPU3: new patch_level=0x0830107a
    microcode: CPU6: new patch_level=0x0830107a
      #8
    ...
      #63
    microcode: CPU62: new patch_level=0x0830107a
    microcode: CPU63: new patch_level=0x0830107a
    smp: Brought up 1 node, 64 CPUs
    ...
    mip6: Mobile IPv6
    NET: Registered PF_PACKET protocol family
    microcode: microcode updated early to new patch_level=0x0830107a
    microcode: CPU0: patch_level=0x0830107a
    microcode: CPU1: patch_level=0x0830107a
    microcode: CPU2: patch_level=0x0830107a
    ..
    microcode: CPU62: patch_level=0x0830107a
    microcode: CPU63: patch_level=0x0830107a
    microcode: Microcode Update Driver: v2.2.

which is really quite ugly and entirely pointless.

I *really* don't want to be told 129 times that my microcode has been
updated to the same level.

And yes, it's "only" 129 times, because while there are two of those
microcode update lines:

    microcode: microcode updated early to new patch_level=0x0830107a
    microcode: Microcode Update Driver: v2.2.

CPU#0 is only mentioned once, while CPU's 1..63 all get two mentions
(once for the bringup, once fro the summary).

Can we please stop doing this insanity? It's not helpful.

                 Linus

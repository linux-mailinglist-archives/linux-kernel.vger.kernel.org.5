Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241A27C970C
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 00:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjJNWc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 18:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjJNWc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 18:32:27 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E73FD8
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 15:32:26 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-538e8eca9c1so5596364a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 15:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697322744; x=1697927544; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bzPVtpp7M3ci+vR78TNfIjhcYijJJkyyF1L4czkuxUI=;
        b=PyazHXDQNV6UU4bnf/wTA1Wq7AYMUptiZ1IWO/5EkYs8MJs5cAjiYoam1/Lz/gVuR3
         cco85hVnf9TZwV3nUAsk9kmUiUpAd/RPtm0WnkieErAay8jFFt7gJw9izRmFEQkfHKrC
         ZeguiLUOdSoXJQp5AHSKPRQ6UGxzJ7AfjuGGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697322744; x=1697927544;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bzPVtpp7M3ci+vR78TNfIjhcYijJJkyyF1L4czkuxUI=;
        b=TlS092z5SjXIcgzCygbXMduiza+9rauW/qgCfFPq2z8PS06K2wJsrd337p8QX8c6Gb
         2RsxJncFbN7ADNPVtOF6NwbWGLvIpop/wT+yiz1EJ5FB0I40mjt/0WO7cNLBrjhYwuzP
         MMyK2AUiyz2u0YTDr+KCQcDuu8q7Y+LSbLNszfB7haHFuqj79PvsKQCj+WCTY3MjZAvF
         l6lgpnPTcwxJxJ59mX5kq9S0vWDByLWoFHnlhNra0E8fc2Z0zAq6FyG7s9m4AuaZDOxY
         AdwmzGYx+tUnyAq9SwTGhwa1cg+5OWW6qbdR/AlnogRsZcV1c1PgpkLIwX1O+THZmsv1
         wneA==
X-Gm-Message-State: AOJu0Yz7scUSYfGWjdHeAdIU5ODqCCGkiXbLwFW8R2fVwsE/39f9f793
        sMvGPgpQZB/XNoNwpDJiU4MWmFf4nEZD4cp6MVev3w==
X-Google-Smtp-Source: AGHT+IE0Lr1LHFdaIX9NIFWaiz/Ex9K0OleZ9dzBaeHEf6ZMK5YhCLU2Wje1xG+V+tp5Bqd0lD63iw==
X-Received: by 2002:a17:906:af65:b0:9b2:9e44:222e with SMTP id os5-20020a170906af6500b009b29e44222emr31205477ejb.19.1697322744234;
        Sat, 14 Oct 2023 15:32:24 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id x16-20020a1709060a5000b0099b8234a9fesm1435893ejf.1.2023.10.14.15.32.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Oct 2023 15:32:23 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-9a6190af24aso536901166b.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 15:32:23 -0700 (PDT)
X-Received: by 2002:a17:907:3e0f:b0:9be:39a4:b440 with SMTP id
 hp15-20020a1709073e0f00b009be39a4b440mr4246165ejc.76.1697322743314; Sat, 14
 Oct 2023 15:32:23 -0700 (PDT)
MIME-Version: 1.0
References: <1d521170-85c9-41bb-ad79-5d2bf3aae7f2@gmx.com>
In-Reply-To: <1d521170-85c9-41bb-ad79-5d2bf3aae7f2@gmx.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 14 Oct 2023 15:32:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg8O_CxYv3grek90cENnzGff1GYL+GGkweVX2t0Lr3KJg@mail.gmail.com>
Message-ID: <CAHk-=wg8O_CxYv3grek90cENnzGff1GYL+GGkweVX2t0Lr3KJg@mail.gmail.com>
Subject: Re: Printing HW configuration on boot
To:     "Artem S. Tashkinov" <aros@gmx.com>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Oct 2023 at 12:57, Artem S. Tashkinov <aros@gmx.com> wrote:
>
> dmesg is an invaluable source of information about the system however
> oftentimes it's the only source of information and it gets really hard
> to extract information from it.

Honestly, I don't think this is "fixable". One issue is that different
people will want different "hardware info". Things like CPU model can
be interesting for some uses, but completely useless most of the time
for others. Same goes very much for GPU etc.

So then in other cases you want all of lspci etc, which is generally
too verbose for dmesg anyway (and even if it isn't, you again end up
with some people wanting not just vendor/model, but submodels and PCI
BAR information).

And if some problem happens during boot, you want the printouts to be
as immediate as possible, *not* some "summary once we've gathered
everything".

In other words: what you want for one bugreport is likely very
different what some other person wants for another unrelated issue,
both in content, verbosity, _and_ in timing.

For some issues, you'll want the dmidecode output, because motherboard
and BIOS versions matter. For other situations, none of it matters at
all, because saying "RPi 4 with 8MB" pretty much describes the
hardware. And other situations want a full acpidump.

You can always find *some* issue where exactly what you asked for is
relevant. But then 99% of the time it doesn't matter at all.

There simply isn't some kind of "one right output".

          Linus

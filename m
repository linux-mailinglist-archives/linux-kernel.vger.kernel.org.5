Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C24799A6D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 20:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239891AbjIIS2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 14:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbjIIS2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 14:28:39 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E6E9C
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 11:28:34 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2bb9a063f26so53333331fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Sep 2023 11:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1694284113; x=1694888913; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A7mn67C2j+jaydn9eWN22ApbUyX6ohndCDOZZ/kAhRI=;
        b=Gt0E8Xts0LtPyWWxBnW1OPJhnpubYfwSaEBbbfUYRbVH2V3TvA+5lqwWHU9YUlhL+o
         +NdrJLB9fUQWPI6UOtdTfVPgQJqNP5RXWsq7dv9aklOLdliShsXodN47rb1oG5H5dYQk
         JRm99BsqCX4MjW+sqWxG6nJoKv5C9H+5GtN7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694284113; x=1694888913;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A7mn67C2j+jaydn9eWN22ApbUyX6ohndCDOZZ/kAhRI=;
        b=SSND3+s2HwbDX/KRe/iWFgTWQv1JQ5BKUcJyClxakYoiTTiJFI8mo7mzt9cNJN8O4M
         +ojESRoKmvYeWqm4RIkLGdXN41XuXA/J79TXUedoNOriE/7OMhGt5fSam+F6VgM6WbzZ
         D2Kyv/i4wQUPY9Z3ZhbHx0Vc8fvE7TZfPBATYxCg3zW/dch3uSdWEcs7Ggc4FVIqgrbM
         xNq1SrXZnwu3OmDTx1xSHQsTtLSveK8N7PgQoIiVOFLb4s9vhp3Hsg9O8atGhY/LxVc+
         E0A/djv2MDqCv6+m54CTABms0D+VHtD8i6TS+2bdFSXZW0AS1UEsZkW7W5WQgxPbPE+Q
         FEQA==
X-Gm-Message-State: AOJu0Yy5gBQfz7eQiAJZunrsP53OOlhgw+Cs/P9luxx5XH1dH2QISWeh
        C1Ghjk3jIHwUHacFuDzLfMeITRn8dfWv83iWIDoBNZXO
X-Google-Smtp-Source: AGHT+IFrXK7TYE0UwaCKL0TMv1/t12Q7lv7V7/A3ro+0Tg3T+m3/ZWmQsiMCkJZ7RTVGNWcWnPecuQ==
X-Received: by 2002:a2e:8784:0:b0:2bd:1cd0:6041 with SMTP id n4-20020a2e8784000000b002bd1cd06041mr4196662lji.0.1694284112774;
        Sat, 09 Sep 2023 11:28:32 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id s5-20020a2e9c05000000b002b9ebbe09d5sm750627lji.33.2023.09.09.11.28.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Sep 2023 11:28:32 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2bb9a063f26so53333121fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Sep 2023 11:28:31 -0700 (PDT)
X-Received: by 2002:a2e:9bd4:0:b0:2b6:eefc:3e4f with SMTP id
 w20-20020a2e9bd4000000b002b6eefc3e4fmr4231263ljj.21.1694284111613; Sat, 09
 Sep 2023 11:28:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230909033457.GA59845@workstation.local>
In-Reply-To: <20230909033457.GA59845@workstation.local>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 9 Sep 2023 11:28:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjHYum5R1hbVFxqEYDt6baZGh7zzKNpv_R3sGbtN0=-dQ@mail.gmail.com>
Message-ID: <CAHk-=wjHYum5R1hbVFxqEYDt6baZGh7zzKNpv_R3sGbtN0=-dQ@mail.gmail.com>
Subject: Re: [GIT PULL] firewire updates for 6.6
To:     Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Jan Engelhardt <jengelh@inai.de>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Sept 2023 at 20:35, Takashi Sakamoto <o-takashi@sakamocchi.jp> wrote:
>
> In the second half of 6.6 merge window, Jan Engelhardt sent the change. It
> allows any front ends of Kconfig to deactivate FireWire subsystem at a
> clip.

I pulled this, but after looking at it, I unpulled it again.

We *already* had this. Saying 'N' to the existing FIREWIRE option
would disable all of the firewire stack, since the rest then just has

        depends on FIREWIRE

on it.

The only exception is the firewire sniffing side (FIREWIRE_NOSY),
which technically doesn't need the firewire stack to exist or to work.

The other thing this adds is a

        depends on PCI || COMPILE_TEST

for the firewire subsystem, which makes sense since the controllers
all depend on PCI even if the code itself doesn't care (thus the
COMPILE_TEST) part.

Anyway, both of those changes are fine by me - but adding a new config
option, and bothering users that want firewire support with TWO
questions about "do you want firewire" is just annoying and frankly
just stupid.

I have said this five hundred times before, but I guess I'll say it
five hundred times again (the Proclaimers even wrote a song about it):
we don't make the config options worse, and we don't ask people stupid
things.

So no.

The actual core limitations I'd be ok with: just add that

        depends on PCI || COMPILE_TEST

to the *existing* FIREWIRE config, and add a

        depends on FIREWIRE

to FIREWIRE_NOSY for all I care. That potentiall y*removes* annoying
questions, not adds them.

And if people want to change the existing menu to a menuconfig
(*keeping* the existing FIREWIRE config option, not adding a new one),
that's fine too.

But this "let's add yet another mindless option to ask users" is _not_
acceptable.

              Linus

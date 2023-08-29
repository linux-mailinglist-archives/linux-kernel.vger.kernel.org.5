Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C554478BC6B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 03:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234092AbjH2Bo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 21:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234980AbjH2Bo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 21:44:29 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B2D18F
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 18:44:22 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b9f0b7af65so56944691fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 18:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693273460; x=1693878260;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7sxVQqPlEP7CEpzy34UVB0Q/8ZNq3LKDzda1K8wnw4M=;
        b=YeOdq+7Wwq7SGHwcQrHmc5YB++l6qPl+dSQF/pM/YrjlBryLmXVM+jPDI/XpNaVDgt
         MPRndjAkW3M4cjsClvLu1lPB76T4iebd9wwM/ZyyLBhiFtVZHdljiWdd1hy7znzYervR
         vKGTKhmzkldo3EqPjVy4EXYC0RmwhzwHW2bAs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693273460; x=1693878260;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7sxVQqPlEP7CEpzy34UVB0Q/8ZNq3LKDzda1K8wnw4M=;
        b=iI/cXM9JvMYgCFJlyCPosX3zHDpzcddu1yJ6FyG1C11cZYhqqO7aEeAh5ZD3NaB1uK
         Phe0pcYRoE1OPAFEID6Aj/wvd9Wsi17L2D0FUrP0dq36U1SlM9hDHtQXnA8n/4XPX7Ok
         qMw7YbofgBJJ1nmrYexvaSyQZEUJEQdWL1Nfi/GgAgCNvT7YnV9Alzejcdjv3/AXPNqV
         9s+dMsdrkpyd9oK07ApK/XqAXrStJNhy27HdwMT3N6mUCY38bqbg+DOzW5t/cuOQvmSG
         12wvr5vEYqJnrWftfYpOIphMU9V2hcIjNBRz0EHS74nkjVc/iYhuKBDMLsikCvcPqoSK
         796A==
X-Gm-Message-State: AOJu0YzDy5jtbU6fd43S8T2+n1n8H9/ESQtJuZbwK8izHpbvZhhL1UwJ
        s83wkhGm7Hi80cuyX2O+P7K4xyFisWnMGpSBSNs6RQ==
X-Google-Smtp-Source: AGHT+IH3UliYydq7qcZRh0WTuFa5lpRkbTVyMRQlxYvnBRDDBqN0uOOUKsbFd9p/QV5cmiKMP58YMg==
X-Received: by 2002:a2e:87d5:0:b0:2bc:ed75:1ba with SMTP id v21-20020a2e87d5000000b002bced7501bamr9551406ljj.16.1693273460148;
        Mon, 28 Aug 2023 18:44:20 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id z28-20020a05651c023c00b002b9ea00a7bbsm1888491ljn.60.2023.08.28.18.44.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 18:44:19 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-500913779f5so6085125e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 18:44:19 -0700 (PDT)
X-Received: by 2002:a05:6512:2392:b0:500:be57:ce4c with SMTP id
 c18-20020a056512239200b00500be57ce4cmr1889189lfv.64.1693273459201; Mon, 28
 Aug 2023 18:44:19 -0700 (PDT)
MIME-Version: 1.0
References: <202308281119.10472FC7@keescook> <CAHk-=wi_WxZ2dEsQR0-wDtYAh4sxVEQkU7HK5JSboVv7v7NwcQ@mail.gmail.com>
 <B085ADB4-4B8C-4998-BB33-DA67C45483E9@kernel.org>
In-Reply-To: <B085ADB4-4B8C-4998-BB33-DA67C45483E9@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 28 Aug 2023 18:44:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjRD_LnCbwSRM20Fg54xhrFBLwgO=X23bdconx3wKokxg@mail.gmail.com>
Message-ID: <CAHk-=wjRD_LnCbwSRM20Fg54xhrFBLwgO=X23bdconx3wKokxg@mail.gmail.com>
Subject: Re: [GIT PULL] pstore updates for v6.6-rc1
To:     Kees Cook <kees@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Enlin Mu <enlin.mu@unisoc.com>,
        Eric Biggers <ebiggers@google.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yunlong Xing <yunlong.xing@unisoc.com>,
        Yuxiao Zhang <yuxiaozhang@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Aug 2023 at 18:28, Kees Cook <kees@kernel.org> wrote:
>
> - does this happen at every boot? (I assume yes.)

Yes so far. I don't boot between every pull, so I think I've only had
two boots since the pstore pull, but both of them have this.

I also see it on my laptop, so it's not hw-specific.

> - what CONFIG are you built with?

I'll send my config separately in private, I don't think we want to
have that kind of noisy thing on the list. But it's basically a
standard Fedora config, cut down with "make localmodconfig" and with
some of the more annoying options disabled.

> - what was the prior CONFIG?

No changes, apart from "make oldconfig".

> - what backend is in use? (Or better yet, what does "dmesg | grep pstore" report?)

  [torvalds@ryzen linux]$ dmesg -t | grep pstore
  pstore: Using crash dump compression: deflate
  pstore: Registered efi_pstore as persistent store backend
  pstore: zlib_inflate() failed, ret = -5!
  pstore: zlib_inflate() failed, ret = -5!
  .. repeats a lot ..

> - are you using systemd?

Yup. Standard F37 install - except for the kernel, of course.

It does happen right after

  Write protecting the kernel read-only data: 22528k
  Freeing unused kernel image (rodata/data gap) memory: 224K
  Run /init as init process
    with arguments:
      /init
      rhgb
    with environment:
      HOME=/
      TERM=linux
      BOOT_IMAGE=(hd0,gpt2)/vmlinuz-6.5.0-00771-g5af3e822077e
      resume=/dev/mapper/fedora_localhost--live-swap
  [ lots of "pstore: zlib_inflate() failed, ret = -5!" ]

and just before systemd adds

  systemd[1]: systemd 251.14-2.fc37 running in system mode (+PAM
+AUDIT +SELINUX -APPARMOR +IMA +SMAC>
  systemd[1]: Detected architecture x86-64.

to the logs.

Which could easily mean that it's triggered by something systemd does
very early.

But none of those other messages are new, and that systemd version
that it reports is the same it has reported before (without any storm
of zlib_inflate() error messages).

> Let me think about the best way to deal with this. I expect I'll have pstore wipe the failed records as it is expressly not expected to work across differing configs/kernel versions. And permanently spewing errors is not ok.

So none of that sounds new.

The only thing that is new is the kernel pstore implementation. Why
was this not a problem before? The warning existed back then too, but
I never actually got it.

I get the feeling that you are overlooking that basic fact.

                 Linus

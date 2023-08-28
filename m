Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABEF78BBC7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 01:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234487AbjH1X45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 19:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233755AbjH1X4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 19:56:23 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FCC013D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 16:56:21 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-500aed06ffcso4348975e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 16:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693266979; x=1693871779;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ca0K8QaLPVDB48KBeeAn11eON3QiDcCcdOpq7HRvOHM=;
        b=UDYUbWdCwiBTSf9jsIgIz43zZ3g1hPOjRZ90DxCf5DFx/16wwqhvFdvcyjEo7migZT
         kk92ZnOA11T/khIY+0tG+EAvDX7Hrp1mGXM20t/cQzQYiHhLUFSK7BQcb+A1qdxPOxcm
         bHgnioElnadkZRI5F4XskL9jrMJorTN7TMRlU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693266979; x=1693871779;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ca0K8QaLPVDB48KBeeAn11eON3QiDcCcdOpq7HRvOHM=;
        b=PDTP5MdSBib8Os/fLi/Tt8y4HwY6eJd0XRJOdSs0OcYdbrke2YZgcJesp4tq5x+rHp
         AxLMGyX6oCudxeGpN0pBpdRKef5QP9X1sjDJCHbEuJ0aEgbsmjXJo3I8ZjJuFSVGxTpN
         pfje0sz4Mv4FdOdGH5le+J3nymie0peinivUU4jjOtZcNQHDauT8PIFrEmBOW/emLn2N
         jMIzR4/sHdE8+tWuaVortUayNmOBQ6Y/WvNpuUKMV4fLRHuHTbWXEVxey3uWwp4gbmj8
         /De3//A1BaRyNy2qZAk0nmo3JFAvGZ4uHAduvvZk+0L6loDwfMD8AeGqyYuTrw9BZfCl
         Xdpw==
X-Gm-Message-State: AOJu0Yz/JEZEltYZpfUvvJ42GHRIJUy/K0LKO37cJfXfoxD9AU0W6wf1
        ABiKpIisIJNBzOTaTv6w29jr0bUImhi5S8kN2tEdaw==
X-Google-Smtp-Source: AGHT+IHOSDbRWNYiwE71728OWhwLV4db76Z9yJOLSKhcNFrDWfdDrZ76OLt30T2p9u4RH0p1A3oVew==
X-Received: by 2002:ac2:4da8:0:b0:500:9031:bb1b with SMTP id h8-20020ac24da8000000b005009031bb1bmr11431244lfe.41.1693266979278;
        Mon, 28 Aug 2023 16:56:19 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id m17-20020ac24ad1000000b004ff725d1a27sm1724571lfp.234.2023.08.28.16.56.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 16:56:18 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2b974031aeaso57912231fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 16:56:17 -0700 (PDT)
X-Received: by 2002:a2e:8717:0:b0:2bc:c11c:4471 with SMTP id
 m23-20020a2e8717000000b002bcc11c4471mr18323041lji.21.1693266977434; Mon, 28
 Aug 2023 16:56:17 -0700 (PDT)
MIME-Version: 1.0
References: <202308281119.10472FC7@keescook>
In-Reply-To: <202308281119.10472FC7@keescook>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 28 Aug 2023 16:56:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi_WxZ2dEsQR0-wDtYAh4sxVEQkU7HK5JSboVv7v7NwcQ@mail.gmail.com>
Message-ID: <CAHk-=wi_WxZ2dEsQR0-wDtYAh4sxVEQkU7HK5JSboVv7v7NwcQ@mail.gmail.com>
Subject: Re: [GIT PULL] pstore updates for v6.6-rc1
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
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

On Mon, 28 Aug 2023 at 11:21, Kees Cook <keescook@chromium.org> wrote:
>
> Please pull these pstore updates for v6.6-rc1. This contains a fair bit
> of code _removal_ which is always nice.

Hmm. The diffstat certainly looks good, but the end result isn't great..

I now get 124 lines of

   pstore: zlib_inflate() failed, ret = -5!

in my bootup dmesg.

Considering that there's no reason for pstore to even be active on
this machine, I think it's because pstore now goes and tries to
uncompress something entirely invalid.

The message itself does not seem to be new, but with the switch from
the crypto code, it apparently used to be

    crypto_comp_decompress failed, ret = %d!

but the key word here is *apparently*. I never got that message
before. So something else has changed, and I'm thinking that the old
code probably didn't even try to decompress the bogus data it found?

I dunno. But 124 lines of insane garbage in the kernel messages is not
a good thing.

                  Linus

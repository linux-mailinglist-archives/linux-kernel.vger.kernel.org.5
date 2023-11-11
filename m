Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6F17E8CF8
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 23:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjKKWFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 17:05:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKKWFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 17:05:36 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B747E3253
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 14:05:32 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-507a0907896so4305272e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 14:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1699740331; x=1700345131; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=liBhiUPvtybBWQPiBr5O6IhXB1tudfuPt//EzYM9ydg=;
        b=DPIbqWKaxE2d40e8GCD1n2LfCcLKaLfThbbY6yLbDH37IrLqBp1vIFjAj3dZFS5cX9
         n6ocUTZMscljVTZqrQR0LQV0IDNQbfgu+zJ1MlOd+2Sw+sNkaKGJGW5l+F/xv3QSem2C
         EdOqNlbzevayZV4mDFqHBr8c4o97MehvOl3+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699740331; x=1700345131;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=liBhiUPvtybBWQPiBr5O6IhXB1tudfuPt//EzYM9ydg=;
        b=OXCEfuaEuPFgco5T8D2ETmPdC82qa5pxPEqudZ92N4rgZT3v3vWclKcPeKl7QSw/uJ
         kR8OvZU4U45L3WSrJ1EXWsmAhsjAwDNaw8Dxe1xWMgC8/VAg5Ts7a2zevaubgP8GoqC0
         j85p+G9SWy7Bp9ZRWbZfqmpl21ogqWs285dqiHtYPN3xf3KTV33QEEZPuaCrHdp+qUWk
         IuO2RWPfa9UG90psYfDnqsXmkztofsRYdlT+bjz+8Wm4Muwg9dhWHld73WtnYLUBwjA5
         4QlhgsIWS/ph8t0UGv4Gy/879QrSfOsyA7HzozFWwfYdfMKtRuOjQBv+yUXR7ingwY0V
         O4Ag==
X-Gm-Message-State: AOJu0Yw5c36+w5VALjwhRBZNonWZ+Dhxha9EZYCGH3Q9WCcIHrapuAiT
        yq1z7B9ZhbpQVobIJd7IvGt/+KJ0oRjTqcyY++vjTQ==
X-Google-Smtp-Source: AGHT+IFRrwCUE0gOq41Bc8+ORCQo2fUJFCc0/larKZNvyyxCj/J33ikPsng7AYO7zEOILiq7wGvPnQ==
X-Received: by 2002:a19:f807:0:b0:509:43ec:dd4c with SMTP id a7-20020a19f807000000b0050943ecdd4cmr1770465lff.3.1699740330661;
        Sat, 11 Nov 2023 14:05:30 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id i27-20020a196d1b000000b004fe3bd81278sm395761lfc.70.2023.11.11.14.05.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Nov 2023 14:05:30 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-507a29c7eefso4317816e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 14:05:29 -0800 (PST)
X-Received: by 2002:ac2:5185:0:b0:509:ffe4:e3d2 with SMTP id
 u5-20020ac25185000000b00509ffe4e3d2mr1696442lfi.6.1699740329607; Sat, 11 Nov
 2023 14:05:29 -0800 (PST)
MIME-Version: 1.0
References: <CAJvTdKn-xtmin9OjnzHg8wy4PM8Lc3Per=3y3UWORhjdroYP3w@mail.gmail.com>
 <CAHk-=wjvJ44a9Z=tkR2o-heQ4XLp0sgynDOhe6JH2fgg=MMMXA@mail.gmail.com> <CAJvTdK=OSTgYkut=-r95nAYOvVfUt3Cah92qudifeQW4ZJHT7Q@mail.gmail.com>
In-Reply-To: <CAJvTdK=OSTgYkut=-r95nAYOvVfUt3Cah92qudifeQW4ZJHT7Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 11 Nov 2023 14:05:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi9OoiKaH11uKD6s6f+jYAoUnXhAqv5Kq8iZWfaZ2Jnow@mail.gmail.com>
Message-ID: <CAHk-=wi9OoiKaH11uKD6s6f+jYAoUnXhAqv5Kq8iZWfaZ2Jnow@mail.gmail.com>
Subject: Re: [GIT PULL] turbostat for Linux-6.7 (with signed tag)
To:     Len Brown <lenb@kernel.org>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Fri, 10 Nov 2023 at 19:39, Len Brown <lenb@kernel.org> wrote:
>
> (Same code as previous pull request, with addition of a signed tag.
>  Hopefully it verifies okay at your end.)

There's no actual signed tag there...

You're still pointing at the same head:

>   git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git turbostat

and when I then did a "git ls-remote" to see if there's a tag that you
just didn't point at, I get nothing.

Forgot to push out?

I really would like to see signed tags only, because since v6.3, all
my pulls have been signed tags.

(Ok, I do have three merges that aren't signed, but they are my own
local branches that I merged. I feel like I don't need to verify my
own signature - I sign the resulting releases, and people can verify
that it's me that way in the end instead).

              Linus

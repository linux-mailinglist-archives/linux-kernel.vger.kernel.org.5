Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBE97E9222
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 19:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbjKLSuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 13:50:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbjKLSud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 13:50:33 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98CD21718
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 10:50:30 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2c5087d19a6so45610491fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 10:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1699815028; x=1700419828; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=toLQxGAKGjPQ+cmef0067ZoK5B9j5w9kF9znNCM+IOg=;
        b=EP6hiRyTauU6wmoXJZSX/w2H+tKn01xMgJIE0/7y2TSC8WpY+KzLvrbdUtD+BCCoeP
         GFoDXR/ObTP8Szni04Y8dYNZ1GoqxXf1zyABzH9dgrzVHmVq4ey2HKlaDphURAVZ5rjC
         cevKlR93kPgv50Krmwyvdw8ZOSi8NSFBJWHwo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699815028; x=1700419828;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=toLQxGAKGjPQ+cmef0067ZoK5B9j5w9kF9znNCM+IOg=;
        b=GNw8Hx4RJ2cpU9etWUAGGfHwW9XzXIyvUeQ+oPz/5R5NWTdODtpbEUI6Gbf+KHA0xR
         JVXYEpX+Yc8K+lXWdKB7bZpuVXtvc4hhmHf5znvRpiBRdi8o6/tHZNxgtUUrOAE3jrVB
         cSmjxow8A4ILjT8/vzDGOowfT2Jk5ZDIJ9hh4dEMR0gbxSBZAPCAlatID8h/CUhPIjkh
         meNqwn5gZlE4Cmf19MuIhePmHzPk9MVD782/4w093ILG4TpuHRgEy2vQouDCWYat7G+R
         jmXOuaw4hNgqNwvJu2oFtCYbymlo/I1ep+d9GbC+tmEldSekR4jQMw82Xb1anS46gCzM
         Tv4w==
X-Gm-Message-State: AOJu0Yyp4YRqzSt80JsmTVWeBSeTIkF9HCrpYllkkoqKr6xXunifxmp/
        C4CF9DGhjfPzuRvxqwrB+ynEnR79cYN2XPIi8TSVuz7e
X-Google-Smtp-Source: AGHT+IHhn+sgWddDJD77i/O33trHxMT0yRjWTopPKX4wGsOPL1ApFSm4WF8lxhoqRilyQzmeP8h4aQ==
X-Received: by 2002:a2e:701a:0:b0:2c5:1fae:e61f with SMTP id l26-20020a2e701a000000b002c51faee61fmr3374310ljc.6.1699815028617;
        Sun, 12 Nov 2023 10:50:28 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id u16-20020a2eb810000000b002b6d68b520esm682202ljo.65.2023.11.12.10.50.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Nov 2023 10:50:27 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-507c5249d55so5702246e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 10:50:27 -0800 (PST)
X-Received: by 2002:a05:6512:3051:b0:4ff:a8c6:d1aa with SMTP id
 b17-20020a056512305100b004ffa8c6d1aamr4427793lfb.48.1699815027222; Sun, 12
 Nov 2023 10:50:27 -0800 (PST)
MIME-Version: 1.0
References: <20231111125126.11665-1-yjnworkstation@gmail.com>
 <20231111132431.GA3717@1wt.eu> <CAHk-=whTZDjeH2FJqBozjAF44sh4XVNQrt2xdQn_Ujt=Be6=dw@mail.gmail.com>
 <CAMjCObv9Z+Ood9QFA_jSQ2roSEE6C_ip=KeyoChmtyi97UoU7g@mail.gmail.com> <20231112154424.GE35991@mit.edu>
In-Reply-To: <20231112154424.GE35991@mit.edu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 12 Nov 2023 10:50:10 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj1qDhzGRYnfHb-jYHiT_3x+PuA8Zk9FosCzm5OL6e=GQ@mail.gmail.com>
Message-ID: <CAHk-=wj1qDhzGRYnfHb-jYHiT_3x+PuA8Zk9FosCzm5OL6e=GQ@mail.gmail.com>
Subject: Re: [PATCH] exitz syscall
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Jasper Niebuhr <yjnworkstation@gmail.com>,
        Willy Tarreau <w@1wt.eu>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Nov 2023 at 07:44, Theodore Ts'o <tytso@mit.edu> wrote:
>
> How about adding a flag MLOCK_ZERO_ON_FREE used by the mlock2() system
> call?  The number of pages which an unprivileged process can lock is
> already capped via RLIMIT_MEMLOCK (or else mlock would be it own
> denial of service attack).  That way if process dies from crash, the
> keys would be zero'ed.

Yes, that is a lot better as an interface.

However, it still needs to also make sure that the memory in question
is not file-backed etc. Which the patch I saw didn't seem to do
either.

End result: as it was, that exitz patch was not helping security. It
was anything but.

              Linus

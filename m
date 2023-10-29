Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0778D7DAD7D
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 18:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjJ2RT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 13:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjJ2RTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 13:19:25 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE86BF
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 10:19:23 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9d242846194so123327866b.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 10:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1698599961; x=1699204761; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/CPMtoFSixsFd7J/sBpL5LC1nviwgRkdiMzTnhelk2A=;
        b=R1f/Gw/RU+0ZdFldDAcmHDw5/e2WkmMoNsyCjB6trAma2YJDTZq32/mGruEN4uwfTU
         JEqbjQUkJVx2n2zMwIcBZ8TMCvLOxDV+OrtnIzABPT3AVMSFlcBTZubElyJaAptdERKK
         oIBeHcxJithmFtRqvViiKZBOByaZVcaEG2jh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698599961; x=1699204761;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/CPMtoFSixsFd7J/sBpL5LC1nviwgRkdiMzTnhelk2A=;
        b=Cj3SMaXXY1tP7AbJLomc+G+AyxiTPGCOKdhNpWGotdD6pQRwdQmQPtHYzOCj1YVfP4
         q9TVw9kwYBLzV7Fcuog/fTfXtmAvvIT+i6s74FgsB7qC1B5BBBIKq/mEyZnNgtwH6vSS
         s+p/4LVEdp/bopzgwaf7+Zs5bsXua3s+IZEm0dReobfWj9IG4wj9+ax9VMlcAxotXdB2
         yy0Vj9LPoRwx9BhprpVhdvZZtCUsg0gGbi3nxJTP9LyWTmzaWm+Qgyp7GlRfhE3wTXOH
         gnXiyd32JIZRdcyMFEoNU6pYoR2Br6KcCmg0lQ9YNkCvcDI+KGKxIhqzTiTTT926C+XH
         rpgg==
X-Gm-Message-State: AOJu0Yy0BaOBeewZoeJY+BRGb6WBUx2tfH8scRgDY9++9vP4Aa9oHVmx
        a7WW5ExK7jfnL4bcHSPv4xeGnG2/lplZnmzxIz1Qkw==
X-Google-Smtp-Source: AGHT+IG3GyT9vpCmpli9gutqaeMi8Q162yPzJ9ep+nQFdSCgh2U0RzUUXehh5tU/l0a34DSWRRDcpw==
X-Received: by 2002:a17:907:e88:b0:9c5:64f2:eaba with SMTP id ho8-20020a1709070e8800b009c564f2eabamr7614521ejc.53.1698599961125;
        Sun, 29 Oct 2023 10:19:21 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id z12-20020a17090655cc00b0099bc2d1429csm4621762ejp.72.2023.10.29.10.19.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Oct 2023 10:19:20 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-9c41e95efcbso517528266b.3
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 10:19:20 -0700 (PDT)
X-Received: by 2002:a17:907:3dac:b0:9ad:eb9c:dd00 with SMTP id
 he44-20020a1709073dac00b009adeb9cdd00mr6680680ejc.12.1698599960057; Sun, 29
 Oct 2023 10:19:20 -0700 (PDT)
MIME-Version: 1.0
References: <169858752781.1095326.10615907253726224231@leemhuis.info>
In-Reply-To: <169858752781.1095326.10615907253726224231@leemhuis.info>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 29 Oct 2023 07:19:03 -1000
X-Gmail-Original-Message-ID: <CAHk-=wgEHNFHpcvnp2X6-fjBngrhPYO=oHAR905Q_qk-njV31A@mail.gmail.com>
Message-ID: <CAHk-=wgEHNFHpcvnp2X6-fjBngrhPYO=oHAR905Q_qk-njV31A@mail.gmail.com>
Subject: Re: Linux regressions report for mainline [2023-10-29]
To:     "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>, Huacai Chen <chenhuacai@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
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

On Sun, 29 Oct 2023 at 03:52, Regzbot (on behalf of Thorsten Leemhuis)
<regressions@leemhuis.info> wrote:
>
>                          One of the remaining ones is new:
> module loading trouble on some laptops. Not nice, but likely nothing
> many users will encounter. The quota compilation oddity problem from
> Andy is also still around (unless it was fixed without me noticing); and
> a memleak, too.

The quota thing remains unexplained, and honestly seems like a timing
issue that just happens to hit Andy. Very strange, but I suspect that
without more reports (that may or may not ever happen), we're stuck.

> * There was another report about a blank screen during boot on a Lenovo
> laptop because simpledrm (that users apparently had enabled without
> problems beforehand) started to support those machines due to
> 60aebc9559492c ("drivers/firmware: Move sysfb_init() from
> device_initcall to subsys_initcall_sync"). I suggested a revert, but the
> developers disagree (to quote: "From my point of view, this is not a
> regression, 60aebc9559492c doesn't cause a problem, but exposes a
> problem.")

Honestly, "exposes a problem" is pretty much the *definition* of a
regression. So that excuse is particularly bad.

The whole point of "regression" is "things that used to work no longer work".

And no, "there's another bug that needs to be fixed" is _not_ the
answer - not unless you have that fix in hand.

That said, this already went into 6.5, so I'm not going to revert it
now just before the 6.6 release. That would be more dangerous than
just letting things be. But yes, a revert is likely the right thing to
do, unless people have figured out what is wrong with simplefb.

                 Linus

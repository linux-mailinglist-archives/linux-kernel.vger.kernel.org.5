Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74CE77BDA8F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 14:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346441AbjJIMBL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 9 Oct 2023 08:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346416AbjJIMBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 08:01:06 -0400
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74F6AC
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 05:01:01 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-d862533ea85so5215140276.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 05:01:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696852860; x=1697457660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7gtciP7pJ5ePDuZs6hrkiwcAh6cWpIDvabFqt+RxIBw=;
        b=Ilc7bQve4gcQTcCuKJfHauDTL7it05NY838G1m57XRLYpT34LgRXREBgDR5dm7UmKw
         jQjQtsk/4S9Cz/7XMAOL0w/3yaONHkWtT/k/rhOdj7Pax6JsxOmEcbmg4iob0BTlfPZf
         1facfAzVeZAc/jEa/COrX7xj4iWlBTeNk8wKh6RufT66D3N0f3+4PIZ1YHnoCBdnPs6Q
         k8Kyp67VUWF7UrfCy95jzsy6arvbMdRxruB32aQDcPbtI0Q6z/hCfH6rF0I8Nm9CF1u5
         SZJ3wMxa5XPSIqikmVERSq4I/GPlUgYB6EtWbtgMV9djMjfEydRlWvGzmBmFbWbm1bYh
         ZwIQ==
X-Gm-Message-State: AOJu0YwS36SBhR8vvSN+6Qz8OUQb81Q3OpevZnC4DCtwDVRJ90s0OfkT
        IuQqkApEPYYcsER6RPrOKqw/3Hc8aWxSCw==
X-Google-Smtp-Source: AGHT+IE8Oyfk8Pe4vCi607/weCGyUuFucUPiCpA0RdrmRHr1E+aK2VTDfclSb7gM57S94D4DICqaMA==
X-Received: by 2002:a25:e70e:0:b0:d81:af6b:cde with SMTP id e14-20020a25e70e000000b00d81af6b0cdemr12217284ybh.62.1696852860519;
        Mon, 09 Oct 2023 05:01:00 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id o135-20020a25418d000000b00d9a3fe483cfsm21179yba.23.2023.10.09.05.01.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 05:01:00 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-59f6e6b7600so52590507b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 05:01:00 -0700 (PDT)
X-Received: by 2002:a81:7309:0:b0:59b:fcca:afc6 with SMTP id
 o9-20020a817309000000b0059bfccaafc6mr14770713ywc.50.1696852859893; Mon, 09
 Oct 2023 05:00:59 -0700 (PDT)
MIME-Version: 1.0
References: <7858a184cda66e0991fd295c711dfed7e4d1248c.1696603287.git.geert@linux-m68k.org>
 <CAMuHMdVT7QEfagWcLx9z7YGtFiKRW5-J3F6gyxKYEzFBb=2_Gg@mail.gmail.com> <61d3b62380fb78b87003a09cc08827fb28de7942.camel@physik.fu-berlin.de>
In-Reply-To: <61d3b62380fb78b87003a09cc08827fb28de7942.camel@physik.fu-berlin.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 9 Oct 2023 14:00:48 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUbHS3tvLF3_JaG=0Hoxcwf71HGbSX+mo2WXQruWSL=nQ@mail.gmail.com>
Message-ID: <CAMuHMdUbHS3tvLF3_JaG=0Hoxcwf71HGbSX+mo2WXQruWSL=nQ@mail.gmail.com>
Subject: Re: [PATCH/RFC] m68k: Add full preempt support
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Greg Ungerer <gerg@linux-m68k.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matthew Wilcox <willy@infradead.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Mon, Oct 9, 2023 at 1:45 PM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On Mon, 2023-10-09 at 13:29 +0200, Geert Uytterhoeven wrote:
> > On Fri, Oct 6, 2023 at 4:49 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > Currently, a Preemptible Kernel is only supported on the Coldfire CPU
> > > family.  Extend preempt support to the full Classic M68K CPU family
> > > (68020+ with MMU, and 68000-derivatives without MMU).
> > >
> > > Make sure preemption is disabled in loops involving cache and TLB
> > > flushing.
> > >
> > > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > > ---
> > > Tested on ARAnyM, using none/voluntary/full preemption.
> >
> > bloat-o-meter summaries for atari_defconfig:
> >
> > PREEMPT_NONE -> PREEMPT_VOLUNTARY:
> >
> >     add/remove: 0/0 grow/shrink: 238/30 up/down: 2804/-748 (2056)
> >     Total: Before=4478149, After=4480205, chg +0.05%
> >
> > PREEMPT_VOLUNTARY -> PREEMPT:
> >
> >     add/remove: 735/277 grow/shrink: 3050/347 up/down: 244359/-11440 (232919)
> >     Total: Before=4480205, After=4713124, chg +5.20%
> >
> > Ouch.
>
> What exactly does the change document? More scheduling events?

No, kernel image size.  Hence enabling full preemption increases kernel
size by ca. 229 KiB (which is more or less the equivalent size increase of
upgrading the kernel by 10 releases).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

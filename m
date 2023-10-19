Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D497CF023
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 08:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbjJSGh3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 19 Oct 2023 02:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbjJSGh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 02:37:27 -0400
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516CB10F;
        Wed, 18 Oct 2023 23:37:25 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5a7be88e9ccso95905327b3.2;
        Wed, 18 Oct 2023 23:37:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697697444; x=1698302244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vXEjMPe8j5c6Nski5KvbyugP8GZIC2bmURRJNkH6ZbQ=;
        b=R69j6BP1J+jlozEAgOxDCD51nFcrXilKH9YHrnkNjK3423AInUTjseWAEqqjR3QxrF
         dK6yP2l3t6cdeOpMzPhPiNwKKBjJbL+LbjgEMmn2aFw/oWdx/FWKy0w6JUlIptsxMD/G
         hrlt1dDpqCMfS0ZHTH750WoP3sAyd2Um6xpZrExoZ0+LLskmP9luIDGdUBLFW/rZl/7o
         /xSKEt6jSmFJD23+IE1t3Fwjm8MTJ5ApW9QFE1GaiqDIkDXbFrKnbvBE4C+kdcqi2bws
         D7GehuYoyn6xWbO6oar0KNq21zoia7QQATdSGiGm+9cvvnQaXbVWWN5sFScX5TJUzIP5
         3LSQ==
X-Gm-Message-State: AOJu0YxWhsn/H2bf9U1n2PcbVPfy2Ai78heATZLCEkmuX5ak3W7M8bMC
        /KRtG1iBjqNKkcE/HjeTwmdIhhjUYTZ8rw==
X-Google-Smtp-Source: AGHT+IF/g5GfYLtIN675wkYCF6vrLJ901oUmB47g1+mlz9FaDPSpmSoFzH5KQytVJu9ERDPXogjVCg==
X-Received: by 2002:a0d:cbd3:0:b0:5a7:b53f:c304 with SMTP id n202-20020a0dcbd3000000b005a7b53fc304mr1696131ywd.37.1697697444045;
        Wed, 18 Oct 2023 23:37:24 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id d19-20020a0ddb13000000b005a7db2a0dddsm2199717ywe.3.2023.10.18.23.37.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 23:37:23 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5a87ac9d245so51099407b3.3;
        Wed, 18 Oct 2023 23:37:23 -0700 (PDT)
X-Received: by 2002:a05:690c:97:b0:577:3d46:f90e with SMTP id
 be23-20020a05690c009700b005773d46f90emr1622261ywb.32.1697697443165; Wed, 18
 Oct 2023 23:37:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230818194136.4084400-1-evan@rivosinc.com> <20230818194136.4084400-2-evan@rivosinc.com>
 <CAMuHMdVtXGjP8VFMiv-7OMFz1XvfU1cz=Fw4jL3fcp4wO1etzQ@mail.gmail.com>
 <CALs-Hsvu7BsK8P0+xeuLmKEqg-q=kQANbf8FkiPGPhwhnSXpmA@mail.gmail.com> <CAMuHMdV594xA1UoTeVixpXm3i5LDFO5cT=dd_iRwWLwvxQctZg@mail.gmail.com>
In-Reply-To: <CAMuHMdV594xA1UoTeVixpXm3i5LDFO5cT=dd_iRwWLwvxQctZg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 19 Oct 2023 08:37:09 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUG3SUVPJHSiNyQNzyqxiJpczUHhBxHN7YqEDcaWYwkFA@mail.gmail.com>
Message-ID: <CAMuHMdUG3SUVPJHSiNyQNzyqxiJpczUHhBxHN7YqEDcaWYwkFA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] RISC-V: Probe for unaligned access speed
To:     "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-doc@vger.kernel.org,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-riscv@lists.infradead.org, Jonathan Corbet <corbet@lwn.net>,
        Sia Jee Heng <jeeheng.sia@starfivetech.com>,
        Marc Zyngier <maz@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Simon Hosie <shosie@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Ley Foon Tan <leyfoon.tan@starfivetech.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <apatel@ventanamicro.com>,
        linux-kernel@vger.kernel.org,
        Xianting Tian <xianting.tian@linux.alibaba.com>,
        David Laight <David.Laight@aculab.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Andy Chiu <andy.chiu@sifive.com>,
        Evan Green <evan@rivosinc.com>
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

Hi Prabahkar,

On Thu, Sep 14, 2023 at 9:32 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Wed, Sep 13, 2023 at 7:46 PM Evan Green <evan@rivosinc.com> wrote:
> > On Wed, Sep 13, 2023 at 5:36 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Fri, Aug 18, 2023 at 9:44 PM Evan Green <evan@rivosinc.com> wrote:
> > > > Rather than deferring unaligned access speed determinations to a vendor
> > > > function, let's probe them and find out how fast they are. If we
> > > > determine that an unaligned word access is faster than N byte accesses,
> > > > mark the hardware's unaligned access as "fast". Otherwise, we mark
> > > > accesses as slow.
> > > >
> > > > The algorithm itself runs for a fixed amount of jiffies. Within each
> > > > iteration it attempts to time a single loop, and then keeps only the best
> > > > (fastest) loop it saw. This algorithm was found to have lower variance from
> > > > run to run than my first attempt, which counted the total number of
> > > > iterations that could be done in that fixed amount of jiffies. By taking
> > > > only the best iteration in the loop, assuming at least one loop wasn't
> > > > perturbed by an interrupt, we eliminate the effects of interrupts and
> > > > other "warm up" factors like branch prediction. The only downside is it
> > > > depends on having an rdtime granular and accurate enough to measure a
> > > > single copy. If we ever manage to complete a loop in 0 rdtime ticks, we
> > > > leave the unaligned setting at UNKNOWN.
> > > >
> > > > There is a slight change in user-visible behavior here. Previously, all
> > > > boards except the THead C906 reported misaligned access speed of
> > > > UNKNOWN. C906 reported FAST. With this change, since we're now measuring
> > > > misaligned access speed on each hart, all RISC-V systems will have this
> > > > key set as either FAST or SLOW.
> > > >
> > > > Currently, we don't have a way to confidently measure the difference between
> > > > SLOW and EMULATED, so we label anything not fast as SLOW. This will
> > > > mislabel some systems that are actually EMULATED as SLOW. When we get
> > > > support for delegating misaligned access traps to the kernel (as opposed
> > > > to the firmware quietly handling it), we can explicitly test in Linux to
> > > > see if unaligned accesses trap. Those systems will start to report
> > > > EMULATED, though older (today's) systems without that new SBI mechanism
> > > > will continue to report SLOW.
> > > >
> > > > I've updated the documentation for those hwprobe values to reflect
> > > > this, specifically: SLOW may or may not be emulated by software, and FAST
> > > > represents means being faster than equivalent byte accesses. The change
> > > > in documentation is accurate with respect to both the former and current
> > > > behavior.
> > > >
> > > > Signed-off-by: Evan Green <evan@rivosinc.com>
> > > > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > >
> > > Thanks for your patch, which is now commit 584ea6564bcaead2 ("RISC-V:
> > > Probe for unaligned access speed") in v6.6-rc1.
> > >
> > > On the boards I have, I get:
> > >
> > >     rzfive:
> > >         cpu0: Ratio of byte access time to unaligned word access is
> > > 1.05, unaligned accesses are fast
> >
> > Hrm, I'm a little surprised to be seeing this number come out so close
> > to 1. If you reboot a few times, what kind of variance do you get on
> > this?
>
> Rock-solid at 1.05 (even with increased resolution: 1.05853 on 3 tries)

After upgrading the firmware from [1] to [2], this changed to
"0.00, unaligned accesses are slow".

[1] RZ-Five-ETH
    U-Boot 2020.10-g611c657e43 (Aug 26 2022 - 11:29:06 +0100)

[2] OpenSBI v1.3-75-g3cf0ea4
    U-Boot 2023.01-00209-g1804c8ab17 (Oct 04 2023 - 13:18:01 +0100)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

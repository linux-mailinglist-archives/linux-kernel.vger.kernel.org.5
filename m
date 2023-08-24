Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D99787519
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 18:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242471AbjHXQTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 12:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242491AbjHXQTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 12:19:25 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691FD1BFA
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 09:18:55 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4ff9b389677so10709432e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 09:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1692893933; x=1693498733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xcpmQIaJ3WGITlP80o7lHc82w8Vh9jMV1bqtDZL9154=;
        b=EXC13LqUOvbmnTJi9XvsU0ESFZpGRpEMW2KS6mmLkv4VGq3dGCVVWm62daPHEtxbhF
         Yk3fnUdtvTNpUJFHCg5dJDJY8qbDEpBiUDyuZ4ApwIuAJWGOCJ68pK5c5L7JY/WUQLlA
         S6qGHoMSvGwzwibAIpi5/Ma9NlIV0a3aaoYkhr82KOX4WO9tTTgGxXdZj4m96CCxIgdP
         DA4hS3gYlE/8wuKGA5Z1ZMuWdu5eXpnJQDu8Gu88MnmA0tnbXkv1/XaXMJoRQfhGAzqp
         i7JuHAKICWjJMNpf9Ia+itwQZU1MdidAyging9RnU9E267f7yRNndGIfIlLyaxIRf0G1
         iNUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692893933; x=1693498733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xcpmQIaJ3WGITlP80o7lHc82w8Vh9jMV1bqtDZL9154=;
        b=iKp3k5ZoDdqEjWTPfWJSC8HniMu+Z6y7NzEfkvLmgiZfIA7z9NqnEVSFrDbW7UJGp2
         jJaBNjLpqBo7Qq0An3FEpeIErVkwV20yCgwN/fF2dgsIEGr8Rt8KctKaD4k6tMuhzBwR
         6rkYqOjfxv3U8ZKxyL7bkB6hTVSFqNGL3zO4rJeeJfi0p/Oqtj/fmTMAMpiLaq0yHPD4
         K7+CIreb8Nqwbvy/sT0KqPVjHJa/A9G4zRd/34LqBTa7Kddzf/SZeP/2G78Mx2rUYM0s
         AQQYad+keHNUXGENbBgVqI0Ga8ZxosEGbGq+kVGrUl82e/BpYTQbgyaLQNmdVTEDYpit
         Do2g==
X-Gm-Message-State: AOJu0Yxe7bBzgUleSCSmK0U1LhdVRPuWrzIBHm3BVYEOM1GT2UY5hFux
        3nQi8o1nM3+tt7a4D7vZde6q3Q8bTDJfPVwuZrecAA==
X-Google-Smtp-Source: AGHT+IFXb5yl9r0LvHVcSGU9TSK5ahTYdOzq873cOHNvKn7t08c6orKmlryauqOU6ndYqyidDX00WvT7bPnvGMaG1A4=
X-Received: by 2002:a19:5f19:0:b0:4ff:9a75:2106 with SMTP id
 t25-20020a195f19000000b004ff9a752106mr10946461lfb.39.1692893932613; Thu, 24
 Aug 2023 09:18:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230711201831.2695097-1-evan@rivosinc.com> <20230824-factual-jawed-2dddd2cf2bdd@wendy>
In-Reply-To: <20230824-factual-jawed-2dddd2cf2bdd@wendy>
From:   Evan Green <evan@rivosinc.com>
Date:   Thu, 24 Aug 2023 09:18:16 -0700
Message-ID: <CALs-Hss51fQE1yxe1Y1T86X+OfjPaAd386vosQ8gzRm=Njm1gw@mail.gmail.com>
Subject: Re: [PATCH v4] RISC-V: Show accurate per-hart isa in /proc/cpuinfo
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <apatel@ventanamicro.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Jonathan Corbet <corbet@lwn.net>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 5:20=E2=80=AFAM Conor Dooley <conor.dooley@microchi=
p.com> wrote:
>
> On Tue, Jul 11, 2023 at 01:18:30PM -0700, Evan Green wrote:
> > In /proc/cpuinfo, most of the information we show for each processor is
> > specific to that hart: marchid, mvendorid, mimpid, processor, hart,
> > compatible, and the mmu size. But the ISA string gets filtered through =
a
> > lowest common denominator mask, so that if one CPU is missing an ISA
> > extension, no CPUs will show it.
> >
> > Now that we track the ISA extensions for each hart, let's report ISA
> > extension info accurately per-hart in /proc/cpuinfo. We cannot change
> > the "isa:" line, as usermode may be relying on that line to show only
> > the common set of extensions supported across all harts. Add a new "har=
t
> > isa" line instead, which reports the true set of extensions for that
> > hart. This matches what is returned in riscv_hwprobe() when querying a
> > given hart.
> >
> > Signed-off-by: Evan Green <evan@rivosinc.com>
> > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> >
> > ---
> >
> > Changes in v4:
> >  - Documentation: Made the underline match the text line (Conor)
> >  - Documentation: hanged "in question" to "being described" (Andrew)
> >
> > Changes in v3:
> >  - Add some documentation (Conor)
> >
> > Changes in v2:
> >  - Added new "hart isa" line rather than altering behavior of existing
> >    "isa" line (Conor, Palmer)
> >
> >
> > I based this series on top of Conor's riscv-extensions-strings branch
> > from July 3rd, since otherwise this change gets hopelessly entangled
> > with that series.
> >
> > ---
> >  Documentation/riscv/uabi.rst | 10 ++++++++++
> >  arch/riscv/kernel/cpu.c      | 22 ++++++++++++++++++----
> >  2 files changed, 28 insertions(+), 4 deletions(-)
> >
> > diff --git a/Documentation/riscv/uabi.rst b/Documentation/riscv/uabi.rs=
t
> > index 8960fac42c40..afdda580e5a2 100644
> > --- a/Documentation/riscv/uabi.rst
> > +++ b/Documentation/riscv/uabi.rst
> > @@ -42,6 +42,16 @@ An example string following the order is::
> >
> >     rv64imadc_zifoo_zigoo_zafoo_sbar_scar_zxmbaz_xqux_xrux
> >
> > +"isa" vs "hart isa" lines in /proc/cpuinfo
> > +------------------------------------------
> > +
> > +The "isa" line in /proc/cpuinfo describes the lowest common denominato=
r of
> > +RISC-V ISA extensions understood by the kernel and implemented on all =
harts. The
> > +"hart isa" line, in contrast, describes the set of extensions understo=
od by the
> > +kernel on the particular hart being described, even if those extension=
s may not
> > +be present on all harts in the system. The "hart isa" line is consiste=
nt with
> > +what's returned by __riscv_hwprobe() when querying for that specific C=
PU.
>
> Thinking about this again, I don't think this is true. hwprobe uses
> has_fpu(), has_vector() etc that interact with Kconfig options but the
> percpu isa bitmap isn't affected by these.

Ugh yeah it's kind of a mishmash isn't it. hwprobe_isa_ext0() uses the
lowest common denominator for FD, C, V, but per-hart info for
Zba,Zbb,Zbs. Given the interface, per-hart info seems like what we
should have done there, and the FD, C, and V were my bad. The good
news is we can define new bits that do the right thing, though maybe
we should wait until someone actually wants them. For this patch we
should just remove this sentence. We can also correct the
documentation in hwprobe to mention the shortcoming in FD,C,V.

Palmer, do you want a spin of this patch or a followup on top to
remove the above sentence?

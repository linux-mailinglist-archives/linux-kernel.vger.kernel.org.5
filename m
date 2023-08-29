Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CACA178CB1C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 19:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235952AbjH2RWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 13:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237834AbjH2RWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 13:22:06 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276A811B
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 10:21:32 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-500b6456c7eso4256433e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 10:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1693329640; x=1693934440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=20Pmn3uR2c8KDzA5Z4/HQP8CRUu7dujiiXH5BmDnN6E=;
        b=kSDB2WQGUmyFMb01R+p1eOHpA23cK87y235AXbcJfL9G9KFKNf2dIv9ncfHs0rcOmp
         E6uOM3JtZeXY9UukSnhiPvf++gWg6uiXz9RA9Y5ivbckZgSO8etk1R0HhBGZdBhFzNN1
         m+uCPSFl2R9hFaky5j8T9urC+Fb/JcUaHUzR1levW/KcgOyIP+KQ7MkMdeyRiX8hfhU5
         s2ubteSKWoR35PveRgN4UhNXU6ynaq1Nak16x/lljn813szYXM/M6YnI5lryzFKk/5Rc
         5B2KzUWlhtfDA4tbDPChElGbp9jOnhDsYi0b2Bn3JyhsbmE4m+8hJAZwdUjnf0KUCEw9
         Hprw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693329640; x=1693934440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=20Pmn3uR2c8KDzA5Z4/HQP8CRUu7dujiiXH5BmDnN6E=;
        b=MEaF6X4fbFl01qVVYd3+tV+HuFvU+o+JaejWFcmHad/kEGmUw5o186QfqdlS5pI6fy
         NNzBqjG3iXdS5nWpLMoYBriWuSEhn3/Jl/5tr+t629sHPkNxTMqBMxQNcn0xGf0slaK6
         tXEYA1byf7ro4iVy7LxMSi/VTS0Stm2higawNwlOvXUQpaJutrh9FyO3YUkY2w6QoDFv
         Qa3gAYYf63HCg8+nWVSzt9Cq5CevhhnMFiYtN85q1/YeukFW8j6ZYiwPhtSsqxJlk2vt
         QGJGw9KSmuf5gbJD84qCIMxHCZTVMfaBlM0KaSh2dDW1PPniGnkPosT+hcKrcUaGyfLV
         HaGg==
X-Gm-Message-State: AOJu0Yyg9Hbqoyi4ikhXk4BCmLWG4LBCirV8isqdbfIzfMGmjwj4clqO
        /z9L5xx8OU/RY1aDeQht5nb6mOWHvt5NcdpxVB4UYw==
X-Google-Smtp-Source: AGHT+IEunguX+29lak9JYuQDp7TQRMvKgwEELQCu8RZRIZrqwbU75qRAqqSDSt/V+9PbVFdflUEqh665Cgkf2rSCUYI=
X-Received: by 2002:a05:6512:7c:b0:500:aed0:cb1b with SMTP id
 i28-20020a056512007c00b00500aed0cb1bmr6295408lfo.24.1693329640476; Tue, 29
 Aug 2023 10:20:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230711201831.2695097-1-evan@rivosinc.com> <20230829-e445d0bdff78969cc33a6263@orel>
In-Reply-To: <20230829-e445d0bdff78969cc33a6263@orel>
From:   Evan Green <evan@rivosinc.com>
Date:   Tue, 29 Aug 2023 10:20:04 -0700
Message-ID: <CALs-HsuTySr0ZojRtBeU3F6hd82UeNWNupaQpEULVqxf2jqzww@mail.gmail.com>
Subject: Re: [PATCH v4] RISC-V: Show accurate per-hart isa in /proc/cpuinfo
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
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
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 1:48=E2=80=AFAM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> Hi Evan,
>
> Here's my stab at new wording.
>
> On Tue, Jul 11, 2023 at 01:18:30PM -0700, Evan Green wrote:
> ...
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
> > +
>
> The "isa" and "hart isa" lines in /proc/cpuinfo list RISC-V ISA extension=
s
> which the kernel can identify (the kernel recognizes the extension's name=
)
> and have not been filtered out due to effectively not being present.  An
> extension is effectively not present when it is unusable, either due to
> defects (which the kernel is aware of), due to missing information which
> is necessary to complete the extension's description, or due to being
> explicitly "hidden", such as when a kernel command line parameter
> instructs the kernel to pretend the extension is not present.  Note, an
> extension's presence in a list does not imply the kernel is using the
> extension, nor does it imply that userspace or guest kernels may use the
> extension (__riscv_hwprobe() should be queried for userspace usability.
> The hypervisor should be queried, using hypervisor-specific APIs, to
> check guest kernel usability.)
>
> The "isa" line describes the lowest common denominator of extensions,
> which are the extensions implemented on all harts.  In contrast, the
> extensions listed in the "hart isa" line need not be implemented by
> any other hart than the hart corresponding to the line.
>
> ---
>
> I've specifically dropped the 'The "hart isa" line is consistent with
> what's returned by __riscv_hwprobe()...' part because I suspect hwprobe
> could at least lag what gets put in "hart isa", since the kernel may be
> taught about an extension for a different purpose first, neglecting
> hwprobe. And, there may be cases that hwprobe never enumerates an
> extension which the kernel does.

Thanks for this. My v5 had also dropped the hwprobe part. A few thoughts:

 * It seems like you want to make sure we call out the fact that the
kernel may trim out, for various reasons, ISA extensions that the
hardware does in fact support. This seems reasonable, but I don't
think we need to enumerate the complete list of "why" this might
happen, as that list is likely to go stale.
 * The "kernel is using the extension" part is a slightly confusing
perspective in this context, as it sort of implies the kernel has its
own agenda :). I'd expect users looking at /proc/cpuinfo are mostly
trying to figure out what extensions they themselves can use, and the
kernel's behavior factors in only insofar as it's required to support
the user in using a feature. Mostly I guess this is a phrasing nit.
 * The bringing up of guest kernels also seems confusing to me in the
context of /proc/cpuinfo. I'd expect discussions on how host ISA
extensions filter into guest OSes to be in a hypervisor-specifc
document, or at least a section dedicated to virtualization.
 * I hesitated in adding prescriptive guidance on what users should
do, as I think this section will hold up better over time if it just
describes current characteristics, rather than attempting to prescribe
behavior. If we want a prescriptive documentation on "use this for
that", that should probably be its own section

If I try to fold the gist of what you wrote into v5, I get something
like this (also with a very slight section heading change). Let me
know what you think:

"isa" and "hart isa" lines in /proc/cpuinfo
------------------------------------------

The "isa" line in /proc/cpuinfo describes the lowest common denominator of
RISC-V ISA extensions recognized by the kernel and implemented on all harts=
. The
"hart isa" line, in contrast, describes the set of extensions recognized by=
 the
kernel on the particular hart being described, even if those extensions may=
 not
be present on all harts in the system.

In both lines, the presence of an extension guarantees only that the
hardware has the described capability.
Additional kernel support or policy changes may be required before an
extension's capability is fully usable by userspace programs.

Inversely, the absence of an extension in these lines does not
necessarily mean the hardware does not support that feature. The
running kernel may not recognize the extension, or may have
deliberately disabled access to it.

-Evan

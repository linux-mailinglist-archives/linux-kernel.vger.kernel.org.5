Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4347891FC
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 00:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjHYWw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 18:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjHYWwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 18:52:09 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C291BCC
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 15:52:06 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-5009d4a4897so2152170e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 15:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1693003925; x=1693608725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+y9J0Vp2KEC0gOHwcifgBi34rB9oiYo6WicEeCrDYUk=;
        b=BqHgwsSFGMBSzPfBjaL1mADgNZ/JMV/t3ctoiSTSqoIS5gT/l4uFn/xXCt6JLYHUy7
         gPuSEJB2mTISHBWmZIMp31j/ybBK4kdYAyhdBlOs7wfaR8ddFAL65C0HQ5z5ntzz3uF2
         vYBhDyW9oc46xobiDjao2H/AWMfF8ipOXkLGtC3ycfJ4b1+g9r+V0M1UbbRMqnP7UrZo
         Og6lQd7ZrW6gCTz/6+vO73sKL64j4iTfOyFUwP12X0LaQZBEFoe8Yzt7H0KYrJH/kTkH
         Ldj7CMmu49LAQ012XQkydspk8hWy7+53LwAoR6wNe3O6zq7t2zoG4e1xYxGAb2GJpwOA
         bdYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693003925; x=1693608725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+y9J0Vp2KEC0gOHwcifgBi34rB9oiYo6WicEeCrDYUk=;
        b=IAnbxgWjA2Zld0G5KsceFV25x2ooezGVSqu+AgM/YJigUNbRZcxwtMllqocUYY8gl6
         uZ6m+brtgvf0qr+yKOHBqOtafgK0rbD9xTz5DPA2/YyJo4oiC/7LP5AuANWPHmH9O7bG
         domjLc5fTBgxEoRn9AtXHzk1rb1S5JKIwfPmUCb/QlDis4Lp4J9rIcq2hDwKLvesqemh
         1UZIqX05ziPpwkMf6nKRYeX2hn6fUa1ty4xrIPeces/ctM90B8/aBru9eF6NOYagHhnO
         v8s+4aGlVQxuE4U4hQzommL4mNvr9ISIx8k1iNTv1roFQUsefSOEhCBQt8EZ9/34zRTx
         a8/A==
X-Gm-Message-State: AOJu0Yyb2hX+kNnCY7iRz5nGvjIaMZVa5ywSyKqsfbzrdwp5vT25SFOz
        wIOyp+JgnxMtrIcpm+N8wEK0H6X1fqEl6XcMJCflFg==
X-Google-Smtp-Source: AGHT+IF+v+BY77506pMI43cchja2d3T+v50mea58RnGu7jsCphVTLnNPxrVLDaC4mo5oFMYvPobn4jQYIezwB6lXp8o=
X-Received: by 2002:a05:6512:4026:b0:4f9:570c:7b28 with SMTP id
 br38-20020a056512402600b004f9570c7b28mr17775050lfb.32.1693003924895; Fri, 25
 Aug 2023 15:52:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230711201831.2695097-1-evan@rivosinc.com> <20230824-factual-jawed-2dddd2cf2bdd@wendy>
 <CALs-Hss51fQE1yxe1Y1T86X+OfjPaAd386vosQ8gzRm=Njm1gw@mail.gmail.com>
 <20230824-exploit-spectacle-ecedd91e9075@spud> <CALs-HssqaOjvUOdBVn=oN+uzkkmjguys2UttTYgdcqJwJB0HnQ@mail.gmail.com>
 <20230825-374a82446ed3eea02fcb41e6@orel>
In-Reply-To: <20230825-374a82446ed3eea02fcb41e6@orel>
From:   Evan Green <evan@rivosinc.com>
Date:   Fri, 25 Aug 2023 15:51:28 -0700
Message-ID: <CALs-HstfA29DDrmVemP6bZe+kON9JDKYR3p132gG_WefA6d7eQ@mail.gmail.com>
Subject: Re: [PATCH v4] RISC-V: Show accurate per-hart isa in /proc/cpuinfo
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     Conor Dooley <conor@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 1:16=E2=80=AFAM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> On Thu, Aug 24, 2023 at 03:06:53PM -0700, Evan Green wrote:
> > On Thu, Aug 24, 2023 at 10:29=E2=80=AFAM Conor Dooley <conor@kernel.org=
> wrote:
> ...
> > > Do you want to have this new thing in cpuinfo tell the user "this har=
t
> > > has xyz extensions that are supported by a kernel, but maybe not this
> > > kernel" or to tell the user "this hart has xyz extensions that are
> > > supported by this kernel"? Your text above says "understood by the
> > > kernel", but I think that's a poor definition that needs to be improv=
ed
> > > to spell out exactly what you mean. IOW does "understood" mean the
> > > kernel will parse them into a structure, or does it mean "yes you can
> > > use this extension on this particular hart".
> >
> > I'm imagining /proc/cpuinfo being closer to "the CPU has it and the
> > kernel at least vaguely understands it, but may not have full support
> > for it enabled". I'm assuming /proc/cpuinfo is mostly used by 1)
> > humans wanting to know if they have hardware support for a feature,
> > and 2) administrators collecting telemetry to manage fleets (ie do I
> > have any hardware deployed that supports X).
>
> Is (2) a special case of (1)? (I want to make sure I understand all the
> cases.)

More or less, yes. In bucket two are also folks wondering things like
"are all these crash reports I'm getting specific to machines with X".

>
> > Programmers looking to
> > see "is the kernel support for this feature ready right now" would
> > ideally not be parsing /proc/cpuinfo text, as more direct mechanisms
> > like specific hwprobe bits for "am I fully ready to go" would be
> > easier to work with. Feel free to yell at me if this overall vision
> > seems flawed.
> >
> > I tried to look to see if there was consensus among the other
> > architectures. Aarch64 seems to go with "supported and fully enabled",
> > as their cpu_has_feature() directly tests elf_hwcap, and elements in
> > arm64_elf_hwcaps[] are Kconfig gated. X86 is complicated, but IIRC is
> > more along the lines of "hardware has it". They have two macros,
> > cpu_has() for "raw capability" and cpu_feature_enabled() for "kernel
> > can do it too", and they use cpu_has() for /proc/cpuinfo flags.
> >
>
> I'd lean more towards the way AArch64 goes, because, unless /proc/cpuinfo
> is just a blind regurgitation of an isa string from DT / ACPI, then the
> kernel must at least know something about it. Advertising a feature which
> is known, but also known not to work, seems odd to me. So my vote is that
> only features which are present and enabled in the kernel or present and
> not necessary to be enabled in the kernel in order for userspace or
> virtual machines to use be advertised in /proc/cpuinfo.
>
> We still have SMBIOS (dmidecode) to blindly dump what the hardware
> supports for cases (1) and (2) above.

Yeah, there's an argument to be made for that. My worry is it's a
difficult line to hold. The bar you're really trying to describe (or
at least what people might take away from it) is "if it's listed here
then it's fully ready to be used in userspace". But then things get
squishy when there are additional ways to control the use of the
feature (prctls() in init to turn it on, usermode policy to turn it
off, security doodads that disable it, etc). I'm assuming nobody wants
a version of /proc/cpuinfo that changes depending on which process is
asking. So then the line would have to be more carefully described as
"well, the hardware can do it, and the kernel COULD do it under some
circumstances, but YMMV", which ends up falling somewhat short of the
original goal. In my mind keeping /proc/cpuinfo as close to "here's
what the hardware can do" seems like a more defensible position.
-Evan

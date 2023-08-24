Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F36787BA4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 00:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243934AbjHXWq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 18:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243933AbjHXWqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 18:46:38 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D351BF7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 15:46:35 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fe2d152f62so501705e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 15:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1692917193; x=1693521993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OCYNyYJU7vy6f7+4m3Y1Z8s/5IyvH+iRHdLo0oYTHwQ=;
        b=RhSm8Ww1H4fdAzH92XRAPITF5WO8VuxzhR6L+9bzkQ/vN5ImXhCszgR0zS+XBTP0CZ
         zOECgGy6mkfeldcWXNpGKsTAkoEFGOdKoM+y46Y5Sy/zQRhiFoCmt3EfDRYN2LL9RZIq
         zLuprtdJhaOPh05ZgQfhmfHMWSSZc/tsIVmm46WgoQgYItqZX/Fz0/MdpDY/vvP7omPY
         ZnSLMQrc5NeFH6md7KKi61m15Q5jzqQPTv7kSEug9Sai7CyhUANZvhl/ag30Vmx3RUHc
         YoAf5KSwAbnyyvC/LiJTPUtNocux6fQss2iiGY6eehyp124iFOp+SHdw4mBY3TI9Cm4k
         rg6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692917193; x=1693521993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OCYNyYJU7vy6f7+4m3Y1Z8s/5IyvH+iRHdLo0oYTHwQ=;
        b=PvMWc69Nrs39AZ24O72bl+mnRP/sonzpww7gc06jVe7vGlSpuM6UcPce9vDEtDEMk2
         kxJVESXU1r7xi7X2cIFG0K/a3aq3s0XMJsPHDjc0XKotuD6heJdAfKXa480dV8+11A5H
         jQwYBgaPeZxh+wXK2l1iT7OcdzQyBDK9ckgE6NoiIXZfdohbPbZvm9q/D/Io4Qayv4ol
         ueau60yzT8HuDR3TEVb+BmkaKOVrLoS8kUfjpWLUZ+/I0zD3HiCycTrP/B41by/p07zS
         dHVLj6M6746xacbV8cWEQCHvC2tOEs1Um5Svy36VgyZVsjvJUoXXLsH5pkTniM0YONvU
         fcTg==
X-Gm-Message-State: AOJu0Yx+ve3tti0Vt/TaVY6rhBYLrZq45SVAFJRrCckO8hJNwjMRCXMX
        QRcQq41JBa10+rS4Occ5K4bppVrcNEeMvB7Py4SpSA==
X-Google-Smtp-Source: AGHT+IGjUvhXZF3UrB6wnTyiM21PdNuE5x48UmMtDL6ByEOKmcfwpNgwI1gzumwtML5+FjMz1Rb3BQyPCujzqOLacIc=
X-Received: by 2002:ac2:4c92:0:b0:4f4:dbcc:54da with SMTP id
 d18-20020ac24c92000000b004f4dbcc54damr10170585lfl.27.1692917193533; Thu, 24
 Aug 2023 15:46:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230711201831.2695097-1-evan@rivosinc.com> <20230824-factual-jawed-2dddd2cf2bdd@wendy>
 <CALs-Hss51fQE1yxe1Y1T86X+OfjPaAd386vosQ8gzRm=Njm1gw@mail.gmail.com>
 <20230824-exploit-spectacle-ecedd91e9075@spud> <CALs-HssqaOjvUOdBVn=oN+uzkkmjguys2UttTYgdcqJwJB0HnQ@mail.gmail.com>
 <20230824-sizing-booth-e1068c6d033f@spud>
In-Reply-To: <20230824-sizing-booth-e1068c6d033f@spud>
From:   Evan Green <evan@rivosinc.com>
Date:   Thu, 24 Aug 2023 15:45:57 -0700
Message-ID: <CALs-HsuA+g+YA707hPHwvTk8Tn6D9iwu8EmkM-f75gqTeum-5g@mail.gmail.com>
Subject: Re: [PATCH v4] RISC-V: Show accurate per-hart isa in /proc/cpuinfo
To:     Conor Dooley <conor@kernel.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Andrew Jones <ajones@ventanamicro.com>
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

On Thu, Aug 24, 2023 at 3:28=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Thu, Aug 24, 2023 at 03:06:53PM -0700, Evan Green wrote:
> > On Thu, Aug 24, 2023 at 10:29=E2=80=AFAM Conor Dooley <conor@kernel.org=
> wrote:
> > > On Thu, Aug 24, 2023 at 09:18:16AM -0700, Evan Green wrote:
> > > > On Thu, Aug 24, 2023 at 5:20=E2=80=AFAM Conor Dooley <conor.dooley@=
microchip.com> wrote:
> > > > > On Tue, Jul 11, 2023 at 01:18:30PM -0700, Evan Green wrote:
>
> > > > > > +"isa" vs "hart isa" lines in /proc/cpuinfo
> > > > > > +------------------------------------------
> > > > > > +
> > > > > > +The "isa" line in /proc/cpuinfo describes the lowest common de=
nominator of
> > > > > > +RISC-V ISA extensions understood by the kernel and implemented=
 on all harts. The
> > > > > > +"hart isa" line, in contrast, describes the set of extensions =
understood by the
> > > > > > +kernel on the particular hart being described, even if those e=
xtensions may not
> > > > > > +be present on all harts in the system. The "hart isa" line is =
consistent with
> > > > > > +what's returned by __riscv_hwprobe() when querying for that sp=
ecific CPU.
> > > > >
> > > > > Thinking about this again, I don't think this is true. hwprobe us=
es
> > > > > has_fpu(), has_vector() etc that interact with Kconfig options bu=
t the
> > > > > percpu isa bitmap isn't affected by these.
> > > >
> > > > Ugh yeah it's kind of a mishmash isn't it. hwprobe_isa_ext0() uses =
the
> > > > lowest common denominator for FD, C, V, but per-hart info for
> > > > Zba,Zbb,Zbs. Given the interface, per-hart info seems like what we
> > > > should have done there, and the FD, C, and V were my bad. The good
> > > > news is we can define new bits that do the right thing, though mayb=
e
> > > > we should wait until someone actually wants them. For this patch we
> > > > should just remove this sentence. We can also correct the
> > > > documentation in hwprobe to mention the shortcoming in FD,C,V.
> > >
> > > I'm not really sure it's all that much of a shortcoming for V or FD,
> > > since without the kernel support you shouldn't be using those extensi=
ons
> > > anyway. A hwprobe thing for that sounds like a footgun to me & I thin=
k
> > > the current behaviour is how it should be for these extensions.
> > > It not being per-cpu is arguably a bug I suppose? But I would contend
> >
> > Yeah it was mostly the not being per-cpu I was pointing to in my previo=
us email.
> >
> > > that we are conveying support for the extension on a per-hart level,
> > > with it then also gated by the kernel supporting V or FD, which is on=
 a
> > > system-wide basis.
> > > Any other extensions that require Kconfig-gated kernel support should
> > > also not report via hwprobe that the extension is supported when the
> > > Kconfig option is disabled. It just so happens that the set of
> > > extensions that hwprobe supports that are Kconfig-gated and those tha=
t
> > > require all-hart support are one and the same right now, so we can ki=
nda
> > > just conflate the two & use has_vector() et al that handles both
> > > kconfig-gating and all-hart support. Until something comes along that=
 needs
> > > anything different, I'd leave well enough alone for hwprobe...
> >
> > Sounds good.
> >
> > >
> > > > Palmer, do you want a spin of this patch or a followup on top to
> > > > remove the above sentence?
> > >
> > > It's not actually been applied yet, right?
> > >
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
> > have any hardware deployed that supports X). Programmers looking to
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
>
> I'm fine with the per-cpu stuff meaning "the hardware has it and a kernel=
,
> but not necessarily this one, supports it" - just please make the
> documentation clear about it.

Sounds good, will spin.
-Evan

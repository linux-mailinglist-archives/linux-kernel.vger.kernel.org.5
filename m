Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00FDF78B589
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 18:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbjH1Qpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 12:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbjH1Qph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 12:45:37 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDAA5139
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 09:45:33 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-5007c8308c3so5393342e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 09:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1693241132; x=1693845932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rUro7QwxD0vKwAUT+qWKm/yCMwnGx0UOQKp8vqTeg1M=;
        b=JiBsCYeNmw+xE/uxWbWZ2NQ5KIvDu/V5/1h4D6e/NJSefDzz5G1tloYG0Tv09xfk4N
         uLxI46vSsuZAPAt1jd2EhjrVoVnttHcDcf2qhwAvzVHMx+3xKCgoYUEFskrR+fbvRsEA
         PuKjSS7G0aXu7hFc+T32BarkI55mj3Obnw1EpDPujWMc4qkSolaZ6cf6OXcq7f1DqqjN
         o51nGop2VYsojhuRVLcyBPt6DTiAycygUUiNwRRBlqGiJ5hOz7OIdHsHMTpSiVC5pgoL
         154JF5DIkjdchzxZxMBOu1OAvFo2irXuIvDnTtvo5YHT5Mv8AMghVKddK7noupmaMEgv
         QPdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693241132; x=1693845932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rUro7QwxD0vKwAUT+qWKm/yCMwnGx0UOQKp8vqTeg1M=;
        b=acn84JZBHfFn9gJr6hsSiWDdDwb9lU0KO8/AECnfr2CX2cTUeaJwf6KYQwpmDDpcOH
         Ac51t8fyhyr34JJHm53Z7so3BnkxVxmr1e9ck0jWVFrtgUO/udGXW8cCrWMA+jsuN07m
         ETuLkH77F1R2BShSXzAQ3K9mwPY9t1+gmAiYQ/baO8s4t+V/3OAmYheEOi7DVMp6YJUn
         5Up4UZGPq2i63BsfIAKoT8juCQTkZRJDYaDqjDlO/kITOOzpF6X9nO9fwIpRofyfn0iL
         w5SJWkr3ULbZVvsvXsA3c2VV5fpL68bUdHhWrTVw2fQR+fHJIebA+HNuk8gehzqUSsBn
         5z6A==
X-Gm-Message-State: AOJu0YxJbYQXwp4pls5VNB8+3medIXy89ge4j8COcLMxGNVvRLc5hNFW
        OAv/MCviW0iMza+2ShrOSVSN3HOCK0UtcAvCojrEvQ==
X-Google-Smtp-Source: AGHT+IHT/JeNdaGMDQop2aCFdzEnxM4ijxxtyQfqFgtW/FreZE/60xXaqH+YO0DtQi7lOKEK6OYttesq0gJHhTGlg0Q=
X-Received: by 2002:ac2:5f41:0:b0:4f8:72fd:ed95 with SMTP id
 1-20020ac25f41000000b004f872fded95mr14942201lfz.22.1693241131906; Mon, 28 Aug
 2023 09:45:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230711201831.2695097-1-evan@rivosinc.com> <20230824-factual-jawed-2dddd2cf2bdd@wendy>
 <CALs-Hss51fQE1yxe1Y1T86X+OfjPaAd386vosQ8gzRm=Njm1gw@mail.gmail.com>
 <20230824-exploit-spectacle-ecedd91e9075@spud> <CALs-HssqaOjvUOdBVn=oN+uzkkmjguys2UttTYgdcqJwJB0HnQ@mail.gmail.com>
 <20230825-374a82446ed3eea02fcb41e6@orel> <CALs-HstfA29DDrmVemP6bZe+kON9JDKYR3p132gG_WefA6d7eQ@mail.gmail.com>
 <20230826-3869468d499caf2850681d08@orel>
In-Reply-To: <20230826-3869468d499caf2850681d08@orel>
From:   Evan Green <evan@rivosinc.com>
Date:   Mon, 28 Aug 2023 09:44:55 -0700
Message-ID: <CALs-HsskEUu3cu8pAc272Z47ro25e=fyuPt8jQBcJE2_RmFGtQ@mail.gmail.com>
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
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 26, 2023 at 1:01=E2=80=AFAM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> On Fri, Aug 25, 2023 at 03:51:28PM -0700, Evan Green wrote:
> > On Fri, Aug 25, 2023 at 1:16=E2=80=AFAM Andrew Jones <ajones@ventanamic=
ro.com> wrote:
> > >
> > > On Thu, Aug 24, 2023 at 03:06:53PM -0700, Evan Green wrote:
> > > > On Thu, Aug 24, 2023 at 10:29=E2=80=AFAM Conor Dooley <conor@kernel=
.org> wrote:
> > > ...
> > > > > Do you want to have this new thing in cpuinfo tell the user "this=
 hart
> > > > > has xyz extensions that are supported by a kernel, but maybe not =
this
> > > > > kernel" or to tell the user "this hart has xyz extensions that ar=
e
> > > > > supported by this kernel"? Your text above says "understood by th=
e
> > > > > kernel", but I think that's a poor definition that needs to be im=
proved
> > > > > to spell out exactly what you mean. IOW does "understood" mean th=
e
> > > > > kernel will parse them into a structure, or does it mean "yes you=
 can
> > > > > use this extension on this particular hart".
> > > >
> > > > I'm imagining /proc/cpuinfo being closer to "the CPU has it and the
> > > > kernel at least vaguely understands it, but may not have full suppo=
rt
> > > > for it enabled". I'm assuming /proc/cpuinfo is mostly used by 1)
> > > > humans wanting to know if they have hardware support for a feature,
> > > > and 2) administrators collecting telemetry to manage fleets (ie do =
I
> > > > have any hardware deployed that supports X).
> > >
> > > Is (2) a special case of (1)? (I want to make sure I understand all t=
he
> > > cases.)
> >
> > More or less, yes. In bucket two are also folks wondering things like
> > "are all these crash reports I'm getting specific to machines with X".
> >
> > >
> > > > Programmers looking to
> > > > see "is the kernel support for this feature ready right now" would
> > > > ideally not be parsing /proc/cpuinfo text, as more direct mechanism=
s
> > > > like specific hwprobe bits for "am I fully ready to go" would be
> > > > easier to work with. Feel free to yell at me if this overall vision
> > > > seems flawed.
> > > >
> > > > I tried to look to see if there was consensus among the other
> > > > architectures. Aarch64 seems to go with "supported and fully enable=
d",
> > > > as their cpu_has_feature() directly tests elf_hwcap, and elements i=
n
> > > > arm64_elf_hwcaps[] are Kconfig gated. X86 is complicated, but IIRC =
is
> > > > more along the lines of "hardware has it". They have two macros,
> > > > cpu_has() for "raw capability" and cpu_feature_enabled() for "kerne=
l
> > > > can do it too", and they use cpu_has() for /proc/cpuinfo flags.
> > > >
> > >
> > > I'd lean more towards the way AArch64 goes, because, unless /proc/cpu=
info
> > > is just a blind regurgitation of an isa string from DT / ACPI, then t=
he
> > > kernel must at least know something about it. Advertising a feature w=
hich
> > > is known, but also known not to work, seems odd to me. So my vote is =
that
> > > only features which are present and enabled in the kernel or present =
and
> > > not necessary to be enabled in the kernel in order for userspace or
> > > virtual machines to use be advertised in /proc/cpuinfo.
> > >
> > > We still have SMBIOS (dmidecode) to blindly dump what the hardware
> > > supports for cases (1) and (2) above.
> >
> > Yeah, there's an argument to be made for that. My worry is it's a
> > difficult line to hold. The bar you're really trying to describe (or
> > at least what people might take away from it) is "if it's listed here
> > then it's fully ready to be used in userspace". But then things get
> > squishy when there are additional ways to control the use of the
> > feature (prctls() in init to turn it on, usermode policy to turn it
> > off, security doodads that disable it, etc). I'm assuming nobody wants
> > a version of /proc/cpuinfo that changes depending on which process is
> > asking. So then the line would have to be more carefully described as
> > "well, the hardware can do it, and the kernel COULD do it under some
> > circumstances, but YMMV", which ends up falling somewhat short of the
> > original goal. In my mind keeping /proc/cpuinfo as close to "here's
> > what the hardware can do" seems like a more defensible position.
> > -Evan
>
> I agree with that. I was actually even trying to say the same thing,
> but only by bringing up virtual machines. Once we decide we'll expose
> extensions to VMs, whether or not the host kernel enables them, then
> none of the other host kernel configurations matter with respect to
> advertising the feature, since the guest kernel may have a completely
> different set of configurations.

My head spins a little when I try to picture a feature which 1)
requires kernel support to use, 2) has that kernel support turned off
in the host kernel, but 3) is passed down into guest kernels.
Generally though, I agree that trying to tie the guarantees of
features in /proc/cpuinfo too much to software gets confusing when
viewed through the double lens of virtualization.

>
> So I think we should only be filtering out extensions that are disabled
> because they're broken (have a detected erratum), have been "hidden"
> (have a kernel command line allowing them to be treated as if not
> present), or cannot be used at all due to missing accompanying hardware
> descriptions (such as block size info for CBO extensions). In all cases,
> I presume we'd wire checks up in riscv_isa_extension_check() and no
> checks would be gated on Kconfigs or anything else. And, since
> /proc/cpuinfo gets its list from the bitmap that's already filtered by
> riscv_isa_extension_check(), then, long story short, we're good to go :-)
>
> But maybe we can try to spell that policy out a bit more in
> Documentation/riscv/uabi.rst.

Right, that sounds reasonable to me, and is consistent with the
behavior we already have. With this documentation change I was only
trying to define the lower bound, rather than the complete definition
for every case. In other words, seeing a feature in cpuinfo guarantees
only that the hardware (or virtualized hardware) supports the feature,
but that's all the language says. So for instance NOT seeing a feature
in cpuinfo doesn't necessarily mean the hardware doesn't support it.
Software turning it off for the reasons you describe IMO doesn't
contradict what's written here. I was planning to leave that tacit,
but if you have suggestions on how to spell that out I'd take them.

-Evan

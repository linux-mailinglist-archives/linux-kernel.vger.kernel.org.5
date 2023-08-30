Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE4678DE4F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 21:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239883AbjH3TBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343945AbjH3Rdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 13:33:47 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 575A4198
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 10:33:43 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50078e52537so140941e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 10:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1693416821; x=1694021621; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rFAqUPUHLCt1ICzqJ94/cfZ/om7aUCeIQB1HCAlluIQ=;
        b=d3eG/se/rEzfjo4z4K53ffufuviJ3j6M6a4rjL0WcL5IjIzrO8rDucyHVzVeLp5cFJ
         SfS6SQPuL15qcRNto9r3Aiug3pym+0Pg+4x/8MEUJNpurGY/61/rBGzC2pnDMD+QsntN
         +O0o0YNESeVZ02vE7plcU1pzRrqFYRyHZo6SseJXyF5nLXhl7vpOZEVCYgAe4nLL2IFQ
         8pB621D9DIbRw2XPhXBS2tN7WRIKYulsSBBSROdsafk+3/TCIvJbjljy5ajlqn0KmKJr
         BY8hopEQ4oykp4yUoE0nShaWzzS7otjxBOTMrVi1OV9f3Ky8dt3eO95xkrCGeKDV/tLD
         EXaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693416821; x=1694021621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rFAqUPUHLCt1ICzqJ94/cfZ/om7aUCeIQB1HCAlluIQ=;
        b=MYetiaG75MqFeR+9QIsyWRmbV/ftlJTQaRtoqC29lCVTFpwH7Rhi8BFjKKIo0sdoE4
         XnlWVKQ+uCU32kwfPPBD7vwU/RK/C5I2Li/2PBGXNFvLXZ0a2RvBWqcz0b3Zbd3tIyxi
         FXx0L8skTWWRB/hf+wu4nyWpZLakrwL+Vl8d0UrI/yoXAZDURFN8eX9gSGKh3uFwtjEE
         d9caRP0A6wJJiodPZ5JcZJBV/JbN0s2PjxMSe206r05ADDbbCRGVoXkWM0hlsaD8q2iF
         +7x2ep08o1jpGgg6Gl7XPmTPYhlt7r9T2UJ9lqZh4DlJecj/HzxrhNwpKaPjDXOVhIDR
         nmgw==
X-Gm-Message-State: AOJu0Yz/27rcEPe4av3Dm7r+y5H67j8ud09zhnoqbKNA2RffbwXsGg0K
        WNUZjk4m/pQUIFj4q34Xn6FBp3JKAA+TS7luO/w/yA==
X-Google-Smtp-Source: AGHT+IHlWKSdVmP8pFG6g9r/7t6cofB3knDmKEpJmBCYjlMtzueLbcTeNe00mhRVTtaLSoCabnUPc5rXtH1thlBuqjQ=
X-Received: by 2002:a05:6512:ac3:b0:500:780b:5bdc with SMTP id
 n3-20020a0565120ac300b00500780b5bdcmr2588428lfu.49.1693416821252; Wed, 30 Aug
 2023 10:33:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230711201831.2695097-1-evan@rivosinc.com> <20230829-e445d0bdff78969cc33a6263@orel>
 <CALs-HsuTySr0ZojRtBeU3F6hd82UeNWNupaQpEULVqxf2jqzww@mail.gmail.com> <20230830-86f54e19392767c02d8d3146@orel>
In-Reply-To: <20230830-86f54e19392767c02d8d3146@orel>
From:   Evan Green <evan@rivosinc.com>
Date:   Wed, 30 Aug 2023 10:33:04 -0700
Message-ID: <CALs-HsuCx_UH4oiFEq7arrAjRFtGe7So07ur-pwvafw3a0QyEw@mail.gmail.com>
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
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 2:03=E2=80=AFAM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> On Tue, Aug 29, 2023 at 10:20:04AM -0700, Evan Green wrote:
> > On Tue, Aug 29, 2023 at 1:48=E2=80=AFAM Andrew Jones <ajones@ventanamic=
ro.com> wrote:
> > >
> > > Hi Evan,
> > >
> > > Here's my stab at new wording.
> > >
> > > On Tue, Jul 11, 2023 at 01:18:30PM -0700, Evan Green wrote:
> > > ...
> > > > diff --git a/Documentation/riscv/uabi.rst b/Documentation/riscv/uab=
i.rst
> > > > index 8960fac42c40..afdda580e5a2 100644
> > > > --- a/Documentation/riscv/uabi.rst
> > > > +++ b/Documentation/riscv/uabi.rst
> > > > @@ -42,6 +42,16 @@ An example string following the order is::
> > > >
> > > >     rv64imadc_zifoo_zigoo_zafoo_sbar_scar_zxmbaz_xqux_xrux
> > > >
> > > > +"isa" vs "hart isa" lines in /proc/cpuinfo
> > > > +------------------------------------------
> > > > +
> > > > +The "isa" line in /proc/cpuinfo describes the lowest common denomi=
nator of
> > > > +RISC-V ISA extensions understood by the kernel and implemented on =
all harts. The
> > > > +"hart isa" line, in contrast, describes the set of extensions unde=
rstood by the
> > > > +kernel on the particular hart being described, even if those exten=
sions may not
> > > > +be present on all harts in the system. The "hart isa" line is cons=
istent with
> > > > +what's returned by __riscv_hwprobe() when querying for that specif=
ic CPU.
> > > > +
> > >
> > > The "isa" and "hart isa" lines in /proc/cpuinfo list RISC-V ISA exten=
sions
> > > which the kernel can identify (the kernel recognizes the extension's =
name)
> > > and have not been filtered out due to effectively not being present. =
 An
> > > extension is effectively not present when it is unusable, either due =
to
> > > defects (which the kernel is aware of), due to missing information wh=
ich
> > > is necessary to complete the extension's description, or due to being
> > > explicitly "hidden", such as when a kernel command line parameter
> > > instructs the kernel to pretend the extension is not present.  Note, =
an
> > > extension's presence in a list does not imply the kernel is using the
> > > extension, nor does it imply that userspace or guest kernels may use =
the
> > > extension (__riscv_hwprobe() should be queried for userspace usabilit=
y.
> > > The hypervisor should be queried, using hypervisor-specific APIs, to
> > > check guest kernel usability.)
> > >
> > > The "isa" line describes the lowest common denominator of extensions,
> > > which are the extensions implemented on all harts.  In contrast, the
> > > extensions listed in the "hart isa" line need not be implemented by
> > > any other hart than the hart corresponding to the line.
> > >
> > > ---
> > >
> > > I've specifically dropped the 'The "hart isa" line is consistent with
> > > what's returned by __riscv_hwprobe()...' part because I suspect hwpro=
be
> > > could at least lag what gets put in "hart isa", since the kernel may =
be
> > > taught about an extension for a different purpose first, neglecting
> > > hwprobe. And, there may be cases that hwprobe never enumerates an
> > > extension which the kernel does.
> >
> > Thanks for this. My v5 had also dropped the hwprobe part. A few thought=
s:
> >
> >  * It seems like you want to make sure we call out the fact that the
> > kernel may trim out, for various reasons, ISA extensions that the
> > hardware does in fact support. This seems reasonable, but I don't
> > think we need to enumerate the complete list of "why" this might
> > happen, as that list is likely to go stale.
>
> I agree it's better to not [try to] list all the possibilities, assuming
> we can come up with good, general words to capture the idea.
>
> >  * The "kernel is using the extension" part is a slightly confusing
> > perspective in this context, as it sort of implies the kernel has its
> > own agenda :). I'd expect users looking at /proc/cpuinfo are mostly
> > trying to figure out what extensions they themselves can use, and the
> > kernel's behavior factors in only insofar as it's required to support
> > the user in using a feature. Mostly I guess this is a phrasing nit.
>
> We'll have plenty of S-mode extensions listed in these strings. Users
> who recognize S-mode extensions may want to know if they're listed becaus=
e
> the kernel is applying them (and wouldn't be listed otherwise), or whethe=
r
> they're listed simply because they exist on the hart(s).

I see. You're right I was thinking only about U-mode extensions.

>
> >  * The bringing up of guest kernels also seems confusing to me in the
> > context of /proc/cpuinfo. I'd expect discussions on how host ISA
> > extensions filter into guest OSes to be in a hypervisor-specifc
> > document, or at least a section dedicated to virtualization.
>
> If there weren't S-mode extensions being listed, then I would agree,
> but, since there are, it seems odd to not explain what it means for
> them to be there wrt host and guest kernels.

I'm not a virtualization guy, but my impression was people didn't have
expectations that everything they saw in cpuinfo would be wholesale
presented to guest VMs. There's always that layer of hypervisor
configuration that may strip out some features. So I'm still not super
convinced guest VMs need a carveout/caveat here, but let me see if I
can fold it in.

>
> >  * I hesitated in adding prescriptive guidance on what users should
> > do, as I think this section will hold up better over time if it just
> > describes current characteristics, rather than attempting to prescribe
> > behavior. If we want a prescriptive documentation on "use this for
> > that", that should probably be its own section
>
> I guess the guidance you're referring to is the "(__riscv_hwprobe() shoul=
d
> be queried for userspace usability.  The hypervisor should be queried,
> using hypervisor-specific APIs, to check guest kernel usability.)" bit.
> I'm fine with dropping that or moving it to another section, but I think
> the more we point out hwprobe, the better. If developers are reading this
> /proc/cpuinfo section because they want to detect extensions, then I'd
> prefer the section redirects them to hwprobe.

Fair enough. I still haven't brought myself to wedge in an ad for
hwprobe, but I also don't disagree with this :)

>
> >
> > If I try to fold the gist of what you wrote into v5, I get something
> > like this (also with a very slight section heading change). Let me
> > know what you think:
> >
> > "isa" and "hart isa" lines in /proc/cpuinfo
> > ------------------------------------------
>
> need one more _
>
> >
> > The "isa" line in /proc/cpuinfo describes the lowest common denominator=
 of
> > RISC-V ISA extensions recognized by the kernel and implemented on all h=
arts. The
> > "hart isa" line, in contrast, describes the set of extensions recognize=
d by the
> > kernel on the particular hart being described, even if those extensions=
 may not
> > be present on all harts in the system.
> >
> > In both lines, the presence of an extension guarantees only that the
> > hardware has the described capability.
> > Additional kernel support or policy changes may be required before an
> > extension's capability is fully usable by userspace programs.
>
> or guest kernels in the case of S-mode extensions.
>
> >
> > Inversely, the absence of an extension in these lines does not
> > necessarily mean the hardware does not support that feature. The
> > running kernel may not recognize the extension, or may have
> > deliberately disabled access to it.
>
> I'm not sure about the word "disabled". The kernel can only disable U-mod=
e
> extensions and S-mode extensions for guests. S-mode extensions for the
> current kernel would have to be disabled by its next higher privilege
> level.
>
> How about "...may not recognize the extension, or may have deliberately
> removed it from the listing."

Perfect.

>
> (But then readers will wonder why an extension would be deliberately
> removed from the listing, which brings us back to trying to come up
> with general words to capture the cases I listed. Or, maybe we don't
> have to care if they wonder why in this section/document.)

I know, I felt the same pull to explain why as well. But I think given
that our goal with this section is mostly to make the distinction of
"presence !=3D active", explaining exactly why the kernel may remove it
is not strictly necessary. All of my attempts to tack something on end
up being enumerated lists, which don't come out well and muddle the
message.

Here's another shot (line endings may be wonky):

"isa" and "hart isa" lines in /proc/cpuinfo
-------------------------------------------

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
Similarly, for S-mode extensions, presence in one of these lines does
not guarantee that the kernel is taking advantage of the extension, or
that the feature will be visible in guest VMs managed by this kernel.

Inversely, the absence of an extension in these lines does not
necessarily mean the hardware does not support that feature. The
running kernel may not recognize the extension, or may have
deliberately removed it from the listing.

-Evan

>
> Thanks,
> drew

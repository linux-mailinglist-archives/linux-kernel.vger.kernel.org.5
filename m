Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C55A278DFA6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243469AbjH3TOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242569AbjH3JDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 05:03:33 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A006CC9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 02:03:29 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99df431d4bfso702124366b.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 02:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1693386207; x=1693991007; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=649ObFmLgbtSYXsjclxuRgkQ2A6tkSvEpqj8h0NPvpY=;
        b=R8k6fd8M+kf4WnBD/0OS054cowbGyDnSsqecNJ4TM0dmsp8un+/qbPbPjbFV5B3bW/
         8z/maFOwnUjohtKV1ShHEHv2y9YuMz8FXfgHa7mTSTWna1d3aHfiAo06bl41xezRS1IF
         V+qZ9bIR9VZqga6eGUBwRm9bDZnU8QcouoIq5ipLXU8Dt+zl1Sz6qzWQOHPVQAei/QHJ
         XJqoNLo2KR1HYuVqcyTKU38cJLUhr1zu+SPc3npc26SqdDUUpuudzGwsDYy9wNKAGxSY
         XpE7q03oj2N6hCnlZv4vBZikJHoeZm4g1C9KFkzS1OqqwAUOOQaqMZyPxlro3SxFNVIo
         Z3YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693386207; x=1693991007;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=649ObFmLgbtSYXsjclxuRgkQ2A6tkSvEpqj8h0NPvpY=;
        b=UxsMC4IXRmFcwNjSyDZw31WYVVtxwzk4zhd0X7wKwNaqpUWGiZhDYzk3yTM9HViNT0
         NBsjc0Fn5GUVL7H1+VQVqPYSAYde0Gb9WUc8Tj+Cr035dABfu3oKeUWHz5kX1eNMbyiE
         Z+BEoTUXLGMUNARWZ6zpwfGJmsX/0IGve8zJvxhvMqRgPsmpbiLktcCPZkxqKKjhQp5T
         GmqU8hW2a/fe/U5YlSLsdXFANud+pX3L/XVIvs1W668l45vn1o3r4dhEWqIeqOQISPnX
         G2VZumq8qH9UT5Q4CAyFZpBzp10aIM1lT+RiosO660v+Mt5QQv3suN8sNDkfYlTJxljs
         hsAA==
X-Gm-Message-State: AOJu0YxP3YvXizTWX1Y6LdOD2Sl5ABfAsh4q4QZ1U195ENFMqDTQdLJX
        xisUuPqiVCeV69rZDDF0Lwy9Xg==
X-Google-Smtp-Source: AGHT+IE8vxpS4Ef/hU74qW0e+L57jhX9+tfjs6yzIB1PyupSu76Ff+cXCFAN27I8z5ygwhbsvj2Klg==
X-Received: by 2002:a17:907:930e:b0:99b:c86b:1d25 with SMTP id bu14-20020a170907930e00b0099bc86b1d25mr1596796ejc.26.1693386207466;
        Wed, 30 Aug 2023 02:03:27 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id f23-20020a1709067f9700b0098748422178sm6936918ejr.56.2023.08.30.02.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 02:03:26 -0700 (PDT)
Date:   Wed, 30 Aug 2023 11:03:25 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Evan Green <evan@rivosinc.com>
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
Subject: Re: [PATCH v4] RISC-V: Show accurate per-hart isa in /proc/cpuinfo
Message-ID: <20230830-86f54e19392767c02d8d3146@orel>
References: <20230711201831.2695097-1-evan@rivosinc.com>
 <20230829-e445d0bdff78969cc33a6263@orel>
 <CALs-HsuTySr0ZojRtBeU3F6hd82UeNWNupaQpEULVqxf2jqzww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALs-HsuTySr0ZojRtBeU3F6hd82UeNWNupaQpEULVqxf2jqzww@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 10:20:04AM -0700, Evan Green wrote:
> On Tue, Aug 29, 2023 at 1:48 AM Andrew Jones <ajones@ventanamicro.com> wrote:
> >
> > Hi Evan,
> >
> > Here's my stab at new wording.
> >
> > On Tue, Jul 11, 2023 at 01:18:30PM -0700, Evan Green wrote:
> > ...
> > > diff --git a/Documentation/riscv/uabi.rst b/Documentation/riscv/uabi.rst
> > > index 8960fac42c40..afdda580e5a2 100644
> > > --- a/Documentation/riscv/uabi.rst
> > > +++ b/Documentation/riscv/uabi.rst
> > > @@ -42,6 +42,16 @@ An example string following the order is::
> > >
> > >     rv64imadc_zifoo_zigoo_zafoo_sbar_scar_zxmbaz_xqux_xrux
> > >
> > > +"isa" vs "hart isa" lines in /proc/cpuinfo
> > > +------------------------------------------
> > > +
> > > +The "isa" line in /proc/cpuinfo describes the lowest common denominator of
> > > +RISC-V ISA extensions understood by the kernel and implemented on all harts. The
> > > +"hart isa" line, in contrast, describes the set of extensions understood by the
> > > +kernel on the particular hart being described, even if those extensions may not
> > > +be present on all harts in the system. The "hart isa" line is consistent with
> > > +what's returned by __riscv_hwprobe() when querying for that specific CPU.
> > > +
> >
> > The "isa" and "hart isa" lines in /proc/cpuinfo list RISC-V ISA extensions
> > which the kernel can identify (the kernel recognizes the extension's name)
> > and have not been filtered out due to effectively not being present.  An
> > extension is effectively not present when it is unusable, either due to
> > defects (which the kernel is aware of), due to missing information which
> > is necessary to complete the extension's description, or due to being
> > explicitly "hidden", such as when a kernel command line parameter
> > instructs the kernel to pretend the extension is not present.  Note, an
> > extension's presence in a list does not imply the kernel is using the
> > extension, nor does it imply that userspace or guest kernels may use the
> > extension (__riscv_hwprobe() should be queried for userspace usability.
> > The hypervisor should be queried, using hypervisor-specific APIs, to
> > check guest kernel usability.)
> >
> > The "isa" line describes the lowest common denominator of extensions,
> > which are the extensions implemented on all harts.  In contrast, the
> > extensions listed in the "hart isa" line need not be implemented by
> > any other hart than the hart corresponding to the line.
> >
> > ---
> >
> > I've specifically dropped the 'The "hart isa" line is consistent with
> > what's returned by __riscv_hwprobe()...' part because I suspect hwprobe
> > could at least lag what gets put in "hart isa", since the kernel may be
> > taught about an extension for a different purpose first, neglecting
> > hwprobe. And, there may be cases that hwprobe never enumerates an
> > extension which the kernel does.
> 
> Thanks for this. My v5 had also dropped the hwprobe part. A few thoughts:
> 
>  * It seems like you want to make sure we call out the fact that the
> kernel may trim out, for various reasons, ISA extensions that the
> hardware does in fact support. This seems reasonable, but I don't
> think we need to enumerate the complete list of "why" this might
> happen, as that list is likely to go stale.

I agree it's better to not [try to] list all the possibilities, assuming
we can come up with good, general words to capture the idea.

>  * The "kernel is using the extension" part is a slightly confusing
> perspective in this context, as it sort of implies the kernel has its
> own agenda :). I'd expect users looking at /proc/cpuinfo are mostly
> trying to figure out what extensions they themselves can use, and the
> kernel's behavior factors in only insofar as it's required to support
> the user in using a feature. Mostly I guess this is a phrasing nit.

We'll have plenty of S-mode extensions listed in these strings. Users
who recognize S-mode extensions may want to know if they're listed because
the kernel is applying them (and wouldn't be listed otherwise), or whether
they're listed simply because they exist on the hart(s).

>  * The bringing up of guest kernels also seems confusing to me in the
> context of /proc/cpuinfo. I'd expect discussions on how host ISA
> extensions filter into guest OSes to be in a hypervisor-specifc
> document, or at least a section dedicated to virtualization.

If there weren't S-mode extensions being listed, then I would agree,
but, since there are, it seems odd to not explain what it means for
them to be there wrt host and guest kernels.

>  * I hesitated in adding prescriptive guidance on what users should
> do, as I think this section will hold up better over time if it just
> describes current characteristics, rather than attempting to prescribe
> behavior. If we want a prescriptive documentation on "use this for
> that", that should probably be its own section

I guess the guidance you're referring to is the "(__riscv_hwprobe() should
be queried for userspace usability.  The hypervisor should be queried,
using hypervisor-specific APIs, to check guest kernel usability.)" bit.
I'm fine with dropping that or moving it to another section, but I think
the more we point out hwprobe, the better. If developers are reading this
/proc/cpuinfo section because they want to detect extensions, then I'd
prefer the section redirects them to hwprobe.

> 
> If I try to fold the gist of what you wrote into v5, I get something
> like this (also with a very slight section heading change). Let me
> know what you think:
> 
> "isa" and "hart isa" lines in /proc/cpuinfo
> ------------------------------------------

need one more _

> 
> The "isa" line in /proc/cpuinfo describes the lowest common denominator of
> RISC-V ISA extensions recognized by the kernel and implemented on all harts. The
> "hart isa" line, in contrast, describes the set of extensions recognized by the
> kernel on the particular hart being described, even if those extensions may not
> be present on all harts in the system.
> 
> In both lines, the presence of an extension guarantees only that the
> hardware has the described capability.
> Additional kernel support or policy changes may be required before an
> extension's capability is fully usable by userspace programs.

or guest kernels in the case of S-mode extensions.

> 
> Inversely, the absence of an extension in these lines does not
> necessarily mean the hardware does not support that feature. The
> running kernel may not recognize the extension, or may have
> deliberately disabled access to it.

I'm not sure about the word "disabled". The kernel can only disable U-mode
extensions and S-mode extensions for guests. S-mode extensions for the
current kernel would have to be disabled by its next higher privilege
level.

How about "...may not recognize the extension, or may have deliberately
removed it from the listing."

(But then readers will wonder why an extension would be deliberately
removed from the listing, which brings us back to trying to come up
with general words to capture the cases I listed. Or, maybe we don't
have to care if they wonder why in this section/document.)

Thanks,
drew

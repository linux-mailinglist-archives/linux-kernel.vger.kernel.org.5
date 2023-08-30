Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0381A78E057
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244809AbjH3TVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344002AbjH3Rzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 13:55:33 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8E8198
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 10:55:29 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-31c65820134so4874076f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 10:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1693418127; x=1694022927; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YmQ2MoNhzEr+YuyoVMHgEFmPqeMcMuiCUmdWY8clz8w=;
        b=YCiq13hH41A6jbxxSrrVLWtdoED84VxLNS4aatc6VpfKrNWXKsR4jqCUBLGIfLH5Fq
         cCOdWyL3u/BS5z/C+F3NFhLCeXtAaRKQpZqgtiv9kQgUH2KqLV4uerMfTuaoVmyYEw0C
         ahUhQk0dcUrB4QOpYYoRpVvKhI3V1n6C4pSO//rqtcRRvf+KlJkCHYGCwuM+kPvsAY2d
         x7pGLczufxQuUtfsnxRqAAwOCBnKf6GwExbuQq6GfIrFIyg8F7ZNo+zUh7zp2W7HXnib
         VTn1CaG+bY2f2lDT+X4NZqTRSrczG0aQjizYoHANxHZ28K9aV/2Blf8Zt9pLgQKM45yE
         u9Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693418127; x=1694022927;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YmQ2MoNhzEr+YuyoVMHgEFmPqeMcMuiCUmdWY8clz8w=;
        b=D9X71XB5+HwKHxqEqXxIbHIRWsVbZIzaNHnQYMhoa8E7oecgL3pWPvgNCnIIbYjWgW
         yh3pBFc5zOSAejsE27X2t9a/H7xqzXy00rYhKGmLbzFsy5GNzWC/8VKIRTGXRtZXqmn0
         F5ME4d/vKpWuWsCU7AdVTsYZ/G3jwP9W/IwtarqwNbxubUH9V0mZGXMeXUSb3gmjKsvT
         bNBJ2opnTbN9ItulQ0PuYlaDacQzbW53jGomzNgJE6OgE7/O90UyoOVAGJPZ0FxdGgyX
         WzPS8SuA1xtJ15Q30cSFC6KwoU1gaeZkWGou8TviH0PCdy9zKp2jH5OAUUxrImrOZ4ni
         Z0cg==
X-Gm-Message-State: AOJu0Yz20OzWguIhbcZTNyIruTHCYFwCQSwdxAsBUFPCnSLySgeQqv8i
        PNgBsYQW59SPI+7Yq5FNtxbteQ==
X-Google-Smtp-Source: AGHT+IFXsFgR+tmPtm38ZlRVYhxslbRFJdsH4JOYvx35ERaaS6F+AyFw/k5jhjXcltzBM4OYBEwI6A==
X-Received: by 2002:adf:dcce:0:b0:315:ad1a:5abc with SMTP id x14-20020adfdcce000000b00315ad1a5abcmr2044751wrm.5.1693418127398;
        Wed, 30 Aug 2023 10:55:27 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id x8-20020a5d60c8000000b0031c52e81490sm17301023wrt.72.2023.08.30.10.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 10:55:26 -0700 (PDT)
Date:   Wed, 30 Aug 2023 19:55:25 +0200
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
Message-ID: <20230830-ae09c1dd0bc8b21f0dcdbc9a@orel>
References: <20230711201831.2695097-1-evan@rivosinc.com>
 <20230829-e445d0bdff78969cc33a6263@orel>
 <CALs-HsuTySr0ZojRtBeU3F6hd82UeNWNupaQpEULVqxf2jqzww@mail.gmail.com>
 <20230830-86f54e19392767c02d8d3146@orel>
 <CALs-HsuCx_UH4oiFEq7arrAjRFtGe7So07ur-pwvafw3a0QyEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALs-HsuCx_UH4oiFEq7arrAjRFtGe7So07ur-pwvafw3a0QyEw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 10:33:04AM -0700, Evan Green wrote:
> On Wed, Aug 30, 2023 at 2:03 AM Andrew Jones <ajones@ventanamicro.com> wrote:
> >
> > On Tue, Aug 29, 2023 at 10:20:04AM -0700, Evan Green wrote:
> > > On Tue, Aug 29, 2023 at 1:48 AM Andrew Jones <ajones@ventanamicro.com> wrote:
> > > >
> > > > Hi Evan,
> > > >
> > > > Here's my stab at new wording.
> > > >
> > > > On Tue, Jul 11, 2023 at 01:18:30PM -0700, Evan Green wrote:
> > > > ...
> > > > > diff --git a/Documentation/riscv/uabi.rst b/Documentation/riscv/uabi.rst
> > > > > index 8960fac42c40..afdda580e5a2 100644
> > > > > --- a/Documentation/riscv/uabi.rst
> > > > > +++ b/Documentation/riscv/uabi.rst
> > > > > @@ -42,6 +42,16 @@ An example string following the order is::
> > > > >
> > > > >     rv64imadc_zifoo_zigoo_zafoo_sbar_scar_zxmbaz_xqux_xrux
> > > > >
> > > > > +"isa" vs "hart isa" lines in /proc/cpuinfo
> > > > > +------------------------------------------
> > > > > +
> > > > > +The "isa" line in /proc/cpuinfo describes the lowest common denominator of
> > > > > +RISC-V ISA extensions understood by the kernel and implemented on all harts. The
> > > > > +"hart isa" line, in contrast, describes the set of extensions understood by the
> > > > > +kernel on the particular hart being described, even if those extensions may not
> > > > > +be present on all harts in the system. The "hart isa" line is consistent with
> > > > > +what's returned by __riscv_hwprobe() when querying for that specific CPU.
> > > > > +
> > > >
> > > > The "isa" and "hart isa" lines in /proc/cpuinfo list RISC-V ISA extensions
> > > > which the kernel can identify (the kernel recognizes the extension's name)
> > > > and have not been filtered out due to effectively not being present.  An
> > > > extension is effectively not present when it is unusable, either due to
> > > > defects (which the kernel is aware of), due to missing information which
> > > > is necessary to complete the extension's description, or due to being
> > > > explicitly "hidden", such as when a kernel command line parameter
> > > > instructs the kernel to pretend the extension is not present.  Note, an
> > > > extension's presence in a list does not imply the kernel is using the
> > > > extension, nor does it imply that userspace or guest kernels may use the
> > > > extension (__riscv_hwprobe() should be queried for userspace usability.
> > > > The hypervisor should be queried, using hypervisor-specific APIs, to
> > > > check guest kernel usability.)
> > > >
> > > > The "isa" line describes the lowest common denominator of extensions,
> > > > which are the extensions implemented on all harts.  In contrast, the
> > > > extensions listed in the "hart isa" line need not be implemented by
> > > > any other hart than the hart corresponding to the line.
> > > >
> > > > ---
> > > >
> > > > I've specifically dropped the 'The "hart isa" line is consistent with
> > > > what's returned by __riscv_hwprobe()...' part because I suspect hwprobe
> > > > could at least lag what gets put in "hart isa", since the kernel may be
> > > > taught about an extension for a different purpose first, neglecting
> > > > hwprobe. And, there may be cases that hwprobe never enumerates an
> > > > extension which the kernel does.
> > >
> > > Thanks for this. My v5 had also dropped the hwprobe part. A few thoughts:
> > >
> > >  * It seems like you want to make sure we call out the fact that the
> > > kernel may trim out, for various reasons, ISA extensions that the
> > > hardware does in fact support. This seems reasonable, but I don't
> > > think we need to enumerate the complete list of "why" this might
> > > happen, as that list is likely to go stale.
> >
> > I agree it's better to not [try to] list all the possibilities, assuming
> > we can come up with good, general words to capture the idea.
> >
> > >  * The "kernel is using the extension" part is a slightly confusing
> > > perspective in this context, as it sort of implies the kernel has its
> > > own agenda :). I'd expect users looking at /proc/cpuinfo are mostly
> > > trying to figure out what extensions they themselves can use, and the
> > > kernel's behavior factors in only insofar as it's required to support
> > > the user in using a feature. Mostly I guess this is a phrasing nit.
> >
> > We'll have plenty of S-mode extensions listed in these strings. Users
> > who recognize S-mode extensions may want to know if they're listed because
> > the kernel is applying them (and wouldn't be listed otherwise), or whether
> > they're listed simply because they exist on the hart(s).
> 
> I see. You're right I was thinking only about U-mode extensions.
> 
> >
> > >  * The bringing up of guest kernels also seems confusing to me in the
> > > context of /proc/cpuinfo. I'd expect discussions on how host ISA
> > > extensions filter into guest OSes to be in a hypervisor-specifc
> > > document, or at least a section dedicated to virtualization.
> >
> > If there weren't S-mode extensions being listed, then I would agree,
> > but, since there are, it seems odd to not explain what it means for
> > them to be there wrt host and guest kernels.
> 
> I'm not a virtualization guy, but my impression was people didn't have
> expectations that everything they saw in cpuinfo would be wholesale
> presented to guest VMs. There's always that layer of hypervisor
> configuration that may strip out some features. So I'm still not super
> convinced guest VMs need a carveout/caveat here, but let me see if I
> can fold it in.
> 
> >
> > >  * I hesitated in adding prescriptive guidance on what users should
> > > do, as I think this section will hold up better over time if it just
> > > describes current characteristics, rather than attempting to prescribe
> > > behavior. If we want a prescriptive documentation on "use this for
> > > that", that should probably be its own section
> >
> > I guess the guidance you're referring to is the "(__riscv_hwprobe() should
> > be queried for userspace usability.  The hypervisor should be queried,
> > using hypervisor-specific APIs, to check guest kernel usability.)" bit.
> > I'm fine with dropping that or moving it to another section, but I think
> > the more we point out hwprobe, the better. If developers are reading this
> > /proc/cpuinfo section because they want to detect extensions, then I'd
> > prefer the section redirects them to hwprobe.
> 
> Fair enough. I still haven't brought myself to wedge in an ad for
> hwprobe, but I also don't disagree with this :)
> 
> >
> > >
> > > If I try to fold the gist of what you wrote into v5, I get something
> > > like this (also with a very slight section heading change). Let me
> > > know what you think:
> > >
> > > "isa" and "hart isa" lines in /proc/cpuinfo
> > > ------------------------------------------
> >
> > need one more _
> >
> > >
> > > The "isa" line in /proc/cpuinfo describes the lowest common denominator of
> > > RISC-V ISA extensions recognized by the kernel and implemented on all harts. The
> > > "hart isa" line, in contrast, describes the set of extensions recognized by the
> > > kernel on the particular hart being described, even if those extensions may not
> > > be present on all harts in the system.
> > >
> > > In both lines, the presence of an extension guarantees only that the
> > > hardware has the described capability.
> > > Additional kernel support or policy changes may be required before an
> > > extension's capability is fully usable by userspace programs.
> >
> > or guest kernels in the case of S-mode extensions.
> >
> > >
> > > Inversely, the absence of an extension in these lines does not
> > > necessarily mean the hardware does not support that feature. The
> > > running kernel may not recognize the extension, or may have
> > > deliberately disabled access to it.
> >
> > I'm not sure about the word "disabled". The kernel can only disable U-mode
> > extensions and S-mode extensions for guests. S-mode extensions for the
> > current kernel would have to be disabled by its next higher privilege
> > level.
> >
> > How about "...may not recognize the extension, or may have deliberately
> > removed it from the listing."
> 
> Perfect.
> 
> >
> > (But then readers will wonder why an extension would be deliberately
> > removed from the listing, which brings us back to trying to come up
> > with general words to capture the cases I listed. Or, maybe we don't
> > have to care if they wonder why in this section/document.)
> 
> I know, I felt the same pull to explain why as well. But I think given
> that our goal with this section is mostly to make the distinction of
> "presence != active", explaining exactly why the kernel may remove it
> is not strictly necessary. All of my attempts to tack something on end
> up being enumerated lists, which don't come out well and muddle the
> message.
> 
> Here's another shot (line endings may be wonky):
> 
> "isa" and "hart isa" lines in /proc/cpuinfo
> -------------------------------------------
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
> Similarly, for S-mode extensions, presence in one of these lines does
> not guarantee that the kernel is taking advantage of the extension, or
> that the feature will be visible in guest VMs managed by this kernel.
> 
> Inversely, the absence of an extension in these lines does not
> necessarily mean the hardware does not support that feature. The
> running kernel may not recognize the extension, or may have
> deliberately removed it from the listing.

Looks good to me!

Thanks,
drew

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449B679B4AF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344978AbjIKVPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244275AbjIKTu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 15:50:57 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9A71A5;
        Mon, 11 Sep 2023 12:50:52 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id DCB0E1F88C;
        Mon, 11 Sep 2023 19:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1694461850; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9x8HAEIwtXLqml/7oNF1Uow6kl0Fypm9g4pU0Qbt6A0=;
        b=LdsQIu6zmCI7TDQ6QofFPK2xiRxUbXOSjnePiglgpn0kDlJ/c+3YVnx52rOXOE63yaC9T+
        DiWiAA0uqBjZfryxMLu9AbbcH+kevsdihj4n965KfTifOWw+GEO4wQph2TVFkfHeKtWS5b
        R7V3VlIm8zv2EngyVws3GoVwxQ4gUgc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1694461850;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9x8HAEIwtXLqml/7oNF1Uow6kl0Fypm9g4pU0Qbt6A0=;
        b=C4OffT5Eet3xv0n0rdQHo9TxEusmpxWcZGiKixobHAxVA6YT7HeI+iwCzgRMhvOw506fKl
        sG19g3QXZRSYi2Bw==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id F18812C142;
        Mon, 11 Sep 2023 19:50:49 +0000 (UTC)
Date:   Mon, 11 Sep 2023 21:50:48 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-modules@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Jiri Slaby <jslaby@suse.com>, Jan Engelhardt <jengelh@inai.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH kmod v5 0/5] kmod /usr support
Message-ID: <20230911195048.GK8826@kitsune.suse.cz>
References: <cover.1689589902.git.msuchanek@suse.de>
 <cover.1689681454.git.msuchanek@suse.de>
 <20230817163744.GD8826@kitsune.suse.cz>
 <CAK7LNAQy79ZHS0d000XQzC-trRPhOUBFnWsGm03yG0cQAs-rXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNAQy79ZHS0d000XQzC-trRPhOUBFnWsGm03yG0cQAs-rXA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 19, 2023 at 08:25:52PM +0900, Masahiro Yamada wrote:
> On Fri, Aug 18, 2023 at 12:15 PM Michal Suchánek <msuchanek@suse.de> wrote:
> >
> > Hello,
> >
> > On Tue, Jul 18, 2023 at 02:01:51PM +0200, Michal Suchanek wrote:
> > > Hello,
> > >
> > > with these patches it is possible to install kernel modules in an arbitrary
> > > directory - eg. moving the /lib/modules to /usr/lib/modules or /opt/linux.
> > >
> > > While the modprobe.d and depmod.d search which already includes multiple
> > > paths is expanded to also include $(prefix) the module directory still
> > > supports only one location, only a different one under $(module_directory).
> > >
> > > Having kmod search multiple module locations while only one is supported now
> > > might break some assumption about relative module path corresponding to a
> > > specific file, would require more invasive changes to implement, and is not
> > > supportive of the goal of moving the modules away from /lib.
> > >
> > > Both kmod and the kernel need to be patched to make use of this feature.
> > > Patched kernel is backwards compatible with older kmod.  Patched kmod
> > > with $(module_directory) set to /lib/modules is equivalent to unpatched kmod.
> >
> > The patch to kernel to support autodetection of module directory is
> > rejected. However, a workaround like
> >
> > make MODLIB='$(INSTALL_MOD_PATH)/usr/lib/modules/$(KERNELRELEASE)'
> >
> > is suggested.
> >
> > Can you consider inluding the kmod changes?
> 
> 
> Hi.
> 
> I have a question about your original patch
> for the Kbuild change.
> 
> In your patch, Kbuild runs 'kmod config' or
> 'pkg-config --variable=module_directory kmod',
> then sets the returned string to MODLIB.
> 
> 
> If kmod is configured to use /usr/lib/modules,
> /opt/modules, or whatever,
> should we change the installation path of the debug
> vdso accordingly?
> 
> Currently, the debug vdso is always installed
> to /lib/modules/$(KERNELRELEASE)/vdso/.
> 
> However, modules and vdso are unrelated to each other.
> kmod does not care about vdso.
> 
> 
> The following commits started to install debug vdso.
> 
> Commit 8150caad0226 ("[POWERPC] powerpc vDSO: install unstripped
> copies on disk")
> Commit f79eb83b3af4 ("x86: Install unstripped copy of 64bit vdso to disk")
> 
> 
> I do not know why they chose $(MODLIB)/vdso as the install destination.
> 
> 
> I am thinking of split the variable into two:
> MODLIB -  installation path for modules
> VDSOLIB - installation path for debug vdso (not affected by kmod config)
> 
> I think that is the way to do this correctly.

The source and build symlinks that point at the kernel tree are not
modules either yet they are in the module directory as well.

Thanks

Michal

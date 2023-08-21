Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD087823AA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 08:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233465AbjHUGXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 02:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233412AbjHUGXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 02:23:00 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2F2D3;
        Sun, 20 Aug 2023 23:22:56 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1DFD222574;
        Mon, 21 Aug 2023 06:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692598975; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/YrpeDEETVnHXfTqeVfb9lfB9FXNdbEh0fq+0q4dbLg=;
        b=st6FSY+YuQ+hI2sNx3kAg2syieeUC0UtQnFLXt/TIE8qVfh+q8h9AqExo5OYrwyeLn+F2o
        YRT+dQWhMvI1t9EQrdgnffJyJ9eVI8BfzCnjyZD/LmycbDh1kMFtqEfrbRYp/MVUdABDjV
        zb5oNGS+aauCrUBck1YYX3px0eSfvTs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692598975;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/YrpeDEETVnHXfTqeVfb9lfB9FXNdbEh0fq+0q4dbLg=;
        b=ye3OaHAF9I6Wl5zZ+8FuQTBwsSvYFJHdG2jgx+6WgNjOv+KJqnNpPIQmToCYC6aFUi2gcZ
        p2wZKRHyRZtunJAw==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2BED02C143;
        Mon, 21 Aug 2023 06:22:54 +0000 (UTC)
Date:   Mon, 21 Aug 2023 08:22:52 +0200
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
Message-ID: <20230821062252.GF8826@kitsune.suse.cz>
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

It's the only directory that exists per-kernel-release.

While technically vdso has nothing to do with modules there is no other
place where it can be stored where it would not conflict between kernel
releases so far.

In fact the distro followed the pattern and started dumping other things
not related to kernel modules into $(MODLIB) for this very reason. Also
from the distribution point of view $(MODLIB) is listed as owned by the
kernel package, and additional files that might be there sometimes need
not be specially handled.

Finally any tools that can find vdso today will search for it in
$(MODLIB), and consequently moving it elsewhere is not practical.

If the makefiles grow a VDSOLIB it should default to MODLIB. It may be
useful for somebody to have this flexibility in the future but I am not
interested for my use case.

Thanks

Michal

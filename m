Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9932D80BD47
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 22:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbjLJVI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 16:08:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbjLJVI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 16:08:57 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0635E9;
        Sun, 10 Dec 2023 13:09:03 -0800 (PST)
Received: from kitsune.suse.cz (unknown [10.100.12.127])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 41F661F8A4;
        Sun, 10 Dec 2023 21:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1702242542; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V4ltyg2yJt/1ZOBAunN1bErd5ePpqdQr2H7j8y7SktI=;
        b=RUhWaSqDzWQWFvZeKeOUAd7GOFqlt4eKcYo1cbQuqJCBb5KM5OVsXycBjVAXsFluhUMtAt
        PBcsvxKF2x3YErkeFGjr3Y2pQGTV4bH6F6Jy0/jK2vPX3nvbOvQE9z41jjykvxo8240bSQ
        XnyvJy1/R6ke85z2BSiakBNxNk/racU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1702242542;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V4ltyg2yJt/1ZOBAunN1bErd5ePpqdQr2H7j8y7SktI=;
        b=j+buDAjyRGVAZoSVQmj+N8q6GT0eS+/3XNX7ZmiQkctwthA7QTCz1sM+amh33VRA4YctWK
        L4CYx92emBQTRwBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1702242540; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V4ltyg2yJt/1ZOBAunN1bErd5ePpqdQr2H7j8y7SktI=;
        b=s9yiXYR2m3qxQObIZf/QMsRdCclnam7Fy2jQZb5tYwTxfuOwbaBmPQ5ppJzHTmDKScBCpc
        z2IlET4yPCUGohPrSuvUSR42ZdGHog3MjF8vwUX1kri6FxJjTpsynb3PqCnOlBbRnAaU8h
        sl77qTui8PKP6Ddj9Vh1ShqGYy77JkU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1702242540;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V4ltyg2yJt/1ZOBAunN1bErd5ePpqdQr2H7j8y7SktI=;
        b=xWBkh2TSWg65+l+NmXF/GbrOig+bC7+q1L20sKhdeTZzEzxINMMuYM6l2Gdjv715PzIHSW
        FoS+EpsRbX/eMrDw==
Date:   Sun, 10 Dec 2023 22:08:59 +0100
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
Subject: Re: [PATCH v6 2/2] kbuild: rpm-pkg: Fix build with non-default MODLIB
Message-ID: <20231210210859.GN9696@kitsune.suse.cz>
References: <CAK7LNAT3N82cJD3GsF+yUBEfPNOBkhzYPk37q3k0HdU7ukz9vQ@mail.gmail.com>
 <baa3224bece94220dfe7173432143a91f7612c09.1701892062.git.msuchanek@suse.de>
 <CAK7LNARdnt0QXn6TRbuS_wzzMVXTY6NrCnu9WOM6PFztnyRmuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNARdnt0QXn6TRbuS_wzzMVXTY6NrCnu9WOM6PFztnyRmuQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Level: 
X-Spam-Score: -2.72
X-Spamd-Result: default: False [-2.72 / 50.00];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         NEURAL_HAM_LONG(-1.00)[-0.998];
         DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-0.12)[-0.587];
         RCPT_COUNT_TWELVE(0.00)[12];
         DBL_BLOCKED_OPENRESOLVER(0.00)[system.map:url,suse.de:email];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         FREEMAIL_CC(0.00)[vger.kernel.org,suse.com,gmail.com,inai.de,kernel.org,google.com,fjasle.eu];
         BAYES_HAM(-3.00)[100.00%];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.72
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 03:44:35AM +0900, Masahiro Yamada wrote:
> On Thu, Dec 7, 2023 at 4:48 AM Michal Suchanek <msuchanek@suse.de> wrote:
> >
> > The default MODLIB value is composed of three variables
> >
> > MODLIB = $(INSTALL_MOD_PATH)$(KERNEL_MODULE_DIRECTORY)/$(KERNELRELEASE)
> >
> > However, the kernel.spec hadcodes the default value of
> > $(KERNEL_MODULE_DIRECTORY), and changed value is not reflected when
> > building the package.
> >
> > Pass KERNEL_MODULE_DIRECTORY to kernel.spec to fix this problem.
> >
> > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > ---
> > Build on top of the previous patch adding KERNEL_MODULE_DIRECTORY
> 
> 
> The SRPM package created by 'make srcrpm-pkg' may not work
> if rpmbuild is executed in a different machine.

That's why there is an option to override KERNEL_MODULE_DIRECTORY?

Thanks

Michal

> 
> 
> 
> %{make} %{makeflags} INSTALL_MOD_PATH=%{buildroot}
> KERNEL_MODULE_DIRECTORY=%{KERNEL_MODULE_DIRECTORY} modules_install
> 
> 
> will align with the specified install destination,
> but depmod will still fail.
> (same issue as 1/2)
> 
> 
> 
> 
> 
> 
> 
> 
> 
> > ---
> >  scripts/package/kernel.spec | 8 ++++----
> >  scripts/package/mkspec      | 1 +
> >  2 files changed, 5 insertions(+), 4 deletions(-)
> >
> > diff --git a/scripts/package/kernel.spec b/scripts/package/kernel.spec
> > index 3eee0143e0c5..12996ed365f8 100644
> > --- a/scripts/package/kernel.spec
> > +++ b/scripts/package/kernel.spec
> > @@ -67,7 +67,7 @@ cp $(%{make} %{makeflags} -s image_name) %{buildroot}/boot/vmlinuz-%{KERNELRELEA
> >  %{make} %{makeflags} INSTALL_HDR_PATH=%{buildroot}/usr headers_install
> >  cp System.map %{buildroot}/boot/System.map-%{KERNELRELEASE}
> >  cp .config %{buildroot}/boot/config-%{KERNELRELEASE}
> > -ln -fns /usr/src/kernels/%{KERNELRELEASE} %{buildroot}/lib/modules/%{KERNELRELEASE}/build
> > +ln -fns /usr/src/kernels/%{KERNELRELEASE} %{buildroot}%{KERNEL_MODULE_DIRECTORY}/%{KERNELRELEASE}/build
> >  %if %{with_devel}
> >  %{make} %{makeflags} run-command KBUILD_RUN_COMMAND='${srctree}/scripts/package/install-extmod-build %{buildroot}/usr/src/kernels/%{KERNELRELEASE}'
> >  %endif
> > @@ -98,8 +98,8 @@ fi
> >
> >  %files
> >  %defattr (-, root, root)
> > -/lib/modules/%{KERNELRELEASE}
> > -%exclude /lib/modules/%{KERNELRELEASE}/build
> > +%{KERNEL_MODULE_DIRECTORY}/%{KERNELRELEASE}
> > +%exclude %{KERNEL_MODULE_DIRECTORY}/%{KERNELRELEASE}/build
> >  /boot/*
> >
> >  %files headers
> > @@ -110,5 +110,5 @@ fi
> >  %files devel
> >  %defattr (-, root, root)
> >  /usr/src/kernels/%{KERNELRELEASE}
> > -/lib/modules/%{KERNELRELEASE}/build
> > +%{KERNEL_MODULE_DIRECTORY}/%{KERNELRELEASE}/build
> >  %endif
> > diff --git a/scripts/package/mkspec b/scripts/package/mkspec
> > index ce201bfa8377..e952fa4f2937 100755
> > --- a/scripts/package/mkspec
> > +++ b/scripts/package/mkspec
> > @@ -24,6 +24,7 @@ fi
> >  cat<<EOF
> >  %define ARCH ${ARCH}
> >  %define KERNELRELEASE ${KERNELRELEASE}
> > +%define KERNEL_MODULE_DIRECTORY ${KERNEL_MODULE_DIRECTORY}
> >  %define pkg_release $("${srctree}/init/build-version")
> >  EOF
> >
> > --
> > 2.42.0
> >
> >
> 
> 
> --
> Best Regards
> Masahiro Yamada

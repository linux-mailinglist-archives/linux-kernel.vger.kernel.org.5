Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE8F80BD44
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 22:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbjLJVHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 16:07:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjLJVHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 16:07:45 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2141E9;
        Sun, 10 Dec 2023 13:07:51 -0800 (PST)
Received: from kitsune.suse.cz (unknown [10.100.12.127])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 647581F8AB;
        Sun, 10 Dec 2023 21:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1702242469; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0GXX7fyzwGRqzBW8lszpIez3y7hw+F2xzAdIfxzSWHk=;
        b=WzQGylcghSjxyRvA7kTKmVr6D7O0XygNbJtpTC9DQXrN/EU0GUly3kEyi2UDFDX+d1uOdu
        LlQUiP+gx39FrOSG/TVALllqUy3xJURqqXttIdjbNmrIv7Rs3Bod+kfjk5AHDgoyVhdMzD
        KzrgbZeoWPk4opF/c3svMckoGyCfVsY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1702242469;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0GXX7fyzwGRqzBW8lszpIez3y7hw+F2xzAdIfxzSWHk=;
        b=qZ2PWsxoDvAI5/CLEjExhp0VZE1Ob8xFkqYgAZ8tMN7IwoXauYpeJbuZjB+5cmJSnRT02k
        1l2ACRjUNsxSHUAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1702242469; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0GXX7fyzwGRqzBW8lszpIez3y7hw+F2xzAdIfxzSWHk=;
        b=WzQGylcghSjxyRvA7kTKmVr6D7O0XygNbJtpTC9DQXrN/EU0GUly3kEyi2UDFDX+d1uOdu
        LlQUiP+gx39FrOSG/TVALllqUy3xJURqqXttIdjbNmrIv7Rs3Bod+kfjk5AHDgoyVhdMzD
        KzrgbZeoWPk4opF/c3svMckoGyCfVsY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1702242469;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0GXX7fyzwGRqzBW8lszpIez3y7hw+F2xzAdIfxzSWHk=;
        b=qZ2PWsxoDvAI5/CLEjExhp0VZE1Ob8xFkqYgAZ8tMN7IwoXauYpeJbuZjB+5cmJSnRT02k
        1l2ACRjUNsxSHUAg==
Date:   Sun, 10 Dec 2023 22:07:48 +0100
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
Subject: Re: [PATCH v6 1/2] depmod: Handle installing modules under a
 different directory
Message-ID: <20231210210748.GM9696@kitsune.suse.cz>
References: <CAK7LNAT3N82cJD3GsF+yUBEfPNOBkhzYPk37q3k0HdU7ukz9vQ@mail.gmail.com>
 <32b332af189bfca8acdb231cee294355aa4af290.1701892062.git.msuchanek@suse.de>
 <CAK7LNATPF7baHLXZVgzz=6zOhLx8maX0r0EU3DBFwAEZ6kCeww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNATPF7baHLXZVgzz=6zOhLx8maX0r0EU3DBFwAEZ6kCeww@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Level: 
X-Spam-Score: 0.20
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: 0.20
X-Spamd-Result: default: False [0.20 / 50.00];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-0.20)[-1.000];
         RCPT_COUNT_TWELVE(0.00)[12];
         DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         FREEMAIL_CC(0.00)[vger.kernel.org,suse.com,gmail.com,inai.de,kernel.org,google.com,fjasle.eu];
         BAYES_HAM(-0.00)[20.47%];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Mon, Dec 11, 2023 at 03:43:44AM +0900, Masahiro Yamada wrote:
> On Thu, Dec 7, 2023 at 4:48 AM Michal Suchanek <msuchanek@suse.de> wrote:
> >
> > Some distributions aim at shipping all files in /usr.
> >
> > The path under which kernel modules are installed is hardcoded to /lib
> > which conflicts with this goal.
> >
> > When kmod provides kmod.pc, use it to determine the correct module
> > installation path.
> >
> > With kmod that does not provide the config /lib/modules is used as
> > before.
> >
> > While pkg-config does not return an error when a variable does not exist
> > the kmod configure script puts some effort into ensuring that
> > module_directory is non-empty. With that empty module_directory from
> > pkg-config can be used to detect absence of the variable.
> >
> > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > ---
> > v6:
> >  - use ?= instead of := to make it easier to override the value
> 
> 
> "KERNEL_MODULE_DIRECTORY=/local/usr/lib/modules make modules_install"
> will override the install destination, but
> depmod will not be not aware of it.

At the same time if you know what you are doing you can build a src rpm
for another system that uses a different location.

> How to avoid the depmod error?

Not override the variable?

Thanks

Michal

> >  - use shorter expression for determining the module directory assuming
> >    it's non-empty
> > ---
> >  Makefile | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/Makefile b/Makefile
> > index 511b5616aa41..84f32bd563d4 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1081,7 +1081,9 @@ export INSTALL_DTBS_PATH ?= $(INSTALL_PATH)/dtbs/$(KERNELRELEASE)
> >  # makefile but the argument can be passed to make if needed.
> >  #
> >
> > -MODLIB = $(INSTALL_MOD_PATH)/lib/modules/$(KERNELRELEASE)
> > +export KERNEL_MODULE_DIRECTORY ?= $(or $(shell pkg-config --variable=module_directory kmod 2>/dev/null),/lib/modules)
> > +
> > +MODLIB = $(INSTALL_MOD_PATH)$(KERNEL_MODULE_DIRECTORY)/$(KERNELRELEASE)
> >  export MODLIB
> >
> >  PHONY += prepare0
> > --
> > 2.42.0
> >
> >
> 
> 
> --
> Best Regards
> Masahiro Yamada

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09C880ECBC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 14:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376510AbjLLNDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 08:03:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbjLLNDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 08:03:21 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135C795;
        Tue, 12 Dec 2023 05:03:27 -0800 (PST)
Received: from kitsune.suse.cz (unknown [10.100.12.127])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 872181FD14;
        Tue, 12 Dec 2023 13:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1702386205; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xVXdFzvQktyLQVIaWnR4yUGDApS7kfx3XEGvF1V5fLE=;
        b=TvRCbxCStGI5SbuUc0ZDH03srM9Hbq7fjrvtcMNI2TC9KfAxrGfyK7p00Y/4IZPxXVdgnp
        NPsfXheED+Ze9n+ErxShl1qRxxfOwtf+3eRUIDbjdbDyP6DNlHD0HIx2whHjY7QqQn4UF3
        lIYLSlzvwSPl5fG0N7UgpvWD71+FQv4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1702386205;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xVXdFzvQktyLQVIaWnR4yUGDApS7kfx3XEGvF1V5fLE=;
        b=Y4ppXHF3MfijWBsq8ZAZGig+3uj7vJDPgJwfmzcav60cb1jtGypRuOUR4opT3bSuiIqZ+Y
        PxnY89hV8RBSH7Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1702386205; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xVXdFzvQktyLQVIaWnR4yUGDApS7kfx3XEGvF1V5fLE=;
        b=TvRCbxCStGI5SbuUc0ZDH03srM9Hbq7fjrvtcMNI2TC9KfAxrGfyK7p00Y/4IZPxXVdgnp
        NPsfXheED+Ze9n+ErxShl1qRxxfOwtf+3eRUIDbjdbDyP6DNlHD0HIx2whHjY7QqQn4UF3
        lIYLSlzvwSPl5fG0N7UgpvWD71+FQv4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1702386205;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xVXdFzvQktyLQVIaWnR4yUGDApS7kfx3XEGvF1V5fLE=;
        b=Y4ppXHF3MfijWBsq8ZAZGig+3uj7vJDPgJwfmzcav60cb1jtGypRuOUR4opT3bSuiIqZ+Y
        PxnY89hV8RBSH7Cw==
Date:   Tue, 12 Dec 2023 14:03:24 +0100
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
Message-ID: <20231212130324.GP9696@kitsune.suse.cz>
References: <CAK7LNAT3N82cJD3GsF+yUBEfPNOBkhzYPk37q3k0HdU7ukz9vQ@mail.gmail.com>
 <32b332af189bfca8acdb231cee294355aa4af290.1701892062.git.msuchanek@suse.de>
 <CAK7LNATPF7baHLXZVgzz=6zOhLx8maX0r0EU3DBFwAEZ6kCeww@mail.gmail.com>
 <20231210210748.GM9696@kitsune.suse.cz>
 <CAK7LNAQQe-fdeKe2RHd5TyYpXa95WJO_-f38o12oewGC3rFTHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNAQQe-fdeKe2RHd5TyYpXa95WJO_-f38o12oewGC3rFTHA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Level: 
X-Spam-Score: -1.60
X-Spam-Level: 
X-Spam-Flag: NO
Authentication-Results: smtp-out2.suse.de;
        none
X-Spamd-Result: default: False [-1.60 / 50.00];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         RCPT_COUNT_TWELVE(0.00)[12];
         DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         FREEMAIL_CC(0.00)[vger.kernel.org,suse.com,gmail.com,inai.de,kernel.org,google.com,fjasle.eu];
         BAYES_HAM(-3.00)[100.00%];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: -1.60
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 01:29:15PM +0900, Masahiro Yamada wrote:
> On Mon, Dec 11, 2023 at 6:07 AM Michal Suchánek <msuchanek@suse.de> wrote:
> >
> > Hello!
> >
> > On Mon, Dec 11, 2023 at 03:43:44AM +0900, Masahiro Yamada wrote:
> > > On Thu, Dec 7, 2023 at 4:48 AM Michal Suchanek <msuchanek@suse.de> wrote:
> > > >
> > > > Some distributions aim at shipping all files in /usr.
> > > >
> > > > The path under which kernel modules are installed is hardcoded to /lib
> > > > which conflicts with this goal.
> > > >
> > > > When kmod provides kmod.pc, use it to determine the correct module
> > > > installation path.
> > > >
> > > > With kmod that does not provide the config /lib/modules is used as
> > > > before.
> > > >
> > > > While pkg-config does not return an error when a variable does not exist
> > > > the kmod configure script puts some effort into ensuring that
> > > > module_directory is non-empty. With that empty module_directory from
> > > > pkg-config can be used to detect absence of the variable.
> > > >
> > > > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > > > ---
> > > > v6:
> > > >  - use ?= instead of := to make it easier to override the value
> > >
> > >
> > > "KERNEL_MODULE_DIRECTORY=/local/usr/lib/modules make modules_install"
> > > will override the install destination, but
> > > depmod will not be not aware of it.
> >
> > At the same time if you know what you are doing you can build a src rpm
> > for another system that uses a different location.
> >
> > > How to avoid the depmod error?
> >
> > Not override the variable?
> 
> You are not answering my question.
> You intentionally changed := to ?=.
> 
> This implies that KERNEL_MODULE_DIRECTORY is an interface to users,
> and should be documented in Documentation/kbuild/kbuild.rst

That's reasonable

> However, it never works if it is overridden from the env variable
> or make command line because there is no way to let depmod know
> the fact that KERNEL_MODULE_DIRECTORY has been overridden.

And there should not. kmod is not aware, kbuild is. That's the
direction of information flow. kmod defines where it looks for the
modules, and kbuild shoukld install the modules there.

If the user knows better (eg. possibility of building src-rpm for a
different you brought up) they can override the autodetection.

> In my understanding, depmod does not provide an option to
> specify the module directory from a command line option, does it?

No it does not.

> If not, is it reasonable to add a new option to depmod?

I don't think so. The module directory is intentionally in a fixed
location. It can be set at compile time, and that's it.

Then when running depmod on the target distribution either kbuild and
kmod agree on the location or the build fails. That's the intended
outcome.

kmod recently grew the ability to use modules outside of module
directory. For that to work internally the path to these out-of-kernel
modules is stored as absolute path, and the path of modules that are in
the module directory is stored relative to the module directory.

Setting the module directory location dynamically still should not break
this but I am not sure it's a great idea. In the end modprobe needs to
find those modules, and if depmod puts the modules.dep in arbitrary
location it will not.

> depmod provides the "-b basedir" option, but it only allows
> adding a prefix to the default "/lib/modules/<version>".

Yes, that's for installation into a staging directory, and there again
the modules that are inside the module directory are considedred
'in-kernel'. Not sure how well this even works with 'out-of-kernel'
modules.

> (My original idea to provide the prefix_part, it would have worked
> like  -b "${INSTALL_MOD_PATH}${MOD_PREFIX}", which you refused)

It's not clear that adding a prefix covers all use cases. It is an
arbitrary limitation that the module path must end with '/lib/modules'.

It may allow taking some shortcuts in some places but is unnecessarily
limiting.

Thanks

Michal

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5A376FE48
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 12:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjHDKRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 06:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbjHDKRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 06:17:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F0649E6;
        Fri,  4 Aug 2023 03:17:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3787F61F8B;
        Fri,  4 Aug 2023 10:17:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10E4FC433C7;
        Fri,  4 Aug 2023 10:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691144233;
        bh=zNBDN7gMxcdP3rzmzlXceNr1RBqj0mH0rrNSb8z1r4Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hGjPvl06N5vqehlQBtNtTo1rEv1/w06C3pAbv/j7SfpWsoygQHEDMp1XYkebaQ52V
         Y76yp0awGlqFUowiW4xa8hzxAX+3mxlJrgp4GwlJ0P/a4SCrziog7TJ4Z7UaXy4472
         8hxWpFLEKdJLKerZ32ZrOKBPg50pJkFm8uQ2B/rg=
Date:   Fri, 4 Aug 2023 12:17:10 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        workflows@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: changes.rst: add entry for git
Message-ID: <2023080447-ahead-tannery-c77a@gregkh>
References: <20230803090711.2261876-1-linux@rasmusvillemoes.dk>
 <2023080302-theology-custody-670b@gregkh>
 <CAK7LNARPTwmnTO-saaGo4nnc7HXK44qQihRK+EqovK=qFT8zPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNARPTwmnTO-saaGo4nnc7HXK44qQihRK+EqovK=qFT8zPg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 06:41:54PM +0900, Masahiro Yamada wrote:
> On Thu, Aug 3, 2023 at 7:19 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Aug 03, 2023 at 11:07:10AM +0200, Rasmus Villemoes wrote:
> > > git is obviously used for development, directly and also
> > > indirectly (via checkpatch, get_maintainer and other helper
> > > scripts). But it is also invoked during the build to produce the
> > > `uname -r` string.
> > >
> > > It's useful to have some minimal git version one can expect people to
> > > use. For now, set a somewhat conservative minimum of 1.8.0, which is
> > > already more then ten years old.
> > >
> > > Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > > ---
> > >  Documentation/process/changes.rst | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
> > > index 5561dae94f85..a82c619f4bb2 100644
> > > --- a/Documentation/process/changes.rst
> > > +++ b/Documentation/process/changes.rst
> > > @@ -62,6 +62,7 @@ Sphinx\ [#f1]_         1.7              sphinx-build --version
> > >  cpio                   any              cpio --version
> > >  GNU tar                1.28             tar --version
> > >  gtags (optional)       6.6.5            gtags --version
> > > +git                    1.8.0            git --version
> > >  ====================== ===============  ========================================
> > >
> > >  .. [#f1] Sphinx is needed only to build the Kernel documentation
> > > @@ -189,6 +190,13 @@ The kernel build requires GNU GLOBAL version 6.6.5 or later to generate
> > >  tag files through ``make gtags``.  This is due to its use of the gtags
> > >  ``-C (--directory)`` flag.
> > >
> > > +git
> > > +---
> > > +
> > > +When building with CONFIG_LOCALVERSION_AUTO=y, the build system uses
> > > +git to produce a version string of the form
> > > +6.4.6-00128-gd78b7f406397, which will be shown e.g. by running `uname -r`.
> >
> > Isn't this optional?  If git is not installed it just will not use git
> > to determine the local version.
> 
> Right.
> Without git, the suffix "-00128-gd78b7f406397" is not
> appended, but you can build the kernel.
> 
> 
> >
> > So you should put "(optional)" above on the list of tools.
> >
> > And also, don't pick a specific version like this unless it is that way
> > for a reason.  Why not pick a newer one?  Or the last one that the local
> > version script can handle properly?
> 
> 
> 
> CentOS 7 (plans to retire in 2024) unfortunately
> uses a ten-year-old git version.
> 
> In CentOS 7,
> 
> $ git --version
> git version 1.8.3.1

I doubt CentOS 7 can build a modern-day kernel anyway, so why is this a
requirement?  We shouldn't be beholden to the necro-distros just because
they have not moved into this decade :)

> If we are allowed to abandon conservative distros,
> I prefer git >= 2.14.0
> 
> That supports 'git status --no-optional-locks'

That makes sense, and is a valid reason to require this.

thanks,

greg k-h

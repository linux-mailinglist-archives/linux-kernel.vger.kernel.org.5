Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF957AF563
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 22:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235901AbjIZUjt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 26 Sep 2023 16:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235883AbjIZUjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 16:39:48 -0400
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5935120
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 13:39:40 -0700 (PDT)
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay05.hostedemail.com (Postfix) with ESMTP id 9143C40255;
        Tue, 26 Sep 2023 20:39:39 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf19.hostedemail.com (Postfix) with ESMTPA id D3A7D2002C;
        Tue, 26 Sep 2023 20:39:35 +0000 (UTC)
Message-ID: <402f586ec556f557921c552dcea2831c4d65dc7a.camel@perches.com>
Subject: Re: [PATCH v2] checkpatch: warn about multi-line comments without
 an empty /* line
From:   Joe Perches <joe@perches.com>
To:     Petr =?UTF-8?Q?Tesa=C5=99=C3=ADk?= <petr@tesarici.cz>
Cc:     Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Date:   Tue, 26 Sep 2023 13:39:34 -0700
In-Reply-To: <20230926221521.08f4a64d@meshulam.tesarici.cz>
References: <20230926192400.19366-1-petr@tesarici.cz>
         <1adcfeaa4bd01d59a349daa697cc007e81bc81b1.camel@perches.com>
         <20230926221521.08f4a64d@meshulam.tesarici.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: D3A7D2002C
X-Stat-Signature: gk53iqr1inpupnxb31sr353ptr7a6tga
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Rspamd-Server: rspamout01
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+w3lR6jXNhSr1RMLbUx4/VZPl1kLjVaOM=
X-HE-Tag: 1695760775-621787
X-HE-Meta: U2FsdGVkX19FYfNQghojYESizAiDToro/2+IH9ZnfXpFGVk1qk45nPn8L06QE40wDyU2aliag3c/9cV0jQMAUCrZevxUcht6WkPgRjqdLNbK63OjlaEru3uQdUCvuYm5496mopaJMHW8mkI5mql5YT5l8FZ2QogQSXGTXTjl7bOPpoQdGtoxHAMWAgvvFbFLEWj57wgXD0KOyIe+83zrFcv0f7KcFR6uix/TZVFIUrTb3BHmJZyDVMDUPCCLUNIEGpmF33cetyZcQ0RYKPCxukxrHGMHP5bAXhqb/ViX/V5bTRiwzEceOHYlHGsezsBcThfgeh4MFvL3HheTkTvgkQx8KrN7F2U0K8lyF7aIQK8L+P/IdHpzELX5uG7PSzrNm2ayRmZVoIooRhRKd4XSGuxFCyhJCwFuy2ue/VMepcJUoBOS1qsxhdbdINUXJ75Dy6XvifDyLYfh9DYyZjviAf1oog6Qjl+XNomDKD5kANkcat1U2Isw0A==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-09-26 at 22:16 +0200, Petr Tesařík wrote:
> On Tue, 26 Sep 2023 12:56:33 -0700
> Joe Perches <joe@perches.com> wrote:
> 
> > On Tue, 2023-09-26 at 21:24 +0200, Petr Tesarik wrote:
> > > According to Documentation/process/coding-style.rst, the preferred style
> > > for multi-line comments outside net/ and drivers/net/ is:
> > > 
> > > .. code-block:: c
> > > 
> > >         /*
> > >          * This is the preferred style for multi-line
> > >          * comments in the Linux kernel source code.
> > >          * Please use it consistently.
> > >          *
> > >          * Description:  A column of asterisks on the left side,
> > >          * with beginning and ending almost-blank lines.
> > >          */
> > > 
> > > Signed-off-by: Petr Tesarik <petr@tesarici.cz>  
> > []
> > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl  
> > []
> > > @@ -4006,6 +4006,14 @@ sub process {
> > >  			     "networking block comments don't use an empty /* line, use /* Comment...\n" . $hereprev);
> > >  		}
> > >  
> > > +# Non-networking without an initial /*
> > > +		if ($realfile !~ m@^(drivers/net/|net/)@ &&
> > > +		    $prevrawline =~ /^\+[ \t]*\/\*.*[^ \t]$/ &&
> > > +		    $rawline =~ /^\+[ \t]*\*/) {
> > > +			WARN("BLOCK_COMMENT_STYLE",
> > > +			     "multi-line block comments should start with an empty /* line\n" . $hereprev);
> > > +		}
> > > +
> > >  # Block comments use * on subsequent lines
> > >  		if ($prevline =~ /$;[ \t]*$/ &&			#ends in comment
> > >  		    $prevrawline =~ /^\+.*?\/\*/ &&		#starting /*  
> > 
> > Still nack.  Too many existing instances.
> > 
> > $ git grep '/\*.*' -- '*.[ch]' | \
> >   grep -v '/\*.*\*/' | \
> >   grep -v -P "/\*\s*$" | \
> >   grep -v '/\*\*' | \
> >   grep -v "SPDX-License" | \
> >   grep -v -P '^drivers/net|^net/' | \
> >   wc -l
> > 51834
> 
> Um. Not everything that is currently found in the source tree would be
> accepted as new code by today's standards...
> 
> As it stands, the script checks the special case for net/ and
> drivers/net/ but does not help prevent unnecessary respins, like this
> one:
> 
> https://lore.kernel.org/linux-iommu/ZRMgObTMkfq8Bjbe@arm.com/
> 
> OTOH if we don't want to warn about multi-line comments, maybe we don't
> want to call it the preferred style, and the corresponding paragraph
> should be removed from coding-style.rst. Do you suggest I try that
> instead?

If you really want to bring it up as a coding style issue
go ahead, but consider that the link above is a 'nitpick'
and not an actual issue.

If you _really_ want, but I am not at all sure it's useful,
I suggest you change the message to a CHK so that it is only
emitted with --strict and not a WARN and only emit anything
when the thing being scanned is a patch and _not_ a file.

Something like:

# Non-networking without an initial /*
		if (!$file &&
		    $realfile !~ m@^(?:drivers/net/|net/)@ &&
		    $prevrawline =~ /^\+[ \t]*\/\*.*[^ \t]$/ &&
		    $rawline =~ /^\+[ \t]*\*/) {
			CHK("BLOCK_COMMENT_STYLE",
			    "multi-line block comments should start with an empty /* line\n" . $hereprev);

But you still want to examine some of the false positives
this would create like:

/* ------------------------
 * block message
 * ------------------------ */

and

struct foo {
	int a;  /* some desriptor */
	int b;	/* some descriptor
		   on multiple lines */
};


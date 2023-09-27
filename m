Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9AE47AFAF7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 08:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjI0GVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 02:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjI0GUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 02:20:46 -0400
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8231982
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 23:20:03 -0700 (PDT)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bee.tesarici.cz (Postfix) with ESMTPSA id C068F183146;
        Wed, 27 Sep 2023 08:20:00 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
        t=1695795600; bh=VXOLDgrjE//bKAwXR5UHYe1arN35YLrbw8ZC5YE0+AY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VudmlmjejNhW76DI85HdTdQXc8aRUFWXvuJ0p62jFtnIHKD2JvM9UlR4mmJXFsnwV
         wVN/uS4qSc8m9bEPpHYtSnQYT9qfF3HF2nXcW9aatwMUuEApfErQLqII8u5XFdG4dW
         jxTypVunRJ+fqbeyPApPnpPXnb4g8TDdrIPtiKNteBqt7jVsuYgMFalSMZ6P3R+l8j
         fEYfaOAbxKpxzkf9mMrqRYkaNd5YEnPe8lN5DDPCPDLoZCUGwdOXhVD9xxIwxHPmyb
         ZyB6fQeWClqo7HMUmN5rETxOXmVdFlxI0ZqOaYUPa0bspQ4BU57v9IB4ZLQwcDAYBF
         PMBU63xqLlSug==
Date:   Wed, 27 Sep 2023 08:19:59 +0200
From:   Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To:     Joe Perches <joe@perches.com>
Cc:     Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v2] checkpatch: warn about multi-line comments without
 an empty /* line
Message-ID: <20230927081959.210166e9@meshulam.tesarici.cz>
In-Reply-To: <402f586ec556f557921c552dcea2831c4d65dc7a.camel@perches.com>
References: <20230926192400.19366-1-petr@tesarici.cz>
        <1adcfeaa4bd01d59a349daa697cc007e81bc81b1.camel@perches.com>
        <20230926221521.08f4a64d@meshulam.tesarici.cz>
        <402f586ec556f557921c552dcea2831c4d65dc7a.camel@perches.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

On Tue, 26 Sep 2023 13:39:34 -0700
Joe Perches <joe@perches.com> wrote:

> On Tue, 2023-09-26 at 22:16 +0200, Petr Tesa=C5=99=C3=ADk wrote:
> > On Tue, 26 Sep 2023 12:56:33 -0700
> > Joe Perches <joe@perches.com> wrote:
> >  =20
> > > On Tue, 2023-09-26 at 21:24 +0200, Petr Tesarik wrote: =20
> > > > According to Documentation/process/coding-style.rst, the preferred =
style
> > > > for multi-line comments outside net/ and drivers/net/ is:
> > > >=20
> > > > .. code-block:: c
> > > >=20
> > > >         /*
> > > >          * This is the preferred style for multi-line
> > > >          * comments in the Linux kernel source code.
> > > >          * Please use it consistently.
> > > >          *
> > > >          * Description:  A column of asterisks on the left side,
> > > >          * with beginning and ending almost-blank lines.
> > > >          */
> > > >=20
> > > > Signed-off-by: Petr Tesarik <petr@tesarici.cz>   =20
> > > [] =20
> > > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl   =20
> > > [] =20
> > > > @@ -4006,6 +4006,14 @@ sub process {
> > > >  			     "networking block comments don't use an empty /* line, use=
 /* Comment...\n" . $hereprev);
> > > >  		}
> > > > =20
> > > > +# Non-networking without an initial /*
> > > > +		if ($realfile !~ m@^(drivers/net/|net/)@ &&
> > > > +		    $prevrawline =3D~ /^\+[ \t]*\/\*.*[^ \t]$/ &&
> > > > +		    $rawline =3D~ /^\+[ \t]*\*/) {
> > > > +			WARN("BLOCK_COMMENT_STYLE",
> > > > +			     "multi-line block comments should start with an empty /* l=
ine\n" . $hereprev);
> > > > +		}
> > > > +
> > > >  # Block comments use * on subsequent lines
> > > >  		if ($prevline =3D~ /$;[ \t]*$/ &&			#ends in comment
> > > >  		    $prevrawline =3D~ /^\+.*?\/\*/ &&		#starting /*   =20
> > >=20
> > > Still nack.  Too many existing instances.
> > >=20
> > > $ git grep '/\*.*' -- '*.[ch]' | \
> > >   grep -v '/\*.*\*/' | \
> > >   grep -v -P "/\*\s*$" | \
> > >   grep -v '/\*\*' | \
> > >   grep -v "SPDX-License" | \
> > >   grep -v -P '^drivers/net|^net/' | \
> > >   wc -l
> > > 51834 =20
> >=20
> > Um. Not everything that is currently found in the source tree would be
> > accepted as new code by today's standards...
> >=20
> > As it stands, the script checks the special case for net/ and
> > drivers/net/ but does not help prevent unnecessary respins, like this
> > one:
> >=20
> > https://lore.kernel.org/linux-iommu/ZRMgObTMkfq8Bjbe@arm.com/
> >=20
> > OTOH if we don't want to warn about multi-line comments, maybe we don't
> > want to call it the preferred style, and the corresponding paragraph
> > should be removed from coding-style.rst. Do you suggest I try that
> > instead? =20
>=20
> If you really want to bring it up as a coding style issue
> go ahead, but consider that the link above is a 'nitpick'
> and not an actual issue.

I don't want to start a flamewar. In fact, I'm quite relaxed about
coding style, so I'm not the right person to propose changes. However,
if enough people believe that most instances found by your grep command
are perfectly valid style, then the text in coding-style.rst does not
match reality...

> If you _really_ want, but I am not at all sure it's useful,
> I suggest you change the message to a CHK so that it is only
> emitted with --strict and not a WARN and only emit anything
> when the thing being scanned is a patch and _not_ a file.

OK, I'm trying to understand what it means when the script WARNs about
something. IIUC these are just warnings about _possible_ coding style
violations; authors and maintainers can choose to ignore them (although
I know some maintainers are more strict than others on this matter).

And then there is existing code. On the one hand, I get a warning when
for BUG_ON(), although there are many existing BUG_ON() instances:

$ git grep -w BUG_ON | wc -l
7561

Yet, there is a check for BUG_ON(). I get a warning even when I merely
modify the argument of a BUG_ON(), e.g. as a result of renaming a struct
member. This makes me believe that warnings from checkpatch.pl are not
meant to be enforced.

On the other hand, you (the maintainer) are not sure if it's useful to
add a warning about block comment style, where the official guidelines
has explicitly asked authors to "use it consistently" since 2006 when
Randy Dunlap wrote commit b3fc9941fbc6e ("CodingStyle updates").

> Something like:
>=20
> # Non-networking without an initial /*
> 		if (!$file &&
> 		    $realfile !~ m@^(?:drivers/net/|net/)@ &&
> 		    $prevrawline =3D~ /^\+[ \t]*\/\*.*[^ \t]$/ &&
> 		    $rawline =3D~ /^\+[ \t]*\*/) {
> 			CHK("BLOCK_COMMENT_STYLE",
> 			    "multi-line block comments should start with an empty /* line\n" .=
 $hereprev);
>=20
> But you still want to examine some of the false positives
> this would create like:
>=20
> /* ------------------------
>  * block message
>  * ------------------------ */

OK, I can see this style is often used to mark larger sections.

> and
>=20
> struct foo {
> 	int a;  /* some desriptor */
> 	int b;	/* some descriptor
> 		   on multiple lines */

AFAICS this would not trigger a warning in my proposed code, because
the first line of the comment is preceded by non-white-space characters.

I have also seen a lot of instances at the very beginning of a file.
What about skipping the check if a block comment is followed by an empty
line? I was also thinking about minus signs, but I'm not sure if the
following instance is considered perfectly acceptable:

	/* -- Watchdog Timeout --
	 * Bit 0-6 (Reserved)
	 * Bit 7   WDT Time-out Value Units Select
	 *	   (0 =3D Minutes, 1 =3D Seconds)
	 */
	outb(timeout_unit, sch311x_wdt_data.runtime_reg + WDT_TIME_OUT);

(found in drivers/watchdog/sch311x_wdt.c)

All I want to achieve is that the check script somehow helps me keep a
consistent style both in network code and non-network code. It's
difficult for me as a human to keep paying attention to all these
little details and subtle differences among maintainers, but at least
some people do care about them. An automated check might help
productivity IMO.

Petr T

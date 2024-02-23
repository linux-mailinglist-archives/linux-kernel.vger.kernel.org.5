Return-Path: <linux-kernel+bounces-78324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A766A8611EB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C0A2B26A15
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54D17E773;
	Fri, 23 Feb 2024 12:48:09 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3B77E0E8;
	Fri, 23 Feb 2024 12:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708692489; cv=none; b=c4FSyG4TaVGVbQSPl2V0vyZDWxOIPWz1Grr6seFp1uf4d64iQgpYfPlfDi6ptLAQflT5l4cSu16q8zSR9LAkWC0DF9MgDjEAupvirz35zkxbrAIReA3l510QPelC5B5CIpxC8KCjpnxUtAU7DpLyfUXRh4Oa1gKa9pxCIhUUQ0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708692489; c=relaxed/simple;
	bh=LAjfPoz2drXqfQvAjv9IzHKfA5IrdcSZOOkt/CeiU1c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M5KopDuGYo9gsf6WYOyfcm8c6/qmDQlJcRzVt4szi1DJ7ls+a9ytdiGaeyDl0ofqlWbtKxZYlaeSk+nN5T3Ivj5brckjPjmRNSdjynEUbn2AG4u2sPlqZhQ/91pGNWIgjmWKdirzozW077EW5WtdY3WuoNXvbhQY1kn51CrJq6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 2073BA1164;
	Fri, 23 Feb 2024 12:48:00 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf02.hostedemail.com (Postfix) with ESMTPA id 682A78000E;
	Fri, 23 Feb 2024 12:47:57 +0000 (UTC)
Message-ID: <bc22e93196284ddece102929ae9f6636358e6716.camel@perches.com>
Subject: Re: [PATCH v2] checkpatch: add check for snprintf to scnprintf
From: Joe Perches <joe@perches.com>
To: Lee Jones <lee@kernel.org>
Cc: Justin Stitt <justinstitt@google.com>, Andy Whitcroft
 <apw@canonical.com>,  Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas
 Bulwahn <lukas.bulwahn@gmail.com>,  linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>, Finn
 Thain <fthain@linux-m68k.org>
Date: Fri, 23 Feb 2024 04:47:56 -0800
In-Reply-To: <20240223103845.GP10170@google.com>
References: <20240221-snprintf-checkpatch-v2-1-9baeb59dae30@google.com>
	 <bccc704fc78b362bbc57a79eb240219f5ec1548e.camel@perches.com>
	 <20240223103845.GP10170@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 682A78000E
X-Rspamd-Server: rspamout08
X-Stat-Signature: ukf9z8exot3f8st6ets4czmu8p6frtk4
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/0INiopDmML8A145GUuo/QwEloV8aKws4=
X-HE-Tag: 1708692477-39706
X-HE-Meta: U2FsdGVkX1/UFjuIy6XDV0zdZU7pS54VpS1HyjtO8u/qVXIGPoXkdNloAv9Sw8rpIUAPYfmxbMgHsnXqz8ZXNUggPoGrMTDkMdjsuMYWEHsMBtLG+GZ+K0dEpAG+22xU1nj+tBk6LPV2pmIMpu6VcwvdSN5oBJGgkUsZbi3K8YncxD+mFqec84H8gFg73naopm5Ka34RzGP0P3M8ftqmMYFcSENvpigT1xsbb6144nhzfETCpQep1i53OKAf09EE3oRn7IF4I5FVorDTY4lpSSH5zAu+ApCymd3jDS8UkgtNx8/nNclHejShy0COFHeS75DYc+/UUZLFEms+GtiIM9Kef3betaQiXQfvaeMuQHyiEmbqKsw54ghsnU6uDBRyngX909KJKOnXPr0ZezUvEIk96GdPiZl6pP0rV0g7PWb9qkAf6J2VyX97st7Bmklws/FWmwXIWOn48xySR1ZDw9x5qStU9/1Rug+6mB1uBZs=

On Fri, 2024-02-23 at 10:38 +0000, Lee Jones wrote:
> On Wed, 21 Feb 2024, Joe Perches wrote:
>=20
> > On Wed, 2024-02-21 at 22:11 +0000, Justin Stitt wrote:
> > > I am going to quote Lee Jones who has been doing some snprintf ->
> > > scnprintf refactorings:
> > >=20
> > > "There is a general misunderstanding amongst engineers that
> > > {v}snprintf() returns the length of the data *actually* encoded into =
the
> > > destination array.  However, as per the C99 standard {v}snprintf()
> > > really returns the length of the data that *would have been* written =
if
> > > there were enough space for it.  This misunderstanding has led to
> > > buffer-overruns in the past.  It's generally considered safer to use =
the
> > > {v}scnprintf() variants in their place (or even sprintf() in simple
> > > cases).  So let's do that."
> > >=20
> > > To help prevent new instances of snprintf() from popping up, let's ad=
d a
> > > check to checkpatch.pl.
> > >=20
> > > Suggested-by: Finn Thain <fthain@linux-m68k.org>
> > > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > > ---
> > > Changes in v2:
> > > - Had a vim moment and deleted a character before sending the patch.
> > > - Replaced the character :)
> > > - Link to v1: https://lore.kernel.org/r/20240221-snprintf-checkpatch-=
v1-1-3ac5025b5961@google.com
> > > ---
> > > From a discussion here [1].
> > >=20
> > > [1]: https://lore.kernel.org/all/0f9c95f9-2c14-eee6-7faf-635880edcea4=
@linux-m68k.org/
> >=20
> > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > []
> > > @@ -7012,6 +7012,12 @@ sub process {
> > >  			     "Prefer strscpy, strscpy_pad, or __nonstring over strncpy - =
see: https://github.com/KSPP/linux/issues/90\n" . $herecurr);
> > >  		}
> > > =20
> > > +# snprintf uses that should likely be {v}scnprintf
> > > +		if ($line =3D~ /\bsnprintf\s*\(\s*/) {
> > > +				WARN("SNPRINTF",
> > > +				     "Prefer scnprintf over snprintf\n" . $herecurr);
> >=20
> > There really should be some sort of reference link here
> > similar to the one above this.
> >=20
> > Also, I rather doubt _all_ of these should be changed just
> > for churn's sake.
>=20
> This is for new implementations only.
>=20
> Kees is planning on changing all of the current instances kernel-wide.

I saw that.  I also saw pushback.
Not just my own.

Creating a cocci script is easy.
Getting Linus and others to run it isn't.



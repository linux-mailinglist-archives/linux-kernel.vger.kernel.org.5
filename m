Return-Path: <linux-kernel+bounces-161960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5188B53C7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36EBD283448
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E4C3717D;
	Mon, 29 Apr 2024 09:04:33 +0000 (UTC)
Received: from gardel.0pointer.net (gardel.0pointer.net [85.214.157.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA562C68F;
	Mon, 29 Apr 2024 09:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.157.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714381473; cv=none; b=EGJvccZyVr3HFu/sYUou0j4b6uWRiXehUCxxFRyhDRBc5mNl5bv+J7NJneybf1RcQIDDGM/n2kV+nqznTeaBvQgIFJPuGaESVyzY4WzjEpGNTlBeV9mZUXvUVCEIaW4f/AY8/iC+e5NglJTCqXQmvZq3dG7wgVLAUZcMiP+Nhcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714381473; c=relaxed/simple;
	bh=H9ZBiwkmJv4MZD4a/1cw2hcXmMAF0/Sg7nByLKv3/h8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XhP8+1ftttm48kyKbGLACY+yajZ24jE2FJTppVTvArl0DmcZtMkqxW4ASFNsmZQZ0wyxC/GUfMCHcyH4wG45PHHx48zFo+yq7l26EuT9nMGDZ/XomrZm3tnu2+HrbIwP+WuXFr1RbqoUlvu34OzvpFSbbuHJnE+HnKKCfhuEpzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0pointer.de; spf=pass smtp.mailfrom=0pointer.de; arc=none smtp.client-ip=85.214.157.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0pointer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0pointer.de
Received: from gardel-login.0pointer.net (gardel-mail [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
	by gardel.0pointer.net (Postfix) with ESMTP id ECCD1E80F27;
	Mon, 29 Apr 2024 11:04:21 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
	id 852A81600A1; Mon, 29 Apr 2024 11:04:21 +0200 (CEST)
Date: Mon, 29 Apr 2024 11:04:21 +0200
From: Lennart Poettering <mzxreary@0pointer.de>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Alexander Graf <graf@amazon.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Babis Chalios <bchalios@amazon.es>, Theodore Ts'o <tytso@mit.edu>,
	"Cali, Marco" <xmarcalx@amazon.co.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	Christian Brauner <brauner@kernel.org>, linux@leemhuis.info,
	regressions@lists.linux.dev
Subject: Re: [REGRESSION] Re: [PATCH] Revert "vmgenid: emit uevent when
 VMGENID updates"
Message-ID: <Zi9ilaX3254KL3Pp@gardel-login>
References: <20240418114814.24601-1-Jason@zx2c4.com>
 <e09ce9fd-14cb-47aa-a22d-d295e466fbb4@amazon.com>
 <CAHmME9qKFraYWmzD9zKCd4oaMg6FyQGP5pL9bzZP4QuqV1O_Qw@mail.gmail.com>
 <ZieoRxn-On0gD-H2@gardel-login>
 <b819717c-74ea-4556-8577-ccd90e9199e9@amazon.com>
 <Ziujox51oPzZmwzA@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ziujox51oPzZmwzA@zx2c4.com>

On Fr, 26.04.24 14:52, Jason A. Donenfeld (Jason@zx2c4.com) wrote:

> I don't think adding UAPI to an individual device driver like this

Does vmgenid really qualify as "an individual device driver"? It's a
pretty generic software interface, implemented by various different
VMMs these days. It is also the only interface I am aware of that
actually exists and would provide the concept right now?

if this was really hyperv specific, then I'd agree it's just an
"individual device driver". But it's widely implemented, for example a
trivial command line switch in qemu.

Hence, for something this generic, and widely deployed with multiple
backend implementations I think we can say it's kinda more of a
subsystem and less of an individual driver, no?

> is a good approach especially considering that the virtio changes we
> discussed some time ago will likely augment this and create another
> means of a similar notification. And given that this intersects with
> other userspace-oriented work I hope to get back to pretty soon, I
> think introducing some adhoc mechanism like this adds clutter and
> isn't the ideal way forward.

If one day a virtio-based equivalent shows up, then I'd be entirely
fine with supporting this in userspace directly too , because virtio
too is a generic thing typically implemented by multiple VMM
backends. From my userspace perspective I see little benefit in the
kernel abstracting over vmgenid and virtio-genid (if that ever
materializes), as a systemd person I am not asking for this kind of
abstraction (in case anyone wonders). A generic ACPI device such as
vmgenid is entirely enough of "generic" for me.

The way we would process the event in userspace in systemd (from a
udev rule) is so generic that it's trivial to match against two
generic interfaces, instead of just one.

And even if there's value in a generic abstraction provided by the
kernel over both vmgenid and a future virtio-based thing: the kernel
patch in question was a *single* line, and our hookup in userspace
could easily be moved over when the day comes, because it's really not
a rocket science level interface. It's a single parameterless event,
how much easier could things get?

I understand that how this all happened wasn't to everyones wishes,
but do we really have to make all of this so complex if it could just
be so simple? Why delay this further, why go back again given the
event, the interface itself is such an utter triviality? Do we really
make such a threatre around a single line change, a single additional
uevent, just because of politics?

Lennart

--
Lennart Poettering, Berlin


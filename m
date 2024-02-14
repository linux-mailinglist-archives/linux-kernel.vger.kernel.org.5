Return-Path: <linux-kernel+bounces-65889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0841D85535D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 20:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B11B1C216F9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46FC13B7B1;
	Wed, 14 Feb 2024 19:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="PI0VbA7I"
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA07D128368;
	Wed, 14 Feb 2024 19:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.93.223.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707939781; cv=none; b=EzQPxC75DaUmQKgaNBJEn7CFDosh2zE3RcwA5+fEK27JRgrYzqG0uV6N7Snp53voIxpHECSTy3EYI+tpHDhNwJywmStY1xEsWSx7tLsJ/2MAynhxVjac2RavKRWaFPYcyVjtnfwOlKEqrLUY/kTNY1E0KVQVyWDyDcjoU9iQfe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707939781; c=relaxed/simple;
	bh=MjzHW3sbvo74UMtDvhMeOjKB1wFsSsg2w0qr4l02BqM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LUDgwcmxWVaSNqIqOeWZ+OXJCmDOz5sgzADTM5loEISs7iKXR56dlXK6b7UL9ILkwqEKzZmTx95VPLTb89IojzxZe+40sBMkrChZJs65zjHE5gAhT5w9Qm59vXQmq3f1KfHWZmUuxscIhRn3MO+nenGKUyVa0K2II9SAUl3RvPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=PI0VbA7I; arc=none smtp.client-ip=77.93.223.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 604D21A3F85;
	Wed, 14 Feb 2024 20:42:55 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1707939775; bh=XbApCY7HYVbip/7kfqTJAZF1W0XGldnt6/Vj0L00k7w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PI0VbA7Imm50dQMfP324uH6fTp44EaM6tpjkV8GA938hByxVe5M0cJ9rBwKqLdF5y
	 C+7e207+PkelEuEkVv3i4+HGF2OI9j4NSGCCnLSX26XODMg6DwA1Ny4Gqh7FrJbi0R
	 clF7x6GlzMS6M6K+HbcKlG9UG4kQFxJZJBc0/Ap8hlrDLQYEOmm13TSf7VpF2F6jVt
	 KYPkdJEVogk8gRrxd17XdhUeliOnOWXD83eXjYbewxju6/yaCaxl7T/C+5xwCll4wv
	 bSd+6GnHaj8ajGwbPTZeJRptgYOHkCUg1VZrlOm1qfkGQax0qJFPEf8GyT/q1LkczW
	 CyhSZaiqIeKnw==
Date: Wed, 14 Feb 2024 20:42:54 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Petr Tesarik
 <petrtesarik@huaweicloud.com>, Jonathan Corbet <corbet@lwn.net>, David
 Kaplan <david.kaplan@amd.com>, Larry Dewey <larry.dewey@amd.com>, Elena
 Reshetova <elena.reshetova@intel.com>, Carlos Bilbao
 <carlos.bilbao@amd.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>, Petr Mladek <pmladek@suse.com>, "Paul
 E. McKenney" <paulmck@kernel.org>, Eric DeVolder
 <eric.devolder@oracle.com>, Marc =?UTF-8?B?QXVyw6hsZQ==?= La France
 <tsi@tuyoix.net>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, Nhat Pham
 <nphamcs@gmail.com>, "Christian Brauner (Microsoft)" <brauner@kernel.org>,
 Douglas Anderson <dianders@chromium.org>, Luis Chamberlain
 <mcgrof@kernel.org>, Guenter Roeck <groeck@chromium.org>, Mike Christie
 <michael.christie@oracle.com>, Kent Overstreet <kent.overstreet@linux.dev>,
 Maninder Singh <maninder1.s@samsung.com>, "open list:DOCUMENTATION"
 <linux-doc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 Roberto Sassu <roberto.sassu@huaweicloud.com>, Petr Tesarik
 <petr.tesarik1@huawei-partners.com>
Subject: Re: [PATCH v1 5/5] sbm: SandBox Mode documentation
Message-ID: <20240214204254.6208ca2f@meshulam.tesarici.cz>
In-Reply-To: <2024021417-magma-drudge-ad70@gregkh>
References: <20240214113035.2117-1-petrtesarik@huaweicloud.com>
	<20240214113035.2117-6-petrtesarik@huaweicloud.com>
	<20240214053053.982b48d993ae99dad1d59020@linux-foundation.org>
	<2024021425-audition-expand-2901@gregkh>
	<20240214155524.719ffb15@meshulam.tesarici.cz>
	<2024021415-jokester-cackle-2923@gregkh>
	<20240214173112.138e0e29@meshulam.tesarici.cz>
	<2024021417-magma-drudge-ad70@gregkh>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 14 Feb 2024 19:48:52 +0100
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Wed, Feb 14, 2024 at 05:31:12PM +0100, Petr Tesa=C5=99=C3=ADk wrote:
> > On Wed, 14 Feb 2024 16:11:05 +0100
> > Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> >  =20
> > > On Wed, Feb 14, 2024 at 03:55:24PM +0100, Petr Tesa=C5=99=C3=ADk wrot=
e: =20
> > > > OK, so why didn't I send the whole thing?
> > > >=20
> > > > Decomposition of the kernel requires many more changes, e.g. in lin=
ker
> > > > scripts. Some of them depend on this patch series. Before I go and
> > > > clean up my code into something that can be submitted, I want to get
> > > > feedback from guys like you, to know if the whole idea would be even
> > > > considered, aka "Fail Fast".   =20
> > >=20
> > > We can't honestly consider this portion without seeing how it would
> > > work, as we don't even see a working implementation that uses it to
> > > verify it at all.
> > >=20
> > > The joy of adding new frameworks is that you need a user before anyone
> > > can spend the time to review it, sorry. =20
> >=20
> > Thank your for a quick assessment. Will it be sufficient if I send some
> > code for illustration (with some quick&dirty hacks to bridge the gaps),
> > or do you need clean and nice kernel code? =20
>=20
> We need a real user in the kernel, otherwise why would we even consider
> it?  Would you want to review a new subsystem that does nothing and has
> no real users?  If not, why would you want us to?  :)

Greg, please enlighten me on the process. How is something like this
supposed to get in?

Subsystem maintainers will not review code that depends on core features
not yet reviewed by the respective maintainers. If I add only the API
and a stub implementation, then it brings no benefit and attempts to
introduce the API will be dismissed. I would certainly do just that if
I was a maintainer...

I could try to pack everything (base infrastructure, arch
implementations, API users) into one big patch with pretty much
everybody on the Cc list, but how is that ever going to get reviewed?

Should I just go and maintain an out-of-tree repo for a few years,
hoping that it gets merged one day, like bcachefs? Is this the way?

Petr T


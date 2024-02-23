Return-Path: <linux-kernel+bounces-79006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D286861C26
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9964EB2406E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494CA84FBB;
	Fri, 23 Feb 2024 18:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="rzQC+UUs"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE00142645;
	Fri, 23 Feb 2024 18:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708714243; cv=none; b=uMB2OW16FlCTbzolU4RqWeBEU+I59v8zSjEuDB10N7d6pA2Wj5F7kpKJpHBgaBnblLN6NFxC0z86Rfx5TKFbzoQdcu2TG6lxPnyMtzTWO8OulKuO8Uvlw5EV4jrrjHwCuAKV2D4aQ1pXr0554+VxU+hezn6sYE2Rey//H+onXoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708714243; c=relaxed/simple;
	bh=DhL+o3TBv9wTdewu3RZDH83BAQtweFRzwwjac4VyAmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ptjRk73cQdlnjfmzMtpBnAlHusR1fAy6RcLRZkBrsoLrdpVXsxgT32kPYqWxaIT6Z5DvzfaDBPja21Dx38Z0PHSXTk0gkBMBAeT7IaGAawZnP+9Zf/k/FSM19jGk4IrbB/qSCRj871lZJVGEUe+a7atw3UcClQ55V9XmhQ5J7/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=rzQC+UUs; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id D19971C0081; Fri, 23 Feb 2024 19:50:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1708714236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N5THRV7c4OguqZqtxRyAd4aFwhAeBHnTNbl2Gj2YB8I=;
	b=rzQC+UUsFYyriraM5TQkTbiALnJrX/ttY9RMMeRia5fd/0YPxmstJoPqHuzpCzMq0nn4JG
	+jtXtMON8C6dPIb9W53Qp5ujdt3dvfI5WOqwOHCbMWA4UZqmSHiqToNBUkxjVHHZiSakkt
	LW8x54za/0EZbqjE+SMKhpXYbUVXf40=
Date: Fri, 23 Feb 2024 19:50:36 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	kernel list <linux-kernel@vger.kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	Oleksandr Natalenko <oleksandr@natalenko.name>,
	Jiri Benc <jbenc@redhat.com>, Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: stable-kernel-rules was Re: fs/bcachefs/
Message-ID: <Zdjo/D8dZ/gJ4vz4@duo.ucw.cz>
References: <g6el7eghhdk2v5osukhobvi4pige5bsfu5koqtmoyeknat36t7@irmmk7zo7edh>
 <uknxc26o6td7g6rawxffvsez46djmvcy2532kza2zyjuj33k7p@4jdywourgtqg>
 <2024022103-municipal-filter-fb3f@gregkh>
 <4900587.31r3eYUQgx@natalenko.name>
 <2024022155-reformat-scorer-98ae@gregkh>
 <aaf2f030-b6f4-437b-bb4e-79aa4891ae56@suse.cz>
 <ZdeeKiTXc7WidRcs@duo.ucw.cz>
 <bhqwmyfmd3a5mgsdbfom6hz2cvhf75felzf2bu3aiusr6f3ael@6qo7buimzot2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+wZgcwm10bI8HAca"
Content-Disposition: inline
In-Reply-To: <bhqwmyfmd3a5mgsdbfom6hz2cvhf75felzf2bu3aiusr6f3ael@6qo7buimzot2>


--+wZgcwm10bI8HAca
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > There seems to be just one rule being observed: "It or an equivalent
> > fix must already exist in Linus' tree (upstream).". Every other rule is
> > broken pretty much all the time.
> >=20
> > AUTOSEL is a problem.
> >=20
> > Plus there's problem with dependencies -- if a patch A is need for fix
> > B, the rules pretty much go out of the window, huge patches are
> > applied, whitespace fixes are applied, etc.
> >=20
> > There are even known-bad patches being applied, and then
> > reverted. Greg explained that it heps his process somehow.
>=20
> This seems to be a pretty consistent theme theme - thins are done baesd
> on whatever makes Greg's process easier, not input from the people
> stable ought to be working with. Pretty questionable set of priorities
> if you ask me.

Well, I'd not mind stable process following the documented rules.

But fixing the documentation to match the reality would also be an
improvement, because some people actually read it and expect it to be
followed.

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--+wZgcwm10bI8HAca
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZdjo/AAKCRAw5/Bqldv6
8hT1AKCNAauh3IxGbhZqKnYZ40ZpkG3lCQCfY8dSbOtuGWBuqkhzTC2wX47Wptw=
=5ekV
-----END PGP SIGNATURE-----

--+wZgcwm10bI8HAca--


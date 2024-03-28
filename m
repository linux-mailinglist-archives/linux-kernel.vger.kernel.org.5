Return-Path: <linux-kernel+bounces-122768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02EA788FCF4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30F261C2F0FA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0351B7BB1C;
	Thu, 28 Mar 2024 10:25:34 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD987D080;
	Thu, 28 Mar 2024 10:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711621533; cv=none; b=lcg0c9k9yu7cBLC2mgKdkGzgGhVh1B6CFhLT77mUveGURadIwL/jvKQ9W7lVBypFFuK536YCVtVVN86fMZH+vS7w4Ah53jQ4FQsZ2A+TPo8zHHilM/Fos/uJHO2J550wQCuMnazaTOS7iYYD4HhlRawQGRMsHBDzYOMDe/u8ImE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711621533; c=relaxed/simple;
	bh=A/lOwqEy3arJTpWQhOi6ni6ni0jKTDQHCogOxMQolk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pjjWmI4FEyNezAxqaJ2ragaYYoCv5JaYozvCvMfl+lOBhpPL2jdft91vix8GAYYWxrMMz1hXAbevDsFecuO0FNNAuFglKYy5P2JrpoVoldbWRxQ0W7v3as/EZpQ/KEqaYEFZBXIBc/ZY27TUw0R0PEHwSpk8Z/NzsQnkAiW7n1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 8E2BD1C007E; Thu, 28 Mar 2024 11:25:21 +0100 (CET)
Date: Thu, 28 Mar 2024 11:25:21 +0100
From: Pavel Machek <pavel@denx.de>
To: David Sterba <dsterba@suse.cz>
Cc: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Josef Bacik <josef@toxicpanda.com>, Boris Burkov <boris@bur.io>,
	David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 5.10 005/238] btrfs: add and use helper to check if block
 group is used
Message-ID: <ZgVFkYnPf9aLeFFM@duo.ucw.cz>
References: <20240324234027.1354210-1-sashal@kernel.org>
 <20240324234027.1354210-6-sashal@kernel.org>
 <20240325182614.GO14596@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IC1LsnMc0PRuSvj6"
Content-Disposition: inline
In-Reply-To: <20240325182614.GO14596@twin.jikos.cz>


--IC1LsnMc0PRuSvj6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > From: Filipe Manana <fdmanana@suse.com>
> >=20
> > [ Upstream commit 1693d5442c458ae8d5b0d58463b873cd879569ed ]
> >=20
> > Add a helper function to determine if a block group is being used and m=
ake
> > use of it at btrfs_delete_unused_bgs(). This helper will also be used in
> > future code changes.
> >=20
> > Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> > Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> > Reviewed-by: Boris Burkov <boris@bur.io>
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > Reviewed-by: David Sterba <dsterba@suse.com>
> > Signed-off-by: David Sterba <dsterba@suse.com>
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
>=20
> Please drop this patch from all stable branches unless it's a
> prerequisite for some other patch. This is clearly a cleanup.

This was reported multiple times, and you have even said you have
dropped the patch. What went wrong here?

Best regards,
								Pavel

Date: Mon, 18 Mar 2024 10:18:36 -0400
=46rom: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH AUTOSEL 5.10 1/7] btrfs: add and use helper to check if=
 block group is used

On Mon, Mar 11, 2024 at 10:05:40PM +0100, David Sterba wrote:
> On Mon, Mar 11, 2024 at 10:00:43PM +0100, Pavel Machek wrote:
> > Hi!
> >
> > > From: Filipe Manana <fdmanana@suse.com>
> > >
> > > [ Upstream commit 1693d5442c458ae8d5b0d58463b873cd879569ed ]
> > >
> > > Add a helper function to determine if a block group is being used and=
 make
> > > use of it at btrfs_delete_unused_bgs(). This helper will also be used=
 in
> > > future code changes.
> >
> > Does not fix a bug and does not seem to be preparation for anything,
> > so probably should not be here.
>
> Agreed, this patch does not belong to stable and I objected in
> https://lore.kernel.org/all/20240229155207.GA2604@suse.cz/
>
> for version 6.7 and all other stable versions.

Dropped, thanks!

--
Thanks,
Sasha

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--IC1LsnMc0PRuSvj6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZgVFkQAKCRAw5/Bqldv6
8ojwAJ9Pnk+1GB7Ggwaymnkbf/yDH4T46wCeMlzAmFmDEhArhKnO4nJ1EJS2EyA=
=53ZJ
-----END PGP SIGNATURE-----

--IC1LsnMc0PRuSvj6--


Return-Path: <linux-kernel+bounces-70537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9F58598F5
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 20:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 511DD1F2169A
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 19:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D416F524;
	Sun, 18 Feb 2024 19:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="YpIsDUMi"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4FD2B9A7;
	Sun, 18 Feb 2024 19:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708283337; cv=none; b=lTX3sdsZAi7d/sgkElT0GlfDxE7gQZFw1GDdjiSDlhlYjxMJS7Djr6WsB/eJgT6XbMUnuOBusIUzp7oYbHrIiqkWxi1uM2wREwk9bU5Al+UkBXyvwY9gmlLQZEtT/WQ2mIc8oJ1acDzG2hDJd92Dakj2GAI9WCdRaS5329wyGZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708283337; c=relaxed/simple;
	bh=PpSH5hvi4dsg4c550Qq2foXlIH3ewfO00DQgws+5isQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WjNzQSH5Ktc2jNf/Gl+OvGwsaG3SaWl7hveZDh5RLTklrCOx5UmfxVLZKxnvL8ly0sDMB7BIbad6o0OqdfMjEXxtVIsl+sJqhu3HAm5ZH2AYrRcx90R5KriCyASJKsaT/C7Ew9PL609salNe0utISRW/IyjVr42kuP6O/Iainbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=YpIsDUMi; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id E76781C006B; Sun, 18 Feb 2024 20:08:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1708283331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UO6BHw1ihzgpeRBQ0bvNxub7e+paexcL1WHjA8wQRHk=;
	b=YpIsDUMiPL4NwLKKvg8ynwih9EeW2hmqUwxY3yApkx7HD5+0Ednpy2C4PYQUg4pQPNTkeO
	OrcaPIMchZzi/DHlWy3C4Wz88zm8nDqO3jaEllihLV2wCWv+obWxOY8k8SgD2p80dqZTkE
	o7aBdrMJ572NzHvOJ7P+mLKlDs1otD8=
Date: Sun, 18 Feb 2024 20:08:51 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Daniel Wagner <dwagner@suse.de>, Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	james.smart@broadcom.com, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH AUTOSEL 5.10 13/16] nvmet-fc: do not tack refs on
 tgtports from assoc
Message-ID: <ZdJVw8PbwTDngATQ@duo.ucw.cz>
References: <20240207212700.4287-1-sashal@kernel.org>
 <20240207212700.4287-13-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LfSJrMDKQ4jMO3dD"
Content-Disposition: inline
In-Reply-To: <20240207212700.4287-13-sashal@kernel.org>


--LfSJrMDKQ4jMO3dD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Daniel Wagner <dwagner@suse.de>
>=20
> [ Upstream commit 1c110588dd95d21782397ff3cbaa55820b4e1fad ]
>=20
> The association life time is tied to the life time of the target port.
> That means we should not take extra a refcount when creating a
> association.

I don't see this one queued for 6.1 or 6.6. What went wrong here?

Best regards,
								Pavel

> +++ b/drivers/nvme/target/fc.c
> @@ -1110,12 +1110,9 @@ nvmet_fc_alloc_target_assoc(struct nvmet_fc_tgtpor=
t *tgtport, void *hosthandle)
>  	if (idx < 0)
>  		goto out_free_assoc;
> =20
> -	if (!nvmet_fc_tgtport_get(tgtport))
> -		goto out_ida;
> -
>  	assoc->hostport =3D nvmet_fc_alloc_hostport(tgtport, hosthandle);
>  	if (IS_ERR(assoc->hostport))
> -		goto out_put;
> +		goto out_ida;
> =20
>  	assoc->tgtport =3D tgtport;
>  	assoc->a_id =3D idx;
> @@ -1145,8 +1142,6 @@ nvmet_fc_alloc_target_assoc(struct nvmet_fc_tgtport=
 *tgtport, void *hosthandle)
> =20
>  	return assoc;
> =20
> -out_put:
> -	nvmet_fc_tgtport_put(tgtport);
>  out_ida:
>  	ida_simple_remove(&tgtport->assoc_cnt, idx);
>  out_free_assoc:

--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--LfSJrMDKQ4jMO3dD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZdJVwwAKCRAw5/Bqldv6
8gWHAJ48kG4XWYE4gvOKhhrCrFwKENwUXwCfdMTyE10BLyKcPXjjH72pOsUk44U=
=ByLx
-----END PGP SIGNATURE-----

--LfSJrMDKQ4jMO3dD--


Return-Path: <linux-kernel+bounces-63172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB54852BE2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C504D28397F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86BA1C687;
	Tue, 13 Feb 2024 09:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=haloniitty.fi header.i=@haloniitty.fi header.b="NTlBAkEv"
Received: from whm50.louhi.net (whm50.louhi.net [77.240.19.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663B91B7E6
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 09:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.240.19.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707815094; cv=none; b=K7M0NpI4GVNtqZHX4xr5nGAFvj0Hkn81++h+MCKfRZw19rHpJtPybxdDkCE5EAvsbp/6eY50PCAPHUBl4efhzpDXfCYECG/wEkgk2f6GldNmJURnytxDyXoQ1Hv7XT7vfpQLIWNZBNU+hF0a9/wxTKjtK4sT7zTeox2f/7ArYhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707815094; c=relaxed/simple;
	bh=Hek6B2b5hqvBzpU1pplaLcjn08MGSZzlnWfzAjJRm0c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RodOvViZTY82qo4R4ZViHVEkiPfNLroF988hIFiYDnp/PPKQEIrCJRW819o7rgnytXxZr0UaS76Axv9oVRfv6xUlKTjIVLxz5EsAvRaNoFFiAbnoo/2OSKLiFr5vbxrYtwmQWgGmBnY8DX1VYWMjat8KrD9qagZz8XBAVFzOPjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haloniitty.fi; spf=pass smtp.mailfrom=haloniitty.fi; dkim=pass (2048-bit key) header.d=haloniitty.fi header.i=@haloniitty.fi header.b=NTlBAkEv; arc=none smtp.client-ip=77.240.19.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haloniitty.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=haloniitty.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=haloniitty.fi; s=default; h=Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Dqvjpi3gCIFY1y588HKBH0osAieBB4j+AjlVItPgKd4=; b=NTlBAkEvk/1WemzjE/6G/dWwmy
	ycEmLjF+03GDFUC4BvFLu+LZppfhL0XZlu5MSN/B4qoTnw2TnH467RdcluoX/Hz2FuBDEz7Spufk4
	1eaPqKdwmdqU/iJTVnsr36Vm7UFOxrBERJQrmojlBgLBeUmaFvcMF9KuDuwuk6IKkwlu3iDkAaQ0P
	vr2H/+KIQz6R0xLvH4lynHs9JRUVsIQNs5bJ9E1JykbgbZZ/tE48cOrSiUKfADL+BS56A9YUGt186
	VH7lm6FzwBxxPu1eBCKPhY+u9KiTRip7D9G9orE1zazvUuZH99ug+WiuaGyYKJLWTzmszpUM4TMgf
	dbmShoYw==;
Received: from [194.136.85.206] (port=33796 helo=eldfell)
	by whm50.louhi.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <pekka.paalanen@haloniitty.fi>)
	id 1rZoiY-0002vt-1d;
	Tue, 13 Feb 2024 11:04:42 +0200
Date: Tue, 13 Feb 2024 11:04:40 +0200
From: Pekka Paalanen <pekka.paalanen@haloniitty.fi>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Jyri Sarha <jyri.sarha@iki.fi>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Sam Ravnborg <sam@ravnborg.org>, Devarsh
 Thakkar <devarsht@ti.com>, Aradhya Bhatia <a-bhatia1@ti.com>, Francesco
 Dolcini <francesco@dolcini.it>, Tomi Valkeinen <tomi.valkeinen@ti.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 "wayland-devel@lists.freedesktop.org" <wayland-devel@lists.freedesktop.org>
Subject: Re: [PATCH 1/2] drm/tidss: Fix initial plane zpos values
Message-ID: <20240213110440.13af335a@eldfell>
In-Reply-To: <20240213-tidss-fixes-v1-1-d709e8dfa505@ideasonboard.com>
References: <20240213-tidss-fixes-v1-0-d709e8dfa505@ideasonboard.com>
	<20240213-tidss-fixes-v1-1-d709e8dfa505@ideasonboard.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/sNODGAuo=/Hxc1/SQ_PTM=+";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - whm50.louhi.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - haloniitty.fi
X-Get-Message-Sender-Via: whm50.louhi.net: authenticated_id: pekka.paalanen@haloniitty.fi
X-Authenticated-Sender: whm50.louhi.net: pekka.paalanen@haloniitty.fi
X-Source: 
X-Source-Args: 
X-Source-Dir: 

--Sig_/sNODGAuo=/Hxc1/SQ_PTM=+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 13 Feb 2024 10:16:36 +0200
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com> wrote:

> When the driver sets up the zpos property it sets the default zpos value
> to the HW id of the plane. That is fine as such, but as on many DSS
> versions the driver arranges the DRM planes in a different order than
> the HW planes (to keep the non-scalable planes first), this leads to odd
> initial zpos values. An example is J721e, where the initial zpos values
> for DRM planes are 1, 3, 0, 2.
>=20
> In theory the userspace should configure the zpos values properly when
> using multiple planes, and in that sense the initial zpos values
> shouldn't matter, but there's really no reason not to fix this and help
> the userspace apps which don't handle zpos perfectly. In particular,
> Weston seems to have issues dealing with the planes with the current
> default zpos values.
>=20
> So let's change the zpos values for the DRM planes to 0, 1, 2, 3.
>=20
> Another option would be to configure the planes marked as primary planes
> to zpos 0. On a two display system this would give us plane zpos values
> of 0, 0, 1, 2. The end result and behavior would be very similar in this
> option, and I'm not aware that this would actually help us in any way.
> So, to keep the code simple, I opted for the 0, 1, 2, 3 values.
>=20
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> Fixes: 32a1795f57ee ("drm/tidss: New driver for TI Keystone platform Disp=
lay SubSystem")

Hi Tomi,

have you reported this to Weston? What exactly is the problem?

It doesn't seem like a good idea to work around userspace bugs
(non-regression, I presume?) with kernel changes.


Thanks,
pq

> ---
>  drivers/gpu/drm/tidss/tidss_plane.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/tidss/tidss_plane.c b/drivers/gpu/drm/tidss/=
tidss_plane.c
> index e1c0ef0c3894..68fed531f6a7 100644
> --- a/drivers/gpu/drm/tidss/tidss_plane.c
> +++ b/drivers/gpu/drm/tidss/tidss_plane.c
> @@ -213,7 +213,7 @@ struct tidss_plane *tidss_plane_create(struct tidss_d=
evice *tidss,
> =20
>  	drm_plane_helper_add(&tplane->plane, &tidss_plane_helper_funcs);
> =20
> -	drm_plane_create_zpos_property(&tplane->plane, hw_plane_id, 0,
> +	drm_plane_create_zpos_property(&tplane->plane, tidss->num_planes, 0,
>  				       num_planes - 1);
> =20
>  	ret =3D drm_plane_create_color_properties(&tplane->plane,
>=20


--Sig_/sNODGAuo=/Hxc1/SQ_PTM=+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmXLMKgACgkQI1/ltBGq
qqdp1w/8DVuos7vQvXFbkwEi2MmS22UH5pJRSEhtktlmNyHvlwnpQbKg7EPlh48M
fqjxA28Rxf/CMw0kAz0E6j+IIZ9mfnAUY6GQNtwmV442IfTD5NrkewgVFKA3JpWG
Ezs1BozIj9KI71Po/4pcIVFfJm5HgUBXMALfz8gp4E/voWBUFPNqyPFVFg6BDiz8
rinLwLVFVJqzEK40FW9p7LFfwOT2XaN0gkl09ql1XDBuA3CpXNuz53p8KDQy3rnZ
vu/BmvZYxPCMzULbiqiJelqk0RYwR/XfHPh/sKK88BYvrjtvIKAuOoQd2sBpvcIO
XoJWb2VtlyMR7jZk+9d8aLrJ+kNoe2GSlo/7CtYBIQYKTR+Zu9oZu+UdiWEFRopM
tXukYecHIVpG7sDpGgkoIMDcJ32LJDx4ynZcP1173Jrc1sgbmJF+uxRu4JhD7qDN
/I7uUYbooRFLv+yXu0C19IsSm8NK2T6foeKrj0YPU9idZp2OwEbW9HuKmH7igNdS
RIIerNbwgOiAbIBTvdzisnlPUDg4K3WIM54faPGBnoKp47xtjNS4ZxbhYWaBsgeM
j2v2tzIvoac/mNQJswGS5gpB/Gh9wqhtbvzU2c9aPlK3Q8XT3BjYHD2+Lj/tyUV8
W7ZZ0lfpnk6nNnR7EIYFB609pP/khWL0VotfNxJJJMRFMH9/rc0=
=iaMj
-----END PGP SIGNATURE-----

--Sig_/sNODGAuo=/Hxc1/SQ_PTM=+--


Return-Path: <linux-kernel+bounces-68897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA8F85819D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 799ACB2738B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E851B12C7E4;
	Fri, 16 Feb 2024 15:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=haloniitty.fi header.i=@haloniitty.fi header.b="GoKfPnm3"
Received: from whm50.louhi.net (whm50.louhi.net [77.240.19.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6125465D
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 15:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.240.19.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708098177; cv=none; b=gxHcuSh/wRZwC7Zv5q1YfM5njHONRSsmOUoGWsYvzckVzBlOPMRYmFBw4T65yy6/POtLUJbOs5Ynw7aXi5KWv36bGX33KxZSfL2uzCzTFak+YpP4+5MQe/C6Dei75kky160Bzo+GTPqZNdgtmdCm52a3npjdmDK3okqyEifxG6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708098177; c=relaxed/simple;
	bh=FHabSSQgrmLyD4BS8YCbUs+aiL3/uj41IuYl9HnphnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tKCVpa7W+V3B6Kh6EB9R6YOLZt9LEtLsU/7OL/sANp9Olhp+Z2PfreqHdqBpVVOOCwzqWZI0vaf1XazR6GfGeGVVjam7EReBOGjX8rrwW8uZHvS6zSkRPt1iXSElbPlRGYbk/AI2qONrbNhOhltL8CmwY/TeiZQbS7oGm24vWpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haloniitty.fi; spf=pass smtp.mailfrom=haloniitty.fi; dkim=pass (2048-bit key) header.d=haloniitty.fi header.i=@haloniitty.fi header.b=GoKfPnm3; arc=none smtp.client-ip=77.240.19.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haloniitty.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=haloniitty.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=haloniitty.fi; s=default; h=Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=yrmSopx2l89wJkQwr+erd3hVS7zVJnKpyVFPIyvtfbI=; b=GoKfPnm38gHh7bHnL1OBkb5Zos
	2T6ZJTbIh/eLoENNWmlbpiQEFIA40e5R5ZOaapkYHoSqIcT4T1/yAuX04D2/F638qIYx1mKsv1wo2
	WmpFu7M6/rxkhoQs9v3HAnyssUVScU9KL6TVZbcYpNgJbiXvPW+hVj4J33RbmM+SBnABuuqIuSeYt
	bMHeVN7hG3ZlSsE2yYTQbdrZCE3Lsf1am1X5ujxglQpRchx83f/T8lOV0NRihADZC5E3RjUtW05OL
	lkiHuDksDn6rkkafhnhV7GDNfo44/oe7qWbMJ9YYCJ0DHGx/7hdkVd19N5M70J1RZvIrFFOC1nAXa
	74092tag==;
Received: from [194.136.85.206] (port=54650 helo=eldfell)
	by whm50.louhi.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <pekka.paalanen@haloniitty.fi>)
	id 1rb0MU-0005eo-1j;
	Fri, 16 Feb 2024 17:42:50 +0200
Date: Fri, 16 Feb 2024 17:42:42 +0200
From: Pekka Paalanen <pekka.paalanen@haloniitty.fi>
To: Harry Wentland <harry.wentland@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>, amd-gfx@lists.freedesktop.org,
 Mario Limonciello <mario.limonciello@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>, David
 Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Alex Hung
 <alex.hung@amd.com>, Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/amd/display: add panel_power_savings sysfs entry
 to eDP connectors
Message-ID: <20240216174242.15d07657@eldfell>
In-Reply-To: <82280a39-4e1d-41ee-82fb-758ceed953e4@amd.com>
References: <20240202152837.7388-1-hamza.mahfooz@amd.com>
	<20240216101936.2e210be2@eldfell>
	<82280a39-4e1d-41ee-82fb-758ceed953e4@amd.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/0kTS.YsXNUeniYT0qC/j.ma";
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

--Sig_/0kTS.YsXNUeniYT0qC/j.ma
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 16 Feb 2024 09:33:47 -0500
Harry Wentland <harry.wentland@amd.com> wrote:

> On 2024-02-16 03:19, Pekka Paalanen wrote:
> > On Fri, 2 Feb 2024 10:28:35 -0500
> > Hamza Mahfooz <hamza.mahfooz@amd.com> wrote:
> >  =20
> >> We want programs besides the compositor to be able to enable or disable
> >> panel power saving features. =20
> >=20
> > Could you also explain why, in the commit message, please?
> >=20
> > It is unexpected for arbitrary programs to be able to override the KMS
> > client, and certainly new ways to do so should not be added without an
> > excellent justification.
> >=20
> > Maybe debugfs would be more appropriate if the purpose is only testing
> > rather than production environments?
> >  =20
> >> However, since they are currently only
> >> configurable through DRM properties, that isn't possible. So, to remedy
> >> that issue introduce a new "panel_power_savings" sysfs attribute. =20
> >=20
> > When the DRM property was added, what was used as the userspace to
> > prove its workings?
> >  =20
>=20
> I don't think there ever was a userspace implementation and doubt any
> exists today. Part of that is on me. In hindsight, the KMS prop should
> have never gone upstream.
>=20
> I suggest we drop the KMS prop entirely.

Sounds good. What about the sysfs thing? Should it be a debugfs thing
instead, assuming the below question will be resolved?

> As for the color accuracy topic, I think it is important that compositors
> can have full control over that if needed, while it's also important
> for HW vendors to optimize for power when absolute color accuracy is not
> needed. An average end-user writing code or working on their slides
> would rather have a longer battery life than a perfectly color-accurate
> display. We should probably think of a solution that can support both
> use-cases.

I agree. Maybe this pondering should start from "how would it work from
end user perspective"?

"Automatically" is probably be most desirable answer. Some kind of
desktop settings with options like "save power at the expense of image
quality":
- always
- not if watching movies/gaming
- on battery
- on battery, unless I'm watching movies/gaming
- never

Or maybe there already is something like that, and it only needs to be
plumbed through?

Which would point towards KMS clients needing to control it, which
means a generic KMS prop rather than vendor specific?

Or should the desktop compositor be talking to some daemon instead of
KMS for this? Maybe they already are?


Thanks,
pq

--Sig_/0kTS.YsXNUeniYT0qC/j.ma
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmXPgnIACgkQI1/ltBGq
qqcCuxAAg9Uyex5kx01Qlv5ieHS2BWyuaSql4cYBf6vA4kUftQMQfDIl1ZzdO0me
5aEfYrUFl2pSdBTgO2o2rdYHdZ3rUA2PYA6+wrIs7xrz+SwLRHZPQH3vE/DSMbOB
2XRzn6PuwVxB3V64Ai0TKttlG2jqdRdue34wrpBIDpvKM5VECp9FK7HAWZx2IfTt
bsmG79BWs9cHdb2P+jEPd/jXFLcj9KC+EEO69e1JXjptxXcnEmJOUsJHR8Mdr1za
vZFg6NexELbZyOWDOEHFBh/Xsdcb9YAadbcEPDuneLIIvSw6TOuhMb2hhGKg1aO1
IlhE/LSUCm35wG4YpMC1OfgyJjDnMH7zCZZ/UsoQ7jSa/35CD55k7JaG6gqV2RFM
7f8eYKcdfUxPyoRGZm3WCh7cESa634etbXQWPuX7cTz+bCuwVJHzb8NMPl7qf55M
XoZMte/SVjynOTshvstslKJIlbHk8lJPmGX70q0RCemSQeP2uF8F/sk/JFEWMeoW
Q1WWNya6ibAXkVWKpyprFnHoNwAodSRFyrcBfMc8+gmzlQgZm9KOOHUoanD2LrYS
iEJHEi2KN26m9oe5RH76crvTGA6ACxuKHq7SpNFooOeeUFKFLl0DKWaju/QzB9bd
tgiB4ezBVE+LSgmAp3foXNhsNINfTnxFHDiJ+1TxscGH9rlAAPI=
=FDiI
-----END PGP SIGNATURE-----

--Sig_/0kTS.YsXNUeniYT0qC/j.ma--


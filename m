Return-Path: <linux-kernel+bounces-122757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1D488FCB7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F1BA1C2F0A6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FC57D3F5;
	Thu, 28 Mar 2024 10:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="N1MR8z0c"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216837C0B7;
	Thu, 28 Mar 2024 10:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711621000; cv=none; b=a7c6PxBY4vAEGkd/eoet5ruXCBkFqSWCOAv8ljefDgm3urPfcIxDtU0bHnigcyx9bKUuEYuXA3mBTkG3y1YaE0Rh2tP7NlH4ww+BPztA6ureKzVjP1MNAqy03P9C5o3Bp2jnVcKfZxCxXwKXZcAJ3piW9iTrluD+wqmlSVUatBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711621000; c=relaxed/simple;
	bh=nk5i4NNZAo1RHHchBnI7S3b6Xb+SwGyXWl+eGWawbec=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sJr5OBqITD7n0pmfNM+ZAI+4HNBBws2Xst/YN0o66fDkXUk0ltC0o2YR5sL+fANil52iDO8pN21LFeBZBtBq6CvQoLimeYeYkiDO5vK95B2na+hKPnlnJQRfYO3zkVg+LcIwFnSnhKQAID4/fv43JnN+uoGbh5r0S/hNaPCSmC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=N1MR8z0c; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1711620997; x=1743156997;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nk5i4NNZAo1RHHchBnI7S3b6Xb+SwGyXWl+eGWawbec=;
  b=N1MR8z0cMMkRgCH5jm2k+gew+SAkA7qCh7m1IowuqGQl4UeXXyZZracc
   GrQdl+jujUPTU7arnbeUelvFHwbnsHq1lseW3QgigUQ4EDPTmPqlue86H
   5D2RoH8qgHPxKa+V2R/TS8X/YCnCyLR7k/1c4x0gHiiMp4zSUVsh8K+7H
   wgdt4M1/LbZ6YKIgPc/supYRdthZt4/zJD0NapH9YKo7PkPmAMFx/U+RP
   6jLYGRMq604kJu6NONxOVtqkv6tZJSszoCcB9Mr0acqQcTAAgGs6+yrzY
   KtSwqqU5OdT0NvMpRRwcHwZ89wZNeFMCAcraoJ30oEx0xllNw2i2Bhv3O
   A==;
X-CSE-ConnectionGUID: drY+R/XoRbWbWJOn1hAABA==
X-CSE-MsgGUID: VmKmYME3Rb2VG6xq0GR+Zg==
X-IronPort-AV: E=Sophos;i="6.07,161,1708412400"; 
   d="asc'?scan'208";a="19039158"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Mar 2024 03:16:35 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Mar 2024 03:16:27 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Thu, 28 Mar 2024 03:16:24 -0700
Date: Thu, 28 Mar 2024 10:15:36 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Kieran Bingham <kieran.bingham@ideasonboard.com>
CC: Conor Dooley <conor@kernel.org>, <git@luigi311.com>,
	<linux-media@vger.kernel.org>, <dave.stevenson@raspberrypi.com>,
	<jacopo.mondi@ideasonboard.com>, <mchehab@kernel.org>, <robh@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<shawnguo@kernel.org>, <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
	<festevam@gmail.com>, <sakari.ailus@linux.intel.com>,
	<devicetree@vger.kernel.org>, <imx@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 17/23] dt-bindings: media: imx258: Rename to include
 vendor prefix
Message-ID: <20240328-prideful-unopposed-e29fcee74c29@wendy>
References: <20240327231710.53188-1-git@luigi311.com>
 <20240327231710.53188-18-git@luigi311.com>
 <20240327-ninth-tulip-77191ad10fdd@spud>
 <0e658ecc-38d2-4d6f-b0cf-f5f3ec32c1b8@luigi311.com>
 <171161592126.3072637.14564447281929105708@ping.linuxembedded.co.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KbSR9HJd4zO5GzGC"
Content-Disposition: inline
In-Reply-To: <171161592126.3072637.14564447281929105708@ping.linuxembedded.co.uk>

--KbSR9HJd4zO5GzGC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 08:52:01AM +0000, Kieran Bingham wrote:
> Quoting git@luigi311.com (2024-03-28 00:57:34)
> > On 3/27/24 17:47, Conor Dooley wrote:
> > > On Wed, Mar 27, 2024 at 05:17:03PM -0600, git@luigi311.com wrote:
> > >> From: Dave Stevenson <dave.stevenson@raspberrypi.com>
> > >>
> > >> imx258.yaml doesn't include the vendor prefix of sony, so
> > >> rename to add it.
> > >> Update the id entry and MAINTAINERS to match.
> > >>
> > >> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> > >> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > >=20
> > > This is a v1 with my ack, something has gone awry here. It's also
> > > missing your signoff. Did you pick up someone else's series?
> >=20
> > Yes, this is a continuation of Dave's work. I contacted him directly,
> > and he mentioned that he is unable to submit a v2 any time soon and
> > was open to someone else continuing it in his stead.

Ah okay. Unfortunately I see so many binding patches pass by that I
sometimes forget about what I already reviewed, and I did not
remember this one at all.

> > This is my first
> > time submitting a patch via a mailing list, so I'm not sure if I'm
> > missing something, but I only added my sign off for anything that
> > actually included work from my side and not just bringing his patch
> > forward to this patch series.

Right. The rules are that you need to add it when you send someone's
work, like chain of custody type of thing.

> Your cover letter states v2, but the individual patches do not.
>=20
> Add the '-v2' (or, rather, next it will be '-v3') to git format-patch
> when you save your series and it will add the version to each patch. You
> can also add '-s' to that command I believe to add your SoB to each
> patch.

or a rebase will do it with --signoff:
https://git-scm.com/docs/git-rebase#Documentation/git-rebase.txt---signoff

Cheers,
Conor.

--KbSR9HJd4zO5GzGC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZgVDSAAKCRB4tDGHoIJi
0oQ0AP9mrkNHo7nUeavUQD133Z30xdxPgA8oxzczCmQqRRn9rQD9H2Peq2ixkepz
Ntr8uhXrnqlN86wkiOXe4lrEkKE0YQk=
=vJQk
-----END PGP SIGNATURE-----

--KbSR9HJd4zO5GzGC--


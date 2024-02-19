Return-Path: <linux-kernel+bounces-71809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6914285AAF4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 956381C21249
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEB9482D0;
	Mon, 19 Feb 2024 18:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lg9UeeJ9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E099481B3
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 18:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708367339; cv=none; b=GNSok69z/3d2PpHtILE3J611ZPZgcD2CthNK/d3OmG1vePJeW5jS9zJ3fo2vl+tOwfv3auP2vlg/RWuYDSmTcgsxbddfBDYlnysJkJQzPnDzcC+ETBMNtaxqZU+tx+JajIKxW18caK5rVwEmLvnS+C1sRUr19osF/J8TBfiAHgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708367339; c=relaxed/simple;
	bh=QN80O6Hd4SYisWubwEwh/1R3fa4UIIJenRLDUxFbOBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gr4jFVB0nzHuAr7d4F6d2viTkQiZuLTm6r3QivxlB62DlNEiX1xUEYcRrZBOmqHnXzFlNNO+AJmv1xHq2aZkCiPsGEgjRDTPMFGP/kr6/HRzfWR8orTMCaN+8u18VYeRhHYKNftCZL0YMgtllxohsRgldAC5WdAwou0I9FBfYHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lg9UeeJ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBC7FC433C7;
	Mon, 19 Feb 2024 18:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708367338;
	bh=QN80O6Hd4SYisWubwEwh/1R3fa4UIIJenRLDUxFbOBY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lg9UeeJ9o9Wgg7Kpe5w3mYuDV9Br7ganoNolSo3SnKH94jeZC++NwyGvPi2Dki89g
	 oFZR/8IVkqpmPcizom4GYUg4dNINunckKUNE1VzXXa2xJPszwKQ1/KOzOuIo6m5frF
	 U+39cLmxx38rZPFud7XBJb7WOAhMrnadmSukZh5Q9aMPpvwTQlMGKJots9yXhmPQSs
	 vM7VSmmRPa452fKaGkIG+y8Z8uJd+6TtIMxTvGgrlNhyjVPBtiQCpx4F/lA6PdBsVj
	 9tbGeuYv7IBKDlHLwvsBzIbx+92vKeDI0OvtSn8D4XebCdm0u3STPqfJqdVRLP+GIy
	 0wLLrQo7rG0Qw==
Date: Mon, 19 Feb 2024 18:28:52 +0000
From: Mark Brown <broonie@kernel.org>
To: Gergo Koteles <soyer@irl.hu>
Cc: Shenghao Ding <shenghao-ding@ti.com>, andriy.shevchenko@linux.intel.com,
	lgirdwood@gmail.com, perex@perex.cz,
	pierre-louis.bossart@linux.intel.com, 13916275206@139.com,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
	liam.r.girdwood@intel.com, bard.liao@intel.com,
	mengdong.lin@intel.com, yung-chuan.liao@linux.intel.com,
	baojun.xu@ti.com, kevin-lu@ti.com, tiwai@suse.de
Subject: Re: [PATCH v8] ASoc: tas2783: Add tas2783 codec driver
Message-ID: <0afeaf24-ba02-413c-810a-90cebd002a3f@sirena.org.uk>
References: <20240219022153.553-1-shenghao-ding@ti.com>
 <646973c48c4ee30c92de98aa027992e8ccdd325d.camel@irl.hu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RoSbG8iRlMkrNIk6"
Content-Disposition: inline
In-Reply-To: <646973c48c4ee30c92de98aa027992e8ccdd325d.camel@irl.hu>
X-Cookie: Kleeneness is next to Godelness.


--RoSbG8iRlMkrNIk6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 07:06:23PM +0100, Gergo Koteles wrote:
> Hi Shenghao,
>=20
> On Mon, 2024-02-19 at 10:21 +0800, Shenghao Ding wrote:
> > The tas2783 is a smart audio amplifier with integrated MIPI SoundWire
> > interface (Version 1.2.1 compliant), I2C, and I2S/TDM interfaces design=
ed
> > for portable applications. An on-chip DSP supports Texas Instruments
> > SmartAmp speaker protection algorithm. The integrated speaker voltage a=
nd
> > current sense provides for real-time monitoring of lodspeakers.

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

--RoSbG8iRlMkrNIk6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXTneQACgkQJNaLcl1U
h9Arywf9E0yAQ5zlYJuPvwD9xlUbowPRrfOwjunt/jB4BQoZcztIogL1luBWd0QJ
RcTGdCEk1Kn/jnawn0M8k6bTiYV+qPRmzBHQ47fgOrELRZODluTklY389Nj8R2+7
SXGM3qH7Y/CV28O36MBtk/CLMzR15JD2QhMFxZlusPAO3E6vyKleV0tIF835Rycl
xJzIY/xc1tQEzSMuerK/3t7JiIVg3XdP5uDuRJsPFdAoi9d+gVaTTtxYQFky0LXh
Nh+5olIsOfD4/NWj+rLmGWZrEWPcEvSMgp0i9wvLSrshX1WWff1v0tZg4IqyMIWY
PIj9+b6El1lFcbQfxY/LfdnAg0oR3Q==
=me1z
-----END PGP SIGNATURE-----

--RoSbG8iRlMkrNIk6--


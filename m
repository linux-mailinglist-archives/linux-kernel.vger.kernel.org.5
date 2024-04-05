Return-Path: <linux-kernel+bounces-133007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DDF899D48
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 887C51F23142
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447B516C86D;
	Fri,  5 Apr 2024 12:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="VCOLuLku"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A031DDD1;
	Fri,  5 Apr 2024 12:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712321025; cv=none; b=u6uPNW6Rgs1/ktUlYW+1bKjH8Z9wDe9rblRbMeEbs9+3e2GnP/eTPxCFR3OL2UMaZRxAzNP0w7s7DBWrmeADTyTEn1nZS+IlYPfbGIahjgQpE15fmfvMm+9OhvoD6XFFGq0c8/340XfWF3Z70EGRl4DRoXD1n1Xc4rGoUguwGvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712321025; c=relaxed/simple;
	bh=uKpkhmhxikuILquZfgGaVnyy2MUxIAtbODz/S12cy40=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ghgDYWwJOYEyhT54LRk6wKsvEbZVIQvpDz/TDZ1r45rnWwdLtKnvFGuJ2KVCcIROv2LLG7m7XdM/NUMCyFch/FF6mDKeQmnVLxmm8O/v6Opy7HFEey/6ADi+dx6KwD2xQgwSQ3ftOP1Qc7QMjTwTj5KSaEaBDkOvM11oF7EgMYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=VCOLuLku; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712321023; x=1743857023;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uKpkhmhxikuILquZfgGaVnyy2MUxIAtbODz/S12cy40=;
  b=VCOLuLkuP18WH1dKH9rVXMXMgM5d7tlMbgPkSlExMkkw2uGde2PjNsGs
   F05Ev0Ihhq620z3v7CN9i8TmQ14FZpvLEEvfGPFeUk2AMtpYzFGH3jhCz
   UrLLtMGXLTuGHNhHquBUN/7o4uPmVA9UxFVu2DHYhp7yYURGTGZmCaIMj
   tMWZ3s2MqUuik1mNryPpchyL3531Plm0eGOdSO41z9Md/L163989Z/f7x
   otbDi4qdoh+g9X/wjNKPXXTUVNROHrYkDVLCTFkzHGxF2d3/IXFOhcgPA
   EP9vCSJPRrO1zCXiPz+MwfHW6dDGJ99yJtLoVotxFQdsckMKx8usEOJ0h
   A==;
X-CSE-ConnectionGUID: yN0usXTgTm6z0XmMc2aABQ==
X-CSE-MsgGUID: Db6lycEUTUmxkwlCZaQJzw==
X-IronPort-AV: E=Sophos;i="6.07,181,1708412400"; 
   d="asc'?scan'208";a="250449363"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Apr 2024 05:42:39 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Apr 2024 05:42:36 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Fri, 5 Apr 2024 05:42:34 -0700
Date: Fri, 5 Apr 2024 13:41:44 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: <marius.cristea@microchip.com>, <lars@metafoo.de>, <robh+dt@kernel.org>,
	<jdelvare@suse.com>, <linux@roeck-us.net>, <linux-hwmon@vger.kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 2/2] iio: adc: adding support for PAC193x
Message-ID: <20240405-embellish-bonnet-ab5f10560d93@wendy>
References: <20240222164206.65700-1-marius.cristea@microchip.com>
 <20240222164206.65700-3-marius.cristea@microchip.com>
 <20240224191559.40d233db@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rftDiodiuYntSj0z"
Content-Disposition: inline
In-Reply-To: <20240224191559.40d233db@jic23-huawei>

--rftDiodiuYntSj0z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 24, 2024 at 07:15:59PM +0000, Jonathan Cameron wrote:
> On Thu, 22 Feb 2024 18:42:06 +0200
> <marius.cristea@microchip.com> wrote:
>=20
> > From: Marius Cristea <marius.cristea@microchip.com>
> >=20
> > This is the iio driver for Microchip
> > PAC193X series of Power Monitor with Accumulator chip family.
> >=20
> > Signed-off-by: Marius Cristea <marius.cristea@microchip.com>
> So I had a few comments on this, but nothing that can't be cleaned up lat=
er.
> + I'll fix the thing the bots didn't like on the bindings.
>=20
> Series applied to the togreg branch of iio.git and pushed out
> as testing for 0-day to take a look at it.

I tested this out on v6.9-rc2 and prompted a backtrace when collectd
started running:
	------------[ cut here ]------------
	UBSAN: array-index-out-of-bounds in /home/conor/stuff/linux/drivers/iio/ad=
c/pac1934.c:857:25
	index 7 is out of range for type 'u32 [4]'
	CPU: 1 PID: 179 Comm: iiod Not tainted 6.9.0-rc2-dirty #1
	Hardware name: Microchip PolarFire-SoC Icicle Kit (DT)
	Call Trace:
	[<ffffffff80006bba>] dump_backtrace+0x28/0x30
	[<ffffffff80bd67d8>] show_stack+0x38/0x44
	[<ffffffff80be7820>] dump_stack_lvl+0x6e/0x9a
	[<ffffffff80be7864>] dump_stack+0x18/0x20
	[<ffffffff80be1452>] ubsan_epilogue+0x10/0x46
	[<ffffffff80615358>] __ubsan_handle_out_of_bounds+0x6a/0x78
	[<ffffffff80981f3a>] pac1934_read_raw+0x20c/0x34c
	[<ffffffff80977c4c>] iio_read_channel_info+0x5c/0xbe
	[<ffffffff8073516e>] dev_attr_show+0x1c/0x4a
	[<ffffffff80387292>] sysfs_kf_seq_show+0x80/0xcc
	[<ffffffff80385b12>] kernfs_seq_show+0x3c/0x4a
	[<ffffffff8031e3d8>] seq_read_iter+0x136/0x2e4
	[<ffffffff80385cde>] kernfs_fop_read_iter+0x38/0x16a
	[<ffffffff802e904a>] vfs_read+0x1be/0x2ba
	[<ffffffff802e9c48>] ksys_read+0x64/0xd2
	[<ffffffff802e9cd6>] __riscv_sys_read+0x20/0x28
	[<ffffffff80be838a>] do_trap_ecall_u+0xee/0x204
	[<ffffffff80bf57d0>] ret_from_exception+0x0/0x64
	---[ end trace ]---

The device itself only has 4 channels, but in sysfs there are "fake"
channels for the average voltages and currents too. UBSAN points at:
	case PAC1934_VSENSE_AVG_4_ADDR:
		*val =3D PAC1934_MAX_VSENSE_RSHIFTED_BY_16B;
		if (chan->scan_type.sign =3D=3D 'u')
			*val2 =3D info->shunts[channel];
		else
			*val2 =3D info->shunts[channel] >> 1;
		return IIO_VAL_FRACTIONAL;

And info->shunts is only valid for the 4 real channels, so I guess the
averaged channels probably need to do a [channel - 4] or similar. I
dunno if that relation between averaged channels and their "real"
counterparts is fixed or if different pac devices need different values,
but on my system here that would work.

I do quite like that UBSAN points out the line in question :)

Cheers,
Conor.

--rftDiodiuYntSj0z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZg/xiAAKCRB4tDGHoIJi
0txtAP9vdnuMITiNcZxaL8SMlaKjSPQD1+HFCcXJLC7ZFeBlYwD9GJvPd7VFEWXq
582boF44JXcw1Oov6i1opoQf1CMElwY=
=Eo5n
-----END PGP SIGNATURE-----

--rftDiodiuYntSj0z--


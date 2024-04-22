Return-Path: <linux-kernel+bounces-152966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 584DC8AC6D3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 693EA1C20B04
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C8F50276;
	Mon, 22 Apr 2024 08:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="0Bm2NM0N"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51042482CA
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 08:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713774158; cv=none; b=XgOm0BBVmfySSp6GF0s03WDZk6+aOYMWIOQPa4HvrREYZcWklM3qikrLaBO8osh1qn7iUget70iaNohwYvcwTQJx+JhjEFz1J0nW+dNcEJNIed08fUAZnZ1ZYVJtfqOaSXTg1bFq+xEvhCS4pYaITIL8Mrnrg9NpD38HAuZDTRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713774158; c=relaxed/simple;
	bh=hqzjZdrVT+2K2Gd5jHuwZTTR/Vs/MX4XtZ2J7V6NUU0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gHDLpFFgZ4Djp6GmMKRIh5eQQz3h7lvQyR28J8R554ti6MbNjjkbAbfraQ5hfA4NqrzJHYrXg8MWfFhrNx7oQToBYeBD5ZuTajW1IlQhc7LPLWMmSFiOCL0gXxON6mcpcQHn5oERXlKIEp+OQVyOoxxMzjqKSTsiNoaUrF2+cQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=0Bm2NM0N; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1713774157; x=1745310157;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hqzjZdrVT+2K2Gd5jHuwZTTR/Vs/MX4XtZ2J7V6NUU0=;
  b=0Bm2NM0NU2QjlLM5yB/2g39PUlEsc4G3Lkaq7X1E+M79spPc7Q1ipFYg
   UZ0l5U2T+F8o5yyZaHFsLjQZiOaaEQ6TMcvnZOLw8Eb7qi7MLnhsJNtwp
   CW7sqYNHKuG6V7ugKuLmThTbVcGPq784Kmg1VuaJEN0OfhXbg5+I68aiu
   weu4plm2JD8n/q571CNJa2aENe3UWrlq7rWzQILdDSbuOc4x24koHzlFU
   Dl9Gx2lPS+jHzw1jJpMvtPczaYfK9n2GpswPoOcL6pDUYtxw/ILvN8ZAY
   k0mJTzoJhFAVtVDKrZEdXZVYSn2eUjPs3qP9w7mTjOfjkm1XZMOwpYxY2
   A==;
X-CSE-ConnectionGUID: FFRa7jbjQ4CieqJWuyjLYg==
X-CSE-MsgGUID: +MO64W1yTt21mTVIuKugwQ==
X-IronPort-AV: E=Sophos;i="6.07,220,1708412400"; 
   d="asc'?scan'208";a="22079780"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Apr 2024 01:22:35 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 01:22:16 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Mon, 22 Apr 2024 01:22:14 -0700
Date: Mon, 22 Apr 2024 09:21:58 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Xu Lu <luxu.kernel@bytedance.com>
CC: Conor Dooley <conor@kernel.org>, <paul.walmsley@sifive.com>,
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <andy.chiu@sifive.com>,
	<guoren@kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <lihangjing@bytedance.com>,
	<dengliang.1214@bytedance.com>, <xieyongji@bytedance.com>,
	<chaiwen.cc@bytedance.com>, Andrew Jones <ajones@ventanamicro.com>
Subject: Re: [External] Re: [RFC 1/2] riscv: process: Introduce idle thread
 using Zawrs extension
Message-ID: <20240422-dropper-subplot-efaa833f3cf2@wendy>
References: <20240418114942.52770-1-luxu.kernel@bytedance.com>
 <20240418114942.52770-2-luxu.kernel@bytedance.com>
 <20240418-dove-deferral-2b01100e13ca@spud>
 <CAPYmKFsddST1n2ZU+5=c_yPqAKTjQ4X1mKVFMZbhfo8xiB+OTA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="au03+AdWTr1KTcof"
Content-Disposition: inline
In-Reply-To: <CAPYmKFsddST1n2ZU+5=c_yPqAKTjQ4X1mKVFMZbhfo8xiB+OTA@mail.gmail.com>

--au03+AdWTr1KTcof
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 12:14:47AM +0800, Xu Lu wrote:
> On Thu, Apr 18, 2024 at 11:06=E2=80=AFPM Conor Dooley <conor@kernel.org> =
wrote:
> > On Thu, Apr 18, 2024 at 07:49:41PM +0800, Xu Lu wrote:

> > > +        The Zawrs extension defines a pair of instructions to be used
> > > +        in polling loops that allows a core to enter a low-power sta=
te
> > > +        and wait on a store to a memory location.
> > > +
> > > +        If you don't know what to do here, say Y.
> > > +
> > >  config TOOLCHAIN_HAS_V
> > >       bool
> > >       default y
> > > @@ -1075,6 +1090,15 @@ endmenu # "Power management options"
> > >
> > >  menu "CPU Power Management"
> > >
> > > +config RISCV_ZAWRS_IDLE
> > > +     bool "Idle thread using ZAWRS extensions"
> > > +     depends on RISCV_ISA_ZAWRS
> > > +     default y
> > > +     help
> > > +             Adds support to implement idle thread using ZAWRS exten=
sion.
> > > +
> > > +             If you don't know what to do here, say Y.
> >
> > I don't think this second option is needed, why would we not always want
> > to use the Zawrs version of this when it is available? Can we do it
> > unconditionally when RISCV_ISA_ZAWRS is set and the extension is
> > detected at runtime?
> >
> > Cheers,
> > Conor.
>=20
> Indeed, we can always choose WRS.NTO when entering idle.
>=20
> This config is introduced for the second commit in this patch series.
> In the second commit, we detect whether the target cpu is idle when
> sending IPI and write IPI info to the reserve set of idle cpu so as to
> avoid sending a physical IPI. Besides, the target idle cpu need not to
> go through traditional interrupt handling routine. However, if all
> cpus are busy and hardly enter idle, this commit may introduce
> performance overhead of extra instructions when sending IPI. Thus we
> introduce this config just in case.

Could you add the downsides into the help text of the config option so
that people can understand why to enable/disable the option?

Thanks,
Conor.

--au03+AdWTr1KTcof
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZiYeGAAKCRB4tDGHoIJi
0m0oAP9mbUm3LJcEUiHU1xnlWcY7C/VC+9g67Mo9ZUgSpFCQPAD/S4i9UUubWIEX
UgTIDTA4/zvViKNIYF6pSKiRQV8URQ4=
=Ocef
-----END PGP SIGNATURE-----

--au03+AdWTr1KTcof--


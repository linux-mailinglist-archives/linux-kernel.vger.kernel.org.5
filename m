Return-Path: <linux-kernel+bounces-20897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6545828719
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18DCC1C24402
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 13:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BF738FA4;
	Tue,  9 Jan 2024 13:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="uFov+Ctq"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF2B38F83;
	Tue,  9 Jan 2024 13:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1704807006; x=1736343006;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8aLZtE/Nh+kY7P6JEc9JNbu4E+Q6wgXQkKqqHcpi8kA=;
  b=uFov+CtqgG5qWAlbVo0TYx0eauHAvdUj1kw/RTESs3JazjFNiTGTMG5H
   KEMsHTdkm8Lw6Xze5L/8q/LC0C4bA1wa7J83l96xjlrHxVKpHPbLsaoQn
   XZGCHo6MsrKw0v41PrqWWSiRO4iIwjD+jMfWjiQAsLam/PDOHhP5hGGLq
   5+kKdAHmzuqv1uG9oDHe27ga8Xx6uuKwIyLO/LVDVmCzrfdvObTPni20D
   sGMBZYLZmhTcJbPazEWTO1W5tK/dFoJjnR/ntGXjW30wJFyXrwlKnLdHv
   hbrm9D1scnFfl4O6btKs2n5V/x/R1xuDElxeZZ6YHn7RMNX7E/Y8rNeF5
   A==;
X-CSE-ConnectionGUID: vc1Zgb4NSW6pSMb/c+2yMQ==
X-CSE-MsgGUID: 3+kM2vspQ02lDGXYD5i6Wg==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,183,1695711600"; 
   d="asc'?scan'208";a="14905648"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Jan 2024 06:30:04 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Jan 2024 06:29:45 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Tue, 9 Jan 2024 06:29:42 -0700
Date: Tue, 9 Jan 2024 13:29:07 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: <stable@vger.kernel.org>, <patches@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <torvalds@linux-foundation.org>,
	<akpm@linux-foundation.org>, <linux@roeck-us.net>, <shuah@kernel.org>,
	<patches@kernelci.org>, <lkft-triage@lists.linaro.org>, <pavel@denx.de>,
	<jonathanh@nvidia.com>, <f.fainelli@gmail.com>, <sudipm.mukherjee@gmail.com>,
	<srw@sladewatkins.net>, <rwarsow@gmx.de>, <conor@kernel.org>,
	<allen.lkml@gmail.com>
Subject: Re: [PATCH 6.6 000/124] 6.6.11-rc1 review
Message-ID: <20240109-woven-qualify-c9b4082f701e@wendy>
References: <20240108150602.976232871@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nSe+/zeOGRhIflWG"
Content-Disposition: inline
In-Reply-To: <20240108150602.976232871@linuxfoundation.org>

--nSe+/zeOGRhIflWG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 08, 2024 at 04:07:06PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.11 release.
> There are 124 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--nSe+/zeOGRhIflWG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZZ1KIwAKCRB4tDGHoIJi
0pOJAQD/J+2ADrOoX5TqtHfI+2VUGQwGknxvkH4c8gMXIjtyAgEA9Nu5rJD53+vM
RZleiX6DLME3IIJLAhBfwLPj3SfaFQ0=
=L2Mg
-----END PGP SIGNATURE-----

--nSe+/zeOGRhIflWG--


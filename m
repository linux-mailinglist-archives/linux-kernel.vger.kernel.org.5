Return-Path: <linux-kernel+bounces-25960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D635682D8D3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 13:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76A64B2169C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 12:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D832C6A7;
	Mon, 15 Jan 2024 12:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="OGbdXgrS"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866472C69D;
	Mon, 15 Jan 2024 12:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1705321261; x=1736857261;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6uiGgKOYeoijZXNs4JR31BgEsE6com5xM6jwtC4X6eU=;
  b=OGbdXgrSG6+53Jmct6kH06gmovz+iORRXEvkudAnWHRwGM9hBJ66zYAM
   BPJbo1+J+A8J+q+3CofFapUcFV0nse032FPsNdLrpZivWaIe4RrbNppIh
   CRNgBRaZ/rNtLctsTj4ocu7cCQQe3OBYiGS1EGKZI/tfNZ3lrg/WzJKKV
   ixL4cpMqlsCgs0VD7BGoTXGd4LE92VIbT7q+w0eUR11fs0AQ9Wa/fgCjk
   K9BU3nhkxkzBtqbfN24CbFzA/aFmOmZyhekHMAy51x8g3SY3HshRgj7eo
   WZbb8JcACnCKA/6jlP6wpPfwves71FF4fqYRTuaz6U7SdIzUb7l3z1cng
   A==;
X-CSE-ConnectionGUID: HseR1VJsSLqKdYBiAuMLMA==
X-CSE-MsgGUID: IijWf9yfQIC9NYX6qqchgQ==
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; 
   d="asc'?scan'208";a="181979590"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jan 2024 05:20:54 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Jan 2024 05:20:49 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Mon, 15 Jan 2024 05:20:45 -0700
Date: Mon, 15 Jan 2024 12:20:09 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: <stable@vger.kernel.org>, <patches@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <torvalds@linux-foundation.org>,
	<akpm@linux-foundation.org>, <linux@roeck-us.net>, <shuah@kernel.org>,
	<patches@kernelci.org>, <lkft-triage@lists.linaro.org>, <pavel@denx.de>,
	<jonathanh@nvidia.com>, <f.fainelli@gmail.com>, <sudipm.mukherjee@gmail.com>,
	<srw@sladewatkins.net>, <rwarsow@gmx.de>, <conor@kernel.org>,
	<allen.lkml@gmail.com>
Subject: Re: [PATCH 6.1 0/4] 6.1.73-rc1 review
Message-ID: <20240115-unclamped-doze-108d5c282743@wendy>
References: <20240113094204.017594027@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0ezr28PRs4Tsf82y"
Content-Disposition: inline
In-Reply-To: <20240113094204.017594027@linuxfoundation.org>

--0ezr28PRs4Tsf82y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 13, 2024 at 10:50:38AM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.73 release.
> There are 4 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Mon, 15 Jan 2024 09:41:55 +0000.
> Anything received after that time might be too late.

It may be too late, but
Tested-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--0ezr28PRs4Tsf82y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZaUi+QAKCRB4tDGHoIJi
0pL+AQDxDTyPAlv0llGnMtomfluUfHekZeRStBZ9r3iNZig6kAD+IT5T9ekWA24F
pJUIm3XHu8Y366kPx2s05pHOLfbxnAA=
=SISq
-----END PGP SIGNATURE-----

--0ezr28PRs4Tsf82y--


Return-Path: <linux-kernel+bounces-123125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FDD6890279
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3CBF2948D1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E36312EBCC;
	Thu, 28 Mar 2024 14:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="P7J32uYm"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A5C22086
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 14:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711637947; cv=none; b=q8/c3W0dvFXiOBEqYmWUYmgZJyYLqD58rpK6faBdJvpOlzcw8kD8Hx76KPpaVR3d1W3jZ+YuHgIsyLMbVTDUPQ+clMAmEVEdJMITp+L+heQxg7QHIpB66JZ1CixX4gOW+hYeKfzKZAcWN6QvOAIAsFZJDMoabP3X3RFOB+0Y0GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711637947; c=relaxed/simple;
	bh=pqcTdZsas/L2lLLi0r0tZaLc/T481Gjhve2hnITnqOg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HTLGv3cV7B2B1UNN0+LP5vuYt10it/Q7UePKIWFvNMplrB4og0t/MFx7ZO9IdRSApeFh2E3DMQNrIfigHSZjoNy6yovMRbe1Jic8xVlsFSx/7xOn6fqWeSJMr8alv4nbhZkNEqORrkZraggKd795EfekxGE/qdlk5Hr0X6UOJGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=P7J32uYm; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1711637945; x=1743173945;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pqcTdZsas/L2lLLi0r0tZaLc/T481Gjhve2hnITnqOg=;
  b=P7J32uYmKLn+d2GvrhWvLtmV9erO0xdXjL5FkkON8gogFbxqum/WuR+p
   balfZv3S1DkHyukT7Qi1pyselk9lAfwrTciDsM7mSL3JU2qX4jVKTGjjM
   vIwX32MCW6HfsdL9R/pq3OWrw3qd59zA71aDzZaU2iLPBv8y6xAMuePPI
   IawtDn5WyYZ55nouOvjLftsMmRyQWOhJ5QAhgqr+tXWntQRb6T1R11e+b
   O1FX1oy3jl3cECkg1fLH90WajDGlJ3ZfWyykPHHuKrGuc6CjjszxQxxT2
   WDRT3u8Z2UOTCJH6fbgbznw40et8nvA4ugGox8z+l5WwJUDk+fJZgBJAP
   A==;
X-CSE-ConnectionGUID: aoxufTLkQWq9+1EyrDTJqA==
X-CSE-MsgGUID: owMpyAaSQPuHzpD0jAx60Q==
X-IronPort-AV: E=Sophos;i="6.07,162,1708412400"; 
   d="asc'?scan'208";a="19071180"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Mar 2024 07:58:58 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Mar 2024 07:58:45 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Thu, 28 Mar 2024 07:58:42 -0700
Date: Thu, 28 Mar 2024 14:57:54 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Christoph =?iso-8859-1?Q?M=FCllner?= <christoph.muellner@vrull.eu>
CC: Andrew Jones <ajones@ventanamicro.com>, Conor Dooley <conor@kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>, Palmer
 Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Philipp Tomsich
	<philipp.tomsich@vrull.eu>, =?iso-8859-1?Q?Bj=F6rn_T=F6pel?=
	<bjorn@kernel.org>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
	Heiko Stuebner <heiko@sntech.de>, Cooper Qu <cooper.qu@linux.alibaba.com>,
	Zhiwei Liu <zhiwei_liu@linux.alibaba.com>, Huang Tao
	<eric.huang@linux.alibaba.com>, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH 2/2] riscv: T-Head: Test availability bit before enabling
 MAEE errata
Message-ID: <20240328-issuing-crouton-3448aba81b64@wendy>
References: <20240327103130.3651950-1-christoph.muellner@vrull.eu>
 <20240327103130.3651950-3-christoph.muellner@vrull.eu>
 <20240327-imperfect-washbowl-d95e57cef0ef@spud>
 <20240327-77a6b64153a68452d0438999@orel>
 <CAEg0e7jyGZV3+04HNYzgfHMGYT9wV_c0A=ekpCRi3L-5yjxK=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DnbhxEf6LbaydUMs"
Content-Disposition: inline
In-Reply-To: <CAEg0e7jyGZV3+04HNYzgfHMGYT9wV_c0A=ekpCRi3L-5yjxK=w@mail.gmail.com>

--DnbhxEf6LbaydUMs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 03:18:22PM +0100, Christoph M=FCllner wrote:

> Switching from th.mxstatus to th.sxstatus should address all mentioned co=
ncerns:
> * no dependency on OpenSBI changes
> * no break of functionality
> * no need for graceful handling of CSR read failures
> * no need to differentiate between HW and emulation (assuming QEMU
> accepts the emulation of th.sxstatus)

Yah, th.sxstatus seems ideal here, provided it is accepted by QEMU - but
if they allow th.mxstatus I would hope emulating th.sxstatus would be
okay too.

> Also note that DT handling would be difficult, because we need to probe b=
efore
> setting up the page table.

IIRC the kaslr seed is also read from DT prior to calling the early
alternatives stuff, so while it would be a bit more annoying than usual
I do think it is possible. My (naive) hope here though is that we don't
actually have to deal with this scenario though, as things like the c908
support Svpbmt as well as the maee version. For the k230 the plan is
to use both Zicbom and Svpbmt rather than the non-standard T-Head
alternatives:
https://lore.kernel.org/all/tencent_DF5D7CD182AFDA188E0FB80E314A21038D08@qq=
=2Ecom/

Cheers,
Conor.

--DnbhxEf6LbaydUMs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZgWFcgAKCRB4tDGHoIJi
0ln8AP9fysABFrgqy3Okgc9O+ecA2rywWKxbBMYuyaLnrMihuAEA6mmXJ/4phDg3
D6YcC7uR47skvTGO9rKNLSUVk0G0bwE=
=rLay
-----END PGP SIGNATURE-----

--DnbhxEf6LbaydUMs--


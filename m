Return-Path: <linux-kernel+bounces-97095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 373C987656B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 695671C21D3E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5707238389;
	Fri,  8 Mar 2024 13:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="pUolcqdL"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4C23612C;
	Fri,  8 Mar 2024 13:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709904856; cv=none; b=Fi7Hwd3d2WnFRsdXH8v3c3lVBdgbc9sqNOJQbWMt6uSvBeELdZy3TNApSfmiIQz4yp2bPTMzYlc4C/xVGkD3KWXpBw/iv3DD/Wk3PX0o4jxEZav1cZTeeGdJC6FhQcarTSz+juOaZTK9pVncK/q/zcZ+mXxqfy4ZG429aCRBJlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709904856; c=relaxed/simple;
	bh=wtzrEfjCpn2S+S3f35TVkH99zb8AiS5TmWJuuoHXmU4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Koj30o6Bdf6W4xBMLpC2+bVSA3xRk1dqTphfhSct3pg9ooWc8t5boQ2ik1F23/26kPuMn1ZRuBzJ6Jr7j2Dd+XkKSPJhW033GFAW3gPLILUVQhV2lInFaLyKFWP9NxTdCpVxMIWn1EgLhuwWU85tmrDXl1LPQRaw9mgO9YbeJ8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=pUolcqdL; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709904854; x=1741440854;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wtzrEfjCpn2S+S3f35TVkH99zb8AiS5TmWJuuoHXmU4=;
  b=pUolcqdLC4Cj+xKA2seYYw09dvpiEdJyyX+G5WIjdvgv5YfKK7wubiKP
   X0MVHL77LOWLvstaQRLdnrfedrMg9IMZSH+kOhUns02uUfgmBg/LLdoVl
   EuAfhTm16Y8cTcIHGJlAa1X9Fe90gdy8tb4jOq61gVbHNC/B+Qyh1Y8qW
   gOfpIn2HPdS/6G2Y2rqO//IJfgrKSX5GwF5yUx2b/f53gdS6nUjIZ6wth
   jQIKAgdz5gxjqG9YULWqJcb98Bp+XfQ1YImbVkwQSwsLw3BVD2wPs8/OP
   IF2Pz0iZ5/HawbQwuqPi23RxznycAtuq4Oa17tNycmd64raxBUBiD9rl3
   Q==;
X-CSE-ConnectionGUID: VD82c0PPRy2Nn/u1qslXzg==
X-CSE-MsgGUID: o6a2Q6TZS8aGv9j+QzMa4Q==
X-IronPort-AV: E=Sophos;i="6.07,109,1708412400"; 
   d="asc'?scan'208";a="184672992"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Mar 2024 06:34:12 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Mar 2024 06:34:06 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Fri, 8 Mar 2024 06:34:03 -0700
Date: Fri, 8 Mar 2024 13:33:19 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: <stable@vger.kernel.org>, <patches@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <torvalds@linux-foundation.org>,
	<akpm@linux-foundation.org>, <linux@roeck-us.net>, <shuah@kernel.org>,
	<patches@kernelci.org>, <lkft-triage@lists.linaro.org>, <pavel@denx.de>,
	<jonathanh@nvidia.com>, <f.fainelli@gmail.com>, <sudipm.mukherjee@gmail.com>,
	<srw@sladewatkins.net>, <rwarsow@gmx.de>, <conor@kernel.org>,
	<allen.lkml@gmail.com>
Subject: Re: [PATCH 6.1 000/219] 6.1.77-rc1 review
Message-ID: <20240308-unpaved-greeter-d665418b2e1d@wendy>
References: <20240203035317.354186483@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dzUFsazBGNPyODmn"
Content-Disposition: inline
In-Reply-To: <20240203035317.354186483@linuxfoundation.org>

--dzUFsazBGNPyODmn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 02, 2024 at 08:02:53PM -0800, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.77 release.
> There are 219 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Again, I'm super late here but I did test this the other day..
Tested-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--dzUFsazBGNPyODmn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZesTnwAKCRB4tDGHoIJi
0rfEAQCNKqC+fC+rw8+CbZLtht2tc29yoTm26p2VIAy31JFFdQD+Ma9jKC5Q3zB9
YfeKWtS6nxOGy0+KWn/D8m4HyFLESAA=
=8rQb
-----END PGP SIGNATURE-----

--dzUFsazBGNPyODmn--


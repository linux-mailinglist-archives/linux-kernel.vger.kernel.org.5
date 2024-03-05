Return-Path: <linux-kernel+bounces-92020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED4C8719DE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0C221C21067
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8F1535BE;
	Tue,  5 Mar 2024 09:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="o3629Gw/"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704B2535C7;
	Tue,  5 Mar 2024 09:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709632042; cv=none; b=tnWamhl38sHHQN2F5NPrxRmNQVl3ZMFXklszSmDZ5qRv2sJiK1icEL5FAlpRPLDCvWpBkE5kigrJK+1s92P3IeT6QlylODw5Bk6CNG9mwMfDceh91RnejWdd/daXsGLkHdDmOZrDmJ4KgDV1UW61lt/JwzBu47/svpz2naduYL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709632042; c=relaxed/simple;
	bh=y1XYyhIDzS15ez0qX/Cdkd6k+pQetnRrqAet7N371P4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UzoytIHOChrlwLe9WsE5Wkj0wR0O0zr3u+bvxuzKscZP/xvSgWPNGAYuiYkOUrcCKfyXM7SHtlqRvJ1sRBJlFOzlAf33qfwOp3c+eUhljDDpmO/tULiAiF9E4HcJpb2tdTIo3ktjJx9wHFXMdtKSL3BozQzW4BgWP4b9U++8k24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=o3629Gw/; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709632040; x=1741168040;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=y1XYyhIDzS15ez0qX/Cdkd6k+pQetnRrqAet7N371P4=;
  b=o3629Gw/A5wM63vV+fb3GklHlnoa7Q+v+DOIrRvYAsQFZen65DUA8OJs
   jJQvzhNPti/teewnPkbquS6ANpQH3OV9FvPD+XDxe6h8U0eZ62T4VyK2N
   uLlIlZohd28twW7+Fd7mKoD157w9hk1oq8sqjGpV49+UBT3H2sSttR/VY
   VjPh/vLdegsHIl07ULGd5CBU+gzS6iWSpyHU38VUpliaXif9Lj4S41R7o
   8F4GznVcfgdBOU0BgGugYURHcI4W3CfrGSLNsS63L1EDndzd6Fzz1fC6N
   zMka8wvn/HaEh1oIc34s6SmvtW6aISzG+ycw412f6qbGCfK7mUcdfcscL
   A==;
X-CSE-ConnectionGUID: lW9zc2JmRG+EntjK9E4bfw==
X-CSE-MsgGUID: wdNb6izESk2LJJT1AzQdEQ==
X-IronPort-AV: E=Sophos;i="6.06,205,1705388400"; 
   d="asc'?scan'208";a="247974493"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Mar 2024 02:47:19 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Mar 2024 02:47:09 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Tue, 5 Mar 2024 02:47:05 -0700
Date: Tue, 5 Mar 2024 09:46:21 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Luna Jernberg <droidbittin@gmail.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, <stable@vger.kernel.org>,
	<patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
	<linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
	<lkft-triage@lists.linaro.org>, <pavel@denx.de>, <jonathanh@nvidia.com>,
	<f.fainelli@gmail.com>, <sudipm.mukherjee@gmail.com>, <srw@sladewatkins.net>,
	<rwarsow@gmx.de>, <conor@kernel.org>, <allen.lkml@gmail.com>
Subject: Re: [PATCH 6.7 000/163] 6.7.9-rc2 review
Message-ID: <20240305-deceiver-radiated-c6656057ee05@wendy>
References: <20240305074649.580820283@linuxfoundation.org>
 <20240305-arson-panhandle-afa453ccb0aa@wendy>
 <CADo9pHg4teVS7Lt1j+gOt4G9U=dZF9G92AUK=Km6PTdURkc0pg@mail.gmail.com>
 <20240305-series-flogging-e359bae88efd@wendy>
 <CADo9pHh6fnOz7d6+WCwkKz6_T4Ahru=0YDuc6q+KNnKYqQ2gBg@mail.gmail.com>
 <20240305-squeezing-backlit-d952f4503e57@wendy>
 <CADo9pHhtugqWO19dc7qT+sDruHBP0GR+5Kpd4RXVqb21SA+tmg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+bmx2j2w/7d+nB/W"
Content-Disposition: inline
In-Reply-To: <CADo9pHhtugqWO19dc7qT+sDruHBP0GR+5Kpd4RXVqb21SA+tmg@mail.gmail.com>

--+bmx2j2w/7d+nB/W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 05, 2024 at 10:35:15AM +0100, Luna Jernberg wrote:
> Yeah sorry i did reply all in Gmail, maybe should just only have
> replied to Greg and the mailinglist sorry for the confusion

Replying all is perfectly fine. It might be harder to do in the gmail UI
than other places, but ideally you'd reply to the original message in
the thread, rather than to another reply.
Not a big deal though :)

--+bmx2j2w/7d+nB/W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZebp7QAKCRB4tDGHoIJi
0kNEAQCnlhhRCesjp71q4D2+Wp290FDhJsBj4U0j2EIs2FosgwD/amGUpoahAuw7
ISggD7lhJQIVH9XleHaAfD3jTUQpKAQ=
=T2RZ
-----END PGP SIGNATURE-----

--+bmx2j2w/7d+nB/W--


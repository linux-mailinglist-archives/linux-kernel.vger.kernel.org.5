Return-Path: <linux-kernel+bounces-142424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC9E8A2B61
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 292761C23339
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1300853392;
	Fri, 12 Apr 2024 09:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="N2Q8CcG+"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E5E53378;
	Fri, 12 Apr 2024 09:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712914824; cv=none; b=Hu7b2agH0tWMBIjx+Dg1PZdR/7XUbmE4ZjtqgsPNHhYaHg9Rb83sW24zMbkesWFRzGB29zsK1VM1B5SwuJvMft6rA27CnmLWw34rHhEcR0XhtLY9bQmsg7Em/bO6wIAz8MUgf4o0eY4qNenuCzIT7Qk/DgdbMlEMJkPd9+G3pJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712914824; c=relaxed/simple;
	bh=AyddXRv/DnT91t6B+nxCTZtHVLA1ljNAIxVGwn0e3Vk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hutN5Rz6U1WhJx6LpFrlk+83kUwWq2XV5mBQtofKrO5pM9lT4x1d49lY9s2wylPwl8zUf4wJ4qGwzi6NK4kDLWkpfRIeBInKbLOfWmurGut48nzIZ94MjNo2yYV0QL0zMjSpprvcXm487owvMpE8uRIoNzJd/2m9OaGNvoOlzS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=N2Q8CcG+; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712914821; x=1744450821;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AyddXRv/DnT91t6B+nxCTZtHVLA1ljNAIxVGwn0e3Vk=;
  b=N2Q8CcG+WSHt61QHSiIgZlntd6c+kdrYKfup268hI/TXB3SBD73Rz5hK
   mStCII/48F0Y6KW4Q0mnZ7pj8YVkzG//6txzOQ8Hd71M9sC/rJ1enFyoF
   2P/vz0JEWUOwglHBorqSlUcu3sDh8n1kgpmNULrdQNXq7chX5nRimdj60
   MQX1LU1umGJs188H8U3VkyY+bpvohleNmbC3LrVc+UKTn88fDOHeCUkbL
   DTZEEvcF0HViQlG++IMVmHSPLLx3Z7bVS6/o/9KNmJ5nHBObZTprqZvfL
   i+ulk5ID2c1BUzP6arcw9fXvu/kAx1/o7za3kIILJkgmcLv1dRjK2/KnU
   w==;
X-CSE-ConnectionGUID: yozmjWR8Rd+BhRpS7jT2WA==
X-CSE-MsgGUID: 7iK6SCRqSQyqm/KKGnCunw==
X-IronPort-AV: E=Sophos;i="6.07,195,1708412400"; 
   d="asc'?scan'208";a="187998476"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Apr 2024 02:40:19 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Apr 2024 02:40:10 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Fri, 12 Apr 2024 02:40:08 -0700
Date: Fri, 12 Apr 2024 10:39:17 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC: <wefu@redhat.com>, <jszhang@kernel.org>, <alexandre.belloni@bootlin.com>,
	<robh@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <guoren@kernel.org>, <paul.walmsley@sifive.com>,
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-rtc@vger.kernel.org>
Subject: Re: [PATCH 3/5] drivers/rtc/rtc-xgene: Add "snps,dw-apb-rtc" into
 the "compatible"
Message-ID: <20240412-rummage-superbowl-a342f179e482@wendy>
References: <20240412080238.134191-1-wefu@redhat.com>
 <20240412080238.134191-4-wefu@redhat.com>
 <86bf8248-2443-4ced-a67c-7845fef98fd3@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Ge0GmYIBWwIaJ/Yq"
Content-Disposition: inline
In-Reply-To: <86bf8248-2443-4ced-a67c-7845fef98fd3@linaro.org>

--Ge0GmYIBWwIaJ/Yq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 11:17:38AM +0200, Krzysztof Kozlowski wrote:
> On 12/04/2024 10:01, wefu@redhat.com wrote:
> > From: Wei Fu <wefu@redhat.com>
> >=20
> > This patch add "snps,dw-apb-rtc" into the "compatible".
>=20
>=20
> Please do not use "This commit/patch/change", but imperative mood. See
> longer explanation here:
> https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/sub=
mitting-patches.rst#L95
>=20
> This we see from the patch. Say what hardware are you adding?

The compatible, unless I misread the patchset, isn't actually documented
either, only the new property is.

>=20
> Please run scripts/checkpatch.pl and fix reported warnings. Then please
> run `scripts/checkpatch.pl --strict` and (probably) fix more warnings.
> Some warnings can be ignored, especially from --strict run, but the code
> here looks like it needs a fix. Feel free to get in touch if the warning
> is not clear.
>=20
>=20
> Best regards,
> Krzysztof
>=20

--Ge0GmYIBWwIaJ/Yq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZhkBOQAKCRB4tDGHoIJi
0nF3AQCpqrVUssnT4yWndlvpuzz0fOX4zka9/Ej3nX5vfZgsawEAzVtgKBzcU07+
FaxCvDk/mWbBtLR+GALH91nw0Q+wEg8=
=Cg5S
-----END PGP SIGNATURE-----

--Ge0GmYIBWwIaJ/Yq--


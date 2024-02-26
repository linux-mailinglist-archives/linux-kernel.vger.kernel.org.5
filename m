Return-Path: <linux-kernel+bounces-81090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E54867009
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F4A3283A45
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3177626B9;
	Mon, 26 Feb 2024 09:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="JxSo1t98"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45951CD32;
	Mon, 26 Feb 2024 09:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708940845; cv=none; b=Y2hEaMa4V+Yf/kLHGeu7RdE70ZBw1h7A8AZfszfU8EzbFGdanXzmwRPCgphEFEsKIUhh0TsRQttQlvycjqUU6gaG5xQEb1hUVtqXn8ENzrcWfWMKHZMd4LJreEo+tKmi/qDNsszzJsNS7pV8n7NcdGul7Yoled3BnKiZEP3TRRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708940845; c=relaxed/simple;
	bh=GUBUJnhCJ+5svJV4Frsq2xuX833M2pcxXkLKdnw/2XQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L9YGkiPeEsbJSrYsor3JsT9GLVXOUzE0OI9xulqbk298sDKTTVPfB4CIRwsk0ZqDfEwXciqYopME1+5WKJqWvvtm8sxWePkwafcd+Z3kRzjB3zCJ0TReBQw2zMaGgBfgqQSMnzOBz7odRaql5dAi1sxfWygAqApl6MwLRHFzpss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=JxSo1t98; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1708940842; x=1740476842;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GUBUJnhCJ+5svJV4Frsq2xuX833M2pcxXkLKdnw/2XQ=;
  b=JxSo1t98+6pArKhTViKwZsuKfzhAjveG6DM9ktOyY1u1Wz9MB+D+/D3A
   aD6LkeqtRYmGuWMC8jkSGiIXAYIdv/CYeQ8fToYT9D0YHenVJj3OVJ0e9
   g8WhqIH1f6yGOOB/TQDG/AP8+gjFIVC1XYMNt48DolvvWFqOI23agt7A2
   o2ddoyVAFvZQZ8mx02XToYdqwfC2QG9qj+s1T3rz5PTgvIArpKwCLkUhy
   rZdeo+l7bHWlGx/4eWjyqp3BlXfSf5ICzeQliTdy6J/m0zioPjjefU3by
   itxYQvk+dMkedUnzCDU4G4Z7NoD/bkMYj5Nk+1tEdAdq8XifNCHuEy3TD
   w==;
X-CSE-ConnectionGUID: 3TUWboU7Q1e+0wVDoOdcMg==
X-CSE-MsgGUID: Th18ok6cRYSjDiY187FfJw==
X-IronPort-AV: E=Sophos;i="6.06,185,1705388400"; 
   d="asc'?scan'208";a="16814562"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Feb 2024 02:47:20 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 02:46:59 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Mon, 26 Feb 2024 02:46:58 -0700
Date: Mon, 26 Feb 2024 09:46:15 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Conor Dooley <conor@kernel.org>
CC: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, <linux-riscv@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] dt-bindings: riscv: cpus: reg matches hart ID
Message-ID: <20240226-esteemed-bagginess-7373abcdcefe@wendy>
References: <20240128180621.85686-1-heinrich.schuchardt@canonical.com>
 <20240128-simile-endocrine-9e8af979d361@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6pjag9RV18K1QWjn"
Content-Disposition: inline
In-Reply-To: <20240128-simile-endocrine-9e8af979d361@spud>

--6pjag9RV18K1QWjn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 28, 2024 at 06:20:46PM +0000, Conor Dooley wrote:
> On Sun, Jan 28, 2024 at 07:06:21PM +0100, Heinrich Schuchardt wrote:
> > Add a description to the CPU reg property to clarify that
> > the reg property must match the hart ID.
>=20
> That is the expected usage alright. Did you come across something where
> it was not being used in that way?
>=20
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

I think I pinged Palmer to grab this, but since it's been a month and
not picked up, I've gone and applied this.

Thanks,
Conor.


--6pjag9RV18K1QWjn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZdxd5wAKCRB4tDGHoIJi
0rpKAQDtHi/6j4X2TxwcayQZ0w2Lut2Pa5wamAt/W3HRnT4ENAD/cOo9XIvgbe7q
tntBZhh1qRKSOacwcfw2GY4q5z0E+A4=
=ZusI
-----END PGP SIGNATURE-----

--6pjag9RV18K1QWjn--


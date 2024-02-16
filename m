Return-Path: <linux-kernel+bounces-68411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7EF8579E2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF9571C20E0D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3901BF5C;
	Fri, 16 Feb 2024 10:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Jh03E6CF"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B491BDCD;
	Fri, 16 Feb 2024 10:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708077951; cv=none; b=Ug7P1/8jN0DAIbOTVFizc8BDvZxz2PE+r94kF64XWWaOFJEDVchpZDaUf0XbCmdmQpGKNqHnNPiECvKSrtPl7bbEql2qwSgIKRu+jxt2AQUPvambLW+T8VmFGGv0nrLZ6nUK9z3f9EJ8dWJ3ob6sN1m+JpELG5nrOxNiM/U+zjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708077951; c=relaxed/simple;
	bh=kM4McQdbrlvkFUd7J3O0TjnOptxLjbqVBjBJWZd7Yq8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=USMgDWI2PKVAbf60+8q/jsUJbAgTVHhJpb4uMtdPCMLfxQIR9EcPFWPVX3O0HH3+6B5UzU0BWokkQur7nrww/3CPIoODUfcok3tT/f5AjFhWlFUiEhE/EQpj8hBngwlicdPuXs0OnH0EBNsCQojmEuET6sEucqgCQuuYrg49CYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Jh03E6CF; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1708077949; x=1739613949;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kM4McQdbrlvkFUd7J3O0TjnOptxLjbqVBjBJWZd7Yq8=;
  b=Jh03E6CFV72yOH9Y2ZrT8r7272xmVlsKGP85zMXvpm5fz+Lllg78/hyZ
   04FLGu330DXyDssaTUVEvZHOSKjKU7ohY0E+zJvfJhQ6Qu29xgiRdYR9z
   O1otr1tqFaFhmQMeh0j8XhVxyY549uacoKvYHgOYPi9z8NCMvM5/5yBpe
   WFE7+s+VHKX76EDMdRk/w7/jLUCArj4cOAK+nxFucJ5OpNQoqP1KGHpZQ
   gLTxkDRI8xcVccWhFVFUQOwfLhgNau/Jk6Vhu1JLB2uup/oMnes8qh9vf
   /FXrqK+4/FVxFG6qfe4a6QklNHKuL47c2dVhtF3jrTlSe8WMOJk+AhXl+
   Q==;
X-CSE-ConnectionGUID: 4OBfS/6USgiZdJ2AElfqog==
X-CSE-MsgGUID: u/igiJMkT4m9uWdPHwf08Q==
X-IronPort-AV: E=Sophos;i="6.06,164,1705388400"; 
   d="asc'?scan'208";a="16347695"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Feb 2024 03:05:48 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 16 Feb 2024 03:05:47 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Fri, 16 Feb 2024 03:05:45 -0700
Date: Fri, 16 Feb 2024 10:05:04 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Samuel Holland <samuel.holland@sifive.com>
CC: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Eric
 Lin <eric.lin@sifive.com>, Conor Dooley <conor@kernel.org>, Palmer Dabbelt
	<palmer@dabbelt.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
	<linux-riscv@lists.infradead.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v1 0/6] SiFive cache controller PMU drivers
Message-ID: <20240216-shopping-unnoticed-e73e72a0e849@wendy>
References: <20240216000837.1868917-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uE8Yv6S3YSeUaEK4"
Content-Disposition: inline
In-Reply-To: <20240216000837.1868917-1-samuel.holland@sifive.com>

--uE8Yv6S3YSeUaEK4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 15, 2024 at 04:08:12PM -0800, Samuel Holland wrote:

> All three of these cache controllers (with PMUs) have been integrated in
> SoCs by our customers. However, as none of those SoCs have been publicly
> announced yet, I cannot include SoC-specific compatible strings in this
> version of the devicetree bindings.

And I don't want to apply any of those dt-binding patches until then.
Stuff like "sifive,perfmon-counters" seems like a property that would
go away with a device-specific compatible, at least for the ccache.

--uE8Yv6S3YSeUaEK4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZc8zUAAKCRB4tDGHoIJi
0q3fAQDoiboO+13TI8qHCe6RQzx4F5yeGe9pfv/8vU4dD4QJVgEA9/R2MW2YuAtB
CvoAEqHzUltrzcqLqW/UHxTpa+QHbwI=
=MiCh
-----END PGP SIGNATURE-----

--uE8Yv6S3YSeUaEK4--


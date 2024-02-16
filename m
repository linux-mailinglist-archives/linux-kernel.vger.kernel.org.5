Return-Path: <linux-kernel+bounces-68297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C201B857853
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F63028A9B7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A827B1B952;
	Fri, 16 Feb 2024 09:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="qTNp52b6"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC7B1B815;
	Fri, 16 Feb 2024 09:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708074083; cv=none; b=V+vocj7m7ltPHmWzsdEBXEE5h8zOgPpxFAaxJ0Mi7DLfXDQq9n2NlRlEpzHNz9dSEMCijfjuVyJW8JJUq9X8fIm7rY70e2M4aWbN1EI1FgOav+QYPymvRvyq7FS2HfeoLeXTYpdD75HCM7w/dJ6UJjLKXzR9SO9YdFniQ/h84t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708074083; c=relaxed/simple;
	bh=4VUvmXl2vQzyr22bW6omoNl/se8xyRB6W/s9RNs7f8M=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BOtXPzfa7djM5yKK83dIVyaDAcQRWfuJWA5Bg7d/gcNPROaA3uvQdbaFHjNYEGNjJb/xnPSJhoH+qHAwbj4dmYS+pP8SWPyzyWj/NVhRaP4ctqgXds7wJL5RSwesZs7e2koNIhM/BZlU/HQxm00d6n7guCGSVFbhaM6Geg7jUl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=qTNp52b6; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1708074082; x=1739610082;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4VUvmXl2vQzyr22bW6omoNl/se8xyRB6W/s9RNs7f8M=;
  b=qTNp52b6k4G50gIfKyzMZJWYD9lwV0n5xQlNOmpUq2UuhJM/dGY/Mzxz
   fSEC7gGWRCukVGJJ7OhwBWQtScf33z20pA71EV6JA2tLzE8YmVfFv6dyo
   Spf8XnnmjqLELJvB1MwBIlc8588i1JG+gTfjJPTgdc7uFJ06Zxf4rhCSx
   AzRJXI+4/qk/m/bNz1LzvYT1hzzkJNSm/J4j56oBFVcIu29C30v0d5N6J
   Fhab3e8DSjsHOIM4Gv3b9ebWJqJueVtO+gImOqH4tuMYQUo5U801Kz9KA
   jpda09E5s0Uz80/1DSUuH8axsK5sVI0cEt+J7vcfb+jSg0bBTLnibkPDc
   A==;
X-CSE-ConnectionGUID: V4AMy5vTSCGqR2VTSU2Ydg==
X-CSE-MsgGUID: 1fB5pH1vRqWAptwi4dmqVw==
X-IronPort-AV: E=Sophos;i="6.06,164,1705388400"; 
   d="asc'?scan'208";a="247083940"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Feb 2024 02:01:14 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 16 Feb 2024 02:00:38 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Fri, 16 Feb 2024 02:00:37 -0700
Date: Fri, 16 Feb 2024 08:59:56 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Rob Herring <robh@kernel.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: vendor-prefixes: Add missing prefixes used
 in compatibles
Message-ID: <20240216-percolate-wooing-b5e4f6814d15@wendy>
References: <20240216025839.902288-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kMsPZaCbowEcvdGt"
Content-Disposition: inline
In-Reply-To: <20240216025839.902288-1-robh@kernel.org>

--kMsPZaCbowEcvdGt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 15, 2024 at 08:58:29PM -0600, Rob Herring wrote:
> +  "^calao,.*":
> +    description: CALAO Systems SAS
>    "^calaosystems,.*":
>      description: CALAO Systems SAS

> +  "^IBM,.*":
> +    description: International Business Machines (IBM)
>    "^ibm,.*":
>      description: International Business Machines (IBM)

These ones add duplicates with no indication of which one is to be used
going forward. Why not mark one as deprecated?

--kMsPZaCbowEcvdGt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZc8j/gAKCRB4tDGHoIJi
0jHHAP9m6zejCzScXNn4O0yHvYY6eMVkEdaoEhiGysHZGMbaOQD/cXYqCtmf0bRt
euQMpaEOCIxBgvycTmpAuYcfJH/Orwo=
=qFDR
-----END PGP SIGNATURE-----

--kMsPZaCbowEcvdGt--


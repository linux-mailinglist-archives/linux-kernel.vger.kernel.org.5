Return-Path: <linux-kernel+bounces-48410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 999AD845B8E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 367441F2C068
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC94626B8;
	Thu,  1 Feb 2024 15:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="dbsB0s4y"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05482626AC
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 15:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706801310; cv=none; b=H+xZGPM1JIHS7doMaQMAZT/sqT+w5Ni4m8COoYbAHraFFJ+tr4cw4jB9MM148AreEaicHCx8AvlaXu0vC13pi5x11jRe0Ja8moENP3FV+Xmck+75DZ0hetCC2NI7x5m3WIoUJFeQdADTk3HNDAQdRgI5GFhUgLyn7UG5bR2XzRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706801310; c=relaxed/simple;
	bh=E6HdKpIdSATrP20bipx9SvKrBN7kLgJKWEle80Dc3sE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IFLrzGvA4SUEVy4VXbEGyf5VmzFRvWeNRrdfX3QJumd1NU0rJid6Ze2MLhviUIsTgkOqf5YvTI8AOeoad7NgR4TyvDr9Dlv1nRDewSg+G41kI+NjlD3NxJHDbXOrhEb7Di52majqoHbPcKJJCBZ+3mrPEP0ndKbhAh0+yJ7NuJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=dbsB0s4y; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1706801306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=26SIQ5pnUVxGBuzI6N0P1NMwW5cCHuoQn92ze0+AFsQ=;
	b=dbsB0s4yLvfcXftjxVr1PtbRs0QgJobNiO59PIQlR+5vqDeS6MwE3KDheQe7Zeo/6jj9Wu
	3YYkWz02yT5UvIE6dYU778APsSZ3OoLjiw2acfpe6EN01sFNvUpeSrL9WCuwQ7DKzvVNL3
	TPT83bfEyHiowg7jkGq16z+gZOX95kRZ2T6KvX8sKvgryAaTlZGnuhBVcZpDNzM/RHvOGv
	4/CZVqJC3FKT9xqUgVCBSIcnoNPNHdQzMlaMeEzMw2mqMwUxCbwJIRXSNEwJOKrXBBIN8r
	hxvCJau/xkmanotkIlFn8oAO33+ZY43btxhwKWKJUXJ3S3dKTANUGpCdb6Y4Sw==
From: Diederik de Haas <didi.debian@cknow.org>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Sandy Huang <hjc@rock-chips.com>, Mark Yao <markyao0591@gmail.com>,
 Segfault <awarnecke002@hotmail.com>, Arnaud Ferraris <aferraris@debian.org>,
 Danct12 <danct12@riseup.net>, Ondrej Jirman <megi@xff.cz>,
 Manuel Traut <manut@mecka.net>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, Manuel Traut <manut@mecka.net>
Subject:
 Re: [PATCH v4 4/4] arm64: dts: rockchip: Add devicetree for Pine64 PineTab2
Date: Thu, 01 Feb 2024 16:28:15 +0100
Message-ID: <13234147.MA61SxHe9P@bagend>
Organization: Connecting Knowledge
In-Reply-To: <20240127-pinetab2-v4-4-37aab1c39194@mecka.net>
References:
 <20240127-pinetab2-v4-0-37aab1c39194@mecka.net>
 <20240127-pinetab2-v4-4-37aab1c39194@mecka.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1794107.V1UpVPejRP";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Migadu-Flow: FLOW_OUT

--nextPart1794107.V1UpVPejRP
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Diederik de Haas <didi.debian@cknow.org>
Date: Thu, 01 Feb 2024 16:28:15 +0100
Message-ID: <13234147.MA61SxHe9P@bagend>
Organization: Connecting Knowledge
In-Reply-To: <20240127-pinetab2-v4-4-37aab1c39194@mecka.net>
MIME-Version: 1.0

On Saturday, 27 January 2024 10:48:45 CET Manuel Traut wrote:
> This includes support for both the v0.1 units that were sent to developers
> and the v2.0 units from production.
> 
> v1.0 is not included as no units are known to exist.
> 
> Working/Tested:
> - SDMMC
> - UART
> - Buttons
> - Charging/Battery/PMIC
> - Audio
> - USB
> - Display
> - SPI NOR Flash
> 
> Signed-off-by: Alexander Warnecke <awarnecke002@hotmail.com>
> Signed-off-by: Manuel Traut <manut@mecka.net>

Everything seems to (still) work, so:
Tested-By: Diederik de Haas <didi.debian@cknow.org>

Thanks for submitting this upstream :-)

Cheers,
  Diederik
--nextPart1794107.V1UpVPejRP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZbu4kAAKCRDXblvOeH7b
blXGAQDP5qENxaN5dIVjBieTyOlY8fPPngqtXwFL4vkEdreqjQD/b48bb1yvUxQr
vS2R3FNuHLcDSnHLKoxjZg+592xUfAU=
=5fTJ
-----END PGP SIGNATURE-----

--nextPart1794107.V1UpVPejRP--





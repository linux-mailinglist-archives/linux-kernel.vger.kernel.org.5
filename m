Return-Path: <linux-kernel+bounces-9920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5F181CD41
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 17:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CD72B21D7D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 16:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA272554C;
	Fri, 22 Dec 2023 16:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="OoTtPvha"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE2425542
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 16:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1703263903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5pp9nMgujJn+Cpq3o1955F8zPLtLYZQipTve8oj6tc8=;
	b=OoTtPvha9uyqsBUq/zsp/Mn1p45thuXKeug1rXypmg8foySIO6I4Y1i1wTJf6uuPUsuxvu
	rErQxsnFBRVH9OXK5B7AcNHQRNKAu86CrSEHIrxvUi9NiDOIZWV3OkccPZi9aYQnbJ7uCi
	9Q91rM0EKTl/Q4IQkYe3w0AE0XnWd6eMFcdM+hlUm/bkQ7Ttf2frhOZKkj+q3XK9vcrV4j
	mu310rciAwIJ+RO/q7TKloG2IIjcz2TU5V0fMnosxdYpxiY5ojGVxChHpyPT5yphfd0OuN
	U9lHSEJ9AkEJtd1P7RUgQ4NUtsvZUJX2YLtazQGtwj/fBlJmLvu29ylq27dzgA==
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
 Manuel Traut <manut@mecka.net>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, Manuel Traut <manut@mecka.net>
Subject: Re: [PATCH 0/6] arm64: rockchip: Pine64 pinetab2 support
Date: Fri, 22 Dec 2023 17:51:41 +0100
Message-ID: <2631715.l0DajZZ3Y3@bagend>
Organization: Connecting Knowledge
In-Reply-To: <20231222-pinetab2-v1-0-e148a7f61bd1@mecka.net>
References: <20231222-pinetab2-v1-0-e148a7f61bd1@mecka.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2286417.7pCFYIXMvo";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Migadu-Flow: FLOW_OUT

--nextPart2286417.7pCFYIXMvo
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Diederik de Haas <didi.debian@cknow.org>
Subject: Re: [PATCH 0/6] arm64: rockchip: Pine64 pinetab2 support
Date: Fri, 22 Dec 2023 17:51:41 +0100
Message-ID: <2631715.l0DajZZ3Y3@bagend>
Organization: Connecting Knowledge
In-Reply-To: <20231222-pinetab2-v1-0-e148a7f61bd1@mecka.net>
References: <20231222-pinetab2-v1-0-e148a7f61bd1@mecka.net>
MIME-Version: 1.0

On Friday, 22 December 2023 12:05:40 CET Manuel Traut wrote:
> [3]
> https://salsa.debian.org/Mobian-team/devices/kernels/rockchip-linux/-/blob/
> mobian-6.6/debian/patches/display/0018-drm-panel-add-BOE-TH101MB31IG002-28A-
> driver.patch?ref_type=heads 
> [4]
> https://salsa.debian.org/Mobian-team/devices/kernels/rockchip-linux/-/blob/
> mobian-6.6/debian/patches/device-tree/0134-arch-arm64-add-Pine64-PineTab2-de
> vice-trees.patch?ref_type=heads

FWIW I believe the actual sources are from
https://github.com/TuxThePenguin0/linux/commits/device/pine64-pinetab2_stable
--nextPart2286417.7pCFYIXMvo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZYW+nQAKCRDXblvOeH7b
br9kAP9lep8IEbNMNDxvFBfaIg1bqdTUIItkkqVnhx+sEs2xjgD+NLX/sy1F2zYq
tihWEexfx2PMq2zU2Xz+xGm2AJuoww8=
=2R8f
-----END PGP SIGNATURE-----

--nextPart2286417.7pCFYIXMvo--





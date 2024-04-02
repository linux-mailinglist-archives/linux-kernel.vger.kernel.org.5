Return-Path: <linux-kernel+bounces-128338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46ECF895979
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7825E1C204F8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DC014AD31;
	Tue,  2 Apr 2024 16:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OgV42Odl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9F714AD1D;
	Tue,  2 Apr 2024 16:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712074618; cv=none; b=b+KCy00YzUOfHPcs1fDZWXKqbKShp1TKm9//D3dbrsIdmPFYxGF5kdkAPndDcfrbdSseZUkcBAyjAnOQGFbINwQuObsMyTArphZN+mDhIb+BP0oB90NZRP0BkDw04sho1vSFW1yeDAc2eCod/Hyqal6aTAEqwsUHfc3BfyJ9VmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712074618; c=relaxed/simple;
	bh=PchHI2A+NwENZcjJHFtNCVWD8ogUwOGOGHd00vtDQ3c=;
	h=Content-Type:Date:Message-Id:Subject:Cc:From:To:References:
	 In-Reply-To; b=i9uOCQfFMWaWh0n476duzY3f1ngSmsq2EguhEiCcR83X4aqrV7g766uViitNcXWUobguG1IQHjE8ggfQXdoUGVLaDUtwMLgjJpNMl9vuV/0tziv8poUbpInEfb+wNOGmqq0BnpvtwYCbMz3t2fcJkvckk5WiEkk7XwH/yIJHyFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OgV42Odl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5345BC433F1;
	Tue,  2 Apr 2024 16:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712074617;
	bh=PchHI2A+NwENZcjJHFtNCVWD8ogUwOGOGHd00vtDQ3c=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To:From;
	b=OgV42OdlKdcQ2jiBc/XminuT7Sxl0ciVxGUVJh/nHGiBx9c1Qv5tKrDV7jyLkRYE8
	 O/qN4tm1/YHaDapVVRB8mO8RMfoRNgU9DQR1xxkqCDcyaXiQLhurZbf65a3S0pv7vD
	 ZbfrnXh2TfVPYAHmCMJ4o2bxk1Tm2BxNPh8wHRDm9IM9MWTaFxqfz52LcvRGu0+ytR
	 bhVCnzU7WKLur/bo8lsD7NP7tbDhKyVqNDflKPiWVN1UxNc0kx48XPeCuk3sBXxr0m
	 2Mvz+njjezjj7uq85zCdn6taRNSZEXB0iKMoJcqR+7/rTYPxx+8FpFVcflwKTEgnNm
	 lqq9682dXwuTQ==
Content-Type: multipart/signed;
 boundary=4163084cc76496901a0e40922461ef7e1ecf8a78c2cef44f7c7839b8c28e;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Tue, 02 Apr 2024 18:16:54 +0200
Message-Id: <D09RSRPKV9L9.2TS01DA84TEKK@kernel.org>
Subject: Re: [PATCH] arm64: dts: ti: k3-j722s: Disable ethernet ports by
 default
Cc: "Vignesh Raghavendra" <vigneshr@ti.com>, "Tero Kristo"
 <kristo@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Nishanth Menon" <nm@ti.com>
X-Mailer: aerc 0.16.0
References: <20240402151802.3803708-1-mwalle@kernel.org>
 <20240402161306.tkg35heqlwqxoaua@another>
In-Reply-To: <20240402161306.tkg35heqlwqxoaua@another>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--4163084cc76496901a0e40922461ef7e1ecf8a78c2cef44f7c7839b8c28e
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

> This is better at arch/arm64/boot/dts/ti/k3-am62p-main.dtsi.

I'm fine with that, but be aware that we'll also change the am62p
SoC dtsi in that case.

-michael

--4163084cc76496901a0e40922461ef7e1ecf8a78c2cef44f7c7839b8c28e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCZgwvdhIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/i9fwGAlbBSVEpNLqQlL6c6MqSNaNQEPWXE5RHF
wGXxAqEraPrwnm0Qeq4pkYvQhhUIr83gAYDYFVjKdJXoXr2Zhc5/ANw4ktMrtrbP
G65c5Zpos9VkD9RT+mr0JKAa5dBR2+X0hpI=
=5lG9
-----END PGP SIGNATURE-----

--4163084cc76496901a0e40922461ef7e1ecf8a78c2cef44f7c7839b8c28e--


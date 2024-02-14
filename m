Return-Path: <linux-kernel+bounces-65783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 768F5855234
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3661B2F6BB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885B212BF1D;
	Wed, 14 Feb 2024 18:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DCXwpPhT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C832412BE9D;
	Wed, 14 Feb 2024 18:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707934231; cv=none; b=OgxPM3259nwrbKY/lTH1w6BVrIplAvNPOd45TyFhvIvtWC6HzgEyHs8D09g8A5EMywLRFV0wiUkuCEgySR4xv9pvGtytn8BfEDIGHkIzV04o9x5jB/IU3bIEkDmlpRqTCGPoB6UUPHr21u6OF1ucy+9qnyhh9sAzNueEokBf5SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707934231; c=relaxed/simple;
	bh=bCCGgn+cpKHU5JFXR2s9+uZ+k8e1qm+nuyp7hb6VGn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DACo+r4fwOtIlP1uprUZ/7Kfu8pcEzbZYCdkixBHmN+y1oYkQBVXu3AZaJRPdGp0or/XN1wiTmn2FzaPa8EU2cnBto/I337ijPfQLFbxN1Z4Kcv2VUvOurJXoruqaj/cRh0j4GwWfBxnFaAeiCqiodEZ09IKlCYytGG1v2phckw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DCXwpPhT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76FDAC433F1;
	Wed, 14 Feb 2024 18:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707934231;
	bh=bCCGgn+cpKHU5JFXR2s9+uZ+k8e1qm+nuyp7hb6VGn8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DCXwpPhT/NKoQfWRmmbBUxheorAiKdzTz4qu02bcQfbFMZEahwkAmz9j7Ew6fal1z
	 36QF49gHihoDjpV41J+CQ8OUAfQtLqMLENRSrW4n1MPl5vEXGHBeYs9yvSE5ITdlQw
	 1zL91DiOphomMkWJkynKI28nbL35GXhJygfU/FSFRjH2nmjJVYJxuVmUJfLxZUXeGJ
	 gK7eD+JzIAJpYUC70htRLMq8Q9Y9pwOyGaXa8Iq4o1k/iBJHKwLdoy+OKczAWgy1t+
	 RVVFSnJmhk8mz1blrugMg295JNWOckCQGCYedAfJhxZaHjFLnY8jeQInBi6N+11Hx6
	 qmB76bmfB3lUQ==
Date: Wed, 14 Feb 2024 18:10:25 +0000
From: Conor Dooley <conor@kernel.org>
To: Kevin Hilman <khilman@kernel.org>
Cc: Bhargav Raviprakash <bhargav.r@ltts.com>, arnd@arndb.de,
	broonie@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org, jpanis@baylibre.com, kristo@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
	lgirdwood@gmail.com, linus.walleij@linaro.org,
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, m.nirmaladevi@ltts.com, nm@ti.com,
	robh+dt@kernel.org, vigneshr@ti.com
Subject: Re: [RESEND PATCH v1 03/13] dt-bindings: mfd: ti,tps6594: Add TI
 TPS65224 PMIC
Message-ID: <20240214-canola-strongman-69b7fc90bd31@spud>
References: <20240209-blitz-fidgety-78469aa80d6d@spud>
 <20240214093106.86483-1-bhargav.r@ltts.com>
 <20240214-galley-dweller-1e9872229d80@spud>
 <7hil2r5556.fsf@baylibre.com>
 <20240214-depraved-unfunded-3f0b3d6bf3e2@spud>
 <7hfrxu6i0t.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aEtsIK1cbYXVAH0m"
Content-Disposition: inline
In-Reply-To: <7hfrxu6i0t.fsf@baylibre.com>


--aEtsIK1cbYXVAH0m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 14, 2024 at 10:02:42AM -0800, Kevin Hilman wrote:
> Sorry for the noise.

nw chief

--aEtsIK1cbYXVAH0m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZc0CEQAKCRB4tDGHoIJi
0p25AQDihDMz1ib1pvi6dgCUIRsPT6mndLgVz01AxshTU471VwEAllyu+KCTnixG
yvV3pEm+PwEJN3mWqucoVYApQXhgRgM=
=QOTA
-----END PGP SIGNATURE-----

--aEtsIK1cbYXVAH0m--


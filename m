Return-Path: <linux-kernel+bounces-105425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0430C87DDB4
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 16:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98F0C1F213B5
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 15:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2301C680;
	Sun, 17 Mar 2024 15:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFlbMl1t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F8F1BF33;
	Sun, 17 Mar 2024 15:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710687672; cv=none; b=WAHN5XwzF5At+yqjSUimyLQ5Yde4+a2CJ0RcwJKEgifdlMxH5MVmK/eByps4QMzh6YjE0R7nfu1vlvlv6tMhw09mqTIQhp8n1r4LJDo17KGrWuSBWhiEBYa+o8/nMHDWVEFMY0B1Qmt58sXw0eoSodCjht0J0+bHZdzsFhdBq14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710687672; c=relaxed/simple;
	bh=j7oxe8BD+mVFzgrsY6JafuiQy9oGRRV5ZitHBwsWITs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PTVQXCTj1Ji+AN99lVvogp272cbTnnES2vT7WYvjTd0ELROLhzpLmQwDfP/CbZvzcnhBFh6fhZjYAiUWOGe6vcgBW3EpiBCNBzeqrzF0+bN7HI0KNzEb/zTiRzQKnnqS1d4zmpX2nOkZCRZM65AAOo03qUQQFPduxzE1h16eg8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFlbMl1t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6A81C433C7;
	Sun, 17 Mar 2024 15:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710687672;
	bh=j7oxe8BD+mVFzgrsY6JafuiQy9oGRRV5ZitHBwsWITs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UFlbMl1tlfTfjCd9+pkxYpxlH5lOdt81iI7gKF6qORgShqzS3QzddQ3IosuKMXCZK
	 hJ/jYKZyEBOi/WONqsV4EswpVnEfSaM/bg3YvvQSwFdWUvKuJkgQaw0T9vb9IcYw7x
	 Uk2QxK4ss5jT9T8RatnMPUupjgglURpWSNR3q5/Id7jhnZ6oBoYmi/ceStU6C3Tics
	 5807V7kuwXgf6yPli2elDOdg2ueJcNeAfq0sM2RzZ+D9F1E4MMz3UamLIeyKOKcfJ1
	 2c7RH+UvUt4vx3n9Vrt23DA0oaEROlNlc3SeOKo6mdFCm2DfG8tbVWEC/41KtgZ+t8
	 1/Mn0r7lbHC2A==
Date: Sun, 17 Mar 2024 15:01:05 +0000
From: Conor Dooley <conor@kernel.org>
To: Joshua Yeong <joshua.yeong@starfivetech.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	geert+renesas@glider.be, prabhakar.mahadev-lad.rj@bp.renesas.com,
	conor.dooley@microchip.com, alexghiti@rivosinc.com,
	evan@rivosinc.com, ajones@ventanamicro.com, heiko@sntech.de,
	guoren@kernel.org, uwu@icenowy.me, jszhang@kernel.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, leyfoon.tan@starfivetech.com,
	jeeheng.sia@starfivetech.com, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 0/4] Add StarFive's StarLink-500 Cache Controller
Message-ID: <20240317-viral-handcraft-12b2519ff1be@spud>
References: <20240314061205.26143-1-joshua.yeong@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rsMLDVhBuM3yu4xb"
Content-Disposition: inline
In-Reply-To: <20240314061205.26143-1-joshua.yeong@starfivetech.com>


--rsMLDVhBuM3yu4xb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 14, 2024 at 02:12:01PM +0800, Joshua Yeong wrote:
> StarFive's StarLink-500 Cache Controller flush/invalidates cache using non-
> conventional CMO method. This driver provides the cache handling on StarFive
> RISC-V SoC.

Unlike the other "non-conventional" CMO methods, the jh8100 does not
pre-date the Zicbom extension. Why has that not been implemented?
How many peripherals on the jh8100 rely on non-coherent DMA?

Cheers,
Conor.

--rsMLDVhBuM3yu4xb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZfcFsQAKCRB4tDGHoIJi
0t+UAP0Rd8gYpX+LqpilA/FjT0qP/H3kHE7pBMNt8b8513mNewD/W/chQLnb9a1Q
8T5MbISfMDawti8Fb7AVnmgEL4o8zQo=
=cPlm
-----END PGP SIGNATURE-----

--rsMLDVhBuM3yu4xb--


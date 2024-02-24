Return-Path: <linux-kernel+bounces-79803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF9B8626FB
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 20:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BCD52823C4
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 19:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B044C600;
	Sat, 24 Feb 2024 19:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vKfy/F+8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E9AC2C8;
	Sat, 24 Feb 2024 19:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708802437; cv=none; b=cFt6VdQXv82YE5Y02Qa7fygNX5FltME7e5oRhcKVyNe/PqYPGksxusuX+F8zRsLcNRNaH4vOPvEjIio+mIjZcJyR6/biTb9vq3ktPBW6K7ZGVRo97rEoAm+3Tu4O9b7vaGBafgwxUUaHtiPMuF3u8Dvcn0r5QKWDF7LE0jM2ufM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708802437; c=relaxed/simple;
	bh=WCpuxvpHdc+sHl7FJrxaAQVhwIuaoeB4DsjQcbC1SdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jK6ZaUF9yhWvzLMyQ5M2/89z7OtTQ+oh+VYlCYlMjXjlC4tF9uePb3gsP+XhXDfkGeqZSJDvMGIOFupZxTGRWREyS8y77Xl52fPGKdcAuVbu+P/bi6CXjxwEvnmci0WI3i2jgWtShqe5guq++T9G35gcd//3bnya8LLjiFWNk4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vKfy/F+8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6DB1C433C7;
	Sat, 24 Feb 2024 19:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708802436;
	bh=WCpuxvpHdc+sHl7FJrxaAQVhwIuaoeB4DsjQcbC1SdE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vKfy/F+8pDe2O0ayhIaMbRw0fDwN9SlFrnRzUbh2JiiUwcCca2kO8MPCX7Hl757oD
	 RGOSmhkKu6tp2VNFKyBK4xeDpOUCEt9N8xv+zazgGLUT4/MgkVXSg2YZGGSyUXnx6X
	 mvuwMv+omkiHjGgt2arauE7k4RyrbKkewY3oCQPu0Mhot1KowwQpkbTMPMXZ01DRcM
	 O290Yf+7sA5i/h2BGZpnz+v+2m+OjJw/H8UQCtuVnqWh9mSkmWGNZ8gKy9CQY5lxRp
	 xoOj3YvAGi0GbbdXedDRttC0ROcs4Xs5PDlVSBwRmmIpxZYqJnvc7GML+Y9LfyC02b
	 7CaDDfe3v00DA==
Date: Sat, 24 Feb 2024 19:20:30 +0000
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Alex Soo <yuklin.soo@starfivetech.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Hal Feng <hal.feng@starfivetech.com>,
	Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	Jianlong Huang <jianlong.huang@starfivetech.com>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Drew Fustini <drew@beagleboard.org>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [RFC PATCH v2 1/6] dt-bindings: pinctrl: starfive: Add JH8100
 pinctrl
Message-ID: <20240224-smudgy-eldercare-d5d8640d9961@spud>
References: <20240220064246.467216-1-yuklin.soo@starfivetech.com>
 <20240220064246.467216-2-yuklin.soo@starfivetech.com>
 <1a11cee2-2ef1-4ce0-8cc1-63c6cc97863f@linaro.org>
 <20240220-bottling-reverence-e0ee08f48ccc@spud>
 <cafccf8d-b8f7-44cb-bc41-3c7a908fd1e4@linaro.org>
 <20240223002443.GA3877354-robh@kernel.org>
 <caea26e2-6598-4796-b199-4ee5b1b9cd30@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4X+rCrj80xZryIi8"
Content-Disposition: inline
In-Reply-To: <caea26e2-6598-4796-b199-4ee5b1b9cd30@linaro.org>


--4X+rCrj80xZryIi8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 24, 2024 at 09:46:53AM +0100, Krzysztof Kozlowski wrote:
> > I would like a solution though. The only idea I have is passing=20
> > SystemReady cert, but that's an Arm thing.

I don't know jack about SystemReady - I had it in my head that it was a
system level certification. I am wondering how you think that
SystemReady certification would apply to a whole binding (I can see it
being a per-compatible thing, but that would be a mess I am sure).

--4X+rCrj80xZryIi8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZdpBfgAKCRB4tDGHoIJi
0tshAQD22weCRiyyz1UYMsSBhqsXWD+BLcY177azkS6FHp3EngD5AXLAtkUf/BSe
yPwvAzi01dGGRR6R9okzKdRy4Ln10QQ=
=6nkj
-----END PGP SIGNATURE-----

--4X+rCrj80xZryIi8--


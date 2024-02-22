Return-Path: <linux-kernel+bounces-76309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9373A85F57D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19D41B24FAE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076673A8C9;
	Thu, 22 Feb 2024 10:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3qgITIen";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TZ+jyXJp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EC939FC7;
	Thu, 22 Feb 2024 10:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708597118; cv=none; b=F4gj+ZXuwvsK3jJM8AHUgc+5uU0UGnMqL3NEXzdb4GBuJV2FqegKxk28ec5yNG5EPvm/zPHYaSEtmBRFM9clBG5KRWNVSztRwEhZfwDQdnyEirDPFwy89hq47vOETaoez+huxfDF523PfPb7l4JZMlPpGFD+toATBPyJQa5uQR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708597118; c=relaxed/simple;
	bh=af17vFA+XR0PLVSDztuSWa2TbDGEHKWUkQWkSMZboyo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=COSfg19d5f56X22UHCEGz9vyYSgMLygy7cGHP8sv9b5awDEgKdQ3fmIj4y5SAr7TPtugSluyBpc8+SiH5Rn0uLjF5OrvP4LNf6xa30HPKl0AorrKRwvgKqR2sZaqSy3yUEjA40KZUBMygqlbDbNrXHIjJqiaS9LHXJrr/VqBMlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3qgITIen; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TZ+jyXJp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708597115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=af17vFA+XR0PLVSDztuSWa2TbDGEHKWUkQWkSMZboyo=;
	b=3qgITIenivVJDEfsgXlDnVaO8ihsP7cjE+l+89ikE3tZsXtzMFglAoQJ4XTCsjc3Bn+Ak3
	I/8JSIqEkduAsTMgsUQDaaruPiTeA5V6xtlQ4d1XYecW01D8h8/QAqTFV13Cy0I25+yf0M
	970TfJOdkHbzecg/VNYX8B/uC8skUg7ZlA/Mbf2fDKhOUyI3fdJCO58AqAPqk6+0gE5/0i
	93Ju3DPLyN+j5y8TnC4xokeoJcTNULX/au6ZP0/yHD569EsxCi1QVWLpwzWn+BCe2akj7o
	4Md8R2oyWVZXbg4LYDPNsjSGge9hAlJdAM3i4NVV8ynyta5HChClSOnegMZ5gg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708597115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=af17vFA+XR0PLVSDztuSWa2TbDGEHKWUkQWkSMZboyo=;
	b=TZ+jyXJpIAX6ztCb0kRdlAbld1WAkSq07gQbwTdprN//TSEisBt28LHuNkZ4E5gbQUaYA+
	GcIlL2DSCe3dZIBw==
To: Arnd Bergmann <arnd@kernel.org>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] igc: fix LEDS_CLASS dependency
In-Reply-To: <20240222100324.453272-1-arnd@kernel.org>
References: <20240222100324.453272-1-arnd@kernel.org>
Date: Thu, 22 Feb 2024 11:18:33 +0100
Message-ID: <87y1bcajk6.fsf@kurt.kurt.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

On Thu Feb 22 2024, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> When IGC is built-in but LEDS_CLASS is a loadable module, there is
> a link failure:
>
> x86_64-linux-ld: drivers/net/ethernet/intel/igc/igc_leds.o: in function `igc_led_setup':
> igc_leds.c:(.text+0x75c): undefined reference to `devm_led_classdev_register_ext'
>
> Add another dependency that prevents this combination.
>
> Fixes: ea578703b03d ("igc: Add support for LEDs on i225/i226")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Ops, sorry. I tried to build all different combinations, but obviously
failed. Thanks for fixing this.

Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmXXH3kTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgpgsD/wL4ALVODXchFjqCM3M42Q/Cc903SsI
C1OkwJfeXL9PHV3NRF/st5Xb9C4ijdRlvOqKe9uoGFv2Hj0vV4cXMXqeOzgHIHLp
Ka0GPGR2yYJF2l1rzXepkLVKAKkUP/UDq97rOtV8q5Z4dLcvxLOCx+HPnKV3Eo+Q
eumqHTx9BUmgrXq0ji/Z9t2AqvUoYOgJpw7BO/mQpyUCm55rwYKwJ0FCuD+7Fjfv
wTW3RhkKOSSCK3AAIXporCITQr07ZxYaNEnOfPPI/xYoNgCkBIvjovPq4ghTPWm1
Rja3kmLUOmMG0nq2mvJeUzJSuaJWL6hnngk3FaJH9QbDN5fIBdTbGY9Mr5VmoCqO
JRYcdPym5xI57ahcCtZXK9YFtUpO8FWCUAVW7pXYL+owkNtBmo2odVrhgW2fozAi
EhO3X9/5AUOjBb9WonmnOe5o3pWWT3vO/ez3f5GaWuDZ74n6u34XIC9enlrI4Z4Z
zixs1ElctrE8fll+TNraf8SQ7o3V71HTadXKgjB0tszDqn/a8Q2jxxLfP9rMTwP6
UDUrpgbHBlw2SjbINMDOkRvTbEX1wgYc2Gw7z5svwGwkeyWHDy9lHz82NGaPafxF
qlannbnjglAp6LO+A6iy8KQEkeSN/8fZpJr2rW4yjTW+WmDkHMPxbNHpLcNeth28
g38yKoe48d7Ldw==
=yN6/
-----END PGP SIGNATURE-----
--=-=-=--


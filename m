Return-Path: <linux-kernel+bounces-55315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4397684BACB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB62A1F2521F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4781B1353E4;
	Tue,  6 Feb 2024 16:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MrodTBgO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742EB1350EB;
	Tue,  6 Feb 2024 16:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707236564; cv=none; b=i3GJgsLuxgBCv9lFmosFZn+QVPXgufhsxK45PoVJmZFwYQFeRtYFv27s2o+Kg5KfayQ4d8wR90tE38TkR4gJQfdBxP2WDKm1cjVCtrGWNl8C9EAZkZFHeUenaZ9T5J14jFYLnWQPwrJfos/UzsO+PDcmk37G/2AQaYyuAzdK2rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707236564; c=relaxed/simple;
	bh=KJ0tC6AYLto0c9nvm5TeupoYIt+wLpWcfBirBcMc89E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ddhh384g7TiYRaiIcKvxwMM96f8QWXXCJ+vFhXKU91gyLnq6dMAvnNjv1GGW22T/zH1Ys2t0dzJgkECCBlsxwqyhqIqZ1m8rv4jtP982MJnUXVLavrVjPdKsjFkCooXBqE9XTy2g5NGMdA/4Rxved1ZfaROR2PseOk/cwxbPxbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MrodTBgO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F306C433A6;
	Tue,  6 Feb 2024 16:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707236564;
	bh=KJ0tC6AYLto0c9nvm5TeupoYIt+wLpWcfBirBcMc89E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MrodTBgO7BcAPmmQrUC7NLTnQFj5LXXjbOnIjbdn8KM6fym7v73kzrkqETfdxg5Y2
	 j3VRvnb+iBCYD4n6UGPGrz4IIWc8tAgx9rEGUyd6bvBy0MgsjyGMepp2ZPaA3xnaWj
	 AOnRTrwwppYhRX2QI7GHyM4BWVijkQx5as6smAGtGpLEcp/YjzbN6b5wd0RbVDdo9M
	 1YBHPxSGhX5T/hB4ycpcIol1dLQAiiCfbhhBWJqwhqyBySOtV32Is/7z2yKBBpsAZp
	 LDPaKiBpTsIGJxvmd9iPw1dsbvvst+lpQgGnZBp5yDK1tSiriITF3gY8McIltkOBP2
	 GCzS5sRFwE3Ng==
Date: Tue, 6 Feb 2024 16:22:40 +0000
From: Mark Brown <broonie@kernel.org>
To: Javier Carrasco <javier.carrasco@wolfvision.net>
Cc: Matthias Kaehlcke <mka@chromium.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v3 6/7] ASoC: dt-bindings: xmos,xvf3500: add XMOS XVF3500
 voice processor
Message-ID: <ZcJc0JVr0nOGYK0B@finisterre.sirena.org.uk>
References: <20240206-onboard_xvf3500-v3-0-f85b04116688@wolfvision.net>
 <20240206-onboard_xvf3500-v3-6-f85b04116688@wolfvision.net>
 <ZcJDFi+iIQOWzgYw@finisterre.sirena.org.uk>
 <7b472cb2-6658-446a-ae47-411d08798cca@wolfvision.net>
 <ZcJOrvmbukDubcuM@google.com>
 <42106e0c-109c-4ba2-a703-f95df92db5e3@wolfvision.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5oDTt8oCWPvri2Kt"
Content-Disposition: inline
In-Reply-To: <42106e0c-109c-4ba2-a703-f95df92db5e3@wolfvision.net>
X-Cookie: You might have mail.


--5oDTt8oCWPvri2Kt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 06, 2024 at 04:35:54PM +0100, Javier Carrasco wrote:

> I took a look at its datasheet and there is no vdd2 as such, so I think
> we are in a similar situation here. Actually that device requires five
> supplies and they have been grouped into vdd and vdd2 according to their
> voltage level.

That binding is just broken then and should be updated to reflect the
reality of the hardware.  The current thing just won't work if any of
those supplies come from different regulators.  It's really hard to
understand how bindings like this get written :/

--5oDTt8oCWPvri2Kt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXCXM8ACgkQJNaLcl1U
h9CEkAf+O+edtJoQQbKZQMUgn6R7Jnmv8S64Lw5F7AsjcZzhjs6xeOZSl3Jgkl6l
9+zZSQIe1jle3MYvVMQUP14S61wnXGV6oMS7N1f6Xxx//3msJ/ZUCNS3WzY6t+AQ
Erxn2Au8obDlgJLqEEDgIYYuuZjqGr2SDlywLeiGXXWu/MOdoadYWDhfsk3HZcDY
AjzfJ/zYMJIQR2PhZEVmzfSiEWLoQqYgn8R/7P/OHMhy+p1g7kRvr78TzzXr229Q
b41WMdQ9BH9kX32VvkRc/I6/HYbvLjYRcAtDQF1CjQoKVCj3e/A+dzSjwVyhTzee
QuijC6NAilFuC42FgnFQzvHVNSJiiQ==
=kQmE
-----END PGP SIGNATURE-----

--5oDTt8oCWPvri2Kt--


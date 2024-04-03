Return-Path: <linux-kernel+bounces-129868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E10BF897170
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 968B31F212CF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7385C1487E3;
	Wed,  3 Apr 2024 13:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dh3P7+lh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2C31DFCE;
	Wed,  3 Apr 2024 13:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712151915; cv=none; b=GU2LPfUGJEa18oQ32DtgkHvCrMXC/RrHAcd1uPkme6mO7ViaOKV2zUbgVsdKo6gTDFMLxncHumc/xIWqjwEIB9/pRCYuq1V7ZYQIuXBtHRpI0q2/RcpXNPhvcwFhzaDENnGFTG3ywaezy4uPdT8o8xeO9cxf1b2JsfhtUl6OBy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712151915; c=relaxed/simple;
	bh=+ikY8BSq10QbgxL9707U5m4U2KSJOM15mk4sbjfgX1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D1KxlZzNhLFaQQa/kl9CKya+tUjhNXTDVXb2rEqSTcAiJtPJ5IDuxmw/gwyxBWQb7Kl3P/sldq+hGr26Ie9F5/+68+WurP01n8k2N9P7k6mO7XfO89QuXFG/htLhurUwVdq3lLuz8TdnhiS2KrQ3QGgM3dwlCXMrY2PtrMEXwiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dh3P7+lh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE7B4C433F1;
	Wed,  3 Apr 2024 13:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712151915;
	bh=+ikY8BSq10QbgxL9707U5m4U2KSJOM15mk4sbjfgX1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dh3P7+lhN5xp4xeFswy1Qto9YZE4QIp5Zf3KOD7H9DzM1vgJniBQm85tZYd/SnYoF
	 aSQitj9sKtOyO1Lcyt7UapsFjs1LlR5iJYxuBMS5tezkZ4LvCb8jrBHSeOgwLZ/o2X
	 3PZbwhzU+JHb9ByAk0RiHBN0rnrDQK1Z97ZZGJvWrMEssqjKF6WBBPX1k/M7UPmUgS
	 5UDtWeSea0W0Oo8J4loGx4vopsQfVVP/Sn0RYGcYdV6/mjDFsde2rOtCDjJ9zE+HJX
	 3GJTVHhHbcD+7bxLFdepeiikVLrtlMm/OaUiK9A84ObL5NcpgD6r7fvIT2HoE+8ZNK
	 r1Hajfu6n8NTA==
Date: Wed, 3 Apr 2024 14:45:09 +0100
From: Conor Dooley <conor@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.6 000/396] 6.6.24-rc1 review
Message-ID: <20240403-unlearned-jitters-481087dc793c@spud>
References: <20240401152547.867452742@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oylpjelTUucA36b9"
Content-Disposition: inline
In-Reply-To: <20240401152547.867452742@linuxfoundation.org>


--oylpjelTUucA36b9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 01, 2024 at 05:40:49PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.24 release.
> There are 396 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Conor Dooley <conor.dooley@microchip.com>

--oylpjelTUucA36b9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZg1dZQAKCRB4tDGHoIJi
0q3pAP9JjZuMA6pxxzW1rO+NnQyD6a7ASg+/23pmyftfxDaq1AEAsOK66IQCe0p7
nfPYa3713RuOQdHyAS+5x6coO3oxMQM=
=Vwnp
-----END PGP SIGNATURE-----

--oylpjelTUucA36b9--


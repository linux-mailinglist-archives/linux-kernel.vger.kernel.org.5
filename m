Return-Path: <linux-kernel+bounces-136868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E90789D939
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A942283F04
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF67612E1C2;
	Tue,  9 Apr 2024 12:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xrzk3FxV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C48112C552;
	Tue,  9 Apr 2024 12:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712665672; cv=none; b=YWqHO026vd5dFigNPOeL4PyoSh7iokJmxDeb55D8TdQQI/R4bY/qbGgXmmXhqrP1hYVe2P2dYjL/TLcD7unF+R42JzoxzkTuf8GzFQsdzMcsyDxctl0AkYGEoIC+Oj6dcUbV3WNUez0CWcNxtLqXdh97P0ld6WrTXqLvAqsNAQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712665672; c=relaxed/simple;
	bh=vCR7V6opm/d0hGCMAwUvbEAVDqs4zaf6v/D7/9bR2Zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qkYLbFmbpOwOMNj90JbZ4yd9Rrl5jA/BWhDQKCNlwdRgd5oKzB8H8Zq18HtZYFWxHp3jELdIcI13LBraufTg+N+fmTzYAmcusHnd5XnQZfG+C3dPq7nT+Bn5V/YtS/QsdYxvxTN5hz2Cs7DhfwdCE/fMTS98HxR9xVpMsoDhnKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xrzk3FxV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06A09C433F1;
	Tue,  9 Apr 2024 12:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712665671;
	bh=vCR7V6opm/d0hGCMAwUvbEAVDqs4zaf6v/D7/9bR2Zk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xrzk3FxV7H4A8aoJv8wIJ8o6x3Piu9OLiS9sWe6n5F1mXXdEM6qyuoGZUvAAPE2yD
	 nIn6CfDpVmIny2VrIzi9tPL58T5afk8rRj3/ZXzGdv8/9jHGCdd041EeQEgBl73ghw
	 B4+ljQX4Oxj3QgEs7/kRav4kPYNYvEC1FB2xlc7AQmyZHg1SjczTFaO4TPG/RRLU7J
	 nS7ULaqg8thGBA/dpBvGPR8KLFUs/8B5t6dWckyEo7VoiBNgenv32UBRxX7dHXK6M9
	 N22ggQ6Icq+dEJj0r3frZrq1PudtfkAF0ae1XxNn7qTIBRhiHh5d9d2oKcsSA8eJbJ
	 UIQYQhaqPkZQg==
Date: Tue, 9 Apr 2024 13:27:45 +0100
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.6 000/252] 6.6.26-rc1 review
Message-ID: <e38ccd75-ace6-45af-9378-6f53caba5897@sirena.org.uk>
References: <20240408125306.643546457@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="e3yZkAQ45y0+vtTp"
Content-Disposition: inline
In-Reply-To: <20240408125306.643546457@linuxfoundation.org>
X-Cookie: Everything you know is wrong!


--e3yZkAQ45y0+vtTp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 08, 2024 at 02:54:59PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.26 release.
> There are 252 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--e3yZkAQ45y0+vtTp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYVNEAACgkQJNaLcl1U
h9AtEgf/V90b2EdFfuvtnR5UhMcRGm+3QQhI0sfsTaPpsDxgOs/25/UXxyMuLIaX
DEHUjGl4YTMJS0H2DixoHZ+h1jqAAdvmdZ5rPr+I7YJOmtZYGpJzgkFvTnKWId+H
JTbTQioEJnnh2/M2Jy6sHu3qRMfq49iWkZniMpVBo4aNIx+6WrNcjswvWFApCE/X
qodRbegBT+5Ii6meZQR3hh6vnxiPOo+akxnJ0yYI4Iq/vO+WtYx+nnWoXUEceofO
37Qwj31qLzsIC++AcDqeGCHd+HCWO3xgcAaLbPYL+0zQVcVWMOaBd51DYhDj0aTN
VMO6cjBuyhpdnRZ3u6bPr8W4QyJ7pQ==
=nXyH
-----END PGP SIGNATURE-----

--e3yZkAQ45y0+vtTp--


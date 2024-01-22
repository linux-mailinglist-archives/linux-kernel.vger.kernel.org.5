Return-Path: <linux-kernel+bounces-34048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CFDA837277
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D833D28CE4F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25873EA81;
	Mon, 22 Jan 2024 19:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nlwLq4vt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426EF40BE2;
	Mon, 22 Jan 2024 19:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705951460; cv=none; b=o9kJzNSHXeuX+3s3qSxSGjGEvrkuVPmWdLw6E+Hpe7GpKSLfVqS7zGLKE4CoHM0oBsiObYsChOiXP5Cw/OAQiIH0bhsR3vx6FV2hnRU5nnSc8n5WWoRRTxMoE3opQ1Jt6WVGFHWd6VwRTPfuGDj/KcjMQjWG1/RDsnOix8VLRog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705951460; c=relaxed/simple;
	bh=q6+ae+e1u2lR2sj3tlYoFuAtnCRKAfk/zjH65/fqdzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rrj/tnDdtBWKyMg4oMWVHowH78UivuFuyqHfwUaYDEU9/3GaOs/kg4cOVwFgZxtre+rPfXwpRTEyLV2i8vRFY6uZuolfB8Pp/QEEhbMoGze1QOre+aReAWIqWXFSEDtqZGJ6KkJ0+IXwylZVTrn8tm/98folFzLl/iT100MBQBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nlwLq4vt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB9B7C433C7;
	Mon, 22 Jan 2024 19:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705951460;
	bh=q6+ae+e1u2lR2sj3tlYoFuAtnCRKAfk/zjH65/fqdzQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nlwLq4vtr47vvjoezI/elsZFCkLtHGUhglYP+KkGBdkj1z+5kqlZFhO5MJFL8i3O0
	 5u5l3R7cmdv1qlGFjN9miagp+q/FoGfK9qqZL/AlA0KztWKojgJW8f7P2UQlw66Les
	 8//g8zukcEys2nwPuK6q+qoL8k38EV4TVowELpRwdyZEWJr4ojk21Ff27BzmkfZYoo
	 nfToxlYh3CHIO6MRxfmLc+07yZ/nru2V/x8hbprj6s2UyRR25erQGehC1wIiuQecLi
	 KsO3SETa/3zo/oUXsKho2auDCwrFAj945ZWHWP7mSHUpjAPp86UGSzUk4Ei+ulebdC
	 +RBJ2WZMPBJrw==
Date: Mon, 22 Jan 2024 19:24:15 +0000
From: Mark Brown <broonie@kernel.org>
To: Klaus Kudielka <klaus.kudielka@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] SPI updates for v6.8
Message-ID: <27cf320e-7b28-44cd-9aa9-ec23008a9e82@sirena.org.uk>
References: <20240107223817.EDB59C433C7@smtp.kernel.org>
 <d8724cd416494bb5cd5b0350266fce0cb7b3b210.camel@gmail.com>
 <a3b7790b-ce5b-407f-8089-a18c52aa7a1e@sirena.org.uk>
 <65a86432e076d98ca5dfbc24ba8a08bcbd48071c.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lEoP+jDxm8z+j2Zc"
Content-Disposition: inline
In-Reply-To: <65a86432e076d98ca5dfbc24ba8a08bcbd48071c.camel@gmail.com>
X-Cookie: Nice guys don't finish nice.


--lEoP+jDxm8z+j2Zc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 22, 2024 at 07:57:01PM +0100, Klaus Kudielka wrote:

> I wouldn't have an explanation either. But said patch, applied on top of 6.8.0-rc1,
> seems to be a possible cure. Everything nominal again, AFAICT.

Great, thanks for checking - the fix should in -rc2 all being well.

--lEoP+jDxm8z+j2Zc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWuwN4ACgkQJNaLcl1U
h9BgJAf+JDrq8bDEDzzlgw3BXrwemxAJFWrNnC4Zupys9mmYY1ocsszxR6VyiosP
pEwqTolJU+pjlzH5W6ECTUT5JXkXv6U1u5Xg+5FwVucWBhSCKszS3N5PJW7xs0+/
dqmHO3Q6zsE3vizAbLtpiO+J+M+7R0e/fS52ax8GP7bJwMyvkpzXoW+cq2qg/EUj
dvcPceH9d+eku9DWaB4dmjLI0O1RtQreqJgseUDeFEFmgOD4dbpRJUSq/ZQ2Vmss
nd8kLtuicsidZRpzsvYRrWaA+AhUo2npfhT78YeLL4JVT11TLL5n84GuhFthH5w5
Pwx1N7D+w0kKdE/kJx0A2d5gWL+nlQ==
=HXsc
-----END PGP SIGNATURE-----

--lEoP+jDxm8z+j2Zc--


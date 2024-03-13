Return-Path: <linux-kernel+bounces-101274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C77E687A4EC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 259B7B21B04
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F147224E8;
	Wed, 13 Mar 2024 09:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u3QdwIqS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F25224D8
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 09:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710321862; cv=none; b=j4sPSssAdBdUKp7DHdkGkHqRe6t2m1fPImuTQNXxM0ffjcpco31bbhkeL2Pvy8btz0+Qp7MM67QHjNvmsAnLQ7aZ2ptjhKAWi3qKTU3DEDSyLJ9tDu5DlKPaNkCCg+4fKNcTHkIE65EzdlO3YafDIAB80mVS3ZVvC4k4MAh7kyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710321862; c=relaxed/simple;
	bh=cEc1lGHAzmhktzZB3LfkyJVWkCDMr1m6qmRcF67PJgE=;
	h=Content-Type:Date:Message-Id:To:Subject:Cc:From:References:
	 In-Reply-To; b=satS36VoqnnWPKQjA+9QtdrwWlqL9kmKg0+oea5y83gDsejYj8eSoOGy9kj6YXWhyN+Tt0EjylptLy0B/DhEHOkEaeT9FdaKQhPYUI2hB2XQoX9MfCeTvS5GNPhacx6kMVqLm8ynjSKfjN8bkQ78grfUUnLMRbQu4htQz6SFX4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u3QdwIqS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7E18C43390;
	Wed, 13 Mar 2024 09:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710321862;
	bh=cEc1lGHAzmhktzZB3LfkyJVWkCDMr1m6qmRcF67PJgE=;
	h=Date:To:Subject:Cc:From:References:In-Reply-To:From;
	b=u3QdwIqSRNu5/om0tD9SwyuK8cIYuVYHvLvUNW53DAa0NROSmvucitQ0yLnmqIenD
	 qm103QJ3GGn182nkchaA8rvdEZN7PyRVUATcM+NkKbQt/9eNOLqLcOmgwu9Mi6anUG
	 QIz+5CYzNn6l9I9aFozmhbzkn1zzRDJlnFK0Nvulx306itgLhsiyeSXgNGwI99p9sU
	 sSwW72KfNh3CZyyRgJX0HqpWHIwHVGO/bm9wDU1tjLY9a3/Hf7MemvYdMETTve3Kra
	 x9xYQvQhbZKfb8Ei2CshzKn6BRU9Bz01hcCnnhFw340Dyjizo0+4I731zwV7fyDOwZ
	 2Arl373zckpQQ==
Content-Type: multipart/signed;
 boundary=8d4e32d90b12bddb067516627e24c977e5b2bdef96f77024fb6ad523e783;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Wed, 13 Mar 2024 10:24:13 +0100
Message-Id: <CZSIHWU6IYXB.2DUCUUYFTAB2X@kernel.org>
To: "Aapo Vienamo" <aapo.vienamo@linux.intel.com>
Subject: Re: [PATCH 2/2] mtd: core: Don't fail mtd_device_parse_register()
 if OTP is unsupported
Cc: "Miquel Raynal" <miquel.raynal@bootlin.com>, "Richard Weinberger"
 <richard@nod.at>, "Vignesh Raghavendra" <vigneshr@ti.com>,
 <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>, "Mika
 Westerberg" <mika.westerberg@linux.intel.com>
From: "Michael Walle" <mwalle@kernel.org>
X-Mailer: aerc 0.16.0
References: <20240307130418.3131898-1-aapo.vienamo@linux.intel.com>
 <20240307130418.3131898-3-aapo.vienamo@linux.intel.com>
 <CZQZXAB2GOCY.12YVJ6CRGG26B@kernel.org>
 <xeqscncwirfaz77mtpcvkueo5xto7vis5khr3uwclcx4sfx6eb@35j3grcqrzo2>
In-Reply-To: <xeqscncwirfaz77mtpcvkueo5xto7vis5khr3uwclcx4sfx6eb@35j3grcqrzo2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--8d4e32d90b12bddb067516627e24c977e5b2bdef96f77024fb6ad523e783
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

On Mon Mar 11, 2024 at 5:20 PM CET, Aapo Vienamo wrote:
> On Mon, Mar 11, 2024 at 03:38:17PM +0100, Michael Walle wrote:
> > On Thu Mar 7, 2024 at 2:04 PM CET, Aapo Vienamo wrote:
> > > Handle the case where -EOPNOTSUPP is returned from OTP driver.
> > > +	/*
> > > +	 * Don't abort MTD init if OTP functionality is unsupported. The
> > > +	 * cleanup of the OTP init is contained within mtd_otp_nvmem_add().
> > > +	 * Omitting goto out here is safe since the cleanup code there
> > > +	 * should be no-ops.
> > > +	 */
> >=20
> > Only if that's true for both the factory and user OTP area.
>
> I'm not sure I follow. I'm not seeing a path in mtd_otp_nvmem_add()
> that would result in either mtd->otp_user_nvmem or mtd->otp_factor_nvmem
> needing to be cleaned up by the caller, if an error is returned, if
> that's what you are referring to.

Yes you're right, sorry for the noise.
>
> > Also, you'll print an error message for EOPNOTSUPP, although that is
> > not really an error. Is that intended?=20
>
> Well, when we hit this, the functionality of the SPI memory itself is
> degraded in the sense that the OTP functionality is not available. What
> would you suggest?

But it's not really an error, I mean, we are ignoring that one on
purpose now :) I'd just guard it with "if (ret !=3D -EOPNOTSUPP)".

> >=20
> > >  	ret =3D mtd_otp_nvmem_add(mtd);
> > > -	if (ret)
> > > +	if (ret && ret !=3D -EOPNOTSUPP)
> >=20
> > Maybe there is a better way to handle this, like controller
> > capabilities instead of putting these EOPNOTSUPP checks
> > everywhere? I'm not sure.
>
> Trying to come up with clear semantics for a capabilities flag to solve
> this is difficult. The issue is that on the SPI controller side, the
> limitation stems from the really strict set of opcodes that are allowed.
> For example, we already hit an error with the 0x35 (read configuration
> register) not being on the set of allowed opcodes. While this
> instruction is used by the OTP code, it's not a strictly OTP specific
> operation.

I see. It's just that due to this (very) restricted SPI contoller
all this EOPNOTSUPP handling is creeping into more an more places in
spi-nor core and now mtdcore :)

Anyway, I don't have any better idea right now. So I think this is
fine.

-michael


> If there was a flag that would signal OTP support, I think it would have
> be defined as "the controller supports all operations that are
> performed by the OTP code", which sounds brittle. The other way around
> would be to have a really fine-grained set of flags that the MTD core
> would check, but that feels tedious and error prone as well.


--8d4e32d90b12bddb067516627e24c977e5b2bdef96f77024fb6ad523e783
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIgEABYIADAWIQQCnWSOYTtih6UXaxvNyh2jtWxG+wUCZfFwvRIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQzcodo7VsRvtCSAD/YJkNHNj/CVCUeVVMRLzNJTsb131beCFk
kGoenLQ4aE8BAJpLL0syl9RnrQOhboV6hPopHwley8DRc9x7jlNUn0ED
=5+gS
-----END PGP SIGNATURE-----

--8d4e32d90b12bddb067516627e24c977e5b2bdef96f77024fb6ad523e783--


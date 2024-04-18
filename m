Return-Path: <linux-kernel+bounces-149854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6717E8A96D7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93E2C1C212F4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9BD815B96D;
	Thu, 18 Apr 2024 09:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EfTBw90L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCA115B15B
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 09:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713434267; cv=none; b=aBLt7qsB5pIX83ne8caMb1ekza3GR/4uu21RwW4onAIrWipcZ0faXMUmd0vS1T/SSt0zrhYtq53em+xiWANFIld/RNEPCXrw+HhH/iELgqZwEtZMcEfesbHi1MQCpihiwYhHC3D5NSI7p5idoSeaJpwu7clFWpPOn7+0cuASJEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713434267; c=relaxed/simple;
	bh=FnO7O/LAw4UD9EIKQqffhjBWzBF2/WXbWWY5ME5kBNo=;
	h=Content-Type:Date:Message-Id:Subject:Cc:From:To:References:
	 In-Reply-To; b=C8tLhp0LfjJwF6IILpkdObLU+79XWsd+UtArPoCVPi5Izgmx3lupeVX50k0zoIkaoyxWWXK17BAUi58k5m5A2e56SR2awsmQ+BsvESxK+eHpa34NofNnrkYdW3x4zk2+7qm8JHLTvEHdE2PAf3Rbunmb3gEtD7xZuQ13Lwhtos0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EfTBw90L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E80EC113CC;
	Thu, 18 Apr 2024 09:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713434266;
	bh=FnO7O/LAw4UD9EIKQqffhjBWzBF2/WXbWWY5ME5kBNo=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To:From;
	b=EfTBw90L4vECvMjY6fgUro/CI+kPMmubR9J4aZTL+VlxjrFBHSjNeLq5nAVOEa0ys
	 CtUi6dSbl0AK9PtokwZkqOxh+zO+z/wu0s5olR17H4MUgOXFcb+thnZSUngjFnPeiw
	 P8wEIgmjVLS98FHbCqoGgK8CFB+fkeXNFuFwj4Y7hR7ZmG3RsLiv/IYaq4mNgCDhr/
	 YFjebODwdUd4aaUikgkd0jPHz05PcC1a0O93ikHC0tD5aPjDUJXwCaoi8FTUbjm704
	 T4l/M5LUEX2qPR1N/13nqkxeSqmHu1yxu4HnroeBAYq5JslItN+Muxt5zlh/CI5ikG
	 ueLSdRJG7J42A==
Content-Type: multipart/signed;
 boundary=d634570c1f6a4a1796182749624c4b5d93dc5a4862d7079e44e41056bc8b;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Thu, 18 Apr 2024 11:57:27 +0200
Message-Id: <D0N5QYQMX1X4.831Q9SEANU4S@kernel.org>
Subject: Re: [RFC PATCH v1 6/6] mtd: spi-nor: introduce support for
 displaying deprecation message
Cc: "Tudor Ambarus" <tudor.ambarus@linaro.org>, "Miquel Raynal"
 <miquel.raynal@bootlin.com>, "Richard Weinberger" <richard@nod.at>,
 "Vignesh Raghavendra" <vigneshr@ti.com>, <linux-kernel@vger.kernel.org>,
 <linux-mtd@lists.infradead.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Pratyush Yadav" <pratyush@kernel.org>
X-Mailer: aerc 0.16.0
References: <20240412134405.381832-1-mwalle@kernel.org>
 <20240412134405.381832-7-mwalle@kernel.org> <mafs0jzkw6oq1.fsf@kernel.org>
 <D0MHEH8OOS44.2PPBZ3LFU4QG3@kernel.org> <mafs0bk686l67.fsf@kernel.org>
In-Reply-To: <mafs0bk686l67.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--d634570c1f6a4a1796182749624c4b5d93dc5a4862d7079e44e41056bc8b
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

On Wed Apr 17, 2024 at 5:52 PM CEST, Pratyush Yadav wrote:
> On Wed, Apr 17 2024, Michael Walle wrote:
> > On Wed Apr 17, 2024 at 4:36 PM CEST, Pratyush Yadav wrote:
> >> On Fri, Apr 12 2024, Michael Walle wrote:
> >>
> >> > SPI-NOR will automatically detect the attached flash device most of =
the
> >> > time. We cannot easily find out if boards are using a given flash.
> >> > Therefore, introduce a (temporary) flag to display a message on boot=
 if
> >>
> >> Why temporary? There will always be a need to deprecate one flash or
> >> another. Might as well keep the flag around.
> >
> > Mh, yes I agree. That also means that this flag will not have any
> > users (most) of the time (hopefully ;) ).
> >
> >> Also, this patch/series does not add any users of the deprecated flag.
> >> If you have some flashes in mind, it would be good to add them to the
> >> patch/series.
> >
> > This is just an RFC to see if whether you Tudor agree with me :) But
> > I was about to add it to the evervision/cypress FRAMs.
> >
> >> I like the idea in general. Do you think we should also print a rough
> >> date for the deprecation as well?
> >
> > Might make sense, any suggestions?
>
> How about a simple string to flash_info?

Ahh, I was rather asking if you already had a time frame in mind.

Besides that, should it be a date or a (future) kernel version?
Roughly about two/three kernel releases?

> /**
>  * struct flash_info - SPI NOR flash_info entry.
>  * @id:   pointer to struct spi_nor_id or NULL, which means "no ID" (most=
ly
>  *        older chips).
>  * @name: (obsolete) the name of the flash. Do not set it for new additio=
ns.
>  * @size:           the size of the flash in bytes.
>  * @deprecation_date: The date after which the support for this flash wil=
l be
>  *                    removed.
>  * [...]
>  */
> struct flash_info {
> 	char *name;
> 	const struct spi_nor_id *id;
> 	char *deprecation_date;
> 	[...]
> }
>
> And then in everspin.c for example,
>
> 	{
> 		.name =3D "mr25h128",
> 		.size =3D SZ_16K,
> 		.sector_size =3D SZ_16K,
> 		.addr_nbytes =3D 2,
> 		.flags =3D SPI_NOR_NO_ERASE | SPI_NOR_NO_FR,
> 		.deprecation_date =3D "2025-01-01",
> 	}, {
>
> And in spi_nor_get_flash_info() (changed some wording of the message):
>
> 	info =3D jinfo ?: info;
>
> 	if (info->deprecation_date)
> 		pr_warn("Your board or device tree is using a SPI NOR flash (%s) with\n=
"
> 			"deprecated driver support. It can be removed in any kernel\n"
> 			"version after %s. If you feel this shouldn't be the case, please cont=
act\n"
> 			"us at linux-mtd@lists.infradead.org\n", info->name,
> 			info->deprecation_date);
>
> 	return info;
>
> This would also remove the need for SPI_NOR_DEPRECATED. But it would
> make the flash_info 4 or 8 bytes larger.
>
> What do you think?

Looks good.

-michael

--d634570c1f6a4a1796182749624c4b5d93dc5a4862d7079e44e41056bc8b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKcEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCZiDuhxIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/gX8QF44ntSYBOpUzOrXjd2P5ZKnbh5928I1t36
JOjjpnwFUrSpmcnSrtzO6TzpDxJSeYABgNW3ep68DS04VArOFpAeXNmTKp9a5w91
TagrJH8qrhzlzkJ+eVJiDIkY8Q2Z0LNYyQ==
=4HSX
-----END PGP SIGNATURE-----

--d634570c1f6a4a1796182749624c4b5d93dc5a4862d7079e44e41056bc8b--


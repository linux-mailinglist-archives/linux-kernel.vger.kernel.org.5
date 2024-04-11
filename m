Return-Path: <linux-kernel+bounces-141296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BBD8A1C40
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D05E81C21BC6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0FA15B99D;
	Thu, 11 Apr 2024 16:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JsEb+ODw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D8615B566;
	Thu, 11 Apr 2024 16:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712852068; cv=none; b=azsOJCZpadzDFHtp4Sz4m96KD+IPu4s11rovHHs3DUjyWA2ziBAt3mkZob4+l2N4jTTYaKjTbkyNnALBNczir3ggH7hL6T0Pfj935jtxHDs4KJPLjnhcZtzZ8oyjlTk48CfTjPOIZFGq8q7CBOny9QNBsYxOKDIqRg7RGJAWkYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712852068; c=relaxed/simple;
	bh=wX+Sb9KE1goHL85Uuw7AAvgTdqo2KwK3euLm9IJTgao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PBPsT0xQQVO4Y0dPbCd4URRAbCyyH1bY20bOmRpZGzMRw4hHa1OXsJ6wK+TtEtxcOC7mMgTTJ01q2H20uC+z9v/ZT5PFiDGQT9M5b+LQtbiUzVKvRn2QO+yrk3GACeytpZehUXu8V4xE9hXW/J9aeDIhqvjFKmeKwACty3wNowo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JsEb+ODw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 993BDC072AA;
	Thu, 11 Apr 2024 16:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712852068;
	bh=wX+Sb9KE1goHL85Uuw7AAvgTdqo2KwK3euLm9IJTgao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JsEb+ODwVxBzaUD7a4CzBXXIZu92Ml/s0phvhSArvWN9K8QDWmfl8rE6SQnO9qIxM
	 LEFAkYyNgTM1DjmP0BgRKspC1OqZBxTzb/CUCD4gUEC9Nh17eosafmPmgxXXGVoZRG
	 IcRJ20cZH2zCnj5WPf8MmmNuZJrg4p40KW2/QRJ76ztSIIEQpUjOJUYk07Dpbn7uLp
	 iQQnBNC8TFcQ+IIAMywRzJDEGiAicin/+Y3WuQ2JjJ0LwpHeNnror3DZuqSZY3Tvuo
	 MEUaiigaHRtMO0tL6BLQpHCni+rouQwVtdXCDL32BOTBB6B/yjnaB1oLXI0pCWu0dL
	 5UCOWWnzYCPmA==
Date: Thu, 11 Apr 2024 17:14:23 +0100
From: Conor Dooley <conor@kernel.org>
To: Michael Opdenacker <michael.opdenacker@bootlin.com>
Cc: Jisheng Zhang <jszhang@kernel.org>,
	Inochi Amaoto <inochiama@outlook.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: dts: sophgo: add initial Milk-V Duo S board
 device tree
Message-ID: <20240411-persuaded-symptom-b14a8cfee57f@spud>
References: <20240409064504.4010353-1-michael.opdenacker@bootlin.com>
 <IA1PR20MB49532A8D4294ADCE0C33A654BB072@IA1PR20MB4953.namprd20.prod.outlook.com>
 <20240409-prevent-deepness-2d22bf009b16@spud>
 <IA1PR20MB49534E00CAE29D24F7D7E718BB072@IA1PR20MB4953.namprd20.prod.outlook.com>
 <1514d28a-5e96-4531-a972-894e41902efa@bootlin.com>
 <IA1PR20MB4953CA04D33EA0C7902DFA3ABB062@IA1PR20MB4953.namprd20.prod.outlook.com>
 <ZhZo0iJFSn1te-6d@xhacker>
 <5fdda638-21ba-4fa7-b666-33cf2fd69dda@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MFXo6Ns2Jdu07e2i"
Content-Disposition: inline
In-Reply-To: <5fdda638-21ba-4fa7-b666-33cf2fd69dda@bootlin.com>


--MFXo6Ns2Jdu07e2i
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 10:35:55AM +0200, Michael Opdenacker wrote:
> Hi Jisheng,
>=20
> On 4/10/24 at 12:24, Jisheng Zhang wrote:
> > setting the correct bus-width is necessary for better performance
> > no-1-8-v can be removed, but it doesn't harm anything because
> > the board doesn't supply 1.8v
> >=20
> > no-mmc and no-sdio to make the probe a bit quicker
>=20
> Many thanks for your advice!
>=20
> However, whether I apply these changes or not,
> git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git is now broken for
> me:
> Error: arch/riscv/boot/dts/sophgo/sg2000-milkv-duos.dts:32.1-8 Label or p=
ath
> sdhci0 not found

This is probably just because you need to use the for-next branch of
https://github.com/sophgo/linux.git as your base. Palmer doesn't apply
dts patchs to the riscv repo. Usually working on linux-next is fine for
these kinds of activities.

> I was previously testing with linux-next, but it's now broken too, though=
 in
> a different way:
> [=A0=A0=A0 1.306811] /dev/root: Can't open blockdev
> [=A0=A0=A0 1.311200] VFS: Cannot open root device "/dev/mmcblk0p2" or
> unknown-block(0,0): error -6
>=20
> Shall I submit my updates anyway?

This is probably worth investigating by someone, providing a longer log
would help if you don't wanna do so yourself. Did you rebase on a more
recent linux-next and this cropped up?

--MFXo6Ns2Jdu07e2i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZhgMXwAKCRB4tDGHoIJi
0izEAP9BMtHM9XrULQAvBFk8Lzjfx7aDOB1RFamiBRseR4yYvQD+LVtg9ja4UyKL
TWkuivznsZkY8kuYquTYOwl8jiAijQY=
=HZD6
-----END PGP SIGNATURE-----

--MFXo6Ns2Jdu07e2i--


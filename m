Return-Path: <linux-kernel+bounces-94442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E47873FE5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 553AEB23A30
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 18:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49FF113E7FE;
	Wed,  6 Mar 2024 18:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="hmE1A4X1";
	dkim=pass (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b="C52ZWhLc";
	dkim=pass (1024-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b="NuqjY41F"
Received: from e2i652.smtp2go.com (e2i652.smtp2go.com [103.2.142.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1821136647
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 18:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.142.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709750622; cv=none; b=AWjZyfqcjAVLdp8Rb7IRkq9pZDRIWUblGSV9+qyUWfs98zPMQEgxVeA6rr+40m6rW+9JkbWmslPJV/knv4bRCBOKv8Nx1qA08U6y8sr4rXQxnKo8Am7fYzNz0svM5LzbA1v4lAr5e7NaG7WQYEEY7I/H22uVbG/q1yGlifj9qYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709750622; c=relaxed/simple;
	bh=lqf5F5/wynUuLQMyXci5UgqCurfaGt/bCOCumtuezvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U/LUPxE0wbP9ytKB/8cd4in31Hc5gcwCv7cYfGep5fOtbRp5nV9OQ3nLZO/ubzgvMsLgG/2OQWryDHXFrQq9k46kHwcldpX0lj1uVrcctxVMC9itFhJf8rGn2tO0wrjfsk7k5d+XTSDhHLw0+hF1GzYXDI3F+wKq9SGOsk0NNKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu; spf=pass smtp.mailfrom=em1174286.fjasle.eu; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=hmE1A4X1 reason="unknown key version"; dkim=pass (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b=C52ZWhLc; dkim=pass (1024-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b=NuqjY41F; arc=none smtp.client-ip=103.2.142.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1174286.fjasle.eu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=mp6320.a1-4.dyn; x=1709751508; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Subject:To:From:Date:Reply-To:Sender:
	List-Unsubscribe; bh=lqf5F5/wynUuLQMyXci5UgqCurfaGt/bCOCumtuezvc=; b=hmE1A4X1
	JPcv0ECUaSk4h8+r1arnpv5JpCB+tzj3nJhKKF2tdFBM0XxaGAEqzB4PDZq2ut60mT/nJLXWg+hXf
	wOCZIr7jU0+QpWZw/qTroypWCp0GZCYFIVovwibWKrLopNw9ms03+dERhdNMen/DcYppcBxSbyh7t
	+hp3z0g7gLnTBLDc1WfoT+RH2ZXf0wTQ/LMRJw9XSaWQfDKX3S1GT9X/PAXfeDboNr8hx5mRz4j7A
	O27LZ92vTBWdnSHNOUp5nA/nk3cUxeiH82bUsLX4DStUu3MOxCOOsrNYcCVTQBDw2vPWSTzeOQ+ya
	xQvgwiVl6rvt+vhP4h8nOery3g==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fjasle.eu;
 i=@fjasle.eu; q=dns/txt; s=s1174286; t=1709750608; h=from : subject :
 to : message-id : date;
 bh=lqf5F5/wynUuLQMyXci5UgqCurfaGt/bCOCumtuezvc=;
 b=C52ZWhLcp7BvxLk/oPPuFgpaXkOMt62joR7w+cY90wlhfyTmv1tQwoAjtmSKklP3nW3gp
 BtsLcdFprYINNGOrIBKBwuc8XeYXW3ORwW+z46Yw18HkzautLoceD/9jAaXO/8JeblWOzt/
 g0x/4rh3ET+XRS7nHcJ47jCnosiQGk4sdVToqcQt9I/mwVfYAzpoYWlQmeO2xoLVuB/0wgv
 KB9WFBJ3vsdN+LAU8qihbnSJHnwDD0J9nPgGiS6CjVSXjX5fPe8STiHhjGwfH6VWi9cxn/S
 RaexZPESfKswkS72ynnNW/Epz0isJ7n+BFs3GORbgDz3aI75JfAChXcviASQ==
Received: from [10.139.162.187] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <nicolas@fjasle.eu>)
 id 1rhwEA-qt4Bqe-MD; Wed, 06 Mar 2024 18:42:54 +0000
Received: from [10.85.249.164] (helo=leknes.fjasle.eu)
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.96.1-S2G) (envelope-from <nicolas@fjasle.eu>)
 id 1rhwEA-4XqxWs-0M; Wed, 06 Mar 2024 18:42:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
 t=1709750568; bh=lqf5F5/wynUuLQMyXci5UgqCurfaGt/bCOCumtuezvc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NuqjY41FDI9SwfMB+XzOfXEdDX0enZGk62Jg5uU4RsZTkqUAV4ctou70R32bmz7rB
 lvhK7kECnrGI/CfyB40ReKlq/LJJhJhbhgJexqPBqI+BFBtoHWPBmh3/chnh+KfbEQ
 CDtLm2modjfUgR/5SYNdpNH4O0rCkilLrr/UfzJc=
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
 id D3B3E3C401; Wed,  6 Mar 2024 19:42:47 +0100 (CET)
Date: Wed, 6 Mar 2024 19:42:47 +0100
From: Nicolas Schier <nicolas@fjasle.eu>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kbuild: unexport abs_srctree and abs_objtree
Message-ID: <Zei5J7aU1Yd720Po@fjasle.eu>
References: <20240306104222.308473-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="QvLgz0ZfwNfKstKB"
Content-Disposition: inline
In-Reply-To: <20240306104222.308473-1-masahiroy@kernel.org>
X-Smtpcorp-Track: 1rhwEj4bqxWs0u.6GktAVmgQOdvo
Feedback-ID: 1174286m:1174286a9YXZ7r:1174286smcNLppFyP
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>


--QvLgz0ZfwNfKstKB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 06, 2024 at 07:42:22PM +0900 Masahiro Yamada wrote:
> Commit 25b146c5b8ce ("kbuild: allow Kbuild to start from any directory")
> exported abs_srctree and abs_objtree to avoid recomputation after the
> sub-make. However, this approach turned out to be fragile.
>=20
> Commit 5fa94ceb793e ("kbuild: set correct abs_srctree and abs_objtree
> for package builds") moved them above "ifneq ($(sub_make_done),1)",
> eliminating the need for exporting them.
>=20
> These are only needed in the top Makefile. If an absolute path is
> required in sub-directories, you can use $(abspath ) or $(realpath )
> as needed.
>=20
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---

Thanks, I appreciate that abs_* is only used in top-level Makefile.

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

--QvLgz0ZfwNfKstKB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmXouR0ACgkQB1IKcBYm
Emkexg//YCqubDBQYOUGXOKDWZ4Biw/QL+kh6UNDM76LouVyCapjebmlag3VD3pm
ArbuWKInK1qc+aBp0XY7G3+MqJP6hdFVGxHZ+oyNHKAWtXJ3QiZtsUY5GL006t0p
19OfoVnk2T0zlu93GQZc74Q1l3ZScOdichEZc5b5mTsc3PH+4pkETyJLTOeS4hLV
WcYnUIrV2h8W021j9/xGByQlWfE707croysbSCAW5loB7u1rW2Y8E6NU4F7zjXf4
a4Z7alQybcmYYosvhkEAR8PHnXb3Q9jP5ZehH+9yw2JGUZAvep65qOe6vGAOK9g1
r1nWOTVgnOb0tbr8a0tYlfV/iWx/LI1jd79xQkRpmt7hJ36R2m+nqcoAwza6dd2B
njUISzuxDTJRNU7yBY6X6+tiAMI5G4+UPAqFtcCYnYcIZ6pZSFGBeH+S+C7OGuEW
k/eAaqSWZ7vbyio6utJCY7PH1OmEjzTOQKvsYr8CVmUiMix5fz8o/Kv7WZ6EQm2q
BPX0e6rGYjurOnMplAIR6x3u/c75Wj/V38GnLkl4It7g6+ypaN3pAvsWc10H8Jt7
l+kampFC+1BBilJw4nq384Exhkr0q1vWvDsDO/L1NGCWDUMsy+c0CZaHYD78lFAi
GzYVdP7cXFP2Ho+VrQzjbKTEa/K0yisJIghPFJVUbiK9oC1GyU4=
=21AF
-----END PGP SIGNATURE-----

--QvLgz0ZfwNfKstKB--


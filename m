Return-Path: <linux-kernel+bounces-99814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB3E878DC4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 05:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C5F11C214C0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 04:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E7CBA4B;
	Tue, 12 Mar 2024 04:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ua6qTmuI"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E7CB664;
	Tue, 12 Mar 2024 04:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710217093; cv=none; b=nLMTkUhWcGipPcgexjVNfA+cCd9/6HpgWgq/TDdDJ4ZY3WHpixV84JK+6n8kXEkzw+JWGFgv/7Y0l0aKG/eUPzEO5JHFgtU2PDWa8i64W0hCDQ2bICxlbrTjP7lZTOLqWbfKXTpDyagsUiDoQMQKwyKNnDHkd1swXSOwPvpy3QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710217093; c=relaxed/simple;
	bh=67KsywSeBnA4HTsQSTCm+nlNA0yqUyueJPuLjaB1n70=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=TAXZ2cfpzKFLOnO7wdWWrH7jt5ZhvD2wJdD9apiY/386ABb5n85VC9+9lFH/0dZHRw4oWYpnSNwB1gqcqFfpY5trh2jNdBgdDp/lhu8uesVp02w7dECoNRlc8P1kzI9AintYgoeFIyorqZ5bKxGfLX6ZRFoNVI9fg6krnQj3SCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=ua6qTmuI; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1710217088;
	bh=9TvvWnAfPR3GqDnwETa657mhuumzJIgbVqn/uYZ9sjA=;
	h=Date:From:To:Cc:Subject:From;
	b=ua6qTmuIHrj2pMCdfYmkSduM/1FXSTNAxoMQzt4Eno/zX6qQ+GiTUrUEmaecGTZ6l
	 l1eCqJX2H37xadDTIDON5PDDIUVVV50TcqORAUZvyroTZGW5akrt6LPvb2IYw5oWR2
	 9veqvK7V1/tavkCuVkQSyDm/Q9xJKIFuF5rHqZZI29XsKFWq9EixI3auawJNjCT31G
	 PuqXjfDfausdLykIZEVfP6FK8xqxXS8rQHXNEZO9a0cdoX2doadLy1OtjgRiCJWcr5
	 Ba/xAe0BiECFvaobaEyMGc36PVWQ1t+YCtsgcAXUhg/OEE0EViDNhxQ/2aAoOpWStx
	 nxYNlTMCEW36w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tv0k81Kwbz4wb2;
	Tue, 12 Mar 2024 15:18:08 +1100 (AEDT)
Date: Tue, 12 Mar 2024 15:18:07 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Wei Liu <wei.liu@kernel.org>
Cc: Nuno Das Neves <nunodasneves@linux.microsoft.com>, Linux Kernel Mailing
 List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the hyperv tree
Message-ID: <20240312151807.52478738@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/=EPy4Pepr7P67gHlSpSx8Sz";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/=EPy4Pepr7P67gHlSpSx8Sz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the hyperv tree, today's linux-next build (i386 defconfig)
failed like this:

arch/x86/kernel/cpu/mshyperv.c:355:5: error: no previous prototype for 'hv_=
get_hypervisor_version' [-Werror=3Dmissing-prototypes]
  355 | int hv_get_hypervisor_version(union hv_hypervisor_version_info *inf=
o)
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

Caused by commit

  1634df06ea12 ("mshyperv: Introduce hv_get_hypervisor_version function")

I have reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/=EPy4Pepr7P67gHlSpSx8Sz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXv138ACgkQAVBC80lX
0GwwhQf/Vtj0UmGnlX3ApN0WWVsXI5guGkshSbgZt5KffUQxchbeqpYM3P1bVXwP
NjxGIzeCPGtkpVDDlhC6J0aJb7TDR2faaXQOv0lt2VKm/DZUV9hryIBMmuz6TIE/
s4/23yoIlmcgEPjeezN5o3V8DjhRwIOTuxAY4EmJEtJpEm4yb3PwIVRKU/xOY3m9
9kzfvxKQRlwBKVJ646xv1I1HaVBqM33ggBJ/Ka53RaPvI72YU5JSTESA/bJsDHNz
Pbe715jOqCkLxxj0JH2ppkWF0dLyY8cjNN3SDkJEIXB9iJyYpWhfShttmludlrc+
l1P4HC6Uwt0yFlcxX7K4bY35/a9WAQ==
=LFWH
-----END PGP SIGNATURE-----

--Sig_/=EPy4Pepr7P67gHlSpSx8Sz--


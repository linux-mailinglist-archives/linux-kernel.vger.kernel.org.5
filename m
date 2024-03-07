Return-Path: <linux-kernel+bounces-96106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F3687572D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B90C11C21143
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448AD137912;
	Thu,  7 Mar 2024 19:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="joI7hlY5"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882A8136663;
	Thu,  7 Mar 2024 19:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709839809; cv=none; b=Hyv5vBaIp379G7ZXYLcPVrOMc3TcNeMt1JAoKPXUc4Au7SN8qwjxOwso8tUYMPCbq16BjJumBEJ+SJxJlgSKybmNXSPx3l+QlGAh9HM0YPhthv2ZlZXBxIalmH63zLoUnDGvZJ7MXXLqDMI/YMCd3OeV1LlUE4L0bnD6kQwsWLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709839809; c=relaxed/simple;
	bh=wJoLaJdq1Fv/+NS7SCjh0EtYhm+UXGFTcT8iVAiiskg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KK/8UAA3Hv/WCL1veFFZKdClVxIEFI599/6Iek37L7yTKs/ADBsZvsDGCAEygG5lONwSh+JYSxeIrVIJa3rBiow/eMZpSVTy45NkZaUP3TOU7STlwgTrunf/15J67I+mqWsAgZJs0BWd/AiNqrNxyf4LA9NChbezE544HOGXZwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=joI7hlY5; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1709839802;
	bh=KU1bwxtkE3rw1Wal8O/VUosRk7rAUURNofEw+ycqLs8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=joI7hlY5qTGLILCxDgxT1cqU6PgjE+e7+sqoHp6LGqLtjkszUykRXWKcAdWp6l7J2
	 pL8KcL20g0LwmRiQgaUGEgbKHYv2dGUlfoRLqIRymlC2DUBO9yiKLhuD423kQu/DgX
	 5FvRikEC8Yfs/c15JFNJtqlPRLK67ZKP8Df2qi0V2/Ah/RCxziFuS9krBBMArQpS4X
	 kMAe2nFyUax+bKJTZzSx+QM7Yv+6Ib0dcfLlG0cVWahv3nb9yxF+upM3GhsfQlq/WX
	 8U0mZBJPrxJV8ptxY+jzTYrKAMaXKzqIkBzlU5XccyZk572/M4lsmGigvQPRApsFAm
	 /uI1ZL6knyEaw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TrKBd4bs8z4wby;
	Fri,  8 Mar 2024 06:30:01 +1100 (AEDT)
Date: Fri, 8 Mar 2024 06:30:00 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Lee Jones <lee@kernel.org>
Cc: Duje =?UTF-8?B?TWloYW5vdmnEhw==?= <duje.mihanovic@skole.hr>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the backlight tree
Message-ID: <20240308063000.6fdce0e5@canb.auug.org.au>
In-Reply-To: <20240307090446.GL86322@google.com>
References: <20240226132828.7524baec@canb.auug.org.au>
	<20240305111634.57e84398@canb.auug.org.au>
	<20240305091737.GB5206@google.com>
	<20240306095539.0da4e342@canb.auug.org.au>
	<20240306140427.4cb24a5e@canb.auug.org.au>
	<20240307082445.GK86322@google.com>
	<20240307090446.GL86322@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/z59s+w1zqDcFC_IrEq9uYSO";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/z59s+w1zqDcFC_IrEq9uYSO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Lee,

On Thu, 7 Mar 2024 09:04:46 +0000 Lee Jones <lee@kernel.org> wrote:
>
> On Thu, 07 Mar 2024, Lee Jones wrote:
>=20
> > Right.  So you build each tree as its merged?

More or less.  I do some batches of merges (since otherwise it just
takes way to long).

> > My assumption was that all things come together in -next?=20

This is from my daily summary report:

"Between each merge, the tree was built with a ppc64_defconfig
for powerpc, an allmodconfig for x86_64, a multi_v7_defconfig for arm
and a native build of tools/perf."

> Okay, all patches are now shared between both branches.

Thanks.

> Let me know if there is still an issue.

Will do.

--=20
Cheers,
Stephen Rothwell

--Sig_/z59s+w1zqDcFC_IrEq9uYSO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXqFbgACgkQAVBC80lX
0Gx4TQf/eoxlAZAPSxJNNF3CCPHMg8OORBKeTG0zw1E9IU5iIv4li3KbRtlo2hib
45aDpV294lWqAIl3h81khVmkqx0YjD3GHF99tP1KRsua3gbBldCBGJ5keokHu8fo
CWtxT+tH7knr1PuOkirj5RFmpnpzYvJFGZ3cOvUncdHNtjKrePHBBSbv7TCofisk
cyCGeskyR3jxm4PWCv5umwKb0GJ5ix0ye63nqGfuDHCJyK1YaFgslNU0C+41VT+C
1clRt+Jss87rZ5QshWoCCsiRy3kInrRlex5yh9RImeDI/aU/aDhllPpUT6ljDxQ+
vneleEFLMheYOyGNZZEVWJ0KnbZ2aA==
=Jobu
-----END PGP SIGNATURE-----

--Sig_/z59s+w1zqDcFC_IrEq9uYSO--


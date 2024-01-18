Return-Path: <linux-kernel+bounces-30576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EEAA8320DE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 22:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E59DB28698A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 21:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C1031734;
	Thu, 18 Jan 2024 21:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="j0l9DS99"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C012EAE6;
	Thu, 18 Jan 2024 21:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705613259; cv=none; b=c9Pc4RfhdrN/dVoUEiKmhvYyIENCLmdfKGno/p5IlI8tRg0NF0TIqhWu5D6yHXNAn8DZWvr65ybR85cgk0VReaP6p2A7q7fAHyinQHvdThcNzFT0nGBXFKNdi0lq0+QCJ3M54LWeYLL8sV4/nigWAnMt7nFNlSryFeeQ1M+WM4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705613259; c=relaxed/simple;
	bh=EXmyvwXfe2wPVitKcnaQ8LBCfYoYq51kaKNX4iec1X4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=BIS/Mgkpe9WYnHvek8x18GPuGP1Tmwc27UV4hsOFo2kVemzEmYxBC/QU1EcNM8z2e5Vafn4ORZ2DBjlil3LFXojGkrOc9SrWON6iU8P9UpByVEeqfo04fT9Vsn6CjE7TGw6NSYFXTOPG+Q+mK9DUhSRl0X3v90i6m77ukEX0iaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=j0l9DS99; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1705613252;
	bh=NYOuL7qqpNh6NMr9Dx3/9PMZZzDpeA4Tl2561B/4MPM=;
	h=Date:From:To:Cc:Subject:From;
	b=j0l9DS99gkKo0uWIigetpm7/o9sVxGVnPZS11xACdY1pCPInGpGWnF6tnvVou9zSs
	 X0HgiaXGBxV7KraoEN6F4JcuQpo3nMWvFWUrUPgX5RNPo1So4lGxBE4V0t5vN8UwyO
	 ner1pibxWGK/PLWtePpMxYZS7Ls1GXinbbAv/Y1YVdEEoxWiSrMBVx7xS9q6cZDi5J
	 FRNrecu6ScBL01blrWoCxoeZ56WH0894fuUMkue/iRqOtFTiWJcg2WpttUCy+R7PLJ
	 wgHaMmMM5mh0ohsXd2iegoUTAX3ZP3VhTRwNidNQNIoejT2Is5VNiELfjU9akdjx4c
	 FbAPXsEFU+t9Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TGG6r1tlrz4wdD;
	Fri, 19 Jan 2024 08:27:32 +1100 (AEDT)
Date: Fri, 19 Jan 2024 08:27:30 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the kgdb tree
Message-ID: <20240119082730.44e1634f@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/H9DIc1L+tKq0zf4VYXzkNo2";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/H9DIc1L+tKq0zf4VYXzkNo2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  4f41d30cd6dc ("kdb: Fix a potential buffer overflow in kdb_local()")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/H9DIc1L+tKq0zf4VYXzkNo2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWpl8IACgkQAVBC80lX
0Gz+/ggAlAHOX+wKYrysem0u6MObPp9O91ynGHgBmNyNtf/aUgXM1DXIaYP1G1rw
UfwAqLlV+HuSquD2MvEqGVX4ZYDn+lBkxMiNSOns4QK5p5mNu76HQckMTSuQ4S6y
UMJDkNoq9jrfL4tWbZdebZ9BJWQUraodgZQyZUyNeJrIth1MwsCGttmxb2MLQoeK
um5YjswCw4ORnYH4APq89MiMcVUIi2M6MV35LXlmfBqDEqd0ohuB9XfveznOz0UE
Z6JaLv6PA+gciA8YlLmD+4ro0+CawIKB0TdSuBr+IeFoG2ifB7nPgy83SxcInfd/
0lEgv/Qi39PcEMQGg5KDkDEOsjcVuw==
=75zn
-----END PGP SIGNATURE-----

--Sig_/H9DIc1L+tKq0zf4VYXzkNo2--


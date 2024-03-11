Return-Path: <linux-kernel+bounces-99555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39AF98789EB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 22:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD007281BA1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 21:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2BA56B6A;
	Mon, 11 Mar 2024 21:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="tuqURkAF"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DFD3CF6A;
	Mon, 11 Mar 2024 21:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710191807; cv=none; b=VrPjEVeyLNIlLjaP1w1NvZmWY4hY5o1IsaNLlwbxU1IhAwB1ACIpnL6SiRrQo9d3tjUHnHFHwTKyhRKhi+MLMQ4Z+GSehae+s6GcuMwLjEAaYF4Rvwwkmu7VMhYKF1tSZSdwZy0neisvCFwJDXFBcMwJqADA4p2HSw8JXltzSO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710191807; c=relaxed/simple;
	bh=NQAUdkeOMHCqXYt8dPtca8uRa1FnOu5SFXIQfhNKX/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=PpEXf8TsuBm36QCU+4FACSYY/ca6/lv6ZfiAstfseMIg26269VHasebDzoKhQWjxZ2Qefw038nvTpnU0ZbD1oSxOIzH0ulmDsOI6QF2whEjCGM6HxDRdxOPshjKrz7EzSNbC2I5nollkGXqKMUem39yFH+2gQmRtyU0/8q1l4lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=tuqURkAF; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1710191794;
	bh=r7YQNuX1FwERL+k0Ou4dBK9LfRd9VlTsxLg8B15x4JU=;
	h=Date:From:To:Cc:Subject:From;
	b=tuqURkAFdgBdA7OF7OrW1FYzi3fJZuqfTnZ4D8N5Vlu4GjvXuadG2IVR8o8W59fo4
	 9oFGbH82GeRBI0JvG1PCoiWduZNZqeAg4L8CWmtzY/gZ0tcbUcIAvC3h6u+GsarBru
	 7ogosuK095z/iJAypkeU21bkScYiIzCoUXDF3WAut7pZEmiOH79LloIEKOxNpJY4Jb
	 CsLdoC9NPb2xdOM1vpcN4xxN23L96eP0vgUt9Q0KPcUj/zMz1OT4oTroc9HoXF71DJ
	 oer6zVMPZtHOm5AF8pRjSc6yJP8Ih4+2Vg9V4q0O8N2XCcvMOST66xv8CRMDje5jlr
	 M1DrfFjyYrr+w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TtqMk0lN5z4wcq;
	Tue, 12 Mar 2024 08:16:34 +1100 (AEDT)
Date: Tue, 12 Mar 2024 08:15:58 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the i2c-host-fixes tree
Message-ID: <20240312081558.014deb45@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/U4vKAAIg+IDNvwlTeXq0OF3";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/U4vKAAIg+IDNvwlTeXq0OF3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in Linus Torvalds' tree as different
commits (but the same patches):

  1f78f0901011 ("i2c: aspeed: Fix the dummy irq expected print")
  7c16cfd69d51 ("i2c: i801: Avoid potential double call to gpiod_remove_loo=
kup_table")
  ace9dc1d1251 ("i2c: wmt: Fix an error handling path in wmt_i2c_probe()")
  b60b86b55400 ("i2c: i801: Fix using mux_pdev before it's set")

--=20
Cheers,
Stephen Rothwell

--Sig_/U4vKAAIg+IDNvwlTeXq0OF3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXvdI4ACgkQAVBC80lX
0GwXdAf/UuTKraVoHjd6/gK6M0txixayi+arlcSYb/6IxTo+9pH+ZNjTIlK3DWit
AhZz6fqQjM5jtInemnKQZg62TmukDwcKcJGRvT+pWkwYwtcAf8cdPjRyNfB1S30M
i7UguYdxhzjcH84y5vtdtRYFvGx/iwozSVtl4lz/N5QbM/Hr1EXMomgvNCke8i9v
cHhBAYAndLbHd+Wd6BLuEI52aJCZQODgGn/3hm7i6cRpI+fomGoQoIjvCzsGl3+9
IktQLYgAoDFodXdCMVFmqAyZn/D1GAkTQp6Ob7Yiz7vQ6bXBrLmAUdE2FYSW+Sgo
yhZNcvrdE+9xbCX689wvNnsvIVbJ9Q==
=qhve
-----END PGP SIGNATURE-----

--Sig_/U4vKAAIg+IDNvwlTeXq0OF3--


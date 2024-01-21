Return-Path: <linux-kernel+bounces-31993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97970835504
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 10:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B9681C21598
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 09:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E912F364B7;
	Sun, 21 Jan 2024 09:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="E97Ug9/o"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8041368;
	Sun, 21 Jan 2024 09:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705829615; cv=none; b=QwyGF72A7RIqHDXCJszdemG/g7smDKojeOKNlQbd4zflURsBwfvSDe3U7tihjApwKB0TTFEnYmclCKjIjwFhDHHstpnB6b/bHYOCBbbVE66b7loxDs+H0QyU/KUPxSseuNPT98aTZqZSfq9FS0cN08yPf50yl6edjMDOH7H/VtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705829615; c=relaxed/simple;
	bh=x0WTgOw5X/Pd4aSkhegE0fLrWXft7tf9f9AZDogGONY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=pqG/6WjQI9Kl1/z1vEsBQijxDmgzZbhPmzKtkOxuHER5jLcXFF0kivbiETXqKJxtnnfUOArkbLjnkOmlqXsScvbwa5xnw4o0ESS+DgA1j+cVZlLD1BUCm2DSZIqxwJg+0djy5L6SJcQ9vd4cEmsj2NxqaMVyd2Ct02DgNyIf860=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=E97Ug9/o; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1705829611;
	bh=5G+eaVFkO/D7dqydxSHtpCHwr3YRctOS+n0FL5yq1TM=;
	h=Date:From:To:Cc:Subject:From;
	b=E97Ug9/oI2DBQkpU19CEiUyWxE+jro79FePRNFFXhLuCukpUWVv4xo4w5LB+uUUCy
	 fQYN/15ifH24KgLWZHHtfCvSECFKpY+BQetqLA1vxK63aFNz9mm01/6LO2qCeI6Ejt
	 3toRgH52139WX7vvoyttsmWbrym+hMq8YQBvPpezePCkUQkP5xuI2g6KEU4kxrR/CK
	 ryCGb+k7NJ2Lz2juqYPOnE/IGfw35Sljmsg5g4QungksxFXTB4HB6SMDnFyaTC5mgn
	 dtlYzC7r/JdFZJZRSqY32NuAV3fTTsnGqGDR0NpeeO52pFpMvK1jYI+KXS12lMPrH7
	 EILE78Nptx5Jg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4THp7b0RMjz4wd5;
	Sun, 21 Jan 2024 20:33:31 +1100 (AEDT)
Date: Sun, 21 Jan 2024 20:33:30 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Rob Herring <robh@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the devicetree tree
Message-ID: <20240121203330.5d6a300a@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/lxSrV+PI3Nf+8DCMwBEZY/=";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/lxSrV+PI3Nf+8DCMwBEZY/=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in Linus Torvalds' tree as different
commits (but the same patches):

  05f7599c60c9 ("net: can: Use device_get_match_data()")
  396b0c8f30be ("thermal: loongson2: Replace of_device.h with explicit incl=
udes")
  d57d584ef69d ("of: Stop circularly including of_device.h and of_platform.=
h")
  f5cfd90c1ae0 ("sparc: Use device_get_match_data()")

--=20
Cheers,
Stephen Rothwell

--Sig_/lxSrV+PI3Nf+8DCMwBEZY/=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWs5OoACgkQAVBC80lX
0GyK1wf/WTCMICSu9UdCtggL+Kc1DfjGyQDXBspV1xaKLKhuBMDhWEXWmgu45/dd
owPMhrZ8BIPToTbjOOBJVkMBFQgTbyu4wypIpyC2Vn9oS211kCmdzgO9NBZ7p8Yp
CP/9lwb4lddC+29jCfNFEknhxApVOIKq+yaRWe3S7DE2FSHSX4JvW+ZCM3rfaKWO
CUxgpfZ+8p5LhlvEC0fjNK2EK0sgOMvrS3k6ZD9EbvO2xGqEMP1Sy65CPXStu2sY
pDnGeEGGrk/08bTMYWAhxiucEYbULd+pSsdM8HmrufRj6LHKWTMMdoPU6Ul0BWAs
An0HzrNbP0mEntzmO2/ZSZBxnxbFGw==
=ekWp
-----END PGP SIGNATURE-----

--Sig_/lxSrV+PI3Nf+8DCMwBEZY/=--


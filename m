Return-Path: <linux-kernel+bounces-127066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68277894661
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 23:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DF5A1F2206F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 21:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0AD548E1;
	Mon,  1 Apr 2024 21:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="qGtlMVtk"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FA7537F7;
	Mon,  1 Apr 2024 21:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712005437; cv=none; b=tf7xjTpOxFo+PnwM0xe+SC0heSDDyYzsilXAmvTCn0dGQ1JaKoWdREMzdAnm/sbSDiA5c4N7HAd8IBP8pCUmbncKWqIc4aRKIoa9i4qBb+LogM9oyCe3Vpv4sK6CpKxPDVZ4BCSEHiILOIhRCagMUCXUdBfYMvJgwNN0wHwXxLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712005437; c=relaxed/simple;
	bh=9l6cBu3V5d30HaFNptLp/c4aXW88N2cmb0KpYWjXU5E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Sr2iQj8jHKmO/IMJauf9MjBZQzfGWrI/0fTXuQYH8iu8/KOrLHdWujexQsEOsfCxrLYy7omHdcTdSTEo5nRFevJcqU5DAkKq8EL6msTg0WQ6Ilbg1ZdVnkqSfvS9JgJ2Uk5XShHx+EIdAM0f+kTCwsT4xYYTeXToH9Am2/fHvIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=qGtlMVtk; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1712005431;
	bh=Bt9PFvB/sRefEXLxtk1k/XnxjjhMktTWi4JtFZS28Aw=;
	h=Date:From:To:Cc:Subject:From;
	b=qGtlMVtknI+42Vx3TNz0jcrQNAA8o1S/VvQwdH8KQwc41apq6DWPE8OcHQC+cGCBB
	 V3mK9eOiqubB1jp/BhGFCsBylxBtq4H4T4p9mqj6sszEhtCOvQBwLEg3IqjfUJ7ffs
	 sFiR+TVh2mLNzjln83W4O2JGp7BLPh+QszXGekDSdhgLgH+PQn2B3ooYRfQlPVmO20
	 9795F8NPFCBtbrqHiK3lI3w+AVmB2VOFYYJAa/xmNhJJC8BnZIb8gFWk/RPhdV+TGs
	 ENdDqSwSESPoSWM4ieMq83OI45TIyTrV5aKJLZMdsnTh05Nv0o9KEkXv1z7qihduTS
	 nUju6CHtmhJ9w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4V7k5M44Kdz4wcC;
	Tue,  2 Apr 2024 08:03:51 +1100 (AEDT)
Date: Tue, 2 Apr 2024 08:03:50 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the rcu tree
Message-ID: <20240402080350.2f28da4a@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_//hIX_gvrTyAgSTSj4ganlmp";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_//hIX_gvrTyAgSTSj4ganlmp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  e94061cfa1d6 ("rcu: Do not release a wait-head from a GP kthread")

Fixes tag

  Fixes: 05a10b921000 ("rcu: Support direct wake-up of synchronize_rcu() us=
ers")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: a2b9f1c8a1f1 ("rcu: Support direct wake-up of synchronize_rcu() user=
s")

--=20
Cheers,
Stephen Rothwell

--Sig_//hIX_gvrTyAgSTSj4ganlmp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYLITcACgkQAVBC80lX
0GzWuQf/cdaQhjGxb4qOZgCvkpTjTEbiHprrU6rnJvFBEsjrcqOAEbvt2weOAqEC
3NCm2At+EFOvDRUxTIhL6GA+ptdauJRMRhfngBkKXydMIdayNZjDZPxGAZFwK1Sy
F7NbTEsp82i2waAGA4gerONShQpZlGUNZ0oo13LGf2+9119v9M50lvieiYmMIJ8o
4tCgAlMjAutUuy/z60b1smRODK8QMfmGTEGExQlARqtVXC8Dq82NT7SkN3vM003E
yFZPX70CKSTcpX6yO05FsXScMiOMA+kT+VnfW5hCH5rW5RUvB/v3duxM6Wc3Sdty
LDe+6h52V80/LjHRAF+9mf1ISBGKLQ==
=625N
-----END PGP SIGNATURE-----

--Sig_//hIX_gvrTyAgSTSj4ganlmp--


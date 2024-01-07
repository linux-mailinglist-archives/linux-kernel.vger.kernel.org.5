Return-Path: <linux-kernel+bounces-18877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E852826472
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 15:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB3F82822CD
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 14:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F2D134AC;
	Sun,  7 Jan 2024 14:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=ethgen.de header.i=@ethgen.de header.b="ycRvJlVk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from tschil.ethgen.ch (tschil.ethgen.ch [5.9.7.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5430134B1
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jan 2024 14:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ethgen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ethgen.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ethgen.de;
	 s=mail; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=i5zI1puaV542LYCAwbBx9ujBev1DTblX1zCJ7QGg+h0=; b=ycRvJlVkG+l7C26J0FkYQfURyL
	RFBlzXqXhqV80dOA0uR+IlOKvIqMuhCabiK0DPSdc2yevzZalH9QpnQwE9VCFqb3XGOxiQ/4CVYzj
	ljCqS/oVi6HvDwhghQDegNjSnWqpsRLdBHYTRqFE6skaH11jiqPUSdk8t0Jk92AXA9Y1SmhO+tjJK
	CNUxCwjzUk+WEu2nFU8KajpNPIOQO4/mvkGZI4SbSwSroOdSCfOy922X4tM3ZrHmU3WKLa6x21ciw
	T5HJLhv5B3imXlcdK+BT44I1ZK+8FvU5DXVoWpPuX8UmhL794r1N6/IgU5sulYni7NiXx1Y6u6jWS
	leDwIpBuB8OTBy54JSkaV06Why0AZ6cwMz3TiJj5Z/GiTTR7YYVj0BtMqbc3W1WYrvgIZQ8nr4nmu
	pj3eveuvnxX6z7sTS/XCxxMvdRTFkRa11GRWcHM0BqIQCSiqlKClX5oDUQ87bnXz1hLRn7QPD1JRV
	pUi/EIDQWkEEhjNm/8dBudas0S5kobeBJ5KdMlRjBkHJ0MudAbgGrNSBE5mVp4p166qjak8nj89R7
	P1dKfUQTeZtTCHuMmbjVRYW4tLeXI25ogohnGpuZ9WDGt+rIN44GYy1t13/voeT20sltRcFdxruZA
	vTqtp9VEyNcO+OKu7C6YEGzHuslN37ula4xVxR18k=;
Received: from [192.168.17.4] (helo=ikki.ket)
	by tschil.ethgen.ch with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <Klaus+lkml@ethgen.de>)
	id 1rMTqD-0003wE-OS; Sun, 07 Jan 2024 14:09:30 +0000
Received: from klaus by ikki.ket with local (Exim 4.97)
	(envelope-from <Klaus+lkml@ethgen.de>)
	id 1rMTqD-0000000088i-1qeJ;
	Sun, 07 Jan 2024 15:09:29 +0100
Date: Sun, 7 Jan 2024 15:09:29 +0100
From: Klaus Ethgen <Klaus+lkml@ethgen.de>
To: linux-kernel@vger.kernel.org
Cc: Klaus Ethgen <Klaus+lkml@ethgen.de>
Subject: Mouse wheel resolution with kernel 6.6+
Message-ID: <ZZqwmckYIS1rLEAP@ikki.ethgen.ch>
Mail-Followup-To: Klaus Ethgen <Klaus+lkml@ethgen.de>,
	linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+YKMPQZVn1NZP14I"
Content-Disposition: inline
OpenPGP: id=79D0B06F4E20AF1C;
 url=http://www.ethgen.ch/~klaus/79D0B06F4E20AF1C.txt; preference=signencrypt


--+YKMPQZVn1NZP14I
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline

Hi,

I have another minor issue that I don't know how to fix. (And even don't
know which subsystem creates that issue.)

I use a Logitech MX3 via bluetooth, which work fine for kernel 6.5 and
under. But when using kernel 6.6+, the mouse wheel dropped the
resolution to not usable slow. Scrolling is not really useful that way.
It seems to me that only every second scroll event is forwarded to the X
server.

Any help to identify the source of this annoying bug is appreciated.

Regards
   Klaus

Ps. Please keep me in Cc as I am not subscribed to the list.
-- 
Klaus Ethgen                                       http://www.ethgen.ch/
pub  4096R/4E20AF1C 2011-05-16            Klaus Ethgen <Klaus@Ethgen.ch>
Fingerprint: 85D4 CA42 952C 949B 1753  62B3 79D0 B06F 4E20 AF1C

--+YKMPQZVn1NZP14I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Charset: ISO-8859-1

iQGzBAABCgAdFiEEMWF28vh4/UMJJLQEpnwKsYAZ9qwFAmWasJkACgkQpnwKsYAZ
9qyDnwwAiNdnAeo7CzTKcR1kidk85U9v0Dp5yVUBWqyOfCQVIoj6hOYs+bKSxFGC
5QBUC2SHnEmRS5ESgBCj7uUcj2VJtd1nC/RNb3PFKppIvEvI5ajzSEzzpV6Mka1g
AH6jZuW/8saUYZ7HHu+wAkZXnylPBOoXKOy86m/mbH2LSfxMgMc1hm7304Xd0sqH
zWcJgxY6abGmI2zYIbIdSJTc4aIyn4g0pCvInbZrbX3dAg3J+44hndoWTaIE/d8s
UkDfttS0wee7/wnViwl6PGZjkTh5tbjxBm5R10cK1VzHP6Xq5w7ksZbY+pL5wDsE
qb+xE7D69bReOdkrje73jKgiTpkUgFBSm6p4mxdMXXWZBfyTnDi0yN0msNWTSXvh
P37kFwC//QFaQL0Zxt0T/3jaOYH5R2KDRLLXDApeHBh0TFQ2OH25J/YCoj+jpBVw
Vphx4eVfI6ZLBh1lG32gWpSNKC+32VloYJHCy1Fs+D7QWRzclasDku+sf8FjYMU3
X37HJUz7
=2LIw
-----END PGP SIGNATURE-----

--+YKMPQZVn1NZP14I--


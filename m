Return-Path: <linux-kernel+bounces-66240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BFE58558F4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 03:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7686F28F6FF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 02:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A117364A;
	Thu, 15 Feb 2024 02:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="aYrZu5gx"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DE03FEF;
	Thu, 15 Feb 2024 02:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707964208; cv=none; b=NEyf9Yc3S3G3zY4C1ydWC6J5FlLBUOfZZNuAgM9IhwjENh74+0nZM95CAMozOpxiRhRwOueGZoyhmsfdt0bSYzNsAy8hiUsFjcZ8df1IKlQa9UaEaDWhkw1OVKaQ9ft5ymKfjVxjJRoxhdUosjJcEUN5JeMyHzFeXnnv+HmhOXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707964208; c=relaxed/simple;
	bh=LVa6TQR2ubWCWAbXH9G7raC0OPAwoLfUp9WeQppAu/g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=m11jK5u2EZToFq6FQ0rkazBJAETCg+WK2YYG1SnHr8KDHMHySAketH1/c43sAeiHDwW8NEJEg6fn9/4SWsIste1vKZ+9DJ0p5j5Ti27OTYaLTjSEDxrzLxvqJn1rW1W/lPlpIyRVDqcoW16VxwWszFjTIPPVbmn3k+zlHbtlzkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=aYrZu5gx; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1707964194;
	bh=90YqM914shKUVf/nn8h70J6ciK5KWSzDwzEM9f+oKzc=;
	h=Date:From:To:Cc:Subject:From;
	b=aYrZu5gxYRwUPGVKk/7mIVn1i14IjgI6BmCOcv/uUyS1E/LEfR4v3AoiV8ImdMvpX
	 b83R6FdjM6lTXQMvrMO9gHo44v1t4xk1vXpjYsIlX2BRXu8t5JeDsxM6nh/AWRLfjE
	 HmqRl3EahDyUwdji6P7lHC/Lk3pYUtzNtCZNRMTn7QXp5yawGFPiqo9AqjNWgUP/F/
	 n8/pXXK6oqeIJc70K8WjqADD5xixdvW/17/lectvEtqa5YcvN0yxgRrUWKV6eRAi32
	 rCyyjIuCpzbuwb7ejuyeNwms6R8cH3T79ZfvHyp9ZhIYAZFHeMr6lzj7Nuf9MtvHaE
	 wv2KRLpA+t9eg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TZzYF2n1cz4wcN;
	Thu, 15 Feb 2024 13:29:53 +1100 (AEDT)
Date: Thu, 15 Feb 2024 13:29:52 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Greg KH
 <greg@kroah.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Christoph Winklhofer
 <cj.winklhofer@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the w1 tree
Message-ID: <20240215132952.6c83ab23@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/zKc9Ct.VwZnhFkAum=xP6yt";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/zKc9Ct.VwZnhFkAum=xP6yt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the w1 tree, today's linux-next build (x86_64 allmodconfig)
failed like this:

drivers/w1/masters/w1-uart.c:314:24: error: initialization of 'size_t (*)(s=
truct serdev_device *, const u8 *, size_t)' {aka 'long unsigned int (*)(str=
uct serdev_device *, const unsigned char *, long unsigned int)'} from incom=
patible pointer type 'ssize_t (*)(struct serdev_device *, const u8 *, size_=
t)' {aka 'long int (*)(struct serdev_device *, const unsigned char *, long =
unsigned int)'} [-Werror=3Dincompatible-pointer-types]
  314 |         .receive_buf =3D w1_uart_serdev_receive_buf,
      |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/w1/masters/w1-uart.c:314:24: note: (near initialization for 'w1_uar=
t_serdev_ops.receive_buf')

Caused by commit

  178cf9db9e6d ("w1: add UART w1 bus driver")

interacting with commit

  fed99212acae ("treewide, serdev: change receive_buf() return type to size=
_t")

from the tty tree.

I have applied the following merge resolution patch:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 15 Feb 2024 13:23:35 +1100
Subject: [PATCH] fixup for "w1: add UART w1 bus driver"

interacting with "treewide, serdev: change receive_buf() return type to siz=
e_t"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/w1/masters/w1-uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/w1/masters/w1-uart.c b/drivers/w1/masters/w1-uart.c
index 6950d29d7dac..a31782e56ba7 100644
--- a/drivers/w1/masters/w1-uart.c
+++ b/drivers/w1/masters/w1-uart.c
@@ -289,7 +289,7 @@ static int w1_uart_serdev_tx_rx(struct w1_uart_device *=
w1dev,
 	return ret;
 }
=20
-static ssize_t w1_uart_serdev_receive_buf(struct serdev_device *serdev,
+static size_t w1_uart_serdev_receive_buf(struct serdev_device *serdev,
 					  const u8 *buf, size_t count)
 {
 	struct w1_uart_device *w1dev =3D serdev_device_get_drvdata(serdev);
--=20
2.43.0

--=20
Cheers,
Stephen Rothwell

--Sig_/zKc9Ct.VwZnhFkAum=xP6yt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXNdyAACgkQAVBC80lX
0Gx0nggAlsDOQAnBfleT5Q1ZDV4jaUlLKb+L0t8Q/6kEqIrC3bzx6XAC7UNc2HMk
5zngyK+OgfuKoluQ9WBYcoRPAYmoG0T78yuttueSuLLZ5qz0vfQJEd/fDVnMSG0V
XFRWK2Hha8ezHBMVjtR5w7TWdtGOkMbGomO6QY4yGDm6HOeahF/9L/3GHURpHznV
1bUeBbTYzbMc8TXm9nEC32FtkrE1uSegOjdhZZhIX7CNieuoBLJxXXyycuPlafG3
SG6CBrxh8FWZ8AHgITq/dVjR0jw1CfFNc+CjFMj4/oOVtBfBHG1/l4Fbdx/FL7tB
wynOk/EM8degtY+I1CWAwKSYdrrvSw==
=x4BQ
-----END PGP SIGNATURE-----

--Sig_/zKc9Ct.VwZnhFkAum=xP6yt--


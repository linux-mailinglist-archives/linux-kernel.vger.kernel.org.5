Return-Path: <linux-kernel+bounces-58982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D513284EF5F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 04:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F7671C25B60
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 03:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86FF5226;
	Fri,  9 Feb 2024 03:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="b0+zLVId"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D544F4C83;
	Fri,  9 Feb 2024 03:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707449080; cv=none; b=kTyr5sHZowsGTMhN+ykyy3JZrcsAW1Z1CNSjA/kyD2kavq+trcvBTkKTYA4Yh5jappKmYqWJvmASlTM0RzpRKlVkqD/6FWB9B0Kf7tcMhAVQHn7pW8f9HMFyIqHeII5QP6jSYZwBbAypIHKz+sSbv4b6CEaQwbQTrL1e4ob66uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707449080; c=relaxed/simple;
	bh=keNyoYba4HEV7avbqgz/8LCi3ewXRMu3T/2Vj55Pa4M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=jtcjNjTW2TljcBhzpxa+jizl7dbtZJHZbFVZ3QVHrkOEh87TVDEcBWn8505sKH91G+GosmUS/3o5sTRGNyuRwWB+y85e0bkPpS212+rKo3A/Itybm5mBH5f1FUiRTCsSkkOpzTJDMR/VMNvh3RHKdGYYlJStDZoFiyRcvX529qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=b0+zLVId; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1707449074;
	bh=mqwjqqeUnv+EbUvdmXIOMlvHo8faBL+1rKYd8AyQTCI=;
	h=Date:From:To:Cc:Subject:From;
	b=b0+zLVIdZFn6JS3dXuySGJpnk4UW5rKJ0XnE/TwrQzp3oF2pcIKDueei2CzaDh8eP
	 TltDNGqzJb+450u9BmaLYgmU0obmRFthToRcaSjn3KimwnAkjLCo3bJSZApSrQmQiA
	 wgyW+/aWQOUzMhmyhVE44MOxjrgYgmCvc/n6vChbVNeqOGTqq0rhVxb3b/1pYbH4CA
	 H+x7Ymawa67ZNBuFV4rCT0GwvDMcGam0YCWpEhiQRhtKribXa9jDc22lQgET/Z1N5c
	 4RgoiCXuw10W61dMHPRLc3eTODcMIVPIvIE+V+C/NSV7kd7Frv7yMJmwt3QFWmLLvn
	 GHHJwmFh/5sEQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TWK360wqRz4wcn;
	Fri,  9 Feb 2024 14:24:34 +1100 (AEDT)
Date: Fri, 9 Feb 2024 14:24:32 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Tejun Heo <tj@kernel.org>
Cc: Waiman Long <longman@redhat.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the workqueues tree
Message-ID: <20240209142432.05acc1b2@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/1+dIqgQJIv4JlIumorOGBYS";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/1+dIqgQJIv4JlIumorOGBYS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the workqueues tree, today's linux-next build (htmldocs)
produced this warning:

Documentation/core-api/workqueue:778: kernel/workqueue.c:1801: WARNING: Lin=
e block ends without a blank line.
Documentation/core-api/workqueue:778: kernel/workqueue.c:1804: WARNING: Lin=
e block ends without a blank line.

Introduced by commit

  4c065dbce1e8 ("workqueue: Enable unbound cpumask update on ordered workqu=
eues")

--=20
Cheers,
Stephen Rothwell

--Sig_/1+dIqgQJIv4JlIumorOGBYS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXFmvAACgkQAVBC80lX
0GxwfwgAkSzD8oznvJ/o+occap7INNMvY/S7erEIpIc3t4U/QGVWPcDKEemgiOyh
dm7cxbAfgGwu5S5/okTquOd7pO1OAnXERagnPP2CRJ0eVBSTHKIqOhagfoz4VBpp
ESz+mB/MynxnDxQA+jwTkxd2egCnKUUNNophlaJzjF/0skz1f4vM44tEOwaXokhQ
WuGqXz0j5Urn/5p22doLPsyiaqCWNWXkJC7UxgEehDZSfBuTS9PDxVYHTS/oxYej
51u/HGq6oWXfHZMpEnSyrXy0W7hacA4VD8W7MyMdYdkTUJQENTIyp2ncF1P0LtoF
UxLq+kFAr16hPZMF3nSujfNZiAfADA==
=zZ8T
-----END PGP SIGNATURE-----

--Sig_/1+dIqgQJIv4JlIumorOGBYS--


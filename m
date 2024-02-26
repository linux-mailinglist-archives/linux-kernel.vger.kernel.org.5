Return-Path: <linux-kernel+bounces-80412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D322086683D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 03:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DB381F21D01
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 02:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C131611CAB;
	Mon, 26 Feb 2024 02:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="niTgoGNx"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48AFEAC2;
	Mon, 26 Feb 2024 02:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708914516; cv=none; b=px2xnfPc0wo+xoAQHeanad6C6BgxTcrthrZUYCfl1y8Ey0AnMsGx8vbMDf2MctJdFjWMYQVGw2ZQhWS/9imaiar+OVaM860U5BO+7TzRwdwrADb/nCZkzfFaQVdyGlKktGyws+E5L3pm5loG1y3iWUSAn8jqiAUHUzMB7nQx1GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708914516; c=relaxed/simple;
	bh=fsopglJdRFwGm3H62RCpMGMnE2IG6io/oYNlk0F4rXM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=csTaCNhuhiZNfQob+zYaUp24JVHI0MGuQBgPhq78kXoR/Q+Ftzm47yQHo0f8oes5GoNCVWl91pB3mBCDHlQAy52eC+POEGSsFojCBWoAsMNX3JM/cNy2BFKwhCe05rfGiZnXgI1v75mlXhPJUiIePRpnqcop/zgtoo05817hlC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=niTgoGNx; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1708914511;
	bh=cFv/nzsZu1HHeCs5J+fMBi4DZwXqF7EVg81/vbEs3TQ=;
	h=Date:From:To:Cc:Subject:From;
	b=niTgoGNxnNtohOGApiOD7F1WgcejX7ottNMr+8/OQP0k/9RHuMxIJUAE7BEr3HCJs
	 HBbT/MclqOcrcYGWy38ES2x5qcGUX3c87Q4hZtRRoJBm0wWHwAlOJVCWPF/sEP1mPh
	 /layVs5rzHqaz5yh1SB4cqc6i76jD12KntcZzZNdW1+s/Pq/PJiUgS8J0DCs+Vg/Qd
	 Y6FgD5nTEjMN1M6WkawFF6Z97j1LIb88JlEmFO5GJw+K0Ex4Bq5uzlxOjQCwfJKtxy
	 pugODvkiRWjLzU+NYIfQF4kpVOvCPn46b+7VCYzPHssKITWpLQ3G/UIdcMJ6+NR8Ns
	 yUP7VgY1cdzaw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tjl0Z1l3Gz4wcN;
	Mon, 26 Feb 2024 13:28:30 +1100 (AEDT)
Date: Mon, 26 Feb 2024 13:28:28 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Lee Jones <lee@kernel.org>
Cc: Duje =?UTF-8?B?TWloYW5vdmnEhw==?= <duje.mihanovic@skole.hr>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the backlight tree
Message-ID: <20240226132828.7524baec@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/zjqY4iyeTAxj_lJqIElMEXN";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/zjqY4iyeTAxj_lJqIElMEXN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the backlight tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/video/backlight/ktd2801-backlight.c:8:10: fatal error: linux/leds-e=
xpresswire.h: No such file or directory
    8 | #include <linux/leds-expresswire.h>
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~

Caused by commit

  48749e2f14e3 ("backlight: Add Kinetic KTD2801 backlight support")

I have used the backlight tree from next-20240223 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/zjqY4iyeTAxj_lJqIElMEXN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXb90wACgkQAVBC80lX
0GwXGQf+P/mv9iR04ObUoVt4M7hZB9H21F5ShyczcRsHaTwOx/xJGzqqdEy9BQaq
+CSER/s2MULPgwiTNebUlNYtz+g19ftOO+upUnDdzV7wXHyrevigEeRWH6yM92C4
9vS9oJfARgwd8iTvloXL2qE1R218QboIkJ1bUuyCiFe3Rg9F7CYZleADyO9SZXE8
5PjUFYEhXTWwHILl1fwN9utFnhubAm7YpJ9PPFWo4zEWmxQovXwJMehISl90FBje
FqOWU+DQTvX6FI/H/stdFY0U3fr80uEcbB+Mn4009kxgDEZMoS0p8hrWeo7zRALF
yVB1uXEeL2MtQh4EK4sTiSUNdj7ZaQ==
=0rcy
-----END PGP SIGNATURE-----

--Sig_/zjqY4iyeTAxj_lJqIElMEXN--


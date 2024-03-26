Return-Path: <linux-kernel+bounces-118369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B320188B9A8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 06:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33790B226BB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 05:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DE083CA5;
	Tue, 26 Mar 2024 05:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="dMDnqIlf"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06F529B0;
	Tue, 26 Mar 2024 05:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711429702; cv=none; b=D/mN43Q21a/A/Zfj3IwUWb7DWBmw7YUnTMxuKgtuco3tic14MhkicMWg+lQoZX05BbNF1h7KS7NibQ2zTN2RxVeKDpm8KQJZFcqkDjieaD1KZUE0/c0Uy1DS6LSE/O4iTrIHXEStenrepgzx2BSbh7BXo6aeLB8U1ciKrltUzho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711429702; c=relaxed/simple;
	bh=fsLyRBVIUGBg1SRPQFpw+XQFT0SgsgDnubKp5vPHwEM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=DVUproc5iY+vucQ0xgjeGjsAJMEd3p+JKiykcjRnmlfLBqWChPStv70ZnLQxJlX6gbxnFnb8ByiDt2fxhM+2Cv9segsXlCbK454mumkuLNydsr4ZR5fG5GWS1oyBR9qo4XkDl8/n3o4nUzwXL7mxHrmJDiTh88BixnxN5pfdYBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=dMDnqIlf; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1711429698;
	bh=6pf/SoAyM4PEIDsEGdsgQNxAPO1rBeFQzvbrMLNxf1I=;
	h=Date:From:To:Cc:Subject:From;
	b=dMDnqIlfgcvgMGR3m+WGegizNGi335xQKPfevJr8q8RHDfDz7dmZgpDfgTW51aoLQ
	 HD3SHuEPsJy+wR+FyPM9Fs6YE5pFoK8tk2GHo8UnQKxUkeZGpffqrBWi+30680cYXf
	 LLzNtfirjka3OppYn8k8XGpAg0d/eMtJtIRjDVYDm34lroO/vaKy+ihdkGHnnOZ9vS
	 cLth9eydG0cdtJXF+rT+JioD9qI6fgF0yzYv/iuisAf3cy4Y5IoNBUxq/4S7unjF4n
	 u4Km/o/rVYMsDSLBZ3hJoz4m0Y/m2znI8dAFCUCdvA1+1gbwChZOdn5OHhixOvLSTh
	 YVS/8YT69/IJw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4V3d9Z5JLjz4wjF;
	Tue, 26 Mar 2024 16:08:18 +1100 (AEDT)
Date: Tue, 26 Mar 2024 16:08:17 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the pwm tree
Message-ID: <20240326160817.4e68d1cf@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/dLrQK=rn8WE9k5=wAig97Rm";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/dLrQK=rn8WE9k5=wAig97Rm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the pwm tree, today's linux-next build (htmldocs) produced
this warning:

include/linux/pwm.h:308: warning: Function parameter or struct member 'cdev=
' not described in 'pwm_chip'

Introduced by commit

  0835e5c87042 ("pwm: Add support for pwmchip devices for faster and easier=
 userspace access")

--=20
Cheers,
Stephen Rothwell

--Sig_/dLrQK=rn8WE9k5=wAig97Rm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYCWEEACgkQAVBC80lX
0GwCggf/erXqffAdlmPxgDE/CtH14c1onTtZ170v2/PNgN3cXfR5okBwrJBFKmUD
m/L0fihJz0m7kRkpvRUUWmRWJ0cvEs9CE8InLP7JfFIFMusW9hG0OQjn9NduTMCU
cQwXHHYgQFoPLrGs7sGJzNXiqJwIjfpVgx1Zq+OKtew7nRCYHFFSNU742q2FZBXK
1WQ2DsivW63dm9dl9q4g20Yyzmsh5Uiu8ZoBUNSlT1JUzQ/Atci2tO2dZuESEi/n
5+Jhdqcn6Wg0sG2R4ENx7rUzzC0tKKERZ6MmLLurTaFtQbfkSfl8UYLAfhOxyiCt
wJgaEM6YvSITV3uq77+zgu9hS08anw==
=VYDC
-----END PGP SIGNATURE-----

--Sig_/dLrQK=rn8WE9k5=wAig97Rm--


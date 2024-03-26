Return-Path: <linux-kernel+bounces-120123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A0388D2AD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 00:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 496CCB22403
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 23:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0568E13DDC5;
	Tue, 26 Mar 2024 23:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="IFofPOxm"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7052313DDAD;
	Tue, 26 Mar 2024 23:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711494803; cv=none; b=prfy0m5nGvhzbpTANPF2uDoXkZI/zDuxpBc1siVT86rFk77j7hD01sRKg5OI7PqoBi8ua+JZ0MWZLzpsq28O29gQSV+UO6EPhjtykS6PiT3MwD0ZGeZE7LIPLKGao42yxKCAVVXvAOvYl30RMRfurbgPzVuiV2wyf2tQxY+8h6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711494803; c=relaxed/simple;
	bh=UcvNeQayEhF72OWsw7JIXY3e7jKFPUq+mQ67sLPafTk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Q/SPMqnGqBP1yL6gtarTmcgFLxPnyQ3EHqQbNd6GhPJb8UlzYOJw9vhq9+cZK5eBYA75bmPiii0Hzt+EFknf4URICWVlHmRjOtWLylS6tl/Oqvlqrh6DkpWMAUT3dxRoQKLvK+iNgQubVSAKjgzruuGAQXh5+viBijxolrF7XEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=IFofPOxm; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1711494793;
	bh=iUsdc7cAw1OVLTLm6TB9hiPQC9EG3D2Ph/qXCcXdnNQ=;
	h=Date:From:To:Cc:Subject:From;
	b=IFofPOxm7IPqJMS1DkpQWAc8psnTQFGR2RtPCiIcvHrwU9y5h3pmoqD3XywHRxGfV
	 zRKJ2/NVra0ImOAK6ho2SJbND9mnMhTjE8lgQM9zyXf/fFuRMpnfyb9kTEQpj+PVnS
	 sGve4C9cNFP/cyuAruGvcMOUbV+nNbHkOGusDhbdqtaVmzUo3WeBiFY1OQaHxOkO/8
	 wfDdTNG3XwUwj+LFQcvkDkS52XdQ/woLikyvzPEdMBa8tNzzAQfjTX5Rt02acdijXW
	 ExWB3CdF164EU4jQwrco2Kv3TMkm+XaafBqmmebimM28m24IewYDyZWidT9aaryh10
	 kazxTCg9q6kUQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4V45FN2Dk5z4wcQ;
	Wed, 27 Mar 2024 10:13:12 +1100 (AEDT)
Date: Wed, 27 Mar 2024 10:13:09 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alexandre
 Belloni <alexandre.belloni@bootlin.com>, Eric Biggers
 <ebiggers@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>, Jens Wiklander
 <jens.wiklander@linaro.org>, Luis Chamberlain <mcgrof@kernel.org>, Richard
 Weinberger <richard@nod.at>, Theodore Ts'o <tytso@mit.edu>, Tyler Hicks
 <code@tyhicks.com>
Subject: linux-next: trees being removed
Message-ID: <20240327101309.4e7d04f3@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/nYu57v3tWCtg6/tEBlLc1Kq";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/nYu57v3tWCtg6/tEBlLc1Kq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

The following trees are going to be removed from linux-next because they
have not been updated in more than a year.  If you want a tree restored,
just let me know (and update its branch).

Tree			Last commit date
  URL
  comits (if any)
----			----------------
ecryptfs		2023-03-24 17:26:44 -0500
  git://git.kernel.org/pub/scm/linux/kernel/git/tyhicks/ecryptfs.git#next
  c1cc2db21607 ("ecryptfs: keystore: Fix typo 'the the' in comment")
  a3d78fe3e1ae ("fs: ecryptfs: comment typo fix")
fscrypt-current		2023-03-18 21:08:03 -0700
  git://git.kernel.org/pub/scm/fs/fscrypt/linux.git#for-current
fsverity-current	2023-03-15 22:50:41 -0700
  git://git.kernel.org/pub/scm/fs/fsverity/linux.git#for-current
modules-fixes		2023-02-06 08:45:55 -0800
  git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git#modules-li=
nus
rtc-fixes		2023-01-23 23:33:47 +0100
  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git#rtc-fixes
tee-fixes		2023-02-12 14:10:17 -0800
  https://git.linaro.org/people/jens.wiklander/linux-tee.git#fixes
ubifs-fixes		2023-01-21 16:27:01 -0800
  git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git#fixes

--=20
Cheers,
Stephen Rothwell

--Sig_/nYu57v3tWCtg6/tEBlLc1Kq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYDVoUACgkQAVBC80lX
0Gw3kggAi+iGqCFfky/jPBw/e39ExzJTHr14StnfY7OrDqWXyhk14wPXDHJhDKqO
DPfXrS4ysmNu29HlF6fBc1KXtMCgIdad7oLIUagWkZXTsEmCvmygd9x8kVUqmpfN
AygUFt3/9OiQ+FVaLjW1Qav5XPAJkXHCvymDJaRNH+FBBEHR7TtYsRYsh7rEBNmb
v+LxQKIY2DZZQrjqGQe6gVCsziJXrpIzICAe3UR8ZG3lwxzow3zqr+xG9P1czAV7
s2AM0JfNF5A6TO1diQ7a25np8J2GXywU7ITW6/q/Fy7KmKuDFU07BWdkO2fGuW4c
3cGwcbt0amgqNobPi1nECl9pXmUYoA==
=O/ba
-----END PGP SIGNATURE-----

--Sig_/nYu57v3tWCtg6/tEBlLc1Kq--


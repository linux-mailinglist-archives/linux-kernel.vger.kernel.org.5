Return-Path: <linux-kernel+bounces-76058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8A185F26F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C1CFB2538D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5402417C7C;
	Thu, 22 Feb 2024 08:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="MB0VwYSq"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FF017BA5;
	Thu, 22 Feb 2024 08:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708589097; cv=none; b=fI3SF514VDzONXEij5GaeW2B7xzMy4TX1XTVgX3N79X50CZeXXgD4rUZIm5Zf/Tut40JBMIEz8vGQzYXSIrimZ6xXyN70tzGK0YHDeBGkVK2+SHae395uzNbN7okuhDyLaAN2YvL2kCIDXy/IZirIX8gaJCUGcaSaqhdur3aEfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708589097; c=relaxed/simple;
	bh=XalwM2inJegIyVNMxykXv8rznu45kGt6P6K7GU0tuKY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=gaptSMMMqXa6YNktyVzN7JbKpLnU+QbiYkO+P5MGImqJOq8ybhUKRs23PaWpHeqz26doSrnkxC06aNwtCfJDqHRS811LKbYphF6IrR/FOgtOhSP2qYAXfkEyWAgWYe0VHCYj0rS8shAaO+CJeJU+q4GoNcrmvM2NF9QoXOf1cLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=MB0VwYSq; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1708589090;
	bh=l0ui1hCzbYxwD4mbLRoZEH5+k2eehAg7p8zFKJxdMTU=;
	h=Date:From:To:Cc:Subject:From;
	b=MB0VwYSqerz/KhIXXUlj0MfYnRPdh2LUWwzPSC1Ngpqcu45b5wITWO5PtZWJkjaX3
	 ug5VzGKjTG0TBkCn+/5bYMnwbedtKAi9Hf27QJ88u0RWYo3j5BI+8wK+yZIlXB0FrO
	 Zkm/ajhk6Wv4V/QUHd9jIe5+288+KtnKOdt80ixK73IFsNcRvGYC/lwZX7DHN0uyOb
	 yWFL6Oa5TDdmu/60CT9q7LNJDd6NZVXoKD8eILxdcFL9n46FD97A5ScjGavkUcv7/y
	 hOfxGSL36qkYie/ZLSD99jfcGdJFQKEd6fR2iTyrx+KojYhQsgDbzkyWCoPrQaLDpV
	 gn23bfMIAeW1A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TgQfT6ZH6z4wcq;
	Thu, 22 Feb 2024 19:04:49 +1100 (AEDT)
Date: Thu, 22 Feb 2024 19:04:48 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Lucas De Marchi <lucas.demarchi@intel.com>, Oded Gabbay
 <ogabbay@kernel.org>, Thomas =?UTF-8?B?SGVsbHN0csO2bQ==?=
 <thomas.hellstrom@linux.intel.com>, DRM XE List
 <intel-xe@lists.freedesktop.org>
Cc: Yury Norov <yury.norov@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the drm-xe tree
Message-ID: <20240222190448.26dc124d@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/aQVovtan3KdVGubS90.tuAQ";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/aQVovtan3KdVGubS90.tuAQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drm-xe tree, today's linux-next build (arm64 defconfig)
failed like this:

arch/arm64/kvm/hyp/nvhe/hyp-init.S: Assembler messages:
arch/arm64/kvm/hyp/nvhe/hyp-init.S:557: Error: found 'l', expected: ')'
arch/arm64/kvm/hyp/nvhe/hyp-init.S:29:  Info: macro invoked from here
arch/arm64/kvm/hyp/nvhe/hyp-init.S:221:   Info: macro invoked from here
arch/arm64/kvm/hyp/nvhe/hyp-init.S:557: Error: non-constant expression in "=
if" statement
arch/arm64/kvm/hyp/nvhe/hyp-init.S:557: Error: junk at end of line, first u=
nrecognized character is `l'
arch/arm64/kvm/hyp/nvhe/hyp-init.S:560: Error: found 'l', expected: ')'
arch/arm64/kvm/hyp/nvhe/hyp-init.S:560: Error: non-constant expression in "=
if" statement
arch/arm64/kvm/hyp/nvhe/hyp-init.S:560: Error: junk at end of line, first u=
nrecognized character is `l'

and many, many more.

Bisected to commit

  b77cb9640f1f ("bits: introduce fixed-type genmasks")

I have reverted that commit (and the following 2) for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/aQVovtan3KdVGubS90.tuAQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXXACAACgkQAVBC80lX
0Gxkagf/dpVUiLUHpKNPoRu1NrxT49fUSse97S6BtIFfbtUgDlaoiK4ejLEIR7d1
9V6Vg7fap7qQUsw8nr+fJT31GuBZR5RaumhNfs8vzXN8ZXjQqi7R8c5eRBkuofX9
3iLOUiaovEsLwUzoerc8FpFOFETUF7b4or9xqgQ48cURsgaTfb4ugRUfA0csaDlU
VUz2jCMSs7alHv7fMaegFGh8GeKOoK9+UyJySluZvmD2BtOGNrZFLp1kmsUFN10W
ZVU2CHa4Rg2gULeM/hKM7Xzi0rpaDAPtQnPURvzjMl+xp3dst+JiTwb9rAbbSbep
GKZoXH0QO3vTIsmmcv9x6zD5VN5IBA==
=JfaI
-----END PGP SIGNATURE-----

--Sig_/aQVovtan3KdVGubS90.tuAQ--


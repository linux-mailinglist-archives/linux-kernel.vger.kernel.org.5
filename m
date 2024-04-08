Return-Path: <linux-kernel+bounces-134778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E196789B6C3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 06:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8025F1F223AC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 04:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6CDF51B;
	Mon,  8 Apr 2024 04:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Cw4WP705"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348AC747F;
	Mon,  8 Apr 2024 04:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712549546; cv=none; b=Erj+SIFnvbHJCbWHI9hw75qGGKDlFJCti2PJakXHggnQd/QFLoITdH4Rfm5L4ElcLzvzzwmGq5CyqvGeKtTfmkuOyXVA7MqKwVzGBg4o1kZszVBbkp762wqisjUPbGVitdZ5HPCyaBCZom3Zi4ZuClTvKEqhX8O+kv+BwXwpNUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712549546; c=relaxed/simple;
	bh=e0+1g5J93AizHJVDtb4ao253/2RFa1h/xWZKAiMQgk8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=R9AGq0S1w0NYJexcWFaGbcLUzzs2qibkuKogp5ix4wnNGVwYZ5YproVboPtn6JGEpmzfslaHMqCdexWa2An+/BWLOiFYeLknbbcx30LHvJU7nwWm9PhZqgDazwu2CaUZT5FMBCpJ2vRO6sREUCbf5fHlt3WD0MzKKYkL7oK5XvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=Cw4WP705; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1712549539;
	bh=FsghQSttg4WR1Ky0iCZ8lwhmFX1sFaubQuxxx9M5Tto=;
	h=Date:From:To:Cc:Subject:From;
	b=Cw4WP705l/VjYcDb9yvMILtrfZJ7/kGt6Aalrn3LZ0FEluGrzDmDwQs/iWSpMbyPT
	 h6vw3wjrUWAWXii8s1YaWl2HZLtg9n/url5KIoRIRu7+qD9lhTnVRP36/lAkdMYxUU
	 5cnNLjhAxnzbQ5vXoF85EhQ4VpM8DzxCshoar+UeAK0gSL5WM9pfPvIAmmIwoKgiON
	 ztXUrSh3BpBJFJ7udcgd0Di368GuMigtt6BSDO+KPXMcSxIpQ9Ynm9NgIGZOLFwMYC
	 R66j5fKiNahqS1u01RpakqJsKXACnr5dVsPRVXulM0XwDZySXcIcnFjI6QfDNqETDC
	 9DEgdXCAtobBA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VCbJz3lwRz4wjF;
	Mon,  8 Apr 2024 14:12:19 +1000 (AEST)
Date: Mon, 8 Apr 2024 14:12:16 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the sound-asoc tree
Message-ID: <20240408141216.3eb1128c@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/cHSj+P_Cu2CAxcSKGrEzGuQ";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/cHSj+P_Cu2CAxcSKGrEzGuQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the sound-asoc tree, today's linux-next build (powerpc
allyesconfig) failed like this:

In file included from include/linux/bits.h:22,
                 from include/linux/gfp_types.h:5,
                 from include/linux/gfp.h:5,
                 from include/linux/slab.h:16,
                 from sound/soc/intel/avs/icl.c:9:
include/linux/build_bug.h:78:41: error: static assertion failed: "sizeof(st=
ruct avs_icl_memwnd2) =3D=3D 65536"
   78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
      |                                         ^~~~~~~~~~~~~~
include/linux/build_bug.h:77:34: note: in expansion of macro '__static_asse=
rt'
   77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS_=
_, #expr)
      |                                  ^~~~~~~~~~~~~~~
sound/soc/intel/avs/icl.c:73:1: note: in expansion of macro 'static_assert'
   73 | static_assert(sizeof(struct avs_icl_memwnd2) =3D=3D 65536);
      | ^~~~~~~~~~~~~

Caused by commit

  c2b10acb62c1 ("ASoC: Intel: avs: Add assert_static to guarantee ABI sizes=
")

PAGE_SIZE is 64K for this build.

I have applied this patch for today:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 8 Apr 2024 13:50:53 +1000
Subject: [PATCH] ASoC: Intel: avs: stop building when PAGE_SIZE =3D=3D 64K

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 sound/soc/intel/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index 4b9e498e3303..abe5cba82d50 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -211,7 +211,7 @@ config SND_SOC_INTEL_KEEMBAY
=20
 config SND_SOC_INTEL_AVS
 	tristate "Intel AVS driver"
-	depends on X86 || COMPILE_TEST
+	depends on X86
 	depends on PCI
 	depends on COMMON_CLK
 	select SND_SOC_ACPI if ACPI
--=20
2.43.0

--=20
Cheers,
Stephen Rothwell

--Sig_/cHSj+P_Cu2CAxcSKGrEzGuQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYTbqEACgkQAVBC80lX
0Gz21gf/VMYKdr8r6BdNpMpgCeETxmlYE1AyDtQN2LSqabcaW3Mzg7UTgczBFwWY
QszRwE02gM6gZdmnR+rf27DwueiE99wVoxEDYCboPyBorX5nY+ME0rt5EG19dbpi
Sp1LMZ4NeMrgIJJx/8+pNZUMSdyAbASFMx4/Q6DsfH8YApHWokZLLLFgGQlA5U57
tD/NrBPHBKRkA21o+qsQuLtyHD/fZHZ4p8dicHHt/I3jlzj7wkOeErYnXgpzVUXc
WmMjNkg7DJGnm8EPt9SWLbegMzEVNnwqRoFWBoX6rl1aL1BH8oxWYPgpWGp9Il6p
qqz2wq2eXO72BvdedoKkRJ9XLgjWPA==
=7Lkp
-----END PGP SIGNATURE-----

--Sig_/cHSj+P_Cu2CAxcSKGrEzGuQ--


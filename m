Return-Path: <linux-kernel+bounces-154352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EEB98ADB19
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5687C1C210AA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5EF2E64B;
	Tue, 23 Apr 2024 00:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="rCCY7nFQ"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9951B2E644;
	Tue, 23 Apr 2024 00:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713831779; cv=none; b=MpQtasu06EaA2eps3crMdbmxEuoYkWd0OZgyjqmL3brHrnSshoCQCvtoOcjO5b3A9MzRiBhe5FwNQORx5c80/VXS3Ht7M7KWR2ts4le8YdLpeHmxRH1UmX40atJ8zrpxhm90nvnah/3MYL93QBbPUh5zlz10b2l0qRkz6O7Qkc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713831779; c=relaxed/simple;
	bh=7c1Zp56q9rDSO4sWrhiFjM+Yai2TNa3k26KwKA7t4S0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=DPtRfWsYMrikhLah3R8rrBOC5FXm6tBSsXwAPJeufZtW/gAfghzezwg0PB9d0MUW5kgbloep5NBHgNDTDn1+Zq+yko1jSdXdNvROvL5ZzdIZBjeG1ftxgvPPPoea15YrrfcirC9RoR2YAWBaQUF/D2AtjCy+LRPaRTzMBl4daUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=rCCY7nFQ; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1713831774;
	bh=rmk3N3DyRezf/hgXZF4A5i5PMn/lnY+lkwftoLV3WJ0=;
	h=Date:From:To:Cc:Subject:From;
	b=rCCY7nFQc06bHzeHzuVo8a3T2jA83YGrexXakKE49LreIFtR3i29SZQM0VNWlVwnz
	 9HpE8Ve6hU1lge8d19YMuMPkeDF8BmVscPsWBEzQafocFbTQ3ifMsGCeXIeNaEDeuP
	 2APFGoNI9UKCQLLUsMcMUE88/MgkqSR7rka8pwRn+JNoJOElP1r4gwIink7FFEJgkG
	 NYHcCViY6rWAwoTgZwwSwguE+1VBsq87vgO+xtluDNBRjWSNaUaJdFbQ/0E5DF0WCA
	 KNoMxsliilVrj9ZvdWmjV36261ucyTmqYcXB7JCOglYjyZvum9m746OYluqQdmg7Xd
	 nZ6JCsTPQG4Xw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VNjWK755lz4wc8;
	Tue, 23 Apr 2024 10:22:53 +1000 (AEST)
Date: Tue, 23 Apr 2024 10:22:53 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kemeng Shi <shikemeng@huaweicloud.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Tejun Heo <tj@kernel.org>
Subject: linux-next: build failure after merge of the mm tree
Message-ID: <20240423102253.3675d0af@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/h9oUFIeP8zYE7l0.+pbAmgA";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/h9oUFIeP8zYE7l0.+pbAmgA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

mm/backing-dev.c: In function 'wb_stats_show':
mm/backing-dev.c:175:33: error: 'struct bdi_writeback' has no member named =
'memcg_css'
  175 |                    cgroup_ino(wb->memcg_css->cgroup),
      |                                 ^~

Caused by commit

  3acd401af0c9 ("writeback: support retrieving per group debug writeback st=
ats of bdi")

from the mm-unstable branch of the mm tree.

I have applied the following (hack) patch for today.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 23 Apr 2024 10:06:13 +1000
Subject: [PATCH] fixup for "writeback: support retrieving per group debug
 writeback stats of bdi"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 mm/backing-dev.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 481886f47164..af8c81adf7a4 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -172,7 +172,11 @@ static void wb_stats_show(struct seq_file *m, struct b=
di_writeback *wb,
 		   "b_more_io:         %10lu\n"
 		   "b_dirty_time:      %10lu\n"
 		   "state:             %10lx\n\n",
+#ifdef CONFIG_CGROUP_WRITEBACK
 		   cgroup_ino(wb->memcg_css->cgroup),
+#else
+		   (ino_t)0,
+#endif
 		   K(stats->nr_writeback),
 		   K(stats->nr_reclaimable),
 		   K(stats->wb_thresh),
--=20
2.43.0

--=20
Cheers,
Stephen Rothwell

--Sig_/h9oUFIeP8zYE7l0.+pbAmgA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYm/10ACgkQAVBC80lX
0GxhrQf/YrizRSNq3WnmuQ7sJ3FSOk4BAiF8p2leUHGkRVc4e75KEjV9OekpohlP
fL6j3NRl1o0PXki6hnaRfX7fM+ei+Mb98rzL2A9UOf80yARhjPBRE+PY7YEhaSc1
rW/SxtkoASRpTws4kaabpUh1lF0ilYlF8VF+vPqJ19vIoscBjg5Yb6e2OnA7UDr9
5jOtS1WfXiuby+mQJF8jVI7HckQXesaY/jg3BhdUt23H4PHvR+FLCtS3Joz5P9Yc
gMXXyhoGp8iAcYtBTYWan8j78bE7idowmSGdUPPwQLfZSiI5xeAPasjjoH2kBy+6
U6hYFWkTSLdvvj7QjxA+V8673trcPA==
=nkFz
-----END PGP SIGNATURE-----

--Sig_/h9oUFIeP8zYE7l0.+pbAmgA--


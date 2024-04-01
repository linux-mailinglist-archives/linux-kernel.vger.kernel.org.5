Return-Path: <linux-kernel+bounces-127142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 998CA894765
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 00:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 388351F226FF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 22:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6DB356457;
	Mon,  1 Apr 2024 22:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="iHMBPZIS"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE7C8F6F;
	Mon,  1 Apr 2024 22:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712011284; cv=none; b=jpDQHsp/6sfGAOQ2SJzir2XbmgH7AW/FWMbBWXsFCoxGqhyBynDuslO1cNyznv/ewB5BLEkUMj+050krEtF7rnKsNIGYsw6litJ/ZiR1Z6UicaYl5p3J0jjLm/j7bazjUA2lHYlasWJp1UoJZ5joKsUSOzE+RCDf7+6MadC8Cjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712011284; c=relaxed/simple;
	bh=MnXQziku1iAl+x3YG8anM+D6UB+7U9nEuRMpTc4ZE/E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=YglRuYN2C+x4tEoHiKuwL/CbsxhT6Y/4++Q1+FvDAIjqDFAG5f/iPp0iVas6C0zCRPG/8FgGzqZCn23TAavmnejFN7tkhi0aDn4tSFWHFolhADhsTLxzkcjhQjfnrxt3W7M0QhawtJvvaEXoy2ZqhtSIEsreNrZrz7ym1Mm9sXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=iHMBPZIS; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1712011277;
	bh=2iKHR/J0bBKAKhQ6+pYkSQ+vHW3YfyWasp7Z+CIup0I=;
	h=Date:From:To:Cc:Subject:From;
	b=iHMBPZIS+RZxcsZQZLSi0U0P+rfMvpQCRj56AF6SMOaI+n8N4+9PHFCA+Mm85qOJu
	 ldF8kCNgm7yobSqZsVCbfv0P6G6XooiXhKyofDUhimw7EhdMMD/PlIXXho783qc++u
	 1WjQOcog6j7ikCLc8EiO5kVxdTJfVBFPPDPKZn14CHPvEfFJ5cBYeY0c46y0KhwF8+
	 l1cAwSH4JfwFyw1NQl71w+HQMjH5xcKwUwMjp2N5pG2296HX7YOTapYuWkvuYf5raF
	 wk2AnBGiC+k3FYQ+ctRnOUiRSwSLKNjkWFK4h7bXLwp9gZ8WjCVA3pVjE73EdNvd05
	 u+TjoUZQdYhjA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4V7mFn3TbSz4wcn;
	Tue,  2 Apr 2024 09:41:17 +1100 (AEDT)
Date: Tue, 2 Apr 2024 09:41:16 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, Namhyung Kim
 <namhyung@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the perf tree
Message-ID: <20240402094116.79751030@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/gTH4wXie_5dp6O+cfwurwim";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/gTH4wXie_5dp6O+cfwurwim
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the perf tree, today's linux-next build (native i.e. ppc64le
perf) failed like this:

make[3]: *** No rule to make target '/home/sfr/next/next/tools/include/uapi=
/linux/stat.h', needed by '/home/sfr/next/perf/libbpf/staticobjs/libbpf.o'.=
  Stop.

Maybe caused by commit

  f122b3d6d179 ("perf beauty: Introduce scrape script for the 'statx' sysca=
ll 'mask' argument")

or

  a672af9139a8 ("tools headers: Remove almost unused copy of uapi/stat.h, a=
dd few conditional defines")

or a combination of them?

This is an incremental build but doing 'make -C tools/perf clean' and then
rebuilding works, so maybe there is a dependency missing?

--=20
Cheers,
Stephen Rothwell

--Sig_/gTH4wXie_5dp6O+cfwurwim
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYLOAwACgkQAVBC80lX
0Gyv7wf/RqpKfKfdLUDWIvjWba9ZLyNjrD5TvbgeMt63mCHQgRlXzqlmRusDi4bi
mYXPU3hM9et2AmXfaKyj1X7a41Q4sDLZMJcgGgM90pU7ipbAIbeLLurbD5GGJ1qu
99GbqAi+g57Pk4B4h0QIS0GbC0yqBiWxVsij5je5xCkNsItU+XwVrzKhtLzF10NA
NGtdMoxC6BDuCcLdtlOQbovHMNPjZ6bXnsygb+PzaR3ZiAKvvS+profUpVea8l5l
6TBEoONxI5SIivaehZ1DraAi2Sdhns255PpKBGd/7S1/o2U5VG18dJIju9SXG49+
VVu4cRYt8lXZl0cpJdHVuyw1pB25ow==
=nfuA
-----END PGP SIGNATURE-----

--Sig_/gTH4wXie_5dp6O+cfwurwim--


Return-Path: <linux-kernel+bounces-110701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A278862A6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 22:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 344461C22198
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 21:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BFE13666A;
	Thu, 21 Mar 2024 21:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="njR39MX6"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C7F136650;
	Thu, 21 Mar 2024 21:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711057297; cv=none; b=lyvxAI2bCkgrwfr1+nggqNS7tr+/ckkE9PnPOzcafvYgSfmd3bcxGOEErbnwuYDlswcZPVXExotQcnJMkdnd19D7YIMfncc8Hd0p8fmsxysThRN7UkkUcNYd4LoQ/9vM+ikYH6rxel8wVeHzjOkuTUbfRy0CaNnMswean0/QaYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711057297; c=relaxed/simple;
	bh=JdPEm22Hh8sbaqGiixRHF8Xt920mtir7nG+16AGKZXM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=pXevSJdIUScoUH/6QxkUtuGmLSIH8dn0rD4YBioUgao7VrP17n6n20GdllmVDIlA/BJMZpHTvOb3WRDR2WBQeNwfBiHCYA8Ou+RezVR/vmh7N2iNwKOGKhFC5AiQnYFH11KgrFbwcUeIS2X1a3KoIEZLOoc4jWt+uy8p5npnfEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=njR39MX6; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1711057292;
	bh=Cf8ctmfRqrbNmiZtV2ydOn9bY9RE833VbbvakcOLYYM=;
	h=Date:From:To:Cc:Subject:From;
	b=njR39MX69cO7u/CSk4aJkLSkb9hXyv6B3By+xc5UfvV402KadcVvsptV/FbQeZUTg
	 5yiQ8DoyN84Pa/1ZUZ6PVzLtdr5cBgroEe4hClEZWys83I0uI7K4APqyg838xkFFsT
	 ZfFM3TkGjSkL9sUjiX3LDPZh4NLqMU56YKaS39iZ4ZBVMb2OMHXwFZA2/W/leZ3VoV
	 9O3JAXnehk0IHyge5WJ4l5uF5LZF2gs64jyB9KKleHlXai51O/nfUqtD62dcW9/jqf
	 ZS+Rbcf139oI780hlVrXfqTPL6F04a7mwdX8x+IKHIm0z2ySk1a4TxS1utFVJrH6Aw
	 wUll3KTuV67BA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4V0zRw285hz4wby;
	Fri, 22 Mar 2024 08:41:32 +1100 (AEDT)
Date: Fri, 22 Mar 2024 08:41:31 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, Namhyung Kim
 <namhyung@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the perf tree
Message-ID: <20240322084131.2316eb8f@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/8BPb5yxUks2R1ilO_+6I79h";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/8BPb5yxUks2R1ilO_+6I79h
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the perf tree, today's linux-next build (native perf)
failed like this:

make[3]: *** No rule to make target '/home/sfr/next/next/tools/include/uapi=
/linux/stat.h', needed by '/home/sfr/next/perf/libbpf/staticobjs/libbpf.o'.=
  Stop.

Caused by commit

  f122b3d6d179 ("perf beauty: Introduce scrape script for the 'statx' sysca=
ll 'mask' argument")

Are all these new commits today really destined for the current merge
window?

I have used the perf tree from next-20240321 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/8BPb5yxUks2R1ilO_+6I79h
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmX8qYsACgkQAVBC80lX
0GzlhQf/bX7vcWdvxn+SGwPBBPMFVowfrtcN1MKZPnKDH5wkVchOfORORrA8WTGE
JX+WAOIPdcP6+Kp8dTfh9sdfCcoiOoPLm25HdmVy9C87ZMsz4EN2UKqPpDAaT9EA
RDqmwAE7lcUDIo6ekzL8KhuY7fRh1Schqk1m19XxZr7rg0KwRye+MzDYcXlSokr5
3Osr0vHV4KmfVTs8HU+nMvD5pQg+mEqR4ENctj4SZcOABOGOt1r0MhDBAKKLh7Sn
CfuqzFAWpbEAsrbRfyHCrlsPKQzroassENPxSI6P7/veWmMRWUWx51adUjs2Nb1K
WEICVCW31QUfvDqzPW2UoDoeQk+wNQ==
=Gaxt
-----END PGP SIGNATURE-----

--Sig_/8BPb5yxUks2R1ilO_+6I79h--


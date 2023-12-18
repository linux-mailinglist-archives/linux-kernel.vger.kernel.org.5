Return-Path: <linux-kernel+bounces-3097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD65A81675D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 08:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A30901C221C4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 07:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC7B79FD;
	Mon, 18 Dec 2023 07:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="PA1UageZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5825079D9;
	Mon, 18 Dec 2023 07:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1702884507;
	bh=NIc8t3GFYfh96SkvKciHn7Qs5qOiQjMAGDjP78FVMvU=;
	h=Date:From:To:Cc:Subject:From;
	b=PA1UageZp7N37Mo/dkxcojYB4N/hBwxnTDeco6B5Bw/tkbc7/iez9hbktKADVAqT7
	 3lbazyWmH5JCitgTHXdDUPOlnO9s9cAzZqBrdBsGwA592E19OBwKFMTps3hktzkLOy
	 4SBZwCylgOE7b0SakWP70hc3biH9fVxOB+4VJBbz20NWdpGEoKnhsX7D84Ss5UwiO/
	 3QXFdYBlBlI/NDWpqr4fVMng69vrPASDZ/4JuWFVSt+1n3dvxN3giIiaL8xy+2YULi
	 kve29lypT7RjP8XnpFNnNkmTemthtFwFbeawLM1lskwHjkeWbrJ8o7fy31bGz47JLL
	 Fuyt1uxfSurxA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Stryy4Z5Bz4xWW;
	Mon, 18 Dec 2023 18:28:26 +1100 (AEDT)
Date: Mon, 18 Dec 2023 18:28:25 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Randy Dunlap <rdunlap@infradead.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the jc_docs tree
Message-ID: <20231218182825.39a6562b@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/61XZXLCLNPDVrK0P5+QVUvI";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/61XZXLCLNPDVrK0P5+QVUvI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the jc_docs tree, today's linux-next build (htmldocs)
produced this warning:

include/crypto/hash.h:248: warning: Excess struct member 'digestsize' descr=
iption in 'shash_alg'

and 636 new similar warnings :-(

Exposed by commit

  b77fdd6a48e6 ("scripts/kernel-doc: restore warning for Excess struct/unio=
n")

I am not sure what we should do about this ... last Friday I only
got about 18 lines of warnings.

--=20
Cheers,
Stephen Rothwell

--Sig_/61XZXLCLNPDVrK0P5+QVUvI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmV/9JkACgkQAVBC80lX
0Gw7zwf/byCBipTXaKiq1JOQvapdQWFnuBSgBhQ3imgECwD26luvRxQ/Waq4LLsl
LGYdyCjNWnveu42Wv62gtG15TriiYQ7Sm5iSZZyPatPptzounU0Ppi3Fm9jhByx9
oa7Ltks+V6fk6ZKCA2+hghUWXZdOkmc1Peo70SmXn5Ld1dI09dW0CGo96t0JsHU6
0dAFb3JqsjQzQNJQrFIXESB59atiB5d2D6AiIiRYWkDKs0iWbgkY8sACOp172c/P
YoGJxRiUaZQ2XCkoqOYom7JCVkZQw26e0JuhO/r7wRpgIhIdiHNDouGIe6F7ArRq
gNJhoHs0t5s63rFluFQFPcyHcoqJGA==
=rUnh
-----END PGP SIGNATURE-----

--Sig_/61XZXLCLNPDVrK0P5+QVUvI--


Return-Path: <linux-kernel+bounces-42080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B9083FC0C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 03:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E18B1F20F23
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 02:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C127AEADD;
	Mon, 29 Jan 2024 02:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="CNFGJc6I"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744CBDF58;
	Mon, 29 Jan 2024 02:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706494261; cv=none; b=LueF6YRYBs6pcByEScbClIY9pbuNQVtcb91v3ldETXX0mxU952fiYKGmVlaNMQ4H8QCV2Mp7f/1bKIgSWFGm0VHSSF0htPahqvcnjhcHdY1nUcPeQEdTUKh2exPtln9t2t3zCemtEnAZm3wK4FLnnRnejGzqBieot58+Kvg7goc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706494261; c=relaxed/simple;
	bh=xc0+o90YWKonTND4pxaXSTh2S+4HBxP9QlVQ1N95Igw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=EltFCBA/mZGoAbT4DOQXx32BkfWduy85XqmKFJntdJBsFzHGK3BKbF+6R29IAjKHxUKSqvtUcHMdtmYOURpzdzLe7waVqlTzKJVVvC4y3afhKZPvh76lC+2mahL4/wAV36BmmqSwQebi4627SDIRBp8CzK4w4lIgWxLKy5JdWAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=CNFGJc6I; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1706494255;
	bh=DCEX5eQgeVc6ideEoDhNqJm9bizkzjs7+HmSlqFV868=;
	h=Date:From:To:Cc:Subject:From;
	b=CNFGJc6I9oLy59bhiAqFIwS1OYkr2SpN1Ev7UUMuB4XErodUHLmBLg5Pb49VwqFdS
	 JxJULbJONI3R7E28WyWVEp+PlMT8UicifNGskZHByAWMTOR5stjrGIVyvm4ia9IWw3
	 4avq56voki6s+8w26T3dz71E931MitVzdjvsch1+cDuNNbobRZGccFfFxqOdSNpFLd
	 CcYUv4TOyujSP5nCBkBXnyurF3+BtgJnpZMhfV59OMGEzBgT0p4YbkJeA/FCahr+gm
	 Het/t/mMwV7A3FjOsyxYq25LFGAvA6Ej34MKdHJ+MLVcCe6fP3nCi4wfWJOMksABqr
	 U5kU4kjv7fy3A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TNWxC22Tnz4wbQ;
	Mon, 29 Jan 2024 13:10:55 +1100 (AEDT)
Date: Mon, 29 Jan 2024 13:10:54 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Lee Jones <lee@kernel.org>
Cc: Anjelique Melendez <quic_amelende@quicinc.com>, Linux Kernel Mailing
 List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the leds-lj tree
Message-ID: <20240129131054.14bc453e@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.=b/cx/ZuiL/LD.awKyrudi";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/.=b/cx/ZuiL/LD.awKyrudi
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the leds-lj tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/leds/rgb/leds-qcom-lpg.c:17:10: fatal error: linux/soc/qcom/qcom-pb=
s.h: No such file or directory
   17 | #include <linux/soc/qcom/qcom-pbs.h>
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~

Caused by commit

  8148c8234e10 ("leds: rgb: leds-qcom-lpg: Add support for PPG through sing=
le SDAM")

I have used the leds-lj tree from next-20240125 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/.=b/cx/ZuiL/LD.awKyrudi
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmW3CS4ACgkQAVBC80lX
0Gw9TQf/TGNhcewAWcOl3nj05SIDcdUnLWSk/FAv6nVlheokDundoEI65LRKWWrJ
ia8vR00/EoQAjiWPI0pBbhYIH8zhlBvNBxC4FcrJvA78F+DROhale94bij+1hWuv
77mUc0NUYZt2OVwtw9UhiwKhJZqUx9rp1sfIUjZ5HEV708zCY9KYMtWPEtRhtuJh
ir5gx249ikvg+j6hgv5YJrJbL09sl4q5E2xCQS9y0HpyZtdM/HIMcCuqqiIwKBkj
JoOzY9F7rhzciuMdPl/0pDRcTV/Der2/7YTfxXE1wAdsxEjO2/WxSprZdpfck0EK
C1BD2NEnj1hFkP4urZSnhsHUCPt6VA==
=mT0l
-----END PGP SIGNATURE-----

--Sig_/.=b/cx/ZuiL/LD.awKyrudi--


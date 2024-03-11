Return-Path: <linux-kernel+bounces-99669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CB2878B9A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 00:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28178B21286
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 23:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECCD59B4D;
	Mon, 11 Mar 2024 23:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="h8IWzGVF"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483E25917D;
	Mon, 11 Mar 2024 23:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710200497; cv=none; b=UKPxvye8pW2vTp9FAgIaW8/wJ1ZNM85yCAJjmYkccy7idOIdYxgEibHth8aEbDLoIoS8fCPLxt2WDcjUd3iCBtjwiHK5T+PgTGWvBZUrWjkZmYrY0wuo5pJuWTw+x6Gmyg4B/b1M8WFMIX5uIxakzl62cNRFlefiAJvdWuQq8zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710200497; c=relaxed/simple;
	bh=NSpdWKz3dtXZCOiFR1hjJUNd4g6YWs1gOB1/WeN2Z/0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=sr5Rr6yjTPTnJf5/pzdfGHtqTEnUOlXZWsSdWsNhNxuvR7VjJoBHBiLtQrRPEiHqkzg4ouGO1/EbltxVngTfImBxoazIM/JoRK3LWoygkUmX0mqfdWx1tdxL+d3a70aph150NeucknUWSNID4DXKX5tZYd99C/DJ170aPrnZBII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=h8IWzGVF; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1710200489;
	bh=KPnrKhWMlY/WKjNaJzOqtYzFsw7BeMmsiEd+5e4Jfc0=;
	h=Date:From:To:Cc:Subject:From;
	b=h8IWzGVF9GRXbiEbYuHkbLZgGUYw9MLrUcFAllTmZBBxxD5IawZY3+CQyEB3IBVqK
	 j2vAuNiqNuPgvxpWizAPXtGChR+IG9AmTPnO51Za7yafCHvuxCbtin+R1S8n7e1k4L
	 qdaRZixF0b5myaWrBSlv1LPM6DZrljUlqmzC4NqX5Y4oWhfF1oD8LSmDC4gGJnOi73
	 4YSyQjaqSFp/XU29CSkM0OsNcRusIGchpy0fojfQu470KCjRfj7lyNu5e1bPtXDDJI
	 MrsKXLaKYHZ2NGuDAXfUXx0F/KYop88paFlK+GmHdQ6U/HqF7QzTZ7YLXQar+be1C5
	 dI3Di6J9Mc9kQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TttZx4g2Xz4wyr;
	Tue, 12 Mar 2024 10:41:29 +1100 (AEDT)
Date: Tue, 12 Mar 2024 10:41:27 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>, Viken Dadhaniya
 <quic_vdadhani@quicinc.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the i2c-host tree
Message-ID: <20240312104127.3fb5e650@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/DzOZ0XHmvV_p5fhAGehxzoB";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/DzOZ0XHmvV_p5fhAGehxzoB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the i2c-host tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/i2c/busses/i2c-qcom-geni.c: In function 'i2c_gpi_cb_result':
drivers/i2c/busses/i2c-qcom-geni.c:493:18: error: implicit declaration of f=
unction 'FIELD_GET' [-Werror=3Dimplicit-function-declaration]
  493 |         status =3D FIELD_GET(I2C_DMA_TX_IRQ_MASK, i2c_res->status);
      |                  ^~~~~~~~~
cc1: all warnings being treated as errors

Caused by commit

  313d6aa4c648 ("i2c: i2c-qcom-geni: Parse Error correctly in i2c GSI mode")

I have used the i2c-host tree from next-20240308 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/DzOZ0XHmvV_p5fhAGehxzoB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXvlqcACgkQAVBC80lX
0Gxzngf/W7c80F2x3Up16fxpdypmxrsRRkghtVjr0eSoZ2uWC/JXLZRqPbcGIcFe
vW9a5kKzEYNHkXYz4w/9N+lmPO5lEsDobVipy1AkeRzo7mId2RSq3wbCpQplsKU8
PpTMVpIamxx/IyxXrTlEAmWg4OBBzSxtgSmC8X6CDotLD/VJqJ3ZL1J4I+eY/oEU
hv1WSW5gZDoUeqrCGrClp++enObxe4NleLVnOcgU1eoiPQVJitPooFi0XsppsI8a
9eXKcfDgQulJJyVVp/NpqqSjcXiVhla/4T9TNHE69NWXe1qrojPVCNE1TbQYkrq+
JYsJcrarpclVGoQ23GprYIvBM8lidA==
=SABp
-----END PGP SIGNATURE-----

--Sig_/DzOZ0XHmvV_p5fhAGehxzoB--


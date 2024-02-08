Return-Path: <linux-kernel+bounces-57441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 392F484D91A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 04:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA6891F22B6B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 03:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673E62C6B1;
	Thu,  8 Feb 2024 03:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="AfDpeJ1+"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F0D2C1A6;
	Thu,  8 Feb 2024 03:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707364127; cv=none; b=QsgmCIVwB0Pc9levfC07wIANuq1ycO17wkBamkpe4y3ms5XZF4rhC0lqZ1hq22YFWMKT3mS1N5E/q6LN2xuiRnEjsc1zMZx1OWmnZqJcT4vAtg/4FMtSKWKFOociHipy0MzGBXxgCZLfA8XgIa+Pyie08fuXabSM5c0Ro8ckeB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707364127; c=relaxed/simple;
	bh=ZKD/zWkDhl3AWxCXsgOa6OUcviNSO50RJYFcCr29aSc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=hjrffHukSDLy0aJ86XzDGmMIbNUF26ACQngBKkkZLIIosx1wWG5bgPEA0uFp9+wfmU2lqPzK584Fh5F2BsnxLH8h5mutgEKnv22Af4shasJ8evXLhXXBbZbNwklVWgE564xfdqxe6CZjnGjZ42uWkGKFcsGoW6Sf3u0KH20O/Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=AfDpeJ1+; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1707364123;
	bh=tnPkbVE/yhWz2btyQ1CuW/no010rXjF6bycJ3xoU2Rs=;
	h=Date:From:To:Cc:Subject:From;
	b=AfDpeJ1+dtM89fV1xNNIseisUioa/EpDdg9F0Gz1dD3h0pytIJg8VpZ8eDwGXe8iW
	 jTM4FxZsGatYNFk746/3eF2Ki06ox3cI47TNRk/VE1fl85xRuTZf7sb8wfJ3h5hlBU
	 cWdWtQGTOlxqrdCfY88nOE+kjVKVt22CzwoWlIUPpD9TTma8iiC46M20Mv2J0KhY9d
	 iKR+3GlFU3D4n4odwFRyFAVQtO5Fwd193mlmyuLy86DffMtwvZjWhhW+MK0sYh3xyN
	 0h7kOPP3bcLrfB9UeBV11UsZHtlWJURNDZO1EJxT0EZkq+FJSqxSxBADNUBxFkA4n/
	 z6hTthVCe/Acw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TVjdR5Bk1z4wcB;
	Thu,  8 Feb 2024 14:48:43 +1100 (AEDT)
Date: Thu, 8 Feb 2024 14:48:42 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kees Cook <keescook@chromium.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the kspp tree
Message-ID: <20240208144842.5491303d@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/n+2TIRG6e3rkaGd=AkqovsA";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/n+2TIRG6e3rkaGd=AkqovsA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the kspp tree, today's linux-next build (htmldocs) produced
this warning:

include/linux/string.h:142: warning: Function parameter or struct member 'd=
st' not described in 'strscpy_pad'
include/linux/string.h:142: warning: Excess function parameter 'dest' descr=
iption in 'strscpy_pad'
include/linux/string.h:142: warning: Excess function parameter 'count' desc=
ription in 'strscpy_pad'

Introduced by commit

  0bf7961afff1 ("string: Allow 2-argument strscpy_pad()")

--=20
Cheers,
Stephen Rothwell

--Sig_/n+2TIRG6e3rkaGd=AkqovsA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXETxoACgkQAVBC80lX
0GxVdAf9HLCvUQKhPDV60HxMQTJ+MaASH6www3LvS7Hngl1wi/G7blEOvrD2Mv6c
9dAQ5AkybLHUKvT1E3EdAuwnBZmMCeKRcd/NqkhKmF2Ong8UXV32qAp5koHdut5y
tUlcPlD92KVXGdKjQ9HbfubSnJTKdebxZalZRnCQaBa0pSaHekiGZjq6W39Gas0v
x6qx8m/IeILE4rxljbCbqaZ3SiqN3m2SzUYSXzgiyrv1vbojLotrpQ1qs64oBlAf
nZCkXjNF/wkQT/l1xyhfUz6XxDu8y3ETBlYL/11viUhfqZ5nBAViJeyHihHizFRQ
fLZKsqD6rPfry+suO5GO7ZBCBm7KBA==
=S768
-----END PGP SIGNATURE-----

--Sig_/n+2TIRG6e3rkaGd=AkqovsA--


Return-Path: <linux-kernel+bounces-95000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B648747F2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 07:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 632671F2313F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 06:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E177F1BF34;
	Thu,  7 Mar 2024 06:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="lhSLOSui"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A98DF55;
	Thu,  7 Mar 2024 06:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709792171; cv=none; b=n0pJV8jx7j6Nwt3pBUChxSGIWKvtJof4rRB87BCL6RwIB6LAG65HUVwKutaTxWqyGnUNQqDJ0wDfGAYcVQ1eRd9k+C987m/SeDN16mRHU/FrGRrPgYwmJ42jKB2c/KKZipQjo1oocY+wG7DL6SmSZ+UUDXvbwaHcA8f7BudqvlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709792171; c=relaxed/simple;
	bh=mo88EBALEBtDnQY43MCWI+nJNOUfmx0VWeGbl7UQya4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=mDvYAgsvvvGfUnwGb7fH8TsJ18ZOpbqlbW7K1o+RwIRtRzLpFiU+aXdtizZHKA+Cd4LK7drl7wXF0LZH/0oaBf5yJnkILAnImnRc43m+91N73T/pXbcHNvNu5956NV92DdIJbE24nCRzj+BSjXO8ZM8OCtRFK4eNfwdOvIhCDBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=lhSLOSui; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1709792164;
	bh=3KCP79w04BosGaUThYXtKEPV6LhLdPtBfhZHCLnbomA=;
	h=Date:From:To:Cc:Subject:From;
	b=lhSLOSui1lmrFhWOXwVz+V5lcPENH6P0LMmpMsSCYFW90SCR2pFtEeg09uToq5lv3
	 EVsylr15Jgw0nz9jCClbWtz7K4Ee+Q5qdBl6NO1+faFH62YZ2DLaVeCQrzaecsckke
	 gOeh9T0MpJHsDs+dFAOgQMMs/e3BHt/CqP0XTu7RQcEAPaPAu0pfkB91HBvxP7uuY/
	 LvH+CpzL3LOiB3wxOnYqks7VSNzKYaMPPnvkfPzgmd7mb4mWRJMwEah7yDDfcCwNKN
	 eWri/xTJj0LT0yA61uWpTDynovbBACnvA7mRn4GnJzdOJsru+8yWoyDA4U67Jg4BTg
	 Ybt/+AtGwTuYA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TqzZX3h9Wz4wb2;
	Thu,  7 Mar 2024 17:16:04 +1100 (AEDT)
Date: Thu, 7 Mar 2024 17:16:03 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kees Cook <keescook@chromium.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the kspp tree
Message-ID: <20240307171603.45e9c8b2@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/EFc7LglZfshsdKepu.jD5N=";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/EFc7LglZfshsdKepu.jD5N=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the kspp tree, today's linux-next build (htmldocs) produced
this warning:

include/linux/overflow.h:408: warning: Excess function parameter 'initializ=
er...' description in '_DEFINE_FLEX'

Introduced by commit

  014dc22af922 ("overflow: Change DEFINE_FLEX to take __counted_by member")

--=20
Cheers,
Stephen Rothwell

--Sig_/EFc7LglZfshsdKepu.jD5N=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXpW6MACgkQAVBC80lX
0GwhIAgAns143ZtoEkWvADbT0h6lMcuKmRWkuct9wUlXRcU2UqOQZAkm+iYqQQqI
AS79yr+eFDeZ9B83TshhrnBKHUbNVU5NCiE2pBVLvaYPkBBh0lYe/BX8Fg5mOlIr
N2T6g/DQ4kYb1TapCvcHO7/utUyts7e+ZNpDrnBZbWBhB+lXw6+NXPcgdL99kW9R
uoRPmQxn1ByLw/woW4BY+cdU/DgfaeBSaWx2n+/erxLmqepcUzdsxz+cTMXPZ45Q
8g5LSgl9CkKHo6p3uCs+xIun0MjQXB2hwmtFSSK4hlIhT6//AK94j+ZTxGg2Epfq
mo6BYvyW/f2Skc/Ju7sFsCSxT11B6Q==
=MYQc
-----END PGP SIGNATURE-----

--Sig_/EFc7LglZfshsdKepu.jD5N=--


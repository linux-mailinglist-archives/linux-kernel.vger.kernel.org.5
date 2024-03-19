Return-Path: <linux-kernel+bounces-107018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF3E87F6CD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A7A11C2197B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 05:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929C345946;
	Tue, 19 Mar 2024 05:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="pRxxvGy3"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F61F446A4;
	Tue, 19 Mar 2024 05:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710827113; cv=none; b=k8WkUTj2cRRZg6Mm41+JEA+iet4uNROpDFhCF2s33eKjg1s1pUbk+TYPh/mpXNdGXTBNa7Suh/2BVXs2dp8m0agY+/0SNsxOlWoZ58qu/lrXoLA47Sn7arD9opunfcFfI46SjP/tk+R3bXUPvE+G9HcRPQV23JcsMT/aLTK214Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710827113; c=relaxed/simple;
	bh=/QXZy3g/RnjkA4vObPEa8Wuv5HDHAjgY2M3QtG3afVw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BlCereZejPWxHeij7PImWnAbI3x/t6A4CnodLEUh/W1lA1ntkOMHC4lSLtNDeO/ICNvrOHONFMY8gqKddDgB0UXVRMiPCmcSPmMROjbP30M9c4sPEOp3+gtTd2A5P9EbG5dUL9GkESeQzoayL/gVABkbuhjkmh7g5dcIFIthBzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=pRxxvGy3; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1710827106;
	bh=/QXZy3g/RnjkA4vObPEa8Wuv5HDHAjgY2M3QtG3afVw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pRxxvGy3Mc86SlThwxv/t20z+ct9diaXD2/KpdFA3uFZ8JKSMdXv106Nn62ZYDwxy
	 GpEumqwcTGr+jBSL9DpULkEMzwJ9pV5Vf/W3uSc1ZXwJI5yj54fnQGtpw65tKy2JJc
	 HnI6BXnbboNJIhK/8jqWZ4MHwV5TE7i9sweTyHfBJVJCbWmdlLqi4/v52BoD4Pnzvf
	 8V9FSqzFtJdwxpbZ3Wtq+UD9WmozByyYA/dzcVpxXzUFfRk+XzZTUla4osLeOrN+qi
	 G9MgrCeqtwnZIsEbaqhWujiBn9OksNqkW/ZG9uXUNKGC5KgtDcKSo4+Rl/sMEI0b4M
	 AqH70CC3VHDCg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TzLKG1WkMz4wby;
	Tue, 19 Mar 2024 16:45:06 +1100 (AEDT)
Date: Tue, 19 Mar 2024 16:45:05 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linus-next: Forgotten merge window reminder
Message-ID: <20240319164505.485b3801@canb.auug.org.au>
In-Reply-To: <20240319124925.71b43bf1@canb.auug.org.au>
References: <20240319124925.71b43bf1@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/VspUVTZ3PkHW_w9YRMnjoqG";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/VspUVTZ3PkHW_w9YRMnjoqG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Please do not add any v6.10 material to your linux-next included branches
until after v6.9-rc1 has been released.

--=20
Cheers,
Stephen Rothwell

--Sig_/VspUVTZ3PkHW_w9YRMnjoqG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmX5JmEACgkQAVBC80lX
0Gwx3wf/Xk4qLKsURddXuY/Ji6XSOK75SRkF92CpBHH/JYxqbRW4AMIXhc7Ppm14
I5eg4vU0M7dLDer+ESdvQvwJmGwy3QnAVkKobU4gLM3Ro7KQOmTaobGCmniwUnnG
DdHBbV/p1Lg2Bvuw0GAG5cqT/rSLD4uEQ05nsPJMmQNr1f7yPlIdUUexHkTePcqe
UT+6m4PhxpjT4dGY2VuEZu9oZL++JEI4o0y05FXj+KYJkjfVzlbCDKQwkr0Uy3HN
vmx+ce/TXMlCBSIBgZ0dMmQtsugNKfHY1iKUQmrzH8208WAE54WKsTK+jqUmkT+m
1J/k7ORw17m+lS7z0zpo+9qVVMh6Fw==
=BLVx
-----END PGP SIGNATURE-----

--Sig_/VspUVTZ3PkHW_w9YRMnjoqG--


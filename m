Return-Path: <linux-kernel+bounces-96325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B4D8875A46
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 23:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBFCC283EBF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 22:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2675913F430;
	Thu,  7 Mar 2024 22:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="WPG5Dn2D"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F4913E7F4;
	Thu,  7 Mar 2024 22:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709850507; cv=none; b=YKGKrXcUDlAGflnwqXOPHMMs+kgPJBTFDwlgCLCr2ftzwv993bwIqeOLUXgMnCguszZvUB1XHwzjjIgOua5Js3kB4J7N36A0nBoYquZZtCkFpKsImjGGyD1FyW+I5ijXkoc7/gk/mQiIzPUuD4BxXxeevyq6AeTyeIpOpYqKWno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709850507; c=relaxed/simple;
	bh=J9FEIZAiQRYpqVR9jQeQqKUfSTyvGjGYfIQ2qkWqTOs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=OmY2wG9HbnL1+wxpXGOmwqbUYItj/x4lrVVV8FyCz+zYzgkjnTerW3Y72Xa/+5Re3oQ+QnASMa+A0ENQATfuO9Dlyi3woIvyzh9DWB9WNApXN/JBW+108XZlm8o8A6J/Uwmuv9yjHf8e41DOhuoTizFb+EinOH4YKTKp511rnNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=WPG5Dn2D; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1709850500;
	bh=akk+btCwoxJ2i1b9Y4ERZO/n4LLCkDJ+4Jq5W3BfLtE=;
	h=Date:From:To:Cc:Subject:From;
	b=WPG5Dn2DrZEQaXfyv8Tej562JOi0v5eQX97UOqEsnRVIx+9kKT+hA3C5ARSJ+1dF9
	 jGCoNazkiOO8rBYmxPwuI51ItyOFy+iMDulJJ5rjL+zJV+2rFIzSA//h0SXhLthbvf
	 Vm9HaAtQ1KFCuOMYqoLIRUYf2w4Rr0TtBSOGv26xyavrfCFlxMYB7aYe1j1jaoRkil
	 ZMjy6ExOo44MHkHEy+N0lom/k1lwgsVo5jAUswDuU0EceQuD5CL3CRlBCxZnTokW51
	 mRKkwPdZNeYzY5cKbxrx/Thc5pR6arlx0HG/WGV80eIy0U4y/CMIT3eBVqNHMd/med
	 UUais9ilBAghQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TrP8N55vGz4wc9;
	Fri,  8 Mar 2024 09:28:20 +1100 (AEDT)
Date: Fri, 8 Mar 2024 09:28:19 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Trond Myklebust <trondmy@gmail.com>
Cc: Dave Wysochanski <dwysocha@redhat.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the nfs tree
Message-ID: <20240308092819.1575e5d2@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Ac7UpYZ/8WLiSQE9ze=YBX/";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/Ac7UpYZ/8WLiSQE9ze=YBX/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  7b676e697cdc ("NFS: Fix nfs_netfs_issue_read() xarray locking for writeba=
ck interrupt")

Fixes tag

  Fixes: 000dbe0bec05 ("NFS: Convert buffered read paths to use netfs when

has these problem(s):

  - Subject has leading but no trailing parentheses
  - Subject has leading but no trailing quotes

Please do not split Fixes tags over more than one line.

--=20
Cheers,
Stephen Rothwell

--Sig_/Ac7UpYZ/8WLiSQE9ze=YBX/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXqP4MACgkQAVBC80lX
0GyTWQf/WfESUrwJYK6U0m/O4JPBL/fMVtgpcFBrcFxMA3vMriu/7mTyMMUwQFfQ
6xFY1wfPMAJBY3Q9V9I/ySLuUvO2O1AW/hBLqedbn3+9aSQ3zjNdbRD9KOi/1hgo
4l7pwOHMmxD7MhPvxKpoMun1wQE22DaUncjzhYmn9bX5+MZzq3eNB9GNK43u7h0J
NcqL/h0E7nrJ3Lp+djsMqN2spEPXKmbe2NPt6YCgFtKsKfkDDxuCa0ezyeLnchVX
VbIcEgGzGYa42NoQCLePx6to2uZyWpICy3lGuEirAdJulAB0XXesJF3w8eXoHuY4
REnKYd9jFQDCSGLq7FQ6eUExEBIIIA==
=vmVD
-----END PGP SIGNATURE-----

--Sig_/Ac7UpYZ/8WLiSQE9ze=YBX/--


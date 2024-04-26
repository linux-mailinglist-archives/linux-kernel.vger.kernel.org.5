Return-Path: <linux-kernel+bounces-159603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4548B30E3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 08:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55015281344
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 06:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6185613AD04;
	Fri, 26 Apr 2024 06:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="bKehq6i2"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B51713BAE4;
	Fri, 26 Apr 2024 06:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714114519; cv=none; b=TWaKpgqKIsckdV0OrjJsGJhFYBOAv2AYSbhgsv7XISiErYw4MIr4tBvoRXXx3/rL/MMSdBLBmJwq9+cC/UdLyE6mauQEW0ZThJsVT1a2bbaOePkkc6iWVRHjrcWlnt2DOwh1zW4du8QSZEhnpVksHv0NjmKY01Ao1rZCESHCf1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714114519; c=relaxed/simple;
	bh=JixeC6h2Md34aUqVyFBqsNB0LRCuGvaZA2+nXpuzN6c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=qYzNIxTLfbJOQgBGPrvq0wXr3en1SnCPHH0uKGBNxz3+N3ComJbKi9jvbERQSXxAOP/XWUzLlkUteVyrO4al36AH09uL9/V6ibAAoatAGFtHXXA8tz+WuDNsdHl52PtcB+/CnP1nYlxeMLafWbPDPsMd3S6l7kSJyKft+MaWuoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=bKehq6i2; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1714114501;
	bh=iAUserrlzQWfEfQlOiDXBKxKBrdtzEctg8T6XH8qTyU=;
	h=Date:From:To:Cc:Subject:From;
	b=bKehq6i2hNGNgEf5Pi8uH3a+3tvziZqLTeMouyrTg2/pU4YrQDv28anK2iZDcVX/7
	 gaSB0eDWNqC99woCzZaOj0ZKfN/BFTyh3Y8qPaU3FOlNE67j2bRwaTePQWOZbI06O5
	 cIWPX9MtBUxHIHj/mhT3n+8FATJaWpfuW1TPgyksFn2fZf96I5BTIRdrW4+FPMg5mx
	 K82HQj3k4ubRt8eHA/38Wipiwprf0QQsNh2gRqftofGycQCRJI4Tc1FuWCtFcT9gdP
	 kngeCJBdWVG4eRLGR70961g/WepwflMo9JWxiChYI9Re4FFxxLa89hV/nvxzTPEYqj
	 uvOoVC7ZN+hZw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VQk4N5wRsz4wcd;
	Fri, 26 Apr 2024 16:55:00 +1000 (AEST)
Date: Fri, 26 Apr 2024 16:55:00 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, Sunil Khatri
 <sunil.khatri@amd.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the amdgpu tree
Message-ID: <20240426165500.56c28076@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/VRVBzV2HTccFfCyJtznr2/e";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/VRVBzV2HTccFfCyJtznr2/e
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the amdgpu tree, today's linux-next build (htmldocs)
produced these warnings:

drivers/gpu/drm/amd/include/amd_shared.h:327: warning: Function parameter o=
r struct member 'dump_ip_state' not described in 'amd_ip_funcs'
drivers/gpu/drm/amd/include/amd_shared.h:327: warning: Function parameter o=
r struct member 'print_ip_state' not described in 'amd_ip_funcs'

Introduced by commits

  9c5c98ebec02 ("drm/amdgpu: add prototype for ip dump")
  70977336d483 ("drm/amdgpu: add protype for print ip state")

--=20
Cheers,
Stephen Rothwell

--Sig_/VRVBzV2HTccFfCyJtznr2/e
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYrT8QACgkQAVBC80lX
0GzapAf9H+yIs3RoMYSudVsvx4mYCelrQqXeRu7tyc47ZYbuItB10Cvnnesw3HC+
PX0YfFbfNtmWSXYfBxEPhby3xLgOPI291XeCADAc3JhHEWsyY5j23SEHYlDZ2X6J
NQ1yCzAUeGiMCp1XPBAdOfHdoXgAzONAtFm6sh50Hr0E6MMmxDwN9uyr060M4985
bFSgZpMoV8JEUlP8skK6vSL+pqwLgZhZt51heViBHa+1SHoilQH6lckSttOAych2
1wlq6DVwd0gmy2Bhh+lX3n5R6tfQ7kr9JWvqcQY57NI1JrrtiiOriAHd2XphIXzc
DwqWvRga4t/cR0DhkU7BnWeyYlM28A==
=e6Nx
-----END PGP SIGNATURE-----

--Sig_/VRVBzV2HTccFfCyJtznr2/e--


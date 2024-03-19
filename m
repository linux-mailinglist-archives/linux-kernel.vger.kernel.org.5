Return-Path: <linux-kernel+bounces-108218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 151108807EA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 00:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 474291C228F2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 23:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1755EE67;
	Tue, 19 Mar 2024 23:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="VluhFGrs"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A3D2F2C;
	Tue, 19 Mar 2024 23:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710889213; cv=none; b=rk8jAFDpsXYDA5rzTlRGad3RYcyfJgmT7x/D9vPtTdOml+7v+AX/gjyTd09xxc1bV3hNGlosxMLznk15SV5mbywyG7nAzhQ6epTx44KaTEpOz0Lxodi9MCoJdt1QMt7zyplCjhYoXCZyuXiKvw4W3r10CcPCGSMVP3pV5DqyZvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710889213; c=relaxed/simple;
	bh=XHWs2TDukjWaaM4rMlR7z3I+PmKwh7KX8+TCMymIhAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=sczpHTkQ7fxo77R9RRoFic7DfY4YOTjEVjIi5W6YMPRB3siwJAfG5bcNL/ePuRynMCxN9OHOurOcJD0FJU8vw737CrCHlX6v+MIhStKvsBJOefCJCNtxYnuNGzSAetPv7O5uI8cLQMsdDBH0pTSLuPP01y5Zv98FTMRnWPUy3IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=VluhFGrs; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1710889199;
	bh=1l5ZS/wHawdSMjrNk1CO13TVElMFEtzAMIJXZOHtZgk=;
	h=Date:From:To:Cc:Subject:From;
	b=VluhFGrs+d4RzzohQs6oQjBVGtOGsfg6cLPIPLjdf6MOLOcH8kqtlSem4tdgkQPF7
	 4zjOaSH4jeh8DEHWRDxveB6W3sfb6MS7ZuObNU32u9u4452hig6VZoMDib4wpo+iEN
	 IhXeVBlsX9ZV+juIWZsrjcEtALQnmDyNbaAHu9JDiTb8NCRt+HKkkflICKLZQJ1hnC
	 LfVwYAQf5at/KlkYQMrwxP5Q9vlgW9AuJ60tZJMRe8/WdC0j4HABSA4cMIJVfgKpln
	 CBvEVjL+inwC4q1O7IIWL+eM7veW1gExr6iqTGOyyuG1iYlXSMqNT7Phm6bS5tG/QO
	 HkjX78uc7+nYA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TznHL6mNbz4wc9;
	Wed, 20 Mar 2024 09:59:58 +1100 (AEDT)
Date: Wed, 20 Mar 2024 09:59:57 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Steve French <smfrench@gmail.com>, CIFS <linux-cifs@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the cifs tree
Message-ID: <20240320095957.324ec03b@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/C.hddX4Iwyg3ysjcjrO=mvA";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/C.hddX4Iwyg3ysjcjrO=mvA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the cifs tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

In file included from fs/smb/client/cifsglob.h:27,
                 from fs/smb/client/cifsfs.c:36:
fs/smb/client/../common/smb2pdu.h:291:9: error: unknown type name '_u8'
  291 |         _u8 BlobData[];
      |         ^~~

Caused by commit

  354c620afff2 ("smb311: additional compression flag defined in updated pro=
tocol spec")

I have used the cifs tree from next-20240319 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/C.hddX4Iwyg3ysjcjrO=mvA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmX6GO0ACgkQAVBC80lX
0GyCrQf/QtN3N7SKfmC9l+xkLpw8xEp0XDS3i2wNT0NHq30jzlpH+skmGLaROFxV
GDdPolyXLomLufURWbGm0+NaIK4BlVFU+kpeG447UOdlwSbtfrjLr2zMxlmm1rD8
5Kb96kgdC+xBXe62fofXVlluhStykbXyVOFg4jCh1wiIZ91Pq4c6wyFVv6h+y8Of
C+mMC0kFLpXl4WDPZNVvTYVn6LEDNRcEWtI6Q3pfMJB+WnwUkEzJosUseVdAGr7Z
U9k22JAcVILCuCiDl1elJS17t/On17HN2oFR9NdFrHiZDP6RPSF87kxqN1FD85eC
KX7NaGH4NsnDiUOyT0D4hpiio5sRCg==
=K3J+
-----END PGP SIGNATURE-----

--Sig_/C.hddX4Iwyg3ysjcjrO=mvA--


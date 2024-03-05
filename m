Return-Path: <linux-kernel+bounces-91432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1337487116C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 01:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1CB328449D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 00:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50725ECF;
	Tue,  5 Mar 2024 00:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="lRff0L6b"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D25910F4;
	Tue,  5 Mar 2024 00:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709597363; cv=none; b=BLdXXT75vt3As0naY7kz+tEqvJNQvKzc+a7adHQRJ2C4HKa/cpU1ueSIG3fp8vhCZTT1NylQh5JMcWcBoQM1AHl4KLHphB72QCEvERa29ZBen26CNKoInILl1FlyxJVEfxfg75KVafi1SOiv80dXFRkxfKMMoK3XZB2IL/aICyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709597363; c=relaxed/simple;
	bh=sjmEfT0ohCbqVdzgG/LkzqVruSg79A1GrsikQf/PbHk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=UxLmEtnsSqYPLJrzmVwQ+7yH2avUfgsoRr6Zes/1joXDtMcHxI+ZAOTiIwKWBck80XqNNre7eEsExgAQkWEQPSUbkpXwjSqJpnVRStXmbdW/ODBKWi/hmMOG2lq9h0xZEJTe8Aw8+9CKJ6J441eM8oOfAiRMzp+csFp1W/qvBpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=lRff0L6b; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1709597356;
	bh=BhjGIujTBJ/bC8q+bjzT0Md5JgyiFQtwGr+hC8HKjZM=;
	h=Date:From:To:Cc:Subject:From;
	b=lRff0L6bcEqeNvLEkyINxqnvMBPvLnI1e023dhZ0VhmKfe5Bm5jnrNbQb5LJPS/D/
	 o3mXhovFHffNkkn2HyhoUds1V7ARuFh5Xm3IaQWjcdI3hYjFhxkxoDj0ZfJ3Vtz7wn
	 ehPt7E4OqPRWaOiOhdDvSiAxqm9NKHztEBUq6GIMkwkKq7lAyzYJaM8m4RGVUk/xK2
	 VnPubfHdV+wsyBmCAFkpZj2K8cFJYFEhC70Ny9jY1yVEMS5+vHiCHQmJI+tfpNRS/8
	 MtcJEfKcaxWK+SyseKYbWqMx83di9myIlkqVK7xnVpCil/cVXMHuW6nqWU98q6XbNW
	 fn/x6KslRoQIw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TpbXD2MX2z4wbr;
	Tue,  5 Mar 2024 11:09:16 +1100 (AEDT)
Date: Tue, 5 Mar 2024 11:09:14 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the cpufreq-arm tree
Message-ID: <20240305110914.69ed133b@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/3hKRnjVnUrb.Xw_eJ5OjhzB";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/3hKRnjVnUrb.Xw_eJ5OjhzB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the cpufreq-arm tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

drivers/cpufreq/qcom-cpufreq-nvmem.c: In function 'qcom_cpufreq_kryo_name_v=
ersion':
drivers/cpufreq/qcom-cpufreq-nvmem.c:194:14: error: 'QCOM_ID_IPQ5321' undec=
lared (first use in this function); did you mean 'QCOM_ID_IPQ5312'?
  194 |         case QCOM_ID_IPQ5321:
      |              ^~~~~~~~~~~~~~~
      |              QCOM_ID_IPQ5312

Caused by commit

  006af7c6958e ("cpufreq: qcom-nvmem: add support for IPQ5321")

I have used the cpufreq-arm tree from next-20240304 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/3hKRnjVnUrb.Xw_eJ5OjhzB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXmYqoACgkQAVBC80lX
0GwOkQgAjoctt69MIVitPcFzcUhVHr2EhFPxJY5eiUbZrKdbzS4371ddSv3AMPcg
IXUU01dYoPeJFHeDkHjHwyK2EM8xU8/Mg5rj0RQ4FqW//6AEtqIxhjL+BUKodkMV
ykinaA6iC/KjhxRyMYsOKWL+P8yQst2vwTYlL5Yl9BB5zzI5ir372aazfVH+VmDT
4Cq4MAEaetnxdsEL7iX8+m1zZQOMHKCWkceuAbSFuBjaM5CFIPtguJlyqHyXzenS
moDE3fHqeuA+LmOMRDq2rzun9GS8ILet6sMyXpgeMyG88VP3yfVb6Xl5NxI9ahOD
ix8F2gPtIe2ChCGXW6wW5Lb0CvhVog==
=yOe7
-----END PGP SIGNATURE-----

--Sig_/3hKRnjVnUrb.Xw_eJ5OjhzB--


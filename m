Return-Path: <linux-kernel+bounces-28264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B048982FC42
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4838A28F4DE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7D33CF5A;
	Tue, 16 Jan 2024 20:44:06 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C4124B5F;
	Tue, 16 Jan 2024 20:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705437845; cv=none; b=ESWNVvQt1ZrPLaGgGhWMC3YycZWIhrjJTW7C2fstjABYpQrBm9SRk5CtNdq7tsOOQP8xml95c/DPtCGxf0025DJg/8SjYFO4CRwFJJx10thelkKWuPU2aFIdtFoUPOpdvIeOHBw7/jkEpasOakwLmf9ELE2zTl/ihDuO8vKgNvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705437845; c=relaxed/simple;
	bh=CZ7ei0D4dK8lP4GUlsYoGNzXEf7NzkxYKYx3wMd+cEI=;
	h=Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To; b=c7d6qBUms3hGpvY9XYZsSl1nqqyIlpc3XkzBqPzmsn4zKVbHyye/u5ShnF6GkxZrw66pc5UXEowtD2gztL7HIGcPDEmZSiVZMxz0CjCvJlpjwj2fuoCZcJhLhMyq5Da+GksOfPLNxpTOdnHIqVZ1tF5okfaV9qtBmTSr5QMiiHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 9713A1C0079; Tue, 16 Jan 2024 21:44:01 +0100 (CET)
Date: Tue, 16 Jan 2024 21:44:01 +0100
From: Pavel Machek <pavel@denx.de>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	"Borislav Petkov (AMD)" <bp@alien8.de>, tglx@linutronix.de,
	mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
	puwen@hygon.cn, seanjc@google.com, kim.phillips@amd.com,
	reinette.chatre@intel.com, babu.moger@amd.com, jmattson@google.com,
	peterz@infradead.org, ashok.raj@intel.com,
	rick.p.edgecombe@intel.com, brgerst@gmail.com, mjguzik@gmail.com,
	jpoimboe@kernel.org, nik.borisov@suse.com, aik@amd.com,
	vegard.nossum@oracle.com, daniel.sneddon@linux.intel.com,
	acdunlap@google.com
Subject: Re: [PATCH AUTOSEL 5.10 09/10] x86/barrier: Do not serialize MSR
 accesses on AMD
Message-ID: <ZabqkZ2vXaicy3pZ@duo.ucw.cz>
References: <20240115232818.210010-1-sashal@kernel.org>
 <20240115232818.210010-9-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4Ia2zJT+I07Stjth"
Content-Disposition: inline
In-Reply-To: <20240115232818.210010-9-sashal@kernel.org>


--4Ia2zJT+I07Stjth
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: "Borislav Petkov (AMD)" <bp@alien8.de>
>=20
> [ Upstream commit 04c3024560d3a14acd18d0a51a1d0a89d29b7eb5 ]
>=20
> AMD does not have the requirement for a synchronization barrier when
> acccessing a certain group of MSRs. Do not incur that unnecessary
> penalty there.
=2E..
> Performance captured using an unmodified ipi-bench using the 'mesh-ipi' o=
ption
> with and without weak_wrmsr_fence() on a Zen4 system also showed signific=
ant
> performance improvement without weak_wrmsr_fence(). The 'mesh-ipi' option=
 ignores
> CCX or CCD and just picks random vCPU.
>=20
>   Average throughput (10 iterations) with weak_wrmsr_fence(),
>         Cumulative throughput: 4933374 IPI/s
>=20
>   Average throughput (10 iterations) without weak_wrmsr_fence(),
>         Cumulative throughput: 6355156 IPI/s
>=20
> [1] https://github.com/bytedance/kvm-utils/tree/master/microbenchmark/ipi=
-bench

Speed improvement, not a bugfix. Please drop.

BR,
									Pavel
									--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--4Ia2zJT+I07Stjth
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZabqkQAKCRAw5/Bqldv6
8uONAJ0WBAl/1FnlM9UMYG/+rhKbGP0K0gCgm6w4SGSIymFTPMqja4N0JqK9w7k=
=ojzs
-----END PGP SIGNATURE-----

--4Ia2zJT+I07Stjth--


Return-Path: <linux-kernel+bounces-100166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 248428792DB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 12:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0BA61F2367E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 11:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD8B79B80;
	Tue, 12 Mar 2024 11:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="VaOi2bx5"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D33679B7A
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 11:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710242413; cv=none; b=NnOtmXnDeTw2ZT9+MmkYH8VuJ+6rO11qWw7Sit5BspW5haxBCrFdE6++oTsM4Hc1M/ht0lI31AUuNEvEWbWaGgEQZneQipq4vZf0AWkkeTx/Yt0GVNGwztFCJPam7Bq5s4vVWJp3wiuAVbiLjMgX7+slZtZb+gEfyxXlNA8m8sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710242413; c=relaxed/simple;
	bh=THPNt9TzHMa9aYpDAVqPM+HQT7ixAh2kp3S6TjD8rmM=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=G+NCmzHmdNITpsTOJpB2yHxssLVu8t/OVolieZGgC5miss3y1bsY3ubSfoCxOawgo1g5eN8O0GUpJeRSV9DAXhg+M5Wk7f+FtUOYzroaQM4Zw3ORGgWN9qTwTjkh2xpFRJrwsAtzHirh3vkUEHpfFAZkFtUK35INjoXy5u9w1Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=VaOi2bx5; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240312112009euoutp017883521ed6014274f86a363bfd8074e8~8AGjmaUKC0425704257euoutp01i;
	Tue, 12 Mar 2024 11:20:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240312112009euoutp017883521ed6014274f86a363bfd8074e8~8AGjmaUKC0425704257euoutp01i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1710242409;
	bh=kVu3MkWqlsaElWb6iWE6s4uATwm43XY3Ol9odMMk/b8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=VaOi2bx5QOCqeYrg5GoLMCOO9kqYJcljlsWa3DZqTyVMMMpZ6GYkWmLIYj7D8xJiK
	 juDeUf8EywPHX3VlxX7BBA4q1K3OmBXz9EzYOzxS1yw/3O5/JxBftTHxveaTakKhzj
	 vIlGHKLYup69fDWMzJmpsM+V9TVPv2xLHyZiTLBU=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240312112008eucas1p11135202c257497fb0df2158d4b730d05~8AGjbkfau2427524275eucas1p1a;
	Tue, 12 Mar 2024 11:20:08 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 2E.73.09552.86A30F56; Tue, 12
	Mar 2024 11:20:08 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240312112008eucas1p20f25ebac3dba209218bd2791c08acdf9~8AGi9dA7Y1877118771eucas1p2i;
	Tue, 12 Mar 2024 11:20:08 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240312112008eusmtrp12491e916a5adcd2e6b3b1f61738dd170~8AGi8xzmB1235012350eusmtrp1k;
	Tue, 12 Mar 2024 11:20:08 +0000 (GMT)
X-AuditID: cbfec7f5-853ff70000002550-77-65f03a6842ed
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 47.1E.09146.86A30F56; Tue, 12
	Mar 2024 11:20:08 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240312112008eusmtip1a9a9d654b9b2f5272622f9a05b527902~8AGiyQfCi3135731357eusmtip1Y;
	Tue, 12 Mar 2024 11:20:08 +0000 (GMT)
Received: from localhost (106.210.248.173) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Tue, 12 Mar 2024 11:20:07 +0000
Date: Tue, 12 Mar 2024 12:20:05 +0100
From: Joel Granados <j.granados@samsung.com>
To: Luis Chamberlain <mcgrof@kernel.org>
CC: Michal Hocko <mhocko@suse.com>, <cve@kernel.org>,
	<linux-kernel@vger.kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
Subject: Re: CVE-2023-52596: sysctl: Fix out of bounds access for empty
 sysctl registers
Message-ID: <20240312112005.u6t3k7fe5pom24yw@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="xi7cclg6zd773sge"
Content-Disposition: inline
In-Reply-To: <Ze9-Xmn8v4P_wppv@bombadil.infradead.org>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHKsWRmVeSWpSXmKPExsWy7djPc7oZVh9SDSZs1LHY39TNbtG8eD2b
	xeVdc9gsbkx4ymhxv8/BgdVj06pONo/9c9ewe6zfcpXF4/MmuQCWKC6blNSczLLUIn27BK6M
	7m8f2Ao6jCuWza5pYOxT6WLk5JAQMJH43L2ftYuRi0NIYAWjxIEvH5khnC+MEif27GeHcD4z
	Slxd/ZoNpmXh95NsEInljBKPDt9iB0mAVfUdVYRIbGWUaJl3kBUkwSKgKvHs435mEJtNQEfi
	/Js7YLaIgIbEvgm9TCANzAKdjBI/rzeBNQgLREnsvbKaBcTmFXCQeNGxlR3CFpQ4OfMJWJxZ
	oEJi28HbjF2MHEC2tMTyfxwgYU4BM4kb63YyQlyqLPF10keoq2slTm25BbZLQqCZU+LM4iZ2
	iISLRPPrE1BFwhKvjm+BistInJ7cwwLRMJlRYv+/D+wQzmpGiWWNX5kgqqwlWq48gepwlFj/
	AORlDiCbT+LGW0GIQ/kkJm2bzgwR5pXoaBOCqFaTWH3vDcsERuVZSF6bheS1WQivQYR1JBbs
	/sSGIawtsWzha2YI21Zi3br3LAsY2VcxiqeWFuempxYb56WW6xUn5haX5qXrJefnbmIEJqvT
	/45/3cG44tVHvUOMTByMhxhVgJofbVh9gVGKJS8/L1VJhPe1zttUId6UxMqq1KL8+KLSnNTi
	Q4zSHCxK4ryqKfKpQgLpiSWp2ampBalFMFkmDk6pBib3M7Yvrb1EXfS7v2YZ/+adW7KcsVjm
	/R2VuyE1hqdYkpPVMhtOvxUzirUy/PlTUDnVbY6cBS//m1wO4fAinvjfvhkcPK/W5UV6HFnM
	Kswa8uRpUb9/4OFyTQ+J+h5u7i0Zfrv63ugxhAvulaj5fHPFdNYXkaZX81p1VCZfWzd3sde0
	/9ofru1i99on8ZZ1jfMLE8UV3a8itY/NTQ23vO99e8/eHwuV/rmK22y26d8k66+bMPto8TyB
	1J4lJydmyJ59+drn2b8DN1XMfqvPNY07+3zdzryKB5vlDn/6uGk262NjQ1+Xxu32C7uCjom8
	LDq96lzLqRUTHH/tdVnKusZ2/oSso98m/ltTc2CGP4sSS3FGoqEWc1FxIgCjUxcF0QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsVy+t/xu7oZVh9SDd4/ELDY39TNbtG8eD2b
	xeVdc9gsbkx4ymhxv8/BgdVj06pONo/9c9ewe6zfcpXF4/MmuQCWKD2bovzSklSFjPziElul
	aEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2Mpa/Osxe0GVc8+DGfvYGxR6WL
	kZNDQsBEYuH3k2xdjFwcQgJLGSXaPs9kg0jISGz8cpUVwhaW+HOtC6roI6PE1iPrmCGcrYwS
	l7pXMINUsQioSjz7uB/MZhPQkTj/5g6YLSKgIbFvQi8TSAOzQCejxM/rTWBjhQWiJPZeWc0C
	YvMKOEi86NjKDmILCVxilPjVKA8RF5Q4OfMJWA2zQJnE1EWNQDYHkC0tsfwfB0iYU8BM4sa6
	nYwQlypLfJ30EeqDWonPf58xTmAUnoVk0iwkk2YhTIIIa0nc+PeSCUNYW2LZwtfMELatxLp1
	71kWMLKvYhRJLS3OTc8tNtQrTswtLs1L10vOz93ECIzZbcd+bt7BOO/VR71DjEwcjIcYVYA6
	H21YfYFRiiUvPy9VSYT3tc7bVCHelMTKqtSi/Pii0pzU4kOMpsBQnMgsJZqcD0wmeSXxhmYG
	poYmZpYGppZmxkrivJ4FHYlCAumJJanZqakFqUUwfUwcnFINTBNmuAQG7D360IZzzo3OJRPD
	8hisHmm+Dj7Uy5VqkPv3dkxAKXfe49V3dmoXsF8OmfGv7cSeKVwN85+VCD78OfHOgVti4WsF
	GY5qF8jXORQuP5Sk69S77wrj/jxN4eBIsXt72r4W3J26OizVvHO/2PTngUtP/VtSxHvoiLPN
	2oL3937vFv0nqXYumO/wqvCX5888tXrGOSNMLVtybvSxDcx73+QUJPuG/nZnjTvQbytlzTQj
	4rzlqqcz5/TvUTK99fn0VTafz3zzGx0snL96LY+cL6K3YUJPUJL3SYeZkzI7jI5/uf/oAsO0
	gNVa9o9uWH3fsVNUcKOMWfn3pxuESmef3a+zI/r7ktRXHtG/tyopsRRnJBpqMRcVJwIAI2yf
	r24DAAA=
X-CMS-MailID: 20240312112008eucas1p20f25ebac3dba209218bd2791c08acdf9
X-Msg-Generator: CA
X-RootMTR: 20240311215755eucas1p112332a9a874672135c14edb722130ad4
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240311215755eucas1p112332a9a874672135c14edb722130ad4
References: <2024030645-CVE-2023-52596-b98e@gregkh>
	<Ze68r7_aTn6Vjbpj@tiehlicka>
	<CGME20240311215755eucas1p112332a9a874672135c14edb722130ad4@eucas1p1.samsung.com>
	<Ze9-Xmn8v4P_wppv@bombadil.infradead.org>

--xi7cclg6zd773sge
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 02:57:50PM -0700, Luis Chamberlain wrote:
> On Mon, Mar 11, 2024 at 09:11:27AM +0100, Michal Hocko wrote:
> > On Wed 06-03-24 06:45:54, Greg KH wrote:
> > > Description
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >=20
> > > In the Linux kernel, the following vulnerability has been resolved:
> > >=20
> > > sysctl: Fix out of bounds access for empty sysctl registers
> > >=20
> > > When registering tables to the sysctl subsystem there is a check to s=
ee
> > > if header is a permanently empty directory (used for mounts). This ch=
eck
> > > evaluates the first element of the ctl_table. This results in an out =
of
> > > bounds evaluation when registering empty directories.
> > >=20
> > > The function register_sysctl_mount_point now passes a ctl_table of si=
ze
> > > 1 instead of size 0. It now relies solely on the type to identify
> > > a permanently empty register.
> > >=20
> > > Make sure that the ctl_table has at least one element before testing =
for
> > > permanent emptiness.
> >=20
> > While this makes the code more robust and more future proof I do not th=
ink
> > this is fixing any real issue not to mention anything with security
> > implications. AFAIU there is no actual code that can generate empty
> > sysctl directories unless the kernel is heavily misconfigured.
> >=20
> > Luis, Joel, what do you think?
>=20
> As per review with Joel:
>=20
> The out-of-bounds issue cannot be triggered in older kernels unless
> you had external modules with empty sysctls. That is because although
> support for empty sysctls was added on v6.6 none of the sysctls that
> were trimmed for the superfluous entry over the different kernel
> releases so far has had the chance to be empty.
>=20
> The 0-day reported crash was for a future out of tree patch which was
> never merged yet:
>=20
> https://github.com/Joelgranados/linux/commit/423f75083acd947804c8d5c31ad1=
e1b5fcb3c020                                                               =
                                       =20
>=20
> Let's examine this commit to see why it triggers a crash to understand
> how the out of bounds issue can be triggered.
>=20
> Looking for suspects of sysctls which may end up empty in that patch we
> have a couple. kernel/sched/fair.c sched_fair_sysctls can end up empty wh=
en
> you don't have CONFIG_CFS_BANDWIDTH or CONFIG_NUMA_BALANCING. But the ker=
nel
> config for the 0-day test was:                                           =
                                                                           =
                                                  =20
> https://download.01.org/0day-ci/archive/20231120/202311201431.57aae8f3-ol=
iver.sang@intel.com/config-6.6.0-rc2-00030-g423f75083acd                   =
                                       =20
>=20
> It has CONFIG_CFS_BANDWIDTH=3Dy but CONFIG_NUMA_BALANCING is not set so
> this was not the culprit, but that configuration could have been a
> cause if it was possible.
>=20
> In the same future-not-upstream commit kernel/sched/core.c sched_core_sys=
ctls
> can be empty if you don't have the following:                            =
                                                                           =
             =20
>=20
> CONFIG_SCHEDSTATS       --> not set on 0-day kernel
> CONFIG_UCLAMP_TASK      --> not set on 0-day kernel                      =
                                                                           =
                                       =20
> CONFIG_NUMA_BALANCING   --> not set on 0-day kernel
>=20
> So that was the cause, and an example real valid config which can trigger
> a crash. But that patch was never upstream.
>=20
> Now, we can look for existing removal of sysctl sentinels with:
>=20
> git log -p --grep "superfluous sentinel element"
>=20
> And of these, at first glance, only locks_sysctls seems like it *could*
> possibly end up in a situation where random config would create an empty
> sysctl, but exanding on the code we see that's not possible because
> leases-enable sysctl entry is always built if you have sysctls enabled:
>=20
> static struct ctl_table llocks_sysctlsocks_sysctls[] =3D {
>         {
>                 .procname       =3D "leases-enable",
>                 .data           =3D &leases_enable,
>                 .maxlen         =3D sizeof(int),                         =
         =20
>                 .mode           =3D 0644,
>                 .proc_handler   =3D proc_dointvec,
>         },
> #ifdef CONFIG_MMU
>         {
>                 .procname       =3D "lease-break-time",
>                 .data           =3D &lease_break_time,                   =
         =20
>                 .maxlen         =3D sizeof(int),
>                 .mode           =3D 0644,
>                 .proc_handler   =3D proc_dointvec,
>         },
> #endif /* CONFIG_MMU */
> };
>=20
> The out of bounds fix commit should have just had the tag:
>=20
> Fixes 9edbfe92a0a13 ("sysctl: Add size to register_sysctl")
>=20
> Backporting this is fine, but wouldn't fix an issue unless an external
It is not only fine, I think it is necessary to avoid some other future
backported patch actually introducing an empty sysctl.

> module had empty sysctls. And exploiting this is not possible unless
> you purposely build an external module which could end up with empty
> sysctls.
This is exactly my conclusion.
Very nice summary Luis. Thx for putting it together

>=20
> HTH,
>=20
>   Luis


--=20

Joel Granados

--xi7cclg6zd773sge
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmXwOmQACgkQupfNUreW
QU+Cfgv/RlgmVAWF6PFmsVJYBKzD8AEAUxMsRWCHlA6QlS8pgCoYGs98klDUxxz4
7hdClzTTQfPBlP+Ym9Zz96CarGidjQyjwlyUHkACTxZrxmAs+WZXmX2DXRpBrDVl
iJ+hJfMMKw9HRGcAa+IK4d2StMsxljMxGjK28zTJeNrDLuXFOzpqYIostV2Fn5+F
8TDTXlBC6WdP16hni/9r8lxdwjhbsA6OctlamDsYiQOBkdbnnle/fOiRd1hXHxE3
9fkH7flAaC4UTOieI0lLgBj97NG6vi1iZ4aLuRcUCYNwK9Vf6vUDjcOt1hif2jlG
fKljzov0p6sltfl7vJoWHE5PhT/x5jZK/N4AF1o+3/UoE++foNPiYD8qLpNwISNJ
2t4EB0raC/ELQeVgyhnikur3lTOKLLto9nI9CyZsgXyo6QykSxJYQLpzD8ZQ6lI4
hQLg3+LGZKAC/Vu2GG2wX/hYHLKMiOCUahTvZgNnDa1tqQA+79ag/Z4xT2jXbm3m
DzF+R2/8
=AfvB
-----END PGP SIGNATURE-----

--xi7cclg6zd773sge--


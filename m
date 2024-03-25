Return-Path: <linux-kernel+bounces-116800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED9888A409
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2BF01C3AF41
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E86818270A;
	Mon, 25 Mar 2024 10:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="UZ8bY5wK"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF5619D1BD
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711361251; cv=none; b=OXx1I2K5Ff+MRADLpFacuR6+PU1N9pJdrDTzUsa7mDGZHFJdcARFtBEB62hJyoWSXh1b1UlFKBUtodXiseMvSIyWssPgZEjpC73wiSrO5PfymOZcd3mYmRjOQ4ZBt/BJEKgOLG6nUO23Se9jcOZQLGkBYUw8zGrEr88xqX7J5BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711361251; c=relaxed/simple;
	bh=7SekN0pq2OpVrKvZMHjrFSyAv7eYom/aQNWVRXOr1qE=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=FXkF/+pPt8cgdha3HM2r9/4u4R9LTFz+BSM42Wn72nmsfPzhLHcaP7T1IEPwJXkaUk1dOuuSiUac8y5XKdLny70nw7lT2rD4TxSaLnXNBfDpcSGh1fz+uut9Z0WF2Xtg2WrLYkba6gsTE3U3C/ugNAB8Hat2iPKMqTd20/4X0XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=UZ8bY5wK; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240325100720euoutp026c8259d15fd16d99dd8a8780c274401c~-_fs3tshg2772727727euoutp02z;
	Mon, 25 Mar 2024 10:07:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240325100720euoutp026c8259d15fd16d99dd8a8780c274401c~-_fs3tshg2772727727euoutp02z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1711361240;
	bh=wzS8KlzptyOGHcav4rSk+oLH7xnQ315uslcLvyvxP38=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=UZ8bY5wKn/BbkfK0tpuoSa7j9LQ4Tumtt0IjbxAtQJm6tvlqs+dc+C3OQ76kKnGI4
	 wze4GMmb1g8rOz4Jdvea4qSRSJzOPs0jUG22sG65817I4kh7qpkIrYf8qd7yJyD/ZZ
	 OECA5qVf4M3eYDk6rMMY6GNCv/DSzlQw8eUC/89k=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240325100720eucas1p21a8e21ba03729454d2c4480555abb3a8~-_fsZ5By42225622256eucas1p2S;
	Mon, 25 Mar 2024 10:07:20 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 6C.C3.09814.8DC41066; Mon, 25
	Mar 2024 10:07:20 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240325100719eucas1p14e5391ce737eb1c41fbf71f42d71e000~-_fsAh5m22730327303eucas1p1g;
	Mon, 25 Mar 2024 10:07:19 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240325100719eusmtrp24d7feb773b190b48c7840957adb483a1~-_fr-pr440317903179eusmtrp2z;
	Mon, 25 Mar 2024 10:07:19 +0000 (GMT)
X-AuditID: cbfec7f4-727ff70000002656-4a-66014cd8cb68
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 2F.E0.09146.7DC41066; Mon, 25
	Mar 2024 10:07:19 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240325100719eusmtip2e42a3262dd92e4523c30f33cb9113019~-_frzEaZu2367323673eusmtip2P;
	Mon, 25 Mar 2024 10:07:19 +0000 (GMT)
Received: from localhost (106.110.32.44) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Mon, 25 Mar 2024 10:07:19 +0000
Date: Mon, 25 Mar 2024 10:55:21 +0100
From: Joel Granados <j.granados@samsung.com>
To: Wen Yang <wenyang.linux@foxmail.com>
CC: "Eric W . Biederman" <ebiederm@xmission.com>, Luis Chamberlain
	<mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>, Christian Brauner
	<brauner@kernel.org>, Iurii Zaikin <yzaikin@google.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/9] sysctl: support encoding values directly in the
 table entry
Message-ID: <20240325095521.roo4u7l3g3u3bjke@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="bk7qmu3hf5kbep73"
Content-Disposition: inline
In-Reply-To: <tencent_994355E551CB05854C76A567301BFBC93D0A@qq.com>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHKsWRmVeSWpSXmKPExsWy7djPc7o3fBjTDG4+57Z4ffgTo8X/bS3s
	Fme6cy0u75rDZnFjwlNGi5bVu1gtlu30c2D3mN1wkcVjQc95Zo8Fm0o9Nq3qZPP4vEnOY8qh
	dpYAtigum5TUnMyy1CJ9uwSujGMP5zIXdElWXH/TyNrAeFiki5GTQ0LARGLZpL3MXYxcHEIC
	Kxgl/nxuZoJwvgA5X9ewQjifGSUO3rvADtOy5e5uRojEckaJiadvMIMkwKo6lmpAJDYzSqw8
	shOsg0VAVaLn3B5GEJtNQEfi/Js7YA0iAhoS5652g61gFnjFKPH85WUmkISwQKTE1yXXgGwO
	Dl4BB4n78/xBwrwCghInZz5hAbGZBSokfjdNYgMpYRaQllj+jwMkzCngJPF7xWs2iEMVJb4u
	vscCYddKnNpyiwnCns8pcWFjFITtIvHo1C9WCFtY4tXxLVBPykj83zkfHBQSApMZJfb/+8AO
	4axmlFjW+BVqkrVEy5UnUB2OEsfXnAW7WUKAT+LGW0GIO/kkJm2bzgwR5pXoaBOCqFaTWH3v
	DcsERuVZSD6bheSzWQifQZiaEut36aOIghRrSyxb+JoZwraVWLfuPcsCRvZVjOKppcW56anF
	Rnmp5XrFibnFpXnpesn5uZsYgcns9L/jX3YwLn/1Ue8QIxMH4yFGFaDmRxtWX2CUYsnLz0tV
	EuFt+cKQJsSbklhZlVqUH19UmpNafIhRmoNFSZxXNUU+VUggPbEkNTs1tSC1CCbLxMEp1cCU
	/r7vxK02haOxP1wCfyzgDT8WuJHFcdu9BPuEmrtsBc2Hdn0/uFGF+YF01frqOW/qOj+YLVHd
	/3rCK1kpNauFzi+b1Xp2pFvnbzu7s7GXMW/OGubo3zmVxx9FesqnPe5LDm7+zb9q4+755kzR
	cjlef/0Pp3TeFnU3EeOe/S7k1GRO4fTytMKcyaWvnZ8UP5zg+OOVmdGqK5kJF/fk7W25Jyyw
	qcugzf3yX4Z5OT9lHrQl7XzWEWZgGOZ4/u9How/n3lmwd54ojfz1S/5Ew4zUa878m46rxJiy
	N/tb9Vq4P2Zzuqj6ii9gb86J64sjnwU+i5Lx1JBsCzRdymBk8Gz1zCsr7NQvdIXOfx//aroS
	S3FGoqEWc1FxIgDwafC34QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFIsWRmVeSWpSXmKPExsVy+t/xe7rXfRjTDH606lu8PvyJ0eL/thZ2
	izPduRaXd81hs7gx4SmjRcvqXawWy3b6ObB7zG64yOKxoOc8s8eCTaUem1Z1snl83iTnMeVQ
	O0sAW5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZapG+XYJe
	xu5rr5kKOiQrzv+6ytzAeFCki5GTQ0LARGLL3d2MXYxcHEICSxkl7v74zg6RkJHY+OUqK4Qt
	LPHnWhcbRNFHRokTqz6BJYQENjNKLDgXAWKzCKhK9JzbwwhiswnoSJx/c4cZxBYR0JA4d7Wb
	FaSZWeAVo8Tzl5eZQBLCApESX5dcA7I5OHgFHCTuz/OHWLCdSeL5o6lgNbwCghInZz5hAalh
	FiiT6HyoAGFKSyz/xwFSwSngJPF7xWs2iDsVJb4uvscCYddKfP77jHECo/AsJINmIQyahTAI
	pIJZQF3iz7xLzBjC2hLLFr5mhrBtJdate8+ygJF9FaNIamlxbnpusaFecWJucWleul5yfu4m
	RmBEbzv2c/MOxnmvPuodYmTiYDzEqALU+WjD6guMUix5+XmpSiK8LV8Y0oR4UxIrq1KL8uOL
	SnNSiw8xmgLDcCKzlGhyPjDV5JXEG5oZmBqamFkamFqaGSuJ83oWdCQKCaQnlqRmp6YWpBbB
	9DFxcEo1MBnnB0yQmnH7J7/wttiXmgEsz0+2eVcLuP6t6M53/qBe9u9MxMI73vtf2j+vPal6
	WcrVmvXHjd7EziSXzzul8rqqCyezVRZtzKn5/WzBvWNm9du6oiyLi0X3fLs+WY29nTntj430
	0ScOV/9c8uTNW5Padu7ujjVzdA1Oq7CeWXdR7NQVEztT08X7l8R15RuHL/5Rs5WX57WZ8vG1
	O3Ki9ibFbOa7uOz/rfRb+lktIl8rtvUscjbyVdBc+6zu6c6yqcmrVdYwOLoxcrz5JnrOdJLx
	1O0J8kw92irHD/18U/b7MJfW+Uyly+sydi0+bRXq6HCgWn3buqbz6i9+b8hf4t+8xjTCq+Op
	W86epuB/dkosxRmJhlrMRcWJAEtmvh99AwAA
X-CMS-MailID: 20240325100719eucas1p14e5391ce737eb1c41fbf71f42d71e000
X-Msg-Generator: CA
X-RootMTR: 20240309103218eucas1p12d642356f7e90ebdf6a7a3101688f55a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240309103218eucas1p12d642356f7e90ebdf6a7a3101688f55a
References: <cover.1709978655.git.wenyang.linux@foxmail.com>
	<CGME20240309103218eucas1p12d642356f7e90ebdf6a7a3101688f55a@eucas1p1.samsung.com>
	<tencent_143077FB953D8B549153BB07F54C5AA4870A@qq.com>
	<20240321162758.tkituzvff5rwnvd2@joelS2.panther.com>
	<tencent_994355E551CB05854C76A567301BFBC93D0A@qq.com>

--bk7qmu3hf5kbep73
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 11:43:16PM +0800, Wen Yang wrote:
>=20
>=20
<--- snip --->
> > information that the NULL pointer gave you. This is effectively adding 2
> > bits per ctl_table element for all ctl_table types; event the ones that
> > do not need min max. So how much will we actually save with all this?
> > once you have added these 2 bits and removed the static variables from
> > the files that are not using the pointers? Is saving read only memory
> > the only reason for this? If that is the case, please add some
> > calculations of how much we save to see if it actually make sense. To
> > calculate the memory gains/losses you can use the bloat-o-meter script
> > under the scripts directory (something similar to what we did here
> > https://lore.kernel.org/all/20240314-jag-sysctl_remset_net-v1-0-aa26b44=
d29d9@samsung.com)
> >=20
> > I'll hold off on reviewing the other patches in this set until this is a
> > bit more clear.
> >=20
>=20
> Thank you for your comments.
>=20
> When we started this work, we had not yet seen Thomas's patch, so by=20
> borrowing the existing enum type=E2=80=98s field, we can achieve directly=
=20
> encoding values without increasing the size of the ctl_table.
>=20
> We really appreciate that you pointed out this issue. It will take some=
=20
> time for rework and the v3 will be sent out within a few weeks.
>=20
> In addition, the patch below is not related to "kill sysctl_vals". It is=
=20
> just a regular optimization and was sent over 10 days ago. We also hope=
=20
> to receive your kind advice:
>=20
> https://lkml.org/lkml/2024/3/8/871
>=20
> [RESEND PATCH v2] sysctl: move the extra1/2 boundary check of u8 to=20
> sysctl_check_table_array

Thx for pointing this out, I had missed it. On my todo list :)

>=20
> --
> Best wishes,
> Wen
>=20
>=20
> >> +	union {
> >> +		struct {
> >> +			void *extra1;
> >> +			void *extra2;
> >> +		};
> >> +		struct {
> >> +			long min;
> >> +			long max;
> >> +		};
> >> +	};
> >> +
> >>   	proc_handler *proc_handler;	/* Callback for text formatting */
> >>   	struct ctl_table_poll *poll;
> >> -	void *extra1;
> >> -	void *extra2;
> >>   } __randomize_layout;
> > ...
> >=20
> > Best
>=20

--=20

Joel Granados

--bk7qmu3hf5kbep73
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmYBSggACgkQupfNUreW
QU/aPAv8C13NsArA0/XO91x/u1pLXveSbgN02ibweD9B0fgyCJ8kDeE6tFv9JRyy
N+C+YzmIrDeSlpwNLAAtWNLvCABlf4/+PJN0KFXX/fYlrmWH9C8zMNtF5IUgUG6P
g0VvViXWWiQpzBvCN+OqGm1E/HoVIafxNHfod0Yv05rYAAuIEFfUZ/doY3Sr8c+9
MJPwL4zP6+tavZMaoJlQf3v65R8mjg0u3FsSQxtNbQADDyzZ4ijzVBHBJya9EMai
KnY3rPrDCVF5KbkqVNWSSgrhqLAPoUWdECTNGPvkq2G+kxGHsX7odh9hkMnnf0RQ
U0osT2K7aG0LaVkyWwQcehLqz9LLgzytFtQSWMruivVfA/tfYVo6CS/yvnbb09qY
IBgSD3mNmh3kdiP35D+DYEF5ZyzXESMA7oWkSyUPn83LhMV1R50e8d7NcIoCgg6+
z4p+e1C0vbx1LiFvLVOrKQ1rOSG5WvT/E5IrPJsh/dwajsLXR0crbR93YiRs5kgN
JjWW7n3R
=S0x0
-----END PGP SIGNATURE-----

--bk7qmu3hf5kbep73--


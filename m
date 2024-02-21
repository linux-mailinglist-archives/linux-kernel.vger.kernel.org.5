Return-Path: <linux-kernel+bounces-73908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B0785CD7D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 02:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6B101C22985
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 01:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B7A4428;
	Wed, 21 Feb 2024 01:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="b6wYO1xP"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98634694
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 01:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708479085; cv=none; b=B4uHmj0hfMlkXRCF7cn1Go47tddyAoQr+5j+HX9Z057NwEloJ3Q01S1qc4sXciYnqTAUzN2A7ERAKaWWdkj651kxxEWePfy89wKF3JDx/dq44ti783v+IbFqMbQ+1CYkSosLeJUI4/bL3aWjC8dl/FouvhU7xxs508ug9PXp7Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708479085; c=relaxed/simple;
	bh=KB6rBRoht3+FHRbi8BcPjMMptPUZaRfNar0xIbBLU2o=;
	h=Mime-Version:Subject:From:To:CC:In-Reply-To:Message-ID:Date:
	 Content-Type:References; b=NXoZd5dO3M2WhrhJE4ni1wNfHqRATE9QupoXagRGlSMch6hWBSoE6vhIJhuyeKSI5mf3mXNZQSGCtBr4jXGn5D6Vn5SLsFitRXxG9V6lH+N0AxRJfTi9UMquSOFWpirJR2+L8WapnvDTrCVcgTKyAK4/gqy+rfAjzss4Lng+f5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=b6wYO1xP; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240221013120epoutp01bb146498b629244ff477899f5b99637a~1vKwMjTFG0410304103epoutp01N
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 01:31:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240221013120epoutp01bb146498b629244ff477899f5b99637a~1vKwMjTFG0410304103epoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1708479080;
	bh=KB6rBRoht3+FHRbi8BcPjMMptPUZaRfNar0xIbBLU2o=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=b6wYO1xP2V0NXOBPCAQcoJ8287usnVLRJS3E5nc7++7iqPTTpgbb99+KBNXYr26Lz
	 /Ib0lyK2PxMTK5nhgkkZN+I4l7X1WOhkejdyaR6rN0GKyXt6Hw5Hm7NWAJmLiDSfui
	 C0xjDhlpPrHOoMOmzmKRO/ewaVNJyO77UmTN81vk=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTP id
	20240221013120epcas2p47e78f24dcbf058fd91d3bb8b8fed4102~1vKvqNEqh1365013650epcas2p4z;
	Wed, 21 Feb 2024 01:31:20 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.89]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4Tfdyv4rKcz4x9Pr; Wed, 21 Feb
	2024 01:31:19 +0000 (GMT)
X-AuditID: b6c32a45-3ebfd70000002716-ee-65d552671cc9
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
	epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	35.10.10006.76255D56; Wed, 21 Feb 2024 10:31:19 +0900 (KST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: RE:(2) [f2fs-dev] [PATCH v6] f2fs: New victim selection for GC
Reply-To: yonggil.song@samsung.com
Sender: Yonggil Song <yonggil.song@samsung.com>
From: Yonggil Song <yonggil.song@samsung.com>
To: Daeho Jeong <daeho43@gmail.com>
CC: "jaegeuk@kernel.org" <jaegeuk@kernel.org>, "chao@kernel.org"
	<chao@kernel.org>, "linux-f2fs-devel@lists.sourceforge.net"
	<linux-f2fs-devel@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Dongjin Kim <dongjin_.kim@samsung.com>,
	Daejun Park <daejun7.park@samsung.com>, Siwoo Jung <siu.jung@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <CACOAw_wS0SS8xhoKkK9aBz2mquVw4fYwfJFqGUJ4QUk08XfxdA@mail.gmail.com>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20240221013119epcms2p28bf15af46e7a330b0f9049abb4a2cc32@epcms2p2>
Date: Wed, 21 Feb 2024 10:31:19 +0900
X-CMS-MailID: 20240221013119epcms2p28bf15af46e7a330b0f9049abb4a2cc32
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjk+LIzCtJLcpLzFFi42LZdljTXDc96Gqqwa4b8hanp55lsnhz5AyL
	xaoH4RY/TppYPFk/i9ni0iJ3i8u75rBZnJ/4msmBw2PnrLvsHptWdbJ57F7wmcmjb8sqRo/P
	m+QCWKOybTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOA
	DlFSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTkFJgX6BUn5haX5qXr5aWWWBkaGBiZ
	AhUmZGccajvLXLBuBWPFq1s9TA2MPxczdjFycEgImEhcnJbTxcjJISSwg1Hi6k55kDCvgKDE
	3x3CIGFhAXeJg+27mSFKlCSuHehlgYjrS2xevIwdxGYT0JX4u2E5mC0ioCyx7fJDMJtZ4D6T
	xI02RhBbQoBXYkb7UxYIW1pi+/KtYHFOgUCJW6s+skPENSR+LOtlhrBFJW6ufssOY78/Nh9q
	johE672zUDWCEg9+7oaKS0osOnSeCcLOl/i74jobhF0jsbWhDSquL3GtYyPYDbwCvhL3F54B
	m8MioCpxc+N8FkiIuEhsa5SGOF9bYtnC18wgYWYBTYn1u/QhKpQljtxigajgk+g4/Jcd5sEd
	855ALVKT2LxpMyuELSNx4TEsEDwkjm6ayDiBUXEWIphnIdk1C2HXAkbmVYxiqQXFuempxUYF
	hvCYTc7P3cQITpBarjsYJ7/9oHeIkYmD8RCjBAezkggvS/mVVCHelMTKqtSi/Pii0pzU4kOM
	pkBPTmSWEk3OB6bovJJ4QxNLAxMzM0NzI1MDcyVx3nutc1OEBNITS1KzU1MLUotg+pg4OKUa
	mOad/LWy65/eKe6baSVTP3nvNu1KNDRt6UphydBkN4soSDR6UrL3EMtinwOqPTuf9Er5N7p+
	fCbhednOOGF355xt9q4Wld2zd0x9x/Mx66iC9aE1Pnpu2ybt40m6Lrbaj3f/r9vbhNwyU9uK
	nyan7X61w2TPnbdnd+8MN0wLbuu83KBxutniTeEvZofH63mf7ODKXmJ9ZeJEXsmaTf8Xvo7t
	VE6caL4/wD366e2QwxYbvhrMtLFWU5+bvt3tfBFD5ffjro837dpjyvxK4sbmfmW+qWKSYiIO
	853V2/n3/Z839f4f811iq067K3qeevF46pGZJ9dPLymeMftb4OHUFcINJgx3w/zfZV7MbJHy
	3aHEUpyRaKjFXFScCAAJn/afGQQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240214013426epcms2p655328452ef7fac82f3df56855d7dd99b
References: <CACOAw_wS0SS8xhoKkK9aBz2mquVw4fYwfJFqGUJ4QUk08XfxdA@mail.gmail.com>
	<20240214013426epcms2p655328452ef7fac82f3df56855d7dd99b@epcms2p6>
	<CGME20240214013426epcms2p655328452ef7fac82f3df56855d7dd99b@epcms2p2>

> On Tue, Feb 13, 2024 at 5:36=E2=80=AFPM=20Yonggil=20Song=20<yonggil.song=
=40samsung.com>=20wrote:=0D=0A>=20>=0D=0A>=20>=0D=0A>=20>=20Overview=0D=0A>=
=20>=20=3D=3D=3D=3D=3D=3D=3D=3D=0D=0A>=20>=0D=0A>=20>=20This=20patch=20intr=
oduces=20a=20new=20way=20to=20preference=20data=20sections=20when=20selecti=
ng=0D=0A>=20>=20GC=20victims.=20Migration=20of=20data=20blocks=20causes=20i=
nvalidation=20of=20node=20blocks.=0D=0A>=20>=20Therefore,=20in=20situations=
=20where=20GC=20is=20frequent,=20selecting=20data=20blocks=20as=0D=0A>=20>=
=20victims=20can=20reduce=20unnecessary=20block=20migration=20by=20invalida=
ting=20node=20blocks.=0D=0A>=20=0D=0A>=20Your=20approach=20will=20allocate=
=20new=20node=20blocks=20despite=20invalidating=0D=0A>=20current=20node=20b=
locks=20while=20moving=20data=20blocks,=20though.=20While=20your=0D=0A>=20a=
pproach=20may=20work=20well=20relating=20to=20WAF=20in=20a=20specific=20sce=
nario,=20such=20as=0D=0A>=20randomly=20overwriting=20an=20entire=20storage=
=20space=20with=20a=20huge=20file,=20it=20is=0D=0A>=20important=20to=20cons=
ider=20its=20general=20applicability.=20For=20example,=20how=0D=0A>=20about=
=20the=20test=20performance?=20Performance=20optimization=20should=20encomp=
ass=0D=0A>=20a=20wide=20range=20of=20user=20scenarios.=20However,=20I=20am=
=20not=20convinced=20that=20this=0D=0A>=20is=20the=20most=20efficient=20sol=
ution=20for=20most=20users.=20Can=20you=20provide=20more=0D=0A>=20informati=
on=20about=20how=20your=20approach=20addresses=20the=20performance=20needs=
=20of=0D=0A>=20a=20broader=20spectrum=20of=20user=20scenarios?=0D=0A>=20=0D=
=0A=0D=0AThank=20you=20for=20your=20review=20and=20feedback.=20I=20agree=20=
with=20your=20opinion.=0D=0AI'll=20research=20and=20develop=20this=20approa=
ch=20for=20the=20user=20scenario.=0D=0A=0D=0A>=20>=20For=20exceptional=20si=
tuations=20where=20free=20sections=20are=20insufficient,=20node=20blocks=0D=
=0A>=20>=20are=20selected=20as=20victims=20instead=20of=20data=20blocks=20t=
o=20get=20extra=20free=20sections.=0D=0A>=20>=0D=0A>=20>=20Problem=0D=0A>=
=20>=20=3D=3D=3D=3D=3D=3D=3D=0D=0A>=20>=0D=0A>=20>=20If=20the=20total=20amo=
unt=20of=20nodes=20is=20larger=20than=20the=20size=20of=20one=20section,=20=
nodes=0D=0A>=20>=20occupy=20multiple=20sections,=20and=20node=20victims=20a=
re=20often=20selected=20because=20the=0D=0A>=20>=20gc=20cost=20is=20lowered=
=20by=20data=20block=20migration=20in=20GC.=20Since=20moving=20the=20data=
=0D=0A>=20>=20section=20causes=20frequent=20node=20victim=20selection,=20vi=
ctim=20threshing=20occurs=20in=0D=0A>=20>=20the=20node=20section.=20This=20=
results=20in=20an=20increase=20in=20WAF.=0D=0A>=20>=0D=0A>=20>=20Experiment=
=0D=0A>=20>=20=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D=0A>=20>=0D=0A>=20>=20Test=
=20environment=20is=20as=20follows.=0D=0A>=20>=0D=0A>=20>=20=20=20=20=20=20=
=20=20=20System=20info=0D=0A>=20>=20=20=20=20=20=20=20=20=20=20=20-=203.6GH=
z,=2016=20core=20CPU=0D=0A>=20>=20=20=20=20=20=20=20=20=20=20=20-=2036GiB=
=20Memory=0D=0A>=20>=20=20=20=20=20=20=20=20=20Device=20info=0D=0A>=20>=20=
=20=20=20=20=20=20=20=20=20=20-=20a=20conventional=20null_blk=20with=20228M=
iB=0D=0A>=20>=20=20=20=20=20=20=20=20=20=20=20-=20a=20sequential=20null_blk=
=20with=204068=20zones=20of=208MiB=0D=0A>=20>=20=20=20=20=20=20=20=20=20For=
mat=0D=0A>=20>=20=20=20=20=20=20=20=20=20=20=20-=20mkfs.f2fs=20<conv=20null=
_blk>=20-c=20<seq=20null_blk>=20-m=20-Z=208=20-o=203.89=0D=0A>=20>=20=20=20=
=20=20=20=20=20=20Mount=0D=0A>=20>=20=20=20=20=20=20=20=20=20=20=20-=20moun=
t=20<conv=20null_blk>=20<mount=20point>=0D=0A>=20>=20=20=20=20=20=20=20=20=
=20Fio=20script=0D=0A>=20>=20=20=20=20=20=20=20=20=20=20=20-=20fio=20--rw=
=3Drandwrite=20--bs=3D4k=20--ba=3D4k=20--filesize=3D31187m=20--norandommap=
=20--overwrite=3D1=20--name=3Djob1=20--filename=3D./mnt/sustain=20--io_size=
=3D128g=0D=0A>=20>=20=20=20=20=20=20=20=20=20WAF=20calculation=0D=0A>=20>=
=20=20=20=20=20=20=20=20=20=20=20-=20(IOs=20on=20conv.=20null_blk=20+=20IOs=
=20on=20seq.=20null_blk)=20/=20random=20write=20IOs=0D=0A>=20>=0D=0A>=20>=
=20Conclusion=0D=0A>=20>=20=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D=0A>=20>=0D=0A>=
=20>=20This=20experiment=20showed=20that=20the=20WAF=20was=20reduced=20by=
=2029%=20(18.75=20->=2013.3)=20when=0D=0A>=20>=20the=20data=20section=20was=
=20selected=20first=20when=20selecting=20GC=20victims.=20This=20was=0D=0A>=
=20>=20achieved=20by=20reducing=20the=20migration=20of=20the=20node=20block=
s=20by=2069.4%=0D=0A>=20>=20(253,131,743=20blks=20->=2077,463,278=20blks).=
=20It=20is=20possible=20to=20achieve=20low=20WAF=0D=0A>=20>=20performance=
=20with=20the=20GC=20victim=20selection=20method=20in=20environments=20wher=
e=20the=0D=0A>=20>=20section=20size=20is=20relatively=20small.=0D=0A>=20>=
=0D=0A>=20>=20Signed-off-by:=20Yonggil=20Song=20<yonggil.song=40samsung.com=
>=0D=0A>=20>=20---=0D=0A>=20>=20=20fs/f2fs/f2fs.h=20=7C=20=201=20+=0D=0A>=
=20>=20=20fs/f2fs/gc.c=20=20=20=7C=2096=20+++++++++++++++++++++++++++++++++=
++++++-----------=0D=0A>=20>=20=20fs/f2fs/gc.h=20=20=20=7C=20=206=20++++=0D=
=0A>=20>=20=203=20files=20changed,=2082=20insertions(+),=2021=20deletions(-=
)=0D=0A>=20>=0D=0A>=20>=20diff=20--git=20a/fs/f2fs/f2fs.h=20b/fs/f2fs/f2fs.=
h=0D=0A>=20>=20index=2065294e3b0bef..b129f62ba541=20100644=0D=0A>=20>=20---=
=20a/fs/f2fs/f2fs.h=0D=0A>=20>=20+++=20b/fs/f2fs/f2fs.h=0D=0A>=20>=20=40=40=
=20-1654,6=20+1654,7=20=40=40=20struct=20f2fs_sb_info=20=7B=0D=0A>=20>=20=
=20=20=20=20=20=20=20=20struct=20f2fs_mount_info=20mount_opt;=20=20=20=20=
=20=20=20/*=20mount=20options=20*/=0D=0A>=20>=0D=0A>=20>=20=20=20=20=20=20=
=20=20=20/*=20for=20cleaning=20operations=20*/=0D=0A>=20>=20+=20=20=20=20=
=20=20=20bool=20require_node_gc;=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20/*=20flag=20for=20node=20GC=20*/=0D=0A>=20>=20=20=20=20=20=
=20=20=20=20struct=20f2fs_rwsem=20gc_lock;=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20/*=0D=0A>=20>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20*=20semaphore=20for=20GC,=20avoid=0D=0A>=20>=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20*=20ra=
ce=20between=20GC=20and=20GC=20or=20CP=0D=0A>=20>=20diff=20--git=20a/fs/f2f=
s/gc.c=20b/fs/f2fs/gc.c=0D=0A>=20>=20index=20a079eebfb080..53a51a668567=201=
00644=0D=0A>=20>=20---=20a/fs/f2fs/gc.c=0D=0A>=20>=20+++=20b/fs/f2fs/gc.c=
=0D=0A>=20>=20=40=40=20-341,6=20+341,14=20=40=40=20static=20unsigned=20int=
=20get_cb_cost(struct=20f2fs_sb_info=20*sbi,=20unsigned=20int=20segno)=0D=
=0A>=20>=20=20=20=20=20=20=20=20=20unsigned=20int=20i;=0D=0A>=20>=20=20=20=
=20=20=20=20=20=20unsigned=20int=20usable_segs_per_sec=20=3D=20f2fs_usable_=
segs_in_sec(sbi,=20segno);=0D=0A>=20>=0D=0A>=20>=20+=20=20=20=20=20=20=20/*=
=0D=0A>=20>=20+=20=20=20=20=20=20=20=20*=20When=20BG_GC=20selects=20victims=
=20based=20on=20age,=20it=20prevents=20node=20victims=0D=0A>=20>=20+=20=20=
=20=20=20=20=20=20*=20from=20being=20selected.=20This=20is=20because=20node=
=20blocks=20can=20be=20invalidated=0D=0A>=20>=20+=20=20=20=20=20=20=20=20*=
=20by=20moving=20data=20blocks.=0D=0A>=20>=20+=20=20=20=20=20=20=20=20*/=0D=
=0A>=20>=20+=20=20=20=20=20=20=20if=20(__skip_node_gc(sbi,=20segno))=0D=0A>=
=20>=20+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20return=20UINT_MAX;=0D=
=0A>=20>=20+=0D=0A>=20>=20=20=20=20=20=20=20=20=20for=20(i=20=3D=200;=20i=
=20<=20usable_segs_per_sec;=20i++)=0D=0A>=20>=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20mtime=20+=3D=20get_seg_entry(sbi,=20start=20+=20i)->mt=
ime;=0D=0A>=20>=20=20=20=20=20=20=20=20=20vblocks=20=3D=20get_valid_blocks(=
sbi,=20segno,=20true);=0D=0A>=20>=20=40=40=20-369,10=20+377,24=20=40=40=20s=
tatic=20inline=20unsigned=20int=20get_gc_cost(struct=20f2fs_sb_info=20*sbi,=
=0D=0A>=20>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20return=20get_=
seg_entry(sbi,=20segno)->ckpt_valid_blocks;=0D=0A>=20>=0D=0A>=20>=20=20=20=
=20=20=20=20=20=20/*=20alloc_mode=20=3D=3D=20LFS=20*/=0D=0A>=20>=20-=20=20=
=20=20=20=20=20if=20(p->gc_mode=20=3D=3D=20GC_GREEDY)=0D=0A>=20>=20-=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20return=20get_valid_blocks(sbi,=20seg=
no,=20true);=0D=0A>=20>=20-=20=20=20=20=20=20=20else=20if=20(p->gc_mode=20=
=3D=3D=20GC_CB)=0D=0A>=20>=20+=20=20=20=20=20=20=20if=20(p->gc_mode=20=3D=
=3D=20GC_GREEDY)=20=7B=0D=0A>=20>=20+=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20/*=0D=0A>=20>=20+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20*=
=20If=20the=20data=20block=20that=20the=20node=20block=20pointed=20to=20is=
=20GCed,=0D=0A>=20>=20+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20*=20=
the=20node=20block=20is=20invalidated.=20For=20this=20reason,=20we=20add=20=
a=0D=0A>=20>=20+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20*=20weight=
=20to=20cost=20of=20node=20victims=20to=20give=20priority=20to=20data=0D=0A=
>=20>=20+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20*=20victims=20duri=
ng=20the=20gc=20process.=20However,=20in=20a=20situation=0D=0A>=20>=20+=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20*=20where=20we=20run=20out=20o=
f=20free=20sections,=20we=20remove=20the=20weight=0D=0A>=20>=20+=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20*=20because=20we=20need=20to=20clean=
=20up=20node=20blocks.=0D=0A>=20>=20+=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20*/=0D=0A>=20>=20+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20u=
nsigned=20int=20weight=20=3D=200;=0D=0A>=20>=20+=0D=0A>=20>=20+=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20if=20(__skip_node_gc(sbi,=20segno))=0D=0A>=
=20>=20+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20weight=20=3D=20BLKS_PER_SEC(sbi);=0D=0A>=20>=20+=0D=0A>=20>=20+=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20return=20get_valid_blocks(sbi,=20segno,=
=20true)=20+=20weight;=0D=0A>=20>=20+=20=20=20=20=20=20=20=7D=20else=20if=
=20(p->gc_mode=20=3D=3D=20GC_CB)=20=7B=0D=0A>=20>=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20return=20get_cb_cost(sbi,=20segno);=0D=0A>=20>=
=20+=20=20=20=20=20=20=20=7D=0D=0A>=20>=0D=0A>=20>=20=20=20=20=20=20=20=20=
=20f2fs_bug_on(sbi,=201);=0D=0A>=20>=20=20=20=20=20=20=20=20=20return=200;=
=0D=0A>=20>=20=40=40=20-557,6=20+579,14=20=40=40=20static=20void=20atgc_loo=
kup_victim(struct=20f2fs_sb_info=20*sbi,=0D=0A>=20>=20=20=20=20=20=20=20=20=
=20if=20(ve->mtime=20>=3D=20max_mtime=20=7C=7C=20ve->mtime=20<=20min_mtime)=
=0D=0A>=20>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20goto=20skip;=
=0D=0A>=20>=0D=0A>=20>=20+=20=20=20=20=20=20=20/*=0D=0A>=20>=20+=20=20=20=
=20=20=20=20=20*=20When=20BG_GC=20selects=20victims=20based=20on=20age,=20i=
t=20prevents=20node=20victims=0D=0A>=20>=20+=20=20=20=20=20=20=20=20*=20fro=
m=20being=20selected.=20This=20is=20because=20node=20blocks=20can=20be=20in=
validated=0D=0A>=20>=20+=20=20=20=20=20=20=20=20*=20by=20moving=20data=20bl=
ocks.=0D=0A>=20>=20+=20=20=20=20=20=20=20=20*/=0D=0A>=20>=20+=20=20=20=20=
=20=20=20if=20(__skip_node_gc(sbi,=20ve->segno))=0D=0A>=20>=20+=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20goto=20skip;=0D=0A>=20>=20+=0D=0A>=20>=20=
=20=20=20=20=20=20=20=20/*=20age=20=3D=2010000=20*=20x%=20*=2060=20*/=0D=0A=
>=20>=20=20=20=20=20=20=20=20=20age=20=3D=20div64_u64(accu=20*=20(max_mtime=
=20-=20ve->mtime),=20total_time)=20*=0D=0A>=20>=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20age_weight;=0D=0A>=20>=20=40=40=20-1827,8=20+1857,27=20=
=40=40=20int=20f2fs_gc(struct=20f2fs_sb_info=20*sbi,=20struct=20f2fs_gc_con=
trol=20*gc_control)=0D=0A>=20>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20goto=20stop;=0D=0A>=20>=20=20=20=20=20=20=20=20=20=7D=0D=0A>=20>=0D=
=0A>=20>=20+=20=20=20=20=20=20=20__get_secs_required(sbi,=20NULL,=20&upper_=
secs,=20NULL);=0D=0A>=20>=20+=0D=0A>=20>=20+=20=20=20=20=20=20=20/*=0D=0A>=
=20>=20+=20=20=20=20=20=20=20=20*=20Write=20checkpoint=20to=20reclaim=20pre=
free=20segments.=0D=0A>=20>=20+=20=20=20=20=20=20=20=20*=20We=20need=20more=
=20three=20extra=20sections=20for=20writer's=20data/node/dentry.=0D=0A>=20>=
=20+=20=20=20=20=20=20=20=20*/=0D=0A>=20>=20+=20=20=20=20=20=20=20if=20(fre=
e_sections(sbi)=20<=3D=20upper_secs=20+=20NR_GC_CHECKPOINT_SECS)=20=7B=0D=
=0A>=20>=20+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20sbi->require_node_=
gc=20=3D=20true;=0D=0A>=20>=20+=0D=0A>=20>=20+=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20if=20(prefree_segments(sbi))=20=7B=0D=0A>=20>=20+=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20stat_inc_cp_=
call_count(sbi,=20TOTAL_CALL);=0D=0A>=20>=20+=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20ret=20=3D=20f2fs_write_checkpoint(sb=
i,=20&cpc);=0D=0A>=20>=20+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20if=20(ret)=0D=0A>=20>=20+=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20goto=20st=
op;=0D=0A>=20>=20+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20/*=20Reset=20due=20to=20checkpoint=20*/=0D=0A>=20>=20+=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20sec_freed=20=3D=
=200;=0D=0A>=20>=20+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=7D=0D=0A>=
=20>=20+=20=20=20=20=20=20=20=7D=0D=0A>=20>=20+=0D=0A>=20>=20=20=20=20=20=
=20=20=20=20/*=20Let's=20run=20FG_GC,=20if=20we=20don't=20have=20enough=20s=
pace.=20*/=0D=0A>=20>=20-=20=20=20=20=20=20=20if=20(has_not_enough_free_sec=
s(sbi,=200,=200))=20=7B=0D=0A>=20>=20+=20=20=20=20=20=20=20if=20(gc_type=20=
=3D=3D=20BG_GC=20&&=20has_not_enough_free_secs(sbi,=200,=200))=20=7B=0D=0A>=
=20>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20gc_type=20=3D=20FG_G=
C;=0D=0A>=20>=0D=0A>=20>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
/*=0D=0A>=20>=20=40=40=20-1863,6=20+1912,18=20=40=40=20int=20f2fs_gc(struct=
=20f2fs_sb_info=20*sbi,=20struct=20f2fs_gc_control=20*gc_control)=0D=0A>=20=
>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20goto=20stop;=0D=0A>=20>=
=20=20=20=20=20=20=20=20=20=7D=0D=0A>=20>=0D=0A>=20>=20+=20=20=20=20=20=20=
=20if=20(sbi->require_node_gc=20&&=0D=0A>=20>=20+=20=20=20=20=20=20=20=20=
=20=20=20IS_DATASEG(get_seg_entry(sbi,=20segno)->type))=20=7B=0D=0A>=20>=20=
+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20/*=0D=0A>=20>=20+=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20*=20We=20need=20to=20clean=20node=20sec=
tions.=20but,=20data=20victim=0D=0A>=20>=20+=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20*=20cost=20is=20the=20lowest.=20If=20free=20sections=20ar=
e=20enough,=0D=0A>=20>=20+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20*=
=20stop=20cleaning=20node=20victim.=20If=20not,=20it=20goes=20on=0D=0A>=20>=
=20+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20*=20by=20GCing=20data=
=20victims.=0D=0A>=20>=20+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20*=
/=0D=0A>=20>=20+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20if=20(has_enou=
gh_free_secs(sbi,=20sec_freed,=200))=0D=0A>=20>=20+=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20goto=20stop;=0D=0A>=20>=20+=20=
=20=20=20=20=20=20=7D=0D=0A>=20>=20+=0D=0A>=20>=20=20=20=20=20=20=20=20=20s=
eg_freed=20=3D=20do_garbage_collect(sbi,=20segno,=20&gc_list,=20gc_type,=0D=
=0A>=20>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20gc_control->should_migrate_blocks);=0D=0A>=
=20>=20=20=20=20=20=20=20=20=20if=20(seg_freed=20<=200)=0D=0A>=20>=20=40=40=
=20-1882,7=20+1943,13=20=40=40=20int=20f2fs_gc(struct=20f2fs_sb_info=20*sbi=
,=20struct=20f2fs_gc_control=20*gc_control)=0D=0A>=20>=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20if=20(=21gc_control->=
no_bg_gc=20&&=0D=0A>=20>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20total_sec_freed=20<=20gc_control->nr_fr=
ee_secs)=0D=0A>=20>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20goto=20go_gc_more;=0D=0A>=20>=
=20-=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20go=
to=20stop;=0D=0A>=20>=20+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20/*=0D=0A>=20>=20+=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20*=20If=20require_node_gc=20flag=20is=20=
set=20even=20though=20there=0D=0A>=20>=20+=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20*=20are=20enough=20free=20sections,=
=20node=20cleaning=20will=0D=0A>=20>=20+=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20*=20continue.=0D=0A>=20>=20+=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20*/=0D=0A>=
=20>=20+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20if=20(=21sbi->require_node_gc)=0D=0A>=20>=20+=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20goto=20st=
op;=0D=0A>=20>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=7D=0D=0A>=
=20>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20if=20(sbi->skipped_g=
c_rwsem)=0D=0A>=20>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20skipped_round++;=0D=0A>=20>=20=40=40=20-1897,21=20+196=
4,6=20=40=40=20int=20f2fs_gc(struct=20f2fs_sb_info=20*sbi,=20struct=20f2fs_=
gc_control=20*gc_control)=0D=0A>=20>=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20goto=20stop;=0D=0A>=20>=20=20=20=20=20=20=20=20=20=7D=0D=0A>=20=
>=0D=0A>=20>=20-=20=20=20=20=20=20=20__get_secs_required(sbi,=20NULL,=20&up=
per_secs,=20NULL);=0D=0A>=20>=20-=0D=0A>=20>=20-=20=20=20=20=20=20=20/*=0D=
=0A>=20>=20-=20=20=20=20=20=20=20=20*=20Write=20checkpoint=20to=20reclaim=
=20prefree=20segments.=0D=0A>=20>=20-=20=20=20=20=20=20=20=20*=20We=20need=
=20more=20three=20extra=20sections=20for=20writer's=20data/node/dentry.=0D=
=0A>=20>=20-=20=20=20=20=20=20=20=20*/=0D=0A>=20>=20-=20=20=20=20=20=20=20i=
f=20(free_sections(sbi)=20<=3D=20upper_secs=20+=20NR_GC_CHECKPOINT_SECS=20&=
&=0D=0A>=20>=20-=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20prefree_segments(sbi))=20=7B=0D=0A>=20>=
=20-=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20stat_inc_cp_call_count(sbi=
,=20TOTAL_CALL);=0D=0A>=20>=20-=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20ret=20=3D=20f2fs_write_checkpoint(sbi,=20&cpc);=0D=0A>=20>=20-=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20if=20(ret)=0D=0A>=20>=20-=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20goto=20stop;=0D=0A=
>=20>=20-=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20/*=20Reset=20due=20to=
=20checkpoint=20*/=0D=0A>=20>=20-=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20sec_freed=20=3D=200;=0D=0A>=20>=20-=20=20=20=20=20=20=20=7D=0D=0A>=20>=
=20=20go_gc_more:=0D=0A>=20>=20=20=20=20=20=20=20=20=20segno=20=3D=20NULL_S=
EGNO;=0D=0A>=20>=20=20=20=20=20=20=20=20=20goto=20gc_more;=0D=0A>=20>=20=40=
=40=20-1920,8=20+1972,10=20=40=40=20int=20f2fs_gc(struct=20f2fs_sb_info=20*=
sbi,=20struct=20f2fs_gc_control=20*gc_control)=0D=0A>=20>=20=20=20=20=20=20=
=20=20=20SIT_I(sbi)->last_victim=5BALLOC_NEXT=5D=20=3D=200;=0D=0A>=20>=20=
=20=20=20=20=20=20=20=20SIT_I(sbi)->last_victim=5BFLUSH_DEVICE=5D=20=3D=20g=
c_control->victim_segno;=0D=0A>=20>=0D=0A>=20>=20-=20=20=20=20=20=20=20if=
=20(gc_type=20=3D=3D=20FG_GC)=0D=0A>=20>=20+=20=20=20=20=20=20=20if=20(gc_t=
ype=20=3D=3D=20FG_GC)=20=7B=0D=0A>=20>=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20f2fs_unpin_all_sections(sbi,=20true);=0D=0A>=20>=20+=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20sbi->require_node_gc=20=3D=20false;=
=0D=0A>=20>=20+=20=20=20=20=20=20=20=7D=0D=0A>=20>=0D=0A>=20>=20=20=20=20=
=20=20=20=20=20trace_f2fs_gc_end(sbi->sb,=20ret,=20total_freed,=20total_sec=
_freed,=0D=0A>=20>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20get_pages(sbi,=20F2FS_DIRTY_NODES=
),=0D=0A>=20>=20diff=20--git=20a/fs/f2fs/gc.h=20b/fs/f2fs/gc.h=0D=0A>=20>=
=20index=2028a00942802c..cd07bf125177=20100644=0D=0A>=20>=20---=20a/fs/f2fs=
/gc.h=0D=0A>=20>=20+++=20b/fs/f2fs/gc.h=0D=0A>=20>=20=40=40=20-166,3=20+166=
,9=20=40=40=20static=20inline=20bool=20has_enough_invalid_blocks(struct=20f=
2fs_sb_info=20*sbi)=0D=0A>=20>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20free_user_blocks(sbi)=20<=0D=0A>=20>=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20limit_free_user_blocks(invalid_us=
er_blocks));=0D=0A>=20>=20=20=7D=0D=0A>=20>=20+=0D=0A>=20>=20+static=20inli=
ne=20bool=20__skip_node_gc(struct=20f2fs_sb_info=20*sbi,=20unsigned=20int=
=20segno)=0D=0A>=20>=20+=7B=0D=0A>=20>=20+=20=20=20=20=20=20=20return=20(IS=
_NODESEG(get_seg_entry(sbi,=20segno)->type)=20&&=0D=0A>=20>=20+=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=21sbi->require_node_gc);=0D=0A>=20>=20+=
=7D=0D=0A>=20>=20--=0D=0A>=20>=202.34.1=0D=0A>=20>=0D=0A>=20>=0D=0A>=20>=0D=
=0A>=20>=20_______________________________________________=0D=0A>=20>=20Lin=
ux-f2fs-devel=20mailing=20list=0D=0A>=20>=20Linux-f2fs-devel=40lists.source=
forge.net=0D=0A>=20>=20https://lists.sourceforge.net/lists/listinfo/linux-f=
2fs-devel=0D=0A>=20


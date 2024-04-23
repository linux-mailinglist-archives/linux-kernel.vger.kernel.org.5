Return-Path: <linux-kernel+bounces-154477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E12CD8ADC72
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 05:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E6C31C21AA9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 03:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13561C694;
	Tue, 23 Apr 2024 03:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MJEQZ2Mc"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955311C2A3
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 03:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713844219; cv=none; b=JihcOtNdM2ngTXo+/AoAkoZ4y2juIhUqVyt7ETpToG/M/V/hKB7+Wp48xZRudG60WampXm6iuaQlDNVZDFFBbp2K34LHcFcKmxQ/IAVHfnMGlYJlO6+T3UKmCtOj9SBgcsgbIIGIYVIZ+4bblTaYk3bNOXYJhHpH+xG98wrsKbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713844219; c=relaxed/simple;
	bh=hSBb+AL3adDeMX5G+K8NhaTTSH2YI9539LvVI4k5pCA=;
	h=Mime-Version:Subject:From:To:CC:In-Reply-To:Message-ID:Date:
	 Content-Type:References; b=Rf3m5tE+2R7Wbdq7QkEQ25EJkVNJzfvLIfxh1N5hf2JqP7nkI5NadU1M0LxOLB0pILbbXhK6S4COzS9pt7/uOyaS/Io/eLpMGcEXv1Uy1YD6HSZNKxXUHr//1A6zAUahkAGV3YGpeL6Nfjvqhm88z87naSrzsvbuVHO9yRDTdJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=MJEQZ2Mc; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240423035014epoutp02153a0ffe855b6e59f2647b11f089b9a2~IzDt8clpA2283022830epoutp02_
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 03:50:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240423035014epoutp02153a0ffe855b6e59f2647b11f089b9a2~IzDt8clpA2283022830epoutp02_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1713844214;
	bh=hSBb+AL3adDeMX5G+K8NhaTTSH2YI9539LvVI4k5pCA=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=MJEQZ2McFmusiDyGFd7kMjvPPfBeCDFWA+j5ZVJ4IqZDkpQV6yRPlQTkFgyURCyIy
	 e2f4c0Y4P8TqbNel06yAPapuTblTGwopiTLM0qvSRvdbU6Y4euoPKlZFEhmoFG9qZA
	 +1nOycAojlga9gXd5jJXPt15mDsxwz5XEoNr9S/g=
Received: from epsmgec5p1new.samsung.com (unknown [182.195.42.68]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240423035013epcas5p2e3f1c0c2d7804cdb07dfba9894f4d2b5~IzDtfBXrd1772317723epcas5p2B;
	Tue, 23 Apr 2024 03:50:13 +0000 (GMT)
X-AuditID: b6c32a44-6c3ff70000002198-57-66272ff5813f
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	ED.1F.08600.5FF27266; Tue, 23 Apr 2024 12:50:13 +0900 (KST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH 1/1] mm: vmalloc: dump page owner info if page is
 already mapped
Reply-To: hariom1.p@samsung.com
Sender: Hariom Panthi <hariom1.p@samsung.com>
From: Hariom Panthi <hariom1.p@samsung.com>
To: Andrew Morton <akpm@linux-foundation.org>
CC: "urezki@gmail.com" <urezki@gmail.com>, "hch@infradead.org"
	<hch@infradead.org>, "lstoakes@gmail.com" <lstoakes@gmail.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Maninder Singh <maninder1.s@samsung.com>,
	Rohit Thapliyal <r.thapliyal@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20240422142835.3a2fe7740dfc3003b68de305@linux-foundation.org>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20240423035007epcms5p44dc3e16cb8477df9159642a857726a44@epcms5p4>
Date: Tue, 23 Apr 2024 09:20:07 +0530
X-CMS-MailID: 20240423035007epcms5p44dc3e16cb8477df9159642a857726a44
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCKsWRmVeSWpSXmKPExsWy7bCmlu5XffU0gyV35S3mrF/DZnF6wiIm
	i8u75rBZ3Fvzn9Xizrd57BaH57exWGy8l22x+iKLA4fHzll32T02r9Dy2PRpErvHiRm/WTz6
	tqxi9Pi8SS6ALYrLJiU1J7MstUjfLoErY0EzR8EO/orrx3axNjC+5Oti5OSQEDCRWHLkJlMX
	IxeHkMBuRokXD0+xdTFycPAKCEr83SEMUiMsECYxY/cfRhBbSEBeon3Da1aQEmEBXYl3u4tA
	TDYBbYnjn6xAKkSAoque72IGmcgscIRJYvmM4+wQq3glZrQ/ZYGwpSW2L98KNpJTwFvi6re1
	UDWiEjdXv4Wz3x+bzwhhi0i03jvLDGELSjz4uRsqLiPx+NVkVgi7XKJ/xR82CLuBUWLCXiMI
	21xi/ZJVYDN5BXwlZj76CVbDIqAqMWFKO1S9i8TThqlgM5mBflm28DUzyF/MApoS63fpQ5TI
	Skw9tY4JooRPovf3EyaYt3bMg7GVJeYe2QT1oqTEjvkdULaHxN+7IONBoXyUUeJf/zz2CYwK
	sxABPQvJ5lkImxcwMq9ilEwtKM5NT002LTDMSy3XK07MLS7NS9dLzs/dxAhOOFouOxhvzP+n
	d4iRiYPxEKMEB7OSCO+vPyppQrwpiZVVqUX58UWlOanFhxilOViUxHlft85NERJITyxJzU5N
	LUgtgskycXBKNTClG6lUaHQtNi46WzxL1nHDjNCS7TU3K1Zf4u3jithgtjihL2H69sY3vdqS
	Zx6ItuwWjUtrevZncTP7l2cikYmfXebVm86deugh2+qdsR3tO1iijgZnNi46KhLbdlDQoVTu
	TGo66/nS9TVb1BVtlrU3G7PJBG9xuehjdF6v44pR3ATZjbNuc+23v6T5WV8yZM3Tti/Jfvf/
	BZ6Y9nml4oefD7fLv9MQPmbQ8VH/1YP82+81+Q+Hv7E5EXjayy2XfZOSkuWl5J0Z8sdDM1ZY
	VUZ75k1OaBNN2JQ9zeHWlgn/Fdt4v9z++WTLN+f50aWlwSdlNos+r8lVvV8ZurmVQ+sgS/e7
	MPMXpt8PyvptslNiKc5INNRiLipOBADrXf74pwMAAA==
X-CMS-RootMailID: 20240419044047epcas5p4a90ca734d73bc9a87cd1670beaa24d8e
References: <20240422142835.3a2fe7740dfc3003b68de305@linux-foundation.org>
	<20240419043910.2156379-1-hariom1.p@samsung.com>
	<CGME20240419044047epcas5p4a90ca734d73bc9a87cd1670beaa24d8e@epcms5p4>

Hi,

> > ...
> >
> > =40=40 -103,7 +105,13 =40=40 static int vmap_pte_range(pmd_t *pmd, unsi=
gned long addr, unsigned long end,
> >=C2=A0=20=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0if=20(=21pte)=0D=0A>=20>=C2=
=A0=20=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0return=20-ENOMEM;=0D=0A>=20>=C2=A0=20=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0do=20=7B=0D=0A>=20>=20-=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0BUG_ON(=21pte_none(ptep_get(pte)));=0D=0A>=20>=20+=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0if=
=20(=21pte_none(ptep_get(pte)))=20=7B=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0if=20(pfn_valid(pfn))=20=7B=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0page=20=3D=20pfn_to_page(pf=
n);=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0dump_page_owner(page);=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=7D=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0BUG();=0D=0A>=
=20>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=7D=0D=0A>=20=0D=0A>=20Diving=20straight=20into=20dump_page_owner()=
=20seems=20inappropriate.=C2=A0=20The=0D=0A>=20higher-level=20dump_page()=
=20interface=20is=20more=20typically=20used.=0D=0A>=20=0D=0A>=20Or,=20even=
=20more=20common,=20VM_BUG_ON_PAGE(),=20but=20that=20doesn't=20look=20to=20=
be=20a=0D=0A>=20good=20fit=20here.=0D=0A=0D=0AOk=20I=20will=20send=20V2=20w=
ith=20dump_page=20API.=0D=0A=0D=0AThanks,=0D=0AHariom=20=0D=0A


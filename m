Return-Path: <linux-kernel+bounces-19033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0598266FE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 01:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33A78281B2A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 00:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3905A10EB;
	Mon,  8 Jan 2024 00:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ajwspY1f"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B3C7F0
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 00:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240108005121epoutp045acc1a82e1234d2921c24ccba1cfb5fc~oOPSK4gfY0236902369epoutp04V
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 00:51:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240108005121epoutp045acc1a82e1234d2921c24ccba1cfb5fc~oOPSK4gfY0236902369epoutp04V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1704675081;
	bh=NnRmXsDz2gF/fLLQZQSELuftp/jZ/1wr6LoLk/2xhhc=;
	h=From:To:In-Reply-To:Subject:Date:References:From;
	b=ajwspY1fUe1fvrAcYATD+eMjI0Dw0qfz2zrIivlVFz6mbgeGHX40KSqbmxL/lRpdw
	 pZpHxkBqx4KR8JVgT8xLpmxQ+i1dSSfXE+LHPDEC8DB+QX95rVIujcO//4xZYfKU+j
	 OKDAW/mAIu0wv2fZkm8emnwSSs2w/gQ/G2BTfqIY=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTP id
	20240108005121epcas2p4c5a6e1e93312268ece2c61c9ef4fc77e~oOPRemT5i0047200472epcas2p4W;
	Mon,  8 Jan 2024 00:51:21 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.89]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4T7b943N3bz4x9Q3; Mon,  8 Jan
	2024 00:51:20 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
	epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	D4.39.09622.8074B956; Mon,  8 Jan 2024 09:51:20 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
	20240108005119epcas2p38d86c4dc9577b05b54cbd4965bea14fd~oOPQV2sV51147911479epcas2p3j;
	Mon,  8 Jan 2024 00:51:19 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240108005119epsmtrp232ba25b05a407ba1391352de53c095fd~oOPQVEOsI1627216272epsmtrp2H;
	Mon,  8 Jan 2024 00:51:19 +0000 (GMT)
X-AuditID: b6c32a46-d61ff70000002596-2b-659b47081a8f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	C4.B0.08755.7074B956; Mon,  8 Jan 2024 09:51:19 +0900 (KST)
Received: from KORCO011456 (unknown [10.229.38.105]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20240108005119epsmtip19a836120889261644d1905a6c21caddf~oOPQGZVHe0816208162epsmtip15;
	Mon,  8 Jan 2024 00:51:19 +0000 (GMT)
From: "Kiwoong Kim" <kwmad.kim@samsung.com>
To: "'Bart Van Assche'" <bvanassche@acm.org>, <linux-scsi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <alim.akhtar@samsung.com>,
	<avri.altman@wdc.com>, <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
	<beanhuo@micron.com>, <adrian.hunter@intel.com>, <h10.kim@samsung.com>,
	<hy50.seo@samsung.com>, <sh425.lee@samsung.com>, <kwangwon.min@samsung.com>,
	<junwoo80.lee@samsung.com>, <wkon.kim@samsung.com>
In-Reply-To: <65dead0b-34a5-4e29-83ec-c26e556f262a@acm.org>
Subject: RE: [PATCH v1] ufs: get target SQ entry within critical section
Date: Mon, 8 Jan 2024 09:51:19 +0900
Message-ID: <001501da41cc$cb1fbe80$615f3b80$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGjKnJSW6mFTQ0gfnvbL4w9CrB5iwLKIUEhAXEayZmxG2puEA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta0xTZxjO13M4nJp0HEonn7g4OCwu3NtyO2zALhA4GUpqiAsb27ChB8ro
	LT3FiNkPNjaoSkZ1E9fq5NLgUGAkFUgpw3FxoiMzk0uohYhMcMEh4WJUNMX10Lrx7/m+93ne
	93m+C44IR7EQvFRjYPQauYrEdqA9wxFUDJ59lhG323ZSN+bbMeru+R6MWtyYxKjBuWMoVb+y
	gVDu6Vt+VJv1Lko1O3t4lMNdxaO6nb0oNe44h1EnpuwY9dPIJo9q2XyIUpfHHqPvBtDjEzm0
	9ZdFHm1qHgD0k04jRq8uuFD6265LgF637aFrBk7wZPjHZalKRq5g9KGMpkirKNWUpJE5eYUZ
	hYlJYkmMJIVKJkM1cjWTRmbuk8Vklao85snQw3JVuWdLJmdZMi49Va8tNzChSi1rSCMZnUKl
	S9bFsnI1W64pidUwhrckYrE00UM8VKY0PsnTLeFHavv+xCqBw/844OOQSIB9tX+jHBYSdgDX
	LvKPgx0evAZg2/g68C4eA+hankJfKszdnIIr9ANY1WnGvItFAG+ONgCOhRFRsH6uz48riAgr
	AmfHfvDjCnzibdg33oZxOIig4dLcI48RHEeJN+DqH0IOCogUaG4q5hgCIhDeMM9vDUY8LS80
	/YN4TYTCjYULWx1FxPuw9XQb8HJE8OyxaoQbCwknDk0dVp8gE3atWoAXB8EHI12+/CFwfbkf
	82IWdtgneV5xpSf/g1EfKR5a7tcAzhxCRMBORxwHIREOr7p83l6BxmG3v3dbAI3VQq8wHD47
	9Z1v6i5ovj3ja0jD/qUZzATCLNtSWraltGxLY/l/biNAL4GdjI5VlzCsVCf976qLtGob2HrV
	kVl28P3DldghwMPBEIA4QooEausZRihQyCuOMnptob5cxbBDINFz6ieRkFeLtJ5voTEUShJS
	xAlJSZJkaaI4mQwW3PnmR4WQKJEbmDKG0TH6lzoezg+p5HUX+33mXAxu4M/MnrxuqhMpkMvL
	mTcX/pK94w6uMEdTpQd3j2QfmHVHXKQLXkSf2RXV2PVzqzNAVLN5a1/vlbGA38cFn+BpUvpg
	Vkth0Ifr1dfiF+LPP5uMmk5fa3LJXut/uieMfC/PWDeVLW2P+2gzxXr9dZMxPj9/9FBCxlfh
	9eiq9n7yYOQdvCDnSFjjxHDYYf9Pi6j2qt82Z8Nbec8LUlQrtv3P87+oi16qHLhnu9d8NCv3
	8yDFvIG9HTEx+2ivMez0VUltgyu29UX96IHga6g0tbS2+IqWDawYzLUPOnJH0ht3x/+KfVDd
	a59uUT41Wc/xozsm35SSp762fZmRGkiirFIuiUT0rPxfKgBo9V4EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFIsWRmVeSWpSXmKPExsWy7bCSnC67++xUg7cTTSxOPlnDZvFg3jY2
	i5c/r7JZHHzYyWIx7cNPZou/ty+yWqxe/IDFYtGNbUwWu/42M1lsvbGTxeLyrjlsFt3Xd7BZ
	LD/+j8li6b+3LBabL31jceD3uHzF22PxnpdMHhMWHWD0+L6+g83j49NbLB59W1YxenzeJOfR
	fqCbKYAjissmJTUnsyy1SN8ugStj86mYgm0cFT1L5rE3MP5h62Lk5JAQMJGYufU5SxcjF4eQ
	wG5GiV3HT7FCJCQlTux8zghhC0vcbzkCFhcSeM4osXNVKojNJqAtMe3hblaQZhGBrcwSZw5u
	ZoQoOs4osfeVPojNKWAtsfvyarBtwgIeEm8efmHvYuTgYBFQkfh4VgjE5BWwlJi5MA2kgldA
	UOLkzCcsIDYz0Pjeh62MMPayha+ZIc5RkPj5dBnYOSICThIrpq6GqhGRmN3ZxjyBUWgWklGz
	kIyahWTULCQtCxhZVjFKphYU56bnFhsWGOallusVJ+YWl+al6yXn525iBEenluYOxu2rPugd
	YmTiYDzEKMHBrCTCm7t4eqoQb0piZVVqUX58UWlOavEhRmkOFiVxXvEXvSlCAumJJanZqakF
	qUUwWSYOTqkGpjKn4OmGJXFRTufMlzXqxmzKiY3ySG3aX35VYGLGyanSj6bPvxlt/u3R1Q0W
	eUpMBksbZ8pMeCjSdjjtoOyGSS9+vxIxmixT6cr9RNKEK27KBU3NEwtWa0lr8a++Xv5xgdW2
	MGXja+rfbZY4bptv2id76ee5RYV81/84zdm7ckZD30yjP7wMKQm/P/+/qvSV84+aiPM8zfJl
	WZcermCV4zhdcMz47bw0By7mh5mpG8wvzkqwMNphKLHhw7aCQu+3uxiPh4k8sV27gr+67mD/
	NYf2Z2s2PAs3vPq2nNNKO12+7cVCwbfszNvqu25YH9pnusDn6cTqb/yRsh9fZZ5601/vUeYa
	y6SVzTmZ7erS40osxRmJhlrMRcWJAA9eE9Q9AwAA
X-CMS-MailID: 20240108005119epcas2p38d86c4dc9577b05b54cbd4965bea14fd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240104012454epcas2p36b58220b4c89ee72f1e095b34d329be2
References: <CGME20240104012454epcas2p36b58220b4c89ee72f1e095b34d329be2@epcas2p3.samsung.com>
	<1704331491-115325-1-git-send-email-kwmad.kim@samsung.com>
	<65dead0b-34a5-4e29-83ec-c26e556f262a@acm.org>

> > diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> > index 7bc3fc4..da1a9c0 100644
> > --- a/drivers/ufs/core/ufshcd.c
> > +++ b/drivers/ufs/core/ufshcd.c
> > =40=40 -2199,9 +2199,10 =40=40 void ufshcd_send_command(struct ufs_hba =
*hba,
> unsigned int task_tag,
> >   	if (is_mcq_enabled(hba)) =7B
> >   		int utrd_size =3D sizeof(struct utp_transfer_req_desc);
> >   		struct utp_transfer_req_desc *src =3D lrbp->utr_descriptor_ptr;
> > -		struct utp_transfer_req_desc *dest =3D hwq->sqe_base_addr +
> hwq->sq_tail_slot;
> > +		struct utp_transfer_req_desc *dest;
> >
> >   		spin_lock(&hwq->sq_lock);
> > +		dest =3D hwq->sqe_base_addr + hwq->sq_tail_slot;
> >   		memcpy(dest, src, utrd_size);
> >   		ufshcd_inc_sq_tail(hwq);
> >   		spin_unlock(&hwq->sq_lock);
>=20
> Is this perhaps a duplicate of patch =22scsi: ufs: core: Let the sq_lock
> protect sq_tail_slot access=22? See also https://lore.kernel.org/linux-
> scsi/1702913550-20631-1-git-send-email-quic_cang=40quicinc.com/=23t

I didn=E2=80=99t=20see=20it.=20Thank=20you=20for=20letting=20me=20know.=0D=
=0A=0D=0A=0D=0A


Return-Path: <linux-kernel+bounces-66089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23602855679
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 23:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 488111C2317C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 22:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BDB128378;
	Wed, 14 Feb 2024 22:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mR5/mFSE"
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BAF2E629;
	Wed, 14 Feb 2024 22:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.189.100.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707951583; cv=none; b=h7GtUY890sVMDsMZWFLVYqGL7J+7ir2i5pKqQBJg72kCI98NiC7cagy9k7gEZuO6u8o0mqkk7I0lJwxT5CQUqkU4KA1MRhwuDi24CzCliLQgF+6/u2ZKLVgdfWxenmnWIzExRLD3dHOdgZE0tmL4RPrbiBWajvOj+yKYe6zdO+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707951583; c=relaxed/simple;
	bh=2ROaEgqkwNNPiQW7EVRrBqCtC40xE0B+dzq3++mYJCQ=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:
	 References; b=avtfos/w0k4mpYZ+/VkNkxZWfzTCnbzPD7iJ6XgJ42d1KOzYrCLnUZftFEriCLPNllcGHw1s+OkaSSgIrtDfgIpuwUyaLPLx1S+D0GcINFiHBJfMWZnWBKlUgVX4YbGuUBu0g7jV27GnIRWMQSVhjyaC00Qy1hXByF+JD+ydOh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=mR5/mFSE; arc=none smtp.client-ip=211.189.100.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
	by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20240214225939usoutp015a2256c4791d245d2f57aaa6751c393c~z3OmPAL2b0141401414usoutp01I;
	Wed, 14 Feb 2024 22:59:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20240214225939usoutp015a2256c4791d245d2f57aaa6751c393c~z3OmPAL2b0141401414usoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1707951579;
	bh=2ROaEgqkwNNPiQW7EVRrBqCtC40xE0B+dzq3++mYJCQ=;
	h=From:To:Subject:Date:References:From;
	b=mR5/mFSEceW96BS9Zp8ZR6PYaw/xKiJshbmMRW/macZguAGiT6lcOZ1N1XklqKPV3
	 SgbEQysIqowDnkqN3yIU1r3PlANGUS44qm6Thpk3bMxhZNmMgPgm7NSk3xlWWgXTPV
	 je9y9BYzTTo5qx24HiGoMMnf0BdRCoiD2CtTRTmM=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
	[203.254.195.111]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240214225939uscas1p16b00de43837bdb8bd991be2655ac99e2~z3OmBfUa10931409314uscas1p1t;
	Wed, 14 Feb 2024 22:59:39 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
	ussmges2new.samsung.com (USCPEMTA) with SMTP id AB.80.09760.BD54DC56; Wed,
	14 Feb 2024 17:59:39 -0500 (EST)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
	[203.254.195.89]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240214225938uscas1p28fc1f193d68b26b0e3b6e0e6da4574eb~z3OldINr42193821938uscas1p2Z;
	Wed, 14 Feb 2024 22:59:38 +0000 (GMT)
X-AuditID: cbfec36f-7f9ff70000002620-17-65cd45dba205
Received: from SSI-EX1.ssi.samsung.com ( [105.128.3.67]) by
	ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id 81.F3.50167.AD54DC56; Wed,
	14 Feb 2024 17:59:38 -0500 (EST)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
	SSI-EX1.ssi.samsung.com (105.128.2.226) with Microsoft SMTP Server
	(version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
	15.1.2375.24; Wed, 14 Feb 2024 14:59:37 -0800
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
	SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Wed,
	14 Feb 2024 14:59:37 -0800
From: Jim Harris <jim.harris@samsung.com>
To: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Kees Cook <keescook@chromium.org>, "Gustavo A.
 R. Silva" <gustavoars@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-hardening@vger.kernel.org"
	<linux-hardening@vger.kernel.org>, Leon Romanovsky <leonro@nvidia.com>,
	"Jason Gunthorpe" <jgg@nvidia.com>, Alex Williamson
	<alex.williamson@redhat.com>, "pierre.cregut@orange.com"
	<pierre.cregut@orange.com>
Subject: [PATCH v3 0/2] PCI/IOV: sriov_numvfs bug fixes
Thread-Topic: [PATCH v3 0/2] PCI/IOV: sriov_numvfs bug fixes
Thread-Index: AQHaX5l7eXJDO8TLJEqs+FrXTi3ZpQ==
Date: Wed, 14 Feb 2024 22:59:37 +0000
Message-ID: <170795147587.2393.15577527626926144858.stgit@bgt-140510-bm01.eng.stellus.in>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-ID: <E73177EA56B5054CA153BA47190B29DD@ssi.samsung.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOKsWRmVeSWpSXmKPExsWy7djX87q3Xc+mGiy4z2bx7X8Pm8XdxxfY
	LKZPvcBoceJmI5vF6ptrGC1+XZzGarH/6XMWiyv/9jBarFp4jc3iTHeuxaYNT1gszs86xWIx
	b/1PRovLu+awWaz/+p7N4taEY0wOAh6zGy6yeLQcecvqsXjPSyaPTas62Tx6m9+xebQ8O8nm
	8X7fVTaPqbPrPT5vkgvgjOKySUnNySxLLdK3S+DKmHR+JUvBM46Kkw96GBsYT3B0MXJySAiY
	SHy+O521i5GLQ0hgJaPEo6vPmSCcViaJm0s+McNUdTS8YYRIrGGUeHpiEVTLJ0aJNfNesEE4
	yxgl3vQ1sYK0sAloSvy6sgZslojAR1aJvh1T2LsYOTiEBcwlPvyPB6kREbCReDRxGyuErSfR
	9W4/I4jNIqAqcfXsLzCbVyBS4uHme2A2o4CYxPdTIDM5OZgFxCVuPZnPBHGeoMSi2XugThWT
	+LfrIRuErShx//tLsLXMQPes36UP0WoncXfjHHYIW1FiSvdDdohVghInZz5hgWiVlDi44gYL
	yPkSApM5JTZPOc8KMkdCwEXi6jQviBppiavXp0KtzZZYub6DCaKkQKLhSBBE2Fpi4Z/1UBfz
	Sfz99YgRooRXoqNNaAKj0iwkv8xCuHMWkjtnIblzFpI7FzCyrmIULy0uzk1PLTbKSy3XK07M
	LS7NS9dLzs/dxAhMi6f/Hc7fwXj91ke9Q4xMHIyHGCU4mJVEeCf1nkkV4k1JrKxKLcqPLyrN
	SS0+xCjNwaIkzmtoezJZSCA9sSQ1OzW1ILUIJsvEwSnVwDT17w2HlKmep1TWxHE0lwo9W6kv
	1eCnts3e+kLKQYnT6X+zeH/Ubk5V8PjRKqWYOCEieE7UsiaeqTqfmstlV8zKCd1p7ixYUXQh
	ehFzpszZlkf6JSuepSvu33a3839n8olDG5Te1G2Z8WhuV2KYT/7a+CtiSRvnRri3qlpsm8i5
	eJGaRbRj6mL1+SriUwrury9Vs1Z+k8q19XqSyM6lHld/bI9ePFPB7sHeDbOUf0+20IpcsDoi
	4sklkeezjq/nXXlUVzn8Zbf+dN/rCuYvrwk2hNT0+8veV+7aeWqT2FrN77bzpIJu/1ssZRrV
	36kptueo7da5hQHfV5p4zJngM+XJ/3tTsx3PTue//OBw+jslluKMREMt5qLiRACKE6yx+gMA
	AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMIsWRmVeSWpSXmKPExsWS2cDsrHvL9WyqwdOPkhbf/vewWdx9fIHN
	YvrUC4wWJ242slmsvrmG0eLXxWmsFvufPmexuPJvD6PFqoXX2CzOdOdabNrwhMXi/KxTLBbz
	1v9ktLi8aw6bxfqv79ksbk04xuQg4DG74SKLR8uRt6wei/e8ZPLYtKqTzaO3+R2bR8uzk2we
	7/ddZfOYOrve4/MmuQDOKC6blNSczLLUIn27BK6MSedXshQ846g4+aCHsYHxBEcXIyeHhICJ
	REfDG8YuRi4OIYFVjBJ9p9+yQjifGCVOzutignCWATmXtjCDtLAJaEr8urIGLCEi8JFV4vOD
	qexdjBwcwgLmEh/+x4PUiAjYSDyauI0VwtaT6Hq3nxHEZhFQlbh69heYzSsQKfFw8z0wm1FA
	TOL7KZCZnBzMAuISt57MZ4I4T0BiyZ7zzBC2qMTLx/9YIWxFifvfX4KtZQa6Z/0ufYhWO4m7
	G+ewQ9iKElO6H7JDrBKUODnzCQtEq6TEwRU3WCYwis5Csm0WwqRZSCbNQjJpFpJJCxhZVzGK
	lxYX56ZXFBvmpZbrFSfmFpfmpesl5+duYgSmg9P/DkfuYDx666PeIUYmDsZDjBIczEoivJN6
	z6QK8aYkVlalFuXHF5XmpBYfYpTmYFES5737QCNVSCA9sSQ1OzW1ILUIJsvEwSnVwLQib9JK
	/99F4htjXHddOKKpzfrZyjptnry/BIewRP0kc2meA+0uHmG12w7GXDpQfHdJ9fQMNwmlpppD
	shzWh9f/rz5dGFzlsLNxmXrLs2u59ZFXnuhGBvQsse6f8PWBcHDFHp7VK54X767w+XnlkIhQ
	+REGzvdZ4vu7HmilRFSW++ccUHhxeW2WwtWPh0/vsIjS2pUy7eqnzAVml33CHzid7XxyeZ7J
	/sCGD3s87RM0/kvxJTG/smLVOPLt9Lf/v/2ty+bd2/xEQ14w8Mjs5v1/+j9cU2z99lV3Y+vy
	xTkS+v23L79s7n5vGiAzraVV48ilt2fXKLf/venubfLzw9spHxc51c+1k3x7t2dat68SS3FG
	oqEWc1FxIgBImar0dgMAAA==
X-CMS-MailID: 20240214225938uscas1p28fc1f193d68b26b0e3b6e0e6da4574eb
CMS-TYPE: 301P
X-CMS-RootMailID: 20240214225938uscas1p28fc1f193d68b26b0e3b6e0e6da4574eb
References: <CGME20240214225938uscas1p28fc1f193d68b26b0e3b6e0e6da4574eb@uscas1p2.samsung.com>

QSBkZWFkbG9jayBjb25kaXRpb24gd2FzIGRpc2NvdmVyZWQgYnkgU1BESyB3aGVuIHJlbW92aW5n
IGFuIFNSSU9WLWVuYWJsZWQgYW5kClZGSU8tYXR0YWNoZWQgZGV2aWNlLCB3aXRoIGEgc3BlY2lm
aWMgdGhyZWFkaW5nIG1vZGVsLiBXaGlsZSBkaXNjdXNzaW5nIHRoaXMKb24gdGhlIG1haWxpbmcg
bGlzdCwgYSBzZXBhcmF0ZSBpc3N1ZSBhcm91bmQgdXBkYXRpbmcgc3Jpb3ZfbnVtdmZzIGFuZCBp
dHMKa29iamVjdF91ZXZlbnQoKSB3YXMgYWxzbyBkaXNjb3ZlcmVkLiBUaGlzIHNlcmllcyBmaXhl
cyBib3RoIG9mIHRob3NlIGlzc3Vlcy4KCi0tLQp2MSA9PiB2MjoKKiBObyBjb2RlIGNoYW5nZXMK
KiBVcGRhdGVkIGNvbW1pdCBtZXNzYWdlcyBwZXIgZmVlZGJhY2sgZnJvbSBCam9ybgoqIEFkZGVk
IExlb24ncyBSZXZpZXdlZC1ieSB0YWdzCiogTW92ZWQgYnVsayBvZiB0aGUgdjEgY292ZXIgbGV0
dGVyIHRvIHRoZSByZXZlcnQgcGF0Y2ggY29tbWl0IG1lc3NhZ2Ugd2hlcmUKICBpdCBiZWxvbmdl
ZAoKdjIgPT4gdjM6CiogVXBkYXRlIGlvdi0+bnVtX1ZGcyBiZWZvcmUgVkZzIGFyZSBwcm9iZWQK
Ci0tLQoKSmltIEhhcnJpcyAoMik6CiAgICAgIFBDSS9JT1Y6IFJldmVydCAiUENJL0lPVjogU2Vy
aWFsaXplIHN5c2ZzIHNyaW92X251bXZmcyByZWFkcyB2cyB3cml0ZXMiCiAgICAgIFBDSS9JT1Y6
IHNldCBpb3YtPm51bV9WRnMgYmVmb3JlIFZGcyBhcmUgcHJvYmVkCgoKIGRyaXZlcnMvcGNpL2lv
di5jIHwgICAxNCArKysrKy0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygr
KSwgOSBkZWxldGlvbnMoLSkKCi0tCg==


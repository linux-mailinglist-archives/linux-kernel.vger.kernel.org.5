Return-Path: <linux-kernel+bounces-58209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBCC84E2C2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 482CC1F290BE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3172D79923;
	Thu,  8 Feb 2024 14:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="b4667edO"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD19178696
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 14:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707400976; cv=none; b=r72frv9NEfJdLfBM2wefFjm2gx1RYoerLcu7rPm7vcKiAE9QJjenvWA6jCTHd23zk7yYGqKEQMIHsf/S/hszCMs1akplTtlOdHrVNTPDzUsSuBWhzgDyOL5EZS+b/ODIQedfLw7CCQgwC2UvzQhOk8U9LTY1enSU8O8YiMenL/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707400976; c=relaxed/simple;
	bh=kEceGURTSCLX1LnHfzyT42pz7RXLd+AthgwrbZcGAGQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version:References; b=a953a4KK1wupbER1C8+agbypEqiNeQoNz6CcxH8jBfh45y9YZkrbJcnADMeDhQUO1Sq04kGUYhn+Tg4B4CxSZsfJvHhtnqAKl0+DdlJvQQgkAmwT56vvNrhJn/yvfmTpATd/Wk/WBJp9NxTjX8V5nk2Fsk7F/EILcsjSiVq/eGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=b4667edO; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240208140245euoutp02f9a2a91d7312ef972ee4828ecefb8d21~x6CHYxETJ3141231412euoutp02S
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 14:02:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240208140245euoutp02f9a2a91d7312ef972ee4828ecefb8d21~x6CHYxETJ3141231412euoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1707400965;
	bh=kEceGURTSCLX1LnHfzyT42pz7RXLd+AthgwrbZcGAGQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=b4667edOsAP6VVgelN+jEIx5AoXUUpyUMNGD89kol2ShCgaRqdm/4HQ2GoRWERwwe
	 fSUih/K0WgZHVNCRkmOk7lx+c69NSZKECAf9+m6EuoFXXcgEWM9F0Z6/heGdoKJUbg
	 yunDXY1oi0KXwCA4vqlPZfwalAvupd8q1UrNq/T0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240208140245eucas1p125409710592f469f6554eff90efb96aa~x6CG4gXAp0794807948eucas1p1k;
	Thu,  8 Feb 2024 14:02:45 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 5E.62.09539.50FD4C56; Thu,  8
	Feb 2024 14:02:45 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240208140244eucas1p1308da6aac688043b2064e91a5e38b34e~x6CGZ4mGq0581005810eucas1p1n;
	Thu,  8 Feb 2024 14:02:44 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240208140244eusmtrp1a05a67bc02bd29117a0f6de2f9c2d4ea~x6CGYIzDj3025730257eusmtrp1Q;
	Thu,  8 Feb 2024 14:02:44 +0000 (GMT)
X-AuditID: cbfec7f2-52bff70000002543-7a-65c4df053775
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 04.DC.10702.40FD4C56; Thu,  8
	Feb 2024 14:02:44 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240208140244eusmtip129c48709c307eee724c0c1e6de2a9a6c~x6CGManwp3240532405eusmtip16;
	Thu,  8 Feb 2024 14:02:44 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) by
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) with Microsoft SMTP
	Server (TLS) id 15.0.1497.2; Thu, 8 Feb 2024 14:02:43 +0000
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
	([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Thu, 8 Feb
	2024 14:02:43 +0000
From: Andreas Hindborg <a.hindborg@samsung.com>
To: Alice Ryhl <aliceryhl@google.com>
CC: Trevor Gross <tmgross@umich.edu>, Miguel Ojeda <ojeda@kernel.org>, "Alex
 Gaynor" <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJuIFJveSBCYXJvbg==?= <bjorn3_gh@protonmail.com>, Benno
	Lossin <benno.lossin@proton.me>, Kees Cook <keescook@chromium.org>, Al Viro
	<viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>,
	=?utf-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, Todd Kjos
	<tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes
	<joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, "Suren
 Baghdasaryan" <surenb@google.com>, Arnd Bergmann <arnd@arndb.de>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "rust-for-linux@vger.kernel.org"
	<rust-for-linux@vger.kernel.org>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH 3/3] rust: add abstraction for `struct page`
Thread-Topic: [PATCH 3/3] rust: add abstraction for `struct page`
Thread-Index: AQHaVNQ8VXQbcxmBfkinu8UJuZg2mrEAgLOAgAAEAwA=
Date: Thu, 8 Feb 2024 14:02:43 +0000
Message-ID: <87v86zrr45.fsf@samsung.com>
In-Reply-To: <CAH5fLgi_iU3nDE-gJ56s8CPznWvC0T4P5M0dVx1zO61kmVGNgQ@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="utf-8"
Content-ID: <657A913530B0754F8DBFB2EBCA6CB2FE@scsc.local>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0xTZxje19NzoUpyWpR+somjG8t0jMsk89slTsmWnMRlQrIbu6hdOcEG
	WlkPBWbcVjGjgqyr2G1SLkVEsVhSUmtxTFErs8WCDDCFmSG6NVMoBmxxc2WwjZ5d+Pe87/u8
	z/O8Xz4Kk5wiEiilupjVqOWFMkIkdF3+feBpfLyHTW+8JkL1dhuB5us6SeQdKRei+ZrLJJqe
	HyfQjL8cR6Pfn8eQzblXgIKXQgDNXhgi0WBfEKB9R+0EOq5LRn0HVGi4q55AN2x/4shl0+HI
	amkFyP7LJQwdGmoiUJM/QqJ+1xUSDcx7cNRxvB1sgozrWxfOzEVqAFOnGxQyLZURAfONeYxk
	mhxa5kjoPs442ioJxhGqIRnv4Tkhc77BRjK/6c8STHWFQ8Dc9RpwJuxIZByBu4Js+h3Ri3ls
	obKE1aRt3CHaeVXvI4pMVNnsCT2mAw/IKhBDQToTNo79SlQBESWhTwDoH7lD8sUsgDM/WvBF
	loQOA9j51RNVgIpu3Duyjue0AmiwLeB8scgx2ABf+AAcHPAI/9Md9C5gi1IEnQb9Nn8Ur6CT
	Yd91XdQcowMkPGg9Fk0VR2+C/olrQp60GXYYhggePw+nQ5bospB+HDrN1dF8sfST0Nc2EuXE
	0DmwI7wv2gf0aviTNRLVxGgpvB6wCPirxbC57izG43i40HWL4HEK7B8JAB6nw9PHuoU8ToL+
	6h/A4v0YvRbau9J4yedg+GYE8DgJmg7cIvk4YthbG/hn9fAy2H3uBf7pXoaj/jS+HQcnPU7S
	CFLMS8KZ/zcwLzEwLzEwLzFoAngbkLJaTpXPchlqtjSVk6s4rTo/VbFL5QB//2vfgid0BjRM
	3kt1AwEF3ABSmGxF7OstPawkNk/+0W5Ws2u7RlvIcm7wMCWUSWOT89awEjpfXswWsGwRq/l3
	KqBiEnSC5kruETerBPajiSdhOWmwrjVOKRRu7+fSSW5oQ837n752UoKxr4zs/fJm/JWpYUpp
	mlKNBhOz1F/cOZe9Pv2qdL1zi+uz08uX7X+pseyP9zZsnfr5qbmulRK/O9v0IdDqWj54SLzj
	/qr94kBKBW61JuVZ+08VnTH2ZvgCD4LOiUlT2Fir31rxxtsbLdxbjVlbmsty3kxvvZjgqZzZ
	k5CfOTbdsW14YuHjbTmMs0fpre/vXLl9zWPdF0pur2oo2FNgMYzry3o/MU4abvt2l7KeZy52
	H2rJLv1axr767rPe3Bura32KRrO8JDMlqzhzpq9Z0S5rt8eLlj+amxusi9v8XbdYJuR2yjPW
	YRpO/hcnBtPERgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTVxzHc+69vfeCwVwe4oE4nI0swFhLee2UMOJmMu+cIXNZzTZGoOIN
	OGmLLZ3MzKXDKbM8ouAeVOQxQR4pFpva8RBUMIgrykvLwCETGBkjjAHdpsXqoJdl/Pf9nXw/
	v9/5/nIOjft0kIH0QWU2p1bKM4WkJ2F7dmvsFWL8JhexVBuCykxGErnO/UChnuFcArmKuyk0
	7xon0Z/2XAH6qf8ajoyWLzA027UIkOP6IIUGemcBOn7BRKKLumDUm69AQ61lJHpofC5AVqNO
	gOoragEyTXfhqGSwkkSVdieF7lh/pFCf65YANV1sBDsga22zCthlZzFgz+kGCLb6lBNjWwxj
	FFtp1rJVi38JWHPDKZI1LxZTbM93ywR77byRYv/Ju0qyBSfNGDvXUyRgl8xBrHlqDnuH+VAU
	r1Zps7kXM1Sa7NeESRIUKZJIkSgyWiqSRL2aHBcZIxQnxB/gMg9+wqnFCamijLt5NjLrLJ3j
	qMvDdeAxpQc0DZlouFAVpgeetA9TA+AVYwmuBx4r51vgZcd9Aa994VO7nuRNCwCWtBSuFTYA
	nWMOwBd1ADaP1GCrCMmIod1od7fyY4Jh76jOTeDMFAV/njzh7uvL7ID2mXsEb3odNhUNkryO
	g/OLFW6YYLZDi6HA7fdiQqCtYXht9AAGXY3z7mkezF7YtHTcbQLMC3Ci3kmtapzZDEenKjA+
	BAOrr/athdsEZyafrYULh3eGpwCvI+CVmg6C19ugvWAErC4JZ0KhqVXMt5TCpV+cgNfb4Nn8
	RxR/N294u3SKOA22GNZNNvxPG9bRhnW0YR1dCQQNwI/TahTpCk2kSCNXaLTKdFGaSmEGKw/Z
	2v3E0gzqf18QdQKMBp0A0rjQz+u96pucj9cB+adHObUqRa3N5DSdIGZldWfwwE1pqpWfoMxO
	kcRGxEiiY6URMdLYKOFmr7eyvpL7MOnybO4Qx2Vx6v84jPYI1GH7hmf3w7kv78X3bT/v6d/W
	dokunNx5KbQq+sb0y/7f+B8L3U8YvEfD4fzDE40DTPCI96Oop06vN9JSqj5KNcap7tdOHMFm
	Tu6BybL59ijL8sj3yiAmM6gj0QnD/v62JTfxa22DKWBC8KBbMfmrQx/QdCQ1zcdWpu+6sKtU
	HjIp6RcnCRVoJudJ2eHdlowa2/WW5/ml5b6uEWpi63jkS0NDR2+8v0FWt4e9XNmsHJLmE2D3
	RkK2NzDpcXDe9LsBHxdVFbarEj7X7NspCz8WmGA/tEHO9RfqcxIPB/fINqa/XSC7S1vG3rx9
	urj2j3LVma2jrfWxCb+VJz8QN/q1f7Yr6AMhocmQS8JwtUb+L/fPdy5RBAAA
X-CMS-MailID: 20240208140244eucas1p1308da6aac688043b2064e91a5e38b34e
X-Msg-Generator: CA
X-RootMTR: 20240208134629eucas1p2edf4cb1e50e3bb578297c33b79701574
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240208134629eucas1p2edf4cb1e50e3bb578297c33b79701574
References: <20240124-alice-mm-v1-0-d1abcec83c44@google.com>
	<20240124-alice-mm-v1-3-d1abcec83c44@google.com>
	<CALNs47uPgvYXxEDmwb6GKa+cw597_rDD1zaSPDa9k9D-6_qZxQ@mail.gmail.com>
	<CGME20240208134629eucas1p2edf4cb1e50e3bb578297c33b79701574@eucas1p2.samsung.com>
	<CAH5fLgi_iU3nDE-gJ56s8CPznWvC0T4P5M0dVx1zO61kmVGNgQ@mail.gmail.com>

DQpBbGljZSBSeWhsIDxhbGljZXJ5aGxAZ29vZ2xlLmNvbT4gd3JpdGVzOg0KDQo+IE9uIFRodSwg
RmViIDEsIDIwMjQgYXQgNzowMuKAr0FNIFRyZXZvciBHcm9zcyA8dG1ncm9zc0B1bWljaC5lZHU+
IHdyb3RlOg0KPj4NCj4+IE9uIFdlZCwgSmFuIDI0LCAyMDI0IGF0IDY6MjLigK9BTSBBbGljZSBS
eWhsIDxhbGljZXJ5aGxAZ29vZ2xlLmNvbT4gd3JvdGU6DQo+PiA+ICsvLy8gQSBwb2ludGVyIHRv
IGEgcGFnZSB0aGF0IG93bnMgdGhlIHBhZ2UgYWxsb2NhdGlvbi4NCj4+ID4gKy8vLw0KPj4gPiAr
Ly8vICMgSW52YXJpYW50cw0KPj4gPiArLy8vDQo+PiA+ICsvLy8gVGhlIHBvaW50ZXIgcG9pbnRz
IGF0IGEgcGFnZSwgYW5kIGhhcyBvd25lcnNoaXAgb3ZlciB0aGUgcGFnZS4NCj4+ID4gK3B1YiBz
dHJ1Y3QgUGFnZSB7DQo+PiA+ICsgICAgcGFnZTogTm9uTnVsbDxiaW5kaW5nczo6cGFnZT4sDQo+
PiA+ICt9DQo+Pg0KPj4gU2hvdWxkbid0IHRoaXMgYmUgVW5zYWZlQ2VsbCAvIE9wYXF1ZT8gU2lu
Y2UgYHN0cnVjdCBwYWdlYCBjb250YWlucyBsb2Nrcy4NCj4NCj4gVGhhdCBvbmx5IG1hdHRlcnMg
d2hlbiB3ZSB1c2UgYSByZWZlcmVuY2UuIEhlcmUsIGl0J3MgYmVoaW5kIGEgcmF3IHBvaW50ZXIu
DQoNCldoeSBpcyBpdCBiZWhpbmQgYSBwb2ludGVyIHJhdGhlciB0aGFuIGJlaW5nIHRyYW5zcGFy
ZW50IG92ZXINCmBPcGFxdWU8YmluZGluZ3M6OnBhZ2U+YCBhbmQgdXNpbmcgYSBgJlBhZ2VgIGlu
c3RlYWQ/DQoNCkJSIEFuZHJlYXM=


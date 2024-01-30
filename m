Return-Path: <linux-kernel+bounces-44192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27620841E9C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AC991C253CB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31FB58234;
	Tue, 30 Jan 2024 09:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="femepWid"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FCC5813B
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 09:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706605388; cv=none; b=Dd/xMGj1I4qlq5shVzfLl3B3mkfPhjZUvsxxUlD3CS9zREHypu5c5bLGww+hfZxKCs+yjy3AILKBT1gspH5ALs/PLRRIrQUBoGOv6Znc4m0Iu+5TXtbG+q2idH8spTFNnLz6uLR9Pps4Ii++uxGdJ7pbSOoiP+/v1BJZA/X4U48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706605388; c=relaxed/simple;
	bh=BEcq/qhqoqGZggGlJrW/V6J25+ggKvqtaGOMG4iq9qI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version:References; b=tCeBw/YGZG3wQS2SsxUw32S5B4EysUqDzKH6ibMXGAeGToLdVUuIiPBRzSqVsli8blMXJ2ygiZ4+qhLVXCFexC2IxhLU4T5+zX1X6+7/MxM9zVY3N8rKqD2uTwu3FB/hu/7G5VPfK37MEJ886TqQK2tXsZ68aspfw3HJcYSZX2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=femepWid; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240130090258euoutp02ef20137f78992f8e38578891ba0dbe7f~vFIzOX6SQ2650926509euoutp02f
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 09:02:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240130090258euoutp02ef20137f78992f8e38578891ba0dbe7f~vFIzOX6SQ2650926509euoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1706605378;
	bh=u5skJTC1NiSxxvHS0YUB/jwBwTXaDHnBS1B0psxcAog=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=femepWidQ6EJHN5Aj267qrGtF2Jj7X6duSAVhyRkcrvlFpZIedfxS0i9+vGOsH9mH
	 CLvI/Rr1lyfxVC0AdGP3i5yLHHTN3/vIXPxXWveiGws8JsTewSgggmcU1ijYvcYvHc
	 9Fx00Ywvq0bR/hzzDjpxC1SQam69EF/PqyoYvwDs=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240130090257eucas1p1c595c555b393cc3c01079203e10f2e1c~vFIxnu7vV1567115671eucas1p1E;
	Tue, 30 Jan 2024 09:02:57 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 67.24.09539.04BB8B56; Tue, 30
	Jan 2024 09:02:56 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240130090256eucas1p1f65f4e34dbbd7dec2ac619b7b60ae073~vFIxJt5-O1387013870eucas1p1S;
	Tue, 30 Jan 2024 09:02:56 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240130090256eusmtrp11bc05448befd85e707a393fc56944407~vFIxIkU4C3128631286eusmtrp1E;
	Tue, 30 Jan 2024 09:02:56 +0000 (GMT)
X-AuditID: cbfec7f2-515ff70000002543-bd-65b8bb40e463
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id DF.1E.10702.04BB8B56; Tue, 30
	Jan 2024 09:02:56 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240130090256eusmtip10e72268538ab337e757e9fc1dd96fbbd~vFIw7uTDP2109621096eusmtip1F;
	Tue, 30 Jan 2024 09:02:56 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) by
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) with Microsoft SMTP
	Server (TLS) id 15.0.1497.2; Tue, 30 Jan 2024 09:02:55 +0000
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
	([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Tue, 30 Jan
	2024 09:02:55 +0000
From: Andreas Hindborg <a.hindborg@samsung.com>
To: Matthew Wilcox <willy@infradead.org>
CC: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
	"Alex Gaynor" <alex.gaynor@gmail.com>, Wedson Almeida Filho
	<wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo
	<gary@garyguo.net>, =?iso-8859-1?Q?Bj=F6rn_Roy_Baron?=
	<bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Kees Cook
	<keescook@chromium.org>, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton
	<akpm@linux-foundation.org>, "Greg Kroah-Hartman"
	<gregkh@linuxfoundation.org>, =?iso-8859-1?Q?Arve_Hj=F8nnev=E5g?=
	<arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen
	<maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas
	<cmllamas@google.com>, "Suren Baghdasaryan" <surenb@google.com>, Arnd
	Bergmann <arnd@arndb.de>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>, Christian
	Brauner <brauner@kernel.org>
Subject: Re: [PATCH 3/3] rust: add abstraction for `struct page`
Thread-Topic: [PATCH 3/3] rust: add abstraction for `struct page`
Thread-Index: AQHaUD8NVXQbcxmBfkinu8UJuZg2mrDxGW2AgAD5TwA=
Date: Tue, 30 Jan 2024 09:02:54 +0000
Message-ID: <87mssngpnc.fsf@samsung.com>
In-Reply-To: <ZbfnmX1J8iLV8UnO@casper.infradead.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf1CTdRzH+z579jwPQ66HgfIVJyV3ZOkaQv3xPTQk666n6Ad6R2dJxpQn
	kDagjcHUrgZ4mLQ8AzthoJskILQFzW2YgzYH8UN+GGADOTDjViegKaAZEBjbgx3/vT73fX/e
	n/fnc1+KJ6wjQqkDGdmsIkMqCycEuK1t9urzcfaL7BZD71ZUUW8k0EJ5I4k6BvNxtFDcRqK7
	C78R6J47n4+GfnHwkNGSh6HJlmmA7jv7SdTXPQlQwbf1BKrWRKDuL+Vo4FIFgW4YH/GRzajh
	o1p9DUD1f7bwUEm/gUAG9xyJri6081FDtQmg+X8qiDjI2Ow2PjM/VwyYck0fzpw7NocxP+pG
	ScZgVjEXzm9izk4/4DPmumMEY54uJpmO0nmccZw2kszDo00Eoy00Y8yMOYwxe+5gCfT7gm0p
	rOxADquIjE0WpLmGvsOz9H7qL0xTQANmiSLgR0H6RVhZ1IkXAQElpM8DaLOdAVxxH0D98PcY
	V8wAON44Ax63LBoKMC8L6RoAr5k++l800HOD5IpuAPMsruX2WgAnHrhwbwtBR0K30c0rAhQV
	TD8Lb1uivRoe7SHh33aXzzaIjoPu8Ws+fTD9Mmw43k9wHAPbCzSkl3E6Al7Wan0csOST31ns
	0/gtxesf7eJ7GdDr4VjtnE/Do0PgsEePcSsEwsryJh7Ha+Dipd+XryGGPYOe5TW3QGvVTzjH
	G6Bbex1wPhI49M1JguPNsPrsJI/LEAg7yzy+S0Ja6w/HHv6xbPQqrKq7yec4CE60W0iORbCr
	RIufAJt1K/LpVszQrZihWzHDAPA6EMKqlPJUVhmVweZKlFK5UpWRKtmfKTeDpe/ctdg+fRGc
	npiSuABGAReAFC88OGD2OSsrDEiRHjzEKjI/VKhkrNIF1lF4eEhARMpTrJBOlWazH7NsFqt4
	/IpRfqEaLGb0iOERNtBmsQynqfPuvit4ffvcS2dKPrWO1Lwlas4pFKlG9EkXHCc3mg4fPXGk
	Nzoua9Bpvdf3uRqE7TyVvW/7lUT7VPKtf/clOrfKtLmv2aLfS0ot2+jSxciDZvMN6QmiSN36
	VZOxUel7xuwz4+LGD0ITplp3rPUv3vm1o1CmCBHl3NwvpJ4U72iOWluacvBci1O3ruGHwlyT
	2Tra55T+9fae3eQTkpHFW81kfGv68OW9q/WNhz5x+JcmvtnhmVj9WRkI283y71xJGqzSXU+K
	XXP8hVfeyey9rXaT236uElam7XWoBdmH43tSJsRP17zxa1PgqmdsCfzk1l274sxfaeLF4bgy
	TRq1iadQSv8D4nuX1D0EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUxTVxjGPb23t4Wk866UeMJgm02MClJopfUgrGNmuouZboZsMxqnjd7x
	IbTYDzf7x1IpTKVs04pka2soE5hgFdZBZXzIKFgQcEzmCpihi3ZzUhjCWIAy2EqvS/jvd877
	Ps/7PieHi/GriShutlJLq5WKXCERjvctdY/Gp7U00YmeyWhkq3MQaNF6nYN6hgpwtGj2cNDk
	4gMCPfUWsNHwj+0YcjScZCF/5zRAM98PctCdfj9Axkt1BKo2rEP9pjz0U7ONQPcd/7KRy2Fg
	o5ryrwGq+70TQ+cH7QSyewMcNLDYzUb11VcBWpizEWmQcrW42NRCwAwoq+EOTlWeCbCo7yyj
	HMru1FHfXo6lKqb/ZlPO2jME5Zw2c6ieLxZwqv2ig0PNnmolqJJPnCzqL+eLlNM3wXqb3CdK
	Vat0WvrlLJVG+4pwvxhJROJkJJIkJYvEm7cc2CqRChPkqUfo3OzjtDpBfkiU5R6+gueXh310
	+uoUMIB5ohiEcSGZBJfsRlYxCOfyySoAT/kbMaYQDb+Z+ZnNcAT8x1scEvDJKQAXy1czgn4A
	W4sWOMyhBkDTTaaLIBOg1+ENOnG5AnIDHG+QLPdg5EMO9J0cCblGkGnQ++QuvswC8jVY/9kg
	wfBW2G00cJYZJ9fBjpKSEPOCPgW3zAQzbCK4avNIqBAWzDA42hcyBWQMfFgTCN1j5Bp4z1fO
	YiKQsLJ14Fm0SPjk0dKzaJvg7SEfYDgRNlbdwBleC70lI4DxEcHhC6UEw3GwusKPMQs9D299
	6cPPghcsK8ZZVkgsKySWFRI7wGuBgNZp8jLzNBKRRpGn0SkzRYdVeU4Q/LAuz3xDE6gZmxK5
	AYsL3AByMaGAN7+xkebzjihO6Gm16qBal0tr3EAafKRzWFTkYVXwxyu1B8WyRKk4SZacKE2W
	bRau4aXnn1bwyUyFlj5K0/m0+n8dixsWZWDtjMPbju+pOsYX3hck1NsCCdaYQ2LJhtkida+c
	p4qMrh4rVV37atcVd6k8xW/dlC3+mBRgMuvumbdqcevINB1emP5e/lLiox+u5Txo6xkwDi3s
	6f3DeWCj9zdj2fvn9NFo0hS/vnC8tfO5dwWex+MdsrgU+edW+e3Y7a/qt/wpl/hduvC5HTk5
	nZe2Vcx2bC/6Zaj0gvXoRakJZhxL83yg6zIXfJgaY9u3VDb31H137f72d+7VXN4br3xzPYnV
	v37zem2Lre+NvRMdN3ZKfk1KydCvOuEOVOyIi6xUtOnHIpolfatNU2O9hWTX2ab0bTPN7K7J
	VS0Zn76Utvuxbhf3vLRMiGuyFOJYTK1R/AecrINTOQQAAA==
X-CMS-MailID: 20240130090256eucas1p1f65f4e34dbbd7dec2ac619b7b60ae073
X-Msg-Generator: CA
X-RootMTR: 20240129180005eucas1p1c1962ece31e6b9619f9e22dc95f54087
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240129180005eucas1p1c1962ece31e6b9619f9e22dc95f54087
References: <20240124-alice-mm-v1-0-d1abcec83c44@google.com>
	<20240124-alice-mm-v1-3-d1abcec83c44@google.com>
	<CGME20240129180005eucas1p1c1962ece31e6b9619f9e22dc95f54087@eucas1p1.samsung.com>
	<ZbfnmX1J8iLV8UnO@casper.infradead.org>


Matthew Wilcox <willy@infradead.org> writes:

> On Wed, Jan 24, 2024 at 11:20:23AM +0000, Alice Ryhl wrote:
>> +impl Page {
>> +    /// Allocates a new set of contiguous pages.
>> +    pub fn new() -> Result<Self, AllocError> {
>> +        // SAFETY: These are the correct arguments to allocate a single=
 page.
>> +        let page =3D unsafe {
>> +            bindings::alloc_pages(
>> +                bindings::GFP_KERNEL | bindings::__GFP_ZERO | bindings:=
:__GFP_HIGHMEM,
>> +                0,
>> +            )
>> +        };
>
> This feels too Binder-specific to be 'Page'.  Pages are not necessarily
> allocated with GFP_HIGHMEM, nor are they necessarily zeroed.  Maybe you
> want a BinderPage type?

Rust null block uses the same definition of these flags [1], so there is
at least that synergy.

I feel like we had the discussion of the flags before, although I can't
find the thread now. I think the conclusion was that we fix them until
we have code that need to actually change them (as to not add dead
code).

BR Andreas

[1] https://github.com/metaspace/linux/blob/702026e6645193fc89b7d55e00dac75=
fd492bfb8/rust/kernel/pages.rs#L28=


Return-Path: <linux-kernel+bounces-35063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2A6838B59
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72E451C21C5E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804CC5A106;
	Tue, 23 Jan 2024 10:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="k3J8SvYh"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83B55646A
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 10:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706004291; cv=none; b=f013eiEVoCvdO1/9rkqDizPxDGKkeHiuQn4AewE8VSFxmCYOYlJQU0CxuPpkmbFmcMCAOZgFDJmb8yfux9VqswVLObF3fzkoPpPHMPtlKb0C9x4OEH2fdEFE3GISxCXcRQ3JUAXjm0Y36MQBV6nO2tvNvD+70y33KgecLXA0B74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706004291; c=relaxed/simple;
	bh=ovOUXCarNLljHoRz7eIXs5gUQJ8YACpGt9Ip75egTxw=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=gSWGCaWWb3Cd6fRxcGYM3mLf/KGoCaNi57nDlFBNOocfhlOYkn8hE231dM7QklGgMN2MVxvlqy+QK6f4RdyiALjJ8RtbucDXX9BQBhwFuVQ6Dvho/Jf6+KtTUjsLD2U1jrtNXuZ4eiatZUN9/lpbaRNAkMdgut3NzdZjQHWlxkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=k3J8SvYh; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240123100442epoutp03e8f7772483310a7b23b9bff143c6c060~s8dsfcWiC2721027210epoutp03V
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 10:04:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240123100442epoutp03e8f7772483310a7b23b9bff143c6c060~s8dsfcWiC2721027210epoutp03V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1706004282;
	bh=XpyCDwoUTF2fUQKmUh+dmwM+2XfycVCRCoBVKaz9gnc=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=k3J8SvYhs24s2VHnjfTtlK/Qvkr7SfBqelrtQA8QgvTjxSgp4busuYpSz4ZlKuAEu
	 oU/HDy6hIEgdzdqNmhzzoZMbT5b5gp6vacuF9cpWvNyy+B5z6wbNgQcemFVQDmU7Jr
	 mvXLgake3azG9r9Yuyc77eNi9A9I3n6WuTVffqJI=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240123100442epcas5p18b09ea51a56099bcac82a657c09fe938~s8dsOQ4Qe1077510775epcas5p1B;
	Tue, 23 Jan 2024 10:04:41 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.178]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4TK2kb6xRNz4x9Q7; Tue, 23 Jan
	2024 10:04:39 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	81.7A.09672.73F8FA56; Tue, 23 Jan 2024 19:04:39 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240123100439epcas5p285a73c1e98cea5e2510900a9a94cc957~s8dp9G4Dp1631716317epcas5p2W;
	Tue, 23 Jan 2024 10:04:39 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240123100439epsmtrp22be8cc3e5460997b3eb544c44a8630e6~s8dp8Z9y53119531195epsmtrp2q;
	Tue, 23 Jan 2024 10:04:39 +0000 (GMT)
X-AuditID: b6c32a4b-c1355a80000025c8-a5-65af8f37ccdb
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	FB.2F.18939.73F8FA56; Tue, 23 Jan 2024 19:04:39 +0900 (KST)
Received: from SRIB7IJ5F5BM8F (unknown [107.108.206.9]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240123100437epsmtip16f703f0f778a361b08c359ba0e455ef2~s8doT6ky_3061430614epsmtip1w;
	Tue, 23 Jan 2024 10:04:37 +0000 (GMT)
From: "sandeep.cs" <sandeep.cs@samsung.com>
To: "'Jiri Kosina'" <jikos@kernel.org>
Cc: "'Joe Perches'" <joe@perches.com>, "'Benjamin Tissoires'"
	<benjamin.tissoires@redhat.com>, <gaudium.lee@samsung.com>,
	<ih0923.kim@samsung.com>, <suhyun_.kim@samsung.com>,
	<jitender.s21@samsung.com>, <junwan.cho@samsung.com>,
	<linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <nycvar.YFH.7.76.2401231049150.29548@cbobk.fhfr.pm>
Subject: RE: [HID Patchsets for Samsung driver v2 2/6] HID: Samsung : Fix
 the checkpatch complain.
Date: Tue, 23 Jan 2024 15:34:26 +0530
Message-ID: <058f01da4de3$93be7b20$bb3b7160$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGnAMfWRo+zFj79MMHZQSbz6pOJPAGgO/sIAfyMtNQBptQ1HwLB7ZUQAIuUYiCxCTtC8A==
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDJsWRmVeSWpSXmKPExsWy7bCmlq55//pUg48/TSyuT9nManF7gafF
	1iVzWS1uHW9ltHj5YAO7xez7j1ksNk9+xGJx89M3VovLu+awWTxasYnJgctj06pONo8vq64x
	e7zfd5XNo2/LKkaPz5vkAlijsm0yUhNTUosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTy
	EnNTbZVcfAJ03TJzgI5SUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BSYFOgVJ+YW
	l+al6+WlllgZGhgYmQIVJmRnLHnQy1rwm7ti6d5WtgbGfxxdjJwcEgImEg/f7mbrYuTiEBLY
	zSjxdudNRgjnE6PEvf71zHDOyvVHmWFa/t3tYodI7GSU2POsAarlDaPE8kf72EGq2AS0JWb8
	vQbWISKgJjHn5T2wJcwCq5gkNv9bzASS4BRwkNi9+yYriC0skCLx9eRDRhCbRUBVom/2CxYQ
	m1fAUuLe/wY2CFtQ4uTMJ2BxZgF5ie1v50CdpCDx8+kyVohlYRKdu1YzQdSISxz92QP2g4TA
	Sg6Jyb+mQTW4SNz63cIOYQtLvDq+BcqWkvj8bi8bREM3o8TS28fYIZwZjBItO69CddtL/Hw9
	AaiKA2iFpsT6XfoQ2/gken8/YQIJSwjwSnS0CUFUq0g87drNCjP/+4mNTBC2h8T/HysYJzAq
	zkLy2ywkv81C8sMshGULGFlWMUqmFhTnpqcWmxYY56WWw+M8OT93EyM42Wp572B89OCD3iFG
	Jg7GQ4wSHMxKIrw3JNelCvGmJFZWpRblxxeV5qQWH2I0BQb4RGYp0eR8YLrPK4k3NLE0MDEz
	MzOxNDYzVBLnfd06N0VIID2xJDU7NbUgtQimj4mDU6qBqUFxtaPMjpWK1z9tPfzBaIfZkmNM
	V4Ujf6t1aK6bvndv/Qb2b4zBt/jN4+QUK07zfPq57GHYthlXv98U1ahVPddyZOdaS+/dB8+a
	BPx+MVvxK9/D0k+LQ0JW5bIsXyPnsLwxeebndb9lHDec65l1c92RUv83dofqz3Pukg+N5v68
	RdLE56RtXV7vlLjONeZH7omsElu+a+ms+qYH1wUMZNmDlfyWbrGaPMWqW3+Omi9vQMmqzUWu
	KwXbO/alHnwjo7VTufWh6XfNBRNWhxQ9cp755EjVnt9syZsmXzpr/6GZw61qK0fe/9p/lvZX
	pisdLVacHnjYmHtxxelrFe0G6/a27Ozv2OQ5Vf0ps06IjasSS3FGoqEWc1FxIgCTOJGXPwQA
	AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjkeLIzCtJLcpLzFFi42LZdlhJTte8f32qwcyJ0hbXp2xmtbi9wNNi
	65K5rBa3jrcyWrx8sIHdYvb9xywWmyc/YrG4+ekbq8XlXXPYLB6t2MTkwOWxaVUnm8eXVdeY
	Pd7vu8rm0bdlFaPH501yAaxRXDYpqTmZZalF+nYJXBlLHvSyFvzmrli6t5WtgfEfRxcjJ4eE
	gInEv7td7CC2kMB2Roknb0Ug4lISq67fY4SwhSVW/nsOVMMFVPOKUWLmiX42kASbgLbEjL/X
	mEFsEQE1iTkv77GBFDELbGKSWPf1IxtExwMmibXzP4KN4hRwkNi9+yYriC0skCRx/8N0sEks
	AqoSfbNfsIDYvAKWEvf+N7BB2IISJ2c+AYszC+hJrF8/hxHClpfY/nYOM8R5ChI/ny5jhbgi
	TKJz12omiBpxiaM/e5gnMArPQjJqFpJRs5CMmoWkZQEjyypG0dSC4tz03OQCQ73ixNzi0rx0
	veT83E2M4CjTCtrBuGz9X71DjEwcjIcYJTiYlUR4b0iuSxXiTUmsrEotyo8vKs1JLT7EKM3B
	oiTOq5zTmSIkkJ5YkpqdmlqQWgSTZeLglGpgSs+yXXLCgUmW98ybwAMLuNjeMR5JPSy+Kts1
	wMqgqPe4cK8hU0yXpftNh4oZ05+UiR38G6f2UZFnXTvz64aED6lC191WZikteZexdpnONsnr
	vzfpPGT3NfghF8kxl3e5oveER/2yXRs5Kj52qfXdv/YoecOtyT8qwgr7vY7d/iUQzrLX+lbG
	gfDPR14vqa3aKjXvzwTL4Jex1lpnZz04MXtX1l31/7sFX87V5JfPWaXSt+/l07lmTbOzJx5y
	2v1Meou8wNod+95FVW/3D5p9bf6teaaz1v7eN59n45yot2ZnZlxqtzOs+qc2S/vA+oDLNcWl
	85WnbjsmfYPJkDs586Hp3o2WJjP78/rmnvR9lqrEUpyRaKjFXFScCAA2al2WIQMAAA==
X-CMS-MailID: 20240123100439epcas5p285a73c1e98cea5e2510900a9a94cc957
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240108091959epcas5p2559b779424e2fb7c7e268d1b24612b4f
References: <20240108091917.1552013-1-sandeep.cs@samsung.com>
	<CGME20240108091959epcas5p2559b779424e2fb7c7e268d1b24612b4f@epcas5p2.samsung.com>
	<20240108091917.1552013-3-sandeep.cs@samsung.com>
	<486973921f89f70bcc5d42501eeca3fd105be2c4.camel@perches.com>
	<020e01da421f$c0d20660$42761320$@samsung.com>
	<nycvar.YFH.7.76.2401231049150.29548@cbobk.fhfr.pm>

>> >> -	} else
>> >> -	if (*rsize == 203 && rdesc[192] == 0x15 && rdesc[193] == 0x0 &&
>> >> +	} else if (*rsize == 203 && rdesc[192] == 0x15 && rdesc[193] ==
>> >> +0x0 &&
>> >>  			rdesc[194] == 0x25 && rdesc[195] == 0x12) {
>> >>  		samsung_irda_dev_trace(hdev, 203);
>> >>  		rdesc[193] = 0x1;
>> >>  		rdesc[195] = 0xf;
>> >> -	} else
>> >> -	if (*rsize == 135 && rdesc[124] == 0x15 && rdesc[125] == 0x0 &&
>> >> +	} else if (*rsize == 135 && rdesc[124] == 0x15 && rdesc[125] ==
>> >> +0x0 &&
>> >>  			rdesc[126] == 0x25 && rdesc[127] == 0x11) {
>> >>  		samsung_irda_dev_trace(hdev, 135);
>> >>  		rdesc[125] = 0x1;
>> >>  		rdesc[127] = 0xe;
>> >> -	} else
>> >> -	if (*rsize == 171 && rdesc[160] == 0x15 && rdesc[161] == 0x0 &&
>> >> +	} else if (*rsize == 171 && rdesc[160] == 0x15 && rdesc[161] ==
>> >> +0x0 &&
>> >>  			rdesc[162] == 0x25 && rdesc[163] == 0x01) {
>> >>  		samsung_irda_dev_trace(hdev, 171);
>> >>  		rdesc[161] = 0x1;
>> >
>> >For this block, I think a rewrite using memcmp would be clearer.
>> >Something like:
>> Okay . Thanks for your valuable feedback. We will promptly address
>> your suggestions and enhance our code accordingly.
>
>I agree with Joe's suggestion here; are you planning to send v2 of the
series?
>
>The rest of the set looks good to me.
>
>Thanks,
>
>--
>Jiri Kosina
>SUSE Labs

Hello Jiri ,

Yes, I am planning to send the v2 of the series. I will include review
comments and share it with you soon.

Thank & Regards
Sandeep C S



Return-Path: <linux-kernel+bounces-37872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F71383B6DA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 02:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C408D2843A0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 01:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA255CA1;
	Thu, 25 Jan 2024 01:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fMD+G96n"
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3803566A
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 01:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706147530; cv=none; b=eIdA6Vk0E0ZIwFGHUQO/We5ZVOOsbOC8Bpkom08JxOvfPqz07wJxuvlpyIkTZkfpEniEgQPg1Y0nIMNdLunUdjieMKD2ArWJlUtz0QxKBnlHDUleXCZHldFKGM8Gej6nuwnkR+osQ1U1LlAjX7shCzjDyyTop6LsZysmqbAX2IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706147530; c=relaxed/simple;
	bh=ZJ1GNx5ryxSDx5W6FiQrSJk0Y5y4JRaDlZzorVio9I0=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=UInZ6WewuW5MF4pZsdowDdjNxxEq3fe67RYOkrewhxBXAgA2k1b/gZKHU4zGKr8NRfzdAqKK9hBJiGiPyV97f8RgadGdsq7UfYBXhO+G9nGbAERz1wUvLo2dIJj8WxANHWb6Kg3s2L0geYifg2mv02tQYJOFvbLHBCt3wy+R/VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=fMD+G96n; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240125015205epoutp045f5943be85bfe8caec298616f45dfd47~tdCJr7HQA1723717237epoutp04T
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 01:52:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240125015205epoutp045f5943be85bfe8caec298616f45dfd47~tdCJr7HQA1723717237epoutp04T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1706147525;
	bh=8Er5bzFeFelCVreOXb2lRDMRhYWCfoIp3xasGT4diT0=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=fMD+G96nkj0Zb8MR5ImsZKml+XNoHpatO+Iry0IgpsJuKB6gKO2o99QAL0iub5Iiz
	 tpIs5Z0mwJRNqT0ssd0wyHyo5+Dqi3rZfnJK/QYpxvIyj9VCq2OVJ/hCJLW62R+UMY
	 S0HfWRkSWzwqoZgJRidPasuQpsmTmw/3yDToOIwk=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240125015204epcas5p1cd7fa49397bf8e6f4b4e411f47daa3df~tdCJVi_d01296212962epcas5p1Q;
	Thu, 25 Jan 2024 01:52:04 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4TL3jG674Fz4x9Q1; Thu, 25 Jan
	2024 01:52:02 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	7F.7C.19369.2CEB1B56; Thu, 25 Jan 2024 10:52:02 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240125015202epcas5p4a37e2da6aeda3e7f6a46c6d78fa8d182~tdCHH-eZS0492104921epcas5p4U;
	Thu, 25 Jan 2024 01:52:02 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240125015202epsmtrp1ba6dfb89cdfd12cf4ece48c1971cca60~tdCHG0kOk1924219242epsmtrp1O;
	Thu, 25 Jan 2024 01:52:02 +0000 (GMT)
X-AuditID: b6c32a50-9e1ff70000004ba9-bb-65b1bec2b2f8
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	FC.F0.18939.2CEB1B56; Thu, 25 Jan 2024 10:52:02 +0900 (KST)
Received: from SRIB7IJ5F5BM8F (unknown [107.99.12.215]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240125015159epsmtip17ac3c67e59d0070d149cfee40aec4d69~tdCE9L1BL2716327163epsmtip1Z;
	Thu, 25 Jan 2024 01:51:59 +0000 (GMT)
From: "sandeep.cs" <sandeep.cs@samsung.com>
To: "'Jiri Kosina'" <jikos@kernel.org>
Cc: "'Benjamin Tissoires'" <benjamin.tissoires@redhat.com>,
	<gaudium.lee@samsung.com>, <ih0923.kim@samsung.com>,
	<suhyun_.kim@samsung.com>, <jitender.s21@samsung.com>,
	<junwan.cho@samsung.com>, <linux-input@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
In-Reply-To: <nycvar.YFH.7.76.2401241917490.29548@cbobk.fhfr.pm>
Subject: RE: [HID Patchsets for Samsung driver v3 3/6] HID: Samsung : Add
 Samsung wireless keyboard support.
Date: Thu, 25 Jan 2024 07:21:44 +0530
Message-ID: <000501da4f31$16ec07d0$44c41770$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGe9MEZUacnBkQWTWlSz6s7q4Y4xAGczTLaA7AsQnoA9RKiFLEuZp+A
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEJsWRmVeSWpSXmKPExsWy7bCmhu6hfRtTDR5s1rG4PmUzq8XtBZ4W
	W5fMZbW4dbyV0eLlgw3sFpsnP2KxuPnpG6vF5V1z2CwerdjE5MDpsWlVJ5vH+31X2Tz6tqxi
	9Pi8SS6AJSrbJiM1MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNct
	MwfoFCWFssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJrVJqQUpOgUmBXnFibnFpXrpeXmqJlaGB
	gZEpUGFCdsaxky9YC46xVfyf/oWtgXE1axcjJ4eEgInE5ueP2boYuTiEBPYwSrya+IAdwvnE
	KHHg4ks2OGftgi8sMC0br75igkjsZJS4sfUzVNUbRonD++eAVbEJaEvM+HuNGcQWEVCTmPPy
	HlgRs0A7k8Slvr9gRZwCDhInD64DKuLgEBbIkzjV4Q4SZhFQlViy/BMTiM0rYCnRcnUXO4Qt
	KHFy5hOwVmYBeYntb+cwQ1ykIPHz6TJWiF1uEo+OvmKGqBGXOPqzhxlkr4TATA6JK9daob52
	kZh34ScThC0s8er4FnYIW0riZX8bO0RDN6PE0tvHoJwZjBItO69CrbOX+Pl6AhvI1cwCmhLr
	d+lDbOOT6P39hAkkLCHAK9HRJgRRrSLxtGs3K8z87yc2Qu31kFg78wDzBEbFWUh+m4Xkt1lI
	fpiFsGwBI8sqRqnUguLc9NRk0wJD3bzUcnicJ+fnbmIEJ1atgB2Mqzf81TvEyMTBeIhRgoNZ
	SYTXxHRjqhBvSmJlVWpRfnxRaU5q8SFGU2CIT2SWEk3OB6b2vJJ4QxNLAxMzMzMTS2MzQyVx
	3tetc1OEBNITS1KzU1MLUotg+pg4OKUamFxmWdRz819dz3mwLuYMw7qVeXsURFfd79H8XFKR
	sOeRYL0oD6/dF7mIp8rsXDNaT11Vk/Ja6PYjgJFDjtvZOmtFqOeU2gRvm0OTzAIO8J8S3bXp
	2YdHPMbnFyTMuZgsdzCVo9jVLO/RvgWyMX6zlZJ2CNQzy5vsWPspIiZqh/EM1vfbjvbPaOjs
	2cxmvOTy74QtG2dw5Nl9vtusZdjvs0z25O7Pa90s8/K3XDRYtHea0KdzvZaleTdU67wF26U2
	7a3i/L+5V0Fghd7diV80y749qdtc1cNUGdLeV/B72ueVjdIyP4RnHHX7sDfnwtrYhe1Wzgcc
	xBa4KO1g/LWsZ0Kt1NQ3WTWL07vSbKRXKLEUZyQaajEXFScCAMR6O7A1BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphkeLIzCtJLcpLzFFi42LZdlhJTvfQvo2pBnf+cFhcn7KZ1eL2Ak+L
	rUvmslrcOt7KaPHywQZ2i82TH7FY3Pz0jdXi8q45bBaPVmxicuD02LSqk83j/b6rbB59W1Yx
	enzeJBfAEsVlk5Kak1mWWqRvl8CVcezkC9aCY2wV/6d/YWtgXM3axcjJISFgIrHx6iumLkYu
	DiGB7YwSKzf+YIZISEmsun6PEcIWllj57zk7RNErRolrU6+xgyTYBLQlZvy9BtYgIqAmMefl
	PTaQImaBXiaJ319bWSA6vjJK/Hy1GqyDU8BB4uTBdUAdHBzCAjkSkw9ngYRZBFQlliz/xARi
	8wpYSrRc3cUOYQtKnJz5hAXEZhbQk1i/fg4jhC0vsf3tHKhLFSR+Pl3GCnGEm8Sjo6+YIWrE
	JY7+7GGewCg8C8moWUhGzUIyahaSlgWMLKsYRVMLinPTc5MLDPWKE3OLS/PS9ZLzczcxgiNK
	K2gH47L1f/UOMTJxMB5ilOBgVhLhNTHdmCrEm5JYWZValB9fVJqTWnyIUZqDRUmcVzmnM0VI
	ID2xJDU7NbUgtQgmy8TBKdXAJDiX0U7GVP2D1Fx2v0+7FP4WLD+w//X8r1IbxW8wWf8xk41R
	bv6p/7Vt5iXTd0fenp2RPKH4bpNMz747aUHv97ydHPn007GWaLkp5rkmZx6tUVr2XyahMEbp
	xMue+7UbVBfP+SXO8YFr1YP8M7O1JhzUV77cpBp7/6TzwS+pDzucUyJs80OMc1pOft7wq5X7
	WKvyKn2l7sdGMxhsDh72DvecJp4XobXlinb6zq9et56JRkX2/0/JnX86LqojdZfJl0bx1XJT
	UqdkHzik37TwYG2Q/s0Pn1fJHmdt8J5xdafi6qS462YNH/lbPx4UD1eebLW97VwZ67bcFE7Z
	aQl66ksCI4TkD4iIc3kd2h6/UImlOCPRUIu5qDgRAOgt5y4XAwAA
X-CMS-MailID: 20240125015202epcas5p4a37e2da6aeda3e7f6a46c6d78fa8d182
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240124161121epcas5p1fef1a14624b26cc436b899d9f6cde164
References: <20240124161029.3756075-1-sandeep.cs@samsung.com>
	<CGME20240124161121epcas5p1fef1a14624b26cc436b899d9f6cde164@epcas5p1.samsung.com>
	<20240124161029.3756075-4-sandeep.cs@samsung.com>
	<nycvar.YFH.7.76.2401241917490.29548@cbobk.fhfr.pm>

>On Wed, 24 Jan 2024, Sandeep C S wrote:
>
> Add Support for samsung wireless keyboard with input mapping events.
>
> Device 7021 (Samsung wireless keyboard)
>
> Signed-off-by: Sandeep C S <sandeep.cs@samsung.com>
> Signed-off-by: Junwan Cho <junwan.cho@samsung.com>
> Signed-off-by: Jitender Sajwan <jitender.s21@samsung.com>
> ---
>  drivers/hid/hid-ids.h     |   2 +
>  drivers/hid/hid-samsung.c | 108
> ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 110 insertions(+)
>[ ... snip ... ]
>> +#ifdef CONFIG_HID_KK_UPGRADE
>
>Where is CONFIG_HID_KK_UPGRADE coming from, please? This is the first time
I
>am seeing it, and it's definitely not being introduced by your patchset.

Yes, Please ignore this commit message line. Only our changes are related to
bringing up Samsung driver only.

Thank you



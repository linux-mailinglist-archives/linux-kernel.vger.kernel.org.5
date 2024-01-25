Return-Path: <linux-kernel+bounces-37904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44EAD83B772
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 03:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 691BB1C23B23
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 02:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44BB6FB6;
	Thu, 25 Jan 2024 02:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="XCKp0aO8"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266286ABA
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 02:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706151434; cv=none; b=McOodrJsPi/HdyWxz/h/Acw/Yn0sYzHZGruTAN+4vnSYRbYKwsevLv1ub++uq930ZRUxz21ShYrSdnLcNn0dN9t4moQOWDOpFj5CdiqklMKVKSA/WEugDwJzTwWnNXvsPTBYXPWP1Jgmyf/6pHLfNHVS/lCSAbOTmbBmfQfTQPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706151434; c=relaxed/simple;
	bh=Vt9NFRCVSrMVE+JcDCImJqL3ssdxEuUFAeruHffN2PQ=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=Pn3F2P5L+/RcHy4t1z3ldgYTpDlfXuhmA0fAvqjpLTsrfaPPOgKwSpzw0hhnw0JrMKGJRmw2KkbtSBYlM/aR3UcEa/ZywTgosrMwArylSvKfBdzcYDDere0po8+bujkyyYZiU+YNfKMlMl41aJKlNajq9BV4hXfPSNlfxDDQzd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=XCKp0aO8; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240125025709epoutp038e4f806cc3478cbbaa443a4686ebed89~td6_b_x1h0621806218epoutp03c
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 02:57:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240125025709epoutp038e4f806cc3478cbbaa443a4686ebed89~td6_b_x1h0621806218epoutp03c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1706151430;
	bh=7CgfqBulVHw9QYs0b2+26MG0F5iv8YN4xW+PuYlqVBA=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=XCKp0aO81RLiCMH09wbc5KpapapcXn9S3rToopQX9c492YWPN8noIBurqbWmBI0Ue
	 5kbZdDqLGq1TFFEssaJV8+IvD1NSBwNc9T5NbYyTBifgSMgmQNTk6ymR3wInJ6wTZX
	 CiqM99Hj4+Yrgse096WFAsCVYwnvVCixrU9bo/Uk=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240125025709epcas5p35fb4556c4da39c3f0539de17007a5b4b~td6_Hv_ws0470404704epcas5p38;
	Thu, 25 Jan 2024 02:57:09 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4TL58M6ZvVz4x9Pr; Thu, 25 Jan
	2024 02:57:07 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	9C.0A.09672.30EC1B56; Thu, 25 Jan 2024 11:57:07 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240125025707epcas5p10f31b0ba6412449fa30d07d8914ce376~td68MaW5k2771327713epcas5p1v;
	Thu, 25 Jan 2024 02:57:07 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240125025707epsmtrp207ac9ba33a3cf54a97cf46c8568849fe~td68Ls-5p2574025740epsmtrp2W;
	Thu, 25 Jan 2024 02:57:07 +0000 (GMT)
X-AuditID: b6c32a4b-39fff700000025c8-9b-65b1ce0343c7
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	81.E3.07368.30EC1B56; Thu, 25 Jan 2024 11:57:07 +0900 (KST)
Received: from SRIB7IJ5F5BM8F (unknown [107.99.12.215]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240125025705epsmtip110cbe843938f2548bfd8a1330de904bf~td656jci90127001270epsmtip1H;
	Thu, 25 Jan 2024 02:57:04 +0000 (GMT)
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
Date: Thu, 25 Jan 2024 08:26:56 +0530
Message-ID: <000001da4f3a$2ea1bce0$8be536a0$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGe9MEZUacnBkQWTWlSz6s7q4Y4xAGczTLaA7AsQnoA9RKiFLEueL2g
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPJsWRmVeSWpSXmKPExsWy7bCmhi7zuY2pBkfeG1lcn7KZ1eL2Ak+L
	rUvmslrcOt7KaPHywQZ2i82TH7FY3Pz0jdXi8q45bBaPVmxicuD02LSqk83j/b6rbB59W1Yx
	enzeJBfAEpVtk5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuW
	mQN0ipJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwKRArzgxt7g0L10vL7XEytDA
	wMgUqDAhO+PEph/sBc/YK35P28TWwLiMrYuRk0NCwERizbl+RhBbSGA3o8S+9SxdjFxA9idG
	iUvNv5khnG+MEp2T1jHBdJx5PhMqsZdR4tfqb1AtbxglPi9dCjaXTUBbYsbfa8wgtoiAmsSc
	l/fYQIqYBdqZJC71/WUBSXAKOEicPLgOqIiDQ1ggT+JUhztImEVAVWLtyytMIGFeAUuJ3pMS
	IGFeAUGJkzOfgHUyC8hLbH87hxniIAWJn0+XsUKscpPoubuPDaJGXOLozx6wQyUEFnJI9K1d
	zQjR4CJx+PksqP+FJV4d38IOYUtJfH63lw2ioZtRYuntY+wQzgxGiZadV6HW2Uv8fD2BDeQ6
	ZgFNifW79CG28Un0/n4CdrSEAK9ER5sQRLWKxNOu3aww87+f2AgNRQ+JtTMPME9gVJyF5LdZ
	SH6bheSHWQjLFjCyrGKUTC0ozk1PLTYtMM5LLYdHeHJ+7iZGcErV8t7B+OjBB71DjEwcjIcY
	JTiYlUR4TUw3pgrxpiRWVqUW5ccXleakFh9iNAWG90RmKdHkfGBSzyuJNzSxNDAxMzMzsTQ2
	M1QS533dOjdFSCA9sSQ1OzW1ILUIpo+Jg1Oqgani6WG3VXILds8o28JuuM/3n6mM+45zdpE7
	9ZUtzIMnhYZf+5Nc8ivp/HOTZZkiBZvf3CvZ/WpZ8AKTbSdTLh3XTjtY4vtAv1lV1Nxr0oOy
	n4y32Axt5r94FZ+k4mp2irHshrCX4XV36fUrdldPWp4c//7Cjbd/Hx2zqU4M15FZG8B/aefC
	MPf91w4d2srZMuHrOXuhv4br/nOnvm5f8pjxAYdd1L1H0tmvdshd010n8F3wpIXlh80aKd9v
	5gUdjxXh41JZPfF0aMgp5g/vfSdumrD//EGBaSW8lZX8DY+93tfc5+WfrqQb4cttUvugcJnN
	hI3Tvlxs0vn+Z/+UQxMs/VwWZtgsiZ76Zke44cxUJZbijERDLeai4kQAqPeq1TIEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphkeLIzCtJLcpLzFFi42LZdlhJTpf53MZUgw87xC2uT9nManF7gafF
	1iVzWS1uHW9ltHj5YAO7xebJj1gsbn76xmpxedccNotHKzYxOXB6bFrVyebxft9VNo++LasY
	PT5vkgtgieKySUnNySxLLdK3S+DKOLHpB3vBM/aK39M2sTUwLmPrYuTkkBAwkTjzfCZzFyMX
	h5DAbkaJ3qdbmCASUhKrrt9jhLCFJVb+e84OYgsJvGKUOL42AcRmE9CWmPH3GjOILSKgJjHn
	5T02kEHMAr1MEr+/trJATP3KKPHz1Wqwbk4BB4mTB9cBdXBwCAvkSEw+nAUSZhFQlVj78goT
	SJhXwFKi96QESJhXQFDi5MwnLCBhZgE9ibaNYOcwC8hLbH87hxniNAWJn0+XsUKc4CbRc3cf
	G0SNuMTRnz3MExiFZyGZNAth0iwkk2Yh6VjAyLKKUTK1oDg3PTfZsMAwL7Vcrzgxt7g0L10v
	OT93EyM4orQ0djDem/9P7xAjEwfjIUYJDmYlEV4T042pQrwpiZVVqUX58UWlOanFhxilOViU
	xHkNZ8xOERJITyxJzU5NLUgtgskycXBKNTCJnX9j/eNJl/K6zbKV5pXPAl5s/iD6Q+Xp5Gmf
	ZrXks5bYv962e6HAu/1vK5nSU+/MvcfL6RBnMdtF6uqHjMxIn9WiXK18lpeOyRYZ+F2cVt2y
	4VKrtmWMdtFJL12uvhs7PLf9fvpfXeLkdy4tlw+vC411kp8qCCptP9mlyV3HzKzZdnDmlNVM
	kgH+dREP8l4cZLZe9sKxYkKuVk3cnO5lPcZeR5+XPjSPvFTndoxtj0zs6pqmPQW3J67inKmc
	/YDhd9J37qluRU+ybjzwNglf1pHyramBO+aTGNOSg4fTZY9IVpg7TZra37s7r9dC5cLpcv8C
	1o2Se87LmV2MuqRho7zmizlXjoobd/EREyWW4oxEQy3mouJEAEna1IQXAwAA
X-CMS-MailID: 20240125025707epcas5p10f31b0ba6412449fa30d07d8914ce376
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
> +#ifdef CONFIG_HID_KK_UPGRADE
>
>Where is CONFIG_HID_KK_UPGRADE coming from, please? This is the first time
I
>am seeing it, and it's definitely not being introduced by your patchset.
>
>Thanks,
>
>--
>Jiri Kosina
>SUSE Labs
Hello

Sorry for oversight!
It is custom handling code for keyboard keys in Samsung driver for android
devices. As suggested I will exclude this macro from open source submission.
I will be sending v4 patchsets shortly.

Thank you




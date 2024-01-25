Return-Path: <linux-kernel+bounces-38294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DEFE83BD90
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9C41293C38
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B34C1C6B8;
	Thu, 25 Jan 2024 09:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="UWLsDnM6"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B70E1C6A1
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 09:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706175588; cv=none; b=WLK5isnsBifEs5+S/vmcS4IYmonKKrlcvypt5jVTyQY3bWmn3gXZ87kHvlJ/MiKjcpDfaSZaKdhakg51L+S5gQpBYrGmRp6OQrnp7XUJ594QT/viyDpYVed8qV3lZC2zlIdTfmFKW5Cxp2p8LUvQNSNJeXVJRWm8+cWfhzDCdgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706175588; c=relaxed/simple;
	bh=JOI+zcX0eU7TDfzKPbYEFkYn9lMQXhDbNBiwHCZNCKo=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=j5vZOER0ptYpkp66OjqDXkGajjE90MDlPIawuaG51V0BsbuL3bZxOFctoOGGpxoKHchAXlzHS8Rg478q1IGvSIPE4cuU24BkJoNETgUkdEJJPNjwX1M6kvNktg1CLqxp7Im1pYmKogB7kh/W0Vq9bDciS3l4bHJ0nB7IxwoPV/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=UWLsDnM6; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240125093943epoutp03120f64b53f9b29d2e9b8c565596aa183~tjadVO1Ns0358903589epoutp03Z
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 09:39:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240125093943epoutp03120f64b53f9b29d2e9b8c565596aa183~tjadVO1Ns0358903589epoutp03Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1706175583;
	bh=zvAGKzBS8LDimzML33KfTYxaGvsdGyPeapNzcVhyMhQ=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=UWLsDnM6hwq9+NFupc5Am8TK1Io7ZfvI6ObH3XpAjBoh8gaZgsICbJA0khAv4c6FA
	 pqMTbxd7aLWBBGhfb0PxYN/kgrKJ8stft4vbD36zcC3klKgW/ahmGN3nZZ5sVdXHGa
	 3QVi8EpYA7G1nHLi6OKI3B2csMhO6gdS6YFVHrtE=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240125093943epcas5p48ec182bf765fb5ce6619d05282c7fb0c~tjac1GBlQ3101531015epcas5p4J;
	Thu, 25 Jan 2024 09:39:43 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4TLG4s1vKtz4x9Q1; Thu, 25 Jan
	2024 09:39:41 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	5C.32.10009.D5C22B56; Thu, 25 Jan 2024 18:39:41 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240125093940epcas5p1bac02dd405fee1a0712c2afe33cbe01e~tjaaW7jCY2478224782epcas5p19;
	Thu, 25 Jan 2024 09:39:40 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240125093940epsmtrp135317284db3885419bdce52dd245be3b~tjaaWOs_P2549125491epsmtrp1N;
	Thu, 25 Jan 2024 09:39:40 +0000 (GMT)
X-AuditID: b6c32a4a-261fd70000002719-0a-65b22c5df939
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	75.D1.08817.C5C22B56; Thu, 25 Jan 2024 18:39:40 +0900 (KST)
Received: from SRIB7IJ5F5BM8F (unknown [107.99.12.215]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240125093938epsmtip13f0bbeed74a58f3002794b90706f3973~tjaYJyFyQ1249512495epsmtip1M;
	Thu, 25 Jan 2024 09:39:37 +0000 (GMT)
From: "sandeep.cs" <sandeep.cs@samsung.com>
To: "'Jiri Kosina'" <jikos@kernel.org>
Cc: "'Benjamin Tissoires'" <benjamin.tissoires@redhat.com>,
	<gaudium.lee@samsung.com>, <ih0923.kim@samsung.com>,
	<suhyun_.kim@samsung.com>, <jitender.s21@samsung.com>,
	<junwan.cho@samsung.com>, <linux-input@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
In-Reply-To: <nycvar.YFH.7.76.2401250923470.29548@cbobk.fhfr.pm>
Subject: RE: [HID Patchsets for Samsung driver v4 0/6] Patchsets for Samsung
 driver
Date: Thu, 25 Jan 2024 15:09:32 +0530
Message-ID: <00e801da4f72$6af09a30$40d1ce90$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQG71ZYHDSo7klI8yRjbxR4VXkJ00AEikOmwASboUR2xFOcgwA==
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAJsWRmVeSWpSXmKPExsWy7bCmpm6szqZUg9tX2S2uT9nManF7gafF
	1iVzWS1uHW9ltHj5YAO7xebJj1gsbn76xmpxedccNotHKzYxOXB6bFrVyebxft9VNo++LasY
	PT5vkgtgicq2yUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXL
	zAE6RUmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYFKgV5yYW1yal66Xl1piZWhg
	YGQKVJiQndG2r4+9YC1XxYpmjwbGWRxdjJwcEgImEku3tDN1MXJxCAnsZpRof3iEGcL5xChx
	9PlpdgjnG6PExblLgco4wFpW7gmHiO9llNi8oAeq4w2jxJZ5yxlB5rIJaEvM+HuNGcQWEVCT
	mPPyHhtIEbNAO5PEpb6/LCAJTgEHib55/5hAbGGBUIm+uVvBbBYBVYmNc06wgti8ApYSk7b0
	skPYghInZz4B62UWkJfY/nYOM8QTChI/ny5jhVjmJNH/fjErRI24xNGfENdJCCzkkPg0bw87
	RIOLxPeHXawQtrDEq+NboOJSEi/729ghGroZJZbePgblzGCUaNl5FWqdvcTP1xPYQIHBLKAp
	sX6XPsQ2Pone30+gYcQr0dEmBFGtIvG0azcrzPzvJzYyQdgeEhO+HGCbwKg4C8lvs5D8NgvJ
	D7MQli1gZFnFKJlaUJybnlpsWmCUl1oOj/Hk/NxNjOCkquW1g/Hhgw96hxiZOBgPMUpwMCuJ
	8JqYbkwV4k1JrKxKLcqPLyrNSS0+xGgKDPCJzFKiyfnAtJ5XEm9oYmlgYmZmZmJpbGaoJM77
	unVuipBAemJJanZqakFqEUwfEwenVAPTzsW3v6p3V8z53V4e/8f86JIGFpU7Ma+8ftYnz51X
	yee+WLvn+g9b5fbarXHi6o+2RVTUm3k7LHTzVtF5XlUWK8W0Uzl4VfG7PNZFn1c5vlm2NSHZ
	PtDm7zYG42MebQKHek0r1nzWi4rflcLsu97CZUp5Qcf/d08S4uYoS/4TeqGu6XPqFvuF9Jk/
	DqvLTDjiMPPYg98zZ85kux96pVg2Z4no4voPe7n/yZ/kOsFUf/2nUqJebs7Btcenm/Zs3aox
	f+saJ/YXYl+u30h6+eip3re8714VOQ3v31Smn85uPGLdzaZTt+NPx4PPxeun3n/8sIg9oldT
	2S2vRuaEZb+dSpXtbOHvPxfO2CpgmFGtxFKckWioxVxUnAgAIYU57DMEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmkeLIzCtJLcpLzFFi42LZdlhJTjdGZ1Oqwcan4hbXp2xmtbi9wNNi
	65K5rBa3jrcyWrx8sIHdYvPkRywWNz99Y7W4vGsOm8WjFZuYHDg9Nq3qZPN4v+8qm0ffllWM
	Hp83yQWwRHHZpKTmZJalFunbJXBltO3rYy9Yy1WxotmjgXEWRxcjB4eEgInEyj3hXYxcHEIC
	uxklGhf+YO1i5ASKS0msun6PEcIWllj57zk7RNErRok1q2exgSTYBLQlZvy9xgxiiwioScx5
	eY8NpIhZoJdJ4vfXVhaQhJDAYUaJkyvAbE4BB4m+ef+YQDYLCwRL3G/2BgmzCKhKbJxzAmwx
	r4ClxKQtvewQtqDEyZlPWEDKmQX0JNo2gt3DLCAvsf3tHGaI2xQkfj5dxgpxgpNE//vFrBA1
	4hJHf/YwT2AUnoVk0iyESbOQTJqFpGMBI8sqRsnUguLc9NxiwwKjvNRyveLE3OLSvHS95Pzc
	TYzgeNLS2sG4Z9UHvUOMTByMhxglOJiVRHhNTDemCvGmJFZWpRblxxeV5qQWH2KU5mBREuf9
	9ro3RUggPbEkNTs1tSC1CCbLxMEp1cDk3TSDY6+OXdLBQ0Yrvxw4ZZm/hPH4utlXOr6tNIrW
	kX4csbBLPL1t7pIPyovS3jJarrEK5GS9udPkjuiBC69f2pdK2n7j0W+/VFo+5Ujwwkh1t5lF
	l5+e2fKf5YXqu60mIUmMLdWbN/XZHs7tDJz3WF+g9uJFd9ErNtv9tx084h1SsuPltvpPMVMm
	Wt/vkw7vdL784YpSQqjLv4jHG89amBzzjD37by7H4gNbug/WcMRxsXwv7j1u9cSixHYR59ai
	zoA3s2dw3254dibUVF94pvzUkzu2rWU8MH1J6LRbrtMUdn9/sOUdh6X17LKbGVOS7jT1lu21
	XvpjQSWDXRN35bot6wz1FocbuuTVet4WVWIpzkg01GIuKk4EALphHY0WAwAA
X-CMS-MailID: 20240125093940epcas5p1bac02dd405fee1a0712c2afe33cbe01e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240125043646epcas5p1d599fecff0fc37926295fc5260a80682
References: <CGME20240125043646epcas5p1d599fecff0fc37926295fc5260a80682@epcas5p1.samsung.com>
	<20240125043630.4031634-1-sandeep.cs@samsung.com>
	<nycvar.YFH.7.76.2401250923470.29548@cbobk.fhfr.pm>

>> Dear Jiri & Team,
>>
>> I hope this email finds you well.  As per the review comments given by
>> Mr. Jiri and Mr. Joe Perches in our last converstaion over mail. We
>> have incorporated the feedback on our driver. Please check this set of
>> series and help us to improve samsung driver.
>>
>> As of today, Opensource kernel Samsung driver only supports USB HID
>> devices and do not have support for Bluetooth HID devices. Samsung
>> would like to improve the samsung driver and extend it's support for
>> bluetooth devices as well.
>>
>> Summary of changes in Samsung driver:
>>  1. Add support for below bluetooth devices
>>
>> 	Samsung wireless Keyboard
>> 	Samsung wireless GamePad
>> 	Samsung Wireless Action Mouse
>> 	Samsung Wireless Book Cover
>> 	Samsung Wireless Universal Keyboard
>> 	Samsung Wireless HOGP Keyboard
>>  2. Add support for Special key processing on each of the above devices.
>
>I have updated the changelogs so that they are up to the subsystem
standards
>(please check the git tree and try to adhere to similar format for your
next
>submissions), and applied, thanks for the patches!

Thank you for accepting our changes and for your feedback.
We will make sure to adhere to the subsystem standard for future
submissions.

Thanks & regards
Sandeep C S




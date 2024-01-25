Return-Path: <linux-kernel+bounces-38307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC84E83BDA5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 461721F22F06
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF031D559;
	Thu, 25 Jan 2024 09:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bLGFkM6F"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB851D539
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 09:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706175733; cv=none; b=AQ1FQMT/BegZzt+6zE0Ev46d4HRFIEDFjb97gfLw0G1MCY+s2TYrOmchJj7GQED5b175hI5VC87o+UB2PIILkVhI69MdT5cpRedGhPj74ceCJcJgJU9Wt+/1nTbKm6U/N6ieiAKkzzl1coI/wdXcnV7+dui4yoSx8Fh2rGDrOF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706175733; c=relaxed/simple;
	bh=eT43wtKl6e6FvTP6lY+dWa3AIZ/11gmMHaJ7gcmvuqk=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=XiDCc0QfjMUI5rANMS9elAY0JQRCJQbKElEXQAv7DPI4BseainAcbFYnUSn7DaSYB5t2xFk6uqxG67KYWcVaFNyLkl7K2Feva9JNq1e1MjrzI9EUsNExDVEf9lYaijDvNGooImhl+6V8gbyXZ0VjcLptA9qy6oT7LmAw2h6TbLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=bLGFkM6F; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240125094209epoutp03478a30a7fa6b55eeb1647afac3e7e216~tjclEOVnv0426404264epoutp037
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 09:42:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240125094209epoutp03478a30a7fa6b55eeb1647afac3e7e216~tjclEOVnv0426404264epoutp037
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1706175729;
	bh=2R+tw7jgF81CC0IJ7T7AV14nd84XzK1YT63rEPbefzM=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=bLGFkM6FjqSyw8oQEt6vh2nu6UeRkw9vzoDIiHLaE+bQHIuZuVvSFJWo0nrsPZu1u
	 H9RI+YO0t3oeiMnNNtYr6CyCn15MqO4mlrI8fCprqtgzhRVRsbLSWZpMVQ4XF/45gH
	 rvRDzDkDxcwB9bqr7bkmIvGI1gkbkuSjoJDmhBec=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240125094208epcas5p154ae8b0d909e8dfd3aed0f5cdece1d92~tjckoYfcM1775817758epcas5p1k;
	Thu, 25 Jan 2024 09:42:08 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.178]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4TLG7g0nVBz4x9Px; Thu, 25 Jan
	2024 09:42:07 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	06.99.09634.EEC22B56; Thu, 25 Jan 2024 18:42:07 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240125094206epcas5p3c377fd4b913d152a560b3bb40907af51~tjciSWKoK2358323583epcas5p39;
	Thu, 25 Jan 2024 09:42:06 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240125094206epsmtrp1ae0b84ffba5c772b65dc0fc0f3849b78~tjciRnaWN2683026830epsmtrp1N;
	Thu, 25 Jan 2024 09:42:06 +0000 (GMT)
X-AuditID: b6c32a49-eebff700000025a2-30-65b22cee1846
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	00.02.08817.EEC22B56; Thu, 25 Jan 2024 18:42:06 +0900 (KST)
Received: from SRIB7IJ5F5BM8F (unknown [107.99.12.215]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240125094204epsmtip28bfbb067f1fc793d3db3e788a3b79cc8~tjcgDl5SK1333313333epsmtip2a;
	Thu, 25 Jan 2024 09:42:03 +0000 (GMT)
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
Date: Thu, 25 Jan 2024 15:11:57 +0530
Message-ID: <012901da4f72$c1ec8420$45c58c60$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQG71ZYHDSo7klI8yRjbxR4VXkJ00AEikOmwASboUR2xFO1QAA==
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEJsWRmVeSWpSXmKPExsWy7bCmuu57nU2pBo+nMlpcn7KZ1eL2Ak+L
	rUvmslrcOt7KaPHywQZ2i82TH7FY3Pz0jdXi8q45bBaPVmxicuD02LSqk83j/b6rbB59W1Yx
	enzeJBfAEpVtk5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuW
	mQN0ipJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwKRArzgxt7g0L10vL7XEytDA
	wMgUqDAhO2PhtPVsBQ+4Ko6eWs3UwLiHo4uRk0NCwERi969V7F2MXBxCArsZJQ6fe8oE4Xxi
	lLjdfokNwvnGKPG9oZEZpmVm/0FGiMReRomuK3Ogqt4wSly7vZYdpIpNQFtixt9rYB0iAmoS
	c17eAytiFmhnkrjU95cFJMEp4CDRN+8fE4gtLBAq0Td3K5jNIqAq8X3RZbAaXgFLicdL/zNB
	2IISJ2c+AYszC8hLbH87B+okBYmfT5exQixzkrh//wszRI24xNGfPcwgiyUEFnJIzPl+hBWi
	wUXiyee3jBC2sMSr41vYIWwpiZf9bewQDd2MEktvH4NyZjBKtOy8CrXOXuLn6wlA/3AArdCU
	WL9LH2Ibn0Tv7ydMIGEJAV6JjjYhiGoViaddu1lh5n8/sZEJwvaQmPDlANsERsVZSH6bheS3
	WUh+mIWwbAEjyypGydSC4tz01GLTAsO81HJ4nCfn525iBCdWLc8djHcffNA7xMjEwXiIUYKD
	WUmE18R0Y6oQb0piZVVqUX58UWlOavEhRlNggE9klhJNzgem9rySeEMTSwMTMzMzE0tjM0Ml
	cd7XrXNThATSE0tSs1NTC1KLYPqYODilGpjCghyWfc00EnDZp8e8R2dKuaPL0ocrrXbeK7i2
	84hCU/8/j93/Cj5Lu/yy0Z+03i3Oe+Vlsa+p6ksu7A9lOLY98ISqdxM/Y1rtqhtz1kwIiFl3
	Qe5obqiEmFz5Prn5u2sF1qklZOuxmj3NOeu9On6d+AbryEPpk9+8Ego+Y5D28lFBgX3jo6dz
	ZT+3fm4JuvVxwdXSjE3PnUxyDT5fSrlkKP4jpmddz7+V4m4yHr9971RI3NN6n/3rR3XsrvCU
	iJ1VR9Y9uflxzhHX05q5h8taTbT6p9j868zcavsxWCytv9A574OBkEScWtvPopLi/imHzgaI
	Lejc9/y/phPvQ/FNSSsUVnU13Yu0WmzI91CJpTgj0VCLuag4EQCgjW7+NQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphkeLIzCtJLcpLzFFi42LZdlhJXvedzqZUg9PzhC2uT9nManF7gafF
	1iVzWS1uHW9ltHj5YAO7xebJj1gsbn76xmpxedccNotHKzYxOXB6bFrVyebxft9VNo++LasY
	PT5vkgtgieKySUnNySxLLdK3S+DKWDhtPVvBA66Ko6dWMzUw7uHoYuTkkBAwkZjZf5Cxi5GL
	Q0hgN6PE0WeTmCASUhKrrt9jhLCFJVb+e84OYgsJvGKUaFttCWKzCWhLzPh7jRnEFhFQk5jz
	8h4byCBmgV4mid9fW1kgGg4zSpxcAWZzCjhI9M37B7SAg0NYIFjifrM3SJhFQFXi+6LLYCW8
	ApYSj5f+Z4KwBSVOznzCAlLOLKAn0bYR7BxmAXmJ7W/nMEOcpiDx8+kyVogTnCTu3//CDFEj
	LnH0Zw/zBEbhWUgmzUKYNAvJpFlIOhYwsqxilEwtKM5Nzy02LDDKSy3XK07MLS7NS9dLzs/d
	xAiOKC2tHYx7Vn3QO8TIxMF4iFGCg1lJhNfEdGOqEG9KYmVValF+fFFpTmrxIUZpDhYlcd5v
	r3tThATSE0tSs1NTC1KLYLJMHJxSDUznz71/xhwu8UbJKm1TaJdAwmxr9u1y1sw2e7WlH2Tp
	Htr5WY1rR72R2TPdV+5Pb19f3lCSbhr5UsCTZ+9B28LGHSIOBf8aZjInC8ltMlHZ/O9QnFfD
	LuOWzmuW1+a+nKE06eSe89EOZzbJK73jF1FYNHXpJysnT1uGjU6PV3CGFYq6Xb1hKFt8Y9YV
	9V/T4vY9cvV68NLv8kspxyuV3LZf5p6XSFOOSlZnvsQ5nSO/tP28yz2zlLKvfwrayjjKu6r5
	b2usF1o9+ebuZy8cpgR9ERDfNi3egnN1pYrLpv19sxX2x/9v3cWZcfFYV+DM4LXLPJ57FYtt
	i7mgcWuWzMUtVy5qSYmqsX5h6nV7IKfEUpyRaKjFXFScCAAcVpOAFwMAAA==
X-CMS-MailID: 20240125094206epcas5p3c377fd4b913d152a560b3bb40907af51
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240125043646epcas5p1d599fecff0fc37926295fc5260a80682
References: <CGME20240125043646epcas5p1d599fecff0fc37926295fc5260a80682@epcas5p1.samsung.com>
	<20240125043630.4031634-1-sandeep.cs@samsung.com>
	<nycvar.YFH.7.76.2401250923470.29548@cbobk.fhfr.pm>

>On Thu, 25 Jan 2024, Sandeep C S wrote:
>
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
>
>--
>Jiri Kosina
>SUSE Labs

Thank you for accepting our changes! We will make sure follow the same
format for future submissions as well.

Thanks & regards
Sandeep C S




Return-Path: <linux-kernel+bounces-37945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EEA83B8AA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 05:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7754B23F45
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 04:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0D479C7;
	Thu, 25 Jan 2024 04:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="DrS4LsMj"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE3D5C9A
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 04:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706157414; cv=none; b=Ux7fpaqAFjH4ep6b1FT9g1m3nI3t66IJXLJdp1ygUXhQnWhqpl8xyvTkYhvLTfj8EhboKTfXMVDuluEuLE3AXFsU8yirKEQS9ocwgI4VBRJIaVIx77IxTz3ZphHee5HJ9B1GYhBXH6sd4kLlJxeuo2KIs8crzIuU+49JZjEFljQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706157414; c=relaxed/simple;
	bh=Zy1RNmQ2x2cYdlG3Q7Lg8TXlMRrqauk88bjeoh0TSCI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=QHbLIKiTSjtuyHqxOVDh888TMuIQDlX9LxVZuUHVB23MCfeGC16n87kkm3+c3u3nwfagj/Oypqd8XDH0wyMsM2WUvi1EFNwZNnrI4B+eBTvN4TCsoEFifeOFZYG0ie2tPvSAK/whSzc0a2oAKWGDnNdAqkKndGuh4+0yC+lndYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=DrS4LsMj; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240125043649epoutp02e110355674584a742dbc96b712a0557a~tfR-FkDnd2166321663epoutp02x
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 04:36:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240125043649epoutp02e110355674584a742dbc96b712a0557a~tfR-FkDnd2166321663epoutp02x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1706157409;
	bh=eJ4BGTrLthw9JuP9hMz/zGXMowvjVifjkq3OqF8LMrs=;
	h=From:To:Cc:Subject:Date:References:From;
	b=DrS4LsMjTsdo1Y/HwErgJ2pocHCR9Od+XzQPdvCp8v0dm+nwmkq7dNWF1Uqmy8ol9
	 +L+Dyf96aHnvz5SlWhNtbAnFd1khjeQCn+1eVoc1ilK0TOpdAg0dja0/5t4DEQX8Ac
	 GZtJe9SY7rPFhUELh6rRRaGhp69a5YfWBuybg/YM=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240125043648epcas5p4802bd7f8fdd75118e040486f5b870ee1~tfR_mO_3T0239802398epcas5p4S;
	Thu, 25 Jan 2024 04:36:48 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4TL7MM0ZrGz4x9Q9; Thu, 25 Jan
	2024 04:36:47 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	19.B6.09634.E55E1B56; Thu, 25 Jan 2024 13:36:47 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240125043646epcas5p1d599fecff0fc37926295fc5260a80682~tfR8kWoy00581105811epcas5p1z;
	Thu, 25 Jan 2024 04:36:46 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240125043646epsmtrp1c8c5657b133970dd184d6401d11024f8~tfR8jsdLD1583715837epsmtrp1y;
	Thu, 25 Jan 2024 04:36:46 +0000 (GMT)
X-AuditID: b6c32a49-159fd700000025a2-23-65b1e55e4b67
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	B3.DB.18939.E55E1B56; Thu, 25 Jan 2024 13:36:46 +0900 (KST)
Received: from ws2030077324.sa.corp.samsungelectronics.net (unknown
	[107.99.237.91]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240125043644epsmtip2c5f96a69fa05bbc7a1c1d0cd578caeae~tfR7DXYbL1132311323epsmtip2A;
	Thu, 25 Jan 2024 04:36:44 +0000 (GMT)
From: Sandeep C S <sandeep.cs@samsung.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires
	<benjamin.tissoires@redhat.com>
Cc: gaudium.lee@samsung.com, ih0923.kim@samsung.com,
	suhyun_.kim@samsung.com, jitender.s21@samsung.com, junwan.cho@samsung.com,
	sandeep.cs@samsung.com, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [HID Patchsets for Samsung driver v4 0/6] Patchsets for Samsung
 driver
Date: Thu, 25 Jan 2024 10:06:23 +0530
Message-Id: <20240125043630.4031634-1-sandeep.cs@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgk+LIzCtJLcpLzFFi42LZdlhTQzf+6cZUg6kdjBbXp2xmtbi9wNNi
	65K5rBa3jrcyWrx8sIHdYvPkRywWNz99Y7W4vGsOm0X77GeMFo9WbGJy4PLYtKqTzeP9vqts
	Hn1bVjF6fN4kF8ASlW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk
	4hOg65aZA3SPkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafApECvODG3uDQvXS8v
	tcTK0MDAyBSoMCE749aG++wFrwQrbp7ybWCczNfFyMkhIWAiMWNiJ2sXIxeHkMBuRomdDe+Z
	IZxPjBJPHl1ngnP2bu5igWm5NH8PG0RiJ6PE62vrWUESQgKdTBJ7TxmD2GwCWhJ9R74zgdgi
	AhES7xZsYgSxmQWuM0o8eBgIYgsLBErc62oG62URUJWY9usy2AJeAVuJw0/fM0Esk5fYf/As
	M0RcUOLkzCcsEHPkJZq3zgY7VULgFrvE354XrBANLhKrLl1ghLCFJV4d38IOYUtJvOxvY4do
	6GaUWHr7GJQzg1GiZedVZogqe4mfrycA/cYBtEJTYv0ufYhtfBK9v58wgYQlBHglOtqEIKpV
	JJ527WaFmf/9xEaooz0kJnw5wAYJlFiJPQ9Osk5glJuF5IdZSH6YhbBsASPzKkbJ1ILi3PTU
	YtMCw7zUcnhkJufnbmIEJ0Utzx2Mdx980DvEyMTBeIhRgoNZSYTXxHRjqhBvSmJlVWpRfnxR
	aU5q8SFGU2DATmSWEk3OB6blvJJ4QxNLAxMzMzMTS2MzQyVx3tetc1OEBNITS1KzU1MLUotg
	+pg4OKUamPgkD8xfoyLXOvnWtwy7AJtXZwTnLnnbXufPdfRwksdUVqvkTTezdM7E6fXY60/M
	sDrR3bOW4Ufaby3XH1WKPL1L5y2tfJcf2xB5R3CLwNeKHeKmZysP8zcL6Vaeucb7kk9Zh+mm
	39eMM7Zi1/fNerT2iNK5oDMcF6ptUhz2a3A2nPt2f3lE2WGfJ3vjYtIEWR0aOyq1e7Ln/anw
	8I7nCdnNOe20x4PVeRb9ohkhro6rw86samD6u0Lf0egU46ct341Yvq/PivpqPafzx7w1yrOm
	BVUohSza2X7i/OcMy6AVt4NuqxX7vOlfnthetVqR12aa0aI8nsAJOzzCfF3/u5+XdHkxvUjQ
	eu2cUz/uKrEUZyQaajEXFScCAMD8xFMTBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMLMWRmVeSWpSXmKPExsWy7bCSvG7c042pBo9vSFpcn7KZ1eL2Ak+L
	rUvmslrcOt7KaPHywQZ2i82TH7FY3Pz0jdXi8q45bBbts58xWjxasYnJgctj06pONo/3+66y
	efRtWcXo8XmTXABLFJdNSmpOZllqkb5dAlfGrQ332QteCVbcPOXbwDiZr4uRk0NCwETi0vw9
	bF2MXBxCAtsZJc5dPMoKkZCSWHX9HiOELSyx8t9zdhBbSKCdSeL8oyAQm01AS6LvyHcmEFtE
	IEJi2r+1jCCDmAXuM0ps3X+VDSQhLOAvsXjvdmYQm0VAVWLar8ssIDavgK3E4afvmSAWyEvs
	P3iWGSIuKHFy5hOwGmagePPW2cwTGPlmIUnNQpJawMi0ilE0taA4Nz03ucBQrzgxt7g0L10v
	OT93EyM4XLWCdjAuW/9X7xAjEwfjIUYJDmYlEV4T042pQrwpiZVVqUX58UWlOanFhxilOViU
	xHmVczpThATSE0tSs1NTC1KLYLJMHJxSDUwWTnErBCYqhjC+OBge2KfvdM1WWodv6+dVK8ue
	vF7Ou8A/ZseVnMnsmuLWn4+tVerYx8/0t/2Ef+/Jk/y9vq6hTle2eU5+zS9iFvhMNsi90+65
	bXSkAXu19IOjMVwvRfi/RXSscrTfmniSM/j0X+49Aom5f807Qm3vs3bfn7vOwcVTpVLWdofv
	wk/zTnHd+rR58/udWl+Sz6cV/L24N/p13NTiSwdcF8x/6GuusXUpS+H6mE9LJsRYrGzeKCx+
	W9Av/mZvjHHOqw3/VEPi+OSkdrmnLbJR/xghIvblDc8KH1aVq1eCrB7oSjuXSfmc490b0uCy
	9c7VwpPzNss1bNl60qu22V5t/o7ybW+jFimxFGckGmoxFxUnAgCuEqb6xgIAAA==
X-CMS-MailID: 20240125043646epcas5p1d599fecff0fc37926295fc5260a80682
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240125043646epcas5p1d599fecff0fc37926295fc5260a80682
References: <CGME20240125043646epcas5p1d599fecff0fc37926295fc5260a80682@epcas5p1.samsung.com>

Dear Jiri & Team,

I hope this email finds you well.  
As per the review comments given by Mr. Jiri and Mr. Joe Perches in our last converstaion over mail.
We have incorporated the feedback on our driver. Please check this set of series and help us to improve samsung driver.

As of today, Opensource kernel Samsung driver only supports USB HID devices and do not have support for Bluetooth HID devices. 
Samsung would like to improve the samsung driver and extend it's support for bluetooth devices as well.

Summary of changes in Samsung driver:
 1. Add support for below bluetooth devices

	Samsung wireless Keyboard
	Samsung wireless GamePad
	Samsung Wireless Action Mouse
	Samsung Wireless Book Cover
	Samsung Wireless Universal Keyboard
	Samsung Wireless HOGP Keyboard
 2. Add support for Special key processing on each of the above devices.
 
 Patch Series Overview:
--------------------------------------

[Patch 1/6]

HID Samsung : Broaden device compatibility in samsung driver.

hid_is_usb() check being moved.

[Patch 2/6]

HID: Samsung : Fix the checkpatch complain.

Warning found by checkpatch.pl script.

[Patch 3/6]

HID: Samsung : Add Samsung wireless keyboard support.

[Patch 4/6]

HID: Samsung : Add Samsung wireless gamepad support.

[Patch 5/6]

HID: Samsung : Add Samsung wireless action mouse support.

[Patch 6/6]

HID: Samsung : Add Samsung wireless bookcover and universal keyboard support.



All these changes have been verified and tested thoroughly in android devices.
Please accept our changes.


Thanks for your time and consideration.

Best regards
Sandeep C S

Sandeep C S (6):
  HID Samsung : Broaden device compatibility in samsung driver.
  HID: Samsung : Fix the checkpatch complain. Rewritten code using
    memcmp where applicable.
  HID: Samsung : Add Samsung wireless keyboard support.
  HID: Samsung : Add Samsung wireless gamepad support.
  HID: Samsung : Add Samsung wireless action mouse support.
  HID: Samsung : Add Samsung wireless bookcover and universal keyboard
    support.

 drivers/hid/hid-ids.h     |   7 +
 drivers/hid/hid-samsung.c | 437 ++++++++++++++++++++++++++++++++++----
 2 files changed, 408 insertions(+), 36 deletions(-)

-- 
2.34.1



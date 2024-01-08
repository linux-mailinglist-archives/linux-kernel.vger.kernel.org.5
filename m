Return-Path: <linux-kernel+bounces-19262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 996FC826A86
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 866391C21D05
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D4611C86;
	Mon,  8 Jan 2024 09:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="OvOfZUsr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8511170D
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 09:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240108091953epoutp022fe145d7ba1404913c886300f5d09f41~oVLSruHNJ3250532505epoutp02L
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 09:19:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240108091953epoutp022fe145d7ba1404913c886300f5d09f41~oVLSruHNJ3250532505epoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1704705593;
	bh=DCnvP1lmXsDpM4Hfqr1hGIcorRE5QrQ7+TOwrmRcZyA=;
	h=From:To:Cc:Subject:Date:References:From;
	b=OvOfZUsrQ8hSe++uw5rEYxHorgqJ8Z2LcrlDXayQbH+DKVjMWFi0xK2dZeszfpH03
	 cGRVKJaONOyfgRNqyawlBppYUebQuR/DfR9lGAdLW3Uie9LO/9eptAYxJheOuBtOYG
	 1D/Dke2Rid1MIu45zlI1cyo0J0m4zXtEC7SIq53A=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240108091952epcas5p3a3b09055393947e7ddee865ccfc5bcc7~oVLRP-6Nj0528705287epcas5p3G;
	Mon,  8 Jan 2024 09:19:52 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4T7pRp57wVz4x9Pt; Mon,  8 Jan
	2024 09:19:50 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	5B.96.08567.63EBB956; Mon,  8 Jan 2024 18:19:50 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240108091950epcas5p41633efaf7b62db312982aa2f94a26db3~oVLPMDo550569705697epcas5p4o;
	Mon,  8 Jan 2024 09:19:50 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240108091950epsmtrp1a6100d247e0c9107e8a6835164eaab1c~oVLPLICAM1886118861epsmtrp1d;
	Mon,  8 Jan 2024 09:19:50 +0000 (GMT)
X-AuditID: b6c32a44-3abff70000002177-82-659bbe362919
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	52.47.08755.63EBB956; Mon,  8 Jan 2024 18:19:50 +0900 (KST)
Received: from ws2030077324.sa.corp.samsungelectronics.net (unknown
	[107.99.237.91]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240108091948epsmtip23633e5ca381fe0f4579ba425a7176231~oVLNwVfYs2115021150epsmtip2T;
	Mon,  8 Jan 2024 09:19:48 +0000 (GMT)
From: Sandeep C S <sandeep.cs@samsung.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires
	<benjamin.tissoires@redhat.com>
Cc: gaudium.lee@samsung.com, ih0923.kim@samsung.com,
	suhyun_.kim@samsung.com, jitender.s21@samsung.com, junwan.cho@samsung.com,
	sandeep.cs@samsung.com, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [HID Patchsets for Samsung driver v2 0/6] HID Support for Samsung
 driver
Date: Mon,  8 Jan 2024 14:49:10 +0530
Message-Id: <20240108091917.1552013-1-sandeep.cs@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgk+LIzCtJLcpLzFFi42LZdlhTU9ds3+xUg4YbyhbXp2xmtbi9wNNi
	65K5rBa3jrcyWrx8sIHdYvPkRywWNz99Y7W4vGsOm0X77GeMFo9WbGJy4PLYtKqTzeP9vqts
	Hn1bVjF6fN4kF8ASlW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk
	4hOg65aZA3SPkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafApECvODG3uDQvXS8v
	tcTK0MDAyBSoMCE749vpE8wF2wQrWndOZmlgfMnbxcjJISFgIvHvzCTGLkYuDiGB3YwSXUsf
	MUE4nxglth87ywRSJSTwjVHiWYs7TMfiiWdZIYr2Mkr8a5jLDOF0Mkn8//CDGaSKTUBLou/I
	d7BuEYEIiXcLNjGC2MwC1xklHjwMBLGFBYIlrt66xgJiswioSnxc9Resl1fAVuLt05dMENvk
	JfYfPAsVF5Q4OfMJC8QceYnmrbPBFksI3GOXWDTtO5DDAeS4SKzZbgPRKyzx6vgWdghbSuJl
	fxs7RH03o8TS28egnBmMEi07rzJDVNlL/Hw9gQ1kELOApsT6XfoQy/gken8/YYKYzyvR0SYE
	Ua0i8bRrNyvM/O8nNkLd7CFx7MwORkjIxUr8vv6aaQKj3CwkL8xC8sIshGULGJlXMUqmFhTn
	pqcmmxYY5qWWwyMzOT93EyM4KWq57GC8Mf+f3iFGJg7GQ4wSHMxKIrySM2anCvGmJFZWpRbl
	xxeV5qQWH2I0BYbrRGYp0eR8YFrOK4k3NLE0MDEzMzOxNDYzVBLnfd06N0VIID2xJDU7NbUg
	tQimj4mDU6qBqcLM/pBy6YFm2Yed2oerLvFzHm2bxmEx9/fDCuHZBc/aolrfChrtfyZ+KVLl
	y3dhJ6OMCQ2ORywbfl10cUlg5DFyv6osWXFwEdMJj5MvNn2aer9ZOLxktebn6t49+95f5fas
	Va8xmL9/l9XpDQ+EjPxyXpz+m5qwb+m5XS+CDqjsZT4mc/NWms8WFSYzyw9b93fcMb7x8+2p
	H9v+3uuIdukPeuMy677Shm+8s/4fy1FeerIy2dC3/Y/LX4n+h5uz3Kdlz9Zt2iizeUKA7MXE
	zKUnls0xnK1ybXtN2m4FpQ0PmY6wthxaIyx1uomz7d9vvnvumaqsC419ag6cyrW5/YU1W0lc
	R8ykq0Jjx9Inc5RYijMSDbWYi4oTAYVziyATBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJLMWRmVeSWpSXmKPExsWy7bCSvK7ZvtmpBlMOslpcn7KZ1eL2Ak+L
	rUvmslrcOt7KaPHywQZ2i82TH7FY3Pz0jdXi8q45bBbts58xWjxasYnJgctj06pONo/3+66y
	efRtWcXo8XmTXABLFJdNSmpOZllqkb5dAlfGt9MnmAu2CVa07pzM0sD4kreLkZNDQsBEYvHE
	s6xdjFwcQgK7GSXOLt7HCJGQklh1/R6ULSyx8t9zdoiidiaJ/gNbmEESbAJaEn1HvjOB2CIC
	ERLT/q1lBCliFrjPKLF1/1U2kISwQKDEhQkrWUBsFgFViY+r/oI18wrYSrx9+pIJYoO8xP6D
	Z6HighInZz4Bq2cGijdvnc08gZFvFpLULCSpBYxMqxglUwuKc9Nziw0LDPNSy/WKE3OLS/PS
	9ZLzczcxgkNXS3MH4/ZVH/QOMTJxMB5ilOBgVhLhlZwxO1WINyWxsiq1KD++qDQntfgQozQH
	i5I4r/iL3hQhgfTEktTs1NSC1CKYLBMHp1QDU7jKn59vLFr1X9neu9dzIE/l6G0xdnXn6Yad
	TQdM77Vta3rOXarfJVbnYXHgmPSyusDZc3iN9z8O22HmPfvyhQ8T/l06dpQ/tWfe39gF/Sau
	3nPP5C1gPfziaecj39z+Tq8/XX6zc6efzNtjOWPThK8/IkWPX4qS/rM+7sir8wnC2eHT9ZW/
	GTJNntWz/ba585Oki11veO+fYjvkGqUlumuKT9rvO3U2IR+Tt+6JzpR/Ka2eVpDz3t/ggGF0
	Ektb0Edp7/Q1Khu/flvNeUxu7Vr7ysk2b+1qDyg4Bv47GjLd/tLW2fPPT37xL3PHt8u2VyIS
	N4YpSLzyNY8QNsues+9u9DqLyfuFlji+K9h/rFeJpTgj0VCLuag4EQBG3yPczAIAAA==
X-CMS-MailID: 20240108091950epcas5p41633efaf7b62db312982aa2f94a26db3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240108091950epcas5p41633efaf7b62db312982aa2f94a26db3
References: <CGME20240108091950epcas5p41633efaf7b62db312982aa2f94a26db3@epcas5p4.samsung.com>

Dear All,

I hope this email finds you well.  
As per your review comments give by Mr. Benjamin Tissoires in our last converstaion over mail.

We refactored series with :
1. hid_is_usb() check being moved
2. fix the checkpatch complain
3+ Added bluetooth device support


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


Thanks for your time and consideration

Best regards
Sandeep C S

Sandeep C S (6):
  HID Samsung : Broaden device compatibility in samsung driver.
  HID: Samsung : Fix the checkpatch complain.
  HID: Samsung : Add Samsung wireless keyboard support.
  HID: Samsung : Add Samsung wireless gamepad support.
  HID: Samsung : Add Samsung wireless action mouse support.
  HID: Samsung : Add Samsung wireless bookcover and universal keyboard
    support.

 drivers/hid/hid-ids.h     |   7 +
 drivers/hid/hid-samsung.c | 440 +++++++++++++++++++++++++++++++++++---
 2 files changed, 423 insertions(+), 24 deletions(-)

-- 
2.34.1



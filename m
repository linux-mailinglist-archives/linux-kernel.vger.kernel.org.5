Return-Path: <linux-kernel+bounces-5138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F208186F3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BAB71C226EF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3CC171A2;
	Tue, 19 Dec 2023 12:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TAU2VphW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4CF17999
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 12:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231219120419epoutp023ac4d4fec434aa9f48f18c4a11c85e37~iOhJlySBG0454904549epoutp02R
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 12:04:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231219120419epoutp023ac4d4fec434aa9f48f18c4a11c85e37~iOhJlySBG0454904549epoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1702987459;
	bh=xU6mmr9hcL6QNQzNmM1vXIFPw7g+7d712i7dUGeCtcs=;
	h=From:To:Cc:Subject:Date:References:From;
	b=TAU2VphWFzdYse5wMKMRPcKBOFBcK7KYa2Nm+yVsEzDsuVll2z1+tf/cIzSrIUMvV
	 xF5rq5qyKK/WDP0KJGxZJaJEEBHBEut9dUHVsvGsG+Heym2+v8g3h4B+ckvJ2sxGoW
	 vkGY1Nmp5wmnbF/vE9Yw2IIqYjoSEWhZDqnnPYRo=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20231219120419epcas5p254ad2421187926c14100d6c7236d4b90~iOhI7bT9r0564605646epcas5p2k;
	Tue, 19 Dec 2023 12:04:19 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4Svb2n3BsRz4x9Pv; Tue, 19 Dec
	2023 12:04:17 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	34.CD.08567.1C681856; Tue, 19 Dec 2023 21:04:17 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20231219115856epcas5p371abeb4264f60309e597b90954e6d58c~iOccah9WH2290022900epcas5p3q;
	Tue, 19 Dec 2023 11:58:56 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231219115856epsmtrp28a370703b93e31bb8b6b26a4170b69ba~iOccZwtbi3243832438epsmtrp2N;
	Tue, 19 Dec 2023 11:58:56 +0000 (GMT)
X-AuditID: b6c32a44-3abff70000002177-ba-658186c10961
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	A3.CC.18939.08581856; Tue, 19 Dec 2023 20:58:56 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
	[107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20231219115854epsmtip10f680a603d53d3817a7772a0cd8ddffb~iOcaZ7V7F0513305133epsmtip1l;
	Tue, 19 Dec 2023 11:58:54 +0000 (GMT)
From: Varada Pavani <v.pavani@samsung.com>
To: mturquette@baylibre.com, sboyd@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, s.nawrocki@samsung.com, tomasz.figa@gmail.com
Cc: linux-samsung-soc@vger.kernel.org, alim.akhtar@samsung.com,
	aswani.reddy@samsung.com, pankaj.dubey@samsung.com, Varada Pavani
	<v.pavani@samsung.com>
Subject: [PATCH 1/2] dt-bindings: clock: Fix spelling mistake in
 'tesla,fsd-clock.yaml'
Date: Tue, 19 Dec 2023 17:28:33 +0530
Message-Id: <20231219115834.65720-1-v.pavani@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFKsWRmVeSWpSXmKPExsWy7bCmlu7BtsZUg08P2SwezNvGZnFo81Z2
	izV7zzFZzD9yjtWi78VDZouPPfdYLS7vmsNmMeP8PiaLi6dcLRZt/cJucfhNO6vFv2sbWSxW
	7frDaLGh9xW7A5/H+xut7B47Z91l99i0qpPN4861PWwefVtWMXp83iQXwBaVbZORmpiSWqSQ
	mpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkDdK2SQlliTilQKCCxuFhJ
	386mKL+0JFUhI7+4xFYptSAlp8CkQK84Mbe4NC9dLy+1xMrQwMDIFKgwITujq+cle8FD9ort
	S3axNjBeZ+ti5OSQEDCR+L9sNmMXIxeHkMBuRokfC8+zQzifGCWe7XvJAue0XjvODNPS+fIk
	G0RiJ6PEzO9XWCGcViaJC52bmUCq2AS0JFZPXQ6WEBF4zygxbfISMIdZYA6jxK2jN1lAqoQF
	IiXOrFgDZrMIqEpsWrAZzOYVsJR4eOMP1D55idUbDjCDNEsI3GOXOPDlHiNEwkViTUcDlC0s
	8er4FnYIW0ri87u9QAdyANnJEu2fuCHCORKXdq9igrDtJQ5cmcMCUsIsoCmxfpc+RFhWYuqp
	dWAlzAJ8Er2/n0CV80rsmAdjK0ns3DEBypaQeLp6DdQmD4kPz1lBTCGBWInLTzInMMrOQpi/
	gJFxFaNkakFxbnpqsmmBYV5qOTyikvNzNzGCE6GWyw7GG/P/6R1iZOJgPMQowcGsJMLrsqg+
	VYg3JbGyKrUoP76oNCe1+BCjKTDAJjJLiSbnA1NxXkm8oYmlgYmZmZmJpbGZoZI47+vWuSlC
	AumJJanZqakFqUUwfUwcnFINTMH/N9Y6WHuV/ogs2Xfr6fW+BVIuSpuWJMaLPuQx858Y+NO8
	3INpv8yX01pv/j848qkrYuHuudPUN8zg7ChzPnfw7plgdpWLdRV5125mMq3P+cp/sX1+vJln
	0bEpayq7VvX4nljxN56jmY2L4fn3vx2GGwJ/uUdaLneduKq6LPxqFLtQ9sdV9UwzU22V37mc
	/n3ZdGtt1f2d9X8PLGUILGiefMZ2Z8P06e9mT+d6+Xb+/Ukp7oH/zOu+bBFxiZr+Ztcm3z/z
	bHsYex5oPnbKVL3d8/l40Py0fW681i7Op872r/zbUrLA6Mq/gluxe3RMJqR5Td5mcdVDtfOx
	OvMCZ42eyJ5ld2X8TvmnrT3xPliJpTgj0VCLuag4EQCY2moADQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCLMWRmVeSWpSXmKPExsWy7bCSnG5Da2OqwaRf/BYP5m1jszi0eSu7
	xZq955gs5h85x2rR9+Ihs8XHnnusFpd3zWGzmHF+H5PFxVOuFou2fmG3OPymndXi37WNLBar
	dv1htNjQ+4rdgc/j/Y1Wdo+ds+6ye2xa1cnmcefaHjaPvi2rGD0+b5ILYIvisklJzcksSy3S
	t0vgyujqecle8JC9YvuSXawNjNfZuhg5OSQETCQ6X54Esrk4hAS2M0r0rV/CBJGQkNj5rZUZ
	whaWWPnvOTtEUTOTxI07TSwgCTYBLYnVU5ezgiREBH4CdX/7yALiMAssYJRY1doAViUsEC5x
	9NUPsFEsAqoSmxZsBovzClhKPLzxB2qFvMTqDQeYJzDyLGBkWMUomlpQnJuem1xgqFecmFtc
	mpeul5yfu4kRHJBaQTsYl63/q3eIkYmD8RCjBAezkgivy6L6VCHelMTKqtSi/Pii0pzU4kOM
	0hwsSuK8yjmdKUIC6YklqdmpqQWpRTBZJg5OqQYmbkHto58vR6tsnLpGrGy7IePfTtkjYYve
	r+J9e+TWT9Hre5+FW66WMDBc0zfV64uK/RMv2x+TJon12/0of/Qg8PWZHuOD384f+u2+9MoF
	LTv/cF/Os4GyR9iPJPNfyTbkWi97ZuP1bYGR1q8mKZRcnHA7VWvBxLtf5c/7u/ruVcj+uLX9
	hez7uwmrbr7gZ/7/uuvQuk82AlVbnxrxs+30SPIo5fh5KVG8Xt7TNlXMif//rdJLf08muf61
	+1EfutxFNXGz7Qtm/XmbFCf/vPFa6bD2ryfeMg+upa4VuPLUPGTN3uqe3WwzP7e8nFjE8vyz
	PW9d0VG21ybP+EU2B79I+NMhbedWl+er1pq2JX2dtxJLcUaioRZzUXEiAKj0wRK3AgAA
X-CMS-MailID: 20231219115856epcas5p371abeb4264f60309e597b90954e6d58c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231219115856epcas5p371abeb4264f60309e597b90954e6d58c
References: <CGME20231219115856epcas5p371abeb4264f60309e597b90954e6d58c@epcas5p3.samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fix typo 'inteernal' to 'internal' in 'Documentation/devicetree/
bindings/clock/tesla,fsd-clock.yaml'.

Signed-off-by: Varada Pavani <v.pavani@samsung.com>
---
 Documentation/devicetree/bindings/clock/tesla,fsd-clock.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/tesla,fsd-clock.yaml b/Documentation/devicetree/bindings/clock/tesla,fsd-clock.yaml
index dc808e2f8327..b370a10a23a6 100644
--- a/Documentation/devicetree/bindings/clock/tesla,fsd-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/tesla,fsd-clock.yaml
@@ -12,7 +12,7 @@ maintainers:
 
 description: |
   FSD clock controller consist of several clock management unit
-  (CMU), which generates clocks for various inteernal SoC blocks.
+  (CMU), which generates clocks for various internal SoC blocks.
   The root clock comes from external OSC clock (24 MHz).
 
   All available clocks are defined as preprocessor macros in
-- 
2.17.1



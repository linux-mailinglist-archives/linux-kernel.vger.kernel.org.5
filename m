Return-Path: <linux-kernel+bounces-52048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D68FA849356
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 06:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9B0D1C2242A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 05:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C8EBE48;
	Mon,  5 Feb 2024 05:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="sT4XcYnR"
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B638AB666
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 05:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707110895; cv=none; b=fffVfXxRlQgq8+TM8MAnrzIRtiVamYd/TAO5afzmPyUeaywPsLUn8EHBFNOsIacLVU5rbpilCpbSYtZrFTJHrAUn8CKQ6YTA4sZumXzTU9LGmVGnOu4k0VjUWQyNw9/7d3GlEV6WzQBDj59/n2ftK9v1W0NpiMD9EZ7ed1lp0eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707110895; c=relaxed/simple;
	bh=KGVIQ7R3XaeYio8DCZDb8cibagzCabv2lV8TzCs3KFA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:References; b=abTnrpY5a4v6DuK6+fv/pZ00FE0wm5hqgFAL1SxTYPSJmXicBTEyIiCxpFcc53OnAe08BLesusZMT+vOuue/MCss8cLlzichQUb3J6bP2ZgTeUiXSyVfFGD4U3IHXPUxlqQXFy+PyvpFtuOovwN1lKCwjL0RM0W8VOWxjp7yK08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=sT4XcYnR; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240205052804epoutp04d2d41d71a04afccabcaee6ac488d0bc4~w4E3wfaGn1731117311epoutp04M
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 05:28:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240205052804epoutp04d2d41d71a04afccabcaee6ac488d0bc4~w4E3wfaGn1731117311epoutp04M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1707110884;
	bh=MEXPbxT6P7PtY/XAgzobsSoAFcpyfbHJUxz+fcXZugY=;
	h=From:To:Cc:Subject:Date:References:From;
	b=sT4XcYnRqTv6T8QOSkyy0jVIa+gdyIMtVGEndwJoGDlTpzQoDSDu//LtkjTgQt3Su
	 FbXqeB2bbG/Kft7zZ3ODa9EfkNOlnpWZfdmgu1gVdyYufZfMhv635gojfTaDjaHgel
	 aXIDPgtI2PWl8dOT7IyNJbH2mHnRg3lrOrUG6Eik=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240205052803epcas5p181a5a112b167e7296158fd6e2796483f~w4E3TnOqt1696816968epcas5p1W;
	Mon,  5 Feb 2024 05:28:03 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.175]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4TSvzP6bZgz4x9QK; Mon,  5 Feb
	2024 05:28:01 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	92.9B.08567.1E170C56; Mon,  5 Feb 2024 14:28:01 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240131070746epcas5p39bf60e36d7d5cea5937cd6f87352ea67~vXNgKvXZw1167111671epcas5p3X;
	Wed, 31 Jan 2024 07:07:46 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240131070746epsmtrp1ce29d4373d2b26044cb2638fd8556af0~vXNgJWnpf0816808168epsmtrp15;
	Wed, 31 Jan 2024 07:07:46 +0000 (GMT)
X-AuditID: b6c32a44-3abff70000002177-6d-65c071e18a24
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	1E.4F.18939.2C1F9B56; Wed, 31 Jan 2024 16:07:46 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
	[107.109.115.53]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240131070744epsmtip2acf436d44ed1e6404aba10c2fc626e2f~vXNeAs9tW2159821598epsmtip2D;
	Wed, 31 Jan 2024 07:07:44 +0000 (GMT)
From: Aakarsh Jain <aakarsh.jain@samsung.com>
To: linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: m.szyprowski@samsung.com, andrzej.hajda@intel.com, mchehab@kernel.org,
	hverkuil-cisco@xs4all.nl, krzysztof.kozlowski+dt@linaro.org,
	robh+dt@kernel.org, conor+dt@kernel.org, linux-samsung-soc@vger.kernel.org,
	gost.dev@samsung.com, alim.akhtar@samsung.com, pankaj.dubey@samsung.com,
	aakarsh.jain@samsung.com
Subject: [PATCH] MAINTAINERS: Add entry for Samsung MFC DT Schema
Date: Wed, 31 Jan 2024 12:37:41 +0530
Message-Id: <20240131070741.3558-1-aakarsh.jain@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnk+LIzCtJLcpLzFFi42LZdlhTU/dh4YFUg8M3jS2e7pjJavFg3jY2
	i/uLP7NYrNl7jsli/pFzrBY3D+xksrg48y6LRd+Lh8wWmx5fY7W4vGsOm0XPhq2sFjPO72Oy
	WHvkLrvFsk1/mCwWbf3CbtG69wi7g4DH4j0vmTw2repk87hzbQ+bx+Yl9R59W1YxenzeJOdx
	6utn9gD2qGybjNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfM
	HKDjlRTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkFJgV6xYm5xaV56Xp5qSVWhgYG
	RqZAhQnZGY1vP7IUfGWpWPv7N0sD4wyWLkZODgkBE4n1cz6xdzFycQgJ7GaUONr9mgkkISTw
	iVHiyw5BOLv1qTNMw4tLSxghGnYySqz4tJAFwmllktiwdxKQw8HBJqArcXZ7DkiDiEAjo8Tj
	jhKQGmaBvUwSe552g60WFnCUuDpzDhuIzSKgKnHv4U12EJtXwEaia/4Zdoht8hKrNxxgBmmW
	EPjLLtGwcToTyAIJAReJ7tdSEDXCEq+Ob4Gql5J42d8GZSdLPF70khnCzpFYv2cK1Mv2Egeu
	zAG7k1lAU2L9Ln2IsKzE1FPrwJ5nFuCT6P39hAkiziuxYx6MrSYx584PVghbRuLw6qWMELaH
	xNy7nWyQwIqVWL96OfMERtlZCBsWMDKuYpRMLSjOTU9NNi0wzEsth0dTcn7uJkZwitRy2cF4
	Y/4/vUOMTByMhxglOJiVRHgnCO9NFeJNSaysSi3Kjy8qzUktPsRoCgyyicxSosn5wCSdVxJv
	aGJpYGJmZmZiaWxmqCTO+7p1boqQQHpiSWp2ampBahFMHxMHp1QDU+vcO/V19qeuf2uzvH1T
	eLE94741ajenbPauu6TteUn97G5Jo/tby+tVX53y274gfFnA6sc7nwTfmjp1+Yzv3FeCHum0
	p+80nFtkfsd35z/O/X8Xznx+J1hO65wm39Zpe5Juv/VbverrOcMFniyJjrlntunM9/UTLjQ8
	qxX/UFVbm02L18SyNuSd5QOziLa8Ir09j53lN2//zy+vvKrGmdckmOuIlnUap+C2h/0XWnb6
	Tp/jv9b8/Ky/VbN/HlO5cyzggFD9Qq7/RnEnH6tHSW30bLwUkFBbWL7ePiJZY/dzkW0xWUFv
	/h9iDX1vGZoVrn8uKvSXgfF6f4lLhanSllwdamarRS2axZfZPPjrrsRSnJFoqMVcVJwIAA0k
	078aBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrELMWRmVeSWpSXmKPExsWy7bCSvO6hjztTDdYu0LR4umMmq8WDedvY
	LO4v/sxisWbvOSaL+UfOsVrcPLCTyeLizLssFn0vHjJbbHp8jdXi8q45bBY9G7ayWsw4v4/J
	Yu2Ru+wWyzb9YbJYtPULu0Xr3iPsDgIei/e8ZPLYtKqTzePOtT1sHpuX1Hv0bVnF6PF5k5zH
	qa+f2QPYo7hsUlJzMstSi/TtErgyGt9+ZCn4ylKx9vdvlgbGGSxdjJwcEgImEi8uLWHsYuTi
	EBLYziixf/YyqISMxP+2Y+wQtrDEyn/P2SGKmpkkmpZ3MXcxcnCwCehKnN2eAxIXEWhllLi+
	spMJxGEWOM0k8WXHE2aQbmEBR4mrM+ewgdgsAqoS9x7eBJvKK2Aj0TX/DNQGeYnVGw4wT2Dk
	WcDIsIpRNLWgODc9N7nAUK84Mbe4NC9dLzk/dxMjOFi1gnYwLlv/V+8QIxMH4yFGCQ5mJRHe
	lXI7U4V4UxIrq1KL8uOLSnNSiw8xSnOwKInzKud0pggJpCeWpGanphakFsFkmTg4pRqYNiby
	b34T87B62l0/l6AlWfIn7n/9x3NkxtPjTe9aMlgUIsKC21TuftSrzJ37wS1En8NWySTxrPu+
	Y6rX+tVmu4WdmLH8s/TeBTv3/7dfVroqWutrYqRQ6Nmaj/26rwtOl3nVfLdv2mw+ZQvv5y8V
	hStYHj7eLChd3bncQtlxpUNTbdEWTqWWRQtZv4lO1+Bna7/EMe+Q/oX59Z1rVZsnXmPi5L01
	S+RsfpnSmck5P78yth3f45692P3JnxmzFBi4d18KWpmhLMIe9Oyx1PQltfXcD3avDbK/sYqH
	ZWW92W1zffaumNV3RAq8LHNufbkpsj1i22TXKcmalw7qlj/5nT01sXFW/amo5J1lPTd2K7EU
	ZyQaajEXFScCAJAMf8fFAgAA
X-CMS-MailID: 20240131070746epcas5p39bf60e36d7d5cea5937cd6f87352ea67
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240131070746epcas5p39bf60e36d7d5cea5937cd6f87352ea67
References: <CGME20240131070746epcas5p39bf60e36d7d5cea5937cd6f87352ea67@epcas5p3.samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add device tree schema entry for Samsung MFC.

Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 32a47aa6aa76..55e9b0ae185b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2752,6 +2752,7 @@ M:	Andrzej Hajda <andrzej.hajda@intel.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-media@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
 F:	drivers/media/platform/samsung/s5p-mfc/
 
 ARM/SOCFPGA ARCHITECTURE
-- 
2.17.1



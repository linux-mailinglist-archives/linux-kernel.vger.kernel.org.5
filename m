Return-Path: <linux-kernel+bounces-63094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8030852ADA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E58D281F40
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A1D17C71;
	Tue, 13 Feb 2024 08:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="n45jA2m5"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EECA1B7F5
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 08:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707812374; cv=none; b=qufGkjscIdC0/UvXOOTCXCHv71/RmLYP9Q52JTpu9a0WzDJj76CKc6uCzfAGp/JXp8aLb+h1GwluccleQ3mj7AW/KlIH+7J9+o/uiPZLt6vcGAjYSzUL+fO3xy4+a8WANW8IEVAIv0DoXKNUdTbVwrp/K7uWpbzkXeetKtWk5Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707812374; c=relaxed/simple;
	bh=a9KpPEigrsX1iLMABeTlXtvEaBlx5SwQTXXvUiczMB0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:References; b=eDh3Kv1Zl9bVu+U5XJxq2fY5MJIfYBb2KfpRy7cuTl7Cjz+UFVr4zanShdEi/LNaWl97Rau41M1hKhpuNuES965wOdEopagSYEXHVtqAal3kJKF9JNFWbCnzohwLym5kYy7lif3RGeKmAm+4wNHDfpEDzAiBKJbMtoad5HIVlTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=n45jA2m5; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240213081929epoutp03803462219adebfbab61ce9eb270af6c1~zXk023W991794017940epoutp03o
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 08:19:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240213081929epoutp03803462219adebfbab61ce9eb270af6c1~zXk023W991794017940epoutp03o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1707812369;
	bh=H1tmDljItywEqFTrCeVCWWEvSW1ptNZPOJ2e9OZtBDU=;
	h=From:To:Cc:Subject:Date:References:From;
	b=n45jA2m5Khgp+gF6RFYFySgSlZT9CDOxAOUd4ycn9dYHvn7FygcCV9OEL4NqevpOH
	 JsOGGtvhe6DUebUjL5GEhy4TTaQCfnsHLWnHsBMQHtJIUaZAt8PGh8Nvdxzkcr9yLm
	 0lFnNhsHM6MF5Na8YatpJi20iO09915MH0DHvyT4=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240213081928epcas5p335b1317d210ea234c717440690a8224d~zXk0Zpb9U1947019470epcas5p3-;
	Tue, 13 Feb 2024 08:19:28 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.175]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4TYvPW1Rzyz4x9Pw; Tue, 13 Feb
	2024 08:19:27 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	8B.49.10009.F062BC56; Tue, 13 Feb 2024 17:19:27 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240213045739epcas5p49f28920efda3cb80351b1fcae580b21e~zU0mg__Ak3076530765epcas5p4j;
	Tue, 13 Feb 2024 04:57:39 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240213045739epsmtrp195d85b4c2bfb9a6608a56432f75f2021~zU0mf7ZVQ2138221382epsmtrp1U;
	Tue, 13 Feb 2024 04:57:39 +0000 (GMT)
X-AuditID: b6c32a4a-261fd70000002719-78-65cb260f034a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	4D.0C.07368.3C6FAC56; Tue, 13 Feb 2024 13:57:39 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
	[107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240213045736epsmtip1f0d0b60a43c700a19890074823abd3b6~zU0kNhaz_0854708547epsmtip1E;
	Tue, 13 Feb 2024 04:57:36 +0000 (GMT)
From: Aakarsh Jain <aakarsh.jain@samsung.com>
To: linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: m.szyprowski@samsung.com, andrzej.hajda@intel.com, mchehab@kernel.org,
	hverkuil-cisco@xs4all.nl, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux-samsung-soc@vger.kernel.org, andi@etezian.org, gost.dev@samsung.com,
	alim.akhtar@samsung.com, pankaj.dubey@samsung.com, aakarsh.jain@samsung.com
Subject: [Patch v2] dt-bindings: media: s5p-mfc: Remove s5p-mfc.txt binding
Date: Tue, 13 Feb 2024 10:27:33 +0530
Message-Id: <20240213045733.63876-1-aakarsh.jain@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEJsWRmVeSWpSXmKPExsWy7bCmui6/2ulUg7aDHBZPd8xktXgwbxub
	xeIfz5ks7i/+zGKxZu85Jov5R86xWtw8sJPJ4uLMuywWfS8eMltsenyN1eLyrjlsFj0btrJa
	zDi/j8li7ZG77BbLNv1hsli09Qu7ReveI+wOgh7Xl3xi9li85yWTx6ZVnWwed67tYfPYvKTe
	o2/LKkaPz5vkPE59/cwewBGVbZORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCX
	mJtqq+TiE6DrlpkD9IaSQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8CkQK84Mbe4
	NC9dLy+1xMrQwMDIFKgwITtj4Y60gn2sFfPerGdrYHzK0sXIySEhYCJx9csU1i5GLg4hgd2M
	Esc33IRyPjFKXL+5jQXC+cYo0fhzJSNMy6OpF5kgEnsZJTbdPcoO4bQySZyc8J65i5GDg01A
	V+Ls9hyQBhGBRkaJxx0lIDazwHkmiQudKSC2sIC3xLX1D9lBbBYBVYldzw4zg9i8ArYS06Zf
	YodYJi+xesMBZpD5EgK9HBLX2s5DHe4iMXvfMWYIW1ji1fEtUA1SEi/726DsZInHi15C1eRI
	rN8zBarXXuLAlTksIHcyC2hKrN+lDxGWlZh6ah0TxJ18Er2/nzBBxHkldsyDsdUk5tz5wQph
	y0gcXr0UGigeEi3vH4KtEhKIldh/9S7bBEbZWQgbFjAyrmKUTC0ozk1PLTYtMMpLLYfHU3J+
	7iZGcOLU8trB+PDBB71DjEwcjIcYJTiYlUR4L804kSrEm5JYWZValB9fVJqTWnyI0RQYZhOZ
	pUST84GpO68k3tDE0sDEzMzMxNLYzFBJnPd169wUIYH0xJLU7NTUgtQimD4mDk6pBqZtsjzT
	OzgvM76/aWrY7LSFsckhPJKxwP2nS4fP+nzGTzf8lhw0v3Rst96SuY35sfYKS/gmLCzyP8c2
	U3zve+0/n/T0Gdjv3eza9ajReYvETOdfz7c6fvlYz1tx4n9e/IH29nshJ3b6GioGqaVM2rtg
	qbhSVfzHhTNM3v+QuRX8UF//9j1/b0Xvuv3NSnc/n3RbyK5Uv9zA7O3h0zyRnZf9K3gPH+0w
	Efr990ue5eWury+3my4PvVQrzl3Kkr/nyjGOFZdFz+ioei1k7DAyXrJG76GFjdSarbPP2ymu
	qQtymL9sxQP+/6b6k06n3rrxf9Kmay2y2f/uVe7d7sD24+WtXZnyNktqsv53yZR3Gv9WYinO
	SDTUYi4qTgQAlmfW9iUEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPLMWRmVeSWpSXmKPExsWy7bCSnO7hb6dSDS7ME7R4umMmq8WDedvY
	LBb/eM5kcX/xZxaLNXvPMVnMP3KO1eLmgZ1MFhdn3mWx6HvxkNli0+NrrBaXd81hs+jZsJXV
	Ysb5fUwWa4/cZbdYtukPk8WirV/YLVr3HmF3EPS4vuQTs8fiPS+ZPDat6mTzuHNtD5vH5iX1
	Hn1bVjF6fN4k53Hq62f2AI4oLpuU1JzMstQifbsEroyFO9IK9rFWzHuznq2B8SlLFyMnh4SA
	icSjqReZuhi5OIQEdjNKdL7bBpWQkfjfdowdwhaWWPnvOTtEUTOTxMab+4E6ODjYBHQlzm7P
	AYmLCLQySlxf2Qk2iVngPpPElYm3WUG6hQW8Ja6tfwg2iUVAVWLXs8PMIDavgK3EtOmXoDbI
	S6zecIB5AiPPAkaGVYySqQXFuem5yYYFhnmp5XrFibnFpXnpesn5uZsYwWGspbGD8d78f3qH
	GJk4GA8xSnAwK4nwXppxIlWINyWxsiq1KD++qDQntfgQozQHi5I4r+GM2SlCAumJJanZqakF
	qUUwWSYOTqkGJuUJE7kuvcjiX8GapGAVZWNzl+eHYOujiOIjBdOfKpSVvjaQ//86htf52M6d
	RbxnLJ9GrUirTUqYwVb8pT1vxYvYhv7Nwga9iWfe6TvJR71zUTCp3a3FP0H0dz1n8JGaLqfP
	LNnGKZE7BC6f0ma6mj2nfs+UpE+60hv+LvZcueLwl9dKsd86lS0WVBZaVad0lmQcer52UsLC
	zsdLTRtvuvrVCbLbqSn0b4vVWPB489LerGnvzuc7avMder51jf/XYsvJUn/V7LsvyWs58GUr
	mDzpn33JtLjd/sZX/9zZr+ITfk9plr05J+kkB/vFHQ6//77L+seyumvRmxtnmB9NmtS1Wzg0
	vzj2a8KxM85KSizFGYmGWsxFxYkAY8iUUNICAAA=
X-CMS-MailID: 20240213045739epcas5p49f28920efda3cb80351b1fcae580b21e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240213045739epcas5p49f28920efda3cb80351b1fcae580b21e
References: <CGME20240213045739epcas5p49f28920efda3cb80351b1fcae580b21e@epcas5p4.samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

commit "538af6e5856b" which convert s5p-mfc bindings to
json-schema is already merged. Remove "s5p-mfc.txt" file.

Fixes: 538af6e5856b ("dt-bindings: media: s5p-mfc: convert
bindings to json-schema")
Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
---
changelog:
v1->v2
Add Fixes tag suggested by Krzysztof
 Documentation/devicetree/bindings/media/s5p-mfc.txt | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/media/s5p-mfc.txt

diff --git a/Documentation/devicetree/bindings/media/s5p-mfc.txt b/Documentation/devicetree/bindings/media/s5p-mfc.txt
deleted file mode 100644
index e69de29bb2d1..000000000000
-- 
2.17.1



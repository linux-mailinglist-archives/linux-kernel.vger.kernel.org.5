Return-Path: <linux-kernel+bounces-44662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC8B8425A3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43BCF28ED07
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F424C66;
	Tue, 30 Jan 2024 12:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fU6IjAxN"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872221F951
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 12:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706619584; cv=none; b=gQZvbfFqXkQkk9txuvNAH+1iYcBFYSf0v0KBPHTsPdyyLbGAi5a9XR5M4CS58BtFYCS+UIV20sODV2NC9DBp7No/c6f+/3mkqrTEu+IEGWUSCwD8nx4irkLC1WXPfqDdSvbFPl8jQ4nnpZqWca8uhpijs6Jg1z0ScWXi8TezHtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706619584; c=relaxed/simple;
	bh=llKIpxzlNFJiUk8PY5b3Z3fCFrJxXebr98TkLhVix6c=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:References; b=E/B96gDYa+xD8mO5KGmAxo16+/ezmb+CcnihV1Xrn+Qp0G2Nciw+tPqrV3g+Zj1iKEqiQV+ZjBW1aBK0OxbqZZNci3D+ahgpQqSRAF/Ueb4Ji4wleH/KUXQQItxAdXLNfNTgHeVSkcmJjwocjvpDc8XBy7MHW8hp3NKHgKMUGxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=fU6IjAxN; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240130125939epoutp02691d2c33992d2675cdf2398a2be6ec83~vIXcWEknK2582125821epoutp020
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 12:59:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240130125939epoutp02691d2c33992d2675cdf2398a2be6ec83~vIXcWEknK2582125821epoutp020
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1706619579;
	bh=86uf5cHblxYzJLM1VjZACQcgiuV34NFC+LyTgR1BKi0=;
	h=From:To:Cc:Subject:Date:References:From;
	b=fU6IjAxNhaNVoL0dcG9yfloQY4KoDhGzATrGw8o7tpb1z25WZ/4wrV8N42AHUiXnc
	 JKeTEoXbxeeFbGey/QoOljQ1350q/Rq+0M85BW6+lMXjGyjQ7Qtm6b9K6RUHVTX4ap
	 6htqun4h5XfRQfvSUn+xUqLR8KDqvg9oezbr+XZY=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240130125938epcas5p27117a2b65534244744c3e07e26ecc13f~vIXbvpSQ82295622956epcas5p22;
	Tue, 30 Jan 2024 12:59:38 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4TPQHD6C8kz4x9Pr; Tue, 30 Jan
	2024 12:59:36 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	5F.0F.10009.8B2F8B56; Tue, 30 Jan 2024 21:59:36 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240130125754epcas5p2edd5cc52dc58add09299d3aa5985a9fd~vIV7QCMa91230812308epcas5p22;
	Tue, 30 Jan 2024 12:57:54 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240130125754epsmtrp2e12576e79ff1cc8625f64e1057826356~vIV7PB6Nn0742507425epsmtrp2j;
	Tue, 30 Jan 2024 12:57:54 +0000 (GMT)
X-AuditID: b6c32a4a-ff1ff70000002719-cd-65b8f2b8df94
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	7A.C1.08755.252F8B56; Tue, 30 Jan 2024 21:57:54 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
	[107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240130125752epsmtip148d450aa6a46e8e5e6576d0cffcc96bd~vIV4u265V0502605026epsmtip1C;
	Tue, 30 Jan 2024 12:57:52 +0000 (GMT)
From: Aakarsh Jain <aakarsh.jain@samsung.com>
To: linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: m.szyprowski@samsung.com, andrzej.hajda@intel.com, mchehab@kernel.org,
	hverkuil-cisco@xs4all.nl, krzysztof.kozlowski+dt@linaro.org,
	robh+dt@kernel.org, conor+dt@kernel.org, linux-samsung-soc@vger.kernel.org,
	andi@etezian.org, gost.dev@samsung.com, alim.akhtar@samsung.com,
	pankaj.dubey@samsung.com, aakarsh.jain@samsung.com
Subject: [PATCH] dt-bindings: media: s5p-mfc: Remove s5p-mfc.txt binding
Date: Tue, 30 Jan 2024 18:27:48 +0530
Message-Id: <20240130125748.54194-1-aakarsh.jain@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSf0wTZxjH895dr6dJl1tB966BrdyGC7BCC6U7pkwZxNw2XdjMNsMi0LQn
	Rfrj1isC2xJ1C+pwot1GIhbZ5NcMWIsVpLCWYUtk6oDMYecIOB0wLSZzoRXRmTnqwfbf9/3m
	833e93neh0CldlxGlJptrNWsNVL4SuxsIClZ4ZnzsMpvD6joGU+9iL7eeBanmxduIvRvzWGM
	PukbQeivB0dE9K8DvQj9U/0kRtfeuoHS7qmgiP65rwGnP+/sFtFHRvsR2jk4Kabb3A8Ruqk7
	IqarfYPiDU8yv7TMoUyzN4Qw7vbPcGYi6MWZMy27mNqudsCE3c8wF++GxflEQdk6A6vVs1Y5
	a9ZZ9KXmkmzqjS1FuUWZGqVKocqiX6LkZq2JzabyNuUrNpYaF9ug5Du1xvJFK1/L81TaK+us
	lnIbKzdYeFs2xXJ6I6fmUnmtiS83l6SaWdvLKqUyPXMRLC4zND24g3FOrPJK4Di2G8yiNWAF
	AUk1POEPgRqwkpCS3wHYNzaOCYc5AHuHxkVRSkrOAzg5altOhB0TuAD5APzEPbSUqEbgFy47
	UgMIAicVcLjHGA3EknsAnNpvizIoOYrA1umFx1VjSAZO1oXwKI+RifD3+wlRW0Jmw3D4mli4
	7FnY0TmARrOQtBNwwH8ZjfKQzIMHWt4TmBg4O9S1xMtg+E8fLmgdnGoKLbVphC7vV5ig18OB
	sQYsWgYlk6CrL02w42HdxVNIVKPkE/Dg39OI4Eugp3FZr4ENE8LrIRkHAx2tQNAMdLr3ioVZ
	bYNzP5xGDoP4o//f8A0A7eBpluNNJSyfyaWb2Yr/vklnMbnB491Mft0Dblz/K9UPEAL4ASRQ
	KlZyP6mblUr02qoPWaulyFpuZHk/yFycmB2VrdJZFpfbbCtSqbOUao1Go87K0KiopyS3q4/p
	pWSJ1saWsSzHWpdzCLFCths5s3aalV/jHp03DU+1N94kMjbnpL0petdRwmzTUBXcg6odzbff
	eic3VO+bjkvThFzS7R9ELn258+ON6ck5m77vH5ZdyI3RrI5L3Gd3rW3rybo6grs4M/68+urY
	1jadZ399MGXzhnuODl/iQy6nMrK9K7H7xPyrJ3WBvMKCYGUhP/0j9GXuiVvV8s9HzjvqyPk1
	PZEX5K1vf1p10HvX6XB7swK36mZnIufyZYrsQ3pFv/qYIbZ23/jxU6sv181qUtbPJAw/9+Kj
	vfP3XnOoLojwii0mLNx67v3O+DhCrdqx61D5QkbhFU9xwtE/gl002tt+JOWSd6tTVJA7N1VM
	BpynCyiMN2hVyaiV1/4LXsDzLCQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPLMWRmVeSWpSXmKPExsWy7bCSnG7Qpx2pBm3v9Sye7pjJavFg3jY2
	i8U/njNZ3F/8mcVizd5zTBbzj5xjtbh5YCeTxcWZd1ks+l48ZLbY9Pgaq8XlXXPYLHo2bGW1
	mHF+H5PF2iN32S2WbfrDZLFo6xd2i9a9R9gdBD2uL/nE7LF4z0smj02rOtk87lzbw+axeUm9
	R9+WVYwenzfJeZz6+pk9gCOKyyYlNSezLLVI3y6BK2PRr/csBWtZKq4eXsjSwPiKuYuRk0NC
	wETi8+w7bF2MXBxCArsZJZ71bGeCSMhI/G87xg5hC0us/PecHaKomUniTk8fUBEHB5uArsTZ
	7TkgcRGBVkaJ6ys7mUAcZoH7TBJP1+4DmyQs4CFxd+pLNpAGFgFViUc/FUHCvAK2Ep8/34Na
	IC+xesMB5gmMPAsYGVYxSqYWFOem5xYbFhjmpZbrFSfmFpfmpesl5+duYgSHsZbmDsbtqz7o
	HWJk4mA8xCjBwawkwvtTc2uqEG9KYmVValF+fFFpTmrxIUZpDhYlcV7xF70pQgLpiSWp2amp
	BalFMFkmDk6pBibBfxMrzkrOarFfpuNl16TBy6H+yuT7r/S8eBb+FUv5bwo1l7/gNDuy2/Xz
	hu9dbV1/K+x7N5xZrcRQL1STFRmh5fzKOeKbzIxHUy/e89x5xeGi1VpVwUOOv9ZNWLjqr3r8
	xx0tO15MED3qXvVG/M63tZsbjJZP5pc4JnTa6nlY2J2H33ftZrnlJ8hlO3uGubthEc/jjav+
	KpU4uSyzeZVy87HJDvu9lp1Bhv4cwXs1XBnTD/97VXWL5ZnxrCknN1/ZeTNgen24uYvaTEar
	h3dWzPmccodHXaX+hHLKmlfzxI/8OnLy6IVrOv+z37TOWPj79IPTPP0BE0ReK9Z/jf1yY/2V
	XIlZ5v83/rwTsnTyAiWW4oxEQy3mouJEAGdDD3LSAgAA
X-CMS-MailID: 20240130125754epcas5p2edd5cc52dc58add09299d3aa5985a9fd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240130125754epcas5p2edd5cc52dc58add09299d3aa5985a9fd
References: <CGME20240130125754epcas5p2edd5cc52dc58add09299d3aa5985a9fd@epcas5p2.samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Commit "538af6e5856b" which convert s5p-mfc bindings to
json-schema is already merged. Remove "s5p-mfc.txt" file.

Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
---
 Documentation/devicetree/bindings/media/s5p-mfc.txt | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/media/s5p-mfc.txt

diff --git a/Documentation/devicetree/bindings/media/s5p-mfc.txt b/Documentation/devicetree/bindings/media/s5p-mfc.txt
deleted file mode 100644
index e69de29bb2d1..000000000000
-- 
2.17.1



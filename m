Return-Path: <linux-kernel+bounces-118852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B19A288C045
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6819A3018C1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086B33838C;
	Tue, 26 Mar 2024 11:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="pqWhmcNL"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEE63A8F0
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 11:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711451463; cv=none; b=U4Ij63mBB9LIknI41Y7rmMPFNAqzT5jzlkkLXrRRaglQsjACPQTejTv8Fq8GO784pjB2PlvdtiHiQa3x8SvAB96mVRnJvzpAywsULQ3DdvcgPcNlv8+x0hw5p1MGvvt3BHP25JxmRpQHST9n5qubfM/X376EUZH3fF+gjgcAn58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711451463; c=relaxed/simple;
	bh=BuX2xwdZHfMpBgoFcmq83YZ+3v4gskJ8M1kjG1AV2tM=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=mErDtv8K8PWvZ436uIT0FxmCDUNH8AVtCUhHmBfAFmayr3C+7WfgpmfivYrWyyYFG9VA/XYaKPBSy5TTTQl8v/NKCgcJLIAufd/vz0NuDj28i8YJPAHV32utKXlHNfAXYcokPO9pfZi28uhzC6DxlxCbXa62wraam6LrvCM6A90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=pqWhmcNL; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240326111049epoutp01f2e0716fb6101845cbb183ade3f624a0~ATAaMJmMv0139801398epoutp01a
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 11:10:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240326111049epoutp01f2e0716fb6101845cbb183ade3f624a0~ATAaMJmMv0139801398epoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1711451449;
	bh=IZ8hCDoFihRIcG4frBbqMwTioSwn4bc+B+U4W58PyJc=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=pqWhmcNLTlMHTpKRQemDszpckEWq11ctLH5hkotLFEzDGq4kR6VhAJ2BcF6twep8U
	 82dNYOF4DM90DrIwKJMkh0kYqa4lb64EBdHdYXe5TB8zFWJ6EYLSilubAUVngJ6tLY
	 QHhzh23Y87OX9ORbxrrRGczwDdq8i40GrvX+8dpo=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240326111048epcas5p39791b4c99d5c0051012921755a396a9f~ATAZrW6Db0240602406epcas5p3i;
	Tue, 26 Mar 2024 11:10:48 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4V3nCq15LNz4x9Pt; Tue, 26 Mar
	2024 11:10:47 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	63.CC.09666.63DA2066; Tue, 26 Mar 2024 20:10:47 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240326111046epcas5p29ae1282c0639642d1450e8f2ca503686~ATAXtzlil3040330403epcas5p2K;
	Tue, 26 Mar 2024 11:10:46 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240326111046epsmtrp1cf299e7bfab4877d81c2377d5278d8a3~ATAXshPFv2192521925epsmtrp1F;
	Tue, 26 Mar 2024 11:10:46 +0000 (GMT)
X-AuditID: b6c32a49-f53fa700000025c2-8d-6602ad361701
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	A0.79.08390.63DA2066; Tue, 26 Mar 2024 20:10:46 +0900 (KST)
Received: from INBRO000447 (unknown [107.122.12.5]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20240326111044epsmtip1f20c2bb2a1201f8c1af5d949d50d0e8b~ATAVnvY0W1636516365epsmtip1a;
	Tue, 26 Mar 2024 11:10:44 +0000 (GMT)
From: "Alim Akhtar" <alim.akhtar@samsung.com>
To: "'Tudor Ambarus'" <tudor.ambarus@linaro.org>,
	<peter.griffin@linaro.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
Cc: <linux-arm-kernel@lists.infradead.org>,
	<linux-samsung-soc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <andre.draszik@linaro.org>,
	<willmcvicker@google.com>, <kernel-team@android.com>
In-Reply-To: <20240326103620.298298-4-tudor.ambarus@linaro.org>
Subject: RE: [PATCH v2 3/4] arm64: dts: exynos: gs101: join lines close to
 80 chars
Date: Tue, 26 Mar 2024 16:40:43 +0530
Message-ID: <001801da7f6e$40545650$c0fd02f0$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQD6o8IeErxKDZrGFPr+Y/HHTXn7CgGaCFg/AaIDCZqy77Q+cA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCJsWRmVeSWpSXmKPExsWy7bCmpq75WqY0g3NPmCy2vNrMYrFm7zkm
	i/lHzrFa7NguYtH34iGzxabH11gtLu+aw2Yx4/w+JosNM/6xWLTuPcJu8elWnMWqT/8ZHXg8
	tu3exuqxYFOpx6ZVnWwed67tYfPYvKTe4/MmuQC2qGybjNTElNQihdS85PyUzLx0WyXv4Hjn
	eFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKADlRTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2
	SqkFKTkFJgV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZGW/3Chb0cVT8XfWBsYHxK1sXIyeHhICJ
	xPWvO4FsLg4hgd2MEg823mOHcD4xSnTdngrlfANyHp5ngWk5//EvC0RiL6NE24/VrBDOC0aJ
	Q+efsYNUsQnoSuxY3AY2WERgEaPE87MLwTYyCzxllDj40gLE5hSwl9jWvBcsLiwQKrF28jyw
	ZhYBVYk/yxczgti8ApYSW05OZIawBSVOznzCAjFHXmL72znMECcpSPx8uowVxBYRcJLYsfwg
	E0SNuMTLo0fAfpAQ2MMhce3tR0aIBheJfz862SFsYYlXx7dA2VISL/vbgGwOINtDYtEfKYhw
	hsTb5euhWu0lDlyZwwJSwiygKbF+lz7EKj6J3t9PmCA6eSU62oQgqlUlmt9dhQactMTE7m5W
	CNtDYt2TCYwTGBVnIXlsFpLHZiF5YBbCsgWMLKsYJVMLinPTU4tNCwzzUsvh8Z2cn7uJEZx8
	tTx3MN598EHvECMTB+MhRgkOZiUR3pYvDGlCvCmJlVWpRfnxRaU5qcWHGE2BoT2RWUo0OR+Y
	/vNK4g1NLA1MzMzMTCyNzQyVxHlft85NERJITyxJzU5NLUgtgulj4uCUamDiT/TbmOro7m9Z
	rFiTYPToxMopcnvW/BNpKrnIkLJwkz63q02ehFEq15p/e58u33H6o+ltW6GYrU9sRA/M+C7S
	LHIpYyZ/epxGEl90i1Gp8u6dd6putF2tFH6wkf9m7e9lpjM7ud2/7VOOXRB9g3ffvcm33rWk
	3rZuSpoXf2t5zfpXEtaTzVLzdnXP8uYK3xgdbXxVsKjRN3nu59VJZ99wL/x4+8Vh9tc7Ms58
	EZ3KIqn9S+YAV8usl2mnuMrnv+713bVsdqts5N3vJ6vEvbbseWefPuedsZDQ9apJkx4m6ss6
	KiZmCoW3PvxbyG2wzX5vWNa+KXzrLq5NWLL94d1HTr9NrZxeBEuyuJ77f6JaiaU4I9FQi7mo
	OBEAuykqzkcEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDIsWRmVeSWpSXmKPExsWy7bCSnK7ZWqY0g8VTlSy2vNrMYrFm7zkm
	i/lHzrFa7NguYtH34iGzxabH11gtLu+aw2Yx4/w+JosNM/6xWLTuPcJu8elWnMWqT/8ZHXg8
	tu3exuqxYFOpx6ZVnWwed67tYfPYvKTe4/MmuQC2KC6blNSczLLUIn27BK6Mt3sFC/o4Kv6u
	+sDYwPiVrYuRk0NCwETi/Me/LF2MXBxCArsZJRoWfmGBSEhLXN84gR3CFpZY+e85O0TRM0aJ
	Y6s7wbrZBHQldixuA7NFBJYxSkz9rApSxCzwmlHi0/IrUGMPAzn7V4GN4hSwl9jWvBesQ1gg
	WOL0q+9g61gEVCX+LF/MCGLzClhKbDk5kRnCFpQ4OfMJUA0H0FQ9ibaNYCXMAvIS29/OYYa4
	TkHi59NlrBBHOEnsWH6QCaJGXOLl0SPsExiFZyGZNAth0iwkk2Yh6VjAyLKKUTK1oDg3PbfY
	sMAoL7Vcrzgxt7g0L10vOT93EyM4ArW0djDuWfVB7xAjEwfjIUYJDmYlEd6WLwxpQrwpiZVV
	qUX58UWlOanFhxilOViUxHm/ve5NERJITyxJzU5NLUgtgskycXBKNTAxilvVPkl7vOnoWf+8
	g6/zruguNdt6Otg4cHVZHptey00P+90pb2evfXjba9U2JZEUS87PMxZdb27auIPd7lS4G/vu
	tbN3r3MtPD4zcY5xhtosp4AQRT3Dt56hDPnS5sFPm6py7yfufC1xKPnvxHUMuo9UVj/lSP7x
	ewNHavxpEfaCmTMMnZ4e3FM9bYl99rnpB7jnfjarkHo9fc2fSS91bRRXB/79VW/mJ/euviz9
	2dGUVwYzMp3kV2ZMElBgqN42rTf00tmfsvfzc3ieff+rlWj2g/19PZcE5438Pcc+7O4wmJS2
	XPnJyo9OHM2Sd0/LLT55Ydl8tmS/JQwLrTSOnH0U8uyzBGcxb9ZL5m2sSizFGYmGWsxFxYkA
	/Naw4y8DAAA=
X-CMS-MailID: 20240326111046epcas5p29ae1282c0639642d1450e8f2ca503686
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240326103631epcas5p37bc95c57becdeb63b0d8b01ffc6606fb
References: <20240326103620.298298-1-tudor.ambarus@linaro.org>
	<CGME20240326103631epcas5p37bc95c57becdeb63b0d8b01ffc6606fb@epcas5p3.samsung.com>
	<20240326103620.298298-4-tudor.ambarus@linaro.org>

Hi Tudor

> -----Original Message-----
> From: Tudor Ambarus <tudor.ambarus@linaro.org>
> Sent: Tuesday, March 26, 2024 4:06 PM
> To: peter.griffin@linaro.org; robh+dt@kernel.org;
> krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org
> Cc: alim.akhtar@samsung.com; linux-arm-kernel@lists.infradead.org; linux-
> samsung-soc@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; andre.draszik@linaro.org;
> willmcvicker@google.com; kernel-team@android.com; Tudor Ambarus
> <tudor.ambarus@linaro.org>
> Subject: [PATCH v2 3/4] arm64: dts: exynos: gs101: join lines close to 80
chars
> 
> These lines fit 81 characters, which is pretty close to 80.
> Join the lines.
> 
Does this breaks checkpatch flow?

> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
For better readability, this looks good.

Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

>  arch/arm64/boot/dts/exynos/google/gs101.dtsi | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 



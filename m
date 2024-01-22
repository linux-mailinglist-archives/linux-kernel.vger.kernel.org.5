Return-Path: <linux-kernel+bounces-32525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D512C835CAD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 069461C21DEC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A4221344;
	Mon, 22 Jan 2024 08:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="e1f+jOVe"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981E6210EE
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 08:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705912332; cv=none; b=jnCsmpJddLmnvFjXwg3TEryBccrN6nsBD5wfGKmXCJD4+yMj1dqqkV8y+JPNeM/TZwd4dExPYFfXQg3ZPMQ3FhF8ljW7Mb+uZkfV9y3kvQ2+JTgeJo5sHkFigar0X+SUVi+/u8NtK2MYrQd0n1UDPRrHzrd8r/zR+NjcYaGagh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705912332; c=relaxed/simple;
	bh=r8RMMePrnokt+ZSxwLfX4KeSzho5CPuG/hIPS3IXFYs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=cg5VcCzScB8cWdIHEwuSDA+Wm+VW45lDQh6E6PULIBYPz3lMOLIElfwrCjQOwHys6OeUvwbFZdwpYgGz2SJ8b/gPWlkVfhNJITFWYl7K+8SgVVj4W8DWZ9P44EVdliVLs2o6Y94EOfOlq7MSND71lwDGyvCPAIrHLx846rEi5vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=e1f+jOVe; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240122083206epoutp01f4e862c311ce830e88905ef08fe1ade8~snjkaWKj42324723247epoutp01V
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 08:32:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240122083206epoutp01f4e862c311ce830e88905ef08fe1ade8~snjkaWKj42324723247epoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1705912326;
	bh=Q9LPucC8reHb0aOkKH2OVTRw75unmT9gWgBiSVlLMbI=;
	h=From:To:Cc:Subject:Date:References:From;
	b=e1f+jOVe+/8fx6X4J3MDQqdRMoRKromZhB0VCODQp3KBrEq5VcJSXkQ+fIm5ff3cf
	 lnJPNXhqolhGhOzvzxs/E/jjluJrUFsBELhdFu1yMeZMD7JZLW9ST281NNWdlqevK8
	 MjwveLGBm6Kd0vTYPj8tzoeWBeY2cwPVZg+wRl9U=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTP id
	20240122083206epcas2p3ec5b42f9b9500a1b32855d79cdb2b436~snjj7VJvG1680416804epcas2p3Z;
	Mon, 22 Jan 2024 08:32:06 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.100]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4TJNkF53Dtz4x9QC; Mon, 22 Jan
	2024 08:32:05 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
	epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	8D.F7.18994.5082EA56; Mon, 22 Jan 2024 17:32:05 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
	20240122083204epcas2p26a1bca522e201972ca072e0b24d23a52~snjilEWn31176011760epcas2p2J;
	Mon, 22 Jan 2024 08:32:04 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240122083204epsmtrp1d662de87164cede84097084f6ffbb349~snjikKGaX0472204722epsmtrp1g;
	Mon, 22 Jan 2024 08:32:04 +0000 (GMT)
X-AuditID: b6c32a4d-743ff70000004a32-39-65ae28058d23
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	43.9B.18939.4082EA56; Mon, 22 Jan 2024 17:32:04 +0900 (KST)
Received: from rack03.dsn.sec.samsung.com (unknown [10.229.95.126]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240122083204epsmtip290d357a363c25a809cb19b11951d9029~snjiWEHmI0795907959epsmtip2S;
	Mon, 22 Jan 2024 08:32:04 +0000 (GMT)
From: SEO HOYOUNG <hy50.seo@samsung.com>
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
	martin.petersen@oracle.com, beanhuo@micron.com, bvanassche@acm.org,
	kwangwon.min@samsung.com, kwmad.kim@samsung.com, sh425.lee@samsung.com,
	sc.suh@samsung.com, quic_nguyenb@quicinc.com, cpgs@samsung.com,
	grant.jung@samsung.com, junwoo80.lee@samsung.com
Cc: SEO HOYOUNG <hy50.seo@samsung.com>
Subject: [PATCH v1] scsi: ufs: core: Remove the ufshcd_release in
 ufshcd_err_handling_prepare
Date: Mon, 22 Jan 2024 17:33:24 +0900
Message-Id: <20240122083324.11797-1-hy50.seo@samsung.com>
X-Mailer: git-send-email 2.26.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLJsWRmVeSWpSXmKPExsWy7bCmuS6rxrpUg9sn1SwezNvGZvHy51U2
	i4MPO1kspn34yWzx8pCmxa+/69ktVi9+wGKx6MY2Jotdf5uZLLbe2MlicXPLURaLy7vmsFl0
	X9/BZrH8+D8mi6kvjrNbdN29wWix9N9bFgdBj8tXvD0mLDrA6PF9fQebx8ent1g8Ju6p8+jb
	sorR4/MmOY/2A91MARxR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmp
	tkouPgG6bpk5QE8oKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgrMC/SKE3OLS/PS
	9fJSS6wMDQyMTIEKE7IzNm/cyVLwg71ixb5zTA2MD9i6GDk5JARMJC509QPZXBxCAnsYJZpe
	P2KFcD4xSvz9tArBeTFhHTtMS1v3NGaIxE5GiQt750M5Pxglum8/AxvMJqAhsebYISaQhIhA
	G7PEyj+XwRLMAmoSn+8uYwGxhQXiJb7M380KYrMIqEr8W74WLM4rYCnxpeknE8Q6eYlFDb+Z
	IOKCEidnPmGBmCMv0bx1NthmCYGFHBL7n1xnhGhwkZg/5x0LhC0s8er4Fqi7pSRe9rcB2RxA
	drHErIXVEL0NjBKHZs+CqjGWmPWsnRGkhllAU2L9Ln2IcmWJI7eg1vJJdBz+C1XNK9Gw8TfU
	RF6JjjYhiLCSxJm5t6HCEhIHZ+dAhD0k1u36BzZFSCBW4s6pk0wTGBVmIflrFpK/ZiGcsICR
	eRWjVGpBcW56arJRgaFuXmo5PJKT83M3MYLTtZbvDsbX6//qHWJk4mA8xCjBwawkwntDcl2q
	EG9KYmVValF+fFFpTmrxIUZTYGhPZJYSTc4HZoy8knhDE0sDEzMzQ3MjUwNzJXHee61zU4QE
	0hNLUrNTUwtSi2D6mDg4pRqYZPsO2Zt/XqXWeyD25OGvmxpW1omk1Oe+VMgM7L8mO69RXijf
	5/Xy5f8duJ7NvsBze8bkkO+LcyY+3PRdc9v+Z5NPfnEofyp7aXHWnjNv99VInKq1DdVifJVw
	f+8Bbou6Hw2lK8unf5tcbNi/8VC94C39n1d2VTR+59v+TSwqx3pR+Xmp2qn+zlHdH/OO+tvb
	LzNV1M198ONC4/fWPze3T+FJZvhyUfxzuJTCF8v93SUnSp6eDNinEP5sywT/EA2X4I47P1dF
	yC5L5/Pestv00jZz/rzbXGm75mpELTDyjg63Xewb8n9XQPTHdZ3fjY1sFhxWbOs5HxHGvFxk
	0w8RJbUDGabyf51ljMxP3i/uUmIpzkg01GIuKk4EADOSTQFgBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsWy7bCSvC6LxrpUg2+nzC0ezNvGZvHy51U2
	i4MPO1kspn34yWzx8pCmxa+/69ktVi9+wGKx6MY2Jotdf5uZLLbe2MlicXPLURaLy7vmsFl0
	X9/BZrH8+D8mi6kvjrNbdN29wWix9N9bFgdBj8tXvD0mLDrA6PF9fQebx8ent1g8Ju6p8+jb
	sorR4/MmOY/2A91MARxRXDYpqTmZZalF+nYJXBmbN+5kKfjBXrFi3zmmBsYHbF2MnBwSAiYS
	bd3TmLsYuTiEBLYzSmy59JodIiEh8X9xExOELSxxv+UIK4gtJPCNUeL/uzIQm01AQ2LNsUNM
	IM0iArOYJZbc+gM2lVlATeLz3WUsILawQKzEzc5XzCA2i4CqxL/la8HivAKWEl+afkItkJdY
	1PCbCSIuKHFy5hMWiDnyEs1bZzNPYOSbhSQ1C0lqASPTKkbR1ILi3PTc5AJDveLE3OLSvHS9
	5PzcTYzg2NAK2sG4bP1fvUOMTByMhxglOJiVRHhvSK5LFeJNSaysSi3Kjy8qzUktPsQozcGi
	JM6rnNOZIiSQnliSmp2aWpBaBJNl4uCUamCayrhffG1hSJBOc3rBQ17TJ4d09vAUPK5Iv37T
	rcNYpOaFZM2VMH4pkxWO2nZRC/nn82Yfqzqh6R1+1/+0Y5d96AG5xlk6vF/0uK7IlfSwnK71
	j1y0Py/K0udRA+eVe5/NPBYYb2Pu+Xrp9uWTaVlXTCyu+PS5hxV8jj1/797LZbcXv17dxSYv
	M4cnf7fv01kZ163VfO/tbLEr+yzbMkvVdXV91Kr6XSo2qxP7vSyCl2udEM08soH9S3Vgfve2
	9lqT2cJP5fZe1Tc/vSJtWvSVtk8TLZxvNdocarvpcJVlWXyQ+eXjfDM/PXedsMnr0+PeK/GH
	mPi/3X1lWFcgUKpqVNDdvkRO3mqNuUJBvBJLcUaioRZzUXEiAIIEG778AgAA
X-CMS-MailID: 20240122083204epcas2p26a1bca522e201972ca072e0b24d23a52
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240122083204epcas2p26a1bca522e201972ca072e0b24d23a52
References: <CGME20240122083204epcas2p26a1bca522e201972ca072e0b24d23a52@epcas2p2.samsung.com>

If err_handler is performed in the suspend/resume situation, ufs_release
can be called twice and active_reqs valid can be negative.
This is because ufshcd_errhandling_prepare() and
ufshcd_err_handling_unprepare() repeatedly release calls.
Eventually, active_reqs have a value different from the intention.
To prevent this, release duplication processing was removed.

Signed-off-by: SEO HOYOUNG <hy50.seo@samsung.com>
---
 drivers/ufs/core/ufshcd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 7c59d7a02243..423e83074a20 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -6351,7 +6351,6 @@ static void ufshcd_err_handling_prepare(struct ufs_hba *hba)
 		ufshcd_hold(hba);
 		if (!ufshcd_is_clkgating_allowed(hba))
 			ufshcd_setup_clocks(hba, true);
-		ufshcd_release(hba);
 		pm_op = hba->is_sys_suspended ? UFS_SYSTEM_PM : UFS_RUNTIME_PM;
 		ufshcd_vops_resume(hba, pm_op);
 	} else {
-- 
2.26.0



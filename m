Return-Path: <linux-kernel+bounces-16178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3882E823A33
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 02:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89638B24965
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 01:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6601878;
	Thu,  4 Jan 2024 01:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mmuYunTt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9871A47
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 01:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240104012456epoutp01382c65faee7c6da19b694dc07dc50d2e~nAHdjEnqA1243912439epoutp01J
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 01:24:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240104012456epoutp01382c65faee7c6da19b694dc07dc50d2e~nAHdjEnqA1243912439epoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1704331496;
	bh=Nq+WiD2ASCtj8k+pc+sy2PFapO5artqTBd5B67HZ+xA=;
	h=From:To:Cc:Subject:Date:References:From;
	b=mmuYunTtFJsTWxS8nxjA654MuipivIpgI/QtCIHqQ6XdQgM4Xwa/bPQPRBJMjzZl7
	 KfxctdQRc0kd0Kb/yuRoWBPvmPK9P3VhODWPY8a7ziA/6HY9eu42wwS018qyTp+uMU
	 G6ZRlkzKOR5BwaHv8UmCZvvFih++yh8F99vDIfBE=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTP id
	20240104012456epcas2p4776cd74d834e68a6e7a482114e7e3ec1~nAHdBbU0S2755027550epcas2p49;
	Thu,  4 Jan 2024 01:24:56 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.89]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4T585g3CTQz4x9QB; Thu,  4 Jan
	2024 01:24:55 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
	epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
	66.17.09607.7E806956; Thu,  4 Jan 2024 10:24:55 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
	20240104012454epcas2p36b58220b4c89ee72f1e095b34d329be2~nAHbuQinc3035330353epcas2p3q;
	Thu,  4 Jan 2024 01:24:54 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240104012454epsmtrp11cce13ff4e26906bb4ee2678170baba0~nAHbtWgyY2678126781epsmtrp1x;
	Thu,  4 Jan 2024 01:24:54 +0000 (GMT)
X-AuditID: b6c32a48-963ff70000002587-19-659608e7a5ca
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	55.A6.18939.6E806956; Thu,  4 Jan 2024 10:24:54 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [10.229.95.128]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240104012454epsmtip21f5ad94dcb86432d724be9c53e07db2c~nAHbhIDoe2426324263epsmtip2k;
	Thu,  4 Jan 2024 01:24:54 +0000 (GMT)
From: Kiwoong Kim <kwmad.kim@samsung.com>
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
	jejb@linux.ibm.com, martin.petersen@oracle.com, beanhuo@micron.com,
	adrian.hunter@intel.com, h10.kim@samsung.com, hy50.seo@samsung.com,
	sh425.lee@samsung.com, kwangwon.min@samsung.com, junwoo80.lee@samsung.com,
	wkon.kim@samsung.com
Cc: Kiwoong Kim <kwmad.kim@samsung.com>
Subject: [PATCH v1] ufs: get target SQ entry within critical section
Date: Thu,  4 Jan 2024 10:24:50 +0900
Message-Id: <1704331491-115325-1-git-send-email-kwmad.kim@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupik+LIzCtJLcpLzFFi42LZdljTVPc5x7RUgyWrxC1OPlnDZvFg3jY2
	i5c/r7JZHHzYyWIx7cNPZou/ty+yWqxe/IDFYtGNbUwWu/42M1lsvbGTxeLmlqMsFpd3zWGz
	6L6+g81i+fF/TBZL/71lsdh86RuLg4DH5SveHov3vGTymLDoAKPH9/UdbB4fn95i8ejbsorR
	4/MmOY/2A91MARxR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkou
	PgG6bpk5QB8oKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgrMC/SKE3OLS/PS9fJS
	S6wMDQyMTIEKE7IzVv6bxlywi6vi27vzbA2Mdzm6GDk5JARMJDYt3cXWxcjFISSwg1Hi7JJV
	TBDOJ0aJFb/es8M5nzeeY+1i5ABraX6tBhHfySjx9sxbRgjnB6PEuu2XWUHmsgloSjy9ORVs
	lIjARyaJzfO3sYMkmAXUJXZNOMEEYgsLuEhcfDGPDWQqi4CqxPd5YSBhXgE3iWVvJ7BD3Ccn
	cfNcJzPIHAmBRg6J+YfnQCVcJH6eus8CYQtLvDq+BSouJfGyvw3KLpZYu+MqE0RzA6PE6len
	oRLGErOetTOCLGYGunT9Ln2Iz5QljtxigTiTT6Lj8F92iDCvREebEESjssSvSZMZIWxJiZk3
	70AN9JDY++YOG4gtJBArcXfXFeYJjLKzEOYvYGRcxSiWWlCcm55abFRgAo+k5PzcTYzgRKnl
	sYNx9tsPeocYmTgYDzFKcDArifCuXzc5VYg3JbGyKrUoP76oNCe1+BCjKTC4JjJLiSbnA1N1
	Xkm8oYmlgYmZmaG5kamBuZI4773WuSlCAumJJanZqakFqUUwfUwcnFINTCy7ZuffSMt7//Df
	qhPfVn+Kn7bb4eMpOfPP7ef/dW6dujTgw4Gs5qVRT3vrY6yPxEvxXSvann7z0+qzGZdrD05k
	T/0tdytX9/WVQs7f6y+kqgtMvFjZ8NH1s4Xaev4b26Yav/5dvMZNJr41uelo0AzrHW9kfkj/
	1dy+kfeBhBXLv/tfk97x9vy4ufVz14SioIkX60SEd0v9UHY+3sH1ao9MG7/VtMe3NTJnHVRg
	6/KZefbjw1sFgTsreZi5PUp7amVUi7i1THnNUwROf54t55lx1fHdhrNPCtM2yOyO8z77uOfo
	py8KqwxPB7Fte+2fXsD6Pn4dd//lZ+5zpeIVFS1TzM5anvH+/Zpli0/JFUElluKMREMt5qLi
	RACiWYtPHQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCLMWRmVeSWpSXmKPExsWy7bCSvO4zjmmpBifua1mcfLKGzeLBvG1s
	Fi9/XmWzOPiwk8Vi2oefzBZ/b19ktVi9+AGLxaIb25gsdv1tZrLYemMni8XNLUdZLC7vmsNm
	0X19B5vF8uP/mCyW/nvLYrH50jcWBwGPy1e8PRbvecnkMWHRAUaP7+s72Dw+Pr3F4tG3ZRWj
	x+dNch7tB7qZAjiiuGxSUnMyy1KL9O0SuDJW/pvGXLCLq+Lbu/NsDYx3OboYOTgkBEwkml+r
	dTFycQgJbGeUuPGgl7GLkRMoLilxYudzKFtY4n7LEVaIom+MEs3N/9lAEmwCmhJPb05lArFF
	BJqZJfqa7EFsZgF1iV0TToDFhQVcJC6+mMcGsoxFQFXi+7wwkDCvgJvEsrcT2CHmy0ncPNfJ
	PIGRZwEjwypG0dSC4tz03OQCQ73ixNzi0rx0veT83E2M4IDVCtrBuGz9X71DjEwcjIcYJTiY
	lUR416+bnCrEm5JYWZValB9fVJqTWnyIUZqDRUmcVzmnM0VIID2xJDU7NbUgtQgmy8TBKdXA
	1P5yq0rZltWSYQuLDThY8/kFjfykRE3eKcry+56MdZnksM9vV7Go/+UD2zKX6XCYh57k5VW6
	rrcjS2i9oOJSAcFjd1Ojn1+b7vOuRHFabGtOZ82s9a2cfrMWnGTQL369pXjJAx69uVF3mEJL
	9kU9CMr/8zBJJcfC+bHHS4/Qt3lCx//OlxFzCxf4wz7RjLHyUcfVrwuKp0Y/uKO8/ca7Pdzx
	Gx4Unksp4c9Key5j+9TDz8Vn65vVmYmrFb/8CpWZ5PtPabXHy+W/e9U9XRef5InZ7CdmOyNV
	TPDmsTNnQh46nlk9iaf23YygR81NxdevW/h+e2Hm6eAc+bD1dPRBn2kWs00Yr7Fn7ExZp9qp
	xFKckWioxVxUnAgADBi78scCAAA=
X-CMS-MailID: 20240104012454epcas2p36b58220b4c89ee72f1e095b34d329be2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240104012454epcas2p36b58220b4c89ee72f1e095b34d329be2
References: <CGME20240104012454epcas2p36b58220b4c89ee72f1e095b34d329be2@epcas2p3.samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

In IO centric scenarios, especially during a period that
many IO requests are submitted to a same HW queue at the same
time, it's found that one reqeust overwrote a SQ entry
that had been already occupied by another request submitted
in the past. And it eventually led to command timed-out
because one of two requests were overwritten, which could not
be completed.

[   74.995185][  T176] exynos-ufs 17100000.ufs: ufshcd_abort: Device abort task at tag 30

Signed-off-by: Kiwoong Kim <kwmad.kim@samsung.com>
---
 drivers/ufs/core/ufshcd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 7bc3fc4..da1a9c0 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -2199,9 +2199,10 @@ void ufshcd_send_command(struct ufs_hba *hba, unsigned int task_tag,
 	if (is_mcq_enabled(hba)) {
 		int utrd_size = sizeof(struct utp_transfer_req_desc);
 		struct utp_transfer_req_desc *src = lrbp->utr_descriptor_ptr;
-		struct utp_transfer_req_desc *dest = hwq->sqe_base_addr + hwq->sq_tail_slot;
+		struct utp_transfer_req_desc *dest;
 
 		spin_lock(&hwq->sq_lock);
+		dest = hwq->sqe_base_addr + hwq->sq_tail_slot;
 		memcpy(dest, src, utrd_size);
 		ufshcd_inc_sq_tail(hwq);
 		spin_unlock(&hwq->sq_lock);
-- 
2.7.4



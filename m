Return-Path: <linux-kernel+bounces-4887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 306E8818352
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 578581C23930
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BBF13FE3;
	Tue, 19 Dec 2023 08:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IYjGGDB+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458E7134BD
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 08:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231219082758epoutp0160a82c40ad8e27cf5bd9ffe01b153684~iLkQNM8Vx3028830288epoutp01D
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 08:27:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231219082758epoutp0160a82c40ad8e27cf5bd9ffe01b153684~iLkQNM8Vx3028830288epoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1702974478;
	bh=Lkyebhrd6+24n9nfaxXooVLJcoZKM0pcEuToIgbdeGU=;
	h=From:To:Cc:Subject:Date:References:From;
	b=IYjGGDB+BTxamjrqtwqJys6c6kj6jeWP9j5OOMzvUmkk5jBI3O6ygkij5IUPuJHqG
	 wtu8kzLpT2D+IneqKnc9OLETdLdpeaK+aJwclWZ7LHzLU7EXcuU8Bz66lfgY6NOcjo
	 hmlySkZNgpi4H9sy1kD3wiAk15CmSkF4OSA8F5xw=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTP id
	20231219082758epcas1p1a948778fb0e77d048cd05cbbb14220d7~iLkPrWCwG2492424924epcas1p1F;
	Tue, 19 Dec 2023 08:27:58 +0000 (GMT)
Received: from epsmgec1p1-new.samsung.com (unknown [182.195.38.242]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4SvVF951JHz4x9Pt; Tue, 19 Dec
	2023 08:27:57 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
	epsmgec1p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	7B.09.19104.D0451856; Tue, 19 Dec 2023 17:27:57 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
	20231219082757epcas1p33bda4e0723d3d57552132054d3e5a3fe~iLkOmFrH10837108371epcas1p3v;
	Tue, 19 Dec 2023 08:27:57 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231219082757epsmtrp26cd44266f4c6ffc8aa51380f26380ad3~iLkOk9DcT1117211172epsmtrp2S;
	Tue, 19 Dec 2023 08:27:57 +0000 (GMT)
X-AuditID: b6c32a4c-80dff70000004aa0-ec-6581540deb96
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	C8.20.18939.C0451856; Tue, 19 Dec 2023 17:27:57 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.100.232]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20231219082756epsmtip2a68e637137f7a0073d3d41aada0ef488~iLkOU2T8k1132911329epsmtip2s;
	Tue, 19 Dec 2023 08:27:56 +0000 (GMT)
From: Chanwoo Lee <cw9316.lee@samsung.com>
To: mani@kernel.org, agross@kernel.org, andersson@kernel.org,
	konrad.dybcio@linaro.org, jejb@linux.ibm.com, martin.petersen@oracle.com,
	linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: grant.jung@samsung.com, jt77.jang@samsung.com, dh0421.hwang@samsung.com,
	sh043.lee@samsung.com, ChanWoo Lee <cw9316.lee@samsung.com>
Subject: [PATCH] scsi: ufs: qcom: Remove unnecessary goto statement from
 ufs_qcom_config_esi function
Date: Tue, 19 Dec 2023 17:27:40 +0900
Message-Id: <20231219082740.27644-1-cw9316.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPJsWRmVeSWpSXmKPExsWy7bCmri5vSGOqwZUnyhbnHv9msdjWYWMx
	41Qbq8W+ayfZLX79Xc9usejGNiaLHc/PsFt0TN7OYjFx/1l2i8u75rBZdF/fwWZx4MMqRovl
	x/8xWTT92cfiwOexaVUnm8eda3vYPCYsOsDo8fHpLRaPvi2rGD0+b5ILYIvKtslITUxJLVJI
	zUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wBulZJoSwxpxQoFJBYXKyk
	b2dTlF9akqqQkV9cYquUWpCSU2BWoFecmFtcmpeul5daYmVoYGBkClSYkJ2x/PQixoJ3HBV7
	5j9jb2BsZ+9i5OSQEDCRuLRpJVsXIxeHkMAeRonH11qZQRJCAp8YJb7eNIdIANl71r0EquIA
	63jXoQYR38kocer5V6juL4wSax72sYAUsQloSdw+5g0SFxF4yiixa8ckFhCHWaCLUeLXwS4W
	kBXCAukSx1ueMoM0sAioSnxcKQ0S5hWwlthyajcrxHnyEn/u9zBDxAUlTs58AtbKDBRv3jqb
	GWSmhEAnh8SVJ+9YIBpcJJY+WwNlC0u8Or4F6k8pic/v9rJBNDQzSix8cxyqewKjxJePt9kg
	quwlmlubwf5kFtCUWL9LH2Ibn8S7rz2sEO/zSnS0CUFUq0jM6TrHBjP/443HUEd7SCye/oIJ
	EoyxEqf2b2OZwCg3C8kPs5D8MAth2QJG5lWMUqkFxbnpqcmGBYa6eanl8NhMzs/dxAhOqVo+
	Oxi/r/+rd4iRiYPxEKMEB7OSCK/LovpUId6UxMqq1KL8+KLSnNTiQ4ymwICdyCwlmpwPTOp5
	JfGGJpYGJmZGJhbGlsZmSuK8Z66UpQoJpCeWpGanphakFsH0MXFwSjUwJVmc23IxlGfZ/mkP
	/jRuMFIvN/E8VJFi671Vs2rmHd13HTkGtSfnPiuM0i42L1nGUjL3xOqzQsuOpzzoj/tV+sqw
	WFrGX+ZT+V1J583ZkzwT96tO2af0oE5q83eGT6WrsupDnnVZun/kjg4IurTQ58b3xqatTt++
	MlcUvnjE8kJfYs4Wla7MLzvXTts4OeWu85+gFl7bUmY3RslwvWN+Sy9USp6ZcOGLgMKmyfEZ
	OUv0L3f3OqdueOyV+e9TWonsPaUp8zpLXq4+xjF9wpWiYLk4uRUXn0n6MT3M3Leh+lxN4P5H
	8atTRV4IeZkbMWWuOnbwZ7Dd0bmJ9l/UX6/5e5tlnubCUB9HMT0FIzU/JZbijERDLeai4kQA
	wriaVTIEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrALMWRmVeSWpSXmKPExsWy7bCSvC5vSGOqwZtVzBbnHv9msdjWYWMx
	41Qbq8W+ayfZLX79Xc9usejGNiaLHc/PsFt0TN7OYjFx/1l2i8u75rBZdF/fwWZx4MMqRovl
	x/8xWTT92cfiwOexaVUnm8eda3vYPCYsOsDo8fHpLRaPvi2rGD0+b5ILYIvisklJzcksSy3S
	t0vgylh+ehFjwTuOij3zn7E3MLazdzFycEgImEi861DrYuTiEBLYzijR/mIfUxcjJ1BcSmL3
	/vNsEDXCEocPF0PUfGKUOHtzNxNInE1AS+L2MW+QuIjAe0aJ/+fXMoM4zAITGCUWX3nLDDJI
	WCBV4vqdGYwgDSwCqhIfV0qDhHkFrCW2nNrNCrFLXuLP/R5miLigxMmZT1hAbGagePPW2cwT
	GPlmIUnNQpJawMi0ilE0taA4Nz03ucBQrzgxt7g0L10vOT93EyM40LWCdjAuW/9X7xAjEwfj
	IUYJDmYlEV6XRfWpQrwpiZVVqUX58UWlOanFhxilOViUxHmVczpThATSE0tSs1NTC1KLYLJM
	HJxSDUwavWcv5YkExjT8yy/6HyqRb3bAL8KuVPrYFY3C8oR/hxLLnu8/cvql+JyZx1ROffuT
	PkMucOGscp+CWVH2p97w3PFSv+u3f+21/farb/HOlFLbdIinYIbG2y7/qinb7Iv8tFeZKV1/
	5sl15gzjWsU918835zUqrHC35/kWx8tULj5jk8obAY654e9KtrUoGTJ/Dl3xz+zA03uZ/fNP
	V1fuce1dV7DhcbHslD/cmWnzhf9dfyyz5LzYr2N1nFOMVopv8RF+mrXbUd4lx/F1wRsn2W88
	Jy0nqCTtaYySWfs7IyNMPv7X9FZNPjn513ffqkT7blcP2zj/+sPwMsPYmFlzL30/buLNahJ1
	ar/J1cNKLMUZiYZazEXFiQBxZjCH4wIAAA==
X-CMS-MailID: 20231219082757epcas1p33bda4e0723d3d57552132054d3e5a3fe
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231219082757epcas1p33bda4e0723d3d57552132054d3e5a3fe
References: <CGME20231219082757epcas1p33bda4e0723d3d57552132054d3e5a3fe@epcas1p3.samsung.com>

From: ChanWoo Lee <cw9316.lee@samsung.com>

There is only one place where goto is used,
and it is unnecessary to check the ret value through 'goto out'
because the ret value is already true.

Therefore, remove the goto statement and
integrate the '!ret' condition into the existing code.

Signed-off-by: ChanWoo Lee <cw9316.lee@samsung.com>
---
 drivers/ufs/host/ufs-qcom.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 17e24270477d..8cf803806326 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -1929,7 +1929,7 @@ static int ufs_qcom_config_esi(struct ufs_hba *hba)
 					     ufs_qcom_write_msi_msg);
 	if (ret) {
 		dev_err(hba->dev, "Failed to request Platform MSI %d\n", ret);
-		goto out;
+		return ret;
 	}
 
 	msi_lock_descs(hba->dev);
@@ -1964,11 +1964,8 @@ static int ufs_qcom_config_esi(struct ufs_hba *hba)
 				      REG_UFS_CFG3);
 		}
 		ufshcd_mcq_enable_esi(hba);
-	}
-
-out:
-	if (!ret)
 		host->esi_enabled = true;
+	}
 
 	return ret;
 }
-- 
2.29.0



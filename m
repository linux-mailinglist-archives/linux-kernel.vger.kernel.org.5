Return-Path: <linux-kernel+bounces-17406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB3E824CC1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 03:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5E571C21E8D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 02:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE834C9F;
	Fri,  5 Jan 2024 02:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="U84Awtko"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F9B1FC8
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 02:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240105021139epoutp0460fcc97c39c874be1cbc9ea9ed8b1daa~nUZiRt6za2838328383epoutp04a
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 02:11:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240105021139epoutp0460fcc97c39c874be1cbc9ea9ed8b1daa~nUZiRt6za2838328383epoutp04a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1704420699;
	bh=C/AtuzkF8iWjKMQX6Oumxw5fvfn0zC3sVDPau/SXw2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U84Awtkomeuh0amjdLfBiPZQlKvocYlBeo2qG5nuZ/vhz4a1wz+93khBlGpd9i5nB
	 hvJrpvnrGTNSArq46qeZSHHmT31bDqyH3Vei6bm46jGX36LceuvyymPuKUuyKucj4x
	 KgB0r1MTW9ZRSo1XZAHyTtbyD3DD7TCutwUzQx9A=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240105021139epcas1p22aeba110aa935e98547d7de2ef732ad7~nUZhvFvCe1382913829epcas1p2F;
	Fri,  5 Jan 2024 02:11:39 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.36.223]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4T5n570DV4z4x9Px; Fri,  5 Jan
	2024 02:11:39 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
	epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
	82.2C.09739.A5567956; Fri,  5 Jan 2024 11:11:38 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
	20240105021138epcas1p3fdfa70996ddbd282c1067de02e39dbd4~nUZhNZy7T2938829388epcas1p3r;
	Fri,  5 Jan 2024 02:11:38 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240105021138epsmtrp19a1b844be0f2970057413a9074b60f8b~nUZhMcw9O2569625696epsmtrp12;
	Fri,  5 Jan 2024 02:11:38 +0000 (GMT)
X-AuditID: b6c32a37-c0bff7000000260b-85-6597655ac821
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	87.B3.08755.A5567956; Fri,  5 Jan 2024 11:11:38 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.100.232]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240105021138epsmtip199cef65cacc1b0e95f64dc375a5c4f8d~nUZg3w29D2103221032epsmtip1X;
	Fri,  5 Jan 2024 02:11:38 +0000 (GMT)
From: Chanwoo Lee <cw9316.lee@samsung.com>
To: alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
	jejb@linux.ibm.com, martin.petersen@oracle.com, stanley.chu@mediatek.com,
	quic_cang@quicinc.com, mani@kernel.org, quic_asutoshd@quicinc.com,
	powen.kao@mediatek.com, quic_nguyenb@quicinc.com, cw9316.lee@samsung.com,
	yang.lee@linux.alibaba.com, peter.wang@mediatek.com, athierry@redhat.com,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: grant.jung@samsung.com, jt77.jang@samsung.com, dh0421.hwang@samsung.com,
	sh043.lee@samsung.com
Subject: [PATCH 1/2] ufs:mcq:Use ufshcd_mcq_req_to_hwq() to simplify
 updating hwq.
Date: Fri,  5 Jan 2024 11:10:40 +0900
Message-Id: <20240105021041.20400-2-cw9316.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20240105021041.20400-1-cw9316.lee@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEJsWRmVeSWpSXmKPExsWy7bCmgW5U6vRUg/ffLC0ezNvGZvFwy1NW
	i5c/r7JZTPvwk9lixqk2Vot9106yW/z6u57dYtGNbUwWO56fYbe4vGsOm0X39R1sFgc+rGK0
	WH78H5PF1k+/WS3e3v3PYrGwYy6LxaRrG9gspr44zm7R9Gcfi8XSrTcZLd41HmZ0EPW4fMXb
	Y9OqTjaPnQ8tPSYsOsDo0XJyP4vHx6e3WDwm7qnzeL/vKptH35ZVjB6fN8l5tB/oZgrgjsq2
	yUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAH6U0mhLDGn
	FCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYFagV5yYW1yal66Xl1piZWhgYGQKVJiQndE1
	7yBLwQuOindzshoY17B3MXJySAiYSFyctZKli5GLQ0hgB6PE64kfmSGcT4wSc6/cYIVwvjFK
	HH64lAmm5cOcGWwQib2MEv86HjJBOF8YJVbOvg/Uz8HBJqAlcfuYN0hcRGAls8TUU6/AFjIL
	pEi86nnHAmILC4RILNzykR2knkVAVeJsTzlImFfAWuLI6rfMEMvkJf7c7wGzOQVsJG6tXMEC
	USMocXLmExaIkfISzVtng50tIfCFQ2L2zumsEM0uEo8u3YQaJCzx6vgWqKelJF72t7FDNDQz
	Six8cxyqewKjxJePt9kgquwlmlub2UCuYxbQlFi/Sx9iG5/Eu689rCBhCQFeiY42IYhqFYk5
	XefYYOZ/vPEY6gYPiRkPbkEDqJ9RYuvRVsYJjPKzkDwxC8kTsxC2LWBkXsUollpQnJueWmxY
	YAyP1uT83E2M4MSuZb6DcdrbD3qHGJk4GA8xSnAwK4nwrl83OVWINyWxsiq1KD++qDQntfgQ
	oykwhCcyS4km5wNzS15JvKGJpYGJmZGJhbGlsZmSOO+ZK2WpQgLpiSWp2ampBalFMH1MHJxS
	DUxzomKi6vYWmgVsP65SEvd6084uEVOtX662R5gniCfal7qVp4pMmrOi1vR3aOEDhZ13krck
	7lX0501yb9qrP+1m44a2Hf4+pdz6yVuK5D96LNqvV6Bk90smbaM6d5H9FF+j6JJe8emfWKfJ
	/asTX3PoXeYT7frMrc1WOnoZcyrXbrnzbGHunV1Bk1S0jnWfPxHxZN/0YvfMKQ8/9Gm4LPz8
	/K9I6tpnD3SWXxY/w8Aa1HXxy1KezJrI+RJXnF78qSr0cKnQ3Tb1+3I5+VesQWVWM7mudmvf
	nR+S7+H0W2ujkLhU7crphvdKqt1C9Fe4TJBwdGA7+TSp0WiLVHvY7en3PI73bUm8lzHzWKf2
	EyWW4oxEQy3mouJEABosJfJ1BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMIsWRmVeSWpSXmKPExsWy7bCSnG5U6vRUg5NPpSwezNvGZvFwy1NW
	i5c/r7JZTPvwk9lixqk2Vot9106yW/z6u57dYtGNbUwWO56fYbe4vGsOm0X39R1sFgc+rGK0
	WH78H5PF1k+/WS3e3v3PYrGwYy6LxaRrG9gspr44zm7R9Gcfi8XSrTcZLd41HmZ0EPW4fMXb
	Y9OqTjaPnQ8tPSYsOsDo0XJyP4vHx6e3WDwm7qnzeL/vKptH35ZVjB6fN8l5tB/oZgrgjuKy
	SUnNySxLLdK3S+DK6Jp3kKXgBUfFuzlZDYxr2LsYOTkkBEwkPsyZwdbFyMUhJLCbUeJF72pm
	iISUxO7954ESHEC2sMThw8UgYSGBT4wSM+/bg4TZBLQkbh/zBgmLCOxnljjdFgtiMwtkSHz7
	eIIJxBYWCJKYeP4H2BQWAVWJsz3lIGFeAWuJI6vfQi2Sl/hzvwfM5hSwkbi1cgULxCZriVUv
	brBA1AtKnJz5hAVivLxE89bZzBMYBWYhSc1CklrAyLSKUTK1oDg3PbfYsMAwL7Vcrzgxt7g0
	L10vOT93EyM4HrU0dzBuX/VB7xAjEwfjIUYJDmYlEd716yanCvGmJFZWpRblxxeV5qQWH2KU
	5mBREucVf9GbIiSQnliSmp2aWpBaBJNl4uCUamCasWCv7blKrd3LHvKovt7L89dbJG3Ds9ne
	IqZBvqsnHNZYsmge37vqxeqeV7u2C9y5V8PHscLuKYvZhV6joiM3bn7nFf2alipaNf//jBxe
	qetL2uc4/mz93LhOprTop2uu3EWF8J73yf9cp3Eemu/VIsSz5ppN/6+etBZN34XPf545HjUr
	9EDJMpHdYiJTA5adUlS+onLguF+/Ipfoq9Jr7xeLX93m2+5aYR4y+6erwWZm+ZBSe/ftS++x
	RAtL8AfyrXn893NT0I9ZaSyfrmx6Ofd8h0c2VzTb1mgtxxZdA/+qMLPu93eC9s3XqTY9mMDK
	cNts42cx+TvPmmRPa6WeuDmzbZ+Q+mV9g9VZi38osRRnJBpqMRcVJwIAX7RxAjYDAAA=
X-CMS-MailID: 20240105021138epcas1p3fdfa70996ddbd282c1067de02e39dbd4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240105021138epcas1p3fdfa70996ddbd282c1067de02e39dbd4
References: <20240105021041.20400-1-cw9316.lee@samsung.com>
	<CGME20240105021138epcas1p3fdfa70996ddbd282c1067de02e39dbd4@epcas1p3.samsung.com>

From: ChanWoo Lee <cw9316.lee@samsung.com>

Use ufshcd_mcq_req_to_hwq() to remove unnecessary variables and simplify.

Signed-off-by: ChanWoo Lee <cw9316.lee@samsung.com>
---
 drivers/ufs/core/ufshcd.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 30df6f6a72c6..c9d122302889 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -5597,7 +5597,6 @@ static void ufshcd_mcq_compl_pending_transfer(struct ufs_hba *hba,
 	struct ufshcd_lrb *lrbp;
 	struct scsi_cmnd *cmd;
 	unsigned long flags;
-	u32 hwq_num, utag;
 	int tag;
 
 	for (tag = 0; tag < hba->nutrs; tag++) {
@@ -5607,9 +5606,7 @@ static void ufshcd_mcq_compl_pending_transfer(struct ufs_hba *hba,
 		    test_bit(SCMD_STATE_COMPLETE, &cmd->state))
 			continue;
 
-		utag = blk_mq_unique_tag(scsi_cmd_to_rq(cmd));
-		hwq_num = blk_mq_unique_tag_to_hwq(utag);
-		hwq = &hba->uhq[hwq_num];
+		hwq = ufshcd_mcq_req_to_hwq(hba, scsi_cmd_to_rq(cmd));
 
 		if (force_compl) {
 			ufshcd_mcq_compl_all_cqes_lock(hba, hwq);
-- 
2.29.0



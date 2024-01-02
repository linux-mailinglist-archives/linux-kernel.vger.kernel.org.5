Return-Path: <linux-kernel+bounces-13971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C594082162B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 02:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 621331C20FD6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 01:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C748ED4;
	Tue,  2 Jan 2024 01:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QektgXHb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A5BA38
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 01:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240102014250epoutp03491323de9db6f130c767e08ac55b28b3~mZEgxV7hJ1312313123epoutp03L
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 01:42:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240102014250epoutp03491323de9db6f130c767e08ac55b28b3~mZEgxV7hJ1312313123epoutp03L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1704159770;
	bh=8sLtjEDMeFIi8jyEkduGnUHIg8g1Fdyp7Qi6v42ZhP8=;
	h=From:To:Cc:Subject:Date:References:From;
	b=QektgXHb0xlap6wplCWBQ1RzpVPmP2LRVn9JuUQndRt6MfvXN8FQF42DLA1Z2SiFY
	 2cWTlgPyeizBUTAnd8Ck4C6aZAiubUbS9RZHjq5j5V8ZP4Z/7ieIa7zTtjGE1aHFvJ
	 x8WYY15H//D/O9DrxApoL3O5ny13FAI+ApSvupiA=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240102014249epcas1p14e28e3df596b7ccd72400e23b478d261~mZEgKXM3e2406324063epcas1p1h;
	Tue,  2 Jan 2024 01:42:49 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.38.250]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4T3wbF12YPz4x9Q3; Tue,  2 Jan
	2024 01:42:49 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
	epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
	77.B5.10025.81A63956; Tue,  2 Jan 2024 10:42:49 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
	20240102014248epcas1p4d49dcf2cd3f020bed88eebaeba648789~mZEfUh2a60046900469epcas1p4U;
	Tue,  2 Jan 2024 01:42:48 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240102014248epsmtrp17bfd39fc9dfbd241d949e28cdfa6d029~mZEfTaC8n2806828068epsmtrp1M;
	Tue,  2 Jan 2024 01:42:48 +0000 (GMT)
X-AuditID: b6c32a39-c2bf870000002729-4f-65936a187ac0
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	9F.3D.08755.81A63956; Tue,  2 Jan 2024 10:42:48 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.100.232]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240102014248epsmtip114aef6f4970f221117d0c09b76455d12~mZEe-1hc50447704477epsmtip1D;
	Tue,  2 Jan 2024 01:42:48 +0000 (GMT)
From: Chanwoo Lee <cw9316.lee@samsung.com>
To: alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
	jejb@linux.ibm.com, martin.petersen@oracle.com, peter.wang@mediatek.com,
	chu.stanley@gmail.com, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com, stanley.chu@mediatek.com,
	quic_cang@quicinc.com, mani@kernel.org, quic_asutoshd@quicinc.com,
	powen.kao@mediatek.com, quic_nguyenb@quicinc.com,
	yang.lee@linux.alibaba.com, athierry@redhat.com, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Cc: grant.jung@samsung.com, jt77.jang@samsung.com, dh0421.hwang@samsung.com,
	sh043.lee@samsung.com, ChanWoo Lee <cw9316.lee@samsung.com>
Subject: [PATCH v3] ufs: mcq: Add definition for REG_UFS_MEM_CFG register
Date: Tue,  2 Jan 2024 10:42:22 +0900
Message-Id: <20240102014222.23351-1-cw9316.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta0xTZxj26zk9LZqyY3XyyQ9gjZjAxqVc6tdNKtmUHMAEki3GEbl07Qkw
	oK09hU2zSaVyseJoS5DLmJsGNOIchtta47gmq2zIhkBluo4pdhsELDAk46KstLD5732ePM/7
	vO/75eNi/OeELzdboaHVCmmugNiKd/QFhYXs/rCSDj9fg6HfL3YQ6N41iB61OdhocmmUQBdm
	lzC0MNSFoZofStio09bPQcvPmzno8lgHC5n/HOCglgkbGw3fqifQsG4IoHP3zQTqnm0C6Kr1
	BQsVnYlE7fMrbDRjX8PRpbIvcGSy3SRQ1V9WDipa7cRRY/svAD093QdifanhkUTKbG8AlKXO
	zqFams4SlOWRmDJc7gZUa0Mhdaa/C6fmHA9wynj7FOXsHCWoz9qaAPV3ix9V2n2OleydkrM/
	i5bKaXUArZAp5dmKzBhB4rvp76RHi8KFIUIx2icIUEjz6BjBwcPJIXHZua5jCAIKpLn5LipZ
	yjCCMMl+tTJfQwdkKRlNjIBWyXNVIlUoI81j8hWZoQpa86YwPDwi2iXMyMlyrFo5qka/j2u1
	/UAL/titB15cSEbBlRkTSw+2cvmkGcDxL3twD5h3Aec08IBFAPtuDLA3LfcbyzZU3wHYoddi
	HrAAoHXK5LJwuQQZDB9+n7jO7yQtOJy0r7hbYaQewOUePb7eagcZD4e/mXbXOBkI7xlG3DWP
	fAv+XGTbiPOHq+PlmIffDvtrn7g1mIvXtX/uToZktRfsumLieAwH4Wj5A8xT74BT1rYN3hdO
	VpRwPAYdgJemrRtuA4ALcw8Jj+oA1BXriPUdMDIINt8K86R5w6fPytnrNCR5sKyE71HvgfX6
	QWKz/9zYxMbQFKywV7pn4JOpsKdzgjAAv7qXdqh7aYe6/8O+AlgT2EWrmLxMmhGqov97TJky
	rwW4/0Gw2AyqZ2ZDewGLC3oB5GKCnbxlSwXN58mlJ07SamW6Oj+XZnpBtOuqRsz3VZnS9ZEU
	mnRhlDg8ShQRhSLFkSKBD29gpIDmk5lSDZ1D0ypaveljcb18tazUwiljvO76gijCGKA1VpXe
	OVJve2wJ46SJf3ut9keDfhdWyHtD1fg+y+GULbDG8j7pyfi2KvbF1Yt9+SfGQeW2zthpeUjv
	wGzQYumxUOy4cUpyct+ibn4ocrHf/+15+WH10b13K7YcOdT23vGj1YYE05jzU0mr5NTjwY+C
	HVWDsoS0bd0470pKcrHxfILjg+Svg+sYfOmOKGnF/lPtbX9tau9Y2t2bQUPLxc7ms9G/Fuhe
	f9IoSY/9xxIi82bW6tcOxF+oaR1fpDJOW+aPLetj9/oU6LZk1aQgiaYisDspjF3Z4LzRkWTz
	CWQGkWmALIkbjDtE9m1/JclBWXqIZ1YBzmRJhcGYmpH+C2DmRq+QBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKIsWRmVeSWpSXmKPExsWy7bCSnK5E1uRUg8af8hYP5m1js7i0UsLi
	4ZanrBYvf15ls5j24SezxZeL+5ktZpxqY7XYd+0ku8Wvv+vZLRbd2MZkseP5GXaLTY+vsVpc
	3jWHzeJy80VGi+7rO9gsDnxYxWix/Pg/JoumFmOLrZ9+s1q8vfufxWJhx1wWi0nXNrBZTH1x
	nN2i6c8+FoulW28yWrxrPMzoIOVx+Yq3x467Sxg9ds66y+6xaVUnm8fOh5YeExYdYPTYvKTe
	o+XkfhaPj09vsXhM3FPn8X7fVTaPvi2rGD0+b5LzaD/QzRTAF8Vlk5Kak1mWWqRvl8CV8fTP
	cfaCpXIVMxtOMjYwPpPsYuTkkBAwkbi+tIOli5GLQ0hgN6PE/SnbWSASUhK7959n62LkALKF
	JQ4fLoao+cQo8ebuZHaQOJuAlsTtY94gcRGBiywSN57MYgJxmAUmMEosvvKWGWSQsICnxOV1
	b8CGsgioSlyacAXM5hWwlrjQdI0VYpm8xJ/7PcwQcUGJkzOfgNUwA8Wbt85mnsDINwtJahaS
	1AJGplWMkqkFxbnpucWGBYZ5qeV6xYm5xaV56XrJ+bmbGMExq6W5g3H7qg96hxiZOBgPMUpw
	MCuJ8P7a2Z8qxJuSWFmVWpQfX1Sak1p8iFGag0VJnFf8RW+KkEB6YklqdmpqQWoRTJaJg1Oq
	gck/wMozdgpL3ZMphXNKLjrLnjuyRXRHwVp3JmEtxcL3v2/0eJV2KEaFzlZu2vGyKLBZOTEq
	cM5GFtl/S871mHGu8P9q3ndGrvQEL+fc0zemGxycmR1oHHYw4D57VOsfRYZlnzxzKnxffp55
	QufJMb7ul5+6n3knv5ocsMXFacL2nCnehw+yLvzCJ2Fpp5RUOHvnuWk2M7WDzi0++Np4tcax
	CSWffp83eCd7vvWlmcmjmzMOP+6LLjF0E17jKRCtXXjI3j0m6b/2bRMD3sPHe7M4Vr80sHXY
	uj2u8uDRs07L2H/Pcp69PT9G/+eqVLOO20Xnt7bVBQZuDnJ+e4FluvTFNEs3BrNSgUKTOp1I
	SSWW4oxEQy3mouJEAFz6MTBIAwAA
X-CMS-MailID: 20240102014248epcas1p4d49dcf2cd3f020bed88eebaeba648789
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240102014248epcas1p4d49dcf2cd3f020bed88eebaeba648789
References: <CGME20240102014248epcas1p4d49dcf2cd3f020bed88eebaeba648789@epcas1p4.samsung.com>

From: ChanWoo Lee <cw9316.lee@samsung.com>

Instead of hardcoding the register field, add the proper definition. While
at it, let's also use ufshcd_rmwl() to simplify updating this register.

Reviewed-by: Peter Wang <peter.wang@mediatek.com>
Signed-off-by: ChanWoo Lee <cw9316.lee@samsung.com>
---
* v2->v3: Change subject and description
  v2 : https://patchwork.kernel.org/project/linux-scsi/patch/20231221065608.9899-1-cw9316.lee@samsung.com/

* v1->v2:
  v1 : https://patchwork.kernel.org/project/linux-scsi/patch/20231220052737.19857-1-cw9316.lee@samsung.com/
   1) Excluding ESI_ENABLE
   2) Replace with ufshcd_rmwl, BIT()
   3) Separating hba->mcq_enabled
---
 drivers/ufs/core/ufs-mcq.c      | 6 ++++++
 drivers/ufs/core/ufshcd.c       | 4 +---
 drivers/ufs/host/ufs-mediatek.c | 4 +---
 include/ufs/ufshcd.h            | 1 +
 include/ufs/ufshci.h            | 3 +++
 5 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index 0787456c2b89..edc752e55878 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -399,6 +399,12 @@ void ufshcd_mcq_enable_esi(struct ufs_hba *hba)
 }
 EXPORT_SYMBOL_GPL(ufshcd_mcq_enable_esi);
 
+void ufshcd_mcq_enable(struct ufs_hba *hba)
+{
+	ufshcd_rmwl(hba, MCQ_MODE_SELECT, MCQ_MODE_SELECT, REG_UFS_MEM_CFG);
+}
+EXPORT_SYMBOL_GPL(ufshcd_mcq_enable);
+
 void ufshcd_mcq_config_esi(struct ufs_hba *hba, struct msi_msg *msg)
 {
 	ufshcd_writel(hba, msg->address_lo, REG_UFS_ESILBA);
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index ae9936fc6ffb..30df6f6a72c6 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -8723,9 +8723,7 @@ static void ufshcd_config_mcq(struct ufs_hba *hba)
 	hba->host->can_queue = hba->nutrs - UFSHCD_NUM_RESERVED;
 	hba->reserved_slot = hba->nutrs - UFSHCD_NUM_RESERVED;
 
-	/* Select MCQ mode */
-	ufshcd_writel(hba, ufshcd_readl(hba, REG_UFS_MEM_CFG) | 0x1,
-		      REG_UFS_MEM_CFG);
+	ufshcd_mcq_enable(hba);
 	hba->mcq_enabled = true;
 
 	dev_info(hba->dev, "MCQ configured, nr_queues=%d, io_queues=%d, read_queue=%d, poll_queues=%d, queue_depth=%d\n",
diff --git a/drivers/ufs/host/ufs-mediatek.c b/drivers/ufs/host/ufs-mediatek.c
index fc61790d289b..1048add66419 100644
--- a/drivers/ufs/host/ufs-mediatek.c
+++ b/drivers/ufs/host/ufs-mediatek.c
@@ -1219,9 +1219,7 @@ static int ufs_mtk_link_set_hpm(struct ufs_hba *hba)
 		ufs_mtk_config_mcq(hba, false);
 		ufshcd_mcq_make_queues_operational(hba);
 		ufshcd_mcq_config_mac(hba, hba->nutrs);
-		/* Enable MCQ mode */
-		ufshcd_writel(hba, ufshcd_readl(hba, REG_UFS_MEM_CFG) | 0x1,
-			      REG_UFS_MEM_CFG);
+		ufshcd_mcq_enable(hba);
 	}
 
 	if (err)
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index d862c8ddce03..a96c45fa4b4b 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -1257,6 +1257,7 @@ unsigned long ufshcd_mcq_poll_cqe_lock(struct ufs_hba *hba,
 					 struct ufs_hw_queue *hwq);
 void ufshcd_mcq_make_queues_operational(struct ufs_hba *hba);
 void ufshcd_mcq_enable_esi(struct ufs_hba *hba);
+void ufshcd_mcq_enable(struct ufs_hba *hba);
 void ufshcd_mcq_config_esi(struct ufs_hba *hba, struct msi_msg *msg);
 
 int ufshcd_opp_config_clks(struct device *dev, struct opp_table *opp_table,
diff --git a/include/ufs/ufshci.h b/include/ufs/ufshci.h
index d5accacae6bc..2a6989a70671 100644
--- a/include/ufs/ufshci.h
+++ b/include/ufs/ufshci.h
@@ -282,6 +282,9 @@ enum {
 /* UTMRLRSR - UTP Task Management Request Run-Stop Register 80h */
 #define UTP_TASK_REQ_LIST_RUN_STOP_BIT		0x1
 
+/* REG_UFS_MEM_CFG - Global Config Registers 300h */
+#define MCQ_MODE_SELECT 	BIT(0)
+
 /* CQISy - CQ y Interrupt Status Register  */
 #define UFSHCD_MCQ_CQIS_TAIL_ENT_PUSH_STS	0x1
 
-- 
2.29.0



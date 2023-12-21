Return-Path: <linux-kernel+bounces-7908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9B181AEFA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 07:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 966FD1F244C7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 06:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79BCAD29F;
	Thu, 21 Dec 2023 06:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ZBbI+85O"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AE5C2E3
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 06:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231221065639epoutp015e486700a71797795bdbc24379ecf5e6~ixnFfJdX-2133721337epoutp01N
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 06:56:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231221065639epoutp015e486700a71797795bdbc24379ecf5e6~ixnFfJdX-2133721337epoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1703141799;
	bh=9gFL3uCthOMnQkTwrbPanBRwPVZKyEWGArY0eovPAM8=;
	h=From:To:Cc:Subject:Date:References:From;
	b=ZBbI+85OF6bbY1/CxE4PVDNoRdJqz9mMYEP9pm+SScfJI3wFUjoQ51HTqtrN8DN7P
	 MyV6k5LRdVBBI59tNl61HEWxC6i+nEHKbYf/I89NtVl+HPdHdVL9FXt0Exc5ia4Wat
	 g7L07k52Xdjr5QKS9zicIEjzA80sfD7aaDEEs4sU=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTP id
	20231221065638epcas1p4bd597d940f7b5477bec514586d2dfdb3~ixnEy-5Ad1052110521epcas1p4E;
	Thu, 21 Dec 2023 06:56:38 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.36.225]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4Swh6s74hXz4x9Pv; Thu, 21 Dec
	2023 06:56:37 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
	epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
	BB.0F.10025.5A1E3856; Thu, 21 Dec 2023 15:56:37 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20231221065637epcas1p203dcd5cfb1d4a3964fff9543a041d78d~ixnDvEQvp2639826398epcas1p2V;
	Thu, 21 Dec 2023 06:56:37 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20231221065637epsmtrp134b2375a6dabf4539c8f416dedb1a507~ixnDs1CTz3242132421epsmtrp1U;
	Thu, 21 Dec 2023 06:56:37 +0000 (GMT)
X-AuditID: b6c32a39-9d9ff70000002729-94-6583e1a5ee57
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	D3.72.08817.5A1E3856; Thu, 21 Dec 2023 15:56:37 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.100.232]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20231221065637epsmtip2a3a1ef3dce1a1ec17cf901744b8b121e~ixnDXVdkT2484324843epsmtip2t;
	Thu, 21 Dec 2023 06:56:37 +0000 (GMT)
From: Chanwoo Lee <cw9316.lee@samsung.com>
To: alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
	jejb@linux.ibm.com, martin.petersen@oracle.com, peter.wang@mediatek.com,
	chu.stanley@gmail.com, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com, stanley.chu@mediatek.com,
	quic_cang@quicinc.com, mani@kernel.org, quic_asutoshd@quicinc.com,
	powen.kao@mediatek.com, quic_nguyenb@quicinc.com,
	yang.lee@linux.alibaba.com, beanhuo@micron.com, Arthur.Simchaev@wdc.com,
	ebiggers@google.com, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Cc: grant.jung@samsung.com, jt77.jang@samsung.com, dh0421.hwang@samsung.com,
	sh043.lee@samsung.com, ChanWoo Lee <cw9316.lee@samsung.com>
Subject: [PATCH v2] ufs: mcq: Adding a function for MCQ enable
Date: Thu, 21 Dec 2023 15:56:08 +0900
Message-Id: <20231221065608.9899-1-cw9316.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta0xTZxjO13N6WnDMQ2XuGxpW6zYirEChwIcBHJFsZ2PZ2OXXloWd0LNC
	oJf1IsNk4ChyqYqiTKWiIIPCkK6kXERWkJaFjo0pF0WQEEBGBCMKCA4ZjrUUN/8975Pn+d73
	eb+8XIyXz/Hlpso1jEpOpwsIT7yla0+wsHpSx4T8fD4cTVxoIdDAjxAVFhvZaPbJTQLZJgtx
	dHr+CYaW+q9i6OxveWzUMdTDQf2Xctlo9amZgyqHW1io9W4vB1mmhthosK2MQIO6foCO3Gol
	UOd8HUA1jn9YKCc3DDUv/s1Gc2PrOLpYcB5HJ4caCPT9jIODctY6cFTdPALQg++6wFs7qcEb
	CVTrWBWgrhjGOFSFRUtZ6goJ6spkFHWishNQjVXZVG7PVZz6y1xAUAvTt3Gq2JpFFTXVAeqR
	xY/K7zzCStz6WVp0CkNLGBWfkScrJKlyaYwg4ZOk/UnhESEioSgKRQr4clrGxAji308Uvp2a
	7lyNgH+ATtc6qURarRYEx0arFFoNw09RqDUxAkYpSVdGKIPUtEytlUuD5IxmrygkJDTcKfwy
	LaWrY4qt7N35TV/J9kPgFNQDDy4kxbBqfZnlwjyyFcBho1YPPJ14EcAzOivhLh4DaDtnZOsB
	d8PRbcpw8+0AXrL14e5iCcCcu/cwl4ggA+Bod4KL9yFncDhtrGW5CozUA7hq0+OuftvIWNiw
	eHkD4+TrcGLoNMeFvci98FixFbjnexWujR/F3Lw37Cn9c0OPOXld8znM9Sgkf/CAlY9MbLch
	HlabB1huvA3eczRx3NgXzh7P47gNOgAv3ndsuk8AuLQwSrhV+6DusI5wZcDIPdDcFuzu9iJ8
	sHx0M78XLMjjudWvwTL9NeLZ+wvDU5szULCr7yRwyXnkF/BxueIE8DM8F8HwXATD/70qAFYH
	tjNKtUzKqEXK8P8+Mlkhs4CNiwiIagVn5uaD7IDFBXYAuZjAx6u9MIfheUnozIOMSpGk0qYz
	ajsIdy61GPN9KVnhPCm5JkkkjgoRR4SKUVhUWITgZa/eGwcYHimlNUwawygZ1TMfi+vhe4hV
	0Gq4ExYo1+2X6D/99R0yPLKiqM0k03dKPs79/I6k/PauHddrFt5c42fWrTwspu3l0kz/xbJu
	fkznRIzQT3Ph/lokHbdLeqrhp/cM9LH2rHph79zgG/b4F0ZKSsiFLfHr7/5hxXYn2G+FFvkH
	ZJrzqfGh5f5YUy17aWqW2ve12bvUKPSR1gfFzc78nmFdEYyu9gUEmU1BfhkTiy0TvezSkkbH
	9IA5UwW5uuoPxjOmcV1T/cODK/Em6/Gtnteyz/puaXB8FK37dndXcrAx8PpXS8PsnF8sH8Zl
	1wZetuywiguiCw/XaEZeuSmz2QxNRovYOwU1+D+d54P8rK7G1AUBrk6hRQGYSk3/C5urgJia
	BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02RfVDLcRzH77vfw351pp/q+EqnjDx0pyKnL0c4h99dOo7zFIedftZOm2wl
	+aOy7dSWnjA0SWJcG8lSVk1bLTHH9cSQ2ynPIlYhJWF17vz3vtf7de/PHx8K87bifpRIkshK
	JYJ4PumJV9n4AXN1XQo2rKODhzqLqkjUVgqRKv8ygT4MPiZRfZcKR6dcgxj62mrB0Jn7RwlU
	57BzUatBSaChX9e5qORpFQeZ3j3gIuMrB4HaawpJ1K5oBSjriYlEVpceoCt3RzhIrgxHlX0/
	CdTj/I2jC5nncHTcUU4izfu7XCQfrsORrvIZQJ+P2MByf6b9URRjcl4CTLXWyWWKjUmMUa8i
	mequRUxeiRUwFZfSGKXdgjMD1zNJpvdNB87km1OZnJt6wPQbpzIZ1izOeq8YzyWxbLzoICsN
	jdztGWere0UkPPA/1HJyYjo4AdWAoiC9ADZdS1YDT8qbrgVQ90ODqYHHX+4Hay3N5JjjA202
	2ZjTB6DT/p1wc5IOhs+boty6Ly0noFId6HYwOg/Ai496Rnd86EhY3ncLd2ecDoKdjlNcd+bR
	i2F2vhmM3QqAwy+OYWN8ArQXvB71sb9cUXkWywPjtf9V2v+qYsDRg8lsgkwsFMvmJcyXsMkh
	MoFYliQRhuzZLzaC0ScHB5uAWe8KaQAcCjQASGF8X95tlZz15sUKUg6z0v27pEnxrKwBTKFw
	/iTe94/Zsd60UJDI7mPZBFb6r+VQHn7pnEmxmh0r78yO1jjqSzICVMve7R7YGt2vHnGsaItJ
	zh1qvBF2r3Ny+tXOhzNVkRviDKff2geflCkHI4SKJuR71o/rKmu2XKgXCZIOWmq7jw+Z10wp
	lu9sdPbD4YqWxqXlU4tCX256fl8aYZxO+NRHFJ3fluoVZpgWFJg68E2HWjeOHKAXSgptIZhH
	WUnPnrTMovgwl3yBskahywvcYpjDwSMTpd3XVOsHiC2/yvYOa7OEYMOncYLEn9vbl2m+1sw2
	LN8c9SUg25rdlGLMeRYqWu1fED69t2FtRuGsY9rwq+Kg8yLSq892Irp0Y/W6Ga9Ls1y3VhWc
	NltMOblcw0w8t5mPy+IE84IxqUzwBxykXBJTAwAA
X-CMS-MailID: 20231221065637epcas1p203dcd5cfb1d4a3964fff9543a041d78d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231221065637epcas1p203dcd5cfb1d4a3964fff9543a041d78d
References: <CGME20231221065637epcas1p203dcd5cfb1d4a3964fff9543a041d78d@epcas1p2.samsung.com>

From: ChanWoo Lee <cw9316.lee@samsung.com>

The REG_UFS_MEM_CFG register is too general(broad)
and it is difficult to know the meaning only with a value of 0x1.
So far, comments were required.

Therefore, I have added new functions and defines
to improve code readability/reusability.

Signed-off-by: ChanWoo Lee <cw9316.lee@samsung.com>

* v1->v2:
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



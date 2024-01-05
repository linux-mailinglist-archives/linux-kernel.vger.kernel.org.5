Return-Path: <linux-kernel+bounces-17408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82BE3824CC4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 03:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF66CB23422
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 02:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FECC1DFDE;
	Fri,  5 Jan 2024 02:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="X7t8WXOo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDB51DFC4
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 02:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240105021225epoutp04a651d7ee0c241565f6973c6f141f00d5~nUaMw3EPT2716427164epoutp04H
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 02:12:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240105021225epoutp04a651d7ee0c241565f6973c6f141f00d5~nUaMw3EPT2716427164epoutp04H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1704420745;
	bh=dZVb79P+qvTVTPnXDcb6hSixeCMAiEBLHc2YBjIHyJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X7t8WXOoO5p7W34ud3FXqxMQcKbi9akktGrnFH5eiIaauiXo4QMRUmuvkFTnhUVu5
	 PfvxX+v/iwoTPiw5iPGq8Vy4bmzXvoVbOe7O1dzc+goRpqtdVsdriQuzJyaTE50lEy
	 EG+LzpIUhegGb0UxIkLrZaBU1qugXgtocuD7Rp28=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTP id
	20240105021224epcas1p3833c624d783a76f90b309fd68f0bb91c~nUaLnMY6G1090310903epcas1p3p;
	Fri,  5 Jan 2024 02:12:24 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.38.248]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4T5n5z56m9z4x9QC; Fri,  5 Jan
	2024 02:12:23 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
	epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	5B.93.09744.78567956; Fri,  5 Jan 2024 11:12:23 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240105021223epcas1p156208a9a445b5e0b527a9eb2d2589ed3~nUaKngZV_0053900539epcas1p12;
	Fri,  5 Jan 2024 02:12:23 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240105021223epsmtrp1a71c939bc2231410859ad3fdaafec842~nUaKmgFZg2623726237epsmtrp1m;
	Fri,  5 Jan 2024 02:12:23 +0000 (GMT)
X-AuditID: b6c32a35-107fa70000002610-02-65976587a7b0
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F2.6C.07368.68567956; Fri,  5 Jan 2024 11:12:22 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.100.232]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240105021222epsmtip1d273cc1fb5d846ef2fe7a27b5d4b53db~nUaKPuQwd2152021520epsmtip1e;
	Fri,  5 Jan 2024 02:12:22 +0000 (GMT)
From: Chanwoo Lee <cw9316.lee@samsung.com>
To: alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
	jejb@linux.ibm.com, martin.petersen@oracle.com, stanley.chu@mediatek.com,
	quic_cang@quicinc.com, mani@kernel.org, quic_asutoshd@quicinc.com,
	powen.kao@mediatek.com, quic_nguyenb@quicinc.com, cw9316.lee@samsung.com,
	yang.lee@linux.alibaba.com, peter.wang@mediatek.com, athierry@redhat.com,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: grant.jung@samsung.com, jt77.jang@samsung.com, dh0421.hwang@samsung.com,
	sh043.lee@samsung.com
Subject: [PATCH 2/2] ufs:mcq:Remove unused parameters
Date: Fri,  5 Jan 2024 11:10:41 +0900
Message-Id: <20240105021041.20400-3-cw9316.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20240105021041.20400-1-cw9316.lee@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Tf0xTVxTHc/va14eu27Ogu+nCj9RphARogbKLwiQB9S0Qx6b8MbcFK32j
	DGhLX4tANsYoIKtEigtjMjdBpxNChCHUgsAQorXoxA1Qh3PAtAzY+FGGlh8Co7y5+d8593zO
	95tz7r0EJhzCRUSySkdrVfJUMb6Oa+7y9fc/QpfTkj9PeKOhb8w4Gm6089DYfD+Ovpiex9CX
	3YU81H7HxkcLS3V8dPqemYMsf9zko96Wkzg6eteCo47pGoC+sy5zUNPMIg9NPFjhoqqir7no
	+J16HJWNWvko72k7F51t+gWgyU+7QORGqrcvhmqo+QynmofDKNPpDkDl237gUg77AJcqbc2h
	ptr7cepYYw2g/m7woo50HOXErT+QEq6k5Qpa60OrEtWKZFVShDhmX0JUgixUIvWXhqHXxD4q
	eRodIY6OjfPfnZy6OqfYJ0Oeql89ipMzjDjw9XCtWq+jfZRqRhchpjWKVE2oJoCRpzF6VVKA
	itZtl0okQbJV8GCKcnipmK8Zc8tc7FnAckEBYQQEAckQWFOQbATrCCFpATB36hLOJjMADv6+
	xGOTJwBOnZrhGoHbWkde5QhgC20Amk1W3FUQkrMATtjedsnipB+8fy3GxXiQ1Rgs6x7nuxiM
	VMDx4sk1IXdSBuvNecDFc8ktsOea2nUsIHfAuuZyDuvlDZ8OFmOu2I0MhwPV57ksswHaTjzi
	spLe0ND0FebyguQcAQ32EowdLRr+bA5gddzhuLWRz8YiOFZSyGd5A4BVf1n/bTYBOOu4j7PU
	TmgoMOAuIYz0hXUtgazZi3DycTGP1RfAokIhS78KTxpv4c/0Hfce8tiYgoO5y3x2VyUAXnTU
	AhPwrnhuhornZqj4360SYDVgE61h0pJoRqqR/nepieq0BrD21P1kFlA6MR3QCTgE6ASQwMQe
	groLn9NCgUKelU1r1QlafSrNdALZ6oJLMdHGRPXqX1HpEqQhYZKQ0KAQFBwWHCp+WXCzL4MW
	kklyHZ1C0xpa+6yPQ7iJcjm3qpz9pG19dtTVubpKVaDD7rcnR+lsSY/bdjYz68PYWFPG+Ld9
	2w+MeV4XpQ9dcGaXdTtPBd0YO/zm7ksXfT+ebLMcqow+s2Nl7+YPdpbInvzmCK7yev/qoRds
	15WGDnGh4GDURGNQ9Pkr8R3OOdW5kVGPPXcX4/T7gtI59t6kJZ4DzVfILSteyfma4drDvK69
	GYEjV4xZ2e9u5VVvLSseOvbYFLvw1gSfkOw2hG5WtBZdLvPPX350O36A+mkT4dlSr38pcvSN
	De/EW21h/Z6vtJ278VHPr5/scmTmXJ6h7PunW/c3e90uOfPjrFO062FV7ffliSLjg/fct5R7
	MttmptuYhkgxl1HKpX6YlpH/A1aJ5INzBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCIsWRmVeSWpSXmKPExsWy7bCSnG5b6vRUg/aHRhYP5m1js3i45Smr
	xcufV9kspn34yWwx41Qbq8W+ayfZLX79Xc9usejGNiaLHc/PsFtc3jWHzaL7+g42iwMfVjFa
	LD/+j8li66ffrBZv7/5nsVjYMZfFYtK1DWwWU18cZ7do+rOPxWLp1puMFu8aDzM6iHpcvuLt
	sWlVJ5vHzoeWHhMWHWD0aDm5n8Xj49NbLB4T99R5vN93lc2jb8sqRo/Pm+Q82g90MwVwR3HZ
	pKTmZJalFunbJXBlPPzbw17wkrPi9/lfzA2MrRxdjJwcEgImEk0LnjGC2EICuxklbu1jhIhL
	Sezef56ti5EDyBaWOHy4uIuRC6jkE6PEszMzmEDibAJaErePeYOUiwjsZ5Y43RYLYjMLZEh8
	+3iCCcQWFjCV2LCtiRGknEVAVeL8sXyQMK+AtcT6ndOZIDbJS/y538MMYnMK2EjcWrmCBeIa
	a4lVL26wQNQLSpyc+YQFYry8RPPW2cwTGAVmIUnNQpJawMi0ilEytaA4Nz032bDAMC+1XK84
	Mbe4NC9dLzk/dxMjOCK1NHYw3pv/T+8QIxMH4yFGCQ5mJRHe9esmpwrxpiRWVqUW5ccXleak
	Fh9ilOZgURLnNZwxO0VIID2xJDU7NbUgtQgmy8TBKdXAVNWqfWTy/Lvx0+uC+95Mr579K82k
	t/VuSLnclihRt0wG33j2997W7uZLgnyUX6z7U71qzoLW/N9LSxffFKw6vOHG6aV/TweUFRzd
	4ZY1192+gaXIjKXop5uBVlai4I+jpS4yh1w83c51q6t0XpafF1TluM5Jxql5/v5WjWbLXdoX
	U1fWtPOsm+za6hBXa/LcJuxIWMVF8SSXuI6c64sXtB55KWLzy9d/r5Krq+D6Fffjrxbsacje
	f0TAn5uZ4wxbi5IX74W7m1b0PN1722Hvl8wQNekVG6O9ol5ftGiN15vM/6uk5uX+l7dNvGfZ
	sW7p/hMbosSzxCvlRZws80WOP+p5h1vCX1/LusVi9kyJpTgj0VCLuag4EQCAS72BNwMAAA==
X-CMS-MailID: 20240105021223epcas1p156208a9a445b5e0b527a9eb2d2589ed3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240105021223epcas1p156208a9a445b5e0b527a9eb2d2589ed3
References: <20240105021041.20400-1-cw9316.lee@samsung.com>
	<CGME20240105021223epcas1p156208a9a445b5e0b527a9eb2d2589ed3@epcas1p1.samsung.com>

From: ChanWoo Lee <cw9316.lee@samsung.com>

The 'hwq' parameter is not used in this function.
So, remove unused parameters.

Signed-off-by: ChanWoo Lee <cw9316.lee@samsung.com>
---
 drivers/ufs/core/ufs-mcq.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index edc752e55878..8db81f1a12d5 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -258,9 +258,7 @@ EXPORT_SYMBOL_GPL(ufshcd_mcq_write_cqis);
  * Current MCQ specification doesn't provide a Task Tag or its equivalent in
  * the Completion Queue Entry. Find the Task Tag using an indirect method.
  */
-static int ufshcd_mcq_get_tag(struct ufs_hba *hba,
-				     struct ufs_hw_queue *hwq,
-				     struct cq_entry *cqe)
+static int ufshcd_mcq_get_tag(struct ufs_hba *hba, struct cq_entry *cqe)
 {
 	u64 addr;
 
@@ -278,7 +276,7 @@ static void ufshcd_mcq_process_cqe(struct ufs_hba *hba,
 				   struct ufs_hw_queue *hwq)
 {
 	struct cq_entry *cqe = ufshcd_mcq_cur_cqe(hwq);
-	int tag = ufshcd_mcq_get_tag(hba, hwq, cqe);
+	int tag = ufshcd_mcq_get_tag(hba, cqe);
 
 	if (cqe->command_desc_base_addr) {
 		ufshcd_compl_one_cqe(hba, tag, cqe);
-- 
2.29.0



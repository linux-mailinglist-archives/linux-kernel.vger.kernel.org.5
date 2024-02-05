Return-Path: <linux-kernel+bounces-52741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 499E2849C22
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFFD11F25145
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D49620DF7;
	Mon,  5 Feb 2024 13:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="ACfjbEEy"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A27B210ED;
	Mon,  5 Feb 2024 13:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707140712; cv=none; b=SI6pnE+QWon/LHcNC2+AtOyqrM+xQ5lMp9QA191VzBFB8Wl2w75kH9aQryrvWOOTZTKWCZBoeIpdU3vhtuieJYniNPw9ysoaDEr0Jdei5jj3SE7IYJyMTkwe6+y+GiND74G4f8m7y1prSatHSd/CNq+zHlqSZxvoLKjqfIcPU/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707140712; c=relaxed/simple;
	bh=/ESju6bUi7mTghBwFv4sbdzVwIricjfRyR1f3X0LBvY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D5mr6jhBFwN7dvHM4e8xAL6bEFc7k+i+K98hukugICNRvV0pn0n0Qq6He4tQjdY/gxJjQfiq+VPBk03fPmamPKRTJDoPxKqNm+EKSEXLRYOUN1X48GkLd5R4KSW1ijHURRFHXcAJkxog72XF/C0KwvEJItogWyiLpQP3RxArYCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=none smtp.helo=mx0b-0016f401.pphosted.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=ACfjbEEy; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mx0b-0016f401.pphosted.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4158JoT8012798;
	Mon, 5 Feb 2024 05:44:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=pfpt0220; bh=zh+AyINX
	Tu/Vu+J5ZWs/mnBjeWFhJ2utrKdUpD3dDh8=; b=ACfjbEEyj9EjPFU4o5FjCtL4
	wqOB+qXV+MIJ/bJ8tTrBrT9Io+8HXzG7FQEzExH3/rz3zbZiUn2hiZ3eWwWpibS5
	JXU7SWu2bhrf3hwLGPkX4dnWKlxyIulPJ5VuxrG0Cbzvc0keyd457e3Sv2qpIzj7
	PWZd7BR44qElCEbG6yxg0uOacfFCqLIcLuwolVtuWWc2jcOfvZlNENgvrb4N6m2S
	06yiFGzCtN0XwpHg+kcTAvu0WPCOCQ2EtPfGu852IWFHNi1zjofUXvdweuvtHgQb
	O1aVAiF8FzIckl65vvdT0/tfcQh3OrC0Kao4z1BGv95w9gxd1z3ks3l517qEFw==
Received: from dc5-exch02.marvell.com ([199.233.59.182])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3w1nvmvj4h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 05:44:42 -0800 (PST)
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 5 Feb
 2024 05:44:40 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Mon, 5 Feb 2024 05:44:40 -0800
Received: from dc3lp-swdev041.marvell.com (dc3lp-swdev041.marvell.com [10.6.60.191])
	by maili.marvell.com (Postfix) with ESMTP id AD5C05B6947;
	Mon,  5 Feb 2024 05:44:38 -0800 (PST)
From: Elad Nachman <enachman@marvell.com>
To: <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <vadym.kochan@plvision.eu>, <aviramd@marvell.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <enachman@marvell.com>, <stable@vger.kernel.org>
Subject: [PATCH v2] mtd: rawnand: marvell: fix layouts
Date: Mon, 5 Feb 2024 15:44:35 +0200
Message-ID: <20240205134435.2769452-1-enachman@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: yGqj9-Pj5kzB-tlPXe0788TlS_8th4XV
X-Proofpoint-ORIG-GUID: yGqj9-Pj5kzB-tlPXe0788TlS_8th4XV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_08,2024-01-31_01,2023-05-22_02

From: Elad Nachman <enachman@marvell.com>

The check in nand_base.c, nand_scan_tail() : has the following code:
(ecc->steps * ecc->size != mtd->writesize) which fails for some NAND chips.
Remove ECC entries in this driver which are not integral multiplications,
and adjust the number of chunks for entries which fails the above
calculation so it will calculate correctly (this was previously done
automatically before the check and was removed in a later commit).

Fixes: 68c18dae6888 ("mtd: rawnand: marvell: add missing layouts")
Cc: stable@vger.kernel.org
Signed-off-by: Elad Nachman <enachman@marvell.com>
---
 drivers/mtd/nand/raw/marvell_nand.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/nand/raw/marvell_nand.c b/drivers/mtd/nand/raw/marvell_nand.c
index a46698744850..5b0f5a9cef81 100644
--- a/drivers/mtd/nand/raw/marvell_nand.c
+++ b/drivers/mtd/nand/raw/marvell_nand.c
@@ -290,16 +290,13 @@ static const struct marvell_hw_ecc_layout marvell_nfc_layouts[] = {
 	MARVELL_LAYOUT( 2048,   512,  4,  1,  1, 2048, 32, 30,  0,  0,  0),
 	MARVELL_LAYOUT( 2048,   512,  8,  2,  1, 1024,  0, 30,1024,32, 30),
 	MARVELL_LAYOUT( 2048,   512,  8,  2,  1, 1024,  0, 30,1024,64, 30),
-	MARVELL_LAYOUT( 2048,   512,  12, 3,  2, 704,   0, 30,640,  0, 30),
-	MARVELL_LAYOUT( 2048,   512,  16, 5,  4, 512,   0, 30,  0, 32, 30),
+	MARVELL_LAYOUT( 2048,   512,  16, 4,  4, 512,   0, 30,  0, 32, 30),
 	MARVELL_LAYOUT( 4096,   512,  4,  2,  2, 2048, 32, 30,  0,  0,  0),
-	MARVELL_LAYOUT( 4096,   512,  8,  5,  4, 1024,  0, 30,  0, 64, 30),
-	MARVELL_LAYOUT( 4096,   512,  12, 6,  5, 704,   0, 30,576, 32, 30),
-	MARVELL_LAYOUT( 4096,   512,  16, 9,  8, 512,   0, 30,  0, 32, 30),
+	MARVELL_LAYOUT( 4096,   512,  8,  4,  4, 1024,  0, 30,  0, 64, 30),
+	MARVELL_LAYOUT( 4096,   512,  16, 8,  8, 512,   0, 30,  0, 32, 30),
 	MARVELL_LAYOUT( 8192,   512,  4,  4,  4, 2048,  0, 30,  0,  0,  0),
-	MARVELL_LAYOUT( 8192,   512,  8,  9,  8, 1024,  0, 30,  0, 160, 30),
-	MARVELL_LAYOUT( 8192,   512,  12, 12, 11, 704,  0, 30,448,  64, 30),
-	MARVELL_LAYOUT( 8192,   512,  16, 17, 16, 512,  0, 30,  0,  32, 30),
+	MARVELL_LAYOUT( 8192,   512,  8,  8,  8, 1024,  0, 30,  0, 160, 30),
+	MARVELL_LAYOUT( 8192,   512,  16, 16, 16, 512,  0, 30,  0,  32, 30),
 };
 
 /**
-- 
2.25.1



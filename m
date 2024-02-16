Return-Path: <linux-kernel+bounces-67953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8886857389
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 02:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED5091C231EA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 01:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF177101DA;
	Fri, 16 Feb 2024 01:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Ug6vs0DD"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4658101C4
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 01:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708047917; cv=none; b=VqABBd/+ur1kam3f7E81ziTzTwWjLrqddKqRimS5ILH/19hPinOGxIcaIPivy485BALavieEUT9KQLrGy0fezdD/GsncVkV6lGUnNCg0hCFJcHUIAUOO5Wjdyc1lgzEUhT5SVqKXNqYQoHrleBr3Hmc4xdKjnoYF8pEMnIM8+5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708047917; c=relaxed/simple;
	bh=MIiy51TTSIUBzvWxt0QQOKklVlPZdMcdU3zIr/oxeNg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=sNvdUnkH3GrFdB1oyF9aEUz/Xa5YcLtBP4j0C5q5uKk9mHKSAb05VWzUGPJ0hpko7FMDce4glIzlRFcXMuFXiQb8THMn5LcyRbtkQC6FpE8PMUD7IjK0KdbOmeJE0cbumJXpfkxTEG+u5c9WSiJih3w94jltAtLWYuzQT5UDhiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Ug6vs0DD; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240216014508epoutp03495d1849572bcd9bd7055d2b884192d7~0NIX61aOk1834018340epoutp03h
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 01:45:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240216014508epoutp03495d1849572bcd9bd7055d2b884192d7~0NIX61aOk1834018340epoutp03h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1708047908;
	bh=i/eLcapPImUQCaXtI1ampR61jKvG768azzE6vB6Rrcw=;
	h=From:To:Cc:Subject:Date:References:From;
	b=Ug6vs0DDxJSejvfOBDQaU1J2odjQT0dao+S2siuyFSboaHc2iWNID2TFm+Escp2Sk
	 L9xeYknC7nTK4/M0ws4vQt0Vqm46FQbuhvSpgBMws2iIL2u5bnPF6VHxNZncXLhs3A
	 /u/XcJyIuBdPe/FQy0+d1khMrnEZ9Og2caDbHQCY=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTP id
	20240216014508epcas2p2c44ef3ec3a95eda1616c5d7e2d5e2a2c~0NIXjPvil0502405024epcas2p2x;
	Fri, 16 Feb 2024 01:45:08 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.68]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4TbZW754hJz4x9Q8; Fri, 16 Feb
	2024 01:45:07 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
	epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	A9.64.18994.32EBEC56; Fri, 16 Feb 2024 10:45:07 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
	20240216014507epcas2p41686c0ccb1fa73715499e45bbbc7d7e9~0NIWmRfks0186401864epcas2p4p;
	Fri, 16 Feb 2024 01:45:07 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240216014507epsmtrp28ad494e93f9e855f90d19b1ed4aabc89~0NIWlcWTX2712327123epsmtrp2C;
	Fri, 16 Feb 2024 01:45:07 +0000 (GMT)
X-AuditID: b6c32a4d-743ff70000004a32-d7-65cebe2348e5
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	A8.A5.08817.32EBEC56; Fri, 16 Feb 2024 10:45:07 +0900 (KST)
Received: from calab-Precision-7920-Tower.dsn.sec.samsung.com (unknown
	[10.229.83.132]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240216014507epsmtip10a3e707447dbea74243dd2811e985a11~0NIWWcGkj1488314883epsmtip1P;
	Fri, 16 Feb 2024 01:45:07 +0000 (GMT)
From: hj96.nam@samsung.com
To: will@kernel.org
Cc: linux-cxl@vger.kernel.org, jonathan.cameron@huawei.com,
	wj28.lee@samsung.com, ks0204.kim@samsung.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	mark.rutland@arm.com, Hojin Nam <hj96.nam@samsung.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Subject: [PATCH v3] perf: CXL: fix CPMU filter value mask length
Date: Fri, 16 Feb 2024 10:45:22 +0900
Message-Id: <20240216014522.32321-1-hj96.nam@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplk+LIzCtJLcpLzFFi42LZdljTXFd537lUg5sNGhYf3vxjsVi18Bqb
	xdE9HBabHl9jtTg/6xSLxeVdc9gsll6/yGTRcsfUYuP9d2wOnB5r5q1h9Gg58pbVY9OqTjaP
	zUvqPfq2rGL0+LxJLoAtKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE3
	1VbJxSdA1y0zB+gkJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BeYFecWJucWle
	ul5eaomVoYGBkSlQYUJ2xrU559gK1gpUvN2Z28A4nbeLkZNDQsBEYvrUTSxdjFwcQgJ7GCXm
	tExignA+MUocnXocyvnGKDF122RGmJYDXb/YIBJ7GSVuNG+AcnqYJH49mwJWxSYgJTH5yyH2
	LkYODhEBYYmHL1NAapgF5jBJHNh3gg2kRljAQaLv2SZWEJtFQFVi4ZarYL28ApYS25eeYYbY
	Ji+x/+BZZoi4oMTJmU9YQGxmoHjz1tnMIEMlBB6xSyx8upUJosFF4ujMBjYIW1ji1fEt7BC2
	lMTnd3vZQA6SEMiX+LSTBSJcIDGrZy1Uq7HEu5vPWUFKmAU0Jdbv0oeoVpY4cgtqK59Ex+G/
	7BBhXomONiGIRiWJ/R2tUAdLSNw5cRkaVB4SsxrWgMWFBGIlfh+ewDiBUX4Wkl9mIfllFsLe
	BYzMqxilUguKc9NTk40KDHXzUsvh0Zqcn7uJEZwutXx3ML5e/1fvECMTB+MhRgkOZiUR3km9
	Z1KFeFMSK6tSi/Lji0pzUosPMZoCQ3gis5Rocj4wYeeVxBuaWBqYmJkZmhuZGpgrifPea52b
	IiSQnliSmp2aWpBaBNPHxMEp1cA0yafkWJX7FQe1w75PY69vb9nGHH581/K99yfPf3y0/MIL
	9indwss2uxeFff/7gbnKPzP7Zrets9SKzrNmU067ubwSWugs/l/Zx0jWxe3ATv00O+6uQ26+
	rIVq53c/36IiofLlT/4sV86nQrJVwse5ja/XMN7UPLpg65S9V0rTfrmue8Wlez1r4+XVMY9i
	LGKjpYUjyi5X8wfXNr697Cu17JvETobdB9915zTUmG5bocjIy3/477yX1i+adgZVON3fGi8Z
	3M21xnDOBoa4Fze+P3jbe2hZkZ9RlQDn1wWHdoo/PDzbouD0px+qFrxTPznVsfhMaP7fJ6JW
	1Cq8cMNbLZ3bifcT+krOZyW+ts1WYinOSDTUYi4qTgQAd6+7HCAEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFLMWRmVeSWpSXmKPExsWy7bCSnK7yvnOpBkf/c1h8ePOPxWLVwmts
	Fkf3cFhsenyN1eL8rFMsFpd3zWGzWHr9IpNFyx1Ti43337E5cHqsmbeG0aPlyFtWj02rOtk8
	Ni+p9+jbsorR4/MmuQC2KC6blNSczLLUIn27BK6Ma3POsRWsFah4uzO3gXE6bxcjJ4eEgInE
	ga5fbF2MXBxCArsZJeYv/MAEkZCQWPx4J5QtLHG/5QgrRFEXk0TT9NOMIAk2ASmJyV8OsXcx
	cnCIABU9fJkCUsMssIRJYtPfGewgNcICDhJ9zzaxgtgsAqoSC7dcBevlFbCU2L70DDPEAnmJ
	/QfPMkPEBSVOznzCAmIzA8Wbt85mnsDINwtJahaS1AJGplWMkqkFxbnpucWGBUZ5qeV6xYm5
	xaV56XrJ+bmbGMHBq6W1g3HPqg96hxiZOBgPMUpwMCuJ8E7qPZMqxJuSWFmVWpQfX1Sak1p8
	iFGag0VJnPfb694UIYH0xJLU7NTUgtQimCwTB6dUA5NO9i25vsB/B752bYmbVbVmx80Qrhjt
	HM+C/4a1MVP4/pR8ObrvYr9xX6LA4vsGFzYfCzt4+Fx54u8/+n92cwk+XtB629VANGL28lsK
	y6O2rapNFTWRkDuaP//fyc6gd0pPu1Zm+eaJ33uzX83LaP3a3m2PJpbManuiELrP4OJ+Hzbx
	076LHn3irz0/eVfbQi+/F1f1mN5vyZnz8BIDS9X+B/rNb1IiEhYs+Cs9f92ULN3st78d82vZ
	BZorXx4Imekn2/KMYcG21nePDu7vmfAzaGmiwuLGE8mHNl2NXHOUhf/8TN4Yqb8HRK7MNX7v
	kNLAZ6ikM+/Wyno2oyplwTXbZs9WmfJNYd67FZq3a0XNlViKMxINtZiLihMBj1hXnM0CAAA=
X-CMS-MailID: 20240216014507epcas2p41686c0ccb1fa73715499e45bbbc7d7e9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240216014507epcas2p41686c0ccb1fa73715499e45bbbc7d7e9
References: <CGME20240216014507epcas2p41686c0ccb1fa73715499e45bbbc7d7e9@epcas2p4.samsung.com>

From: Hojin Nam <hj96.nam@samsung.com>

CPMU filter value is described as 4B length in CXL r3.0 8.2.7.2.2.
However, it is used as 2B length in code and comments.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Hojin Nam <hj96.nam@samsung.com>
---

Hi Will,
Sorry, I think whitespace-damage occurred while sending the patch.
I returned space to tab in the code below line 642, thank you!

Changes since v2:
- Return damaged whitespace to tabs (Will)

Changes since v1:
- Remove Fixes tag (Jonathan)
- Repair broken sign off (Jonathan)

 drivers/perf/cxl_pmu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
index 365d964b0f6a..ca5e92f28b4a 100644
--- a/drivers/perf/cxl_pmu.c
+++ b/drivers/perf/cxl_pmu.c
@@ -59,7 +59,7 @@
 #define   CXL_PMU_COUNTER_CFG_EVENT_GRP_ID_IDX_MSK	GENMASK_ULL(63, 59)
 
 #define CXL_PMU_FILTER_CFG_REG(n, f)	(0x400 + 4 * ((f) + (n) * 8))
-#define   CXL_PMU_FILTER_CFG_VALUE_MSK			GENMASK(15, 0)
+#define   CXL_PMU_FILTER_CFG_VALUE_MSK			GENMASK(31, 0)
 
 #define CXL_PMU_COUNTER_REG(n)		(0xc00 + 8 * (n))
 
@@ -314,9 +314,9 @@ static bool cxl_pmu_config1_get_edge(struct perf_event *event)
 }
 
 /*
- * CPMU specification allows for 8 filters, each with a 16 bit value...
- * So we need to find 8x16bits to store it in.
- * As the value used for disable is 0xffff, a separate enable switch
+ * CPMU specification allows for 8 filters, each with a 32 bit value...
+ * So we need to find 8x32bits to store it in.
+ * As the value used for disable is 0xffff_ffff, a separate enable switch
  * is needed.
  */
 
@@ -642,7 +642,7 @@ static void cxl_pmu_event_start(struct perf_event *event, int flags)
 		if (cxl_pmu_config1_hdm_filter_en(event))
 			cfg = cxl_pmu_config2_get_hdm_decoder(event);
 		else
-			cfg = GENMASK(15, 0); /* No filtering if 0xFFFF_FFFF */
+			cfg = GENMASK(31, 0); /* No filtering if 0xFFFF_FFFF */
 		writeq(cfg, base + CXL_PMU_FILTER_CFG_REG(hwc->idx, 0));
 	}
 
-- 
2.34.1



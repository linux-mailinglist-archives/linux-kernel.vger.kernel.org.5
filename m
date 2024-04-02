Return-Path: <linux-kernel+bounces-127768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CDAA8950A6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7E80286372
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA955F466;
	Tue,  2 Apr 2024 10:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Ls3Y+rw8"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C014939852
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 10:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712054874; cv=none; b=np4iBrE7q7OOtMrxODUg8nYxV+ajpr6zxFGB7BLmM/Sa2ycy8LZlw/kRDXQEYAP2TFPPuGgPMUd1VX3I2ei7H1Sd//wZnjTQc6pDXTFhfq+umlHWYaR+oU3UjOc3KpNrqyttsdStdxSqzE/7P1oFGjEhpYUuoU4QPsngqex5pLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712054874; c=relaxed/simple;
	bh=ccdrkrf5k7Cp/aHNUer3qGL6Y7sadz5cOWrsywoXdo4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=Nsr4zIrrK34mUBiJb2kowea3tzPJMb4m3prIM5UNoZP0/FDF6SIPJJVXfLUSsjM1Rpm6z14rFVBXNdCfbFivxdzUjRi+MwCWir4c8G4wZD9lY39hAiV5nDX6UCvwCsNLnAV+TSP+ryVWz7O7uhd7NJvfXBJf6ZaeZGEfrRVps8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Ls3Y+rw8; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240402104743epoutp02021202971bf7cf651f7ce687e3df920f~CcNPun4fw2159521595epoutp02r
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 10:47:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240402104743epoutp02021202971bf7cf651f7ce687e3df920f~CcNPun4fw2159521595epoutp02r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1712054863;
	bh=ASstzGlnYxumvkV4PMhGYVoYgNKEFCHa9r2folxaO1A=;
	h=From:To:Cc:Subject:Date:References:From;
	b=Ls3Y+rw8IiQdE3NKRvR4AbBKseKX+Ub1k1yIGPvibS0DM1LrhRvOzDJn+oeSxSWTQ
	 GX0CBVTswTPxeSjz9SkzXL2XRTNR1cQbpvbZY7TUX/Au1YXYBAw0E2s3FABdFm0quZ
	 ZVEp91Os2CsrDMUyT1kSW7b9isJkglvV/lLw2HrI=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTP id
	20240402104742epcas1p4d0a83dde284adbe2ea0781c3316aeb65~CcNOkwBud2726527265epcas1p47;
	Tue,  2 Apr 2024 10:47:42 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.36.225]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4V84My3zg8z4x9Q8; Tue,  2 Apr
	2024 10:47:42 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
	epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	9A.BE.08627.E42EB066; Tue,  2 Apr 2024 19:47:42 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
	20240402104742epcas1p306e175348a3a7c1bdba9422ce22284f8~CcNOIrYr12886728867epcas1p3S;
	Tue,  2 Apr 2024 10:47:42 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240402104742epsmtrp1424e48b7a9ae2c14d44e502289c7545c~CcNOH_Hcd2639526395epsmtrp1b;
	Tue,  2 Apr 2024 10:47:42 +0000 (GMT)
X-AuditID: b6c32a33-d59fa700000021b3-18-660be24e7546
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	E7.A2.19234.D42EB066; Tue,  2 Apr 2024 19:47:42 +0900 (KST)
Received: from parkseongsu-desktop.. (unknown [10.252.69.73]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240402104741epsmtip10984bfa2b2dde39f29a6f7266913b5c8~CcNN4DNc01514115141epsmtip1M;
	Tue,  2 Apr 2024 10:47:41 +0000 (GMT)
From: Seongsu Park <sgsu.park@samsung.com>
To: catalin.marinas@arm.com, will@kernel.org, ardb@kernel.org,
	mark.rutland@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	sgsu.park@samsung.com, Leem ChaeHoon <infinite.run@gamil.com>, Gyeonggeon
	Choi <gychoi@student.42seoul.kr>, Soomin Cho <to.soomin@gmail.com>, DaeRo
	Lee <skseofh@gmail.com>, kmasta <kmasta.study@gmail.com>
Subject: [PATCH] arm64: Fix double TCR_T0SZ_OFFSET shift
Date: Tue,  2 Apr 2024 19:47:35 +0900
Message-Id: <20240402104735.170539-1-sgsu.park@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGJsWRmVeSWpSXmKPExsWy7bCmvq7fI+40g557chY/v7xntHi/rIfR
	YlPbfUaL7Q3lFl/+LmW22PT4GqvF5V1z2CyWXr/IZPG+oYvVYtKPLYwW7Z9fsFq03DF14PFY
	M28No8e85e3MHjtn3WX32LSqk81j85J6j74tqxg9Dp1dwOrxeZNcAEdUtk1GamJKapFCal5y
	fkpmXrqtkndwvHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0K1KCmWJOaVAoYDE4mIlfTub
	ovzSklSFjPziElul1IKUnAKzAr3ixNzi0rx0vbzUEitDAwMjU6DChOyM/skzWArecFZcPzWb
	vYHxKEcXIyeHhICJxNoFi1m6GLk4hAR2MEqs7DkJ5XxilPg/YTU7nPN80W7WLkYOsJbfu6sh
	4jsZJXpefmCGK1p09RoTyFw2AS2J1f962UFsEYFQidcz1rOB2MwCs5gk2lcogtjCAhYSi9Y9
	YwGxWQRUJd5c+c4IYvMKWEus37KZBeI+eYn9B88yQ8QFJU7OfMICMUdeonnrbLDFEgKtHBIv
	nn+GanCR2Hu/iR3CFpZ4dXwLlC0l8bK/Dcoultj3ZQ0zhF0j8WDeHijbXqLjWRsLyJfMApoS
	63fpQ+zik3j3tQfqeV6JjjYhCFNZ4txWRwhTUuLPAj2IGR4Sl49PAweCkECsRMffXuYJjHKz
	kNw/C8n9sxBWLWBkXsUollpQnJuemmxYYAiPxuT83E2M4ASqZbyD8fL8f3qHGJk4GA8xSnAw
	K4nw/vTmTBPiTUmsrEotyo8vKs1JLT7EaAoM0YnMUqLJ+cAUnlcSb2hiaWBiZmRiYWxpbKYk
	znvmSlmqkEB6YklqdmpqQWoRTB8TB6dUA1P5tcdRVtnZXBpvlGeVHozb5yfUFDNDbn3899Ky
	NS9rd/1y/CJwxvPrvBpDtRtB8RuVXybO4Dxz0kVH6z/7xgsRO26+6Kzrapav9FjiKv1qutfJ
	lwv2v1p79F7CPzMn9y1rP75Xf/yyyP/qsTr32j/xk0L8rRX4/dffKmabycJgOcshPvbM/N1f
	d/CK/D78cmLUI5ZnG1mS564/4r7fPbV9ukTN1J2HL86pCMqWnRKy78P7rsx7+UePnlTvFRCJ
	C6vrKJzVIrHPk2NL8OGt2vfuV+zN+jVj4rTCkNbuxhL3R6KR4plBG2+6JH90d7hxNmHmF/Gc
	YOfYxD+WUt/Wvzxt3/mkefvk7qPST/OeXdNTYinOSDTUYi4qTgQA+iURkykEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPLMWRmVeSWpSXmKPExsWy7bCSnK7fI+40g74JzBY/v7xntHi/rIfR
	YlPbfUaL7Q3lFl/+LmW22PT4GqvF5V1z2CyWXr/IZPG+oYvVYtKPLYwW7Z9fsFq03DF14PFY
	M28No8e85e3MHjtn3WX32LSqk81j85J6j74tqxg9Dp1dwOrxeZNcAEcUl01Kak5mWWqRvl0C
	V0b/5BksBW84K66fms3ewHiUo4uRg0NCwETi9+7qLkYuDiGB7YwSu7/uZOpi5ASKS0q0v7vM
	AlEjLHH4cDFEzQdGidmH3jCC1LAJaEms/tfLDmKLCERKnH12kQmkiFlgEZPEixvXWUASwgIW
	EovWPQOzWQRUJd5c+Q7WzCtgLbF+y2YWiGXyEvsPnmWGiAtKnJz5BCzODBRv3jqbeQIj3ywk
	qVlIUgsYmVYxiqYWFOem5yYXGOoVJ+YWl+al6yXn525iBIe5VtAOxmXr/+odYmTiYDzEKMHB
	rCTC+9ObM02INyWxsiq1KD++qDQntfgQozQHi5I4r3JOZ4qQQHpiSWp2ampBahFMlomDU6qB
	Kde4x3y/iCTbS8X10QuPrSr+4Lbp4omjQVeVNrz2//Wk/IDZm283t0t9W2bzRujrC8vXMyeI
	pF9VnbN44eNVmj4tHfMiVp95ciDqSOlhfmc+vnsb+9d191+yitJ/f93A+uYf/ldc0jpLWS86
	JbGvOSPbbRP286jfDFd+szkpzzwWHnFZJpK6ZsohCa5eo4Wattn/F87Uq/sj2SRxVNUqpE85
	wGC6WmvO77biigXsBcs/WWetZs1sq/h1af/VeJUmnUvKi61zj31a9Fzl443yNUJT5JgW2qzg
	epfKrnckm+/fyTdHrvK4bstoPpLhEWwk+aqp8/jEMy7n6rmPVf99eaAgKiNypbmMzes1FpPD
	NymxFGckGmoxFxUnAgAtgi6u4gIAAA==
X-CMS-MailID: 20240402104742epcas1p306e175348a3a7c1bdba9422ce22284f8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240402104742epcas1p306e175348a3a7c1bdba9422ce22284f8
References: <CGME20240402104742epcas1p306e175348a3a7c1bdba9422ce22284f8@epcas1p3.samsung.com>

We have already shifted the value of t0sz in TCR_T0SZ by TCR_T0SZ_OFFSET.
So, the TCR_T0SZ_OFFSET shift here should be removed.

Co-developed-by: Leem ChaeHoon <infinite.run@gamil.com>
Signed-off-by: Leem ChaeHoon <infinite.run@gamil.com>
Co-developed-by: Gyeonggeon Choi <gychoi@student.42seoul.kr>
Signed-off-by: Gyeonggeon Choi <gychoi@student.42seoul.kr>
Co-developed-by: Soomin Cho <to.soomin@gmail.com>
Signed-off-by: Soomin Cho <to.soomin@gmail.com>
Co-developed-by: DaeRo Lee <skseofh@gmail.com>
Signed-off-by: DaeRo Lee <skseofh@gmail.com>
Co-developed-by: kmasta <kmasta.study@gmail.com>
Signed-off-by: kmasta <kmasta.study@gmail.com>
Signed-off-by: Seongsu Park <sgsu.park@samsung.com>
---
 arch/arm64/include/asm/mmu_context.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index c768d16b81a4..58de99836d2e 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -76,7 +76,7 @@ static inline void __cpu_set_tcr_t0sz(unsigned long t0sz)
 		return;
 
 	tcr &= ~TCR_T0SZ_MASK;
-	tcr |= t0sz << TCR_T0SZ_OFFSET;
+	tcr |= t0sz;
 	write_sysreg(tcr, tcr_el1);
 	isb();
 }
-- 
2.34.1



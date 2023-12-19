Return-Path: <linux-kernel+bounces-5139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4EE8186F5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 264EB1F24939
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259C2168C9;
	Tue, 19 Dec 2023 12:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MsSIktPl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E3D168C7
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 12:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20231219120436epoutp04ab432277c9b039036376c7426ef803d2~iOhZaUdsZ0704507045epoutp044
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 12:04:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20231219120436epoutp04ab432277c9b039036376c7426ef803d2~iOhZaUdsZ0704507045epoutp044
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1702987476;
	bh=kbtLfXsExq1k5rYtU73cq9h6/Dgp8Np56tw3hmb9V6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MsSIktPlipgcjebd1qxX+mRUFLzE3u9Oz6JofRTmAhocbFrAsITKwJ8EdajPbHqPT
	 dJWXYHwNBvXXIxr9hdSPsl76EQkwNO83w0R0YEr146QcY5OpB0fpNLyw1RjOIhlJAu
	 gAHjiLrkFiUUyo2tET+G7s1vIsNZ8I6ZDrnyLNo4=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20231219120436epcas5p47c35bce9213ac74893681d2fd5206aed~iOhY40kEd2781027810epcas5p4-;
	Tue, 19 Dec 2023 12:04:36 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4Svb3708Vtz4x9Pq; Tue, 19 Dec
	2023 12:04:35 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	35.C9.09672.2D681856; Tue, 19 Dec 2023 21:04:34 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20231219115858epcas5p469e925738bcb93ee88842fdea0f9d3f0~iOceah7X21311313113epcas5p4X;
	Tue, 19 Dec 2023 11:58:58 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20231219115858epsmtrp1fca3f53f13e8cc5e38f75c4d3e574a98~iOceY-HLe0150201502epsmtrp1h;
	Tue, 19 Dec 2023 11:58:58 +0000 (GMT)
X-AuditID: b6c32a4b-60bfd700000025c8-e2-658186d24c6e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	2A.AB.07368.28581856; Tue, 19 Dec 2023 20:58:58 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
	[107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20231219115856epsmtip1e2f14bde4a42468b3556abec4bcc0547~iOccdsqC20479904799epsmtip1n;
	Tue, 19 Dec 2023 11:58:56 +0000 (GMT)
From: Varada Pavani <v.pavani@samsung.com>
To: mturquette@baylibre.com, sboyd@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, s.nawrocki@samsung.com, tomasz.figa@gmail.com
Cc: linux-samsung-soc@vger.kernel.org, alim.akhtar@samsung.com,
	aswani.reddy@samsung.com, pankaj.dubey@samsung.com, Varada Pavani
	<v.pavani@samsung.com>
Subject: [PATCH 2/2] clk: samsung: Fix typo error and extra space
Date: Tue, 19 Dec 2023 17:28:34 +0530
Message-Id: <20231219115834.65720-2-v.pavani@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231219115834.65720-1-v.pavani@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjk+LIzCtJLcpLzFFi42LZdlhTU/dSW2OqwfebFhYP5m1jszi0eSu7
	xZq955gs5h85x2rR9+Ihs8XHnnusFpd3zWGzmHF+H5PFxVOuFou2fmG3OPymndXi37WNLBar
	dv1htNjQ+4rdgc/j/Y1Wdo+ds+6ye2xa1cnmcefaHjaPvi2rGD0+b5ILYIvKtslITUxJLVJI
	zUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wBulZJoSwxpxQoFJBYXKyk
	b2dTlF9akqqQkV9cYquUWpCSU2BSoFecmFtcmpeul5daYmVoYGBkClSYkJ3x8vg5xoIzYhXP
	1txmaWBcINTFyMkhIWAi0fFxLWMXIxeHkMBuRonPDetZIZxPjBL333+DynxjlNjRuI8doeU5
	E4gtJLCXUWLp4kqIolYmiV03doIVsQloSayeuhxslIjAe0aJaZOXgDnMAnMYJW4dvcnSxcjB
	ISzgKNHQD3YIi4CqxIsjJ1hAbF4BS4mDp49BbZOXWL3hADOIzSlgJXF24Q92kDkSAq0cEosu
	7GaDKHKRWLz8AiuELSzx6vgWqGYpiZf9bewguyQEkiXaP3FDhHMkLu1exQRh20scuDIH7Bxm
	AU2J9bv0IcKyElNPrQMrYRbgk+j9/QSqnFdixzwYW0li544JULaExNPVa9ggNnlIzDqmBQmT
	XkaJ6VsnM05glJuFsGEBI+MqRsnUguLc9NRi0wLjvNRyeKQl5+duYgQnSC3vHYyPHnzQO8TI
	xMF4iFGCg1lJhNdlUX2qEG9KYmVValF+fFFpTmrxIUZTYPBNZJYSTc4Hpui8knhDE0sDEzMz
	MxNLYzNDJXHe161zU4QE0hNLUrNTUwtSi2D6mDg4pRqYuiq65qT9YDCRflt69Hnvlg2ZMdO4
	pC++srZde0NIbJWQ4Zu3iRF93PtaXr5+JROdm1gas1nJXXzt+ZcWS3O+75p+PTzz1C+W60/m
	qp3lippXeXeq5Bur6S6MsX2xJ+38Pkd0Hl7ZOf+NwpvTcXE99lNsNT9Fq3JufCW0+/7UHLH9
	b7d/ZZYKOjr59fS4BRahDmtKXmStK2Dg1JpeOefT5MW/XeMOnEk6aXCVOUPqxaWSskuHS1hl
	C9dNfFa0+mRN3qLGHRqK96xTfJ7LpLxcpyVwT2Tnvsrpm7jnm+bu+Pn7V/IehvOSH80PvOQW
	CDh93nKp/5knM/VtPmxazWCzeXPzmYLzC16XaGavXGhhW6rEUpyRaKjFXFScCABqr3xuGQQA
	AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHLMWRmVeSWpSXmKPExsWy7bCSnG5Ta2OqQVu3lMWDedvYLA5t3spu
	sWbvOSaL+UfOsVr0vXjIbPGx5x6rxeVdc9gsZpzfx2Rx8ZSrxaKtX9gtDr9pZ7X4d20ji8Wq
	XX8YLTb0vmJ34PN4f6OV3WPnrLvsHptWdbJ53Lm2h82jb8sqRo/Pm+QC2KK4bFJSczLLUov0
	7RK4Ml4eP8dYcEas4tma2ywNjAuEuhg5OSQETCQ6Pj5nArGFBHYzSvR8r4SIS0js/NbKDGEL
	S6z895y9i5ELqKaZSWLyrRuMIAk2AS2J1VOXs4IkRAR+Mkr0ffvIAuIwCyxglFjV2gDkcHAI
	CzhKNPSDbWMRUJV4ceQEC4jNK2ApcfD0MXaIDfISqzccANvGKWAlcXbhD3aIiywlZk2axjiB
	kW8BI8MqRsnUguLc9NxkwwLDvNRyveLE3OLSvHS95PzcTYzgINbS2MF4b/4/vUOMTByMhxgl
	OJiVRHhdFtWnCvGmJFZWpRblxxeV5qQWH2KU5mBREuc1nDE7RUggPbEkNTs1tSC1CCbLxMEp
	1cD0zPFy2+NSpYue8tPr2brLrrNtW54qrJ46Y5v1HDm+OC/n/yEnZqS4fFw1rXCxjNvhQ333
	7+atr5srL71m8/7MpwIP77iKffbcqJRw8634hu9Wiqyi+2KE2MVVl2rNtw+3+awrecdv0/Wk
	pbwlvLmBM/PKD/yYJpx3+fRP4877SzYHNsUulpVpWv2h00iz+so8/1072VbU8urNZbx63qnh
	esECbVknq7+P8x5KvTDi5t7DdIZnf5eiz/3prbmvthmK3LSL5HxpJvs+VuKk3SH7LTbTm6aI
	ymjJLot6zcFTl2EnOXX3v5cbpvrZXm/xsuC+a7fZ4HC6VL7D20cdCmd68yTv2TlKvcxMl/x1
	uEyJpTgj0VCLuag4EQAwy+7B0QIAAA==
X-CMS-MailID: 20231219115858epcas5p469e925738bcb93ee88842fdea0f9d3f0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231219115858epcas5p469e925738bcb93ee88842fdea0f9d3f0
References: <20231219115834.65720-1-v.pavani@samsung.com>
	<CGME20231219115858epcas5p469e925738bcb93ee88842fdea0f9d3f0@epcas5p4.samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Remove extra spaces and fix spelling mistakes in 'drivers/
clk/samsung/clk-cpu.c' and 'drivers/clk/samsung/clk-cpu.h'

Signed-off-by: Varada Pavani <v.pavani@samsung.com>
---
 drivers/clk/samsung/clk-cpu.c | 6 +++---
 drivers/clk/samsung/clk-cpu.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/samsung/clk-cpu.c b/drivers/clk/samsung/clk-cpu.c
index 3e62ade120c5..18568b8b1b9b 100644
--- a/drivers/clk/samsung/clk-cpu.c
+++ b/drivers/clk/samsung/clk-cpu.c
@@ -19,7 +19,7 @@
  * clock and the corresponding rate changes of the auxillary clocks of the CPU
  * domain. The platform clock driver provides a clock register configuration
  * for each configurable rate which is then used to program the clock hardware
- * registers to acheive a fast co-oridinated rate change for all the CPU domain
+ * registers to achieve a fast co-oridinated rate change for all the CPU domain
  * clocks.
  *
  * On a rate change request for the CPU clock, the rate change is propagated
@@ -181,7 +181,7 @@ static int exynos_cpuclk_pre_rate_change(struct clk_notifier_data *ndata,
 	 * If the old parent clock speed is less than the clock speed of
 	 * the alternate parent, then it should be ensured that at no point
 	 * the armclk speed is more than the old_prate until the dividers are
-	 * set.  Also workaround the issue of the dividers being set to lower
+	 * set. Also workaround the issue of the dividers being set to lower
 	 * values before the parent clock speed is set to new lower speed
 	 * (this can result in too high speed of armclk output clocks).
 	 */
@@ -303,7 +303,7 @@ static int exynos5433_cpuclk_pre_rate_change(struct clk_notifier_data *ndata,
 	 * If the old parent clock speed is less than the clock speed of
 	 * the alternate parent, then it should be ensured that at no point
 	 * the armclk speed is more than the old_prate until the dividers are
-	 * set.  Also workaround the issue of the dividers being set to lower
+	 * set. Also workaround the issue of the dividers being set to lower
 	 * values before the parent clock speed is set to new lower speed
 	 * (this can result in too high speed of armclk output clocks).
 	 */
diff --git a/drivers/clk/samsung/clk-cpu.h b/drivers/clk/samsung/clk-cpu.h
index fc9f67a3b22e..e0a1651174e6 100644
--- a/drivers/clk/samsung/clk-cpu.h
+++ b/drivers/clk/samsung/clk-cpu.h
@@ -33,7 +33,7 @@ struct exynos_cpuclk_cfg_data {
  * @hw:	handle between CCF and CPU clock.
  * @alt_parent: alternate parent clock to use when switching the speed
  *	of the primary parent clock.
- * @ctrl_base:	base address of the clock controller.
+ * @ctrl_base: base address of the clock controller.
  * @lock: cpu clock domain register access lock.
  * @cfg: cpu clock rate configuration data.
  * @num_cfgs: number of array elements in @cfg array.
-- 
2.17.1



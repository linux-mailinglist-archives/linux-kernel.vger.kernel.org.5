Return-Path: <linux-kernel+bounces-142421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6468A2B57
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C88412828E7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2662251C28;
	Fri, 12 Apr 2024 09:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="nwVeG1Lb"
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB0C5102B
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 09:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712914587; cv=none; b=QYxQyPgsUrjUxDMEh5vVQbLFy0PDXwkrTBRaYtBY4kb2bWqp7z0DEuKjWp6mRTmorXf3iVaHbm54njhgxA/VOiIVEA4By5fzSCTyrjn1Ns1LNUSEUSSB9rhvG2gNAVdFbphS2IcdZuA+TMP3j79if6vKHQA5AchcGtgqbTIbm9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712914587; c=relaxed/simple;
	bh=ECG66815UF5U5UZ532M011H3Hgu9sb1nS+RlWPOzlVI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=ASD3f9BdGtvlrM8UQRYvG/9VHaSOR8ENnz7RVuYkwwjS1TxJFazXz7zem52vHMtxLA/Y58PBz/XdlKvq003mWlNbYRnTvum5vEagMZUDQrSZFBL5YVIDz2teC8tQWwlT3wC8/wC2L8j8Vr9m+oVtaVmelvDibxCHKpsucRDvLhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=nwVeG1Lb; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240412093622epoutp045a1fadc1ac7bdb22c78fab2ebc2c731e~FfrzQUwQM2155621556epoutp04X
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 09:36:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240412093622epoutp045a1fadc1ac7bdb22c78fab2ebc2c731e~FfrzQUwQM2155621556epoutp04X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1712914582;
	bh=18OZ4wgAdnYQqHPQ+QR1sMRA2rNC7ROaX7uQYViKJU4=;
	h=From:To:Cc:Subject:Date:References:From;
	b=nwVeG1Lbkm8L09VoWgzd/8konc0f8a/Z7G7DuXLrz35HRtr3SSMZ/ytNm+WKxIe4a
	 J82srKZMG8QJN+KPuDWAh56/Q4145Ce5+MnPIuuxWtLnTwYkz9IJrGCjGMuVqEoNfq
	 TjqdWY4mClLi3jeBRsbPGDG93rLiIoYCwzKiPF4Q=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240412093622epcas5p385256fbd7d1a71ac8596442246fd206d~Ffry0_EfB1567515675epcas5p38;
	Fri, 12 Apr 2024 09:36:22 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	C1.9B.09665.69009166; Fri, 12 Apr 2024 18:36:22 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240412090801epcas5p1beb5c87f7582cf4f53c245a642468763~FfTCzoULs2335923359epcas5p1O;
	Fri, 12 Apr 2024 09:08:01 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240412090801epsmtrp1648b0aa57349dc8c8ecdfcd74ae84238~FfTCyqBJq0149901499epsmtrp1B;
	Fri, 12 Apr 2024 09:08:01 +0000 (GMT)
X-AuditID: b6c32a4b-829fa700000025c1-6a-661900963857
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	3B.70.08390.1F9F8166; Fri, 12 Apr 2024 18:08:01 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.44]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240412090759epsmtip230e5033ab5bdd5f1ba3ac3202ccf54c7~FfTBKbzXQ1740317403epsmtip2g;
	Fri, 12 Apr 2024 09:07:59 +0000 (GMT)
From: Onkarnarth <onkarnath.1@samsung.com>
To: paulburton@kernel.org, mturquette@baylibre.com, sboyd@kernel.org
Cc: linux-mips@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, r.thapliyal@samsung.com,
	maninder1.s@samsung.com, Onkarnath <onkarnath.1@samsung.com>
Subject: [PATCH v2 1/1] clk: imgtec: use %pe for better readability of
 errors while printing
Date: Fri, 12 Apr 2024 14:37:49 +0530
Message-Id: <20240412090749.15392-1-onkarnath.1@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkleLIzCtJLcpLzFFi42LZdlhTXXcag2SawYF5XBYfe+6xWlzeNYfN
	onPTVkaLw/PbWCwunnK1WNHzgdWi49tcFouN97It/l3byOLA6fH+Riu7x6ZVnWwefVtWMXp8
	3iQXwBLFZZOSmpNZllqkb5fAlXFgwjKWgkvcFR9PNrI3MJ7l7GLk4JAQMJE4Pzuki5GLQ0hg
	N6PEsY8djBDOJ0aJGzP6mCGcb4wSp/fvYoTpWL23touREyi+l1HiUGshRM0XRok5D88ygyTY
	BLQkZtw5wARiiwi4SPSu2wU2lVlgE6PE0pk/wIqEBeIkVj+dzghiswioSnSs2MUGYvMK2Eic
	O34arEZCQF5i5qXv7BBxQYmTM5+wgNjMQPHmrbPBrpMQuMYucebpFyaIBheJx3+vQdnCEq+O
	b2GHsKUkXva3Qdn5Ei2zZzFDfFMjcfWpKkTYXuLJxYWsIGFmAU2J9bv0IcKyElNPrWOCWMsn
	0fv7CdR0Xokd82BsVYlfU6ayQNjSEvd/z2WDsD0k3q2+zQgJrFiJl5fXs01glJ+F5JtZSL6Z
	hbB5ASPzKkbJ1ILi3PTUYtMC47zUcr3ixNzi0rx0veT83E2M4NSi5b2D8dGDD3qHGJk4GA8x
	SnAwK4nwSmuJpgnxpiRWVqUW5ccXleakFh9ilOZgURLnfd06N0VIID2xJDU7NbUgtQgmy8TB
	KdXAdO7LXmYRXp/Tionitoem/jvZ89780b62g1w++ypVVn2Wrbly/YzGzSc/vfZ8syz7+qW+
	cds2/zfi7e5i9/VqjbbbXUj+8/K3/PqY2KNzX8ufW/frY8Lts5xSWc/VJJofhHqJ+X96a1Bu
	tN9GLbbvZbQsb3pLAevCy2k3dz+4Zzs5kDfk7xuLwwej9jbXO78rezWP+fTV1Jj4oCT/5fcC
	/wQ13Djuf8dK2O7siUth0yVYm76qW8XqzF2ntX7Bks7Yx9w7/br+CD8KZl290f9CfZqYzo69
	kVrFr3T0PUMEjXcuvyUpdar/y+1e7f0N18r1fjrtniix+8qP95O1Ps++eZb7/XvWaedOFE4/
	dYAvJVSJpTgj0VCLuag4EQA6AiKTnAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrELMWRmVeSWpSXmKPExsWy7bCSvO7HnxJpBt+PCVl87LnHanF51xw2
	i85NWxktDs9vY7G4eMrVYkXPB1aLjm9zWSw23su2+HdtI4sDp8f7G63sHptWdbJ59G1Zxejx
	eZNcAEsUl01Kak5mWWqRvl0CV8aBCctYCi5xV3w82cjewHiWs4uRg0NCwERi9d7aLkYuDiGB
	3YwSa6/tZ+li5ASKS0t8ujyHHcIWllj57zk7RNEnRomGzauZQBJsAloSM+4cALNFBDwkdh15
	wwxSxCywg1HicvMVsG5hgRiJmTMvghWxCKhKdKzYxQZi8wrYSJw7fpoZYoO8xMxL39kh4oIS
	J2c+AbuCGSjevHU28wRGvllIUrOQpBYwMq1ilEwtKM5Nzy02LDDKSy3XK07MLS7NS9dLzs/d
	xAgOVi2tHYx7Vn3QO8TIxMF4iFGCg1lJhFdaSzRNiDclsbIqtSg/vqg0J7X4EKM0B4uSOO+3
	170pQgLpiSWp2ampBalFMFkmDk6pBqboZ1teqics3SR4+FpRwiEnE1mfz7putksP/unYaHzP
	s9x3Ss3z+Zm8a1bczStde7stcolUwrpipqXXWDf3/jhn2BbYlrJqc+p2Of6QNKvdzyrU7+7J
	WLcsfVGaa9JTjmPW3d3cPCsUX+S0TmUomnq7o3xmWeWNzu293YI6tyy+2n+LYpQ0i41+nCbD
	urH6XW34meM2X/+KBs/Q3/RDhmfhB/OM9J2+fifV5/X+zchoSuau55g+hz17kukexdvL9Fr4
	DJbdMnna8KTCy+OmZUGfybu7B6Z0fD1hlypqd3bPwf7EHxLzLCPslKQubv95oVlw5tbOQxd/
	1PvMTxeJWbjB87Ct5xHF+X7LOnZc2a/EUpyRaKjFXFScCAC1KF73xQIAAA==
X-CMS-MailID: 20240412090801epcas5p1beb5c87f7582cf4f53c245a642468763
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20240412090801epcas5p1beb5c87f7582cf4f53c245a642468763
References: <CGME20240412090801epcas5p1beb5c87f7582cf4f53c245a642468763@epcas5p1.samsung.com>

From: Onkarnath <onkarnath.1@samsung.com>

instead of printing errros as a number(%ld), it's better to print in string
format for better readability of logs.

Signed-off-by: Onkarnath <onkarnath.1@samsung.com>
---
v1 -> v2 : Removed unnecessary SOB tag.

 drivers/clk/imgtec/clk-boston.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/imgtec/clk-boston.c b/drivers/clk/imgtec/clk-boston.c
index b00cbd045af5..db96f8bea630 100644
--- a/drivers/clk/imgtec/clk-boston.c
+++ b/drivers/clk/imgtec/clk-boston.c
@@ -67,21 +67,21 @@ static void __init clk_boston_setup(struct device_node *np)
 
 	hw = clk_hw_register_fixed_rate(NULL, "input", NULL, 0, in_freq);
 	if (IS_ERR(hw)) {
-		pr_err("failed to register input clock: %ld\n", PTR_ERR(hw));
+		pr_err("failed to register input clock: %pe\n", hw);
 		goto fail_input;
 	}
 	onecell->hws[BOSTON_CLK_INPUT] = hw;
 
 	hw = clk_hw_register_fixed_rate(NULL, "sys", "input", 0, sys_freq);
 	if (IS_ERR(hw)) {
-		pr_err("failed to register sys clock: %ld\n", PTR_ERR(hw));
+		pr_err("failed to register sys clock: %pe\n", hw);
 		goto fail_sys;
 	}
 	onecell->hws[BOSTON_CLK_SYS] = hw;
 
 	hw = clk_hw_register_fixed_rate(NULL, "cpu", "input", 0, cpu_freq);
 	if (IS_ERR(hw)) {
-		pr_err("failed to register cpu clock: %ld\n", PTR_ERR(hw));
+		pr_err("failed to register cpu clock: %pe\n", hw);
 		goto fail_cpu;
 	}
 	onecell->hws[BOSTON_CLK_CPU] = hw;
-- 
2.25.1



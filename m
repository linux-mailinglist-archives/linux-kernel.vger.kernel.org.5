Return-Path: <linux-kernel+bounces-103258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E613987BD15
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 135B41C21DD2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 12:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BFEA5A10A;
	Thu, 14 Mar 2024 12:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="R/p4zuCW"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DFB58AD2
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 12:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710420994; cv=none; b=JP8yjYfPW5E1Qgx7GLyOATU1MpW3K3falEnEBdFQx77JQ/QxzNOT91ppWJRodeeVnjAlaIWNsMNkv5+YI6wKJj/N3Dj9ded1hAzwuEZIX2AMZFlgdovJlcAF9ItqDoGqU9OCsoKqe3pdH0zZ8IBKjVCnEwVUVI5nK/0h88rWVbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710420994; c=relaxed/simple;
	bh=9Y/+hw0hgw9ADsFQLz0LPL3cLz0NNDauGYrral+Dtro=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=KoSlA4P2oSRECxYhrpePKQcAbGoccPjyuqsIt9JAfi88HFSbSIURu24Md97bPO/F8alzVxLHI/GflDqHrRWLhgh3hDccZDLzm1BLIH9JuO1CisGy3KC71WAtJyXb0HoCwWAjyCBnCd+XmIukGVJY9OAWcDkIl1VmjNQrqDrPnoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=R/p4zuCW; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240314125629euoutp010b19f517c9a9da2e6da08bcb3dc864f5~8otPQ2Yrm1041910419euoutp01a
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 12:56:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240314125629euoutp010b19f517c9a9da2e6da08bcb3dc864f5~8otPQ2Yrm1041910419euoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1710420989;
	bh=AtiIPD1nd1BTHIsx1dMEytn/tsBihsCy+dwOY7jQpBY=;
	h=From:To:Cc:Subject:Date:References:From;
	b=R/p4zuCWtTO6I2S2SBVnoJM4D/03rroyRNjc6VN1uUfQYoV9rcRtFkqbqNIVLKN2E
	 yST+G/UfoOeOU8ynRiUXYXFs4KrDKfJUi1GBYlX3rrYQr7n/hhpXrgCaKU79D6rnQf
	 s2iu5gvtOGEOh+p/VydajeBDAGzE7WKyeSuAobgI=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240314125628eucas1p2e3ad48e936d6c53ce89ca5f2e02d474c~8otOyC5e32014220142eucas1p2m;
	Thu, 14 Mar 2024 12:56:28 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 46.99.09814.CF3F2F56; Thu, 14
	Mar 2024 12:56:28 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240314125628eucas1p161af377a50fd957f445397bc1404978b~8otOP51sB1264712647eucas1p1m;
	Thu, 14 Mar 2024 12:56:28 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240314125628eusmtrp157bb9d209f9df74e3c1ff96e3a790aaf~8otOPJAlG1799517995eusmtrp1O;
	Thu, 14 Mar 2024 12:56:28 +0000 (GMT)
X-AuditID: cbfec7f4-727ff70000002656-24-65f2f3fc65a2
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id D2.FA.09146.BF3F2F56; Thu, 14
	Mar 2024 12:56:27 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240314125627eusmtip12f547f04dc25f77ebf9f2ed838088094~8otNdUPBP2067620676eusmtip1f;
	Thu, 14 Mar 2024 12:56:27 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Stephan Gerhold
	<stephan@gerhold.net>, Catalin Marinas <catalin.marinas@arm.com>, Russell
	King <linux@armlinux.org.uk>, Christoph Lameter <cl@gentwo.org>, Mark
	Rutland <mark.rutland@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Will
	Deacon <will@kernel.org>, stable@vger.kernel.org
Subject: [PATCH] cpufreq: dt: always allocate zeroed cpumask
Date: Thu, 14 Mar 2024 13:54:57 +0100
Message-Id: <20240314125457.186678-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNKsWRmVeSWpSXmKPExsWy7djP87p/Pn9KNdj8Sc7i/bIeRovlc+Yy
	WWx6fI3V4vKuOWwW99b8Z7X43HuE0eLQ1L2MFmuP3GW3WHr9IpPF3C9TmS0WbHzEaHFjronF
	8lM7WCw2fvWwaLlj6sDvsWbeGkaPy9cuMnvsP1zk0bbA3mPTqk42j02fJrF73Lm2h81j85J6
	j74tqxg9Pm+SC+CK4rJJSc3JLEst0rdL4MpYvGk3S0ETV8W/43/YGhj3cHQxcnJICJhIdF34
	wNzFyMUhJLCCUeL37TOsEM4XRolL0zawQDifGSUubz7PBNNyctMJqMRyRolVU18ywbV8uNHD
	BlLFJmAo0fW2C8wWESiT6P17CKyIWWAZs8Sse0+BNnJwCAvYSKztCQOpYRFQlZi95iNYPa+A
	nUTzhVWMENvkJfYfPMsMEReUODnzCQuIzQwUb946mxmi5geHxMvFQSAjJQRcJL68YYEIC0u8
	Or6FHcKWkTg9uQfsaAmBdkaJBb/vM0E4ExglGp7fglpmLXHn3C82kEHMApoS63fpQ4QdJf7e
	f8ACMZ9P4sZbQYgT+CQmbZvODBHmlehoE4KoVpOYdXwd3NqDFy5BlXhIHL8kDhIWEoiVODPr
	MMsERoVZSP6aheSvWQgnLGBkXsUonlpanJueWmyUl1quV5yYW1yal66XnJ+7iRGY3k7/O/5l
	B+PyVx/1DjEycTAeYpTgYFYS4a1T/JgqxJuSWFmVWpQfX1Sak1p8iFGag0VJnFc1RT5VSCA9
	sSQ1OzW1ILUIJsvEwSnVwJTyUnetpBmbEKeOSbXi4jvWt6z+8ymf0Kl3q/uSOFX88rlIbxWO
	u/mW01/LcpdLGpx5a8FU2X3ErGijUPefloaSba8/HG+afv5bmcvPP0+YTr1KzfXMienaVV3h
	sEB2oVxEvsq9q8r509nMorJzV+hKFJ6R+Xt0t04J7x63R4u2qoeun7t6Bm+qcsxB2R/ZX2+q
	3Fmml9l825V1zq8pK3O+lpteKtqaoSwk/onxn3XnrtnsTnnXnz9YbvnC+oWWylP+C9v552ub
	fo8p7TBTW2o2N4FlGcPcO435H1QXaK7r6Np+5NDxymh1n/SmiWHm/O/uFP5pS/O2OfHgydZP
	QRpdM9W101fOmNgWWHtaWomlOCPRUIu5qDgRABqRgGreAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEIsWRmVeSWpSXmKPExsVy+t/xu7q/P39KNbj9ydLi/bIeRovlc+Yy
	WWx6fI3V4vKuOWwW99b8Z7X43HuE0eLQ1L2MFmuP3GW3WHr9IpPF3C9TmS0WbHzEaHFjronF
	8lM7WCw2fvWwaLlj6sDvsWbeGkaPy9cuMnvsP1zk0bbA3mPTqk42j02fJrF73Lm2h81j85J6
	j74tqxg9Pm+SC+CK0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3J
	LEst0rdL0MtYvGk3S0ETV8W/43/YGhj3cHQxcnJICJhInNx0ggXEFhJYyijR/9MbIi4jcXJa
	AyuELSzx51oXWxcjF1DNJ0aJAydfMoEk2AQMJbregiQ4OUQEqiT+NKxmAiliFtjALHHh3Hb2
	LkYODmEBG4m1PWEgNSwCqhKz13wEq+cVsJNovrCKEWKBvMT+g2eZIeKCEidnPgE7iBko3rx1
	NvMERr5ZSFKzkKQWMDKtYhRJLS3OTc8tNtQrTswtLs1L10vOz93ECIysbcd+bt7BOO/VR71D
	jEwcjIcYJTiYlUR46xQ/pgrxpiRWVqUW5ccXleakFh9iNAW6byKzlGhyPjC280riDc0MTA1N
	zCwNTC3NjJXEeT0LOhKFBNITS1KzU1MLUotg+pg4OKUamFw/7E4v/uWZdV5549zwmvN8lR33
	S+52fEn7ZP1bZ4l00qZn3f9za94Xf56jcqr7/KyMsPBZFoceStyo7VjsttjnfEPK3EO9yxI1
	zoi4nG6VCVVezMOcfPbmwRN+wv8ydx98b/Uj4NKlyMtz4j5zr4sWvP9X/aqdTOaBMn1h4W99
	v2Mt/qdo/bz9Im7j4eZz0vEnfBM7BWXavvAcdDa873uJ929W4tbE31+3bJK5sfvA0aKX4RuN
	H+2q3STGIxTDbe35VUw62CCi+ymHuAaDuW1ym3YuwyZjlboL250ez/PoyHP0uyX7m8l2NtvN
	r1aN86LNV3dKpe+1jNfQe81o7juFaS4nX0tZzMUPRdtXKrEUZyQaajEXFScCAG0BSGY1AwAA
X-CMS-MailID: 20240314125628eucas1p161af377a50fd957f445397bc1404978b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240314125628eucas1p161af377a50fd957f445397bc1404978b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240314125628eucas1p161af377a50fd957f445397bc1404978b
References: <CGME20240314125628eucas1p161af377a50fd957f445397bc1404978b@eucas1p1.samsung.com>

Commit 0499a78369ad ("ARM64: Dynamically allocate cpumasks and increase
supported CPUs to 512") changed the handling of cpumasks on ARM 64bit,
what resulted in the strange issues and warnings during cpufreq-dt
initialization on some big.LITTLE platforms.

This was caused by mixing OPPs between big and LITTLE cores, because
OPP-sharing information between big and LITTLE cores is computed on
cpumask, which in turn was not zeroed on allocation. Fix this by
switching to zalloc_cpumask_var() call.

Fixes: dc279ac6e5b4 ("cpufreq: dt: Refactor initialization to handle probe deferral properly")
CC: stable@vger.kernel.org # v5.10+
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/cpufreq/cpufreq-dt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 8bd6e5e8f121..2d83bbc65dd0 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -208,7 +208,7 @@ static int dt_cpufreq_early_init(struct device *dev, int cpu)
 	if (!priv)
 		return -ENOMEM;
 
-	if (!alloc_cpumask_var(&priv->cpus, GFP_KERNEL))
+	if (!zalloc_cpumask_var(&priv->cpus, GFP_KERNEL))
 		return -ENOMEM;
 
 	cpumask_set_cpu(cpu, priv->cpus);
-- 
2.34.1



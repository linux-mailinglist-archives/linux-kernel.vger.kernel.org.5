Return-Path: <linux-kernel+bounces-158147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA39C8B1C29
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 477A51F25271
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 07:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82266DD0D;
	Thu, 25 Apr 2024 07:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="ORNWl1Z0"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615E04205D
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 07:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714031377; cv=none; b=DhJq96gtFPwecY+6mGV9JvGmGAGRN5vqJR6VvoOthB7U8FuCeRKErXWYDeZBiqR2/fWNLCu8hHaQc+35qy+rA2bgTK5W213UeWsY+esFKSWEM/gucNpzYQxnrJRDj8G4rHm9rswdmEgoKkZcJVyrgcfl0TU6jqZh3fFJqYSE8bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714031377; c=relaxed/simple;
	bh=wXslftyAHbp0WFus9DwxbwCpcoU4H9kJT4sdc9kuFO4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sn+lwQyAxlmrXuOgYgI2dtHFaEVJqvbloUFsuhOhxS2rh5RwVwdJUp/7LZy210zGnRMf3HzL7vDAKhm4FEkCCLJWsVtA2+23f1vsaYGQ2ay0hY9kdQgFoYAicvwBnFuMfsQhVhf+vyf4z0FBfoPNsKFpsXDtIgVS8KSP7nvp6MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=ORNWl1Z0; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43P7j7Oa021437;
	Thu, 25 Apr 2024 09:49:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=9YeaHLmicVOdp2NeKB/6HJ2XK6JQdpKzOtj7T+m86tc=; b=OR
	NWl1Z046LC+8xqoipeUuw+iE+XQdOCihVMxjQ/eKdsXX3Muv2PvkqllFNeRuLQQy
	RX7/GuF10B/iGhxX+oagQWl6PdZDpyWJKUAg1Db274UL4Zz0Fhk/sKnbc+lH6gvh
	CFEmO+2nnCkd6qVq/tRzNe0XGhtSKtN3Q8316hAFL7SBnHFXT1NNVByBG3nYDZcR
	IePZWE6D/7lkJDFsuTUXGq74t+6gG5jL7Dxt1NMljwze549+dm2x+RCtB7L/BY23
	ShCQOusLavsyCA4nYVgSlo46KWfHJffk1WYFdLmfIoz9gM08NHFt+olhUClgzICE
	jf+NpbgHCUb4PWNQDxdA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xm51wcpdb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 09:49:22 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 853F640044;
	Thu, 25 Apr 2024 09:49:18 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 20777212FDC;
	Thu, 25 Apr 2024 09:48:54 +0200 (CEST)
Received: from localhost (10.48.86.112) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 25 Apr
 2024 09:48:53 +0200
From: Patrick Delaunay <patrick.delaunay@foss.st.com>
To: Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>
CC: Patrick Delaunay <patrick.delaunay@foss.st.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH 2/3] regulator: stm32-pwr: add support of correct compatible
Date: Thu, 25 Apr 2024 09:48:33 +0200
Message-ID: <20240425094829.2.I04ec53442753147c35efad1307b6ec133f53b471@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240425074835.760134-1-patrick.delaunay@foss.st.com>
References: <20240425074835.760134-1-patrick.delaunay@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_06,2024-04-25_01,2023-05-22_02

Remove the unexpected comma in the compatible "st,stm32mp1,pwr-reg",
and support the new compatible "st,stm32mp1-pwr-reg".
The old compatible is keept for compatibility with old device trees.

Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
---

 drivers/regulator/stm32-pwr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/stm32-pwr.c b/drivers/regulator/stm32-pwr.c
index 85b0102fb9b1..f6a761167726 100644
--- a/drivers/regulator/stm32-pwr.c
+++ b/drivers/regulator/stm32-pwr.c
@@ -165,6 +165,7 @@ static int stm32_pwr_regulator_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id __maybe_unused stm32_pwr_of_match[] = {
+	{ .compatible = "st,stm32mp1-pwr-reg", },
 	{ .compatible = "st,stm32mp1,pwr-reg", },
 	{},
 };
-- 
2.25.1



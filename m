Return-Path: <linux-kernel+bounces-52318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E89D68496AF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61D9AB24AD4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C395118030;
	Mon,  5 Feb 2024 09:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="ELAybzml"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A2F17582;
	Mon,  5 Feb 2024 09:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707125681; cv=none; b=GtQuPqx+YEkRrH4JOsWCaWY7ht8ndhY2IPle8qu88nvl3v5tAUmtX3OCWolToj+bNMd8QAr90lOpT+5plvPqtvlPWUU0CgO/hZSIGjtO01bo5XSnUQSR8spEEJlxEPwqXQFIcn6OjtczRFncd8bWARQp9S5WU+pJgGwyjZ/Gkp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707125681; c=relaxed/simple;
	bh=3oGCy5voRlN85Whw6ttPtaf7dpukqP5pCVoAcNGsgCY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=qMz2ll8qro5HoTF32Z6+liPkwcR7XQbY7rbpdczkTMvNSoi0ysEISdhBRy3hdQRlTLAsIDUNMguaCBcfpwB6x2xWlbtxzszBsJ2HhlEa9NWB9PlRXDo1+P/u/4YfOs6MJ/YH1mqRBB1MSlA45jX6577KCQz8GhgsGwEIxfUgWqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=ELAybzml; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4158Jfau017463;
	Mon, 5 Feb 2024 10:34:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=selector1; bh=yRD+45wPol9C5Oo/j6x0XsNhrnxr5qZGHo18uofpfm4
	=; b=ELAybzmlTlHzCV4JWfGPhoA6fEeBBz5dIQ2Qzty0alFer7RAu2+HQvN9K4T
	DeD5EAOGeCHcAeCSM10LwE8F610ihmtaGFKqHj6ETrmNJpbiVPwBGmJyqqii04kn
	AklFnqOKgJtQg8n3opcJ0xLRD9AkK+71IMztqcA/kMmUVaOKX7FBqIyDEIkB3Cln
	1AjFtO1yRGLn3oQ3e4LRQZtz8T1YzqoP/n3gp0+DYlQiwQ0DvcmsgbQ4LJj9ifAD
	LpcAC5Tmorl0I2Rkcqj2DP9rdC2j1Ya8kxLHo1HpESw9tHLXvT84mS8K05iUyBAF
	U7fVuw/1fGCxm4h6Zi12oIS00Pw==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3w1eyp656b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 10:34:18 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4D7F810003B;
	Mon,  5 Feb 2024 10:34:17 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 425C72AC0F0;
	Mon,  5 Feb 2024 10:34:17 +0100 (CET)
Received: from localhost (10.252.18.216) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 5 Feb
 2024 10:34:14 +0100
From: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Date: Mon, 5 Feb 2024 10:26:50 +0100
Subject: [PATCH 5/5] drm/panel: simple: push blanking limit on RK32FN48H
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240205-ltdc_mp13-v1-5-116d43ebba75@foss.st.com>
References: <20240205-ltdc_mp13-v1-0-116d43ebba75@foss.st.com>
In-Reply-To: <20240205-ltdc_mp13-v1-0-116d43ebba75@foss.st.com>
To: Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard
	<mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie
	<airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
CC: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        Raphael Gallais-Pou
	<raphael.gallais-pou@foss.st.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_04,2024-01-31_01,2023-05-22_02

Push horizontal front porch and vertical back porch blanking limit.
This allows to get a 60 fps sharp.

Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 7b286382ffb4..10b361d603be 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -3516,10 +3516,10 @@ static const struct display_timing rocktech_rk043fn48h_timing = {
 	.pixelclock = { 6000000, 9000000, 12000000 },
 	.hactive = { 480, 480, 480 },
 	.hback_porch = { 8, 43, 43 },
-	.hfront_porch = { 2, 8, 8 },
+	.hfront_porch = { 2, 8, 10 },
 	.hsync_len = { 1, 1, 1 },
 	.vactive = { 272, 272, 272 },
-	.vback_porch = { 2, 12, 12 },
+	.vback_porch = { 2, 12, 26 },
 	.vfront_porch = { 1, 4, 4 },
 	.vsync_len = { 1, 10, 10 },
 	.flags = DISPLAY_FLAGS_VSYNC_LOW | DISPLAY_FLAGS_HSYNC_LOW |

-- 
2.25.1



Return-Path: <linux-kernel+bounces-70555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC92859923
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 20:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 326871F2210F
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 19:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A8271B43;
	Sun, 18 Feb 2024 19:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="xjj7zlpc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="nIXIwEu7"
Received: from fallback22.i.mail.ru (fallback22.i.mail.ru [79.137.243.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9BD9442;
	Sun, 18 Feb 2024 19:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708285833; cv=none; b=FwYX7fG4Qd9PszxBeJQPpld6gE5zdYFC23QZ98m9IslBhHlpxmQTYZPjyj1baBFcfNk1TUu2oTNAG354S/Jsbs+Mb6MouJEYNXA306AFGTnKo4guyGKJg/3FLt3gpzjVEGPxWAOyPnuDv/2oY3GLDLcz4S+4Qh/N2xCjkiWw72s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708285833; c=relaxed/simple;
	bh=LwinS9JB95uEZLSjeTt+G4axyvv7nJVl1bqUuJsT8R8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AUcVQ8DuQXesfOXDumgSWAtJow9X+9HYOdOH3FXvvfhOv6JaKbNltoizUCUAarS60eGsMDag0R18yChkAJwc6coJPPYGmMyzW+9UVNE6b1qvvZxFbq0riO7U+x6lNWVmt3eXPijL0Vcjtyj0VFpMrPFqYgXOQ+tNOtRpC59+3v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com; spf=pass smtp.mailfrom=jiaxyga.com; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=xjj7zlpc; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=nIXIwEu7; arc=none smtp.client-ip=79.137.243.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jiaxyga.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com; s=mailru;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=4/wl3nPE9NLJe3dlrlIflnjznmzyaom44ksPbb06geE=;
	t=1708285830;x=1708375830; 
	b=xjj7zlpcZmQ8kEDX1qmhICN/dSFSBbIcQfl7IMoAfFQ+ZdQoQVGsLcXq3Xvjf99FeW+0xr78CAoPMJZ+SCWetILPCOZhsuEi846SnK+PXjTeztd7W/xM+iHwj2TJyTdpnOT7Vt+IwGPSNC3YQtim+OPdCjejXFt6Un7SGUcgMnY=;
Received: from [10.12.4.2] (port=35680 helo=smtp29.i.mail.ru)
	by fallback22.i.mail.ru with esmtp (envelope-from <danila@jiaxyga.com>)
	id 1rbnBD-00C5Vm-Oe; Sun, 18 Feb 2024 22:50:28 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
	; s=mailru; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=4/wl3nPE9NLJe3dlrlIflnjznmzyaom44ksPbb06geE=; t=1708285827; x=1708375827; 
	b=nIXIwEu7YLN0kB3XiylGvh3O7cyvFmbElr+l3kDE4Dvbgd63M1kfOGBULduxcgxAqhEKn0f9NhF
	C1KFEit9SY5yeNfQO6jth22KNaFiH3DrOLhdd8l6A75KjDVx6ztb5TH4CmQPIaMbyFntfkKSC+lMu
	MK+9vtX5SZCX+OE4MqY=;
Received: by smtp29.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
	id 1rbnAz-00000006hY1-275H; Sun, 18 Feb 2024 22:50:14 +0300
From: Danila Tikhonov <danila@jiaxyga.com>
To: robdclark@gmail.com,
	quic_abhinavk@quicinc.com,
	dmitry.baryshkov@linaro.org,
	sean@poorly.run,
	marijn.suijten@somainline.org,
	airlied@gmail.com,
	daniel@ffwll.ch,
	konrad.dybcio@linaro.org,
	johan+linaro@kernel.org,
	quic_bjorande@quicinc.com
Cc: linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Danila Tikhonov <danila@jiaxyga.com>
Subject: [RESEND PATCH v2 1/1] drm/msm/adreno: Add support for SM7150 SoC machine
Date: Sun, 18 Feb 2024 22:50:07 +0300
Message-ID: <20240218195007.89960-2-danila@jiaxyga.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240218195007.89960-1-danila@jiaxyga.com>
References: <20240218195007.89960-1-danila@jiaxyga.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD9001F8F2F6BAD2021BBD8C705D41124DC6159324E79CF6DC700894C459B0CD1B9C5E22C23F1BE03C07FBBE522E338CBBDA25AC2CB0B85F4D9C08A02FB1A177B0896BFE15B8ADB4371
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE793089AEA09EF102BEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637D8F5094E9BAC3E9F8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D89E8E22097183F6372652140B8C21926305C4F13DE3BC10D8CC7F00164DA146DAFE8445B8C89999728AA50765F79006377C70927E34808485389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC821E93C0F2A571C7BF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947CA5ED62E35AC703CCC0837EA9F3D197644AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C3C9F4304F34B30F1CBA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CF17B107DEF921CE791DD303D21008E298D5E8D9A59859A8B6B372FE9A2E580EFC725E5C173C3A84C3D13DC059A893E58D35872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-C1DE0DAB: 0D63561A33F958A5D4E08B9C32BD0D525002B1117B3ED6969918ED69EDCDA2E7C638DF663A625AFA823CB91A9FED034534781492E4B8EEADF12279BA039A6965C79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CFB5E2A74AD09625C955E57C695C7097EF810F039CA7F3B7C081E5A95D9CF27496E5D0AE1B9048421534E84B500378195F3327C800B57CF284DA80BD25FDB1A95A9D5BF67B070882F2457F7985AD47CF5C02C26D483E81D6BE72B480F99247062FEE42F474E8A1C6FD34D382445848F2F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2bioj3ZJ49a6yxuuUQixMPPYjew==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C7394981B81DDCAC1631E74704DE63E6493D46055460E003A26B2832A877D903728FDABB2C62728BC403A049225EC17F3711B6CF1A6F2E8989E84EC137BFB0221605B344978139F6FA5A77F05FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: 78E4E2B564C1792B
X-77F55803: 6242723A09DB00B4A77971E4CF73965D9E271BDE2CCB4C0C7AB8ED82C1DDBC5A049FFFDB7839CE9E8F5A60B08382AFE3848351DD467580E9312762F486F8102C39D320635B8870A2
X-7FA49CB5: 0D63561A33F958A5DBD39F8E793081EACE88A8A54B442D44FAF53675CA7907D98941B15DA834481FA18204E546F3947CB645AEB2D65EEA52117882F4460429724CE54428C33FAD30A8DF7F3B2552694AC26CFBAC0749D213D2E47CDBA5A9658378DA827A17800CE7EF2A066DDA19BA868941B15DA834481F9449624AB7ADAF3735872C767BF85DA227C277FBC8AE2E8B9323F30CF592B49A75ECD9A6C639B01B4E70A05D1297E1BBCB5012B2E24CD356
X-87b9d050: 1
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2bioj3ZJ49a6yxuu6I5dWVp/Zhw==
X-Mailru-MI: 8000000000000800
X-Mras: Ok

SM7150 has 5 power levels which correspond to 5 speed-bin values: 0,
128, 146, 167, 172. Speed-bin value is calulated as FMAX/4.8MHz round up
to zero decimal places.

Also a618 on SM7150 uses a615 zapfw. Add a squashed version (.mbn).

Add this as machine = "qcom,sm7150", because speed-bin values are
different from atoll (sc7180/sm7125).

Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
---
 drivers/gpu/drm/msm/adreno/adreno_device.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index 2ce7d7b1690d..b81f90fb4257 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -293,6 +293,27 @@ static const struct adreno_info gpulist[] = {
 			{ 157, 3 },
 			{ 127, 4 },
 		),
+	}, {
+		.machine = "qcom,sm7150",
+		.chip_ids = ADRENO_CHIP_IDS(0x06010800),
+		.family = ADRENO_6XX_GEN1,
+		.fw = {
+			[ADRENO_FW_SQE] = "a630_sqe.fw",
+			[ADRENO_FW_GMU] = "a630_gmu.bin",
+		},
+		.gmem = SZ_512K,
+		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT,
+		.init = a6xx_gpu_init,
+		.zapfw = "a615_zap.mbn",
+		.hwcg = a615_hwcg,
+		.speedbins = ADRENO_SPEEDBINS(
+			{ 0,   0 },
+			{ 128, 1 },
+			{ 146, 2 },
+			{ 167, 3 },
+			{ 172, 4 },
+		),
 	}, {
 		.chip_ids = ADRENO_CHIP_IDS(0x06010800),
 		.family = ADRENO_6XX_GEN1,
@@ -539,6 +560,7 @@ MODULE_FIRMWARE("qcom/a530_zap.b00");
 MODULE_FIRMWARE("qcom/a530_zap.b01");
 MODULE_FIRMWARE("qcom/a530_zap.b02");
 MODULE_FIRMWARE("qcom/a540_gpmu.fw2");
+MODULE_FIRMWARE("qcom/a615_zap.mbn");
 MODULE_FIRMWARE("qcom/a619_gmu.bin");
 MODULE_FIRMWARE("qcom/a630_sqe.fw");
 MODULE_FIRMWARE("qcom/a630_gmu.bin");
-- 
2.43.2



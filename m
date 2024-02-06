Return-Path: <linux-kernel+bounces-55479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4787184BD32
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AED81C20DD8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C2B1B95E;
	Tue,  6 Feb 2024 18:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U8YB1/Sb"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DF31B7FB
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 18:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707245037; cv=none; b=oV5m3LQI7QV085jfQzfkQhqPwRwcI9+OM0t0AmbYI7WFx9YEaW4gw6MB8DOJy40yi/az9cybdmLnIll8WSrmgdyaAmwFQxQbjYv3JzO/ALOQdrgxYetzzh+PNCIv1DWNoQKo8UIo+C2r27dwd/J/tr06WumRdns4UjbxeP7ovBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707245037; c=relaxed/simple;
	bh=7ZxBeTpI7rU3/jGQrGYsBGxNSFTwMdNCV6VkV77JbJc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hs7XXTlvg90AcMxfnbySc03+SOYPK2twuFYvfJ8uKg7EAcLGQhHX9umR3HlRZNIuEAd1OvWoWxxAcuGEFkxUp3If5rNpBd675679eCml2GLrDwpSlnD72lNCCQrxB3r1OQsrVV6wO3YOaIOKYXOiX0SMD7a+5CchDdn94ZdlY+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U8YB1/Sb; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a30e445602cso197530966b.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 10:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707245034; x=1707849834; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6JFIAAu62FuQn/HSZ5tKqmYhrMc0VqNnJVz9VNDCrjM=;
        b=U8YB1/SbcajaNo6MtJJPaP7bx7DCjn0g02KnCGkLTRlmLFQHGLcWP2BRhMXZfH2Tnw
         TG66AM7XS9/oxglXwdq2uyM714U5w3OmMoGsO2938GynQeUBPFFdTjkybPy3yfO+s8Bs
         UbSXSAW/OFkO5cuUl6chYgoteaBmCFKFK7Oog5ik5w/OwZ5F5hl5pSMswmShMyuCFCqo
         mu9T/JJqvf2V/xd0FUCX4HmNTwE+nICu1YugobOn6RUiBremDZDh6oflwcprncmeHBBG
         QfVbtUGKY+csQe7jhEBiuwONOHoW7RHJKEs1Tz9gFHmo65Mf2s9YNNkSlu4MQvVhpMHH
         ZxpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707245034; x=1707849834;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6JFIAAu62FuQn/HSZ5tKqmYhrMc0VqNnJVz9VNDCrjM=;
        b=Ni7hGe2uHG4mgQj79bCSInhkVhn9DJSzd4RTlEdb3S4/VK8uIQoRelCSlzsE3wAIhP
         Um2Zhn1EneKKbUHjF5z8j3RIEWlhczVWoZD6XJmxCZJv6XCS7zVi3trmQxLDlQmnR5eA
         6NUdpRTNkPyP4fHsofRdmKjXUg5ManP6RWuzKZRbM6VwDw6+lDCq3Q4LjIk+Bt1aqAi4
         PcakDAHcXyPq02kWBZP+2TT864u7omtRiuVANx6pmNrIdHWE7KUbWn9NyCSvbhGXU3t1
         xOaS69XWFvzoBAAlXZbkBZh/DEwtNzfimEhLQxjAbTeDtVLY3d/Jtfmp/44B/G2Eltwk
         1nFw==
X-Gm-Message-State: AOJu0YxDEqCGXVPbACkhxVylLXxP5MBc3Vy7NAfL9S4iMIdEZFT3a/BB
	hqv75ZQjwW1neM5VsbzItg5NOcTy/cuhmGOz7ds5hAT2XU8vfJ8sIsRaedUHd+Q=
X-Google-Smtp-Source: AGHT+IFRnU7S9WuINV3NhaAKT2gjDWTwPGpFeNX4WG2QF1077VknapVFzp8zFOquS5VGWgaguqZCwg==
X-Received: by 2002:a17:906:3297:b0:a35:b59c:fc04 with SMTP id 23-20020a170906329700b00a35b59cfc04mr3562614ejw.25.1707245034391;
        Tue, 06 Feb 2024 10:43:54 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU3GW7DesvZfeZqzLXJ9bmcXbGuiNMy3LJq+VOD/cMGEPUlLtDY/ddOTJAliMHrcBDDAz2a6vd0Iij1ilRqUNdnK4nToxkPvOM2ID/b67mvZbZvKnSObM7cwpHAvnAUX2QwJ6AVvoV4q4PNRXNqD3ZAbpBWrCzoc9uhCY9uuzufzopIF7Pwri/sIspnjvVXd0Fmc2I0pfIgeYj0Jv22+T+oFO9p03oqvCLgpJ5LRLOIU+pvv15CuSAqna0R87VuBdR7R21jlXfGHAdbXEbeEfVh/9b61KoQjNHA33HhjYBkSXBPlZEMATZ7Nt+jSnD/V7vsH0sNLCBRLVVtlS3w9pdh6tJKLrEuEExVL4rftP3DQqIgdlP88q9AdPoxmSX6pB5FcF3jdCRRHSh8kAx4+MHEWn93+DiQKqI5NbFn9FUHGTMWPlIDHtQQ6Cq4BQwik+5GlUJRVcew
Received: from [10.167.154.1] (037008245233.garwolin.vectranet.pl. [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id un9-20020a170907cb8900b00a384365e3b9sm562305ejc.195.2024.02.06.10.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 10:43:54 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Tue, 06 Feb 2024 19:43:43 +0100
Subject: [PATCH v2 10/18] clk: qcom: gcc-sm8350: Set delay for Venus CLK
 resets
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240105-topic-venus_reset-v2-10-c37eba13b5ce@linaro.org>
References: <20240105-topic-venus_reset-v2-0-c37eba13b5ce@linaro.org>
In-Reply-To: <20240105-topic-venus_reset-v2-0-c37eba13b5ce@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Dikshita Agarwal <quic_dikshita@quicinc.com>, 
 Vikash Garodia <quic_vgarodia@quicinc.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707245017; l=1113;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=7ZxBeTpI7rU3/jGQrGYsBGxNSFTwMdNCV6VkV77JbJc=;
 b=IjZM3jN5XHZrj5wc5iXTiZuKe8lstZqNruPJ13n3kYfjb61cQtY0BWSyA+c4+SNxU5Z59zsEl
 FFlmLMVgijVBk9qV7fgkaVVVDBpl/9tfRtod4o1RKlRwx1jwkHM0HHx
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Some Venus resets may require more time when toggling. Describe that.

The value is known for SM8350, see [1].

[1] https://git.codelinaro.org/clo/la/platform/vendor/opensource/video-driver/-/commit/dfe241edf23daf3c1ccbb79b02798965123fad98
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/gcc-sm8350.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sm8350.c b/drivers/clk/qcom/gcc-sm8350.c
index 1385a98eb3bb..df4842588a24 100644
--- a/drivers/clk/qcom/gcc-sm8350.c
+++ b/drivers/clk/qcom/gcc-sm8350.c
@@ -3743,8 +3743,8 @@ static const struct qcom_reset_map gcc_sm8350_resets[] = {
 	[GCC_USB3PHY_PHY_PRIM_BCR] = { 0x50004 },
 	[GCC_USB3PHY_PHY_SEC_BCR] = { 0x50010 },
 	[GCC_USB_PHY_CFG_AHB2PHY_BCR] = { 0x6a000 },
-	[GCC_VIDEO_AXI0_CLK_ARES] = { 0x28010, 2 },
-	[GCC_VIDEO_AXI1_CLK_ARES] = { 0x28018, 2 },
+	[GCC_VIDEO_AXI0_CLK_ARES] = { .reg = 0x28010, .bit = 2, .udelay = 400 },
+	[GCC_VIDEO_AXI1_CLK_ARES] = { .reg = 0x28018, .bit = 2, .udelay = 400 },
 	[GCC_VIDEO_BCR] = { 0x28000 },
 };
 

-- 
2.43.0



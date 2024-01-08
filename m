Return-Path: <linux-kernel+bounces-19532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23925826E6F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B67F61F22D5B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20215479F;
	Mon,  8 Jan 2024 12:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fLBEcKd7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F19B54669
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 12:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a28b2e1a13fso172276866b.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 04:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704717168; x=1705321968; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5z5yUvqcicNviZoQ1keoobP6j7WXXaRy5LaqfnUo/lw=;
        b=fLBEcKd7Fq7C0IKeAxplyYrLyzgPj2NU+MTyaWm/02rMr4HWV9EfvzkQ5QqzsljemL
         PHm5psUcByiWJ5rUbFgtrDUf9OwXDzuFIlBdTZtdsVfur+wB585qDMoe1MXcBWIdLPNa
         QkiCszoWq+go6CeiGLUIGOfJEk8DasnuifTca+EfsD+xiBdGP13NxuBqSVXmteMIlV31
         SzROCM3OrGQ7l7jHGSYP+xsMphc315li9qhp9QjQeXtI5C2lkrKFDUQWgGB1Rr7tAp1E
         mDIE6+LDjcxAF4cmzN7ty3qCcHsPZPzv6hbS5s+3Z3XJxz49/KFbfaSKG9e8qH7H9Vwf
         BFQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704717168; x=1705321968;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5z5yUvqcicNviZoQ1keoobP6j7WXXaRy5LaqfnUo/lw=;
        b=BXQ2c7FBRSLaHRMX4g24Uk+X5b802GPzywfUtjSQf0sLryYe4ogLZbTjttHjbhGSKG
         S71vlexYUO+ijVmRLNbZnkqBkApgNntMfjnj7xza+w6NCPbmaMY8TiJ6onztkZ+pRdk9
         u/XEElQSxyW565TWMk46HUxph9LAs38vvpMU0RFpx7REIPv9o2WIPZkzCjt99YXBMpEn
         Q7UUuVnyq1INv+rYE9NV+Sg1NBOZifP44GxSu3UWZec0rVDF5uvwzsxcQhht6ALFzWGi
         GN36x886JKwKXh3dXMqsQXBArqb5urWWzgfL71/L1aNBXpHp3cwjtNfFQi90qSbsL6ft
         PcsQ==
X-Gm-Message-State: AOJu0YyrZiOrhc4WIeEBvvcOFmNUW1q4jP7sLc7wuilPBddTmY8zC6Xk
	tE8ad5/b28m2J+1S//AFuVSJUtm/qMzFCBiFSAkXHaMbHRs=
X-Google-Smtp-Source: AGHT+IGqGzfdWQ3/JX7GDAKAVjEGLM9iF1MJEeYZ4anKHrA1z+inEBSsZBDL39DIgJUMlRq0y1HVrg==
X-Received: by 2002:a17:906:51c2:b0:a28:fb5:4389 with SMTP id v2-20020a17090651c200b00a280fb54389mr1477784ejk.0.1704717168568;
        Mon, 08 Jan 2024 04:32:48 -0800 (PST)
Received: from [10.167.154.1] (178235179081.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.81])
        by smtp.gmail.com with ESMTPSA id bs18-20020a170906d1d200b00a2808ee8ab1sm3892978ejb.150.2024.01.08.04.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 04:32:48 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Mon, 08 Jan 2024 13:32:27 +0100
Subject: [PATCH 10/18] clk: qcom: gcc-sm8350: Set delay for Venus CLK
 resets
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240105-topic-venus_reset-v1-10-981c7a624855@linaro.org>
References: <20240105-topic-venus_reset-v1-0-981c7a624855@linaro.org>
In-Reply-To: <20240105-topic-venus_reset-v1-0-981c7a624855@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Dikshita Agarwal <quic_dikshita@quicinc.com>, 
 Vikash Garodia <quic_vgarodia@quicinc.com>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704717148; l=941;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=OLPxtvXqfSyhCTWcq+01XHn2DaYTX7g8uZCGKb6FcxQ=;
 b=6TL92acn8ty2HTUqvb61CLEe8msKXhlTDJUT1kf+Uz4x2+Im+mdbxiGKI++huH/CS3MYX3Wvw
 wKdKTkNJxbaCXwScNGqE9rqj1mJ0hVcWk005hsHdGlFe1lS/+kAP2Ku
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Some Venus resets may require more time when toggling. Describe that.

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


